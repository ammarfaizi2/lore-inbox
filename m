Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285692AbSBOCAf>; Thu, 14 Feb 2002 21:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285828AbSBOCAY>; Thu, 14 Feb 2002 21:00:24 -0500
Received: from holomorphy.com ([216.36.33.161]:65199 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S285692AbSBOCAK>;
	Thu, 14 Feb 2002 21:00:10 -0500
Date: Thu, 14 Feb 2002 17:59:54 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: sortiz@dbear.engr.sgi.com, riel@surriel.com
Subject: [PATCH] [rmap] fix node offsets into zone_table[]
Message-ID: <20020215015954.GB26305@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, sortiz@dbear.engr.sgi.com,
	riel@surriel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Against rmap12f
free_area_init_core() initializes zone_table[] with no node offset,
and sets the zone of a page using pgdat->nid (uninitialized on entry
to free_area_init_core()) as a node number.

Bug and fix reported by Samuel Ortiz.

Cheers,
Bill


# This is a BitKeeper generated patch for the following project:
# Project Name: Long-term Linux VM development
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.198   ->        
#	     mm/page_alloc.c	1.58    -> 1.59   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/14	wli@holomorphy.com	1.199
# Fix zone_table[] initialization bugs where zone_table uses either no node offset
# for the index or an uninitialized field of pgdat as a node number.
# --------------------------------------------
#
diff -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Thu Feb 14 17:51:19 2002
+++ b/mm/page_alloc.c	Thu Feb 14 17:51:19 2002
@@ -897,7 +897,7 @@
 		unsigned long mask, extrafree = 0;
 		unsigned long size, realsize;
 
-		zone_table[j] = zone;
+		zone_table[nid * MAX_NR_ZONES + j] = zone;
 		realsize = size = zones_size[j];
 		if (zholes_size)
 			realsize -= zholes_size[j];
@@ -982,7 +982,7 @@
 		 */
 		for (i = 0; i < size; i++) {
 			struct page *page = mem_map + offset + i;
-			set_page_zone(page, pgdat->node_id * MAX_NR_ZONES + j);
+			set_page_zone(page, nid * MAX_NR_ZONES + j);
 			init_page_count(page);
 			__SetPageReserved(page);
 			memlist_init(&page->list);
