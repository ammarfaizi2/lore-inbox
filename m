Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315216AbSD2WSv>; Mon, 29 Apr 2002 18:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315221AbSD2WSu>; Mon, 29 Apr 2002 18:18:50 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:20419 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315216AbSD2WSp>;
	Mon, 29 Apr 2002 18:18:45 -0400
Date: Mon, 29 Apr 2002 18:18:44 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Hanna V Linder <hannal@us.ibm.com>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: [CFT][PATCH] Re: 2.5.11 breakage
In-Reply-To: <390625259.1020069198@[10.10.2.2]>
Message-ID: <Pine.GSO.4.21.0204291806280.5397-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	OK, here comes.  Patch below is an attempt to do the fastwalk
stuff in right way and so far it seems to be working.

	Differences from Hanna's stuff:

*	dentry leak is plugged
*	locked/unlocked state of nameidata doesn't depend on history - it
	depends only on point in code.
*	LOOKUP_LOCKED is gone.
*	following mounts and .. doesn't drop dcache_lock
*	light-weight permission check distinguishes between "don't know" and
	"permission denied", so we don't call full-blown permission() unless
	we have to.
*	code that changes root/pwd holds dcache_lock _and_ write lock on
	current->fs->lock.  I.e. if we hold dcache_lock we can safely
	access our ->fs->{root,pwd}{,mnt}
*	__d_lookup() does not increment refcount; callers do dget_locked()
	if they need it (behaviour of d_lookup() didn't change, obviously).
*	link_path_walk() logics had been (somewhat) cleaned up.

	Comments/questions/testing are welcome.  Patch is trivially
backportable to 2.4, BTW.  Patch is against vanilla 2.5.11.

diff -urN C11/fs/dcache.c C11-current/fs/dcache.c
--- C11/fs/dcache.c	Mon Apr 29 08:03:36 2002
+++ C11-current/fs/dcache.c	Mon Apr 29 10:24:35 2002
@@ -849,6 +849,8 @@
 	struct dentry * dentry;
 	spin_lock(&dcache_lock);
 	dentry = __d_lookup(parent,name);
+	if (dentry)
+		__dget_locked(dentry);
 	spin_unlock(&dcache_lock);
 	return dentry;
 }
@@ -881,7 +883,6 @@
 			if (memcmp(dentry->d_name.name, str, len))
 				continue;
 		}
-		__dget_locked(dentry);
 		dentry->d_vfs_flags |= DCACHE_REFERENCED;
 		return dentry;
 	}
diff -urN C11/fs/namei.c C11-current/fs/namei.c
--- C11/fs/namei.c	Mon Apr 29 08:03:36 2002
+++ C11-current/fs/namei.c	Mon Apr 29 16:20:27 2002
@@ -279,36 +279,24 @@
 }
 
 /*for fastwalking*/
-static inline void undo_locked(struct nameidata *nd)
+static inline void unlock_nd(struct nameidata *nd)
 {
-	if(nd->flags & LOOKUP_LOCKED){
-		dget_locked(nd->dentry);
-		mntget(nd->mnt);
-		spin_unlock(&dcache_lock);
-		nd->flags &= ~LOOKUP_LOCKED;
-	}
+	struct vfsmount *mnt = nd->old_mnt;
+	struct dentry *dentry = nd->old_dentry;
+	mntget(nd->mnt);
+	dget_locked(nd->dentry);
+	nd->old_mnt = NULL;
+	nd->old_dentry = NULL;
+	spin_unlock(&dcache_lock);
+	dput(dentry);
+	mntput(mnt);
 }
 
-/*
- * For fast path lookup while holding the dcache_lock. 
- * SMP-safe
- */
-static struct dentry * cached_lookup_nd(struct nameidata * nd, struct qstr * name, int flags)
+static inline void lock_nd(struct nameidata *nd)
 {
-	struct dentry * dentry = NULL;
-	if(!(nd->flags & LOOKUP_LOCKED))
-		return cached_lookup(nd->dentry, name, flags);
-	
-	dentry = __d_lookup(nd->dentry, name);
-	
-	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
-		undo_locked(nd);
-		if (!dentry->d_op->d_revalidate(dentry, flags) && !d_invalidate(dentry)) {
-			dput(dentry);
-			dentry = NULL;
-		}
-	}
-	return dentry;
+	spin_lock(&dcache_lock);
+	nd->old_mnt = nd->mnt;
+	nd->old_dentry = nd->dentry;
 }
 
 /*
@@ -326,7 +314,7 @@
 	umode_t	mode = inode->i_mode;
 
 	if ((inode->i_op && inode->i_op->permission))
-		return -EACCES;
+		return -EAGAIN;
 
 	if (current->fsuid == inode->i_uid)
 		mode >>= 6;
@@ -418,10 +406,10 @@
 	return -ELOOP;
 }
 
-static inline int __follow_up(struct vfsmount **mnt, struct dentry **base)
+int follow_up(struct vfsmount **mnt, struct dentry **dentry)
 {
 	struct vfsmount *parent;
-	struct dentry *dentry;
+	struct dentry *mountpoint;
 	spin_lock(&dcache_lock);
 	parent=(*mnt)->mnt_parent;
 	if (parent == *mnt) {
@@ -429,18 +417,27 @@
 		return 0;
 	}
 	mntget(parent);
-	dentry=dget((*mnt)->mnt_mountpoint);
+	mountpoint=dget((*mnt)->mnt_mountpoint);
 	spin_unlock(&dcache_lock);
-	dput(*base);
-	*base = dentry;
+	dput(*dentry);
+	*dentry = mountpoint;
 	mntput(*mnt);
 	*mnt = parent;
 	return 1;
 }
 
-int follow_up(struct vfsmount **mnt, struct dentry **dentry)
+static int follow_mount(struct vfsmount **mnt, struct dentry **dentry)
 {
-	return __follow_up(mnt, dentry);
+	int res = 0;
+	while (d_mountpoint(*dentry)) {
+		struct vfsmount *mounted = lookup_mnt(*mnt, *dentry);
+		if (!mounted)
+			break;
+		*mnt = mounted;
+		*dentry = mounted->mnt_root;
+		res = 1;
+	}
+	return res;
 }
 
 static inline int __follow_down(struct vfsmount **mnt, struct dentry **dentry)
@@ -466,41 +463,83 @@
 	return __follow_down(mnt,dentry);
 }
  
-static inline void follow_dotdot(struct nameidata *nd)
+static inline void follow_dotdot(struct vfsmount **mnt, struct dentry **dentry)
 {
 	while(1) {
 		struct vfsmount *parent;
-		struct dentry *dentry;
-		read_lock(&current->fs->lock);
-		if (nd->dentry == current->fs->root &&
-		    nd->mnt == current->fs->rootmnt)  {
-			read_unlock(&current->fs->lock);
+		if (*dentry == current->fs->root &&
+		    *mnt == current->fs->rootmnt)
 			break;
-		}
-		read_unlock(&current->fs->lock);
-		spin_lock(&dcache_lock);
-		if (nd->dentry != nd->mnt->mnt_root) {
-			dentry = dget(nd->dentry->d_parent);
-			spin_unlock(&dcache_lock);
-			dput(nd->dentry);
-			nd->dentry = dentry;
+		if (*dentry != (*mnt)->mnt_root) {
+			*dentry = (*dentry)->d_parent;
 			break;
 		}
-		parent=nd->mnt->mnt_parent;
-		if (parent == nd->mnt) {
-			spin_unlock(&dcache_lock);
+		parent=(*mnt)->mnt_parent;
+		if (parent == *mnt)
 			break;
-		}
-		mntget(parent);
-		dentry=dget(nd->mnt->mnt_mountpoint);
-		spin_unlock(&dcache_lock);
-		dput(nd->dentry);
-		nd->dentry = dentry;
-		mntput(nd->mnt);
-		nd->mnt = parent;
+		*dentry=(*mnt)->mnt_mountpoint;
+		*mnt = parent;
 	}
-	while (d_mountpoint(nd->dentry) && __follow_down(&nd->mnt, &nd->dentry))
-		;
+	follow_mount(mnt, dentry);
+}
+
+struct path {
+	struct vfsmount *mnt;
+	struct dentry *dentry;
+};
+
+/*
+ *  It's more convoluted than I'd like it to be, but... it's still fairly
+ *  small and for now I'd prefer to have fast path as straight as possible.
+ *  It _is_ time-critical.
+ */
+static int do_lookup(struct nameidata *nd, struct qstr *name,
+		     struct path *path, struct path *cached_path,
+		     int flags)
+{
+	struct vfsmount *mnt = nd->mnt;
+	struct dentry *dentry = __d_lookup(nd->dentry, name);
+
+	if (!dentry)
+		goto dcache_miss;
+	if (dentry->d_op && dentry->d_op->d_revalidate)
+		goto need_revalidate;
+done:
+	path->mnt = mnt;
+	path->dentry = dentry;
+	return 0;
+
+dcache_miss:
+	unlock_nd(nd);
+
+need_lookup:
+	dentry = real_lookup(nd->dentry, name, LOOKUP_CONTINUE);
+	if (IS_ERR(dentry))
+		goto fail;
+	mntget(mnt);
+relock:
+	dput(cached_path->dentry);
+	mntput(cached_path->mnt);
+	cached_path->mnt = mnt;
+	cached_path->dentry = dentry;
+	lock_nd(nd);
+	goto done;
+
+need_revalidate:
+	mntget(mnt);
+	dget_locked(dentry);
+	unlock_nd(nd);
+	if (dentry->d_op->d_revalidate(dentry, flags))
+		goto relock;
+	if (d_invalidate(dentry))
+		goto relock;
+	dput(dentry);
+	mntput(mnt);
+	goto need_lookup;
+
+fail:
+	lock_nd(nd);
+	return PTR_ERR(dentry);
 }
 
 /*
@@ -513,11 +552,11 @@
  */
 int link_path_walk(const char * name, struct nameidata *nd)
 {
-	struct dentry *dentry;
+	struct path next, pinned = {NULL, NULL};
 	struct inode *inode;
 	int err;
 	unsigned int lookup_flags = nd->flags;
-
+	
 	while (*name=='/')
 		name++;
 	if (!*name)
@@ -534,11 +573,11 @@
 		unsigned int c;
 
 		err = exec_permission_lite(inode);
-		if(err){
-			undo_locked(nd);
+		if (err == -EAGAIN) {
+			unlock_nd(nd);
 			err = permission(inode, MAY_EXEC);
+			lock_nd(nd);
 		}
-		dentry = ERR_PTR(err);
  		if (err)
 			break;
 
@@ -572,8 +611,7 @@
 			case 2:	
 				if (this.name[1] != '.')
 					break;
-				undo_locked(nd);
-				follow_dotdot(nd);
+				follow_dotdot(&nd->mnt, &nd->dentry);
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
 			case 1:
@@ -589,35 +627,30 @@
 				break;
 		}
 		/* This does the actual lookups.. */
-		dentry = cached_lookup_nd(nd, &this, LOOKUP_CONTINUE);
-		if (!dentry) {
-			undo_locked(nd);
-			dentry = real_lookup(nd->dentry, &this, LOOKUP_CONTINUE);
-			err = PTR_ERR(dentry);
-			if (IS_ERR(dentry))
-				break;
-		}
+		err = do_lookup(nd, &this, &next, &pinned, LOOKUP_CONTINUE);
+		if (err)
+			break;
 		/* Check mountpoints.. */
-		if(d_mountpoint(dentry)){
-			undo_locked(nd);
-			while (d_mountpoint(dentry) && __follow_down(&nd->mnt, &dentry))
-				;
-		}
+		follow_mount(&next.mnt, &next.dentry);
 
 		err = -ENOENT;
-		inode = dentry->d_inode;
+		inode = next.dentry->d_inode;
 		if (!inode)
-			goto out_dput;
+			break;
 		err = -ENOTDIR; 
 		if (!inode->i_op)
-			goto out_dput;
+			break;
 
 		if (inode->i_op->follow_link) {
-			undo_locked(nd);
-			err = do_follow_link(dentry, nd);
-			dput(dentry);
+			mntget(next.mnt);
+			dget_locked(next.dentry);
+			unlock_nd(nd);
+			err = do_follow_link(next.dentry, nd);
+			dput(next.dentry);
+			mntput(next.mnt);
 			if (err)
 				goto return_err;
+			lock_nd(nd);
 			err = -ENOENT;
 			inode = nd->dentry->d_inode;
 			if (!inode)
@@ -626,9 +659,8 @@
 			if (!inode->i_op)
 				break;
 		} else {
-			if (!(nd->flags & LOOKUP_LOCKED))
-				dput(nd->dentry);
-			nd->dentry = dentry;
+			nd->mnt = next.mnt;
+			nd->dentry = next.dentry;
 		}
 		err = -ENOTDIR; 
 		if (!inode->i_op->lookup)
@@ -647,8 +679,7 @@
 			case 2:	
 				if (this.name[1] != '.')
 					break;
-				undo_locked(nd);
-				follow_dotdot(nd);
+				follow_dotdot(&nd->mnt, &nd->dentry);
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
 			case 1:
@@ -659,27 +690,26 @@
 			if (err < 0)
 				break;
 		}
-		dentry = cached_lookup_nd(nd, &this, 0);
-		undo_locked(nd); 
-		if (!dentry) {
-			dentry = real_lookup(nd->dentry, &this, 0);
-			err = PTR_ERR(dentry);
-			if (IS_ERR(dentry))
-				break;
-		}
-		while (d_mountpoint(dentry) && __follow_down(&nd->mnt, &dentry))
-			;
-		inode = dentry->d_inode;
+		err = do_lookup(nd, &this, &next, &pinned, 0);
+		if (err)
+			break;
+		follow_mount(&next.mnt, &next.dentry);
+		inode = next.dentry->d_inode;
 		if ((lookup_flags & LOOKUP_FOLLOW)
 		    && inode && inode->i_op && inode->i_op->follow_link) {
-			err = do_follow_link(dentry, nd);
-			dput(dentry);
+			mntget(next.mnt);
+			dget_locked(next.dentry);
+			unlock_nd(nd);
+			err = do_follow_link(next.dentry, nd);
+			dput(next.dentry);
+			mntput(next.mnt);
 			if (err)
 				goto return_err;
 			inode = nd->dentry->d_inode;
+			lock_nd(nd);
 		} else {
-			dput(nd->dentry);
-			nd->dentry = dentry;
+			nd->mnt = next.mnt;
+			nd->dentry = next.dentry;
 		}
 		err = -ENOENT;
 		if (!inode)
@@ -700,22 +730,23 @@
 		else if (this.len == 2 && this.name[1] == '.')
 			nd->last_type = LAST_DOTDOT;
 return_base:
-		undo_locked(nd);
+		unlock_nd(nd);
+		dput(pinned.dentry);
+		mntput(pinned.mnt);
 		return 0;
-out_dput:
-		undo_locked(nd);
-		dput(dentry);
-		break;
 	}
-	undo_locked(nd);
+	unlock_nd(nd);
 	path_release(nd);
 return_err:
+	dput(pinned.dentry);
+	mntput(pinned.mnt);
 	return err;
 }
 
 int path_walk(const char * name, struct nameidata *nd)
 {
 	current->total_link_count = 0;
+	lock_nd(nd);
 	return link_path_walk(name, nd);
 }
 
@@ -803,6 +834,8 @@
 int path_init(const char *name, unsigned int flags, struct nameidata *nd)
 {
 	nd->last_type = LAST_ROOT; /* if there are only slashes... */
+	nd->old_mnt = NULL;
+	nd->old_dentry = NULL;
 	nd->flags = flags;
 	if (*name=='/')
 		return walk_init_root(name,nd);
@@ -817,7 +850,7 @@
 {
 	nd->last_type = LAST_ROOT; /* if there are only slashes... */
 	nd->flags = flags;
-	if (*name=='/'){
+	if (*name=='/') {
 		read_lock(&current->fs->lock);
 		if (current->fs->altroot && !(nd->flags & LOOKUP_NOALT)) {
 			nd->mnt = mntget(current->fs->altrootmnt);
@@ -827,20 +860,20 @@
 				return 0;
 			read_lock(&current->fs->lock);
 		}
-		spin_lock(&dcache_lock); /*to avoid cacheline bouncing with d_count*/
+		read_unlock(&current->fs->lock);
+		spin_lock(&dcache_lock);
 		nd->mnt = current->fs->rootmnt;
 		nd->dentry = current->fs->root;
-		read_unlock(&current->fs->lock);
 	}
 	else{
-		read_lock(&current->fs->lock);
 		spin_lock(&dcache_lock);
 		nd->mnt = current->fs->pwdmnt;
 		nd->dentry = current->fs->pwd;
-		read_unlock(&current->fs->lock);
 	}
-	nd->flags |= LOOKUP_LOCKED;
-	return (path_walk(name, nd));
+	nd->old_mnt = NULL;
+	nd->old_dentry = NULL;
+	current->total_link_count = 0;
+	return link_path_walk(name, nd);
 }
 
 /*
@@ -2029,6 +2062,7 @@
 			/* weird __emul_prefix() stuff did it */
 			goto out;
 	}
+	lock_nd(nd);
 	res = link_path_walk(link, nd);
 out:
 	if (current->link_count || res || nd->last_type!=LAST_NORM)
diff -urN C11/include/linux/fs.h C11-current/include/linux/fs.h
--- C11/include/linux/fs.h	Mon Apr 29 08:03:37 2002
+++ C11-current/include/linux/fs.h	Mon Apr 29 16:03:36 2002
@@ -654,6 +654,8 @@
 	struct qstr last;
 	unsigned int flags;
 	int last_type;
+	struct dentry *old_dentry;
+	struct vfsmount *old_mnt;
 };
 
 #define DQUOT_USR_ENABLED	0x01		/* User diskquotas enabled */
@@ -1395,7 +1397,6 @@
 #define LOOKUP_CONTINUE		(4)
 #define LOOKUP_PARENT		(16)
 #define LOOKUP_NOALT		(32)
-#define LOOKUP_LOCKED		(64)
 
 /*
  * Type of the last component on LOOKUP_PARENT
diff -urN C11/include/linux/fs_struct.h C11-current/include/linux/fs_struct.h
--- C11/include/linux/fs_struct.h	Mon Feb 25 21:12:16 2002
+++ C11-current/include/linux/fs_struct.h	Mon Apr 29 16:03:36 2002
@@ -35,10 +35,12 @@
 	struct dentry *old_root;
 	struct vfsmount *old_rootmnt;
 	write_lock(&fs->lock);
+	spin_lock(&dcache_lock);
 	old_root = fs->root;
 	old_rootmnt = fs->rootmnt;
 	fs->rootmnt = mntget(mnt);
 	fs->root = dget(dentry);
+	spin_unlock(&dcache_lock);
 	write_unlock(&fs->lock);
 	if (old_root) {
 		dput(old_root);
@@ -58,10 +60,12 @@
 	struct dentry *old_pwd;
 	struct vfsmount *old_pwdmnt;
 	write_lock(&fs->lock);
+	spin_lock(&dcache_lock);
 	old_pwd = fs->pwd;
 	old_pwdmnt = fs->pwdmnt;
 	fs->pwdmnt = mntget(mnt);
 	fs->pwd = dget(dentry);
+	spin_unlock(&dcache_lock);
 	write_unlock(&fs->lock);
 	if (old_pwd) {
 		dput(old_pwd);


