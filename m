Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262990AbVGIADT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262990AbVGIADT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262998AbVGIADS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:03:18 -0400
Received: from silver.veritas.com ([143.127.12.111]:16703 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S262990AbVGIABX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:01:23 -0400
Date: Sat, 9 Jul 2005 01:02:44 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] move destroy_swap_extents calls
In-Reply-To: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0507090102030.13391@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jul 2005 00:01:23.0007 (UTC) FILETIME=[57AF1CF0:01C58419]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sys_swapon's call to destroy_swap_extents on failure is made after the
final swap_list_unlock, which is faintly unsafe: another sys_swapon might
already be setting up that swap_info_struct.  Calling it earlier, before
taking swap_list_lock, is safe.  sys_swapoff's call to destroy_swap_extents
was safe, but likewise move it earlier, before taking the locks (once
try_to_unuse has completed, nothing can be needing the swap extents).

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/swapfile.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- swap2/mm/swapfile.c	2005-07-08 19:13:33.000000000 +0100
+++ swap3/mm/swapfile.c	2005-07-08 19:13:46.000000000 +0100
@@ -1127,6 +1127,7 @@ asmlinkage long sys_swapoff(const char _
 		swap_list_unlock();
 		goto out_dput;
 	}
+	destroy_swap_extents(p);
 	down(&swapon_sem);
 	swap_list_lock();
 	drain_mmlist();
@@ -1137,7 +1138,6 @@ asmlinkage long sys_swapoff(const char _
 	swap_map = p->swap_map;
 	p->swap_map = NULL;
 	p->flags = 0;
-	destroy_swap_extents(p);
 	swap_device_unlock(p);
 	swap_list_unlock();
 	up(&swapon_sem);
@@ -1529,6 +1529,7 @@ bad_swap:
 		set_blocksize(bdev, p->old_block_size);
 		bd_release(bdev);
 	}
+	destroy_swap_extents(p);
 bad_swap_2:
 	swap_list_lock();
 	swap_map = p->swap_map;
@@ -1538,7 +1539,6 @@ bad_swap_2:
 	if (!(swap_flags & SWAP_FLAG_PREFER))
 		++least_priority;
 	swap_list_unlock();
-	destroy_swap_extents(p);
 	vfree(swap_map);
 	if (swap_file)
 		filp_close(swap_file, NULL);
