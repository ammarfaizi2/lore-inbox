Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754665AbWKZXVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbWKZXVk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 18:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754876AbWKZXVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 18:21:40 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:37902 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1754665AbWKZXVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 18:21:39 -0500
Date: Sun, 26 Nov 2006 23:21:29 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: Build breakage ...
Message-ID: <20061126232128.GC30767@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>
References: <20061126224928.GA22285@linux-mips.org> <Pine.LNX.4.64.0611261459010.3483@woody.osdl.org> <Pine.LNX.4.64.0611261509330.3483@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611261509330.3483@woody.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2006 at 03:12:54PM -0800, Linus Torvalds wrote:
> 
> 
> On Sun, 26 Nov 2006, Linus Torvalds wrote:
> > 
> > Does the obvious fix (to include <linux/kernel.h> in irqflags.h) fix it 
> > for you?
> 
> Btw, Alexey, why did you do _both a BUILD_BUG_ON and a "typecheck()"?
> 
> If there are any broken users, we shouldn't break the build, but a 
> _warning_ is certainly appropriate.
> 
> I think I'll just commit this..
> 
> Ralf, Russell, does this work for you guys?

Not at all.  It creates even more problems for me, with this circular
dependency:

  linux/bitops.h -> asm-arm/bitops.h -> asm-arm/system.h
   -> linux/irqflags.h -> linux/kernel.h -> linux/bitops.h

We really need, as a priority, to sort out these include files ASAP,
and stop bunging random stuff into unrelated random headers.  Shouldn't
stuff like roundup_pow_of_two() and long_log2() live somewhere else
other than such a generic run-of-the-mill include such as linux/kernel.h ?

  CHK     include/linux/version.h
make[2]: `include/asm-arm/mach-types.h' is up to date.
  Using /home/rmk/git/linux-2.6-rmk as source for kernel
  GEN     /home/rmk/git/build/assabet/Makefile
  CHK     include/linux/utsrelease.h
  CC      arch/arm/kernel/asm-offsets.s
In file included from /home/rmk/git/linux-2.6-rmk/include/linux/irqflags.h:14,
                 from include2/asm/system.h:214,
                 from include2/asm/bitops.h:23,
                 from /home/rmk/git/linux-2.6-rmk/include/linux/bitops.h:9,
                 from /home/rmk/git/linux-2.6-rmk/include/linux/thread_info.h:20,
                 from /home/rmk/git/linux-2.6-rmk/include/linux/preempt.h:9,
                 from /home/rmk/git/linux-2.6-rmk/include/linux/spinlock.h:49,
                 from /home/rmk/git/linux-2.6-rmk/include/linux/capability.h:45,
                 from /home/rmk/git/linux-2.6-rmk/include/linux/sched.h:46,
                 from /home/rmk/git/linux-2.6-rmk/arch/arm/kernel/asm-offsets.c:13:
/home/rmk/git/linux-2.6-rmk/include/linux/kernel.h: In function `roundup_pow_of_two':
/home/rmk/git/linux-2.6-rmk/include/linux/kernel.h:169: warning: implicit declaration of function `fls_long'
In file included from /home/rmk/git/linux-2.6-rmk/include/linux/thread_info.h:20,
                 from /home/rmk/git/linux-2.6-rmk/include/linux/preempt.h:9,
                 from /home/rmk/git/linux-2.6-rmk/include/linux/spinlock.h:49,
                 from /home/rmk/git/linux-2.6-rmk/include/linux/capability.h:45,
                 from /home/rmk/git/linux-2.6-rmk/include/linux/sched.h:46,
                 from /home/rmk/git/linux-2.6-rmk/arch/arm/kernel/asm-offsets.c:13:
/home/rmk/git/linux-2.6-rmk/include/linux/bitops.h: At top level:
/home/rmk/git/linux-2.6-rmk/include/linux/bitops.h:57: error: conflicting types for 'fls_long'
/home/rmk/git/linux-2.6-rmk/include/linux/kernel.h:169: error: previous implicit declaration of 'fls_long' was here
make[2]: *** [arch/arm/kernel/asm-offsets.s] Error 1
make[1]: *** [prepare0] Error 2
make: *** [_all] Error 2

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
