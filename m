Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274487AbRIVJT7>; Sat, 22 Sep 2001 05:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274534AbRIVJTt>; Sat, 22 Sep 2001 05:19:49 -0400
Received: from [195.223.140.107] ([195.223.140.107]:28403 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274487AbRIVJTg>;
	Sat, 22 Sep 2001 05:19:36 -0400
Date: Sat, 22 Sep 2001 11:19:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>,
        "Randy.Dunlap" <rddunlap@osdlab.org>
Subject: Re: 2.4.10pre VM changes: Potential race condition on swap code
Message-ID: <20010922111953.B29543@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0109141456410.4708-100000@freak.distro.conectiva> <Pine.LNX.4.21.0109142125120.2124-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0109142125120.2124-100000@localhost.localdomain>; from hugh@veritas.com on Fri, Sep 14, 2001 at 10:55:35PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2001 at 10:55:35PM +0100, Hugh Dickins wrote:
> CPU0					CPU1
> 
> do_swap_page's lookup of entry
> doesn't find it in the cache, so
> drops page_table lock, waits for BKL.
> 					Another thread faults on the same
> 					page, suppose this is the one which
> 					wins BKL, proceeds without delay
> 					to replace entry by pte, notices
> 					exclusive swap page and vm_swap_full,
> 					deletes entry from swap cache and
> 					swap_frees it completely.
> Gets BKL, tries swapin_readahead,
> but for simplicity let's suppose
> that does nothing at all (e.g.
> entry is for page 1 of swap -
> which valid_swaphandles adjusts
> to 0, but 0 always SWAP_MAP_BAD
> so it breaks immediately).  So
> "bare" read_swap_cache_async.
> 					Due to some shortage, enters try_to_
> 					free_pages, down to try_to_swap_out,
> 					get_swap_page gives entry just freed.
> swap_duplicate
> 					add_to_swap_cache
> add_to_swap_cache

What do you think about this temporary fix? (ok not very nice either, but
much much simpler... ignoring swapoff races, but I don't care about
swapoff at the moment, we can sort it out later, I'd just like to know
if this is what Randy is experiencing)

Randy, can you apply this one on top of pre14 and try if you still get
the SIGILL from the X server with Andrew's workload? if that's not
enough to fix your problem can you check if you have any shm/tmpfs in
use just in case?

--- 2.4.10pre14aa1/mm/memory.c.~1~	Sat Sep 22 08:29:47 2001
+++ 2.4.10pre14aa1/mm/memory.c	Sat Sep 22 10:11:43 2001
@@ -1123,6 +1123,12 @@
 	pte_t pte;
 	int ret = 1;
 
+	/*
+	 * With threads make sure the swap entry won't go
+	 * away under read_swap_cache_async().
+	 */
+	swap_duplicate(entry);
+
 	spin_unlock(&mm->page_table_lock);
 	page = lookup_swap_cache(entry);
 	if (!page) {
@@ -1131,6 +1137,7 @@
 		page = read_swap_cache_async(entry);
 		unlock_kernel();
 		if (!page) {
+			swap_free(entry);
 			spin_lock(&mm->page_table_lock);
 			/*
 			 * Back out if somebody else faulted in this pte while
@@ -1158,6 +1165,7 @@
 	if (!pte_same(*page_table, orig_pte)) {
 		UnlockPage(page);
 		page_cache_release(page);
+		swap_free(entry);
 		return 1;
 	}
 		
@@ -1165,7 +1173,7 @@
 	mm->rss++;
 	pte = mk_pte(page, vma->vm_page_prot);
 
-	swap_free(entry);
+	__swap_free(entry, 2);
 	if (exclusive_swap_page(page)) {
 		if (vma->vm_flags & VM_WRITE)
 			pte = pte_mkwrite(pte);

(Hugh, from my part I'm queueing all other non critical patches for 26
Sep, I don't have time to check them right now, sorry)

Andrea
