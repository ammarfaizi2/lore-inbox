Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265188AbUFHLwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265188AbUFHLwO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 07:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUFHLv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 07:51:28 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:59071 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265067AbUFHLqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 07:46:32 -0400
Date: Tue, 8 Jun 2004 12:46:32 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
       Pawel Kot <pkot@bezsensu.pl>
Subject: Re: [2.6.7-BK] NTFS 2.1.13 patch 7/8
In-Reply-To: <Pine.SOL.4.58.0406081245500.21854@orange.csi.cam.ac.uk>
Message-ID: <Pine.SOL.4.58.0406081246070.21854@orange.csi.cam.ac.uk>
References: <Pine.SOL.4.58.0406081236450.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081243060.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081244330.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081244580.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081245130.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081245290.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081245500.21854@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 7 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/06/07 1.1748)
   NTFS: Add functions ntfs_{clear,set}_volume_flags(), to modify the volume
         information flags (fs/ntfs/super.c).

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
--- a/fs/ntfs/ChangeLog	2004-06-08 12:22:21 +01:00
+++ b/fs/ntfs/ChangeLog	2004-06-08 12:22:21 +01:00
@@ -68,6 +68,8 @@
 	  alowing the VM to do with the page as it pleases.  Also, at umount
 	  time, now only throw away dirty mft (meta)data pages if dirty inodes
 	  are present and ask the user to email us if they see this happening.
+	- Add functions ntfs_{clear,set}_volume_flags(), to modify the volume
+	  information flags (fs/ntfs/super.c).

 2.1.12 - Fix the second fix to the decompression engine and some cleanups.

diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-06-08 12:22:21 +01:00
+++ b/fs/ntfs/super.c	2004-06-08 12:22:21 +01:00
@@ -291,6 +291,101 @@
 	return FALSE;
 }

+#ifdef NTFS_RW
+
+/**
+ * ntfs_write_volume_flags - write new flags to the volume information flags
+ * @vol:	ntfs volume on which to modify the flags
+ * @flags:	new flags value for the volume information flags
+ *
+ * Internal function.  You probably want to use ntfs_{set,clear}_volume_flags()
+ * instead (see below).
+ *
+ * Replace the volume information flags on the volume @vol with the value
+ * supplied in @flags.  Note, this overwrites the volume information flags, so
+ * make sure to combine the flags you want to modify with the old flags and use
+ * the result when calling ntfs_write_volume_flags().
+ *
+ * Return 0 on success and -errno on error.
+ */
+static int ntfs_write_volume_flags(ntfs_volume *vol, const VOLUME_FLAGS flags)
+{
+	ntfs_inode *ni = NTFS_I(vol->vol_ino);
+	MFT_RECORD *m;
+	VOLUME_INFORMATION *vi;
+	attr_search_context *ctx;
+	int err;
+
+	ntfs_debug("Entering, old flags = 0x%x, new flags = 0x%x.",
+			vol->vol_flags, flags);
+	if (vol->vol_flags == flags)
+		goto done;
+	BUG_ON(!ni);
+	m = map_mft_record(ni);
+	if (IS_ERR(m)) {
+		err = PTR_ERR(m);
+		goto err_out;
+	}
+	ctx = get_attr_search_ctx(ni, m);
+	if (!ctx) {
+		err = -ENOMEM;
+		goto put_unm_err_out;
+	}
+	if (!lookup_attr(AT_VOLUME_INFORMATION, NULL, 0, 0, 0, NULL, 0, ctx)) {
+		err = -EIO;
+		goto put_unm_err_out;
+	}
+	vi = (VOLUME_INFORMATION*)((u8*)ctx->attr +
+			le16_to_cpu(ctx->attr->data.resident.value_offset));
+	vol->vol_flags = vi->flags = flags;
+	flush_dcache_mft_record_page(ctx->ntfs_ino);
+	mark_mft_record_dirty(ctx->ntfs_ino);
+	put_attr_search_ctx(ctx);
+	unmap_mft_record(ni);
+done:
+	ntfs_debug("Done.");
+	return 0;
+put_unm_err_out:
+	if (ctx)
+		put_attr_search_ctx(ctx);
+	unmap_mft_record(ni);
+err_out:
+	ntfs_error(vol->sb, "Failed with error code %i.", -err);
+	return err;
+}
+
+/**
+ * ntfs_set_volume_flags - set bits in the volume information flags
+ * @vol:	ntfs volume on which to modify the flags
+ * @flags:	flags to set on the volume
+ *
+ * Set the bits in @flags in the volume information flags on the volume @vol.
+ *
+ * Return 0 on success and -errno on error.
+ */
+static inline int ntfs_set_volume_flags(ntfs_volume *vol, VOLUME_FLAGS flags)
+{
+	flags &= VOLUME_FLAGS_MASK;
+	return ntfs_write_volume_flags(vol, vol->vol_flags | flags);
+}
+
+/**
+ * ntfs_clear_volume_flags - clear bits in the volume information flags
+ * @vol:	ntfs volume on which to modify the flags
+ * @flags:	flags to clear on the volume
+ *
+ * Clear the bits in @flags in the volume information flags on the volume @vol.
+ *
+ * Return 0 on success and -errno on error.
+ */
+static inline int ntfs_clear_volume_flags(ntfs_volume *vol, VOLUME_FLAGS flags)
+{
+	flags &= VOLUME_FLAGS_MASK;
+	return ntfs_write_volume_flags(vol, vol->vol_flags & ~flags);
+}
+
+#endif /* NTFS_RW */
+
 /**
  * ntfs_remount - change the mount options of a mounted ntfs filesystem
  * @sb:		superblock of mounted ntfs filesystem
