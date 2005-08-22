Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbVHVWMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbVHVWMe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVHVWMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:12:32 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:57990 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751307AbVHVWMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:12:15 -0400
Date: Mon, 22 Aug 2005 13:07:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David Brownell <david-b@pacbell.net>
Cc: tglx@linutronix.de, stern@rowland.harvard.edu, some.nzguy@gmail.com,
       paulmck@us.ibm.com, linux-kernel@vger.kernel.org, gregkh@suse.de,
       akpm@osdl.org, a.p.zijlstra@chello.nl
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc6-V0.7.53-11
Message-ID: <20050822110748.GA31125@elte.hu>
References: <Pine.LNX.4.44L0.0508170959410.4862-100000@iolanthe.rowland.org> <20050817205125.06ABCBF3E9@adsl-69-107-32-110.dsl.pltn13.pacbell.net> <20050818045257.GC9768@elte.hu> <20050818063750.036C685F16@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050818063750.036C685F16@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
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

> > > > > We couldn't switch to #2 with patches that simple.  They'd in fact
> > > > > be rather involved ...
> > > >
> > > > I'm in favor of #2 on general principle.
> > > 
> > > Which principle would that be, though?  :)
> >
> > it's the basic Linux kernel principle of never disabling interrupts, 
> > unless really, really necessary.
> 
> And "really, really" depends on context.  I know that you're
> working in some contexts where "really, really" means "virtually
> never", but that's not the only context folk work with.
> 
> Of course, "never ... unless really really necessary" can fight 
> against the principle of "as simple as practical".  Tradeoffs somehow 
> never seem far away in engineering, somehow.

do you imply that in the USB case the code and the locking somehow gets 
simpler? It doesnt. Explicit management of the IRQ flags when combined 
with spinlocks is _never_ good, for multiple reasons. We do it only very 
rarely in the core kernel code, and even then we comment it thickly.  
E.g. we used to have a single case of such code in do_exit() and we got 
rid of it.

> > but the main issue isnt with disabling interrupts in general, the issue 
> > is with "naked" (i.e. lock-less) disabling of interrupts. Let me try to 
> > explain. Stuff like:
> >
> > 	spin_lock_irq(&lock);
> > 	stuff1();
> > 	spin_unlock(&lock);
> > 	stuff2();
> > 	local_irq_enable();
> >
> > is outright dangerous, because it could hide SMP bugs that do not 
> > trigger on UP.
> 
> Sure, but NONE of the code in question started out that way.  And last 
> time I audited USB locking code, there was none like that.  So I don't 
> know where that pseudocode came from; if any code is like that today, 
> it could be hiding non-SMP bugs too.  The only cases where 
> "local_irq_enable" is used, it's paired with "local_irq_disable".
> 
> And the only places either is used relate to some tricky lock 
> hierarchy games that need to be played when canceling URBs ... where 
> usbcore has to account for the fact that the URB being canceled may 
> _at that instant_ be in the middle of being given back to the device 
> driver (from the HCD, via usbcore) by an IRQ handler on another CPU.  
> There's no "naked disabling" at all; it's used exclusively when two 
> different irq-safe locks need to be coordinated.

the simple solution is to always save/restore irq flags when taking the 
irq-safe lock.

> > so in the process of identifying naked IRQ-flags use i asked why the USB 
> > code was doing it, and i'm happy that the answer is "no good reason, 
> > mostly historic". (naked IRQ flags use also happens to be a problem for 
> > PREEMPT_RT, where i also have a debug warning about such IRQ flags 
> > assymetries, but you need not worry about that one.)
> 
> But as I pointed out, that answer was incomplete.  Or maybe it only 
> addressed some of the code paths, not all of them.  Not all the issues 
> are "mostly historic".

so could you give me some other than "mostly historic" explanation? It 
seems there's some spin_lock() use within the USB code - if most of the 
USB locks are irq-safe, then all those spin_lock()s should be converted 
to use spin_lock_irqsave/restore. Depending on an external 
local_irq_disable() to have interrupts disabled is extremely fragile. It 
might easily be code that works fine right now, but it's an extremely 
unrobust concept.

> > to make such cleanups of irq-flags use easier i'm also thinking about 
> > automating the process of checking for the irq-safety of spinlocks, by 
> > adding a new spinlock type via:
> >
> > 	DEFINE_SPINLOCK_IRQSAFE(lock2);
> >
> > (and a spin_lock_init_irqsafe() function too)
> 
> I think all the locks inside usbcore and the HCDs will end up being 
> "irqsafe"...

great - then the solution is to use irq save/restore for all of them, 
and dont manage irq flags explicitly. I'll cook up a patch.

	Ingo
