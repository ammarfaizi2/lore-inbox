Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131718AbRBMOdB>; Tue, 13 Feb 2001 09:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131721AbRBMOcv>; Tue, 13 Feb 2001 09:32:51 -0500
Received: from colorfullife.com ([216.156.138.34]:14087 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131718AbRBMOcm>;
	Tue, 13 Feb 2001 09:32:42 -0500
Message-ID: <3A893BFC.309C7E0F@colorfullife.com>
Date: Tue, 13 Feb 2001 14:51:56 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cache directory position in dcache for ext2
Content-Type: multipart/mixed;
 boundary="------------207E0E5033FC46E96D45B5FF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------207E0E5033FC46E96D45B5FF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

ext2_find_entry is quite expensive for directories with lots of entries
- what about caching the block and offset in the dcache?

Each dentry contains 2 values reserved for the filesystem:
dentry->d_fsdata
dentry->d_time

ext2 doesn't use them - yet.

I've written a small patch that caches the directory block & offset into
these variables, and one test (lots of create, remove, rename in one
directory) is 20% faster than the unpatched 2.4.1 kernel.

No disk format change.

The patch is attached, it survives dbench, kernel compiles and other
stress tests.
But that doesn't mean that it won't eat your filesystem ;-)
--
	Manfred
--------------207E0E5033FC46E96D45B5FF
Content-Type: text/plain; charset=us-ascii;
 name="patch-ext2-cache"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ext2-cache"

diff -u 2.4/fs/ext2/namei.c build-2.4/fs/ext2/namei.c
--- 2.4/fs/ext2/namei.c	Sat Dec  9 02:35:54 2000
+++ build-2.4/fs/ext2/namei.c	Tue Feb 13 14:49:46 2001
@@ -58,7 +58,7 @@
  * entry - you'll have to do that yourself if you want to.
  */
 static struct buffer_head * ext2_find_entry (struct inode * dir,
-					     const char * const name, int namelen,
+					     struct dentry * dentry,
 					     struct ext2_dir_entry_2 ** res_dir)
 {
 	struct super_block * sb;
@@ -70,7 +70,49 @@
 	*res_dir = NULL;
 	sb = dir->i_sb;
 
-	if (namelen > EXT2_NAME_LEN)
+	if(dentry->d_fsdata != NULL) {
+		struct buffer_head * bh;
+		struct ext2_dir_entry_2 * de;
+		/*
+		 * cached data, use it.
+		 *
+		 */
+		block = (unsigned int)dentry->d_fsdata;
+		bh = getblk(sb->s_dev, block, sb->s_blocksize);
+		if (!bh) {
+			/* out of memory? */
+			return NULL;
+		}
+		if (!buffer_uptodate(bh)) {
+			ll_rw_block (READ, 1, &bh);
+		}
+		wait_on_buffer (bh);
+		if (!buffer_uptodate(bh)) {
+			/*
+			 * read error: all bets are off
+			 */
+			brelse(bh);
+			return NULL;
+		}
+		de = (struct ext2_dir_entry_2 *) (bh->b_data+dentry->d_time);
+		if(!ext2_match (dentry->d_name.len, dentry->d_name.name, de)) {
+			ext2_error (sb, "ext2_find_entry",
+					    "bad cached directory pos");
+			brelse(bh);
+			return NULL;
+		}
+		/* found a match -
+		   just to be sure, do a full check */
+		if (!ext2_check_dir_entry("ext2_find_entry",
+					  dir, de, bh, dentry->d_time)) {
+			brelse(bh);
+			return NULL;
+		}
+		*res_dir = de;
+		return bh;
+	}
+
+	if (dentry->d_name.len > EXT2_NAME_LEN)
 		return NULL;
 
 	memset (bh_use, 0, sizeof (bh_use));
@@ -120,8 +162,8 @@
 			/* do minimal checking `by hand' */
 			int de_len;
 
-			if ((char *) de + namelen <= dlimit &&
-			    ext2_match (namelen, name, de)) {
+			if ((char *) de + dentry->d_name.len <= dlimit &&
+			    ext2_match (dentry->d_name.len, dentry->d_name.name, de)) {
 				/* found a match -
 				   just to be sure, do a full check */
 				if (!ext2_check_dir_entry("ext2_find_entry",
@@ -131,6 +173,8 @@
 					if (bh_use[i] != bh)
 						brelse (bh_use[i]);
 				}
+				dentry->d_fsdata = (void*)bh->b_blocknr;
+				dentry->d_time = ((long)de)-((long)bh->b_data);
 				*res_dir = de;
 				return bh;
 			}
@@ -169,7 +213,7 @@
 	if (dentry->d_name.len > EXT2_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	bh = ext2_find_entry (dir, dentry->d_name.name, dentry->d_name.len, &de);
+	bh = ext2_find_entry (dir, dentry, &de);
 	inode = NULL;
 	if (bh) {
 		unsigned long ino = le32_to_cpu(de->inode);
@@ -206,7 +250,7 @@
  *
  * adds a file entry to the specified directory.
  */
-int ext2_add_entry (struct inode * dir, const char * name, int namelen,
+static int ext2_add_entry (struct inode * dir, struct dentry *dentry,
 		    struct inode *inode)
 {
 	unsigned long offset;
@@ -218,12 +262,12 @@
 
 	sb = dir->i_sb;
 
-	if (!namelen)
+	if (!dentry->d_name.len)
 		return -EINVAL;
 	bh = ext2_bread (dir, 0, 0, &retval);
 	if (!bh)
 		return retval;
-	rec_len = EXT2_DIR_REC_LEN(namelen);
+	rec_len = EXT2_DIR_REC_LEN(dentry->d_name.len);
 	offset = 0;
 	de = (struct ext2_dir_entry_2 *) bh->b_data;
 	while (1) {
@@ -258,9 +302,9 @@
 			brelse (bh);
 			return -ENOENT;
 		}
-		if (ext2_match (namelen, name, de)) {
-				brelse (bh);
-				return -EEXIST;
+		if (ext2_match (dentry->d_name.len, dentry->d_name.name, de)) {
+			brelse (bh);
+			return -EEXIST;
 		}
 		if ((le32_to_cpu(de->inode) == 0 && le16_to_cpu(de->rec_len) >= rec_len) ||
 		    (le16_to_cpu(de->rec_len) >= EXT2_DIR_REC_LEN(de->name_len) + rec_len)) {
@@ -279,8 +323,10 @@
 				ext2_set_de_type(dir->i_sb, de, inode->i_mode);
 			} else
 				de->inode = 0;
-			de->name_len = namelen;
-			memcpy (de->name, name, namelen);
+			de->name_len = dentry->d_name.len;
+			memcpy (de->name, dentry->d_name.name, de->name_len);
+			dentry->d_fsdata = (void*)bh->b_blocknr;
+			dentry->d_time = ((long)de)-((long)bh->b_data);
 			/*
 			 * XXX shouldn't update any times until successful
 			 * completion of syscall, but too many callers depend
@@ -371,8 +417,7 @@
 	inode->i_mapping->a_ops = &ext2_aops;
 	inode->i_mode = mode;
 	mark_inode_dirty(inode);
-	err = ext2_add_entry (dir, dentry->d_name.name, dentry->d_name.len, 
-			     inode);
+	err = ext2_add_entry (dir, dentry, inode);
 	if (err) {
 		inode->i_nlink--;
 		mark_inode_dirty(inode);
@@ -393,8 +438,7 @@
 
 	inode->i_uid = current->fsuid;
 	init_special_inode(inode, mode, rdev);
-	err = ext2_add_entry (dir, dentry->d_name.name, dentry->d_name.len, 
-			     inode);
+	err = ext2_add_entry (dir, dentry, inode);
 	if (err)
 		goto out_no_entry;
 	mark_inode_dirty(inode);
@@ -453,8 +497,7 @@
 	if (dir->i_mode & S_ISGID)
 		inode->i_mode |= S_ISGID;
 	mark_inode_dirty(inode);
-	err = ext2_add_entry (dir, dentry->d_name.name, dentry->d_name.len, 
-			     inode);
+	err = ext2_add_entry (dir, dentry, inode);
 	if (err)
 		goto out_no_entry;
 	dir->i_nlink++;
@@ -540,7 +583,7 @@
 	struct ext2_dir_entry_2 * de;
 
 	retval = -ENOENT;
-	bh = ext2_find_entry (dir, dentry->d_name.name, dentry->d_name.len, &de);
+	bh = ext2_find_entry (dir, dentry, &de);
 	if (!bh)
 		goto end_rmdir;
 
@@ -584,7 +627,7 @@
 	struct ext2_dir_entry_2 * de;
 
 	retval = -ENOENT;
-	bh = ext2_find_entry (dir, dentry->d_name.name, dentry->d_name.len, &de);
+	bh = ext2_find_entry (dir, dentry, &de);
 	if (!bh)
 		goto end_unlink;
 
@@ -604,6 +647,7 @@
 	retval = ext2_delete_entry(dir, de, bh);
 	if (retval)
 		goto end_unlink;
+	dentry->d_fsdata=NULL;	/* flush the cached lookup */
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	dir->u.ext2_i.i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(dir);
@@ -646,8 +690,7 @@
 	}
 	mark_inode_dirty(inode);
 
-	err = ext2_add_entry (dir, dentry->d_name.name, dentry->d_name.len, 
-			     inode);
+	err = ext2_add_entry (dir, dentry, inode);
 	if (err)
 		goto out_no_entry;
 	d_instantiate(dentry, inode);
@@ -672,8 +715,7 @@
 	if (inode->i_nlink >= EXT2_LINK_MAX)
 		return -EMLINK;
 	
-	err = ext2_add_entry (dir, dentry->d_name.name, dentry->d_name.len, 
-			     inode);
+	err = ext2_add_entry (dir, dentry, inode);
 	if (err)
 		return err;
 
@@ -703,7 +745,7 @@
 
 	old_bh = new_bh = dir_bh = NULL;
 
-	old_bh = ext2_find_entry (old_dir, old_dentry->d_name.name, old_dentry->d_name.len, &old_de);
+	old_bh = ext2_find_entry (old_dir, old_dentry, &old_de);
 	/*
 	 *  Check for inode number is _not_ due to possible IO errors.
 	 *  We might rmdir the source, keep it as pwd of some process
@@ -716,8 +758,7 @@
 		goto end_rename;
 
 	new_inode = new_dentry->d_inode;
-	new_bh = ext2_find_entry (new_dir, new_dentry->d_name.name,
-				new_dentry->d_name.len, &new_de);
+	new_bh = ext2_find_entry (new_dir, new_dentry, &new_de);
 	if (new_bh) {
 		if (!new_inode) {
 			brelse (new_bh);
@@ -744,8 +785,7 @@
 			goto end_rename;
 	}
 	if (!new_bh) {
-		retval = ext2_add_entry (new_dir, new_dentry->d_name.name,
-					 new_dentry->d_name.len,
+		retval = ext2_add_entry (new_dir, new_dentry,
 					 old_inode);
 		if (retval)
 			goto end_rename;
@@ -763,7 +803,7 @@
 		brelse(new_bh);
 		new_bh = NULL;
 	}
-	
+
 	/*
 	 * Like most other Unix systems, set the ctime for inodes on a
 	 * rename.
@@ -775,6 +815,13 @@
 	 * ok, that's it
 	 */
 	ext2_delete_entry(old_dir, old_de, old_bh);
+
+	/*
+	 * transfer the block position
+	 */
+	old_dentry->d_fsdata = new_dentry->d_fsdata;
+	old_dentry->d_time = new_dentry->d_time;
+	new_dentry->d_fsdata = NULL; /* flush the cached lookup */
 
 	if (new_inode) {
 		new_inode->i_nlink--;

--------------207E0E5033FC46E96D45B5FF--



