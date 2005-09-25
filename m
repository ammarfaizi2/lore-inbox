Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbVIYGnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbVIYGnr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 02:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbVIYGnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 02:43:40 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:32093 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751195AbVIYGnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 02:43:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=N4vDGwGGHuLOClm+CyTqi3frGOGFwDgBqYFa3VdsUORZ4spmfga4/BI8M/E7o8DYWOixcEdnxbxx4BZnJwiy5RwhJGFowZbP50EUjSiOFzhPODs/EUKzso5hMCgQH6xFutUUaBAk3OYoFBn96OwvqvzB4JD3DED0fVsSGCJa6Rk=
From: Tejun Heo <htejun@gmail.com>
To: zwane@linuxpower.ca, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050925064218.E7558977@htj.dyndns.org>
In-Reply-To: <20050925064218.E7558977@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6 02/04] brsem: convert super_block->s_umount to brsem
Message-ID: <20050925064218.3AE7BE10@htj.dyndns.org>
Date: Sun, 25 Sep 2005 15:43:17 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_brsem_convert-s_umount-to-brsem.patch

	Convert super_block->s_umount from rwsem to brsem.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 arch/um/drivers/mconsole_kern.c |    2 -
 fs/9p/vfs_super.c               |    2 -
 fs/afs/super.c                  |    2 -
 fs/cifs/cifsfs.c                |    2 -
 fs/fs-writeback.c               |    8 ++---
 fs/jffs2/super.c                |    2 -
 fs/libfs.c                      |    2 -
 fs/namespace.c                  |    8 ++---
 fs/nfs/inode.c                  |    4 +-
 fs/quota.c                      |    4 +-
 fs/reiserfs/procfs.c            |    2 -
 fs/super.c                      |   60 +++++++++++++++++++++-------------------
 include/linux/fs.h              |    3 +-
 security/selinux/hooks.c        |    2 -
 14 files changed, 54 insertions(+), 49 deletions(-)

Index: linux-work/fs/9p/vfs_super.c
===================================================================
--- linux-work.orig/fs/9p/vfs_super.c	2005-09-25 15:26:32.000000000 +0900
+++ linux-work/fs/9p/vfs_super.c	2005-09-25 15:42:04.000000000 +0900
@@ -189,7 +189,7 @@ static struct super_block *v9fs_get_sb(s
 
 put_back_sb:
 	/* deactivate_super calls v9fs_kill_super which will frees the rest */
-	up_write(&sb->s_umount);
+	brsem_up_write(sb->s_umount);
 	deactivate_super(sb);
 	return ERR_PTR(retval);
 }
Index: linux-work/fs/afs/super.c
===================================================================
--- linux-work.orig/fs/afs/super.c	2005-09-25 15:26:32.000000000 +0900
+++ linux-work/fs/afs/super.c	2005-09-25 15:42:04.000000000 +0900
@@ -343,7 +343,7 @@ static struct super_block *afs_get_sb(st
 
 	ret = afs_fill_super(sb, &params, flags & MS_VERBOSE ? 1 : 0);
 	if (ret < 0) {
-		up_write(&sb->s_umount);
+		brsem_up_write(sb->s_umount);
 		deactivate_super(sb);
 		goto error;
 	}
Index: linux-work/fs/cifs/cifsfs.c
===================================================================
--- linux-work.orig/fs/cifs/cifsfs.c	2005-09-25 15:26:32.000000000 +0900
+++ linux-work/fs/cifs/cifsfs.c	2005-09-25 15:42:04.000000000 +0900
@@ -435,7 +435,7 @@ cifs_get_sb(struct file_system_type *fs_
 
 	rc = cifs_read_super(sb, data, dev_name, flags & MS_VERBOSE ? 1 : 0);
 	if (rc) {
-		up_write(&sb->s_umount);
+		brsem_up_write(sb->s_umount);
 		deactivate_super(sb);
 		return ERR_PTR(rc);
 	}
Index: linux-work/fs/fs-writeback.c
===================================================================
--- linux-work.orig/fs/fs-writeback.c	2005-09-25 15:26:32.000000000 +0900
+++ linux-work/fs/fs-writeback.c	2005-09-25 15:42:04.000000000 +0900
@@ -425,13 +425,13 @@ restart:
 			 * waiting around, most of the time the FS is going to
 			 * be unmounted by the time it is released.
 			 */
-			if (down_read_trylock(&sb->s_umount)) {
+			if (brsem_down_read_trylock(sb->s_umount)) {
 				if (sb->s_root) {
 					spin_lock(&inode_lock);
 					sync_sb_inodes(sb, wbc);
 					spin_unlock(&inode_lock);
 				}
-				up_read(&sb->s_umount);
+				brsem_up_read(sb->s_umount);
 			}
 			spin_lock(&sb_lock);
 			if (__put_super_and_need_restart(sb))
@@ -516,12 +516,12 @@ restart:
 		sb->s_syncing = 1;
 		sb->s_count++;
 		spin_unlock(&sb_lock);
-		down_read(&sb->s_umount);
+		brsem_down_read(sb->s_umount);
 		if (sb->s_root) {
 			sync_inodes_sb(sb, wait);
 			sync_blockdev(sb->s_bdev);
 		}
-		up_read(&sb->s_umount);
+		brsem_up_read(sb->s_umount);
 		spin_lock(&sb_lock);
 		if (__put_super_and_need_restart(sb))
 			goto restart;
Index: linux-work/fs/jffs2/super.c
===================================================================
--- linux-work.orig/fs/jffs2/super.c	2005-09-25 15:26:32.000000000 +0900
+++ linux-work/fs/jffs2/super.c	2005-09-25 15:42:04.000000000 +0900
@@ -156,7 +156,7 @@ static struct super_block *jffs2_get_sb_
 
 	if (ret) {
 		/* Failure case... */
-		up_write(&sb->s_umount);
+		brsem_up_write(sb->s_umount);
 		deactivate_super(sb);
 		return ERR_PTR(ret);
 	}
Index: linux-work/fs/libfs.c
===================================================================
--- linux-work.orig/fs/libfs.c	2005-09-25 15:26:32.000000000 +0900
+++ linux-work/fs/libfs.c	2005-09-25 15:42:04.000000000 +0900
@@ -233,7 +233,7 @@ get_sb_pseudo(struct file_system_type *f
 	return s;
 
 Enomem:
-	up_write(&s->s_umount);
+	brsem_up_write(s->s_umount);
 	deactivate_super(s);
 	return ERR_PTR(-ENOMEM);
 }
Index: linux-work/fs/namespace.c
===================================================================
--- linux-work.orig/fs/namespace.c	2005-09-25 15:26:32.000000000 +0900
+++ linux-work/fs/namespace.c	2005-09-25 15:42:04.000000000 +0900
@@ -421,14 +421,14 @@ static int do_umount(struct vfsmount *mn
 		 * Special case for "unmounting" root ...
 		 * we just try to remount it readonly.
 		 */
-		down_write(&sb->s_umount);
+		brsem_down_write(sb->s_umount);
 		if (!(sb->s_flags & MS_RDONLY)) {
 			lock_kernel();
 			DQUOT_OFF(sb);
 			retval = do_remount_sb(sb, MS_RDONLY, NULL, 0);
 			unlock_kernel();
 		}
-		up_write(&sb->s_umount);
+		brsem_up_write(sb->s_umount);
 		return retval;
 	}
 
@@ -681,11 +681,11 @@ static int do_remount(struct nameidata *
 	if (nd->dentry != nd->mnt->mnt_root)
 		return -EINVAL;
 
-	down_write(&sb->s_umount);
+	brsem_down_write(sb->s_umount);
 	err = do_remount_sb(sb, flags, data, 0);
 	if (!err)
 		nd->mnt->mnt_flags=mnt_flags;
-	up_write(&sb->s_umount);
+	brsem_up_write(sb->s_umount);
 	if (!err)
 		security_sb_post_remount(nd->mnt, flags, data);
 	return err;
Index: linux-work/fs/nfs/inode.c
===================================================================
--- linux-work.orig/fs/nfs/inode.c	2005-09-25 15:26:32.000000000 +0900
+++ linux-work/fs/nfs/inode.c	2005-09-25 15:42:04.000000000 +0900
@@ -1574,7 +1574,7 @@ static struct super_block *nfs_get_sb(st
 
 	error = nfs_fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
 	if (error) {
-		up_write(&s->s_umount);
+		brsem_up_write(s->s_umount);
 		deactivate_super(s);
 		return ERR_PTR(error);
 	}
@@ -1931,7 +1931,7 @@ static struct super_block *nfs4_get_sb(s
 
 	error = nfs4_fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
 	if (error) {
-		up_write(&s->s_umount);
+		brsem_up_write(s->s_umount);
 		deactivate_super(s);
 		return ERR_PTR(error);
 	}
Index: linux-work/fs/quota.c
===================================================================
--- linux-work.orig/fs/quota.c	2005-09-25 15:26:32.000000000 +0900
+++ linux-work/fs/quota.c	2005-09-25 15:42:04.000000000 +0900
@@ -209,10 +209,10 @@ restart:
 			continue;
 		sb->s_count++;
 		spin_unlock(&sb_lock);
-		down_read(&sb->s_umount);
+		brsem_down_read(sb->s_umount);
 		if (sb->s_root && sb->s_qcop->quota_sync)
 			quota_sync_sb(sb, type);
-		up_read(&sb->s_umount);
+		brsem_up_read(sb->s_umount);
 		spin_lock(&sb_lock);
 		if (__put_super_and_need_restart(sb))
 			goto restart;
Index: linux-work/fs/reiserfs/procfs.c
===================================================================
--- linux-work.orig/fs/reiserfs/procfs.c	2005-09-25 15:26:32.000000000 +0900
+++ linux-work/fs/reiserfs/procfs.c	2005-09-25 15:42:04.000000000 +0900
@@ -422,7 +422,7 @@ static void *r_start(struct seq_file *m,
 	if (IS_ERR(sget(&reiserfs_fs_type, test_sb, set_sb, s)))
 		return NULL;
 
-	up_write(&s->s_umount);
+	brsem_up_write(s->s_umount);
 
 	if (de->deleted) {
 		deactivate_super(s);
Index: linux-work/fs/super.c
===================================================================
--- linux-work.orig/fs/super.c	2005-09-25 15:26:32.000000000 +0900
+++ linux-work/fs/super.c	2005-09-25 15:42:04.000000000 +0900
@@ -60,20 +60,18 @@ static struct super_block *alloc_super(v
 
 	if (s) {
 		memset(s, 0, sizeof(struct super_block));
-		if (security_sb_alloc(s)) {
-			kfree(s);
-			s = NULL;
-			goto out;
-		}
+		if (security_sb_alloc(s))
+			goto fail_sec;
 		INIT_LIST_HEAD(&s->s_dirty);
 		INIT_LIST_HEAD(&s->s_io);
 		INIT_LIST_HEAD(&s->s_files);
 		INIT_LIST_HEAD(&s->s_instances);
 		INIT_HLIST_HEAD(&s->s_anon);
 		INIT_LIST_HEAD(&s->s_inodes);
-		init_rwsem(&s->s_umount);
+		if (!(s->s_umount = create_brsem()))
+			goto fail_umount;
 		sema_init(&s->s_lock, 1);
-		down_write(&s->s_umount);
+		brsem_down_write(s->s_umount);
 		s->s_count = S_BIAS;
 		atomic_set(&s->s_active, 1);
 		sema_init(&s->s_vfs_rename_sem,1);
@@ -87,8 +85,13 @@ static struct super_block *alloc_super(v
 		s->s_op = &default_op;
 		s->s_time_gran = 1000000000;
 	}
-out:
 	return s;
+
+fail_umount:
+	security_sb_free(s);
+fail_sec:
+	kfree(s);
+	return NULL;
 }
 
 /**
@@ -100,6 +103,7 @@ out:
 static inline void destroy_super(struct super_block *s)
 {
 	security_sb_free(s);
+	destroy_brsem(s->s_umount);
 	kfree(s);
 }
 
@@ -171,7 +175,7 @@ void deactivate_super(struct super_block
 	if (atomic_dec_and_lock(&s->s_active, &sb_lock)) {
 		s->s_count -= S_BIAS-1;
 		spin_unlock(&sb_lock);
-		down_write(&s->s_umount);
+		brsem_down_write(s->s_umount);
 		fs->kill_sb(s);
 		put_filesystem(fs);
 		put_super(s);
@@ -195,7 +199,7 @@ static int grab_super(struct super_block
 {
 	s->s_count++;
 	spin_unlock(&sb_lock);
-	down_write(&s->s_umount);
+	brsem_down_write(s->s_umount);
 	if (s->s_root) {
 		spin_lock(&sb_lock);
 		if (s->s_count > S_BIAS) {
@@ -206,7 +210,7 @@ static int grab_super(struct super_block
 		}
 		spin_unlock(&sb_lock);
 	}
-	up_write(&s->s_umount);
+	brsem_up_write(s->s_umount);
 	put_super(s);
 	yield();
 	return 0;
@@ -258,7 +262,7 @@ void generic_shutdown_super(struct super
 	list_del_init(&sb->s_list);
 	list_del(&sb->s_instances);
 	spin_unlock(&sb_lock);
-	up_write(&sb->s_umount);
+	brsem_up_write(sb->s_umount);
 }
 
 EXPORT_SYMBOL(generic_shutdown_super);
@@ -319,7 +323,7 @@ EXPORT_SYMBOL(sget);
 
 void drop_super(struct super_block *sb)
 {
-	up_read(&sb->s_umount);
+	brsem_up_read(sb->s_umount);
 	put_super(sb);
 }
 
@@ -349,9 +353,9 @@ restart:
 		if (sb->s_dirt) {
 			sb->s_count++;
 			spin_unlock(&sb_lock);
-			down_read(&sb->s_umount);
+			brsem_down_read(sb->s_umount);
 			write_super(sb);
-			up_read(&sb->s_umount);
+			brsem_up_read(sb->s_umount);
 			spin_lock(&sb_lock);
 			if (__put_super_and_need_restart(sb))
 				goto restart;
@@ -400,10 +404,10 @@ restart:
 			continue;	/* hm.  Was remounted r/o meanwhile */
 		sb->s_count++;
 		spin_unlock(&sb_lock);
-		down_read(&sb->s_umount);
+		brsem_down_read(sb->s_umount);
 		if (sb->s_root && (wait || sb->s_dirt))
 			sb->s_op->sync_fs(sb, wait);
-		up_read(&sb->s_umount);
+		brsem_up_read(sb->s_umount);
 		/* restart only when sb is no longer on the list */
 		spin_lock(&sb_lock);
 		if (__put_super_and_need_restart(sb))
@@ -434,10 +438,10 @@ rescan:
 		if (sb->s_bdev == bdev) {
 			sb->s_count++;
 			spin_unlock(&sb_lock);
-			down_read(&sb->s_umount);
+			brsem_down_read(sb->s_umount);
 			if (sb->s_root)
 				return sb;
-			up_read(&sb->s_umount);
+			brsem_up_read(sb->s_umount);
 			/* restart only when sb is no longer on the list */
 			spin_lock(&sb_lock);
 			if (__put_super_and_need_restart(sb))
@@ -460,10 +464,10 @@ rescan:
 		if (sb->s_dev ==  dev) {
 			sb->s_count++;
 			spin_unlock(&sb_lock);
-			down_read(&sb->s_umount);
+			brsem_down_read(sb->s_umount);
 			if (sb->s_root)
 				return sb;
-			up_read(&sb->s_umount);
+			brsem_up_read(sb->s_umount);
 			/* restart only when sb is no longer on the list */
 			spin_lock(&sb_lock);
 			if (__put_super_and_need_restart(sb))
@@ -568,7 +572,7 @@ static void do_emergency_remount(unsigne
 	list_for_each_entry(sb, &super_blocks, s_list) {
 		sb->s_count++;
 		spin_unlock(&sb_lock);
-		down_read(&sb->s_umount);
+		brsem_down_read(sb->s_umount);
 		if (sb->s_root && sb->s_bdev && !(sb->s_flags & MS_RDONLY)) {
 			/*
 			 * ->remount_fs needs lock_kernel().
@@ -701,7 +705,7 @@ struct super_block *get_sb_bdev(struct f
 
 	if (s->s_root) {
 		if ((flags ^ s->s_flags) & MS_RDONLY) {
-			up_write(&s->s_umount);
+			brsem_up_write(s->s_umount);
 			deactivate_super(s);
 			s = ERR_PTR(-EBUSY);
 		}
@@ -715,7 +719,7 @@ struct super_block *get_sb_bdev(struct f
 		sb_set_blocksize(s, s->s_old_blocksize);
 		error = fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
 		if (error) {
-			up_write(&s->s_umount);
+			brsem_up_write(s->s_umount);
 			deactivate_super(s);
 			s = ERR_PTR(error);
 		} else {
@@ -759,7 +763,7 @@ struct super_block *get_sb_nodev(struct 
 
 	error = fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
 	if (error) {
-		up_write(&s->s_umount);
+		brsem_up_write(s->s_umount);
 		deactivate_super(s);
 		return ERR_PTR(error);
 	}
@@ -788,7 +792,7 @@ struct super_block *get_sb_single(struct
 		s->s_flags = flags;
 		error = fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
 		if (error) {
-			up_write(&s->s_umount);
+			brsem_up_write(s->s_umount);
 			deactivate_super(s);
 			return ERR_PTR(error);
 		}
@@ -840,12 +844,12 @@ do_kern_mount(const char *fstype, int fl
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = sb->s_root;
 	mnt->mnt_parent = mnt;
-	up_write(&sb->s_umount);
+	brsem_up_write(sb->s_umount);
 	free_secdata(secdata);
 	put_filesystem(type);
 	return mnt;
 out_sb:
-	up_write(&sb->s_umount);
+	brsem_up_write(sb->s_umount);
 	deactivate_super(sb);
 	sb = ERR_PTR(error);
 out_free_secdata:
Index: linux-work/security/selinux/hooks.c
===================================================================
--- linux-work.orig/security/selinux/hooks.c	2005-09-25 15:26:32.000000000 +0900
+++ linux-work/security/selinux/hooks.c	2005-09-25 15:42:04.000000000 +0900
@@ -4407,7 +4407,7 @@ next_sb:
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 		spin_unlock(&sb_security_lock);
-		down_read(&sb->s_umount);
+		brsem_down_read(sb->s_umount);
 		if (sb->s_root)
 			superblock_doinit(sb, NULL);
 		drop_super(sb);
Index: linux-work/include/linux/fs.h
===================================================================
--- linux-work.orig/include/linux/fs.h	2005-09-25 15:26:32.000000000 +0900
+++ linux-work/include/linux/fs.h	2005-09-25 15:42:04.000000000 +0900
@@ -216,6 +216,7 @@ extern int dir_notify_enable;
 #include <linux/prio_tree.h>
 #include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/brsem.h>
 
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
@@ -771,7 +772,7 @@ struct super_block {
 	unsigned long		s_flags;
 	unsigned long		s_magic;
 	struct dentry		*s_root;
-	struct rw_semaphore	s_umount;
+	struct brsem		*s_umount;
 	struct semaphore	s_lock;
 	int			s_count;
 	int			s_syncing;
Index: linux-work/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-work.orig/arch/um/drivers/mconsole_kern.c	2005-09-25 15:26:32.000000000 +0900
+++ linux-work/arch/um/drivers/mconsole_kern.c	2005-09-25 15:42:04.000000000 +0900
@@ -150,7 +150,7 @@ void mconsole_proc(struct mc_request *re
 		mconsole_reply(req, "Failed to get procfs superblock", 1, 0);
 		goto out;
 	}
-	up_write(&super->s_umount);
+	brsem_up_write(super->s_umount);
 
 	nd.dentry = super->s_root;
 	nd.mnt = NULL;

