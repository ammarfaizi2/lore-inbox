Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWHAMHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWHAMHX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 08:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWHAMHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 08:07:22 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:64205 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751116AbWHAMHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 08:07:22 -0400
Subject: Re: rt_mutex_timed_lock() vs hrtimer_wakeup() race ?
From: Steven Rostedt <rostedt@goodmis.org>
To: tglx@linutronix.de
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Ingo Molnar <mingo@elte.hu>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1154419117.5932.55.camel@localhost.localdomain>
References: <20060730043605.GA2894@oleg>
	 <1154419117.5932.55.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 08:07:11 -0400
Message-Id: <1154434031.25445.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 09:58 +0200, Thomas Gleixner wrote:
> On Sun, 2006-07-30 at 08:36 +0400, Oleg Nesterov wrote:
> > Another question, task_blocks_on_rt_mutex() does get_task_struct() and checks
> > owner->pi_blocked_on != NULL under owner->pi_lock. Why ? RT_MUTEX_HAS_WAITERS
> > bit is set, we are holding ->wait_lock, so the 'owner' can't go away until
> > we drop ->wait_lock. I think we can drop owner->pi_lock right after
> > __rt_mutex_adjust_prio(owner), we can't miss owner->pi_blocked_on != NULL
> > if it was true before we take owner->pi_lock, and this is the case we should
> > worry about, yes?
> 
> No.
> 
> We hold lock->wait_lock. The owner of this lock can be blocked itself,
> which makes it necessary to do the chain walk. The indicator is
> owner->pi_blocked_on. This field is only protected by owner->pi_lock.
> 
> If we look at this field outside of owner->pi_lock, then we might miss a
> chain walk.
> 

Actually Thomas, not counting the debug case, his patch wont miss a
chain walk.  That is because the boost is read _after_ the owner's prio
is adjusted.  So the only thing the lock is doing for us is to prevent
us from walking the chain twice for the same lock grab. (btw. I'm
looking at 2.6.18-rc2, and not the -rt patch, just to make things
clear).

> CPU 0					CPU 1
> 
> lock lock->wait_lock
> 
> block_on_rt_mutex()
> 
> lock current->pi_lock
> current->pi_blocked_on = waiter(lock)
> unlock current->pi_lock
> 
> boost = owner->pi_blocked_on
> 
> 					owner blocks on lock2
> 					lock owner->pi_lock
> 					owner->pi_blocked_on = waiter(lock2)
> 					unlock owner->pi_lock
> 
> lock owner->pi_lock
> enqueue waiter
> adjust prio
> unlock owner->pi_lock
> unlock lock->wait_lock
> 
> if boost
> 	do_chain_walk()
> 
> ->pi_blocked_on is protected by ->pi_lock and has to be read/modified

Something does not have to be read under a lock unless it is actually
doing something with it while still under the lock. But this code
doesn't do that.  It reads boost = owner->pi_blocked_on and then
releases the lock.  The only other thing that this read is protected
with is the adjusting of the prio.  So as I said. We are protecting
against doing more work, and that is all.  We wont miss any chain walk
by moving the boost check outside the lock, as long as we do the boost
check _after_ we adjusted the owner's prio and the blocking task is on
the owner's/lock's wait queue.

> under this lock. That way we can not miss a chain walk:
> 
> CPU 0					CPU 1
> 
> lock lock->wait_lock
> 
> block_on_rt_mutex()
> 
> lock current->pi_lock
> current->pi_blocked_on = waiter(lock)
> unlock current->pi_lock
> 
> 					owner blocks on lock2
> 					lock owner->pi_lock
> 					owner->pi_blocked_on = waiter(lock2)
> 					unlock owner->pi_lock
> 
> lock owner->pi_lock
> enqueue waiter
> adjust prio
> boost = owner->pi_blocked_on
> unlock owner->pi_lock
> unlock lock->wait_lock
> 
> if boost
> 	do_chain_walk()
> 

BTW, you are showing a lot of CPU0 vs CPU1 code here without explaining
what you are showing. Please point out where exactly a chain walk is
missed, and how the locking of the boost variable helps.  All I see is
that it prevents the chain walk from happening twice.

Reading a variable under a lock and then releasing the lock does
nothing, unless that variable might be a NULL dereference, and that
would mean that the owner struct disappeared.  Which can't happen
because we still have the wait_lock (see below).

> 
> CPU 0					CPU 1
> 
> lock lock->wait_lock
> 
> block_on_rt_mutex()
> 
> lock current->pi_lock
> current->pi_blocked_on = waiter(lock)
> unlock current->pi_lock
> 
> lock owner->pi_lock
> enqueue waiter
> adjust prio of owner
> boost = owner->pi_blocked_on
> unlock owner->pi_lock
> unlock lock->wait_lock
> 
> 					owner blocks on lock2
> 					lock owner->pi_lock
> 					owner->pi_blocked_on = waiter(lock2)
> 					unlock owner->pi_lock
> if boost
> 	do_chain_walk()
> 
> 					owner propagates the priority to owner(lock2)
> 
> get_task_struct() is there for a different reason. We have to protect
> the gap where we hold _no_ lock in rt_mutex_adjust_prio_chain:

I think Oleg realized this. But the question was why is it done with the
pi_lock held.  It is just as good to do it with the wait_lock held,
because the owner can't disappear while holding a lock or that is in
itself is a bug.  So we can push that get_task_struct to just before the
wait_lock is released.

-- Steve

> 
> retry:
> 	lock task->pi_lock
> 	block = task->pi_blocked_on->lock
> 	if (! trylock block->wait_lock) {
> 		unlock task->pi_lock
> 
> -> task could go away right here, if we do not hold a reference
> 
> 		cpu_relax()
> 		goto retry
> 	}
> 
> 
> 	tglx
> 
> 

