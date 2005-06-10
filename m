Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVFJTGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVFJTGB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 15:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVFJTGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 15:06:01 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:50305 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261177AbVFJTFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 15:05:20 -0400
Subject: Re: [PATCH] vfs: namei operations should pass nameidata when
	available
From: Ram <linuxram@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Mahoney <jeffm@suse.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050328201728.GA12668@infradead.org>
References: <20050328200617.GA13280@locomotive.unixthugs.org>
	 <20050328201728.GA12668@infradead.org>
Content-Type: multipart/mixed; boundary="=-MIjAp6Qm2qbRkU5krvFI"
Organization: IBM 
Message-Id: <1118430311.4227.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 10 Jun 2005 12:05:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MIjAp6Qm2qbRkU5krvFI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-03-28 at 12:17, Christoph Hellwig wrote:
> > +	dentry = __lookup_hash(&nd->last, nd->dentry, nd);
> 
> Please add a tiny wrapper lookup_hash_nd(struct nameidata *nd)
> that expands to the above instead of opencoding it everywhere.
> 
> Or just call it lookup_hash() after you removed the original version..

Jeff,

   I have incorporated the Christophs' comments. 
   lookup_hash() now takes a third
   nameidata argument. I touch tested it. If you like the patch can
   your forward it to Andrew.

Thanks,
RP

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=-MIjAp6Qm2qbRkU5krvFI
Content-Disposition: attachment; filename=lookup.patch
Content-Type: text/x-patch; name=lookup.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

diff -Nrup -X dontdiff /home/linux/views/linux-2.6.12-rc4/drivers/usb/core/inode.c linux-2.6.12-rc4/drivers/usb/core/inode.c
--- /home/linux/views/linux-2.6.12-rc4/drivers/usb/core/inode.c	2005-05-06 23:22:26.000000000 -0700
+++ linux-2.6.12-rc4/drivers/usb/core/inode.c	2005-05-23 13:41:10.000000000 -0700
@@ -460,7 +460,7 @@ static struct dentry * get_dentry(struct
 	qstr.name = name;
 	qstr.len = strlen(name);
 	qstr.hash = full_name_hash(name,qstr.len);
-	return lookup_hash(&qstr,parent);
+	return lookup_hash(&qstr,parent,NULL);
 }               
 
 
diff -Nrup -X dontdiff /home/linux/views/linux-2.6.12-rc4/fs/debugfs/inode.c linux-2.6.12-rc4/fs/debugfs/inode.c
--- /home/linux/views/linux-2.6.12-rc4/fs/debugfs/inode.c	2005-03-02 02:59:59.000000000 -0800
+++ linux-2.6.12-rc4/fs/debugfs/inode.c	2005-05-23 13:41:46.000000000 -0700
@@ -117,7 +117,7 @@ static struct dentry * get_dentry(struct
 	qstr.name = name;
 	qstr.len = strlen(name);
 	qstr.hash = full_name_hash(name,qstr.len);
-	return lookup_hash(&qstr,parent);
+	return lookup_hash(&qstr,parent,NULL);
 }               
 
 static struct super_block *debug_get_sb(struct file_system_type *fs_type,
diff -Nrup -X dontdiff /home/linux/views/linux-2.6.12-rc4/fs/ext3/super.c linux-2.6.12-rc4/fs/ext3/super.c
--- /home/linux/views/linux-2.6.12-rc4/fs/ext3/super.c	2005-05-06 23:22:29.000000000 -0700
+++ linux-2.6.12-rc4/fs/ext3/super.c	2005-05-23 13:42:07.000000000 -0700
@@ -2346,7 +2346,7 @@ static int ext3_quota_on_mount(struct su
 			     .hash = 0,
 			     .len = strlen(EXT3_SB(sb)->s_qf_names[type])};
 
-	dentry = lookup_hash(&name, sb->s_root);
+	dentry = lookup_hash(&name, sb->s_root, NULL);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 	err = vfs_quota_on_mount(type, EXT3_SB(sb)->s_jquota_fmt, dentry);
diff -Nrup -X dontdiff /home/linux/views/linux-2.6.12-rc4/fs/namei.c linux-2.6.12-rc4/fs/namei.c
--- /home/linux/views/linux-2.6.12-rc4/fs/namei.c	2005-05-06 23:22:29.000000000 -0700
+++ linux-2.6.12-rc4/fs/namei.c	2005-05-23 13:42:56.000000000 -0700
@@ -1075,9 +1075,10 @@ out:
 	return dentry;
 }
 
-struct dentry * lookup_hash(struct qstr *name, struct dentry * base)
+struct dentry * lookup_hash(struct qstr *name, struct dentry * base, 
+			struct nameidata *nd)
 {
-	return __lookup_hash(name, base, NULL);
+	return __lookup_hash(name, base, nd);
 }
 
 /* SMP-safe */
@@ -1101,7 +1102,7 @@ struct dentry * lookup_one_len(const cha
 	}
 	this.hash = end_name_hash(hash);
 
-	return lookup_hash(&this, base);
+	return lookup_hash(&this, base, NULL);
 access:
 	return ERR_PTR(-EACCES);
 }
@@ -1568,7 +1569,7 @@ struct dentry *lookup_create(struct name
 	if (nd->last_type != LAST_NORM)
 		goto fail;
 	nd->flags &= ~LOOKUP_PARENT;
-	dentry = lookup_hash(&nd->last, nd->dentry);
+	dentry = lookup_hash(&nd->last, nd->dentry, nd);
 	if (IS_ERR(dentry))
 		goto fail;
 	if (!is_dir && nd->last.name[nd->last.len] && !dentry->d_inode)
@@ -1800,7 +1801,7 @@ asmlinkage long sys_rmdir(const char __u
 			goto exit1;
 	}
 	down(&nd.dentry->d_inode->i_sem);
-	dentry = lookup_hash(&nd.last, nd.dentry);
+	dentry = lookup_hash(&nd.last, nd.dentry, &nd);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 		error = vfs_rmdir(nd.dentry->d_inode, dentry);
@@ -1869,7 +1870,7 @@ asmlinkage long sys_unlink(const char __
 	if (nd.last_type != LAST_NORM)
 		goto exit1;
 	down(&nd.dentry->d_inode->i_sem);
-	dentry = lookup_hash(&nd.last, nd.dentry);
+	dentry = lookup_hash(&nd.last, nd.dentry, &nd);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 		/* Why not before? Because we want correct error value */
@@ -2218,7 +2219,7 @@ static inline int do_rename(const char *
 
 	trap = lock_rename(new_dir, old_dir);
 
-	old_dentry = lookup_hash(&oldnd.last, old_dir);
+	old_dentry = lookup_hash(&oldnd.last, old_dir, &oldnd);
 	error = PTR_ERR(old_dentry);
 	if (IS_ERR(old_dentry))
 		goto exit3;
@@ -2238,7 +2239,7 @@ static inline int do_rename(const char *
 	error = -EINVAL;
 	if (old_dentry == trap)
 		goto exit4;
-	new_dentry = lookup_hash(&newnd.last, new_dir);
+	new_dentry = lookup_hash(&newnd.last, new_dir, &newnd);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
 		goto exit4;
diff -Nrup -X dontdiff /home/linux/views/linux-2.6.12-rc4/fs/reiserfs/super.c linux-2.6.12-rc4/fs/reiserfs/super.c
--- /home/linux/views/linux-2.6.12-rc4/fs/reiserfs/super.c	2005-05-06 23:22:29.000000000 -0700
+++ linux-2.6.12-rc4/fs/reiserfs/super.c	2005-05-23 13:43:11.000000000 -0700
@@ -1941,7 +1941,7 @@ static int reiserfs_quota_on_mount(struc
                          .hash = 0,
                          .len = strlen(REISERFS_SB(sb)->s_qf_names[type])};
 
-    dentry = lookup_hash(&name, sb->s_root);
+    dentry = lookup_hash(&name, sb->s_root, NULL);
     if (IS_ERR(dentry))
             return PTR_ERR(dentry);
     err = vfs_quota_on_mount(type, REISERFS_SB(sb)->s_jquota_fmt, dentry);
diff -Nrup -X dontdiff /home/linux/views/linux-2.6.12-rc4/fs/sysfs/inode.c linux-2.6.12-rc4/fs/sysfs/inode.c
--- /home/linux/views/linux-2.6.12-rc4/fs/sysfs/inode.c	2005-05-06 23:22:30.000000000 -0700
+++ linux-2.6.12-rc4/fs/sysfs/inode.c	2005-05-23 13:43:35.000000000 -0700
@@ -83,7 +83,7 @@ struct dentry * sysfs_get_dentry(struct 
 	qstr.name = name;
 	qstr.len = strlen(name);
 	qstr.hash = full_name_hash(name,qstr.len);
-	return lookup_hash(&qstr,parent);
+	return lookup_hash(&qstr,parent,NULL);
 }
 
 /*
diff -Nrup -X dontdiff /home/linux/views/linux-2.6.12-rc4/include/linux/namei.h linux-2.6.12-rc4/include/linux/namei.h
--- /home/linux/views/linux-2.6.12-rc4/include/linux/namei.h	2005-05-06 23:22:33.000000000 -0700
+++ linux-2.6.12-rc4/include/linux/namei.h	2005-05-23 13:28:44.000000000 -0700
@@ -66,7 +66,8 @@ extern void path_release(struct nameidat
 extern void path_release_on_umount(struct nameidata *);
 
 extern struct dentry * lookup_one_len(const char *, struct dentry *, int);
-extern struct dentry * lookup_hash(struct qstr *, struct dentry *);
+extern struct dentry * lookup_hash(struct qstr *, struct dentry *, 
+		struct nameidata *);
 
 extern int follow_down(struct vfsmount **, struct dentry **);
 extern int follow_up(struct vfsmount **, struct dentry **);
diff -Nrup -X dontdiff /home/linux/views/linux-2.6.12-rc4/net/sunrpc/rpc_pipe.c linux-2.6.12-rc4/net/sunrpc/rpc_pipe.c
--- /home/linux/views/linux-2.6.12-rc4/net/sunrpc/rpc_pipe.c	2005-03-02 03:00:24.000000000 -0800
+++ linux-2.6.12-rc4/net/sunrpc/rpc_pipe.c	2005-05-23 13:51:08.000000000 -0700
@@ -601,7 +601,7 @@ rpc_lookup_negative(char *path, struct n
 		return ERR_PTR(error);
 	dir = nd->dentry->d_inode;
 	down(&dir->i_sem);
-	dentry = lookup_hash(&nd->last, nd->dentry);
+	dentry = lookup_hash(&nd->last, nd->dentry, nd);
 	if (IS_ERR(dentry))
 		goto out_err;
 	if (dentry->d_inode) {
@@ -663,7 +663,7 @@ rpc_rmdir(char *path)
 		return error;
 	dir = nd.dentry->d_inode;
 	down(&dir->i_sem);
-	dentry = lookup_hash(&nd.last, nd.dentry);
+	dentry = lookup_hash(&nd.last, nd.dentry, &nd);
 	if (IS_ERR(dentry)) {
 		error = PTR_ERR(dentry);
 		goto out_release;
@@ -724,7 +724,7 @@ rpc_unlink(char *path)
 		return error;
 	dir = nd.dentry->d_inode;
 	down(&dir->i_sem);
-	dentry = lookup_hash(&nd.last, nd.dentry);
+	dentry = lookup_hash(&nd.last, nd.dentry, &nd);
 	if (IS_ERR(dentry)) {
 		error = PTR_ERR(dentry);
 		goto out_release;
diff -Nrup -X dontdiff /home/linux/views/linux-2.6.12-rc4/net/unix/af_unix.c linux-2.6.12-rc4/net/unix/af_unix.c
--- /home/linux/views/linux-2.6.12-rc4/net/unix/af_unix.c	2005-05-06 23:22:35.000000000 -0700
+++ linux-2.6.12-rc4/net/unix/af_unix.c	2005-05-23 13:51:22.000000000 -0700
@@ -784,7 +784,7 @@ static int unix_bind(struct socket *sock
 		/*
 		 * Do the final lookup.
 		 */
-		dentry = lookup_hash(&nd.last, nd.dentry);
+		dentry = lookup_hash(&nd.last, nd.dentry, &nd);
 		err = PTR_ERR(dentry);
 		if (IS_ERR(dentry))
 			goto out_mknod_unlock;

--=-MIjAp6Qm2qbRkU5krvFI--

