Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291335AbSBMEDJ>; Tue, 12 Feb 2002 23:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291340AbSBMEC4>; Tue, 12 Feb 2002 23:02:56 -0500
Received: from dsl-213-023-043-038.arcor-ip.net ([213.23.43.38]:54406 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291335AbSBMECd>;
	Tue, 12 Feb 2002 23:02:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
Date: Wed, 13 Feb 2002 05:07:15 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: wli@holomorphy.com, dmccr@us.ibm.com, oxymoron@waste.org,
        Momchil Velikov <velco@fadata.bg>, Uli Luckas <uluckas@web.de>,
        Daniel Mack <daniel@yoobay.net>, riel@surriel.com
Subject: [RFC] [WIP] Shared page tables, first results
Message-Id: <E16aqhP-0001ls-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today I have the first concrete results of an effort that began six weeks
ago around Christmas, namely some working code that implements page table 
sharing.  This has been a rather grinding, difficult piece of code to 
develop, especially as I did not really have a clue how Linux page tables
worked when I started on it.  However, in spite of that - or perhaps because 
of that - this code seems to be heading in the right direction.  According to 
a report I received from Dave McCracken, we are already seeing some dramatic
speedups in certain test cases.

The patch as attached is far from finished, but it does work for the cases 
I've tried.  I hope to be lazy about further development and do most of the
rest of it in response to feedback, especially in the area of locking, and
in auiditing for corner cases.  For example, nobody has audited the swap
paths yet, or tried it to see if it works.

Page table sharing
------------------

(The algorithm formerly known as 'lazy page table instantiation')

This algorithm implements page table sharing between page directories, with
a view to reducing the amount of work required at fork time for a child to
inherit its parent's memory.  With this algorithm, only a single page (the
page directory) is copied at fork time.

This work is aimed at making Rik van Riel's rmap design practical, i.e., by 
eliminating the current high cost of creating potentially millions of 
pte_chain list nodes at fork time.  However, the usefulness of this approach 
is not limited to rmap - it should speed up fork in the current non-rmap vm 
as well.

The algorithm relies on a page table's use count, which specifies how many 
page directories point to it.  A page table can be shared by several page 
directories until one of its non-shared pages is written.  Then the page and 
its page table are unshared, i.e., a private copy of the page is entered into 
a private copy of the page table (and, for rmap, the page's pte_chain is 
extended).

In this way, instantiation of page tables does not happen at fork time, but
later, when pages referenced by page tables are privatized.  Furthermore,
page tables are instantiated only when they need to be, as opposed to the 
current method, which instantiates all page tables at fork time.

Algorithm
---------

On fork:
  - Copy the page directory to the child
  - For each of the page directory's page tables with use count of one, write 
    protect its CoW pages
  - Increment the use count of each page table in the page directory

On write to a CoW page:
  - If the page table has use count greater than one, make a private copy 
    of the page table.

  - For rmap, at this time, extend all the pte_chains to include the 
    privatized page table.  Reduce the use count on the original page table 
    by one and set the use count of the new page table to one.

On process termination:
  - Decrement the use counts on all page tables mapped by the page directory;
    free those with zero use count.

Implementation
--------------

The implementation turned out to follow the generically stated algorithm
quite closely.  The areas affected are:

  copy_page_tables ... implements the fork part of the algorithm, and also
  preserves the traditional behavior as an optional code path

  __pte_alloc ... implements the fault part of the algorithm, and also
  handles non-fault modifications to page tables, such as mremap.  This
  is based on the original (misnamed) pte_alloc, and takes an additional
  parameter to indicate whether shared page tables are to be unshared
  because of pending modification.

  clear_page_tables ... implements the process termination part of the
  algorithm

  zap_page_tables ... special treatment is required here (not anticipated in
  the original algorithm) to handle the case where a shared page table is
  modified by unmapping - one of the few places where page tables are
  modified with a preceding pte_alloc.

Note: The most difficult thing to get right in this patch is the accurate
maintainance of page use counts.  We want to preserve *exactly* the same
semantics with shared page tables as with copied page tables.  In the end,
all the accounts have to balance.  So when reading the patch, please look
especially critically at this aspect of it.

Current Status
--------------

Today I managed to convince a forked child share its page tables with its 
parent and live to tell the tale.  This is as good a time as any to publish 
the code, even though it's not finished.  For one thing, the page table 
sharing is restricted to processes of a single, test user - nobody has tried 
to boot a whole system with page table sharing yet, and I seriously doubt it 
would run very long.  So far, I have not written any test programs to 
exercise any corner cases.  Instead I have just worked with one common case: 
fork, immediately followed by execve, the normal way commands are launched 
from a shell.

The biggest omission in the patch as it now stands is locking - there isn't 
any.  I feel that this is something that's suitable for group development, as 
opposed to the initial design and coding, which I pretty much had to do 
myself, as I seemed to be the only one who really knew what I had in mind.

One outstanding problem, pointed out by Dave McCracken earlier today, is that 
zap_page_range forces all shared page tables to be instantiated in order to 
unmap their pages, typically on exit.  This seems wrong and distasteful, and 
is something that needs to be looked at.  Dave suggested treating the case of 
unmap-on-exit specially, since the page tables will never be used again.  I 
think there is merit in that idea.

How far are we from a usable patch?  Probably, not that far.  However, I will 
not be working on this quite so intensively from now on, as I believe the 
principle is now demonstrated, and that was the real urgency.  Over the next 
few months this should develop into something practical.

Possible Further Optimizations
------------------------------

- It's very tempting to look at the possibility of incrementing page use 
counts at fault time instead of at fork time.  Using this strategy, each use 
count greater than one on a page table would be interpreted as standing for a 
use count on every page on the page table.  The use counts of a shared page 
tables pages would be incremented only when it is unshared.  With this 
strategy, page unmapping can be performed 4 MB at a time just by unmapping
a page table and decrementing its use count.  However, partially unmapped 
page tables will need special treatment, and there is enough complexity there 
that for the time being such work will be deferred.

- As currently implemented, the work performed at fault time very closely 
resembles a straight memcpy of the page table.  With rmap, it may be possible 
to turn that into a real memcpy, since with rmap we do not have to set a copy 
of a dirty pte clean, nor is it particularly important to set the referenced 
bit on a pte.

- Shared page tables could be set RO, then the test for shared page tables 
inside __pte_alloc could be eliminated.  Though a fault is expensive in 
comparison to a test, there could be up to 1024 such tests if every page on 
the page table had a CoW fault, and that makes it a close race.  (Thanks to 
Uli Luckas for pointing this out.)

- Another reason for setting a page table RO, as pointed out earlier by Linus 
and Oliver Oxymoron, is that the rest of the work now performed in fork can 
be deferred to fault time, perhaps avoiding some of it entirely.  However, so 
far, in my tests I see only three page tables being inherited on each fork, 
so it seems unlikely that this would have much of an effect on the common 
case.  Further testing may turn up some interesting special cases.

- Suparna pointed out that these techniques may be applicable to mmaped 
shares, as opposed to sharing through fork inheritance, as implemented here.  
This is indeed possible, though trickier than it sounds at first blush, since 
the determination of which page tables can and cannot be shared gets quite 
complex.  Also, this is unrelated to fixing performance problems with rmap, 
which is my current purpose.  If nobody else looks into this possibility by 
the end of the year, then perhaps I will, but there does not seem to be any 
great urgency.

The Patch
---------

I dithered for some time on  whether to cut down my patch to its minimum 
elements and just focus on the algorithm, or to post the whole thing, 
complete with my test harness, so people have something useful to play with 
and develop with.  In the end I decided to do both: post the minimal patch on 
lkml, and post the full thing complete with the debugging code on my home 
page at nl.linux.org.  However, lack of sleep got the better of me: I've 
taken the route of least resistance and am posting my development code, as 
is.  The interesting parts are the ones with lots of +'s ;-)

To reduce the pain of debugging this, I restricted the use of shared page 
tables to processes running under the user with 'magic' uid of 9999.  Thanks 
to Andrew Morton for this useful suggestion.

There is a very useful piece of testing harness embedded in the patch, the 
'teststart/testcount' mechanism, which allows page table sharing to be 
restricted to just a certain range of calls to copy_page_tables.  Without 
this isolation I would have had a very difficult time indeed tracking up the 
problems that did come up, and there were some nasty ones.

So now on to actually running the code.  Here's how to reproduce my test run:

  - compile 2.4.17 + uml + this patch
  - boot uml in single user mode
  - useradd test -u 9999 # uid=9999 is the magic debug user
  - su test
  - id # or any other simple command

This causes a fork from test's shell, and the new process will (briefly)
share up to 3 page tables from the shell, before it execve's and frees
them again.  Before the page tables get freed, it happens that a CoW write
fault comes along some page owned by each of the three page tables, and
each one is unshared.  So by the time the page tables are freed, none of
them is shared and we don't get to test the code path in clear_page_tables.

The following results:

daniel@starship:/src/uml.2.4.17$ linux single
usermode:~# su test
usermode:/root$ id
>>> fork, stack=0
>>> dup_mmap
>>> copy_page_range test 0
>>> share a235e120 @ 08048000 (2)
>>> share a2335000 @ 40000000 (2)
>>> share a236dfec @ 9fffb000 (2)
>>> make page table a22f9000 @ 080b2878 write fault
>>> unshare a235e06d (2--)
>>> make page table a22f7000 @ 9ffffa88 write fault
>>> unshare a236d06d (2--)
>>> make page table a22f5000 @ 40013054 write fault
>>> unshare a233506d (2--)
>>> execve /usr/bin/id
>>> clear_page_tables
>>> free page table a235e000 (1)
>>> free page table a2335000 (1)
>>> free page table a236d000 (1)
>>> make page table a2325000 @ 9ffff000 unshared
>>> make page table a27b5000 @ 40012c58 write fault
>>> make page table a2308000 @ 0804b0c0 write fault
uid=9999(test) gid=100(users) groups=100(users)
>>> clear_page_tables
>>> free page table a2308000 (1)
>>> free page table a27b5000 (1)
>>> free page table a2325000 (1)

The debugging output generally shows the page table address, the address that
triggered an operation on it (nnnnnn @ nnnnnn) and the share count of the page
table - in the case of adding a share, the resulting count, and in the case of
removing a share, the prior count.  For clarity, the unshare-on-fault is shown
as (n--).

Unsharing is implemented inside the (misnamed) page table creation routine 
pte_alloc, since that is always called on any path that could cause a write
to a page table.  You can see from the above trace that three successive 
write faults cause the three share page tables to be unshared.  In fact,
those are not the only write faults, they're just the ones that cause a page
table to be allocated.  There are many more write faults on other CoW pages
on those tables, and if the unshare were not done properly they would not
work very well at all (and didn't, when I tested the early version of the 
patch that had the sharing but not the unsharing+CoW setup).

All the action is over by the time the first three shared tables are freed,
which happens as part of the immediately following execve, which has no
chance to share anything.

To apply the patch:

    cd /your/uml/source/tree
    patch -p0 <this.patch

Warning: this is very much a development patch, do not expect stability.
Hard core hackers only, please :-)

--
Daniel

--- ../uml.2.4.17.clean/fs/exec.c	Fri Dec 21 18:41:55 2001
+++ ./fs/exec.c	Tue Feb 12 17:25:27 2002
@@ -860,6 +860,7 @@
 	int retval;
 	int i;
 
+	if (current->uid == 9999) printk(">>> execve %s\n", filename);
 	file = open_exec(filename);
 
 	retval = PTR_ERR(file);
--- ../uml.2.4.17.clean/include/linux/mm.h	Fri Dec 21 18:42:03 2001
+++ ./include/linux/mm.h	Tue Feb 12 17:25:28 2002
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
+++ ./include/linux/sched.h	Tue Feb 12 17:25:28 2002
@@ -427,7 +427,7 @@
 #define PF_MEMDIE	0x00001000	/* Killed for out-of-memory */
 #define PF_FREE_PAGES	0x00002000	/* per process page freeing */
 #define PF_NOIO		0x00004000	/* avoid generating further I/O */
-
+#define PF_SHARE_TABLES 0x00008000    /* share page tables (testing) */
 #define PF_USEDFPU	0x00100000	/* task used FPU this quantum (SMP) */
 
 /*
--- ../uml.2.4.17.clean/kernel/fork.c	Wed Nov 21 19:18:42 2001
+++ ./kernel/fork.c	Tue Feb 12 17:25:28 2002
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
+++ ./kernel/sys.c	Tue Feb 12 17:25:28 2002
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
+++ ./mm/memory.c	Wed Feb 13 02:46:20 2002
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
@@ -204,34 +215,63 @@
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
+			} else if (page_count(virt_to_page(src_ptb)) == 1)
+				goto no_share;
+
+			spin_lock(&src->page_table_lock);
+			do {
+				pte_t pte = *src_ptb;
+				if (!pte_none(pte)) {
+					if (pte_present(pte)) {
+						struct page *page = pte_page(pte);
+						if (VALID_PAGE(page) && !PageReserved(page)) {
+							get_page(page);
+							if (cow)
+								ptep_set_wrprotect(src_ptb);
+							dst->rss++;
+						}
+					} else
+						swap_duplicate(pte_to_swp_entry(pte));
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
@@ -240,14 +280,14 @@
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
@@ -257,16 +297,16 @@
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
@@ -302,6 +342,14 @@
 		pmd_clear(pmd);
 		return 0;
 	}
+
+	/* Crude hack follows to ensure ptb unshared before unmap */
+#ifdef CONFIG_SMP
+	__pte_alloc(tlb->mm, pmd, address, 1); // an awkward arrangement indeed
+#else
+	__pte_alloc(tlb, pmd, address, 1);
+#endif
+
 	ptep = pte_offset(pmd, address);
 	offset = address & ~PMD_MASK;
 	if (offset + size > PMD_SIZE)
@@ -346,7 +394,7 @@
 	freed = 0;
 	do {
 		freed += zap_pte_range(tlb, pmd, address, end - address);
-		address = (address + PMD_SIZE) & PMD_MASK; 
+		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address < end);
 	return freed;
@@ -361,6 +409,7 @@
 	pgd_t * dir;
 	unsigned long start = address, end = address + size;
 	int freed = 0;
+	if (current->uid == 9999) printk(">>> zap_page_range %lx+%lx\n", address, size);
 
 	dir = pgd_offset(mm, address);
 
@@ -1348,7 +1397,8 @@
 	pmd = pmd_alloc(mm, pgd, address);
 
 	if (pmd) {
-		pte_t * pte = pte_alloc(mm, pmd, address);
+		pte_t *pte = __pte_alloc(mm, pmd, address,
+			write_access /*&& !(vma->vm_flags & VM_SHARED)*/);
 		if (pte)
 			return handle_pte_fault(mm, vma, address, write_access, pte);
 	}
@@ -1398,28 +1448,43 @@
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
+					if (pte_present(pte))
+						pte = pte_mkold(pte_mkclean(pte));
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
+++ ./mm/mremap.c	Tue Feb 12 17:25:28 2002
@@ -92,6 +92,7 @@
 {
 	unsigned long offset = len;
 
+	if (current->uid == 9999) printk(">>> mremap\n");
 	flush_cache_range(mm, old_addr, old_addr + len);
 
 	/*
