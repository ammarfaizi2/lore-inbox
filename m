Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262893AbVEHQfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbVEHQfh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 12:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbVEHQfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 12:35:37 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:63751 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262893AbVEHQfV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 12:35:21 -0400
Date: Sun, 8 May 2005 12:28:18 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Alexander Nyberg <alexn@telia.com>, Antoine Martin <antoine@nagafix.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
Message-ID: <20050508162818.GA25130@ccure.user-mode-linux.org>
References: <20050504191828.620C812EE7@sc8-sf-spam2.sourceforge.net> <1115248927.12088.52.camel@cobra> <1115392141.12197.3.camel@cobra> <1115483506.12131.33.camel@cobra> <1115481468.925.9.camel@localhost.localdomain> <20050507180356.GA10793@ccure.user-mode-linux.org> <20050508001832.GA32143@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050508001832.GA32143@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2005 at 01:18:32AM +0100, Al Viro wrote:
> Hrm...

I had a lot of these fixed already.  These will be mostly in the fixlets
patch.

> 	a) stub.S handling breaks on O= builds.   Actually, your unprofile
> breaks there - it's bypassing the machinery that deals with include path.

This?
	$(patsubst -pg,,$(patsubst -fprofile-arcs -ftest-coverage,,$(1)))

I don't see any connection to include paths there.


> 	b) stub_segv.c on amd64 includes <signal.h>.  Not a good idea...

x86_64 doesn't, but i386 does.  Fixed now.

> 	c) sysdep-x86_64/checksum.h in -rc4 has csum_partial_copy_from_user()
> that needs updating (AFAICS, you have that in your patchset, but it hadn't
> reached Linus)

Fixed.

> 	d) ip_compute_csum() prototype is missing (same file)
> 	j) ip_compute_csum should be exported on amd64.

OK, I need to look at this a bit more.

> 	e) #define UPT_SYSCALL_RET(r) UPT_RAX(r) is needed in amd64 ptrace.h

Fixed.

> 	f) take a good look at UPT_SET() in the same file ;-)

Sigh.  Fixed now.

> 	g) CFLAGS_csum-partial.o := -Dcsum_partial=arch_csum_partial in
> sys-x86_64/Makefile needs to be removed.

Fixed.

> 	h) Makefile.rules should be included _after_ SYMLINKS = in the same
> file.

Fixed.

> 	i) sys-x86_64/delay.c needs exports of __udelay() and __const_udelay(),
> include of linux/module.h and barriers in your delay loop bodies (or games
> with volatile - anything that would guarantee that gcc won't decide to optimize
> the entire loop away).  The last part applies to i386 as well.

Looks to me like it all applies to i386 too, except that __delay looks 
unoptimizable.

It also looks to me like I could implement __udelay as n=... ; __delay(n);

And also never mind the fact that __udelay and __const_udelay are identical.

> 	k) sys-x86_64/syscalls.c needs include "kern.h"

Fixed now.

> 	l) elf-i386.h should include <asm/user.h>, not "user.h"

Fixed now.

> 	m) elf-x86_64.h lacks R_X86_64_... definitions

Fixed now.

> 	n) WTF _is_ that #ifdef TIF_IA32 in there?  Aside of the trailing \,
> we could as well put #error there - free-floating clear_thread_flag(TIF_IA32);> outside of any function body will have that effect anyway.

The trailing \ aside, which is fixed, that's a reminder for me when I add
the 32-bit compatibility code.

> 	o) in drivers/chan_kern.c we have several printf(KERN_ERR "...");
> these should become printk, as they clearly had been intended.  As it is,
> they give instant panic if we ever call them.

Oops.  This requires a bit of thought.  Offhand, I think they need to be 
printf, because that early in boot, printk'd stuff may not reach the screen
if UML exits then.

> 	p) TOP_ADDR in Kconfig_x86_64 got lost in transmission - your patchset
> has it, but same patch in Linus' tree does not.

Fixed

> 
> I've got patches for everything except (a); that one is really nasty.  I hope
> to sort it out by tonight; if not, I'll just send what I've got by now.

OK, send me what you have, and if we've fixed the same thing differently,
I choose one or the other.

				Jeff
