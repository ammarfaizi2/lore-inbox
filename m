Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161139AbVKDKug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161139AbVKDKug (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 05:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbVKDKug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 05:50:36 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:29923 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161139AbVKDKuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 05:50:35 -0500
Date: Fri, 4 Nov 2005 11:50:26 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Andreas Herrmann <aherrman@de.ibm.com>
Subject: [PATCH resubmit] do_mount: reduce stack consumption
Message-ID: <20051104105026.GA12476@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Herrmann <aherrman@de.ibm.com>

This is a resubmit of Andreas' patch that reduces stackframe usage in
do_mount. Problem is that without this patch we get a kernel stack
overflow if we run with 4k stacks (s390 31 bit mode).
See original stack back trace below and Andreas' patch and analysis
here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0410.3/1844.html

    <4>Call Trace:
    <4>([<000000000014ade6>] buffered_rmqueue+0x36a/0x3b4)
    <4> [<000000000014aed6>] __alloc_pages+0xa6/0x350
    <4> [<000000000014b258>] __get_free_pages+0x38/0x74
    <4> [<000000000014f9fe>] kmem_getpages+0x32/0x140
    <4> [<0000000000150396>] cache_alloc_refill+0x3ae/0x58c
    <4> [<000000000014feb0>] __kmalloc+0xc0/0xe8
    <4> [<00000000002acc64>] zfcp_mempool_alloc+0x24/0x34
    <4> [<00000000001494ea>] mempool_alloc+0x56/0x1e8
    <4> [<00000000002bfb46>] zfcp_fsf_req_create+0x56/0x5d8
    <4> [<00000000002c0cf0>] zfcp_fsf_send_fcp_command_task+0x44/0x5c4
    <4> [<00000000002afbda>] zfcp_scsi_command_async+0x7a/0x1f8
    <4> [<00000000002afe68>] zfcp_scsi_queuecommand+0x44/0x54
    <4> [<000000000024f458>] scsi_dispatch_cmd+0x234/0x3c0
    <4> [<0000000000255fb2>] scsi_request_fn+0x2c6/0x67c
    <4> [<000000000023f3ea>] __generic_unplug_device+0x52/0x60
    <4> [<000000000023d392>] __elv_add_request+0x8a/0x98
    <4> [<0000000000240c5e>] __make_request+0x306/0x62c
    <4> [<0000000000241074>] generic_make_request+0xf0/0x21c
    <4> [<0000000010831380>] __map_bio+0x70/0x160 [dm_mod]
    <4> [<000000001083173e>] __split_bio+0x1e6/0x538 [dm_mod]
    <4> [<0000000010831ba8>] dm_request+0x118/0x25c [dm_mod]
    <4> [<0000000000241074>] generic_make_request+0xf0/0x21c
    <4> [<0000000010831380>] __map_bio+0x70/0x160 [dm_mod]
    <4> [<000000001083173e>] __split_bio+0x1e6/0x538 [dm_mod]
    <4> [<0000000010831ba8>] dm_request+0x118/0x25c [dm_mod]
    <4> [<0000000000241074>] generic_make_request+0xf0/0x21c
    <4> [<0000000010831380>] __map_bio+0x70/0x160 [dm_mod]
    <4> [<000000001083173e>] __split_bio+0x1e6/0x538 [dm_mod]
    <4> [<0000000010831ba8>] dm_request+0x118/0x25c [dm_mod]
    <4> [<0000000000241074>] generic_make_request+0xf0/0x21c
    <4> [<000000000024121a>] submit_bio+0x7a/0x154
    <4> [<00000000001736e6>] submit_bh+0x106/0x184
    <4> [<000000000017514e>] __block_write_full_page+0x23a/0x58c
    <4> [<000000000017558e>] block_write_full_page+0xee/0x108
    <4> [<000000000017a908>] blkdev_writepage+0x24/0x38
    <4> [<00000000001a0f76>] mpage_writepages+0x1da/0x9d0
    <4> [<000000000017a4fa>] generic_writepages+0x22/0x30
    <4> [<000000000014cc1e>] do_writepages+0x36/0x54
    <4> [<0000000000144fe2>] __filemap_fdatawrite+0x5a/0x6c
    <4> [<0000000000145016>] filemap_fdatawrite+0x22/0x30
    <4> [<0000000000171244>] sync_blockdev+0x30/0x5c
    <4> [<00000000001df074>] journal_recover+0x88/0xbc
    <4> [<00000000001e2876>] journal_load+0x52/0xcc
    <4> [<00000000001d37b4>] ext3_fill_super+0x1a48/0x1d38
    <4> [<0000000000179faa>] get_sb_bdev+0x13a/0x208
    <4> [<00000000001d3bd6>] ext3_get_sb+0x22/0x34
    <4> [<000000000017a32e>] do_kern_mount+0x86/0x1f4
    <4> [<000000000019aaf4>] do_mount+0x1c8/0x8e4
    <4> [<000000000019b7ba>] sys_mount+0xce/0x1dc
    <4> [<000000000010f9a6>] sysc_do_restart+0xe/0x12

Signed-off-by: Andreas Herrmann <aherrman@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 fs/namespace.c |   80 ++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 51 insertions(+), 29 deletions(-)

diff -urpN linux-2.6/fs/namespace.c linux-2.6-patched/fs/namespace.c
--- linux-2.6/fs/namespace.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/fs/namespace.c	2005-11-03 13:39:30.000000000 +0100
@@ -619,25 +619,31 @@ out_unlock:
  */
 static int do_loopback(struct nameidata *nd, char *old_name, int recurse)
 {
-	struct nameidata old_nd;
+	struct nameidata *old_nd;
 	struct vfsmount *mnt = NULL;
 	int err = mount_is_safe(nd);
 	if (err)
 		return err;
 	if (!old_name || !*old_name)
 		return -EINVAL;
-	err = path_lookup(old_name, LOOKUP_FOLLOW, &old_nd);
-	if (err)
+
+	old_nd = kmalloc(sizeof(*old_nd), GFP_KERNEL);
+	if (!old_nd)
+		return -ENOMEM;
+	err = path_lookup(old_name, LOOKUP_FOLLOW, old_nd);
+	if (err) {
+		kfree(old_nd);
 		return err;
+	}
 
 	down_write(&current->namespace->sem);
 	err = -EINVAL;
-	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {
+	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd->mnt))) {
 		err = -ENOMEM;
 		if (recurse)
-			mnt = copy_tree(old_nd.mnt, old_nd.dentry);
+			mnt = copy_tree(old_nd->mnt, old_nd->dentry);
 		else
-			mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
+			mnt = clone_mnt(old_nd->mnt, old_nd->dentry);
 	}
 
 	if (mnt) {
@@ -656,7 +662,8 @@ static int do_loopback(struct nameidata 
 	}
 
 	up_write(&current->namespace->sem);
-	path_release(&old_nd);
+	path_release(old_nd);
+	kfree(old_nd);
 	return err;
 }
 
@@ -693,22 +700,29 @@ static int do_remount(struct nameidata *
 
 static int do_move_mount(struct nameidata *nd, char *old_name)
 {
-	struct nameidata old_nd, parent_nd;
+	struct {
+		struct nameidata old_nd, parent_nd;
+	} *loc;
 	struct vfsmount *p;
 	int err = 0;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	if (!old_name || !*old_name)
 		return -EINVAL;
-	err = path_lookup(old_name, LOOKUP_FOLLOW, &old_nd);
-	if (err)
+	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
+	if (!loc)
+		return -ENOMEM;
+	err = path_lookup(old_name, LOOKUP_FOLLOW, &loc->old_nd);
+	if (err) {
+		kfree (loc);
 		return err;
+	}
 
 	down_write(&current->namespace->sem);
 	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
 		;
 	err = -EINVAL;
-	if (!check_mnt(nd->mnt) || !check_mnt(old_nd.mnt))
+	if (!check_mnt(nd->mnt) || !check_mnt(loc->old_nd.mnt))
 		goto out;
 
 	err = -ENOENT;
@@ -721,28 +735,28 @@ static int do_move_mount(struct nameidat
 		goto out2;
 
 	err = -EINVAL;
-	if (old_nd.dentry != old_nd.mnt->mnt_root)
+	if (loc->old_nd.dentry != loc->old_nd.mnt->mnt_root)
 		goto out2;
 
-	if (old_nd.mnt == old_nd.mnt->mnt_parent)
+	if (loc->old_nd.mnt == loc->old_nd.mnt->mnt_parent)
 		goto out2;
 
 	if (S_ISDIR(nd->dentry->d_inode->i_mode) !=
-	      S_ISDIR(old_nd.dentry->d_inode->i_mode))
+	      S_ISDIR(loc->old_nd.dentry->d_inode->i_mode))
 		goto out2;
 
 	err = -ELOOP;
 	for (p = nd->mnt; p->mnt_parent!=p; p = p->mnt_parent)
-		if (p == old_nd.mnt)
+		if (p == loc->old_nd.mnt)
 			goto out2;
 	err = 0;
 
-	detach_mnt(old_nd.mnt, &parent_nd);
-	attach_mnt(old_nd.mnt, nd);
+	detach_mnt(loc->old_nd.mnt, &loc->parent_nd);
+	attach_mnt(loc->old_nd.mnt, nd);
 
 	/* if the mount is moved, it should no longer be expire
 	 * automatically */
-	list_del_init(&old_nd.mnt->mnt_expire);
+	list_del_init(&loc->old_nd.mnt->mnt_expire);
 out2:
 	spin_unlock(&vfsmount_lock);
 out1:
@@ -750,8 +764,9 @@ out1:
 out:
 	up_write(&current->namespace->sem);
 	if (!err)
-		path_release(&parent_nd);
-	path_release(&old_nd);
+		path_release(&loc->parent_nd);
+	path_release(&loc->old_nd);
+	kfree(loc);
 	return err;
 }
 
@@ -1014,7 +1029,7 @@ int copy_mount_options(const void __user
 long do_mount(char * dev_name, char * dir_name, char *type_page,
 		  unsigned long flags, void *data_page)
 {
-	struct nameidata nd;
+	struct nameidata *nd;
 	int retval = 0;
 	int mnt_flags = 0;
 
@@ -1041,27 +1056,34 @@ long do_mount(char * dev_name, char * di
 		mnt_flags |= MNT_NOEXEC;
 	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV|MS_ACTIVE);
 
+	nd = kmalloc(sizeof(*nd), GFP_KERNEL);
+	if (!nd)
+		return -ENOMEM;
+
 	/* ... and get the mountpoint */
-	retval = path_lookup(dir_name, LOOKUP_FOLLOW, &nd);
-	if (retval)
+	retval = path_lookup(dir_name, LOOKUP_FOLLOW, nd);
+	if (retval) {
+		kfree(nd);
 		return retval;
+	}
 
-	retval = security_sb_mount(dev_name, &nd, type_page, flags, data_page);
+	retval = security_sb_mount(dev_name, nd, type_page, flags, data_page);
 	if (retval)
 		goto dput_out;
 
 	if (flags & MS_REMOUNT)
-		retval = do_remount(&nd, flags & ~MS_REMOUNT, mnt_flags,
+		retval = do_remount(nd, flags & ~MS_REMOUNT, mnt_flags,
 				    data_page);
 	else if (flags & MS_BIND)
-		retval = do_loopback(&nd, dev_name, flags & MS_REC);
+		retval = do_loopback(nd, dev_name, flags & MS_REC);
 	else if (flags & MS_MOVE)
-		retval = do_move_mount(&nd, dev_name);
+		retval = do_move_mount(nd, dev_name);
 	else
-		retval = do_new_mount(&nd, type_page, flags, mnt_flags,
+		retval = do_new_mount(nd, type_page, flags, mnt_flags,
 				      dev_name, data_page);
 dput_out:
-	path_release(&nd);
+	path_release(nd);
+	kfree(nd);
 	return retval;
 }
 
