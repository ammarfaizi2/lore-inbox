Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135211AbRDZIrP>; Thu, 26 Apr 2001 04:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135215AbRDZIrG>; Thu, 26 Apr 2001 04:47:06 -0400
Received: from www.wen-online.de ([212.223.88.39]:33803 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S135211AbRDZIqx>;
	Thu, 26 Apr 2001 04:46:53 -0400
Date: Thu, 26 Apr 2001 10:46:20 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.21.0104252352430.1101-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0104261043330.292-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Marcelo Tosatti wrote:

> > (I can get it to under 9 with MUCH extremely ugly tinkering.  I've done
> > this enough to know that I _should_ be able to do 8 1/2 minutes ~easily)
>
> Which kind of changes you're doing to get better performance on this test?

:)

2.4.4.pre7.virgin
real    11m33.589s
user    7m57.790s
sys     0m38.730s

2.4.4.pre7.sillyness
real    9m30.336s
user    7m55.270s
sys     0m38.510s

--- mm/vmscan.c.org	Thu Apr 26 06:35:19 2001
+++ mm/vmscan.c	Thu Apr 26 08:25:52 2001
@@ -72,8 +72,7 @@
 		set_pte(page_table, swp_entry_to_pte(entry));
 drop_pte:
 		mm->rss--;
-		if (!page->age)
-			deactivate_page(page);
+		age_page_down(page);
 		UnlockPage(page);
 		page_cache_release(page);
 		return;
@@ -282,7 +281,7 @@

 	/* Always start by trying to penalize the process that is allocating memory */
 	if (mm)
-		retval = swap_out_mm(mm, swap_amount(mm));
+		return swap_out_mm(mm, swap_amount(mm));

 	/* Then, look at the other mm's */
 	counter = mmlist_nr >> priority;
@@ -642,6 +641,10 @@
 	struct page * page;
 	int maxscan, page_active = 0;
 	int ret = 0;
+	static unsigned long lastscan;
+
+	if (lastscan == jiffies)
+		return 0;

 	/* Take the lock while messing with the list... */
 	spin_lock(&pagemap_lru_lock);
@@ -695,6 +698,7 @@
 				break;
 		}
 	}
+	lastscan = jiffies;
 	spin_unlock(&pagemap_lru_lock);

 	return ret;
@@ -791,35 +795,13 @@
 #define DEF_PRIORITY (6)
 static int refill_inactive(unsigned int gfp_mask, int user)
 {
-	int count, start_count, maxtry;
-
-	count = inactive_shortage() + free_shortage();
-	if (user)
-		count = (1 << page_cluster);
-	start_count = count;
-
-	maxtry = 6;
-	do {
-		if (current->need_resched) {
-			__set_current_state(TASK_RUNNING);
-			schedule();
-		}
-
-		while (refill_inactive_scan(DEF_PRIORITY, 1)) {
-			if (--count <= 0)
-				goto done;
-		}
+	int shortage = inactive_shortage();

+	if (refill_inactive_scan(DEF_PRIORITY, 0) < shortage)
 		/* If refill_inactive_scan failed, try to page stuff out.. */
 		swap_out(DEF_PRIORITY, gfp_mask);

-		if (--maxtry <= 0)
-				return 0;
-
-	} while (inactive_shortage());
-
-done:
-	return (count < start_count);
+	return 0;
 }

 static int do_try_to_free_pages(unsigned int gfp_mask, int user)

