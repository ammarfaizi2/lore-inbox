Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbVHREwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbVHREwv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 00:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVHREwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 00:52:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:62685 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S1751016AbVHREwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 00:52:51 -0400
Date: Thu, 18 Aug 2005 06:52:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David Brownell <david-b@pacbell.net>
Cc: stern@rowland.harvard.edu, tglx@linutronix.de, some.nzguy@gmail.com,
       paulmck@us.ibm.com, linux-kernel@vger.kernel.org, gregkh@suse.de,
       a.p.zijlstra@chello.nl, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc6-V0.7.53-11
Message-ID: <20050818045257.GC9768@elte.hu>
References: <Pine.LNX.4.44L0.0508170959410.4862-100000@iolanthe.rowland.org> <20050817205125.06ABCBF3E9@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050817205125.06ABCBF3E9@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Brownell <david-b@pacbell.net> wrote:

> > >   1 ALWAYS complete() with IRQs disabled
> > > 
> > >   2 NEVER complete() with them disabled
> > > 
> > >   3 SOMETIMEs complete() with them disabled.
> > > 
> > > Right now we're with #1 which is simple, consistent and guaranteed.
> > > 
> > > We couldn't switch to #2 with patches that simple.  They'd in fact
> > > be rather involved ...
> >
> > I'm in favor of #2 on general principle.
> 
> Which principle would that be, though?  :)

it's the basic Linux kernel principle of never disabling interrupts, 
unless really, really necessary.

but the main issue isnt with disabling interrupts in general, the issue 
is with "naked" (i.e. lock-less) disabling of interrupts. Let me try to 
explain. Stuff like:

	spin_lock_irq(&lock);
	stuff1();
	spin_unlock(&lock);
	stuff2();
	local_irq_enable();

is outright dangerous, because it could hide SMP bugs that do not 
trigger on UP. SMP systems are becoming the norm these days, so we 
cannot hide behind "most people use UP" arguments anymore. IRQ flags 
management needs to be tightened up. (The good news is that it can be 
done gradually and i'm doing it, so it's no extra work for you.)

so in the process of identifying naked IRQ-flags use i asked why the USB 
code was doing it, and i'm happy that the answer is "no good reason, 
mostly historic". (naked IRQ flags use also happens to be a problem for 
PREEMPT_RT, where i also have a debug warning about such IRQ flags 
assymetries, but you need not worry about that one.)

the only logistical problem with "unifying" the IRQ flags operations 
with their respective spin_lock functions is their transitive nature, 
e.g. in the above example, if stuff2() does:

	stuff2()
	{
		spin_lock(&lock2);
		stuff3();
		spin_unlock(&lock2);
	}

then the irqs-off condition needs to be propagated into the function:

	stuff2()
	{
		spin_lock_irq(&lock2);
		stuff3();
		spin_unlock_irq(&lock2);
	}

IFF 'lock2' can be used from an interrupt or softirq context. Obviously 
the latter code form is much more preferred, because it self-documents 
that lock2 is irq-safe. Nested, implicit irqs-off assumptions are 
another common source of locking bugs.

but fortunately this is a relatively straightforward process, and it 
seems Alan has identified most of the affected functions. I'd be happy 
if you could point out more candidates. In the worst-case, if any 
function is missed by accident then it's easy to debug it. I'm now 
testing the patches posted in this thread in the -RT tree, they are 
looking good so far.

to make such cleanups of irq-flags use easier i'm also thinking about 
automating the process of checking for the irq-safety of spinlocks, by 
adding a new spinlock type via:

	DEFINE_SPINLOCK_IRQSAFE(lock2);

(and a spin_lock_init_irqsafe() function too)

this will be useful for the whole kernel, not properly managing the irq 
flags is a common locking mistake. With this new debug feature enabled, 
the kernel will warn if an irq-safe lock is taken with interrupts still 
enabled.

furthermore, the debug feature will also warn if a spinlock _not_ marked 
irqsafe is used from an interrupt context. This is another common type 
of locking mistake.

the spinlock-consolidation patch currently cooking in -mm (to be merged 
to 2.6.14) makes it easy to add such new spinlock debugging features 
without having to change assembly code in 22 architectures.

[ we could even take this one step further and completely automate 
  irq-safe locks - i.e. not manage irq-flags at all and only have 
  spin_lock() and spin_unlock(). That would cause some minimal runtime 
  overhead for irqsafe locks though. But i digress. ]

	Ingo
