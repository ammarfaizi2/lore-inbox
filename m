Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVAZXSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVAZXSP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbVAZXR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:17:56 -0500
Received: from rev.193.226.232.37.euroweb.hu ([193.226.232.37]:12960 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262322AbVAZRpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:45:39 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE - better error reporting in fuse_fill_super
Message-Id: <E1CtrEN-0000QQ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 26 Jan 2005 18:45:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch makes fuse_fill_super() return correct error value in case
of OOM.

Please apply.

Thanks,
Miklos

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.11-rc2-mm1/fs/fuse/inode.c linux-fuse/fs/fuse/inode.c
--- linux-2.6.11-rc2-mm1/fs/fuse/inode.c	2005-01-26 18:30:47.000000000 +0100
+++ linux-fuse/fs/fuse/inode.c	2005-01-26 18:18:58.000000000 +0100
@@ -407,14 +407,14 @@ static struct fuse_conn *get_conn(struct
 	struct fuse_conn *fc;
 
 	if (file->f_op != &fuse_dev_operations)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	fc = new_conn();
 	if (fc == NULL)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	spin_lock(&fuse_lock);
 	if (file->private_data) {
 		free_conn(fc);
-		fc = NULL;
+		fc = ERR_PTR(-EINVAL);
 	} else {
 		file->private_data = fc;
 		fc->sb = sb;
@@ -525,8 +525,8 @@ static int fuse_fill_super(struct super_
 
 	fc = get_conn(file, sb);
 	fput(file);
-	if (fc == NULL)
-		return -EINVAL;
+	if (IS_ERR(fc))
+		return PTR_ERR(fc);
 
 	fc->flags = d.flags;
 	fc->user_id = d.user_id;
