Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265502AbUGAO2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265502AbUGAO2B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 10:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265470AbUGAO1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 10:27:10 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:30085 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265515AbUGAO0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 10:26:49 -0400
Subject: Re: [RFC] on-chip coherent memory API for DMA
From: James Bottomley <James.Bottomley@steeleye.com>
To: David Brownell <david-b@pacbell.net>
Cc: Ian Molton <spyro@f2s.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <40E41BE1.1010003@pacbell.net>
References: <1088518868.1862.18.camel@mulgrave> 
	<40E41BE1.1010003@pacbell.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 01 Jul 2004 09:26:42 -0500
Message-Id: <1088692004.1887.8.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-01 at 09:12, David Brownell wrote:
> The API looked OK except this part didn't make sense to me, since
> as I understand things dma_alloc_coherent() is guaranteed to have
> the DMA_MEMORY_MAP semantics at all times ... the CPU virtual address
> returned may always be directly written.  That's certainly how all
> the code I've seen using dma_alloc_coherent() works.

> It'd make more sense if the routine were "dma_declare_memory()", and
> DMA_MEMORY_MAP meant it was OK to return from dma_alloc_coherent(),
> while DMA_MEMORY_IO meant the dma_alloc_coherent() would always fail.

You need an allocator paired with IO memory.  If the driver allows for
DMA_MEMORY_IO then it's not unreasonable to expect it to have such
memory returned by dma_alloc_coherent() rather than adding yet another
allocator API.

> If I understand what you're trying to do, DMA_MEMORY_IO supports a
> new kind of DMA memory, and is necessary to work on those IBM boxes
> you were talking about ... where dma_alloc_coherent() can't work,
> and the "indirectly accessible" memory would need to be allocated
> using some new alloc/free API.  Or were you maybe trying to get at
> that "can be mmapped to userspace" distinction?

No, this IO vs MAP thing is can be mapped directly to *kernel* space.
i.e. whether the driver can use it via ordinary dereferencing or has to
use the I/O memory accessor functions.

> Also in terms of implementation, I noticed that if there's a
> dev->dma_mem, the GFP_* flags are ignored.  For __GFP_NOFAIL
> that seems buglike, but not critical.  (Just looked at x86.)
> Might be worth just passing the flags down so that behavior
> can be upgraded later.

Actually, there's no point respecting the flags for the on chip region. 
Either the memory is there or it isn't.  If it isn't there, then you
either fall through to the ordinary allocator (where the flags are
respected) or fail if the DMA_MEMORY_EXCLUSIVE flag was specified.

James

