Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbTDLNus (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 09:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbTDLNus (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 09:50:48 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:18083 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S262426AbTDLNuq (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 09:50:46 -0400
Date: Sat, 12 Apr 2003 10:55:46 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: george anzinger <george@mvista.com>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 kernel/timer.c may incorrectly reenable interrupts
Message-ID: <20030412105546.H659@nightmaster.csn.tu-chemnitz.de>
References: <24294.1050043625@kao2.melbourne.sgi.com> <3E966BAA.804@mvista.com> <20030411112728.M626@nightmaster.csn.tu-chemnitz.de> <3E9731E2.9090606@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3E9731E2.9090606@mvista.com>; from george@mvista.com on Fri, Apr 11, 2003 at 02:21:38PM -0700
X-Spam-Score: -32.2 (--------------------------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *194LaQ-0005rn-00*Vvwz8VyloYA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 02:21:38PM -0700, george anzinger wrote:
> Ingo Oeser wrote:
> > Maybe we could replace some cli/sti pairs with spinlocks? If it
> > takes more time to cli/sti than to run the whole code section
> > that will be protected by the spinlock, then it might be better
> > to use that instead and block in the IRQ dispatch code.
> 
> Not so fast there :)  The cli/sti is there to protect from "same cpu" 
> contention, i.e. this machine can come here on interrupt so don't 
> allow interrupts.  The spin lock is only good for the "other" cpus.
>
> On the other hand, a cli/sti will NOT protect from other machine 
> interrupts (baring the global cli which is not even in 2.5).

Because it isn't implemented this way? ;-)

If you have a per-CPU lock, which block in the arch-specific
IRQ-dispatch section, you can simulate cli/sti quite well.

I have more problems with the semantical difference of cli/sti
vs. spinlocks on nesting. A cli/sti will never block anything but
interrupts, a spinlock will block the caller on contention.

This should be measured. Unfortunately I don't have fast enough
hardware to notice a difference.

> The better thing to do, IMHO, is to move the work off the interrupt 
> path where only spin locks (and preemption locks) are required.
 
This is done incrementally already, so its only a matter of time.

> Another possibility is to make more use of the new read/write stuff 
> that is now being used for the xtime lock.  The idea here is that we 
> don't care if an interrupt (or the other machine) visits this data 
> while we are here as long as we know about it and can then redo what 
> we are doing.  This works very well for fetching a few words that need 
> to be fetch atomically WRT the lock.  If the fetch is not atomic (i.e. 
> was interrupted), just try again.

Not suitable for drivers. They must read the registers, set some
other registers and ACK the IRQ in the ISR. There is no way
around that. 

If the maximum latency between ISR and process context work is
small and definable by the drivers, people would offload more.

So if there would be a schedule_work_deadline() then this would
be nice. The routine called later in process context called will
be noticed, if the deadline is missed or not and can act
correctly.

This will simplify IDE (which needs those small timeouts and
could act like the stuff timed out, if the deadline is missed),
this will simplify the deadline-scheduler for IO and allow an
additional scheduling method for user space.

The scheduler changes would be one additional queue and it could
also be depth limited, since later deadlines can be added later.

We currently have timers, but they are not suitable for doing the
work only for triggering it and that's a source of complexity in
driver design.

> I haven't measured or heard of 
> measurements on this change, but I suspect that there is a significant 
> reduction in the time to do gettimeofday() because the cli/sti is not 
> on the read path any more.

I agree that these historical kind of code should be changed,
but modern drivers, which need to protect from IRQs of this
device happening while changing some registers could not do this.

They really need the spin_lock_irqsave() (which does the cli
implicitly).

Regards

Ingo Oeser
