Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293055AbSBWAby>; Fri, 22 Feb 2002 19:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293057AbSBWAbi>; Fri, 22 Feb 2002 19:31:38 -0500
Received: from dsl-213-023-039-244.arcor-ip.net ([213.23.39.244]:9864 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S293055AbSBWAbY>;
	Fri, 22 Feb 2002 19:31:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC] Page table sharing
Date: Fri, 22 Feb 2002 06:29:13 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Hugh Dickins <hugh@veritas.com>, <dmccr@us.ibm.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Robert Love <rml@tech9.net>, <mingo@redhat.co>,
        Andrew Morton <akpm@zip.com.au>, <manfred@colorfullife.com>,
        <wli@holomorphy.com>
In-Reply-To: <Pine.LNX.4.33.0202181758260.24597-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0202181758260.24597-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16e8Gf-0005HN-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 19, 2002 03:05 am, Linus Torvalds wrote:
> On Mon, 18 Feb 2002, Rik van Riel wrote:
> >
> > The swapout code can remove a page from the page table
> > while another process is in the process of unsharing
> > the page table.
> 
> Ok, I'll buy that. However, looking at that, the locking is not the real
> issue at all:
> 
> When the swapper does a "ptep_get_and_clear()" on a shared pmd, it will
> end up having to not just synchronize with anybody doing unsharing, it
> will have to flush all the TLB's on all the mm's that might be implicated.
> 
> Which implies that the swapper needs to look up all mm's some way anyway,
> so the locking gets solved that way.
> 
> (Now, that's really pushing the problem somewhere else, and that
> "somewhere else" is actually a whole lot nastier than the original locking
> problem ever was, so I'm not claiming this actually solves anything. I'm
> just saying that the locking isn't the issue, and we actually have some
> quite fundamental problems here..)

Even though I'm quite certain you are right and my locking is way more 
heavyweight that necessary, I'd like to see the heavyweight version running 
reliably before embarking on a more extensive rearrangement of the code.  So 
for today I've just added exclusion on the swap out/in paths, and for tlb 
invalidation I'm just doing a global invalidate.  On my two-way machine it 
makes no detectable difference for the relatively lightweight tests I'm
doing now, but granted, somebody is sure to come up with a demonstration that
does show a difference.

This patch isn't stable, though it seems very close.  Since I have very 
limited time for hacking on it I'm posting it now the hopes that more 
eyeballs will help speed things up.  I'm guessing there's a stupid mistake 
and not some fundamental oversight, and I haven't noticed it because I 
haven't gone over it with a fine-toothed comb.

Here's the style of protection I've used against swap in/out:

	if (page_count(virt_to_page(pte)) == 1) {
		entry = pte_mkyoung(entry);
		establish_pte(vma, address, pte, entry);
	} else {
		spin_lock(&page_table_share_lock);
		entry = pte_mkyoung(entry);
		establish_pte(vma, address, pte, entry);
		spin_unlock(&page_table_share_lock);
	}

Totally crude.  The tlb flushing is equally crude:

	if (page_count(virt_to_page(page_table)) == 1) {
		flush_cache_page(vma, address);
		pte = ptep_get_and_clear(page_table);
		flush_tlb_page(vma, address);
	} else {
		spin_lock(&page_table_share_lock);
		flush_cache_all();
		pte = ptep_get_and_clear(page_table);
		flush_tlb_all();
		spin_unlock(&page_table_share_lock);
	}

I know, yuck, but I want to kill the remaining bugs, not make it faster just 
now (it's still running more that 2X faster than the good old fork for fork 
from parent with large vm).

Here is code to demonstrate the problem:

---------------------
useradd -u 9999 new

cat >testnew << END
echo \$1 forks from parent with \$2 pages of mapped memory...
echo -n "New "; sudo -u new ./forktime -n \$1 -m \$2
END

cat >watchnew << END
watch "sh tesnew 10 100000; cat /proc/meminfo"
END

sh watchnew
---------------------

9999 is the magic uid for which page table sharing is enabled.  Run this
and watch free get eaten away.  Things do seem to stabilize eventually,
but it's very definitely not the same behavior as with the following:

---------------------
useradd -u 8888 old

cat >testold << END
echo \$1 forks from parent with \$2 pages of mapped memory...
echo -n "Old "; sudo -u old ./forktime -n \$1 -m \$2
END

cat >watchold << END
watch "sh testold 10 100000; cat /proc/meminfo"
END

sh watchold
---------------------

Which does the same thing with a non-magic user.

Here is 'forktime.c':

---------------------
/*
 *  Time fork() system call.
 *
 * Original by Dave McCracken
 * Reformat by Daniel Phillips
 */

#include <stdio.h>
#include <sys/time.h>
#include <sys/mman.h>

int main(int argc, char *argv[])
{
	int n=1, m=1, i, pagesize = getpagesize();
	struct timeval stime, etime, rtime;
	extern char *optarg;
	char *mem;

args:	switch (getopt(argc, argv, "n:m:")) {
	case 'n':
		n = atoi(optarg);
		goto args;
	case 'm':
		m = atoi(optarg);
		goto args;
	case -1:
		break;
	default:
		fprintf(stderr, "Usage: %s [-n iterations] [-m mappedpages]\n", argv[0]);
		exit(1);
	}

	mem = mmap(NULL, m * pagesize, PROT_READ|PROT_WRITE, MAP_PRIVATE | MAP_ANON, 0, 0);

	for (i = 0; i < m; i++)
		mem[i * pagesize] = 0;

	gettimeofday (&stime, NULL);

	for (i = 0; i < n; i++)
		switch (fork()) {
			case 0: exit(0);
			case -1: exit(2);
		}

	wait();
	gettimeofday(&etime, NULL);
	timersub(&etime, &stime, &rtime);
	printf("total fork time: %d.%06d seconds in %d iterations ", rtime.tv_sec, rtime.tv_usec, i);
	printf("(%d usec/fork)\n", ((rtime.tv_sec * 1000000) + rtime.tv_usec) / i);
	exit(0);
}
---------------------

The following patch (-p0 against 2.4.17) is also available at:

  nl.linux.org/~phillips/ptab-2.4.17-3

--
Daniel

--- ../2.4.17.clean/fs/exec.c	Fri Dec 21 12:41:55 2001
+++ ./fs/exec.c	Mon Feb 18 22:57:10 2002
@@ -860,6 +860,7 @@
 	int retval;
 	int i;
 
+	ptab(printk(">>> execve %s\n", filename));
 	file = open_exec(filename);
 
 	retval = PTR_ERR(file);
--- ../2.4.17.clean/include/linux/mm.h	Fri Dec 21 12:42:03 2001
+++ ./include/linux/mm.h	Fri Feb 22 20:23:17 2002
@@ -411,7 +411,7 @@
 
 extern int vmtruncate(struct inode * inode, loff_t offset);
 extern pmd_t *FASTCALL(__pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address));
-extern pte_t *FASTCALL(pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
+extern pte_t *FASTCALL(__pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address, int write));
 extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
 extern int make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
@@ -424,6 +424,19 @@
 
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
 		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);
+
+static inline pte_t *pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
+{
+	return __pte_alloc(mm, pmd, address, 1);
+}
+
+#define nil do { } while (0)
+#define ptab_off(cmd) nil
+#define ptab_on(cmd) do { if (current->flags & PF_SHARE_TABLES) cmd; } while (0)
+#define ptab ptab_off
+#define always_share_page_tables 1
+
+extern spinlock_t page_table_share_lock;
 
 /*
  * On a two-level page table, this ends up being trivial. Thus the
--- ../2.4.17.clean/include/linux/sched.h	Fri Dec 21 12:42:03 2001
+++ ./include/linux/sched.h	Mon Feb 18 22:57:10 2002
@@ -427,7 +427,7 @@
 #define PF_MEMDIE	0x00001000	/* Killed for out-of-memory */
 #define PF_FREE_PAGES	0x00002000	/* per process page freeing */
 #define PF_NOIO		0x00004000	/* avoid generating further I/O */
-
+#define PF_SHARE_TABLES 0x00008000    /* share page tables (testing) */
 #define PF_USEDFPU	0x00100000	/* task used FPU this quantum (SMP) */
 
 /*
--- ../2.4.17.clean/kernel/fork.c	Wed Nov 21 13:18:42 2001
+++ ./kernel/fork.c	Mon Feb 18 22:57:10 2002
@@ -140,6 +140,7 @@
 	mm->swap_address = 0;
 	pprev = &mm->mmap;
 
+	ptab(printk(">>> dup_mmap\n"));
 	/*
 	 * Add it to the mmlist after the parent.
 	 * Doing it this way means that we can order the list,
@@ -566,9 +567,10 @@
 	struct task_struct *p;
 	struct completion vfork;
 
+	ptab(printk(">>> fork, stack=%lx\n", stack_start));
 	retval = -EPERM;
 
-	/* 
+	/*
 	 * CLONE_PID is only allowed for the initial SMP swapper
 	 * calls
 	 */
--- ../2.4.17.clean/kernel/sys.c	Tue Sep 18 17:10:43 2001
+++ ./kernel/sys.c	Mon Feb 18 22:57:10 2002
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
 
--- ../2.4.17.clean/mm/memory.c	Fri Dec 21 12:42:05 2001
+++ ./mm/memory.c	Fri Feb 22 22:19:43 2002
@@ -34,6 +34,9 @@
  *
  * 16.07.99  -  Support of BIGMEM added by Gerhard Wichert, Siemens AG
  *		(Gerhard.Wichert@pdb.siemens.de)
+ *
+ * Feb 2002  -  Shared page tables added by Daniel Phillips
+ *		(phillips@nl.linux.org)
  */
 
 #include <linux/mm.h>
@@ -49,6 +52,8 @@
 #include <asm/uaccess.h>
 #include <asm/tlb.h>
 
+#define assert(cond) do { if (!(cond)) BUG(); } while (0)
+
 unsigned long max_mapnr;
 unsigned long num_physpages;
 void * high_memory;
@@ -100,10 +105,18 @@
 		return;
 	}
 	pte = pte_offset(dir, 0);
-	pmd_clear(dir);
-	pte_free(pte);
+	ptab(printk(">>> free page table %p (%i--)\n", pte, page_count(virt_to_page(pte))));
+	
+	spin_lock(&page_table_share_lock);
+	if (page_count(virt_to_page(pte)) == 1) {
+		put_page(virt_to_page(pte));
+		pmd_clear(dir);
+		pte_free_slow(pte);
+	}
+	spin_unlock(&page_table_share_lock);
 }
 
+
 static inline void free_one_pgd(pgd_t * dir)
 {
 	int j;
@@ -143,8 +156,8 @@
  */
 void clear_page_tables(struct mm_struct *mm, unsigned long first, int nr)
 {
-	pgd_t * page_dir = mm->pgd;
-
+	pgd_t *page_dir = mm->pgd;
+	ptab(printk(">>> clear_page_tables\n"));
 	spin_lock(&mm->page_table_lock);
 	page_dir += first;
 	do {
@@ -171,13 +184,23 @@
  * dst->page_table_lock is held on entry and exit,
  * but may be dropped within pmd_alloc() and pte_alloc().
  */
-int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
-			struct vm_area_struct *vma)
+spinlock_t page_table_share_lock = SPIN_LOCK_UNLOCKED;
+
+int copy_page_range(struct mm_struct *dst, struct mm_struct *src, struct vm_area_struct *vma)
 {
-	pgd_t * src_pgd, * dst_pgd;
+	pgd_t *src_pgd, *dst_pgd;
 	unsigned long address = vma->vm_start;
 	unsigned long end = vma->vm_end;
 	unsigned long cow = (vma->vm_flags & (VM_SHARED | VM_WRITE)) == VM_WRITE;
+	int share_page_tables = always_share_page_tables || !!(current->flags & PF_SHARE_TABLES);
+
+#if 0
+	static int teststart = 2, testcount = 99, tests = 0;
+	if (share_page_tables && (tests++ < teststart || tests > teststart + testcount))
+		share_page_tables = 0;
+	if (share_page_tables)
+		printk(">>> copy_page_range test %i\n", tests - 1);
+#endif
 
 	src_pgd = pgd_offset(src, address)-1;
 	dst_pgd = pgd_offset(dst, address)-1;
@@ -186,15 +209,15 @@
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
@@ -204,34 +227,58 @@
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
+				spin_lock(&src->page_table_lock);
+				get_page(virt_to_page(src_ptb));
+				pmd_populate(dst, dst_pmd, ((ulong) src_ptb & PAGE_MASK));
+				ptab(printk(">>> share %p @ %p (++%i)\n", src_ptb, address, page_count(virt_to_page(src_ptb))));
+				goto share;
+			}
+			if ((pmd_val(*src_pmd) & PAGE_MASK) != ((pmd_val(*dst_pmd) & PAGE_MASK)))
+				goto no_share;
+			spin_lock(&src->page_table_lock);
+share:
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
+			} while ((ulong) src_ptb & PTE_TABLE_MASK);
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
@@ -240,14 +287,14 @@
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
@@ -257,16 +304,16 @@
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
+			} while ((ulong) src_ptb & PTE_TABLE_MASK);
 			spin_unlock(&src->page_table_lock);
-		
-cont_copy_pmd_range:	src_pmd++;
+
+cont_pmd_range:		src_pmd++;
 			dst_pmd++;
 		} while ((unsigned long)src_pmd & PMD_TABLE_MASK);
 	}
@@ -288,7 +335,6 @@
 		BUG();
 	}
 }
-
 static inline int zap_pte_range(mmu_gather_t *tlb, pmd_t * pmd, unsigned long address, unsigned long size)
 {
 	unsigned long offset;
@@ -299,10 +345,21 @@
 		return 0;
 	if (pmd_bad(*pmd)) {
 		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
+		pmd_clear(pmd);	
 		return 0;
 	}
+
 	ptep = pte_offset(pmd, address);
+
+	spin_lock(&page_table_share_lock);
+	if (page_count(virt_to_page(ptep)) > 1) {
+		ptab(printk(">>> zap table!!! %p (%i)\n", ptep, page_count(virt_to_page(ptep))));
+		tlb_remove_page(tlb, (pte_t *) pmd, pmd_val(*pmd));
+		spin_unlock(&page_table_share_lock);
+		return 0;
+	}
+	spin_unlock(&page_table_share_lock);
+
 	offset = address & ~PMD_MASK;
 	if (offset + size > PMD_SIZE)
 		size = PMD_SIZE - offset;
@@ -352,6 +409,24 @@
 	return freed;
 }
 
+static int unshare_one(struct mm_struct *mm, pgd_t *dir, unsigned long address)
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
@@ -374,6 +449,14 @@
 	if (address >= end)
 		BUG();
 	spin_lock(&mm->page_table_lock);
+
+	/*
+	 * Ensure first and last partial page tables are unshared
+	 */
+	do {
+		unshare_one(mm, dir, address);
+	} while (unshare_one(mm, pgd_offset(mm, end & PMD_MASK), end));
+
 	flush_cache_range(mm, address, end);
 	tlb = tlb_gather_mmu(mm);
 
@@ -517,7 +600,7 @@
 
 	mm = current->mm;
 	dprintk ("map_user_kiobuf: begin\n");
-	
+		
 	pgcount = (va + len + PAGE_SIZE - 1)/PAGE_SIZE - va/PAGE_SIZE;
 	/* mapping 0 bytes is not permitted */
 	if (!pgcount) BUG();
@@ -1317,13 +1400,28 @@
 	}
 
 	if (write_access) {
-		if (!pte_write(entry))
-			return do_wp_page(mm, vma, address, pte, entry);
-
+		if (!pte_write(entry)) {
+			if (page_count(virt_to_page(pte)) == 1) {
+				return do_wp_page(mm, vma, address, pte, entry);
+			} else {
+				int err;
+				spin_lock(&page_table_share_lock);
+				err = do_wp_page(mm, vma, address, pte, entry);
+				spin_unlock(&page_table_share_lock);
+				return err;
+			}
+		}
 		entry = pte_mkdirty(entry);
 	}
-	entry = pte_mkyoung(entry);
-	establish_pte(vma, address, pte, entry);
+	if (page_count(virt_to_page(pte)) == 1) {
+		entry = pte_mkyoung(entry);
+		establish_pte(vma, address, pte, entry);
+	} else {
+		spin_lock(&page_table_share_lock);
+		entry = pte_mkyoung(entry);
+		establish_pte(vma, address, pte, entry);
+		spin_unlock(&page_table_share_lock);
+	}
 	spin_unlock(&mm->page_table_lock);
 	return 1;
 }
@@ -1398,33 +1496,73 @@
  * We've already handled the fast-path in-line, and we own the
  * page table lock.
  */
-pte_t *pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
+pte_t *__pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address, int unshare)
 {
-	if (pmd_none(*pmd)) {
-		pte_t *new;
+	struct page *ptb_page;
+	pte_t *new, *src_ptb, *dst_ptb;
 
-		/* "fast" allocation can happen without dropping the lock.. */
-		new = pte_alloc_one_fast(mm, address);
-		if (!new) {
-			spin_unlock(&mm->page_table_lock);
-			new = pte_alloc_one(mm, address);
-			spin_lock(&mm->page_table_lock);
-			if (!new)
-				return NULL;
+	if (pmd_none(*pmd)) {
+		spin_unlock(&mm->page_table_lock);
+		new = pte_alloc_one(mm, address);
+		spin_lock(&mm->page_table_lock);
+		if (!new) return NULL;
 
-			/*
-			 * Because we dropped the lock, we should re-check the
-			 * entry, as somebody else could have populated it..
-			 */
-			if (!pmd_none(*pmd)) {
-				pte_free(new);
-				goto out;
-			}
-		}
+		/* Populated while unlocked? */
+		if (!pmd_none(*pmd))
+			goto unshared_free;
 		pmd_populate(mm, pmd, new);
+unshared:	return pte_offset(pmd, address);
 	}
-out:
-	return pte_offset(pmd, address);
+	if (!unshare || page_count(virt_to_page(pmd_page(*pmd))) == 1)
+		goto unshared;
+	spin_unlock(&mm->page_table_lock);
+	new = pte_alloc_one(mm, address);
+	spin_lock(&mm->page_table_lock);
+	if (!new) return NULL;
+
+	assert(page_count(virt_to_page(new)) == 1);
+	spin_lock(&page_table_share_lock);
+	ptb_page = virt_to_page(pmd_page(*pmd));
+	if (page_count(ptb_page) == 1)
+		goto unshared_unlock;
+
+	ptab(printk(">>> make page table %p @ %p %s\n", new, address,
+		unshare == 2? "write fault":
+		unshare == 1? "unshared":
+		"bogus"));
+
+	src_ptb = pte_offset(pmd, 0);
+	dst_ptb = new;
+	ptab(printk(">>> unshare %p (%i--)\n", *pmd, page_count(ptb_page)));
+	// assert(ptb_page->flags & PG_shared_debug);
+	do {
+		pte_t pte = *src_ptb;
+		if (!pte_none(pte)) {
+			if (pte_present(pte)) {
+				struct page *page = pte_page(pte);
+				if (VALID_PAGE(page) && !PageReserved(page)) {
+					get_page(page);
+					pte = pte_mkold(pte_mkclean(pte));
+					mm->rss++;
+				}
+			} else
+				swap_duplicate(pte_to_swp_entry(pte));
+			set_pte(dst_ptb, pte);
+		}
+		src_ptb++;
+		dst_ptb++;
+	} while ((ulong) dst_ptb & PTE_TABLE_MASK);
+	pmd_populate(mm, pmd, new);
+	put_page(ptb_page);
+	spin_unlock(&page_table_share_lock);
+	goto unshared;
+
+unshared_unlock:
+	get_page(ptb_page);
+	spin_unlock(&page_table_share_lock);
+unshared_free:
+	pte_free_slow(new);
+        goto unshared;
 }
 
 int make_pages_present(unsigned long addr, unsigned long end)
--- ../2.4.17.clean/mm/mremap.c	Thu Sep 20 23:31:26 2001
+++ ./mm/mremap.c	Mon Feb 18 22:57:54 2002
@@ -92,6 +92,7 @@
 {
 	unsigned long offset = len;
 
+	ptab(printk(">>> mremap\n"));
 	flush_cache_range(mm, old_addr, old_addr + len);
 
 	/*
--- ../2.4.17.clean/mm/vmscan.c	Fri Dec 21 12:42:05 2001
+++ ./mm/vmscan.c	Fri Feb 22 16:05:29 2002
@@ -69,9 +69,17 @@
 	 * is needed on CPUs which update the accessed and dirty
 	 * bits in hardware.
 	 */
-	flush_cache_page(vma, address);
-	pte = ptep_get_and_clear(page_table);
-	flush_tlb_page(vma, address);
+	if (page_count(virt_to_page(page_table)) == 1) {
+		flush_cache_page(vma, address);
+		pte = ptep_get_and_clear(page_table);
+		flush_tlb_page(vma, address);
+	} else {
+		spin_lock(&page_table_share_lock);
+		flush_cache_all();
+		pte = ptep_get_and_clear(page_table);
+		flush_tlb_all();
+		spin_unlock(&page_table_share_lock);
+	}
 
 	if (pte_dirty(pte))
 		set_page_dirty(page);

