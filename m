Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262697AbSJRBSx>; Thu, 17 Oct 2002 21:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262702AbSJRBSx>; Thu, 17 Oct 2002 21:18:53 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:29179 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S262697AbSJRBSd>; Thu, 17 Oct 2002 21:18:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15791.21383.361727.533851@wombat.chubb.wattle.id.au>
In-Reply-To: <20021017154102.D30332@redhat.com>
References: <20021016140658.GA8461@averell>
	<shs7kgipiym.fsf@charged.uio.no>
	<15789.64263.606518.921166@wombat.chubb.wattle.id.au>
	<20021017000111.GA25054@averell>
	<20021017154102.D30332@redhat.com>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
From: Peter Chubb <peter@chubb.wattle.id.au>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Andi Kleen <ak@muc.de>, Peter Chubb <peter@chubb.wattle.id.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] statfs64 no longer missing
Date: Fri, 18 Oct 2002 10:19:19 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



OK, here's a preliminary infrastructure patch for statfs64 and
fstatfs64.  Patch against yesterday's BK tree.

I've implemented it only for IA64 and i386, because that's all I can
test --- it's fairly trivial to add the system calls for other
architectures, though.

What I've done is primarily to isolate the internal form of struct
statfs from what's handed out to users.

Still to do is any file-system specific stuff (to implement f_frsize,
to do anything special that's needed for large filesystem support) and
of course the other architectures.

I didn't add a passed-in argument of expected size, as I think that
statfs64 is well enough understood (and there are 5 spare longs
anyway).

Diffstat output:
 arch/i386/kernel/entry.S   |    2 
 fs/adfs/super.c            |    4 -
 fs/affs/super.c            |    4 -
 fs/bfs/inode.c             |    2 
 fs/cifs/cifsfs.c           |    2 
 fs/coda/inode.c            |    4 -
 fs/coda/upcall.c           |    2 
 fs/cramfs/inode.c          |    2 
 fs/efs/super.c             |    2 
 fs/ext2/super.c            |    4 -
 fs/ext3/super.c            |    2 
 fs/fat/inode.c             |    4 -
 fs/freevxfs/vxfs_super.c   |    4 -
 fs/hfs/super.c             |    4 -
 fs/hpfs/hpfs_fn.h          |    2 
 fs/hpfs/super.c            |    2 
 fs/isofs/inode.c           |    4 -
 fs/jfs/super.c             |    2 
 fs/libfs.c                 |    2 
 fs/minix/inode.c           |    4 -
 fs/ncpfs/inode.c           |    4 -
 fs/nfs/inode.c             |    4 -
 fs/nfsd/nfs3xdr.c          |    2 
 fs/nfsd/nfs4xdr.c          |    2 
 fs/nfsd/nfsxdr.c           |    2 
 fs/nfsd/vfs.c              |    2 
 fs/ntfs/super.c            |    2 
 fs/open.c                  |  103 +++++++++++++++++++++++++++++++++++++++++----
 fs/qnx4/inode.c            |    4 -
 fs/reiserfs/super.c        |    4 -
 fs/romfs/inode.c           |    2 
 fs/smbfs/inode.c           |    4 -
 fs/super.c                 |    2 
 fs/sysv/inode.c            |    2 
 fs/udf/super.c             |    4 -
 fs/ufs/super.c             |    6 +-
 fs/xfs/linux/xfs_super.c   |    4 -
 fs/xfs/linux/xfs_vfs.h     |    4 -
 fs/xfs/xfs_vfsops.c        |    4 -
 include/asm-i386/statfs.h  |   24 ++++++----
 include/asm-i386/unistd.h  |    3 -
 include/asm-ia64/statfs.h  |   24 ++++++++--
 include/asm-ia64/unistd.h  |    2 
 include/linux/coda_psdev.h |    2 
 include/linux/efs_fs.h     |    2 
 include/linux/ext3_fs.h    |    2 
 include/linux/fat_cvf.h    |    2 
 include/linux/fs.h         |    7 +--
 include/linux/msdos_fs.h   |    2 
 include/linux/nfsd/nfsd.h  |    2 
 include/linux/nfsd/xdr.h   |    2 
 include/linux/nfsd/xdr3.h  |    2 
 include/linux/statfs.h     |   26 +++++++++++
 mm/shmem.c                 |    2 
 54 files changed, 233 insertions(+), 90 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.791   -> 1.792  
#	   fs/nfsd/nfs3xdr.c	1.16    -> 1.17   
#	      fs/ufs/super.c	1.29    -> 1.30   
#	     fs/adfs/super.c	1.20    -> 1.21   
#	          fs/libfs.c	1.8     -> 1.9    
#	     fs/sysv/inode.c	1.23    -> 1.24   
#	fs/xfs/linux/xfs_vfs.h	1.2     -> 1.3    
#	    fs/nfsd/nfsxdr.c	1.13    -> 1.14   
#	include/linux/fat_cvf.h	1.1     -> 1.2    
#	   fs/cramfs/inode.c	1.24    -> 1.25   
#	           fs/open.c	1.28    -> 1.29   
#	include/asm-ia64/unistd.h	1.15    -> 1.16   
#	    fs/smbfs/inode.c	1.33    -> 1.34   
#	     fs/ntfs/super.c	1.121   -> 1.122  
#	 fs/xfs/xfs_vfsops.c	1.10    -> 1.11   
#	  include/linux/fs.h	1.172   -> 1.173  
#	arch/i386/kernel/entry.S	1.38    -> 1.39   
#	   fs/nfsd/nfs4xdr.c	1.2     -> 1.3    
#	include/linux/nfsd/xdr3.h	1.2     -> 1.3    
#	     fs/qnx4/inode.c	1.24    -> 1.25   
#	      fs/hfs/super.c	1.19    -> 1.20   
#	       fs/nfsd/vfs.c	1.44    -> 1.45   
#	      fs/bfs/inode.c	1.21    -> 1.22   
#	include/linux/efs_fs.h	1.7     -> 1.8    
#	          mm/shmem.c	1.87    -> 1.88   
#	include/linux/nfsd/nfsd.h	1.11    -> 1.12   
#	      fs/fat/inode.c	1.51    -> 1.52   
#	          fs/super.c	1.83    -> 1.84   
#	 fs/reiserfs/super.c	1.54    -> 1.55   
#	      fs/jfs/super.c	1.27    -> 1.28   
#	     fs/coda/inode.c	1.22    -> 1.23   
#	include/linux/coda_psdev.h	1.4     -> 1.5    
#	    fs/ncpfs/inode.c	1.33    -> 1.34   
#	    fs/minix/inode.c	1.29    -> 1.30   
#	include/asm-ia64/statfs.h	1.1     -> 1.2    
#	    fs/cifs/cifsfs.c	1.1     -> 1.2    
#	     fs/hpfs/super.c	1.20    -> 1.21   
#	include/linux/ext3_fs.h	1.11    -> 1.12   
#	   fs/hpfs/hpfs_fn.h	1.10    -> 1.11   
#	include/asm-i386/unistd.h	1.17    -> 1.18   
#	      fs/udf/super.c	1.27    -> 1.28   
#	     fs/ext2/super.c	1.31    -> 1.32   
#	    fs/romfs/inode.c	1.25    -> 1.26   
#	     fs/affs/super.c	1.28    -> 1.29   
#	include/linux/nfsd/xdr.h	1.3     -> 1.4    
#	      fs/nfs/inode.c	1.60    -> 1.61   
#	include/linux/msdos_fs.h	1.18    -> 1.19   
#	      fs/efs/super.c	1.14    -> 1.15   
#	    fs/coda/upcall.c	1.11    -> 1.12   
#	include/asm-i386/statfs.h	1.1     -> 1.2    
#	fs/freevxfs/vxfs_super.c	1.12    -> 1.13   
#	     fs/ext3/super.c	1.33    -> 1.34   
#	fs/xfs/linux/xfs_super.c	1.8     -> 1.9    
#	    fs/isofs/inode.c	1.28    -> 1.29   
#	               (new)	        -> 1.1     include/linux/statfs.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/18	peterc@gelato.unsw.edu.au	1.792
# Implement statfs64 and fstatfs64 for IA64 and I386. (Other architectures later, if this
# passes peer review).
# 
# -- Add a new type struct kstatfs that is variable sized depending on CONFIG_LBD.
#    This type is used for all in-kernel communication between filesystems and the system
#    calls.
# -- Convert to the user-expected form in the system call code.
# 
# Todo:
# 	-- Add support for new field, f_frsize in each filesystem
# 	-- Add support for other architectures.
# 	-- (Maybe) move struct statfs to asm-generic
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Fri Oct 18 10:07:29 2002
+++ b/arch/i386/kernel/entry.S	Fri Oct 18 10:07:29 2002
@@ -737,6 +737,8 @@
 	.long sys_free_hugepages
 	.long sys_exit_group
 	.long sys_lookup_dcookie
+	.long sys_statfs64
+	.long sys_fstatfs64 /* 255 */
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff -Nru a/fs/adfs/super.c b/fs/adfs/super.c
--- a/fs/adfs/super.c	Fri Oct 18 10:07:29 2002
+++ b/fs/adfs/super.c	Fri Oct 18 10:07:29 2002
@@ -188,7 +188,7 @@
 	return parse_options(sb, data);
 }
 
-static int adfs_statfs(struct super_block *sb, struct statfs *buf)
+static int adfs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	struct adfs_sb_info *asb = ADFS_SB(sb);
 
@@ -199,7 +199,7 @@
 	buf->f_files   = asb->s_ids_per_zone * asb->s_map_size;
 	buf->f_bavail  =
 	buf->f_bfree   = adfs_map_free(sb);
-	buf->f_ffree   = buf->f_bfree * buf->f_files / buf->f_blocks;
+	buf->f_ffree   = (long)(buf->f_bfree * buf->f_files) / (long)buf->f_blocks;
 
 	return 0;
 }
diff -Nru a/fs/affs/super.c b/fs/affs/super.c
--- a/fs/affs/super.c	Fri Oct 18 10:07:30 2002
+++ b/fs/affs/super.c	Fri Oct 18 10:07:30 2002
@@ -32,7 +32,7 @@
 
 extern struct timezone sys_tz;
 
-static int affs_statfs(struct super_block *sb, struct statfs *buf);
+static int affs_statfs(struct super_block *sb, struct kstatfs *buf);
 static int affs_remount (struct super_block *sb, int *flags, char *data);
 
 static void
@@ -527,7 +527,7 @@
 }
 
 static int
-affs_statfs(struct super_block *sb, struct statfs *buf)
+affs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	int		 free;
 
diff -Nru a/fs/bfs/inode.c b/fs/bfs/inode.c
--- a/fs/bfs/inode.c	Fri Oct 18 10:07:29 2002
+++ b/fs/bfs/inode.c	Fri Oct 18 10:07:29 2002
@@ -187,7 +187,7 @@
 	s->s_fs_info = NULL;
 }
 
-static int bfs_statfs(struct super_block *s, struct statfs *buf)
+static int bfs_statfs(struct super_block *s, struct kstatfs *buf)
 {
 	struct bfs_sb_info *info = BFS_SB(s);
 	buf->f_type = BFS_MAGIC;
diff -Nru a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
--- a/fs/cifs/cifsfs.c	Fri Oct 18 10:07:30 2002
+++ b/fs/cifs/cifsfs.c	Fri Oct 18 10:07:30 2002
@@ -127,7 +127,7 @@
 }
 
 int
-cifs_statfs(struct super_block *sb, struct statfs *buf)
+cifs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	int xid, rc;
 	struct cifs_sb_info *cifs_sb;
diff -Nru a/fs/coda/inode.c b/fs/coda/inode.c
--- a/fs/coda/inode.c	Fri Oct 18 10:07:30 2002
+++ b/fs/coda/inode.c	Fri Oct 18 10:07:30 2002
@@ -33,7 +33,7 @@
 /* VFS super_block ops */
 static void coda_clear_inode(struct inode *);
 static void coda_put_super(struct super_block *);
-static int coda_statfs(struct super_block *sb, struct statfs *buf);
+static int coda_statfs(struct super_block *sb, struct kstatfs *buf);
 
 static kmem_cache_t * coda_inode_cachep;
 
@@ -272,7 +272,7 @@
 	.setattr	= coda_setattr,
 };
 
-static int coda_statfs(struct super_block *sb, struct statfs *buf)
+static int coda_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	int error;
 	
diff -Nru a/fs/coda/upcall.c b/fs/coda/upcall.c
--- a/fs/coda/upcall.c	Fri Oct 18 10:07:30 2002
+++ b/fs/coda/upcall.c	Fri Oct 18 10:07:30 2002
@@ -584,7 +584,7 @@
 	return error;
 }
 
-int venus_statfs(struct super_block *sb, struct statfs *sfs) 
+int venus_statfs(struct super_block *sb, struct kstatfs *sfs) 
 { 
         union inputArgs *inp;
         union outputArgs *outp;
diff -Nru a/fs/cramfs/inode.c b/fs/cramfs/inode.c
--- a/fs/cramfs/inode.c	Fri Oct 18 10:07:29 2002
+++ b/fs/cramfs/inode.c	Fri Oct 18 10:07:29 2002
@@ -262,7 +262,7 @@
 	return -EINVAL;
 }
 
-static int cramfs_statfs(struct super_block *sb, struct statfs *buf)
+static int cramfs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	buf->f_type = CRAMFS_MAGIC;
 	buf->f_bsize = PAGE_CACHE_SIZE;
diff -Nru a/fs/efs/super.c b/fs/efs/super.c
--- a/fs/efs/super.c	Fri Oct 18 10:07:30 2002
+++ b/fs/efs/super.c	Fri Oct 18 10:07:30 2002
@@ -277,7 +277,7 @@
 	return -EINVAL;
 }
 
-int efs_statfs(struct super_block *s, struct statfs *buf) {
+int efs_statfs(struct super_block *s, struct kstatfs *buf) {
 	struct efs_sb_info *sb = SUPER_INFO(s);
 
 	buf->f_type    = EFS_SUPER_MAGIC;	/* efs magic number */
diff -Nru a/fs/ext2/super.c b/fs/ext2/super.c
--- a/fs/ext2/super.c	Fri Oct 18 10:07:30 2002
+++ b/fs/ext2/super.c	Fri Oct 18 10:07:30 2002
@@ -32,7 +32,7 @@
 static void ext2_sync_super(struct super_block *sb,
 			    struct ext2_super_block *es);
 static int ext2_remount (struct super_block * sb, int * flags, char * data);
-static int ext2_statfs (struct super_block * sb, struct statfs * buf);
+static int ext2_statfs (struct super_block * sb, struct kstatfs * buf);
 
 static char error_buf[1024];
 
@@ -818,7 +818,7 @@
 	return 0;
 }
 
-static int ext2_statfs (struct super_block * sb, struct statfs * buf)
+static int ext2_statfs (struct super_block * sb, struct kstatfs * buf)
 {
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	unsigned long overhead;
diff -Nru a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	Fri Oct 18 10:07:30 2002
+++ b/fs/ext3/super.c	Fri Oct 18 10:07:30 2002
@@ -1755,7 +1755,7 @@
 	return 0;
 }
 
-int ext3_statfs (struct super_block * sb, struct statfs * buf)
+int ext3_statfs (struct super_block * sb, struct kstatfs * buf)
 {
 	struct ext3_super_block *es = EXT3_SB(sb)->s_es;
 	unsigned long overhead;
diff -Nru a/fs/fat/inode.c b/fs/fat/inode.c
--- a/fs/fat/inode.c	Fri Oct 18 10:07:29 2002
+++ b/fs/fat/inode.c	Fri Oct 18 10:07:29 2002
@@ -1070,14 +1070,14 @@
 	return error;
 }
 
-int fat_statfs(struct super_block *sb,struct statfs *buf)
+int fat_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	int free,nr;
        
 	if (MSDOS_SB(sb)->cvf_format &&
 	    MSDOS_SB(sb)->cvf_format->cvf_statfs)
 		return MSDOS_SB(sb)->cvf_format->cvf_statfs(sb,buf,
-						sizeof(struct statfs));
+						sizeof(struct kstatfs));
 	  
 	lock_fat(sb);
 	if (MSDOS_SB(sb)->free_clusters != -1)
diff -Nru a/fs/freevxfs/vxfs_super.c b/fs/freevxfs/vxfs_super.c
--- a/fs/freevxfs/vxfs_super.c	Fri Oct 18 10:07:30 2002
+++ b/fs/freevxfs/vxfs_super.c	Fri Oct 18 10:07:30 2002
@@ -54,7 +54,7 @@
 
 
 static void		vxfs_put_super(struct super_block *);
-static int		vxfs_statfs(struct super_block *, struct statfs *);
+static int		vxfs_statfs(struct super_block *, struct kstatfs *);
 
 static struct super_operations vxfs_super_ops = {
 	.read_inode =		vxfs_read_inode,
@@ -104,7 +104,7 @@
  *   This is everything but complete...
  */
 static int
-vxfs_statfs(struct super_block *sbp, struct statfs *bufp)
+vxfs_statfs(struct super_block *sbp, struct kstatfs *bufp)
 {
 	struct vxfs_sb_info		*infp = VXFS_SBI(sbp);
 
diff -Nru a/fs/hfs/super.c b/fs/hfs/super.c
--- a/fs/hfs/super.c	Fri Oct 18 10:07:29 2002
+++ b/fs/hfs/super.c	Fri Oct 18 10:07:29 2002
@@ -39,7 +39,7 @@
 
 static void hfs_read_inode(struct inode *);
 static void hfs_put_super(struct super_block *);
-static int hfs_statfs(struct super_block *, struct statfs *);
+static int hfs_statfs(struct super_block *, struct kstatfs *);
 static void hfs_write_super(struct super_block *);
 
 static kmem_cache_t * hfs_inode_cachep;
@@ -194,7 +194,7 @@
  *
  * changed f_files/f_ffree to reflect the fs_ablock/free_ablocks.
  */
-static int hfs_statfs(struct super_block *sb, struct statfs *buf)
+static int hfs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	struct hfs_mdb *mdb = HFS_SB(sb)->s_mdb;
 
diff -Nru a/fs/hpfs/hpfs_fn.h b/fs/hpfs/hpfs_fn.h
--- a/fs/hpfs/hpfs_fn.h	Fri Oct 18 10:07:30 2002
+++ b/fs/hpfs/hpfs_fn.h	Fri Oct 18 10:07:30 2002
@@ -306,7 +306,7 @@
 int hpfs_remount_fs(struct super_block *, int *, char *);
 void hpfs_put_super(struct super_block *);
 unsigned hpfs_count_one_bitmap(struct super_block *, secno);
-int hpfs_statfs(struct super_block *, struct statfs *);
+int hpfs_statfs(struct super_block *, struct kstatfs *);
 
 extern struct address_space_operations hpfs_aops;
 
diff -Nru a/fs/hpfs/super.c b/fs/hpfs/super.c
--- a/fs/hpfs/super.c	Fri Oct 18 10:07:30 2002
+++ b/fs/hpfs/super.c	Fri Oct 18 10:07:30 2002
@@ -135,7 +135,7 @@
 	return count;
 }
 
-int hpfs_statfs(struct super_block *s, struct statfs *buf)
+int hpfs_statfs(struct super_block *s, struct kstatfs *buf)
 {
 	struct hpfs_sb_info *sbi = hpfs_sb(s);
 	lock_kernel();
diff -Nru a/fs/isofs/inode.c b/fs/isofs/inode.c
--- a/fs/isofs/inode.c	Fri Oct 18 10:07:30 2002
+++ b/fs/isofs/inode.c	Fri Oct 18 10:07:30 2002
@@ -74,7 +74,7 @@
 }
 
 static void isofs_read_inode(struct inode *);
-static int isofs_statfs (struct super_block *, struct statfs *);
+static int isofs_statfs (struct super_block *, struct kstatfs *);
 
 static kmem_cache_t *isofs_inode_cachep;
 
@@ -884,7 +884,7 @@
 	return -EINVAL;
 }
 
-static int isofs_statfs (struct super_block *sb, struct statfs *buf)
+static int isofs_statfs (struct super_block *sb, struct kstatfs *buf)
 {
 	buf->f_type = ISOFS_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
diff -Nru a/fs/jfs/super.c b/fs/jfs/super.c
--- a/fs/jfs/super.c	Fri Oct 18 10:07:30 2002
+++ b/fs/jfs/super.c	Fri Oct 18 10:07:30 2002
@@ -97,7 +97,7 @@
 	kmem_cache_free(jfs_inode_cachep, JFS_IP(inode));
 }
 
-static int jfs_statfs(struct super_block *sb, struct statfs *buf)
+static int jfs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	struct jfs_sb_info *sbi = JFS_SBI(sb);
 	s64 maxinodes;
diff -Nru a/fs/libfs.c b/fs/libfs.c
--- a/fs/libfs.c	Fri Oct 18 10:07:29 2002
+++ b/fs/libfs.c	Fri Oct 18 10:07:29 2002
@@ -6,7 +6,7 @@
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 
-int simple_statfs(struct super_block *sb, struct statfs *buf)
+int simple_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = PAGE_CACHE_SIZE;
diff -Nru a/fs/minix/inode.c b/fs/minix/inode.c
--- a/fs/minix/inode.c	Fri Oct 18 10:07:30 2002
+++ b/fs/minix/inode.c	Fri Oct 18 10:07:30 2002
@@ -18,7 +18,7 @@
 
 static void minix_read_inode(struct inode * inode);
 static void minix_write_inode(struct inode * inode, int wait);
-static int minix_statfs(struct super_block *sb, struct statfs *buf);
+static int minix_statfs(struct super_block *sb, struct kstatfs *buf);
 static int minix_remount (struct super_block * sb, int * flags, char * data);
 
 static void minix_delete_inode(struct inode *inode)
@@ -293,7 +293,7 @@
 	return -EINVAL;
 }
 
-static int minix_statfs(struct super_block *sb, struct statfs *buf)
+static int minix_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	struct minix_sb_info *sbi = minix_sb(sb);
 	buf->f_type = sb->s_magic;
diff -Nru a/fs/ncpfs/inode.c b/fs/ncpfs/inode.c
--- a/fs/ncpfs/inode.c	Fri Oct 18 10:07:30 2002
+++ b/fs/ncpfs/inode.c	Fri Oct 18 10:07:30 2002
@@ -38,7 +38,7 @@
 
 static void ncp_delete_inode(struct inode *);
 static void ncp_put_super(struct super_block *);
-static int  ncp_statfs(struct super_block *, struct statfs *);
+static int  ncp_statfs(struct super_block *, struct kstatfs *);
 
 static kmem_cache_t * ncp_inode_cachep;
 
@@ -711,7 +711,7 @@
 	kfree(server);
 }
 
-static int ncp_statfs(struct super_block *sb, struct statfs *buf)
+static int ncp_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	struct dentry* d;
 	struct inode* i;
diff -Nru a/fs/nfs/inode.c b/fs/nfs/inode.c
--- a/fs/nfs/inode.c	Fri Oct 18 10:07:30 2002
+++ b/fs/nfs/inode.c	Fri Oct 18 10:07:30 2002
@@ -52,7 +52,7 @@
 static void nfs_put_super(struct super_block *);
 static void nfs_clear_inode(struct inode *);
 static void nfs_umount_begin(struct super_block *);
-static int  nfs_statfs(struct super_block *, struct statfs *);
+static int  nfs_statfs(struct super_block *, struct kstatfs *);
 static int  nfs_show_options(struct seq_file *, struct vfsmount *);
 
 static struct super_operations nfs_sops = { 
@@ -476,7 +476,7 @@
 }
 
 static int
-nfs_statfs(struct super_block *sb, struct statfs *buf)
+nfs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	struct nfs_server *server = NFS_SB(sb);
 	unsigned char blockbits;
diff -Nru a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
--- a/fs/nfsd/nfs3xdr.c	Fri Oct 18 10:07:28 2002
+++ b/fs/nfsd/nfs3xdr.c	Fri Oct 18 10:07:28 2002
@@ -762,7 +762,7 @@
 nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, u32 *p,
 					struct nfsd3_fsstatres *resp)
 {
-	struct statfs	*s = &resp->stats;
+	struct kstatfs	*s = &resp->stats;
 	u64		bs = s->f_bsize;
 
 	*p++ = xdr_zero;	/* no post_op_attr */
diff -Nru a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
--- a/fs/nfsd/nfs4xdr.c	Fri Oct 18 10:07:29 2002
+++ b/fs/nfsd/nfs4xdr.c	Fri Oct 18 10:07:29 2002
@@ -976,7 +976,7 @@
 	struct name_ent *owner = NULL;
 	struct name_ent *group = NULL;
 	struct svc_fh tempfh;
-	struct statfs statfs;
+	struct kstatfs statfs;
 	int buflen = *countp << 2;
 	u32 *attrlenp;
 	u32 dummy;
diff -Nru a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
--- a/fs/nfsd/nfsxdr.c	Fri Oct 18 10:07:29 2002
+++ b/fs/nfsd/nfsxdr.c	Fri Oct 18 10:07:29 2002
@@ -388,7 +388,7 @@
 nfssvc_encode_statfsres(struct svc_rqst *rqstp, u32 *p,
 					struct nfsd_statfsres *resp)
 {
-	struct statfs	*stat = &resp->stats;
+	struct kstatfs	*stat = &resp->stats;
 
 	*p++ = htonl(NFSSVC_MAXBLKSIZE);	/* max transfer size */
 	*p++ = htonl(stat->f_bsize);
diff -Nru a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
--- a/fs/nfsd/vfs.c	Fri Oct 18 10:07:29 2002
+++ b/fs/nfsd/vfs.c	Fri Oct 18 10:07:29 2002
@@ -1473,7 +1473,7 @@
  * N.B. After this call fhp needs an fh_put
  */
 int
-nfsd_statfs(struct svc_rqst *rqstp, struct svc_fh *fhp, struct statfs *stat)
+nfsd_statfs(struct svc_rqst *rqstp, struct svc_fh *fhp, struct kstatfs *stat)
 {
 	int err = fh_verify(rqstp, fhp, 0, MAY_NOP);
 	if (!err && vfs_statfs(fhp->fh_dentry->d_inode->i_sb,stat))
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	Fri Oct 18 10:07:29 2002
+++ b/fs/ntfs/super.c	Fri Oct 18 10:07:29 2002
@@ -1220,7 +1220,7 @@
  *
  * Return 0 on success or -errno on error.
  */
-static int ntfs_statfs(struct super_block *sb, struct statfs *sfs)
+static int ntfs_statfs(struct super_block *sb, struct kstatfs *sfs)
 {
 	ntfs_volume *vol = NTFS_SB(sb);
 	s64 size;
diff -Nru a/fs/open.c b/fs/open.c
--- a/fs/open.c	Fri Oct 18 10:07:29 2002
+++ b/fs/open.c	Fri Oct 18 10:07:29 2002
@@ -22,14 +22,14 @@
 
 #define special_file(m) (S_ISCHR(m)||S_ISBLK(m)||S_ISFIFO(m)||S_ISSOCK(m))
 
-int vfs_statfs(struct super_block *sb, struct statfs *buf)
+int vfs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	int retval = -ENODEV;
 
 	if (sb) {
 		retval = -ENOSYS;
 		if (sb->s_op && sb->s_op->statfs) {
-			memset(buf, 0, sizeof(struct statfs));
+			memset(buf, 0, sizeof(*buf));
 			retval = security_ops->sb_statfs(sb);
 			if (retval)
 				return retval;
@@ -40,16 +40,87 @@
 }
 
 
+
+long vfs_statfs_native(struct super_block *sb, struct statfs *buf)
+{
+	struct kstatfs st;
+	int retval;
+
+	retval = vfs_statfs(sb, &st);
+	if (retval)
+		return retval;
+
+	if (sizeof(*buf) == sizeof(st))
+		memcpy(buf, &st, sizeof(st));
+	else {
+		buf->f_type = st.f_type;
+		buf->f_bsize = st.f_bsize;
+		buf->f_blocks = st.f_blocks;
+		buf->f_bfree = st.f_bfree;
+		buf->f_bavail = st.f_bavail;
+		buf->f_files = st.f_files;
+		buf->f_ffree = st.f_ffree;
+		buf->f_fsid = st.f_fsid;
+		buf->f_namelen = st.f_namelen;
+		buf->f_frsize = st.f_frsize;
+		memset(buf->f_spare, 0, sizeof(buf->f_spare));
+	}
+	return 0;
+}
+
+long vfs_statfs64(struct super_block *sb, struct statfs64 *buf)
+{
+	struct kstatfs st;
+	int retval;
+
+	retval = vfs_statfs(sb, &st);
+	if (retval)
+		return retval;
+
+	if (sizeof(*buf) == sizeof(st))
+		memcpy(buf, &st, sizeof(st));
+	else {
+		buf->f_type = st.f_type;
+		buf->f_bsize = st.f_bsize;
+		buf->f_blocks = st.f_blocks;
+		buf->f_bfree = st.f_bfree;
+		buf->f_bavail = st.f_bavail;
+		buf->f_files = st.f_files;
+		buf->f_ffree = st.f_ffree;
+		buf->f_fsid = st.f_fsid;
+		buf->f_namelen = st.f_namelen;
+		buf->f_frsize = st.f_frsize;
+		memset(buf->f_spare, 0, sizeof(buf->f_spare));
+	}
+	return 0;
+}
+
 asmlinkage long sys_statfs(const char * path, struct statfs * buf)
 {
 	struct nameidata nd;
-	int error;
+	long error;
 
 	error = user_path_walk(path, &nd);
 	if (!error) {
 		struct statfs tmp;
-		error = vfs_statfs(nd.dentry->d_inode->i_sb, &tmp);
-		if (!error && copy_to_user(buf, &tmp, sizeof(struct statfs)))
+		error = vfs_statfs_native(nd.dentry->d_inode->i_sb, &tmp);
+		if (!error && copy_to_user(buf, &tmp, sizeof(tmp)))
+			error = -EFAULT;
+		path_release(&nd);
+	}
+	return error;
+}
+
+asmlinkage long sys_statfs64(const char * path, struct statfs64 * buf)
+{
+	struct nameidata nd;
+	long error;
+
+	error = user_path_walk(path, &nd);
+	if (!error) {
+		struct statfs64 tmp;
+		error = vfs_statfs64(nd.dentry->d_inode->i_sb, &tmp);
+		if (!error && copy_to_user(buf, &tmp, sizeof(tmp)))
 			error = -EFAULT;
 		path_release(&nd);
 	}
@@ -66,8 +137,26 @@
 	file = fget(fd);
 	if (!file)
 		goto out;
-	error = vfs_statfs(file->f_dentry->d_inode->i_sb, &tmp);
-	if (!error && copy_to_user(buf, &tmp, sizeof(struct statfs)))
+	error = vfs_statfs_native(file->f_dentry->d_inode->i_sb, &tmp);
+	if (!error && copy_to_user(buf, &tmp, sizeof(tmp)))
+		error = -EFAULT;
+	fput(file);
+out:
+	return error;
+}
+
+asmlinkage long sys_fstatfs64(unsigned int fd, struct statfs64 * buf)
+{
+	struct file * file;
+	struct statfs64 tmp;
+	int error;
+
+	error = -EBADF;
+	file = fget(fd);
+	if (!file)
+		goto out;
+	error = vfs_statfs64(file->f_dentry->d_inode->i_sb, &tmp);
+	if (!error && copy_to_user(buf, &tmp, sizeof(tmp)))
 		error = -EFAULT;
 	fput(file);
 out:
diff -Nru a/fs/qnx4/inode.c b/fs/qnx4/inode.c
--- a/fs/qnx4/inode.c	Fri Oct 18 10:07:29 2002
+++ b/fs/qnx4/inode.c	Fri Oct 18 10:07:29 2002
@@ -127,7 +127,7 @@
 static void qnx4_destroy_inode(struct inode *inode);
 static void qnx4_read_inode(struct inode *);
 static int qnx4_remount(struct super_block *sb, int *flags, char *data);
-static int qnx4_statfs(struct super_block *, struct statfs *);
+static int qnx4_statfs(struct super_block *, struct kstatfs *);
 
 static struct super_operations qnx4_sops =
 {
@@ -277,7 +277,7 @@
 	return block;
 }
 
-static int qnx4_statfs(struct super_block *sb, struct statfs *buf)
+static int qnx4_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	lock_kernel();
 
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Fri Oct 18 10:07:30 2002
+++ b/fs/reiserfs/super.c	Fri Oct 18 10:07:30 2002
@@ -64,7 +64,7 @@
 }
 
 static int reiserfs_remount (struct super_block * s, int * flags, char * data);
-static int reiserfs_statfs (struct super_block * s, struct statfs * buf);
+static int reiserfs_statfs (struct super_block * s, struct kstatfs * buf);
 
 static void reiserfs_write_super (struct super_block * s)
 {
@@ -1340,7 +1340,7 @@
 }
 
 
-static int reiserfs_statfs (struct super_block * s, struct statfs * buf)
+static int reiserfs_statfs (struct super_block * s, struct kstatfs * buf)
 {
   struct reiserfs_super_block * rs = SB_DISK_SUPER_BLOCK (s);
   
diff -Nru a/fs/romfs/inode.c b/fs/romfs/inode.c
--- a/fs/romfs/inode.c	Fri Oct 18 10:07:30 2002
+++ b/fs/romfs/inode.c	Fri Oct 18 10:07:30 2002
@@ -175,7 +175,7 @@
 /* That's simple too. */
 
 static int
-romfs_statfs(struct super_block *sb, struct statfs *buf)
+romfs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	buf->f_type = ROMFS_MAGIC;
 	buf->f_bsize = ROMBSIZE;
diff -Nru a/fs/smbfs/inode.c b/fs/smbfs/inode.c
--- a/fs/smbfs/inode.c	Fri Oct 18 10:07:29 2002
+++ b/fs/smbfs/inode.c	Fri Oct 18 10:07:29 2002
@@ -45,7 +45,7 @@
 
 static void smb_delete_inode(struct inode *);
 static void smb_put_super(struct super_block *);
-static int  smb_statfs(struct super_block *, struct statfs *);
+static int  smb_statfs(struct super_block *, struct kstatfs *);
 static int  smb_show_options(struct seq_file *, struct vfsmount *);
 
 static kmem_cache_t *smb_inode_cachep;
@@ -608,7 +608,7 @@
 }
 
 static int
-smb_statfs(struct super_block *sb, struct statfs *buf)
+smb_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	int result;
 	
diff -Nru a/fs/super.c b/fs/super.c
--- a/fs/super.c	Fri Oct 18 10:07:29 2002
+++ b/fs/super.c	Fri Oct 18 10:07:30 2002
@@ -353,7 +353,7 @@
 {
         struct super_block *s;
         struct ustat tmp;
-        struct statfs sbuf;
+        struct kstatfs sbuf;
 	int err = -EINVAL;
 
         s = user_get_super(dev);
diff -Nru a/fs/sysv/inode.c b/fs/sysv/inode.c
--- a/fs/sysv/inode.c	Fri Oct 18 10:07:29 2002
+++ b/fs/sysv/inode.c	Fri Oct 18 10:07:29 2002
@@ -74,7 +74,7 @@
 	kfree(sbi);
 }
 
-static int sysv_statfs(struct super_block *sb, struct statfs *buf)
+static int sysv_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	struct sysv_sb_info *sbi = SYSV_SB(sb);
 
diff -Nru a/fs/udf/super.c b/fs/udf/super.c
--- a/fs/udf/super.c	Fri Oct 18 10:07:30 2002
+++ b/fs/udf/super.c	Fri Oct 18 10:07:30 2002
@@ -94,7 +94,7 @@
 static void udf_open_lvid(struct super_block *);
 static void udf_close_lvid(struct super_block *);
 static unsigned int udf_count_free(struct super_block *);
-static int udf_statfs(struct super_block *, struct statfs *);
+static int udf_statfs(struct super_block *, struct kstatfs *);
 
 /* UDF filesystem type */
 static struct super_block *udf_get_sb(struct file_system_type *fs_type,
@@ -1724,7 +1724,7 @@
  *	Written, tested, and released.
  */
 static int
-udf_statfs(struct super_block *sb, struct statfs *buf)
+udf_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	lock_kernel();
 
diff -Nru a/fs/ufs/super.c b/fs/ufs/super.c
--- a/fs/ufs/super.c	Fri Oct 18 10:07:29 2002
+++ b/fs/ufs/super.c	Fri Oct 18 10:07:29 2002
@@ -972,7 +972,7 @@
 	return 0;
 }
 
-int ufs_statfs (struct super_block * sb, struct statfs * buf)
+int ufs_statfs (struct super_block * sb, struct kstatfs * buf)
 {
 	struct ufs_sb_private_info * uspi;
 	struct ufs_super_block_first * usb1;
@@ -987,8 +987,8 @@
 	buf->f_blocks = uspi->s_dsize;
 	buf->f_bfree = ufs_blkstofrags(fs32_to_cpu(sb, usb1->fs_cstotal.cs_nbfree)) +
 		fs32_to_cpu(sb, usb1->fs_cstotal.cs_nffree);
-	buf->f_bavail = (buf->f_bfree > ((buf->f_blocks / 100) * uspi->s_minfree))
-		? (buf->f_bfree - ((buf->f_blocks / 100) * uspi->s_minfree)) : 0;
+	buf->f_bavail = (buf->f_bfree > (((long)buf->f_blocks / 100) * uspi->s_minfree))
+		? (buf->f_bfree - (((long)buf->f_blocks / 100) * uspi->s_minfree)) : 0;
 	buf->f_files = uspi->s_ncg * uspi->s_ipg;
 	buf->f_ffree = fs32_to_cpu(sb, usb1->fs_cstotal.cs_nifree);
 	buf->f_namelen = UFS_MAXNAMLEN;
diff -Nru a/fs/xfs/linux/xfs_super.c b/fs/xfs/linux/xfs_super.c
--- a/fs/xfs/linux/xfs_super.c	Fri Oct 18 10:07:30 2002
+++ b/fs/xfs/linux/xfs_super.c	Fri Oct 18 10:07:30 2002
@@ -406,7 +406,7 @@
 	vnode_t			*rootvp;
 	struct inode		*ip;
 	struct xfs_mount_args	*args;
-	struct statfs		statvfs;
+	struct kstatfs		statvfs;
 	int			error = EINVAL;
 
 	args = kmalloc(sizeof(struct xfs_mount_args), GFP_KERNEL);
@@ -619,7 +619,7 @@
 int
 linvfs_statfs(
 	struct super_block	*sb,
-	struct statfs		*statp)
+	struct kstatfs		*statp)
 {
 	vfs_t			*vfsp = LINVFS_GET_VFS(sb);
 	int			error;
diff -Nru a/fs/xfs/linux/xfs_vfs.h b/fs/xfs/linux/xfs_vfs.h
--- a/fs/xfs/linux/xfs_vfs.h	Fri Oct 18 10:07:29 2002
+++ b/fs/xfs/linux/xfs_vfs.h	Fri Oct 18 10:07:29 2002
@@ -34,7 +34,7 @@
 
 #include <linux/vfs.h>
 
-struct statfs;
+struct kstatfs;
 struct vnode;
 struct cred;
 struct super_block;
@@ -82,7 +82,7 @@
 					/* unmount file system */
 	int	(*vfs_root)(bhv_desc_t *, struct vnode **);
 					/* get root vnode */
-	int	(*vfs_statvfs)(bhv_desc_t *, struct statfs *, struct vnode *);
+	int	(*vfs_statvfs)(bhv_desc_t *, struct kstatfs *, struct vnode *);
 					/* get file system statistics */
 	int	(*vfs_sync)(bhv_desc_t *, int, struct cred *);
 					/* flush files */
diff -Nru a/fs/xfs/xfs_vfsops.c b/fs/xfs/xfs_vfsops.c
--- a/fs/xfs/xfs_vfsops.c	Fri Oct 18 10:07:29 2002
+++ b/fs/xfs/xfs_vfsops.c	Fri Oct 18 10:07:29 2002
@@ -766,7 +766,7 @@
 STATIC int
 xfs_statvfs(
 	bhv_desc_t	*bdp,
-	struct statfs	*statp,
+	struct kstatfs	*statp,
 	vnode_t		*vp)
 {
 	__uint64_t	fakeinos;
@@ -796,7 +796,7 @@
 		if (!mp->m_inoadd)
 #endif
 			statp->f_files =
-			    MIN(statp->f_files, (long)mp->m_maxicount);
+			    MIN(statp->f_files, mp->m_maxicount);
 	statp->f_ffree = statp->f_files - (sbp->sb_icount - sbp->sb_ifree);
 	XFS_SB_UNLOCK(mp, s);
 
diff -Nru a/include/asm-i386/statfs.h b/include/asm-i386/statfs.h
--- a/include/asm-i386/statfs.h	Fri Oct 18 10:07:30 2002
+++ b/include/asm-i386/statfs.h	Fri Oct 18 10:07:30 2002
@@ -1,13 +1,6 @@
 #ifndef _I386_STATFS_H
 #define _I386_STATFS_H
 
-#ifndef __KERNEL_STRICT_NAMES
-
-#include <linux/types.h>
-
-typedef __kernel_fsid_t	fsid_t;
-
-#endif
 
 struct statfs {
 	long f_type;
@@ -19,7 +12,22 @@
 	long f_ffree;
 	__kernel_fsid_t f_fsid;
 	long f_namelen;
-	long f_spare[6];
+	long f_frsize;
+	long f_spare[5];
+};
+
+struct statfs64 {
+	long f_type;
+	long f_bsize;
+	long long f_blocks;
+	long long f_bfree;
+	long long f_bavail;
+	long long f_files;
+	long long f_ffree;
+	__kernel_fsid_t f_fsid;
+	long f_namelen;
+	long f_frsize;
+	long f_spare[5];
 };
 
 #endif
diff -Nru a/include/asm-i386/unistd.h b/include/asm-i386/unistd.h
--- a/include/asm-i386/unistd.h	Fri Oct 18 10:07:30 2002
+++ b/include/asm-i386/unistd.h	Fri Oct 18 10:07:30 2002
@@ -258,7 +258,8 @@
 #define __NR_free_hugepages	251
 #define __NR_exit_group		252
 #define __NR_lookup_dcookie	253
-  
+#define __NR_statfs64		254
+#define __NR_fstatfs64		255  
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -Nru a/include/asm-ia64/statfs.h b/include/asm-ia64/statfs.h
--- a/include/asm-ia64/statfs.h	Fri Oct 18 10:07:30 2002
+++ b/include/asm-ia64/statfs.h	Fri Oct 18 10:07:30 2002
@@ -6,11 +6,9 @@
  * Copyright (C) 1998, 1999 David Mosberger-Tang <davidm@hpl.hp.com>
  */
 
-# ifndef __KERNEL_STRICT_NAMES
-#  include <linux/types.h>
-   typedef __kernel_fsid_t	fsid_t;
-# endif
-
+/*
+ * This is ugly --- we're already 64-bit, so just duplicate the definitions
+ */
 struct statfs {
 	long f_type;
 	long f_bsize;
@@ -23,5 +21,21 @@
 	long f_namelen;
 	long f_spare[6];
 };
+
+
+struct statfs64 {
+	long f_type;
+	long f_bsize;
+	long f_blocks;
+	long f_bfree;
+	long f_bavail;
+	long f_files;
+	long f_ffree;
+	__kernel_fsid_t f_fsid;
+	long f_namelen;
+	long f_spare[6];
+};
+
+
 
 #endif /* _ASM_IA64_STATFS_H */
diff -Nru a/include/asm-ia64/unistd.h b/include/asm-ia64/unistd.h
--- a/include/asm-ia64/unistd.h	Fri Oct 18 10:07:29 2002
+++ b/include/asm-ia64/unistd.h	Fri Oct 18 10:07:29 2002
@@ -92,7 +92,9 @@
 #define __NR_getpriority		1101
 #define __NR_setpriority		1102
 #define __NR_statfs			1103
+#define __NR_statfs64			__NR_statfs
 #define __NR_fstatfs			1104
+#define __NR_fstatfs64			__NR_fstatfs
 #define __NR_gettid			1105
 #define __NR_semget			1106
 #define __NR_semop			1107
diff -Nru a/include/linux/coda_psdev.h b/include/linux/coda_psdev.h
--- a/include/linux/coda_psdev.h	Fri Oct 18 10:07:30 2002
+++ b/include/linux/coda_psdev.h	Fri Oct 18 10:07:30 2002
@@ -71,7 +71,7 @@
 		 unsigned int cmd, struct PioctlData *data);
 int coda_downcall(int opcode, union outputArgs *out, struct super_block *sb);
 int venus_fsync(struct super_block *sb, struct ViceFid *fid);
-int venus_statfs(struct super_block *sb, struct statfs *sfs);
+int venus_statfs(struct super_block *sb, struct kstatfs *sfs);
 
 
 /* messages between coda filesystem in kernel and Venus */
diff -Nru a/include/linux/efs_fs.h b/include/linux/efs_fs.h
--- a/include/linux/efs_fs.h	Fri Oct 18 10:07:29 2002
+++ b/include/linux/efs_fs.h	Fri Oct 18 10:07:29 2002
@@ -54,7 +54,7 @@
 extern struct address_space_operations efs_symlink_aops;
 
 extern int efs_fill_super(struct super_block *, void *, int);
-extern int efs_statfs(struct super_block *, struct statfs *);
+extern int efs_statfs(struct super_block *, struct kstatfs *);
 
 extern void efs_read_inode(struct inode *);
 extern efs_block_t efs_map_block(struct inode *, efs_block_t);
diff -Nru a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
--- a/include/linux/ext3_fs.h	Fri Oct 18 10:07:30 2002
+++ b/include/linux/ext3_fs.h	Fri Oct 18 10:07:30 2002
@@ -755,7 +755,7 @@
 extern void ext3_write_super_lockfs (struct super_block *);
 extern void ext3_unlockfs (struct super_block *);
 extern int ext3_remount (struct super_block *, int *, char *);
-extern int ext3_statfs (struct super_block *, struct statfs *);
+extern int ext3_statfs (struct super_block *, struct kstatfs *);
 
 #define ext3_std_error(sb, errno)				\
 do {								\
diff -Nru a/include/linux/fat_cvf.h b/include/linux/fat_cvf.h
--- a/include/linux/fat_cvf.h	Fri Oct 18 10:07:29 2002
+++ b/include/linux/fat_cvf.h	Fri Oct 18 10:07:29 2002
@@ -24,7 +24,7 @@
                         int nbreq,
                         struct buffer_head *bh[32]);
   int (*fat_access) (struct super_block *sb,int nr,int new_value);
-  int (*cvf_statfs) (struct super_block *sb,struct statfs *buf, int bufsiz);
+  int (*cvf_statfs) (struct super_block *sb,struct kstatfs *buf, int bufsiz);
   int (*cvf_bmap) (struct inode *inode,int block);
   ssize_t (*cvf_file_read) ( struct file *, char *, size_t, loff_t *);
   ssize_t (*cvf_file_write) ( struct file *, const char *, size_t, loff_t *);
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Fri Oct 18 10:07:29 2002
+++ b/include/linux/fs.h	Fri Oct 18 10:07:29 2002
@@ -23,6 +23,7 @@
 #include <linux/string.h>
 #include <linux/radix-tree.h>
 #include <linux/bitops.h>
+#include <linux/statfs.h>
 
 #include <asm/atomic.h>
 
@@ -813,7 +814,7 @@
 	void (*write_super) (struct super_block *);
 	void (*write_super_lockfs) (struct super_block *);
 	void (*unlockfs) (struct super_block *);
-	int (*statfs) (struct super_block *, struct statfs *);
+	int (*statfs) (struct super_block *, struct kstatfs *);
 	int (*remount_fs) (struct super_block *, int *, char *);
 	void (*clear_inode) (struct inode *);
 	void (*umount_begin) (struct super_block *);
@@ -999,7 +1000,7 @@
 
 #define kern_umount mntput
 
-extern int vfs_statfs(struct super_block *, struct statfs *);
+extern int vfs_statfs(struct super_block *, struct kstatfs *);
 
 /* Return value for VFS lock functions - tells locks.c to lock conventionally
  * REALLY kosha for root NFS and nfs_lock
@@ -1294,7 +1295,7 @@
 extern int dcache_dir_close(struct inode *, struct file *);
 extern loff_t dcache_dir_lseek(struct file *, loff_t, int);
 extern int dcache_readdir(struct file *, void *, filldir_t);
-extern int simple_statfs(struct super_block *, struct statfs *);
+extern int simple_statfs(struct super_block *, struct kstatfs *);
 extern int simple_link(struct dentry *, struct inode *, struct dentry *);
 extern int simple_unlink(struct inode *, struct dentry *);
 extern int simple_rmdir(struct inode *, struct dentry *);
diff -Nru a/include/linux/msdos_fs.h b/include/linux/msdos_fs.h
--- a/include/linux/msdos_fs.h	Fri Oct 18 10:07:30 2002
+++ b/include/linux/msdos_fs.h	Fri Oct 18 10:07:30 2002
@@ -293,7 +293,7 @@
 extern void fat_put_super(struct super_block *sb);
 int fat_fill_super(struct super_block *sb, void *data, int silent,
 		   struct inode_operations *fs_dir_inode_ops, int isvfat);
-extern int fat_statfs(struct super_block *sb, struct statfs *buf);
+extern int fat_statfs(struct super_block *sb, struct kstatfs *buf);
 extern void fat_write_inode(struct inode *inode, int wait);
 extern int fat_notify_change(struct dentry * dentry, struct iattr * attr);
 
diff -Nru a/include/linux/nfsd/nfsd.h b/include/linux/nfsd/nfsd.h
--- a/include/linux/nfsd/nfsd.h	Fri Oct 18 10:07:29 2002
+++ b/include/linux/nfsd/nfsd.h	Fri Oct 18 10:07:29 2002
@@ -121,7 +121,7 @@
 				u32 *buffer, int *countp, u32 *verf,
 				u32 *bmval);
 int		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
-				struct statfs *);
+				struct kstatfs *);
 
 int		nfsd_notify_change(struct inode *, struct iattr *);
 int		nfsd_permission(struct svc_export *, struct dentry *, int);
diff -Nru a/include/linux/nfsd/xdr.h b/include/linux/nfsd/xdr.h
--- a/include/linux/nfsd/xdr.h	Fri Oct 18 10:07:30 2002
+++ b/include/linux/nfsd/xdr.h	Fri Oct 18 10:07:30 2002
@@ -101,7 +101,7 @@
 };
 
 struct nfsd_statfsres {
-	struct statfs		stats;
+	struct kstatfs		stats;
 };
 
 /*
diff -Nru a/include/linux/nfsd/xdr3.h b/include/linux/nfsd/xdr3.h
--- a/include/linux/nfsd/xdr3.h	Fri Oct 18 10:07:29 2002
+++ b/include/linux/nfsd/xdr3.h	Fri Oct 18 10:07:29 2002
@@ -160,7 +160,7 @@
 
 struct nfsd3_fsstatres {
 	__u32			status;
-	struct statfs		stats;
+	struct kstatfs		stats;
 	__u32			invarsec;
 };
 
diff -Nru a/include/linux/statfs.h b/include/linux/statfs.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/statfs.h	Fri Oct 18 10:07:30 2002
@@ -0,0 +1,26 @@
+#ifndef _LINUX_STATFS_H
+#define _LINUX_STATFS_H
+
+#include <linux/types.h>
+
+#ifndef __KERNEL_STRICT_NAMES
+typedef __kernel_fsid_t	fsid_t;
+#endif
+
+#include <asm/statfs.h>
+
+struct kstatfs {
+	long f_type;
+	long f_bsize;
+	sector_t f_blocks;
+	sector_t f_bfree;
+	sector_t f_bavail;
+	sector_t f_files;
+	sector_t f_ffree;
+	__kernel_fsid_t f_fsid;
+	long f_namelen;
+	long f_frsize;
+	long f_spare[5];
+};
+
+#endif
diff -Nru a/mm/shmem.c b/mm/shmem.c
--- a/mm/shmem.c	Fri Oct 18 10:07:29 2002
+++ b/mm/shmem.c	Fri Oct 18 10:07:29 2002
@@ -1252,7 +1252,7 @@
 	return retval;
 }
 
-static int shmem_statfs(struct super_block *sb, struct statfs *buf)
+static int shmem_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 
