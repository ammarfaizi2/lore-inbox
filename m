Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263186AbTCSV30>; Wed, 19 Mar 2003 16:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263190AbTCSV30>; Wed, 19 Mar 2003 16:29:26 -0500
Received: from hera.cwi.nl ([192.16.191.8]:55478 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263186AbTCSV3W>;
	Wed, 19 Mar 2003 16:29:22 -0500
From: Andries.Brouwer@cwi.nl
Date: Wed, 19 Mar 2003 22:40:15 +0100 (MET)
Message-Id: <UTC200303192140.h2JLeF924104.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, akpm@digeo.com
Subject: Re: major/minor split
Cc: Joel.Becker@oracle.com, andrey@eccentric.mae.cornell.edu,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Shouldn't this be "typedef unsigned int __kernel_dev_t;" ?

This is for you to play with, not a submitted patch.
Make it int, long, long long - whatever you like.

> This is 16+16. What is involved in going to 12+20?

Editing kdev_t.h and changing one 16 to 12 and another 16 to 20.
And then there are two 0xffff, lazy as I am, that you would
have to turn into the appropriate masks: e.g., for 13+19:

#define KDEV_MINOR_BITS 19
#define KDEV_MINOR_MASK ((1<<KDEV_MINOR_BITS) - 1)
#define KDEV_MAJOR_BITS 13
#define KDEV_MAJOR_MASK ((1<<KDEV_MAJOR_BITS) - 1)
#define minor(dev)	((dev).value & KDEV_MINOR_MASK)
#define major(dev)	(((dev).value >> KDEV_MINOR_BITS) & KDEV_MAJOR_MASK)

Similar in the definition of MAJOR and MINOR.

One of these weeks I'll give you a better parametrized version.

(I hope the purpose of distinguishing arithmetic types dev_t
and kdev_t is clear. The latter is simple e.g. 13+19.
mk_kdev, major, minor are simple macros. Kernel use is fast,
no conditional involved.
The former must be backwards compatible, so MKDEV, MAJOR, MINOR
are somewhat complicated macros; for example MAJOR asks: does it fit
in 16 bits? then MAJOR is the first 8; otherwise MAJOR is
the first DEV_MAJOR_BITS. Used only when converting from userspace.)

> What glibc changes are required?

Glibc has:

int
xmknod (int vers, const char *path, mode_t mode, dev_t *dev) {
      unsigned short int k_dev;

      k_dev = ((major (*dev) & 0xff) << 8) | (minor (*dev) & 0xff);
      return INLINE_SYSCALL (mknod, 3, CHECK_STRING (path), mode, k_dev);
}

You see that even though glibc dev_t is very large, the peephole
offered with mknod is tiny. So, the glibc mknod routine must be fixed.
Also the macros major, minor, makedev in <sys/sysmacros.h>.

> What happens with an old glibc?

As long as you do not use new device numbers, all is well.
With new device numbers and an old glibc, major and minor
will be truncated to 8 bits in many places.
So, anybody who wants to use 10000 disks will also have to
use the latest glibc.

Andries
