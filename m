Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422959AbWJQAhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422959AbWJQAhU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 20:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422989AbWJQAhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 20:37:20 -0400
Received: from smtp-out.google.com ([216.239.45.12]:45196 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1422959AbWJQAhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 20:37:18 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:subject:content-type;
	b=wT84VcV4HP5h9rdg52MmnnZO0mMlQckyhKeLOZ/0xnsPZRwEcyGdEIcvXHD1oBT2k
	iHuIAdvdXUNQAAdfhCNTQ==
Message-ID: <453425A5.5040304@google.com>
Date: Mon, 16 Oct 2006 17:36:53 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [PATCH] Fix bug in try_to_free_pages and balance_pgdat when they
 fail to reclaim pages
Content-Type: multipart/mixed;
 boundary="------------000303090100080302010006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000303090100080302010006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The same bug is contained in both try_to_free_pages and balance_pgdat.
On reclaiming the requisite number of pages we correctly set
prev_priority back to DEF_PRIORITY. However, we ALSO do this even
if we loop over all priorities and fail to reclaim.

Setting prev_priority artificially high causes reclaimers to set
distress artificially low, and fail to reclaim mapped pages, when
they are, in fact, under severe memory pressure (their priority
may be as low as 0). This causes the OOM killer to fire incorrectly.

This patch changes that to set prev_priority to 0 instead, if we
fail to reclaim.

Signed-off-by: Martin J. Bligh <mbligh@google.com>


--------------000303090100080302010006
Content-Type: text/plain;
 name="2.6.18-prev_reset"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.18-prev_reset"

diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.18/mm/vmscan.c 2.6.18-prev_reset/mm/vmscan.c
--- linux-2.6.18/mm/vmscan.c	2006-09-20 12:24:42.000000000 -0700
+++ 2.6.18-prev_reset/mm/vmscan.c	2006-10-16 17:23:48.000000000 -0700
@@ -962,7 +962,6 @@ static unsigned long shrink_zones(int pr
 unsigned long try_to_free_pages(struct zone **zones, gfp_t gfp_mask)
 {
 	int priority;
-	int ret = 0;
 	unsigned long total_scanned = 0;
 	unsigned long nr_reclaimed = 0;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
@@ -1000,8 +999,15 @@ unsigned long try_to_free_pages(struct z
 		}
 		total_scanned += sc.nr_scanned;
 		if (nr_reclaimed >= sc.swap_cluster_max) {
-			ret = 1;
-			goto out;
+			for (i = 0; zones[i] != 0; i++) {
+				struct zone *zone = zones[i];
+
+				if (!cpuset_zone_allowed(zone, __GFP_HARDWALL))
+					continue;
+
+				zone->prev_priority = zone->temp_priority;
+			}
+			return 1;
 		}
 
 		/*
@@ -1021,16 +1027,15 @@ unsigned long try_to_free_pages(struct z
 		if (sc.nr_scanned && priority < DEF_PRIORITY - 2)
 			blk_congestion_wait(WRITE, HZ/10);
 	}
-out:
 	for (i = 0; zones[i] != 0; i++) {
 		struct zone *zone = zones[i];
 
 		if (!cpuset_zone_allowed(zone, __GFP_HARDWALL))
 			continue;
 
-		zone->prev_priority = zone->temp_priority;
+		zone->prev_priority = 0;
 	}
-	return ret;
+	return 0;
 }
 
 /*
@@ -1186,7 +1191,10 @@ out:
 	for (i = 0; i < pgdat->nr_zones; i++) {
 		struct zone *zone = pgdat->node_zones + i;
 
-		zone->prev_priority = zone->temp_priority;
+		if (priority < 0)		/* we failed to reclaim */
+			zone->prev_priority = 0;
+		else
+			zone->prev_priority = zone->temp_priority;
 	}
 	if (!all_zones_ok) {
 		cond_resched();

--------------000303090100080302010006--
