Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263287AbVCEANJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263287AbVCEANJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263398AbVCEAJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:09:36 -0500
Received: from rev.193.226.232.215.euroweb.hu ([193.226.232.215]:7354 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263318AbVCDXQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:16:50 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: inode leak fix
Message-Id: <E1D7M29-0005ar-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 05 Mar 2005 00:16:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

This patch fixes an inode leak in fuse_get_dentry().  With libfuse
this practically never triggers, but a DoS exploit could be written.

Please Apply.

Thanks,
Miklos

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.11-mm1/fs/fuse/inode.c linux-fuse/fs/fuse/inode.c
--- linux-2.6.11-mm1/fs/fuse/inode.c	2005-03-04 23:26:59.000000000 +0100
+++ linux-fuse/fs/fuse/inode.c	2005-03-04 23:32:36.000000000 +0100
@@ -446,8 +446,12 @@ static struct dentry *fuse_get_dentry(st
 		return ERR_PTR(-ESTALE);
 
 	inode = ilookup5(sb, nodeid, fuse_inode_eq, &nodeid);
-	if (!inode || inode->i_generation != generation)
+	if (!inode)
 		return ERR_PTR(-ESTALE);
+	if (inode->i_generation != generation) {
+		iput(inode);
+		return ERR_PTR(-ESTALE);
+	}
 
 	entry = d_alloc_anon(inode);
 	if (!entry) {
