Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267650AbUJJAEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267650AbUJJAEj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 20:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267653AbUJJAEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 20:04:39 -0400
Received: from mail.dif.dk ([193.138.115.101]:51157 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S267650AbUJJAEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 20:04:37 -0400
Date: Sun, 10 Oct 2004 02:12:14 +0200 (CEST)
From: Jesper Juhl <juhl@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] check copy_to_user return value in raw1394
Message-ID: <Pine.LNX.4.61.0410100208270.2973@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a proposed patch to make sure we check the return value of 
copy_to_user in raw1394.c::raw1394_read
I've changed __copy_to_user into copy_to_user since I don't see where we 
would otherwhise be doing the access_ok checking...
Please review this patch before applying.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.9-rc3-bk9-orig/drivers/ieee1394/raw1394.c linux-2.6.9-rc3-bk9/drivers/ieee1394/raw1394.c
--- linux-2.6.9-rc3-bk9-orig/drivers/ieee1394/raw1394.c	2004-09-30 05:03:45.000000000 +0200
+++ linux-2.6.9-rc3-bk9/drivers/ieee1394/raw1394.c	2004-10-10 02:05:54.000000000 +0200
@@ -411,6 +411,7 @@ static ssize_t raw1394_read(struct file 
         struct file_info *fi = (struct file_info *)file->private_data;
         struct list_head *lh;
         struct pending_request *req;
+        ssize_t ret;
 
         if (count != sizeof(struct raw1394_request)) {
                 return -EINVAL;
@@ -443,10 +444,15 @@ static ssize_t raw1394_read(struct file 
                         req->req.error = RAW1394_ERROR_MEMFAULT;
                 }
         }
-        __copy_to_user(buffer, &req->req, sizeof(req->req));
+        if(copy_to_user(buffer, &req->req, sizeof(req->req))) {
+		ret = -EFAULT;
+		goto out;
+	}
 
+        ret = (ssize_t)sizeof(struct raw1394_request);
+out:
         free_pending_request(req);
-        return sizeof(struct raw1394_request);
+	return ret;
 }
 
 

