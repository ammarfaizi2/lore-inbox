Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTEUJ2a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 05:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbTEUJ2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 05:28:30 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:16555 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261825AbTEUJ2P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 05:28:15 -0400
Date: Wed, 21 May 2003 15:13:40 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       dipankar@in.ibm.com, Paul.McKenney@us.ibm.com
Subject: Re: [patch 1/2] vfsmount_lock
Message-ID: <20030521094340.GG1198@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20030521092502.GD1198@in.ibm.com> <20030521023523.655bc8f2.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030521023523.655bc8f2.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 02:35:23AM -0700, Andrew Morton wrote:
> >   	}
> >  -	return p;
> >  +	spin_lock(&vfsmount_lock);
> >  +	return found;
> >   }
> 
> err, how many times do you want to spin that lock?

sorry I didnot test the patches separately. Corrected patches follow


- Patch for replacing dcache_lock with new vfsmount_lock for all mount 
  related operation. This removes the need to take dcache_lock while
  doing follow_mount or follow_down operations in path walking.


 fs/namei.c     |   24 +++++++++------------
 fs/namespace.c |   64 ++++++++++++++++++++++++++++++++-------------------------
 2 files changed, 48 insertions(+), 40 deletions(-)

diff -puN fs/namespace.c~vfsmount_lock fs/namespace.c
--- linux-2.5.69/fs/namespace.c~vfsmount_lock	2003-05-21 10:53:00.000000000 +0530
+++ linux-2.5.69-maneesh/fs/namespace.c	2003-05-21 15:10:37.000000000 +0530
@@ -28,6 +28,8 @@ extern int do_remount_sb(struct super_bl
 extern int __init init_rootfs(void);
 extern int __init fs_subsys_init(void);
 
+/* spinlock for vfsmount related operation, inplace of dcache_lock */
+static spinlock_t vfsmount_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 static struct list_head *mount_hashtable;
 static int hash_mask, hash_bits;
 static kmem_cache_t *mnt_cache; 
@@ -69,30 +71,38 @@ void free_vfsmnt(struct vfsmount *mnt)
 	kmem_cache_free(mnt_cache, mnt);
 }
 
+/*
+ * Now, lookup_mnt increments the ref count before returning
+ * the vfsmount struct.
+ */
 struct vfsmount *lookup_mnt(struct vfsmount *mnt, struct dentry *dentry)
 {
 	struct list_head * head = mount_hashtable + hash(mnt, dentry);
 	struct list_head * tmp = head;
-	struct vfsmount *p;
+	struct vfsmount *p, *found = NULL;
 
+	spin_lock(&vfsmount_lock);
 	for (;;) {
 		tmp = tmp->next;
 		p = NULL;
 		if (tmp == head)
 			break;
 		p = list_entry(tmp, struct vfsmount, mnt_hash);
-		if (p->mnt_parent == mnt && p->mnt_mountpoint == dentry)
+		if (p->mnt_parent == mnt && p->mnt_mountpoint == dentry) {
+			found = mntget(p);
 			break;
+		}
 	}
-	return p;
+	spin_unlock(&vfsmount_lock);
+	return found;
 }
 
 static int check_mnt(struct vfsmount *mnt)
 {
-	spin_lock(&dcache_lock);
+	spin_lock(&vfsmount_lock);
 	while (mnt->mnt_parent != mnt)
 		mnt = mnt->mnt_parent;
-	spin_unlock(&dcache_lock);
+	spin_unlock(&vfsmount_lock);
 	return mnt == current->namespace->root;
 }
 
@@ -273,15 +283,15 @@ void umount_tree(struct vfsmount *mnt)
 		mnt = list_entry(kill.next, struct vfsmount, mnt_list);
 		list_del_init(&mnt->mnt_list);
 		if (mnt->mnt_parent == mnt) {
-			spin_unlock(&dcache_lock);
+			spin_unlock(&vfsmount_lock);
 		} else {
 			struct nameidata old_nd;
 			detach_mnt(mnt, &old_nd);
-			spin_unlock(&dcache_lock);
+			spin_unlock(&vfsmount_lock);
 			path_release(&old_nd);
 		}
 		mntput(mnt);
-		spin_lock(&dcache_lock);
+		spin_lock(&vfsmount_lock);
 	}
 }
 
@@ -334,17 +344,17 @@ static int do_umount(struct vfsmount *mn
 	}
 
 	down_write(&current->namespace->sem);
-	spin_lock(&dcache_lock);
+	spin_lock(&vfsmount_lock);
 
 	if (atomic_read(&sb->s_active) == 1) {
 		/* last instance - try to be smart */
-		spin_unlock(&dcache_lock);
+		spin_unlock(&vfsmount_lock);
 		lock_kernel();
 		DQUOT_OFF(sb);
 		acct_auto_close(sb);
 		unlock_kernel();
 		security_sb_umount_close(mnt);
-		spin_lock(&dcache_lock);
+		spin_lock(&vfsmount_lock);
 	}
 	retval = -EBUSY;
 	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH) {
@@ -352,7 +362,7 @@ static int do_umount(struct vfsmount *mn
 			umount_tree(mnt);
 		retval = 0;
 	}
-	spin_unlock(&dcache_lock);
+	spin_unlock(&vfsmount_lock);
 	if (retval)
 		security_sb_umount_busy(mnt);
 	up_write(&current->namespace->sem);
@@ -442,17 +452,17 @@ static struct vfsmount *copy_tree(struct
 		q = clone_mnt(p, p->mnt_root);
 		if (!q)
 			goto Enomem;
-		spin_lock(&dcache_lock);
+		spin_lock(&vfsmount_lock);
 		list_add_tail(&q->mnt_list, &res->mnt_list);
 		attach_mnt(q, &nd);
-		spin_unlock(&dcache_lock);
+		spin_unlock(&vfsmount_lock);
 	}
 	return res;
 Enomem:
 	if (res) {
-		spin_lock(&dcache_lock);
+		spin_lock(&vfsmount_lock);
 		umount_tree(res);
-		spin_unlock(&dcache_lock);
+		spin_unlock(&vfsmount_lock);
 	}
 	return NULL;
 }
@@ -476,7 +486,7 @@ static int graft_tree(struct vfsmount *m
 	if (err)
 		goto out_unlock;
 
-	spin_lock(&dcache_lock);
+	spin_lock(&vfsmount_lock);
 	if (IS_ROOT(nd->dentry) || !d_unhashed(nd->dentry)) {
 		struct list_head head;
 		attach_mnt(mnt, nd);
@@ -485,7 +495,7 @@ static int graft_tree(struct vfsmount *m
 		mntget(mnt);
 		err = 0;
 	}
-	spin_unlock(&dcache_lock);
+	spin_unlock(&vfsmount_lock);
 out_unlock:
 	up(&nd->dentry->d_inode->i_sem);
 	if (!err)
@@ -522,9 +532,9 @@ static int do_loopback(struct nameidata 
 	if (mnt) {
 		err = graft_tree(mnt, nd);
 		if (err) {
-			spin_lock(&dcache_lock);
+			spin_lock(&vfsmount_lock);
 			umount_tree(mnt);
-			spin_unlock(&dcache_lock);
+			spin_unlock(&vfsmount_lock);
 		} else
 			mntput(mnt);
 	}
@@ -589,7 +599,7 @@ static int do_move_mount(struct nameidat
 	if (IS_DEADDIR(nd->dentry->d_inode))
 		goto out1;
 
-	spin_lock(&dcache_lock);
+	spin_lock(&vfsmount_lock);
 	if (!IS_ROOT(nd->dentry) && d_unhashed(nd->dentry))
 		goto out2;
 
@@ -613,7 +623,7 @@ static int do_move_mount(struct nameidat
 	detach_mnt(old_nd.mnt, &parent_nd);
 	attach_mnt(old_nd.mnt, nd);
 out2:
-	spin_unlock(&dcache_lock);
+	spin_unlock(&vfsmount_lock);
 out1:
 	up(&nd->dentry->d_inode->i_sem);
 out:
@@ -794,9 +804,9 @@ int copy_namespace(int flags, struct tas
 	down_write(&tsk->namespace->sem);
 	/* First pass: copy the tree topology */
 	new_ns->root = copy_tree(namespace->root, namespace->root->mnt_root);
-	spin_lock(&dcache_lock);
+	spin_lock(&vfsmount_lock);
 	list_add_tail(&new_ns->list, &new_ns->root->mnt_list);
-	spin_unlock(&dcache_lock);
+	spin_unlock(&vfsmount_lock);
 
 	/* Second pass: switch the tsk->fs->* elements */
 	if (fs) {
@@ -1017,7 +1027,7 @@ asmlinkage long sys_pivot_root(const cha
 	if (new_nd.mnt->mnt_root != new_nd.dentry)
 		goto out2; /* not a mountpoint */
 	tmp = old_nd.mnt; /* make sure we can reach put_old from new_root */
-	spin_lock(&dcache_lock);
+	spin_lock(&vfsmount_lock);
 	if (tmp != new_nd.mnt) {
 		for (;;) {
 			if (tmp->mnt_parent == tmp)
@@ -1034,7 +1044,7 @@ asmlinkage long sys_pivot_root(const cha
 	detach_mnt(user_nd.mnt, &root_parent);
 	attach_mnt(user_nd.mnt, &old_nd);
 	attach_mnt(new_nd.mnt, &root_parent);
-	spin_unlock(&dcache_lock);
+	spin_unlock(&vfsmount_lock);
 	chroot_fs_refs(&user_nd, &new_nd);
 	security_sb_post_pivotroot(&user_nd, &new_nd);
 	error = 0;
@@ -1051,7 +1061,7 @@ out0:
 	unlock_kernel();
 	return error;
 out3:
-	spin_unlock(&dcache_lock);
+	spin_unlock(&vfsmount_lock);
 	goto out2;
 }
 
diff -puN fs/namei.c~vfsmount_lock fs/namei.c
--- linux-2.5.69/fs/namei.c~vfsmount_lock	2003-05-21 10:53:00.000000000 +0530
+++ linux-2.5.69-maneesh/fs/namei.c	2003-05-21 10:53:00.000000000 +0530
@@ -434,19 +434,17 @@ int follow_up(struct vfsmount **mnt, str
 	return 1;
 }
 
+/* no need for dcache_lock, as serialization is taken care in
+ * namespace.c
+ */
 static int follow_mount(struct vfsmount **mnt, struct dentry **dentry)
 {
 	int res = 0;
 	while (d_mountpoint(*dentry)) {
-		struct vfsmount *mounted;
-		spin_lock(&dcache_lock);
-		mounted = lookup_mnt(*mnt, *dentry);
-		if (!mounted) {
-			spin_unlock(&dcache_lock);
+		struct vfsmount *mounted = lookup_mnt(*mnt, *dentry);
+		if (!mounted) 
 			break;
-		}
-		*mnt = mntget(mounted);
-		spin_unlock(&dcache_lock);
+		*mnt = mounted;
 		dput(*dentry);
 		mntput(mounted->mnt_parent);
 		*dentry = dget(mounted->mnt_root);
@@ -455,21 +453,21 @@ static int follow_mount(struct vfsmount 
 	return res;
 }
 
+/* no need for dcache_lock, as serialization is taken care in
+ * namespace.c
+ */
 static inline int __follow_down(struct vfsmount **mnt, struct dentry **dentry)
 {
 	struct vfsmount *mounted;
-
-	spin_lock(&dcache_lock);
+	
 	mounted = lookup_mnt(*mnt, *dentry);
 	if (mounted) {
-		*mnt = mntget(mounted);
-		spin_unlock(&dcache_lock);
+		*mnt = mounted;
 		dput(*dentry);
 		mntput(mounted->mnt_parent);
 		*dentry = dget(mounted->mnt_root);
 		return 1;
 	}
-	spin_unlock(&dcache_lock);
 	return 0;
 }
 

_
 

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
