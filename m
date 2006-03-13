Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWCMRjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWCMRjp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 12:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbWCMRjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 12:39:45 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:37846 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1751578AbWCMRjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 12:39:42 -0500
Subject: [PATCH] kexec for ia64
From: Khalid Aziz <khalid_aziz@hp.com>
To: Fastboot mailing list <fastboot@lists.osdl.org>,
       Linux ia64 <linux-ia64@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>
Cc: "Luck, Tony" <tony.luck@intel.com>
Content-Type: multipart/mixed; boundary="=-heiMyns1HKTsdqdGLpY9"
Date: Mon, 13 Mar 2006 10:39:36 -0700
Message-Id: <1142271576.10787.15.camel@lyra.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-heiMyns1HKTsdqdGLpY9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I have updated kexec patch for ia64. Attached patch fixes a couple of
bugs from previous version and incorporates code developed by Nan Hai.
This patch works on 2.6.16-rc6 kernel. Also attached is a patch for
kexec-tools which applies on top of kexec-tools-1.101 release from Eric
Biederman <http://www.xmission.com/%
7Eebiederm/files/kexec/kexec-tools-1.101.tar.gz> and adds support for
ia64. Please test and provide feedback.

I am working on integrating kdump support and will post that patch once
I have tested it.

-- 
Khalid

====================================================================
Khalid Aziz                       Open Source and Linux Organization
(970)898-9214                                        Hewlett-Packard
khalid.aziz@hp.com                                  Fort Collins, CO

"The Linux kernel is subject to relentless development" 
                                - Alessandro Rubini


--=-heiMyns1HKTsdqdGLpY9
Content-Disposition: attachment; filename=kexec-ia64-2.6.16-rc2.patch
Content-Type: text/x-patch; name=kexec-ia64-2.6.16-rc2.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -urNp linux-2.6.16-rc2/arch/ia64/hp/common/sba_iommu.c linux-2.6.16-rc2-ia64kexec/arch/ia64/hp/common/sba_iommu.c
--- linux-2.6.16-rc2/arch/ia64/hp/common/sba_iommu.c	2006-01-02 20:21:10.000000000 -0700
+++ linux-2.6.16-rc2-ia64kexec/arch/ia64/hp/common/sba_iommu.c	2006-02-09 14:38:48.000000000 -0700
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
diff -urNp linux-2.6.16-rc2/arch/ia64/Kconfig linux-2.6.16-rc2-ia64kexec/arch/ia64/Kconfig
--- linux-2.6.16-rc2/arch/ia64/Kconfig	2006-01-02 20:21:10.000000000 -0700
+++ linux-2.6.16-rc2-ia64kexec/arch/ia64/Kconfig	2006-02-09 14:43:33.000000000 -0700
@@ -374,6 +374,23 @@ config IA64_PALINFO
 	  To use this option, you have to ensure that the "/proc file system
 	  support" (CONFIG_PROC_FS) is enabled, too.
 
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
diff -urNp linux-2.6.16-rc2/arch/ia64/kernel/crash.c linux-2.6.16-rc2-ia64kexec/arch/ia64/kernel/crash.c
--- linux-2.6.16-rc2/arch/ia64/kernel/crash.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.16-rc2-ia64kexec/arch/ia64/kernel/crash.c	2006-02-09 15:36:23.000000000 -0700
@@ -0,0 +1,46 @@
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
+
+extern void device_shutdown(void);
+
+void
+machine_crash_shutdown(struct pt_regs *pt)
+{
+	extern void terminate_irqs(void);
+
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
diff -urNp linux-2.6.16-rc2/arch/ia64/kernel/entry.S linux-2.6.16-rc2-ia64kexec/arch/ia64/kernel/entry.S
--- linux-2.6.16-rc2/arch/ia64/kernel/entry.S	2006-02-09 10:48:40.000000000 -0700
+++ linux-2.6.16-rc2-ia64kexec/arch/ia64/kernel/entry.S	2006-02-09 11:34:02.000000000 -0700
@@ -1588,7 +1588,7 @@ sys_call_table:
 	data8 sys_mq_timedreceive		// 1265
 	data8 sys_mq_notify
 	data8 sys_mq_getsetattr
-	data8 sys_ni_syscall			// reserved for kexec_load
+	data8 sys_kexec_load
 	data8 sys_ni_syscall			// reserved for vserver
 	data8 sys_waitid			// 1270
 	data8 sys_add_key
diff -urNp linux-2.6.16-rc2/arch/ia64/kernel/machine_kexec.c linux-2.6.16-rc2-ia64kexec/arch/ia64/kernel/machine_kexec.c
--- linux-2.6.16-rc2/arch/ia64/kernel/machine_kexec.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.16-rc2-ia64kexec/arch/ia64/kernel/machine_kexec.c	2006-03-10 14:36:51.000000000 -0700
@@ -0,0 +1,165 @@
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
+#ifdef CONFIG_HOTPLUG_CPU
+#include <linux/cpu.h>
+#endif
+#include <asm/mmu_context.h>
+#include <asm/setup.h>
+#include <asm/mca.h>
+#include <asm/page.h>
+#include <asm/bitops.h>
+#include <asm/tlbflush.h>
+#include <asm/delay.h>
+
+DECLARE_PER_CPU(u64, ia64_mca_pal_base);
+
+extern unsigned long ia64_iobase;
+extern unsigned long kexec_reboot;
+extern void kexec_stop_this_cpu(void *);
+extern struct subsystem devices_subsys;
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
+const extern unsigned char relocate_new_kernel[];
+const extern unsigned long kexec_fake_sal_rendez[];
+const extern unsigned int relocate_new_kernel_size;
+extern void ioc_iova_disable(void);
+
+volatile extern long kexec_rendez;
+volatile const extern unsigned char kexec_rendez_reloc[];
+
+/*
+ * Do what every setup is needed on image and the
+ * reboot code buffer to allow us to avoid allocations
+ * later.
+ */
+int machine_kexec_prepare(struct kimage *image)
+{
+	void *control_code_buffer;
+
+	/* Pre-load control code buffer to minimize work in kexec path */
+	control_code_buffer = page_address(image->control_code_page);
+	memcpy((void *)control_code_buffer, &relocate_new_kernel, relocate_new_kernel_size);
+	kexec_rendez = (long)(page_to_pfn(image->control_code_page) << PAGE_SHIFT) + (long)kexec_rendez_reloc -  (long)&kexec_fake_sal_rendez;
+	flush_icache_range(control_code_buffer, 
+			control_code_buffer + relocate_new_kernel_size);
+
+	return 0;
+}
+
+void machine_kexec_cleanup(struct kimage *image)
+{
+}
+
+void machine_shutdown(void)
+{
+	struct pci_dev *dev;
+	irq_desc_t *idesc;
+	cpumask_t mask = CPU_MASK_NONE;
+
+	/* Disable all PCI devices */
+	list_for_each_entry(dev, &pci_devices, global_list) {
+		if (!(dev->is_enabled)) {
+			continue;
+		}
+		if (!(idesc = irq_descp(dev->irq)))
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
+
+/*
+ * Do not allocate memory (or fail in any way) in machine_kexec().
+ * We are past the point of no return, committed to rebooting now. 
+ */
+void machine_kexec(struct kimage *image)
+{
+	unsigned long indirection_page;
+	relocate_new_kernel_t rnk;
+	void *pal_addr = efi_get_pal_addr();
+	unsigned long code_addr = (unsigned long)page_address(image->control_code_page);
+
+#ifdef CONFIG_SMP
+#ifdef CONFIG_HOTPLUG_CPU
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		if (cpu != smp_processor_id())
+			cpu_down(cpu);
+	}
+#else
+	smp_call_function(kexec_stop_this_cpu, (void *)image->start, 0, 0);
+#endif
+#endif
+
+	ia64_set_itv(1<<16);
+	/* Interrupts aren't acceptable while we reboot */
+	local_irq_disable();
+
+	/* set kr0 to the appropriate address */
+	set_io_base();
+
+	{
+		unsigned long pta, impl_va_bits;
+
+#       define pte_bits                 3
+#       define vmlpt_bits               (impl_va_bits - PAGE_SHIFT + pte_bits)
+#       define POW2(n)                  (1ULL << (n))
+
+		/* Disable VHPT */
+		impl_va_bits = ffz(~(local_cpu_data->unimpl_va_mask | (7UL << 61)));
+		pta = POW2(61) - POW2(vmlpt_bits);
+		ia64_set_pta(pta | (0 << 8) | (vmlpt_bits << 2) | 0);
+	}
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
+}
diff -urNp linux-2.6.16-rc2/arch/ia64/kernel/Makefile linux-2.6.16-rc2-ia64kexec/arch/ia64/kernel/Makefile
--- linux-2.6.16-rc2/arch/ia64/kernel/Makefile	2006-02-09 10:48:40.000000000 -0700
+++ linux-2.6.16-rc2-ia64kexec/arch/ia64/kernel/Makefile	2006-02-09 14:08:26.000000000 -0700
@@ -28,6 +28,7 @@ obj-$(CONFIG_IA64_CYCLONE)	+= cyclone.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_IA64_MCA_RECOVERY)	+= mca_recovery.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o jprobes.o
+obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o crash.o
 obj-$(CONFIG_IA64_UNCACHED_ALLOCATOR)	+= uncached.o
 mca_recovery-y			+= mca_drv.o mca_drv_asm.o
 
diff -urNp linux-2.6.16-rc2/arch/ia64/kernel/relocate_kernel.S linux-2.6.16-rc2-ia64kexec/arch/ia64/kernel/relocate_kernel.S
--- linux-2.6.16-rc2/arch/ia64/kernel/relocate_kernel.S	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.16-rc2-ia64kexec/arch/ia64/kernel/relocate_kernel.S	2006-02-21 12:22:53.000000000 -0700
@@ -0,0 +1,364 @@
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
+	mf.a
+	;;
+	movl	r25=kexec_rendez
+	;;
+	ld8	r17=[r25]
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
+	rsm	psr.i | psr.ic
+	srlz.i
+	;;
+	movl	r16=(IA64_PSR_AC | IA64_PSR_BN | IA64_PSR_IC | IA64_PSR_MFL)
+	;;
+	mov	cr.ipsr=r16
+	;;
+	mov	cr.iip=r17
+	mov	cr.ifs=r0
+	;;
+	rfi
+	;;
+	.global kexec_rendez_reloc
+kexec_rendez_reloc:     /* Now we are in physical mode */
+
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
+	.global kexec_rendez
+kexec_rendez:	data8 0xdeadbeefdeadbeef
+
diff -urNp linux-2.6.16-rc2/arch/ia64/kernel/smp.c linux-2.6.16-rc2-ia64kexec/arch/ia64/kernel/smp.c
--- linux-2.6.16-rc2/arch/ia64/kernel/smp.c	2006-01-02 20:21:10.000000000 -0700
+++ linux-2.6.16-rc2-ia64kexec/arch/ia64/kernel/smp.c	2006-02-15 16:37:33.000000000 -0700
@@ -30,6 +30,9 @@
 #include <linux/delay.h>
 #include <linux/efi.h>
 #include <linux/bitops.h>
+#ifdef CONFIG_KEXEC
+#include <linux/kexec.h>
+#endif
 
 #include <asm/atomic.h>
 #include <asm/current.h>
@@ -84,6 +87,43 @@ unlock_ipi_calllock(void)
 	spin_unlock_irq(&call_lock);
 }
 
+#ifdef CONFIG_KEXEC
+extern void kexec_fake_sal_rendez(void *start, unsigned long wake_up,
+		unsigned long pal_base);
+
+#define pte_bits	3
+#define vmlpt_bits	(impl_va_bits - PAGE_SHIFT + pte_bits)
+#define POW2(n)		(1ULL << (n))
+
+DECLARE_PER_CPU(u64, ia64_mca_pal_base);
+
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
diff -urNp linux-2.6.16-rc2/include/asm-ia64/kexec.h linux-2.6.16-rc2-ia64kexec/include/asm-ia64/kexec.h
--- linux-2.6.16-rc2/include/asm-ia64/kexec.h	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.16-rc2-ia64kexec/include/asm-ia64/kexec.h	2006-02-09 15:35:55.000000000 -0700
@@ -0,0 +1,24 @@
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
+
+static inline void
+crash_setup_regs(struct pt_regs *newregs, struct pt_regs *oldregs)
+{
+}
+#endif /* _ASM_IA64_KEXEC_H */
diff -urNp linux-2.6.16-rc2/kernel/irq/handle.c linux-2.6.16-rc2-ia64kexec/kernel/irq/handle.c
--- linux-2.6.16-rc2/kernel/irq/handle.c	2006-01-02 20:21:10.000000000 -0700
+++ linux-2.6.16-rc2-ia64kexec/kernel/irq/handle.c	2006-02-09 15:11:49.000000000 -0700
@@ -100,6 +100,25 @@ fastcall int handle_IRQ_event(unsigned i
 }
 
 /*
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
+/*
  * do_IRQ handles all normal device IRQ's (the special
  * SMP cross-CPU interrupts have their own specific
  * handlers).

--=-heiMyns1HKTsdqdGLpY9
Content-Disposition: attachment; filename=kexec-ia64-tools.patch
Content-Type: text/x-patch; name=kexec-ia64-tools.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -urNp kexec-tools-1.101/kdump/kdump.8 kexec-tools-1.101-ia64/kdump/kdump.8
--- kexec-tools-1.101/kdump/kdump.8	1969-12-31 17:00:00.000000000 -0700
+++ kexec-tools-1.101-ia64/kdump/kdump.8	2006-02-21 13:29:36.000000000 -0700
@@ -0,0 +1,39 @@
+.\"                                      Hey, EMACS: -*- nroff -*-
+.\" First parameter, NAME, should be all caps
+.\" Second parameter, SECTION, should be 1-8, maybe w/ subsection
+.\" other parameters are allowed: see man(7), man(1)
+.TH KDUMP 8 "Jul 27, 2005"
+.\" Please adjust this date whenever revising the manpage.
+.\"
+.\" Some roff macros, for reference:
+.\" .nh        disable hyphenation
+.\" .hy        enable hyphenation
+.\" .ad l      left justify
+.\" .ad b      justify to both left and right margins
+.\" .nf        disable filling
+.\" .fi        enable filling
+.\" .br        insert line break
+.\" .sp <n>    insert n+1 empty lines
+.\" for manpage-specific macros, see man(7)
+.SH NAME
+kdump \- This is just a placeholder until real man page has been written
+.SH SYNOPSIS
+.B kdump
+.RI [ options ] " start_address" ...
+.SH DESCRIPTION
+.PP
+.\" TeX users may be more comfortable with the \fB<whatever>\fP and
+.\" \fI<whatever>\fP escape sequences to invode bold face and italics, 
+.\" respectively.
+\fBkdump\fP does not have a man page yet. 
+.SH OPTIONS
+.\"These programs follow the usual GNU command line syntax, with long
+.\"options starting with two dashes (`-').
+.\"A summary of options is included below.
+.\"For a complete description, see the Info files.
+.SH SEE ALSO
+.SH AUTHOR
+kdump was written by Eric Biederman.
+.PP
+This manual page was written by Khalid Aziz <khalid.aziz@hp.com>,
+for the Debian project (but may be used by others).
diff -urNp kexec-tools-1.101/kdump/Makefile kexec-tools-1.101-ia64/kdump/Makefile
--- kexec-tools-1.101/kdump/Makefile	2005-02-05 18:40:36.000000000 -0700
+++ kexec-tools-1.101-ia64/kdump/Makefile	2006-02-21 13:30:06.000000000 -0700
@@ -10,6 +10,7 @@ KDUMP_SRCS:= $(KDUMP_C_SRCS)
 KDUMP_OBJS:= $(KDUMP_C_OBJS)
 KDUMP_DEPS:= $(KDUMP_C_DEPS)
 KDUMP:= $(SBINDIR)/kdump
+KDUMP_MANPAGE:= $(MANDIR)/man8/kdump.8
 
 include $(KDUMP_DEPS)
 
@@ -25,6 +26,9 @@ $(KDUMP): $(KDUMP_OBJS)
 	mkdir -p $(@D)
 	$(CC) $(CFLAGS) -o $@ $(KDUMP_OBJS)
 
+$(KDUMP_MANPAGE): kdump/kdump.8
+	$(MKDIR) -p     $(MANDIR)/man8
+	cp kdump/kdump.8 $(KDUMP_MANPAGE)
 echo::
 	@echo "KDUMP_C_SRCS $(KDUMP_C_SRCS)"
 	@echo "KDUMP_C_DEPS $(KDUMP_C_DEPS)"
diff -urNp kexec-tools-1.101/kexec/arch/ia64/kexec-elf-ia64.c kexec-tools-1.101-ia64/kexec/arch/ia64/kexec-elf-ia64.c
--- kexec-tools-1.101/kexec/arch/ia64/kexec-elf-ia64.c	2004-12-21 13:01:37.000000000 -0700
+++ kexec-tools-1.101-ia64/kexec/arch/ia64/kexec-elf-ia64.c	2006-02-21 13:31:14.000000000 -0700
@@ -6,6 +6,7 @@
  * Copyright (C) 2004 Silicon Graphics, Inc.
  *   Jesse Barnes <jbarnes@sgi.com>
  * Copyright (C) 2004 Khalid Aziz <khalid.aziz@hp.com> Hewlett Packard Co
+ * Copyright (C) 2005 Zou Nan hai <nanhai.zou@intel.com> Intel Corp
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -34,6 +35,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <getopt.h>
+#include <limits.h>
 #include <elf.h>
 #include <boot/elf_boot.h>
 #include <ip_checksum.h>
@@ -74,23 +76,29 @@ void elf_ia64_usage(void)
 {
 	printf(
 		"    --command-line=STRING Set the kernel command line to STRING.\n"
-		"    --append=STRING       Set the kernel command line to STRING.\n");
+		"    --append=STRING       Set the kernel command line to STRING.\n"
+		"    --initrd=FILE       Use FILE as the kernel's initial ramdisk.\n");
 }
 
 int elf_ia64_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
-	const char *command_line;
-	int command_line_len;
-	unsigned long entry, max_addr;
+	const char *command_line, *ramdisk=0;
+	char *ramdisk_buf = NULL;
+	off_t ramdisk_size = 0;
+	unsigned long command_line_len;
+	unsigned long entry, max_addr, gp_value;
+	unsigned command_line_base, ramdisk_base;
 	int result;
 	int opt;
 #define OPT_APPEND	(OPT_ARCH_MAX+0)
+#define OPT_RAMDISK	(OPT_ARCH_MAX+1)
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
 		{"command-line", 1, 0, OPT_APPEND},
 		{"append",       1, 0, OPT_APPEND},
+		{"initrd",       1, 0, OPT_RAMDISK},
 		{0, 0, 0, 0},
 	};
 
@@ -110,11 +118,14 @@ int elf_ia64_load(int argc, char **argv,
 		case OPT_APPEND:
 			command_line = optarg;
 			break;
+		case OPT_RAMDISK:
+			ramdisk = optarg;
+			break;
 		}
 	}
 	command_line_len = 0;
 	if (command_line) {
-		command_line_len = strlen(command_line) + 1;
+		command_line_len = strlen(command_line) + 16;
 	}
 
 	/* Parse the Elf file */
@@ -129,13 +140,46 @@ int elf_ia64_load(int argc, char **argv,
 
 	/* Load the Elf data */
 	result = elf_exec_load(&ehdr, info);
-	free_elf_info(&ehdr);
 	if (result < 0) {
 		fprintf(stderr, "ELF load failed\n");
+		free_elf_info(&ehdr);
 		return result;
 	}
+
+
+	/* Load the setup code */
+	elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
+			0x80000, ULONG_MAX, 1);
+
+	if (command_line_len) {
+		char *cmdline = xmalloc(command_line_len);
+		strcpy(cmdline, command_line);
+		command_line_len = (command_line_len + 15)&(~15);
+		elf_rel_set_symbol(&info->rhdr, "__command_line_len",
+				&command_line_len, sizeof(long));
+		command_line_base = add_buffer(info, cmdline,
+					command_line_len, command_line_len,
+					16, 0, max_addr, 1);
+		elf_rel_set_symbol(&info->rhdr, "__command_line",
+				&command_line_base, sizeof(long));
+	}
 	
-	/* For now we don't have arguments to pass :( */
-	info->entry = (void *)entry;
+	if (ramdisk) {
+		ramdisk_buf = slurp_file(ramdisk, &ramdisk_size);
+		ramdisk_base = add_buffer(info, ramdisk_buf, ramdisk_size,
+				ramdisk_size,
+				getpagesize(), 0, max_addr, 1);
+		elf_rel_set_symbol(&info->rhdr, "__ramdisk_base",
+				&ramdisk_base, sizeof(long));
+		elf_rel_set_symbol(&info->rhdr, "__ramdisk_size",
+				&ramdisk_size, sizeof(long));
+	}
+
+	gp_value = info->rhdr.rel_addr + 0x200000;
+        elf_rel_set_symbol(&info->rhdr, "__gp_value", &gp_value,
+                        sizeof(gp_value));
+
+	elf_rel_set_symbol(&info->rhdr, "__kernel_entry", &entry, sizeof(entry));
+	free_elf_info(&ehdr);
 	return 0;
 }
diff -urNp kexec-tools-1.101/kexec/arch/ia64/kexec-elf-rel-ia64.c kexec-tools-1.101-ia64/kexec/arch/ia64/kexec-elf-rel-ia64.c
--- kexec-tools-1.101/kexec/arch/ia64/kexec-elf-rel-ia64.c	2004-12-20 15:43:23.000000000 -0700
+++ kexec-tools-1.101-ia64/kexec/arch/ia64/kexec-elf-rel-ia64.c	2006-02-09 15:46:39.000000000 -0700
@@ -1,8 +1,14 @@
+/*  Most of the code in this file is
+ *  based on arch/ia64/kernel/module.c in Linux kernel
+ */
+
 #include <stdio.h>
 #include <elf.h>
 #include "../../kexec.h"
 #include "../../kexec-elf.h"
 
+#define MAX_LTOFF       ((uint64_t) (1 << 22))
+
 int machine_verify_elf_rel(struct mem_ehdr *ehdr)
 {
 	if (ehdr->ei_data != ELFDATA2LSB) {
@@ -17,12 +23,40 @@ int machine_verify_elf_rel(struct mem_eh
 	return 1;
 }
 
+static void
+ia64_patch (uint64_t insn_addr, uint64_t mask, uint64_t val)
+{
+        uint64_t m0, m1, v0, v1, b0, b1, *b = (uint64_t *) (insn_addr & -16);
+#       define insn_mask ((1UL << 41) - 1)
+        unsigned long shift;
+
+        b0 = b[0]; b1 = b[1];
+        shift = 5 + 41 * (insn_addr % 16); /* 5 bits of template, then 3 x 41-bit instructions */
+        if (shift >= 64) {
+                m1 = mask << (shift - 64);
+                v1 = val << (shift - 64);
+        } else {
+                m0 = mask << shift; m1 = mask >> (64 - shift);
+                v0 = val  << shift; v1 = val >> (64 - shift);
+                b[0] = (b0 & ~m0) | (v0 & m0);
+        }
+        b[1] = (b1 & ~m1) | (v1 & m1);
+}
+
+static inline uint64_t
+bundle (const uint64_t insn)
+{
+        return insn & ~0xfUL;
+}
+
 void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
 	void *location, unsigned long address, unsigned long value)
 {
+	uint64_t gp_value = ehdr->rel_addr + 0x200000;
 	switch(r_type) {
 	case R_IA64_NONE:
 		break;
+	case R_IA64_SEGREL64LSB:
 	case R_IA64_DIR64LSB:
 		*((uint64_t *)location) = value;
 		break;
@@ -31,15 +65,67 @@ void machine_apply_elf_rel(struct mem_eh
 		if (value != *((uint32_t *)location))
 			goto overflow;
 		break;
-	case R_IA64_PCREL21B:
+	case R_IA64_IMM64:
+		ia64_patch((uint64_t)location, 0x01fffefe000UL, 
+				/* bit 63 -> 36 */
+				(((value & 0x8000000000000000UL) >> 27) 
+				/* bit 21 -> 21 */
+				  | ((value & 0x0000000000200000UL) <<  0) 
+				/* bit 16 -> 22 */
+				  | ((value & 0x00000000001f0000UL) <<  6) 
+				/* bit 7 -> 27 */
+				  | ((value & 0x000000000000ff80UL) << 20) 
+				/* bit 0 -> 13 */
+				  | ((value & 0x000000000000007fUL) << 13)));
+		ia64_patch((uint64_t)location - 1, 0x1ffffffffffUL, value>>22);
+		break;
+	case R_IA64_IMM22:
+		if (value + (1 << 21) >= (1 << 22))
+                	die("value out of IMM22 range\n");
+		ia64_patch((uint64_t)location, 0x01fffcfe000UL,
+				/* bit 21 -> 36 */
+				(((value & 0x200000UL) << 15)
+				/* bit 16 -> 22 */
+				 | ((value & 0x1f0000UL) <<  6)
+				/* bit  7 -> 27 */
+				 | ((value & 0x00ff80UL) << 20)
+				/* bit  0 -> 13 */
+				 | ((value & 0x00007fUL) << 13) ));
+		break;
+	case R_IA64_PCREL21B: {
+		uint64_t delta = ((int64_t)value - (int64_t)address)/16;
+		if (delta + (1 << 20) >= (1 << 21))
+			die("value out of IMM21B range\n");
+		value = ((int64_t)(value - bundle(address)))/16;
+		ia64_patch((uint64_t)location, 0x11ffffe000UL,
+				(((value & 0x100000UL) << 16) /* bit 20 -> 36 */
+				 | ((value & 0x0fffffUL) << 13) /* bit  0 -> 13 */));
+		}
+		break;
+	case R_IA64_LTOFF22X:
+		if (value - gp_value + MAX_LTOFF/2 >= MAX_LTOFF)
+			die("value out of gp relative range");
+		value -= gp_value;
+		ia64_patch((uint64_t)location, 0x01fffcfe000UL,
+				(((value & 0x200000UL) << 15) /* bit 21 -> 36 */
+				   |((value & 0x1f0000UL) <<  6) /* bit 16 -> 22 */
+				   |((value & 0x00ff80UL) << 20) /* bit  7 -> 27 */
+				   |((value & 0x00007fUL) << 13) /* bit  0 -> 13 */));
+		break;
+	case R_IA64_LDXMOV:
+		if (value - gp_value + MAX_LTOFF/2 >= MAX_LTOFF)
+			die("value out of gp relative range");
+		ia64_patch((uint64_t)location, 0x1fff80fe000UL, 0x10000000000UL);
+	        break;
 	case R_IA64_LTOFF22:
-	case R_IA64_SEGREL64LSB:
+
 	default:
-		die("Unknown rela relocation: %lu\n", r_type);
+		die("Unknown rela relocation: 0x%lx 0x%lx\n",
+				r_type, address);
 		break;
 	}
 	return;
- overflow:
+overflow:
 	die("overflow in relocation type %lu val %Lx\n", 
-		r_type, value);
+			r_type, value);
 }
diff -urNp kexec-tools-1.101/kexec/arch/ia64/kexec-ia64.c kexec-tools-1.101-ia64/kexec/arch/ia64/kexec-ia64.c
--- kexec-tools-1.101/kexec/arch/ia64/kexec-ia64.c	2005-01-10 23:28:36.000000000 -0700
+++ kexec-tools-1.101-ia64/kexec/arch/ia64/kexec-ia64.c	2006-02-21 14:25:57.000000000 -0700
@@ -27,6 +27,7 @@
 #include <stdint.h>
 #include <string.h>
 #include <getopt.h>
+#include <sched.h>
 #include <sys/utsname.h>
 #include "../../kexec.h"
 #include "../../kexec-syscall.h"
@@ -56,7 +57,7 @@ int get_memory_ranges(struct memory_rang
 	 */
 	fprintf(stderr, "Warning assuming memory at 0-64MB is present\n");
 	memory_ranges = 0;
-	memory_range[memory_ranges].start = 0x00010000;
+	memory_range[memory_ranges].start = 0x00100000;
 	memory_range[memory_ranges].end   = 0x10000000;
 	memory_range[memory_ranges].type  = RANGE_RAM;
 	memory_ranges++;
@@ -76,9 +77,6 @@ void arch_usage(void)
 {
 }
 
-static struct {
-} arch_options = {
-};
 int arch_process_options(int argc, char **argv)
 {
 	static const struct option options[] = {
@@ -87,8 +85,12 @@ int arch_process_options(int argc, char 
 	};
 	static const char short_options[] = KEXEC_ARCH_OPT_STR;
 	int opt;
-	unsigned long value;
-	char *end;
+
+	/* execute from monarch processor */
+        cpu_set_t affinity;
+	CPU_ZERO(&affinity);
+	CPU_SET(0, &affinity);
+        sched_setaffinity(0, sizeof(affinity), &affinity);
 
 	opterr = 0; /* Don't complain about unrecognized options here */
 	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
@@ -115,32 +117,7 @@ int arch_compat_trampoline(struct kexec_
 	}
 	if (strcmp(utsname.machine, "ia64") == 0)
 	{
-		*flags |= KEXEC_ARCH_X86_64;
-	}
-	else {
-		fprintf(stderr, "Unsupported machine type: %s\n",
-			utsname.machine);
-		return -1;
-	}
-	return 0;
-}
-
-int arch_compat_trampoline(struct kexec_info *info, unsigned long *flags)
-{
-	int result;
-	struct utsname utsname;
-	result = uname(&utsname);
-	if (result < 0) {
-		fprintf(stderr, "uname failed: %s\n",
-			strerror(errno));
-		return -1;
-	}
-	if (strcmp(utsname.machine, "ia64") == 0)
-	{
-		/* For compatibility with older patches 
-		 * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_IA64 here.
-		 */
-		*flags |= KEXEC_ARCH_DEFAULT;
+		*flags |= KEXEC_ARCH_IA_64;
 	}
 	else {
 		fprintf(stderr, "Unsupported machine type: %s\n",
diff -urNp kexec-tools-1.101/kexec/kexec.8 kexec-tools-1.101-ia64/kexec/kexec.8
--- kexec-tools-1.101/kexec/kexec.8	2004-12-19 15:27:31.000000000 -0700
+++ kexec-tools-1.101-ia64/kexec/kexec.8	2006-02-21 13:34:49.000000000 -0700
@@ -2,7 +2,7 @@
 .\" First parameter, NAME, should be all caps
 .\" Second parameter, SECTION, should be 1-8, maybe w/ subsection
 .\" other parameters are allowed: see man(7), man(1)
-.TH KEXEC-TOOLS 8 "October 13, 2004"
+.TH KEXEC 8 "October 13, 2004"
 .\" Please adjust this date whenever revising the manpage.
 .\"
 .\" Some roff macros, for reference:
@@ -16,30 +16,60 @@
 .\" .sp <n>    insert n+1 empty lines
 .\" for manpage-specific macros, see man(7)
 .SH NAME
-kexec-tools \- Tool to load a kernel for warm reboot and initiate a warm reboot
+kexec \- Tool to load a kernel for warm reboot and initiate a warm reboot
 .SH SYNOPSIS
-.B kexec-tools
+.B kexec
 .RI [ options ] " files" ...
 .SH DESCRIPTION
 .PP
 .\" TeX users may be more comfortable with the \fB<whatever>\fP and
 .\" \fI<whatever>\fP escape sequences to invode bold face and italics, 
 .\" respectively.
-\fBkexec-tools\fP does not have a man page yet. Please use "kexec -h" for help.
+\fBkexec\fP allows one to load another kernel from the currently running 
+Linux kernel. Normally one would load a kernel, and possibly an initial 
+ramdisk, into the currently running kernel using kexec and then initiate
+a warm reboot by executing kexec again with appropriate option.
 .SH OPTIONS
 These programs follow the usual GNU command line syntax, with long
 options starting with two dashes (`-').
 A summary of options is included below.
-For a complete description, see the Info files.
 .TP
 .B \-h, \-\-help
 Show summary of options.
 .TP
 .B \-v, \-\-version
 Show version of program.
-.SH SEE ALSO
+.TP
+.B \-f, \-\-force
+Force an immediate kexec without calling shutdown.
+.TP
+.B \-x, \-\-no-ifdown
+Don't bring down network interfaces. (if used, must be last option specified)
+.TP
+.B \-l, \-\-load
+Load the new kernel into the current kernel.
+.TP
+.B \-p, \-\-load-panic
+Load the new kernel for use on panic.
+.TP
+.B \-u, \-\-unload
+Unload the current kexec target kernel.
+.TP
+.B \-e, \-\-exec
+Execute a currently loaded kernel.
+.TP
+.B \-t, \-\-type=TYPE
+Specify the new kernel is of this type.
+.TP
+.B \-\-mem\-min=<addr>
+Specify the lowest memory addres to load code into.
+.TP
+.B \-\-mem\-max=<addr>
+Specify the highest memory addres to load code into.
+.TP
+There may be additional options supported on individual architectures.  Use --help option to see those options.
 .SH AUTHOR
-kexec-tools was written by Eric Biederman.
+kexec was written by Eric Biederman.
 .PP
-This manual page was written by Khalid Aziz <khalid_aziz@hp.com>,
+This manual page was written by Khalid Aziz <khalid.aziz@hp.com>,
 for the Debian project (but may be used by others).
diff -urNp kexec-tools-1.101/kexec/kexec.c kexec-tools-1.101-ia64/kexec/kexec.c
--- kexec-tools-1.101/kexec/kexec.c	2005-01-13 06:24:29.000000000 -0700
+++ kexec-tools-1.101-ia64/kexec/kexec.c	2006-02-09 15:46:39.000000000 -0700
@@ -187,7 +187,7 @@ unsigned long locate_hole(struct kexec_i
 	}
 
 	/* Compute the free memory ranges */
-	max_mem_ranges = memory_ranges + (info->nr_segments -1);
+	max_mem_ranges = memory_ranges + info->nr_segments;
 	mem_range = malloc(max_mem_ranges *sizeof(struct memory_range));
 	mem_ranges = 0;
 		
diff -urNp kexec-tools-1.101/kexec/Makefile kexec-tools-1.101-ia64/kexec/Makefile
--- kexec-tools-1.101/kexec/Makefile	2004-12-21 12:36:39.000000000 -0700
+++ kexec-tools-1.101-ia64/kexec/Makefile	2006-02-21 13:36:18.000000000 -0700
@@ -27,6 +27,7 @@ KEXEC_SRCS:= $(KEXEC_C_SRCS) $(KEXEC_S_S
 KEXEC_OBJS:= $(KEXEC_C_OBJS) $(KEXEC_S_OBJS)
 KEXEC_DEPS:= $(KEXEC_C_DEPS) $(KEXEC_S_DEPS)
 KEXEC:= $(SBINDIR)/kexec
+KEXEC_MANPAGE:= $(MANDIR)/man8/kexec.8
 
 include $(KEXEC_DEPS)
 
@@ -50,6 +51,9 @@ $(KEXEC): $(KEXEC_OBJS) $(UTIL_LIB)
 	mkdir -p $(@D)
 	$(CC) $(KCFLAGS) -o $@ $(KEXEC_OBJS) $(UTIL_LIB) $(LIBS)
 
+$(KEXEC_MANPAGE): kexec/kexec.8
+	 $(MKDIR) -p     $(MANDIR)/man8
+	cp kexec/kexec.8 $(KEXEC_MANPAGE)
 echo::
 	@echo "KEXEC_C_SRCS $(KEXEC_C_SRCS)"
 	@echo "KEXEC_C_DEPS $(KEXEC_C_DEPS)"
diff -urNp kexec-tools-1.101/Makefile kexec-tools-1.101-ia64/Makefile
--- kexec-tools-1.101/Makefile	2005-02-18 05:26:09.000000000 -0700
+++ kexec-tools-1.101-ia64/Makefile	2006-02-21 13:37:40.000000000 -0700
@@ -43,6 +43,7 @@ PKGLIBDIR=$(LIBDIR)/$(PACKAGE)
 PKGINCLUDEIR=$(INCLUDEDIR)/$(PACKAGE)
 
 MAN_PAGES:= kexec/kexec.8
+MAN_PAGES+= kdump/kdump.8
 BINARIES_i386:=  $(SBINDIR)/kexec $(PKGLIBDIR)/kexec_test
 BINARIES_x86_64:=$(SBINDIR)/kexec $(PKGLIBDIR)/kexec_test
 BINARIES:=$(SBINDIR)/kexec $(SBINDIR)/kdump $(BINARIES_$(ARCH)) 
diff -urNp kexec-tools-1.101/purgatory/arch/ia64/entry.S kexec-tools-1.101-ia64/purgatory/arch/ia64/entry.S
--- kexec-tools-1.101/purgatory/arch/ia64/entry.S	1969-12-31 17:00:00.000000000 -0700
+++ kexec-tools-1.101-ia64/purgatory/arch/ia64/entry.S	2006-02-09 15:46:39.000000000 -0700
@@ -0,0 +1,85 @@
+/*
+ * purgatory:  setup code
+ *
+ * Copyright (C) 2005  Zou Nan hai (nanhai.zou@intel.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation (version 2 of the License).
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
+.global __dummy_efi_function
+.align  32
+.proc  __dummy_efi_function
+__dummy_efi_function:
+	mov r8=r0;;
+	br.ret.sptk.many rp;;
+.global __dummy_efi_function_end
+__dummy_efi_function_end:
+.endp 	__dummy_efi_function
+
+.global purgatory_start
+.align  32
+.proc   purgatory_start
+purgatory_start:
+	movl r2=__gp_value;;
+	ld8 gp=[r2];;
+	br.call.sptk.many b0=purgatory
+	;;
+	alloc r2 = ar.pfs, 0, 0, 5, 0
+	;;
+	mov out0=r28
+
+	movl r2=__command_line;;
+	ld8 out1=[r2];;
+	movl r2=__command_line_len;;
+	ld8 out2=[r2];;
+	movl r2=__ramdisk_base;;
+	ld8 out3=[r2];;
+	movl r2=__ramdisk_size;;
+	ld8 out4=[r2];;
+	br.call.sptk.many b0=ia64_env_setup
+	movl r10=__kernel_entry;;
+	ld8 r14=[r10];;
+	mov b6=r14;;
+	mov ar.lc=r0
+	mov ar.ec=r0
+	cover;;
+	invala;;
+	br.call.sptk.many  b0=b6
+.endp   purgatory_start
+
+.align  32
+.global __kernel_entry
+.size	__kernel_entry, 8
+__kernel_entry:
+        data8 0x0
+.global __command_line
+.size	__command_line, 8
+__command_line:
+        data8 0x0
+.global __command_line_len
+.size	__command_line_len, 8
+__command_line_len:
+        data8 0x0
+.global __ramdisk_base
+.size	__ramdisk_base, 8
+__ramdisk_base:
+        data8 0x0
+.global __ramdisk_size
+.size	__ramdisk_size, 8
+__ramdisk_size:
+        data8 0x0
+.global __gp_value
+.size	__gp_value, 8
+__gp_value:
+        data8 0x0
diff -urNp kexec-tools-1.101/purgatory/arch/ia64/include/arch/io.h kexec-tools-1.101-ia64/purgatory/arch/ia64/include/arch/io.h
--- kexec-tools-1.101/purgatory/arch/ia64/include/arch/io.h	1969-12-31 17:00:00.000000000 -0700
+++ kexec-tools-1.101-ia64/purgatory/arch/ia64/include/arch/io.h	2006-02-14 15:28:09.000000000 -0700
@@ -0,0 +1,25 @@
+#ifndef ARCH_IO_H
+#define ARCH_IO_H
+
+#include <stdint.h>
+/* Helper functions for directly doing I/O */
+
+extern inline uint8_t inb(void *port)
+{
+	volatile unsigned char *addr = (unsigned char *)port;
+	uint8_t result;
+
+	result = *addr;
+	asm volatile ("mf.a"::: "memory");
+	return result;
+}
+
+extern inline void outb (uint8_t value, void *port)
+{
+	volatile unsigned char *addr = (unsigned char *)port;
+
+	*addr = value;
+	asm volatile ("mf.a"::: "memory");
+}
+
+#endif /* ARCH_IO_H */
diff -urNp kexec-tools-1.101/purgatory/arch/ia64/Makefile kexec-tools-1.101-ia64/purgatory/arch/ia64/Makefile
--- kexec-tools-1.101/purgatory/arch/ia64/Makefile	2004-12-20 15:44:22.000000000 -0700
+++ kexec-tools-1.101-ia64/purgatory/arch/ia64/Makefile	2006-02-09 15:46:39.000000000 -0700
@@ -1,8 +1,8 @@
 #
 # Purgatory ia64
 #
-
-PURGATORY_S_SRCS+=
+PCFLAGS		+= -ffixed-r28
+PURGATORY_S_SRCS+= purgatory/arch/ia64/entry.S
 PURGATORY_C_SRCS+= purgatory/arch/ia64/purgatory-ia64.c
 PURGATORY_C_SRCS+= purgatory/arch/ia64/console-ia64.c
 PURGATORY_C_SRCS+=
diff -urNp kexec-tools-1.101/purgatory/arch/ia64/purgatory-ia64.c kexec-tools-1.101-ia64/purgatory/arch/ia64/purgatory-ia64.c
--- kexec-tools-1.101/purgatory/arch/ia64/purgatory-ia64.c	2004-12-20 15:45:21.000000000 -0700
+++ kexec-tools-1.101-ia64/purgatory/arch/ia64/purgatory-ia64.c	2006-02-09 15:46:39.000000000 -0700
@@ -1,7 +1,113 @@
 #include <purgatory.h>
+#include <stdint.h>
+#include <string.h>
 #include "purgatory-ia64.h"
 
+#define PAGE_OFFSET             0xe000000000000000
+
+typedef struct {
+        uint64_t signature;
+        uint32_t revision;
+        uint32_t headersize;
+        uint32_t crc32;
+        uint32_t reserved;
+} efi_table_hdr_t;
+
+typedef struct {
+        efi_table_hdr_t hdr;
+        unsigned long get_time;
+        unsigned long set_time;
+        unsigned long get_wakeup_time;
+        unsigned long set_wakeup_time;
+        unsigned long set_virtual_address_map;
+        unsigned long convert_pointer;
+        unsigned long get_variable;
+        unsigned long get_next_variable;
+        unsigned long set_variable;
+        unsigned long get_next_high_mono_count;
+        unsigned long reset_system;
+} efi_runtime_services_t;
+
+typedef struct {
+        efi_table_hdr_t hdr;
+        unsigned long fw_vendor;        /* physical addr of CHAR16 vendor string
+ */
+        uint32_t fw_revision;
+        unsigned long con_in_handle;
+        unsigned long con_in;
+        unsigned long con_out_handle;
+        unsigned long con_out;
+        unsigned long stderr_handle;
+        unsigned long stderr;
+        unsigned long runtime;
+        unsigned long boottime;
+        unsigned long nr_tables;
+        unsigned long tables;
+} efi_system_table_t;
+
+struct ia64_boot_param {
+        uint64_t command_line;             /* physical address of command line arguments */
+        uint64_t efi_systab;               /* physical address of EFI system table */
+        uint64_t efi_memmap;               /* physical address of EFI memory map */
+        uint64_t efi_memmap_size;          /* size of EFI memory map */
+        uint64_t efi_memdesc_size;         /* size of an EFI memory map descriptor */
+        uint32_t efi_memdesc_version;      /* memory descriptor version */
+        struct {
+                uint16_t num_cols; /* number of columns on console output device */
+                uint16_t num_rows; /* number of rows on console output device */
+                uint16_t orig_x;   /* cursor's x position */
+                uint16_t orig_y;   /* cursor's y position */
+        } console_info;
+        uint64_t fpswa;            /* physical address of the fpswa interface */
+        uint64_t initrd_start;
+        uint64_t initrd_size;
+};
+
 void setup_arch(void)
 {
 	/* Nothing for now */
 }
+inline unsigned long PA(unsigned long addr)
+{
+	return addr - PAGE_OFFSET;
+}
+
+void flush_icache_range(char *start, unsigned long len)
+{
+	unsigned long i;
+	for (i = 0;i < len; i += 32)
+	  asm volatile("fc.i %0"::"r"(start+i):"memory");
+	asm volatile (";;sync.i;;":::"memory");
+	asm volatile ("srlz.i":::"memory");
+}
+
+extern char __dummy_efi_function[], __dummy_efi_function_end[];
+
+void ia64_env_setup(struct ia64_boot_param *boot_param,
+	uint64_t command_line, uint64_t command_line_len,
+	uint64_t ramdisk_base, uint64_t ramdisk_size)
+{
+	unsigned long len;
+        efi_system_table_t *systab;
+        efi_runtime_services_t *runtime;
+	unsigned long *set_virtual_address_map;
+
+	// patch efi_runtime->set_virtual_address_map to a
+	// dummy function
+	len = __dummy_efi_function_end - __dummy_efi_function;
+	memcpy((char *)command_line + command_line_len, __dummy_efi_function,
+	len);
+	systab = (efi_system_table_t *)boot_param->efi_systab;
+	runtime = (efi_runtime_services_t *)PA(systab->runtime);
+	set_virtual_address_map =
+		(unsigned long *)PA(runtime->set_virtual_address_map);
+	*(set_virtual_address_map)=
+		(unsigned long)((char *)command_line + command_line_len);
+	flush_icache_range((char *)command_line+command_line_len, len);
+
+	boot_param->command_line = command_line;
+	boot_param->console_info.orig_x = 0;
+	boot_param->console_info.orig_y = 0;
+	boot_param->initrd_start = ramdisk_base;
+	boot_param->initrd_size =  ramdisk_size;
+}
diff -urNp kexec-tools-1.101/purgatory/Makefile kexec-tools-1.101-ia64/purgatory/Makefile
--- kexec-tools-1.101/purgatory/Makefile	2005-01-08 15:36:32.000000000 -0700
+++ kexec-tools-1.101-ia64/purgatory/Makefile	2006-02-14 14:40:16.000000000 -0700
@@ -6,7 +6,7 @@
 # There is probably a cleaner way to do this but for now this
 # should keep us from accidentially include unsafe library functions
 # or headers.
-PCFLAGS:=-Wall -Os  \
+PCFLAGS:=-Wall -Os -g  \
 	-I$(shell $(CC) -print-file-name=include) \
 	-Ipurgatory/include -Ipurgatory/arch/$(ARCH)/include \
 	$(CPPFLAGS)

--=-heiMyns1HKTsdqdGLpY9--

