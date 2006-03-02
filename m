Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWCBG6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWCBG6f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 01:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWCBG6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 01:58:35 -0500
Received: from ns.suse.de ([195.135.220.2]:41138 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750811AbWCBG6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 01:58:35 -0500
From: Neil Brown <neilb@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Olaf Hering <olh@suse.de>, Jan Blunck <jblunck@suse.de>,
       Kirill Korotaev <dev@openvz.org>
Date: Thu, 2 Mar 2006 17:57:33 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17414.38749.886125.282255@cse.unsw.edu.au>
Cc: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,
 This mail relates to the thread with the same subject which can be
 found at

    http://lkml.org/lkml/2006/1/16/279

 I would like to propose an alternate patch for the problem.

 The core problem is that:
   prune_one_dentry can hold a reference to a dentry without any
     lock being held, and without any other reference to the
     filesystem (if it is being called from shrink_dcache_memory).
     It holds this reference while calling iput on an inode.  This can
     take an arbitrarily long time to complete, especially if NFS
     needs to wait for some RPCs to complete or timeout.

   shrink_dcache_parent skips over dentries which have a reference,
     such as the one held by prune_one_dentry.

   Thus umount can find that an inode is still in use (by it's dentry
   which was skipped) and will complain.  Worse, when the nfs request
   on some inode finally completes, it might find the superblock
   doesn't exist any more and... oops.

  My proposed solution to the problem is never to expose the reference
  held by prune_one_dentry.  i.e. keep the spin_lock held.

  This requires:
  - Breaking dentry_iput into 2 pieces, one that happens while the
    dcache locks are held, and one that happens unlocked.
  - Also, dput needs a variant which can be called with the spinlocks
    held.
  - This also requires a suitable comment in the code.

    It is possible that the dentry_iput call in dput might need to be
    split into the locked/unlocked portions as well.  That would
    require collecting a list of inodes and dentries to be freed once
    the lock is dropped, which would be ugly.
    An alternative might be to skip the tail recursion when
    dput_locked was called as I *think* it is just an optimisation.


 The following patch addressed the first three points.

Comments?  Please :-?

NeilBrown


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/dcache.c |  105 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 81 insertions(+), 24 deletions(-)

diff ./fs/dcache.c~current~ ./fs/dcache.c
--- ./fs/dcache.c~current~	2006-03-02 17:14:24.000000000 +1100
+++ ./fs/dcache.c	2006-03-02 17:55:08.000000000 +1100
@@ -94,24 +94,36 @@ static void d_free(struct dentry *dentry
  * d_iput() operation if defined.
  * Called with dcache_lock and per dentry lock held, drops both.
  */
-static void dentry_iput(struct dentry * dentry)
+static inline struct inode *dentry_iput_locked(struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
 	if (inode) {
 		dentry->d_inode = NULL;
 		list_del_init(&dentry->d_alias);
-		spin_unlock(&dentry->d_lock);
-		spin_unlock(&dcache_lock);
-		if (!inode->i_nlink)
-			fsnotify_inoderemove(inode);
-		if (dentry->d_op && dentry->d_op->d_iput)
-			dentry->d_op->d_iput(dentry, inode);
-		else
-			iput(inode);
-	} else {
-		spin_unlock(&dentry->d_lock);
-		spin_unlock(&dcache_lock);
 	}
+	return inode;
+}
+
+static inline void dentry_iput_unlocked(struct dentry *dentry,
+					struct inode *inode)
+{
+	if (!inode)
+		return;
+	if (!inode->i_nlink)
+		fsnotify_inoderemove(inode);
+	if (dentry->d_op && dentry->d_op->d_iput)
+		dentry->d_op->d_iput(dentry, inode);
+	else
+		iput(inode);
+}
+
+static void dentry_iput(struct dentry * dentry)
+{
+	struct inode *inode = dentry_iput_locked(dentry);
+
+	spin_unlock(&dentry->d_lock);
+	spin_unlock(&dcache_lock);
+	dentry_iput_unlocked(dentry, inode);
 }
 
 /* 
@@ -143,18 +155,10 @@ static void dentry_iput(struct dentry * 
  * no dcache lock, please.
  */
 
-void dput(struct dentry *dentry)
+static void __dput_locked(struct dentry *dentry)
 {
-	if (!dentry)
-		return;
 
 repeat:
-	if (atomic_read(&dentry->d_count) == 1)
-		might_sleep();
-	if (!atomic_dec_and_lock(&dentry->d_count, &dcache_lock))
-		return;
-
-	spin_lock(&dentry->d_lock);
 	if (atomic_read(&dentry->d_count)) {
 		spin_unlock(&dentry->d_lock);
 		spin_unlock(&dcache_lock);
@@ -202,10 +206,43 @@ kill_it: {
 		if (dentry == parent)
 			return;
 		dentry = parent;
+
+		if (atomic_read(&dentry->d_count) == 1)
+			might_sleep();
+		if (!atomic_dec_and_lock(&dentry->d_count, &dcache_lock))
+			return;
+
+		spin_lock(&dentry->d_lock);
 		goto repeat;
 	}
 }
 
+void dput(struct dentry *dentry)
+{
+	if (!dentry)
+		return;
+	if (atomic_read(&dentry->d_count) == 1)
+		might_sleep();
+	if (!atomic_dec_and_lock(&dentry->d_count, &dcache_lock))
+		return;
+
+	spin_lock(&dentry->d_lock);
+
+	__dput_locked(dentry);
+}
+
+void dput_locked(struct dentry *dentry)
+{
+	if (!dentry)
+		return;
+	if (!atomic_dec_and_test(&dentry->d_count)) {
+ 		spin_unlock(&dentry->d_lock);
+ 		spin_unlock(&dcache_lock);
+		return;
+	}
+	__dput_locked(dentry);
+}
+
 /**
  * d_invalidate - invalidate a dentry
  * @dentry: dentry to invalidate
@@ -361,19 +398,39 @@ restart:
  * This requires that the LRU list has already been
  * removed.
  * Called with dcache_lock, drops it and then regains.
+ *
+ * There was a risk of this function, called from shrink_dache_memory,
+ * racing with select_dcache_parent called from generic_shutdown_super.
+ * This function was holding a reference to the parent after the child
+ * has been removed, and this wasn't protected by any spinlock.
+ * select_dcache_parent would think the dentry was in use, and so it would
+ * not get discarded.  This would result in a very unclean unmount.
+ * So we need to keep the spin_lock while ever we hold a reference to
+ * a dentry.  This (hopefully) explains the two-stage
+ * dentry_iput, and the need for dput_locked.
+ * Note: the race was easiest to hit if iput was very slow, as
+ * it could be when tearing down a large address space, or waiting
+ * for pending network requests to return/timeout.
  */
 static inline void prune_one_dentry(struct dentry * dentry)
 {
 	struct dentry * parent;
+	struct inode * ino;
 
 	__d_drop(dentry);
 	list_del(&dentry->d_u.d_child);
 	dentry_stat.nr_dentry--;	/* For d_free, below */
-	dentry_iput(dentry);
+	ino = dentry_iput_locked(dentry);
 	parent = dentry->d_parent;
-	d_free(dentry);
 	if (parent != dentry)
-		dput(parent);
+		dput_locked(parent);
+	else {
+		spin_unlock(&dentry->d_lock);
+		spin_unlock(&dcache_lock);
+	}
+	dentry_iput_unlocked(dentry, ino);
+	d_free(dentry);
+
 	spin_lock(&dcache_lock);
 }
 
