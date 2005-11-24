Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVKXQe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVKXQe1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 11:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVKXQe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 11:34:27 -0500
Received: from adsl-80.mirage.euroweb.hu ([193.226.228.80]:32784 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932255AbVKXQe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 11:34:26 -0500
To: akpm@osdl.org
CC: linuxram@us.ibm.com, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <E1EfJnm-00017H-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Thu, 24 Nov 2005 17:18:26 +0100)
Subject: Re: [PATCH 2/2] shared mounts: save mount flag space
References: <E1EfJfC-00016e-00@dorka.pomaz.szeredi.hu> <E1EfJnm-00017H-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1EfK2o-0001AK-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 24 Nov 2005 17:33:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duh, last patch was missing a check against NULL.  Here's the fixed
one.  I promise to review patches _before_ sending, next time.


Remaining mount flags are becoming scarce (just 11 bits)
and shared mount code uses 4 though one would suffice.

I think this should go into 2.6.15, fixing it later would be breaking
userspace ABI.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/pnode.c
===================================================================
--- linux.orig/fs/pnode.c	2005-11-24 16:47:13.000000000 +0100
+++ linux/fs/pnode.c	2005-11-24 16:48:14.000000000 +0100
@@ -72,17 +72,17 @@ static int do_make_slave(struct vfsmount
 	return 0;
 }
 
-void change_mnt_propagation(struct vfsmount *mnt, int type)
+void change_mnt_propagation(struct vfsmount *mnt, enum propagation_type type)
 {
-	if (type == MS_SHARED) {
+	if (type == PT_SHARED) {
 		set_mnt_shared(mnt);
 		return;
 	}
 	do_make_slave(mnt);
-	if (type != MS_SLAVE) {
+	if (type != PT_SLAVE) {
 		list_del_init(&mnt->mnt_slave);
 		mnt->mnt_master = NULL;
-		if (type == MS_UNBINDABLE)
+		if (type == PT_UNBINDABLE)
 			mnt->mnt_flags |= MNT_UNBINDABLE;
 	}
 }
Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h	2005-11-24 16:47:13.000000000 +0100
+++ linux/include/linux/fs.h	2005-11-24 16:48:14.000000000 +0100
@@ -104,10 +104,7 @@ extern int dir_notify_enable;
 #define MS_REC		16384
 #define MS_VERBOSE	32768
 #define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
-#define MS_UNBINDABLE	(1<<17)	/* change to unbindable */
-#define MS_PRIVATE	(1<<18)	/* change to private */
-#define MS_SLAVE	(1<<19)	/* change to slave */
-#define MS_SHARED	(1<<20)	/* change to shared */
+#define MS_PROPAGATION	(1<<17) /* change propagation property */
 #define MS_ACTIVE	(1<<30)
 #define MS_NOUSER	(1<<31)
 
Index: linux/fs/pnode.h
===================================================================
--- linux.orig/fs/pnode.h	2005-11-24 16:47:13.000000000 +0100
+++ linux/fs/pnode.h	2005-11-24 16:48:14.000000000 +0100
@@ -23,13 +23,20 @@
 #define CL_MAKE_SHARED 		0x08
 #define CL_PROPAGATION 		0x10
 
+enum propagation_type {
+	PT_UNBINDABLE,
+	PT_PRIVATE,
+	PT_SLAVE,
+	PT_SHARED,
+};
+
 static inline void set_mnt_shared(struct vfsmount *mnt)
 {
 	mnt->mnt_flags &= ~MNT_PNODE_MASK;
 	mnt->mnt_flags |= MNT_SHARED;
 }
 
-void change_mnt_propagation(struct vfsmount *, int);
+void change_mnt_propagation(struct vfsmount *, enum propagation_type);
 int propagate_mnt(struct vfsmount *, struct dentry *, struct vfsmount *,
 		struct list_head *);
 int propagate_umount(struct list_head *);
Index: linux/fs/namespace.c
===================================================================
--- linux.orig/fs/namespace.c	2005-11-24 16:47:13.000000000 +0100
+++ linux/fs/namespace.c	2005-11-24 17:24:58.000000000 +0100
@@ -490,7 +490,7 @@ void umount_tree(struct vfsmount *mnt, i
 		list_del_init(&p->mnt_child);
 		if (p->mnt_parent != p)
 			mnt->mnt_mountpoint->d_mounted--;
-		change_mnt_propagation(p, MS_PRIVATE);
+		change_mnt_propagation(p, PT_PRIVATE);
 	}
 }
 
@@ -835,15 +835,28 @@ out_unlock:
 /*
  * recursively change the type of the mountpoint.
  */
-static int do_change_type(struct nameidata *nd, int flag)
+static int do_change_type(struct nameidata *nd, int recurse, char *name)
 {
 	struct vfsmount *m, *mnt = nd->mnt;
-	int recurse = flag & MS_REC;
-	int type = flag & ~MS_REC;
+	enum propagation_type type;
 
 	if (nd->dentry != nd->mnt->mnt_root)
 		return -EINVAL;
 
+	if (!name)
+		return -EINVAL;
+
+	if (strcmp(name, "unbindable") == 0)
+		type = PT_UNBINDABLE;
+	else if (strcmp(name, "private") == 0)
+		type = PT_PRIVATE;
+	else if (strcmp(name, "slave") == 0)
+		type = PT_SLAVE;
+	else if (strcmp(name, "shared") == 0)
+		type = PT_SHARED;
+	else
+		return -EINVAL;
+
 	down_write(&namespace_sem);
 	spin_lock(&vfsmount_lock);
 	for (m = mnt; m; m = (recurse ? next_mnt(m, mnt) : NULL))
@@ -1302,8 +1315,8 @@ long do_mount(char *dev_name, char *dir_
 				    data_page);
 	else if (flags & MS_BIND)
 		retval = do_loopback(&nd, dev_name, flags & MS_REC);
-	else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
-		retval = do_change_type(&nd, flags);
+	else if (flags & MS_PROPAGATION)
+		retval = do_change_type(&nd, flags & MS_REC, data_page);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
 	else
