Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313080AbSDYLix>; Thu, 25 Apr 2002 07:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313083AbSDYLiw>; Thu, 25 Apr 2002 07:38:52 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:64528 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S313080AbSDYLir>; Thu, 25 Apr 2002 07:38:47 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: Hanna Linder <hannal@us.ibm.com>
cc: pmenage@ensim.com, linux-kernel@vger.kernel.org, viro@math.psu.edu,
        Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 2.5.10] FastWalk Dcache with 2.5.8 vs 2.5.10 dbench results
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 25 Apr 2002 04:38:32 -0700
Message-Id: <E170ha4-0008RP-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Hanna,

Hanna Linder wrote:
>I ran dbench on an 8-way SMP with 1gb mem (no highmem). I used 1 to 12
>clients each run was repeated 30 times. Then the highest and lowest
>values were removed and I took the average (dbench can be quite
>inconsistant). Let me know if you want to see the numbers.
>
>Results show the fast_walk patch increases throughput. 

It strikes me that a standard dbench run isn't the best way to
demonstrate the potential of dcache fastwalk - the only common dentries
between all the children are the CLIENTS directory, and the contents of
the NBSIMULD directory, so there aren't that many d_count cache lines
getting bounced around. In a real system, there's likely to be quite a
bit more commonality between different accessors of the filesystem. You
can create more commonality by having more dbench clients than
processors, but then you bring other CPU affinity issues (e.g. cache and
TLB footprint) into play.

I modified dbench to allow passing an arbitrary directory prefix that
gets appended to all child file operations. This results in all the
dbench children accessing the path elements in the directory prefix, and
hence bouncing their d_count cache lines in the standard kernel.

I ran a series of dbench tests with 0 to 20 path elements in the prefix
(0 corresponding to a normal dbench run) and 1 to 4 clients, on a 4-way
SMP system. I tested on clean 2.5.9, plus your fastwalk patch and my
extended fastwalk patch. Each run was repeated 50 times, and the average
taken without the two outermost data points. 

The results are at

http://www.chiark.greenend.org.uk/~paulm/dbench/fastwalk-dbench.png

With 1 client, there's little difference between the different kernels.
With 2 clients, clean 2.5.9 drops behind the fastwalk kernels at about 5
path elements. When we get to 4 clients, clean 2.5.9 drops behind with 3
path elements, with your fastwalk patch falling about midway between the
clean kernel and my extended fastwalk. At 20 path elements, clean 2.5.9
with 4 clients has the same performance as my fastwalk using only 3
clients ...

My patch is included below, against 2.5.10. This version fixes a problem
that caused "Busy inodes after unmount" warnings.

In case anyone is interested, the patch to add the path prefix to dbench
is at

http://www.chiark.greenend.org.uk/~paulm/dbench/dbench-prefix.patch

Cheers,

Paul

 fs/dcache.c            |   31 ++++-
 fs/namei.c             |  274 +++++++++++++++++++++++++++++++++++++++----------
 include/linux/dcache.h |    4 
 include/linux/fs.h     |   11 -
 4 files changed, 254 insertions(+), 66 deletions(-)

diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.10/fs/dcache.c linux-2.5.10-dcache/fs/dcache.c
--- linux-2.5.10/fs/dcache.c	Wed Apr 24 00:15:11 2002
+++ linux-2.5.10-dcache/fs/dcache.c	Thu Apr 25 03:29:58 2002
@@ -846,13 +846,35 @@
  
 struct dentry * d_lookup(struct dentry * parent, struct qstr * name)
 {
+	struct dentry * dentry;
+	spin_lock(&dcache_lock);
+	dentry = __d_lookup(parent,name);
+	if(dentry)
+		__dget_locked(dentry);
+	spin_unlock(&dcache_lock);
+	return dentry;
+}
+
+/**
+ * __d_lookup - find a dentry without incrementing its reference count
+ * @parent: parent dentry
+ * @name: qstr of name we wish to find.
+ *
+ * Searches the children of the parent dentry for the name in
+ * question, and returns it if it is found. No reference counting is
+ * performed. %NULL is returned on failure. Caller must hold
+ * dcache_lock.  
+ */
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
@@ -872,12 +894,11 @@
 			if (memcmp(dentry->d_name.name, str, len))
 				continue;
 		}
-		__dget_locked(dentry);
-		dentry->d_vfs_flags |= DCACHE_REFERENCED;
-		spin_unlock(&dcache_lock);
+		if(!(dentry->d_vfs_flags & DCACHE_REFERENCED)) {
+			dentry->d_vfs_flags |= DCACHE_REFERENCED;
+		}
 		return dentry;
 	}
-	spin_unlock(&dcache_lock);
 	return NULL;
 }
 
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff  linux-2.5.10/fs/namei.c linux-2.5.10-dcache/fs/namei.c
--- linux-2.5.10/fs/namei.c	Wed Apr 24 00:15:16 2002
+++ linux-2.5.10-dcache/fs/namei.c	Thu Apr 25 03:29:58 2002
@@ -265,11 +265,51 @@
  * Internal lookup() using the new generic dcache.
  * SMP-safe
  */
-static struct dentry * cached_lookup(struct dentry * parent, struct qstr * name, int flags)
+
+/**
+ * undo_locked - release dcache_lock and increment reference counts if needed.
+ * @nd:     dentry/mnt to be reference counted
+ * @dentry: optional additional dentry to be reference counted
+ *
+ * In situations where we may be holding the dcache_lock, but need to
+ * do something blocking, undo_locked() will take reference counts on
+ * the dentry/mnt in nd (and optionally an additional dentry if one is
+ * passed) before releasing the dcache lock. 
+ */
+
+static void __undo_locked(struct nameidata *nd, struct dentry *dentry) {
+	dget_locked(nd->dentry);
+	if(dentry)
+		dget_locked(dentry);
+	mntget(nd->mnt);
+	spin_unlock(&dcache_lock);
+	nd->flags &= ~LOOKUP_LOCKED;
+}
+
+static inline int lookup_locked(struct nameidata *nd) {
+	return (nd->flags & LOOKUP_LOCKED);
+}
+
+static inline void undo_locked(struct nameidata *nd, struct dentry *dentry)
+{
+	if(lookup_locked(nd)) 
+		__undo_locked(nd, dentry);
+}
+
+/*
+ * For fast path lookup while holding the dcache_lock. 
+ * SMP-safe
+ */
+static struct dentry * cached_lookup(struct nameidata * nd, struct qstr * name, int flags)
 {
-	struct dentry * dentry = d_lookup(parent, name);
+	struct dentry * dentry = NULL;
+	if(lookup_locked(nd)) 
+		dentry = __d_lookup(nd->dentry, name);
+	else
+		dentry = d_lookup(nd->dentry, name);
 
 	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
+		undo_locked(nd, dentry);
 		if (!dentry->d_op->d_revalidate(dentry, flags) && !d_invalidate(dentry)) {
 			dput(dentry);
 			dentry = NULL;
@@ -279,6 +319,34 @@
 }
 
 /*
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
+		return -EACCES;
+
+	if (current->fsuid == inode->i_uid)
+		mode >>= 6;
+	else if (in_group_p(inode->i_gid))
+		mode >>= 3;
+
+	if (mode & MAY_EXEC)
+		return 0;
+
+	return -EACCES;
+}
+
+/*
  * This is called when everything else fails, and we actually have
  * to go to the low-level filesystem to find out what we should do..
  *
@@ -333,11 +401,15 @@
  * limiting consecutive symlinks to 40.
  *
  * Without that kind of total limit, nasty chains of consecutive
- * symlinks can cause almost arbitrarily long lookups. 
+ * symlinks can cause almost arbitrarily long lookups.
+ * 
+ * Does dput() on dentry before returning 
  */
 static inline int do_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	int err;
+
+	undo_locked(nd, dentry);
 	if (current->link_count >= 5)
 		goto loop;
 	if (current->total_link_count >= 40)
@@ -351,9 +423,13 @@
 	UPDATE_ATIME(dentry->d_inode);
 	err = dentry->d_inode->i_op->follow_link(dentry, nd);
 	current->link_count--;
+
+	dput(dentry);
+
 	return err;
 loop:
 	path_release(nd);
+	dput(dentry);
 	return -ELOOP;
 }
 
@@ -382,63 +458,106 @@
 	return __follow_up(mnt, dentry);
 }
 
-static inline int __follow_down(struct vfsmount **mnt, struct dentry **dentry)
+static inline int __follow_down_locked(struct vfsmount **mnt, struct dentry **dentry) 
 {
 	struct vfsmount *mounted;
-
-	spin_lock(&dcache_lock);
 	mounted = lookup_mnt(*mnt, *dentry);
 	if (mounted) {
-		*mnt = mntget(mounted);
-		spin_unlock(&dcache_lock);
-		dput(*dentry);
-		mntput(mounted->mnt_parent);
-		*dentry = dget(mounted->mnt_root);
+		*mnt = mounted;
+		*dentry = mounted->mnt_root;
 		return 1;
 	}
+	return 0;
+}
+
+static inline int __follow_down(struct vfsmount **mnt, struct dentry **dentry)
+{
+	spin_lock(&dcache_lock);
+	if(__follow_down_locked(mnt, dentry)) {
+		mntget(*mnt);
+		dget(*dentry);
+		spin_unlock(&dcache_lock);
+		dput((*mnt)->mnt_mountpoint);
+		mntput((*mnt)->mnt_parent);
+		return 1;
+	} 
 	spin_unlock(&dcache_lock);
 	return 0;
 }
 
+static inline int __follow_down_nd(struct nameidata *nd, struct dentry **dentry) 
+{
+	if(lookup_locked(nd)) {
+		return __follow_down_locked(&nd->mnt, dentry);
+	}
+	return __follow_down(&nd->mnt, dentry);
+}
+
 int follow_down(struct vfsmount **mnt, struct dentry **dentry)
 {
 	return __follow_down(mnt,dentry);
 }
  
+static inline int __follow_dotdot_locked(struct nameidata *nd) {
+
+	struct vfsmount *parent;
+	
+	if (nd->dentry != nd->mnt->mnt_root) {
+		/* This isn't the root of our mountpoint */
+		nd->dentry = nd->dentry->d_parent;
+		return 1;
+	}
+	
+	parent=nd->mnt->mnt_parent;
+	if (parent == nd->mnt) {
+		/* This is a self-rooted mount */
+		return 1;
+	}
+	
+	/* This is a real mountpoint */
+	nd->dentry = nd->mnt->mnt_mountpoint;
+	nd->mnt = parent;
+	
+	return 0;
+}
+
 static inline void follow_dotdot(struct nameidata *nd)
 {
 	while(1) {
-		struct vfsmount *parent;
-		struct dentry *dentry;
-		read_lock(&current->fs->lock);
-		if (nd->dentry == current->fs->root &&
-		    nd->mnt == current->fs->rootmnt)  {
-			read_unlock(&current->fs->lock);
-			break;
-		}
-		read_unlock(&current->fs->lock);
-		spin_lock(&dcache_lock);
-		if (nd->dentry != nd->mnt->mnt_root) {
-			dentry = dget(nd->dentry->d_parent);
-			spin_unlock(&dcache_lock);
-			dput(nd->dentry);
-			nd->dentry = dentry;
-			break;
-		}
-		parent=nd->mnt->mnt_parent;
-		if (parent == nd->mnt) {
-			spin_unlock(&dcache_lock);
-			break;
-		}
-		mntget(parent);
-		dentry=dget(nd->mnt->mnt_mountpoint);
-		spin_unlock(&dcache_lock);
-		dput(nd->dentry);
-		nd->dentry = dentry;
-		mntput(nd->mnt);
-		nd->mnt = parent;
+
+	    /* Check for current root directory */
+	    read_lock(&current->fs->lock);
+	    if (nd->dentry == current->fs->root &&
+		nd->mnt == current->fs->rootmnt)  {
+		    read_unlock(&current->fs->lock);
+		    break;
+	    }
+	    read_unlock(&current->fs->lock);
+
+	    if(lookup_locked(nd)) {
+		    if(__follow_dotdot_locked(nd))
+			    break;
+	    } else {
+		    struct vfsmount *oldmnt = nd->mnt;
+		    struct dentry *olddentry = nd->dentry;
+		    int done;
+		    
+		    spin_lock(&dcache_lock);
+
+		    done = __follow_dotdot_locked(nd);
+		
+		    dget(nd->dentry);
+		    mntget(nd->mnt);
+		    spin_unlock(&dcache_lock);
+		    dput(olddentry);
+		    mntput(oldmnt);
+		    
+		    if(done)
+			    break;
+	    }
+	    
 	}
-	while (d_mountpoint(nd->dentry) && __follow_down(&nd->mnt, &nd->dentry))
+	while (d_mountpoint(nd->dentry) && __follow_down_nd(nd, &nd->dentry))
 		;
 }
 
@@ -472,7 +591,11 @@
 		struct qstr this;
 		unsigned int c;
 
-		err = permission(inode, MAY_EXEC);
+		err = exec_permission_lite(inode);
+		if(err) {
+			undo_locked(nd, NULL);
+			err = permission(inode, MAY_EXEC);
+		}
 		dentry = ERR_PTR(err);
  		if (err)
 			break;
@@ -523,15 +646,16 @@
 				break;
 		}
 		/* This does the actual lookups.. */
-		dentry = cached_lookup(nd->dentry, &this, LOOKUP_CONTINUE);
+		dentry = cached_lookup(nd, &this, LOOKUP_CONTINUE);
 		if (!dentry) {
+			undo_locked(nd, NULL);
 			dentry = real_lookup(nd->dentry, &this, LOOKUP_CONTINUE);
 			err = PTR_ERR(dentry);
 			if (IS_ERR(dentry))
 				break;
 		}
 		/* Check mountpoints.. */
-		while (d_mountpoint(dentry) && __follow_down(&nd->mnt, &dentry))
+		while (d_mountpoint(dentry) && __follow_down_nd(nd, &dentry))
 			;
 
 		err = -ENOENT;
@@ -544,7 +668,6 @@
 
 		if (inode->i_op->follow_link) {
 			err = do_follow_link(dentry, nd);
-			dput(dentry);
 			if (err)
 				goto return_err;
 			err = -ENOENT;
@@ -555,7 +678,12 @@
 			if (!inode->i_op)
 				break;
 		} else {
-			dput(nd->dentry);
+			if (!lookup_locked(nd)) {
+				//dentry_stat.slowwalks ++;
+				dput(nd->dentry);
+			} else {
+				//dentry_stat.fastwalks ++;
+			}
 			nd->dentry = dentry;
 		}
 		err = -ENOTDIR; 
@@ -586,25 +714,27 @@
 			if (err < 0)
 				break;
 		}
-		dentry = cached_lookup(nd->dentry, &this, 0);
+		dentry = cached_lookup(nd, &this, 0);
 		if (!dentry) {
+			undo_locked(nd, dentry); 
 			dentry = real_lookup(nd->dentry, &this, 0);
 			err = PTR_ERR(dentry);
 			if (IS_ERR(dentry))
 				break;
 		}
-		while (d_mountpoint(dentry) && __follow_down(&nd->mnt, &dentry))
+
+		while (d_mountpoint(dentry) && __follow_down_nd(nd, &dentry))
 			;
 		inode = dentry->d_inode;
 		if ((lookup_flags & LOOKUP_FOLLOW)
 		    && inode && inode->i_op && inode->i_op->follow_link) {
 			err = do_follow_link(dentry, nd);
-			dput(dentry);
 			if (err)
 				goto return_err;
 			inode = nd->dentry->d_inode;
 		} else {
-			dput(nd->dentry);
+			if(!lookup_locked(nd)) 
+				dput(nd->dentry);
 			nd->dentry = dentry;
 		}
 		err = -ENOENT;
@@ -626,11 +756,14 @@
 		else if (this.len == 2 && this.name[1] == '.')
 			nd->last_type = LAST_DOTDOT;
 return_base:
+		undo_locked(nd, NULL);
 		return 0;
 out_dput:
+		undo_locked(nd, dentry);
 		dput(dentry);
 		break;
 	}
+	undo_locked(nd, NULL);
 	path_release(nd);
 return_err:
 	return err;
@@ -707,17 +840,31 @@
 static inline int
 walk_init_root(const char *name, struct nameidata *nd)
 {
+	unsigned int flags = nd->flags;
 	read_lock(&current->fs->lock);
 	if (current->fs->altroot && !(nd->flags & LOOKUP_NOALT)) {
+
+		/* Don't use locked lookup for altroot */
+		nd->flags &= ~LOOKUP_LOCKED;
+
 		nd->mnt = mntget(current->fs->altrootmnt);
 		nd->dentry = dget(current->fs->altroot);
 		read_unlock(&current->fs->lock);
 		if (__emul_lookup_dentry(name,nd))
 			return 0;
+
+		nd->flags = flags;
+
 		read_lock(&current->fs->lock);
 	}
-	nd->mnt = mntget(current->fs->rootmnt);
-	nd->dentry = dget(current->fs->root);
+	nd->mnt = current->fs->rootmnt;
+	nd->dentry = current->fs->root;
+	if(flags & LOOKUP_LOCKED) {
+		spin_lock(&dcache_lock);
+	} else {
+		mntget(nd->mnt);
+		dget(nd->dentry);
+	}
 	read_unlock(&current->fs->lock);
 	return 1;
 }
@@ -736,6 +883,23 @@
 	return 1;
 }
 
+int path_lookup(const char *name, unsigned int flags, struct nameidata *nd)
+{
+	nd->last_type = LAST_ROOT; /* if there are only slashes... */
+	nd->flags = flags | LOOKUP_LOCKED;
+	if (*name=='/'){
+		if(!walk_init_root(name, nd)) 
+			return 0;
+	} else{
+		read_lock(&current->fs->lock);
+		spin_lock(&dcache_lock);
+		nd->mnt = current->fs->pwdmnt;
+		nd->dentry = current->fs->pwd;
+		read_unlock(&current->fs->lock);
+	}
+	return (path_walk(name, nd));
+}
+
 /*
  * Restricted form of lookup. Doesn't follow links, single-component only,
  * needs parent already locked. Doesn't follow mounts.
@@ -744,6 +908,7 @@
 struct dentry * lookup_hash(struct qstr *name, struct dentry * base)
 {
 	struct dentry * dentry;
+	struct nameidata nd;
 	struct inode *inode;
 	int err;
 
@@ -753,6 +918,9 @@
 	if (err)
 		goto out;
 
+	nd.dentry = base;
+	nd.flags = 0;
+
 	/*
 	 * See if the low-level filesystem might want
 	 * to use its own hash..
@@ -764,7 +932,7 @@
 			goto out;
 	}
 
-	dentry = cached_lookup(base, name, 0);
+	dentry = cached_lookup(&nd, name, 0);
 	if (!dentry) {
 		struct dentry *new = d_alloc(base, name);
 		dentry = ERR_PTR(-ENOMEM);
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.10/include/linux/dcache.h linux-2.5.10-dcache/include/linux/dcache.h
--- linux-2.5.10/include/linux/dcache.h	Wed Apr 24 00:15:18 2002
+++ linux-2.5.10-dcache/include/linux/dcache.h	Thu Apr 25 03:29:58 2002
@@ -33,7 +33,8 @@
 	int nr_unused;
 	int age_limit;          /* age in seconds */
 	int want_pages;         /* pages requested by system */
-	int dummy[2];
+	int fastwalks;
+	int slowwalks;
 };
 extern struct dentry_stat_t dentry_stat;
 
@@ -229,6 +230,7 @@
 
 /* appendix may either be NULL or be used for transname suffixes */
 extern struct dentry * d_lookup(struct dentry *, struct qstr *);
+extern struct dentry * __d_lookup(struct dentry *, struct qstr *);
 
 /* validate "insecure" dentry pointer */
 extern int d_validate(struct dentry *, struct dentry *);
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff  linux-2.5.10/include/linux/fs.h linux-2.5.10-dcache/include/linux/fs.h
--- linux-2.5.10/include/linux/fs.h	Wed Apr 24 00:15:14 2002
+++ linux-2.5.10-dcache/include/linux/fs.h	Thu Apr 25 03:29:58 2002
@@ -1386,12 +1386,15 @@
  *  - require a directory
  *  - ending slashes ok even for nonexistent files
  *  - internal "there are more path compnents" flag
+ *  - locked when lookup done with dcache_lock held
  */
 #define LOOKUP_FOLLOW		(1)
 #define LOOKUP_DIRECTORY	(2)
 #define LOOKUP_CONTINUE		(4)
 #define LOOKUP_PARENT		(16)
 #define LOOKUP_NOALT		(32)
+#define LOOKUP_LOCKED		(64)
+
 /*
  * Type of the last component on LOOKUP_PARENT
  */
@@ -1422,13 +1425,7 @@
 extern int FASTCALL(path_init(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_walk(const char *, struct nameidata *));
 extern int FASTCALL(link_path_walk(const char *, struct nameidata *));
-static inline int path_lookup(const char *path, unsigned flags, struct nameidata *nd)
-{
-	int error = 0;
-	if (path_init(path, flags, nd))
-		error = path_walk(path, nd);
-	return error;
-}
+extern int FASTCALL(path_lookup(const char *, unsigned, struct nameidata *));
 extern void path_release(struct nameidata *);
 extern int follow_down(struct vfsmount **, struct dentry **);
 extern int follow_up(struct vfsmount **, struct dentry **);


