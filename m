Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161251AbVIPS2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161251AbVIPS2i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161247AbVIPS2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:28:37 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:33472 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161241AbVIPS2U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:28:20 -0400
Date: Fri, 16 Sep 2005 11:26:19 -0700
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: linuxram@us.ibm.com, akpm@osdl.org, viro@ftp.linux.org.uk,
       miklos@szeredi.hu, mike@waychison.com, bfields@fieldses.org,
       serue@us.ibm.com
Subject: [RFC PATCH 3/10] vfs: make mounts unclonable 
Message-ID: <20050916182619.GA28459@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: linuxram@us.ibm.com (Ram)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch that help create mounts that cannot be bind mounted.

A mount that is unclonable, cannot be bind mounted. Its a private mount
with this additional unclonable feature

Eg: 	mount --make-unclonable /mnt
	mount --bind /mnt /tmp
	The bind should fail


Signed by Ram Pai (linuxram@us.ibm.com)
 fs/namespace.c        |    6 +++++-
 fs/pnode.c            |   19 +++++++++++++++++++
 include/linux/fs.h    |    1 +
 include/linux/mount.h |    1 +
 include/linux/pnode.h |    7 +++++++
 5 files changed, 33 insertions(+), 1 deletion(-)

Index: 2.6.13.sharedsubtree/fs/namespace.c
===================================================================
--- 2.6.13.sharedsubtree.orig/fs/namespace.c
+++ 2.6.13.sharedsubtree/fs/namespace.c
@@ -654,10 +654,14 @@ static int do_change_type(struct nameida
 		break;
 	case MS_PRIVATE:
 		for (m = mnt; m; m = (recurse ? next_mnt(m, mnt) : NULL))
 			do_make_private(m);
 		break;
+	case MS_UNCLONABLE:
+		for (m = mnt; m; m = (recurse ? next_mnt(m, mnt) : NULL))
+			do_make_unclonable(m);
+		break;
 	}
       out:
 	spin_unlock(&vfsmount_lock);
 	up_write(&namespace_sem);
 	return err;
@@ -1099,11 +1103,11 @@ long do_mount(char *dev_name, char *dir_
 	if (flags & MS_REMOUNT)
 		retval = do_remount(&nd, flags & ~MS_REMOUNT, mnt_flags,
 				    data_page);
 	else if (flags & MS_BIND)
 		retval = do_loopback(&nd, dev_name, flags & MS_REC);
-	else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE))
+	else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNCLONABLE))
 		retval = do_change_type(&nd, flags);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
 	else
 		retval = do_new_mount(&nd, type_page, flags, mnt_flags,
Index: 2.6.13.sharedsubtree/fs/pnode.c
===================================================================
--- 2.6.13.sharedsubtree.orig/fs/pnode.c
+++ 2.6.13.sharedsubtree/fs/pnode.c
@@ -112,5 +112,24 @@ int do_make_private(struct vfsmount *mnt
 	spin_unlock(&vfspnode_lock);
 	mnt->mnt_master = NULL;
 	set_mnt_private(mnt);
 	return 0;
 }
+
+/*
+ * a unclonable mount does not receive and forward
+ * propagations and cannot be cloned(bind mounted).
+ */
+int do_make_unclonable(struct vfsmount *mnt)
+{
+	/*
+	 * a unclonable mount is nothing but a
+	 * private mount which is unclonnable.
+	 */
+	spin_lock(&vfspnode_lock);
+	__do_make_slave(mnt);
+	list_del_init(&mnt->mnt_slave);
+	spin_unlock(&vfspnode_lock);
+	mnt->mnt_master = NULL;
+	set_mnt_unclonable(mnt);
+	return 0;
+}
Index: 2.6.13.sharedsubtree/include/linux/mount.h
===================================================================
--- 2.6.13.sharedsubtree.orig/include/linux/mount.h
+++ 2.6.13.sharedsubtree/include/linux/mount.h
@@ -19,10 +19,11 @@
 
 #define MNT_NOSUID	0x01
 #define MNT_NODEV	0x02
 #define MNT_NOEXEC	0x04
 #define MNT_SHARED	0x10	/* if the vfsmount is a shared mount */
+#define MNT_UNCLONABLE	0x20	/* if the vfsmount is a unclonable mount */
 #define MNT_PNODE_MASK	0x30	/* propogation flag mask */
 
 #define IS_MNT_SHARED(mnt) (mnt->mnt_flags & MNT_SHARED)
 #define IS_MNT_SLAVE(mnt) (!list_empty(&mnt->mnt_slave))
 #define IS_MNT_PRIVATE(mnt) (!IS_MNT_SLAVE(mnt) && \
Index: 2.6.13.sharedsubtree/include/linux/pnode.h
===================================================================
--- 2.6.13.sharedsubtree.orig/include/linux/pnode.h
+++ 2.6.13.sharedsubtree/include/linux/pnode.h
@@ -24,10 +24,16 @@ static inline void set_mnt_shared(struct
 static inline void set_mnt_private(struct vfsmount *mnt)
 {
 	mnt->mnt_flags &= ~MNT_PNODE_MASK;
 }
 
+static inline void set_mnt_unclonable(struct vfsmount *mnt)
+{
+	mnt->mnt_flags &= ~MNT_PNODE_MASK;
+	mnt->mnt_flags |= MNT_PNODE_MASK & MNT_UNCLONABLE;
+}
+
 static inline struct vfsmount *next_shared(struct vfsmount *p)
 {
 	return list_entry(p->mnt_share.next, struct vfsmount, mnt_share);
 }
 
@@ -42,6 +48,7 @@ static inline struct vfsmount *next_slav
 }
 
 int do_make_slave(struct vfsmount *);
 int do_make_shared(struct vfsmount *);
 int do_make_private(struct vfsmount *);
+int do_make_unclonable(struct vfsmount *);
 #endif				/* _LINUX_PNODE_H */
Index: 2.6.13.sharedsubtree/include/linux/fs.h
===================================================================
--- 2.6.13.sharedsubtree.orig/include/linux/fs.h
+++ 2.6.13.sharedsubtree/include/linux/fs.h
@@ -100,10 +100,11 @@ extern int dir_notify_enable;
 #define MS_NODIRATIME	2048	/* Do not update directory access times */
 #define MS_BIND		4096
 #define MS_MOVE		8192
 #define MS_REC		16384
 #define MS_VERBOSE	32768
+#define MS_UNCLONABLE	(1<<17)	/* recursively change to unclonnable */
 #define MS_PRIVATE	(1<<18)	/* recursively change to private */
 #define MS_SLAVE	(1<<19)	/* recursively change to slave */
 #define MS_SHARED	(1<<20)	/* recursively change to shared */
 #define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
 #define MS_ACTIVE	(1<<30)
