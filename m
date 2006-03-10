Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWCJAgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWCJAgA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWCJAf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:35:59 -0500
Received: from mx.pathscale.com ([64.160.42.68]:13966 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752161AbWCJAfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:35:52 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 9 of 20] ipath - char devices for diagnostics and lightweight
	subnet management
X-Mercurial-Node: 28bb276205de498d0b5c7e5deb6fc0b39fe4c33a
Message-Id: <28bb276205de498d0b5c.1141950939@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1141950930@eng-12.pathscale.com>
Date: Thu,  9 Mar 2006 16:35:39 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ipath_diag.c file permits userspace diagnostic tools to read and
write a chip's registers.  It is different in purpose from the mmap
interfaces to the /sys/bus/pci resource files.

The ipath_sma.c file supports a lightweight userspace subnet management
agent (SMA).  This is used in deployments (such as HPC clusters) where
a full Infiniband protocol stack is not needed.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 1123028ac13a -r 28bb276205de drivers/infiniband/hw/ipath/ipath_diag.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_diag.c	Thu Mar  9 16:16:04 2006 -0800
@@ -0,0 +1,377 @@
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+/*
+ * This file contains support for diagnostic functions.  It is accessed by
+ * opening the ipath_diag device, normally minor number 129.  Diagnostic use
+ * of the InfiniPath chip may render the chip or board unusable until the
+ * driver is unloaded, or in some cases, until the system is rebooted.
+ *
+ * Accesses to the chip through this interface are not similar to going
+ * through the /sys/bus/pci resource mmap interface.
+ */
+
+#include <linux/pci.h>
+#include <linux/version.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+#include "ipath_common.h"
+#include "ipath_kernel.h"
+#include "ips_common.h"
+#include "ipath_layer.h"
+
+__kernel_pid_t ipath_diag_alive;	/* PID of diags, if running */
+static int diag_set_link;
+
+static int ipath_diag_open(struct inode *in, struct file *fp);
+static int ipath_diag_release(struct inode *in, struct file *fp);
+static ssize_t ipath_diag_read(struct file *fp, char __user *data,
+			       size_t count, loff_t *off);
+static ssize_t ipath_diag_write(struct file *fp, const char __user *data,
+				size_t count, loff_t *off);
+
+static struct file_operations diag_file_ops = {
+	.owner = THIS_MODULE,
+	.write = ipath_diag_write,
+	.read = ipath_diag_read,
+	.open = ipath_diag_open,
+	.release = ipath_diag_release
+};
+
+static struct cdev *diag_cdev;
+static struct class_device *diag_class_dev;
+
+int ipath_diag_init(void)
+{
+	return ipath_cdev_init(IPATH_DIAG_MINOR, "ipath_diag",
+			       &diag_file_ops, &diag_cdev, &diag_class_dev);
+}
+
+void ipath_diag_cleanup(void)
+{
+	ipath_cdev_cleanup(&diag_cdev, &diag_class_dev);
+}
+
+/**
+ * ipath_read_umem64 - read a 64-bit quantity from the chip into user space
+ * @dd: the infinipath device
+ * @uaddr: the location to store the data in user memory
+ * @caddr: the source chip address (full pointer, not offset)
+ * @count: number of bytes to copy (multiple of 32 bits)
+ *
+ * This function also localizes all chip memory accesses.
+ * The copy should be written such that we read full cacheline packets
+ * from the chip.  This is usually used for a single qword
+ *
+ * NOTE:  This assumes the chip address is 64-bit aligned.
+ */
+static int ipath_read_umem64(struct ipath_devdata *dd, void __user *uaddr,
+			     const void __iomem *caddr, size_t count)
+{
+	const u64 __iomem *reg_addr = caddr;
+	const u64 __iomem *reg_end = reg_addr + (count / sizeof(u64));
+	int ret;
+
+	/* not very efficient, but it works for now */
+	if (reg_addr < dd->ipath_kregbase ||
+	    reg_end > dd->ipath_kregend) {
+		ret = -EINVAL;
+		goto bail;
+	}
+	while (reg_addr < reg_end) {
+		u64 data = readq(reg_addr);
+		if (copy_to_user(uaddr, &data, sizeof(u64))) {
+			ret = -EFAULT;
+			goto bail;
+		}
+		reg_addr++;
+		uaddr++;
+	}
+	ret = 0;
+bail:
+	return ret;
+}
+
+/**
+ * ipath_write_umem64 - write a 64-bit quantity to the chip from user space
+ * @dd: the infinipath device
+ * @caddr: the destination chip address (full pointer, not offset)
+ * @uaddr: the source of the data in user memory
+ * @count: the number of bytes to copy (multiple of 32 bits)
+ *
+ * This is usually used for a single qword
+ * NOTE:  This assumes the chip address is 64-bit aligned.
+ */
+
+static int ipath_write_umem64(struct ipath_devdata *dd, void __iomem *caddr,
+			      const void __user *uaddr, size_t count)
+{
+	u64 __iomem *reg_addr = caddr;
+	const u64 __iomem *reg_end = reg_addr + (count / sizeof(u64));
+	int ret;
+
+	/* not very efficient, but it works for now */
+	if (reg_addr < dd->ipath_kregbase ||
+	    reg_end > dd->ipath_kregend) {
+		ret = -EINVAL;
+		goto bail;
+	}
+	while (reg_addr < reg_end) {
+		u64 data;
+		if (copy_from_user(&data, uaddr, sizeof(data))) {
+			ret = -EFAULT;
+			goto bail;
+		}
+		writeq(data, reg_addr);
+
+		reg_addr++;
+		uaddr++;
+	}
+	ret = 0;
+bail:
+	return ret;
+}
+
+/**
+ * ipath_read_umem32 - read a 32-bit quantity from the chip into user space
+ * @dd: the infinipath device
+ * @uaddr: the location to store the data in user memory
+ * @caddr: the source chip address (full pointer, not offset)
+ * @count: number of bytes to copy
+ *
+ * read 32 bit values, not 64 bit; for memories that only
+ * support 32 bit reads; usually a single dword.
+ */
+static int ipath_read_umem32(struct ipath_devdata *dd, void __user *uaddr,
+			     const void __iomem *caddr, size_t count)
+{
+	const u32 __iomem *reg_addr = caddr;
+	const u32 __iomem *reg_end = reg_addr + (count / sizeof(u32));
+	int ret;
+
+	if (reg_addr < (u32 __iomem *) dd->ipath_kregbase ||
+	    reg_end > (u32 __iomem *) dd->ipath_kregend) {
+		ret = -EINVAL;
+		goto bail;
+	}
+	/* not very efficient, but it works for now */
+	while (reg_addr < reg_end) {
+		u32 data = readl(reg_addr);
+		if (copy_to_user(uaddr, &data, sizeof(data))) {
+			ret = -EFAULT;
+			goto bail;
+		}
+
+		reg_addr++;
+		uaddr++;
+	}
+	ret = 0;
+bail:
+	return ret;
+}
+
+/**
+ * ipath_write_umem32 - write a 32-bit quantity to the chip from user space
+ * @dd: the infinipath device
+ * @caddr: the destination chip address (full pointer, not offset)
+ * @uaddr: the source of the data in user memory
+ * @count: number of bytes to copy
+ *
+ * write 32 bit values, not 64 bit; for memories that only
+ * support 32 bit write; usually a single dword.
+ */
+
+static int ipath_write_umem32(struct ipath_devdata *dd, void __iomem *caddr,
+			      const void __user *uaddr, size_t count)
+{
+	u32 __iomem *reg_addr = caddr;
+	const u32 __iomem *reg_end = reg_addr + (count / sizeof(u32));
+	int ret;
+
+	if (reg_addr < (u32 __iomem *) dd->ipath_kregbase ||
+	    reg_end > (u32 __iomem *) dd->ipath_kregend) {
+		ret = -EINVAL;
+		return ret;
+	}
+	while (reg_addr < reg_end) {
+		u32 data;
+		if (copy_from_user(&data, uaddr, sizeof(data))) {
+			ret = -EFAULT;
+			goto bail;
+		}
+		writel(data, reg_addr);
+
+		reg_addr++;
+		uaddr++;
+	}
+	ret = 0;
+bail:
+	return ret;
+}
+
+static int ipath_diag_open(struct inode *in, struct file *fp)
+{
+	int i, ret;
+
+	if (ipath_diag_alive) {
+		ipath_dbg("Diags already running (pid %u), failing\n",
+			  ipath_diag_alive);
+		ret = -EBUSY;
+		goto bail;
+	}
+
+	for (i = 0; i < atomic_read(&ipath_max); i++) {
+		struct ipath_devdata *dd = ipath_lookup(i);
+
+		if (!dd || !(dd->ipath_flags & IPATH_PRESENT) ||
+		    !dd->ipath_kregbase)
+			continue;
+
+		/*
+		 * we need at least one infinipath device to be
+		 * present (don't use INITTED, because we want to be
+		 * able to open even if device is in freeze mode,
+		 * which cleared INITTED).  There is s small amount of
+		 * risk to this, which is why we also verify kregbase
+		 * is set.
+		 */
+
+		ipath_diag_alive = current->pid;
+		diag_set_link = 0;
+		ipath_dbg("diag device now open, active as PID %u\n",
+			  ipath_diag_alive);
+
+		/* Only expose a way to reset the device if we
+		   make it into diag mode. */
+		ipath_expose_reset(&dd->pcidev->dev);
+
+		ret = 0;
+		goto bail;
+	}
+
+	ipath_dbg("No hardware yet found and initted, failing diags\n");
+	ret = -ENODEV;
+
+bail:
+	return ret;
+}
+
+static int ipath_diag_release(struct inode *i, struct file *f)
+{
+	ipath_diag_alive = 0;
+	ipath_dbg("Closing DIAG device\n");
+	return 0;
+}
+
+static ssize_t ipath_diag_read(struct file *fp, char __user *data,
+			       size_t count, loff_t *off)
+{
+	int unit = 0; /* XXX this is bogus */
+	struct ipath_devdata *dd;
+	void __iomem *kreg_base;
+	ssize_t ret;
+
+	dd = ipath_lookup(unit);
+	if (!dd) {
+		ret = -ENODEV;
+		goto bail;
+	}
+
+	kreg_base = dd->ipath_kregbase;
+
+	if (count == 0)
+		ret = 0;
+	else if ((count % 4) || (*off % 4))
+		/* address or length is not 32-bit aligned, hence invalid */
+		ret = -EINVAL;
+	else if ((count % 8) || (*off % 8))
+		/* address or length not 64-bit aligned; do 32-bit reads */
+		ret = ipath_read_umem32(dd, data, kreg_base + *off, count);
+	else
+		ret = ipath_read_umem64(dd, data, kreg_base + *off, count);
+
+	if (ret >= 0) {
+		*off += count;
+		ret = count;
+	}
+
+bail:
+	return ret;
+}
+
+static ssize_t ipath_diag_write(struct file *fp, const char __user *data,
+				size_t count, loff_t *off)
+{
+	int unit = 0; /* XXX this is bogus */
+	struct ipath_devdata *dd;
+	void __iomem *kreg_base;
+	ssize_t ret;
+
+	dd = ipath_lookup(unit);
+	if (!dd) {
+		ret = -ENODEV;
+		goto bail;
+	}
+	kreg_base = dd->ipath_kregbase;
+
+	if (count == 0)
+		ret = 0;
+	else if ((count % 4) || (*off % 4))
+		/* address or length is not 32-bit aligned, hence invalid */
+		ret = -EINVAL;
+	else if ((count % 8) || (*off % 8))
+		/* address or length not 64-bit aligned; do 32-bit writes */
+		ret = ipath_write_umem32(dd, kreg_base + *off, data, count);
+	else
+		ret = ipath_write_umem64(dd, kreg_base + *off, data, count);
+
+	if (ret >= 0) {
+		*off += count;
+		ret = count;
+	}
+
+bail:
+	return ret;
+}
+
+void ipath_diag_bringup_link(struct ipath_devdata *dd)
+{
+	if (diag_set_link || (dd->ipath_flags & IPATH_LINKACTIVE))
+		return;
+
+	diag_set_link = 1;
+	ipath_cdbg(VERBOSE, "Trying to set to set link active for "
+		   "diag pkt\n");
+	ipath_layer_set_linkstate(dd, IPATH_IB_LINKARM);
+	ipath_layer_set_linkstate(dd, IPATH_IB_LINKACTIVE);
+}
diff -r 1123028ac13a -r 28bb276205de drivers/infiniband/hw/ipath/ipath_sma.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_sma.c	Thu Mar  9 16:16:04 2006 -0800
@@ -0,0 +1,385 @@
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <linux/io.h>
+#include <linux/pci.h>
+#include <linux/cdev.h>
+#include <linux/vmalloc.h>
+#include <asm/uaccess.h>
+
+#include "ipath_kernel.h"
+#include "ips_common.h"
+#include "ipath_layer.h"
+
+/* PID of SMA, if it's running.  Atomic because it's accessed without
+ * a lock outside this file. */
+atomic_t ipath_sma_alive;
+DEFINE_SPINLOCK(ipath_sma_lock);	/* SMA receive */
+
+/* max SM received packets we'll queue; we keep the most recent packets. */
+
+struct _ipath_sma_rpkt ipath_sma_data[IPATH_NUM_SMA_PKTS];
+
+unsigned ipath_sma_first;	/* oldest sma packet index */
+unsigned ipath_sma_next;	/* next sma packet index to use */
+
+/*
+ * ipath_sma_data_bufs has one extra, pointed to by ipath_sma_data_spare,
+ * so we can exchange buffers to do copy_to_user, and not hold the lock
+ * across the copy_to_user().
+ */
+
+u8 ipath_sma_data_bufs[IPATH_NUM_SMA_PKTS + 1][IPATH_SMA_MAX_PKTSZ];
+u8 *ipath_sma_data_spare;
+/* sma waits globally on all units */
+wait_queue_head_t ipath_sma_wait;
+wait_queue_head_t ipath_sma_state_wait;
+
+static int ipath_sma_open(struct inode *in, struct file *fp);
+static int ipath_sma_release(struct inode *in, struct file *fp);
+static ssize_t ipath_sma_read(struct file *fp, char __user *data,
+			      size_t count, loff_t *off);
+static ssize_t ipath_sma_write(struct file *fp, const char __user *data,
+			       size_t count, loff_t *off);
+
+static struct file_operations sma_file_ops = {
+	.owner = THIS_MODULE,
+	.write = ipath_sma_write,
+	.read = ipath_sma_read,
+	.open = ipath_sma_open,
+	.release = ipath_sma_release
+};
+
+static struct cdev *sma_cdev;
+static struct class_device *sma_class_dev;
+
+int ipath_sma_init(void)
+{
+	return ipath_cdev_init(IPATH_SMA_MINOR, "ipath_sma", &sma_file_ops,
+			       &sma_cdev, &sma_class_dev);
+}
+
+void ipath_sma_cleanup(void)
+{
+	ipath_cdev_cleanup(&sma_cdev, &sma_class_dev);
+}
+
+static int ipath_sma_open(struct inode *in, struct file *fp)
+{
+	unsigned long flags;
+	__kernel_pid_t pid;
+	int s, ret;
+
+	spin_lock_irqsave(&ipath_sma_lock, flags);
+
+	pid = atomic_read(&ipath_sma_alive);
+	if (pid) {
+		ipath_dbg("SMA already running (pid %u), failing\n", pid);
+		ret = -EBUSY;
+		goto bail;
+	}
+
+	for (s = 0; s < atomic_read(&ipath_max); s++) {
+		struct ipath_devdata *dd = ipath_lookup(s);
+		/* we need at least one infinipath device to be initialized. */
+		if (dd && dd->ipath_flags & IPATH_INITTED) {
+			pid = current->pid;
+			*dd->ipath_statusp |= IPATH_STATUS_SMA;
+			*dd->ipath_statusp &= ~IPATH_STATUS_OIB_SMA;
+		}
+	}
+	if (pid) {
+		ipath_cdbg(SMA, "SMA device now open, SMA active as PID %u\n",
+			   pid);
+		atomic_set(&ipath_sma_alive, pid);
+		ret = 0;
+	} else {
+		ret = -ENODEV;
+		ipath_dbg("No hardware yet found and initted, failing\n");
+	}
+bail:
+	spin_unlock_irqrestore(&ipath_sma_lock, flags);
+	return ret;
+}
+
+static int ipath_sma_release(struct inode *in, struct file *fp)
+{
+	unsigned long flags;
+	int s;
+
+	spin_lock_irqsave(&ipath_sma_lock, flags);
+
+	atomic_set(&ipath_sma_alive, 0);
+	ipath_cdbg(SMA, "Closing SMA device\n");
+	for (s = 0; s < atomic_read(&ipath_max); s++) {
+		struct ipath_devdata *dd = ipath_lookup(s);
+
+		if (!dd || !(dd->ipath_flags & IPATH_INITTED))
+			continue;
+		*dd->ipath_statusp &= ~IPATH_STATUS_SMA;
+		if (dd->verbs_layer.l_flags & IPATH_VERBS_KERNEL_SMA)
+			*dd->ipath_statusp |= IPATH_STATUS_OIB_SMA;
+	}
+	spin_unlock_irqrestore(&ipath_sma_lock, flags);
+	return 0;
+}
+
+/**
+ * ipath_sma_read - receive an IB packet with QP 0 or 1
+ * @fp: the SMA device file pointer
+ * @data: ipath_sma_pkt structure saying where to place the SMA data
+ * @count: unused by this code
+ * @off: unused by this code
+ *
+ * This receives from all/any of the active chips, and we currently do not
+ * allow specifying just one (we could, by filling in unit in the library
+ * before the syscall, and checking here).
+ */
+static ssize_t ipath_sma_read(struct file *fp, char __user *data,
+			      size_t count, loff_t *off)
+{
+	struct _ipath_sma_rpkt *smpkt;
+	struct ipath_sma_pkt rp;
+	unsigned long flags;
+	ssize_t ret;
+	u32 rp_len;
+	int i, any;
+	u8 *sdata;
+	u32 slen;
+
+	if (copy_from_user(&rp, data, sizeof(rp))) {
+		ret = -EFAULT;
+		goto bail;
+	}
+
+	if (!ipath_sma_data_spare) {
+		ipath_dbg("can't do receive, sma not initialized\n");
+		ret = -ENETDOWN;
+		goto bail;
+	}
+
+	for (any = i = 0; i < atomic_read(&ipath_max); i++) {
+		struct ipath_devdata *dd = ipath_lookup(i);
+		if (dd && (dd->ipath_flags & IPATH_INITTED))
+			any++;
+	}
+
+	if (!any) {		/* no hardware, freeze, etc. */
+		ipath_cdbg(SMA, "Didn't find any initialized and usable chips\n");
+		ret = -ENODEV;
+		goto bail;
+	}
+
+	wait_event_interruptible(ipath_sma_wait,
+				 ipath_sma_data[ipath_sma_first].len);
+
+	spin_lock_irqsave(&ipath_sma_lock, flags);
+	if (ipath_sma_data[ipath_sma_first].len == 0) {
+		/* usually means SMA process received a signal */
+		spin_unlock_irqrestore(&ipath_sma_lock, flags);
+		ret = -EAGAIN;
+		goto bail;
+	}
+
+	smpkt = &ipath_sma_data[ipath_sma_first];
+
+	/*
+	 * we swap out the buffer we are going to use with the spare buffer
+	 * and set spare to that buffer.  This code is the only code that
+	 * ever manipulates spare, other than the initialization code.
+	 * This code should never be entered by more than one process at
+	 * a time, and if it is, the user  code doing so deserves what it gets;
+	 * it won't break anything in the driver by doing so.  We do it this
+	 * way to avoid holding a lock across the copy_to_user, which could
+	 * fault, or delay a long time while paging occurs; ditto for printks
+	 */
+
+	rp_len = rp.len;
+	rp.len = smpkt->len;
+	rp.unit = smpkt->unit;
+
+	slen = smpkt->len;
+	sdata = smpkt->buf;
+	smpkt->buf = ipath_sma_data_spare;
+	ipath_sma_data_spare = sdata;
+	smpkt->len = 0;	/* it's available again */
+	if (++ipath_sma_first >= IPATH_NUM_SMA_PKTS)
+		ipath_sma_first = 0;
+	spin_unlock_irqrestore(&ipath_sma_lock, flags);
+
+	if (copy_to_user((void __user *) (unsigned long) rp.data,
+			 sdata, min(rp_len, slen))) {
+		ret = -EFAULT;
+		goto bail;
+	}
+
+	if (copy_to_user(data, &rp, sizeof(rp))) {
+		ret = -EFAULT;
+		goto bail;
+	}
+
+	ret = sizeof(rp);
+bail:
+	return ret;
+}
+
+/**
+ * ipath_sma_write - receive an IB packet with QP 0 or 1
+ * @fp: the SMA device file pointer
+ * @data: ipath_sma_pkt structure saying where to get the SMA packet
+ * @count: size of data to write
+ * @off: unused by this code
+ *
+ * This routine is no longer on any critical paths; it is used only
+ * for sending SMA packets, and some diagnostic usage.
+ * Because it's currently sma only, there are no checks to see if the
+ * link is up; sma must be able to send in the not fully initialized state
+ */
+static ssize_t ipath_sma_write(struct file *fp, const char __user *data,
+			       size_t count, loff_t *off)
+{
+	u32 __iomem *piobuf;
+	u32 plen, clen, pbufn;
+	struct ipath_sma_pkt sp;
+	u32 *tmpbuf = NULL;
+	struct ipath_devdata *dd;
+	ssize_t ret = 0;
+	u64 val;
+
+	if (count < sizeof(sp)) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	if (copy_from_user(&sp, data, sizeof(sp))) {
+		ret = -EFAULT;
+		goto bail;
+	}
+
+	// send count must be an exact number of dwords
+	if (sp.len & 3) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	clen = sp.len >> 2;
+
+	dd = ipath_lookup(sp.unit);
+	if (!dd || !(dd->ipath_flags & IPATH_PRESENT) || !dd->ipath_kregbase) {
+		ipath_cdbg(SMA, "illegal unit %u for sma send\n", sp.unit);
+		ret = -ENODEV;
+		goto bail;
+	}
+
+	if (ipath_diag_alive)
+		ipath_diag_bringup_link(dd);
+
+	if (!(dd->ipath_flags & IPATH_INITTED)) {
+		/* no hardware, freeze, etc. */
+		ipath_cdbg(SMA, "unit %u not usable\n", dd->ipath_unit);
+		ret = -ENODEV;
+		goto bail;
+	}
+	val = dd->ipath_lastibcstat & IPATH_IBSTATE_MASK;
+	if (val != IPATH_IBSTATE_INIT && val != IPATH_IBSTATE_ARM &&
+	    val != IPATH_IBSTATE_ACTIVE) {
+		ipath_cdbg(SMA, "unit %u not ready (state %llx)\n",
+			   dd->ipath_unit, (unsigned long long) val);
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	/* need total length before first word written */
+	plen = sizeof(u32) + sp.len;	/* +1 word is for the qword padding */
+
+	if ((plen + 4) > dd->ipath_ibmaxlen) {
+		ipath_dbg("Pkt len 0x%x > ibmaxlen %x\n",
+			  plen - 4, dd->ipath_ibmaxlen);
+		ret = -EINVAL;
+		goto bail;	/* before writing pbc */
+	}
+	tmpbuf = vmalloc(plen);
+	if (!tmpbuf) {
+		dev_info(&dd->pcidev->dev, "Unable to allocate tmp buffer, "
+			 "failing\n");
+		ret = -ENOMEM;
+		goto bail;
+	}
+
+	if (copy_from_user(tmpbuf,
+			   (const void __user *) (unsigned long) sp.data,
+			   sp.len)) {
+		ret = -EFAULT;
+		goto bail;
+	}
+
+	piobuf = ipath_getpiobuf(dd, &pbufn);
+	if (!piobuf) {
+		ipath_cdbg(SMA, "No PIO buffers available unit %u %u times\n",
+			   dd->ipath_unit, dd->ipath_nosma_bufs);
+		dd->ipath_nosma_bufs++;
+		ret = -EBUSY;
+		goto bail;
+	}
+	if (dd->ipath_nosma_bufs) {
+		ipath_cdbg(SMA, "Unit %u got SMA send buffer after %u failures, %u seconds\n",
+			   dd->ipath_unit, dd->ipath_nosma_bufs,
+			   dd->ipath_nosma_secs);
+		dd->ipath_nosma_bufs = 0;
+		dd->ipath_nosma_secs = 0;
+	}
+
+	plen >>= 2;		/* in dwords */
+
+	if (ipath_debug & __IPATH_PKTDBG)	// SMA and PKT, both
+		ipath_cdbg(SMA, "unit %u 0x%x+1w pio%d\n",
+			   dd->ipath_unit, plen - 1, pbufn);
+
+	/* we have to flush after the PBC for correctness on some cpus
+	 * or WC buffer can be written out of order */
+	writeq(plen, piobuf);
+	ipath_flush_wc();
+	/* copy all by the trigger word, then flush, so it's written
+	 * to chip before trigger word, then write trigger word, then
+	 * flush again, so packet is sent. */
+	__iowrite32_copy(piobuf + 2, tmpbuf, clen - 1);
+	ipath_flush_wc();
+	__raw_writel(tmpbuf[clen - 1], piobuf + clen + 1);
+	ipath_flush_wc();
+	ipath_stats.sps_sma_spkts++;
+
+	ret = sizeof(sp);
+
+bail:
+	vfree(tmpbuf);
+	return ret;
+}
