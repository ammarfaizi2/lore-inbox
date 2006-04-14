Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWDNR3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWDNR3P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 13:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWDNR3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 13:29:15 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:44933 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751299AbWDNR3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 13:29:14 -0400
Date: Fri, 14 Apr 2006 10:28:32 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: hugh@veritas.com, linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       linux-mm@kvack.org, taka@valinux.co.jp, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Implement lookup_swap_cache for migration entries
In-Reply-To: <20060413222921.2834d897.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604141025310.18575@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
 <20060413235416.15398.49978.sendpatchset@schroedinger.engr.sgi.com>
 <20060413171331.1752e21f.akpm@osdl.org> <Pine.LNX.4.64.0604131728150.15802@schroedinger.engr.sgi.com>
 <20060413174232.57d02343.akpm@osdl.org> <Pine.LNX.4.64.0604131743180.15965@schroedinger.engr.sgi.com>
 <20060413180159.0c01beb7.akpm@osdl.org> <Pine.LNX.4.64.0604131827210.16220@schroedinger.engr.sgi.com>
 <20060413222921.2834d897.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This undoes the optimization that resulted in a yield in do_swap_cache().
do_swap_cache() stays as is. Instead we convert the migration entry to
a page * in lookup_swap_cache.

For the non swap case we need a special macro version of lookup_swap_cache
that is only capable of handling migration cache entries.

Signed-off-by: Christoph Lameter <claemter@sgi.com>

Index: linux-2.6.17-rc1-mm2/mm/swap_state.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/swap_state.c	2006-04-11 12:14:34.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/swap_state.c	2006-04-14 09:10:03.000000000 -0700
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
+#include <linux/swapops.h>
 #include <linux/swap-prefetch.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
@@ -305,6 +306,12 @@ struct page * lookup_swap_cache(swp_entr
 {
 	struct page *page;
 
+	if (is_migration_entry(entry)) {
+		page = migration_entry_to_page(entry);
+		get_page(page);
+		return page;
+	}
+
 	page = find_get_page(&swapper_space, entry.val);
 
 	if (page)
Index: linux-2.6.17-rc1-mm2/mm/memory.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/memory.c	2006-04-13 16:43:10.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/memory.c	2006-04-14 09:04:11.000000000 -0700
@@ -1880,11 +1880,6 @@ static int do_swap_page(struct mm_struct
 
 	entry = pte_to_swp_entry(orig_pte);
 
-	if (unlikely(is_migration_entry(entry))) {
-		yield();
-		goto out;
-	}
-
 	page = lookup_swap_cache(entry);
 	if (!page) {
  		swapin_readahead(entry, address, vma);
Index: linux-2.6.17-rc1-mm2/include/linux/swap.h
===================================================================
--- linux-2.6.17-rc1-mm2.orig/include/linux/swap.h	2006-04-13 16:43:21.000000000 -0700
+++ linux-2.6.17-rc1-mm2/include/linux/swap.h	2006-04-14 09:08:42.000000000 -0700
@@ -302,7 +302,6 @@ static inline void disable_swap_token(vo
 #define swap_duplicate(swp)			/*NOTHING*/
 #define swap_free(swp)				/*NOTHING*/
 #define read_swap_cache_async(swp,vma,addr)	NULL
-#define lookup_swap_cache(swp)			NULL
 #define valid_swaphandles(swp, off)		0
 #define can_share_swap_page(p)			0
 #define move_to_swap_cache(p, swp)		1
@@ -311,6 +310,19 @@ static inline void disable_swap_token(vo
 #define delete_from_swap_cache(p)		/*NOTHING*/
 #define swap_token_default_timeout		0
 
+/*
+ * Must use a macro for lookup_swap_cache since the functions
+ * used are only available in certain contexts.
+ */
+#define lookup_swap_cache(__swp)				\
+({	struct page *p = NULL;					\
+	if (is_migration_entry(__swp)) {			\
+		p = migration_entry_to_page(__swp);		\
+		get_page(p);					\
+	}							\
+	p;							\
+})
+
 static inline int remove_exclusive_swap_page(struct page *p)
 {
 	return 0;
Index: linux-2.6.17-rc1-mm2/include/linux/swapops.h
===================================================================
--- linux-2.6.17-rc1-mm2.orig/include/linux/swapops.h	2006-04-13 16:43:10.000000000 -0700
+++ linux-2.6.17-rc1-mm2/include/linux/swapops.h	2006-04-14 09:55:25.000000000 -0700
@@ -77,7 +77,7 @@ static inline swp_entry_t make_migration
 
 static inline int is_migration_entry(swp_entry_t entry)
 {
-	return swp_type(entry) == SWP_TYPE_MIGRATION;
+	return unlikely(swp_type(entry) == SWP_TYPE_MIGRATION);
 }
 
 static inline struct page *migration_entry_to_page(swp_entry_t entry)
