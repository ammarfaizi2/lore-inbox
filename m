Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVLMGsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVLMGsk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 01:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVLMGsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 01:48:40 -0500
Received: from ns.suse.de ([195.135.220.2]:8676 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932388AbVLMGsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 01:48:39 -0500
To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
Cc: vatsa@in.ibm.com, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Semantics of smp_mb() [was : Re: [PATCH] Fix RCU race in access of nohz_cpu_mask ]
References: <439889FA.BB08E5E1@tv-sign.ru>
	<200512111621.20365.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	<1134344716.5937.11.camel@localhost.localdomain>
	<200512130007.48712.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andi Kleen <ak@suse.de>
Date: 13 Dec 2005 04:20:13 -0700
In-Reply-To: <200512130007.48712.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
Message-ID: <p73vext8cr6.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew James Wade <andrew.j.wade@gmail.com> writes:
> 
> What does it mean for a write to start? For that matter, what does it mean
> for a write to complete?

wmb() or smp_smb() really makes no guarantees when a write
completes (e.g. when another CPU or a device sees the new value)
It just guarantees ordering. This means when you do e.g.

        *p = 1;
        wmb();
        *p = 2;
        wmb();

then another CPU will never see 2 before 1 (but possibly it might
miss the "1 state completely"). When it actually sees the values
(or if it keeps using whatever value was in *p before the first
assignment) is undefined.

The definition quoted above is wrong I think. Rusty can you
perhaps fix it up?

> I think my focusing on the hardware details (of which I am woefully
> ignorant) was a mistake: the hardware can really do whatever it wants so
> long as it implements the expected abstract machine model, and it is
> ordering that matters in that model. So it makes sense that ordering, not
> time, is what the definitions of the memory barriers focus on.

Exactly.

> > Does this mb() garantees that the new value of ->cur will be visible
> > on other cpus immediately after smp_sees 1 or 2 is undefined.  mb() (so that rcu_pending() will
> > notice it) ?
> is really just about the timeliness with which writes before a smp_mb()
> become visible to other CPUs. Does Linux run on architectures in which
> writes are not propagated in a timely manner (that is: other CPUs can read
> stale values for a "considerable" time)? I rather doubt it.
> 
> But with a proviso to my answer: the compiler will happily hoist reads out
> of loops. So writes won't necessarily get read in a timely manner.

Or just consider interrupts. Any CPU can stop for an very long time
at any time as seen by the other CPUs.  Or it might take an machine check
and come back. You can never make any assumptions about when another
CPU sees a write unless you add explicit synchronization like a spinlock.

-Andi
