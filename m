Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289196AbSAGNVl>; Mon, 7 Jan 2002 08:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289195AbSAGNVh>; Mon, 7 Jan 2002 08:21:37 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:31629 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S289186AbSAGNVX>;
	Mon, 7 Jan 2002 08:21:23 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: torvalds@transmeta.com, viro@math.psu.edu, phillips@bonn-fries.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
Message-Id: <20020107132121.241311F6A@gtf.org>
Date: Mon,  7 Jan 2002 07:21:21 -0600 (CST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's my idea for the solution.  Each patch in the series has been
tested individually and can be applied individually, as long as all
preceding patches are applied.  (ie. to apply and testing patch N,
patches 1 through N-1 must also be applied)  The light testing consisted
of unpacking, catting, and removing kernel trees, along with a fillmem
runs to ensure that slab caches are properly purged.  An fsck was forced
after each run of tests.

This is the first of seven steps in the Make Fs.h Happy program.
It borrows direction from Daniel and Linus as well as my own.

patch1 (this patch): use accessor function ext2_i to access inode->u.ext2_i
	The rest of the patches borrows ideas but no code.  This patch
	is the only exception: it borrows substantially Daniel's ext2_i
	patch.
patch2: use accessor function ext2_sb to access sb->u.ext2_sb
patch3: dynamically allocate sb->u.ext2_sbp
patch4: dynamically allocate inode->u.ext2_ip
patch5: move include/linux/ext2*.h to fs/ext2

	at this point we've reached the limits of how far the current
	VFS API will go.  inode and superblock fs-level private info
	is dynamically allocated.

patch6: add sb->s_op->{alloc,destroy}_inode to VFS API
patch7: implement ext2 use of s_op->{alloc,destroy}

	at this point we have what Linus described:

		struct ext2_inode_info {
			...ext2 stuff...
			struct inode inode;
		};

patch1 follows...


diff -Naur -X /g/g/lib/dontdiff linux-2.5.2-pre9/fs/ext2/dir.c linux-fs1/fs/ext2/dir.c
--- linux-2.5.2-pre9/fs/ext2/dir.c	Mon Sep 17 20:16:30 2001
+++ linux-fs1/fs/ext2/dir.c	Sun Jan  6 23:08:18 2002
@@ -300,6 +300,7 @@
 struct ext2_dir_entry_2 * ext2_find_entry (struct inode * dir,
 			struct dentry *dentry, struct page ** res_page)
 {
+	struct ext2_inode_info *ei = ext2_i(dir);
 	const char *name = dentry->d_name.name;
 	int namelen = dentry->d_name.len;
 	unsigned reclen = EXT2_DIR_REC_LEN(namelen);
@@ -311,7 +312,7 @@
 	/* OFFSET_CACHE */
 	*res_page = NULL;
 
-	start = dir->u.ext2_i.i_dir_start_lookup;
+	start = ei->i_dir_start_lookup;
 	if (start >= npages)
 		start = 0;
 	n = start;
@@ -336,7 +337,7 @@
 
 found:
 	*res_page = page;
-	dir->u.ext2_i.i_dir_start_lookup = n;
+	ei->i_dir_start_lookup = n;
 	return de;
 }
 
diff -Naur -X /g/g/lib/dontdiff linux-2.5.2-pre9/fs/ext2/ialloc.c linux-fs1/fs/ext2/ialloc.c
--- linux-2.5.2-pre9/fs/ext2/ialloc.c	Thu Jan  3 22:20:05 2002
+++ linux-fs1/fs/ext2/ialloc.c	Mon Jan  7 00:57:57 2002
@@ -313,6 +313,8 @@
 
 struct inode * ext2_new_inode (const struct inode * dir, int mode)
 {
+	const struct ext2_inode_info *di = &dir->u.ext2_i;
+	struct ext2_inode_info *ei;
 	struct super_block * sb;
 	struct buffer_head * bh;
 	struct buffer_head * bh2;
@@ -327,14 +329,15 @@
 	inode = new_inode(sb);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
+	ei = ext2_i(inode);
 
 	lock_super (sb);
 	es = sb->u.ext2_sb.s_es;
 repeat:
 	if (S_ISDIR(mode))
-		group = find_group_dir(sb, dir->u.ext2_i.i_block_group);
+		group = find_group_dir(sb, di->i_block_group);
 	else 
-		group = find_group_other(sb, dir->u.ext2_i.i_block_group);
+		group = find_group_other(sb, di->i_block_group);
 
 	err = -ENOSPC;
 	if (group == -1)
@@ -385,12 +388,12 @@
 	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blocks = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-	inode->u.ext2_i.i_new_inode = 1;
-	inode->u.ext2_i.i_flags = dir->u.ext2_i.i_flags;
+	ei->i_new_inode = 1;
+	ei->i_flags = di->i_flags;
 	if (S_ISLNK(mode))
-		inode->u.ext2_i.i_flags &= ~(EXT2_IMMUTABLE_FL|EXT2_APPEND_FL);
-	inode->u.ext2_i.i_block_group = group;
-	if (inode->u.ext2_i.i_flags & EXT2_SYNC_FL)
+		ei->i_flags &= ~(EXT2_IMMUTABLE_FL|EXT2_APPEND_FL);
+	ei->i_block_group = group;
+	if (ei->i_flags & EXT2_SYNC_FL)
 		inode->i_flags |= S_SYNC;
 	insert_inode_hash(inode);
 	inode->i_generation = sb->u.ext2_sb.s_next_generation++;
diff -Naur -X /g/g/lib/dontdiff linux-2.5.2-pre9/fs/ext2/inode.c linux-fs1/fs/ext2/inode.c
--- linux-2.5.2-pre9/fs/ext2/inode.c	Sat Jan  5 04:23:38 2002
+++ linux-fs1/fs/ext2/inode.c	Mon Jan  7 09:19:01 2002
@@ -57,7 +57,7 @@
 	    inode->i_ino == EXT2_ACL_IDX_INO ||
 	    inode->i_ino == EXT2_ACL_DATA_INO)
 		goto no_delete;
-	inode->u.ext2_i.i_dtime	= CURRENT_TIME;
+	ext2_i(inode)->i_dtime	= CURRENT_TIME;
 	mark_inode_dirty(inode);
 	ext2_update_inode(inode, IS_SYNC(inode));
 	inode->i_size = 0;
@@ -75,13 +75,14 @@
 void ext2_discard_prealloc (struct inode * inode)
 {
 #ifdef EXT2_PREALLOCATE
+	struct ext2_inode_info *ei = ext2_i(inode);
 	lock_kernel();
 	/* Writer: ->i_prealloc* */
-	if (inode->u.ext2_i.i_prealloc_count) {
-		unsigned short total = inode->u.ext2_i.i_prealloc_count;
-		unsigned long block = inode->u.ext2_i.i_prealloc_block;
-		inode->u.ext2_i.i_prealloc_count = 0;
-		inode->u.ext2_i.i_prealloc_block = 0;
+	if (ei->i_prealloc_count) {
+		unsigned short total = ei->i_prealloc_count;
+		unsigned long block = ei->i_prealloc_block;
+		ei->i_prealloc_count = 0;
+		ei->i_prealloc_block = 0;
 		/* Writer: end */
 		ext2_free_blocks (inode, block, total);
 	}
@@ -91,6 +92,7 @@
 
 static int ext2_alloc_block (struct inode * inode, unsigned long goal, int *err)
 {
+	struct ext2_inode_info *ei = ext2_i(inode);
 #ifdef EXT2FS_DEBUG
 	static unsigned long alloc_hits = 0, alloc_attempts = 0;
 #endif
@@ -99,12 +101,12 @@
 
 #ifdef EXT2_PREALLOCATE
 	/* Writer: ->i_prealloc* */
-	if (inode->u.ext2_i.i_prealloc_count &&
-	    (goal == inode->u.ext2_i.i_prealloc_block ||
-	     goal + 1 == inode->u.ext2_i.i_prealloc_block))
+	if (ei->i_prealloc_count &&
+	    (goal == ei->i_prealloc_block ||
+	     goal + 1 == ei->i_prealloc_block))
 	{		
-		result = inode->u.ext2_i.i_prealloc_block++;
-		inode->u.ext2_i.i_prealloc_count--;
+		result = ei->i_prealloc_block++;
+		ei->i_prealloc_count--;
 		/* Writer: end */
 		ext2_debug ("preallocation hit (%lu/%lu).\n",
 			    ++alloc_hits, ++alloc_attempts);
@@ -114,8 +116,8 @@
 			    alloc_hits, ++alloc_attempts);
 		if (S_ISREG(inode->i_mode))
 			result = ext2_new_block (inode, goal, 
-				 &inode->u.ext2_i.i_prealloc_count,
-				 &inode->u.ext2_i.i_prealloc_block, err);
+				 &ei->i_prealloc_count,
+				 &ei->i_prealloc_block, err);
 		else
 			result = ext2_new_block (inode, goal, 0, 0, err);
 	}
@@ -239,13 +241,14 @@
 				 Indirect chain[4],
 				 int *err)
 {
+	struct ext2_inode_info *ei = ext2_i(inode);
 	struct super_block *sb = inode->i_sb;
 	Indirect *p = chain;
 	struct buffer_head *bh;
 
 	*err = 0;
 	/* i_data is not going away, no lock needed */
-	add_chain (chain, NULL, inode->u.ext2_i.i_data + *offsets);
+	add_chain (chain, NULL, ei->i_data + *offsets);
 	if (!p->key)
 		goto no_block;
 	while (--depth) {
@@ -287,7 +290,8 @@
 
 static inline unsigned long ext2_find_near(struct inode *inode, Indirect *ind)
 {
-	u32 *start = ind->bh ? (u32*) ind->bh->b_data : inode->u.ext2_i.i_data;
+	struct ext2_inode_info *ei = ext2_i(inode);
+	u32 *start = ind->bh? (u32*) ind->bh->b_data: ei->i_data;
 	u32 *p;
 
 	/* Try to find previous block */
@@ -303,8 +307,7 @@
 	 * It is going to be refered from inode itself? OK, just put it into
 	 * the same cylinder group then.
 	 */
-	return (inode->u.ext2_i.i_block_group * 
-		EXT2_BLOCKS_PER_GROUP(inode->i_sb)) +
+	return (ei->i_block_group * EXT2_BLOCKS_PER_GROUP(inode->i_sb)) +
 	       le32_to_cpu(inode->i_sb->u.ext2_sb.s_es->s_first_data_block);
 }
 
@@ -327,10 +330,11 @@
 				 Indirect *partial,
 				 unsigned long *goal)
 {
+	struct ext2_inode_info *ei = ext2_i(inode);
 	/* Writer: ->i_next_alloc* */
-	if (block == inode->u.ext2_i.i_next_alloc_block + 1) {
-		inode->u.ext2_i.i_next_alloc_block++;
-		inode->u.ext2_i.i_next_alloc_goal++;
+	if (block == ei->i_next_alloc_block + 1) {
+		ei->i_next_alloc_block++;
+		ei->i_next_alloc_goal++;
 	} 
 	/* Writer: end */
 	/* Reader: pointers, ->i_next_alloc* */
@@ -339,8 +343,8 @@
 		 * try the heuristic for sequential allocation,
 		 * failing that at least try to get decent locality.
 		 */
-		if (block == inode->u.ext2_i.i_next_alloc_block)
-			*goal = inode->u.ext2_i.i_next_alloc_goal;
+		if (block == ei->i_next_alloc_block)
+			*goal = ei->i_next_alloc_goal;
 		if (!*goal)
 			*goal = ext2_find_near(inode, partial);
 		return 0;
@@ -407,7 +411,7 @@
 		mark_buffer_uptodate(bh, 1);
 		unlock_buffer(bh);
 		mark_buffer_dirty_inode(bh, inode);
-		if (IS_SYNC(inode) || inode->u.ext2_i.i_osync) {
+		if (IS_SYNC(inode) || ext2_i(inode)->i_osync) {
 			ll_rw_block (WRITE, 1, &bh);
 			wait_on_buffer (bh);
 		}
@@ -447,6 +451,7 @@
 				     Indirect *where,
 				     int num)
 {
+	struct ext2_inode_info *ei = ext2_i(inode);
 	int i;
 
 	/* Verify that place we are splicing to is still there and vacant */
@@ -459,8 +464,8 @@
 	/* That's it */
 
 	*where->p = where->key;
-	inode->u.ext2_i.i_next_alloc_block = block;
-	inode->u.ext2_i.i_next_alloc_goal = le32_to_cpu(where[num-1].key);
+	ei->i_next_alloc_block = block;
+	ei->i_next_alloc_goal = le32_to_cpu(where[num-1].key);
 
 	/* Writer: end */
 
@@ -471,13 +476,13 @@
 	/* had we spliced it onto indirect block? */
 	if (where->bh) {
 		mark_buffer_dirty_inode(where->bh, inode);
-		if (IS_SYNC(inode) || inode->u.ext2_i.i_osync) {
+		if (IS_SYNC(inode) || ei->i_osync) {
 			ll_rw_block (WRITE, 1, &where->bh);
 			wait_on_buffer(where->bh);
 		}
 	}
 
-	if (IS_SYNC(inode) || inode->u.ext2_i.i_osync)
+	if (IS_SYNC(inode) || ei->i_osync)
 		ext2_sync_inode (inode);
 	else
 		mark_inode_dirty(inode);
@@ -785,7 +790,8 @@
 
 void ext2_truncate (struct inode * inode)
 {
-	u32 *i_data = inode->u.ext2_i.i_data;
+	struct ext2_inode_info *ei = ext2_i(inode);
+	u32 *i_data = ei->i_data;
 	int addr_per_block = EXT2_ADDR_PER_BLOCK(inode->i_sb);
 	int offsets[4];
 	Indirect chain[4];
@@ -878,6 +884,7 @@
 
 void ext2_read_inode (struct inode * inode)
 {
+	struct ext2_inode_info *ei = ext2_i(inode);
 	struct buffer_head * bh;
 	struct ext2_inode * raw_inode;
 	unsigned long block_group;
@@ -939,13 +946,13 @@
 	inode->i_atime = le32_to_cpu(raw_inode->i_atime);
 	inode->i_ctime = le32_to_cpu(raw_inode->i_ctime);
 	inode->i_mtime = le32_to_cpu(raw_inode->i_mtime);
-	inode->u.ext2_i.i_dtime = le32_to_cpu(raw_inode->i_dtime);
+	ei->i_dtime = le32_to_cpu(raw_inode->i_dtime);
 	/* We now have enough fields to check if the inode was active or not.
 	 * This is needed because nfsd might try to access dead inodes
 	 * the test is that same one that e2fsck uses
 	 * NeilBrown 1999oct15
 	 */
-	if (inode->i_nlink == 0 && (inode->i_mode == 0 || inode->u.ext2_i.i_dtime)) {
+	if (inode->i_nlink == 0 && (inode->i_mode == 0 || ei->i_dtime)) {
 		/* this inode is deleted */
 		brelse (bh);
 		goto bad_inode;
@@ -953,25 +960,25 @@
 	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
 	inode->i_version = ++event;
-	inode->u.ext2_i.i_flags = le32_to_cpu(raw_inode->i_flags);
-	inode->u.ext2_i.i_faddr = le32_to_cpu(raw_inode->i_faddr);
-	inode->u.ext2_i.i_frag_no = raw_inode->i_frag;
-	inode->u.ext2_i.i_frag_size = raw_inode->i_fsize;
-	inode->u.ext2_i.i_file_acl = le32_to_cpu(raw_inode->i_file_acl);
+	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
+	ei->i_faddr = le32_to_cpu(raw_inode->i_faddr);
+	ei->i_frag_no = raw_inode->i_frag;
+	ei->i_frag_size = raw_inode->i_fsize;
+	ei->i_file_acl = le32_to_cpu(raw_inode->i_file_acl);
 	if (S_ISREG(inode->i_mode))
 		inode->i_size |= ((__u64)le32_to_cpu(raw_inode->i_size_high)) << 32;
 	else
-		inode->u.ext2_i.i_dir_acl = le32_to_cpu(raw_inode->i_dir_acl);
+		ei->i_dir_acl = le32_to_cpu(raw_inode->i_dir_acl);
 	inode->i_generation = le32_to_cpu(raw_inode->i_generation);
-	inode->u.ext2_i.i_prealloc_count = 0;
-	inode->u.ext2_i.i_block_group = block_group;
+	ei->i_prealloc_count = 0;
+	ei->i_block_group = block_group;
 
 	/*
 	 * NOTE! The in-memory inode i_data array is in little-endian order
 	 * even on big-endian machines: we do NOT byteswap the block numbers!
 	 */
 	for (block = 0; block < EXT2_N_BLOCKS; block++)
-		inode->u.ext2_i.i_data[block] = raw_inode->i_block[block];
+		ei->i_data[block] = raw_inode->i_block[block];
 
 	if (inode->i_ino == EXT2_ACL_IDX_INO ||
 	    inode->i_ino == EXT2_ACL_DATA_INO)
@@ -996,19 +1003,19 @@
 				   le32_to_cpu(raw_inode->i_block[0]));
 	brelse (bh);
 	inode->i_attr_flags = 0;
-	if (inode->u.ext2_i.i_flags & EXT2_SYNC_FL) {
+	if (ei->i_flags & EXT2_SYNC_FL) {
 		inode->i_attr_flags |= ATTR_FLAG_SYNCRONOUS;
 		inode->i_flags |= S_SYNC;
 	}
-	if (inode->u.ext2_i.i_flags & EXT2_APPEND_FL) {
+	if (ei->i_flags & EXT2_APPEND_FL) {
 		inode->i_attr_flags |= ATTR_FLAG_APPEND;
 		inode->i_flags |= S_APPEND;
 	}
-	if (inode->u.ext2_i.i_flags & EXT2_IMMUTABLE_FL) {
+	if (ei->i_flags & EXT2_IMMUTABLE_FL) {
 		inode->i_attr_flags |= ATTR_FLAG_IMMUTABLE;
 		inode->i_flags |= S_IMMUTABLE;
 	}
-	if (inode->u.ext2_i.i_flags & EXT2_NOATIME_FL) {
+	if (ei->i_flags & EXT2_NOATIME_FL) {
 		inode->i_attr_flags |= ATTR_FLAG_NOATIME;
 		inode->i_flags |= S_NOATIME;
 	}
@@ -1021,6 +1028,7 @@
 
 static int ext2_update_inode(struct inode * inode, int do_sync)
 {
+	struct ext2_inode_info *ei = ext2_i(inode);
 	struct buffer_head * bh;
 	struct ext2_inode * raw_inode;
 	unsigned long block_group;
@@ -1077,7 +1085,7 @@
  * Fix up interoperability with old kernels. Otherwise, old inodes get
  * re-used with the upper 16 bits of the uid/gid intact
  */
-		if(!inode->u.ext2_i.i_dtime) {
+		if(!ei->i_dtime) {
 			raw_inode->i_uid_high = cpu_to_le16(high_16_bits(inode->i_uid));
 			raw_inode->i_gid_high = cpu_to_le16(high_16_bits(inode->i_gid));
 		} else {
@@ -1096,14 +1104,14 @@
 	raw_inode->i_ctime = cpu_to_le32(inode->i_ctime);
 	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime);
 	raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
-	raw_inode->i_dtime = cpu_to_le32(inode->u.ext2_i.i_dtime);
-	raw_inode->i_flags = cpu_to_le32(inode->u.ext2_i.i_flags);
-	raw_inode->i_faddr = cpu_to_le32(inode->u.ext2_i.i_faddr);
-	raw_inode->i_frag = inode->u.ext2_i.i_frag_no;
-	raw_inode->i_fsize = inode->u.ext2_i.i_frag_size;
-	raw_inode->i_file_acl = cpu_to_le32(inode->u.ext2_i.i_file_acl);
+	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
+	raw_inode->i_flags = cpu_to_le32(ei->i_flags);
+	raw_inode->i_faddr = cpu_to_le32(ei->i_faddr);
+	raw_inode->i_frag = ei->i_frag_no;
+	raw_inode->i_fsize = ei->i_frag_size;
+	raw_inode->i_file_acl = cpu_to_le32(ei->i_file_acl);
 	if (S_ISDIR(inode->i_mode))
-		raw_inode->i_dir_acl = cpu_to_le32(inode->u.ext2_i.i_dir_acl);
+		raw_inode->i_dir_acl = cpu_to_le32(ei->i_dir_acl);
 	else {
 		raw_inode->i_size_high = cpu_to_le32(inode->i_size >> 32);
 		if (inode->i_size > 0x7fffffffULL) {
@@ -1129,7 +1137,7 @@
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
 		raw_inode->i_block[0] = cpu_to_le32(kdev_t_to_nr(inode->i_rdev));
 	else for (block = 0; block < EXT2_N_BLOCKS; block++)
-		raw_inode->i_block[block] = inode->u.ext2_i.i_data[block];
+		raw_inode->i_block[block] = ei->i_data[block];
 	mark_buffer_dirty(bh);
 	if (do_sync) {
 		ll_rw_block (WRITE, 1, &bh);
diff -Naur -X /g/g/lib/dontdiff linux-2.5.2-pre9/fs/ext2/ioctl.c linux-fs1/fs/ext2/ioctl.c
--- linux-2.5.2-pre9/fs/ext2/ioctl.c	Wed Sep 27 20:41:33 2000
+++ linux-fs1/fs/ext2/ioctl.c	Sun Jan  6 23:08:18 2002
@@ -16,13 +16,14 @@
 int ext2_ioctl (struct inode * inode, struct file * filp, unsigned int cmd,
 		unsigned long arg)
 {
+	struct ext2_inode_info *ei = ext2_i(inode);
 	unsigned int flags;
 
 	ext2_debug ("cmd = %u, arg = %lu\n", cmd, arg);
 
 	switch (cmd) {
 	case EXT2_IOC_GETFLAGS:
-		flags = inode->u.ext2_i.i_flags & EXT2_FL_USER_VISIBLE;
+		flags = ei->i_flags & EXT2_FL_USER_VISIBLE;
 		return put_user(flags, (int *) arg);
 	case EXT2_IOC_SETFLAGS: {
 		unsigned int oldflags;
@@ -36,7 +37,7 @@
 		if (get_user(flags, (int *) arg))
 			return -EFAULT;
 
-		oldflags = inode->u.ext2_i.i_flags;
+		oldflags = ei->i_flags;
 
 		/*
 		 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
@@ -51,7 +52,7 @@
 
 		flags = flags & EXT2_FL_USER_MODIFIABLE;
 		flags |= oldflags & ~EXT2_FL_USER_MODIFIABLE;
-		inode->u.ext2_i.i_flags = flags;
+		ei->i_flags = flags;
 
 		if (flags & EXT2_SYNC_FL)
 			inode->i_flags |= S_SYNC;
diff -Naur -X /g/g/lib/dontdiff linux-2.5.2-pre9/fs/ext2/namei.c linux-fs1/fs/ext2/namei.c
--- linux-2.5.2-pre9/fs/ext2/namei.c	Thu Oct  4 05:57:36 2001
+++ linux-fs1/fs/ext2/namei.c	Sun Jan  6 23:08:18 2002
@@ -134,7 +134,7 @@
 	if (IS_ERR(inode))
 		goto out;
 
-	if (l > sizeof (inode->u.ext2_i.i_data)) {
+	if (l > sizeof (ext2_i(inode)->i_data)) {
 		/* slow symlink */
 		inode->i_op = &page_symlink_inode_operations;
 		inode->i_mapping->a_ops = &ext2_aops;
@@ -144,7 +144,7 @@
 	} else {
 		/* fast symlink */
 		inode->i_op = &ext2_fast_symlink_inode_operations;
-		memcpy((char*)&inode->u.ext2_i.i_data,symname,l);
+		memcpy((char *) &ext2_i(inode)->i_data, symname, l);
 		inode->i_size = l-1;
 	}
 	mark_inode_dirty(inode);
diff -Naur -X /g/g/lib/dontdiff linux-2.5.2-pre9/fs/ext2/symlink.c linux-fs1/fs/ext2/symlink.c
--- linux-2.5.2-pre9/fs/ext2/symlink.c	Wed Sep 27 20:41:33 2000
+++ linux-fs1/fs/ext2/symlink.c	Mon Jan  7 00:58:15 2002
@@ -22,14 +22,14 @@
 
 static int ext2_readlink(struct dentry *dentry, char *buffer, int buflen)
 {
-	char *s = (char *)dentry->d_inode->u.ext2_i.i_data;
-	return vfs_readlink(dentry, buffer, buflen, s);
+	struct ext2_inode_info *ei = ext2_i(dentry->d_inode);
+	return vfs_readlink(dentry, buffer, buflen, (char *) &ei->i_data);
 }
 
 static int ext2_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
-	char *s = (char *)dentry->d_inode->u.ext2_i.i_data;
-	return vfs_follow_link(nd, s);
+	struct ext2_inode_info *ei = ext2_i(dentry->d_inode);
+	return vfs_follow_link(nd, (char *) &ei->i_data);
 }
 
 struct inode_operations ext2_fast_symlink_inode_operations = {
diff -Naur -X /g/g/lib/dontdiff linux-2.5.2-pre9/include/linux/ext2_fs.h linux-fs1/include/linux/ext2_fs.h
--- linux-2.5.2-pre9/include/linux/ext2_fs.h	Sun Dec 16 23:43:50 2001
+++ linux-fs1/include/linux/ext2_fs.h	Mon Jan  7 09:24:57 2002
@@ -580,6 +580,14 @@
 extern unsigned long ext2_count_free (struct buffer_head *, unsigned);
 
 /* inode.c */
+
+static inline struct ext2_inode_info *ext2_i(struct inode *inode)
+{
+	if (!inode)
+		BUG();
+	return &inode->u.ext2_i;
+}
+
 extern void ext2_read_inode (struct inode *);
 extern void ext2_write_inode (struct inode *, int);
 extern void ext2_put_inode (struct inode *);
