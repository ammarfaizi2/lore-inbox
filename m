Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264891AbTGBKMI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 06:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264897AbTGBKMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 06:12:08 -0400
Received: from gprs2-63.eurotel.cz ([160.218.145.63]:13031 "EHLO
	exuhome.dyn.jankratochvil.net") by vger.kernel.org with ESMTP
	id S264891AbTGBKLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 06:11:54 -0400
Date: Wed, 2 Jul 2003 12:25:38 +0200
From: Jan Kratochvil 
	<rcpt-linux-kernel.AT.vger.kernel.org@jankratochvil.net>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: chaffee@cs.berkeley.edu, zippel@linux-m68k.org
Subject: [PATCH] vfat+affs case preservation
Message-ID: <20030702102538.GA16711@exuhome.dyn.jankratochvil.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch gets working
	mv somecase SomeCase

on case-insensitive case-preserving vfat and affs filesystems.
Needed for Samba using vfat volumes - for Linux-doubting small bussiness ppl.

Thanks to Jan Kara (past patch review) and Pavouk (affs image).

http://www.jankratochvil.net/priv/vfat/linux-2.4.22-pre2-vfat6.diff
http://www.jankratochvil.net/priv/vfat/linux-2.5.73-bk9-vfat6.diff


Lace


linux-2.5.73-bk9-vfat6.diff:

diff -u -ru linux-2.5.73-bk9-orig/Documentation/filesystems/vfs.txt linux-2.5.73-bk9-vfat6/Documentation/filesystems/vfs.txt
--- linux-2.5.73-bk9-orig/Documentation/filesystems/vfs.txt	Tue May 27 03:00:43 2003
+++ linux-2.5.73-bk9-vfat6/Documentation/filesystems/vfs.txt	Mon Jun 30 18:45:06 2003
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
diff -u -ru linux-2.5.73-bk9-orig/fs/affs/namei.c linux-2.5.73-bk9-vfat6/fs/affs/namei.c
--- linux-2.5.73-bk9-orig/fs/affs/namei.c	Tue May 27 03:00:27 2003
+++ linux-2.5.73-bk9-vfat6/fs/affs/namei.c	Mon Jun 30 18:45:06 2003
@@ -25,24 +25,57 @@
 
 extern struct inode_operations affs_symlink_inode_operations;
 
-static int	 affs_toupper(int ch);
-static int	 affs_hash_dentry(struct dentry *, struct qstr *);
-static int       affs_compare_dentry(struct dentry *, struct qstr *, struct qstr *);
-static int	 affs_intl_toupper(int ch);
-static int	 affs_intl_hash_dentry(struct dentry *, struct qstr *);
-static int       affs_intl_compare_dentry(struct dentry *, struct qstr *, struct qstr *);
+static int affs_revalidate(struct dentry *dentry, int flags);
+static int affs_strict_toupper(int ch);
+static int affs_toupper(int ch);
+static int affs_intl_toupper(int ch);
+static int affs_hash_strictcase_dentry(struct dentry *, struct qstr *);
+static int affs_compare_strictcase_dentry(struct dentry *, struct qstr *, struct qstr *);
+static int affs_compare_anycase_dentry(struct dentry *, struct qstr *, struct qstr *);
+static int affs_intl_compare_anycase_dentry(struct dentry *, struct qstr *, struct qstr *);
+
+/* We have to always do the revalidate as after unlink (etc.) there still may
+ * exist other case-different dentries for the same inode. It would be also
+ * possible to discard such aliases by going through d_alias links during the
+ * unlink.
+ */
 
 struct dentry_operations affs_dentry_operations = {
-	.d_hash		= affs_hash_dentry,
-	.d_compare	= affs_compare_dentry,
+	.d_revalidate		= affs_revalidate,
+	.d_hash			= affs_hash_strictcase_dentry,
+	.d_compare		= affs_compare_strictcase_dentry,
+	.d_compare_rename	= affs_compare_anycase_dentry,
 };
 
 struct dentry_operations affs_intl_dentry_operations = {
-	.d_hash		= affs_intl_hash_dentry,
-	.d_compare	= affs_intl_compare_dentry,
+	.d_revalidate		= affs_revalidate,
+	.d_hash			= affs_hash_strictcase_dentry,
+	.d_compare		= affs_compare_strictcase_dentry,
+	.d_compare_rename	= affs_intl_compare_anycase_dentry,
 };
 
 
+static int affs_revalidate(struct dentry *dentry, int flags)
+{
+	pr_debug("AFFS: revalidate(\"%.*s\")\n", (int)dentry->d_name.len, dentry->d_name.name);
+	spin_lock(&dcache_lock);
+	if (dentry->d_parent == dentry /* root is always valid */
+	    || dentry->d_time == dentry->d_parent->d_inode->i_version) {
+		spin_unlock(&dcache_lock);
+		return 1;
+	}
+	spin_unlock(&dcache_lock);
+	return 0;
+}
+
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
@@ -91,14 +124,9 @@
 }
 
 static int
-affs_hash_dentry(struct dentry *dentry, struct qstr *qstr)
+affs_hash_strictcase_dentry(struct dentry *dentry, struct qstr *qstr)
 {
-	return __affs_hash_dentry(dentry, qstr, affs_toupper);
-}
-static int
-affs_intl_hash_dentry(struct dentry *dentry, struct qstr *qstr)
-{
-	return __affs_hash_dentry(dentry, qstr, affs_intl_toupper);
+	return __affs_hash_dentry(dentry, qstr, affs_strict_toupper);
 }
 
 static inline int
@@ -134,12 +162,17 @@
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
@@ -242,6 +275,7 @@
 		}
 	}
 	dentry->d_op = AFFS_SB(sb)->s_flags & SF_INTL ? &affs_intl_dentry_operations : &affs_dentry_operations;
+	dentry->d_time = dentry->d_parent->d_inode->i_version;
 	d_add(dentry, inode);
 	return NULL;
 }
@@ -282,6 +316,7 @@
 		iput(inode);
 		return error;
 	}
+	dentry->d_time = dentry->d_parent->d_inode->i_version;
 	return 0;
 }
 
@@ -311,6 +346,7 @@
 		iput(inode);
 		return error;
 	}
+	dentry->d_time = dentry->d_parent->d_inode->i_version;
 	return 0;
 }
 
@@ -423,7 +459,12 @@
 		return retval;
 
 	/* Unlink destination if it already exists */
-	if (new_dentry->d_inode) {
+	if (new_dentry->d_inode
+	    /* Do not remove case-different aliases twice.
+	     * Hardlinks cannot be passed here - checked at top of vfs_rename().
+	     */
+	    && old_dentry->d_inode != new_dentry->d_inode
+	    ) {
 		retval = affs_remove_header(new_dentry);
 		if (retval)
 			return retval;
diff -u -ru linux-2.5.73-bk9-orig/fs/namei.c linux-2.5.73-bk9-vfat6/fs/namei.c
--- linux-2.5.73-bk9-orig/fs/namei.c	Mon Jun 30 17:35:52 2003
+++ linux-2.5.73-bk9-vfat6/fs/namei.c	Mon Jun 30 18:45:06 2003
@@ -1953,9 +1953,19 @@
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
diff -u -ru linux-2.5.73-bk9-orig/fs/vfat/namei.c linux-2.5.73-bk9-vfat6/fs/vfat/namei.c
--- linux-2.5.73-bk9-orig/fs/vfat/namei.c	Mon Jun 30 17:35:12 2003
+++ linux-2.5.73-bk9-vfat6/fs/vfat/namei.c	Wed Jul  2 10:30:57 2003
@@ -41,38 +41,35 @@
 #  define PRINTK3(x)
 #endif
 
-static int vfat_hashi(struct dentry *parent, struct qstr *qstr);
 static int vfat_hash(struct dentry *parent, struct qstr *qstr);
 static int vfat_cmpi(struct dentry *dentry, struct qstr *a, struct qstr *b);
 static int vfat_cmp(struct dentry *dentry, struct qstr *a, struct qstr *b);
 static int vfat_revalidate(struct dentry *dentry, int);
 
-static struct dentry_operations vfat_dentry_ops[4] = {
-	{
-		.d_hash		= vfat_hashi,
-		.d_compare	= vfat_cmpi,
-	},
-	{
-		.d_revalidate	= vfat_revalidate,
-		.d_hash		= vfat_hashi,
-		.d_compare	= vfat_cmpi,
-	},
-	{
-		.d_hash		= vfat_hash,
-		.d_compare	= vfat_cmp,
-	},
-	{
-		.d_revalidate	= vfat_revalidate,
-		.d_hash		= vfat_hash,
-		.d_compare	= vfat_cmp,
-	}
+/* We have to always do the revalidate as after unlink (etc.) there still may
+ * exist other case-different dentries for the same inode. It would be also
+ * possible to discard such aliases by going through d_alias links during the
+ * unlink. "strictcase" does not have case-different dentries but "longna~1"
+ * style aliases still exist there.
+ */
+static struct dentry_operations vfat_dentry_ops_anycase = {
+	.d_revalidate		= vfat_revalidate,
+	.d_hash			= vfat_hash,
+	.d_compare		= vfat_cmp,
+	.d_compare_rename	= vfat_cmpi,
+};
+static struct dentry_operations vfat_dentry_ops_strictcase = {
+	.d_revalidate		= vfat_revalidate,
+	.d_hash			= vfat_hash,
+	.d_compare		= vfat_cmp,
 };
 
 static int vfat_revalidate(struct dentry *dentry, int flags)
 {
 	PRINTK1(("vfat_revalidate: %s\n", dentry->d_name.name));
 	spin_lock(&dcache_lock);
-	if (dentry->d_time == dentry->d_parent->d_inode->i_version) {
+	if (dentry->d_parent == dentry /* root is always valid */
+	    || dentry->d_time == dentry->d_parent->d_inode->i_version) {
 		spin_unlock(&dcache_lock);
 		return 1;
 	}
@@ -129,32 +126,6 @@
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
@@ -865,22 +836,21 @@
 	int res;
 	struct vfat_slot_info sinfo;
 	struct inode *inode;
-	struct dentry *alias;
 	struct buffer_head *bh = NULL;
 	struct msdos_dir_entry *de;
-	int table;
+	struct dentry_operations *dentry_ops;
 	
 	PRINTK2(("vfat_lookup: name=%s, len=%d\n", 
 		 dentry->d_name.name, dentry->d_name.len));
 
 	lock_kernel();
-	table = (MSDOS_SB(dir->i_sb)->options.name_check == 's') ? 2 : 0;
-	dentry->d_op = &vfat_dentry_ops[table];
+	dentry_ops = (MSDOS_SB(dir->i_sb)->options.name_check == 's'
+	              ? &vfat_dentry_ops_strictcase : &vfat_dentry_ops_anycase);
+	dentry->d_op = dentry_ops;
 
 	inode = NULL;
 	res = vfat_find(dir,&dentry->d_name,&sinfo,&bh,&de);
 	if (res < 0) {
-		table++;
 		goto error;
 	}
 	inode = fat_build_inode(dir->i_sb, de, sinfo.i_pos, &res);
@@ -889,24 +859,13 @@
 		unlock_kernel();
 		return ERR_PTR(res);
 	}
-	alias = d_find_alias(inode);
-	if (alias) {
-		if (d_invalidate(alias)==0)
-			dput(alias);
-		else {
-			iput(inode);
-			unlock_kernel();
-			return alias;
-		}
-		
-	}
 error:
 	unlock_kernel();
-	dentry->d_op = &vfat_dentry_ops[table];
+	dentry->d_op = dentry_ops;
 	dentry->d_time = dentry->d_parent->d_inode->i_version;
 	dentry = d_splice_alias(inode, dentry);
 	if (dentry) {
-		dentry->d_op = &vfat_dentry_ops[table];
+		dentry->d_op = dentry_ops;
 		dentry->d_time = dentry->d_parent->d_inode->i_version;
 	}
 	return dentry;
@@ -1082,11 +1041,14 @@
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
@@ -1098,10 +1060,10 @@
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
@@ -1112,11 +1074,10 @@
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
@@ -1124,8 +1085,12 @@
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
@@ -1179,10 +1144,8 @@
 	if (res)
 		return res;
 
-	if (MSDOS_SB(sb)->options.name_check != 's')
-		sb->s_root->d_op = &vfat_dentry_ops[0];
-	else
-		sb->s_root->d_op = &vfat_dentry_ops[2];
+	sb->s_root->d_op = (MSDOS_SB(sb)->options.name_check == 's'
+	                    ? &vfat_dentry_ops_strictcase : &vfat_dentry_ops_anycase);
 
 	return 0;
 }
diff -u -ru linux-2.5.73-bk9-orig/include/linux/dcache.h linux-2.5.73-bk9-vfat6/include/linux/dcache.h
--- linux-2.5.73-bk9-orig/include/linux/dcache.h	Mon Jun 30 17:35:17 2003
+++ linux-2.5.73-bk9-vfat6/include/linux/dcache.h	Mon Jun 30 18:44:33 2003
@@ -109,6 +109,7 @@
 	int (*d_revalidate)(struct dentry *, int);
 	int (*d_hash) (struct dentry *, struct qstr *);
 	int (*d_compare) (struct dentry *, struct qstr *, struct qstr *);
+	int (*d_compare_rename) (struct dentry *, struct qstr *, struct qstr *);
 	int (*d_delete)(struct dentry *);
 	void (*d_release)(struct dentry *);
 	void (*d_iput)(struct dentry *, struct inode *);
