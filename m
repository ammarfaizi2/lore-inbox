Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbULITGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbULITGg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 14:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbULITGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 14:06:36 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:37019 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261538AbULITGb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 14:06:31 -0500
Date: Thu, 9 Dec 2004 20:04:55 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Mark_H_Johnson@raytheon.com
Cc: Florian Schmidt <mista.tapas@gmx.net>, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
In-Reply-To: <OF8CB9B8EE.C928A668-ON86256F65.0058B4C3@raytheon.com>
Message-Id: <Pine.OSF.4.05.10412091907430.4626-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2004 Mark_H_Johnson@raytheon.com wrote:

> Don't take this message the wrong way. I strongly support what
> Ingo is doing with the 2.6 kernel. Its just sometimes the measurements
> don't seem to show the improvements everyone wants to see.

It all depends on whate "everyone" wants to see!  You can have tuning for
quite different things. Even within real-time you can tune for low
interrupt latency, low task latency and predictability.

If you forinstance want low interrupt latency you take avoid doing almost
anything with interrupts disabled and actions like waking a task is
deferred from the interrupt routings to some post interrupt handling. But
that is ofcourse an overhead because you add yet another state to the
whole structure. That would most like mean lower task latency.

Priority inheritance improves the predictability but it doesn't improve 
the raw interrupt or task latency.

In general: If you want really low latencies you have to do stuff which
hurt the overall performance because you have to turn on preemption at a
really low level. On the other hand if your latency requirement is not
that low you can do much better by locking for long periods (but shorter
than your required latency, ofcourse) and get done with the job at hand
without worrying about fine-grained locking.

> [...]
>   "IRQ-threading will always be more expensive than direct IRQs,
>    but it should be a fixed overhead not some drastic degradation."
> I agree the overhead should be modest but somehow the test cases I
> run don't show that (yet). There is certainly more work to be done
> to fix that.
> 

IRQ threading makes the system more predictable but for many, many
devices it is very expensive. I am predicting that many interrupt routines 
have to be turned back to running in interrupt context.

At work I deal with a few drivers in a RTOS. We run ArcNet and ethernet
drivers in task context because the bus is so slow that reading/writing
packets from/to the controllers will block interrupts and therefore all 
tasks for too long. But all the fast interrupts (serial, CAN, timers...)
we handle in interrupt context. 

On a general perpose OS like Linux where different "users" (RT developers
in this case) have different needs on different systems. Therefore I think
it ought to be configureable, driver for driver. It will be a hard job to
go through them, but Ingo have certainly laid out the framework. What is
needed is to add CONFIG_MY_DRIVER_THREADED and decide the threading and
lock types of the locks used in the driver from that option. Code can
probably be made to do most of the conversions and adding to the configs
automaticly :-)

Muteces are also an overhead. There must be a lot of locks in the system
which can safely be transfered back to raw spinlocks as the locking time
is in the same order of the locking time internally in a mutex. There is
no perpose of using a mutex instead of a raw spinlock if the region being
locked is shorter or about the same as the job of handling the mutex
internals and rescheduling (twice)!

Finally I suggest a very dirty compromise:
Use the internal spinlock in a mutex to lock the users region when that
region is really small. I.e. instead of (the most common case):
 lock mutex's spinlock
 set mutex's owner current
 unlock mutex's spinlock
 do the stuff
 lock mutex's spinlock
 set mutex's owner NULL
 unlock mutex's spinlock

do
 lock mutex's spinlock
 check owner==NULL
 do the stuff
 unlock mutex's spinlock

Ofcourse if owner!=NULL this will have to fall back to the very slow case 
of sleeping. Once it is seen that all lockings done with a mutex is done
this way it can safely be made into a raw spinlock.

Esben


> --Mark H Johnson
>   <mailto:Mark_H_Johnson@raytheon.com>
> 


