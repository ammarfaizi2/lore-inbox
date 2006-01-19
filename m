Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161373AbWASTzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161373AbWASTzX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161374AbWASTzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:55:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:13784 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161373AbWASTzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:55:21 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <20060119195404.14171.55511.sendpatchset@linux.site>
In-Reply-To: <20060119195355.14171.14613.sendpatchset@linux.site>
References: <20060119195355.14171.14613.sendpatchset@linux.site>
Subject: [resend][patch 6/6] mm: de-skew page refcounting
Date: Thu, 19 Jan 2006 20:55:15 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

atomic_add_unless (atomic_inc_not_zero) no longer requires an offset
refcount to function correctly.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -286,15 +286,6 @@ struct page {
  *
  * Also, many kernel routines increase the page count before a critical
  * routine so they can be sure the page doesn't go away from under them.
- *
- * Since 2.6.6 (approx), a free page has ->_count = -1.  This is so that we
- * can use atomic_add_negative(-1, page->_count) to detect when the page
- * becomes free and so that we can also use atomic_inc_and_test to atomically
- * detect when we just tried to grab a ref on a page which some other CPU has
- * already deemed to be freeable.
- *
- * NO code should make assumptions about this internal detail!  Use the provided
- * macros which retain the old rules: page_count(page) == 0 is a free page.
  */
 
 /*
@@ -303,8 +294,8 @@ struct page {
  */
 static inline int put_page_testzero(struct page *page)
 {
-	BUG_ON(atomic_read(&page->_count) == -1);
-	return atomic_add_negative(-1, &page->_count);
+	BUG_ON(atomic_read(&page->_count) == 0);
+	return atomic_dec_and_test(&page->_count);
 }
 
 /*
@@ -313,10 +304,10 @@ static inline int put_page_testzero(stru
  */
 static inline int get_page_unless_zero(struct page *page)
 {
-	return atomic_add_unless(&page->_count, 1, -1);
+	return atomic_inc_not_zero(&page->_count);
 }
 
-#define set_page_count(p,v) 	atomic_set(&(p)->_count, (v) - 1)
+#define set_page_count(p,v) 	atomic_set(&(p)->_count, (v))
 #define __put_page(p)		atomic_dec(&(p)->_count)
 
 extern void FASTCALL(__page_cache_release(struct page *));
@@ -325,7 +316,7 @@ static inline int page_count(struct page
 {
 	if (PageCompound(page))
 		page = (struct page *)page_private(page);
-	return atomic_read(&page->_count) + 1;
+	return atomic_read(&page->_count);
 }
 
 static inline void get_page(struct page *page)
