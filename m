Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264176AbRFFVns>; Wed, 6 Jun 2001 17:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264181AbRFFVni>; Wed, 6 Jun 2001 17:43:38 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:53518 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264176AbRFFVna>; Wed, 6 Jun 2001 17:43:30 -0400
Date: Wed, 6 Jun 2001 17:07:41 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: [PATCH] Reap dead swap cache earlier v2
Message-ID: <Pine.LNX.4.21.0106061705250.3769-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

As suggested by Linus, I've cleaned the reapswap code to be contained
inside an inline function. (yes, the if statement is really ugly) 

Tested and against 2.4.6pre1. 



--- linux.orig/mm/vmscan.c	Wed Jun  6 18:16:45 2001
+++ linux/mm/vmscan.c	Wed Jun  6 18:28:26 2001
@@ -407,6 +407,27 @@
 	memory_pressure++;
 	return page;
 }
+/*
+ * Check for dead swap cache pages and clean them, forcing 
+ * those pages to be freed earlier.
+ */
+static inline int clean_dead_swap_page (struct page* page)
+{
+	int ret = 0;
+	if (!TryLockPage (page)) { 
+		if (PageSwapCache(page) && PageDirty(page) &&
+				(page_count(page) - !!page->buffers) == 1 &&
+				swap_count(page) == 1) { 
+			ClearPageDirty(page);
+			ClearPageReferenced(page);
+			page->age = 0;
+			ret = 1;
+		}
+		UnlockPage(page);
+	}
+	return ret;
+}
+
 
 /**
  * page_launder - clean dirty inactive pages, move to inactive_clean list
@@ -456,6 +477,12 @@
 			continue;
 		}
 
+		/*
+		 * Check for dead swap cache pages 
+		 * before doing any other checks.
+		 */
+		clean_dead_swap_page(page);
+			
 		/* Page is or was in use?  Move it to the active list. */
 		if (PageReferenced(page) || page->age > 0 ||
 				page->zone->free_pages > page->zone->pages_high ||
@@ -666,6 +693,15 @@
 			printk("VM: refill_inactive, wrong page on list.\n");
 			list_del(page_lru);
 			nr_active_pages--;
+			continue;
+		}
+		
+		/*
+		 * Special case for dead swap cache pages.
+		 */
+		if (clean_dead_swap_page(page)) {
+			deactivate_page_nolock(page);
+			nr_deactivated++;
 			continue;
 		}
 

