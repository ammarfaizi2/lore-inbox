Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265334AbUGAOQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265334AbUGAOQX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 10:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbUGAOQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 10:16:22 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:56794 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S265334AbUGAOQN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 10:16:13 -0400
Message-ID: <40E41BE1.1010003@pacbell.net>
Date: Thu, 01 Jul 2004 07:12:49 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Ian Molton <spyro@f2s.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC] on-chip coherent memory API for DMA
References: <1088518868.1862.18.camel@mulgrave>
In-Reply-To: <1088518868.1862.18.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> 
> dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
> dma_addr_t device_addr, size_t size, int flags)
> 
> ...
> 
> The flags is where all the magic is.  They can be or'd together and are
> 
> DMA_MEMORY_MAP - request that the memory returned from
> dma_alloc_coherent() be directly writeable.
> 
> DMA_MEMORY_IO - request that the memory returned from
> dma_alloc_coherent() be addressable using read/write/memcpy_toio etc.

The API looked OK except this part didn't make sense to me, since
as I understand things dma_alloc_coherent() is guaranteed to have
the DMA_MEMORY_MAP semantics at all times ... the CPU virtual address
returned may always be directly written.  That's certainly how all
the code I've seen using dma_alloc_coherent() works.

It'd make more sense if the routine were "dma_declare_memory()", and
DMA_MEMORY_MAP meant it was OK to return from dma_alloc_coherent(),
while DMA_MEMORY_IO meant the dma_alloc_coherent() would always fail.

If I understand what you're trying to do, DMA_MEMORY_IO supports a
new kind of DMA memory, and is necessary to work on those IBM boxes
you were talking about ... where dma_alloc_coherent() can't work,
and the "indirectly accessible" memory would need to be allocated
using some new alloc/free API.  Or were you maybe trying to get at
that "can be mmapped to userspace" distinction?


Also in terms of implementation, I noticed that if there's a
dev->dma_mem, the GFP_* flags are ignored.  For __GFP_NOFAIL
that seems buglike, but not critical.  (Just looked at x86.)
Might be worth just passing the flags down so that behavior
can be upgraded later.

- Dave




