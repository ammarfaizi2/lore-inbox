Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965600AbWKGR2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965600AbWKGR2m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 12:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965598AbWKGR2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 12:28:42 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:8904 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965597AbWKGR2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 12:28:40 -0500
Date: Tue, 7 Nov 2006 18:28:35 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jeff Layton <jlayton@redhat.com>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels that offer x86 compatability
Message-ID: <20061107172835.GB15629@wohnheim.fh-wedel.de>
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com> <20061106182222.GO27140@parisc-linux.org> <1162838843.12129.8.camel@dantu.rdu.redhat.com> <20061106202313.GA691@wohnheim.fh-wedel.de> <454FA032.1070008@redhat.com> <20061106211134.GB691@wohnheim.fh-wedel.de> <454FAAF8.8080707@redhat.com> <1162914966.28425.24.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1162914966.28425.24.camel@dantu.rdu.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 November 2006 10:56:06 -0500, Jeff Layton wrote:
> -struct inode *new_inode(struct super_block *sb)
> +struct inode *new_inode_autonum(struct super_block *sb, int autonum)

Looking at the callers, it seemed a bit more natural to me to call
new_inode_autonum(sb) than new_inode_autonum(sb, 1).  Would you mind
turning new_inode_autonum() in a wrapper like new_inode() and putting
the actual code into a static helper?

Anyway, here is a first patch converting some callers that looked
obvious.

JÃ¶rn

-- 
Man darf nicht das, was uns unwahrscheinlich und unnatürlich erscheint,
mit dem verwechseln, was absolut unmöglich ist.
-- Carl Friedrich Gauß


Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 arch/ia64/kernel/perfmon.c                |    2 +-
 arch/powerpc/platforms/cell/spufs/inode.c |    2 +-
 arch/s390/hypfs/inode.c                   |    2 +-
 drivers/infiniband/hw/ipath/ipath_fs.c    |    2 +-
 drivers/misc/ibmasm/ibmasmfs.c            |    2 +-
 drivers/oprofile/oprofilefs.c             |    2 +-
 drivers/usb/core/inode.c                  |    2 +-
 drivers/usb/gadget/inode.c                |    2 +-
 fs/autofs4/inode.c                        |    2 +-
 fs/binfmt_misc.c                          |    2 +-
 fs/configfs/inode.c                       |    2 +-
 fs/debugfs/inode.c                        |    2 +-
 fs/eventpoll.c                            |    2 +-
 fs/freevxfs/vxfs_inode.c                  |    2 +-
 fs/fuse/control.c                         |    2 +-
 fs/hugetlbfs/inode.c                      |    2 +-
 fs/ocfs2/dlm/dlmfs.c                      |    4 ++--
 fs/pipe.c                                 |    2 +-
 fs/ramfs/inode.c                          |    2 +-
 fs/sysfs/inode.c                          |    2 +-
 ipc/mqueue.c                              |    2 +-
 kernel/cpuset.c                           |    2 +-
 mm/shmem.c                                |    2 +-
 net/socket.c                              |    2 +-
 security/inode.c                          |    2 +-
 security/selinux/selinuxfs.c              |    2 +-
 26 files changed, 27 insertions(+), 27 deletions(-)

--- iunique/arch/ia64/kernel/perfmon.c~iunique	2006-10-13 15:50:36.000000000 +0200
+++ iunique/arch/ia64/kernel/perfmon.c	2006-11-07 18:06:51.000000000 +0100
@@ -2167,7 +2167,7 @@ pfm_alloc_fd(struct file **cfile)
 	/*
 	 * allocate a new inode
 	 */
-	inode = new_inode(pfmfs_mnt->mnt_sb);
+	inode = new_inode_autonum(pfmfs_mnt->mnt_sb);
 	if (!inode) goto out;
 
 	DPRINT(("new inode ino=%ld @%p\n", inode->i_ino, inode));
--- iunique/arch/powerpc/platforms/cell/spufs/inode.c~iunique	2006-10-13 15:51:29.000000000 +0200
+++ iunique/arch/powerpc/platforms/cell/spufs/inode.c	2006-11-07 18:07:18.000000000 +0100
@@ -75,7 +75,7 @@ spufs_new_inode(struct super_block *sb, 
 {
 	struct inode *inode;
 
-	inode = new_inode(sb);
+	inode = new_inode_autonum(sb);
 	if (!inode)
 		goto out;
 
--- iunique/arch/s390/hypfs/inode.c~iunique	2006-10-13 15:51:52.000000000 +0200
+++ iunique/arch/s390/hypfs/inode.c	2006-11-07 18:07:37.000000000 +0100
@@ -84,7 +84,7 @@ static void hypfs_delete_tree(struct den
 
 static struct inode *hypfs_make_inode(struct super_block *sb, int mode)
 {
-	struct inode *ret = new_inode(sb);
+	struct inode *ret = new_inode_autonum(sb);
 
 	if (ret) {
 		struct hypfs_sb_info *hypfs_info = sb->s_fs_info;
--- iunique/drivers/infiniband/hw/ipath/ipath_fs.c~iunique	2006-10-13 15:53:19.000000000 +0200
+++ iunique/drivers/infiniband/hw/ipath/ipath_fs.c	2006-11-07 18:08:06.000000000 +0100
@@ -51,7 +51,7 @@ static int ipathfs_mknod(struct inode *d
 			 void *data)
 {
 	int error;
-	struct inode *inode = new_inode(dir->i_sb);
+	struct inode *inode = new_inode_autonum(dir->i_sb);
 
 	if (!inode) {
 		error = -EPERM;
--- iunique/drivers/misc/ibmasm/ibmasmfs.c~iunique	2006-10-13 15:53:59.000000000 +0200
+++ iunique/drivers/misc/ibmasm/ibmasmfs.c	2006-11-07 18:08:26.000000000 +0100
@@ -142,7 +142,7 @@ static int ibmasmfs_fill_super (struct s
 
 static struct inode *ibmasmfs_make_inode(struct super_block *sb, int mode)
 {
-	struct inode *ret = new_inode(sb);
+	struct inode *ret = new_inode_autonum(sb);
 
 	if (ret) {
 		ret->i_mode = mode;
--- iunique/drivers/oprofile/oprofilefs.c~iunique	2006-10-13 15:54:40.000000000 +0200
+++ iunique/drivers/oprofile/oprofilefs.c	2006-11-07 18:08:45.000000000 +0100
@@ -25,7 +25,7 @@ DEFINE_SPINLOCK(oprofilefs_lock);
 
 static struct inode * oprofilefs_get_inode(struct super_block * sb, int mode)
 {
-	struct inode * inode = new_inode(sb);
+	struct inode * inode = new_inode_autonum(sb);
 
 	if (inode) {
 		inode->i_mode = mode;
--- iunique/drivers/usb/core/inode.c~iunique	2006-10-13 15:55:22.000000000 +0200
+++ iunique/drivers/usb/core/inode.c	2006-11-07 18:09:03.000000000 +0100
@@ -243,7 +243,7 @@ static int remount(struct super_block *s
 
 static struct inode *usbfs_get_inode (struct super_block *sb, int mode, dev_t dev)
 {
-	struct inode *inode = new_inode(sb);
+	struct inode *inode = new_inode_autonum(sb);
 
 	if (inode) {
 		inode->i_mode = mode;
--- iunique/drivers/usb/gadget/inode.c~iunique	2006-10-13 15:55:23.000000000 +0200
+++ iunique/drivers/usb/gadget/inode.c	2006-11-07 18:10:41.000000000 +0100
@@ -1960,7 +1960,7 @@ gadgetfs_make_inode (struct super_block 
 		void *data, const struct file_operations *fops,
 		int mode)
 {
-	struct inode *inode = new_inode (sb);
+	struct inode *inode = new_inode_autonum(sb);
 
 	if (inode) {
 		inode->i_mode = mode;
--- iunique/fs/autofs4/inode.c~iunique	2006-10-13 15:55:48.000000000 +0200
+++ iunique/fs/autofs4/inode.c	2006-11-07 18:11:28.000000000 +0100
@@ -432,7 +432,7 @@ fail_unlock:
 struct inode *autofs4_get_inode(struct super_block *sb,
 				struct autofs_info *inf)
 {
-	struct inode *inode = new_inode(sb);
+	struct inode *inode = new_inode_autonum(sb);
 
 	if (inode == NULL)
 		return NULL;
--- iunique/fs/binfmt_misc.c~iunique	2006-10-13 15:55:49.000000000 +0200
+++ iunique/fs/binfmt_misc.c	2006-11-07 18:11:50.000000000 +0100
@@ -501,7 +501,7 @@ static void entry_status(Node *e, char *
 
 static struct inode *bm_get_inode(struct super_block *sb, int mode)
 {
-	struct inode * inode = new_inode(sb);
+	struct inode * inode = new_inode_autonum(sb);
 
 	if (inode) {
 		inode->i_mode = mode;
--- iunique/fs/configfs/inode.c~iunique	2006-10-13 15:55:51.000000000 +0200
+++ iunique/fs/configfs/inode.c	2006-11-07 18:13:09.000000000 +0100
@@ -134,7 +134,7 @@ static inline void set_inode_attr(struct
 
 struct inode * configfs_new_inode(mode_t mode, struct configfs_dirent * sd)
 {
-	struct inode * inode = new_inode(configfs_sb);
+	struct inode * inode = new_inode_autonum(configfs_sb);
 	if (inode) {
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
--- iunique/fs/debugfs/inode.c~iunique	2006-10-13 15:55:51.000000000 +0200
+++ iunique/fs/debugfs/inode.c	2006-11-07 18:13:27.000000000 +0100
@@ -34,7 +34,7 @@ static int debugfs_mount_count;
 
 static struct inode *debugfs_get_inode(struct super_block *sb, int mode, dev_t dev)
 {
-	struct inode *inode = new_inode(sb);
+	struct inode *inode = new_inode_autonum(sb);
 
 	if (inode) {
 		inode->i_mode = mode;
--- iunique/fs/eventpoll.c~iunique	2006-10-13 15:55:53.000000000 +0200
+++ iunique/fs/eventpoll.c	2006-11-07 18:14:11.000000000 +0100
@@ -1572,7 +1572,7 @@ static int eventpollfs_delete_dentry(str
 static struct inode *ep_eventpoll_inode(void)
 {
 	int error = -ENOMEM;
-	struct inode *inode = new_inode(eventpoll_mnt->mnt_sb);
+	struct inode *inode = new_inode_autonum(eventpoll_mnt->mnt_sb);
 
 	if (!inode)
 		goto eexit_1;
--- iunique/fs/freevxfs/vxfs_inode.c~iunique	2006-10-13 15:55:58.000000000 +0200
+++ iunique/fs/freevxfs/vxfs_inode.c	2006-11-07 18:15:48.000000000 +0100
@@ -262,7 +262,7 @@ vxfs_get_fake_inode(struct super_block *
 {
 	struct inode			*ip = NULL;
 
-	if ((ip = new_inode(sbp))) {
+	if ((ip = new_inode_autonum(sbp))) {
 		vxfs_iinit(ip, vip);
 		ip->i_mapping->a_ops = &vxfs_aops;
 	}
--- iunique/fs/fuse/control.c~iunique	2006-10-13 15:55:59.000000000 +0200
+++ iunique/fs/fuse/control.c	2006-11-07 18:15:58.000000000 +0100
@@ -85,7 +85,7 @@ static struct dentry *fuse_ctl_add_dentr
 		return NULL;
 
 	fc->ctl_dentry[fc->ctl_ndents++] = dentry;
-	inode = new_inode(fuse_control_sb);
+	inode = new_inode_autonum(fuse_control_sb);
 	if (!inode)
 		return NULL;
 
--- iunique/fs/hugetlbfs/inode.c~iunique	2006-10-13 15:56:01.000000000 +0200
+++ iunique/fs/hugetlbfs/inode.c	2006-11-07 18:16:30.000000000 +0100
@@ -351,7 +351,7 @@ static struct inode *hugetlbfs_get_inode
 {
 	struct inode *inode;
 
-	inode = new_inode(sb);
+	inode = new_inode_autonum(sb);
 	if (inode) {
 		struct hugetlbfs_inode_info *info;
 		inode->i_mode = mode;
--- iunique/fs/ocfs2/dlm/dlmfs.c~iunique	2006-10-13 15:56:17.000000000 +0200
+++ iunique/fs/ocfs2/dlm/dlmfs.c	2006-11-07 18:19:11.000000000 +0100
@@ -325,7 +325,7 @@ static struct backing_dev_info dlmfs_bac
 
 static struct inode *dlmfs_get_root_inode(struct super_block *sb)
 {
-	struct inode *inode = new_inode(sb);
+	struct inode *inode = new_inode_autonum(sb);
 	int mode = S_IFDIR | 0755;
 	struct dlmfs_inode_private *ip;
 
@@ -353,7 +353,7 @@ static struct inode *dlmfs_get_inode(str
 				     int mode)
 {
 	struct super_block *sb = parent->i_sb;
-	struct inode * inode = new_inode(sb);
+	struct inode * inode = new_inode_autonum(sb);
 	struct dlmfs_inode_private *ip;
 
 	if (!inode)
--- iunique/fs/pipe.c~iunique	2006-10-13 15:56:19.000000000 +0200
+++ iunique/fs/pipe.c	2006-11-07 18:19:21.000000000 +0100
@@ -854,7 +854,7 @@ static struct dentry_operations pipefs_d
 
 static struct inode * get_pipe_inode(void)
 {
-	struct inode *inode = new_inode(pipe_mnt->mnt_sb);
+	struct inode *inode = new_inode_autonum(pipe_mnt->mnt_sb);
 	struct pipe_inode_info *pipe;
 
 	if (!inode)
--- iunique/fs/ramfs/inode.c~iunique	2006-10-13 15:56:23.000000000 +0200
+++ iunique/fs/ramfs/inode.c	2006-11-07 18:19:36.000000000 +0100
@@ -52,7 +52,7 @@ static struct backing_dev_info ramfs_bac
 
 struct inode *ramfs_get_inode(struct super_block *sb, int mode, dev_t dev)
 {
-	struct inode * inode = new_inode(sb);
+	struct inode * inode = new_inode_autonum(sb);
 
 	if (inode) {
 		inode->i_mode = mode;
--- iunique/fs/sysfs/inode.c~iunique	2006-10-13 15:56:26.000000000 +0200
+++ iunique/fs/sysfs/inode.c	2006-11-07 18:19:51.000000000 +0100
@@ -122,7 +122,7 @@ static struct lock_class_key sysfs_inode
 
 struct inode * sysfs_new_inode(mode_t mode, struct sysfs_dirent * sd)
 {
-	struct inode * inode = new_inode(sysfs_sb);
+	struct inode * inode = new_inode_autonum(sysfs_sb);
 	if (inode) {
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
--- iunique/ipc/mqueue.c~iunique	2006-10-13 15:59:58.000000000 +0200
+++ iunique/ipc/mqueue.c	2006-11-07 18:20:13.000000000 +0100
@@ -110,7 +110,7 @@ static struct inode *mqueue_get_inode(st
 {
 	struct inode *inode;
 
-	inode = new_inode(sb);
+	inode = new_inode_autonum(sb);
 	if (inode) {
 		inode->i_mode = mode;
 		inode->i_uid = current->fsuid;
--- iunique/kernel/cpuset.c~iunique	2006-10-13 15:59:59.000000000 +0200
+++ iunique/kernel/cpuset.c	2006-11-07 18:20:22.000000000 +0100
@@ -283,7 +283,7 @@ static struct backing_dev_info cpuset_ba
 
 static struct inode *cpuset_new_inode(mode_t mode)
 {
-	struct inode *inode = new_inode(cpuset_sb);
+	struct inode *inode = new_inode_autonum(cpuset_sb);
 
 	if (inode) {
 		inode->i_mode = mode;
--- iunique/mm/shmem.c~iunique	2006-10-13 16:00:14.000000000 +0200
+++ iunique/mm/shmem.c	2006-11-07 18:20:32.000000000 +0100
@@ -1345,7 +1345,7 @@ shmem_get_inode(struct super_block *sb, 
 		spin_unlock(&sbinfo->stat_lock);
 	}
 
-	inode = new_inode(sb);
+	inode = new_inode_autonum(sb);
 	if (inode) {
 		inode->i_mode = mode;
 		inode->i_uid = current->fsuid;
--- iunique/net/socket.c~iunique	2006-10-13 16:00:48.000000000 +0200
+++ iunique/net/socket.c	2006-11-07 18:20:45.000000000 +0100
@@ -516,7 +516,7 @@ static struct socket *sock_alloc(void)
 	struct inode * inode;
 	struct socket * sock;
 
-	inode = new_inode(sock_mnt->mnt_sb);
+	inode = new_inode_autonum(sock_mnt->mnt_sb);
 	if (!inode)
 		return NULL;
 
--- iunique/security/inode.c~iunique	2006-10-13 16:01:00.000000000 +0200
+++ iunique/security/inode.c	2006-11-07 18:23:06.000000000 +0100
@@ -58,7 +58,7 @@ static struct file_operations default_fi
 
 static struct inode *get_inode(struct super_block *sb, int mode, dev_t dev)
 {
-	struct inode *inode = new_inode(sb);
+	struct inode *inode = new_inode_autonum(sb);
 
 	if (inode) {
 		inode->i_mode = mode;
--- iunique/security/selinux/selinuxfs.c~iunique	2006-10-13 16:01:01.000000000 +0200
+++ iunique/security/selinux/selinuxfs.c	2006-11-07 18:23:27.000000000 +0100
@@ -766,7 +766,7 @@ out:
 
 static struct inode *sel_make_inode(struct super_block *sb, int mode)
 {
-	struct inode *ret = new_inode(sb);
+	struct inode *ret = new_inode_autonum(sb);
 
 	if (ret) {
 		ret->i_mode = mode;
