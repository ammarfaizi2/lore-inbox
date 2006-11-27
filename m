Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758578AbWK0VKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758578AbWK0VKf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 16:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758579AbWK0VKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 16:10:34 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:4581 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1758578AbWK0VKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 16:10:34 -0500
Date: Mon, 27 Nov 2006 16:10:27 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061126222547.GB110@oleg>
Message-ID: <Pine.LNX.4.44L0.0611271608470.2786-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006, Oleg Nesterov wrote:

> I still can't relax, another attempt to "prove" this should not be
> possible on CPUs supported by Linux :)
> 
> Let's suppose it is possible, then it should also be possible if CPU_1
> does spin_lock() instead of mb() (spin_lock can't be "stronger"), yes?
> 
> Now,
> 
> 	int COND;
> 	wait_queue_head_t wq;
> 
> 	my_wait()
> 	{
> 		add_wait_queue(&wq);
> 		for (;;) {
> 			set_current_state(TASK_UNINTERRUPTIBLE);
> 
> 			if (COND)
> 				break;
> 
> 			schedule();
> 		}
> 		remove_wait_queue(&wq);
> 	}
> 
> 	my_wake()
> 	{
> 		COND = 1;
> 		wake_up(&wq);
> 	}
> 
> this should be correct, but it is not!
> 
> my_wait:
> 
> 	task->state = TASK_UNINTERRUPTIBLE;		// STORE
> 
> 	mb();
> 
> 	if (COND) break;				// LOAD
> 
> 
> my_wake:
> 
> 	COND = 1;					// STORE
> 
> 	spin_lock(WQ.lock);
> 	spin_lock(runqueue.lock);
> 
> 	// try_to_wake_up()
> 	if (!(task->state & TASK_UNINTERRUPTIBLE))	// LOAD
> 		goto out;
> 
> 
> So, my_wait() gets COND == 0, and goes to schedule in 'D' state.
> try_to_wake_up() reads ->state == TASK_RUNNING, and does nothing.

This is a very good point.  I don't know what the resolution is; Paul will 
have to explain the situation.

Alan

