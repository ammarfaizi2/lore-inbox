Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132684AbRDKRlP>; Wed, 11 Apr 2001 13:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132688AbRDKRlH>; Wed, 11 Apr 2001 13:41:07 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:37387 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S132683AbRDKRkt>; Wed, 11 Apr 2001 13:40:49 -0400
Date: Wed, 11 Apr 2001 13:41:44 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] Initial permissions on ramfs
Message-ID: <Pine.LNX.4.33.0104111322440.22147-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patch is against 2.4.3-ac4. It won't apply to the Linus' tree!

This patch makes it possible to manage all RAM filesystems in one place -
in /etc/fstab. No need to write scripts to change permissions after mount.

The patch adds "mode", "uid" and "gid" options to ramfs. They only affect
the top-level directory. The permissions can be changed later. For
example:

mount -t ramfs -o mode=1777,uid=0,gid=100 none /tmp

This patch superseeds my older patch that only allowed to specify "mode"
but not "gid" and "uid" of the top-level directory. It also includes
corresponding changes in the documentation.

I'm using this patch all the time on the system where I'm writing these
lines for /tmp. No problems so far.

This patch is orthogonal to the "umount" problem I reported yesterday
(http://www.uwsg.indiana.edu/hypermail/linux/kernel/0104.1/0414.html) - it
neither fixes nor introduces the "umount" problem.

The patch is also available online:
http://www.red-bean.com/~proski/linux/ramfs_access.diff

-- 
Regards,
Pavel Roskin

_______________________________
--- linux.orig/Documentation/filesystems/ramfs.txt
+++ linux/Documentation/filesystems/ramfs.txt
@@ -45,3 +45,18 @@
 		Sets the maximum number of inodes (i.e. distinct
 files) on the filesystem to NNN. If NNN=0 there is no limit. The
 default is no limit (but there can never be more inodes than dentries).
+
+	mode=NNN
+		Sets the initial permissions of the root inode. By
+default this is 755. You can specify the sticky bit if you want to
+mount /tmp as ramfs, but make sure to set maxsize (see above) to a safe
+value to avoid running out of memory.
+
+	uid=NNN
+		Sets the initial owner of the root inode. You can later
+change the owner. Other inodes are not affected.
+
+	gid=NNN
+		Sets the initial group of the root inode. You can later
+change the group. Other inodes are not affected.
+
--- linux.orig/fs/ramfs/inode.c
+++ linux/fs/ramfs/inode.c
@@ -297,7 +297,7 @@ static void ramfs_truncatepage(struct pa
 	ramfs_dealloc_page(inode, page);
 }

-struct inode *ramfs_get_inode(struct super_block *sb, int mode, int dev)
+struct inode *ramfs_get_inode(struct super_block *sb, int mode, int dev, uid_t uid, gid_t gid)
 {
 	struct inode * inode;

@@ -308,8 +308,8 @@ struct inode *ramfs_get_inode(struct sup

 	if (inode) {
 		inode->i_mode = mode;
-		inode->i_uid = current->fsuid;
-		inode->i_gid = current->fsgid;
+		inode->i_uid = uid;
+		inode->i_gid = gid;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_rdev = to_kdev_t(dev);
@@ -349,7 +349,7 @@ static int ramfs_mknod(struct inode *dir
 	if (! ramfs_alloc_dentry(sb))
 		return error;

-	inode = ramfs_get_inode(dir->i_sb, mode, dev);
+	inode = ramfs_get_inode(dir->i_sb, mode, dev, current->fsuid, current->fsgid);

 	if (inode) {
 		d_instantiate(dentry, inode);
@@ -504,6 +504,9 @@ struct ramfs_params {
 	long filepages;
 	long inodes;
 	long dentries;
+	mode_t root_mode;
+	mode_t root_uid;
+	mode_t root_gid;
 };

 static int parse_options(char * options, struct ramfs_params *p)
@@ -514,6 +517,9 @@ static int parse_options(char * options,
 	p->filepages = -1;
 	p->inodes = -1;
 	p->dentries = -1;
+	p->root_mode = 755;
+	p->root_uid = current->uid;
+	p->root_gid = current->gid;

 	for (optname = strtok(options,","); optname;
 	     optname = strtok(NULL,",")) {
@@ -541,6 +547,18 @@ static int parse_options(char * options,
 			p->dentries = simple_strtoul(value, &value, 0);
 			if (*value)
 				return -EINVAL;
+		} else if (!strcmp(optname, "mode") && value) {
+			p->root_mode = simple_strtoul(value, &value, 8) & 07777;
+			if (*value)
+				return -EINVAL;
+		} else if (!strcmp(optname, "uid") && value) {
+			p->root_uid = simple_strtoul(value, &value, 0);
+			if (*value)
+				return -EINVAL;
+		} else if (!strcmp(optname, "gid") && value) {
+			p->root_gid = simple_strtoul(value, &value, 0);
+			if (*value)
+				return -EINVAL;
 		}

 		if (optname != options)
@@ -725,7 +743,8 @@ static struct super_block *ramfs_read_su

 	init_limits(rsb, &params);

-	inode = ramfs_get_inode(sb, S_IFDIR | 0755, 0);
+	inode = ramfs_get_inode(sb, S_IFDIR | params.root_mode, 0,
+				params.root_uid,  params.root_gid);
 	if (!inode)
 		return NULL;

_______________________________


