Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316959AbSGHSKu>; Mon, 8 Jul 2002 14:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316996AbSGHSKt>; Mon, 8 Jul 2002 14:10:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47627 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316959AbSGHSKs>; Mon, 8 Jul 2002 14:10:48 -0400
Date: Mon, 8 Jul 2002 20:13:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal
Message-ID: <20020708181331.GD28335@atrey.karlin.mff.cuni.cz>
References: <20020705134816.GA112@elf.ucw.cz> <9171.1026053813@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9171.1026053813@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Modules can run their own kernel threads.  When the module shuts down
> >> it terminates the threads but we must wait until the process entries
> >> for the threads have been reaped.  If you are not careful, the zombie
> >> clean up code can refer to the module that no longer exists.  You must
> >> not freeze any threads that belong to the module.
> >
> >Look at the code. freezer will try for 5 seconds, then give up. So, in
> >rare case module has some threads, rmmod will simply fail. I believe
> >we can fix rare remaining modules one by one.
> 
> There is no failure path for rmmod.  Once rmmod sees a use count of 0,
> it must succeed.  Which is why both Rusty and I agree that rmmod must
> be split in two, one piece that is allowed to fail and a second piece
> that is not.
> 
> BTW, freeze_processes() silently ignores zombie processes.  The test is
> not obvious, it is hidden in the INTERESTING macro which has an
> embedded 'continue' to break out of the loop.  Easy to miss.

Is there problems? Zombie processes are basically dead, not
interesting, processes.

> >> You must not freeze any process that has entered the module but not yet
> >> incremented the use count, nor any process that has decremented the use
> >> count but not yet left the module.  Simply looking at the EIP after
> >
> >Look how freezer works. refrigerator() is blocking, by definition. So
> >if all processes reach refrigerator(), and the use count == 0, it is
> >indeed safe to unload.
> 
> freeze_processes()
>   signal_wake_up() - sets TIF_SIGPENDING for other task
>     kick_if_running()
>       resched_task() - calls preempt_disable() for this cpu
>         smp_send_reschedule()
> 	  smp_reschedule_interrupt() - now on another cpu
> 	    ret_from_intr
> 	      resume_kernel - on other cpu
> 
> With CONFIG_PREEMPT, a process running on another cpu without a lock
> when freeze_processes() is called should immediately end up in
> schedule.  I don't see anything in that code path that disables
> preemption on other cpus.  If I am right, then a second cpu could be in
> this window when freeze_processes is called
> 
>   if (xxx->func)
>     xxx->func()

okay, so we have

	if (xxx->func)
		interrupt
			schedule()

but schedule at this point is certainly not going to enter signal
handling code, so refrigerator is deffered at run to userspace, so it
continues with
		interrupt return
		xxx->func()
	...
	attempt to return to userspace
		signal code
			refrigerator().

So I believe that is safe.

> where func is a module function.  There is still a window from loading
> the function address, through calling the function and up to the point
> where the function does MOD_INC_USE_COUNT.  Any reschedule in that
> window opens a race with rmmod.  Without preemption, freeze might be
> safe, with preemption the race is back again.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
