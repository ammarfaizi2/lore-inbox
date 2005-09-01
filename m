Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030504AbVIAXCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030504AbVIAXCC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 19:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030508AbVIAXCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 19:02:01 -0400
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:9409 "EHLO
	tux06.ltc.ic.unicamp.br") by vger.kernel.org with ESMTP
	id S1030504AbVIAXCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 19:02:00 -0400
Date: Thu, 1 Sep 2005 20:04:52 -0300
From: Glauber de Oliveira Costa <gocosta@br.ibm.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Glauber de Oliveira Costa <gocosta@br.ibm.com>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       ext2resize-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH][RFC] Ext3 online resizing locking issue (Again)
Message-ID: <20050901230452.GA14526@br.ibm.com>
References: <20050824210325.GK23782@br.ibm.com> <1124996561.1884.212.camel@sisko.sctweedie.blueyonder.co.uk> <20050825204335.GA1674@br.ibm.com> <1125410818.1910.52.camel@sisko.sctweedie.blueyonder.co.uk> <20050831113506.GM23782@br.ibm.com> <1125495031.1900.60.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <1125495031.1900.60.camel@sisko.sctweedie.blueyonder.co.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

Here is my new trial for the resize lock issue. 
Basically, it goes as follows: 

To ensure that only one resizer is running at a time, I added a global
lock that is acquired in the very beginning of ext3_group_add and
ext3_group_extend. 

lock_super is now only used in ext3_group_add in the moment we alter
s_groups_count, and released after the super block is marked dirty.

In ext3_group_extend, this is done outside the main function, so we can
do it trusting the lock to be already held while in remount, or
acquiring it explicitly while in ioctl. 

The lock in ext3_setup_new_group_blocks was simply wiped out, since this
is always called from one of the functions that already holds the lock
(and thus, in a safe environment)

Signed-off-by: Glauber de Oliveira Costa <gocosta@br.ibm.com>


-- 
=====================================
Glauber de Oliveira Costa
IBM Linux Technology Center - Brazil
gocosta@br.ibm.com
=====================================

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-resize_lock

Only in linux/fs/ext3/: .tmp_versions
Only in linux/fs/ext3/: fileidx
diff -bup linux-2.6.13-orig/fs/ext3/ioctl.c linux/fs/ext3/ioctl.c
--- linux-2.6.13-orig/fs/ext3/ioctl.c	2005-09-01 12:44:31.000000000 -0300
+++ linux/fs/ext3/ioctl.c	2005-09-01 11:42:22.000000000 -0300
@@ -207,6 +207,12 @@ flags_err:
 			return -EFAULT;
 
 		err = ext3_group_extend(sb, EXT3_SB(sb)->s_es, n_blocks_count);
+		if (!err){
+			lock_super(sb);
+			sb->s_dirt = 1;
+			unlock_super(sb);
+		}
+		
 		journal_lock_updates(EXT3_SB(sb)->s_journal);
 		journal_flush(EXT3_SB(sb)->s_journal);
 		journal_unlock_updates(EXT3_SB(sb)->s_journal);
Only in linux/fs/ext3/: patch
diff -bup linux-2.6.13-orig/fs/ext3/resize.c linux/fs/ext3/resize.c
--- linux-2.6.13-orig/fs/ext3/resize.c	2005-09-01 12:44:31.000000000 -0300
+++ linux/fs/ext3/resize.c	2005-09-01 19:30:40.000000000 -0300
@@ -23,6 +23,8 @@
 #define outside(b, first, last)	((b) < (first) || (b) >= (last))
 #define inside(b, first, last)	((b) >= (first) && (b) < (last))
 
+DECLARE_MUTEX(resize_lock);
+
 static int verify_group_input(struct super_block *sb,
 			      struct ext3_new_group_data *input)
 {
@@ -178,7 +180,6 @@ static int setup_new_group_blocks(struct
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
-	lock_super(sb);
 	if (input->group != sbi->s_groups_count) {
 		err = -EBUSY;
 		goto exit_journal;
@@ -194,6 +195,7 @@ static int setup_new_group_blocks(struct
 		ext3_set_bit(0, bh->b_data);
 	}
 
+	smp_rmb();
 	/* Copy all of the GDT blocks into the backup in this group */
 	for (i = 0, bit = 1, block = start + 1;
 	     i < gdblocks; i++, block++, bit++) {
@@ -271,7 +273,6 @@ exit_bh:
 	brelse(bh);
 
 exit_journal:
-	unlock_super(sb);
 	if ((err2 = ext3_journal_stop(handle)) && !err)
 		err = err2;
 
@@ -706,6 +707,11 @@ int ext3_group_add(struct super_block *s
 	int gdb_off, gdb_num;
 	int err, err2;
 
+	if (unlikely(down_trylock(&resize_lock))){
+		ext3_warning(sb,__FUNCTION__,"multiple resizers run on filesystem. Aborting\n");
+		return -EBUSY;
+	}
+
 	gdb_num = input->group / EXT3_DESC_PER_BLOCK(sb);
 	gdb_off = input->group % EXT3_DESC_PER_BLOCK(sb);
 
@@ -753,12 +759,6 @@ int ext3_group_add(struct super_block *s
 		goto exit_put;
 	}
 
-	lock_super(sb);
-	if (input->group != EXT3_SB(sb)->s_groups_count) {
-		ext3_warning(sb, __FUNCTION__,
-			     "multiple resizers run on filesystem!\n");
-		goto exit_journal;
-	}
 
 	if ((err = ext3_journal_get_write_access(handle, sbi->s_sbh)))
 		goto exit_journal;
@@ -847,6 +847,7 @@ int ext3_group_add(struct super_block *s
 	 */
 	smp_wmb();
 
+	lock_super(sb);
 	/* Update the global fs size fields */
 	EXT3_SB(sb)->s_groups_count++;
 
@@ -865,9 +866,9 @@ int ext3_group_add(struct super_block *s
 
 	ext3_journal_dirty_metadata(handle, EXT3_SB(sb)->s_sbh);
 	sb->s_dirt = 1;
+	unlock_super(sb);
 
 exit_journal:
-	unlock_super(sb);
 	if ((err2 = ext3_journal_stop(handle)) && !err)
 		err = err2;
 	if (!err) {
@@ -877,6 +878,7 @@ exit_journal:
 			       primary->b_size);
 	}
 exit_put:
+	up(&resize_lock);
 	iput(inode);
 	return err;
 } /* ext3_group_add */
@@ -901,6 +903,12 @@ int ext3_group_extend(struct super_block
 	handle_t *handle;
 	int err, freed_blocks;
 
+
+	if (unlikely(down_trylock(&resize_lock))){ 
+		ext3_warning(sb,__FUNCTION__,"multiple resizers run on filesystem. Aborting\n");
+		return -EBUSY;
+	}
+
 	/* We don't need to worry about locking wrt other resizers just
 	 * yet: we're going to revalidate es->s_blocks_count after
 	 * taking lock_super() below. */
@@ -911,13 +919,15 @@ int ext3_group_extend(struct super_block
 		printk(KERN_DEBUG "EXT3-fs: extending last group from %lu to %lu blocks\n",
 		       o_blocks_count, n_blocks_count);
 
+	err = 0;
 	if (n_blocks_count == 0 || n_blocks_count == o_blocks_count)
-		return 0;
+		goto exit_put;
 
 	if (n_blocks_count < o_blocks_count) {
 		ext3_warning(sb, __FUNCTION__,
 			     "can't shrink FS - resize aborted");
-		return -EBUSY;
+		err = -EBUSY;
+		goto exit_put;
 	}
 
 	/* Handle the remaining blocks in the last group only. */
@@ -927,7 +937,8 @@ int ext3_group_extend(struct super_block
 	if (last == 0) {
 		ext3_warning(sb, __FUNCTION__,
 			     "need to use ext2online to resize further\n");
-		return -EPERM;
+		err = -EPERM;
+		goto exit_put;
 	}
 
 	add = EXT3_BLOCKS_PER_GROUP(sb) - last;
@@ -945,7 +956,8 @@ int ext3_group_extend(struct super_block
 	if (!bh) {
 		ext3_warning(sb, __FUNCTION__,
 			     "can't read last block, resize aborted");
-		return -ENOSPC;
+		err = -ENOSPC;
+		goto exit_put;
 	}
 	brelse(bh);
 
@@ -959,26 +971,15 @@ int ext3_group_extend(struct super_block
 		goto exit_put;
 	}
 
-	lock_super(sb);
-	if (o_blocks_count != le32_to_cpu(es->s_blocks_count)) {
-		ext3_warning(sb, __FUNCTION__,
-			     "multiple resizers run on filesystem!\n");
-		err = -EBUSY;
-		goto exit_put;
-	}
-
 	if ((err = ext3_journal_get_write_access(handle,
 						 EXT3_SB(sb)->s_sbh))) {
 		ext3_warning(sb, __FUNCTION__,
 			     "error %d on journal write access", err);
-		unlock_super(sb);
 		ext3_journal_stop(handle);
 		goto exit_put;
 	}
 	es->s_blocks_count = cpu_to_le32(o_blocks_count + add);
 	ext3_journal_dirty_metadata(handle, EXT3_SB(sb)->s_sbh);
-	sb->s_dirt = 1;
-	unlock_super(sb);
 	ext3_debug("freeing blocks %ld through %ld\n", o_blocks_count,
 		   o_blocks_count + add);
 	ext3_free_blocks_sb(handle, sb, o_blocks_count, add, &freed_blocks);
@@ -992,5 +993,6 @@ int ext3_group_extend(struct super_block
 	update_backups(sb, EXT3_SB(sb)->s_sbh->b_blocknr, (char *)es,
 		       sizeof(struct ext3_super_block));
 exit_put:
+	up(&resize_lock);
 	return err;
 } /* ext3_group_extend */
diff -bup linux-2.6.13-orig/fs/ext3/super.c linux/fs/ext3/super.c
--- linux-2.6.13-orig/fs/ext3/super.c	2005-09-01 12:44:31.000000000 -0300
+++ linux/fs/ext3/super.c	2005-09-01 12:02:09.000000000 -0300
@@ -639,8 +639,8 @@ static match_table_t tokens = {
 	{Opt_quota, "quota"},
 	{Opt_quota, "usrquota"},
 	{Opt_barrier, "barrier=%u"},
+	{Opt_resize, "resize=%u"},
 	{Opt_err, NULL},
-	{Opt_resize, "resize"},
 };
 
 static unsigned long get_sb_block(void **data)
@@ -2195,6 +2195,8 @@ static int ext3_remount (struct super_bl
 			sbi->s_mount_state = le16_to_cpu(es->s_state);
 			if ((ret = ext3_group_extend(sb, es, n_blocks_count))) {
 				err = ret;
+				if (!err)
+					sb->s_dirt = 1;
 				goto restore_opts;
 			}
 			if (!ext3_setup_super (sb, es, 0))
Only in linux/fs/ext3/: xref

--fdj2RfSjLxBAspz7--
