Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWAJP7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWAJP7c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 10:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWAJP7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 10:59:32 -0500
Received: from mx.pathscale.com ([64.160.42.68]:51860 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751132AbWAJP7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 10:59:31 -0500
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060110011844.7a4a1f90.akpm@osdl.org>
References: <patchbomb.1136579193@eng-12.pathscale.com>
	 <d286502c3b3cd6bcec7b.1136579194@eng-12.pathscale.com>
	 <20060110011844.7a4a1f90.akpm@osdl.org>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Tue, 10 Jan 2006 07:59:21 -0800
Message-Id: <1136908761.32183.18.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 01:18 -0800, Andrew Morton wrote:
> "Bryan O'Sullivan" <bos@pathscale.com> wrote:
> >
> > This arch-independent routine copies data to a memory-mapped I/O region,
> >  using 32-bit accesses.  It does not guarantee access ordering, nor does
> >  it perform a memory barrier afterwards.  This style of access is required
> >  by some devices.
> 
> Not providing orderingor barriers makes this a rather risky thing to export
> - people might use it, find their driver "works" on one architecture, but
> fails on another.

The kdoc comments for the routine clearly state these limitations, so I
hope that between the comments and the naming, the risk is minimal.

> I guess the "__" is a decent warning of this, and the patch anticipates a
> higher-level raw_memcpy_toio32() which implements those things, yes?

It leaves room for it, yes, though I don't see much reason to add such a
routine until a driver specifically needs it.

> How come __raw_memcpy_toio32() is inlined?

There's no technical reason for it to be.  I'm simply trying to find an
acceptable way to get the code into the tree that accommodates per-arch
implementations.

So let me rewind a little and state my problem.

My driver needs a copy routine that works in 32-bit chunks, writes to
MMIO space, doesn't care about ordering, and doesn't guarantee a memory
barrier.  It also very much wants individual arches to be able to
implement this routine themselves; even though it's a small, simple
loop, we've benchmarked our x86_64 version as giving us 5% better
performance overall (i.e. visible to apps, not just microbenchmarks)
when doing reasonably large copies.  I'd expect other arches to have
similar benefits.

I'm more than willing to recast the code into whatever form makes people
happy, but it would be greatly beneficial to me if it also met my
requirements.

So far, my attempts have been thus:

      * out of line, with __HAVE_ARCH_XXX to avoid bloat on arches that
        have specialised implementations - __HAVE_ARCH_XXX is out of
        style
      * out of line, unconditional - made people unhappy on bloat
        grounds, since arches that have specialised implementations end
        up with an extra unneeded routine
      * inline, apparently in Linus's preferred style - an inline that
        isn't really necessary

For a routine whose C implementation is six lines long, it's had an
impressive submission history :-)

What do you suggest I try next?  I'll be happy to try a different tack.

	<b

