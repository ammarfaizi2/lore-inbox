Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVCYVbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVCYVbm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 16:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVCYVbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 16:31:42 -0500
Received: from mail.dif.dk ([193.138.115.101]:18868 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261815AbVCYVbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 16:31:25 -0500
Date: Fri, 25 Mar 2005 22:33:22 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Ben Fennema <bfennema@falcon.csc.calpoly.edu>
Cc: linux_udf@hpesjro.fc.hp.com, linux-kernel@vger.kernel.org
Subject: [PATCH] drop pointless NULL pointer checks before calling kfree in
 fs/udf/
Message-ID: <Pine.LNX.4.62.0503252231070.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please keep me on CC)


There's no need to check for NULL pointer before calling kfree(), it 
handles NULL just fine by itself.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm3-orig/fs/udf/udf_sb.h	2005-03-02 08:38:20.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/udf/udf_sb.h	2005-03-25 21:58:33.000000000 +0100
@@ -39,8 +39,7 @@ static inline struct udf_sb_info *UDF_SB
 {\
 	if (UDF_SB(X))\
 	{\
-		if (UDF_SB_PARTMAPS(X))\
-			kfree(UDF_SB_PARTMAPS(X));\
+		kfree(UDF_SB_PARTMAPS(X));\
 		UDF_SB_PARTMAPS(X) = NULL;\
 	}\
 }
--- linux-2.6.12-rc1-mm3-orig/fs/ufs/super.c	2005-03-21 23:12:41.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/ufs/super.c	2005-03-25 21:59:49.000000000 +0100
@@ -472,13 +472,13 @@ static int ufs_read_cylinder_structures 
 	return 1;
 
 failed:
-	if (base) kfree (base);
+	kfree(base);
 	if (sbi->s_ucg) {
 		for (i = 0; i < uspi->s_ncg; i++)
 			if (sbi->s_ucg[i]) brelse (sbi->s_ucg[i]);
-		kfree (sbi->s_ucg);
+		kfree(sbi->s_ucg);
 		for (i = 0; i < UFS_MAX_GROUP_LOADED; i++)
-			if (sbi->s_ucpi[i]) kfree (sbi->s_ucpi[i]);
+			kfree(sbi->s_ucpi[i]);
 	}
 	UFSD(("EXIT (FAILED)\n"))
 	return 0;
@@ -982,8 +982,8 @@ dalloc_failed:
 	iput(inode);
 failed:
 	if (ubh) ubh_brelse_uspi (uspi);
-	if (uspi) kfree (uspi);
-	if (sbi) kfree(sbi);
+	kfree(uspi);
+	kfree(sbi);
 	sb->s_fs_info = NULL;
 	UFSD(("EXIT (FAILED)\n"))
 	return -EINVAL;


