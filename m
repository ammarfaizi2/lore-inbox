Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUHWLLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUHWLLl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 07:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUHWK4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 06:56:41 -0400
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:7884 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267689AbUHWKcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:32:33 -0400
Date: Mon, 23 Aug 2004 11:32:22 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 14/20] Re: [2.6-BK-URL] NTFS 2.1.17 release
In-Reply-To: <Pine.LNX.4.60.0408231131520.24220@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0408231132080.24220@hermes-1.csi.cam.ac.uk>
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
 <Pine.LNX.4.60.0408231131390.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131520.24220@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 14/20 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/08/16 1.1820)
   NTFS: Implement cluster (de-)allocation code (fs/ntfs/lcnalloc.[hc]).
   
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
--- a/fs/ntfs/ChangeLog	2004-08-18 20:50:30 +01:00
+++ b/fs/ntfs/ChangeLog	2004-08-18 20:50:30 +01:00
@@ -28,6 +28,7 @@
 	- Add fs/ntfs/attrib.[hc]::ntfs_find_vcn() which returns the locked
 	  runlist element containing a particular vcn.  It also takes care of
 	  mapping any needed runlist fragments.
+	- Implement cluster (de-)allocation code (fs/ntfs/lcnalloc.[hc]).
 
 2.1.16 - Implement access time updates, file sync, async io, and read/writev.
 
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	2004-08-18 20:50:30 +01:00
+++ b/fs/ntfs/Makefile	2004-08-18 20:50:30 +01:00
@@ -15,5 +15,5 @@
 ifeq ($(CONFIG_NTFS_RW),y)
 EXTRA_CFLAGS += -DNTFS_RW
 
-ntfs-objs += bitmap.o logfile.o quota.o
+ntfs-objs += bitmap.o lcnalloc.o logfile.o quota.o
 endif
diff -Nru a/fs/ntfs/bitmap.c b/fs/ntfs/bitmap.c
--- a/fs/ntfs/bitmap.c	2004-08-18 20:50:30 +01:00
+++ b/fs/ntfs/bitmap.c	2004-08-18 20:50:30 +01:00
@@ -56,8 +56,9 @@
 
 	BUG_ON(!vi);
 	ntfs_debug("Entering for i_ino 0x%lx, start_bit 0x%llx, count 0x%llx, "
-			"value %u.", vi->i_ino, (unsigned long long)start_bit,
-			(unsigned long long)cnt, (unsigned int)value);
+			"value %u.%s", vi->i_ino, (unsigned long long)start_bit,
+			(unsigned long long)cnt, (unsigned int)value,
+			is_rollback ? " (rollback)" : "");
 	BUG_ON(start_bit < 0);
 	BUG_ON(cnt < 0);
 	BUG_ON(value > 1);
diff -Nru a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/fs/ntfs/lcnalloc.c	2004-08-18 20:50:30 +01:00
@@ -0,0 +1,1015 @@
+/*
+ * lcnalloc.c - Cluster (de)allocation code.  Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2004 Anton Altaparmakov
+ *
+ * This program/include file is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program/include file is distributed in the hope that it will be
+ * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program (in the main directory of the Linux-NTFS
+ * distribution in the file COPYING); if not, write to the Free Software
+ * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifdef NTFS_RW
+
+#include <linux/pagemap.h>
+
+#include "lcnalloc.h"
+#include "debug.h"
+#include "bitmap.h"
+#include "inode.h"
+#include "volume.h"
+#include "attrib.h"
+#include "malloc.h"
+#include "ntfs.h"
+
+/**
+ * ntfs_cluster_free_from_rl_nolock - free clusters from runlist
+ * @vol:	mounted ntfs volume on which to free the clusters
+ * @rl:		runlist describing the clusters to free
+ *
+ * Free all the clusters described by the runlist @rl on the volume @vol.  In
+ * the case of an error being returned, at least some of the clusters were not
+ * freed.
+ *
+ * Return 0 on success and -errno on error.
+ *
+ * Locking: - The volume lcn bitmap must be locked for writing on entry and is
+ *	      left locked on return.
+ */
+static int ntfs_cluster_free_from_rl_nolock(ntfs_volume *vol,
+		const runlist_element *rl)
+{
+	struct inode *lcnbmp_vi = vol->lcnbmp_ino;
+	int ret = 0;
+
+	ntfs_debug("Entering.");
+	for (; rl->length; rl++) {
+		int err;
+
+		if (rl->lcn < 0)
+			continue;
+		err = ntfs_bitmap_clear_run(lcnbmp_vi, rl->lcn, rl->length);
+		if (unlikely(err && (!ret || ret == ENOMEM) && ret != err))
+			ret = err;
+	}
+	ntfs_debug("Done.");
+	return ret;
+}
+
+/**
+ * ntfs_cluster_alloc - allocate clusters on an ntfs volume
+ * @vol:	mounted ntfs volume on which to allocate the clusters
+ * @start_vcn:	vcn to use for the first allocated cluster
+ * @count:	number of clusters to allocate
+ * @start_lcn:	starting lcn at which to allocate the clusters (or -1 if none)
+ * @zone:	zone from which to allocate the clusters
+ *
+ * Allocate @count clusters preferably starting at cluster @start_lcn or at the
+ * current allocator position if @start_lcn is -1, on the mounted ntfs volume
+ * @vol. @zone is either DATA_ZONE for allocation of normal clusters or
+ * MFT_ZONE for allocation of clusters for the master file table, i.e. the
+ * $MFT/$DATA attribute.
+ *
+ * @start_vcn specifies the vcn of the first allocated cluster.  This makes
+ * merging the resulting runlist with the old runlist easier.
+ *
+ * You need to check the return value with IS_ERR().  If this is false, the
+ * function was successful and the return value is a runlist describing the
+ * allocated cluster(s).  If IS_ERR() is true, the function failed and
+ * PTR_ERR() gives you the error code.
+ *
+ * Notes on the allocation algorithm
+ * =================================
+ *
+ * There are two data zones.  First is the area between the end of the mft zone
+ * and the end of the volume, and second is the area between the start of the
+ * volume and the start of the mft zone.  On unmodified/standard NTFS 1.x
+ * volumes, the second data zone does not exist due to the mft zone being
+ * expanded to cover the start of the volume in order to reserve space for the
+ * mft bitmap attribute.
+ *
+ * This is not the prettiest function but the complexity stems from the need of
+ * implementing the mft vs data zoned approach and from the fact that we have
+ * access to the lcn bitmap in portions of up to 8192 bytes at a time, so we
+ * need to cope with crossing over boundaries of two buffers.  Further, the
+ * fact that the allocator allows for caller supplied hints as to the location
+ * of where allocation should begin and the fact that the allocator keeps track
+ * of where in the data zones the next natural allocation should occur,
+ * contribute to the complexity of the function.  But it should all be
+ * worthwhile, because this allocator should: 1) be a full implementation of
+ * the MFT zone approach used by Windows NT, 2) cause reduction in
+ * fragmentation, and 3) be speedy in allocations (the code is not optimized
+ * for speed, but the algorithm is, so further speed improvements are probably
+ * possible).
+ *
+ * FIXME: We should be monitoring cluster allocation and increment the MFT zone
+ * size dynamically but this is something for the future.  We will just cause
+ * heavier fragmentation by not doing it and I am not even sure Windows would
+ * grow the MFT zone dynamically, so it might even be correct not to do this.
+ * The overhead in doing dynamic MFT zone expansion would be very large and
+ * unlikely worth the effort. (AIA)
+ *
+ * TODO: I have added in double the required zone position pointer wrap around
+ * logic which can be optimized to having only one of the two logic sets.
+ * However, having the double logic will work fine, but if we have only one of
+ * the sets and we get it wrong somewhere, then we get into trouble, so
+ * removing the duplicate logic requires _very_ careful consideration of _all_
+ * possible code paths.  So at least for now, I am leaving the double logic -
+ * better safe than sorry... (AIA)
+ *
+ * Locking: - The volume lcn bitmap must be unlocked on entry and is unlocked
+ *	      on return.
+ *	    - This function takes the volume lcn bitmap lock for writing and
+ *	      modifies the bitmap contents.
+ */
+runlist_element *ntfs_cluster_alloc(ntfs_volume *vol, const VCN start_vcn,
+		const s64 count, const LCN start_lcn,
+		const NTFS_CLUSTER_ALLOCATION_ZONES zone)
+{
+	LCN zone_start, zone_end, bmp_pos, bmp_initial_pos, last_read_pos, lcn;
+	LCN prev_lcn = 0, prev_run_len = 0, mft_zone_size;
+	s64 clusters;
+	struct inode *lcnbmp_vi;
+	runlist_element *rl = NULL;
+	struct address_space *mapping;
+	struct page *page = NULL;
+	u8 *buf, *byte;
+	int err = 0, rlpos, rlsize, buf_size;
+	u8 pass, done_zones, search_zone, need_writeback = 0, bit;
+
+	ntfs_debug("Entering for start_vcn 0x%llx, count 0x%llx, start_lcn "
+			"0x%llx, zone %s_ZONE.", (unsigned long long)start_vcn,
+			(unsigned long long)count,
+			(unsigned long long)start_lcn,
+			zone == MFT_ZONE ? "MFT" : "DATA");
+	BUG_ON(!vol);
+	lcnbmp_vi = vol->lcnbmp_ino;
+	BUG_ON(!lcnbmp_vi);
+	BUG_ON(start_vcn < 0);
+	BUG_ON(count < 0);
+	BUG_ON(start_lcn < -1);
+	BUG_ON(zone < FIRST_ZONE);
+	BUG_ON(zone > LAST_ZONE);
+
+	/* Return empty runlist if @count == 0 */
+	// FIXME: Do we want to just return NULL instead? (AIA)
+	if (!count) {
+		rl = ntfs_malloc_nofs(PAGE_SIZE);
+		if (!rl)
+			return ERR_PTR(-ENOMEM);
+		rlpos = 0;
+		if (start_vcn) {
+			rl[0].vcn = 0;
+			rl[0].lcn = LCN_RL_NOT_MAPPED;
+			rl[0].length = start_vcn;
+			rlpos++;
+		}
+		rl[rlpos].vcn = start_vcn;
+		rl[rlpos].lcn = LCN_ENOENT;
+		rl[rlpos].length = 0;
+		return rl;
+	}
+	/* Take the lcnbmp lock for writing. */
+	down_write(&vol->lcnbmp_lock);
+	/*
+	 * If no specific @start_lcn was requested, use the current data zone
+	 * position, otherwise use the requested @start_lcn but make sure it
+	 * lies outside the mft zone.  Also set done_zones to 0 (no zones done)
+	 * and pass depending on whether we are starting inside a zone (1) or
+	 * at the beginning of a zone (2).  If requesting from the MFT_ZONE,
+	 * we either start at the current position within the mft zone or at
+	 * the specified position.  If the latter is out of bounds then we start
+	 * at the beginning of the MFT_ZONE.
+	 */
+	done_zones = 0;
+	pass = 1;
+	/*
+	 * zone_start and zone_end are the current search range.  search_zone
+	 * is 1 for mft zone, 2 for data zone 1 (end of mft zone till end of
+	 * volume) and 4 for data zone 2 (start of volume till start of mft
+	 * zone).
+	 */
+	zone_start = start_lcn;
+	if (zone_start < 0) {
+		if (zone == DATA_ZONE)
+			zone_start = vol->data1_zone_pos;
+		else
+			zone_start = vol->mft_zone_pos;
+		if (!zone_start) {
+			/*
+			 * Zone starts at beginning of volume which means a
+			 * single pass is sufficient.
+			 */
+			pass = 2;
+		}
+	} else if (zone == DATA_ZONE && zone_start >= vol->mft_zone_start &&
+			zone_start < vol->mft_zone_end) {
+		zone_start = vol->mft_zone_end;
+		/*
+		 * Starting at beginning of data1_zone which means a single
+		 * pass in this zone is sufficient.
+		 */
+		pass = 2;
+	} else if (zone == MFT_ZONE && (zone_start < vol->mft_zone_start ||
+			zone_start >= vol->mft_zone_end)) {
+		zone_start = vol->mft_lcn;
+		if (!vol->mft_zone_end)
+			zone_start = 0;
+		/*
+		 * Starting at beginning of volume which means a single pass
+		 * is sufficient.
+		 */
+		pass = 2;
+	}
+	if (zone == MFT_ZONE) {
+		zone_end = vol->mft_zone_end;
+		search_zone = 1;
+	} else /* if (zone == DATA_ZONE) */ {
+		/* Skip searching the mft zone. */
+		done_zones |= 1;
+		if (zone_start >= vol->mft_zone_end) {
+			zone_end = vol->nr_clusters;
+			search_zone = 2;
+		} else {
+			zone_end = vol->mft_zone_start;
+			search_zone = 4;
+		}
+	}
+	/*
+	 * bmp_pos is the current bit position inside the bitmap.  We use
+	 * bmp_initial_pos to determine whether or not to do a zone switch.
+	 */
+	bmp_pos = bmp_initial_pos = zone_start;
+
+	/* Loop until all clusters are allocated, i.e. clusters == 0. */
+	clusters = count;
+	rlpos = rlsize = 0;
+	mapping = lcnbmp_vi->i_mapping;
+	while (1) {
+		ntfs_debug("Start of outer while loop: done_zones 0x%x, "
+				"search_zone %i, pass %i, zone_start 0x%llx, "
+				"zone_end 0x%llx, bmp_initial_pos 0x%llx, "
+				"bmp_pos 0x%llx, rlpos %i, rlsize %i.",
+				done_zones, search_zone, pass,
+				(unsigned long long)zone_start,
+				(unsigned long long)zone_end,
+				(unsigned long long)bmp_initial_pos,
+				(unsigned long long)bmp_pos, rlpos, rlsize);
+		/* Loop until we run out of free clusters. */
+		last_read_pos = bmp_pos >> 3;
+		ntfs_debug("last_read_pos 0x%llx.",
+				(unsigned long long)last_read_pos);
+		if (last_read_pos > lcnbmp_vi->i_size) {
+			ntfs_debug("End of attribute reached.  "
+					"Skipping to zone_pass_done.");
+			goto zone_pass_done;
+		}
+		if (likely(page)) {
+			if (need_writeback) {
+				ntfs_debug("Marking page dirty.");
+				flush_dcache_page(page);
+				set_page_dirty(page);
+				need_writeback = 0;
+			}
+			ntfs_unmap_page(page);
+		}
+		page = ntfs_map_page(mapping, last_read_pos >>
+				PAGE_CACHE_SHIFT);
+		if (IS_ERR(page)) {
+			err = PTR_ERR(page);
+			ntfs_error(vol->sb, "Failed to map page.");
+			goto out;
+		}
+		buf_size = last_read_pos & ~PAGE_CACHE_MASK;
+		buf = page_address(page) + buf_size;
+		buf_size = PAGE_CACHE_SIZE - buf_size;
+		if (unlikely(last_read_pos + buf_size > lcnbmp_vi->i_size))
+			buf_size = lcnbmp_vi->i_size - last_read_pos;
+		buf_size <<= 3;
+		lcn = bmp_pos & 7;
+		bmp_pos &= ~7;
+		ntfs_debug("Before inner while loop: buf_size %i, lcn 0x%llx, "
+				"bmp_pos 0x%llx, need_writeback %i.", buf_size,
+				(unsigned long long)lcn,
+				(unsigned long long)bmp_pos, need_writeback);
+		while (lcn < buf_size && lcn + bmp_pos < zone_end) {
+			byte = buf + (lcn >> 3);
+			ntfs_debug("In inner while loop: buf_size %i, "
+					"lcn 0x%llx, bmp_pos 0x%llx, "
+					"need_writeback %i, byte ofs 0x%x, "
+					"*byte 0x%x.", buf_size,
+					(unsigned long long)lcn,
+					(unsigned long long)bmp_pos,
+					need_writeback,
+					(unsigned int)(lcn >> 3),
+					(unsigned int)*byte);
+			/* Skip full bytes. */
+			if (*byte == 0xff) {
+				lcn = (lcn + 8) & ~7;
+				ntfs_debug("Continuing while loop 1.");
+				continue;
+			}
+			bit = 1 << (lcn & 7);
+			ntfs_debug("bit %i.", bit);
+			/* If the bit is already set, go onto the next one. */
+			if (*byte & bit) {
+				lcn++;
+				ntfs_debug("Continuing while loop 2.");
+				continue;
+			}
+			/*
+			 * Allocate more memory if needed, including space for
+			 * the not-mapped and terminator elements.
+			 * ntfs_malloc_nofs() operates on whole pages only.
+			 */
+			if ((rlpos + 3) * sizeof(*rl) > rlsize) {
+				runlist_element *rl2;
+
+				ntfs_debug("Reallocating memory.");
+				if (!rl)
+					ntfs_debug("First free bit is at LCN "
+							"0x%llx.",
+							(unsigned long long)
+							(lcn + bmp_pos));
+				rl2 = ntfs_malloc_nofs(rlsize + (int)PAGE_SIZE);
+				if (unlikely(!rl2)) {
+					err = -ENOMEM;
+					ntfs_error(vol->sb, "Failed to "
+							"allocate memory.");
+					goto out;
+				}
+				memcpy(rl2, rl, rlsize);
+				ntfs_free(rl);
+				rl = rl2;
+				rlsize += PAGE_SIZE;
+				ntfs_debug("Reallocated memory, rlsize 0x%x.",
+						rlsize);
+			}
+			/* Allocate the bitmap bit. */
+			*byte |= bit;
+			/* We need to write this bitmap page to disk. */
+			need_writeback = 1;
+			ntfs_debug("*byte 0x%x, need_writeback is set.",
+					(unsigned int)*byte);
+			/*
+			 * Coalesce with previous run if adjacent LCNs.
+			 * Otherwise, append a new run.
+			 */
+			ntfs_debug("Adding run (lcn 0x%llx, len 0x%llx), "
+					"prev_lcn 0x%llx, lcn 0x%llx, "
+					"bmp_pos 0x%llx, prev_run_len 0x%llx, "
+					"rlpos %i.",
+					(unsigned long long)(lcn + bmp_pos),
+					1ULL, (unsigned long long)prev_lcn,
+					(unsigned long long)lcn,
+					(unsigned long long)bmp_pos,
+					(unsigned long long)prev_run_len,
+					rlpos);
+			if (prev_lcn == lcn + bmp_pos - prev_run_len && rlpos) {
+				ntfs_debug("Coalescing to run (lcn 0x%llx, "
+						"len 0x%llx).",
+						(unsigned long long)
+						rl[rlpos - 1].lcn,
+						(unsigned long long)
+						rl[rlpos - 1].length);
+				rl[rlpos - 1].length = ++prev_run_len;
+				ntfs_debug("Run now (lcn 0x%llx, len 0x%llx), "
+						"prev_run_len 0x%llx.",
+						(unsigned long long)
+						rl[rlpos - 1].lcn,
+						(unsigned long long)
+						rl[rlpos - 1].length,
+						(unsigned long long)
+						prev_run_len);
+			} else {
+				if (likely(rlpos)) {
+					ntfs_debug("Adding new run, (previous "
+							"run lcn 0x%llx, "
+							"len 0x%llx).",
+							(unsigned long long)
+							rl[rlpos - 1].lcn,
+							(unsigned long long)
+							rl[rlpos - 1].length);
+					rl[rlpos].vcn = rl[rlpos - 1].vcn +
+							prev_run_len;
+				} else {
+					ntfs_debug("Adding new run, is first "
+							"run.");
+					rl[rlpos].vcn = 0;
+					if (start_vcn) {
+						rl[rlpos].lcn =
+							LCN_RL_NOT_MAPPED;
+						rl[rlpos].length = start_vcn;
+						rlpos++;
+						rl[rlpos].vcn = start_vcn;
+					}
+				}
+				rl[rlpos].lcn = prev_lcn = lcn + bmp_pos;
+				rl[rlpos].length = prev_run_len = 1;
+				rlpos++;
+			}
+			/* Done? */
+			if (!--clusters) {
+				LCN tc;
+				/*
+				 * Update the current zone position.  Positions
+				 * of already scanned zones have been updated
+				 * during the respective zone switches.
+				 */
+				tc = lcn + bmp_pos + 1;
+				ntfs_debug("Done. Updating current zone "
+						"position, tc 0x%llx, "
+						"search_zone %i.",
+						(unsigned long long)tc,
+						search_zone);
+				switch (search_zone) {
+				case 1:
+					ntfs_debug("Before checks, "
+							"vol->mft_zone_pos "
+							"0x%llx.",
+							(unsigned long long)
+							vol->mft_zone_pos);
+					if (tc >= vol->mft_zone_end) {
+						vol->mft_zone_pos =
+								vol->mft_lcn;
+						if (!vol->mft_zone_end)
+							vol->mft_zone_pos = 0;
+					} else if ((bmp_initial_pos >=
+							vol->mft_zone_pos ||
+							tc > vol->mft_zone_pos)
+							&& tc >= vol->mft_lcn)
+						vol->mft_zone_pos = tc;
+					ntfs_debug("After checks, "
+							"vol->mft_zone_pos "
+							"0x%llx.",
+							(unsigned long long)
+							vol->mft_zone_pos);
+					break;
+				case 2:
+					ntfs_debug("Before checks, "
+							"vol->data1_zone_pos "
+							"0x%llx.",
+							(unsigned long long)
+							vol->data1_zone_pos);
+					if (tc >= vol->nr_clusters)
+						vol->data1_zone_pos =
+							     vol->mft_zone_end;
+					else if ((bmp_initial_pos >=
+						    vol->data1_zone_pos ||
+						    tc > vol->data1_zone_pos)
+						    && tc >= vol->mft_zone_end)
+						vol->data1_zone_pos = tc;
+					ntfs_debug("After checks, "
+							"vol->data1_zone_pos "
+							"0x%llx.",
+							(unsigned long long)
+							vol->data1_zone_pos);
+					break;
+				case 4:
+					ntfs_debug("Before checks, "
+							"vol->data2_zone_pos "
+							"0x%llx.",
+							(unsigned long long)
+							vol->data2_zone_pos);
+					if (tc >= vol->mft_zone_start)
+						vol->data2_zone_pos = 0;
+					else if (bmp_initial_pos >=
+						      vol->data2_zone_pos ||
+						      tc > vol->data2_zone_pos)
+						vol->data2_zone_pos = tc;
+					ntfs_debug("After checks, "
+							"vol->data2_zone_pos "
+							"0x%llx.",
+							(unsigned long long)
+							vol->data2_zone_pos);
+					break;
+				default:
+					BUG();
+				}
+				ntfs_debug("Finished.  Going to out.");
+				goto out;
+			}
+			lcn++;
+		}
+		bmp_pos += buf_size;
+		ntfs_debug("After inner while loop: buf_size 0x%x, lcn "
+				"0x%llx, bmp_pos 0x%llx, need_writeback %i.",
+				buf_size, (unsigned long long)lcn,
+				(unsigned long long)bmp_pos, need_writeback);
+		if (bmp_pos < zone_end) {
+			ntfs_debug("Continuing outer while loop, "
+					"bmp_pos 0x%llx, zone_end 0x%llx.",
+					(unsigned long long)bmp_pos,
+					(unsigned long long)zone_end);
+			continue;
+		}
+zone_pass_done:	/* Finished with the current zone pass. */
+		ntfs_debug("At zone_pass_done, pass %i.", pass);
+		if (pass == 1) {
+			/*
+			 * Now do pass 2, scanning the first part of the zone
+			 * we omitted in pass 1.
+			 */
+			pass = 2;
+			zone_end = zone_start;
+			switch (search_zone) {
+			case 1: /* mft_zone */
+				zone_start = vol->mft_zone_start;
+				break;
+			case 2: /* data1_zone */
+				zone_start = vol->mft_zone_end;
+				break;
+			case 4: /* data2_zone */
+				zone_start = 0;
+				break;
+			default:
+				BUG();
+			}
+			/* Sanity check. */
+			if (zone_end < zone_start)
+				zone_end = zone_start;
+			bmp_pos = zone_start;
+			ntfs_debug("Continuing outer while loop, pass 2, "
+					"zone_start 0x%llx, zone_end 0x%llx, "
+					"bmp_pos 0x%llx.",
+					(unsigned long long)zone_start,
+					(unsigned long long)zone_end,
+					(unsigned long long)bmp_pos);
+			continue;
+		} /* pass == 2 */
+done_zones_check:
+		ntfs_debug("At done_zones_check, search_zone %i, done_zones "
+				"before 0x%x, done_zones after 0x%x.",
+				search_zone, done_zones,
+				done_zones | search_zone);
+		done_zones |= search_zone;
+		if (done_zones < 7) {
+			ntfs_debug("Switching zone.");
+			/* Now switch to the next zone we haven't done yet. */
+			pass = 1;
+			switch (search_zone) {
+			case 1:
+				ntfs_debug("Switching from mft zone to data1 "
+						"zone.");
+				/* Update mft zone position. */
+				if (rlpos) {
+					LCN tc;
+
+					ntfs_debug("Before checks, "
+							"vol->mft_zone_pos "
+							"0x%llx.",
+							(unsigned long long)
+							vol->mft_zone_pos);
+					tc = rl[rlpos - 1].lcn +
+							rl[rlpos - 1].length;
+					if (tc >= vol->mft_zone_end) {
+						vol->mft_zone_pos =
+								vol->mft_lcn;
+						if (!vol->mft_zone_end)
+							vol->mft_zone_pos = 0;
+					} else if ((bmp_initial_pos >=
+							vol->mft_zone_pos ||
+							tc > vol->mft_zone_pos)
+							&& tc >= vol->mft_lcn)
+						vol->mft_zone_pos = tc;
+					ntfs_debug("After checks, "
+							"vol->mft_zone_pos "
+							"0x%llx.",
+							(unsigned long long)
+							vol->mft_zone_pos);
+				}
+				/* Switch from mft zone to data1 zone. */
+switch_to_data1_zone:		search_zone = 2;
+				zone_start = bmp_initial_pos =
+						vol->data1_zone_pos;
+				zone_end = vol->nr_clusters;
+				if (zone_start == vol->mft_zone_end)
+					pass = 2;
+				if (zone_start >= zone_end) {
+					vol->data1_zone_pos = zone_start =
+							vol->mft_zone_end;
+					pass = 2;
+				}
+				break;
+			case 2:
+				ntfs_debug("Switching from data1 zone to "
+						"data2 zone.");
+				/* Update data1 zone position. */
+				if (rlpos) {
+					LCN tc;
+
+					ntfs_debug("Before checks, "
+							"vol->data1_zone_pos "
+							"0x%llx.",
+							(unsigned long long)
+							vol->data1_zone_pos);
+					tc = rl[rlpos - 1].lcn +
+							rl[rlpos - 1].length;
+					if (tc >= vol->nr_clusters)
+						vol->data1_zone_pos =
+							     vol->mft_zone_end;
+					else if ((bmp_initial_pos >=
+						    vol->data1_zone_pos ||
+						    tc > vol->data1_zone_pos)
+						    && tc >= vol->mft_zone_end)
+						vol->data1_zone_pos = tc;
+					ntfs_debug("After checks, "
+							"vol->data1_zone_pos "
+							"0x%llx.",
+							(unsigned long long)
+							vol->data1_zone_pos);
+				}
+				/* Switch from data1 zone to data2 zone. */
+				search_zone = 4;
+				zone_start = bmp_initial_pos =
+						vol->data2_zone_pos;
+				zone_end = vol->mft_zone_start;
+				if (!zone_start)
+					pass = 2;
+				if (zone_start >= zone_end) {
+					vol->data2_zone_pos = zone_start =
+							bmp_initial_pos = 0;
+					pass = 2;
+				}
+				break;
+			case 4:
+				ntfs_debug("Switching from data2 zone to "
+						"data1 zone.");
+				/* Update data2 zone position. */
+				if (rlpos) {
+					LCN tc;
+
+					ntfs_debug("Before checks, "
+							"vol->data2_zone_pos "
+							"0x%llx.",
+							(unsigned long long)
+							vol->data2_zone_pos);
+					tc = rl[rlpos - 1].lcn +
+							rl[rlpos - 1].length;
+					if (tc >= vol->mft_zone_start)
+						vol->data2_zone_pos = 0;
+					else if (bmp_initial_pos >=
+						      vol->data2_zone_pos ||
+						      tc > vol->data2_zone_pos)
+						vol->data2_zone_pos = tc;
+					ntfs_debug("After checks, "
+							"vol->data2_zone_pos "
+							"0x%llx.",
+							(unsigned long long)
+							vol->data2_zone_pos);
+				}
+				/* Switch from data2 zone to data1 zone. */
+				goto switch_to_data1_zone;
+			default:
+				BUG();
+			}
+			ntfs_debug("After zone switch, search_zone %i, "
+					"pass %i, bmp_initial_pos 0x%llx, "
+					"zone_start 0x%llx, zone_end 0x%llx.",
+					search_zone, pass,
+					(unsigned long long)bmp_initial_pos,
+					(unsigned long long)zone_start,
+					(unsigned long long)zone_end);
+			bmp_pos = zone_start;
+			if (zone_start == zone_end) {
+				ntfs_debug("Empty zone, going to "
+						"done_zones_check.");
+				/* Empty zone. Don't bother searching it. */
+				goto done_zones_check;
+			}
+			ntfs_debug("Continuing outer while loop.");
+			continue;
+		} /* done_zones == 7 */
+		ntfs_debug("All zones are finished.");
+		/*
+		 * All zones are finished!  If DATA_ZONE, shrink mft zone.  If
+		 * MFT_ZONE, we have really run out of space.
+		 */
+		mft_zone_size = vol->mft_zone_end - vol->mft_zone_start;
+		ntfs_debug("vol->mft_zone_start 0x%llx, vol->mft_zone_end "
+				"0x%llx, mft_zone_size 0x%llx.",
+				(unsigned long long)vol->mft_zone_start,
+				(unsigned long long)vol->mft_zone_end,
+				(unsigned long long)mft_zone_size);
+		if (zone == MFT_ZONE || mft_zone_size <= 0) {
+			ntfs_debug("No free clusters left, going to out.");
+			/* Really no more space left on device. */
+			err = ENOSPC;
+			goto out;
+		} /* zone == DATA_ZONE && mft_zone_size > 0 */
+		ntfs_debug("Shrinking mft zone.");
+		zone_end = vol->mft_zone_end;
+		mft_zone_size >>= 1;
+		if (mft_zone_size > 0)
+			vol->mft_zone_end = vol->mft_zone_start + mft_zone_size;
+		else /* mft zone and data2 zone no longer exist. */
+			vol->data2_zone_pos = vol->mft_zone_start =
+					vol->mft_zone_end = 0;
+		if (vol->mft_zone_pos >= vol->mft_zone_end) {
+			vol->mft_zone_pos = vol->mft_lcn;
+			if (!vol->mft_zone_end)
+				vol->mft_zone_pos = 0;
+		}
+		bmp_pos = zone_start = bmp_initial_pos =
+				vol->data1_zone_pos = vol->mft_zone_end;
+		search_zone = 2;
+		pass = 2;
+		done_zones &= ~2;
+		ntfs_debug("After shrinking mft zone, mft_zone_size 0x%llx, "
+				"vol->mft_zone_start 0x%llx, "
+				"vol->mft_zone_end 0x%llx, "
+				"vol->mft_zone_pos 0x%llx, search_zone 2, "
+				"pass 2, dones_zones 0x%x, zone_start 0x%llx, "
+				"zone_end 0x%llx, vol->data1_zone_pos 0x%llx, "
+				"continuing outer while loop.",
+				(unsigned long long)mft_zone_size,
+				(unsigned long long)vol->mft_zone_start,
+				(unsigned long long)vol->mft_zone_end,
+				(unsigned long long)vol->mft_zone_pos,
+				done_zones, (unsigned long long)zone_start,
+				(unsigned long long)zone_end,
+				(unsigned long long)vol->data1_zone_pos);
+	}
+	ntfs_debug("After outer while loop.");
+out:
+	ntfs_debug("At out.");
+	/* Add runlist terminator element. */
+	if (likely(rl)) {
+		rl[rlpos].vcn = rl[rlpos - 1].vcn + rl[rlpos - 1].length;
+		rl[rlpos].lcn = LCN_ENOENT;
+		rl[rlpos].length = 0;
+	}
+	if (likely(page && !IS_ERR(page))) {
+		if (need_writeback) {
+			ntfs_debug("Marking page dirty.");
+			flush_dcache_page(page);
+			set_page_dirty(page);
+			need_writeback = 0;
+		}
+		ntfs_unmap_page(page);
+	}
+	if (likely(!err)) {
+		up_write(&vol->lcnbmp_lock);
+		ntfs_debug("Done.");
+		return rl;
+	}
+	ntfs_error(vol->sb, "Failed to allocate clusters, aborting "
+			"(error %i).", err);
+	if (rl) {
+		int err2;
+
+		if (err == ENOSPC)
+			ntfs_debug("Not enough space to complete allocation, "
+					"err ENOSPC, first free lcn 0x%llx, "
+					"could allocate up to 0x%llx "
+					"clusters.",
+					(unsigned long long)rl[0].lcn,
+					(unsigned long long)count - clusters);
+		/* Deallocate all allocated clusters. */
+		ntfs_debug("Attempting rollback...");
+		err2 = ntfs_cluster_free_from_rl_nolock(vol, rl);
+		if (err2) {
+			ntfs_error(vol->sb, "Failed to rollback (error %i).  "
+					"Leaving inconsistent metadata!  "
+					"Unmount and run chkdsk.", err2);
+			NVolSetErrors(vol);
+		}
+		/* Free the runlist. */
+		ntfs_free(rl);
+	} else if (err == ENOSPC)
+		ntfs_debug("No space left at all, err = ENOSPC, "
+				"first free lcn = 0x%llx.",
+				(unsigned long long)vol->data1_zone_pos);
+	up_write(&vol->lcnbmp_lock);
+	return ERR_PTR(err);
+}
+
+/**
+ * __ntfs_cluster_free - free clusters on an ntfs volume
+ * @vi:		vfs inode whose runlist describes the clusters to free
+ * @start_vcn:	vcn in the runlist of @vi at which to start freeing clusters
+ * @count:	number of clusters to free or -1 for all clusters
+ * @is_rollback:	if TRUE this is a rollback operation
+ *
+ * Free @count clusters starting at the cluster @start_vcn in the runlist
+ * described by the vfs inode @vi.
+ *
+ * If @count is -1, all clusters from @start_vcn to the end of the runlist are
+ * deallocated.  Thus, to completely free all clusters in a runlist, use
+ * @start_vcn = 0 and @count = -1.
+ *
+ * @is_rollback should always be FALSE, it is for internal use to rollback
+ * errors.  You probably want to use ntfs_cluster_free() instead.
+ *
+ * Note, ntfs_cluster_free() does not modify the runlist at all, so the caller
+ * has to deal with it later.
+ *
+ * Return the number of deallocated clusters (not counting sparse ones) on
+ * success and -errno on error.
+ *
+ * Locking: - The runlist described by @vi must be unlocked on entry and is
+ *	      unlocked on return.
+ *	    - This function takes the runlist lock of @vi for reading and
+ *	      sometimes for writing and sometimes modifies the runlist.
+ *	    - The volume lcn bitmap must be unlocked on entry and is unlocked
+ *	      on return.
+ *	    - This function takes the volume lcn bitmap lock for writing and
+ *	      modifies the bitmap contents.
+ */
+s64 __ntfs_cluster_free(struct inode *vi, const VCN start_vcn, s64 count,
+		const BOOL is_rollback)
+{
+	s64 delta, to_free, total_freed, real_freed;
+	ntfs_inode *ni;
+	ntfs_volume *vol;
+	struct inode *lcnbmp_vi;
+	runlist_element *rl;
+	int err;
+
+	BUG_ON(!vi);
+	ntfs_debug("Entering for i_ino 0x%lx, start_vcn 0x%llx, count "
+			"0x%llx.%s", vi->i_ino, (unsigned long long)start_vcn,
+			(unsigned long long)count,
+			is_rollback ? " (rollback)" : "");
+	ni = NTFS_I(vi);
+	vol = ni->vol;
+	lcnbmp_vi = vol->lcnbmp_ino;
+	BUG_ON(!lcnbmp_vi);
+	BUG_ON(start_vcn < 0);
+	BUG_ON(count < -1);
+	/*
+	 * Lock the lcn bitmap for writing but only if not rolling back.  We
+	 * must hold the lock all the way including through rollback otherwise
+	 * rollback is not possible because once we have cleared a bit and
+	 * dropped the lock, anyone could have set the bit again, thus
+	 * allocating the cluster for another use.
+	 */
+	if (likely(!is_rollback))
+		down_write(&vol->lcnbmp_lock);
+
+	total_freed = real_freed = 0;
+
+	/* This returns with ni->runlist locked for reading on success. */
+	rl = ntfs_find_vcn(ni, start_vcn, FALSE);
+	if (IS_ERR(rl)) {
+		if (!is_rollback)
+			ntfs_error(vol->sb, "Failed to find first runlist "
+					"element (error %li), aborting.",
+					PTR_ERR(rl));
+		err = PTR_ERR(rl);
+		goto err_out;
+	}
+	if (unlikely(rl->lcn < (LCN)LCN_HOLE)) {
+		if (!is_rollback)
+			ntfs_error(vol->sb, "First runlist element has "
+					"invalid lcn, aborting.");
+		err = -EIO;
+		goto unl_err_out;
+	}
+	/* Find the starting cluster inside the run that needs freeing. */
+	delta = start_vcn - rl->vcn;
+
+	/* The number of clusters in this run that need freeing. */
+	to_free = rl->length - delta;
+	if (count >= 0 && to_free > count)
+		to_free = count;
+
+	if (likely(rl->lcn >= 0)) {
+		/* Do the actual freeing of the clusters in this run. */
+		err = ntfs_bitmap_set_bits_in_run(lcnbmp_vi, rl->lcn + delta,
+				to_free, likely(!is_rollback) ? 0 : 1);
+		if (unlikely(err)) {
+			if (!is_rollback)
+				ntfs_error(vol->sb, "Failed to clear first run "
+						"(error %i), aborting.", err);
+			goto unl_err_out;
+		}
+		/* We have freed @to_free real clusters. */
+		real_freed = to_free;
+	};
+	/* Go to the next run and adjust the number of clusters left to free. */
+	++rl;
+	if (count >= 0)
+		count -= to_free;
+
+	/* Keep track of the total "freed" clusters, including sparse ones. */
+	total_freed = to_free;
+	/*
+	 * Loop over the remaining runs, using @count as a capping value, and
+	 * free them.
+	 */
+	for (; rl->length && count != 0; ++rl) {
+		if (unlikely(rl->lcn < (LCN)LCN_HOLE)) {
+			VCN vcn;
+
+			/*
+			 * Attempt to map runlist, dropping runlist lock for
+			 * the duration.
+			 */
+			up_read(&ni->runlist.lock);
+			vcn = rl->vcn;
+			err = ntfs_map_runlist(ni, vcn);
+			if (err) {
+				if (!is_rollback)
+					ntfs_error(vol->sb, "Failed to map "
+							"runlist fragment.");
+				if (err == -EINVAL || err == -ENOENT)
+					err = -EIO;
+				goto err_out;
+			}
+			/*
+			 * This returns with ni->runlist locked for reading on
+			 * success.
+			 */
+			rl = ntfs_find_vcn(ni, vcn, FALSE);
+			if (IS_ERR(rl)) {
+				err = PTR_ERR(rl);
+				if (!is_rollback)
+					ntfs_error(vol->sb, "Failed to find "
+							"subsequent runlist "
+							"element.");
+				goto err_out;
+			}
+			if (unlikely(rl->lcn < (LCN)LCN_HOLE)) {
+				if (!is_rollback)
+					ntfs_error(vol->sb, "Runlist element "
+							"has invalid lcn "
+							"(0x%llx).",
+							(unsigned long long)
+							rl->lcn);
+				err = -EIO;
+				goto unl_err_out;
+			}
+		}
+		/* The number of clusters in this run that need freeing. */
+		to_free = rl->length;
+		if (count >= 0 && to_free > count)
+			to_free = count;
+
+		if (likely(rl->lcn >= 0)) {
+			/* Do the actual freeing of the clusters in the run. */
+			err = ntfs_bitmap_set_bits_in_run(lcnbmp_vi, rl->lcn,
+					to_free, likely(!is_rollback) ? 0 : 1);
+			if (unlikely(err)) {
+				if (!is_rollback)
+					ntfs_error(vol->sb, "Failed to clear "
+							"subsequent run.");
+				goto unl_err_out;
+			}
+			/* We have freed @to_free real clusters. */
+			real_freed += to_free;
+		}
+		/* Adjust the number of clusters left to free. */
+		if (count >= 0)
+			count -= to_free;
+	
+		/* Update the total done clusters. */
+		total_freed += to_free;
+	}
+	up_read(&ni->runlist.lock);
+	if (likely(!is_rollback))
+		up_write(&vol->lcnbmp_lock);
+
+	BUG_ON(count > 0);
+
+	/* We are done.  Return the number of actually freed clusters. */
+	ntfs_debug("Done.");
+	return real_freed;
+unl_err_out:
+	up_read(&ni->runlist.lock);
+err_out:
+	if (is_rollback)
+		return err;
+	/* If no real clusters were freed, no need to rollback. */
+	if (!real_freed) {
+		up_write(&vol->lcnbmp_lock);
+		return err;
+	}
+	/*
+	 * Attempt to rollback and if that succeeds just return the error code.
+	 * If rollback fails, set the volume errors flag, emit an error
+	 * message, and return the error code.
+	 */
+	delta = __ntfs_cluster_free(vi, start_vcn, total_freed, TRUE);
+	if (delta < 0) {
+		ntfs_error(vol->sb, "Failed to rollback (error %i).  Leaving "
+				"inconsistent metadata!  Unmount and run "
+				"chkdsk.", (int)delta);
+		NVolSetErrors(vol);
+	}
+	up_write(&vol->lcnbmp_lock);
+	ntfs_error(vol->sb, "Aborting (error %i).", err);
+	return err;
+}
+
+#endif /* NTFS_RW */
diff -Nru a/fs/ntfs/lcnalloc.h b/fs/ntfs/lcnalloc.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/fs/ntfs/lcnalloc.h	2004-08-18 20:50:30 +01:00
@@ -0,0 +1,83 @@
+/*
+ * lcnalloc.h - Exports for NTFS kernel cluster (de)allocation.  Part of the
+ *		Linux-NTFS project.
+ *
+ * Copyright (c) 2004 Anton Altaparmakov
+ *
+ * This program/include file is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program/include file is distributed in the hope that it will be
+ * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program (in the main directory of the Linux-NTFS
+ * distribution in the file COPYING); if not, write to the Free Software
+ * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef _LINUX_NTFS_LCNALLOC_H
+#define _LINUX_NTFS_LCNALLOC_H
+
+#ifdef NTFS_RW
+
+#include <linux/fs.h>
+
+#include "types.h"
+#include "volume.h"
+
+typedef enum {
+	FIRST_ZONE	= 0,	/* For sanity checking. */
+	MFT_ZONE	= 0,	/* Allocate from $MFT zone. */
+	DATA_ZONE	= 1,	/* Allocate from $DATA zone. */
+	LAST_ZONE	= 1,	/* For sanity checking. */
+} NTFS_CLUSTER_ALLOCATION_ZONES;
+
+extern runlist_element *ntfs_cluster_alloc(ntfs_volume *vol,
+		const VCN start_vcn, const s64 count, const LCN start_lcn,
+		const NTFS_CLUSTER_ALLOCATION_ZONES zone);
+
+extern s64 __ntfs_cluster_free(struct inode *vi, const VCN start_vcn,
+		s64 count, const BOOL is_rollback);
+
+/**
+ * ntfs_cluster_free - free clusters on an ntfs volume
+ * @vi:		vfs inode whose runlist describes the clusters to free
+ * @start_vcn:	vcn in the runlist of @vi at which to start freeing clusters
+ * @count:	number of clusters to free or -1 for all clusters
+ *
+ * Free @count clusters starting at the cluster @start_vcn in the runlist
+ * described by the vfs inode @vi.
+ *
+ * If @count is -1, all clusters from @start_vcn to the end of the runlist are
+ * deallocated.  Thus, to completely free all clusters in a runlist, use
+ * @start_vcn = 0 and @count = -1.
+ *
+ * Note, ntfs_cluster_free() does not modify the runlist at all, so the caller
+ * has to deal with it later.
+ *
+ * Return the number of deallocated clusters (not counting sparse ones) on
+ * success and -errno on error.
+ *
+ * Locking: - The runlist described by @vi must be unlocked on entry and is
+ *	      unlocked on return.
+ *	    - This function takes the runlist lock of @vi for reading and
+ *	      sometimes for writing and sometimes modifies the runlist.
+ *	    - The volume lcn bitmap must be unlocked on entry and is unlocked
+ *	      on return.
+ *	    - This function takes the volume lcn bitmap lock for writing and
+ *	      modifies the bitmap contents.
+ */
+static inline s64 ntfs_cluster_free(struct inode *vi, const VCN start_vcn,
+		s64 count)
+{
+	return __ntfs_cluster_free(vi, start_vcn, count, FALSE);
+}
+
+#endif /* NTFS_RW */
+
+#endif /* defined _LINUX_NTFS_LCNALLOC_H */
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-08-18 20:50:30 +01:00
+++ b/fs/ntfs/super.c	2004-08-18 20:50:30 +01:00
@@ -818,37 +818,86 @@
 	vol->serial_no = le64_to_cpu(b->volume_serial_number);
 	ntfs_debug("vol->serial_no = 0x%llx",
 			(unsigned long long)vol->serial_no);
-	/*
-	 * Determine MFT zone size. This is not strictly the right place to do
-	 * this, but I am too lazy to create a function especially for it...
-	 */
-	vol->mft_zone_end = vol->nr_clusters;
+	return TRUE;
+}
+
+/**
+ * setup_lcn_allocator - initialize the cluster allocator
+ * @vol:	volume structure for which to setup the lcn allocator
+ *
+ * Setup the cluster (lcn) allocator to the starting values.
+ */
+static void setup_lcn_allocator(ntfs_volume *vol)
+{
+#ifdef NTFS_RW
+	LCN mft_zone_size, mft_lcn;
+#endif /* NTFS_RW */
+
+	ntfs_debug("vol->mft_zone_multiplier = 0x%x",
+			vol->mft_zone_multiplier);
+#ifdef NTFS_RW
+	/* Determine the size of the MFT zone. */
+	mft_zone_size = vol->nr_clusters;
 	switch (vol->mft_zone_multiplier) {  /* % of volume size in clusters */
 	case 4:
-		vol->mft_zone_end = vol->mft_zone_end >> 1;	/* 50%   */
+		mft_zone_size >>= 1;			/* 50%   */
 		break;
 	case 3:
-		vol->mft_zone_end = (vol->mft_zone_end +
-				(vol->mft_zone_end >> 1)) >> 2;	/* 37.5% */
+		mft_zone_size = (mft_zone_size +
+				(mft_zone_size >> 1)) >> 2;	/* 37.5% */
 		break;
 	case 2:
-		vol->mft_zone_end = vol->mft_zone_end >> 2;	/* 25%   */
+		mft_zone_size >>= 2;			/* 25%   */
 		break;
+	/* case 1: */
 	default:
-		vol->mft_zone_multiplier = 1;
-		/* Fall through into case 1. */
-	case 1:
-		vol->mft_zone_end = vol->mft_zone_end >> 3;	/* 12.5% */
+		mft_zone_size >>= 3;			/* 12.5% */
 		break;
 	}
-	ntfs_debug("vol->mft_zone_multiplier = 0x%x",
-			vol->mft_zone_multiplier);
-	vol->mft_zone_start = vol->mft_lcn;
-	vol->mft_zone_end += vol->mft_lcn;
+	/* Setup the mft zone. */
+	vol->mft_zone_start = vol->mft_zone_pos = vol->mft_lcn;
+	ntfs_debug("vol->mft_zone_pos = 0x%llx",
+			(unsigned long long)vol->mft_zone_pos);
+	/*
+	 * Calculate the mft_lcn for an unmodified NTFS volume (see mkntfs
+	 * source) and if the actual mft_lcn is in the expected place or even
+	 * further to the front of the volume, extend the mft_zone to cover the
+	 * beginning of the volume as well.  This is in order to protect the
+	 * area reserved for the mft bitmap as well within the mft_zone itself.
+	 * On non-standard volumes we do not protect it as the overhead would
+	 * be higher than the speed increase we would get by doing it.
+	 */
+	mft_lcn = (8192 + 2 * vol->cluster_size - 1) / vol->cluster_size;
+	if (mft_lcn * vol->cluster_size < 16 * 1024)
+		mft_lcn = (16 * 1024 + vol->cluster_size - 1) /
+				vol->cluster_size;
+	if (vol->mft_zone_start <= mft_lcn)
+		vol->mft_zone_start = 0;
 	ntfs_debug("vol->mft_zone_start = 0x%llx",
-			(long long)vol->mft_zone_start);
-	ntfs_debug("vol->mft_zone_end = 0x%llx", (long long)vol->mft_zone_end);
-	return TRUE;
+			(unsigned long long)vol->mft_zone_start);
+	/*
+	 * Need to cap the mft zone on non-standard volumes so that it does
+	 * not point outside the boundaries of the volume.  We do this by
+	 * halving the zone size until we are inside the volume.
+	 */
+	vol->mft_zone_end = vol->mft_lcn + mft_zone_size;
+	while (vol->mft_zone_end >= vol->nr_clusters) {
+		mft_zone_size >>= 1;
+		vol->mft_zone_end = vol->mft_lcn + mft_zone_size;
+	}
+	ntfs_debug("vol->mft_zone_end = 0x%llx",
+			(unsigned long long)vol->mft_zone_end);
+	/*
+	 * Set the current position within each data zone to the start of the
+	 * respective zone.
+	 */
+	vol->data1_zone_pos = vol->mft_zone_end;
+	ntfs_debug("vol->data1_zone_pos = 0x%llx",
+			(unsigned long long)vol->data1_zone_pos);
+	vol->data2_zone_pos = 0;
+	ntfs_debug("vol->data2_zone_pos = 0x%llx",
+			(unsigned long long)vol->data2_zone_pos);
+#endif /* NTFS_RW */
 }
 
 #ifdef NTFS_RW
@@ -2195,6 +2244,9 @@
 	 * using it.
 	 */
 	result = parse_ntfs_boot_sector(vol, (NTFS_BOOT_SECTOR*)bh->b_data);
+
+	/* Initialize the cluster allocator. */
+	setup_lcn_allocator(vol);
 
 	brelse(bh);
 
diff -Nru a/fs/ntfs/volume.h b/fs/ntfs/volume.h
--- a/fs/ntfs/volume.h	2004-08-18 20:50:30 +01:00
+++ b/fs/ntfs/volume.h	2004-08-18 20:50:30 +01:00
@@ -73,8 +73,18 @@
 	/* Mount specific NTFS information. */
 	u32 upcase_len;			/* Number of entries in upcase[]. */
 	ntfschar *upcase;		/* The upcase table. */
+
+#ifdef NTFS_RW
+	/* Variables used by the cluster and mft allocators. */
 	LCN mft_zone_start;		/* First cluster of the mft zone. */
 	LCN mft_zone_end;		/* First cluster beyond the mft zone. */
+	LCN mft_zone_pos;		/* Current position in the mft zone. */
+	LCN data1_zone_pos;		/* Current position in the first data
+					   zone. */
+	LCN data2_zone_pos;		/* Current position in the second data
+					   zone. */
+#endif /* NTFS_RW */
+
 	struct inode *mft_ino;		/* The VFS inode of $MFT. */
 
 	struct inode *mftbmp_ino;	/* Attribute inode for $MFT/$BITMAP. */
