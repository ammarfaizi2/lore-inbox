Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262959AbSJaXso>; Thu, 31 Oct 2002 18:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265463AbSJaXso>; Thu, 31 Oct 2002 18:48:44 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:15096 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S262959AbSJaXrD>; Thu, 31 Oct 2002 18:47:03 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15809.49776.16863.56764@wombat.chubb.wattle.id.au>
Date: Fri, 1 Nov 2002 10:53:20 +1100
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org, woodard@redhat.com
Subject: [patch] Updated statfs64
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus, others,
   The attached patch is for the core part of statfs64 and fstatfs64.

The approach taken is to isolate the in-kernel form of struct statfs
from the forms exported to userland. Hence, a new structure, struct
kstatfs, is defined, that is exactly the same as the old struct
statfs, except that it uses sector_t not long for fields that could
usefully be 64-bit on a system with large block devices (or large
network-mounted filesystems).

struct kstatfs is then converted at system call time to either a
struct statfs or a struct statfs64.

Still to do: add the f_frsize (allocation granularity) implementation
(the code to copy it to/from user space is there, just the filesystems
need to be updated to report it)

===============================
ChangeSet@1.857, 2002-11-01 10:02:34+11:00, peterc@gelato.unsw.edu.au
  1. As per Ben LaHaises's request, add size argument to statfs64 
  and fstatfs64.
  
  2. As the definition of statfs.h appears almost the same for all
  architectures, use linux/statfs.h for the in-kernel definition, and
  asm-generic/statfs.h for the per-arch definition.  Architectures
  that support 32 and 64-bit user-land will have to do something
  special.

ChangeSet@1.856, 2002-10-31 21:00:04+11:00, peterc@gelato.unsw.edu.au
  Manual merge of statfs64 patch into linux 2.5.45

ChangeSet@1.791.15.1, 2002-10-18 09:59:49+10:00, peterc@gelato.unsw.edu.au
  Implement statfs64 and fstatfs64 for IA64 and I386. (Other
  architectures later, if this passes peer review).
  
  -- Add a new type struct kstatfs that is variable sized depending on
     CONFIG_LBD.    This type is used for all in-kernel communication
     between filesystems and the system calls.
  -- Convert to the user-expected form in the system call code.
  
  Todo:
  	-- Add support for new field, f_frsize in each filesystem
  	-- Add support for other architectures.
  	-- (Maybe) move struct statfs to asm-generic

=====================================
diffstat output:
 arch/i386/kernel/entry.S     |    3 -
 fs/adfs/super.c              |    4 -
 fs/affs/super.c              |    4 -
 fs/bfs/inode.c               |    2 
 fs/cifs/cifsfs.c             |    2 
 fs/coda/inode.c              |    4 -
 fs/coda/upcall.c             |    2 
 fs/cramfs/inode.c            |    2 
 fs/efs/super.c               |    2 
 fs/ext2/super.c              |    4 -
 fs/ext3/super.c              |    2 
 fs/fat/inode.c               |    2 
 fs/freevxfs/vxfs_super.c     |    4 -
 fs/hfs/super.c               |    4 -
 fs/hpfs/hpfs_fn.h            |    2 
 fs/hpfs/super.c              |    2 
 fs/isofs/inode.c             |    4 -
 fs/jfs/super.c               |    2 
 fs/libfs.c                   |    2 
 fs/minix/inode.c             |    4 -
 fs/ncpfs/inode.c             |    4 -
 fs/nfs/inode.c               |    4 -
 fs/nfsd/nfs3xdr.c            |    2 
 fs/nfsd/nfs4xdr.c            |    2 
 fs/nfsd/nfsxdr.c             |    2 
 fs/nfsd/vfs.c                |    2 
 fs/ntfs/super.c              |    2 
 fs/open.c                    |  112 +++++++++++++++++++++++++++++++++++++++----
 fs/qnx4/inode.c              |    4 -
 fs/reiserfs/super.c          |    4 -
 fs/romfs/inode.c             |    2 
 fs/smbfs/inode.c             |    4 -
 fs/super.c                   |    2 
 fs/sysv/inode.c              |    2 
 fs/udf/super.c               |    4 -
 fs/ufs/super.c               |    6 +-
 fs/xfs/linux/xfs_super.c     |    4 -
 fs/xfs/linux/xfs_vfs.h       |    4 -
 fs/xfs/xfs_vfsops.c          |    4 -
 include/asm-generic/statfs.h |   39 ++++++++++++++
 include/asm-i386/statfs.h    |   21 --------
 include/asm-i386/unistd.h    |    3 -
 include/asm-ia64/statfs.h    |   24 +++++++--
 include/asm-ia64/unistd.h    |    2 
 include/linux/coda_psdev.h   |    2 
 include/linux/efs_fs.h       |    2 
 include/linux/ext3_fs.h      |    2 
 include/linux/fs.h           |    7 +-
 include/linux/msdos_fs.h     |    2 
 include/linux/nfsd/nfsd.h    |    2 
 include/linux/nfsd/xdr.h     |    2 
 include/linux/nfsd/xdr3.h    |    2 
 include/linux/statfs.h       |   26 +++++++++
 include/linux/vfs.h          |    2 
 mm/shmem.c                   |    2 
 55 files changed, 263 insertions(+), 104 deletions(-)

diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/arch/i386/kernel/entry.S linux-2.5-lbd/arch/i386/kernel/entry.S
--- linux-2.5.45/arch/i386/kernel/entry.S	Fri Nov  1 08:47:16 2002
+++ linux-2.5-lbd/arch/i386/kernel/entry.S	Fri Nov  1 10:03:13 2002
@@ -740,7 +740,8 @@
 	.long sys_epoll_create
 	.long sys_epoll_ctl	/* 255 */
 	.long sys_epoll_wait
-
+	.long sys_statfs64
+	.long sys_fstatfs64
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/adfs/super.c linux-2.5-lbd/fs/adfs/super.c
--- linux-2.5.45/fs/adfs/super.c	Fri Nov  1 08:49:32 2002
+++ linux-2.5-lbd/fs/adfs/super.c	Fri Nov  1 10:06:09 2002
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/affs/super.c linux-2.5-lbd/fs/affs/super.c
--- linux-2.5.45/fs/affs/super.c	Fri Nov  1 08:49:32 2002
+++ linux-2.5-lbd/fs/affs/super.c	Fri Nov  1 10:06:10 2002
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
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/bfs/inode.c linux-2.5-lbd/fs/bfs/inode.c
--- linux-2.5.45/fs/bfs/inode.c	Fri Nov  1 08:49:32 2002
+++ linux-2.5-lbd/fs/bfs/inode.c	Fri Nov  1 10:06:13 2002
@@ -187,7 +187,7 @@
 	s->s_fs_info = NULL;
 }
 
-static int bfs_statfs(struct super_block *s, struct statfs *buf)
+static int bfs_statfs(struct super_block *s, struct kstatfs *buf)
 {
 	struct bfs_sb_info *info = BFS_SB(s);
 	buf->f_type = BFS_MAGIC;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/cifs/cifsfs.c linux-2.5-lbd/fs/cifs/cifsfs.c
--- linux-2.5.45/fs/cifs/cifsfs.c	Fri Nov  1 08:49:32 2002
+++ linux-2.5-lbd/fs/cifs/cifsfs.c	Fri Nov  1 10:06:13 2002
@@ -127,7 +127,7 @@
 }
 
 int
-cifs_statfs(struct super_block *sb, struct statfs *buf)
+cifs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	int xid, rc;
 	struct cifs_sb_info *cifs_sb;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/coda/inode.c linux-2.5-lbd/fs/coda/inode.c
--- linux-2.5.45/fs/coda/inode.c	Fri Nov  1 08:49:32 2002
+++ linux-2.5-lbd/fs/coda/inode.c	Fri Nov  1 10:06:13 2002
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
 	
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/coda/upcall.c linux-2.5-lbd/fs/coda/upcall.c
--- linux-2.5.45/fs/coda/upcall.c	Fri Nov  1 08:49:32 2002
+++ linux-2.5-lbd/fs/coda/upcall.c	Fri Nov  1 10:06:14 2002
@@ -584,7 +584,7 @@
 	return error;
 }
 
-int venus_statfs(struct super_block *sb, struct statfs *sfs) 
+int venus_statfs(struct super_block *sb, struct kstatfs *sfs) 
 { 
         union inputArgs *inp;
         union outputArgs *outp;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/cramfs/inode.c linux-2.5-lbd/fs/cramfs/inode.c
--- linux-2.5.45/fs/cramfs/inode.c	Fri Nov  1 08:49:32 2002
+++ linux-2.5-lbd/fs/cramfs/inode.c	Fri Nov  1 10:06:14 2002
@@ -262,7 +262,7 @@
 	return -EINVAL;
 }
 
-static int cramfs_statfs(struct super_block *sb, struct statfs *buf)
+static int cramfs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	buf->f_type = CRAMFS_MAGIC;
 	buf->f_bsize = PAGE_CACHE_SIZE;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/efs/super.c linux-2.5-lbd/fs/efs/super.c
--- linux-2.5.45/fs/efs/super.c	Fri Nov  1 08:49:32 2002
+++ linux-2.5-lbd/fs/efs/super.c	Fri Nov  1 10:06:14 2002
@@ -277,7 +277,7 @@
 	return -EINVAL;
 }
 
-int efs_statfs(struct super_block *s, struct statfs *buf) {
+int efs_statfs(struct super_block *s, struct kstatfs *buf) {
 	struct efs_sb_info *sb = SUPER_INFO(s);
 
 	buf->f_type    = EFS_SUPER_MAGIC;	/* efs magic number */
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/ext2/super.c linux-2.5-lbd/fs/ext2/super.c
--- linux-2.5.45/fs/ext2/super.c	Fri Nov  1 08:49:32 2002
+++ linux-2.5-lbd/fs/ext2/super.c	Fri Nov  1 10:06:14 2002
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/ext3/super.c linux-2.5-lbd/fs/ext3/super.c
--- linux-2.5.45/fs/ext3/super.c	Fri Nov  1 08:49:32 2002
+++ linux-2.5-lbd/fs/ext3/super.c	Fri Nov  1 10:06:14 2002
@@ -1759,7 +1759,7 @@
 	return 0;
 }
 
-int ext3_statfs (struct super_block * sb, struct statfs * buf)
+int ext3_statfs (struct super_block * sb, struct kstatfs * buf)
 {
 	struct ext3_super_block *es = EXT3_SB(sb)->s_es;
 	unsigned long overhead;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/fat/inode.c linux-2.5-lbd/fs/fat/inode.c
--- linux-2.5.45/fs/fat/inode.c	Fri Nov  1 08:49:32 2002
+++ linux-2.5-lbd/fs/fat/inode.c	Fri Nov  1 10:06:15 2002
@@ -1004,7 +1004,7 @@
 	return error;
 }
 
-int fat_statfs(struct super_block *sb,struct statfs *buf)
+int fat_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	int free,nr;
        
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/freevxfs/vxfs_super.c linux-2.5-lbd/fs/freevxfs/vxfs_super.c
--- linux-2.5.45/fs/freevxfs/vxfs_super.c	Fri Nov  1 08:49:33 2002
+++ linux-2.5-lbd/fs/freevxfs/vxfs_super.c	Fri Nov  1 10:06:16 2002
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
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/hfs/super.c linux-2.5-lbd/fs/hfs/super.c
--- linux-2.5.45/fs/hfs/super.c	Fri Nov  1 08:49:34 2002
+++ linux-2.5-lbd/fs/hfs/super.c	Fri Nov  1 10:06:17 2002
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
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/hpfs/hpfs_fn.h linux-2.5-lbd/fs/hpfs/hpfs_fn.h
--- linux-2.5.45/fs/hpfs/hpfs_fn.h	Fri Nov  1 08:49:34 2002
+++ linux-2.5-lbd/fs/hpfs/hpfs_fn.h	Fri Nov  1 10:06:17 2002
@@ -306,7 +306,7 @@
 int hpfs_remount_fs(struct super_block *, int *, char *);
 void hpfs_put_super(struct super_block *);
 unsigned hpfs_count_one_bitmap(struct super_block *, secno);
-int hpfs_statfs(struct super_block *, struct statfs *);
+int hpfs_statfs(struct super_block *, struct kstatfs *);
 
 extern struct address_space_operations hpfs_aops;
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/hpfs/super.c linux-2.5-lbd/fs/hpfs/super.c
--- linux-2.5.45/fs/hpfs/super.c	Fri Nov  1 08:49:34 2002
+++ linux-2.5-lbd/fs/hpfs/super.c	Fri Nov  1 10:06:17 2002
@@ -135,7 +135,7 @@
 	return count;
 }
 
-int hpfs_statfs(struct super_block *s, struct statfs *buf)
+int hpfs_statfs(struct super_block *s, struct kstatfs *buf)
 {
 	struct hpfs_sb_info *sbi = hpfs_sb(s);
 	lock_kernel();
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/isofs/inode.c linux-2.5-lbd/fs/isofs/inode.c
--- linux-2.5.45/fs/isofs/inode.c	Fri Nov  1 08:49:34 2002
+++ linux-2.5-lbd/fs/isofs/inode.c	Fri Nov  1 10:06:18 2002
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/jfs/super.c linux-2.5-lbd/fs/jfs/super.c
--- linux-2.5.45/fs/jfs/super.c	Fri Nov  1 08:49:34 2002
+++ linux-2.5-lbd/fs/jfs/super.c	Fri Nov  1 10:06:21 2002
@@ -97,7 +97,7 @@
 	kmem_cache_free(jfs_inode_cachep, JFS_IP(inode));
 }
 
-static int jfs_statfs(struct super_block *sb, struct statfs *buf)
+static int jfs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	struct jfs_sb_info *sbi = JFS_SBI(sb);
 	s64 maxinodes;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/libfs.c linux-2.5-lbd/fs/libfs.c
--- linux-2.5.45/fs/libfs.c	Fri Nov  1 08:49:32 2002
+++ linux-2.5-lbd/fs/libfs.c	Fri Nov  1 10:06:09 2002
@@ -6,7 +6,7 @@
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 
-int simple_statfs(struct super_block *sb, struct statfs *buf)
+int simple_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = PAGE_CACHE_SIZE;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/minix/inode.c linux-2.5-lbd/fs/minix/inode.c
--- linux-2.5.45/fs/minix/inode.c	Fri Nov  1 08:49:34 2002
+++ linux-2.5-lbd/fs/minix/inode.c	Fri Nov  1 10:06:22 2002
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/ncpfs/inode.c linux-2.5-lbd/fs/ncpfs/inode.c
--- linux-2.5.45/fs/ncpfs/inode.c	Fri Nov  1 08:49:34 2002
+++ linux-2.5-lbd/fs/ncpfs/inode.c	Fri Nov  1 10:06:22 2002
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/nfs/inode.c linux-2.5-lbd/fs/nfs/inode.c
--- linux-2.5.45/fs/nfs/inode.c	Fri Nov  1 08:49:34 2002
+++ linux-2.5-lbd/fs/nfs/inode.c	Fri Nov  1 10:06:22 2002
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/nfsd/nfs3xdr.c linux-2.5-lbd/fs/nfsd/nfs3xdr.c
--- linux-2.5.45/fs/nfsd/nfs3xdr.c	Fri Nov  1 08:49:34 2002
+++ linux-2.5-lbd/fs/nfsd/nfs3xdr.c	Fri Nov  1 10:06:22 2002
@@ -790,7 +790,7 @@
 nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, u32 *p,
 					struct nfsd3_fsstatres *resp)
 {
-	struct statfs	*s = &resp->stats;
+	struct kstatfs	*s = &resp->stats;
 	u64		bs = s->f_bsize;
 
 	*p++ = xdr_zero;	/* no post_op_attr */
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/nfsd/nfs4xdr.c linux-2.5-lbd/fs/nfsd/nfs4xdr.c
--- linux-2.5.45/fs/nfsd/nfs4xdr.c	Fri Nov  1 08:49:34 2002
+++ linux-2.5-lbd/fs/nfsd/nfs4xdr.c	Fri Nov  1 10:06:22 2002
@@ -976,7 +976,7 @@
 	struct name_ent *owner = NULL;
 	struct name_ent *group = NULL;
 	struct svc_fh tempfh;
-	struct statfs statfs;
+	struct kstatfs statfs;
 	int buflen = *countp << 2;
 	u32 *attrlenp;
 	u32 dummy;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/nfsd/nfsxdr.c linux-2.5-lbd/fs/nfsd/nfsxdr.c
--- linux-2.5.45/fs/nfsd/nfsxdr.c	Fri Nov  1 08:49:34 2002
+++ linux-2.5-lbd/fs/nfsd/nfsxdr.c	Fri Nov  1 10:06:23 2002
@@ -415,7 +415,7 @@
 nfssvc_encode_statfsres(struct svc_rqst *rqstp, u32 *p,
 					struct nfsd_statfsres *resp)
 {
-	struct statfs	*stat = &resp->stats;
+	struct kstatfs	*stat = &resp->stats;
 
 	*p++ = htonl(NFSSVC_MAXBLKSIZE);	/* max transfer size */
 	*p++ = htonl(stat->f_bsize);
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/nfsd/vfs.c linux-2.5-lbd/fs/nfsd/vfs.c
--- linux-2.5.45/fs/nfsd/vfs.c	Fri Nov  1 08:49:34 2002
+++ linux-2.5-lbd/fs/nfsd/vfs.c	Fri Nov  1 10:06:23 2002
@@ -1434,7 +1434,7 @@
  * N.B. After this call fhp needs an fh_put
  */
 int
-nfsd_statfs(struct svc_rqst *rqstp, struct svc_fh *fhp, struct statfs *stat)
+nfsd_statfs(struct svc_rqst *rqstp, struct svc_fh *fhp, struct kstatfs *stat)
 {
 	int err = fh_verify(rqstp, fhp, 0, MAY_NOP);
 	if (!err && vfs_statfs(fhp->fh_dentry->d_inode->i_sb,stat))
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/ntfs/super.c linux-2.5-lbd/fs/ntfs/super.c
--- linux-2.5.45/fs/ntfs/super.c	Fri Nov  1 08:49:34 2002
+++ linux-2.5-lbd/fs/ntfs/super.c	Fri Nov  1 10:06:24 2002
@@ -1220,7 +1220,7 @@
  *
  * Return 0 on success or -errno on error.
  */
-static int ntfs_statfs(struct super_block *sb, struct statfs *sfs)
+static int ntfs_statfs(struct super_block *sb, struct kstatfs *sfs)
 {
 	ntfs_volume *vol = NTFS_SB(sb);
 	s64 size;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/open.c linux-2.5-lbd/fs/open.c
--- linux-2.5.45/fs/open.c	Fri Nov  1 08:49:32 2002
+++ linux-2.5-lbd/fs/open.c	Fri Nov  1 10:06:09 2002
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
@@ -40,23 +40,96 @@
 }
 
 
-asmlinkage long sys_statfs(const char * path, struct statfs * buf)
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
+asmlinkage long sys_statfs(const char *path, struct statfs *buf)
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
 			error = -EFAULT;
 		path_release(&nd);
 	}
 	return error;
 }
 
-asmlinkage long sys_fstatfs(unsigned int fd, struct statfs * buf)
+asmlinkage long sys_statfs64(const char *path, size_t sz, struct statfs64 *buf)
+{
+	struct nameidata nd;
+	long error;
+
+	if (sz != sizeof(*buf))
+		return -EINVAL;
+	error = user_path_walk(path, &nd);
+	if (!error) {
+		struct statfs64 tmp;
+		error = vfs_statfs64(nd.dentry->d_inode->i_sb, &tmp);
+		if (!error && copy_to_user(buf, &tmp, sizeof(tmp)))
+			error = -EFAULT;
+		path_release(&nd);
+	}
+	return error;
+}
+
+asmlinkage long sys_fstatfs(unsigned int fd, struct statfs *buf)
 {
 	struct file * file;
 	struct statfs tmp;
@@ -66,8 +139,29 @@
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
+asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz, struct statfs64 *buf)
+{
+	struct file * file;
+	struct statfs64 tmp;
+	int error;
+
+	if (sz != sizeof(*buf))
+		return -EINVAL;
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/qnx4/inode.c linux-2.5-lbd/fs/qnx4/inode.c
--- linux-2.5.45/fs/qnx4/inode.c	Fri Nov  1 08:49:34 2002
+++ linux-2.5-lbd/fs/qnx4/inode.c	Fri Nov  1 10:06:27 2002
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
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/reiserfs/super.c linux-2.5-lbd/fs/reiserfs/super.c
--- linux-2.5.45/fs/reiserfs/super.c	Fri Nov  1 08:49:34 2002
+++ linux-2.5-lbd/fs/reiserfs/super.c	Fri Nov  1 10:06:28 2002
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
   
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/romfs/inode.c linux-2.5-lbd/fs/romfs/inode.c
--- linux-2.5.45/fs/romfs/inode.c	Fri Nov  1 08:49:34 2002
+++ linux-2.5-lbd/fs/romfs/inode.c	Fri Nov  1 10:06:28 2002
@@ -175,7 +175,7 @@
 /* That's simple too. */
 
 static int
-romfs_statfs(struct super_block *sb, struct statfs *buf)
+romfs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	buf->f_type = ROMFS_MAGIC;
 	buf->f_bsize = ROMBSIZE;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/smbfs/inode.c linux-2.5-lbd/fs/smbfs/inode.c
--- linux-2.5.45/fs/smbfs/inode.c	Fri Nov  1 08:49:35 2002
+++ linux-2.5-lbd/fs/smbfs/inode.c	Fri Nov  1 10:06:28 2002
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
 	
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/super.c linux-2.5-lbd/fs/super.c
--- linux-2.5.45/fs/super.c	Fri Nov  1 08:49:32 2002
+++ linux-2.5-lbd/fs/super.c	Fri Nov  1 10:06:09 2002
@@ -352,7 +352,7 @@
 {
         struct super_block *s;
         struct ustat tmp;
-        struct statfs sbuf;
+        struct kstatfs sbuf;
 	int err = -EINVAL;
 
         s = user_get_super(dev);
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/sysv/inode.c linux-2.5-lbd/fs/sysv/inode.c
--- linux-2.5.45/fs/sysv/inode.c	Fri Nov  1 08:49:35 2002
+++ linux-2.5-lbd/fs/sysv/inode.c	Fri Nov  1 10:06:28 2002
@@ -74,7 +74,7 @@
 	kfree(sbi);
 }
 
-static int sysv_statfs(struct super_block *sb, struct statfs *buf)
+static int sysv_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	struct sysv_sb_info *sbi = SYSV_SB(sb);
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/udf/super.c linux-2.5-lbd/fs/udf/super.c
--- linux-2.5.45/fs/udf/super.c	Fri Nov  1 08:49:35 2002
+++ linux-2.5-lbd/fs/udf/super.c	Fri Nov  1 10:06:28 2002
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
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/ufs/super.c linux-2.5-lbd/fs/ufs/super.c
--- linux-2.5.45/fs/ufs/super.c	Fri Nov  1 08:49:35 2002
+++ linux-2.5-lbd/fs/ufs/super.c	Fri Nov  1 10:06:29 2002
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/xfs/linux/xfs_super.c linux-2.5-lbd/fs/xfs/linux/xfs_super.c
--- linux-2.5.45/fs/xfs/linux/xfs_super.c	Fri Nov  1 08:49:45 2002
+++ linux-2.5-lbd/fs/xfs/linux/xfs_super.c	Fri Nov  1 10:06:35 2002
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/xfs/linux/xfs_vfs.h linux-2.5-lbd/fs/xfs/linux/xfs_vfs.h
--- linux-2.5.45/fs/xfs/linux/xfs_vfs.h	Fri Nov  1 08:49:45 2002
+++ linux-2.5-lbd/fs/xfs/linux/xfs_vfs.h	Fri Nov  1 10:06:35 2002
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/fs/xfs/xfs_vfsops.c linux-2.5-lbd/fs/xfs/xfs_vfsops.c
--- linux-2.5.45/fs/xfs/xfs_vfsops.c	Fri Nov  1 08:49:45 2002
+++ linux-2.5-lbd/fs/xfs/xfs_vfsops.c	Fri Nov  1 10:06:34 2002
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
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/include/asm-generic/statfs.h linux-2.5-lbd/include/asm-generic/statfs.h
--- linux-2.5.45/include/asm-generic/statfs.h	Thu Jan  1 10:00:00 1970
+++ linux-2.5-lbd/include/asm-generic/statfs.h	Fri Nov  1 10:06:48 2002
@@ -0,0 +1,39 @@
+/*
+ * Generic implementation of struct statfs and struct statfs64.
+ */
+
+#ifndef _ASM_GENERIC_STATFS_H_
+#define _ASM_GENERIC_STATFS_H_
+
+
+
+struct statfs {
+	long f_type;		/* filesystem type */
+	long f_bsize;		/* optimum I/O size (bytes) */
+	long f_blocks;		/* total number of f_bsize blocks in the FS */
+	long f_bfree;		/* number of free f_bsize blocks */
+	long f_bavail;		/* number of available-to-mere-mortals blocks */
+	long f_files;		/* total number of files (inodes) */
+	long f_ffree;		/* number of files available   */
+	__kernel_fsid_t f_fsid;	/* file system ID */
+	long f_namelen;		/* length of filenames on the filesystem */
+	long f_frsize;		/* `fragment' size -- underlying minimum allocation length */
+	long f_spare[5];
+};
+
+struct statfs64 {
+	long f_type;		/* filesystem type */
+	long f_bsize;		/* optimum I/O size (bytes) */
+	long long f_blocks;	/* total number of f_bsize blocks in the FS */
+	long long f_bfree;	/* number of free f_bsize blocks */
+	long long f_bavail;	/* number of available-to-mere-mortals blocks */
+	long long f_files;	/* total number of files (inodes) */
+	long long f_ffree;	/* number of files available   */
+	__kernel_fsid_t f_fsid;	/* file system ID */
+	long f_namelen;		/* length of filenames on the filesystem */
+	long f_frsize;		/* `fragment' size -- underlying minimum allocation length */
+	long f_spare[5];
+};
+
+
+#endif
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/include/asm-i386/statfs.h linux-2.5-lbd/include/asm-i386/statfs.h
--- linux-2.5.45/include/asm-i386/statfs.h	Fri Nov  1 08:49:58 2002
+++ linux-2.5-lbd/include/asm-i386/statfs.h	Fri Nov  1 10:06:50 2002
@@ -1,25 +1,6 @@
 #ifndef _I386_STATFS_H
 #define _I386_STATFS_H
 
-#ifndef __KERNEL_STRICT_NAMES
-
-#include <linux/types.h>
-
-typedef __kernel_fsid_t	fsid_t;
-
-#endif
-
-struct statfs {
-	long f_type;
-	long f_bsize;
-	long f_blocks;
-	long f_bfree;
-	long f_bavail;
-	long f_files;
-	long f_ffree;
-	__kernel_fsid_t f_fsid;
-	long f_namelen;
-	long f_spare[6];
-};
+#include <asm-generic/statfs.h>
 
 #endif
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/include/asm-i386/unistd.h linux-2.5-lbd/include/asm-i386/unistd.h
--- linux-2.5.45/include/asm-i386/unistd.h	Fri Nov  1 08:49:58 2002
+++ linux-2.5-lbd/include/asm-i386/unistd.h	Fri Nov  1 10:06:50 2002
@@ -261,7 +261,8 @@
 #define __NR_sys_epoll_create	254
 #define __NR_sys_epoll_ctl	255
 #define __NR_sys_epoll_wait	256
-  
+#define __NR_statfs64		257
+#define __NR_fstatfs64		258  
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/include/asm-ia64/statfs.h linux-2.5-lbd/include/asm-ia64/statfs.h
--- linux-2.5.45/include/asm-ia64/statfs.h	Fri Nov  1 08:49:58 2002
+++ linux-2.5-lbd/include/asm-ia64/statfs.h	Fri Nov  1 10:06:53 2002
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/include/asm-ia64/unistd.h linux-2.5-lbd/include/asm-ia64/unistd.h
--- linux-2.5.45/include/asm-ia64/unistd.h	Fri Nov  1 08:49:58 2002
+++ linux-2.5-lbd/include/asm-ia64/unistd.h	Fri Nov  1 10:06:53 2002
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/include/linux/coda_psdev.h linux-2.5-lbd/include/linux/coda_psdev.h
--- linux-2.5.45/include/linux/coda_psdev.h	Fri Nov  1 08:50:22 2002
+++ linux-2.5-lbd/include/linux/coda_psdev.h	Fri Nov  1 10:07:28 2002
@@ -71,7 +71,7 @@
 		 unsigned int cmd, struct PioctlData *data);
 int coda_downcall(int opcode, union outputArgs *out, struct super_block *sb);
 int venus_fsync(struct super_block *sb, struct ViceFid *fid);
-int venus_statfs(struct super_block *sb, struct statfs *sfs);
+int venus_statfs(struct super_block *sb, struct kstatfs *sfs);
 
 
 /* messages between coda filesystem in kernel and Venus */
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/include/linux/efs_fs.h linux-2.5-lbd/include/linux/efs_fs.h
--- linux-2.5.45/include/linux/efs_fs.h	Fri Nov  1 08:50:22 2002
+++ linux-2.5-lbd/include/linux/efs_fs.h	Fri Nov  1 10:07:29 2002
@@ -54,7 +54,7 @@
 extern struct address_space_operations efs_symlink_aops;
 
 extern int efs_fill_super(struct super_block *, void *, int);
-extern int efs_statfs(struct super_block *, struct statfs *);
+extern int efs_statfs(struct super_block *, struct kstatfs *);
 
 extern void efs_read_inode(struct inode *);
 extern efs_block_t efs_map_block(struct inode *, efs_block_t);
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/include/linux/ext3_fs.h linux-2.5-lbd/include/linux/ext3_fs.h
--- linux-2.5.45/include/linux/ext3_fs.h	Fri Nov  1 08:50:22 2002
+++ linux-2.5-lbd/include/linux/ext3_fs.h	Fri Nov  1 10:07:29 2002
@@ -755,7 +755,7 @@
 extern void ext3_write_super_lockfs (struct super_block *);
 extern void ext3_unlockfs (struct super_block *);
 extern int ext3_remount (struct super_block *, int *, char *);
-extern int ext3_statfs (struct super_block *, struct statfs *);
+extern int ext3_statfs (struct super_block *, struct kstatfs *);
 
 #define ext3_std_error(sb, errno)				\
 do {								\
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/include/linux/fs.h linux-2.5-lbd/include/linux/fs.h
--- linux-2.5.45/include/linux/fs.h	Fri Nov  1 08:50:22 2002
+++ linux-2.5-lbd/include/linux/fs.h	Fri Nov  1 10:07:29 2002
@@ -23,6 +23,7 @@
 #include <linux/string.h>
 #include <linux/radix-tree.h>
 #include <linux/bitops.h>
+#include <linux/statfs.h>
 
 #include <asm/atomic.h>
 
@@ -817,7 +818,7 @@
 	void (*write_super) (struct super_block *);
 	void (*write_super_lockfs) (struct super_block *);
 	void (*unlockfs) (struct super_block *);
-	int (*statfs) (struct super_block *, struct statfs *);
+	int (*statfs) (struct super_block *, struct kstatfs *);
 	int (*remount_fs) (struct super_block *, int *, char *);
 	void (*clear_inode) (struct inode *);
 	void (*umount_begin) (struct super_block *);
@@ -1003,7 +1004,7 @@
 
 #define kern_umount mntput
 
-extern int vfs_statfs(struct super_block *, struct statfs *);
+extern int vfs_statfs(struct super_block *, struct kstatfs *);
 
 /* Return value for VFS lock functions - tells locks.c to lock conventionally
  * REALLY kosha for root NFS and nfs_lock
@@ -1313,7 +1314,7 @@
 extern int dcache_dir_close(struct inode *, struct file *);
 extern loff_t dcache_dir_lseek(struct file *, loff_t, int);
 extern int dcache_readdir(struct file *, void *, filldir_t);
-extern int simple_statfs(struct super_block *, struct statfs *);
+extern int simple_statfs(struct super_block *, struct kstatfs *);
 extern int simple_link(struct dentry *, struct inode *, struct dentry *);
 extern int simple_unlink(struct inode *, struct dentry *);
 extern int simple_rmdir(struct inode *, struct dentry *);
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/include/linux/msdos_fs.h linux-2.5-lbd/include/linux/msdos_fs.h
--- linux-2.5.45/include/linux/msdos_fs.h	Fri Nov  1 08:50:23 2002
+++ linux-2.5-lbd/include/linux/msdos_fs.h	Fri Nov  1 10:07:33 2002
@@ -278,7 +278,7 @@
 extern void fat_put_super(struct super_block *sb);
 int fat_fill_super(struct super_block *sb, void *data, int silent,
 		   struct inode_operations *fs_dir_inode_ops, int isvfat);
-extern int fat_statfs(struct super_block *sb, struct statfs *buf);
+extern int fat_statfs(struct super_block *sb, struct kstatfs *buf);
 extern void fat_write_inode(struct inode *inode, int wait);
 extern int fat_notify_change(struct dentry * dentry, struct iattr * attr);
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/include/linux/nfsd/nfsd.h linux-2.5-lbd/include/linux/nfsd/nfsd.h
--- linux-2.5.45/include/linux/nfsd/nfsd.h	Fri Nov  1 08:50:24 2002
+++ linux-2.5-lbd/include/linux/nfsd/nfsd.h	Fri Nov  1 10:07:40 2002
@@ -110,7 +110,7 @@
 int		nfsd_readdir(struct svc_rqst *, struct svc_fh *,
 			     loff_t *, struct readdir_cd *, encode_dent_fn);
 int		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
-				struct statfs *);
+				struct kstatfs *);
 
 int		nfsd_notify_change(struct inode *, struct iattr *);
 int		nfsd_permission(struct svc_export *, struct dentry *, int);
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/include/linux/nfsd/xdr.h linux-2.5-lbd/include/linux/nfsd/xdr.h
--- linux-2.5.45/include/linux/nfsd/xdr.h	Fri Nov  1 08:50:24 2002
+++ linux-2.5-lbd/include/linux/nfsd/xdr.h	Fri Nov  1 10:07:40 2002
@@ -106,7 +106,7 @@
 };
 
 struct nfsd_statfsres {
-	struct statfs		stats;
+	struct kstatfs		stats;
 };
 
 /*
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/include/linux/nfsd/xdr3.h linux-2.5-lbd/include/linux/nfsd/xdr3.h
--- linux-2.5.45/include/linux/nfsd/xdr3.h	Fri Nov  1 08:50:24 2002
+++ linux-2.5-lbd/include/linux/nfsd/xdr3.h	Fri Nov  1 10:07:40 2002
@@ -170,7 +170,7 @@
 
 struct nfsd3_fsstatres {
 	__u32			status;
-	struct statfs		stats;
+	struct kstatfs		stats;
 	__u32			invarsec;
 };
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/include/linux/statfs.h linux-2.5-lbd/include/linux/statfs.h
--- linux-2.5.45/include/linux/statfs.h	Thu Jan  1 10:00:00 1970
+++ linux-2.5-lbd/include/linux/statfs.h	Fri Nov  1 10:07:36 2002
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/include/linux/vfs.h linux-2.5-lbd/include/linux/vfs.h
--- linux-2.5.45/include/linux/vfs.h	Fri Nov  1 08:50:24 2002
+++ linux-2.5-lbd/include/linux/vfs.h	Fri Nov  1 10:07:38 2002
@@ -1,6 +1,6 @@
 #ifndef _LINUX_VFS_H
 #define _LINUX_VFS_H
 
-#include <asm/statfs.h>
+#include <linux/statfs.h>
 
 #endif
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.45/mm/shmem.c linux-2.5-lbd/mm/shmem.c
--- linux-2.5.45/mm/shmem.c	Fri Nov  1 08:50:25 2002
+++ linux-2.5-lbd/mm/shmem.c	Fri Nov  1 10:07:52 2002
@@ -1367,7 +1367,7 @@
 	return desc.error;
 }
 
-static int shmem_statfs(struct super_block *sb, struct statfs *buf)
+static int shmem_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 
