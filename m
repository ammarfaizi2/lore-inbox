Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSGEEaj>; Fri, 5 Jul 2002 00:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315285AbSGEEaj>; Fri, 5 Jul 2002 00:30:39 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:33512 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315279AbSGEEad>;
	Fri, 5 Jul 2002 00:30:33 -0400
Date: Fri, 5 Jul 2002 00:33:07 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] devpts cleanup
Message-ID: <Pine.GSO.4.21.0207050016580.14718-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	OK, this area isn't affected by any patches in BK tree, so
that patch should be mergable as it is.

	* devpts "upcalls" eliminated.
	* instead of playing games with revalidation we simply use
ramfs-style tree and kill dentries upon devpts_pty_kill().  That
allows to get rid of a lot of code in fs/devpts/*.c.
	* devpts_fs.h cleaned up.
	* devpts/root.c and devpts/devpts_i.h removed.
	* array of pointers to devpts inodes killed; with ramfs-style tree
it's not needed anymore.
	* devpts/inode.c cleaned up.
	* devpts_pty_new() used to get mk_kdev() only to convert it to
dev_t (hardly a surprise, since it's mknod() in disguise).  Now it gets
dev_t as an argument.

diff -urN C24-a/drivers/char/pty.c C24-a-devpts/drivers/char/pty.c
--- C24-a/drivers/char/pty.c	Sun Jan 20 10:21:53 2002
+++ C24-a-devpts/drivers/char/pty.c	Fri Jul  5 00:01:50 2002
@@ -25,8 +25,6 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/bitops.h>
-
-#define BUILDING_PTY_C 1
 #include <linux/devpts_fs.h>
 
 struct pty_struct {
diff -urN C24-a/drivers/char/tty_io.c C24-a-devpts/drivers/char/tty_io.c
--- C24-a/drivers/char/tty_io.c	Sun Jun  9 23:03:54 2002
+++ C24-a-devpts/drivers/char/tty_io.c	Fri Jul  5 00:01:50 2002
@@ -1336,7 +1336,7 @@
 	ptmx_found:
 		set_bit(TTY_PTY_LOCK, &tty->flags); /* LOCK THE SLAVE */
 		minor -= driver->minor_start;
-		devpts_pty_new(driver->other->name_base + minor, mk_kdev(driver->other->major, minor + driver->other->minor_start));
+		devpts_pty_new(driver->other->name_base + minor, MKDEV(driver->other->major, minor + driver->other->minor_start));
 		tty_register_devfs(&pts_driver[major], DEVFS_FL_DEFAULT,
 				   pts_driver[major].minor_start + minor);
 		noctty = 1;
diff -urN C24-a/fs/Makefile C24-a-devpts/fs/Makefile
--- C24-a/fs/Makefile	Thu Jun 20 13:37:04 2002
+++ C24-a-devpts/fs/Makefile	Fri Jul  5 00:01:50 2002
@@ -40,6 +40,7 @@
 obj-$(CONFIG_PROC_FS)		+= proc/
 obj-y				+= partitions/
 obj-y				+= driverfs/
+obj-y				+= devpts/
 
 # Do not add any filesystems before this line
 obj-$(CONFIG_EXT3_FS)		+= ext3/ # Before ext2 so root fs can be ext3
@@ -81,7 +82,6 @@
 obj-$(CONFIG_AUTOFS4_FS)	+= autofs4/
 obj-$(CONFIG_ADFS_FS)		+= adfs/
 obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
-obj-$(CONFIG_DEVPTS_FS)		+= devpts/
 obj-$(CONFIG_SUN_OPENPROMFS)	+= openpromfs/
 obj-$(CONFIG_JFS_FS)		+= jfs/
 
diff -urN C24-a/fs/devpts/Makefile C24-a-devpts/fs/devpts/Makefile
--- C24-a/fs/devpts/Makefile	Sat May 25 01:40:57 2002
+++ C24-a-devpts/fs/devpts/Makefile	Fri Jul  5 00:01:50 2002
@@ -4,6 +4,6 @@
 
 obj-$(CONFIG_DEVPTS_FS) += devpts.o
 
-devpts-objs := root.o inode.o
+devpts-objs := inode.o
 
 include $(TOPDIR)/Rules.make
diff -urN C24-a/fs/devpts/devpts_i.h C24-a-devpts/fs/devpts/devpts_i.h
--- C24-a/fs/devpts/devpts_i.h	Thu Nov 29 03:00:49 2001
+++ C24-a-devpts/fs/devpts/devpts_i.h	Wed Dec 31 19:00:00 1969
@@ -1,41 +0,0 @@
-/* -*- linux-c -*- --------------------------------------------------------- *
- *
- * linux/fs/devpts/devpts_i.h
- *
- *  Copyright 1998 H. Peter Anvin -- All Rights Reserved
- *
- * This file is part of the Linux kernel and is made available under
- * the terms of the GNU General Public License, version 2, or at your
- * option, any later version, incorporated herein by reference.
- *
- * ------------------------------------------------------------------------- */
-
-#include <linux/fs.h>
-#include <linux/tty.h>
-#include <linux/types.h>
-
-#define BUILDING_DEVPTS 1
-#include <linux/devpts_fs.h>
-
-struct devpts_sb_info {
-	u32 magic;
-	int setuid;
-	int setgid;
-	uid_t   uid;
-	gid_t   gid;
-	umode_t mode;
-
-	unsigned int max_ptys;
-	struct inode **inodes;
-};
-
-#define DEVPTS_SUPER_MAGIC 0x1cd1
-#define DEVPTS_SBI_MAGIC   0x01da1d02
-
-extern inline struct devpts_sb_info *SBI(struct super_block *sb)
-{
-	return (struct devpts_sb_info *)(sb->u.generic_sbp);
-}
-
-extern struct inode_operations devpts_root_inode_operations;
-extern struct file_operations devpts_root_operations;
diff -urN C24-a/fs/devpts/inode.c C24-a-devpts/fs/devpts/inode.c
--- C24-a/fs/devpts/inode.c	Tue May 21 20:53:41 2002
+++ C24-a-devpts/fs/devpts/inode.c	Fri Jul  5 00:02:21 2002
@@ -11,135 +11,70 @@
  * ------------------------------------------------------------------------- */
 
 #include <linux/module.h>
-
-#include <linux/string.h>
-#include <linux/fs.h>
 #include <linux/init.h>
-#include <linux/kdev_t.h>
-#include <linux/kernel.h>
-#include <linux/major.h>
-#include <linux/slab.h>
-#include <linux/stat.h>
-#include <linux/tty.h>
-#include <asm/bitops.h>
-#include <asm/uaccess.h>
+#include <linux/fs.h>
+#include <linux/sched.h>
+#include <linux/namei.h>
 
-#include "devpts_i.h"
+#define DEVPTS_SUPER_MAGIC 0x1cd1
 
 static struct vfsmount *devpts_mnt;
+static struct dentry *devpts_root;
 
-static void devpts_put_super(struct super_block *sb)
-{
-	struct devpts_sb_info *sbi = SBI(sb);
-	struct inode *inode;
-	int i;
-
-	for ( i = 0 ; i < sbi->max_ptys ; i++ ) {
-		if ( (inode = sbi->inodes[i]) ) {
-			if ( atomic_read(&inode->i_count) != 1 )
-				printk("devpts_put_super: badness: entry %d count %d\n",
-				       i, atomic_read(&inode->i_count));
-			inode->i_nlink--;
-			iput(inode);
-		}
-	}
-	kfree(sbi->inodes);
-	kfree(sbi);
-}
-
-static int devpts_remount (struct super_block * sb, int * flags, char * data);
-
-static struct super_operations devpts_sops = {
-	put_super:	devpts_put_super,
-	statfs:		simple_statfs,
-	remount_fs:	devpts_remount,
-};
+static struct {
+	int setuid;
+	int setgid;
+	uid_t   uid;
+	gid_t   gid;
+	umode_t mode;
+} config = {mode: 0600};
 
-static int devpts_parse_options(char *options, struct devpts_sb_info *sbi)
+static int devpts_remount(struct super_block *sb, int *flags, char *data)
 {
 	int setuid = 0;
 	int setgid = 0;
 	uid_t uid = 0;
 	gid_t gid = 0;
 	umode_t mode = 0600;
-	char *this_char, *value;
+	char *this_char;
 
 	this_char = NULL;
-	while ((this_char = strsep(&options, ",")) != NULL) {
+	while ((this_char = strsep(&data, ",")) != NULL) {
+		int n;
+		char dummy;
 		if (!*this_char)
 			continue;
-		if ((value = strchr(this_char,'=')) != NULL)
-			*value++ = 0;
-		if (!strcmp(this_char,"uid")) {
-			if (!value || !*value)
-				return 1;
-			uid = simple_strtoul(value,&value,0);
-			if (*value)
-				return 1;
+		if (sscanf(this_char, "uid=%i%c", &n, &dummy) == 1) {
 			setuid = 1;
-		}
-		else if (!strcmp(this_char,"gid")) {
-			if (!value || !*value)
-				return 1;
-			gid = simple_strtoul(value,&value,0);
-			if (*value)
-				return 1;
+			uid = n;
+		} else if (sscanf(this_char, "gid=%i%c", &n, &dummy) == 1) {
 			setgid = 1;
+			gid = n;
+		} else if (sscanf(this_char, "mode=%o%c", &n, &dummy) == 1)
+			mode = n & ~S_IFMT;
+		else {
+			printk("devpts: called with bogus options\n");
+			return -EINVAL;
 		}
-		else if (!strcmp(this_char,"mode")) {
-			if (!value || !*value)
-				return 1;
-			mode = simple_strtoul(value,&value,8);
-			if (*value)
-				return 1;
-		}
-		else
-			return 1;
 	}
-	sbi->setuid  = setuid;
-	sbi->setgid  = setgid;
-	sbi->uid     = uid;
-	sbi->gid     = gid;
-	sbi->mode    = mode & ~S_IFMT;
+	config.setuid  = setuid;
+	config.setgid  = setgid;
+	config.uid     = uid;
+	config.gid     = gid;
+	config.mode    = mode;
 
 	return 0;
 }
 
-static int devpts_remount(struct super_block * sb, int * flags, char * data)
-{
-	struct devpts_sb_info *sbi = sb->u.generic_sbp;
-	int res = devpts_parse_options(data,sbi);
-	if (res) {
-		printk("devpts: called with bogus options\n");
-		return -EINVAL;
-	}
-	return 0;
-}
+static struct super_operations devpts_sops = {
+	statfs:		simple_statfs,
+	remount_fs:	devpts_remount,
+};
 
 static int devpts_fill_super(struct super_block *s, void *data, int silent)
 {
-	int error = -ENOMEM;
 	struct inode * inode;
-	struct devpts_sb_info *sbi;
-
-	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
-	if ( !sbi )
-		goto fail;
-	memset(sbi, 0, sizeof(*sbi));
 
-	sbi->magic  = DEVPTS_SBI_MAGIC;
-	sbi->max_ptys = unix98_max_ptys;
-	sbi->inodes = kmalloc(sizeof(struct inode *) * sbi->max_ptys, GFP_KERNEL);
-	if ( !sbi->inodes )
-		goto fail_free;
-	memset(sbi->inodes, 0, sizeof(struct inode *) * sbi->max_ptys);
-
-	if ( devpts_parse_options(data,sbi) && !silent) {
-		error = -EINVAL;
-		printk("devpts: called with bogus options\n");
-		goto fail_free;
-	}
-	s->u.generic_sbp = (void *) sbi;
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
 	s->s_magic = DEVPTS_SUPER_MAGIC;
@@ -147,27 +82,25 @@
 
 	inode = new_inode(s);
 	if (!inode)
-		goto fail_free;
+		goto fail;
 	inode->i_ino = 1;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_blocks = 0;
 	inode->i_blksize = 1024;
 	inode->i_uid = inode->i_gid = 0;
 	inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO | S_IWUSR;
-	inode->i_op = &devpts_root_inode_operations;
-	inode->i_fop = &devpts_root_operations;
+	inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
 	inode->i_nlink = 2;
 
-	s->s_root = d_alloc_root(inode);
+	devpts_root = s->s_root = d_alloc_root(inode);
 	if (s->s_root)
 		return 0;
 	
 	printk("devpts: get root dentry failed\n");
 	iput(inode);
-fail_free:
-	kfree(sbi);
 fail:
-	return error;
+	return -ENOMEM;
 }
 
 static struct super_block *devpts_get_sb(struct file_system_type *fs_type,
@@ -183,44 +116,52 @@
 	kill_sb:	kill_anon_super,
 };
 
-void devpts_pty_new(int number, kdev_t device)
+/*
+ * The normal naming convention is simply /dev/pts/<number>; this conforms
+ * to the System V naming convention
+ */
+
+static struct dentry *get_node(int num)
+{
+	char s[10];
+	struct dentry *root = devpts_root;
+	down(&root->d_inode->i_sem);
+	return lookup_one_len(s, root, sprintf(s, "%d", num));
+}
+
+void devpts_pty_new(int number, dev_t device)
 {
-	struct super_block *sb = devpts_mnt->mnt_sb;
-	struct devpts_sb_info *sbi = SBI(sb);
-	struct inode *inode;
-		
-	if ( sbi->inodes[number] )
-		return; /* Already registered, this does happen */
-		
-	inode = new_inode(sb);
+	struct dentry *dentry;
+	struct inode *inode = new_inode(devpts_mnt->mnt_sb);
 	if (!inode)
 		return;
 	inode->i_ino = number+2;
-	inode->i_blocks = 0;
 	inode->i_blksize = 1024;
-	inode->i_uid = sbi->setuid ? sbi->uid : current->fsuid;
-	inode->i_gid = sbi->setgid ? sbi->gid : current->fsgid;
+	inode->i_uid = config.setuid ? config.uid : current->fsuid;
+	inode->i_gid = config.setgid ? config.gid : current->fsgid;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-	init_special_inode(inode, S_IFCHR|sbi->mode, kdev_t_to_nr(device));
+	init_special_inode(inode, S_IFCHR|config.mode, device);
 
-	if ( sbi->inodes[number] ) {
-		iput(inode);
-		return;
-	}
-	sbi->inodes[number] = inode;
+	dentry = get_node(number);
+	if (!IS_ERR(dentry) && !dentry->d_inode)
+		d_instantiate(dentry, inode);
+	up(&devpts_root->d_inode->i_sem);
 }
 
 void devpts_pty_kill(int number)
 {
-	struct super_block *sb = devpts_mnt->mnt_sb;
-	struct devpts_sb_info *sbi = SBI(sb);
-	struct inode *inode = sbi->inodes[number];
-
-	if ( inode ) {
-		sbi->inodes[number] = NULL;
-		inode->i_nlink--;
-		iput(inode);
+	struct dentry *dentry = get_node(number);
+
+	if (!IS_ERR(dentry)) {
+		struct inode *inode = dentry->d_inode;
+		if (inode) {
+			inode->i_nlink--;
+			d_delete(dentry);
+			dput(dentry);
+		}
+		dput(dentry);
 	}
+	up(&devpts_root->d_inode->i_sem);
 }
 
 static int __init init_devpts_fs(void)
@@ -231,22 +172,12 @@
 		err = PTR_ERR(devpts_mnt);
 		if (!IS_ERR(devpts_mnt))
 			err = 0;
-#ifdef MODULE
-		if ( !err ) {
-			devpts_upcall_new  = devpts_pty_new;
-			devpts_upcall_kill = devpts_pty_kill;
-		}
-#endif
 	}
 	return err;
 }
 
 static void __exit exit_devpts_fs(void)
 {
-#ifdef MODULE
-	devpts_upcall_new  = NULL;
-	devpts_upcall_kill = NULL;
-#endif
 	unregister_filesystem(&devpts_fs_type);
 	kern_umount(devpts_mnt);
 }
@@ -254,4 +185,3 @@
 module_init(init_devpts_fs)
 module_exit(exit_devpts_fs)
 MODULE_LICENSE("GPL");
-
diff -urN C24-a/fs/devpts/root.c C24-a-devpts/fs/devpts/root.c
--- C24-a/fs/devpts/root.c	Tue Apr 30 20:26:58 2002
+++ C24-a-devpts/fs/devpts/root.c	Wed Dec 31 19:00:00 1969
@@ -1,142 +0,0 @@
-/* -*- linux-c -*- --------------------------------------------------------- *
- *
- * linux/fs/devpts/root.c
- *
- *  Copyright 1998 H. Peter Anvin -- All Rights Reserved
- *
- * This file is part of the Linux kernel and is made available under
- * the terms of the GNU General Public License, version 2, or at your
- * option, any later version, incorporated herein by reference.
- *
- * ------------------------------------------------------------------------- */
-
-#include <linux/errno.h>
-#include <linux/stat.h>
-#include <linux/param.h>
-#include <linux/string.h>
-#include <linux/smp_lock.h>
-#include "devpts_i.h"
-
-static int devpts_root_readdir(struct file *,void *,filldir_t);
-static struct dentry *devpts_root_lookup(struct inode *,struct dentry *);
-static int devpts_revalidate(struct dentry *, int);
-
-struct file_operations devpts_root_operations = {
-	read:		generic_read_dir,
-	readdir:	devpts_root_readdir,
-};
-
-struct inode_operations devpts_root_inode_operations = {
-	lookup:		devpts_root_lookup,
-};
-
-static struct dentry_operations devpts_dentry_operations = {
-	d_revalidate:	devpts_revalidate,
-};
-
-/*
- * The normal naming convention is simply /dev/pts/<number>; this conforms
- * to the System V naming convention
- */
-
-#define genptsname(buf,num) sprintf(buf, "%d", num)
-
-static int devpts_root_readdir(struct file *filp, void *dirent, filldir_t filldir)
-{
-	struct inode * inode = filp->f_dentry->d_inode;
-	struct devpts_sb_info * sbi = SBI(filp->f_dentry->d_inode->i_sb);
-	off_t nr;
-	char numbuf[16];
-
-	lock_kernel();
-
-	nr = filp->f_pos;
-
-	switch(nr)
-	{
-	case 0:
-		if (filldir(dirent, ".", 1, nr, inode->i_ino, DT_DIR) < 0)
-			goto out;
-		filp->f_pos = ++nr;
-		/* fall through */
-	case 1:
-		if (filldir(dirent, "..", 2, nr, inode->i_ino, DT_DIR) < 0)
-			goto out;
-		filp->f_pos = ++nr;
-		/* fall through */
-	default:
-		while ( nr - 2 < sbi->max_ptys ) {
-			int ptynr = nr - 2;
-			if ( sbi->inodes[ptynr] ) {
-				genptsname(numbuf, ptynr);
-				if ( filldir(dirent, numbuf, strlen(numbuf), nr, nr, DT_CHR) < 0 )
-					goto out;
-			}
-			filp->f_pos = ++nr;
-		}
-		break;
-	}
-
-out:
-	unlock_kernel();
-	return 0;
-}
-
-/*
- * Revalidate is called on every cache lookup.  We use it to check that
- * the pty really does still exist.  Never revalidate negative dentries;
- * for simplicity (fix later?)
- */
-static int devpts_revalidate(struct dentry * dentry, int flags)
-{
-	struct devpts_sb_info *sbi;
-
-	if ( !dentry->d_inode )
-		return 0;
-
-	sbi = SBI(dentry->d_inode->i_sb);
-
-	return ( sbi->inodes[dentry->d_inode->i_ino - 2] == dentry->d_inode );
-}
-
-static struct dentry *devpts_root_lookup(struct inode * dir, struct dentry * dentry)
-{
-	struct devpts_sb_info *sbi = SBI(dir->i_sb);
-	unsigned int entry;
-	int i;
-	const char *p;
-
-	dentry->d_op    = &devpts_dentry_operations;
-
-	if ( dentry->d_name.len == 1 && dentry->d_name.name[0] == '0' ) {
-		entry = 0;
-	} else if ( dentry->d_name.len < 1 ) {
-		return NULL;
-	} else {
-		p = dentry->d_name.name;
-		if ( *p < '1' || *p > '9' )
-			return NULL;
-		entry = *p++ - '0';
-
-		for ( i = dentry->d_name.len-1 ; i ; i-- ) {
-			unsigned int nentry = *p++ - '0';
-			if ( nentry > 9 )
-				return NULL;
-			if ( entry >= ~0U/10 )
-				return NULL;
-			entry = nentry + entry * 10;
-		}
-	}
-
-	if ( entry >= sbi->max_ptys )
-		return NULL;
-
-	lock_kernel();
-	if ( sbi->inodes[entry] )
-		atomic_inc(&sbi->inodes[entry]->i_count);
-	
-	d_add(dentry, sbi->inodes[entry]);
-	unlock_kernel();
-
-	return NULL;
-}
diff -urN C24-a/include/linux/devpts_fs.h C24-a-devpts/include/linux/devpts_fs.h
--- C24-a/include/linux/devpts_fs.h	Mon May 27 14:55:03 2002
+++ C24-a-devpts/include/linux/devpts_fs.h	Fri Jul  5 00:01:50 2002
@@ -10,64 +10,23 @@
  *
  * ------------------------------------------------------------------------- */
 
-/*
- * Prototypes for the pty driver <-> devpts filesystem interface.  Most
- * of this is really just a hack so we can exclude it or build it as a
- * module, and probably should go away eventually.
- */
-
 #ifndef _LINUX_DEVPTS_FS_H
 #define _LINUX_DEVPTS_FS_H 1
 
-#include <linux/config.h>
-#include <linux/kdev_t.h>
-#include <linux/tty.h>
-
 #ifdef CONFIG_DEVPTS_FS
 
-void devpts_pty_new(int, kdev_t);
-void devpts_pty_kill(int);
-#define unix98_max_ptys               NR_PTYS * UNIX98_NR_MAJORS;
-
-#elif defined(CONFIG_DEVPTS_FS_MODULE)
-
-#ifdef BUILDING_PTY_C
-void (*devpts_upcall_new)(int,kdev_t) = NULL;
-void (*devpts_upcall_kill)(int)       = NULL;
-unsigned int unix98_max_ptys          = NR_PTYS * UNIX98_NR_MAJORS;
+void devpts_pty_new(int, dev_t);	/* mknod in devpts */
+void devpts_pty_kill(int);		/* unlink */
 
-EXPORT_SYMBOL(devpts_upcall_new);
-EXPORT_SYMBOL(devpts_upcall_kill);
-EXPORT_SYMBOL(unix98_max_ptys);
 #else
-extern void (*devpts_upcall_new)(int,kdev_t);
-extern void (*devpts_upcall_kill)(int);
-extern unsigned int unix98_max_ptys;
-#endif
 
-#ifndef BUILDING_DEVPTS
-static inline void
-devpts_pty_new(int line, kdev_t device)
+static inline void devpts_pty_new(int line, dev_t device)
 {
-	if ( devpts_upcall_new )
-		return devpts_upcall_new(line,device);
 }
 
-static inline void
-devpts_pty_kill(int line)
+static inline void devpts_pty_kill(int line)
 {
-	if ( devpts_upcall_kill )
-		return devpts_upcall_kill(line);
 }
-#endif
-
-#else  /* No /dev/pts filesystem at all */
-
-static inline void
-devpts_pty_new(int line, kdev_t device) { }
-
-static inline void
-devpts_pty_kill(int line) { }
 
 #endif
 

