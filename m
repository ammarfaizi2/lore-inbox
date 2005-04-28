Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVD1IYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVD1IYi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVD1IYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:24:37 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:39933 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261976AbVD1IOO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:14:14 -0400
Message-Id: <200504280813.j3S8DNLd019256@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: [PATCH 4/4] ppc64: Add SPU file system
Date: Thu, 28 Apr 2005 10:00:30 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
References: <200504190318.32556.arnd@arndb.de>
In-Reply-To: <200504190318.32556.arnd@arndb.de>
X-KMail-CryptoFormat: 15
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an early version of the SPU file system, which is used
to run code on the Synergistic Processing Units of the Broadband
Engine.

The file system provides a name space similar to posix shared
memory or message queues. Users that have write permissions
on the file system can create directories in the spufs root.

Every directory represents an SPU context, which is currently
mapped to a physical SPU, but that is going to change to a
virtualization scheme in future updates.

An SPU context directory contains a predefined set of files
used for manipulating the state of the logical SPU. Users
can change permissions on those files, but not actually
add or remove files without removing the complete directory.

The current set of files is:

/mem	the contents of the local store memory of the SPU.
	This can be accessed like a regular shared memory
	file and contains both code and data in the address
	space of the SPU.
	The implemented file operations currently are read(),
	write() and mmap(). We will need our own address
	space operations as soon as we allow the SPU context
	to be scheduled away from the physical SPU into
	page cache.

/run	A stub file that lets us do ioctl. The only ioctl
	method we need is the spu_run() call. spu_run suspends
	the current thread from the host CPU and transfers
	the flow of execution to the SPU.
	The ioctl call return to the calling thread when a state
	is entered that can not be handled by the kernel, e.g.
	an error in the SPU code or an exit() from it.
	When a signal is pending for the host CPU thread, the
	ioctl is interrupted and the SPU stopped in order to
	call the signal handler.

/mbox	The first SPU to CPU communication mailbox. This file
	is read-only and can be read in units of 32 bits.
	The file can only be used in non-blocking mode and
	it even poll() will not block on it.
	When no data is available in the mailbox, read() returns
	EAGAIN.

/ibox	The second SPU to CPU communication mailbox. This file
	is similar to the first mailbox file, but can be read
	in blocking I/O mode, and the poll familiy of system
	calls can be used to wait for it.

/wbox	The CPU to SPU communation mailbox. It is write-only
	can can be written in units of 32 bits. If the mailbox
	is full, write() will block and poll can be used to
	wait for it becoming empty again.

Other files are planned but currently are not implemented or
not functional.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--- linux-2.6-ppc.orig/arch/ppc64/kernel/Makefile	2005-04-01 12:52:36.202930304 -0500
+++ linux-2.6-ppc/arch/ppc64/kernel/Makefile	2005-04-01 12:53:32.093954472 -0500
@@ -53,6 +53,7 @@ obj-$(CONFIG_HVCS)		+= hvcserver.o
 obj-$(CONFIG_IBMVIO)		+= vio.o
 obj-$(CONFIG_XICS)		+= xics.o
 obj-$(CONFIG_MPIC)		+= mpic.o
+obj-$(CONFIG_SPU_FS)		+= spu_base.o
 
 obj-$(CONFIG_PPC_PMAC)		+= pmac_setup.o pmac_feature.o pmac_pci.o \
 				   pmac_time.o pmac_nvram.o pmac_low_i2c.o
--- linux-2.6-ppc.orig/arch/ppc64/kernel/spu_base.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6-ppc/arch/ppc64/kernel/spu_base.c	2005-04-01 12:53:32.095954168 -0500
@@ -0,0 +1,573 @@
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
+	force_sig(SIGBUS, /* info, */ spu->task);
+	return 0;
+}
+
+static int __spu_trap_dma_align(struct spu *spu)
+{
+	pr_debug("%s\n", __FUNCTION__);
+	force_sig(SIGBUS, /* info, */ spu->task);
+	return 0;
+}
+
+static int __spu_trap_error(struct spu *spu)
+{
+	pr_debug("%s\n", __FUNCTION__);
+	force_sig(SIGILL, /* info, */ spu->task);
+	return 0;
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
+		printk("invalid region access at %016lx\n", ea);
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
+	out_be64(&priv2->mfc_control_RW, MFC_CNTL_RESTART_DMA_COMMAND);
+
+	printk("set slb %d context %lx, ea %016lx, vsid %016lx, esid %016lx\n",
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
+	if (dsisr & MFC_DSISR_PTE_NOT_FOUND) {
+		printk("pte lookup ea %016lx, dsisr %lx\n", ea, dsisr);
+		wake_up(&spu->stop_wq);
+	} else {
+		printk("unexpexted data fault ea %016lx, dsisr %lx\n", ea, dsisr);
+	}
+
+	return 0;
+}
+
+static int __spu_trap_mailbox(struct spu *spu)
+{
+	pr_debug("%s\n", __FUNCTION__);
+	wake_up(&spu->mbox_wq);
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
+static irqreturn_t
+spu_irq_class_0(int irq, void *data, struct pt_regs *regs)
+{
+	struct spu *spu;
+	unsigned long stat;
+	
+	spu = data;
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
+	return stat ? IRQ_HANDLED : IRQ_NONE;
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
+	if (stat & 1) /* mailbox */
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
+	ret = request_irq(irq_base + spu->isrc,
+		 spu_irq_class_0, 0, "spe_class0", spu);
+	if (ret)
+		goto out;
+	out_be64(&spu->priv1->int_mask_class0_RW, 0x7);
+	
+	ret = request_irq(irq_base + IIC_CLASS_STRIDE + spu->isrc,
+		 spu_irq_class_1, 0, "spe_class1", spu);
+	if (ret)
+		goto out1;
+	out_be64(&spu->priv1->int_mask_class1_RW, 0x3);
+
+	ret = request_irq(irq_base + 2*IIC_CLASS_STRIDE + spu->isrc,
+		 spu_irq_class_2, 0, "spe_class2", spu);
+	if (ret)
+		goto out2;
+	out_be64(&spu->priv1->int_mask_class2_RW, 0xf);
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
+struct spu *spu_alloc(void)
+{
+	struct spu *spu;
+
+	down(&spu_mutex);
+	if (!list_empty(&spu_list)) {
+		spu = list_entry(spu_list.next, struct spu, list);
+		list_del_init(&spu->list);
+		printk("Got SPU %x\n", spu->isrc);
+	} else {
+		printk("No SPU left\n");
+		spu = NULL;
+	}
+	up(&spu_mutex);
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
+static int spu_handle_pte_fault(struct spu *spu)
+{
+	struct spu_problem __iomem *prob;
+	struct spu_priv1 __iomem *priv1;
+	struct spu_priv2 __iomem *priv2;
+	unsigned long ea, access, is_write;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	int ret;
+
+	printk("%s\n", __FUNCTION__);
+	prob = spu->problem;
+	priv1 = spu->priv1;
+	priv2 = spu->priv2;
+
+	ea = in_be64(&priv1->mfc_dar_RW);
+	access = _PAGE_PRESENT | _PAGE_USER;
+	is_write = in_be64(&priv1->mfc_dsisr_RW) & 0x02000000;
+	mm = spu->mm;
+
+	ret = hash_page(ea, access, 0x300);
+	if (ret < 0) {
+		printk("error in hash_page!\n");
+		ret = -EFAULT;
+		goto out_err;
+	}
+
+	printk("current %ld, spu %ld, ea %ld\n", current->mm->context.id, mm->context.id, ea);
+	if (!ret) {
+		printk("hash inserted, vsid %lx\n", get_vsid(current->mm->context.id, ea));
+		goto out_restart;
+	}
+
+	ret = -EFAULT;
+	if (ea >= TASK_SIZE)
+		goto out_err;
+	
+	down_read(&mm->mmap_sem);
+	vma = find_vma(mm, ea);
+	if (!vma)
+		goto out;
+
+	if (is_write) {
+		if (!(vma->vm_flags & VM_WRITE))
+			goto out;
+	}
+
+	ret = 0;
+/* FIXME add missing code from do_page_fault */
+	switch (handle_mm_fault(mm, vma, ea, is_write)) {
+	case VM_FAULT_MINOR:
+		printk("minor\n");
+                current->min_flt++;
+                break;
+        case VM_FAULT_MAJOR:
+		printk("major\n");
+                current->maj_flt++;
+                break;
+        case VM_FAULT_SIGBUS:
+		ret = -EFAULT;
+                break;
+        case VM_FAULT_OOM:
+		ret = -ENOMEM;
+                break;
+	default:
+		BUG();
+	}
+out:	
+	up_read(&mm->mmap_sem);
+	if (ret)
+		goto out_err;
+out_restart:
+	out_be64(&priv2->mfc_control_RW, MFC_CNTL_RESTART_DMA_COMMAND);
+out_err:
+	printk("%s: returning %d\n", __FUNCTION__, ret);
+	return ret;
+}
+
+int spu_run(struct spu *spu)
+{
+	struct spu_problem __iomem *prob;
+	struct spu_priv1 __iomem *priv1;
+	struct spu_priv2 __iomem *priv2;
+	unsigned long status;
+	int count = 10;
+	int ret;
+
+	prob = spu->problem;
+	priv1 = spu->priv1;
+	priv2 = spu->priv2;
+	spu->mm = current->mm;
+	spu->task = current;
+	out_be32(&prob->spu_runcntl_RW, SPU_RUNCNTL_RUNNABLE);
+
+	do {	
+		ret = wait_event_interruptible(spu->stop_wq,
+			 (!((status = in_be32(&prob->spu_status_R)) & 0x1))
+			|| (in_be64(&priv1->mfc_dsisr_RW) & MFC_DSISR_PTE_NOT_FOUND));
+
+		if (status & SPU_STATUS_STOPPED_BY_STOP)
+			ret = -EAGAIN;
+		else if (status & SPU_STATUS_STOPPED_BY_HALT)
+			ret = -EIO;
+		else if (in_be64(&priv1->mfc_dsisr_RW) & MFC_DSISR_PTE_NOT_FOUND)
+			ret = spu_handle_pte_fault(spu);
+
+	} while (!ret && count--);
+	out_be32(&prob->spu_runcntl_RW, SPU_RUNCNTL_STOP);
+	out_be64(&priv2->slb_invalidate_all_W, 0);
+	spu->mm = NULL;
+	spu->task = NULL;
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
+	unsigned int *isrc_prop;
+	int ret;
+
+	ret = -ENODEV;
+	isrc_prop = (u32 *)get_property(spe, "isrc", NULL);
+	if (!isrc_prop)
+		goto out;
+	spu->isrc = *isrc_prop;
+
+	spu->name = get_property(spe, "name", NULL);
+	if (!spu->name)
+		goto out;
+
+	/* we use local store as ram, not io memory */
+	spu->local_store = (u8 __force *) map_spe_prop(spe, "local-store");
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
+
+	out_be64(&spu->priv1->mfc_sdr_RW, mfspr(SPRN_SDR1));
+	out_be64(&spu->priv1->mfc_sr1_RW, 0x33);
+
+	init_waitqueue_head(&spu->stop_wq);
+	init_waitqueue_head(&spu->mbox_wq);
+
+	ret = spu_request_irqs(spu);
+	if (ret)
+		goto out_unmap;
+
+	down(&spu_mutex);
+	list_add(&spu->list, &spu_list);
+	up(&spu_mutex);
+
+	printk(KERN_DEBUG "Using SPE %s %02x %p %p %p %p\n", 
+		spu->name, spu->isrc, spu->local_store, 
+		spu->problem, spu->priv1, spu->priv2);
+	goto out;
+
+out_unmap:
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
+	return ret;
+}
+module_init(init_spu_base);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Arnd Bergmann <arndb@de.ibm.com>");
--- linux-2.6-ppc.orig/arch/ppc64/mm/hash_utils.c	2005-04-01 12:39:56.616981816 -0500
+++ linux-2.6-ppc/arch/ppc64/mm/hash_utils.c	2005-04-01 12:53:32.098953712 -0500
@@ -355,6 +355,7 @@ int hash_page(unsigned long ea, unsigned
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(hash_page);
 
 void flush_hash_page(unsigned long context, unsigned long ea, pte_t pte,
 		     int local)
--- linux-2.6-ppc.orig/fs/Kconfig	2005-04-01 12:39:56.619981360 -0500
+++ linux-2.6-ppc/fs/Kconfig	2005-04-01 12:53:32.100953408 -0500
@@ -853,6 +853,16 @@ config HUGETLBFS
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
--- linux-2.6-ppc.orig/fs/Makefile	2005-04-01 12:39:56.621981056 -0500
+++ linux-2.6-ppc/fs/Makefile	2005-04-01 12:53:32.102953104 -0500
@@ -95,3 +95,4 @@ obj-$(CONFIG_BEFS_FS)		+= befs/
 obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_HPPFS)		+= hppfs/
 obj-$(CONFIG_DEBUG_FS)		+= debugfs/
+obj-$(CONFIG_SPU_FS)		+= spufs/
--- linux-2.6-ppc.orig/fs/spufs/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6-ppc/fs/spufs/Makefile	2005-04-01 12:53:32.104952800 -0500
@@ -0,0 +1,3 @@
+obj-$(CONFIG_SPU_FS) += spufs.o
+
+spufs-y += inode.o
--- linux-2.6-ppc.orig/fs/spufs/inode.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6-ppc/fs/spufs/inode.c	2005-04-01 12:53:32.107952344 -0500
@@ -0,0 +1,991 @@
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
+
+#include <asm/io.h>
+#include <asm/semaphore.h>
+#include <asm/spu.h>
+#include <asm/uaccess.h>
+
+/* SPU context abstraction */
+struct spu_context {
+	struct spu *spu; /* pointer to a physical SPU if SPUFS_DIRECT */
+	struct rw_semaphore backing_sema; /* protects the above */
+	spinlock_t mmio_lock; /* protects mmio access */ 
+	long  sig;
+
+	struct kref kref;
+};
+
+static struct spu_context *
+alloc_spu_context(void)
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
+static void
+destroy_spu_context(struct kref *kref)
+{
+	struct spu_context *ctx;
+	ctx = container_of(kref, struct spu_context, kref);
+	if (ctx->spu)
+		spu_free(ctx->spu);
+	kfree(ctx);
+}
+
+static struct spu_context *
+get_spu_context(struct spu_context *ctx)
+{
+	kref_get(&ctx->kref);
+	return ctx;
+}
+
+static void
+put_spu_context(struct spu_context *ctx)
+{
+	kref_put(&ctx->kref, &destroy_spu_context);
+}
+
+/* The magic number for our file system */
+enum {
+	SPUFS_MAGIC = 0x23c9b64e,
+};
+
+/* bits in the inode flags */
+enum {
+	SPUFS_DIRECT, /* Data resides on a physical SPU */
+};
+
+struct spufs_inode_info {
+	struct spu_context *i_ctx;
+	struct inode vfs_inode;
+};
+
+static kmem_cache_t *spufs_inode_cache;
+#define SPUFS_I(inode) container_of(inode, struct spufs_inode_info, vfs_inode)
+
+/* Information about the backing dev, same as ramfs */
+
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
+
+/* File operations */
+
+static int
+spufs_open(struct inode *inode, struct file *file)
+{
+	struct spufs_inode_info *i = SPUFS_I(inode);
+	file->private_data = i->i_ctx;
+	return 0;
+}
+
+static ssize_t
+spufs_read(struct file *file, char __user *buffer, size_t size, loff_t *pos)
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
+	ret = 0;
+	size = min_t(ssize_t, LS_SIZE - *pos, size);
+	if (size <= 0)
+		goto out;
+	*pos += size;
+	ret = copy_to_user(buffer, spu->local_store + *pos - size, size);
+	ret = ret ? -EFAULT : size;
+
+out:
+	up_read(&ctx->backing_sema);
+	return ret;
+}
+
+static ssize_t
+spufs_write(struct file *file, const char __user *buffer, size_t size, loff_t *pos)
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
+				 buffer, size) ? -EFAULT : size;
+}
+
+static int
+spufs_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct spu_context *ctx = file->private_data;
+	struct spu *spu = ctx->spu;
+	unsigned long pfn;
+
+	if (spu->number & 0) //1)
+		return generic_file_mmap(file, vma);
+
+	vma->vm_flags |= VM_RESERVED;
+	pfn = __pa(spu->local_store) >> PAGE_SHIFT;
+	/*
+	 * This will work for actual SPUs, but not for vmalloc memory:
+	 */
+	if (remap_pfn_range(vma, vma->vm_start, pfn,
+				vma->vm_end-vma->vm_start, vma->vm_page_prot))
+	           return -EAGAIN;
+	 /**/
+	return 0;
+}
+
+static struct file_operations spufs_mem_fops = {
+	.open	 = spufs_open,
+	.read    = spufs_read,
+        .write   = spufs_write,
+	.mmap    = spufs_mmap,
+	.llseek  = generic_file_llseek,
+};
+
+/* generic open function for all pipe-like files */
+static int spufs_pipe_open(struct inode *inode, struct file *file)
+{
+        struct spufs_inode_info *i = SPUFS_I(inode);
+        file->private_data = i->i_ctx;
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
+static ssize_t spufs_ibox_read(struct file *file, char __user *buf, 
+			size_t len, loff_t *pos)
+{
+	struct spu_context *ctx;
+	struct spu_problem __iomem *prob;
+	struct spu_priv2 __iomem *priv2;
+	u32 mbox_stat;
+	u32 ibox_data;
+	ssize_t ret;
+
+	if (len < 4)
+		return -EINVAL;
+
+	ctx = file->private_data;
+	prob = ctx->spu->problem;
+	priv2 = ctx->spu->priv2;
+
+	mbox_stat = in_be32(&prob->mb_stat_R);
+	if (!(mbox_stat & 0xff0000))
+		return -EAGAIN;
+
+	ibox_data = in_be64(&priv2->puint_mb_R);
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
+	poll_wait(file, &ctx->spu->mbox_wq, wait);
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
+static ssize_t spufs_wbox_write(struct file *file, const char __user *buf, 
+			size_t len, loff_t *pos)
+{
+	struct spu_context *ctx;
+	struct spu_problem __iomem *prob;
+	u32 mbox_stat;
+	u32 wbox_data;
+
+	if (len < 4)
+		return -EINVAL;
+
+	ctx = file->private_data;
+	prob = ctx->spu->problem;
+	mbox_stat = in_be32(&prob->mb_stat_R);
+	if (!(mbox_stat & 0x00ff00))
+		return -EAGAIN;
+
+	if (copy_from_user(&wbox_data, buf, sizeof wbox_data))
+		return -EFAULT;
+
+	out_be32(&prob->spu_mb_W, wbox_data);
+
+	return 4;
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
+	poll_wait(file, &ctx->spu->mbox_wq, wait);
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
+static int spufs_run_open(struct inode *inode, struct file *file)
+{
+        struct spufs_inode_info *i = SPUFS_I(inode);
+        file->private_data = i->i_ctx;
+
+	return nonseekable_open(inode, file);
+}
+
+struct spufs_run_arg {
+	u32 npc;    /* inout: Next Program Counter */
+	u32 status; /* out:   SPU status */
+};
+
+static long spufs_run_ioctl(struct file *file, unsigned int num,
+						unsigned long arg)
+{
+	struct spu_context *ctx;
+	struct spu_problem __iomem *prob;
+	struct spufs_run_arg data;
+	int ret;
+
+	if (num != _IOWR('s', 0, struct spufs_run_arg))
+		return -EINVAL;
+
+	if (copy_from_user(&data, (void __user *)arg, sizeof data))
+		return -EFAULT;
+
+	ctx = file->private_data;
+	prob = ctx->spu->problem;
+	out_be32(&prob->spu_npc_RW, data.npc);
+	wmb();
+
+	ret = spu_run(ctx->spu);
+/*
+	prob->spu_npc_RW = data.npc;
+	ctx->spu->mm = current->mm;
+	wmb();
+	prob->spu_runcntl_RW = SPU_RUNCNTL_RUNNABLE;
+	mb();
+	
+	ret = wait_event_interruptible(ctx->spu->stop_wq,
+				 prob->spu_status_R & 0x3e);
+
+	prob->spu_runcntl_RW = SPU_RUNCNTL_STOP;
+	ctx->spu->mm = NULL;
+*/
+	data.status = in_be32(&prob->spu_status_R);
+	data.npc = in_be32(&prob->spu_npc_RW);
+	if (copy_to_user((void __user *)arg, &data, sizeof data))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+static struct file_operations spufs_run_fops = {
+	.open		= spufs_run_open,
+	.unlocked_ioctl	= spufs_run_ioctl,
+	.compat_ioctl	= spufs_run_ioctl,
+};
+
+
+/**** spufs attributes
+ *
+ * Attributes in spufs behave similar to those in sysfs:
+ *
+ * Writing to an attribute immediately sets a value, an open file can be
+ * written to multiple times.
+ *
+ * Reading from an attribute creates a buffer from the value that might get
+ * read with multiple read calls. When the attribute has been read completely,
+ * no further read calls are possible until the file is opened again.
+ *
+ * All spufs attributes contain a text representation of a numeric value that
+ * are accessed with the get() and set() functions.
+ *
+ * Perhaps these file operations could be put in debugfs or libfs instead,
+ * they are not really SPU specific.
+ */
+
+struct spufs_attr {
+	long (*get)(struct spu_context *);
+	void (*set)(struct spu_context *, long);
+	struct spu_context *ctx;
+	char get_buf[24]; /* enough to store a long and "\n\0" */
+	char set_buf[24];
+	struct semaphore sem; /* protects access to these buffers */
+};
+
+/* spufs_attr_open is called by an actual attribute open file operation
+ * to set the attribute specific access operations. */
+static int spufs_attr_open(struct inode *inode, struct file *file,
+		long (*get)(struct spu_context *),
+		void (*set)(struct spu_context *, long))
+{
+	struct spufs_attr *attr;
+
+	attr = kmalloc(sizeof *attr, GFP_KERNEL);
+	if (!attr)
+		return -ENOMEM;
+
+	/* reading/writing needs the respective get/set operation */
+	if (((file->f_mode & FMODE_READ)  && !get) ||
+	    ((file->f_mode & FMODE_WRITE) && !set))
+		return -EACCES;
+
+	attr->get = get;
+	attr->set = set;
+	attr->ctx = SPUFS_I(inode)->i_ctx;
+	init_MUTEX(&attr->sem);
+
+	file->private_data = attr;
+
+	return nonseekable_open(inode, file);
+}
+
+static int spufs_attr_close(struct inode *inode, struct file *file)
+{
+	kfree(file->private_data);
+	return 0;
+}
+
+/* read from the buffer that is filled with the get function */
+static ssize_t spufs_attr_read(struct file *file, char __user *buf,
+					size_t len, loff_t *ppos)
+{
+	struct spufs_attr *attr;
+	size_t size;
+	ssize_t ret;
+
+	attr = file->private_data;
+
+	down(&attr->sem);
+	if (*ppos) /* continued read */
+		size = strlen(attr->get_buf);
+	else	  /* first read */
+		size = scnprintf(attr->get_buf, sizeof (attr->get_buf),
+				 "%ld\n", attr->get(attr->ctx));
+
+	ret = simple_read_from_buffer(buf, len, ppos, attr->get_buf, size);
+	up(&attr->sem);
+	return ret;
+}
+
+/* interpret the buffer as a number to call the set function with */
+static ssize_t spufs_attr_write(struct file *file, const char __user *buf,
+					size_t len, loff_t *ppos)
+{
+	struct spufs_attr *attr;
+	long val;
+	size_t size;
+	ssize_t ret;
+	
+
+	attr = file->private_data;
+
+	down(&attr->sem);
+	ret = -EFAULT;
+	size = min(sizeof (attr->set_buf) - 1, len);
+	if (copy_from_user(attr->set_buf, buf, size))
+		goto out;
+
+	ret = len; /* claim we got the whole input */
+	attr->set_buf[size] = '\0';
+	val = simple_strtol(attr->set_buf, NULL, 0);
+	attr->set(attr->ctx, val);
+out:
+	up(&attr->sem);
+	return ret;
+}
+
+#define spufs_attribute(name)						   \
+static int name ## _open(struct inode *inode, struct file *file)	   \
+{									   \
+	return spufs_attr_open(inode, file, &name ## _get, &name ## _set); \
+}									   \
+static struct file_operations name = {					   \
+	.open	 = name ## _open,					   \
+	.release = spufs_attr_close,					   \
+	.read	 = spufs_attr_read,					   \
+	.write	 = spufs_attr_write,					   \
+};
+
+
+static void spufs_signal1_type_set(struct spu_context *ctx, long val)
+{
+	ctx->sig = val;
+}
+
+static long spufs_signal1_type_get(struct spu_context *ctx)
+{
+	return ctx->sig;
+}
+
+spufs_attribute(spufs_signal1_type);
+
+static void spufs_class0_stat_set(struct spu_context *ctx, long val)
+{
+	out_be64(&ctx->spu->priv1->int_stat_class0_RW, val);
+}
+
+static long spufs_class0_stat_get(struct spu_context *ctx)
+{
+	return in_be64(&ctx->spu->priv1->int_stat_class0_RW);
+}
+
+spufs_attribute(spufs_class0_stat);
+
+static void spufs_class1_stat_set(struct spu_context *ctx, long val)
+{
+	out_be64(&ctx->spu->priv1->int_stat_class1_RW, val);
+}
+
+static long spufs_class1_stat_get(struct spu_context *ctx)
+{
+	return in_be64(&ctx->spu->priv1->int_stat_class1_RW);
+}
+
+spufs_attribute(spufs_class1_stat);
+
+static void spufs_class2_stat_set(struct spu_context *ctx, long val)
+{
+	out_be64(&ctx->spu->priv1->int_stat_class2_RW, val);
+}
+
+static long spufs_class2_stat_get(struct spu_context *ctx)
+{
+	return in_be64(&ctx->spu->priv1->int_stat_class2_RW);
+}
+
+spufs_attribute(spufs_class2_stat);
+
+static void spufs_class0_mask_set(struct spu_context *ctx, long val)
+{
+	out_be64(&ctx->spu->priv1->int_mask_class0_RW, val);
+}
+
+static long spufs_class0_mask_get(struct spu_context *ctx)
+{
+	return in_be64(&ctx->spu->priv1->int_mask_class0_RW);
+}
+
+spufs_attribute(spufs_class0_mask);
+
+static void spufs_class1_mask_set(struct spu_context *ctx, long val)
+{
+	out_be64(&ctx->spu->priv1->int_mask_class1_RW, val);
+}
+
+static long spufs_class1_mask_get(struct spu_context *ctx)
+{
+	return in_be64(&ctx->spu->priv1->int_mask_class1_RW);
+}
+
+spufs_attribute(spufs_class1_mask);
+
+static void spufs_class2_mask_set(struct spu_context *ctx, long val)
+{
+	out_be64(&ctx->spu->priv1->int_mask_class2_RW, val);
+}
+
+static long spufs_class2_mask_get(struct spu_context *ctx)
+{
+	return in_be64(&ctx->spu->priv1->int_mask_class2_RW);
+}
+
+spufs_attribute(spufs_class2_mask);
+
+#define priv1_attr(name) \
+static void spufs_ ## name ## _set(struct spu_context *ctx, long val) \
+{ out_be64(&ctx->spu->priv1->name, val); } \
+static long spufs_ ## name ## _get(struct spu_context *ctx) \
+{ return in_be64(&ctx->spu->priv1->name); } \
+spufs_attribute(spufs_ ## name)
+
+#define priv2_attr(name) \
+static void spufs_ ## name ## _set(struct spu_context *ctx, long val) \
+{ out_be64(&ctx->spu->priv2->name, val); } \
+static long spufs_ ## name ## _get(struct spu_context *ctx) \
+{ return in_be64(&ctx->spu->priv2->name); } \
+spufs_attribute(spufs_ ## name)
+
+priv1_attr(mfc_sr1_RW);
+priv1_attr(mfc_fir_R);
+priv1_attr(mfc_fir_status_or_W);
+priv1_attr(mfc_fir_status_and_W);
+priv1_attr(mfc_fir_mask_R);
+priv1_attr(mfc_fir_mask_or_W);
+priv1_attr(mfc_fir_mask_and_W);
+priv1_attr(mfc_fir_chkstp_enable_RW);
+priv1_attr(mfc_cer_R);
+priv1_attr(mfc_dsisr_RW);
+priv1_attr(mfc_dsir_R);
+priv1_attr(mfc_sdr_RW);
+priv2_attr(mfc_control_RW);
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
+	printk("ia_size %lld, i_size:%lld\n", attr->ia_size, inode->i_size);
+*/
+	if (attr->ia_size != inode->i_size)
+		return -EINVAL;
+	return inode_setattr(inode, attr);
+}
+
+/*
+static int
+spufs_create(struct inode *dir, struct dentry *dentry,
+		int mode, struct nameidata *nd)
+{
+	static struct inode_operations iops = {
+		.getattr = simple_getattr,
+		.setattr = spufs_setattr,
+	};
+
+
+	struct inode *inode;
+	int ret;
+
+	ret = -ENOSPC;
+	inode = spufs_new_inode(dir->i_sb, S_IFREG | mode);
+	if (!inode)
+		goto out;
+	inode->i_op = &iops;
+	inode->i_fop = &spufs_mem_fops;
+	inode->i_size = LS_SIZE;
+	SPUFS_I(inode)->i_spu = spu_alloc();
+	if (!SPUFS_I(inode)->i_spu)
+		goto out_iput;
+	inode->i_mapping->a_ops = &spufs_aops;
+	inode->i_mapping->backing_dev_info = &spufs_backing_dev_info;
+	d_instantiate(dentry, inode);
+	dget(dentry);
+	return 0;
+out_iput:
+	iput(inode);
+out:
+	return ret;
+}
+*/
+
+static void
+spufs_delete_inode(struct inode *inode)
+{
+	if (SPUFS_I(inode)->i_ctx)
+		put_spu_context(SPUFS_I(inode)->i_ctx);
+	clear_inode(inode);
+}
+
+static struct tree_descr spufs_dir_contents[] = {
+	{ "mem",  &spufs_mem_fops,  0644, },
+	{ "run",  &spufs_run_fops,  0400, },
+	{ "mbox", &spufs_mbox_fops, 0400, },
+	{ "ibox", &spufs_ibox_fops, 0400, },
+	{ "wbox", &spufs_wbox_fops, 0200, },
+	{ "signal1_type", &spufs_signal1_type, 0600, },
+	{ "signal2_type", &spufs_signal1_type, 0600, },
+
+#if 1 /* debugging only */
+	{ "class0_mask", &spufs_class0_mask, 0600, },
+	{ "class1_mask", &spufs_class1_mask, 0600, },
+	{ "class2_mask", &spufs_class2_mask, 0600, },
+	{ "class0_stat", &spufs_class0_stat, 0600, },
+	{ "class1_stat", &spufs_class1_stat, 0600, },
+	{ "class2_stat", &spufs_class2_stat, 0600, },
+	{ "sr1", &spufs_mfc_sr1_RW, 0600, },
+	{ "fir", &spufs_mfc_fir_R, 0400, },
+	{ "fir_status_or", &spufs_mfc_fir_status_or_W, 0200, },
+	{ "fir_status_and", &spufs_mfc_fir_status_and_W, 0200, },
+	{ "fir_mask", &spufs_mfc_fir_mask_R, 0400, },
+	{ "fir_mask_or", &spufs_mfc_fir_mask_or_W, 0200, },
+	{ "fir_mask_and", &spufs_mfc_fir_mask_and_W, 0200, },
+	{ "fir_chkstp", &spufs_mfc_fir_chkstp_enable_RW, 0600, },
+	{ "cer", &spufs_mfc_cer_R, 0400, },
+	{ "dsisr", &spufs_mfc_dsisr_RW, 0600, },
+	{ "dsir", &spufs_mfc_dsir_R, 0200, },
+	{ "cntl", &spufs_mfc_control_RW, 0600, },
+	{ "sdr", &spufs_mfc_sdr_RW, 0600, },
+#endif
+	{},
+};
+
+static int
+spufs_fill_dir(struct dentry *dir, struct tree_descr *files,
+		int mode, struct spu_context *ctx)
+{
+	struct inode *inode;
+	struct dentry *dentry;
+	int ret;
+
+	static struct inode_operations iops = {
+		.getattr = simple_getattr,
+		.setattr = spufs_setattr,
+	};
+
+	ret = -ENOSPC;
+	while (files->name && files->name[0]) {
+		dentry = d_alloc_name(dir, files->name);
+		if (!dentry)
+			goto out;
+		inode = spufs_new_inode(dir->d_sb,
+				S_IFREG | (files->mode & mode));
+		if (!inode)
+			goto out;
+		inode->i_op = &iops;
+		inode->i_fop = files->ops;
+		inode->i_mapping->a_ops = &spufs_aops;
+		inode->i_mapping->backing_dev_info = &spufs_backing_dev_info;
+		SPUFS_I(inode)->i_ctx = get_spu_context(ctx);
+
+		d_add(dentry, inode);
+		files++;
+	}
+	return 0;
+out:
+	// FIXME: remove all files that are left
+	return ret;
+}
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
+		inode->i_mode |= S_ISGID;
+	}
+	ctx = alloc_spu_context();
+	SPUFS_I(inode)->i_ctx = ctx;
+	if (!ctx)
+		goto out_iput;
+
+	inode->i_op = &simple_dir_inode_operations;
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
+
+	/* check if any entry is used */
+	err = -EBUSY;
+	list_for_each_entry(dentry, &dir_dentry->d_subdirs, d_child) {
+		if (d_unhashed(dentry) || !dentry->d_inode)
+			continue;
+		if (atomic_read(&dentry->d_count) != 1)
+			goto out;
+	}
+	/* remove all entries */
+	err = 0;
+	list_for_each_entry(dentry, &dir_dentry->d_subdirs, d_child) {
+		if (d_unhashed(dentry) || !dentry->d_inode)
+			continue;
+		atomic_dec(&dentry->d_count);
+		__d_drop(dentry);
+	}
+out:
+	spin_unlock(&dcache_lock);
+	if (!err) {
+		shrink_dcache_parent(dir_dentry);
+		err = simple_rmdir(root, dir_dentry);
+	}
+	return err;
+}
+
+/* File system initialization */
+
+static int
+spufs_create_root(struct super_block *sb) {
+	static struct inode_operations spufs_dir_inode_operations = {
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
+	inode = spufs_new_inode(sb, S_IFDIR | 0777);
+
+	if (inode) {
+		inode->i_op = &spufs_dir_inode_operations;
+		inode->i_fop = &simple_dir_operations;
+		SPUFS_I(inode)->i_ctx = NULL;
+		sb->s_root = d_alloc_root(inode);
+		if (!sb->s_root)
+			iput(inode);
+		else
+			ret = 0;
+	}
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
+	return spufs_create_root(sb);
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
--- linux-2.6-ppc.orig/include/asm-ppc64/spu.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6-ppc/include/asm-ppc64/spu.h	2005-04-01 12:55:10.054973928 -0500
@@ -0,0 +1,459 @@
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
+
+#define LS_ORDER (6)		/* 256 kb */
+
+#define LS_SIZE (PAGE_SIZE << LS_ORDER)
+
+struct spu {
+	char *name;
+	u8  *local_store;
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
+	struct task_struct *task;
+
+	u32 stop_code;
+	wait_queue_head_t stop_wq;
+	wait_queue_head_t mbox_wq;
+};
+
+struct spu *spu_alloc(void);
+void spu_free(struct spu *spu);
+int spu_run(struct spu *spu);
+
+/*
+ * This defines the Local Store, Problem Area and Privlege Area of an SPU.
+ */
+
+union MFC_TagSizeClassCmd {
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
+struct MFC_cq_sr {
+	u64 mfc_cq_data0_RW;
+	u64 mfc_cq_data1_RW;
+	u64 mfc_cq_data2_RW;
+	u64 mfc_cq_data3_RW;
+};
+
+struct spu_problem {
+	u8  pad_0x0000_0x3000[0x3000 - 0x0000]; 		/* 0x0000 */
+
+	/* DMA Area */
+	u8  pad_0x3000_0x3004[0x4];				/* 0x3000 */
+	u32 mfc_lsa_W;						/* 0x3004 */
+	u64 mfc_ea_W;						/* 0x3008 */
+	union MFC_TagSizeClassCmd mfc_union_W;			/* 0x3010 */
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
+#define SPU_STATUS_STOPPED		0x0
+#define SPU_STATUS_RUNNING		0x1
+#define SPU_STATUS_STOPPED_BY_STOP	0x2
+#define SPU_STATUS_STOPPED_BY_HALT	0x4
+#define SPU_STATUS_WAITING_FOR_CHANNEL	0x8
+#define SPU_STATUS_SINGLE_STEP		0x10
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
+	struct MFC_cq_sr spuq[16];				/* 0x2000 */
+	struct MFC_cq_sr puq[8];				/* 0x2200 */
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
+	u8  pad_0x290_0x380[0x380 - 0x290];			/* 0x290 */
+
+	/* MFC Fault Isolation Area */
+	/* mfc_fir_R:			MFC Fault Isolation Register. 
+	 * mfc_fir_status_or_W:		MFC Fault Isolation Status OR Register. 
+	 * mfc_fir_status_and_W:	MFC Fault Isolation Status AND Register.
+	 * mfc_fir_mask_R:		MFC FIR Mask Register.
+	 * mfc_fir_mask_or_W:		MFC FIR Mask OR Register.
+	 * mfc_fir_mask_and_W:		MFC FIR Mask AND Register.
+	 * mfc_fir_chkstp_enable_W: MFC FIR Checkstop Enable Register.
+	 */
+	u64 mfc_fir_R;						/* 0x380 */
+	u64 mfc_fir_status_or_W;				/* 0x388 */
+	u64 mfc_fir_status_and_W;				/* 0x390 */
+	u64 mfc_fir_mask_R;					/* 0x398 */
+	u64 mfc_fir_mask_or_W;					/* 0x3a0 */
+	u64 mfc_fir_mask_and_W;					/* 0x3a8 */
+	u64 mfc_fir_chkstp_enable_RW;				/* 0x3b0 */
+	u8  pad_0x3b8_0x3c8[0x3c8 - 0x3b8];			/* 0x3b8 */
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
+	u8  pad_0x818_0x900[0x900 - 0x818];			/* 0x818 */
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
--- linux-2.6-ppc.orig/mm/memory.c	2005-04-01 12:39:56.630979688 -0500
+++ linux-2.6-ppc/mm/memory.c	2005-04-01 12:53:32.111951736 -0500
@@ -2108,6 +2108,7 @@ unsigned long vmalloc_to_pfn(void * vmal
 {
 	return page_to_pfn(vmalloc_to_page(vmalloc_addr));
 }
+EXPORT_SYMBOL_GPL(handle_mm_fault);
 
 EXPORT_SYMBOL(vmalloc_to_pfn);
 

