Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265049AbUFHLpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265049AbUFHLpQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 07:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265054AbUFHLpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 07:45:15 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:39871 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265049AbUFHLox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 07:44:53 -0400
Date: Tue, 8 Jun 2004 12:44:52 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
       Pawel Kot <pkot@bezsensu.pl>
Subject: Re: [2.6.7-BK] NTFS 2.1.13 patch 2/8
In-Reply-To: <Pine.SOL.4.58.0406081243060.21854@orange.csi.cam.ac.uk>
Message-ID: <Pine.SOL.4.58.0406081244330.21854@orange.csi.cam.ac.uk>
References: <Pine.SOL.4.58.0406081236450.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081243060.21854@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 2 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/05/28 1.1737)
   NTFS: Commit open system inodes at umount time.  This should make it
         virtually impossible for sync_mft_mirror_umount() to ever be needed.

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
--- a/fs/ntfs/ChangeLog	2004-06-08 12:22:07 +01:00
+++ b/fs/ntfs/ChangeLog	2004-06-08 12:22:07 +01:00
@@ -39,6 +39,8 @@
 	  implementation is quite rudimentary for now with lots of things not
 	  implemented yet but I am not sure any of them can actually occur so
 	  I will wait for people to hit each one and only then implement it.
+	- Commit open system inodes at umount time.  This should make it
+	  virtually impossible for sync_mft_mirror_umount() to ever be needed.

 2.1.12 - Fix the second fix to the decompression engine and some cleanups.

diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-06-08 12:22:07 +01:00
+++ b/fs/ntfs/super.c	2004-06-08 12:22:07 +01:00
@@ -1302,6 +1302,38 @@

 	ntfs_debug("Entering.");

+#ifdef NTFS_RW
+	/*
+	 * Commit all inodes while they are still open in case some of them
+	 * cause others to be dirtied.
+	 */
+	ntfs_commit_inode(vol->vol_ino);
+
+	/* NTFS 3.0+ specific. */
+	if (vol->major_ver >= 3) {
+		if (vol->secure_ino)
+			ntfs_commit_inode(vol->secure_ino);
+	}
+
+	ntfs_commit_inode(vol->root_ino);
+
+	down_write(&vol->lcnbmp_lock);
+	ntfs_commit_inode(vol->lcnbmp_ino);
+	up_write(&vol->lcnbmp_lock);
+
+	down_write(&vol->mftbmp_lock);
+	ntfs_commit_inode(vol->mftbmp_ino);
+	up_write(&vol->mftbmp_lock);
+
+	if (vol->logfile_ino)
+		ntfs_commit_inode(vol->logfile_ino);
+
+	if (vol->mftmirr_ino)
+		ntfs_commit_inode(vol->mftmirr_ino);
+
+	ntfs_commit_inode(vol->mft_ino);
+#endif /* NTFS_RW */
+
 	iput(vol->vol_ino);
 	vol->vol_ino = NULL;

@@ -1333,6 +1365,9 @@
 	}

 	if (vol->mftmirr_ino) {
+		/* Re-commit the mft mirror and mft just in case. */
+		ntfs_commit_inode(vol->mftmirr_ino);
+		ntfs_commit_inode(vol->mft_ino);
 		iput(vol->mftmirr_ino);
 		vol->mftmirr_ino = NULL;
 	}
