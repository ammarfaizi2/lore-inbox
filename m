Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268544AbSIRV0R>; Wed, 18 Sep 2002 17:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268545AbSIRV0Q>; Wed, 18 Sep 2002 17:26:16 -0400
Received: from packet.digeo.com ([12.110.80.53]:53244 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268544AbSIRV0K>;
	Wed, 18 Sep 2002 17:26:10 -0400
Message-ID: <3D88F099.81A50A89@digeo.com>
Date: Wed, 18 Sep 2002 14:31:05 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       "lse-tech@lists.sourceforge.net" <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.35-mm1
References: <3D858515.ED128C76@digeo.com> <20020917160722.G39@toy.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Sep 2002 21:31:05.0373 (UTC) FILETIME=[B1C15CD0:01C25F5A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> > url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.35/2.5.35-mm1/
> >
> > Significant rework of the new sleep/wakeup code - make it look totally
> > different from the current APIs to avoid confusion, and to make it
> > simpler to use.
> 
> Did you add any hooks to allow me to free memory for swsusp?

I just did then.  You'll need to call

	freed = shrink_all_memory(99);

to free up 99 pages.  It returns the number which it actually
freed.  If that's not 99 then it's time to give up.  There is
no oom-killer in this code path.

I haven't tested it yet.  And it's quite a long way back in the
queue I'm afraid - it has a dependency chain, and I prefer to
send stuff to Linus which has been tested for a couple of weeks, and
hasn't changed for one week.

Can you use the allocate-lots-then-free-it trick in the meanwhile?



 include/linux/swap.h |    1 +
 mm/vmscan.c          |   46 ++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 41 insertions, 6 deletions

--- 2.5.36/mm/vmscan.c~swsusp-feature	Wed Sep 18 13:55:20 2002
+++ 2.5.36-akpm/mm/vmscan.c	Wed Sep 18 14:29:13 2002
@@ -694,12 +694,19 @@ try_to_free_pages(struct zone *classzone
 }
 
 /*
- * kswapd will work across all this node's zones until they are all at
- * pages_high.
+ * For kswapd, balance_pgdat() will work across all this node's zones until
+ * they are all at pages_high.
+ *
+ * If `nr_pages' is non-zero then it is the number of pages which are to be
+ * reclaimed, regardless of the zone occupancies.  This is a software suspend
+ * special.
+ *
+ * Returns the number of pages which were actually freed.
  */
-static void kswapd_balance_pgdat(pg_data_t *pgdat)
+static int balance_pgdat(pg_data_t *pgdat, int nr_pages)
 {
-	int priority = DEF_PRIORITY;
+	int to_free = nr_pages;
+	int priority;
 	int i;
 
 	for (priority = DEF_PRIORITY; priority; priority--) {
@@ -712,13 +719,15 @@ static void kswapd_balance_pgdat(pg_data
 			int to_reclaim;
 
 			to_reclaim = zone->pages_high - zone->free_pages;
+			if (nr_pages && to_free > 0)
+				to_reclaim = min(to_free, SWAP_CLUSTER_MAX*8);
 			if (to_reclaim <= 0)
 				continue;
 			success = 0;
 			max_scan = zone->nr_inactive >> priority;
 			if (max_scan < to_reclaim * 2)
 				max_scan = to_reclaim * 2;
-			shrink_zone(zone, max_scan, GFP_KSWAPD,
+			to_free -= shrink_zone(zone, max_scan, GFP_KSWAPD,
 					to_reclaim, &nr_mapped);
 			shrink_slab(max_scan + nr_mapped, GFP_KSWAPD);
 		}
@@ -726,6 +735,7 @@ static void kswapd_balance_pgdat(pg_data
 			break;	/* All zones are at pages_high */
 		blk_congestion_wait(WRITE, HZ/4);
 	}
+	return nr_pages - to_free;
 }
 
 /*
@@ -772,10 +782,34 @@ int kswapd(void *p)
 		prepare_to_wait(&pgdat->kswapd_wait, &wait, TASK_INTERRUPTIBLE);
 		schedule();
 		finish_wait(&pgdat->kswapd_wait, &wait);
-		kswapd_balance_pgdat(pgdat);
+		balance_pgdat(pgdat, 0);
 		blk_run_queues();
 	}
 }
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
+/*
+ * Try to free `nr_pages' of memory, system-wide.  Returns the number of freed
+ * pages.
+ */
+int shrink_all_memory(int nr_pages)
+{
+	pg_data_t *pgdat;
+	int nr_to_free = nr_pages;
+	int ret = 0;
+
+	for_each_pgdat(pgdat) {
+		int freed;
+
+		freed = balance_pgdat(pgdat, nr_to_free);
+		ret += freed;
+		nr_to_free -= freed;
+		if (nr_to_free <= 0)
+			break;
+	}
+	return ret;
+}
+#endif
 
 static int __init kswapd_init(void)
 {
--- 2.5.36/include/linux/swap.h~swsusp-feature	Wed Sep 18 14:03:01 2002
+++ 2.5.36-akpm/include/linux/swap.h	Wed Sep 18 14:16:29 2002
@@ -163,6 +163,7 @@ extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
 extern int try_to_free_pages(struct zone *, unsigned int, unsigned int);
+int shrink_all_memory(int nr_pages);
 
 /* linux/mm/page_io.c */
 int swap_readpage(struct file *file, struct page *page);

.
