Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292594AbSCIHTF>; Sat, 9 Mar 2002 02:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292231AbSCIHQz>; Sat, 9 Mar 2002 02:16:55 -0500
Received: from zeus.kernel.org ([204.152.189.113]:61645 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292550AbSCIHPm>;
	Sat, 9 Mar 2002 02:15:42 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: viro@math.psu.edu, Hanna Linder <hannal@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6 Fast Walk Dcache (improved) 
cc: pmenage@ensim.com
In-Reply-To: Your message of "Fri, 08 Mar 2002 18:03:27 PST."
             <E16jWCl-0007cf-00@pmenage-dt.ensim.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Mar 2002 18:59:13 -0800
Message-Id: <E16jX4j-0007gz-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I've reworked the patch somewhat to give the following features:
>

Oops - that was a slightly non-functional version of the patch, as 
exec_permission_lite() had somehow got renamed to exec_permission().

Here's the correct one.

diff -daur linux-2.5.6/fs/dcache.c linux-2.5.6.dcache/fs/dcache.c
--- linux-2.5.6/fs/dcache.c	Fri Mar  8 10:34:58 2002
+++ linux-2.5.6.dcache/fs/dcache.c	Fri Mar  8 17:07:40 2002
@@ -691,18 +691,7 @@
 	return dentry_hashtable + (hash & D_HASHMASK);
 }
 
-/**
- * d_lookup - search for a dentry
- * @parent: parent dentry
- * @name: qstr of name we wish to find
- *
- * Searches the children of the parent dentry for the name in question. If
- * the dentry is found its reference count is incremented and the dentry
- * is returned. The caller must use d_put to free the entry when it has
- * finished using it. %NULL is returned on failure.
- */
- 
-struct dentry * d_lookup(struct dentry * parent, struct qstr * name)
+struct dentry * __d_lookup(struct dentry * parent, struct qstr * name)  
 {
 	unsigned int len = name->len;
 	unsigned int hash = name->hash;
@@ -710,7 +699,6 @@
 	struct list_head *head = d_hash(parent,hash);
 	struct list_head *tmp;
 
-	spin_lock(&dcache_lock);
 	tmp = head->next;
 	for (;;) {
 		struct dentry * dentry = list_entry(tmp, struct dentry, d_hash);
@@ -730,16 +718,37 @@
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
 
 /**
+ * d_lookup - search for a dentry
+ * @parent: parent dentry
+ * @name: qstr of name we wish to find
+ *
+ * Searches the children of the parent dentry for the name in question. If
+ * the dentry is found its reference count is incremented and the dentry
+ * is returned. The caller must use d_put to free the entry when it has
+ * finished using it. %NULL is returned on failure.
+ */
+ 
+struct dentry * d_lookup(struct dentry * parent, struct qstr * name)
+{
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
  * d_validate - verify dentry provided from insecure source
  * @dentry: The dentry alleged to be valid child of @dparent
  * @dparent: The parent dentry (known to be valid)
diff -daur linux-2.5.6/fs/namei.c linux-2.5.6.dcache/fs/namei.c
--- linux-2.5.6/fs/namei.c	Fri Mar  8 10:34:58 2002
+++ linux-2.5.6.dcache/fs/namei.c	Fri Mar  8 17:16:30 2002
@@ -265,11 +265,37 @@
  * Internal lookup() using the new generic dcache.
  * SMP-safe
  */
-static struct dentry * cached_lookup(struct dentry * parent, struct qstr * name, int flags)
+
+/*for fastwalking*/
+static void __undo_locked(struct nameidata *nd, struct dentry *dentry) {
+	dget_locked(nd->dentry);
+	if(dentry)
+		dget_locked(dentry);
+	mntget(nd->mnt);
+	spin_unlock(&dcache_lock);
+	nd->flags &= ~LOOKUP_LOCKED;
+}
+
+static inline void undo_locked(struct nameidata *nd, struct dentry *dentry)
 {
-	struct dentry * dentry = d_lookup(parent, name);
+	if(nd->flags & LOOKUP_LOCKED) 
+		__undo_locked(nd, dentry);
+}
+		
+/*
+ * For fast path lookup while holding the dcache_lock. 
+ * SMP-safe
+ */
+static struct dentry * cached_lookup(struct nameidata * nd, struct qstr * name, int flags)
+{
+	struct dentry * dentry = NULL;
+	if(nd->flags & LOOKUP_LOCKED) 
+		dentry = __d_lookup(nd->dentry, name);
+	else
+		dentry = d_lookup(nd->dentry, name);
 
 	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
+		undo_locked(nd, dentry);
 		if (!dentry->d_op->d_revalidate(dentry, flags) && !d_invalidate(dentry)) {
 			dput(dentry);
 			dentry = NULL;
@@ -279,6 +305,34 @@
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
@@ -472,7 +526,11 @@
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
@@ -507,6 +565,7 @@
 			case 2:	
 				if (this.name[1] != '.')
 					break;
+				undo_locked(nd, NULL);
 				follow_dotdot(nd);
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
@@ -523,16 +582,20 @@
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
-			;
+		if(d_mountpoint(dentry)){
+			undo_locked(nd, dentry);
+			while (d_mountpoint(dentry) && __follow_down(&nd->mnt, &dentry))
+				;
+		}
 
 		err = -ENOENT;
 		inode = dentry->d_inode;
@@ -543,6 +606,7 @@
 			goto out_dput;
 
 		if (inode->i_op->follow_link) {
+			undo_locked(nd, dentry);
 			err = do_follow_link(dentry, nd);
 			dput(dentry);
 			if (err)
@@ -555,7 +619,12 @@
 			if (!inode->i_op)
 				break;
 		} else {
-			dput(nd->dentry);
+			if (!(nd->flags & LOOKUP_LOCKED)) {
+				dentry_stat.slowwalks ++;
+				dput(nd->dentry);
+			} else {
+				dentry_stat.fastwalks ++;
+			}
 			nd->dentry = dentry;
 		}
 		err = -ENOTDIR; 
@@ -575,6 +644,7 @@
 			case 2:	
 				if (this.name[1] != '.')
 					break;
+				undo_locked(nd, NULL);
 				follow_dotdot(nd);
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
@@ -586,7 +656,8 @@
 			if (err < 0)
 				break;
 		}
-		dentry = cached_lookup(nd->dentry, &this, 0);
+		dentry = cached_lookup(nd, &this, 0);
+		undo_locked(nd, dentry); 
 		if (!dentry) {
 			dentry = real_lookup(nd->dentry, &this, 0);
 			err = PTR_ERR(dentry);
@@ -626,11 +697,14 @@
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
+	undo_locked(nd, dentry);
 	path_release(nd);
 return_err:
 	return err;
@@ -707,17 +781,30 @@
 static inline int
 walk_init_root(const char *name, struct nameidata *nd)
 {
+	unsigned int flags = nd->flags;
 	read_lock(&current->fs->lock);
 	if (current->fs->altroot && !(nd->flags & LOOKUP_NOALT)) {
+
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
+		read_lock(&dcache_lock);
+	} else {
+		mntget(nd->mnt);
+		dget(nd->dentry);
+	}
 	read_unlock(&current->fs->lock);
 	return 1;
 }
@@ -736,6 +823,23 @@
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
@@ -744,6 +848,7 @@
 struct dentry * lookup_hash(struct qstr *name, struct dentry * base)
 {
 	struct dentry * dentry;
+	struct nameidata nd;
 	struct inode *inode;
 	int err;
 
@@ -753,6 +858,9 @@
 	if (err)
 		goto out;
 
+	nd.dentry = base;
+	nd.flags = 0;
+
 	/*
 	 * See if the low-level filesystem might want
 	 * to use its own hash..
@@ -764,7 +872,7 @@
 			goto out;
 	}
 
-	dentry = cached_lookup(base, name, 0);
+	dentry = cached_lookup(&nd, name, 0);
 	if (!dentry) {
 		struct dentry *new = d_alloc(base, name);
 		dentry = ERR_PTR(-ENOMEM);
diff -daur linux-2.5.6/include/linux/dcache.h linux-2.5.6.dcache/include/linux/dcache.h
--- linux-2.5.6/include/linux/dcache.h	Fri Mar  8 10:34:59 2002
+++ linux-2.5.6.dcache/include/linux/dcache.h	Fri Mar  8 17:07:09 2002
@@ -33,7 +33,8 @@
 	int nr_unused;
 	int age_limit;          /* age in seconds */
 	int want_pages;         /* pages requested by system */
-	int dummy[2];
+	int fastwalks;
+	int slowwalks;
 };
 extern struct dentry_stat_t dentry_stat;
 
@@ -220,6 +221,7 @@
 
 /* appendix may either be NULL or be used for transname suffixes */
 extern struct dentry * d_lookup(struct dentry *, struct qstr *);
+extern struct dentry * __d_lookup(struct dentry *, struct qstr *);
 
 /* validate "insecure" dentry pointer */
 extern int d_validate(struct dentry *, struct dentry *);
diff -daur linux-2.5.6/include/linux/fs.h linux-2.5.6.dcache/include/linux/fs.h
--- linux-2.5.6/include/linux/fs.h	Fri Mar  8 10:34:59 2002
+++ linux-2.5.6.dcache/include/linux/fs.h	Fri Mar  8 16:33:42 2002
@@ -1273,12 +1273,15 @@
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
@@ -1309,13 +1312,7 @@
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


