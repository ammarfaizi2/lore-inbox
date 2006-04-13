Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbWDMXye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbWDMXye (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWDMXye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:54:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32726 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965054AbWDMXyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:54:33 -0400
Date: Thu, 13 Apr 2006 16:54:16 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Lee Schermerhorn <lee.schermerhorn@hp.com>, linux-mm@kvack.org,
       Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20060413235416.15398.49978.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 2/5] Swapless V2: Add migration swap entries
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add migration swap type and functions to handle migration entries

SWP_TYPE_MIGRATION is a special swap type that encodes the pfn of the
page in the swp_offset. SWP_TYPE_MIGRATION swap entries are only set
for a pte while the corresponding page is locked. Migration entries
are removed while the page is still locked. Therefore the processing
for this special type of swap page can be simple.

Only freeing and duplication operations are supported for copy_page_range
and zap_range. The freeing of this type of entry is ignored and we also
simply do nothing on duplication relying on the reverse maps to track
replications of the pte.

If do_swap_page encounters a migration entry then it simply redoes
the fault until the migration entry has gone away. We used to take
a page count on the old page which frequently caused the page migration
code to retry again. Redoing the fault immediately avoids
migration retries.

Migration entry related operations work even if CONFIG_SWAP has not been
switched on.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc1-mm2/mm/swapfile.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/swapfile.c	2006-04-02 20:22:10.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/swapfile.c	2006-04-13 16:43:10.000000000 -0700
@@ -395,6 +395,9 @@ void free_swap_and_cache(swp_entry_t ent
 	struct swap_info_struct * p;
 	struct page *page = NULL;
 
+	if (is_migration_entry(entry))
+		return;
+
 	p = swap_info_get(entry);
 	if (p) {
 		if (swap_entry_free(p, swp_offset(entry)) == 1) {
@@ -1709,6 +1712,9 @@ int swap_duplicate(swp_entry_t entry)
 	unsigned long offset, type;
 	int result = 0;
 
+	if (is_migration_entry(entry))
+		return 1;
+
 	type = swp_type(entry);
 	if (type >= nr_swapfiles)
 		goto bad_file;
Index: linux-2.6.17-rc1-mm2/include/linux/swap.h
===================================================================
--- linux-2.6.17-rc1-mm2.orig/include/linux/swap.h	2006-04-11 12:14:34.000000000 -0700
+++ linux-2.6.17-rc1-mm2/include/linux/swap.h	2006-04-13 16:43:21.000000000 -0700
@@ -29,7 +29,13 @@ static inline int current_is_kswapd(void
  * the type/offset into the pte as 5/27 as well.
  */
 #define MAX_SWAPFILES_SHIFT	5
+#ifndef CONFIG_MIGRATION
 #define MAX_SWAPFILES		(1 << MAX_SWAPFILES_SHIFT)
+#else
+/* Use last entry for page migration swap entries */
+#define MAX_SWAPFILES		((1 << MAX_SWAPFILES_SHIFT)-1)
+#define SWP_TYPE_MIGRATION	MAX_SWAPFILES
+#endif
 
 /*
  * Magic header for a swap area. The first part of the union is
Index: linux-2.6.17-rc1-mm2/include/linux/swapops.h
===================================================================
--- linux-2.6.17-rc1-mm2.orig/include/linux/swapops.h	2006-04-02 20:22:10.000000000 -0700
+++ linux-2.6.17-rc1-mm2/include/linux/swapops.h	2006-04-13 16:43:10.000000000 -0700
@@ -67,3 +67,35 @@ static inline pte_t swp_entry_to_pte(swp
 	BUG_ON(pte_file(__swp_entry_to_pte(arch_entry)));
 	return __swp_entry_to_pte(arch_entry);
 }
+
+#ifdef CONFIG_MIGRATION
+static inline swp_entry_t make_migration_entry(struct page *page)
+{
+	BUG_ON(!PageLocked(page));
+	return swp_entry(SWP_TYPE_MIGRATION, page_to_pfn(page));
+}
+
+static inline int is_migration_entry(swp_entry_t entry)
+{
+	return swp_type(entry) == SWP_TYPE_MIGRATION;
+}
+
+static inline struct page *migration_entry_to_page(swp_entry_t entry)
+{
+	struct page *p = pfn_to_page(swp_offset(entry));
+	/*
+	 * Any use of migration entries may only occur while the
+	 * corresponding page is locked
+	 */
+	BUG_ON(!PageLocked(p));
+	BUG_ON(!is_migration_entry(entry));
+	return p;
+}
+#else
+
+#define make_migration_entry(page) swp_entry(0, 0)
+#define is_migration_entry(swp) 0
+#define migration_entry_to_page(swp) NULL
+
+#endif
+
Index: linux-2.6.17-rc1-mm2/mm/memory.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/memory.c	2006-04-11 12:14:34.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/memory.c	2006-04-13 16:43:10.000000000 -0700
@@ -1879,6 +1879,12 @@ static int do_swap_page(struct mm_struct
 		goto out;
 
 	entry = pte_to_swp_entry(orig_pte);
+
+	if (unlikely(is_migration_entry(entry))) {
+		yield();
+		goto out;
+	}
+
 	page = lookup_swap_cache(entry);
 	if (!page) {
  		swapin_readahead(entry, address, vma);
