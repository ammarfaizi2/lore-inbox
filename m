Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWCMMDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWCMMDk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 07:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbWCMMDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 07:03:40 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:59620 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751977AbWCMMDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 07:03:40 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: does swsusp suck after resume for you? [was Re: Faster resuming of suspend technology.]
Date: Mon, 13 Mar 2006 23:03:18 +1100
User-Agent: KMail/1.9.1
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, ck@vds.kolivas.org,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060313111326.GA29716@rhlx01.fht-esslingen.de> <20060313113631.GA1736@elf.ucw.cz>
In-Reply-To: <20060313113631.GA1736@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603132303.18758.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2006 22:36, Pavel Machek wrote:
> 4) Congratulations, you are right person to help. Could you test if
> Con's patches help?

Ok this patch is only compile tested only but is reasonably straight forward.
(I have no hardware to test it on atm). It relies on the previous 4 patches I
sent out that update swap prefetch. To make it easier here is a single rolled
up patch that goes on top of 2.6.16-rc6-mm1:

http://ck.kolivas.org/patches/swap-prefetch/2.6.16-rc6-mm1-swap_prefetch_suspend_test.patch

Otherwise the incremental patch is below.

Usual blowing up warnings apply with this sort of patch. If it works well then
/proc/meminfo should show a very large SwapCached value after resume.

Cheers,
Con
---
 include/linux/swap-prefetch.h |    5 ++
 kernel/power/swsusp.c         |    2 
 mm/swap_prefetch.c            |   91 +++++++++++++++++++++++++-----------------
 3 files changed, 62 insertions(+), 36 deletions(-)

Index: linux-2.6.16-rc6-mm1/include/linux/swap-prefetch.h
===================================================================
--- linux-2.6.16-rc6-mm1.orig/include/linux/swap-prefetch.h	2006-03-13 10:05:05.000000000 +1100
+++ linux-2.6.16-rc6-mm1/include/linux/swap-prefetch.h	2006-03-13 22:41:07.000000000 +1100
@@ -33,6 +33,7 @@ extern void add_to_swapped_list(struct p
 extern void remove_from_swapped_list(const unsigned long index);
 extern void delay_swap_prefetch(void);
 extern void prepare_swap_prefetch(void);
+extern void post_resume_swap_prefetch(void);
 
 #else	/* CONFIG_SWAP_PREFETCH */
 static inline void add_to_swapped_list(struct page *__unused)
@@ -50,6 +51,10 @@ static inline void remove_from_swapped_l
 static inline void delay_swap_prefetch(void)
 {
 }
+
+static inline void post_resume_swap_prefetch(void)
+{
+}
 #endif	/* CONFIG_SWAP_PREFETCH */
 
 #endif		/* SWAP_PREFETCH_H_INCLUDED */
Index: linux-2.6.16-rc6-mm1/mm/swap_prefetch.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/mm/swap_prefetch.c	2006-03-13 20:12:24.000000000 +1100
+++ linux-2.6.16-rc6-mm1/mm/swap_prefetch.c	2006-03-13 22:44:30.000000000 +1100
@@ -291,43 +291,17 @@ static void examine_free_limits(void)
 }
 
 /*
- * We want to be absolutely certain it's ok to start prefetching.
+ * Have some hysteresis between where page reclaiming and prefetching
+ * will occur to prevent ping-ponging between them.
  */
-static int prefetch_suitable(void)
+static void set_suitable_nodes(void)
 {
-	unsigned long limit;
 	struct zone *z;
-	int node, ret = 0, test_pagestate = 0;
-
-	/* Purposefully racy */
-	if (test_bit(0, &swapped.busy)) {
-		__clear_bit(0, &swapped.busy);
-		goto out;
-	}
-
-	/*
-	 * get_page_state and above_background_load are expensive so we only
-	 * perform them every SWAP_CLUSTER_MAX prefetched_pages.
-	 * We test to see if we're above_background_load as disk activity
-	 * even at low priority can cause interrupt induced scheduling
-	 * latencies.
-	 */
-	if (!(sp_stat.prefetched_pages % SWAP_CLUSTER_MAX)) {
-		if (above_background_load())
-			goto out;
-		test_pagestate = 1;
-	}
-
-	clear_current_prefetch_free();
 
-	/*
-	 * Have some hysteresis between where page reclaiming and prefetching
-	 * will occur to prevent ping-ponging between them.
-	 */
 	for_each_zone(z) {
 		struct node_stats *ns;
 		unsigned long free;
-		int idx;
+		int node, idx;
 
 		if (!populated_zone(z))
 			continue;
@@ -349,6 +323,45 @@ static int prefetch_suitable(void)
 		}
 		ns->current_free += free;
 	}
+}
+
+/*
+ * We want to be absolutely certain it's ok to start prefetching.
+ */
+static int prefetch_suitable(const int resume)
+{
+	unsigned long limit;
+	int node, ret = 0, test_pagestate = 0;
+
+	if (unlikely(resume)) {
+		clear_current_prefetch_free();
+		set_suitable_nodes();
+		if (!nodes_empty(sp_stat.prefetch_nodes))
+			ret = 1;
+		goto out;
+	}
+
+	/* Purposefully racy */
+	if (test_bit(0, &swapped.busy)) {
+		__clear_bit(0, &swapped.busy);
+		goto out;
+	}
+
+	/*
+	 * get_page_state and above_background_load are expensive so we only
+	 * perform them every SWAP_CLUSTER_MAX prefetched_pages.
+	 * We test to see if we're above_background_load as disk activity
+	 * even at low priority can cause interrupt induced scheduling
+	 * latencies.
+	 */
+	if (!(sp_stat.prefetched_pages % SWAP_CLUSTER_MAX)) {
+		if (above_background_load())
+			goto out;
+		test_pagestate = 1;
+	}
+
+	clear_current_prefetch_free();
+	set_suitable_nodes();
 
 	/*
 	 * We iterate over each node testing to see if it is suitable for
@@ -429,7 +442,7 @@ static inline struct swapped_entry *prev
  * vm is busy, we prefetch to the watermark, or the list is empty or we have
  * iterated over all entries
  */
-static enum trickle_return trickle_swap(void)
+static enum trickle_return trickle_swap(const int resume)
 {
 	enum trickle_return ret = TRICKLE_DELAY;
 	struct swapped_entry *entry;
@@ -438,7 +451,7 @@ static enum trickle_return trickle_swap(
 	 * If laptop_mode is enabled don't prefetch to avoid hard drives
 	 * doing unnecessary spin-ups
 	 */
-	if (!swap_prefetch || laptop_mode)
+	if (!swap_prefetch || (laptop_mode && !resume))
 		return ret;
 
 	examine_free_limits();
@@ -448,7 +461,7 @@ static enum trickle_return trickle_swap(
 		swp_entry_t swp_entry;
 		int node;
 
-		if (!prefetch_suitable())
+		if (!prefetch_suitable(resume))
 			break;
 
 		spin_lock(&swapped.lock);
@@ -491,8 +504,9 @@ static enum trickle_return trickle_swap(
 		entry = prev_swapped_entry(entry);
 		spin_unlock(&swapped.lock);
 
-		if (trickle_swap_cache_async(swp_entry, node) == TRICKLE_DELAY)
-			break;
+		if (trickle_swap_cache_async(swp_entry, node) == TRICKLE_DELAY &&
+			!resume)
+				break;
 	}
 
 	if (sp_stat.prefetched_pages) {
@@ -502,6 +516,11 @@ static enum trickle_return trickle_swap(
 	return ret;
 }
 
+void post_resume_swap_prefetch(void)
+{
+	trickle_swap(1);
+}
+
 static int kprefetchd(void *__unused)
 {
 	set_user_nice(current, 19);
@@ -515,7 +534,7 @@ static int kprefetchd(void *__unused)
 		 * TRICKLE_FAILED implies no entries left - we do not schedule
 		 * a wakeup, and further delay the next one.
 		 */
-		if (trickle_swap() == TRICKLE_FAILED) {
+		if (trickle_swap(0) == TRICKLE_FAILED) {
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule();
 		}
Index: linux-2.6.16-rc6-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/kernel/power/swsusp.c	2006-03-13 10:05:05.000000000 +1100
+++ linux-2.6.16-rc6-mm1/kernel/power/swsusp.c	2006-03-13 22:42:52.000000000 +1100
@@ -49,6 +49,7 @@
 #include <linux/bootmem.h>
 #include <linux/syscalls.h>
 #include <linux/highmem.h>
+#include <linux/swap-prefetch.h>
 
 #include "power.h"
 
@@ -269,5 +270,6 @@ int swsusp_resume(void)
 	touch_softlockup_watchdog();
 	device_power_up();
 	local_irq_enable();
+	post_resume_swap_prefetch();
 	return error;
 }
