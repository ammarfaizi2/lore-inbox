Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVEII6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVEII6H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 04:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVEII6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 04:58:07 -0400
Received: from godzilla.roxen.com ([212.247.28.43]:49105 "EHLO mail.roxen.com")
	by vger.kernel.org with ESMTP id S261159AbVEII54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 04:57:56 -0400
Date: Mon, 9 May 2005 10:57:48 +0200 (MET DST)
From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@grubba.org>
To: sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com,
       neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Support for dx directories in ext3_get_parent (NFSD)
Message-ID: <Pine.GSO.4.21.0505091032000.22820-100000@jms.roxen.com>
Organization: Roxen Internet Software AB
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.6.10 ext3_get_parent attempts to use ext3_find_entry to look up the
entry "..", which fails for dx directories since ".." is not present in
the directory hash table. The patch below solves this by looking up the
dotdot entry in the dx_root block.

Typical symptoms of the above bug are intermittent claims by nfsd that
files or directories are missing on exported ext3 filesystems.

cf https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=150759
and https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=144556

Signed-off-by: Henrik Grubbström <grubba@grubba.org>

--- linux/fs/ext3/namei.c.orig	2005-05-06 17:08:31.000000000 +0200
+++ linux/fs/ext3/namei.c	2005-05-07 17:57:24.000000000 +0200
@@ -999,24 +999,90 @@ static struct dentry *ext3_lookup(struct
 
 struct dentry *ext3_get_parent(struct dentry *child)
 {
-	unsigned long ino;
+	unsigned long ino = 0;
 	struct dentry *parent;
 	struct inode *inode;
-	struct dentry dotdot;
-	struct ext3_dir_entry_2 * de;
 	struct buffer_head *bh;
+	int err;
+	struct inode *dir = child->d_inode;
+	struct super_block *sb = dir->i_sb;
 
-	dotdot.d_name.name = "..";
-	dotdot.d_name.len = 2;
-	dotdot.d_parent = child; /* confusing, isn't it! */
+	/* In all cases the ".." entry is in block #0, so read it. */
+	bh = ext3_bread(NULL, dir, 0, 0, &err);
+	if (!bh) return ERR_PTR(err);
+
+#ifdef CONFIG_EXT3_INDEX
+	if (is_dx(dir)) {
+		/* Block #0 is a dx_root. */
+		struct dx_root *root = (struct dx_root *)bh->b_data;
+		if (root->info.hash_version == DX_HASH_TEA ||
+		    root->info.hash_version == DX_HASH_HALF_MD4 ||
+		    root->info.hash_version == DX_HASH_LEGACY) {
+			/* Is this paranoia actually needed? */
+			ino = le32_to_cpu(root->dotdot.inode);
+		} else {
+			ext3_error(sb, __FUNCTION__,
+				"unsupported dx hash_version (%d) for #%lu\n",
+				root->info.hash_version, dir->i_ino);
+		}
+	}
+	if (!ino)
+#endif
+	{
+		/* Block #0 is a sequence of ext3_dir_entry_2.
+		 * ".." is the second entry.
+		 */
+		struct ext3_dir_entry_2 *de =
+			(struct ext3_dir_entry_2 *)bh->b_data;
+		int len = le16_to_cpu(de->rec_len);
+		if (len > 0) {
+			/* The first entry should be ".". */
+			de = (struct ext3_dir_entry_2 *)((char *)de + len);
+			if ((de->name_len == 2) &&
+			    (de->name[0] == '.') &&
+			    (de->name[1] == '.')) {
+				/* The second entry should be "..". */
+				ino = le32_to_cpu(de->inode);
+			} else {
+				ext3_warning(sb, __FUNCTION__,
+					"second entry of #%lu not parent",
+					dir->i_ino);
+			}
+		} else {
+			ext3_error(sb, __FUNCTION__,
+				"first entry of #%lu has bad rec_len: %d",
+				dir->i_ino, len);
+		}
+#if 0
+		/* Fallback code to enable if the ".." entry ever can
+		 * be somewhere else than in the second entry of the
+		 * first block.
+		 */
+		if (!ino) {
+			struct dentry dotdot;
+
+			ext3_warning(sb, __FUNCTION__,
+				"falling back to ext3_find_entry for #%lu\n",
+				dir->i_ino);
+			brelse(bh);
+			dotdot.d_name.name = "..";
+			dotdot.d_name.len = 2;
+			dotdot.d_parent = child; /* confusing, isn't it! */
+
+			bh = ext3_find_entry(&dotdot, &de);
+			if (!bh)
+				return ERR_PTR(-ENOENT);
+			ino = le32_to_cpu(de->inode);
+		}
+#endif /* 0 */
+	}
 
-	bh = ext3_find_entry(&dotdot, &de);
-	inode = NULL;
-	if (!bh)
-		return ERR_PTR(-ENOENT);
-	ino = le32_to_cpu(de->inode);
 	brelse(bh);
-	inode = iget(child->d_inode->i_sb, ino);
+
+	if (!ino)
+		return ERR_PTR(-ENOENT);
+
+	inode = iget(sb, ino);
 
 	if (!inode)
 		return ERR_PTR(-EACCES);

--
Henrik Grubbström					grubba@grubba.org
Roxen Internet Software AB				grubba@roxen.com

