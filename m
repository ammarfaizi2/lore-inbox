Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316858AbSEVFLN>; Wed, 22 May 2002 01:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316859AbSEVFLM>; Wed, 22 May 2002 01:11:12 -0400
Received: from holomorphy.com ([66.224.33.161]:38288 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316858AbSEVFLK>;
	Wed, 22 May 2002 01:11:10 -0400
Date: Tue, 21 May 2002 22:11:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: noninterfering drop_page()
Message-ID: <20020522051102.GN2046@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brewed this up a while ago as part of the rmap_locking project, though
the forward port itself hasn't gone through much more than a test boot.
Let me know how it goes.


Cheers,
Bill


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.423   -> 1.424  
#	include/linux/swap.h	1.34    -> 1.35   
#	  include/linux/mm.h	1.43    -> 1.44   
#	         mm/vmscan.c	1.69    -> 1.70   
#	           mm/swap.c	1.20    -> 1.21   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/21	wli@tisifone.holomorphy.com	1.424
# Noninterfering drop_page(). Doesn't grab at the global lock, but rather sets a per-page flag
# signalling to VM scanning that the page should be aggressively reclaimed.
# --------------------------------------------
#
diff --minimal -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	Tue May 21 22:08:14 2002
+++ b/include/linux/mm.h	Tue May 21 22:08:14 2002
@@ -306,6 +306,7 @@
 #define PG_reserved		14
 #define PG_launder		15	/* written out by VM pressure.. */
 #define PG_chainlock		16	/* lock bit for ->pte_chain */
+#define PG_drop			17	/* hint bit to drop a page */
 
 /* Make it prettier to test the above... */
 #define UnlockPage(page)	unlock_page(page)
@@ -322,6 +323,9 @@
 #define SetPageChecked(page)	set_bit(PG_checked, &(page)->flags)
 #define PageLaunder(page)	test_bit(PG_launder, &(page)->flags)
 #define SetPageLaunder(page)	set_bit(PG_launder, &(page)->flags)
+#define PageDrop(page)		test_bit(PG_drop, &(page)->flags)
+#define SetPageDrop(page)	set_bit(PG_drop, &(page)->flags)
+#define ClearPageDrop(page)	clear_bit(PG_drop, &(page)->flags)
 
 /*
  * inlines for acquisition and release of PG_chainlock
diff --minimal -Nru a/include/linux/swap.h b/include/linux/swap.h
--- a/include/linux/swap.h	Tue May 21 22:08:14 2002
+++ b/include/linux/swap.h	Tue May 21 22:08:14 2002
@@ -123,6 +123,7 @@
 extern void FASTCALL(deactivate_page(struct page *));
 extern void FASTCALL(deactivate_page_nolock(struct page *));
 extern void FASTCALL(drop_page(struct page *));
+extern void FASTCALL(deactivate_dropped_page(struct page *));
 
 extern void swap_setup(void);
 
diff --minimal -Nru a/mm/swap.c b/mm/swap.c
--- a/mm/swap.c	Tue May 21 22:08:14 2002
+++ b/mm/swap.c	Tue May 21 22:08:14 2002
@@ -69,28 +69,42 @@
  * drop_page - like deactivate_page, but try inactive_clean list
  * @page: the page to drop
  *
- * Try to move a page to the inactive_clean list, this succeeds if the
- * page is clean and not in use by anybody. If the page cannot be placed
- * on the inactive_clean list it is placed on the inactive_dirty list
- * instead.
- *
- * Note: this function gets called with the pagemap_lru_lock held.
+ * Grabs PG_locked and does try_to_release_page(), must be called with
+ * elevated reference count to page, trying to release buffers
+ * associated with a page, then direct VM scanning to try to deactivate
+ * the page to the inactive_clean list if it's not still in use.
+ * Must be called with an elevated reference to the page and also
+ * without PG_locked.
  */
 void drop_page(struct page * page)
 {
-	if (!TryLockPage(page)) {
-		if (page->mapping && page->buffers) {
-			page_cache_get(page);
-			spin_unlock(&pagemap_lru_lock);
-			try_to_release_page(page, GFP_NOIO);
-			spin_lock(&pagemap_lru_lock);
-			page_cache_release(page);
-		}
-		UnlockPage(page);
-	}
+	if (TryLockPage(page))
+		goto out;
+
+	if (!page->mapping || !page->buffers)
+		goto out_unlock;
+
+	try_to_release_page(page, GFP_NOIO);
 
+out_unlock:
+	UnlockPage(page);
+out:
+	SetPageDrop(page);
+}
+
+
+/**
+ * deactivate dropped_page - like deactivate_page, but try inactive_clean
+ * @page: the page to deactivate
+ *
+ * Try to move a page to the inactive_clean list, this succeeeds if the
+ * page is clean and not in use by anybody. If the page cannot be placed
+ * on the inactive_clean list it is placed on the inactive_dirty list.
+ * The caller must hold the pagemap_lru_lock, PG_locked, and PG_chainlock
+ */
+void deactivate_dropped_page(struct page *page)
+{
 	/* Make sure the page really is reclaimable. */
-	pte_chain_lock(page);
 	if (!page->mapping || PageDirty(page) || page->pte_chain ||
 			page->buffers || page_count(page) > 1)
 		deactivate_page_nolock(page);
@@ -106,7 +120,7 @@
 			add_page_to_inactive_clean_list(page);
 		}
 	}
-	pte_chain_unlock(page);
+	ClearPageDrop(page);
 }
 
 /*
diff --minimal -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Tue May 21 22:08:14 2002
+++ b/mm/vmscan.c	Tue May 21 22:08:14 2002
@@ -506,10 +506,10 @@
 		 * both PG_locked and the pte_chain_lock are held.
 		 */
 		pte_chain_lock(page);
-		if (!page_mapping_inuse(page)) {
+		if (PageDrop(page) || !page_mapping_inuse(page)) {
+			deactivate_dropped_page(page);
 			pte_chain_unlock(page);
 			UnlockPage(page);
-			drop_page(page);
 			continue;
 		}
 
