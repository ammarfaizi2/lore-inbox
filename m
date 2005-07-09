Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263009AbVGIAdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbVGIAdy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVGIAdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:33:50 -0400
Received: from silver.veritas.com ([143.127.12.111]:54335 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S263009AbVGIAIL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:08:11 -0400
Date: Sat, 9 Jul 2005 01:09:33 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] scan_swap_map drop swap_device_lock
In-Reply-To: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0507090108350.13391@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jul 2005 00:08:11.0241 (UTC) FILETIME=[4B02AD90:01C5841A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

get_swap_page has often shown up on latency traces, doing lengthy scans
while holding two spinlocks.  swap_list_lock is already dropped, now
scan_swap_map drop swap_device_lock before scanning the swap_map.

While scanning for an empty cluster, don't worry that racing tasks may
allocate what was free and free what was allocated; but when allocating
an entry, check it's still free after retaking the lock.  Avoid dropping
the lock in the expected common path.  No barriers beyond the locks,
just let the cookie crumble; highest_bit limit is volatile, but benign.

Guard against swapoff: must check SWP_WRITEOK before allocating, must
raise SWP_SCANNING reference count while in scan_swap_map, swapoff wait
for that to fall - just use schedule_timeout, we don't want to burden
scan_swap_map itself, and it's very unlikely that anyone can really
still be in scan_swap_map once swapoff gets this far.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/linux/swap.h |    2 ++
 mm/swapfile.c        |   42 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 37 insertions(+), 7 deletions(-)

--- swap9/include/linux/swap.h	2005-07-08 19:14:26.000000000 +0100
+++ swap10/include/linux/swap.h	2005-07-08 19:15:20.000000000 +0100
@@ -106,6 +106,8 @@ enum {
 	SWP_USED	= (1 << 0),	/* is slot in swap_info[] used? */
 	SWP_WRITEOK	= (1 << 1),	/* ok to write to this swap?	*/
 	SWP_ACTIVE	= (SWP_USED | SWP_WRITEOK),
+					/* add others here before... */
+	SWP_SCANNING	= (1 << 8),	/* refcount in scan_swap_map */
 };
 
 #define SWAP_CLUSTER_MAX 32
--- swap9/mm/swapfile.c	2005-07-08 19:15:06.000000000 +0100
+++ swap10/mm/swapfile.c	2005-07-08 19:15:20.000000000 +0100
@@ -96,10 +96,12 @@ static inline unsigned long scan_swap_ma
 	 * But we do now try to find an empty cluster.  -Andrea
 	 */
 
+	si->flags += SWP_SCANNING;
 	if (unlikely(!si->cluster_nr)) {
 		si->cluster_nr = SWAPFILE_CLUSTER - 1;
 		if (si->pages - si->inuse_pages < SWAPFILE_CLUSTER)
 			goto lowest;
+		swap_device_unlock(si);
 
 		offset = si->lowest_bit;
 		last_in_cluster = offset + SWAPFILE_CLUSTER - 1;
@@ -109,10 +111,12 @@ static inline unsigned long scan_swap_ma
 			if (si->swap_map[offset])
 				last_in_cluster = offset + SWAPFILE_CLUSTER;
 			else if (offset == last_in_cluster) {
+				swap_device_lock(si);
 				si->cluster_next = offset-SWAPFILE_CLUSTER-1;
 				goto cluster;
 			}
 		}
+		swap_device_lock(si);
 		goto lowest;
 	}
 
@@ -121,10 +125,12 @@ cluster:
 	offset = si->cluster_next;
 	if (offset > si->highest_bit)
 lowest:		offset = si->lowest_bit;
+checks:	if (!(si->flags & SWP_WRITEOK))
+		goto no_page;
 	if (!si->highest_bit)
 		goto no_page;
 	if (!si->swap_map[offset]) {
-got_page:	if (offset == si->lowest_bit)
+		if (offset == si->lowest_bit)
 			si->lowest_bit++;
 		if (offset == si->highest_bit)
 			si->highest_bit--;
@@ -135,16 +141,22 @@ got_page:	if (offset == si->lowest_bit)
 		}
 		si->swap_map[offset] = 1;
 		si->cluster_next = offset + 1;
+		si->flags -= SWP_SCANNING;
 		return offset;
 	}
 
+	swap_device_unlock(si);
 	while (++offset <= si->highest_bit) {
-		if (!si->swap_map[offset])
-			goto got_page;
+		if (!si->swap_map[offset]) {
+			swap_device_lock(si);
+			goto checks;
+		}
 	}
+	swap_device_lock(si);
 	goto lowest;
 
 no_page:
+	si->flags -= SWP_SCANNING;
 	return 0;
 }
 
@@ -1109,10 +1121,6 @@ asmlinkage long sys_swapoff(const char _
 	err = try_to_unuse(type);
 	current->flags &= ~PF_SWAPOFF;
 
-	/* wait for any unplug function to finish */
-	down_write(&swap_unplug_sem);
-	up_write(&swap_unplug_sem);
-
 	if (err) {
 		/* re-insert swap space back into swap_list */
 		swap_list_lock();
@@ -1126,10 +1134,28 @@ asmlinkage long sys_swapoff(const char _
 			swap_info[prev].next = p - swap_info;
 		nr_swap_pages += p->pages;
 		total_swap_pages += p->pages;
+		swap_device_lock(p);
 		p->flags |= SWP_WRITEOK;
+		swap_device_unlock(p);
 		swap_list_unlock();
 		goto out_dput;
 	}
+
+	/* wait for any unplug function to finish */
+	down_write(&swap_unplug_sem);
+	up_write(&swap_unplug_sem);
+
+	/* wait for anyone still in scan_swap_map */
+	swap_device_lock(p);
+	p->highest_bit = 0;		/* cuts scans short */
+	while (p->flags >= SWP_SCANNING) {
+		swap_device_unlock(p);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(1);
+		swap_device_lock(p);
+	}
+	swap_device_unlock(p);
+
 	destroy_swap_extents(p);
 	down(&swapon_sem);
 	swap_list_lock();
@@ -1429,6 +1455,8 @@ asmlinkage long sys_swapon(const char __
 		}
 
 		p->lowest_bit  = 1;
+		p->cluster_next = 1;
+
 		/*
 		 * Find out how many pages are allowed for a single swap
 		 * device. There are two limiting factors: 1) the number of
