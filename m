Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWABSvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWABSvX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 13:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWABSvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 13:51:23 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:24505 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750948AbWABSvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 13:51:22 -0500
Date: Mon, 2 Jan 2006 19:51:15 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matan Peled <chaosite@gmail.com>
cc: linux-kernel@vger.kernel.org, kwall@kurtwerks.com
Subject: Re: Arjan's noinline Patch
In-Reply-To: <43B8FA70.2090408@gmail.com>
Message-ID: <Pine.LNX.4.61.0601021949240.29938@yvahk01.tjqt.qr>
References: <20060101155710.GA5213@kurtwerks.com> <20060102034350.GD5213@kurtwerks.com>
 <43B8FA70.2090408@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> the "noinline" cases were built with Arjan's patch and
>> CONFIG_CC_OPTIMIZE_FOR_SIZE; the "inline" kernels were built,
>> obviously, without the patch and without CONFIG_CC_OPTIMIZE_FOR_SIZE.
>
> Wait, so how do we know if its GCC's -Os that caused the reduction in .text
> size, or the noinline patch ... ?
>
> To get actual results, you should either take OPTIMIZE_FOR_SIZE out the
> equation or use it on the other kernel as well...

I tried various kernel compilations; for fun and joy, I built a totally
monolithic kernel with almost all options turned on. I probably won't
boot it, heh. First, there were some modules/sourcefiles that fail to
compile:

	CONFIG_MTD_AMDSTD
	CONFIG_MTD_JEDEC
	CONFIG_FB_PM3

There are also some issues in drivers/net/wan/sdla_*.c that I had to
fix before make was able to link to .tmp_vmlinux1.bin. I will post a 
compile-fix in another thread. Now back to the inlining part. I have a
number of flavors to show...

All done with gcc version 4.0.2 20050901 (prerelease) (SUSE Linux)

	std:		vanilla 2.6.15-rc7
	Os:		vanilla + CONFIG_OPTIMIZE_FOR_SIZE
	noinl:		vanilla + Arjan's noinline
	noinl-Os:	vanilla + CONFIG_OPTIMIZE_FOR_SIZE + noinline
Specials:
	NFI:		no forced inline (removal of always_inline part)

Information from make (bzImage):
	std:		System is 12226 kB
	Os:		System is 10879 kB
	noinl:		System is 12181 kB
	noinl-Os:	System is 10851 kB
	NFI:		System is 12198 kB

ls -l:
	-rwxr-xr-x  26999081 Jan  2 17:43 rc7-noinl-Os/vmlinux
	-rwxr-xr-x  27115266 Jan  2 15:48 rc7-Os/vmlinux
	-rwxr-xr-x  30010293 Jan  2 17:24 rc7-noinl/vmlinux
	-rwxr-xr-x  30058462 Jan  2 19:37 rc7-NFI/vmlinux
	-rwxr-xr-x  30150993 Jan  2 15:45 rc7-std/vmlinux

size:
    text    data     bss      dec     hex filename
17188479 5984442 1738248 24911169 17c1d41 rc7-noinl-Os/vmlinux
17313751 5980978 1738248 25032977 17df911 rc7-Os/vmlinux
20174873 5991726 1738248 27904847 1a9cb4f rc7-noinl/vmlinux
20222221 5992278 1738248 27952747 1aa866b rc7-NFI/vmlinux
20321527 5988706 1738248 28048481 1abfc61 rc7-std/vmlinux


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
