Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425427AbWLHLxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425427AbWLHLxO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425434AbWLHLxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:53:13 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52393 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425430AbWLHLxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:53:02 -0500
Message-Id: <200612081152.kB8BqRG1019759@shell0.pdx.osdl.net>
Subject: [patch 04/13] io-accounting: write-cancel accounting
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, balbir@in.ibm.com, csturtiv@sgi.com, daw@sgi.com,
       guillaume.thouvenin@bull.net, jlan@sgi.com, nagar@watson.ibm.com,
       tee@sgi.com
From: akpm@osdl.org
Date: Fri, 08 Dec 2006 03:52:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Account for the number of byte writes which this process caused to not happen
after all.

Cc: Jay Lan <jlan@sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Balbir Singh <balbir@in.ibm.com>
Cc: Chris Sturtivant <csturtiv@sgi.com>
Cc: Tony Ernst <tee@sgi.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: David Wright <daw@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/buffer.c   |    7 ++++++-
 mm/truncate.c |    4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff -puN fs/buffer.c~io-accounting-write-cancel-accounting fs/buffer.c
--- a/fs/buffer.c~io-accounting-write-cancel-accounting
+++ a/fs/buffer.c
@@ -2823,8 +2823,13 @@ int try_to_free_buffers(struct page *pag
 		 * could encounter a non-uptodate page, which is unresolvable.
 		 * This only applies in the rare case where try_to_free_buffers
 		 * succeeds but the page is not freed.
+		 *
+		 * Also, during truncate, discard_buffer will have marked all
+		 * the page's buffers clean.  We discover that here and clean
+		 * the page also.
 		 */
-		clear_page_dirty(page);
+		if (test_clear_page_dirty(page))
+			task_io_account_cancelled_write(PAGE_CACHE_SIZE);
 	}
 out:
 	if (buffers_to_free) {
diff -puN mm/truncate.c~io-accounting-write-cancel-accounting mm/truncate.c
--- a/mm/truncate.c~io-accounting-write-cancel-accounting
+++ a/mm/truncate.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
+#include <linux/task_io_accounting_ops.h>
 #include <linux/buffer_head.h>	/* grr. try_to_release_page,
 				   do_invalidatepage */
 
@@ -69,7 +70,8 @@ truncate_complete_page(struct address_sp
 	if (PagePrivate(page))
 		do_invalidatepage(page, 0);
 
-	clear_page_dirty(page);
+	if (test_clear_page_dirty(page))
+		task_io_account_cancelled_write(PAGE_CACHE_SIZE);
 	ClearPageUptodate(page);
 	ClearPageMappedToDisk(page);
 	remove_from_page_cache(page);
_
