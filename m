Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSGUXs4>; Sun, 21 Jul 2002 19:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315417AbSGUXs4>; Sun, 21 Jul 2002 19:48:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39624 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S315416AbSGUXsz>;
	Sun, 21 Jul 2002 19:48:55 -0400
Date: Mon, 22 Jul 2002 01:50:57 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: george anzinger <george@mvista.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [announce, patch, RFC] "big IRQ lock" removal, IRQ cleanups.
In-Reply-To: <3D3B4734.244BBE2A@mvista.com>
Message-ID: <Pine.LNX.4.44.0207220146210.4147-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 21 Jul 2002, george anzinger wrote:

> > > - to remove the preemption count increase/decrease code from the lowlevel
> > >   IRQ assembly code.
> 
> IMHO this is unwise as the system NEEDS to exit to user (or
> system) space when preempt_count is zero with a garuntee
> that TIF_NEED_RESCHED is 0. [...]

my comment was too compact - the bumping of the preemption count did not
get removed, it's just the dualness that got removed. Both the lowlevel
entry code and the irq_enter() code used to do the same thing - now only
irq_enter() does it.

in the latest patch irq_enter() is done early in do_IRQ(), and irq_exit()  
is done before returning from do_IRQ().

> [...] To do this from irq.c means that it must exit with interrupts off
> and the the low level code needs to keep them off till the irtn. [...]

yes, we are very careful to keep irqs disabled in do_IRQ(), both before
and after calling the handler.

> [...] But this is where we test TIF_NEED_RESCHED, and if it is set,
> schedule() is called and should be called with preempt_count != 0, to
> avoid stack overflow interrupt loops.  And, schedule() returns with the
> interrupt system on (even if we, unwisely, call it with it off).

yes, in this case schedule() is called with a nonzero preempt count
(PREEMPT_ACTIVE), to keep it from recursing into itself.

> > It seems to me that call to irq_enter() must be shifted from
> > handle_IRQ_event() to do_IRQ().
> 
> Even then...

could you check out the latest patch, can you still see any hole in it?  
All the above scenarios should be handled correctly.

	Ingo

