Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267653AbUHWKg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267653AbUHWKg2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 06:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267749AbUHWKft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 06:35:49 -0400
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:40649 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267653AbUHWKaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:30:11 -0400
Date: Mon, 23 Aug 2004 11:30:07 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/20] Re: [2.6-BK-URL] NTFS 2.1.17 release
In-Reply-To: <Pine.LNX.4.60.0408231129370.24220@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0408231129530.24220@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0408231055290.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128020.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128550.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129180.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129370.24220@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 5/20 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/07/21 1.1808)
   NTFS: Implement bitmap modification code (fs/ntfs/bitmap.[hc]).  This
         includes functions to set/clear a single bit or a run of bits.
   
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
--- a/fs/ntfs/ChangeLog	2004-08-18 20:50:00 +01:00
+++ b/fs/ntfs/ChangeLog	2004-08-18 20:50:00 +01:00
@@ -1,11 +1,6 @@
 ToDo/Notes:
 	- Find and fix bugs.
 	- Checkpoint or disable the user space journal ($UsnJrnl).
-	- Implement sops->dirty_inode() to implement {a,m,c}time updates and
-	  such things.  This should probably just flag the ntfs inode such that
-	  sops->write_inode(), i.e. ntfs_write_inode(), will copy the times
-	  when it is invoked rather than having to update the mft record
-	  every time.
 	- In between ntfs_prepare/commit_write, need exclusion between
 	  simultaneous file extensions. Need perhaps an NInoResizeUnderway()
 	  flag which we can set in ntfs_prepare_write() and clear again in
@@ -25,6 +20,11 @@
 	  the problem.
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
+
+2.1.17 - WIP.
+
+	- Implement bitmap modification code (fs/ntfs/bitmap.[hc]).  This
+	  includes functions to set/clear a single bit or a run of bits.
 
 2.1.16 - Implement access time updates, file sync, async io, and read/writev.
 
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	2004-08-18 20:50:00 +01:00
+++ b/fs/ntfs/Makefile	2004-08-18 20:50:00 +01:00
@@ -6,7 +6,7 @@
 	     index.o inode.o mft.o mst.o namei.o super.o sysctl.o unistr.o \
 	     upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.16\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.17-WIP\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
@@ -15,5 +15,5 @@
 ifeq ($(CONFIG_NTFS_RW),y)
 EXTRA_CFLAGS += -DNTFS_RW
 
-ntfs-objs += logfile.o quota.o
+ntfs-objs += bitmap.o logfile.o quota.o
 endif
diff -Nru a/fs/ntfs/bitmap.c b/fs/ntfs/bitmap.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/fs/ntfs/bitmap.c	2004-08-18 20:50:00 +01:00
@@ -0,0 +1,183 @@
+/*
+ * bitmap.c - NTFS kernel bitmap handling.  Part of the Linux-NTFS project.
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
+#include <linux/pagemap.h>
+
+#include "bitmap.h"
+#include "debug.h"
+#include "ntfs.h"
+
+/**
+ * __ntfs_bitmap_set_bits_in_run - set a run of bits in a bitmap to a value
+ * @vi:			vfs inode describing the bitmap
+ * @start_bit:		first bit to set
+ * @count:		number of bits to set
+ * @value:		value to set the bits to (i.e. 0 or 1)
+ * @is_rollback:	if TRUE this is a rollback operation
+ *
+ * Set @count bits starting at bit @start_bit in the bitmap described by the
+ * vfs inode @vi to @value, where @value is either 0 or 1.
+ *
+ * @is_rollback should always be FALSE, it is for internal use to rollback
+ * errors.  You probably want to use ntfs_bitmap_set_bits_in_run() instead.
+ *
+ * Return 0 on success and -errno on error.
+ */
+int __ntfs_bitmap_set_bits_in_run(struct inode *vi, const s64 start_bit,
+		const s64 count, const u8 value, const BOOL is_rollback)
+{
+	s64 cnt = count;
+	pgoff_t index, end_index;
+	struct address_space *mapping;
+	struct page *page;
+	u8 *kaddr;
+	int pos, len;
+	u8 bit;
+
+	ntfs_debug("Entering for i_ino 0x%lx, start_bit 0x%llx, count 0x%llx, "
+			"value %u.", vi->i_ino, (unsigned long long)start_bit,
+			(unsigned long long)cnt, (unsigned int)value);
+	BUG_ON(!vi);
+	BUG_ON(start_bit < 0);
+	BUG_ON(cnt < 0);
+	BUG_ON(value > 1);
+	/*
+	 * Calculate the indices for the pages containing the first and last
+	 * bits, i.e. @start_bit and @start_bit + @cnt - 1, respectively.
+	 */
+	index = start_bit >> (3 + PAGE_CACHE_SHIFT);
+	end_index = (start_bit + cnt - 1) >> (3 + PAGE_CACHE_SHIFT);
+
+	/* Get the page containing the first bit (@start_bit). */
+	mapping = vi->i_mapping;
+	page = ntfs_map_page(mapping, index);
+	if (IS_ERR(page)) {
+		if (!is_rollback)
+			ntfs_error(vi->i_sb, "Failed to map first page (error "
+					"%li), aborting.", PTR_ERR(page));
+		return PTR_ERR(page);
+	}
+	kaddr = page_address(page);
+
+	/* Set @pos to the position of the byte containing @start_bit. */
+	pos = (start_bit >> 3) & ~PAGE_CACHE_MASK;
+
+	/* Calculate the position of @start_bit in the first byte. */
+	bit = start_bit & 7;
+
+	/* If the first byte is partial, modify the appropriate bits in it. */
+	if (bit) {
+		u8 *byte = kaddr + pos;
+		while ((bit & 7) && cnt--) {
+			if (value)
+				*byte |= 1 << bit++;
+			else
+				*byte &= ~(1 << bit++);
+		}
+		/* If we are done, unmap the page and return success. */
+		if (!cnt)
+			goto done;
+
+		/* Update @pos to the new position. */
+		pos++;
+	}
+	/*
+	 * Depending on @value, modify all remaining whole bytes in the page up
+	 * to @cnt.
+	 */
+	len = min_t(s64, cnt >> 3, PAGE_CACHE_SIZE - pos);
+	memset(kaddr + pos, value ? 0xff : 0, len);
+	cnt -= len << 3;
+
+	/* Update @len to point to the first not-done byte in the page. */
+	if (cnt < 8)
+		len += pos;
+
+	/* If we are not in the last page, deal with all subsequent pages. */
+	while (end_index > index) {
+		BUG_ON(cnt <= 0);
+
+		/* Update @index and get the next page. */
+		flush_dcache_page(page);
+		set_page_dirty(page);
+		ntfs_unmap_page(page);
+		page = ntfs_map_page(mapping, ++index);
+		if (IS_ERR(page))
+			goto rollback;
+		kaddr = page_address(page);
+		/*
+		 * Depending on @value, modify all remaining whole bytes in the
+		 * page up to @cnt.
+		 */
+		len = min_t(s64, cnt >> 3, PAGE_CACHE_SIZE);
+		memset(kaddr, value ? 0xff : 0, len);
+		cnt -= len << 3;
+	}
+	/*
+	 * The currently mapped page is the last one.  If the last byte is
+	 * partial, modify the appropriate bits in it.  Note, @len is the
+	 * position of the last byte inside the page.
+	 */
+	if (cnt) {
+		u8 *byte;
+
+		BUG_ON(cnt > 7);
+
+		bit = cnt;
+		byte = kaddr + len;
+		while (bit--) {
+			if (value)
+				*byte |= 1 << bit;
+			else
+				*byte &= ~(1 << bit);
+		}
+	}
+done:
+	/* We are done.  Unmap the page and return success. */
+	flush_dcache_page(page);
+	set_page_dirty(page);
+	ntfs_unmap_page(page);
+	ntfs_debug("Done.");
+	return 0;
+rollback:
+	/*
+	 * Current state:
+	 *	- no pages are mapped
+	 *	- @count - @cnt is the number of bits that have been modified
+	 */
+	if (is_rollback)
+		return PTR_ERR(page);
+	pos = __ntfs_bitmap_set_bits_in_run(vi, start_bit, count - cnt,
+			value ? 0 : 1, TRUE);
+	if (!pos) {
+		/* Rollback was successful. */
+		ntfs_error(vi->i_sb, "Failed to map subsequent page (error "
+				"%li), aborting.", PTR_ERR(page));
+	} else {
+		/* Rollback failed. */
+		ntfs_error(vi->i_sb, "Failed to map subsequent page (error "
+				"%li) and rollback failed (error %i).  "
+				"Aborting and leaving inconsistent metadata.  "
+				"Unmount and run chkdsk.", PTR_ERR(page), pos);
+		NVolSetErrors(NTFS_SB(vi->i_sb));
+	}
+	return PTR_ERR(page);
+}
diff -Nru a/fs/ntfs/bitmap.h b/fs/ntfs/bitmap.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/fs/ntfs/bitmap.h	2004-08-18 20:50:00 +01:00
@@ -0,0 +1,114 @@
+/*
+ * bitmap.h - Defines for NTFS kernel bitmap handling.  Part of the Linux-NTFS
+ *	      project.
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
+#ifndef _LINUX_NTFS_BITMAP_H
+#define _LINUX_NTFS_BITMAP_H
+
+#include <linux/fs.h>
+
+#include "types.h"
+
+extern int __ntfs_bitmap_set_bits_in_run(struct inode *vi, const s64 start_bit,
+		const s64 count, const u8 value, const BOOL is_rollback);
+
+/**
+ * ntfs_bitmap_set_bits_in_run - set a run of bits in a bitmap to a value
+ * @vi:			vfs inode describing the bitmap
+ * @start_bit:		first bit to set
+ * @count:		number of bits to set
+ * @value:		value to set the bits to (i.e. 0 or 1)
+ *
+ * Set @count bits starting at bit @start_bit in the bitmap described by the
+ * vfs inode @vi to @value, where @value is either 0 or 1.
+ *
+ * Return 0 on success and -errno on error.
+ */
+static inline int ntfs_bitmap_set_bits_in_run(struct inode *vi,
+		const s64 start_bit, const s64 count, const u8 value)
+{
+	return __ntfs_bitmap_set_bits_in_run(vi, start_bit, count, value,
+			FALSE);
+}
+
+/**
+ * ntfs_bitmap_set_run - set a run of bits in a bitmap
+ * @vi:		vfs inode describing the bitmap
+ * @start_bit:	first bit to set
+ * @count:	number of bits to set
+ *
+ * Set @count bits starting at bit @start_bit in the bitmap described by the
+ * vfs inode @vi.
+ *
+ * Return 0 on success and -errno on error.
+ */
+static inline int ntfs_bitmap_set_run(struct inode *vi, const s64 start_bit,
+		const s64 count)
+{
+	return ntfs_bitmap_set_bits_in_run(vi, start_bit, count, 1);
+}
+
+/**
+ * ntfs_bitmap_clear_run - clear a run of bits in a bitmap
+ * @vi:		vfs inode describing the bitmap
+ * @start_bit:	first bit to clear
+ * @count:	number of bits to clear
+ *
+ * Clear @count bits starting at bit @start_bit in the bitmap described by the
+ * vfs inode @vi.
+ *
+ * Return 0 on success and -errno on error.
+ */
+static inline int ntfs_bitmap_clear_run(struct inode *vi, const s64 start_bit,
+		const s64 count)
+{
+	return ntfs_bitmap_set_bits_in_run(vi, start_bit, count, 0);
+}
+
+/**
+ * ntfs_bitmap_set_bit - set a bit in a bitmap
+ * @vi:		vfs inode describing the bitmap
+ * @bit:	bit to set
+ *
+ * Set bit @bit in the bitmap described by the vfs inode @vi.
+ *
+ * Return 0 on success and -errno on error.
+ */
+static inline int ntfs_bitmap_set_bit(struct inode *vi, const s64 bit)
+{
+	return ntfs_bitmap_set_run(vi, bit, 1);
+}
+
+/**
+ * ntfs_bitmap_clear_bit - clear a bit in a bitmap
+ * @vi:		vfs inode describing the bitmap
+ * @bit:	bit to clear
+ *
+ * Clear bit @bit in the bitmap described by the vfs inode @vi.
+ *
+ * Return 0 on success and -errno on error.
+ */
+static inline int ntfs_bitmap_clear_bit(struct inode *vi, const s64 bit)
+{
+	return ntfs_bitmap_clear_run(vi, bit, 1);
+}
+
+#endif /* defined _LINUX_NTFS_BITMAP_H */
