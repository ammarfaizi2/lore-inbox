Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266322AbSKGDzc>; Wed, 6 Nov 2002 22:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266320AbSKGDxo>; Wed, 6 Nov 2002 22:53:44 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:44161 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S266322AbSKGDwb>;
	Wed, 6 Nov 2002 22:52:31 -0500
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ext2/3 bugfix 4/6: Fix ext3 htree rename bug
From: tytso@mit.edu
Message-Id: <E189doz-0007Ge-00@snap.thunk.org>
Date: Wed, 06 Nov 2002 22:59:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix ext3 htree rename bug.

This fixes an ext3 htree bug pointed out by Christopher Li; if 
adding the new name to the directory causes a split, this can cause
the directory entry containing the old name to move to another 
block, and then the removal of the old name will fail.

namei.c |   21 ++++++++++++++++++++-
1 files changed, 20 insertions(+), 1 deletion(-)

diff -Nru a/fs/ext3/namei.c b/fs/ext3/namei.c
--- a/fs/ext3/namei.c	Wed Nov  6 22:26:40 2002
+++ b/fs/ext3/namei.c	Wed Nov  6 22:26:40 2002
@@ -2243,7 +2243,26 @@
 	/*
 	 * ok, that's it
 	 */
-	ext3_delete_entry(handle, old_dir, old_de, old_bh);
+	retval = ext3_delete_entry(handle, old_dir, old_de, old_bh);
+	if (retval == -ENOENT) {
+		/*
+		 * old_de could have moved out from under us.
+		 */
+		struct buffer_head *old_bh2;
+		struct ext3_dir_entry_2 *old_de2;
+		
+		old_bh2 = ext3_find_entry(old_dentry, &old_de2);
+		if (old_bh2) {
+			retval = ext3_delete_entry(handle, old_dir,
+						   old_de2, old_bh2);
+			brelse(old_bh2);
+		}
+	}
+	if (retval) {
+		ext3_warning(old_dir->i_sb, "ext3_rename",
+				"Deleting old file (%lu), %d, error=%d",
+				old_dir->i_ino, old_dir->i_nlink, retval);
+	}
 
 	if (new_inode) {
 		new_inode->i_nlink--;
