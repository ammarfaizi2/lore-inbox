Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129732AbQLMIpH>; Wed, 13 Dec 2000 03:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129730AbQLMIo5>; Wed, 13 Dec 2000 03:44:57 -0500
Received: from [24.65.192.120] ([24.65.192.120]:36599 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S129524AbQLMIov>;
	Wed, 13 Dec 2000 03:44:51 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200012130814.eBD8ELc10852@webber.adilger.net>
Subject: [PATCH] 2.2.18 ext2 large file bug?
To: Ext2 development mailing list <ext2-devel@lists.sourceforge.net>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
Date: Wed, 13 Dec 2000 01:14:21 -0700 (MST)
CC: Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
while looking at the COMPAT flag patches I made, I noticed the following
in the ext2/ext3 code.  I believe that this bug is fixed in 2.4, but it
also needs to be fixed in 2.2.  Basically, we are checking for an ext2
large file, which would be a file > 2GB on systems that don't support
such.  However, we are checking for a file > 8GB which is clearly wrong.
The ext3 version of the patch is also attached.

Cheers, Andreas
==========================================================================
--- linux-2.2.18pre27-TL/fs/ext2/file.c.orig	Mon Dec 11 22:43:17 2000
+++ linux-2.2.18pre27-TL/fs/ext2/file.c	Wed Dec 13 00:13:00 2000
@@ -208,7 +208,7 @@
 			if (!count)
 				return -EFBIG;
 		}
-		if (((pos + count) >> 31) &&
+		if (((pos + count) >> 33) &&
 		    !(sb->u.ext2_sb.s_es->s_feature_ro_compat &
 		      cpu_to_le32(EXT2_FEATURE_RO_COMPAT_LARGE_FILE))) {
 			/* If this is the first large file created, add a flag

--- linux-2.2.18pre27-TL/fs/ext3/file.c.orig	Mon Dec 11 22:43:17 2000
+++ linux-2.2.18pre27-TL/fs/ext3/file.c	Wed Dec 13 00:13:00 2000
@@ -208,7 +208,7 @@
 			if (!count)
 				return -EFBIG;
 		}
-		if (((pos + count) >> 31) &&
+		if (((pos + count) >> 33) &&
 		    !EXT3_HAS_RO_COMPAT_FEATURE(sb,
 					EXT3_FEATURE_RO_COMPAT_LARGE_FILE)) {
 			/* If this is the first large file created, add a flag
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
