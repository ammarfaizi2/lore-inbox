Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbVLOUkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbVLOUkB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 15:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbVLOUkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 15:40:00 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:32495 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751064AbVLOUj7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 15:39:59 -0500
Message-ID: <43A1D4A4.80805@mvista.com>
Date: Thu, 15 Dec 2005 12:40:04 -0800
From: David Singleton <dsingleton@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dino@in.ibm.com
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       robustmutexes@lists.osdl.org
Subject: Re: Recursion bug in -rt
References: <20051214223912.GA4716@in.ibm.com> <9175126B-6D06-11DA-AA1B-000A959BB91E@mvista.com> <20051215194434.GA4741@in.ibm.com>
In-Reply-To: <20051215194434.GA4741@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar,
    two items.

     1) Yes, the INLINE_SYSCALL is the problem that Dave Carlson is seeing.

    2)  Are you saying that a recursive pthread_mutex enters the kernel on
    subsequent lock opertions when it already owns the lock?

    I believe the library should take care of recursive pthread mutexes and
    not enter the kernel on subsequent calls.  The futex_wait function is
    designed to block on lock owned by another thread.

    Let me go spend some time looking at the library code and see what it is
    doing for recursive mutexes. 

David

>On Wed, Dec 14, 2005 at 05:03:13PM -0800, david singleton wrote:
>  
>
>>Dinakar,
>>you may be correct, since reverting the change in down_futex seems 
>>to work.
>>    
>>
>
>Well it did not. It ran for much longer than previously but still 
>hung up. 
>
>Well we have a very basic problem in the current implementation. 
>
>Currently if a thread calls pthread_mutex_lock on the same lock 
>(normal, non recursive lock) twice without unlocking in between, the 
>application hangs. Which is the right behaviour.
>However if the same thing is done with a non recursive robust mutex,
>it manages to acquire the lock.
>
>I see many problems here (I am assuming that the right behaviour
>with robust mutexes is for application to ultimately block
>indefinitely in the kernel)
>
>1. In down_futex we do the following check
>
>	if (owner_task != current)
>		down_try_futex(lock, owner_task->thread_info __EIP__);
>
>   In the above scenario, the thread would have acquired the uncontended
>   lock first time around in userspace. The second time it tries to
>   acquire the same mutex, because of the above check, does not
>   call down_try_futex and hence will not initialize the lock structure
>   in the kernel. It then goes to __down_interruptible where it is 
>   granted the lock, which is wrong.
>
>   So IMO the above check is not right. However removing this check
>   is not the end of story.  This time it gets to task_blocks_on_lock 
>   and tries to grab the task->pi_lock of the owvner which is itself
>   and results in a system hang. (Assuming CONFIG_DEBUG_DEADLOCKS
>   is not set). So it looks like we need to add some check to 
>   prevent this below in case lock_owner happens to be current.
>
>    _raw_spin_lock(&lock_owner(lock)->task->pi_lock);
>
>
>  
>
>>However, I'm  wondering if you've hit a bug that Dave Carlson is 
>>reporting that he's tracked down to an inline in the glibc patch.
>>    
>>
>
>Yes I noticed that, basically it looks like INLINE_SYSCALL, on error
>returns -1 with the error code in errno. Whereas we expect the
>return code to be the same as the kernel return code. Are you referring
>to this or something else ??
>
>However even with all of the above fixes (remove the check in down_futex
>as mentioned above, add a check in task_blocks_on_lock and the glibc
>changes) my test program continues to hang up the system, though it 
>takes a lot longer to recreate the problem now
>
>[snip]
>
>  
>
>>1) Why did the library call into the kernel if the calling thread
>>owned the lock?
>>    
>>
>
>This is something I still havent figured out and leads me to believe
>that we still have a tiny race race somewhere
>
>	-Dinakar
>  
>

