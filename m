Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316438AbSETXg5>; Mon, 20 May 2002 19:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316439AbSETXg4>; Mon, 20 May 2002 19:36:56 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:61957 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316438AbSETXgy>; Mon, 20 May 2002 19:36:54 -0400
Date: Tue, 21 May 2002 01:36:46 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix rss accounting
In-Reply-To: <Pine.LNX.4.21.0205202357390.23394-100000@serv>
Message-ID: <Pine.LNX.4.21.0205210131090.23394-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 21 May 2002, I wrote:

> The patch does this as well. It seems to get the rss tracking right, at
> least I couldn't trigger the print with some basic tests here and allows
> to simplify tlb_finish_mmu().

Here is a slightly simpler patch, instead of modifiying
pte_alloc/pte_free simply increment rss in pmd_populate.

Changes:

asm-generic/tlb.h: 
- introduce tlb_fast_mode() and reduce table size to optimize for UP only mode
- fix and simplify rss handling
linux/mm.h:
- __free_pte() doesn't exist anymore
binfmt_{aout,elf}.c:
- initializing of mm->rss/mm->mmap is redundant
pmd_populate():
- add rss accounting (pte_free needs mm arg for this)
do_no_page():
- fix rss accounting
exit_mmap():
- check mm->rss on exit

bye, Roman

Index: fs/binfmt_aout.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/fs/binfmt_aout.c,v
retrieving revision 1.1.1.3
diff -u -p -r1.1.1.3 binfmt_aout.c
--- fs/binfmt_aout.c	14 Apr 2002 20:01:10 -0000	1.1.1.3
+++ fs/binfmt_aout.c	20 May 2002 20:46:17 -0000
@@ -308,8 +308,6 @@ static int load_aout_binary(struct linux
 	current->mm->brk = ex.a_bss +
 		(current->mm->start_brk = N_BSSADDR(ex));
 
-	current->mm->rss = 0;
-	current->mm->mmap = NULL;
 	compute_creds(bprm);
  	current->flags &= ~PF_FORKNOEXEC;
 #ifdef __sparc__
Index: fs/binfmt_elf.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/fs/binfmt_elf.c,v
retrieving revision 1.1.1.6
diff -u -p -r1.1.1.6 binfmt_elf.c
--- fs/binfmt_elf.c	14 Apr 2002 20:01:09 -0000	1.1.1.6
+++ fs/binfmt_elf.c	20 May 2002 20:46:18 -0000
@@ -600,13 +600,11 @@ static int load_elf_binary(struct linux_
 	current->mm->start_data = 0;
 	current->mm->end_data = 0;
 	current->mm->end_code = 0;
-	current->mm->mmap = NULL;
 	current->flags &= ~PF_FORKNOEXEC;
 	elf_entry = (unsigned long) elf_ex.e_entry;
 
 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
-	current->mm->rss = 0;
 	setup_arg_pages(bprm); /* XXX: check error */
 	current->mm->start_stack = bprm->p;
 
Index: include/asm-generic/tlb.h
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/include/asm-generic/tlb.h,v
retrieving revision 1.1.1.4
diff -u -p -r1.1.1.4 tlb.h
--- include/asm-generic/tlb.h	18 May 2002 13:39:29 -0000	1.1.1.4
+++ include/asm-generic/tlb.h	20 May 2002 20:46:18 -0000
@@ -14,10 +14,17 @@
 #define _ASM_GENERIC__TLB_H
 
 #include <linux/config.h>
+#include <linux/swap.h>
 #include <asm/tlbflush.h>
 
+#ifdef CONFIG_SMP
+#define tlb_fast_mode(tlb) ((tlb)->nr == ~0UL)	
 /* aim for something that fits in the L1 cache */
 #define FREE_PTE_NR	508
+#else
+#define tlb_fast_mode(tlb) (1)
+#define FREE_PTE_NR	1
+#endif
 
 /* mmu_gather_t is an opaque type used by the mm code for passing around any
  * data needed by arch specific code for tlb_remove_page.  This structure can
@@ -55,12 +62,10 @@ static inline mmu_gather_t *tlb_gather_m
 
 static inline void tlb_flush_mmu(mmu_gather_t *tlb, unsigned long start, unsigned long end)
 {
-	unsigned long nr;
-
 	flush_tlb_mm(tlb->mm);
-	nr = tlb->nr;
-	if (nr != ~0UL) {
-		unsigned long i;
+	if (!tlb_fast_mode(tlb)) {
+		unsigned long nr, i;
+		nr = tlb->nr;
 		tlb->nr = 0;
 		for (i=0; i < nr; i++)
 			free_page_and_swap_cache(tlb->pages[i]);
@@ -73,13 +78,7 @@ static inline void tlb_flush_mmu(mmu_gat
  */
 static inline void tlb_finish_mmu(mmu_gather_t *tlb, unsigned long start, unsigned long end)
 {
-	int freed = tlb->freed;
-	struct mm_struct *mm = tlb->mm;
-	int rss = mm->rss;
-
-	if (rss < freed)
-		freed = rss;
-	mm->rss = rss - freed;
+	tlb->mm->rss -= tlb->freed;
 	tlb_flush_mmu(tlb, start, end);
 }
 
@@ -91,8 +90,9 @@ static inline void tlb_finish_mmu(mmu_ga
  */
 static inline void tlb_remove_page(mmu_gather_t *tlb, struct page *page)
 {
-	/* Handle the common case fast, first. */\
-	if (tlb->nr == ~0UL) {
+	/* Handle the common case fast, first. */
+	tlb->freed++;
+	if (tlb_fast_mode(tlb)) {
 		free_page_and_swap_cache(page);
 		return;
 	}
Index: include/asm-i386/pgalloc.h
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/include/asm-i386/pgalloc.h,v
retrieving revision 1.1.1.9
diff -u -p -r1.1.1.9 pgalloc.h
--- include/asm-i386/pgalloc.h	18 May 2002 13:39:30 -0000	1.1.1.9
+++ include/asm-i386/pgalloc.h	20 May 2002 23:27:24 -0000
@@ -14,6 +14,7 @@ static inline void pmd_populate(struct m
 	set_pmd(pmd, __pmd(_PAGE_TABLE +
 		((unsigned long long)(pte - mem_map) <<
 			(unsigned long long) PAGE_SHIFT)));
+	mm->rss++;
 }
 /*
  * Allocate and free page tables.
Index: include/linux/mm.h
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/include/linux/mm.h,v
retrieving revision 1.1.1.11
diff -u -p -r1.1.1.11 mm.h
--- include/linux/mm.h	18 May 2002 13:39:19 -0000	1.1.1.11
+++ include/linux/mm.h	20 May 2002 20:50:19 -0000
@@ -383,8 +383,6 @@ extern void swapin_readahead(swp_entry_t
 extern int can_share_swap_page(struct page *);
 extern int remove_exclusive_swap_page(struct page *);
 
-extern void __free_pte(pte_t);
-
 /* mmap.c */
 extern void lock_vma_mappings(struct vm_area_struct *);
 extern void unlock_vma_mappings(struct vm_area_struct *);
Index: mm/memory.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/mm/memory.c,v
retrieving revision 1.1.1.12
diff -u -p -r1.1.1.12 memory.c
--- mm/memory.c	18 May 2002 13:39:18 -0000	1.1.1.12
+++ mm/memory.c	20 May 2002 23:21:26 -0000
@@ -1326,7 +1326,8 @@ static int do_no_page(struct mm_struct *
 	 */
 	/* Only go through if we didn't race with anybody else... */
 	if (pte_none(*page_table)) {
-		++mm->rss;
+		if (!PageReserved(new_page))
+			++mm->rss;
 		flush_page_to_ram(new_page);
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
Index: mm/mmap.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/mm/mmap.c,v
retrieving revision 1.1.1.7
diff -u -p -r1.1.1.7 mmap.c
--- mm/mmap.c	18 May 2002 13:39:18 -0000	1.1.1.7
+++ mm/mmap.c	20 May 2002 20:46:18 -0000
@@ -1128,6 +1128,9 @@ void exit_mmap(struct mm_struct * mm)
 	clear_page_tables(tlb, FIRST_USER_PGD_NR, USER_PTRS_PER_PGD);
 	tlb_finish_mmu(tlb, FIRST_USER_PGD_NR*PGDIR_SIZE, USER_PTRS_PER_PGD*PGDIR_SIZE);
 
+	if (mm->rss)
+		printk("mm %p has nonzero rss (%ld) (%d,%s)\n", mm, mm->rss, current->pid, current->comm);
+
 	mpnt = mm->mmap;
 	mm->mmap = mm->mmap_cache = NULL;
 	mm->mm_rb = RB_ROOT;

