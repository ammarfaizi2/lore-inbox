Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263026AbVGIASO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbVGIASO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262985AbVGIAIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:08:55 -0400
Received: from gold.veritas.com ([143.127.12.110]:11966 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S263002AbVGIAGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:06:16 -0400
Date: Sat, 9 Jul 2005 01:07:37 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] get_swap_page drop swap_list_lock
In-Reply-To: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0507090106320.13391@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jul 2005 00:06:16.0229 (UTC) FILETIME=[06753D50:01C5841A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite get_swap_page to allocate in just the same sequence as before,
but without holding swap_list_lock across its scan_swap_map.  Decrement
nr_swap_pages and update swap_list.next in advance, while still holding
swap_list_lock.  Skip full devices by testing highest_bit.  Swapoff hold
swap_device_lock as well as swap_list_lock to clear SWP_WRITEOK.  Reduces
lock contention when there are parallel swap devices of the same priority.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/swapfile.c |   73 +++++++++++++++++++++++++++-------------------------------
 1 files changed, 35 insertions(+), 38 deletions(-)

--- swap7/mm/swapfile.c	2005-07-08 19:14:39.000000000 +0100
+++ swap8/mm/swapfile.c	2005-07-08 19:14:54.000000000 +0100
@@ -137,7 +137,6 @@ static inline unsigned long scan_swap_ma
 		}
 		si->swap_map[offset] = 1;
 		si->inuse_pages++;
-		nr_swap_pages--;
 		si->cluster_next = offset+1;
 		return offset;
 	}
@@ -148,50 +147,45 @@ static inline unsigned long scan_swap_ma
 
 swp_entry_t get_swap_page(void)
 {
-	struct swap_info_struct * p;
-	unsigned long offset;
-	swp_entry_t entry;
-	int type, wrapped = 0;
+	struct swap_info_struct *si;
+	pgoff_t offset;
+	int type, next;
+	int wrapped = 0;
 
-	entry.val = 0;	/* Out of memory */
 	swap_list_lock();
-	type = swap_list.next;
-	if (type < 0)
-		goto out;
 	if (nr_swap_pages <= 0)
-		goto out;
+		goto noswap;
+	nr_swap_pages--;
 
-	while (1) {
-		p = &swap_info[type];
-		if ((p->flags & SWP_ACTIVE) == SWP_ACTIVE) {
-			swap_device_lock(p);
-			offset = scan_swap_map(p);
-			swap_device_unlock(p);
-			if (offset) {
-				entry = swp_entry(type,offset);
-				type = swap_info[type].next;
-				if (type < 0 ||
-					p->prio != swap_info[type].prio) {
-						swap_list.next = swap_list.head;
-				} else {
-					swap_list.next = type;
-				}
-				goto out;
-			}
+	for (type = swap_list.next; type >= 0 && wrapped < 2; type = next) {
+		si = swap_info + type;
+		next = si->next;
+		if (next < 0 ||
+		    (!wrapped && si->prio != swap_info[next].prio)) {
+			next = swap_list.head;
+			wrapped++;
 		}
-		type = p->next;
-		if (!wrapped) {
-			if (type < 0 || p->prio != swap_info[type].prio) {
-				type = swap_list.head;
-				wrapped = 1;
-			}
-		} else
-			if (type < 0)
-				goto out;	/* out of swap space */
+
+		if (!si->highest_bit)
+			continue;
+		if (!(si->flags & SWP_WRITEOK))
+			continue;
+
+		swap_list.next = next;
+		swap_device_lock(si);
+		swap_list_unlock();
+		offset = scan_swap_map(si);
+		swap_device_unlock(si);
+		if (offset)
+			return swp_entry(type, offset);
+		swap_list_lock();
+		next = swap_list.next;
 	}
-out:
+
+	nr_swap_pages++;
+noswap:
 	swap_list_unlock();
-	return entry;
+	return (swp_entry_t) {0};
 }
 
 static struct swap_info_struct * swap_info_get(swp_entry_t entry)
@@ -1103,8 +1097,11 @@ asmlinkage long sys_swapoff(const char _
 	}
 	nr_swap_pages -= p->pages;
 	total_swap_pages -= p->pages;
+	swap_device_lock(p);
 	p->flags &= ~SWP_WRITEOK;
+	swap_device_unlock(p);
 	swap_list_unlock();
+
 	current->flags |= PF_SWAPOFF;
 	err = try_to_unuse(type);
 	current->flags &= ~PF_SWAPOFF;
