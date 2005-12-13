Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbVLMQUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVLMQUU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 11:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVLMQUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 11:20:20 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:62164 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932312AbVLMQUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 11:20:19 -0500
Date: Tue, 13 Dec 2005 08:20:27 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       vatsa@in.ibm.com, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Semantics of smp_mb() [was : Re: [PATCH] Fix RCU race in access of nohz_cpu_mask ]
Message-ID: <20051213162027.GA14158@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <439889FA.BB08E5E1@tv-sign.ru> <200512111621.20365.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <1134344716.5937.11.camel@localhost.localdomain> <200512130007.48712.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <p73vext8cr6.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73vext8cr6.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 04:20:13AM -0700, Andi Kleen wrote:
> Andrew James Wade <andrew.j.wade@gmail.com> writes:
> > 
> > What does it mean for a write to start? For that matter, what does it mean
> > for a write to complete?
> 
> wmb() or smp_smb() really makes no guarantees when a write
> completes (e.g. when another CPU or a device sees the new value)
> It just guarantees ordering. This means when you do e.g.
> 
>         *p = 1;
>         wmb();
>         *p = 2;
>         wmb();
> 
> then another CPU will never see 2 before 1 (but possibly it might
> miss the "1 state completely"). When it actually sees the values
> (or if it keeps using whatever value was in *p before the first
> assignment) is undefined.

It is OK on the write side, but the corresponding barriers are required
on the read side (even on non-Alpha CPUs, since the value of the pointer
remains constant).

	Writer			Reader

	p = 1;			p1 = p;
	smp_wmb();		smp_rmb();
	p = 2;			p2 = p;

With these memory barriers in place, if p2 is set to 1, then p1 must
also be set to 1.  Similarly, if p1 is set to 2, then p2 must also
be set to 2.  If the smp_rmb() is not present on the read side, then
the reading CPU (and compiler) are free to interchange the order
of the two assignment statements.  As Andi says, memory barriers do
not necessarily make reads or writes happen faster, instead they only
enforce limited ordering constraints.

If the variable p references MMIO rather than normal memory, then
wmb() and rmb() are needed instead of smp_wmb() and smp_rmb().
This is because the I/O device needs to see the accesses ordered
even in a UP system.

						Thanx, Paul

> The definition quoted above is wrong I think. Rusty can you
> perhaps fix it up?
>
> > I think my focusing on the hardware details (of which I am woefully
> > ignorant) was a mistake: the hardware can really do whatever it wants so
> > long as it implements the expected abstract machine model, and it is
> > ordering that matters in that model. So it makes sense that ordering, not
> > time, is what the definitions of the memory barriers focus on.
> 
> Exactly.
> 
> > > Does this mb() garantees that the new value of ->cur will be visible
> > > on other cpus immediately after smp_sees 1 or 2 is undefined.  mb() (so that rcu_pending() will
> > > notice it) ?
> > is really just about the timeliness with which writes before a smp_mb()
> > become visible to other CPUs. Does Linux run on architectures in which
> > writes are not propagated in a timely manner (that is: other CPUs can read
> > stale values for a "considerable" time)? I rather doubt it.
> > 
> > But with a proviso to my answer: the compiler will happily hoist reads out
> > of loops. So writes won't necessarily get read in a timely manner.
> 
> Or just consider interrupts. Any CPU can stop for an very long time
> at any time as seen by the other CPUs.  Or it might take an machine check
> and come back. You can never make any assumptions about when another
> CPU sees a write unless you add explicit synchronization like a spinlock.
> 
> -Andi
> 
