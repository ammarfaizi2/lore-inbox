Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293035AbSCAPwD>; Fri, 1 Mar 2002 10:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293289AbSCAPvz>; Fri, 1 Mar 2002 10:51:55 -0500
Received: from angband.namesys.com ([212.16.7.85]:27008 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S293035AbSCAPva>; Fri, 1 Mar 2002 10:51:30 -0500
Date: Fri, 1 Mar 2002 18:51:28 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] 2.4 reiserfs updates for 2.4.19-rc2 all in one.
Message-ID: <20020301185128.A8996@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

   Attached patch contains these 24 patches (all in one as you requested):

01-corrupt_items_checks.diff
    Certain disk corruptions may end-up making item-type to be garbage. This
    patch makes reiserfs not to crash when dealing with such items.

02-ioerrors-checks-2.diff
    Correctly check return value of reiserfs_find_entry for io errors.

03-key_output_fix.diff
    Correctly output cpu keys as %K

04-mkdir_nospace_nowarning.diff
    Do not print warnings if cannot create a dir due to no free space.

05-non4kpages_size_fix.diff
    Fix a case where filesizes in blocks could be incorrectly
    determined if pagesize != blocksize

06-return_braindamage_removal.diff
    Removal of some dead code that never can be executed.

07-rm_truncate_nospace_nowarn.diff
    Do not print a warning if we cannot insert rm/truncate record into the
    tree due to no space condition

08-savelink_nospace_nowarning.diff
    Do not print a warning if we cannot inser a savelink item into the tree due 
    to no space condition.

09-tailconv_nospace_nowarn.diff
    Do not print a warning if we cannot conwert file tail into ordinar page
    due to no space condition.

10-unfinished_rebuildtree_message.diff
    Print a hint for a user if we encounter a filesystem that was not correctly
    processed by reiserfsck --rebuild-tree

11-reiserfs-bitmap-journal-read-ahead.diff
    Read-ahead of journal bitmaps, this should speed-up mount times in case of
    journal replay. Especially on rebuilding RAID arrays.

12-v3.6_uuid_support-1.diff
    Add some support for UUID and LABELs on v3.6 filesystems.

13-pap14030-not-crash-2.diff
    Fix a problem where subsequent get_block() failures may lead to incorrect
    data in page case marced as uptodate.

14-remount-options.diff
    Add support for more remount options.

15-more-procfs.diff
    Add more vatiables to reiserfs procfs monitoring interface

16-blocksize_lessthan_pagesize_fix.diff
    Fixes a bug in case we have pagesize > blocksize and active
    buffers flushing.

17-kmalloc_cleanup.diff
    Convert all kmalloc's into the reiserfs_kmallocs. Make reiserfs_kmalloc to
    be of no extra overhead in case CONFIG_REISERFS_CHECK was not selected.

18-hash_autodetect_fix.diff
    Fix hash autodetecting.

19-inode-attrs.diff
    Add support for ext2-style inode attributes. Note, you must use -o attrs
    flag, also you must have previous attribute contents cleaned and special
    flag set in the superblock.

20-unlink_print_nogarbage.diff
    Do not print garbage priority level on savelinks replay.

21-docupdate.diff
    Update current reiserfsprogs information, fix "unused variable" warning.

22-atime_fix.diff
    Correctly update atime on file access.

23-truncate-fix.diff
    Add missed journal_begin call for a case where direct2indirect failed, but
    block for this conversion was already allocated and needs to be freed.

24-o_direct.diff
    Add O_DIRECT support.

Bye,
    Oleg

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="big_2.4.18-3.diff"

diff -uNr linux-2.4.18.original/Documentation/Changes linux-2.4.18/Documentation/Changes
--- linux-2.4.18.original/Documentation/Changes	Tue Feb 26 15:52:55 2002
+++ linux-2.4.18/Documentation/Changes	Fri Mar  1 18:09:21 2002
@@ -54,7 +54,7 @@
 o  util-linux             2.10o                   # fdformat --version
 o  modutils               2.4.2                   # insmod -V
 o  e2fsprogs              1.25                    # tune2fs
-o  reiserfsprogs          3.x.0j                  # reiserfsck 2>&1|grep reiserfsprogs
+o  reiserfsprogs          3.x.1b                  # reiserfsck 2>&1|grep reiserfsprogs
 o  pcmcia-cs              3.1.21                  # cardmgr -V
 o  PPP                    2.4.0                   # pppd --version
 o  isdn4k-utils           3.1pre1                 # isdnctrl 2>&1|grep version
@@ -321,7 +321,7 @@
 
 Reiserfsprogs
 -------------
-o  <ftp://ftp.namesys.com/pub/reiserfsprogs/reiserfsprogs-3.x.0j.tar.gz>
+o  <ftp://ftp.namesys.com/pub/reiserfsprogs/reiserfsprogs-3.x.0b.tar.gz>
 
 LVM toolset
 -----------
diff -uNr linux-2.4.18.original/fs/reiserfs/bitmap.c linux-2.4.18/fs/reiserfs/bitmap.c
--- linux-2.4.18.original/fs/reiserfs/bitmap.c	Tue Feb 26 15:52:56 2002
+++ linux-2.4.18/fs/reiserfs/bitmap.c	Fri Mar  1 18:09:21 2002
@@ -139,10 +139,8 @@
 /* preallocated blocks don't need to be run through journal_mark_freed */
 void reiserfs_free_prealloc_block (struct reiserfs_transaction_handle *th, 
                           unsigned long block) {
-    struct super_block * s = th->t_super;
-
-    RFALSE(!s, "vs-4060: trying to free block on nonexistent device");
-    RFALSE(is_reusable (s, block, 1) == 0, "vs-4070: can not free such block");
+    RFALSE(!th->t_super, "vs-4060: trying to free block on nonexistent device");
+    RFALSE(is_reusable (th->t_super, block, 1) == 0, "vs-4070: can not free such block");
     _reiserfs_free_block(th, block) ;
 }
 
diff -uNr linux-2.4.18.original/fs/reiserfs/dir.c linux-2.4.18/fs/reiserfs/dir.c
--- linux-2.4.18.original/fs/reiserfs/dir.c	Tue Feb 26 15:52:56 2002
+++ linux-2.4.18/fs/reiserfs/dir.c	Fri Mar  1 18:09:21 2002
@@ -20,6 +20,7 @@
     read:	generic_read_dir,
     readdir:	reiserfs_readdir,
     fsync:	reiserfs_dir_fsync,
+    ioctl:	reiserfs_ioctl,
 };
 
 int reiserfs_dir_fsync(struct file *filp, struct dentry *dentry, int datasync) {
@@ -76,7 +77,7 @@
 		
 	/* we must have found item, that is item of this directory, */
 	RFALSE( COMP_SHORT_KEYS (&(ih->ih_key), &pos_key),
-		"vs-9000: found item %h does not match to dir we readdir %k",
+		"vs-9000: found item %h does not match to dir we readdir %K",
 		ih, &pos_key);
 	RFALSE( item_num > B_NR_ITEMS (bh) - 1,
 		"vs-9005 item_num == %d, item amount == %d", 
@@ -115,13 +116,13 @@
 		if (d_reclen <= 32) {
 		  local_buf = small_buf ;
 		} else {
-		    local_buf = kmalloc(d_reclen, GFP_NOFS) ;
+		    local_buf = reiserfs_kmalloc(d_reclen, GFP_NOFS, inode->i_sb) ;
 		    if (!local_buf) {
 			pathrelse (&path_to_entry);
 			return -ENOMEM ;
 		    }
 		    if (item_moved (&tmp_ih, &path_to_entry)) {
-			kfree(local_buf) ;
+			reiserfs_kfree(local_buf, d_reclen, inode->i_sb) ;
 			goto research;
 		    }
 		}
@@ -133,12 +134,12 @@
 		if (filldir (dirent, local_buf, d_reclen, d_off, d_ino, 
 		             DT_UNKNOWN) < 0) {
 		    if (local_buf != small_buf) {
-			kfree(local_buf) ;
+			reiserfs_kfree(local_buf, d_reclen, inode->i_sb) ;
 		    }
 		    goto end;
 		}
 		if (local_buf != small_buf) {
-		    kfree(local_buf) ;
+		    reiserfs_kfree(local_buf, d_reclen, inode->i_sb) ;
 		}
 
 		// next entry should be looked for with such offset
@@ -180,6 +181,7 @@
     filp->f_pos = next_pos;
     pathrelse (&path_to_entry);
     reiserfs_check_path(&path_to_entry) ;
+    UPDATE_ATIME(inode) ;
     return 0;
 }
 
diff -uNr linux-2.4.18.original/fs/reiserfs/fix_node.c linux-2.4.18/fs/reiserfs/fix_node.c
--- linux-2.4.18.original/fs/reiserfs/fix_node.c	Tue Feb 26 15:53:01 2002
+++ linux-2.4.18/fs/reiserfs/fix_node.c	Fri Mar  1 18:09:21 2002
@@ -1979,7 +1979,7 @@
     return CARRY_ON;
 }
 
-
+#ifdef CONFIG_REISERFS_CHECK
 void * reiserfs_kmalloc (size_t size, int flags, struct super_block * s)
 {
     void * vp;
@@ -2007,6 +2007,7 @@
 	reiserfs_warning ("vs-8302: reiserfs_kfree: allocated memory %d\n", s->u.reiserfs_sb.s_kmallocs);
 
 }
+#endif
 
 
 static int get_virtual_node_size (struct super_block * sb, struct buffer_head * bh)
@@ -2356,7 +2357,6 @@
     for ( n_h = 0; n_h < MAX_HEIGHT && p_s_tb->insert_size[n_h]; n_h++ ) { 
 	if ( (n_ret_value = get_direct_parent(p_s_tb, n_h)) != CARRY_ON ) {
 	    goto repeat;
-	    return n_ret_value;
 	}
 
 	if ( (n_ret_value = check_balance (n_op_mode, p_s_tb, n_h, n_item_num,
@@ -2365,7 +2365,6 @@
 		/* No balancing for higher levels needed. */
 		if ( (n_ret_value = get_neighbors(p_s_tb, n_h)) != CARRY_ON ) {
 		    goto repeat;
-		    return n_ret_value;
 		}
 		if ( n_h != MAX_HEIGHT - 1 )  
 		    p_s_tb->insert_size[n_h + 1] = 0;
@@ -2373,17 +2372,14 @@
 		break;
 	    }
 	    goto repeat;
-	    return n_ret_value;
 	}
 
 	if ( (n_ret_value = get_neighbors(p_s_tb, n_h)) != CARRY_ON ) {
 	    goto repeat;
-	    return n_ret_value;
 	}
 
 	if ( (n_ret_value = get_empty_nodes(p_s_tb, n_h)) != CARRY_ON ) {
-	    goto repeat;
-	    return n_ret_value; /* No disk space, or schedule occurred and
+	    goto repeat;        /* No disk space, or schedule occurred and
 				   analysis may be invalid and needs to be redone. */
 	}
     
diff -uNr linux-2.4.18.original/fs/reiserfs/inode.c linux-2.4.18/fs/reiserfs/inode.c
--- linux-2.4.18.original/fs/reiserfs/inode.c	Tue Feb 26 15:53:01 2002
+++ linux-2.4.18/fs/reiserfs/inode.c	Fri Mar  1 18:09:21 2002
@@ -445,6 +445,24 @@
     return reiserfs_get_block(inode, block, bh_result, GET_BLOCK_NO_HOLE) ;
 }
 
+static int reiserfs_get_block_direct_io (struct inode * inode, long block,
+			struct buffer_head * bh_result, int create) {
+    int ret ;
+
+    ret = reiserfs_get_block(inode, block, bh_result, create) ;
+
+    /* don't allow direct io onto tail pages */
+    if (ret == 0 && buffer_mapped(bh_result) && bh_result->b_blocknr == 0) {
+	/* make sure future calls to the direct io funcs for this offset
+	** in the file fail by unmapping the buffer
+	*/
+	reiserfs_unmap_buffer(bh_result);
+        ret = -EINVAL ;
+    }
+    return ret ;
+}
+
+
 /*
 ** helper function for when reiserfs_get_block is called for a hole
 ** but the file tail is still in a direct item
@@ -748,14 +766,24 @@
 
 		retval = convert_tail_for_hole(inode, bh_result, tail_offset) ;
 		if (retval) {
-		    printk("clm-6004: convert tail failed inode %lu, error %d\n", inode->i_ino, retval) ;
-		    if (allocated_block_nr)
+		    if ( retval != -ENOSPC )
+			printk("clm-6004: convert tail failed inode %lu, error %d\n", inode->i_ino, retval) ;
+		    if (allocated_block_nr) {
+			/* the bitmap, the super, and the stat data == 3 */
+			journal_begin(&th, inode->i_sb, 3) ;
 			reiserfs_free_block (&th, allocated_block_nr);
+			transaction_started = 1 ;
+		    }
 		    goto failure ;
 		}
 		goto research ;
 	    }
 	    retval = direct2indirect (&th, inode, &path, unbh, tail_offset);
+	    if (retval) {
+		reiserfs_unmap_buffer(unbh);
+		reiserfs_free_block (&th, allocated_block_nr);
+		goto failure;
+	    }
 	    /* it is important the mark_buffer_uptodate is done after
 	    ** the direct2indirect.  The buffer might contain valid
 	    ** data newer than the data on disk (read by readpage, changed,
@@ -765,10 +793,7 @@
 	    ** the disk
 	    */
 	    mark_buffer_uptodate (unbh, 1);
-	    if (retval) {
-		reiserfs_free_block (&th, allocated_block_nr);
-		goto failure;
-	    }
+
 	    /* we've converted the tail, so we must 
 	    ** flush unbh before the transaction commits
 	    */
@@ -914,7 +939,7 @@
 	inode->i_blocks = sd_v1_blocks(sd);
 	inode->i_generation = le32_to_cpu (INODE_PKEY (inode)->k_dir_id);
 	blocks = (inode->i_size + 511) >> 9;
-	blocks = _ROUND_UP (blocks, inode->i_blksize >> 9);
+	blocks = _ROUND_UP (blocks, inode->i_sb->s_blocksize >> 9);
 	if (inode->i_blocks > blocks) {
 	    // there was a bug in <=3.5.23 when i_blocks could take negative
 	    // values. Starting from 3.5.17 this value could even be stored in
@@ -926,6 +951,9 @@
 
         rdev = sd_v1_rdev(sd);
 	inode->u.reiserfs_i.i_first_direct_byte = sd_v1_first_direct_byte(sd);
+	/* nopack is initially zero for v1 objects. For v2 objects,
+	   nopack is initialised from sd_attrs */
+	inode->u.reiserfs_i.i_flags &= ~i_nopack_mask;
     } else {
 	// new stat data found, but object may have old items
 	// (directories and symlinks)
@@ -952,10 +980,12 @@
             set_inode_item_key_version (inode, KEY_FORMAT_3_6);
 
         set_inode_sd_version (inode, STAT_DATA_V2);
+	/* read persistent inode attributes from sd and initalise
+	   generic inode flags from them */
+	inode -> u.reiserfs_i.i_attrs = sd_v2_attrs( sd );
+	sd_attrs_to_i_attrs( sd_v2_attrs( sd ), inode );
     }
 
-    /* nopack = 0, by default */
-    inode->u.reiserfs_i.i_flags &= ~i_nopack_mask;
 
     pathrelse (path);
     if (S_ISREG (inode->i_mode)) {
@@ -979,6 +1009,7 @@
 static void inode2sd (void * sd, struct inode * inode)
 {
     struct stat_data * sd_v2 = (struct stat_data *)sd;
+    __u16 flags;
 
     set_sd_v2_mode(sd_v2, inode->i_mode );
     set_sd_v2_nlink(sd_v2, inode->i_nlink );
@@ -989,13 +1020,13 @@
     set_sd_v2_atime(sd_v2, inode->i_atime );
     set_sd_v2_ctime(sd_v2, inode->i_ctime );
     set_sd_v2_blocks(sd_v2, inode->i_blocks );
-    if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
+    if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
         set_sd_v2_rdev(sd_v2, inode->i_rdev );
-}
     else
-    {
         set_sd_v2_generation(sd_v2, inode->i_generation);
-    }
+    flags = inode -> u.reiserfs_i.i_attrs;
+    i_attrs_to_sd_attrs( inode, &flags );
+    set_sd_v2_attrs( sd_v2, flags );
 }
 
 
@@ -1493,7 +1524,9 @@
     }
 
     sb = dir->i_sb;
-    inode->i_flags = 0;//inode->i_sb->s_flags;
+    inode -> u.reiserfs_i.i_attrs = 
+	    dir -> u.reiserfs_i.i_attrs & REISERFS_INHERIT_MASK;
+    sd_attrs_to_i_attrs( inode -> u.reiserfs_i.i_attrs, inode );
 
     /* item head of new item */
     ih.ih_key.k_dir_id = INODE_PKEY (dir)->k_objectid;
@@ -1552,6 +1585,10 @@
     } else
 	inode->i_gid = current->fsgid;
 
+    /* symlink cannot be immutable or append only, right? */
+    if( S_ISLNK( inode -> i_mode ) )
+	    inode -> i_flags &= ~ ( S_IMMUTABLE | S_APPEND );
+
     inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
     inode->i_size = i_size;
     inode->i_blocks = (inode->i_size + 511) >> 9;
@@ -1898,14 +1935,21 @@
 static inline void submit_bh_for_writepage(struct buffer_head **bhp, int nr) {
     struct buffer_head *bh ;
     int i;
+
+    /* lock them all first so the end_io handler doesn't unlock the page
+    ** too early
+    */
     for(i = 0 ; i < nr ; i++) {
         bh = bhp[i] ;
 	lock_buffer(bh) ;
 	set_buffer_async_io(bh) ;
+    }
+    for(i = 0 ; i < nr ; i++) {
 	/* submit_bh doesn't care if the buffer is dirty, but nobody
 	** later on in the call chain will be cleaning it.  So, we
 	** clean the buffer here, it still gets written either way.
 	*/
+        bh = bhp[i] ;
 	clear_bit(BH_Dirty, &bh->b_state) ;
 	set_bit(BH_Uptodate, &bh->b_state) ;
 	submit_bh(WRITE, bh) ;
@@ -2073,11 +2117,64 @@
     return ret ;
 }
 
+void sd_attrs_to_i_attrs( __u16 sd_attrs, struct inode *inode )
+{
+	if( reiserfs_attrs( inode -> i_sb ) ) {
+		if( sd_attrs & REISERFS_SYNC_FL )
+			inode -> i_flags |= S_SYNC;
+		else
+			inode -> i_flags &= ~S_SYNC;
+		if( sd_attrs & REISERFS_IMMUTABLE_FL )
+			inode -> i_flags |= S_IMMUTABLE;
+		else
+			inode -> i_flags &= ~S_IMMUTABLE;
+		if( sd_attrs & REISERFS_NOATIME_FL )
+			inode -> i_flags |= S_NOATIME;
+		else
+			inode -> i_flags &= ~S_NOATIME;
+		if( sd_attrs & REISERFS_NOTAIL_FL )
+			inode->u.reiserfs_i.i_flags |= i_nopack_mask;
+		else
+			inode->u.reiserfs_i.i_flags &= ~i_nopack_mask;
+	}
+}
+
+void i_attrs_to_sd_attrs( struct inode *inode, __u16 *sd_attrs )
+{
+	if( reiserfs_attrs( inode -> i_sb ) ) {
+		if( inode -> i_flags & S_IMMUTABLE )
+			*sd_attrs |= REISERFS_IMMUTABLE_FL;
+		else
+			*sd_attrs &= ~REISERFS_IMMUTABLE_FL;
+		if( inode -> i_flags & S_SYNC )
+			*sd_attrs |= REISERFS_SYNC_FL;
+		else
+			*sd_attrs &= ~REISERFS_SYNC_FL;
+		if( inode -> i_flags & S_NOATIME )
+			*sd_attrs |= REISERFS_NOATIME_FL;
+		else
+			*sd_attrs &= ~REISERFS_NOATIME_FL;
+		if( inode->u.reiserfs_i.i_flags & i_nopack_mask )
+			*sd_attrs |= REISERFS_NOTAIL_FL;
+		else
+			*sd_attrs &= ~REISERFS_NOTAIL_FL;
+	}
+}
+
+static int reiserfs_direct_io(int rw, struct inode *inode, 
+                              struct kiobuf *iobuf, unsigned long blocknr,
+			      int blocksize) 
+{
+    return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize,
+                             reiserfs_get_block_direct_io) ;
+}
+
 struct address_space_operations reiserfs_address_space_operations = {
     writepage: reiserfs_writepage,
     readpage: reiserfs_readpage, 
     sync_page: block_sync_page,
     prepare_write: reiserfs_prepare_write,
     commit_write: reiserfs_commit_write,
-    bmap: reiserfs_aop_bmap
+    bmap: reiserfs_aop_bmap,
+    direct_IO: reiserfs_direct_io,
 } ;
diff -uNr linux-2.4.18.original/fs/reiserfs/ioctl.c linux-2.4.18/fs/reiserfs/ioctl.c
--- linux-2.4.18.original/fs/reiserfs/ioctl.c	Tue Feb 26 15:52:56 2002
+++ linux-2.4.18/fs/reiserfs/ioctl.c	Fri Mar  1 18:09:21 2002
@@ -14,17 +14,70 @@
 ** supported commands:
 **  1) REISERFS_IOC_UNPACK - try to unpack tail from direct item into indirect
 **                           and prevent packing file (argument arg has to be non-zero)
-**  2) That's all for a while ...
+**  2) REISERFS_IOC_[GS]ETFLAGS, REISERFS_IOC_[GS]ETVERSION
+**  3) That's all for a while ...
 */
 int reiserfs_ioctl (struct inode * inode, struct file * filp, unsigned int cmd,
 		unsigned long arg)
 {
+	unsigned int flags;
+
 	switch (cmd) {
 	    case REISERFS_IOC_UNPACK:
+		if( S_ISREG( inode -> i_mode ) ) {
 		if (arg)
 		    return reiserfs_unpack (inode, filp);
+			else
+				return 0;
+		} else
+			return -ENOTTY;
+	/* following two cases are taken from fs/ext2/ioctl.c by Remy
+	   Card (card@masi.ibp.fr) */
+	case REISERFS_IOC_GETFLAGS:
+		flags = inode -> u.reiserfs_i.i_attrs;
+		i_attrs_to_sd_attrs( inode, ( __u16 * ) &flags );
+		return put_user(flags, (int *) arg);
+	case REISERFS_IOC_SETFLAGS: {
+		if (IS_RDONLY(inode))
+			return -EROFS;
+
+		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
+			return -EPERM;
+
+		if (get_user(flags, (int *) arg))
+			return -EFAULT;
+
+		if ( ( flags & REISERFS_IMMUTABLE_FL ) && 
+		     !capable( CAP_LINUX_IMMUTABLE ) )
+			return -EPERM;
 			
-	    default:
+		if( ( flags & REISERFS_NOTAIL_FL ) &&
+		    S_ISREG( inode -> i_mode ) ) {
+				int result;
+
+				result = reiserfs_unpack( inode, filp );
+				if( result )
+					return result;
+		}
+		sd_attrs_to_i_attrs( flags, inode );
+		inode -> u.reiserfs_i.i_attrs = flags;
+		inode->i_ctime = CURRENT_TIME;
+		mark_inode_dirty(inode);
+		return 0;
+	}
+	case REISERFS_IOC_GETVERSION:
+		return put_user(inode->i_generation, (int *) arg);
+	case REISERFS_IOC_SETVERSION:
+		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
+			return -EPERM;
+		if (IS_RDONLY(inode))
+			return -EROFS;
+		if (get_user(inode->i_generation, (int *) arg))
+			return -EFAULT;	
+		inode->i_ctime = CURRENT_TIME;
+		mark_inode_dirty(inode);
+		return 0;
+	default:
 		return -ENOTTY;
 	}
 }
@@ -43,7 +96,8 @@
     unsigned long blocksize = inode->i_sb->s_blocksize ;
     	
     if (inode->i_size == 0) {
-        return -EINVAL ;
+        inode->u.reiserfs_i.i_flags |= i_nopack_mask;
+        return 0 ;
     }
     /* ioctl already done */
     if (inode->u.reiserfs_i.i_flags & i_nopack_mask) {
diff -uNr linux-2.4.18.original/fs/reiserfs/item_ops.c linux-2.4.18/fs/reiserfs/item_ops.c
--- linux-2.4.18.original/fs/reiserfs/item_ops.c	Sat Oct 13 01:19:28 2001
+++ linux-2.4.18/fs/reiserfs/item_ops.c	Fri Mar  1 18:09:21 2002
@@ -685,17 +685,110 @@
 
 
 //////////////////////////////////////////////////////////////////////////////
+// Error catching functions to catch errors caused by incorrect item types.
+//
+static int errcatch_bytes_number (struct item_head * ih, int block_size)
+{
+    reiserfs_warning ("green-16001: Invalid item type observed, run fsck ASAP\n");
+    return 0;
+}
+
+static void errcatch_decrement_key (struct cpu_key * key)
+{
+    reiserfs_warning ("green-16002: Invalid item type observed, run fsck ASAP\n");
+}
+
+
+static int errcatch_is_left_mergeable (struct key * key, unsigned long bsize)
+{
+    reiserfs_warning ("green-16003: Invalid item type observed, run fsck ASAP\n");
+    return 0;
+}
+
+
+static void errcatch_print_item (struct item_head * ih, char * item)
+{
+    reiserfs_warning ("green-16004: Invalid item type observed, run fsck ASAP\n");
+}
+
+
+static void errcatch_check_item (struct item_head * ih, char * item)
+{
+    reiserfs_warning ("green-16005: Invalid item type observed, run fsck ASAP\n");
+}
+
+static int errcatch_create_vi (struct virtual_node * vn,
+			       struct virtual_item * vi, 
+			       int is_affected, 
+			       int insert_size)
+{
+    reiserfs_warning ("green-16006: Invalid item type observed, run fsck ASAP\n");
+    return 0;	// We might return -1 here as well, but it won't help as create_virtual_node() from where
+		// this operation is called from is of return type void.
+}
+
+static int errcatch_check_left (struct virtual_item * vi, int free,
+				int start_skip, int end_skip)
+{
+    reiserfs_warning ("green-16007: Invalid item type observed, run fsck ASAP\n");
+    return -1;
+}
+
+
+static int errcatch_check_right (struct virtual_item * vi, int free)
+{
+    reiserfs_warning ("green-16008: Invalid item type observed, run fsck ASAP\n");
+    return -1;
+}
+
+static int errcatch_part_size (struct virtual_item * vi, int first, int count)
+{
+    reiserfs_warning ("green-16009: Invalid item type observed, run fsck ASAP\n");
+    return 0;
+}
+
+static int errcatch_unit_num (struct virtual_item * vi)
+{
+    reiserfs_warning ("green-16010: Invalid item type observed, run fsck ASAP\n");
+    return 0;
+}
+
+static void errcatch_print_vi (struct virtual_item * vi)
+{
+    reiserfs_warning ("green-16011: Invalid item type observed, run fsck ASAP\n");
+}
+
+struct item_operations errcatch_ops = {
+    errcatch_bytes_number,
+    errcatch_decrement_key,
+    errcatch_is_left_mergeable,
+    errcatch_print_item,
+    errcatch_check_item,
+
+    errcatch_create_vi,
+    errcatch_check_left,
+    errcatch_check_right,
+    errcatch_part_size,
+    errcatch_unit_num,
+    errcatch_print_vi
+};
+
+
+
+//////////////////////////////////////////////////////////////////////////////
 //
 //
 #if ! (TYPE_STAT_DATA == 0 && TYPE_INDIRECT == 1 && TYPE_DIRECT == 2 && TYPE_DIRENTRY == 3)
   do not compile
 #endif
 
-struct item_operations * item_ops [4] = {
+struct item_operations * item_ops [TYPE_ANY + 1] = {
   &stat_data_ops,
   &indirect_ops,
   &direct_ops,
-  &direntry_ops
+  &direntry_ops,
+  NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+  &errcatch_ops		/* This is to catch errors with invalid type (15th entry for TYPE_ANY) */
 };
 
 
diff -uNr linux-2.4.18.original/fs/reiserfs/journal.c linux-2.4.18/fs/reiserfs/journal.c
--- linux-2.4.18.original/fs/reiserfs/journal.c	Tue Feb 26 15:53:01 2002
+++ linux-2.4.18/fs/reiserfs/journal.c	Fri Mar  1 18:09:21 2002
@@ -71,7 +71,9 @@
 static DECLARE_WAIT_QUEUE_HEAD(reiserfs_commit_thread_done) ;
 DECLARE_TASK_QUEUE(reiserfs_commit_thread_tq) ;
 
-#define JOURNAL_TRANS_HALF 1018   /* must be correct to keep the desc and commit structs at 4k */
+#define JOURNAL_TRANS_HALF 1018   /* must be correct to keep the desc and commit
+				     structs at 4k */
+#define BUFNR 64 /*read ahead */
 
 /* cnode stat bits.  Move these into reiserfs_fs.h */
 
@@ -117,13 +119,13 @@
   struct reiserfs_bitmap_node *bn ;
   static int id = 0 ;
 
-  bn = kmalloc(sizeof(struct reiserfs_bitmap_node), GFP_NOFS) ;
+  bn = reiserfs_kmalloc(sizeof(struct reiserfs_bitmap_node), GFP_NOFS, p_s_sb) ;
   if (!bn) {
     return NULL ;
   }
-  bn->data = kmalloc(p_s_sb->s_blocksize, GFP_NOFS) ;
+  bn->data = reiserfs_kmalloc(p_s_sb->s_blocksize, GFP_NOFS, p_s_sb) ;
   if (!bn->data) {
-    kfree(bn) ;
+    reiserfs_kfree(bn, sizeof(struct reiserfs_bitmap_node), p_s_sb) ;
     return NULL ;
   }
   bn->id = id++ ;
@@ -159,8 +161,8 @@
                                     struct reiserfs_bitmap_node *bn) {
   SB_JOURNAL(p_s_sb)->j_used_bitmap_nodes-- ;
   if (SB_JOURNAL(p_s_sb)->j_free_bitmap_nodes > REISERFS_MAX_BITMAP_NODES) {
-    kfree(bn->data) ;
-    kfree(bn) ;
+    reiserfs_kfree(bn->data, p_s_sb->s_blocksize, p_s_sb) ;
+    reiserfs_kfree(bn, sizeof(struct reiserfs_bitmap_node), p_s_sb) ;
   } else {
     list_add(&bn->list, &SB_JOURNAL(p_s_sb)->j_bitmap_nodes) ;
     SB_JOURNAL(p_s_sb)->j_free_bitmap_nodes++ ;
@@ -228,8 +230,8 @@
   while(next != &SB_JOURNAL(p_s_sb)->j_bitmap_nodes) {
     bn = list_entry(next, struct reiserfs_bitmap_node, list) ;
     list_del(next) ;
-    kfree(bn->data) ;
-    kfree(bn) ;
+    reiserfs_kfree(bn->data, p_s_sb->s_blocksize, p_s_sb) ;
+    reiserfs_kfree(bn, sizeof(struct reiserfs_bitmap_node), p_s_sb) ;
     next = SB_JOURNAL(p_s_sb)->j_bitmap_nodes.next ;
     SB_JOURNAL(p_s_sb)->j_free_bitmap_nodes-- ;
   }
@@ -1500,13 +1502,13 @@
   }
   trans_id = le32_to_cpu(desc->j_trans_id) ;
   /* now we know we've got a good transaction, and it was inside the valid time ranges */
-  log_blocks = kmalloc(le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), GFP_NOFS) ;
-  real_blocks = kmalloc(le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), GFP_NOFS) ;
+  log_blocks = reiserfs_kmalloc(le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), GFP_NOFS, p_s_sb) ;
+  real_blocks = reiserfs_kmalloc(le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), GFP_NOFS, p_s_sb) ;
   if (!log_blocks  || !real_blocks) {
     brelse(c_bh) ;
     brelse(d_bh) ;
-    kfree(log_blocks) ;
-    kfree(real_blocks) ;
+    reiserfs_kfree(log_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), p_s_sb) ;
+    reiserfs_kfree(real_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), p_s_sb) ;
     reiserfs_warning("journal-1169: kmalloc failed, unable to mount FS\n") ;
     return -1 ;
   }
@@ -1525,8 +1527,8 @@
       brelse_array(real_blocks, i) ;
       brelse(c_bh) ;
       brelse(d_bh) ;
-      kfree(log_blocks) ;
-      kfree(real_blocks) ;
+      reiserfs_kfree(log_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), p_s_sb) ;
+      reiserfs_kfree(real_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), p_s_sb) ;
       return -1 ;
     }
   }
@@ -1540,8 +1542,8 @@
       brelse_array(real_blocks, le32_to_cpu(desc->j_len)) ;
       brelse(c_bh) ;
       brelse(d_bh) ;
-      kfree(log_blocks) ;
-      kfree(real_blocks) ;
+      reiserfs_kfree(log_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), p_s_sb) ;
+      reiserfs_kfree(real_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), p_s_sb) ;
       return -1 ;
     }
     memcpy(real_blocks[i]->b_data, log_blocks[i]->b_data, real_blocks[i]->b_size) ;
@@ -1560,8 +1562,8 @@
       brelse_array(real_blocks + i, le32_to_cpu(desc->j_len) - i) ;
       brelse(c_bh) ;
       brelse(d_bh) ;
-      kfree(log_blocks) ;
-      kfree(real_blocks) ;
+      reiserfs_kfree(log_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), p_s_sb) ;
+      reiserfs_kfree(real_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), p_s_sb) ;
       return -1 ;
     }
     brelse(real_blocks[i]) ;
@@ -1577,8 +1579,8 @@
   SB_JOURNAL(p_s_sb)->j_trans_id = trans_id + 1;
   brelse(c_bh) ;
   brelse(d_bh) ;
-  kfree(log_blocks) ;
-  kfree(real_blocks) ;
+  reiserfs_kfree(log_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), p_s_sb) ;
+  reiserfs_kfree(real_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), p_s_sb) ;
   return 0 ;
 }
 
@@ -1591,6 +1593,41 @@
 **
 ** On exit, it sets things up so the first transaction will work correctly.
 */
+struct buffer_head * reiserfs_breada (kdev_t dev, int block, int bufsize,
+			    unsigned int max_block)
+{
+	struct buffer_head * bhlist[BUFNR];
+	unsigned int blocks = BUFNR;
+	struct buffer_head * bh;
+	int i, j;
+	
+	bh = getblk (dev, block, bufsize);
+	if (buffer_uptodate (bh))
+		return (bh);   
+		
+	if (block + BUFNR > max_block) {
+		blocks = max_block - block;
+	}
+	bhlist[0] = bh;
+	j = 1;
+	for (i = 1; i < blocks; i++) {
+		bh = getblk (dev, block + i, bufsize);
+		if (buffer_uptodate (bh)) {
+			brelse (bh);
+			break;
+		}
+		else bhlist[j++] = bh;
+	}
+	ll_rw_block (READ, j, bhlist);
+	for(i = 1; i < j; i++) 
+		brelse (bhlist[i]);
+	bh = bhlist[0];
+	wait_on_buffer (bh);
+	if (buffer_uptodate (bh))
+		return bh;
+	brelse (bh);
+	return NULL;
+}
 static int journal_read(struct super_block *p_s_sb) {
   struct reiserfs_journal_desc *desc ;
   unsigned long last_flush_trans_id = 0 ;
@@ -1660,7 +1697,8 @@
   ** all the valid transactions, and pick out the oldest.
   */
   while(continue_replay && cur_dblock < (reiserfs_get_journal_block(p_s_sb) + JOURNAL_BLOCK_COUNT)) {
-    d_bh = sb_bread(p_s_sb, cur_dblock) ;
+    d_bh = reiserfs_breada(p_s_sb->s_dev, cur_dblock, p_s_sb->s_blocksize,
+			   reiserfs_get_journal_block(p_s_sb) + JOURNAL_BLOCK_COUNT) ;
     ret = journal_transaction_is_valid(p_s_sb, d_bh, &oldest_invalid_trans_id, &newest_mount_id) ;
     if (ret == 1) {
       desc = (struct reiserfs_journal_desc *)d_bh->b_data ;
@@ -1777,7 +1815,7 @@
       atomic_read(&(jl->j_commit_left)) == 0) {
     kupdate_one_transaction(ct->p_s_sb, jl) ;
   }
-  kfree(ct->self) ;
+  reiserfs_kfree(ct->self, sizeof(struct reiserfs_journal_commit_task), ct->p_s_sb) ;
 }
 
 static void setup_commit_task_arg(struct reiserfs_journal_commit_task *ct,
@@ -1801,7 +1839,7 @@
   /* using GFP_NOFS, GFP_KERNEL could try to flush inodes, which will try
   ** to start/join a transaction, which will deadlock
   */
-  ct = kmalloc(sizeof(struct reiserfs_journal_commit_task), GFP_NOFS) ;
+  ct = reiserfs_kmalloc(sizeof(struct reiserfs_journal_commit_task), GFP_NOFS, p_s_sb) ;
   if (ct) {
     setup_commit_task_arg(ct, p_s_sb, jindex) ;
     queue_task(&(ct->task), &reiserfs_commit_thread_tq);
diff -uNr linux-2.4.18.original/fs/reiserfs/namei.c linux-2.4.18/fs/reiserfs/namei.c
--- linux-2.4.18.original/fs/reiserfs/namei.c	Tue Feb 26 15:53:01 2002
+++ linux-2.4.18/fs/reiserfs/namei.c	Fri Mar  1 18:09:21 2002
@@ -340,7 +340,7 @@
 static struct dentry * reiserfs_lookup (struct inode * dir, struct dentry * dentry)
 {
     int retval;
-    struct inode * inode = 0;
+    struct inode * inode = NULL;
     struct reiserfs_dir_entry de;
     INITIALIZE_PATH (path_to_entry);
 
@@ -358,6 +358,9 @@
 	    return ERR_PTR(-EACCES);
         }
     }
+    if ( retval == IO_ERROR ) {
+	return ERR_PTR(-EIO);
+    }
 
     d_add(dentry, inode);
     return NULL;
@@ -443,6 +446,10 @@
 	    reiserfs_kfree (buffer, buflen, dir->i_sb);
 	pathrelse (&path);
 
+	if ( retval == IO_ERROR ) {
+	    return -EIO;
+	}
+
         if (retval != NAME_FOUND) {
 	    reiserfs_warning ("zam-7002:" __FUNCTION__ ": \"reiserfs_find_entry\" has returned"
                               " unexpected value (%d)\n", retval);
@@ -470,7 +477,7 @@
     if (gen_number != 0) {	/* we need to re-search for the insertion point */
       if (search_by_entry_key (dir->i_sb, &entry_key, &path, &de) != NAME_NOT_FOUND) {
             reiserfs_warning ("vs-7032: reiserfs_add_entry: "
-                            "entry with this key (%k) already exists\n", &entry_key);
+                            "entry with this key (%K) already exists\n", &entry_key);
 
 	    if (buffer != small_buf)
 		reiserfs_kfree (buffer, buflen, dir->i_sb);
@@ -715,10 +722,14 @@
     windex = push_journal_writer("reiserfs_rmdir") ;
 
     de.de_gen_number_bit_string = 0;
-    if (reiserfs_find_entry (dir, dentry->d_name.name, dentry->d_name.len, &path, &de) == NAME_NOT_FOUND) {
+    if ( (retval = reiserfs_find_entry (dir, dentry->d_name.name, dentry->d_name.len, &path, &de)) == NAME_NOT_FOUND) {
 	retval = -ENOENT;
 	goto end_rmdir;
+    } else if ( retval == IO_ERROR) {
+	retval = -EIO;
+	goto end_rmdir;
     }
+
     inode = dentry->d_inode;
 
     reiserfs_update_inode_transaction(inode) ;
@@ -800,9 +811,12 @@
     windex = push_journal_writer("reiserfs_unlink") ;
 	
     de.de_gen_number_bit_string = 0;
-    if (reiserfs_find_entry (dir, dentry->d_name.name, dentry->d_name.len, &path, &de) == NAME_NOT_FOUND) {
+    if ( (retval = reiserfs_find_entry (dir, dentry->d_name.name, dentry->d_name.len, &path, &de)) == NAME_NOT_FOUND) {
 	retval = -ENOENT;
 	goto end_unlink;
+    } else if (retval == IO_ERROR) {
+	retval = -EIO;
+	goto end_unlink;
     }
 
     reiserfs_update_inode_transaction(inode) ;
@@ -881,7 +895,7 @@
 	return -ENAMETOOLONG;
     }
   
-    name = kmalloc (item_len, GFP_NOFS);
+    name = reiserfs_kmalloc (item_len, GFP_NOFS, dir->i_sb);
     if (!name) {
 	iput(inode) ;
 	return -ENOMEM;
@@ -894,7 +908,7 @@
 
     inode = reiserfs_new_inode (&th, dir, S_IFLNK | S_IRWXUGO, name, strlen (symname), dentry,
 				inode, &retval);
-    kfree (name);
+    reiserfs_kfree (name, item_len, dir->i_sb);
     if (inode == 0) { /* reiserfs_new_inode iputs for us */
 	pop_journal_writer(windex) ;
 	journal_end(&th, dir->i_sb, jbegin_count) ;
@@ -1065,8 +1079,10 @@
     retval = reiserfs_find_entry (old_dir, old_dentry->d_name.name, old_dentry->d_name.len,
 				  &old_entry_path, &old_de);
     pathrelse (&old_entry_path);
+    if (retval == IO_ERROR)
+	return -EIO;
+
     if (retval != NAME_FOUND || old_de.de_objectid != old_inode->i_ino) {
-	// FIXME: IO error is possible here
 	return -ENOENT;
     }
 
@@ -1138,6 +1154,8 @@
 	new_de.de_gen_number_bit_string = 0;
 	retval = reiserfs_find_entry (new_dir, new_dentry->d_name.name, new_dentry->d_name.len, 
 				      &new_entry_path, &new_de);
+	// reiserfs_add_entry should not return IO_ERROR, because it is called with essentially same parameters from
+        // reiserfs_add_entry above, and we'll catch any i/o errors before we get here.
 	if (retval != NAME_FOUND_INVISIBLE && retval != NAME_FOUND)
 	    BUG ();
 
diff -uNr linux-2.4.18.original/fs/reiserfs/objectid.c linux-2.4.18/fs/reiserfs/objectid.c
--- linux-2.4.18.original/fs/reiserfs/objectid.c	Tue Feb 26 15:52:56 2002
+++ linux-2.4.18/fs/reiserfs/objectid.c	Fri Mar  1 18:09:21 2002
@@ -5,6 +5,7 @@
 #include <linux/config.h>
 #include <linux/string.h>
 #include <linux/locks.h>
+#include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/reiserfs_fs.h>
 
@@ -195,6 +196,10 @@
 
     /* set the max size so we don't overflow later */
     disk_sb->s_oid_maxsize = cpu_to_le16(new_size) ;
+
+    /* Zero out label and generate random UUID */
+    memset(disk_sb->s_label, 0, sizeof(disk_sb->s_label)) ;
+    generate_random_uuid(disk_sb->s_uuid);
 
     /* finally, zero out the unused chunk of the new super */
     memset(disk_sb->s_unused, 0, sizeof(disk_sb->s_unused)) ;
diff -uNr linux-2.4.18.original/fs/reiserfs/prints.c linux-2.4.18/fs/reiserfs/prints.c
--- linux-2.4.18.original/fs/reiserfs/prints.c	Tue Feb 26 15:52:56 2002
+++ linux-2.4.18/fs/reiserfs/prints.c	Fri Mar  1 18:09:21 2002
@@ -477,6 +477,17 @@
     return 0;
 }
 
+char * reiserfs_hashname(int code)
+{
+    if ( code == YURA_HASH)
+	return "rupasov";
+    if ( code == TEA_HASH)
+	return "tea";
+    if ( code == R5_HASH)
+	return "r5";
+
+    return "unknown";
+}
 /* return 1 if this is not super block */
 static int print_super_block (struct buffer_head * bh)
 {
@@ -519,8 +530,7 @@
     printk ("Filesystem state %s\n", 
 	    (sb_state(rs) == REISERFS_VALID_FS) ? "VALID" : "ERROR");
     printk ("Hash function \"%s\"\n",
-            sb_hash_function_code(rs) == TEA_HASH ? "tea" :
-	    ( sb_hash_function_code(rs) == YURA_HASH ? "rupasov" : (sb_hash_function_code(rs) == R5_HASH ? "r5" : "unknown")));
+            reiserfs_hashname(sb_hash_function_code(rs)));
 
     printk ("Tree height %d\n", sb_tree_height(rs));
     return 0;
diff -uNr linux-2.4.18.original/fs/reiserfs/procfs.c linux-2.4.18/fs/reiserfs/procfs.c
--- linux-2.4.18.original/fs/reiserfs/procfs.c	Tue Feb 26 15:53:01 2002
+++ linux-2.4.18/fs/reiserfs/procfs.c	Fri Mar  1 18:09:21 2002
@@ -172,6 +172,12 @@
 			"search_by_key_fs_changed: \t%lu\n"
 			"search_by_key_restarted: \t%lu\n"
 			
+			"insert_item_restarted: \t%lu\n"
+			"paste_into_item_restarted: \t%lu\n"
+			"cut_from_item_restarted: \t%lu\n"
+			"delete_solid_item_restarted: \t%lu\n"
+			"delete_item_restarted: \t%lu\n"
+
 			"leaked_oid: \t%lu\n"
 			"leaves_removable: \t%lu\n",
 
@@ -208,6 +214,13 @@
 			SFP( search_by_key ),
 			SFP( search_by_key_fs_changed ),
 			SFP( search_by_key_restarted ),
+
+			SFP( insert_item_restarted ),
+			SFP( paste_into_item_restarted ),
+			SFP( cut_from_item_restarted ),
+			SFP( delete_solid_item_restarted ),
+			SFP( delete_item_restarted ),
+
 			SFP( leaked_oid ),
 			SFP( leaves_removable ) );
 
@@ -341,6 +354,7 @@
 	struct reiserfs_sb_info *sb_info;
 	struct reiserfs_super_block *rs;
 	int hash_code;
+	__u32 flags;
 	int len = 0;
     
 	sb = procinfo_prologue( ( kdev_t ) ( long ) data );
@@ -349,6 +363,7 @@
 	sb_info = &sb->u.reiserfs_sb;
 	rs = sb_info -> s_rs;
 	hash_code = DFL( s_hash_function_code );
+	flags = DFL( s_flags );
 
 	len += sprintf( &buffer[ len ], 
 			"block_count: \t%i\n"
@@ -362,7 +377,8 @@
 			"hash: \t%s\n"
 			"tree_height: \t%i\n"
 			"bmap_nr: \t%i\n"
-			"version: \t%i\n",
+			"version: \t%i\n"
+			"flags: \t%x[%s]\n",
 
 			DFL( s_block_count ),
 			DFL( s_free_blocks ),
@@ -378,7 +394,10 @@
 			( hash_code == UNSET_HASH ) ? "unset" : "unknown",
 			DF( s_tree_height ),
 			DF( s_bmap_nr ),
-			DF( s_version ) );
+			DF( s_version ),
+			flags, 
+			( flags & reiserfs_attrs_cleared ) 
+			? "attrs_cleared" : "" );
 
 	procinfo_epilogue( sb );
 	return reiserfs_proc_tail( len, buffer, start, offset, count, eof );
diff -uNr linux-2.4.18.original/fs/reiserfs/stree.c linux-2.4.18/fs/reiserfs/stree.c
--- linux-2.4.18.original/fs/reiserfs/stree.c	Tue Feb 26 15:53:01 2002
+++ linux-2.4.18/fs/reiserfs/stree.c	Fri Mar  1 18:09:21 2002
@@ -166,7 +166,7 @@
     if (cpu_key_k_offset (key1) > cpu_key_k_offset (key2))
 	return 1;
 
-    reiserfs_warning ("comp_cpu_keys: type are compared for %k and %k\n",
+    reiserfs_warning ("comp_cpu_keys: type are compared for %K and %K\n",
 		      key1, key2);
 
     if (cpu_key_k_type (key1) < cpu_key_k_type (key2))
@@ -524,6 +524,10 @@
     ih = (struct item_head *)(buf + BLKH_SIZE);
     prev_location = blocksize;
     for (i = 0; i < nr; i ++, ih ++) {
+	if ( le_ih_k_type(ih) == TYPE_ANY) {
+	    reiserfs_warning ("is_leaf: wrong item type for item %h\n",ih);
+	    return 0;
+	}
 	if (ih_location (ih) >= blocksize || ih_location (ih) < IH_SIZE * nr) {
 	    reiserfs_warning ("is_leaf: item location seems wrong: %h\n", ih);
 	    return 0;
@@ -1242,6 +1246,8 @@
 	if ( n_ret_value != REPEAT_SEARCH )
 	    break;
 
+	PROC_INFO_INC( p_s_sb, delete_item_restarted );
+
 	// file system changed, repeat search
 	n_ret_value = search_for_position_by_key(p_s_sb, p_s_item_key, p_s_path);
 	if (n_ret_value == IO_ERROR)
@@ -1339,8 +1345,10 @@
 	}
 	if (retval != ITEM_FOUND) {
 	    pathrelse (&path);
-	    reiserfs_warning ("vs-5355: reiserfs_delete_solid_item: %k not found",
-			      key);
+	    // No need for a warning, if there is just no free space to insert '..' item into the newly-created subdir
+	    if ( !( (unsigned long long) GET_HASH_VALUE (le_key_k_offset (le_key_version (key), key)) == 0 && \
+		 GET_GENERATION_NUMBER (le_key_k_offset (le_key_version (key), key)) == 1 ) )
+		reiserfs_warning ("vs-5355: reiserfs_delete_solid_item: %k not found", key);
 	    break;
 	}
 	if (!tb_init) {
@@ -1350,8 +1358,10 @@
 	}
 
 	retval = fix_nodes (M_DELETE, &tb, NULL, 0);
-	if (retval == REPEAT_SEARCH)
+	if (retval == REPEAT_SEARCH) {
+	    PROC_INFO_INC( th -> t_super, delete_solid_item_restarted );
 	    continue;
+	}
 
 	if (retval == CARRY_ON) {
 	    do_balance (&tb, 0, 0, M_DELETE);
@@ -1523,7 +1533,7 @@
 	    set_cpu_key_k_offset (p_s_item_key, n_new_file_size + 1);
 	    if ( search_for_position_by_key(p_s_sb, p_s_item_key, p_s_path) == POSITION_NOT_FOUND ){
 		print_block (PATH_PLAST_BUFFER (p_s_path), 3, PATH_LAST_POSITION (p_s_path) - 1, PATH_LAST_POSITION (p_s_path) + 1);
-		reiserfs_panic(p_s_sb, "PAP-5580: reiserfs_cut_from_item: item to convert does not exist (%k)", p_s_item_key);
+		reiserfs_panic(p_s_sb, "PAP-5580: reiserfs_cut_from_item: item to convert does not exist (%K)", p_s_item_key);
 	    }
 	    continue;
 	}
@@ -1538,6 +1548,8 @@
       	if ( n_ret_value != REPEAT_SEARCH )
 	    break;
 	
+	PROC_INFO_INC( p_s_sb, cut_from_item_restarted );
+
 	n_ret_value = search_for_position_by_key(p_s_sb, p_s_item_key, p_s_path);
 	if (n_ret_value == POSITION_FOUND)
 	    continue;
@@ -1716,7 +1728,7 @@
 	}
 
 	RFALSE( n_deleted > n_file_size,
-		"PAP-5670: reiserfs_truncate_file returns too big number: deleted %d, file_size %lu, item_key %k",
+		"PAP-5670: reiserfs_truncate_file returns too big number: deleted %d, file_size %lu, item_key %K",
 		n_deleted, n_file_size, &s_item_key);
 
 	/* Change key to search the last file item. */
@@ -1805,6 +1817,7 @@
     
     while ( (retval = fix_nodes(M_PASTE, &s_paste_balance, NULL, p_c_body)) == REPEAT_SEARCH ) {
 	/* file system changed while we were in the fix_nodes */
+	PROC_INFO_INC( th -> t_super, paste_into_item_restarted );
 	retval = search_for_position_by_key (th->t_super, p_s_key, p_s_search_path);
 	if (retval == IO_ERROR) {
 	    retval = -EIO ;
@@ -1855,6 +1868,7 @@
 
     while ( (retval = fix_nodes(M_INSERT, &s_ins_balance, p_s_ih, p_c_body)) == REPEAT_SEARCH) {
 	/* file system changed while we were in the fix_nodes */
+	PROC_INFO_INC( th -> t_super, insert_item_restarted );
 	retval = search_item (th->t_super, key, p_s_path);
 	if (retval == IO_ERROR) {
 	    retval = -EIO;
diff -uNr linux-2.4.18.original/fs/reiserfs/super.c linux-2.4.18/fs/reiserfs/super.c
--- linux-2.4.18.original/fs/reiserfs/super.c	Tue Feb 26 15:53:01 2002
+++ linux-2.4.18/fs/reiserfs/super.c	Fri Mar  1 18:09:21 2002
@@ -207,7 +207,7 @@
         }
  
         iput (inode);
-        reiserfs_warning ("done\n");
+        printk ("done\n");
         done ++;
     }
     s -> u.reiserfs_sb.s_is_unlinked_ok = 0;
@@ -269,7 +269,8 @@
     /* look for its place in the tree */
     retval = search_item (inode->i_sb, &key, &path);
     if (retval != ITEM_NOT_FOUND) {
-	reiserfs_warning ("vs-2100: add_save_link:"
+	if ( retval != -ENOSPC )
+	    reiserfs_warning ("vs-2100: add_save_link:"
 			  "search_by_key (%K) returned %d\n", &key, retval);
 	pathrelse (&path);
 	return;
@@ -280,10 +281,11 @@
 
     /* put "save" link inot tree */
     retval = reiserfs_insert_item (th, &path, &key, &ih, (char *)&link);
-    if (retval)
-	reiserfs_warning ("vs-2120: add_save_link: insert_item returned %d\n",
+    if (retval) {
+	if (retval != -ENOSPC)
+	    reiserfs_warning ("vs-2120: add_save_link: insert_item returned %d\n",
 			  retval);
-    else {
+    } else {
 	if( truncate )
 	    inode -> u.reiserfs_i.i_flags |= i_link_saved_truncate_mask;
 	else
@@ -488,6 +490,8 @@
 	  	printk("reiserfs: hash option requires a value\n");
 		return 0 ;
 	    }
+	} else if (!strcmp (this_char, "attrs")) {
+	    set_bit (REISERFS_ATTRS, mount_options);
 	} else {
 	    printk ("reiserfs: Unrecognized mount option %s\n", this_char);
 	    return 0;
@@ -502,6 +506,24 @@
 }
 
 
+static void handle_attrs( struct super_block *s )
+{
+	struct reiserfs_super_block * rs;
+
+	if( reiserfs_attrs( s ) ) {
+		rs = SB_DISK_SUPER_BLOCK (s);
+		if( old_format_only(s) ) {
+			reiserfs_warning( "reiserfs: cannot support attributes on 3.5.x disk format\n" );
+			s -> u.reiserfs_sb.s_mount_opt &= ~ ( 1 << REISERFS_ATTRS );
+			return;
+		}
+		if( !( le32_to_cpu( rs -> s_flags ) & reiserfs_attrs_cleared ) ) {
+				reiserfs_warning( "reiserfs: cannot support attributes until flag is set in super-block\n" );
+				s -> u.reiserfs_sb.s_mount_opt &= ~ ( 1 << REISERFS_ATTRS );
+		}
+	}
+}
+
 //
 // a portion of this function, particularly the VFS interface portion,
 // was derived from minix or ext2's analog and evolved as the
@@ -514,13 +536,28 @@
   struct reiserfs_super_block * rs;
   struct reiserfs_transaction_handle th ;
   unsigned long blocks;
-  unsigned long mount_options;
+  unsigned long mount_options = 0;
 
   rs = SB_DISK_SUPER_BLOCK (s);
 
   if (!parse_options(data, &mount_options, &blocks))
   	return 0;
 
+#define SET_OPT( opt, bits, super )					\
+    if( ( bits ) & ( 1 << ( opt ) ) )					\
+	    ( super ) -> u.reiserfs_sb.s_mount_opt |= ( 1 << ( opt ) )
+
+  /* set options in the super-block bitmask */
+  SET_OPT( NOTAIL, mount_options, s );
+  SET_OPT( REISERFS_NO_BORDER, mount_options, s );
+  SET_OPT( REISERFS_NO_UNHASHED_RELOCATION, mount_options, s );
+  SET_OPT( REISERFS_HASHED_RELOCATION, mount_options, s );
+  SET_OPT( REISERFS_TEST4, mount_options, s );
+  SET_OPT( REISERFS_ATTRS, mount_options, s );
+#undef SET_OPT
+
+  handle_attrs( s );
+
   if(blocks) {
       int rc = reiserfs_resize(s, blocks);
       if (rc != 0)
@@ -572,28 +609,30 @@
 
 static int read_bitmaps (struct super_block * s)
 {
-    int i, bmp, dl ;
-    struct reiserfs_super_block * rs = SB_DISK_SUPER_BLOCK(s);
+    int i, bmp;
 
-    SB_AP_BITMAP (s) = reiserfs_kmalloc (sizeof (struct buffer_head *) * sb_bmap_nr(rs), GFP_NOFS, s);
+    SB_AP_BITMAP (s) = reiserfs_kmalloc (sizeof (struct buffer_head *) * SB_BMAP_NR(s), GFP_NOFS, s);
     if (SB_AP_BITMAP (s) == 0)
+      return 1;
+    for (i = 0, bmp = REISERFS_DISK_OFFSET_IN_BYTES / s->s_blocksize + 1;
+ 	 i < SB_BMAP_NR(s); i++, bmp = s->s_blocksize * 8 * i) {
+      SB_AP_BITMAP (s)[i] = getblk (s->s_dev, bmp, s->s_blocksize);
+      if (!buffer_uptodate(SB_AP_BITMAP(s)[i]))
+	ll_rw_block(READ, 1, SB_AP_BITMAP(s) + i); 
+    }
+    for (i = 0; i < SB_BMAP_NR(s); i++) {
+      wait_on_buffer(SB_AP_BITMAP (s)[i]);
+      if (!buffer_uptodate(SB_AP_BITMAP(s)[i])) {
+	reiserfs_warning("sh-2029: reiserfs read_bitmaps: "
+			 "bitmap block (#%lu) reading failed\n",
+			 SB_AP_BITMAP(s)[i]->b_blocknr);
+	for (i = 0; i < SB_BMAP_NR(s); i++)
+	  brelse(SB_AP_BITMAP(s)[i]);
+	reiserfs_kfree(SB_AP_BITMAP(s), sizeof(struct buffer_head *) * SB_BMAP_NR(s), s);
+	SB_AP_BITMAP(s) = NULL;
 	return 1;
-    memset (SB_AP_BITMAP (s), 0, sizeof (struct buffer_head *) * sb_bmap_nr(rs));
-
-    /* reiserfs leaves the first 64k unused so that any partition
-       labeling scheme currently used will have enough space. Then we
-       need one block for the super.  -Hans */
-    bmp = (REISERFS_DISK_OFFSET_IN_BYTES / s->s_blocksize) + 1;	/* first of bitmap blocks */
-    SB_AP_BITMAP (s)[0] = reiserfs_bread (s, bmp, s->s_blocksize);
-    if(!SB_AP_BITMAP(s)[0])
-	return 1;
-    for (i = 1, bmp = dl = s->s_blocksize * 8; i < sb_bmap_nr(rs); i ++) {
-	SB_AP_BITMAP (s)[i] = reiserfs_bread (s, bmp, s->s_blocksize);
-	if (!SB_AP_BITMAP (s)[i])
-	    return 1;
-	bmp += dl;
-    }
-
+      }
+    }   
     return 0;
 }
 
@@ -704,8 +743,18 @@
 	       "It must not be of this format type.\n", bh->b_blocknr) ;
 	return 1 ;
     }
+
+    if ( rs->s_root_block == -1 ) {
+	brelse(bh) ;
+	printk("dev %s: Unfinished reiserfsck --rebuild-tree run detected. Please run\n"
+	       "reiserfsck --rebuild-tree and wait for a completion. If that fails\n"
+	       "get newer reiserfsprogs package\n", kdevname (s->s_dev));
+	return 1;
+    }
+
     SB_BUFFER_WITH_SB (s) = bh;
     SB_DISK_SUPER_BLOCK (s) = rs;
+
     s->s_op = &reiserfs_sops;
 
     /* new format is limited by the 32 bit wide i_blocks field, want to
@@ -760,7 +809,9 @@
 
     inode = s->s_root->d_inode;
 
-    while (1) {
+    do { // Some serious "goto"-hater was there ;)
+	u32 teahash, r5hash, yurahash;
+
 	make_cpu_key (&key, inode, ~0, TYPE_DIRENTRY, 3);
 	retval = search_by_entry_key (s, &key, &path, &de);
 	if (retval == IO_ERROR) {
@@ -779,20 +830,30 @@
 	                     "is using the default hash\n");
 	    break;
 	}
-	if (GET_HASH_VALUE(yura_hash (de.de_name, de.de_namelen)) == 
-	    GET_HASH_VALUE(keyed_hash (de.de_name, de.de_namelen))) {
-	    reiserfs_warning ("reiserfs: Could not detect hash function "
-			      "please mount with -o hash={tea,rupasov,r5}\n") ;
-	    hash = UNSET_HASH ;
+	r5hash=GET_HASH_VALUE (r5_hash (de.de_name, de.de_namelen));
+	teahash=GET_HASH_VALUE (keyed_hash (de.de_name, de.de_namelen));
+	yurahash=GET_HASH_VALUE (yura_hash (de.de_name, de.de_namelen));
+	if ( ( (teahash == r5hash) && (GET_HASH_VALUE( deh_offset(&(de.de_deh[de.de_entry_num]))) == r5hash) ) ||
+	     ( (teahash == yurahash) && (yurahash == GET_HASH_VALUE( deh_offset(&(de.de_deh[de.de_entry_num])))) ) ||
+	     ( (r5hash == yurahash) && (yurahash == GET_HASH_VALUE( deh_offset(&(de.de_deh[de.de_entry_num])))) ) ) {
+	    reiserfs_warning("reiserfs: Unable to automatically detect hash"
+		"function for device %s\n"
+		"please mount with -o hash={tea,rupasov,r5}\n", kdevname (s->s_dev));
+	    hash = UNSET_HASH;
 	    break;
 	}
-	if (GET_HASH_VALUE( deh_offset(&(de.de_deh[de.de_entry_num])) ) ==
-	    GET_HASH_VALUE (yura_hash (de.de_name, de.de_namelen)))
+	if (GET_HASH_VALUE( deh_offset(&(de.de_deh[de.de_entry_num])) ) == yurahash)
 	    hash = YURA_HASH;
-	else
+	else if (GET_HASH_VALUE( deh_offset(&(de.de_deh[de.de_entry_num])) ) == teahash)
 	    hash = TEA_HASH;
-	break;
-    }
+	else if (GET_HASH_VALUE( deh_offset(&(de.de_deh[de.de_entry_num])) ) == r5hash)
+	    hash = R5_HASH;
+	else {
+	    reiserfs_warning("reiserfs: Unrecognised hash function for "
+			     "device %s\n", kdevname (s->s_dev));
+	    hash = UNSET_HASH;
+	}
+    } while (0);
 
     pathrelse (&path);
     return hash;
@@ -817,16 +878,16 @@
 	** mount options 
 	*/
 	if (reiserfs_rupasov_hash(s) && code != YURA_HASH) {
-	    printk("REISERFS: Error, tea hash detected, "
-		   "unable to force rupasov hash\n") ;
+	    printk("REISERFS: Error, %s hash detected, "
+		   "unable to force rupasov hash\n", reiserfs_hashname(code)) ;
 	    code = UNSET_HASH ;
 	} else if (reiserfs_tea_hash(s) && code != TEA_HASH) {
-	    printk("REISERFS: Error, rupasov hash detected, "
-		   "unable to force tea hash\n") ;
+	    printk("REISERFS: Error, %s hash detected, "
+		   "unable to force tea hash\n", reiserfs_hashname(code)) ;
 	    code = UNSET_HASH ;
 	} else if (reiserfs_r5_hash(s) && code != R5_HASH) {
-	    printk("REISERFS: Error, r5 hash detected, "
-		   "unable to force r5 hash\n") ;
+	    printk("REISERFS: Error, %s hash detected, "
+		   "unable to force r5 hash\n", reiserfs_hashname(code)) ;
 	    code = UNSET_HASH ;
 	} 
     } else { 
@@ -934,6 +995,8 @@
 	    old_format = 1;
     }
 
+    rs = SB_DISK_SUPER_BLOCK (s);
+
     s->u.reiserfs_sb.s_mount_state = SB_REISERFS_STATE(s);
     s->u.reiserfs_sb.s_mount_state = REISERFS_VALID_FS ;
 
@@ -1033,6 +1096,8 @@
     }
     // mark hash in super block: it could be unset. overwrite should be ok
     set_sb_hash_function_code( rs, function2code(s->u.reiserfs_sb.s_hash_function ) );
+
+    handle_attrs( s );
 
     reiserfs_proc_info_init( s );
     reiserfs_proc_register( s, "version", reiserfs_version_in_proc );
diff -uNr linux-2.4.18.original/fs/reiserfs/tail_conversion.c linux-2.4.18/fs/reiserfs/tail_conversion.c
--- linux-2.4.18.original/fs/reiserfs/tail_conversion.c	Tue Feb 26 15:52:56 2002
+++ linux-2.4.18/fs/reiserfs/tail_conversion.c	Fri Mar  1 18:09:21 2002
@@ -49,9 +49,13 @@
     make_cpu_key (&end_key, inode, tail_offset, TYPE_INDIRECT, 4);
 
     // FIXME: we could avoid this 
-    if ( search_for_position_by_key (sb, &end_key, path) == POSITION_FOUND )
-	reiserfs_panic (sb, "PAP-14030: direct2indirect: "
-			"pasted or inserted byte exists in the tree");
+    if ( search_for_position_by_key (sb, &end_key, path) == POSITION_FOUND ) {
+	reiserfs_warning ("PAP-14030: direct2indirect: "
+			"pasted or inserted byte exists in the tree %K. "
+			"Use fsck to repair.\n", &end_key);
+	pathrelse(path);
+	return -EIO;
+    }
     
     p_le_ih = PATH_PITEM_HEAD (path);
 
@@ -90,10 +94,10 @@
            last item of the file */
 	if ( search_for_position_by_key (sb, &end_key, path) == POSITION_FOUND )
 	    reiserfs_panic (sb, "PAP-14050: direct2indirect: "
-			    "direct item (%k) not found", &end_key);
+			    "direct item (%K) not found", &end_key);
 	p_le_ih = PATH_PITEM_HEAD (path);
 	RFALSE( !is_direct_le_ih (p_le_ih),
-	        "vs-14055: direct item expected(%k), found %h",
+	        "vs-14055: direct item expected(%K), found %h",
                 &end_key, p_le_ih);
         tail_size = (le_ih_k_offset (p_le_ih) & (n_blk_size - 1))
             + ih_item_len(p_le_ih) - 1;
@@ -227,7 +231,7 @@
 	/* re-search indirect item */
 	if ( search_for_position_by_key (p_s_sb, p_s_item_key, p_s_path) == POSITION_NOT_FOUND )
 	    reiserfs_panic(p_s_sb, "PAP-5520: indirect2direct: "
-			   "item to be converted %k does not exist", p_s_item_key);
+			   "item to be converted %K does not exist", p_s_item_key);
 	copy_item_head(&s_ih, PATH_PITEM_HEAD(p_s_path));
 #ifdef CONFIG_REISERFS_CHECK
 	pos = le_ih_k_offset (&s_ih) - 1 + 
diff -uNr linux-2.4.18.original/include/linux/reiserfs_fs.h linux-2.4.18/include/linux/reiserfs_fs.h
--- linux-2.4.18.original/include/linux/reiserfs_fs.h	Tue Feb 26 15:53:01 2002
+++ linux-2.4.18/include/linux/reiserfs_fs.h	Fri Mar  1 18:09:21 2002
@@ -204,7 +204,15 @@
 #define REISERFS_VALID_FS    1
 #define REISERFS_ERROR_FS    2
 
-
+//
+// there are 5 item types currently
+//
+#define TYPE_STAT_DATA 0
+#define TYPE_INDIRECT 1
+#define TYPE_DIRECT 2
+#define TYPE_DIRENTRY 3 
+#define TYPE_MAXTYPE 3 
+#define TYPE_ANY 15 // FIXME: comment is required
 
 /***************************************************************************/
 /*                       KEY & ITEM HEAD                                   */
@@ -240,7 +248,7 @@
 {
     offset_v2_esafe_overlay tmp = *(const offset_v2_esafe_overlay *)v2;
     tmp.linear = le64_to_cpu( tmp.linear );
-    return tmp.offset_v2.k_type;
+    return (tmp.offset_v2.k_type <= TYPE_MAXTYPE)?tmp.offset_v2.k_type:TYPE_ANY;
 }
  
 static inline void set_offset_v2_k_type( struct offset_v2 *v2, int type )
@@ -390,15 +398,6 @@
 #define put_block_num(p, i, v) put_unaligned(cpu_to_le32(v), (p) + (i))
 
 //
-// there are 5 item types currently
-//
-#define TYPE_STAT_DATA 0
-#define TYPE_INDIRECT 1
-#define TYPE_DIRECT 2
-#define TYPE_DIRENTRY 3 
-#define TYPE_ANY 15 // FIXME: comment is required
-
-//
 // in old version uniqueness field shows key type
 //
 #define V1_SD_UNIQUENESS 0
@@ -718,11 +717,41 @@
 #define set_sd_v1_first_direct_byte(sdp,v) \
                                 ((sdp)->sd_first_direct_byte = cpu_to_le32(v))
 
+#include <linux/ext2_fs.h>
+
+/* inode flags stored in sd_attrs (nee sd_reserved) */
+
+/* we want common flags to have the same values as in ext2,
+   so chattr(1) will work without problems */
+#define REISERFS_IMMUTABLE_FL EXT2_IMMUTABLE_FL
+#define REISERFS_SYNC_FL      EXT2_SYNC_FL
+#define REISERFS_NOATIME_FL   EXT2_NOATIME_FL
+#define REISERFS_NODUMP_FL    EXT2_NODUMP_FL
+#define REISERFS_SECRM_FL     EXT2_SECRM_FL
+#define REISERFS_UNRM_FL      EXT2_UNRM_FL
+#define REISERFS_COMPR_FL     EXT2_COMPR_FL
+/* persistent flag to disable tails on per-file basic.
+   Note, that is inheritable: mark directory with this and
+   all new files inside will not have tails. 
+
+   Teodore Tso allocated EXT2_NODUMP_FL (0x00008000) for this. Change
+   numeric constant to ext2 macro when available. */
+#define REISERFS_NOTAIL_FL    (0x00008000) /* EXT2_NOTAIL_FL */
+
+/* persistent flags that file inherits from the parent directory */
+#define REISERFS_INHERIT_MASK ( REISERFS_IMMUTABLE_FL |	\
+				REISERFS_SYNC_FL |	\
+				REISERFS_NOATIME_FL |	\
+				REISERFS_NODUMP_FL |	\
+				REISERFS_SECRM_FL |	\
+				REISERFS_COMPR_FL |	\
+				REISERFS_NOTAIL_FL )
+
 /* Stat Data on disk (reiserfs version of UFS disk inode minus the
    address blocks) */
 struct stat_data {
     __u16 sd_mode;	/* file type, permissions */
-    __u16 sd_reserved;
+    __u16 sd_attrs;     /* persistent inode flags */
     __u32 sd_nlink;	/* number of hard links */
     __u64 sd_size;	/* file size */
     __u32 sd_uid;		/* owner */
@@ -775,6 +804,8 @@
 #define set_sd_v2_rdev(sdp,v)   ((sdp)->u.sd_rdev = cpu_to_le32(v))
 #define sd_v2_generation(sdp)   (le32_to_cpu((sdp)->u.sd_generation))
 #define set_sd_v2_generation(sdp,v) ((sdp)->u.sd_generation = cpu_to_le32(v))
+#define sd_v2_attrs(sdp)         (le16_to_cpu((sdp)->sd_attrs))
+#define set_sd_v2_attrs(sdp,v)   ((sdp)->sd_attrs = cpu_to_le16(v))
 
 
 /***************************************************************************/
@@ -1365,7 +1396,7 @@
 
 extern struct item_operations stat_data_ops, indirect_ops, direct_ops, 
   direntry_ops;
-extern struct item_operations * item_ops [4];
+extern struct item_operations * item_ops [TYPE_ANY + 1];
 
 #define op_bytes_number(ih,bsize)                    item_ops[le_ih_k_type (ih)]->bytes_number (ih, bsize)
 #define op_is_left_mergeable(key,bsize)              item_ops[le_key_k_type (le_key_version (key), key)]->is_left_mergeable (key, bsize)
@@ -1701,6 +1732,9 @@
 int reiserfs_sync_inode (struct reiserfs_transaction_handle *th, struct inode * inode);
 void reiserfs_update_sd (struct reiserfs_transaction_handle *th, struct inode * inode);
 
+void sd_attrs_to_i_attrs( __u16 sd_attrs, struct inode *inode );
+void i_attrs_to_sd_attrs( struct inode *inode, __u16 *sd_attrs );
+
 /* namei.c */
 inline void set_de_name_and_namelen (struct reiserfs_dir_entry * de);
 int search_by_entry_key (struct super_block * sb, const struct cpu_key * key, 
@@ -1792,8 +1826,14 @@
 				     int n_size);
 
 /* fix_nodes.c */
+#ifdef CONFIG_REISERFS_CHECK
 void * reiserfs_kmalloc (size_t size, int flags, struct super_block * s);
 void reiserfs_kfree (const void * vp, size_t size, struct super_block * s);
+#else
+#define reiserfs_kmalloc(x, y, z) kmalloc(x, y)
+#define reiserfs_kfree(x, y, z) kfree(x)
+#endif
+
 int fix_nodes (int n_op_mode, struct tree_balance * p_s_tb, 
 	       struct item_head * p_s_ins_ih, const void *);
 void unfix_nodes (struct tree_balance *);
@@ -1824,6 +1864,7 @@
 void check_leaf (struct buffer_head * bh);
 void check_internal (struct buffer_head * bh);
 void print_statistics (struct super_block * s);
+char * reiserfs_hashname(int code);
 
 /* lbalance.c */
 int leaf_move_items (int shift_mode, struct tree_balance * tb, int mov_num, int mov_bytes, struct buffer_head * Snew);
@@ -1918,6 +1959,12 @@
  
 /* ioctl's command */
 #define REISERFS_IOC_UNPACK		_IOW(0xCD,1,long)
+/* define following flags to be the same as in ext2, so that chattr(1),
+   lsattr(1) will work with us. */
+#define REISERFS_IOC_GETFLAGS           EXT2_IOC_GETFLAGS
+#define REISERFS_IOC_SETFLAGS           EXT2_IOC_SETFLAGS
+#define REISERFS_IOC_GETVERSION 	EXT2_IOC_GETVERSION
+#define REISERFS_IOC_SETVERSION         EXT2_IOC_SETVERSION
  			         
 #endif /* _LINUX_REISER_FS_H */
 
diff -uNr linux-2.4.18.original/include/linux/reiserfs_fs_i.h linux-2.4.18/include/linux/reiserfs_fs_i.h
--- linux-2.4.18.original/include/linux/reiserfs_fs_i.h	Tue Feb 26 15:52:56 2002
+++ linux-2.4.18/include/linux/reiserfs_fs_i.h	Fri Mar  1 18:09:21 2002
@@ -33,6 +33,9 @@
 
     __u32 i_first_direct_byte; // offset of first byte stored in direct item.
 
+    /* copy of persistent inode flags read from sd_attrs. */
+    __u32 i_attrs;
+
     int i_prealloc_block; /* first unused block of a sequence of unused blocks */
     int i_prealloc_count; /* length of that sequence */
     struct list_head i_prealloc_list;	/* per-transaction list of inodes which
diff -uNr linux-2.4.18.original/include/linux/reiserfs_fs_sb.h linux-2.4.18/include/linux/reiserfs_fs_sb.h
--- linux-2.4.18.original/include/linux/reiserfs_fs_sb.h	Tue Feb 26 15:53:01 2002
+++ linux-2.4.18/include/linux/reiserfs_fs_sb.h	Fri Mar  1 18:09:21 2002
@@ -61,9 +61,19 @@
                                    superblock. -Hans */
   __u16 s_reserved;
   __u32 s_inode_generation;
-  char s_unused[124] ;			/* zero filled by mkreiserfs */
+  __u32 s_flags;		       /* Right now used only by inode-attributes, if enabled */
+  unsigned char s_uuid[16];            /* filesystem unique identifier */
+  unsigned char s_label[16];           /* filesystem volume label */
+  char s_unused[88] ;                  /* zero filled by mkreiserfs and
+                                        * reiserfs_convert_objectid_map_v1()
+                                        * so any additions must be updated
+                                        * there as well. */
 } __attribute__ ((__packed__));
 
+typedef enum {
+  reiserfs_attrs_cleared       = 0x00000001,
+} reiserfs_super_block_flags;
+
 #define SB_SIZE (sizeof(struct reiserfs_super_block))
 /* struct reiserfs_super_block accessors/mutators
  * since this is a disk structure, it will always be in 
@@ -330,6 +340,12 @@
   stat_cnt_t search_by_key_fs_changed;
   stat_cnt_t search_by_key_restarted;
 
+  stat_cnt_t insert_item_restarted;
+  stat_cnt_t paste_into_item_restarted;
+  stat_cnt_t cut_from_item_restarted;
+  stat_cnt_t delete_solid_item_restarted;
+  stat_cnt_t delete_item_restarted;
+
   stat_cnt_t leaked_oid;
   stat_cnt_t leaves_removable;
 
@@ -472,6 +488,8 @@
 #define REISERFS_TEST3 13
 #define REISERFS_TEST4 14 
 
+#define REISERFS_ATTRS (15)
+
 #define reiserfs_r5_hash(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << FORCE_R5_HASH))
 #define reiserfs_rupasov_hash(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << FORCE_RUPASOV_HASH))
 #define reiserfs_tea_hash(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << FORCE_TEA_HASH))
@@ -484,6 +502,7 @@
 #define dont_have_tails(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << NOTAIL))
 #define replay_only(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REPLAYONLY))
 #define reiserfs_dont_log(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_NOLOG))
+#define reiserfs_attrs(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_ATTRS))
 #define old_format_only(s) ((s)->u.reiserfs_sb.s_properties & (1 << REISERFS_3_5))
 #define convert_reiserfs(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_CONVERT))
 

--qDbXVdCdHGoSgWSk--
