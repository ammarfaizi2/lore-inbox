Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263416AbRFKFd7>; Mon, 11 Jun 2001 01:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263421AbRFKFdt>; Mon, 11 Jun 2001 01:33:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:57005 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263416AbRFKFdo>;
	Mon, 11 Jun 2001 01:33:44 -0400
Date: Mon, 11 Jun 2001 01:33:43 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/super.c stuff (2/10)
In-Reply-To: <Pine.GSO.4.21.0106110132340.24249-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0106110133160.24249-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN S6-pre2-mnt_instances/fs/super.c S6-pre2-s_active/fs/super.c
--- S6-pre2-mnt_instances/fs/super.c	Sat Jun  9 19:18:31 2001
+++ S6-pre2-s_active/fs/super.c	Sun Jun 10 12:07:40 2001
@@ -388,7 +388,6 @@
 	spin_lock(&dcache_lock);
 	list_add(&mnt->mnt_list, vfsmntlist.prev);
 	spin_unlock(&dcache_lock);
-	atomic_inc(&sb->s_active);
 	if (sb->s_type->fs_flags & FS_SINGLE)
 		get_filesystem(sb->s_type);
 out:
@@ -740,6 +739,7 @@
 	     s  = sb_entry(s->s_list.next)) {
 		if (s->s_dev)
 			continue;
+		atomic_inc(&s->s_active);
 		return s;
 	}
 	/* Need a new one... */
@@ -755,7 +755,7 @@
 		INIT_LIST_HEAD(&s->s_files);
 		init_rwsem(&s->s_umount);
 		sema_init(&s->s_lock, 1);
-		atomic_set(&s->s_active, 0);
+		atomic_set(&s->s_active, 1);
 		sema_init(&s->s_vfs_rename_sem,1);
 		sema_init(&s->s_nfsd_free_path_sem,1);
 		sema_init(&s->s_dquot.dqio_sem, 1);
@@ -794,6 +794,7 @@
 	s->s_bdev = 0;
 	s->s_type = NULL;
 	unlock_super(s);
+	atomic_dec(&s->s_active);
 	return NULL;
 }
 
@@ -860,6 +861,7 @@
 		if (fs_type == sb->s_type &&
 		    ((flags ^ sb->s_flags) & MS_RDONLY) == 0) {
 			path_release(&nd);
+			atomic_inc(&sb->s_active);
 			return sb;
 		}
 	} else {
@@ -923,6 +925,7 @@
 	if (!sb)
 		BUG();
 	do_remount_sb(sb, flags, data);
+	atomic_inc(&sb->s_active);
 	return sb;
 }
 
@@ -1038,7 +1041,6 @@
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = mnt->mnt_root;
 	mnt->mnt_parent = mnt;
-	atomic_inc(&sb->s_active);
 	type->kern_mnt = mnt;
 	return mnt;
 }
@@ -1315,7 +1317,6 @@
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = mnt->mnt_root;
 	mnt->mnt_parent = mnt;
-	atomic_inc(&sb->s_active);
 
 	/* Something was mounted here while we slept */
 	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
@@ -1573,6 +1574,7 @@
 	sb = get_super(ROOT_DEV);
 	if (sb) {
 		fs_type = sb->s_type;
+		atomic_inc(&sb->s_active);
 		goto mount_it;
 	}
 


