Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263150AbVG3ULi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbVG3ULi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 16:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbVG3UJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 16:09:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47114 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261487AbVG3UIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 16:08:12 -0400
Date: Sat, 30 Jul 2005 21:08:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3: cache flush missing from somewhere
Message-ID: <20050730210807.E26592@flint.arm.linux.org.uk>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
References: <20050729161343.A18249@flint.arm.linux.org.uk> <20050730.124052.104057695.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050730.124052.104057695.davem@davemloft.net>; from davem@davemloft.net on Sat, Jul 30, 2005 at 12:40:52PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 12:40:52PM -0700, David S. Miller wrote:
> From: Russell King <rmk+lkml@arm.linux.org.uk>
> > My current patch to get this working is below.  The only thing which
> > really seems to fix the issue is the __flush_dcache_page call in
> > read_pages() - if I remove this, I get spurious segfaults and illegal
> > instruction faults.
> 
> If one cpu stores, does it get picked up in the other cpu's I-cache?

No - there's absolutely no coherency between the I-cache and D-cache.
However, the I-cache and D-cache are individually PIPT.

> If not, you cannot use the lazy dcache flushing method, and in fact
> you must broadcast the flush on all processors.

I guess that answers the question, thanks.

> > If I call __flush_dcache_page() from update_mmu_cache() (iow, always
> > ensure that we have I/D coherency when the page is mapped into user
> > space) the effect is the same - I see random faults.
> 
> You have to do the flush on the processor that does the store,
> at a minimum.  But if other cpus have no way to "notice" stores
> on other cpus in their I-cache, this alone is not sufficient.
> 
> Based upon your report, I strongly suspect that remote I-caches
> do not see cpu local stores when the cache is in write allocate
> mode.  If this is true, it's a horrible design decision for an
> SMP system :(

I'm now told that the system is only coherent with the caches in
write back write allocate mode, which is rather odd since it appears
stable with write back read allocate.  However, I'll forward your
comments back to the designers.

Thanks David.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
