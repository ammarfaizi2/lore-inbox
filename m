Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbUE0ISy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUE0ISy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 04:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbUE0ISy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 04:18:54 -0400
Received: from [213.146.154.40] ([213.146.154.40]:42915 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261787AbUE0ISw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 04:18:52 -0400
Date: Thu, 27 May 2004 09:18:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: dag@bakke.com
Cc: nathans@sgi.com, linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: xfsdump hangs - 2.6.6 && 2.6.7-rc1-bk3
Message-ID: <20040527081849.GA12359@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, dag@bakke.com,
	nathans@sgi.com, linux-kernel@vger.kernel.org,
	linux-xfs@oss.sgi.com
References: <20040527010946.9778.h018.c000.wm@mail.bakke.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040527010946.9778.h018.c000.wm@mail.bakke.com.criticalpath.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My patch still wasn't complete, you're still leaking pages, just not
locked ones, this patch should be better and I'll check it in in a few
minutes:


--- 1.111/fs/xfs/linux/xfs_buf.c	2004-04-28 06:45:14 +02:00
+++ edited/fs/xfs/linux/xfs_buf.c	2004-05-27 08:38:46 +02:00
@@ -359,6 +359,7 @@
 	error = _pagebuf_get_pages(bp, page_count, flags);
 	if (unlikely(error))
 		return error;
+	bp->pb_flags |= _PBF_PAGE_CACHE;
 
 	offset = bp->pb_offset;
 	first = bp->pb_file_offset >> PAGE_CACHE_SHIFT;
@@ -370,8 +371,12 @@
 	      retry:
 		page = find_or_create_page(mapping, first + i, gfp_mask);
 		if (unlikely(page == NULL)) {
-			if (flags & PBF_READ_AHEAD)
+			if (flags & PBF_READ_AHEAD) {
+				bp->pb_page_count = i;
+				for (i = 0; i < bp->pb_page_count; i++)
+					unlock_page(bp->pb_pages[i]);
 				return -ENOMEM;
+			}
 
 			/*
 			 * This could deadlock.
@@ -426,8 +431,6 @@
 		for (i = 0; i < bp->pb_page_count; i++)
 			unlock_page(bp->pb_pages[i]);
 	}
-
-	bp->pb_flags |= _PBF_PAGE_CACHE;
 
 	if (page_count) {
 		/* if we have any uptodate pages, mark that in the buffer */
