Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbUKIWRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbUKIWRu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 17:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbUKIWRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 17:17:50 -0500
Received: from alog0222.analogic.com ([208.224.220.237]:3968 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261727AbUKIWR1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 17:17:27 -0500
Date: Tue, 9 Nov 2004 17:17:18 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Mike Waychison <Michael.Waychison@Sun.COM>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: More linux-2.6.9 module problems
In-Reply-To: <41913A16.5090508@sun.com>
Message-ID: <Pine.LNX.4.61.0411091652440.5941@chaos.analogic.com>
References: <Pine.LNX.4.61.0411081148520.5510@chaos.analogic.com>
 <41911FD4.2060902@sun.com> <Pine.LNX.4.61.0411091522440.3519@chaos.analogic.com>
 <41913A16.5090508@sun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2004, Mike Waychison wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> linux-os wrote:
>> On Tue, 9 Nov 2004, Mike Waychison wrote:
>>
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> linux-os wrote:
>>>
>>>>
>>>> I have a memory-test procedure that tests
>>>> memory on a board, accessed via the PCI bus.
>>>> There is a lot of RAM and it's bank-switched
>>>> into some 64k windows so it takes a lot of
>>>> time to test, about 60 seconds.
>>>>
>>>> This is in a module, therefore inside the kernel.
>>>> When it is invoked via an ioctl() call, the
>>>> kernel is frozen for the whole test-time. The
>>>> test procedure does not use any spin-locks nor
>>>> does it even use any semaphores. It just does a
>>>> bunch of read/write operations over the PCI/Bus.
>>>>
>>>> I thought that I could enable the preemptible-
>>>> kernel option and the machine would then respond
>>>> normally. Not so. Even with 4 CPUs, when one
>>>> ioctl() is busy in the kernel, nothing else
>>>> happens until its done. Even keyboard activity
>>>> is gone, no Caps Lock and no Num Lock, no `ping`
>>>> response over the network. However, the machine
>>>> comes back to life when the memory-test is done.
>>>>
>>>> This is kernel version 2.6.9. Is it possible that
>>>> somebody left on the BKL when calling a module
>>>> ioctl() on this version? If not, what do I do
>>>> to be able to execute a time-consuming procedure
>>>> from inside the kernel? Do I break it up into
>>>> sections and execute schedule() periodically
>>>> (temporary work-around --works)??
>>>>
>>>
>>> The BKL has always been grabbed across ioctls.  Drop the lock when you
>>> enter your f_op->ioctl call and grab it again open completion.
>>>
>>
>> Hmmm. I get 'scheduling while atomic' screaming across the screen!
>> There are no atomic operations in my ioctl functions so I don't
>> know what its complaining about. I think I shouldn't have tried
>> to do anything with BKL because I (my task) doesn't own it.
>>
>
> 'Scheduling while atomic' means you called some function that may
> schedule itself out while you are holding a spinlock.  Note that the BKL
> is not a regular spinlock, and scheduling is allowed while holding it.
>
> Please see
> http://james.bond.edu.au/courses/inft73626@033/Assigs/Papers/kernel_locking_techniques.html
> by Robert Love, the section titled "The Big Kernel Lock"
>
> Something else is wrong with your code.

Not quite. Something is wrong with the e100 network driver used in
2.6.9. When I do:

int ioctl(,,,,)
{
    int ret;
    unlock_kernel();
    ret = original_ioctl(...);
    lock_kernel();
    return ret;
}
In my driver,  completely unrelated to the network.... It's
something in the e100 network driver that the kernel's
complaining about. If I shut down the network and remove
the network driver module I don't have any problems while
enabling BKL. Everything runs fine.

The code that runs is:

/*
  *   Copyright(c)  2004  Analogic Corporation
  *
  *   This program may be distributed under the GNU Public License
  *   version 2, as published by the Free Software Foundation, Inc.,
  *   59 Temple Place, Suite 330 Boston, MA, 02111.
  *
  *   File ram_test.c	Created 10-MAY-2001	Richard B. Johnson
  */

#include <linux/kernel.h>

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
/*
  *   The following are in file rwcheck.S
  */
extern void xorlw(volatile void *men, size_t wrd, size_t len);
extern void fill_rnd(volatile void *men, size_t len);
extern unsigned char *check_rnd(volatile void *men, size_t len);
extern void set_seed(int);

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
/*
  *   This tests RAM to make sure it is read/writable, and uniquely-
  *   addressable i.e., working.
  *   If the RAM is not working, this returns the address of the
  *   first failing location, otherwise it returns NULL.
  */

#define SEED 0x12345678

unsigned char *testram(volatile void *mem, size_t len)
{
     len /= sizeof(size_t);
     set_seed(SEED);
     fill_rnd(mem, len);
     xorlw(mem, 0x55555555, len);
     xorlw(mem, 0xaaaaaaaa, len);
     xorlw(mem, 0xa5555555, len);
     xorlw(mem, 0x5a555555, len);
     xorlw(mem, 0x55a55555, len);
     xorlw(mem, 0x555a5555, len);
     xorlw(mem, 0x5555a555, len);
     xorlw(mem, 0x55555a55, len);
     xorlw(mem, 0x555555a5, len);
     xorlw(mem, 0x5555555a, len);
     xorlw(mem, 0x5aaaaaaa, len);
     xorlw(mem, 0xa5aaaaaa, len);
     xorlw(mem, 0xaa5aaaaa, len);
     xorlw(mem, 0xaaa5aaaa, len);
     xorlw(mem, 0xaaaa5aaa, len);
     xorlw(mem, 0xaaaaa5aa, len);
     xorlw(mem, 0xaaaaaa5a, len);
     xorlw(mem, 0xaaaaaaa5, len);
     xorlw(mem, 0xaa55aa55, len);
     xorlw(mem, 0x55aa55aa, len);
     xorlw(mem, 0xaa55aa55, len);
     xorlw(mem, 0x55aa55aa, len);
     xorlw(mem, 0xaaaaaaaa, len);
     xorlw(mem, 0x5aaaaaaa, len);
     xorlw(mem, 0xa5aaaaaa, len);
     xorlw(mem, 0xaa5aaaaa, len);
     xorlw(mem, 0xaaa5aaaa, len);
     xorlw(mem, 0xaaaa5aaa, len);
     xorlw(mem, 0xaaaaa5aa, len);
     xorlw(mem, 0xaaaaaa5a, len);
     xorlw(mem, 0xaaaaaaa5, len);
     xorlw(mem, 0xa5555555, len);
     xorlw(mem, 0x5a555555, len);
     xorlw(mem, 0x55a55555, len);
     xorlw(mem, 0x555a5555, len);
     xorlw(mem, 0x5555a555, len);
     xorlw(mem, 0x55555a55, len);
     xorlw(mem, 0x555555a5, len);
     xorlw(mem, 0x5555555a, len);
     xorlw(mem, 0x55555555, len);
     set_seed(SEED);
     return check_rnd(mem, len);
}

The 60 seconds is a very long time to not have a responsive machine.
Once I removed the BKL, the machine was responsive as long as I
removed the network driver. There must be something in that network
driver that is timing-sensitive and I just ticked it off.

I will try a 3-COM board in a few minutes. The 'real' target machines
don't use either of these so it might just be a non-event although
the maintainer of the e100 should know that I've got an interesting
test platform if he's got a patch!


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
