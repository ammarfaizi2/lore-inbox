Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWAIT7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWAIT7S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWAIT7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:59:18 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:29862 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751264AbWAIT7Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:59:16 -0500
Date: Mon, 9 Jan 2006 11:59:33 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       vatsa@in.ibm.com
Subject: Re: [PATCH 2/5] rcu: don't check ->donelist in __rcu_pending()
Message-ID: <20060109195933.GE14738@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43C165BC.F7C6DCF5@tv-sign.ru> <20060109185944.GB15083@us.ibm.com> <43C2C818.65238C30@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C2C818.65238C30@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 11:31:20PM +0300, Oleg Nesterov wrote:
> "Paul E. McKenney" wrote:
> > 
> > On Sun, Jan 08, 2006 at 10:19:24PM +0300, Oleg Nesterov wrote:
> > > ->donelist becomes != NULL only in rcu_process_callbacks().
> > >
> > > rcu_process_callbacks() always calls rcu_do_batch() when
> > > ->donelist != NULL.
> > >
> > > rcu_do_batch() schedules rcu_process_callbacks() again if
> > > ->donelist was not flushed entirely.
> > >
> > > So ->donelist != NULL means that rcu_tasklet is either
> > > TASKLET_STATE_SCHED or TASKLET_STATE_RUN, we don't need to
> > > check it in __rcu_pending().
> > 
> > As Vatsa noted, this is needed if the CPU-hotplug case moves
> > from ->donelist to ->donelist.  It could be omitted if CPU-hotplug
> > instead moves from ->donelist to ->nextlist, as is the case in Oleg's
> > patch.  The extra grace-period delay should not be a problem for the
> > presumably rare hotplug case, but:
> 
> Just to be sure. So do you agree that CPU-hotplug is buggy now (without
> that patch) ?

Hmmm...  So your thought is that __rcu_offline_cpu() moves nxtlist and
curlist, but not donelist, but then returns to rcu_offline_cpu(), which
might well do the tasklet_kill_immediate() before the tasklet completed
processing all of donelist.

Seems plausible to me.  If true, your patch adding the following statement
to the ed of __rcu_offline_cpu seems like a reasonable fix:

	rcu_move_batch(this_rdp, rdp->donelist, rdp->donetail);

Vatsa, is there something that Oleg and I are missing?

> > o       the extra test in __rcu_pending() should be quite inexpensive,
> >         since the cacheline is already loaded given the earlier tests.
> 
> Yes, it was a cleanup, not an optimization.
> 
> > o       although tasklet_schedule() looks to be perfectly reliable
> >         right now, and although any bugs in tasklet_schedule() must
> >         be fixed, having RCU leakage be the major symptom of
> >         tasklet_schedule() failure sounds quite unfriendly to me.
> > 
> > So I am not (yet) convinced that this patch is the way to go.
> 
> Ok, I agree.

Sounds good!

							Thanx, Paul
