Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVHAPgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVHAPgF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 11:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVHAPgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 11:36:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:26523
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261209AbVHAPfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 11:35:05 -0400
Date: Mon, 01 Aug 2005 08:35:05 -0700 (PDT)
Message-Id: <20050801.083505.88343974.davem@davemloft.net>
To: catalin.marinas@arm.com
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3: cache flush missing from somewhere
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <tnxzms1c0bf.fsf@arm.com>
References: <20050729161343.A18249@flint.arm.linux.org.uk>
	<20050730.124052.104057695.davem@davemloft.net>
	<tnxzms1c0bf.fsf@arm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 01 Aug 2005 13:24:04 +0100

> "David S. Miller" <davem@davemloft.net> wrote:
> > If not, you cannot use the lazy dcache flushing method, and in fact
> > you must broadcast the flush on all processors.
> 
> Why wouldn't the lazy dcache flushing method work? My understanding is
> that if there is no user mapping for a given page, there's no reason
> to flush the dcache and just postpone it until the page is faulted
> in. When the page fault occurs the dcache should be flushed (on one
> CPU is enough) and the icache invalidated on all the CPUs.

The "lazy dcache flushing" he mentioned only flushes on the
processor where the store occurred, not on any other cpus.

He took the sparc64 code which, at the time of the flush_dcache_page()
call, stores the current cpu number in the page->flags and sets a
bit indicating a flush is needed.  When some condition occurs
requiring the delayed flush to occur, we look at the cpu number
in the page and ask that specific cpu to do the flush.

This works perfectly for what sparc64 is trying to do, which is deal
with bad aliasing in a virtually indexed D-cache where only the cpu
who does the store has to do any flushing, but that won't work for
this ARM SMP case at all.

I've seen implementations where the I-cache does not snoop local cpu
stores, but I've never seen one where other cpus do not snoop such
stores.  You _HAVE_ to implement handling of I-cache update on L2
cache line changes to handle updates from devices doing DMA, so why
in the world special case stores done by other cpus?

It almost sounds impossible to implement this and have the I-cache
be coherent wrt. DMA transactions.

Do you have to flush the whole I-cache every time some device DMAs
a page into memory, before you can execute instructions out of it?
