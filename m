Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWAIUAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWAIUAs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWAIUAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:00:48 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:64497 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751273AbWAIUAr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:00:47 -0500
Message-ID: <43C2C11F.4010408@mvista.com>
Date: Mon, 09 Jan 2006 12:01:35 -0800
From: David Singleton <dsingleton@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Esben Nielsen <simlo@phys.au.dk>
Cc: dino@in.ibm.com, robustmutexes@lists.osdl.org,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: robust futex deadlock detection patch
References: <Pine.LNX.4.44L0.0601071105540.17859-100000@lifa03.phys.au.dk>
In-Reply-To: <Pine.LNX.4.44L0.0601071105540.17859-100000@lifa03.phys.au.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Esben Nielsen wrote:

>
>I am a little bit confused when I read check_futex_deadlock():
>It takes a parameter struct thread_info *ti and immediately do
>struct task_struct *task = ti->task. Now we have the usual pair
>(thread_info *ti, task_t *task) corresponding to the same process. Later
>on in the function you do ti = lock_owner(lock), but do not update task.
>Was this intented?
>  
>

Whoops.  You are right.  I've fixed the update to the task structure.  
The check_futex_deadlock()
code now mirrors the existing check_deadlock() code.

>Anyway, I can't see that you have locked the necesary raw_spin_locks.
>Forinstance lock_owner(lock) must be called with the lock->wait_lock taken
>and task->blocked_on needs task->pi_lock locked.
>  
>

Actually those locks are grabbed in the down_try_futex code.  I hold 
both of those
locks across the check for deadlocks and into __down_interruptible.   
Those locks
need to be held for the check for deadlocks and holding
them from down_try_futex to down_interruptible garuantees that a thread
that enters the kernel to block on a lock will block on the lock.  There 
is no
window any more between dropping the robust_sem and mmap_sem
and calling down_interruptible.

This also fixed an SMP problem that Dave Carlson has been seeing on earlier
patches.

The new patch is at

    http://source.mvista.com/~dsingleton/patch-2.6.15-rt2-rf2

David

>To avoid deadlocks in all the deadlock detection you have to do the loop
>something like
>
>for(owner = current; owner; ) {
> raw_spin_lock(&owner->pi_lock);
> if(owner->task->blocked_on) {
>   lock = owner->task->blocked_on->lock;
>   raw_spin_lock(&lock->wait_lock);
>   owner2 = lock_owner(lock);
>   if(owner2) {
>     get_task_struct(owner2->task);
>     raw_spin_unlock(&lock->wait_lock)
>     raw_spin_unlock(&owner->pi_lock);
>   }
> put_task_struct(owner->task);
> owner = owner2;
> if(owner2==current) DEADLOCK
>}
>
>
>Esben
>
>
>  
>
>>David
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>    
>>
>
>
>
>  
>

