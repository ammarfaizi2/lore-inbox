Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbVK3RLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbVK3RLX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 12:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbVK3RLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 12:11:23 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:37252 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751461AbVK3RLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 12:11:22 -0500
Date: Wed, 30 Nov 2005 09:11:12 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: lhms-devel@lists.sourceforge.net, Cliff Wickman <cpw@sgi.com>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20051130171112.19405.60414.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051130171056.19405.95644.sendpatchset@schroedinger.engr.sgi.com>
References: <20051130171056.19405.95644.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 3/5] Direct Migration V6: remove_from_swap() to remove swap ptes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add remove_from_swap

remove_from_swap() allows the restoration of the pte entries that existed
before page migration occurred for anonymous pages by walking the reverse
maps. This reduces swap use and establishes regular pte's without the need
for page faults.

V5->V6:
- Somehow V5 did a remove_from_swap for the old page. Changed to new
  page

V3->V4:
- Add new function remove_vma_swap in swapfile.c to encapsulate
  the functionality needed instead of exporting unuse_vma.
- Add #ifdef CONFIG_MIGRATION

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc3-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.15-rc3-mm1.orig/include/linux/swap.h	2005-11-30 08:46:48.000000000 -0800
+++ linux-2.6.15-rc3-mm1/include/linux/swap.h	2005-11-30 08:46:52.000000000 -0800
@@ -263,6 +263,9 @@ extern int remove_exclusive_swap_page(st
 struct backing_dev_info;
 
 extern spinlock_t swap_lock;
+#ifdef CONFIG_MIGRATION
+extern int remove_vma_swap(struct vm_area_struct *vma, struct page *page);
+#endif
 
 /* linux/mm/thrash.c */
 extern struct mm_struct * swap_token_mm;
Index: linux-2.6.15-rc3-mm1/mm/swapfile.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/mm/swapfile.c	2005-11-30 08:46:44.000000000 -0800
+++ linux-2.6.15-rc3-mm1/mm/swapfile.c	2005-11-30 08:46:52.000000000 -0800
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
Index: linux-2.6.15-rc3-mm1/mm/rmap.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/mm/rmap.c	2005-11-30 08:46:40.000000000 -0800
+++ linux-2.6.15-rc3-mm1/mm/rmap.c	2005-11-30 08:46:52.000000000 -0800
@@ -205,6 +205,28 @@ out:
 	return anon_vma;
 }
 
+#ifdef CONFIG_MIGRATION
+/*
+ * Remove an anonymous page from swap replacing the swap pte's
+ * through real pte's pointing to valid pages.
+ */
+void remove_from_swap(struct page *page)
+{
+	struct anon_vma *anon_vma;
+	struct vm_area_struct *vma;
+
+	if (!PageAnon(page))
+		return;
+
+	anon_vma = page_lock_anon_vma(page);
+	if (!anon_vma)
+		return;
+
+	list_for_each_entry(vma, &anon_vma->head, anon_vma_node)
+		remove_vma_swap(vma, page);
+}
+#endif
+
 /*
  * At what user virtual address is page expected in vma?
  */
Index: linux-2.6.15-rc3-mm1/include/linux/rmap.h
===================================================================
--- linux-2.6.15-rc3-mm1.orig/include/linux/rmap.h	2005-11-28 19:51:27.000000000 -0800
+++ linux-2.6.15-rc3-mm1/include/linux/rmap.h	2005-11-30 08:46:52.000000000 -0800
@@ -91,6 +91,9 @@ static inline void page_dup_rmap(struct 
  */
 int page_referenced(struct page *, int is_locked);
 int try_to_unmap(struct page *);
+#ifdef CONFIG_MIGRATION
+void remove_from_swap(struct page *page);
+#endif
 
 /*
  * Called from mm/filemap_xip.c to unmap empty zero page
Index: linux-2.6.15-rc3-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/mm/vmscan.c	2005-11-30 08:46:48.000000000 -0800
+++ linux-2.6.15-rc3-mm1/mm/vmscan.c	2005-11-30 08:46:52.000000000 -0800
@@ -972,10 +972,11 @@ next:
 			list_move(&page->lru, failed);
 			nr_failed++;
 		} else {
-			if (newpage)
+			if (newpage) {
 				/* Successful migration. Return new page to LRU */
+				remove_from_swap(newpage);
 				move_to_lru(newpage);
-
+			}
 			list_move(&page->lru, moved);
 		}
 	}
