Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbWDNCdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbWDNCdd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 22:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbWDNCdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 22:33:33 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:18093 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965039AbWDNCdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 22:33:32 -0400
Date: Fri, 14 Apr 2006 11:34:55 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, hugh@veritas.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, linux-mm@kvack.org, taka@valinux.co.jp,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 5/5] Swapless V2: Revise main migration logic
Message-Id: <20060414113455.15fd5162.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0604131832020.16220@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
	<20060413235432.15398.23912.sendpatchset@schroedinger.engr.sgi.com>
	<20060414101959.d59ac82d.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604131832020.16220@schroedinger.engr.sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2006 18:33:07 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Fri, 14 Apr 2006, KAMEZAWA Hiroyuki wrote:
> 
> > For hotremove (I stops it now..), we should fix this later (if we can do).
> > If new SWP_TYPE_MIGRATION swp entry can contain write protect bit,
> > hotremove can avoid copy-on-write but things will be more complicated.
> 
> This is a known issue.I'd be glad if you could come up with a working 
> scheme to solve this that is simple.
> 

This patch can fix copy-on-write problem.
I just compiled this patch (because I cannot use NUMA now.)

BTW, why MAX_SWAPFILES_SHIFT==5 now ? required by some arch ?

-Kame
==

This patch removes unnecessary copy-on-write after page migraiton.

This patch preserve writable(write-protection) bit in swap entry,
and make pte writable/protected when push it back.

Because I don't understand why MAX_SWAPFILES_SHIFT==5 now,
This patch uses one more swap type for migration.
(By this patch, available swp type goes down to 30.)

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: Christoph-New-Migration/include/linux/swap.h
===================================================================
--- Christoph-New-Migration.orig/include/linux/swap.h	2006-04-14 11:13:38.000000000 +0900
+++ Christoph-New-Migration/include/linux/swap.h	2006-04-14 11:13:55.000000000 +0900
@@ -33,8 +33,11 @@
 #define MAX_SWAPFILES		(1 << MAX_SWAPFILES_SHIFT)
 #else
 /* Use last entry for page migration swap entries */
-#define MAX_SWAPFILES		((1 << MAX_SWAPFILES_SHIFT)-1)
-#define SWP_TYPE_MIGRATION	MAX_SWAPFILES
+#define MAX_SWAPFILES		((1 << MAX_SWAPFILES_SHIFT)-2)
+/* write protected page under migration*/
+#define SWP_TYPE_MIGRATION_WP	(MAX_SWAPFILES - 1)
+/* write enabled migration type */
+#define SWP_TYPE_MIGRATION_WE	(MAX_SWAPFILES)
 #endif
 
 /*
Index: Christoph-New-Migration/include/linux/swapops.h
===================================================================
--- Christoph-New-Migration.orig/include/linux/swapops.h	2006-04-14 11:13:38.000000000 +0900
+++ Christoph-New-Migration/include/linux/swapops.h	2006-04-14 11:13:55.000000000 +0900
@@ -69,17 +69,32 @@
 }
 
 #ifdef CONFIG_MIGRATION
-static inline swp_entry_t make_migration_entry(struct page *page)
+static inline swp_entry_t make_migration_entry(struct page *page, int writable)
 {
 	BUG_ON(!PageLocked(page));
-	return swp_entry(SWP_TYPE_MIGRATION, page_to_pfn(page));
+	if (writable)
+		return swp_entry(SWP_TYPE_MIGRATION_WE, page_to_pfn(page));
+	else
+		return swp_entry(SWP_TYPE_MIGRATION_WP, page_to_pfn(page));
 }
 
 static inline int is_migration_entry(swp_entry_t entry)
 {
-	return swp_type(entry) == SWP_TYPE_MIGRATION;
+	return (swp_type(entry) == SWP_TYPE_MIGRATION_WP) ||
+	       (swp_type(entry) == SWP_TYPE_MIGRATION_WE);
 }
 
+static inline int is_migration_entry_wp(swp_entry_t entry)
+{
+	return (swp_type(entry) == SWP_TYPE_MIGRATION_WP);
+}
+
+static inline int is_migration_entry_we(swp_entry_t entry)
+{
+	return (swp_type(entry) == SWP_TYPE_MIGRATION_WE);
+}
+
+
 static inline struct page *migration_entry_to_page(swp_entry_t entry)
 {
 	struct page *p = pfn_to_page(swp_offset(entry));
Index: Christoph-New-Migration/mm/migrate.c
===================================================================
--- Christoph-New-Migration.orig/mm/migrate.c	2006-04-14 11:13:49.000000000 +0900
+++ Christoph-New-Migration/mm/migrate.c	2006-04-14 11:13:55.000000000 +0900
@@ -167,7 +167,11 @@
 
 	inc_mm_counter(mm, anon_rss);
 	get_page(new);
-	set_pte_at(mm, addr, ptep, pte_mkold(mk_pte(new, vma->vm_page_prot)));
+	pte = pte_mkold(mk_pte(new, vma->vm_page_prot));
+	if (is_migration_entry_we(entry)) {
+		pte = pte_mkwrite(pte);
+	}
+	set_pte_at(mm, addr, ptep, pte);
 	page_add_anon_rmap(new, vma, addr);
 out:
 	pte_unmap_unlock(pte, ptl);
Index: Christoph-New-Migration/mm/rmap.c
===================================================================
--- Christoph-New-Migration.orig/mm/rmap.c	2006-04-14 11:13:45.000000000 +0900
+++ Christoph-New-Migration/mm/rmap.c	2006-04-14 11:13:55.000000000 +0900
@@ -602,7 +602,10 @@
 			 * pte is removed and then restart fault handling.
 			 */
 			BUG_ON(!migration);
-			entry = make_migration_entry(page);
+			if (pte_write(pteval))
+				entry = make_migration_entry(page, 1);
+			else
+				entry = make_migration_entry(page, 0);
 		}
 		set_pte_at(mm, address, pte, swp_entry_to_pte(entry));
 		BUG_ON(pte_file(*pte));

