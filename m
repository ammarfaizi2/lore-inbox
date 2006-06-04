Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932170AbWFDHeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWFDHeN (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 03:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWFDHeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 03:34:13 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:52105 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932170AbWFDHeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 03:34:12 -0400
Message-ID: <349406446.10828@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sun, 4 Jun 2006 15:34:15 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: Valdis.Kletnieks@vt.edu, diegocg@gmail.com, Voluspa <lista1@comhem.se>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] readahead: initial method - expected read size - fix fastcall
Message-ID: <20060604073415.GB5405@mail.ustc.edu.cn>
Mail-Followup-To: Fengguang Wu <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, Valdis.Kletnieks@vt.edu,
	diegocg@gmail.com, Voluspa <lista1@comhem.se>,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 'fastcall' directive for function readahead_close().

It has drawn concerns from Andrew Morton. Now I have some benchmarks
on it, and proved it as a _false_ optimization.

The tests are simple runs of the following command over _cached_ dirs:
                time find / > /dev/null

Table of summary(averages):
		user		sys		cpu		total
fastcall:	1.236		4.39		89%		6.2936
non-fastcall:	1.18		4.14166667	92%		5.75416667
stock:		1.25833333	4.14666667	93.3%		5.75866667


-----------
Detailed outputs:

readahead patched kernel with fastcall:
noglob find / > /dev/null  1.21s user 4.58s system 90% cpu 6.378 total
noglob find / > /dev/null  1.25s user 4.47s system 86% cpu 6.623 total
noglob find / > /dev/null  1.23s user 4.36s system 90% cpu 6.173 total
noglob find / > /dev/null  1.25s user 4.33s system 92% cpu 6.067 total
noglob find / > /dev/null  1.24s user 4.21s system 87% cpu 6.227 total

readahead patched kernel without fastcall:
noglob find / > /dev/null  1.21s user 4.46s system 95% cpu 5.962 total
noglob find / > /dev/null  1.26s user 4.58s system 94% cpu 6.142 total
noglob find / > /dev/null  1.10s user 3.80s system 86% cpu 5.661 total
noglob find / > /dev/null  1.13s user 3.98s system 95% cpu 5.355 total
noglob find / > /dev/null  1.18s user 4.00s system 89% cpu 5.805 total
noglob find / > /dev/null  1.22s user 4.03s system 93% cpu 5.600 total

stock kernel:
noglob find / > /dev/null  1.22s user 4.24s system 94% cpu 5.803 total
noglob find / > /dev/null  1.31s user 4.21s system 95% cpu 5.784 total
noglob find / > /dev/null  1.27s user 4.24s system 97% cpu 5.676 total
noglob find / > /dev/null  1.34s user 4.21s system 94% cpu 5.844 total
noglob find / > /dev/null  1.26s user 4.08s system 89% cpu 5.935 total
noglob find / > /dev/null  1.15s user 3.90s system 91% cpu 5.510 total


-----------
Similar regression has also been found by Voluspa <lista1@comhem.se>:
> "cd /usr ; time find . -type f -exec md5sum {} \;"
>
> 2.6.17-rc5 ------- 2.6.17-rc5-ar
>
> real 21m21.009s -- 21m37.663s
> user 3m20.784s  -- 3m20.701s
> sys  6m34.261s  -- 6m41.735s

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

--- linux-2.6.17-rc5-mm2.orig/include/linux/mm.h
+++ linux-2.6.17-rc5-mm2/include/linux/mm.h
@@ -1068,7 +1068,7 @@ unsigned long page_cache_readahead(struc
 void handle_ra_miss(struct address_space *mapping, 
 		    struct file_ra_state *ra, pgoff_t offset);
 unsigned long max_sane_readahead(unsigned long nr);
-void fastcall readahead_close(struct file *file);
+void readahead_close(struct file *file);
 unsigned long
 page_cache_readahead_adaptive(struct address_space *mapping,
 			struct file_ra_state *ra, struct file *filp,
--- linux-2.6.17-rc5-mm2.orig/mm/readahead.c
+++ linux-2.6.17-rc5-mm2/mm/readahead.c
@@ -1943,7 +1943,7 @@ void fastcall readahead_cache_hit(struct
  * The resulted `ra_expect_bytes' answers the question of:
  * 	How many pages are expected to be read on start-of-file?
  */
-void fastcall readahead_close(struct file *file)
+void readahead_close(struct file *file)
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	struct address_space *mapping = inode->i_mapping;
