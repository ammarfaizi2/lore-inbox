Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVB1PxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVB1PxM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 10:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVB1PxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 10:53:12 -0500
Received: from galileo.bork.org ([134.117.69.57]:41622 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261659AbVB1Pwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 10:52:50 -0500
Date: Mon, 28 Feb 2005 10:52:48 -0500
From: Martin Hicks <mort@wildopensource.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] perthread_pages_alloc cleanup
Message-ID: <20050228155248.GR26705@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

This is just a cleanup - no functional changes.  Gets a bunch of code
outside an if by returning NULL earlier.

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296


Signed-Off-By: Martin Hicks <mort@wildopensource.com>


Index: linux-2.6.10/mm/page_alloc.c
===================================================================
--- linux-2.6.10.orig/mm/page_alloc.c	2005-02-25 08:02:33.000000000 -0800
+++ linux-2.6.10/mm/page_alloc.c	2005-02-28 07:08:01.000000000 -0800
@@ -710,6 +710,7 @@
 perthread_pages_alloc(void)
 {
 	struct list_head *perthread_pages;
+	struct page *page;
 
 	/*
 	 * try to allocate pages from the per-thread private_pages pool. No
@@ -717,18 +718,16 @@
 	 * itself, and not by interrupts or other threads.
 	 */
 	perthread_pages = get_per_thread_pages();
-	if (!in_interrupt() && !list_empty(perthread_pages)) {
-		struct page *page;
-
-		page = list_entry(perthread_pages->next, struct page, lru);
-		list_del(&page->lru);
-		current->private_pages_count--;
-		/*
-		 * per-thread page is already initialized, just return it.
-		 */
-		return page;
-	} else
+	if (in_interrupt() || list_empty(perthread_pages))
 		return NULL;
+
+	page = list_entry(perthread_pages->next, struct page, lru);
+	list_del(&page->lru);
+	current->private_pages_count--;
+	/*
+	 * per-thread page is already initialized, just return it.
+	 */
+	return page;
 }
 
 /*
