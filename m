Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbVKRRF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbVKRRF1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 12:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbVKRRF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 12:05:27 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:9980 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S964822AbVKRRF1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 12:05:27 -0500
In-Reply-To: <20051118132715.GA3314@elte.hu>
References: <20051117161817.GA3935@in.ibm.com> <437D0C59.1060607@mvista.com> <20051118092909.GC4858@elte.hu> <20051118132137.GA5639@in.ibm.com> <20051118132715.GA3314@elte.hu>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8311ADE9-5855-11DA-BBAB-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: Dinakar Guniguntala <dino@in.ibm.com>, linux-kernel@vger.kernel.org
From: david singleton <dsingleton@mvista.com>
Subject: Re: PI BUG with -rt13
Date: Fri, 18 Nov 2005 09:05:25 -0800
To: Ingo Molnar <mingo@elte.hu>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 18, 2005, at 5:27 AM, Ingo Molnar wrote:

>
> * Dinakar Guniguntala <dino@in.ibm.com> wrote:
>
>> Ingo, Thanks for providing the fix. However I still hit the same bug
>> even with your changes
>
> even with my patch the robust-futex code is still quite broken. E.g. in
> down_futex(), it accesses rt-mutex internals without any locking (!):
>
>         if (rt_mutex_free(lock)) {
>                 __down_mutex(lock __EIP__);
>                 rt_mutex_set_owner(lock, owner_task->thread_info);
>         }
>
> both rt_mutex_free() and rt_mutex_set_owner() must be called with the
> proper locking. David?

         Yes, the lock  needs to be protected by the robust semaphore.
         The locking order is:

                 mmap_sem to protect the vma that holds the pthread_mutex

                 robust_sem to protect the futex_mutex chain.

                 futex_mutex - the rt_mutex associated with the 
pthread_mutex.


         This section of code performs the locking of the first waiter
         on the pthread_mutex, which was locked by another thread in the
         fast path in userspace.  The fast path locking does not enter 
the
         kernel.

         The first waiter locks the futex_mutex and then changes the
         owner to the 'owning' thread.  The waiter then calls 
down_interruptible
         to block on the futex_mutex.

         I'll provide a patch to protect this piece of code.

David

>
> 	Ingo

