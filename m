Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUBFVZK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 16:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUBFVZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 16:25:10 -0500
Received: from web40501.mail.yahoo.com ([66.218.78.118]:63411 "HELO
	web40501.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266517AbUBFVWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 16:22:12 -0500
Message-ID: <20040206212205.46151.qmail@web40501.mail.yahoo.com>
Date: Fri, 6 Feb 2004 13:22:05 -0800 (PST)
From: Alex Davis <alex14641@yahoo.com>
Subject: Issues with linux-2.6.2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a few issues with 2.6.2. Ths first issue is when upgrading from 2.4, I had to create 
the symlinks:

   ln -s /usr/include/asm /usr/src/linux/include/asm-i386
   ln -s /usr/include/asm-generic /usr/src/linux/include/asm-generic

This requirement was not mentioned in any documentation I could find.

The second issue is when trying to build util-linux-2.11z I get the following error:

cc -pipe -O2 -mcpu=i486 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes
-Wstrict-prototypes -I/usr/include/ncurses -DNCH=0   -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\"
-DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\"
-DLOCALEDIR=\"/usr/share/locale\" -O2  -s  blockdev.c   -o blockdev
blockdev.c:70: error: parse error before '[' token
blockdev.c:70: error: initializer element is not constant
blockdev.c:70: error: (near initialization for `bdcms[4].ioc')
blockdev.c:70: error: initializer element is not constant
blockdev.c:70: error: (near initialization for `bdcms[4]')
blockdev.c:73: error: parse error before '[' token
blockdev.c:73: error: initializer element is not constant
blockdev.c:73: error: (near initialization for `bdcms[5].ioc')
blockdev.c:73: error: initializer element is not constant
blockdev.c:73: error: (near initialization for `bdcms[5]')
blockdev.c:76: error: initializer element is not constant
blockdev.c:76: error: (near initialization for `bdcms[6]')
blockdev.c:79: error: initializer element is not constant
blockdev.c:79: error: (near initialization for `bdcms[7]')
blockdev.c:82: error: initializer element is not constant
blockdev.c:82: error: (near initialization for `bdcms[8]')
blockdev.c:85: error: initializer element is not constant
blockdev.c:85: error: (near initialization for `bdcms[9]')
blockdev.c:89: error: initializer element is not constant
blockdev.c:89: error: (near initialization for `bdcms[10]')
blockdev.c: In function `report_device':
blockdev.c:331: error: parse error before '[' token
make: *** [blockdev] Error 1

It seems there is a problem with the BLKBSZGET and the BLKBSZSET macros defined in
linux/include/linux/fs.h.
They both indirectly call the _IOC_TYPECHECK macro, which is defined in
linux/include/asm-386/ioctl.h thusly:

#define _IOC_TYPECHECK(t) \
	((sizeof(t) == sizeof(t[1]) && \
	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
	  sizeof(t) : __invalid_size_argument_for_IOC)


The problem is that _IOC_TYPECHECK is being called with a constant value (size_t), making the 
array indexing attempt illegal. Using gcc -E, BLKBSZGET expands to:
(((2U) << (((0 +8)+8)+14)) | (((0x12)) << (0 +8)) | (((112)) << 0) | (((((sizeof(sizeof(int)) == 
sizeof(sizeof(int)[1]) && sizeof(sizeof(int)) < (1 << 14)) ? sizeof(sizeof(int)) : 
       ^^^^^^^^^^^^^^  // illegal.
__invalid_size_argument_for_IOC))) << ((0 +8)+8))) 

Is this a known problem?

=====
I code, therefore I am

__________________________________
Do you Yahoo!?
Yahoo! Finance: Get your refund fast by filing online.
http://taxes.yahoo.com/filing.html
