Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262352AbRENSKL>; Mon, 14 May 2001 14:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262351AbRENSKC>; Mon, 14 May 2001 14:10:02 -0400
Received: from hera.cwi.nl ([192.16.191.8]:20434 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262352AbRENSJv>;
	Mon, 14 May 2001 14:09:51 -0400
Date: Mon, 14 May 2001 20:09:45 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105141809.UAA09657.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk
Subject: Re: Minor numbers
Cc: R.E.Wolff@bitwizard.nl, aqchen@us.ibm.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The exercise is essentially the patch that I sent last month or so.

> mknod takes a 32bit input
> the stat64 padding only has room for 32bits

Hmm. You make me search for this old patch.
Since Linus' reaction was not exactly positive I left
the topic again, but there must be a copy somewhere..

Aha, found it. Mail from March 24.

==================================================================
...
- For stat all is fine already since we got stat64.
- For mknod a little work is required.
- The state of affairs with loopinfo is sad today (the fact that
kernel and glibc use dev_t of different size causes problems)
but all will be well with 64-bit dev_t.
...
(iii) mknod:
Then there is the prototype of mknod.
I changed it for all filesystems to

diff -r linux-2.4.2/linux/fs/ext2/namei.c linux-2.4.2kdevt/linux/fs/ext2/namei.c
387c387,388
< static int ext2_mknod (struct inode * dir, struct dentry *dentry, int mode, int rdev)
---
> static int ext2_mknod (struct inode * dir, struct dentry *dentry, int mode,
>                      dev_t rdev)

The system call itself cannot easily be changed to take a larger dev_t,
mostly because under old glibc the high order part would be random.
So, mknod64, with

diff linux-2.4.2/linux/fs/namei.c linux-2.4.2kdevt/linux/fs/namei.c
1205c1208
< asmlinkage long sys_mknod(const char * filename, int mode, dev_t dev)
---
> static long mknod_common(const char * filename, int mode, dev_t dev)
1245a1249,1259
> }
> 
> asmlinkage long sys_mknod64(const char * filename, int mode,
>                           unsigned int ma, unsigned int mi)
> {
>       return mknod_common(filename, mode, ((dev_t) ma << 32) | mi);
> }
...
==================================================================

Yes, so mknod is solved by having mknod64.
I saw no problems with stat64, but you do.
Hmm. I was running a system with 64-bit dev_t when I wrote that letter,
so at least for i386 there cannot be any serious problems.
Let me see.

=================== include/asm-i386/stat.h ======================
/* This matches struct stat64 in glibc2.1, hence the absolutely
 * insane amounts of padding around dev_t's.
 */
struct stat64 {
        unsigned short  st_dev;
        unsigned char   __pad0[10];
...
        unsigned short  st_rdev;
        unsigned char   __pad3[10];
...
==================================================================

So, it seems that you are too pessimistic.
The present stat64 structure even allows 96-bit dev_t.

Andries
