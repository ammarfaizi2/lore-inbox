Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbVLSTlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbVLSTlv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 14:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbVLSTlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 14:41:49 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:22410 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964900AbVLSTle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 14:41:34 -0500
Date: Mon, 19 Dec 2005 11:41:24 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Hirokazu Takahashi <taka@valinux.co.jp>, lhms-devel@lists.sourceforge.net,
       Cliff Wickman <cpw@sgi.com>, Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20051219194124.20715.169.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051219194108.20715.39379.sendpatchset@schroedinger.engr.sgi.com>
References: <20051219194108.20715.39379.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 3/5] Direct Migration V8: remove_from_swap() to remove swap ptes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add remove_from_swap

remove_from_swap() allows the restoration of the pte entries that existed
before page migration occurred for anonymous pages by walking the reverse
maps. This reduces swap use and establishes regular pte's without the need
for page faults.

V7->V8:
- Move the removing of the page from the swap entries and from the swap
  cache to migrate page so that it can be done while the page lock
  on the new page is held.
- Unlock anon_vma
- Remove the page from the page cache

V5->V6:
- Somehow V5 did a remove_from_swap for the old page. Changed to new
  page

V3->V4:
- Add new function remove_vma_swap in swapfile.c to encapsulate
  the functionality needed instead of exporting unuse_vma.
- Add #ifdef CONFIG_MIGRATION

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm3/include/linux/swap.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/swap.h	2005-12-16 11:44:15.000000000 -0800
+++ linux-2.6.15-rc5-mm3/include/linux/swap.h	2005-12-19 10:39:14.000000000 -0800
@@ -230,6 +230,9 @@ extern int remove_exclusive_swap_page(st
 struct backing_dev_info;
 
 extern spinlock_t swap_lock;
+#ifdef CONFIG_MIGRATION
+extern int remove_vma_swap(struct vm_area_struct *vma, struct page *page);
+#endif
 
 /* linux/mm/thrash.c */
 extern struct mm_struct * swap_token_mm;
Index: linux-2.6.15-rc5-mm3/mm/swapfile.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/swapfile.c	2005-12-16 11:44:15.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/swapfile.c	2005-12-19 10:39:14.000000000 -0800
@@ -532,6 +532,16 @@ static int unuse_mm(struct mm_struct *mm
 	return 0;
 }
 
+#ifdef CONFIG_MIGRATION
+int remove_vma_swap(struct vm_area_struct *vma, struct page *page)
+{
+	swp_entry_t entry = { .val = page_private(page) };
+
+	return unuse_vma(vma, entry, page);
+}
+#endif
+
+
 /*
  * Scan swap_map from current position to next entry still in use.
  * Recycle to start on reaching the end, returning 0 when empty.
Index: linux-2.6.15-rc5-mm3/mm/rmap.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/rmap.c	2005-12-16 11:44:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/rmap.c	2005-12-19 10:42:23.000000000 -0800
@@ -205,6 +205,35 @@ out:
 	return anon_vma;
 }
 
+#ifdef CONFIG_MIGRATION
+/*
+ * Remove an anonymous page from swap replacing the swap pte's
+ * through real pte's pointing to valid pages and then releasing
+ * the page from the swap cache.
+ *
+ * Must hold page lock on page.
+ */
+void remove_from_swap(struct page *page)
+{
+	struct anon_vma *anon_vma;
+	struct vm_area_struct *vma;
+
+	if (!PageAnon(page) || !PageSwapCache(page))
+		return;
+
+	anon_vma = page_lock_anon_vma(page);
+	if (!anon_vma)
+		return;
+
+	list_for_each_entry(vma, &anon_vma->head, anon_vma_node)
+		remove_vma_swap(vma, page);
+
+	spin_unlock(&anon_vma->lock);
+
+	delete_from_swap_cache(page);
+}
+#endif
+
 /*
  * At what user virtual address is page expected in vma?
  */
Index: linux-2.6.15-rc5-mm3/include/linux/rmap.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/rmap.h	2005-12-16 11:44:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/include/linux/rmap.h	2005-12-19 10:39:14.000000000 -0800
@@ -92,6 +92,9 @@ static inline void page_dup_rmap(struct 
  */
 int page_referenced(struct page *, int is_locked);
 int try_to_unmap(struct page *);
+#ifdef CONFIG_MIGRATION
+void remove_from_swap(struct page *page);
+#endif
 
 /*
  * Called from mm/filemap_xip.c to unmap empty zero page
Index: linux-2.6.15-rc5-mm3/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/vmscan.c	2005-12-16 11:44:15.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/vmscan.c	2005-12-19 10:44:23.000000000 -0800
@@ -807,6 +807,15 @@ int migrate_page(struct page *newpage, s
 
 	migrate_page_copy(newpage, page);
 
+	/*
+	 * Remove auxiliary swap entries and replace
+	 * them with real ptes.
+	 *
+	 * Note that a real pte entry will allow processes that are not
+	 * waiting on the page lock to use the new page via the page tables
+	 * before the new page is unlocked.
+	 */
+	remove_from_swap(newpage);
 	return 0;
 }
 
