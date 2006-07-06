Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbWGFBoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbWGFBoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 21:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbWGFBoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 21:44:32 -0400
Received: from aun.it.uu.se ([130.238.12.36]:34979 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S965120AbWGFBoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 21:44:32 -0400
Date: Thu, 6 Jul 2006 03:44:17 +0200 (MEST)
Message-Id: <200607060144.k661iH8d010317@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: adaplas@gmail.com, mikpe@it.uu.se
Subject: Re: [PATCH 2.6.17 sparc64] 32-bit compat for Mach64 framebuffer
Cc: davem@davemloft.net, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2006 09:01:04 +0800, Antonino A. Daplas wrote:
>Mikael Pettersson wrote:
>> To: davem@davemloft.net
>> Subject: [PATCH 2.6.17 sparc64] 32-bit compat for Mach64 framebuffer
>> Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
>> 
>> In recent sparc64 kernels, starting a 32-bit mode X server on
>> a machine with a Mach64 framebuffer (CONFIG_FB_ATY_CT=y) like
>> an Ultra5, results in the kernel complaining:
>> 
>> ioctl32(X:1977): Unknown cmd fd(6) cmd(40584606){00} arg(ef8dd6d8) on /dev/fb0
>> ioctl32(X:1977): Unknown cmd fd(6) cmd(40184600){00} arg(ef8dd6e0) on /dev/fb0
>> 
>> That's FBIOGTYPE and FBIOGATTR. These errors occur because
>> kernel 2.6.15-rc2 changed the way sparc64 handles SPARC-specific
>> framebuffer ioctls from 32-bit processes: before 2.6.15-rc2
>> arch/sparc64/kernel/ioctl32.c handled them for all devices,
>> but 2.6.15-rc2 dropped that support and changed SPARC-only
>> framebuffer drivers like ffb.c to set up ->compat_ioctl methods
>> pointing to sbusfb_compat_ioctl in drivers/video/sbuslib.c.
>> However, drivers for framebuffers like the Mach64 that can exist
>> on both SPARCs and non-SPARCs were not adjusted, so in sparc64
>> kernels SPARC-specific framebuffer ioctls on Mach64 devices are
>> no longer accepted from 32-bit mode processes. Hence the errors.
>> 
>> The fix is to make atyfb_base.c set up a ->compat_ioctl pointing
>> to sbusfb_compat_ioctl when running in a sparc64 kernel with
>> compatibility for sparc32 user-space, and to compile and link
>> sbuslib.o with the frambuffer driver.
>> 
>> A complication is that sbuslib.c doesn't compile on non-SPARC
>> machines, so we must be careful to only enable it in the case
>> described above. That's why the patch puts an ugly "if" statement
>> in the Makefile.
>
>Why not something like this?
>
>1. In Kconfig
>
>config FB_SBUSLIB
>tristate
>default n
>
>Then all the sbus drivers will have this:
>
>select FB_SBUSLIB
>
>and atyfb will have this
>
>select FB_SBUSLIB if SPARC64 && COMPAT
>
>2. In Makefile
>obj-$(CONFIG_FB_SBUSLIB)  += sbuslib.o
>
>3. In sbuslib.h
>
>#ifdef CONFIG_COMPAT
>int sbusfb_compat_ioctl(...);
>#else
>#define sbusfb_compat_ioctl NULL;
>#endif

That could work. But it's a much larger patch than mine,
and I don't want to go around hacking random other stuff
just to repair atyfb. It's up the the Powers That Be to
decide whether a local fix or a global one is most appropriate.

>This way, we can also eliminate all the #ifdef CONFIG_COMPAT in all the
>cg* drivers and atyfb.

That would require sbuslib.h to be completely benign on
non-SPARC machines. If it is, great, but I can't currently
guarantee that it is.
