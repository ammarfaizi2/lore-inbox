Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756397AbWKRTeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756397AbWKRTeg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 14:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756400AbWKRTeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 14:34:36 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:57755 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1756397AbWKRTef
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 14:34:35 -0500
Date: Sat, 18 Nov 2006 22:34:26 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061118193426.GC163@oleg>
References: <20061118002845.GF2632@us.ibm.com> <Pine.LNX.4.44L0.0611181054470.28058-100000@netrider.rowland.org> <20061118171410.GB4427@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061118171410.GB4427@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18, Paul E. McKenney wrote:
>
> On Sat, Nov 18, 2006 at 11:15:27AM -0500, Alan Stern wrote:
> > > +			    smp_processor_id())->c[idx]++;
> > > +		smp_mb();
> > > +		preempt_enable();
> > > +		return idx;
> > > +	}
> > > +	if (mutex_trylock(&sp->mutex)) {
> > > +		preempt_enable();
> > 
> > Move the preempt_enable() before the "if", then get rid of the
> > preempt_enable() after the "if" block.
> 
> No can do.  The preempt_enable() must follow the increment and
> the memory barrier, otherwise the synchronize_sched() inside
> synchronize_srcu() can't do its job.

Given that srcu_read_lock() does smp_mb() after ->c[idx]++, what
is the purpose of synchronize_srcu() ? It seems to me it could be
replaced by smp_mb().

synchronize_srcu:

	sp->completed++;

	mb();

	// if the reader did any memory access _after_
	// srcu_read_lock()->mb() we must see the changes.
	while (srcu_readers_active_idx(sp, idx))
		sleep();

No?

Oleg.

