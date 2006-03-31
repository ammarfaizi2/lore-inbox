Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWCaRsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWCaRsq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWCaRsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:48:46 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:46498 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932148AbWCaRsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:48:45 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Fri, 31 Mar 2006 19:45:19 +0200)
Subject: [PATCH 2/10] fuse: fix fuse_dev_poll() return value
References: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FPNjd-0005aE-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Mar 2006 19:48:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fuse_dev_poll() returned an error value instead of a poll mask.
Luckily (or unluckily) -ENODEV does contain the POLLERR bit.

There's also a race if filesystem is unmounted between fuse_get_conn()
and spin_lock(), in which case this event will be missed by poll().

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-03-31 18:55:11.000000000 +0200
+++ linux/fs/fuse/dev.c	2006-03-31 18:55:30.000000000 +0200
@@ -804,17 +804,18 @@ static ssize_t fuse_dev_write(struct fil
 
 static unsigned fuse_dev_poll(struct file *file, poll_table *wait)
 {
-	struct fuse_conn *fc = fuse_get_conn(file);
 	unsigned mask = POLLOUT | POLLWRNORM;
-
+	struct fuse_conn *fc = fuse_get_conn(file);
 	if (!fc)
-		return -ENODEV;
+		return POLLERR;
 
 	poll_wait(file, &fc->waitq, wait);
 
 	spin_lock(&fuse_lock);
-	if (!list_empty(&fc->pending))
-                mask |= POLLIN | POLLRDNORM;
+	if (!fc->connected)
+		mask = POLLERR;
+	else if (!list_empty(&fc->pending))
+		mask |= POLLIN | POLLRDNORM;
 	spin_unlock(&fuse_lock);
 
 	return mask;
