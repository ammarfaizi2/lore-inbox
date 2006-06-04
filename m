Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932234AbWFDMNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWFDMNV (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 08:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWFDMNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 08:13:21 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:49814 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932234AbWFDMNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 08:13:20 -0400
Message-ID: <349423197.27188@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sun, 4 Jun 2006 20:13:28 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: Valdis.Kletnieks@vt.edu, diegocg@gmail.com, lista1@comhem.se,
        linux-kernel@vger.kernel.org
Subject: [PATCH] readahead: call scheme - fix fastcall readahead_cache_hit()
Message-ID: <20060604121328.GA6686@mail.ustc.edu.cn>
Mail-Followup-To: Fengguang Wu <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, Valdis.Kletnieks@vt.edu,
	diegocg@gmail.com, lista1@comhem.se, linux-kernel@vger.kernel.org
References: <349406446.10828@ustc.edu.cn> <20060604020738.31f43cb0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060604020738.31f43cb0.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 'fastcall' directive for readahead_cache_hit().

Sorry, it also leads to unfavorable performance in the following micro
benchmark on i386 with CONFIG_REGPARM=n:

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
