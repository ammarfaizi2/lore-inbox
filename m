Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290433AbSBOSF0>; Fri, 15 Feb 2002 13:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290422AbSBOSFJ>; Fri, 15 Feb 2002 13:05:09 -0500
Received: from dsl-213-023-039-219.arcor-ip.net ([213.23.39.219]:2950 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290389AbSBOSEt>;
	Fri, 15 Feb 2002 13:04:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Shared page tables, updated
Date: Fri, 15 Feb 2002 19:09:41 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16bmnl-0002oq-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

I stupidly forgot to cc you when I made this post yesterday.  The code is
quite radically revised, and I think it's just about where it needs to be.

After the 'pmd_clear', what kind of shootdown do we need, and what is a
convenient way to implement it that gets around the fact that the mm is one
of two different kinds of structs, depending on whether you are SMP or UP?
Do we need to create a new, per-arch helper or something for this?

--
Daniel

------------------------
The original version of the shared page tables patch suffered from an oversight,
namely, that page use counts would need to be decremented in try_to_swap_out
and incremented in the various flavors of swap_in by an amount equal to the
share count of the page table.  This would have been a relatively ugly change,
so instead the design was changed to do the page use count incrementing at
unshare time instead of at fork time, which is one of the possible
optimizations that had been discussed in the original post.  Thanks to Dave
McCracken for giving me a push in that direction.

A second, more serious problem with the original patch is that zap_page_range
forces all shared page tables to be unshared in order to be unmapped, which
completely defeats the purpose of the patch, leaving little more than a
latency advantage.

To deal with time, zap_page_range has been modified to remove entire page
tables when possible.  The strategy is to unshare the leading and trailing
partial page tables first, then each shared page table encountered during
the zap can simply be removed from the page directory.  The page table
doesn't need to be traversed at all, much less copied.  The result is that
large shared mappings or CoW regions that haven't been written to can be
removed 4 MB at a time, as follows:

	if (page_count(virt_to_page(ptep)) > 1) {
		pmd_clear(pmd);
		put_page(virt_to_page(ptep));
		return 0;
	}

There is a lot more room to optimize zap_page_range by improving the way
vmas are fed to it.  Right now they come in one at a time, even though each
vma tends to immediately adjoin the next one in the list.  The ranges needed
unmapping can instead be accumulated in exit_mmap and passed as a
contiguous region to zap_page_range, which will be able to take advantage
of more opportunities to unmap entire shared page tables.

Though the basic design seems to be arriving at a workable, and dare I say
it, somewhat pleasing form, there is still a lot of testing and debugging
to do.  Swapping hasn't been tested yet (it should work, but...) and smp
considerations are only beginning to be be analyzed.

Dave McCracken kindly contributed this C program, forktime.c, very useful
both for debugging and benchmarking:
--------------------------------------------------------------------------
/*
 *  Time fork() system call.
 */

#include <unistd.h>
#include <stdio.h>

#include <sys/types.h>
#include <sys/time.h>
#include <sys/mman.h>

static void usage(char *name);
static void mapmem();

static int	iter = 100;
static int	memsize = 0;

int
main(int argc, char *argv[])
{
    int			i, c;
    int			pid;
    struct timeval	stime, etime, rtime;
    extern char		*optarg;

    while ((c = getopt(argc, argv, "i:m:")) != -1) switch(c) {

      case 'i':
	  iter = atoi(optarg);
	  break;

      case 'm':
	  memsize = atoi(optarg);
	  break;

      default:
	  usage(argv[0]);
    }

    if (memsize)
	mapmem();

    gettimeofday (&stime, NULL);
    for (i = 0; i < iter; i++) {
	if ((pid = fork()) == -1) {
	    perror("fork");
	    break;
	} else if (pid == 0) {
	    exit(0);
	}
    }
    gettimeofday(&etime, NULL);

    timersub(&etime, &stime, &rtime);
    printf("Total time taken %d.%06d seconds in %d iterations\n",
	    rtime.tv_sec, rtime.tv_usec, i);
    
    c = ((rtime.tv_sec * 1000000) + rtime.tv_usec) / i;
    printf("or %d microseconds per fork.\n", c);

    exit(0);
}

static void
usage(char *name)
{
    fprintf(stderr, "Usage: %s [-i iterations] [-m mappedpages]\n", name);
    exit(1);
}

static void
mapmem()
{
    int		i;
    int		psize = getpagesize();
    char	*mp;

    mp = mmap(NULL, memsize * psize, PROT_READ|PROT_WRITE,
	      MAP_PRIVATE | MAP_ANON, 0, 0);

    for (i = 0; i < memsize; i++) {
	mp[i * psize] = i;
    }
}
--------------------------------------------------------------------------


--- ../uml.2.4.17.clean/fs/exec.c	Fri Dec 21 18:41:55 2001
+++ ./fs/exec.c	Thu Feb 14 20:46:34 2002
@@ -860,6 +860,7 @@
 	int retval;
 	int i;
 
+	if (current->uid == 9999) printk(">>> execve %s\n", filename);
 	file = open_exec(filename);
 
 	retval = PTR_ERR(file);
--- ../uml.2.4.17.clean/include/linux/mm.h	Fri Dec 21 18:42:03 2001
+++ ./include/linux/mm.h	Thu Feb 14 22:52:25 2002
@@ -411,7 +411,7 @@
 
 extern int vmtruncate(struct inode * inode, loff_t offset);
 extern pmd_t *FASTCALL(__pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address));
-extern pte_t *FASTCALL(pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
+extern pte_t *FASTCALL(__pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address, int write));
 extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
 extern int make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
@@ -424,6 +424,11 @@
 
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
 		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);
+
+static inline pte_t *pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
+{
+	return __pte_alloc(mm, pmd, address, 1);
+}
 
 /*
  * On a two-level page table, this ends up being trivial. Thus the
--- ../uml.2.4.17.clean/include/linux/sched.h	Fri Dec 21 18:42:03 2001
+++ ./include/linux/sched.h	Thu Feb 14 20:46:34 2002
@@ -427,7 +427,7 @@
 #define PF_MEMDIE	0x00001000	/* Killed for out-of-memory */
 #define PF_FREE_PAGES	0x00002000	/* per process page freeing */
 #define PF_NOIO		0x00004000	/* avoid generating further I/O */
-
+#define PF_SHARE_TABLES 0x00008000    /* share page tables (testing) */
 #define PF_USEDFPU	0x00100000	/* task used FPU this quantum (SMP) */
 
 /*
--- ../uml.2.4.17.clean/kernel/fork.c	Wed Nov 21 19:18:42 2001
+++ ./kernel/fork.c	Thu Feb 14 20:46:34 2002
@@ -140,6 +140,7 @@
 	mm->swap_address = 0;
 	pprev = &mm->mmap;
 
+	if (current->uid == 9999) printk(">>> dup_mmap\n");
 	/*
 	 * Add it to the mmlist after the parent.
 	 * Doing it this way means that we can order the list,
@@ -566,9 +567,10 @@
 	struct task_struct *p;
 	struct completion vfork;
 
+	if (current->uid == 9999) printk(">>> fork, stack=%li\n", stack_start);
 	retval = -EPERM;
 
-	/* 
+	/*
 	 * CLONE_PID is only allowed for the initial SMP swapper
 	 * calls
 	 */
--- ../uml.2.4.17.clean/kernel/sys.c	Tue Sep 18 23:10:43 2001
+++ ./kernel/sys.c	Thu Feb 14 20:46:34 2002
@@ -514,6 +514,11 @@
 	current->uid = new_ruid;
 	current->user = new_user;
 	free_uid(old_user);
+
+	if (current->uid == 9999)
+		current->flags |= PF_SHARE_TABLES;
+	printk(">>> user: uid=%i pid=%i pf=%x\n", current->uid, current->pid, current->flags);
+	
 	return 0;
 }
 
--- ../uml.2.4.17.clean/mm/memory.c	Fri Dec 21 18:42:05 2001
+++ ./mm/memory.c	Fri Feb 15 07:13:57 2002
@@ -79,7 +79,7 @@
 	if ((!VALID_PAGE(page)) || PageReserved(page))
 		return;
 	if (pte_dirty(pte))
-		set_page_dirty(page);		
+		set_page_dirty(page);
 	free_page_and_swap_cache(page);
 }
 
@@ -100,8 +100,12 @@
 		return;
 	}
 	pte = pte_offset(dir, 0);
-	pmd_clear(dir);
-	pte_free(pte);
+	if (current->uid == 9999 || page_count(virt_to_page(pte)) > 1)
+		printk(">>> free page table %p (%i)\n", pte, page_count(virt_to_page(pte)));
+	if (put_page_testzero(virt_to_page(pte))) {
+		pmd_clear(dir);
+		pte_free(pte);
+	}
 }
 
 static inline void free_one_pgd(pgd_t * dir)
@@ -143,8 +147,8 @@
  */
 void clear_page_tables(struct mm_struct *mm, unsigned long first, int nr)
 {
-	pgd_t * page_dir = mm->pgd;
-
+	pgd_t *page_dir = mm->pgd;
+	if (current->uid == 9999) printk(">>> clear_page_tables\n");
 	spin_lock(&mm->page_table_lock);
 	page_dir += first;
 	do {
@@ -175,10 +179,17 @@
 			struct vm_area_struct *vma)
 {
 	pgd_t * src_pgd, * dst_pgd;
+	int share_page_tables = !!(current->flags & PF_SHARE_TABLES);
 	unsigned long address = vma->vm_start;
 	unsigned long end = vma->vm_end;
 	unsigned long cow = (vma->vm_flags & (VM_SHARED | VM_WRITE)) == VM_WRITE;
 
+	static int teststart = 0, testcount = 999, tests = 0;
+	if (share_page_tables && (tests++ < teststart || tests > teststart + testcount))
+		share_page_tables = 0;
+	if (share_page_tables)
+		printk(">>> copy_page_range test %i\n", tests - 1);
+
 	src_pgd = pgd_offset(src, address)-1;
 	dst_pgd = pgd_offset(dst, address)-1;
 
@@ -186,15 +197,15 @@
 		pmd_t * src_pmd, * dst_pmd;
 
 		src_pgd++; dst_pgd++;
-		
+
 		/* copy_pmd_range */
-		
+
 		if (pgd_none(*src_pgd))
-			goto skip_copy_pmd_range;
+			goto skip_pmd_range;
 		if (pgd_bad(*src_pgd)) {
 			pgd_ERROR(*src_pgd);
 			pgd_clear(src_pgd);
-skip_copy_pmd_range:	address = (address + PGDIR_SIZE) & PGDIR_MASK;
+skip_pmd_range:		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 			if (!address || (address >= end))
 				goto out;
 			continue;
@@ -204,34 +215,56 @@
 		dst_pmd = pmd_alloc(dst, dst_pgd, address);
 		if (!dst_pmd)
 			goto nomem;
-
 		do {
-			pte_t * src_pte, * dst_pte;
-		
-			/* copy_pte_range */
-		
+			pte_t *src_ptb, *dst_ptb;
+
 			if (pmd_none(*src_pmd))
-				goto skip_copy_pte_range;
+				goto skip_ptb_range;
 			if (pmd_bad(*src_pmd)) {
 				pmd_ERROR(*src_pmd);
 				pmd_clear(src_pmd);
-skip_copy_pte_range:		address = (address + PMD_SIZE) & PMD_MASK;
+skip_ptb_range:			address = (address + PMD_SIZE) & PMD_MASK;
 				if (address >= end)
 					goto out;
-				goto cont_copy_pmd_range;
+				goto cont_pmd_range;
 			}
 
-			src_pte = pte_offset(src_pmd, address);
-			dst_pte = pte_alloc(dst, dst_pmd, address);
-			if (!dst_pte)
+			src_ptb = pte_offset(src_pmd, address);
+
+			if (!share_page_tables) goto no_share;
+
+			if (pmd_none(*dst_pmd)) {
+				get_page(virt_to_page(src_ptb));
+				pmd_populate(dst, dst_pmd, ((unsigned long) src_ptb & PAGE_MASK));
+				printk(">>> share %p @ %p (%i)\n", src_ptb, address,
+					page_count(virt_to_page(src_ptb)));
+			} else if (page_count(virt_to_page(src_ptb)) == 1) // should test for ptbs !=
+				goto no_share;
+
+			spin_lock(&src->page_table_lock);
+			do {
+				pte_t pte = *src_ptb;
+				if (!pte_none(pte) && pte_present(pte)) {
+					struct page *page = pte_page(pte);
+					if (VALID_PAGE(page) && !PageReserved(page) && cow)
+						ptep_set_wrprotect(src_ptb);
+				}
+				if ((address += PAGE_SIZE) >= end)
+					goto out_unlock;
+				src_ptb++;
+			} while ((unsigned) src_ptb & PTE_TABLE_MASK);
+			spin_unlock(&src->page_table_lock);
+
+			goto cont_pmd_range;
+no_share:
+			dst_ptb = __pte_alloc(dst, dst_pmd, address, 0);
+			if (!dst_ptb)
 				goto nomem;
 
-			spin_lock(&src->page_table_lock);			
+			spin_lock(&src->page_table_lock);
 			do {
-				pte_t pte = *src_pte;
+				pte_t pte = *src_ptb;
 				struct page *ptepage;
-				
-				/* copy_one_pte */
 
 				if (pte_none(pte))
 					goto cont_copy_pte_range_noset;
@@ -240,14 +273,14 @@
 					goto cont_copy_pte_range;
 				}
 				ptepage = pte_page(pte);
-				if ((!VALID_PAGE(ptepage)) || 
+				if ((!VALID_PAGE(ptepage)) ||
 				    PageReserved(ptepage))
 					goto cont_copy_pte_range;
 
 				/* If it's a COW mapping, write protect it both in the parent and the child */
 				if (cow) {
-					ptep_set_wrprotect(src_pte);
-					pte = *src_pte;
+					ptep_set_wrprotect(src_ptb);
+					pte = *src_ptb;
 				}
 
 				/* If it's a shared mapping, mark it clean in the child */
@@ -257,16 +290,16 @@
 				get_page(ptepage);
 				dst->rss++;
 
-cont_copy_pte_range:		set_pte(dst_pte, pte);
+cont_copy_pte_range:		set_pte(dst_ptb, pte);
 cont_copy_pte_range_noset:	address += PAGE_SIZE;
 				if (address >= end)
 					goto out_unlock;
-				src_pte++;
-				dst_pte++;
-			} while ((unsigned long)src_pte & PTE_TABLE_MASK);
+				src_ptb++;
+				dst_ptb++;
+			} while ((unsigned) src_ptb & PTE_TABLE_MASK);
 			spin_unlock(&src->page_table_lock);
-		
-cont_copy_pmd_range:	src_pmd++;
+
+cont_pmd_range:		src_pmd++;
 			dst_pmd++;
 		} while ((unsigned long)src_pmd & PMD_TABLE_MASK);
 	}
@@ -302,7 +335,17 @@
 		pmd_clear(pmd);
 		return 0;
 	}
+
 	ptep = pte_offset(pmd, address);
+
+	if (page_count(virt_to_page(ptep)) > 1) {
+		if (current->uid == 9999) printk(">>> zap table!!! %p (%i)\n",
+			ptep, page_count(virt_to_page(ptep)));
+		pmd_clear(pmd);
+		put_page(virt_to_page(ptep));
+		return 0;
+	}
+
 	offset = address & ~PMD_MASK;
 	if (offset + size > PMD_SIZE)
 		size = PMD_SIZE - offset;
@@ -346,12 +389,30 @@
 	freed = 0;
 	do {
 		freed += zap_pte_range(tlb, pmd, address, end - address);
-		address = (address + PMD_SIZE) & PMD_MASK; 
+		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address < end);
 	return freed;
 }
 
+static int unshare_partial(struct mm_struct *mm, pgd_t *dir, unsigned long address)
+{
+	if ((address & PMD_MASK)) {
+		address &= PMD_MASK;
+		if (!pgd_none(*dir)) {
+			pmd_t *pmd = pmd_offset(dir, address);
+			if (!pmd_none(*pmd)) {
+				pte_t *ptb = pte_offset(pmd, address);
+				if (page_count(virt_to_page(ptb)) > 1) {
+					__pte_alloc(mm, pmd, address, 1);
+					return 1;
+				}
+			}
+		}
+	}
+	return 0;
+}
+
 /*
  * remove user pages in a given range.
  */
@@ -361,6 +422,7 @@
 	pgd_t * dir;
 	unsigned long start = address, end = address + size;
 	int freed = 0;
+	if (current->uid == 9999) printk(">>> zap_page_range %lx+%lx\n", address, size);
 
 	dir = pgd_offset(mm, address);
 
@@ -374,6 +436,14 @@
 	if (address >= end)
 		BUG();
 	spin_lock(&mm->page_table_lock);
+
+	/*
+	 * Ensure first and last partial page tables are unshared
+	 */
+	do {
+		unshare_partial(mm, dir, address);
+	} while (unshare_partial(mm, pgd_offset(mm, end & PMD_MASK), end));
+
 	flush_cache_range(mm, address, end);
 	tlb = tlb_gather_mmu(mm);
 
@@ -1348,7 +1418,8 @@
 	pmd = pmd_alloc(mm, pgd, address);
 
 	if (pmd) {
-		pte_t * pte = pte_alloc(mm, pmd, address);
+		pte_t *pte = __pte_alloc(mm, pmd, address,
+			write_access /*&& !(vma->vm_flags & VM_SHARED)*/);
 		if (pte)
 			return handle_pte_fault(mm, vma, address, write_access, pte);
 	}
@@ -1398,28 +1469,50 @@
  * We've already handled the fast-path in-line, and we own the
  * page table lock.
  */
-pte_t *pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
+pte_t *__pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address, int write)
 {
-	if (pmd_none(*pmd)) {
-		pte_t *new;
-
-		/* "fast" allocation can happen without dropping the lock.. */
-		new = pte_alloc_one_fast(mm, address);
+	if (pmd_none(*pmd) || (write && page_count(virt_to_page(pmd_page(*pmd))) > 1)) {
+		pte_t *new = pte_alloc_one_fast(mm, address);
 		if (!new) {
 			spin_unlock(&mm->page_table_lock);
 			new = pte_alloc_one(mm, address);
 			spin_lock(&mm->page_table_lock);
 			if (!new)
 				return NULL;
-
-			/*
-			 * Because we dropped the lock, we should re-check the
-			 * entry, as somebody else could have populated it..
-			 */
-			if (!pmd_none(*pmd)) {
+			/* Recheck in case populated while unlocked */
+			if (!pmd_none(*pmd) && !(write && page_count(virt_to_page(pmd_page(*pmd))) > 1)) {
 				pte_free(new);
 				goto out;
 			}
+		}
+		if (current->uid == 9999) printk(">>> make page table %p @ %p %s\n", new, address,
+			write == 2? "write fault":
+			write == 1? "unshared":
+			write == 0? "sharable":
+			"bogus");
+		if (!page_count(virt_to_page(new)) == 1) BUG();
+		if (!pmd_none(*pmd)) {
+			pte_t *src_ptb = pte_offset(pmd, 0);
+			pte_t *dst_ptb = new;
+			printk(">>> unshare %p (%i--)\n", *pmd, page_count(virt_to_page(pmd_page(*pmd))));
+			do {
+				pte_t pte = *src_ptb;
+				if (!pte_none(pte)) {
+					if (pte_present(pte)) {
+						struct page *page = pte_page(pte);
+						if (VALID_PAGE(page) && !PageReserved(page)) {
+							get_page(page);
+							pte = pte_mkold(pte_mkclean(pte));
+							mm->rss++;
+						}
+					} else
+						swap_duplicate(pte_to_swp_entry(pte));
+					set_pte(dst_ptb, pte);
+				}
+				src_ptb++;
+				dst_ptb++;
+			} while ((unsigned) dst_ptb & PTE_TABLE_MASK);
+			put_page(virt_to_page(pmd_page(*pmd)));
 		}
 		pmd_populate(mm, pmd, new);
 	}
--- ../uml.2.4.17.clean/mm/mremap.c	Fri Sep 21 05:31:26 2001
+++ ./mm/mremap.c	Thu Feb 14 22:52:24 2002
@@ -92,6 +92,7 @@
 {
 	unsigned long offset = len;
 
+	if (current->uid == 9999) printk(">>> mremap\n");
 	flush_cache_range(mm, old_addr, old_addr + len);
 
 	/*

