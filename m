Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261344AbSJHXDi>; Tue, 8 Oct 2002 19:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbSJHXDi>; Tue, 8 Oct 2002 19:03:38 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:3312 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S261344AbSJHXDC>; Tue, 8 Oct 2002 19:03:02 -0400
Message-ID: <3DA365AA.1010500@quark.didntduck.org>
Date: Tue, 08 Oct 2002 19:09:30 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] struct super_block cleanup - final
Content-Type: multipart/mixed;
 boundary="------------070103050600060005040600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070103050600060005040600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This last patch removes the union, replacing it with s_fs_info.

--------------070103050600060005040600
Content-Type: text/plain;
 name="sb-union-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-union-1"

diff -urN linux-2.5.41/drivers/isdn/capi/capifs.c linux/drivers/isdn/capi/capifs.c
--- linux-2.5.41/drivers/isdn/capi/capifs.c	Sun Sep 15 22:18:24 2002
+++ linux/drivers/isdn/capi/capifs.c	Mon Oct  7 17:27:57 2002
@@ -61,7 +61,7 @@
 
 static inline struct capifs_sb_info *SBI(struct super_block *sb)
 {
-	return (struct capifs_sb_info *)(sb->u.generic_sbp);
+	return (struct capifs_sb_info *)(sb->s_fs_info);
 }
 
 /* ------------------------------------------------------------------ */
@@ -310,7 +310,7 @@
 	}
 	memset(sbi->nccis, 0, sizeof(struct capifs_ncci) * sbi->max_ncci);
 
-	s->u.generic_sbp = (void *) sbi;
+	s->s_fs_info = (void *) sbi;
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
 	s->s_magic = CAPIFS_SUPER_MAGIC;
diff -urN linux-2.5.41/fs/adfs/super.c linux/fs/adfs/super.c
--- linux-2.5.41/fs/adfs/super.c	Sun Sep 15 22:18:16 2002
+++ linux/fs/adfs/super.c	Mon Oct  7 17:27:57 2002
@@ -130,7 +130,7 @@
 		brelse(asb->s_map[i].dm_bh);
 	kfree(asb->s_map);
 	kfree(asb);
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 }
 
 static int parse_options(struct super_block *sb, char *options)
@@ -330,7 +330,7 @@
 	asb = kmalloc(sizeof(*asb), GFP_KERNEL);
 	if (!asb)
 		return -ENOMEM;
-	sb->u.generic_sbp = asb;
+	sb->s_fs_info = asb;
 	memset(asb, 0, sizeof(*asb));
 
 	/* set default options */
@@ -452,7 +452,7 @@
 error_free_bh:
 	brelse(bh);
 error:
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	kfree(asb);
 	return -EINVAL;
 }
diff -urN linux-2.5.41/fs/affs/super.c linux/fs/affs/super.c
--- linux-2.5.41/fs/affs/super.c	Sun Sep 15 22:18:41 2002
+++ linux/fs/affs/super.c	Mon Oct  7 17:27:57 2002
@@ -56,7 +56,7 @@
 	kfree(sbi->s_bitmap);
 	affs_brelse(sbi->s_root_bh);
 	kfree(sbi);
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	unlock_kernel();
 	return;
 }
@@ -298,7 +298,7 @@
 	sbi = kmalloc(sizeof(struct affs_sb_info), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
-	sb->u.generic_sbp = sbi;
+	sb->s_fs_info = sbi;
 	memset(sbi, 0, sizeof(*AFFS_SB));
 	init_MUTEX(&sbi->s_bmlock);
 
@@ -483,7 +483,7 @@
 	if (sbi->s_prefix)
 		kfree(sbi->s_prefix);
 	kfree(sbi);
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	return -EINVAL;
 }
 
diff -urN linux-2.5.41/fs/autofs/autofs_i.h linux/fs/autofs/autofs_i.h
--- linux-2.5.41/fs/autofs/autofs_i.h	Sun Sep 15 22:18:45 2002
+++ linux/fs/autofs/autofs_i.h	Mon Oct  7 17:27:57 2002
@@ -111,7 +111,7 @@
 
 static inline struct autofs_sb_info *autofs_sbi(struct super_block *sb)
 {
-	return (struct autofs_sb_info *)(sb->u.generic_sbp);
+	return (struct autofs_sb_info *)(sb->s_fs_info);
 }
 
 /* autofs_oz_mode(): do we see the man behind the curtain?  (The
diff -urN linux-2.5.41/fs/autofs/inode.c linux/fs/autofs/inode.c
--- linux-2.5.41/fs/autofs/inode.c	Sun Sep 15 22:18:46 2002
+++ linux/fs/autofs/inode.c	Mon Oct  7 17:27:57 2002
@@ -33,7 +33,7 @@
 			kfree(sbi->symlink[n].data);
 	}
 
-	kfree(sb->u.generic_sbp);
+	kfree(sb->s_fs_info);
 
 	DPRINTK(("autofs: shutting down\n"));
 }
@@ -126,7 +126,7 @@
 	memset(sbi, 0, sizeof(*sbi));
 	DPRINTK(("autofs: starting up, sbi = %p\n",sbi));
 
-	s->u.generic_sbp = sbi;
+	s->s_fs_info = sbi;
 	sbi->magic = AUTOFS_SBI_MAGIC;
 	sbi->catatonic = 0;
 	sbi->exp_timeout = 0;
diff -urN linux-2.5.41/fs/autofs4/autofs_i.h linux/fs/autofs4/autofs_i.h
--- linux-2.5.41/fs/autofs4/autofs_i.h	Sun Sep 15 22:18:41 2002
+++ linux/fs/autofs4/autofs_i.h	Mon Oct  7 17:27:57 2002
@@ -98,7 +98,7 @@
 
 static inline struct autofs_sb_info *autofs4_sbi(struct super_block *sb)
 {
-	return (struct autofs_sb_info *)(sb->u.generic_sbp);
+	return (struct autofs_sb_info *)(sb->s_fs_info);
 }
 
 static inline struct autofs_info *autofs4_dentry_ino(struct dentry *dentry)
diff -urN linux-2.5.41/fs/autofs4/inode.c linux/fs/autofs4/inode.c
--- linux-2.5.41/fs/autofs4/inode.c	Sun Sep 15 22:18:46 2002
+++ linux/fs/autofs4/inode.c	Mon Oct  7 17:27:57 2002
@@ -80,7 +80,7 @@
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(sb);
 
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 
 	if ( !sbi->catatonic )
 		autofs4_catatonic_mode(sbi); /* Free wait queues, close pipe */
@@ -189,7 +189,7 @@
 
 	memset(sbi, 0, sizeof(*sbi));
 
-	s->u.generic_sbp = sbi;
+	s->s_fs_info = sbi;
 	sbi->magic = AUTOFS_SBI_MAGIC;
 	sbi->catatonic = 0;
 	sbi->exp_timeout = 0;
diff -urN linux-2.5.41/fs/bfs/bfs.h linux/fs/bfs/bfs.h
--- linux-2.5.41/fs/bfs/bfs.h	Sun Sep 15 22:18:16 2002
+++ linux/fs/bfs/bfs.h	Mon Oct  7 17:27:57 2002
@@ -35,7 +35,7 @@
 
 static inline struct bfs_sb_info *BFS_SB(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 
 static inline struct bfs_inode_info *BFS_I(struct inode *inode)
diff -urN linux-2.5.41/fs/bfs/inode.c linux/fs/bfs/inode.c
--- linux-2.5.41/fs/bfs/inode.c	Tue Oct  1 19:53:18 2002
+++ linux/fs/bfs/inode.c	Mon Oct  7 17:27:57 2002
@@ -184,7 +184,7 @@
 	brelse(info->si_sbh);
 	kfree(info->si_imap);
 	kfree(info);
-	s->u.generic_sbp = NULL;
+	s->s_fs_info = NULL;
 }
 
 static int bfs_statfs(struct super_block *s, struct statfs *buf)
@@ -294,7 +294,7 @@
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-	s->u.generic_sbp = info;
+	s->s_fs_info = info;
 	memset(info, 0, sizeof(*info));
 
 	sb_set_blocksize(s, BFS_BSIZE);
@@ -370,7 +370,7 @@
 out:
 	brelse(bh);
 	kfree(info);
-	s->u.generic_sbp = NULL;
+	s->s_fs_info = NULL;
 	return -EINVAL;
 }
 
diff -urN linux-2.5.41/fs/coda/inode.c linux/fs/coda/inode.c
--- linux-2.5.41/fs/coda/inode.c	Sun Sep 15 22:18:29 2002
+++ linux/fs/coda/inode.c	Mon Oct  7 17:27:57 2002
@@ -175,7 +175,7 @@
 	sbi->sbi_vcomm = vc;
 	INIT_LIST_HEAD(&sbi->sbi_cihead);
 
-        sb->u.generic_sbp = sbi;
+        sb->s_fs_info = sbi;
         sb->s_blocksize = 1024;	/* XXXXX  what do we put here?? */
         sb->s_blocksize_bits = 10;
         sb->s_magic = CODA_SUPER_MAGIC;
diff -urN linux-2.5.41/fs/cramfs/inode.c linux/fs/cramfs/inode.c
--- linux-2.5.41/fs/cramfs/inode.c	Tue Oct  1 19:53:18 2002
+++ linux/fs/cramfs/inode.c	Mon Oct  7 17:27:57 2002
@@ -181,8 +181,8 @@
 
 static void cramfs_put_super(struct super_block *sb)
 {
-	kfree(sb->u.generic_sbp);
-	sb->u.generic_sbp = NULL;
+	kfree(sb->s_fs_info);
+	sb->s_fs_info = NULL;
 }
 
 static int cramfs_fill_super(struct super_block *sb, void *data, int silent)
@@ -195,7 +195,7 @@
 	sbi = kmalloc(sizeof(struct cramfs_sb_info), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
-	sb->u.generic_sbp = sbi;
+	sb->s_fs_info = sbi;
 	memset(sbi, 0, sizeof(struct cramfs_sb_info));
 
 	sb_set_blocksize(sb, PAGE_CACHE_SIZE);
@@ -258,7 +258,7 @@
 	return 0;
 out:
 	kfree(sbi);
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	return -EINVAL;
 }
 
diff -urN linux-2.5.41/fs/devfs/base.c linux/fs/devfs/base.c
--- linux-2.5.41/fs/devfs/base.c	Tue Oct  1 19:53:18 2002
+++ linux/fs/devfs/base.c	Mon Oct  7 17:27:57 2002
@@ -2483,7 +2483,7 @@
     int retval;
     struct devfs_entry *de;
     struct inode *inode = dentry->d_inode;
-    struct fs_info *fs_info = inode->i_sb->u.generic_sbp;
+    struct fs_info *fs_info = inode->i_sb->s_fs_info;
 
     de = get_devfs_entry_from_vfs_inode (inode);
     if (de == NULL) return -ENODEV;
@@ -2630,7 +2630,7 @@
     struct devfs_entry *parent, *de, *next = NULL;
     struct inode *inode = file->f_dentry->d_inode;
 
-    fs_info = inode->i_sb->u.generic_sbp;
+    fs_info = inode->i_sb->s_fs_info;
     parent = get_devfs_entry_from_vfs_inode (file->f_dentry->d_inode);
     if ( (long) file->f_pos < 0 ) return -EINVAL;
     DPRINTK (DEBUG_F_READDIR, "(%s): fs_info: %p  pos: %ld\n",
@@ -2694,7 +2694,7 @@
     int err;
     struct fcb_type *df;
     struct devfs_entry *de;
-    struct fs_info *fs_info = inode->i_sb->u.generic_sbp;
+    struct fs_info *fs_info = inode->i_sb->s_fs_info;
     void *ops;
 
     de = get_devfs_entry_from_vfs_inode (inode);
@@ -2825,7 +2825,7 @@
 	DPRINTK (DEBUG_D_DELETE, "(%p): dropping negative dentry\n", dentry);
 	return 1;
     }
-    fs_info = inode->i_sb->u.generic_sbp;
+    fs_info = inode->i_sb->s_fs_info;
     de = get_devfs_entry_from_vfs_inode (inode);
     DPRINTK (DEBUG_D_DELETE, "(%p): inode: %p  devfs_entry: %p\n",
 	     dentry, inode, de);
@@ -2854,7 +2854,7 @@
 static int devfs_d_revalidate_wait (struct dentry *dentry, int flags)
 {
     struct inode *dir = dentry->d_parent->d_inode;
-    struct fs_info *fs_info = dir->i_sb->u.generic_sbp;
+    struct fs_info *fs_info = dir->i_sb->s_fs_info;
     devfs_handle_t parent = get_devfs_entry_from_vfs_inode (dir);
     struct devfs_lookup_struct *lookup_info = dentry->d_fsdata;
     DECLARE_WAITQUEUE (wait, current);
@@ -2907,7 +2907,7 @@
 {
     struct devfs_entry tmp;  /*  Must stay in scope until devfsd idle again  */
     struct devfs_lookup_struct lookup_info;
-    struct fs_info *fs_info = dir->i_sb->u.generic_sbp;
+    struct fs_info *fs_info = dir->i_sb->s_fs_info;
     struct devfs_entry *parent, *de;
     struct inode *inode;
     struct dentry *retval = NULL;
@@ -2996,7 +2996,7 @@
     int unhooked;
     struct devfs_entry *de;
     struct inode *inode = dentry->d_inode;
-    struct fs_info *fs_info = dir->i_sb->u.generic_sbp;
+    struct fs_info *fs_info = dir->i_sb->s_fs_info;
 
     de = get_devfs_entry_from_vfs_inode (inode);
     DPRINTK (DEBUG_I_UNLINK, "(%s): de: %p\n", dentry->d_name.name, de);
@@ -3018,7 +3018,7 @@
 			  const char *symname)
 {
     int err;
-    struct fs_info *fs_info = dir->i_sb->u.generic_sbp;
+    struct fs_info *fs_info = dir->i_sb->s_fs_info;
     struct devfs_entry *parent, *de;
     struct inode *inode;
 
@@ -3050,7 +3050,7 @@
 static int devfs_mkdir (struct inode *dir, struct dentry *dentry, int mode)
 {
     int err;
-    struct fs_info *fs_info = dir->i_sb->u.generic_sbp;
+    struct fs_info *fs_info = dir->i_sb->s_fs_info;
     struct devfs_entry *parent, *de;
     struct inode *inode;
 
@@ -3082,10 +3082,10 @@
 {
     int err = 0;
     struct devfs_entry *de;
-    struct fs_info *fs_info = dir->i_sb->u.generic_sbp;
+    struct fs_info *fs_info = dir->i_sb->s_fs_info;
     struct inode *inode = dentry->d_inode;
 
-    if (dir->i_sb->u.generic_sbp != inode->i_sb->u.generic_sbp) return -EINVAL;
+    if (dir->i_sb->s_fs_info != inode->i_sb->s_fs_info) return -EINVAL;
     de = get_devfs_entry_from_vfs_inode (inode);
     if (de == NULL) return -ENOENT;
     if ( !S_ISDIR (de->mode) ) return -ENOTDIR;
@@ -3113,7 +3113,7 @@
 			int rdev)
 {
     int err;
-    struct fs_info *fs_info = dir->i_sb->u.generic_sbp;
+    struct fs_info *fs_info = dir->i_sb->s_fs_info;
     struct devfs_entry *parent, *de;
     struct inode *inode;
 
@@ -3201,7 +3201,7 @@
     init_waitqueue_head (&fs_info.devfsd_wait_queue);
     init_waitqueue_head (&fs_info.revalidate_wait_queue);
     fs_info.sb = sb;
-    sb->u.generic_sbp = &fs_info;
+    sb->s_fs_info = &fs_info;
     sb->s_blocksize = 1024;
     sb->s_blocksize_bits = 10;
     sb->s_magic = DEVFS_SUPER_MAGIC;
@@ -3210,7 +3210,7 @@
 	goto out_no_root;
     sb->s_root = d_alloc_root (root_inode);
     if (!sb->s_root) goto out_no_root;
-    DPRINTK (DEBUG_S_READ, "(): made devfs ptr: %p\n", sb->u.generic_sbp);
+    DPRINTK (DEBUG_S_READ, "(): made devfs ptr: %p\n", sb->s_fs_info);
     return 0;
 
 out_no_root:
@@ -3242,7 +3242,7 @@
     loff_t pos, devname_offset, tlen, rpos;
     devfs_handle_t de;
     struct devfsd_buf_entry *entry;
-    struct fs_info *fs_info = file->f_dentry->d_inode->i_sb->u.generic_sbp;
+    struct fs_info *fs_info = file->f_dentry->d_inode->i_sb->s_fs_info;
     struct devfsd_notify_struct *info = fs_info->devfsd_info;
     DECLARE_WAITQUEUE (wait, current);
 
@@ -3343,7 +3343,7 @@
 			 unsigned int cmd, unsigned long arg)
 {
     int ival;
-    struct fs_info *fs_info = inode->i_sb->u.generic_sbp;
+    struct fs_info *fs_info = inode->i_sb->s_fs_info;
 
     switch (cmd)
     {
@@ -3400,7 +3400,7 @@
 static int devfsd_close (struct inode *inode, struct file *file)
 {
     struct devfsd_buf_entry *entry, *next;
-    struct fs_info *fs_info = inode->i_sb->u.generic_sbp;
+    struct fs_info *fs_info = inode->i_sb->s_fs_info;
 
     if (fs_info->devfsd_file != file) return 0;
     fs_info->devfsd_event_mask = 0;
diff -urN linux-2.5.41/fs/efs/super.c linux/fs/efs/super.c
--- linux-2.5.41/fs/efs/super.c	Tue Oct  1 19:53:18 2002
+++ linux/fs/efs/super.c	Mon Oct  7 17:27:57 2002
@@ -72,8 +72,8 @@
 
 void efs_put_super(struct super_block *s)
 {
-	kfree(s->u.generic_sbp);
-	s->u.generic_sbp = NULL;
+	kfree(s->s_fs_info);
+	s->s_fs_info = NULL;
 }
 
 static struct super_operations efs_superblock_operations = {
@@ -213,7 +213,7 @@
  	sb = kmalloc(sizeof(struct efs_sb_info), GFP_KERNEL);
 	if (!sb)
 		return -ENOMEM;
-	s->u.generic_sbp = sb;
+	s->s_fs_info = sb;
 	memset(sb, 0, sizeof(struct efs_sb_info));
  
 	s->s_magic		= EFS_SUPER_MAGIC;
@@ -272,7 +272,7 @@
 
 out_no_fs_ul:
 out_no_fs:
-	s->u.generic_sbp = NULL;
+	s->s_fs_info = NULL;
 	kfree(sb);
 	return -EINVAL;
 }
diff -urN linux-2.5.41/fs/ext2/super.c linux/fs/ext2/super.c
--- linux-2.5.41/fs/ext2/super.c	Sun Sep 15 22:18:40 2002
+++ linux/fs/ext2/super.c	Mon Oct  7 17:27:57 2002
@@ -143,7 +143,7 @@
 			brelse (sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
 	brelse (sbi->s_sbh);
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	kfree(sbi);
 
 	return;
@@ -475,7 +475,7 @@
 	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
-	sb->u.generic_sbp = sbi;
+	sb->s_fs_info = sbi;
 	memset(sbi, 0, sizeof(*sbi));
 
 	/*
@@ -710,7 +710,7 @@
 failed_mount:
 	brelse(bh);
 failed_sbi:
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	kfree(sbi);
 	return -EINVAL;
 }
diff -urN linux-2.5.41/fs/ext3/super.c linux/fs/ext3/super.c
--- linux-2.5.41/fs/ext3/super.c	Wed Sep 18 00:06:55 2002
+++ linux/fs/ext3/super.c	Mon Oct  7 17:27:57 2002
@@ -439,7 +439,7 @@
 		ext3_blkdev_remove(sbi);
 	}
 	clear_ro_after(sb);
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	kfree(sbi);
 	return;
 }
@@ -974,7 +974,7 @@
 	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
-	sb->u.generic_sbp = sbi;
+	sb->s_fs_info = sbi;
 	memset(sbi, 0, sizeof(*sbi));
 	sbi->s_mount_opt = 0;
 	sbi->s_resuid = EXT3_DEF_RESUID;
@@ -1271,7 +1271,7 @@
 	ext3_blkdev_remove(sbi);
 	brelse(bh);
 out_fail:
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	kfree(sbi);
 	return -EINVAL;
 }
diff -urN linux-2.5.41/fs/fat/inode.c linux/fs/fat/inode.c
--- linux-2.5.41/fs/fat/inode.c	Mon Oct  7 15:44:09 2002
+++ linux/fs/fat/inode.c	Mon Oct  7 17:27:57 2002
@@ -197,7 +197,7 @@
 		kfree(sbi->options.iocharset);
 		sbi->options.iocharset = NULL;
 	}
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	kfree(sbi);
 }
 
@@ -648,7 +648,7 @@
 	sbi = kmalloc(sizeof(struct msdos_sb_info), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
-	sb->u.generic_sbp = sbi;
+	sb->s_fs_info = sbi;
 	memset(sbi, 0, sizeof(struct msdos_sb_info));
 
 	cvf_format[0] = '\0';
@@ -925,7 +925,7 @@
 	if (sbi->private_data)
 		kfree(sbi->private_data);
 	sbi->private_data = NULL;
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	kfree(sbi);
 
 	return error;
diff -urN linux-2.5.41/fs/freevxfs/vxfs.h linux/fs/freevxfs/vxfs.h
--- linux-2.5.41/fs/freevxfs/vxfs.h	Sun Sep 15 22:18:29 2002
+++ linux/fs/freevxfs/vxfs.h	Mon Oct  7 17:27:57 2002
@@ -261,6 +261,6 @@
  * Get filesystem private data from VFS superblock.
  */
 #define VXFS_SBI(sbp) \
-	((struct vxfs_sb_info *)(sbp)->u.generic_sbp)
+	((struct vxfs_sb_info *)(sbp)->s_fs_info)
 
 #endif /* _VXFS_SUPER_H_ */
diff -urN linux-2.5.41/fs/freevxfs/vxfs_super.c linux/fs/freevxfs/vxfs_super.c
--- linux-2.5.41/fs/freevxfs/vxfs_super.c	Fri Sep 20 16:27:57 2002
+++ linux/fs/freevxfs/vxfs_super.c	Mon Oct  7 17:27:57 2002
@@ -184,7 +184,7 @@
 #endif
 
 	sbp->s_magic = rsbp->vs_magic;
-	sbp->u.generic_sbp = (void *)infp;
+	sbp->s_fs_info = (void *)infp;
 
 	infp->vsi_raw = rsbp;
 	infp->vsi_bp = bp;
diff -urN linux-2.5.41/fs/hfs/super.c linux/fs/hfs/super.c
--- linux-2.5.41/fs/hfs/super.c	Sun Sep 15 22:18:26 2002
+++ linux/fs/hfs/super.c	Mon Oct  7 17:27:57 2002
@@ -181,8 +181,8 @@
 	/* release the MDB's resources */
 	hfs_mdb_put(mdb, sb->s_flags & MS_RDONLY);
 
-	kfree(sb->u.generic_sbp);
-	sb->u.generic_sbp = NULL;
+	kfree(sb->s_fs_info);
+	sb->s_fs_info = NULL;
 }
 
 /*
@@ -459,7 +459,7 @@
 	sbi = kmalloc(sizeof(struct hfs_sb_info), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
-	s->u.generic_sbp = sbi;
+	s->s_fs_info = sbi;
 	memset(sbi, 0, sizeof(struct hfs_sb_info));
 
 	if (!parse_options((char *)data, sbi, &part)) {
@@ -533,7 +533,7 @@
 	hfs_mdb_put(mdb, s->s_flags & MS_RDONLY);
 bail2:
 	kfree(sbi);
-	s->u.generic_sbp = NULL;
+	s->s_fs_info = NULL;
 	return -EINVAL;	
 }
 
diff -urN linux-2.5.41/fs/hpfs/hpfs_fn.h linux/fs/hpfs/hpfs_fn.h
--- linux-2.5.41/fs/hpfs/hpfs_fn.h	Mon Oct  7 15:44:09 2002
+++ linux/fs/hpfs/hpfs_fn.h	Mon Oct  7 17:27:57 2002
@@ -296,7 +296,7 @@
 
 static inline struct hpfs_sb_info *hpfs_sb(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 
 /* super.c */
diff -urN linux-2.5.41/fs/hpfs/super.c linux/fs/hpfs/super.c
--- linux-2.5.41/fs/hpfs/super.c	Mon Oct  7 15:44:09 2002
+++ linux/fs/hpfs/super.c	Mon Oct  7 17:27:57 2002
@@ -105,7 +105,7 @@
 	if (sbi->sb_cp_table) kfree(sbi->sb_cp_table);
 	if (sbi->sb_bmp_dir) kfree(sbi->sb_bmp_dir);
 	unmark_dirty(s);
-	s->u.generic_sbp = NULL;
+	s->s_fs_info = NULL;
 	kfree(sbi);
 }
 
@@ -440,7 +440,7 @@
 	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
-	s->u.generic_sbp = sbi;
+	s->s_fs_info = sbi;
 	memset(sbi, 0, sizeof(*sbi));
 
 	sbi->sb_bmp_dir = NULL;
@@ -626,7 +626,7 @@
 bail0:
 	if (sbi->sb_bmp_dir) kfree(sbi->sb_bmp_dir);
 	if (sbi->sb_cp_table) kfree(sbi->sb_cp_table);
-	s->u.generic_sbp = NULL;
+	s->s_fs_info = NULL;
 	kfree(sbi);
 	return -EINVAL;
 }
diff -urN linux-2.5.41/fs/isofs/inode.c linux/fs/isofs/inode.c
--- linux-2.5.41/fs/isofs/inode.c	Tue Oct  1 19:53:18 2002
+++ linux/fs/isofs/inode.c	Mon Oct  7 17:27:57 2002
@@ -74,7 +74,7 @@
 #endif
 
 	kfree(sbi);
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	return;
 }
 
@@ -550,7 +550,7 @@
 	sbi = kmalloc(sizeof(struct isofs_sb_info), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
-	s->u.generic_sbp = sbi;
+	s->s_fs_info = sbi;
 	memset(sbi, 0, sizeof(struct isofs_sb_info));
 
 	if (!parse_options((char *) data, &opt))
@@ -911,7 +911,7 @@
 	brelse(bh);
 out_freesbi:
 	kfree(sbi);
-	s->u.generic_sbp = NULL;
+	s->s_fs_info = NULL;
 	return -EINVAL;
 }
 
diff -urN linux-2.5.41/fs/jffs/inode-v23.c linux/fs/jffs/inode-v23.c
--- linux-2.5.41/fs/jffs/inode-v23.c	Mon Oct  7 15:44:09 2002
+++ linux/fs/jffs/inode-v23.c	Mon Oct  7 17:27:57 2002
@@ -88,7 +88,7 @@
 
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
-	sb->u.generic_sbp = (void *) 0;
+	sb->s_fs_info = (void *) 0;
 	sb->s_maxbytes = 0xFFFFFFFF;
 
 	/* Build the file system.  */
@@ -111,7 +111,7 @@
 		goto jffs_sb_err3;
 	}
 
-	c = (struct jffs_control *) sb->u.generic_sbp;
+	c = (struct jffs_control *) sb->s_fs_info;
 
 #ifdef CONFIG_JFFS_PROC_FS
 	/* Set up the jffs proc file system.  */
@@ -149,7 +149,7 @@
 jffs_sb_err3:
 	iput(root_inode);
 jffs_sb_err2:
-	jffs_cleanup_control((struct jffs_control *)sb->u.generic_sbp);
+	jffs_cleanup_control((struct jffs_control *)sb->s_fs_info);
 jffs_sb_err1:
 	printk(KERN_WARNING "JFFS: Failed to mount device %s.\n",
 	       sb->s_id);
@@ -161,7 +161,7 @@
 static void
 jffs_put_super(struct super_block *sb)
 {
-	struct jffs_control *c = (struct jffs_control *) sb->u.generic_sbp;
+	struct jffs_control *c = (struct jffs_control *) sb->s_fs_info;
 
 	D2(printk("jffs_put_super()\n"));
 
@@ -177,7 +177,7 @@
 
 	D1(printk (KERN_NOTICE "jffs_put_super(): Successfully waited on thread.\n"));
 
-	jffs_cleanup_control((struct jffs_control *)sb->u.generic_sbp);
+	jffs_cleanup_control((struct jffs_control *)sb->s_fs_info);
 	D1(printk(KERN_NOTICE "JFFS: Successfully unmounted device %s.\n",
 	       sb->s_id));
 }
@@ -204,7 +204,7 @@
 	if ((res = inode_change_ok(inode, iattr))) 
 		goto out;
 
-	c = (struct jffs_control *)inode->i_sb->u.generic_sbp;
+	c = (struct jffs_control *)inode->i_sb->s_fs_info;
 	fmc = c->fmc;
 
 	D3(printk (KERN_NOTICE "notify_change(): down biglock\n"));
@@ -355,7 +355,7 @@
 		return NULL;
 	}
 
-	c = (struct jffs_control *)sb->u.generic_sbp;
+	c = (struct jffs_control *)sb->s_fs_info;
 
 	inode->i_ino = raw_inode->ino;
 	inode->i_mode = raw_inode->mode;
@@ -382,7 +382,7 @@
 int
 jffs_statfs(struct super_block *sb, struct statfs *buf)
 {
-	struct jffs_control *c = (struct jffs_control *) sb->u.generic_sbp;
+	struct jffs_control *c = (struct jffs_control *) sb->s_fs_info;
 	struct jffs_fmcontrol *fmc;
 
 	lock_kernel();
@@ -436,7 +436,7 @@
 		 new_dir, new_dentry->d_name.name));
 
 	lock_kernel();
-	c = (struct jffs_control *)old_dir->i_sb->u.generic_sbp;
+	c = (struct jffs_control *)old_dir->i_sb->s_fs_info;
 	ASSERT(if (!c) {
 		printk(KERN_ERR "jffs_rename(): The old_dir inode "
 		       "didn't have a reference to a jffs_file struct\n");
@@ -572,7 +572,7 @@
 	struct jffs_file *f;
 	struct dentry *dentry = filp->f_dentry;
 	struct inode *inode = dentry->d_inode;
-	struct jffs_control *c = (struct jffs_control *)inode->i_sb->u.generic_sbp;
+	struct jffs_control *c = (struct jffs_control *)inode->i_sb->s_fs_info;
 	int j;
 	int ddino;
 	lock_kernel();
@@ -643,7 +643,7 @@
 {
 	struct jffs_file *d;
 	struct jffs_file *f;
-	struct jffs_control *c = (struct jffs_control *)dir->i_sb->u.generic_sbp;
+	struct jffs_control *c = (struct jffs_control *)dir->i_sb->s_fs_info;
 	int len;
 	int r = 0;
 	const char *name;
@@ -743,7 +743,7 @@
 	int result;
 	struct inode *inode = (struct inode*)page->mapping->host;
 	struct jffs_file *f = (struct jffs_file *)inode->u.generic_ip;
-	struct jffs_control *c = (struct jffs_control *)inode->i_sb->u.generic_sbp;
+	struct jffs_control *c = (struct jffs_control *)inode->i_sb->s_fs_info;
 	int r;
 	loff_t offset;
 
@@ -919,7 +919,7 @@
 static int
 jffs_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	struct jffs_control *c = (struct jffs_control *)dir->i_sb->u.generic_sbp;
+	struct jffs_control *c = (struct jffs_control *)dir->i_sb->s_fs_info;
 	int ret;
 	D3(printk("***jffs_rmdir()\n"));
 	D3(printk (KERN_NOTICE "rmdir(): down biglock\n"));
@@ -937,7 +937,7 @@
 static int
 jffs_unlink(struct inode *dir, struct dentry *dentry)
 {
-	struct jffs_control *c = (struct jffs_control *)dir->i_sb->u.generic_sbp;
+	struct jffs_control *c = (struct jffs_control *)dir->i_sb->s_fs_info;
 	int ret; 
 
 	lock_kernel();
@@ -1561,7 +1561,7 @@
 	D2(printk("***jffs_ioctl(): cmd = 0x%08x, arg = 0x%08lx\n",
 		  cmd, arg));
 
-	if (!(c = (struct jffs_control *)inode->i_sb->u.generic_sbp)) {
+	if (!(c = (struct jffs_control *)inode->i_sb->s_fs_info)) {
 		printk(KERN_ERR "JFFS: Bad inode in ioctl() call. "
 		       "(cmd = 0x%08x)\n", cmd);
 		return -EIO;
@@ -1686,7 +1686,7 @@
 			 "No super block!\n"));
 		return;
 	}
-	c = (struct jffs_control *)inode->i_sb->u.generic_sbp;
+	c = (struct jffs_control *)inode->i_sb->s_fs_info;
 	D3(printk (KERN_NOTICE "read_inode(): down biglock\n"));
 	down(&c->fmc->biglock);
 	if (!(f = jffs_find_file(c, inode->i_ino))) {
@@ -1748,7 +1748,7 @@
 	inode->u.generic_ip = 0;
 	clear_inode(inode);
 	if (inode->i_nlink == 0) {
-		c = (struct jffs_control *) inode->i_sb->u.generic_sbp;
+		c = (struct jffs_control *) inode->i_sb->s_fs_info;
 		f = (struct jffs_file *) jffs_find_file (c, inode->i_ino);
 		jffs_possibly_delete_file(f);
 	}
@@ -1760,7 +1760,7 @@
 void
 jffs_write_super(struct super_block *sb)
 {
-	struct jffs_control *c = (struct jffs_control *)sb->u.generic_sbp;
+	struct jffs_control *c = (struct jffs_control *)sb->s_fs_info;
 	lock_kernel();
 	jffs_garbage_collect_trigger(c);
 	unlock_kernel();
diff -urN linux-2.5.41/fs/jffs/intrep.c linux/fs/jffs/intrep.c
--- linux-2.5.41/fs/jffs/intrep.c	Mon Oct  7 15:44:09 2002
+++ linux/fs/jffs/intrep.c	Mon Oct  7 17:27:57 2002
@@ -614,7 +614,7 @@
 		printk("JFFS: Failed to build file system.\n");
 		goto jffs_build_fs_fail;
 	}
-	sb->u.generic_sbp = (void *)c;
+	sb->s_fs_info = (void *)c;
 	c->building_fs = 0;
 
 	D1(jffs_print_hash_table(c));
diff -urN linux-2.5.41/fs/jffs2/os-linux.h linux/fs/jffs2/os-linux.h
--- linux-2.5.41/fs/jffs2/os-linux.h	Sun Sep 15 22:18:19 2002
+++ linux/fs/jffs2/os-linux.h	Mon Oct  7 17:27:57 2002
@@ -18,7 +18,7 @@
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,2)
 #define JFFS2_INODE_INFO(i) (list_entry(i, struct jffs2_inode_info, vfs_inode))
 #define OFNI_EDONI_2SFFJ(f)  (&(f)->vfs_inode)
-#define JFFS2_SB_INFO(sb) (sb->u.generic_sbp)
+#define JFFS2_SB_INFO(sb) (sb->s_fs_info)
 #define OFNI_BS_2SFFJ(c)  ((struct super_block *)c->os_priv)
 #elif defined(JFFS2_OUT_OF_KERNEL)
 #define JFFS2_INODE_INFO(i) ((struct jffs2_inode_info *) &(i)->u)
diff -urN linux-2.5.41/fs/jffs2/super.c linux/fs/jffs2/super.c
--- linux-2.5.41/fs/jffs2/super.c	Sun Sep 15 22:18:25 2002
+++ linux/fs/jffs2/super.c	Mon Oct  7 17:27:57 2002
@@ -93,7 +93,7 @@
 	/* For persistence of NFS exports etc. we use the same s_dev
 	   each time we mount the device, don't just use an anonymous
 	   device */
-	sb->u.generic_sbp = p;
+	sb->s_fs_info = p;
 	p->os_priv = sb;
 	sb->s_dev = MKDEV(MTD_BLOCK_MAJOR, p->mtd->index);
 
diff -urN linux-2.5.41/fs/jfs/jfs_incore.h linux/fs/jfs/jfs_incore.h
--- linux-2.5.41/fs/jfs/jfs_incore.h	Mon Sep 23 09:00:33 2002
+++ linux/fs/jfs/jfs_incore.h	Mon Oct  7 17:27:57 2002
@@ -162,7 +162,7 @@
 
 static inline struct jfs_sb_info *JFS_SBI(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 
 static inline int isReadOnly(struct inode *inode)
diff -urN linux-2.5.41/fs/jfs/super.c linux/fs/jfs/super.c
--- linux-2.5.41/fs/jfs/super.c	Mon Sep 23 09:00:33 2002
+++ linux/fs/jfs/super.c	Mon Oct  7 17:27:57 2002
@@ -248,7 +248,7 @@
 	if (!sbi)
 		return -ENOSPC;
 	memset(sbi, 0, sizeof (struct jfs_sb_info));
-	sb->u.generic_sbp = sbi;
+	sb->s_fs_info = sbi;
 
 	if (!parse_options((char *) data, sb, &newLVSize)) {
 		kfree(sbi);
diff -urN linux-2.5.41/fs/minix/inode.c linux/fs/minix/inode.c
--- linux-2.5.41/fs/minix/inode.c	Tue Oct  1 19:53:18 2002
+++ linux/fs/minix/inode.c	Mon Oct  7 17:27:57 2002
@@ -43,7 +43,7 @@
 		brelse(sbi->s_zmap[i]);
 	brelse (sbi->s_sbh);
 	kfree(sbi->s_imap);
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	kfree(sbi);
 
 	return;
@@ -145,7 +145,7 @@
 	sbi = kmalloc(sizeof(struct minix_sb_info), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
-	s->u.generic_sbp = sbi;
+	s->s_fs_info = sbi;
 	memset(sbi, 0, sizeof(struct minix_sb_info));
 
 	/* N.B. These should be compile-time tests.
@@ -288,7 +288,7 @@
 out_bad_sb:
 	printk("MINIX-fs: unable to read superblock\n");
  out:
-	s->u.generic_sbp = NULL;
+	s->s_fs_info = NULL;
 	kfree(sbi);
 	return -EINVAL;
 }
diff -urN linux-2.5.41/fs/minix/minix.h linux/fs/minix/minix.h
--- linux-2.5.41/fs/minix/minix.h	Sun Sep 15 22:19:04 2002
+++ linux/fs/minix/minix.h	Mon Oct  7 17:27:57 2002
@@ -87,7 +87,7 @@
 
 static inline struct minix_sb_info *minix_sb(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 
 static inline struct minix_inode_info *minix_i(struct inode *inode)
diff -urN linux-2.5.41/fs/ncpfs/inode.c linux/fs/ncpfs/inode.c
--- linux-2.5.41/fs/ncpfs/inode.c	Mon Oct  7 15:44:09 2002
+++ linux/fs/ncpfs/inode.c	Mon Oct  7 17:27:57 2002
@@ -401,7 +401,7 @@
 	server = kmalloc(sizeof(struct ncp_server), GFP_KERNEL);
 	if (!server)
 		return -ENOMEM;
-	sb->u.generic_sbp = server;
+	sb->s_fs_info = server;
 	memset(server, 0, sizeof(struct ncp_server));
 
 	error = -EFAULT;
@@ -668,7 +668,7 @@
 	 */
 	fput(ncp_filp);
 out:
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	kfree(server);
 	return error;
 }
@@ -707,7 +707,7 @@
 	if (server->auth.object_name)
 		ncp_kfree_s(server->auth.object_name, server->auth.object_name_len);
 	vfree(server->packet);
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	kfree(server);
 }
 
diff -urN linux-2.5.41/fs/nfs/inode.c linux/fs/nfs/inode.c
--- linux-2.5.41/fs/nfs/inode.c	Mon Oct  7 15:44:09 2002
+++ linux/fs/nfs/inode.c	Mon Oct  7 17:27:57 2002
@@ -1167,7 +1167,7 @@
 
 static int nfs_set_super(struct super_block *s, void *data)
 {
-	s->u.generic_sbp = data;
+	s->s_fs_info = data;
 	return set_anon_super(s, data);
 }
  
diff -urN linux-2.5.41/fs/ntfs/ntfs.h linux/fs/ntfs/ntfs.h
--- linux-2.5.41/fs/ntfs/ntfs.h	Sun Sep 15 22:18:27 2002
+++ linux/fs/ntfs/ntfs.h	Mon Oct  7 17:27:58 2002
@@ -90,7 +90,7 @@
  */
 static inline ntfs_volume *NTFS_SB(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 
 /**
diff -urN linux-2.5.41/fs/ntfs/super.c linux/fs/ntfs/super.c
--- linux-2.5.41/fs/ntfs/super.c	Sun Sep 15 22:18:21 2002
+++ linux/fs/ntfs/super.c	Mon Oct  7 17:27:58 2002
@@ -1051,7 +1051,7 @@
 		unload_nls(vol->nls_map);
 		vol->nls_map = NULL;
 	}
-	vfs_sb->u.generic_sbp = NULL;
+	vfs_sb->s_fs_info = NULL;
 	kfree(vol);
 	return;
 }
@@ -1336,8 +1336,8 @@
 #ifndef NTFS_RW
 	sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
 #endif
-	/* Allocate a new ntfs_volume and place it in sb->u.generic_sbp. */
-	sb->u.generic_sbp = kmalloc(sizeof(ntfs_volume), GFP_NOFS);
+	/* Allocate a new ntfs_volume and place it in sb->s_fs_info. */
+	sb->s_fs_info = kmalloc(sizeof(ntfs_volume), GFP_NOFS);
 	vol = NTFS_SB(sb);
 	if (!vol) {
 		if (!silent)
@@ -1580,7 +1580,7 @@
 	}
 	/* Errors at this stage are irrelevant. */
 err_out_now:
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	kfree(vol);
 	ntfs_debug("Failed, returning -EINVAL.");
 	return -EINVAL;
diff -urN linux-2.5.41/fs/qnx4/inode.c linux/fs/qnx4/inode.c
--- linux-2.5.41/fs/qnx4/inode.c	Sun Sep 15 22:18:25 2002
+++ linux/fs/qnx4/inode.c	Mon Oct  7 17:27:58 2002
@@ -353,7 +353,7 @@
 	qs = kmalloc(sizeof(struct qnx4_sb_info), GFP_KERNEL);
 	if (!qs)
 		return -ENOMEM;
-	s->u.generic_sbp = qs;
+	s->s_fs_info = qs;
 	memset(qs, 0, sizeof(struct qnx4_sb_info));
 
 	sb_set_blocksize(s, QNX4_BLOCK_SIZE);
@@ -416,7 +416,7 @@
 	brelse(bh);
       outnobh:
 	kfree(qs);
-	s->u.generic_sbp = NULL;
+	s->s_fs_info = NULL;
 	return -EINVAL;
 }
 
@@ -425,7 +425,7 @@
 	struct qnx4_sb_info *qs = qnx4_sb(sb);
 	kfree( qs->BitMap );
 	kfree( qs );
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	return;
 }
 
diff -urN linux-2.5.41/fs/reiserfs/super.c linux/fs/reiserfs/super.c
--- linux-2.5.41/fs/reiserfs/super.c	Sun Sep 15 22:18:28 2002
+++ linux/fs/reiserfs/super.c	Mon Oct  7 17:27:58 2002
@@ -402,8 +402,8 @@
   reiserfs_proc_unregister( s, "version" );
   reiserfs_proc_info_done( s );
 
-  kfree(s->u.generic_sbp);
-  s->u.generic_sbp = NULL;
+  kfree(s->s_fs_info);
+  s->s_fs_info = NULL;
 
   return;
 }
@@ -1164,7 +1164,7 @@
 	errval = -ENOMEM;
 	goto error;
     }
-    s->u.generic_sbp = sbi;
+    s->s_fs_info = sbi;
     memset (sbi, 0, sizeof (struct reiserfs_sb_info));
     /* Set default values for options: non-aggressive tails */
     REISERFS_SB(s)->s_mount_opt = ( 1 << REISERFS_SMALLTAIL );
@@ -1335,7 +1335,7 @@
 	kfree(sbi);
     }
 
-    s->u.generic_sbp = NULL;
+    s->s_fs_info = NULL;
     return errval;
 }
 
diff -urN linux-2.5.41/fs/romfs/inode.c linux/fs/romfs/inode.c
--- linux-2.5.41/fs/romfs/inode.c	Tue Oct  1 19:53:18 2002
+++ linux/fs/romfs/inode.c	Mon Oct  7 17:27:58 2002
@@ -86,7 +86,7 @@
 /* instead of private superblock data */
 static inline unsigned long romfs_maxsize(struct super_block *sb)
 {
-	return (unsigned long)sb->u.generic_sbp;
+	return (unsigned long)sb->s_fs_info;
 }
 
 static inline struct romfs_inode_info *ROMFS_I(struct inode *inode)
@@ -144,7 +144,7 @@
 	}
 
 	s->s_magic = ROMFS_MAGIC;
-	s->u.generic_sbp = (void *)(long)sz;
+	s->s_fs_info = (void *)(long)sz;
 
 	s->s_flags |= MS_RDONLY;
 
diff -urN linux-2.5.41/fs/smbfs/inode.c linux/fs/smbfs/inode.c
--- linux-2.5.41/fs/smbfs/inode.c	Mon Oct  7 15:44:09 2002
+++ linux/fs/smbfs/inode.c	Mon Oct  7 17:27:58 2002
@@ -468,7 +468,7 @@
 		unload_nls(server->local_nls);
 		server->local_nls = NULL;
 	}
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	smb_unlock_server(server);
 	smb_kfree(server);
 }
@@ -499,7 +499,7 @@
 	server = smb_kmalloc(sizeof(struct smb_sb_info), GFP_KERNEL);
 	if (!server)
 		goto out_no_server;
-	sb->u.generic_sbp = server;
+	sb->s_fs_info = server;
 	memset(server, 0, sizeof(struct smb_sb_info));
 
 	server->super_block = sb;
@@ -592,7 +592,7 @@
 out_no_mem:
 	if (!server->mnt)
 		printk(KERN_ERR "smb_fill_super: allocation failure\n");
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	smb_kfree(server);
 	goto out_fail;
 out_wrong_data:
diff -urN linux-2.5.41/fs/sysv/super.c linux/fs/sysv/super.c
--- linux-2.5.41/fs/sysv/super.c	Sun Sep 15 22:18:21 2002
+++ linux/fs/sysv/super.c	Mon Oct  7 17:27:58 2002
@@ -367,7 +367,7 @@
 
 	sbi->s_sb = sb;
 	sbi->s_block_base = 0;
-	sb->u.generic_sbp = sbi;
+	sb->s_fs_info = sbi;
 	
 	sb_set_blocksize(sb, BLOCK_SIZE);
 
@@ -453,7 +453,7 @@
 	sbi->s_block_base = 0;
 	sbi->s_type = FSTYPE_V7;
 	sbi->s_bytesex = BYTESEX_PDP;
-	sb->u.generic_sbp = sbi;
+	sb->s_fs_info = sbi;
 	
 	sb_set_blocksize(sb, 512);
 
diff -urN linux-2.5.41/fs/sysv/sysv.h linux/fs/sysv/sysv.h
--- linux-2.5.41/fs/sysv/sysv.h	Sun Sep 15 22:18:17 2002
+++ linux/fs/sysv/sysv.h	Mon Oct  7 17:27:58 2002
@@ -73,7 +73,7 @@
 
 static inline struct sysv_sb_info *SYSV_SB(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 
 
diff -urN linux-2.5.41/fs/udf/super.c linux/fs/udf/super.c
--- linux-2.5.41/fs/udf/super.c	Sun Sep 15 22:18:40 2002
+++ linux/fs/udf/super.c	Mon Oct  7 17:27:58 2002
@@ -1425,7 +1425,7 @@
 	sbi = kmalloc(sizeof(struct udf_sb_info), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
-	sb->u.generic_sbp = sbi;
+	sb->s_fs_info = sbi;
 	memset(UDF_SB(sb), 0x00, sizeof(struct udf_sb_info));
 
 #if UDFFS_RW != 1
@@ -1615,7 +1615,7 @@
 	udf_release_data(UDF_SB_LVIDBH(sb));
 	UDF_SB_FREE(sb);
 	kfree(sbi);
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	return -EINVAL;
 }
 
@@ -1706,8 +1706,8 @@
 		udf_close_lvid(sb);
 	udf_release_data(UDF_SB_LVIDBH(sb));
 	UDF_SB_FREE(sb);
-	kfree(sb->u.generic_sbp);
-	sb->u.generic_sbp = NULL;
+	kfree(sb->s_fs_info);
+	sb->s_fs_info = NULL;
 }
 
 /*
diff -urN linux-2.5.41/fs/udf/udf_sb.h linux/fs/udf/udf_sb.h
--- linux-2.5.41/fs/udf/udf_sb.h	Sun Sep 15 22:18:24 2002
+++ linux/fs/udf/udf_sb.h	Mon Oct  7 17:27:58 2002
@@ -32,7 +32,7 @@
 
 static inline struct udf_sb_info *UDF_SB(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 
 #define UDF_SB_FREE(X)\
diff -urN linux-2.5.41/fs/ufs/super.c linux/fs/ufs/super.c
--- linux-2.5.41/fs/ufs/super.c	Tue Oct  1 19:53:18 2002
+++ linux/fs/ufs/super.c	Mon Oct  7 17:27:58 2002
@@ -457,7 +457,7 @@
 	sbi = kmalloc(sizeof(struct ufs_sb_info), GFP_KERNEL);
 	if (!sbi)
 		goto failed_nomem;
-	sb->u.generic_sbp = sbi;
+	sb->s_fs_info = sbi;
 	memset(sbi, 0, sizeof(struct ufs_sb_info));
 
 	UFSD(("flag %u\n", (int)(sb->s_flags & MS_RDONLY)))
@@ -844,7 +844,7 @@
 	if (ubh) ubh_brelse_uspi (uspi);
 	if (uspi) kfree (uspi);
 	if (sbi) kfree(sbi);
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	UFSD(("EXIT (FAILED)\n"))
 	return -EINVAL;
 
@@ -892,7 +892,7 @@
 	ubh_brelse_uspi (sbi->s_uspi);
 	kfree (sbi->s_uspi);
 	kfree (sbi);
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	return;
 }
 
diff -urN linux-2.5.41/fs/xfs/linux/xfs_super.h linux/fs/xfs/linux/xfs_super.h
--- linux-2.5.41/fs/xfs/linux/xfs_super.h	Wed Sep 18 00:06:55 2002
+++ linux/fs/xfs/linux/xfs_super.h	Mon Oct  7 17:27:58 2002
@@ -75,9 +75,9 @@
 
 
 #define LINVFS_GET_VFS(s) \
-	(vfs_t *)((s)->u.generic_sbp)
+	(vfs_t *)((s)->s_fs_info)
 #define LINVFS_SET_VFS(s, vfsp) \
-	((s)->u.generic_sbp = vfsp)
+	((s)->s_fs_info = vfsp)
 
 
 struct xfs_mount_args;
diff -urN linux-2.5.41/include/linux/adfs_fs.h linux/include/linux/adfs_fs.h
--- linux-2.5.41/include/linux/adfs_fs.h	Sun Sep 15 22:18:46 2002
+++ linux/include/linux/adfs_fs.h	Mon Oct  7 17:27:58 2002
@@ -63,7 +63,7 @@
 
 static inline struct adfs_sb_info *ADFS_SB(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 
 static inline struct adfs_inode_info *ADFS_I(struct inode *inode)
diff -urN linux-2.5.41/include/linux/affs_fs_sb.h linux/include/linux/affs_fs_sb.h
--- linux-2.5.41/include/linux/affs_fs_sb.h	Sun Sep 15 22:18:21 2002
+++ linux/include/linux/affs_fs_sb.h	Mon Oct  7 17:27:58 2002
@@ -52,7 +52,7 @@
 /* short cut to get to the affs specific sb data */
 static inline struct affs_sb_info *AFFS_SB(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 
 #endif
diff -urN linux-2.5.41/include/linux/coda_psdev.h linux/include/linux/coda_psdev.h
--- linux-2.5.41/include/linux/coda_psdev.h	Sun Sep 15 22:18:29 2002
+++ linux/include/linux/coda_psdev.h	Mon Oct  7 17:27:58 2002
@@ -26,7 +26,7 @@
 
 static inline struct coda_sb_info *coda_sbp(struct super_block *sb)
 {
-    return ((struct coda_sb_info *)((sb)->u.generic_sbp));
+    return ((struct coda_sb_info *)((sb)->s_fs_info));
 }
 
 
diff -urN linux-2.5.41/include/linux/cramfs_fs_sb.h linux/include/linux/cramfs_fs_sb.h
--- linux-2.5.41/include/linux/cramfs_fs_sb.h	Sun Sep 15 22:18:25 2002
+++ linux/include/linux/cramfs_fs_sb.h	Mon Oct  7 17:27:58 2002
@@ -14,7 +14,7 @@
 
 static inline struct cramfs_sb_info *CRAMFS_SB(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 
 #endif
diff -urN linux-2.5.41/include/linux/efs_fs.h linux/include/linux/efs_fs.h
--- linux-2.5.41/include/linux/efs_fs.h	Sun Sep 15 22:18:27 2002
+++ linux/include/linux/efs_fs.h	Mon Oct  7 17:27:58 2002
@@ -46,7 +46,7 @@
 
 static inline struct efs_sb_info *SUPER_INFO(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 
 extern struct inode_operations efs_dir_inode_operations;
diff -urN linux-2.5.41/include/linux/ext2_fs.h linux/include/linux/ext2_fs.h
--- linux-2.5.41/include/linux/ext2_fs.h	Sun Sep 15 22:18:21 2002
+++ linux/include/linux/ext2_fs.h	Mon Oct  7 17:27:58 2002
@@ -74,7 +74,7 @@
 #ifdef __KERNEL__
 static inline struct ext2_sb_info *EXT2_SB(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 #else
 /* Assume that user mode programs are passing in an ext2fs superblock, not
diff -urN linux-2.5.41/include/linux/ext3_fs.h linux/include/linux/ext3_fs.h
--- linux-2.5.41/include/linux/ext3_fs.h	Mon Oct  7 15:44:09 2002
+++ linux/include/linux/ext3_fs.h	Mon Oct  7 17:27:58 2002
@@ -447,7 +447,7 @@
 #ifdef __KERNEL__
 static inline struct ext3_sb_info * EXT3_SB(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 static inline struct ext3_inode_info *EXT3_I(struct inode *inode)
 {
diff -urN linux-2.5.41/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.5.41/include/linux/fs.h	Mon Oct  7 15:44:09 2002
+++ linux/include/linux/fs.h	Mon Oct  7 17:27:58 2002
@@ -667,9 +667,8 @@
 
 	char s_id[32];				/* Informational name */
 
-	union {
-		void			*generic_sbp;
-	} u;
+	void 			*s_fs_info;	/* Filesystem private info */
+
 	/*
 	 * The next field is for VFS *only*. No filesystems have any business
 	 * even looking at it. You had been warned.
diff -urN linux-2.5.41/include/linux/hfs_fs.h linux/include/linux/hfs_fs.h
--- linux-2.5.41/include/linux/hfs_fs.h	Sun Sep 15 22:18:45 2002
+++ linux/include/linux/hfs_fs.h	Mon Oct  7 17:27:58 2002
@@ -327,7 +327,7 @@
 
 static inline struct hfs_sb_info *HFS_SB(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 
 static inline void hfs_nameout(struct inode *dir, struct hfs_name *out,
diff -urN linux-2.5.41/include/linux/iso_fs.h linux/include/linux/iso_fs.h
--- linux-2.5.41/include/linux/iso_fs.h	Sun Sep 15 22:18:37 2002
+++ linux/include/linux/iso_fs.h	Mon Oct  7 17:27:58 2002
@@ -174,7 +174,7 @@
 
 static inline struct isofs_sb_info *ISOFS_SB(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 
 static inline struct iso_inode_info *ISOFS_I(struct inode *inode)
diff -urN linux-2.5.41/include/linux/msdos_fs.h linux/include/linux/msdos_fs.h
--- linux-2.5.41/include/linux/msdos_fs.h	Tue Oct  1 19:53:19 2002
+++ linux/include/linux/msdos_fs.h	Mon Oct  7 17:27:58 2002
@@ -193,7 +193,7 @@
 
 static inline struct msdos_sb_info *MSDOS_SB(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 
 static inline struct msdos_inode_info *MSDOS_I(struct inode *inode)
diff -urN linux-2.5.41/include/linux/ncp_fs.h linux/include/linux/ncp_fs.h
--- linux-2.5.41/include/linux/ncp_fs.h	Sun Sep 15 22:18:23 2002
+++ linux/include/linux/ncp_fs.h	Mon Oct  7 17:27:58 2002
@@ -192,7 +192,7 @@
 
 static inline struct ncp_server *NCP_SBP(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 
 #define NCP_SERVER(inode)	NCP_SBP((inode)->i_sb)
diff -urN linux-2.5.41/include/linux/nfs_fs.h linux/include/linux/nfs_fs.h
--- linux-2.5.41/include/linux/nfs_fs.h	Mon Oct  7 15:44:10 2002
+++ linux/include/linux/nfs_fs.h	Mon Oct  7 17:27:58 2002
@@ -192,7 +192,7 @@
 {
 	return container_of(inode, struct nfs_inode, vfs_inode);
 }
-#define NFS_SB(s)		((struct nfs_server *)(s->u.generic_sbp))
+#define NFS_SB(s)		((struct nfs_server *)(s->s_fs_info))
 
 #define NFS_FH(inode)			(&NFS_I(inode)->fh)
 #define NFS_SERVER(inode)		(NFS_SB(inode->i_sb))
diff -urN linux-2.5.41/include/linux/qnx4_fs.h linux/include/linux/qnx4_fs.h
--- linux-2.5.41/include/linux/qnx4_fs.h	Sun Sep 15 22:19:07 2002
+++ linux/include/linux/qnx4_fs.h	Mon Oct  7 17:27:58 2002
@@ -135,7 +135,7 @@
 
 static inline struct qnx4_sb_info *qnx4_sb(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 
 static inline struct qnx4_inode_info *qnx4_i(struct inode *inode)
diff -urN linux-2.5.41/include/linux/reiserfs_fs.h linux/include/linux/reiserfs_fs.h
--- linux-2.5.41/include/linux/reiserfs_fs.h	Mon Oct  7 15:44:10 2002
+++ linux/include/linux/reiserfs_fs.h	Mon Oct  7 17:27:58 2002
@@ -294,7 +294,7 @@
 
 static inline struct reiserfs_sb_info *REISERFS_SB(const struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 
 /** this says about version of key of all items (but stat data) the
diff -urN linux-2.5.41/include/linux/smb_fs.h linux/include/linux/smb_fs.h
--- linux-2.5.41/include/linux/smb_fs.h	Tue Oct  1 19:53:19 2002
+++ linux/include/linux/smb_fs.h	Mon Oct  7 17:27:58 2002
@@ -33,7 +33,7 @@
 
 static inline struct smb_sb_info *SMB_SB(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 
 static inline struct smb_inode_info *SMB_I(struct inode *inode)
diff -urN linux-2.5.41/include/linux/ufs_fs.h linux/include/linux/ufs_fs.h
--- linux-2.5.41/include/linux/ufs_fs.h	Sun Sep 15 22:18:49 2002
+++ linux/include/linux/ufs_fs.h	Mon Oct  7 17:27:58 2002
@@ -785,7 +785,7 @@
 
 static inline struct ufs_sb_info *UFS_SB(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 
 static inline struct ufs_inode_info *UFS_I(struct inode *inode)
diff -urN linux-2.5.41/mm/shmem.c linux/mm/shmem.c
--- linux-2.5.41/mm/shmem.c	Mon Oct  7 15:44:10 2002
+++ linux/mm/shmem.c	Mon Oct  7 17:27:58 2002
@@ -98,7 +98,7 @@
 
 static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
 {
-	return sb->u.generic_sbp;
+	return sb->s_fs_info;
 }
 
 static struct super_operations shmem_ops;
@@ -1595,7 +1595,7 @@
 	sbinfo = kmalloc(sizeof(struct shmem_sb_info), GFP_KERNEL);
 	if (!sbinfo)
 		return -ENOMEM;
-	sb->u.generic_sbp = sbinfo;
+	sb->s_fs_info = sbinfo;
 	memset(sbinfo, 0, sizeof(struct shmem_sb_info));
 
 	/*
@@ -1644,14 +1644,14 @@
 	iput(inode);
 failed:
 	kfree(sbinfo);
-	sb->u.generic_sbp = NULL;
+	sb->s_fs_info = NULL;
 	return err;
 }
 
 static void shmem_put_super(struct super_block *sb)
 {
-	kfree(sb->u.generic_sbp);
-	sb->u.generic_sbp = NULL;
+	kfree(sb->s_fs_info);
+	sb->s_fs_info = NULL;
 }
 
 static kmem_cache_t *shmem_inode_cachep;

--------------070103050600060005040600--

