Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263053AbVCXGiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbVCXGiW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 01:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbVCXGiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 01:38:22 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:2699 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263053AbVCXGh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 01:37:58 -0500
Date: Wed, 23 Mar 2005 22:38:02 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050324063802.GE1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu> <20050323061601.GE1294@us.ibm.com> <20050323063317.GB31626@elte.hu> <20050323071604.GA32712@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323071604.GA32712@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 08:16:04AM +0100, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > That callback will be queued on CPU#2 - while the task still keeps
> > current->rcu_data of CPU#1. It also means that CPU#2's read counter
> > did _not_ get increased - and a too short grace period may occur.
> > 
> > it seems to me that that only safe method is to pick an 'RCU CPU' when
> > first entering the read section, and then sticking to it, no matter
> > where the task gets migrated to. Or to 'migrate' the +1 read count
> > from one CPU to the other, within the scheduler.
> 
> i think the 'migrate read-count' method is not adequate either, because
> all callbacks queued within an RCU read section must be called after the
> lock has been dropped - while with the migration method CPU#1 would be
> free to process callbacks queued in the RCU read section still active on
> CPU#2.

Right -- the limitation is that you cannot declare a grace period
over until -all- RCU read-side critical sections that started before
the call_rcu() have completed.

> i'm wondering how much of a problem this is though. Can there be stale
> pointers at that point? Yes in theory, because code like:
> 
> 	rcu_read_lock();
> 	call_rcu(&dentry->d_rcu, d_callback);
> 	func(dentry->whatever);
> 	rcu_read_unlock();

In this code segment, a correct RCU will not invoke the callback
until after the rcu_read_unlock().  Ugly code, though.  But see
below...

> would be unsafe because the pointer is still accessed within the RCU
> read section, and if we get migrated from CPU#1 to CPU#2 after call_rcu
> but before dentry->whatever dereference, the callback may be processed
> early by CPU#1, making the dentry->whatever read operation unsafe.
> 
> the question is, does this occur in practice? Does existing RCU-using
> code use pointers it has queued for freeing, relying on the fact that
> the callback wont be processed until we drop the RCU read lock?

Using a pointer that had been passed to call_rcu() would be in theory
safe, but I would usually object to it.  In most cases, it would cause
confusion at the very least.  However, there are exceptions:

	rcu_read_lock();
	list_for_each_entry_rcu(p, head, list) {
		if (unlikely(p->status == DELETE_ME)) {
			spin_lock(&p->mutex);
			if (likely(p->status == DELETE_ME)) {
				p->status = DELETED;
				list_rcu(&p->list);
				call_rcu(&p->rcu, sublist_finalize_rcu);
			}
			spin_unlock(&p->mutex);
		}
	}
	rcu_read_unlock();

You can drop the spinlock before the call_rcu() if you want, but doing
so makes the code uglier.  Besides, you have to allow for the fact that
another instance of this same code might be running on the same list
on some other CPU.  You cannot invoke the callback until -both- CPUs/tasks
have exited their RCU read-side critical sections.

							Thanx, Paul
