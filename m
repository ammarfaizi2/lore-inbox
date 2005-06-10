Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVFJRhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVFJRhv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 13:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVFJRhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 13:37:51 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:56862
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261152AbVFJRhd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 13:37:33 -0400
Date: Fri, 10 Jun 2005 19:37:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, bhuey@lnxw.com, tglx@linutronix.de,
       karim@opersys.com, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050610173728.GA6564@g5.random>
References: <20050608022646.GA3158@us.ibm.com> <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610154745.GA1300@us.ibm.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

kudos for your very nice RT documents (as usual ;)

On Fri, Jun 10, 2005 at 08:47:46AM -0700, Paul E. McKenney wrote:
> Good point -- I certainly need to add a disclaimer to the effect that
> common hardware (such as VGA, last I checked some months ago) can

> a.	Quality of service: soft realtime, with timeframe of 100s of
> 	microseconds for task scheduling and interrupt handling, but
> 	-only- for very carefully restricted hardware configurations
> 	that exclude problematic devices and drivers (such as VGA)
> 	that can cause latency bumps of tens or even hundreds of
> 	milliseconds (-not- microseconds).  Furthermore, the software
> 	configuration of such systems must be carefully controlled,
> 	for example, doing a "kill -1" traverses the entire task list
> 	with tasklist_lock held (see kill_something_info()), which might
> 	result in disappointing latencies in systems with very large
> 	numbers of tasks.  System services providing I/O, networking,
> 	task creation, and VM manipulation can take much longer.  A very
> 	small performance penalty is exacted, since spinlocks and RCU
> 	must suppress preemption.
> 
> Does this help, or are there other CONFIG_PREEMPT latency issues that
> need to be called out?

You don't need to add it to the document, but as a further pratical
example of troublesome hardware besides VGA (could be a software issue
and not hardware issue though) I'd like to make the example of the irq
handler of the uhci usb1.1 controller that takes up to 8msec on a 1ghz
atlhon UP system, and there's nothing that PREEMPT can do about it since
it's an hard-irq. This latency keeps triggering a few times per second
on my firewall for the last few years.

preempt-RT _can_ do something about it but only _if_ people hacks the
drivers properly and makes sure to call local_irq_save_nort instead of
local_irq_save and other explicit changes like that, things that if
missing are noticeable only during measurements with preempt-RT config
option enabled (hence the metal-hard classification of preempt-RT and
not ruby-hard definition).

See the tg3 updates required to be safe with preempt-RT without breaking
hard-RT as a clear example of how preempt-RT is weak:

--- linux/drivers/net/tg3.c.orig
+++ linux/drivers/net/tg3.c
@@ -3229,9 +3229,9 @@ static int tg3_start_xmit(struct sk_buff
         * So we really do need to disable interrupts when taking
         * tx_lock here.
         */
-       local_irq_save(flags);
+       local_irq_save_nort(flags);
        if (!spin_trylock(&tp->tx_lock)) { 
-               local_irq_restore(flags);
+               local_irq_restore_nort(flags);
                return NETDEV_TX_LOCKED; 
        } 
 
There's no apparent reason why all those changes should be required to
get hard-RT.

Both RTAI and rtlinux _don't_ require to change all those drivers to get
the guarantee that the kernel will get out of the way within a certain
nanoseconds deadline interval.

Furthermore with the scheduler, mutex and context switch code into the
equation, it gets more and more difficult to calculate with math the max
latency that preempt-RT will provide, while it's almost trivial to do
that with RTAI/rtlinux given only the nanokernel code runs before the
hard-RT code is invoked and there are not many paths to test, so one has
to disable the cache and just measure the few possible nanokenrel paths.
(as usual when speaking about hard-RT I've robots in mind, and not audio
code that will call into the alsa ioctls)

This below is the kind of stuff where I wouldn't even dream to replace
a ruby-hard rtlinux/RTAI with a weaker metal-hard and possibly
underperformant (cause scheduling hard-irq in userland and scheduling
instead of spinning isn't going to be cheap in smp) preempt-RT solution:

http://linuxdevices.com/articles/AT7871136191.html

In the above RTAI should have made it as well as rtlinux of course.
