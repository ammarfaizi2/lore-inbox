Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbVKHCCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbVKHCCQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbVKHCB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:01:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:26573 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965218AbVKHCBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:01:36 -0500
To: torvalds@osdl.org
Subject: [PATCH 11/18] introduce shared mounts
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Message-Id: <E1EZInj-0001Ex-7l@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 08 Nov 2005 02:01:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>
Date: 1131401973 -0500

Creates shared mounts.  A shared mount when bind-mounted to some mountpoint,
propagates mount/umount events to each other. All the shared mounts that
propagate events to each other belong to the same peer-group.

Signed-off-by: Ram Pai (linuxram@us.ibm.com)
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/namespace.c        |    3 ++-
 fs/pnode.c            |   13 ++++++++++++-
 fs/pnode.h            |    4 ++++
 include/linux/fs.h    |    1 +
 include/linux/mount.h |    2 ++
 5 files changed, 21 insertions(+), 2 deletions(-)

2fcec0f04ac5906f647d8e004a8091e48974b952
diff --git a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -68,6 +68,7 @@ struct vfsmount *alloc_vfsmnt(const char
 		INIT_LIST_HEAD(&mnt->mnt_mounts);
 		INIT_LIST_HEAD(&mnt->mnt_list);
 		INIT_LIST_HEAD(&mnt->mnt_expire);
+		INIT_LIST_HEAD(&mnt->mnt_share);
 		if (name) {
 			int size = strlen(name) + 1;
 			char *newname = kmalloc(size, GFP_KERNEL);
@@ -1113,7 +1114,7 @@ long do_mount(char *dev_name, char *dir_
 				    data_page);
 	else if (flags & MS_BIND)
 		retval = do_loopback(&nd, dev_name, flags & MS_REC);
-	else if (flags & MS_PRIVATE)
+	else if (flags & (MS_SHARED | MS_PRIVATE))
 		retval = do_change_type(&nd, flags);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
diff --git a/fs/pnode.c b/fs/pnode.c
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -11,7 +11,18 @@
 #include <linux/fs.h>
 #include "pnode.h"
 
+/* return the next shared peer mount of @p */
+static inline struct vfsmount *next_peer(struct vfsmount *p)
+{
+	return list_entry(p->mnt_share.next, struct vfsmount, mnt_share);
+}
+
 void change_mnt_propagation(struct vfsmount *mnt, int type)
 {
-	mnt->mnt_flags &= ~MNT_PNODE_MASK;
+	if (type == MS_SHARED) {
+		mnt->mnt_flags |= MNT_SHARED;
+	} else {
+		list_del_init(&mnt->mnt_share);
+		mnt->mnt_flags &= ~MNT_PNODE_MASK;
+	}
 }
diff --git a/fs/pnode.h b/fs/pnode.h
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -10,5 +10,9 @@
 
 #include <linux/list.h>
 #include <linux/mount.h>
+
+#define IS_MNT_SHARED(mnt) (mnt->mnt_flags & MNT_SHARED)
+#define CLEAR_MNT_SHARED(mnt) (mnt->mnt_flags &= ~MNT_SHARED)
+
 void change_mnt_propagation(struct vfsmount *, int);
 #endif /* _LINUX_PNODE_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -105,6 +105,7 @@ extern int dir_notify_enable;
 #define MS_REC		16384
 #define MS_VERBOSE	32768
 #define MS_PRIVATE	(1<<18)	/* change to private */
+#define MS_SHARED	(1<<20)	/* change to shared */
 #define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
 #define MS_ACTIVE	(1<<30)
 #define MS_NOUSER	(1<<31)
diff --git a/include/linux/mount.h b/include/linux/mount.h
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -20,6 +20,7 @@
 #define MNT_NOSUID	0x01
 #define MNT_NODEV	0x02
 #define MNT_NOEXEC	0x04
+#define MNT_SHARED	0x10	/* if the vfsmount is a shared mount */
 #define MNT_PNODE_MASK	0x30	/* propogation flag mask */
 
 struct vfsmount {
@@ -36,6 +37,7 @@ struct vfsmount {
 	char *mnt_devname;		/* Name of device e.g. /dev/dsk/hda1 */
 	struct list_head mnt_list;
 	struct list_head mnt_expire;	/* link in fs-specific expiry list */
+	struct list_head mnt_share;	/* circular list of shared mounts */
 	struct namespace *mnt_namespace; /* containing namespace */
 	int mnt_pinned;
 };
