Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbVKHCDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbVKHCDn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965256AbVKHCBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:01:54 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:25293 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965186AbVKHCBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:01:36 -0500
To: torvalds@osdl.org
Subject: [PATCH 15/18] introduce slave mounts
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Message-Id: <E1EZInj-0001F5-BH@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 08 Nov 2005 02:01:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>
Date: 1131402048 -0500

A slave mount always has a master mount from which it receives
mount/umount events. Unlike shared mount the event propagation
does not flow from the slave mount to the master.

Signed-off-by: Ram Pai (linuxram@us.ibm.com)
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/namespace.c        |    4 +++-
 fs/pnode.c            |   54 ++++++++++++++++++++++++++++++++++++++++++++++---
 fs/pnode.h            |    2 ++
 include/linux/fs.h    |    1 +
 include/linux/mount.h |    3 +++
 5 files changed, 60 insertions(+), 4 deletions(-)

f98429253bbedb8511dd1c0af294d95a4c5cbc5d
diff --git a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -67,6 +67,8 @@ struct vfsmount *alloc_vfsmnt(const char
 		INIT_LIST_HEAD(&mnt->mnt_list);
 		INIT_LIST_HEAD(&mnt->mnt_expire);
 		INIT_LIST_HEAD(&mnt->mnt_share);
+		INIT_LIST_HEAD(&mnt->mnt_slave_list);
+		INIT_LIST_HEAD(&mnt->mnt_slave);
 		if (name) {
 			int size = strlen(name) + 1;
 			char *newname = kmalloc(size, GFP_KERNEL);
@@ -1243,7 +1245,7 @@ long do_mount(char *dev_name, char *dir_
 				    data_page);
 	else if (flags & MS_BIND)
 		retval = do_loopback(&nd, dev_name, flags & MS_REC);
-	else if (flags & (MS_SHARED | MS_PRIVATE))
+	else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE))
 		retval = do_change_type(&nd, flags);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
diff --git a/fs/pnode.c b/fs/pnode.c
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -17,13 +17,61 @@ static inline struct vfsmount *next_peer
 	return list_entry(p->mnt_share.next, struct vfsmount, mnt_share);
 }
 
+static int do_make_slave(struct vfsmount *mnt)
+{
+	struct vfsmount *peer_mnt = mnt, *master = mnt->mnt_master;
+	struct vfsmount *slave_mnt;
+
+	/*
+	 * slave 'mnt' to a peer mount that has the
+	 * same root dentry. If none is available than
+	 * slave it to anything that is available.
+	 */
+	while ((peer_mnt = next_peer(peer_mnt)) != mnt &&
+	       peer_mnt->mnt_root != mnt->mnt_root) ;
+
+	if (peer_mnt == mnt) {
+		peer_mnt = next_peer(mnt);
+		if (peer_mnt == mnt)
+			peer_mnt = NULL;
+	}
+	list_del_init(&mnt->mnt_share);
+
+	if (peer_mnt)
+		master = peer_mnt;
+
+	if (master) {
+		list_for_each_entry(slave_mnt, &mnt->mnt_slave_list, mnt_slave)
+			slave_mnt->mnt_master = master;
+		list_del(&mnt->mnt_slave);
+		list_add(&mnt->mnt_slave, &master->mnt_slave_list);
+		list_splice(&mnt->mnt_slave_list, master->mnt_slave_list.prev);
+		INIT_LIST_HEAD(&mnt->mnt_slave_list);
+	} else {
+		struct list_head *p = &mnt->mnt_slave_list;
+		while (!list_empty(p)) {
+                        slave_mnt = list_entry(p->next,
+					struct vfsmount, mnt_slave);
+			list_del_init(&slave_mnt->mnt_slave);
+			slave_mnt->mnt_master = NULL;
+		}
+	}
+	mnt->mnt_master = master;
+	CLEAR_MNT_SHARED(mnt);
+	INIT_LIST_HEAD(&mnt->mnt_slave_list);
+	return 0;
+}
+
 void change_mnt_propagation(struct vfsmount *mnt, int type)
 {
 	if (type == MS_SHARED) {
 		set_mnt_shared(mnt);
-	} else {
-		list_del_init(&mnt->mnt_share);
-		mnt->mnt_flags &= ~MNT_PNODE_MASK;
+		return;
+	}
+	do_make_slave(mnt);
+	if (type != MS_SLAVE) {
+		list_del_init(&mnt->mnt_slave);
+		mnt->mnt_master = NULL;
 	}
 }
 
diff --git a/fs/pnode.h b/fs/pnode.h
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -12,10 +12,12 @@
 #include <linux/mount.h>
 
 #define IS_MNT_SHARED(mnt) (mnt->mnt_flags & MNT_SHARED)
+#define IS_MNT_SLAVE(mnt) (mnt->mnt_master)
 #define IS_MNT_NEW(mnt)  (!mnt->mnt_namespace)
 #define CLEAR_MNT_SHARED(mnt) (mnt->mnt_flags &= ~MNT_SHARED)
 
 #define CL_EXPIRE    		0x01
+#define CL_SLAVE     		0x02
 #define CL_COPY_ALL 		0x04
 #define CL_MAKE_SHARED 		0x08
 #define CL_PROPAGATION 		0x10
diff --git a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -105,6 +105,7 @@ extern int dir_notify_enable;
 #define MS_REC		16384
 #define MS_VERBOSE	32768
 #define MS_PRIVATE	(1<<18)	/* change to private */
+#define MS_SLAVE	(1<<19)	/* change to slave */
 #define MS_SHARED	(1<<20)	/* change to shared */
 #define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
 #define MS_ACTIVE	(1<<30)
diff --git a/include/linux/mount.h b/include/linux/mount.h
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -38,6 +38,9 @@ struct vfsmount {
 	struct list_head mnt_list;
 	struct list_head mnt_expire;	/* link in fs-specific expiry list */
 	struct list_head mnt_share;	/* circular list of shared mounts */
+	struct list_head mnt_slave_list;/* list of slave mounts */
+	struct list_head mnt_slave;	/* slave list entry */
+	struct vfsmount *mnt_master;	/* slave is on master->mnt_slave_list */
 	struct namespace *mnt_namespace; /* containing namespace */
 	int mnt_pinned;
 };
