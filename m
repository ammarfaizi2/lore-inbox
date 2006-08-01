Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422768AbWHAH6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422768AbWHAH6d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 03:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422769AbWHAH6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 03:58:33 -0400
Received: from www.osadl.org ([213.239.205.134]:22754 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1422768AbWHAH6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 03:58:32 -0400
Subject: Re: rt_mutex_timed_lock() vs hrtimer_wakeup() race ?
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060730043605.GA2894@oleg>
References: <20060730043605.GA2894@oleg>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 09:58:36 +0200
Message-Id: <1154419117.5932.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-30 at 08:36 +0400, Oleg Nesterov wrote:
> Another question, task_blocks_on_rt_mutex() does get_task_struct() and checks
> owner->pi_blocked_on != NULL under owner->pi_lock. Why ? RT_MUTEX_HAS_WAITERS
> bit is set, we are holding ->wait_lock, so the 'owner' can't go away until
> we drop ->wait_lock. I think we can drop owner->pi_lock right after
> __rt_mutex_adjust_prio(owner), we can't miss owner->pi_blocked_on != NULL
> if it was true before we take owner->pi_lock, and this is the case we should
> worry about, yes?

No.

We hold lock->wait_lock. The owner of this lock can be blocked itself,
which makes it necessary to do the chain walk. The indicator is
owner->pi_blocked_on. This field is only protected by owner->pi_lock.

If we look at this field outside of owner->pi_lock, then we might miss a
chain walk.

CPU 0					CPU 1

lock lock->wait_lock

block_on_rt_mutex()

lock current->pi_lock
current->pi_blocked_on = waiter(lock)
unlock current->pi_lock

boost = owner->pi_blocked_on

					owner blocks on lock2
					lock owner->pi_lock
					owner->pi_blocked_on = waiter(lock2)
					unlock owner->pi_lock

lock owner->pi_lock
enqueue waiter
adjust prio
unlock owner->pi_lock
unlock lock->wait_lock

if boost
	do_chain_walk()

->pi_blocked_on is protected by ->pi_lock and has to be read/modified
under this lock. That way we can not miss a chain walk:

CPU 0					CPU 1

lock lock->wait_lock

block_on_rt_mutex()

lock current->pi_lock
current->pi_blocked_on = waiter(lock)
unlock current->pi_lock

					owner blocks on lock2
					lock owner->pi_lock
					owner->pi_blocked_on = waiter(lock2)
					unlock owner->pi_lock

lock owner->pi_lock
enqueue waiter
adjust prio
boost = owner->pi_blocked_on
unlock owner->pi_lock
unlock lock->wait_lock

if boost
	do_chain_walk()


CPU 0					CPU 1

lock lock->wait_lock

block_on_rt_mutex()

lock current->pi_lock
current->pi_blocked_on = waiter(lock)
unlock current->pi_lock

lock owner->pi_lock
enqueue waiter
adjust prio of owner
boost = owner->pi_blocked_on
unlock owner->pi_lock
unlock lock->wait_lock

					owner blocks on lock2
					lock owner->pi_lock
					owner->pi_blocked_on = waiter(lock2)
					unlock owner->pi_lock
if boost
	do_chain_walk()

					owner propagates the priority to owner(lock2)

get_task_struct() is there for a different reason. We have to protect
the gap where we hold _no_ lock in rt_mutex_adjust_prio_chain:

retry:
	lock task->pi_lock
	block = task->pi_blocked_on->lock
	if (! trylock block->wait_lock) {
		unlock task->pi_lock

-> task could go away right here, if we do not hold a reference

		cpu_relax()
		goto retry
	}


	tglx


