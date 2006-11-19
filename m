Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933356AbWKSV3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933356AbWKSV3y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 16:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933352AbWKSV3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 16:29:54 -0500
Received: from pool-71-111-72-250.ptldor.dsl-w.verizon.net ([71.111.72.250]:30531
	"EHLO IBM-8EC8B5596CA.beaverton.ibm.com") by vger.kernel.org
	with ESMTP id S933355AbWKSV3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 16:29:52 -0500
Date: Sun, 19 Nov 2006 13:26:19 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061119212619.GH4427@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20061118002845.GF2632@us.ibm.com> <Pine.LNX.4.44L0.0611181054470.28058-100000@netrider.rowland.org> <20061118171410.GB4427@us.ibm.com> <20061118193426.GC163@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061118193426.GC163@oleg>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2006 at 10:34:26PM +0300, Oleg Nesterov wrote:
> On 11/18, Paul E. McKenney wrote:
> >
> > On Sat, Nov 18, 2006 at 11:15:27AM -0500, Alan Stern wrote:
> > > > +			    smp_processor_id())->c[idx]++;
> > > > +		smp_mb();
> > > > +		preempt_enable();
> > > > +		return idx;
> > > > +	}
> > > > +	if (mutex_trylock(&sp->mutex)) {
> > > > +		preempt_enable();
> > >
> > > Move the preempt_enable() before the "if", then get rid of the
> > > preempt_enable() after the "if" block.
> >
> > No can do.  The preempt_enable() must follow the increment and
> > the memory barrier, otherwise the synchronize_sched() inside
> > synchronize_srcu() can't do its job.
> 
> Given that srcu_read_lock() does smp_mb() after ->c[idx]++, what
> is the purpose of synchronize_srcu() ? It seems to me it could be
> replaced by smp_mb().
> 
> synchronize_srcu:
> 
> 	sp->completed++;
> 
> 	mb();
> 
> 	// if the reader did any memory access _after_
> 	// srcu_read_lock()->mb() we must see the changes.
> 	while (srcu_readers_active_idx(sp, idx))
> 		sleep();
> 
> No?

I believe that this could run afoul of the example I sent out earlier
(based on Alan's example).  In my mind, the key difference between
this and Jens's suggestion is that in Jens's case, we check for -all-
the counters being zero, not just the old ones.  (But I still don't
trust Jen's optimization -- I just have not yet come up with an example
showing breakage, possibly because there isn't one, but...)

						Thanx, Paul
