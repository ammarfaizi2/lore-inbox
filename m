Return-Path: <linux-kernel-owner+w=401wt.eu-S1754981AbXABV5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754981AbXABV5e (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754986AbXABV5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:57:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2721 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754981AbXABV5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:57:32 -0500
Date: Tue, 2 Jan 2007 22:57:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Nick Piggin <npiggin@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] the scheduled find_trylock_page() removal
Message-ID: <20070102215735.GD20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the scheduled find_trylock_page() removal.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/feature-removal-schedule.txt |   12 ------------
 include/linux/pagemap.h                    |    2 --
 mm/filemap.c                               |   20 --------------------
 3 files changed, 34 deletions(-)

--- linux-2.6.20-rc2-mm1/Documentation/feature-removal-schedule.txt.old	2007-01-02 21:34:57.000000000 +0100
+++ linux-2.6.20-rc2-mm1/Documentation/feature-removal-schedule.txt	2007-01-02 21:35:12.000000000 +0100
@@ -163,18 +163,6 @@
 
 ---------------------------
 
-What:	find_trylock_page
-When:	January 2007
-Why:	The interface no longer has any callers left in the kernel. It
-	is an odd interface (compared with other find_*_page functions), in
-	that it does not take a refcount to the page, only the page lock.
-	It should be replaced with find_get_page or find_lock_page if possible.
-	This feature removal can be reevaluated if users of the interface
-	cannot cleanly use something else.
-Who:	Nick Piggin <npiggin@suse.de>
-
----------------------------
-
 What:	Interrupt only SA_* flags
 When:	Januar 2007
 Why:	The interrupt related SA_* flags are replaced by IRQF_* to move them
--- linux-2.6.20-rc2-mm1/include/linux/pagemap.h.old	2007-01-02 21:35:20.000000000 +0100
+++ linux-2.6.20-rc2-mm1/include/linux/pagemap.h	2007-01-02 21:35:26.000000000 +0100
@@ -78,8 +78,6 @@
 				unsigned long index);
 extern struct page * find_lock_page(struct address_space *mapping,
 				unsigned long index);
-extern __deprecated_for_modules struct page * find_trylock_page(
-			struct address_space *mapping, unsigned long index);
 extern struct page * find_or_create_page(struct address_space *mapping,
 				unsigned long index, gfp_t gfp_mask);
 unsigned find_get_pages(struct address_space *mapping, pgoff_t start,
--- linux-2.6.20-rc2-mm1/mm/filemap.c.old	2007-01-02 21:35:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1/mm/filemap.c	2007-01-02 21:36:36.000000000 +0100
@@ -630,26 +630,6 @@
 EXPORT_SYMBOL(find_get_page);
 
 /**
- * find_trylock_page - find and lock a page
- * @mapping: the address_space to search
- * @offset: the page index
- *
- * Same as find_get_page(), but trylock it instead of incrementing the count.
- */
-struct page *find_trylock_page(struct address_space *mapping, unsigned long offset)
-{
-	struct page *page;
-
-	read_lock_irq(&mapping->tree_lock);
-	page = radix_tree_lookup(&mapping->page_tree, offset);
-	if (page && TestSetPageLocked(page))
-		page = NULL;
-	read_unlock_irq(&mapping->tree_lock);
-	return page;
-}
-EXPORT_SYMBOL(find_trylock_page);
-
-/**
  * find_lock_page - locate, pin and lock a pagecache page
  * @mapping: the address_space to search
  * @offset: the page index

