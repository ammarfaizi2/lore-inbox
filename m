Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992721AbWJTTXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992721AbWJTTXM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992722AbWJTTXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:23:12 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57752
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S2992721AbWJTTXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:23:11 -0400
Date: Fri, 20 Oct 2006 12:23:11 -0700 (PDT)
Message-Id: <20061020.122311.30184576.davem@davemloft.net>
To: nickpiggin@yahoo.com.au
Cc: ralf@linux-mips.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
From: David Miller <davem@davemloft.net>
In-Reply-To: <4538DFAC.1090206@yahoo.com.au>
References: <20061019181346.GA5421@linux-mips.org>
	<20061019.155939.48528489.davem@davemloft.net>
	<4538DFAC.1090206@yahoo.com.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Sat, 21 Oct 2006 00:39:40 +1000

> So moving the flush_cache_mm below the copy_page_range, to just
> before the flush_tlb_mm, would work then? This would make the
> race much smaller than with this patchset.
> 
> But doesn't that still leave a race?
> 
> What if another thread writes to cache after we have flushed it
> but before flushing the TLBs? Although we've marked the the ptes
> readonly, the CPU won't trap if the TLB is valid? There must be
> some special way for the arch to handle this, but I can't see it.

Also, it is actually the case that doing page-by-page cache flushes
can be cheaper than flush_mm_cache() on certain cpus.  Very few cpus
that need this cache flushing provide a "context" based cache flush.

On cpus like the mentioned hypersparc, there is no way to do a
"context" flush of the cache, so we flush the entire multi-megabyte L2
cache.  Actually, it allows to flush only "user" cache lines which
keeps the kernel cache lines in there, but still it's very expensive.
