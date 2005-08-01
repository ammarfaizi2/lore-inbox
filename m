Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVHAQfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVHAQfu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 12:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVHAQft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 12:35:49 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:24548 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261822AbVHAQfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 12:35:42 -0400
To: "David S. Miller" <davem@davemloft.net>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3: cache flush missing from somewhere
References: <20050729161343.A18249@flint.arm.linux.org.uk>
	<20050730.124052.104057695.davem@davemloft.net>
	<tnxzms1c0bf.fsf@arm.com>
	<20050801.083505.88343974.davem@davemloft.net>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 01 Aug 2005 17:34:19 +0100
In-Reply-To: <20050801.083505.88343974.davem@davemloft.net> (David S.
 Miller's message of "Mon, 01 Aug 2005 08:35:05 -0700 (PDT)")
Message-ID: <tnxirypboqc.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Aug 2005 16:34:50.0613 (UTC) FILETIME=[F0163A50:01C596B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> wrote:
> The "lazy dcache flushing" he mentioned only flushes on the
> processor where the store occurred, not on any other cpus.
>
> He took the sparc64 code which, at the time of the flush_dcache_page()
> call, stores the current cpu number in the page->flags and sets a
> bit indicating a flush is needed.  When some condition occurs
> requiring the delayed flush to occur, we look at the cpu number
> in the page and ask that specific cpu to do the flush.

That's a point I missed. The D-cache flushing should take place on the
CPU that wrote the page, not the one that got the page fault (and the
I-cache invalidation on all the CPUs). I don't see why this wouldn't
work.

> I've seen implementations where the I-cache does not snoop local cpu
> stores, but I've never seen one where other cpus do not snoop such
> stores.

On this ARM SMP implementation, only the D-cache snoops the other CPUs
stores, not the I-cache.

> You _HAVE_ to implement handling of I-cache update on L2
> cache line changes to handle updates from devices doing DMA, so why
> in the world special case stores done by other cpus?
>
> It almost sounds impossible to implement this and have the I-cache
> be coherent wrt. DMA transactions.

Shouldn't flush_dcache_page() be called anyway when a page is modified
by the kernel (or by a device via DMA)? With the Harvard cache
architecture in ARM, the I cache should be invalidated even in a
uniprocessor system. For SMP it is just a matter of invalidating it on
all the CPUs (done by issuing an inter-processor interrupt).

> Do you have to flush the whole I-cache every time some device DMAs
> a page into memory, before you can execute instructions out of it?

IMHO, it only needs invalidating the I-cache corresponding to the
DMA'ed page, not the whole I-cache but, as I said, this should be
handled by flush_dcache_page, whether lazily or not.

Thanks,

-- 
Catalin

