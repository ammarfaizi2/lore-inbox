Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315308AbSDWSaE>; Tue, 23 Apr 2002 14:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315309AbSDWSaD>; Tue, 23 Apr 2002 14:30:03 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:64932 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315305AbSDWS3z>;
	Tue, 23 Apr 2002 14:29:55 -0400
Message-ID: <3CC5A7ED.7020701@us.ibm.com>
Date: Tue, 23 Apr 2002 11:29:01 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: locking in sync_old_buffers
In-Reply-To: <Pine.GSO.4.21.0204222130270.5686-100000@weyl.math.psu.edu>
Content-Type: multipart/mixed;
 boundary="------------080806090305040804030600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080806090305040804030600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alexander Viro wrote:
> On Mon, 22 Apr 2002, Andrew Morton wrote:
>>If you're going to do this, then the BKL should be acquired
>>in fs/super.c:write_super(), so the per-fs ->write_super
>>functions do not see changed external locking rules.
> 
> Definitely.

Would you prefer that it be pushed into fs/super.c:write_super() itself, 
or the fs-specific write_super()s?  The approach so far has been to push 
into the filesystem itself, so that is what this patch does.  I also 
updated filesystems/Locking and a little comment in the ext3 code.

-- 
Dave Hansen
haveblue@us.ibm.com

--------------080806090305040804030600
Content-Type: text/plain;
 name="sync_old_buffers-bkl_shift-2.5.9-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sync_old_buffers-bkl_shift-2.5.9-2.patch"

diff -ur linux-2.5.9-clean/Documentation/filesystems/Locking linux/Documentation/filesystems/Locking
--- linux-2.5.9-clean/Documentation/filesystems/Locking	Wed Apr 10 13:27:52 2002
+++ linux/Documentation/filesystems/Locking	Tue Apr 23 10:54:23 2002
@@ -110,7 +110,7 @@
 delete_inode:	no	
 clear_inode:	no	
 put_super:	yes	yes	maybe		(see below)
-write_super:	yes	yes	maybe		(see below)
+write_super:	no	yes	maybe		(see below)
 statfs:		yes	no	no
 remount_fs:	yes	yes	maybe		(see below)
 umount_begin:	yes	no	maybe		(see below)
diff -ur linux-2.5.9-clean/fs/affs/super.c linux/fs/affs/super.c
--- linux-2.5.9-clean/fs/affs/super.c	Wed Apr 10 13:28:10 2002
+++ linux/fs/affs/super.c	Tue Apr 23 10:32:31 2002
@@ -38,7 +38,7 @@
 affs_put_super(struct super_block *sb)
 {
 	struct affs_sb_info *sbi = AFFS_SB(sb);
-
+	lock_kernel();
 	pr_debug("AFFS: put_super()\n");
 
 	if (!(sb->s_flags & MS_RDONLY)) {
@@ -56,7 +56,7 @@
 	affs_brelse(sbi->s_root_bh);
 	kfree(sbi);
 	sb->u.generic_sbp = NULL;
-
+	unlock_kernel();
 	return;
 }
 
@@ -65,7 +65,7 @@
 {
 	int clean = 2;
 	struct affs_sb_info *sbi = AFFS_SB(sb);
-
+	lock_kernel();
 	if (!(sb->s_flags & MS_RDONLY)) {
 		//	if (sbi->s_bitmap[i].bm_bh) {
 		//		if (buffer_dirty(sbi->s_bitmap[i].bm_bh)) {
@@ -80,6 +80,7 @@
 		sb->s_dirt = 0;
 
 	pr_debug("AFFS: write_super() at %lu, clean=%d\n", CURRENT_TIME, clean);
+	unlock_kernel();
 }
 
 static kmem_cache_t * affs_inode_cachep;
diff -ur linux-2.5.9-clean/fs/bfs/inode.c linux/fs/bfs/inode.c
--- linux-2.5.9-clean/fs/bfs/inode.c	Tue Apr 23 10:57:34 2002
+++ linux/fs/bfs/inode.c	Tue Apr 23 10:56:42 2002
@@ -206,9 +206,11 @@
 
 static void bfs_write_super(struct super_block *s)
 {
+	lock_kernel();
 	if (!(s->s_flags & MS_RDONLY))
 		mark_buffer_dirty(BFS_SB(s)->si_sbh);
 	s->s_dirt = 0;
+	unlock_kernel();
 }
 
 static kmem_cache_t * bfs_inode_cachep;
diff -ur linux-2.5.9-clean/fs/buffer.c linux/fs/buffer.c
--- linux-2.5.9-clean/fs/buffer.c	Mon Apr 22 13:45:34 2002
+++ linux/fs/buffer.c	Mon Apr 22 13:45:49 2002
@@ -2612,10 +2612,8 @@
 
 static void sync_old_buffers(unsigned long dummy)
 {
-	lock_kernel();
 	sync_unlocked_inodes();
 	sync_supers();
-	unlock_kernel();
 
 	for (;;) {
 		struct buffer_head *bh;
diff -ur linux-2.5.9-clean/fs/ext2/super.c linux/fs/ext2/super.c
--- linux-2.5.9-clean/fs/ext2/super.c	Tue Apr 23 10:57:34 2002
+++ linux/fs/ext2/super.c	Tue Apr 23 10:56:42 2002
@@ -754,7 +754,7 @@
 void ext2_write_super (struct super_block * sb)
 {
 	struct ext2_super_block * es;
-
+	lock_kernel();
 	if (!(sb->s_flags & MS_RDONLY)) {
 		es = EXT2_SB(sb)->s_es;
 
@@ -768,6 +768,7 @@
 			ext2_commit_super (sb, es);
 	}
 	sb->s_dirt = 0;
+	unlock_kernel();
 }
 
 int ext2_remount (struct super_block * sb, int * flags, char * data)
diff -ur linux-2.5.9-clean/fs/ext3/super.c linux/fs/ext3/super.c
--- linux-2.5.9-clean/fs/ext3/super.c	Wed Apr 10 13:28:12 2002
+++ linux/fs/ext3/super.c	Tue Apr 23 11:23:42 2002
@@ -501,7 +501,7 @@
 	put_inode:	ext3_put_inode,		/* BKL not held.  Don't need */
 	delete_inode:	ext3_delete_inode,	/* BKL not held.  We take it */
 	put_super:	ext3_put_super,		/* BKL held */
-	write_super:	ext3_write_super,	/* BKL held */
+	write_super:	ext3_write_super,	/* BKL not held. We take it. Needed? */
 	write_super_lockfs: ext3_write_super_lockfs, /* BKL not held. Take it */
 	unlockfs:	ext3_unlockfs,		/* BKL not held.  We take it */
 	statfs:		ext3_statfs,		/* BKL held */
@@ -1599,7 +1599,7 @@
 void ext3_write_super (struct super_block * sb)
 {
 	tid_t target;
-	
+	lock_kernel();	
 	if (down_trylock(&sb->s_lock) == 0)
 		BUG();		/* aviro detector */
 	sb->s_dirt = 0;
@@ -1610,6 +1610,7 @@
 		log_wait_commit(EXT3_SB(sb)->s_journal, target);
 		lock_super(sb);
 	}
+	unlock_kernel();
 }
 
 /*
diff -ur linux-2.5.9-clean/fs/hfs/super.c linux/fs/hfs/super.c
--- linux-2.5.9-clean/fs/hfs/super.c	Wed Apr 10 13:28:12 2002
+++ linux/fs/hfs/super.c	Tue Apr 23 10:33:21 2002
@@ -146,9 +146,10 @@
 static void hfs_write_super(struct super_block *sb)
 {
 	struct hfs_mdb *mdb = HFS_SB(sb)->s_mdb;
-
+	lock_kernel();
 	/* is this a valid hfs superblock? */
 	if (!sb || sb->s_magic != HFS_SUPER_MAGIC) {
+		unlock_kernel();
 		return;
 	}
 
@@ -157,6 +158,7 @@
 		hfs_mdb_commit(mdb, 0);
 	}
 	sb->s_dirt = 0;
+	unlock_kernel();
 }
 
 /*
diff -ur linux-2.5.9-clean/fs/jffs/inode-v23.c linux/fs/jffs/inode-v23.c
--- linux-2.5.9-clean/fs/jffs/inode-v23.c	Wed Apr 10 13:28:13 2002
+++ linux/fs/jffs/inode-v23.c	Tue Apr 23 10:35:15 2002
@@ -1746,8 +1746,9 @@
 jffs_write_super(struct super_block *sb)
 {
 	struct jffs_control *c = (struct jffs_control *)sb->u.generic_sbp;
-
+	lock_kernel();
 	jffs_garbage_collect_trigger(c);
+	unlock_kernel();
 }
 
 static struct super_operations jffs_ops =
diff -ur linux-2.5.9-clean/fs/jffs2/fs.c linux/fs/jffs2/fs.c
--- linux-2.5.9-clean/fs/jffs2/fs.c	Tue Apr  2 10:43:21 2002
+++ linux/fs/jffs2/fs.c	Tue Apr 23 10:35:39 2002
@@ -320,16 +320,21 @@
 void jffs2_write_super (struct super_block *sb)
 {
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
+
+	lock_kernel();
 	sb->s_dirt = 0;
 
-	if (sb->s_flags & MS_RDONLY)
+	if (sb->s_flags & MS_RDONLY) {
+		unlock_kernel();	
 		return;
+	}
 
 	D1(printk("jffs2_write_super(): flush_wbuf before gc-trigger\n"));
 	jffs2_flush_wbuf(c, 2);
 	jffs2_garbage_collect_trigger(c);
 	jffs2_erase_pending_blocks(c);
 	jffs2_mark_erased_blocks(c);
+	unlock_kernel();
 }
 
 
diff -ur linux-2.5.9-clean/fs/qnx4/inode.c linux/fs/qnx4/inode.c
--- linux-2.5.9-clean/fs/qnx4/inode.c	Tue Apr  2 10:43:22 2002
+++ linux/fs/qnx4/inode.c	Tue Apr 23 10:35:51 2002
@@ -72,8 +72,10 @@
 
 static void qnx4_write_super(struct super_block *sb)
 {
+	lock_kernel();
 	QNX4DEBUG(("qnx4: write_super\n"));
 	sb->s_dirt = 0;
+	unlock_kernel();
 }
 
 static void qnx4_write_inode(struct inode *inode, int unused)
diff -ur linux-2.5.9-clean/fs/sysv/inode.c linux/fs/sysv/inode.c
--- linux-2.5.9-clean/fs/sysv/inode.c	Thu Mar  7 18:18:05 2002
+++ linux/fs/sysv/inode.c	Tue Apr 23 10:37:25 2002
@@ -33,6 +33,7 @@
 /* This is only called on sync() and umount(), when s_dirt=1. */
 static void sysv_write_super(struct super_block *sb)
 {
+	lock_kernel();
 	if (!(sb->s_flags & MS_RDONLY)) {
 		/* If we are going to write out the super block,
 		   then attach current time stamp.
@@ -46,6 +47,7 @@
 		mark_buffer_dirty(sb->sv_bh2);
 	}
 	sb->s_dirt = 0;
+	unlock_kernel();
 }
 
 static void sysv_put_super(struct super_block *sb)
diff -ur linux-2.5.9-clean/fs/udf/super.c linux/fs/udf/super.c
--- linux-2.5.9-clean/fs/udf/super.c	Wed Apr 10 13:28:14 2002
+++ linux/fs/udf/super.c	Tue Apr 23 10:37:33 2002
@@ -359,9 +359,11 @@
 void
 udf_write_super(struct super_block *sb)
 {
+	lock_kernel();
 	if (!(sb->s_flags & MS_RDONLY))
 		udf_open_lvid(sb);
 	sb->s_dirt = 0;
+	unlock_kernel();
 }
 
 static int
diff -ur linux-2.5.9-clean/fs/ufs/super.c linux/fs/ufs/super.c
--- linux-2.5.9-clean/fs/ufs/super.c	Wed Apr 10 13:28:15 2002
+++ linux/fs/ufs/super.c	Tue Apr 23 10:49:12 2002
@@ -822,6 +822,8 @@
 	struct ufs_super_block_third * usb3;
 	unsigned flags;
 
+	lock_kernel();
+
 	UFSD(("ENTER\n"))
 	flags = sb->u.ufs_sb.s_flags;
 	uspi = sb->u.ufs_sb.s_uspi;
@@ -838,6 +840,7 @@
 	}
 	sb->s_dirt = 0;
 	UFSD(("EXIT\n"))
+	unlock_kernel();
 }
 
 void ufs_put_super (struct super_block * sb)

--------------080806090305040804030600--

