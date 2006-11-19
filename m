Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933344AbWKSV0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933344AbWKSV0v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 16:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933349AbWKSV0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 16:26:51 -0500
Received: from pool-71-111-72-250.ptldor.dsl-w.verizon.net ([71.111.72.250]:28227
	"EHLO IBM-8EC8B5596CA.beaverton.ibm.com") by vger.kernel.org
	with ESMTP id S933344AbWKSV0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 16:26:50 -0500
Date: Sun, 19 Nov 2006 13:23:16 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Jens Axboe <jens.axboe@oracle.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Linus Torvalds <torvalds@osdl.org>, Thomas Gleixner <tglx@timesys.com>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, manfred@colorfullife.com
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061119212316.GG4427@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <Pine.LNX.4.64.0611161414580.3349@woody.osdl.org> <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org> <20061117065128.GA5452@us.ibm.com> <20061117092925.GT7164@kernel.dk> <20061117183945.GA367@oleg> <20061118002845.GF2632@us.ibm.com> <20061118190217.GB163@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061118190217.GB163@oleg>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2006 at 10:02:17PM +0300, Oleg Nesterov wrote:
> On 11/17, Paul E. McKenney wrote:
> >
> >  int srcu_read_lock(struct srcu_struct *sp)
> >  {
> >  	int idx;
> > +	struct srcu_struct_array *sap;
> >
> >  	preempt_disable();
> >  	idx = sp->completed & 0x1;
> > -	barrier();  /* ensure compiler looks -once- at sp->completed. */
> > -	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]++;
> > -	srcu_barrier();  /* ensure compiler won't misorder critical section. */
> > +	sap = rcu_dereference(sp->per_cpu_ref);
> > +	if (likely(sap != NULL)) {
> > +		barrier();  /* ensure compiler looks -once- at sp->completed. */
> > +		per_cpu_ptr(rcu_dereference(sap),
> > +			    smp_processor_id())->c[idx]++;
> > +		smp_mb();
> > +		preempt_enable();
> > +		return idx;
> > +	}
> > +	if (mutex_trylock(&sp->mutex)) {
> > +		preempt_enable();
> > +		if (sp->per_cpu_ref == NULL)
> > +			sp->per_cpu_ref = alloc_srcu_struct_percpu();
> > +		if (sp->per_cpu_ref == NULL) {
> > +			atomic_inc(&sp->hardluckref);
> > +			mutex_unlock(&sp->mutex);
> > +			return -1;
> > +		}
> > +		mutex_unlock(&sp->mutex);
> > +		return srcu_read_lock(sp);
> > +	}
> >  	preempt_enable();
> > -	return idx;
> > +	atomic_inc(&sp->hardluckref);
> > +	return -1;
> >  }
> 
> This is a real nitpick, but in theory we have a possibility for the livelock.
> 
> Suppose that synchronize_srcu() takes sp->mutex and fails to allocate
> sp->per_cpu_ref. If we have a flow of srcu_read_lock/srcu_read_unlock,
> this loop in synchronize_srcu()
> 
>   	while (srcu_readers_active_idx(sp, idx))
>   		schedule_timeout_interruptible(1);
> 
> may spin unpredictably long, because we use the same sp->hardluckref for
> accounting.

Excellent point -- hardluckref also needs to be a two-element array.

						Thanx, Paul
