Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278700AbRJ1WMu>; Sun, 28 Oct 2001 17:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278702AbRJ1WMk>; Sun, 28 Oct 2001 17:12:40 -0500
Received: from [63.231.122.81] ([63.231.122.81]:24378 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S278701AbRJ1WMd>;
	Sun, 28 Oct 2001 17:12:33 -0500
Date: Sun, 28 Oct 2001 01:36:42 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] minor UFS cleanup
Message-ID: <20011028013642.D4229@lynx.no>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
a minor cleanup of the UFS code, originally inspired by the Stanford checker.
They found that "dir" was being checked for non-NULLness after it was being
dereferenced.

I also added a local variable for rlen, because SWAB16 cannot be removed
at compile time for either little- or big-endian systems.

The second hunk is again from the Stanford checker, avoiding NULL dereference.

Cheers, Andreas
=============================================================================
diff -ru linux.orig/fs/ufs/dir.c linux/fs/ufs/dir.c
--- linux.orig/fs/ufs/dir.c	Thu Oct 25 03:05:12 2001
+++ linux/fs/ufs/dir.c	Thu Oct 25 02:55:49 2001
@@ -290,34 +290,32 @@
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
 
diff -ru linux.orig/fs/ufs/super.c linux/fs/ufs/super.c
--- linux.orig/fs/ufs/super.c	Tue May 29 13:13:21 2001
+++ linux/fs/ufs/super.c	Tue May 29 20:14:02 2001
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
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

