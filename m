Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbTAXVzk>; Fri, 24 Jan 2003 16:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbTAXVzk>; Fri, 24 Jan 2003 16:55:40 -0500
Received: from hera.cwi.nl ([192.16.191.8]:63624 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S265815AbTAXVzh>;
	Fri, 24 Jan 2003 16:55:37 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 24 Jan 2003 23:04:45 +0100 (MET)
Message-Id: <UTC200301242204.h0OM4jU09451.aeb@smtp.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, sdake@mvista.com
Subject: Re: 32bit dev_t
Cc: Joel.Becker@oracle.com, dougg@torque.net, kurt@garloff.de,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Who is tracking the 32bit dev_t effort for 2.5?

Once or twice a year I build a kernel with 32bit or 64bit dev_t.
Every now and then submit a few patches so that doing so
remains easy. The last real change was the change in prototype
of the VFS *_mknod functions.

: 32bit dev_t IMHO is essential to 2.6. Essential enough that if its not
: in the base 2.6 all the vendors have to get together and issue a Linus 
: incompatible but common 32bit dev_t interface.

The main point to decide would be the external dev_t format.
Of course the format must be compatible with existing filesystems
and binaries. For example,

#define MAJOR(dev)      ((unsigned int)(((dev) & 0xffff0000) \
	? ((dev) >> 16) & 0xffff : ((dev) >> 8) & 0xff))
#define MINOR(dev)      ((unsigned int)(((dev) & 0xffff0000) \
	? ((dev) & 0xffff) : ((dev) & 0xff)))
#define MKDEV(ma,mi)    ((dev_t)((((ma) & ~0xff) == 0 && ((mi) & ~0xff) == 0) \
	? (((ma) << 8) | (mi)) : (((ma) << 16) | (mi))))

This is 1-1 on nonzero majors (and zero major, 8-bit minor).

Once the decision has been made on the size of dev_t and the
computation of major,minor given a dev_t, it is straightforward
to implement that decision. Unfortunately not only the kernel
but also glibc must be changed.

In glibc one needs to fix in sysdeps/unix/sysv/linux
the files sys/sysmacros.h, bits/stat.h, ustat.c, xmknod.c.

In the kernel there are lots of tiny fixes needed because
people did not distinguish between int and dev_t and kdev_t.
Nothing major.

(Anyone can boot a 2.5 kernel with 32-bit dev_t by changing
    include/asm-i386/posix_types.h
(change the line "typedef unsigned short __kernel_dev_t;"
to what is desired, e.g. s/short/int/) and changing
    include/linux/kdev_t.h
(change the typedef for kdev_t to have e.g. unsigned int,
set KDEV_MINOR_BITS and KDEV_MAJOR_BITS to 16,
change the 0xff in the definition of major and minor to 0xffff,
change the definitions of MAJOR, MINOR, MKDEV as above).)

[Warning: I do such things and it works. But if you do so,
it may well destroy your filesystems. A complete patch has
minor fixes all over the place.]


Andries
