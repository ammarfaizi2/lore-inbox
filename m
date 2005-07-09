Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263002AbVGIAUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbVGIAUE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263004AbVGIASu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:18:50 -0400
Received: from silver.veritas.com ([143.127.12.111]:58943 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S263002AbVGIAI7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:08:59 -0400
Date: Sat, 9 Jul 2005 01:10:17 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] scan_swap_map latency breaks
In-Reply-To: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0507090109410.13391@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jul 2005 00:08:56.0089 (UTC) FILETIME=[65BDF090:01C5841A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The get_swap_page/scan_swap_map latency can be so bad that even those
without preemption configured deserve relief: periodically cond_resched.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/swapfile.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

--- swap10/mm/swapfile.c	2005-07-08 19:15:20.000000000 +0100
+++ swap11/mm/swapfile.c	2005-07-08 19:15:33.000000000 +0100
@@ -54,8 +54,6 @@ static DECLARE_MUTEX(swapon_sem);
  */
 static DECLARE_RWSEM(swap_unplug_sem);
 
-#define SWAPFILE_CLUSTER 256
-
 void swap_unplug_io_fn(struct backing_dev_info *unused_bdi, struct page *page)
 {
 	swp_entry_t entry;
@@ -82,9 +80,13 @@ void swap_unplug_io_fn(struct backing_de
 	up_read(&swap_unplug_sem);
 }
 
+#define SWAPFILE_CLUSTER	256
+#define LATENCY_LIMIT		256
+
 static inline unsigned long scan_swap_map(struct swap_info_struct *si)
 {
 	unsigned long offset, last_in_cluster;
+	int latency_ration = LATENCY_LIMIT;
 
 	/* 
 	 * We try to cluster swap pages by allocating them sequentially
@@ -115,6 +117,10 @@ static inline unsigned long scan_swap_ma
 				si->cluster_next = offset-SWAPFILE_CLUSTER-1;
 				goto cluster;
 			}
+			if (unlikely(--latency_ration < 0)) {
+				cond_resched();
+				latency_ration = LATENCY_LIMIT;
+			}
 		}
 		swap_device_lock(si);
 		goto lowest;
@@ -151,6 +157,10 @@ checks:	if (!(si->flags & SWP_WRITEOK))
 			swap_device_lock(si);
 			goto checks;
 		}
+		if (unlikely(--latency_ration < 0)) {
+			cond_resched();
+			latency_ration = LATENCY_LIMIT;
+		}
 	}
 	swap_device_lock(si);
 	goto lowest;
