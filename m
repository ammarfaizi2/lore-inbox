Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTK1Vif (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 16:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTK1Vif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 16:38:35 -0500
Received: from holomorphy.com ([199.26.172.102]:3524 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263496AbTK1Vib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 16:38:31 -0500
Date: Fri, 28 Nov 2003 13:38:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Vladimir Zidar <vladimir@mindnever.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/<pid>/status: VmSize
Message-ID: <20031128213817.GZ19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Vladimir Zidar <vladimir@mindnever.org>,
	linux-kernel@vger.kernel.org
References: <1070047087.4058.469.camel@mravojed>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070047087.4058.469.camel@mravojed>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 28, 2003 at 08:18:08PM +0100, Vladimir Zidar wrote:
>  We have multithreaded application that uses lots of mmap()-ed memory
> (one big file in size around 700 MB, and lots of anonymous mappings to
> /dev/zero in average size between 64k and 1MB). This program sometimes
> grow up to 1.6 GB in size (SIZE that is shown by top utility).. But,
> sometimes /proc/<pid>/status shows VmSize with more than 2GB, where at
> the same time top and other /proc/<pid> entries show 1.6GB. This somehow
> affects pthread_create() call which fails then.
>  The question is, how can happen that different numbers are shown in
> proc filesystem, for same pid ? (which is part of multithreaded
> process), and why pthread_create() fails ? Is there maybe 2GB limit on
> memory size that single process can manage on i386 ? Also, when such
> program crashes, it creates 2GB core file, which is not completly usable
> from gdb. (gdb complains that some addresses are not accessible)..
>  I suspect that this has something to do with amount of RAM (4GB), but
> we are still trying to get this server tested with only 2GB running in
> standard (not paged) mode.. but this can take some time, since it is one
> of our production machines.

Well, some of the 2.4 proc_pid_statm() numbers are gibberish. This should
address some of the numbers being gibberish. It eliminates some of the
statm_*_range() parameters, and gets size and rss from the mm's counters,
which should be accurate, and last of all, ditches the hardcoded constant
for its intended meaning: TASK_UNMAPPED_BASE.

The real way to go is to keep count of these things as they're set up and
torn down, but that's a 100KB patch.


-- wli


===== fs/proc/array.c 1.10 vs edited =====
--- 1.10/fs/proc/array.c	Tue Apr 22 10:21:00 2003
+++ edited/fs/proc/array.c	Fri Nov 28 13:30:42 2003
@@ -397,7 +397,7 @@
 }
 		
 static inline void statm_pte_range(pmd_t * pmd, unsigned long address, unsigned long size,
-	int * pages, int * shared, int * dirty, int * total)
+	int * pages, int * shared, int * dirty)
 {
 	pte_t * pte;
 	unsigned long end;
@@ -422,7 +422,6 @@
 		pte++;
 		if (pte_none(page))
 			continue;
-		++*total;
 		if (!pte_present(page))
 			continue;
 		ptpage = pte_page(page);
@@ -437,7 +436,7 @@
 }
 
 static inline void statm_pmd_range(pgd_t * pgd, unsigned long address, unsigned long size,
-	int * pages, int * shared, int * dirty, int * total)
+	int * pages, int * shared, int * dirty)
 {
 	pmd_t * pmd;
 	unsigned long end;
@@ -455,17 +454,17 @@
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 	do {
-		statm_pte_range(pmd, address, end - address, pages, shared, dirty, total);
+		statm_pte_range(pmd, address, end - address, pages, shared, dirty);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address < end);
 }
 
 static void statm_pgd_range(pgd_t * pgd, unsigned long address, unsigned long end,
-	int * pages, int * shared, int * dirty, int * total)
+	int * pages, int * shared, int * dirty)
 {
 	while (address < end) {
-		statm_pmd_range(pgd, address, end - address, pages, shared, dirty, total);
+		statm_pmd_range(pgd, address, end - address, pages, shared, dirty);
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		pgd++;
 	}
@@ -487,23 +486,23 @@
 		vma = mm->mmap;
 		while (vma) {
 			pgd_t *pgd = pgd_offset(mm, vma->vm_start);
-			int pages = 0, shared = 0, dirty = 0, total = 0;
+			int pages = 0, shared = 0, dirty = 0;
 
-			statm_pgd_range(pgd, vma->vm_start, vma->vm_end, &pages, &shared, &dirty, &total);
-			resident += pages;
+			statm_pgd_range(pgd, vma->vm_start, vma->vm_end, &pages, &shared, &dirty);
 			share += shared;
 			dt += dirty;
-			size += total;
 			if (vma->vm_flags & VM_EXECUTABLE)
 				trs += pages;	/* text */
 			else if (vma->vm_flags & VM_GROWSDOWN)
 				drs += pages;	/* stack */
-			else if (vma->vm_end > 0x60000000)
+			else if (vma->vm_end > TASK_UNMAPPED_BASE)
 				lrs += pages;	/* library */
 			else
 				drs += pages;
 			vma = vma->vm_next;
 		}
+		size = mm->total_vm;
+		resident = mm->rss;
 		up_read(&mm->mmap_sem);
 		mmput(mm);
 	}
