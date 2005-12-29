Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbVL2RP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbVL2RP7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 12:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbVL2RP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 12:15:59 -0500
Received: from relais.videotron.ca ([24.201.245.36]:14889 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750869AbVL2RP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 12:15:58 -0500
Date: Thu, 29 Dec 2005 12:15:57 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 1/3] mutex subsystem: trylock
In-reply-to: <43B3A5F2.5060903@yahoo.com.au>
X-X-Sender: nico@localhost.localdomain
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0512291148560.3309@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051223161649.GA26830@elte.hu>
 <Pine.LNX.4.64.0512261411530.1496@localhost.localdomain>
 <1135685158.2926.22.camel@laptopd505.fenrus.org>
 <20051227131501.GA29134@elte.hu>
 <Pine.LNX.4.64.0512282222400.3309@localhost.localdomain>
 <20051229083333.GA31003@elte.hu> <43B3A5F2.5060903@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2005, Nick Piggin wrote:

> FWIW, I still think we should go for an open-coded "cmpxchg" variant
> for UP that disables preempt, and an atomic_cmpxchg variant for SMP.
> 
> - good generic implementations
> - the UP version is faster than atomic_xchg for non preempt on ARM
> - if you really are counting cycles, you'd probably have preempt off
> - if you've got preempt on then the preempt_ operations in semaphores
>   would be the least of your worries (how about spinlocks?)
> 
> Rather than straight out introducing lots of ugliness and complexity
> for something that actually slows down the speed critical !preempt
> case (but is unlikely to be measurable either way).

I provided you with the demonstration last week:

- the non SMP (ARM version < 6) is using xchg.

- xchg on ARM version < 6 is always faster and smaller than any 
  preemption disable.

- xchg on ARM is the same size as the smallest solution you may think of
  when preemption is disabled and never slower (prove me otherwise? if 
  you wish).

- all xchg based primitives are "generic" code already.

And I think you didn't look at the overall patch set before talking 
about "lots of ugliness", did you?  The fact is that the code, 
especially the core code, is much cleaner now than it was when 
everything was seemingly "generic" since the current work on 
architecture abstractions still allows optimizations in a way that is so 
much cleaner and controlled than what happened with the semaphore code, 
and the debugging code can even take advantage of it without polluting 
the core code.

It happens that i386, x86_64 and ARM (if v6 or above) currently have 
their own tweaks to save space and/or cycles in a pretty strictly 
defined way.  The effort is currently spent on making sure if other 
architectures want to use one of their own tricks for those they can do 
it without affecting the core code which remains 95% of the whole thing 
(which is not the case for semaphores), and the currently provided 
architecture specific versions are _never_ bigger nor slower than any 
generic version would be.  Otherwise what would be the point?  


Nicolas
