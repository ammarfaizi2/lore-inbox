Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313818AbSEEX2i>; Sun, 5 May 2002 19:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313819AbSEEX2h>; Sun, 5 May 2002 19:28:37 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:57765 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S313818AbSEEX2g>;
	Sun, 5 May 2002 19:28:36 -0400
Date: Mon, 6 May 2002 01:28:36 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200205052328.BAA12076@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: 2.5.13 floppy driver is broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are at least two major problems with drivers/block/floppy.c
in 2.5.13:

1. Writing to /dev/fd0 fails with EROFS from open().
   The driver's open() method relies on revalidate() having read the
   first block and sensed whether the floppy is writable or not.
   But this code was #if:ed out (lines 3883-3903) in 2.5.13, causing
   open() to think the floppy is write-protected and return -EROFS.
   Simply removing the #if 0 doesn't work since some of the code
   in there no longer compiles in 2.5.13.
   A workaround is to read from /dev/fd0 before writing.

2. The data written is seriously corrupted. I compared a bzImage
   written to /dev/fd0 with 2.4.19-pre8 and 2.5.13. The first 9K was Ok,
   but then 2.5.13 wrote data starting from offset 8K in the input.
   I checked if the remaining data was simply shifted 1K, but that
   was not the case: there are other differences (the next one at
   offset 18K) but I haven't fully analysed the pattern.
   I suspect there's some kind of block size confusion error.

/Mikael
