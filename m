Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316957AbSGCHT1>; Wed, 3 Jul 2002 03:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316958AbSGCHT0>; Wed, 3 Jul 2002 03:19:26 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:11004 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S316957AbSGCHTY>;
	Wed, 3 Jul 2002 03:19:24 -0400
Message-ID: <3D22A5F6.2CC26FC6@mvista.com>
Date: Wed, 03 Jul 2002 00:21:26 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] BH removal text
References: <20020701050555.F29045@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> 
> I'm soliciting comments before people start implementing these things.
> Please, do NOT start changing anything based on the instructions given
> below.  I do intend to update the floppy.c patch to fix the problems
> I mentioned below, but I'm going to sleep first.
> 
> PRERELEASE VERSION 2002-06-30-01
> 
> A janitor's guide to removing bottom halves
> ===========================================
> 
> First, ignore the serial devices.  They're being taken care of
> independently.
> 
> Apart from these, we use 3 bottom halves currently.  IMMEDIATE_BH,
> TIMER_BH and TQUEUE_BH.  There is a spinlock (global_bh_lock) which
> is held when running any of these three bottom halves, so none of them
> can run at the same time.  IMMEDIATE_BH runs the immediate task queue
> (tq_immediate).  TQUEUE_BH runs the timer task queue (tq_timer).
> TIMER_BH first calls update_times(), then runs the timer list.

It should also be noted that none of these is entered if a
cli is in effect.  This is the global cli and inhibits BHs
on all cpus.

-g

> 
> What does all that mean?
> ------------------------
> 
> Right now, the kernel guarantees it will only enter your driver (or
> indeed any user, but we're mostly concerned with drivers) through one of
> these entry points at a time.  If we get rid of bottom halves, we will be
> able to enter a driver simultaneously through any active timer routine,
> any active immediate task routine and any active timer task routine.
> 
> So how do we modify drivers?
> ----------------------------
> 
> I am of the opinion that we should remove tq_immediate entirely.
> Every current user of it should be converted to use a private tasklet.
> Example code for floppy.c to show how to do this can be found at:
> http://ftp.linux.org.uk/pub/linux/willy/patches/floppy.diff
> Note that this patch is BROKEN.  There's no locking to prevent any of our
> timers from being called at the same time as our tasklet.  See below ...
> 
> Some of the users of tq_timer should probably be converted to
> schedule_task so they run in a user context rather than interrupt context.
> But there will always be a need for a task queue to be run in interrupt
> context after a fixed period of time has elapsed in order to allow
> for interrupt mitigation.  I think a better interface should be used
> for tq_timer anyway -- I will be proposing a queue_timer_task() macro.
> We can use conversion to this interface as a flag to indicate that a
> driver has been checked for SMP locking.
> 
> The same thing goes for add_timer users, except that there's no better
> interface that I want to convert drivers to.  So a comment beside the
> add_timer usage indicating that you've checked the locking and it's OK
> is helpful.
> 
> So how should we do the locking?
> --------------------------------
> 
> Notice that right now we use a spinlock whenever we call any of these
> entry points.  So it should be safe to declare a new spinlock within
> this driver and acquire/release it at entry & exit to each of these
> types of functions.  It's easier than converting drivers which use the
> BKL because they might sleep or acquire it twice.  Be wary of reusing an
> existing spinlock because it might be acquired from interrupt context,
> so you'd have to use spin_lock_irq to acquire it in other contexts.
> 
> Of course, that's the lazy way of doing it.  What I'm hoping is that each
> Janitor will take a driver and spend a week checking over its locking.
> There's only 80 files in the kernel which use tq_immediate; with 10
> Janitors involved, that's 8 drivers each -- that's only 2 months and we
> have 4.
> 
> That doesn't mean that we shouldn't worry about the 38 files which use
> tq_timer, but they are almost all tty related and are therefore Hard ;-)
> 
> --
> Revolutions do not require corporate support.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
