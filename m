Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbVIZIDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVIZIDs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 04:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVIZIDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 04:03:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:34495 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750741AbVIZIDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 04:03:47 -0400
Subject: Re: update_mmu_cache(): fault or not fault ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050926.004123.47346085.davem@davemloft.net>
References: <1127715725.15882.43.camel@gaston>
	 <20050926.004123.47346085.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 18:03:08 +1000
Message-Id: <1127721788.15882.64.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You can track this in your port specific code.  That's what I do on
> sparc64 to deal with this case.  I record the TLB miss type (D or I
> tlb), and also whether a write occurred, in a bitmask.  Then I check
> this in update_mmu_cache() to decide whether to prefill.
> 
> I store it in current_thread_info() and clear it at the end of fault
> processing.
> 
> Just grep for "FAULT_CODE_*" in the sparc64 code to see how this
> works.

Yup, that would work, thanks. I'll look into it. I just did something
similar on ppc64 for i/d cache coherency. On CPUs with support for no
executable pages, we map pages non-exec and do the cache flush on the
resulting exec fault. That means however that when faulting in text
pages that haven't been used yet (typically app launch), we would take
the linux page fault, put a PTE in, have update_mmu_cache() put a read
HPTE in the hash table without exec permission, then take a new fault
(exec permission violation), do the flush & return.

I just hacked in some code to test in update_mmu_cache() (just using
current->thread.regs->trap for now) if we come from an instruction
access exception, then do the cache sync and hash in an executable HPTE
(if the linux PTE is executable of course) directly so we avoid the
double fault. It's currently deep into a patch that does many more
things, so I didn't yet have a chance to bench separately, but I'll try
to get some numbers, might grab a little bit more perfs on app launch on
my G5 :)

> Although, I'm ambivalent as to whether prefilling helps at all.

If it's really only ever done on faults, I fail to see how it can hurt
at least, since we are basically just removing the cost of a second
exception. Wether it's useful in practice probably depends on the cost
of taking such an exception on a given CPU. Difficult to say without
some benchmarking...

Ben.


