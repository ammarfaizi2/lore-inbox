Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWERF7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWERF7I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 01:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWERF7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 01:59:08 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:36025 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750878AbWERF7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 01:59:07 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] mm: swap prefetch fix lowmem reserve calc
Date: Thu, 18 May 2006 15:58:57 +1000
User-Agent: KMail/1.9.1
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605181558.57777.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When examining the free limits in swap_prefetch we should ensure the largest
lowmem_reserve for each zone is free.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 mm/swap_prefetch.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletion(-)

Index: linux-2.6.17-rc4-mm1/mm/swap_prefetch.c
===================================================================
--- linux-2.6.17-rc4-mm1.orig/mm/swap_prefetch.c	2006-05-18 15:48:22.000000000 +1000
+++ linux-2.6.17-rc4-mm1/mm/swap_prefetch.c	2006-05-18 15:52:42.000000000 +1000
@@ -258,6 +258,18 @@ static void clear_current_prefetch_free(
 	}
 }
 
+static inline unsigned long largest_lowmem_reserve(struct zone *z)
+{
+	unsigned long ret = 0;
+	unsigned int idx = zone_idx(z);
+
+	while (!is_highmem_idx(idx)) {
+		idx++;
+		ret = max(ret, z->lowmem_reserve[idx]);
+	}
+	return ret;
+}
+
 /*
  * This updates the high and low watermarks of amount of free ram in each
  * node used to start and stop prefetching. We prefetch from pages_high * 4
@@ -276,7 +288,7 @@ static void examine_free_limits(void)
 
 		ns = &sp_stat.node[z->zone_pgdat->node_id];
 		idx = zone_idx(z);
-		ns->lowfree[idx] = z->pages_high * 3 + z->lowmem_reserve[idx];
+		ns->lowfree[idx] = z->pages_high * 3 + largest_lowmem_reserve(z);
 		ns->highfree[idx] = ns->lowfree[idx] + z->pages_high;
 
 		if (z->free_pages > ns->highfree[idx]) {

-- 
-ck
