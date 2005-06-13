Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVFMGW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVFMGW3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 02:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVFMGW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 02:22:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:60664 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261364AbVFMGWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 02:22:14 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <1118640173.29495.22.camel@localhost.localdomain>
References: <Pine.OSF.4.05.10506112214240.2917-100000@da410.phys.au.dk>
	 <1118530780.5593.154.camel@sdietrich-xp.vilm.net>
	 <1118640173.29495.22.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 12 Jun 2005 23:20:48 -0700
Message-Id: <1118643649.5729.34.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 01:22 -0400, Steven Rostedt wrote:
> On Sat, 2005-06-11 at 15:59 -0700, Sven-Thorsten Dietrich wrote:
> > On Sat, 2005-06-11 at 22:23 +0200, Esben Nielsen wrote:
> > > > 
> > > No because it correctly leaves irqs on but not preemption on. 
> > 
> > I see your worries now. See below.
> > 
> I'm still slightly confused :-)

I think there is a LOT of confusion.

> > > No. If you leave preemption off but irqs on, which is what is done here,
> > > you get good, deterministic IRQ latencies but nothing for task-latencies -
> > > actually slightly (unmeassureable I agree) worse due to the extra step
> > > you have to go from the physical interrupt to the task-switch is
> > > completed.
> 
> So is this just to allow for waking up of the IRQ threads?  I can see an
> improvement on SMP since it would allow for the IRQ thread to run on
> another CPU while the current CPU has local_irq_disable.  Or is this
> just to improve the SA_NODELAY?
> 

There are several benefits here:

1. local_irq no longer physically disables processor IRQs. This
eliminates exhaustive testing and driver examination, since any driver
you load, will only disable preemption, and cannot lock the system up
with irqs disabled for an unknown time.

2. To complicate matters further, its not actually required to disable
preemption in ALL cases. ALL you need to do, in many cases is to KEEP
the SPECIFIC IRQ pertaining to the driver that is disabling IRQs, from
being scheduled.

3. consequentially, by exposing more kernel code surface to run with
IRQs ENabled, you allow the SA_NODELAY to respond faster overall. 

4. In addition, but not trivially, the remaining code that is ACTUALLY
allowed to disable IRQs is SMALL. With this model, there are around 100
sections of code left, that DO disable processor interrupts. Those can
be analyzed, and every branch path measured. This allows the interrupt
response time for SA_NODELAY to be known and bounded. I'm not going to
say the h-word. Too much of a fire hazard ;)

5. By breaking up the opaque generic local_irq_disable into:

	A. irq disable to keep IRQs handler from running
	B. irq disable because we can't have interrupts for
	 another reason

All in the spirit of experimentation and research, we provided a tool
for analysis of the IRQ behavior, and IRQ response, by experiment, which
lets us know the subtle workings of the kernel a little better,
empirically. (i.e. by crashing it or not)

There are apparently some drawbacks as well, and I am a little confused
about that myself. I think I am being dense.

Experiments
-----------
It allows us to improve performance of SA_NODELAY interrupts (on X86)
towards a point, where you might try and measure the remaining code, and
make a prediction, and then beat the living daylights out of the kernel
with a million benchmarks and ping flood.

I recommend putting the machine on the uprotected Internet, with no
firewall, and let the hackers have their way with it while running your
tests.

When its a smoldering pile of ashes, go back to the logs, and see if it
ever took longer to process and interrupt than what you predicted with
measurements. If it did not, you might think hard and long about using
the h-word to describe the SA_NODELAY IRQ response.


Daniel proposed this entire concept, not to start a flame war, but to
get some feedback. We are not hell bent on pushing this on anyone.

But it is a tool, like RT in general, that is helping us look at the
kernel top-down, and test, and find problem areas and learn more about
the subtleties and the inner workings.

I realize that there are issues with this technology, and that its not
going to work for everyone. I realize that this may not be optimal for
all architectures.

It was posted for review and discussion.. 

We GOT some review, alright, so it wasn't ignored at least.

> > PI is already in there. I think you are missing some basic concepts here, 
> > for example that IRQs can happen ANYTIME, not just when we happen to enable 
> > interrupts where they have previously been disabled.
> 
> I don't understand this paragraph at all :-?    Where is the PI with the
> local_irq_disable?   So what if the IRQs can happen anytime?  Maybe it's
> just because it's late and I've spent the last three hours catching up
> on this and other threads (I still need to read the "Attempted
> summary ..." thread. Wow that's big!), but this paragraph just totally
> lost me.
> 

I might have mis-understood it in the first place. I was referring to PI
on the Mutex. I think Esben may have meant PI on Interrupts? Now if
Esben really does mean PI on IRQs, that's another interesting concept to
bend your mind around.

> > 
> > I am going to stop responding to this thread until you back up your concerns 
> > with real data, or throw some code out there, that you can back up with real data.
> 
> I hope you at least respond to me ;-) but I might try to implement that
> per CPU BKL for local_irq_... just to see how it looks. But then again
> you have to check all the code that uses it to see if it's not just
> protection some local CPU data. Since there's not too many reasons to
> use local_irq_.. in an SMP environment.  So when they are used, it
> probably would be for a reason that a global mutex wouldn't work for. Oh
> well, I guess I don't need to implement that after all. 
> 

Ok. There's a couple of bunkers around, but they maybe quite full right now.
Down here at the bottom of the Marianas trench, its dark and clammy, 
the sushi is fatty, and the uplink is slow.

Does Ottowa staff up their riot squads in mid-July?

Cheers,

Sven


