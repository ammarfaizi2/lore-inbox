Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286207AbSBOCNZ>; Thu, 14 Feb 2002 21:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286322AbSBOCNV>; Thu, 14 Feb 2002 21:13:21 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:27828 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S286207AbSBOCNE>; Thu, 14 Feb 2002 21:13:04 -0500
Date: Thu, 14 Feb 2002 18:13:35 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: Paul Menage <pmenage@ensim.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.4.17] Your suggestions for fast path walk
Message-ID: <16270000.1013739215@w-hlinder.des>
In-Reply-To: <E16bS9Q-0000Bd-00@pmenage-dt.ensim.com>
In-Reply-To: <E16bS9Q-0000Bd-00@pmenage-dt.ensim.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Thursday, February 14, 2002 12:06:40 -0800 Paul Menage <pmenage@ensim.com> wrote:

> 
> Also, to avoid code duplication, is there any reason why path_lookup()
> can't be implemented (possibly inlined) just as:
> 
> static int path_lookup(const char *name, struct nameidata *nd, int flags)
> {
> 
>     if(!path_init(name, flags, nd))
> 	return 0;
> 
>     return path_walk(name, nd);
> 
> }


Hello Paul,

	Thank you for taking the time to look over my patch and sending
your comments. In response, Yes, there is a reason why I can't implement 
path_lookup by calling path_init. path_init calls dget which increments 
the d_count. The function I wrote holds the dcache_lock instead of 
incrementing d_count at that point.
	Following is the patch calling path_walk in path_init_walk
as you suggested. 

Thanks for your input.

Hanna

------------
diff -Nru linux/fs/dcache.c linux-fastwalk/fs/dcache.c
--- linux/fs/dcache.c	Fri Dec 21 09:41:55 2001
+++ linux-fastwalk/fs/dcache.c	Wed Feb 13 11:25:44 2002
@@ -703,39 +703,45 @@
  
 struct dentry * d_lookup(struct dentry * parent, struct qstr * name)
 {
-	unsigned int len = name->len;
-	unsigned int hash = name->hash;
-	const unsigned char *str = name->name;
-	struct list_head *head = d_hash(parent,hash);
-	struct list_head *tmp;
-
-	spin_lock(&dcache_lock);
-	tmp = head->next;
-	for (;;) {
-		struct dentry * dentry = list_entry(tmp, struct dentry, d_hash);
-		if (tmp == head)
-			break;
-		tmp = tmp->next;
-		if (dentry->d_name.hash != hash)
-			continue;
-		if (dentry->d_parent != parent)
-			continue;
-		if (parent->d_op && parent->d_op->d_compare) {
-			if (parent->d_op->d_compare(parent, &dentry->d_name, name))
-				continue;
-		} else {
-			if (dentry->d_name.len != len)
-				continue;
-			if (memcmp(dentry->d_name.name, str, len))
-				continue;
-		}
-		__dget_locked(dentry);
-		dentry->d_vfs_flags |= DCACHE_REFERENCED;
-		spin_unlock(&dcache_lock);
-		return dentry;
-	}
-	spin_unlock(&dcache_lock);
-	return NULL;
+        struct dentry *dentry = NULL;
+ 
+        spin_lock(&dcache_lock);
+        dentry = __d_lookup(parent, name);
+        spin_unlock(&dcache_lock);
+        return dentry;
+}
+ 
+struct dentry * __d_lookup(struct dentry *parent, struct qstr *name)
+{
+        unsigned int len = name->len;
+        unsigned int hash = name->hash;
+        const unsigned char *str = name->name;
+        struct list_head *head = d_hash(parent,hash);
+        struct list_head *tmp;
+ 
+        tmp = head->next;
+        for (;;) {
+                struct dentry * dentry = list_entry(tmp, struct dentry, d_hash);
+                if (tmp == head)
+                        return NULL;
+                tmp = tmp->next;
+                if (dentry->d_name.hash != hash)
+                        continue;
+                if (dentry->d_parent != parent)
+                        continue;
+                if (parent->d_op && parent->d_op->d_compare) {
+                        if (parent->d_op->d_compare(parent, &dentry->d_name, name))
+                                continue;
+                } else {
+                        if (dentry->d_name.len != len)
+                                continue;
+                        if (memcmp(dentry->d_name.name, str, len))
+                                continue;
+                }
+                __dget_locked(dentry);
+                dentry->d_vfs_flags |= DCACHE_REFERENCED;
+                return dentry;
+        }
 }
 
 /**
diff -Nru linux/fs/exec.c linux-fastwalk/fs/exec.c
--- linux/fs/exec.c	Fri Dec 21 09:41:55 2001
+++ linux-fastwalk/fs/exec.c	Wed Feb 13 11:25:44 2002
@@ -343,8 +343,7 @@
 	struct file *file;
 	int err = 0;
 
-	if (path_init(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
-		err = path_walk(name, &nd);
+	err = path_init_walk(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd);
 	file = ERR_PTR(err);
 	if (!err) {
 		inode = nd.dentry->d_inode;
diff -Nru linux/fs/namei.c linux-fastwalk/fs/namei.c
--- linux/fs/namei.c	Wed Oct 17 14:46:29 2001
+++ linux-fastwalk/fs/namei.c	Thu Feb 14 14:49:51 2002
@@ -261,7 +261,13 @@
  */
 static struct dentry * cached_lookup(struct dentry * parent, struct qstr * name, int flags)
 {
-	struct dentry * dentry = d_lookup(parent, name);
+	struct dentry *dentry = NULL;
+	if(flags & LOOKUP_LOCKED){
+		dentry = __d_lookup(parent, name);
+		spin_unlock(&dcache_lock);
+	}
+	else
+		dentry = d_lookup(parent, name);
 
 	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
 		if (!dentry->d_op->d_revalidate(dentry, flags) && !d_invalidate(dentry)) {
@@ -269,6 +275,8 @@
 			dentry = NULL;
 		}
 	}
+	if(flags & LOOKUP_LOCKED)
+		spin_lock(&dcache_lock);
 	return dentry;
 }
 
@@ -380,18 +388,18 @@
 
 static inline int __follow_down(struct vfsmount **mnt, struct dentry **dentry)
 {
-	struct vfsmount *mounted;
+        struct vfsmount *mounted;
 
 	spin_lock(&dcache_lock);
-	mounted = lookup_mnt(*mnt, *dentry);
-	if (mounted) {
-		*mnt = mntget(mounted);
-		spin_unlock(&dcache_lock);
-		dput(*dentry);
-		mntput(mounted->mnt_parent);
-		*dentry = dget(mounted->mnt_root);
-		return 1;
-	}
+        mounted = lookup_mnt(*mnt, *dentry);
+        if (mounted) {
+                *mnt = mntget(mounted);
+                spin_unlock(&dcache_lock);
+                dput(*dentry);
+                mntput(mounted->mnt_parent);
+                *dentry = dget(mounted->mnt_root);
+                return 1;
+        }
 	spin_unlock(&dcache_lock);
 	return 0;
 }
@@ -400,6 +408,17 @@
 {
 	return __follow_down(mnt,dentry);
 }
+
+/* for fastwalking */
+static inline void undo_locked( struct nameidata *nd)
+{
+        if(nd->flags & LOOKUP_LOCKED){
+                dget(nd->dentry);
+                mntget(nd->mnt);
+                spin_unlock(&dcache_lock);
+		nd->flags &= ~LOOKUP_LOCKED;
+        }
+}
  
 static inline void follow_dotdot(struct nameidata *nd)
 {
@@ -501,6 +520,7 @@
 			case 2:	
 				if (this.name[1] != '.')
 					break;
+				undo_locked(nd);
 				follow_dotdot(nd);
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
@@ -516,17 +536,26 @@
 			if (err < 0)
 				break;
 		}
-		/* This does the actual lookups.. */
-		dentry = cached_lookup(nd->dentry, &this, LOOKUP_CONTINUE);
+		if(nd->flags & LOOKUP_LOCKED){
+			/* This does the actual lookups.. */
+			dentry = cached_lookup(nd->dentry, &this, LOOKUP_CONTINUE|LOOKUP_LOCKED);
+		}
+		else{
+			/* This does the actual lookups.. */
+			dentry = cached_lookup(nd->dentry, &this, LOOKUP_CONTINUE);
+		}
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
+			while ( d_mountpoint(dentry) && __follow_down(&nd->mnt, &dentry));
+		}
 
 		err = -ENOENT;
 		inode = dentry->d_inode;
@@ -537,6 +566,7 @@
 			goto out_dput;
 
 		if (inode->i_op->follow_link) {
+			undo_locked(nd);
 			err = do_follow_link(dentry, nd);
 			dput(dentry);
 			if (err)
@@ -549,7 +579,8 @@
 			if (!inode->i_op)
 				break;
 		} else {
-			dput(nd->dentry);
+			if (!nd->flags & LOOKUP_LOCKED)
+				dput(dentry);
 			nd->dentry = dentry;
 		}
 		err = -ENOTDIR; 
@@ -569,6 +600,7 @@
 			case 2:	
 				if (this.name[1] != '.')
 					break;
+				undo_locked(nd);
 				follow_dotdot(nd);
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
@@ -580,15 +612,18 @@
 			if (err < 0)
 				break;
 		}
-		dentry = cached_lookup(nd->dentry, &this, 0);
+		if(nd->flags & LOOKUP_LOCKED)
+			dentry = cached_lookup(nd->dentry, &this, LOOKUP_LOCKED);
+		else
+			dentry = cached_lookup(nd->dentry, &this, 0);
+		undo_locked(nd);
 		if (!dentry) {
 			dentry = real_lookup(nd->dentry, &this, 0);
 			err = PTR_ERR(dentry);
 			if (IS_ERR(dentry))
 				break;
 		}
-		while (d_mountpoint(dentry) && __follow_down(&nd->mnt, &dentry))
-			;
+		while (d_mountpoint(dentry) && __follow_down(&nd->mnt, &dentry));
 		inode = dentry->d_inode;
 		if ((lookup_flags & LOOKUP_FOLLOW)
 		    && inode && inode->i_op && inode->i_op->follow_link) {
@@ -625,11 +660,14 @@
 		else if (this.len == 2 && this.name[1] == '.')
 			nd->last_type = LAST_DOTDOT;
 return_base:
+		undo_locked(nd);
 		return 0;
 out_dput:
+		undo_locked(nd);
 		dput(dentry);
 		break;
-	}
+	} /* end of for loop */
+	undo_locked(nd);
 	path_release(nd);
 return_err:
 	return err;
@@ -736,6 +774,38 @@
 	return 1;
 }
 
+/* SMP-safe */
+int path_init_walk(const char *name, unsigned int flags, struct nameidata *nd)
+{
+        nd->last_type = LAST_ROOT; /* if there are only slashes... */
+        nd->flags = flags;
+	spin_lock(&dcache_lock);
+        if (*name=='/'){
+        	read_lock(&current->fs->lock);
+        	if (current->fs->altroot && !(nd->flags & LOOKUP_NOALT)) {
+			nd->mnt = current->fs->altrootmnt;
+                	nd->dentry = current->fs->altroot;
+                	read_unlock(&current->fs->lock);
+			spin_unlock(&dcache_lock);
+                	if (__emul_lookup_dentry(name,nd))
+                        	return 0;
+                	read_lock(&current->fs->lock);
+			spin_lock(&dcache_lock);
+        	}
+    		nd->mnt = current->fs->rootmnt;
+        	nd->dentry = current->fs->root;
+        	read_unlock(&current->fs->lock);
+	}
+	else{
+        	read_lock(&current->fs->lock);
+        	nd->mnt = current->fs->pwdmnt;
+        	nd->dentry = current->fs->pwd;
+        	read_unlock(&current->fs->lock);
+	}
+	nd->flags |= LOOKUP_LOCKED;
+        return (path_walk(name, nd));
+}
+
 /*
  * Restricted form of lookup. Doesn't follow links, single-component only,
  * needs parent already locked. Doesn't follow mounts.
@@ -1316,8 +1386,7 @@
 		struct dentry *dentry;
 		struct nameidata nd;
 
-		if (path_init(tmp, LOOKUP_PARENT, &nd))
-			error = path_walk(tmp, &nd);
+		error = path_init_walk(tmp, LOOKUP_PARENT, &nd);
 		if (error)
 			goto out;
 		dentry = lookup_create(&nd, 1);
diff -Nru linux/fs/namespace.c linux-fastwalk/fs/namespace.c
--- linux/fs/namespace.c	Fri Dec 21 09:41:55 2001
+++ linux-fastwalk/fs/namespace.c	Wed Feb 13 11:25:44 2002
@@ -375,8 +375,7 @@
 	if (IS_ERR(kname))
 		goto out;
 	retval = 0;
-	if (path_init(kname, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &nd))
-		retval = path_walk(kname, &nd);
+	retval = path_init_walk(kname, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &nd);
 	putname(kname);
 	if (retval)
 		goto out;
@@ -505,8 +504,7 @@
 		return err;
 	if (!old_name || !*old_name)
 		return -EINVAL;
-	if (path_init(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd))
-		err = path_walk(old_name, &old_nd);
+	err = path_init_walk(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd);
 	if (err)
 		return err;
 
@@ -669,8 +667,7 @@
 	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV);
 
 	/* ... and get the mountpoint */
-	if (path_init(dir_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
-		retval = path_walk(dir_name, &nd);
+	retval = path_init_walk(dir_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd);
 	if (retval)
 		return retval;
 
@@ -780,8 +777,7 @@
 	if (IS_ERR(name))
 		goto out0;
 	error = 0;
-	if (path_init(name, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &new_nd))
-		error = path_walk(name, &new_nd);
+	error = path_init_walk(name, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &new_nd);
 	putname(name);
 	if (error)
 		goto out0;
@@ -794,8 +790,7 @@
 	if (IS_ERR(name))
 		goto out1;
 	error = 0;
-	if (path_init(name, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &old_nd))
-		error = path_walk(name, &old_nd);
+	error = path_init_walk(name, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &old_nd);
 	putname(name);
 	if (error)
 		goto out1;
@@ -985,8 +980,7 @@
 	old_rootmnt = mntget(current->fs->rootmnt);
 	read_unlock(&current->fs->lock);
 	/*  First unmount devfs if mounted  */
-	if (path_init("/dev", LOOKUP_FOLLOW|LOOKUP_POSITIVE, &devfs_nd))
-		error = path_walk("/dev", &devfs_nd);
+	error = path_init_walk("/dev", LOOKUP_FOLLOW|LOOKUP_POSITIVE, &devfs_nd);
 	if (!error) {
 		if (devfs_nd.mnt->mnt_sb->s_magic == DEVFS_SUPER_MAGIC &&
 		    devfs_nd.dentry == devfs_nd.mnt->mnt_root) {
@@ -1009,8 +1003,7 @@
 	 * Get the new mount directory
 	 */
 	error = 0;
-	if (path_init(put_old, LOOKUP_FOLLOW|LOOKUP_POSITIVE|LOOKUP_DIRECTORY, &nd))
-		error = path_walk(put_old, &nd);
+	error = path_init_walk(put_old, LOOKUP_FOLLOW|LOOKUP_POSITIVE|LOOKUP_DIRECTORY, &nd);
 	if (error) {
 		int blivet;
 		struct block_device *ramdisk = old_rootmnt->mnt_sb->s_bdev;
diff -Nru linux/fs/open.c linux-fastwalk/fs/open.c
--- linux/fs/open.c	Fri Oct 12 13:48:42 2001
+++ linux-fastwalk/fs/open.c	Wed Feb 13 11:25:44 2002
@@ -368,8 +368,7 @@
 		goto out;
 
 	error = 0;
-	if (path_init(name,LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY,&nd))
-		error = path_walk(name, &nd);
+	error = path_init_walk(name,LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY,&nd);
 	putname(name);
 	if (error)
 		goto out;
@@ -427,9 +426,8 @@
 	if (IS_ERR(name))
 		goto out;
 
-	path_init(name, LOOKUP_POSITIVE | LOOKUP_FOLLOW |
+	error = path_init_walk(name, LOOKUP_POSITIVE | LOOKUP_FOLLOW |
 		      LOOKUP_DIRECTORY | LOOKUP_NOALT, &nd);
-	error = path_walk(name, &nd);	
 	putname(name);
 	if (error)
 		goto out;
diff -Nru linux/fs/super.c linux-fastwalk/fs/super.c
--- linux/fs/super.c	Fri Dec 21 09:42:03 2001
+++ linux-fastwalk/fs/super.c	Wed Feb 13 11:25:44 2002
@@ -548,8 +548,7 @@
 	/* What device it is? */
 	if (!dev_name || !*dev_name)
 		return ERR_PTR(-EINVAL);
-	if (path_init(dev_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
-		error = path_walk(dev_name, &nd);
+	error = path_init_walk(dev_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd);
 	if (error)
 		return ERR_PTR(error);
 	inode = nd.dentry->d_inode;
diff -Nru linux/include/linux/dcache.h linux-fastwalk/include/linux/dcache.h
--- linux/include/linux/dcache.h	Thu Nov 22 11:46:18 2001
+++ linux-fastwalk/include/linux/dcache.h	Wed Feb 13 11:25:44 2002
@@ -218,6 +218,7 @@
 
 /* appendix may either be NULL or be used for transname suffixes */
 extern struct dentry * d_lookup(struct dentry *, struct qstr *);
+extern struct dentry * __d_lookup(struct dentry *, struct qstr *);
 
 /* validate "insecure" dentry pointer */
 extern int d_validate(struct dentry *, struct dentry *);
diff -Nru linux/include/linux/fs.h linux-fastwalk/include/linux/fs.h
--- linux/include/linux/fs.h	Fri Dec 21 09:42:03 2001
+++ linux-fastwalk/include/linux/fs.h	Wed Feb 13 11:25:44 2002
@@ -1270,6 +1270,7 @@
  *  - require a directory
  *  - ending slashes ok even for nonexistent files
  *  - internal "there are more path compnents" flag
+ *  - locked on when the dcache_lock is held 
  */
 #define LOOKUP_FOLLOW		(1)
 #define LOOKUP_DIRECTORY	(2)
@@ -1277,6 +1278,8 @@
 #define LOOKUP_POSITIVE		(8)
 #define LOOKUP_PARENT		(16)
 #define LOOKUP_NOALT		(32)
+#define LOOKUP_LOCKED		(64)
+
 /*
  * Type of the last component on LOOKUP_PARENT
  */
@@ -1306,6 +1309,7 @@
 extern int FASTCALL(__user_walk(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_init(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_walk(const char *, struct nameidata *));
+extern int FASTCALL(path_init_walk(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(link_path_walk(const char *, struct nameidata *));
 extern void path_release(struct nameidata *);
 extern int follow_down(struct vfsmount **, struct dentry **);
diff -Nru linux/kernel/ksyms.c linux-fastwalk/kernel/ksyms.c
--- linux/kernel/ksyms.c	Fri Dec 21 09:42:04 2001
+++ linux-fastwalk/kernel/ksyms.c	Wed Feb 13 11:25:44 2002
@@ -144,6 +144,7 @@
 EXPORT_SYMBOL(lookup_mnt);
 EXPORT_SYMBOL(path_init);
 EXPORT_SYMBOL(path_walk);
+EXPORT_SYMBOL(path_init_walk);
 EXPORT_SYMBOL(path_release);
 EXPORT_SYMBOL(__user_walk);
 EXPORT_SYMBOL(lookup_one_len);

