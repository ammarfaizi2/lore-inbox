Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315133AbSD2MO4>; Mon, 29 Apr 2002 08:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315137AbSD2MOz>; Mon, 29 Apr 2002 08:14:55 -0400
Received: from krynn.axis.se ([193.13.178.10]:42633 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S315133AbSD2MOx>;
	Mon, 29 Apr 2002 08:14:53 -0400
Date: Mon, 29 Apr 2002 13:54:31 +0200 (CEST)
From: Johan Adolfsson <johan.adolfsson@axis.com>
X-X-Sender: <johana@ado-2.axis.se>
To: <quinlan@transmeta.com>, <marcelo@conectiva.com.br>,
        <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>, Johan Adolfsson <johan.adolfsson@axis.com>
Subject: [PATCH] cramfs 1/6 - timestamp in includes
Message-ID: <Pine.LNX.4.33.0204291326230.25892-100000@ado-2.axis.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here comes a couple of patches to improve and fix problems in cramfs and
the tools mkcramfs and cramfsck.
The patches will be in seperate mails as below and are against
2.4.19-pre7 or the latest version from
http://sourceforge.net/projects/cramfs/
but will probably apply to 2.5 as well (and it really should go in there
as well).

1. Support for fstime and EDITION_TIMESTAMP in cramfs include files.
   Uses the edition field in fsid if the CRAMFS_FLAG_EDITION_TIMESTAMP
   flag is set.
2. Support for fstime in fs/cramfs/inode.c together with
   fixing hardcoded blocksize conversion
   (Now uses /(PAGE_CACHE_SIZE/1024) instead of >> 2).

3. The tools: mkcramfs.c and cramfsck.c: Add support for timestamp in the
   edition field (fstime) and added the option -b blocksize.
   For cramfsck.c it also fixes a segfault that occured in the error
   message if the incorrect blocksize is used (order of arguments wrong).

4. The tools: mkcramfs.c gets added support for -m metafile option.
5. linux/Documentation/filesystems/metafiles.txt added that describes the
   metafile format used in mkcramfs.

6. (RFC) In the cris architecture we have a hack that allows us
   to append the cramfs image to the kernel image and use it to boot from.
   We support both booting from flash where the kernel image is compressed
   and the cramfs image is in flash and booting directly from RAM using
   the image downloaded through the network interface - in that case the
   kernel is not compressed and the cramfs image is in RAM after the kernel.
   A special variable is used to determine which mode is used and
   if we're booting from RAM, the cramfs is not read through a real
   device.
   I'll submit the patch for your amusement and welcomes any feedback.
   An alternative approach could be to use a mtd-ram device but I don't
   know how yet.
   cram_fs_type and the read function should not be static since it is
   accessed from do_mounts.c

/Johan


--- linux-2.4.19-pre7/include/linux/cramfs_fs.h	Mon Apr 29 10:11:54 2002
+++ linux/include/linux/cramfs_fs.h	Thu Apr 25 23:01:50 2002
@@ -49,7 +49,7 @@

 struct cramfs_info {
 	u32 crc;
-	u32 edition;
+	u32 edition;	/* contains timestamp if EDITION_TIMESTAMP flag set */
 	u32 blocks;
 	u32 files;
 };
@@ -76,6 +76,7 @@
  */
 #define CRAMFS_FLAG_FSID_VERSION_2	0x00000001	/* fsid version #2 */
 #define CRAMFS_FLAG_SORTED_DIRS		0x00000002	/* sorted dirs */
+#define CRAMFS_FLAG_EDITION_TIMESTAMP	0x00000004	/* fstime in edition */
 #define CRAMFS_FLAG_HOLES		0x00000100	/* support for holes */
 #define CRAMFS_FLAG_WRONG_SIGNATURE	0x00000200	/* reserved */
 #define CRAMFS_FLAG_SHIFTED_ROOT_OFFSET	0x00000400	/* shifted root fs */
--- linux-2.4.19-pre7/include/linux/cramfs_fs_sb.h	Mon Apr 29 10:11:54 2002
+++ linux/include/linux/cramfs_fs_sb.h	Mon Apr 29 10:26:11 2002
@@ -5,11 +5,12 @@
  * cramfs super-block data in memory
  */
 struct cramfs_sb_info {
-			unsigned long magic;
-			unsigned long size;
-			unsigned long blocks;
-			unsigned long files;
-			unsigned long flags;
+	unsigned long magic;
+	unsigned long size;
+	unsigned long blocks;
+	unsigned long files;
+	unsigned long flags;
+	time_t        fstime; /* From the edition field if EDITION_TIMESTAMP */
 };

 #endif

