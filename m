Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbWHDGxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbWHDGxX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 02:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbWHDGxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 02:53:23 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:25805 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932590AbWHDGxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 02:53:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:reply-to:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=m3A5NKhm5zqg50QIgScDBgxBQb8UhTAQaVMFWQp/LvTxRnufmZ9tsRlBSpfcv+kGbwVknom5bZUU2M/bhecq6O2rUgyP6tEhDu9Ky9u6gye98GPFbtjdG78NseiIcbd7ZYLASTz6y67mlvLdmel1gB8FkiLypngcYCoaMkqY9N8=
From: Mulyadi Santosa <mulyadi.santosa@gmail.com>
Reply-To: mulyadi.santosa@gmail.com
To: akpm@osdl.org
Subject: [PATCH] accounting per process swapped out pages
Date: Fri, 4 Aug 2006 13:51:52 +0700
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608041351.52695.mulyadi.santosa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone.

Here is patch to count per process swapped out pages. This patch is 
created against 2.6.16.1. So far, I had tested by forcing certain task 
to swap out (tail -f /dev/zero) and wait until top/vmstat/free reported
that swap is occupied.

Comments and feedbacks are  greatly appreciated. Please keep me CC'ed 
since I am not subscribed to linux-kernel mailing list.

regards,

Mulyadi


# diffstat ./swap-acct.patch
 fs/proc/task_mmu.c |   14 ++++++++++++--
 include/linux/mm.h |    1 +
 mm/memory.c        |    3 +++
 mm/rmap.c          |    1 +
 mm/swapfile.c      |    1 +
5 files changed, 18 insertions(+), 2 deletions(-)

--- fs/proc/task_mmu.c.bak	2006-03-28 13:49:02.000000000 +0700
+++ fs/proc/task_mmu.c	2006-07-22 19:18:33.000000000 +0700
@@ -15,6 +15,8 @@ char *task_mem(struct mm_struct *mm, cha
 {
 	unsigned long data, text, lib;
 	unsigned long hiwater_vm, total_vm, hiwater_rss, total_rss;
+	struct vm_area_struct * this_vma;
+	unsigned long swp_out_pages=0;
 
 	/*
 	 * Note: to minimize their overhead, mm maintains hiwater_vm and
@@ -33,6 +35,12 @@ char *task_mem(struct mm_struct *mm, cha
 	data = mm->total_vm - mm->shared_vm - mm->stack_vm;
 	text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK)) >> 10;
 	lib = (mm->exec_vm << (PAGE_SHIFT-10)) - text;
+
+	for(this_vma = mm->mmap;this_vma;this_vma = this_vma->vm_next)
+	{
+		swp_out_pages += atomic_read(&(this_vma)->swapped_out);
+	}
+
 	buffer += sprintf(buffer,
 		"VmPeak:\t%8lu kB\n"
 		"VmSize:\t%8lu kB\n"
@@ -43,7 +51,8 @@ char *task_mem(struct mm_struct *mm, cha
 		"VmStk:\t%8lu kB\n"
 		"VmExe:\t%8lu kB\n"
 		"VmLib:\t%8lu kB\n"
-		"VmPTE:\t%8lu kB\n",
+		"VmPTE:\t%8lu kB\n"
+		"VmSwp:\t%8lu kB\n",
 		hiwater_vm << (PAGE_SHIFT-10),
 		(total_vm - mm->reserved_vm) << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
@@ -51,7 +60,8 @@ char *task_mem(struct mm_struct *mm, cha
 		total_rss << (PAGE_SHIFT-10),
 		data << (PAGE_SHIFT-10),
 		mm->stack_vm << (PAGE_SHIFT-10), text, lib,
-		(PTRS_PER_PTE*sizeof(pte_t)*mm->nr_ptes) >> 10);
+		(PTRS_PER_PTE*sizeof(pte_t)*mm->nr_ptes) >> 10,
+		swp_out_pages << (PAGE_SHIFT-10) );
 	return buffer;
 }
 
--- include/linux/mm.h.bak	2006-03-28 13:49:02.000000000 +0700
+++ include/linux/mm.h	2006-07-22 19:20:34.000000000 +0700
@@ -111,6 +111,7 @@ struct vm_area_struct {
 #ifdef CONFIG_NUMA
 	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
 #endif
+	atomic_t  swapped_out;	/* swapped out pages in this VMA */
 };
 
 /*
--- mm/rmap.c.bak	2006-03-28 13:49:02.000000000 +0700
+++ mm/rmap.c	2006-07-22 19:19:47.000000000 +0700
@@ -635,6 +635,7 @@ static int try_to_unmap_one(struct page 
 		set_pte_at(mm, address, pte, swp_entry_to_pte(entry));
 		BUG_ON(pte_file(*pte));
 		dec_mm_counter(mm, anon_rss);
+		atomic_inc(&(vma)->swapped_out);
 	} else
 		dec_mm_counter(mm, file_rss);
 
--- mm/memory.c.bak	2006-03-28 13:49:02.000000000 +0700
+++ mm/memory.c	2006-07-25 16:04:42.000000000 +0700
@@ -683,6 +683,7 @@ static unsigned long zap_pte_range(struc
 	} while (pte++, addr += PAGE_SIZE, (addr != end && *zap_work > 0));
 
 	add_mm_rss(mm, file_rss, anon_rss);
+	atomic_sub(anon_rss,&(vma)->swapped_out);
 	pte_unmap_unlock(pte - 1, ptl);
 
 	return addr;
@@ -1928,6 +1929,8 @@ again:
 	/* The page isn't present yet, go ahead with the fault. */
 
 	inc_mm_counter(mm, anon_rss);
+	printk("Reducing swapped_out variable...\n");
+	atomic_dec(&(vma)->swapped_out);
 	pte = mk_pte(page, vma->vm_page_prot);
 	if (write_access && can_share_swap_page(page)) {
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
--- mm/swapfile.c.bak	2006-07-25 18:25:57.000000000 +0700
+++ mm/swapfile.c	2006-07-25 18:43:17.000000000 +0700
@@ -426,6 +426,7 @@ static void unuse_pte(struct vm_area_str
 		unsigned long addr, swp_entry_t entry, struct page *page)
 {
 	inc_mm_counter(vma->vm_mm, anon_rss);
+	atomic_dec(&(vma)->swapped_out);
 	get_page(page);
 	set_pte_at(vma->vm_mm, addr, pte,
 		   pte_mkold(mk_pte(page, vma->vm_page_prot)));

