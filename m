Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265042AbUFHLo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265042AbUFHLo6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 07:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUFHLo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 07:44:58 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:35775 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265042AbUFHLob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 07:44:31 -0400
Date: Tue, 8 Jun 2004 12:44:30 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
       Pawel Kot <pkot@bezsensu.pl>
Subject: [2.6.7-BK] NTFS 2.1.13 patch 1/8
In-Reply-To: <Pine.SOL.4.58.0406081236450.21854@orange.csi.cam.ac.uk>
Message-ID: <Pine.SOL.4.58.0406081243060.21854@orange.csi.cam.ac.uk>
References: <Pine.SOL.4.58.0406081236450.21854@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 1 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/05/28 1.1736)
   NTFS: Implement writing of mft records (fs/ntfs/mft.[hc]), which includes
         keeping the mft mirror in sync with the mft when mirrored mft records
         are written.  The functions are write_mft_record{,_nolock}().  The
         implementation is quite rudimentary for now with lots of things not
         implemented yet but I am not sure any of them can actually occur so
         I will wait for people to hit each one and only then implement it.

   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-06-08 12:22:04 +01:00
+++ b/fs/ntfs/ChangeLog	2004-06-08 12:22:04 +01:00
@@ -24,6 +24,21 @@
 	  OTOH, perhaps i_sem, which is held accross generic_file_write is
 	  sufficient for synchronisation here. We then just need to make sure
 	  ntfs_readpage/writepage/truncate interoperate properly with us.
+	- Implement mft.c::sync_mft_mirror_umount().  We currently will just
+	  leave the volume dirty on umount if the final iput(vol->mft_ino)
+	  causes a write of any mirrored mft records due to the mft mirror
+	  inode having been discarded already.  Whether this can actually ever
+	  happen is unclear however so it is worth waiting until someone hits
+	  the problem.
+
+2.1.13 - WIP.
+
+	- Implement writing of mft records (fs/ntfs/mft.[hc]), which includes
+	  keeping the mft mirror in sync with the mft when mirrored mft records
+	  are written.  The functions are write_mft_record{,_nolock}().  The
+	  implementation is quite rudimentary for now with lots of things not
+	  implemented yet but I am not sure any of them can actually occur so
+	  I will wait for people to hit each one and only then implement it.

 2.1.12 - Fix the second fix to the decompression engine and some cleanups.

diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	2004-06-08 12:22:04 +01:00
+++ b/fs/ntfs/Makefile	2004-06-08 12:22:04 +01:00
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o unistr.o upcase.o

-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.12\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.13-WIP\"

 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-06-08 12:22:04 +01:00
+++ b/fs/ntfs/aops.c	2004-06-08 12:22:04 +01:00
@@ -479,7 +479,7 @@
 	vol = ni->vol;

 	ntfs_debug("Entering for inode %li, attribute type 0x%x, page index "
-			"0x%lx.\n", vi->i_ino, ni->type, page->index);
+			"0x%lx.", vi->i_ino, ni->type, page->index);

 	BUG_ON(!NInoNonResident(ni));
 	BUG_ON(NInoMstProtected(ni));
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-06-08 12:22:04 +01:00
+++ b/fs/ntfs/attrib.c	2004-06-08 12:22:04 +01:00
@@ -624,7 +624,7 @@

 			if (drl[ds].vcn == marker_vcn) {
 				ntfs_debug("Old marker = 0x%llx, replacing "
-						"with LCN_ENOENT.\n",
+						"with LCN_ENOENT.",
 						(unsigned long long)
 						drl[ds].lcn);
 				drl[ds].lcn = (LCN)LCN_ENOENT;
@@ -1565,7 +1565,7 @@
 		goto do_next_attr_loop;
 	}
 	ntfs_error(base_ni->vol->sb, "Inode contains corrupt attribute list "
-			"attribute.\n");
+			"attribute.");
 	if (ni != base_ni) {
 		unmap_extent_mft_record(ni);
 		ctx->ntfs_ino = base_ni;
diff -Nru a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c	2004-06-08 12:22:04 +01:00
+++ b/fs/ntfs/compress.c	2004-06-08 12:22:04 +01:00
@@ -433,7 +433,7 @@
 	goto do_next_tag;

 return_overflow:
-	ntfs_error(NULL, "Failed. Returning -EOVERFLOW.\n");
+	ntfs_error(NULL, "Failed. Returning -EOVERFLOW.");
 	goto return_error;
 }

@@ -851,7 +851,7 @@
 		if (err) {
 			ntfs_error(vol->sb, "ntfs_decompress() failed in inode "
 					"0x%lx with error code %i. Skipping "
-					"this compression block.\n",
+					"this compression block.",
 					ni->mft_no, -err);
 			/* Release the unfinished pages. */
 			for (; prev_cur_page < cur_page; prev_cur_page++) {
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-06-08 12:22:04 +01:00
+++ b/fs/ntfs/mft.c	2004-06-08 12:22:04 +01:00
@@ -429,3 +429,390 @@
 		ntfs_clear_extent_inode(ni);
 	return m;
 }
+
+#ifdef NTFS_RW
+
+static const char *ntfs_please_email = "Please email "
+		"linux-ntfs-dev@lists.sourceforge.net and say that you saw "
+		"this message.  Thank you.";
+
+/**
+ * sync_mft_mirror_umount - synchronise an mft record to the mft mirror
+ * @ni:		ntfs inode whose mft record to synchronize
+ * @m:		mapped, mst protected (extent) mft record to synchronize
+ *
+ * Write the mapped, mst protected (extent) mft record @m described by the
+ * (regular or extent) ntfs inode @ni to the mft mirror ($MFTMirr) bypassing
+ * the page cache and the $MFTMirr inode itself.
+ *
+ * This function is only for use at umount time when the mft mirror inode has
+ * already been disposed off.  We BUG() if we are called while the mft mirror
+ * inode is still attached to the volume.
+ *
+ * On success return 0.  On error return -errno.
+ *
+ * NOTE:  This function is not implemented yet as I am not convinced it can
+ * actually be triggered considering the sequence of commits we do in super.c::
+ * ntfs_put_super().  But just in case we provide this place holder as the
+ * alternative would be either to BUG() or to get a NULL pointer dereference
+ * and Oops.
+ */
+static int sync_mft_mirror_umount(ntfs_inode *ni, MFT_RECORD *m)
+{
+	ntfs_volume *vol = ni->vol;
+
+	BUG_ON(vol->mftmirr_ino);
+	ntfs_error(vol->sb, "Umount time mft mirror syncing is not "
+			"implemented yet.  %s", ntfs_please_email);
+	return -EOPNOTSUPP;
+}
+
+/**
+ * sync_mft_mirror - synchronize an mft record to the mft mirror
+ * @ni:		ntfs inode whose mft record to synchronize
+ * @m:		mapped, mst protected (extent) mft record to synchronize
+ * @sync:	if true, wait for i/o completion
+ *
+ * Write the mapped, mst protected (extent) mft record @m described by the
+ * (regular or extent) ntfs inode @ni to the mft mirror ($MFTMirr).
+ *
+ * On success return 0.  On error return -errno and set the volume errors flag
+ * in the ntfs_volume to which @ni belongs.
+ *
+ * NOTE:  We always perform synchronous i/o and ignore the @sync parameter.
+ *
+ * TODO:  If @sync is false, want to do truly asynchronous i/o, i.e. just
+ * schedule i/o via ->writepage or do it via kntfsd or whatever.
+ */
+static int sync_mft_mirror(ntfs_inode *ni, MFT_RECORD *m, int sync)
+{
+	ntfs_volume *vol = ni->vol;
+	struct page *page;
+	unsigned int blocksize = vol->sb->s_blocksize;
+	int max_bhs = vol->mft_record_size / blocksize;
+	struct buffer_head *bhs[max_bhs];
+	struct buffer_head *bh, *head;
+	u8 *kmirr;
+	unsigned int block_start, block_end, m_start, m_end;
+	int i_bhs, nr_bhs, err = 0;
+
+	ntfs_debug("Entering for inode 0x%lx.", ni->mft_no);
+	BUG_ON(!max_bhs);
+	if (unlikely(!vol->mftmirr_ino)) {
+		/* This could happen during umount... */
+		err = sync_mft_mirror_umount(ni, m);
+		if (likely(!err))
+			return err;
+		goto err_out;
+	}
+	/* Get the page containing the mirror copy of the mft record @m. */
+	page = ntfs_map_page(vol->mftmirr_ino->i_mapping, ni->mft_no >>
+			(PAGE_CACHE_SHIFT - vol->mft_record_size_bits));
+	if (unlikely(IS_ERR(page))) {
+		ntfs_error(vol->sb, "Failed to map mft mirror page.");
+		err = PTR_ERR(page);
+		goto err_out;
+	}
+	/*
+	 * Exclusion against other writers.   This should never be a problem
+	 * since the page in which the mft record @m resides is also locked and
+	 * hence any other writers would be held up there but it is better to
+	 * make sure no one is writing from elsewhere.
+	 */
+	lock_page(page);
+	/* The address in the page of the mirror copy of the mft record @m. */
+	kmirr = page_address(page) + ((ni->mft_no << vol->mft_record_size_bits)
+			& ~PAGE_CACHE_MASK);
+	/* Copy the mst protected mft record to the mirror. */
+	memcpy(kmirr, m, vol->mft_record_size);
+	/* Make sure we have mapped buffers. */
+	if (!page_has_buffers(page)) {
+no_buffers_err_out:
+		ntfs_error(vol->sb, "Writing mft mirror records without "
+				"existing buffers is not implemented yet.  %s",
+				ntfs_please_email);
+		err = -EOPNOTSUPP;
+		goto unlock_err_out;
+	}
+	bh = head = page_buffers(page);
+	if (!bh)
+		goto no_buffers_err_out;
+	nr_bhs = 0;
+	block_start = 0;
+	m_start = kmirr - (u8*)page_address(page);
+	m_end = m_start + vol->mft_record_size;
+	do {
+		block_end = block_start + blocksize;
+		/*
+		 * If the buffer is outside the mft record, just skip it,
+		 * clearing it if it is dirty to make sure it is not written
+		 * out.  It should never be marked dirty but better be safe.
+		 */
+		if ((block_end <= m_start) || (block_start >= m_end)) {
+			if (buffer_dirty(bh)) {
+				ntfs_warning(vol->sb, "Clearing dirty mft "
+						"record page buffer.  %s",
+						ntfs_please_email);
+				clear_buffer_dirty(bh);
+			}
+			continue;
+		}
+		if (!buffer_mapped(bh)) {
+			ntfs_error(vol->sb, "Writing mft mirror records "
+					"without existing mapped buffers is "
+					"not implemented yet.  %s",
+					ntfs_please_email);
+			err = -EOPNOTSUPP;
+			continue;
+		}
+		if (!buffer_uptodate(bh)) {
+			ntfs_error(vol->sb, "Writing mft mirror records "
+					"without existing uptodate buffers is "
+					"not implemented yet.  %s",
+					ntfs_please_email);
+			err = -EOPNOTSUPP;
+			continue;
+		}
+		BUG_ON(!nr_bhs && (m_start != block_start));
+		BUG_ON(nr_bhs >= max_bhs);
+		bhs[nr_bhs++] = bh;
+		BUG_ON((nr_bhs >= max_bhs) && (m_end != block_end));
+	} while (block_start = block_end, (bh = bh->b_this_page) != head);
+	if (likely(!err)) {
+		/* Lock buffers and start synchronous write i/o on them. */
+		for (i_bhs = 0; i_bhs < nr_bhs; i_bhs++) {
+			struct buffer_head *tbh = bhs[i_bhs];
+
+			if (unlikely(test_set_buffer_locked(tbh)))
+				BUG();
+			BUG_ON(!buffer_uptodate(tbh));
+			if (buffer_dirty(tbh))
+				clear_buffer_dirty(tbh);
+			get_bh(tbh);
+			tbh->b_end_io = end_buffer_write_sync;
+			submit_bh(WRITE, tbh);
+		}
+		/* Wait on i/o completion of buffers. */
+		for (i_bhs = 0; i_bhs < nr_bhs; i_bhs++) {
+			struct buffer_head *tbh = bhs[i_bhs];
+
+			wait_on_buffer(tbh);
+			if (unlikely(!buffer_uptodate(tbh))) {
+				err = -EIO;
+				/*
+				 * Set the buffer uptodate so the page & buffer
+				 * states don't become out of sync.
+				 */
+				if (PageUptodate(page))
+					set_buffer_uptodate(tbh);
+			}
+		}
+	} else /* if (unlikely(err)) */ {
+		/* Clean the buffers. */
+		for (i_bhs = 0; i_bhs < nr_bhs; i_bhs++)
+			clear_buffer_dirty(bhs[i_bhs]);
+	}
+unlock_err_out:
+	/* Current state: all buffers are clean, unlocked, and uptodate. */
+	/* Remove the mst protection fixups again. */
+	post_write_mst_fixup((NTFS_RECORD*)kmirr);
+	flush_dcache_page(page);
+	unlock_page(page);
+	ntfs_unmap_page(page);
+	if (unlikely(err)) {
+		/* I/O error during writing.  This is really bad! */
+		ntfs_error(vol->sb, "I/O error while writing mft mirror "
+				"record 0x%lx!  You should unmount the volume "
+				"and run chkdsk or ntfsfix.", ni->mft_no);
+		goto err_out;
+	}
+	ntfs_debug("Done.");
+	return 0;
+err_out:
+	ntfs_error(vol->sb, "Failed to synchronize $MFTMirr (error code %i).  "
+			"Volume will be left marked dirty on umount.  Run "
+			"ntfsfix on the partition after umounting to correct "
+			"this.", -err);
+	/* We don't want to clear the dirty bit on umount. */
+	NVolSetErrors(vol);
+	return err;
+}
+
+/**
+ * write_mft_record_nolock - write out a mapped (extent) mft record
+ * @ni:		ntfs inode describing the mapped (extent) mft record
+ * @m:		mapped (extent) mft record to write
+ * @sync:	if true, wait for i/o completion
+ *
+ * Write the mapped (extent) mft record @m described by the (regular or extent)
+ * ntfs inode @ni to backing store.  If the mft record @m has a counterpart in
+ * the mft mirror, that is also updated.
+ *
+ * On success, clean the mft record and return 0.  On error, leave the mft
+ * record dirty and return -errno.  The caller should call make_bad_inode() on
+ * the base inode to ensure no more access happens to this inode.  We do not do
+ * it here as the caller may want to finish writing other extent mft records
+ * first to minimize on-disk metadata inconsistencies.
+ *
+ * NOTE:  We always perform synchronous i/o and ignore the @sync parameter.
+ * However, if the mft record has a counterpart in the mft mirror and @sync is
+ * true, we write the mft record, wait for i/o completion, and only then write
+ * the mft mirror copy.  This ensures that if the system crashes either the mft
+ * or the mft mirror will contain a self-consistent mft record @m.  If @sync is
+ * false on the other hand, we start i/o on both and then wait for completion
+ * on them.  This provides a speedup but no longer guarantees that you will end
+ * up with a self-consistent mft record in the case of a crash but if you asked
+ * for asynchronous writing you probably do not care about that anyway.
+ *
+ * TODO:  If @sync is false, want to do truly asynchronous i/o, i.e. just
+ * schedule i/o via ->writepage or do it via kntfsd or whatever.
+ */
+int write_mft_record_nolock(ntfs_inode *ni, MFT_RECORD *m, int sync)
+{
+	ntfs_volume *vol = ni->vol;
+	struct page *page = ni->page;
+	unsigned int blocksize = vol->sb->s_blocksize;
+	int max_bhs = vol->mft_record_size / blocksize;
+	struct buffer_head *bhs[max_bhs];
+	struct buffer_head *bh, *head;
+	unsigned int block_start, block_end, m_start, m_end;
+	int i_bhs, nr_bhs, err = 0;
+
+	ntfs_debug("Entering for inode 0x%lx.", ni->mft_no);
+	BUG_ON(NInoAttr(ni));
+	BUG_ON(!max_bhs);
+	BUG_ON(!page);
+	BUG_ON(!PageLocked(page));
+	/*
+	 * If the ntfs_inode is clean no need to do anything.  If it is dirty,
+	 * mark it as clean now so that it can be redirtied later on if needed.
+	 * There is no danger of races as as long as the caller is holding the
+	 * locks for the mft record @m and the page it is in.
+	 */
+	if (!NInoTestClearDirty(ni))
+		goto done;
+	/* Make sure we have mapped buffers. */
+	if (!page_has_buffers(page)) {
+no_buffers_err_out:
+		ntfs_error(vol->sb, "Writing mft records without existing "
+				"buffers is not implemented yet.  %s",
+				ntfs_please_email);
+		err = -EOPNOTSUPP;
+		goto err_out;
+	}
+	bh = head = page_buffers(page);
+	if (!bh)
+		goto no_buffers_err_out;
+	nr_bhs = 0;
+	block_start = 0;
+	m_start = ni->page_ofs;
+	m_end = m_start + vol->mft_record_size;
+	do {
+		block_end = block_start + blocksize;
+		/*
+		 * If the buffer is outside the mft record, just skip it,
+		 * clearing it if it is dirty to make sure it is not written
+		 * out.  It should never be marked dirty but better be safe.
+		 */
+		if ((block_end <= m_start) || (block_start >= m_end)) {
+			if (buffer_dirty(bh)) {
+				ntfs_warning(vol->sb, "Clearing dirty mft "
+						"record page buffer.  %s",
+						ntfs_please_email);
+				clear_buffer_dirty(bh);
+			}
+			continue;
+		}
+		if (!buffer_mapped(bh)) {
+			ntfs_error(vol->sb, "Writing mft records without "
+					"existing mapped buffers is not "
+					"implemented yet.  %s",
+					ntfs_please_email);
+			err = -EOPNOTSUPP;
+			continue;
+		}
+		if (!buffer_uptodate(bh)) {
+			ntfs_error(vol->sb, "Writing mft records without "
+					"existing uptodate buffers is not "
+					"implemented yet.  %s",
+					ntfs_please_email);
+			err = -EOPNOTSUPP;
+			continue;
+		}
+		BUG_ON(!nr_bhs && (m_start != block_start));
+		BUG_ON(nr_bhs >= max_bhs);
+		bhs[nr_bhs++] = bh;
+		BUG_ON((nr_bhs >= max_bhs) && (m_end != block_end));
+	} while (block_start = block_end, (bh = bh->b_this_page) != head);
+	if (unlikely(err))
+		goto cleanup_out;
+	/* Apply the mst protection fixups. */
+	err = pre_write_mst_fixup((NTFS_RECORD*)m, vol->mft_record_size);
+	if (err) {
+		ntfs_error(vol->sb, "Failed to apply mst fixups!");
+		goto cleanup_out;
+	}
+	flush_dcache_mft_record_page(ni);
+	/* Lock buffers and start synchronous write i/o on them. */
+	for (i_bhs = 0; i_bhs < nr_bhs; i_bhs++) {
+		struct buffer_head *tbh = bhs[i_bhs];
+
+		if (unlikely(test_set_buffer_locked(tbh)))
+			BUG();
+		BUG_ON(!buffer_uptodate(tbh));
+		if (buffer_dirty(tbh))
+			clear_buffer_dirty(tbh);
+		get_bh(tbh);
+		tbh->b_end_io = end_buffer_write_sync;
+		submit_bh(WRITE, tbh);
+	}
+	/* Synchronize the mft mirror now if not @sync. */
+	if (!sync && ni->mft_no < vol->mftmirr_size)
+		sync_mft_mirror(ni, m, sync);
+	/* Wait on i/o completion of buffers. */
+	for (i_bhs = 0; i_bhs < nr_bhs; i_bhs++) {
+		struct buffer_head *tbh = bhs[i_bhs];
+
+		wait_on_buffer(tbh);
+		if (unlikely(!buffer_uptodate(tbh))) {
+			err = -EIO;
+			/*
+			 * Set the buffer uptodate so the page & buffer states
+			 * don't become out of sync.
+			 */
+			if (PageUptodate(page))
+				set_buffer_uptodate(tbh);
+		}
+	}
+	/* If @sync, now synchronize the mft mirror. */
+	if (sync && ni->mft_no < vol->mftmirr_size)
+		sync_mft_mirror(ni, m, sync);
+	/* Remove the mst protection fixups again. */
+	post_write_mst_fixup((NTFS_RECORD*)m);
+	flush_dcache_mft_record_page(ni);
+	if (unlikely(err)) {
+		/* I/O error during writing.  This is really bad! */
+		ntfs_error(vol->sb, "I/O error while writing mft record "
+				"0x%lx!  Marking base inode as bad.  You "
+				"should unmount the volume and run chkdsk.",
+				ni->mft_no);
+		goto err_out;
+	}
+done:
+	ntfs_debug("Done.");
+	return 0;
+cleanup_out:
+	/* Clean the buffers. */
+	for (i_bhs = 0; i_bhs < nr_bhs; i_bhs++)
+		clear_buffer_dirty(bhs[i_bhs]);
+err_out:
+	/*
+	 * Current state: all buffers are clean, unlocked, and uptodate.
+	 * The caller should mark the base inode as bad so that no more i/o
+	 * happens.  ->clear_inode() will still be invoked so all extent inodes
+	 * and other allocated memory will be freed.
+	 */
+	return err;
+}
+
+#endif /* NTFS_RW */
diff -Nru a/fs/ntfs/mft.h b/fs/ntfs/mft.h
--- a/fs/ntfs/mft.h	2004-06-08 12:22:04 +01:00
+++ b/fs/ntfs/mft.h	2004-06-08 12:22:04 +01:00
@@ -57,6 +57,41 @@
 	flush_dcache_page(ni->page);
 }

+extern int write_mft_record_nolock(ntfs_inode *ni, MFT_RECORD *m, int sync);
+
+/**
+ * write_mft_record - write out a mapped (extent) mft record
+ * @ni:		ntfs inode describing the mapped (extent) mft record
+ * @m:		mapped (extent) mft record to write
+ * @sync:	if true, wait for i/o completion
+ *
+ * This is just a wrapper for write_mft_record_nolock() (see mft.c), which
+ * locks the page for the duration of the write.  This ensures that there are
+ * no race conditions between writing the mft record via the dirty inode code
+ * paths and via the page cache write back code paths or between writing
+ * neighbouring mft records residing in the same page.
+ *
+ * Locking the page also serializes us against ->readpage() if the page is not
+ * uptodate.
+ *
+ * On success, clean the mft record and return 0.  On error, leave the mft
+ * record dirty and return -errno.  The caller should call make_bad_inode() on
+ * the base inode to ensure no more access happens to this inode.  We do not do
+ * it here as the caller may want to finish writing other extent mft records
+ * first to minimize on-disk metadata inconsistencies.
+ */
+static inline int write_mft_record(ntfs_inode *ni, MFT_RECORD *m, int sync)
+{
+	struct page *page = ni->page;
+	int err;
+
+	BUG_ON(!page);
+	lock_page(page);
+	err = write_mft_record_nolock(ni, m, sync);
+	unlock_page(page);
+	return err;
+}
+
 #endif /* NTFS_RW */

 #endif /* _LINUX_NTFS_MFT_H */
