Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318744AbSICKJJ>; Tue, 3 Sep 2002 06:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318747AbSICKJJ>; Tue, 3 Sep 2002 06:09:09 -0400
Received: from h181n1fls11o1004.telia.com ([195.67.254.181]:52097 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S318744AbSICKJI>; Tue, 3 Sep 2002 06:09:08 -0400
Date: Tue, 3 Sep 2002 12:13:34 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: Ingo Molnar <mingo@elte.hu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
In-Reply-To: <Pine.LNX.4.44.0209030750380.2379-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209031150310.6862-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Ingo Molnar wrote:

> On Mon, 2 Sep 2002, Tobias Ringstrom wrote:
> 
> > But I still do not understand why the process is classified as
> > non-interactive...  Around 20 times per second it does a nanosleep for 1
> > ms which takes around 40 ms in reality.  (Seeing this makes me believe
> > that I should try to increase HZ, but that is a separate issue.)
> 
> what CPU usage does it have? 70% CPU usage is not interactive.
> 
> well, even 70% CPU usage can be interactive if you lower its priority to
> -20. But with the default nice value a task will lose its interactivity
> much quicker.

If I understand the code in sched.c correctly, the dynamic prio [-5...5]
is calculated using sleep_avg, but the name is deceiving, it's more like
the edge of a knife.  If a process is sleeping, its sleep_avg is
incremented by one per timer tick, and if it is running it is decremented
by one per timer tick.  This means (for a periodic task) that if it sleeps
for less than 50% of the timer ticks, it will get a sleep_avg of zero
(dynamic prio +5), and if it is sleeping for more than 50%, it will get a 
sleep_avg of MAX_SLEEP_AVG (dynamic prio -5).

For the case of a game server, this means that when the CPU utilization 
gets above 50% (roughly), it will switch from -5 to +5 in dynamic priority 
in a few seconds and stay there until the CPU utilization drops under 50%.

Is my analysis correct, and is this what we want?

Have you experimented with other averaging algorithms?

> also, could you increase HZ to 1000 (in asm/param.h, full recompile of the
> kernel is needed), does it make a difference?

I tried that yesterday (without the O(1) scheduler), and it does wonders
for the in-game latency (i.e. ping).  I suppose that the dynamic prio will
still be +5 at 70% CPU utilization even with a HZ of 1000 using the O(1)  
scheduler.  Why would it make a difference?

/Tobias

