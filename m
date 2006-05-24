Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932710AbWEXLTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbWEXLTb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbWEXLTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:19:11 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:45952 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932691AbWEXLTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:19:02 -0400
Message-ID: <348469539.42623@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060524111900.970898174@localhost.localdomain>
References: <20060524111246.420010595@localhost.localdomain>
Date: Wed, 24 May 2006 19:12:54 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 08/33] readahead: common macros
Content-Disposition: inline; filename=readahead-common-macros.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define some common used macros for the read-ahead logics.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -5,6 +5,8 @@
  *
  * 09Apr2002	akpm@zip.com.au
  *		Initial version.
+ * 21May2006	Wu Fengguang <wfg@mail.ustc.edu.cn>
+ *		Adaptive read-ahead framework.
  */
 
 #include <linux/kernel.h>
@@ -14,6 +16,14 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
+#include <linux/writeback.h>
+#include <linux/nfsd/const.h>
+
+#define PAGES_BYTE(size) (((size) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT)
+#define PAGES_KB(size)	 PAGES_BYTE((size)*1024)
+
+#define next_page(pg) (list_entry((pg)->lru.prev, struct page, lru))
+#define prev_page(pg) (list_entry((pg)->lru.next, struct page, lru))
 
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
@@ -21,7 +31,7 @@ void default_unplug_io_fn(struct backing
 EXPORT_SYMBOL(default_unplug_io_fn);
 
 struct backing_dev_info default_backing_dev_info = {
-	.ra_pages	= (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE,
+	.ra_pages	= PAGES_KB(VM_MAX_READAHEAD),
 	.state		= 0,
 	.capabilities	= BDI_CAP_MAP_COPY,
 	.unplug_io_fn	= default_unplug_io_fn,
@@ -50,7 +60,7 @@ static inline unsigned long get_max_read
 
 static inline unsigned long get_min_readahead(struct file_ra_state *ra)
 {
-	return (VM_MIN_READAHEAD * 1024) / PAGE_CACHE_SIZE;
+	return PAGES_KB(VM_MIN_READAHEAD);
 }
 
 static inline void reset_ahead_window(struct file_ra_state *ra)

--
