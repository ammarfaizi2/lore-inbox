Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283660AbRK3O5C>; Fri, 30 Nov 2001 09:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283661AbRK3O4x>; Fri, 30 Nov 2001 09:56:53 -0500
Received: from 209-161-7-161.bradetich.boi.fiberpipe.net ([209.161.7.161]:5778
	"EHLO beavis.ybsoft.com") by vger.kernel.org with ESMTP
	id <S283660AbRK3O4l>; Fri, 30 Nov 2001 09:56:41 -0500
Subject: Re: Possible bug with the keyboard_tasklet? or is it softirq
	tasklet  scheduling?
From: Ryan Bradetich <rbradetich@uswest.net>
To: george anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C0739DE.4E2EF490@mvista.com>
In-Reply-To: <1007100759.13785.8.camel@beavis> 
	<3C0739DE.4E2EF490@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 30 Nov 2001 07:56:35 -0700
Message-Id: <1007132195.13785.10.camel@beavis>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I found this same problem in while trying to run down timer bh issues. 
> With out looking at the keyboard driver (since this is IMHO a tasklet
> issue), I recommend that we not set the "pending" bit
> (__cpu_raise_softirq()) if the tasklet fails because of count !=0, and
> then modify the enable macro to, if the count is now 0, do the
> __cpu_raise_softirq().  This still leaves the issue of the
> tasklet_trylock(t), which will fail in the same way, but there we are
> contending with another cpu and the rules say it can only run on one cpu
> at a time.

hmm.. interesting.  I agree with you that this is a softirq tasklet
scheduling problem, not just related to the keyboard tasklet.  According
to the rules you stated, the tasklet_trylock(t) is bogus and can be
removed.  So what you suggest is to reschedule the tasklet, but not
raise the pending bit if the tasklet is disabled.  I can live with that
:)

I will produce and test a patch based on this tonight.

> On the other hand, why is this bothering you?  You don't say what kernel
> version you are on, but the later versions push this sort of thing off
> to ksoftirqd (a kernel thread) which allows the system to boot (even if
> the thread doesn't exist yet, and it doesn't at this point).

Sorry, I am running (available from cvs.parisc-linux.org)
Linux vega 2.4.16-pa5 #2 SMP Thu Nov 29 21:35:27 MST 2001 parisc unknown

Since this code is arch independent, it is very similar to the 2.4.16
kernel.  (Before posting to the list, I did verify that this problem
existed in the 2.4.16 kernel, and the code paths were the same.)


The reason I tracked this problem down was, if I enabled CONFIG_SMP
(C200+ is a single processor system), the system would "hang" after the
following bootup message:

Based upon Swansea University Computer Society NET3.039

UP kernels worked fine, but SMP kernels would "hang" every time.  I
still do not understand why toggling CONFIG_SMP triggered this "hang",
but it did.  Looks I need to keep digging further and try to understand
why CONFIG_SMP "hangs" the system.



> The tasklet info suggests that it is ok for a tasklet to reschedule
> itself, however, in the current system, this means that it will run each
> interrupt.  Surly a timer would be a better answer, except we don't have
> sub jiffie timers... yet.
> -- 
> George           george@mvista.com
> High-res-timers: http://sourceforge.net/projects/high-res-timers/
> Real time sched: http://sourceforge.net/projects/rtsched/
> 


Thanks for your feedback George!

- Ryan
parisc-linux newbie kernel hacker.


