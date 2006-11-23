Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755701AbWKWO7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755701AbWKWO7O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 09:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757381AbWKWO7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 09:59:14 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:64715 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1755701AbWKWO7O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 09:59:14 -0500
Date: Thu, 23 Nov 2006 17:59:10 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061123145910.GA145@oleg>
References: <Pine.LNX.4.64.0611161414580.3349@woody.osdl.org> <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org> <20061117065128.GA5452@us.ibm.com> <20061117092925.GT7164@kernel.dk> <20061119190027.GA3676@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061119190027.GA3676@oleg>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry, responding to the wrong message)

Paul E. McKenney wrote:
>
> I am concerned about this as well, and am beginning to suspect that I
> need to make a special-purpose primitive specifically for Jens that he
> can include with his code.

How about this?

	struct xxx_struct {
		int completed;
		atomic_t ctr[2];
		struct mutex mutex;
		wait_queue_head_t wq;
	};

	void init_xxx_struct(struct xxx_struct *sp)
	{
		sp->completed = 0;
		atomic_set(sp->ctr + 0, 1);	// active
		atomic_set(sp->ctr + 1, 0);	// inactive
		mutex_init(&sp->mutex);
		init_waitqueue_head(&sp->wq);
	}

	int xxx_read_lock(struct xxx_struct *sp)
	{
		for (;;) {
			int idx = sp->completed & 0x1;
			if (likely(atomic_inc_not_zero(sp->ctr + idx)))
				return idx;
		}
	}

	void xxx_read_unlock(struct xxx_struct *sp, int idx)
	{
		if (unlikely(atomic_dec_and_test(sp->ctr + idx)))
			wake_up(&sp->wq);
	}

	void synchronize_xxx(struct xxx_struct *sp)
	{
		int idx;

		mutex_lock(&sp->mutex);

		idx = ++sp->completed & 0x1;
		smp_mb__before_atomic_inc();
		atomic_inc(&sp->ctr + idx);

		idx = !idx;
		if (!atomic_dec_and_test(&sp->ctr + idx))
			__wait_event(&sp->wq, !atomic_read(&sp->ctr + idx));

		mutex_unlock(&sp->mutex);
	}

Yes, cache thrashing... But I think this is hard to avoid if we want writer
to be fast.

I do not claim this is the best solution, but for some reason I'd like to
suggest something that doesn't need synchronize_sched(). What do you think
about correctness at least?

Oleg.

