Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWDJJLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWDJJLc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 05:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWDJJLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 05:11:32 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:60329 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750958AbWDJJLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 05:11:31 -0400
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit
	from 8TB to 16TB
From: Laurent Vivier <Laurent.Vivier@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Mingming Cao <cmm@us.ibm.com>, Takashi Sato <sho@tnes.nec.co.jp>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060329175446.67149f32.akpm@osdl.org>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	 <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	 <20060327131049.2c6a5413.akpm@osdl.org>
	 <20060327225847.GC3756@localhost.localdomain>
	 <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	 <1143623605.5046.11.camel@openx2.frec.bull.fr>
	 <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
	 <20060329175446.67149f32.akpm@osdl.org>
Message-Id: <1144660270.5816.3.camel@openx2.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-14) 
Date: Mon, 10 Apr 2006 11:11:11 +0200
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/04/2006 11:13:41,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/04/2006 11:13:44,
	Serialize complete at 10/04/2006 11:13:44
Content-Type: multipart/mixed; boundary="=-aiTLDgJfm/cFSWGZ8+wW"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aiTLDgJfm/cFSWGZ8+wW
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Le jeu 30/03/2006 =C3=A0 03:54, Andrew Morton a =C3=A9crit :
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > The things need to be done to complete this work is the issue with
> >  current percpu counter, which could not handle u32 type count well.=20
>=20
> I'm surprised there's much of a problem here.  It is a 32-bit value, so i=
t
> should mainly be a matter of treating the return value from
> percpu_counter_read() as unsigned long.
>=20
> However a stickier problem is when dealing with a filesystem which has,
> say, 0xffff_ff00 blocks.  Because percpu counters are approximate, and a
> counter which really has a value of 0xffff_feee might return 0x00000123.=20
> What do we do then?
>=20
> Of course the simple option is to nuke the percpu counters in ext3 and us=
e
> atomic_long_t (which is signed, so appropriate treat-it-as-unsigned code
> would be needed).  I doubt if the percpu counters in ext3 are gaining us
> much.

I tried to make something in this way.
Does the attached patch look like the thing you though about ?

Regards,
Laurent
--=20
Laurent Vivier
Bull, Architect of an Open World (TM)
http://www.bullopensource.org/ext4

--=-aiTLDgJfm/cFSWGZ8+wW
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=cpu_counter
Content-Type: text/x-patch; name=cpu_counter; charset=UTF-8

Index: linux-2.6.16-lv/fs/ext3/balloc.c
===================================================================
--- linux-2.6.16-lv.orig/fs/ext3/balloc.c	2006-04-07 16:27:11.000000000 +0200
+++ linux-2.6.16-lv/fs/ext3/balloc.c	2006-04-07 17:05:28.000000000 +0200
@@ -471,7 +471,7 @@ do_more:
 		cpu_to_le16(le16_to_cpu(desc->bg_free_blocks_count) +
 			group_freed);
 	spin_unlock(sb_bgl_lock(sbi, block_group));
-	percpu_counter_mod(&sbi->s_freeblocks_counter, count);
+	atomic_long_set(&sbi->s_freeblocks_counter, count);
 
 	/* We dirtied the bitmap block */
 	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
@@ -1129,7 +1129,7 @@ static int ext3_has_free_blocks(struct e
 {
 	sector_t free_blocks, root_blocks;
 
-	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
+	free_blocks = (sector_t)atomic_long_read(&sbi->s_freeblocks_counter);
 	root_blocks = le32_to_cpu(sbi->s_es->s_r_blocks_count);
 	if (free_blocks < root_blocks + 1 && !capable(CAP_SYS_RESOURCE) &&
 		sbi->s_resuid != current->fsuid &&
@@ -1381,7 +1381,7 @@ allocated:
 	gdp->bg_free_blocks_count =
 			cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count) - 1);
 	spin_unlock(sb_bgl_lock(sbi, group_no));
-	percpu_counter_mod(&sbi->s_freeblocks_counter, -1);
+	atomic_long_dec(&sbi->s_freeblocks_counter);
 
 	BUFFER_TRACE(gdp_bh, "journal_dirty_metadata for group descriptor");
 	err = ext3_journal_dirty_metadata(handle, gdp_bh);
Index: linux-2.6.16-lv/include/linux/ext3_fs_sb.h
===================================================================
--- linux-2.6.16-lv.orig/include/linux/ext3_fs_sb.h	2006-04-07 16:27:11.000000000 +0200
+++ linux-2.6.16-lv/include/linux/ext3_fs_sb.h	2006-04-07 17:01:23.000000000 +0200
@@ -20,7 +20,6 @@
 #include <linux/timer.h>
 #include <linux/wait.h>
 #include <linux/blockgroup_lock.h>
-#include <linux/percpu_counter.h>
 #endif
 #include <linux/rbtree.h>
 
@@ -54,9 +53,9 @@ struct ext3_sb_info {
 	u32 s_next_generation;
 	u32 s_hash_seed[4];
 	int s_def_hash_version;
-	struct percpu_counter s_freeblocks_counter;
-	struct percpu_counter s_freeinodes_counter;
-	struct percpu_counter s_dirs_counter;
+	atomic_long_t s_freeblocks_counter;
+	atomic_long_t s_freeinodes_counter;
+	atomic_long_t s_dirs_counter;
 	struct blockgroup_lock s_blockgroup_lock;
 
 	/* root of the per fs reservation window tree */
Index: linux-2.6.16-lv/fs/ext3/super.c
===================================================================
--- linux-2.6.16-lv.orig/fs/ext3/super.c	2006-04-07 16:27:11.000000000 +0200
+++ linux-2.6.16-lv/fs/ext3/super.c	2006-04-07 17:14:22.000000000 +0200
@@ -404,9 +404,6 @@ static void ext3_put_super (struct super
 	for (i = 0; i < sbi->s_gdb_count; i++)
 		brelse(sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
-	percpu_counter_destroy(&sbi->s_freeblocks_counter);
-	percpu_counter_destroy(&sbi->s_freeinodes_counter);
-	percpu_counter_destroy(&sbi->s_dirs_counter);
 	brelse(sbi->s_sbh);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < MAXQUOTAS; i++)
@@ -1580,9 +1577,9 @@ static int ext3_fill_super (struct super
 		goto failed_mount;
 	}
 
-	percpu_counter_init(&sbi->s_freeblocks_counter);
-	percpu_counter_init(&sbi->s_freeinodes_counter);
-	percpu_counter_init(&sbi->s_dirs_counter);
+	atomic_long_set(&sbi->s_freeblocks_counter, 0);
+	atomic_long_set(&sbi->s_freeinodes_counter, 0);
+	atomic_long_set(&sbi->s_dirs_counter, 0);
 	bgl_lock_init(&sbi->s_blockgroup_lock);
 
 	for (i = 0; i < db_count; i++) {
@@ -1730,11 +1727,11 @@ static int ext3_fill_super (struct super
 		test_opt(sb,DATA_FLAGS) == EXT3_MOUNT_ORDERED_DATA ? "ordered":
 		"writeback");
 
-	percpu_counter_mod(&sbi->s_freeblocks_counter,
+	atomic_long_set(&sbi->s_freeblocks_counter,
 		ext3_count_free_blocks(sb));
-	percpu_counter_mod(&sbi->s_freeinodes_counter,
+	atomic_long_set(&sbi->s_freeinodes_counter,
 		ext3_count_free_inodes(sb));
-	percpu_counter_mod(&sbi->s_dirs_counter,
+	atomic_long_set(&sbi->s_dirs_counter,
 		ext3_count_dirs(sb));
 
 	lock_kernel();
Index: linux-2.6.16-lv/fs/ext3/resize.c
===================================================================
--- linux-2.6.16-lv.orig/fs/ext3/resize.c	2006-04-07 16:27:11.000000000 +0200
+++ linux-2.6.16-lv/fs/ext3/resize.c	2006-04-07 17:12:13.000000000 +0200
@@ -871,9 +871,9 @@ int ext3_group_add(struct super_block *s
 		input->reserved_blocks);
 
 	/* Update the free space counts */
-	percpu_counter_mod(&sbi->s_freeblocks_counter,
+	atomic_long_set(&sbi->s_freeblocks_counter,
 			   input->free_blocks_count);
-	percpu_counter_mod(&sbi->s_freeinodes_counter,
+	atomic_long_set(&sbi->s_freeinodes_counter,
 			   EXT3_INODES_PER_GROUP(sb));
 
 	ext3_journal_dirty_metadata(handle, sbi->s_sbh);
Index: linux-2.6.16-lv/fs/ext3/ialloc.c
===================================================================
--- linux-2.6.16-lv.orig/fs/ext3/ialloc.c	2006-04-07 16:27:11.000000000 +0200
+++ linux-2.6.16-lv/fs/ext3/ialloc.c	2006-04-07 17:09:54.000000000 +0200
@@ -170,9 +170,9 @@ void ext3_free_inode (handle_t *handle, 
 				gdp->bg_used_dirs_count = cpu_to_le16(
 				  le16_to_cpu(gdp->bg_used_dirs_count) - 1);
 			spin_unlock(sb_bgl_lock(sbi, block_group));
-			percpu_counter_inc(&sbi->s_freeinodes_counter);
+			atomic_long_inc(&sbi->s_freeinodes_counter);
 			if (is_directory)
-				percpu_counter_dec(&sbi->s_dirs_counter);
+				atomic_long_dec(&sbi->s_dirs_counter);
 
 		}
 		BUFFER_TRACE(bh2, "call ext3_journal_dirty_metadata");
@@ -207,7 +207,7 @@ static int find_group_dir(struct super_b
 	struct buffer_head *bh;
 	int group, best_group = -1;
 
-	freei = percpu_counter_read_positive(&EXT3_SB(sb)->s_freeinodes_counter);
+	freei = (sector_t)atomic_long_read(&EXT3_SB(sb)->s_freeinodes_counter);
 	avefreei = freei / ngroups;
 
 	for (group = 0; group < ngroups; group++) {
@@ -269,11 +269,11 @@ static int find_group_orlov(struct super
 	struct ext3_group_desc *desc;
 	struct buffer_head *bh;
 
-	freei = percpu_counter_read_positive(&sbi->s_freeinodes_counter);
+	freei = (sector_t)atomic_long_read(&sbi->s_freeinodes_counter);
 	avefreei = freei / ngroups;
-	freeb = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
+	freeb = (sector_t)atomic_long_read(&sbi->s_freeblocks_counter);
 	avefreeb = freeb / ngroups;
-	ndirs = percpu_counter_read_positive(&sbi->s_dirs_counter);
+	ndirs = (sector_t)atomic_long_read(&sbi->s_dirs_counter);
 
 	if ((parent == sb->s_root->d_inode) ||
 	    (EXT3_I(parent)->i_flags & EXT3_TOPDIR_FL)) {
@@ -539,9 +539,9 @@ got:
 	err = ext3_journal_dirty_metadata(handle, bh2);
 	if (err) goto fail;
 
-	percpu_counter_dec(&sbi->s_freeinodes_counter);
+	atomic_long_dec(&sbi->s_freeinodes_counter);
 	if (S_ISDIR(mode))
-		percpu_counter_inc(&sbi->s_dirs_counter);
+		atomic_long_inc(&sbi->s_dirs_counter);
 	sb->s_dirt = 1;
 
 	inode->i_uid = current->fsuid;

--=-aiTLDgJfm/cFSWGZ8+wW--

