Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161069AbVIBVtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbVIBVtS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbVIBVtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:49:17 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:23313 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1161069AbVIBVtP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:49:15 -0400
Date: Fri, 2 Sep 2005 17:42:31 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: LKML Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Message-ID: <20050902214231.GA10230@ccure.user-mode-linux.org>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C670AD22-97CF-46AA-A527-965036D78667@mac.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 11:00:16PM -0400, Kyle Moffett wrote:
>   1)  There are a couple header files upon which almost everything
> else depends, among them {asm,linux}/{posix_,}types.h, which have
> some significant duplications.  Many of the archs have weird sizes
> for those types to preserve some backwards-compatibility ABI, but
> nowhere does it explain if there are any type-size restrictions in
> general.  I would propose that those headers be reorganized so that
> there are sane defaults for all the types in kabi/types.h, and
> archs that require different would #define exceptions in their
> kabi/arch-foo/types.h.  This would allow new archs to start with a
> sane standard ABI before it becomes set in stone.
> 
>   2)  There is a bunch of stuff that would be _really_ useful in
> userspace programs as well, even though not kernel ABI, such as
> list.h, atomic.h (with a few archs modified due to privilege
> restrictions), etc.  If there is interest, I would attempt to split
> off those headers into a kcore/kerncore/linuxcore/whatever inline
> header collection included in the linux distribution and installed
> as part of the kernel headers.

UML really needs something like this, both 1 and 2.  See
	http://groups.google.com/group/fa.linux.kernel/browse_thread/thread/34d3c02372861a5c/71816a3c7863ea2b?lnk=st&q=%22jeff+dike%22&rnum=27&hl=en#71816a3c7863ea2b
for my take on system.h and ptrace.h when a change in the host
architecture broke the UML build.

UML takes most of its headers from the underlying arch.  It simplifies
things since most of the definitions are usable in UML.  I don't have
to clone and maintain my versions of all the other arch headers.

OTOH, there are things in those headers which UML can't use, and these
are eliminated in various ways (undefining them after the include of
the host arch header, redefining them before the include).  But this
is a pain.

It has long been my opinion that splitting headers into userspace
usable and userspace unusable pieces is the right thing for UML.  Less
clear for the host arch.

Your post seems to indicate that there is a non-UML demand for exactly
this.


>   3)  What names are preferable for the above?  My personal
> preferences are "kabi" and "kcore", because those save the most
> typing for the sucker trying to do all this (IE: me), although if
> someone has good reasons otherwise, I'll listen.

If you look at my patch referenced above, I used -abi, which worked
well for ptrace.h, for which this is what the split amounted to.  For
system.h, it's not so good, since this is your case #2 above.  These
are random userspace usable things which don't appear in the ABI, like
the memory barriers, xchg, and alternative().

> I realize this project is only slightly short of massive, however I
> do have a bunch of time and am willing to do the grunt work if
> enlightened as to the community desires.  

You have my full support on this.

> I have a few different
> semi-patches almost ready, and I can probably finish up a couple
> this weekend if I can figure out which way people want to go. 

Grab my ptrace.h and system.h patches if you don't have them already.

				Jeff
