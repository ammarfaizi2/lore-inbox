Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264640AbUFSUmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264640AbUFSUmD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 16:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUFSUmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 16:42:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3592 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264650AbUFSUlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 16:41:42 -0400
Date: Sat, 19 Jun 2004 21:41:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Brownell <david-b@pacbell.net>
Cc: James Bottomley <James.Bottomley@steeleye.com>, Ian Molton <spyro@f2s.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-ID: <20040619214126.C8063@flint.arm.linux.org.uk>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	James Bottomley <James.Bottomley@steeleye.com>,
	Ian Molton <spyro@f2s.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com,
	tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com
References: <1087584769.2134.119.camel@mulgrave> <20040618195721.0cf43ec2.spyro@f2s.co <40D34078.5060909@pacbell.net> <20040618204438.35278560.spyro@f2s.com> <1087588627.2134.155.camel@mulgrave <40D359BB.3090106@pacbell.net> <1087593282.2135.176.camel@mulgrave> <40D36EDE.2080803@pacbell.net> <1087600052.2135.197.camel@mulgrave> <40D4849B.3070001@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40D4849B.3070001@pacbell.net>; from david-b@pacbell.net on Sat, Jun 19, 2004 at 11:23:23AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 11:23:23AM -0700, David Brownell wrote:
> I'm having to guess at your point here, even from other emails.
> You've asserted a difference, but not what it is.  Maybe it's
> something to do with the problem's NUMA nature?  Are you for
> some reason applying DMA _mapping_ requirements (main-memory
> only) to the DMA memory _allocation_ problem?

I suspect the problem is concerning how Linux backs the memory and
what is assumed to be backing memory returned from the DMA coherent
API.

Currently, there are drivers which assume that it's possible that
dma_alloc_coherent memory is backed by system memory, which has
page structures associated with each page.  For this "new" memory,
there are no such page structures, so things like bus_to_virt()
don't work on them (not that they were guaranteed to work on a
dma_addr_t _anyway_ but that doesn't stop driver authors thinking
that they do work - and as code presently stands, they do indeed
work.)

In addition, the ARM implementation of dma_alloc_coherent()
implicitly believes in struct page pointers - they're a fundamental
properly of the way that has been implemented, so any deviation from
"memory with struct page" means more or less a rewrite this.

I would say that, yes, from a perfectly objective view, if you are
unable to do coherent DMA from system memory, but your system provides
you with a totally separate memory system which does indeed provide
coherent DMA, it seems logical to allow dma_alloc_coherent() to use
it - at risk of breaking some drivers making incorrect assumptions.

And I don't see _that_ case as being vastly different from Ian's
case.

So, I think as long as we can ensure that drivers do not make bad
assumptions about dma_alloc_coherent() _and_ we have a suitable DMA
MMAP API to solve the cases where device drivers want to mmap DMA
buffers (and they _do_ want to do this) it should be possible.

Depending on how I look at the problem, I'm oscillating between "yes
it should be done" (if its an overall system thing like DMA memory
on a PCI north bridge separate from your normal system non-DMA
memory) and "no it's out of the question."

> Well, no other memory in the entire system meets the requirements
> for the dma_alloc_coherent() API, since _only that_ chunk of memory
> is works with that device's DMA hardware.  Which is the fundamental
> problem that needs to be solved.  It can clearly done at the platform
> level, using device- or bus-specific implementations.

The counter-argument here is to consider the case of video cards.
They do almost continuous DMA from on-board RAM, yet the DMA API
doesn't get involved...

So I'm afraid I'm sitting on the fence between the two sides not
really knowing which side to fall off to.  It sounds to me like
other people here are in a similar situation.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
