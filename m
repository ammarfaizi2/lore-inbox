Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWFOJ0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWFOJ0R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 05:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWFOJ0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 05:26:17 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:24794 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932465AbWFOJ0Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 05:26:16 -0400
Message-ID: <44912848.5070703@bull.net>
Date: Thu, 15 Jun 2006 11:28:40 +0200
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: =?ISO-8859-15?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: Jakub Jelinek <jakub@redhat.com>, Arjan van de Ven <arjan@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
       Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: NPTL mutex and the scheduling priority
References: <20060612.171035.108739746.nemoto@toshiba-tops.co.jp>	 <1150115008.3131.106.camel@laptopd505.fenrus.org>	 <20060612124406.GZ3115@devserv.devel.redhat.com>	 <1150125869.3835.12.camel@frecb000686>	 <20060613084819.GL3115@devserv.devel.redhat.com>	 <1150200272.3835.33.camel@frecb000686>	 <20060613125603.GQ3115@devserv.devel.redhat.com> <1150291180.3835.59.camel@frecb000686>
In-Reply-To: <1150291180.3835.59.camel@frecb000686>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/06/2006 11:29:58,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/06/2006 11:29:59,
	Serialize complete at 15/06/2006 11:29:59
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sébastien Dugué a écrit :

>> 1) FUTEX_REQUEUE being able to requeue non-PI futex to PI futex
> 
>   We're trying to look into that right now.
> 

Humm, let me try to propose a kind of design for a futex_requeue_pi
which does that.

According to the existing code in -mm tree:

static int futex_requeue_pi(u32 __user *uaddr1, u32 __user *uaddr2,
                 int nr_wake, int nr_requeue, u32 *cmpval) {

    1. for the first nr_wake task in the queue
            => call wake_futex(...) /* as today */
    2. if it remains some tasks in the list to requeue
       a) we must have a pi_state for the futex2.
          *) futex2 has an owner and has some waiters (easy case):
             => walk the list hb2->chain, look for a futex_q matching the
                key2 (as in lookup_pi_state).
             => retrieve the pi_state attached to this futex_q
       OR *) futex2 has an owner but no waiter yet:
             => alloc a pi_state as in lookup_pi_state.
             => set FUTEX_WAITERS flag
       OR *) futex2 has no owner and no waiter:
             => set the FUTEX_WAITERS flag on futex2
             => alloc a pi_state _without_ owner.
             => initialize the rtmutex without owner.

       b) for each futex_q to requeue
          *) requeue the futex_q from hb1 to hb2 (if not the same)
          *) set futex_q->pi_state.
          *) initialize the rt_mutex_waiter pointed by
             futex_q->task->pi_blocked_on with the properties of task
             futex_q->task  (see futex_wait below).
          *) queue it on the wait_list of pi_state->pi_mutex

       c) if there was some waiters on futex2 before us
          *) take care of prio propagation.
          *) if the top_waiter of pi_state->pi_mutex has changed
             => update pi_state->owner->pi_waiters
}


in futex_wait:
==============

static int futex_wait(...) {
    ...
    struct rt_mutex_waiter waiter;  /* hum hum */
    ...

    memset(&waiter, 0, sizeof(waiter));
    current->pi_blocked_on = &waiter; /* will be used in case of requeue
                                         on a PI-futex */
    ...

    /* just before unqueue_me */
    if (q->pi_state) {
        /* we were requeued on a PI-futex */
        1. do what is done at the end of futex_lock_pi
           after "rt_mutex_timed_lock"
        2. may be: do what is done at the end of rtmutex_slowlock
           (remove ourself from the wait_list, adjust prio, ...)

    } else if (!unqueue_me(&q))
       ...

    ...
}

in futex_lock_pi:
=================

static int do_futex_lock_pi(u32 __user *uaddr, int detect, int trylock,
                 struct hrtimer_sleeper *to) {

     ...

/* take care of the case where the futex is free (no owner)
    but there are some waiters that were requeued (futex_requeue_pi) */

   if ((curval & FUTEX_WAITERS) && (curval & FUTEX_TID_MASK) == 0) {
       1. make current the futex owner
         newval = curval & current->pid;

         inc_preempt_count();
         curval = futex_atomic_cmpxchg_inatomic(uaddr, FUTEX_WAITERS, 
newval);
         dec_preempt_count();
         /* handle faulty case */

       2. search a futex_q whose key match the current one to retrieve
          the pi_state.
       3. make current the owner of the pi_state:
          a) list_add(&pi_state->list, &current->pi_state_list);
          b) pi_state->owner = current;
       4. make current the owner of the pi_mutex:
          a) pi_mutex->owner = current;
          b) plist_add(&rt_mutex_top_waiter(&pi_mutex)->pi_list_entry,
                       &current->pi_waiters);
       5. unlock all locks and return
     }

    ...
}


... any kind of comments are welcome ...

Here are some from me:

1. The use of a rt_mutex_waiter in futex_wait does not look very clean 
to me... (or not clean at all...). And thus, I wonder if, for example, 
mixing futex_q and rt_mutex more closely would not be more helpfull in 
this case ??

2. in futex_requeue_pi: how do we know if futex2 is a PI-futex or a 
normal futex ? If there are some waiters, we can check if there is a 
pi_state linked to a futex_q, but otherwise ?
Proposal: use two separate commands (FUTEX_CMP_REQUEUE and 
FUTEX_CMP_REQUEUE_PI) and let the glibc do the choice, as it knows which 
kind of mutex/futex it uses.

Thanks.

Running for shelter now !

-- 
Pierre
