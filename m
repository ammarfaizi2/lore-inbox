Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266319AbSKGDxW>; Wed, 6 Nov 2002 22:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266326AbSKGDxT>; Wed, 6 Nov 2002 22:53:19 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:42625 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S266319AbSKGDwS>;
	Wed, 6 Nov 2002 22:52:18 -0500
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ext2/3 bugfix 2/6: readdir() needs to return '.' and '..'
From: tytso@mit.edu
Message-Id: <E189don-0007Ga-00@snap.thunk.org>
Date: Wed, 06 Nov 2002 22:58:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add '.' and '..' entries to be returned by readdir of htree directories

This patch from Chris Li adds '.' and '..' to the rbtree so that they 
are properly returned by readdir.

namei.c |    9 +++++++++
1 files changed, 9 insertions(+)

diff -Nru a/fs/ext3/namei.c b/fs/ext3/namei.c
--- a/fs/ext3/namei.c	Wed Nov  6 17:29:46 2002
+++ b/fs/ext3/namei.c	Wed Nov  6 17:29:46 2002
@@ -549,6 +549,15 @@
 	if (!frame)
 		return err;
 
+	/* Add '.' and '..' from the htree header */
+	if (!start_hash && !start_minor_hash) {
+		de = (struct ext3_dir_entry_2 *) frames[0].bh->b_data;
+		ext3_htree_store_dirent(dir_file, 0, 0, de);
+		de = ext3_next_entry(de);
+		ext3_htree_store_dirent(dir_file, 0, 0, de);
+		count += 2;
+	}
+
 	while (1) {
 		block = dx_get_block(frame->at);
 		dxtrace(printk("Reading block %d\n", block));
