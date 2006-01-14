Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423252AbWANAl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423252AbWANAl3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423245AbWANAlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:41:12 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:14254 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1423243AbWANAlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:41:00 -0500
Message-Id: <20060114004031.161922000@dorka.pomaz.szeredi.hu>
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
Date: Sat, 14 Jan 2006 01:39:50 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 02/17] fuse: fuse_copy_finish() order fix
Content-Disposition: inline; filename=fuse_fix_copy_finish.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fuse_copy_finish() must be called before request_end(), since the
later might sleep, and no sleeping is allowed between fuse_copy_one()
and fuse_copy_finish() because of kmap_atomic()/kunmap_atomic() used
in them.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-01-13 21:52:16.000000000 +0100
+++ linux/fs/fuse/dev.c	2006-01-13 22:51:43.000000000 +0100
@@ -773,8 +773,10 @@ static ssize_t fuse_dev_writev(struct fi
 
 	list_del_init(&req->list);
 	if (req->interrupted) {
-		request_end(fc, req);
+		spin_unlock(&fuse_lock);
 		fuse_copy_finish(&cs);
+		spin_lock(&fuse_lock);
+		request_end(fc, req);
 		return -ENOENT;
 	}
 	req->out.h = oh;

--
