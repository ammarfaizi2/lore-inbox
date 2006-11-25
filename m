Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966739AbWKYROo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966739AbWKYROo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 12:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966747AbWKYROo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 12:14:44 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:4744 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S966739AbWKYROn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 12:14:43 -0500
Date: Sat, 25 Nov 2006 20:14:38 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Jens Axboe <jens.axboe@oracle.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061125171438.GA159@oleg>
References: <20061124211300.GA102@oleg> <Pine.LNX.4.44L0.0611242219420.11686-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611242219420.11686-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24, Alan Stern wrote:
>
> On Sat, 25 Nov 2006, Oleg Nesterov wrote:
>
> > spin_lock() + spin_unlock() doesn't imply mb(), it allows subsequent loads
> > to move into the the critical region.
>
> No, that's wrong.  Subsequent loads are allowed to move into the region
> protected by the spinlock, but not past it (into the xxx critical
> section).

Yes, you are right, but see below what I meant.

> > I personally prefer this way, but may be you are right.
>
> See what you think...
>
> Alan
>
> //-----------------------------------------------------------------------------
> struct xxx_struct {
> 	int completed;
> 	int ctr[2];
> 	struct mutex mutex;
> 	spinlock_t lock;
> 	wait_queue_head_t wq;
> };
>
> void init_xxx_struct(struct xxx_struct *sp)
> {
> 	sp->completed = 0;
> 	sp->ctr[0] = 1;
> 	sp->ctr[1] = 0;
> 	spin_lock_init(&sp->lock);
> 	mutex_init(&sp->mutex);
> 	init_waitqueue_head(&sp->wq);
> }
>
> int xxx_read_lock(struct xxx_struct *sp)
> {
> 	int idx;
>
> 	spin_lock(&sp->lock);
> 	idx = sp->completed & 0x1;
> 	++sp->ctr[idx];
> 	spin_unlock(&sp->lock);
> 	return idx;
> }
>
> void xxx_read_unlock(struct xxx_struct *sp, int idx)
> {
> 	spin_lock(&sp->lock);

It is possible that the memory ops that occur before spin_lock() is not yet
completed,

> 	if (--sp->ctr[idx] == 0)

suppose that synchronize_xxx() just unlocked sp->lock. It sees sp->ctr[idx] == 0
and returns.

> 		wake_up(&sp->wq);
> 	spin_unlock(&sp->lock);

This is a one-way barrier, yes. But it is too late.

Actually, synchronize_xxx() may sleep on sp->wq and we still have a race.
synchronize_xxx() can return before ->wake_up() unlocks sp->wq.lock (finish_wait()
doesn't take sp->wq.lock due to autoremove_wake_function()).

> }
>
> void synchronize_xxx(struct xxx_struct *sp)
> {
> 	int idx;
>
> 	mutex_lock(&sp->mutex);
>
> 	spin_lock(&sp->lock);
> 	idx = sp->completed & 0x1;
> 	++sp->completed;
> 	--sp->ctr[idx];
> 	sp->ctr[idx ^ 1] = 1;
> 	spin_unlock(&sp->lock);
>
> 	wait_event(sp->wq, sp->ctr[idx] == 0);
> 	mutex_unlock(&sp->mutex);
> }

This is more or less equivalent to

	void synchronize_xxx(struct xxx_struct *sp)
	{
		int idx;

		mutex_lock(&sp->mutex);

		idx = sp->completed & 0x1;
		atomic_dec(sp->ctr + idx);
		smp_mb__before_atomic_inc();
		atomic_inc(sp->ctr + (idx ^ 0x1));
		sp->completed++;

		wait_event(sp->wq, !atomic_read(sp->ctr + idx));
		mutex_unlock(&sp->mutex);
	}

and lacks an optimization.

	void synchronize_xxx(struct xxx_struct *sp)
	{
		int idx;

		mutex_lock(&sp->mutex);

		spin_lock(&sp->lock);

		idx = sp->completed & 0x1;
		if (sp->ctr[idx] == 1) {
			spin_unlock(&sp->lock);
			goto out;
		}

		++sp->completed;
		--sp->ctr[idx];
		sp->ctr[idx ^ 1] = 1;
		spin_unlock(&sp->lock);

		wait_event(sp->wq, sp->ctr[idx] == 0);
	out:
		mutex_unlock(&sp->mutex);
	}

Honestly, I don't see why it is better, but may be this is just me.
In any case, spinlock based implementation shouldn't be faster, yes?

Jens, Paul, what do you think?

Note also that 'atomic_add_unless' in synchronize_xxx() is not strictly
necessary, it is just for "symmetry", we can do

	void synchronize_xxx(struct xxx_struct *sp)
	{
		int idx;

		mutex_lock(&sp->mutex);

		idx = sp->completed & 0x1;
		if (!atomic_read(sp->ctr + idx)
			goto out;

		atomic_dec(sp->ctr + idx);
		atomic_inc(sp->ctr + (idx ^ 0x1));
		sp->completed++;

		wait_event(sp->wq, !atomic_read(sp->ctr + idx));
	out:
		mutex_unlock(&sp->mutex);
	}

instead. So the only complication I can see is the 'for' loop in
xxx_read_lock(). Does it worth adding sp->lock ?

Anyway, s/xxx/WHAT ???/ ?

Oleg.

