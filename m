Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbVCPMRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVCPMRz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 07:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVCPMRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 07:17:55 -0500
Received: from fire.osdl.org ([65.172.181.4]:50364 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262558AbVCPMQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 07:16:15 -0500
Date: Wed, 16 Mar 2005 04:15:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: andrea@suse.de, noahm@csail.mit.edu, linux-kernel@vger.kernel.org
Subject: Re: OOM problems with 2.6.11-rc4
Message-Id: <20050316041553.4cdc205c.akpm@osdl.org>
In-Reply-To: <20050316040435.39533675.akpm@osdl.org>
References: <20050315204413.GF20253@csail.mit.edu>
	<20050316003134.GY7699@opteron.random>
	<20050316040435.39533675.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Still, I think it would make more sense to return a success indication from
>  shrink_slab() if we actually freed any slab objects.  That will prevent us
>  from incorrectly going all_unreclaimable if all we happen to be doing is
>  increasing slab internal fragmentation.
> 
>  We could do that kludgily by re-polling the shrinker but it would be better
>  to return a second value from all the shrinkers.

This is the kludgy version.

--- 25/mm/vmscan.c~vmscan-notice-slab-shrinking	2005-03-16 04:12:49.000000000 -0800
+++ 25-akpm/mm/vmscan.c	2005-03-16 04:14:02.000000000 -0800
@@ -180,17 +180,20 @@ EXPORT_SYMBOL(remove_shrinker);
  * `lru_pages' represents the number of on-LRU pages in all the zones which
  * are eligible for the caller's allocation attempt.  It is used for balancing
  * slab reclaim versus page reclaim.
+ *
+ * Returns the number of slab objects which we shrunk.
  */
 static int shrink_slab(unsigned long scanned, unsigned int gfp_mask,
 			unsigned long lru_pages)
 {
 	struct shrinker *shrinker;
+	int ret = 0;
 
 	if (scanned == 0)
 		scanned = SWAP_CLUSTER_MAX;
 
 	if (!down_read_trylock(&shrinker_rwsem))
-		return 0;
+		return 1;	/* Assume we'll be able to shrink next time */
 
 	list_for_each_entry(shrinker, &shrinker_list, list) {
 		unsigned long long delta;
@@ -209,10 +212,14 @@ static int shrink_slab(unsigned long sca
 		while (total_scan >= SHRINK_BATCH) {
 			long this_scan = SHRINK_BATCH;
 			int shrink_ret;
+			int nr_before;
 
+			nr_before = (*shrinker->shrinker)(0, gfp_mask);
 			shrink_ret = (*shrinker->shrinker)(this_scan, gfp_mask);
 			if (shrink_ret == -1)
 				break;
+			if (shrink_ret < nr_before)
+				ret += nr_before - shrink_ret;
 			mod_page_state(slabs_scanned, this_scan);
 			total_scan -= this_scan;
 
@@ -222,7 +229,7 @@ static int shrink_slab(unsigned long sca
 		shrinker->nr += total_scan;
 	}
 	up_read(&shrinker_rwsem);
-	return 0;
+	return ret;
 }
 
 /* Called without lock on whether page is mapped, so answer is unstable */
@@ -1077,6 +1084,7 @@ scan:
 		 */
 		for (i = 0; i <= end_zone; i++) {
 			struct zone *zone = pgdat->node_zones + i;
+			int nr_slab;
 
 			if (zone->present_pages == 0)
 				continue;
@@ -1098,14 +1106,15 @@ scan:
 			sc.swap_cluster_max = nr_pages? nr_pages : SWAP_CLUSTER_MAX;
 			shrink_zone(zone, &sc);
 			reclaim_state->reclaimed_slab = 0;
-			shrink_slab(sc.nr_scanned, GFP_KERNEL, lru_pages);
+			nr_slab = shrink_slab(sc.nr_scanned, GFP_KERNEL,
+						lru_pages);
 			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
 			total_reclaimed += sc.nr_reclaimed;
 			total_scanned += sc.nr_scanned;
 			if (zone->all_unreclaimable)
 				continue;
-			if (zone->pages_scanned >= (zone->nr_active +
-							zone->nr_inactive) * 4)
+			if (nr_slab == 0 && zone->pages_scanned >=
+				    (zone->nr_active + zone->nr_inactive) * 4)
 				zone->all_unreclaimable = 1;
 			/*
 			 * If we've done a decent amount of scanning and
_

