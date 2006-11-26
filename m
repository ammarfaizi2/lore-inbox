Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935581AbWKZWZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935581AbWKZWZt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 17:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935588AbWKZWZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 17:25:49 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:45479 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S935581AbWKZWZs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 17:25:48 -0500
Date: Mon, 27 Nov 2006 01:25:47 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061126222547.GB110@oleg>
References: <20061119214315.GI4427@us.ibm.com> <Pine.LNX.4.44L0.0611201212040.3224-100000@iolanthe.rowland.org> <20061120185712.GA95@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120185712.GA95@oleg>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20, Oleg Nesterov wrote:
>
> So, if we have global A == B == 0,
>
> 	CPU_0		CPU_1
>
> 	A = 1;		B = 2;
> 	mb();		mb();
> 	b = B;		a = A;
>
> It could happen that a == b == 0, yes? Isn't this contradicts with definition
> of mb?

I still can't relax, another attempt to "prove" this should not be
possible on CPUs supported by Linux :)

Let's suppose it is possible, then it should also be possible if CPU_1
does spin_lock() instead of mb() (spin_lock can't be "stronger"), yes?

Now,

	int COND;
	wait_queue_head_t wq;

	my_wait()
	{
		add_wait_queue(&wq);
		for (;;) {
			set_current_state(TASK_UNINTERRUPTIBLE);

			if (COND)
				break;

			schedule();
		}
		remove_wait_queue(&wq);
	}

	my_wake()
	{
		COND = 1;
		wake_up(&wq);
	}

this should be correct, but it is not!

my_wait:

	task->state = TASK_UNINTERRUPTIBLE;		// STORE

	mb();

	if (COND) break;				// LOAD


my_wake:

	COND = 1;					// STORE

	spin_lock(WQ.lock);
	spin_lock(runqueue.lock);

	// try_to_wake_up()
	if (!(task->state & TASK_UNINTERRUPTIBLE))	// LOAD
		goto out;


So, my_wait() gets COND == 0, and goes to schedule in 'D' state.
try_to_wake_up() reads ->state == TASK_RUNNING, and does nothing.

Oleg.

