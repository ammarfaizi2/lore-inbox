Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266676AbUFWVMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266676AbUFWVMt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUFWVLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:11:50 -0400
Received: from holomorphy.com ([207.189.100.168]:17541 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266678AbUFWVHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:07:48 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [oom]: [2/4] add nr_wired to page_state
Message-ID: <0406231407.Wa3a0aIbWaLbXaJbIb1a1aLbKb2aKb2a3aYaJbYa3a1a4aJbKbWa4a0a4a4aWaHb342@holomorphy.com>
In-Reply-To: <0406231407.ZaHbZa1aIbIbKbZa3aHbLb3aYa2a3a5aWaIbWaKb2aYaKb4a4aHbIb3aLb5aHb2a342@holomorphy.com>
CC: akpm@osdl.org
Date: Wed, 23 Jun 2004 14:07:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.6.7/include/linux/page-flags.h
===================================================================
--- linux-2.6.7.orig/include/linux/page-flags.h	2004-06-16 05:19:42.000000000 +0000
+++ linux-2.6.7/include/linux/page-flags.h	2004-06-23 18:57:13.000000000 +0000
@@ -77,6 +77,7 @@
 #define PG_compound		19	/* Part of a compound page */
 
 #define PG_anon			20	/* Anonymous: anon_vma in mapping */
+#define PG_wired		21	/* wired: can't be evicted */
 
 
 /*
@@ -90,7 +91,8 @@
 	unsigned long nr_page_table_pages;/* Pages used for pagetables */
 	unsigned long nr_mapped;	/* mapped into pagetables */
 	unsigned long nr_slab;		/* In slab */
-#define GET_PAGE_STATE_LAST nr_slab
+	unsigned long nr_wired;		/* pinned pages */
+#define GET_PAGE_STATE_LAST nr_wired
 
 	/*
 	 * The below are zeroed by get_page_state().  Use get_full_page_state()
@@ -302,6 +304,10 @@
 #define SetPageAnon(page)	set_bit(PG_anon, &(page)->flags)
 #define ClearPageAnon(page)	clear_bit(PG_anon, &(page)->flags)
 
+#define PageWired(page)		test_bit(PG_wired, &(page)->flags)
+#define SetPageWired(page)	set_bit(PG_wired, &(page)->flags)
+#define ClearPageWired(page)	clear_bit(PG_wired, &(page)->flags)
+
 #ifdef CONFIG_SWAP
 #define PageSwapCache(page)	test_bit(PG_swapcache, &(page)->flags)
 #define SetPageSwapCache(page)	set_bit(PG_swapcache, &(page)->flags)
@@ -327,4 +333,16 @@
 	test_set_page_writeback(page);
 }
 
+static inline void set_page_wired(struct page *page)
+{
+	SetPageWired(page);
+	inc_page_state(nr_wired);
+}
+
+static inline void clear_page_wired(struct page *page)
+{
+	ClearPageWired(page);
+	dec_page_state(nr_wired);
+}
+
 #endif	/* PAGE_FLAGS_H */
Index: linux-2.6.7/mm/page_alloc.c
===================================================================
--- linux-2.6.7.orig/mm/page_alloc.c	2004-06-16 05:18:57.000000000 +0000
+++ linux-2.6.7/mm/page_alloc.c	2004-06-23 18:57:50.000000000 +0000
@@ -235,6 +235,8 @@
 		bad_page(function, page);
 	if (PageDirty(page))
 		ClearPageDirty(page);
+	if (PageWired(page))
+		clear_page_wired(page);
 }
 
 /*
@@ -563,6 +565,8 @@
 		if (order && (gfp_flags & __GFP_COMP))
 			prep_compound_page(page, order);
 	}
+	if (gfp_flags & __GFP_WIRED)
+		set_page_wired(page);
 	return page;
 }
 
@@ -1695,6 +1699,7 @@
 	"nr_page_table_pages",
 	"nr_mapped",
 	"nr_slab",
+	"nr_wired",
 
 	"pgpgin",
 	"pgpgout",
Index: linux-2.6.7/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.7.orig/fs/proc/proc_misc.c	2004-06-16 05:18:58.000000000 +0000
+++ linux-2.6.7/fs/proc/proc_misc.c	2004-06-23 18:57:33.000000000 +0000
@@ -204,6 +204,7 @@
 		"Slab:         %8lu kB\n"
 		"Committed_AS: %8u kB\n"
 		"PageTables:   %8lu kB\n"
+		"Wired:        %8lu kB\n"
 		"VmallocTotal: %8lu kB\n"
 		"VmallocUsed:  %8lu kB\n"
 		"VmallocChunk: %8lu kB\n",
@@ -226,6 +227,7 @@
 		K(ps.nr_slab),
 		K(committed),
 		K(ps.nr_page_table_pages),
+		K(ps.nr_wired),
 		vmtot,
 		vmi.used,
 		vmi.largest_chunk
