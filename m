Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVGRHHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVGRHHN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 03:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVGRHHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 03:07:12 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:44483 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261456AbVGRHHI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 03:07:08 -0400
Message-Id: <20050718070701.394389000@localhost>
References: <20050718065311.210001000@localhost>
Date: Sun, 17 Jul 2005 23:53:13 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       mike@waychison.com, Miklos Szeredi <miklos@szeredi.hu>,
       bfields@fieldses.org, Andrew Morton <akpm@osdl.org>,
       penberg@cs.helsinki.fi
Subject: [RFC-2 PATCH 2/8] shared subtree
Content-Type: text/x-patch; name=unclone.patch
Content-Disposition: inline; filename=unclone.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Adds the ability to unclone a vfs tree. A uncloned vfs tree will not be
 clonnable, and hence cannot be bind/rbind to any other mountpoint.

 RP


 fs/namespace.c        |   15 ++++++++++++++-
 include/linux/fs.h    |    1 +
 include/linux/mount.h |   15 +++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

Index: 2.6.12.work1/fs/namespace.c
===================================================================
--- 2.6.12.work1.orig/fs/namespace.c
+++ 2.6.12.work1/fs/namespace.c
@@ -678,6 +678,14 @@ static int do_make_private(struct vfsmou
 	return 0;
 }
 
+static int do_make_unclone(struct vfsmount *mnt)
+{
+	if(mnt->mnt_pnode)
+		pnode_disassociate_mnt(mnt);
+	set_mnt_unclone(mnt);
+	return 0;
+}
+
 /*
  * recursively change the type of the mountpoint.
  */
@@ -687,6 +695,7 @@ static int do_change_type(struct nameida
 	int err=0;
 
 	if (!(flag & MS_SHARED) && !(flag & MS_PRIVATE)
+			&& !(flag & MS_UNCLONE)
 			&& !(flag & MS_SLAVE))
 		return -EINVAL;
 
@@ -705,6 +714,9 @@ static int do_change_type(struct nameida
 		case MS_PRIVATE:
 			err = do_make_private(m);
 			break;
+		case MS_UNCLONE:
+			err = do_make_unclone(m);
+			break;
 		}
 	}
 	spin_unlock(&vfsmount_lock);
@@ -1145,7 +1157,8 @@ long do_mount(char * dev_name, char * di
 				    data_page);
 	else if (flags & MS_BIND)
 		retval = do_loopback(&nd, dev_name, flags & MS_REC);
-	else if (flags & MS_SHARED || flags & MS_PRIVATE || flags & MS_SLAVE)
+	else if (flags & MS_SHARED || flags & MS_UNCLONE ||
+			flags & MS_PRIVATE || flags & MS_SLAVE)
 		retval = do_change_type(&nd, flags);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
Index: 2.6.12.work1/include/linux/fs.h
===================================================================
--- 2.6.12.work1.orig/include/linux/fs.h
+++ 2.6.12.work1/include/linux/fs.h
@@ -102,6 +102,7 @@ extern int dir_notify_enable;
 #define MS_MOVE		8192
 #define MS_REC		16384
 #define MS_VERBOSE	32768
+#define MS_UNCLONE	(1<<17) /* recursively change to unclonnable */
 #define MS_PRIVATE	(1<<18) /* recursively change to private */
 #define MS_SLAVE	(1<<19) /* recursively change to slave */
 #define MS_SHARED	(1<<20) /* recursively change to shared */
Index: 2.6.12.work1/include/linux/mount.h
===================================================================
--- 2.6.12.work1.orig/include/linux/mount.h
+++ 2.6.12.work1/include/linux/mount.h
@@ -22,15 +22,18 @@
 #define MNT_PRIVATE	0x10  /* if the vfsmount is private, by default it is private*/
 #define MNT_SLAVE	0x20  /* if the vfsmount is a slave mount of its pnode */
 #define MNT_SHARED	0x40  /* if the vfsmount is a slave mount of its pnode */
+#define MNT_UNCLONE	0x80  /* if the vfsmount is unclonable */
 #define MNT_PNODE_MASK	0xf0  /* propogation flag mask */
 
 #define IS_MNT_SHARED(mnt) (mnt->mnt_flags & MNT_SHARED)
 #define IS_MNT_SLAVE(mnt) (mnt->mnt_flags & MNT_SLAVE)
 #define IS_MNT_PRIVATE(mnt) (mnt->mnt_flags & MNT_PRIVATE)
+#define IS_MNT_UNCLONE(mnt) (mnt->mnt_flags & MNT_UNCLONE)
 
 #define CLEAR_MNT_SHARED(mnt) (mnt->mnt_flags &= ~(MNT_PNODE_MASK & MNT_SHARED))
 #define CLEAR_MNT_PRIVATE(mnt) (mnt->mnt_flags &= ~(MNT_PNODE_MASK & MNT_PRIVATE))
 #define CLEAR_MNT_SLAVE(mnt) (mnt->mnt_flags &= ~(MNT_PNODE_MASK & MNT_SLAVE))
+#define CLEAR_MNT_UNCLONE(mnt) (mnt->mnt_flags &= ~(MNT_PNODE_MASK & MNT_UNCLONE))
 
 struct vfsmount
 {
@@ -59,6 +62,7 @@ static inline void set_mnt_shared(struct
 	mnt->mnt_flags |= MNT_PNODE_MASK & MNT_SHARED;
 	CLEAR_MNT_PRIVATE(mnt);
 	CLEAR_MNT_SLAVE(mnt);
+	CLEAR_MNT_UNCLONE(mnt);
 }
 
 static inline void set_mnt_private(struct vfsmount *mnt)
@@ -66,6 +70,16 @@ static inline void set_mnt_private(struc
 	mnt->mnt_flags |= MNT_PNODE_MASK & MNT_PRIVATE;
 	CLEAR_MNT_SLAVE(mnt);
 	CLEAR_MNT_SHARED(mnt);
+	CLEAR_MNT_UNCLONE(mnt);
+	mnt->mnt_pnode = NULL;
+}
+
+static inline void set_mnt_unclone(struct vfsmount *mnt)
+{
+	mnt->mnt_flags |= MNT_PNODE_MASK & MNT_UNCLONE;
+	CLEAR_MNT_SLAVE(mnt);
+	CLEAR_MNT_SHARED(mnt);
+	CLEAR_MNT_PRIVATE(mnt);
 	mnt->mnt_pnode = NULL;
 }
 
@@ -74,6 +88,7 @@ static inline void set_mnt_slave(struct 
 	mnt->mnt_flags |= MNT_PNODE_MASK & MNT_SLAVE;
 	CLEAR_MNT_PRIVATE(mnt);
 	CLEAR_MNT_SHARED(mnt);
+	CLEAR_MNT_UNCLONE(mnt);
 }
 
 static inline struct vfsmount *mntget(struct vfsmount *mnt)
