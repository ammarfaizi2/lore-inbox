Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312376AbSCYJs3>; Mon, 25 Mar 2002 04:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312380AbSCYJsT>; Mon, 25 Mar 2002 04:48:19 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:40966 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S312376AbSCYJsL>; Mon, 25 Mar 2002 04:48:11 -0500
Message-ID: <3C9EF242.6080106@loewe-komp.de>
Date: Mon, 25 Mar 2002 10:47:46 +0100
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010923
X-Accept-Language: de, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <E16pKE0-0004Rb-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

> In message <3C9E1A10.F7AA6D6E@loewe-komp.de> you write:
> 
>>I can't see a reason why the ack-futex is needed. I think we can simply
>>delete it.
>>When deleted, the broadcast wouldn't block on ack (also preventing 
>>schedule ping-pong). With the cond->lock it's save to have several
>>broadcasters. That's fine.
>>
> 
> No, you might end up waking someone who did the pthread_cond_wait()
> after you did the pthread_cond_broadcast in place of one of the
> existing pthread_cond_wait() threads.
> 
> I don't believe this is allowed.  
> 


Indeed, I suspect that this isn't wanted.
With the cond->lock you almost prevent this: an ongoing broadcast
can't be intermixed with newly incoming waiters (they will block
on futex_down(&cond->lock))
But there is the window between a->b...


> 
>>But:
>>static int __pthread_cond_wait(pthread_cond_t *cond,
>>                               pthread_mutex_t *mutex,
>>                               const struct timespec *reltime)
>>{
>>        int ret;
>>
>>        /* Increment first so broadcaster knows we are waiting. */
>>	futex_down(&cond->lock);
>>        atomic_inc(cond->num_waiting);
>>(*)     futex_up(&mutex, 1);
>>a)	futex_up(&cond->lock, 1);  [move into syscall]
>>        do {
>>b)                ret = futex_down_time(&cond, ABSTIME); [cond_timed_wait]
>>        } while (ret < 0 && errno == EINTR);
>>	[futex_up(&cond->lock, 1); /* release condvar */]
>>
>>        futex_down(&mutex->futex);
>>        return ret;
>>}
>>
>>With the original code, we have a "signal/broadcast lost window (a->b)" 
>>that shouldn't be there:
>>
> 
> Where?  Having done the inc, the futex_up at (a) will fall through,
> giving the "thread behaves as if it [signal or broadcast] were issued
> after the about-to-block thread has blocked."
> 
Right after (a) another thread gets scheduled, issueing a signal/broadcast.

Ah, and then the futex_down_timed() wouldn't block, OK ;-)
But this way you have to use the ack->lock

 

I strongly believe, that the implementation of a condvar needs a lock
to prevent intermixed calls. You will see my comment on your implementation
with uwaitq. ;-)




