Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261921AbRE3T1r>; Wed, 30 May 2001 15:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261898AbRE3T1h>; Wed, 30 May 2001 15:27:37 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:28175 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S261921AbRE3T10>; Wed, 30 May 2001 15:27:26 -0400
Date: Wed, 30 May 2001 14:51:08 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] reclaim dirty dead swapcache pages 
Message-ID: <Pine.LNX.4.21.0105301420000.5231-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

The following untested patch against 2.4.5-ac2 makes page_launder() free
dead swap cache pages by ignoring their age and/or referenced bits.

refill_inactive_scan() will move those pages to the inactive dirty list
whatever their age/referenced bit.

Testers are welcome (hum, needed). 

Linus,

I gaveup on the writepage() changes because 

1) it would (and it could not) ignore the page age. 
2) changing the API for such a reason on 2.4 is not reasonable, I think. 

I definately want writepage() changed to include the 'priority' argument,
in 2.5. 

--- linux.orig/mm/vmscan.c	Wed May 30 14:51:21 2001
+++ linux/mm/vmscan.c	Wed May 30 16:18:41 2001
@@ -461,6 +461,28 @@
 			continue;
 		}
 
+		/*
+		 * FIXME: this is a hack.
+		 *
+		 * Check for dead swap cache pages and clean
+		 * them as fast as possible, before doing any other checks.
+		 *
+		 * Note: We are guaranteeing that this page will never 
+		 * be touched in the future because a dirty page with no
+		 * other users than the swapcache will never be referenced
+		 * again.
+		 * 
+		 */
+
+		if (PageSwapCache(page) && PageDirty(page) &&
+				(page_count(page) - !!page->buffers) == 1 &&
+				swap_count(page) == 1) { 
+			ClearPageDirty(page);
+			ClearPageReferenced(page);
+			page->age = 0;
+		}
+
+			
 		/* Page is or was in use?  Move it to the active list. */
 		if (PageReferenced(page) || page->age > 0 ||
 				(!page->buffers && page_count(page) > 1) ||
@@ -686,6 +708,21 @@
 			nr_active_pages--;
 			continue;
 		}
+		
+		/*
+		 * FIXME: hack
+		 *
+		 * Special case for dead swap cache pages.
+		 * See comment on page_launder() for more info.
+		 */
+		if (PageSwapCache(page) && PageDirty(page) &&
+				(page_count(page) - !!page->buffers) == 1 &&
+				swap_count(page) == 1) {
+			deactivate_page_nolock(page);
+			nr_deactivated++;
+			continue;
+		}
+
 
 		/* Do aging on the pages. */
 		if (PageTestandClearReferenced(page)) {

