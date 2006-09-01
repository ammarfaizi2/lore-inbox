Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWIAWnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWIAWnF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 18:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWIAWnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 18:43:05 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:43965 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751139AbWIAWnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 18:43:04 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Adrian Bunk <bunk@stusta.de>,
       Tom Tucker <tom@opengridcomputing.com>,
       Steve Wise <swise@opengridcomputing.com>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.18-rc5-mm1: drivers/infiniband/hw/amso1100/c2.c compile error
X-Message-Flag: Warning: May contain useful information
References: <20060901015818.42767813.akpm@osdl.org>
	<20060901160023.GB18276@stusta.de>
	<20060901101340.962150cb.akpm@osdl.org> <adak64nij8f.fsf@cisco.com>
	<20060901112312.5ff0dd8d.akpm@osdl.org> <ada8xl3ics4.fsf@cisco.com>
	<20060901130444.48f19457.akpm@osdl.org>
	<20060901204343.GA4979@flint.arm.linux.org.uk>
	<20060901135911.bc53d89a.akpm@osdl.org> <adar6yvguvz.fsf@cisco.com>
	<20060901142606.4f5c1152.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 01 Sep 2006 15:42:55 -0700
In-Reply-To: <20060901142606.4f5c1152.akpm@osdl.org> (Andrew Morton's message of "Fri, 1 Sep 2006 14:26:06 -0700")
Message-ID: <adamz9jgqds.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Sep 2006 22:42:56.0626 (UTC) FILETIME=[F7F55D20:01C6CE17]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> It depends on how many other devices have (or are expected
    Andrew> to have) mthca-like requirements.  If the answer is "very
    Andrew> few, maybe none" then perhaps we don't need to go
    Andrew> designing generic interfaces to support such things.

I actually don't know of any others -- not that I'm an expert on the
range of devices that exist...

What's your feeling about drivers like amso1100, which don't
particularly care about atomicity, but just want to write a 64-bit
quantity conveniently?  Should we require writeq()/__raw_writeq() for
all archs, and then define CONFIG_ARCH_HAS_64BIT_ATOMIC_MMIO_WRITES as
appropriate?

I see stuff like this is drivers/dma/ioatdma.c:

#if (BITS_PER_LONG == 64)
	ioatdma_chan_write64(ioat_chan, IOAT_CHAINADDR_OFFSET, desc->phys);
#else
	ioatdma_chan_write32(ioat_chan,
	                     IOAT_CHAINADDR_OFFSET_LOW,
	                     (u32) desc->phys);
	ioatdma_chan_write32(ioat_chan, IOAT_CHAINADDR_OFFSET_HIGH, 0);
#endif

and drivers/char/hpet.c:

#ifndef readq
static inline unsigned long long readq(void __iomem *addr)
{
	return readl(addr) | (((unsigned long long)readl(addr + 4)) << 32LL);
}
#endif

#ifndef writeq
static inline void writeq(unsigned long long v, void __iomem *addr)
{
	writel(v & 0xffffffff, addr);
	writel(v >> 32, addr + 4);
}
#endif

and so on...

 - R.

-- 
VGER BF report: H 0
