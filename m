Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161059AbWBTWhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbWBTWhz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbWBTWh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:37:29 -0500
Received: from linuxhacker.ru ([217.76.32.60]:46742 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S1161059AbWBTWgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:36:55 -0500
Date: Tue, 21 Feb 2006 00:38:10 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: linux-kernel@vger.kernel.org
Subject: Request for export of truncate_complete_page
Message-ID: <20060220223810.GD5733@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Can I ask for truncate_complete_page() to be exported?
   For Lustre filesystem it is necessary to poke out pages in the middle of
   a file, but truncate_inode_pages() is not very suitable, because we
   poke those pages one at a time when locks on those pages are cancelled, but
   we cannot kill entire set of pages as a group, because there might be some
   other lock that covers a subset of those pages, so we still need to iterate
   through all of them, and while we are at it, it is easier to kill pages
   as we check them one by one.

--- linux-2.6.16-rc4/include/linux/mm.h.orig	2006-02-21 00:22:58.000000000 +0200
+++ linux-2.6.16-rc4/include/linux/mm.h	2006-02-21 00:23:37.000000000 +0200
@@ -941,6 +941,8 @@ extern unsigned long do_brk(unsigned lon
 
 /* filemap.c */
 extern unsigned long page_unuse(struct page *);
+extern void truncate_complete_page(struct address_space *mapping,
+                                   struct page *page);
 extern void truncate_inode_pages(struct address_space *, loff_t);
 extern void truncate_inode_pages_range(struct address_space *,
 				       loff_t lstart, loff_t lend);
--- linux-2.6.16-rc4/mm/truncate.c.orig	2006-02-21 00:20:27.000000000 +0200
+++ linux-2.6.16-rc4/mm/truncate.c	2006-02-21 00:21:42.000000000 +0200
@@ -33,7 +33,7 @@ static inline void truncate_partial_page
  * its lock, b) when a concurrent invalidate_inode_pages got there first and
  * c) when tmpfs swizzles a page between a tmpfs inode and swapper_space.
  */
-static void
+void
 truncate_complete_page(struct address_space *mapping, struct page *page)
 {
 	if (page->mapping != mapping)
@@ -48,6 +48,7 @@ truncate_complete_page(struct address_sp
 	remove_from_page_cache(page);
 	page_cache_release(page);	/* pagecache ref */
 }
+EXPORT_SYMBOL(truncate_complete_page);
 
 /*
  * This is for invalidate_inode_pages().  That function can be called at


Bye,
    Oleg
