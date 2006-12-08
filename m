Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425435AbWLHLxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425435AbWLHLxN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425427AbWLHLws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:52:48 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52364 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425426AbWLHLwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:52:47 -0500
Message-Id: <200612081152.kB8BqQvb019756@shell0.pdx.osdl.net>
Subject: [patch 03/13] io-accounting: write accounting
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, balbir@in.ibm.com, csturtiv@sgi.com, daw@sgi.com,
       guillaume.thouvenin@bull.net, jlan@sgi.com, nagar@watson.ibm.com,
       tee@sgi.com
From: akpm@osdl.org
Date: Fri, 08 Dec 2006 03:52:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Accounting writes is fairly simple: whenever a process flips a page from clean
to dirty, we accuse it of having caused a write to underlying storage of
PAGE_CACHE_SIZE bytes.

This may overestimate the amount of writing: the page-dirtying may cause only
one buffer_head's worth of writeout.  Fixing that is possible, but probably a
bit messy and isn't obviously important.

Cc: Jay Lan <jlan@sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Balbir Singh <balbir@in.ibm.com>
Cc: Chris Sturtivant <csturtiv@sgi.com>
Cc: Tony Ernst <tee@sgi.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: David Wright <daw@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/buffer.c         |    5 ++++-
 mm/page-writeback.c |    5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff -puN fs/buffer.c~io-accounting-write-accounting fs/buffer.c
--- a/fs/buffer.c~io-accounting-write-accounting
+++ a/fs/buffer.c
@@ -35,6 +35,7 @@
 #include <linux/hash.h>
 #include <linux/suspend.h>
 #include <linux/buffer_head.h>
+#include <linux/task_io_accounting_ops.h>
 #include <linux/bio.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
@@ -729,8 +730,10 @@ int __set_page_dirty_buffers(struct page
 
 	write_lock_irq(&mapping->tree_lock);
 	if (page->mapping) {	/* Race with truncate? */
-		if (mapping_cap_account_dirty(mapping))
+		if (mapping_cap_account_dirty(mapping)) {
 			__inc_zone_page_state(page, NR_FILE_DIRTY);
+			task_io_account_write(PAGE_CACHE_SIZE);
+		}
 		radix_tree_tag_set(&mapping->page_tree,
 				page_index(page), PAGECACHE_TAG_DIRTY);
 	}
diff -puN mm/page-writeback.c~io-accounting-write-accounting mm/page-writeback.c
--- a/mm/page-writeback.c~io-accounting-write-accounting
+++ a/mm/page-writeback.c
@@ -21,6 +21,7 @@
 #include <linux/writeback.h>
 #include <linux/init.h>
 #include <linux/backing-dev.h>
+#include <linux/task_io_accounting_ops.h>
 #include <linux/blkdev.h>
 #include <linux/mpage.h>
 #include <linux/rmap.h>
@@ -768,8 +769,10 @@ int __set_page_dirty_nobuffers(struct pa
 		mapping2 = page_mapping(page);
 		if (mapping2) { /* Race with truncate? */
 			BUG_ON(mapping2 != mapping);
-			if (mapping_cap_account_dirty(mapping))
+			if (mapping_cap_account_dirty(mapping)) {
 				__inc_zone_page_state(page, NR_FILE_DIRTY);
+				task_io_account_write(PAGE_CACHE_SIZE);
+			}
 			radix_tree_tag_set(&mapping->page_tree,
 				page_index(page), PAGECACHE_TAG_DIRTY);
 		}
_
