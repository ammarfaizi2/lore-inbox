Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbUJYPAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbUJYPAN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUJYO43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:56:29 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:49832 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261835AbUJYOnV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:43:21 -0400
Cc: raven@themaw.net
Subject: [PATCH 9/28] VFS: Give sane expiry semantics
In-Reply-To: <10987153522992@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:43:02 -0400
Message-Id: <10987153821176@sun.com>
References: <10987153522992@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the semantics of expiry slightly when dealing with stuff
like --move, --bind and --rbind.  The newly added file
Documentation/filesystems/expire_semantics.txt describes how it works.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 Documentation/filesystems/expire_semantics.txt |  184 +++++++++++++++++++++++++
 fs/namespace.c                                 |   26 ++-
 2 files changed, 202 insertions(+), 8 deletions(-)

Index: linux-2.6.9-quilt/fs/namespace.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/namespace.c	2004-10-22 17:17:37.121820768 -0400
+++ linux-2.6.9-quilt/fs/namespace.c	2004-10-22 17:17:37.770722120 -0400
@@ -178,13 +178,22 @@ static int can_expire(struct vfsmount *r
 }
 
 static struct vfsmount *
-clone_mnt(struct vfsmount *old, struct dentry *root)
+clone_mnt(struct vfsmount *old, struct dentry *root, int keep_expiry)
 {
 	struct super_block *sb = old->mnt_sb;
 	struct vfsmount *mnt = alloc_vfsmnt(old->mnt_devname);
 
 	if (mnt) {
-		mnt->mnt_flags = old->mnt_flags & ~MNT_CHILDEXPIRE;
+		if (keep_expiry) {
+			mnt->mnt_flags = old->mnt_flags;
+			if (!list_empty(&old->mnt_expire)) {
+				spin_lock(&vfsmount_lock);
+				list_add_tail(&mnt->mnt_expire, &expiry_list);
+				spin_unlock(&vfsmount_lock);
+			}
+		} else {
+			mnt->mnt_flags = old->mnt_flags & ~MNT_CHILDEXPIRE;
+		}
 		atomic_inc(&sb->s_active);
 		mnt->mnt_sb = sb;
 		mnt->mnt_root = dget(root);
@@ -589,13 +598,14 @@ lives_below_in_same_fs(struct dentry *d,
 	}
 }
 
-static struct vfsmount *copy_tree(struct vfsmount *mnt, struct dentry *dentry)
+static struct vfsmount *copy_tree(struct vfsmount *mnt, struct dentry *dentry,
+		int keep_expiry)
 {
 	struct vfsmount *res, *p, *q, *r, *s;
 	struct list_head *h;
 	struct nameidata nd;
 
-	res = q = clone_mnt(mnt, dentry);
+	res = q = clone_mnt(mnt, dentry, keep_expiry);
 	if (!q)
 		goto Enomem;
 	q->mnt_mountpoint = mnt->mnt_mountpoint;
@@ -614,7 +624,7 @@ static struct vfsmount *copy_tree(struct
 			p = s;
 			nd.mnt = q;
 			nd.dentry = p->mnt_mountpoint;
-			q = clone_mnt(p, p->mnt_root);
+			q = clone_mnt(p, p->mnt_root, keep_expiry);
 			if (!q)
 				goto Enomem;
 			spin_lock(&vfsmount_lock);
@@ -692,9 +702,9 @@ static int do_loopback(struct nameidata 
 	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {
 		err = -ENOMEM;
 		if (recurse)
-			mnt = copy_tree(old_nd.mnt, old_nd.dentry);
+			mnt = copy_tree(old_nd.mnt, old_nd.dentry, 0);
 		else
-			mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
+			mnt = clone_mnt(old_nd.mnt, old_nd.dentry, 0);
 	}
 
 	if (mnt) {
@@ -1197,7 +1207,7 @@ int copy_namespace(int flags, struct tas
 
 	down_write(&tsk->namespace->sem);
 	/* First pass: copy the tree topology */
-	new_ns->root = copy_tree(namespace->root, namespace->root->mnt_root);
+	new_ns->root = copy_tree(namespace->root, namespace->root->mnt_root, 1);
 	if (!new_ns->root) {
 		up_write(&tsk->namespace->sem);
 		kfree(new_ns);
Index: linux-2.6.9-quilt/Documentation/filesystems/expire_semantics.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.9-quilt/Documentation/filesystems/expire_semantics.txt	2004-10-22 17:17:37.775721360 -0400
@@ -0,0 +1,184 @@
+Mountpoint Expiry Semantics
+===========================
+
+In order to implement an autofs system as described in 'Towards a Modern Autofs'
+(ftp://ftp-eng.cobalt.com/pub/whitepapers/autofs/towards_a_modern_autofs.txt), a
+VFS-native expiry system needs to be designed and implemented.  This document
+attempts to summarize the expiry requirements the autofs design requires and
+lays out a set of expiry semantics.  
+
+Requirements
+------------
+
+The following is a set of functions we wish to be able to perform with the
+expiry system.  
+
+  - We need to be able to arbitrarily specify timeouts for all expiries.  
+    - The ability to set an arbitrary timeout at mount-time.
+    - The ability to change a timeout (via a remount)
+    - The ability to remount a given filesystem without affecting the expiry
+      settings.
+    - The ability to disable an expiry of a mountpoint.
+  - We need to be able to expire a single mountpoint.
+  - We need to be able to expire a tree of mountpoints in an atomic fashion.
+    This is required to support lazy-mounting as this is done by nesting direct
+    mount triggers within expiring NFS filesystems.
+    - The ability to mark a sub-tree as expirying all child mountpoints in
+      unison.
+    - The ability to remount individual mountpoints within a sub-tree (children
+      as well as the root mountpoint of the sub-tree) without affecting the
+      expiry settings for that sub-tree.
+    - The ability to disable expiry of a sub-tree.
+    - The semantic that any added mountpoints into a sub-tree after the sub-tree
+      has been marked to expire will block the expire of the sub-tree.
+  - We need to be able to read expiry settings.
+    - The ability to read expiry settings for an individual mountpoint expiry.
+    - The ability to read expiry settings for a sub-tree (by looking at the root
+      mountpoint of the sub-tree).
+    - The ability to identify whether a given mountpoint is part of a sub-tree
+      expiry.
+
+Ticks
+-----
+
+Ticks are meant as a way to specify the amount of time of inactivity that should
+occur before mountpoints expire.  Ticks will by default be 10 seconds long, and
+will be configurable via a sysctl interface.  The sysctl interface will be
+represented in terms of USER_HZ.  The length of a tick is left configurable as
+calculating expiry may become a tedious task on larger system where less
+frequent expiry checks may be more desirable.
+
+Policies
+--------
+
+In order to fulfill the requirements outlined above, we define a new attribute
+to mountpoints called the expiry policy.  Each policy may define a set of
+policy-related attributes.
+
+
+  'NOEXPIRE' - This is the default expiry policy for any given mountpoint.
+     It signifies that this mountpoint will neither expire nor is it part of a
+     sub-tree expiry.  
+
+     This policy has no attributes.
+
+  'EXPIRE' - This policy means that the given mountpoint is set to
+     eventually expire.  It may be an individual mountpoint expiry, or may be
+     the root of a sub-tree that will expire.
+
+     Attribute 'ticks' - This is the number of ticks that must pass of
+     inactive use before the mountpoint will expire.  This value is a non-zero
+     positive integer. For more information on 'ticks', see above: 'Ticks'.
+
+  'SUBTREEEXPIRE' - This policy specifies that the mountpoint in question is
+     part of a larger sub-tree expiry.  
+
+
+Policy transitions
+------------------
+
+Certain rules need to apply when the policy for a mountpoint is changed.
+Following is a description of what occurs when a policy has changed for all
+possible transitions:
+
+NOEXPIRE -> EXPIRE
+  A mountpoint that was previously not marked for expiry is now marked for
+  expiry.  If the attribute value for 'ticks' is not a positive integer, then
+  this transition fails.  This transition also fails automatically for the
+  true-root of a namespace.
+
+NOEXPIRE -> SUBTREEEXPIRE
+  A mountpoint that was not previously set to expire will now expire as part of
+  it's parent expiry.  This transition fails if the policy of the immediate
+  parent mointpoint of the mountpoint in question is not either EXPIRE or
+  SUBTREEEXPIRE.
+
+EXPIRE -> NOEXPIRE
+  A mountpoint that was set to expire will no longer expire.  Any immediate
+  child mountpoints whose policy is SUBTREEEXPIRE transitions to NOEXPIRE, as
+  described below.
+
+EXPIRE -> SUBTREEEXPIRE
+  This is an invalid policy transition.  Instead, a transition from EXPIRE to 
+  NOEXPIRE followed by a transition from NOEXPIRE to SUBTREEEXPIRE should be
+  performed.
+
+SUBTREEEXPIRE -> NOEXPIRE
+  A mountpoint that was marked as being part of a sub-tree expiry no longer is
+  part of that expiry.  Any immediate child mountpoints of the mountpoint in
+  question that also have the SUBTREEEXPIRE policy will recursively receive an
+  implied SUBTREEEXPIRE -> NOEXPIRE transition.
+
+SUBTREEEXPIRE -> EXPIRE
+  This is an invalid policy transition.  Instead, a transition from
+  SUBTREEEXPIRE to NOEXPIRE followed by a transition from NOEXPIRE to EXPIRE
+  should be performed.
+
+Note: Transitions between SUBTREEXPIRE and EXPIRE are invalid in order to
+simplify the corner cases of a failed transition.  Transitioning to
+SUBTREEEXPIRE is the only path where things can actually fail (eg: parent
+mountpoint is NOEXPIRE), and trasitioning from EXPIRE may alter children
+mountpoints of the mountpoint in question.  This implied loss of information is
+more explicit when you must transition to NOEXPIRE as an intermediate.
+
+Mount Operations
+----------------
+
+The following are a list of mount operations that may occur along with a
+description of implied policy changes that may occur.
+
+
+Mount Move:
+
+  A mountpoint is moved from one location to another.  If the policy was: 
+
+  NOEXPIRE      - The policy remains NOEXPIRE
+  EXPIRE        - The policy remains EXPIRE
+  SUBTREEEXPIRE - The policy for the given mountpoint transitions to NOEXPIRE
+
+Mount Bind:
+
+  There are several variants on mount bind operations:
+    
+    - Single bind of from a mountpoint to another location.  Only one filesystem
+      is actually available in the new location after the bind. 
+    - Single bind of a directory (not a mountpoint) to another location.  This
+      is similar to the previous scenario however the root directory of the
+      new mountpoint is a sub-directory of the original mountpoint.  
+    - A recursive bind from a mountpoint to another location.
+    - A recursive bind from a directory that isn't a mountpoint to another
+      location.
+
+  In all cases, all newly created mountpoints are created with the NOEXPIRE
+  policy.  This allows a userspace application to arbitrarily determine what it
+  wishes to do with the expiry policy on the bind.
+
+Remount:
+
+  All filesystems remounts should not effect the expiry policy.  That is, the
+  policy and policy attributes should remain the same across a mountpoint
+  remount unless the policy itself was changed.
+
+Namespace Creation:
+  
+  When a namespace is created, it is derived from the parenting namespace.  A
+  namespace begins it's life as a complete clone and as such, any mountpoints in
+  that namespace should inherit the expiry policies set at the time of namespace
+  creation.
+
+Detaching Mountpoints (umount -l):
+  
+  Lazy unmounting is a particular case as the mointpoints in question are still
+  accessible, however not navigeable from the root directory.  Currently, when a
+  lazy unmount occurs on a sub-tree, all elements of that sub-tree are torn
+  apart and their resources freed once all references into that given mountpoint
+  are released.  In this case, all mountpoints should transition their expiry
+  policy to NOEXPIRE.
+
+  In a future case where a lazy unmount of a sub-tree does not result in the
+  sub-tree being torn apart (so that it may possibly be reattached elsewhere),
+  the root of this sub-tree's policy should transition as follows:
+    
+    - EXPIRE -> EXPIRE
+    - NOEXPIRE -> NOEXPIRE
+    - SUBTREEEXPIRE -> NOEXPIRE

