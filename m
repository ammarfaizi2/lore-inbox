Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVBBL7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVBBL7z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 06:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbVBBL7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 06:59:55 -0500
Received: from rev.193.226.232.88.euroweb.hu ([193.226.232.88]:6076 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262270AbVBBL7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 06:59:45 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE - fix race in interrupted request
Message-Id: <E1CwJAI-0004uC-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 02 Feb 2005 12:59:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This patch fixes a potential race between request_wait_answer()
calling background_request() and fuse_dev_writev() calling
request_end() if a request is interrupted.  The race could cause
inodes and files to acquire an extra reference, making them
unfreeable.

Please apply.

Thanks,
Miklos

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.11-rc2-mm2/fs/fuse/dev.c linux-fuse/fs/fuse/dev.c
--- linux-2.6.11-rc2-mm2/fs/fuse/dev.c	2005-01-30 21:40:53.000000000 +0100
+++ linux-fuse/fs/fuse/dev.c	2005-02-02 12:44:26.000000000 +0100
@@ -233,7 +233,7 @@ static void request_wait_answer(struct f
 	if (!req->sent && !list_empty(&req->list)) {
 		list_del(&req->list);
 		__fuse_put_request(req);
-	} else if (req->sent)
+	} else if (!req->finished && req->sent)
 		background_request(req);
 }
 

