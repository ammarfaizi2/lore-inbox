Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbUKJPBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbUKJPBs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 10:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbUKJOuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:50:35 -0500
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:19161 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261876AbUKJNpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:45:32 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 19/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsmq-0006Rc-QR@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:45:24 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 19/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/11/05 1.2026.1.54)
   NTFS: Rewrite handling of multi sector transfer errors.  We now do not set
         PageError() when such errors are detected in the async i/o handler           fs/ntfs/aops.c::ntfs_end_buffer_async_read().  All users of mst           protected attributes now check the magic of each ntfs record as they           use it and act appropriately.  This has the effect of making errors
         granular per ntfs record rather than per page which solves the case
         where we cannot access any of the ntfs records in a page when a
         single one of them had an mst error.  (Thanks to Ken MacFerrin for
         the bug report.)
   
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
--- a/fs/ntfs/ChangeLog	2004-11-10 13:45:28 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:45:28 +00:00
@@ -72,6 +72,15 @@
 	  thus was not mapped.  (Thanks to Ken MacFerrin for the bug report.)
 	- Drop the runlist lock after the vcn has been read in
 	  fs/ntfs/lcnalloc.c::__ntfs_cluster_free().
+	- Rewrite handling of multi sector transfer errors.  We now do not set
+	  PageError() when such errors are detected in the async i/o handler
+	  fs/ntfs/aops.c::ntfs_end_buffer_async_read().  All users of mst
+	  protected attributes now check the magic of each ntfs record as they
+	  use it and act appropriately.  This has the effect of making errors
+	  granular per ntfs record rather than per page which solves the case
+	  where we cannot access any of the ntfs records in a page when a
+	  single one of them had an mst error.  (Thanks to Ken MacFerrin for
+	  the bug report.)
 
 2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-11-10 13:45:28 +00:00
+++ b/fs/ntfs/aops.c	2004-11-10 13:45:28 +00:00
@@ -43,13 +43,13 @@
  * @uptodate:	whether @bh is now uptodate or not
  *
  * Asynchronous I/O completion handler for reading pages belonging to the
- * attribute address space of an inode. The inodes can either be files or
+ * attribute address space of an inode.  The inodes can either be files or
  * directories or they can be fake inodes describing some attribute.
  *
  * If NInoMstProtected(), perform the post read mst fixups when all IO on the
  * page has been completed and mark the page uptodate or set the error bit on
- * the page. To determine the size of the records that need fixing up, we cheat
- * a little bit by setting the index_block_size in ntfs_inode to the ntfs
+ * the page.  To determine the size of the records that need fixing up, we
+ * cheat a little bit by setting the index_block_size in ntfs_inode to the ntfs
  * record size, and index_block_size_bits, to the log(base 2) of the ntfs
  * record size.
  */
@@ -90,7 +90,6 @@
 				(unsigned long long)bh->b_blocknr);
 		SetPageError(page);
 	}
-
 	spin_lock_irqsave(&page_uptodate_lock, flags);
 	clear_buffer_async_read(bh);
 	unlock_buffer(bh);
@@ -111,42 +110,30 @@
 	 * If none of the buffers had errors then we can set the page uptodate,
 	 * but we first have to perform the post read mst fixups, if the
 	 * attribute is mst protected, i.e. if NInoMstProteced(ni) is true.
+	 * Note we ignore fixup errors as those are detected when
+	 * map_mft_record() is called which gives us per record granularity
+	 * rather than per page granularity.
 	 */
 	if (!NInoMstProtected(ni)) {
 		if (likely(page_uptodate && !PageError(page)))
 			SetPageUptodate(page);
 	} else {
 		char *addr;
-		unsigned int i, recs, nr_err;
+		unsigned int i, recs;
 		u32 rec_size;
 
 		rec_size = ni->itype.index.block_size;
 		recs = PAGE_CACHE_SIZE / rec_size;
+		/* Should have been verified before we got here... */
+		BUG_ON(!recs);
 		addr = kmap_atomic(page, KM_BIO_SRC_IRQ);
-		for (i = nr_err = 0; i < recs; i++) {
-			if (likely(!post_read_mst_fixup((NTFS_RECORD*)(addr +
-					i * rec_size), rec_size)))
-				continue;
-			nr_err++;
-			ntfs_error(ni->vol->sb, "post_read_mst_fixup() failed, "
-					"corrupt %s record 0x%llx. Run chkdsk.",
-					ni->mft_no ? "index" : "mft",
-					(unsigned long long)(((s64)page->index
-					<< PAGE_CACHE_SHIFT >>
-					ni->itype.index.block_size_bits) + i));
-		}
+		for (i = 0; i < recs; i++)
+			post_read_mst_fixup((NTFS_RECORD*)(addr +
+					i * rec_size), rec_size);
 		flush_dcache_page(page);
 		kunmap_atomic(addr, KM_BIO_SRC_IRQ);
-		if (likely(!PageError(page))) {
-			if (likely(!nr_err && recs)) {
-				if (likely(page_uptodate))
-					SetPageUptodate(page);
-			} else {
-				ntfs_error(ni->vol->sb, "Setting page error, "
-						"index 0x%lx.", page->index);
-				SetPageError(page);
-			}
-		}
+		if (likely(!PageError(page) && page_uptodate))
+			SetPageUptodate(page);
 	}
 	unlock_page(page);
 	return;
diff -Nru a/fs/ntfs/aops.h b/fs/ntfs/aops.h
--- a/fs/ntfs/aops.h	2004-11-10 13:45:28 +00:00
+++ b/fs/ntfs/aops.h	2004-11-10 13:45:28 +00:00
@@ -55,6 +55,13 @@
  * method defined in the address space operations of @mapping and the page is
  * added to the page cache of @mapping in the process.
  *
+ * If the page belongs to an mst protected attribute and it is marked as such
+ * in its ntfs inode (NInoMstProtected()) the mst fixups are applied but no
+ * error checking is performed.  This means the caller has to verify whether
+ * the ntfs record(s) contained in the page are valid or not using one of the
+ * ntfs_is_XXXX_record{,p}() macros, where XXXX is the record type you are
+ * expecting to see.  (For details of the macros, see fs/ntfs/layout.h.)
+ *
  * If the page is in high memory it is mapped into memory directly addressible
  * by the kernel.
  *
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	2004-11-10 13:45:28 +00:00
+++ b/fs/ntfs/dir.c	2004-11-10 13:45:28 +00:00
@@ -300,7 +300,6 @@
 		ntfs_error(sb, "No index allocation attribute but index entry "
 				"requires one. Directory inode 0x%lx is "
 				"corrupt or driver bug.", dir_ni->mft_no);
-		err = -EIO;
 		goto err_out;
 	}
 	/* Get the starting vcn of the index_block holding the child node. */
@@ -338,7 +337,13 @@
 	if ((u8*)ia < kaddr || (u8*)ia > kaddr + PAGE_CACHE_SIZE) {
 		ntfs_error(sb, "Out of bounds check failed. Corrupt directory "
 				"inode 0x%lx or driver bug.", dir_ni->mft_no);
-		err = -EIO;
+		goto unm_err_out;
+	}
+	/* Catch multi sector transfer fixup errors. */
+	if (unlikely(!ntfs_is_indx_record(ia->magic))) {
+		ntfs_error(sb, "Directory index record with vcn 0x%llx is "
+				"corrupt.  Corrupt inode 0x%lx.  Run chkdsk.",
+				(unsigned long long)vcn, dir_ni->mft_no);
 		goto unm_err_out;
 	}
 	if (sle64_to_cpu(ia->index_block_vcn) != vcn) {
@@ -348,7 +353,6 @@
 				"bug.", (unsigned long long)
 				sle64_to_cpu(ia->index_block_vcn),
 				(unsigned long long)vcn, dir_ni->mft_no);
-		err = -EIO;
 		goto unm_err_out;
 	}
 	if (le32_to_cpu(ia->index.allocated_size) + 0x18 !=
@@ -360,7 +364,6 @@
 				(unsigned long long)vcn, dir_ni->mft_no,
 				le32_to_cpu(ia->index.allocated_size) + 0x18,
 				dir_ni->itype.index.block_size);
-		err = -EIO;
 		goto unm_err_out;
 	}
 	index_end = (u8*)ia + dir_ni->itype.index.block_size;
@@ -370,7 +373,6 @@
 				"Cannot access! This is probably a bug in the "
 				"driver.", (unsigned long long)vcn,
 				dir_ni->mft_no);
-		err = -EIO;
 		goto unm_err_out;
 	}
 	index_end = (u8*)&ia->index + le32_to_cpu(ia->index.index_length);
@@ -378,7 +380,6 @@
 		ntfs_error(sb, "Size of index buffer (VCN 0x%llx) of directory "
 				"inode 0x%lx exceeds maximum size.",
 				(unsigned long long)vcn, dir_ni->mft_no);
-		err = -EIO;
 		goto unm_err_out;
 	}
 	/* The first index entry. */
@@ -398,7 +399,6 @@
 			ntfs_error(sb, "Index entry out of bounds in "
 					"directory inode 0x%lx.",
 					dir_ni->mft_no);
-			err = -EIO;
 			goto unm_err_out;
 		}
 		/*
@@ -551,7 +551,6 @@
 			ntfs_error(sb, "Index entry with child node found in "
 					"a leaf node in directory inode 0x%lx.",
 					dir_ni->mft_no);
-			err = -EIO;
 			goto unm_err_out;
 		}
 		/* Child node present, descend into it. */
@@ -572,7 +571,6 @@
 		}
 		ntfs_error(sb, "Negative child node vcn in directory inode "
 				"0x%lx.", dir_ni->mft_no);
-		err = -EIO;
 		goto unm_err_out;
 	}
 	/*
@@ -591,6 +589,8 @@
 	unlock_page(page);
 	ntfs_unmap_page(page);
 err_out:
+	if (!err)
+		err = -EIO;
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
 	if (m)
@@ -601,8 +601,7 @@
 	}
 	return ERR_MREF(err);
 dir_err_out:
-	ntfs_error(sb, "Corrupt directory. Aborting lookup.");
-	err = -EIO;
+	ntfs_error(sb, "Corrupt directory.  Aborting lookup.");
 	goto err_out;
 }
 
@@ -780,7 +779,6 @@
 		ntfs_error(sb, "No index allocation attribute but index entry "
 				"requires one. Directory inode 0x%lx is "
 				"corrupt or driver bug.", dir_ni->mft_no);
-		err = -EIO;
 		goto err_out;
 	}
 	/* Get the starting vcn of the index_block holding the child node. */
@@ -818,7 +816,13 @@
 	if ((u8*)ia < kaddr || (u8*)ia > kaddr + PAGE_CACHE_SIZE) {
 		ntfs_error(sb, "Out of bounds check failed. Corrupt directory "
 				"inode 0x%lx or driver bug.", dir_ni->mft_no);
-		err = -EIO;
+		goto unm_err_out;
+	}
+	/* Catch multi sector transfer fixup errors. */
+	if (unlikely(!ntfs_is_indx_record(ia->magic))) {
+		ntfs_error(sb, "Directory index record with vcn 0x%llx is "
+				"corrupt.  Corrupt inode 0x%lx.  Run chkdsk.",
+				(unsigned long long)vcn, dir_ni->mft_no);
 		goto unm_err_out;
 	}
 	if (sle64_to_cpu(ia->index_block_vcn) != vcn) {
@@ -828,7 +832,6 @@
 				"bug.", (unsigned long long)
 				sle64_to_cpu(ia->index_block_vcn),
 				(unsigned long long)vcn, dir_ni->mft_no);
-		err = -EIO;
 		goto unm_err_out;
 	}
 	if (le32_to_cpu(ia->index.allocated_size) + 0x18 !=
@@ -840,7 +843,6 @@
 				(unsigned long long)vcn, dir_ni->mft_no,
 				le32_to_cpu(ia->index.allocated_size) + 0x18,
 				dir_ni->itype.index.block_size);
-		err = -EIO;
 		goto unm_err_out;
 	}
 	index_end = (u8*)ia + dir_ni->itype.index.block_size;
@@ -850,7 +852,6 @@
 				"Cannot access! This is probably a bug in the "
 				"driver.", (unsigned long long)vcn,
 				dir_ni->mft_no);
-		err = -EIO;
 		goto unm_err_out;
 	}
 	index_end = (u8*)&ia->index + le32_to_cpu(ia->index.index_length);
@@ -858,7 +859,6 @@
 		ntfs_error(sb, "Size of index buffer (VCN 0x%llx) of directory "
 				"inode 0x%lx exceeds maximum size.",
 				(unsigned long long)vcn, dir_ni->mft_no);
-		err = -EIO;
 		goto unm_err_out;
 	}
 	/* The first index entry. */
@@ -878,7 +878,6 @@
 			ntfs_error(sb, "Index entry out of bounds in "
 					"directory inode 0x%lx.",
 					dir_ni->mft_no);
-			err = -EIO;
 			goto unm_err_out;
 		}
 		/*
@@ -962,7 +961,6 @@
 			ntfs_error(sb, "Index entry with child node found in "
 					"a leaf node in directory inode 0x%lx.",
 					dir_ni->mft_no);
-			err = -EIO;
 			goto unm_err_out;
 		}
 		/* Child node present, descend into it. */
@@ -982,7 +980,6 @@
 		}
 		ntfs_error(sb, "Negative child node vcn in directory inode "
 				"0x%lx.", dir_ni->mft_no);
-		err = -EIO;
 		goto unm_err_out;
 	}
 	/* No child node, return -ENOENT. */
@@ -992,6 +989,8 @@
 	unlock_page(page);
 	ntfs_unmap_page(page);
 err_out:
+	if (!err)
+		err = -EIO;
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
 	if (m)
@@ -999,7 +998,6 @@
 	return ERR_MREF(err);
 dir_err_out:
 	ntfs_error(sb, "Corrupt directory. Aborting lookup.");
-	err = -EIO;
 	goto err_out;
 }
 
@@ -1338,6 +1336,14 @@
 	if (unlikely((u8*)ia < kaddr || (u8*)ia > kaddr + PAGE_CACHE_SIZE)) {
 		ntfs_error(sb, "Out of bounds check failed. Corrupt directory "
 				"inode 0x%lx or driver bug.", vdir->i_ino);
+		goto err_out;
+	}
+	/* Catch multi sector transfer fixup errors. */
+	if (unlikely(!ntfs_is_indx_record(ia->magic))) {
+		ntfs_error(sb, "Directory index record with vcn 0x%llx is "
+				"corrupt.  Corrupt inode 0x%lx.  Run chkdsk.",
+				(unsigned long long)ia_pos >>
+				ndir->itype.index.vcn_size_bits, vdir->i_ino);
 		goto err_out;
 	}
 	if (unlikely(sle64_to_cpu(ia->index_block_vcn) != (ia_pos &
diff -Nru a/fs/ntfs/index.c b/fs/ntfs/index.c
--- a/fs/ntfs/index.c	2004-11-10 13:45:28 +00:00
+++ b/fs/ntfs/index.c	2004-11-10 13:45:28 +00:00
@@ -263,7 +263,6 @@
 		ntfs_error(sb, "No index allocation attribute but index entry "
 				"requires one.  Inode 0x%lx is corrupt or "
 				"driver bug.", idx_ni->mft_no);
-		err = -EIO;
 		goto err_out;
 	}
 	/* Get the starting vcn of the index_block holding the child node. */
@@ -301,7 +300,13 @@
 	if ((u8*)ia < kaddr || (u8*)ia > kaddr + PAGE_CACHE_SIZE) {
 		ntfs_error(sb, "Out of bounds check failed.  Corrupt inode "
 				"0x%lx or driver bug.", idx_ni->mft_no);
-		err = -EIO;
+		goto unm_err_out;
+	}
+	/* Catch multi sector transfer fixup errors. */
+	if (unlikely(!ntfs_is_indx_record(ia->magic))) {
+		ntfs_error(sb, "Index record with vcn 0x%llx is corrupt.  "
+				"Corrupt inode 0x%lx.  Run chkdsk.",
+				(long long)vcn, idx_ni->mft_no);
 		goto unm_err_out;
 	}
 	if (sle64_to_cpu(ia->index_block_vcn) != vcn) {
@@ -311,7 +316,6 @@
 				(unsigned long long)
 				sle64_to_cpu(ia->index_block_vcn),
 				(unsigned long long)vcn, idx_ni->mft_no);
-		err = -EIO;
 		goto unm_err_out;
 	}
 	if (le32_to_cpu(ia->index.allocated_size) + 0x18 !=
@@ -323,7 +327,6 @@
 				idx_ni->mft_no,
 				le32_to_cpu(ia->index.allocated_size) + 0x18,
 				idx_ni->itype.index.block_size);
-		err = -EIO;
 		goto unm_err_out;
 	}
 	index_end = (u8*)ia + idx_ni->itype.index.block_size;
@@ -333,7 +336,6 @@
 				"access!  This is probably a bug in the "
 				"driver.", (unsigned long long)vcn,
 				idx_ni->mft_no);
-		err = -EIO;
 		goto unm_err_out;
 	}
 	index_end = (u8*)&ia->index + le32_to_cpu(ia->index.index_length);
@@ -341,7 +343,6 @@
 		ntfs_error(sb, "Size of index buffer (VCN 0x%llx) of inode "
 				"0x%lx exceeds maximum size.",
 				(unsigned long long)vcn, idx_ni->mft_no);
-		err = -EIO;
 		goto unm_err_out;
 	}
 	/* The first index entry. */
@@ -359,11 +360,10 @@
 				(u8*)ie + le16_to_cpu(ie->length) > index_end) {
 			ntfs_error(sb, "Index entry out of bounds in inode "
 					"0x%lx.", idx_ni->mft_no);
-			err = -EIO;
 			goto unm_err_out;
 		}
 		/*
-		 * The last entry cannot contain a ket.  It can however contain
+		 * The last entry cannot contain a key.  It can however contain
 		 * a pointer to a child node in the B+tree so we just break out.
 		 */
 		if (ie->flags & INDEX_ENTRY_END)
@@ -377,7 +377,6 @@
 				le16_to_cpu(ie->length)) {
 			ntfs_error(sb, "Index entry out of bounds in inode "
 					"0x%lx.", idx_ni->mft_no);
-			err = -EIO;
 			goto unm_err_out;
 		}
 		/* If the keys match perfectly, we setup @ictx and return 0. */
@@ -424,7 +423,6 @@
 	if ((ia->index.flags & NODE_MASK) == LEAF_NODE) {
 		ntfs_error(sb, "Index entry with child node found in a leaf "
 				"node in inode 0x%lx.", idx_ni->mft_no);
-		err = -EIO;
 		goto unm_err_out;
 	}
 	/* Child node present, descend into it. */
@@ -446,11 +444,12 @@
 	}
 	ntfs_error(sb, "Negative child node vcn in inode 0x%lx.",
 			idx_ni->mft_no);
-	err = -EIO;
 unm_err_out:
 	unlock_page(page);
 	ntfs_unmap_page(page);
 err_out:
+	if (!err)
+		err = -EIO;
 	if (actx)
 		ntfs_attr_put_search_ctx(actx);
 	if (m)
@@ -458,6 +457,5 @@
 	return err;
 idx_err_out:
 	ntfs_error(sb, "Corrupt index.  Aborting lookup.");
-	err = -EIO;
 	goto err_out;
 }
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-11-10 13:45:28 +00:00
+++ b/fs/ntfs/mft.c	2004-11-10 13:45:28 +00:00
@@ -68,20 +68,31 @@
 		if (index > end_index || (mft_vi->i_size & ~PAGE_CACHE_MASK) <
 				ofs + vol->mft_record_size) {
 			page = ERR_PTR(-ENOENT);
+			ntfs_error(vol->sb, "Attemt to read mft record 0x%lx, "
+					"which is beyond the end of the mft.  "
+					"This is probably a bug in the ntfs "
+					"driver.", ni->mft_no);
 			goto err_out;
 		}
 	}
 	/* Read, map, and pin the page. */
 	page = ntfs_map_page(mft_vi->i_mapping, index);
 	if (likely(!IS_ERR(page))) {
-		ni->page = page;
-		ni->page_ofs = ofs;
-		return page_address(page) + ofs;
+		/* Catch multi sector transfer fixup errors. */
+		if (likely(ntfs_is_mft_recordp((le32*)(page_address(page) +
+				ofs)))) {
+			ni->page = page;
+			ni->page_ofs = ofs;
+			return page_address(page) + ofs;
+		}
+		ntfs_error(vol->sb, "Mft record 0x%lx is corrupt.  "
+				"Run chkdsk.", ni->mft_no);
+		ntfs_unmap_page(page);
+		page = ERR_PTR(-EIO);
 	}
 err_out:
 	ni->page = NULL;
 	ni->page_ofs = 0;
-	ntfs_error(vol->sb, "Failed with error code %lu.", -PTR_ERR(page));
 	return (void*)page;
 }
 
