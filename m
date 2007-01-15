Return-Path: <linux-kernel-owner+w=401wt.eu-S1751318AbXAOSjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbXAOSjA (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 13:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbXAOSi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 13:38:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51447 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbXAOSi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 13:38:58 -0500
Message-ID: <45ABCA3A.5080105@redhat.com>
Date: Mon, 15 Jan 2007 12:38:50 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
MIME-Version: 1.0
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext4 development <linux-ext4@vger.kernel.org>
Subject: [PATCH] remove ext[34]_inc_count and _dec_count
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see that there's any reason for this extra layer.  

- Naming is confusing, ext3_inc_count manipulates i_nlink not i_count
- handle argument passed in is not used
- ext3 and ext4 already call inc_nlink and dec_nlink directly in other places


 ext3/namei.c |   21 +++------------------
 ext4/namei.c |   21 +++------------------
 2 files changed, 6 insertions(+), 36 deletions(-)

Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Index: linux-2.6.19/fs/ext3/namei.c
===================================================================
--- linux-2.6.19.orig/fs/ext3/namei.c
+++ linux-2.6.19/fs/ext3/namei.c
@@ -1618,21 +1618,6 @@ static int ext3_delete_entry (handle_t *
 	return -ENOENT;
 }
 
-/*
- * ext3_mark_inode_dirty is somewhat expensive, so unlike ext2 we
- * do not perform it in these functions.  We perform it at the call site,
- * if it is needed.
- */
-static inline void ext3_inc_count(handle_t *handle, struct inode *inode)
-{
-	inc_nlink(inode);
-}
-
-static inline void ext3_dec_count(handle_t *handle, struct inode *inode)
-{
-	drop_nlink(inode);
-}
-
 static int ext3_add_nondir(handle_t *handle,
 		struct dentry *dentry, struct inode *inode)
 {
@@ -1642,7 +1627,7 @@ static int ext3_add_nondir(handle_t *han
 		d_instantiate(dentry, inode);
 		return 0;
 	}
-	ext3_dec_count(handle, inode);
+	drop_nlink(inode);
 	iput(inode);
 	return err;
 }
@@ -2163,7 +2148,7 @@ retry:
 		err = __page_symlink(inode, symname, l,
 				mapping_gfp_mask(inode->i_mapping) & ~__GFP_FS);
 		if (err) {
-			ext3_dec_count(handle, inode);
+			drop_nlink(inode);
 			ext3_mark_inode_dirty(handle, inode);
 			iput (inode);
 			goto out_stop;
@@ -2204,7 +2189,7 @@ retry:
 		handle->h_sync = 1;
 
 	inode->i_ctime = CURRENT_TIME_SEC;
-	ext3_inc_count(handle, inode);
+	inc_nlink(inode);
 	atomic_inc(&inode->i_count);
 
 	err = ext3_add_nondir(handle, dentry, inode);
Index: linux-2.6.19/fs/ext4/namei.c
===================================================================
--- linux-2.6.19.orig/fs/ext4/namei.c
+++ linux-2.6.19/fs/ext4/namei.c
@@ -1616,21 +1616,6 @@ static int ext4_delete_entry (handle_t *
 	return -ENOENT;
 }
 
-/*
- * ext4_mark_inode_dirty is somewhat expensive, so unlike ext2 we
- * do not perform it in these functions.  We perform it at the call site,
- * if it is needed.
- */
-static inline void ext4_inc_count(handle_t *handle, struct inode *inode)
-{
-	inc_nlink(inode);
-}
-
-static inline void ext4_dec_count(handle_t *handle, struct inode *inode)
-{
-	drop_nlink(inode);
-}
-
 static int ext4_add_nondir(handle_t *handle,
 		struct dentry *dentry, struct inode *inode)
 {
@@ -1640,7 +1625,7 @@ static int ext4_add_nondir(handle_t *han
 		d_instantiate(dentry, inode);
 		return 0;
 	}
-	ext4_dec_count(handle, inode);
+	drop_nlink(inode);
 	iput(inode);
 	return err;
 }
@@ -2161,7 +2146,7 @@ retry:
 		err = __page_symlink(inode, symname, l,
 				mapping_gfp_mask(inode->i_mapping) & ~__GFP_FS);
 		if (err) {
-			ext4_dec_count(handle, inode);
+			drop_nlink(inode);
 			ext4_mark_inode_dirty(handle, inode);
 			iput (inode);
 			goto out_stop;
@@ -2202,7 +2187,7 @@ retry:
 		handle->h_sync = 1;
 
 	inode->i_ctime = CURRENT_TIME_SEC;
-	ext4_inc_count(handle, inode);
+	inc_nlink(inode);
 	atomic_inc(&inode->i_count);
 
 	err = ext4_add_nondir(handle, dentry, inode);



