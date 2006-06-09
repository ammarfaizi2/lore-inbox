Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWFIILX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWFIILX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 04:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWFIILX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 04:11:23 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:30618 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751436AbWFIILW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 04:11:22 -0400
Message-ID: <349840679.03819@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060609081120.054527393@localhost.localdomain>
References: <20060609080801.741901069@localhost.localdomain>
Date: Fri, 09 Jun 2006 16:08:04 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 3/5] readahead: call scheme - no fastcall for readahead_cache_hit()
Content-Disposition: inline; filename=readahead-cache-hit-remove-fastcall.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 'fastcall' directive for readahead_cache_hit().

It leads to unfavorable performance in the following micro benchmark on i386
with CONFIG_REGPARM=n:

Command:
        time cp cold /dev/null

Summary:
              user     sys     cpu    total
no-fastcall   1.24    24.88    90.9   28.57
fastcall      1.16    25.69    91.5   29.23

Details:
without fastcall:
cp cold /dev/null  1.27s user 24.63s system 91% cpu 28.348 total
cp cold /dev/null  1.17s user 25.09s system 91% cpu 28.653 total
cp cold /dev/null  1.24s user 24.75s system 91% cpu 28.448 total
cp cold /dev/null  1.20s user 25.04s system 91% cpu 28.614 total
cp cold /dev/null  1.31s user 24.67s system 91% cpu 28.499 total
cp cold /dev/null  1.30s user 24.87s system 91% cpu 28.530 total
cp cold /dev/null  1.26s user 24.84s system 91% cpu 28.542 total
cp cold /dev/null  1.16s user 25.15s system 90% cpu 28.925 total

with fastcall:
cp cold /dev/null  1.16s user 26.39s system 91% cpu 30.061 total
cp cold /dev/null  1.25s user 26.53s system 91% cpu 30.378 total
cp cold /dev/null  1.10s user 25.32s system 92% cpu 28.679 total
cp cold /dev/null  1.15s user 25.20s system 91% cpu 28.747 total
cp cold /dev/null  1.19s user 25.38s system 92% cpu 28.841 total
cp cold /dev/null  1.11s user 25.75s system 92% cpu 29.126 total
cp cold /dev/null  1.17s user 25.49s system 91% cpu 29.042 total
cp cold /dev/null  1.17s user 25.49s system 92% cpu 28.970 total

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


--- linux-2.6.17-rc5-mm2.orig/include/linux/mm.h
+++ linux-2.6.17-rc5-mm2/include/linux/mm.h
@@ -1074,7 +1074,7 @@ page_cache_readahead_adaptive(struct add
 			struct file_ra_state *ra, struct file *filp,
 			struct page *prev_page, struct page *page,
 			pgoff_t first_index, pgoff_t index, pgoff_t last_index);
-void fastcall readahead_cache_hit(struct file_ra_state *ra, struct page *page);
+void readahead_cache_hit(struct file_ra_state *ra, struct page *page);

 #ifdef CONFIG_ADAPTIVE_READAHEAD
 extern int readahead_ratio;
--- linux-2.6.17-rc5-mm2.orig/mm/readahead.c
+++ linux-2.6.17-rc5-mm2/mm/readahead.c
@@ -1916,7 +1916,7 @@ readit:
  * readahead_cache_hit() is the feedback route of the adaptive read-ahead
  * logic. It must be called on every access on the read-ahead pages.
  */
-void fastcall readahead_cache_hit(struct file_ra_state *ra, struct page *page)
+void readahead_cache_hit(struct file_ra_state *ra, struct page *page)
 {
 	if (PageActive(page) || PageReferenced(page))
 		return;

--
