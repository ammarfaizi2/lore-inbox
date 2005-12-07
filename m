Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVLGK0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVLGK0j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVLGK0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:26:25 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:31675 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750801AbVLGK0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:26:16 -0500
Message-Id: <20051207105225.732716000@localhost.localdomain>
References: <20051207104755.177435000@localhost.localdomain>
Date: Wed, 07 Dec 2005 18:48:09 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 14/16] mm: zone aging rounds accounting
Content-Disposition: inline; filename=mm-account-zone-aging-rounds.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add zone->aging_rounds to evaluate the balancing work.
It means how many rounds the zone has been fully scanned.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/mmzone.h |    1 +
 mm/page_alloc.c        |    5 +++++
 mm/vmscan.c            |    4 +++-
 3 files changed, 9 insertions(+), 1 deletion(-)

--- linux.orig/include/linux/mmzone.h
+++ linux/include/linux/mmzone.h
@@ -160,6 +160,7 @@ struct zone {
 	 */
 	unsigned long		aging_total;
 	unsigned long		aging_milestone;
+	unsigned long		aging_rounds;
 	unsigned long		page_age;
 
 	/*
--- linux.orig/mm/page_alloc.c
+++ linux/mm/page_alloc.c
@@ -1523,6 +1523,7 @@ void show_free_areas(void)
 			" inactive:%lukB"
 			" present:%lukB"
 			" aging:%lukB"
+			" aging_rounds:%lukB"
 			" age:%lu"
 			" pages_scanned:%lu"
 			" all_unreclaimable? %s"
@@ -1536,6 +1537,7 @@ void show_free_areas(void)
 			K(zone->nr_inactive),
 			K(zone->present_pages),
 			K(zone->aging_total),
+			zone->aging_rounds,
 			zone->page_age,
 			zone->pages_scanned,
 			(zone->all_unreclaimable ? "yes" : "no")
@@ -2149,6 +2151,7 @@ static void __init free_area_init_core(s
 		zone->nr_inactive = 0;
 		zone->aging_total = 0;
 		zone->aging_milestone = 0;
+		zone->aging_rounds = 0;
 		zone->page_age = 0;
 		atomic_set(&zone->reclaim_in_progress, 0);
 		if (!size)
@@ -2299,6 +2302,7 @@ static int zoneinfo_show(struct seq_file
 			   "\n        active   %lu"
 			   "\n        inactive %lu"
 			   "\n        aging    %lu"
+			   "\n        rounds   %lu"
 			   "\n        age      %lu"
 			   "\n        scanned  %lu (a: %lu)"
 			   "\n        spanned  %lu"
@@ -2310,6 +2314,7 @@ static int zoneinfo_show(struct seq_file
 			   zone->nr_active,
 			   zone->nr_inactive,
 			   zone->aging_total,
+			   zone->aging_rounds,
 			   zone->page_age,
 			   zone->pages_scanned,
 			   zone->nr_scan_active / 1024,
--- linux.orig/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -157,8 +157,10 @@ static inline void update_zone_age(struc
 
 	z->aging_total += nr_scan;
 
-	if (z->aging_total - z->aging_milestone > len)
+	if (z->aging_total - z->aging_milestone > len) {
 		z->aging_milestone += len;
+		z->aging_rounds++;
+	}
 
 	z->page_age = ((z->aging_total - z->aging_milestone)
 						<< PAGE_AGE_SHIFT) / len;

--
