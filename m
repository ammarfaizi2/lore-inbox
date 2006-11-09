Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424053AbWKIPZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424053AbWKIPZa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424047AbWKIPZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:25:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3287 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1424050AbWKIPYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:24:53 -0500
Subject: [PATCH 2/3] new_inode_autonum: convert filesystems to use new
	function
From: Jeff Layton <jlayton@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Nov 2006 10:24:43 -0500
Message-Id: <1163085883.21469.46.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts all in-tree filesystems that blindly use the i_ino 
value given by new_inode to use new_inode_autonum. Also fix up a few
other cases where i_ino might not end up being unique.
    
Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
Signed-off-by: Jeff Layton <jlayton@redhat.com>

diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index 3aaede0..da76197 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -2170,7 +2170,7 @@ pfm_alloc_fd(struct file **cfile)
 	/*
 	 * allocate a new inode
 	 */
-	inode = new_inode(pfmfs_mnt->mnt_sb);
+	inode = new_inode_autonum(pfmfs_mnt->mnt_sb);
 	if (!inode) goto out;
 
 	DPRINT(("new inode ino=%ld @%p\n", inode->i_ino, inode));
diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 427d00a..5d6aaa8 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -79,7 +79,7 @@ spufs_new_inode(struct super_block *sb, 
 {
 	struct inode *inode;
 
-	inode = new_inode(sb);
+	inode = new_inode_autonum(sb);
 	if (!inode)
 		goto out;
 
diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index cd702ae..7d59814 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -84,7 +84,7 @@ static void hypfs_delete_tree(struct den
 
 static struct inode *hypfs_make_inode(struct super_block *sb, int mode)
 {
-	struct inode *ret = new_inode(sb);
+	struct inode *ret = new_inode_autonum(sb);
 
 	if (ret) {
 		struct hypfs_sb_info *hypfs_info = sb->s_fs_info;
diff --git a/drivers/infiniband/hw/ipath/ipath_fs.c b/drivers/infiniband/hw/ipath/ipath_fs.c
index d9ff283..02e3559 100644
--- a/drivers/infiniband/hw/ipath/ipath_fs.c
+++ b/drivers/infiniband/hw/ipath/ipath_fs.c
@@ -51,7 +51,7 @@ static int ipathfs_mknod(struct inode *d
 			 void *data)
 {
 	int error;
-	struct inode *inode = new_inode(dir->i_sb);
+	struct inode *inode = new_inode_autonum(dir->i_sb);
 
 	if (!inode) {
 		error = -EPERM;
diff --git a/drivers/misc/ibmasm/ibmasmfs.c b/drivers/misc/ibmasm/ibmasmfs.c
index b99dc50..2921dc1 100644
--- a/drivers/misc/ibmasm/ibmasmfs.c
+++ b/drivers/misc/ibmasm/ibmasmfs.c
@@ -142,7 +142,7 @@ static int ibmasmfs_fill_super (struct s
 
 static struct inode *ibmasmfs_make_inode(struct super_block *sb, int mode)
 {
-	struct inode *ret = new_inode(sb);
+	struct inode *ret = new_inode_autonum(sb);
 
 	if (ret) {
 		ret->i_mode = mode;
diff --git a/drivers/oprofile/oprofilefs.c b/drivers/oprofile/oprofilefs.c
index 5756401..962e809 100644
--- a/drivers/oprofile/oprofilefs.c
+++ b/drivers/oprofile/oprofilefs.c
@@ -25,7 +25,7 @@ DEFINE_SPINLOCK(oprofilefs_lock);
 
 static struct inode * oprofilefs_get_inode(struct super_block * sb, int mode)
 {
-	struct inode * inode = new_inode(sb);
+	struct inode * inode = new_inode_autonum(sb);
 
 	if (inode) {
 		inode->i_mode = mode;
diff --git a/drivers/usb/core/inode.c b/drivers/usb/core/inode.c
index b5d6a79..673d91c 100644
--- a/drivers/usb/core/inode.c
+++ b/drivers/usb/core/inode.c
@@ -243,7 +243,7 @@ static int remount(struct super_block *s
 
 static struct inode *usbfs_get_inode (struct super_block *sb, int mode, dev_t dev)
 {
-	struct inode *inode = new_inode(sb);
+	struct inode *inode = new_inode_autonum(sb);
 
 	if (inode) {
 		inode->i_mode = mode;
diff --git a/drivers/usb/gadget/inode.c b/drivers/usb/gadget/inode.c
index 86924f9..63ba800 100644
--- a/drivers/usb/gadget/inode.c
+++ b/drivers/usb/gadget/inode.c
@@ -2026,7 +2026,7 @@ gadgetfs_make_inode (struct super_block 
 		void *data, const struct file_operations *fops,
 		int mode)
 {
-	struct inode *inode = new_inode (sb);
+	struct inode *inode = new_inode_autonum(sb);
 
 	if (inode) {
 		inode->i_mode = mode;
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 5241c60..71b91de 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -199,7 +199,7 @@ struct inode *v9fs_get_inode(struct supe
 
 	dprintk(DEBUG_VFS, "super block: %p mode: %o\n", sb, mode);
 
-	inode = new_inode(sb);
+	inode = new_inode_autonum(sb);
 	if (inode) {
 		inode->i_mode = mode;
 		inode->i_uid = current->fsuid;
diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 51fd859..bc18888 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -419,7 +419,7 @@ fail_unlock:
 struct inode *autofs4_get_inode(struct super_block *sb,
 				struct autofs_info *inf)
 {
-	struct inode *inode = new_inode(sb);
+	struct inode *inode = new_inode_autonum(sb);
 
 	if (inode == NULL)
 		return NULL;
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 1713c48..8fe64a8 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -499,7 +499,7 @@ static void entry_status(Node *e, char *
 
 static struct inode *bm_get_inode(struct super_block *sb, int mode)
 {
-	struct inode * inode = new_inode(sb);
+	struct inode * inode = new_inode_autonum(sb);
 
 	if (inode) {
 		inode->i_mode = mode;
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index dffe295..5d566e0 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -80,7 +80,7 @@ int cifs_get_inode_info_unix(struct inod
 
 		/* get new inode */
 		if (*pinode == NULL) {
-			*pinode = new_inode(sb);
+			*pinode = new_inode_autonum(sb);
 			if (*pinode == NULL) 
 				return -ENOMEM;
 			/* Is an i_ino of zero legal? */
@@ -89,7 +89,9 @@ int cifs_get_inode_info_unix(struct inod
 			if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM) {
 				(*pinode)->i_ino =
 					(unsigned long)findData.UniqueId;
-			} /* note ino incremented to unique num in new_inode */
+			} else {
+				(*pinode)->i_ino = iunique(sb, 0);
+			}
 			insert_inode_hash(*pinode);
 		}
 
@@ -418,7 +420,7 @@ int cifs_get_inode_info(struct inode **p
 					/* BB EOPNOSUPP disable SERVER_INUM? */
 				} else /* do we need cast or hash to ino? */
 					(*pinode)->i_ino = inode_num;
-			} /* else ino incremented to unique num in new_inode*/
+			} /* else ino incremented to unique num in new_inode_autonum*/
 			insert_inode_hash(*pinode);
 		}
 		inode = *pinode;
diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index fb18917..b0fad8c 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -133,7 +133,7 @@ static inline void set_inode_attr(struct
 
 struct inode * configfs_new_inode(mode_t mode, struct configfs_dirent * sd)
 {
-	struct inode * inode = new_inode(configfs_sb);
+	struct inode * inode = new_inode_autonum(configfs_sb);
 	if (inode) {
 		inode->i_blocks = 0;
 		inode->i_mapping->a_ops = &configfs_aops;
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index e77676d..331aad9 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -34,7 +34,7 @@ static int debugfs_mount_count;
 
 static struct inode *debugfs_get_inode(struct super_block *sb, int mode, dev_t dev)
 {
-	struct inode *inode = new_inode(sb);
+	struct inode *inode = new_inode_autonum(sb);
 
 	if (inode) {
 		inode->i_mode = mode;
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ae228ec..bd64487 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1623,7 +1623,7 @@ static int eventpollfs_delete_dentry(str
 static struct inode *ep_eventpoll_inode(void)
 {
 	int error = -ENOMEM;
-	struct inode *inode = new_inode(eventpoll_mnt->mnt_sb);
+	struct inode *inode = new_inode_autonum(eventpoll_mnt->mnt_sb);
 
 	if (!inode)
 		goto eexit_1;
diff --git a/fs/freevxfs/vxfs_inode.c b/fs/freevxfs/vxfs_inode.c
index 4786d51..c92df28 100644
--- a/fs/freevxfs/vxfs_inode.c
+++ b/fs/freevxfs/vxfs_inode.c
@@ -261,7 +261,7 @@ vxfs_get_fake_inode(struct super_block *
 {
 	struct inode			*ip = NULL;
 
-	if ((ip = new_inode(sbp))) {
+	if ((ip = new_inode_autonum(sbp))) {
 		vxfs_iinit(ip, vip);
 		ip->i_mapping->a_ops = &vxfs_aops;
 	}
diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 16b39c0..a5caf5a 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -85,7 +85,7 @@ static struct dentry *fuse_ctl_add_dentr
 		return NULL;
 
 	fc->ctl_dentry[fc->ctl_ndents++] = dentry;
-	inode = new_inode(fuse_control_sb);
+	inode = new_inode_autonum(fuse_control_sb);
 	if (!inode)
 		return NULL;
 
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 0bea6a6..213c6c0 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -349,7 +349,7 @@ static struct inode *hugetlbfs_get_inode
 {
 	struct inode *inode;
 
-	inode = new_inode(sb);
+	inode = new_inode_autonum(sb);
 	if (inode) {
 		struct hugetlbfs_inode_info *info;
 		inode->i_mode = mode;
diff --git a/fs/jfs/jfs_inode.c b/fs/jfs/jfs_inode.c
index 4c67ed9..cc9a7bc 100644
--- a/fs/jfs/jfs_inode.c
+++ b/fs/jfs/jfs_inode.c
@@ -58,7 +58,7 @@ struct inode *ialloc(struct inode *paren
 	struct jfs_inode_info *jfs_inode;
 	int rc;
 
-	inode = new_inode(sb);
+	inode = new_inode_autonum(sb);
 	if (!inode) {
 		jfs_warn("ialloc: new_inode returned NULL!");
 		return ERR_PTR(-ENOMEM);
diff --git a/fs/ocfs2/dlm/dlmfs.c b/fs/ocfs2/dlm/dlmfs.c
index 16b8d1b..f38c914 100644
--- a/fs/ocfs2/dlm/dlmfs.c
+++ b/fs/ocfs2/dlm/dlmfs.c
@@ -325,7 +325,7 @@ static struct backing_dev_info dlmfs_bac
 
 static struct inode *dlmfs_get_root_inode(struct super_block *sb)
 {
-	struct inode *inode = new_inode(sb);
+	struct inode *inode = new_inode_autonum(sb);
 	int mode = S_IFDIR | 0755;
 	struct dlmfs_inode_private *ip;
 
@@ -352,7 +352,7 @@ static struct inode *dlmfs_get_inode(str
 				     int mode)
 {
 	struct super_block *sb = parent->i_sb;
-	struct inode * inode = new_inode(sb);
+	struct inode * inode = new_inode_autonum(sb);
 	struct dlmfs_inode_private *ip;
 
 	if (!inode)
diff --git a/fs/pipe.c b/fs/pipe.c
index b1626f2..fb14bd1 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -839,7 +839,7 @@ static struct dentry_operations pipefs_d
 
 static struct inode * get_pipe_inode(void)
 {
-	struct inode *inode = new_inode(pipe_mnt->mnt_sb);
+	struct inode *inode = new_inode_autonum(pipe_mnt->mnt_sb);
 	struct pipe_inode_info *pipe;
 
 	if (!inode)
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 2faf4cd..03573d4 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -52,7 +52,7 @@ static struct backing_dev_info ramfs_bac
 
 struct inode *ramfs_get_inode(struct super_block *sb, int mode, dev_t dev)
 {
-	struct inode * inode = new_inode(sb);
+	struct inode * inode = new_inode_autonum(sb);
 
 	if (inode) {
 		inode->i_mode = mode;
diff --git a/fs/sysfs/inode.c b/fs/sysfs/inode.c
index e79e38d..6dc0e0f 100644
--- a/fs/sysfs/inode.c
+++ b/fs/sysfs/inode.c
@@ -123,7 +123,7 @@ static struct lock_class_key sysfs_inode
 
 struct inode * sysfs_new_inode(mode_t mode, struct sysfs_dirent * sd)
 {
-	struct inode * inode = new_inode(sysfs_sb);
+	struct inode * inode = new_inode_autonum(sysfs_sb);
 	if (inode) {
 		inode->i_blocks = 0;
 		inode->i_mapping->a_ops = &sysfs_aops;
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 7c27400..a8c83e5 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -110,7 +110,7 @@ static struct inode *mqueue_get_inode(st
 {
 	struct inode *inode;
 
-	inode = new_inode(sb);
+	inode = new_inode_autonum(sb);
 	if (inode) {
 		inode->i_mode = mode;
 		inode->i_uid = current->fsuid;
diff --git a/kernel/cpuset.c b/kernel/cpuset.c
index 6313c38..6dd0156 100644
--- a/kernel/cpuset.c
+++ b/kernel/cpuset.c
@@ -283,7 +283,7 @@ static struct backing_dev_info cpuset_ba
 
 static struct inode *cpuset_new_inode(mode_t mode)
 {
-	struct inode *inode = new_inode(cpuset_sb);
+	struct inode *inode = new_inode_autonum(cpuset_sb);
 
 	if (inode) {
 		inode->i_mode = mode;
diff --git a/mm/shmem.c b/mm/shmem.c
index 4959535..0d47801 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1354,7 +1354,7 @@ shmem_get_inode(struct super_block *sb, 
 		spin_unlock(&sbinfo->stat_lock);
 	}
 
-	inode = new_inode(sb);
+	inode = new_inode_autonum(sb);
 	if (inode) {
 		inode->i_mode = mode;
 		inode->i_uid = current->fsuid;
diff --git a/net/socket.c b/net/socket.c
index 6c9b9b3..e8d75f5 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -474,7 +474,7 @@ static struct socket *sock_alloc(void)
 	struct inode *inode;
 	struct socket *sock;
 
-	inode = new_inode(sock_mnt->mnt_sb);
+	inode = new_inode_autonum(sock_mnt->mnt_sb);
 	if (!inode)
 		return NULL;
 
diff --git a/security/inode.c b/security/inode.c
index 9b16e14..b1a4e08 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -58,7 +58,7 @@ static struct file_operations default_fi
 
 static struct inode *get_inode(struct super_block *sb, int mode, dev_t dev)
 {
-	struct inode *inode = new_inode(sb);
+	struct inode *inode = new_inode_autonum(sb);
 
 	if (inode) {
 		inode->i_mode = mode;
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index cd24441..98493ce 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -766,7 +766,7 @@ out:
 
 static struct inode *sel_make_inode(struct super_block *sb, int mode)
 {
-	struct inode *ret = new_inode(sb);
+	struct inode *ret = new_inode_autonum(sb);
 
 	if (ret) {
 		ret->i_mode = mode;


