Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316223AbSEVQBm>; Wed, 22 May 2002 12:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316225AbSEVQBl>; Wed, 22 May 2002 12:01:41 -0400
Received: from fmr01.intel.com ([192.55.52.18]:19158 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S316223AbSEVQBa>;
	Wed, 22 May 2002 12:01:30 -0400
Message-ID: <9287DC1579B0D411AA2F009027F44C3F171C1DCE@fmsmsx41.fm.intel.com>
From: "Saxena, Sunil" <sunil.saxena@intel.com>
To: "'James Washer'" <washer@us.ibm.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Tom Epperly'" <tepperly@llnl.gov>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Seth, Rohit" <rohit.seth@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        "'Linus Torvalds (torvalds@transmeta.com)'" <torvalds@transmeta.com>
Subject: [PATCH] Illegal instruction failures fixes for 2.4.18
Date: Wed, 22 May 2002 09:01:20 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C201A9.E9A4AEE0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C201A9.E9A4AEE0
Content-Type: text/plain

Resending this in text form since it did not go out on the kernel mailing
lists.
Thanks
Sunil
 

Problem Statement: In March we received an issue from Tom Epperly of LLNL
that they were seeing bad illegal instruction traps on dual-xeon P4 while
running their Java workload.  This sighting was reproduced at Intel
subsequently.  We were able to get CPU traces and now understand this issue.
James Washer of IBM also notified to us last month on a critical sighting
that X servers were dumping cores on dual P4 machines.  Linus also
encountered strange (and nonreproducable) failures with compiler dying with
illegal instruction while recompiling kernel.

Root Cause Analysis: The CPU traces helped us identify that there is an
issue in the order in which page tables are freed in Linux.  Currently all
2.4.x kernels do the following steps for freeing page tables of a process
when called from exit_mmap and do_unmap:
	A. Repeat the following for all pdes to be cleared
		A.1. set PDE to zero (note all ptes in the page table are
zero at this time)
		A.2. free the page table corresponding to the PDE that was
zeroed.
	B. flushtlb is done as part of the context switch for the exit_mmap
path.  The flushtlb is not done for the do_munmap.

The real issue above is that page tables are freed before TLB is flushed.
The CPU traces showed the following happening in a dual processor
environment:
1. CPU 0 is executing do_munmap.  It does:  a) zap_page_range(clears ptes,
collects pages to be freed later, flushtlb, frees the pages)
2. CPU 0 wants to speculative prefetch instructions from some user address
that is getting dismantled above and initiates a page table walk.
3. CPU 0 gets the PDE and now wants to get the PTE and initiates a read of
PTE and stalls.  The PTE may have snooped out of CPU 0's cache and waits.
4. CPU 0 zeros the PDE.  Please note read of PTE above is now due to stale
PDE.
5. CPU 0 frees the page table corresponding to the PDE it zeroed above.
6. CPU 1 allocates the page freed by CPU 0 above and scribbles over it.  The
scribbling causes further delays in CPU 0 getting the Page Table Entry's
cache line".
7. CPU 0 finally gets unstalled and gets it's PTE from a cacheline which has
been overwritten by CPU 1.  The decode of this PTE is a valid, global, user,
non-reserved page, which gets stored in the tlb.
8. CPU 0 flushes tlb as part of part of the process switch but entry does
not get flushed as it is global
9. CPU 0 runs another process and executes code pointed by the above address
getting illegal instruction traps.

The above traces showed one case of failure, the problem is worse and could
happen in different ways in SMP environments with more than two processors.

Here is a scenario that highlights the problem of a multi-threaded
application in greater than two processor environment:
1. CPU 0 is executing do_munmap.  It does:  a) zap_page_range(clears ptes,
collects pages to be freed later, flushtlb, frees the pages)
2. CPU 1 is reading addresses that falls in the range that is being teared
down by CPU 0 and initiates a page walk.
3. CPU 1 is able to read PDE that has not been zeroed yet by CPU 0.  It
wants to read PTE for the address it wants to translate and stalls.
4. CPU 0 zeros the PDE and frees the page table corresponding to it.
5. CPU 2 allocates the page freed by CPU 0 above and scribbles over it.
6. CPU 1 gets the PTE and finds a valid pte for its use and
writes/reads/executes from the page pointed by the pte.
7. CPU 0 flushes tlbs for everyone, but it is already too late for CPU 1.

The real fix to the above problems is to make certain that the page table
pages are not freed before TLBs are flushed.  Linus has sent out his fixes
with the 2.5.16+ kernels. We were able to fix the 2.4.18 kernel in a very
similar way by using the quick lists as per the attached patch.  It
incorporates the fixes that Linus provided for using load_cr3 macro and TLB
fixes that Linus resolved for the lazy TLB case.  We would like to get more
eyes looking at this code and hope this issue is resolved.  Please note that
we have inserted flush_tlb_pgtables in clear_page_tables.  As an
optimization, we would have liked to remove the flush_tlb_mm in exit_mmap as
it is now unnecessary for x86, but we feel that it's removal may break other
architectures.

I like to acknowledge Asit K Mallick, Rohit Seth, Tony Luck, Jun Nakajima
and Venkatesh Pallipadi of Intel in helping find a simple solution for
2.4.18 kernels.

Thanks
Sunil
diff -ur linux-2.4.18.org/arch/i386/kernel/process.c
linux-2.4.18/arch/i386/kernel/process.c
--- linux-2.4.18.org/arch/i386/kernel/process.c	Mon Feb 25 11:37:53 2002
+++ linux-2.4.18/arch/i386/kernel/process.c	Tue May 21 11:21:07 2002
@@ -311,7 +311,7 @@
 	/*
 	 * Use `swapper_pg_dir' as our page directory.
 	 */
-	asm volatile("movl %0,%%cr3": :"r" (__pa(swapper_pg_dir)));
+	load_cr3(swapper_pg_dir);
 
 	/* Write 0x1234 to absolute memory location 0x472.  The BIOS reads
 	   this on booting to tell it to "Bypass memory test (also warm
diff -ur linux-2.4.18.org/arch/i386/kernel/smp.c
linux-2.4.18/arch/i386/kernel/smp.c
--- linux-2.4.18.org/arch/i386/kernel/smp.c	Fri Dec 21 09:41:53 2001
+++ linux-2.4.18/arch/i386/kernel/smp.c	Tue May 21 18:19:55 2002
@@ -298,12 +298,16 @@
 /*
  * We cannot call mmdrop() because we are in interrupt context, 
  * instead update mm->cpu_vm_mask.
+ *
+ * We need to reload %cr3 since the page tables may be going
+ * away from under us..
  */
 static void inline leave_mm (unsigned long cpu)
 {
 	if (cpu_tlbstate[cpu].state == TLBSTATE_OK)
 		BUG();
 	clear_bit(cpu, &cpu_tlbstate[cpu].active_mm->cpu_vm_mask);
+	load_cr3(swapper_pg_dir);
 }
 
 /*
diff -ur linux-2.4.18.org/arch/i386/mm/init.c
linux-2.4.18/arch/i386/mm/init.c
--- linux-2.4.18.org/arch/i386/mm/init.c	Fri Dec 21 09:41:53 2001
+++ linux-2.4.18/arch/i386/mm/init.c	Tue May 21 11:21:07 2002
@@ -334,7 +334,7 @@
 {
 	pagetable_init();
 
-	__asm__( "movl %%ecx,%%cr3\n" ::"c"(__pa(swapper_pg_dir)));
+	load_cr3(swapper_pg_dir);	
 
 #if CONFIG_X86_PAE
 	/*
diff -ur linux-2.4.18.org/include/asm-generic/tlb.h
linux-2.4.18/include/asm-generic/tlb.h
--- linux-2.4.18.org/include/asm-generic/tlb.h	Fri Sep 14 08:41:04 2001
+++ linux-2.4.18/include/asm-generic/tlb.h	Tue May 21 11:21:07 2002
@@ -55,8 +55,9 @@
 #define tlb_remove_page(ctxp, pte, addr) do {\
 		/* Handle the common case fast, first. */\
 		if ((ctxp)->nr == ~0UL) {\
-			__free_pte(*(pte));\
-			pte_clear((pte));\
+			pte_t __pte = *(pte);\
+			pte_clear(pte);\
+			__free_pte(__pte);\
 			break;\
 		}\
 		if (!(ctxp)->nr) \
diff -ur linux-2.4.18.org/include/asm-i386/mmu_context.h
linux-2.4.18/include/asm-i386/mmu_context.h
--- linux-2.4.18.org/include/asm-i386/mmu_context.h	Thu Nov 22 11:46:19
2001
+++ linux-2.4.18/include/asm-i386/mmu_context.h	Tue May 21 12:09:51 2002
@@ -42,7 +42,7 @@
 		set_bit(cpu, &next->cpu_vm_mask);
 		set_bit(cpu, &next->context.cpuvalid);
 		/* Re-load page tables */
-		asm volatile("movl %0,%%cr3": :"r" (__pa(next->pgd)));
+		load_cr3(next->pgd);
 	}
 #ifdef CONFIG_SMP
 	else {
@@ -51,9 +51,9 @@
 			BUG();
 		if(!test_and_set_bit(cpu, &next->cpu_vm_mask)) {
 			/* We were in lazy tlb mode and leave_mm disabled 
-			 * tlb flush IPI delivery. We must flush our tlb.
+			 * tlb flush IPI delivery. We must reload %cr3.
 			 */
-			local_flush_tlb();
+			load_cr3(next->pgd);
 		}
 		if (!test_and_set_bit(cpu, &next->context.cpuvalid))
 			load_LDT(next);
diff -ur linux-2.4.18.org/include/asm-i386/pgalloc.h
linux-2.4.18/include/asm-i386/pgalloc.h
--- linux-2.4.18.org/include/asm-i386/pgalloc.h	Fri Dec 21 09:42:03 2001
+++ linux-2.4.18/include/asm-i386/pgalloc.h	Tue May 21 12:09:51 2002
@@ -139,7 +139,7 @@
 	free_page((unsigned long)pte);
 }
 
-#define pte_free(pte)		pte_free_slow(pte)
+#define pte_free(pte)		pte_free_fast(pte)
 #define pgd_free(pgd)		free_pgd_slow(pgd)
 #define pgd_alloc(mm)		get_pgd_fast()
 
@@ -227,13 +227,12 @@
 };
 extern struct tlb_state cpu_tlbstate[NR_CPUS];
 
-
-#endif
+#endif /* CONFIG_SMP */
 
 static inline void flush_tlb_pgtables(struct mm_struct *mm,
 				      unsigned long start, unsigned long
end)
 {
-	/* i386 does not keep any page table caches in TLB */
+	flush_tlb_mm(mm);
 }
 
 #endif /* _I386_PGALLOC_H */
diff -ur linux-2.4.18.org/include/asm-i386/processor.h
linux-2.4.18/include/asm-i386/processor.h
--- linux-2.4.18.org/include/asm-i386/processor.h	Thu Nov 22 11:46:19
2001
+++ linux-2.4.18/include/asm-i386/processor.h	Tue May 21 12:09:51 2002
@@ -190,6 +190,9 @@
 #define X86_CR4_OSFXSR		0x0200	/* enable fast FPU save and restore
*/
 #define X86_CR4_OSXMMEXCPT	0x0400	/* enable unmasked SSE exceptions */
 
+#define load_cr3(pgdir) \
+	asm volatile("movl %0,%%cr3": :"r" (__pa(pgdir)));
+
 /*
  * Save the cr4 feature set we're using (ie
  * Pentium 4MB enable and PPro Global page
diff -ur linux-2.4.18.org/mm/memory.c linux-2.4.18/mm/memory.c
--- linux-2.4.18.org/mm/memory.c	Mon Feb 25 11:38:13 2002
+++ linux-2.4.18/mm/memory.c	Tue May 21 11:21:07 2002
@@ -144,6 +144,7 @@
 void clear_page_tables(struct mm_struct *mm, unsigned long first, int nr)
 {
 	pgd_t * page_dir = mm->pgd;
+	unsigned long	last = first + nr;
 
 	spin_lock(&mm->page_table_lock);
 	page_dir += first;
@@ -153,6 +154,8 @@
 	} while (--nr);
 	spin_unlock(&mm->page_table_lock);
 
+	flush_tlb_pgtables(mm, first * PGDIR_SIZE, last * PGDIR_SIZE);
+	
 	/* keep the page table cache within bounds */
 	check_pgt_cache();
 }
diff -ur linux-2.4.18.org/mm/mmap.c linux-2.4.18/mm/mmap.c
--- linux-2.4.18.org/mm/mmap.c	Mon Feb 25 11:38:14 2002
+++ linux-2.4.18/mm/mmap.c	Tue May 21 11:21:07 2002
@@ -885,7 +885,6 @@
 	end_index = pgd_index(last);
 	if (end_index > start_index) {
 		clear_page_tables(mm, start_index, end_index - start_index);
-		flush_tlb_pgtables(mm, first & PGDIR_MASK, last &
PGDIR_MASK);
 	}
 }
 


 <<patch_final>> 

------_=_NextPart_000_01C201A9.E9A4AEE0
Content-Type: application/octet-stream;
	name="patch_final"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch_final"

diff -ur linux-2.4.18.org/arch/i386/kernel/process.c =
linux-2.4.18/arch/i386/kernel/process.c=0A=
--- linux-2.4.18.org/arch/i386/kernel/process.c	Mon Feb 25 11:37:53 =
2002=0A=
+++ linux-2.4.18/arch/i386/kernel/process.c	Tue May 21 11:21:07 2002=0A=
@@ -311,7 +311,7 @@=0A=
 	/*=0A=
 	 * Use `swapper_pg_dir' as our page directory.=0A=
 	 */=0A=
-	asm volatile("movl %0,%%cr3": :"r" (__pa(swapper_pg_dir)));=0A=
+	load_cr3(swapper_pg_dir);=0A=
 =0A=
 	/* Write 0x1234 to absolute memory location 0x472.  The BIOS reads=0A=
 	   this on booting to tell it to "Bypass memory test (also warm=0A=
diff -ur linux-2.4.18.org/arch/i386/kernel/smp.c =
linux-2.4.18/arch/i386/kernel/smp.c=0A=
--- linux-2.4.18.org/arch/i386/kernel/smp.c	Fri Dec 21 09:41:53 2001=0A=
+++ linux-2.4.18/arch/i386/kernel/smp.c	Tue May 21 18:19:55 2002=0A=
@@ -298,12 +298,16 @@=0A=
 /*=0A=
  * We cannot call mmdrop() because we are in interrupt context, =0A=
  * instead update mm->cpu_vm_mask.=0A=
+ *=0A=
+ * We need to reload %cr3 since the page tables may be going=0A=
+ * away from under us..=0A=
  */=0A=
 static void inline leave_mm (unsigned long cpu)=0A=
 {=0A=
 	if (cpu_tlbstate[cpu].state =3D=3D TLBSTATE_OK)=0A=
 		BUG();=0A=
 	clear_bit(cpu, &cpu_tlbstate[cpu].active_mm->cpu_vm_mask);=0A=
+	load_cr3(swapper_pg_dir);=0A=
 }=0A=
 =0A=
 /*=0A=
diff -ur linux-2.4.18.org/arch/i386/mm/init.c =
linux-2.4.18/arch/i386/mm/init.c=0A=
--- linux-2.4.18.org/arch/i386/mm/init.c	Fri Dec 21 09:41:53 2001=0A=
+++ linux-2.4.18/arch/i386/mm/init.c	Tue May 21 11:21:07 2002=0A=
@@ -334,7 +334,7 @@=0A=
 {=0A=
 	pagetable_init();=0A=
 =0A=
-	__asm__( "movl %%ecx,%%cr3\n" ::"c"(__pa(swapper_pg_dir)));=0A=
+	load_cr3(swapper_pg_dir);	=0A=
 =0A=
 #if CONFIG_X86_PAE=0A=
 	/*=0A=
diff -ur linux-2.4.18.org/include/asm-generic/tlb.h =
linux-2.4.18/include/asm-generic/tlb.h=0A=
--- linux-2.4.18.org/include/asm-generic/tlb.h	Fri Sep 14 08:41:04 =
2001=0A=
+++ linux-2.4.18/include/asm-generic/tlb.h	Tue May 21 11:21:07 2002=0A=
@@ -55,8 +55,9 @@=0A=
 #define tlb_remove_page(ctxp, pte, addr) do {\=0A=
 		/* Handle the common case fast, first. */\=0A=
 		if ((ctxp)->nr =3D=3D ~0UL) {\=0A=
-			__free_pte(*(pte));\=0A=
-			pte_clear((pte));\=0A=
+			pte_t __pte =3D *(pte);\=0A=
+			pte_clear(pte);\=0A=
+			__free_pte(__pte);\=0A=
 			break;\=0A=
 		}\=0A=
 		if (!(ctxp)->nr) \=0A=
diff -ur linux-2.4.18.org/include/asm-i386/mmu_context.h =
linux-2.4.18/include/asm-i386/mmu_context.h=0A=
--- linux-2.4.18.org/include/asm-i386/mmu_context.h	Thu Nov 22 11:46:19 =
2001=0A=
+++ linux-2.4.18/include/asm-i386/mmu_context.h	Tue May 21 12:09:51 =
2002=0A=
@@ -42,7 +42,7 @@=0A=
 		set_bit(cpu, &next->cpu_vm_mask);=0A=
 		set_bit(cpu, &next->context.cpuvalid);=0A=
 		/* Re-load page tables */=0A=
-		asm volatile("movl %0,%%cr3": :"r" (__pa(next->pgd)));=0A=
+		load_cr3(next->pgd);=0A=
 	}=0A=
 #ifdef CONFIG_SMP=0A=
 	else {=0A=
@@ -51,9 +51,9 @@=0A=
 			BUG();=0A=
 		if(!test_and_set_bit(cpu, &next->cpu_vm_mask)) {=0A=
 			/* We were in lazy tlb mode and leave_mm disabled =0A=
-			 * tlb flush IPI delivery. We must flush our tlb.=0A=
+			 * tlb flush IPI delivery. We must reload %cr3.=0A=
 			 */=0A=
-			local_flush_tlb();=0A=
+			load_cr3(next->pgd);=0A=
 		}=0A=
 		if (!test_and_set_bit(cpu, &next->context.cpuvalid))=0A=
 			load_LDT(next);=0A=
diff -ur linux-2.4.18.org/include/asm-i386/pgalloc.h =
linux-2.4.18/include/asm-i386/pgalloc.h=0A=
--- linux-2.4.18.org/include/asm-i386/pgalloc.h	Fri Dec 21 09:42:03 =
2001=0A=
+++ linux-2.4.18/include/asm-i386/pgalloc.h	Tue May 21 12:09:51 2002=0A=
@@ -139,7 +139,7 @@=0A=
 	free_page((unsigned long)pte);=0A=
 }=0A=
 =0A=
-#define pte_free(pte)		pte_free_slow(pte)=0A=
+#define pte_free(pte)		pte_free_fast(pte)=0A=
 #define pgd_free(pgd)		free_pgd_slow(pgd)=0A=
 #define pgd_alloc(mm)		get_pgd_fast()=0A=
 =0A=
@@ -227,13 +227,12 @@=0A=
 };=0A=
 extern struct tlb_state cpu_tlbstate[NR_CPUS];=0A=
 =0A=
-=0A=
-#endif=0A=
+#endif /* CONFIG_SMP */=0A=
 =0A=
 static inline void flush_tlb_pgtables(struct mm_struct *mm,=0A=
 				      unsigned long start, unsigned long end)=0A=
 {=0A=
-	/* i386 does not keep any page table caches in TLB */=0A=
+	flush_tlb_mm(mm);=0A=
 }=0A=
 =0A=
 #endif /* _I386_PGALLOC_H */=0A=
diff -ur linux-2.4.18.org/include/asm-i386/processor.h =
linux-2.4.18/include/asm-i386/processor.h=0A=
--- linux-2.4.18.org/include/asm-i386/processor.h	Thu Nov 22 11:46:19 =
2001=0A=
+++ linux-2.4.18/include/asm-i386/processor.h	Tue May 21 12:09:51 =
2002=0A=
@@ -190,6 +190,9 @@=0A=
 #define X86_CR4_OSFXSR		0x0200	/* enable fast FPU save and restore =
*/=0A=
 #define X86_CR4_OSXMMEXCPT	0x0400	/* enable unmasked SSE exceptions =
*/=0A=
 =0A=
+#define load_cr3(pgdir) \=0A=
+	asm volatile("movl %0,%%cr3": :"r" (__pa(pgdir)));=0A=
+=0A=
 /*=0A=
  * Save the cr4 feature set we're using (ie=0A=
  * Pentium 4MB enable and PPro Global page=0A=
diff -ur linux-2.4.18.org/mm/memory.c linux-2.4.18/mm/memory.c=0A=
--- linux-2.4.18.org/mm/memory.c	Mon Feb 25 11:38:13 2002=0A=
+++ linux-2.4.18/mm/memory.c	Tue May 21 11:21:07 2002=0A=
@@ -144,6 +144,7 @@=0A=
 void clear_page_tables(struct mm_struct *mm, unsigned long first, int =
nr)=0A=
 {=0A=
 	pgd_t * page_dir =3D mm->pgd;=0A=
+	unsigned long	last =3D first + nr;=0A=
 =0A=
 	spin_lock(&mm->page_table_lock);=0A=
 	page_dir +=3D first;=0A=
@@ -153,6 +154,8 @@=0A=
 	} while (--nr);=0A=
 	spin_unlock(&mm->page_table_lock);=0A=
 =0A=
+	flush_tlb_pgtables(mm, first * PGDIR_SIZE, last * PGDIR_SIZE);=0A=
+	=0A=
 	/* keep the page table cache within bounds */=0A=
 	check_pgt_cache();=0A=
 }=0A=
diff -ur linux-2.4.18.org/mm/mmap.c linux-2.4.18/mm/mmap.c=0A=
--- linux-2.4.18.org/mm/mmap.c	Mon Feb 25 11:38:14 2002=0A=
+++ linux-2.4.18/mm/mmap.c	Tue May 21 18:55:54 2002=0A=
@@ -885,7 +885,6 @@=0A=
 	end_index =3D pgd_index(last);=0A=
 	if (end_index > start_index) {=0A=
 		clear_page_tables(mm, start_index, end_index - start_index);=0A=
-		flush_tlb_pgtables(mm, first & PGDIR_MASK, last & PGDIR_MASK);=0A=
 	}=0A=
 }=0A=
 =0A=

------_=_NextPart_000_01C201A9.E9A4AEE0--
