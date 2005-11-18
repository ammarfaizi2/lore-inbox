Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbVKRBDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbVKRBDK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 20:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVKRBDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 20:03:10 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:8120 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751335AbVKRBDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 20:03:07 -0500
Date: Thu, 17 Nov 2005 17:03:02 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>,
       lhms-devel@lists.sourceforge.net
Message-Id: <20051118010302.22328.14094.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051118010257.22328.49524.sendpatchset@schroedinger.engr.sgi.com>
References: <20051118010257.22328.49524.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 2/4] SwapMig: add_to_swap() avoid atomic allocations
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add gfp_mask to add_to_swap

add_to_swap does allocations with GFP_ATOMIC in order not to
interfere with swapping. During migration we may have
use add_to_swap extensively which may lead to out of memory
errors.

This patch makes add_to_swap take a parameter that specifies
the gfp mask. The page migration code can then make add_to_swap
use GFP_KERNEL.

Signed-off-by: Hirokazu Takahashi <taka@valinux.co.jp>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc1-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.15-rc1-mm1.orig/include/linux/swap.h	2005-11-17 16:55:05.000000000 -0800
+++ linux-2.6.15-rc1-mm1/include/linux/swap.h	2005-11-17 16:57:30.000000000 -0800
@@ -231,7 +231,7 @@ extern int rw_swap_page_sync(int, swp_en
 extern struct address_space swapper_space;
 #define total_swapcache_pages  swapper_space.nrpages
 extern void show_swap_cache_info(void);
-extern int add_to_swap(struct page *);
+extern int add_to_swap(struct page *, gfp_t);
 extern void __delete_from_swap_cache(struct page *);
 extern void delete_from_swap_cache(struct page *);
 extern int move_to_swap_cache(struct page *, swp_entry_t);
Index: linux-2.6.15-rc1-mm1/mm/swap_state.c
===================================================================
--- linux-2.6.15-rc1-mm1.orig/mm/swap_state.c	2005-11-17 15:17:32.000000000 -0800
+++ linux-2.6.15-rc1-mm1/mm/swap_state.c	2005-11-17 16:57:30.000000000 -0800
@@ -142,7 +142,7 @@ void __delete_from_swap_cache(struct pag
  * Allocate swap space for the page and add the page to the
  * swap cache.  Caller needs to hold the page lock. 
  */
-int add_to_swap(struct page * page)
+int add_to_swap(struct page * page, gfp_t gfp_mask)
 {
 	swp_entry_t entry;
 	int err;
@@ -170,7 +170,7 @@ int add_to_swap(struct page * page)
 		 * Add it to the swap cache and mark it dirty
 		 */
 		err = __add_to_swap_cache(page, entry,
-				GFP_ATOMIC|__GFP_NOMEMALLOC|__GFP_NOWARN);
+				gfp_mask|__GFP_NOMEMALLOC|__GFP_NOWARN);
 
 		switch (err) {
 		case 0:				/* Success */
Index: linux-2.6.15-rc1-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc1-mm1.orig/mm/vmscan.c	2005-11-17 16:55:49.000000000 -0800
+++ linux-2.6.15-rc1-mm1/mm/vmscan.c	2005-11-17 16:57:30.000000000 -0800
@@ -455,7 +455,7 @@ static int shrink_list(struct list_head 
 		if (PageAnon(page) && !PageSwapCache(page)) {
 			if (!sc->may_swap)
 				goto keep_locked;
-			if (!add_to_swap(page))
+			if (!add_to_swap(page, GFP_ATOMIC))
 				goto activate_locked;
 		}
 #endif /* CONFIG_SWAP */
@@ -726,7 +726,7 @@ redo:
 		}
 
 		if (PageAnon(page) && !PageSwapCache(page)) {
-			if (!add_to_swap(page)) {
+			if (!add_to_swap(page, GFP_KERNEL)) {
 				unlock_page(page);
 				list_move(&page->lru, &failed);
 				nr_failed++;
