Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135380AbRBEQyQ>; Mon, 5 Feb 2001 11:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135378AbRBEQyH>; Mon, 5 Feb 2001 11:54:07 -0500
Received: from mail.inup.com ([194.250.46.226]:63753 "EHLO www.inup.com")
	by vger.kernel.org with ESMTP id <S131020AbRBEQx5>;
	Mon, 5 Feb 2001 11:53:57 -0500
Date: Mon, 5 Feb 2001 17:53:48 +0100
From: christophe barbe <christophe.barbe@inup.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: christophe barbe <christophe.barbe@inup.com>, linux-kernel@vger.kernel.org
Subject: Re: IRQ and sleep_on
Message-ID: <20010205175348.A2372@pc8.inup.com>
In-Reply-To: <20010205131154.I31876@pc8.inup.com> <20010205133837.A485@pc8.inup.com> <3A7EA3B0.2D7CFA19@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <3A7EA3B0.2D7CFA19@colorfullife.com>; from ma
 nfred@colorfullife.com on lun, fév 05, 2001 at 
 13:59:28 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok thank you for your help.
I've followed your first advice. My solution was ok on my target (ppc and x86) but was not a good solution.
I'm very interesting to know why it's bad to restore flags in a sub-function. I imagine it should be due to an optimisation in the restore function.

Thank you,
Christophe Barbé


On lun, 05 fév 2001 13:59:28 Manfred Spraul wrote:
> christophe barbe wrote:
> > 
> > I've missed the thread "avoiding bad sleeps" last week. I've had a similar problem
> > and I would like to discuss the solution I've used to avoid it.
> > 
> > I want to wake up a sleeping process from an IRQ handler. In the process, if I use
> > a interruptible_sleep_on(), I need first to restore flags (otherwise the process
> > will sleep forever).
> > 
> > restore_flags(flags);
> > // <<== here IRQ handler possibly call wake_up()
> > interruptible_sleep_on(&my_queue);
> >
> > [...]
> > I've written a modified version of  interruptible_sleep_on which takes an
> > additionnal argument : flags to be restored.
> 
> That's possible, but it will crash on Sparc: you cannot restore the
> interrupt flag saved in one function in another function.
> 
> The solution is very simple: do not call restore_flags() before
> interruptible_sleep_on(), the schedule internally reenables interrupts.
> 
> >>>>>>>>>>
> for(;;) {
> 	cli();
> 	if(condition) {
> 		sti();
> 		break;
> 	}
> 	interruptible_sleep_on();
> 	sti(); /* required! */
> } 	
> >>>>>>>>>
> 
> But if you are writing new code, then DO NOT USE sleep_on(), use
> add_wait_queue(), and a spinlock instead of cli().
> Look at wait_event_irq in <linux/raid/md_k.h> from the 2.4 kernel as an
> example.
> 
> --
> 	Manfred
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
-- 
Christophe Barbé
Software Engineer
Lineo High Availability Group
42-46, rue Médéric
92110 Clichy - France
phone (33).1.41.40.02.12
fax (33).1.41.40.02.01
www.lineo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
