Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289250AbSAVRr3>; Tue, 22 Jan 2002 12:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289201AbSAVRrT>; Tue, 22 Jan 2002 12:47:19 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:38412 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S289250AbSAVRrI>; Tue, 22 Jan 2002 12:47:08 -0500
Message-ID: <3C4DA68A.D3DEC61D@loewe-komp.de>
Date: Tue, 22 Jan 2002 18:51:06 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <Pine.LNX.4.33.0201221206320.20907-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn schrieb:
> 
> > So the time between the interrupt handler wanting to schedule a specific
> > task/thread and the next scheduling decision is crucial, right?
> 
> sure, if there's some reason for user-space to run immediately
> after the irq.  that's certainly not the case in general.
> 
> remember, we're talking about what mainline Linux should do.
> 
> > I have no hard numbers, but I can imagine that this can also lead to
> > better IO (in terms of latency AND IO throughput but with the cost of
> > cpu cycles [user space CPU throughput]).
> 
> poorer throughput in general, since there's no chunking
> (write gathering, etc.)  this is my complaint about the
> eager-preempt patches: that the *mandate* eager wakeup.
> the traditional kernel design *can* implement eager wakeup,
> but can also express chunking.
> 

So can the interrupt handler code. The handler decides what to do,
depending on the status of the device. The higher level woken up task can
also do what it wants/ see fits in. The only difference is that higher level 
gets notified a bit earlier - nothing more.

Does the current preempt patch unconditionally mandates preemption to occur?
This would be indeed a design flaw. The handler has to make the decision -
he knows it best.

> > I don't know the Linux kernel good enough right now, but if you shorten
> > the scheduling latency: that could be a win for faster IO. But there's always
> > a tradeoff: if you spent too much time in scheduling decisions/preparations
> > the overhead eats the lower latency (especially if your mutexes have to deal
> > with priority inversion, giving a lock holder at least the same priority as
> > the lock contender for the period it holds the lock).
> 
> no, my criticism is strictly based on the fact that
> eager wakeup is often bad.

Ooh, that sounds different.
But where does a delayed wakeup makes sense in the _general_ case?
You wouldn't want slow interrupts. Kernel preemption allows you a quicker
notify of higher levels. It does not imply any policy on what to do 
with this event.
Of course it's still bad to flood the system with interrupts.
The interrupt handler has to decide if he has to wakeup a higher
level thread, immediatly, on the next schedule or not (if he can
handle it on its own).
