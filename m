Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbVLMFIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbVLMFIE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 00:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVLMFIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 00:08:04 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:28771 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932402AbVLMFID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 00:08:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=kdBJGzqa0TpcMYzekuT55Qs665xi1ASJ2wF8jaZXPIJ4/aX+U6e7cVhbpzMWUVHCCzy4Jm6482eTLYTYobwYWKG5TuFrhRilVNkK/vwRwJONMsCQ4pGFNqZOXyd060AhN18kj+5A4ShAUw2cJ4vXViCSi5kRWuXP0+U+QcA5GZQ=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Semantics of smp_mb() [was : Re: [PATCH] Fix RCU race in access of nohz_cpu_mask ]
Date: Tue, 13 Dec 2005 00:07:47 -0500
User-Agent: KMail/1.8.3
Cc: vatsa@in.ibm.com, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
References: <439889FA.BB08E5E1@tv-sign.ru> <200512111621.20365.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <1134344716.5937.11.camel@localhost.localdomain>
In-Reply-To: <1134344716.5937.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512130007.48712.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 December 2005 18:45, Rusty Russell wrote:
> On Sun, 2005-12-11 at 16:21 -0500, Andrew James Wade wrote:
> > On Sunday 11 December 2005 12:41, Srivatsa Vaddagiri wrote:
> > > [Changed the subject line to be more generic in the interest of wider audience]
> > > 
> > > We seem to be having some confusion over the exact semantics of smp_mb().
> > > 
> > > Specifically, are all stores preceding smp_mb() guaranteed to have finished
> > > (committed to memory/corresponding cache-lines on other CPUs invalidated) 
> > > *before* successive loads are issued?
> > 
> > I doubt it. That's definitely not true of smp_wmb(), which boils down to
> > __asm__ __volatile__ ("": : :"memory") on SMP i386 (which the constrains
> > how the compiler orders write instructions, but is otherwise a nop. i386
> > has in-order writes.).

Hrrm, after doing a bit of reading on cache-coherency, verifying that the
corresponding cache-lines on other CPUs are invalidated can (sometimes)
be done quite quickly, so waiting for that before issuing reads might not
destroy performance. I still doubt that i386es do thing this way, but I
don't think it matters (see below).

> > 
> > And it makes sense that wmb() wouldn't wait for writes: RCU needs
> > constraints on the order in which writes become visible, but has very week
> > constraints on when they do. Waiting for writes to flush would hurt
> > performance.
> 
> On the contrary.  I did some digging and asking and thinking about this
> for the Unreliable Guide to Kernel Locking, years ago:
> 
> wmb() means all writes preceeding will complete before any writes
> following are started.

What does it mean for a write to start? For that matter, what does it mean
for a write to complete?

I think my focusing on the hardware details (of which I am woefully
ignorant) was a mistake: the hardware can really do whatever it wants so
long as it implements the expected abstract machine model, and it is
ordering that matters in that model. So it makes sense that ordering, not
time, is what the definitions of the memory barriers focus on.

I think that Oleg's question:
> Does this mb() garantees that the new value of ->cur will be visible
> on other cpus immediately after smp_mb() (so that rcu_pending() will
> notice it) ?
is really just about the timeliness with which writes before a smp_mb()
become visible to other CPUs. Does Linux run on architectures in which
writes are not propagated in a timely manner (that is: other CPUs can read
stale values for a "considerable" time)? I rather doubt it.

But with a proviso to my answer: the compiler will happily hoist reads out
of loops. So writes won't necessarily get read in a timely manner.

Andrew

