Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbTIAJLu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 05:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTIAJLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 05:11:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24978 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262780AbTIAJLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 05:11:11 -0400
Date: Mon, 1 Sep 2003 02:02:03 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: mfedyk@matchmail.com, lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-Id: <20030901020203.1779efe8.davem@redhat.com>
In-Reply-To: <20030901082911.GA1638@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk>
	<20030829154101.GB16319@work.bitmover.com>
	<20030829230521.GD3846@matchmail.com>
	<20030830221032.1edf71d0.davem@redhat.com>
	<20030831224937.GA29239@mail.jlokier.co.uk>
	<20030831223102.3affcb34.davem@redhat.com>
	<20030901064231.GJ748@mail.jlokier.co.uk>
	<20030901000615.28d93760.davem@redhat.com>
	<20030901082911.GA1638@mail.jlokier.co.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Sep 2003 09:29:11 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> David S. Miller wrote:
> > I disagree, MAP_FIXED means "I know what I am doing don't override
> > this unless the mapping area is not available in my address space."
> > You should never specify MAP_FIXED unless you _REALLY_ know what you
> > are doing.
> 
> So explain this from the Sparc architecture code:
> 
> 	if (flags & MAP_FIXED) {
> 		/* We do not accept a shared mapping if it would violate
> 		 * cache aliasing constraints.
> 		 */
> 		if ((flags & MAP_SHARED) && (addr & (SHMLBA - 1)))
> 			return -EINVAL;
> 		return addr;
> 	}
> 
> Ok, I'll explain it :)  At one time, the code did what the comment says,
> but nowadays linux/mm/mmap.c doesn't call arch_get_unmapped_area() for
> MAP_FIXED, so the above code is redundant and misleading.  It already
> mislead me, so please remove it.  sparc and sparc64 both have it.

I take back what I said, I think the -EINVAL behavior is better
and mmap.c should call into this code to verify the requested
mmap() parameters.

> This is my strategy:
> 
> 	mmap MAP_ANON without MAP_FIXED to find a free area
> 	mmap MAP_FIXED over the anon area at same address
> 	mmap MAP_FIXED over the anon area at larger address
> 
> I don't see any strategy that lets me establish this kind of circular
> mapping on Sparc without either (a) knowing the value of SHMLBA, or
> (b) risking clobbering another thread's mmap.

Why do you need the same piece of data mapped to multiple places
in the first place, and why at specific addresses?  It's purely an
optimization of some sort, right?

> Well, my code has no bug because I do run-time tests to see what
> rubbish the architecture gave me.  As we see, they work :)

It doesn't work in just the right set of circumstances, if interrupts
arrive at just the right moment it might flush the bad aliases out
of the cache via displacement during your 'check' phase.

Then during your actual computation you can hit the aliasing problem
silently.

That's just a bad way to do this.

> I don't see any real alternative to doing that.

I'd suggest instead to hardcode the SHMLBA stuff into your sources.

> But that's ok, it seems robust and portable.

Unfortunately, it is anything but robust.

> > There is no efficient way to do this from userspace, only the
> > kernel has access to the more efficient cache flushing instructions.
> > You'd need to flush via loads to displace the aliasing cache lines.
> 
> Will msync() do it?

No.
