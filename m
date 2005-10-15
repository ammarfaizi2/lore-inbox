Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVJOILJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVJOILJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 04:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbVJOILI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 04:11:08 -0400
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:30420 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750706AbVJOILH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 04:11:07 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] mm - implement swap prefetching
Date: Sat, 15 Oct 2005 18:10:53 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
References: <200510110023.02426.kernel@kolivas.org> <200510111648.31504.kernel@kolivas.org> <20051011223419.4250ecf6.akpm@osdl.org>
In-Reply-To: <20051011223419.4250ecf6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OmLUDLSB7YCE526"
Message-Id: <200510151810.54016.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_OmLUDLSB7YCE526
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[snip snip]
On Wed, 12 Oct 2005 15:34, Andrew Morton wrote:
> Why use the "zone with most free pages"?  Generally it would be better to
> use up ZONE_HIGHMEM first: ZONE_NORMAL is valuable.

> I'd just not bother with the locking at all here.

> kthread(), please.

> Might be able to use a boring old wake_up_process() here rather than a
> waitqueue.

> Is the timer actually needed?  Could just do schedule_timeout() in
> kprefetchd()?

Ok how's this look? On top of your patches.

Cheers,
Con

--Boundary-00=_OmLUDLSB7YCE526
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="mm-implement-swap-prefetching-cleanups.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="mm-implement-swap-prefetching-cleanups.patch"

-Convert kprefetchd to kthread().
-Convert timers to schedule_timeouts
-Prefer highmem whenever possible to prefetch into
-Remove locking from reading total_swapcache_pages
-Remove waitqueues

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.14-rc4-ck1/mm/swap_prefetch.c
===================================================================
--- linux-2.6.14-rc4-ck1.orig/mm/swap_prefetch.c	2005-10-14 11:48:46.000000000 +1000
+++ linux-2.6.14-rc4-ck1/mm/swap_prefetch.c	2005-10-15 17:22:13.000000000 +1000
@@ -10,11 +10,12 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/swap.h>
 #include <linux/fs.h>
+#include <linux/swap.h>
+#include <linux/ioprio.h>
+#include <linux/kthread.h>
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
-#include <linux/ioprio.h>
 #include <linux/writeback.h>
 
 /* Time to delay prefetching if vm is busy or prefetching unsuccessful */
@@ -48,9 +49,7 @@ static struct swapped_root swapped = {
 	.count 		= 0,
 };
 
-static struct timer_list prefetch_timer;
-
-static DECLARE_WAIT_QUEUE_HEAD(kprefetchd_wait);
+static task_t *kprefetchd_task;
 
 static unsigned long mapped_limit;	/* Max mapped we will prefetch to */
 static unsigned long last_free = 0;	/* Last total free pages */
@@ -77,16 +76,6 @@ void __init prepare_prefetch(void)
 		swap_prefetch++;
 }
 
-static inline void delay_prefetch_timer(void)
-{
-	mod_timer(&prefetch_timer, jiffies + PREFETCH_DELAY);
-}
-
-static inline void reset_prefetch_timer(void)
-{
-	mod_timer(&prefetch_timer, jiffies + PREFETCH_INTERVAL);
-}
-
 /*
  * We check to see no part of the vm is busy. If it is this will interrupt
  * trickle_swap and wait another PREFETCH_DELAY. Purposefully racy.
@@ -130,11 +119,11 @@ void add_to_swapped_list(unsigned long i
 		error = radix_tree_insert(&swapped.swap_tree, index, entry);
 		if (likely(!error)) {
 			/*
-			 * If this is the first entry the timer needs to be
+			 * If this is the first entry, kprefetchd needs to be
 			 * (re)started
 			 */
 			if (list_empty(&swapped.list))
-				delay_prefetch_timer();
+				wake_up_process(kprefetchd_task);
 			list_add(&entry->swapped_list, &swapped.list);
 			swapped.count++;
 		}
@@ -168,6 +157,13 @@ void remove_from_swapped_list(unsigned l
 	spin_unlock_irqrestore(&swapped.lock, flags);
 }
 
+static inline int high_zone(struct zone *zone)
+{
+	if (zone == NULL)
+		return 0;
+	return is_highmem(zone);
+}
+
 /*
  * Find the zone with the most free pages, recheck the watermarks and
  * then directly allocate the ram. We don't want prefetch to use
@@ -185,16 +181,16 @@ static struct page *prefetch_get_page(vo
 		if (z->present_pages == 0)
 			continue;
 
-		free = z->free_pages;
-
 		/* We don't prefetch into DMA */
 		if (zone_idx(z) == ZONE_DMA)
 			continue;
 
-		/* Select the zone with the most free ram */
-		if (free > most_free) {
-			most_free = free;
-			zone = z;
+		free = z->free_pages;
+		/* Select the zone with the most free ram preferring high */
+		if ((free > most_free && (!high_zone(zone) || high_zone(z))) ||
+			(!high_zone(zone) && high_zone(z))) {
+				most_free = free;
+				zone = z;
 		}
 	}
 
@@ -330,19 +326,12 @@ static int prefetch_suitable(void)
 	if (pending_writes > SWAP_CLUSTER_MAX)
 		goto out;
 
-	/* >2/3 of the ram is mapped, we need some free for pagecache */
-	limit = ps.nr_mapped + ps.nr_slab + pending_writes;
-	if (limit > mapped_limit)
-		goto out;
-
 	/*
-	 * Add swapcache to limit as well, but check this last since it needs
-	 * locking
+	 * >2/3 of the ram is mapped or swapcache, we need some free for
+	 * pagecache
 	 */
-	if (unlikely(!read_trylock(&swapper_space.tree_lock)))
-		goto out;
-	limit += total_swapcache_pages;
-	read_unlock(&swapper_space.tree_lock);
+	limit = ps.nr_mapped + ps.nr_slab + pending_writes +
+		total_swapcache_pages;
 	if (limit > mapped_limit)
 		goto out;
 
@@ -400,68 +389,53 @@ out:
 	return ret;
 }
 
-static int kprefetchd(void *data)
+static int kprefetchd(void *__unused)
 {
-	DEFINE_WAIT(wait);
-
-	daemonize("kprefetchd");
 	set_user_nice(current, 19);
 	/* Set ioprio to lowest if supported by i/o scheduler */
 	sys_ioprio_set(IOPRIO_WHO_PROCESS, 0, IOPRIO_CLASS_IDLE);
 
-	for ( ; ; ) {
+	do {
 		enum trickle_return prefetched;
 
 		try_to_freeze();
-		prepare_to_wait(&kprefetchd_wait, &wait, TASK_INTERRUPTIBLE);
-		schedule();
-		finish_wait(&kprefetchd_wait, &wait);
 
 		/*
-		 * TRICKLE_FAILED implies no entries left - the timer is not
-		 * reset
+		 * TRICKLE_FAILED implies no entries left - we do not schedule
+		 * a wakeup, and further delay the next one.
 		 */
 		prefetched = trickle_swap();
 		switch (prefetched) {
 		case TRICKLE_SUCCESS:
 			last_free = temp_free;
-			reset_prefetch_timer();
+			schedule_timeout_interruptible(PREFETCH_INTERVAL);
 			break;
 		case TRICKLE_DELAY:
 			last_free = 0;
-			delay_prefetch_timer();
+			schedule_timeout_interruptible(PREFETCH_DELAY);
 			break;
 		case TRICKLE_FAILED:
 			last_free = 0;
+			schedule_timeout_interruptible(MAX_SCHEDULE_TIMEOUT);
+			schedule_timeout_interruptible(PREFETCH_DELAY);
 			break;
 		}
-	}
-	return 0;
-}
+	} while (!kthread_should_stop());
 
-/*
- * Wake up kprefetchd. It will reset the timer itself appropriately so no
- * need to do it here
- */
-static void prefetch_wakeup(unsigned long data)
-{
-	if (waitqueue_active(&kprefetchd_wait))
-		wake_up_interruptible(&kprefetchd_wait);
+	return 0;
 }
 
 static int __init kprefetchd_init(void)
 {
-	/*
-	 * Prepare the prefetch timer. It is inactive until entries are placed
-	 * on the swapped_list
-	 */
-	init_timer(&prefetch_timer);
-	prefetch_timer.data = 0;
-	prefetch_timer.function = prefetch_wakeup;
-
-	kernel_thread(kprefetchd, NULL, CLONE_KERNEL);
+	kprefetchd_task = kthread_run(kprefetchd, NULL, "kprefetchd");
 
 	return 0;
 }
 
-module_init(kprefetchd_init)
+static void __exit kprefetchd_exit(void)
+{
+	kthread_stop(kprefetchd_task);
+}
+
+module_init(kprefetchd_init);
+module_exit(kprefetchd_exit);

--Boundary-00=_OmLUDLSB7YCE526--
