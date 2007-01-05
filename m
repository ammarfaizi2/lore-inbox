Return-Path: <linux-kernel-owner+w=401wt.eu-S1161002AbXAEHph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbXAEHph (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 02:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbXAEHpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 02:45:36 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:57842 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161002AbXAEHpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 02:45:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UpOLFG+w6fAr9d6QoT7oY+7eeIGTWhf+KSj+dnamf9XTjyypzvu/AwM5XzHpJQlBIQOwOG8b6descosn0OyUTeF8GNMJYunfU1HACOY+iwf7yDO9JEgxExA9ABmJTHXRP/e75EE+tj721OMWkFblPonTcqNVjqRaParCMGqQBII=
Message-ID: <4df04b840701042345x71d25be5ma1474b84a99795b3@mail.gmail.com>
Date: Fri, 5 Jan 2007 15:45:33 +0800
From: "yunfeng zhang" <zyf.zeroos@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16.29 1/1] memory: enhance Linux swap subsystem
Cc: pavel@ucw.cz, rdunlap@xenotime.net
In-Reply-To: <4df04b840701042335t5f99b21cl4962dec35c0ffa1a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4df04b840612260018u4be268cod9886edefd25c3a@mail.gmail.com>
	 <67029b170612260103o9193346hde726a3f09afa57f@mail.gmail.com>
	 <4df04b840612261933g6eab036rb474930828dadb6d@mail.gmail.com>
	 <67029b170612292150q7f59390cp83f35698ac7f7bd7@mail.gmail.com>
	 <4df04b840701042335t5f99b21cl4962dec35c0ffa1a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A new patch has been done by me, based on the previous quilt patch
(2.6.16.29). Here is
changelog

--------------------------
>> NEW
New kernel thread kppsd is added to execute background scanning task
periodically (mm/vmscan.c).

PPS statistic is added into /proc/meminfo, its prototype is in
include/linux/mm.h.

Documentation/vm_pps.txt is also updated to show the aboved two new features,
some sections is re-written for comprehension.

>> BUG
New loop code is introduced in shrink_private_vma (mm/vmscan.c) and
pps_swapoff (mm/swapfile.c), contrast with old code, even lhtemp is freed
during loop, it's also safe.

A bug is catched in mm/memory.c:zap_pte_range -- if a PrivatePage is
being written back, it will be migrated back to Linux legacy page system.

A fault done by me in previous patch is remedied in stage 5, now stage 5 can
work.

>> MISCELLANEOUS
UP code has been separated from SMP code in dftlb.
--------------------------

Index: linux-2.6.16.29/Documentation/vm_pps.txt
===================================================================
--- linux-2.6.16.29.orig/Documentation/vm_pps.txt	2007-01-04
14:47:35.000000000 +0800
+++ linux-2.6.16.29/Documentation/vm_pps.txt	2007-01-04 14:49:36.000000000 +0800
@@ -6,11 +6,11 @@
 // Purpose <([{
 The file is used to document the idea which is published firstly at
 http://www.ussg.iu.edu/hypermail/linux/kernel/0607.2/0451.html, as a part of my
-OS -- main page http://blog.chinaunix.net/u/21764/index.php. In brief, a patch
-of the document to enchance the performance of Linux swap subsystem. You can
-find the overview of the idea in section <How to Reclaim Pages more
-Efficiently> and how I patch it into Linux 2.6.16.29 in section <Pure Private
-Page System -- pps>.
+OS -- main page http://blog.chinaunix.net/u/21764/index.php. In brief, the
+patch of the document is for enchancing the performance of Linux swap
+subsystem. You can find the overview of the idea in section <How to Reclaim
+Pages more Efficiently> and how I patch it into Linux 2.6.16.29 in section
+<Pure Private Page System -- pps>.
 // }])>

 // How to Reclaim Pages more Efficiently <([{
@@ -21,7 +21,9 @@
 OK! to modern OS, its memory subsystem can be divided into three layers
 1) Space layer (InodeSpace, UserSpace and CoreSpace).
 2) VMA layer (PrivateVMA and SharedVMA, memory architecture-independent layer).
-3) PTE and page layer (architecture-dependent).
+3) PTE, zone/memory inode layer (architecture-dependent).
+4) Maybe it makes you sense that Page should be placed on the 3rd layer, but
+   here, it's placed on the 2nd layer since it's the basic unit of VMA.

 Since the 2nd layer assembles the much statistic of page-acess information, so
 it's nature that swap subsystem should be deployed and implemented on the 2nd
@@ -41,7 +43,8 @@
 Unfortunately, Linux 2.6.16.29 swap subsystem is based on the 3rd layer -- a
 system on zone::active_list/inactive_list.

-I've finished a patch, see section <Pure Private Page System -- pps>.
Note, it ISN'T perfect.
+I've finished a patch, see section <Pure Private Page System -- pps>. Note, it
+ISN'T perfect.
 // }])>

 // Pure Private Page System -- pps  <([{
@@ -70,7 +73,18 @@
 3) <Private Page Lifecycle of pps> -- how private pages enter in/go off pps.
 4) <VMA Lifecycle of pps> which VMA is belonging to pps.

-PPS uses init_mm.mm_list list to enumerate all swappable UserSpace.
+PPS uses init_mm.mm_list list to enumerate all swappable UserSpace
+(shrink_private_vma).
+
+A new kernel thread -- kppsd is introduced in mm/vmscan.c, its task is to
+execute the stages of pps periodically, note an appropriate timeout ticks is
+necessary so we can give application a chance to re-map back its PrivatePage
+from UnmappedPTE to PTE, that is, show their conglomeration affinity.
+scan_control::pps_cmd field is used to control the behavior of kppsd, = 1 for
+accelerating scanning process and reclaiming pages, it's used in balance_pgdat.
+
+PPS statistic data is appended to /proc/meminfo entry, its prototype is in
+include/linux/mm.h.

 I'm also glad to highlight my a new idea -- dftlb which is described in
 section <Delay to Flush TLB>.
@@ -97,15 +111,19 @@
    gone when a CPU starts to execute the task in timer interrupt, so don't use
    dftlb.
 combine stage 1 with stage 2, and send IPI immediately in fill_in_tlb_tasks.
+
+dftlb increases mm_struct::mm_users to prevent the mm from being freed when
+other CPU works on it.
 // }])>

 // Stage Definition <([{
 The whole process of private page page-out is divided into six stages, as
-showed in shrink_pvma_scan_ptes of mm/vmscan.c
+showed in shrink_pvma_scan_ptes of mm/vmscan.c, the code groups the similar
+pages to a series.
 1) PTE to untouched PTE (access bit is cleared), append flushing
tasks to dftlb.
 2) Convert untouched PTE to UnmappedPTE.
 3) Link SwapEntry to every UnmappedPTE.
-4) Synchronize the page of a UnmappedPTE with its physical swap page.
+4) Flush PrivatePage of UnmappedPTE to its disk SwapPage.
 5) Reclaimed the page and shift UnmappedPTE to SwappedPTE.
 6) SwappedPTE stage.
 // }])>
@@ -114,7 +132,15 @@
 New VMA flag (VM_PURE_PRIVATE) is appended into VMA in include/linux/mm.h.

 New PTE type (UnmappedPTE) is appended into PTE system in
-include/asm-i386/pgtable.h.
+include/asm-i386/pgtable.h. Its prototype is
+struct UnmappedPTE {
+    int present : 1; // must be 0.
+    ...
+    int pageNum : 20;
+};
+The new PTE has a feature, it keeps a link to its PrivatePage and prevent the
+page from being visited by CPU, so you can use it in <Stage Definition> as a
+middleware.
 // }])>

 // Concurrent Racers of Shrinking pps <([{
@@ -125,10 +151,14 @@
 1) mm/swapfile.c    pps_swapoff (swapoff API).
 2) mm/memory.c  do_wp_page, handle_pte_fault::unmapped_pte, do_anonymous_page
    (page-fault).
+
+The VMAs of pps can coexist with madvise, mlock, mprotect, mmap and munmap,
+that is why new VMA created from mmap.c:split_vma can re-enter into pps.
 // }])>

 // Private Page Lifecycle of pps <([{
-All pages belonging to pps are called as pure private page.
+All pages belonging to pps are called as pure private page, its PTE type is PTE
+or UnmappedPTE.

 IN (NOTE, when a pure private page enters into pps, it's also trimmed from
 Linux legacy page system by commeting lru_cache_add_active clause)
@@ -147,9 +177,10 @@
 // }])>

 // VMA Lifecycle of pps <([{
-When a PrivateVMA enters into pps, it's or-ed a new flag -- VM_PURE_PRIVATE,
-the flag is used in the shrink_private_vma of mm/vmscan.c.  Other fields are
-left untouched.
+When a PrivateVMA enters into pps, it's or-ed a new flag -- VM_PURE_PRIVATE in
+memory.c:enter_pps, you can also find which VMA is fit with pps in it, the flag
+is used in the shrink_private_vma of mm/vmscan.c.  Other fields are left
+untouched.

 IN.
 1) fs/exec.c	setup_arg_pages	(StackVMA).
@@ -173,18 +204,9 @@
    UnmappedPTE) and PrivatePage (SwapPage) which is described in my OS and the
    aboved hyperlink of Linux kernel mail list. So it's a compromise to use
    Linux legacy SwapCache in my pps.
-2) SwapCache should provide more flexible interfaces, shrink_pvma_scan_ptes
+2) SwapSpace should provide more flexible interfaces, shrink_pvma_scan_ptes
    need allocate swap entries in batch, exactly, allocate a batch of fake
    continual swap entries, see mm/pps_swapin_readahead.
-3) pps statistic entry in /proc/meminfo.
-4) a better arithmetic to pick mm out to scan and shrink in shrink_private_vma.
-5) It's better to execute the first 2 stages when system is idle, current
-   SwapDaemon only is activated when free pages are low.
-6) A scanning count should be added into mm_struct, so when the count is
-   becoming enough old to open stage 3 and 4.
-
-I'm still working on improvement 4, 5 and 6 to find out how to maximum the
-performance of swap subsystem.

 If Linux kernel group can't make a schedule to re-write their memory code,
 however, pps maybe is the best solution until now.
Index: linux-2.6.16.29/fs/exec.c
===================================================================
--- linux-2.6.16.29.orig/fs/exec.c	2007-01-04 14:47:35.000000000 +0800
+++ linux-2.6.16.29/fs/exec.c	2007-01-04 14:49:36.000000000 +0800
@@ -320,6 +320,8 @@
 		pte_unmap_unlock(pte, ptl);
 		goto out;
 	}
+	atomic_inc(&pps_info.total);
+	atomic_inc(&pps_info.pte_count);
 	inc_mm_counter(mm, anon_rss);
 	set_pte_at(mm, address, pte, pte_mkdirty(pte_mkwrite(mk_pte(
 					page, vma->vm_page_prot))));
Index: linux-2.6.16.29/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.16.29.orig/fs/proc/proc_misc.c	2007-01-04 14:47:35.000000000 +0800
+++ linux-2.6.16.29/fs/proc/proc_misc.c	2007-01-04 14:49:36.000000000 +0800
@@ -174,7 +174,11 @@
 		"PageTables:   %8lu kB\n"
 		"VmallocTotal: %8lu kB\n"
 		"VmallocUsed:  %8lu kB\n"
-		"VmallocChunk: %8lu kB\n",
+		"VmallocChunk: %8lu kB\n"
+		"PPS Total:    %8d kB\n"
+		"PPS PTE:      %8d kB\n"
+		"PPS Unmapped: %8d kB\n"
+		"PPS Swapped:  %8d kB\n",
 		K(i.totalram),
 		K(i.freeram),
 		K(i.bufferram),
@@ -197,7 +201,11 @@
 		K(ps.nr_page_table_pages),
 		(unsigned long)VMALLOC_TOTAL >> 10,
 		vmi.used >> 10,
-		vmi.largest_chunk >> 10
+		vmi.largest_chunk >> 10,
+		K(pps_info.total.counter),
+		K(pps_info.pte_count.counter),
+		K(pps_info.unmapped_count.counter),
+		K(pps_info.swapped_count.counter)
 		);

 		len += hugetlb_report_meminfo(page + len);
Index: linux-2.6.16.29/include/asm-i386/mmu_context.h
===================================================================
--- linux-2.6.16.29.orig/include/asm-i386/mmu_context.h	2007-01-04
14:47:35.000000000 +0800
+++ linux-2.6.16.29/include/asm-i386/mmu_context.h	2007-01-04
14:49:36.000000000 +0800
@@ -33,6 +33,9 @@
 		/* stop flush ipis for the previous mm */
 		cpu_clear(cpu, prev->cpu_vm_mask);
 #ifdef CONFIG_SMP
+		// vmscan.c::end_tlb_tasks maybe had copied cpu_vm_mask before we leave
+		// prev, so let's flush the trace of prev of delay_tlb_tasks.
+		timer_flush_tlb_tasks(NULL);
 		per_cpu(cpu_tlbstate, cpu).state = TLBSTATE_OK;
 		per_cpu(cpu_tlbstate, cpu).active_mm = next;
 #endif
Index: linux-2.6.16.29/include/linux/mm.h
===================================================================
--- linux-2.6.16.29.orig/include/linux/mm.h	2007-01-04 14:47:36.000000000 +0800
+++ linux-2.6.16.29/include/linux/mm.h	2007-01-04 14:49:37.000000000 +0800
@@ -1058,8 +1058,16 @@
 extern int randomize_va_space;
 #endif

+struct pps_info {
+	atomic_t total;
+	atomic_t pte_count; // stage 1 and 2.
+	atomic_t unmapped_count; // stage 3 and 4.
+	atomic_t swapped_count; // stage 6.
+};
+extern struct pps_info pps_info;
+
 /* vmscan.c::delay flush TLB */
-struct delay_tlb_task_t
+struct delay_tlb_task
 {
 	struct mm_struct* mm;
 	cpumask_t cpu_mask;
@@ -1067,7 +1075,7 @@
 	unsigned long start[32];
 	unsigned long end[32];
 };
-extern struct delay_tlb_task_t delay_tlb_tasks[32];
+extern struct delay_tlb_task delay_tlb_tasks[32];

 // The prototype of the function is fit with the "func" of "int
 // smp_call_function (void (*func) (void *info), void *info, int retry, int
Index: linux-2.6.16.29/kernel/timer.c
===================================================================
--- linux-2.6.16.29.orig/kernel/timer.c	2007-01-04 14:47:37.000000000 +0800
+++ linux-2.6.16.29/kernel/timer.c	2007-01-04 14:49:37.000000000 +0800
@@ -843,7 +843,9 @@
 	scheduler_tick();
  	run_posix_cpu_timers(p);

+#ifdef SMP
 	timer_flush_tlb_tasks(NULL);
+#endif
 }

 /*
Index: linux-2.6.16.29/mm/memory.c
===================================================================
--- linux-2.6.16.29.orig/mm/memory.c	2007-01-04 14:47:37.000000000 +0800
+++ linux-2.6.16.29/mm/memory.c	2007-01-04 14:49:37.000000000 +0800
@@ -615,6 +615,9 @@
 	spinlock_t *ptl;
 	int file_rss = 0;
 	int anon_rss = 0;
+	int pps_pte = 0;
+	int pps_unmapped = 0;
+	int pps_swapped = 0;

 	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	do {
@@ -658,8 +661,13 @@
 						addr) != page->index)
 				set_pte_at(mm, addr, pte,
 					   pgoff_to_pte(page->index));
-			// if (vma->vm_flags & VM_PURE_PRIVATE && page != ZERO_PAGE(addr))
-			// 	lru_cache_add_active(page);
+			if (vma->vm_flags & VM_PURE_PRIVATE) {
+				if (page != ZERO_PAGE(addr)) {
+					if (PageWriteback(page))
+						lru_cache_add_active(page);
+					pps_pte++;
+				}
+			}
 			if (PageAnon(page))
 				anon_rss--;
 			else {
@@ -682,18 +690,28 @@
 		if (pte_unmapped(ptent)) {
 			struct page *page;
 			page = pfn_to_page(pte_pfn(ptent));
+			BUG_ON(page == ZERO_PAGE(addr));
+			if (PageWriteback(page))
+				lru_cache_add_active(page);
+			pps_unmapped++;
 			pte_clear_full(mm, addr, pte, tlb->fullmm);
-			// lru_cache_add_active(page);
 			tlb_remove_page(tlb, page);
 			anon_rss--;
 			continue;
 		}
-		if (pte_swapped(ptent))
+		if (pte_swapped(ptent)) {
+			if (vma->vm_flags & VM_PURE_PRIVATE)
+				pps_swapped++;
 			free_swap_and_cache(pte_to_swp_entry(ptent));
+		}
 		pte_clear_full(mm, addr, pte, tlb->fullmm);
 	} while (pte++, addr += PAGE_SIZE, (addr != end && *zap_work > 0));

 	add_mm_rss(mm, file_rss, anon_rss);
+	atomic_sub(pps_pte + pps_unmapped, &pps_info.total);
+	atomic_sub(pps_pte, &pps_info.pte_count);
+	atomic_sub(pps_unmapped, &pps_info.unmapped_count);
+	atomic_sub(pps_swapped, &pps_info.swapped_count);
 	pte_unmap_unlock(pte - 1, ptl);

 	return addr;
@@ -1521,6 +1539,10 @@
 		lazy_mmu_prot_update(entry);
 		if (!(vma->vm_flags & VM_PURE_PRIVATE))
 			lru_cache_add_active(new_page);
+		else {
+			atomic_inc(&pps_info.total);
+			atomic_inc(&pps_info.pte_count);
+		}
 		page_add_new_anon_rmap(new_page, vma, address);

 		/* Free the old page.. */
@@ -2041,6 +2063,11 @@
 	if (vm_swap_full())
 		remove_exclusive_swap_page(page);
 	unlock_page(page);
+	if (vma->vm_flags & VM_PURE_PRIVATE) {
+		atomic_dec(&pps_info.swapped_count);
+		atomic_inc(&pps_info.total);
+		atomic_inc(&pps_info.pte_count);
+	}

 	if (write_access) {
 		if (do_wp_page(mm, vma, address,
@@ -2094,6 +2121,10 @@
 			goto release;
 		if (!(vma->vm_flags & VM_PURE_PRIVATE))
 			lru_cache_add_active(page);
+		else {
+			atomic_inc(&pps_info.total);
+			atomic_inc(&pps_info.pte_count);
+		}
 		inc_mm_counter(mm, anon_rss);
 		page_add_new_anon_rmap(page, vma, address);
 	} else {
@@ -2311,6 +2342,8 @@
 	if (!pte_present(entry)) {
 		if (pte_unmapped(entry)) {
 			BUG_ON(!(vma->vm_flags & VM_PURE_PRIVATE));
+			atomic_dec(&pps_info.unmapped_count);
+			atomic_inc(&pps_info.pte_count);
 			struct page* page = pte_page(entry);
 			pte_t temp_pte = mk_pte(page, vma->vm_page_prot);
 			pte = pte_offset_map_lock(mm, pmd, address, &ptl);
@@ -2565,8 +2598,11 @@
 {
 	struct page* page;
 	pte_t entry;
-	pte_t* pte;
+	pte_t *pte;
 	spinlock_t* ptl;
+	int pps_pte = 0;
+	int pps_unmapped = 0;
+	int pps_swapped = 0;

 	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	do {
@@ -2577,16 +2613,23 @@
 			set_pte_at(mm, addr, pte, entry);
 			BUG_ON(page == ZERO_PAGE(addr));
 			page_add_new_anon_rmap(page, vma, addr);
-		}
-		if (pte_present(*pte)) {
+			lru_cache_add_active(page);
+			pps_unmapped++;
+		} else if (pte_present(*pte)) {
 			page = pte_page(*pte);
 			if (page == ZERO_PAGE(addr))
 				continue;
 			lru_cache_add_active(page);
-		}
+			pps_pte++;
+		} else if (!pte_present(*pte) && pte_swapped(*pte))
+			pps_swapped++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap_unlock(pte - 1, ptl);
 	lru_add_drain();
+	atomic_sub(pps_pte + pps_unmapped, &pps_info.total);
+	atomic_sub(pps_pte, &pps_info.pte_count);
+	atomic_sub(pps_unmapped, &pps_info.unmapped_count);
+	atomic_sub(pps_swapped, &pps_info.swapped_count);
 }

 static void migrate_back_pmd_range(struct mm_struct* mm, pud_t *pud, struct
@@ -2636,17 +2679,13 @@
 	} while (pgd++, addr = next, addr != end);
 }

-LIST_HEAD(pps_head);
-LIST_HEAD(pps_head_buddy);
-
-DEFINE_SPINLOCK(pps_lock);
-
 void enter_pps(struct mm_struct* mm, struct vm_area_struct* vma)
 {
 	int condition = VM_READ | VM_WRITE | VM_EXEC | \
 		 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC | \
 		 VM_GROWSDOWN | VM_GROWSUP | \
-		 VM_LOCKED | VM_SEQ_READ | VM_RAND_READ | VM_DONTCOPY | VM_ACCOUNT;
+		 VM_LOCKED | VM_SEQ_READ | VM_RAND_READ | VM_DONTCOPY | VM_ACCOUNT | \
+		 VM_PURE_PRIVATE;
 	if (!(vma->vm_flags & ~condition) && vma->vm_file == NULL) {
 		vma->vm_flags |= VM_PURE_PRIVATE;
 		if (list_empty(&mm->mmlist)) {
Index: linux-2.6.16.29/mm/swapfile.c
===================================================================
--- linux-2.6.16.29.orig/mm/swapfile.c	2007-01-04 14:47:37.000000000 +0800
+++ linux-2.6.16.29/mm/swapfile.c	2007-01-04 14:49:37.000000000 +0800
@@ -544,19 +544,22 @@

 static int pps_swapoff(int type)
 {
-	struct mm_struct* mm;
 	struct vm_area_struct* vma;
-	struct list_head *pos, *lhtemp;
+	struct list_head *pos;
+	struct mm_struct *prev, *mm;
 	int ret = 0;

+	prev = mm = &init_mm;
+	pos = &init_mm.mmlist;
+	atomic_inc(&prev->mm_users);
 	spin_lock(&mmlist_lock);
-	list_for_each_safe(pos, lhtemp, &init_mm.mmlist) {
+	while ((pos = pos->next) != &init_mm.mmlist) {
 		mm = list_entry(pos, struct mm_struct, mmlist);
-		if (atomic_inc_return(&mm->mm_users) == 1) {
-			atomic_dec(&mm->mm_users);
+		if (!atomic_add_unless(&mm->mm_users, 1, 0))
 			continue;
-		}
 		spin_unlock(&mmlist_lock);
+		mmput(prev);
+		prev = mm;
 		down_read(&mm->mmap_sem);
 		for (vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
 			if (!(vma->vm_flags & VM_PURE_PRIVATE))
@@ -568,10 +571,10 @@
 				break;
 		}
 		up_read(&mm->mmap_sem);
-		mmput(mm);
 		spin_lock(&mmlist_lock);
 	}
 	spin_unlock(&mmlist_lock);
+	mmput(prev);
 	return ret;
 }

Index: linux-2.6.16.29/mm/vmscan.c
===================================================================
--- linux-2.6.16.29.orig/mm/vmscan.c	2007-01-04 14:47:38.000000000 +0800
+++ linux-2.6.16.29/mm/vmscan.c	2007-01-05 11:42:05.795353536 +0800
@@ -79,6 +79,9 @@
 	 * In this context, it doesn't matter that we scan the
 	 * whole list at once. */
 	int swap_cluster_max;
+
+	/* pps control command, 0: do stage 1-4, kppsd only; 1: full stages. */
+	int pps_cmd;
 };

 /*
@@ -1514,6 +1517,17 @@
 	return ret;
 }

+// pps fields.
+static wait_queue_head_t kppsd_wait;
+static struct scan_control wakeup_sc;
+struct pps_info pps_info = {
+	.total = ATOMIC_INIT(0),
+	.pte_count = ATOMIC_INIT(0), // stage 1 and 2.
+	.unmapped_count = ATOMIC_INIT(0), // stage 3 and 4.
+	.swapped_count = ATOMIC_INIT(0) // stage 6.
+};
+// pps end.
+
 struct series_t {
 	pte_t orig_ptes[MAX_SERIES_LENGTH];
 	pte_t* ptes[MAX_SERIES_LENGTH];
@@ -1564,11 +1578,10 @@
 	series.series_length = i;
 }

-struct delay_tlb_task_t delay_tlb_tasks[32] = { [0 ... 31] = {0} };
+struct delay_tlb_task delay_tlb_tasks[32] = { [0 ... 31] = {0} };

 void timer_flush_tlb_tasks(void* data)
 {
-	// To x86, if we found there were some flushing tasks, we should do
it all together, that is, flush it once.
 	int i;
 #ifdef CONFIG_X86
 	int flag = 0;
@@ -1591,12 +1604,12 @@
 #endif
 }

-static struct delay_tlb_task_t* delay_task = NULL;
+static struct delay_tlb_task* delay_task = NULL;
 static int vma_index = 0;

-static struct delay_tlb_task_t* search_free_tlb_tasks_slot(void)
+static struct delay_tlb_task* search_free_tlb_tasks_slot(void)
 {
-	struct delay_tlb_task_t* ret = NULL;
+	struct delay_tlb_task* ret = NULL;
 	int i;
 again:
 	for (i = 0; i < 32; i++) {
@@ -1650,18 +1663,24 @@

 static void end_tlb_tasks(void)
 {
-	if (!cpus_empty(delay_task->cpu_mask)) {
-		atomic_inc(&delay_task->mm->mm_users);
-		delay_task->cpu_mask = delay_task->mm->cpu_vm_mask;
-	} else
-		delay_task->mm = NULL;
+	atomic_inc(&delay_task->mm->mm_users);
+	delay_task->cpu_mask = delay_task->mm->cpu_vm_mask;
 	delay_task = NULL;
+#ifndef CONFIG_SMP
+	timer_flush_tlb_tasks(NULL);
+#endif
 }

 static void fill_in_tlb_tasks(struct vm_area_struct* vma, unsigned long addr,
 		unsigned long end)
 {
 	struct mm_struct* mm;
+	// First, try to combine the task with the previous.
+	if (vma_index != 0 && delay_task->vma[vma_index - 1] == vma &&
+			delay_task->end[vma_index - 1] == addr) {
+		delay_task->end[vma_index - 1] = end;
+		return;
+	}
 fill_it:
 	if (vma_index != 32) {
 		delay_task->vma[vma_index] = vma;
@@ -1678,11 +1697,11 @@
 	goto fill_it;
 }

-static void shrink_pvma_scan_ptes(struct scan_control* sc,
-		struct mm_struct* mm, struct vm_area_struct* vma, pmd_t* pmd,
-		unsigned long addr, unsigned long end)
+static void shrink_pvma_scan_ptes(struct scan_control* sc, struct mm_struct*
+		mm, struct vm_area_struct* vma, pmd_t* pmd, unsigned long addr,
+		unsigned long end)
 {
-	int i;
+	int i, statistic;
 	spinlock_t* ptl = pte_lockptr(mm, pmd);
 	pte_t* pte = pte_offset_map(pmd, addr);
 	int anon_rss = 0;
@@ -1694,6 +1713,8 @@
 	do {
 		memset(&series, 0, sizeof(struct series_t));
 		find_series(&pte, &addr, end);
+		if (sc->pps_cmd == 0 && series.series_stage == 5)
+			continue;
 		switch (series.series_stage) {
 			case 1: // PTE -- untouched PTE.
 				for (i = 0; i < series.series_length; i++) {
@@ -1722,6 +1743,7 @@
 				 * send IPI immediately in fill_in_tlb_tasks.
 				 */
 				spin_lock(ptl);
+				statistic = 0;
 				for (i = 0; i < series.series_length; i++) {
 					if (unlikely(pte_same(*series.ptes[i], series.orig_ptes[i]))) {
 						pte_t pte_unmapped = series.orig_ptes[i];
@@ -1734,8 +1756,11 @@
 							continue;
 						page_remove_rmap(series.pages[i]);
 						anon_rss--;
+						statistic++;
 					}
 				}
+				atomic_add(statistic, &pps_info.unmapped_count);
+				atomic_sub(statistic, &pps_info.pte_count);
 				spin_unlock(ptl);
 				break;
 			case 3: // Attach SwapPage to PrivatePage.
@@ -1798,15 +1823,17 @@
 				}
 				break;
 			case 5: // UnmappedPTE -- SwappedPTE, reclaim PrivatePage.
+				statistic = 0;
 				for (i = 0; i < series.series_length; i++) {
 					struct page* page = series.pages[i];
 					lock_page(page);
 					spin_lock(ptl);
-					if (unlikely(pte_same(*series.ptes[i], series.orig_ptes[i]))) {
+					if (unlikely(!pte_same(*series.ptes[i], series.orig_ptes[i]))) {
 						spin_unlock(ptl);
 						unlock_page(page);
 						continue;
 					}
+					statistic++;
 					swp_entry_t entry = { .val = page_private(page) };
 					swap_duplicate(entry);
 					pte_t pte_swp = swp_entry_to_pte(entry);
@@ -1820,6 +1847,9 @@
 						__pagevec_release_nonlru(&freed_pvec);
 					sc->nr_reclaimed++;
 				}
+				atomic_add(statistic, &pps_info.swapped_count);
+				atomic_sub(statistic, &pps_info.unmapped_count);
+				atomic_sub(statistic, &pps_info.total);
 				break;
 			case 6:
 				// NULL operation!
@@ -1831,9 +1861,9 @@
 		__pagevec_release_nonlru(&freed_pvec);
 }

-static void shrink_pvma_pmd_range(struct scan_control* sc, struct
mm_struct* mm,
-		struct vm_area_struct* vma, pud_t* pud,
-		unsigned long addr, unsigned long end)
+static void shrink_pvma_pmd_range(struct scan_control* sc, struct mm_struct*
+		mm, struct vm_area_struct* vma, pud_t* pud, unsigned long addr,
+		unsigned long end)
 {
 	unsigned long next;
 	pmd_t* pmd = pmd_offset(pud, addr);
@@ -1845,9 +1875,9 @@
 	} while (pmd++, addr = next, addr != end);
 }

-static void shrink_pvma_pud_range(struct scan_control* sc, struct
mm_struct* mm,
-		struct vm_area_struct* vma, pgd_t* pgd,
-		unsigned long addr, unsigned long end)
+static void shrink_pvma_pud_range(struct scan_control* sc, struct mm_struct*
+		mm, struct vm_area_struct* vma, pgd_t* pgd, unsigned long addr,
+		unsigned long end)
 {
 	unsigned long next;
 	pud_t* pud = pud_offset(pgd, addr);
@@ -1859,8 +1889,8 @@
 	} while (pud++, addr = next, addr != end);
 }

-static void shrink_pvma_pgd_range(struct scan_control* sc, struct
mm_struct* mm,
-		struct vm_area_struct* vma)
+static void shrink_pvma_pgd_range(struct scan_control* sc, struct mm_struct*
+		mm, struct vm_area_struct* vma)
 {
 	unsigned long next;
 	unsigned long addr = vma->vm_start;
@@ -1876,18 +1906,21 @@

 static void shrink_private_vma(struct scan_control* sc)
 {
-	struct mm_struct* mm;
 	struct vm_area_struct* vma;
-	struct list_head *pos, *lhtemp;
+	struct list_head *pos;
+	struct mm_struct *prev, *mm;

+	prev = mm = &init_mm;
+	pos = &init_mm.mmlist;
+	atomic_inc(&prev->mm_users);
 	spin_lock(&mmlist_lock);
-	list_for_each_safe(pos, lhtemp, &init_mm.mmlist) {
+	while ((pos = pos->next) != &init_mm.mmlist) {
 		mm = list_entry(pos, struct mm_struct, mmlist);
-		if (atomic_inc_return(&mm->mm_users) == 1) {
-			atomic_dec(&mm->mm_users);
+		if (!atomic_add_unless(&mm->mm_users, 1, 0))
 			continue;
-		}
 		spin_unlock(&mmlist_lock);
+		mmput(prev);
+		prev = mm;
 		start_tlb_tasks(mm);
 		if (down_read_trylock(&mm->mmap_sem)) {
 			for (vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
@@ -1900,10 +1933,10 @@
 			up_read(&mm->mmap_sem);
 		}
 		end_tlb_tasks();
-		mmput(mm);
 		spin_lock(&mmlist_lock);
 	}
 	spin_unlock(&mmlist_lock);
+	mmput(prev);
 }

 /*
@@ -1949,7 +1982,10 @@
 	sc.may_swap = 1;
 	sc.nr_mapped = read_page_state(nr_mapped);

-	shrink_private_vma(&sc);
+	wakeup_sc = sc;
+	wakeup_sc.pps_cmd = 1;
+	wake_up_interruptible(&kppsd_wait);
+
 	inc_page_state(pageoutrun);

 	for (i = 0; i < pgdat->nr_zones; i++) {
@@ -2086,6 +2122,33 @@
 	return total_reclaimed;
 }

+static int kppsd(void* p)
+{
+	struct task_struct *tsk = current;
+	int timeout;
+	DEFINE_WAIT(wait);
+	daemonize("kppsd");
+	tsk->flags |= PF_MEMALLOC | PF_SWAPWRITE;
+	struct scan_control default_sc;
+	default_sc.gfp_mask = GFP_KERNEL;
+	default_sc.may_writepage = 1;
+	default_sc.may_swap = 1;
+	default_sc.pps_cmd = 0;
+
+	while (1) {
+		try_to_freeze();
+		prepare_to_wait(&kppsd_wait, &wait, TASK_INTERRUPTIBLE);
+		timeout = schedule_timeout(2000);
+		finish_wait(&kppsd_wait, &wait);
+
+		if (timeout)
+			shrink_private_vma(&wakeup_sc);
+		else
+			shrink_private_vma(&default_sc);
+	}
+	return 0;
+}
+
 /*
  * The background pageout daemon, started as a kernel thread
  * from the init process.
@@ -2230,6 +2293,15 @@
 }
 #endif /* CONFIG_HOTPLUG_CPU */

+static int __init kppsd_init(void)
+{
+	init_waitqueue_head(&kppsd_wait);
+	kernel_thread(kppsd, NULL, CLONE_KERNEL);
+	return 0;
+}
+
+module_init(kppsd_init)
+
 static int __init kswapd_init(void)
 {
 	pg_data_t *pgdat;
