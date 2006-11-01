Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946553AbWKAFr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946553AbWKAFr5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946547AbWKAFqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:46:09 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:61660 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946556AbWKAFpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:45:41 -0500
Message-Id: <20061101054521.120572000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:35 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Martin Bligh <mbligh@google.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH 55/61] Use min of two prio settings in calculating distress for reclaim
Content-Disposition: inline; filename=use-min-of-two-prio-settings-in-calculating-distress-for-reclaim.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Martin Bligh <mbligh@google.com>

If try_to_free_pages / balance_pgdat are called with a gfp_mask specifying
GFP_IO and/or GFP_FS, they will reclaim the requisite number of pages, and the
reset prev_priority to DEF_PRIORITY (or to some other high (ie: unurgent)
value).

However, another reclaimer without those gfp_mask flags set (say, GFP_NOIO)
may still be struggling to reclaim pages.  The concurrent overwrite of
zone->prev_priority will cause this GFP_NOIO thread to unexpectedly cease
deactivating mapped pages, thus causing reclaim difficulties.

Fix this is to key the distress calculation not off zone->prev_priority, but
also take into account the local caller's priority by using
min(zone->prev_priority, sc->priority)

Signed-off-by: Martin J. Bligh <mbligh@google.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 mm/vmscan.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.18.1.orig/mm/vmscan.c
+++ linux-2.6.18.1/mm/vmscan.c
@@ -727,7 +727,7 @@ static inline void note_zone_scanning_pr
  * But we had to alter page->flags anyway.
  */
 static void shrink_active_list(unsigned long nr_pages, struct zone *zone,
-				struct scan_control *sc)
+				struct scan_control *sc, int priority)
 {
 	unsigned long pgmoved;
 	int pgdeactivate = 0;
@@ -748,7 +748,7 @@ static void shrink_active_list(unsigned 
 		 * `distress' is a measure of how much trouble we're having
 		 * reclaiming pages.  0 -> no problems.  100 -> great trouble.
 		 */
-		distress = 100 >> zone->prev_priority;
+		distress = 100 >> min(zone->prev_priority, priority);
 
 		/*
 		 * The point of this algorithm is to decide when to start
@@ -899,7 +899,7 @@ static unsigned long shrink_zone(int pri
 			nr_to_scan = min(nr_active,
 					(unsigned long)sc->swap_cluster_max);
 			nr_active -= nr_to_scan;
-			shrink_active_list(nr_to_scan, zone, sc);
+			shrink_active_list(nr_to_scan, zone, sc, priority);
 		}
 
 		if (nr_inactive) {
@@ -1341,7 +1341,7 @@ static unsigned long shrink_all_zones(un
 			if (zone->nr_scan_active >= nr_pages || pass > 3) {
 				zone->nr_scan_active = 0;
 				nr_to_scan = min(nr_pages, zone->nr_active);
-				shrink_active_list(nr_to_scan, zone, sc);
+				shrink_active_list(nr_to_scan, zone, sc, prio);
 			}
 		}
 

--
