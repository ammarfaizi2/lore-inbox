Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261291AbSJYGaV>; Fri, 25 Oct 2002 02:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbSJYGaV>; Fri, 25 Oct 2002 02:30:21 -0400
Received: from falcon.monarch.net ([24.244.0.24]:17668 "HELO
	falcon.monarch.net") by vger.kernel.org with SMTP
	id <S261291AbSJYGaB>; Fri, 25 Oct 2002 02:30:01 -0400
Date: Fri, 25 Oct 2002 00:32:50 -0600
From: Peter Braam <braam@clusterfs.com>
To: viro@math.psu.edu, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Cc: lustre-devel@lists.sf.net
Subject: [PATCH/RFC] 2.5 vfs intent lookup patch
Message-ID: <20021025063249.GA1359@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

Attached is a 2.5 patch for lookup intents, which we use with Lustre.
This patch adds a lookup2, revalidate2 and intent_release method.
None of those are required if the kernel changes the parameters
globally, but I wanted to keep things simple.

We got some feedback last week and incorporated that. 

The purpose of the patch is to give the lookup call sufficient
information about the "intent" of the lookup.  Intents can be tags
like "a create/open is coming".  With the intent patch, distributed
O_EXCL problems, from which NFS suffers too, are easily addressed.
For Lustre, which runs on 1,000+ node clusters, reducing file system
transactions to a single RPC from ->lookup is the core benefit.  For
InterMezzo the intent opens the opportunity to refresh the cache
before the ->create/mkdir etc methods lock anything, which is very
beneficial.  This is much along the lines of what we discussed over
the last year and a bit.  

Another way to look at it is that it enables one to re-order the
execution slightly: 

(client, namei) --> (server, namei)
(client, vfs_xxx) --> (server, vfs_xxx) 

changes into:

(client, namei) --> (server, namei ; vfs_xxx)
(client, vfs_xxx)

I think this functionality does require VFS changes, but quite clearly
it does not affect file systems that pay no attention to the intent.

We hope that something like this can be incorporated in 2.5, for use
with Lustre and InterMezzo.  

However, I suspect that after you review this you might come up with
an equivalent but better way of doing this.  Particularly interesting
to us is how the d_it field we added to the dentry can be protected
between the return from lookup and the use of that field in
->create/mkdir etc.  We do that with a semaphore (which we placed
under d_fsdata); alternatives are passing the nameidata or intent to
every inode operation that requires the intent.

Do you have a good idea how to do this better?

Best wishes,

- Peter -

diff -Nru a/fs/driverfs/inode.c b/fs/driverfs/inode.c
--- a/fs/driverfs/inode.c	Thu Oct 24 23:30:31 2002
+++ b/fs/driverfs/inode.c	Thu Oct 24 23:30:31 2002
@@ -521,7 +521,7 @@
 	qstr.name = name;
 	qstr.len = strlen(name);
 	qstr.hash = full_name_hash(name,qstr.len);
-	return lookup_hash(&qstr,parent);
+	return lookup_hash(&qstr,parent, NULL);
 }
 
 /**
diff -Nru a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Thu Oct 24 23:30:31 2002
+++ b/fs/exec.c	Thu Oct 24 23:30:31 2002
@@ -113,6 +113,7 @@
 	struct nameidata nd;
 	int error;
 
+        intent_init(&nd, IT_OPEN, 0, NULL);
 	error = user_path_walk(library, &nd);
 	if (error)
 		goto out;
@@ -421,8 +422,12 @@
 struct file *open_exec(const char *name)
 {
 	struct nameidata nd;
-	int err = path_lookup(name, LOOKUP_FOLLOW, &nd);
-	struct file *file = ERR_PTR(err);
+	int err;
+	struct file *file;
+
+        intent_init(&nd, IT_OPEN, 0, NULL);
+        err = path_lookup(name, LOOKUP_FOLLOW, &nd);
+        file = ERR_PTR(err);
 
 	if (!err) {
 		struct inode *inode = nd.dentry->d_inode;
diff -Nru a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c	Thu Oct 24 23:30:31 2002
+++ b/fs/namei.c	Thu Oct 24 23:30:31 2002
@@ -265,6 +265,9 @@
 
 void path_release(struct nameidata *nd)
 {
+        if (nd->dentry && nd->dentry->d_op && 
+            nd->dentry->d_op->d_intent_release)
+                nd->dentry->d_op->d_intent_release(nd->dentry, &nd->it);
 	dput(nd->dentry);
 	mntput(nd->mnt);
 }
@@ -273,10 +276,18 @@
  * Internal lookup() using the new generic dcache.
  * SMP-safe
  */
-static struct dentry * cached_lookup(struct dentry * parent, struct qstr * name, int flags)
+static struct dentry * cached_lookup(struct dentry * parent, struct qstr * name, int flags, struct lookup_intent *it)
 {
 	struct dentry * dentry = d_lookup(parent, name);
 	
+	if (dentry && dentry->d_op && dentry->d_op->d_revalidate2) {
+		if (!dentry->d_op->d_revalidate2(dentry, flags, it) &&
+		    !d_invalidate(dentry)) {
+			dput(dentry);
+			dentry = NULL;
+		}
+		return dentry;
+	} else
 	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
 		if (!dentry->d_op->d_revalidate(dentry, flags) && !d_invalidate(dentry)) {
 			dput(dentry);
@@ -351,7 +362,7 @@
  * make sure that nobody added the entry to the dcache in the meantime..
  * SMP-safe
  */
-static struct dentry * real_lookup(struct dentry * parent, struct qstr * name, int flags)
+static struct dentry * real_lookup(struct dentry * parent, struct qstr * name, int flags, struct lookup_intent *it)
 {
 	struct dentry * result;
 	struct inode *dir = parent->d_inode;
@@ -369,7 +380,11 @@
 		struct dentry * dentry = d_alloc(parent, name);
 		result = ERR_PTR(-ENOMEM);
 		if (dentry) {
-			result = dir->i_op->lookup(dir, dentry);
+			if (dir->i_op->lookup2)
+				result = dir->i_op->lookup2(dir, dentry, 
+                                                            flags, it);
+			else
+                                result = dir->i_op->lookup(dir, dentry);
 			if (result)
 				dput(dentry);
 			else {
@@ -391,6 +406,12 @@
 			dput(result);
 			result = ERR_PTR(-ENOENT);
 		}
+	} else if (result->d_op && result->d_op->d_revalidate2) {
+		if (!result->d_op->d_revalidate2(result, flags, it) &&
+		    !d_invalidate(result)) {
+			dput(result);
+			result = ERR_PTR(-ENOENT);
+		}
 	}
 	return result;
 }
@@ -534,7 +555,7 @@
 	unlock_nd(nd);
 
 need_lookup:
-	dentry = real_lookup(nd->dentry, name, LOOKUP_CONTINUE);
+	dentry = real_lookup(nd->dentry, name, LOOKUP_CONTINUE, &nd->it);
 	if (IS_ERR(dentry))
 		goto fail;
 	mntget(mnt);
@@ -684,7 +705,7 @@
 			nd->dentry = next.dentry;
 		}
 		err = -ENOTDIR; 
-		if (!inode->i_op->lookup)
+		if (!inode->i_op->lookup && !inode->i_op->lookup2)
 			break;
 		continue;
 		/* here ends the main loop */
@@ -737,7 +758,8 @@
 			break;
 		if (lookup_flags & LOOKUP_DIRECTORY) {
 			err = -ENOTDIR; 
-			if (!inode->i_op || !inode->i_op->lookup)
+			if (!inode->i_op || 
+                            (!inode->i_op->lookup && !inode->i_op->lookup2))
 				break;
 		}
 		goto return_base;
@@ -886,7 +908,8 @@
  * needs parent already locked. Doesn't follow mounts.
  * SMP-safe.
  */
-struct dentry * lookup_hash(struct qstr *name, struct dentry * base)
+struct dentry * lookup_hash(struct qstr *name, struct dentry * base, 
+                            struct lookup_intent *it)
 {
 	struct dentry * dentry;
 	struct inode *inode;
@@ -909,13 +932,16 @@
 			goto out;
 	}
 
-	dentry = cached_lookup(base, name, 0);
+	dentry = cached_lookup(base, name, 0, it);
 	if (!dentry) {
 		struct dentry *new = d_alloc(base, name);
 		dentry = ERR_PTR(-ENOMEM);
 		if (!new)
 			goto out;
-		dentry = inode->i_op->lookup(inode, new);
+                if (inode->i_op->lookup2) 
+                        dentry = inode->i_op->lookup2(inode, new, 0, it);
+                else 
+                        dentry = inode->i_op->lookup(inode, new);
 		if (!dentry) {
 			dentry = new;
 			security_ops->inode_post_lookup(inode, dentry);
@@ -927,7 +953,7 @@
 }
 
 /* SMP-safe */
-struct dentry * lookup_one_len(const char * name, struct dentry * base, int len)
+struct dentry * lookup_one_len_it(const char * name, struct dentry * base, int len, struct lookup_intent *it)
 {
 	unsigned long hash;
 	struct qstr this;
@@ -947,11 +973,16 @@
 	}
 	this.hash = end_name_hash(hash);
 
-	return lookup_hash(&this, base);
+	return lookup_hash(&this, base, it);
 access:
 	return ERR_PTR(-EACCES);
 }
 
+struct dentry * lookup_one_len(const char * name, struct dentry * base, int len)
+{
+        return lookup_one_len_it(name, base, len, NULL);
+}
+
 /*
  *	namei()
  *
@@ -1250,6 +1281,7 @@
 		goto ok;
 	}
 
+        intent_init(nd, IT_OPEN|IT_CREAT, mode, NULL);
 	/*
 	 * Create - we need to know the parent.
 	 */
@@ -1268,7 +1300,7 @@
 
 	dir = nd->dentry;
 	down(&dir->d_inode->i_sem);
-	dentry = lookup_hash(&nd->last, nd->dentry);
+	dentry = lookup_hash(&nd->last, nd->dentry, &nd->it);
 
 do_last:
 	error = PTR_ERR(dentry);
@@ -1370,7 +1402,7 @@
 	}
 	dir = nd->dentry;
 	down(&dir->d_inode->i_sem);
-	dentry = lookup_hash(&nd->last, nd->dentry);
+	dentry = lookup_hash(&nd->last, nd->dentry, &nd->it);
 	putname(nd->last.name);
 	goto do_last;
 }
@@ -1384,7 +1416,7 @@
 	dentry = ERR_PTR(-EEXIST);
 	if (nd->last_type != LAST_NORM)
 		goto fail;
-	dentry = lookup_hash(&nd->last, nd->dentry);
+	dentry = lookup_hash(&nd->last, nd->dentry, &nd->it);
 	if (IS_ERR(dentry))
 		goto fail;
 	if (!is_dir && nd->last.name[nd->last.len] && !dentry->d_inode)
@@ -1436,6 +1468,7 @@
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
+        intent_init(&nd, IT_MKNOD, mode, NULL);
 	error = path_lookup(tmp, LOOKUP_PARENT, &nd);
 	if (error)
 		goto out;
@@ -1502,6 +1535,7 @@
 		struct dentry *dentry;
 		struct nameidata nd;
 
+                intent_init(&nd, IT_MKDIR, mode, NULL);
 		error = path_lookup(tmp, LOOKUP_PARENT, &nd);
 		if (error)
 			goto out;
@@ -1598,6 +1632,7 @@
 	if(IS_ERR(name))
 		return PTR_ERR(name);
 
+        intent_init(&nd, IT_RMDIR, 0, NULL);
 	error = path_lookup(name, LOOKUP_PARENT, &nd);
 	if (error)
 		goto exit;
@@ -1614,7 +1649,7 @@
 			goto exit1;
 	}
 	down(&nd.dentry->d_inode->i_sem);
-	dentry = lookup_hash(&nd.last, nd.dentry);
+	dentry = lookup_hash(&nd.last, nd.dentry, &nd.it);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 		error = vfs_rmdir(nd.dentry->d_inode, dentry);
@@ -1668,6 +1703,7 @@
 	if(IS_ERR(name))
 		return PTR_ERR(name);
 
+        intent_init(&nd, IT_UNLINK, 0, NULL);
 	error = path_lookup(name, LOOKUP_PARENT, &nd);
 	if (error)
 		goto exit;
@@ -1675,7 +1711,7 @@
 	if (nd.last_type != LAST_NORM)
 		goto exit1;
 	down(&nd.dentry->d_inode->i_sem);
-	dentry = lookup_hash(&nd.last, nd.dentry);
+	dentry = lookup_hash(&nd.last, nd.dentry, &nd.it);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 		/* Why not before? Because we want correct error value */
@@ -1737,6 +1773,7 @@
 		struct dentry *dentry;
 		struct nameidata nd;
 
+                intent_init(&nd, IT_SYMLINK, 0, from);
 		error = path_lookup(to, LOOKUP_PARENT, &nd);
 		if (error)
 			goto out;
@@ -1815,9 +1852,11 @@
 	if (IS_ERR(to))
 		return PTR_ERR(to);
 
+        intent_init(&old_nd, IT_LINK, 0, NULL);
 	error = __user_walk(oldname, 0, &old_nd);
 	if (error)
 		goto exit;
+        intent_init(&nd, IT_LINK2, 0, &old_nd);
 	error = path_lookup(to, LOOKUP_PARENT, &nd);
 	if (error)
 		goto out;
@@ -1949,7 +1988,8 @@
 }
 
 int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
-	       struct inode *new_dir, struct dentry *new_dentry)
+	       struct inode *new_dir, struct dentry *new_dentry, 
+               struct lookup_intent *it)
 {
 	int error;
 	int is_dir = S_ISDIR(old_dentry->d_inode->i_mode);
@@ -1997,10 +2037,12 @@
 	struct dentry * trap;
 	struct nameidata oldnd, newnd;
 
+        intent_init(&oldnd, IT_RENAME, 0, NULL);
 	error = path_lookup(oldname, LOOKUP_PARENT, &oldnd);
 	if (error)
 		goto exit;
 
+        intent_init(&newnd, IT_RENAME2, 0, &oldnd);
 	error = path_lookup(newname, LOOKUP_PARENT, &newnd);
 	if (error)
 		goto exit1;
@@ -2020,7 +2062,7 @@
 
 	trap = lock_rename(new_dir, old_dir);
 
-	old_dentry = lookup_hash(&oldnd.last, old_dir);
+	old_dentry = lookup_hash(&oldnd.last, old_dir, &oldnd.it);
 	error = PTR_ERR(old_dentry);
 	if (IS_ERR(old_dentry))
 		goto exit3;
@@ -2040,7 +2082,7 @@
 	error = -EINVAL;
 	if (old_dentry == trap)
 		goto exit4;
-	new_dentry = lookup_hash(&newnd.last, new_dir);
+	new_dentry = lookup_hash(&newnd.last, new_dir, &newnd.it);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
 		goto exit4;
@@ -2050,7 +2092,7 @@
 		goto exit5;
 
 	error = vfs_rename(old_dir->d_inode, old_dentry,
-				   new_dir->d_inode, new_dentry);
+				   new_dir->d_inode, new_dentry, NULL);
 exit5:
 	dput(new_dentry);
 exit4:
diff -Nru a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c	Thu Oct 24 23:30:31 2002
+++ b/fs/namespace.c	Thu Oct 24 23:30:31 2002
@@ -1,3 +1,5 @@
+
+
 /*
  *  linux/fs/namespace.c
  *
@@ -370,6 +372,7 @@
 	struct nameidata nd;
 	int retval;
 
+        intent_init(&nd, IT_GETATTR, 0, NULL);
 	retval = __user_walk(name, LOOKUP_FOLLOW, &nd);
 	if (retval)
 		goto out;
@@ -503,6 +506,7 @@
 		return err;
 	if (!old_name || !*old_name)
 		return -EINVAL;
+        intent_init(&old_nd, IT_GETATTR, 0, NULL);
 	err = path_lookup(old_name, LOOKUP_FOLLOW, &old_nd);
 	if (err)
 		return err;
@@ -571,6 +575,8 @@
 		return -EPERM;
 	if (!old_name || !*old_name)
 		return -EINVAL;
+
+        intent_init(&old_nd, IT_GETATTR, 0, NULL);
 	err = path_lookup(old_name, LOOKUP_FOLLOW, &old_nd);
 	if (err)
 		return err;
@@ -928,6 +934,7 @@
 
 	lock_kernel();
 
+        intent_init(&new_nd, IT_GETATTR, 0, NULL);
 	error = __user_walk(new_root, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &new_nd);
 	if (error)
 		goto out0;
@@ -935,6 +942,7 @@
 	if (!check_mnt(new_nd.mnt))
 		goto out1;
 
+        intent_init(&old_nd, IT_GETATTR, 0, NULL);
 	error = __user_walk(put_old, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &old_nd);
 	if (error)
 		goto out1;
diff -Nru a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
--- a/fs/nfsd/vfs.c	Thu Oct 24 23:30:31 2002
+++ b/fs/nfsd/vfs.c	Thu Oct 24 23:30:31 2002
@@ -1282,7 +1282,7 @@
 			err = nfserr_perm;
 	} else
 #endif
-	err = vfs_rename(fdir, odentry, tdir, ndentry);
+	err = vfs_rename(fdir, odentry, tdir, ndentry, NULL);
 	if (!err && EX_ISSYNC(tfhp->fh_export)) {
 		nfsd_sync_dir(tdentry);
 		nfsd_sync_dir(fdentry);
diff -Nru a/fs/open.c b/fs/open.c
--- a/fs/open.c	Thu Oct 24 23:30:31 2002
+++ b/fs/open.c	Thu Oct 24 23:30:31 2002
@@ -46,6 +46,7 @@
 	struct nameidata nd;
 	int error;
 
+        intent_init(&nd, IT_STATFS, 0, buf);
 	error = user_path_walk(path, &nd);
 	if (!error) {
 		struct statfs tmp;
@@ -102,6 +103,7 @@
 	if (length < 0)	/* sorry, but loff_t says... */
 		goto out;
 
+        intent_init(&nd, IT_SETATTR, 0, NULL);
 	error = user_path_walk(path, &nd);
 	if (error)
 		goto out;
@@ -239,6 +241,7 @@
 	struct inode * inode;
 	struct iattr newattrs;
 
+        intent_init(&nd, IT_SETATTR, 0, NULL);
 	error = user_path_walk(filename, &nd);
 	if (error)
 		goto out;
@@ -285,6 +288,7 @@
 	struct inode * inode;
 	struct iattr newattrs;
 
+        intent_init(&nd, IT_SETATTR, 0, NULL);
 	error = user_path_walk(filename, &nd);
 
 	if (error)
@@ -354,6 +358,7 @@
 	else
 		current->cap_effective = current->cap_permitted;
 
+        intent_init(&nd, IT_GETATTR, 0, NULL);
 	res = user_path_walk(filename, &nd);
 	if (!res) {
 		res = permission(nd.dentry->d_inode, mode);
@@ -376,6 +381,7 @@
 	struct nameidata nd;
 	int error;
 
+        intent_init(&nd, IT_GETATTR, 0, NULL);
 	error = __user_walk(filename, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &nd);
 	if (error)
 		goto out;
@@ -427,6 +433,7 @@
 	struct nameidata nd;
 	int error;
 
+        intent_init(&nd, IT_GETATTR, 0, NULL);
 	error = __user_walk(filename, LOOKUP_FOLLOW | LOOKUP_DIRECTORY | LOOKUP_NOALT, &nd);
 	if (error)
 		goto out;
@@ -490,6 +497,7 @@
 	int error;
 	struct iattr newattrs;
 
+        intent_init(&nd, IT_SETATTR, 0, NULL);
 	error = user_path_walk(filename, &nd);
 	if (error)
 		goto out;
@@ -557,6 +565,7 @@
 	struct nameidata nd;
 	int error;
 
+        intent_init(&nd, IT_SETATTR, 0, NULL);
 	error = user_path_walk(filename, &nd);
 	if (!error) {
 		error = chown_common(nd.dentry, user, group);
@@ -570,6 +579,7 @@
 	struct nameidata nd;
 	int error;
 
+        intent_init(&nd, IT_SETATTR, 0, NULL);
 	error = user_path_walk_link(filename, &nd);
 	if (!error) {
 		error = chown_common(nd.dentry, user, group);
@@ -617,6 +627,7 @@
 	if (namei_flags & O_TRUNC)
 		namei_flags |= 2;
 
+        intent_init(&nd, IT_OPEN, 0, NULL);
 	error = open_namei(filename, namei_flags, mode, &nd);
 	if (!error)
 		return dentry_open(nd.dentry, nd.mnt, flags);
diff -Nru a/fs/quota.c b/fs/quota.c
--- a/fs/quota.c	Thu Oct 24 23:30:31 2002
+++ b/fs/quota.c	Thu Oct 24 23:30:31 2002
@@ -110,6 +110,7 @@
 	struct block_device *bdev;
 	struct super_block *sb;
 
+        intent_init(&nd, IT_GETATTR, 0, NULL);
 	ret = user_path_walk(path, &nd);
 	if (ret)
 		goto out;
diff -Nru a/fs/stat.c b/fs/stat.c
--- a/fs/stat.c	Thu Oct 24 23:30:31 2002
+++ b/fs/stat.c	Thu Oct 24 23:30:31 2002
@@ -62,6 +62,7 @@
 	struct nameidata nd;
 	int error;
 
+        intent_init(&nd, IT_GETATTR, 0, stat);
 	error = user_path_walk(name, &nd);
 	if (!error) {
 		error = vfs_getattr(nd.mnt, nd.dentry, stat);
@@ -75,6 +76,7 @@
 	struct nameidata nd;
 	int error;
 
+        intent_init(&nd, IT_GETATTR, 0, stat);
 	error = user_path_walk_link(name, &nd);
 	if (!error) {
 		error = vfs_getattr(nd.mnt, nd.dentry, stat);
@@ -232,6 +234,7 @@
 	if (bufsiz <= 0)
 		return -EINVAL;
 
+        intent_init(&nd, IT_READLINK, 0, NULL);
 	error = user_path_walk_link(path, &nd);
 	if (!error) {
 		struct inode * inode = nd.dentry->d_inode;
diff -Nru a/fs/super.c b/fs/super.c
--- a/fs/super.c	Thu Oct 24 23:30:31 2002
+++ b/fs/super.c	Thu Oct 24 23:30:31 2002
@@ -476,6 +476,7 @@
 	/* What device it is? */
 	if (!dev_name || !*dev_name)
 		return ERR_PTR(-EINVAL);
+        intent_init(&nd, IT_GETATTR, 0, NULL);
 	error = path_lookup(dev_name, LOOKUP_FOLLOW, &nd);
 	if (error)
 		return ERR_PTR(error);
diff -Nru a/fs/xattr.c b/fs/xattr.c
--- a/fs/xattr.c	Thu Oct 24 23:30:31 2002
+++ b/fs/xattr.c	Thu Oct 24 23:30:31 2002
@@ -105,6 +105,7 @@
 	struct nameidata nd;
 	int error;
 
+        intent_init(&nd, IT_SETATTR, 0, NULL);
 	error = user_path_walk(path, &nd);
 	if (error)
 		return error;
@@ -119,6 +120,7 @@
 	struct nameidata nd;
 	int error;
 
+        intent_init(&nd, IT_SETATTR, 0, NULL);
 	error = user_path_walk_link(path, &nd);
 	if (error)
 		return error;
@@ -185,6 +187,7 @@
 	struct nameidata nd;
 	ssize_t error;
 
+        intent_init(&nd, IT_GETATTR, 0, NULL);
 	error = user_path_walk(path, &nd);
 	if (error)
 		return error;
@@ -199,6 +202,7 @@
 	struct nameidata nd;
 	ssize_t error;
 
+        intent_init(&nd, IT_GETATTR, 0, NULL);
 	error = user_path_walk_link(path, &nd);
 	if (error)
 		return error;
@@ -258,6 +262,7 @@
 	struct nameidata nd;
 	ssize_t error;
 
+        intent_init(&nd, IT_GETATTR, 0, NULL);
 	error = user_path_walk(path, &nd);
 	if (error)
 		return error;
@@ -272,6 +277,7 @@
 	struct nameidata nd;
 	ssize_t error;
 
+        intent_init(&nd, IT_GETATTR, 0, NULL);
 	error = user_path_walk_link(path, &nd);
 	if (error)
 		return error;
@@ -328,6 +334,7 @@
 	struct nameidata nd;
 	int error;
 
+        intent_init(&nd, IT_GETATTR, 0, NULL);
 	error = user_path_walk(path, &nd);
 	if (error)
 		return error;
@@ -342,6 +349,7 @@
 	struct nameidata nd;
 	int error;
 
+        intent_init(&nd, IT_GETATTR, 0, NULL);
 	error = user_path_walk_link(path, &nd);
 	if (error)
 		return error;
diff -Nru a/include/linux/dcache.h b/include/linux/dcache.h
--- a/include/linux/dcache.h	Thu Oct 24 23:30:31 2002
+++ b/include/linux/dcache.h	Thu Oct 24 23:30:31 2002
@@ -9,6 +9,25 @@
 #include <linux/spinlock.h>
 #include <asm/page.h>			/* for BUG() */
 
+#define IT_OPEN  (1)
+#define IT_CREAT  (1<<1)
+#define IT_MKDIR  (1<<2)
+#define IT_LINK  (1<<3)
+#define IT_LINK2  (1<<4)
+#define IT_SYMLINK  (1<<5)
+#define IT_UNLINK  (1<<6)
+#define IT_RMDIR  (1<<7)
+#define IT_RENAME  (1<<8)
+#define IT_RENAME2  (1<<9)
+#define IT_READDIR  (1<<10)
+#define IT_GETATTR  (1<<11)
+#define IT_SETATTR  (1<<12)
+#define IT_READLINK  (1<<13)
+#define IT_MKNOD  (1<<14)
+#define IT_LOOKUP  (1<<15)
+#define IT_STATFS  (1<<16)
+
+
 /*
  * linux/include/linux/dcache.h
  *
@@ -30,6 +49,8 @@
 	unsigned int hash;
 };
 
+#include <linux/namei.h>
+
 struct dentry_stat_t {
 	int nr_dentry;
 	int nr_unused;
@@ -77,6 +98,7 @@
 	struct list_head d_subdirs;	/* our children */
 	struct list_head d_alias;	/* inode alias list */
 	int d_mounted;
+        struct lookup_intent *d_it;
 	struct qstr d_name;
 	unsigned long d_time;		/* used by d_revalidate */
 	struct dentry_operations  *d_op;
@@ -93,6 +115,8 @@
 	int (*d_delete)(struct dentry *);
 	void (*d_release)(struct dentry *);
 	void (*d_iput)(struct dentry *, struct inode *);
+	int (*d_revalidate2)(struct dentry *, int, struct lookup_intent *);
+	void (*d_intent_release)(struct  dentry *, struct lookup_intent *);
 };
 
 /* the dentry parameter passed to d_hash and d_compare is the parent
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Thu Oct 24 23:30:31 2002
+++ b/include/linux/fs.h	Thu Oct 24 23:30:31 2002
@@ -1,3 +1,5 @@
+
+
 #ifndef _LINUX_FS_H
 #define _LINUX_FS_H
 
@@ -704,7 +706,7 @@
 extern int vfs_link(struct dentry *, struct inode *, struct dentry *);
 extern int vfs_rmdir(struct inode *, struct dentry *);
 extern int vfs_unlink(struct inode *, struct dentry *);
-extern int vfs_rename(struct inode *, struct dentry *, struct inode *, struct dentry *);
+extern int vfs_rename(struct inode *, struct dentry *, struct inode *, struct dentry *, struct lookup_intent *it);
 
 /*
  * File types
@@ -773,6 +775,8 @@
 struct inode_operations {
 	int (*create) (struct inode *,struct dentry *,int);
 	struct dentry * (*lookup) (struct inode *,struct dentry *);
+	struct dentry * (*lookup2) (struct inode *,struct dentry *, 
+                                    int flags, struct lookup_intent *);
 	int (*link) (struct dentry *,struct inode *,struct dentry *);
 	int (*unlink) (struct inode *,struct dentry *);
 	int (*symlink) (struct inode *,struct dentry *,const char *);
@@ -999,6 +1003,7 @@
 extern int unregister_filesystem(struct file_system_type *);
 extern struct vfsmount *kern_mount(struct file_system_type *);
 extern int may_umount(struct vfsmount *);
+struct vfsmount *do_kern_mount(const char *type, int flags, char *name, void *data);
 extern long do_mount(char *, char *, char *, unsigned long, void *);
 
 #define kern_umount mntput
diff -Nru a/include/linux/namei.h b/include/linux/namei.h
--- a/include/linux/namei.h	Thu Oct 24 23:30:31 2002
+++ b/include/linux/namei.h	Thu Oct 24 23:30:31 2002
@@ -1,3 +1,4 @@
+
 #ifndef _LINUX_NAMEI_H
 #define _LINUX_NAMEI_H
 
@@ -5,6 +6,18 @@
 
 struct vfsmount;
 
+/* for debugging to detect unitialized intents */
+#define INTENT_MAGIC 0x102E02
+
+struct lookup_intent {
+	int it_op;
+        int it_magic;
+	int it_mode;
+	void *it_data;
+        __u8 it_fsdata[80];
+};
+
+
 struct nameidata {
 	struct dentry	*dentry;
 	struct vfsmount *mnt;
@@ -13,8 +26,17 @@
 	int		last_type;
 	struct dentry	*old_dentry;
 	struct vfsmount	*old_mnt;
+        struct lookup_intent it;
 };
 
+static inline void intent_init(struct nameidata *nd, int op, 
+                               int mode, void *data)
+{
+        nd->it.it_op = op;
+        nd->it.it_mode = mode;
+        nd->it.it_data = data;
+        nd->it.it_magic = INTENT_MAGIC;
+}
 /*
  * Type of the last component on LOOKUP_PARENT
  */
@@ -46,7 +68,7 @@
 extern void path_release(struct nameidata *);
 
 extern struct dentry * lookup_one_len(const char *, struct dentry *, int);
-extern struct dentry * lookup_hash(struct qstr *, struct dentry *);
+extern struct dentry * lookup_hash(struct qstr *, struct dentry *, struct lookup_intent *);
 
 extern int follow_down(struct vfsmount **, struct dentry **);
 extern int follow_up(struct vfsmount **, struct dentry **);
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Thu Oct 24 23:30:31 2002
+++ b/kernel/ksyms.c	Thu Oct 24 23:30:31 2002
@@ -361,6 +361,13 @@
 EXPORT_SYMBOL(tty_get_baud_rate);
 EXPORT_SYMBOL(do_SAK);
 
+/* lustre */
+EXPORT_SYMBOL(panic_notifier_list);
+//EXPORT_SYMBOL(pagecache_lock_cacheline);
+EXPORT_SYMBOL(do_kern_mount);
+EXPORT_SYMBOL(exit_files);
+EXPORT_SYMBOL(kmem_cache_validate);
+
 /* filesystem registration */
 EXPORT_SYMBOL(register_filesystem);
 EXPORT_SYMBOL(unregister_filesystem);
diff -Nru a/net/unix/af_unix.c b/net/unix/af_unix.c
--- a/net/unix/af_unix.c	Thu Oct 24 23:30:31 2002
+++ b/net/unix/af_unix.c	Thu Oct 24 23:30:31 2002
@@ -715,7 +715,7 @@
 		/*
 		 * Do the final lookup.
 		 */
-		dentry = lookup_hash(&nd.last, nd.dentry);
+		dentry = lookup_hash(&nd.last, nd.dentry, NULL);
 		err = PTR_ERR(dentry);
 		if (IS_ERR(dentry))
 			goto out_mknod_unlock;

