Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265701AbUGAOsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbUGAOsb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 10:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265743AbUGAOsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 10:48:31 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:50912 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S265701AbUGAOs2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 10:48:28 -0400
Message-ID: <40E42374.8060407@pacbell.net>
Date: Thu, 01 Jul 2004 07:45:08 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Ian Molton <spyro@f2s.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC] on-chip coherent memory API for DMA
References: <1088518868.1862.18.camel@mulgrave> 	<40E41BE1.1010003@pacbell.net> <1088692004.1887.8.camel@mulgrave>
In-Reply-To: <1088692004.1887.8.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Thu, 2004-07-01 at 09:12, David Brownell wrote:
> 
>>The API looked OK except this part didn't make sense to me, since
>>as I understand things dma_alloc_coherent() is guaranteed to have
>>the DMA_MEMORY_MAP semantics at all times ... the CPU virtual address
>>returned may always be directly written.  That's certainly how all
>>the code I've seen using dma_alloc_coherent() works.
> 
> 
>>It'd make more sense if the routine were "dma_declare_memory()", and
>>DMA_MEMORY_MAP meant it was OK to return from dma_alloc_coherent(),
>>while DMA_MEMORY_IO meant the dma_alloc_coherent() would always fail.
> 
> 
> You need an allocator paired with IO memory.  If the driver allows for
> DMA_MEMORY_IO then it's not unreasonable to expect it to have such
> memory returned by dma_alloc_coherent() rather than adding yet another
> allocator API.

Seems unreasonable to me, unless there's also an API to change
the mode of the dma_alloc_coherent() memory from the normal
"CPU can read/write as usual" to the exotic "need to use special
memory accessors".  (And another to report what mode the API is
in at the current moment.)

And I don't like modal APIs like that, which is why it'd make
more sense to me to have a new allocator API for this new
kind of DMA memory.  (Which IS for that IBM processor, yes?)

Alternatively, modify dma_alloc_coherent() to say what kind
of address it must return.  Since this is a "generic" DMA
API, the caller of dma_alloc_coherent() shouldn't need to be
guessing how they may actually use the memory returned.
That new "must guess" requirement will break some code...


>>Also in terms of implementation, I noticed that if there's a
>>dev->dma_mem, the GFP_* flags are ignored.  For __GFP_NOFAIL
>>that seems buglike, but not critical.  (Just looked at x86.)
>>Might be worth just passing the flags down so that behavior
>>can be upgraded later.
> 
> 
> Actually, there's no point respecting the flags for the on chip region. 
> Either the memory is there or it isn't.  If it isn't there, then you
> either fall through to the ordinary allocator (where the flags are
> respected) or fail if the DMA_MEMORY_EXCLUSIVE flag was specified.

So -- you're saying it's not a bug that a __GFP_NOFAIL|__GFP_WAIT
allocation be able to fail?  Curious.  I'd have thought the API
was clear about that.  Allocating 128 MB from a 1 MB region must
of course fail, but allocating one page just needs a wait/wakeup.

- Dave


