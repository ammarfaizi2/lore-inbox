Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWAIUUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWAIUUM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWAIUUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:20:12 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:30875 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751308AbWAIUUK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:20:10 -0500
Date: Mon, 9 Jan 2006 21:16:33 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: David Singleton <dsingleton@mvista.com>
cc: dino@in.ibm.com, <robustmutexes@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: robust futex deadlock detection patch
In-Reply-To: <43C2C11F.4010408@mvista.com>
Message-ID: <Pine.LNX.4.44L0.0601092109520.18240-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, David Singleton wrote:

> Esben Nielsen wrote:
>
> >
> >I am a little bit confused when I read check_futex_deadlock():
> >It takes a parameter struct thread_info *ti and immediately do
> >struct task_struct *task = ti->task. Now we have the usual pair
> >(thread_info *ti, task_t *task) corresponding to the same process. Later
> >on in the function you do ti = lock_owner(lock), but do not update task.
> >Was this intented?
> >
> >
>
> Whoops.  You are right.  I've fixed the update to the task structure.
> The check_futex_deadlock()
> code now mirrors the existing check_deadlock() code.
>
> >Anyway, I can't see that you have locked the necesary raw_spin_locks.
> >Forinstance lock_owner(lock) must be called with the lock->wait_lock taken
> >and task->blocked_on needs task->pi_lock locked.
> >
> >
>
> Actually those locks are grabbed in the down_try_futex code.  I hold
> both of those
> locks across the check for deadlocks and into __down_interruptible.
> Those locks
> need to be held for the check for deadlocks and holding
> them from down_try_futex to down_interruptible garuantees that a thread
> that enters the kernel to block on a lock will block on the lock.  There
> is no
> window any more between dropping the robust_sem and mmap_sem
> and calling down_interruptible.
>

You only take the spinlocks corresponding to the current lock. What about
the next locks in the chain? Remember those locks might not be
futexes but a lock inside the kernel, taken in system calls. I.e. the
robust_sem might not protect you.
If there are n locks you need to lock n lock->wait_lock and n
owner->task->pi_lock as you traverse the locks. That is what I tried to
sketch in the examble below.

Esben


> This also fixed an SMP problem that Dave Carlson has been seeing on earlier
> patches.
>
> The new patch is at
>
>     http://source.mvista.com/~dsingleton/patch-2.6.15-rt2-rf2
>
> David
>
> >To avoid deadlocks in all the deadlock detection you have to do the loop
> >something like
> >
> >for(owner = current; owner; ) {
> > raw_spin_lock(&owner->pi_lock);
> > if(owner->task->blocked_on) {
> >   lock = owner->task->blocked_on->lock;
> >   raw_spin_lock(&lock->wait_lock);
> >   owner2 = lock_owner(lock);
> >   if(owner2) {
> >     get_task_struct(owner2->task);
> >     raw_spin_unlock(&lock->wait_lock)
> >     raw_spin_unlock(&owner->pi_lock);
> >   }
> > put_task_struct(owner->task);
> > owner = owner2;
> > if(owner2==current) DEADLOCK
> >}
> >
> >
> >Esben
> >
> >
> >
> >
> >>David
> >>
> >>-
> >>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>Please read the FAQ at  http://www.tux.org/lkml/
> >>
> >>
> >>
> >
> >
> >
> >
> >
>

