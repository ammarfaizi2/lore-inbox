Return-Path: <linux-kernel-owner+w=401wt.eu-S1423142AbWLUXyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423142AbWLUXyi (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 18:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423139AbWLUXyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 18:54:38 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:37630 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423140AbWLUXyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 18:54:37 -0500
Subject: Re: newbie questions about while (1) in kernel mode and spinlocks
From: Steven Rostedt <rostedt@goodmis.org>
To: Sorin Manolache <sorinm@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20170a030612210141y6578602eo525e6df5f324747d@mail.gmail.com>
References: <20170a030612210141y6578602eo525e6df5f324747d@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 18:54:33 -0500
Message-Id: <1166745273.852.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2006-12-21 at 10:41 +0100, Sorin Manolache wrote:
> Dear list,
> 
> I am in the process of learning how to write linux device drivers.
> 
> I have a 2.6.16.5 kernel running on a monoprocessor machine.

We usually call that a Uniprocessor or just UP.

> #CONFIG_SMP is not set
> CONFIG_DEBUG_SPINLOCK=y.
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_BKL=y
> 
> First question:
> 
> I wrote
> 
> while (1)
>     ;
> 
> in the read function of a test device driver. I expect the calling
> process to freeze, and then a timer interrupt to preempt the kernel
> and to schedule another process. This does not happen, the whole
> system freezes. I see no effect from pressing keys or moving the
> mouse. Why? The hardware interrupts are not disabled, are they? Why do
> the interrupt handlers not get executed?

Matters what you have in that code. Are you sure interrupts are not
handled? The can be, and you just don't notice, because the programs
that get affected by the interrupts are not able to run.

I don't know what your read function looks like, or how you got there,
but a while(1) would only slow the system down quite a bit. It shouldn't
lock it up. (/me goes to try it out on a dummy driver after writing
this).

> 
> Second question:
> 
> I wrote
> 
> spin_lock(&lck);
> down(&sem); /* I know that one shouldn't sleep when holding a lock */
>                     /* but I want to understand why */

Well a spin_lock is just that. It spins.  What happens if you schedule,
and the next process that goes to run tries to grab that same spin_lock.
It spins, thinking the lock holder is on another CPU and it will be
released shortly. But then, the other CPU (assuming a 2x system) has a
process that tries to grab this same spin_lock, now the system is truely
dead locked. All CPUS are spinning waiting for the non-running process
to let go of the spin lock.

> spin_unlock(&lck);
> 
> in the read function and
> 
> up(&sem)
> 
> in the write function. The semaphore is initially locked, so the first
> process invoking down will sleep.
> 
> I invoke
> 
> cat /dev/test
> 
> and the process sleeps on the semaphore. Then I invoke
> 
> echo 1 > /dev/test
> 
> and I wake up the "cat" process.
> 
> Then I intend to invoke _two_ cat processes. I expect the first one to
> sleep on the semaphore and the second on to spin at the spin_lock.
> Then I expect to wake up the first process by invoking an echo, the
> first process to release the lock and the second process to sleep on
> the semaphore. What I get is that the system freezes as soon as I
> invoke the second "cat" process. Again, no effect from key presses or
> mouse movements. Why? Shouldn't the timer interrupt preempt the second
> "cat" process that spins on the spinlock and give control to something
> else, for example to the console where I could wake up the first "cat"
> process? Why do I not see any effect from mouse movements? Hardware
> interrupts are not disabled, are they?

A spin_lock will not preempt. So if you are doing this on a UP system, a
spin lock will only be a preempt disable (with CONFIG_PREEMPT=y).
There's no need for spin_locks for UP.

I'd have to take a look at the actual code to explain exactly what mess
you are making for yourself ;)

> 
> Third question:
> 
> The Linux Device Drivers book says that a spin_lock should not be
> shared between a process and an interrupt handler. The explanation is
> that the process may hold the lock, an interrupt occurs, the interrupt
> handler spins on the lock held by the process and the system freezes.
> Why should it freeze? Isn't it possible for the interrupt handler to
> re-enable interrupts as its first thing, then to spin at the lock, the
> timer interrupt to preempt the interrupt handler and to relinquish
> control to the process which in turn will finish its critical section
> and release the lock, making way for the interrupt handler to
> continue.

I believe that Paolo explained this, but I can go into more details if
you need.

> 
> Thank you very much for clarifying these issues.

No prob.

-- Steve

