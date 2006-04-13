Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbWDMXzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbWDMXzB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbWDMXzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:55:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:35798 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965059AbWDMXyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:54:46 -0400
Date: Thu, 13 Apr 2006 16:54:32 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Lee Schermerhorn <lee.schermerhorn@hp.com>, linux-mm@kvack.org,
       Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20060413235432.15398.23912.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 5/5] Swapless V2: Revise main migration logic
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the migration entries for page migration

This modifies the migration code to use the new migration entries.
It now becomes possible to migrate anonymous pages without having to
add a swap entry.

We add a couple of new functions to replace migration entries with the proper
ptes.

We cannot take the tree_lock for migrating anonymous pages anymore. However,
we know that we hold the only remaining reference to the page when the page
count reaches 1.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc1-mm2/mm/migrate.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/migrate.c	2006-04-13 15:58:54.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/migrate.c	2006-04-13 16:36:28.000000000 -0700
@@ -15,6 +15,7 @@
 #include <linux/migrate.h>
 #include <linux/module.h>
 #include <linux/swap.h>
+#include <linux/swapops.h>
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
 #include <linux/mm_inline.h>
@@ -23,7 +24,6 @@
 #include <linux/topology.h>
 #include <linux/cpu.h>
 #include <linux/cpuset.h>
-#include <linux/swapops.h>
 
 #include "internal.h"
 
@@ -115,6 +115,95 @@ int putback_lru_pages(struct list_head *
 	return count;
 }
 
+static inline int is_swap_pte(pte_t pte)
+{
+	return !pte_none(pte) && !pte_present(pte) && !pte_file(pte);
+}
+
+/*
+ * Restore a potential migration pte to a working pte entry for
+ * anonymous pages.
+ */
+static void remove_migration_pte(struct vm_area_struct *vma, unsigned long addr,
+		struct page *old, struct page *new)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	swp_entry_t entry;
+ 	pgd_t *pgd;
+ 	pud_t *pud;
+ 	pmd_t *pmd;
+	pte_t *ptep, pte;
+ 	spinlock_t *ptl;
+
+ 	pgd = pgd_offset(mm, addr);
+	 if (!pgd_present(*pgd))
+                return;
+
+	pud = pud_offset(pgd, addr);
+	if (!pud_present(*pud))
+                return;
+
+	pmd = pmd_offset(pud, addr);
+	if (!pmd_present(*pmd))
+		return;
+
+	ptep = pte_offset_map(pmd, addr);
+
+	if (!is_swap_pte(*ptep)) {
+		pte_unmap(ptep);
+ 		return;
+ 	}
+
+ 	ptl = pte_lockptr(mm, pmd);
+ 	spin_lock(ptl);
+	pte = *ptep;
+	if (!is_swap_pte(pte))
+		goto out;
+
+	entry = pte_to_swp_entry(pte);
+
+	if (!is_migration_entry(entry) || migration_entry_to_page(entry) != old)
+		goto out;
+
+	inc_mm_counter(mm, anon_rss);
+	get_page(new);
+	set_pte_at(mm, addr, ptep, pte_mkold(mk_pte(new, vma->vm_page_prot)));
+	page_add_anon_rmap(new, vma, addr);
+out:
+	pte_unmap_unlock(pte, ptl);
+}
+
+/*
+ * Get rid of all migration entries and replace them by
+ * references to the indicated page.
+ *
+ * Must hold mmap_sem lock on at least one of the vmas containing
+ * the page so that the anon_vma cannot vanish.
+ */
+static void remove_migration_ptes(struct page *old, struct page *new)
+{
+	struct anon_vma *anon_vma;
+	struct vm_area_struct *vma;
+	unsigned long mapping;
+
+	mapping = (unsigned long)new->mapping;
+
+	if (!mapping || (mapping & PAGE_MAPPING_ANON) == 0)
+		return;
+
+	/*
+	 * We hold the mmap_sem lock. So no need to call page_lock_anon_vma.
+	 */
+	anon_vma = (struct anon_vma *) (mapping - PAGE_MAPPING_ANON);
+	spin_lock(&anon_vma->lock);
+
+	list_for_each_entry(vma, &anon_vma->head, anon_vma_node)
+		remove_migration_pte(vma, page_address_in_vma(new, vma),
+					old, new);
+
+	spin_unlock(&anon_vma->lock);
+}
+
 /*
  * Non migratable page
  */
@@ -125,8 +214,9 @@ int fail_migrate_page(struct page *newpa
 EXPORT_SYMBOL(fail_migrate_page);
 
 /*
- * Remove references for a page and establish the new page with the correct
- * basic settings to be able to stop accesses to the page.
+ * Remove or replace all references to a page so that future accesses to
+ * the page can be blocked. Establish the new page
+ * with the basic settings to be able to stop accesses to the page.
  */
 int migrate_page_remove_references(struct page *newpage,
 				struct page *page, int nr_refs)
@@ -139,38 +229,51 @@ int migrate_page_remove_references(struc
 	 * indicates that the page is in use or truncate has removed
 	 * the page.
 	 */
-	if (!mapping || page_mapcount(page) + nr_refs != page_count(page))
-		return -EAGAIN;
+	if (!page->mapping ||
+		page_mapcount(page) + nr_refs != page_count(page))
+			return -EAGAIN;
 
 	/*
-	 * Establish swap ptes for anonymous pages or destroy pte
+	 * Establish migration ptes for anonymous pages or destroy pte
 	 * maps for files.
 	 *
 	 * In order to reestablish file backed mappings the fault handlers
 	 * will take the radix tree_lock which may then be used to stop
   	 * processses from accessing this page until the new page is ready.
 	 *
-	 * A process accessing via a swap pte (an anonymous page) will take a
-	 * page_lock on the old page which will block the process until the
-	 * migration attempt is complete. At that time the PageSwapCache bit
-	 * will be examined. If the page was migrated then the PageSwapCache
-	 * bit will be clear and the operation to retrieve the page will be
-	 * retried which will find the new page in the radix tree. Then a new
-	 * direct mapping may be generated based on the radix tree contents.
-	 *
-	 * If the page was not migrated then the PageSwapCache bit
-	 * is still set and the operation may continue.
+	 * A process accessing via a migration pte (an anonymous page) will
+	 * take a page_lock on the old page which will block the process
+	 * until the migration attempt is complete.
 	 */
 	if (try_to_unmap(page, 1) == SWAP_FAIL)
 		/* A vma has VM_LOCKED set -> permanent failure */
 		return -EPERM;
 
 	/*
-	 * Give up if we were unable to remove all mappings.
+	 * Retry if we were unable to remove all mappings.
 	 */
 	if (page_mapcount(page))
 		return -EAGAIN;
 
+	if (!mapping) {
+		/*
+		 * Anonymous page without swap mapping.
+		 * User space cannot access the page anymore since we
+		 * removed the ptes. Now check if the kernel still has
+		 * pending references.
+		 */
+		if (page_count(page) != nr_refs)
+			return -EAGAIN;
+
+		/* We are holding the only remaining reference */
+		newpage->index = page->index;
+		newpage->mapping = page->mapping;
+		return 0;
+	}
+
+	/*
+	 * The page has a mapping that we need to change
+	 */
 	write_lock_irq(&mapping->tree_lock);
 
 	radix_pointer = (struct page **)radix_tree_lookup_slot(
@@ -194,10 +297,13 @@ int migrate_page_remove_references(struc
 	get_page(newpage);
 	newpage->index = page->index;
 	newpage->mapping = page->mapping;
+
+#ifdef CONFIG_SWAP
 	if (PageSwapCache(page)) {
 		SetPageSwapCache(newpage);
 		set_page_private(newpage, page_private(page));
 	}
+#endif
 
 	*radix_pointer = newpage;
 	__put_page(page);
@@ -232,7 +338,9 @@ void migrate_page_copy(struct page *newp
 		set_page_dirty(newpage);
  	}
 
+#ifdef CONFIG_SWAP
 	ClearPageSwapCache(page);
+#endif
 	ClearPageActive(page);
 	ClearPagePrivate(page);
 	set_page_private(page, 0);
@@ -259,22 +367,16 @@ int migrate_page(struct page *newpage, s
 
 	BUG_ON(PageWriteback(page));	/* Writeback must be complete */
 
-	rc = migrate_page_remove_references(newpage, page, 2);
+	rc = migrate_page_remove_references(newpage, page,
+			page_mapping(page) ? 2 : 1);
 
-	if (rc)
+	if (rc) {
+		remove_migration_ptes(page, page);
 		return rc;
+	}
 
 	migrate_page_copy(newpage, page);
-
-	/*
-	 * Remove auxiliary swap entries and replace
-	 * them with real ptes.
-	 *
-	 * Note that a real pte entry will allow processes that are not
-	 * waiting on the page lock to use the new page via the page tables
-	 * before the new page is unlocked.
-	 */
-	remove_from_swap(newpage);
+	remove_migration_ptes(page, newpage);
 	return 0;
 }
 EXPORT_SYMBOL(migrate_page);
@@ -356,9 +458,11 @@ redo:
 		 * Try to migrate the page.
 		 */
 		mapping = page_mapping(page);
-		if (!mapping)
+		if (!mapping) {
+			rc = migrate_page(newpage, page);
 			goto unlock_both;
 
+		} else
 		if (mapping->a_ops->migratepage) {
 			/*
 			 * Most pages have a mapping and most filesystems
Index: linux-2.6.17-rc1-mm2/mm/Kconfig
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/Kconfig	2006-04-02 20:22:10.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/Kconfig	2006-04-13 15:58:56.000000000 -0700
@@ -138,8 +138,8 @@ config SPLIT_PTLOCK_CPUS
 #
 config MIGRATION
 	bool "Page migration"
-	def_bool y if NUMA
-	depends on SWAP && NUMA
+	def_bool y
+	depends on NUMA
 	help
 	  Allows the migration of the physical location of pages of processes
 	  while the virtual addresses are not changed. This is useful for
