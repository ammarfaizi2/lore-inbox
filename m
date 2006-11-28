Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933892AbWK1Bqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933892AbWK1Bqj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 20:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933956AbWK1Bqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 20:46:39 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:46551 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S933892AbWK1Bqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 20:46:38 -0500
Date: Mon, 27 Nov 2006 17:47:59 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oleg Nesterov <oleg@tv-sign.ru>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061128014758.GD3313@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20061126222547.GB110@oleg> <Pine.LNX.4.44L0.0611271608470.2786-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611271608470.2786-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 04:10:27PM -0500, Alan Stern wrote:
> On Mon, 27 Nov 2006, Oleg Nesterov wrote:
> 
> > I still can't relax, another attempt to "prove" this should not be
> > possible on CPUs supported by Linux :)
> >
> > Let's suppose it is possible, then it should also be possible if CPU_1
> > does spin_lock() instead of mb() (spin_lock can't be "stronger"), yes?
> >
> > Now,
> >
> > 	int COND;
> > 	wait_queue_head_t wq;
> >
> > 	my_wait()
> > 	{
> > 		add_wait_queue(&wq);
> > 		for (;;) {
> > 			set_current_state(TASK_UNINTERRUPTIBLE);
> >
> > 			if (COND)
> > 				break;
> >
> > 			schedule();
> > 		}
> > 		remove_wait_queue(&wq);
> > 	}
> >
> > 	my_wake()
> > 	{
> > 		COND = 1;
> > 		wake_up(&wq);
> > 	}
> >
> > this should be correct, but it is not!
> >
> > my_wait:
> >
> > 	task->state = TASK_UNINTERRUPTIBLE;		// STORE
> >
> > 	mb();
> >
> > 	if (COND) break;				// LOAD
> >
> >
> > my_wake:
> >
> > 	COND = 1;					// STORE
> >
> > 	spin_lock(WQ.lock);
> > 	spin_lock(runqueue.lock);
> >
> > 	// try_to_wake_up()
> > 	if (!(task->state & TASK_UNINTERRUPTIBLE))	// LOAD
> > 		goto out;
> >
> >
> > So, my_wait() gets COND == 0, and goes to schedule in 'D' state.
> > try_to_wake_up() reads ->state == TASK_RUNNING, and does nothing.
> 
> This is a very good point.  I don't know what the resolution is; Paul will
> have to explain the situation.

I am revisiting this, and will let you know what I learn.

							Thanx, Paul
