Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262916AbVG3ELK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262916AbVG3ELK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 00:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbVG3EIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 00:08:50 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:2308 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262913AbVG3EGq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 00:06:46 -0400
Date: Fri, 29 Jul 2005 21:04:16 -0700
From: zach@vmware.com
Message-Id: <200507300404.j6U44Gvk005919@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, davej@codemonkey.org.uk, hpa@zytor.com,
       linux-kernel@vger.kernel.org, pratap@vmware.com, Riley@Williams.Name,
       zach@vmware.com
Subject: [PATCH] 1/6 i386 cpu-inline-cleanup
X-OriginalArrivalTime: 30 Jul 2005 04:05:16.0390 (UTC) FILETIME=[E488E860:01C594BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386 Inline asm cleanup.  Use cr/dr accessor functions.

Also, a potential bugfix.  Also, some CR accessors really should be volatile.
Reads from CR0 (numeric state may change in an exception handler), writes
to CR4 (flipping CR4.TSD) and reads from CR2 (page fault) prevent instruction
re-ordering.  I did not add memory clobber to CR3 / CR4 / CR0 updates, as it
was not there to begin with, and in no case should kernel memory be clobbered,
except when doing a TLB flush, which already has memory clobber.

I noticed that page invalidation does not have a memory clobber.  I can't find
a bug as a result, but there is definitely a potential for a bug here:

#define __flush_tlb_single(addr) \
	__asm__ __volatile__("invlpg %0": :"m" (*(char *) addr))

Diffs against: linux-2.6.13-rc4

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/i386/power/cpu.c
===================================================================
--- linux-2.6.13.orig/arch/i386/power/cpu.c	2005-07-29 11:14:33.000000000 -0700
+++ linux-2.6.13/arch/i386/power/cpu.c	2005-07-29 11:15:36.000000000 -0700
@@ -57,10 +57,10 @@
 	/*
 	 * control registers 
 	 */
-	asm volatile ("movl %%cr0, %0" : "=r" (ctxt->cr0));
-	asm volatile ("movl %%cr2, %0" : "=r" (ctxt->cr2));
-	asm volatile ("movl %%cr3, %0" : "=r" (ctxt->cr3));
-	asm volatile ("movl %%cr4, %0" : "=r" (ctxt->cr4));
+	ctxt->cr0 = read_cr0();
+	ctxt->cr2 = read_cr2();
+	ctxt->cr3 = read_cr3();
+	ctxt->cr4 = read_cr4();
 }
 
 void save_processor_state(void)
@@ -109,10 +109,10 @@
 	/*
 	 * control registers
 	 */
-	asm volatile ("movl %0, %%cr4" :: "r" (ctxt->cr4));
-	asm volatile ("movl %0, %%cr3" :: "r" (ctxt->cr3));
-	asm volatile ("movl %0, %%cr2" :: "r" (ctxt->cr2));
-	asm volatile ("movl %0, %%cr0" :: "r" (ctxt->cr0));
+	write_cr4(ctxt->cr4);
+	write_cr3(ctxt->cr3);
+	write_cr2(ctxt->cr2);
+	write_cr2(ctxt->cr0);
 
 	/*
 	 * now restore the descriptor tables to their proper values
Index: linux-2.6.13/arch/i386/kernel/efi.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/efi.c	2005-07-29 11:14:33.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/efi.c	2005-07-29 11:15:36.000000000 -0700
@@ -79,7 +79,7 @@
 	 * directory. If I have PSE, I just need to duplicate one entry in
 	 * page directory.
 	 */
-	__asm__ __volatile__("movl %%cr4, %0":"=r"(cr4));
+	cr4 = read_cr4();
 
 	if (cr4 & X86_CR4_PSE) {
 		efi_bak_pg_dir_pointer[0].pgd =
@@ -115,7 +115,7 @@
 	cpu_gdt_descr[0].address =
 		(unsigned long) __va(cpu_gdt_descr[0].address);
 	__asm__ __volatile__("lgdt %0":"=m"(cpu_gdt_descr));
-	__asm__ __volatile__("movl %%cr4, %0":"=r"(cr4));
+	cr4 = read_cr4();
 
 	if (cr4 & X86_CR4_PSE) {
 		swapper_pg_dir[pgd_index(0)].pgd =
Index: linux-2.6.13/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/process.c	2005-07-29 11:14:33.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/process.c	2005-07-29 11:15:36.000000000 -0700
@@ -313,16 +313,12 @@
 	printk(" DS: %04x ES: %04x\n",
 		0xffff & regs->xds,0xffff & regs->xes);
 
-	__asm__("movl %%cr0, %0": "=r" (cr0));
-	__asm__("movl %%cr2, %0": "=r" (cr2));
-	__asm__("movl %%cr3, %0": "=r" (cr3));
-	/* This could fault if %cr4 does not exist */
-	__asm__("1: movl %%cr4, %0		\n"
-		"2:				\n"
-		".section __ex_table,\"a\"	\n"
-		".long 1b,2b			\n"
-		".previous			\n"
-		: "=r" (cr4): "0" (0));
+	cr0 = read_cr0();
+	cr2 = read_cr2();
+	cr3 = read_cr3();
+	if (current_cpu_data.x86 > 4) {
+		cr4 = read_cr4();
+	}
 	printk("CR0: %08lx CR2: %08lx CR3: %08lx CR4: %08lx\n", cr0, cr2, cr3, cr4);
 	show_trace(NULL, &regs->esp);
 }
Index: linux-2.6.13/arch/i386/kernel/smp.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/smp.c	2005-07-29 11:14:33.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/smp.c	2005-07-29 11:15:36.000000000 -0700
@@ -576,7 +576,7 @@
 	local_irq_disable();
 	disable_local_APIC();
 	if (cpu_data[smp_processor_id()].hlt_works_ok)
-		for(;;) __asm__("hlt");
+		for(;;) halt();
 	for (;;);
 }
 
Index: linux-2.6.13/arch/i386/kernel/cpu/common.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/cpu/common.c	2005-07-29 11:14:33.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/cpu/common.c	2005-07-29 11:15:36.000000000 -0700
@@ -642,12 +642,12 @@
 	asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax, %gs");
 
 	/* Clear all 6 debug registers: */
-
-#define CD(register) set_debugreg(0, register)
-
-	CD(0); CD(1); CD(2); CD(3); /* no db4 and db5 */; CD(6); CD(7);
-
-#undef CD
+	set_debugreg(0, 0);
+	set_debugreg(0, 1);
+	set_debugreg(0, 2);
+	set_debugreg(0, 3);
+	set_debugreg(0, 6);
+	set_debugreg(0, 7);
 
 	/*
 	 * Force FPU initialization:
Index: linux-2.6.13/arch/i386/kernel/cpu/cyrix.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/cpu/cyrix.c	2005-07-29 11:14:33.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/cpu/cyrix.c	2005-07-29 11:15:36.000000000 -0700
@@ -132,11 +132,7 @@
 	setCx86(CX86_CCR2, getCx86(CX86_CCR2) & ~0x04);
 	/* set 'Not Write-through' */
 	cr0 = 0x20000000;
-	__asm__("movl %%cr0,%%eax\n\t"
-		"orl %0,%%eax\n\t"
-		"movl %%eax,%%cr0\n"
-		: : "r" (cr0)
-		:"ax");
+	write_cr0(read_cr0() | cr0);
 	/* CCR2 bit 2: lock NW bit and set WT1 */
 	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x14 );
 }
Index: linux-2.6.13/arch/i386/kernel/cpu/cpufreq/longhaul.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/cpu/cpufreq/longhaul.c	2005-07-29 11:14:33.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/cpu/cpufreq/longhaul.c	2005-07-29 11:15:36.000000000 -0700
@@ -64,8 +64,6 @@
 #define dprintk(msg...) cpufreq_debug_printk(CPUFREQ_DEBUG_DRIVER, "longhaul", msg)
 
 
-#define __hlt()     __asm__ __volatile__("hlt": : :"memory")
-
 /* Clock ratios multiplied by 10 */
 static int clock_ratio[32];
 static int eblcr_table[32];
@@ -168,11 +166,9 @@
 	outb(0xFE,0x21);	/* TMR0 only */
 	outb(0xFF,0x80);	/* delay */
 
-	local_irq_enable();
-
-	__hlt();
+	safe_halt();
 	wrmsrl(MSR_VIA_LONGHAUL, longhaul->val);
-	__hlt();
+	halt();
 
 	local_irq_disable();
 
@@ -251,9 +247,7 @@
 		bcr2.bits.CLOCKMUL = clock_ratio_index;
 		local_irq_disable();
 		wrmsrl (MSR_VIA_BCR2, bcr2.val);
-		local_irq_enable();
-
-		__hlt();
+		safe_halt();
 
 		/* Disable software clock multiplier */
 		rdmsrl (MSR_VIA_BCR2, bcr2.val);
Index: linux-2.6.13/arch/i386/mm/fault.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mm/fault.c	2005-07-29 11:14:33.000000000 -0700
+++ linux-2.6.13/arch/i386/mm/fault.c	2005-07-29 11:15:36.000000000 -0700
@@ -222,7 +222,7 @@
 	siginfo_t info;
 
 	/* get the address */
-	__asm__("movl %%cr2,%0":"=r" (address));
+        address = read_cr2();
 
 	if (notify_die(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
 					SIGSEGV) == NOTIFY_STOP)
@@ -446,7 +446,7 @@
 	printk(" at virtual address %08lx\n",address);
 	printk(KERN_ALERT " printing eip:\n");
 	printk("%08lx\n", regs->eip);
-	asm("movl %%cr3,%0":"=r" (page));
+	page = read_cr3();
 	page = ((unsigned long *) __va(page))[address >> 22];
 	printk(KERN_ALERT "*pde = %08lx\n", page);
 	/*
@@ -523,7 +523,7 @@
 		pmd_t *pmd, *pmd_k;
 		pte_t *pte_k;
 
-		asm("movl %%cr3,%0":"=r" (pgd_paddr));
+		pgd_paddr = read_cr3();
 		pgd = index + (pgd_t *)__va(pgd_paddr);
 		pgd_k = init_mm.pgd + index;
 
Index: linux-2.6.13/arch/i386/mm/pageattr.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mm/pageattr.c	2005-07-29 11:14:33.000000000 -0700
+++ linux-2.6.13/arch/i386/mm/pageattr.c	2005-07-29 11:15:36.000000000 -0700
@@ -62,7 +62,7 @@
 { 
 	/* Could use CLFLUSH here if the CPU supports it (Hammer,P4) */
 	if (boot_cpu_data.x86_model >= 4) 
-		asm volatile("wbinvd":::"memory"); 
+		wbinvd();
 	/* Flush all to work around Errata in early athlons regarding 
 	 * large page flushing. 
 	 */
Index: linux-2.6.13/include/asm-i386/agp.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/agp.h	2005-07-29 11:14:33.000000000 -0700
+++ linux-2.6.13/include/asm-i386/agp.h	2005-07-29 11:15:36.000000000 -0700
@@ -19,7 +19,7 @@
 /* Could use CLFLUSH here if the cpu supports it. But then it would
    need to be called for each cacheline of the whole page so it may not be 
    worth it. Would need a page for it. */
-#define flush_agp_cache() asm volatile("wbinvd":::"memory")
+#define flush_agp_cache() wbinvd()
 
 /* Convert a physical address to an address suitable for the GART. */
 #define phys_to_gart(x) (x)
Index: linux-2.6.13/include/asm-i386/bugs.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/bugs.h	2005-07-29 11:14:33.000000000 -0700
+++ linux-2.6.13/include/asm-i386/bugs.h	2005-07-29 11:15:36.000000000 -0700
@@ -118,7 +118,10 @@
 		printk("disabled\n");
 		return;
 	}
-	__asm__ __volatile__("hlt ; hlt ; hlt ; hlt");
+	halt();
+	halt();
+	halt();
+	halt();
 	printk("OK.\n");
 }
 
Index: linux-2.6.13/include/asm-i386/processor.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/processor.h	2005-07-29 11:14:33.000000000 -0700
+++ linux-2.6.13/include/asm-i386/processor.h	2005-07-29 11:16:10.000000000 -0700
@@ -203,9 +203,7 @@
 	return edx;
 }
 
-#define load_cr3(pgdir) \
-	asm volatile("movl %0,%%cr3": :"r" (__pa(pgdir)))
-
+#define load_cr3(pgdir) write_cr3(__pa(pgdir))
 
 /*
  * Intel CPU features in CR4
@@ -232,22 +230,20 @@
 
 static inline void set_in_cr4 (unsigned long mask)
 {
+	unsigned cr4;
 	mmu_cr4_features |= mask;
-	__asm__("movl %%cr4,%%eax\n\t"
-		"orl %0,%%eax\n\t"
-		"movl %%eax,%%cr4\n"
-		: : "irg" (mask)
-		:"ax");
+	cr4 = read_cr4();
+	cr4 |= mask;
+	write_cr4(cr4);
 }
 
 static inline void clear_in_cr4 (unsigned long mask)
 {
+	unsigned cr4;
 	mmu_cr4_features &= ~mask;
-	__asm__("movl %%cr4,%%eax\n\t"
-		"andl %0,%%eax\n\t"
-		"movl %%eax,%%cr4\n"
-		: : "irg" (~mask)
-		:"ax");
+	cr4 = read_cr4();
+	cr4 &= ~mask;
+	write_cr4(cr4);
 }
 
 /*
Index: linux-2.6.13/include/asm-i386/xor.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/xor.h	2005-07-29 11:14:33.000000000 -0700
+++ linux-2.6.13/include/asm-i386/xor.h	2005-07-29 11:15:36.000000000 -0700
@@ -535,14 +535,14 @@
 
 #define XMMS_SAVE do {				\
 	preempt_disable();			\
+	cr0 = read_cr0();			\
+	clts();					\
 	__asm__ __volatile__ ( 			\
-		"movl %%cr0,%0		;\n\t"	\
-		"clts			;\n\t"	\
-		"movups %%xmm0,(%1)	;\n\t"	\
-		"movups %%xmm1,0x10(%1)	;\n\t"	\
-		"movups %%xmm2,0x20(%1)	;\n\t"	\
-		"movups %%xmm3,0x30(%1)	;\n\t"	\
-		: "=&r" (cr0)			\
+		"movups %%xmm0,(%0)	;\n\t"	\
+		"movups %%xmm1,0x10(%0)	;\n\t"	\
+		"movups %%xmm2,0x20(%0)	;\n\t"	\
+		"movups %%xmm3,0x30(%0)	;\n\t"	\
+		:				\
 		: "r" (xmm_save) 		\
 		: "memory");			\
 } while(0)
@@ -550,14 +550,14 @@
 #define XMMS_RESTORE do {			\
 	__asm__ __volatile__ ( 			\
 		"sfence			;\n\t"	\
-		"movups (%1),%%xmm0	;\n\t"	\
-		"movups 0x10(%1),%%xmm1	;\n\t"	\
-		"movups 0x20(%1),%%xmm2	;\n\t"	\
-		"movups 0x30(%1),%%xmm3	;\n\t"	\
-		"movl 	%0,%%cr0	;\n\t"	\
+		"movups (%0),%%xmm0	;\n\t"	\
+		"movups 0x10(%0),%%xmm1	;\n\t"	\
+		"movups 0x20(%0),%%xmm2	;\n\t"	\
+		"movups 0x30(%0),%%xmm3	;\n\t"	\
 		:				\
-		: "r" (cr0), "r" (xmm_save)	\
+		: "r" (xmm_save)		\
 		: "memory");			\
+	write_cr0(cr0);				\
 	preempt_enable();			\
 } while(0)
 
Index: linux-2.6.13/include/asm-i386/system.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/system.h	2005-07-29 11:14:33.000000000 -0700
+++ linux-2.6.13/include/asm-i386/system.h	2005-07-29 11:15:36.000000000 -0700
@@ -107,13 +107,33 @@
 #define clts() __asm__ __volatile__ ("clts")
 #define read_cr0() ({ \
 	unsigned int __dummy; \
-	__asm__( \
+	__asm__ __volatile__( \
 		"movl %%cr0,%0\n\t" \
 		:"=r" (__dummy)); \
 	__dummy; \
 })
 #define write_cr0(x) \
-	__asm__("movl %0,%%cr0": :"r" (x));
+	__asm__ __volatile__("movl %0,%%cr0": :"r" (x));
+
+#define read_cr2() ({ \
+	unsigned int __dummy; \
+	__asm__ __volatile__( \
+		"movl %%cr2,%0\n\t" \
+		:"=r" (__dummy)); \
+	__dummy; \
+})
+#define write_cr2(x) \
+	__asm__ __volatile__("movl %0,%%cr2": :"r" (x));
+
+#define read_cr3() ({ \
+	unsigned int __dummy; \
+	__asm__ ( \
+		"movl %%cr3,%0\n\t" \
+		:"=r" (__dummy)); \
+	__dummy; \
+})
+#define write_cr3(x) \
+	__asm__ __volatile__("movl %0,%%cr3": :"r" (x));
 
 #define read_cr4() ({ \
 	unsigned int __dummy; \
@@ -123,7 +143,7 @@
 	__dummy; \
 })
 #define write_cr4(x) \
-	__asm__("movl %0,%%cr4": :"r" (x));
+	__asm__ __volatile__("movl %0,%%cr4": :"r" (x));
 #define stts() write_cr0(8 | read_cr0())
 
 #endif	/* __KERNEL__ */
@@ -447,6 +467,8 @@
 #define local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
 /* used in the idle loop; sti takes one instruction cycle to complete */
 #define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
+/* used when interrupts are already enabled or to shutdown the processor */
+#define halt()			__asm__ __volatile__("hlt": : :"memory")
 
 #define irqs_disabled()			\
 ({					\
