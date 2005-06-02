Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVFBKn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVFBKn3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 06:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVFBKn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 06:43:29 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:49418 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261371AbVFBKnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 06:43:24 -0400
To: akpm@osdl.org
CC: sven@sven-tantau.de, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH] FUSE: serious information leak fix
Message-Id: <E1DdnA0-0001Xq-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 02 Jun 2005 12:42:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In certain situations the user can read out previous contents of
pages.  To do this, create a filesystem that returns a short count on
a read request.  Then issue a read for a file.  If there are pages to
be read, that are not touched at all, these will not be zeroed.

The fix is to zero out all pages that are not touched.

Thanks to Sven Tantau for the bug report.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2005-06-01 12:22:08.000000000 +0200
+++ linux/fs/fuse/dev.c	2005-06-02 11:10:08.000000000 +0200
@@ -525,7 +525,7 @@ static int fuse_copy_pages(struct fuse_c
 	unsigned offset = req->page_offset;
 	unsigned count = min(nbytes, (unsigned) PAGE_SIZE - offset);
 
-	for (i = 0; i < req->num_pages && nbytes; i++) {
+	for (i = 0; i < req->num_pages && (nbytes || zeroing); i++) {
 		struct page *page = req->pages[i];
 		int err = fuse_copy_page(cs, page, offset, count, zeroing);
 		if (err)
