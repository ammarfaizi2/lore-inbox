Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318076AbSIBT2H>; Mon, 2 Sep 2002 15:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318175AbSIBT2H>; Mon, 2 Sep 2002 15:28:07 -0400
Received: from dsl-213-023-021-067.arcor-ip.net ([213.23.21.67]:8845 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318076AbSIBT2G>;
	Mon, 2 Sep 2002 15:28:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Heiko Carstens" <Heiko.Carstens@de.ibm.com>
Subject: Re: Kernel BUG at page_alloc.c:91! (2.4.19)
Date: Mon, 2 Sep 2002 21:35:06 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <OFB29A6613.5FAAE384-ONC1256C28.00430C8B@de.ibm.com>
In-Reply-To: <OFB29A6613.5FAAE384-ONC1256C28.00430C8B@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17lwyY-0004jW-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 September 2002 14:54, Heiko Carstens wrote:
> Hi Daniel,
> 
> >> Looks to me that this function itself has a bug: after the drop_pte 
> label
> >> it is checked if the current page has a mapping. If this is true there 
> is
> >> ...
> >Chances are, you've run into the subtle double-free race I've been 
> working
> >on for the last few days.  Would you like to try this patch as see if it
> >makes a difference?
> >http://nl.linux.org/~phillips/patches/lru.race-2.4.19
> 
> Thanks for the patch but unfortunately it doesn't change the behaviour at
> all. This BUG is still 100% reproducible by just having 1 process which
> allocates memory chunks of 256KB and after each allocation writes to each
> of the pages in order to make them dirty.

Um, no smp --> no free race anyway.  But try the following instead, to
start narrowing down the possibilities:

--- ./vmscan.c	2002-09-02 21:15:17.000000000 +0200
+++ mm/vmscan.c	2002-09-02 21:33:24.000000000 +0200
@@ -82,7 +82,7 @@
 	 */
 	if (PageSwapCache(page)) {
 		entry.val = page->index;
-		swap_duplicate(entry);
+		BUG_ON(!swap_duplicate(entry));
 set_swap_pte:
 		set_pte(page_table, swp_entry_to_pte(entry));
 drop_pte:
@@ -109,8 +109,10 @@
 	 * Basically, this just makes it possible for us to do
 	 * some real work in the future in "refill_inactive()".
 	 */
-	if (page->mapping)
+	if (page->mapping) {
+		BUG_ON( page_count(page) == 1);
 		goto drop_pte;
+	}
 	if (!PageDirty(page))
 		goto drop_pte;
 
