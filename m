Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263700AbTJCGiA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 02:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTJCGiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 02:38:00 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:31916 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263571AbTJCGgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 02:36:52 -0400
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Ia64 Linux <linux-ia64@vger.kernel.org>
Date: Fri, 3 Oct 2003 16:36:45 +1000
Cc: Linux Kern <linux-kernel@vger.kernel.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Arun Sharma <arun.sharma@intel.com>
Subject: [TESTING] Require NUMA testing linux-2.6.0-test6
Message-ID: <20031003063645.GA31674@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi
If anybody is interested we require a patch to be
testing on an ia64 NUMA enabled machine. The patch 
makes use of the long format VHPT offered on ia64
machines. I have tested that it will compile with
NUMA enabled, however I do not have a NUMA machine
to run any tests on. Any help would be appreciated.
There has been a small discussion about this patch
on the ia64-linux list:
http://marc.theaimsgroup.com/?t=106453919500005&r=1&w=2


Thanks

--------------------------------------------------
Darren Williams <dsw@gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.0-test6-long-vhpt.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	v2.6.0-test6 -> 1.1376 
#	include/asm-ia64/mmu_context.h	1.15    -> 1.17   
#	include/asm-ia64/page.h	1.21    -> 1.22   
#	arch/ia64/kernel/setup.c	1.59    -> 1.61   
#	arch/ia64/kernel/ivt.S	1.23    -> 1.24   
#	include/asm-ia64/kregs.h	1.6     -> 1.7    
#	include/asm-ia64/asmmacro.h	1.12    -> 1.13   
#	arch/ia64/kernel/smpboot.c	1.39    -> 1.40   
#	include/asm-ia64/pgtable.h	1.28    -> 1.29   
#	include/asm-ia64/tlb.h	1.16    -> 1.17   
#	 arch/ia64/mm/init.c	1.48    -> 1.50   
#	            Makefile	1.432   -> 1.433  
#	arch/ia64/kernel/patch.c	1.5     -> 1.6    
#	  arch/ia64/mm/tlb.c	1.19    -> 1.20   
#	include/asm-ia64/tlbflush.h	1.9     -> 1.10   
#	   arch/ia64/Kconfig	1.46    -> 1.47   
#	arch/ia64/kernel/traps.c	1.39    -> 1.40   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/27	torvalds@home.osdl.org	1.1375
# Linux 2.6.0-test6
# --------------------------------------------
# 03/10/03	dsw@quasar.(none)	1.1376
# Clean up compiler warnings and add comments
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Fri Oct  3 14:07:36 2003
+++ b/Makefile	Fri Oct  3 14:07:36 2003
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 0
-EXTRAVERSION = -test6
+EXTRAVERSION = -test6-vhpt
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
diff -Nru a/arch/ia64/Kconfig b/arch/ia64/Kconfig
--- a/arch/ia64/Kconfig	Fri Oct  3 14:07:36 2003
+++ b/arch/ia64/Kconfig	Fri Oct  3 14:07:36 2003
@@ -685,7 +685,10 @@
 	  debugging info resulting in a larger kernel image.
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
-	  
+
+config IA64_LONG_FORMAT_VHPT
+	bool "Long format VHPT"
+
 endmenu
 
 source "security/Kconfig"
diff -Nru a/arch/ia64/kernel/ivt.S b/arch/ia64/kernel/ivt.S
--- a/arch/ia64/kernel/ivt.S	Fri Oct  3 14:07:36 2003
+++ b/arch/ia64/kernel/ivt.S	Fri Oct  3 14:07:36 2003
@@ -12,6 +12,8 @@
  *
  * 00/08/23 Asit Mallick <asit.k.mallick@intel.com> TLB handling for SMP
  * 00/12/20 David Mosberger-Tang <davidm@hpl.hp.com> DTLB/ITLB handler now uses virtual PT.
+ * 03/05/01 Matt Chapman <matthewc@cse.unsw.edu.au> Long format VHPT support
+ * 15/09/03 Darren Williams <dsw@cse.unsw.edu.au> update Long format VHPT support from 2.5.67 -> 2.6.0
  */
 /*
  * This file defines the interruption vector table used by the CPU.
@@ -70,6 +72,7 @@
 #define MINSTATE_VIRT	/* needed by minstate.h */
 #include "minstate.h"
 
+
 #define FAULT(n)									\
 	mov r31=pr;									\
 	mov r19=n;;			/* prepare to save predicates */		\
@@ -100,7 +103,14 @@
 	 * do_page_fault gets invoked in the following cases:
 	 *	- the faulting virtual address uses unimplemented address bits
 	 *	- the faulting virtual address has no L1, L2, or L3 mapping
-	 */
+	 *
+	 * This fault should not occur with the long format VHPT since we keep it
+	 * permanently mapped.
+ 	 */
+	 
+#ifdef CONFIG_IA64_LONG_FORMAT_VHPT
+	FAULT(0)
+#else
 	mov r16=cr.ifa				// get address that caused the TLB miss
 #ifdef CONFIG_HUGETLB_PAGE
 	movl r18=PAGE_SHIFT
@@ -198,6 +208,7 @@
 
 	mov pr=r31,-1				// restore predicate registers
 	rfi
+#endif /* !CONFIG_IA64_LONG_FORMAT_VHPT */
 END(vhpt_miss)
 
 	.org ia64_ivt+0x400
@@ -215,23 +226,18 @@
 	mov r29=b0				// save b0
 	mov r31=pr				// save predicates
 .itlb_fault:
-	mov r17=cr.iha				// get virtual address of L3 PTE
-	movl r30=1f				// load nested fault continuation point
-	;;
-1:	ld8 r18=[r17]				// read L3 PTE
-	;;
-	mov b0=r29
-	tbit.z p6,p0=r18,_PAGE_P_BIT		// page present bit cleared?
-(p6)	br.cond.spnt page_fault
+	LOAD_PTE_MISS(r16,r17,r18,r22,page_fault)	// find PTE and check present bit
 	;;
+	VHPT_INSERT(r16,r17,r18,r22)
 	itc.i r18
-	;;
 #ifdef CONFIG_SMP
+	;;
 	ld8 r19=[r17]				// read L3 PTE again and see if same
 	mov r20=PAGE_SHIFT<<2			// setup page size for purge
 	;;
 	cmp.ne p7,p0=r18,r19
 	;;
+	VHPT_PURGE(p7,r22)
 (p7)	ptc.l r16,r20
 #endif
 	mov pr=r31,-1
@@ -252,24 +258,19 @@
 	mov r16=cr.ifa				// get virtual address
 	mov r29=b0				// save b0
 	mov r31=pr				// save predicates
-dtlb_fault:
-	mov r17=cr.iha				// get virtual address of L3 PTE
-	movl r30=1f				// load nested fault continuation point
-	;;
-1:	ld8 r18=[r17]				// read L3 PTE
-	;;
-	mov b0=r29
-	tbit.z p6,p0=r18,_PAGE_P_BIT		// page present bit cleared?
-(p6)	br.cond.spnt page_fault
+.dtlb_fault:
+	LOAD_PTE_MISS(r16,r17,r18,r22,page_fault)	// find PTE and check present bit
 	;;
+	VHPT_INSERT(r16,r17,r18,r22)
 	itc.d r18
-	;;
 #ifdef CONFIG_SMP
+	;;
 	ld8 r19=[r17]				// read L3 PTE again and see if same
 	mov r20=PAGE_SHIFT<<2			// setup page size for purge
 	;;
 	cmp.ne p7,p0=r18,r19
 	;;
+	VHPT_PURGE(p7,r22)
 (p7)	ptc.l r16,r20
 #endif
 	mov pr=r31,-1
@@ -401,6 +402,9 @@
 	 * continuation point passed in register r30 (or call page_fault if the address is
 	 * not mapped).
 	 *
+	 * This fault should not occur with the long format VHPT since we keep it
+	 * permanently mapped.
+	 *	 
 	 * Input:	r16:	faulting address
 	 *		r29:	saved b0
 	 *		r30:	continuation address
@@ -411,44 +415,17 @@
 	 *		r30:	continuation address
 	 *		r31:	saved pr
 	 *
-	 * Clobbered:	b0, r18, r19, r21, psr.dt (cleared)
+	 * Clobbered:	b0, psr.dt (cleared), r24-r26 (see FIND_PTE)
 	 */
-	rsm psr.dt				// switch to using physical data addressing
-	mov r19=IA64_KR(PT_BASE)		// get the page table base address
-	shl r21=r16,3				// shift bit 60 into sign bit
-	;;
-	shr.u r17=r16,61			// get the region number into r17
-	;;
-	cmp.eq p6,p7=5,r17			// is faulting address in region 5?
-	shr.u r18=r16,PGDIR_SHIFT		// get bits 33-63 of faulting address
-	;;
-(p7)	dep r17=r17,r19,(PAGE_SHIFT-3),3	// put region number bits in place
-
-	srlz.d
-	LOAD_PHYSICAL(p6, r19, swapper_pg_dir)	// region 5 is rooted at swapper_pg_dir
-
-	.pred.rel "mutex", p6, p7
-(p6)	shr.u r21=r21,PGDIR_SHIFT+PAGE_SHIFT
-(p7)	shr.u r21=r21,PGDIR_SHIFT+PAGE_SHIFT-3
-	;;
-(p6)	dep r17=r18,r19,3,(PAGE_SHIFT-3)	// r17=PTA + IFA(33,42)*8
-(p7)	dep r17=r18,r17,3,(PAGE_SHIFT-6)	// r17=PTA + (((IFA(61,63) << 7) | IFA(33,39))*8)
-	cmp.eq p7,p6=0,r21			// unused address bits all zeroes?
-	shr.u r18=r16,PMD_SHIFT			// shift L2 index into position
-	;;
-	ld8 r17=[r17]				// fetch the L1 entry (may be 0)
-	;;
-(p7)	cmp.eq p6,p7=r17,r0			// was L1 entry NULL?
-	dep r17=r18,r17,3,(PAGE_SHIFT-3)	// compute address of L2 page table entry
-	;;
-(p7)	ld8 r17=[r17]				// fetch the L2 entry (may be 0)
-	shr.u r19=r16,PAGE_SHIFT		// shift L3 index into position
-	;;
-(p7)	cmp.eq.or.andcm p6,p7=r17,r0		// was L2 entry NULL?
-	dep r17=r19,r17,3,(PAGE_SHIFT-3)	// compute address of L3 page table entry
+#ifdef CONFIG_IA64_LONG_FORMAT_VHPT
+	DBG_FAULT(5)
+	FAULT(5)
+#else
+	FIND_PTE(r16,r17,p6,p7)
 (p6)	br.cond.spnt page_fault
 	mov b0=r30
 	br.sptk.many b0				// return to continuation point
+#endif
 END(nested_dtlb_miss)
 
 	.org ia64_ivt+0x1800
@@ -482,15 +459,12 @@
 	 * up the physical address of the L3 PTE and then continue at label 1 below.
 	 */
 	mov r16=cr.ifa				// get the address that caused the fault
-	movl r30=1f				// load continuation point in case of nested fault
-	;;
-	thash r17=r16				// compute virtual address of L3 PTE
-	mov r29=b0				// save b0 in case of nested fault
+	mov r29=b0				// save b0
 	mov r31=pr				// save pr
+	;;
+	LOAD_PTE_FAULT(r16,r17,r18,r22,.dtlb_fault)
 #ifdef CONFIG_SMP
 	mov r28=ar.ccv				// save ar.ccv
-	;;
-1:	ld8 r18=[r17]
 	;;					// avoid RAW on r18
 	mov ar.ccv=r18				// set compare value for cmpxchg
 	or r25=_PAGE_D|_PAGE_A,r18		// set the dirty and accessed bits
@@ -500,23 +474,22 @@
 	;;
 	cmp.eq p6,p7=r26,r18
 	;;
+	VHPT_UPDATE(p6,r18,r22)
 (p6)	itc.d r25				// install updated PTE
 	;;
 	ld8 r18=[r17]				// read PTE again
 	;;
 	cmp.eq p6,p7=r18,r25			// is it same as the newly installed
 	;;
+	VHPT_PURGE(p7,r22)
 (p7)	ptc.l r16,r24
-	mov b0=r29				// restore b0
 	mov ar.ccv=r28
 #else
-	;;
-1:	ld8 r18=[r17]
 	;;					// avoid RAW on r18
 	or r18=_PAGE_D|_PAGE_A,r18		// set the dirty and accessed bits
-	mov b0=r29				// restore b0
 	;;
 	st8 [r17]=r18				// store back updated PTE
+	VHPT_UPDATE(p0,r18,r22)
 	itc.d r18				// install updated PTE
 #endif
 	mov pr=r31,-1				// restore pr
@@ -530,7 +503,7 @@
 	DBG_FAULT(9)
 	// Like Entry 8, except for instruction access
 	mov r16=cr.ifa				// get the address that caused the fault
-	movl r30=1f				// load continuation point in case of nested fault
+	mov r29=b0				// save b0
 	mov r31=pr				// save predicates
 #ifdef CONFIG_ITANIUM
 	/*
@@ -544,13 +517,10 @@
 (p6)	mov r16=r18				// if so, use cr.iip instead of cr.ifa
 #endif /* CONFIG_ITANIUM */
 	;;
-	thash r17=r16				// compute virtual address of L3 PTE
-	mov r29=b0				// save b0 in case of nested fault)
+	LOAD_PTE_FAULT(r16,r17,r18,r22,.itlb_fault)
 #ifdef CONFIG_SMP
 	mov r28=ar.ccv				// save ar.ccv
 	;;
-1:	ld8 r18=[r17]
-	;;
 	mov ar.ccv=r18				// set compare value for cmpxchg
 	or r25=_PAGE_A,r18			// set the accessed bit
 	;;
@@ -559,23 +529,22 @@
 	;;
 	cmp.eq p6,p7=r26,r18
 	;;
+	VHPT_UPDATE(p6,r18,r22)
 (p6)	itc.i r25				// install updated PTE
 	;;
 	ld8 r18=[r17]				// read PTE again
 	;;
 	cmp.eq p6,p7=r18,r25			// is it same as the newly installed
 	;;
+	VHPT_PURGE(p7,r22)
 (p7)	ptc.l r16,r24
-	mov b0=r29				// restore b0
 	mov ar.ccv=r28
 #else /* !CONFIG_SMP */
 	;;
-1:	ld8 r18=[r17]
-	;;
 	or r18=_PAGE_A,r18			// set the accessed bit
-	mov b0=r29				// restore b0
 	;;
 	st8 [r17]=r18				// store back updated PTE
+	VHPT_UPDATE(p0,r18,r22)
 	itc.i r18				// install updated PTE
 #endif /* !CONFIG_SMP */
 	mov pr=r31,-1
@@ -589,15 +558,12 @@
 	DBG_FAULT(10)
 	// Like Entry 8, except for data access
 	mov r16=cr.ifa				// get the address that caused the fault
-	movl r30=1f				// load continuation point in case of nested fault
-	;;
-	thash r17=r16				// compute virtual address of L3 PTE
+	mov r29=b0				// save bo
 	mov r31=pr
-	mov r29=b0				// save b0 in case of nested fault)
+	;;
+	LOAD_PTE_FAULT(r16,r17,r18,r22,.dtlb_fault)
 #ifdef CONFIG_SMP
 	mov r28=ar.ccv				// save ar.ccv
-	;;
-1:	ld8 r18=[r17]
 	;;					// avoid RAW on r18
 	mov ar.ccv=r18				// set compare value for cmpxchg
 	or r25=_PAGE_A,r18			// set the dirty bit
@@ -607,12 +573,14 @@
 	;;
 	cmp.eq p6,p7=r26,r18
 	;;
+	VHPT_UPDATE(p6,r18,r22)
 (p6)	itc.d r25				// install updated PTE
 	;;
 	ld8 r18=[r17]				// read PTE again
 	;;
 	cmp.eq p6,p7=r18,r25			// is it same as the newly installed
 	;;
+	VHPT_PURGE(p7,r22)
 (p7)	ptc.l r16,r24
 	mov ar.ccv=r28
 #else
@@ -622,9 +590,9 @@
 	or r18=_PAGE_A,r18			// set the accessed bit
 	;;
 	st8 [r17]=r18				// store back updated PTE
+	VHPT_UPDATE(p0,r18,r22)
 	itc.d r18				// install updated PTE
 #endif
-	mov b0=r29				// restore b0
 	mov pr=r31,-1
 	rfi
 END(daccess_bit)
diff -Nru a/arch/ia64/kernel/patch.c b/arch/ia64/kernel/patch.c
--- a/arch/ia64/kernel/patch.c	Fri Oct  3 14:07:36 2003
+++ b/arch/ia64/kernel/patch.c	Fri Oct  3 14:07:36 2003
@@ -145,7 +145,6 @@
 	extern unsigned long fsyscall_table[NR_syscalls];
 	s32 *offp = (s32 *) start;
 	u64 ip;
-
 	while (offp < (s32 *) end) {
 		ip = (u64) ia64_imva((char *) offp + *offp);
 		ia64_patch_imm64(ip, (u64) fsyscall_table);
@@ -179,7 +178,6 @@
 {
 #	define START(name)	((unsigned long) __start_gate_##name##_patchlist)
 #	define END(name)	((unsigned long)__end_gate_##name##_patchlist)
-
 	patch_fsyscall_table(START(fsyscall), END(fsyscall));
 	patch_brl_fsys_bubble_down(START(brl_fsys_bubble_down), END(brl_fsys_bubble_down));
 	ia64_patch_vtop(START(vtop), END(vtop));
diff -Nru a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
--- a/arch/ia64/kernel/setup.c	Fri Oct  3 14:07:36 2003
+++ b/arch/ia64/kernel/setup.c	Fri Oct  3 14:07:36 2003
@@ -225,6 +225,15 @@
 #endif
 }
 
+#ifdef CONFIG_IA64_LONG_FORMAT_VHPT
+void __init
+compute_vhpt_size(void)
+{
+	long_vhpt_bits = 22;
+	long_vhpt_size = 1 << long_vhpt_bits;
+}
+#endif
+
 void __init
 setup_arch (char **cmdline_p)
 {
@@ -240,6 +249,10 @@
 
 	efi_init();
 	find_memory();
+
+#ifdef CONFIG_IA64_LONG_FORMAT_VHPT
+	compute_vhpt_size();
+#endif
 
 #ifdef CONFIG_ACPI_BOOT
 	/* Initialize the ACPI boot-time table parser */
diff -Nru a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
--- a/arch/ia64/kernel/smpboot.c	Fri Oct  3 14:07:36 2003
+++ b/arch/ia64/kernel/smpboot.c	Fri Oct  3 14:07:36 2003
@@ -381,7 +381,13 @@
 	unhash_process(idle);
 
 	task_for_booting_cpu = idle;
-
+#ifdef CONFIG_IA64_LONG_FORMAT_VHPT
+	if (alloc_vhpt(cpu)) {
+		panic("Couldn't allocate VHPT on CPU%d, size: %lx\n", cpu, long_vhpt_size);
+	}
+	printk(KERN_INFO "Allocated long format VHPT for CPU%d at: %lx, size: 0x%lx\n", cpu, vhpt_base[cpu], long_vhpt_size);
+#endif /* CONFIG_IA64_LONG_FORMAT_VHPT */
+	
 	Dprintk("Sending wakeup vector %lu to AP 0x%x/0x%x.\n", ap_wakeup_vector, cpu, sapicid);
 
 	platform_send_ipi(cpu, ap_wakeup_vector, IA64_IPI_DM_INT, 0);
diff -Nru a/arch/ia64/kernel/traps.c b/arch/ia64/kernel/traps.c
--- a/arch/ia64/kernel/traps.c	Fri Oct  3 14:07:36 2003
+++ b/arch/ia64/kernel/traps.c	Fri Oct  3 14:07:36 2003
@@ -454,7 +454,7 @@
 		"Unknown fault 9", "Unknown fault 10", "Unknown fault 11", "Unknown fault 12",
 		"Unknown fault 13", "Unknown fault 14", "Unknown fault 15"
 	};
-
+	
 	if ((isr & IA64_ISR_NA) && ((isr & IA64_ISR_CODE_MASK) == IA64_ISR_CODE_LFETCH)) {
 		/*
 		 * This fault was due to lfetch.fault, set "ed" bit in the psr to cancel
diff -Nru a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
--- a/arch/ia64/mm/init.c	Fri Oct  3 14:07:36 2003
+++ b/arch/ia64/mm/init.c	Fri Oct  3 14:07:36 2003
@@ -35,6 +35,11 @@
 
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
+#ifdef CONFIG_IA64_LONG_FORMAT_VHPT
+unsigned long vhpt_base[NR_CPUS];
+unsigned long long_vhpt_bits, long_vhpt_size;
+#endif
+
 extern void ia64_tlb_init (void);
 
 unsigned long MAX_DMA_ADDRESS = PAGE_OFFSET + 0x100000000UL;
@@ -270,6 +275,30 @@
 	ia64_patch_gate();
 }
 
+#ifdef CONFIG_IA64_LONG_FORMAT_VHPT 
+/*
+ * This code must be called on a CPU which has it's MMU
+ * initialized. The page allocator seems to depend on it.
+ *
+ * Returns 0 on success.
+*/
+ unsigned int
+alloc_vhpt(int cpu)
+{
+#ifdef CONFIG_NUMA	
+	struct page *page;
+	
+	page = alloc_pages_node(cpu_to_node(cpu), __GFP_HIGHMEM|GFP_ATOMIC, long_vhpt_bits - PAGE_SHIFT);
+	if (!page)
+		return -1;
+	vhpt_base[cpu] = (unsigned long) page_address(page);
+#else
+	vhpt_base[cpu] = (unsigned long)__get_free_pages(__GFP_HIGHMEM|GFP_ATOMIC, long_vhpt_bits - PAGE_SHIFT);
+#endif
+	return (vhpt_base[cpu] == 0);
+}
+#endif /* CONFIG_IA64_LONG_FORMAT_VHPT */
+
 void __init
 ia64_mmu_init (void *my_cpu_data)
 {
@@ -281,16 +310,46 @@
 #	define VHPT_ENABLE_BIT	1
 #endif
 
+#ifdef CONFIG_IA64_LONG_FORMAT_VHPT
+	int cpu = smp_processor_id();
+	if (cpu == 0)
+	{
+		vhpt_base[cpu] = (unsigned long)__alloc_bootmem(long_vhpt_size, long_vhpt_size, __pa(MAX_DMA_ADDRESS));
+		if (vhpt_base[cpu] == 0) {
+			panic("Couldn't allocate VHPT on CPU%d, size: %lx\n", cpu, long_vhpt_size);
+		} 
+		printk(KERN_INFO "Allocated long format VHPT for CPU%d at: %lx, size: 0x%lx\n", cpu, vhpt_base[cpu], long_vhpt_size);
+	}
+#endif
+
 	/* Pin mapping for percpu area into TLB */
 	psr = ia64_clear_ic();
 	ia64_itr(0x2, IA64_TR_PERCPU_DATA, PERCPU_ADDR,
 		 pte_val(pfn_pte(__pa(my_cpu_data) >> PAGE_SHIFT, PAGE_KERNEL)),
 		 PERCPU_PAGE_SHIFT);
 
+#ifdef CONFIG_IA64_LONG_FORMAT_VHPT
+	/* insert the permanent translation for the VHPT */
+	ia64_itr(0x2, IA64_TR_LONG_VHPT, LONG_VHPT_BASE,
+		 pte_val(pfn_pte(__pa(vhpt_base[cpu]) >> PAGE_SHIFT, PAGE_KERNEL)), long_vhpt_bits);
+#endif
+
 	ia64_set_psr(psr);
 	ia64_srlz_i();
 
+#ifdef CONFIG_IA64_LONG_FORMAT_VHPT
+	/*
+	 * LONG FORMAT VHPT
+	 */
+#	define VHPT_FORMAT_BIT		1
+#	define vhpt_bits		long_vhpt_bits
+
+	pta = LONG_VHPT_BASE;
+#else
+
 	/*
+	 * SHORT FORMAT VHPT (virtually mapped linear pagetable)
+	 *
 	 * Check if the virtually mapped linear page table (VMLPT) overlaps with a mapped
 	 * address space.  The IA-64 architecture guarantees that at least 50 bits of
 	 * virtual address space are implemented but if we pick a large enough page size
@@ -301,6 +360,7 @@
 	 * address space to not permit mappings that would overlap with the VMLPT.
 	 * --davidm 00/12/06
 	 */
+#	define VHPT_FORMAT_BIT		0
 #	define pte_bits			3
 #	define mapped_space_bits	(3*(PAGE_SHIFT - pte_bits) + PAGE_SHIFT)
 	/*
@@ -310,7 +370,7 @@
 	 * non-speculative accesses to the virtual page table, so the address range of the
 	 * virtual page table itself needs to be covered by virtual page table.
 	 */
-#	define vmlpt_bits		(impl_va_bits - PAGE_SHIFT + pte_bits)
+#	define vhpt_bits		(impl_va_bits - PAGE_SHIFT + pte_bits)
 #	define POW2(n)			(1ULL << (n))
 
 	impl_va_bits = ffz(~(local_cpu_data->unimpl_va_mask | (7UL << 61)));
@@ -319,18 +379,20 @@
 		panic("CPU has bogus IMPL_VA_MSB value of %lu!\n", impl_va_bits - 1);
 
 	/* place the VMLPT at the end of each page-table mapped region: */
-	pta = POW2(61) - POW2(vmlpt_bits);
+	pta = POW2(61) - POW2(vhpt_bits);
 
 	if (POW2(mapped_space_bits) >= pta)
 		panic("mm/init: overlap between virtually mapped linear page table and "
 		      "mapped kernel space!");
+#endif
+
 	/*
 	 * Set the (virtually mapped linear) page table address.  Bit
 	 * 8 selects between the short and long format, bits 2-7 the
 	 * size of the table, and bit 0 whether the VHPT walker is
 	 * enabled.
 	 */
-	ia64_set_pta(pta | (0 << 8) | (vmlpt_bits << 2) | VHPT_ENABLE_BIT);
+	ia64_set_pta(pta | (VHPT_FORMAT_BIT << 8) | (vhpt_bits << 2) | VHPT_ENABLE_BIT); 
 
 	ia64_tlb_init();
 }
@@ -659,7 +721,6 @@
 			fsyscall_table[i] = sys_call_table[i] | 1;
 	}
 	setup_gate();	/* setup gate pages before we free up boot memory... */
-
 #ifdef CONFIG_IA32_SUPPORT
 	ia32_gdt_init();
 #endif
diff -Nru a/arch/ia64/mm/tlb.c b/arch/ia64/mm/tlb.c
--- a/arch/ia64/mm/tlb.c	Fri Oct  3 14:07:36 2003
+++ b/arch/ia64/mm/tlb.c	Fri Oct  3 14:07:36 2003
@@ -109,6 +109,14 @@
 {
 	unsigned long i, j, flags, count0, count1, stride0, stride1, addr;
 
+#ifdef CONFIG_IA64_LONG_FORMAT_VHPT
+	unsigned long page;
+
+	/* Admittedly 0 is a valid tag, but in that rare case the present bit will save us */
+	for (page = LONG_VHPT_BASE; page < LONG_VHPT_BASE+long_vhpt_size; page += PAGE_SIZE)
+		clear_page((void *)page);
+#endif
+
 	addr    = local_cpu_data->ptce_base;
 	count0  = local_cpu_data->ptce_count[0];
 	count1  = local_cpu_data->ptce_count[1];
@@ -127,6 +135,41 @@
 	ia64_srlz_i();			/* srlz.i implies srlz.d */
 }
 
+
+#ifdef CONFIG_IA64_LONG_FORMAT_VHPT
+static void
+flush_vhpt_range (struct mm_struct *mm, unsigned long from, unsigned long to)
+{
+	unsigned long addr;
+
+	for (addr = from; addr < to; addr += PAGE_SIZE)
+		flush_vhpt_page(addr);
+
+#ifdef CONFIG_SMP
+	{
+		/* Urgh... flush VHPTs of any other CPUs that have run this mm */
+		extern unsigned long vhpt_base[];
+		unsigned long offset, cpu_mask;
+		long_pte_t *hpte;
+		int cpu;
+
+		cpu_mask = mm->cpu_vm_mask & ~(1 << smp_processor_id());
+		while (cpu_mask != 0)
+		{
+			cpu = __ffs(cpu_mask);
+			cpu_mask &= ~(1 << cpu);
+			for (addr = from; addr < to; addr += PAGE_SIZE)
+			{
+				offset = ia64_thash(addr) & (long_vhpt_size-1);
+				hpte = (long_pte_t *)(vhpt_base[cpu] + offset);
+				hpte->tag = INVALID_TAG;
+			}
+		}
+	}
+#endif
+}
+#endif
+
 void
 flush_tlb_range (struct vm_area_struct *vma, unsigned long start, unsigned long end)
 {
@@ -143,6 +186,10 @@
 #endif
 		return;
 	}
+
+#ifdef CONFIG_IA64_LONG_FORMAT_VHPT
+	flush_vhpt_range(mm, start, end);
+#endif
 
 	nbits = ia64_fls(size + 0xfff);
 	while (unlikely (((1UL << nbits) & purge.mask) == 0) && (nbits < purge.max_bits))
diff -Nru a/include/asm-ia64/asmmacro.h b/include/asm-ia64/asmmacro.h
--- a/include/asm-ia64/asmmacro.h	Fri Oct  3 14:07:36 2003
+++ b/include/asm-ia64/asmmacro.h	Fri Oct  3 14:07:36 2003
@@ -4,6 +4,11 @@
 /*
  * Copyright (C) 2000-2001, 2003 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
+ *
+ * 25/09/03 Darren Williams <dsw@cse.unsw.edu.au> move Long format VHPT MACROS 
+ * 	    from ivt.S to here. I though that this would keep the placement of 
+ *	    code and MACROS correct.
+ *
  */
 
 #include <linux/config.h>
@@ -83,5 +88,131 @@
 #else
 # define MCKINLEY_E9_WORKAROUND
 #endif
+
+
+/*
+ * Find a page table entry with the long format VHPT walker
+ */
+#define temp r24
+#define rgn r25
+#define mbz r26
+/* va=r16 ppte=r19 fail=p6 ok=p7 */
+#define FIND_PTE(va, ppte, fail, ok)								\
+	rsm psr.dt;				/* switch to using physical data addressing */	\
+	mov ppte=IA64_KR(PT_BASE);		/* get the page table base address */		\
+	shl mbz=va,3;				/* shift bit 60 into sign bit	*/		\
+	shr.u rgn=va,61;			/* get the region number into 'rgn' */		\
+	;;											\
+	cmp.eq p6,p7=5,rgn;			/* is faulting address in region 5? */		\
+	shr.u temp=va,PGDIR_SHIFT;		/* get bits 33-63 of faulting address */	\
+	;;											\
+(p7)	dep ppte=rgn,ppte,(PAGE_SHIFT-3),3;	/* put region number bits in place */		\
+	srlz.d;											\
+	LOAD_PHYSICAL(p6, ppte, swapper_pg_dir); /* region 5 is rooted at swapper_pg_dir */	\
+												\
+	.pred.rel "mutex", p6, p7;								\
+(p6)	shr.u mbz=mbz,PGDIR_SHIFT+PAGE_SHIFT;							\
+(p7)	shr.u mbz=mbz,PGDIR_SHIFT+PAGE_SHIFT-3;							\
+	;;											\
+(p6)	dep ppte=temp,ppte,3,(PAGE_SHIFT-3);	/* ppte=PTA + IFA(33,42)*8 */			\
+(p7)	dep ppte=temp,ppte,3,(PAGE_SHIFT-6);	/* ppte=PTA + (((IFA(61,63) << 7) | IFA(33,39))*8) */ \
+	cmp.eq ok,fail=0,mbz;			/* unused address bits all zeroes? */		\
+	shr.u temp=va,PMD_SHIFT;			/* shift L2 index into position	*/		\
+	;;											\
+	ld8 ppte=[ppte];			/* fetch the L1 entry (may be 0)*/		\
+	;;											\
+(ok)	cmp.eq fail,ok=ppte,r0;			/* was L1 entry NULL?*/				\
+	dep ppte=temp,ppte,3,(PAGE_SHIFT-3);	/* compute address of L2 page table entry*/	\
+	;;											\
+(ok)	ld8 ppte=[ppte];			/* fetch the L2 entry (may be 0)*/		\
+	shr.u temp=va,PAGE_SHIFT;		/* shift L3 index into position*/		\
+	;;											\
+(ok)	cmp.eq.or.andcm fail,ok=ppte,r0;		/* was L2 entry NULL?*/				\
+	dep ppte=temp,ppte,3,(PAGE_SHIFT-3);	/* compute address of L3 page table entry*/
+
+#ifdef CONFIG_IA64_LONG_FORMAT_VHPT
+
+#define LOAD_PTE_MISS(va, ppte, pte, hpte, failfn)						\
+	;;											\
+	FIND_PTE(va, ppte, p6, p7)								\
+	;;											\
+(p7)	ld8 pte=[ppte];										\
+	;;											\
+(p7)	tbit.z p6,p0=pte,_PAGE_P_BIT;		/* page present bit cleared? */			\
+(p6)	br.cond.spnt failfn; 
+
+/* Since we access the page table physically, we access the long VHPT physically as well
+ * to avoid switching back and forth */
+
+
+#define tag r25
+#define htag r26
+#define LOAD_PTE_FAULT(va, ppte, pte, hpte, failfn)						\
+	thash hpte=va;										\
+	rsm psr.dt;										\
+	;;											\
+	tpa hpte=hpte;				/* make hash address physical */		\
+	ttag tag=va;										\
+	;;											\
+	srlz.d;											\
+	add temp=16,hpte;									\
+	add ppte=24,hpte;									\
+	;;											\
+	ld8 htag=[temp];									\
+	ld8 ppte=[ppte];									\
+	;;											\
+	cmp.ne p6,p7=htag, tag;			/* verify tag */				\
+	;;											\
+(p7)	ld8 pte=[ppte];										\
+(p6)	br.cond.spnt failfn;
+
+#define tir r26
+#define VHPT_INSERT(va, ppte, pte, hpte)							\
+	mov hpte=cr.iha;									\
+	mov tir=cr.itir;									\
+	;;											\
+	tpa hpte=hpte;				/* make hash address physical */		\
+	ttag tag=va;										\
+	;;											\
+	add temp=16,hpte;									\
+	;;											\
+	st8 [hpte]=pte,8;			/* fill out VHPT entry */			\
+	st8 [temp]=tag,8;									\
+	;;											\
+	st8 [hpte]=tir,8;									\
+	st8 [temp]=ppte;
+	
+#define VHPT_UPDATE(cond, pte, hpte)								\
+(cond)	st8 [hpte]=pte,16;
+
+#define VHPT_PURGE(cond, hpte)									\
+(cond)	dep tag=-1,r0,63,1;			/* set tag-invalid bit */			\
+	;;											\
+(cond)	st8 [hpte]=tag;				/* hpte already points to tag (see above) */
+
+#else /* !CONFIG_IA64_LONG_FORMAT_VHPT */
+
+#define LOAD_PTE_MISS(va, ppte, pte, hpte, failfn)						\
+	mov ppte=cr.iha;			/* get virtual address of L3 PTE */		\
+	movl r30=1f;				/* load continuation point */			\
+	;;											\
+1:	ld8 pte=[ppte]; \
+	mov b0=r29;				/* restore possibly destroyed b0 */		\
+	;;											\
+	tbit.z p6,p0=pte,_PAGE_P_BIT;		/* page present bit cleared? */			\
+(p6)	br.cond.spnt failfn;
+
+#define LOAD_PTE_FAULT(va, ppte, pte, hpte, failfn)						\
+	thash ppte=va;				/* get virtual address of L3 PTE */		\
+	movl r30=1f;				/* load continuation point */			\
+	;;											\
+1:	ld8 pte=[ppte];										\
+	mov b0=r29;				/* restore possibly destroyed b0 */
+
+#define VHPT_INSERT(va, ppte, pte, hpte)		/* nothing */
+#define VHPT_UPDATE(cond, pte, hpte)			/* nothing */
+#define VHPT_PURGE(cond, hpte)				/* nothing */
+#endif
+
 
 #endif /* _ASM_IA64_ASMMACRO_H */
diff -Nru a/include/asm-ia64/kregs.h b/include/asm-ia64/kregs.h
--- a/include/asm-ia64/kregs.h	Fri Oct  3 14:07:36 2003
+++ b/include/asm-ia64/kregs.h	Fri Oct  3 14:07:36 2003
@@ -30,6 +30,7 @@
 #define IA64_TR_PALCODE		1	/* itr1: maps PALcode as required by EFI */
 #define IA64_TR_PERCPU_DATA	1	/* dtr1: percpu data */
 #define IA64_TR_CURRENT_STACK	2	/* dtr2: maps kernel's memory- & register-stacks */
+#define IA64_TR_LONG_VHPT	3	/* dtr3: maps long format VHPT */
 
 /* Processor status register bits: */
 #define IA64_PSR_BE_BIT		1
diff -Nru a/include/asm-ia64/mmu_context.h b/include/asm-ia64/mmu_context.h
--- a/include/asm-ia64/mmu_context.h	Fri Oct  3 14:07:36 2003
+++ b/include/asm-ia64/mmu_context.h	Fri Oct  3 14:07:36 2003
@@ -17,7 +17,21 @@
 
 #define IA64_REGION_ID_KERNEL	0 /* the kernel's region id (tlb.c depends on this being 0) */
 
-#define ia64_rid(ctx,addr)	(((ctx) << 3) | (addr >> 61))
+#ifdef CONFIG_IA64_LONG_FORMAT_VHPT
+/*
+ * Due to a high number of collisions in the long format VHPT walker hash function
+ * when RIDs and similar address space layout occur "eg. fork()". The following is
+ * used to space out the RIDs we present to the hardware without messing with Linux's 
+ * sequential allocation scheme. 
+ * Refer to 'Intel Itanium Processor Reference Manual for Software Development' 
+ * http://www.intel.com/design/itanium/manuals.htm 
+ */
+#define redistribute_rid(rid)	(((rid) & ~0xffff) | (((rid) << 8) & 0xff00) | (((rid) >> 8) & 0xff))
+#else
+#define redistribute_rid(rid)	(rid)
+#endif
+
+#define ia64_rid(ctx,addr)	redistribute_rid(((ctx) << 3) | (addr >> 61))
 
 # ifndef __ASSEMBLY__
 
@@ -141,7 +155,12 @@
 	unsigned long rr0, rr1, rr2, rr3, rr4;
 
 	rid = context << 3;	/* make space for encoding the region number */
+#ifdef CONFIG_IA64_LONG_FORMAT_VHPT
+	rid = redistribute_rid(rid);
+	rid_incr = 1 << 16;
+#else
 	rid_incr = 1 << 8;
+#endif
 
 	/* encode the region id, preferred page size, and VHPT enable bit: */
 	rr0 = (rid << 8) | (PAGE_SHIFT << 2) | 1;
@@ -173,6 +192,10 @@
 		MMU_TRACE('a', smp_processor_id(), mm, context);
 		/* in the unlikely event of a TLB-flush by another thread, redo the load: */
 	} while (unlikely(context != mm->context));
+	
+#if defined(CONFIG_IA64_LONG_FORMAT_VHPT) && defined(CONFIG_SMP)
+	set_bit(smp_processor_id(), &mm->cpu_vm_mask);
+#endif
 }
 
 #define deactivate_mm(tsk,mm)					\
diff -Nru a/include/asm-ia64/page.h b/include/asm-ia64/page.h
--- a/include/asm-ia64/page.h	Fri Oct  3 14:07:36 2003
+++ b/include/asm-ia64/page.h	Fri Oct  3 14:07:36 2003
@@ -151,6 +151,9 @@
 	return order;
 }
 
+/* Long format VHPT entry */
+typedef struct { unsigned long pte, itir, tag, ig; } long_pte_t;
+
 # endif /* __KERNEL__ */
 #endif /* !__ASSEMBLY__ */
 
diff -Nru a/include/asm-ia64/pgtable.h b/include/asm-ia64/pgtable.h
--- a/include/asm-ia64/pgtable.h	Fri Oct  3 14:07:36 2003
+++ b/include/asm-ia64/pgtable.h	Fri Oct  3 14:07:36 2003
@@ -474,6 +474,12 @@
     extern void memmap_init (struct page *start, unsigned long size, int nid, unsigned long zone,
 			     unsigned long start_pfn);
 #  endif /* CONFIG_VIRTUAL_MEM_MAP */
+
+#ifdef CONFIG_IA64_LONG_FORMAT_VHPT
+extern unsigned long vhpt_base[NR_CPUS];
+extern unsigned long long_vhpt_bits, long_vhpt_size;
+#endif
+
 # endif /* !__ASSEMBLY__ */
 
 /*
@@ -492,6 +498,11 @@
  */
 #define KERNEL_TR_PAGE_SHIFT	_PAGE_SIZE_64M
 #define KERNEL_TR_PAGE_SIZE	(1 << KERNEL_TR_PAGE_SHIFT)
+
+ /*
+ * Long format VHPT
+ */
+#define LONG_VHPT_BASE		(0xc000000000000000 - long_vhpt_size)
 
 /*
  * No page table caches to initialise
diff -Nru a/include/asm-ia64/tlb.h b/include/asm-ia64/tlb.h
--- a/include/asm-ia64/tlb.h	Fri Oct  3 14:07:36 2003
+++ b/include/asm-ia64/tlb.h	Fri Oct  3 14:07:36 2003
@@ -105,8 +105,10 @@
 		vma.vm_mm = tlb->mm;
 		/* flush the address range from the tlb: */
 		flush_tlb_range(&vma, start, end);
+#ifndef CONFIG_IA64_LONG_FORMAT_VHPT
 		/* now flush the virt. page-table area mapping the address range: */
 		flush_tlb_range(&vma, ia64_thash(start), ia64_thash(end));
+#endif
 	}
 
 	/* lastly, release the freed pages */
diff -Nru a/include/asm-ia64/tlbflush.h b/include/asm-ia64/tlbflush.h
--- a/include/asm-ia64/tlbflush.h	Fri Oct  3 14:07:36 2003
+++ b/include/asm-ia64/tlbflush.h	Fri Oct  3 14:07:36 2003
@@ -19,6 +19,21 @@
  * can be very expensive, so try to avoid them whenever possible.
  */
 
+/* Flushing a translation from the long format VHPT */
+#ifdef CONFIG_IA64_LONG_FORMAT_VHPT
+# define INVALID_TAG (1UL << 63)
+
+static inline void
+flush_vhpt_page(unsigned long addr)
+{
+	long_pte_t *hpte;
+	hpte = (long_pte_t *)ia64_thash(addr);
+	hpte->tag = INVALID_TAG;
+}
+#else
+# define flush_vhpt_page(addr)	do { } while (0)
+#endif
+
 /*
  * Flush everything (kernel mapping may also have changed due to
  * vmalloc/vfree).
@@ -53,6 +68,7 @@
 		goto out;
 
 	mm->context = 0;
+	mm->cpu_vm_mask = 0;
 
 	if (atomic_read(&mm->mm_users) == 0)
 		goto out;		/* happens as a result of exit_mmap() */
@@ -78,7 +94,10 @@
 	flush_tlb_range(vma, (addr & PAGE_MASK), (addr & PAGE_MASK) + PAGE_SIZE);
 #else
 	if (vma->vm_mm == current->active_mm)
+	{
+		flush_vhpt_page(addr);
 		ia64_ptcl(addr, (PAGE_SHIFT << 2));
+	}
 	else
 		vma->vm_mm->context = 0;
 #endif

--9amGYk9869ThD9tj--
