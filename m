Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263123AbVG3Tks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263123AbVG3Tks (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbVG3Tks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:40:48 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:39884
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S263123AbVG3Tkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:40:45 -0400
Date: Sat, 30 Jul 2005 12:40:52 -0700 (PDT)
Message-Id: <20050730.124052.104057695.davem@davemloft.net>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3: cache flush missing from somewhere
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050729161343.A18249@flint.arm.linux.org.uk>
References: <20050729161343.A18249@flint.arm.linux.org.uk>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Fri, 29 Jul 2005 16:13:43 +0100

> My current patch to get this working is below.  The only thing which
> really seems to fix the issue is the __flush_dcache_page call in
> read_pages() - if I remove this, I get spurious segfaults and illegal
> instruction faults.

If one cpu stores, does it get picked up in the other cpu's I-cache?
If not, you cannot use the lazy dcache flushing method, and in fact
you must broadcast the flush on all processors.

> If I make flush_dcache_page() non-lazy, this also fixes it, but this
> is not desirable.  The problem also goes away if I disable the write
> allocate cache mode.

Strange.

> If I call __flush_dcache_page() from update_mmu_cache() (iow, always
> ensure that we have I/D coherency when the page is mapped into user
> space) the effect is the same - I see random faults.

You have to do the flush on the processor that does the store,
at a minimum.  But if other cpus have no way to "notice" stores
on other cpus in their I-cache, this alone is not sufficient.

Based upon your report, I strongly suspect that remote I-caches
do not see cpu local stores when the cache is in write allocate
mode.  If this is true, it's a horrible design decision for an
SMP system :(

> To me, it feels like there's a path which results in pages mapped into
> user space without update_mmu_cache() being called, but I'm unable to
> find it.  Ideas?

Ptrace can make this occur, but that's obviously not what you're
seeing here.
