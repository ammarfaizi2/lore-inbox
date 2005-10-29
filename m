Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbVJ2I6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbVJ2I6m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 04:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVJ2I6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 04:58:42 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:3602 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S1750855AbVJ2I6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 04:58:41 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Don't use pdflush for filesystems has BDI_CAP_NO_WRITEBACK
References: <43288A84.2090107@sm.sony.co.jp>
	<87oe6uwjy7.fsf@devron.myhome.or.jp> <433C25D9.9090602@sm.sony.co.jp>
	<20051011142608.6ff3ca58.akpm@osdl.org>
	<87r7armlgz.fsf@ibmpc.myhome.or.jp>
	<20051011211601.72a0f91c.akpm@osdl.org>
	<87vezgd89q.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 29 Oct 2005 17:58:32 +0900
In-Reply-To: <87vezgd89q.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's message of "Sat, 29 Oct 2005 17:42:09 +0900")
Message-ID: <87r7a4d7if.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If inodes of filesystem has BDI_CAP_NO_WRITEBACK, it shouldn't be
needed to flush the inodes by pdflush at all.  So, this patch stops
puting the inode on the sb->s_dirty, by setting I_DIRTY as initial
state.

With this patch, I think unnecessary flush is stopped.

BTW, probably all most of on memory filesystems also doesn't need to
flush by pdflush...?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/hugetlbfs/inode.c |    1 +
 fs/pipe.c            |    8 +-------
 fs/ramfs/inode.c     |    1 +
 fs/relayfs/inode.c   |    1 +
 fs/sysfs/inode.c     |    1 +
 include/linux/fs.h   |   10 ++++++++++
 kernel/cpuset.c      |    1 +
 mm/shmem.c           |    1 +
 8 files changed, 17 insertions(+), 7 deletions(-)

diff -puN fs/hugetlbfs/inode.c~add-set_inode_noflush fs/hugetlbfs/inode.c
--- linux-2.6.14/fs/hugetlbfs/inode.c~add-set_inode_noflush	2005-10-29 08:13:57.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/hugetlbfs/inode.c	2005-10-29 08:13:57.000000000 +0900
@@ -394,6 +394,7 @@ static struct inode *hugetlbfs_get_inode
 	inode = new_inode(sb);
 	if (inode) {
 		struct hugetlbfs_inode_info *info;
+		set_inode_noflush(inode);
 		inode->i_mode = mode;
 		inode->i_uid = uid;
 		inode->i_gid = gid;
diff -puN fs/pipe.c~add-set_inode_noflush fs/pipe.c
--- linux-2.6.14/fs/pipe.c~add-set_inode_noflush	2005-10-29 08:13:57.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/pipe.c	2005-10-29 08:13:57.000000000 +0900
@@ -697,13 +697,7 @@ static struct inode * get_pipe_inode(voi
 	PIPE_READERS(*inode) = PIPE_WRITERS(*inode) = 1;
 	inode->i_fop = &rdwr_pipe_fops;
 
-	/*
-	 * Mark the inode dirty from the very beginning,
-	 * that way it will never be moved to the dirty
-	 * list because "mark_inode_dirty()" will think
-	 * that it already _is_ on the dirty list.
-	 */
-	inode->i_state = I_DIRTY;
+	set_inode_noflush(inode);
 	inode->i_mode = S_IFIFO | S_IRUSR | S_IWUSR;
 	inode->i_uid = current->fsuid;
 	inode->i_gid = current->fsgid;
diff -puN fs/ramfs/inode.c~add-set_inode_noflush fs/ramfs/inode.c
--- linux-2.6.14/fs/ramfs/inode.c~add-set_inode_noflush	2005-10-29 08:13:57.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/ramfs/inode.c	2005-10-29 08:13:57.000000000 +0900
@@ -55,6 +55,7 @@ struct inode *ramfs_get_inode(struct sup
 	struct inode * inode = new_inode(sb);
 
 	if (inode) {
+		set_inode_noflush(inode);
 		inode->i_mode = mode;
 		inode->i_uid = current->fsuid;
 		inode->i_gid = current->fsgid;
diff -puN fs/relayfs/inode.c~add-set_inode_noflush fs/relayfs/inode.c
--- linux-2.6.14/fs/relayfs/inode.c~add-set_inode_noflush	2005-10-29 08:13:57.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/relayfs/inode.c	2005-10-29 08:13:57.000000000 +0900
@@ -52,6 +52,7 @@ static struct inode *relayfs_get_inode(s
 		return NULL;
 	}
 
+	set_inode_noflush(inode);
 	inode->i_mode = mode;
 	inode->i_uid = 0;
 	inode->i_gid = 0;
diff -puN fs/sysfs/inode.c~add-set_inode_noflush fs/sysfs/inode.c
--- linux-2.6.14/fs/sysfs/inode.c~add-set_inode_noflush	2005-10-29 08:13:57.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/sysfs/inode.c	2005-10-29 08:13:57.000000000 +0900
@@ -113,6 +113,7 @@ struct inode * sysfs_new_inode(mode_t mo
 {
 	struct inode * inode = new_inode(sysfs_sb);
 	if (inode) {
+		set_inode_noflush(inode);
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_mapping->a_ops = &sysfs_aops;
diff -puN include/linux/fs.h~add-set_inode_noflush include/linux/fs.h
--- linux-2.6.14/include/linux/fs.h~add-set_inode_noflush	2005-10-29 08:13:57.000000000 +0900
+++ linux-2.6.14-hirofumi/include/linux/fs.h	2005-10-29 08:13:57.000000000 +0900
@@ -1075,6 +1075,16 @@ static inline void file_accessed(struct 
 		touch_atime(file->f_vfsmnt, file->f_dentry);
 }
 
+static inline void set_inode_noflush(struct inode *inode)
+{
+	/*
+	 * Mark the inode dirty from the very beginning, that way it
+	 * will never be moved to the dirty list because "mark_inode_dirty()"
+	 * will think that it already _is_ on the dirty list.
+	 */
+	inode->i_state |= I_DIRTY;
+}
+
 int sync_inode(struct inode *inode, struct writeback_control *wbc);
 
 /**
diff -puN kernel/cpuset.c~add-set_inode_noflush kernel/cpuset.c
--- linux-2.6.14/kernel/cpuset.c~add-set_inode_noflush	2005-10-29 08:13:57.000000000 +0900
+++ linux-2.6.14-hirofumi/kernel/cpuset.c	2005-10-29 08:13:57.000000000 +0900
@@ -236,6 +236,7 @@ static struct inode *cpuset_new_inode(mo
 	struct inode *inode = new_inode(cpuset_sb);
 
 	if (inode) {
+		set_inode_noflush(inode);
 		inode->i_mode = mode;
 		inode->i_uid = current->fsuid;
 		inode->i_gid = current->fsgid;
diff -puN mm/shmem.c~add-set_inode_noflush mm/shmem.c
--- linux-2.6.14/mm/shmem.c~add-set_inode_noflush	2005-10-29 08:13:57.000000000 +0900
+++ linux-2.6.14-hirofumi/mm/shmem.c	2005-10-29 08:13:57.000000000 +0900
@@ -1283,6 +1283,7 @@ shmem_get_inode(struct super_block *sb, 
 
 	inode = new_inode(sb);
 	if (inode) {
+		set_inode_noflush(inode);
 		inode->i_mode = mode;
 		inode->i_uid = current->fsuid;
 		inode->i_gid = current->fsgid;
_
