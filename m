Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136016AbRD0NRe>; Fri, 27 Apr 2001 09:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136017AbRD0NRQ>; Fri, 27 Apr 2001 09:17:16 -0400
Received: from www.wen-online.de ([212.223.88.39]:38410 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S136016AbRD0NRL>;
	Fri, 27 Apr 2001 09:17:11 -0400
Date: Fri, 27 Apr 2001 15:16:09 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Ingo Molnar <mingo@elte.hu>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.33.0104261503360.17635-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0104271500300.243-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Rik van Riel wrote:

> On Thu, 26 Apr 2001, Mike Galbraith wrote:
>
> > > > > No.  It livelocked on me with almost all active pages exausted.
> > > > Misspoke.. I didn't try the two mixed.  Rik's patch livelocked me.
> > >
> > > Interesting. The semantics of my patch are practically the same as
> > > those of the stock kernel ... can you get the stock kernel to
> > > livelock on you, too ?
> >
> > Generally no.  Let kswapd continue to run?  Yes, but not always.
>
> OK, then I guess we should find out WHY the thing livelocked...

Hi Rik,

I decided to take a break from pondering input and see why the thing
ran itself into the ground.  Methinks I was sent the wrooong patch :)

--- linux-2.4.4-pre7/mm/vmscan.c.orig	Wed Apr 25 23:59:48 2001
+++ linux-2.4.4-pre7/mm/vmscan.c	Thu Apr 26 00:31:31 2001
@@ -24,6 +24,8 @@

 #include <asm/pgalloc.h>

+#define MAX(a,b) ((a) > (b) ? (a) : (b))
+
 /*
  * The swap-out function returns 1 if it successfully
  * scanned all the pages it was asked to (`count').
@@ -631,17 +633,45 @@
 /**
  * refill_inactive_scan - scan the active list and find pages to deactivate
  * @priority: the priority at which to scan
- * @oneshot: exit after deactivating one page
+ * @count: the number of pages to deactivate
  *
  * This function will scan a portion of the active list to find
  * unused pages, those pages will then be moved to the inactive list.
  */
-int refill_inactive_scan(unsigned int priority, int oneshot)
+int refill_inactive_scan(unsigned int priority, int count)
 {
 	struct list_head * page_lru;
 	struct page * page;
-	int maxscan, page_active = 0;
-	int ret = 0;
+	int maxscan = nr_active_pages >> priority;
+	int page_active = 0;
+
+	/*
+	 * If no count was specified, we do background page aging.
+	 * This is done so, after periods of little VM activity, we
+	 * know which pages to swap out and we can handle load spikes.
+	 * However, if we scan unlimited and deactivate all pages,
+	 * we still wouldn't know which pages to swap ...
+	 *
+	 * The obvious solution is to do less background scanning when
+	 * we have lots of inactive pages and to completely stop if we
+	 * have tons of them...
+	 */
+	if (!count) {
+		int nr_active, nr_inactive;
+
+		/* Active pages can be "hidden" in ptes, take a saner number. */
+		nr_active = MAX(nr_active_pages, num_physpages / 2);
+		nr_inactive = nr_inactive_dirty_pages + nr_free_pages() +
+					nr_inactive_clean_pages();
+
+		if (nr_inactive * 10 < nr_active) {
+			maxscan = nr_active_pages >> 4;
+		} else if (nr_inactive * 3 < nr_active_pages) {
+			maxscan = nr_active >> 8;
+		} else {
+			maxscan = 0;
+		}
+	}

 	/* Take the lock while messing with the list... */
 	spin_lock(&pagemap_lru_lock);
@@ -690,14 +720,13 @@
 			list_del(page_lru);
 			list_add(page_lru, &active_list);
 		} else {
-			ret = 1;
-			if (oneshot)
+			if (--count <= 0)
 				break;
 		}
 	}
 	spin_unlock(&pagemap_lru_lock);

-	return ret;
+	return count;
 }

 /*
@@ -805,10 +834,9 @@
 			schedule();
 		}

-		while (refill_inactive_scan(DEF_PRIORITY, 1)) {
-			if (--count <= 0)
-				goto done;
-		}
+		count -= refill_inactive_scan(DEF_PRIORITY, count);
+		if (--count <= 0)
+			goto done;

 		/* If refill_inactive_scan failed, try to page stuff out.. */
 		swap_out(DEF_PRIORITY, gfp_mask);


