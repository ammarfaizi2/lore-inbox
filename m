Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135856AbREFVIj>; Sun, 6 May 2001 17:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135857AbREFVIa>; Sun, 6 May 2001 17:08:30 -0400
Received: from mail.inf.elte.hu ([157.181.161.6]:10660 "HELO mail.inf.elte.hu")
	by vger.kernel.org with SMTP id <S135856AbREFVIZ>;
	Sun, 6 May 2001 17:08:25 -0400
Date: Sun, 6 May 2001 23:08:20 +0200 (CEST)
From: BERECZ Szabolcs <szabi@inf.elte.hu>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-mm@kvack.org>
Subject: page_launder() bug
Message-ID: <Pine.A41.4.31.0105062307290.59664-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

there is a bug in page_launder introduced with kernel 2.4.3-ac12.
if the swapfile is on a filesystem, then after swapping out some
pages, the system locks up. sometimes it writes an oops message.
I don't know exactly what's the problem, but with the attached
patch it works. (this is just a reverse patch to go back to
pre 2.4.3-ac12, and it's against 2.4.4-ac5)
please fix the bug, or apply this patch until fixed properly.

a question:
why don't you include lkcd or something like that in the
mainstream kernel? it would be much easier to save those annoying
oopses :)

Bye,
Szabi


diff -Nur linux/mm/vmscan.c linux.swapfix/mm/vmscan.c
--- linux/mm/vmscan.c	Sun May  6 15:59:22 2001
+++ linux.swapfix/mm/vmscan.c	Sun May  6 16:07:09 2001
@@ -448,15 +448,9 @@
 	maxscan = nr_inactive_dirty_pages;
 	while ((page_lru = inactive_dirty_list.prev) != &inactive_dirty_list &&
 				maxscan-- > 0) {
-		int dead_swap_page;
-
 		page = list_entry(page_lru, struct page, lru);
 		zone = page->zone;

-		dead_swap_page =
-			(PageSwapCache(page) &&
-			 page_count(page) == (1 + !!page->buffers));
-
 		/* Wrong page on list?! (list corruption, should not happen) */
 		if (!PageInactiveDirty(page)) {
 			printk("VM: page_launder, wrong page on list.\n");
@@ -467,10 +461,9 @@
 		}

 		/* Page is or was in use?  Move it to the active list. */
-		if (!dead_swap_page &&
-		    (PageTestandClearReferenced(page) || page->age > 0 ||
-		     (!page->buffers && page_count(page) > 1) ||
-		     page_ramdisk(page))) {
+		if (PageTestandClearReferenced(page) || page->age > 0 ||
+				(!page->buffers && page_count(page) > 1) ||
+				page_ramdisk(page)) {
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_active_list(page);
 			continue;
@@ -512,11 +505,8 @@
 			if (!writepage)
 				goto page_active;

-			/* First time through? Move it to the back of the list,
-			 * but not if it is a dead swap page. We want to reap
-			 * those as fast as possible.
-			 */
-			if (!launder_loop && !dead_swap_page) {
+			/* First time through? Move it to the back of the list */
+			if (!launder_loop) {
 				list_del(page_lru);
 				list_add(page_lru, &inactive_dirty_list);
 				UnlockPage(page);

