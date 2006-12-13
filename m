Return-Path: <linux-kernel-owner+w=401wt.eu-S965011AbWLMQTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbWLMQTx (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 11:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWLMQTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 11:19:53 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:38934 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965011AbWLMQTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 11:19:52 -0500
Message-ID: <4580200E.2010509@bull.net>
Date: Wed, 13 Dec 2006 16:45:18 +0100
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Cc: Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Ingo Molnar <mingo@elte.hu>,
       =?ISO-8859-15?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       Ulrich Drepper <drepper@redhat.com>, Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [PATCH 2.6.19-rt12][RFC] - futex_requeue_pi implementation (requeue
 from futex1 to PI-futex2)
References: <458003BD.40705@bull.net>
In-Reply-To: <458003BD.40705@bull.net>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 13/12/2006 16:52:43,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 13/12/2006 16:52:46,
	Serialize complete at 13/12/2006 16:52:46
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some explanations about the code implementation:

* kernel side:
==============

1)  futex_wait:
	- now there is a rt_mutex_waiter structure included in the futex_q. It will be 
used to queue the thread in the pi_mutex wait_list in case of requeue.
	- Once the thread is woken up in futex_wait, it must check if it has been 
requeued on a PI-futex; it can know this by checking its futex_q.pi_state
	- In this case, then it must still take the pi_mutex (it does not yet own it at 
this state)
	- Then we handle this case as in futex_lock_pi.

2) futex_requeue_pi:
	- a new command is created: FUTEX_CMP_REQUEUE_PI
         - it works as in futex_requeue, but:
         - we must, moreover, update the pi_state of each queue element and 
queue each element in the wait_list of the pi_mutex.
	  For this, first, we must retrieve the pi_state or allocate one if it does not 
yet exist.
	  We use the rt_mutex_waiter structure to queue each thread in the pi_mutex 
wait_list.
	- Finally, we must handle PI-boosting if needed.
	- A new flag is created for PI-futexes with requeued threads: 
FUTEX_WAITER_REQUEUED. The PI-futex uaddr2 is flagged with it. (See below to see 
why we need it)

* glibc side:
=============

1) pthread_cond_broadcast:
	- it calls futex(..., FUTEX_CMP_REQUEUE_PI, ...) if the mutex used with the 
condvar is a PI-mutex.

2) pthread_mutex_cond_lock:
	- If 1) The mutex is a PI-mutex
	     2) and we already own the futex
	     3) and the FUTEX_WAITER_REQUEUED flag is set
	  Then we consider we own the futex and the can lock the mutex
	  (in other words, we don't consider this as a deadlock)

* Why the FUTEX_WAITER_REQUEUED flag ?
======================================
Because, in case of use of PI-mutex:

1) the glibc code of pthread_cond_(timed)wait does:
{
      ...
       /* Wait until woken by signal or broadcast.  */
       lll_futex_wait (&cond->__data.__futex, futex_val);
       /* At return of this call, all threads but one have been
          requeued on PI-futex uaddr2 by the broadcast call.
	 The PI-futex uaddr2 is in fact the mutex used below
      ...
       /* Here, if we have been requeued, the futex (well, the futex
	 used for this mutex) ownership has already been given by the
	 waker on kernel side, in futex_wake_pi */
       return __pthread_mutex_cond_lock (mutex);
}

2) On kernel side, in futex_wake_pi, the futex ownership is given by 
anticipation to "what should be" the woken thread.
In the usual case, the woken thread is blocked in futex_lock_pi and this well 
handle;
But in case of futex_requeue_pi, the woken thread is blocked in futex_wait, and 
it will attempt to lock this futex again by a __pthread_mutex_cond_lock (mutex) 
call...


Humm, I hope it will help, really...

Thanks,

-- 
Pierre P.






