Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317624AbSGFIdY>; Sat, 6 Jul 2002 04:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317625AbSGFIdX>; Sat, 6 Jul 2002 04:33:23 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:12193 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S317624AbSGFIdW>; Sat, 6 Jul 2002 04:33:22 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Gyurdiev <ivangurdiev@attbi.com>
Reply-To: ivangurdiev@attbi.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>, <fabbione@fabbione.net>
Subject: Re: linux 2.5.25 (different compilation errors)
Date: Fri, 5 Jul 2002 04:38:48 -0400
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200207050438.48989.ivangurdiev@attbi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm. Haven't received this message. Reading it on LKML.
Please cc, I'm not subscribed.


> iforce-packets.c:252: `IFORCE_USB' undeclared (first use in this function)
> iforce-packets.c:252: (Each undeclared identifier is reported only once
> iforce-packets.c:252: for each function it appears in.)
> iforce-packets.c:282: `IFORCE_232' undeclared (first use in this function)
> iforce-packets.c:278: warning: unreachable code at beginning of switch
> statement

Well, obviously the construct


switch (iforce->bus)

case CONSTANT:

#ifdef CONSTANT
do stuff
#endif

will not work.

Why is all this #ifdef mess necessary.
Those are recognition constants.
How can you compare iforce->bus to IFORCE_USB or IFORCE_232
if those are only defined sometimes, based on config options...

Why not just...
#if defined(CONFIG_JOYSTICK_IFORCE_232)
#define IFORCE_232      1
#endif
#if defined(CONFIG_JOYSTICK_IFORCE_USB)
#define IFORCE_USB      2
#endif

drop the if statements and always define the constants.
The code will get much simpler IMHO.

===========================================

> zr36120.c:1497: unknown field `open' specified in initializer 
zr36120.c:1497: warning: initialization makes integer from pointer without a 
cast zr36120.c:1498: unknown field `close' specified in initializer 
zr36120.c:1498: warning: initialization from incompatible pointer type
>
> [SNIP]
>
> zr36120.c:1839: unknown field `minor' specified in initializer make[3]: *** 
[zr36120.o] Error 1

Here's what I found in the 2.4 videodev.h:
   /* old, obsolete interface -- dropped in 2.5.x, don't use it */
        int (*open)(struct video_device *, int mode);
        void (*close)(struct video_device *);
...
 /* new interface -- we will use file_operations directly
         * like soundcore does.
         * kernel_ioctl() will be called by video_generic_ioctl.
         * video_generic_ioctl() does the userspace copying of the
         * ioctl arguments */

============================================

