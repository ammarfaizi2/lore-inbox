Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266760AbRGFRU5>; Fri, 6 Jul 2001 13:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266763AbRGFRUh>; Fri, 6 Jul 2001 13:20:37 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:38668 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S266760AbRGFRUd>; Fri, 6 Jul 2001 13:20:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Page LRU State as Scalar
Date: Fri, 6 Jul 2001 19:24:03 +0200
X-Mailer: KMail [version 1.2]
Cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Mike Galbraith <mikeg@wen-online.de>,
        Andrew Morton <andrewm@uow.edu.au>
MIME-Version: 1.0
Message-Id: <01070619240300.22952@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch combines the three lru state bits in page->flags into a single
scalar field of two bits.  In this case, setting the scalar value never 
costs more than setting a single bit does because each change of state goes
through an intermediate step of clearing the state bits to zero, so a single
or instruction suffices.

There is in fact a slight improvement in efficiency because switch statements
can be substituted for chained conditionals, and if there is room for more if
gcc is improved to generate better code for switches (it overlooks the fact
that the switch expression is two bits wide and generates a redundant test).
Testing the state costs an extra masking instruction, but this is done only
on debug paths.  The long series of debug checks in free_pages_ok is
shortened by two.  All in all, this should be a wash in terms of efficiency.

The state is always tested and set under protection of the pagemap_lru_lock,
so there should not be any new races.

The motivation for this patch is to provide some infrastructure for memory
management experiments using more than three lru lists, along the lines of
what we have been discussing recently in the VM Requirement Document thread.

To apply:

  cd /your/2.4.6-sourcetree
  patch <thispatch -p0

--- ../uml.2.4.6.clean/include/linux/mm.h	Wed Jul  4 00:42:55 2001
+++ ./include/linux/mm.h	Fri Jul  6 18:31:14 2001
@@ -274,15 +274,14 @@
 #define PG_uptodate		 3
 #define PG_dirty		 4
 #define PG_decr_after		 5
-#define PG_active		 6
-#define PG_inactive_dirty	 7
 #define PG_slab			 8
 #define PG_swap_cache		 9
 #define PG_skip			10
-#define PG_inactive_clean	11
 #define PG_highmem		12
 #define PG_checked		13	/* kill me in 2.5.<early>. */
-				/* bits 21-29 unused */
+				/* bits 6, 7, 11 and 21-29 unused */
+#define PG_state_shift		14
+#define PG_state_mask		(3 << PG_state_shift)
 #define PG_arch_1		30
 #define PG_reserved		31
 
@@ -344,17 +343,24 @@
 
 #define PageTestandClearSwapCache(page)	test_and_clear_bit(PG_swap_cache, &(page)->flags)
 
-#define PageActive(page)	test_bit(PG_active, &(page)->flags)
-#define SetPageActive(page)	set_bit(PG_active, &(page)->flags)
-#define ClearPageActive(page)	clear_bit(PG_active, &(page)->flags)
-
-#define PageInactiveDirty(page)	test_bit(PG_inactive_dirty, &(page)->flags)
-#define SetPageInactiveDirty(page)	set_bit(PG_inactive_dirty, &(page)->flags)
-#define ClearPageInactiveDirty(page)	clear_bit(PG_inactive_dirty, &(page)->flags)
-
-#define PageInactiveClean(page)	test_bit(PG_inactive_clean, &(page)->flags)
-#define SetPageInactiveClean(page)	set_bit(PG_inactive_clean, &(page)->flags)
-#define ClearPageInactiveClean(page)	clear_bit(PG_inactive_clean, &(page)->flags)
+#define PG_Nolist 0
+#define PG_Active 1
+#define PG_InactiveClean 2
+#define PG_InactiveDirty 3
+
+#define PageNolist(page)	(((page)->flags & PG_state_mask) == PG_Nolist << PG_state_shift)
+#define PageActive(page)	(((page)->flags & PG_state_mask) == PG_Active << PG_state_shift)
+#define PageInactiveClean(page)	(((page)->flags & PG_state_mask) == PG_InactiveClean << PG_state_shift)
+#define PageInactiveDirty(page)	(((page)->flags & PG_state_mask) == PG_InactiveDirty << PG_state_shift)
+
+#define SetPageNolist(page)	   ((page)->flags &= ~PG_state_mask)
+#define SetPageActive(page)	   ((page)->flags |= PG_Active << PG_state_shift)
+#define SetPageInactiveClean(page) ((page)->flags |= PG_InactiveClean << PG_state_shift)
+#define SetPageInactiveDirty(page) ((page)->flags |= PG_InactiveDirty << PG_state_shift)
+
+#define ClearPageActive SetPageNolist
+#define ClearPageInactiveClean SetPageNolist
+#define ClearPageInactiveDirty SetPageNolist
 
 #ifdef CONFIG_HIGHMEM
 #define PageHighMem(page)		test_bit(PG_highmem, &(page)->flags)
--- ../uml.2.4.6.clean/include/linux/swap.h	Wed Jul  4 00:42:55 2001
+++ ./include/linux/swap.h	Fri Jul  6 17:26:39 2001
@@ -182,8 +182,7 @@
  * with the pagemap_lru_lock held!
  */
 #define DEBUG_ADD_PAGE \
-	if (PageActive(page) || PageInactiveDirty(page) || \
-					PageInactiveClean(page)) BUG();
+	if (!PageNolist(page)) BUG();
 
 #define ZERO_PAGE_BUG \
 	if (page_count(page) == 0) BUG();
--- ../uml.2.4.6.clean/mm/page_alloc.c	Sat Jun 30 00:39:41 2001
+++ ./mm/page_alloc.c	Fri Jul  6 17:25:41 2001
@@ -81,11 +81,7 @@
 		BUG();
 	if (PageDecrAfter(page))
 		BUG();
-	if (PageActive(page))
-		BUG();
-	if (PageInactiveDirty(page))
-		BUG();
-	if (PageInactiveClean(page))
+	if (!PageNolist(page))
 		BUG();
 
 	page->flags &= ~((1<<PG_referenced) | (1<<PG_dirty));
--- ../uml.2.4.6.clean/mm/swap.c	Mon Jan 22 22:30:21 2001
+++ ./mm/swap.c	Fri Jul  6 16:36:27 2001
@@ -197,13 +197,17 @@
  */
 void activate_page_nolock(struct page * page)
 {
-	if (PageInactiveDirty(page)) {
+	switch ((page->flags & PG_state_mask) >> PG_state_shift)
+	{
+	case PG_InactiveDirty:
 		del_page_from_inactive_dirty_list(page);
 		add_page_to_active_list(page);
-	} else if (PageInactiveClean(page)) {
+		break;
+	case PG_InactiveClean:
 		del_page_from_inactive_clean_list(page);
 		add_page_to_active_list(page);
-	} else {
+		break;
+	default:
 		/*
 		 * The page was not on any list, so we take care
 		 * not to do anything.
@@ -248,16 +252,21 @@
  */
 void __lru_cache_del(struct page * page)
 {
-	if (PageActive(page)) {
+	switch ((page->flags & PG_state_mask) >> PG_state_shift)
+	{
+	case PG_Active:
 		del_page_from_active_list(page);
-	} else if (PageInactiveDirty(page)) {
-		del_page_from_inactive_dirty_list(page);
-	} else if (PageInactiveClean(page)) {
+		break;
+	case PG_InactiveClean:
 		del_page_from_inactive_clean_list(page);
-	} else {
+		break;
+	case PG_InactiveDirty:
+		del_page_from_inactive_dirty_list(page);
+		break;
+	default:
 		printk("VM: __lru_cache_del, found unknown page ?!\n");
+		DEBUG_ADD_PAGE
 	}
-	DEBUG_ADD_PAGE
 }
 
 /**
