Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268175AbRG2VTX>; Sun, 29 Jul 2001 17:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268174AbRG2VTN>; Sun, 29 Jul 2001 17:19:13 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:37023 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S268165AbRG2VTA>; Sun, 29 Jul 2001 17:19:00 -0400
Date: Sun, 29 Jul 2001 22:20:16 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hold cow while breaking
In-Reply-To: <Pine.LNX.4.33.0107291350540.937-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0107292212330.1139-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, 29 Jul 2001, Linus Torvalds wrote:
> On Sun, 29 Jul 2001, Hugh Dickins wrote:
> >
> > Sorry for being dense, but I still don't get it.  I thought the
> > down_read on mmap_sem is permitting concurrent faults by other users
> > of the address space (but excluding structural changes to the address
> > space)?  and we haven't locked the page itself, and we've temporarily
> > dropped the page_table_lock.  I just don't see what lock prevents the
> > page from being refaulted in.
> 
> Ehh, you're right. But you're still wrong, I think.
> 
> Because we hold the mm semaphore, nobody can change the mapping on us.
> 
> Which means that even if we first page somthing out and page something
> else in to the same page, that "something else" has to be the same thing.
> See?

Sure, I agree with you on that, but it doesn't let us off the hook.
This isn't necessarily the first reuse of that page: after paging it
out and freeing it, it may have got allocated to some other purpose
and freed again, and then reassigned to the original use.  And while
it held the data from that intermediate use, we may have done the
copy_cow_page from old_page to new_page, and now we come along and
substitute this corrupt new_page for the good old_page.

Hugh

--- linux-2.4.8-pre2/mm/memory.c	Sun Jul 29 08:10:42 2001
+++ linux/mm/memory.c	Sun Jul 29 13:12:20 2001
@@ -862,8 +862,8 @@
 /*
  * We hold the mm semaphore for reading and vma->vm_mm->page_table_lock
  */
-static inline void break_cow(struct vm_area_struct * vma, struct page *	old_page, struct page * new_page, unsigned long address, 
-		pte_t *page_table)
+static inline void break_cow(struct vm_area_struct * vma, struct page * new_page,
+			     unsigned long address, pte_t *page_table)
 {
 	flush_page_to_ram(new_page);
 	flush_cache_page(vma, address);
@@ -935,12 +935,15 @@
 	/*
 	 * Ok, we need to copy. Oh, well..
 	 */
+	if (!PageReserved(old_page))
+		page_cache_get(old_page);
 	spin_unlock(&mm->page_table_lock);
 
 	new_page = alloc_page(GFP_HIGHUSER);
 	if (!new_page)
 		goto no_mem;
 	copy_cow_page(old_page,new_page,address);
+	page_cache_release(old_page);
 
 	/*
 	 * Re-check the pte - we dropped the lock
@@ -949,7 +952,7 @@
 	if (pte_same(*page_table, pte)) {
 		if (PageReserved(old_page))
 			++mm->rss;
-		break_cow(vma, old_page, new_page, address, page_table);
+		break_cow(vma, new_page, address, page_table);
 
 		/* Free the old page.. */
 		new_page = old_page;

