Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbULPEfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbULPEfi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 23:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbULPEfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 23:35:37 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:51881 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262545AbULPEf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 23:35:28 -0500
Date: Thu, 16 Dec 2004 05:35:21 +0100
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 32-bit syscalls from 64-bit process on x86-64?
Message-ID: <20041216043520.GD32718@wotan.suse.de>
References: <380350F3EC1@vcnet.vc.cvut.cz> <20041215042704.GE27225@wotan.suse.de> <1103107807.24540.23.camel@localhost> <20041215105510.GF27225@wotan.suse.de> <1103144285.13338.30.camel@minilith.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103144285.13338.30.camel@minilith.goop.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 12:58:05PM -0800, Jeremy Fitzhardinge wrote:
> On Wed, 2004-12-15 at 11:55 +0100, Andi Kleen wrote:
> > Hmm, in theory you could handle a 64bit signal frame from 32bit code
> > (just may need an assembly stub if you want the arguments). But it 
> > would be quite ugly agreed.
> 
> Yes.  I've tried this out, and it works OK, but it isn't pleasing.  One
> of the main problems is that the stack is likely to be above 4G, so %esp
> has no useful value, and when you switch to 64-bit mode, the top 32-bits
> of %rsp become undefined.

They seem to stay at the previous value in the current CPUs, but it's 
undefined behaviour yes.

> 
> > Perhaps it should force __USER_CS yes in this case, agreed.
> > 
> > There is a small risk of breaking someone, but it's very small.
> 
> Well, if they've got code which is already switching between 32 and 64
> bit segments, then they need to cope with either cs being current at
> delivery time.

Can you cope with that in valgrind? If I change it there will
be kernels with both behaviour around for a long time.

> 
> > I can do that change if you want.
> > 
> > BTW the long term plan is to get rid of the special cases to make
> > it easierto use the 32bit kernel ABI from a 64bit program.
> > This means signal handling will likely just check the code segment
> > at some  point to decide if it should set up 32bit or 64bit frames
> > and we'll probably do similar things with the other cases 
> > (except exec which needs to stay this way) 
> 
> At syscall time, rather than delivery time, I assume.  Hm, I'd prefer it
> if it didn't look at the current segment, but at the syscall path.  Ie,
> installing a handler with __NR_rt_sigaction via int 0x80 (or 32-bit
> syscall/sysenter) should set up a 32-bit frame on delivery, but if the
> handler was installed with the 64-bit syscall, it should be called with
> a 64-bit frame.

That would probably add some complications to the syscall exit path:
there is some code sharing between 32bit and 64bit, in particular 64bit
execve uses the IRET path to restore all registers and there can be a 
signal after that.

The only case that wouldn't be handled by checking the segment would
be that if someone defines a 64bit LDT code segment and uses it, it
will not work. But that won't work anyways from 64bit because SYSRET
always forces __USER_CS. If you want to do any 64bit system calls
you cannot use such custom segment anyways. 

So i don't see any drawbacks in just checking the segment for this.

-Andi

