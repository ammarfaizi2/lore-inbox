Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWCaRws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWCaRws (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWCaRws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:52:48 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:21723 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932161AbWCaRwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:52:47 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Fri, 31 Mar 2006 19:45:19 +0200)
Subject: [PATCH 4/10] fuse: add O_NONBLOCK support to FUSE device
References: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FPNnT-0005bn-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Mar 2006 19:52:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Dike <jdike@addtoit.com>

I don't like duplicating the connected and list_empty tests in
fuse_dev_readv, but this seemed cleaner than adding the f_flags test
to request_wait.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-03-31 18:55:31.000000000 +0200
+++ linux/fs/fuse/dev.c	2006-03-31 18:55:31.000000000 +0200
@@ -619,6 +619,12 @@ static ssize_t fuse_dev_readv(struct fil
 	err = -EPERM;
 	if (!fc)
 		goto err_unlock;
+
+	err = -EAGAIN;
+	if((file->f_flags & O_NONBLOCK) && fc->connected &&
+	   list_empty(&fc->pending))
+		goto err_unlock;
+
 	request_wait(fc);
 	err = -ENODEV;
 	if (!fc->connected)
