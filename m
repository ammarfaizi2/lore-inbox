Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbTGBSPj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 14:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264328AbTGBSPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 14:15:38 -0400
Received: from gprs2-63.eurotel.cz ([160.218.145.63]:3051 "EHLO
	exuhome.dyn.jankratochvil.net") by vger.kernel.org with ESMTP
	id S264277AbTGBSOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 14:14:40 -0400
Date: Wed, 2 Jul 2003 20:28:18 +0200
From: Jan Kratochvil 
	<rcpt-linux-kernel.AT.vger.kernel.org@jankratochvil.net>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       chaffee@cs.berkeley.edu, zippel@linux-m68k.org
Subject: Re: [PATCH] vfat+affs case preservation
Message-ID: <20030702182818.GB17979@exuhome.dyn.jankratochvil.net>
References: <20030702102538.GA16711@exuhome.dyn.jankratochvil.net> <20030702103457.GS27348@parcelfarce.linux.theplanet.co.uk> <20030702105328.GA17023@exuhome.dyn.jankratochvil.net> <20030702120426.GU27348@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702120426.GU27348@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 02 Jul 2003 14:04:27 +0200, viro@parcelfarce.linux.theplanet.co.uk wrote:
...
> Obvious example of bad behaviour:

Thanks, each directory really must be represented by at most one dentry.
Updated patch changes order of vfs_rename() dentry locking from (old,new)
to (new,old) to get the 'new' filename in the target letter-case even for
directory entries.

Unfortunately rename("dir","DIR") will be nop if some file in dir/ is currently
open ("dir" dentry in use). This is not a serious issue for Samba-over-vfat.
One way would be to use target filename string instead of target dentry in
inode_operations->rename() although it would need updating of all filesystems.

http://www.jankratochvil.net/priv/vfat/linux-2.4.22-pre2-vfat7.diff
http://www.jankratochvil.net/priv/vfat/linux-2.5.73-bk10-vfat7.diff


Lace


linux-2.5.73-bk10-vfat7.diff:

diff -u -ru linux-2.5.73-bk10-orig/Documentation/filesystems/vfs.txt linux-2.5.73-bk10-vfat7/Documentation/filesystems/vfs.txt
--- linux-2.5.73-bk10-orig/Documentation/filesystems/vfs.txt	Tue May 27 03:00:43 2003
+++ linux-2.5.73-bk10-vfat7/Documentation/filesystems/vfs.txt	Mon Jun 30 18:45:06 2003
@@ -419,6 +419,7 @@
 	int (*d_revalidate)(struct dentry *);
 	int (*d_hash) (struct dentry *, struct qstr *);
 	int (*d_compare) (struct dentry *, struct qstr *, struct qstr *);
+	int (*d_compare_rename) (struct dentry *, struct qstr *, struct qstr *);
 	void (*d_delete)(struct dentry *);
 	void (*d_release)(struct dentry *);
 	void (*d_iput)(struct dentry *, struct inode *);
@@ -431,7 +432,13 @@
 
   d_hash: called when the VFS adds a dentry to the hash table
 
-  d_compare: called when a dentry should be compared with another
+  d_compare: called when a dentry should be compared with another.
+	Case-sensitive for all case-preserving filesystems no matter if the
+	filesystem structure is case-sensitive itself
+
+  d_compare_rename: compare equivalency of two dentries no matter their case.
+	This method is optional - useful for case-insensitive case-preserving
+	filesystems. dentries are simply compared by d_compare if not provided
 
   d_delete: called when the last reference to a dentry is
 	deleted. This means no-one is using the dentry, however it is
diff -u -ru linux-2.5.73-bk10-orig/fs/affs/namei.c linux-2.5.73-bk10-vfat7/fs/affs/namei.c
--- linux-2.5.73-bk10-orig/fs/affs/namei.c	Tue May 27 03:00:27 2003
+++ linux-2.5.73-bk10-vfat7/fs/affs/namei.c	Wed Jul  2 19:23:37 2003
@@ -25,24 +25,35 @@
 
 extern struct inode_operations affs_symlink_inode_operations;
 
-static int	 affs_toupper(int ch);
-static int	 affs_hash_dentry(struct dentry *, struct qstr *);
-static int       affs_compare_dentry(struct dentry *, struct qstr *, struct qstr *);
-static int	 affs_intl_toupper(int ch);
-static int	 affs_intl_hash_dentry(struct dentry *, struct qstr *);
-static int       affs_intl_compare_dentry(struct dentry *, struct qstr *, struct qstr *);
+static int affs_strict_toupper(int ch);
+static int affs_toupper(int ch);
+static int affs_intl_toupper(int ch);
+static int affs_hash_strictcase_dentry(struct dentry *, struct qstr *);
+static int affs_compare_strictcase_dentry(struct dentry *, struct qstr *, struct qstr *);
+static int affs_compare_anycase_dentry(struct dentry *, struct qstr *, struct qstr *);
+static int affs_intl_compare_anycase_dentry(struct dentry *, struct qstr *, struct qstr *);
 
 struct dentry_operations affs_dentry_operations = {
-	.d_hash		= affs_hash_dentry,
-	.d_compare	= affs_compare_dentry,
+	.d_hash			= affs_hash_strictcase_dentry,
+	.d_compare		= affs_compare_strictcase_dentry,
+	.d_compare_rename	= affs_compare_anycase_dentry,
 };
 
 struct dentry_operations affs_intl_dentry_operations = {
-	.d_hash		= affs_intl_hash_dentry,
-	.d_compare	= affs_intl_compare_dentry,
+	.d_hash			= affs_hash_strictcase_dentry,
+	.d_compare		= affs_compare_strictcase_dentry,
+	.d_compare_rename	= affs_intl_compare_anycase_dentry,
 };
 
 
+/* toupper() for case-sensitive dentries matching */
+
+static int
+affs_strict_toupper(int ch)
+{
+	return ch;
+}
+
 /* Simple toupper() for DOS\1 */
 
 static int
@@ -91,14 +102,9 @@
 }
 
 static int
-affs_hash_dentry(struct dentry *dentry, struct qstr *qstr)
-{
-	return __affs_hash_dentry(dentry, qstr, affs_toupper);
-}
-static int
-affs_intl_hash_dentry(struct dentry *dentry, struct qstr *qstr)
+affs_hash_strictcase_dentry(struct dentry *dentry, struct qstr *qstr)
 {
-	return __affs_hash_dentry(dentry, qstr, affs_intl_toupper);
+	return __affs_hash_dentry(dentry, qstr, affs_strict_toupper);
 }
 
 static inline int
@@ -134,12 +140,17 @@
 }
 
 static int
-affs_compare_dentry(struct dentry *dentry, struct qstr *a, struct qstr *b)
+affs_compare_strictcase_dentry(struct dentry *dentry, struct qstr *a, struct qstr *b)
+{
+	return __affs_compare_dentry(dentry, a, b, affs_strict_toupper);
+}
+static int
+affs_compare_anycase_dentry(struct dentry *dentry, struct qstr *a, struct qstr *b)
 {
 	return __affs_compare_dentry(dentry, a, b, affs_toupper);
 }
 static int
-affs_intl_compare_dentry(struct dentry *dentry, struct qstr *a, struct qstr *b)
+affs_intl_compare_anycase_dentry(struct dentry *dentry, struct qstr *a, struct qstr *b)
 {
 	return __affs_compare_dentry(dentry, a, b, affs_intl_toupper);
 }
@@ -226,6 +237,7 @@
 	}
 	if (bh) {
 		u32 ino = bh->b_blocknr;
+		struct dentry *alias;
 
 		/* store the real header ino in d_fsdata for faster lookups */
 		dentry->d_fsdata = (void *)(long)ino;
@@ -240,6 +252,15 @@
 		if (!inode) {
 			return ERR_PTR(-EACCES);
 		}
+		alias = d_find_alias(inode);
+		if (alias) {
+			if (d_invalidate(alias)==0)
+				dput(alias);
+			else {
+				iput(inode);
+				return alias;
+			}
+		}
 	}
 	dentry->d_op = AFFS_SB(sb)->s_flags & SF_INTL ? &affs_intl_dentry_operations : &affs_dentry_operations;
 	d_add(dentry, inode);
@@ -423,7 +444,11 @@
 		return retval;
 
 	/* Unlink destination if it already exists */
-	if (new_dentry->d_inode) {
+	if (new_dentry->d_inode
+	    /* Do not remove case-different aliases twice.
+	     * Hardlinks cannot be passed here - checked at top of vfs_rename().
+	     */
+	    && old_dentry->d_inode != new_dentry->d_inode) {
 		retval = affs_remove_header(new_dentry);
 		if (retval)
 			return retval;
diff -u -ru linux-2.5.73-bk10-orig/fs/namei.c linux-2.5.73-bk10-vfat7/fs/namei.c
--- linux-2.5.73-bk10-orig/fs/namei.c	Mon Jun 30 17:35:52 2003
+++ linux-2.5.73-bk10-vfat7/fs/namei.c	Wed Jul  2 19:47:08 2003
@@ -1893,6 +1893,8 @@
 		return error;
 
 	target = new_dentry->d_inode;
+	if (old_dentry == new_dentry)
+		target = NULL;
 	if (target) {
 		down(&target->i_sem);
 		d_unhash(new_dentry);
@@ -1910,7 +1912,8 @@
 		dput(new_dentry);
 	}
 	if (!error) {
-		d_move(old_dentry,new_dentry);
+		if (old_dentry != new_dentry)
+			d_move(old_dentry,new_dentry);
 		security_inode_post_rename(old_dir, old_dentry,
 					   new_dir, new_dentry);
 	}
@@ -1937,7 +1940,8 @@
 		error = old_dir->i_op->rename(old_dir, old_dentry, new_dir, new_dentry);
 	if (!error) {
 		/* The following d_move() should become unconditional */
-		if (!(old_dir->i_sb->s_type->fs_flags & FS_ODD_RENAME))
+		if (!(old_dir->i_sb->s_type->fs_flags & FS_ODD_RENAME)
+		    && old_dentry != new_dentry)
 			d_move(old_dentry, new_dentry);
 		security_inode_post_rename(old_dir, old_dentry, new_dir, new_dentry);
 	}
@@ -1953,9 +1957,19 @@
 	int error;
 	int is_dir = S_ISDIR(old_dentry->d_inode->i_mode);
 
-	if (old_dentry->d_inode == new_dentry->d_inode)
- 		return 0;
- 
+	/*
+	 * Rename to the same inode but possibly different name.
+	 * Pass such call only to case-insensitive case-preserving filesystems
+	 * (vfat) implementing d_compare_rename. Other filesystems would crash
+	 * as they do not expect rename to the same target inode.
+	 * Renaming devoted to johanka.
+	 */
+	if (old_dentry->d_inode == new_dentry->d_inode
+	    && (!old_dentry->d_op || !old_dentry->d_op->d_compare_rename
+	        || (old_dir != new_dir
+	            || old_dentry->d_op->d_compare_rename(old_dentry, &old_dentry->d_name, &new_dentry->d_name))))
+		return 0;
+
 	error = may_delete(old_dir, old_dentry, is_dir);
 	if (error)
 		return error;
@@ -2019,41 +2033,46 @@
 
 	trap = lock_rename(new_dir, old_dir);
 
+	/*
+	 * Lookup 'new' name first to get the target filename in the wanted
+	 * letter-case on case-insensitive case-preserving filesystems.
+	 * The case of 'old' name does not matter for these filesystems.
+	 */
+	new_dentry = lookup_hash(&newnd.last, new_dir);
+	error = PTR_ERR(new_dentry);
+	if (IS_ERR(new_dentry))
+		goto exit3;
+	/* source should not be ancestor of target if not case-change rename */
+	error = -ENOTEMPTY;
+	if (new_dentry == trap && old_dir != new_dir)
+		goto exit4;
 	old_dentry = lookup_hash(&oldnd.last, old_dir);
 	error = PTR_ERR(old_dentry);
 	if (IS_ERR(old_dentry))
-		goto exit3;
+		goto exit4;
 	/* source must exist */
 	error = -ENOENT;
 	if (!old_dentry->d_inode)
-		goto exit4;
+		goto exit5;
 	/* unless the source is a directory trailing slashes give -ENOTDIR */
 	if (!S_ISDIR(old_dentry->d_inode->i_mode)) {
 		error = -ENOTDIR;
 		if (oldnd.last.name[oldnd.last.len])
-			goto exit4;
+			goto exit5;
 		if (newnd.last.name[newnd.last.len])
-			goto exit4;
+			goto exit5;
 	}
-	/* source should not be ancestor of target */
+	/* source should not be ancestor of target if not case-change rename */
 	error = -EINVAL;
-	if (old_dentry == trap)
-		goto exit4;
-	new_dentry = lookup_hash(&newnd.last, new_dir);
-	error = PTR_ERR(new_dentry);
-	if (IS_ERR(new_dentry))
-		goto exit4;
-	/* target should not be an ancestor of source */
-	error = -ENOTEMPTY;
-	if (new_dentry == trap)
+	if (old_dentry == trap && old_dir != new_dir)
 		goto exit5;
 
 	error = vfs_rename(old_dir->d_inode, old_dentry,
 				   new_dir->d_inode, new_dentry);
 exit5:
-	dput(new_dentry);
-exit4:
 	dput(old_dentry);
+exit4:
+	dput(new_dentry);
 exit3:
 	unlock_rename(new_dir, old_dir);
 exit2:
diff -u -ru linux-2.5.73-bk10-orig/fs/vfat/namei.c linux-2.5.73-bk10-vfat7/fs/vfat/namei.c
--- linux-2.5.73-bk10-orig/fs/vfat/namei.c	Mon Jun 30 17:35:12 2003
+++ linux-2.5.73-bk10-vfat7/fs/vfat/namei.c	Wed Jul  2 19:53:24 2003
@@ -41,7 +41,6 @@
 #  define PRINTK3(x)
 #endif
 
-static int vfat_hashi(struct dentry *parent, struct qstr *qstr);
 static int vfat_hash(struct dentry *parent, struct qstr *qstr);
 static int vfat_cmpi(struct dentry *dentry, struct qstr *a, struct qstr *b);
 static int vfat_cmp(struct dentry *dentry, struct qstr *a, struct qstr *b);
@@ -49,22 +48,24 @@
 
 static struct dentry_operations vfat_dentry_ops[4] = {
 	{
-		.d_hash		= vfat_hashi,
-		.d_compare	= vfat_cmpi,
+		.d_hash			= vfat_hash,
+		.d_compare		= vfat_cmp,
+		.d_compare_rename	= vfat_cmpi,
 	},
 	{
-		.d_revalidate	= vfat_revalidate,
-		.d_hash		= vfat_hashi,
-		.d_compare	= vfat_cmpi,
+		.d_revalidate		= vfat_revalidate,
+		.d_hash			= vfat_hash,
+		.d_compare		= vfat_cmp,
+		.d_compare_rename	= vfat_cmpi,
 	},
 	{
-		.d_hash		= vfat_hash,
-		.d_compare	= vfat_cmp,
+		.d_hash			= vfat_hash,
+		.d_compare		= vfat_cmp,
 	},
 	{
-		.d_revalidate	= vfat_revalidate,
-		.d_hash		= vfat_hash,
-		.d_compare	= vfat_cmp,
+		.d_revalidate		= vfat_revalidate,
+		.d_hash			= vfat_hash,
+		.d_compare		= vfat_cmp,
 	}
 };
 
@@ -129,32 +130,6 @@
 }
 
 /*
- * Compute the hash for the vfat name corresponding to the dentry.
- * Note: if the name is invalid, we leave the hash code unchanged so
- * that the existing dentry can be used. The vfat fs routines will
- * return ENOENT or EINVAL as appropriate.
- */
-static int vfat_hashi(struct dentry *dentry, struct qstr *qstr)
-{
-	struct nls_table *t = MSDOS_SB(dentry->d_inode->i_sb)->nls_io;
-	const char *name;
-	int len;
-	unsigned long hash;
-
-	len = qstr->len;
-	name = qstr->name;
-	while (len && name[len-1] == '.')
-		len--;
-
-	hash = init_name_hash();
-	while (len--)
-		hash = partial_name_hash(vfat_tolower(t, *name++), hash);
-	qstr->hash = end_name_hash(hash);
-
-	return 0;
-}
-
-/*
  * Case insensitive compare of two vfat names.
  */
 static int vfat_cmpi(struct dentry *dentry, struct qstr *a, struct qstr *b)
@@ -1082,11 +1057,14 @@
 	loff_t dotdot_i_pos;
 	struct inode *old_inode, *new_inode;
 	int res, is_dir;
-	struct vfat_slot_info old_sinfo,sinfo;
+	struct vfat_slot_info old_sinfo,new_sinfo;
 
 	old_bh = new_bh = dotdot_bh = NULL;
 	old_inode = old_dentry->d_inode;
 	new_inode = new_dentry->d_inode;
+	/* Rename of case-different aliases in the same dir. */
+	if (old_inode == new_inode)
+		new_inode = NULL;
 	lock_kernel();
 	res = vfat_find(old_dir,&old_dentry->d_name,&old_sinfo,&old_bh,&old_de);
 	PRINTK3(("vfat_rename 2\n"));
@@ -1098,10 +1076,10 @@
 				&dotdot_de,&dotdot_i_pos)) < 0)
 		goto rename_done;
 
-	if (new_dentry->d_inode) {
-		res = vfat_find(new_dir,&new_dentry->d_name,&sinfo,&new_bh,
+	if (new_inode) {
+		res = vfat_find(new_dir,&new_dentry->d_name,&new_sinfo,&new_bh,
 				&new_de);
-		if (res < 0 || MSDOS_I(new_inode)->i_pos != sinfo.i_pos) {
+		if (res < 0 || MSDOS_I(new_inode)->i_pos != new_sinfo.i_pos) {
 			/* WTF??? Cry and fail. */
 			printk(KERN_WARNING "vfat_rename: fs corrupted\n");
 			goto rename_done;
@@ -1112,11 +1090,10 @@
 			if (res)
 				goto rename_done;
 		}
+		/* releases new_bh */
+		vfat_remove_entry(new_dir,&new_sinfo,new_bh,new_de);
+		new_bh=NULL;
 		fat_detach(new_inode);
-	} else {
-		res = vfat_add_entry(new_dir,&new_dentry->d_name,is_dir,&sinfo,
-					&new_bh,&new_de);
-		if (res < 0) goto rename_done;
 	}
 
 	new_dir->i_version++;
@@ -1124,8 +1101,12 @@
 	/* releases old_bh */
 	vfat_remove_entry(old_dir,&old_sinfo,old_bh,old_de);
 	old_bh=NULL;
+	res = vfat_add_entry(new_dir,&new_dentry->d_name,is_dir,&new_sinfo,
+				&new_bh,&new_de);
+	if (res < 0) goto rename_done;
+
 	fat_detach(old_inode);
-	fat_attach(old_inode, sinfo.i_pos);
+	fat_attach(old_inode, new_sinfo.i_pos);
 	mark_inode_dirty(old_inode);
 
 	old_dir->i_version++;
diff -u -ru linux-2.5.73-bk10-orig/include/linux/dcache.h linux-2.5.73-bk10-vfat7/include/linux/dcache.h
--- linux-2.5.73-bk10-orig/include/linux/dcache.h	Mon Jun 30 17:35:17 2003
+++ linux-2.5.73-bk10-vfat7/include/linux/dcache.h	Mon Jun 30 18:44:33 2003
@@ -109,6 +109,7 @@
 	int (*d_revalidate)(struct dentry *, int);
 	int (*d_hash) (struct dentry *, struct qstr *);
 	int (*d_compare) (struct dentry *, struct qstr *, struct qstr *);
+	int (*d_compare_rename) (struct dentry *, struct qstr *, struct qstr *);
 	int (*d_delete)(struct dentry *);
 	void (*d_release)(struct dentry *);
 	void (*d_iput)(struct dentry *, struct inode *);
