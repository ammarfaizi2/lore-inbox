Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312681AbSDXWCw>; Wed, 24 Apr 2002 18:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312687AbSDXWCv>; Wed, 24 Apr 2002 18:02:51 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:23511 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312681AbSDXWCt>; Wed, 24 Apr 2002 18:02:49 -0400
Date: Wed, 24 Apr 2002 15:05:01 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: viro@math.psu.edu
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, hannal@us.ibm.com
Subject: [PATCH 2.5.10] FastWalk Dcache with 2.5.8 vs 2.5.10 dbench results
Message-ID: <22350000.1019685901@w-hlinder.des>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here it is again...

This time I have a picture at http://prdownloads.sf.net/lse/2510.png

I ran dbench on an 8-way SMP with 1gb mem (no highmem). I used
1 to 12 clients each run was repeated 30 times. Then the highest
and lowest values were removed and I took the average (dbench can
be quite inconsistant). Let me know if you want to see the numbers.

Results show the fast_walk patch increases throughput.

Patch can also be downloaded at: http://prdownloads.sf.net/lse/fast_walkA1-2.5.10.patch

Hanna Linder
hannal@us.ibm.com
IBM Linux Technology Center
-------------

diff -Nru -Xdontdiff linux-2.5.10/fs/dcache.c linux-fastwalk/fs/dcache.c
--- linux-2.5.10/fs/dcache.c	Wed Apr 24 00:15:11 2002
+++ linux-fastwalk/fs/dcache.c	Wed Apr 24 11:29:10 2002
@@ -846,13 +846,22 @@
  
 struct dentry * d_lookup(struct dentry * parent, struct qstr * name)
 {
+	struct dentry * dentry;
+	spin_lock(&dcache_lock);
+	dentry = __d_lookup(parent,name);
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
@@ -874,10 +883,8 @@
 		}
 		__dget_locked(dentry);
 		dentry->d_vfs_flags |= DCACHE_REFERENCED;
-		spin_unlock(&dcache_lock);
 		return dentry;
 	}
-	spin_unlock(&dcache_lock);
 	return NULL;
 }
 
diff -Nru -Xdontdiff linux-2.5.10/fs/namei.c linux-fastwalk/fs/namei.c
--- linux-2.5.10/fs/namei.c	Wed Apr 24 00:15:16 2002
+++ linux-fastwalk/fs/namei.c	Wed Apr 24 11:29:11 2002
@@ -268,8 +268,41 @@
 static struct dentry * cached_lookup(struct dentry * parent, struct qstr * name, int flags)
 {
 	struct dentry * dentry = d_lookup(parent, name);
+	
+	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
+		if (!dentry->d_op->d_revalidate(dentry, flags) && !d_invalidate(dentry)) {
+			dput(dentry);
+			dentry = NULL;
+		}
+	}
+	return dentry;
+}
 
+/*for fastwalking*/
+static inline void undo_locked(struct nameidata *nd)
+{
+	if(nd->flags & LOOKUP_LOCKED){
+		dget_locked(nd->dentry);
+		mntget(nd->mnt);
+		spin_unlock(&dcache_lock);
+		nd->flags &= ~LOOKUP_LOCKED;
+	}
+}
+
+/*
+ * For fast path lookup while holding the dcache_lock. 
+ * SMP-safe
+ */
+static struct dentry * cached_lookup_nd(struct nameidata * nd, struct qstr * name, int flags)
+{
+	struct dentry * dentry = NULL;
+	if(!(nd->flags & LOOKUP_LOCKED))
+		return cached_lookup(nd->dentry, name, flags);
+	
+	dentry = __d_lookup(nd->dentry, name);
+	
 	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
+		undo_locked(nd);
 		if (!dentry->d_op->d_revalidate(dentry, flags) && !d_invalidate(dentry)) {
 			dput(dentry);
 			dentry = NULL;
@@ -279,6 +312,34 @@
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
@@ -472,7 +533,11 @@
 		struct qstr this;
 		unsigned int c;
 
-		err = permission(inode, MAY_EXEC);
+		err = exec_permission_lite(inode);
+		if(err){
+			undo_locked(nd);
+			err = permission(inode, MAY_EXEC);
+		}
 		dentry = ERR_PTR(err);
  		if (err)
 			break;
@@ -507,6 +572,7 @@
 			case 2:	
 				if (this.name[1] != '.')
 					break;
+				undo_locked(nd);
 				follow_dotdot(nd);
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
@@ -523,16 +589,20 @@
 				break;
 		}
 		/* This does the actual lookups.. */
-		dentry = cached_lookup(nd->dentry, &this, LOOKUP_CONTINUE);
+		dentry = cached_lookup_nd(nd, &this, LOOKUP_CONTINUE);
 		if (!dentry) {
+			undo_locked(nd);
 			dentry = real_lookup(nd->dentry, &this, LOOKUP_CONTINUE);
 			err = PTR_ERR(dentry);
 			if (IS_ERR(dentry))
 				break;
 		}
 		/* Check mountpoints.. */
-		while (d_mountpoint(dentry) && __follow_down(&nd->mnt, &dentry))
-			;
+		if(d_mountpoint(dentry)){
+			undo_locked(nd);
+			while (d_mountpoint(dentry) && __follow_down(&nd->mnt, &dentry))
+				;
+		}
 
 		err = -ENOENT;
 		inode = dentry->d_inode;
@@ -543,6 +613,7 @@
 			goto out_dput;
 
 		if (inode->i_op->follow_link) {
+			undo_locked(nd);
 			err = do_follow_link(dentry, nd);
 			dput(dentry);
 			if (err)
@@ -555,7 +626,8 @@
 			if (!inode->i_op)
 				break;
 		} else {
-			dput(nd->dentry);
+			if (!(nd->flags & LOOKUP_LOCKED))
+				dput(nd->dentry);
 			nd->dentry = dentry;
 		}
 		err = -ENOTDIR; 
@@ -575,6 +647,7 @@
 			case 2:	
 				if (this.name[1] != '.')
 					break;
+				undo_locked(nd);
 				follow_dotdot(nd);
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
@@ -586,7 +659,8 @@
 			if (err < 0)
 				break;
 		}
-		dentry = cached_lookup(nd->dentry, &this, 0);
+		dentry = cached_lookup_nd(nd, &this, 0);
+		undo_locked(nd); 
 		if (!dentry) {
 			dentry = real_lookup(nd->dentry, &this, 0);
 			err = PTR_ERR(dentry);
@@ -626,11 +700,14 @@
 		else if (this.len == 2 && this.name[1] == '.')
 			nd->last_type = LAST_DOTDOT;
 return_base:
+		undo_locked(nd);
 		return 0;
 out_dput:
+		undo_locked(nd);
 		dput(dentry);
 		break;
 	}
+	undo_locked(nd);
 	path_release(nd);
 return_err:
 	return err;
@@ -734,6 +811,36 @@
 	nd->dentry = dget(current->fs->pwd);
 	read_unlock(&current->fs->lock);
 	return 1;
+}
+
+int path_lookup(const char *name, unsigned int flags, struct nameidata *nd)
+{
+	nd->last_type = LAST_ROOT; /* if there are only slashes... */
+	nd->flags = flags;
+	if (*name=='/'){
+		read_lock(&current->fs->lock);
+		if (current->fs->altroot && !(nd->flags & LOOKUP_NOALT)) {
+			nd->mnt = mntget(current->fs->altrootmnt);
+			nd->dentry = dget(current->fs->altroot);
+			read_unlock(&current->fs->lock);
+			if (__emul_lookup_dentry(name,nd))
+				return 0;
+			read_lock(&current->fs->lock);
+		}
+		spin_lock(&dcache_lock); /*to avoid cacheline bouncing with d_count*/
+		nd->mnt = current->fs->rootmnt;
+		nd->dentry = current->fs->root;
+		read_unlock(&current->fs->lock);
+	}
+	else{
+		read_lock(&current->fs->lock);
+		spin_lock(&dcache_lock);
+		nd->mnt = current->fs->pwdmnt;
+		nd->dentry = current->fs->pwd;
+		read_unlock(&current->fs->lock);
+	}
+	nd->flags |= LOOKUP_LOCKED;
+	return (path_walk(name, nd));
 }
 
 /*
diff -Nru -Xdontdiff linux-2.5.10/include/linux/dcache.h linux-fastwalk/include/linux/dcache.h
--- linux-2.5.10/include/linux/dcache.h	Wed Apr 24 00:15:18 2002
+++ linux-fastwalk/include/linux/dcache.h	Wed Apr 24 11:29:13 2002
@@ -229,6 +229,7 @@
 
 /* appendix may either be NULL or be used for transname suffixes */
 extern struct dentry * d_lookup(struct dentry *, struct qstr *);
+extern struct dentry * __d_lookup(struct dentry *, struct qstr *);
 
 /* validate "insecure" dentry pointer */
 extern int d_validate(struct dentry *, struct dentry *);
diff -Nru -Xdontdiff linux-2.5.10/include/linux/fs.h linux-fastwalk/include/linux/fs.h
--- linux-2.5.10/include/linux/fs.h	Wed Apr 24 00:15:14 2002
+++ linux-fastwalk/include/linux/fs.h	Wed Apr 24 11:29:14 2002
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
@@ -1421,14 +1424,8 @@
 extern int FASTCALL(__user_walk(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_init(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_walk(const char *, struct nameidata *));
+extern int FASTCALL(path_lookup(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(link_path_walk(const char *, struct nameidata *));
-static inline int path_lookup(const char *path, unsigned flags, struct nameidata *nd)
-{
-	int error = 0;
-	if (path_init(path, flags, nd))
-		error = path_walk(path, nd);
-	return error;
-}
 extern void path_release(struct nameidata *);
 extern int follow_down(struct vfsmount **, struct dentry **);
 extern int follow_up(struct vfsmount **, struct dentry **);





	
