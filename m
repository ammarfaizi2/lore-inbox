Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbUKJAON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbUKJAON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 19:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbUKJAOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 19:14:01 -0500
Received: from alog0224.analogic.com ([208.224.220.239]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261807AbUKJAKr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 19:10:47 -0500
Date: Tue, 9 Nov 2004 19:10:40 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Mike Waychison <Michael.Waychison@Sun.COM>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: More linux-2.6.9 module problems
In-Reply-To: <Pine.LNX.4.61.0411091758310.6598@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0411091847130.3651@chaos.analogic.com>
References: <Pine.LNX.4.61.0411081148520.5510@chaos.analogic.com>
 <41911FD4.2060902@sun.com> <Pine.LNX.4.61.0411091522440.3519@chaos.analogic.com>
 <41913A16.5090508@sun.com> <Pine.LNX.4.61.0411091652440.5941@chaos.analogic.com>
 <41914570.5060501@sun.com> <Pine.LNX.4.61.0411091758310.6598@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2004, linux-os wrote:

> On Tue, 9 Nov 2004, Mike Waychison wrote:
>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>> 
>> linux-os wrote:
>>> On Tue, 9 Nov 2004, Mike Waychison wrote:
>>> 
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA1
>>>> 
>>>> linux-os wrote:
>>>> 
>>>>> On Tue, 9 Nov 2004, Mike Waychison wrote:
>>>>> 
>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>>> Hash: SHA1
>>>>>> 
>>>>>> linux-os wrote:
>>>>>> 
>>>>>>> 
>>>>>>> I have a memory-test procedure that tests
>>>>>>> memory on a board, accessed via the PCI bus.
>>>>>>> There is a lot of RAM and it's bank-switched
>>>>>>> into some 64k windows so it takes a lot of
>>>>>>> time to test, about 60 seconds.
>>>>>>> 
>>>>>>> This is in a module, therefore inside the kernel.
>>>>>>> When it is invoked via an ioctl() call, the
>>>>>>> kernel is frozen for the whole test-time. The
>>>>>>> test procedure does not use any spin-locks nor
>>>>>>> does it even use any semaphores. It just does a
>>>>>>> bunch of read/write operations over the PCI/Bus.
>>>>>>> 
>>>>>>> I thought that I could enable the preemptible-
>>>>>>> kernel option and the machine would then respond
>>>>>>> normally. Not so. Even with 4 CPUs, when one
>>>>>>> ioctl() is busy in the kernel, nothing else
>>>>>>> happens until its done. Even keyboard activity
>>>>>>> is gone, no Caps Lock and no Num Lock, no `ping`
>>>>>>> response over the network. However, the machine
>>>>>>> comes back to life when the memory-test is done.
>>>>>>> 
>>>>>>> This is kernel version 2.6.9. Is it possible that
>>>>>>> somebody left on the BKL when calling a module
>>>>>>> ioctl() on this version? If not, what do I do
>>>>>>> to be able to execute a time-consuming procedure
>>>>>>> from inside the kernel? Do I break it up into
>>>>>>> sections and execute schedule() periodically
>>>>>>> (temporary work-around --works)??
>>>>>>> 
>>>>>> 
>>>>>> The BKL has always been grabbed across ioctls.  Drop the lock when you
>>>>>> enter your f_op->ioctl call and grab it again open completion.
>>>>>> 
>>>>> 
>>>>> Hmmm. I get 'scheduling while atomic' screaming across the screen!
>>>>> There are no atomic operations in my ioctl functions so I don't
>>>>> know what its complaining about. I think I shouldn't have tried
>>>>> to do anything with BKL because I (my task) doesn't own it.
>>>>> 
>>>> 
>>>> 'Scheduling while atomic' means you called some function that may
>>>> schedule itself out while you are holding a spinlock.  Note that the BKL
>>>> is not a regular spinlock, and scheduling is allowed while holding it.
>>>> 
>>>> Please see
>>>> http://james.bond.edu.au/courses/inft73626@033/Assigs/Papers/kernel_locking_techniques.html
>>>> 
>>>> by Robert Love, the section titled "The Big Kernel Lock"
>>>> 
>>>> Something else is wrong with your code.
>>> 
>>> 
>>> Not quite. Something is wrong with the e100 network driver used in
>>> 2.6.9. When I do:
>>> 
>>> int ioctl(,,,,)
>>> {
>>>    int ret;
>>>    unlock_kernel();
>>>    ret = original_ioctl(...);
>>>    lock_kernel();
>>>    return ret;
>>> }
>>> In my driver,  completely unrelated to the network.... It's
>>> something in the e100 network driver that the kernel's
>>> complaining about. If I shut down the network and remove
>>> the network driver module I don't have any problems while
>>> enabling BKL. Everything runs fine.
>>> 
>> 
>> Don't do that. ioctls rightly-assume that the BKL is held when they are
>> called.
>> 
>> When I said drop the lock, I meant for _your_ ioctl code.
>> 
>
> Hmmm. My code didn't do any locking, therefore I don't know
> how to, as you say "drop the lock", except how other kernel drivers
> do it. If I had any semaphores (which I don't here), or spin-locks
> (which I don't), I could certainly unlock anything my code locked.
>
> However, the kernel did something before my code was called.
> Therefore, I have no way of undoing it except by calling
> unlock_kernel().
>
> Is there some other way?

I experimented with:
 	release_kernel_lock(current);
         do_ioctl();
         reacquire_kernel_lock(current);

The results were truly spectacular crashes when a copy_to_user
happens in the ioctl(), returning the results. The starting
error is:
    sleeping function called from invalid context at 
arch/i386/lib/usercopy.c:599.

It says in_atomic():1, irqs_disabled():0 so something
makes __might_sleep() think that it's "in_atomic".
Looking at that, I see where !kernel_locked() is going
to cause problems in ../include/linux/hard_irq.h if
we've been preempted.

Then a few hundred thousand lines of unrelated stuff 
smp_apic_timer_interrupt, etc.

FYI, there are no spin-locks and no semaphores in the
ioctl() code, and it all works if I don't muck with the
kernel lock.

So maybe I can't do copy_to_user unless the kernel lock
is held? Seems strange.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
