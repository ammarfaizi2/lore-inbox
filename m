Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262792AbVDHMM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbVDHMM0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 08:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVDHMM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 08:12:26 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:64173 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262794AbVDHMMS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 08:12:18 -0400
Date: Fri, 8 Apr 2005 14:12:04 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Matt Mackall <mpm@selenic.com>
Cc: Simon Derr <Simon.Derr@bull.net>, Yura Pakhuchiy <pakhuchiy@iptel.by>,
       Patrice Martinez <patrice.martinez@ext.bull.net>,
       linux-kernel@vger.kernel.org
Subject: buggy ia64_fls() ? (was Re: /dev/random problem on 2.6.12-rc1)
In-Reply-To: <20050408075532.GX3174@waste.org>
Message-ID: <Pine.LNX.4.61.0504081024120.15652@openx3.frec.bull.fr>
References: <42552A33.6070704@ext.bull.net> <1112879666.2035.10.camel@chaos.void>
 <Pine.LNX.4.58.0504071727080.5654@localhost.localdomain> <20050407211257.GK25554@waste.org>
 <Pine.LNX.4.61.0504080817370.15652@openx3.frec.bull.fr> <20050408075532.GX3174@waste.org>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/04/2005 14:22:03,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/04/2005 14:22:05,
	Serialize complete at 08/04/2005 14:22:05
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2005, Matt Mackall wrote:

> On Fri, Apr 08, 2005 at 08:56:51AM +0200, Simon Derr wrote:
> > On Thu, 7 Apr 2005, Matt Mackall wrote:
> > 
> > > On Thu, Apr 07, 2005 at 05:36:59PM +0200, Simon Derr wrote:
> > > > 
> > > > 
> > I run:
> > # dd if=/dev/random bs=1 count=1 | od
> 
> strace the dd process, please. This works fine here.

As expected, dd is waiting in:

read(0, 0x6000000000014000, 1)

with fd 0 being /dev/random.

> > About /proc/sys/kernel/random/entropy_avail:
> > (5 second refresh interval)
> 
> That may not be sufficient resolution. The upper layers will pull from
> it whenever it rises above 64 and bash it back down to within 7 bits
> of 0. What does it do when no one is reading from it?
Oh, you're right.

with 1/100 sec (or so) resolution, things look like:
(with nobody reading /dev/random, this time)

* usually zero, lots of zero
* sometimes things such as:
0 0 0 1 0 0 0 0 0 0 0 2 0 0 0 1 0 4 1 0 0 0 1 2 2 2 0 2 0 0 0 0 3 0 0 0 

or even

0 0 0 1 0 0 3 2 0 2 0 0 0 0 0 0 0 0 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 9 0 

Other values:

poolsize:4096
read_wakeup_threshold:64
write_wakeup_threshold:128

I enabled the debug messages in random.c and I think I found the problem 
lying in the IA64 version of fls().

It turns out that the generic and IA64 versions of fls() disagree:

(output from a small test program)

     x   ia64_fls(x)      generic_fls(x)

i=-1, t=0, ia64: -65535 et generic:0
i=0, t=1, ia64: 0 et generic:1
i=1, t=2, ia64: 1 et generic:2
i=2, t=4, ia64: 2 et generic:3
i=3, t=8, ia64: 3 et generic:4
i=4, t=16, ia64: 4 et generic:5
i=5, t=32, ia64: 5 et generic:6
i=6, t=64, ia64: 6 et generic:7
i=7, t=128, ia64: 7 et generic:8
i=8, t=256, ia64: 8 et generic:9
i=9, t=512, ia64: 9 et generic:10
i=10, t=1024, ia64: 10 et generic:11
i=11, t=2048, ia64: 11 et generic:12
i=12, t=4096, ia64: 12 et generic:13
i=13, t=8192, ia64: 13 et generic:14
i=14, t=16384, ia64: 14 et generic:15
i=15, t=32768, ia64: 15 et generic:16
i=16, t=65536, ia64: 16 et generic:17
i=17, t=131072, ia64: 17 et generic:18
i=18, t=262144, ia64: 18 et generic:19
i=19, t=524288, ia64: 19 et generic:20
i=20, t=1048576, ia64: 20 et generic:21
i=21, t=2097152, ia64: 21 et generic:22
i=22, t=4194304, ia64: 22 et generic:23
i=23, t=8388608, ia64: 23 et generic:24
i=24, t=16777216, ia64: 24 et generic:25
i=25, t=33554432, ia64: 25 et generic:26
i=26, t=67108864, ia64: 26 et generic:27
i=27, t=134217728, ia64: 27 et generic:28
i=28, t=268435456, ia64: 28 et generic:29
i=29, t=536870912, ia64: 29 et generic:30
i=30, t=1073741824, ia64: 30 et generic:31
i=31, t=-2147483648, ia64: 31 et generic:32
i=32, t=0, ia64: -65535 et generic:0
...

I tried to fix it with an ia64 version that would give the same result as 
the generic version, but the kernel did not boot, I guess some functions 
rely on the ""broken"" ia64_fls() behaviour.

So I just changed fls() to use generic_fls() instead of ia64_fls().

(Patch below).

And /dev/random seems to work again.


	Simon.


Signed-Off-By: Simon Derr <Simon.Derr@bull.net>

Index: linux-2.6.11/include/asm-ia64/bitops.h
===================================================================
--- linux-2.6.11.orig/include/asm-ia64/bitops.h	2005-04-08 14:07:46.826191877 +0200
+++ linux-2.6.11/include/asm-ia64/bitops.h	2005-04-08 14:08:09.750996284 +0200
@@ -327,11 +327,7 @@ ia64_fls (unsigned long x)
 	return exp - 0xffff;
 }
 
-static inline int
-fls (int x)
-{
-	return ia64_fls((unsigned int) x);
-}
+#define fls(x) generic_fls(x)
 
 /*
  * ffs: find first bit set. This is defined the same way as the libc and compiler builtin
