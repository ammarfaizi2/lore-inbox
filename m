Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422997AbWJQBa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422997AbWJQBa4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 21:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWJQBa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 21:30:56 -0400
Received: from smtp-out.google.com ([216.239.45.12]:48788 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030215AbWJQBa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 21:30:56 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:subject:content-type;
	b=XJJ8JoHOBi9s2s2o8jNXksdOQVIffaKV2u1umsV3CIs0mwjRv4/9PuydByZ/CAJxc
	xpHPImiIWGUXGPlhZk+YQ==
Message-ID: <4534323F.5010103@google.com>
Date: Mon, 16 Oct 2006 18:30:39 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [PATCH] Use min of two prio settings in calculating distress for
 reclaim
Content-Type: multipart/mixed;
 boundary="------------000706010606020009000007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000706010606020009000007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Another bug is that if try_to_free_pages / balance_pgdat are called
with a gfp_mask specifying GFP_IO and/or GFP_FS, they may reclaim
the requisite number of pages, and reset prev_priority to DEF_PRIORITY.

However, another reclaimer without those gfp_mask flags set may still
be struggling to reclaim pages. The easy fix for this is to key the
distress calculation not off zone->prev_priority, but also take into
account the local caller's priority by using:
min(zone->prev_priority, sc->priority)

Signed-off-by: Martin J. Bligh <mbligh@google.com>

--------------000706010606020009000007
Content-Type: text/plain;
 name="2.6.18-min_prio"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.18-min_prio"

diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.18/mm/vmscan.c 2.6.18-min_prio/mm/vmscan.c
--- linux-2.6.18/mm/vmscan.c	2006-09-20 12:24:42.000000000 -0700
+++ 2.6.18-min_prio/mm/vmscan.c	2006-10-16 18:16:39.000000000 -0700
@@ -713,7 +713,7 @@ done:
  * But we had to alter page->flags anyway.
  */
 static void shrink_active_list(unsigned long nr_pages, struct zone *zone,
-				struct scan_control *sc)
+				struct scan_control *sc, int priority)
 {
 	unsigned long pgmoved;
 	int pgdeactivate = 0;
@@ -734,7 +734,7 @@ static void shrink_active_list(unsigned 
 		 * `distress' is a measure of how much trouble we're having
 		 * reclaiming pages.  0 -> no problems.  100 -> great trouble.
 		 */
-		distress = 100 >> zone->prev_priority;
+		distress = 100 >> min(zone->prev_priority, priority);
 
 		/*
 		 * The point of this algorithm is to decide when to start
@@ -885,7 +885,7 @@ static unsigned long shrink_zone(int pri
 			nr_to_scan = min(nr_active,
 					(unsigned long)sc->swap_cluster_max);
 			nr_active -= nr_to_scan;
-			shrink_active_list(nr_to_scan, zone, sc);
+			shrink_active_list(nr_to_scan, zone, sc, priority);
 		}
 
 		if (nr_inactive) {
@@ -1315,7 +1315,7 @@ static unsigned long shrink_all_zones(un
 			if (zone->nr_scan_active >= nr_pages || pass > 3) {
 				zone->nr_scan_active = 0;
 				nr_to_scan = min(nr_pages, zone->nr_active);
-				shrink_active_list(nr_to_scan, zone, sc);
+				shrink_active_list(nr_to_scan, zone, sc, prio);
 			}
 		}
 

--------------000706010606020009000007--
