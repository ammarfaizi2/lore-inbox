Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262706AbVCXGps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbVCXGps (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 01:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbVCXGps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 01:45:48 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:45754 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262706AbVCXGpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 01:45:35 -0500
Date: Wed, 23 Mar 2005 22:45:37 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <peter@programming.kicks-ass.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050324064536.GF1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu> <20050323061601.GE1294@us.ibm.com> <20050323063317.GB31626@elte.hu> <20050323071604.GA32712@elte.hu> <1111566593.14156.2.camel@nspc0585.nedstat.nl> <20050323090341.GA7960@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323090341.GA7960@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 10:03:41AM +0100, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peter@programming.kicks-ass.net> wrote:
> 
> > > i think the 'migrate read-count' method is not adequate either, because
> > > all callbacks queued within an RCU read section must be called after the
> > > lock has been dropped - while with the migration method CPU#1 would be
> > > free to process callbacks queued in the RCU read section still active on
> > > CPU#2.
> >
> > how about keeping the rcu callback list in process context and only
> > splice it to a global (per cpu) list on rcu_read_unlock?
> 
> hm, that would indeed solve this problem. It would also solve the grace
> period problem: all callbacks in the global (per-CPU) list are
> immediately processable. Paul?

If I understand the proposal, it would break in the following situation
(lifted from earlier email):

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

Here, sublist_finalize_rcu() just finds the front of the block and
kfree()s it.

Here is the scenario:

	CPU 1				CPU 2

	task 1 does rcu_read lock

					task 2 does rcu_read_lock

	task 1 sees DELETE_ME

					task 2 sees DELETE_ME

	task 1 acquires the lock

					task 2 blocks/spins on lock

	task 1 does call_rcu

	task 1 releases lock

	task 1 does rcu_read_unlock()

					task 2 acquires lock

	RCU puts the callback on global list

	RCU invokes callback, kfree()!!!

					task 2 now sees garbage!!!


Callbacks cannot be invoked until all RCU read-side critical sections
that were in process at the time of the rcu_callback() have all
completed.

						Thanx, Paul
