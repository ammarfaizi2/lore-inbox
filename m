Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbTCEFhI>; Wed, 5 Mar 2003 00:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbTCEFhI>; Wed, 5 Mar 2003 00:37:08 -0500
Received: from [140.239.227.29] ([140.239.227.29]:26540 "EHLO
	thunker.thunk.org") by vger.kernel.org with ESMTP
	id <S262394AbTCEFhB>; Wed, 5 Mar 2003 00:37:01 -0500
To: ext2-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix ext3 htree / NFS compatibility problems
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E18qRkK-0005nP-00@think.thunk.org>
Date: Wed, 05 Mar 2003 00:47:16 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch should (in theory) fix the htree/NFS readdir
problems that people have reported.  Specifically, it should fix the NFS
looping on EOF problem with readdir, as well as the problems caused by
coverting a directory to HTREE while an NFS readdir is in progress
problem. 

I'd appreciate it if people who can easily replicate these NFS/htree
problems could give this patch (against BK-recent / 2.5.63) a whirl.
Thanks!!

						- Ted

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1059  -> 1.1060 
#	       fs/ext3/dir.c	1.8     -> 1.9    
#	     fs/ext3/namei.c	1.36    -> 1.37   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/05	tytso@thank.thunk.org	1.1060
# If the directory contains only one block and directory indexing is 
# enabled, then use ext3_dx_readdir() so that NFS doesn't get confused
# if the directory gets converted to htree format during the readdir run.
# 
# We use -1 (or ~0) in f_pos and in next_hash to represent EOF in the
# readdir stream.  This should fix the NFS readdir looping problem.
# --------------------------------------------
#
diff -Nru a/fs/ext3/dir.c b/fs/ext3/dir.c
--- a/fs/ext3/dir.c	Wed Mar  5 00:43:28 2003
+++ b/fs/ext3/dir.c	Wed Mar  5 00:43:28 2003
@@ -103,16 +103,23 @@
 
 	sb = inode->i_sb;
 
-	if (is_dx(inode)) {
+#ifdef CONFIG_EXT3_INDEX
+	if (EXT3_HAS_COMPAT_FEATURE(inode->i_sb,
+				    EXT3_FEATURE_COMPAT_DIR_INDEX) &&
+	    ((EXT3_I(inode)->i_flags & EXT3_INDEX_FL) ||
+	     ((inode->i_size >> sb->s_blocksize_bits) == 1))) {
 		err = ext3_dx_readdir(filp, dirent, filldir);
-		if (err != ERR_BAD_DX_DIR)
+		if (err != ERR_BAD_DX_DIR) {
+			unlock_kernel();
 			return err;
+		}
 		/*
 		 * We don't set the inode dirty flag since it's not
 		 * critical that it get flushed back to the disk.
 		 */
 		EXT3_I(filp->f_dentry->d_inode)->i_flags &= ~EXT3_INDEX_FL;
 	}
+#endif
 	stored = 0;
 	bh = NULL;
 	offset = filp->f_pos & (sb->s_blocksize - 1);
@@ -432,6 +439,9 @@
 		filp->private_data = info;
 	}
 
+	if (filp->f_pos == -1)
+		return 0;	/* EOF */
+
 	/* Some one has messed with f_pos; reset the world */
 	if (info->last_pos != filp->f_pos) {
 		free_rb_tree_fname(&info->root);
@@ -468,8 +478,10 @@
 						   &info->next_hash);
 			if (ret < 0)
 				return ret;
-			if (ret == 0)
+			if (ret == 0) {
+				filp->f_pos = -1;
 				break;
+			}
 			info->curr_node = rb_first(&info->root);
 		}
 
@@ -481,6 +493,10 @@
 
 		info->curr_node = rb_next(info->curr_node);
 		if (!info->curr_node) {
+			if (info->next_hash == ~0) {
+				filp->f_pos = -1;
+				break;
+			}
 			info->curr_hash = info->next_hash;
 			info->curr_minor_hash = 0;
 		}
diff -Nru a/fs/ext3/namei.c b/fs/ext3/namei.c
--- a/fs/ext3/namei.c	Wed Mar  5 00:43:28 2003
+++ b/fs/ext3/namei.c	Wed Mar  5 00:43:28 2003
@@ -170,7 +170,7 @@
 static void dx_insert_block (struct dx_frame *frame, u32 hash, u32 block);
 static int ext3_htree_next_block(struct inode *dir, __u32 hash,
 				 struct dx_frame *frame,
-				 struct dx_frame *frames, int *err,
+				 struct dx_frame *frames, 
 				 __u32 *start_hash);
 static struct buffer_head * ext3_dx_find_entry(struct dentry *dentry,
 		       struct ext3_dir_entry_2 **res_dir, int *err);
@@ -239,6 +239,17 @@
  * Debug
  */
 #ifdef DX_DEBUG
+static void dx_show_index (char * label, struct dx_entry *entries)
+{
+        int i, n = dx_get_count (entries);
+        printk("%s index ", label);
+        for (i = 0; i < n; i++)
+        {
+                printk("%x->%u ", i? dx_get_hash(entries + i): 0, dx_get_block(entries + i));
+        }
+        printk("\n");
+}
+
 struct stats
 { 
 	unsigned names;
@@ -447,22 +458,21 @@
  *
  * This function returns 1 if the caller should continue to search,
  * or 0 if it should not.  If there is an error reading one of the
- * index blocks, it will return -1.
+ * index blocks, it will a negative error code.
  *
  * If start_hash is non-null, it will be filled in with the starting
  * hash of the next page.
  */
 static int ext3_htree_next_block(struct inode *dir, __u32 hash,
 				 struct dx_frame *frame,
-				 struct dx_frame *frames, int *err,
+				 struct dx_frame *frames, 
 				 __u32 *start_hash)
 {
 	struct dx_frame *p;
 	struct buffer_head *bh;
-	int num_frames = 0;
+	int err, num_frames = 0;
 	__u32 bhash;
 
-	*err = ENOENT;
 	p = frame;
 	/*
 	 * Find the next leaf page by incrementing the frame pointer.
@@ -500,8 +510,8 @@
 	 */
 	while (num_frames--) {
 		if (!(bh = ext3_bread(NULL, dir, dx_get_block(p->at),
-				      0, err)))
-			return -1; /* Failure */
+				      0, &err)))
+			return err; /* Failure */
 		p++;
 		brelse (p->bh);
 		p->bh = bh;
@@ -521,6 +531,46 @@
 
 /*
  * This function fills a red-black tree with information from a
+ * directory block.  It returns the number directory entries loaded
+ * into the tree.  If there is an error it is returned in err.
+ */
+static int htree_dirblock_to_tree(struct file *dir_file,
+				  struct inode *dir, int block,
+				  struct dx_hash_info *hinfo,
+				  __u32 start_hash, __u32 start_minor_hash)
+{
+	struct buffer_head *bh;
+	struct ext3_dir_entry_2 *de, *top;
+	int err, count = 0;
+
+	dxtrace(printk("In htree dirblock_to_tree: block %d\n", block));
+	if (!(bh = ext3_bread (NULL, dir, block, 0, &err)))
+		return err;
+	
+	de = (struct ext3_dir_entry_2 *) bh->b_data;
+	top = (struct ext3_dir_entry_2 *) ((char *) de +
+					   dir->i_sb->s_blocksize -
+					   EXT3_DIR_REC_LEN(0));
+	for (; de < top; de = ext3_next_entry(de)) {
+		ext3fs_dirhash(de->name, de->name_len, hinfo);
+		if ((hinfo->hash < start_hash) ||
+		    ((hinfo->hash == start_hash) &&
+		     (hinfo->minor_hash < start_minor_hash)))
+			continue;
+		if ((err = ext3_htree_store_dirent(dir_file,
+				   hinfo->hash, hinfo->minor_hash, de)) != 0) {
+			brelse(bh);
+			return err;
+		}
+		count++;
+	}
+	brelse(bh);
+	return count;
+}
+
+
+/*
+ * This function fills a red-black tree with information from a
  * directory.  We start scanning the directory in hash order, starting
  * at start_hash and start_minor_hash.
  *
@@ -531,8 +581,7 @@
 			 __u32 start_minor_hash, __u32 *next_hash)
 {
 	struct dx_hash_info hinfo;
-	struct buffer_head *bh;
-	struct ext3_dir_entry_2 *de, *top;
+	struct ext3_dir_entry_2 *de;
 	struct dx_frame frames[2], *frame;
 	struct inode *dir;
 	int block, err;
@@ -543,6 +592,14 @@
 	dxtrace(printk("In htree_fill_tree, start hash: %x:%x\n", start_hash,
 		       start_minor_hash));
 	dir = dir_file->f_dentry->d_inode;
+	if (!(EXT3_I(dir)->i_flags & EXT3_INDEX_FL)) {	
+		hinfo.hash_version = EXT3_SB(dir->i_sb)->s_def_hash_version;
+		hinfo.seed = EXT3_SB(dir->i_sb)->s_hash_seed;
+		count = htree_dirblock_to_tree(dir_file, dir, 0, &hinfo,
+					       start_hash, start_minor_hash);
+		*next_hash = ~0;
+		return count;
+	}
 	hinfo.hash = start_hash;
 	hinfo.minor_hash = 0;
 	frame = dx_probe(0, dir_file->f_dentry->d_inode, &hinfo, frames, &err);
@@ -562,34 +619,21 @@
 
 	while (1) {
 		block = dx_get_block(frame->at);
-		dxtrace(printk("Reading block %d\n", block));
-		if (!(bh = ext3_bread (NULL, dir, block, 0, &err)))
+		ret = htree_dirblock_to_tree(dir_file, dir, block, &hinfo,
+					     start_hash, start_minor_hash);
+		if (ret < 0) {
+			err = ret;
 			goto errout;
-	
-		de = (struct ext3_dir_entry_2 *) bh->b_data;
-		top = (struct ext3_dir_entry_2 *) ((char *) de + dir->i_sb->s_blocksize -
-				       EXT3_DIR_REC_LEN(0));
-		for (; de < top; de = ext3_next_entry(de)) {
-			ext3fs_dirhash(de->name, de->name_len, &hinfo);
-			if ((hinfo.hash < start_hash) ||
-			    ((hinfo.hash == start_hash) &&
-			     (hinfo.minor_hash < start_minor_hash)))
-				continue;
-			if ((err = ext3_htree_store_dirent(dir_file,
-				   hinfo.hash, hinfo.minor_hash, de)) != 0) {
-				brelse(bh);
-				goto errout;
-			}
-			count++;
 		}
-		brelse (bh);
-		hashval = ~1;
+		count += ret;
+		hashval = ~0;
 		ret = ext3_htree_next_block(dir, HASH_NB_ALWAYS, 
-					    frame, frames, &err, &hashval);
-		if (next_hash)
-			*next_hash = hashval;
-		if (ret == -1)
+					    frame, frames, &hashval);
+		*next_hash = hashval;
+		if (ret < 0) {
+			err = ret;
 			goto errout;
+		}
 		/*
 		 * Stop if:  (a) there are no more entries, or
 		 * (b) we have inserted at least one entry and the
@@ -600,7 +644,8 @@
 			break;
 	}
 	dx_release(frames);
-	dxtrace(printk("Fill tree: returned %d entries\n", count));
+	dxtrace(printk("Fill tree: returned %d entries, next hash: %x\n", 
+		       count, *next_hash));
 	return count;
 errout:
 	dx_release(frames);
@@ -909,11 +954,12 @@
 		brelse (bh);
 		/* Check to see if we should continue to search */
 		retval = ext3_htree_next_block(dir, hash, frame,
-					       frames, err, 0);
-		if (retval == -1) {
+					       frames, 0);
+		if (retval < 0) {
 			ext3_warning(sb, __FUNCTION__,
 			     "error reading index page in directory #%lu",
 			     dir->i_ino);
+			*err = retval;
 			goto errout;
 		}
 	} while (retval == 1);
