Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316753AbSFJHni>; Mon, 10 Jun 2002 03:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316755AbSFJHnh>; Mon, 10 Jun 2002 03:43:37 -0400
Received: from smtp01ffm.de.uu.net ([192.76.144.150]:46510 "EHLO
	smtp01ffm.de.uu.net") by vger.kernel.org with ESMTP
	id <S316753AbSFJHnf>; Mon, 10 Jun 2002 03:43:35 -0400
From: Ulrich Pfeifer <pfeifer@wait.de>
To: linux-kernel@vger.kernel.org
Subject: Cramfs fixes + mtime
Date: 10 Jun 2002 09:42:22 +0200
Message-ID: <p5r8jfshpd.fsf@hentai.de.uu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 ,-----
 | Given that cramfs will probably be used for CDs etc. as well as just
 | silicon ROMs,
 `-----

inspired by this comment in fs/cramfs/README, I tried to use cramfs
for backups on a very old PC.  Unpacking a 50+M uncleaned kernel tree
just to compare one file was very slow compared to loopback mounting a
cramfs image from CDROM.

When using mkcramfs for larger directory trees, I realized two
shortcomings of mkcramfs which are already highlighted in the source:

1) mkcramfs does map all files before generating the image.  That
   limits the number of files you can backup to 1024 on most systems.

2) mkcramfs uses an anonymous map for the resulting image.  That
   limits the image size to the available physical memory - not enough
   on my box.

I resolved both issues as suggested by the comments.  When solving
problem 1), I removed the capability of mkcramfs to detect duplicate
files.  It can be re-added by e.g. storing md5sums for each file.
This feature is of little use for backups, so I did not implement it.

With these two changes, I was able to generate images of up to the
maximum of 256M.  Then I realized that backups without storing the
mtime of the files is of limited use.

The fs/cramfs/README encouraged me to extend the cramfs inode.

 ,-----
 | it might make sense to expand the inode a little from its current 12
 | bytes.  Inodes other than the root inode are followed by filename, so
 | the expansion doesn't even have to be a multiple of 4 bytes.
 `-----

I managed to change the kernel module to support the old and new inode
format at the same time.  For mkcramfs you have to choose a compile
time what image format should be generated.

I also added support (compile time option) for uncompressed files as
used for the Agenda romdisks.  I did not add the full XIP support to
the module but Agenda romdisks can be read completely.

Since I wanted to use the cramfs as backup, I felt a stand alone
program to extract the image would be in order.  That would probably
work even with kernel series 4.5 ;-)

I slightly massaged Andrew Stitcher's uncramfs and included it.

The patch is against a 2.4.17 kernel tree.  It's a little bigger than
necessary because I piped mkcramfs through Lindent.

http://www.wait.de:data/agenda/cramfs+mtime-2.4.17.patch.gz (14k)

If there is enough interest, I can rework the patch for a newer kernel
or make other adjustments.

Please keep me on CC; I am not subscribe to the mailing list.

Ulrich Pfeifer
