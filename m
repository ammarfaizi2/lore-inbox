Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129361AbQLLGtM>; Tue, 12 Dec 2000 01:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131369AbQLLGtC>; Tue, 12 Dec 2000 01:49:02 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:58356 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129361AbQLLGsw>; Tue, 12 Dec 2000 01:48:52 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200012120618.eBC6I6e11386@webber.adilger.net>
Subject: Re: e2fs block to physical block translation
In-Reply-To: <20001212012148.60376.qmail@web10105.mail.yahoo.com>
 "from Al Peat at Dec 11, 2000 05:21:48 pm"
To: Al Peat <al_kernel@yahoo.com>
Date: Mon, 11 Dec 2000 23:18:06 -0700 (MST)
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Stephen C. Tweedie" <sct@redhat.com>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Peat writes:
> Quick question about blocks:
> 
>   If I assume my hard drive uses 512 blocks, and my
> ext2 filesystem uses 4k blocks, can I assume the
> following formula for translation?
> 
>   physical block # / 8  =  e2fs block #

It really depends on what you are calculating.  Ext2 uses "fs blocksize"
blocks for most things (i.e. absolute block number in the filesystem,
filesystem size, blocks per group, etc) but not for the inode blocks count
(for a reason I don't understand).  The inode i_blocks count is always
in 512-byte blocks from what I've seen.  This value _may_ be in "sector"
sized blocks, but I've never tried ext2 on a non-512-byte sector device.
In any case, there is a lot of ">> 9" and "/ 512" stuff in the ext2
code and e2fsprogs, so it would probably break anyways.  This limits
ext2 files to 2TB.

On that note, we need a patch to the ext2/ext3 code which limits the
file size to (2^32 - 1 filesystem block) 512-byte blocks (as imposed by
the i_blocks field).  This is only a limitation for 4kB and 8kB block
ext2 filesystems.  We currently don't have to worry about this limit
because the kernel block device layer imposes a 2TB limit on the whole
filesystem, but better to be correct now than bug hunt a rare case later.

Single File Limits (in GB, * = real limit)     1k     2k     4k      8k
==========================================   ====   ====   ====   =====
By {,in,double-in,triple-in}direct blocks:     16*   256*  4100   65568
By i_blocks (2^32 - 1 fs block)*512 bytes:   2048   2048   2048*   2048*


The patch is for 2.4.0-test12, but is the same for 2.2.18 (excluding context).
Ted or Stephen, can you please forward to Linus and Alan, since they appear
never to accept patches from me directly.

Cheers, Andreas
==============================================================================
--- fs/ext2/file.c.orig	Tue Jan  4 11:12:23 2000
+++ fs/ext2/file.c	Mon Dec 11 21:08:43 2000
@@ -44,11 +44,11 @@
 static loff_t ext2_file_lseek(struct file *, loff_t, int);
 static int ext2_open_file (struct inode *, struct file *);
 
-#define EXT2_MAX_SIZE(bits)							\
-	(((EXT2_NDIR_BLOCKS + (1LL << (bits - 2)) + 				\
-	   (1LL << (bits - 2)) * (1LL << (bits - 2)) + 				\
-	   (1LL << (bits - 2)) * (1LL << (bits - 2)) * (1LL << (bits - 2))) * 	\
-	  (1LL << bits)) - 1)
+#define EXT2_MAX_SIZE(bits)						      \
+    MIN(((EXT2_NDIR_BLOCKS + (1LL << (bits - 2)) +			      \
+	  (1LL << (bits - 2)) * (1LL << (bits - 2)) +			      \
+	  (1LL << (bits - 2)) * (1LL << (bits - 2)) * (1LL << (bits - 2))) *  \
+	 (1LL << bits)) - 1, 512LL * ((1LL << 32) - (1LL << (bits - 9)))
 
 static long long ext2_max_sizes[] = {
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 

-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
