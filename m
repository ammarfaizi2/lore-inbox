Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVCYW14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVCYW14 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVCYWZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:25:35 -0500
Received: from mail.dif.dk ([193.138.115.101]:62392 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261853AbVCYWXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:23:09 -0500
Date: Fri, 25 Mar 2005 23:25:06 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] don't check for NULL before calling kfree() in fs/ntfs/
Message-ID: <Pine.LNX.4.62.0503252322460.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please keep me on CC)


There's no need to check a pointer for NULL before calling kfree() on it - 
kfree() handles NULL pointers just fine on its own.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm3-orig/fs/ntfs/dir.c	2005-03-25 15:28:59.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/ntfs/dir.c	2005-03-25 22:51:46.000000000 +0100
@@ -183,8 +183,7 @@ found_it:
 				name->len = 0;
 				*res = name;
 			} else {
-				if (name)
-					kfree(name);
+				kfree(name);
 				*res = NULL;
 			}
 			mref = le64_to_cpu(ie->data.dir.indexed_file);
@@ -444,8 +443,7 @@ found_it2:
 				name->len = 0;
 				*res = name;
 			} else {
-				if (name)
-					kfree(name);
+				kfree(name);
 				*res = NULL;
 			}
 			mref = le64_to_cpu(ie->data.dir.indexed_file);
@@ -1462,10 +1460,8 @@ err_out:
 		unlock_page(ia_page);
 		ntfs_unmap_page(ia_page);
 	}
-	if (ir)
-		kfree(ir);
-	if (name)
-		kfree(name);
+	kfree(ir);
+	kfree(name);
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
 	if (m)
--- linux-2.6.12-rc1-mm3-orig/fs/ntfs/namei.c	2005-03-25 15:28:59.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/ntfs/namei.c	2005-03-25 22:52:36.000000000 +0100
@@ -153,8 +153,7 @@ static struct dentry *ntfs_lookup(struct
 			ntfs_error(vol->sb, "ntfs_iget(0x%lx) failed with "
 					"error code %li.", dent_ino,
 					PTR_ERR(dent_inode));
-		if (name)
-			kfree(name);
+		kfree(name);
 		/* Return the error code. */
 		return (struct dentry *)dent_inode;
 	}
--- linux-2.6.12-rc1-mm3-orig/fs/ntfs/super.c	2005-03-25 15:28:59.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/ntfs/super.c	2005-03-25 22:52:49.000000000 +0100
@@ -1193,8 +1193,7 @@ static BOOL load_and_init_quota(ntfs_vol
 		return FALSE;
 	}
 	/* We do not care for the type of match that was found. */
-	if (name)
-		kfree(name);
+	kfree(name);
 	/* Get the inode. */
 	tmp_ino = ntfs_iget(vol->sb, MREF(mref));
 	if (IS_ERR(tmp_ino) || is_bad_inode(tmp_ino)) {


