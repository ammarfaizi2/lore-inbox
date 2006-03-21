Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWCUTpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWCUTpu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWCUTpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:45:50 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:30893 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750940AbWCUTpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:45:49 -0500
Subject: [PATCH 2/2] add flush_kernel_dcache_page() API
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 13:45:41 -0600
Message-Id: <1142970341.3428.15.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a problem in a lot of emulated storage in that it takes a page
from get_user_pages() and does something like

kmap_atomic(page)
modify page
kunmap_atomic(page)

However, nothing has flushed the kernel cache view of the page before
the kunmap.  We need a lightweight API to do this, so this new API
would specifically be for flushing the kernel cache view of a user
page which the kernel has modified.  The driver would need to add
flush_kernel_dcache_page(page) before the final kunmap.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

Index: BUILD-2.6/Documentation/cachetlb.txt
===================================================================
--- BUILD-2.6.orig/Documentation/cachetlb.txt	2006-03-21 13:37:45.000000000 -0600
+++ BUILD-2.6/Documentation/cachetlb.txt	2006-03-21 13:37:54.000000000 -0600
@@ -371,6 +371,18 @@
 	architectures).  For incoherent architectures, it should flush
 	the cache of the page at vmaddr in the current user process.
 
+  void flush_kernel_dcache_page(struct page *page)
+	When the kernel needs to modify a user page is has obtained
+	with kmap, it calls this function after all modifications are
+	complete (but before kunmapping it) to bring the underlying
+	page up to date.  It is assumed here that the user has no
+	incoherent cached copies (i.e. the original page was obtained
+	from a mechanism like get_user_pages()).  The default
+	implementation is a nop and should remain so on all coherent
+	architectures.  On incoherent architectures, this should flush
+	the kernel cache for page (using page_address(page)).
+
+
   void flush_icache_range(unsigned long start, unsigned long end)
   	When the kernel stores into addresses that it will execute
 	out of (eg when loading modules), this function is called.
Index: BUILD-2.6/include/linux/highmem.h
===================================================================
--- BUILD-2.6.orig/include/linux/highmem.h	2006-03-21 13:37:19.000000000 -0600
+++ BUILD-2.6/include/linux/highmem.h	2006-03-21 13:37:54.000000000 -0600
@@ -13,6 +13,12 @@
 }
 #endif
 
+#ifndef ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+static inline void flush_kernel_dcache_page(struct page *page)
+{
+}
+#endif
+
 #ifdef CONFIG_HIGHMEM
 
 #include <asm/highmem.h>


