Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSIEDYp>; Wed, 4 Sep 2002 23:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSIEDYp>; Wed, 4 Sep 2002 23:24:45 -0400
Received: from holomorphy.com ([66.224.33.161]:50344 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316684AbSIEDYm>;
	Wed, 4 Sep 2002 23:24:42 -0400
Date: Wed, 4 Sep 2002 20:20:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@surriel.com
Subject: Re: statm_pgd_range() sucks!
Message-ID: <20020905032035.GY888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, riel@surriel.com
References: <20020830015814.GN18114@holomorphy.com> <3D6EDDC0.F9ADC015@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D6EDDC0.F9ADC015@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 07:51:44PM -0700, Andrew Morton wrote:
> BTW, Rohit's hugetlb patch touches proc_pid_statm(), so a diff on -mm3
> would be appreciated.

I lost track of what the TODO's were but this is of relatively minor
import, and I lagged long enough this is against 2.5.33-mm2:


Cheers,
Bill


--- linux-virgin/fs/proc/array.c.orig	2002-09-02 23:24:57.000000000 -0700
+++ linux-wli/fs/proc/array.c		2002-09-02 23:37:17.000000000 -0700
@@ -394,131 +394,38 @@
 	return res;
 }
 		
-static inline void statm_pte_range(pmd_t * pmd, unsigned long address, unsigned long size, int * pages, int * shared, int * dirty, int * total)
+int proc_pid_statm(task_t *task, char *buffer)
 {
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
+	int size, resident, shared, text, lib, data, dirty;
+	struct mm_struct *mm = get_task_mm(task);
+	struct vm_area_struct * vma;
 
-static void statm_pgd_range(pgd_t * pgd, unsigned long address, unsigned long end,
-	int * pages, int * shared, int * dirty, int * total)
-{
-	while (address < end) {
-		statm_pmd_range(pgd, address, end - address, pages, shared, dirty, total);
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		pgd++;
-	}
-}
+	size = resident = shared = text = lib = data = dirty = 0;
 
-int proc_pid_statm(struct task_struct *task, char * buffer)
-{
-	int size=0, resident=0, share=0, trs=0, lrs=0, drs=0, dt=0;
-	struct mm_struct *mm = get_task_mm(task);
+	if (!mm)
+		goto out;
 
-	if (mm) {
-		struct vm_area_struct * vma;
-		down_read(&mm->mmap_sem);
-		vma = mm->mmap;
-		while (vma) {
-			pgd_t *pgd = pgd_offset(mm, vma->vm_start);
-			int pages = 0, shared = 0, dirty = 0, total = 0;
-			if (is_vm_hugetlb_page(vma)) {
-				int num_pages = ((vma->vm_end - vma->vm_start)/PAGE_SIZE);
-
-				resident += num_pages;
-				if (!(vma->vm_flags & VM_DONTCOPY))
-					share += num_pages;
-				if (vma->vm_flags & VM_WRITE)
-					dt += num_pages;
-				drs += num_pages;
-				vma = vma->vm_next;
-				continue;
-			}
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
+	down_read(&mm->mmap_sem);
+	resident = mm->rss;
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		int pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+		if (is_vm_hugetlb_page(vma)) {
+			if (!(vma->vm_flags & VM_DONTCOPY))
+				shared += pages;
+			continue;
 		}
-		up_read(&mm->mmap_sem);
-		mmput(mm);
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
