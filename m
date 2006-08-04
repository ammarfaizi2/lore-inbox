Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbWHDFsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWHDFsr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbWHDFow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:44:52 -0400
Received: from cantor2.suse.de ([195.135.220.15]:11696 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030332AbWHDFor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:44:47 -0400
Date: Thu, 3 Aug 2006 22:40:10 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jack@suse.cz, esandeen@redhat.com,
       neilb@suse.de, Marcel Holtmann <marcel@holtmann.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 16/23] ext3: avoid triggering ext3_error on bad NFS file handle
Message-ID: <20060804054010.GQ769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ext3-avoid-triggering-ext3_error-on-bad-nfs-file-handle.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Neil Brown <neilb@suse.de>

The inode number out of an NFS file handle gets passed eventually to
ext3_get_inode_block() without any checking.  If ext3_get_inode_block()
allows it to trigger an error, then bad filehandles can have unpleasant
effect - ext3_error() will usually cause a forced read-only remount, or a
panic if `errors=panic' was used.

So remove the call to ext3_error there and put a matching check in
ext3/namei.c where inode numbers are read off storage.

[akpm@osdl.org: fix off-by-one error]
Signed-off-by: Neil Brown <neilb@suse.de>
Signed-off-by: Jan Kara <jack@suse.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Eric Sandeen <esandeen@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/ext3/inode.c         |   13 +++++++------
 fs/ext3/namei.c         |   15 +++++++++++++--
 include/linux/ext3_fs.h |    9 +++++++++
 3 files changed, 29 insertions(+), 8 deletions(-)

--- linux-2.6.17.7.orig/fs/ext3/inode.c
+++ linux-2.6.17.7/fs/ext3/inode.c
@@ -2402,14 +2402,15 @@ static unsigned long ext3_get_inode_bloc
 	struct buffer_head *bh;
 	struct ext3_group_desc * gdp;
 
-
-	if ((ino != EXT3_ROOT_INO && ino != EXT3_JOURNAL_INO &&
-		ino != EXT3_RESIZE_INO && ino < EXT3_FIRST_INO(sb)) ||
-		ino > le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count)) {
-		ext3_error(sb, "ext3_get_inode_block",
-			    "bad inode number: %lu", ino);
+	if (!ext3_valid_inum(sb, ino)) {
+		/*
+		 * This error is already checked for in namei.c unless we are
+		 * looking at an NFS filehandle, in which case no error
+		 * report is needed
+		 */
 		return 0;
 	}
+
 	block_group = (ino - 1) / EXT3_INODES_PER_GROUP(sb);
 	if (block_group >= EXT3_SB(sb)->s_groups_count) {
 		ext3_error(sb,"ext3_get_inode_block","group >= groups count");
--- linux-2.6.17.7.orig/fs/ext3/namei.c
+++ linux-2.6.17.7/fs/ext3/namei.c
@@ -1000,7 +1000,12 @@ static struct dentry *ext3_lookup(struct
 	if (bh) {
 		unsigned long ino = le32_to_cpu(de->inode);
 		brelse (bh);
-		inode = iget(dir->i_sb, ino);
+		if (!ext3_valid_inum(dir->i_sb, ino)) {
+			ext3_error(dir->i_sb, "ext3_lookup",
+				   "bad inode number: %lu", ino);
+			inode = NULL;
+		} else
+			inode = iget(dir->i_sb, ino);
 
 		if (!inode)
 			return ERR_PTR(-EACCES);
@@ -1028,7 +1033,13 @@ struct dentry *ext3_get_parent(struct de
 		return ERR_PTR(-ENOENT);
 	ino = le32_to_cpu(de->inode);
 	brelse(bh);
-	inode = iget(child->d_inode->i_sb, ino);
+
+	if (!ext3_valid_inum(child->d_inode->i_sb, ino)) {
+		ext3_error(child->d_inode->i_sb, "ext3_get_parent",
+			   "bad inode number: %lu", ino);
+		inode = NULL;
+	} else
+		inode = iget(child->d_inode->i_sb, ino);
 
 	if (!inode)
 		return ERR_PTR(-EACCES);
--- linux-2.6.17.7.orig/include/linux/ext3_fs.h
+++ linux-2.6.17.7/include/linux/ext3_fs.h
@@ -495,6 +495,15 @@ static inline struct ext3_inode_info *EX
 {
 	return container_of(inode, struct ext3_inode_info, vfs_inode);
 }
+
+static inline int ext3_valid_inum(struct super_block *sb, unsigned long ino)
+{
+	return ino == EXT3_ROOT_INO ||
+		ino == EXT3_JOURNAL_INO ||
+		ino == EXT3_RESIZE_INO ||
+		(ino >= EXT3_FIRST_INO(sb) &&
+		 ino <= le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count));
+}
 #else
 /* Assume that user mode programs are passing in an ext3fs superblock, not
  * a kernel struct super_block.  This will allow us to call the feature-test

--
