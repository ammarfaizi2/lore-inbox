Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289182AbSAVHaj>; Tue, 22 Jan 2002 02:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289184AbSAVHab>; Tue, 22 Jan 2002 02:30:31 -0500
Received: from ns.caldera.de ([212.34.180.1]:21376 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S289182AbSAVHaQ>;
	Tue, 22 Jan 2002 02:30:16 -0500
Date: Tue, 22 Jan 2002 08:29:30 +0100
Message-Id: <200201220729.g0M7TU304703@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: viro@math.psu.edu (Alexander Viro)
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.5.3-pre3
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.GSO.4.21.0201212044270.12228-100000@weyl.math.psu.edu>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.21.0201212044270.12228-100000@weyl.math.psu.edu> you wrote:
> BTW, maintainers of filesystems are welcome to send patches.  Stuff in
> ftp.math.psu.edu/pub/viro/MA* should be enough to figure it out - everything
> is fairly straightforward.

sysvfs bits below.

First patchs adds SYSV_I(), second switches to new-style inode
allocation.




diff -uNr -Xdontdiff linux/fs/sysv/ChangeLog linux-SYSV_I/fs/sysv/ChangeLog
--- linux/fs/sysv/ChangeLog	Tue Jan 15 10:59:14 2002
+++ linux-SYSV_I/fs/sysv/ChangeLog	Sat Jan 19 17:15:25 2002
@@ -1,3 +1,16 @@
+Sat Jan 19 2001  Christoph Hellwig  <hch@infradead.org>
+
+	* include/linux/sysv_fs.h: Include <linux/sysv_fs_i.h>, declare SYSV_I().
+	* dir.c (sysv_find_entry): Use SYSV_I() instead of ->u.sysv_i to
+		access fs-private inode data.
+	* ialloc.c (sysv_new_inode): Likewise.
+	* inode.c (sysv_read_inode): Likewise.
+	(sysv_update_inode): Likewise.
+	* itree.c (get_branch): Likewise.
+	(sysv_truncate): Likewise.
+	* symlink.c (sysv_readlink): Likewise.
+	(sysv_follow_link): Likewise.
+
 Fri Jan  4 2001  Alexander Viro  <viro@math.psu.edu>
 
 	* ialloc.c (sysv_free_inode): Use sb->s_id instead of bdevname().
diff -uNr -Xdontdiff linux/fs/sysv/dir.c linux-SYSV_I/fs/sysv/dir.c
--- linux/fs/sysv/dir.c	Tue Jan 15 10:59:14 2002
+++ linux-SYSV_I/fs/sysv/dir.c	Sat Jan 19 17:08:46 2002
@@ -145,7 +145,7 @@
 
 	*res_page = NULL;
 
-	start = dir->u.sysv_i.i_dir_start_lookup;
+	start = SYSV_I(dir)->i_dir_start_lookup;
 	if (start >= npages)
 		start = 0;
 	n = start;
@@ -174,7 +174,7 @@
 	return NULL;
 
 found:
-	dir->u.sysv_i.i_dir_start_lookup = n;
+	SYSV_I(dir)->i_dir_start_lookup = n;
 	*res_page = page;
 	return de;
 }
diff -uNr -Xdontdiff linux/fs/sysv/ialloc.c linux-SYSV_I/fs/sysv/ialloc.c
--- linux/fs/sysv/ialloc.c	Tue Jan 15 10:59:14 2002
+++ linux-SYSV_I/fs/sysv/ialloc.c	Sat Jan 19 17:08:46 2002
@@ -165,7 +165,7 @@
 	inode->i_ino = fs16_to_cpu(sb, ino);
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_blocks = inode->i_blksize = 0;
-	inode->u.sysv_i.i_dir_start_lookup = 0;
+	SYSV_I(inode)->i_dir_start_lookup = 0;
 	insert_inode_hash(inode);
 	mark_inode_dirty(inode);
 
diff -uNr -Xdontdiff linux/fs/sysv/inode.c linux-SYSV_I/fs/sysv/inode.c
--- linux/fs/sysv/inode.c	Tue Jan 15 10:59:14 2002
+++ linux-SYSV_I/fs/sysv/inode.c	Sat Jan 19 17:08:46 2002
@@ -144,6 +144,7 @@
 	struct super_block * sb = inode->i_sb;
 	struct buffer_head * bh;
 	struct sysv_inode * raw_inode;
+	struct sysv_inode_info * si;
 	unsigned int block, ino;
 	dev_t rdev = 0;
 
@@ -169,13 +170,15 @@
 	inode->i_mtime = fs32_to_cpu(sb, raw_inode->i_mtime);
 	inode->i_ctime = fs32_to_cpu(sb, raw_inode->i_ctime);
 	inode->i_blocks = inode->i_blksize = 0;
+
+	si = SYSV_I(inode);
 	for (block = 0; block < 10+1+1+1; block++)
 		read3byte(sb, &raw_inode->i_a.i_addb[3*block],
-			(unsigned char*)&inode->u.sysv_i.i_data[block]);
+			(unsigned char*)&si->i_data[block]);
 	brelse(bh);
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
-		rdev = (u16)fs32_to_cpu(sb, inode->u.sysv_i.i_data[0]);
-	inode->u.sysv_i.i_dir_start_lookup = 0;
+		rdev = (u16)fs32_to_cpu(sb, si->i_data[0]);
+	si->i_dir_start_lookup = 0;
 	sysv_set_inode(inode, rdev);
 	return;
 
@@ -189,6 +192,7 @@
 	struct super_block * sb = inode->i_sb;
 	struct buffer_head * bh;
 	struct sysv_inode * raw_inode;
+	struct sysv_inode_info * si;
 	unsigned int ino, block;
 
 	ino = inode->i_ino;
@@ -211,11 +215,12 @@
 	raw_inode->i_atime = cpu_to_fs32(sb, inode->i_atime);
 	raw_inode->i_mtime = cpu_to_fs32(sb, inode->i_mtime);
 	raw_inode->i_ctime = cpu_to_fs32(sb, inode->i_ctime);
+
+	si = SYSV_I(inode);
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
-		inode->u.sysv_i.i_data[0] = 
-			cpu_to_fs32(sb, kdev_t_to_nr(inode->i_rdev));
+		si->i_data[0] = cpu_to_fs32(sb, kdev_t_to_nr(inode->i_rdev));
 	for (block = 0; block < 10+1+1+1; block++)
-		write3byte(sb, (unsigned char*)&inode->u.sysv_i.i_data[block],
+		write3byte(sb, (unsigned char*)&si->i_data[block],
 			&raw_inode->i_a.i_addb[3*block]);
 	mark_buffer_dirty(bh);
 	return bh;
diff -uNr -Xdontdiff linux/fs/sysv/itree.c linux-SYSV_I/fs/sysv/itree.c
--- linux/fs/sysv/itree.c	Tue Jan 15 10:59:14 2002
+++ linux-SYSV_I/fs/sysv/itree.c	Sat Jan 19 17:08:46 2002
@@ -91,7 +91,7 @@
 	struct buffer_head *bh;
 
 	*err = 0;
-	add_chain (chain, NULL, inode->u.sysv_i.i_data + *offsets);
+	add_chain (chain, NULL, SYSV_I(inode)->i_data + *offsets);
 	if (!p->key)
 		goto no_block;
 	while (--depth) {
@@ -348,7 +348,7 @@
 
 void sysv_truncate (struct inode * inode)
 {
-	u32 *i_data = inode->u.sysv_i.i_data;
+	u32 *i_data = SYSV_I(inode)->i_data;
 	int offsets[DEPTH];
 	Indirect chain[DEPTH];
 	Indirect *partial;
diff -uNr -Xdontdiff linux/fs/sysv/symlink.c linux-SYSV_I/fs/sysv/symlink.c
--- linux/fs/sysv/symlink.c	Sun Sep  2 19:34:36 2001
+++ linux-SYSV_I/fs/sysv/symlink.c	Sat Jan 19 17:21:36 2002
@@ -6,16 +6,17 @@
  */
 
 #include <linux/fs.h>
+#include <linux/sysv_fs.h>
 
 static int sysv_readlink(struct dentry *dentry, char *buffer, int buflen)
 {
-	char *s = (char *)dentry->d_inode->u.sysv_i.i_data;
+	char *s = (char *)SYSV_I(dentry->d_inode)->i_data;
 	return vfs_readlink(dentry, buffer, buflen, s);
 }
 
 static int sysv_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
-	char *s = (char *)dentry->d_inode->u.sysv_i.i_data;
+	char *s = (char *)SYSV_I(dentry->d_inode)->i_data;
 	return vfs_follow_link(nd, s);
 }
 
diff -uNr -Xdontdiff linux/include/linux/sysv_fs.h linux-SYSV_I/include/linux/sysv_fs.h
--- linux/include/linux/sysv_fs.h	Fri Nov  9 22:45:35 2001
+++ linux-SYSV_I/include/linux/sysv_fs.h	Sat Jan 19 17:21:16 2002
@@ -21,6 +21,14 @@
 #include <linux/sched.h>	/* declares wake_up() */
 #include <linux/sysv_fs_sb.h>	/* defines the sv_... shortcuts */
 
+/* temporary hack. */
+#include <linux/sysv_fs_i.h>
+static inline struct sysv_inode_info *SYSV_I(struct inode *inode)
+{
+	return &inode->u.sysv_i;
+}
+/* end temporary hack. */
+
 
 /* Layout on disk */
 /* ============== */



diff -uNr -Xdontdiff linux-SYSV_I/fs/sysv/ChangeLog linux-sysv_inode_cache/fs/sysv/ChangeLog
--- linux-SYSV_I/fs/sysv/ChangeLog	Sat Jan 19 17:15:25 2002
+++ linux-sysv_inode_cache/fs/sysv/ChangeLog	Sat Jan 19 17:50:00 2002
@@ -1,5 +1,17 @@
 Sat Jan 19 2001  Christoph Hellwig  <hch@infradead.org>
 
+	* include/linux/sysv_fs.h (SYSV_I): Get fs-private inode data using
+		list_entry() instead of inode->u.
+	* include/linux/sysv_fs_i.h: Add 'struct inode  i_vnode' field to
+		sysv_inode_info structure.
+	* inode.c: Include <linux/slab.h>, implement alloc_inode/destroy_inode
+		sop methods, add infrastructure for per-fs inode slab cache.
+	* super.c (init_sysv_fs): Initialize inode cache, recover properly
+		in the case of failed register_filesystem for V7.
+	(exit_sysv_fs): Destroy inode cache.
+
+Sat Jan 19 2001  Christoph Hellwig  <hch@infradead.org>
+
 	* include/linux/sysv_fs.h: Include <linux/sysv_fs_i.h>, declare SYSV_I().
 	* dir.c (sysv_find_entry): Use SYSV_I() instead of ->u.sysv_i to
 		access fs-private inode data.
diff -uNr -Xdontdiff linux-SYSV_I/fs/sysv/inode.c linux-sysv_inode_cache/fs/sysv/inode.c
--- linux-SYSV_I/fs/sysv/inode.c	Sat Jan 19 17:08:46 2002
+++ linux-sysv_inode_cache/fs/sysv/inode.c	Sat Jan 19 17:43:40 2002
@@ -26,6 +26,7 @@
 #include <linux/locks.h>
 #include <linux/smp_lock.h>
 #include <linux/highuid.h>
+#include <linux/slab.h>
 #include <asm/byteorder.h>
 
 /* This is only called on sync() and umount(), when s_dirt=1. */
@@ -265,7 +266,35 @@
 	unlock_kernel();
 }
 
+static kmem_cache_t *sysv_inode_cachep;
+
+static struct inode *sysv_alloc_inode(struct super_block *sb)
+{
+	struct sysv_inode_info *si;
+
+	si = kmem_cache_alloc(sysv_inode_cachep, SLAB_KERNEL);
+	if (!si)
+		return NULL;
+	return &si->i_vnode;
+}
+
+static void sysv_destroy_inode(struct inode *inode)
+{
+	kmem_cache_free(sysv_inode_cachep, SYSV_I(inode));
+}
+
+static void init_once(void *p, kmem_cache_t *cachep, unsigned long flags)
+{
+	struct sysv_inode_info *si = (struct sysv_inode_info *)p;
+
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
+			SLAB_CTOR_CONSTRUCTOR)
+		inode_init_once(&si->i_vnode);
+}
+
 struct super_operations sysv_sops = {
+	alloc_inode:	sysv_alloc_inode,
+	destroy_inode:	sysv_destroy_inode,
 	read_inode:	sysv_read_inode,
 	write_inode:	sysv_write_inode,
 	delete_inode:	sysv_delete_inode,
@@ -273,3 +302,18 @@
 	write_super:	sysv_write_super,
 	statfs:		sysv_statfs,
 };
+
+int __init sysv_init_icache(void)
+{
+	sysv_inode_cachep = kmem_cache_create("sysv_inode_cache",
+			sizeof(struct sysv_inode_info), 0,
+			SLAB_HWCACHE_ALIGN, init_once, NULL);
+	if (!sysv_inode_cachep)
+		return -ENOMEM;
+	return 0;
+}
+
+void sysv_destroy_icache(void)
+{
+	kmem_cache_destroy(sysv_inode_cachep);
+}
diff -uNr -Xdontdiff linux-SYSV_I/fs/sysv/super.c linux-sysv_inode_cache/fs/sysv/super.c
--- linux-SYSV_I/fs/sysv/super.c	Tue Jan 15 10:59:14 2002
+++ linux-sysv_inode_cache/fs/sysv/super.c	Sat Jan 19 17:37:13 2002
@@ -479,18 +479,37 @@
 static DECLARE_FSTYPE_DEV(sysv_fs_type, "sysv", sysv_read_super);
 static DECLARE_FSTYPE_DEV(v7_fs_type, "v7", v7_read_super);
 
+extern int sysv_init_icache(void) __init;
+extern void sysv_destroy_icache(void);
+
 static int __init init_sysv_fs(void)
 {
-	int err = register_filesystem(&sysv_fs_type);
-	if (!err)
-		err = register_filesystem(&v7_fs_type);
-	return err;
+	int error;
+
+	error = sysv_init_icache();
+	if (error)
+		goto out;
+	error = register_filesystem(&sysv_fs_type);
+	if (error)
+		goto destroy_icache;
+	error = register_filesystem(&v7_fs_type);
+	if (error)
+		goto unregister;
+	return 0;
+
+unregister:
+	unregister_filesystem(&sysv_fs_type);
+destroy_icache:
+	sysv_destroy_icache();
+out:
+	return error;
 }
 
 static void __exit exit_sysv_fs(void)
 {
 	unregister_filesystem(&sysv_fs_type);
 	unregister_filesystem(&v7_fs_type);
+	sysv_destroy_icache();
 }
 
 EXPORT_NO_SYMBOLS;
diff -uNr -Xdontdiff linux-SYSV_I/include/linux/fs.h linux-sysv_inode_cache/include/linux/fs.h
--- linux-SYSV_I/include/linux/fs.h	Sat Jan 19 17:16:22 2002
+++ linux-sysv_inode_cache/include/linux/fs.h	Sat Jan 19 17:37:37 2002
@@ -292,7 +292,6 @@
 #include <linux/msdos_fs_i.h>
 #include <linux/umsdos_fs_i.h>
 #include <linux/iso_fs_i.h>
-#include <linux/sysv_fs_i.h>
 #include <linux/romfs_fs_i.h>
 #include <linux/smb_fs_i.h>
 #include <linux/hfs_fs_i.h>
@@ -471,7 +470,6 @@
 		struct msdos_inode_info		msdos_i;
 		struct umsdos_inode_info	umsdos_i;
 		struct iso_inode_info		isofs_i;
-		struct sysv_inode_info		sysv_i;
 		struct romfs_inode_info		romfs_i;
 		struct smb_inode_info		smbfs_i;
 		struct hfs_inode_info		hfs_i;
diff -uNr -Xdontdiff linux-SYSV_I/include/linux/sysv_fs.h linux-sysv_inode_cache/include/linux/sysv_fs.h
--- linux-SYSV_I/include/linux/sysv_fs.h	Sat Jan 19 17:21:16 2002
+++ linux-sysv_inode_cache/include/linux/sysv_fs.h	Sat Jan 19 17:41:21 2002
@@ -25,7 +25,8 @@
 #include <linux/sysv_fs_i.h>
 static inline struct sysv_inode_info *SYSV_I(struct inode *inode)
 {
-	return &inode->u.sysv_i;
+	/* I think list_entry should have a more descriptive name..  --hch */
+	return list_entry(inode, struct sysv_inode_info, i_vnode);
 }
 /* end temporary hack. */
 
diff -uNr -Xdontdiff linux-SYSV_I/include/linux/sysv_fs_i.h linux-sysv_inode_cache/include/linux/sysv_fs_i.h
--- linux-SYSV_I/include/linux/sysv_fs_i.h	Fri Nov  9 22:45:35 2001
+++ linux-sysv_inode_cache/include/linux/sysv_fs_i.h	Sat Jan 19 17:39:56 2002
@@ -11,6 +11,7 @@
 				 * then 1 triple indirection block.
 				 */
 	u32 i_dir_start_lookup;
+	struct inode  i_vnode;	/* VFS inode */
 };
 
 #endif

