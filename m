Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUHWKvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUHWKvK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 06:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUHWKsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 06:48:21 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:11912 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267660AbUHWKcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:32:25 -0400
Date: Mon, 23 Aug 2004 11:31:50 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 12/20] Re: [2.6-BK-URL] NTFS 2.1.17 release
In-Reply-To: <Pine.LNX.4.60.0408231131200.24220@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0408231131390.24220@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0408231055290.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128020.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128550.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129180.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129370.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129530.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130090.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130240.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130380.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130510.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131070.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131200.24220@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 12/20 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/07/22 1.1815)
   NTFS: Add fs/ntfs/attrib.[hc]::ntfs_find_vcn().
   
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
--- a/fs/ntfs/ChangeLog	2004-08-18 20:50:24 +01:00
+++ b/fs/ntfs/ChangeLog	2004-08-18 20:50:24 +01:00
@@ -25,6 +25,9 @@
 
 	- Implement bitmap modification code (fs/ntfs/bitmap.[hc]).  This
 	  includes functions to set/clear a single bit or a run of bits.
+	- Add fs/ntfs/attrib.[hc]::ntfs_find_vcn() which returns the locked
+	  runlist element containing a particular vcn.  It also takes care of
+	  mapping any needed runlist fragments.
 
 2.1.16 - Implement access time updates, file sync, async io, and read/writev.
 
@@ -448,7 +451,7 @@
 	  cannot set any write related options when the driver is compiled
 	  read-only.
 	- Optimize block resolution in fs/ntfs/aops.c::ntfs_read_block() to
-	  cache the current run list element. This should improve performance
+	  cache the current runlist element. This should improve performance
 	  when reading very large and/or very fragmented data.
 
 2.0.16 - Convert access to $MFT/$BITMAP to attribute inode API.
@@ -496,9 +499,9 @@
 	- Change fs/ntfs/super.c::ntfs_statfs() to not rely on BKL by moving
 	  the locking out of super.c::get_nr_free_mft_records() and taking and
 	  dropping the mftbmp_lock rw_semaphore in ntfs_statfs() itself.
-	- Bring attribute run list merging code (fs/ntfs/attrib.c) in sync with
+	- Bring attribute runlist merging code (fs/ntfs/attrib.c) in sync with
 	  current userspace ntfs library code. This means that if a merge
-	  fails the original run lists are always left unmodified instead of
+	  fails the original runlists are always left unmodified instead of
 	  being silently corrupted.
 	- Misc typo fixes.
 
@@ -690,7 +693,7 @@
 	  appropriately.
 	- Update to 2.5.9 kernel (preserving backwards compatibility) by
 	  replacing all occurences of page->buffers with page_buffers(page).
-	- Fix minor bugs in run list merging, also minor cleanup.
+	- Fix minor bugs in runlist merging, also minor cleanup.
 	- Updates to bootsector layout and mft mirror contents descriptions.
 	- Small bug fix in error detection in unistr.c and some cleanups.
 	- Grow name buffer allocations in unistr.c in aligned mutlipled of 64
@@ -713,12 +716,12 @@
 	  initialized_size vs data_size (i.e. i_size). Done are
 	  mft.c::ntfs_mft_readpage(), aops.c::end_buffer_read_index_async(),
 	  and attrib.c::load_attribute_list().
-	- Lock the run list in attrib.c::load_attribute_list() while using it.
+	- Lock the runlist in attrib.c::load_attribute_list() while using it.
 	- Fix memory leak in ntfs_file_read_compressed_block() and generally
 	  clean up compress.c a little, removing some uncommented/unused debug
 	  code.
 	- Tidy up dir.c a little bit.
-	- Don't bother getting the run list in inode.c::ntfs_read_inode().
+	- Don't bother getting the runlist in inode.c::ntfs_read_inode().
 	- Merge mft.c::ntfs_mft_readpage() and aops.c::ntfs_index_readpage()
 	  creating aops.c::ntfs_mst_readpage(), improving the handling of
 	  holes and overflow in the process and implementing the correct
@@ -748,7 +751,7 @@
 	- Apply kludge in ntfs_read_inode(), setting i_nlink to 1 for
 	  directories. Without this the "find" utility gets very upset which is
 	  fair enough as Linux/Unix do not support directory hard links.
-	- Further run list merging work. (Richard Russon)
+	- Further runlist merging work. (Richard Russon)
 	- Backwards compatibility for gcc-2.95. (Richard Russon)
 	- Update to kernel 2.5.5-pre1 and rediff the now tiny patch.
 	- Convert to new file system declaration using ->ntfs_get_sb() and
@@ -803,7 +806,7 @@
 	  which is then referenced but not copied.
 	- Rename run_list structure to run_list_element and create a new
 	  run_list structure containing a pointer to a run_list_element
-	  structure and a read/write semaphore. Adapt all users of run lists
+	  structure and a read/write semaphore. Adapt all users of runlists
 	  to new scheme and take and release the lock as needed. This fixes a
 	  nasty race as the run_list changes even when inodes are locked for
 	  reading and even when the inode isn't locked at all, so we really
@@ -834,7 +837,7 @@
 	- Cleanup mft.c and it's debug/error output in particular. Fix a minor
 	  bug in mapping of extent inodes. Update all the comments to fit all
 	  the recent code changes.
-	- Modify vcn_to_lcn() to cope with entirely unmapped run lists.
+	- Modify vcn_to_lcn() to cope with entirely unmapped runlists.
 	- Cleanups in compress.c, mostly comments and folding help.
 	- Implement attrib.c::map_run_list() as a generic helper.
 	- Make compress.c::ntfs_file_read_compressed_block() use map_run_list()
@@ -860,11 +863,11 @@
 	  pass in the upcase table and its length. These can be gotten from
 	  ctx->ntfs_ino->vol->upcase{_len}. Update all callers.
 	- Cleanups in attrib.c.
-	- Implement merging of run lists, attrib.c::merge_run_lists() and its
+	- Implement merging of runlists, attrib.c::merge_run_lists() and its
 	  helpers. (Richard Russon)
-	- Attribute lists part 2, attribute extents and multi part run lists:
+	- Attribute lists part 2, attribute extents and multi part runlists:
 	  enable proper support for LCN_RL_NOT_MAPPED and automatic mapping of
-	  further run list parts via attrib.c::map_run_list().
+	  further runlist parts via attrib.c::map_run_list().
 	- Tiny endianness bug fix in decompress_mapping_pairs().
 
 tng-0.0.6 - Encrypted directories, bug fixes, cleanups, debugging enhancements.
@@ -896,7 +899,7 @@
 	  support dollar signs in the names of variables/constants. Attribute
 	  types now start with AT_ instead of $ and $I30 is now just I30.
 	- Cleanup ntfs_lookup() and add consistency check of sequence numbers.
-	- Load complete run list for $MFT/$BITMAP during mount and cleanup
+	- Load complete runlist for $MFT/$BITMAP during mount and cleanup
 	  access functions. This means we now cope with $MFT/$BITMAP being
 	  spread accross several mft records.
 	- Disable modification of mft_zone_multiplier on remount. We can always
@@ -929,11 +932,11 @@
 	  parameter list. Pass either READ or WRITE to this, each has the
 	  obvious meaning.
 	- General cleanups to allow for easier folding in vi.
-	- attrib.c::decompress_mapping_pairs() now accepts the old run list
+	- attrib.c::decompress_mapping_pairs() now accepts the old runlist
 	  argument, and invokes attrib.c::merge_run_lists() to merge the old
-	  and the new run lists.
+	  and the new runlists.
 	- Removed attrib.c::find_first_attr().
-	- Implemented loading of attribute list and complete run list for $MFT.
+	- Implemented loading of attribute list and complete runlist for $MFT.
 	  This means we now cope with $MFT being spread across several mft
 	  records.
 	- Adapt to 2.5.2-pre9 and the changed create_empty_buffers() syntax.
@@ -971,7 +974,7 @@
 tng-0.0.3 - Cleanups, enhancements, bug fixes.
 
 	- Work on attrib.c::decompress_mapping_pairs() to detect base extents
-	  and setup the run list appropriately using knowledge provided by the
+	  and setup the runlist appropriately using knowledge provided by the
 	  sizes in the base attribute record.
 	- Balance the get_/put_attr_search_ctx() calls so we don't leak memory
 	  any more.
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-08-18 20:50:24 +01:00
+++ b/fs/ntfs/attrib.c	2004-08-18 20:50:24 +01:00
@@ -1051,6 +1051,107 @@
 }
 
 /**
+ * ntfs_find_vcn - find a vcn in the runlist described by an ntfs inode
+ * @ni:		ntfs inode describing the runlist to search
+ * @vcn:	vcn to find
+ * @need_write:	if false, lock for reading and if true, lock for writing
+ *
+ * Find the virtual cluster number @vcn in the runlist described by the ntfs
+ * inode @ni and return the address of the runlist element containing the @vcn.
+ * The runlist is left locked and the caller has to unlock it.  If @need_write
+ * is true, the runlist is locked for writing and if @need_write is false, the
+ * runlist is locked for reading.  In the error case, the runlist is not left
+ * locked.
+ *
+ * Note you need to distinguish between the lcn of the returned runlist element
+ * being >= 0 and LCN_HOLE.  In the later case you have to return zeroes on
+ * read and allocate clusters on write.
+ *
+ * Return the runlist element containing the @vcn on success and
+ * ERR_PTR(-errno) on error.  You need to test the return value with IS_ERR()
+ * to decide if the return is success or failure and PTR_ERR() to get to the
+ * error code if IS_ERR() is true.
+ *
+ * The possible error return codes are:
+ *	-ENOENT - No such vcn in the runlist, i.e. @vcn is out of bounds.
+ *	-ENOMEM - Not enough memory to map runlist.
+ *	-EIO	- Critical error (runlist/file is corrupt, i/o error, etc).
+ *
+ * Locking: - The runlist must be unlocked on entry.
+ *	    - On failing return, the runlist is unlocked.
+ *	    - On successful return, the runlist is locked.  If @need_write us
+ *	      true, it is locked for writing.  Otherwise is is locked for
+ *	      reading.
+ */
+runlist_element *ntfs_find_vcn(ntfs_inode *ni, const VCN vcn,
+		const BOOL need_write)
+{
+	runlist_element *rl;
+	int err = 0;
+	BOOL is_retry = FALSE;
+
+	ntfs_debug("Entering for i_ino 0x%lx, vcn 0x%llx, lock for %sing.",
+			ni->mft_no, (unsigned long long)vcn,
+			!need_write ? "read" : "writ");
+	BUG_ON(!ni);
+	BUG_ON(!NInoNonResident(ni));
+	BUG_ON(vcn < 0);
+lock_retry_remap:
+	if (!need_write)
+		down_read(&ni->runlist.lock);
+	else
+		down_write(&ni->runlist.lock);
+	rl = ni->runlist.rl;
+	if (likely(rl && vcn >= rl[0].vcn)) {
+		while (likely(rl->length)) {
+			if (likely(vcn < rl[1].vcn)) {
+				if (likely(rl->lcn >= (LCN)LCN_HOLE)) {
+					ntfs_debug("Done.");
+					return rl;
+				}
+				break;
+			}
+			rl++;
+		}
+		switch (rl->lcn) {
+		case (LCN)LCN_RL_NOT_MAPPED:
+			break;
+		case (LCN)LCN_ENOENT:
+			err = -ENOENT;
+			break;
+		default:
+			err = -EIO;
+			break;
+		}
+	}
+	if (!need_write)
+		up_read(&ni->runlist.lock);
+	else
+		up_write(&ni->runlist.lock);
+	if (!err && !is_retry) {
+		/*
+		 * The @vcn is in an unmapped region, map the runlist and
+		 * retry.
+		 */
+		err = ntfs_map_runlist(ni, vcn);
+		if (likely(!err)) {
+			is_retry = TRUE;
+			goto lock_retry_remap;
+		}
+		/*
+		 * -EINVAL and -ENOENT coming from a failed mapping attempt are
+		 * equivalent to i/o errors for us as they should not happen in
+		 * our code paths.
+		 */
+		if (err == -EINVAL || err == -ENOENT)
+			err = -EIO;
+	} else if (!err)
+		err = -EIO;
+	ntfs_error(ni->vol->sb, "Failed with error code %i.", err);
+	return ERR_PTR(err);
+}
+
+/**
  * find_attr - find (next) attribute in mft record
  * @type:	attribute type to find
  * @name:	attribute name to find (optional, i.e. NULL means don't care)
diff -Nru a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
--- a/fs/ntfs/attrib.h	2004-08-18 20:50:24 +01:00
+++ b/fs/ntfs/attrib.h	2004-08-18 20:50:24 +01:00
@@ -78,6 +78,9 @@
 
 extern LCN ntfs_vcn_to_lcn(const runlist_element *rl, const VCN vcn);
 
+extern runlist_element *ntfs_find_vcn(ntfs_inode *ni, const VCN vcn,
+		const BOOL need_write);
+
 extern BOOL find_attr(const ATTR_TYPES type, const ntfschar *name,
 		const u32 name_len, const IGNORE_CASE_BOOL ic, const u8 *val,
 		const u32 val_len, attr_search_context *ctx);
