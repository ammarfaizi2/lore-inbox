Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261447AbTCYWBo>; Tue, 25 Mar 2003 17:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261625AbTCYWBH>; Tue, 25 Mar 2003 17:01:07 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:34678 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S261447AbTCYWAC>; Tue, 25 Mar 2003 17:00:02 -0500
Date: Tue, 25 Mar 2003 22:13:07 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] swap 03/13 add_to_swap_cache
In-Reply-To: <Pine.LNX.4.44.0303252209070.12636-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303252212190.12636-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make add_to_swap_cache static, it's only used by read_swap_cache_async;
and since that has just done a GFP_HIGHUSER allocation, surely it's
better for add_to_swap_cache to use GFP_KERNEL than GFP_ATOMIC.

--- swap02/include/linux/swap.h	Tue Mar 25 20:43:07 2003
+++ swap03/include/linux/swap.h	Tue Mar 25 20:43:18 2003
@@ -197,7 +197,6 @@
 extern struct address_space swapper_space;
 #define total_swapcache_pages  swapper_space.nrpages
 extern void show_swap_cache_info(void);
-extern int add_to_swap_cache(struct page *, swp_entry_t);
 extern int add_to_swap(struct page *);
 extern void __delete_from_swap_cache(struct page *);
 extern void delete_from_swap_cache(struct page *);
--- swap02/mm/swap_state.c	Wed Mar  5 07:26:34 2003
+++ swap03/mm/swap_state.c	Tue Mar 25 20:43:18 2003
@@ -68,7 +68,7 @@
 		swap_cache_info.noent_race, swap_cache_info.exist_race);
 }
 
-int add_to_swap_cache(struct page *page, swp_entry_t entry)
+static int add_to_swap_cache(struct page *page, swp_entry_t entry)
 {
 	int error;
 
@@ -78,7 +78,7 @@
 		INC_CACHE_INFO(noent_race);
 		return -ENOENT;
 	}
-	error = add_to_page_cache(page, &swapper_space, entry.val, GFP_ATOMIC);
+	error = add_to_page_cache(page, &swapper_space, entry.val, GFP_KERNEL);
 	/*
 	 * Anon pages are already on the LRU, we don't run lru_cache_add here.
 	 */

