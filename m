Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131237AbRCVGZO>; Thu, 22 Mar 2001 01:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131868AbRCVGZE>; Thu, 22 Mar 2001 01:25:04 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:14858 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131237AbRCVGYv>; Thu, 22 Mar 2001 01:24:51 -0500
Date: Wed, 21 Mar 2001 22:23:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mike Galbraith <mikeg@wen-online.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: kswapd deadlock 2.4.3-pre6
In-Reply-To: <Pine.LNX.4.31.0103211223480.9358-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.31.0103212217320.10817-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Mar 2001, Linus Torvalds wrote:
>
> The deadlock implies that somebody scheduled with page_table_lock held.
> Which would be really bad.

..and it is probably do_swap_page().

Despite the name, "lookup_swap_cache()" does more than a lookup - it will
wait for the page that it looked up. And we call it with the
page_table_lock held in do_swap_page().

Ho humm. Does the appended patch fix it for you? Looks obvious enough, but
this bug is actually hidden on true SMP, and I'm too lazy to test with
"num_cpus=1" or something..

		Linus

-----
diff -u --recursive --new-file pre6/linux/mm/memory.c linux/mm/memory.c
--- pre6/linux/mm/memory.c	Tue Mar 20 23:13:03 2001
+++ linux/mm/memory.c	Wed Mar 21 22:21:27 2001
@@ -1031,18 +1031,20 @@
 	struct vm_area_struct * vma, unsigned long address,
 	pte_t * page_table, swp_entry_t entry, int write_access)
 {
-	struct page *page = lookup_swap_cache(entry);
+	struct page *page;
 	pte_t pte;

+	spin_unlock(&mm->page_table_lock);
+	page = lookup_swap_cache(entry);
 	if (!page) {
-		spin_unlock(&mm->page_table_lock);
 		lock_kernel();
 		swapin_readahead(entry);
 		page = read_swap_cache(entry);
 		unlock_kernel();
-		spin_lock(&mm->page_table_lock);
-		if (!page)
+		if (!page) {
+			spin_lock(&mm->page_table_lock);
 			return -1;
+		}

 		flush_page_to_ram(page);
 		flush_icache_page(vma, page);
@@ -1053,13 +1055,13 @@
 	 * Must lock page before transferring our swap count to already
 	 * obtained page count.
 	 */
-	spin_unlock(&mm->page_table_lock);
 	lock_page(page);
-	spin_lock(&mm->page_table_lock);

 	/*
-	 * Back out if somebody else faulted in this pte while we slept.
+	 * Back out if somebody else faulted in this pte while we
+	 * released the page table lock.
 	 */
+	spin_lock(&mm->page_table_lock);
 	if (pte_present(*page_table)) {
 		UnlockPage(page);
 		page_cache_release(page);

