Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUFSVqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUFSVqz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 17:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264728AbUFSVqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 17:46:54 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:37345 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264726AbUFSVqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 17:46:52 -0400
Subject: Re: DMA API issues
From: James Bottomley <James.Bottomley@steeleye.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Brownell <david-b@pacbell.net>, Ian Molton <spyro@f2s.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com
In-Reply-To: <20040619214126.C8063@flint.arm.linux.org.uk>
References: <1087584769.2134.119.camel@mulgrave>
	<20040618195721.0cf43ec2.spyro@f2s.co <40D34078.5060909@pacbell.net>
	<20040618204438.35278560.spyro@f2s.com> <1087588627.2134.155.camel@mulgrave
	<40D359BB.3090106@pacbell.net> <1087593282.2135.176.camel@mulgrave>
	<40D36EDE.2080803@pacbell.net> <1087600052.2135.197.camel@mulgrave>
	<40D4849B.3070001@pacbell.net> 
	<20040619214126.C8063@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 19 Jun 2004 16:46:42 -0500
Message-Id: <1087681604.2121.96.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-19 at 15:41, Russell King wrote:
> I suspect the problem is concerning how Linux backs the memory and
> what is assumed to be backing memory returned from the DMA coherent
> API.

More or less, yes.  The basic problem is platforms that simply cannot
make this type of bus remote memory visible in the CPU page tables at
all (the IBM AS/400 apparently falls into that).  Then there are the
ones that could be persuaded to do this with great difficulty and a lot
of restrictions (sparc and parisc).

> Currently, there are drivers which assume that it's possible that
> dma_alloc_coherent memory is backed by system memory, which has
> page structures associated with each page.  For this "new" memory,
> there are no such page structures, so things like bus_to_virt()
> don't work on them (not that they were guaranteed to work on a
> dma_addr_t _anyway_ but that doesn't stop driver authors thinking
> that they do work - and as code presently stands, they do indeed
> work.)
> 
> In addition, the ARM implementation of dma_alloc_coherent()
> implicitly believes in struct page pointers - they're a fundamental
> properly of the way that has been implemented, so any deviation from
> "memory with struct page" means more or less a rewrite this.

Yes, I think everyone has more or less a struct page backed allocator,
although we could first consult an exception table hanging off the
device somehow to get around this.

> I would say that, yes, from a perfectly objective view, if you are
> unable to do coherent DMA from system memory, but your system provides
> you with a totally separate memory system which does indeed provide
> coherent DMA, it seems logical to allow dma_alloc_coherent() to use
> it - at risk of breaking some drivers making incorrect assumptions.
> 
> And I don't see _that_ case as being vastly different from Ian's
> case.
> 
> So, I think as long as we can ensure that drivers do not make bad
> assumptions about dma_alloc_coherent() _and_ we have a suitable DMA
> MMAP API to solve the cases where device drivers want to mmap DMA
> buffers (and they _do_ want to do this) it should be possible.

But we still need some sort of fallback where the platform really cannot
do this.  And that fallback is going to be ioremap and all the other
paraphenalia.  So, the thing that bothers me is that if we have to have
the fallback which is identical to what every other driver that uses
on-chip memory does anyway, is there any point to placing this in the
DMA API?

James


