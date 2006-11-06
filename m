Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753827AbWKFVlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827AbWKFVlf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 16:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbWKFVlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 16:41:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:4785 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1753827AbWKFVle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 16:41:34 -0500
Subject: Re: PATCH? hrtimer_wakeup: fix a theoretical race wrt
	rt_mutex_slowlock()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0611061609340.22166@gandalf.stny.rr.com>
References: <20061105193457.GA3082@oleg>
	 <Pine.LNX.4.64.0611051423150.25218@g5.osdl.org>
	 <1162803471.28571.303.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0611060732020.14553@gandalf.stny.rr.com>
	 <1162846433.28571.341.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0611061609340.22166@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 08:41:05 +1100
Message-Id: <1162849266.28571.352.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 16:17 -0500, Steven Rostedt wrote:
> On Tue, 7 Nov 2006, Benjamin Herrenschmidt wrote:
> 
> > On Mon, 2006-11-06 at 07:35 -0500, Steven Rostedt wrote:
> >
> > > It is relevant.  In powerpc, can one write happen before another write?
> > >
> > >
> > >   x = 1;
> > >   barrier();  (only compiler barrier)
> > >   b = 2;
> > >
> > >
> > > And have CPU 2 see b=2 before seeing x=1?
> >
> > Yes. Definitely.
> 
> OK, I see in powerpc, that spin lock calls isync. This just clears the
> pipeline. It doesn't touch the loads and stores, right?

Yes. That isync is to prevent loads to be speculated accross spin_lock,
thus leaking out of the lock by the top. In fact, it doesn't act on the
load per-se but it prevent speculative execution accross the conditional
branch in the spin_lock. 

> So basically saying this:
> 
>    x=1;
>    asm ("isync");
>    b=2;
> 
> Would that have the same problem too?  Where another CPU can see x=1
> before seeing b=2?

Yes.

What isync provides is

a = *foo
spin_lock_loop_with_conditional_branch
isync
b = *bar

It prevents the read of b from being speculated by the CPU ahead of a

Ben.



