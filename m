Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbVBLDfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVBLDfH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 22:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbVBLDcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 22:32:45 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:39603 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262384AbVBLD0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 22:26:51 -0500
Date: Fri, 11 Feb 2005 19:26:13 -0800 (PST)
From: Ray Bryant <raybry@sgi.com>
To: Hirokazu Takahashi <taka@valinux.co.jp>, Hugh DIckins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       Marcello Tosatti <marcello@cyclades.com>
Cc: Ray Bryant <raybry@sgi.com>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-Id: <20050212032613.18524.52634.88860@tomahawk.engr.sgi.com>
In-Reply-To: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
Subject: [RFC 2.6.11-rc2-mm2 6/7] mm: manual page migration -- add node_map arg to try_to_migrate_pages()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To migrate pages from one node to another, we need to tell
try_to_migrate_pages() which nodes we want to migrate off
of and where to migrate the pages found on each such node.

We do this by adding the node_map array argument to 
try_to_migrate_pages(); node_map[N] gives the target
node to migrate pages to from node N.

This patch depends on a previous patch I submiteed that
adds a node argument to migrate_onepage(); this patch
is currently part of the Memory HOTPLUG page migration
patch.

node_migrate_onepage() is introduced to handle the case
where node_map is NULL (i. e. caller doesn't care where
we migrate the page, just migrate it out of here) or
the system is not a NUMA system.

Signed-off-by:Ray Bryant <raybry@sgi.com>

Index: linux-2.6.11-rc2-mm2/include/linux/mmigrate.h
===================================================================
--- linux-2.6.11-rc2-mm2.orig/include/linux/mmigrate.h	2005-02-11 11:50:27.000000000 -0800
+++ linux-2.6.11-rc2-mm2/include/linux/mmigrate.h	2005-02-11 11:52:50.000000000 -0800
@@ -16,11 +16,29 @@ extern int migrate_page_buffer(struct pa
 extern int page_migratable(struct page *, struct page *, int,
 					struct list_head *);
 extern struct page * migrate_onepage(struct page *, int nodeid);
-extern int try_to_migrate_pages(struct list_head *);
+extern int try_to_migrate_pages(struct list_head *, short *);
 extern int migration_duplicate(swp_entry_t);
 extern struct page * lookup_migration_cache(int);
 extern int migration_remove_reference(struct page *, int);
 
+extern int try_to_migrate_pages(struct list_head *, short *node_map);
+
+#ifdef CONFIG_NUMA
+static inline struct page *node_migrate_onepage(struct page *page, short *node_map) 
+{
+	if (node_map)
+		return migrate_onepage(page, node_map[page_to_nid(page)]);
+	else
+		return migrate_onepage(page, MIGRATE_NODE_ANY); 
+		
+}
+#else
+static inline struct page *node_migrate_onepage(struct page *page, short *node_map) 
+{
+	return migrate_onepage(page, MIGRATE_NODE_ANY); 
+}
+#endif
+
 #else
 static inline int generic_migrate_page(struct page *page, struct page *newpage,
 					int (*fn)(struct page *, struct page *))
Index: linux-2.6.11-rc2-mm2/mm/mmigrate.c
===================================================================
--- linux-2.6.11-rc2-mm2.orig/mm/mmigrate.c	2005-02-11 11:50:40.000000000 -0800
+++ linux-2.6.11-rc2-mm2/mm/mmigrate.c	2005-02-11 11:51:04.000000000 -0800
@@ -502,9 +502,11 @@ out_unlock:
 /*
  * This is the main entry point to migrate pages in a specific region.
  * If a page is inactive, the page may be just released instead of
- * migration.
+ * migration.  node_map is supplied in those cases (on NUMA systems)
+ * where the caller wishes to specify to which nodes the pages are
+ * migrated.  If node_map is null, the target node is MIGRATE_NODE_ANY.
  */
-int try_to_migrate_pages(struct list_head *page_list)
+int try_to_migrate_pages(struct list_head *page_list, short *node_map)
 {
 	struct page *page, *page2, *newpage;
 	LIST_HEAD(pass1_list);
@@ -542,7 +544,7 @@ int try_to_migrate_pages(struct list_hea
 	list_for_each_entry_safe(page, page2, &pass1_list, lru) {
 		list_del(&page->lru);
 		if (PageLocked(page) || PageWriteback(page) ||
-		    IS_ERR(newpage = migrate_onepage(page, MIGRATE_NODE_ANY))) {
+		    IS_ERR(newpage = node_migrate_onepage(page, node_map))) {
 			if (page_count(page) == 1) {
 				/* the page is already unused */
 				putback_page_to_lru(page_zone(page), page);
@@ -560,7 +562,7 @@ int try_to_migrate_pages(struct list_hea
 	 */
 	list_for_each_entry_safe(page, page2, &pass2_list, lru) {
 		list_del(&page->lru);
-		if (IS_ERR(newpage = migrate_onepage(page, MIGRATE_NODE_ANY))) {
+		if (IS_ERR(newpage = node_migrate_onepage(page, node_map))) {
 			if (page_count(page) == 1) {
 				/* the page is already unused */
 				putback_page_to_lru(page_zone(page), page);

-- 
Best Regards,
Ray
-----------------------------------------------
Ray Bryant                       raybry@sgi.com
The box said: "Requires Windows 98 or better",
           so I installed Linux.
-----------------------------------------------
