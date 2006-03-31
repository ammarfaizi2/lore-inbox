Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWCaRrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWCaRrb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWCaRrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:47:31 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:45986 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751323AbWCaRra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:47:30 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Fri, 31 Mar 2006 19:45:19 +0200)
Subject: [PATCH 1/10] fuse: fix oops in fuse_send_readpages()
References: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FPNiA-0005ZA-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Mar 2006 19:47:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During heavy parallel filesystem activity it was possible to Oops the
kernel.  The reason is that read_cache_pages() could skip pages which
have already been inserted into the cache by another task.
Occasionally this may result in zero pages actually being sent, while
fuse_send_readpages() relies on at least one page being in the
request.

So check this corner case and just free the request instead of trying
to send it.

Reported and tested by Konstantin Isakov.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-03-31 18:55:11.000000000 +0200
+++ linux/fs/fuse/file.c	2006-03-31 18:55:29.000000000 +0200
@@ -397,8 +397,12 @@ static int fuse_readpages(struct file *f
 		return -EINTR;
 
 	err = read_cache_pages(mapping, pages, fuse_readpages_fill, &data);
-	if (!err)
-		fuse_send_readpages(data.req, file, inode);
+	if (!err) {
+		if (data.req->num_pages)
+			fuse_send_readpages(data.req, file, inode);
+		else
+			fuse_put_request(fc, data.req);
+	}
 	return err;
 }
 
