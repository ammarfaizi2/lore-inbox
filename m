Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266209AbUGASEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266209AbUGASEi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 14:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266212AbUGASEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 14:04:38 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:36482 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266209AbUGASEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 14:04:33 -0400
Subject: Re: [RFC] on-chip coherent memory API for DMA
From: James Bottomley <James.Bottomley@steeleye.com>
To: David Brownell <david-b@pacbell.net>
Cc: Ian Molton <spyro@f2s.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <40E42374.8060407@pacbell.net>
References: <1088518868.1862.18.camel@mulgrave>
		<40E41BE1.1010003@pacbell.net> <1088692004.1887.8.camel@mulgrave> 
	<40E42374.8060407@pacbell.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 01 Jul 2004 13:04:20 -0500
Message-Id: <1088705063.1919.16.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-01 at 09:45, David Brownell wrote:
> Seems unreasonable to me, unless there's also an API to change
> the mode of the dma_alloc_coherent() memory from the normal
> "CPU can read/write as usual" to the exotic "need to use special
> memory accessors".  (And another to report what mode the API is
> in at the current moment.)

No. That's why you specify how you'd like the memory to be treated.  If
you don't want the memory to be accessible only via IO accessors, then
you specify DMA_MEMORY_MAP and take the failure if the platform can't
handle it.

> And I don't like modal APIs like that, which is why it'd make
> more sense to me to have a new allocator API for this new
> kind of DMA memory.  (Which IS for that IBM processor, yes?)

There is no "new" kind of memory.  This is currently how *all* I/O
memory is accessed.  DMA_MEMORY_MAP is actually the new bit since it
allows I/O memory to be treated as normal memory.

> Alternatively, modify dma_alloc_coherent() to say what kind
> of address it must return.  Since this is a "generic" DMA
> API, the caller of dma_alloc_coherent() shouldn't need to be
> guessing how they may actually use the memory returned.
> That new "must guess" requirement will break some code...

There is no "must guess".  Either the driver specifies DMA_MEMORY_MAP or
DMA_MEMORY_IO.  If you specify DMA_MEMORY_IO then you have to use
accessors for dma_alloc_coherent() memory.  If you never wish to bother
with it, simply specify DMA_MEMORY_MAP and take the failure on platforms
which cannot comply.

> So -- you're saying it's not a bug that a __GFP_NOFAIL|__GFP_WAIT
> allocation be able to fail?  Curious.  I'd have thought the API
> was clear about that.  Allocating 128 MB from a 1 MB region must
> of course fail, but allocating one page just needs a wait/wakeup.

It can *only* happen if you specify DMA_MEMORY_EXCLUSIVE; that preempts
the GFP_ flags and the application must be coded with this in mind. 
Otherwise it will respect the GFP_ flags.

James


