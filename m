Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWDTQ7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWDTQ7p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 12:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWDTQ7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 12:59:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24711 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751139AbWDTQ7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 12:59:44 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/7] FS-Cache: Provide a filesystem-specific sync'able page bit
Date: Thu, 20 Apr 2006 17:59:27 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com, sct@redhat.com,
       aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch provides a filesystem-specific page bit that a filesystem
can synchronise upon.  This can be used, for example, by a netfs to synchronise
with CacheFS writing its pages to disk.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/page-flags.h |   10 ++++++++++
 include/linux/pagemap.h    |   11 +++++++++++
 mm/filemap.c               |   17 +++++++++++++++++
 3 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index d276a4e..5486874 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -74,6 +74,7 @@
 #define PG_slab			 7	/* slab debug (Suparna wants this) */
 
 #define PG_checked		 8	/* kill me in 2.5.<early>. */
+#define PG_fs_misc		 8
 #define PG_arch_1		 9
 #define PG_reserved		10
 #define PG_private		11	/* Has something at ->private */
@@ -376,4 +377,13 @@ static inline void set_page_writeback(st
 	test_set_page_writeback(page);
 }
 
+/*
+ * Filesystem-specific page bit testing
+ */
+#define PageFsMisc(page)		test_bit(PG_fs_misc, &(page)->flags)
+#define SetPageFsMisc(page)		set_bit(PG_fs_misc, &(page)->flags)
+#define TestSetPageFsMisc(page)		test_and_set_bit(PG_fs_misc, &(page)->flags)
+#define ClearPageFsMisc(page)		clear_bit(PG_fs_misc, &(page)->flags)
+#define TestClearPageFsMisc(page)	test_and_clear_bit(PG_fs_misc, &(page)->flags)
+
 #endif	/* PAGE_FLAGS_H */
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 9539efd..02e7d8b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -206,6 +206,17 @@ static inline void wait_on_page_writebac
 extern void end_page_writeback(struct page *page);
 
 /*
+ * Wait for filesystem-specific page synchronisation to complete
+ */
+static inline void wait_on_page_fs_misc(struct page *page)
+{
+	if (PageFsMisc(page))
+		wait_on_page_bit(page, PG_fs_misc);
+}
+
+extern void fastcall end_page_fs_misc(struct page *page);
+
+/*
  * Fault a userspace page into pagetables.  Return non-zero on a fault.
  *
  * This assumes that two userspace pages are always sufficient.  That's
diff --git a/mm/filemap.c b/mm/filemap.c
index 3ef2073..d4a598f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -545,6 +545,23 @@ void fastcall __lock_page(struct page *p
 EXPORT_SYMBOL(__lock_page);
 
 /*
+ * Note completion of filesystem specific page synchronisation
+ *
+ * This is used to allow a page to be written to a filesystem cache in the
+ * background without holding up the completion of readpage
+ */
+void fastcall end_page_fs_misc(struct page *page)
+{
+	smp_mb__before_clear_bit();
+	if (!TestClearPageFsMisc(page))
+		BUG();
+	smp_mb__after_clear_bit();
+	__wake_up_bit(page_waitqueue(page), &page->flags, PG_fs_misc);
+}
+
+EXPORT_SYMBOL(end_page_fs_misc);
+
+/*
  * a rather lightweight function, finding and getting a reference to a
  * hashed page atomically.
  */

