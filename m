Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312293AbSCTKnk>; Wed, 20 Mar 2002 05:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312294AbSCTKna>; Wed, 20 Mar 2002 05:43:30 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:11529 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S312293AbSCTKnN>; Wed, 20 Mar 2002 05:43:13 -0500
Message-ID: <3C9867AA.8070008@loewe-komp.de>
Date: Wed, 20 Mar 2002 11:42:50 +0100
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010923
X-Accept-Language: de, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Ulrich Drepper <drepper@redhat.com>, martin.wirth@dlr.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <E16m1oK-0006oy-00@wagner.rustcorp.com.au>	<3C932B2E.90709@dlr.de>	<20020317175009.4f4954a0.rusty@rustcorp.com.au>	<1016412720.2194.16.camel@myware.mynet>	<20020319142842.0d9291c2.rusty@rustcorp.com.au>	<1016510722.2194.101.camel@myware.mynet> <20020320172027.79a70ecd.rusty@rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

> On 18 Mar 2002 20:05:22 -0800
> Ulrich Drepper <drepper@redhat.com> wrote:
> 
> 
>>On Mon, 2002-03-18 at 19:28, Rusty Russell wrote:
>>
>>
>>>What do you WANT in a kernel primitive then?  Given that we now have mutexes,
>>>what else do we need to make pthreads relatively painless?
>>>
>>I think wrt to the mutexes only wake-all is missing.  I don't think that
>>semaphore semantic is needed in the kernel.
>>
> 
> And have all the waiters exit with errno = EAGAIN?  ("You didn't get it but
> someone wanted you all woken").
> 

That's a joke, isn't it? ;-)

We can return -1 with errno=ELOCKBREAK if the process holding the lock

dies.

Why don't we need a semaphore in the kernel?
There is open_sem() for POSIX named semaphores. The SysV interface
is there - and it's far more ugly.

in linuxthreads we have:
sem_t *sem_open(const char *name, int oflag, ...)
{
   __set_errno (ENOSYS);
   return SEM_FAILED;
}

Well, mutexes are not semaphores. Why not have fusema or fuma?
They are good for thread pools where you want several workers.


> It can be done, I'd have to see if is sufficient to implement pthreads.
> 

I don't see the necessity for wake_all except for the barrier case.

A condvar implies, that when successfully returning, the thread
owns the mutex. So even in the case of cond_broadcast, only one thread
will get the mutex - the others will get blocked on that.

The only reason for cond_broadcast I can think of, are implementations
that wouldn't wake_up the highest priority waiting thread. So with
a broadcast all will be woken up and try to acquire the lock.

The waiters will NOT return without the mutex locked except on ETIMEDOUT
(when the thread gets cancelled, the cancelation handler will be called
and the thread will die).

It's also written in the spec, that when you want "predictable scheduling"
the caller of signal/broadcast _has_to_ hold the mutex. On release of
the mutex all other threads will race for it.

