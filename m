Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268108AbUJSJjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268108AbUJSJjg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268117AbUJSJjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:39:35 -0400
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:13537 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268108AbUJSJjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:39:05 -0400
Date: Tue, 19 Oct 2004 10:38:55 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 1/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191038250.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 1/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/29 1.1995.1.2)
   NTFS: Implement extent mft record deallocation.
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:13:07 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:13:07 +01:00
@@ -21,6 +21,11 @@
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
+2.1.20-WIP
+
+	- Implement extent mft record deallocation
+	  fs/ntfs/mft.c::ntfs_extent_mft_record_free().
+
 2.1.19 - Many cleanups, improvements, and a minor bug fix.
 
 	- Update ->setattr (fs/ntfs/inode.c::ntfs_setattr()) to refuse to
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	2004-10-19 10:13:07 +01:00
+++ b/fs/ntfs/Makefile	2004-10-19 10:13:07 +01:00
@@ -6,7 +6,7 @@
 	     index.o inode.o mft.o mst.o namei.o super.o sysctl.o unistr.o \
 	     upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.19\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.20-WIP\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-10-19 10:13:07 +01:00
+++ b/fs/ntfs/mft.c	2004-10-19 10:13:07 +01:00
@@ -23,6 +23,7 @@
 #include <linux/swap.h>
 
 #include "ntfs.h"
+#include "bitmap.h"
 
 /**
  * __format_mft_record - initialize an empty mft record
@@ -1095,4 +1096,159 @@
 	return 0;
 }
 
+static const char *es = "  Leaving inconsistent metadata.  Unmount and run "
+		"chkdsk.";
+
+/**
+ * ntfs_extent_mft_record_free - free an extent mft record on an ntfs volume
+ * @ni:		ntfs inode of the mapped extent mft record to free
+ * @m:		mapped extent mft record of the ntfs inode @ni
+ *
+ * Free the mapped extent mft record @m of the extent ntfs inode @ni.
+ *
+ * Note that this function unmaps the mft record and closes and destroys @ni
+ * internally and hence you cannot use either @ni nor @m any more after this
+ * function returns success.
+ *
+ * On success return 0 and on error return -errno.  @ni and @m are still valid
+ * in this case and have not been freed.
+ *
+ * For some errors an error message is displayed and the success code 0 is
+ * returned and the volume is then left dirty on umount.  This makes sense in
+ * case we could not rollback the changes that were already done since the
+ * caller no longer wants to reference this mft record so it does not matter to
+ * the caller if something is wrong with it as long as it is properly detached
+ * from the base inode.
+ */
+int ntfs_extent_mft_record_free(ntfs_inode *ni, MFT_RECORD *m)
+{
+	unsigned long mft_no = ni->mft_no;
+	ntfs_volume *vol = ni->vol;
+	ntfs_inode *base_ni;
+	ntfs_inode **extent_nis;
+	int i, err;
+	le16 old_seq_no;
+	u16 seq_no;
+	
+	BUG_ON(NInoAttr(ni));
+	BUG_ON(ni->nr_extents != -1);
+
+	down(&ni->extent_lock);
+	base_ni = ni->ext.base_ntfs_ino;
+	up(&ni->extent_lock);
+
+	BUG_ON(base_ni->nr_extents <= 0);
+
+	ntfs_debug("Entering for extent inode 0x%lx, base inode 0x%lx.\n",
+			mft_no, base_ni->mft_no);
+
+	down(&base_ni->extent_lock);
+
+	/* Make sure we are holding the only reference to the extent inode. */
+	if (atomic_read(&ni->count) > 2) {
+		ntfs_error(vol->sb, "Tried to free busy extent inode 0x%lx, "
+				"not freeing.", base_ni->mft_no);
+		up(&base_ni->extent_lock);
+		return -EBUSY;
+	}
+
+	/* Dissociate the ntfs inode from the base inode. */
+	extent_nis = base_ni->ext.extent_ntfs_inos;
+	err = -ENOENT;
+	for (i = 0; i < base_ni->nr_extents; i++) {
+		if (ni != extent_nis[i])
+			continue;
+		extent_nis += i;
+		base_ni->nr_extents--;
+		memmove(extent_nis, extent_nis + 1, (base_ni->nr_extents - i) *
+				sizeof(ntfs_inode*));
+		err = 0;
+		break;
+	}
+
+	up(&base_ni->extent_lock);
+
+	if (unlikely(err)) {
+		ntfs_error(vol->sb, "Extent inode 0x%lx is not attached to "
+				"its base inode 0x%lx.", mft_no,
+				base_ni->mft_no);
+		BUG();
+	}
+
+	/*
+	 * The extent inode is no longer attached to the base inode so no one
+	 * can get a reference to it any more.
+	 */
+
+	/* Mark the mft record as not in use. */
+	m->flags &= const_cpu_to_le16(~const_le16_to_cpu(MFT_RECORD_IN_USE));
+
+	/* Increment the sequence number, skipping zero, if it is not zero. */
+	old_seq_no = m->sequence_number;
+	seq_no = le16_to_cpu(old_seq_no);
+	if (seq_no == 0xffff)
+		seq_no = 1;
+	else if (seq_no)
+		seq_no++;
+	m->sequence_number = cpu_to_le16(seq_no);
+
+	/*
+	 * Set the ntfs inode dirty and write it out.  We do not need to worry
+	 * about the base inode here since whatever caused the extent mft
+	 * record to be freed is guaranteed to do it already.
+	 */
+	NInoSetDirty(ni);
+	err = write_mft_record(ni, m, 0);
+	if (unlikely(err)) {
+		ntfs_error(vol->sb, "Failed to write mft record 0x%lx, not "
+				"freeing.", mft_no);
+		goto rollback;
+	}
+rollback_error:
+	/* Unmap and throw away the now freed extent inode. */
+	unmap_extent_mft_record(ni);
+	ntfs_clear_extent_inode(ni);
+
+	/* Clear the bit in the $MFT/$BITMAP corresponding to this record. */
+	err = ntfs_bitmap_clear_bit(vol->mftbmp_ino, mft_no);
+	if (unlikely(err)) {
+		/*
+		 * The extent inode is gone but we failed to deallocate it in
+		 * the mft bitmap.  Just emit a warning and leave the volume
+		 * dirty on umount.
+		 */
+		ntfs_error(vol->sb, "Failed to clear bit in mft bitmap.%s", es);
+		NVolSetErrors(vol);
+	}
+	return 0;
+rollback:
+	/* Rollback what we did... */
+	down(&base_ni->extent_lock);
+	extent_nis = base_ni->ext.extent_ntfs_inos;
+	if (!(base_ni->nr_extents & 3)) {
+		int new_size = (base_ni->nr_extents + 4) * sizeof(ntfs_inode*);
+
+		extent_nis = (ntfs_inode**)kmalloc(new_size, GFP_NOFS);
+		if (unlikely(!extent_nis)) {
+			ntfs_error(vol->sb, "Failed to allocate internal "
+					"buffer during rollback.%s", es);
+			up(&base_ni->extent_lock);
+			NVolSetErrors(vol);
+			goto rollback_error;
+		}
+		if (base_ni->nr_extents) {
+			BUG_ON(!base_ni->ext.extent_ntfs_inos);
+			memcpy(extent_nis, base_ni->ext.extent_ntfs_inos,
+					new_size - 4 * sizeof(ntfs_inode*));
+			kfree(base_ni->ext.extent_ntfs_inos);
+		}
+		base_ni->ext.extent_ntfs_inos = extent_nis;
+	}
+	m->flags |= MFT_RECORD_IN_USE;
+	m->sequence_number = old_seq_no;
+	extent_nis[base_ni->nr_extents++] = ni;
+	up(&base_ni->extent_lock);
+	mark_mft_record_dirty(ni);
+	return err;
+}
 #endif /* NTFS_RW */
diff -Nru a/fs/ntfs/mft.h b/fs/ntfs/mft.h
--- a/fs/ntfs/mft.h	2004-10-19 10:13:07 +01:00
+++ b/fs/ntfs/mft.h	2004-10-19 10:13:07 +01:00
@@ -111,6 +111,8 @@
 	return err;
 }
 
+extern int ntfs_extent_mft_record_free(ntfs_inode *ni, MFT_RECORD *m);
+
 #endif /* NTFS_RW */
 
 #endif /* _LINUX_NTFS_MFT_H */
