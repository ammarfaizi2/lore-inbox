Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262272AbRENEBL>; Mon, 14 May 2001 00:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262278AbRENEBB>; Mon, 14 May 2001 00:01:01 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:24327 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262247AbRENEAu>;
	Mon, 14 May 2001 00:00:50 -0400
Date: Mon, 14 May 2001 01:00:39 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] filemap.c fixes
Message-ID: <Pine.LNX.4.21.0105140057180.4671-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are a filemap.c fix and a slight addition:

1) __find_page_nolock should only set the referenced bit
   on an active page, otherwise a number of subsequent
   reads from the same page within one page scan interval
   can SEVERELY mess up page aging to the disadvantage of
   the other pages in the system ...
   just setting the referenced bit on the page makes the
   aging a lot fairer

2) in drop_behind() we first increase the page age and
   will then proceed to deactivate the page again; better
   have a simpler help function for this ... note that this
   help function could also be used for eg. ->writepage()
   write clustering code

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)



--- linux-2.4.5-pre1/mm/filemap.c.orig	Mon May 14 00:55:53 2001
+++ linux-2.4.5-pre1/mm/filemap.c	Mon May 14 00:56:03 2001
@@ -299,13 +299,14 @@
 			break;
 	}
 	/*
-	 * Touching the page may move it to the active list.
-	 * If we end up with too few inactive pages, we wake
-	 * up kswapd.
+	 * Mark the page referenced, moving inactive pages to the
+	 * active list.
 	 */
-	age_page_up(page);
-	if (inactive_shortage() > inactive_target / 2 && free_shortage())
-			wakeup_kswapd();
+	if (!PageActive(page))
+		activate_page(page);
+	else
+		SetPageReferenced(page);
+
 not_found:
 	return page;
 }
@@ -783,8 +784,7 @@
 	 */
 	spin_lock(&pagecache_lock);
 	while (--index >= start) {
-		hash = page_hash(mapping, index);
-		page = __find_page_nolock(mapping, index, *hash);
+		page = __find_page_simple(mapping, index);
 		if (!page)
 			break;
 		deactivate_page(page);

