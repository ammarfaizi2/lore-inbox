Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261540AbSI1OI4>; Sat, 28 Sep 2002 10:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261566AbSI1OI4>; Sat, 28 Sep 2002 10:08:56 -0400
Received: from thunk.org ([140.239.227.29]:17827 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261540AbSI1OIu>;
	Sat, 28 Sep 2002 10:08:50 -0400
Date: Sat, 28 Sep 2002 10:13:30 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ryan Cumming <ryan@completely.kicks-ass.org>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Message-ID: <20020928141330.GA653@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Ryan Cumming <ryan@completely.kicks-ass.org>,
	Andreas Dilger <adilger@clusterfs.com>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <E17uINs-0003bG-00@think.thunk.org> <20020926235741.GC10551@think.thunk.org> <20020927041234.GS22795@clusterfs.com> <200209271820.41906.ryan@completely.kicks-ass.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <200209271820.41906.ryan@completely.kicks-ass.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 27, 2002 at 06:20:27PM -0700, Ryan Cumming wrote:
>
> This is while deleteing an old fsstress directory (a full fsck had been 
> performed since the last time the fsstress directory had been touched) while 
> running a few instances of the attached program.
> 
> You guys have any idea what's going on yet? 

Some ideas yes, although I don't have a complete solution yet.

I've been able to replicate it now fairly reliably, with the attached
shell script and 2.4.19 with the 2.4.19-2 dxdir patch.  It appears to
be somewhat timing dependent, as where the directory corruption occurs
is not consistent, but I believe it is in the split code.  Since
e2fsck -fD packs all of the directories completely, it means that any
attempt to add a file to directory will guarantee at least one split,
and possibly two levels of tree splits.  Since the -D option to e2fsck
has only been relatively recently been available, I believe this is
why it hasn't been noticed up until now in the testing; directories
which are indexed "naturally" as they grow don't appear to trigger the
problem, or are very, very unlikely to trigger the problem.  (One
potential avenue for exploration is that -D option perfectly sorts all
of the directory entries in hash order, which doesn't normally occur
for naturally grown directories, and this may be triggering a
fencepost error in the split code.)

The other thing which I've developed is a patch to e2fsprogs 1.29
(also attached) which fixes the directory corruption without causing
files to end up in lost+found.  I'm using the dxdir patch in
production, and I was first able to replicate your problem after I ran
e2fsck -fD on my /usr partition.  At that point, /usr/bin and
/usr/share/man/man8 got corrupted.  So I modified e2fsck to be able to
correct the problem without throwing a directory block's worth of
dirents into lost+found.

The nature of the corruption is that a directory entry of size 8
(which is enough room for a zero-length name) is left in the
directory.  This is harmless, but it should never happen normally, and
so the ext3 sanity-checking code flags it as an error.  With this
patch, e2fsck is much smarter about salvaging corrupt directories, and
so it can do so without causing any directory entries to be lost.
(This corrupted, too-small directory entry appears at the beginning of
the directory block, which is another reason why I strongly suspect
the dx_split code.)

BTW, Andreas, I've tried your stack-usage reduction patch (modified to
sanely deal with out of memory conditions instead of panicking), but
that doesn't seem to fix the problem.  So whatever it is, it's
something else, although your patch is still a good one and I've
commited it to the 2.4 ext3-dxdir BK tree.

							- Ted


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Description: gen-test-cdir
Content-Disposition: attachment; filename=gen-test-cdir

#!/bin/sh
#dd if=/dev/zero of=test.img bs=8k count=2000
mke2fs -j -F -b 1024 -N 24000 test.img 
mount -t ext3 -o loop test.img /mnt
pushd /mnt
mkdir test 
cd test
time seq -f "gabby-qf%f" 1 10000  | xargs touch
popd
umount /mnt
e2fsck -fD test.img
mount -t ext3 -o loop test.img /mnt
pushd /mnt/test
time seq -f "%f" 1 62  | xargs touch
popd
umount /mnt
e2fsck -f test.img


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Description: e2fsprogs-patch
Content-Disposition: attachment; filename=e2fsprogs-patch

# This is a BitKeeper generated patch for the following project:
# Project Name: Ext2 filesystem utilities
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1020  -> 1.1021 
#	      e2fsck/pass2.c	1.45    -> 1.46   
#	    e2fsck/ChangeLog	1.281   -> 1.282  
#	       e2fsck/unix.c	1.66    -> 1.67   
#	     e2fsck/rehash.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/28	tytso@think.thunk.org	1.1021
# Add a more sophisticated algorithm to e2fsck to salvage corrupted
# directories.
# 
# Speed up e2fsck slightly by only updating the master superblock;
# there is no point to update the backup superblocks.
# 
# Fix a small bug in the rehashing code which could leave the indexed
# flag set even after the directory was compressed instead of indexed.
# (Not fatal, since the kernel will deal with this, but technically
# it filesystem isn't consistent, and the filesystem will be marked
# as being in error when the kernel comes across the directory.  It
# should also never happen in real life, since directories that small
# will never be indexed, but better safe than sorry.)
# 
# Also change the threshold of when directories are indexed, so that
# directories of size 2 blocks will be indexed.  Otherwise they will
# never be indexed by the kernel when they grow.
# --------------------------------------------
#
diff -Nru a/e2fsck/ChangeLog b/e2fsck/ChangeLog
--- a/e2fsck/ChangeLog	Sat Sep 28 09:50:43 2002
+++ b/e2fsck/ChangeLog	Sat Sep 28 09:50:43 2002
@@ -1,3 +1,20 @@
+2002-09-28  Theodore Ts'o  <tytso@mit.edu>
+
+	* rehash.c (write_directory): Clear the index flag if by
+		reoptimizing the directory, we bring it back into a
+		non-indexed state.
+		(e2fsck_rehash_dir): Allow directories that contain two
+		blocks to be indexed.  Otherwise when they grow, they
+		never will be indexed by the kernel.
+
+	* unix.c (main): Only update the master superblock; there's no
+		point updating the backup superblocks, and it speeds up
+		fsck slightly.
+
+	* pass2.c (salvage_directory): New function called by
+		check_dir_block() which is much more sophisticated about
+		how it salvages corrupted filesystems.
+
 2001-09-24  Theodore Tso  <tytso@mit.edu>
 
 	* Release of E2fsprogs 1.29
diff -Nru a/e2fsck/pass2.c b/e2fsck/pass2.c
--- a/e2fsck/pass2.c	Sat Sep 28 09:50:43 2002
+++ b/e2fsck/pass2.c	Sat Sep 28 09:50:43 2002
@@ -574,6 +574,55 @@
 }
 #endif /* ENABLE_HTREE */
 
+/*
+ * Given a busted directory, try to salvage it somehow.
+ * 
+ */
+static int salvage_directory(ext2_filsys fs,
+			      struct ext2_dir_entry *dirent,
+			      struct ext2_dir_entry *prev,
+			      int offset)
+{
+	char	*cp = (char *) dirent;
+	int left = fs->blocksize - offset - dirent->rec_len;
+	int prev_offset = offset - ((char *) dirent - (char *) prev);
+
+	/*
+	 * Special case of directory entry of size 8: copy what's left
+	 * of the directory block up to cover up the invalid hole.
+	 */
+	if ((left >= 12) && (dirent->rec_len == 8)) {
+		memmove(cp, cp+8, left);
+		memset(cp + left, 0, 8);
+		return offset;
+	}
+	/*
+	 * If the directory entry is a multiple of four, so it is
+	 * valid, let the previous directory entry absorb the invalid
+	 * one. 
+	 */
+	if (prev && dirent->rec_len && (dirent->rec_len % 4) == 0) {
+		prev->rec_len += dirent->rec_len;
+		return prev_offset;
+	}
+	/*
+	 * Default salvage method --- kill all of the directory
+	 * entries for the rest of the block.  We will either try to
+	 * absorb it into the previous directory entry, or create a
+	 * new empty directory entry the rest of the directory block.
+	 */
+	if (prev) {
+		prev->rec_len += fs->blocksize - offset;
+		return prev_offset;
+	} else {
+		dirent->rec_len = fs->blocksize - offset;
+		dirent->name_len = 0;
+		dirent->inode = 0;
+		return offset;
+	}
+	
+}
+
 static int check_dir_block(ext2_filsys fs,
 			   struct ext2_db_entry *db,
 			   void *priv_data)
@@ -583,7 +632,7 @@
 #ifdef ENABLE_HTREE
 	struct dx_dirblock_info	*dx_db = 0;
 #endif /* ENABLE_HTREE */
-	struct ext2_dir_entry 	*dirent;
+	struct ext2_dir_entry 	*dirent, *prev;
 	ext2_dirhash_t		hash;
 	int			offset = 0;
 	int			dir_modified = 0;
@@ -680,8 +729,8 @@
 	}
 #endif /* ENABLE_HTREE */
 
+	prev = 0;
 	do {
-		dot_state++;
 		problem = 0;
 		dirent = (struct ext2_dir_entry *) (buf + offset);
 		cd->pctx.dirent = dirent;
@@ -691,10 +740,10 @@
 		    ((dirent->rec_len % 4) != 0) ||
 		    (((dirent->name_len & 0xFF)+8) > dirent->rec_len)) {
 			if (fix_problem(ctx, PR_2_DIR_CORRUPTED, &cd->pctx)) {
-				dirent->rec_len = fs->blocksize - offset;
-				dirent->name_len = 0;
-				dirent->inode = 0;
+				offset = salvage_directory(fs, dirent,
+							   prev, offset);
 				dir_modified++;
+				continue;
 			} else
 				return DIRENT_ABORT;
 		}
@@ -705,10 +754,10 @@
 			}
 		}
 
-		if (dot_state == 1) {
+		if (dot_state == 0) {
 			if (check_dot(ctx, dirent, ino, &cd->pctx))
 				dir_modified++;
-		} else if (dot_state == 2) {
+		} else if (dot_state == 1) {
 			dir = e2fsck_get_dir_info(ctx, ino);
 			if (!dir) {
 				fix_problem(ctx, PR_2_NO_DIRINFO, &cd->pctx);
@@ -749,7 +798,7 @@
 			 * clear it.
 			 */
 			problem = PR_2_BB_INODE;
-		} else if ((dot_state > 2) &&
+		} else if ((dot_state > 1) &&
 			   ((dirent->name_len & 0xFF) == 1) &&
 			   (dirent->name[0] == '.')) {
 			/*
@@ -758,7 +807,7 @@
 			 * duplicate entry that should be removed.
 			 */
 			problem = PR_2_DUP_DOT;
-		} else if ((dot_state > 2) &&
+		} else if ((dot_state > 1) &&
 			   ((dirent->name_len & 0xFF) == 2) &&
 			   (dirent->name[0] == '.') && 
 			   (dirent->name[1] == '.')) {
@@ -768,7 +817,7 @@
 			 * duplicate entry that should be removed.
 			 */
 			problem = PR_2_DUP_DOT_DOT;
-		} else if ((dot_state > 2) &&
+		} else if ((dot_state > 1) &&
 			   (dirent->inode == EXT2_ROOT_INO)) {
 			/*
 			 * Don't allow links to the root directory.
@@ -777,7 +826,7 @@
 			 * directory hasn't been created yet.
 			 */
 			problem = PR_2_LINK_ROOT;
-		} else if ((dot_state > 2) &&
+		} else if ((dot_state > 1) &&
 			   (dirent->name_len & 0xFF) == 0) {
 			/*
 			 * Don't allow zero-length directory names.
@@ -842,7 +891,7 @@
 		 * hard link.  We assume the first link is correct,
 		 * and ask the user if he/she wants to clear this one.
 		 */
-		if ((dot_state > 2) &&
+		if ((dot_state > 1) &&
 		    (ext2fs_test_inode_bitmap(ctx->inode_dir_map,
 					      dirent->inode))) {
 			subdir = e2fsck_get_dir_info(ctx, dirent->inode);
@@ -871,7 +920,9 @@
 			ctx->fs_links_count++;
 		ctx->fs_total_count++;
 	next:
+		prev = dirent;
 		offset += dirent->rec_len;
+		dot_state++;
 	} while (offset < fs->blocksize);
 #if 0
 	printf("\n");
diff -Nru a/e2fsck/rehash.c b/e2fsck/rehash.c
--- a/e2fsck/rehash.c	Sat Sep 28 09:50:43 2002
+++ b/e2fsck/rehash.c	Sat Sep 28 09:50:43 2002
@@ -522,7 +522,9 @@
 		return wd.err;
 
 	e2fsck_read_inode(ctx, ino, &inode, "rehash_dir");
-	if (!compress)
+	if (compress)
+		inode.i_flags &= ~EXT2_INDEX_FL;
+	else
 		inode.i_flags |= EXT2_INDEX_FL;
 	inode.i_size = outdir->num * fs->blocksize;
 	inode.i_blocks -= (fs->blocksize / 512) * wd.cleared;
@@ -561,7 +563,7 @@
 	fd.dir_size = 0;
 	fd.compress = 0;
 	if (!(fs->super->s_feature_compat & EXT2_FEATURE_COMPAT_DIR_INDEX) ||
-	    (inode.i_size / fs->blocksize) < 3)
+	    (inode.i_size / fs->blocksize) < 2)
 		fd.compress = 1;
 	fd.parent = 0;
 
diff -Nru a/e2fsck/unix.c b/e2fsck/unix.c
--- a/e2fsck/unix.c	Sat Sep 28 09:50:43 2002
+++ b/e2fsck/unix.c	Sat Sep 28 09:50:43 2002
@@ -974,8 +974,11 @@
 		ext2fs_mark_super_dirty(fs);
 
 	/*
-	 * Don't overwrite the backup superblock and block
-	 * descriptors, until we're sure the filesystem is OK....
+	 * We only update the master superblock because (a) paranoia;
+	 * we don't want to corrupt the backup superblocks, and (b) we
+	 * don't need to update the mount count and last checked
+	 * fields in the backup superblock (the kernel doesn't
+	 * update the backup superblocks anyway).
 	 */
 	fs->flags |= EXT2_FLAG_MASTER_SB_ONLY;
 
@@ -1058,9 +1061,7 @@
 			exit_value |= FSCK_REBOOT;
 		}
 	}
-	if (ext2fs_test_valid(fs))
-		fs->flags &= ~EXT2_FLAG_MASTER_SB_ONLY;
-	else {
+	if (!ext2fs_test_valid(fs)) {
 		printf(_("\n%s: ********** WARNING: Filesystem still has "
 			 "errors **********\n\n"), ctx->device_name);
 		exit_value |= FSCK_UNCORRECTED;

--ZGiS0Q5IWpPtfppv--
