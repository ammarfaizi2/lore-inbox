Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932689AbWEXL1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbWEXL1x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbWEXL0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:26:39 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:16769 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932685AbWEXLTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:19:08 -0400
Message-ID: <348469542.39504@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060524111904.019763011@localhost.localdomain>
References: <20060524111246.420010595@localhost.localdomain>
Date: Wed, 24 May 2006 19:13:00 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 14/33] readahead: state based method - data structure
Content-Disposition: inline; filename=readahead-method-stateful-data.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Extend struct file_ra_state to support the adaptive read-ahead logic.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/fs.h |   57 +++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 47 insertions(+), 10 deletions(-)

--- linux-2.6.17-rc4-mm3.orig/include/linux/fs.h
+++ linux-2.6.17-rc4-mm3/include/linux/fs.h
@@ -613,21 +613,58 @@ struct fown_struct {
 
 /*
  * Track a single file's readahead state
+ *
+ * Diagram for the adaptive readahead logic:
+ *
+ *  |--------- old chunk ------->|-------------- new chunk -------------->|
+ *  +----------------------------+----------------------------------------+
+ *  |               #            |                  #                     |
+ *  +----------------------------+----------------------------------------+
+ *                  ^            ^                  ^                     ^
+ *  file_ra_state.la_index    .ra_index   .lookahead_index      .readahead_index
+ *
+ * Deduced sizes:
+ *                               |----------- readahead size ------------>|
+ *  +----------------------------+----------------------------------------+
+ *  |               #            |                  #                     |
+ *  +----------------------------+----------------------------------------+
+ *                  |------- invoke interval ------>|-- lookahead size -->|
  */
 struct file_ra_state {
-	unsigned long start;		/* Current window */
-	unsigned long size;
-	unsigned long flags;		/* ra flags RA_FLAG_xxx*/
-	unsigned long cache_hit;	/* cache hit count*/
-	unsigned long prev_page;	/* Cache last read() position */
-	unsigned long ahead_start;	/* Ahead window */
-	unsigned long ahead_size;
-	unsigned long ra_pages;		/* Maximum readahead window */
-	unsigned long mmap_hit;		/* Cache hit stat for mmap accesses */
-	unsigned long mmap_miss;	/* Cache miss stat for mmap accesses */
+	union {
+		struct { /* conventional read-ahead */
+			unsigned long start;		/* Current window */
+			unsigned long size;
+			unsigned long ahead_start;	/* Ahead window */
+			unsigned long ahead_size;
+			unsigned long cache_hit;        /* cache hit count */
+		};
+#ifdef CONFIG_ADAPTIVE_READAHEAD
+		struct { /* adaptive read-ahead */
+			pgoff_t la_index;
+			pgoff_t ra_index;
+			pgoff_t lookahead_index;
+			pgoff_t readahead_index;
+			unsigned long age;
+			uint64_t cache_hits;
+		};
+#endif
+	};
+
+	/* mmap read-around */
+	unsigned long mmap_hit;         /* Cache hit stat for mmap accesses */
+	unsigned long mmap_miss;        /* Cache miss stat for mmap accesses */
+
+	/* common ones */
+	unsigned long flags;            /* ra flags RA_FLAG_xxx*/
+	unsigned long prev_page;        /* Cache last read() position */
+	unsigned long ra_pages;         /* Maximum readahead window */
 };
 #define RA_FLAG_MISS 0x01	/* a cache miss occured against this file */
 #define RA_FLAG_INCACHE 0x02	/* file is already in cache */
+#define RA_FLAG_MMAP		(1UL<<31)	/* mmaped page access */
+#define RA_FLAG_NO_LOOKAHEAD	(1UL<<30)	/* disable look-ahead */
+#define RA_FLAG_EOF		(1UL<<29)	/* readahead hits EOF */
 
 struct file {
 	/*

--
