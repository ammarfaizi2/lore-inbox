Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTIAI33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 04:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTIAI32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 04:29:28 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:42121 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262758AbTIAI30
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 04:29:26 -0400
Date: Mon, 1 Sep 2003 09:29:11 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "David S. Miller" <davem@redhat.com>
Cc: mfedyk@matchmail.com, lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901082911.GA1638@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk> <20030829154101.GB16319@work.bitmover.com> <20030829230521.GD3846@matchmail.com> <20030830221032.1edf71d0.davem@redhat.com> <20030831224937.GA29239@mail.jlokier.co.uk> <20030831223102.3affcb34.davem@redhat.com> <20030901064231.GJ748@mail.jlokier.co.uk> <20030901000615.28d93760.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901000615.28d93760.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> I disagree, MAP_FIXED means "I know what I am doing don't override
> this unless the mapping area is not available in my address space."
> You should never specify MAP_FIXED unless you _REALLY_ know what you
> are doing.

So explain this from the Sparc architecture code:

	if (flags & MAP_FIXED) {
		/* We do not accept a shared mapping if it would violate
		 * cache aliasing constraints.
		 */
		if ((flags & MAP_SHARED) && (addr & (SHMLBA - 1)))
			return -EINVAL;
		return addr;
	}

Ok, I'll explain it :)  At one time, the code did what the comment says,
but nowadays linux/mm/mmap.c doesn't call arch_get_unmapped_area() for
MAP_FIXED, so the above code is redundant and misleading.  It already
mislead me, so please remove it.  sparc and sparc64 both have it.

> > Thus I have three Sparc-specific questions:
> > 
> > 	1. How does userspace find out the value of SHMLBA?
> > 	   On Sparc, it is not a compile-time constant.
> 
> Don't specify MAP_FIXED for MAP_SHARED mapping if you want
> proper coherency, that's my answer for this one.

I can't safely set up this kind of mapping without MAP_FIXED, unless I
know SHMLBA.

This is my strategy:

	mmap MAP_ANON without MAP_FIXED to find a free area
	mmap MAP_FIXED over the anon area at same address
	mmap MAP_FIXED over the anon area at larger address

I don't see any strategy that lets me establish this kind of circular
mapping on Sparc without either (a) knowing the value of SHMLBA, or
(b) risking clobbering another thread's mmap.

> > 	3. Is there a kernel bug on Sparc, because the test program
> > 	   is either getting mappings that aren't aligned to run time
> > 	   SHMLBA, or the kernel's run time SHMLBA value is not correct.
> 
> No, the user is allowed to hang himself with MAP_FIXED.
> The bug is in your code :)

Well, my code has no bug because I do run-time tests to see what
rubbish the architecture gave me.  As we see, they work :)

I don't see any real alternative to doing that.  But that's ok, it
seems robust and portable.  It's a shame about the slow cache flush,
because I can sometimes use fast cache flushing to improve my DSP
buffering algorithms.

> > 	2. Is flushing part of the data cache something I can do from
> > 	   userspace?  (I'll figure out the exact machine instructions
> > 	   myself if I need to do this, but it'd be nice to know if
> > 	   it's possible before I have a go).
> 
> There is no efficient way to do this from userspace, only the
> kernel has access to the more efficient cache flushing instructions.
> You'd need to flush via loads to displace the aliasing cache lines.

Will msync() do it?

Thanks,
-- Jamie
