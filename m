Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270829AbRHNVbd>; Tue, 14 Aug 2001 17:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270827AbRHNVb0>; Tue, 14 Aug 2001 17:31:26 -0400
Received: from atlrel7.hp.com ([192.151.27.9]:25608 "HELO atlrel7.hp.com")
	by vger.kernel.org with SMTP id <S270794AbRHNVbI>;
	Tue, 14 Aug 2001 17:31:08 -0400
Message-ID: <F341E03C8ED6D311805E00902761278C04728E7D@xfc04.fc.hp.com>
From: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
To: "'Chris Mason'" <mason@suse.com>,
        "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Performance 2.4.8 is worse than 2.4.x<8 (SPEC NFS results sho
	 w this)
Date: Tue, 14 Aug 2001 11:04:51 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C124D2.781C57A0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C124D2.781C57A0
Content-Type: text/plain;
	charset="iso-8859-1"

Chris,
   Which patch is the transaction packing patch?  My build did have
"knfsd-6.g" patch, which does the reiesrfs generation number stuff
(attached).

Erik

> -----Original Message-----
> From: Chris Mason [mailto:mason@suse.com]
> Sent: Tuesday, August 14, 2001 8:25 AM
> To: HABBINGA,ERIK (HP-Loveland,ex1); 'linux-kernel@vger.kernel.org'
> Subject: re: Performance 2.4.8 is worse than 2.4.x<8 (SPEC NFS results
> sho w this)
> 
> 
> 
> 
> On Monday, August 13, 2001 09:40:59 AM -0700 "HABBINGA,ERIK
> (HP-Loveland,ex1)" <erik_habbinga@hp.com> wrote:
> 
> > Here are some SPEC SFS NFS testing 
> (http://www.spec.org/osg/sfs97) results
> > I've been doing over the past few weeks that shows NFS performance
> > degrading since the 2.4.5pre1 kernel.  I've kept the 
> hardware constant,
> > only changing the kernel. 
> 
> Did the 2.4.5pre1 have the transaction tracking patch?
> 
> -chris
> 


------_=_NextPart_000_01C124D2.781C57A0
Content-Type: application/octet-stream;
	name="linux-2.4.5pre1-knfsd-6.g.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux-2.4.5pre1-knfsd-6.g.patch"

diff -rubB linux-2.4.4.orig/fs/dcache.c =
linux-2.4.4-knfsd/fs/dcache.c=0A=
--- linux-2.4.4.orig/fs/dcache.c	Mon Apr 30 14:55:04 2001=0A=
+++ linux-2.4.4-knfsd/fs/dcache.c	Mon Apr 30 15:13:42 2001=0A=
@@ -262,6 +262,53 @@=0A=
 	return NULL;=0A=
 }=0A=
 =0A=
+/**=0A=
+ * d_make_alias - find or make a hashed alias of an inode=0A=
+ * @inode: inode in question=0A=
+ *=0A=
+ * If d_find_alias() succeeds on the inode, then the alias found=0A=
+ * is returned.  Otherwise as new dentry is allocated, marked=0A=
+ * as %DCACHE_NFSD_DISCONNECTED, and made to be a hashed alias=0A=
+ * for the inode.=0A=
+ *=0A=
+ * To guard against multiple aliases being added to a directory=0A=
+ * inode, the i_zombie semphore is held while checking for=0A=
+ * aliases and adding a new one.=0A=
+ *=0A=
+ * This is particularly used by filesystems which support exporting=0A=
+ * via knfsd, and need to build a dcache path from the bottom=0A=
+ * up.=0A=
+ *=0A=
+ * %NULL may be returned if a memory allocation fails, in which =
case=0A=
+ * the inode should probably be released by the caller=0A=
+ */=0A=
+=0A=
+struct dentry * d_make_alias(struct inode *inode)=0A=
+{=0A=
+	struct dentry *alias;=0A=
+	down(&inode->i_zombie);=0A=
+	/* NOTE: if inode =3D=3D inode->i_sb->s_root->d_inode, then=0A=
+	 * d_find_alias wont work as s_root isn't hashed..=0A=
+	 */=0A=
+	if (inode =3D=3D inode->i_sb->s_root->d_inode)=0A=
+		alias =3D dget(inode->i_sb->s_root);=0A=
+	else=0A=
+		alias =3D d_find_alias(inode);=0A=
+	if (!alias) {=0A=
+		alias =3D d_alloc_root(inode);=0A=
+		if (alias) {=0A=
+			d_rehash(alias);=0A=
+			alias->d_flags |=3D DCACHE_NFSD_DISCONNECTED;=0A=
+		}=0A=
+	}=0A=
+	else=0A=
+		if (atomic_dec_and_test(&inode->i_count))=0A=
+			BUG();=0A=
+		       =0A=
+	up(&inode->i_zombie);=0A=
+	return alias;=0A=
+}=0A=
+=0A=
 /*=0A=
  *	Try to kill dentries associated with this inode.=0A=
  * WARNING: you must own a reference to inode.=0A=
@@ -914,16 +961,67 @@=0A=
 	list_del(&dentry->d_child);=0A=
 	list_del(&target->d_child);=0A=
 =0A=
-	/* Switch the parents and the names.. */=0A=
+	/* Switch the names.. */=0A=
 	switch_names(dentry, target);=0A=
-	do_switch(dentry->d_parent, target->d_parent);=0A=
 	do_switch(dentry->d_name.len, target->d_name.len);=0A=
 	do_switch(dentry->d_name.hash, target->d_name.hash);=0A=
 =0A=
+	/* ... and switch the parents */=0A=
+	if (IS_ROOT(dentry)) {=0A=
+		dentry->d_parent =3D target->d_parent;=0A=
+		target->d_parent =3D target;=0A=
+		INIT_LIST_HEAD(&target->d_child);=0A=
+	} else {=0A=
+		do_switch(dentry->d_parent, target->d_parent);=0A=
+		=0A=
 	/* And add them back to the (new) parent lists */=0A=
 	list_add(&target->d_child, &target->d_parent->d_subdirs);=0A=
+	}=0A=
 	list_add(&dentry->d_child, &dentry->d_parent->d_subdirs);=0A=
 	spin_unlock(&dcache_lock);=0A=
+}=0A=
+=0A=
+/**=0A=
+ * d_splice_alias - splice a disconnected dentry into the tree if one =
exists=0A=
+ * @inode:  the inode which may have a disconnected dentry=0A=
+ * @dentry: a negative dentry which we want to point to the inode.=0A=
+ *=0A=
+ * If inode has a 'disconnected' dentry (i.e. IS_ROOT and =
DCACHE_NFSD_DISCONNECTED),=0A=
+ * then d_move that in place of the given dentry and return it,=0A=
+ * else simply d_add the inode to the dentry and return NULL.=0A=
+ *=0A=
+ * This is needed in the lookup routine of any filesystem that is =
exportable=0A=
+ * via knfsd so that knfsd can build dcache paths to directories =
effectively.=0A=
+ *=0A=
+ * As we cannot lock the parent of the disconnected dentry (there =
being none),=0A=
+ * 'd_move'ing it is only race-free if we can be certain that the =
inode=0A=
+ * only has one parent.  This means that it is only safe on =
directories.=0A=
+ *=0A=
+ */=0A=
+struct dentry *d_splice_alias(struct inode *inode, struct dentry =
*dentry)=0A=
+{=0A=
+	struct dentry *new =3D NULL;=0A=
+=0A=
+	down(&inode->i_zombie);=0A=
+	if (S_ISDIR(inode->i_mode) &&=0A=
+	    (new =3D d_find_alias(inode))) {=0A=
+		if (IS_ROOT(new) &&=0A=
+		    (new->d_flags & DCACHE_NFSD_DISCONNECTED)) {=0A=
+			if (atomic_dec_and_test(&inode->i_count))=0A=
+				BUG();=0A=
+			d_move(new, dentry);=0A=
+			/* dentry was probably not hashed, so .. */=0A=
+			d_rehash(new);=0A=
+		} else {=0A=
+			dput(new);=0A=
+			new =3D NULL;=0A=
+		}=0A=
+	}=0A=
+	if (new =3D=3D NULL)=0A=
+		/* use the dentry we were given */=0A=
+		d_add(dentry, inode);=0A=
+	up(&inode->i_zombie);=0A=
+	return new;=0A=
 }=0A=
 =0A=
 /**=0A=
diff -rubB linux-2.4.4.orig/fs/efs/inode.c =
linux-2.4.4-knfsd/fs/efs/inode.c=0A=
--- linux-2.4.4.orig/fs/efs/inode.c	Mon Apr 30 14:28:29 2001=0A=
+++ linux-2.4.4-knfsd/fs/efs/inode.c	Mon Apr 30 15:13:42 2001=0A=
@@ -91,6 +91,9 @@=0A=
 	inode->i_atime =3D be32_to_cpu(efs_inode->di_atime);=0A=
 	inode->i_mtime =3D be32_to_cpu(efs_inode->di_mtime);=0A=
 	inode->i_ctime =3D be32_to_cpu(efs_inode->di_ctime);=0A=
+	inode->i_generation =3D be32_to_cpu(efs_inode->di_gen);=0A=
+	if (inode->i_mode =3D=3D 0 || inode->i_nlink =3D=3D 0)=0A=
+		goto badinode;=0A=
 =0A=
 	/* this is the number of blocks in the file */=0A=
 	if (inode->i_size =3D=3D 0) {=0A=
@@ -163,6 +166,7 @@=0A=
         =0A=
 read_inode_error:=0A=
 	printk(KERN_WARNING "EFS: failed to read inode %lu\n", =
inode->i_ino);=0A=
+ badinode:=0A=
 	make_bad_inode(inode);=0A=
 =0A=
 	return;=0A=
diff -rubB linux-2.4.4.orig/fs/efs/namei.c =
linux-2.4.4-knfsd/fs/efs/namei.c=0A=
--- linux-2.4.4.orig/fs/efs/namei.c	Mon Apr 30 14:28:29 2001=0A=
+++ linux-2.4.4-knfsd/fs/efs/namei.c	Mon Apr 30 15:13:42 2001=0A=
@@ -70,7 +70,32 @@=0A=
 			return ERR_PTR(-EACCES);=0A=
 	}=0A=
 =0A=
+	if (inode)=0A=
+		return d_splice_alias(inode, dentry);=0A=
+	=0A=
 	d_add(dentry, inode);=0A=
 	return NULL;=0A=
 }=0A=
 =0A=
+struct dentry *efs_get_parent(struct dentry *child)=0A=
+{=0A=
+	struct super_block *sb;=0A=
+	struct inode *inode =3D NULL;=0A=
+	efs_ino_t inodenum;=0A=
+	struct dentry *parent;=0A=
+=0A=
+	sb =3D child->d_inode->i_sb;=0A=
+=0A=
+	inodenum =3D efs_find_entry(child->d_inode, "..", 2);=0A=
+	if (inodenum)=0A=
+		inode =3D iget(sb, inodenum);=0A=
+	if (!inode)=0A=
+		return ERR_PTR(-EACCES);=0A=
+=0A=
+	parent =3D d_make_alias(inode);=0A=
+	if (!parent) {=0A=
+		iput(inode);=0A=
+		parent =3D ERR_PTR(-ENOMEM);=0A=
+	}=0A=
+	return parent;=0A=
+}=0A=
diff -rubB linux-2.4.4.orig/fs/efs/super.c =
linux-2.4.4-knfsd/fs/efs/super.c=0A=
--- linux-2.4.4.orig/fs/efs/super.c	Mon Apr 30 14:55:04 2001=0A=
+++ linux-2.4.4-knfsd/fs/efs/super.c	Mon Apr 30 15:13:42 2001=0A=
@@ -12,6 +12,7 @@=0A=
 #include <linux/efs_fs.h>=0A=
 #include <linux/efs_vh.h>=0A=
 #include <linux/efs_fs_sb.h>=0A=
+#include <linux/nfsd/interface.h>=0A=
 =0A=
 static DECLARE_FSTYPE_DEV(efs_fs_type, "efs", efs_read_super);=0A=
 =0A=
@@ -20,6 +21,13 @@=0A=
 	statfs:		efs_statfs,=0A=
 };=0A=
 =0A=
+extern struct dentry *efs_get_parent(struct dentry *child);=0A=
+=0A=
+static struct nfsd_operations efs_nfsd_operations =3D {=0A=
+	get_parent:	efs_get_parent,=0A=
+};=0A=
+=0A=
+=0A=
 static int __init init_efs_fs(void) {=0A=
 	printk("EFS: "EFS_VERSION" - http://aeschi.ch.eu.org/efs/\n");=0A=
 	return register_filesystem(&efs_fs_type);=0A=
@@ -186,6 +194,7 @@=0A=
 		s->s_flags |=3D MS_RDONLY;=0A=
 	}=0A=
 	s->s_op   =3D &efs_superblock_operations;=0A=
+	s->s_nfsd_op =3D &efs_nfsd_operations;=0A=
 	s->s_root =3D d_alloc_root(iget(s, EFS_ROOTINODE));=0A=
  =0A=
 	if (!(s->s_root)) {=0A=
diff -rubB linux-2.4.4.orig/fs/ext2/namei.c =
linux-2.4.4-knfsd/fs/ext2/namei.c=0A=
--- linux-2.4.4.orig/fs/ext2/namei.c	Mon Apr 30 14:28:24 2001=0A=
+++ linux-2.4.4-knfsd/fs/ext2/namei.c	Mon Apr 30 15:13:42 2001=0A=
@@ -179,9 +179,37 @@=0A=
 		if (!inode)=0A=
 			return ERR_PTR(-EACCES);=0A=
 	}=0A=
+	if (inode)=0A=
+		return d_splice_alias(inode, dentry);=0A=
+=0A=
 	d_add(dentry, inode);=0A=
 	return NULL;=0A=
 }=0A=
+=0A=
+struct dentry *ext2_get_parent(struct dentry *child)=0A=
+{=0A=
+	struct buffer_head * bh;=0A=
+	struct ext2_dir_entry_2 *de;=0A=
+	unsigned long ino;=0A=
+	struct dentry *parent;=0A=
+	struct inode *inode;=0A=
+=0A=
+	bh =3D ext2_find_entry (child->d_inode, "..", 2, &de);=0A=
+	if (!bh)=0A=
+		return ERR_PTR(-ENOENT);=0A=
+	ino =3D le32_to_cpu(de->inode);=0A=
+	brelse (bh);=0A=
+	inode =3D iget(child->d_inode->i_sb, ino);=0A=
+	=0A=
+	if (!inode)=0A=
+		return ERR_PTR(-EACCES);=0A=
+	parent =3D d_make_alias(inode);=0A=
+	if (!parent) {=0A=
+		iput(inode);=0A=
+		parent =3D ERR_PTR(-ENOMEM);=0A=
+	}=0A=
+	return parent;=0A=
+} =0A=
 =0A=
 #define S_SHIFT 12=0A=
 static unsigned char ext2_type_by_mode[S_IFMT >> S_SHIFT] =3D {=0A=
diff -rubB linux-2.4.4.orig/fs/ext2/super.c =
linux-2.4.4-knfsd/fs/ext2/super.c=0A=
--- linux-2.4.4.orig/fs/ext2/super.c	Mon Apr 30 14:55:04 2001=0A=
+++ linux-2.4.4-knfsd/fs/ext2/super.c	Mon Apr 30 15:14:30 2001=0A=
@@ -24,6 +24,7 @@=0A=
 #include <linux/slab.h>=0A=
 #include <linux/init.h>=0A=
 #include <linux/locks.h>=0A=
+#include <linux/nfsd/interface.h>=0A=
 #include <linux/blkdev.h>=0A=
 #include <asm/uaccess.h>=0A=
 =0A=
@@ -157,6 +158,16 @@=0A=
 	remount_fs:	ext2_remount,=0A=
 };=0A=
 =0A=
+/* Yes, most of these are left as NULL!!=0A=
+ * A NULL value implies the default, which works with ext2-like =
file=0A=
+ * systems, but can be improved upon.=0A=
+ * Currently only get_parent is required.=0A=
+ */=0A=
+struct dentry *ext2_get_parent(struct dentry *child);=0A=
+static struct nfsd_operations ext2_nfsd_ops =3D {=0A=
+	get_parent: ext2_get_parent,=0A=
+};=0A=
+=0A=
 /*=0A=
  * This function has been shamelessly adapted from the msdos fs=0A=
  */=0A=
@@ -644,6 +655,7 @@=0A=
 	 * set up enough so that it can read an inode=0A=
 	 */=0A=
 	sb->s_op =3D &ext2_sops;=0A=
+	sb->s_nfsd_op =3D &ext2_nfsd_ops;=0A=
 	sb->s_root =3D d_alloc_root(iget(sb, EXT2_ROOT_INO));=0A=
 	if (!sb->s_root) {=0A=
 		for (i =3D 0; i < db_count; i++)=0A=
diff -rubB linux-2.4.4.orig/fs/isofs/inode.c =
linux-2.4.4-knfsd/fs/isofs/inode.c=0A=
--- linux-2.4.4.orig/fs/isofs/inode.c	Mon Apr 30 14:55:04 2001=0A=
+++ linux-2.4.4-knfsd/fs/isofs/inode.c	Mon Apr 30 15:14:57 2001=0A=
@@ -27,6 +27,7 @@=0A=
 #include <linux/nls.h>=0A=
 #include <linux/ctype.h>=0A=
 #include <linux/smp_lock.h>=0A=
+#include <linux/nfsd/interface.h>=0A=
 #include <linux/blkdev.h>=0A=
 =0A=
 #include <asm/system.h>=0A=
@@ -82,6 +83,9 @@=0A=
 	statfs:		isofs_statfs,=0A=
 };=0A=
 =0A=
+static struct nfsd_operations isofs_nfsd_ops =3D {=0A=
+};=0A=
+=0A=
 static struct dentry_operations isofs_dentry_ops[] =3D {=0A=
 	{=0A=
 		d_hash:		isofs_hash,=0A=
@@ -750,6 +754,7 @@=0A=
 	}=0A=
 #endif=0A=
 	s->s_op =3D &isofs_sops;=0A=
+	s->s_nfsd_op =3D &isofs_nfsd_ops;=0A=
 	s->u.isofs_sb.s_mapping =3D opt.map;=0A=
 	s->u.isofs_sb.s_rock =3D (opt.rock =3D=3D 'y' ? 2 : 0);=0A=
 	s->u.isofs_sb.s_cruft =3D opt.cruft;=0A=
diff -rubB linux-2.4.4.orig/fs/nfsd/Makefile =
linux-2.4.4-knfsd/fs/nfsd/Makefile=0A=
--- linux-2.4.4.orig/fs/nfsd/Makefile	Mon Apr 30 14:28:25 2001=0A=
+++ linux-2.4.4-knfsd/fs/nfsd/Makefile	Mon Apr 30 15:13:43 2001=0A=
@@ -9,6 +9,7 @@=0A=
 =0A=
 O_TARGET :=3D nfsd.o=0A=
 =0A=
+export-objs :=3D nfsfh.o=0A=
 obj-y :=3D    nfssvc.o nfsctl.o nfsproc.o nfsfh.o vfs.o \=0A=
 	    export.o auth.o lockd.o nfscache.o nfsxdr.o \=0A=
 	    stats.o=0A=
diff -rubB linux-2.4.4.orig/fs/nfsd/export.c =
linux-2.4.4-knfsd/fs/nfsd/export.c=0A=
--- linux-2.4.4.orig/fs/nfsd/export.c	Mon Apr 30 14:28:25 2001=0A=
+++ linux-2.4.4-knfsd/fs/nfsd/export.c	Mon Apr 30 15:13:43 2001=0A=
@@ -212,8 +212,7 @@=0A=
 		goto finish;=0A=
 =0A=
 	err =3D -EINVAL;=0A=
-	if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) ||=0A=
-	    inode->i_sb->s_op->read_inode =3D=3D NULL) {=0A=
+	if (inode->i_sb->s_nfsd_op =3D=3D NULL) {=0A=
 		dprintk("exp_export: export of invalid fs type.\n");=0A=
 		goto finish;=0A=
 	}=0A=
diff -rubB linux-2.4.4.orig/fs/nfsd/nfsctl.c =
linux-2.4.4-knfsd/fs/nfsd/nfsctl.c=0A=
--- linux-2.4.4.orig/fs/nfsd/nfsctl.c	Mon Apr 30 14:28:25 2001=0A=
+++ linux-2.4.4-knfsd/fs/nfsd/nfsctl.c	Mon Apr 30 15:13:43 2001=0A=
@@ -312,8 +312,11 @@=0A=
 EXPORT_NO_SYMBOLS;=0A=
 MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");=0A=
 =0A=
+#undef nfsd_find_fh_dentry=0A=
+=0A=
 struct nfsd_linkage nfsd_linkage_s =3D {=0A=
 	do_nfsservctl: handle_sys_nfsservctl,=0A=
+	find_fh_dentry: nfsd_find_fh_dentry,=0A=
 };=0A=
 =0A=
 /*=0A=
diff -rubB linux-2.4.4.orig/fs/nfsd/nfsfh.c =
linux-2.4.4-knfsd/fs/nfsd/nfsfh.c=0A=
--- linux-2.4.4.orig/fs/nfsd/nfsfh.c	Mon Apr 30 14:28:25 2001=0A=
+++ linux-2.4.4-knfsd/fs/nfsd/nfsfh.c	Mon Apr 30 15:13:43 2001=0A=
@@ -6,6 +6,7 @@=0A=
  * Copyright (C) 1995, 1996 Olaf Kirch <okir@monad.swb.de>=0A=
  * Portions Copyright (C) 1999 G. Allen Morris III <gam3@acm.org>=0A=
  * Extensive rewrite by Neil Brown <neilb@cse.unsw.edu.au> =
Southern-Spring 1999=0A=
+ * ... and again Southern-Winter 2000 to support nfsd_operations=0A=
  */=0A=
 =0A=
 #include <linux/sched.h>=0A=
@@ -15,6 +16,7 @@=0A=
 #include <linux/string.h>=0A=
 #include <linux/stat.h>=0A=
 #include <linux/dcache.h>=0A=
+#include <linux/module.h>=0A=
 #include <asm/pgtable.h>=0A=
 =0A=
 #include <linux/sunrpc/svc.h>=0A=
@@ -28,9 +30,13 @@=0A=
 static int nfsd_nr_verified;=0A=
 static int nfsd_nr_put;=0A=
 =0A=
+extern struct nfsd_operations nfsd_op_default;=0A=
+=0A=
+#define	CALL(ops,fun) ((ops->fun)?(ops->fun):nfsd_op_default.fun)=0A=
+=0A=
 =0A=
 struct nfsd_getdents_callback {=0A=
-	struct qstr *name;	/* name that was found. name->name already points =
to a buffer */=0A=
+	char *name;		/* name that was found. It already points to a buffer =
NAME_MAX+1 is size */=0A=
 	unsigned long ino;	/* the inum we are looking for */=0A=
 	int found;		/* inode matched? */=0A=
 	int sequence;		/* sequence counter */=0A=
@@ -44,8 +50,6 @@=0A=
 			off_t pos, ino_t ino, unsigned int d_type)=0A=
 {=0A=
 	struct nfsd_getdents_callback *buf =3D __buf;=0A=
-	struct qstr *qs =3D buf->name;=0A=
-	char *nbuf =3D (char*)qs->name; /* cast is to get rid of "const" =
*/=0A=
 	int result =3D 0;=0A=
 =0A=
 	buf->sequence++;=0A=
@@ -53,22 +57,25 @@=0A=
 dprintk("filldir_one: seq=3D%d, ino=3D%ld, name=3D%s\n", =
buf->sequence, ino, name);=0A=
 #endif=0A=
 	if (buf->ino =3D=3D ino) {=0A=
-		qs->len =3D len;=0A=
-		memcpy(nbuf, name, len);=0A=
-		nbuf[len] =3D '\0';=0A=
+		memcpy(buf->name, name, len);=0A=
+		buf->name[len] =3D '\0';=0A=
 		buf->found =3D 1;=0A=
 		result =3D -1;=0A=
 	}=0A=
 	return result;=0A=
 }=0A=
 =0A=
-/*=0A=
- * Read a directory and return the name of the specified entry.=0A=
- * i_sem is already down().=0A=
- * The whole thing is a total BS. It should not be done via readdir(), =
damnit!=0A=
- * Oh, well, as soon as it will be in filesystems...=0A=
+/**=0A=
+ * nfsd_get_name - default nfsd_operations->get_name function=0A=
+ * @dentry: the directory in which to find a name=0A=
+ * @name:   a pointer to a %NAME_MAX+1 char buffer to store the =
name=0A=
+ * @child:  the dentry for the child directory.=0A=
+ *=0A=
+ * calls readdir on the parent until it finds an entry with=0A=
+ * the same inode number as the child, and returns that.=0A=
  */=0A=
-static int get_ino_name(struct dentry *dentry, struct qstr *name, =
unsigned long ino)=0A=
+static int nfsd_get_name(struct dentry *dentry, char *name,=0A=
+		  struct dentry *child)=0A=
 {=0A=
 	struct inode *dir =3D dentry->d_inode;=0A=
 	int error;=0A=
@@ -92,12 +99,12 @@=0A=
 		goto out_close;=0A=
 =0A=
 	buffer.name =3D name;=0A=
-	buffer.ino =3D ino;=0A=
+	buffer.ino =3D child->d_inode->i_ino;=0A=
 	buffer.found =3D 0;=0A=
 	buffer.sequence =3D 0;=0A=
 	while (1) {=0A=
 		int old_seq =3D buffer.sequence;=0A=
-		error =3D file.f_op->readdir(&file, &buffer, filldir_one);=0A=
+		error =3D vfs_readdir(&file, filldir_one, &buffer);=0A=
 		if (error < 0)=0A=
 			break;=0A=
 =0A=
@@ -116,370 +123,390 @@=0A=
 	return error;=0A=
 }=0A=
 =0A=
-/* this should be provided by each filesystem in an nfsd_operations =
interface as=0A=
- * iget isn't really the right interface=0A=
- */=0A=
-static struct dentry *nfsd_iget(struct super_block *sb, unsigned long =
ino, __u32 generation)=0A=
-{=0A=
-=0A=
-	/* iget isn't really right if the inode is currently unallocated!!=0A=
-	 * This should really all be done inside each filesystem=0A=
+/**=0A=
+ * nfsd_get_dentry - default nfsd_operations->get_dentry function=0A=
+ * sb: 	super_block of target file system.=0A=
+ * inump: pointer to 32bit inode number followed by 32bit generation =
number=0A=
 	 *=0A=
-	 * ext2fs' read_inode has been strengthed to return a bad_inode if =
the inode=0A=
-	 *   had been deleted.=0A=
+ * This function abuses iget() to find the inode with a given=0A=
+ * inode number, and checks that the generation number is correct.=0A=
+ * It assumes that the filesystems read_inode function will return=0A=
+ * a "bad_inode" if the inode number is invalid.=0A=
 	 *=0A=
-	 * Currently we don't know the generation for parent directory, so a =
generation=0A=
-	 * of 0 means "accept any"=0A=
+ * If the inode is found and it has at least one dentry, the first =
dentry=0A=
+ * is returned.=0A=
+ * If there are no dentrys, one is allocated using d_alloc_root, =
and=0A=
+ * it is returned with the DCACHE_NFSD_DISCONNECTED flag set.=0A=
+ *=0A=
+ * If a filesystem choses to use this as its get_dentry function, =
its=0A=
+ * read_inode() but be able to reliably locate an inode given the =
inode number,=0A=
+ * and must also be able to detect an inactive inode, and make the =
inode structure=0A=
+ * as bad using make_bad_inode.  Further, the delete_inode() function =
must be=0A=
+ * able to detect and ignore a "bad inode".=0A=
+ *=0A=
+ * Finally, the filesystem must not depend in have d_op set for a =
dentry, as=0A=
+ * this routine may allocate one without setting d_op. =0A=
 	 */=0A=
+static struct dentry *nfsd_get_dentry(struct super_block *sb, void =
*inump)=0A=
+{=0A=
+	struct dentry *dentry;=0A=
 	struct inode *inode;=0A=
-	struct list_head *lp;=0A=
-	struct dentry *result;=0A=
+=0A=
+	__u32 *u32p;=0A=
+	unsigned long ino;=0A=
+	__u32 generation;=0A=
+=0A=
+	u32p =3D (__u32*)inump;=0A=
+=0A=
+	ino =3D *u32p++;=0A=
+	generation =3D *u32p;=0A=
+=0A=
+	if (ino =3D=3D 0)=0A=
+		return NULL;=0A=
+	=0A=
 	inode =3D iget(sb, ino);=0A=
 	if (is_bad_inode(inode)=0A=
 	    || (generation && inode->i_generation !=3D generation)=0A=
 		) {=0A=
 		/* we didn't find the right inode.. */=0A=
-		dprintk("fh_verify: Inode %lu, Bad count: %d %d or version  %u =
%u\n",=0A=
+		dprintk("nfsd_get_dentry: Inode %lu, Bad count: %d %d or version  %u =
%u\n",=0A=
 			inode->i_ino,=0A=
 			inode->i_nlink, atomic_read(&inode->i_count),=0A=
 			inode->i_generation,=0A=
 			generation);=0A=
 =0A=
 		iput(inode);=0A=
-		return ERR_PTR(-ESTALE);=0A=
+		return NULL;=0A=
 	}=0A=
-	/* now to find a dentry.=0A=
-	 * If possible, get a well-connected one=0A=
-	 */=0A=
-	spin_lock(&dcache_lock);=0A=
-	for (lp =3D inode->i_dentry.next; lp !=3D &inode->i_dentry ; =
lp=3Dlp->next) {=0A=
-		result =3D list_entry(lp,struct dentry, d_alias);=0A=
-		if (! (result->d_flags & DCACHE_NFSD_DISCONNECTED)) {=0A=
-			dget_locked(result);=0A=
-			result->d_vfs_flags |=3D DCACHE_REFERENCED;=0A=
-			spin_unlock(&dcache_lock);=0A=
-			iput(inode);=0A=
-			return result;=0A=
-		}=0A=
-	}=0A=
-	spin_unlock(&dcache_lock);=0A=
-	result =3D d_alloc_root(inode);=0A=
-	if (result =3D=3D NULL) {=0A=
+=0A=
+	dentry =3D d_make_alias(inode);=0A=
+	if (!dentry) {=0A=
 		iput(inode);=0A=
-		return ERR_PTR(-ENOMEM);=0A=
+		dentry =3D ERR_PTR(-ENOMEM);=0A=
 	}=0A=
-	result->d_flags |=3D DCACHE_NFSD_DISCONNECTED;=0A=
-	d_rehash(result); /* so a dput won't loose it */=0A=
-	return result;=0A=
+	return dentry;=0A=
 }=0A=
 =0A=
-/* this routine links an IS_ROOT dentry into the dcache tree.  It =
gains "parent"=0A=
- * as a parent and "name" as a name=0A=
- * It should possibly go in dcache.c=0A=
- */=0A=
-int d_splice(struct dentry *target, struct dentry *parent, struct qstr =
*name)=0A=
-{=0A=
-	struct dentry *tdentry;=0A=
-#ifdef NFSD_PARANOIA=0A=
-	if (!IS_ROOT(target))=0A=
-		printk("nfsd: d_splice with no-root target: %s/%s\n", =
parent->d_name.name, name->name);=0A=
-	if (!(target->d_flags & DCACHE_NFSD_DISCONNECTED))=0A=
-		printk("nfsd: d_splice with non-DISCONNECTED target: %s/%s\n", =
parent->d_name.name, name->name);=0A=
-#endif=0A=
-	name->hash =3D full_name_hash(name->name, name->len);=0A=
-	tdentry =3D d_alloc(parent, name);=0A=
-	if (tdentry =3D=3D NULL)=0A=
-		return -ENOMEM;=0A=
-	d_move(target, tdentry);=0A=
 =0A=
-	/* tdentry will have been made a "child" of target (the parent of =
target)=0A=
-	 * make it an IS_ROOT instead=0A=
+/**=0A=
+ * nfsd_find_fh_dentry - helper routine to implement =
nfsd_operations->decode_fh=0A=
+ * @sb:		The &super_block identifying the filesystem=0A=
+ * @obj:	An opaque identifier of the object to be found - passed to =
get_inode=0A=
+ * @parent:	An optional opqaue identifier of the parent of the =
object.=0A=
+ * @acceptable:	A function used to test possible &dentries to see of =
they are acceptable=0A=
+ * @context:	A parameter to @acceptable so that it knows on what basis =
to judge.=0A=
+ *=0A=
+ * nfsd_find_fh_dentry is the central helper routine to enable file =
systems to provide=0A=
+ * the decode_fh() nfsd_operation.  It's main task is to take an =
inode, find or create an=0A=
+ * appropriate &dentry structure, and possibly splice this into the =
dcache in the=0A=
+ * correct place.=0A=
+ *=0A=
+ * The decode_fh() operation provided by the filesystem should call =
nfsd_find_fh_dentry()=0A=
+ * with the same parameters that it received except that instead of =
the file handle fragment,=0A=
+ * pointers to opaque identifiers for the object and optionally its =
parent are passed.=0A=
+ * The default decode_fh routine passes one pointer to the start of =
the filehandle fragment, and=0A=
+ * one 8 bytes in to the fragment.  It is expected that most =
filesystems will take this=0A=
+ * approach, though the offset to the parent identifier may well be =
different.=0A=
+ *=0A=
+ * nfsd_find_fh_dentry() will call get_dentry to get an dentry pointer =
from the file system.  If=0A=
+ * any &dentry in the d_alias list is acceptable, it will be returned. =
 Otherwise=0A=
+ * nfsd_find_fh_dentry() will attempt to splice a new &dentry into the =
dcache using get_name() and=0A=
+ * get_parent() to find the appropriate place.=0A=
+ *=0A=
+ */=0A=
+#ifdef CONFIG_NFSD_MODULE=0A=
+/* for any other code, nfsd_find_fh_dentry is a macro that=0A=
+ * dives through nfsd_linkage, but for us, it is a real function=0A=
 	 */=0A=
-	spin_lock(&dcache_lock);=0A=
-	list_del(&tdentry->d_child);=0A=
-	tdentry->d_parent =3D tdentry;=0A=
-	spin_unlock(&dcache_lock);=0A=
-	d_rehash(target);=0A=
-	dput(tdentry);=0A=
 =0A=
-	/* if parent is properly connected, then we can assert that=0A=
-	 * the children are connected, but it must be a singluar =
(non-forking)=0A=
-	 * branch=0A=
-	 */=0A=
-	if (!(parent->d_flags & DCACHE_NFSD_DISCONNECTED)) {=0A=
-		while (target) {=0A=
-			target->d_flags &=3D ~DCACHE_NFSD_DISCONNECTED;=0A=
-			parent =3D target;=0A=
-			spin_lock(&dcache_lock);=0A=
-			if (list_empty(&parent->d_subdirs))=0A=
-				target =3D NULL;=0A=
-			else {=0A=
-				target =3D list_entry(parent->d_subdirs.next, struct dentry, =
d_child);=0A=
-#ifdef NFSD_PARANOIA=0A=
-				/* must be only child */=0A=
-				if (target->d_child.next !=3D &parent->d_subdirs=0A=
-				    || target->d_child.prev !=3D &parent->d_subdirs)=0A=
-					printk("nfsd: d_splice found non-singular disconnected branch: =
%s/%s\n",=0A=
-					       parent->d_name.name, target->d_name.name);=0A=
+#undef nfsd_find_fh_dentry=0A=
 #endif=0A=
-			}=0A=
-			spin_unlock(&dcache_lock);=0A=
-		}=0A=
-	}=0A=
-	return 0;=0A=
-}=0A=
-=0A=
-/* this routine finds the dentry of the parent of a given directory=0A=
- * it should be in the filesystem accessed by nfsd_operations=0A=
- * it assumes lookup("..") works.=0A=
- */=0A=
-struct dentry *nfsd_findparent(struct dentry *child)=0A=
-{=0A=
-	struct dentry *tdentry, *pdentry;=0A=
-	tdentry =3D d_alloc(child, &(const struct qstr) {"..", 2, 0});=0A=
-	if (!tdentry)=0A=
-		return ERR_PTR(-ENOMEM);=0A=
-=0A=
-	/* I'm going to assume that if the returned dentry is different, =
then=0A=
-	 * it is well connected.  But nobody returns different dentrys do =
they?=0A=
-	 */=0A=
-	pdentry =3D child->d_inode->i_op->lookup(child->d_inode, tdentry);=0A=
-	d_drop(tdentry); /* we never want ".." hashed */=0A=
-	if (!pdentry) {=0A=
-		/* I don't want to return a ".." dentry.=0A=
-		 * I would prefer to return an unconnected "IS_ROOT" dentry,=0A=
-		 * though a properly connected dentry is even better=0A=
-		 */=0A=
-		/* if first or last of alias list is not tdentry, use that=0A=
-		 * else make a root dentry=0A=
-		 */=0A=
-		struct list_head *aliases =3D &tdentry->d_inode->i_dentry;=0A=
-		spin_lock(&dcache_lock);=0A=
-		if (aliases->next !=3D aliases) {=0A=
-			pdentry =3D list_entry(aliases->next, struct dentry, d_alias);=0A=
-			if (pdentry =3D=3D tdentry)=0A=
-				pdentry =3D list_entry(aliases->prev, struct dentry, d_alias);=0A=
-			if (pdentry =3D=3D tdentry)=0A=
-				pdentry =3D NULL;=0A=
-			if (pdentry) dget_locked(pdentry);=0A=
-		}=0A=
-		spin_unlock(&dcache_lock);=0A=
-		if (pdentry =3D=3D NULL) {=0A=
-			pdentry =3D d_alloc_root(igrab(tdentry->d_inode));=0A=
-			if (pdentry) {=0A=
-				pdentry->d_flags |=3D DCACHE_NFSD_DISCONNECTED;=0A=
-				d_rehash(pdentry);=0A=
-			}=0A=
-		}=0A=
-		if (pdentry =3D=3D NULL)=0A=
-			pdentry =3D ERR_PTR(-ENOMEM);=0A=
-	}=0A=
-	dput(tdentry); /* it is not hashed, it will be discarded */=0A=
-	return pdentry;=0A=
-}=0A=
-=0A=
-static struct dentry *splice(struct dentry *child, struct dentry =
*parent)=0A=
-{=0A=
-	int err =3D 0;=0A=
-	struct qstr qs;=0A=
-	char namebuf[256];=0A=
-	struct list_head *lp;=0A=
-	struct dentry *tmp;=0A=
-	/* child is an IS_ROOT (anonymous) dentry, but it is hypothesised =
that=0A=
-	 * it should be a child of parent.=0A=
-	 * We see if we can find a name and, if we can - splice it in.=0A=
-	 * We hold the i_sem on the parent the whole time to try to follow =
locking protocols.=0A=
-	 */=0A=
-	qs.name =3D namebuf;=0A=
-	down(&parent->d_inode->i_sem);=0A=
-=0A=
-	/* Now, things might have changed while we waited.=0A=
-	 * Possibly a friendly filesystem found child and spliced it in in =
response=0A=
-	 * to a lookup (though nobody does this yet).  In this case, just =
succeed.=0A=
-	 */=0A=
-	if (child->d_parent =3D=3D parent) goto out;=0A=
-	/* Possibly a new dentry has been made for this child->d_inode in=0A=
-	 * parent by a lookup.  In this case return that dentry. caller =
must=0A=
-	 * notice and act accordingly=0A=
-	 */=0A=
-	spin_lock(&dcache_lock);=0A=
-	for (lp =3D child->d_inode->i_dentry.next; lp !=3D =
&child->d_inode->i_dentry ; lp=3Dlp->next) {=0A=
-		tmp =3D list_entry(lp,struct dentry, d_alias);=0A=
-		if (tmp->d_parent =3D=3D parent) {=0A=
-			child =3D dget_locked(tmp);=0A=
-			spin_unlock(&dcache_lock);=0A=
-			goto out;=0A=
-		}=0A=
-	}=0A=
-	spin_unlock(&dcache_lock);=0A=
-	/* well, if we can find a name for child in parent, it should be safe =
to splice it in */=0A=
-	err =3D get_ino_name(parent, &qs, child->d_inode->i_ino);=0A=
-	if (err)=0A=
-		goto out;=0A=
-	tmp =3D d_lookup(parent, &qs);=0A=
-	if (tmp) {=0A=
-		/* Now that IS odd.  I wonder what it means... */=0A=
-		err =3D -EEXIST;=0A=
-		printk("nfsd-fh: found a name that I didn't expect: %s/%s\n", =
parent->d_name.name, qs.name);=0A=
-		dput(tmp);=0A=
-		goto out;=0A=
-	}=0A=
-	err =3D d_splice(child, parent, &qs);=0A=
-	dprintk("nfsd_fh: found name %s for ino %ld\n", child->d_name.name, =
child->d_inode->i_ino);=0A=
- out:=0A=
-	up(&parent->d_inode->i_sem);=0A=
-	if (err)=0A=
-		return ERR_PTR(err);=0A=
-	else=0A=
-		return child;=0A=
-}=0A=
 =0A=
-/*=0A=
- * This is the basic lookup mechanism for turning an NFS file =
handle=0A=
- * into a dentry.=0A=
- * We use nfsd_iget and if that doesn't return a suitably connected =
dentry,=0A=
- * we try to find the parent, and the parent of that and so-on until =
a=0A=
- * connection if made.=0A=
- */=0A=
-static struct dentry *=0A=
-find_fh_dentry(struct super_block *sb, ino_t ino, int generation, =
ino_t dirino, int needpath)=0A=
-{=0A=
-	struct dentry *dentry, *result =3D NULL;=0A=
-	struct dentry *tmp;=0A=
-	int  found =3D0;=0A=
-	int err =3D -ESTALE;=0A=
-	/* the sb->s_nfsd_free_path_sem semaphore is needed to make sure that =
only one unconnected (free)=0A=
-	 * dcache path ever exists, as otherwise two partial paths might =
get=0A=
-	 * joined together, which would be very confusing.=0A=
-	 * If there is ever an unconnected non-root directory, then this =
lock=0A=
-	 * must be held.=0A=
-	 */=0A=
+struct dentry *=0A=
+nfsd_find_fh_dentry(struct super_block *sb, void *obj, void =
*parent,=0A=
+		    int (*acceptable)(void *context, struct dentry *de),=0A=
+		    void *context)=0A=
+{=0A=
+	struct dentry *result =3D NULL;=0A=
+	struct dentry *target_dir;=0A=
+	int err;=0A=
+	struct nfsd_operations *nops =3D sb->s_nfsd_op;=0A=
+	struct list_head *le, *head;=0A=
+	int noprogress;=0A=
 =0A=
 =0A=
-	nfsdstats.fh_lookup++;=0A=
 	/*=0A=
 	 * Attempt to find the inode.=0A=
 	 */=0A=
- retry:=0A=
-	down(&sb->s_nfsd_free_path_sem);=0A=
-	result =3D nfsd_iget(sb, ino, generation);=0A=
-	if (IS_ERR(result)=0A=
-	    || !(result->d_flags & DCACHE_NFSD_DISCONNECTED)=0A=
-	    || (!S_ISDIR(result->d_inode->i_mode) && ! needpath)) {=0A=
-		up(&sb->s_nfsd_free_path_sem);=0A=
-	    =0A=
+	result =3D CALL(sb->s_nfsd_op,get_dentry)(sb,obj);=0A=
+	err =3D -ESTALE;=0A=
+	if (result =3D=3D NULL)=0A=
+		goto err_out;=0A=
+	if (IS_ERR(result)) {=0A=
 		err =3D PTR_ERR(result);=0A=
-		if (IS_ERR(result))=0A=
 			goto err_out;=0A=
-		if ((result->d_flags & DCACHE_NFSD_DISCONNECTED))=0A=
-			nfsdstats.fh_anon++;=0A=
+	}=0A=
+	if (S_ISDIR(result->d_inode->i_mode) &&=0A=
+	    (result->d_flags & DCACHE_NFSD_DISCONNECTED)) {=0A=
+		/* it is an unconnected directory, we must connect it */=0A=
+		;=0A=
+	} else {=0A=
+		struct dentry *toput =3D NULL;=0A=
+		if (acceptable(context, result))=0A=
 		return result;=0A=
+		if (S_ISDIR(result->d_inode->i_mode)) {=0A=
+			/* there is no other dentry, so fail */=0A=
+			goto err_result;=0A=
+		}=0A=
+		/* try any other aliases */=0A=
+		spin_lock(&dcache_lock);=0A=
+		head =3D &result->d_inode->i_dentry;=0A=
+		list_for_each(le, head) {=0A=
+			struct dentry *dentry =3D list_entry(le, struct dentry, =
d_alias);=0A=
+			dget_locked(dentry);=0A=
+			spin_unlock(&dcache_lock);=0A=
+			if (toput)=0A=
+				dput(toput);=0A=
+			toput =3D NULL;=0A=
+			if (dentry !=3D result &&=0A=
+			    acceptable(context, dentry)) {=0A=
+				dput(result);=0A=
+				return dentry;=0A=
+			}=0A=
+			spin_lock(&dcache_lock);=0A=
+			toput =3D dentry;=0A=
+		}=0A=
+		spin_unlock(&dcache_lock);=0A=
+		if (toput)=0A=
+			dput(toput);=0A=
 	}=0A=
 =0A=
 	/* It's a directory, or we are required to confirm the file's=0A=
-	 * location in the tree.=0A=
+	 * location in the tree based on the parent information=0A=
 	 */=0A=
-	dprintk("nfs_fh: need to look harder for %d/%ld\n",sb->s_dev,ino);=0A=
-=0A=
-	found =3D 0;=0A=
-	if (!S_ISDIR(result->d_inode->i_mode)) {=0A=
-		nfsdstats.fh_nocache_nondir++;=0A=
-		if (dirino =3D=3D 0)=0A=
-			goto err_result; /* don't know how to find parent */=0A=
+	dprintk("nfs_fh: need to look harder for =
%d/%d\n",sb->s_dev,*(int*)obj);=0A=
+	if (S_ISDIR(result->d_inode->i_mode))=0A=
+		target_dir =3D dget(result);=0A=
 		else {=0A=
-			/* need to iget dirino and make sure this inode is in that =
directory */=0A=
-			dentry =3D nfsd_iget(sb, dirino, 0);=0A=
-			err =3D PTR_ERR(dentry);=0A=
-			if (IS_ERR(dentry))=0A=
+		if (parent =3D=3D NULL)=0A=
+			goto err_result;=0A=
+=0A=
+		target_dir =3D CALL(sb->s_nfsd_op,get_dentry)(sb,parent);=0A=
+		if (IS_ERR(target_dir))=0A=
+			err =3D PTR_ERR(target_dir);=0A=
+		if (target_dir =3D=3D NULL || IS_ERR(target_dir))=0A=
 				goto err_result;=0A=
-			err =3D -ESTALE;=0A=
-			if (!dentry->d_inode=0A=
-			    || !S_ISDIR(dentry->d_inode->i_mode)) {=0A=
-				goto err_dentry;=0A=
-			}=0A=
-			if (!(dentry->d_flags & DCACHE_NFSD_DISCONNECTED))=0A=
-				found =3D 1;=0A=
-			tmp =3D splice(result, dentry);=0A=
-			err =3D PTR_ERR(tmp);=0A=
-			if (IS_ERR(tmp))=0A=
-				goto err_dentry;=0A=
-			if (tmp !=3D result) {=0A=
-				/* it is safe to just use tmp instead, but we must discard result =
first */=0A=
-				d_drop(result);=0A=
-				dput(result);=0A=
-				result =3D tmp;=0A=
-				/* If !found, then this is really wierd, but it shouldn't hurt =
*/=0A=
-			}=0A=
 		}=0A=
+	/*=0A=
+	 * Now we need to make sure that target_dir is properly connected.=0A=
+	 * It may already be, as the flag isn't always updated when =
connection=0A=
+	 * happens.=0A=
+	 * So, we walk up parent links until we find a connected =
directory,=0A=
+	 * or we run out of directories.  Then we find the parent, find=0A=
+	 * the name of the child in that parent, and do a lookup.=0A=
+	 * This should connect the child into the parent=0A=
+	 * We then repeat.=0A=
+	 */=0A=
+=0A=
+	/* it is possible that a confused file system might no let up =
complete the=0A=
+	 * path to the root.  For example, if get_parent returns a =
directory=0A=
+	 * in which we cannot find a name for the child.  While this implies =
a very=0A=
+	 * sick filesystem we don't want it to cause knfsd to spin.  Hence =
the noprogress=0A=
+	 * counter.  If we go through the loop 10 times (2 is probably =
enough) without=0A=
+	 * getting anywhere, we just give up=0A=
+	 */=0A=
+	noprogress=3D 0;=0A=
+	while (target_dir->d_flags & DCACHE_NFSD_DISCONNECTED && noprogress++ =
< 10) {=0A=
+		struct dentry *pd =3D target_dir;=0A=
+		spin_lock(&dcache_lock);=0A=
+		while (!IS_ROOT(pd) &&=0A=
+		       (pd->d_parent->d_flags & DCACHE_NFSD_DISCONNECTED))=0A=
+			pd =3D pd->d_parent;=0A=
+=0A=
+		dget_locked(pd);=0A=
+		spin_unlock(&dcache_lock);=0A=
+=0A=
+		if (!IS_ROOT(pd)) {=0A=
+			/* must have found a connected parent - great */=0A=
+			pd->d_flags &=3D ~DCACHE_NFSD_DISCONNECTED;=0A=
+			noprogress =3D 0;=0A=
+		} else if (pd =3D=3D sb->s_root) {=0A=
+			printk("nfsd: Eeek filesystem root is not connected, =
impossible\n");=0A=
+			pd->d_flags &=3D ~DCACHE_NFSD_DISCONNECTED;=0A=
+			noprogress =3D 0;=0A=
 	} else {=0A=
-		nfsdstats.fh_nocache_dir++;=0A=
-		dentry =3D dget(result);=0A=
+			/* we have hit the top of a disconnected path.  Try=0A=
+			 * to find parent and connect=0A=
+			 * note: racing with some other process renaming a=0A=
+			 * directory isn't much of a problem here.  If someone=0A=
+			 * renames the directory, it will end up properly connected,=0A=
+			 * which is what we want=0A=
+			 */=0A=
+			struct dentry *ppd;=0A=
+			struct dentry *npd;=0A=
+			char nbuf[NAME_MAX+1];=0A=
+=0A=
+			down(&pd->d_inode->i_sem);=0A=
+			ppd =3D CALL(nops,get_parent)(pd);=0A=
+			up(&pd->d_inode->i_sem);=0A=
+=0A=
+			if (IS_ERR(ppd)) {=0A=
+				err =3D PTR_ERR(ppd);=0A=
+				dprintk("nfsfh: get_parent of %ld failed, err %d\n",=0A=
+					pd->d_inode->i_ino, err);=0A=
+				dput(pd);=0A=
+				break;=0A=
 	}=0A=
-=0A=
-	while(!found) {=0A=
-		/* LOOP INVARIANT */=0A=
-		/* haven't found a place in the tree yet, but we do have a free =
path=0A=
-		 * from dentry down to result, and dentry is a directory.=0A=
-		 * Have a hold on dentry and result */=0A=
-		struct dentry *pdentry;=0A=
-		struct inode *parent;=0A=
-=0A=
-		pdentry =3D nfsd_findparent(dentry);=0A=
-		err =3D PTR_ERR(pdentry);=0A=
-		if (IS_ERR(pdentry))=0A=
-			goto err_dentry;=0A=
-		parent =3D pdentry->d_inode;=0A=
-		err =3D -EACCES;=0A=
-		if (!parent) {=0A=
-			dput(pdentry);=0A=
-			goto err_dentry;=0A=
-		}=0A=
-=0A=
-		if (!(dentry->d_flags & DCACHE_NFSD_DISCONNECTED))=0A=
-			found =3D 1;=0A=
-=0A=
-		tmp =3D splice(dentry, pdentry);=0A=
-		if (tmp !=3D dentry) {=0A=
-			/* Something wrong.  We need to drop thw whole dentry->result =
path=0A=
-			 * whatever it was=0A=
-			 */=0A=
-			struct dentry *d;=0A=
-			for (d=3Dresult ; d ; d=3D(d->d_parent =3D=3D =
d)?NULL:d->d_parent)=0A=
-				d_drop(d);=0A=
-		}=0A=
-		if (IS_ERR(tmp)) {=0A=
-			err =3D PTR_ERR(tmp);=0A=
-			dput(pdentry);=0A=
-			goto err_dentry;=0A=
+			dprintk("nfsfh: find name of %lu in %lu\n", pd->d_inode->i_ino, =
ppd->d_inode->i_ino);=0A=
+			err =3D CALL(nops,get_name)(ppd, nbuf, pd);=0A=
+			if (err) {=0A=
+				dput(ppd);=0A=
+				if (err =3D=3D -ENOENT)=0A=
+					/* some race between get_parent and get_name?=0A=
+					 * just try again=0A=
+					 */=0A=
+					continue;=0A=
+				dput(pd);=0A=
+				break;=0A=
 		}=0A=
-		if (tmp !=3D dentry) {=0A=
-			/* we lost a race,  try again=0A=
+			dprintk("nfsfh: found name: %s\n", nbuf);=0A=
+			down(&ppd->d_inode->i_sem);=0A=
+			npd =3D lookup_one(nbuf, ppd);=0A=
+			up(&ppd->d_inode->i_sem);=0A=
+			if (IS_ERR(npd)) {=0A=
+				err =3D PTR_ERR(npd);=0A=
+				dprintk("nfsfh: lookup failed: %d\n", err);=0A=
+				dput(ppd);=0A=
+				dput(pd);=0A=
+				break;=0A=
+			}=0A=
+			/* we didn't really want npd, we really wanted=0A=
+			 * a side-effect of the lookup.=0A=
+			 * hopefully, npd =3D=3D pd, though it isn't really=0A=
+			 * a problem if it isn't=0A=
 			 */=0A=
-			dput(pdentry);=0A=
-			dput(tmp);=0A=
-			dput(dentry);=0A=
-			dput(result);	/* this will discard the whole free path, so we can =
up the semaphore */=0A=
-			up(&sb->s_nfsd_free_path_sem);=0A=
-			goto retry;=0A=
+			if (npd =3D=3D pd)=0A=
+				noprogress =3D 0;=0A=
+			else=0A=
+				printk("nfsd: npd !=3D pd\n");=0A=
+			dput(npd);=0A=
+			dput(ppd);=0A=
+			if (IS_ROOT(pd)) {=0A=
+				/* something went wrong, we will have to give up */=0A=
+				dput(pd);=0A=
+				break;=0A=
 		}=0A=
-		dput(dentry);=0A=
-		dentry =3D pdentry;=0A=
 	}=0A=
-	dput(dentry);=0A=
-	up(&sb->s_nfsd_free_path_sem);=0A=
+		dput(pd);=0A=
+	}=0A=
+=0A=
+	if (target_dir->d_flags & DCACHE_NFSD_DISCONNECTED) {=0A=
+		/* something went wrong - oh-well */=0A=
+		if (!err)=0A=
+			err =3D -ESTALE;=0A=
+		goto err_target;=0A=
+	}=0A=
+	/* if we weren't after a directory, have one more step to go */=0A=
+	if (result !=3D target_dir) {=0A=
+		struct dentry *nresult;=0A=
+		char nbuf[NAME_MAX+1];=0A=
+		err =3D CALL(nops,get_name)(target_dir, nbuf, result);=0A=
+		if (!err) {=0A=
+			down(&target_dir->d_inode->i_sem);=0A=
+			nresult =3D lookup_one(nbuf, target_dir);=0A=
+			up(&target_dir->d_inode->i_sem);=0A=
+			if (!IS_ERR(nresult)) {=0A=
+				if (nresult->d_inode) {=0A=
+					dput(result);=0A=
+					result =3D nresult;=0A=
+				} else=0A=
+					dput(nresult);=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+	dput(target_dir);=0A=
+	/* now result is properly connected, it is our best bet */=0A=
+	if (acceptable(context, result))=0A=
 	return result;=0A=
+	/* one last try of the aliases.. */=0A=
+	spin_lock(&dcache_lock);=0A=
+	head =3D &result->d_inode->i_dentry;=0A=
+	list_for_each(le, head) {=0A=
+		struct dentry *dentry =3D list_entry(le, struct dentry, d_alias);=0A=
+		if (dentry !=3D result &&=0A=
+		    acceptable(context, dentry)) {=0A=
+			dget_locked(dentry);=0A=
+			spin_unlock(&dcache_lock);=0A=
+			dput(result);=0A=
+			return dentry;=0A=
+		}=0A=
+	}=0A=
+	spin_unlock(&dcache_lock);=0A=
 =0A=
-err_dentry:=0A=
-	dput(dentry);=0A=
-err_result:=0A=
+	/* drat - I just cannot find anything acceptable */=0A=
 	dput(result);=0A=
-	up(&sb->s_nfsd_free_path_sem);=0A=
-err_out:=0A=
+	return ERR_PTR(-ESTALE);=0A=
+=0A=
+ err_target:=0A=
+	dput(target_dir);=0A=
+ err_result:=0A=
+	dput(result);=0A=
+ err_out:=0A=
 	if (err =3D=3D -ESTALE)=0A=
 		nfsdstats.fh_stale++;=0A=
 	return ERR_PTR(err);=0A=
 }=0A=
 =0A=
+=0A=
+/**=0A=
+ * nfsd_decode_fh - default nfsd_operations->decode_fh function=0A=
+ * sb:  The superblock=0A=
+ * fh:  pointer to the file handle fragment=0A=
+ * fh_len: length of file handle fragment=0A=
+ * acceptable: function for testing acceptability of dentrys=0A=
+ * context:   context for @acceptable=0A=
+ *=0A=
+ * This default decode_fh() function assumes that the object =
identifier=0A=
+ * is at the start of the fragment, and that the parent identifier, =
if=0A=
+ * present, is 8 bytes in.=0A=
+ */=0A=
+struct dentry *nfsd_decode_fh(struct super_block *sb, char *fh, int =
fh_len,=0A=
+			 int (*acceptable)(void *context, struct dentry *de),=0A=
+			 void *context)=0A=
+{=0A=
+	char *parent =3D fh+8;=0A=
+	if (fh_len <=3D8)=0A=
+		parent =3D NULL;=0A=
+	return nfsd_find_fh_dentry(sb, fh, parent,=0A=
+				   acceptable, context);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * our acceptability function.=0A=
+ * if NOSUBTREECHECK, accept anything=0A=
+ * if not, require that we can walk up to exp->ex_dentry=0A=
+ * doing some checks on the 'x' bits=0A=
+ */=0A=
+int nfsd_acceptable(void *expv, struct dentry *dentry)=0A=
+{=0A=
+	struct svc_export *exp =3D expv;=0A=
+	struct dentry *tdentry;=0A=
+	if (exp->ex_flags & NFSEXP_NOSUBTREECHECK)=0A=
+		return 1;=0A=
+=0A=
+	for (tdentry =3D dentry;=0A=
+	     tdentry !=3D exp->ex_dentry && ! IS_ROOT(tdentry);=0A=
+	     tdentry =3D tdentry->d_parent) {=0A=
+		/* make sure parents give x permission to user */=0A=
+		if (permission(tdentry->d_parent->d_inode, S_IXOTH)<0)=0A=
+			break;=0A=
+	}=0A=
+	if (tdentry !=3D exp->ex_dentry)=0A=
+		dprintk("nfsd_acceptable failed at %p %s\n", tdentry, =
tdentry->d_name.name);=0A=
+	return tdentry =3D=3D exp->ex_dentry;=0A=
+}=0A=
+=0A=
+=0A=
 /*=0A=
  * Perform sanity checks on the dentry in a client's file handle.=0A=
  *=0A=
@@ -543,7 +571,6 @@=0A=
 =0A=
 		if (!exp) {=0A=
 			/* export entry revoked */=0A=
-			nfsdstats.fh_stale++;=0A=
 			goto out;=0A=
 		}=0A=
 =0A=
@@ -563,44 +590,43 @@=0A=
 		/*=0A=
 		 * Look up the dentry using the NFS file handle.=0A=
 		 */=0A=
-		error =3D nfserr_stale;=0A=
-		if (rqstp->rq_vers =3D=3D 3)=0A=
-			error =3D nfserr_badhandle;=0A=
 =0A=
 		if (fh->fh_version =3D=3D 1) {=0A=
-			/* if fileid_type !=3D 0, and super_operations provide fh_to_dentry =
lookup,=0A=
-			 *  then should use that */=0A=
-			switch (fh->fh_fileid_type) {=0A=
-			case 0:=0A=
+			if (fh->fh_fileid_type =3D=3D 0)=0A=
 				dentry =3D dget(exp->ex_dentry);=0A=
-				break;=0A=
-			case 1:=0A=
-				if ((data_left-=3D2)<0) goto out;=0A=
-				dentry =3D find_fh_dentry(exp->ex_dentry->d_inode->i_sb,=0A=
-							datap[0], datap[1],=0A=
-							0,=0A=
-							!(exp->ex_flags & NFSEXP_NOSUBTREECHECK));=0A=
-				break;=0A=
-			case 2:=0A=
-				if ((data_left-=3D3)<0) goto out;=0A=
-				dentry =3D find_fh_dentry(exp->ex_dentry->d_inode->i_sb,=0A=
-							datap[0], datap[1],=0A=
-							datap[2],=0A=
-							!(exp->ex_flags & NFSEXP_NOSUBTREECHECK));=0A=
-				break;=0A=
-			default: goto out;=0A=
+			else {=0A=
+				struct nfsd_operations *nop =3D exp->ex_mnt->mnt_sb->s_nfsd_op;=0A=
+				int len =3D fh->fh_fileid_type;=0A=
+				/* compatibility with earlier code.. */=0A=
+				switch(len) {=0A=
+				case 1: len =3D 8; break;=0A=
+				case 2: len =3D 12; break;=0A=
+				}=0A=
+				if (len > data_left*4) len =3D data_left*4;=0A=
+				dentry  =3D CALL(nop,decode_fh)(exp->ex_mnt->mnt_sb,=0A=
+							      (char*)datap, len,=0A=
+							      nfsd_acceptable, exp);=0A=
+				=0A=
+				nfsdstats.fh_lookup++;=0A=
 			}=0A=
 		} else {=0A=
-=0A=
-			dentry =3D find_fh_dentry(exp->ex_dentry->d_inode->i_sb,=0A=
-						fh->ofh_ino, fh->ofh_generation,=0A=
-						fh->ofh_dirino,=0A=
-						!(exp->ex_flags & NFSEXP_NOSUBTREECHECK));=0A=
+			struct nfsd_operations *nop =3D exp->ex_mnt->mnt_sb->s_nfsd_op;=0A=
+			__u32 handle[4];=0A=
+			handle[0] =3D fh->ofh_ino;=0A=
+			handle[1] =3D fh->ofh_generation;=0A=
+			handle[2] =3D fh->ofh_dirino;=0A=
+			handle[3] =3D 0;=0A=
+			dentry =3D CALL(nop,decode_fh)(exp->ex_mnt->mnt_sb,=0A=
+						     (char*)handle, fh->ofh_dirino?12:8,=0A=
+						     nfsd_acceptable, exp);=0A=
+			nfsdstats.fh_lookup++;=0A=
 		}=0A=
-		if (IS_ERR(dentry)) {=0A=
-			error =3D nfserrno(PTR_ERR(dentry));=0A=
+=0A=
+		error =3D nfserr_stale;=0A=
+		if (rqstp->rq_vers =3D=3D 3 && dentry =3D=3D NULL)=0A=
+			error =3D nfserr_badhandle;=0A=
+		if (dentry =3D=3D NULL || IS_ERR(dentry))=0A=
 			goto out;=0A=
-		}=0A=
 #ifdef NFSD_PARANOIA=0A=
 		if (S_ISDIR(dentry->d_inode->i_mode) &&=0A=
 		    (dentry->d_flags & DCACHE_NFSD_DISCONNECTED)) {=0A=
@@ -630,7 +656,7 @@=0A=
 	 * write call).=0A=
 	 */=0A=
 =0A=
-	/* When is type ever negative? */=0A=
+	/* Type can be negative when creating hardlinks - not to a dir */=0A=
 	if (type > 0 && (inode->i_mode & S_IFMT) !=3D type) {=0A=
 		error =3D (type =3D=3D S_IFDIR)? nfserr_notdir : nfserr_isdir;=0A=
 		goto out;=0A=
@@ -640,58 +666,58 @@=0A=
 		goto out;=0A=
 	}=0A=
 =0A=
-	/*=0A=
-	 * Security: Check that the export is valid for dentry =
<gam3@acm.org>=0A=
-	 */=0A=
-	error =3D 0;=0A=
-=0A=
-	if (!(exp->ex_flags & NFSEXP_NOSUBTREECHECK)) {=0A=
-		if (exp->ex_dentry !=3D dentry) {=0A=
-			struct dentry *tdentry =3D dentry;=0A=
-=0A=
-			do {=0A=
-				tdentry =3D tdentry->d_parent;=0A=
-				if (exp->ex_dentry =3D=3D tdentry)=0A=
-					break;=0A=
-				/* executable only by root and we can't be root */=0A=
-				if (current->fsuid=0A=
-				    && (exp->ex_flags & NFSEXP_ROOTSQUASH)=0A=
-				    && !(tdentry->d_inode->i_uid=0A=
-					 && (tdentry->d_inode->i_mode & S_IXUSR))=0A=
-				    && !(tdentry->d_inode->i_gid=0A=
-					 && (tdentry->d_inode->i_mode & S_IXGRP))=0A=
-				    && !(tdentry->d_inode->i_mode & S_IXOTH)=0A=
-					) {=0A=
-					error =3D nfserr_stale;=0A=
-					nfsdstats.fh_stale++;=0A=
-					dprintk("fh_verify: no root_squashed access.\n");=0A=
-				}=0A=
-			} while ((tdentry !=3D tdentry->d_parent));=0A=
-			if (exp->ex_dentry !=3D tdentry) {=0A=
-				error =3D nfserr_stale;=0A=
-				nfsdstats.fh_stale++;=0A=
-				printk("nfsd Security: %s/%s bad export.\n",=0A=
-				       dentry->d_parent->d_name.name,=0A=
-				       dentry->d_name.name);=0A=
-				goto out;=0A=
-			}=0A=
-		}=0A=
-	}=0A=
-=0A=
 	/* Finally, check access permissions. */=0A=
-	if (!error) {=0A=
 		error =3D nfsd_permission(exp, dentry, access);=0A=
-	}=0A=
-#ifdef NFSD_PARANOIA=0A=
+#ifdef NFSD_PARANOIA_EXTREME=0A=
 	if (error) {=0A=
 		printk("fh_verify: %s/%s permission failure, acc=3D%x, =
error=3D%d\n",=0A=
 		       dentry->d_parent->d_name.name, dentry->d_name.name, access, =
(error >> 24));=0A=
 	}=0A=
 #endif=0A=
 out:=0A=
+	if (error =3D=3D nfserr_stale)=0A=
+		nfsdstats.fh_stale++;=0A=
 	return error;=0A=
 }=0A=
 =0A=
+=0A=
+=0A=
+/**=0A=
+ * nfsd_encode_fh - default nfsd_operations->encode_fh function=0A=
+ * dentry:  the dentry to encode=0A=
+ * fh:      where to stor the file handle fragment=0A=
+ * max_len: maximum length to store there=0A=
+ * connectable: whether to store parent infomation=0A=
+ *=0A=
+ * This default encode_fh function assumes that the 32 inode number=0A=
+ * is suitable for locating an inode, and that the generation =
number=0A=
+ * can be used to check that it is still valid.  It places them in =
the=0A=
+ * filehandle fragment where nfsd_decode_fh expects to find them.=0A=
+ */=0A=
+int nfsd_encode_fh(struct dentry *dentry, char *fh, int max_len,=0A=
+		   int connectable)=0A=
+{=0A=
+	struct inode * inode =3D dentry->d_inode;=0A=
+	struct inode *parent =3D dentry->d_parent->d_inode;=0A=
+	__u32 new[4];=0A=
+	int cnt =3D 8;=0A=
+	=0A=
+	if (max_len < 8 || (connectable && max_len < 16))=0A=
+		return -ENOSPC;=0A=
+=0A=
+	new[0] =3D inode->i_ino;=0A=
+	new[1] =3D inode->i_generation;=0A=
+	if (connectable && !S_ISDIR(inode->i_mode)) {=0A=
+		new[2] =3D parent->i_ino;=0A=
+		new[3] =3D parent->i_generation;=0A=
+		cnt=3D 16;=0A=
+	}=0A=
+	memcpy(fh, new, cnt);=0A=
+	return cnt;=0A=
+}=0A=
+=0A=
+=0A=
+=0A=
 /*=0A=
  * Compose a file handle for an NFS reply.=0A=
  *=0A=
@@ -702,20 +728,24 @@=0A=
 inline int _fh_update(struct dentry *dentry, struct svc_export =
*exp,=0A=
 		      __u32 **datapp, int maxsize)=0A=
 {=0A=
-	__u32 *datap=3D *datapp;=0A=
+	struct nfsd_operations *nop =3D exp->ex_mnt->mnt_sb->s_nfsd_op;=0A=
+	int len, len2;=0A=
+	char *datap =3D (char*) *datapp;=0A=
+	=0A=
 	if (dentry =3D=3D exp->ex_dentry)=0A=
 		return 0;=0A=
-	/* if super_operations provides dentry_to_fh lookup, should use that =
*/=0A=
 	=0A=
-	*datap++ =3D ino_t_to_u32(dentry->d_inode->i_ino);=0A=
-	*datap++ =3D dentry->d_inode->i_generation;=0A=
-	if (S_ISDIR(dentry->d_inode->i_mode) || (exp->ex_flags & =
NFSEXP_NOSUBTREECHECK)){=0A=
-		*datapp =3D datap;=0A=
-		return 1;=0A=
-	}=0A=
-	*datap++ =3D ino_t_to_u32(dentry->d_parent->d_inode->i_ino);=0A=
-	*datapp =3D datap;=0A=
-	return 2;=0A=
+	len =3D CALL(nop,encode_fh)(dentry, datap, maxsize,=0A=
+			     !(exp->ex_flags&NFSEXP_NOSUBTREECHECK));=0A=
+	if (len<0)=0A=
+		return len;=0A=
+=0A=
+	/* round to four-byte boundry */=0A=
+	len2=3Dlen;=0A=
+	while (len2&3)=0A=
+		datap[len2++] =3D 0;=0A=
+	*datapp =3D (__u32*) (datap+len2);=0A=
+	return len;=0A=
 }=0A=
 =0A=
 int=0A=
@@ -724,6 +754,7 @@=0A=
 	struct inode * inode =3D dentry->d_inode;=0A=
 	struct dentry *parent =3D dentry->d_parent;=0A=
 	__u32 *datap;=0A=
+	int err;=0A=
 =0A=
 	dprintk("nfsd: fh_compose(exp %x/%ld %s/%s, ino=3D%ld)\n",=0A=
 		exp->ex_dev, (long) exp->ex_ino,=0A=
@@ -749,9 +780,12 @@=0A=
 	*datap++ =3D htonl((MAJOR(exp->ex_dev)<<16)| MINOR(exp->ex_dev));=0A=
 	*datap++ =3D ino_t_to_u32(exp->ex_ino);=0A=
 =0A=
-	if (inode)=0A=
-		fhp->fh_handle.fh_fileid_type =3D=0A=
-			_fh_update(dentry, exp, &datap, fhp->fh_maxsize-3);=0A=
+	if (inode) {=0A=
+		err =3D _fh_update(dentry, exp, &datap, fhp->fh_maxsize-3*4);=0A=
+		if (err < 0)=0A=
+			return nfserr_opnotsupp;=0A=
+		fhp->fh_handle.fh_fileid_type =3D err;=0A=
+	}=0A=
 =0A=
 	fhp->fh_handle.fh_size =3D (datap-fhp->fh_handle.fh_auth+1)*4;=0A=
 =0A=
@@ -755,10 +789,7 @@=0A=
 =0A=
 	fhp->fh_handle.fh_size =3D (datap-fhp->fh_handle.fh_auth+1)*4;=0A=
 =0A=
-=0A=
 	nfsd_nr_verified++;=0A=
-	if (fhp->fh_handle.fh_fileid_type =3D=3D 255)=0A=
-		return nfserr_opnotsupp;=0A=
 	return 0;=0A=
 }=0A=
 =0A=
@@ -771,6 +802,7 @@=0A=
 {=0A=
 	struct dentry *dentry;=0A=
 	__u32 *datap;=0A=
+	int err;=0A=
 	=0A=
 	if (!fhp->fh_dentry)=0A=
 		goto out_bad;=0A=
@@ -782,8 +814,10 @@=0A=
 		goto out_uptodate;=0A=
 	datap =3D fhp->fh_handle.fh_auth+=0A=
 		          fhp->fh_handle.fh_size/4 -1;=0A=
-	fhp->fh_handle.fh_fileid_type =3D=0A=
-		_fh_update(dentry, fhp->fh_export, &datap, =
fhp->fh_maxsize-fhp->fh_handle.fh_size);=0A=
+	err =3D_fh_update(dentry, fhp->fh_export, &datap, =
fhp->fh_maxsize-fhp->fh_handle.fh_size);=0A=
+	if (err < 0)=0A=
+		return nfserr_opnotsupp;=0A=
+	fhp->fh_handle.fh_fileid_type =3D err;=0A=
 	fhp->fh_handle.fh_size =3D (datap-fhp->fh_handle.fh_auth+1)*4;=0A=
 out:=0A=
 	return 0;=0A=
@@ -816,3 +850,30 @@=0A=
 	}=0A=
 	return;=0A=
 }=0A=
+=0A=
+static struct dentry *nfsd_get_parent(struct dentry *child)=0A=
+{=0A=
+	/* get_parent cannot be supported generically, the locking=0A=
+	 * is too icky.=0A=
+	 * instead, we just return EACCES.  If server reboots or inodes=0A=
+	 * get flused, you lose=0A=
+	 */=0A=
+	return ERR_PTR(-EACCES);=0A=
+}=0A=
+=0A=
+=0A=
+struct nfsd_operations nfsd_op_default =3D {=0A=
+	decode_fh:	nfsd_decode_fh,=0A=
+	encode_fh:	nfsd_encode_fh,=0A=
+=0A=
+	get_name:	nfsd_get_name,=0A=
+	get_parent:	nfsd_get_parent,=0A=
+	get_dentry:	nfsd_get_dentry,=0A=
+};=0A=
+=0A=
+#ifndef CONFIG_NFSD_MODULE=0A=
+/* we don't export this when compiling as a module, as=0A=
+ * we use the nfsd_linkage structure for linkage instead=0A=
+ */=0A=
+EXPORT_SYMBOL(nfsd_find_fh_dentry);=0A=
+#endif=0A=
diff -rubB linux-2.4.4.orig/fs/reiserfs/inode.c =
linux-2.4.4-knfsd/fs/reiserfs/inode.c=0A=
--- linux-2.4.4.orig/fs/reiserfs/inode.c	Mon Apr 30 14:55:07 2001=0A=
+++ linux-2.4.4-knfsd/fs/reiserfs/inode.c	Mon Apr 30 15:13:43 2001=0A=
@@ -918,7 +918,6 @@=0A=
 =0A=
 =0A=
     copy_key (INODE_PKEY (inode), &(ih->ih_key));=0A=
-    inode->i_generation =3D INODE_PKEY (inode)->k_dir_id;=0A=
     inode->i_blksize =3D PAGE_SIZE;=0A=
 =0A=
     if (stat_data_v1 (ih)) {=0A=
@@ -936,6 +935,7 @@=0A=
 	inode->i_ctime =3D le32_to_cpu (sd->sd_ctime);=0A=
 =0A=
 	inode->i_blocks =3D le32_to_cpu (sd->u.sd_blocks);=0A=
+	inode->i_generation =3D INODE_PKEY (inode)->k_dir_id;=0A=
 	blocks =3D (inode->i_size + 511) >> 9;=0A=
 	blocks =3D _ROUND_UP (blocks, inode->i_blksize >> 9);=0A=
 	if (inode->i_blocks > blocks) {=0A=
@@ -970,6 +970,10 @@=0A=
 	inode->i_ctime =3D le32_to_cpu (sd->sd_ctime);=0A=
 	inode->i_blocks =3D le32_to_cpu (sd->sd_blocks);=0A=
 	rdev =3D le32_to_cpu (sd->u.sd_rdev);=0A=
+	if( S_ISCHR( inode -> i_mode ) || S_ISBLK( inode -> i_mode ) )=0A=
+	    inode->i_generation =3D INODE_PKEY (inode)->k_dir_id;=0A=
+	else=0A=
+	    inode->i_generation =3D le32_to_cpu( sd->u.sd_generation );=0A=
     }=0A=
 =0A=
     /* nopack =3D 0, by default */=0A=
@@ -1007,8 +1011,11 @@=0A=
     sd_v2->sd_atime =3D cpu_to_le32 (inode->i_atime);=0A=
     sd_v2->sd_ctime =3D cpu_to_le32 (inode->i_ctime);=0A=
     sd_v2->sd_blocks =3D cpu_to_le32 (inode->i_blocks);=0A=
-    if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))=0A=
+    if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {=0A=
 	sd_v2->u.sd_rdev =3D cpu_to_le32 (inode->i_rdev);=0A=
+    } else {=0A=
+	sd_v2->u.sd_generation =3D cpu_to_le32( inode -> i_generation );=0A=
+    }=0A=
 }=0A=
 =0A=
 =0A=
@@ -1422,6 +1429,18 @@=0A=
       U32_MAX/*NO_BYTES_IN_DIRECT_ITEM*/;=0A=
 =0A=
     if (old_format_only (sb))=0A=
+      /* not a perfect generation count, as object ids can be reused, =
but this=0A=
+      ** is as good as reiserfs can do right now=0A=
+      */=0A=
+      inode->i_generation =3D INODE_PKEY (inode)->k_dir_id;=0A=
+    else=0A=
+#if defined( USE_INODE_GENERATION_COUNTER )=0A=
+      inode->i_generation =3D =0A=
+	le32_to_cpu( sb -> u.reiserfs_sb.s_rs -> s_inode_generation );=0A=
+#else=0A=
+      inode->i_generation =3D ++event;=0A=
+#endif=0A=
+    if (old_format_only (sb))=0A=
 	inode2sd_v1 (&sd, inode);=0A=
     else=0A=
 	inode2sd (&sd, inode);=0A=
@@ -1468,10 +1487,6 @@=0A=
 	return NULL;=0A=
     }=0A=
 =0A=
-    /* not a perfect generation count, as object ids can be reused, =
but this=0A=
-    ** is as good as reiserfs can do right now=0A=
-    */=0A=
-    inode->i_generation =3D INODE_PKEY (inode)->k_dir_id;=0A=
     insert_inode_hash (inode);=0A=
     // we do not mark inode dirty: on disk content matches to the=0A=
     // in-core one=0A=
diff -rubB linux-2.4.4.orig/fs/reiserfs/namei.c =
linux-2.4.4-knfsd/fs/reiserfs/namei.c=0A=
--- linux-2.4.4.orig/fs/reiserfs/namei.c	Mon Apr 30 14:55:07 2001=0A=
+++ linux-2.4.4-knfsd/fs/reiserfs/namei.c	Mon Apr 30 15:13:43 2001=0A=
@@ -18,6 +18,7 @@=0A=
 #include <linux/bitops.h>=0A=
 #include <linux/reiserfs_fs.h>=0A=
 #include <linux/smp_lock.h>=0A=
+#include <linux/nfsd/interface.h>=0A=
 =0A=
 #else=0A=
 =0A=
@@ -25,6 +26,39 @@=0A=
 =0A=
 #endif=0A=
 =0A=
+typedef struct __r5fs_nfs_fh_nogen=0A=
+{=0A=
+  __u32 objectid;=0A=
+  __u32 dirid;=0A=
+} __attribute__((__packed__)) __r5fs_nfs_fh_nogen;=0A=
+=0A=
+typedef struct __r5fs_nfs_fh_full=0A=
+{=0A=
+  __r5fs_nfs_fh_nogen base;=0A=
+  __u32               generation;=0A=
+} __attribute__((__packed__)) __r5fs_nfs_fh_full;=0A=
+=0A=
+typedef union __r5fs_nfs_subfh=0A=
+{=0A=
+  __r5fs_nfs_fh_nogen nogen;=0A=
+  __r5fs_nfs_fh_full  full;=0A=
+} __attribute__((__packed__)) __r5fs_nfs_subfh;=0A=
+=0A=
+typedef struct __r5fs_nfs_fh=0A=
+{=0A=
+  __r5fs_nfs_fh_full  object;=0A=
+  __r5fs_nfs_subfh    parent;=0A=
+} __attribute__((__packed__)) __r5fs_nfs_fh;=0A=
+=0A=
+typedef enum { full_subfh, nogen_subfh } subfh_type;=0A=
+typedef struct __r5fs_nfs_subfh_wrapper=0A=
+{=0A=
+  subfh_type       type;=0A=
+  __r5fs_nfs_subfh subfh;=0A=
+} __attribute__((__packed__)) __r5fs_nfs_subfh_wrapper;=0A=
+=0A=
+static char no_knfsd_support_panic[] =3D "reiserfs: %s called w/o =
CONFIG_NFSD\n";=0A=
+=0A=
 				/* there should be an overview right=0A=
                                    here, as there should be in =
every=0A=
                                    conceptual grouping of code.  =
This=0A=
@@ -387,10 +421,99 @@=0A=
         }=0A=
     }=0A=
 =0A=
+    /* added for knfsd support */=0A=
+    if (inode)=0A=
+        return d_splice_alias(inode, dentry) ;=0A=
+=0A=
     d_add(dentry, inode);=0A=
     return NULL;=0A=
 }=0A=
+/*=0A=
+** reiserfs_get_dentry: inump is a pointer to =
__r5fs_nfs_subfh_wrapper,=0A=
+** set up by reiserfs_decode_fh().=0A=
+**=0A=
+** taken from nfsd_get_dentry=0A=
+*/=0A=
+struct dentry *reiserfs_get_dentry(struct super_block *s, void =
*inump)=0A=
+{=0A=
+    struct dentry *dentry;=0A=
+    struct inode *inode;=0A=
+    __r5fs_nfs_subfh_wrapper *fh;=0A=
+    unsigned long ino;=0A=
+    struct reiserfs_iget4_args args ;=0A=
+=0A=
+    fh =3D ( __r5fs_nfs_subfh_wrapper * )inump;=0A=
+=0A=
+    ino =3D fh -> subfh.nogen.objectid;=0A=
+    args.objectid =3D fh -> subfh.nogen.dirid;=0A=
+    if (ino =3D=3D 0)=0A=
+	return NULL;=0A=
 =0A=
+    inode =3D iget4(s, ino, 0, (void *)(&args));=0A=
+    if (!inode) {=0A=
+	printk("reiserfs_get_dentry: iget4 returned NULL\n") ;=0A=
+	return NULL ;=0A=
+    }=0A=
+    if ( is_bad_inode( inode ) ||=0A=
+	 ( ( fh -> type =3D=3D full_subfh ) &&=0A=
+	   fh -> subfh.full.generation && =0A=
+	   ( inode -> i_generation !=3D fh -> subfh.full.generation ) ) ) =
{=0A=
+      /* we didn't find the right inode.. */=0A=
+      printk( "reiserfs: [CAN IGNORE: stale NFS handle] =
knfsd-fh-mismatch: %s:%s:%i " =0A=
+	      "%s inode %lx, count: %d %d [%i %i]/[%x %x]\n",=0A=
+	      __FUNCTION__, __FILE__, __LINE__,=0A=
+	      is_bad_inode( inode ) ? "bad" : "ok",=0A=
+	      inode->i_ino,=0A=
+	      inode->i_nlink, atomic_read(&inode->i_count),=0A=
+	      fh -> subfh.full.generation, inode->i_generation,=0A=
+	      fh -> subfh.nogen.dirid, inode -> u.reiserfs_i.i_key[ 1 ] );=0A=
+=0A=
+	iput(inode);=0A=
+	return NULL;=0A=
+    }=0A=
+    dentry =3D d_make_alias(inode);=0A=
+    if (!dentry) {=0A=
+	iput(inode);=0A=
+	dentry =3D ERR_PTR(-ENOMEM);=0A=
+    }=0A=
+    return dentry;=0A=
+}=0A=
+=0A=
+/* =0A=
+** looks up the dentry of the parent directory for child.=0A=
+** taken from ext2_get_parent=0A=
+*/=0A=
+struct dentry *reiserfs_get_parent(struct dentry *child)=0A=
+{=0A=
+    int retval;=0A=
+    struct inode * inode =3D NULL;=0A=
+    struct reiserfs_dir_entry de;=0A=
+    INITIALIZE_PATH (path_to_entry);=0A=
+    struct dentry *parent;=0A=
+    struct inode *dir =3D child->d_inode ;=0A=
+=0A=
+    reiserfs_check_lock_depth("reiserfs_get_parent") ;=0A=
+=0A=
+    if (dir->i_nlink =3D=3D 0) {=0A=
+	return ERR_PTR(-ENOENT);=0A=
+    }=0A=
+    de.de_gen_number_bit_string =3D 0;=0A=
+    retval =3D reiserfs_find_entry (dir, "..", 2, &path_to_entry, =
&de);=0A=
+    pathrelse (&path_to_entry);=0A=
+    if (retval =3D=3D NAME_FOUND) {=0A=
+	inode =3D reiserfs_iget (dir->i_sb, (struct cpu_key =
*)&(de.de_dir_id));=0A=
+	if (!inode) {=0A=
+	    return ERR_PTR(-EACCES);=0A=
+        }=0A=
+	parent =3D d_make_alias(inode);=0A=
+	if (!parent) {=0A=
+		iput(inode);=0A=
+		parent =3D ERR_PTR(-ENOMEM);=0A=
+        }=0A=
+	return parent;=0A=
+    }=0A=
+    return ERR_PTR(-ENOENT);=0A=
+} =0A=
 =0A=
 //=0A=
 // a portion of this function, particularly the VFS interface =
portion,=0A=
@@ -1229,5 +1352,83 @@=0A=
     pop_journal_writer(windex) ;=0A=
     journal_end(&th, old_dir->i_sb, jbegin_count) ;=0A=
     return 0;=0A=
+}=0A=
+=0A=
+/* this is not best file to place following functions in, =0A=
+   but they don't worth creation of new one. */=0A=
+=0A=
+/* our file-handle fragment format is __r5fs_nfs_fh */=0A=
+struct dentry *reiserfs_decode_fh( struct super_block *sb, =0A=
+				   char *fh, int fh_len,=0A=
+				   int ( *acceptable )( void *context, =0A=
+							struct dentry *de ),=0A=
+				   void *context )=0A=
+{=0A=
+#if defined( CONFIG_NFSD ) || defined( CONFIG_NFSD_MODULE )=0A=
+=0A=
+  __r5fs_nfs_fh *handle;=0A=
+  __r5fs_nfs_subfh_wrapper object;=0A=
+  __r5fs_nfs_subfh_wrapper parent;=0A=
+=0A=
+  handle =3D ( __r5fs_nfs_fh * ) fh;=0A=
+=0A=
+  object.type =3D full_subfh;=0A=
+  object.subfh.full =3D handle -> object;=0A=
+  if( fh_len >=3D sizeof object.subfh.full + sizeof parent.subfh.nogen =
)=0A=
+    {=0A=
+      parent.subfh.nogen =3D handle -> parent.nogen;=0A=
+    }=0A=
+  if( fh_len >=3D 2 * sizeof( __r5fs_nfs_fh_full ) )=0A=
+    {=0A=
+      parent.subfh.full.generation =3D handle -> =
parent.full.generation;=0A=
+      parent.type =3D full_subfh;=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+      parent.type =3D nogen_subfh;=0A=
+    }=0A=
+  return nfsd_find_fh_dentry=0A=
+    ( sb, &object, =0A=
+      ( fh_len >=3D sizeof object.subfh.full + sizeof =
parent.subfh.nogen ) ? =0A=
+      &parent : NULL, =0A=
+      acceptable, context );=0A=
+#else=0A=
+  panic( no_knfsd_support_panic, __FUNCTION__ );=0A=
+#endif=0A=
+}=0A=
+=0A=
+int reiserfs_encode_fh( struct dentry *dentry, char *fh, int max_len, =
=0A=
+			int connectable )=0A=
+{=0A=
+#if defined( CONFIG_NFSD ) || defined( CONFIG_NFSD_MODULE )=0A=
+	struct inode * inode =3D dentry->d_inode;=0A=
+	struct inode *parent =3D dentry->d_parent->d_inode;=0A=
+	__r5fs_nfs_fh new;=0A=
+	int cnt =3D sizeof new.object;=0A=
+=0A=
+	if( max_len < cnt || =0A=
+	    ( connectable && =0A=
+	      max_len < sizeof new.object + sizeof new.parent.nogen ) )=0A=
+	  return -ENOSPC;=0A=
+=0A=
+	new.object.base.objectid =3D inode -> i_ino;=0A=
+	new.object.base.dirid =3D inode -> u.reiserfs_i.i_key[ 0 ];=0A=
+	new.object.generation =3D inode -> i_generation;=0A=
+	if(connectable) {=0A=
+	  new.parent.nogen.objectid =3D parent -> i_ino;=0A=
+	  new.parent.nogen.dirid =3D parent -> u.reiserfs_i.i_key[ 0 ];=0A=
+	  cnt +=3D sizeof new.parent.nogen;=0A=
+	  /* generation of parent doesn't fit into NFSv2 file-handle */=0A=
+	  if( max_len >=3D 2 * sizeof( __r5fs_nfs_fh_full ) )=0A=
+	    {=0A=
+	      new.parent.full.generation =3D parent -> i_generation;=0A=
+	      cnt +=3D sizeof new.parent.full.generation;=0A=
+	    }=0A=
+	}=0A=
+	memcpy(fh, &new, cnt);=0A=
+	return cnt;=0A=
+#else=0A=
+	panic( no_knfsd_support_panic, __FUNCTION__ );=0A=
+#endif=0A=
 }=0A=
 =0A=
diff -rubB linux-2.4.4.orig/fs/reiserfs/stree.c =
linux-2.4.4-knfsd/fs/reiserfs/stree.c=0A=
--- linux-2.4.4.orig/fs/reiserfs/stree.c	Mon Apr 30 14:55:07 2001=0A=
+++ linux-2.4.4-knfsd/fs/reiserfs/stree.c	Mon Apr 30 15:13:43 2001=0A=
@@ -1560,6 +1560,17 @@=0A=
         reiserfs_warning("clm-4001: deleting inode with link =
count=3D=3D%d\n", inode->i_nlink) ;=0A=
     }=0A=
 #endif=0A=
+#if defined( USE_INODE_GENERATION_COUNTER )=0A=
+    if( !old_format_only ( th -> t_super ) )=0A=
+      {=0A=
+       __u32 *inode_generation;=0A=
+       =0A=
+       inode_generation =3D =0A=
+         &th -> t_super -> u.reiserfs_sb.s_rs -> =
s_inode_generation;=0A=
+       *inode_generation =3D cpu_to_le32( le32_to_cpu( =
*inode_generation ) + 1 );=0A=
+      }=0A=
+/* USE_INODE_GENERATION_COUNTER */=0A=
+#endif=0A=
     reiserfs_delete_solid_item (th, INODE_PKEY (inode));=0A=
 }=0A=
 =0A=
diff -rubB linux-2.4.4.orig/fs/reiserfs/super.c =
linux-2.4.4-knfsd/fs/reiserfs/super.c=0A=
--- linux-2.4.4.orig/fs/reiserfs/super.c	Mon Apr 30 14:55:07 2001=0A=
+++ linux-2.4.4-knfsd/fs/reiserfs/super.c	Mon Apr 30 15:17:42 2001=0A=
@@ -21,6 +21,7 @@=0A=
 #include <linux/smp_lock.h>=0A=
 #include <linux/locks.h>=0A=
 #include <linux/init.h>=0A=
+#include <linux/nfsd/interface.h>=0A=
 =0A=
 #else=0A=
 =0A=
@@ -151,6 +152,24 @@=0A=
 =0A=
 };=0A=
 =0A=
+struct dentry *reiserfs_get_parent(struct dentry *) ;=0A=
+struct dentry *reiserfs_get_dentry(struct super_block *, void *) ;=0A=
+struct dentry *reiserfs_decode_fh( struct super_block *sb, =0A=
+				   char *fh, int fh_len,=0A=
+				   int ( *acceptable )( void *context, =0A=
+							struct dentry *de ),=0A=
+				   void *context );=0A=
+int reiserfs_encode_fh( struct dentry *dentry, char *fh, int max_len, =
=0A=
+						int connectable );=0A=
+=0A=
+static struct nfsd_operations reiserfs_nfsd_ops =3D {=0A=
+  encode_fh: reiserfs_encode_fh,=0A=
+  decode_fh: reiserfs_decode_fh,=0A=
+  get_parent: reiserfs_get_parent,=0A=
+  get_dentry: reiserfs_get_dentry,=0A=
+} ;=0A=
+=0A=
+=0A=
 /* this was (ext2)parse_options */=0A=
 static int parse_options (char * options, unsigned long * =
mount_options, unsigned long * blocks)=0A=
 {=0A=
@@ -413,6 +432,7 @@=0A=
     SB_BUFFER_WITH_SB (s) =3D bh;=0A=
     SB_DISK_SUPER_BLOCK (s) =3D rs;=0A=
     s->s_op =3D &reiserfs_sops;=0A=
+    s->s_nfsd_op =3D &reiserfs_nfsd_ops;=0A=
     return 0;=0A=
 }=0A=
 #endif=0A=
@@ -493,6 +513,7 @@=0A=
     SB_BUFFER_WITH_SB (s) =3D bh;=0A=
     SB_DISK_SUPER_BLOCK (s) =3D rs;=0A=
     s->s_op =3D &reiserfs_sops;=0A=
+    s->s_nfsd_op =3D &reiserfs_nfsd_ops;=0A=
 =0A=
     /* new format is limited by the 32 bit wide i_blocks field, want =
to=0A=
     ** be one full block below that.=0A=
diff -rubB linux-2.4.4.orig/fs/super.c linux-2.4.4-knfsd/fs/super.c=0A=
--- linux-2.4.4.orig/fs/super.c	Mon Apr 30 14:55:08 2001=0A=
+++ linux-2.4.4-knfsd/fs/super.c	Mon Apr 30 15:13:43 2001=0A=
@@ -735,7 +735,6 @@=0A=
 	s->s_flags =3D flags;=0A=
 	s->s_dirt =3D 0;=0A=
 	sema_init(&s->s_vfs_rename_sem,1);=0A=
-	sema_init(&s->s_nfsd_free_path_sem,1);=0A=
 	s->s_type =3D type;=0A=
 	sema_init(&s->s_dquot.dqio_sem, 1);=0A=
 	sema_init(&s->s_dquot.dqoff_sem, 1);=0A=
diff -rubB linux-2.4.4.orig/fs/ufs/ialloc.c =
linux-2.4.4-knfsd/fs/ufs/ialloc.c=0A=
--- linux-2.4.4.orig/fs/ufs/ialloc.c	Mon Apr 30 14:28:25 2001=0A=
+++ linux-2.4.4-knfsd/fs/ufs/ialloc.c	Mon Apr 30 15:13:43 2001=0A=
@@ -272,6 +272,7 @@=0A=
 	inode->i_mtime =3D inode->i_atime =3D inode->i_ctime =3D =
CURRENT_TIME;=0A=
 	inode->u.ufs_i.i_flags =3D dir->u.ufs_i.i_flags;=0A=
 	inode->u.ufs_i.i_lastfrag =3D 0;=0A=
+	inode->i_generation =3D event++;=0A=
 =0A=
 	insert_inode_hash(inode);=0A=
 	mark_inode_dirty(inode);=0A=
diff -rubB linux-2.4.4.orig/fs/ufs/inode.c =
linux-2.4.4-knfsd/fs/ufs/inode.c=0A=
--- linux-2.4.4.orig/fs/ufs/inode.c	Mon Apr 30 14:28:25 2001=0A=
+++ linux-2.4.4-knfsd/fs/ufs/inode.c	Mon Apr 30 15:13:43 2001=0A=
@@ -562,13 +562,13 @@=0A=
 	if (inode->i_ino < UFS_ROOTINO || =0A=
 	    inode->i_ino > (uspi->s_ncg * uspi->s_ipg)) {=0A=
 		ufs_warning (sb, "ufs_read_inode", "bad inode number (%lu)\n", =
inode->i_ino);=0A=
-		return;=0A=
+		goto bad_inode;=0A=
 	}=0A=
 	=0A=
 	bh =3D bread (sb->s_dev, uspi->s_sbbase + =
ufs_inotofsba(inode->i_ino), sb->s_blocksize);=0A=
 	if (!bh) {=0A=
 		ufs_warning (sb, "ufs_read_inode", "unable to read inode %lu\n", =
inode->i_ino);=0A=
-		return;=0A=
+		goto bad_inode;=0A=
 	}=0A=
 	ufs_inode =3D (struct ufs_inode *) (bh->b_data + sizeof(struct =
ufs_inode) * ufs_inotofsbo(inode->i_ino));=0A=
 =0A=
@@ -577,9 +577,12 @@=0A=
 	 */=0A=
 	inode->i_mode =3D SWAB16(ufs_inode->ui_mode);=0A=
 	inode->i_nlink =3D SWAB16(ufs_inode->ui_nlink);=0A=
-	if (inode->i_nlink =3D=3D 0)=0A=
+	if (inode->i_nlink =3D=3D 0) {=0A=
+		/* probably NFSd with a stale file handle, not an error=0A=
 		ufs_error (sb, "ufs_read_inode", "inode %lu has zero nlink\n", =
inode->i_ino);=0A=
-	=0A=
+		*/=0A=
+		goto bad_inode;=0A=
+	}=0A=
 	/*=0A=
 	 * Linux now has 32-bit uid and gid, so we can support EFT.=0A=
 	 */=0A=
@@ -619,6 +622,8 @@=0A=
 			inode->u.ufs_i.i_u1.i_symlink[i] =3D =
ufs_inode->ui_u2.ui_symlink[i];=0A=
 	}=0A=
 =0A=
+	inode->i_generation =3D inode->u.ufs_i.i_gen;=0A=
+=0A=
 =0A=
 	if (S_ISREG(inode->i_mode)) {=0A=
 		inode->i_op =3D &ufs_file_inode_operations;=0A=
@@ -643,7 +648,10 @@=0A=
 #ifdef UFS_INODE_DEBUG_MORE=0A=
 	ufs_print_inode (inode);=0A=
 #endif=0A=
-	UFSD(("EXIT\n"))=0A=
+	UFSD(("EXIT\n"));=0A=
+ bad_inode:=0A=
+	make_bad_inode(inode);=0A=
+	return;=0A=
 }=0A=
 =0A=
 static int ufs_update_inode(struct inode * inode, int do_sync)=0A=
@@ -690,6 +698,7 @@=0A=
 	ufs_inode->ui_mtime.tv_usec =3D SWAB32(0);=0A=
 	ufs_inode->ui_blocks =3D SWAB32(inode->i_blocks);=0A=
 	ufs_inode->ui_flags =3D SWAB32(inode->u.ufs_i.i_flags);=0A=
+	inode->u.ufs_i.i_gen =3D inode->i_generation;=0A=
 	ufs_inode->ui_gen =3D SWAB32(inode->u.ufs_i.i_gen);=0A=
 =0A=
 	if ((flags & UFS_UID_MASK) =3D=3D UFS_UID_EFT) {=0A=
@@ -738,11 +747,14 @@=0A=
 {=0A=
 	/*inode->u.ufs_i.i_dtime =3D CURRENT_TIME;*/=0A=
 	lock_kernel();=0A=
+	if (!is_bad_inode(inode)) {=0A=
 	mark_inode_dirty(inode);=0A=
 	ufs_update_inode(inode, IS_SYNC(inode));=0A=
 	inode->i_size =3D 0;=0A=
 	if (inode->i_blocks)=0A=
 		ufs_truncate (inode);=0A=
 	ufs_free_inode (inode);=0A=
+	} else=0A=
+		clear_inode(inode);=0A=
 	unlock_kernel();=0A=
 }=0A=
diff -rubB linux-2.4.4.orig/fs/ufs/namei.c =
linux-2.4.4-knfsd/fs/ufs/namei.c=0A=
--- linux-2.4.4.orig/fs/ufs/namei.c	Mon Apr 30 14:28:25 2001=0A=
+++ linux-2.4.4-knfsd/fs/ufs/namei.c	Mon Apr 30 15:13:43 2001=0A=
@@ -208,9 +208,45 @@=0A=
 		if (!inode) =0A=
 			return ERR_PTR(-EACCES);=0A=
 	}=0A=
+	if (inode)=0A=
+		return d_splice_alias(inode, dentry);=0A=
+	=0A=
 	d_add(dentry, inode);=0A=
 	UFSD(("EXIT\n"))=0A=
 	return NULL;=0A=
+}=0A=
+=0A=
+struct dentry *ufs_get_parent(struct dentry *child)=0A=
+{=0A=
+	struct super_block * sb;=0A=
+	struct inode * inode;=0A=
+	struct ufs_dir_entry * de;=0A=
+	struct buffer_head * bh;=0A=
+	struct dentry *parent;=0A=
+	unsigned swab;=0A=
+	=0A=
+	UFSD(("ENTER\n"))=0A=
+	=0A=
+	sb =3D child->d_inode->i_sb;=0A=
+	swab =3D sb->u.ufs_sb.s_swab;=0A=
+	=0A=
+=0A=
+	bh =3D ufs_find_entry (child->d_inode, "..", 2, &de);=0A=
+	inode =3D NULL;=0A=
+	if (bh) {=0A=
+		unsigned long ino =3D SWAB32(de->d_ino);=0A=
+		brelse (bh);=0A=
+		inode =3D iget(sb, ino);=0A=
+	}=0A=
+	if (!inode) =0A=
+		return ERR_PTR(-EACCES);=0A=
+	parent =3D d_make_alias(inode);=0A=
+	if (!parent) {=0A=
+		iput(inode);=0A=
+		parent =3D ERR_PTR(-ENOMEM);=0A=
+	}=0A=
+	UFSD(("EXIT\n"))=0A=
+	return parent;=0A=
 }=0A=
 =0A=
 /*=0A=
diff -rubB linux-2.4.4.orig/fs/ufs/super.c =
linux-2.4.4-knfsd/fs/ufs/super.c=0A=
--- linux-2.4.4.orig/fs/ufs/super.c	Mon Apr 30 14:55:08 2001=0A=
+++ linux-2.4.4-knfsd/fs/ufs/super.c	Mon Apr 30 15:13:43 2001=0A=
@@ -80,6 +80,7 @@=0A=
 #include <linux/locks.h>=0A=
 #include <linux/blkdev.h>=0A=
 #include <linux/init.h>=0A=
+#include <linux/nfsd/interface.h>=0A=
 =0A=
 #include "swab.h"=0A=
 #include "util.h"=0A=
@@ -177,6 +178,7 @@=0A=
 #endif /* UFS_SUPER_DEBUG_MORE */=0A=
 =0A=
 static struct super_operations ufs_super_ops;=0A=
+static struct nfsd_operations ufs_nfsd_ops;=0A=
 =0A=
 static char error_buf[1024];=0A=
 =0A=
@@ -738,6 +740,7 @@=0A=
 	sb->s_blocksize =3D  SWAB32(usb1->fs_fsize);=0A=
 	sb->s_blocksize_bits =3D SWAB32(usb1->fs_fshift);=0A=
 	sb->s_op =3D &ufs_super_ops;=0A=
+	sb->s_nfsd_op =3D &ufs_nfsd_ops;=0A=
 	sb->dq_op =3D NULL; /***/=0A=
 	sb->s_magic =3D SWAB32(usb3->fs_magic);=0A=
 =0A=
@@ -980,6 +983,12 @@=0A=
 	write_super:	ufs_write_super,=0A=
 	statfs:		ufs_statfs,=0A=
 	remount_fs:	ufs_remount,=0A=
+};=0A=
+=0A=
+extern struct dentry *ufs_get_parent(struct dentry *child);=0A=
+=0A=
+static struct nfsd_operations ufs_nfsd_ops =3D {=0A=
+	get_parent:	ufs_get_parent,=0A=
 };=0A=
 =0A=
 static DECLARE_FSTYPE_DEV(ufs_fs_type, "ufs", ufs_read_super);=0A=
diff -rubB linux-2.4.4.orig/include/linux/dcache.h =
linux-2.4.4-knfsd/include/linux/dcache.h=0A=
--- linux-2.4.4.orig/include/linux/dcache.h	Mon Apr 30 14:55:13 2001=0A=
+++ linux-2.4.4-knfsd/include/linux/dcache.h	Mon Apr 30 15:13:43 =
2001=0A=
@@ -116,12 +116,17 @@=0A=
 					 * renamed" and has to be=0A=
 					 * deleted on the last dput()=0A=
 					 */=0A=
-#define	DCACHE_NFSD_DISCONNECTED 0x0004	/* This dentry is not =
currently connected to the=0A=
-					 * dcache tree. Its parent will either be itself,=0A=
-					 * or will have this flag as well.=0A=
-					 * If this dentry points to a directory, then=0A=
-					 * s_nfsd_free_path semaphore will be down=0A=
+#define	DCACHE_NFSD_DISCONNECTED 0x0004=0A=
+     /* This dentry is possibly not currently connected to the dcache =
tree,=0A=
+      * in which case its parent will either be itself, or will have =
this=0A=
+      * flag as well.  nfsd will not use a dentry with this bit set, =
but will=0A=
+      * first endeavour to clear the bit either by discovering that it =
is=0A=
+      * connected, or by performing lookup operations.   Any =
filesystem which=0A=
+      * supports nfsd_operations MUST have a lookup function which, if =
it finds=0A=
+      * a directory inode with a DCACHE_NFSD_DISCONNECTED dentry, will =
d_move=0A=
+      * that dentry into place and return that dentry rather than the =
passed one.=0A=
 					 */=0A=
+=0A=
 #define DCACHE_REFERENCED	0x0008  /* Recently used, don't discard. =
*/=0A=
 =0A=
 extern spinlock_t dcache_lock;=0A=
@@ -212,6 +217,11 @@=0A=
 =0A=
 /* used for rename() and baskets */=0A=
 extern void d_move(struct dentry *, struct dentry *);=0A=
+=0A=
+/* used in ->lookup in filesystems that play nice with knfsd */=0A=
+extern struct dentry *d_splice_alias(struct inode *inode, struct =
dentry *dentry);=0A=
+extern struct dentry *d_make_alias(struct inode *inode);=0A=
+   =0A=
 =0A=
 /* appendix may either be NULL or be used for transname suffixes */=0A=
 extern struct dentry * d_lookup(struct dentry *, struct qstr *);=0A=
diff -rubB linux-2.4.4.orig/include/linux/fs.h =
linux-2.4.4-knfsd/include/linux/fs.h=0A=
--- linux-2.4.4.orig/include/linux/fs.h	Mon Apr 30 14:55:13 2001=0A=
+++ linux-2.4.4-knfsd/include/linux/fs.h	Mon Apr 30 15:13:43 2001=0A=
@@ -652,6 +652,7 @@=0A=
 	struct file_system_type	*s_type;=0A=
 	struct super_operations	*s_op;=0A=
 	struct dquot_operations	*dq_op;=0A=
+	struct nfsd_operations	*s_nfsd_op;=0A=
 	unsigned long		s_flags;=0A=
 	unsigned long		s_magic;=0A=
 	struct dentry		*s_root;=0A=
@@ -696,15 +697,6 @@=0A=
 	 * even looking at it. You had been warned.=0A=
 	 */=0A=
 	struct semaphore s_vfs_rename_sem;	/* Kludge */=0A=
-=0A=
-	/* The next field is used by knfsd when converting a (inode number =
based)=0A=
-	 * file handle into a dentry. As it builds a path in the dcache tree =
from=0A=
-	 * the bottom up, there may for a time be a subpath of dentrys which =
is not=0A=
-	 * connected to the main tree.  This semaphore ensure that there is =
only ever=0A=
-	 * one such free path per filesystem.  Note that unconnected files =
(or other=0A=
-	 * non-directories) are allowed, but not unconnected diretories.=0A=
-	 */=0A=
-	struct semaphore s_nfsd_free_path_sem;=0A=
 };=0A=
 =0A=
 /*=0A=
diff -rubB linux-2.4.4.orig/include/linux/nfsd/interface.h =
linux-2.4.4-knfsd/include/linux/nfsd/interface.h=0A=
--- linux-2.4.4.orig/include/linux/nfsd/interface.h	Mon Apr 30 14:28:34 =
2001=0A=
+++ linux-2.4.4-knfsd/include/linux/nfsd/interface.h	Mon Apr 30 =
15:13:43 2001=0A=
@@ -12,12 +12,151 @@=0A=
 =0A=
 #include <linux/config.h>=0A=
 =0A=
+/**=0A=
+ * &nfsd_operations - for nfsd to communicate with file systems=0A=
+ * decode_fh:      decode a file handle fragment and return a &struct =
dentry=0A=
+ * encode_fh:      encode a file handle fragment from a dentry=0A=
+ * get_name:       find the name for a given inode in a given =
directory=0A=
+ * get_parent:     find the parent of a given directory=0A=
+ * get_dentry:     find a dentry for the inode given a file handle =
sub-fragment=0A=
+ *=0A=
+ * Description:=0A=
+ *    The nfsd_operations structure provides a means for nfsd to =
communicate=0A=
+ *    with a particular exported file system  - particularly enabling =
nfsd and=0A=
+ *    the filesystem to co-operate when dealing with file handles.=0A=
+ *=0A=
+ *    nfsd_operations contains two basic operation for dealing with =
file handles,=0A=
+ *    decode_fh() and encode_fh(), and allows for some other =
operations to be defined=0A=
+ *    which standard helper routines use to get specific information =
from the=0A=
+ *    filesystem.=0A=
+ *=0A=
+ *    nfsd encodes information use to determine which filesystem a =
filehandle=0A=
+ *    applies to in the initial part of the file handle.  The =
remainder, termed a=0A=
+ *    file handle fragment, is controlled completely by the =
filesystem.=0A=
+ *    The standard helper routines assume that this fragment will =
contain one or two=0A=
+ *    sub-fragments, one which identifies the file, and one which may =
be used to=0A=
+ *    identify the (a) directory containing the file.=0A=
+ *=0A=
+ *    In some situations, nfsd needs to get a dentry which is =
connected into a=0A=
+ *    specific part of the file tree.  To allow for this, it passes =
the function=0A=
+ *    acceptable() together with a @context which can be used to see =
if the dentry=0A=
+ *    is acceptable.  As there can be multiple dentrys for a given =
file, the filesystem=0A=
+ *    should check each one for acceptability before looking for the =
next.  As soon=0A=
+ *    as an acceptable one is found, it should be returned.=0A=
+ *=0A=
+ * decode_fh:=0A=
+ *    @decode_fh is given a &struct super_block (@sb), a file handle =
fragment (@fh, @fh_len)=0A=
+ *    and an acceptability testing function (@acceptable, @context).  =
It should return=0A=
+ *    a &struct dentry which refers to the same file that the file =
handle fragment refers=0A=
+ *    to,  and which passes the acceptability test.  If it cannot, it =
should return=0A=
+ *    a %NULL pointer if the file was found but no acceptable =
&dentries were available, or=0A=
+ *    a %ERR_PTR error code indicating why it couldn't be found (e.g. =
%ENOENT or %ENOMEM).=0A=
+ *=0A=
+ * encode_fh:=0A=
+ *    @encode_fh should store in the file handle fragment @fh (using =
at most @max_len bytes)=0A=
+ *    information that can be used by @decode_fh to recover the file =
refered to by the=0A=
+ *    &struct dentry @de.  If the @connectable flag is set, the =
encode_fh() should store=0A=
+ *    sufficient information so that a good attempt can be made to =
find not only=0A=
+ *    the file but also it's place in the filesystem.   This typically =
means storing=0A=
+ *    a reference to de->d_parent in the filehandle fragment.=0A=
+ *    encode_fh() should return the number of bytes stored or a =
negative error code=0A=
+ *    such as %-ENOSPC=0A=
+ *=0A=
+ * get_name:=0A=
+ *    @get_name should find a name for the given @child in the given =
@parent directory.=0A=
+ *    The name should be stored in the @name (with the understanding =
that it is already=0A=
+ *    pointing to a a %NAME_MAX+1 sized buffer.   get_name() should =
return %0 on success,=0A=
+ *    a negative error code.=0A=
+ *    @get_name will be called without @parent->i_sem held.=0A=
+ *=0A=
+ * get_parent:=0A=
+ *    @get_parent should find the parent directory for the given =
@child which is also=0A=
+ *    a directory.  In the event that it cannot be found, or storage =
space cannot be=0A=
+ *    allocated, a %ERR_PTR should be returned.=0A=
+ *=0A=
+ * get_dentry:=0A=
+ *    Given a &super_block (@sb) and a pointer to a file-system =
specific inode identifier,=0A=
+ *    possibly an inode number, (@inump) get_dentry() should find the =
identified inode and=0A=
+ *    return a dentry for that inode.=0A=
+ *    Any suitable dentry can be returned including, if necessary, a =
new dentry created=0A=
+ *    with d_alloc_root.  The caller can then find any other extant =
dentrys by following the=0A=
+ *    d_alias links.  If a new dentry was created using d_alloc_root, =
DCACHE_NFSD_DISCONNECTED=0A=
+ *    should be set, and the dentry should be d_rehash()ed.=0A=
+ *=0A=
+ *    If the inode cannot be found, either a %NULL pointer or an =
%ERR_PTR code can be returned.=0A=
+ *    The @inump will be whatever was passed to nfsd_find_fh_dentry() =
in either the=0A=
+ *    @obj or @parent parameters.=0A=
+ */=0A=
+=0A=
+struct nfsd_operations {=0A=
+	struct dentry *(*decode_fh)(struct super_block *sb, char *fh, int =
fh_len,=0A=
+			 int (*acceptable)(void *context, struct dentry *de),=0A=
+			 void *context);=0A=
+	int (*encode_fh)(struct dentry *de, char *fh, int max_len,=0A=
+			 int connectable);=0A=
+=0A=
+	/* the following are only called from the filesystem itself */=0A=
+	int (*get_name)(struct dentry *parent, char *name,=0A=
+			struct dentry *child);=0A=
+	struct dentry * (*get_parent)(struct dentry *child);=0A=
+	struct dentry * (*get_dentry)(struct super_block *sb, void =
*inump);=0A=
+=0A=
+};=0A=
+=0A=
+=0A=
+=0A=
+/**=0A=
+ * &nfsd_linkage - structure for nfsd to register it's presence=0A=
+ * do_nfsservctl:  handler for sys_nfsservctl syscall=0A=
+ * find_fh_dentry: helper for finding dentry from filehandle=0A=
+ *=0A=
+ * When nfsd is compiled as a module, it registers it's presence=0A=
+ * by setting the global variable $nfsd_linkage to be a pointer to=0A=
+ * an appropriate &struct nfsd_linkage.  This currently has two =
fields.=0A=
+ *=0A=
+ * @do_nfsservctl should contain a pointer to the implementation of=0A=
+ * the sy_nfsservctl system call.=0A=
+ *=0A=
+ * @find_fh_dentry is a helper function that filesystems may use=0A=
+ * to help convert a filehandle into a &dentry.  It inturn calls =
the=0A=
+ * private entry points in the &nfsd_operations structure: =
get_name,=0A=
+ * get_parent and get_inode.=0A=
+ *=0A=
+ * When nfsd is compiled in the the kernel, or not included at all,=0A=
+ * this structure is not used and the linkage to these routines is=0A=
+ * more direct.=0A=
+ **/=0A=
+=0A=
+struct dentry * nfsd_find_fh_dentry(struct super_block *sb, void *obj, =
void *parent,=0A=
+				    int (*acceptable)(void *context, struct dentry *de),=0A=
+				    void *context);=0A=
+=0A=
+=0A=
+=0A=
+=0A=
 #ifdef CONFIG_NFSD_MODULE=0A=
 =0A=
 extern struct nfsd_linkage {=0A=
 	long (*do_nfsservctl)(int cmd, void *argp, void *resp);=0A=
+    	struct dentry * (*find_fh_dentry)(struct super_block *sb, void =
*obj, void *parent,=0A=
+					  int (*acceptable)(void *context, struct dentry *de),=0A=
+					  void *context);=0A=
 } * nfsd_linkage;=0A=
 =0A=
+/* filesystems that include this will get to use the linkage point=0A=
+ * if knfsd is a module.  nfsd/?*.c will need to #undef this if they =
want=0A=
+ * to use it.=0A=
+ */=0A=
+# define nfsd_find_fh_dentry (nfsd_linkage->find_fh_dentry)=0A=
+=0A=
+#else=0A=
+# ifndef CONFIG_NFSD=0A=
+#  define nfsd_find_fh_dentry(a,b,c,d,e) *((char*)0)=3D0=0A=
+/* filesystems can use "#ifndef NO_CONFIG_NFSD" to exclude code that =
is only needed=0A=
+ * by knfsd=0A=
+ */=0A=
+#  define NO_CONFIG_NFSD=0A=
+# endif=0A=
 #endif=0A=
 =0A=
 #endif /* LINUX_NFSD_INTERFACE_H */=0A=
diff -rubB linux-2.4.4.orig/include/linux/reiserfs_fs.h =
linux-2.4.4-knfsd/include/linux/reiserfs_fs.h=0A=
--- linux-2.4.4.orig/include/linux/reiserfs_fs.h	Mon Apr 30 14:55:14 =
2001=0A=
+++ linux-2.4.4-knfsd/include/linux/reiserfs_fs.h	Mon Apr 30 15:13:43 =
2001=0A=
@@ -65,6 +65,8 @@=0A=
 /* enable journalling */=0A=
 #define ENABLE_JOURNAL=0A=
 =0A=
+#define USE_INODE_GENERATION_COUNTER=0A=
+=0A=
 #ifdef __KERNEL__=0A=
 =0A=
 /* #define REISERFS_CHECK */=0A=
@@ -708,6 +710,7 @@=0A=
     __u32 sd_blocks;=0A=
     union {=0A=
 	__u32 sd_rdev;=0A=
+	__u32 sd_generation;=0A=
       //__u32 sd_first_direct_byte; =0A=
       /* first byte of file which is stored in a=0A=
 				       direct item: except that if it equals 1=0A=
diff -rubB linux-2.4.4.orig/include/linux/reiserfs_fs_sb.h =
linux-2.4.4-knfsd/include/linux/reiserfs_fs_sb.h=0A=
--- linux-2.4.4.orig/include/linux/reiserfs_fs_sb.h	Mon Apr 30 14:55:14 =
2001=0A=
+++ linux-2.4.4-knfsd/include/linux/reiserfs_fs_sb.h	Mon Apr 30 =
15:13:43 2001=0A=
@@ -60,7 +60,8 @@=0A=
                                    don't need to save bytes in the=0A=
                                    superblock. -Hans */=0A=
   __u16 s_reserved;=0A=
-  char s_unused[128] ;			/* zero filled by mkreiserfs */=0A=
+  __u32 s_inode_generation;=0A=
+  char s_unused[124] ;			/* zero filled by mkreiserfs */=0A=
 } __attribute__ ((__packed__));=0A=
 =0A=
 #define SB_SIZE (sizeof(struct reiserfs_super_block))=0A=
diff -rubB linux-2.4.4.orig/kernel/ksyms.c =
linux-2.4.4-knfsd/kernel/ksyms.c=0A=
--- linux-2.4.4.orig/kernel/ksyms.c	Mon Apr 30 14:55:14 2001=0A=
+++ linux-2.4.4-knfsd/kernel/ksyms.c	Mon Apr 30 15:13:43 2001=0A=
@@ -157,6 +157,8 @@=0A=
 EXPORT_SYMBOL(d_rehash);=0A=
 EXPORT_SYMBOL(d_invalidate);	/* May be it will be better in dcache.h? =
*/=0A=
 EXPORT_SYMBOL(d_move);=0A=
+EXPORT_SYMBOL(d_splice_alias);=0A=
+EXPORT_SYMBOL(d_make_alias);=0A=
 EXPORT_SYMBOL(d_instantiate);=0A=
 EXPORT_SYMBOL(d_alloc);=0A=
 EXPORT_SYMBOL(d_lookup);=0A=

------_=_NextPart_000_01C124D2.781C57A0--
