Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266248AbUGAUS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266248AbUGAUS0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 16:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266254AbUGAUS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 16:18:26 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:28884 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S266248AbUGAUSX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 16:18:23 -0400
Message-ID: <40E470A9.3000908@pacbell.net>
Date: Thu, 01 Jul 2004 13:14:33 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Ian Molton <spyro@f2s.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC] on-chip coherent memory API for DMA
References: <1088518868.1862.18.camel@mulgrave>		<40E41BE1.1010003@pacbell.net> <1088692004.1887.8.camel@mulgrave> 	<40E42374.8060407@pacbell.net> <1088705063.1919.16.camel@mulgrave>
In-Reply-To: <1088705063.1919.16.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Thu, 2004-07-01 at 09:45, David Brownell wrote:
> 
>>Seems unreasonable to me, unless there's also an API to change
>>the mode of the dma_alloc_coherent() memory from the normal
>>"CPU can read/write as usual" to the exotic "need to use special
>>memory accessors".  (And another to report what mode the API is
>>in at the current moment.)
> 
> 
> No. That's why you specify how you'd like the memory to be treated.  If
> you don't want the memory to be accessible only via IO accessors, then
> you specify DMA_MEMORY_MAP and take the failure if the platform can't
> handle it.

That can work when the scope of "DMA" knowledge is just
one driver ... but when that driver is plugging into a
framework, it's as likely to be some other code (maybe
a higher level driver) that just wants RAM address space
which, for whatever reasons, is DMA-coherent.  And hey,
the way to get this is dma_alloc_coherent ... or in some
cases, pci_alloc_consistent.

Which is why my comment was that the new feature of
returning some kind of memory cookie usable on that one
IBM box (etc) should just use a different allocator API.
It doesn't allocate RAM "similarly to __get_free_pages";
it'd be returning something drivers can't treat as RAM.


>>And I don't like modal APIs like that, which is why it'd make
>>more sense to me to have a new allocator API for this new
>>kind of DMA memory.  (Which IS for that IBM processor, yes?)
> 
> 
> There is no "new" kind of memory.  This is currently how *all* I/O
> memory is accessed.  DMA_MEMORY_MAP is actually the new bit since it
> allows I/O memory to be treated as normal memory.

This isn't I/O address space, needing PIO I/O accessors,
and as returned by the new DMA_MEMORY_IO mode.  (And why
wouldn't ioremap already handle that?)

This is how to allocate DMA-ready buffers that have certain
characteristics aren't useful only to the lowest level
drivers in the stack.  Drivers depend on alloc_coherent to
behave in the way you (originally) said DMA_MEMORY_MAP works.
The more detailed API specs (DMA-mapping.txt not DMA-API.txt)
are very clear that the behavior is like RAM.


>>So -- you're saying it's not a bug that a __GFP_NOFAIL|__GFP_WAIT
>>allocation be able to fail?  Curious.  I'd have thought the API
>>was clear about that.  Allocating 128 MB from a 1 MB region must
>>of course fail, but allocating one page just needs a wait/wakeup.
> 
> 
> It can *only* happen if you specify DMA_MEMORY_EXCLUSIVE; that preempts
> the GFP_ flags and the application must be coded with this in mind. 
> Otherwise it will respect the GFP_ flags.

You'd have to change the spec to allow that.  Wouldn't it be
a lot simpler to just pass the GFP flags down to that lowlevel
code, so it can eventually start doing what the highlevel code
told it to do?  :)

Special cases make for fragile systems.

- Dave



