Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266042AbUA1PkM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 10:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266053AbUA1PkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 10:40:11 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:11 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S266042AbUA1Pj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 10:39:27 -0500
Date: Wed, 28 Jan 2004 23:38:36 +0800 (WST)
From: raven@themaw.net
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Jeremy Fitzhardinge <jeremy@goop.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Mike Waychison <Michael.Waychison@Sun.COM>
Subject: [PATCH 1/8] autofs4-2.6 - to support autofs 4.1.x 
Message-ID: <Pine.LNX.4.58.0401282308510.17471@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.3, required 8,
	NO_REAL_NAME, PATCH_UNIFIED_DIFF, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch:

1-autofs4-2.6.0-test9-expire.patch

This was originally written against an early 2.6 test. It was the result 
of an e-mail discussion with Soni Maneesh. He felt that using reference
counts in expire is unreliable and suggested it should be implemented
using standard VFS calls where possible (Jeremy would remember this 
discussion).

diff -Nur linux-2.6.0-0.test9.orig/fs/autofs4/autofs_i.h linux-2.6.0-0.test9.expire/fs/autofs4/autofs_i.h
--- linux-2.6.0-0.test9.orig/fs/autofs4/autofs_i.h	2003-10-26 02:44:03.000000000 +0800
+++ linux-2.6.0-0.test9.expire/fs/autofs4/autofs_i.h	2003-11-15 09:21:53.000000000 +0800
@@ -25,6 +25,8 @@
 #include <linux/string.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
 #include <asm/current.h>
 #include <asm/uaccess.h>
 
@@ -160,3 +162,21 @@
 int autofs4_wait(struct autofs_sb_info *,struct qstr *, enum autofs_notify);
 int autofs4_wait_release(struct autofs_sb_info *,autofs_wqt_t,int);
 void autofs4_catatonic_mode(struct autofs_sb_info *);
+
+static inline int simple_positive(struct dentry *dentry)
+{
+	return dentry->d_inode && !d_unhashed(dentry);
+}
+
+static inline int simple_empty_nolock(struct dentry *dentry)
+{
+	struct dentry *child;
+	int ret = 0;
+
+	list_for_each_entry(child, &dentry->d_subdirs, d_child)
+		if (simple_positive(child))
+			goto out;
+	ret = 1;
+out:
+	return ret;
+}
diff -Nur linux-2.6.0-0.test9.orig/fs/autofs4/expire.c linux-2.6.0-0.test9.expire/fs/autofs4/expire.c
--- linux-2.6.0-0.test9.orig/fs/autofs4/expire.c	2003-10-26 02:44:04.000000000 +0800
+++ linux-2.6.0-0.test9.expire/fs/autofs4/expire.c	2003-11-18 22:51:08.000000000 +0800
@@ -4,6 +4,7 @@
  *
  *  Copyright 1997-1998 Transmeta Corporation -- All Rights Reserved
  *  Copyright 1999-2000 Jeremy Fitzhardinge <jeremy@goop.org>
+ *  Copyright 2001-2003 Ian Kent <raven@themaw.net>
  *
  * This file is part of the Linux kernel and is made available under
  * the terms of the GNU General Public License, version 2, or at your
@@ -12,139 +13,240 @@
  * ------------------------------------------------------------------------- */
 
 #include "autofs_i.h"
-#include <linux/mount.h>
 
-/*
- * Determine if a subtree of the namespace is busy.
- *
- * mnt is the mount tree under the autofs mountpoint
- */
-static inline int is_vfsmnt_tree_busy(struct vfsmount *mnt)
+static unsigned long now;
+
+/* Check if a dentry can be expired return 1 if it can else return 0 */
+static inline int autofs4_can_expire(struct dentry *dentry,
+					unsigned long timeout, int do_now)
+{
+	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+
+	/* dentry in the process of being deleted */
+	if (ino == NULL)
+		return 0;
+
+	/* No point expiring a pending mount */
+	if (dentry->d_flags & DCACHE_AUTOFS_PENDING)
+		return 0;
+
+	if (!do_now) {
+		/* Too young to die */
+		if (time_after(ino->last_used + timeout, now))
+			return 0;
+		
+		/* update last_used here :- 
+		   - obviously makes sense if it is in use now
+		   - less obviously, prevents rapid-fire expire
+		     attempts if expire fails the first time */
+		ino->last_used = now;
+	}
+
+	return 1;
+}
+
+/* Sorry I can't solve the problem without using counts either */
+static int autofs4_may_umount(struct vfsmount *mnt)
 {
-	struct vfsmount *this_parent = mnt;
 	struct list_head *next;
-	int count;
+	struct vfsmount *this_parent = mnt;
+	int actual_refs;
+	int minimum_refs;
 
-	count = atomic_read(&mnt->mnt_count) - 1;
+	actual_refs = atomic_read(&mnt->mnt_count);
+	minimum_refs = 2;
 
+	spin_lock(&vfsmount_lock);
 repeat:
 	next = this_parent->mnt_mounts.next;
-	DPRINTK(("is_vfsmnt_tree_busy: mnt=%p, this_parent=%p, next=%p\n",
-		 mnt, this_parent, next));
 resume:
-	for( ; next != &this_parent->mnt_mounts; next = next->next) {
-		struct vfsmount *p = list_entry(next, struct vfsmount,
-						mnt_child);
-
-		/* -1 for struct vfs_mount's normal count, 
-		   -1 to compensate for child's reference to parent */
-		count += atomic_read(&p->mnt_count) - 1 - 1;
+	while (next != &this_parent->mnt_mounts) {
+		struct vfsmount *p = list_entry(next, struct vfsmount, mnt_child);
+
+		next = next->next;
 
-		DPRINTK(("is_vfsmnt_tree_busy: p=%p, count now %d\n",
-			 p, count));
+		actual_refs += atomic_read(&p->mnt_count);
+		minimum_refs += 2;
 
-		if (!list_empty(&p->mnt_mounts)) {
+		if ( !list_empty(&p->mnt_mounts) ) {
 			this_parent = p;
 			goto repeat;
 		}
-		/* root is busy if any leaf is busy */
-		if (atomic_read(&p->mnt_count) > 1)
-			return 1;
 	}
 
-	/* All done at this level ... ascend and resume the search. */
 	if (this_parent != mnt) {
-		next = this_parent->mnt_child.next; 
+		next = this_parent->mnt_child.next;
 		this_parent = this_parent->mnt_parent;
 		goto resume;
 	}
+	spin_unlock(&vfsmount_lock);
 
-	DPRINTK(("is_vfsmnt_tree_busy: count=%d\n", count));
-	return count != 0; /* remaining users? */
+	DPRINTK(("autofs4_may_umount: done actual = %d, minimum = %d\n",
+		 actual_refs, minimum_refs));
+
+	return actual_refs > minimum_refs;
 }
 
-/* Traverse a dentry's list of vfsmounts and return the number of
-   non-busy mounts */
-static int check_vfsmnt(struct vfsmount *mnt, struct dentry *dentry)
+/* Check a mount point for busyness return 1 if not busy, otherwise */
+static int autofs4_check_mount(struct vfsmount *mnt, struct dentry *dentry)
 {
-	int ret = dentry->d_mounted;
-	struct vfsmount *vfs = lookup_mnt(mnt, dentry);
+	int status = 0;
 
-	if (vfs) {
-		mntput(vfs);
-		if (is_vfsmnt_tree_busy(vfs))
-			ret--;
-	}
-	DPRINTK(("check_vfsmnt: ret=%d\n", ret));
-	return ret;
+	DPRINTK(("autofs4_check_mount: dentry %p %.*s\n",
+		 dentry, (int)dentry->d_name.len, dentry->d_name.name));
+
+	mntget(mnt);
+	dget(dentry);
+
+	if (!follow_down(&mnt, &dentry))
+		goto done;
+
+	while (d_mountpoint(dentry) && follow_down(&mnt, &dentry))
+		;
+
+	/* This is an autofs submount, we can't expire it */
+	if (is_autofs4_dentry(dentry))
+		goto done;
+	
+	/* The big question */
+	if (autofs4_may_umount(mnt) == 0)
+		status = 1;
+done:
+	DPRINTK(("autofs4_check_mount: returning = %d\n", status));
+	mntput(mnt);
+	dput(dentry);
+	return status;
 }
 
-/* Check dentry tree for busyness.  If a dentry appears to be busy
-   because it is a mountpoint, check to see if the mounted
-   filesystem is busy. */
-static int is_tree_busy(struct vfsmount *topmnt, struct dentry *top)
+/* Check a directory tree of mount points for busyness
+ * The tree is not busy iff no mountpoints are busy 
+ * Return 1 if the tree is busy or 0 otherwise
+ */
+static int autofs4_check_tree(struct vfsmount *mnt,
+	       		      struct dentry *top,
+			      unsigned long timeout,
+			      int do_now)
 {
-	struct dentry *this_parent;
+	struct dentry *this_parent = top;
 	struct list_head *next;
-	int count;
 
-	count = atomic_read(&top->d_count);
-	
-	DPRINTK(("is_tree_busy: top=%p initial count=%d\n", 
-		 top, count));
-	this_parent = top;
-
-	if (is_autofs4_dentry(top)) {
-		count--;
-		DPRINTK(("is_tree_busy: autofs; count=%d\n", count));
-	}
+	DPRINTK(("autofs4_check_tree: parent %p %.*s\n",
+		 top, (int)top->d_name.len, top->d_name.name));
 
-	if (d_mountpoint(top))
-		count -= check_vfsmnt(topmnt, top);
+	/* Negative dentry - give up */
+	if (!simple_positive(top))
+		return 0;
+
+	/* Timeout of a tree mount is determined by its top dentry */
+	if (!autofs4_can_expire(top, timeout, do_now))
+		return 0;
 
- repeat:
+	spin_lock(&dcache_lock);
+repeat:
 	next = this_parent->d_subdirs.next;
- resume:
+resume:
 	while (next != &this_parent->d_subdirs) {
-		int adj = 0;
-		struct dentry *dentry = list_entry(next, struct dentry,
-						   d_child);
+		struct dentry *dentry = list_entry(next, struct dentry, d_child);
+
+		/* Negative dentry - give up */
+		if (!simple_positive(dentry)) {
+			next = next->next;
+			continue;
+		}
+
+		DPRINTK(("autofs4_check_tree: dentry %p %.*s\n",
+			 dentry, (int)dentry->d_name.len, dentry->d_name.name));
+
+		if (!simple_empty_nolock(dentry)) {
+			this_parent = dentry;
+			goto repeat;
+		}
+
+		dentry = dget(dentry);
+		spin_unlock(&dcache_lock);
+
+		if (d_mountpoint(dentry)) {
+			/* First busy => tree busy */
+			if (!autofs4_check_mount(mnt, dentry)) {
+				dput(dentry);
+				return 0;
+			}
+		}
+
+		dput(dentry);
+		spin_lock(&dcache_lock);
 		next = next->next;
+	}
 
-		count += atomic_read(&dentry->d_count) - 1;
+	if (this_parent != top) {
+		next = this_parent->d_child.next;
+		this_parent = this_parent->d_parent;
+		goto resume;
+	}
+	spin_unlock(&dcache_lock);
 
-		if (d_mountpoint(dentry))
-			adj += check_vfsmnt(topmnt, dentry);
+	return 1;
+}
+
+struct dentry *autofs4_check_leaves(struct vfsmount *mnt,
+				    struct dentry *parent,
+				    unsigned long timeout,
+				    int do_now)
+{
+	struct dentry *this_parent = parent;
+	struct list_head *next;
+
+	DPRINTK(("autofs4_check_leaves: parent %p %.*s\n",
+		parent, (int)parent->d_name.len, parent->d_name.name));
+
+	spin_lock(&dcache_lock);
+repeat:
+	next = this_parent->d_subdirs.next;
+resume:
+	while (next != &this_parent->d_subdirs) {
+		struct dentry *dentry = list_entry(next, struct dentry, d_child);
 
-		if (is_autofs4_dentry(dentry)) {
-			adj++;
-			DPRINTK(("is_tree_busy: autofs; adj=%d\n",
-				 adj));
+		/* Negative dentry - give up */
+		if (!simple_positive(dentry)) {
+			next = next->next;
+			continue;
 		}
 
-		count -= adj;
+		DPRINTK(("autofs4_check_leaves: dentry %p %.*s\n",
+			dentry, (int)dentry->d_name.len, dentry->d_name.name));
 
 		if (!list_empty(&dentry->d_subdirs)) {
 			this_parent = dentry;
 			goto repeat;
 		}
 
-		if (atomic_read(&dentry->d_count) != adj) {
-			DPRINTK(("is_tree_busy: busy leaf (d_count=%d adj=%d)\n",
-				 atomic_read(&dentry->d_count), adj));
-			return 1;
+		dentry = dget(dentry);
+		spin_unlock(&dcache_lock);
+
+		if (d_mountpoint(dentry)) {
+			/* Can we expire this guy */
+			if (!autofs4_can_expire(dentry, timeout, do_now))
+				goto cont;
+
+			/* Can we umount this guy */
+			if (autofs4_check_mount(mnt, dentry))
+				return dentry;
+
 		}
+cont:
+		dput(dentry);
+		spin_lock(&dcache_lock);
+		next = next->next;
 	}
 
-	/* All done at this level ... ascend and resume the search. */
-	if (this_parent != top) {
-		next = this_parent->d_child.next; 
+	if (this_parent != parent) {
+		next = this_parent->d_child.next;
 		this_parent = this_parent->d_parent;
 		goto resume;
 	}
+	spin_unlock(&dcache_lock);
 
-	DPRINTK(("is_tree_busy: count=%d\n", count));
-	return count != 0; /* remaining users? */
+	return NULL;
 }
 
 /*
@@ -156,61 +258,86 @@
 static struct dentry *autofs4_expire(struct super_block *sb,
 				     struct vfsmount *mnt,
 				     struct autofs_sb_info *sbi,
-				     int do_now)
+				     int how)
 {
-	unsigned long now = jiffies;
 	unsigned long timeout;
 	struct dentry *root = sb->s_root;
-	struct list_head *tmp;
+	struct dentry *expired = NULL;
+	struct list_head *next;
+	int do_now = how & AUTOFS_EXP_IMMEDIATE;
+	int exp_leaves = how & AUTOFS_EXP_LEAVES;
 
-	if (!sbi->exp_timeout || !root)
+	if ( !sbi->exp_timeout || !root )
 		return NULL;
 
+	now = jiffies;
 	timeout = sbi->exp_timeout;
 
 	spin_lock(&dcache_lock);
-	for(tmp = root->d_subdirs.next;
-	    tmp != &root->d_subdirs; 
-	    tmp = tmp->next) {
-		struct autofs_info *ino;
-		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
+	next = root->d_subdirs.next;
 
-		if (dentry->d_inode == NULL)
+	/* On exit from the loop expire is set to a dgot dentry
+	 * to expire or it's NULL */
+	while ( next != &root->d_subdirs ) {
+		struct dentry *dentry = list_entry(next, struct dentry, d_child);
+
+		/* Negative dentry - give up */
+		if ( !simple_positive(dentry) ) {
+			next = next->next;
 			continue;
+		}
 
-		ino = autofs4_dentry_ino(dentry);
+		dentry = dget(dentry);
+		spin_unlock(&dcache_lock);
 
-		if (ino == NULL) {
-			/* dentry in the process of being deleted */
-			continue;
+		/* Case 1: indirect mount or top level direct mount */
+		if (d_mountpoint(dentry)) {
+			DPRINTK(("autofs4_expire: checking mountpoint %p %.*s\n",
+			 dentry, (int)dentry->d_name.len, dentry->d_name.name));
+
+			/* Can we expire this guy */
+			if (!autofs4_can_expire(dentry, timeout, do_now))
+				goto next;
+
+			/* Can we umount this guy */
+			if (autofs4_check_mount(mnt, dentry)) {
+				expired = dentry;
+				break;
+			}
+			goto next;
 		}
 
-		/* No point expiring a pending mount */
-		if (dentry->d_flags & DCACHE_AUTOFS_PENDING)
-			continue;
+		if ( simple_empty(dentry) )
+			goto next;
 
-		if (!do_now) {
-			/* Too young to die */
-			if (time_after(ino->last_used + timeout, now))
-				continue;
-		
-			/* update last_used here :- 
-			   - obviously makes sense if it is in use now
-			   - less obviously, prevents rapid-fire expire
-			     attempts if expire fails the first time */
-			ino->last_used = now;
+		/* Case 2: tree mount, expire iff entire tree is not busy */
+		if (!exp_leaves) {
+			if (autofs4_check_tree(mnt, dentry, timeout, do_now)) {
+			expired = dentry;
+			break;
+			}
+		/* Case 3: direct mount, expire individual leaves */
+		} else {
+			expired = autofs4_check_leaves(mnt, dentry, timeout, do_now);
+			if (expired) {
+				dput(dentry);
+				break;
+			}
 		}
-		if (!is_tree_busy(mnt, dentry)) {
-			DPRINTK(("autofs_expire: returning %p %.*s\n",
-				 dentry, (int)dentry->d_name.len, dentry->d_name.name));
-			/* Start from here next time */
-			list_del(&root->d_subdirs);
-			list_add(&root->d_subdirs, &dentry->d_child);
-			dget(dentry);
-			spin_unlock(&dcache_lock);
+next:
+		dput(dentry);
+		spin_lock(&dcache_lock);
+		next = next->next;
+	}
 
-			return dentry;
-		}
+	if ( expired ) {
+		DPRINTK(("autofs4_expire: returning %p %.*s\n",
+			 expired, (int)expired->d_name.len, expired->d_name.name));
+		spin_lock(&dcache_lock);
+		list_del(&expired->d_parent->d_subdirs);
+		list_add(&expired->d_parent->d_subdirs, &expired->d_child);
+		spin_unlock(&dcache_lock);
+		return expired;
 	}
 	spin_unlock(&dcache_lock);
 
diff -Nur linux-2.6.0-0.test9.orig/include/linux/auto_fs4.h linux-2.6.0-0.test9.expire/include/linux/auto_fs4.h
--- linux-2.6.0-0.test9.orig/include/linux/auto_fs4.h	2003-10-26 02:42:51.000000000 +0800
+++ linux-2.6.0-0.test9.expire/include/linux/auto_fs4.h	2003-11-18 22:52:47.000000000 +0800
@@ -23,6 +23,10 @@
 #define AUTOFS_MIN_PROTO_VERSION	3
 #define AUTOFS_MAX_PROTO_VERSION	4
 
+/* Mask for expire behaviour */
+#define AUTOFS_EXP_IMMEDIATE		1
+#define AUTOFS_EXP_LEAVES		2
+
 /* New message type */
 #define autofs_ptype_expire_multi	2	/* Expire entry (umount request) */
 
