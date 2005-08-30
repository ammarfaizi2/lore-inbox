Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVH3PBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVH3PBb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 11:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVH3PBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 11:01:31 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:42174 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932168AbVH3PBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 11:01:30 -0400
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, dwalker@mvista.com,
       george anzinger <george@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1125064334.5365.39.camel@localhost.localdomain>
References: <1124704837.5208.22.camel@localhost.localdomain>
	 <20050822101632.GA28803@elte.hu>
	 <1124710309.5208.30.camel@localhost.localdomain>
	 <20050822113858.GA1160@elte.hu>
	 <1124715755.5647.4.camel@localhost.localdomain>
	 <20050822183355.GB13888@elte.hu>
	 <1124739657.5809.6.camel@localhost.localdomain>
	 <1124739895.5809.11.camel@localhost.localdomain>
	 <1124981238.5350.6.camel@localhost.localdomain>
	 <1124982413.5350.19.camel@localhost.localdomain>
	 <20050825174732.GA23774@elte.hu>
	 <1125000563.6264.10.camel@localhost.localdomain>
	 <1125023010.5365.4.camel@localhost.localdomain>
	 <1125064334.5365.39.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 30 Aug 2005 11:00:39 -0400
Message-Id: <1125414039.5675.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I'm looking for a second set of eyes (or third or more :-) to see if
there's a danger of a deadlock here.

The task->pi_lock is dependent on the order of locking, which I said was
proven to be true, otherwise there would be a deadlock.

L1->P1->L2->P2-L3->P3 

Where lock L1 is owned by P1 which is blocked on L2 and so on.

The problem comes when we have to deal with this BKL.  This lock is
special in that it can be grabbed and released and break this chain.
Mainly with semaphores, since BKL shouldn't be released when scheduling
where the old spin_locks were replaced.  But since we replaced
semaphores with mutexes, the BKL starts to change the rules.

(Ingo, my last patch is flawed since it only covers the case of
semaphores, so please don't apply it, yet).

Now we can have:

BKL->P1->L1->P2->BKL

Where there's a loop.  The good news is that this only happens when P1
is about to release the BKL, otherwise it would be a real deadlock in
the kernel and not with the PI.

My fear of a deadlock is in the __up code.  Where we have the locking
order of:  

P2->BKL->P1

Is there someplace that can cause this to deadlock?

To deadlock, we need another process on another CPU to lock in the
following order:

P1->L1->P2->BKL

Which I guess can happen and we would get a deadlock.  This task could
be holding P1 and L1 and be waiting on P2 while the __up could have P2
and BKL and be waiting on P1.

So would this solve the problem with this deadlock?  This would be in
pick_new_owner where the caller is the __up.  (the P2->BKL-P1 side) This
is not a patch, but I put +'s at the added code.


#ifdef CONFIG_SMP
 try_again:
#endif
	trace_special_pid(waiter->ti->task->pid, waiter->ti->task->prio, 0);

#ifdef ALL_TASKS_PI
	check_pi_list_present(lock, waiter, old_owner);
#endif
	new_owner = waiter->ti;
	/*
	 * The new owner is still blocked on this lock, so we
	 * must release the lock->wait_lock before grabing
	 * the new_owner lock.
	 */
	__raw_spin_unlock(&lock->wait_lock);
	__raw_spin_lock(&new_owner->task->pi_lock);
	__raw_spin_lock(&lock->wait_lock);
	/*
	 * In this split second of releasing the lock, a high priority
	 * process could have come along and blocked as well.
	 */
#ifdef CONFIG_SMP
	waiter = plist_first_entry(&lock->wait_list, struct rt_mutex_waiter, list);
	if (unlikely(waiter->ti != new_owner)) {
		__raw_spin_unlock(&new_owner->task->pi_lock);
		goto try_again;
	}
+	/*
+	 * Once again the BKL comes to play.  Since the BKL can be grabbed and released
+	 * out of the normal P1->L1->P2 order, there's a chance that someone has the
+	 * BKL owner's lock and is waiting on the new owner lock.
+	 */
+	if (unlikely(lock == &kernel_sem.lock)) {
+		if (!__raw_spin_trylock(&old_owner->task->pi_lock)) {
+			__raw_spin_unlock(&lock->wait_lock);
+			__raw_spin_unlock(&new_owner->task->pi_lock);
+			goto try_again;
+		}
+	} else
#endif
		__raw_spin_lock(&old_owner->task->pi_lock);


-- Steve


