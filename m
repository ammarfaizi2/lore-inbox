Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261362AbTCGFmo>; Fri, 7 Mar 2003 00:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261361AbTCGFmo>; Fri, 7 Mar 2003 00:42:44 -0500
Received: from packet.digeo.com ([12.110.80.53]:42627 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261362AbTCGFml>;
	Fri, 7 Mar 2003 00:42:41 -0500
Date: Thu, 6 Mar 2003 21:53:12 -0800
From: Andrew Morton <akpm@digeo.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: felipe_alfaro@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.64-mm1: Badness in request_irq
Message-Id: <20030306215312.0c7ed05d.akpm@digeo.com>
In-Reply-To: <1047015055.1538.7.camel@ixodes.goop.org>
References: <20030306141859.19645.qmail@linuxmail.org>
	<1047015055.1538.7.camel@ixodes.goop.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2003 05:53:08.0867 (UTC) FILETIME=[D4918530:01C2E46D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
> On Thu, 2003-03-06 at 06:18, Felipe Alfaro Solana wrote:
> > Hello,  
> >   
> > I have just installed and compiled 2.5.64-mm1 using gcc-3.2.2 and,
> > when booting the system, I have found the  
> > following error on the kernel ring:  
> >   
> > Badness in request_irq at arch/i386/kernel/irq.c:475  
> > Call Trace: [<c010afdd>]  [<d08b3d3a>]  [<d08b18c0>]  [<d08b42c8>]  [<d08b024e>]  [<d08b42b0>]   
> > [<d08b49c0>]  [<d08b49e8>]  [<c0191d6e>]  [<d08b496c>]  [<d08b49e8>]  [<c01947f5>]  [<d08b49e8>]   
> > [<c019491c>]  [<d08b49e8>]  [<d08b4a04>]  [<c0194c10>]  [<d08b49e8>]  [<d08bb160>]  [<c0194fff>]   
> > [<d08b49e8>]  [<c0191eab>]  [<d08b49e8>]  [<d08a0019>]  [<d08b49c0>]  [<d08bb160>]  [<c01302cd>]   
> > [<c010969e>]  
> 
> I'm getting this as well on both my desktop and laptop machines.
> 

Yeah, sorry.  Any request_irq(SA_INTERRUPT|SA_SHIRQ) call will do this.

The problem is that when an SA_INTERRUPT handler shares with a
non-SA_INTERRUPT one, the result is basically meaningless.  The SA_INTERRUPT
handler may (or may not) get executed with interrupts off.

So the intent was to drop a warning saying "hey, someone is being silly
here".

And it _is_ silly, because what the caller is saying is "I want my handler to
run with interrupts disabled, but I am also prepared to share the IRQ with
damn near any other interrupt handler in the kernel".

That warning has to go.  My current thinking is as follows:

- Each time a handler is registered or removed from the chain, we walk the
  IRQ chain and propogate some accumulated info into the controlling
  irq_desc_t.

- If all handlers in the chain are SA_INTERRUPT then the entire chain is
  run with irqs disabled.

- If _any_ handler is !SA_INTERRUPT then all handlers are run with IRQs
  enabled.

This gives sane and documentable semantics.  It also means that any
SA_INTERRUPT handler which is also SA_SHIRQ _must_ be prepared to be called
with irq's enabled.   That is already the case: it is merely being formalised.

If a handler MUST be run with interrupts disabled (for atomicity reasons,
say) then it cannot share.  That's the caller's responsibility.

(One might argue that if any handlers in the chain are SA_INTERRUPT then all
handlers should run with irq's off.  Problem is, the !SA_INTERRUPT handlers
could easily be doing foo_lock_irq()/foo_unlock_irq(), because they think
they were called with irq's enabled).

It's all a bit murky.
