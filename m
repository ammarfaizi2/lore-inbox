Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265293AbUFTUDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbUFTUDy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 16:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265930AbUFTUDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 16:03:54 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:55451 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S265293AbUFTUDv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 16:03:51 -0400
Message-ID: <40D5ED56.4060409@pacbell.net>
Date: Sun, 20 Jun 2004 13:02:30 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: James Bottomley <James.Bottomley@steeleye.com>, Ian Molton <spyro@f2s.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
References: <1087584769.2134.119.camel@mulgrave> <20040618195721.0cf43ec2.spyro@f2s.co <40D34078.5060909@pacbell.net> <20040618204438.35278560.spyro@f2s.com> <1087588627.2134.155.camel@mulgrave <40D359BB.3090106@pacbell.net> <1087593282.2135.176.camel@mulgrave> <40D36EDE.2080803@pacbell.net> <1087600052.2135.197.camel@mulgrave> <40D4849B.3070001@pacbell.net> <20040619214126.C8063@flint.arm.linux.org.uk>
In-Reply-To: <20040619214126.C8063@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Sat, Jun 19, 2004 at 11:23:23AM -0700, David Brownell wrote:
> 
>>I'm having to guess at your point here, even from other emails.
>>You've asserted a difference, but not what it is.  Maybe it's
>>something to do with the problem's NUMA nature?  Are you for
>>some reason applying DMA _mapping_ requirements (main-memory
>>only) to the DMA memory _allocation_ problem?
> 
> ...
> 
> Currently, there are drivers which assume that it's possible that
> dma_alloc_coherent memory is backed by system memory, which has
> page structures associated with each page.  For this "new" memory,
> there are no such page structures, so things like bus_to_virt()
> don't work on them (not that they were guaranteed to work on a

This shouldn't include the USB stack, FWIW; nothing in drivers/usb
makes such calls (on 2.6).  The device drivers don't have any
reason to use such calls, either.


> In addition, the ARM implementation of dma_alloc_coherent()
> implicitly believes in struct page pointers - they're a fundamental
> properly of the way that has been implemented, so any deviation from
> "memory with struct page" means more or less a rewrite this.

Or just bypassing it before it gets to __dma_alloc(), which would
be ugly but functional.  Or flagging the devices in question as
needing to use that particular memory zone ... so for example a
dma_zone(dev) macro, used with alloc_pages_node(), might be a
cleaner approach.


> I would say that, yes, from a perfectly objective view, if you are
> unable to do coherent DMA from system memory, but your system provides
> you with a totally separate memory system which does indeed provide
> coherent DMA, it seems logical to allow dma_alloc_coherent() to use
> it - at risk of breaking some drivers making incorrect assumptions.
> 
> And I don't see _that_ case as being vastly different from Ian's
> case.

That's hardly a vast difference, no!


> So, I think as long as we can ensure that drivers do not make bad
> assumptions about dma_alloc_coherent() _and_ we have a suitable DMA
> MMAP API to solve the cases where device drivers want to mmap DMA
> buffers (and they _do_ want to do this) it should be possible.

Right, and the whole USB stack should "just work" once that's done.
Subject to memory cramping for some uses!  :)


> Depending on how I look at the problem, I'm oscillating between "yes
> it should be done" (if its an overall system thing like DMA memory
> on a PCI north bridge separate from your normal system non-DMA
> memory) and "no it's out of the question."

I'm clearly on the "yes" side, though I suspect Deepak is right
that doing it very cleanly as an all-arch extension may not be
a near-term 2.6 option.

- Dave



