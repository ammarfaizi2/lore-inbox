Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSKGQnf>; Thu, 7 Nov 2002 11:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbSKGQnf>; Thu, 7 Nov 2002 11:43:35 -0500
Received: from [198.149.18.6] ([198.149.18.6]:27075 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S261456AbSKGQne>;
	Thu, 7 Nov 2002 11:43:34 -0500
Date: Thu, 7 Nov 2002 19:04:41 -0500
From: Christoph Hellwig <hch@sgi.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, cattelan@sgi.com
Subject: [PATCH] fix file system corruption under load
Message-ID: <20021107190441.A15691@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org, cattelan@sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When QA testing XFS 1.2 we observed in-memory corruption under extreme
load (fsx, usemem & bash-shared-mapping) when using block size < pagesizes.

In addition to some bugs inside XFS Russell Cattelan found a problem in
end_buffer_io_async.

The problem is that end_buffer_io_async sets the page uptodate as soon
as there are no more async or locked buffers, which is wrong if only
parts of the page are submitted for I/O (i.e. writes not on the page
boundary, etc..)



--- linux-2.4/fs/buffer.c	Fri Oct  4 18:14:59 2002
+++ linux/fs/buffer.c	Thu Nov  7 16:09:53 2002
@@ -749,6 +749,7 @@
 	unsigned long flags;
 	struct buffer_head *tmp;
 	struct page *page;
+	int fullup = 1;
 
 	mark_buffer_uptodate(bh, uptodate);
 
@@ -775,8 +876,11 @@
 	unlock_buffer(bh);
 	tmp = bh->b_this_page;
 	while (tmp != bh) {
-		if (buffer_async(tmp) && buffer_locked(tmp))
-			goto still_busy;
+		if (buffer_locked(tmp)) {
+			if (buffer_async(tmp))
+				goto still_busy;
+		} else if (!buffer_uptodate(tmp))
+			fullup = 0;
 		tmp = tmp->b_this_page;
 	}
 
@@ -784,10 +824,10 @@
 	spin_unlock_irqrestore(&page_uptodate_lock, flags);
 
 	/*
-	 * if none of the buffers had errors then we can set the
-	 * page uptodate:
+	 * If none of the buffers had errors and all were uptodate
+	 * then we can set the page uptodate:
 	 */
-	if (!PageError(page))
+	if (fullup && !PageError(page))
 		SetPageUptodate(page);
 
 	UnlockPage(page);
