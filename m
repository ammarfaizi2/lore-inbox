Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316886AbSH3Bx5>; Thu, 29 Aug 2002 21:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319257AbSH3Bx5>; Thu, 29 Aug 2002 21:53:57 -0400
Received: from holomorphy.com ([66.224.33.161]:10374 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316886AbSH3Bxy>;
	Thu, 29 Aug 2002 21:53:54 -0400
Date: Thu, 29 Aug 2002 18:58:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@zip.com.au, riel@surriel.com
Subject: statm_pgd_range() sucks!
Message-ID: <20020830015814.GN18114@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@zip.com.au,
	riel@surriel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I have *had it* with statm_pgd_range()!

So I started up top(1) to monitor a benchmark. And the idiot thing
couldn't get out of the kernel fast enough to refresh the screen every
5s and ate an entire cpu (well, I did have 15 to spare, but still). I
pulled the plug and applied the following, which fixed the situation,
albeit with slight changes to the semantics of what's reported.

(1) shared, lib, text, & total are now reported as what's mapped
	instead of what's resident. This actually fixes two bugs:
	(1A) Misreporting the total size of what's mapped by a task
		when third-level pagetables haven't been instantiated
		for regions (i.e. incorrect VSZ).
	(1B) Misreporting "shared" because elevated reference counts
		do not represent sharing of pages between processes,
		such things as presence on the LRU and buffers foil it.
		shared is now the size of the regions mapped as MAP_SHARED,
		which is different, but at least meaningful.

(2) dirty and reported as 0. It wasn't used by userspace anyway, and
	frankly that information is too expensive to collect at all.

(3) The hardcoded i386 a.out format hack (0x60000000) is removed
	and lib pages reported as 0. This value is not used by
	userspace and has not been reliable or meaningful for some time,
	as library pages have no special meaning to ELF. It can only be
	faithfully reported by means of awareness of both the executable
	format and architectural address space layout.

(4) The horrifically expensive pagetable walk is gone, and so
	/proc/$PID/statm will disturb the system far less in general.
	The reduction in cpu consumption observed was immense.
	B = Before, A = After:

	     PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
	B:  2813 wli       25   0  1624 1624   744 R    99.9  0.0   0:38 top
	A:   259 wli       15   0  2452 1616     0 R     6.1  0.0   3:45 top

	Those cpus are 700MHz P-III Xeons. This efficiency gain is immense.

	Profile of a stock kernel from a UP "desktop" system where I
	continually run top(1) to catch runaway memory consumers:

	Before (running for 20 days or so):
	1492108515	total                               1102.3391
	1340420417	default_idle                    27925425.3542
	  13822366	statm_pgd_range                    29789.5819
	   7922620	number                             11515.4360
	   7052090	handle_IRQ_event                   88151.1250
	   6041850	fget                               94403.9062
	   5077128	__generic_copy_to_user             63464.1000
	   4278107	csum_partial_copy_generic          16711.3555
	   3968287	vsnprintf                           3757.8475
	   3336038	proc_pid_stat                       4255.1505

	After (running for 24 hours or so):
	   9921095	total                                  7.3620
	   9710998	default_idle                      202312.4583
	     20253	number                                18.6149
	     13130	proc_getdata                          23.4464
	     12696	__generic_copy_to_user               158.7000
	      7454	vsnprintf                              7.0587
	      6963	handle_IRQ_event                      72.5312
	      6112	fast_clear_page                       54.5714
	      4568	proc_pid_stat                          6.3444
	      3931	kmem_cache_free                       27.2986


	statm_pgd_range() was eating buttloads of cpu for exactly zero
	gain. Cutting it down to size is worthwhile even for "desktops".
	This UP box is under heavy load with general network I/O,
	serving up nfsroots to ancient NetBSD toasters, Mozilla/GNOME
	gunk, and by some braindeath top(1) manages to dominate the
	profile. It's not difficult to understand that a real-life
	end-user interactive load is being dominated, and perhaps even
	its progress hindered, by the cost of collecting information to
	report to userspace in a grossly inefficient manner. And yes, I
	do need to know what's eating cpu & mem on my box at all times.
	(Before telling me to get more memory, I see enough highmem to
	know I don't want highmem at home, and it's already got 768MB.)

(5) The code fits into 80x24 and is generally easier on the eyes.

(6) Less code:
$ diffstat no_statm_pgd_range-2.5.31-4 
 array.c |  128 ++++++++++------------------------------------------------------
 1 files changed, 21 insertions(+), 107 deletions(-)


Against 2.5.31, applies cleanly to 2.5.32.


Cheers,
Bill


===== fs/proc/array.c 1.26 vs edited =====
--- 1.26/fs/proc/array.c	Wed Jul 24 18:36:09 2002
+++ edited/fs/proc/array.c	Tue Aug 20 09:12:37 2002
@@ -394,120 +394,34 @@
 	return res;
 }
 		
-static inline void statm_pte_range(pmd_t * pmd, unsigned long address, unsigned long size, int * pages, int * shared, int * dirty, int * total)
-{
-	unsigned long end, pmd_end;
-	pte_t *pte;
-
-	if (pmd_none(*pmd))
-		return;
-	if (pmd_bad(*pmd)) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
-		return;
-	}
-	preempt_disable();
-	pte = pte_offset_map(pmd, address);
-	end = address + size;
-	pmd_end = (address + PMD_SIZE) & PMD_MASK;
-	if (end > pmd_end)
-		end = pmd_end;
-	do {
-		pte_t page = *pte;
-		struct page *ptpage;
-		unsigned long pfn;
-
-		address += PAGE_SIZE;
-		pte++;
-		if (pte_none(page))
-			continue;
-		++*total;
-		if (!pte_present(page))
-			continue;
-		pfn = pte_pfn(page);
-		if (!pfn_valid(pfn))
-			continue;
-		ptpage = pfn_to_page(pfn);
-		if (PageReserved(ptpage))
-			continue;
-		++*pages;
-		if (pte_dirty(page))
-			++*dirty;
-		if (page_count(pte_page(page)) > 1)
-			++*shared;
-	} while (address < end);
-	pte_unmap(pte - 1);
-	preempt_enable();
-}
-
-static inline void statm_pmd_range(pgd_t * pgd, unsigned long address, unsigned long size,
-	int * pages, int * shared, int * dirty, int * total)
-{
-	pmd_t * pmd;
-	unsigned long end;
-
-	if (pgd_none(*pgd))
-		return;
-	if (pgd_bad(*pgd)) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
-		return;
-	}
-	pmd = pmd_offset(pgd, address);
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-	do {
-		statm_pte_range(pmd, address, end - address, pages, shared, dirty, total);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address < end);
-}
-
-static void statm_pgd_range(pgd_t * pgd, unsigned long address, unsigned long end,
-	int * pages, int * shared, int * dirty, int * total)
-{
-	while (address < end) {
-		statm_pmd_range(pgd, address, end - address, pages, shared, dirty, total);
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		pgd++;
-	}
-}
-
 int proc_pid_statm(struct task_struct *task, char * buffer)
 {
-	int size=0, resident=0, share=0, trs=0, lrs=0, drs=0, dt=0;
+	int size, resident, shared, text, lib, data, dirty = 0;
 	struct mm_struct *mm = get_task_mm(task);
+	struct vm_area_struct * vma;
 
-	if (mm) {
-		struct vm_area_struct * vma;
-		down_read(&mm->mmap_sem);
-		vma = mm->mmap;
-		while (vma) {
-			pgd_t *pgd = pgd_offset(mm, vma->vm_start);
-			int pages = 0, shared = 0, dirty = 0, total = 0;
+	size = resident = shared = text = lib = data = 0;
 
-			statm_pgd_range(pgd, vma->vm_start, vma->vm_end, &pages, &shared, &dirty, &total);
-			resident += pages;
-			share += shared;
-			dt += dirty;
-			size += total;
-			if (vma->vm_flags & VM_EXECUTABLE)
-				trs += pages;	/* text */
-			else if (vma->vm_flags & VM_GROWSDOWN)
-				drs += pages;	/* stack */
-			else if (vma->vm_end > 0x60000000)
-				lrs += pages;	/* library */
-			else
-				drs += pages;
-			vma = vma->vm_next;
-		}
-		up_read(&mm->mmap_sem);
-		mmput(mm);
+	if (!mm)
+		goto out;
+
+	down_read(&mm->mmap_sem);
+	resident = mm->rss;
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		int pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+		size += pages;
+		if (vma->vm_flags & VM_SHARED)
+			shared += pages;
+		if (vma->vm_flags & VM_EXECUTABLE)
+			text += pages;
+		else
+			data += pages;
 	}
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+out:
 	return sprintf(buffer,"%d %d %d %d %d %d %d\n",
-		       size, resident, share, trs, lrs, drs, dt);
+		       size, resident, shared, text, lib, data, dirty);
 }
 
 /*
