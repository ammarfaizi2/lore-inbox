Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752084AbWCPKeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbWCPKeR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 05:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbWCPKeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 05:34:17 -0500
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:5069 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1752084AbWCPKeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 05:34:16 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: does swsusp suck after resume for you?
Date: Thu, 16 Mar 2006 21:33:26 +1100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, Stefan Seyfried <seife@suse.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060315103711.GA31317@suse.de> <20060315175948.GB2423@ucw.cz>
In-Reply-To: <20060315175948.GB2423@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603162133.26771.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 March 2006 04:59, Pavel Machek wrote:
> (It will probably suck. In such case, testing Con's patch would be
> nice -- after trivial fix rafael pointed out).

Ok here's a patch I've booted and tested with a modification to swap prefetch
 that others might find useful, not just swsusp.

The tunable in /proc/sys/vm/swap_prefetch is now bitwise ORed:
1	= Normal background swap prefetching when load is light
2	= Aggressively swap prefetch as much as possible

And once the "aggressive" bit is set it will prefetch as much as it can and
 then disable the aggressive bit. Thus if you set this value to 3 it will
 prefetch aggressively and then drop back to the default of 1. This makes it
 easy to simply set the aggressive flag once and forget about it. I've booted
 and tested this feature and it's working nicely. Where exactly you'd set this
 in your resume scripts I'm not sure. A rolled up patch against 2.6.16-rc6-mm1
 is here for simplicity:
http://ck.kolivas.org/patches/swap-prefetch/2.6.16-rc6-mm1-swap_prefetch_suspend_test.patch

and the incremental on top of the 4 patches pending for the next -mm is below.

Comments and testers most welcome.

Cheers,
Con
---
 Documentation/sysctl/vm.txt |    9 +++
 mm/swap_prefetch.c          |  119 +++++++++++++++++++++++++++++---------------
 2 files changed, 90 insertions(+), 38 deletions(-)

Index: linux-2.6.16-rc6-mm1/mm/swap_prefetch.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/mm/swap_prefetch.c	2006-03-16 20:26:45.000000000 +1100
+++ linux-2.6.16-rc6-mm1/mm/swap_prefetch.c	2006-03-16 21:06:50.000000000 +1100
@@ -27,8 +27,18 @@
  */
 #define PREFETCH_DELAY	(HZ * 5)
 
-/* sysctl - enable/disable swap prefetching */
-int swap_prefetch __read_mostly = 1;
+#define PREFETCH_NORMAL		(1 << 0)
+#define PREFETCH_AGGRESSIVE 	(1 << 1)
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
@@ -291,43 +301,17 @@ static void examine_free_limits(void)
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
@@ -349,6 +333,45 @@ static int prefetch_suitable(void)
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
@@ -421,6 +444,17 @@ static inline struct swapped_entry *prev
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
@@ -438,7 +472,7 @@ static enum trickle_return trickle_swap(
 	 * If laptop_mode is enabled don't prefetch to avoid hard drives
 	 * doing unnecessary spin-ups
 	 */
-	if (!swap_prefetch || laptop_mode)
+	if (!swap_prefetch || (laptop_mode && !aggressive_prefetch))
 		return ret;
 
 	examine_free_limits();
@@ -474,6 +508,14 @@ static enum trickle_return trickle_swap(
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
 
@@ -491,14 +533,15 @@ static enum trickle_return trickle_swap(
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
 
Index: linux-2.6.16-rc6-mm1/Documentation/sysctl/vm.txt
===================================================================
--- linux-2.6.16-rc6-mm1.orig/Documentation/sysctl/vm.txt	2006-03-13 10:04:51.000000000 +1100
+++ linux-2.6.16-rc6-mm1/Documentation/sysctl/vm.txt	2006-03-16 21:10:42.000000000 +1100
@@ -188,4 +188,13 @@ memory subsystem has been extremely idle
 copying back pages from swap into the swapcache and keep a copy in swap. In
 practice it can take many minutes before the vm is idle enough.
 
+This is value ORed together of
+1	= Normal background swap prefetching when load is light
+2	= Aggressively swap prefetch as much as possible
+
+When 2 is set, after the maximum amount possible has been prefetched, this bit
+is unset. ie Setting the value to 3 will prefetch aggressively then drop to 1.
+This is useful for doing aggressive prefetching for short periods in scripts
+such as after resuming from software suspend.
+
 The default value is 1.
