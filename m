Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWDNR3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWDNR3Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 13:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWDNR3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 13:29:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:428 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751312AbWDNR3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 13:29:24 -0400
Date: Fri, 14 Apr 2006 10:29:01 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, hugh@veritas.com,
       linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       linux-mm@kvack.org, taka@valinux.co.jp, marcelo.tosatti@cyclades.com
Subject: Preserve write permissions in migration entries
In-Reply-To: <20060414114437.1a5a9c7c.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0604141023550.18575@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
 <20060413235432.15398.23912.sendpatchset@schroedinger.engr.sgi.com>
 <20060414101959.d59ac82d.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604131832020.16220@schroedinger.engr.sgi.com>
 <20060414113455.15fd5162.kamezawa.hiroyu@jp.fujitsu.com>
 <20060414114437.1a5a9c7c.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cleaned up the patch a bit and ran some tests.


This patch implements the preservation of the write permissions.
The preservation of write permission avoids unnecessary COW operations
following page migration.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.17-rc1-mm2/include/linux/swap.h
===================================================================
--- linux-2.6.17-rc1-mm2.orig/include/linux/swap.h	2006-04-14 09:08:42.000000000 -0700
+++ linux-2.6.17-rc1-mm2/include/linux/swap.h	2006-04-14 10:01:27.000000000 -0700
@@ -33,8 +33,9 @@ static inline int current_is_kswapd(void
 #define MAX_SWAPFILES		(1 << MAX_SWAPFILES_SHIFT)
 #else
 /* Use last entry for page migration swap entries */
-#define MAX_SWAPFILES		((1 << MAX_SWAPFILES_SHIFT)-1)
-#define SWP_TYPE_MIGRATION	MAX_SWAPFILES
+#define MAX_SWAPFILES		((1 << MAX_SWAPFILES_SHIFT)-2)
+#define SWP_MIGRATION_READ	MAX_SWAPFILES
+#define SWP_MIGRATION_WRITE	(MAX_SWAPFILES + 1)
 #endif
 
 /*
Index: linux-2.6.17-rc1-mm2/include/linux/swapops.h
===================================================================
--- linux-2.6.17-rc1-mm2.orig/include/linux/swapops.h	2006-04-14 09:55:25.000000000 -0700
+++ linux-2.6.17-rc1-mm2/include/linux/swapops.h	2006-04-14 10:06:43.000000000 -0700
@@ -69,15 +69,22 @@ static inline pte_t swp_entry_to_pte(swp
 }
 
 #ifdef CONFIG_MIGRATION
-static inline swp_entry_t make_migration_entry(struct page *page)
+static inline swp_entry_t make_migration_entry(struct page *page, int write)
 {
 	BUG_ON(!PageLocked(page));
-	return swp_entry(SWP_TYPE_MIGRATION, page_to_pfn(page));
+	return swp_entry(write ? SWP_MIGRATION_WRITE : SWP_MIGRATION_READ,
+			 page_to_pfn(page));
 }
 
 static inline int is_migration_entry(swp_entry_t entry)
 {
-	return unlikely(swp_type(entry) == SWP_TYPE_MIGRATION);
+	return unlikely(swp_type(entry) == SWP_MIGRATION_READ ||
+			swp_type(entry) == SWP_MIGRATION_WRITE);
+}
+
+static inline int is_write_migration_entry(swp_entry_t entry)
+{
+	return swp_type(entry) == SWP_MIGRATION_WRITE;
 }
 
 static inline struct page *migration_entry_to_page(swp_entry_t entry)
Index: linux-2.6.17-rc1-mm2/mm/rmap.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/rmap.c	2006-04-13 16:43:24.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/rmap.c	2006-04-14 10:04:27.000000000 -0700
@@ -602,7 +602,7 @@ static int try_to_unmap_one(struct page 
 			 * pte is removed and then restart fault handling.
 			 */
 			BUG_ON(!migration);
-			entry = make_migration_entry(page);
+			entry = make_migration_entry(page, pte_write(pteval));
 		}
 		set_pte_at(mm, address, pte, swp_entry_to_pte(entry));
 		BUG_ON(pte_file(*pte));
Index: linux-2.6.17-rc1-mm2/mm/migrate.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/migrate.c	2006-04-13 16:44:07.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/migrate.c	2006-04-14 10:06:01.000000000 -0700
@@ -167,7 +167,10 @@ static void remove_migration_pte(struct 
 
 	inc_mm_counter(mm, anon_rss);
 	get_page(new);
-	set_pte_at(mm, addr, ptep, pte_mkold(mk_pte(new, vma->vm_page_prot)));
+	pte = pte_mkold(mk_pte(new, vma->vm_page_prot));
+	if (is_write_migration_entry(entry))
+		pte = pte_mkwrite(pte);
+	set_pte_at(mm, addr, ptep, pte);
 	page_add_anon_rmap(new, vma, addr);
 out:
 	pte_unmap_unlock(pte, ptl);
