Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbVHYWD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbVHYWD7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 18:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbVHYWD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 18:03:59 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:18132 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964915AbVHYWD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 18:03:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: [PATCH 1/7] spufs: The SPU file system
Date: Fri, 26 Aug 2005 00:03:39 +0200
User-Agent: KMail/1.7.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200508260003.40865.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a work-in-progress version of the SPU file system.

Since the previous version, a lot of features have been added and a number
of bugs has been fixed.  We now support doing read() on the /run file to
start executing code on an SPU.  Some files have been added to give access
to more hardware features, especially the signal notification channels.

Most importantly, we now have a working context save and restore
functionality for SPEs, which is written by Mark Nutter and will
eventually lead to having a scheduler for SPUs in the kernel.  Since this
has grown the file system a lot, I now split it up into a few smaller
patches.

Within the next weeks, we will do some larger reworks on the code base,
so this version is probably the last one that is binary compatible to
the earlier releases.

If you have specific requirements that are not met by spufs in its
present incarnation, now would be a good time to tell us.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--

 Documentation/filesystems/spufs.txt |  107 +++++
 arch/ppc/kernel/ppc_ksyms.c         |    1 
 arch/ppc64/kernel/Makefile          |    1 
 arch/ppc64/kernel/spu_base.c        |  733 ++++++++++++++++++++++++++++++++++++
 arch/ppc64/mm/hash_utils.c          |    1 
 fs/Kconfig                          |   10 
 fs/Makefile                         |    1 
 fs/spufs/Makefile                   |    3 
 fs/spufs/context.c                  |   67 +++
 fs/spufs/file.c                     |  716 +++++++++++++++++++++++++++++++++++
 fs/spufs/inode.c                    |  435 +++++++++++++++++++++
 fs/spufs/spufs.h                    |   65 +++
 include/asm-ppc64/spu.h             |  473 +++++++++++++++++++++++
 mm/memory.c                         |    2 
 14 files changed, 2614 insertions(+), 1 deletion(-)

--- linux-cg.orig/Documentation/filesystems/spufs.txt	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/Documentation/filesystems/spufs.txt	2005-08-25 22:15:10.902980544 -0400
@@ -0,0 +1,107 @@
+              *** The SPU file system ***
+
+Spufs is used to run code on the Synergistic Processing Units
+of the Cell Processor (a.k.a Broadband Engine).
+
+The file system provides a name space similar to posix shared
+memory or message queues. Users that have write permissions
+on the file system can create directories in the spufs root.
+
+Every directory represents an SPU context, which is currently
+mapped to a physical SPU, but that is going to change to a
+virtualization scheme in future updates.
+
+An SPU context directory contains a predefined set of files
+used for manipulating the state of the logical SPU. Users
+can change permissions on those files, but not actually
+add or remove files without removing the complete directory.
+
+The current set of files is:
+
+/mem	the contents of the local store memory of the SPU.
+	This can be accessed like a regular shared memory
+	file and contains both code and data in the address
+	space of the SPU.
+	The implemented file operations currently are read(),
+	write() and mmap(). We will need our own address
+	space operations as soon as we allow the SPU context
+	to be scheduled away from the physical SPU into
+	page cache.
+
+/run	A stub file that lets us do the spu_run() call.
+	spu_run suspends the current thread from the host
+	CPU and transfers the flow of execution to the SPU.
+	The spu_run call returns to the calling thread when a
+	state is entered that can not be handled by the kernel,
+	e.g.  an error in the SPU code or an exit() from it.
+	When a signal is pending for the host CPU thread, the
+	ioctl is interrupted and the SPU stopped in order to
+	call the signal handler.
+	Currently, there are three different methods how
+	spu_run can be entered with the /run file:
+	- The spu_run() syscall (see other patch)
+	- ioctl(), as used in previous versions
+	- read(), to return only the status, while the npc
+	  is updated in kernel or through the /npc file.
+	Very likely, the concept of the /run file will change
+	in the near future and it will be replaced with
+	something completely different.
+
+/mbox	The first SPU to CPU communication mailbox. This file
+	is read-only and can be read in units of 32 bits.
+	The file can only be used in non-blocking mode and
+	it even poll() will not block on it.
+	When no data is available in the mailbox, read() returns
+	EAGAIN.
+
+/ibox	The second SPU to CPU communication mailbox. This file
+	is similar to the first mailbox file, but can be read
+	in blocking I/O mode, and the poll familiy of system
+	calls can be used to wait for it.
+
+/wbox	The CPU to SPU communation mailbox. It is write-only
+	can can be written in units of 32 bits. If the mailbox
+	is full, write() will block and poll can be used to
+	wait for it becoming empty again.
+
+/mbox_stat
+/ibox_stat
+/wbox_stat
+	Read-only files that contain the length of the current
+	queue, i.e. how many words can be read from mbox or
+	ibox or how many words can be written to wbox without
+	blocking.
+	The files can be read only in 4-byte units and return
+	a big-endian binary integer number.
+
+/npc	The next program counter of the SPU. The representation
+	is an ASCII string with the numeric value of the
+	next instruction to be executed. It can be used in
+	read/write mode.
+
+/signal1
+/signal2
+	The two signal notification channels of an SPU. These
+	are read-write files that operate on a 32 bit word,
+	similar to the npc file.
+	Writing to one of these files triggers an interrupt on
+	the SPU. The value writting to the signal files can
+	be read from the SPU through a channel read or from
+	host user space through the file.
+	After the value has been read by the SPU, it is reset
+	to zero.
+
+/signal1_type
+/signal2_type
+	These two files change the behavior of the signal1 and
+	signal2 notification files. The contain a numerical
+	ASCII string which is read as either "1" or "0".
+	In mode 0 (overwrite), the hardware replaces the contents
+	of the signal channel with the data that is written to it.
+	in mode 1 (logical OR), the hardware accumulates the bits
+	that are subsequently written to it.
+
+There are also a number of files that are only there for
+debugging purposes and give low-level access to hardware
+registers of an SPE. These will certainly go away and
+should not be considered official interfaces.
--- linux-cg.orig/arch/ppc64/kernel/Makefile	2005-08-25 22:08:05.354980224 -0400
+++ linux-cg/arch/ppc64/kernel/Makefile	2005-08-25 22:20:30.523977744 -0400
@@ -53,6 +53,7 @@ obj-$(CONFIG_HVCS)		+= hvcserver.o
 obj-$(CONFIG_IBMVIO)		+= vio.o
 obj-$(CONFIG_XICS)		+= xics.o
 obj-$(CONFIG_MPIC)		+= mpic.o
+obj-$(CONFIG_SPU_FS)		+= spu_base.o
 
 obj-$(CONFIG_PPC_PMAC)		+= pmac_setup.o pmac_feature.o pmac_pci.o \
 				   pmac_time.o pmac_nvram.o pmac_low_i2c.o
--- linux-cg.orig/arch/ppc64/kernel/spu_base.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/arch/ppc64/kernel/spu_base.c	2005-08-25 22:27:19.502976744 -0400
@@ -0,0 +1,733 @@
+/*
+ * Low-level SPU handling
+ *
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
+ *
+ * Author: Arnd Bergmann <arndb@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#define DEBUG 1
+
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/ptrace.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/semaphore.h>
+#include <asm/spu.h>
+#include <asm/mmu_context.h>
+
+#include "bpa_iic.h"
+
+static int __spu_trap_invalid_dma(struct spu *spu)
+{
+	pr_debug("%s\n", __FUNCTION__);
+	force_sig(SIGBUS, /* info, */ current);
+	return 0;
+}
+
+static int __spu_trap_dma_align(struct spu *spu)
+{
+	pr_debug("%s\n", __FUNCTION__);
+	force_sig(SIGBUS, /* info, */ current);
+	return 0;
+}
+
+static int __spu_trap_error(struct spu *spu)
+{
+	pr_debug("%s\n", __FUNCTION__);
+	force_sig(SIGILL, /* info, */ current);
+	return 0;
+}
+
+static void spu_restart_dma(struct spu *spu)
+{
+	struct spu_priv2 __iomem *priv2 = spu->priv2;
+	out_be64(&priv2->mfc_control_RW, MFC_CNTL_RESTART_DMA_COMMAND);
+}
+
+static int __spu_trap_data_seg(struct spu *spu, unsigned long ea)
+{
+	struct spu_priv2 __iomem *priv2;
+	struct mm_struct *mm;
+
+	pr_debug("%s\n", __FUNCTION__);
+
+	if (REGION_ID(ea) != USER_REGION_ID) {
+		pr_debug("invalid region access at %016lx\n", ea);
+		return 1;
+	}
+
+	priv2 = spu->priv2;
+	mm = spu->mm;
+
+	if (spu->slb_replace >= 8)
+		spu->slb_replace = 0;
+
+	out_be64(&priv2->slb_index_W, spu->slb_replace);
+	out_be64(&priv2->slb_vsid_RW,
+		(get_vsid(mm->context.id, ea) << SLB_VSID_SHIFT)
+						 | SLB_VSID_USER);
+	out_be64(&priv2->slb_esid_RW, (ea & ESID_MASK) | SLB_ESID_V);
+
+	spu_restart_dma(spu);
+
+	pr_debug("set slb %d context %lx, ea %016lx, vsid %016lx, esid %016lx\n",
+		spu->slb_replace, mm->context.id, ea,
+		(get_vsid(mm->context.id, ea) << SLB_VSID_SHIFT)| SLB_VSID_USER,
+		 (ea & ESID_MASK) | SLB_ESID_V);
+	return 0;
+}	
+
+static int __spu_trap_data_map(struct spu *spu, unsigned long ea)
+{
+	unsigned long dsisr;
+	struct spu_priv1 __iomem *priv1;
+
+	pr_debug("%s\n", __FUNCTION__);
+	priv1 = spu->priv1;
+	dsisr = in_be64(&priv1->mfc_dsisr_RW);
+
+	wake_up(&spu->stop_wq);
+
+	return 0;
+}
+
+static int __spu_trap_mailbox(struct spu *spu)
+{
+	wake_up_all(&spu->ibox_wq);
+
+	/* atomically disable SPU mailbox interrupts */
+	spin_lock(&spu->register_lock);
+	out_be64(&spu->priv1->int_mask_class2_RW,
+		in_be64(&spu->priv1->int_mask_class2_RW) & ~0x1);
+	spin_unlock(&spu->register_lock);
+	return 0;
+}
+
+static int __spu_trap_stop(struct spu *spu)
+{
+	pr_debug("%s\n", __FUNCTION__);
+	spu->stop_code = in_be32(&spu->problem->spu_status_R);
+	wake_up(&spu->stop_wq);
+	return 0;
+}
+
+static int __spu_trap_halt(struct spu *spu)
+{
+	pr_debug("%s\n", __FUNCTION__);
+	spu->stop_code = in_be32(&spu->problem->spu_status_R);
+	wake_up(&spu->stop_wq);
+	return 0;
+}
+
+static int __spu_trap_tag_group(struct spu *spu)
+{
+	pr_debug("%s\n", __FUNCTION__);
+	/* wake_up(&spu->dma_wq); */
+	return 0;
+}
+
+static int __spu_trap_spubox(struct spu *spu)
+{
+	wake_up_all(&spu->wbox_wq);
+
+	/* atomically disable SPU mailbox interrupts */
+	spin_lock(&spu->register_lock);
+	out_be64(&spu->priv1->int_mask_class2_RW,
+		in_be64(&spu->priv1->int_mask_class2_RW) & ~0x10);
+	spin_unlock(&spu->register_lock);
+	return 0;
+}
+
+static irqreturn_t
+spu_irq_class_0(int irq, void *data, struct pt_regs *regs)
+{
+	struct spu *spu;
+	
+	spu = data;
+	spu->class_0_pending = 1;
+	wake_up(&spu->stop_wq);
+
+	return IRQ_HANDLED;
+}
+
+static int
+spu_irq_class_0_bottom(struct spu *spu)
+{
+	unsigned long stat;
+
+	spu->class_0_pending = 0;
+
+	stat = in_be64(&spu->priv1->int_stat_class0_RW);
+
+	if (stat & 1) /* invalid MFC DMA */
+		__spu_trap_invalid_dma(spu);
+
+	if (stat & 2) /* invalid DMA alignment */
+		__spu_trap_dma_align(spu);
+
+	if (stat & 4) /* error on SPU */
+		__spu_trap_error(spu);
+
+	out_be64(&spu->priv1->int_stat_class0_RW, stat);
+	return 0;
+}
+
+static irqreturn_t
+spu_irq_class_1(int irq, void *data, struct pt_regs *regs)
+{
+	struct spu *spu;
+	unsigned long stat, dar;
+
+	spu = data;
+	stat  = in_be64(&spu->priv1->int_stat_class1_RW);
+	dar   = in_be64(&spu->priv1->mfc_dar_RW);
+
+	if (stat & 1) /* segment fault */
+		__spu_trap_data_seg(spu, dar);
+
+	if (stat & 2) { /* mapping fault */
+		__spu_trap_data_map(spu, dar);
+	}
+
+	if (stat & 4) /* ls compare & suspend on get */
+		;
+
+	if (stat & 8) /* ls compare & suspend on put */
+		;
+
+	out_be64(&spu->priv1->int_stat_class1_RW, stat);
+	return stat ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static irqreturn_t
+spu_irq_class_2(int irq, void *data, struct pt_regs *regs)
+{
+	struct spu *spu;
+	unsigned long stat;
+
+	spu = data;
+	stat = in_be64(&spu->priv1->int_stat_class2_RW);
+
+	pr_debug("class 2 interrupt %d, %lx, %lx\n", irq, stat,
+		in_be64(&spu->priv1->int_mask_class2_RW));
+	
+
+	if (stat & 1)  /* PPC core mailbox */
+		__spu_trap_mailbox(spu);
+
+	if (stat & 2) /* SPU stop-and-signal */
+		__spu_trap_stop(spu);
+
+	if (stat & 4) /* SPU halted */
+		__spu_trap_halt(spu);
+
+	if (stat & 8) /* DMA tag group complete */
+		__spu_trap_tag_group(spu);
+
+	if (stat & 0x10) /* SPU mailbox threshold */
+		__spu_trap_spubox(spu);
+
+	out_be64(&spu->priv1->int_stat_class2_RW, stat);
+	return stat ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static int
+spu_request_irqs(struct spu *spu)
+{
+	int ret;
+	int irq_base;
+
+	irq_base = IIC_NODE_STRIDE * spu->node + IIC_SPE_OFFSET;
+
+	snprintf(spu->irq_c0, sizeof (spu->irq_c0), "spe%02d.0", spu->number);
+	ret = request_irq(irq_base + spu->isrc,
+		 spu_irq_class_0, 0, spu->irq_c0, spu);
+	if (ret)
+		goto out;
+	out_be64(&spu->priv1->int_mask_class0_RW, 0x7);
+	
+	snprintf(spu->irq_c1, sizeof (spu->irq_c1), "spe%02d.1", spu->number);
+	ret = request_irq(irq_base + IIC_CLASS_STRIDE + spu->isrc,
+		 spu_irq_class_1, 0, spu->irq_c1, spu);
+	if (ret)
+		goto out1;
+	out_be64(&spu->priv1->int_mask_class1_RW, 0x3);
+
+	snprintf(spu->irq_c2, sizeof (spu->irq_c2), "spe%02d.2", spu->number);
+	ret = request_irq(irq_base + 2*IIC_CLASS_STRIDE + spu->isrc,
+		 spu_irq_class_2, 0, spu->irq_c2, spu);
+	if (ret)
+		goto out2;
+	out_be64(&spu->priv1->int_mask_class2_RW, 0xe);
+	goto out;
+
+out2:
+	free_irq(irq_base + IIC_CLASS_STRIDE + spu->isrc, spu);
+out1:
+	free_irq(irq_base + spu->isrc, spu);
+out:
+	return ret;
+}
+
+static void
+spu_free_irqs(struct spu *spu)
+{
+	int irq_base;
+
+	irq_base = IIC_NODE_STRIDE * spu->node + IIC_SPE_OFFSET;
+
+	free_irq(irq_base + spu->isrc, spu);
+	free_irq(irq_base + IIC_CLASS_STRIDE + spu->isrc, spu);
+	free_irq(irq_base + 2*IIC_CLASS_STRIDE + spu->isrc, spu);
+}
+
+static LIST_HEAD(spu_list);
+static DECLARE_MUTEX(spu_mutex);
+
+static void spu_init_channels(struct spu *spu)
+{
+	static const struct {
+		 unsigned channel;
+		 unsigned count;
+	} zero_list[] = {
+		{ 0x00, 1, }, { 0x01, 1, }, { 0x03, 1, }, { 0x04, 1, },
+		{ 0x18, 1, }, { 0x19, 1, }, { 0x1b, 1, }, { 0x1d, 1, },
+	}, count_list[] = {
+		{ 0x00, 0, }, { 0x03, 0, }, { 0x04, 0, }, { 0x15, 16, },
+		{ 0x17, 1, }, { 0x18, 0, }, { 0x19, 0, }, { 0x1b, 0, },
+		{ 0x1c, 1, }, { 0x1d, 0, }, { 0x1e, 1, },
+	};
+	struct spu_priv2 *priv2;
+	int i;
+
+	priv2 = spu->priv2;
+
+	/* initialize all channel data to zero */
+	for (i = 0; i < ARRAY_SIZE(zero_list); i++) {
+		int count;
+
+		out_be64(&priv2->spu_chnlcntptr_RW, zero_list[i].channel);
+		for (count = 0; count < zero_list[i].count; count++)
+			out_be64(&priv2->spu_chnldata_RW, 0);
+	}
+
+	/* initialize channel counts to meaningful values */
+	for (i = 0; i < ARRAY_SIZE(count_list); i++) {
+		out_be64(&priv2->spu_chnlcntptr_RW, count_list[i].channel);
+		out_be64(&priv2->spu_chnlcnt_RW, count_list[i].count);
+	}
+}
+
+static void spu_init_regs(struct spu *spu)
+{
+	out_be64(&spu->priv1->int_mask_class0_RW, 0x7);
+	out_be64(&spu->priv1->int_mask_class1_RW, 0x3);
+	out_be64(&spu->priv1->int_mask_class2_RW, 0xe);
+}
+
+struct spu *spu_alloc(void)
+{
+	struct spu *spu;
+
+	down(&spu_mutex);
+	if (!list_empty(&spu_list)) {
+		spu = list_entry(spu_list.next, struct spu, list);
+		list_del_init(&spu->list);
+		pr_debug("Got SPU %x %d\n", spu->isrc, spu->number);
+	} else {
+		pr_debug("No SPU left\n");
+		spu = NULL;
+	}
+	up(&spu_mutex);
+
+	if (spu) {
+		spu_init_channels(spu);
+		spu_init_regs(spu);
+	}
+
+	return spu;
+}
+EXPORT_SYMBOL(spu_alloc);
+
+void spu_free(struct spu *spu)
+{
+	down(&spu_mutex);
+	list_add_tail(&spu->list, &spu_list);
+	up(&spu_mutex);
+}
+EXPORT_SYMBOL(spu_free);
+
+extern int hash_page(unsigned long ea, unsigned long access, unsigned long trap); //XXX
+static int spu_handle_mm_fault(struct spu *spu)
+{
+	struct spu_priv1 __iomem *priv1;
+	struct mm_struct *mm = spu->mm;
+	struct vm_area_struct *vma;
+	u64 ea, dsisr, is_write;
+	int ret;
+
+	priv1 = spu->priv1;
+	ea = in_be64(&priv1->mfc_dar_RW);
+	dsisr = in_be64(&priv1->mfc_dsisr_RW);
+#if 0
+	if (!IS_VALID_EA(ea)) {
+		return -EFAULT;
+	}
+#endif /* XXX */
+	if (mm == NULL) {
+		return -EFAULT;
+	}
+	if (mm->pgd == NULL) {
+		return -EFAULT;
+	}
+
+	down_read(&mm->mmap_sem);
+	vma = find_vma(mm, ea);
+	if (!vma)
+		goto bad_area;
+	if (vma->vm_start <= ea)
+		goto good_area;
+	if (!(vma->vm_flags & VM_GROWSDOWN))
+		goto bad_area;
+#if 0
+	if (expand_stack(vma, ea))
+		goto bad_area;
+#endif /* XXX */
+good_area:
+	is_write = dsisr & MFC_DSISR_ACCESS_PUT;
+	if (is_write) {
+		if (!(vma->vm_flags & VM_WRITE))
+			goto bad_area;
+	} else {
+		if (dsisr & MFC_DSISR_ACCESS_DENIED)
+			goto bad_area;
+		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
+			goto bad_area;
+	}
+	ret = 0;
+	switch (handle_mm_fault(mm, vma, ea, is_write)) {
+	case VM_FAULT_MINOR:
+		current->min_flt++;
+		break;
+	case VM_FAULT_MAJOR:
+		current->maj_flt++;
+		break;
+	case VM_FAULT_SIGBUS:
+		ret = -EFAULT;
+		goto bad_area;
+	case VM_FAULT_OOM:
+		ret = -ENOMEM;
+		goto bad_area;
+	default:
+		BUG();
+	}
+	up_read(&mm->mmap_sem);
+	return ret;
+
+bad_area:
+	up_read(&mm->mmap_sem);
+	return -EFAULT;
+}
+
+static int spu_handle_pte_fault(struct spu *spu)
+{
+	struct spu_priv1 __iomem *priv1;
+	u64 ea, dsisr, access, error = 0UL;
+	int ret = 0;
+
+	priv1 = spu->priv1;
+	ea = in_be64(&priv1->mfc_dar_RW);
+	dsisr = in_be64(&priv1->mfc_dsisr_RW);
+	access = (_PAGE_PRESENT | _PAGE_USER);
+	if (dsisr & MFC_DSISR_PTE_NOT_FOUND) {
+		if (hash_page(ea, access, 0x300) != 0)
+			error |= CLASS1_ENABLE_STORAGE_FAULT_INTR;
+	}
+	if ((error & CLASS1_ENABLE_STORAGE_FAULT_INTR) ||
+	    (dsisr & MFC_DSISR_ACCESS_DENIED)) {
+		if ((ret = spu_handle_mm_fault(spu)) != 0)
+			error |= CLASS1_ENABLE_STORAGE_FAULT_INTR;
+		else
+			error &= ~CLASS1_ENABLE_STORAGE_FAULT_INTR;
+	}
+	if (!error)
+		spu_restart_dma(spu);
+
+	return ret;
+}
+
+int spu_run(struct spu *spu)
+{
+	struct spu_problem __iomem *prob;
+	struct spu_priv1 __iomem *priv1;
+	struct spu_priv2 __iomem *priv2;
+	unsigned long status;
+	int ret;
+
+	prob = spu->problem;
+	priv1 = spu->priv1;
+	priv2 = spu->priv2;
+
+	/* Let SPU run.  */
+	spu->mm = current->mm;
+	eieio();
+	out_be32(&prob->spu_runcntl_RW, SPU_RUNCNTL_RUNNABLE);
+
+	do {	
+		ret = wait_event_interruptible(spu->stop_wq,
+			 (!((status = in_be32(&prob->spu_status_R)) & 0x1))
+			|| (in_be64(&priv1->mfc_dsisr_RW) & MFC_DSISR_PTE_NOT_FOUND)
+			|| spu->class_0_pending);
+
+		if (status & SPU_STATUS_STOPPED_BY_STOP)
+			ret = -EAGAIN;
+		else if (status & SPU_STATUS_STOPPED_BY_HALT)
+			ret = -EIO;
+		else if (in_be64(&priv1->mfc_dsisr_RW) & MFC_DSISR_PTE_NOT_FOUND)
+			ret = spu_handle_pte_fault(spu);
+
+		if (spu->class_0_pending)
+			spu_irq_class_0_bottom(spu);
+
+		if (!ret && signal_pending(current))
+			ret = -ERESTARTSYS;
+
+	} while (!ret);
+
+	/* Ensure SPU is stopped.  */
+	out_be32(&prob->spu_runcntl_RW, SPU_RUNCNTL_STOP);
+	eieio();
+	while (in_be32(&prob->spu_status_R) & SPU_STATUS_RUNNING)
+		cpu_relax();
+
+	out_be64(&priv2->slb_invalidate_all_W, 0);
+	out_be64(&priv1->tlb_invalidate_entry_W, 0UL);
+	eieio();
+
+	spu->mm = NULL;
+
+	/* Check for SPU breakpoint.  */
+	if (unlikely(current->ptrace & PT_PTRACED)) {
+		status = in_be32(&prob->spu_status_R);
+
+		if ((status & SPU_STATUS_STOPPED_BY_STOP)
+		    && status >> SPU_STOP_STATUS_SHIFT == 0x3fff) {
+			force_sig(SIGTRAP, current);
+			ret = -ERESTARTSYS;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(spu_run);
+
+static void __iomem * __init map_spe_prop(struct device_node *n,
+						 const char *name)
+{
+	struct address_prop {
+		unsigned long address;
+		unsigned int len;
+	} __attribute__((packed)) *prop;
+
+	void *p;
+	int proplen;
+	
+	p = get_property(n, name, &proplen);
+	if (proplen != sizeof (struct address_prop))
+		return NULL;
+
+	prop = p;
+
+	return ioremap(prop->address, prop->len);
+}
+
+static void spu_unmap(struct spu *spu)
+{
+	iounmap(spu->priv2);
+	iounmap(spu->priv1);
+	iounmap(spu->problem);
+	iounmap((u8 __iomem *)spu->local_store);
+}
+
+static int __init spu_map_device(struct spu *spu, struct device_node *spe)
+{
+	char *prop;
+	int ret;
+
+	ret = -ENODEV;
+	prop = get_property(spe, "isrc", NULL);
+	if (!prop)
+		goto out;
+	spu->isrc = *(unsigned int *)prop;
+
+	spu->name = get_property(spe, "name", NULL);
+	if (!spu->name)
+		goto out;
+
+	prop = get_property(spe, "local-store", NULL);
+	if (!prop)
+		goto out;
+	spu->local_store_phys = *(unsigned long *)prop;
+
+	/* we use local store as ram, not io memory */
+	spu->local_store = (void __force *)map_spe_prop(spe, "local-store");
+	if (!spu->local_store)
+		goto out;
+
+	spu->problem= map_spe_prop(spe, "problem");
+	if (!spu->problem)
+		goto out_unmap;
+
+	spu->priv1= map_spe_prop(spe, "priv1");
+	if (!spu->priv1)
+		goto out_unmap;
+
+	spu->priv2= map_spe_prop(spe, "priv2");
+	if (!spu->priv2)
+		goto out_unmap;
+	ret = 0;
+	goto out;
+	
+out_unmap:
+	spu_unmap(spu);
+out:
+	return ret;
+}
+
+static int __init find_spu_node_id(struct device_node *spe)
+{
+	unsigned int *id;
+	struct device_node *cpu;
+
+	cpu = spe->parent->parent;
+	id = (unsigned int *)get_property(cpu, "node-id", NULL);
+
+	return id ? *id : 0;
+}
+
+static int __init create_spu(struct device_node *spe)
+{
+	struct spu *spu;
+	int ret;
+	static int number;
+
+	ret = -ENOMEM;
+	spu = kmalloc(sizeof (*spu), GFP_KERNEL);
+	if (!spu)
+		goto out;
+
+	ret = spu_map_device(spu, spe);
+	if (ret)
+		goto out_free;
+
+	spu->node = find_spu_node_id(spe);
+	spu->stop_code = 0;
+	spu->slb_replace = 0;
+	spu->mm = NULL;
+	spu->class_0_pending = 0;
+	spin_lock_init(&spu->register_lock);
+
+	out_be64(&spu->priv1->mfc_sdr_RW, mfspr(SPRN_SDR1));
+	out_be64(&spu->priv1->mfc_sr1_RW, 0x33);
+
+	init_waitqueue_head(&spu->stop_wq);
+	init_waitqueue_head(&spu->wbox_wq);
+	init_waitqueue_head(&spu->ibox_wq);
+
+	down(&spu_mutex);
+	spu->number = number++;
+	ret = spu_request_irqs(spu);
+	if (ret)
+		goto out_unmap;
+
+	list_add(&spu->list, &spu_list);
+	up(&spu_mutex);
+
+	pr_debug(KERN_DEBUG "Using SPE %s %02x %p %p %p %p %d\n",
+		spu->name, spu->isrc, spu->local_store,
+		spu->problem, spu->priv1, spu->priv2, spu->number);
+	goto out;
+
+out_unmap:
+	up(&spu_mutex);
+	spu_unmap(spu);
+out_free:
+	kfree(spu);
+out:
+	return ret;
+}
+
+static void destroy_spu(struct spu *spu)
+{
+	list_del_init(&spu->list);
+
+	spu_free_irqs(spu);
+	spu_unmap(spu);
+	kfree(spu);
+}
+
+static void cleanup_spu_base(void)
+{
+	struct spu *spu, *tmp;
+	down(&spu_mutex);
+	list_for_each_entry_safe(spu, tmp, &spu_list, list)
+		destroy_spu(spu);
+	up(&spu_mutex);
+}
+module_exit(cleanup_spu_base);
+
+static int __init init_spu_base(void)
+{
+	struct device_node *node;
+	int ret;
+
+	ret = -ENODEV;
+	for (node = of_find_node_by_type(NULL, "spe");
+			node; node = of_find_node_by_type(node, "spe")) {
+		ret = create_spu(node);
+		if (ret) {
+			printk(KERN_WARNING "%s: Error initializing %s\n",
+				__FUNCTION__, node->name);
+			cleanup_spu_base();
+			break;
+		}
+	}
+	/* in some old firmware versions, the spe is called 'spc', so we
+	   look for that as well */
+	for (node = of_find_node_by_type(NULL, "spc");
+			node; node = of_find_node_by_type(node, "spc")) {
+		ret = create_spu(node);
+		if (ret) {
+			printk(KERN_WARNING "%s: Error initializing %s\n",
+				__FUNCTION__, node->name);
+			cleanup_spu_base();
+			break;
+		}
+	}
+	return ret;
+}
+module_init(init_spu_base);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Arnd Bergmann <arndb@de.ibm.com>");
--- linux-cg.orig/arch/ppc64/mm/hash_utils.c	2005-08-25 22:08:05.359979464 -0400
+++ linux-cg/arch/ppc64/mm/hash_utils.c	2005-08-25 22:15:10.906979936 -0400
@@ -354,6 +354,7 @@ int hash_page(unsigned long ea, unsigned
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(hash_page);
 
 void flush_hash_page(unsigned long context, unsigned long ea, pte_t pte,
 		     int local)
--- linux-cg.orig/fs/Kconfig	2005-08-25 22:08:05.361979160 -0400
+++ linux-cg/fs/Kconfig	2005-08-25 22:15:10.908979632 -0400
@@ -845,6 +845,16 @@ config HUGETLBFS
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
 
+config SPU_FS
+	tristate "SPU file system"
+	default m
+	depends on PPC_BPA
+	help
+	  The SPU file system is used to access Synergistic Processing
+	  Units on machines implementing the Broadband Processor
+	  Architecture.
+	
+
 config RAMFS
 	bool
 	default y
--- linux-cg.orig/fs/Makefile	2005-08-25 22:08:05.363978856 -0400
+++ linux-cg/fs/Makefile	2005-08-25 22:15:10.908979632 -0400
@@ -98,3 +98,4 @@ obj-$(CONFIG_BEFS_FS)		+= befs/
 obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_HPPFS)		+= hppfs/
 obj-$(CONFIG_DEBUG_FS)		+= debugfs/
+obj-$(CONFIG_SPU_FS)		+= spufs/
--- linux-cg.orig/fs/spufs/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/fs/spufs/Makefile	2005-08-25 22:20:31.628941784 -0400
@@ -0,0 +1,3 @@
+obj-$(CONFIG_SPU_FS) += spufs.o
+
+spufs-y += inode.o file.o context.o
--- linux-cg.orig/fs/spufs/context.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/fs/spufs/context.c	2005-08-25 22:20:31.631941328 -0400
@@ -0,0 +1,67 @@
+/*
+ * SPU file system -- SPU context management
+ *
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
+ *
+ * Author: Arnd Bergmann <arndb@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/slab.h>
+#include <asm/spu.h>
+#include "spufs.h"
+
+struct spu_context *alloc_spu_context(void)
+{
+	struct spu_context *ctx;
+	ctx = kmalloc(sizeof *ctx, GFP_KERNEL);
+	if (!ctx)
+		goto out;
+	ctx->spu = spu_alloc();
+	if (!ctx->spu)
+		goto out_free;
+	init_rwsem(&ctx->backing_sema);
+	spin_lock_init(&ctx->mmio_lock);
+	kref_init(&ctx->kref);
+	goto out;
+out_free:
+	kfree(ctx);
+	ctx = NULL;
+out:
+	return ctx;
+}
+
+void destroy_spu_context(struct kref *kref)
+{
+	struct spu_context *ctx;
+	ctx = container_of(kref, struct spu_context, kref);
+	if (ctx->spu)
+		spu_free(ctx->spu);
+	kfree(ctx);
+}
+
+struct spu_context * get_spu_context(struct spu_context *ctx)
+{
+	kref_get(&ctx->kref);
+	return ctx;
+}
+
+void put_spu_context(struct spu_context *ctx)
+{
+	kref_put(&ctx->kref, &destroy_spu_context);
+}
+
+
--- linux-cg.orig/fs/spufs/file.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/fs/spufs/file.c	2005-08-25 22:27:19.503976592 -0400
@@ -0,0 +1,716 @@
+/*
+ * SPU file system -- file contents
+ *
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
+ *
+ * Author: Arnd Bergmann <arndb@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/fs.h>
+#include <linux/ioctl.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+
+#include <asm/io.h>
+#include <asm/semaphore.h>
+#include <asm/spu.h>
+#include <asm/uaccess.h>
+
+#include "spufs.h"
+
+static int
+spufs_mem_open(struct inode *inode, struct file *file)
+{
+	struct spufs_inode_info *i = SPUFS_I(inode);
+	file->private_data = i->i_ctx;
+	return 0;
+}
+
+static ssize_t
+spufs_mem_read(struct file *file, char __user *buffer,
+				size_t size, loff_t *pos)
+{
+	struct spu *spu;
+	struct spu_context *ctx;
+	int ret;
+
+	ctx = file->private_data;
+	spu = ctx->spu;
+
+	down_read(&ctx->backing_sema);
+	if (spu->number & 0/*1*/) {
+		ret = generic_file_read(file, buffer, size, pos);
+		goto out;
+	}
+
+	ret = simple_read_from_buffer(buffer, size, pos,
+					spu->local_store, LS_SIZE);
+out:
+	up_read(&ctx->backing_sema);
+	return ret;
+}
+
+static ssize_t
+spufs_mem_write(struct file *file, const char __user *buffer,
+					size_t size, loff_t *pos)
+{
+	struct spu_context *ctx = file->private_data;
+	struct spu *spu = ctx->spu;
+
+	if (spu->number & 0) //1)
+		return generic_file_write(file, buffer, size, pos);
+
+	size = min_t(ssize_t, LS_SIZE - *pos, size);
+	if (size <= 0)
+		return -EFBIG;
+	*pos += size;
+	return copy_from_user(spu->local_store + *pos - size,
+				buffer, size) ? -EFAULT : size;
+}
+
+static int
+spufs_mem_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct spu_context *ctx = file->private_data;
+	struct spu *spu = ctx->spu;
+	unsigned long pfn;
+
+	if (spu->number & 0) //1)
+		return generic_file_mmap(file, vma);
+
+	vma->vm_flags |= VM_RESERVED;
+	vma->vm_page_prot = __pgprot(pgprot_val (vma->vm_page_prot)
+							| _PAGE_NO_CACHE);
+	pfn = spu->local_store_phys >> PAGE_SHIFT;
+	/*
+	 * This will work for actual SPUs, but not for vmalloc memory:
+	 */
+	if (remap_pfn_range(vma, vma->vm_start, pfn,
+				vma->vm_end-vma->vm_start, vma->vm_page_prot))
+		return -EAGAIN;
+	return 0;
+}
+
+static struct file_operations spufs_mem_fops = {
+	.open	 = spufs_mem_open,
+	.read    = spufs_mem_read,
+	.write   = spufs_mem_write,
+	.mmap    = spufs_mem_mmap,
+	.llseek  = generic_file_llseek,
+};
+
+/* generic open function for all pipe-like files */
+static int spufs_pipe_open(struct inode *inode, struct file *file)
+{
+	struct spufs_inode_info *i = SPUFS_I(inode);
+	file->private_data = i->i_ctx;
+
+	return nonseekable_open(inode, file);
+}
+
+static ssize_t spufs_mbox_read(struct file *file, char __user *buf,
+			size_t len, loff_t *pos)
+{
+	struct spu_context *ctx;
+	struct spu_problem __iomem *prob;
+	u32 mbox_stat;
+	u32 mbox_data;
+
+	if (len < 4)
+		return -EINVAL;
+
+	ctx = file->private_data;
+	prob = ctx->spu->problem;
+	mbox_stat = in_be32(&prob->mb_stat_R);
+	if (!(mbox_stat & 0x0000ff))
+		return -EAGAIN;
+
+	mbox_data = in_be32(&prob->pu_mb_R);
+
+	if (copy_to_user(buf, &mbox_data, sizeof mbox_data))
+		return -EFAULT;
+
+	return 4;
+}
+
+static struct file_operations spufs_mbox_fops = {
+	.open	= spufs_pipe_open,
+	.read	= spufs_mbox_read,
+};
+
+static ssize_t spufs_mbox_stat_read(struct file *file, char __user *buf,
+			size_t len, loff_t *pos)
+{
+	struct spu_context *ctx;
+	u32 mbox_stat;
+
+	if (len < 4)
+		return -EINVAL;
+
+	ctx = file->private_data;
+	mbox_stat = in_be32(&ctx->spu->problem->mb_stat_R) & 0xff;
+
+	if (copy_to_user(buf, &mbox_stat, sizeof mbox_stat))
+		return -EFAULT;
+
+	return 4;
+}
+
+static struct file_operations spufs_mbox_stat_fops = {
+	.open	= spufs_pipe_open,
+	.read	= spufs_mbox_stat_read,
+};
+
+/* low-level ibox access function */
+size_t spu_ibox_read(struct spu *spu, u32 *data)
+{
+	int ret;
+
+	spin_lock_irq(&spu->register_lock);
+
+	if (in_be32(&spu->problem->mb_stat_R) & 0xff0000) {
+		/* read the first available word */
+		*data = in_be64(&spu->priv2->puint_mb_R);
+		ret = 4;
+	} else {
+		/* make sure we get woken up by the interrupt */
+		out_be64(&spu->priv1->int_mask_class2_RW,
+			in_be64(&spu->priv1->int_mask_class2_RW) | 0x1);
+		ret = 0;
+	}
+
+	spin_unlock_irq(&spu->register_lock);
+	return ret;
+}
+EXPORT_SYMBOL(spu_ibox_read);
+
+static ssize_t spufs_ibox_read(struct file *file, char __user *buf,
+			size_t len, loff_t *pos)
+{
+	struct spu_context *ctx;
+	u32 ibox_data;
+	ssize_t ret;
+
+	if (len < 4)
+		return -EINVAL;
+
+	ctx = file->private_data;
+
+	ret = 0;
+	if (file->f_flags & O_NONBLOCK) {
+		if (!spu_ibox_read(ctx->spu, &ibox_data))
+			ret = -EAGAIN;
+	} else {
+		ret = wait_event_interruptible(ctx->spu->ibox_wq,
+				 spu_ibox_read(ctx->spu, &ibox_data));
+	}
+
+	if (ret)
+		return ret;
+
+	ret = 4;
+	if (copy_to_user(buf, &ibox_data, sizeof ibox_data))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+static unsigned int spufs_ibox_poll(struct file *file, poll_table *wait)
+{
+	struct spu_context *ctx;
+	struct spu_problem __iomem *prob;
+	u32 mbox_stat;
+	unsigned int mask;
+
+	ctx = file->private_data;
+	prob = ctx->spu->problem;
+	mbox_stat = in_be32(&prob->mb_stat_R);
+
+	poll_wait(file, &ctx->spu->ibox_wq, wait);
+
+	mask = 0;
+	if (mbox_stat & 0xff0000)
+		mask |= POLLIN | POLLRDNORM;
+
+	return mask;
+}
+
+static struct file_operations spufs_ibox_fops = {
+	.open	= spufs_pipe_open,
+	.read	= spufs_ibox_read,
+	.poll	= spufs_ibox_poll,
+};
+
+static ssize_t spufs_ibox_stat_read(struct file *file, char __user *buf,
+			size_t len, loff_t *pos)
+{
+	struct spu_context *ctx;
+	u32 ibox_stat;
+
+	if (len < 4)
+		return -EINVAL;
+
+	ctx = file->private_data;
+	ibox_stat = (in_be32(&ctx->spu->problem->mb_stat_R) >> 16) & 0xff;
+
+	if (copy_to_user(buf, &ibox_stat, sizeof ibox_stat))
+		return -EFAULT;
+
+	return 4;
+}
+
+static struct file_operations spufs_ibox_stat_fops = {
+	.open	= spufs_pipe_open,
+	.read	= spufs_ibox_stat_read,
+};
+
+/* low-level mailbox write */
+size_t spu_wbox_write(struct spu *spu, u32 data)
+{
+	int ret;
+
+	spin_lock_irq(&spu->register_lock);
+
+	if (in_be32(&spu->problem->mb_stat_R) & 0x00ff00) {
+		/* we have space to write wbox_data to */
+		out_be32(&spu->problem->spu_mb_W, data);
+		ret = 4;
+	} else {
+		/* make sure we get woken up by the interrupt when space
+		   becomes available */
+		out_be64(&spu->priv1->int_mask_class2_RW,
+			in_be64(&spu->priv1->int_mask_class2_RW) | 0x10);
+		ret = 0;
+	}
+
+	spin_unlock_irq(&spu->register_lock);
+	return ret;
+}
+EXPORT_SYMBOL(spu_wbox_write);
+
+static ssize_t spufs_wbox_write(struct file *file, const char __user *buf,
+			size_t len, loff_t *pos)
+{
+	struct spu_context *ctx;
+	u32 wbox_data;
+	int ret;
+
+	if (len < 4)
+		return -EINVAL;
+
+	ctx = file->private_data;
+
+	if (copy_from_user(&wbox_data, buf, sizeof wbox_data))
+		return -EFAULT;
+
+	ret = 0;
+	if (file->f_flags & O_NONBLOCK) {
+		if (!spu_wbox_write(ctx->spu, wbox_data))
+			ret = -EAGAIN;
+	} else {
+		ret = wait_event_interruptible(ctx->spu->wbox_wq,
+			spu_wbox_write(ctx->spu, wbox_data));
+	}
+
+	return ret ? ret : sizeof wbox_data;
+}
+
+static unsigned int spufs_wbox_poll(struct file *file, poll_table *wait)
+{
+	struct spu_context *ctx;
+	struct spu_problem __iomem *prob;
+	u32 mbox_stat;
+	unsigned int mask;
+
+	ctx = file->private_data;
+	prob = ctx->spu->problem;
+	mbox_stat = in_be32(&prob->mb_stat_R);
+
+	poll_wait(file, &ctx->spu->wbox_wq, wait);
+
+	mask = 0;
+	if (mbox_stat & 0x00ff00)
+		mask = POLLOUT | POLLWRNORM;
+
+	return mask;
+}
+
+static struct file_operations spufs_wbox_fops = {
+	.open	= spufs_pipe_open,
+	.write	= spufs_wbox_write,
+	.poll	= spufs_wbox_poll,
+};
+
+static ssize_t spufs_wbox_stat_read(struct file *file, char __user *buf,
+			size_t len, loff_t *pos)
+{
+	struct spu_context *ctx;
+	u32 wbox_stat;
+
+	if (len < 4)
+		return -EINVAL;
+
+	ctx = file->private_data;
+	wbox_stat = (in_be32(&ctx->spu->problem->mb_stat_R) >> 8) & 0xff;
+
+	if (copy_to_user(buf, &wbox_stat, sizeof wbox_stat))
+		return -EFAULT;
+
+	return 4;
+}
+
+static struct file_operations spufs_wbox_stat_fops = {
+	.open	= spufs_pipe_open,
+	.read	= spufs_wbox_stat_read,
+};
+
+static long spufs_run_spu(struct file *file, struct spu_context *ctx,
+		u32 *npc, u32 *status)
+{
+	struct spu_problem __iomem *prob;
+	int ret;
+
+	if (file->f_flags & O_NONBLOCK) {
+		ret = -EAGAIN;
+		if (!down_write_trylock(&ctx->backing_sema))
+			goto out;
+	} else {
+		down_write(&ctx->backing_sema);
+	}
+
+	prob = ctx->spu->problem;
+	out_be32(&prob->spu_npc_RW, *npc);
+
+	ret = spu_run(ctx->spu);
+
+	*status = in_be32(&prob->spu_status_R);
+	*npc = in_be32(&prob->spu_npc_RW);
+
+	up_write(&ctx->backing_sema);
+
+out:
+	return ret;
+}
+
+struct spufs_run_arg {
+	u32 npc;    /* inout: Next Program Counter */
+	u32 status; /* out:   SPU status */
+};
+
+static ssize_t spufs_run_read(struct file *file, char __user *buf,
+			size_t len, loff_t *pos)
+{
+	struct spu_context *ctx;
+	struct spufs_run_arg arg;
+	int ret;
+
+	ctx = file->private_data;
+
+	ret = -EINVAL;
+	if (len < 8)
+		goto out;
+
+	arg.npc = in_be32(&ctx->spu->problem->spu_npc_RW);
+
+	ret = spufs_run_spu(file, file->private_data, &arg.npc, &arg.status);
+	if (ret == -EAGAIN)
+		ret = 0;
+
+	if ((arg.status & 0xffff0002) == 0x21000002) {
+		/* library callout */
+		u32 npc = arg.npc;
+		arg.npc = *(u32*) (ctx->spu->local_store + npc);
+		npc += 4;
+		out_be32(&ctx->spu->problem->spu_npc_RW, npc);
+	}
+
+	if (ret)
+		goto out;
+
+	ret = 8;
+	if (copy_to_user(buf, &arg, 8))
+		ret = -EFAULT;
+
+out:
+	return ret;
+}
+
+/* either this ioctl function or the system call needs to die! */
+static long spufs_run_ioctl(struct file *file, unsigned int num,
+						unsigned long arg)
+{
+	struct spufs_run_arg data;
+	int ret;
+
+	if (num != _IOWR('s', 0, struct spufs_run_arg))
+		return -EINVAL;
+
+	if (copy_from_user(&data, (void __user *)arg, sizeof data))
+		return -EFAULT;
+
+	ret = spufs_run_spu(file, file->private_data,
+				&data.npc, &data.status);
+
+	if (copy_to_user((void __user *)arg, &data, sizeof data))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+static struct file_operations spufs_run_fops = {
+	.open		= spufs_pipe_open,
+	.unlocked_ioctl	= spufs_run_ioctl,
+	.compat_ioctl	= spufs_run_ioctl,
+	.read		= spufs_run_read,
+};
+
+static ssize_t spufs_signal1_read(struct file *file, char __user *buf,
+			size_t len, loff_t *pos)
+{
+	struct spu_context *ctx;
+	struct spu_problem *prob;
+	u32 data;
+
+	ctx = file->private_data;
+	prob = ctx->spu->problem;
+
+	if (len < 4)
+		return -EINVAL;
+
+	data = in_be32(&prob->signal_notify1);
+	if (copy_to_user(buf, &data, 4))
+		return -EFAULT;
+
+	return 4;
+}
+
+static ssize_t spufs_signal1_write(struct file *file, const char __user *buf,
+			size_t len, loff_t *pos)
+{
+	struct spu_context *ctx;
+	struct spu_problem *prob;
+	u32 data;
+
+	ctx = file->private_data;
+	prob = ctx->spu->problem;
+
+	if (len < 4)
+		return -EINVAL;
+
+	if (copy_from_user(&data, buf, 4))
+		return -EFAULT;
+
+	out_be32(&prob->signal_notify1, data);
+
+	return 4;
+}
+
+static struct file_operations spufs_signal1_fops = {
+	.open = spufs_pipe_open,
+	.read = spufs_signal1_read,
+	.write = spufs_signal1_write,
+};
+
+static ssize_t spufs_signal2_read(struct file *file, char __user *buf,
+			size_t len, loff_t *pos)
+{
+	struct spu_context *ctx;
+	struct spu_problem *prob;
+	u32 data;
+
+	ctx = file->private_data;
+	prob = ctx->spu->problem;
+
+	if (len < 4)
+		return -EINVAL;
+
+	data = in_be32(&prob->signal_notify2);
+	if (copy_to_user(buf, &data, 4))
+		return -EFAULT;
+
+	return 4;
+}
+
+static ssize_t spufs_signal2_write(struct file *file, const char __user *buf,
+			size_t len, loff_t *pos)
+{
+	struct spu_context *ctx;
+	struct spu_problem *prob;
+	u32 data;
+
+	ctx = file->private_data;
+	prob = ctx->spu->problem;
+
+	if (len < 4)
+		return -EINVAL;
+
+	if (copy_from_user(&data, buf, 4))
+		return -EFAULT;
+
+	out_be32(&prob->signal_notify2, data);
+
+	return 4;
+}
+
+static struct file_operations spufs_signal2_fops = {
+	.open = spufs_pipe_open,
+	.read = spufs_signal2_read,
+	.write = spufs_signal2_write,
+};
+
+static void spufs_signal1_type_set(void *data, u64 val)
+{
+	struct spu_context *ctx = data;
+	struct spu_priv2 *priv2 = ctx->spu->priv2;
+	u64 tmp;
+
+	spin_lock_irq(&ctx->spu->register_lock);
+	tmp = in_be64(&priv2->spu_cfg_RW);
+	if (val)
+		tmp |= 1;
+	else
+		tmp &= ~1;
+	out_be64(&priv2->spu_cfg_RW, tmp);
+	spin_unlock_irq(&ctx->spu->register_lock);
+}
+
+static u64 spufs_signal1_type_get(void *data)
+{
+	struct spu_context *ctx = data;
+	return (in_be64(&ctx->spu->priv2->spu_cfg_RW) & 1) != 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(spufs_signal1_type, spufs_signal1_type_get,
+					spufs_signal1_type_set, "%llu");
+
+static void spufs_signal2_type_set(void *data, u64 val)
+{
+	struct spu_context *ctx = data;
+	struct spu_priv2 *priv2 = ctx->spu->priv2;
+	u64 tmp;
+
+	spin_lock_irq(&ctx->spu->register_lock);
+	tmp = in_be64(&priv2->spu_cfg_RW);
+	if (val)
+		tmp |= 2;
+	else
+		tmp &= ~2;
+	out_be64(&priv2->spu_cfg_RW, tmp);
+	spin_unlock_irq(&ctx->spu->register_lock);
+}
+
+static u64 spufs_signal2_type_get(void *data)
+{
+	struct spu_context *ctx = data;
+	return (in_be64(&ctx->spu->priv2->spu_cfg_RW) & 2) != 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(spufs_signal2_type, spufs_signal2_type_get,
+					spufs_signal2_type_set, "%llu");
+
+#define prob_attr(name) 				\
+static void spufs_ ## name ## _set(void *data, u64 val) \
+{							\
+	struct spu_context *ctx = data; 		\
+	out_be32(&ctx->spu->problem->name, val);	\
+}						 	\
+static u64 spufs_ ## name ## _get(void *data)		\
+{							\
+	struct spu_context *ctx = data;			\
+	return in_be32(&ctx->spu->problem->name);	\
+}							\
+DEFINE_SIMPLE_ATTRIBUTE(spufs_ ## name, 		\
+	spufs_ ## name ## _get, 			\
+	spufs_ ## name ## _set, "%llx\n")
+
+#define priv1_attr(name) 				\
+static void spufs_ ## name ## _set(void *data, u64 val) \
+{							\
+	struct spu_context *ctx = data; 		\
+	out_be64(&ctx->spu->priv1->name, val);		\
+}						 	\
+static u64 spufs_ ## name ## _get(void *data)		\
+{							\
+	struct spu_context *ctx = data;			\
+	return in_be64(&ctx->spu->priv1->name);		\
+}							\
+DEFINE_SIMPLE_ATTRIBUTE(spufs_ ## name, 		\
+	spufs_ ## name ## _get, 			\
+	spufs_ ## name ## _set, "%llx\n")
+
+#define priv2_attr(name) 				\
+static void spufs_ ## name ## _set(void *data, u64 val) \
+{							\
+	struct spu_context *ctx = data; 		\
+	out_be64(&ctx->spu->priv2->name, val);		\
+}						 	\
+static u64 spufs_ ## name ## _get(void *data)		\
+{							\
+	struct spu_context *ctx = data;			\
+	return in_be64(&ctx->spu->priv2->name);		\
+}							\
+DEFINE_SIMPLE_ATTRIBUTE(spufs_ ## name, 		\
+	spufs_ ## name ## _get, 			\
+	spufs_ ## name ## _set, "%llx\n")
+
+prob_attr(mb_stat_R);
+prob_attr(spu_npc_RW);
+
+priv1_attr(int_stat_class0_RW);
+priv1_attr(int_stat_class1_RW);
+priv1_attr(int_stat_class2_RW);
+
+priv1_attr(int_mask_class0_RW);
+priv1_attr(int_mask_class1_RW);
+priv1_attr(int_mask_class2_RW);
+
+priv1_attr(mfc_sr1_RW);
+priv1_attr(mfc_cer_R);
+priv1_attr(mfc_dsisr_RW);
+priv1_attr(mfc_dsir_R);
+priv1_attr(mfc_sdr_RW);
+priv2_attr(mfc_control_RW);
+
+struct tree_descr spufs_dir_contents[] = {
+	{ "mem",  &spufs_mem_fops,  0666, },
+	{ "run",  &spufs_run_fops,  0444, },
+	{ "mbox", &spufs_mbox_fops, 0444, },
+	{ "ibox", &spufs_ibox_fops, 0444, },
+	{ "wbox", &spufs_wbox_fops, 0222, },
+	{ "mbox_stat", &spufs_mbox_stat_fops, 0444, },
+	{ "ibox_stat", &spufs_ibox_stat_fops, 0444, },
+	{ "wbox_stat", &spufs_wbox_stat_fops, 0444, },
+	{ "signal1", &spufs_signal1_fops, 0666, },
+	{ "signal2", &spufs_signal2_fops, 0666, },
+	{ "signal1_type", &spufs_signal1_type, 0666, },
+	{ "signal2_type", &spufs_signal2_type, 0666, },
+	{ "npc", &spufs_spu_npc_RW, 0666, },
+#if 1 /* debugging only */
+	{ "mb_stat", &spufs_mb_stat_R, 0444, },
+	{ "class0_mask", &spufs_int_mask_class0_RW, 0666, },
+	{ "class1_mask", &spufs_int_mask_class1_RW, 0666, },
+	{ "class2_mask", &spufs_int_mask_class2_RW, 0666, },
+	{ "class0_stat", &spufs_int_stat_class0_RW, 0666, },
+	{ "class1_stat", &spufs_int_stat_class1_RW, 0666, },
+	{ "class2_stat", &spufs_int_stat_class2_RW, 0666, },
+	{ "sr1", &spufs_mfc_sr1_RW, 0666, },
+	{ "cer", &spufs_mfc_cer_R, 0444, },
+	{ "dsisr", &spufs_mfc_dsisr_RW, 0666, },
+	{ "dsir", &spufs_mfc_dsir_R, 0222, },
+	{ "cntl", &spufs_mfc_control_RW, 0666, },
+	{ "sdr", &spufs_mfc_sdr_RW, 0666, },
+#endif
+	{},
+};
--- linux-cg.orig/fs/spufs/inode.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/fs/spufs/inode.c	2005-08-25 22:15:10.914978720 -0400
@@ -0,0 +1,435 @@
+/*
+ * SPU file system
+ *
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
+ *
+ * Author: Arnd Bergmann <arndb@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/fs.h>
+#include <linux/backing-dev.h>
+#include <linux/init.h>
+#include <linux/ioctl.h>
+#include <linux/module.h>
+#include <linux/pagemap.h>
+#include <linux/poll.h>
+#include <linux/slab.h>
+#include <linux/parser.h>
+
+#include <asm/io.h>
+#include <asm/semaphore.h>
+#include <asm/spu.h>
+#include <asm/uaccess.h>
+
+#include "spufs.h"
+
+static kmem_cache_t *spufs_inode_cache;
+
+/* Information about the backing dev, same as ramfs */
+#if 0
+static struct backing_dev_info spufs_backing_dev_info = {
+	.ra_pages       = 0,    /* No readahead */
+	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK |
+	  BDI_CAP_MAP_DIRECT | BDI_CAP_MAP_COPY | BDI_CAP_READ_MAP |
+	  BDI_CAP_WRITE_MAP,
+};
+
+static struct address_space_operations spufs_aops = {
+	.readpage       = simple_readpage,
+	.prepare_write  = simple_prepare_write,
+	.commit_write   = simple_commit_write,
+};
+#endif
+
+/* Inode operations */
+
+static struct inode *
+spufs_alloc_inode(struct super_block *sb)
+{
+	struct spufs_inode_info *ei;
+
+	ei = kmem_cache_alloc(spufs_inode_cache, SLAB_KERNEL);
+	if (!ei)
+		return NULL;
+	return &ei->vfs_inode;
+}
+
+static void
+spufs_destroy_inode(struct inode *inode)
+{
+	kmem_cache_free(spufs_inode_cache, SPUFS_I(inode));
+}
+
+static void
+spufs_init_once(void *p, kmem_cache_t * cachep, unsigned long flags)
+{
+	struct spufs_inode_info *ei = p;
+
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
+	    SLAB_CTOR_CONSTRUCTOR) {
+		inode_init_once(&ei->vfs_inode);
+	}
+}
+
+static struct inode *
+spufs_new_inode(struct super_block *sb, int mode)
+{
+	struct inode *inode;
+
+	inode = new_inode(sb);
+	if (!inode)
+		goto out;
+
+	inode->i_mode = mode;
+	inode->i_uid = current->fsuid;
+	inode->i_gid = current->fsgid;
+	inode->i_blksize = PAGE_CACHE_SIZE;
+	inode->i_blocks = 0;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+out:
+	return inode;
+}
+
+static int
+spufs_setattr(struct dentry *dentry, struct iattr *attr)
+{
+	struct inode *inode = dentry->d_inode;
+
+/*	dump_stack();
+	pr_debug("ia_size %lld, i_size:%lld\n", attr->ia_size, inode->i_size);
+*/
+	if ((attr->ia_valid & ATTR_SIZE) &&
+	    (attr->ia_size != inode->i_size))
+		return -EINVAL;
+	return inode_setattr(inode, attr);
+}
+
+
+static int
+spufs_new_file(struct super_block *sb, struct dentry *dentry,
+		struct file_operations *fops, int mode,
+		struct spu_context *ctx)
+{
+	static struct inode_operations spufs_file_iops = {
+		.getattr = simple_getattr,
+		.setattr = spufs_setattr,
+		.unlink  = simple_unlink,
+	};
+	struct inode *inode;
+	int ret;
+
+	ret = -ENOSPC;
+	inode = spufs_new_inode(sb, S_IFREG | mode);
+	if (!inode)
+		goto out;
+
+	ret = 0;
+	inode->i_op = &spufs_file_iops;
+	inode->i_fop = fops;
+//	inode->i_mapping->a_ops = &spufs_aops;
+//	inode->i_mapping->backing_dev_info = &spufs_backing_dev_info;
+	inode->u.generic_ip = SPUFS_I(inode)->i_ctx = get_spu_context(ctx);
+	d_add(dentry, inode);
+out:
+	return ret;
+}
+
+static int
+spufs_create(struct inode *dir, struct dentry *dentry,
+		int mode, struct nameidata *nd)
+{
+	struct tree_descr *descr;
+	struct spu_context *ctx;
+	int ret;
+
+	descr = spufs_dir_contents;
+
+	/* search spufs_dir_contents for a file with the name we are
+	   trying to create */
+	ret = -EINVAL;
+	while (strcmp(descr->name, dentry->d_name.name) != 0) {
+		descr++;
+		if (!descr->name || !descr->name[0])
+			goto out;
+	}
+
+	ctx = SPUFS_I(dir)->i_ctx;
+	mode &= descr->mode;
+
+	ret = spufs_new_file(dir->i_sb, dentry, descr->ops, mode, ctx);
+	/* get an extra reference to pin the dentry */
+	dget(dentry);
+out:
+	return ret;
+}
+
+static void
+spufs_delete_inode(struct inode *inode)
+{
+	if (SPUFS_I(inode)->i_ctx)
+		put_spu_context(SPUFS_I(inode)->i_ctx);
+	clear_inode(inode);
+}
+
+static int
+spufs_fill_dir(struct dentry *dir, struct tree_descr *files,
+		int mode, struct spu_context *ctx)
+{
+	struct dentry *dentry;
+	int ret;
+
+	while (files->name && files->name[0]) {
+		ret = -ENOMEM;
+		dentry = d_alloc_name(dir, files->name);
+		if (!dentry)
+			goto out;
+		ret = spufs_new_file(dir->d_sb, dentry, files->ops,
+					files->mode & mode, ctx);
+		if (ret)
+			goto out;
+		files++;
+	}
+	return 0;
+out:
+	// FIXME: remove all files that are left
+
+	return ret;
+}
+
+struct inode_operations spufs_dir_inode_operations = {
+	.lookup = simple_lookup,
+	.unlink = simple_unlink,
+	.create = spufs_create,
+};
+
+static int
+spufs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+{
+	int ret;
+	struct inode *inode;
+	struct spu_context *ctx;
+
+	ret = -ENOSPC;
+	inode = spufs_new_inode(dir->i_sb, mode | S_IFDIR);
+	if (!inode)
+		goto out;
+
+	if (dir->i_mode & S_ISGID) {
+		inode->i_gid = dir->i_gid;
+		inode->i_mode &= S_ISGID;
+	}
+	ctx = alloc_spu_context();
+	SPUFS_I(inode)->i_ctx = ctx;
+	if (!ctx)
+		goto out_iput;
+
+	inode->i_op = &spufs_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	ret = spufs_fill_dir(dentry, spufs_dir_contents, mode, ctx);
+	if (ret)
+		goto out_free_ctx;
+
+	d_instantiate(dentry, inode);
+	dget(dentry);
+	dir->i_nlink++;
+	goto out;
+
+out_free_ctx:
+	put_spu_context(ctx);
+out_iput:
+	iput(inode);
+out:
+	return ret;
+}
+
+/* This looks really wrong! */
+static int spufs_rmdir(struct inode *root, struct dentry *dir_dentry)
+{
+	struct dentry *dentry;
+	int err;
+
+	spin_lock(&dcache_lock);
+#if 0
+	/* check if any entry is used */
+	err = -EBUSY;
+	list_for_each_entry(dentry, &dir_dentry->d_subdirs, d_child) {
+		if (d_unhashed(dentry) || !dentry->d_inode)
+			continue;
+		if (atomic_read(&dentry->d_count) != 1)
+			goto out;
+	}
+#endif
+	/* remove all entries */
+	err = 0;
+	list_for_each_entry(dentry, &dir_dentry->d_subdirs, d_child) {
+		if (d_unhashed(dentry) || !dentry->d_inode)
+			continue;
+		atomic_dec(&dentry->d_count);
+		__d_drop(dentry);
+	}
+#if 0
+out:
+#endif
+	spin_unlock(&dcache_lock);
+	if (!err) {
+		shrink_dcache_parent(dir_dentry);
+		err = simple_rmdir(root, dir_dentry);
+	}
+	return err;
+}
+
+/* File system initialization */
+enum {
+	Opt_uid, Opt_gid, Opt_err,
+};
+
+static match_table_t spufs_tokens = {
+	{ Opt_uid, "uid=%d" },
+	{ Opt_gid, "gid=%d" },
+	{ Opt_err, NULL  },
+};
+
+static int
+spufs_parse_options(char *options, struct inode *root)
+{
+	char *p;
+	substring_t args[MAX_OPT_ARGS];
+
+	while ((p = strsep(&options, ",")) != NULL) {
+		int token, option;
+
+		if (!*p)
+			continue;
+
+		token = match_token(p, spufs_tokens, args);
+		switch (token) {
+		case Opt_uid:
+			if (match_int(&args[0], &option))
+				return 0;
+			root->i_uid = option;
+			break;
+		case Opt_gid:
+			if (match_int(&args[0], &option))
+				return 0;
+			root->i_gid = option;
+			break;
+		default:
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static int
+spufs_create_root(struct super_block *sb, void *data) {
+	static struct inode_operations spufs_root_inode_operations = {
+		.lookup		= simple_lookup,
+		.mkdir		= spufs_mkdir,
+		.rmdir		= spufs_rmdir,
+//		.rename		= simple_rename, // XXX maybe
+	};
+
+	struct inode *inode;
+	int ret;
+
+	ret = -ENOMEM;
+	inode = spufs_new_inode(sb, S_IFDIR | 0775);
+	if (!inode)
+		goto out;
+
+	inode->i_op = &spufs_root_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	SPUFS_I(inode)->i_ctx = NULL;
+
+	ret = -EINVAL;
+	if (!spufs_parse_options(data, inode))
+		goto out_iput;
+
+	ret = -ENOMEM;
+	sb->s_root = d_alloc_root(inode);
+	if (!sb->s_root)
+		goto out_iput;
+
+	return 0;
+out_iput:
+	iput(inode);
+out:
+	return ret;
+}
+
+static int
+spufs_fill_super(struct super_block *sb, void *data, int silent)
+{
+	static struct super_operations s_ops = {
+		.alloc_inode = spufs_alloc_inode,
+		.destroy_inode = spufs_destroy_inode,
+		.statfs = simple_statfs,
+		.delete_inode = spufs_delete_inode,
+		.drop_inode = generic_delete_inode,
+	};
+
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = SPUFS_MAGIC;
+	sb->s_op = &s_ops;
+
+	return spufs_create_root(sb, data);
+}
+
+static struct super_block *
+spufs_get_sb(struct file_system_type *fstype, int flags,
+		const char *name, void *data)
+{
+	return get_sb_single(fstype, flags, data, spufs_fill_super);
+}
+
+static struct file_system_type spufs_type = {
+	.owner = THIS_MODULE,
+	.name = "spufs",
+	.get_sb = spufs_get_sb,
+	.kill_sb = kill_litter_super,
+};
+
+static int spufs_init(void)
+{
+	int ret;
+	ret = -ENOMEM;
+	spufs_inode_cache = kmem_cache_create("spufs_inode_cache",
+			sizeof(struct spufs_inode_info), 0,
+			SLAB_HWCACHE_ALIGN, spufs_init_once, NULL);
+
+	if (!spufs_inode_cache)
+		goto out;
+	ret = register_filesystem(&spufs_type);
+	if (ret)
+		kmem_cache_destroy(spufs_inode_cache);
+out:
+	return ret;
+}
+module_init(spufs_init);
+
+static void spufs_exit(void)
+{
+	unregister_filesystem(&spufs_type);
+	kmem_cache_destroy(spufs_inode_cache);
+}
+module_exit(spufs_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Arnd Bergmann <arndb@de.ibm.com>");
+
--- linux-cg.orig/fs/spufs/spufs.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/fs/spufs/spufs.h	2005-08-25 22:20:31.638940264 -0400
@@ -0,0 +1,65 @@
+/*
+ * SPU file system
+ *
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
+ *
+ * Author: Arnd Bergmann <arndb@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#ifndef SPUFS_H
+#define SPUFS_H
+
+#include <linux/kref.h>
+#include <linux/rwsem.h>
+#include <linux/spinlock.h>
+#include <linux/fs.h>
+
+#include <asm/spu.h>
+
+/* The magic number for our file system */
+enum {
+	SPUFS_MAGIC = 0x23c9b64e,
+};
+
+struct spu_context {
+	struct spu *spu;		  /* pointer to a physical SPU */
+	struct rw_semaphore backing_sema; /* protects the above */
+	spinlock_t mmio_lock;		  /* protects mmio access */
+
+	struct kref kref;
+};
+
+struct spufs_inode_info {
+	struct spu_context *i_ctx;
+	struct inode vfs_inode;
+};
+#define SPUFS_I(inode) \
+	container_of(inode, struct spufs_inode_info, vfs_inode)
+
+extern struct tree_descr spufs_dir_contents[];
+
+/* context management */
+struct spu_context * alloc_spu_context(void);
+void destroy_spu_context(struct kref *kref);
+struct spu_context * get_spu_context(struct spu_context *ctx);
+void put_spu_context(struct spu_context *ctx);
+
+void spu_acquire(struct spu_context *ctx);
+void spu_release(struct spu_context *ctx);
+void spu_acquire_runnable(struct spu_context *ctx);
+void spu_acquire_saved(struct spu_context *ctx);
+
+#endif
--- linux-cg.orig/include/asm-ppc64/spu.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/include/asm-ppc64/spu.h	2005-08-25 22:20:31.642939656 -0400
@@ -0,0 +1,473 @@
+/*
+ * SPU core / file system interface and HW structures
+ *
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
+ *
+ * Author: Arnd Bergmann <arndb@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef _SPU_H
+#define _SPU_H
+#include <linux/kref.h>
+#include <linux/workqueue.h>
+
+#define LS_ORDER (6)		/* 256 kb */
+
+#define LS_SIZE (PAGE_SIZE << LS_ORDER)
+
+struct spu {
+	char *name;
+	unsigned long local_store_phys;
+	u8 *local_store;
+	struct spu_problem __iomem *problem;
+	struct spu_priv1 __iomem *priv1;
+	struct spu_priv2 __iomem *priv2;
+	struct list_head list;
+	int number;
+	u32 isrc;
+	u32 node;
+	struct kref kref;
+	size_t ls_size;
+	unsigned int slb_replace;
+	struct mm_struct *mm;
+	int class_0_pending;
+	spinlock_t register_lock;
+
+	u32 stop_code;
+	wait_queue_head_t stop_wq;
+	wait_queue_head_t ibox_wq;
+	wait_queue_head_t wbox_wq;
+
+	char irq_c0[8];
+	char irq_c1[8];
+	char irq_c2[8];
+};
+
+struct spu *spu_alloc(void);
+void spu_free(struct spu *spu);
+int spu_run(struct spu *spu);
+
+size_t spu_wbox_write(struct spu *spu, u32 data);
+size_t spu_ibox_read(struct spu *spu, u32 *data);
+
+/*
+ * This defines the Local Store, Problem Area and Privlege Area of an SPU.
+ */
+
+union mfc_tag_size_class_cmd {
+	struct {
+		u16 mfc_size;
+		u16 mfc_tag;
+		u8  pad;
+		u8  mfc_rclassid;
+		u16 mfc_cmd;
+	} u;
+	struct {
+		u32 mfc_size_tag32;
+		u32 mfc_class_cmd32;
+	} by32;
+	u64 all64;
+};
+
+struct mfc_cq_sr {
+	u64 mfc_cq_data0_RW;
+	u64 mfc_cq_data1_RW;
+	u64 mfc_cq_data2_RW;
+	u64 mfc_cq_data3_RW;
+};
+
+struct spu_problem {
+#define MS_SYNC_PENDING         1L
+	u64 spc_mssync_RW;					/* 0x0000 */
+	u8  pad_0x0008_0x3000[0x3000 - 0x0008];
+
+	/* DMA Area */
+	u8  pad_0x3000_0x3004[0x4];				/* 0x3000 */
+	u32 mfc_lsa_W;						/* 0x3004 */
+	u64 mfc_ea_W;						/* 0x3008 */
+	union mfc_tag_size_class_cmd mfc_union_W;			/* 0x3010 */
+	u8  pad_0x3018_0x3104[0xec];				/* 0x3018 */
+	u32 dma_qstatus_R;					/* 0x3104 */
+	u8  pad_0x3108_0x3204[0xfc];				/* 0x3108 */
+	u32 dma_querytype_RW;					/* 0x3204 */
+	u8  pad_0x3208_0x321c[0x14];				/* 0x3208 */
+	u32 dma_querymask_RW;					/* 0x321c */
+	u8  pad_0x3220_0x322c[0xc];				/* 0x3220 */
+	u32 dma_tagstatus_R;					/* 0x322c */
+#define DMA_TAGSTATUS_INTR_ANY	1u
+#define DMA_TAGSTATUS_INTR_ALL	2u
+	u8  pad_0x3230_0x4000[0x4000 - 0x3230]; 		/* 0x3230 */
+
+	/* SPU Control Area */
+	u8  pad_0x4000_0x4004[0x4];				/* 0x4000 */
+	u32 pu_mb_R;						/* 0x4004 */
+	u8  pad_0x4008_0x400c[0x4];				/* 0x4008 */
+	u32 spu_mb_W;						/* 0x400c */
+	u8  pad_0x4010_0x4014[0x4];				/* 0x4010 */
+	u32 mb_stat_R;						/* 0x4014 */
+	u8  pad_0x4018_0x401c[0x4];				/* 0x4018 */
+	u32 spu_runcntl_RW;					/* 0x401c */
+#define SPU_RUNCNTL_STOP	0L
+#define SPU_RUNCNTL_RUNNABLE	1L
+	u8  pad_0x4020_0x4024[0x4];				/* 0x4020 */
+	u32 spu_status_R;					/* 0x4024 */
+#define SPU_STOP_STATUS_SHIFT           16
+#define SPU_STATUS_STOPPED		0x0
+#define SPU_STATUS_RUNNING		0x1
+#define SPU_STATUS_STOPPED_BY_STOP	0x2
+#define SPU_STATUS_STOPPED_BY_HALT	0x4
+#define SPU_STATUS_WAITING_FOR_CHANNEL	0x8
+#define SPU_STATUS_SINGLE_STEP		0x10
+#define SPU_STATUS_INVALID_INSTR        0x20
+#define SPU_STATUS_INVALID_CH           0x40
+#define SPU_STATUS_ISOLATED_STATE       0x80
+#define SPU_STATUS_ISOLATED_LOAD_STAUTUS 0x200
+#define SPU_STATUS_ISOLATED_EXIT_STAUTUS 0x400
+	u8  pad_0x4028_0x402c[0x4];				/* 0x4028 */
+	u32 spu_spe_R;						/* 0x402c */
+	u8  pad_0x4030_0x4034[0x4];				/* 0x4030 */
+	u32 spu_npc_RW;						/* 0x4034 */
+	u8  pad_0x4038_0x14000[0x14000 - 0x4038];		/* 0x4038 */
+
+	/* Signal Notification Area */
+	u8  pad_0x14000_0x1400c[0xc];				/* 0x14000 */
+	u32 signal_notify1;					/* 0x1400c */
+	u8  pad_0x14010_0x1c00c[0x7ffc];			/* 0x14010 */
+	u32 signal_notify2;					/* 0x1c00c */
+} __attribute__ ((aligned(0x20000)));
+
+/* SPU Privilege 2 State Area */
+struct spu_priv2 {
+	/* MFC Registers */
+	u8  pad_0x0000_0x1100[0x1100 - 0x0000]; 		/* 0x0000 */
+
+	/* SLB Management Registers */
+	u8  pad_0x1100_0x1108[0x8];				/* 0x1100 */
+	u64 slb_index_W;					/* 0x1108 */
+#define SLB_INDEX_MASK				0x7L
+	u64 slb_esid_RW;					/* 0x1110 */
+	u64 slb_vsid_RW;					/* 0x1118 */
+#define SLB_VSID_SUPERVISOR_STATE	(0x1ull << 11)
+#define SLB_VSID_SUPERVISOR_STATE_MASK	(0x1ull << 11)
+#define SLB_VSID_PROBLEM_STATE		(0x1ull << 10)
+#define SLB_VSID_PROBLEM_STATE_MASK	(0x1ull << 10)
+#define SLB_VSID_EXECUTE_SEGMENT	(0x1ull << 9)
+#define SLB_VSID_NO_EXECUTE_SEGMENT	(0x1ull << 9)
+#define SLB_VSID_EXECUTE_SEGMENT_MASK	(0x1ull << 9)
+#define SLB_VSID_4K_PAGE		(0x0 << 8)
+#define SLB_VSID_LARGE_PAGE		(0x1ull << 8)
+#define SLB_VSID_PAGE_SIZE_MASK		(0x1ull << 8)
+#define SLB_VSID_CLASS_MASK		(0x1ull << 7)
+#define SLB_VSID_VIRTUAL_PAGE_SIZE_MASK	(0x1ull << 6)
+	u64 slb_invalidate_entry_W;				/* 0x1120 */
+	u64 slb_invalidate_all_W;				/* 0x1128 */
+	u8  pad_0x1130_0x2000[0x2000 - 0x1130]; 		/* 0x1130 */
+
+	/* Context Save / Restore Area */
+	struct mfc_cq_sr spuq[16];				/* 0x2000 */
+	struct mfc_cq_sr puq[8];				/* 0x2200 */
+	u8  pad_0x2300_0x3000[0x3000 - 0x2300]; 		/* 0x2300 */
+
+	/* MFC Control */
+	u64 mfc_control_RW;					/* 0x3000 */
+#define MFC_CNTL_RESUME_DMA_QUEUE		(0ull << 0)
+#define MFC_CNTL_SUSPEND_DMA_QUEUE		(1ull << 0)
+#define MFC_CNTL_SUSPEND_DMA_QUEUE_MASK		(1ull << 0)
+#define MFC_CNTL_NORMAL_DMA_QUEUE_OPERATION	(0ull << 8)
+#define MFC_CNTL_SUSPEND_IN_PROGRESS		(1ull << 8)
+#define MFC_CNTL_SUSPEND_COMPLETE		(3ull << 8)
+#define MFC_CNTL_SUSPEND_DMA_STATUS_MASK	(3ull << 8)
+#define MFC_CNTL_DMA_QUEUES_EMPTY		(1ull << 14)
+#define MFC_CNTL_DMA_QUEUES_EMPTY_MASK		(1ull << 14)
+#define MFC_CNTL_PURGE_DMA_REQUEST		(1ull << 15)
+#define MFC_CNTL_PURGE_DMA_IN_PROGRESS		(1ull << 24)
+#define MFC_CNTL_PURGE_DMA_COMPLETE		(3ull << 24)
+#define MFC_CNTL_PURGE_DMA_STATUS_MASK		(3ull << 24)
+#define MFC_CNTL_RESTART_DMA_COMMAND		(1ull << 32)
+#define MFC_CNTL_DMA_COMMAND_REISSUE_PENDING	(1ull << 32)
+#define MFC_CNTL_DMA_COMMAND_REISSUE_STATUS_MASK (1ull << 32)
+#define MFC_CNTL_MFC_PRIVILEGE_STATE		(2ull << 33)
+#define MFC_CNTL_MFC_PROBLEM_STATE		(3ull << 33)
+#define MFC_CNTL_MFC_KEY_PROTECTION_STATE_MASK	(3ull << 33)
+#define MFC_CNTL_DECREMENTER_HALTED		(1ull << 35)
+#define MFC_CNTL_DECREMENTER_RUNNING		(1ull << 40)
+#define MFC_CNTL_DECREMENTER_STATUS_MASK	(1ull << 40)
+	u8  pad_0x3008_0x4000[0x4000 - 0x3008]; 		/* 0x3008 */
+
+	/* Interrupt Mailbox */
+	u64 puint_mb_R;						/* 0x4000 */
+	u8  pad_0x4008_0x4040[0x4040 - 0x4008]; 		/* 0x4008 */
+
+	/* SPU Control */
+	u64 spu_privcntl_RW;					/* 0x4040 */
+#define SPU_PRIVCNTL_MODE_NORMAL		(0x0ull << 0)
+#define SPU_PRIVCNTL_MODE_SINGLE_STEP		(0x1ull << 0)
+#define SPU_PRIVCNTL_MODE_MASK			(0x1ull << 0)
+#define SPU_PRIVCNTL_NO_ATTENTION_EVENT		(0x0ull << 1)
+#define SPU_PRIVCNTL_ATTENTION_EVENT		(0x1ull << 1)
+#define SPU_PRIVCNTL_ATTENTION_EVENT_MASK	(0x1ull << 1)
+#define SPU_PRIVCNT_LOAD_REQUEST_NORMAL		(0x0ull << 2)
+#define SPU_PRIVCNT_LOAD_REQUEST_ENABLE_MASK	(0x1ull << 2)
+	u8  pad_0x4048_0x4058[0x10];				/* 0x4048 */
+	u64 spu_lslr_RW;					/* 0x4058 */
+	u64 spu_chnlcntptr_RW;					/* 0x4060 */
+	u64 spu_chnlcnt_RW;					/* 0x4068 */
+	u64 spu_chnldata_RW;					/* 0x4070 */
+	u64 spu_cfg_RW;						/* 0x4078 */
+	u8  pad_0x4080_0x5000[0x5000 - 0x4080]; 		/* 0x4080 */
+
+	/* PV2_ImplRegs: Implementation-specific privileged-state 2 regs */
+	u64 spu_pm_trace_tag_status_RW;				/* 0x5000 */
+	u64 spu_tag_status_query_RW;				/* 0x5008 */
+#define TAG_STATUS_QUERY_CONDITION_BITS (0x3ull << 32)
+#define TAG_STATUS_QUERY_MASK_BITS (0xffffffffull)
+	u64 spu_cmd_buf1_RW;					/* 0x5010 */
+#define SPU_COMMAND_BUFFER_1_LSA_BITS (0x7ffffull << 32)
+#define SPU_COMMAND_BUFFER_1_EAH_BITS (0xffffffffull)
+	u64 spu_cmd_buf2_RW;					/* 0x5018 */
+#define SPU_COMMAND_BUFFER_2_EAL_BITS ((0xffffffffull) << 32)
+#define SPU_COMMAND_BUFFER_2_TS_BITS (0xffffull << 16)
+#define SPU_COMMAND_BUFFER_2_TAG_BITS (0x3full)
+	u64 spu_atomic_status_RW;				/* 0x5020 */
+} __attribute__ ((aligned(0x20000)));
+
+/* SPU Privilege 1 State Area */
+struct spu_priv1 {
+	/* Control and Configuration Area */
+	u64 mfc_sr1_RW;						/* 0x000 */
+#define MFC_STATE1_LOCAL_STORAGE_DECODE_MASK	0x01ull
+#define MFC_STATE1_BUS_TLBIE_MASK		0x02ull
+#define MFC_STATE1_REAL_MODE_OFFSET_ENABLE_MASK	0x04ull
+#define MFC_STATE1_PROBLEM_STATE_MASK		0x08ull
+#define MFC_STATE1_RELOCATE_MASK		0x10ull
+#define MFC_STATE1_MASTER_RUN_CONTROL_MASK	0x20ull
+	u64 mfc_lpid_RW;					/* 0x008 */
+	u64 spu_idr_RW;						/* 0x010 */
+	u64 mfc_vr_RO;						/* 0x018 */
+#define MFC_VERSION_BITS		(0xffff << 16)
+#define MFC_REVISION_BITS		(0xffff)
+#define MFC_GET_VERSION_BITS(vr)	(((vr) & MFC_VERSION_BITS) >> 16)
+#define MFC_GET_REVISION_BITS(vr)	((vr) & MFC_REVISION_BITS)
+	u64 spu_vr_RO;						/* 0x020 */
+#define SPU_VERSION_BITS		(0xffff << 16)
+#define SPU_REVISION_BITS		(0xffff)
+#define SPU_GET_VERSION_BITS(vr)	(vr & SPU_VERSION_BITS) >> 16
+#define SPU_GET_REVISION_BITS(vr)	(vr & SPU_REVISION_BITS)
+	u8  pad_0x28_0x100[0x100 - 0x28];			/* 0x28 */
+
+
+	/* Interrupt Area */
+	u64 int_mask_class0_RW;					/* 0x100 */
+#define CLASS0_ENABLE_DMA_ALIGNMENT_INTR		0x1L
+#define CLASS0_ENABLE_INVALID_DMA_COMMAND_INTR		0x2L
+#define CLASS0_ENABLE_SPU_ERROR_INTR			0x4L
+#define CLASS0_ENABLE_MFC_FIR_INTR			0x8L
+	u64 int_mask_class1_RW;					/* 0x108 */
+#define CLASS1_ENABLE_SEGMENT_FAULT_INTR		0x1L
+#define CLASS1_ENABLE_STORAGE_FAULT_INTR		0x2L
+#define CLASS1_ENABLE_LS_COMPARE_SUSPEND_ON_GET_INTR	0x4L
+#define CLASS1_ENABLE_LS_COMPARE_SUSPEND_ON_PUT_INTR	0x8L
+	u64 int_mask_class2_RW;					/* 0x110 */
+#define CLASS2_ENABLE_MAILBOX_INTR			0x1L
+#define CLASS2_ENABLE_SPU_STOP_INTR			0x2L
+#define CLASS2_ENABLE_SPU_HALT_INTR			0x4L
+#define CLASS2_ENABLE_SPU_DMA_TAG_GROUP_COMPLETE_INTR	0x8L
+	u8  pad_0x118_0x140[0x28];				/* 0x118 */
+	u64 int_stat_class0_RW;					/* 0x140 */
+	u64 int_stat_class1_RW;					/* 0x148 */
+	u64 int_stat_class2_RW;					/* 0x150 */
+	u8  pad_0x158_0x180[0x28];				/* 0x158 */
+	u64 int_route_RW;					/* 0x180 */
+
+	/* Interrupt Routing */
+	u8  pad_0x188_0x200[0x200 - 0x188];			/* 0x188 */
+
+	/* Atomic Unit Control Area */
+	u64 mfc_atomic_flush_RW;				/* 0x200 */
+#define mfc_atomic_flush_enable			0x1L
+	u8  pad_0x208_0x280[0x78];				/* 0x208 */
+	u64 resource_allocation_groupID_RW;			/* 0x280 */
+	u64 resource_allocation_enable_RW; 			/* 0x288 */
+	u8  pad_0x290_0x3c8[0x3c8 - 0x290];			/* 0x290 */
+
+	/* SPU_Cache_ImplRegs: Implementation-dependent cache registers */
+
+	u64 smf_sbi_signal_sel;					/* 0x3c8 */
+#define smf_sbi_mask_lsb	56
+#define smf_sbi_shift		(63 - smf_sbi_mask_lsb)
+#define smf_sbi_mask		(0x301LL << smf_sbi_shift)
+#define smf_sbi_bus0_bits	(0x001LL << smf_sbi_shift)
+#define smf_sbi_bus2_bits	(0x100LL << smf_sbi_shift)
+#define smf_sbi2_bus0_bits	(0x201LL << smf_sbi_shift)
+#define smf_sbi2_bus2_bits	(0x300LL << smf_sbi_shift)
+	u64 smf_ato_signal_sel;					/* 0x3d0 */
+#define smf_ato_mask_lsb	35
+#define smf_ato_shift		(63 - smf_ato_mask_lsb)
+#define smf_ato_mask		(0x3LL << smf_ato_shift)
+#define smf_ato_bus0_bits	(0x2LL << smf_ato_shift)
+#define smf_ato_bus2_bits	(0x1LL << smf_ato_shift)
+	u8  pad_0x3d8_0x400[0x400 - 0x3d8];			/* 0x3d8 */
+
+	/* TLB Management Registers */
+	u64 mfc_sdr_RW;						/* 0x400 */
+	u8  pad_0x408_0x500[0xf8];				/* 0x408 */
+	u64 tlb_index_hint_RO;					/* 0x500 */
+	u64 tlb_index_W;					/* 0x508 */
+	u64 tlb_vpn_RW;						/* 0x510 */
+	u64 tlb_rpn_RW;						/* 0x518 */
+	u8  pad_0x520_0x540[0x20];				/* 0x520 */
+	u64 tlb_invalidate_entry_W;				/* 0x540 */
+	u64 tlb_invalidate_all_W;				/* 0x548 */
+	u8  pad_0x550_0x580[0x580 - 0x550];			/* 0x550 */
+
+	/* SPU_MMU_ImplRegs: Implementation-dependent MMU registers */
+	u64 smm_hid;						/* 0x580 */
+#define PAGE_SIZE_MASK		0xf000000000000000ull
+#define PAGE_SIZE_16MB_64KB	0x2000000000000000ull
+	u8  pad_0x588_0x600[0x600 - 0x588];			/* 0x588 */
+
+	/* MFC Status/Control Area */
+	u64 mfc_accr_RW;					/* 0x600 */
+#define MFC_ACCR_EA_ACCESS_GET		(1 << 0)
+#define MFC_ACCR_EA_ACCESS_PUT		(1 << 1)
+#define MFC_ACCR_LS_ACCESS_GET		(1 << 3)
+#define MFC_ACCR_LS_ACCESS_PUT		(1 << 4)
+	u8  pad_0x608_0x610[0x8];				/* 0x608 */
+	u64 mfc_dsisr_RW;					/* 0x610 */
+#define MFC_DSISR_PTE_NOT_FOUND		(1 << 30)
+#define MFC_DSISR_ACCESS_DENIED		(1 << 27)
+#define MFC_DSISR_ATOMIC		(1 << 26)
+#define MFC_DSISR_ACCESS_PUT		(1 << 25)
+#define MFC_DSISR_ADDR_MATCH		(1 << 22)
+#define MFC_DSISR_LS			(1 << 17)
+#define MFC_DSISR_L			(1 << 16)
+#define MFC_DSISR_ADDRESS_OVERFLOW	(1 << 0)
+	u8  pad_0x618_0x620[0x8];				/* 0x618 */
+	u64 mfc_dar_RW;						/* 0x620 */
+	u8  pad_0x628_0x700[0x700 - 0x628];			/* 0x628 */
+
+	/* Replacement Management Table (RMT) Area */
+	u64 rmt_index_RW;					/* 0x700 */
+	u8  pad_0x708_0x710[0x8];				/* 0x708 */
+	u64 rmt_data1_RW;					/* 0x710 */
+	u8  pad_0x718_0x800[0x800 - 0x718];			/* 0x718 */
+
+	/* Control/Configuration Registers */
+	u64 mfc_dsir_R;						/* 0x800 */
+#define MFC_DSIR_Q			(1 << 31)
+#define MFC_DSIR_SPU_QUEUE		MFC_DSIR_Q
+	u64 mfc_lsacr_RW;					/* 0x808 */
+#define MFC_LSACR_COMPARE_MASK		((~0ull) << 32)
+#define MFC_LSACR_COMPARE_ADDR		((~0ull) >> 32)
+	u64 mfc_lscrr_R;					/* 0x810 */
+#define MFC_LSCRR_Q			(1 << 31)
+#define MFC_LSCRR_SPU_QUEUE		MFC_LSCRR_Q
+#define MFC_LSCRR_QI_SHIFT		32
+#define MFC_LSCRR_QI_MASK		((~0ull) << MFC_LSCRR_QI_SHIFT)
+	u8  pad_0x818_0x820[0x8];				/* 0x818 */
+	u64 mfc_tclass_id_RW;					/* 0x820 */
+#define MFC_TCLASS_ID_ENABLE		(1L << 0L)
+#define MFC_TCLASS_SLOT2_ENABLE		(1L << 5L)
+#define MFC_TCLASS_SLOT1_ENABLE		(1L << 6L)
+#define MFC_TCLASS_SLOT0_ENABLE		(1L << 7L)
+#define MFC_TCLASS_QUOTA_2_SHIFT	8L
+#define MFC_TCLASS_QUOTA_1_SHIFT	16L
+#define MFC_TCLASS_QUOTA_0_SHIFT	24L
+#define MFC_TCLASS_QUOTA_2_MASK		(0x1FL << MFC_TCLASS_QUOTA_2_SHIFT)
+#define MFC_TCLASS_QUOTA_1_MASK		(0x1FL << MFC_TCLASS_QUOTA_1_SHIFT)
+#define MFC_TCLASS_QUOTA_0_MASK		(0x1FL << MFC_TCLASS_QUOTA_0_SHIFT)
+	u8  pad_0x828_0x900[0x900 - 0x828];			/* 0x828 */
+
+	/* Real Mode Support Registers */
+	u64 mfc_rm_boundary;					/* 0x900 */
+	u8  pad_0x908_0x938[0x30];				/* 0x908 */
+	u64 smf_dma_signal_sel;					/* 0x938 */
+#define mfc_dma1_mask_lsb	41
+#define mfc_dma1_shift		(63 - mfc_dma1_mask_lsb)
+#define mfc_dma1_mask		(0x3LL << mfc_dma1_shift)
+#define mfc_dma1_bits		(0x1LL << mfc_dma1_shift)
+#define mfc_dma2_mask_lsb	43
+#define mfc_dma2_shift		(63 - mfc_dma2_mask_lsb)
+#define mfc_dma2_mask		(0x3LL << mfc_dma2_shift)
+#define mfc_dma2_bits		(0x1LL << mfc_dma2_shift)
+	u8  pad_0x940_0xa38[0xf8];				/* 0x940 */
+	u64 smm_signal_sel;					/* 0xa38 */
+#define smm_sig_mask_lsb	12
+#define smm_sig_shift		(63 - smm_sig_mask_lsb)
+#define smm_sig_mask		(0x3LL << smm_sig_shift)
+#define smm_sig_bus0_bits	(0x2LL << smm_sig_shift)
+#define smm_sig_bus2_bits	(0x1LL << smm_sig_shift)
+	u8  pad_0xa40_0xc00[0xc00 - 0xa40];			/* 0xa40 */
+
+	/* DMA Command Error Area */
+	u64 mfc_cer_R;						/* 0xc00 */
+#define MFC_CER_Q		(1 << 31)
+#define MFC_CER_SPU_QUEUE	MFC_CER_Q
+	u8  pad_0xc08_0x1000[0x1000 - 0xc08];			/* 0xc08 */
+
+	/* PV1_ImplRegs: Implementation-dependent privileged-state 1 regs */
+	/* DMA Command Error Area */
+	u64 spu_ecc_cntl_RW;					/* 0x1000 */
+#define SPU_ECC_CNTL_E			(1ull << 0ull)
+#define SPU_ECC_CNTL_ENABLE		SPU_ECC_CNTL_E
+#define SPU_ECC_CNTL_DISABLE		(~SPU_ECC_CNTL_E & 1L)
+#define SPU_ECC_CNTL_S			(1ull << 1ull)
+#define SPU_ECC_STOP_AFTER_ERROR	SPU_ECC_CNTL_S
+#define SPU_ECC_CONTINUE_AFTER_ERROR	(~SPU_ECC_CNTL_S & 2L)
+#define SPU_ECC_CNTL_B			(1ull << 2ull)
+#define SPU_ECC_BACKGROUND_ENABLE	SPU_ECC_CNTL_B
+#define SPU_ECC_BACKGROUND_DISABLE	(~SPU_ECC_CNTL_B & 4L)
+#define SPU_ECC_CNTL_I_SHIFT		3ull
+#define SPU_ECC_CNTL_I_MASK		(3ull << SPU_ECC_CNTL_I_SHIFT)
+#define SPU_ECC_WRITE_ALWAYS		(~SPU_ECC_CNTL_I & 12L)
+#define SPU_ECC_WRITE_CORRECTABLE	(1ull << SPU_ECC_CNTL_I_SHIFT)
+#define SPU_ECC_WRITE_UNCORRECTABLE	(3ull << SPU_ECC_CNTL_I_SHIFT)
+#define SPU_ECC_CNTL_D			(1ull << 5ull)
+#define SPU_ECC_DETECTION_ENABLE	SPU_ECC_CNTL_D
+#define SPU_ECC_DETECTION_DISABLE	(~SPU_ECC_CNTL_D & 32L)
+	u64 spu_ecc_stat_RW;					/* 0x1008 */
+#define SPU_ECC_CORRECTED_ERROR		(1ull << 0ul)
+#define SPU_ECC_UNCORRECTED_ERROR	(1ull << 1ul)
+#define SPU_ECC_SCRUB_COMPLETE		(1ull << 2ul)
+#define SPU_ECC_SCRUB_IN_PROGRESS	(1ull << 3ul)
+#define SPU_ECC_INSTRUCTION_ERROR	(1ull << 4ul)
+#define SPU_ECC_DATA_ERROR		(1ull << 5ul)
+#define SPU_ECC_DMA_ERROR		(1ull << 6ul)
+#define SPU_ECC_STATUS_CNT_MASK		(256ull << 8)
+	u64 spu_ecc_addr_RW;					/* 0x1010 */
+	u64 spu_err_mask_RW;					/* 0x1018 */
+#define SPU_ERR_ILLEGAL_INSTR		(1ull << 0ul)
+#define SPU_ERR_ILLEGAL_CHANNEL		(1ull << 1ul)
+	u8  pad_0x1020_0x1028[0x1028 - 0x1020];			/* 0x1020 */
+
+	/* SPU Debug-Trace Bus (DTB) Selection Registers */
+	u64 spu_trig0_sel;					/* 0x1028 */
+	u64 spu_trig1_sel;					/* 0x1030 */
+	u64 spu_trig2_sel;					/* 0x1038 */
+	u64 spu_trig3_sel;					/* 0x1040 */
+	u64 spu_trace_sel;					/* 0x1048 */
+#define spu_trace_sel_mask		0x1f1fLL
+#define spu_trace_sel_bus0_bits		0x1000LL
+#define spu_trace_sel_bus2_bits		0x0010LL
+	u64 spu_event0_sel;					/* 0x1050 */
+	u64 spu_event1_sel;					/* 0x1058 */
+	u64 spu_event2_sel;					/* 0x1060 */
+	u64 spu_event3_sel;					/* 0x1068 */
+	u64 spu_trace_cntl;					/* 0x1070 */
+} __attribute__ ((aligned(0x2000)));
+
+#endif
--- linux-cg.orig/mm/memory.c	2005-08-25 22:08:05.379976424 -0400
+++ linux-cg/mm/memory.c	2005-08-25 22:15:10.920977808 -0400
@@ -2062,6 +2062,8 @@ int __handle_mm_fault(struct mm_struct *
 	return VM_FAULT_OOM;
 }
 
+EXPORT_SYMBOL_GPL(__handle_mm_fault);
+
 #ifndef __PAGETABLE_PUD_FOLDED
 /*
  * Allocate page upper directory.
--- linux-cg.orig/arch/ppc/kernel/ppc_ksyms.c	2005-08-08 13:44:49.000000000 -0400
+++ linux-cg/arch/ppc/kernel/ppc_ksyms.c	2005-08-25 22:50:27.453998112 -0400
@@ -324,7 +324,6 @@ EXPORT_SYMBOL(__res);
 
 EXPORT_SYMBOL(next_mmu_context);
 EXPORT_SYMBOL(set_context);
-EXPORT_SYMBOL_GPL(__handle_mm_fault); /* For MOL */
 EXPORT_SYMBOL(disarm_decr);
 #ifdef CONFIG_PPC_STD_MMU
 extern long mol_trampoline;

