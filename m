Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136786AbREBAet>; Tue, 1 May 2001 20:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136788AbREBAej>; Tue, 1 May 2001 20:34:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31616 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136786AbREBAeg>;
	Tue, 1 May 2001 20:34:36 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15087.22036.811357.526981@pizda.ninka.net>
Date: Tue, 1 May 2001 17:34:28 -0700 (PDT)
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "J . A . Magallon" <jamagallon@able.es>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Wakko Warner <wakko@animx.eu.org>,
        Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <Pine.LNX.4.21.0105012119110.19012-100000@imladris.rielhome.conectiva>
In-Reply-To: <20010501140003.A28747@redhat.com>
	<Pine.LNX.4.21.0105012119110.19012-100000@imladris.rielhome.conectiva>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rik van Riel writes:
 > Then we will be scanning through memory looking for something to
 > swap out (otherwise we'd not be in need of swap space, right?).
 > At this point we can simply free up swap entries while scanning
 > through memory looking for stuff to swap out.

Sounds a lot like my patch I posted a few weeks ago:

--- mm/vmscan.c.~1~	Wed Apr 11 19:05:59 2001
+++ mm/vmscan.c	Thu Apr 12 17:19:51 2001
@@ -441,8 +441,14 @@
 	maxscan = nr_inactive_dirty_pages;
 	while ((page_lru = inactive_dirty_list.prev) != &inactive_dirty_list &&
 				maxscan-- > 0) {
+		int dead_swap_page;
+
 		page = list_entry(page_lru, struct page, lru);
 
+		dead_swap_page =
+			(PageSwapCache(page) &&
+			 page_count(page) == (1 + !!page->buffers));
+
 		/* Wrong page on list?! (list corruption, should not happen) */
 		if (!PageInactiveDirty(page)) {
 			printk("VM: page_launder, wrong page on list.\n");
@@ -453,9 +459,10 @@
 		}
 
 		/* Page is or was in use?  Move it to the active list. */
-		if (PageTestandClearReferenced(page) || page->age > 0 ||
-				(!page->buffers && page_count(page) > 1) ||
-				page_ramdisk(page)) {
+		if (!dead_swap_page &&
+		    (PageTestandClearReferenced(page) || page->age > 0 ||
+		     (!page->buffers && page_count(page) > 1) ||
+		     page_ramdisk(page))) {
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_active_list(page);
 			continue;
@@ -481,8 +488,11 @@
 			if (!writepage)
 				goto page_active;
 
-			/* First time through? Move it to the back of the list */
-			if (!launder_loop) {
+			/* First time through? Move it to the back of the list,
+			 * but not if it is a dead swap page. We want to reap
+			 * those as fast as possible.
+			 */
+			if (!launder_loop && !dead_swap_page) {
 				list_del(page_lru);
 				list_add(page_lru, &inactive_dirty_list);
 				UnlockPage(page);
