Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTFKAT2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 20:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbTFKAT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 20:19:28 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:46754 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262033AbTFKATE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 20:19:04 -0400
Date: Tue, 10 Jun 2003 17:32:54 -0700
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: marcelo@conectiva.com.br
cc: hannal@us.ibm.com, linux-kernel@vger.kernel.org, hch@infradead.org,
       Herbert Poetzl <herbert@13thfloor.at>, andrea@suse.de
Subject: [PATCH 2.4.21-rc8] Fastwalk
Message-ID: <108160000.1055291574@w-hlinder>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo,

We have talked about putting the fastwalk patch into 2.4 before.
Very little has changed and it should apply cleanly to 2.4.22-pre
too ;)

This patch reduces cacheline bouncing due to numerous atomic increments 
and decrements of the d_count reference counter during path walking by 
holding the dcache_lock as long as the dentries are in the cache. 

Linus included the original patch in 2.5.11. Al Viro made a few great 
changes in 2.5.12 and Paul Menage added one fix. The following patch includes 
their changes as well. The last time I had access to an 8-way this patch 
showed a throughput improvement while running dbench. Here is the output:

http://west.dl.sourceforge.net/sourceforge/lse/2419fw.png

Today I tested this patch on a 2-way with dbench and found similar 
throughput increase albeit on a smaller scale. I can send out the details 
of that if anyone is interested. 

The patch is also availabe on SourceForge here:
http://osdn.dl.sourceforge.net/sourceforge/lse/fastwalk-2.4.21-rc8.diff

Thank You.

Hanna Linder
IBM Linux Technology Center

----

diff -Nrup -Xdontdiff linux-2.4.21-rc8/fs/dcache.c linux-fastwalk-rc8/fs/dcache.c
--- linux-2.4.21-rc8/fs/dcache.c	Tue Jun 10 16:31:20 2003
+++ linux-fastwalk-rc8/fs/dcache.c	Tue Jun 10 16:34:12 2003
@@ -702,13 +702,25 @@ static inline struct list_head * d_hash(
  
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
@@ -728,12 +740,9 @@ struct dentry * d_lookup(struct dentry *
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
 
diff -Nrup -Xdontdiff linux-2.4.21-rc8/fs/intermezzo/journal.c linux-fastwalk-rc8/fs/intermezzo/journal.c
--- linux-2.4.21-rc8/fs/intermezzo/journal.c	Thu Nov 28 15:53:15 2002
+++ linux-fastwalk-rc8/fs/intermezzo/journal.c	Tue Jun 10 16:34:12 2003
@@ -617,8 +617,7 @@ int izo_lookup_file(struct presto_file_s
 
         CDEBUG(D_CACHE, "looking up: %s\n", path);
 
-        if (path_init(path, LOOKUP_PARENT, nd))
-                error = path_walk(path, nd);
+        error = path_lookup(path, LOOKUP_PARENT, nd);
         if (error) {
                 EXIT;
                 return error;
diff -Nrup -Xdontdiff linux-2.4.21-rc8/fs/intermezzo/presto.c linux-fastwalk-rc8/fs/intermezzo/presto.c
--- linux-2.4.21-rc8/fs/intermezzo/presto.c	Thu Nov 28 15:53:15 2002
+++ linux-fastwalk-rc8/fs/intermezzo/presto.c	Tue Jun 10 16:34:12 2003
@@ -53,8 +53,7 @@ int presto_walk(const char *name, struct
 
         ENTRY;
         err = 0;
-        if (path_init(name, flags, nd)) 
-                err = path_walk(name, nd);
+        err = path_lookup(name, flags, nd);
         return err;
 }
 
diff -Nrup -Xdontdiff linux-2.4.21-rc8/fs/intermezzo/vfs.c linux-fastwalk-rc8/fs/intermezzo/vfs.c
--- linux-2.4.21-rc8/fs/intermezzo/vfs.c	Tue Jun 10 16:31:21 2003
+++ linux-fastwalk-rc8/fs/intermezzo/vfs.c	Tue Jun 10 16:34:12 2003
@@ -702,8 +702,7 @@ int lento_create(const char *name, int m
 
         /* this looks up the parent */
 //        if (path_init(pathname, LOOKUP_FOLLOW | LOOKUP_POSITIVE, &nd))
-        if (path_init(pathname,  LOOKUP_PARENT, &nd))
-                error = path_walk(pathname, &nd);
+        error = path_lookup(pathname,  LOOKUP_PARENT, &nd);
         if (error) {
                 EXIT;
                 goto exit;
@@ -855,12 +854,10 @@ int lento_link(const char * oldname, con
                 struct nameidata nd, old_nd;
 
                 error = 0;
-                if (path_init(from, LOOKUP_POSITIVE, &old_nd))
-                        error = path_walk(from, &old_nd);
+                error = path_lookup(from, LOOKUP_POSITIVE, &old_nd);
                 if (error)
                         goto exit;
-                if (path_init(to, LOOKUP_PARENT, &nd))
-                        error = path_walk(to, &nd);
+                error = path_lookup(to, LOOKUP_PARENT, &nd);
                 if (error)
                         goto out;
                 error = -EXDEV;
@@ -1062,8 +1059,7 @@ int lento_unlink(const char *pathname, s
         if(IS_ERR(name))
                 return PTR_ERR(name);
 
-        if (path_init(name, LOOKUP_PARENT, &nd))
-                error = path_walk(name, &nd);
+        error = path_lookup(name, LOOKUP_PARENT, &nd);
         if (error)
                 goto exit;
         error = -EISDIR;
@@ -1223,8 +1219,7 @@ int lento_symlink(const char *oldname, c
                 goto exit_from;
         }
 
-        if (path_init(to, LOOKUP_PARENT, &nd)) 
-                error = path_walk(to, &nd);
+        error = path_lookup(to, LOOKUP_PARENT, &nd);
         if (error) {
                 EXIT;
                 goto exit_to;
@@ -1381,8 +1376,7 @@ int lento_mkdir(const char *name, int mo
                 return error;
         }
 
-        if (path_init(pathname, LOOKUP_PARENT, &nd))
-                error = path_walk(pathname, &nd);
+        error = path_lookup(pathname, LOOKUP_PARENT, &nd);
         if (error)
                 goto out_name;
 
@@ -1527,8 +1521,7 @@ int lento_rmdir(const char *pathname, st
                 return PTR_ERR(name);
         }
 
-        if (path_init(name, LOOKUP_PARENT, &nd))
-                error = path_walk(name, &nd);
+        error = path_lookup(name, LOOKUP_PARENT, &nd);
         if (error) {
                 EXIT;
                 goto exit;
@@ -1693,8 +1686,7 @@ int lento_mknod(const char *filename, in
         if (IS_ERR(tmp))
                 return PTR_ERR(tmp);
 
-        if (path_init(tmp, LOOKUP_PARENT, &nd))
-                error = path_walk(tmp, &nd);
+        error = path_lookup(tmp, LOOKUP_PARENT, &nd);
         if (error)
                 goto out;
         dentry = lookup_create(&nd, 0);
@@ -1973,14 +1965,11 @@ int lento_do_rename(const char *oldname,
 
         ENTRY;
 
-        if (path_init(oldname, LOOKUP_PARENT, &oldnd))
-                error = path_walk(oldname, &oldnd);
-
+        error = path_lookup(oldname, LOOKUP_PARENT, &oldnd);
         if (error)
                 goto exit;
 
-        if (path_init(newname, LOOKUP_PARENT, &newnd))
-                error = path_walk(newname, &newnd);
+        error = path_lookup(newname, LOOKUP_PARENT, &newnd);
         if (error)
                 goto exit1;
 
diff -Nrup -Xdontdiff linux-2.4.21-rc8/fs/namei.c linux-fastwalk-rc8/fs/namei.c
--- linux-2.4.21-rc8/fs/namei.c	Tue Jun 10 16:31:25 2003
+++ linux-fastwalk-rc8/fs/namei.c	Tue Jun 10 16:34:12 2003
@@ -263,7 +263,7 @@ void path_release(struct nameidata *nd)
 static struct dentry * cached_lookup(struct dentry * parent, struct qstr * name, int flags)
 {
 	struct dentry * dentry = d_lookup(parent, name);
-
+	
 	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
 		if (!dentry->d_op->d_revalidate(dentry, flags) && !d_invalidate(dentry)) {
 			dput(dentry);
@@ -273,6 +273,61 @@ static struct dentry * cached_lookup(str
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
@@ -354,10 +409,10 @@ loop:
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
@@ -365,18 +420,27 @@ static inline int __follow_up(struct vfs
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
@@ -402,41 +466,83 @@ int follow_down(struct vfsmount **mnt, s
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
@@ -449,15 +555,15 @@ static inline void follow_dotdot(struct 
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
@@ -469,8 +575,12 @@ int link_path_walk(const char * name, st
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
 
@@ -504,7 +614,7 @@ int link_path_walk(const char * name, st
 			case 2:	
 				if (this.name[1] != '.')
 					break;
-				follow_dotdot(nd);
+				follow_dotdot(&nd->mnt, &nd->dentry);
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
 			case 1:
@@ -520,30 +630,30 @@ int link_path_walk(const char * name, st
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
@@ -552,8 +662,8 @@ int link_path_walk(const char * name, st
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
@@ -572,52 +682,47 @@ last_component:
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
@@ -627,33 +732,24 @@ lookup_parent:
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
 
@@ -738,28 +834,35 @@ walk_init_root(const char *name, struct 
 	return 1;
 }
 
-/* SMP-safe */
-int path_lookup(const char *path, unsigned flags, struct nameidata *nd)
-{
-	int error = 0;
-	if (path_init(path, flags, nd))
-		error = path_walk(path, nd);
-	return error;
-}
 
-
-/* SMP-safe */
-int path_init(const char *name, unsigned int flags, struct nameidata *nd)
+int path_lookup(const char *name, unsigned int flags, struct nameidata *nd)
 {
 	nd->last_type = LAST_ROOT; /* if there are only slashes... */
 	nd->flags = flags;
-	if (*name=='/')
-		return walk_init_root(name,nd);
-	read_lock(&current->fs->lock);
-	nd->mnt = mntget(current->fs->pwdmnt);
-	nd->dentry = dget(current->fs->pwd);
-	read_unlock(&current->fs->lock);
-	return 1;
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
 }
 
 /*
@@ -1964,6 +2067,7 @@ __vfs_follow_link(struct nameidata *nd, 
 			/* weird __emul_prefix() stuff did it */
 			goto out;
 	}
+	lock_nd(nd);
 	res = link_path_walk(link, nd);
 out:
 	if (current->link_count || res || nd->last_type!=LAST_NORM)
diff -Nrup -Xdontdiff linux-2.4.21-rc8/fs/namespace.c linux-fastwalk-rc8/fs/namespace.c
--- linux-2.4.21-rc8/fs/namespace.c	Tue Jun 10 16:31:25 2003
+++ linux-fastwalk-rc8/fs/namespace.c	Tue Jun 10 16:34:12 2003
@@ -23,6 +23,7 @@
 
 struct vfsmount *do_kern_mount(const char *type, int flags, char *name, void *data);
 int do_remount_sb(struct super_block *sb, int flags, void * data);
+int __init init_rootfs(void);
 void kill_super(struct super_block *sb);
 extern int __init init_rootfs(void);
 
diff -Nrup -Xdontdiff linux-2.4.21-rc8/fs/nfsd/export.c linux-fastwalk-rc8/fs/nfsd/export.c
--- linux-2.4.21-rc8/fs/nfsd/export.c	Thu Nov 28 15:53:15 2002
+++ linux-fastwalk-rc8/fs/nfsd/export.c	Tue Jun 10 16:34:12 2003
@@ -214,8 +214,7 @@ exp_export(struct nfsctl_export *nxp)
 
 	/* Look up the dentry */
 	err = 0;
-	if (path_init(nxp->ex_path, LOOKUP_POSITIVE, &nd))
-		err = path_walk(nxp->ex_path, &nd);
+	err = path_lookup(nxp->ex_path, LOOKUP_POSITIVE, &nd);
 	if (err)
 		goto out_unlock;
 
@@ -411,8 +410,7 @@ exp_rootfh(struct svc_client *clp, kdev_
 
 	err = -EPERM;
 	if (path) {
-		if (path_init(path, LOOKUP_POSITIVE, &nd) &&
-		    path_walk(path, &nd)) {
+		if (path_lookup(path, LOOKUP_POSITIVE, &nd))  {
 			printk("nfsd: exp_rootfh path not found %s", path);
 			return err;
 		}
diff -Nrup -Xdontdiff linux-2.4.21-rc8/include/linux/dcache.h linux-fastwalk-rc8/include/linux/dcache.h
--- linux-2.4.21-rc8/include/linux/dcache.h	Thu Nov 28 15:53:15 2002
+++ linux-fastwalk-rc8/include/linux/dcache.h	Tue Jun 10 16:34:12 2003
@@ -219,6 +219,7 @@ extern void d_move(struct dentry *, stru
 
 /* appendix may either be NULL or be used for transname suffixes */
 extern struct dentry * d_lookup(struct dentry *, struct qstr *);
+extern struct dentry * __d_lookup(struct dentry *, struct qstr *);
 
 /* validate "insecure" dentry pointer */
 extern int d_validate(struct dentry *, struct dentry *);
diff -Nrup -Xdontdiff linux-2.4.21-rc8/include/linux/fs.h linux-fastwalk-rc8/include/linux/fs.h
--- linux-2.4.21-rc8/include/linux/fs.h	Tue Jun 10 16:31:59 2003
+++ linux-fastwalk-rc8/include/linux/fs.h	Tue Jun 10 16:34:12 2003
@@ -658,6 +658,8 @@ struct nameidata {
 	struct qstr last;
 	unsigned int flags;
 	int last_type;
+	struct dentry *old_dentry;
+	struct vfsmount *old_mnt;
 };
 
 #define DQUOT_USR_ENABLED	0x01		/* User diskquotas enabled */
@@ -1326,6 +1328,7 @@ static inline long IS_ERR(const void *pt
  *  - require a directory
  *  - ending slashes ok even for nonexistent files
  *  - internal "there are more path compnents" flag
+ *  - locked when lookup done with dcache_lock held
  */
 #define LOOKUP_FOLLOW		(1)
 #define LOOKUP_DIRECTORY	(2)
@@ -1333,6 +1336,7 @@ static inline long IS_ERR(const void *pt
 #define LOOKUP_POSITIVE		(8)
 #define LOOKUP_PARENT		(16)
 #define LOOKUP_NOALT		(32)
+
 /*
  * Type of the last component on LOOKUP_PARENT
  */
@@ -1360,7 +1364,6 @@ typedef int (*read_actor_t)(read_descrip
 extern loff_t default_llseek(struct file *file, loff_t offset, int origin);
 
 extern int FASTCALL(__user_walk(const char *, unsigned, struct nameidata *));
-extern int FASTCALL(path_init(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_walk(const char *, struct nameidata *));
 extern int FASTCALL(path_lookup(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(link_path_walk(const char *, struct nameidata *));
diff -Nrup -Xdontdiff linux-2.4.21-rc8/include/linux/fs_struct.h linux-fastwalk-rc8/include/linux/fs_struct.h
--- linux-2.4.21-rc8/include/linux/fs_struct.h	Fri Jul 13 15:10:44 2001
+++ linux-fastwalk-rc8/include/linux/fs_struct.h	Tue Jun 10 16:34:12 2003
@@ -32,10 +32,12 @@ static inline void set_fs_root(struct fs
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
@@ -55,10 +57,12 @@ static inline void set_fs_pwd(struct fs_
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
diff -Nrup -Xdontdiff linux-2.4.21-rc8/kernel/ksyms.c linux-fastwalk-rc8/kernel/ksyms.c
--- linux-2.4.21-rc8/kernel/ksyms.c	Tue Jun 10 16:32:05 2003
+++ linux-fastwalk-rc8/kernel/ksyms.c	Tue Jun 10 16:34:12 2003
@@ -148,8 +148,8 @@ EXPORT_SYMBOL(force_delete);
 EXPORT_SYMBOL(follow_up);
 EXPORT_SYMBOL(follow_down);
 EXPORT_SYMBOL(lookup_mnt);
-EXPORT_SYMBOL(path_init);
 EXPORT_SYMBOL(path_walk);
+EXPORT_SYMBOL(path_lookup);
 EXPORT_SYMBOL(path_release);
 EXPORT_SYMBOL(__user_walk);
 EXPORT_SYMBOL(lookup_one_len);
diff -Nrup -Xdontdiff linux-2.4.21-rc8/net/unix/af_unix.c linux-fastwalk-rc8/net/unix/af_unix.c
--- linux-2.4.21-rc8/net/unix/af_unix.c	Thu Nov 28 15:53:16 2002
+++ linux-fastwalk-rc8/net/unix/af_unix.c	Tue Jun 10 16:34:12 2003
@@ -590,9 +590,8 @@ static unix_socket *unix_find_other(stru
 	int err = 0;
 	
 	if (sunname->sun_path[0]) {
-		if (path_init(sunname->sun_path, 
-			      LOOKUP_POSITIVE|LOOKUP_FOLLOW, &nd))
-			err = path_walk(sunname->sun_path, &nd);
+		err = path_lookup(sunname->sun_path, 
+			      LOOKUP_POSITIVE|LOOKUP_FOLLOW, &nd);
 		if (err)
 			goto fail;
 		err = permission(nd.dentry->d_inode,MAY_WRITE);
@@ -685,8 +684,7 @@ static int unix_bind(struct socket *sock
 		 * Get the parent directory, calculate the hash for last
 		 * component.
 		 */
-		if (path_init(sunaddr->sun_path, LOOKUP_PARENT, &nd))
-			err = path_walk(sunaddr->sun_path, &nd);
+		err = path_lookup(sunaddr->sun_path, LOOKUP_PARENT, &nd);
 		if (err)
 			goto out_mknod_parent;
 		/*




