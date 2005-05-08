Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbVEHASj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbVEHASj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 20:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbVEHASj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 20:18:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16067 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262765AbVEHASg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 20:18:36 -0400
Date: Sun, 8 May 2005 01:18:32 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Jeff Dike <jdike@addtoit.com>
Cc: Alexander Nyberg <alexn@telia.com>, Antoine Martin <antoine@nagafix.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
Message-ID: <20050508001832.GA32143@parcelfarce.linux.theplanet.co.uk>
References: <20050504191828.620C812EE7@sc8-sf-spam2.sourceforge.net> <1115248927.12088.52.camel@cobra> <1115392141.12197.3.camel@cobra> <1115483506.12131.33.camel@cobra> <1115481468.925.9.camel@localhost.localdomain> <20050507180356.GA10793@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050507180356.GA10793@ccure.user-mode-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 02:03:56PM -0400, Jeff Dike wrote:
> On Sat, May 07, 2005 at 05:57:48PM +0200, Alexander Nyberg wrote:
> > I never get uml to compile around here, 2.6.12-rc3 + that patchkit from
> > the link you sent blows up with defconfig any my minimal config. Please
> > attach your guest .config and if you can you might aswell put your guest
> > vmlinux somewhere where i can download it too.
> 
> Start with -rc3, and all the patches from
> 	http://user-mode-linux.sf.net/patches.html
> up to and including skas0.  You'll see a note to x86_64 users on that patch.

Hrm...
	a) stub.S handling breaks on O= builds.   Actually, your unprofile
breaks there - it's bypassing the machinery that deals with include path.
	b) stub_segv.c on amd64 includes <signal.h>.  Not a good idea...
	c) sysdep-x86_64/checksum.h in -rc4 has csum_partial_copy_from_user()
that needs updating (AFAICS, you have that in your patchset, but it hadn't
reached Linus)
	d) ip_compute_csum() prototype is missing (same file)
	e) #define UPT_SYSCALL_RET(r) UPT_RAX(r) is needed in amd64 ptrace.h
	f) take a good look at UPT_SET() in the same file ;-)
	g) CFLAGS_csum-partial.o := -Dcsum_partial=arch_csum_partial in
sys-x86_64/Makefile needs to be removed.
	h) Makefile.rules should be included _after_ SYMLINKS = in the same
file.
	i) sys-x86_64/delay.c needs exports of __udelay() and __const_udelay(),
include of linux/module.h and barriers in your delay loop bodies (or games
with volatile - anything that would guarantee that gcc won't decide to optimize
the entire loop away).  The last part applies to i386 as well.
	j) ip_compute_csum should be exported on amd64.
	k) sys-x86_64/syscalls.c needs include "kern.h"
	l) elf-i386.h should include <asm/user.h>, not "user.h"
	m) elf-x86_64.h lacks R_X86_64_... definitions
	n) WTF _is_ that #ifdef TIF_IA32 in there?  Aside of the trailing \,
we could as well put #error there - free-floating clear_thread_flag(TIF_IA32);
outside of any function body will have that effect anyway.
	o) in drivers/chan_kern.c we have several printf(KERN_ERR "...");
these should become printk, as they clearly had been intended.  As it is,
they give instant panic if we ever call them.
	p) TOP_ADDR in Kconfig_x86_64 got lost in transmission - your patchset
has it, but same patch in Linus' tree does not.

I've got patches for everything except (a); that one is really nasty.  I hope
to sort it out by tonight; if not, I'll just send what I've got by now.
