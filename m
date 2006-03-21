Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWCUTo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWCUTo4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWCUTo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:44:56 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:28333 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750940AbWCUToz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:44:55 -0500
Subject: [PATCH 1/2] add API for flushing Anon pages
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 13:44:46 -0600
Message-Id: <1142970286.3428.14.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, get_user_pages() returns fully coherent pages to the kernel
for anything other than anonymous pages.  This is a problem for things
like fuse and the SCSI generic ioctl SG_IO which can potentially wish
to do DMA to anonymous pages passed in by users.

The fix is to add a new memory management API: flush_anon_page() which
is used in get_user_pages() to make anonymous pages coherent.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

Index: BUILD-2.6/Documentation/cachetlb.txt
===================================================================
--- BUILD-2.6.orig/Documentation/cachetlb.txt	2006-03-20 10:44:45.000000000 -0600
+++ BUILD-2.6/Documentation/cachetlb.txt	2006-03-21 13:38:32.000000000 -0600
@@ -362,6 +362,15 @@
 	likely that you will need to flush the instruction cache
 	for copy_to_user_page().
 
+  void flush_anon_page(struct page *page, unsigned long vmaddr)
+  	When the kernel needs to access the contents of an anonymous
+	page, it calls this function (currently only
+	get_user_pages()).  Note: flush_dcache_page() deliberately
+	doesn't work for an anonymous page.  The default
+	implementation is a nop (and should remain so for all coherent
+	architectures).  For incoherent architectures, it should flush
+	the cache of the page at vmaddr in the current user process.
+
   void flush_icache_range(unsigned long start, unsigned long end)
   	When the kernel stores into addresses that it will execute
 	out of (eg when loading modules), this function is called.
Index: BUILD-2.6/include/linux/highmem.h
===================================================================
--- BUILD-2.6.orig/include/linux/highmem.h	2006-03-20 10:44:46.000000000 -0600
+++ BUILD-2.6/include/linux/highmem.h	2006-03-21 13:38:24.000000000 -0600
@@ -7,6 +7,12 @@
 
 #include <asm/cacheflush.h>
 
+#ifndef ARCH_HAS_FLUSH_ANON_PAGE
+static inline void flush_anon_page(struct page *page, unsigned long vmaddr)
+{
+}
+#endif
+
 #ifdef CONFIG_HIGHMEM
 
 #include <asm/highmem.h>
Index: BUILD-2.6/mm/memory.c
===================================================================
--- BUILD-2.6.orig/mm/memory.c	2006-03-20 10:44:46.000000000 -0600
+++ BUILD-2.6/mm/memory.c	2006-03-20 10:44:55.000000000 -0600
@@ -1074,6 +1074,8 @@
 			}
 			if (pages) {
 				pages[i] = page;
+
+				flush_anon_page(page, start);
 				flush_dcache_page(page);
 			}
 			if (vmas)


