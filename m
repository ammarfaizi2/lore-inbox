Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965186AbWDNVvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbWDNVvt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbWDNVvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:51:49 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:49051 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965186AbWDNVvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:51:48 -0400
Date: Fri, 14 Apr 2006 14:51:04 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: hugh@veritas.com, linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       linux-mm@kvack.org, taka@valinux.co.jp, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Wait for migrating page after incr of page count under anon_vma lock
In-Reply-To: <20060414125320.72599c7e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604141417170.22852@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
 <20060413235416.15398.49978.sendpatchset@schroedinger.engr.sgi.com>
 <20060413171331.1752e21f.akpm@osdl.org> <Pine.LNX.4.64.0604131728150.15802@schroedinger.engr.sgi.com>
 <20060413174232.57d02343.akpm@osdl.org> <Pine.LNX.4.64.0604131743180.15965@schroedinger.engr.sgi.com>
 <20060413180159.0c01beb7.akpm@osdl.org> <Pine.LNX.4.64.0604131827210.16220@schroedinger.engr.sgi.com>
 <20060413222921.2834d897.akpm@osdl.org> <Pine.LNX.4.64.0604141025310.18575@schroedinger.engr.sgi.com>
 <20060414113104.72a5059b.akpm@osdl.org> <Pine.LNX.4.64.0604141143520.22475@schroedinger.engr.sgi.com>
 <20060414121537.11134d26.akpm@osdl.org> <Pine.LNX.4.64.0604141214060.22652@schroedinger.engr.sgi.com>
 <20060414125320.72599c7e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another patch that considers the need to prevent the freeing of the page 
and the pte while incrementing the page count.



Wait for migrating page after incr of page count under anon_vma lock

This patch replaces the yield() in do_swap_page with a call to
migration_entry_wait() in the migration code.

migration_entry_wait() locks the anonymous vma of the page and then
safely increments page count before waiting for the page to become
unlocked.

Migration entries are only removed while holding the anon_vma lock
(See remove_migration_ptes). Therefore we can be sure that the
migration pte is not modified and the underlying page is not
removed while holding this lock.

Also make is_migration_entry() unlikely and clean up a unnecessary
BUG_ON.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc1-mm2/mm/memory.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/memory.c	2006-04-13 16:43:10.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/memory.c	2006-04-14 13:57:44.000000000 -0700
@@ -1880,8 +1880,8 @@ static int do_swap_page(struct mm_struct
 
 	entry = pte_to_swp_entry(orig_pte);
 
-	if (unlikely(is_migration_entry(entry))) {
-		yield();
+	if (is_migration_entry(entry)) {
+		migration_entry_wait(entry, page_table);
 		goto out;
 	}
 
Index: linux-2.6.17-rc1-mm2/include/linux/swapops.h
===================================================================
--- linux-2.6.17-rc1-mm2.orig/include/linux/swapops.h	2006-04-13 16:43:10.000000000 -0700
+++ linux-2.6.17-rc1-mm2/include/linux/swapops.h	2006-04-14 13:57:44.000000000 -0700
@@ -77,7 +77,7 @@ static inline swp_entry_t make_migration
 
 static inline int is_migration_entry(swp_entry_t entry)
 {
-	return swp_type(entry) == SWP_TYPE_MIGRATION;
+	return unlikely(swp_type(entry) == SWP_TYPE_MIGRATION);
 }
 
 static inline struct page *migration_entry_to_page(swp_entry_t entry)
@@ -88,14 +88,16 @@ static inline struct page *migration_ent
 	 * corresponding page is locked
 	 */
 	BUG_ON(!PageLocked(p));
-	BUG_ON(!is_migration_entry(entry));
 	return p;
 }
+
+extern void migration_entry_wait(swp_entry_t, pte_t *);
 #else
 
 #define make_migration_entry(page) swp_entry(0, 0)
 #define is_migration_entry(swp) 0
 #define migration_entry_to_page(swp) NULL
+static inline void migration_entry_wait(swp_entry_t entry, pte_t *ptep) { }
 
 #endif
 
Index: linux-2.6.17-rc1-mm2/mm/migrate.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/migrate.c	2006-04-13 16:44:07.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/migrate.c	2006-04-14 14:27:06.000000000 -0700
@@ -174,6 +174,57 @@ out:
 }
 
 /*
+ * Something used the pte of a page under migration. We need to
+ * get to the page and wait until migration is finished.
+ * When we return from this function the fault will be retried.
+ *
+ * This function is called from do_swap_page().
+ */
+void migration_entry_wait(swp_entry_t entry, pte_t *ptep)
+{
+	struct page *page = migration_entry_to_page(entry);
+	unsigned long mapping = (unsigned long)page->mapping;
+	struct anon_vma *anon_vma;
+	pte_t pte;
+
+	if (!mapping ||
+		(mapping & PAGE_MAPPING_ANON) == 0)
+			return;
+	/*
+	 * We hold the mmap_sem lock.
+	 */
+	anon_vma = (struct anon_vma *) (mapping - PAGE_MAPPING_ANON);
+
+	/*
+	 * The anon_vma lock is also taken while removing the migration
+	 * entries. Take the lock here to insure that the migration pte
+	 * is not modified while we increment the page count.
+	 * This is similar to find_get_page().
+	 */
+	spin_lock(&anon_vma->lock);
+	pte = *ptep;
+	if (pte_present(pte) || pte_none(pte) || pte_file(pte)) {
+		spin_unlock(&anon_vma->lock);
+		return;
+	}
+	entry = pte_to_swp_entry(pte);
+	if (!is_migration_entry(entry) ||
+		migration_entry_to_page(entry) != page) {
+			/* Migration entry is gone */
+			spin_unlock(&anon_vma->lock);
+			return;
+	}
+	/* Pages with migration entries must be locked */
+	BUG_ON(!PageLocked(page));
+
+	/* Phew. Finally we can increment the refcount */
+	get_page(page);
+	spin_unlock(&anon_vma->lock);
+	wait_on_page_locked(page);
+	put_page(page);
+}
+
+/*
  * Get rid of all migration entries and replace them by
  * references to the indicated page.
  *
