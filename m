Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293426AbSCECBm>; Mon, 4 Mar 2002 21:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293367AbSCECBJ>; Mon, 4 Mar 2002 21:01:09 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:28843 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293330AbSCEB77>; Mon, 4 Mar 2002 20:59:59 -0500
Date: Mon, 04 Mar 2002 18:01:17 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: davej@suse.de, torvalds@transmeta.com, viro@math.psu.edu
cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: [PATCH] 2.5.5-dj2 - Fast Walk Dcache to Decrease Cacheline Bouncing
Message-ID: <33110000.1015293677@w-hlinder.des>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I would like you to consider this patch for inclusion in 2.5.6. 

What it does:

The simple part combines path_init and path_walk into one function
path_lookup. Which was a simple cleanup of the code. The more complex 
part is changing link_path_walk and cached_lookup to hold the dcache_lock 
instead of incrementing the d_count reference counter while walking 
the path as long as the desired dentry's are found in the dcache. Dave
Olien wrote permission_exec_lite. These ideas came from Al Viro to decrease 
cacheline bouncing.

Performance benefits running dbench with 16 clients 10 times on an 8-way SMP:

On 2.5.5-dj2 it 
	-reduces TOTAL system spinlock contention from 8.7 to 6.5
	-reduces TOTAL system MAX HOLD time from 37ms to 17ms
	-reduces lru_list_lock spinning from 31.4% to 5.7%
	-reduces lru_list_lock contention from 38.3% to 15.4%

Testing:

It compiles and boots and runs as well or better as the clean 2.5.5-dj2 kernel.
I have run it on my T21 laptop and my 8-way SMP system.

Please let me know if there are any changes I can make or tests I can
run to increase the chance of it being accepted.

Thanks.

Hanna Linder (hannal@us.ibm.com)
IBM Linux Technology Center

-----------
diff -Nru --exclude-from=dontdiff linux-2.5.5-dj2/fs/dcache.c linux-2.5.5-fastwalk/fs/dcache.c
--- linux-2.5.5-dj2/fs/dcache.c	Mon Mar  4 15:56:20 2002
+++ linux-2.5.5-fastwalk/fs/dcache.c	Fri Mar  1 16:21:40 2002
@@ -705,13 +705,23 @@
  
 struct dentry * d_lookup(struct dentry * parent, struct qstr * name)
 {
+	struct dentry *dentry = NULL;
+
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
@@ -733,10 +743,8 @@
 		}
 		__dget_locked(dentry);
 		dentry->d_vfs_flags |= DCACHE_REFERENCED;
-		spin_unlock(&dcache_lock);
 		return dentry;
 	}
-	spin_unlock(&dcache_lock);
 	return NULL;
 }
 
diff -Nru --exclude-from=dontdiff linux-2.5.5-dj2/fs/exec.c linux-2.5.5-fastwalk/fs/exec.c
--- linux-2.5.5-dj2/fs/exec.c	Tue Feb 19 18:11:00 2002
+++ linux-2.5.5-fastwalk/fs/exec.c	Fri Mar  1 16:21:40 2002
@@ -347,8 +347,7 @@
 	struct file *file;
 	int err = 0;
 
-	if (path_init(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
-		err = path_walk(name, &nd);
+	err = path_lookup(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd);
 	file = ERR_PTR(err);
 	if (!err) {
 		inode = nd.dentry->d_inode;
diff -Nru --exclude-from=dontdiff linux-2.5.5-dj2/fs/namei.c linux-2.5.5-fastwalk/fs/namei.c
--- linux-2.5.5-dj2/fs/namei.c	Mon Mar  4 15:56:22 2002
+++ linux-2.5.5-fastwalk/fs/namei.c	Fri Mar  1 16:21:40 2002
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
+		dget(nd->dentry);
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
+	if(!nd->flags & LOOKUP_LOCKED)
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
@@ -472,7 +533,9 @@
 		struct qstr this;
 		unsigned int c;
 
-		err = permission(inode, MAY_EXEC);
+		err = exec_permission_lite(inode);
+		if(err)
+			err = permission(inode, MAY_EXEC);
 		dentry = ERR_PTR(err);
  		if (err)
 			break;
@@ -507,6 +570,7 @@
 			case 2:	
 				if (this.name[1] != '.')
 					break;
+				undo_locked(nd);
 				follow_dotdot(nd);
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
@@ -523,16 +587,20 @@
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
@@ -543,6 +611,7 @@
 			goto out_dput;
 
 		if (inode->i_op->follow_link) {
+			undo_locked(nd);
 			err = do_follow_link(dentry, nd);
 			dput(dentry);
 			if (err)
@@ -555,7 +624,8 @@
 			if (!inode->i_op)
 				break;
 		} else {
-			dput(nd->dentry);
+			if (!nd->flags & LOOKUP_LOCKED)
+				dput(nd->dentry);
 			nd->dentry = dentry;
 		}
 		err = -ENOTDIR; 
@@ -575,6 +645,7 @@
 			case 2:	
 				if (this.name[1] != '.')
 					break;
+				undo_locked(nd);
 				follow_dotdot(nd);
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
@@ -586,7 +657,8 @@
 			if (err < 0)
 				break;
 		}
-		dentry = cached_lookup(nd->dentry, &this, 0);
+		dentry = cached_lookup_nd(nd, &this, 0);
+		undo_locked(nd); 
 		if (!dentry) {
 			dentry = real_lookup(nd->dentry, &this, 0);
 			err = PTR_ERR(dentry);
@@ -644,11 +716,14 @@
 			}
 		}
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
@@ -755,6 +830,36 @@
 	return 1;
 }
 
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
+}
+
 /*
  * Restricted form of lookup. Doesn't follow links, single-component only,
  * needs parent already locked. Doesn't follow mounts.
@@ -845,8 +950,7 @@
 	err = PTR_ERR(tmp);
 	if (!IS_ERR(tmp)) {
 		err = 0;
-		if (path_init(tmp, flags, nd))
-			err = path_walk(tmp, nd);
+		err = path_lookup(tmp, flags, nd);
 		putname(tmp);
 	}
 	return err;
@@ -1037,8 +1141,7 @@
 	 * The simplest case - just a plain lookup.
 	 */
 	if (!(flag & O_CREAT)) {
-		if (path_init(pathname, lookup_flags(flag), nd))
-			error = path_walk(pathname, nd);
+		error = path_lookup(pathname, lookup_flags(flag), nd);
 		if (error)
 			return error;
 		dentry = nd->dentry;
@@ -1048,8 +1151,7 @@
 	/*
 	 * Create - we need to know the parent.
 	 */
-	if (path_init(pathname, LOOKUP_PARENT, nd))
-		error = path_walk(pathname, nd);
+	error = path_lookup(pathname, LOOKUP_PARENT, nd);
 	if (error)
 		return error;
 
@@ -1299,8 +1401,7 @@
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
-	if (path_init(tmp, LOOKUP_PARENT, &nd))
-		error = path_walk(tmp, &nd);
+	error = path_lookup(tmp, LOOKUP_PARENT, &nd);
 	if (error)
 		goto out;
 	dentry = lookup_create(&nd, 0);
@@ -1360,8 +1461,7 @@
 		struct dentry *dentry;
 		struct nameidata nd;
 
-		if (path_init(tmp, LOOKUP_PARENT, &nd))
-			error = path_walk(tmp, &nd);
+		error = path_lookup(tmp, LOOKUP_PARENT, &nd);
 		if (error)
 			goto out;
 		dentry = lookup_create(&nd, 1);
@@ -1452,8 +1552,7 @@
 	if(IS_ERR(name))
 		return PTR_ERR(name);
 
-	if (path_init(name, LOOKUP_PARENT, &nd))
-		error = path_walk(name, &nd);
+	error = path_lookup(name, LOOKUP_PARENT, &nd);
 	if (error)
 		goto exit;
 
@@ -1524,8 +1623,7 @@
 	if(IS_ERR(name))
 		return PTR_ERR(name);
 
-	if (path_init(name, LOOKUP_PARENT, &nd))
-		error = path_walk(name, &nd);
+	error = path_lookup(name, LOOKUP_PARENT, &nd);
 	if (error)
 		goto exit;
 	error = -EISDIR;
@@ -1588,8 +1686,7 @@
 		struct dentry *dentry;
 		struct nameidata nd;
 
-		if (path_init(to, LOOKUP_PARENT, &nd))
-			error = path_walk(to, &nd);
+		error = path_lookup(to, LOOKUP_PARENT, &nd);
 		if (error)
 			goto out;
 		dentry = lookup_create(&nd, 0);
@@ -1666,12 +1763,10 @@
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
@@ -1848,14 +1943,11 @@
 	struct dentry * trap;
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
 
diff -Nru --exclude-from=dontdiff linux-2.5.5-dj2/fs/namespace.c linux-2.5.5-fastwalk/fs/namespace.c
--- linux-2.5.5-dj2/fs/namespace.c	Mon Mar  4 15:56:22 2002
+++ linux-2.5.5-fastwalk/fs/namespace.c	Fri Mar  1 16:22:14 2002
@@ -368,8 +368,7 @@
 	if (IS_ERR(kname))
 		goto out;
 	retval = 0;
-	if (path_init(kname, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &nd))
-		retval = path_walk(kname, &nd);
+	retval = path_lookup(kname, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &nd); 
 	putname(kname);
 	if (retval)
 		goto out;
@@ -497,8 +496,7 @@
 		return err;
 	if (!old_name || !*old_name)
 		return -EINVAL;
-	if (path_init(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd))
-		err = path_walk(old_name, &old_nd);
+	err = path_lookup(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd);
 	if (err)
 		return err;
 
@@ -564,8 +562,7 @@
 		return -EPERM;
 	if (!old_name || !*old_name)
 		return -EINVAL;
-	if (path_init(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd))
-		err = path_walk(old_name, &old_nd);
+	err = path_lookup(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd);
 	if (err)
 		return err;
 
@@ -731,8 +728,7 @@
 	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV);
 
 	/* ... and get the mountpoint */
-	if (path_init(dir_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
-		retval = path_walk(dir_name, &nd);
+	retval = path_lookup(dir_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd);
 	if (retval)
 		return retval;
 
@@ -924,8 +920,7 @@
 	if (IS_ERR(name))
 		goto out0;
 	error = 0;
-	if (path_init(name, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &new_nd))
-		error = path_walk(name, &new_nd);
+	error = path_lookup(name, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &new_nd);
 	putname(name);
 	if (error)
 		goto out0;
@@ -938,8 +933,7 @@
 	if (IS_ERR(name))
 		goto out1;
 	error = 0;
-	if (path_init(name, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &old_nd))
-		error = path_walk(name, &old_nd);
+	error = path_lookup(name, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &old_nd);
 	putname(name);
 	if (error)
 		goto out1;
diff -Nru --exclude-from=dontdiff linux-2.5.5-dj2/fs/open.c linux-2.5.5-fastwalk/fs/open.c
--- linux-2.5.5-dj2/fs/open.c	Tue Feb 19 18:10:54 2002
+++ linux-2.5.5-fastwalk/fs/open.c	Fri Mar  1 16:21:40 2002
@@ -368,8 +368,7 @@
 		goto out;
 
 	error = 0;
-	if (path_init(name,LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY,&nd))
-		error = path_walk(name, &nd);
+	error = path_lookup(name,LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY,&nd);
 	putname(name);
 	if (error)
 		goto out;
@@ -427,9 +426,8 @@
 	if (IS_ERR(name))
 		goto out;
 
-	path_init(name, LOOKUP_POSITIVE | LOOKUP_FOLLOW |
+	error = path_lookup(name, LOOKUP_POSITIVE | LOOKUP_FOLLOW |
 		      LOOKUP_DIRECTORY | LOOKUP_NOALT, &nd);
-	error = path_walk(name, &nd);	
 	putname(name);
 	if (error)
 		goto out;
diff -Nru --exclude-from=dontdiff linux-2.5.5-dj2/fs/super.c linux-2.5.5-fastwalk/fs/super.c
--- linux-2.5.5-dj2/fs/super.c	Mon Mar  4 15:56:25 2002
+++ linux-2.5.5-fastwalk/fs/super.c	Fri Mar  1 16:21:40 2002
@@ -710,8 +710,7 @@
 	/* What device it is? */
 	if (!dev_name || !*dev_name)
 		return ERR_PTR(-EINVAL);
-	if (path_init(dev_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
-		error = path_walk(dev_name, &nd);
+	error = path_lookup(dev_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd);
 	if (error)
 		return ERR_PTR(error);
 	inode = nd.dentry->d_inode;
diff -Nru --exclude-from=dontdiff linux-2.5.5-dj2/include/linux/dcache.h linux-2.5.5-fastwalk/include/linux/dcache.h
--- linux-2.5.5-dj2/include/linux/dcache.h	Mon Mar  4 15:56:27 2002
+++ linux-2.5.5-fastwalk/include/linux/dcache.h	Fri Mar  1 16:21:40 2002
@@ -221,6 +221,7 @@
 
 /* appendix may either be NULL or be used for transname suffixes */
 extern struct dentry * d_lookup(struct dentry *, struct qstr *);
+extern struct dentry * __d_lookup(struct dentry *, struct qstr *);
 
 /* validate "insecure" dentry pointer */
 extern int d_validate(struct dentry *, struct dentry *);
diff -Nru --exclude-from=dontdiff linux-2.5.5-dj2/include/linux/fs.h linux-2.5.5-fastwalk/include/linux/fs.h
--- linux-2.5.5-dj2/include/linux/fs.h	Mon Mar  4 15:56:27 2002
+++ linux-2.5.5-fastwalk/include/linux/fs.h	Fri Mar  1 16:21:40 2002
@@ -1271,6 +1271,7 @@
  *  - require a directory
  *  - ending slashes ok even for nonexistent files
  *  - internal "there are more path compnents" flag
+ *  - locked when lookup done with dcache_lock held
  */
 #define LOOKUP_FOLLOW		(1)
 #define LOOKUP_DIRECTORY	(2)
@@ -1278,6 +1279,8 @@
 #define LOOKUP_POSITIVE		(8)
 #define LOOKUP_PARENT		(16)
 #define LOOKUP_NOALT		(32)
+#define LOOKUP_LOCKED		(64)
+
 /*
  * Type of the last component on LOOKUP_PARENT
  */
@@ -1307,6 +1310,7 @@
 extern int FASTCALL(__user_walk(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_init(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_walk(const char *, struct nameidata *));
+extern int FASTCALL(path_lookup(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(link_path_walk(const char *, struct nameidata *));
 extern void path_release(struct nameidata *);
 extern int follow_down(struct vfsmount **, struct dentry **);
diff -Nru --exclude-from=dontdiff linux-2.5.5-dj2/kernel/ksyms.c linux-2.5.5-fastwalk/kernel/ksyms.c
--- linux-2.5.5-dj2/kernel/ksyms.c	Mon Mar  4 15:56:33 2002
+++ linux-2.5.5-fastwalk/kernel/ksyms.c	Fri Mar  1 16:21:40 2002
@@ -145,6 +145,7 @@
 EXPORT_SYMBOL(lookup_mnt);
 EXPORT_SYMBOL(path_init);
 EXPORT_SYMBOL(path_walk);
+EXPORT_SYMBOL(path_lookup);
 EXPORT_SYMBOL(path_release);
 EXPORT_SYMBOL(__user_walk);
 EXPORT_SYMBOL(lookup_one_len);


	



