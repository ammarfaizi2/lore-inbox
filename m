Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWAIJYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWAIJYr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 04:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWAIJYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 04:24:47 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:53439 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751143AbWAIJYr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 04:24:47 -0500
Date: Mon, 9 Jan 2006 10:23:46 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: david singleton <dsingleton@mvista.com>
cc: dino@in.ibm.com, <robustmutexes@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: robust futex deadlock detection patch
In-Reply-To: <EB15893A-7F26-11DA-9F72-000A959BB91E@mvista.com>
Message-ID: <Pine.LNX.4.44L0.0601071105540.17859-100000@lifa03.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Jan 2006, david singleton wrote:

>
> Here is a new patch that provides both futex deadlock detection and
> prevents ill-behaved and
> malicious apps from deadlocking the kernel through the robust futex
> interface.
>
> 	http://source.mvista.com/~dsingleton/patch-2.6.15-rt2-rf1
>
> Deadlock detection is done 'up front' for both POSIX and robust
> pthread_mutexes.   Non-recursive
> POSIX mutexes will hang if deadlocked, as defined by the POSIX spec.
> The wait channel they
> are hung on is 'futex_deadlock'.  This wait channel makes it easy to
> spot that your POSIX app
> has deadlocked itself via the 'ps' command.
>
> Robust futexes will have -EDEADLK returned to them since there is no
> POSIX specification for
> robust mutexes,  yet, and  returning -EDEADLK is more in the spirit of
> robustness.   Robust
> mutexes are cleaned up by the kernel after a thread dies and they also
> report to the app if
> it is deadlocking itself.
>
> Deadlock detection is something I have wanted to provide for both debug
> and production kernels
> for a while.  It was previously available through DEBUG_DEADLOCKS.  I
> needed to add the
> deadlock dection code for both production and debug kernels to prevent
> applications hanging
> the kernel.
>

I am a little bit confused when I read check_futex_deadlock():
It takes a parameter struct thread_info *ti and immediately do
struct task_struct *task = ti->task. Now we have the usual pair
(thread_info *ti, task_t *task) corresponding to the same process. Later
on in the function you do ti = lock_owner(lock), but do not update task.
Was this intented?

Anyway, I can't see that you have locked the necesary raw_spin_locks.
Forinstance lock_owner(lock) must be called with the lock->wait_lock taken
and task->blocked_on needs task->pi_lock locked.
To avoid deadlocks in all the deadlock detection you have to do the loop
something like

for(owner = current; owner; ) {
 raw_spin_lock(&owner->pi_lock);
 if(owner->task->blocked_on) {
   lock = owner->task->blocked_on->lock;
   raw_spin_lock(&lock->wait_lock);
   owner2 = lock_owner(lock);
   if(owner2) {
     get_task_struct(owner2->task);
     raw_spin_unlock(&lock->wait_lock)
     raw_spin_unlock(&owner->pi_lock);
   }
 put_task_struct(owner->task);
 owner = owner2;
 if(owner2==current) DEADLOCK
}


Esben


> David
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



