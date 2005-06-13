Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVFMM2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVFMM2s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 08:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVFMM2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 08:28:48 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:39923 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261537AbVFMM2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 08:28:31 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Steven Rostedt <rostedt@goodmis.org>
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <1118643649.5729.34.camel@sdietrich-xp.vilm.net>
References: <Pine.OSF.4.05.10506112214240.2917-100000@da410.phys.au.dk>
	 <1118530780.5593.154.camel@sdietrich-xp.vilm.net>
	 <1118640173.29495.22.camel@localhost.localdomain>
	 <1118643649.5729.34.camel@sdietrich-xp.vilm.net>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 13 Jun 2005 08:28:05 -0400
Message-Id: <1118665685.29495.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-12 at 23:20 -0700, Sven-Thorsten Dietrich wrote:

> I think there is a LOT of confusion.

Thanks, I'm not so confused anymore thanks to you :-)

> There are several benefits here:
> 
> 1. local_irq no longer physically disables processor IRQs. This
> eliminates exhaustive testing and driver examination, since any driver
> you load, will only disable preemption, and cannot lock the system up
> with irqs disabled for an unknown time.

With all IRQs (except timer) as a thread, on a UP this will lock up the
system for a long time.  I'm not saying this is good or bad, I'm just
saying that this only helps the timer interrupt.  If the purpose is to
help your own SA_NODELAY then this is all good.

One thing I'm worried about is if some bad code goes into an infinite
loop you won't know why the system just locked up for a long time since
the NMI won't go off.  Hey, this is an idea, have the NMI also check for
preempt off.  Since local_irq_disable and preempt_disable both are
macros or functions, we can easily add a NMI counter to them.  I'll
write up a patch to do this. (If I can keep up with Ingo, last night it
was as -17 this morning it's at -24!)

> 
> 2. To complicate matters further, its not actually required to disable
> preemption in ALL cases. ALL you need to do, in many cases is to KEEP
> the SPECIFIC IRQ pertaining to the driver that is disabling IRQs, from
> being scheduled.

I consider this a bug when a driver disables irqs when it should only
disable it's own.  Actually, with a SMP system, the only safe thing to
do is turn off interrupts at the device (or spin_locks), and this would
be the proper fix for both RT and vanilla kernels.  If the device's
interrupt handler has a per CPU data that it modifies, then this would
need to be addressed even in the current implementation of RT, but I
don't know of any driver that really does this.

> 
> 3. consequentially, by exposing more kernel code surface to run with
> IRQs ENabled, you allow the SA_NODELAY to respond faster overall. 

No qualms here.

> 
> 4. In addition, but not trivially, the remaining code that is ACTUALLY
> allowed to disable IRQs is SMALL. With this model, there are around 100
> sections of code left, that DO disable processor interrupts. Those can
> be analyzed, and every branch path measured. This allows the interrupt
> response time for SA_NODELAY to be known and bounded. I'm not going to
> say the h-word. Too much of a fire hazard ;)
> 
> 5. By breaking up the opaque generic local_irq_disable into:
> 
> 	A. irq disable to keep IRQs handler from running
> 	B. irq disable because we can't have interrupts for
> 	 another reason

OK, so I'm not as confused as I thought. This all makes sense.

> 
> All in the spirit of experimentation and research, we provided a tool
> for analysis of the IRQ behavior, and IRQ response, by experiment, which
> lets us know the subtle workings of the kernel a little better,
> empirically. (i.e. by crashing it or not)
> 
> There are apparently some drawbacks as well, and I am a little confused
> about that myself. I think I am being dense.

What drawbacks?

> 
> Experiments
> -----------
> It allows us to improve performance of SA_NODELAY interrupts (on X86)
> towards a point, where you might try and measure the remaining code, and
> make a prediction, and then beat the living daylights out of the kernel
> with a million benchmarks and ping flood.
> 
> I recommend putting the machine on the uprotected Internet, with no
> firewall, and let the hackers have their way with it while running your
> tests.

No thank you, I don't need the FBI breaking down my door because my
computer is being used to hack into the pentagon ;-)

> 
> When its a smoldering pile of ashes, go back to the logs, and see if it
> ever took longer to process and interrupt than what you predicted with
> measurements. If it did not, you might think hard and long about using
> the h-word to describe the SA_NODELAY IRQ response.
> 
> 
> Daniel proposed this entire concept, not to start a flame war, but to
> get some feedback. We are not hell bent on pushing this on anyone.

I'm open to new ideas, and I wasn't flaming, and this thread really
didn't get that hot (unlike the flaming hell of the RT acceptance
thread).  I think Esben may have gotten a little excited, but nothing
that was enough to boil an egg with.

> 
> But it is a tool, like RT in general, that is helping us look at the
> kernel top-down, and test, and find problem areas and learn more about
> the subtleties and the inner workings.

Hey, lets try it out, if it works then keep it, if it's too much of a
burden then dump it!

> 
> I realize that there are issues with this technology, and that its not
> going to work for everyone. I realize that this may not be optimal for
> all architectures.
> 
> It was posted for review and discussion.. 
> 
> We GOT some review, alright, so it wasn't ignored at least.

And lots of discussion :-)

> 
> > > PI is already in there. I think you are missing some basic concepts here, 
> > > for example that IRQs can happen ANYTIME, not just when we happen to enable 
> > > interrupts where they have previously been disabled.
> > 
> > I don't understand this paragraph at all :-?    Where is the PI with the
> > local_irq_disable?   So what if the IRQs can happen anytime?  Maybe it's
> > just because it's late and I've spent the last three hours catching up
> > on this and other threads (I still need to read the "Attempted
> > summary ..." thread. Wow that's big!), but this paragraph just totally
> > lost me.
> > 
> 
> I might have mis-understood it in the first place. I was referring to PI
> on the Mutex. I think Esben may have meant PI on Interrupts? Now if
> Esben really does mean PI on IRQs, that's another interesting concept to
> bend your mind around.

This is where PI on wait queues comes in.

> 
> > > 
> > > I am going to stop responding to this thread until you back up your concerns 
> > > with real data, or throw some code out there, that you can back up with real data.
> > 
> > I hope you at least respond to me ;-) but I might try to implement that
> > per CPU BKL for local_irq_... just to see how it looks. But then again
> > you have to check all the code that uses it to see if it's not just
> > protection some local CPU data. Since there's not too many reasons to
> > use local_irq_.. in an SMP environment.  So when they are used, it
> > probably would be for a reason that a global mutex wouldn't work for. Oh
> > well, I guess I don't need to implement that after all. 
> > 
> 
> Ok. There's a couple of bunkers around, but they maybe quite full right now.
> Down here at the bottom of the Marianas trench, its dark and clammy, 
> the sushi is fatty, and the uplink is slow.
> 
> Does Ottowa staff up their riot squads in mid-July?

;}


-- Steve


