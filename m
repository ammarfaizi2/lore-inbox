Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130777AbRCWMoP>; Fri, 23 Mar 2001 07:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130686AbRCWMoH>; Fri, 23 Mar 2001 07:44:07 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:53210 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130770AbRCWMnb>; Fri, 23 Mar 2001 07:43:31 -0500
Message-ID: <3ABB452F.6A7E4C42@uow.edu.au>
Date: Fri, 23 Mar 2001 23:44:31 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>,
        Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [patch] Re: 2.4.3-pre6: agpart.o causes arch/i386/mm/ioremap.c hang
In-Reply-To: <200103230952.BAA06705@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
>          In case anyone is interested, the conflicting lock of
> init_mm.page_table_lock was acquired in line 1318 of mm/memory.c,
> in pte_alloc.

You can sorta blame me for that.  I reviewed the locking in
the mmap_sem patch and said it was correct :(

I only checked that the new locking was correct, rather than
checking that the new locking *rules* were being complied
with kernel-wide.

pmd_alloc() has the same problem.  It requires ->page_table_lock,
and we have bugs there. Fixed in this patch.

Linus, this patch includes the mm->rss locking stuff which
I sent yesterday.

Also, is the comment over remap_page_range true?  Should the caller
be doing a down_write(mmap_sem)?  If so, then there are
about thirty callers who don't.  I've looked at each one,
and it is safe to do the down_write() *within* remap_page_range().



--- linux-2.4.3-pre6/fs/exec.c	Thu Mar 22 18:52:52 2001
+++ linux-akpm/fs/exec.c	Fri Mar 23 22:08:48 2001
@@ -252,6 +252,8 @@
 /*
  * This routine is used to map in a page into an address space: needed by
  * execve() for the initial stack and environment pages.
+ *
+ * tsk->mmap_sem is held for writing.
  */
 void put_dirty_page(struct task_struct * tsk, struct page *page, unsigned long address)
 {
@@ -291,6 +293,7 @@
 	unsigned long stack_base;
 	struct vm_area_struct *mpnt;
 	int i;
+	unsigned long rss_increment = 0;
 
 	stack_base = STACK_TOP - MAX_ARG_PAGES*PAGE_SIZE;
 
@@ -322,11 +325,14 @@
 		struct page *page = bprm->page[i];
 		if (page) {
 			bprm->page[i] = NULL;
-			current->mm->rss++;
+			rss_increment++;
 			put_dirty_page(current,page,stack_base);
 		}
 		stack_base += PAGE_SIZE;
 	}
+	spin_lock(&current->mm->page_table_lock);
+	current->mm->rss += rss_increment;
+	spin_unlock(&current->mm->page_table_lock);
 	up_write(&current->mm->mmap_sem);
 	
 	return 0;
--- linux-2.4.3-pre6/include/linux/mm.h	Thu Mar 22 18:52:52 2001
+++ linux-akpm/include/linux/mm.h	Fri Mar 23 23:32:00 2001
@@ -407,6 +407,8 @@
  * On a two-level page table, this ends up being trivial. Thus the
  * inlining and the symmetry break with pte_alloc() that does all
  * of this out-of-line.
+ *
+ * __pmd_alloc() requires that mm->page_table_lock be held, so we do too.
  */
 static inline pmd_t *pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 {
--- linux-2.4.3-pre6/include/linux/sched.h	Thu Mar 22 18:52:52 2001
+++ linux-akpm/include/linux/sched.h	Fri Mar 23 22:08:48 2001
@@ -209,9 +209,12 @@
 	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
 	int map_count;				/* number of VMAs */
 	struct rw_semaphore mmap_sem;
-	spinlock_t page_table_lock;
+	spinlock_t page_table_lock;		/* Protects task page tables and mm->rss */
 
-	struct list_head mmlist;		/* List of all active mm's */
+	struct list_head mmlist;		/* List of all active mm's.  These are globally strung
+						 * together off init_mm.mmlist, and are protected
+						 * by mmlist_lock
+						 */
 
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long start_brk, brk, start_stack;
--- linux-2.4.3-pre6/mm/memory.c	Fri Mar 23 22:16:55 2001
+++ linux-akpm/mm/memory.c	Fri Mar 23 23:32:05 2001
@@ -374,7 +374,6 @@
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
-	spin_unlock(&mm->page_table_lock);
 	/*
 	 * Update rss for the mm_struct (not necessarily current->mm)
 	 * Notice that rss is an unsigned long.
@@ -383,6 +382,7 @@
 		mm->rss -= freed;
 	else
 		mm->rss = 0;
+	spin_unlock(&mm->page_table_lock);
 }
 
 
@@ -655,6 +655,7 @@
 	} while (address && (address < end));
 }
 
+/* mm->page_table_lock must be held */
 static inline int zeromap_pmd_range(struct mm_struct *mm, pmd_t * pmd, unsigned long address,
                                     unsigned long size, pgprot_t prot)
 {
@@ -734,6 +735,7 @@
 	} while (address && (address < end));
 }
 
+/* mm->page_table_lock must be held */
 static inline int remap_pmd_range(struct mm_struct *mm, pmd_t * pmd, unsigned long address, unsigned long size,
 	unsigned long phys_addr, pgprot_t prot)
 {
@@ -792,6 +794,8 @@
  *  - flush the old one
  *  - update the page tables
  *  - inform the TLB about the new one
+ *
+ * We hold the mm semaphore for reading and vma->vm_mm->page_table_lock
  */
 static inline void establish_pte(struct vm_area_struct * vma, unsigned long address, pte_t *page_table, pte_t entry)
 {
@@ -800,6 +804,9 @@
 	update_mmu_cache(vma, address, entry);
 }
 
+/*
+ * We hold the mm semaphore for reading and vma->vm_mm->page_table_lock
+ */
 static inline void break_cow(struct vm_area_struct * vma, struct page *	old_page, struct page * new_page, unsigned long address, 
 		pte_t *page_table)
 {
@@ -1024,8 +1031,7 @@
 }
 
 /*
- * We hold the mm semaphore and the page_table_lock on entry
- * and exit.
+ * We hold the mm semaphore and the page_table_lock on entry and exit.
  */
 static int do_swap_page(struct mm_struct * mm,
 	struct vm_area_struct * vma, unsigned long address,
--- linux-2.4.3-pre6/mm/mmap.c	Thu Mar 22 18:52:52 2001
+++ linux-akpm/mm/mmap.c	Fri Mar 23 22:08:48 2001
@@ -889,8 +889,8 @@
 	spin_lock(&mm->page_table_lock);
 	mpnt = mm->mmap;
 	mm->mmap = mm->mmap_avl = mm->mmap_cache = NULL;
-	spin_unlock(&mm->page_table_lock);
 	mm->rss = 0;
+	spin_unlock(&mm->page_table_lock);
 	mm->total_vm = 0;
 	mm->locked_vm = 0;
 
--- linux-2.4.3-pre6/mm/mremap.c	Thu Mar 22 18:52:52 2001
+++ linux-akpm/mm/mremap.c	Fri Mar 23 22:22:04 2001
@@ -15,6 +15,11 @@
 
 extern int vm_enough_memory(long pages);
 
+/*
+ * Throughout all the following functions, mm->mmap_sem must be held for
+ * writing, and mm->page_table_lock must be held
+ */
+
 static inline pte_t *get_one_pte(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t * pgd;
--- linux-2.4.3-pre6/mm/swapfile.c	Sun Feb 25 17:37:14 2001
+++ linux-akpm/mm/swapfile.c	Fri Mar 23 22:08:48 2001
@@ -209,6 +209,7 @@
  * share this swap entry, so be cautious and let do_wp_page work out
  * what to do if a write is requested later.
  */
+/* tasklist_lock and vma->vm_mm->page_table_lock are held */
 static inline void unuse_pte(struct vm_area_struct * vma, unsigned long address,
 	pte_t *dir, swp_entry_t entry, struct page* page)
 {
@@ -234,6 +235,7 @@
 	++vma->vm_mm->rss;
 }
 
+/* tasklist_lock and vma->vm_mm->page_table_lock are held */
 static inline void unuse_pmd(struct vm_area_struct * vma, pmd_t *dir,
 	unsigned long address, unsigned long size, unsigned long offset,
 	swp_entry_t entry, struct page* page)
@@ -261,6 +263,7 @@
 	} while (address && (address < end));
 }
 
+/* tasklist_lock and vma->vm_mm->page_table_lock are held */
 static inline void unuse_pgd(struct vm_area_struct * vma, pgd_t *dir,
 	unsigned long address, unsigned long size,
 	swp_entry_t entry, struct page* page)
@@ -291,6 +294,7 @@
 	} while (address && (address < end));
 }
 
+/* tasklist_lock and vma->vm_mm->page_table_lock are held */
 static void unuse_vma(struct vm_area_struct * vma, pgd_t *pgdir,
 			swp_entry_t entry, struct page* page)
 {
--- linux-2.4.3-pre6/mm/vmalloc.c	Thu Mar 22 18:52:52 2001
+++ linux-akpm/mm/vmalloc.c	Fri Mar 23 22:38:07 2001
@@ -123,7 +123,11 @@
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 	do {
-		pte_t * pte = pte_alloc(&init_mm, pmd, address);
+		pte_t * pte;
+
+		spin_lock(&init_mm.page_table_lock);	/* pte_alloc requires this */
+		pte = pte_alloc(&init_mm, pmd, address);
+		spin_unlock(&init_mm.page_table_lock);
 		if (!pte)
 			return -ENOMEM;
 		if (alloc_area_pte(pte, address, end - address, gfp_mask, prot))
@@ -147,7 +151,9 @@
 	do {
 		pmd_t *pmd;
 		
+		spin_lock(&init_mm.page_table_lock);	/* pmd_alloc requires this */
 		pmd = pmd_alloc(&init_mm, dir, address);
+		spin_unlock(&init_mm.page_table_lock);
 		ret = -ENOMEM;
 		if (!pmd)
 			break;
--- linux-2.4.3-pre6/mm/vmscan.c	Tue Jan 16 07:36:49 2001
+++ linux-akpm/mm/vmscan.c	Fri Mar 23 22:08:48 2001
@@ -25,16 +25,15 @@
 #include <asm/pgalloc.h>
 
 /*
- * The swap-out functions return 1 if they successfully
- * threw something out, and we got a free page. It returns
- * zero if it couldn't do anything, and any other value
- * indicates it decreased rss, but the page was shared.
+ * The swap-out function returns 1 if it successfully
+ * scanned all the pages it was asked to (`count').
+ * It returns zero if it couldn't do anything,
  *
- * NOTE! If it sleeps, it *must* return 1 to make sure we
- * don't continue with the swap-out. Otherwise we may be
- * using a process that no longer actually exists (it might
- * have died while we slept).
+ * rss may decrease because pages are shared, but this
+ * doesn't count as having freed a page.
  */
+
+/* mm->page_table_lock is held. mmap_sem is not held */
 static void try_to_swap_out(struct mm_struct * mm, struct vm_area_struct* vma, unsigned long address, pte_t * page_table, struct page *page)
 {
 	pte_t pte;
@@ -129,6 +128,7 @@
 	return;
 }
 
+/* mm->page_table_lock is held. mmap_sem is not held */
 static int swap_out_pmd(struct mm_struct * mm, struct vm_area_struct * vma, pmd_t *dir, unsigned long address, unsigned long end, int count)
 {
 	pte_t * pte;
@@ -165,6 +165,7 @@
 	return count;
 }
 
+/* mm->page_table_lock is held. mmap_sem is not held */
 static inline int swap_out_pgd(struct mm_struct * mm, struct vm_area_struct * vma, pgd_t *dir, unsigned long address, unsigned long end, int count)
 {
 	pmd_t * pmd;
@@ -194,6 +195,7 @@
 	return count;
 }
 
+/* mm->page_table_lock is held. mmap_sem is not held */
 static int swap_out_vma(struct mm_struct * mm, struct vm_area_struct * vma, unsigned long address, int count)
 {
 	pgd_t *pgdir;
@@ -218,6 +220,9 @@
 	return count;
 }
 
+/*
+ * Returns non-zero if we scanned all `count' pages
+ */
 static int swap_out_mm(struct mm_struct * mm, int count)
 {
 	unsigned long address;
@@ -879,6 +884,7 @@
  * If there are applications that are active memory-allocators
  * (most normal use), this basically shouldn't matter.
  */
+
 int kswapd(void *unused)
 {
 	struct task_struct *tsk = current;
