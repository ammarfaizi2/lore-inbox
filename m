Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751811AbWDCWU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbWDCWU3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 18:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWDCWU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 18:20:29 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:39393 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1751811AbWDCWU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 18:20:27 -0400
Subject: [PATCH] kexec on ia64
From: Khalid Aziz <khalid_aziz@hp.com>
To: LKML <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Linux ia64 <linux-ia64@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 16:20:18 -0600
Message-Id: <1144102818.8279.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add kexec support on ia64.

Signed-off-by: Khalid Aziz <khalid.aziz@hp.com>
---

diff -urNp linux-2.6.16/arch/ia64/hp/common/sba_iommu.c linux-2.6.16-kexec/arch/ia64/hp/common/sba_iommu.c
--- linux-2.6.16/arch/ia64/hp/common/sba_iommu.c	2006-03-19 22:53:29.000000000 -0700
+++ linux-2.6.16-kexec/arch/ia64/hp/common/sba_iommu.c	2006-03-27 15:42:47.000000000 -0700
@@ -1624,6 +1624,28 @@ ioc_iova_init(struct ioc *ioc)
 	READ_REG(ioc->ioc_hpa + IOC_IBASE);
 }
 
+#ifdef CONFIG_KEXEC
+void
+ioc_iova_disable(void)
+{
+	struct ioc *ioc;
+
+	ioc = ioc_list;
+
+	while (ioc != NULL) {
+		/* Disable IOVA translation */
+		WRITE_REG(ioc->ibase & 0xfffffffffffffffe, ioc->ioc_hpa + IOC_IBASE);
+		READ_REG(ioc->ioc_hpa + IOC_IBASE);
+
+		/* Clear I/O TLB of any possible entries */
+		WRITE_REG(ioc->ibase | (get_iovp_order(ioc->iov_size) + iovp_shift), ioc->ioc_hpa + IOC_PCOM);
+		READ_REG(ioc->ioc_hpa + IOC_PCOM);
+
+		ioc = ioc->next;
+	}
+}
+#endif
+
 static void __init
 ioc_resource_init(struct ioc *ioc)
 {
diff -urNp linux-2.6.16/arch/ia64/Kconfig linux-2.6.16-kexec/arch/ia64/Kconfig
--- linux-2.6.16/arch/ia64/Kconfig	2006-03-19 22:53:29.000000000 -0700
+++ linux-2.6.16-kexec/arch/ia64/Kconfig	2006-03-27 15:42:47.000000000 -0700
@@ -376,6 +376,23 @@ config IA64_PALINFO
 config SGI_SN
 	def_bool y if (IA64_SGI_SN2 || IA64_GENERIC)
 
+config KEXEC
+	bool "kexec system call (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  kexec is a system call that implements the ability to shutdown your
+	  current kernel, and to start another kernel.  It is like a reboot
+	  but it is indepedent of the system firmware.   And like a reboot
+	  you can start any kernel with it, not just Linux.
+
+	  The name comes from the similiarity to the exec system call.
+
+	  It is an ongoing process to be certain the hardware in a machine
+	  is properly shutdown, so do not be surprised if this code does not
+	  initially work for you.  It may help to enable device hotplugging
+	  support.  As of this writing the exact hardware interface is
+	  strongly in flux, so no good recommendation can be made.
+
 source "drivers/firmware/Kconfig"
 
 source "fs/Kconfig.binfmt"
diff -urNp linux-2.6.16/arch/ia64/kernel/crash.c linux-2.6.16-kexec/arch/ia64/kernel/crash.c
--- linux-2.6.16/arch/ia64/kernel/crash.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.16-kexec/arch/ia64/kernel/crash.c	2006-03-27 15:49:44.000000000 -0700
@@ -0,0 +1,43 @@
+/*
+ * arch/ia64/kernel/crash.c
+ *
+ * Architecture specific (ia64) functions for kexec based crash dumps.
+ *
+ * Created by: Khalid Aziz <khalid.aziz@hp.com>
+ *
+ * Copyright (C) 2005 Hewlett-Packard Development Company, L.P.
+ *
+ */
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/irq.h>
+#include <linux/reboot.h>
+#include <linux/kexec.h>
+#include <linux/irq.h>
+#include <linux/delay.h>
+#include <linux/elf.h>
+#include <linux/elfcore.h>
+#include <linux/device.h>
+
+void
+machine_crash_shutdown(struct pt_regs *pt)
+{
+	/* This function is only called after the system
+	 * has paniced or is otherwise in a critical state.
+	 * The minimum amount of code to allow a kexec'd kernel
+	 * to run successfully needs to happen here.
+	 *
+	 * In practice this means shooting down the other cpus in
+	 * an SMP system.
+	 */
+	if (in_interrupt()) {
+		terminate_irqs();
+		ia64_eoi();
+	}
+	system_state = SYSTEM_RESTART;
+	device_shutdown();
+	system_state = SYSTEM_BOOTING;
+	machine_shutdown();
+}
diff -urNp linux-2.6.16/arch/ia64/kernel/entry.S linux-2.6.16-kexec/arch/ia64/kernel/entry.S
--- linux-2.6.16/arch/ia64/kernel/entry.S	2006-03-19 22:53:29.000000000 -0700
+++ linux-2.6.16-kexec/arch/ia64/kernel/entry.S	2006-03-27 15:42:47.000000000 -0700
@@ -1590,7 +1590,7 @@ sys_call_table:
 	data8 sys_mq_timedreceive		// 1265
 	data8 sys_mq_notify
 	data8 sys_mq_getsetattr
-	data8 sys_ni_syscall			// reserved for kexec_load
+	data8 sys_kexec_load
 	data8 sys_ni_syscall			// reserved for vserver
 	data8 sys_waitid			// 1270
 	data8 sys_add_key
diff -urNp linux-2.6.16/arch/ia64/kernel/machine_kexec.c linux-2.6.16-kexec/arch/ia64/kernel/machine_kexec.c
--- linux-2.6.16/arch/ia64/kernel/machine_kexec.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.16-kexec/arch/ia64/kernel/machine_kexec.c	2006-04-03 13:42:09.000000000 -0600
@@ -0,0 +1,149 @@
+/*
+ * arch/ia64/kernel/machine_kexec.c 
+ *
+ * Handle transition of Linux booting another kernel
+ * Copyright (C) 2005 Hewlett-Packard Development Comapny, L.P.
+ * Copyright (C) 2005 Khalid Aziz <khalid.aziz@hp.com>
+ * Copyright (C) 2006 Intel Corp, Zou Nan hai <nanhai.zou@intel.com>
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/kexec.h>
+#include <linux/pci.h>
+#include <linux/cpu.h>
+#include <asm/mmu_context.h>
+#include <asm/setup.h>
+#include <asm/mca.h>
+#include <asm/page.h>
+#include <asm/bitops.h>
+#include <asm/tlbflush.h>
+#include <asm/delay.h>
+#include <asm/meminit.h>
+
+extern unsigned long ia64_iobase;
+
+static void set_io_base(void)
+{
+	unsigned long phys_iobase;
+
+	/* set kr0 to iobase */
+	phys_iobase = __pa(ia64_iobase);
+	ia64_set_kr(IA64_KR_IO_BASE, __IA64_UNCACHED_OFFSET | phys_iobase);
+};
+
+typedef void (*relocate_new_kernel_t)( unsigned long, unsigned long, 
+		struct ia64_boot_param *, unsigned long);
+
+/*
+ * Do what every setup is needed on image and the
+ * reboot code buffer to allow us to avoid allocations
+ * later.
+ */
+int machine_kexec_prepare(struct kimage *image)
+{
+	void *control_code_buffer;
+	const unsigned long *func;
+
+	func = (unsigned long *)&relocate_new_kernel;
+	/* Pre-load control code buffer to minimize work in kexec path */
+	control_code_buffer = page_address(image->control_code_page);
+	memcpy((void *)control_code_buffer, (const void *)func[0], 
+			relocate_new_kernel_size);
+	flush_icache_range((unsigned long)control_code_buffer, 
+			(unsigned long)control_code_buffer + relocate_new_kernel_size);
+
+	return 0;
+}
+
+void machine_kexec_cleanup(struct kimage *image)
+{
+}
+
+#ifdef CONFIG_PCI
+void machine_shutdown(void)
+{
+	struct pci_dev *dev;
+	irq_desc_t *idesc;
+	cpumask_t mask = CPU_MASK_NONE;
+
+	/* Disable all PCI devices */
+	list_for_each_entry(dev, &pci_devices, global_list) {
+		if (!(dev->is_enabled))
+			continue;
+		idesc = irq_descp(dev->irq);
+		if (!idesc)
+			continue;
+		cpu_set(0, mask);
+		disable_irq_nosync(dev->irq);
+		idesc->handler->end(dev->irq);
+		idesc->handler->set_affinity(dev->irq, mask);
+		idesc->action = NULL;
+		pci_disable_device(dev);
+		pci_set_power_state(dev, 0);
+	}
+}
+#endif
+
+/*
+ * Do not allocate memory (or fail in any way) in machine_kexec().
+ * We are past the point of no return, committed to rebooting now. 
+ */
+void machine_kexec(struct kimage *image)
+{
+	unsigned long indirection_page;
+	relocate_new_kernel_t rnk;
+	unsigned long pta, impl_va_bits;
+	void *pal_addr = efi_get_pal_addr();
+	unsigned long code_addr = (unsigned long)page_address(image->control_code_page);
+
+#ifdef CONFIG_HOTPLUG_CPU
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		if (cpu != smp_processor_id())
+			cpu_down(cpu);
+	}
+#elif CONFIG_SMP
+	smp_call_function(kexec_stop_this_cpu, (void *)image->start, 0, 0);
+#endif
+
+	ia64_set_itv(1<<16);
+	/* Interrupts aren't acceptable while we reboot */
+	local_irq_disable();
+
+	/* set kr0 to the appropriate address */
+	set_io_base();
+
+	/* Disable VHPT */
+	impl_va_bits = ffz(~(local_cpu_data->unimpl_va_mask | (7UL << 61)));
+	pta = POW2(61) - POW2(vmlpt_bits);
+	ia64_set_pta(pta | (0 << 8) | (vmlpt_bits << 2) | 0);
+
+#ifdef CONFIG_IA64_HP_ZX1
+	ioc_iova_disable();
+#endif
+	/* now execute the control code.
+	 * We will start by executing the control code linked into the 
+	 * kernel as opposed to the code we copied in control code buffer		 * page. When this code switches to physical mode, we will start
+	 * executing the code in control code buffer page. Reason for
+	 * doing this is we start code execution in virtual address space.
+	 * If we were to try to execute the newly copied code in virtual
+	 * address space, we will need to make an ITLB entry to avoid ITLB 
+	 * miss. By executing the code linked into kernel, we take advantage
+	 * of the ITLB entry already in place for kernel and avoid making
+	 * a new entry.
+	 */
+	indirection_page = image->head & PAGE_MASK;
+
+	rnk = (relocate_new_kernel_t)&code_addr;
+	(*rnk)(indirection_page, image->start, ia64_boot_param,
+		     GRANULEROUNDDOWN((unsigned long) pal_addr));
+	BUG();
+	for (;;)
+		;
+}
diff -urNp linux-2.6.16/arch/ia64/kernel/Makefile linux-2.6.16-kexec/arch/ia64/kernel/Makefile
--- linux-2.6.16/arch/ia64/kernel/Makefile	2006-03-19 22:53:29.000000000 -0700
+++ linux-2.6.16-kexec/arch/ia64/kernel/Makefile	2006-03-27 15:42:47.000000000 -0700
@@ -28,6 +28,7 @@ obj-$(CONFIG_IA64_CYCLONE)	+= cyclone.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_IA64_MCA_RECOVERY)	+= mca_recovery.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o jprobes.o
+obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o crash.o
 obj-$(CONFIG_IA64_UNCACHED_ALLOCATOR)	+= uncached.o
 mca_recovery-y			+= mca_drv.o mca_drv_asm.o
 
diff -urNp linux-2.6.16/arch/ia64/kernel/relocate_kernel.S linux-2.6.16-kexec/arch/ia64/kernel/relocate_kernel.S
--- linux-2.6.16/arch/ia64/kernel/relocate_kernel.S	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.16-kexec/arch/ia64/kernel/relocate_kernel.S	2006-03-31 09:04:10.000000000 -0700
@@ -0,0 +1,359 @@
+/*
+ * arch/ia64/kernel/relocate_kernel.S 
+ *
+ * Relocate kexec'able kernel and start it
+ *
+ * Copyright (C) 2005 Hewlett-Packard Development Company, L.P.
+ * Copyright (C) 2005 Khalid Aziz  <khalid.aziz@hp.com>
+ * Copyright (C) 2005 Intel Corp,  Zou Nan hai <nanhai.zou@intel.com>
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+#include <linux/config.h>
+#include <asm/asmmacro.h>
+#include <asm/kregs.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/mca_asm.h>
+
+       /* Must be relocatable PIC code callable as a C function, that once
+        * it starts can not use the previous processes stack.
+        *
+        */
+GLOBAL_ENTRY(relocate_new_kernel)
+	.prologue
+	alloc r31=ar.pfs,4,0,0,0
+        .body
+.reloc_entry:
+{
+	rsm psr.i| psr.ic
+	mov r2=ip
+}
+	;;
+{
+        flushrs                         // must be first insn in group
+        srlz.i
+}
+	;;
+
+	//first switch to physical mode
+	add r3=1f-.reloc_entry, r2
+	movl r16 = IA64_PSR_AC|IA64_PSR_BN|IA64_PSR_IC|IA64_PSR_MFL
+	mov ar.rsc=0	          	// put RSE in enforced lazy mode
+	;;
+	add r2=(memory_stack-.reloc_entry), r2
+	;;
+	add sp=(memory_stack_end - .reloc_entry),r2
+	add r8=(register_stack - .reloc_entry),r2
+	;;
+	tpa sp=sp
+	tpa r3=r3
+	;;
+	loadrs
+	;;
+	mov r18=ar.rnat
+	mov ar.bspstore=r8
+	;;
+        mov cr.ipsr=r16
+        mov cr.iip=r3
+        mov cr.ifs=r0
+	srlz.i
+	;;
+	mov ar.rnat=r18
+	rfi
+	;;
+1:
+	//physical mode code begin
+	mov b6=in1
+	tpa r28=in2			// tpa must before TLB purge
+
+	// purge all TC entries
+#define O(member)       IA64_CPUINFO_##member##_OFFSET
+        GET_THIS_PADDR(r2, cpu_info)    // load phys addr of cpu_info into r2
+        ;;
+        addl r17=O(PTCE_STRIDE),r2
+        addl r2=O(PTCE_BASE),r2
+        ;;
+        ld8 r18=[r2],(O(PTCE_COUNT)-O(PTCE_BASE));;    	// r18=ptce_base
+        ld4 r19=[r2],4                                  // r19=ptce_count[0]
+        ld4 r21=[r17],4                                 // r21=ptce_stride[0]
+        ;;
+        ld4 r20=[r2]                                    // r20=ptce_count[1]
+        ld4 r22=[r17]                                   // r22=ptce_stride[1]
+        mov r24=r0
+        ;;
+        adds r20=-1,r20
+        ;;
+#undef O
+2:
+        cmp.ltu p6,p7=r24,r19
+(p7)    br.cond.dpnt.few 4f
+        mov ar.lc=r20
+3:
+        ptc.e r18
+        ;;
+        add r18=r22,r18
+        br.cloop.sptk.few 3b
+        ;;
+        add r18=r21,r18
+        add r24=1,r24
+        ;;
+        br.sptk.few 2b
+4:
+        srlz.i
+        ;;
+	//purge TR entry for kernel text and data
+        movl r16=KERNEL_START
+        mov r18=KERNEL_TR_PAGE_SHIFT<<2
+        ;;
+        ptr.i r16, r18
+        ptr.d r16, r18
+        ;;
+        srlz.i
+        ;;
+
+	// purge TR entry for percpu data
+        movl r16=PERCPU_ADDR
+        mov r18=PERCPU_PAGE_SHIFT<<2
+        ;;
+        ptr.d r16,r18
+        ;;
+        srlz.d
+	;;
+
+        // purge TR entry for pal code
+        mov r16=in3
+        mov r18=IA64_GRANULE_SHIFT<<2
+        ;;
+        ptr.i r16,r18
+        ;;
+        srlz.i
+	;;
+
+        // purge TR entry for stack
+        mov r16=IA64_KR(CURRENT_STACK)
+        ;;
+        shl r16=r16,IA64_GRANULE_SHIFT
+        movl r19=PAGE_OFFSET
+        ;;
+        add r16=r19,r16
+        mov r18=IA64_GRANULE_SHIFT<<2
+        ;;
+        ptr.d r16,r18
+        ;;
+        srlz.i
+	;;
+
+	// copy kexec kernel segments
+	movl r16=PAGE_MASK
+	ld8  r30=[in0],8;;			// in0 is page_list
+	br.sptk.few .dest_page
+	;;
+.loop:
+	ld8  r30=[in0], 8;;
+.dest_page:
+	tbit.z p0, p6=r30, 0;;    	// 0x1 dest page
+(p6)	and r17=r30, r16
+(p6)	br.cond.sptk.few .loop;;
+
+	tbit.z p0, p6=r30, 1;;		// 0x2 indirect page
+(p6)	and in0=r30, r16
+(p6)	br.cond.sptk.few .loop;;
+
+	tbit.z p0, p6=r30, 2;;		// 0x4 end flag
+(p6)	br.cond.sptk.few .end_loop;;
+
+	tbit.z p6, p0=r30, 3;;		// 0x8 source page
+(p6)	br.cond.sptk.few .loop
+
+	and r18=r30, r16
+
+	// simple copy page, may optimize later
+	movl r14=PAGE_SIZE/8 - 1;;
+	mov ar.lc=r14;;
+1:
+	ld8 r14=[r18], 8;;
+	st8 [r17]=r14, 8;;
+	fc.i r17
+	br.ctop.sptk.few 1b
+	br.sptk.few .loop
+	;;
+
+.end_loop:
+	sync.i			// for fc.i
+	;;
+	srlz.i
+	;;
+	srlz.d
+	;;
+	br.call.sptk.many b0=b6;;
+memory_stack:
+	.fill           8192, 1, 0
+memory_stack_end:
+register_stack:
+	.fill           8192, 1, 0
+register_stack_end:
+relocate_new_kernel_end:
+END(relocate_new_kernel)
+
+GLOBAL_ENTRY(kexec_fake_sal_rendez)
+	.prologue
+	alloc r31=ar.pfs,3,0,0,0
+	.body
+.rendez_entry:
+	rsm	psr.i | psr.ic
+	mov r25=ip
+	;;
+	{
+		flushrs
+		srlz.i
+	}
+	;;
+       /* See where I am running, and compute gp */
+	{
+		mov     ar.rsc = 0      /* Put RSE in enforce lacy, LE mode */
+		mov     gp = ip         /* gp == relocate_new_kernel */
+	}
+
+	movl r8=0x00000100000000
+	;;
+	mov cr.iva=r8
+	/* Transition from virtual to physical mode */
+	srlz.i
+	;;
+	add	r17=5f-.rendez_entry, r25
+	movl	r16=(IA64_PSR_AC | IA64_PSR_BN | IA64_PSR_IC | IA64_PSR_MFL)
+	;;
+	tpa	r17=r17
+	mov	cr.ipsr=r16
+	;;
+	mov	cr.iip=r17
+	mov	cr.ifs=r0
+	;;
+	rfi
+	;;
+5:
+	mov     b6=in0			/* _start addr */
+	mov	r8=in1			/* ap_wakeup_vector */
+	mov	r26=in2			/* PAL addr */
+	;;
+	/* Purge kernel TRs */
+	movl	r16=KERNEL_START
+	mov	r18=KERNEL_TR_PAGE_SHIFT<<2
+	;;
+	ptr.i	r16,r18
+	ptr.d	r16,r18
+	;;
+	srlz.i
+	;;
+	srlz.d
+	;;
+	/* Purge percpu TR */
+	movl	r16=PERCPU_ADDR
+	mov	r18=PERCPU_PAGE_SHIFT<<2
+	;;
+	ptr.d	r16,r18
+	;;
+	srlz.d
+	;;
+	/* Purge PAL TR */
+	mov	r18=IA64_GRANULE_SHIFT<<2
+	;;
+	ptr.i	r26,r18
+	;;
+	srlz.i
+	;;
+	/* Purge stack TR */
+	mov	r16=IA64_KR(CURRENT_STACK)
+	;;
+	shl	r16=r16,IA64_GRANULE_SHIFT
+	movl	r19=PAGE_OFFSET
+	;;
+	add	r16=r19,r16
+	mov	r18=IA64_GRANULE_SHIFT<<2
+	;;
+	ptr.d	r16,r18
+	;;
+	srlz.i
+	;;
+
+	/* Ensure we can read and clear external interrupts */
+	mov	cr.tpr=r0
+	srlz.d
+
+	shr.u	r9=r8,6			/* which irr */
+	;;
+	and	r8=63,r8		/* bit offset into irr */
+	;;
+	mov	r10=1;;
+	;;
+	shl	r10=r10,r8		/* bit mask off irr we want */
+	cmp.eq	p6,p0=0,r9
+	;;
+(p6)	br.cond.sptk.few        check_irr0
+	cmp.eq	p7,p0=1,r9
+	;;
+(p7)	br.cond.sptk.few        check_irr1
+	cmp.eq	p8,p0=2,r9
+	;;
+(p8)	br.cond.sptk.few        check_irr2
+	cmp.eq	p9,p0=3,r9
+	;;
+(p9)	br.cond.sptk.few        check_irr3
+
+check_irr0:
+	mov	r8=cr.irr0
+	;;
+	and	r8=r8,r10
+	;;
+	cmp.eq	p6,p0=0,r8
+(p6)	br.cond.sptk.few	check_irr0
+	br.few	call_start
+	
+check_irr1:
+	mov	r8=cr.irr1
+	;;
+	and	r8=r8,r10
+	;;
+	cmp.eq	p6,p0=0,r8
+(p6)	br.cond.sptk.few	check_irr1
+	br.few	call_start
+	
+check_irr2:
+	mov	r8=cr.irr2
+	;;
+	and	r8=r8,r10
+	;;
+	cmp.eq	p6,p0=0,r8
+(p6)	br.cond.sptk.few	check_irr2
+	br.few	call_start
+	
+check_irr3:
+	mov	r8=cr.irr3
+	;;
+	and	r8=r8,r10
+	;;
+	cmp.eq	p6,p0=0,r8
+(p6)	br.cond.sptk.few	check_irr3
+	br.few	call_start
+	
+call_start:
+	mov	cr.eoi=r0
+	;;
+	srlz.d
+	;;
+	mov	r8=cr.ivr
+	;;
+	srlz.d
+	;;
+	cmp.eq	p0,p6=15,r8
+(p6)	br.cond.sptk.few	call_start
+	br.sptk.few		b6
+kexec_fake_sal_rendez_end:
+END(kexec_fake_sal_rendez)
+
+	.global relocate_new_kernel_size
+relocate_new_kernel_size:
+	data8	kexec_fake_sal_rendez_end - relocate_new_kernel
+
diff -urNp linux-2.6.16/arch/ia64/kernel/smp.c linux-2.6.16-kexec/arch/ia64/kernel/smp.c
--- linux-2.6.16/arch/ia64/kernel/smp.c	2006-03-19 22:53:29.000000000 -0700
+++ linux-2.6.16-kexec/arch/ia64/kernel/smp.c	2006-03-27 17:14:04.000000000 -0700
@@ -30,6 +30,7 @@
 #include <linux/delay.h>
 #include <linux/efi.h>
 #include <linux/bitops.h>
+#include <linux/kexec.h>
 
 #include <asm/atomic.h>
 #include <asm/current.h>
@@ -84,6 +85,34 @@ unlock_ipi_calllock(void)
 	spin_unlock_irq(&call_lock);
 }
 
+#ifdef CONFIG_KEXEC
+/*
+ * Stop the CPU and put it in fake SAL rendezvous. This allows CPU to wake
+ * up with IPI from boot processor
+ */
+void
+kexec_stop_this_cpu (void *func)
+{
+	unsigned long pta, impl_va_bits, pal_base;
+
+	/*
+	 * Remove this CPU by putting it into fake SAL rendezvous
+	 */
+	cpu_clear(smp_processor_id(), cpu_online_map);
+	max_xtp();
+	ia64_eoi();
+
+	/* Disable VHPT */
+	impl_va_bits = ffz(~(local_cpu_data->unimpl_va_mask | (7UL << 61)));
+	pta = POW2(61) - POW2(vmlpt_bits);
+	ia64_set_pta(pta | (0 << 8) | (vmlpt_bits << 2) | 0);
+
+	local_irq_disable();
+	pal_base = __get_cpu_var(ia64_mca_pal_base);
+	kexec_fake_sal_rendez(func, ap_wakeup_vector, pal_base);
+}
+#endif
+
 static void
 stop_this_cpu (void)
 {
diff -urNp linux-2.6.16/include/asm-ia64/kexec.h linux-2.6.16-kexec/include/asm-ia64/kexec.h
--- linux-2.6.16/include/asm-ia64/kexec.h	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.16-kexec/include/asm-ia64/kexec.h	2006-03-30 11:46:46.000000000 -0700
@@ -0,0 +1,36 @@
+#ifndef _ASM_IA64_KEXEC_H
+#define _ASM_IA64_KEXEC_H
+
+
+/* Maximum physical address we can use pages from */
+#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
+/* Maximum address we can reach in physical address mode */
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
+/* Maximum address we can use for the control code buffer */
+#define KEXEC_CONTROL_MEMORY_LIMIT TASK_SIZE
+
+#define KEXEC_CONTROL_CODE_SIZE (8192 + 8192 + 4096)
+
+/* The native architecture */
+#define KEXEC_ARCH KEXEC_ARCH_IA_64
+
+#define MAX_NOTE_BYTES 1024
+
+#define pte_bits	3
+#define vmlpt_bits	(impl_va_bits - PAGE_SHIFT + pte_bits)
+#define POW2(n)		(1ULL << (n))
+
+DECLARE_PER_CPU(u64, ia64_mca_pal_base);
+
+const extern unsigned int relocate_new_kernel_size;
+volatile extern long kexec_rendez;
+extern void relocate_new_kernel(unsigned long, unsigned long, 
+		struct ia64_boot_param *, unsigned long);
+extern void kexec_fake_sal_rendez(void *start, unsigned long wake_up,
+		unsigned long pal_base);
+
+static inline void
+crash_setup_regs(struct pt_regs *newregs, struct pt_regs *oldregs)
+{
+}
+#endif /* _ASM_IA64_KEXEC_H */
diff -urNp linux-2.6.16/include/asm-ia64/machvec_hpzx1.h linux-2.6.16-kexec/include/asm-ia64/machvec_hpzx1.h
--- linux-2.6.16/include/asm-ia64/machvec_hpzx1.h	2006-03-19 22:53:29.000000000 -0700
+++ linux-2.6.16-kexec/include/asm-ia64/machvec_hpzx1.h	2006-03-27 15:58:38.000000000 -0700
@@ -34,4 +34,6 @@ extern ia64_mv_dma_mapping_error	sba_dma
 #define platform_dma_supported			sba_dma_supported
 #define platform_dma_mapping_error		sba_dma_mapping_error
 
+extern void ioc_iova_disable(void);
+
 #endif /* _ASM_IA64_MACHVEC_HPZX1_h */
diff -urNp linux-2.6.16/include/asm-ia64/smp.h linux-2.6.16-kexec/include/asm-ia64/smp.h
--- linux-2.6.16/include/asm-ia64/smp.h	2006-03-19 22:53:29.000000000 -0700
+++ linux-2.6.16-kexec/include/asm-ia64/smp.h	2006-03-27 15:52:51.000000000 -0700
@@ -129,6 +129,9 @@ extern void smp_send_reschedule (int cpu
 extern void lock_ipi_calllock(void);
 extern void unlock_ipi_calllock(void);
 extern void identify_siblings (struct cpuinfo_ia64 *);
+#ifdef CONFIG_KEXEC
+extern void kexec_stop_this_cpu(void *);
+#endif
 
 #else
 
diff -urNp linux-2.6.16/include/linux/irq.h linux-2.6.16-kexec/include/linux/irq.h
--- linux-2.6.16/include/linux/irq.h	2006-03-19 22:53:29.000000000 -0700
+++ linux-2.6.16-kexec/include/linux/irq.h	2006-03-27 15:49:27.000000000 -0700
@@ -94,6 +94,7 @@ irq_descp (int irq)
 #include <asm/hw_irq.h> /* the arch dependent stuff */
 
 extern int setup_irq(unsigned int irq, struct irqaction * new);
+extern void terminate_irqs(void);
 
 #ifdef CONFIG_GENERIC_HARDIRQS
 extern cpumask_t irq_affinity[NR_IRQS];
diff -urNp linux-2.6.16/kernel/irq/manage.c linux-2.6.16-kexec/kernel/irq/manage.c
--- linux-2.6.16/kernel/irq/manage.c	2006-03-19 22:53:29.000000000 -0700
+++ linux-2.6.16-kexec/kernel/irq/manage.c	2006-03-27 17:02:08.000000000 -0700
@@ -377,3 +377,22 @@ int request_irq(unsigned int irq,
 
 EXPORT_SYMBOL(request_irq);
 
+/*
+ * Terminate any outstanding interrupts
+ */
+void terminate_irqs(void)
+{
+	struct irqaction * action;
+	irq_desc_t *idesc;
+	int i;
+
+	for (i=0; i<NR_IRQS; i++) {
+		idesc = irq_descp(i);
+		action = idesc->action;
+		if (!action)
+			continue;
+		if (idesc->handler->end)
+			idesc->handler->end(i);
+	}
+}
+


