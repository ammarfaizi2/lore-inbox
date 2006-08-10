Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWHKT0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWHKT0Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 15:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWHKT0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 15:26:24 -0400
Received: from mail04.hansenet.de ([213.191.73.12]:49355 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S932203AbWHKT0V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 15:26:21 -0400
X-Mailbox-Line: From d517e359ceb92de4b94751a3190788b99bcb8e95 Mon Sep 17 00:00:00 2001
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Date: Thu, 10 Aug 2006 23:18:04 +0200
Subject: [PATCH] Image capturing driver for Basler eXcite smart camera
Organization: Basler AG
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Ralf Baechle <ralf@linux-mips.org>,
       linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608102318.04512.thomas.koeller@baslerweb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a driver used for image capturing by the Basler eXcite smart camera
platform. It utilizes the integrated GPI DMA engine of the MIPS RM9122
processor. Since this driver does not fit into one of the existing categories
I created a new toplevel directory for it (which may not be appropriate?).

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
---
 drivers/Kconfig            |    2 
 drivers/Makefile           |    1 
 drivers/xicap/Kconfig      |   30 +
 drivers/xicap/Makefile     |    6 
 drivers/xicap/xicap_core.c |  483 ++++++++++++++++++
 drivers/xicap/xicap_gpi.c  | 1204 
++++++++++++++++++++++++++++++++++++++++++++
 drivers/xicap/xicap_priv.h |   47 ++
 include/xicap/xicap.h      |   40 +
 8 files changed, 1813 insertions(+), 0 deletions(-)

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 8b11ceb..5b4d329 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -74,4 +74,6 @@ source "drivers/rtc/Kconfig"
 
 source "drivers/dma/Kconfig"
 
+source "drivers/xicap/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index fc2d744..af1b1ee 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -76,3 +76,4 @@ obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
 obj-$(CONFIG_GENERIC_TIME)	+= clocksource/
 obj-$(CONFIG_DMA_ENGINE)	+= dma/
+obj-$(CONFIG_EXCITE_FCAP)	+= xicap/
diff --git a/drivers/xicap/Kconfig b/drivers/xicap/Kconfig
new file mode 100644
index 0000000..da17d82
--- /dev/null
+++ b/drivers/xicap/Kconfig
@@ -0,0 +1,30 @@
+#
+# eXcite frame capturing configuration
+#
+
+menu "eXcite frame capture support"
+	depends BASLER_EXCITE
+
+config EXCITE_FCAP
+	tristate "Frame capturing support for eXcite devices (EXPERIMENTAL)"
+	---help---
+	 Enable basic support for frame capture devices on the BASLER eXcite
+	 platform. You also have to select a hardware driver.
+	 
+	 This can also be compiled as a module, which will be named
+	 xicap_core.
+
+
+config EXCITE_FCAP_GPI
+	depends CPU_RM9000 && EXCITE_FCAP
+	tristate "Frame capturing using MIPS RM9K (EXPERIMENTAL)"
+	---help---
+	 This driver implememnts frame capturing support via the
+	 GPI device found on MIPS RM9K embedded processors manufactured
+	 by PMC-Sierra, Inc.
+	 
+	 This driver can be built as a module, which will be named
+	 xicap_gpi.
+
+endmenu
+
diff --git a/drivers/xicap/Makefile b/drivers/xicap/Makefile
new file mode 100644
index 0000000..12e1a3b
--- /dev/null
+++ b/drivers/xicap/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for Basler eXcite frame capturing drivers
+#
+
+obj-$(CONFIG_EXCITE_FCAP)	+= xicap_core.o
+obj-$(CONFIG_EXCITE_FCAP_GPI)	+= xicap_gpi.o
diff --git a/drivers/xicap/xicap_core.c b/drivers/xicap/xicap_core.c
new file mode 100644
index 0000000..a72f7b8
--- /dev/null
+++ b/drivers/xicap/xicap_core.c
@@ -0,0 +1,483 @@
+/*
+ *  Copyright (C) 2004, 2005 by Basler Vision Technologies AG
+ *  Author: Thomas Koeller <thomas.koeller@baslerweb.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/config.h>
+#include <linux/list.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/spinlock.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/wait.h>
+#include <linux/poll.h>
+#include <asm/bitops.h>
+#include <asm/atomic.h>
+#include <asm/uaccess.h>
+#include <asm/page.h>
+#include <xicap/xicap.h>
+
+#include "xicap_priv.h"
+
+
+
+/* Get device context from inode */
+#define cxi(__i__) container_of((__i__)->i_cdev, xicap_device_context_t, 
chardev)
+
+/* Get device context from file */
+#define cxf(__f__) ((xicap_device_context_t *) (__f__)->private_data)
+
+
+
+/* String constants */
+static const char xicap_name[] = "xicap";
+
+
+
+/* Data used for device number allocation */
+static dev_t devnum_base;
+static DECLARE_MUTEX(devnum_lock);
+static unsigned long devnum_bitmap = 0;
+
+#define MAX_DEVICES	(sizeof devnum_bitmap * 8)
+
+
+
+/* Function prototypes */
+static void xicap_device_release(struct class_device *);
+static long xicap_ioctl(struct file *, unsigned int, unsigned long);
+static unsigned int xicap_poll(struct file *, poll_table *);
+static ssize_t xicap_read(struct file *, char __user *, size_t, loff_t *);
+static int xicap_open(struct inode *, struct file *);
+static int xicap_release(struct inode *, struct file *);
+static int xicap_queue_buffer(xicap_device_context_t *,
+			      const xicap_arg_qbuf_t *);
+
+
+
+/* A class for xicap devices */
+static struct class xicap_class = {
+	.name		= (char *) xicap_name,
+	.release	= xicap_device_release,
+	.class_release	= NULL
+};
+
+
+
+/* The file operations vector */
+static struct file_operations xicap_fops = {
+	.unlocked_ioctl	= xicap_ioctl,
+	.read		= xicap_read,
+	.open		= xicap_open,
+	.release	= xicap_release,
+	.poll		= xicap_poll
+};
+
+
+
+struct xicap_devctxt {
+	struct class_device		classdev;
+	struct cdev			chardev;
+	const xicap_hw_driver_t *	hwdrv;
+	dev_t				devnum;
+	spinlock_t			compl_lock;
+	struct list_head		compl_queue;
+	atomic_t			opencnt;
+	wait_queue_head_t		wq;
+};
+
+
+
+/* A context for every class device */
+struct xicap_clsdev_ctxt {
+	xicap_hw_driver_t *	hwdrv;
+};
+
+
+
+/* Check for completed buffers */
+static inline int xicap_check_completed(xicap_device_context_t *dc)
+{
+	int r;
+	spin_lock(&dc->compl_lock);
+	r = !list_empty(&dc->compl_queue);
+	spin_unlock(&dc->compl_lock);
+	return r;
+}
+
+
+
+/* Retreive a completed buffer from the queue */
+static inline xicap_data_buffer_t *
+xicap_retreive_completed(xicap_device_context_t *dc)
+{
+	xicap_data_buffer_t * p;
+	spin_lock(&dc->compl_lock);
+	p = list_empty(&dc->compl_queue) ?
+		NULL : list_entry(dc->compl_queue.next, xicap_data_buffer_t,
+				  link);
+	if (p)
+		list_del(&p->link);
+	spin_unlock(&dc->compl_lock);
+	return p;
+}
+
+
+
+
+static long xicap_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	int res = -ENOTTY;
+	union {
+		xicap_arg_qbuf_t qbuf;
+	} a;
+
+
+	if (unlikely(_IOC_TYPE(cmd) != XICAP_IOC_TYPE))
+		return -ENOTTY;
+
+	if ((_IOC_DIR(cmd) & _IOC_READ)
+	    && !access_ok(VERIFY_WRITE, arg, _IOC_SIZE(cmd)))
+	 	return -EFAULT;
+
+	if ((_IOC_DIR(cmd) & _IOC_WRITE)
+	    && !access_ok(VERIFY_READ, arg, _IOC_SIZE(cmd)))
+	 	return -EFAULT;
+
+	switch (cmd) {
+		case XICAP_IOC_QBUF:
+			if (_IOC_SIZE(XICAP_IOC_QBUF) != sizeof a.qbuf) {
+				res = -EINVAL;
+				break;
+			}
+			res = __copy_from_user(&a.qbuf, (void *) arg,
+					       sizeof a.qbuf) ?
+				-EINVAL : xicap_queue_buffer(cxf(f), &a.qbuf);
+			break;
+
+		case XICAP_IOC_FLUSH:
+			{
+				xicap_device_context_t * const dc = cxf(f);
+				res = dc->hwdrv->flush ?
+				      dc->hwdrv->flush(dc->classdev.dev) :
+				      -ENOTTY;
+			}
+			break;
+	}
+
+	return res;
+}
+
+
+
+static unsigned int xicap_poll(struct file *f, poll_table *tbl)
+{
+	xicap_device_context_t * const dc = cxf(f);
+	poll_wait(f, &dc->wq, tbl);
+	return POLLOUT | POLLWRNORM
+	       | (xicap_check_completed(dc) ? POLLIN | POLLRDNORM : 0);
+}
+
+
+
+static ssize_t xicap_read(struct file *f, char __user *buf, size_t len,
+			  loff_t *offs)
+{
+	int res;
+	xicap_device_context_t * const dc = cxf(f);
+	xicap_data_buffer_t *bd;
+	xicap_result_t dat;
+
+	if (unlikely(len != sizeof dat))
+		return -EINVAL;
+
+	if (unlikely(!access_ok(VERIFY_WRITE, buf, len)))
+		return -EFAULT;
+
+	if (f->f_flags & O_NONBLOCK) {
+		/* If nonblocking and no completed ops, return error status */	
+		if (bd = xicap_retreive_completed(dc), !bd)
+			return -EAGAIN;
+	} else {
+		res = wait_event_interruptible(
+			dc->wq,
+			(bd = xicap_retreive_completed(dc), bd));
+		if (res)
+			return res;
+	}
+
+	if (dc->hwdrv->finish_buffer) {
+		const int i = dc->hwdrv->finish_buffer(dc->classdev.dev,
+						       bd->frmctxt);
+		if (i) {
+			kfree(bd);
+			return i;
+		}
+	}
+
+	dat.data = bd->uaddr;
+	dat.ctxt = bd->uctxt;
+	dat.status = bd->status;
+	__copy_to_user(buf, &dat, sizeof dat);
+	kfree(bd);
+
+	return sizeof dat;
+}
+
+
+
+static int xicap_open(struct inode *i, struct file *f)
+{
+	xicap_device_context_t * const dc = cxi(i);
+
+	/* Only one opener allowed */
+	if (atomic_dec_if_positive(&dc->opencnt) < 0)
+		return -EBUSY;
+
+	spin_lock_init(&dc->compl_lock);
+	INIT_LIST_HEAD(&dc->compl_queue);
+	init_waitqueue_head(&dc->wq);
+	f->private_data = cxi(i);
+	return dc->hwdrv->start(dc->classdev.dev);
+}
+
+
+
+static int xicap_release(struct inode *i, struct file *f)
+{
+	xicap_device_context_t * const dc = cxi(i);
+	dc->hwdrv->stop(dc->classdev.dev);
+	
+	while (xicap_check_completed(dc))
+		kfree(xicap_retreive_completed(dc));
+	
+	atomic_set(&dc->opencnt, 1);
+	return 0;
+}
+
+
+
+/* Device registration */
+xicap_device_context_t *
+xicap_device_register(struct device *dev, const xicap_hw_driver_t *hwdrv)
+{
+	int res = 0, devi = -1;
+
+	/* Set up a device context */
+	xicap_device_context_t * const dc =
+		(xicap_device_context_t *) kmalloc(sizeof *dc, GFP_KERNEL);
+	if (!dc) {
+		res = -ENOMEM;
+		goto ex;
+	}
+
+	memset(dc, 0, sizeof *dc);
+	cdev_init(&dc->chardev, &xicap_fops);
+	dc->chardev.owner = THIS_MODULE;
+	dc->classdev.dev = get_device(dev);
+	dc->hwdrv = hwdrv;
+	atomic_set(&dc->opencnt, 1);
+
+	/* Allocate a device number */
+	down(&devnum_lock);
+	if (unlikely(devnum_bitmap == ~0x0)) {
+		up(&devnum_lock);
+		res = -ENODEV;
+		goto ex;
+	}
+	devi = ffz(devnum_bitmap);
+	devnum_bitmap |= 0x1 << devi;
+	up(&devnum_lock);
+
+	/* Register the class device with its class */
+	dc->classdev.class = &xicap_class;
+	dc->classdev.devt = devi + devnum_base;
+	res = snprintf(dc->classdev.class_id, sizeof dc->classdev.class_id,
+		       "%s%u", xicap_name, devi)
+		< sizeof dc->classdev.class_id ? 0 : -ENAMETOOLONG;
+	if (!res)
+		res = class_device_register(&dc->classdev);
+	if (unlikely(res)) {
+		dc->classdev.class = NULL;
+		goto ex;
+	}
+	
+	/* Register the character device */
+	res = cdev_add(&dc->chardev, devi + devnum_base, 1);
+
+ex:
+	if (res) {
+		if (dc->classdev.class)
+			class_device_unregister(&dc->classdev);
+		if (devi >= 0) {
+			down(&devnum_lock);
+			devnum_bitmap &= ~(0x1 << devi);
+			up(&devnum_lock);
+		}
+		if (dc) {
+			put_device(dc->classdev.dev);
+			kfree(dc);
+		}
+	} else {
+		dc->devnum = devi + devnum_base;
+	}
+	
+	return res ? (xicap_device_context_t *) ERR_PTR(res) : dc;
+}
+
+
+
+/* Device unregistration */
+void xicap_device_unregister(xicap_device_context_t *dc)
+{
+	cdev_del(&dc->chardev);
+	class_device_unregister(&dc->classdev);
+	down(&devnum_lock);
+	devnum_base &= ~(0x1 << (dc->devnum - devnum_base));
+	up(&devnum_lock);
+}
+
+
+
+void xicap_frame_done(xicap_device_context_t *dc, xicap_data_buffer_t *bd)
+{
+	struct page **p;
+
+	for (p = bd->pages; p < bd->pages + bd->npages; p++)
+		page_cache_release(*p);
+
+	spin_lock(&dc->compl_lock);
+	list_add_tail(&bd->link, &dc->compl_queue);
+	spin_unlock(&dc->compl_lock);
+	wake_up_interruptible(&dc->wq);
+}
+
+
+
+static void xicap_device_release(struct class_device *cldev)
+{
+	xicap_device_context_t * const dc =
+		container_of(cldev, xicap_device_context_t, classdev);
+	put_device(dc->classdev.dev);
+	kfree(dc);
+}
+
+
+
+static int xicap_queue_buffer(xicap_device_context_t *dc,
+			      const xicap_arg_qbuf_t *arg)
+{
+	int res, npages;
+	xicap_data_buffer_t *bufdesc;
+
+	/* Check for buffer write permissions */
+	if (!access_ok(VERIFY_WRITE, arg->data, arg->size))
+		return -EFAULT;
+	
+	npages = (PAGE_ALIGN((unsigned long ) arg->data + arg->size)
+		 - ((unsigned long ) arg->data & PAGE_MASK)) >> PAGE_SHIFT;
+
+	bufdesc = (xicap_data_buffer_t *)
+		kmalloc(sizeof *bufdesc + sizeof (struct page *) * npages,
+			GFP_KERNEL);
+	if (!bufdesc)
+		return -ENOMEM;
+	
+	bufdesc->uctxt = arg->ctxt;
+	bufdesc->uaddr = arg->data;
+	bufdesc->size = arg->size;
+	bufdesc->npages = npages;
+
+	/* Get hold of the data buffer pages */
+	res = get_user_pages(current, current->mm, (unsigned long) arg->data,
+			     npages, 1, 0, bufdesc->pages, NULL);
+	if (res < 0) {
+		kfree(bufdesc);
+		return res;
+	}
+	
+	bufdesc->frmctxt = dc->hwdrv->do_buffer(dc->classdev.dev, bufdesc);
+	if (IS_ERR(bufdesc->frmctxt))  {
+		int i;
+		
+		for (i = 0; i < npages; i++)
+			put_page(bufdesc->pages[i]);
+		i = PTR_ERR(bufdesc->frmctxt);
+		kfree(bufdesc);
+		return i;
+	}
+
+	return 0;
+}
+
+
+
+static int __init xicap_init_module(void)
+{
+	int res;
+	static __initdata char 
+		errfmt[] = KERN_ERR "%s: %s failed - error = %d\n",
+		clsreg[] = "class registration",
+		devalc[] = "device number allocation";
+
+	/* Register the xicap class */
+	res = class_register(&xicap_class);
+	if (unlikely(res)) {
+		printk(errfmt, xicap_class.name, clsreg, res);
+		return res;
+	}
+	
+	/* Allocate a range of device numbers */
+	res = alloc_chrdev_region(&devnum_base, 0, MAX_DEVICES, xicap_name);
+	if (unlikely(res)) {
+		printk(errfmt, xicap_name, devalc, res);
+		class_unregister(&xicap_class);
+		return res;
+	}
+	
+	return 0;
+}
+
+
+
+static void __exit xicap_cleanup_module(void)
+{
+	unregister_chrdev_region(devnum_base, MAX_DEVICES);
+	class_unregister(&xicap_class);
+}
+
+
+
+EXPORT_SYMBOL(xicap_device_register);
+EXPORT_SYMBOL(xicap_device_unregister);
+EXPORT_SYMBOL(xicap_frame_done);
+module_init(xicap_init_module);
+module_exit(xicap_cleanup_module);
+
+
+
+MODULE_AUTHOR("Thomas Koeller <thomas.koeller@baslerweb.com>");
+MODULE_DESCRIPTION("Basler eXcite frame capturing core driver");
+MODULE_VERSION("0.0");
+MODULE_LICENSE("GPL");
diff --git a/drivers/xicap/xicap_gpi.c b/drivers/xicap/xicap_gpi.c
new file mode 100644
index 0000000..d39da37
--- /dev/null
+++ b/drivers/xicap/xicap_gpi.c
@@ -0,0 +1,1204 @@
+/*
+ *  Copyright (C) 2004, 2005 by Basler Vision Technologies AG
+ *  Author: Thomas Koeller <thomas.koeller@baslerweb.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+#include <linux/dma-mapping.h>
+#include <linux/vmalloc.h>
+#include <linux/workqueue.h>
+#include <linux/moduleparam.h>
+#include <asm/types.h>
+#include <asm/io.h>
+#include <asm/rm9k-ocd.h>
+#include <asm/page.h>
+#include <asm/semaphore.h>
+
+#include <rm9k_xicap.h>
+
+#include "xicap_priv.h"
+
+
+/* Debug support */
+#define XICAP_GPI_DBG			0
+
+#if XICAP_GPI_DBG
+#	define	dbgprint(fmt,arg...) printk(KERN_DEBUG fmt,##arg)
+
+static u32 dbg_readl(unsigned int) __attribute__((used));
+
+static u32 dbg_readl(unsigned int addr)
+{
+	return titan_readl(addr);
+}
+#else
+#	define	dbgprint(fmt,arg...) do {} while (0)
+#endif
+
+
+
+/* Module arguments */
+unsigned int min_packet_size = (32 * L1_CACHE_BYTES);
+module_param(min_packet_size, uint, 0644);
+
+
+
+#define VMAP_WORKAROUND			1
+
+
+
+#define PAGES_PER_FULL_PACKET		7
+#define MAX_PAGES_PER_PACKET		(PAGES_PER_FULL_PACKET + 1)
+#define FULL_PACKET_SIZE		(PAGE_SIZE * PAGES_PER_FULL_PACKET)
+#define ABSOLUTE_MIN_PACKET_SIZE	5
+#define MAX_PACKET_SIZE			32767
+#define DUMMY_PACKET_SIZE		min_packet_size
+
+
+
+/* DMA decriptor-related definitions */
+#define XDMA_RING_SIZE_CODE		3
+#define XDMA_DESC_RING_SIZE		(512 >> XDMA_RING_SIZE_CODE)
+#define XDMA_ENABLE_REGVAL		\
+	(0x80000000 | (XDMA_RING_SIZE_CODE << 16) | (3 << 5))
+
+
+/*
+ * I/O register access macros
+ * Do not use __raw_writeq() and __raw_readq(), these do not seem to work!
+ */
+#define io_writeq(__v__, __a__)	\
+	*(volatile unsigned long long *) (__a__) = (__v__)
+#define io_readq(__a__)		(*(volatile unsigned long long *) (__a__))
+#define io_readl(__a__)		__raw_readl((__a__))
+#define io_writel(__v__, __a__)	__raw_writel((__v__), (__a__))
+#define io_readb(__a__)		__raw_readb((__a__))
+#define io_writeb(__v__, __a__)	__raw_writeb((__v__), (__a__))
+
+
+
+typedef struct __pkt		packet_t;
+typedef struct __gpi_devctxt	xicap_gpi_device_context_t;
+
+
+/* Function prototypes */
+static int __init xicap_gpi_probe(struct device *);
+static int __exit xicap_gpi_remove(struct device *);
+static int xicap_gpi_start(struct device *);
+static void xicap_gpi_stop(struct device *);
+static int xicap_gpi_flush(struct device *);
+static xicap_frame_context_t * xicap_gpi_do_buffer(struct device *, 
xicap_data_buffer_t *);
+#if VMAP_WORKAROUND
+static int xicap_gpi_finish_buffer(struct device *, xicap_frame_context_t *);
+#endif
+static void xicap_gpi_run_pkt_queue(xicap_gpi_device_context_t *);
+static void xicap_gpi_start_data(xicap_gpi_device_context_t *);
+static void xicap_gpi_stop_data(xicap_gpi_device_context_t *);
+static void xicap_gpi_pkt_finish(void *);
+static void xicap_gpi_flush_queue(struct list_head *, unsigned int);
+static irqreturn_t xicap_gpi_int_handler(int, void *, struct pt_regs *);
+
+
+
+/* A common name for various objects */
+static const char xicap_gpi_name[] = "xicap_gpi";
+
+
+
+/* The driver struct */
+static struct device_driver xicap_gpi_driver = {
+	.name		= (char *) xicap_gpi_name,
+	.bus		= &platform_bus_type,
+	.owner		= THIS_MODULE,
+	.probe		= xicap_gpi_probe,
+	.remove		= __exit_p(xicap_gpi_remove),
+	.shutdown	= NULL,
+	.suspend	= NULL,
+	.resume		= NULL
+};
+
+
+
+static const xicap_hw_driver_t xicap_gpi_hwdrv = {
+	.start		= xicap_gpi_start,
+	.stop		= xicap_gpi_stop,
+	.do_buffer	= xicap_gpi_do_buffer,
+#if VMAP_WORKAROUND
+	.finish_buffer	= xicap_gpi_finish_buffer,
+#else
+	.finish_buffer	= NULL,
+#endif
+	.flush		= xicap_gpi_flush
+};
+
+
+
+/* A work queue for cleting packets */
+struct workqueue_struct *wq;
+
+
+
+/* A DMA buffer used to work around the RM9K GPI silicon bug */
+unsigned long dummy_dma_buffer;
+
+
+
+/* XDMA read descriptor */
+typedef struct {
+	u64	cpu_part;
+	u64	xdma_part;
+} xdmadesc_t;
+
+
+
+/* A context struct for every device */
+struct __gpi_devctxt {
+	struct semaphore		lock;
+	unsigned int			slice;
+	unsigned int			irq;
+	unsigned int			fifomem_start;
+	unsigned int			fifomem_size;
+
+	void __iomem *			regaddr_fifo_rx;
+	void __iomem *			regaddr_fifo_tx;
+	void __iomem *			regaddr_xdma;
+	void __iomem *			regaddr_pktproc;
+	void __iomem *			regaddr_fpga;
+	void __iomem *			dmadesc;
+	
+	dma_addr_t			dmadesc_p;
+	atomic_t			desc_cnt;
+
+	struct list_head		frm_queue;
+	unsigned int			frm_cnt;
+	unsigned int			frm_ready_cnt;
+
+	/* Core driver context pointer */
+	xicap_device_context_t *	devctxt;
+
+	/*
+	 * The interrupt queue, where packes are queued for
+	 * processing at interrupt level.
+	 */
+	spinlock_t			int_queue_lock;
+	struct list_head		int_queue;
+	unsigned int			int_errflg;
+
+
+	/* The packet queue & related stuff */
+	struct list_head		pkt_queue;
+	unsigned int			pkt_page_i;
+
+
+	void __iomem *			curdesc;
+};
+
+
+
+struct __pkt {
+	union {
+		struct list_head	link;
+		struct work_struct	wrk;
+	}			link;
+	dma_addr_t		pgaddr[MAX_PAGES_PER_PACKET];
+	xicap_frame_context_t *	fctxt;
+	volatile const u64 *	desc2;
+	u16			copy_size;
+	u16			mapped_size;
+	u16			remain_size;
+	void *			copy_src;
+	struct page **		copy_pg;
+	unsigned int		copy_offs;
+	struct page **		page;
+	unsigned int 		ndirty;
+};
+
+
+
+#define PKTFLG_FIFO_OVERFLOW	0x01
+#define PKTFLG_DATA_ERROR	0x02
+#define PKTFLG_XDMA_ERROR	0x04
+#define PKTFLG_DESC_UNDERRUN	0x08
+
+
+
+
+struct xicap_frmctxt {
+	struct list_head		link;
+	struct device *			dev;
+	unsigned int			flags;
+	xicap_gpi_device_context_t *	dc;
+	int				status;
+	u16				fpga_data[5];
+	xicap_data_buffer_t *		buf;
+	atomic_t			npkts;
+	unsigned int 			total_pkts;
+	packet_t			pkts[0];
+};
+
+
+
+static inline xicap_data_buffer_t * xicap_gpi_delete_packet(packet_t *pkt)
+{
+	xicap_frame_context_t * const fctxt = pkt->fctxt;
+	xicap_data_buffer_t * res = NULL;
+	
+	if (!atomic_dec_return(&fctxt->npkts)) {
+		res = fctxt->buf;
+		res->status = fctxt->status;
+#if !VMAP_WORKAROUND
+		kfree(fctxt);
+#endif
+	}
+	
+	return res;
+}
+
+
+
+static inline const struct resource *
+xicap_gpi_get_resource(struct platform_device *d, unsigned long flags,
+		 const char *basename)
+{
+	const char fmt[] = "%s_%u";
+	char buf[80];
+
+	if (unlikely(snprintf(buf, sizeof buf, fmt, basename, d->id) >= sizeof buf))
+		return NULL;
+	return platform_get_resource_byname(d, flags, buf);
+}
+
+
+
+static inline void __iomem *
+xicap_gpi_map_regs(struct platform_device *d, const char *basename)
+{
+	void * result = NULL;
+	const struct resource * const r =
+		xicap_gpi_get_resource(d, IORESOURCE_MEM, basename);
+	if (likely(r))
+		result = ioremap_nocache(r->start, r->end + 1 - r->start);
+	return result;
+}
+
+
+
+/* No hotplugging on the platform bus - use __init */
+static int __init xicap_gpi_probe(struct device *dev)
+{
+	int res;
+	xicap_gpi_device_context_t *dc = NULL;
+	struct platform_device * pdv;
+	const struct resource * rsrc;
+	
+	static char __initdata
+		rsrcname_gpi_slice[] = XICAP_RESOURCE_GPI_SLICE,
+		rsrcname_fifo_blk[] = XICAP_RESOURCE_FIFO_BLK,
+		rsrcname_irq[] = XICAP_RESOURCE_IRQ,
+		rsrcname_dmadesc[] = XICAP_RESOURCE_DMADESC,
+		rsrcname_fifo_rx[] = XICAP_RESOURCE_FIFO_RX,
+		rsrcname_fifo_tx[] = XICAP_RESOURCE_FIFO_TX,
+		rsrcname_xdma[] = XICAP_RESOURCE_XDMA,
+		rsrcname_pktproc[] = XICAP_RESOURCE_PKTPROC,
+		rsrcname_pkt_stream[] = XICAP_RESOURCE_PKT_STREAM;
+
+	/* Get the platform device. */
+	if (unlikely(dev->bus != &platform_bus_type)) {
+		res = -ENODEV;
+		goto errex;
+	}
+
+	pdv = to_platform_device(dev);
+
+	/* Create and set up the device context */
+	dc = (xicap_gpi_device_context_t *)
+	      kmalloc(sizeof (xicap_gpi_device_context_t), GFP_KERNEL);
+	if (!dc) {
+		res = -ENOMEM;
+		goto errex;
+	}
+	memset(dc, 0, sizeof *dc);
+	init_MUTEX(&dc->lock);
+	
+	/* Evaluate resources */
+	res = -ENXIO;
+
+	rsrc = xicap_gpi_get_resource(pdv, 0, rsrcname_gpi_slice);
+	if (unlikely(!rsrc)) goto errex;
+	dc->slice = rsrc->start;
+	
+	rsrc = xicap_gpi_get_resource(pdv, 0, rsrcname_fifo_blk);
+	if (unlikely(!rsrc)) goto errex;
+	dc->fifomem_start = rsrc->start;
+	dc->fifomem_size = rsrc->end + 1 - rsrc->start;
+
+	rsrc = xicap_gpi_get_resource(pdv, IORESOURCE_IRQ, rsrcname_irq);
+	if (unlikely(!rsrc)) goto errex;
+	dc->irq = rsrc->start;
+	
+	rsrc = xicap_gpi_get_resource(pdv, IORESOURCE_MEM, rsrcname_dmadesc);
+	if (unlikely(!rsrc)) goto errex;
+	if (unlikely((rsrc->end + 1 - rsrc->start)
+	             < (XDMA_DESC_RING_SIZE * sizeof (xdmadesc_t))))
+		goto errex;
+	dc->dmadesc_p = (dma_addr_t) rsrc->start;
+	dc->dmadesc = ioremap_nocache(rsrc->start, rsrc->end + 1 - rsrc->start);
+	
+	dc->regaddr_fifo_rx = xicap_gpi_map_regs(pdv, rsrcname_fifo_rx);
+	dc->regaddr_fifo_tx = xicap_gpi_map_regs(pdv, rsrcname_fifo_tx);
+	dc->regaddr_xdma = xicap_gpi_map_regs(pdv, rsrcname_xdma);
+	dc->regaddr_pktproc = xicap_gpi_map_regs(pdv, rsrcname_pktproc);
+	dc->regaddr_fpga = xicap_gpi_map_regs(pdv, rsrcname_pkt_stream);
+
+	if (unlikely(!dc->regaddr_fifo_rx || !dc->regaddr_fifo_tx
+	    || !dc->regaddr_xdma || !dc->regaddr_pktproc || !dc->regaddr_fpga
+	    || !dc->dmadesc))
+		goto errex;
+
+	/* Register the device with the core */
+	dc->devctxt = xicap_device_register(dev, &xicap_gpi_hwdrv);
+	res = IS_ERR(dc->devctxt) ? PTR_ERR(dc->devctxt) : 0;
+
+errex:
+	if (res) {
+		if (dc->regaddr_fifo_rx) iounmap(dc->regaddr_fifo_rx);
+		if (dc->regaddr_fifo_tx) iounmap(dc->regaddr_fifo_tx);
+		if (dc->regaddr_xdma) iounmap(dc->regaddr_xdma);
+		if (dc->regaddr_pktproc) iounmap(dc->regaddr_pktproc);
+		if (dc->regaddr_fpga) iounmap(dc->regaddr_fpga);
+		if (dc->dmadesc) iounmap(dc->dmadesc);
+		if (dc) kfree(dc);
+		dbgprint("%s: %s failed, error = %d\n", xicap_gpi_name,
+			 __func__, res);
+	} else {
+		dev->driver_data = dc;
+		dbgprint("%s: Context at %p\n", xicap_gpi_name, dc);
+	}
+
+	return res;
+}
+
+
+
+static int __exit xicap_gpi_remove(struct device *dev)
+{
+	xicap_gpi_device_context_t * const dc =
+		(xicap_gpi_device_context_t *) dev->driver_data;
+
+	xicap_device_unregister(dc->devctxt);
+	kfree(dc);
+	dev->driver_data = NULL;
+	return 0;
+}
+
+
+
+static int xicap_gpi_start(struct device *dev)
+{
+	xicap_gpi_device_context_t * const dc =
+		(xicap_gpi_device_context_t *) dev->driver_data;
+	u32 reg;
+	int res;
+
+	/* Lock the device context */	
+	down(&dc->lock);
+	
+	/* Device context initialization */
+	INIT_LIST_HEAD(&dc->pkt_queue);
+	INIT_LIST_HEAD(&dc->frm_queue);
+	INIT_LIST_HEAD(&dc->int_queue);
+	spin_lock_init(&dc->int_queue_lock);
+	dc->int_errflg = 0;
+
+	lock_titan_regs();
+
+	/* Disable the slice status interrupts */
+	reg = titan_readl(0x0050) & ~(0x1f << (dc->slice * 5));
+	titan_writel(reg, 0x0050);
+
+	/* Disable the XDMA interrupts for this slice */
+	reg = titan_readl(0x0058) & ~(0xff << (dc->slice * 8));
+	titan_writel(reg, 0x0058);
+
+	unlock_titan_regs();
+
+	xicap_gpi_start_data(dc);
+
+	res = request_irq(dc->irq, xicap_gpi_int_handler,
+			  SA_SHIRQ, xicap_gpi_name, dc);
+	if (unlikely(res))
+		return res;
+
+	lock_titan_regs();
+
+	/* Enable the slice status interrupts */
+	reg = titan_readl(0x0050) | (0x2 << (dc->slice * 5));
+	titan_writel(reg, 0x0050);
+
+	/* Enable the XDMA data interrupt */
+	reg = 0xff << (dc->slice * 8);
+	titan_writel(reg, 0x0048);
+	titan_writel(reg, 0x004c);
+	reg = titan_readl(0x0058);
+	titan_writel(reg | (0x1 << (dc->slice * 8)), 0x0058);
+
+	unlock_titan_regs();
+
+	/* Release the device context and exit */
+	up(&dc->lock);
+	return 0;
+}
+
+
+
+static void xicap_gpi_start_data(xicap_gpi_device_context_t *dc)
+{
+	unsigned int i;
+
+	/* Reset all XDMA channels for this slice */
+	io_writel(0x80080000, dc->regaddr_xdma + 0x0000);
+	io_writel(0x80080000, dc->regaddr_xdma + 0x0040);
+	io_writel(0x80080000, dc->regaddr_xdma + 0x0080);
+	io_writel(0x80080000, dc->regaddr_xdma + 0x00c0);
+
+	/* Reset & enable the XDMA slice interrupts */	
+	io_writel(0x80068002, dc->regaddr_xdma + 0x000c);
+	io_writel(0x00008002, dc->regaddr_xdma + 0x0010);
+
+	dc->pkt_page_i = 0;
+	dc->frm_ready_cnt = dc->frm_cnt = 0;
+		
+	/* Set up the XDMA descriptor ring & enable the XDMA */
+	dc->curdesc = dc->dmadesc;
+	atomic_set(&dc->desc_cnt, XDMA_DESC_RING_SIZE);
+	io_writel(dc->dmadesc_p, dc->regaddr_xdma + 0x0018);
+	wmb();
+	memset(dc->dmadesc, 0, XDMA_DESC_RING_SIZE * sizeof (xdmadesc_t));
+	io_writel(XDMA_ENABLE_REGVAL, dc->regaddr_xdma + 0x0000);
+
+	/*
+	 * Enable the rx fifo we are going to use. Disable the
+	 * unused ones as well as the tx fifo.
+	 */
+	io_writel(0x00100000 | ((dc->fifomem_size) << 10)
+		  | dc->fifomem_start,
+		  dc->regaddr_fifo_rx + 0x0000);
+	wmb();
+	io_writel((10 << 20) | (10 << 10) | 128, dc->regaddr_fifo_rx
+		  + 0x0004);
+	io_writel(0x00100400, dc->regaddr_fifo_rx + 0x000c);
+	io_writel(0x00100400, dc->regaddr_fifo_rx + 0x0018);
+	io_writel(0x00100400, dc->regaddr_fifo_rx + 0x0024);
+	io_writel(0x00100400, dc->regaddr_fifo_tx + 0x0000);
+
+	/* Reset any pending interrupt, then enable fifo */
+	titan_writel(0xf << (dc->slice * 4), 0x482c);
+	wmb();
+	io_writel(0x00200000 | ((dc->fifomem_size) << 10)
+		  | dc->fifomem_start,
+		  dc->regaddr_fifo_rx + 0x0000);
+	
+	/* Enable the packet processor */
+	io_writel(0x00000000, dc->regaddr_pktproc + 0x0000);
+	wmb();
+	io_writel(0x0000001f, dc->regaddr_pktproc + 0x0008);
+	io_writel(0x00000e08, dc->regaddr_pktproc + 0x0010);
+	io_writel(0x0000080f, dc->regaddr_pktproc + 0x0014);
+	io_writel(0x000003ff, dc->regaddr_pktproc + 0x0018);
+	io_writel(0x00000100, dc->regaddr_pktproc + 0x0038);
+	wmb();
+	io_writel(0x00000001, dc->regaddr_pktproc + 0x0000);
+	
+	/* Disable address filtering */
+	io_writel(0x0, dc->regaddr_pktproc + 0x0120);
+	io_writel(0x2, dc->regaddr_pktproc + 0x0124);
+	for (i = 0; i < 8; i++) {
+		io_writel(  i, dc->regaddr_pktproc + 0x0128);
+		wmb();
+		io_writel(0x0, dc->regaddr_pktproc + 0x0100);
+		io_writel(0x0, dc->regaddr_pktproc + 0x0104);
+		io_writel(0x0, dc->regaddr_pktproc + 0x0108);
+		io_writel(0x0, dc->regaddr_pktproc + 0x010c);
+		wmb();
+	}
+	
+	io_writel(0x1, dc->regaddr_pktproc + 0x012c);
+		
+}
+
+
+
+static void xicap_gpi_stop_data(xicap_gpi_device_context_t *dc)
+{
+	/* Shut down the data transfer */
+	io_writeb(0x01, dc->regaddr_fpga + 0x000b);
+
+	/* Reset the XDMA channel */
+	io_writel(0x80080000, dc->regaddr_xdma + 0x0000);
+	
+	/* Disable the FIFO */
+	io_writel(0x00100400, dc->regaddr_fifo_rx + 0x0000);
+	
+	/* Disable the packet processor */
+	io_writel(0x00000000, dc->regaddr_pktproc + 0x0000);
+
+	dc->frm_ready_cnt = 0;
+	INIT_LIST_HEAD(&dc->frm_queue);
+}
+
+
+
+static void xicap_gpi_flush_queue(struct list_head *l, unsigned int stat)
+{
+	while (!list_empty(l)) {
+		packet_t * const pkt =
+			list_entry(l->next, packet_t, link.link);
+		xicap_gpi_device_context_t * const dc = pkt->fctxt->dc;
+		const dma_addr_t *pa = pkt->pgaddr;
+		xicap_data_buffer_t * buf;
+
+		list_del(&pkt->link.link);
+
+		while (pkt->mapped_size) {
+			size_t sz = pkt->mapped_size;
+			if (sz > PAGE_SIZE)
+				sz = PAGE_SIZE;
+			pkt->mapped_size -= sz;
+			dma_unmap_page(pkt->fctxt->dev, *pa++, sz,
+				       DMA_FROM_DEVICE);
+		}
+	
+		if (pkt->copy_size) {
+			free_pages((unsigned long) pkt->copy_src,
+				   pkt->copy_size > PAGE_SIZE ? 1 : 0);
+			pkt->copy_size = 0;
+		}
+
+		buf = xicap_gpi_delete_packet(pkt);
+		if (buf) {
+			buf->status = stat;
+			xicap_frame_done(dc->devctxt, buf);
+		}
+	}
+}
+
+
+
+static void xicap_gpi_stop(struct device *dev)
+{
+	u32 reg;
+	LIST_HEAD(l);
+	xicap_gpi_device_context_t * const dc =
+		(xicap_gpi_device_context_t *) dev->driver_data;
+	
+	lock_titan_regs();
+
+	/* Disable the slice status interrupts */
+	reg = titan_readl(0x0050) & ~(0x1f << (dc->slice * 5));
+	titan_writel(reg, 0x0050);
+
+	/* Disable the XDMA interrupts for this slice */
+	reg = titan_readl(0x0058) & ~(0xff << (dc->slice * 8));
+	titan_writel(reg, 0x0058);
+
+	unlock_titan_regs();
+	flush_workqueue(wq);
+	down(&dc->lock);
+	xicap_gpi_stop_data(dc);
+
+	/* Now clean up the packet & int queues */
+	spin_lock_irq(&dc->int_queue_lock);
+	list_splice_init(&dc->int_queue, &l);
+	spin_unlock_irq(&dc->int_queue_lock);
+	list_splice_init(&dc->pkt_queue, l.prev);
+	xicap_gpi_flush_queue(&l, ~0x0);
+	up(&dc->lock);
+
+	/* Detach interrupt handler */
+	free_irq(dc->irq, dc);
+}
+
+
+
+static int xicap_gpi_flush(struct device *dev)
+{
+	u32 reg;
+	xicap_gpi_device_context_t * const dc =
+		(xicap_gpi_device_context_t *) dev->driver_data;
+	LIST_HEAD(l);
+
+	lock_titan_regs();
+
+	/* Disable the slice status interrupts */
+	reg = titan_readl(0x0050) & ~(0x1f << (dc->slice * 5));
+	titan_writel(reg, 0x0050);
+
+	/* Disable the XDMA interrupts for this slice */
+	reg = titan_readl(0x0058) & ~(0xff << (dc->slice * 8));
+	titan_writel(reg, 0x0058);
+
+	unlock_titan_regs();
+
+	/* Now clean up the packet & int queues */
+	flush_workqueue(wq);
+	down(&dc->lock);
+	xicap_gpi_stop_data(dc);
+	spin_lock_irq(&dc->int_queue_lock);
+	list_splice_init(&dc->int_queue, &l);
+	spin_unlock_irq(&dc->int_queue_lock);
+	list_splice_init(&dc->pkt_queue, l.prev);
+	xicap_gpi_flush_queue(&l, XICAP_BUFSTAT_ABORTED);
+	xicap_gpi_start_data(dc);
+	up(&dc->lock);
+
+	lock_titan_regs();
+
+	/* Re-enable the slice status interrupts */
+	reg = titan_readl(0x0050) | (0x2 << (dc->slice * 5));
+	titan_writel(reg, 0x0050);
+
+	/* Re-enable the XDMA data interrupt */
+	reg = 0xff << (dc->slice * 8);
+	titan_writel(reg, 0x0048);
+	titan_writel(reg, 0x004c);
+	reg = titan_readl(0x0058);
+	wmb();
+	titan_writel(reg | (0x1 << (dc->slice * 8)), 0x0058);
+
+	unlock_titan_regs();
+
+	return 0;
+}
+
+
+
+static xicap_frame_context_t *
+xicap_gpi_do_buffer(struct device *dev, xicap_data_buffer_t *buf)
+{
+	unsigned long head_buf = 0, tail_buf = 0;
+	u16 head_size = 0, tail_size = 0, full_size = FULL_PACKET_SIZE;
+	u16 total_packets;
+	size_t sz = buf->size;
+	unsigned int full_packets = 0, head_order = 0, i, request_frame = 1;
+	const unsigned int boffs = (unsigned long) buf->uaddr & ~PAGE_MASK;
+	packet_t *pkt;
+	struct page ** pg;
+	LIST_HEAD(packets);
+	xicap_frame_context_t * fctxt;
+	xicap_gpi_device_context_t * const dc =
+		(xicap_gpi_device_context_t *) dev->driver_data;
+	
+	if (unlikely(sz < ABSOLUTE_MIN_PACKET_SIZE))
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * If the buffer is not page aligned, the first part of it
+	 * (the 'head') is DMA'ed into a temporary buffer and later
+	 * copied to the user's buffer. The size of the head is chosen
+	 * so that the remaining part of the buffer is page aligned.
+	 */	
+	if (boffs) {
+		head_size = PAGE_SIZE - boffs;
+		if (head_size < min_packet_size) {
+			head_size += PAGE_SIZE;
+			head_order = 1;
+		}
+		if (head_size > sz) {
+			head_size = sz;
+			head_order = (head_size > PAGE_SIZE) ? 1 : 0;
+		}
+		head_buf = __get_dma_pages(GFP_KERNEL, head_order);
+		if (!head_buf)
+			return ERR_PTR(-ENOMEM);
+			
+		/* Compute the residual buffer size */	
+		sz -= head_size;
+	}
+
+	/*
+	 * Now compute the number of full-sized packets, and the size
+	 * of the last ('tail') packet.
+	 */
+	if (sz) {
+		full_packets = sz / FULL_PACKET_SIZE;
+		tail_size = sz % FULL_PACKET_SIZE;
+	}
+	
+	/*
+	 * If the tail packet is less than a page, it can be merged with
+	 * the previous one. This also covers the case where the size of
+	 * the tail packet is less than min_packet_size.
+	 */
+	if ((tail_size < PAGE_SIZE) && full_packets) {
+		full_packets--;
+		tail_size += FULL_PACKET_SIZE;
+	}
+
+	/*
+	 * The XDMA will pad the last packet to the next cache line
+	 * boundary, so in order to avoid writing beyond the user's
+	 * buffer, we need to use a temporary buffer if the tail packet
+	 * size is not an integer multiple of the cache line size.
+	 */
+	if (tail_size % L1_CACHE_BYTES) {
+		tail_buf = __get_dma_pages(GFP_KERNEL, 0);
+		if (unlikely(!tail_buf)) {
+			if (head_buf)
+				free_pages(head_buf, head_order);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	/*
+	 * Now we know how many packets to process for the buffer, so we
+	 * can allocate a packet set. Add one extra dummy packet (silicon
+	 * bug workaround).
+	 */		  
+	total_packets =
+		full_packets + (head_size ? 1 : 0) + (tail_size ? 1 : 0) + 1;
+	fctxt = kmalloc(
+		sizeof (xicap_frame_context_t) + sizeof (packet_t) * total_packets,
+		GFP_KERNEL);
+	if (unlikely(!fctxt)) {
+		if (tail_buf)
+			free_pages(tail_buf, 0);
+		if (head_buf)
+			free_pages(head_buf, head_order);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	fctxt->buf = buf;
+	fctxt->dev = dev;
+	fctxt->flags = 0;
+	fctxt->status = XICAP_BUFSTAT_OK;
+	atomic_set(&fctxt->npkts, total_packets);
+	fctxt->total_pkts = total_packets;
+	pkt = &fctxt->pkts[0];
+	pg = buf->pages;
+	fctxt->dc = (xicap_gpi_device_context_t *) dev->driver_data;
+	
+	/* Set up the head packet descriptor */
+	if (head_size) {
+		struct page * const p = virt_to_page(head_buf);
+
+		pkt->page = pkt->copy_pg = pg;
+
+		if (head_order) {
+			pkt->pgaddr[0] = dma_map_page(dev, p, 0, PAGE_SIZE,
+						      DMA_FROM_DEVICE);
+			pkt->pgaddr[1] = dma_map_page(dev, p + 1, 0,
+						      head_size - PAGE_SIZE,
+						      DMA_FROM_DEVICE);
+			pkt->ndirty = 2;
+			pg += 2;
+		} else {
+			pkt->pgaddr[0] = dma_map_page(dev, p, 0, head_size,
+						      DMA_FROM_DEVICE);
+			pkt->ndirty = 1;
+			pg++;
+		}
+		
+		pkt->copy_src = (void *) head_buf;
+		pkt->copy_offs = ((unsigned long)buf->uaddr & ~PAGE_MASK);
+		pkt->remain_size = pkt->mapped_size = pkt->copy_size = head_size;
+		pkt->fctxt = fctxt;
+		list_add_tail(&pkt->link.link, &packets);
+		pkt++;
+	}
+	
+	/* Set up descriptors for all full-sized packets */
+	while (full_packets--) {
+		pkt->remain_size = pkt->mapped_size = FULL_PACKET_SIZE;
+		pkt->copy_size = 0;
+		pkt->page = pg;
+		pkt->ndirty = PAGES_PER_FULL_PACKET;
+		
+		for (i = 0; i < PAGES_PER_FULL_PACKET; i++)
+			pkt->pgaddr[i] = dma_map_page(dev, *pg++, 0, PAGE_SIZE,
+						      DMA_FROM_DEVICE);
+
+		pkt->fctxt = fctxt;
+		list_add_tail(&pkt->link.link, &packets);
+		pkt++;
+	}
+
+	/* Set up the descriptor for the tail packet */
+	if (tail_size) {
+		const size_t cs = tail_size % PAGE_SIZE;
+
+		pkt->remain_size = pkt->mapped_size = tail_size;
+		pkt->page = pg;
+		pkt->ndirty = tail_size / PAGE_SIZE;
+
+		for (i = 0; i < pkt->ndirty; i++)
+			pkt->pgaddr[i] = dma_map_page(dev, *pg++, 0, PAGE_SIZE,
+						      DMA_FROM_DEVICE);
+
+		if (cs) {
+			if (tail_buf) {
+				struct page * const p = virt_to_page(tail_buf);
+				pkt->pgaddr[i] = dma_map_page(dev, p, 0, cs,
+							      DMA_FROM_DEVICE);
+				pkt->copy_src = (void *) tail_buf;
+				pkt->copy_size = cs;
+				pkt->copy_pg = pg;
+				pkt->copy_offs = 0;
+			} else {
+				pkt->pgaddr[i] = dma_map_page(dev, *pg, 0, cs,
+							      DMA_FROM_DEVICE);
+				pkt->copy_size = 0;
+			}
+			pkt->ndirty++;
+		} else {
+			pkt->copy_size = 0;
+		}
+
+		pkt->fctxt = fctxt;
+		list_add_tail(&pkt->link.link, &packets);
+		pkt++;
+	}
+
+	/*
+	 * Set up the trailing dummy packet (silicon bug workaround).
+	 *
+	 * The XDMA does not generate an interrupt if the memory
+	 * controlled by the last DMA descriptor is filled with data
+	 * to the last byte. We work around this by adding a dummy packet
+	 * after each frame. This guarantees that there always is an
+	 * active DMA descriptor after the last one of the frame, and so
+	 * the XDMA will interrupt. The dummy packet size is chosen so that
+	 * the dummy buffer is not entirely filled and hence will always
+	 * generate an interrupt, too.
+	 */
+	pkt->remain_size = pkt->mapped_size = DUMMY_PACKET_SIZE;
+	pkt->page = NULL;
+	pkt->copy_size = 0;
+	pkt->ndirty = 0;
+				      
+	for (i = 0; i < DUMMY_PACKET_SIZE / PAGE_SIZE; i++)
+		pkt->pgaddr[i] = dma_map_page(dev, virt_to_page(dummy_dma_buffer),
+					      0, PAGE_SIZE, DMA_FROM_DEVICE);
+
+	pkt->pgaddr[i] = dma_map_page(dev, virt_to_page(dummy_dma_buffer),
+				      0, DUMMY_PACKET_SIZE % PAGE_SIZE,
+				      DMA_FROM_DEVICE);
+
+	pkt->fctxt = fctxt;
+	list_add_tail(&pkt->link.link, &packets);
+
+	/*
+	 * Set up data to send to the FPGA. The total number of packets
+	 * requested does _not_ include the dummy packet. If DUMMY_PACKET_SIZE
+	 * is not zero, a dummy packet is always sent.
+	 */
+	fctxt->fpga_data[0] = cpu_to_le16(fctxt->pkts[0].mapped_size);
+	fctxt->fpga_data[1] = cpu_to_le16(full_size);
+	fctxt->fpga_data[2] = cpu_to_le16((pkt - 1)->mapped_size);
+	fctxt->fpga_data[3] = cpu_to_le16(DUMMY_PACKET_SIZE);
+	fctxt->fpga_data[4] = cpu_to_le16(total_packets - 1);
+	
+	down(&dc->lock);
+	
+	/* Now enqueue all the packets in one step */
+	list_splice(&packets, dc->pkt_queue.prev);
+	if (!dc->frm_cnt++)
+		xicap_gpi_run_pkt_queue(dc);
+
+	dbgprint("%s: created packet set %p\n"
+		 "\thead size = %#06x, full size = %#06x, "
+		 "tail size = %#06x, dummy size = %#06x\n"
+		 "\ttotal packets = %u, active DMA descriptors = %u\n",
+		 xicap_gpi_name, fctxt, head_size, full_size, tail_size,
+		 DUMMY_PACKET_SIZE, total_packets,
+		 io_readl(dc->regaddr_xdma + 0x0008));
+
+	/*
+	 * If less than two frames are currently pending, we can send
+	 * the frame parameters to the FPGA right away. Otherwise, we
+	 * need to queue the frame.
+	 */
+	if (dc->frm_ready_cnt++ > 1) {
+		list_add_tail(&fctxt->link, &dc->frm_queue);
+		request_frame = 0;
+	}
+	
+	up(&dc->lock);
+	 
+	if (request_frame)
+		memcpy_toio(dc->regaddr_fpga, fctxt->fpga_data,
+			    sizeof fctxt->fpga_data);
+	
+	return fctxt;
+}
+
+
+
+static void xicap_gpi_run_pkt_queue(xicap_gpi_device_context_t *dc)
+{
+	packet_t *pkt = list_empty(&dc->pkt_queue) ? NULL :
+			list_entry(dc->pkt_queue.next, packet_t, link.link);
+
+	while (pkt) {
+		int i;
+		size_t sz;
+
+		/* Stop, if no more free DMA descriptors */
+		if (0 > atomic_dec_if_positive(&dc->desc_cnt))
+			break;
+
+		i = dc->pkt_page_i++;
+
+		sz = pkt->remain_size;
+		if (sz > PAGE_SIZE)
+			sz = PAGE_SIZE;
+		pkt->remain_size -= sz;
+
+		/* Set up the DMA descriptor */
+		io_writeq(cpu_to_be64(pkt->pgaddr[i]), dc->curdesc);
+		if (i) {
+			io_writeq(cpu_to_be64(0x1ULL << 53), dc->curdesc + 8);
+		} else {
+			io_writeq(cpu_to_be64((0x1ULL << 63) | (0x1ULL << 53)),
+				  dc->curdesc + 8);
+			pkt->desc2 = dc->curdesc + 8;
+		}
+
+		dbgprint("%s: Desc. %2u = %016Lx, %016Lx\n",
+			 xicap_gpi_name,
+			 (dc->curdesc - dc->dmadesc) / sizeof (xdmadesc_t),
+			 (u64) pkt->pgaddr[i], desc2);
+
+		dc->curdesc += sizeof (xdmadesc_t);
+		if ((dc->curdesc - dc->dmadesc) >=
+		    (XDMA_DESC_RING_SIZE * sizeof (xdmadesc_t)))
+			dc->curdesc = dc->dmadesc;
+
+		/* Add the packet to the interrupt queue */
+		if (!pkt->remain_size) {
+			spin_lock_irq(&dc->int_queue_lock);
+			list_move_tail(&pkt->link.link, &dc->int_queue);
+			spin_unlock_irq(&dc->int_queue_lock);
+			dc->pkt_page_i = 0;
+			pkt = list_empty(&dc->pkt_queue) ? NULL :
+			      list_entry(dc->pkt_queue.next, packet_t,
+					 link.link);
+		}
+
+		io_writel(1, dc->regaddr_xdma + 0x0008);
+	}
+}
+
+
+#if VMAP_WORKAROUND
+static int
+xicap_gpi_finish_buffer(struct device *dev, xicap_frame_context_t *frmctxt)
+{
+	struct __pkt * const pkt_h = frmctxt->pkts,
+		     * const pkt_t = frmctxt->pkts + frmctxt->total_pkts - 2;
+	
+	if (pkt_h->copy_size) {
+		__copy_to_user(frmctxt->buf->uaddr, pkt_h->copy_src,
+			       pkt_h->copy_size);
+		free_pages((unsigned long) pkt_h->copy_src,
+			   (pkt_h->copy_size > PAGE_SIZE) ? 1 : 0);
+	}
+
+	if (2 < frmctxt->total_pkts) {
+		if (pkt_t->copy_size) {
+			__copy_to_user(frmctxt->buf->uaddr + frmctxt->buf->size
+				       - pkt_t->copy_size,
+				       pkt_t->copy_src,
+				       pkt_t->copy_size);
+			free_pages((unsigned long) pkt_t->copy_src, 0);
+		}
+	}
+
+	kfree(frmctxt);
+	return 0;
+}
+#endif
+
+
+
+static void xicap_gpi_pkt_finish(void *p)
+{
+	packet_t * const pkt = (packet_t *) p;
+	xicap_gpi_device_context_t * const dc =
+		(xicap_gpi_device_context_t *) pkt->fctxt->dev->driver_data;
+	const dma_addr_t *pa = pkt->pgaddr;
+	xicap_data_buffer_t * buf;
+
+	while (pkt->mapped_size) {
+		size_t sz = pkt->mapped_size;
+		if (sz > PAGE_SIZE)
+			sz = PAGE_SIZE;
+		pkt->mapped_size -= sz;
+		dma_unmap_page(pkt->fctxt->dev, *pa++, sz, DMA_FROM_DEVICE);
+	}
+
+#if !VMAP_WORKAROUND
+	if (pkt->copy_size) {
+		const unsigned int page_order =
+			(pkt->copy_size > PAGE_SIZE) ? 1 : 0;
+		void * const dst = vmap(pkt->copy_pg, 0x1 << page_order,
+					VM_MAP, PAGE_USERIO);
+
+		if (dst) {
+			memcpy(dst + pkt->copy_offs, pkt->copy_src,
+			       pkt->copy_size);
+			free_pages((unsigned long) pkt->copy_src, page_order);
+			vunmap(dst);
+		} else {
+			pkt->fctxt->status = XICAP_BUFSTAT_VMERR;
+		}
+	}
+#endif
+
+	while (pkt->ndirty--)
+		set_page_dirty_lock(*pkt->page++);
+
+	down(&dc->lock);
+	buf = xicap_gpi_delete_packet(pkt);
+	if (buf) {
+		xicap_frame_context_t *fctxt = NULL;
+		xicap_frame_done(dc->devctxt, buf);
+		dc->frm_cnt--;
+		if (dc->frm_ready_cnt-- > 2) {
+			fctxt = list_entry(dc->frm_queue.next,
+					  xicap_frame_context_t, link);
+			list_del(&fctxt->link);
+		}
+
+		if (fctxt)
+			memcpy_toio(dc->regaddr_fpga, fctxt->fpga_data,
+				    sizeof fctxt->fpga_data);
+	}
+
+	if (dc->frm_cnt)
+		xicap_gpi_run_pkt_queue(dc);
+	up(&dc->lock);
+}
+
+
+
+/* The interrupt handler */
+static irqreturn_t xicap_gpi_int_handler(int irq, void *arg, struct pt_regs 
*regs)
+{
+	xicap_gpi_device_context_t * const dc =
+		(xicap_gpi_device_context_t *) arg;
+	u32 flg_dmadata, flg_slstat, flg_fofl, reg;
+
+	/* Check, if this interrupt is for us */	
+	flg_dmadata = titan_readl(0x0048) & (0x1 << (dc->slice * 8));
+	flg_slstat = titan_readl(0x0040) & (0x1f << (dc->slice * 5));
+	flg_fofl = titan_readl(0x482c) & ((dc->slice * 4));
+	if (!(flg_dmadata | flg_slstat | flg_fofl))
+		return IRQ_NONE;	/* not our interrupt */
+
+	if (unlikely(flg_slstat)) {
+		reg = io_readl(dc->regaddr_pktproc + 0x000c) & 0x1f;
+		io_writel(reg, dc->regaddr_pktproc + 0x000c);
+		dc->int_errflg |= PKTFLG_DATA_ERROR;
+	}
+
+	if (unlikely(flg_fofl)) {
+		titan_writel(flg_fofl, 0x482c);
+		dc->int_errflg |= PKTFLG_FIFO_OVERFLOW;
+	}
+	
+	reg = io_readl(dc->regaddr_xdma + 0x000c) & 0x00008002;
+	if (unlikely(reg)) {
+		io_writel(reg, dc->regaddr_xdma + 0x000c);
+		dc->int_errflg |= ((reg & 0x00008000) ? PKTFLG_XDMA_ERROR : 0)
+				  | ((reg & 0x00000002) ? PKTFLG_DESC_UNDERRUN : 0);
+	}
+
+	if (likely(flg_dmadata)) {
+		titan_writel(flg_dmadata, 0x0048);
+		spin_lock(&dc->int_queue_lock);
+		while (!list_empty(&dc->int_queue)) {
+			packet_t * const pkt = list_entry(dc->int_queue.next,
+							  packet_t, link.link);
+
+			/* If the packet is not completed yet, exit */
+			if (be64_to_cpu(*pkt->desc2) & (0x1ULL << 53))
+				break;
+			list_del(&pkt->link.link);
+			
+			/* Release the DMA descriptors used by this packet */
+			atomic_add(PAGE_ALIGN(pkt->mapped_size) >> PAGE_SHIFT, &dc->desc_cnt);
+
+			/* All further processing is deferred to a worker thread */	
+			INIT_WORK(&pkt->link.wrk, xicap_gpi_pkt_finish, pkt);
+			if(unlikely(!queue_work(wq, &pkt->link.wrk)))
+				panic("%s: worker thread error\n",
+				      xicap_gpi_name);
+		}
+		spin_unlock(&dc->int_queue_lock);
+	}
+
+	return IRQ_HANDLED;
+}
+
+
+static int __init xicap_gpi_init_module(void)
+{
+	int res;
+	dummy_dma_buffer = __get_dma_pages(GFP_KERNEL, 0);
+	if (!dummy_dma_buffer)
+		return -ENOMEM;
+	wq = create_workqueue(xicap_gpi_name);
+	if (unlikely(!wq)) {
+		free_pages(dummy_dma_buffer, 0);
+		return -ENOMEM;
+	}
+	res = driver_register(&xicap_gpi_driver);
+	if (unlikely(res)) {
+		free_pages(dummy_dma_buffer, 0);
+		destroy_workqueue(wq);
+	}
+	return res;
+}
+
+
+
+static void __exit xicap_gpi_cleanup_module(void)
+{
+	driver_unregister(&xicap_gpi_driver);
+	destroy_workqueue(wq);
+	free_pages(dummy_dma_buffer, 0);
+}
+
+module_init(xicap_gpi_init_module);
+module_exit(xicap_gpi_cleanup_module);
+
+
+
+MODULE_AUTHOR("Thomas Koeller <thomas.koeller@baslerweb.com>");
+MODULE_DESCRIPTION("Basler eXcite frame capturing driver for gpi devices");
+MODULE_VERSION("0.0");
+MODULE_LICENSE("GPL");
+MODULE_PARM_DESC(min_packet_size, "Minimum data packet size");
diff --git a/drivers/xicap/xicap_priv.h b/drivers/xicap/xicap_priv.h
new file mode 100644
index 0000000..7c6b158
--- /dev/null
+++ b/drivers/xicap/xicap_priv.h
@@ -0,0 +1,47 @@
+#if ! defined(XICAP_PRIV_H)
+#define XICAP_PRIV_H
+
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <xicap/xicap.h>
+
+
+
+typedef struct xicap_devctxt xicap_device_context_t;
+typedef struct xicap_frmctxt xicap_frame_context_t;
+
+
+
+/* A queue block for a data buffer */
+typedef struct {
+	struct list_head	link;
+	void __user *		uaddr;
+	size_t			size;
+	void *			uctxt;
+	xicap_frame_context_t *	frmctxt;
+	unsigned int		status;
+	unsigned int		npages;
+	struct page *		pages[0]; /* must be last element! */
+} xicap_data_buffer_t;
+
+
+
+/* Functions invoked by the core */
+typedef struct {
+	int			(*start)(struct device *);
+	void			(*stop)(struct device *);
+	xicap_frame_context_t *	(*do_buffer)(struct device *, xicap_data_buffer_t 
*);
+	int			(*finish_buffer)(struct device *, xicap_frame_context_t *);
+	int			(*flush)(struct device *);
+} xicap_hw_driver_t;
+
+
+
+/* Functions exported by the core */
+xicap_device_context_t *
+	xicap_device_register(struct device *, const xicap_hw_driver_t *);
+void xicap_device_unregister(xicap_device_context_t *);
+void xicap_frame_done(xicap_device_context_t *, xicap_data_buffer_t *);
+
+#endif	/* ! defined(XICAP_PRIV_H) */
diff --git a/include/xicap/xicap.h b/include/xicap/xicap.h
new file mode 100644
index 0000000..6614bc4
--- /dev/null
+++ b/include/xicap/xicap.h
@@ -0,0 +1,40 @@
+#if ! defined(XICAP_H)
+#define XICAP_H
+
+#include <linux/ioctl.h>
+
+/* A buffer descriptor. */
+typedef struct {
+	void	*data;			/* data buffer */
+	size_t	size;			/* data buffer size */
+	void	*ctxt;			/* user-defined context pointer */
+} xicap_arg_qbuf_t;
+
+
+/*
+ * Result block passed back to user after operation completed.
+ * Todo: add time stamp field.
+ */
+typedef struct {
+	void		*data;		/* data buffer pointer */
+	void		*ctxt;		/* user context */
+	int		status;		/* buffer status, see below */
+} xicap_result_t;
+
+/* Returned buffer status values */
+#define XICAP_BUFSTAT_OK	0	/* normal return */
+#define XICAP_BUFSTAT_ABORTED	1	/* aborted by flush */
+#define XICAP_BUFSTAT_VMERR	2	/* buffer mapping error */
+
+
+
+/* Definitions for ioctl() */
+#define	XICAP_IOC_TYPE		0xbb	/* a random choice */
+
+/* Ready to grab next frame */
+#define XICAP_IOC_QBUF		_IOW(XICAP_IOC_TYPE, 0, xicap_arg_qbuf_t)
+#define XICAP_IOC_FLUSH		_IO(XICAP_IOC_TYPE, 1)
+
+#define XICAP_IOC_MAXNR		1
+
+#endif	/* ! defined(XICAP_H) */
-- 
1.4.0


-- 
Thomas Koeller, Software Development

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel +49 (4102) 463-390
Fax +49 (4102) 463-46390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com

