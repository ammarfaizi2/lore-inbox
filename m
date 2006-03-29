Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWC2PLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWC2PLA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 10:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWC2PLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 10:11:00 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:35970 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750733AbWC2PLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 10:11:00 -0500
Date: Wed, 29 Mar 2006 17:08:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: emin ak <eminak71@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt10 crash on ppc
Message-ID: <20060329150815.GA24741@elte.hu>
References: <2cf1ee820603270656w6697778ai83935217ea5ab3a5@mail.gmail.com> <2cf1ee820603271231l69187925j3150098097c7ca15@mail.gmail.com> <44288FB3.5030208@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44288FB3.5030208@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Normally what will happen is that kswapd will be woken up, and 
> ksoftirqd will start throttling (soft) interrupts and kswapd will be 
> allowed to get a chance to run. With the -rt kernel, I guess if your 
> network irq has a higher priority than kswapd, it could prevent it 
> from running completely. (I could be wrong here).
> 
> You might try increasing /proc/sys/vm/min_free_kbytes, or failing 
> that, increase the priority of kswapd to something comparable to or 
> greater than your network interrupt.
> 
> I'm not very familiar with the -rt tree, but possibly what should be 
> happening, if interrupts are executed in process context and allowed 
> to schedule, is that their memory allocations should also be allowed 
> to reclaim memory.

indeed - very good point. Emin, could you try the patch below [which 
isnt a full solution but should be a good first approximation], does it 
make any difference?

> OTOH, I guess for a deterministic realtime system, you need to 
> allocate fixed minimum amounts of memory for each element of the 
> system so you never run out like this.

yeah, preallocation is pretty much the only way to go for deterministic 
workloads. Still, networking (and other complex subsystems) can still be 
used in parallel to deterministic tasks - and those should not be 
starved easier when PREEMPT_RT is enabled. In fact, with the patch below 
it could become much more robust - we could in fact achieve to never 
fail an allocation due to being in an atomic context.

	Ingo

Index: linux/mm/page_alloc.c
===================================================================
--- linux.orig/mm/page_alloc.c
+++ linux/mm/page_alloc.c
@@ -1008,9 +1008,11 @@ nofail_alloc:
 		goto nopage;
 	}
 
+#ifndef CONFIG_PREEMPT_RT
 	/* Atomic allocations - we can't balance anything */
 	if (!wait)
 		goto nopage;
+#endif
 
 rebalance:
 	cond_resched();
