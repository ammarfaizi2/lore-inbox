Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbVIZTwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVIZTwI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 15:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbVIZTwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 15:52:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1220
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932488AbVIZTwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 15:52:07 -0400
Date: Mon, 26 Sep 2005 12:52:03 -0700 (PDT)
Message-Id: <20050926.125203.132216841.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: update_mmu_cache(): fault or not fault ?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1127721788.15882.64.camel@gaston>
References: <1127715725.15882.43.camel@gaston>
	<20050926.004123.47346085.davem@davemloft.net>
	<1127721788.15882.64.camel@gaston>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 26 Sep 2005 18:03:08 +1000

> > Although, I'm ambivalent as to whether prefilling helps at all.
> 
> If it's really only ever done on faults, I fail to see how it can hurt
> at least, since we are basically just removing the cost of a second
> exception. Wether it's useful in practice probably depends on the cost
> of taking such an exception on a given CPU. Difficult to say without
> some benchmarking...

I guess my ambivalence comes from some aspects of how sparc64 TLB
refilling works.

When you take the TLB miss, the cpu sets up all of these things for
the TLB reload that you have to do by hand if you want to do the
TLB refill in some other context.

There is an MMU register which holds the page aligned virtual address
and the MMU context value.  Next, there is a register where you
write the TLB "tag" which contains the PTE entry and, the write to
this register is what performs the TLB load up.  (it uses the virtual
address + context value to figure out where to place the PTE entry,
and the PTE itself comes from the store source register)

At TLB miss time, the MMU automatically fills in the virutal address
+ context register, and all you have to do is store the PTE value
and you're done.  Whereas in a context like update_mmu_cache() I
have to setup that value as well.

Things get more complicated on UltraSPARC-III+ and later, which have
one 16-entry CAM D-TLB and two indexed 512-entry D-TLBs.  You can
configure each 512-entry D-TLB to hold a parituclar page size.  (So
for the kernel, for example, I configure the first one to hold 4MB
pages, and the second one for 8K pages) It is configurable by context.
So to do a TLB refill on these chips it has to know which of these 3
TLBs gets the write enable when you load in the PTE value.  It does
this with a register that holds the page size configuration for the
active context at the time of the TLB miss.

So this is yet another register I'd have to load by hand to load the
TLB at update_mmu_cache() time.

I also have to disable interrupts so that TLB loading (which requires
multiple stores and is thus not atomic) does not get interrupted by a
cross-cpu call that flushes the TLB or similar.

So this is a ton of complication, which is straightforwardly done in
the TLB miss handler.  And if you think about it, since we've been
writing the PTE entries and walking the page tables for fault
processing, all of this will be hot in the L2 cache when we take
the nearly immediate TLB miss.

Anyways, I'm very likely going to remove the prefilling of TLB entries
on sparc64.  I hope it's more beneficial and less complicated for ppc64
:-)
