Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262999AbVGIAIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262999AbVGIAIt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbVGIAFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:05:41 -0400
Received: from gold.veritas.com ([143.127.12.110]:5310 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S262997AbVGIAFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:05:07 -0400
Date: Sat, 9 Jul 2005 01:06:28 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] freeing update swap_list.next
In-Reply-To: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0507090105400.13391@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jul 2005 00:05:07.0026 (UTC) FILETIME=[DD35B320:01C58419]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes negligible difference in practice: but swap_list.next should not
be updated to a higher prio in the general helper swap_info_get, but rather
in swap_entry_free; and then only in the case when entry is actually freed.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/swapfile.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- swap6/mm/swapfile.c	2005-07-08 19:14:26.000000000 +0100
+++ swap7/mm/swapfile.c	2005-07-08 19:14:39.000000000 +0100
@@ -213,8 +213,6 @@ static struct swap_info_struct * swap_in
 	if (!p->swap_map[offset])
 		goto bad_free;
 	swap_list_lock();
-	if (p->prio > swap_info[swap_list.next].prio)
-		swap_list.next = type;
 	swap_device_lock(p);
 	return p;
 
@@ -251,6 +249,8 @@ static int swap_entry_free(struct swap_i
 				p->lowest_bit = offset;
 			if (offset > p->highest_bit)
 				p->highest_bit = offset;
+			if (p->prio > swap_info[swap_list.next].prio)
+				swap_list.next = p - swap_info;
 			nr_swap_pages++;
 			p->inuse_pages--;
 		}
