Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSGCBX7>; Tue, 2 Jul 2002 21:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSGCBX6>; Tue, 2 Jul 2002 21:23:58 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:20493 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S311025AbSGCBXq>; Tue, 2 Jul 2002 21:23:46 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: viro@math.psu.edu, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
cc: pmenage@ensim.com
Subject: [PATCH] Shift BKL into ->statfs()
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Jul 2002 18:25:47 -0700
Message-Id: <E17PYtv-0004Fd-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes BKL protection from the invocation of the
super_operations ->statfs() method, and shifts it into the filesystems
where necessary. Any out-of-tree filesystems may need to take the BKL in
their statfs() methods if they were relying on it for synchronisation.

All ->statfs() implementations have been modified to take the BKL,
except for the following, which don't reference any external mutable
data:

simple_statfs
isofs_statfs
ncp_statfs
cramfs_statfs
romfs_statfs

Additionally, capifs is changed to use simple_statfs rather than its 
own home-grown version.


All modified filesystems have been compiled except for the disabled
umsdos; only ext2 and shmfs have actually been tested.

Paul


diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/Documentation/filesystems/Locking linux-2.5.24-statfs/Documentation/filesystems/Locking
--- linux-2.5.24/Documentation/filesystems/Locking	Tue Jun 18 19:11:52 2002
+++ linux-2.5.24-statfs/Documentation/filesystems/Locking	Wed Jun 26 01:41:08 2002
@@ -108,7 +108,7 @@
 clear_inode:	no	
 put_super:	yes	yes	maybe		(see below)
 write_super:	no	yes	maybe		(see below)
-statfs:		yes	no	no
+statfs:		no	no	no
 remount_fs:	yes	yes	maybe		(see below)
 umount_begin:	yes	no	maybe		(see below)
 
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/Documentation/filesystems/porting linux-2.5.24-statfs/Documentation/filesystems/porting
--- linux-2.5.24/Documentation/filesystems/porting	Tue Jun 18 19:11:51 2002
+++ linux-2.5.24-statfs/Documentation/filesystems/porting	Wed Jun 26 01:41:08 2002
@@ -91,9 +91,10 @@
 ---
 [mandatory]
 
-BKL is also moved from around sb operations.  ->write_super() Is now called 
-without BKL held.  BKL should have been shifted into individual fs sb_op
-functions.  If you don't need it, remove it.  
+BKL is also moved from around sb operations.  ->write_super() and
+->statfs() are now called without BKL held.  BKL should have been
+shifted into individual fs sb_op functions.  If you don't need it,
+remove it.
 
 ---
 [informational]
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/drivers/isdn/capi/capifs.c linux-2.5.24-statfs/drivers/isdn/capi/capifs.c
--- linux-2.5.24/drivers/isdn/capi/capifs.c	Tue Jun 18 19:11:50 2002
+++ linux-2.5.24-statfs/drivers/isdn/capi/capifs.c	Wed Jun 26 01:41:08 2002
@@ -221,11 +221,9 @@
 	kfree(sbi);
 }
 
-static int capifs_statfs(struct super_block *sb, struct statfs *buf);
-
 static struct super_operations capifs_sops = {
 	put_super:	capifs_put_super,
-	statfs:		capifs_statfs,
+	statfs:		simple_statfs,
 };
 
 static int capifs_parse_options(char *options, struct capifs_sb_info *sbi)
@@ -354,19 +352,6 @@
 	return -EINVAL;
 }
 
-static int capifs_statfs(struct super_block *sb, struct statfs *buf)
-{
-	buf->f_type = CAPIFS_SUPER_MAGIC;
-	buf->f_bsize = 1024;
-	buf->f_blocks = 0;
-	buf->f_bfree = 0;
-	buf->f_bavail = 0;
-	buf->f_files = 0;
-	buf->f_ffree = 0;
-	buf->f_namelen = NAME_MAX;
-	return 0;
-}
-
 static struct inode *capifs_new_inode(struct super_block *sb)
 {
 	struct inode *inode = new_inode(sb);
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/adfs/super.c linux-2.5.24-statfs/fs/adfs/super.c
--- linux-2.5.24/fs/adfs/super.c	Tue Jun 18 19:11:45 2002
+++ linux-2.5.24-statfs/fs/adfs/super.c	Wed Jun 26 01:41:08 2002
@@ -18,6 +18,7 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/buffer_head.h>
+#include <linux/smp_lock.h>
 
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
@@ -192,6 +193,8 @@
 {
 	struct adfs_sb_info *asb = ADFS_SB(sb);
 
+	lock_kernel();
+
 	buf->f_type    = ADFS_SUPER_MAGIC;
 	buf->f_namelen = asb->s_namelen;
 	buf->f_bsize   = sb->s_blocksize;
@@ -201,6 +204,8 @@
 	buf->f_bfree   = adfs_map_free(sb);
 	buf->f_ffree   = buf->f_bfree * buf->f_files / buf->f_blocks;
 
+	unlock_kernel();
+
 	return 0;
 }
 
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/affs/super.c linux-2.5.24-statfs/fs/affs/super.c
--- linux-2.5.24/fs/affs/super.c	Tue Jun 18 19:11:57 2002
+++ linux-2.5.24-statfs/fs/affs/super.c	Wed Jun 26 01:41:08 2002
@@ -531,6 +531,8 @@
 {
 	int		 free;
 
+	lock_kernel();
+
 	pr_debug("AFFS: statfs() partsize=%d, reserved=%d\n",AFFS_SB(sb)->s_partition_size,
 	     AFFS_SB(sb)->s_reserved);
 
@@ -540,6 +542,9 @@
 	buf->f_blocks  = AFFS_SB(sb)->s_partition_size - AFFS_SB(sb)->s_reserved;
 	buf->f_bfree   = free;
 	buf->f_bavail  = free;
+
+	unlock_kernel();
+
 	return 0;
 }
 
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/bfs/inode.c linux-2.5.24-statfs/fs/bfs/inode.c
--- linux-2.5.24/fs/bfs/inode.c	Tue Jun 18 19:11:53 2002
+++ linux-2.5.24-statfs/fs/bfs/inode.c	Wed Jun 26 01:41:08 2002
@@ -190,6 +190,9 @@
 static int bfs_statfs(struct super_block *s, struct statfs *buf)
 {
 	struct bfs_sb_info *info = BFS_SB(s);
+
+	lock_kernel();
+
 	buf->f_type = BFS_MAGIC;
 	buf->f_bsize = s->s_blocksize;
 	buf->f_blocks = info->si_blocks;
@@ -198,6 +201,9 @@
 	buf->f_ffree = info->si_freei;
 	buf->f_fsid.val[0] = s->s_dev;
 	buf->f_namelen = BFS_NAMELEN;
+
+	unlock_kernel();
+
 	return 0;
 }
 
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/coda/inode.c linux-2.5.24-statfs/fs/coda/inode.c
--- linux-2.5.24/fs/coda/inode.c	Tue Jun 18 19:11:55 2002
+++ linux-2.5.24-statfs/fs/coda/inode.c	Wed Jun 26 01:41:08 2002
@@ -281,9 +281,13 @@
 static int coda_statfs(struct super_block *sb, struct statfs *buf)
 {
 	int error;
+	
+	lock_kernel();
 
 	error = venus_statfs(sb, buf);
 
+	unlock_kernel();
+
 	if (error) {
 		/* fake something like AFS does */
 		buf->f_blocks = 9000000;
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/efs/super.c linux-2.5.24-statfs/fs/efs/super.c
--- linux-2.5.24/fs/efs/super.c	Tue Jun 18 19:11:50 2002
+++ linux-2.5.24-statfs/fs/efs/super.c	Wed Jun 26 01:41:08 2002
@@ -13,6 +13,7 @@
 #include <linux/efs_fs_sb.h>
 #include <linux/slab.h>
 #include <linux/buffer_head.h>
+#include <linux/smp_lock.h>
 
 static struct super_block *efs_get_sb(struct file_system_type *fs_type,
 	int flags, char *dev_name, void *data)
@@ -280,6 +281,8 @@
 int efs_statfs(struct super_block *s, struct statfs *buf) {
 	struct efs_sb_info *sb = SUPER_INFO(s);
 
+	lock_kernel();
+
 	buf->f_type    = EFS_SUPER_MAGIC;	/* efs magic number */
 	buf->f_bsize   = EFS_BLOCKSIZE;		/* blocksize */
 	buf->f_blocks  = sb->total_groups *	/* total data blocks */
@@ -294,6 +297,8 @@
 	buf->f_fsid.val[1] =  sb->fs_magic        & 0xffff; /* fs ID */
 	buf->f_namelen = EFS_MAXNAMELEN;	/* max filename length */
 
+	unlock_kernel();
+
 	return 0;
 }
 
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/ext2/super.c linux-2.5.24-statfs/fs/ext2/super.c
--- linux-2.5.24/fs/ext2/super.c	Wed Jun 26 01:07:20 2002
+++ linux-2.5.24-statfs/fs/ext2/super.c	Wed Jun 26 01:41:08 2002
@@ -835,6 +835,8 @@
 	unsigned long overhead;
 	int i;
 
+	lock_kernel();
+
 	if (test_opt (sb, MINIX_DF))
 		overhead = 0;
 	else {
@@ -875,6 +877,9 @@
 	buf->f_files = le32_to_cpu(sbi->s_es->s_inodes_count);
 	buf->f_ffree = ext2_count_free_inodes (sb);
 	buf->f_namelen = EXT2_NAME_LEN;
+
+	unlock_kernel();
+
 	return 0;
 }
 
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/ext3/super.c linux-2.5.24-statfs/fs/ext3/super.c
--- linux-2.5.24/fs/ext3/super.c	Tue Jun 18 19:11:58 2002
+++ linux-2.5.24-statfs/fs/ext3/super.c	Wed Jun 26 01:41:08 2002
@@ -504,7 +504,7 @@
 	write_super:	ext3_write_super,	/* BKL not held. We take it. Needed? */
 	write_super_lockfs: ext3_write_super_lockfs, /* BKL not held. Take it */
 	unlockfs:	ext3_unlockfs,		/* BKL not held.  We take it */
-	statfs:		ext3_statfs,		/* BKL held */
+	statfs:		ext3_statfs,		/* BKL not held.  We take it. Needed? */
 	remount_fs:	ext3_remount,		/* BKL held */
 };
 
@@ -1732,6 +1732,8 @@
 	unsigned long overhead;
 	int i;
 
+	lock_kernel();
+
 	if (test_opt (sb, MINIX_DF))
 		overhead = 0;
 	else {
@@ -1772,6 +1774,8 @@
 	buf->f_files = le32_to_cpu(es->s_inodes_count);
 	buf->f_ffree = ext3_count_free_inodes (sb);
 	buf->f_namelen = EXT3_NAME_LEN;
+
+	unlock_kernel();
 	return 0;
 }
 
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/fat/inode.c linux-2.5.24-statfs/fs/fat/inode.c
--- linux-2.5.24/fs/fat/inode.c	Tue Jun 18 19:11:54 2002
+++ linux-2.5.24-statfs/fs/fat/inode.c	Wed Jun 26 01:41:08 2002
@@ -934,11 +934,15 @@
 int fat_statfs(struct super_block *sb,struct statfs *buf)
 {
 	int free,nr;
-       
+	int ret = 0;
+        
+	lock_kernel();
 	if (MSDOS_SB(sb)->cvf_format &&
-	    MSDOS_SB(sb)->cvf_format->cvf_statfs)
-		return MSDOS_SB(sb)->cvf_format->cvf_statfs(sb,buf,
+	    MSDOS_SB(sb)->cvf_format->cvf_statfs) {
+		ret = MSDOS_SB(sb)->cvf_format->cvf_statfs(sb,buf,
 						sizeof(struct statfs));
+		goto out;
+	}
 	  
 	lock_fat(sb);
 	if (MSDOS_SB(sb)->free_clusters != -1)
@@ -959,7 +963,9 @@
 	buf->f_bavail = free;
 	buf->f_namelen = MSDOS_SB(sb)->options.isvfat ? 260 : 12;
 
-	return 0;
+ out:
+	unlock_kernel();
+	return ret;
 }
 
 static int is_exec(char *extension)
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/freevxfs/vxfs_super.c linux-2.5.24-statfs/fs/freevxfs/vxfs_super.c
--- linux-2.5.24/fs/freevxfs/vxfs_super.c	Tue Jun 18 19:11:51 2002
+++ linux-2.5.24-statfs/fs/freevxfs/vxfs_super.c	Wed Jun 26 01:41:08 2002
@@ -41,6 +41,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
+#include <linux/smp_lock.h>
 
 #include "vxfs.h"
 #include "vxfs_extern.h"
@@ -98,7 +99,7 @@
  *   Zero.
  *
  * Locking:
- *   We are under bkl and @sbp->s_lock.
+ *   We are under @sbp->s_lock.
  *
  * Notes:
  *   This is everything but complete...
@@ -108,6 +109,8 @@
 {
 	struct vxfs_sb_info		*infp = VXFS_SBI(sbp);
 
+	lock_kernel();
+
 	bufp->f_type = VXFS_SUPER_MAGIC;
 	bufp->f_bsize = sbp->s_blocksize;
 	bufp->f_blocks = infp->vsi_raw->vs_dsize;
@@ -117,6 +120,8 @@
 	bufp->f_ffree = infp->vsi_raw->vs_ifree;
 	bufp->f_namelen = VXFS_NAMELEN;
 
+	unlock_kernel();
+
 	return 0;
 }
 
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/hfs/super.c linux-2.5.24-statfs/fs/hfs/super.c
--- linux-2.5.24/fs/hfs/super.c	Tue Jun 18 19:11:52 2002
+++ linux-2.5.24-statfs/fs/hfs/super.c	Wed Jun 26 01:41:08 2002
@@ -198,6 +198,8 @@
 {
 	struct hfs_mdb *mdb = HFS_SB(sb)->s_mdb;
 
+	lock_kernel();
+
 	buf->f_type = HFS_SUPER_MAGIC;
 	buf->f_bsize = HFS_SECTOR_SIZE;
 	buf->f_blocks = mdb->alloc_blksz * mdb->fs_ablocks;
@@ -207,6 +209,8 @@
 	buf->f_ffree = mdb->free_ablocks;
 	buf->f_namelen = HFS_NAMELEN;
 
+	unlock_kernel();
+
 	return 0;
 }
 
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/hpfs/super.c linux-2.5.24-statfs/fs/hpfs/super.c
--- linux-2.5.24/fs/hpfs/super.c	Tue Jun 18 19:11:56 2002
+++ linux-2.5.24-statfs/fs/hpfs/super.c	Tue Jul  2 16:51:50 2002
@@ -134,6 +134,8 @@
 
 int hpfs_statfs(struct super_block *s, struct statfs *buf)
 {
+	lock_kernel();
+
 	/*if (s->s_hpfs_n_free == -1) {*/
 		s->s_hpfs_n_free = count_bitmaps(s);
 		s->s_hpfs_n_free_dnodes = hpfs_count_one_bitmap(s, s->s_hpfs_dmap);
@@ -146,6 +148,8 @@
 	buf->f_files = s->s_hpfs_dirband_size / 4;
 	buf->f_ffree = s->s_hpfs_n_free_dnodes;
 	buf->f_namelen = 254;
+
+	unlock_kernel();
 	return 0;
 }
 
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/jffs/inode-v23.c linux-2.5.24-statfs/fs/jffs/inode-v23.c
--- linux-2.5.24/fs/jffs/inode-v23.c	Tue Jun 18 19:11:56 2002
+++ linux-2.5.24-statfs/fs/jffs/inode-v23.c	Wed Jun 26 01:41:08 2002
@@ -383,7 +383,11 @@
 jffs_statfs(struct super_block *sb, struct statfs *buf)
 {
 	struct jffs_control *c = (struct jffs_control *) sb->u.generic_sbp;
-	struct jffs_fmcontrol *fmc = c->fmc;
+	struct jffs_fmcontrol *fmc;
+
+	lock_kernel();
+
+	fmc = c->fmc;
 
 	D2(printk("jffs_statfs()\n"));
 
@@ -401,6 +405,9 @@
 	buf->f_ffree = buf->f_bfree;
 	/* buf->f_fsid = 0; */
 	buf->f_namelen = JFFS_MAX_NAME_LEN;
+
+	unlock_kernel();
+
 	return 0;
 }
 
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/jffs2/fs.c linux-2.5.24-statfs/fs/jffs2/fs.c
--- linux-2.5.24/fs/jffs2/fs.c	Tue Jun 18 19:11:53 2002
+++ linux-2.5.24-statfs/fs/jffs2/fs.c	Wed Jun 26 01:41:08 2002
@@ -52,6 +52,8 @@
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
 	unsigned long avail;
 
+	lock_kernel();
+
 	buf->f_type = JFFS2_SUPER_MAGIC;
 	buf->f_bsize = 1 << PAGE_SHIFT;
 	buf->f_blocks = c->flash_size >> PAGE_SHIFT;
@@ -184,6 +186,7 @@
 
 	spin_unlock_bh(&c->erase_completion_lock);
 
+	unlock_kernel();
 
 	return 0;
 }
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/jfs/super.c linux-2.5.24-statfs/fs/jfs/super.c
--- linux-2.5.24/fs/jfs/super.c	Wed Jun 26 01:07:20 2002
+++ linux-2.5.24-statfs/fs/jfs/super.c	Wed Jun 26 01:41:08 2002
@@ -21,6 +21,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/completion.h>
+#include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
@@ -96,7 +97,11 @@
 {
 	struct jfs_sb_info *sbi = JFS_SBI(sb);
 	s64 maxinodes;
-	imap_t *imap = JFS_IP(sbi->ipimap)->i_imap;
+	imap_t *imap;
+
+	lock_kernel();
+
+	imap = JFS_IP(sbi->ipimap)->i_imap;
 
 	jFYI(1, ("In jfs_statfs\n"));
 	buf->f_type = JFS_SUPER_MAGIC;
@@ -121,6 +126,9 @@
 				    atomic_read(&imap->im_numfree));
 
 	buf->f_namelen = JFS_NAME_MAX;
+
+	unlock_kernel();
+
 	return 0;
 }
 
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/minix/inode.c linux-2.5.24-statfs/fs/minix/inode.c
--- linux-2.5.24/fs/minix/inode.c	Tue Jun 18 19:11:55 2002
+++ linux-2.5.24-statfs/fs/minix/inode.c	Wed Jun 26 01:41:08 2002
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/highuid.h>
+#include <linux/smp_lock.h>
 
 static void minix_read_inode(struct inode * inode);
 static void minix_write_inode(struct inode * inode, int wait);
@@ -296,6 +297,9 @@
 static int minix_statfs(struct super_block *sb, struct statfs *buf)
 {
 	struct minix_sb_info *sbi = minix_sb(sb);
+
+	lock_kernel();
+
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = sb->s_blocksize;
 	buf->f_blocks = (sbi->s_nzones - sbi->s_firstdatazone) << sbi->s_log_zone_size;
@@ -304,6 +308,9 @@
 	buf->f_files = sbi->s_ninodes;
 	buf->f_ffree = minix_count_free_inodes(sbi);
 	buf->f_namelen = sbi->s_namelen;
+
+	unlock_kernel();
+
 	return 0;
 }
 
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/nfs/inode.c linux-2.5.24-statfs/fs/nfs/inode.c
--- linux-2.5.24/fs/nfs/inode.c	Tue Jun 18 19:11:57 2002
+++ linux-2.5.24-statfs/fs/nfs/inode.c	Wed Jun 26 01:41:08 2002
@@ -474,6 +474,8 @@
 	struct nfs_fsinfo res;
 	int error;
 
+	lock_kernel();
+
 	error = server->rpc_ops->statfs(server, NFS_FH(sb->s_root->d_inode), &res);
 	buf->f_type = NFS_SUPER_MAGIC;
 	if (error < 0)
@@ -491,11 +493,16 @@
 	if (res.namelen == 0 || res.namelen > server->namelen)
 		res.namelen = server->namelen;
 	buf->f_namelen = res.namelen;
+
+ out:
+	unlock_kernel();
 	return 0;
+
  out_err:
-	printk("nfs_statfs: statfs error = %d\n", -error);
+	printk(KERN_WARNING "nfs_statfs: statfs error = %d\n", -error);
 	buf->f_bsize = buf->f_blocks = buf->f_bfree = buf->f_bavail = -1;
-	return 0;
+	goto out;
+
 }
 
 static int nfs_show_options(struct seq_file *m, struct vfsmount *mnt)
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/ntfs/super.c linux-2.5.24-statfs/fs/ntfs/super.c
--- linux-2.5.24/fs/ntfs/super.c	Wed Jun 26 01:07:20 2002
+++ linux-2.5.24-statfs/fs/ntfs/super.c	Tue Jul  2 16:52:35 2002
@@ -27,6 +27,7 @@
 #include <linux/blkdev.h>	/* For bdev_hardsect_size(). */
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>
+#include <linux/smp_lock.h>
 
 #include "ntfs.h"
 #include "sysctl.h"
@@ -1334,6 +1335,8 @@
 {
 	ntfs_volume *vol = NTFS_SB(sb);
 	s64 size;
+	
+	lock_kernel();
 
 	ntfs_debug("Entering.");
 	/* Type of filesystem. */
@@ -1372,6 +1375,9 @@
 	sfs->f_fsid.val[1] = (vol->serial_no >> 32) & 0xffffffff;
 	/* Maximum length of filenames. */
 	sfs->f_namelen	   = NTFS_MAX_NAME_LEN;
+
+	unlock_kernel();
+
 	return 0;
 }
 
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/open.c linux-2.5.24-statfs/fs/open.c
--- linux-2.5.24/fs/open.c	Tue Jun 18 19:11:46 2002
+++ linux-2.5.24-statfs/fs/open.c	Wed Jun 26 01:41:08 2002
@@ -30,9 +30,7 @@
 		retval = -ENOSYS;
 		if (sb->s_op && sb->s_op->statfs) {
 			memset(buf, 0, sizeof(struct statfs));
-			lock_kernel();
 			retval = sb->s_op->statfs(sb, buf);
-			unlock_kernel();
 		}
 	}
 	return retval;
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/qnx4/inode.c linux-2.5.24-statfs/fs/qnx4/inode.c
--- linux-2.5.24/fs/qnx4/inode.c	Tue Jun 18 19:11:52 2002
+++ linux-2.5.24-statfs/fs/qnx4/inode.c	Wed Jun 26 01:41:08 2002
@@ -281,6 +281,8 @@
 
 static int qnx4_statfs(struct super_block *sb, struct statfs *buf)
 {
+	lock_kernel();
+
 	buf->f_type    = sb->s_magic;
 	buf->f_bsize   = sb->s_blocksize;
 	buf->f_blocks  = le32_to_cpu(qnx4_sb(sb)->BitMap->di_size) * 8;
@@ -288,6 +290,7 @@
 	buf->f_bavail  = buf->f_bfree;
 	buf->f_namelen = QNX4_NAME_MAX;
 
+	unlock_kernel();
 	return 0;
 }
 
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/reiserfs/super.c linux-2.5.24-statfs/fs/reiserfs/super.c
--- linux-2.5.24/fs/reiserfs/super.c	Tue Jun 18 19:11:54 2002
+++ linux-2.5.24-statfs/fs/reiserfs/super.c	Wed Jun 26 01:41:08 2002
@@ -1257,6 +1257,8 @@
 {
   struct reiserfs_super_block * rs = SB_DISK_SUPER_BLOCK (s);
   
+  lock_kernel();
+
   buf->f_namelen = (REISERFS_MAX_NAME (s->s_blocksize));
   buf->f_ffree   = -1;
   buf->f_files   = -1;
@@ -1266,6 +1268,9 @@
   buf->f_bsize   = s->s_blocksize;
   /* changed to accomodate gcc folks.*/
   buf->f_type    =  REISERFS_SUPER_MAGIC;
+
+  unlock_kernel();
+
   return 0;
 }
 
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/smbfs/inode.c linux-2.5.24-statfs/fs/smbfs/inode.c
--- linux-2.5.24/fs/smbfs/inode.c	Tue Jun 18 19:11:48 2002
+++ linux-2.5.24-statfs/fs/smbfs/inode.c	Tue Jul  2 17:18:29 2002
@@ -604,7 +604,13 @@
 static int
 smb_statfs(struct super_block *sb, struct statfs *buf)
 {
-	int result = smb_proc_dskattr(sb, buf);
+	int result;
+	
+	lock_kernel();
+
+	result = smb_proc_dskattr(sb, buf);
+
+	unlock_kernel();
 
 	buf->f_type = SMB_SUPER_MAGIC;
 	buf->f_namelen = SMB_MAXPATHLEN;
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/sysv/inode.c linux-2.5.24-statfs/fs/sysv/inode.c
--- linux-2.5.24/fs/sysv/inode.c	Tue Jun 18 19:11:45 2002
+++ linux-2.5.24-statfs/fs/sysv/inode.c	Wed Jun 26 01:41:08 2002
@@ -78,6 +78,8 @@
 {
 	struct sysv_sb_info *sbi = SYSV_SB(sb);
 
+	lock_kernel();
+
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = sb->s_blocksize;
 	buf->f_blocks = sbi->s_ndatazones;
@@ -85,6 +87,8 @@
 	buf->f_files = sbi->s_ninodes;
 	buf->f_ffree = sysv_count_free_inodes(sb);
 	buf->f_namelen = SYSV_NAMELEN;
+
+	unlock_kernel();
 	return 0;
 }
 
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/udf/super.c linux-2.5.24-statfs/fs/udf/super.c
--- linux-2.5.24/fs/udf/super.c	Tue Jun 18 19:11:56 2002
+++ linux-2.5.24-statfs/fs/udf/super.c	Wed Jun 26 01:41:08 2002
@@ -1726,6 +1726,7 @@
 static int
 udf_statfs(struct super_block *sb, struct statfs *buf)
 {
+	lock_kernel();
 	buf->f_type = UDF_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
 	buf->f_blocks = UDF_SB_PARTLEN(sb, UDF_SB_PARTITION(sb));
@@ -1737,7 +1738,7 @@
 	buf->f_ffree = buf->f_bfree;
 	/* __kernel_fsid_t f_fsid */
 	buf->f_namelen = UDF_NAME_LEN;
-
+	unlock_kernel();
 	return 0;
 }
 
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/ufs/super.c linux-2.5.24-statfs/fs/ufs/super.c
--- linux-2.5.24/fs/ufs/super.c	Tue Jun 18 19:11:44 2002
+++ linux-2.5.24-statfs/fs/ufs/super.c	Wed Jun 26 01:41:08 2002
@@ -959,6 +959,8 @@
 	struct ufs_sb_private_info * uspi;
 	struct ufs_super_block_first * usb1;
 
+	lock_kernel();
+
 	uspi = sb->u.ufs_sb.s_uspi;
 	usb1 = ubh_get_usb_first (USPI_UBH);
 	
@@ -972,6 +974,9 @@
 	buf->f_files = uspi->s_ncg * uspi->s_ipg;
 	buf->f_ffree = fs32_to_cpu(sb, usb1->fs_cstotal.cs_nifree);
 	buf->f_namelen = UFS_MAXNAMLEN;
+
+	unlock_kernel();
+
 	return 0;
 }
 
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/umsdos/inode.c linux-2.5.24-statfs/fs/umsdos/inode.c
--- linux-2.5.24/fs/umsdos/inode.c	Tue Jun 18 19:11:48 2002
+++ linux-2.5.24-statfs/fs/umsdos/inode.c	Tue Jul  2 17:19:28 2002
@@ -19,6 +19,7 @@
 #include <linux/umsdos_fs.h>
 #include <linux/list.h>
 #include <linux/pagemap.h>
+#include <linux/smp_lock.h>
 
 extern struct dentry_operations umsdos_dentry_operations;
 
@@ -346,9 +347,12 @@
 int UMSDOS_statfs(struct super_block *sb,struct statfs *buf)
 {
 	int ret;
+
+	lock_kernel();
 	ret = fat_statfs (sb, buf);
 	if (!ret)	
 		buf->f_namelen = UMSDOS_MAXNAME;
+	unlock_kernel();
 	return ret;
 }
 
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/mm/shmem.c linux-2.5.24-statfs/mm/shmem.c
--- linux-2.5.24/mm/shmem.c	Tue Jun 18 19:11:53 2002
+++ linux-2.5.24-statfs/mm/shmem.c	Wed Jun 26 01:41:08 2002
@@ -1035,6 +1035,8 @@
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 
+	lock_kernel();
+
 	buf->f_type = TMPFS_MAGIC;
 	buf->f_bsize = PAGE_CACHE_SIZE;
 	spin_lock (&sbinfo->stat_lock);
@@ -1044,6 +1046,9 @@
 	buf->f_ffree = sbinfo->free_inodes;
 	spin_unlock (&sbinfo->stat_lock);
 	buf->f_namelen = 255;
+
+	unlock_kernel();
+
 	return 0;
 }
 


