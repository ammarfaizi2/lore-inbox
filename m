Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbUJYPOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbUJYPOm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbUJYPNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:13:37 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:55464 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261854AbUJYOpO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:45:14 -0400
Cc: raven@themaw.net
Subject: [PATCH 13/28] VFS: Introduce soft reference counts
In-Reply-To: <10987154731896@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:45:03 -0400
Message-Id: <10987155032816@sun.com>
References: <10987154731896@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the concept of a 'soft' reference count for a vfsmount.
This type of reference count allows for references to be held on mountpoints
that do not affect their busy states for userland unmounting.  Some might
argue that this is wrong because 'when I unmount a filesystem, I want the
resources associated with it to go away too', but this way of thinking was
deprecated with the addition of namespaces and --bind back in the 2.4 series.

A future addition may see a callback mechanism so that in kernel users can
use a given mountpoint and have it deregistered some way (quota and
accounting come to mind).

These soft reference counts are used by a later patch that adds an interface
for holding and manipulating mountpoints using filedescriptors.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 fs/namespace.c        |    4 ++++
 include/linux/mount.h |   28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

Index: linux-2.6.9-quilt/include/linux/mount.h
===================================================================
--- linux-2.6.9-quilt.orig/include/linux/mount.h	2004-10-22 17:17:38.881553248 -0400
+++ linux-2.6.9-quilt/include/linux/mount.h	2004-10-22 17:17:40.185355040 -0400
@@ -30,6 +30,7 @@ struct vfsmount
 	struct list_head mnt_mounts;	/* list of children, anchored here */
 	struct list_head mnt_child;	/* and going through their mnt_child */
 	atomic_t mnt_count;
+	atomic_t mnt_softcount; 	/* hold reference w/o going busy */
 	union {
 		struct vfsmount *base;	/* pointer to root of vfsmount tree */
 		atomic_t count;		/* user ref count on this tree */
@@ -104,6 +105,33 @@ static inline void mntput(struct vfsmoun
 	}
 }
 
+static inline struct vfsmount *mntsoftget(struct vfsmount *mnt)
+{
+	if (mnt) {
+		read_lock(&vfsmountref_lock);
+		atomic_inc(&mnt->mnt_softcount);
+		mntgroupget(mnt);
+		read_unlock(&vfsmountref_lock);
+	}
+	return mnt;
+}
+
+static inline void mntsoftput(struct vfsmount *mnt)
+{
+	struct vfsmount *cleanup;
+	might_sleep();
+	if (mnt) {
+		if (atomic_dec_and_test(&mnt->mnt_count))
+			__mntput(mnt);
+		read_lock(&vfsmountref_lock);
+		cleanup = mntgroupput(mnt);
+		atomic_dec(&mnt->mnt_softcount);
+		read_unlock(&vfsmountref_lock);
+		if (cleanup)
+			__mntgroupput(cleanup);
+	}
+}
+
 extern void free_vfsmnt(struct vfsmount *mnt);
 extern struct vfsmount *alloc_vfsmnt(const char *name);
 extern struct vfsmount *do_kern_mount(const char *fstype, int flags,
Index: linux-2.6.9-quilt/fs/namespace.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/namespace.c	2004-10-22 17:17:39.557450496 -0400
+++ linux-2.6.9-quilt/fs/namespace.c	2004-10-22 17:17:40.187354736 -0400
@@ -73,6 +73,7 @@ struct vfsmount *alloc_vfsmnt(const char
 		memset(mnt, 0, sizeof(struct vfsmount));
 		mnt->mnt_flags = MNT_ISBASE;
 		atomic_set(&mnt->mnt_count,1);
+		atomic_set(&mnt->mnt_softcount,0);
 		atomic_set(&mnt->mnt_group.count, 1);
 		INIT_LIST_HEAD(&mnt->mnt_hash);
 		INIT_LIST_HEAD(&mnt->mnt_child);
@@ -187,6 +188,7 @@ static void detach_mnt(struct vfsmount *
 
 		/* count the total number of refcounts in the sub-tree */
 		nrefs += atomic_read(&p->mnt_count);
+		       + atomic_read(&p->mnt_softcount);
 	}
 
 	/*
@@ -362,6 +364,7 @@ void __mntgroupput(struct vfsmount *mnt)
 
 		if (mnt == mnt->mnt_parent) {
 			WARN_ON(atomic_read(&mnt->mnt_count) != 0);
+			WARN_ON(atomic_read(&mnt->mnt_softcount) != 0);
 			list_del_init(&mnt->mnt_list);
 			__mntput(mnt);
 		} else {
@@ -373,6 +376,7 @@ void __mntgroupput(struct vfsmount *mnt)
 			dput(old_nd.dentry);
 			atomic_dec(&mnt->mnt_count);
 			WARN_ON(atomic_read(&mnt->mnt_count) != 0);
+			WARN_ON(atomic_read(&mnt->mnt_softcount) != 0);
 			__mntput(mnt);
 		}
 	}

