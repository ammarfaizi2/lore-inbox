Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263463AbVCEAMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbVCEAMn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263449AbVCEAJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:09:29 -0500
Received: from [193.226.232.215] ([193.226.232.215]:6586 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263154AbVCDXJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:09:41 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: use after free fix
Message-Id: <E1D7Lud-0005ZM-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 05 Mar 2005 00:08:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

I should have known that bragging about the stability of FUSE will get
me into trouble.

This patch fixes a use after free bug, which could in theory cause
memory corruption.  It was actually found with DEBUG_PAGEALLOC by
Magnus Johansson. 

Please apply.

Thanks,
Miklos

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.11-mm1/fs/fuse/dev.c linux-fuse/fs/fuse/dev.c
--- linux-2.6.11-mm1/fs/fuse/dev.c	2005-03-04 23:26:59.000000000 +0100
+++ linux-fuse/fs/fuse/dev.c	2005-03-04 23:32:36.000000000 +0100
@@ -121,12 +121,11 @@ struct fuse_req *fuse_get_request_nonint
 
 static void fuse_putback_request(struct fuse_conn *fc, struct fuse_req *req)
 {
-	if (!req->preallocated)
-		fuse_request_free(req);
-
 	spin_lock(&fuse_lock);
 	if (req->preallocated)
 		list_add(&req->list, &fc->unused_list);
+	else
+		fuse_request_free(req);
 
 	if (fc->outstanding_debt)
 		fc->outstanding_debt--;
