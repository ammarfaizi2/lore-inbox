Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWBZTw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWBZTw7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 14:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWBZTw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 14:52:59 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:50918 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751393AbWBZTw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 14:52:58 -0500
Message-ID: <4402065B.AD07EA57@tv-sign.ru>
Date: Sun, 26 Feb 2006 22:49:47 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Bryan Fink <bfink@eventmonitor.com>, linux-kernel@vger.kernel.org,
       Ram Pai <linuxram@us.ibm.com>, Steven Pratt <slpratt@austin.ibm.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [PATCH] readahead: ->prev_page can overrun the ahead window
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If get_next_ra_size() does not grow fast enough, ->prev_page can
overrun the ahead window. This means the caller will read the pages
from ->ahead_start + ->ahead_size to ->prev_page synchronously.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc3/mm/readahead.c~	2006-02-27 00:11:13.070848680 +0300
+++ 2.6.16-rc3/mm/readahead.c	2006-02-27 00:53:17.881019192 +0300
@@ -52,13 +52,24 @@ static inline unsigned long get_min_read
 	return (VM_MIN_READAHEAD * 1024) / PAGE_CACHE_SIZE;
 }
 
+static inline void reset_ahead_window(struct file_ra_state *ra)
+{
+	/*
+	 * ... but preserve ahead_start + ahead_size value,
+	 * see 'recheck:' label in page_cache_readahead().
+	 * Note: We never use ->ahead_size as rvalue without
+	 * checking ->ahead_start != 0 first.
+	 */
+	ra->ahead_size += ra->ahead_start;
+	ra->ahead_start = 0;
+}
+
 static inline void ra_off(struct file_ra_state *ra)
 {
 	ra->start = 0;
 	ra->flags = 0;
 	ra->size = 0;
-	ra->ahead_start = 0;
-	ra->ahead_size = 0;
+	reset_ahead_window(ra);
 	return;
 }
 
@@ -426,8 +437,7 @@ static int make_ahead_window(struct addr
 		 * congestion.  The ahead window will any way be closed
 		 * in case we failed due to excessive page cache hits.
 		 */
-		ra->ahead_start = 0;
-		ra->ahead_size = 0;
+		reset_ahead_window(ra);
 	}
 
 	return ret;
@@ -520,11 +530,11 @@ page_cache_readahead(struct address_spac
 	 * If we get here we are doing sequential IO and this was not the first
 	 * occurence (ie we have an existing window)
 	 */
-
 	if (ra->ahead_start == 0) {	 /* no ahead window yet */
 		if (!make_ahead_window(mapping, filp, ra, 0))
-			goto out;
+			goto recheck;
 	}
+
 	/*
 	 * Already have an ahead window, check if we crossed into it.
 	 * If so, shift windows and issue a new ahead window.
@@ -536,6 +546,10 @@ page_cache_readahead(struct address_spac
 		ra->start = ra->ahead_start;
 		ra->size = ra->ahead_size;
 		make_ahead_window(mapping, filp, ra, 0);
+recheck:
+		/* prev_page shouldn't overrun the ahead window */
+		ra->prev_page = min(ra->prev_page,
+			ra->ahead_start + ra->ahead_size - 1);
 	}
 
 out:
