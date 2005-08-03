Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVHCL3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVHCL3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 07:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVHCL3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 07:29:50 -0400
Received: from silver.veritas.com ([143.127.12.111]:14199 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S262148AbVHCL3t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 07:29:49 -0400
Date: Wed, 3 Aug 2005 12:31:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Robin Holt <holt@sgi.com>
cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, Roland McGrath <roland@redhat.com>,
       linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <20050803082414.GB6384@lnx-holt.americas.sgi.com>
Message-ID: <Pine.LNX.4.61.0508031223590.13845@goblin.wat.veritas.com>
References: <20050801032258.A465C180EC0@magilla.sf.frob.com>
 <42EDDB82.1040900@yahoo.com.au> <Pine.LNX.4.58.0508010833250.14342@g5.osdl.org>
 <Pine.LNX.4.58.0508011116180.3341@g5.osdl.org> <20050803082414.GB6384@lnx-holt.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Aug 2005 11:29:48.0369 (UTC) FILETIME=[A7ECEC10:01C5981E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Aug 2005, Robin Holt wrote:
> On Mon, Aug 01, 2005 at 11:18:42AM -0700, Linus Torvalds wrote:
> > 
> > Can somebody who saw the problem in the first place please verify?
> 
> Unfortunately, I can not get the user test to run against anything but the
> SLES9 SP2 kernel.  I took the commit 4ceb5db9757aaeadcf8fbbf97d76bd42aa4df0d6
> and applied that diff to the SUSE kernel.  It does fix the problem the
> customer reported.

Thanks for getting that tried, Robin, but I'm afraid you hadn't got far
enough down your mailbox.  There's a couple of flaws with Linus' patch
above, one with respect to fork and one with respect to s390, so we're
now intending to apply my patch below on top of Linus' (I see Nick has
now come up with some refinement to mine, test his if you prefer it).
Sorry to mess you back and forth, but 4ceb...f0d6 itself won't do, so
we do rather need your customer to retest with the patch below too.

Thanks,
Hugh

Checking pte_dirty instead of pte_write in __follow_page is problematic
for s390, and for copy_one_pte which leaves dirty when clearing write.

So revert __follow_page to check pte_write as before, and let do_wp_page
pass back a special code VM_FAULT_WRITE to say it has done its full job
(whereas VM_FAULT_MINOR when it backs out on race): once get_user_pages
receives this value, it no longer requires pte_write in __follow_page.

But most callers of handle_mm_fault, in the various architectures, have
switch statements which do not expect this new case.  To avoid changing
them all in a hurry, only pass back VM_FAULT_WRITE when write_access arg
says VM_FAULT_WRITE_EXPECTED - chosen as -1 since some arches pass
write_access as a boolean, some as a bitflag, but none as -1.

Yes, we do have a call to do_wp_page from do_swap_page, but no need to
change that: in rare case it's needed, another do_wp_page will follow.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.13-rc5/include/linux/mm.h	2005-08-02 12:07:14.000000000 +0100
+++ linux/include/linux/mm.h	2005-08-02 21:14:58.000000000 +0100
@@ -629,6 +629,9 @@ static inline int page_mapped(struct pag
 #define VM_FAULT_SIGBUS	0
 #define VM_FAULT_MINOR	1
 #define VM_FAULT_MAJOR	2
+#define VM_FAULT_WRITE	3	/* special case for get_user_pages */
+
+#define VM_FAULT_WRITE_EXPECTED	(-1)	/* only for get_user_pages */
 
 #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
 
--- 2.6.13-rc5/mm/memory.c	2005-08-02 12:07:23.000000000 +0100
+++ linux/mm/memory.c	2005-08-02 21:14:26.000000000 +0100
@@ -811,15 +811,18 @@ static struct page *__follow_page(struct
 	pte = *ptep;
 	pte_unmap(ptep);
 	if (pte_present(pte)) {
-		if (write && !pte_dirty(pte))
+		if (write && !pte_write(pte))
 			goto out;
 		if (read && !pte_read(pte))
 			goto out;
 		pfn = pte_pfn(pte);
 		if (pfn_valid(pfn)) {
 			page = pfn_to_page(pfn);
-			if (accessed)
+			if (accessed) {
+				if (write && !pte_dirty(pte) &&!PageDirty(page))
+					set_page_dirty(page);
 				mark_page_accessed(page);
+			}
 			return page;
 		}
 	}
@@ -941,10 +944,11 @@ int get_user_pages(struct task_struct *t
 		}
 		spin_lock(&mm->page_table_lock);
 		do {
+			int write_access = write? VM_FAULT_WRITE_EXPECTED: 0;
 			struct page *page;
 
 			cond_resched_lock(&mm->page_table_lock);
-			while (!(page = follow_page(mm, start, write))) {
+			while (!(page = follow_page(mm, start, write_access))) {
 				/*
 				 * Shortcut for anonymous pages. We don't want
 				 * to force the creation of pages tables for
@@ -957,7 +961,16 @@ int get_user_pages(struct task_struct *t
 					break;
 				}
 				spin_unlock(&mm->page_table_lock);
-				switch (handle_mm_fault(mm,vma,start,write)) {
+				switch (handle_mm_fault(mm, vma, start,
+							write_access)) {
+				case VM_FAULT_WRITE:
+					/*
+					 * do_wp_page has broken COW when
+					 * necessary, even if maybe_mkwrite
+					 * decided not to set pte_write
+					 */
+					write_access = 0;
+					/* FALLTHRU */
 				case VM_FAULT_MINOR:
 					tsk->min_flt++;
 					break;
@@ -1220,6 +1233,7 @@ static int do_wp_page(struct mm_struct *
 	struct page *old_page, *new_page;
 	unsigned long pfn = pte_pfn(pte);
 	pte_t entry;
+	int ret;
 
 	if (unlikely(!pfn_valid(pfn))) {
 		/*
@@ -1247,7 +1261,7 @@ static int do_wp_page(struct mm_struct *
 			lazy_mmu_prot_update(entry);
 			pte_unmap(page_table);
 			spin_unlock(&mm->page_table_lock);
-			return VM_FAULT_MINOR;
+			return VM_FAULT_WRITE;
 		}
 	}
 	pte_unmap(page_table);
@@ -1274,6 +1288,7 @@ static int do_wp_page(struct mm_struct *
 	/*
 	 * Re-check the pte - we dropped the lock
 	 */
+	ret = VM_FAULT_MINOR;
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
 	if (likely(pte_same(*page_table, pte))) {
@@ -1290,12 +1305,13 @@ static int do_wp_page(struct mm_struct *
 
 		/* Free the old page.. */
 		new_page = old_page;
+		ret = VM_FAULT_WRITE;
 	}
 	pte_unmap(page_table);
 	page_cache_release(new_page);
 	page_cache_release(old_page);
 	spin_unlock(&mm->page_table_lock);
-	return VM_FAULT_MINOR;
+	return ret;
 
 no_new_page:
 	page_cache_release(old_page);
@@ -1985,9 +2001,13 @@ static inline int handle_pte_fault(struc
 	}
 
 	if (write_access) {
-		if (!pte_write(entry))
-			return do_wp_page(mm, vma, address, pte, pmd, entry);
-
+		if (!pte_write(entry)) {
+			int ret = do_wp_page(mm, vma, address, pte, pmd, entry);
+			if (ret == VM_FAULT_WRITE &&
+			    write_access != VM_FAULT_WRITE_EXPECTED)
+				ret = VM_FAULT_MINOR;
+			return ret;
+		}
 		entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
