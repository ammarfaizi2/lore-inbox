Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVHBUxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVHBUxs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 16:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVHBUxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 16:53:48 -0400
Received: from gold.veritas.com ([143.127.12.110]:39762 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S261771AbVHBUxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 16:53:46 -0400
Date: Tue, 2 Aug 2005 21:55:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Robin Holt <holt@sgi.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <Pine.LNX.4.58.0508021244250.3341@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0508022150530.10815@goblin.wat.veritas.com>
References: <OF3BCB86B7.69087CF8-ON42257051.003DCC6C-42257051.00420E16@de.ibm.com>
 <Pine.LNX.4.58.0508020829010.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508021645050.4921@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508020911480.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508021809530.5659@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508021127120.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508022001420.6744@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508021244250.3341@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 02 Aug 2005 20:53:45.0640 (UTC) FILETIME=[4618FA80:01C597A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2005, Linus Torvalds wrote:
> 
> Go for it, I think whatever we do won't be wonderfully pretty.

Here we are: get_user_pages quite untested, let alone the racy case,
but I think it should work.  Please all hack it around as you see fit,
I'll check mail when I get home, but won't be very responsive...


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
