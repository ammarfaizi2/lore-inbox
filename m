Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315239AbSEIXvQ>; Thu, 9 May 2002 19:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315241AbSEIXvP>; Thu, 9 May 2002 19:51:15 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:57311 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315239AbSEIXvD>; Thu, 9 May 2002 19:51:03 -0400
Date: Thu, 09 May 2002 16:52:13 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: alan@lxorguk.ukuu.org.uk, viro@math.psu.edu
cc: linux-kernel@vger.kernel.org, hannal@us.ibm.com
Subject: [PATCH 2.4.19-pre8] FastWalk Dcache back port from 2.5
Message-ID: <16290000.1020988333@w-hlinder.des>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

	Please consider this new and improved fast walk patch for
inclusion in your 2.4.19 tree. This patch reduces cacheline bouncing 
due to numerous atomic increments and decrements of the d_count 
reference counter during path walking by holding the dcache_lock
as long as the dentries are in the cache. 
	Linus included my original patch in 2.5.11. Al Viro made a 
few great changes in 2.5.12 and Paul Menage added one fix. The following
patch includes their changes as well. This code has been in 2.5 for 
almost 3 weeks and appears to be quite stable. In addition it shows a 
throughput improvement while running dbench on an 8-way. Here is the output:

http://west.dl.sourceforge.net/sourceforge/lse/2419fw.png

Hanna Linder
hannal@us.ibm.com
IBM Linux Technology Center

Patch is also available at:
http://west.dl.sourceforge.net/sourceforge/lse/fast_walkA3-2.4.19-pre8.patch

---------
diff -Nru -X dontdiff linux-2.4.19-pre8/fs/dcache.c linux-fastwalk/fs/dcache.c
--- linux-2.4.19-pre8/fs/dcache.c	Thu May  9 11:03:46 2002
+++ linux-fastwalk/fs/dcache.c	Thu May  9 14:13:16 2002
@@ -702,13 +702,25 @@
  
 struct dentry * d_lookup(struct dentry * parent, struct qstr * name)
 {
+	struct dentry *dentry = NULL;
+
+	spin_lock(&dcache_lock);
+	dentry = __d_lookup(parent,name);
+	if (dentry)
+		__dget_locked(dentry);
+	spin_unlock(&dcache_lock);
+	return dentry;
+}
+
+struct dentry * __d_lookup(struct dentry * parent, struct qstr * name)  
+{
+
 	unsigned int len = name->len;
 	unsigned int hash = name->hash;
 	const unsigned char *str = name->name;
 	struct list_head *head = d_hash(parent,hash);
 	struct list_head *tmp;
 
-	spin_lock(&dcache_lock);
 	tmp = head->next;
 	for (;;) {
 		struct dentry * dentry = list_entry(tmp, struct dentry, d_hash);
@@ -728,12 +740,9 @@
 			if (memcmp(dentry->d_name.name, str, len))
 				continue;
 		}
-		__dget_locked(dentry);
 		dentry->d_vfs_flags |= DCACHE_REFERENCED;
-		spin_unlock(&dcache_lock);
 		return dentry;
 	}
-	spin_unlock(&dcache_lock);
 	return NULL;
 }
 
diff -Nru -X dontdiff linux-2.4.19-pre8/fs/exec.c linux-fastwalk/fs/exec.c
--- linux-2.4.19-pre8/fs/exec.c	Thu May  9 11:03:46 2002
+++ linux-fastwalk/fs/exec.c	Thu May  9 14:13:15 2002
@@ -343,8 +343,7 @@
 	struct file *file;
 	int err = 0;
 
-	if (path_init(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
-		err = path_walk(name, &nd);
+	err = path_lookup(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd);
 	file = ERR_PTR(err);
 	if (!err) {
 		inode = nd.dentry->d_inode;
diff -Nru -X dontdiff linux-2.4.19-pre8/fs/namei.c linux-fastwalk/fs/namei.c
--- linux-2.4.19-pre8/fs/namei.c	Thu May  9 11:03:47 2002
+++ linux-fastwalk/fs/namei.c	Thu May  9 14:13:15 2002
@@ -263,7 +263,7 @@
 static struct dentry * cached_lookup(struct dentry * parent, struct qstr * name, int flags)
 {
 	struct dentry * dentry = d_lookup(parent, name);
-
+	
 	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
 		if (!dentry->d_op->d_revalidate(dentry, flags) && !d_invalidate(dentry)) {
 			dput(dentry);
@@ -273,6 +273,61 @@
 	return dentry;
 }
 
+/*for fastwalking*/
+static inline void unlock_nd(struct nameidata *nd)
+{
+	struct vfsmount *mnt = nd->old_mnt;
+	struct dentry *dentry = nd->old_dentry;
+	mntget(nd->mnt);
+	dget_locked(nd->dentry);
+	nd->old_mnt = NULL;
+	nd->old_dentry = NULL;
+	spin_unlock(&dcache_lock);
+	dput(dentry);
+	mntput(mnt);
+}
+
+static inline void lock_nd(struct nameidata *nd)
+{
+	spin_lock(&dcache_lock);
+	nd->old_mnt = nd->mnt;
+	nd->old_dentry = nd->dentry;
+}
+
+/*
+ * Short-cut version of permission(), for calling by
+ * path_walk(), when dcache lock is held.  Combines parts
+ * of permission() and vfs_permission(), and tests ONLY for
+ * MAY_EXEC permission.
+ *
+ * If appropriate, check DAC only.  If not appropriate, or
+ * short-cut DAC fails, then call permission() to do more
+ * complete permission check.
+ */
+static inline int exec_permission_lite(struct inode *inode)
+{
+	umode_t	mode = inode->i_mode;
+
+	if ((inode->i_op && inode->i_op->permission))
+		return -EAGAIN;
+
+	if (current->fsuid == inode->i_uid)
+		mode >>= 6;
+	else if (in_group_p(inode->i_gid))
+		mode >>= 3;
+
+	if (mode & MAY_EXEC)
+		return 0;
+
+	if ((inode->i_mode & S_IXUGO) && capable(CAP_DAC_OVERRIDE))
+		return 0;
+
+	if (S_ISDIR(inode->i_mode) && capable(CAP_DAC_READ_SEARCH))
+	return 0;
+
+	return -EACCES;
+}
+
 /*
  * This is called when everything else fails, and we actually have
  * to go to the low-level filesystem to find out what we should do..
@@ -354,10 +409,10 @@
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
@@ -365,18 +420,27 @@
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
@@ -402,41 +466,83 @@
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
@@ -449,15 +555,15 @@
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
-		goto return_reval;
+		goto return_base;
 
 	inode = nd->dentry->d_inode;
 	if (current->link_count)
@@ -469,8 +575,12 @@
 		struct qstr this;
 		unsigned int c;
 
-		err = permission(inode, MAY_EXEC);
-		dentry = ERR_PTR(err);
+		err = exec_permission_lite(inode);
+		if (err == -EAGAIN) {
+			unlock_nd(nd);
+			err = permission(inode, MAY_EXEC);
+			lock_nd(nd);
+		}
  		if (err)
 			break;
 
@@ -504,7 +614,7 @@
 			case 2:	
 				if (this.name[1] != '.')
 					break;
-				follow_dotdot(nd);
+				follow_dotdot(&nd->mnt, &nd->dentry);
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
 			case 1:
@@ -520,30 +630,30 @@
 				break;
 		}
 		/* This does the actual lookups.. */
-		dentry = cached_lookup(nd->dentry, &this, LOOKUP_CONTINUE);
-		if (!dentry) {
-			dentry = real_lookup(nd->dentry, &this, LOOKUP_CONTINUE);
-			err = PTR_ERR(dentry);
-			if (IS_ERR(dentry))
-				break;
-		}
+		err = do_lookup(nd, &this, &next, &pinned, LOOKUP_CONTINUE);
+		if (err)
+			break;
 		/* Check mountpoints.. */
-		while (d_mountpoint(dentry) && __follow_down(&nd->mnt, &dentry))
-			;
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
@@ -552,8 +662,8 @@
 			if (!inode->i_op)
 				break;
 		} else {
-			dput(nd->dentry);
-			nd->dentry = dentry;
+			nd->mnt = next.mnt;
+			nd->dentry = next.dentry;
 		}
 		err = -ENOTDIR; 
 		if (!inode->i_op->lookup)
@@ -572,52 +682,47 @@
 			case 2:	
 				if (this.name[1] != '.')
 					break;
-				follow_dotdot(nd);
+				follow_dotdot(&nd->mnt, &nd->dentry);
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
 			case 1:
-				goto return_reval;
+				goto return_base;
 		}
 		if (nd->dentry->d_op && nd->dentry->d_op->d_hash) {
 			err = nd->dentry->d_op->d_hash(nd->dentry, &this);
 			if (err < 0)
 				break;
 		}
-		dentry = cached_lookup(nd->dentry, &this, 0);
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
-			goto no_inode;
+			break;
 		if (lookup_flags & LOOKUP_DIRECTORY) {
 			err = -ENOTDIR; 
 			if (!inode->i_op || !inode->i_op->lookup)
 				break;
 		}
 		goto return_base;
-no_inode:
-		err = -ENOENT;
-		if (lookup_flags & (LOOKUP_POSITIVE|LOOKUP_DIRECTORY))
-			break;
-		goto return_base;
 lookup_parent:
 		nd->last = this;
 		nd->last_type = LAST_NORM;
@@ -627,33 +732,24 @@
 			nd->last_type = LAST_DOT;
 		else if (this.len == 2 && this.name[1] == '.')
 			nd->last_type = LAST_DOTDOT;
-return_reval:
-		/*
-		 * We bypassed the ordinary revalidation routines.
-		 * Check the cached dentry for staleness.
-		 */
-		dentry = nd->dentry;
-		if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
-			err = -ESTALE;
-			if (!dentry->d_op->d_revalidate(dentry, 0)) {
-				d_invalidate(dentry);
-				break;
-			}
-		}
 return_base:
+		unlock_nd(nd);
+		dput(pinned.dentry);
+		mntput(pinned.mnt);
 		return 0;
-out_dput:
-		dput(dentry);
-		break;
 	}
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
 
@@ -742,6 +838,8 @@
 int path_init(const char *name, unsigned int flags, struct nameidata *nd)
 {
 	nd->last_type = LAST_ROOT; /* if there are only slashes... */
+	nd->old_mnt = NULL;
+	nd->old_dentry = NULL;
 	nd->flags = flags;
 	if (*name=='/')
 		return walk_init_root(name,nd);
@@ -752,6 +850,36 @@
 	return 1;
 }
 
+int path_lookup(const char *name, unsigned int flags, struct nameidata *nd)
+{
+	nd->last_type = LAST_ROOT; /* if there are only slashes... */
+	nd->flags = flags;
+	if (*name=='/') {
+		read_lock(&current->fs->lock);
+		if (current->fs->altroot && !(nd->flags & LOOKUP_NOALT)) {
+			nd->mnt = mntget(current->fs->altrootmnt);
+			nd->dentry = dget(current->fs->altroot);
+			read_unlock(&current->fs->lock);
+			if (__emul_lookup_dentry(name,nd))
+				return 0;
+			read_lock(&current->fs->lock);
+		}
+		read_unlock(&current->fs->lock);
+		spin_lock(&dcache_lock);
+		nd->mnt = current->fs->rootmnt;
+		nd->dentry = current->fs->root;
+	}
+	else{
+		spin_lock(&dcache_lock);
+		nd->mnt = current->fs->pwdmnt;
+		nd->dentry = current->fs->pwd;
+	}
+	nd->old_mnt = NULL;
+	nd->old_dentry = NULL;
+	current->total_link_count = 0;
+	return link_path_walk(name, nd);
+}
+
 /*
  * Restricted form of lookup. Doesn't follow links, single-component only,
  * needs parent already locked. Doesn't follow mounts.
@@ -844,8 +972,7 @@
 	err = PTR_ERR(tmp);
 	if (!IS_ERR(tmp)) {
 		err = 0;
-		if (path_init(tmp, flags, nd))
-			err = path_walk(tmp, nd);
+		err = path_lookup(tmp, flags, nd);
 		putname(tmp);
 	}
 	return err;
@@ -1001,8 +1128,7 @@
 	 * The simplest case - just a plain lookup.
 	 */
 	if (!(flag & O_CREAT)) {
-		if (path_init(pathname, lookup_flags(flag), nd))
-			error = path_walk(pathname, nd);
+		error = path_lookup(pathname, lookup_flags(flag), nd);
 		if (error)
 			return error;
 		dentry = nd->dentry;
@@ -1012,8 +1138,7 @@
 	/*
 	 * Create - we need to know the parent.
 	 */
-	if (path_init(pathname, LOOKUP_PARENT, nd))
-		error = path_walk(pathname, nd);
+	error = path_lookup(pathname, LOOKUP_PARENT, nd);
 	if (error)
 		return error;
 
@@ -1265,8 +1390,7 @@
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
-	if (path_init(tmp, LOOKUP_PARENT, &nd))
-		error = path_walk(tmp, &nd);
+	error = path_lookup(tmp, LOOKUP_PARENT, &nd);
 	if (error)
 		goto out;
 	dentry = lookup_create(&nd, 0);
@@ -1334,8 +1458,7 @@
 		struct dentry *dentry;
 		struct nameidata nd;
 
-		if (path_init(tmp, LOOKUP_PARENT, &nd))
-			error = path_walk(tmp, &nd);
+		error = path_lookup(tmp, LOOKUP_PARENT, &nd);
 		if (error)
 			goto out;
 		dentry = lookup_create(&nd, 1);
@@ -1427,8 +1550,7 @@
 	if(IS_ERR(name))
 		return PTR_ERR(name);
 
-	if (path_init(name, LOOKUP_PARENT, &nd))
-		error = path_walk(name, &nd);
+	error = path_lookup(name, LOOKUP_PARENT, &nd);
 	if (error)
 		goto exit;
 
@@ -1496,8 +1618,7 @@
 	if(IS_ERR(name))
 		return PTR_ERR(name);
 
-	if (path_init(name, LOOKUP_PARENT, &nd))
-		error = path_walk(name, &nd);
+	error = path_lookup(name, LOOKUP_PARENT, &nd);
 	if (error)
 		goto exit;
 	error = -EISDIR;
@@ -1568,8 +1689,7 @@
 		struct dentry *dentry;
 		struct nameidata nd;
 
-		if (path_init(to, LOOKUP_PARENT, &nd))
-			error = path_walk(to, &nd);
+		error = path_lookup(to, LOOKUP_PARENT, &nd);
 		if (error)
 			goto out;
 		dentry = lookup_create(&nd, 0);
@@ -1652,12 +1772,10 @@
 		struct nameidata nd, old_nd;
 
 		error = 0;
-		if (path_init(from, LOOKUP_POSITIVE, &old_nd))
-			error = path_walk(from, &old_nd);
+		error = path_lookup(from, LOOKUP_POSITIVE, &old_nd);
 		if (error)
 			goto exit;
-		if (path_init(to, LOOKUP_PARENT, &nd))
-			error = path_walk(to, &nd);
+		error = path_lookup(to, LOOKUP_PARENT, &nd);
 		if (error)
 			goto out;
 		error = -EXDEV;
@@ -1855,14 +1973,11 @@
 	struct dentry * old_dentry, *new_dentry;
 	struct nameidata oldnd, newnd;
 
-	if (path_init(oldname, LOOKUP_PARENT, &oldnd))
-		error = path_walk(oldname, &oldnd);
-
+	error = path_lookup(oldname, LOOKUP_PARENT, &oldnd);
 	if (error)
 		goto exit;
 
-	if (path_init(newname, LOOKUP_PARENT, &newnd))
-		error = path_walk(newname, &newnd);
+	error = path_lookup(newname, LOOKUP_PARENT, &newnd);
 	if (error)
 		goto exit1;
 
@@ -1970,6 +2085,7 @@
 			/* weird __emul_prefix() stuff did it */
 			goto out;
 	}
+	lock_nd(nd);
 	res = link_path_walk(link, nd);
 out:
 	if (current->link_count || res || nd->last_type!=LAST_NORM)
diff -Nru -X dontdiff linux-2.4.19-pre8/fs/namespace.c linux-fastwalk/fs/namespace.c
--- linux-2.4.19-pre8/fs/namespace.c	Thu May  9 11:03:47 2002
+++ linux-fastwalk/fs/namespace.c	Thu May  9 14:13:18 2002
@@ -23,6 +23,7 @@
 
 struct vfsmount *do_kern_mount(const char *type, int flags, char *name, void *data);
 int do_remount_sb(struct super_block *sb, int flags, void * data);
+int __init init_rootfs(void);
 void kill_super(struct super_block *sb);
 
 static struct list_head *mount_hashtable;
@@ -367,8 +368,7 @@
 	if (IS_ERR(kname))
 		goto out;
 	retval = 0;
-	if (path_init(kname, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &nd))
-		retval = path_walk(kname, &nd);
+	retval = path_lookup(kname, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &nd); 
 	putname(kname);
 	if (retval)
 		goto out;
@@ -496,8 +496,7 @@
 		return err;
 	if (!old_name || !*old_name)
 		return -EINVAL;
-	if (path_init(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd))
-		err = path_walk(old_name, &old_nd);
+	err = path_lookup(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd);
 	if (err)
 		return err;
 
@@ -563,8 +562,7 @@
 		return -EPERM;
 	if (!old_name || !*old_name)
 		return -EINVAL;
-	if (path_init(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd))
-		err = path_walk(old_name, &old_nd);
+	err = path_lookup(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd);
 	if (err)
 		return err;
 
@@ -730,8 +728,7 @@
 	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV);
 
 	/* ... and get the mountpoint */
-	if (path_init(dir_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
-		retval = path_walk(dir_name, &nd);
+	retval = path_lookup(dir_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd);
 	if (retval)
 		return retval;
 
@@ -923,8 +920,7 @@
 	if (IS_ERR(name))
 		goto out0;
 	error = 0;
-	if (path_init(name, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &new_nd))
-		error = path_walk(name, &new_nd);
+	error = path_lookup(name, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &new_nd);
 	putname(name);
 	if (error)
 		goto out0;
@@ -937,8 +933,7 @@
 	if (IS_ERR(name))
 		goto out1;
 	error = 0;
-	if (path_init(name, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &old_nd))
-		error = path_walk(name, &old_nd);
+	error = path_lookup(name, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &old_nd);
 	putname(name);
 	if (error)
 		goto out1;
@@ -1047,15 +1042,9 @@
 	if (!mnt_cache)
 		panic("Cannot create vfsmount cache");
 
-	mempages >>= (16 - PAGE_SHIFT);
-	mempages *= sizeof(struct list_head);
-	for (order = 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
-		;
-
-	do {
-		mount_hashtable = (struct list_head *)
-			__get_free_pages(GFP_ATOMIC, order);
-	} while (mount_hashtable == NULL && --order >= 0);
+	order = 0;
+	mount_hashtable = (struct list_head *)
+		__get_free_pages(GFP_ATOMIC, order);
 
 	if (!mount_hashtable)
 		panic("Failed to allocate mount hash table\n");
diff -Nru -X dontdiff linux-2.4.19-pre8/fs/open.c linux-fastwalk/fs/open.c
--- linux-2.4.19-pre8/fs/open.c	Thu May  9 11:03:48 2002
+++ linux-fastwalk/fs/open.c	Thu May  9 14:13:15 2002
@@ -392,8 +392,7 @@
 		goto out;
 
 	error = 0;
-	if (path_init(name,LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY,&nd))
-		error = path_walk(name, &nd);
+	error = path_lookup(name,LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY,&nd);
 	putname(name);
 	if (error)
 		goto out;
@@ -451,9 +450,8 @@
 	if (IS_ERR(name))
 		goto out;
 
-	path_init(name, LOOKUP_POSITIVE | LOOKUP_FOLLOW |
+	error = path_lookup(name, LOOKUP_POSITIVE | LOOKUP_FOLLOW |
 		      LOOKUP_DIRECTORY | LOOKUP_NOALT, &nd);
-	error = path_walk(name, &nd);	
 	putname(name);
 	if (error)
 		goto out;
diff -Nru -X dontdiff linux-2.4.19-pre8/fs/super.c linux-fastwalk/fs/super.c
--- linux-2.4.19-pre8/fs/super.c	Thu May  9 11:03:48 2002
+++ linux-fastwalk/fs/super.c	Thu May  9 14:13:15 2002
@@ -659,8 +659,7 @@
 	/* What device it is? */
 	if (!dev_name || !*dev_name)
 		return ERR_PTR(-EINVAL);
-	if (path_init(dev_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
-		error = path_walk(dev_name, &nd);
+	error = path_lookup(dev_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd);
 	if (error)
 		return ERR_PTR(error);
 	inode = nd.dentry->d_inode;
diff -Nru -X dontdiff linux-2.4.19-pre8/include/linux/dcache.h linux-fastwalk/include/linux/dcache.h
--- linux-2.4.19-pre8/include/linux/dcache.h	Thu May  9 11:04:01 2002
+++ linux-fastwalk/include/linux/dcache.h	Thu May  9 14:13:30 2002
@@ -218,6 +218,7 @@
 
 /* appendix may either be NULL or be used for transname suffixes */
 extern struct dentry * d_lookup(struct dentry *, struct qstr *);
+extern struct dentry * __d_lookup(struct dentry *, struct qstr *);
 
 /* validate "insecure" dentry pointer */
 extern int d_validate(struct dentry *, struct dentry *);
diff -Nru -X dontdiff linux-2.4.19-pre8/include/linux/fs.h linux-fastwalk/include/linux/fs.h
--- linux-2.4.19-pre8/include/linux/fs.h	Thu May  9 11:04:01 2002
+++ linux-fastwalk/include/linux/fs.h	Thu May  9 14:13:23 2002
@@ -653,6 +653,8 @@
 	struct qstr last;
 	unsigned int flags;
 	int last_type;
+	struct dentry *old_dentry;
+	struct vfsmount *old_mnt;
 };
 
 #define DQUOT_USR_ENABLED	0x01		/* User diskquotas enabled */
@@ -1289,6 +1291,7 @@
  *  - require a directory
  *  - ending slashes ok even for nonexistent files
  *  - internal "there are more path compnents" flag
+ *  - locked when lookup done with dcache_lock held
  */
 #define LOOKUP_FOLLOW		(1)
 #define LOOKUP_DIRECTORY	(2)
@@ -1296,6 +1299,7 @@
 #define LOOKUP_POSITIVE		(8)
 #define LOOKUP_PARENT		(16)
 #define LOOKUP_NOALT		(32)
+
 /*
  * Type of the last component on LOOKUP_PARENT
  */
@@ -1325,6 +1329,7 @@
 extern int FASTCALL(__user_walk(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_init(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_walk(const char *, struct nameidata *));
+extern int FASTCALL(path_lookup(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(link_path_walk(const char *, struct nameidata *));
 extern void path_release(struct nameidata *);
 extern int follow_down(struct vfsmount **, struct dentry **);
diff -Nru -X dontdiff linux-2.4.19-pre8/include/linux/fs_struct.h linux-fastwalk/include/linux/fs_struct.h
--- linux-2.4.19-pre8/include/linux/fs_struct.h	Fri Jul 13 15:10:44 2001
+++ linux-fastwalk/include/linux/fs_struct.h	Thu May  9 14:13:32 2002
@@ -32,10 +32,12 @@
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
@@ -55,10 +57,12 @@
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
diff -Nru -X dontdiff linux-2.4.19-pre8/kernel/ksyms.c linux-fastwalk/kernel/ksyms.c
--- linux-2.4.19-pre8/kernel/ksyms.c	Thu May  9 11:04:03 2002
+++ linux-fastwalk/kernel/ksyms.c	Thu May  9 14:13:20 2002
@@ -144,6 +144,7 @@
 EXPORT_SYMBOL(lookup_mnt);
 EXPORT_SYMBOL(path_init);
 EXPORT_SYMBOL(path_walk);
+EXPORT_SYMBOL(path_lookup);
 EXPORT_SYMBOL(path_release);
 EXPORT_SYMBOL(__user_walk);
 EXPORT_SYMBOL(lookup_one_len);

