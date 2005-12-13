Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbVLMR4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbVLMR4u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 12:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVLMR4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 12:56:50 -0500
Received: from verein.lst.de ([213.95.11.210]:37075 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932172AbVLMR4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 12:56:49 -0500
Date: Tue, 13 Dec 2005 18:56:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] introduce FS_NOATIME and FS_NODIRATIME flags
Message-ID: <20051213175642.GC17130@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3.849 () BAYES_00,DOMAIN_BODY
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various filesystems always want noatime or nodiratime semantics because
their disk format doesn't support it or the server takes care of it for
network filesystems.  Currently they always set
MS_NOATIME/MS_NODIRATIME, which is duplicate code because it needs to
be done in fill_super and remount (which various filesystems wouldn't
need at all otherwise) and dangerous because various filesystems forget
to handle the remount case.  Also it's not doable for the per-mount
noatime case because the filesystems don't have access to the vfsmount
flags.

This patch introduces file_system_type flags instead to handle this
easier and allow the per-mount noatime transition.  We could add
mnt_flags and s_flags memembers to file_system_type instead, but as long
as we have very little such flags (the only other I could image would
be FS_RDONLY) I'll keep it simple for now.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6.15-rc5/fs/9p/vfs_super.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/9p/vfs_super.c	2005-12-13 11:11:53.000000000 +0100
+++ linux-2.6.15-rc5/fs/9p/vfs_super.c	2005-12-13 11:12:23.000000000 +0100
@@ -91,8 +91,7 @@
 	sb->s_magic = V9FS_MAGIC;
 	sb->s_op = &v9fs_super_ops;
 
-	sb->s_flags = flags | MS_ACTIVE | MS_SYNCHRONOUS | MS_DIRSYNC |
-	    MS_NOATIME;
+	sb->s_flags = flags | MS_ACTIVE | MS_SYNCHRONOUS | MS_DIRSYNC;
 }
 
 /**
@@ -259,6 +258,7 @@
 
 struct file_system_type v9fs_fs_type = {
 	.name = "9P",
+	.fs_flags = FS_NOATIME,
 	.get_sb = v9fs_get_sb,
 	.kill_sb = v9fs_kill_super,
 	.owner = THIS_MODULE,
Index: linux-2.6.15-rc5/include/linux/fs.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/fs.h	2005-12-13 11:11:59.000000000 +0100
+++ linux-2.6.15-rc5/include/linux/fs.h	2005-12-13 11:12:05.000000000 +0100
@@ -82,6 +82,8 @@
 /* public flags for file_system_type */
 #define FS_REQUIRES_DEV 1 
 #define FS_BINARY_MOUNTDATA 2
+#define FS_NOATIME	4
+#define FS_NODIRATIME	8
 #define FS_REVAL_DOT	16384	/* Check the paths ".", ".." for staleness */
 #define FS_ODD_RENAME	32768	/* Temporary stuff; will go away as soon
 				  * as nfs_rename() will be cleaned up
Index: linux-2.6.15-rc5/fs/adfs/super.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/adfs/super.c	2005-12-12 18:31:41.000000000 +0100
+++ linux-2.6.15-rc5/fs/adfs/super.c	2005-12-13 11:42:05.000000000 +0100
@@ -192,7 +192,6 @@
 
 static int adfs_remount(struct super_block *sb, int *flags, char *data)
 {
-	*flags |= MS_NODIRATIME;
 	return parse_options(sb, data);
 }
 
@@ -336,8 +335,6 @@
 	struct adfs_sb_info *asb;
 	struct inode *root;
 
-	sb->s_flags |= MS_NODIRATIME;
-
 	asb = kmalloc(sizeof(*asb), GFP_KERNEL);
 	if (!asb)
 		return -ENOMEM;
@@ -480,7 +477,7 @@
 	.name		= "adfs",
 	.get_sb		= adfs_get_sb,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV|FS_NODIRATIME,
 };
 
 static int __init init_adfs_fs(void)
Index: linux-2.6.15-rc5/fs/affs/super.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/affs/super.c	2005-12-12 18:31:41.000000000 +0100
+++ linux-2.6.15-rc5/fs/affs/super.c	2005-12-13 11:17:11.000000000 +0100
@@ -275,7 +275,6 @@
 
 	sb->s_magic             = AFFS_SUPER_MAGIC;
 	sb->s_op                = &affs_sops;
-	sb->s_flags |= MS_NODIRATIME;
 
 	sbi = kmalloc(sizeof(struct affs_sb_info), GFP_KERNEL);
 	if (!sbi)
@@ -483,8 +482,6 @@
 
 	pr_debug("AFFS: remount(flags=0x%x,opts=\"%s\")\n",*flags,data);
 
-	*flags |= MS_NODIRATIME;
-
 	if (!parse_options(data,&uid,&gid,&mode,&reserved,&root_block,
 	    &blocksize,&sbi->s_prefix,sbi->s_volume,&mount_flags))
 		return -EINVAL;
@@ -534,7 +531,7 @@
 	.name		= "affs",
 	.get_sb		= affs_get_sb,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV|FS_NODIRATIME,
 };
 
 static int __init init_affs_fs(void)
Index: linux-2.6.15-rc5/fs/cifs/cifsfs.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/cifs/cifsfs.c	2005-12-12 18:51:16.000000000 +0100
+++ linux-2.6.15-rc5/fs/cifs/cifsfs.c	2005-12-13 11:42:38.000000000 +0100
@@ -92,7 +92,6 @@
 	struct cifs_sb_info *cifs_sb;
 	int rc = 0;
 
-	sb->s_flags |= MS_NODIRATIME; /* and probably even noatime */
 	sb->s_fs_info = kmalloc(sizeof(struct cifs_sb_info),GFP_KERNEL);
 	cifs_sb = CIFS_SB(sb);
 	if(cifs_sb == NULL)
@@ -442,12 +441,6 @@
 }
 #endif	
 
-static int cifs_remount(struct super_block *sb, int *flags, char *data)
-{
-	*flags |= MS_NODIRATIME;
-	return 0;
-}
-
 struct super_operations cifs_super_ops = {
 	.read_inode = cifs_read_inode,
 	.put_super = cifs_put_super,
@@ -462,7 +455,6 @@
 #ifdef CONFIG_CIFS_EXPERIMENTAL
 	.umount_begin   = cifs_umount_begin,
 #endif
-	.remount_fs = cifs_remount,
 };
 
 static struct super_block *
@@ -516,9 +508,9 @@
 static struct file_system_type cifs_fs_type = {
 	.owner = THIS_MODULE,
 	.name = "cifs",
+	.fs_flags = FS_NODIRATIME,
 	.get_sb = cifs_get_sb,
 	.kill_sb = kill_anon_super,
-	/*  .fs_flags */
 };
 struct inode_operations cifs_dir_inode_ops = {
 	.create = cifs_create,
Index: linux-2.6.15-rc5/fs/coda/inode.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/coda/inode.c	2005-12-12 18:31:43.000000000 +0100
+++ linux-2.6.15-rc5/fs/coda/inode.c	2005-12-13 11:42:52.000000000 +0100
@@ -82,12 +82,6 @@
 		printk(KERN_INFO "coda_inode_cache: not all structures were freed\n");
 }
 
-static int coda_remount(struct super_block *sb, int *flags, char *data)
-{
-	*flags |= MS_NODIRATIME;
-	return 0;
-}
-
 /* exported operations */
 static struct super_operations coda_super_operations =
 {
@@ -96,7 +90,6 @@
 	.clear_inode	= coda_clear_inode,
 	.put_super	= coda_put_super,
 	.statfs		= coda_statfs,
-	.remount_fs	= coda_remount,
 };
 
 static int get_device_index(struct coda_mount_data *data)
@@ -178,7 +171,6 @@
 	sbi->sbi_vcomm = vc;
 
         sb->s_fs_info = sbi;
-	sb->s_flags |= MS_NODIRATIME; /* probably even noatime */
         sb->s_blocksize = 1024;	/* XXXXX  what do we put here?? */
         sb->s_blocksize_bits = 10;
         sb->s_magic = CODA_SUPER_MAGIC;
@@ -316,6 +308,6 @@
 	.name		= "coda",
 	.get_sb		= coda_get_sb,
 	.kill_sb	= kill_anon_super,
-	.fs_flags	= FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_BINARY_MOUNTDATA | FS_NODIRATIME,
 };
 
Index: linux-2.6.15-rc5/fs/fat/inode.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/fat/inode.c	2005-12-12 18:51:16.000000000 +0100
+++ linux-2.6.15-rc5/fs/fat/inode.c	2005-12-13 11:43:11.000000000 +0100
@@ -531,13 +531,6 @@
 		printk(KERN_INFO "fat_inode_cache: not all structures were freed\n");
 }
 
-static int fat_remount(struct super_block *sb, int *flags, char *data)
-{
-	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	*flags |= MS_NODIRATIME | (sbi->options.isvfat ? 0 : MS_NOATIME);
-	return 0;
-}
-
 static int fat_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
@@ -633,7 +626,6 @@
 	.write_super	= fat_write_super,
 	.statfs		= fat_statfs,
 	.clear_inode	= fat_clear_inode,
-	.remount_fs	= fat_remount,
 
 	.read_inode	= make_bad_inode,
 
@@ -1173,7 +1165,6 @@
 	sb->s_fs_info = sbi;
 	memset(sbi, 0, sizeof(struct msdos_sb_info));
 
-	sb->s_flags |= MS_NODIRATIME;
 	sb->s_magic = MSDOS_SUPER_MAGIC;
 	sb->s_op = &fat_sops;
 	sb->s_export_op = &fat_export_ops;
Index: linux-2.6.15-rc5/fs/hfs/super.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/hfs/super.c	2005-12-12 18:31:43.000000000 +0100
+++ linux-2.6.15-rc5/fs/hfs/super.c	2005-12-13 11:20:14.000000000 +0100
@@ -96,7 +96,6 @@
 
 static int hfs_remount(struct super_block *sb, int *flags, char *data)
 {
-	*flags |= MS_NODIRATIME;
 	if ((*flags & MS_RDONLY) == (sb->s_flags & MS_RDONLY))
 		return 0;
 	if (!(*flags & MS_RDONLY)) {
@@ -369,7 +368,6 @@
 	}
 
 	sb->s_op = &hfs_super_operations;
-	sb->s_flags |= MS_NODIRATIME;
 	init_MUTEX(&sbi->bitmap_lock);
 
 	res = hfs_mdb_get(sb);
@@ -424,7 +422,7 @@
 	.name		= "hfs",
 	.get_sb		= hfs_get_sb,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_NODIRATIME,
 };
 
 static void hfs_init_once(void *p, kmem_cache_t *cachep, unsigned long flags)
Index: linux-2.6.15-rc5/fs/hpfs/super.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/hpfs/super.c	2005-12-12 18:31:43.000000000 +0100
+++ linux-2.6.15-rc5/fs/hpfs/super.c	2005-12-13 11:13:12.000000000 +0100
@@ -392,8 +392,6 @@
 	int o;
 	struct hpfs_sb_info *sbi = hpfs_sb(s);
 	
-	*flags |= MS_NOATIME;
-	
 	uid = sbi->sb_uid; gid = sbi->sb_gid;
 	umask = 0777 & ~sbi->sb_mode;
 	lowercase = sbi->sb_lowercase; conv = sbi->sb_conv;
@@ -515,8 +513,6 @@
 		goto bail4;
 	}
 
-	s->s_flags |= MS_NOATIME;
-
 	/* Fill superblock stuff */
 	s->s_magic = HPFS_SUPER_MAGIC;
 	s->s_op = &hpfs_sops;
@@ -672,7 +668,7 @@
 	.name		= "hpfs",
 	.get_sb		= hpfs_get_sb,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_NOATIME,
 };
 
 static int __init init_hpfs_fs(void)
Index: linux-2.6.15-rc5/fs/jffs/inode-v23.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/jffs/inode-v23.c	2005-12-12 18:51:16.000000000 +0100
+++ linux-2.6.15-rc5/fs/jffs/inode-v23.c	2005-12-13 11:43:43.000000000 +0100
@@ -70,8 +70,6 @@
 	struct inode *root_inode;
 	struct jffs_control *c;
 
-	sb->s_flags |= MS_NODIRATIME;
-
 	D1(printk(KERN_NOTICE "JFFS: Trying to mount device %s.\n",
 		  sb->s_id));
 
@@ -1773,12 +1771,6 @@
 	unlock_kernel();
 }
 
-static int jffs_remount(struct super_block *sb, int *flags, char *data)
-{
-	*flags |= MS_NODIRATIME;
-	return 0;
-}
-
 static struct super_operations jffs_ops =
 {
 	.read_inode	= jffs_read_inode,
@@ -1786,7 +1778,6 @@
 	.put_super	= jffs_put_super,
 	.write_super	= jffs_write_super,
 	.statfs		= jffs_statfs,
-	.remount_fs	= jffs_remount,
 };
 
 static struct super_block *jffs_get_sb(struct file_system_type *fs_type,
@@ -1800,7 +1791,7 @@
 	.name		= "jffs",
 	.get_sb		= jffs_get_sb,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_NODIRATIME,
 };
 
 static int __init
Index: linux-2.6.15-rc5/fs/jffs2/fs.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/jffs2/fs.c	2005-12-12 18:31:44.000000000 +0100
+++ linux-2.6.15-rc5/fs/jffs2/fs.c	2005-12-13 11:13:48.000000000 +0100
@@ -359,9 +359,6 @@
 
 	if (!(*flags & MS_RDONLY))
 		jffs2_start_garbage_collect_thread(c);
-
-	*flags |= MS_NOATIME;
-
 	return 0;
 }
 
Index: linux-2.6.15-rc5/fs/jffs2/super.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/jffs2/super.c	2005-12-12 18:31:44.000000000 +0100
+++ linux-2.6.15-rc5/fs/jffs2/super.c	2005-12-13 11:13:46.000000000 +0100
@@ -150,7 +150,7 @@
 	spin_lock_init(&c->inocache_lock);
 
 	sb->s_op = &jffs2_super_operations;
-	sb->s_flags = flags | MS_NOATIME;
+	sb->s_flags = flags;
 
 	ret = jffs2_do_fill_super(sb, data, (flags&MS_VERBOSE)?1:0);
 
@@ -312,6 +312,7 @@
 static struct file_system_type jffs2_fs_type = {
 	.owner =	THIS_MODULE,
 	.name =		"jffs2",
+	.fs_flags =	FS_NOATIME,
 	.get_sb =	jffs2_get_sb,
 	.kill_sb =	jffs2_kill_sb,
 };
Index: linux-2.6.15-rc5/fs/msdos/namei.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/msdos/namei.c	2005-12-12 18:31:44.000000000 +0100
+++ linux-2.6.15-rc5/fs/msdos/namei.c	2005-12-13 11:23:30.000000000 +0100
@@ -669,7 +669,6 @@
 	if (res)
 		return res;
 
-	sb->s_flags |= MS_NOATIME;
 	sb->s_root->d_op = &msdos_dentry_operations;
 	return 0;
 }
@@ -686,7 +685,7 @@
 	.name		= "msdos",
 	.get_sb		= msdos_get_sb,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV|FS_NOATIME,
 };
 
 static int __init init_msdos_fs(void)
Index: linux-2.6.15-rc5/fs/ncpfs/inode.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/ncpfs/inode.c	2005-12-12 18:31:44.000000000 +0100
+++ linux-2.6.15-rc5/fs/ncpfs/inode.c	2005-12-13 11:44:15.000000000 +0100
@@ -85,12 +85,6 @@
 		printk(KERN_INFO "ncp_inode_cache: not all structures were freed\n");
 }
 
-static int ncp_remount(struct super_block *sb, int *flags, char* data)
-{
-	*flags |= MS_NODIRATIME;
-	return 0;
-}
-
 static struct super_operations ncp_sops =
 {
 	.alloc_inode	= ncp_alloc_inode,
@@ -99,7 +93,6 @@
 	.delete_inode	= ncp_delete_inode,
 	.put_super	= ncp_put_super,
 	.statfs		= ncp_statfs,
-	.remount_fs	= ncp_remount,
 };
 
 extern struct dentry_operations ncp_root_dentry_operations;
@@ -486,7 +479,6 @@
 	else
 		default_bufsize = 1024;
 
-	sb->s_flags |= MS_NODIRATIME;	/* probably even noatime */
 	sb->s_maxbytes = 0xFFFFFFFFU;
 	sb->s_blocksize = 1024;	/* Eh...  Is this correct? */
 	sb->s_blocksize_bits = 10;
@@ -972,6 +964,7 @@
 static struct file_system_type ncp_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "ncpfs",
+	.fs_flags	= FS_NODIRATIME,
 	.get_sb		= ncp_get_sb,
 	.kill_sb	= kill_anon_super,
 };
Index: linux-2.6.15-rc5/fs/openpromfs/inode.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/openpromfs/inode.c	2005-12-12 18:31:47.000000000 +0100
+++ linux-2.6.15-rc5/fs/openpromfs/inode.c	2005-12-13 11:44:31.000000000 +0100
@@ -1018,23 +1018,15 @@
 	}
 }
 
-static int openprom_remount(struct super_block *sb, int *flags, char *data)
-{
-	*flags |= MS_NOATIME;
-	return 0;
-}
-
 static struct super_operations openprom_sops = { 
 	.read_inode	= openprom_read_inode,
 	.statfs		= simple_statfs,
-	.remount_fs	= openprom_remount,
 };
 
 static int openprom_fill_super(struct super_block *s, void *data, int silent)
 {
 	struct inode * root_inode;
 
-	s->s_flags |= MS_NOATIME;
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
 	s->s_magic = OPENPROM_SUPER_MAGIC;
@@ -1063,6 +1055,7 @@
 static struct file_system_type openprom_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "openpromfs",
+	.fs_flags	= FS_NOATIME,
 	.get_sb		= openprom_get_sb,
 	.kill_sb	= kill_anon_super,
 };
Index: linux-2.6.15-rc5/fs/proc/inode.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/proc/inode.c	2005-12-12 18:31:47.000000000 +0100
+++ linux-2.6.15-rc5/fs/proc/inode.c	2005-12-13 11:44:46.000000000 +0100
@@ -128,12 +128,6 @@
 	return 0;
 }
 
-static int proc_remount(struct super_block *sb, int *flags, char *data)
-{
-	*flags |= MS_NODIRATIME;
-	return 0;
-}
-
 static struct super_operations proc_sops = { 
 	.alloc_inode	= proc_alloc_inode,
 	.destroy_inode	= proc_destroy_inode,
@@ -141,7 +135,6 @@
 	.drop_inode	= generic_delete_inode,
 	.delete_inode	= proc_delete_inode,
 	.statfs		= simple_statfs,
-	.remount_fs	= proc_remount,
 };
 
 struct inode *proc_get_inode(struct super_block *sb, unsigned int ino,
@@ -194,7 +187,6 @@
 {
 	struct inode * root_inode;
 
-	s->s_flags |= MS_NODIRATIME;
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
 	s->s_magic = PROC_SUPER_MAGIC;
Index: linux-2.6.15-rc5/fs/proc/root.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/proc/root.c	2005-12-12 18:31:47.000000000 +0100
+++ linux-2.6.15-rc5/fs/proc/root.c	2005-12-13 11:22:18.000000000 +0100
@@ -34,6 +34,7 @@
 	.name		= "proc",
 	.get_sb		= proc_get_sb,
 	.kill_sb	= kill_anon_super,
+	.fs_flags	= FS_NODIRATIME,
 };
 
 extern int __init proc_init_inodecache(void);
Index: linux-2.6.15-rc5/fs/smbfs/inode.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/smbfs/inode.c	2005-12-12 18:51:18.000000000 +0100
+++ linux-2.6.15-rc5/fs/smbfs/inode.c	2005-12-13 11:44:58.000000000 +0100
@@ -93,12 +93,6 @@
 		printk(KERN_INFO "smb_inode_cache: not all structures were freed\n");
 }
 
-static int smb_remount(struct super_block *sb, int *flags, char *data)
-{
-	*flags |= MS_NODIRATIME;
-	return 0;
-}
-
 static struct super_operations smb_sops =
 {
 	.alloc_inode	= smb_alloc_inode,
@@ -108,7 +102,6 @@
 	.put_super	= smb_put_super,
 	.statfs		= smb_statfs,
 	.show_options	= smb_show_options,
-	.remount_fs	= smb_remount,
 };
 
 
@@ -512,7 +505,6 @@
 	if (ver != SMB_MOUNT_OLDVERSION && cpu_to_be32(ver) != SMB_MOUNT_ASCII)
 		goto out_wrong_data;
 
-	sb->s_flags |= MS_NODIRATIME;
 	sb->s_blocksize = 1024;	/* Eh...  Is this correct? */
 	sb->s_blocksize_bits = 10;
 	sb->s_magic = SMB_SUPER_MAGIC;
@@ -799,7 +791,7 @@
 	.name		= "smbfs",
 	.get_sb		= smb_get_sb,
 	.kill_sb	= kill_anon_super,
-	.fs_flags	= FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_BINARY_MOUNTDATA | FS_NODIRATIME,
 };
 
 static int __init init_smb_fs(void)
Index: linux-2.6.15-rc5/fs/vfat/namei.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/vfat/namei.c	2005-12-13 11:10:21.000000000 +0100
+++ linux-2.6.15-rc5/fs/vfat/namei.c	2005-12-13 11:15:36.000000000 +0100
@@ -1053,7 +1053,7 @@
 	.name		= "vfat",
 	.get_sb		= vfat_get_sb,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV|FS_NODIRATIME,
 };
 
 static int __init init_vfat_fs(void)
