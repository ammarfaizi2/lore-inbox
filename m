Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbUK1RVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbUK1RVx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 12:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbUK1RTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 12:19:52 -0500
Received: from mail.dif.dk ([193.138.115.101]:923 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261313AbUK1RIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 12:08:43 -0500
Date: Sun, 28 Nov 2004 18:18:24 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Ben Collins <bcollins@debian.org>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH][re-send] check copy_to_user() return value in raw1394
Message-ID: <Pine.LNX.4.61.0411281811160.3389@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch makes sure we check the return value of copy_to_user() in 
drivers/ieee1394/raw1394.c::raw1394_read() with the added bonus of 
silencing this warning: 
include/asm/uaccess.h: In function `raw1394_read':
drivers/ieee1394/raw1394.c:446: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result

I've submitted this before, but never got an ACK or NACK, and the patch is 
still relevant against latest Linus bk (2.6.10-rc2-bk11 atm).


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc2-bk11-orig/drivers/ieee1394/raw1394.c linux-2.6.10-rc2-bk11/drivers/ieee1394/raw1394.c
--- linux-2.6.10-rc2-bk11-orig/drivers/ieee1394/raw1394.c	2004-10-18 23:53:06.000000000 +0200
+++ linux-2.6.10-rc2-bk11/drivers/ieee1394/raw1394.c	2004-11-28 18:08:49.000000000 +0100
@@ -411,6 +411,7 @@ static ssize_t raw1394_read(struct file 
         struct file_info *fi = (struct file_info *)file->private_data;
         struct list_head *lh;
         struct pending_request *req;
+	ssize_t ret;
 
         if (count != sizeof(struct raw1394_request)) {
                 return -EINVAL;
@@ -443,10 +444,15 @@ static ssize_t raw1394_read(struct file 
                         req->req.error = RAW1394_ERROR_MEMFAULT;
                 }
         }
-        __copy_to_user(buffer, &req->req, sizeof(req->req));
+        if (copy_to_user(buffer, &req->req, sizeof(req->req))) {
+		ret = -EFAULT;
+		goto out;
+	}
 
+        ret = (ssize_t)sizeof(struct raw1394_request);
+out:
         free_pending_request(req);
-        return sizeof(struct raw1394_request);
+	return ret;
 }
 
 


-- 
Jesper Juhl <juhl-lkml@dif.dk>
   Please CC me on replies from linux1394-devel, I'm not subscribed there.


