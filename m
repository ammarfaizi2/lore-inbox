Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267607AbUHEIkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267607AbUHEIkZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 04:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267603AbUHEIkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 04:40:25 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:19425 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S267609AbUHEIjm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 04:39:42 -0400
Message-ID: <4111F24C.3050803@free.fr>
Date: Thu, 05 Aug 2004 10:39:40 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040618
X-Accept-Language: en
MIME-Version: 1.0
To: drepper@redhat.com
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wote

>> How large is the slowdown, and on what workloads?
> 
> The fast path for all locking primitives etc in nptl today is entirely
> at userlevel. Normally just a single atomic operation with a dozen
> other instructions. With the fusyn stuff each and every locking
> operation needs a system call to register/unregister the thread as it
> locks/unlocks mutex/rwlocks/etc. Go figure how well this works. We are
> talking about making the fast path of the locking primitives
> two/three/four orders of magnitude more expensive. And this for
> absolutely no benefit for 99.999% of all the code which uses threads.

Frankly, there is no way you can escape calling the kernel to perform 
anything usefull related to respect of scheduling priorities and of 
course it cost more than a user spec only thing. But programming RT 
application correctly if priority invesion due to locking occurs is 
almost _impossible_. So most RT systems (including Open Source ones) 
have two kind of primitives (e.g Jaluna (mutex/semaphore (hint hint), 
RTEMS various kind of semaphore), the users level only one. Most of the 
time people are readdy to pay the price for determinism.

>> Passing the lock to a non-rt task when there's an rt-task waiting for it
>> seems pretty poor form, too.

Exactly.

> No no, that's not what is wanted. Robust mutexes are a special kind of
> mutex and not related to rt issues. Lockers of robust mutexes have to
> register with the kernel (i.e., the locking must actually be performed
> by the kernel) so that in case the thread goes away or the entire
> process dies, the mutex is unlocked and other waiters (other threads, in
> the same or other processes) can get the lock. This is very useful for
> normal operations where mutexes are used inter-process. This is the
> part which is independent from rt but it also must not be the default
> mode (i.e., normal pthread_mutex_t code must not be replaced) since it
> is significantly slower.

Robust mutext could also then be used then for dealing with priority 
inversion, handling of thread priorities when dequeing, ... But if you 
cannot access theses functionnality without going away of posix API, 
that's a pity.

> The rest of the extensions like all the priority handling is not of
> general interest. POSIX describes how a thread's priority would be
> temporarily raised if it holds a mutex which has a higher-priority
> waiter. But this is all functionality of a realtime profile and widely
> not part of the normal implementation.

I guess you do not read linuxdevices often enough : linux is becoming a
major player in the embeeded market place and RT behavior is important 
here. Given the work that already occured on reducing scheduling latency 
and continue with the voluntary premption patche trial, I guess it is 
time to make application at least able to benefit of theses enhancements.

Question for Andrew : I have seen the IRQ handler -> IRQ thread handler 
conversion patch and for me this will go about nowhere (from experience) 
but I'm wondering why nobody actually proposed as way to define logical 
interrupt priorities (e.g by applying a mask on the 8259 rather than 
just masking the current interrupt). More details at 
<http://www.rtems.org/cgi-bin/viewcvs.cgi/rtems/c/src/lib/libbsp/i386/shared/irq/> 


Defining a generic API, is very complicated and has been given up by 
almost RTOS vendor but defining priorities among interrupts is important 
and threads simply too costly for interrupt driven applications :-)

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr



