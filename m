Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWIJObs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWIJObs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 10:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWIJObs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 10:31:48 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:47518 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932203AbWIJObp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 10:31:45 -0400
Subject: Re: [RFC:PATCH 002/002] EXT3: Fix sparse warnings
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-ext4@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060908221756.GB5192@martell.zuzino.mipt.ru>
References: <20060908213914.11498.3272.sendpatchset@kleikamp.austin.ibm.com>
	 <20060908213927.11498.18166.sendpatchset@kleikamp.austin.ibm.com>
	 <20060908221756.GB5192@martell.zuzino.mipt.ru>
Content-Type: text/plain
Date: Sun, 10 Sep 2006 09:31:38 -0500
Message-Id: <1157898698.15217.5.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
The new patch below can replace ext3-fix-sparse-warnings.patch.

On Sat, 2006-09-09 at 02:17 +0400, Alexey Dobriyan wrote:
> On Fri, Sep 08, 2006 at 03:39:30PM -0600, Dave Kleikamp wrote:
> > EXT3: Fix sparse warnings
> 
> > --- linux001/fs/ext3/resize.c
> > +++ linux002/fs/ext3/resize.c
> 
> > @@ -380,7 +380,7 @@ static int add_new_gdb(handle_t *handle,
> >  	struct buffer_head *dind;
> >  	int gdbackups;
> >  	struct ext3_iloc iloc;
> > -	__u32 *data;
> > +	__le32 *data;
> >  	int err;
> >  
> >  	if (test_opt(sb, DEBUG))
> > @@ -410,14 +410,14 @@ static int add_new_gdb(handle_t *handle,
> >  		goto exit_bh;
> >  	}
> >  
> > -	data = EXT3_I(inode)->i_data + EXT3_DIND_BLOCK;
> > +	data = (__le32 *)(EXT3_I(inode)->i_data + EXT3_DIND_BLOCK);
> 
> Why cast is needed? i_data is __le32 * already.

You're right.  I didn't realize fixing the declaration was enough.

> > -	data = (__u32 *)dind->b_data;
> > +	data = (__le32 *)dind->b_data;
> >  	if (le32_to_cpu(data[gdb_num % EXT3_ADDR_PER_BLOCK(sb)]) != gdblock) {
> >  		ext3_warning(sb, __FUNCTION__,
> >  			     "new group %u GDT block "E3FSBLK" not reserved",
> > @@ -519,7 +519,7 @@ static int reserve_backup_gdb(handle_t *
> >  	struct buffer_head *dind;
> >  	struct ext3_iloc iloc;
> >  	ext3_fsblk_t blk;
> > -	__u32 *data, *end;
> > +	__le32 *data, *end;
> >  	int gdbackups = 0;
> >  	int res, i;
> >  	int err;
> > @@ -528,7 +528,7 @@ static int reserve_backup_gdb(handle_t *
> >  	if (!primary)
> >  		return -ENOMEM;
> >
> > -	data = EXT3_I(inode)->i_data + EXT3_DIND_BLOCK;
> > +	data = (__le32 *)(EXT3_I(inode)->i_data + EXT3_DIND_BLOCK);
> 
> Ditto.

Agreed.

> > --- linux001/fs/ext3/super.c
> > +++ linux002/fs/ext3/super.c
> > @@ -2330,13 +2330,14 @@ static int ext3_remount (struct super_bl
> >  
> >  			ext3_mark_recovery_complete(sb, es);
> >  		} else {
> > -			__le32 ret;
> > -			if ((ret = EXT3_HAS_RO_COMPAT_FEATURE(sb,
> > +			int ret;
> > +			__le32 ret_le;
> > +			if ((ret_le = EXT3_HAS_RO_COMPAT_FEATURE(sb,
> >  					~EXT3_FEATURE_RO_COMPAT_SUPP))) {
> >  				printk(KERN_WARNING "EXT3-fs: %s: couldn't "
> >  				       "remount RDWR because of unsupported "
> >  				       "optional features (%x).\n",
> > -				       sb->s_id, le32_to_cpu(ret));
> > +				       sb->s_id, le32_to_cpu(ret_le));
> >  				err = -EROFS;
> >  				goto restore_opts;
> >  			}
> 
> Get rid of "err = ret;" assignment below. It would be cleaner than
> introducing new var.

Agreed.

Here's a leaner patch.
===========================================================================
EXT3: Fix sparse warnings

Fixing up some endian-ness warnings in preparation to clone ext4 from ext3.

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

---
diff -Nurp linux001/fs/ext3/resize.c linux002/fs/ext3/resize.c
--- linux001/fs/ext3/resize.c	2006-09-08 07:24:23.000000000 -0500
+++ linux002/fs/ext3/resize.c	2006-09-10 09:22:10.000000000 -0500
@@ -336,7 +336,7 @@ static int verify_reserved_gdb(struct su
 	unsigned five = 5;
 	unsigned seven = 7;
 	unsigned grp;
-	__u32 *p = (__u32 *)primary->b_data;
+	__le32 *p = (__le32 *)primary->b_data;
 	int gdbackups = 0;
 
 	while ((grp = ext3_list_backups(sb, &three, &five, &seven)) < end) {
@@ -380,7 +380,7 @@ static int add_new_gdb(handle_t *handle,
 	struct buffer_head *dind;
 	int gdbackups;
 	struct ext3_iloc iloc;
-	__u32 *data;
+	__le32 *data;
 	int err;
 
 	if (test_opt(sb, DEBUG))
@@ -417,7 +417,7 @@ static int add_new_gdb(handle_t *handle,
 		goto exit_bh;
 	}
 
-	data = (__u32 *)dind->b_data;
+	data = (__le32 *)dind->b_data;
 	if (le32_to_cpu(data[gdb_num % EXT3_ADDR_PER_BLOCK(sb)]) != gdblock) {
 		ext3_warning(sb, __FUNCTION__,
 			     "new group %u GDT block "E3FSBLK" not reserved",
@@ -519,7 +519,7 @@ static int reserve_backup_gdb(handle_t *
 	struct buffer_head *dind;
 	struct ext3_iloc iloc;
 	ext3_fsblk_t blk;
-	__u32 *data, *end;
+	__le32 *data, *end;
 	int gdbackups = 0;
 	int res, i;
 	int err;
@@ -536,8 +536,8 @@ static int reserve_backup_gdb(handle_t *
 	}
 
 	blk = EXT3_SB(sb)->s_sbh->b_blocknr + 1 + EXT3_SB(sb)->s_gdb_count;
-	data = (__u32 *)dind->b_data + EXT3_SB(sb)->s_gdb_count;
-	end = (__u32 *)dind->b_data + EXT3_ADDR_PER_BLOCK(sb);
+	data = (__le32 *)dind->b_data + EXT3_SB(sb)->s_gdb_count;
+	end = (__le32 *)dind->b_data + EXT3_ADDR_PER_BLOCK(sb);
 
 	/* Get each reserved primary GDT block and verify it holds backups */
 	for (res = 0; res < reserved_gdb; res++, blk++) {
@@ -545,7 +545,8 @@ static int reserve_backup_gdb(handle_t *
 			ext3_warning(sb, __FUNCTION__,
 				     "reserved block "E3FSBLK
 				     " not at offset %ld",
-				     blk, (long)(data - (__u32 *)dind->b_data));
+				     blk,
+				     (long)(data - (__le32 *)dind->b_data));
 			err = -EINVAL;
 			goto exit_bh;
 		}
@@ -560,7 +561,7 @@ static int reserve_backup_gdb(handle_t *
 			goto exit_bh;
 		}
 		if (++data >= end)
-			data = (__u32 *)dind->b_data;
+			data = (__le32 *)dind->b_data;
 	}
 
 	for (i = 0; i < reserved_gdb; i++) {
@@ -584,7 +585,7 @@ static int reserve_backup_gdb(handle_t *
 	blk = input->group * EXT3_BLOCKS_PER_GROUP(sb);
 	for (i = 0; i < reserved_gdb; i++) {
 		int err2;
-		data = (__u32 *)primary[i]->b_data;
+		data = (__le32 *)primary[i]->b_data;
 		/* printk("reserving backup %lu[%u] = %lu\n",
 		       primary[i]->b_blocknr, gdbackups,
 		       blk + primary[i]->b_blocknr); */
@@ -689,7 +690,7 @@ exit_err:
 			     "can't update backup for group %d (err %d), "
 			     "forcing fsck on next reboot", group, err);
 		sbi->s_mount_state &= ~EXT3_VALID_FS;
-		sbi->s_es->s_state &= ~cpu_to_le16(EXT3_VALID_FS);
+		sbi->s_es->s_state &= cpu_to_le16(~EXT3_VALID_FS);
 		mark_buffer_dirty(sbi->s_sbh);
 	}
 }
diff -Nurp linux001/fs/ext3/super.c linux002/fs/ext3/super.c
--- linux001/fs/ext3/super.c	2006-09-08 16:25:07.000000000 -0500
+++ linux002/fs/ext3/super.c	2006-09-10 09:19:37.000000000 -0500
@@ -2348,10 +2348,8 @@ static int ext3_remount (struct super_bl
 			 */
 			ext3_clear_journal_err(sb, es);
 			sbi->s_mount_state = le16_to_cpu(es->s_state);
-			if ((ret = ext3_group_extend(sb, es, n_blocks_count))) {
-				err = ret;
+			if ((err = ext3_group_extend(sb, es, n_blocks_count)))
 				goto restore_opts;
-			}
 			if (!ext3_setup_super (sb, es, 0))
 				sb->s_flags &= ~MS_RDONLY;
 		}
diff -Nurp linux001/fs/jbd/journal.c linux002/fs/jbd/journal.c
--- linux001/fs/jbd/journal.c	2006-09-08 16:25:07.000000000 -0500
+++ linux002/fs/jbd/journal.c	2006-09-08 16:25:07.000000000 -0500
@@ -1094,7 +1094,7 @@ int journal_load(journal_t *journal)
 	/*
 	 * Create a slab for this blocksize
 	 */
-	err = journal_create_jbd_slab(cpu_to_be32(sb->s_blocksize));
+	err = journal_create_jbd_slab(be32_to_cpu(sb->s_blocksize));
 	if (err)
 		return err;
 
diff -Nurp linux001/include/linux/ext3_fs.h linux002/include/linux/ext3_fs.h
--- linux001/include/linux/ext3_fs.h	2006-09-08 16:25:07.000000000 -0500
+++ linux002/include/linux/ext3_fs.h	2006-09-08 16:25:07.000000000 -0500
@@ -481,7 +481,7 @@ struct ext3_super_block {
 	 */
 	__u8	s_prealloc_blocks;	/* Nr of blocks to try to preallocate*/
 	__u8	s_prealloc_dir_blocks;	/* Nr to preallocate for dirs */
-	__u16	s_reserved_gdt_blocks;	/* Per group desc for online growth */
+	__le16	s_reserved_gdt_blocks;	/* Per group desc for online growth */
 	/*
 	 * Journaling support valid if EXT3_FEATURE_COMPAT_HAS_JOURNAL set.
 	 */


