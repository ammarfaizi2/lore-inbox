Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317687AbSGKAC1>; Wed, 10 Jul 2002 20:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317688AbSGKAC0>; Wed, 10 Jul 2002 20:02:26 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:53993 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317687AbSGKACR>; Wed, 10 Jul 2002 20:02:17 -0400
Subject: [BK-PATCH-2.5] NTFS: 2.0.17 - Cleanups and optimizations - shrinking the ToDo list
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 11 Jul 2002 01:04:56 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17SRS4-00018d-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-tng-2.5

Thanks! - This is to make some progress on the NTFS ToDo list, halving it
in two in fact. (-:

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 Documentation/filesystems/ntfs.txt |    2 
 fs/ntfs/ChangeLog                  |   22 ++---
 fs/ntfs/Makefile                   |    6 +
 fs/ntfs/aops.c                     |   31 +++++--
 fs/ntfs/attrib.c                   |    2 
 fs/ntfs/inode.c                    |  155 ++++++++++++++++---------------------
 fs/ntfs/super.c                    |   20 ++--
 7 files changed, 125 insertions(+), 113 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/07/11 1.620)
   NTFS: 2.0.17 - Cleanups and optimizations - shrinking the ToDo list.
   - Modify fs/ntfs/inode.c::ntfs_read_locked_inode() to return an error
     code and update callers, i.e. ntfs_iget(), to pass that error code
     up instead of just using -EIO.
   - Modifications to super.c to ensure that both mount and remount
     cannot set any write related options when the driver is compiled
     read-only.
   - Optimize block resolution in fs/ntfs/aops.c::ntfs_read_block() to
     cache the current run list element. This should improve performance
     when reading very large and/or very fragmented data.


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Thu Jul 11 01:01:04 2002
+++ b/Documentation/filesystems/ntfs.txt	Thu Jul 11 01:01:04 2002
@@ -247,6 +247,8 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.0.17:
+	- Cleanups and optimizations.
 2.0.16:
 	- Fix stupid bug introduced in 2.0.15 in new attribute inode API.
 	- Big internal cleanup replacing the mftbmp access hacks by using the
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Thu Jul 11 01:01:04 2002
+++ b/fs/ntfs/ChangeLog	Thu Jul 11 01:01:04 2002
@@ -9,20 +9,22 @@
 	  read() will fail when s_maxbytes is reached? -> Investigate this.
 	- Implement/allow non-resident index bitmaps in dir.c::ntfs_readdir()
 	  and then also consider initialized_size w.r.t. the bitmaps, etc.
-	- vcn_to_lcn() should somehow return the correct pointer within the
-	  ->run_list so we can get at the lcns for the following vcns, this is
-	  strictly a speed optimization. Obviously need to keep the ->run_list
-	  locked or RACE. load_attribute_list() already performs such an
-	  optimization so use the same optimization where desired.
 	- Consider if ntfs_file_read_compressed_block() shouldn't be coping
 	  with initialized_size < data_size. I don't think it can happen but
 	  it requires more careful consideration.
-	- CLEANUP: Modularising code in aops.c a bit, e.g. a-la get_block(),
-	  will be cleaner and make code reuse easier.
-	- Modify ntfs_read_locked_inode() to return an error code and update
-	  callers, i.e. ntfs_iget(), to pass that error code up instead of just
-	  using -EIO.
 	- Enable NFS exporting of NTFS.
+
+2.0.17 - Cleanups and optimizations - shrinking the ToDo list.
+
+	- Modify fs/ntfs/inode.c::ntfs_read_locked_inode() to return an error
+	  code and update callers, i.e. ntfs_iget(), to pass that error code
+	  up instead of just using -EIO.
+	- Modifications to super.c to ensure that both mount and remount
+	  cannot set any write related options when the driver is compiled
+	  read-only.
+	- Optimize block resolution in fs/ntfs/aops.c::ntfs_read_block() to
+	  cache the current run list element. This should improve performance
+	  when reading very large and/or very fragmented data.
 
 2.0.16 - Convert access to $MFT/$BITMAP to attribute inode API.
 
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Thu Jul 11 01:01:04 2002
+++ b/fs/ntfs/Makefile	Thu Jul 11 01:01:04 2002
@@ -5,11 +5,15 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.16\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.17\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
 endif
+
+#ifeq ($(CONFIG_NTFS_RW),y)
+#EXTRA_CFLAGS += -DNTFS_RW
+#endif
 
 include $(TOPDIR)/Rules.make
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	Thu Jul 11 01:01:04 2002
+++ b/fs/ntfs/aops.c	Thu Jul 11 01:01:04 2002
@@ -162,6 +162,7 @@
 	LCN lcn;
 	ntfs_inode *ni;
 	ntfs_volume *vol;
+	run_list_element *rl;
 	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
 	sector_t iblock, lblock, zblock;
 	unsigned int blocksize, blocks, vcn_ofs;
@@ -192,6 +193,7 @@
 #endif
 
 	/* Loop through all the buffers in the page. */
+	rl = NULL;
 	nr = i = 0;
 	do {
 		if (unlikely(buffer_uptodate(bh)))
@@ -210,11 +212,18 @@
 					vol->cluster_size_bits;
 			vcn_ofs = ((VCN)iblock << blocksize_bits) &
 					vol->cluster_size_mask;
-retry_remap:
-			/* Convert the vcn to the corresponding lcn. */
-			down_read(&ni->run_list.lock);
-			lcn = vcn_to_lcn(ni->run_list.rl, vcn);
-			up_read(&ni->run_list.lock);
+			if (!rl) {
+lock_retry_remap:
+				down_read(&ni->run_list.lock);
+				rl = ni->run_list.rl;
+			}
+			if (likely(rl != NULL)) {
+				/* Seek to element containing target vcn. */
+				while (rl->length && rl[1].vcn <= vcn)
+					rl++;
+				lcn = vcn_to_lcn(rl, vcn);
+			} else
+				lcn = (LCN)LCN_RL_NOT_MAPPED;
 			/* Successful remap. */
 			if (lcn >= 0) {
 				/* Setup buffer head to correct block. */
@@ -235,8 +244,14 @@
 			/* If first try and run list unmapped, map and retry. */
 			if (!is_retry && lcn == LCN_RL_NOT_MAPPED) {
 				is_retry = TRUE;
+				/*
+				 * Attempt to map run list, dropping lock for
+				 * the duration.
+				 */
+				up_read(&ni->run_list.lock);
 				if (!map_run_list(ni, vcn))
-					goto retry_remap;
+					goto lock_retry_remap;
+				rl = NULL;
 			}
 			/* Hard error, zero out region. */
 			SetPageError(page);
@@ -260,6 +275,10 @@
 		kunmap(page);
 		set_buffer_uptodate(bh);
 	} while (i++, iblock++, (bh = bh->b_this_page) != head);
+
+	/* Release the lock if we took it. */
+	if (rl)
+		up_read(&ni->run_list.lock);
 
 	/* Check we have at least one buffer ready for i/o. */
 	if (nr) {
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	Thu Jul 11 01:01:04 2002
+++ b/fs/ntfs/attrib.c	Thu Jul 11 01:01:04 2002
@@ -964,7 +964,7 @@
 	}
 
 	down_write(&ni->run_list.lock);
-	/* Make sure someone else didn't do the work while we were spinning. */
+	/* Make sure someone else didn't do the work while we were sleeping. */
 	if (likely(vcn_to_lcn(ni->run_list.rl, vcn) <= LCN_RL_NOT_MAPPED)) {
 		run_list_element *rl;
 
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	Thu Jul 11 01:01:04 2002
+++ b/fs/ntfs/inode.c	Thu Jul 11 01:01:04 2002
@@ -149,7 +149,7 @@
 
 typedef int (*test_t)(struct inode *, void *);
 typedef int (*set_t)(struct inode *, void *);
-static void ntfs_read_locked_inode(struct inode *vi);
+static int ntfs_read_locked_inode(struct inode *vi);
 static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi);
 
 /**
@@ -172,6 +172,7 @@
 {
 	struct inode *vi;
 	ntfs_attr na;
+	int err;
 
 	na.mft_no = mft_no;
 	na.type = AT_UNUSED;
@@ -183,25 +184,21 @@
 	if (!vi)
 		return ERR_PTR(-ENOMEM);
 
+	err = 0;
+
 	/* If this is a freshly allocated inode, need to read it now. */
 	if (vi->i_state & I_NEW) {
-		ntfs_read_locked_inode(vi);
+		err = ntfs_read_locked_inode(vi);
 		unlock_new_inode(vi);
 	}
-#if 0
-	// TODO: Enable this and do the follow up cleanup, i.e. remove all the
-	// bad inode checks. -- BUT: Do we actually want to do this? -- It may
-	// result in repeated attemps to read a bad inode which is not
-	// desirable. (AIA)
 	/*
-	 * There is no point in keeping bad inodes around. This also simplifies
-	 * things in that we never need to check for bad inodes elsewhere.
+	 * There is no point in keeping bad inodes around if the failure was
+	 * due to ENOMEM. We want to be able to retry again layer.
 	 */
-	if (is_bad_inode(vi)) {
+	if (err == -ENOMEM) {
 		iput(vi);
-		vi = ERR_PTR(-EIO);
+		vi = ERR_PTR(err);
 	}
-#endif
 	return vi;
 }
 
@@ -256,7 +253,7 @@
 	 */
 	if (err) {
 		iput(vi);
-		vi = ERR_PTR(-EIO);
+		vi = ERR_PTR(err);
 	}
 	return vi;
 }
@@ -471,15 +468,18 @@
  *    is allowed to write to them. We should of course be honouring them but
  *    we need to do that using the IS_* macros defined in include/linux/fs.h.
  *    In any case ntfs_read_locked_inode() has nothing to do with i_flags.
+ *
+ * Return 0 on success and -errno on error. In the error case, the inode will
+ * have had make_bad_inode() executed on it.
  */
-static void ntfs_read_locked_inode(struct inode *vi)
+static int ntfs_read_locked_inode(struct inode *vi)
 {
 	ntfs_volume *vol = NTFS_SB(vi->i_sb);
 	ntfs_inode *ni;
 	MFT_RECORD *m;
 	STANDARD_INFORMATION *si;
 	attr_search_context *ctx;
-	int err;
+	int err = 0;
 
 	ntfs_debug("Entering for i_ino 0x%lx.", vi->i_ino);
 
@@ -492,46 +492,42 @@
 	 * that the file can be updated if necessary (compare with f_version).
 	 */
 	vi->i_version = ++event;
-	/* Set uid and gid from the mount options. */
+
 	vi->i_uid = vol->uid;
 	vi->i_gid = vol->gid;
-	/* Set to zero so we can use logical operations on it from here on. */
 	vi->i_mode = 0;
 
 	/*
 	 * Initialize the ntfs specific part of @vi special casing
-	 * FILE_MFT which we need to do at mount time. This also sets
-	 * ni->mft_no to vi->i_ino.
+	 * FILE_MFT which we need to do at mount time.
 	 */
 	if (vi->i_ino != FILE_MFT)
 		ntfs_init_big_inode(vi);
-
 	ni = NTFS_I(vi);
 
-	/* Map, pin and lock the mft record for reading. */
 	m = map_mft_record(READ, ni);
 	if (IS_ERR(m)) {
 		err = PTR_ERR(m);
 		goto err_out;
 	}
+	ctx = get_attr_search_ctx(ni, m);
+	if (!ctx) {
+		err = -ENOMEM;
+		goto unm_err_out;
+	}
 
-	/* Is the record in use? */
 	if (!(m->flags & MFT_RECORD_IN_USE)) {
 		ntfs_error(vi->i_sb, "Inode is not in use! You should "
 				"run chkdsk.");
 		goto unm_err_out;
 	}
-
-	/* Is this an extent mft record / inode? Treat same as if not in use. */
 	if (m->base_mft_record) {
-		ntfs_error(vi->i_sb, "Inode is an extent inode! iget() "
-				"not possible. You should run chkdsk.");
+		ntfs_error(vi->i_sb, "Inode is an extent inode! You should "
+				"run chkdsk.");
 		goto unm_err_out;
 	}
 
 	/* Transfer information from mft record into vfs and ntfs inodes. */
-
-	/* Cache the sequence number in the ntfs inode. */
 	ni->seq_no = le16_to_cpu(m->sequence_number);
 
 	/*
@@ -553,21 +549,12 @@
 	 */
 	if (m->flags & MFT_RECORD_IS_DIRECTORY) {
 		vi->i_mode |= S_IFDIR;
-		/*
-		 * Linux/Unix do not support directory hard links and things
-		 * break without this kludge.
-		 */
+		/* Things break without this kludge! */
 		if (vi->i_nlink > 1)
 			vi->i_nlink = 1;
 	} else
 		vi->i_mode |= S_IFREG;
 
-	ctx = get_attr_search_ctx(ni, m);
-	if (!ctx) {
-		err = -ENOMEM;
-		goto unm_err_out;
-	}
-
 	/*
 	 * Find the standard information attribute in the mft record. At this
 	 * stage we haven't setup the attribute list stuff yet, so this could
@@ -582,7 +569,7 @@
 		 */
 		ntfs_error(vi->i_sb, "$STANDARD_INFORMATION attribute is "
 				"missing.");
-		goto put_unm_err_out;
+		goto unm_err_out;
 	}
 	/* Get the standard information attribute value. */
 	si = (STANDARD_INFORMATION*)((char*)ctx->attr +
@@ -611,10 +598,7 @@
 	 */
 	vi->i_atime = ntfs2utc(si->last_access_time);
 
-	/*
-	 * Find the attribute list attribute and set the corresponding bit in
-	 * ntfs_ino->state.
-	 */
+	/* Find the attribute list attribute if present. */
 	reinit_attr_search_ctx(ctx);
 	if (lookup_attr(AT_ATTRIBUTE_LIST, NULL, 0, 0, 0, NULL, 0, ctx)) {
 		if (vi->i_ino == FILE_MFT)
@@ -628,7 +612,7 @@
 					"compressed/encrypted/sparse. Not "
 					"allowed. Corrupt inode. You should "
 					"run chkdsk.");
-			goto put_unm_err_out;
+			goto unm_err_out;
 		}
 		/* Now allocate memory for the attribute list. */
 		ni->attr_list_size = (u32)attribute_value_length(ctx->attr);
@@ -637,7 +621,7 @@
 			ntfs_error(vi->i_sb, "Not enough memory to allocate "
 					"buffer for attribute list.");
 			err = -ENOMEM;
-			goto ec_put_unm_err_out;
+			goto unm_err_out;
 		}
 		if (ctx->attr->non_resident) {
 			NInoSetAttrListNonResident(ni);
@@ -646,7 +630,7 @@
 						"zero lowest_vcn. Inode is "
 						"corrupt. You should run "
 						"chkdsk.");
-				goto put_unm_err_out;
+				goto unm_err_out;
 			}
 			/*
 			 * Setup the run list. No need for locking as we have
@@ -662,7 +646,7 @@
 						"error code %i. Corrupt "
 						"attribute list in inode.",
 						-err);
-				goto ec_put_unm_err_out;
+				goto unm_err_out;
 			}
 			/* Now load the attribute list. */
 			if ((err = load_attribute_list(vol, &ni->attr_list_rl,
@@ -671,7 +655,7 @@
 					ctx->attr->_ANR(initialized_size))))) {
 				ntfs_error(vi->i_sb, "Failed to load "
 						"attribute list attribute.");
-				goto ec_put_unm_err_out;
+				goto unm_err_out;
 			}
 		} else /* if (!ctx.attr->non_resident) */ {
 			if ((u8*)ctx->attr + le16_to_cpu(
@@ -681,7 +665,7 @@
 					(u8*)ctx->mrec + vol->mft_record_size) {
 				ntfs_error(vi->i_sb, "Corrupt attribute list "
 						"in inode.");
-				goto put_unm_err_out;
+				goto unm_err_out;
 			}
 			/* Now copy the attribute list. */
 			memcpy(ni->attr_list, (u8*)ctx->attr + le16_to_cpu(
@@ -707,13 +691,13 @@
 			// root attribute if recovery option is set.
 			ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is "
 					"missing.");
-			goto put_unm_err_out;
+			goto unm_err_out;
 		}
 		/* Set up the state. */
 		if (ctx->attr->non_resident) {
 			ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is "
 					"not resident. Not allowed.");
-			goto put_unm_err_out;
+			goto unm_err_out;
 		}
 		/*
 		 * Compressed/encrypted index root just means that the newly
@@ -728,7 +712,7 @@
 				ntfs_error(vi->i_sb, "Found encrypted and "
 						"compressed attribute. Not "
 						"allowed.");
-				goto put_unm_err_out;
+				goto unm_err_out;
 			}
 			NInoSetEncrypted(ni);
 		}
@@ -740,23 +724,23 @@
 		if (ir_end > (char*)ctx->mrec + vol->mft_record_size) {
 			ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is "
 					"corrupt.");
-			goto put_unm_err_out;
+			goto unm_err_out;
 		}
 		index_end = (char*)&ir->index +
 				le32_to_cpu(ir->index.index_length);
 		if (index_end > ir_end) {
 			ntfs_error(vi->i_sb, "Directory index is corrupt.");
-			goto put_unm_err_out;
+			goto unm_err_out;
 		}
 		if (ir->type != AT_FILE_NAME) {
 			ntfs_error(vi->i_sb, "Indexed attribute is not "
 					"$FILE_NAME. Not allowed.");
-			goto put_unm_err_out;
+			goto unm_err_out;
 		}
 		if (ir->collation_rule != COLLATION_FILE_NAME) {
 			ntfs_error(vi->i_sb, "Index collation rule is not "
 					"COLLATION_FILE_NAME. Not allowed.");
-			goto put_unm_err_out;
+			goto unm_err_out;
 		}
 		ni->_IDM(index_block_size) = le32_to_cpu(ir->index_block_size);
 		if (ni->_IDM(index_block_size) &
@@ -764,7 +748,7 @@
 			ntfs_error(vi->i_sb, "Index block size (%u) is not a "
 					"power of two.",
 					ni->_IDM(index_block_size));
-			goto put_unm_err_out;
+			goto unm_err_out;
 		}
 		if (ni->_IDM(index_block_size) > PAGE_CACHE_SIZE) {
 			ntfs_error(vi->i_sb, "Index block size (%u) > "
@@ -773,7 +757,7 @@
 					ni->_IDM(index_block_size),
 					PAGE_CACHE_SIZE);
 			err = -EOPNOTSUPP;
-			goto ec_put_unm_err_out;
+			goto unm_err_out;
 		}
 		if (ni->_IDM(index_block_size) < NTFS_BLOCK_SIZE) {
 			ntfs_error(vi->i_sb, "Index block size (%u) < "
@@ -782,7 +766,7 @@
 					ni->_IDM(index_block_size),
 					NTFS_BLOCK_SIZE);
 			err = -EOPNOTSUPP;
-			goto ec_put_unm_err_out;
+			goto unm_err_out;
 		}
 		ni->_IDM(index_block_size_bits) =
 				ffs(ni->_IDM(index_block_size)) - 1;
@@ -814,34 +798,34 @@
 			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
 					"is not present but $INDEX_ROOT "
 					"indicated it is.");
-			goto put_unm_err_out;
+			goto unm_err_out;
 		}
 		if (!ctx->attr->non_resident) {
 			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
 					"is resident.");
-			goto put_unm_err_out;
+			goto unm_err_out;
 		}
 		if (ctx->attr->flags & ATTR_IS_ENCRYPTED) {
 			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
 					"is encrypted.");
-			goto put_unm_err_out;
+			goto unm_err_out;
 		}
 		if (ctx->attr->flags & ATTR_IS_SPARSE) {
 			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
 					"is sparse.");
-			goto put_unm_err_out;
+			goto unm_err_out;
 		}
 		if (ctx->attr->flags & ATTR_COMPRESSION_MASK) {
 			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
 					"is compressed.");
-			goto put_unm_err_out;
+			goto unm_err_out;
 		}
 		if (ctx->attr->_ANR(lowest_vcn)) {
 			ntfs_error(vi->i_sb, "First extent of "
 					"$INDEX_ALLOCATION attribute has non "
 					"zero lowest_vcn. Inode is corrupt. "
 					"You should run chkdsk.");
-			goto put_unm_err_out;
+			goto unm_err_out;
 		}
 		vi->i_size = sle64_to_cpu(ctx->attr->_ANR(data_size));
 		ni->initialized_size = sle64_to_cpu(
@@ -854,13 +838,13 @@
 				ctx)) {
 			ntfs_error(vi->i_sb, "$BITMAP attribute is not "
 					"present but it must be.");
-			goto put_unm_err_out;
+			goto unm_err_out;
 		}
 		if (ctx->attr->flags & (ATTR_COMPRESSION_MASK |
 				ATTR_IS_ENCRYPTED | ATTR_IS_SPARSE)) {
 			ntfs_error(vi->i_sb, "$BITMAP attribute is compressed "
 					"and/or encrypted and/or sparse.");
-			goto put_unm_err_out;
+			goto unm_err_out;
 		}
 		if (ctx->attr->non_resident) {
 			NInoSetBmpNonResident(ni);
@@ -869,7 +853,7 @@
 						"attribute has non zero "
 						"lowest_vcn. Inode is corrupt. "
 						"You should run chkdsk.");
-				goto put_unm_err_out;
+				goto unm_err_out;
 			}
 			ni->_IDM(bmp_size) = sle64_to_cpu(
 					ctx->attr->_ANR(data_size));
@@ -889,7 +873,7 @@
 				ntfs_error(vi->i_sb, "Mapping pairs "
 						"decompression failed with "
 						"error code %i.", -err);
-				goto ec_put_unm_err_out;
+				goto unm_err_out;
 			}
 		} else
 			ni->_IDM(bmp_size) = ni->_IDM(bmp_initialized_size) =
@@ -903,7 +887,7 @@
 					"for index allocation (0x%Lx).",
 					(long long)ni->_IDM(bmp_size) << 3,
 					vi->i_size);
-			goto put_unm_err_out;
+			goto unm_err_out;
 		}
 skip_large_dir_stuff:
 		/* Everyone gets read and scan permissions. */
@@ -954,7 +938,7 @@
 			// attribute if recovery option is set.
 			ntfs_error(vi->i_sb, "$DATA attribute is "
 					"missing.");
-			goto put_unm_err_out;
+			goto unm_err_out;
 		}
 		/* Setup the state. */
 		if (ctx->attr->non_resident) {
@@ -967,14 +951,14 @@
 						"compression is disabled due "
 						"to cluster size (%i) > 4kiB.",
 						vol->cluster_size);
-					goto put_unm_err_out;
+					goto unm_err_out;
 				}
 				if ((ctx->attr->flags & ATTR_COMPRESSION_MASK)
 						!= ATTR_IS_COMPRESSED) {
 					ntfs_error(vi->i_sb, "Found "
 						"unknown compression method or "
 						"corrupt file.");
-					goto put_unm_err_out;
+					goto unm_err_out;
 				}
 				ni->_ICF(compression_block_clusters) = 1U <<
 					ctx->attr->_ANR(compression_unit);
@@ -987,7 +971,7 @@
 						"should run chkdsk.",
 					     ctx->attr->_ANR(compression_unit));
 					err = -EOPNOTSUPP;
-					goto ec_put_unm_err_out;
+					goto unm_err_out;
 				}
 				ni->_ICF(compression_block_size) = 1U << (
 						ctx->attr->_ANR(
@@ -1000,7 +984,7 @@
 				if (ctx->attr->flags & ATTR_COMPRESSION_MASK) {
 					ntfs_error(vi->i_sb, "Found encrypted "
 							"and compressed data.");
-					goto put_unm_err_out;
+					goto unm_err_out;
 				}
 				NInoSetEncrypted(ni);
 			}
@@ -1011,7 +995,7 @@
 						"attribute has non zero "
 						"lowest_vcn. Inode is corrupt. "
 						"You should run chkdsk.");
-				goto put_unm_err_out;
+				goto unm_err_out;
 			}
 			/* Setup all the sizes. */
 			vi->i_size = sle64_to_cpu(ctx->attr->_ANR(data_size));
@@ -1075,25 +1059,24 @@
 		vi->i_blocks = ni->allocated_size >> 9;
 	else
 		vi->i_blocks = ni->_ICF(compressed_size) >> 9;
-	/* Done. */
+
 	put_attr_search_ctx(ctx);
 	unmap_mft_record(READ, ni);
+
 	ntfs_debug("Done.");
-	return;
-ec_put_unm_err_out:
-	put_attr_search_ctx(ctx);
-	goto ec_unm_err_out;
-put_unm_err_out:
-	put_attr_search_ctx(ctx);
+	return 0;
+
 unm_err_out:
-	err = -EIO;
-ec_unm_err_out:
+	if (!err)
+		err = -EIO;
+	if (ctx)
+		put_attr_search_ctx(ctx);
 	unmap_mft_record(READ, ni);
 err_out:
 	ntfs_error(vi->i_sb, "Failed with error code %i. Marking inode 0x%lx "
 			"as bad.", -err, vi->i_ino);
 	make_bad_inode(vi);
-	return;
+	return err;
 }
 
 /**
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	Thu Jul 11 01:01:04 2002
+++ b/fs/ntfs/super.c	Thu Jul 11 01:01:04 2002
@@ -323,6 +323,11 @@
 
 	if (!parse_options(vol, opt))
 		return -EINVAL;
+
+#ifndef NTFS_RW
+	*flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
+#endif
+
 	return 0;
 }
 
@@ -789,9 +794,6 @@
 		ntfs_error(sb, "Failed to load $MFT/$BITMAP attribute.");
 		return FALSE;
 	}
-	// FIXME: If mounting read-only, it would be ok to ignore errors when
-	// loading the mftbmp but we then need to make sure nobody remounts the
-	// volume read-write...
 
 	/* Get mft mirror inode. */
 	vol->mftmirr_ino = ntfs_iget(sb, FILE_MFTMirr);
@@ -858,8 +860,8 @@
 			le16_to_cpu(ctx->attr->_ARA(value_offset)));
 	/* Some bounds checks. */
 	if ((u8*)vi < (u8*)ctx->attr || (u8*)vi +
-			le32_to_cpu(ctx->attr->_ARA(value_length)) > (u8*)ctx->attr +
-			le32_to_cpu(ctx->attr->length))
+			le32_to_cpu(ctx->attr->_ARA(value_length)) >
+			(u8*)ctx->attr + le32_to_cpu(ctx->attr->length))
 		goto err_put_vol;
 	/* Setup volume flags and version. */
 	vol->vol_flags = vi->flags;
@@ -1306,6 +1308,9 @@
 	int result;
 
 	ntfs_debug("Entering.");
+#ifndef NTFS_RW
+	sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
+#endif
 	/* Allocate a new ntfs_volume and place it in sb->u.generic_sbp. */
 	sb->u.generic_sbp = kmalloc(sizeof(ntfs_volume), GFP_NOFS);
 	vol = NTFS_SB(sb);
@@ -1346,9 +1351,6 @@
 	if (!parse_options(vol, (char*)opt))
 		goto err_out_now;
 
-	/* We are just a read-only fs at the moment. */
-	sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
-
 	/*
 	 * TODO: Fail safety check. In the future we should really be able to
 	 * cope with this being the case, but for now just bail out.
@@ -1623,7 +1625,7 @@
 
 	/* This may be ugly but it results in pretty output so who cares. (-8 */
 	printk(KERN_INFO "NTFS driver " NTFS_VERSION " [Flags: R/"
-#ifdef CONFIG_NTFS_RW
+#ifdef NTFS_RW
 			"W"
 #else
 			"O"

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch12310
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
1#WW7'#FC4/L_M#*"3`8F````
`
end
