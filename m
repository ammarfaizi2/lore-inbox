Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbTKQVZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 16:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbTKQVZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 16:25:59 -0500
Received: from chaos.analogic.com ([204.178.40.224]:35202 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261460AbTKQVZ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 16:25:56 -0500
Date: Mon, 17 Nov 2003 16:28:48 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Q] jiffies overflow & timers.
In-Reply-To: <3FB9373D.6010300@softhome.net>
Message-ID: <Pine.LNX.4.53.0311171624100.27657@chaos>
References: <3FB91527.50007@softhome.net> <Pine.LNX.4.53.0311171347540.24608@chaos>
 <3FB9373D.6010300@softhome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003, Ihar 'Philips' Filipau wrote:

> Richard B. Johnson wrote:
> >
> > Use jiffies as other modules use it:
> >
> >         tim = jiffies + TIMEOUT_IN_HZ;
> >         while(time_before(jiffies, tim))
> >         {
> >             if(what_im_waiting_for())
> >                 break;
> >             current->policy |= SCHED_YIELD;
> >             schedule();
> >         }
> > //
> > // Note that somebody could have taken the CPU for many seconds
> > // causing a 'timeout', therefore, you need to add one more check
> > // after loop-termination:
> > //
> >             if(what_im_waiting_for())
> >                 good();
> >             else
> >                 timed_out();
> >
> > Overflow is handled up to one complete wrap of jiffies + TIMEOUT. It's
> > only the second wrap that will fail and if you are waiting several
> > months for something to happen in your code, the code is broken.
> >
>
>    Thanks! Looks & sounds sane.
>
>    Will try to apply this to my case.
>    what_im_waiting_for() == 'any expired timer'. I'm generating event to
> upper layer, if timer wasn't canceled before. This is network layer
> implementation - e.g. if line is Okay for some specified time, we need
> to generate event that line is 'up'. Or if we didn't get positive ack
> for some specified time resend payload. Something like this.
>
>    And sure you example needs to be enhanced for the case when timer
> gets canceled before. Doable in anyway.
>
>    You example implies I have to have something I can call schedule() on
> - currently I'm running without any user space part. To follow your
> advice I will need to create process a la kswapd/keventd?
>

schedule() is the kernel procedure that gives the CPU to somebody
while your code is waiting for something to happen. You cannot
call that in an interrupt or when a lock is held.

current->policy is a member of 'current' a pointer to a structure
that completely defines the current task being executed. It exists
inside the kernel. You don't need to create a task. Lots of tasks
already exist.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


