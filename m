Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWEZG7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWEZG7H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 02:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWEZG7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 02:59:07 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:5506 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751303AbWEZG7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 02:59:05 -0400
Message-ID: <348626742.20977@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Fri, 26 May 2006 14:59:06 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/33] readahead: common macros
Message-ID: <20060526065906.GA5135@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <348469539.42623@ustc.edu.cn> <44754708.5090406@yahoo.com.au> <348553673.03597@ustc.edu.cn> <447676F4.7090503@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447676F4.7090503@yahoo.com.au>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nick and Andrew,

Updated the patch as recommended.

Thanks,
Wu
---

readahead-macros-min-max-rapages.patch
---

Subject: readahead: introduce {MIN,MAX}_RA_PAGES

Define two convenient macros for read-ahead:
	- MAX_RA_PAGES: rounded down counterpart of VM_MAX_READAHEAD
	- MIN_RA_PAGES: rounded _up_ counterpart of VM_MIN_READAHEAD

Note that the rounded _up_ MIN_RA_PAGES will work flawlessly with large
page sizes like 64k.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---
 mm/readahead.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

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
