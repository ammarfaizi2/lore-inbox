Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316853AbSGHMRn>; Mon, 8 Jul 2002 08:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316855AbSGHMRn>; Mon, 8 Jul 2002 08:17:43 -0400
Received: from chaos.analogic.com ([204.178.40.224]:29315 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316853AbSGHMRl>; Mon, 8 Jul 2002 08:17:41 -0400
Date: Mon, 8 Jul 2002 08:21:59 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Daniel Phillips <phillips@arcor.de>
cc: Pavel Machek <pavel@ucw.cz>, "Stephen C. Tweedie" <sct@redhat.com>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal
In-Reply-To: <E17PtqU-0000RJ-00@starship>
Message-ID: <Pine.LNX.3.95.1020708082014.19138A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2002, Daniel Phillips wrote:

> On Wednesday 03 July 2002 05:48, Pavel Machek wrote:
> > Hi!
> > 
> > Okay. So we want modules and want them unload. And we want it bugfree.
> > 
> > So... then its okay if module unload is *slow*, right?
> > 
> > I believe you can just freeze_processes(), unload module [now its
> > safe, you *know* noone is using that module, because all processes are
> > in your refrigerator], thaw_processes().
> > 
> > That's going to take *lot* of time, but should be very simple and very
> > effective.
> 
> Hi Pavel,
> 
> Is it just the mod_dec_use_count; return/unload race we're worried about?  
> I'm not clear on why this is hard.  I'd think it would be sufficient just to 
> walk all runnable processes to ensure none has an execution address inside the
> module.  For smp, an ipi would pick up the current process on each cpu.
> 
> At this point the use count must be zero and the module deregistered, so all 
> we're interested in is that every process that dec'ed the module's use count 
> has succeeded in executing its way out of the module.  If not, we try again 
> later, or if we're impatient, also bump any processes still inside the module 
> to the front of the run queue.
> 
> I'm sure I must have missed something.
> 
> -- 
> Daniel
> 

Assuming that there are no users of a module, i.e., the current
MOD_DEC_USE_COUNT mechanism, checked under a lock, I think all
you have to do to assure race-free module removal is to:

(1)	Make sure that `current` isn't preempted. There are several
        ways to do this. This may require another global variable.

(2)	Execute cleanup_module(). It is assumed that the user-code
	will deallocate interrupts, and free resources, etc.

(3)	Set a global flag "module_remove", it doesn't have to be atomic.
	It needs only to be volatile. It is used in schedule() to trap
	all CPUs.
        schedule()
        {
            while(module_remove)
                ;
        }

(4)	Wait number-of-CPUs timer-ticks with interrupts alive and well.
        This will make certain that everything queued on the timer gets
        a chance to be executed and everything that would be preempted
        gets trapped in schedule().
 
(5)	Remove the module, reset the flag.

The cost is the single variable that must be checked every time schedule()
is executed plus the 'don't preempt me' variable (if necessary).


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

