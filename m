Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVHRGiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVHRGiT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 02:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVHRGiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 02:38:19 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:32399 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1750831AbVHRGiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 02:38:18 -0400
X-ORBL: [69.107.32.110]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=U7OkS96narakY6HBNYRa6+VW0bGPrL9zvrrkzWk+drcYmpxFj7SuavNqhD4PS3voY
	eeH7vdfZg8DXcb4rIXtZw==
Date: Wed, 17 Aug 2005 23:37:50 -0700
From: David Brownell <david-b@pacbell.net>
To: mingo@elte.hu
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc6-V0.7.53-11
Cc: tglx@linutronix.de, stern@rowland.harvard.edu, some.nzguy@gmail.com,
       paulmck@us.ibm.com, linux-kernel@vger.kernel.org, gregkh@suse.de,
       akpm@osdl.org, a.p.zijlstra@chello.nl
References: <Pine.LNX.4.44L0.0508170959410.4862-100000@iolanthe.rowland.org>
 <20050817205125.06ABCBF3E9@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
 <20050818045257.GC9768@elte.hu>
In-Reply-To: <20050818045257.GC9768@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050818063750.036C685F16@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > We couldn't switch to #2 with patches that simple.  They'd in fact
> > > > be rather involved ...
> > >
> > > I'm in favor of #2 on general principle.
> > 
> > Which principle would that be, though?  :)
>
> it's the basic Linux kernel principle of never disabling interrupts, 
> unless really, really necessary.

And "really, really" depends on context.  I know that you're
working in some contexts where "really, really" means "virtually
never", but that's not the only context folk work with.

Of course, "never ... unless really really necessary" can fight
against the principle of "as simple as practical".  Tradeoffs
somehow never seem far away in engineering, somehow.


> but the main issue isnt with disabling interrupts in general, the issue 
> is with "naked" (i.e. lock-less) disabling of interrupts. Let me try to 
> explain. Stuff like:
>
> 	spin_lock_irq(&lock);
> 	stuff1();
> 	spin_unlock(&lock);
> 	stuff2();
> 	local_irq_enable();
>
> is outright dangerous, because it could hide SMP bugs that do not 
> trigger on UP.

Sure, but NONE of the code in question started out that way.  And last
time I audited USB locking code, there was none like that.  So I don't
know where that pseudocode came from; if any code is like that today, it
could be hiding non-SMP bugs too.  The only cases where "local_irq_enable"
is used, it's paired with "local_irq_disable".

And the only places either is used relate to some tricky lock hierarchy
games that need to be played when canceling URBs ...  where usbcore has to
account for the fact that the URB being canceled may _at that instant_
be in the middle of being given back to the device driver (from the
HCD, via usbcore) by an IRQ handler on another CPU.  There's no "naked
disabling" at all; it's used exclusively when two different irq-safe
locks need to be coordinated.


> so in the process of identifying naked IRQ-flags use i asked why the USB 
> code was doing it, and i'm happy that the answer is "no good reason, 
> mostly historic". (naked IRQ flags use also happens to be a problem for 
> PREEMPT_RT, where i also have a debug warning about such IRQ flags 
> assymetries, but you need not worry about that one.)

But as I pointed out, that answer was incomplete.  Or maybe it
only addressed some of the code paths, not all of them.  Not
all the issues are "mostly historic".


> to make such cleanups of irq-flags use easier i'm also thinking about 
> automating the process of checking for the irq-safety of spinlocks, by 
> adding a new spinlock type via:
>
> 	DEFINE_SPINLOCK_IRQSAFE(lock2);
>
> (and a spin_lock_init_irqsafe() function too)

I think all the locks inside usbcore and the HCDs will end up
being "irqsafe"... 


> this will be useful for the whole kernel, not properly managing the irq 
> flags is a common locking mistake. With this new debug feature enabled, 
> the kernel will warn if an irq-safe lock is taken with interrupts still 
> enabled.
>
> furthermore, the debug feature will also warn if a spinlock _not_ marked 
> irqsafe is used from an interrupt context. This is another common type 
> of locking mistake.

That seems like a good idea.  New Linux developers have often gotten
confused about the rules associated with a given spinlock; and even
when something starts out with good comments, it likely doesn't stay
that way.  Automatic warning about simple mistakes will be a big win.

- Dave

