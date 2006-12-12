Return-Path: <linux-kernel-owner+w=401wt.eu-S932186AbWLLKyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWLLKyp (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 05:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWLLKyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 05:54:45 -0500
Received: from nigel.suspend2.net ([203.171.70.205]:40502 "EHLO
	nigel.suspend2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932186AbWLLKyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 05:54:44 -0500
Subject: [PATCH] Vmscan.c: Account for memory already freed in seeking to
	free more.
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 21:54:41 +1100
Message-Id: <1165920881.7318.2.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current versions of shrink_all_zones and shrink_all_memory don't
take account of memory already freed when making multiple calls to seek
to free memory. As a result, we can end up freeing far more memory than
was asked for. This can in turn result in more (unnecessary) paging
if/when the data is later needed.

These modifications seek to alleviate this situation by modifying
swap_cluster_max by the number of pages freed by shrink_inactive_list in
shrink_all_zones before proceeding to the next zone, and in
shrink_all_memory before shrinking slab and going to the next priority.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net> 

diff -ruNp 930-vmscan.patch-old/mm/vmscan.c 930-vmscan.patch-new/mm/vmscan.c
@@ -1469,9 +1469,12 @@ static unsigned long shrink_all_zones(un
 
 		zone->nr_scan_inactive += (zone->nr_inactive >> prio) + 1;
 		if (zone->nr_scan_inactive >= nr_pages || pass > 3) {
+			int freed;
 			zone->nr_scan_inactive = 0;
 			nr_to_scan = min(nr_pages, zone->nr_inactive);
-			ret += shrink_inactive_list(nr_to_scan, zone, sc);
+			freed = shrink_inactive_list(nr_to_scan, zone, sc);
+			ret += freed;
+			sc->swap_cluster_max -= freed;
 			if (ret >= nr_pages)
 				return ret;
 		}
@@ -1550,9 +1553,14 @@ unsigned long shrink_all_memory(unsigned
 
 		for (prio = DEF_PRIORITY; prio >= 0; prio--) {
 			unsigned long nr_to_scan = nr_pages - ret;
+			int freed;
 
 			sc.nr_scanned = 0;
-			ret += shrink_all_zones(nr_to_scan, prio, pass, &sc);
+			sc.swap_cluster_max = nr_pages - ret;
+			freed = shrink_all_zones(nr_to_scan, prio, pass, &sc);
+			ret += freed;
+			lru_pages =- freed;
+			nr_to_scan = nr_pages - ret;
 			if (ret >= nr_pages)
 				goto out;
 


