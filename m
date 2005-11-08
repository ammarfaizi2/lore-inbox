Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965194AbVKHVG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965194AbVKHVG0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbVKHVFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:05:33 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:59816 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030355AbVKHVFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:05:12 -0500
Date: Tue, 8 Nov 2005 13:04:42 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       torvalds@osdl.org, Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>, Andi Kleen <ak@suse.de>,
       Magnus Damm <magnus.damm@gmail.com>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20051108210432.31330.8927.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com>
References: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 7/8] Direct Migration V2: add_to_swap() with additional gfp_t parameter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add gfp_mask to add_to_swap

The migration code calls the function with GFP_KERNEL
while the swap code calls it with GFP_ATOMIC, because
the migration code can ask the swap code to free some pages
when we're in a low memory situation.

Signed-off-by: Hirokazu Takahashi <taka@valinux.co.jp>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.14-mm1.orig/include/linux/swap.h	2005-11-07 18:35:40.000000000 -0800
+++ linux-2.6.14-mm1/include/linux/swap.h	2005-11-07 18:38:59.000000000 -0800
@@ -242,7 +242,7 @@ extern int rw_swap_page_sync(int, swp_en
 extern struct address_space swapper_space;
 #define total_swapcache_pages  swapper_space.nrpages
 extern void show_swap_cache_info(void);
-extern int add_to_swap(struct page *);
+extern int add_to_swap(struct page *, gfp_t);
 extern void __delete_from_swap_cache(struct page *);
 extern void delete_from_swap_cache(struct page *);
 extern int move_to_swap_cache(struct page *, swp_entry_t);
Index: linux-2.6.14-mm1/mm/swap_state.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/swap_state.c	2005-11-07 18:35:40.000000000 -0800
+++ linux-2.6.14-mm1/mm/swap_state.c	2005-11-07 18:38:59.000000000 -0800
@@ -143,7 +143,7 @@ void __delete_from_swap_cache(struct pag
  * Allocate swap space for the page and add the page to the
  * swap cache.  Caller needs to hold the page lock. 
  */
-int add_to_swap(struct page * page)
+int add_to_swap(struct page * page, gfp_t gfp_mask)
 {
 	swp_entry_t entry;
 	int err;
@@ -171,7 +171,7 @@ int add_to_swap(struct page * page)
 		 * Add it to the swap cache and mark it dirty
 		 */
 		err = __add_to_swap_cache(page, entry,
-				GFP_ATOMIC|__GFP_NOMEMALLOC|__GFP_NOWARN);
+				gfp_mask|__GFP_NOMEMALLOC|__GFP_NOWARN);
 
 		switch (err) {
 		case 0:				/* Success */
Index: linux-2.6.14-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/vmscan.c	2005-11-07 18:35:40.000000000 -0800
+++ linux-2.6.14-mm1/mm/vmscan.c	2005-11-07 18:38:59.000000000 -0800
@@ -456,7 +456,7 @@ static int shrink_list(struct list_head 
 		if (PageAnon(page) && !PageSwapCache(page)) {
 			if (!sc->may_swap)
 				goto keep_locked;
-			if (!add_to_swap(page))
+			if (!add_to_swap(page, GFP_ATOMIC))
 				goto activate_locked;
 		}
 #endif /* CONFIG_SWAP */
@@ -889,7 +889,7 @@ redo:
 		 * preserved.
 		 */
 		if (PageAnon(page) && !PageSwapCache(page)) {
-			if (!add_to_swap(page)) {
+			if (!add_to_swap(page, GFP_KERNEL)) {
 				unlock_page(page);
 				list_move(&page->lru, failed);
 				nr_failed++;
