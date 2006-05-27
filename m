Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751562AbWE0Pwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbWE0Pwk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 11:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbWE0Pwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 11:52:35 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:57563 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751575AbWE0Pvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 11:51:32 -0400
Message-ID: <348745088.79681@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060527155129.653903854@localhost.localdomain>
References: <20060527154849.927021763@localhost.localdomain>
Date: Sat, 27 May 2006 23:48:57 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 08/32] readahead: {MIN,MAX}_RA_PAGES
Content-Disposition: inline; filename=readahead-macros-min-max-rapages.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define two convenient macros for read-ahead:
	- MAX_RA_PAGES: rounded down counterpart of VM_MAX_READAHEAD
	- MIN_RA_PAGES: rounded _up_ counterpart of VM_MIN_READAHEAD

Note that the rounded up MIN_RA_PAGES will work flawlessly with _large_
page sizes like 64k.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -17,13 +17,21 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 
+/*
+ * Convienent macros for min/max read-ahead pages.
+ * Note that MAX_RA_PAGES is rounded down, while MIN_RA_PAGES is rounded up.
+ * The latter is necessary for systems with large page size(i.e. 64k).
+ */
+#define MAX_RA_PAGES	(VM_MAX_READAHEAD*1024 / PAGE_CACHE_SIZE)
+#define MIN_RA_PAGES	DIV_ROUND_UP(VM_MIN_READAHEAD*1024, PAGE_CACHE_SIZE)
+
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
 }
 EXPORT_SYMBOL(default_unplug_io_fn);
 
 struct backing_dev_info default_backing_dev_info = {
-	.ra_pages	= (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE,
+	.ra_pages	= MAX_RA_PAGES,
 	.state		= 0,
 	.capabilities	= BDI_CAP_MAP_COPY,
 	.unplug_io_fn	= default_unplug_io_fn,
@@ -52,7 +60,7 @@ static inline unsigned long get_max_read
 
 static inline unsigned long get_min_readahead(struct file_ra_state *ra)
 {
-	return (VM_MIN_READAHEAD * 1024) / PAGE_CACHE_SIZE;
+	return MIN_RA_PAGES;
 }
 
 static inline void reset_ahead_window(struct file_ra_state *ra)

--
