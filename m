Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967259AbWKYWGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967259AbWKYWGH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 17:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967264AbWKYWGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 17:06:07 -0500
Received: from firewall.rowland.harvard.edu ([140.247.233.35]:1657 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S967259AbWKYWGE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 17:06:04 -0500
Date: Sat, 25 Nov 2006 17:06:02 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Jens Axboe <jens.axboe@oracle.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061125171438.GA159@oleg>
Message-ID: <Pine.LNX.4.44L0.0611251648380.28957-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2006, Oleg Nesterov wrote:

> > void xxx_read_unlock(struct xxx_struct *sp, int idx)
> > {
> > 	spin_lock(&sp->lock);
> 
> It is possible that the memory ops that occur before spin_lock() is not yet
> completed,
> 
> > 	if (--sp->ctr[idx] == 0)
> 
> suppose that synchronize_xxx() just unlocked sp->lock. It sees sp->ctr[idx] == 0
> and returns.
> 
> > 		wake_up(&sp->wq);
> > 	spin_unlock(&sp->lock);
> 
> This is a one-way barrier, yes. But it is too late.

Yes, you are right.  The corrected routine (including your little 
optimization) looks like this:

void synchronize_xxx(struct xxx_struct *sp)
{
	int idx;

	mutex_lock(&sp->mutex);
	spin_lock(&sp->lock);
	idx = sp->completed & 0x1;
	if (sp->ctr[idx] == 1)
		goto done;

	++sp->completed;
	--sp->ctr[idx];
	sp->ctr[idx ^ 1] = 1;

	spin_unlock(&sp->lock);
	__wait_event(sp->wq, sp->ctr[idx] == 0);
	spin_lock(&sp->lock);

done:
	spin_unlock(&sp->lock);
	mutex_unlock(&sp->mutex);
}

> Actually, synchronize_xxx() may sleep on sp->wq and we still have a race.
> synchronize_xxx() can return before ->wake_up() unlocks sp->wq.lock (finish_wait()
> doesn't take sp->wq.lock due to autoremove_wake_function()).

The version above doesn't suffer from that race.

> This is more or less equivalent to
> 
> 	void synchronize_xxx(struct xxx_struct *sp)
> 	{
> 		int idx;
> 
> 		mutex_lock(&sp->mutex);
> 
> 		idx = sp->completed & 0x1;
> 		atomic_dec(sp->ctr + idx);
> 		smp_mb__before_atomic_inc();
> 		atomic_inc(sp->ctr + (idx ^ 0x1));
> 		sp->completed++;
> 
> 		wait_event(sp->wq, !atomic_read(sp->ctr + idx));
> 		mutex_unlock(&sp->mutex);
> 	}

It may indeed be equivalent.  But _proving_ it is equivalent is certainly 
not easy.  The advantage of spinlocks is that they remove the necessity 
for outrageous mental contortions to verify that all possible execution 
paths will work correctly.

> Honestly, I don't see why it is better, but may be this is just me.
> In any case, spinlock based implementation shouldn't be faster, yes?

It will generally be somewhat slower.  In addition to cache-line
contention it suffers from lock contention.  The difference shouldn't be
enough to matter unless a lot of threads are trying to acquire a read lock
simultaneously.

Alan Stern

