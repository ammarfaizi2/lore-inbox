Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266151AbRGSXBf>; Thu, 19 Jul 2001 19:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266150AbRGSXBQ>; Thu, 19 Jul 2001 19:01:16 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:31737 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S266130AbRGSXA6>; Thu, 19 Jul 2001 19:00:58 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107192259.f6JMxTNL032622@webber.adilger.int>
Subject: [PATCH] minor UFS fixups
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com
Date: Thu, 19 Jul 2001 16:59:28 -0600 (MDT)
CC: Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello,
this patch was inspired by the Stanford checker (the report was sent out a
while ago, but I'm just getting around to submitting the patch).

They pointed out two instances of dereferencing potentially NULL pointers
in the UFS code, one of which was valid, and the other was incorrect (so
the extra check is just overhead).

The change in parse_options() is actually avoiding NULL dereference of
the "value" if a value was not given.  This is a bug.

The change in ufs_check_dir_entry() removes redundant checks for "dir"
(redundant because ufs_check_dir_entry() already dereferences dir before
the checks are made, and the "dir" parameter is valid in the caller).
It also creates a local variable to avoid repeated endian swapping in
this often-used function.  This is all just runtime overhead, not a bug.

Note that it doesn't _appear_ that the change to ufs_check_dir_entry()
conflicts with Al's changes in -ac, so the same patch should apply to
both 2.4.7-pre8 and 2.4.6-ac5 kernels.

Cheers, Andreas
==================  ufs-2.4.6-checker.diff ================================
diff -ru linux-2.4.6.orig/fs/ufs/super.c linux-2.4.6-aed/fs/ufs/super.c
--- linux-2.4.6.orig/fs/ufs/super.c	Tue May 29 13:13:21 2001
+++ linux-2.4.6-aed/fs/ufs/super.c	Tue May 29 20:14:02 2001
@@ -265,6 +265,10 @@
 			*value++ = 0;
 		if (!strcmp (this_char, "ufstype")) {
 			ufs_clear_opt (*mount_options, UFSTYPE);
+			if (!value) {
+				printk ("UFS-fs: ufstype option needs value\n");
+				return 0;
+			}
 			if (!strcmp (value, "old"))
 				ufs_set_opt (*mount_options, UFSTYPE_OLD);
 			else if (!strcmp (value, "sun"))
@@ -288,6 +292,10 @@
 		}
 		else if (!strcmp (this_char, "onerror")) {
 			ufs_clear_opt (*mount_options, ONERROR);
+			if (!value) {
+				printk ("UFS-fs: onerror option needs value\n");
+				return 0;
+			}
 			if (!strcmp (value, "panic"))
 				ufs_set_opt (*mount_options, ONERROR_PANIC);
 			else if (!strcmp (value, "lock"))
diff -ru linux-2.4.6.orig/fs/ufs/dir.c linux-2.4.6-aed/fs/ufs/dir.c
--- linux-2.4.6.orig/fs/ufs/dir.c	Fri Aug 11 15:29:02 2000
+++ linux-2.4.6-aed/fs/ufs/dir.c	Thu Jul 19 16:54:14 2001
@@ -149,34 +149,32 @@
 	struct ufs_dir_entry * de, struct buffer_head * bh, 
 	unsigned long offset)
 {
-	struct super_block * sb;
-	const char * error_msg;
-	unsigned flags, swab;
-	
-	sb = dir->i_sb;
-	flags = sb->u.ufs_sb.s_flags;
-	swab = sb->u.ufs_sb.s_swab;
-	error_msg = NULL;
-			
-	if (SWAB16(de->d_reclen) < UFS_DIR_REC_LEN(1))
+	struct super_block *sb = dir->i_sb;
+	const char *error_msg = NULL;
+	unsigned flags = sb->u.ufs_sb.s_flags;
+	unsigned swab = sb->u.ufs_sb.s_swab;
+	int rlen = SWAB16(de->d_reclen);
+
+	if (rlen < UFS_DIR_REC_LEN(1))
 		error_msg = "reclen is smaller than minimal";
-	else if (SWAB16(de->d_reclen) % 4 != 0)
+	else if (rlen % 4 != 0)
 		error_msg = "reclen % 4 != 0";
-	else if (SWAB16(de->d_reclen) < UFS_DIR_REC_LEN(ufs_get_de_namlen(de)))
+	else if (rlen < UFS_DIR_REC_LEN(ufs_get_de_namlen(de)))
 		error_msg = "reclen is too small for namlen";
-	else if (dir && ((char *) de - bh->b_data) + SWAB16(de->d_reclen) >
-		 dir->i_sb->s_blocksize)
+	else if (((char *) de - bh->b_data) + rlen > dir->i_sb->s_blocksize)
 		error_msg = "directory entry across blocks";
-	else if (dir && SWAB32(de->d_ino) > (sb->u.ufs_sb.s_uspi->s_ipg * sb->u.ufs_sb.s_uspi->s_ncg))
+	else if (SWAB32(de->d_ino) > (sb->u.ufs_sb.s_uspi->s_ipg *
+				      sb->u.ufs_sb.s_uspi->s_ncg))
 		error_msg = "inode out of bounds";
 
 	if (error_msg != NULL)
-		ufs_error (sb, function, "bad entry in directory #%lu, size %Lu: %s - "
+		ufs_error (sb, function,
+			   "bad entry in directory #%lu, size %Lu: %s - "
 			    "offset=%lu, inode=%lu, reclen=%d, namlen=%d",
 			    dir->i_ino, dir->i_size, error_msg, offset,
 			    (unsigned long) SWAB32(de->d_ino),
-			    SWAB16(de->d_reclen), ufs_get_de_namlen(de));
-	
+			    rlen, ufs_get_de_namlen(de));
+
 	return (error_msg == NULL ? 1 : 0);
 }
 
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
