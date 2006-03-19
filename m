Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWCSPdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWCSPdX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 10:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWCSPdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 10:33:22 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:29600 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932138AbWCSPdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 10:33:21 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Date: Mon, 20 Mar 2006 02:32:40 +1100
User-Agent: KMail/1.9.1
Cc: ck list <ck@vds.kolivas.org>, Andrew Morton <akpm@osdl.org>,
       "Rafael Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       linux-mm@kvack.org
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 746
Subject: [PATCH][2/3] mm: swap prefetch aggressive mode
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200603200232.41473.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add an "aggressive" mode to swap prefetch that overrides most of the checks
that prevent swap prefetch from doing any prefetching when the system is not
idle. Make it a transient bit that can be set in the /proc tunable which
makes it a use once setting - the most likely way such a mode will be useful.

Export the aggressive_swap_prefetch function to allow other code to set it
if it is deemed suitable.

Such a mode would be useful, for example, immediately after resuming from
suspend-to-disk.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 Documentation/sysctl/vm.txt   |   15 ++++
 include/linux/swap-prefetch.h |    5 +
 mm/swap_prefetch.c            |  130 +++++++++++++++++++++++++++++-------------
 3 files changed, 112 insertions(+), 38 deletions(-)

Index: linux-2.6.16-rc6-mm2/Documentation/sysctl/vm.txt
===================================================================
--- linux-2.6.16-rc6-mm2.orig/Documentation/sysctl/vm.txt	2006-03-20 02:15:54.000000000 +1100
+++ linux-2.6.16-rc6-mm2/Documentation/sysctl/vm.txt	2006-03-20 02:20:34.000000000 +1100
@@ -188,4 +188,19 @@ memory subsystem has been extremely idle
 copying back pages from swap into the swapcache and keep a copy in swap. In
 practice it can take many minutes before the vm is idle enough.
 
+This is value ORed together of
+1	= Normal background swap prefetching when load is light
+2	= Aggressively swap prefetch as much as possible
+
+ie Setting the value to 3 will prefetch aggressively then drop to 1. This
+is useful for doing aggressive prefetching for short periods in scripts
+such as after resuming from software suspend. Setting the value to 2 will
+prefetch aggressively as much as it can and then disable any further swap
+prefetching.
+
+Note that setting this to 0 disables even storing a list of swapped pages (to
+minimise overhead) which means that if significant swapping has occurred with
+swap_prefetch unset and then it is enabled, there is nothing that can be
+prefetched.
+
 The default value is 1.
Index: linux-2.6.16-rc6-mm2/mm/swap_prefetch.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/mm/swap_prefetch.c	2006-03-20 02:15:54.000000000 +1100
+++ linux-2.6.16-rc6-mm2/mm/swap_prefetch.c	2006-03-20 02:20:34.000000000 +1100
@@ -27,8 +27,19 @@
  */
 #define PREFETCH_DELAY	(HZ * 5)
 
-/* sysctl - enable/disable swap prefetching */
-int swap_prefetch __read_mostly = 1;
+#define PREFETCH_NORMAL		(1 << 0)
+#define PREFETCH_AGGRESSIVE 	(1 << 1)
+
+/*
+ * sysctl - enable/disable swap prefetching bits
+ * This is composed of the bitflags PREFETCH_NORMAL and PREFETCH_AGGRESSIVE.
+ * Once PREFETCH_AGGRESSIVE is set, swap prefetching will be peformed as much
+ * as possible irrespective of load conditions and then the
+ * PREFETCH_AGGRESSIVE bit will be unset.
+ */
+int swap_prefetch __read_mostly = PREFETCH_NORMAL;
+
+#define aggressive_prefetch	(unlikely(swap_prefetch & PREFETCH_AGGRESSIVE))
 
 struct swapped_root {
 	unsigned long		busy;		/* vm busy */
@@ -291,43 +302,17 @@ static void examine_free_limits(void)
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
-
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
@@ -349,6 +334,45 @@ static int prefetch_suitable(void)
 		}
 		ns->current_free += free;
 	}
+}
+
+/*
+ * We want to be absolutely certain it's ok to start prefetching.
+ */
+static int prefetch_suitable(void)
+{
+	unsigned long limit;
+	int node, ret = 0, test_pagestate = 0;
+
+	if (aggressive_prefetch) {
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
@@ -421,6 +445,17 @@ static inline struct swapped_entry *prev
 		struct swapped_entry, swapped_list);
 }
 
+static unsigned long pages_prefetched(void)
+{
+	unsigned long pages = sp_stat.prefetched_pages;
+
+	if (pages) {
+		lru_add_drain();
+		sp_stat.prefetched_pages = 0;
+	}
+	return pages;
+}
+
 /*
  * trickle_swap is the main function that initiates the swap prefetching. It
  * first checks to see if the busy flag is set, and does not prefetch if it
@@ -438,7 +473,7 @@ static enum trickle_return trickle_swap(
 	 * If laptop_mode is enabled don't prefetch to avoid hard drives
 	 * doing unnecessary spin-ups
 	 */
-	if (!swap_prefetch || laptop_mode)
+	if (!swap_prefetch || (laptop_mode && !aggressive_prefetch))
 		return ret;
 
 	examine_free_limits();
@@ -474,6 +509,14 @@ static enum trickle_return trickle_swap(
 			 * delay attempting further prefetching.
 			 */
 			spin_unlock(&swapped.lock);
+			if (aggressive_prefetch) {
+				/*
+				 * If we're prefetching aggressively and
+				 * making progress then don't give up.
+				 */
+				if (pages_prefetched())
+					continue;
+			}
 			break;
 		}
 
@@ -491,14 +534,15 @@ static enum trickle_return trickle_swap(
 		entry = prev_swapped_entry(entry);
 		spin_unlock(&swapped.lock);
 
-		if (trickle_swap_cache_async(swp_entry, node) == TRICKLE_DELAY)
+		if (trickle_swap_cache_async(swp_entry, node) == TRICKLE_DELAY &&
+		    !aggressive_prefetch)
 			break;
 	}
 
-	if (sp_stat.prefetched_pages) {
-		lru_add_drain();
-		sp_stat.prefetched_pages = 0;
-	}
+	/* Return value of pages_prefetched irrelevant here */
+	pages_prefetched();
+	if (aggressive_prefetch)
+		swap_prefetch &= ~PREFETCH_AGGRESSIVE;
 	return ret;
 }
 
@@ -558,6 +602,16 @@ void __init prepare_swap_prefetch(void)
 	}
 }
 
+/*
+ * This exported function sets the PREFETCH_AGGRESSIVE flag but only if there
+ * are entries to prefetch.
+ */
+void aggressive_swap_prefetch(void)
+{
+	if (swapped.count)
+		swap_prefetch |= PREFETCH_AGGRESSIVE;
+}
+
 static int __init kprefetchd_init(void)
 {
 	kprefetchd_task = kthread_run(kprefetchd, NULL, "kprefetchd");
Index: linux-2.6.16-rc6-mm2/include/linux/swap-prefetch.h
===================================================================
--- linux-2.6.16-rc6-mm2.orig/include/linux/swap-prefetch.h	2006-03-20 02:15:54.000000000 +1100
+++ linux-2.6.16-rc6-mm2/include/linux/swap-prefetch.h	2006-03-20 02:20:34.000000000 +1100
@@ -33,6 +33,7 @@ extern void add_to_swapped_list(struct p
 extern void remove_from_swapped_list(const unsigned long index);
 extern void delay_swap_prefetch(void);
 extern void prepare_swap_prefetch(void);
+extern void aggressive_swap_prefetch(void);
 
 #else	/* CONFIG_SWAP_PREFETCH */
 static inline void add_to_swapped_list(struct page *__unused)
@@ -50,6 +51,10 @@ static inline void remove_from_swapped_l
 static inline void delay_swap_prefetch(void)
 {
 }
+
+static inline void aggressive_swap_prefetch(void)
+{
+}
 #endif	/* CONFIG_SWAP_PREFETCH */
 
 #endif		/* SWAP_PREFETCH_H_INCLUDED */
