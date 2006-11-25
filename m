Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755447AbWKYDYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755447AbWKYDYf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 22:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756824AbWKYDYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 22:24:35 -0500
Received: from firewall.rowland.harvard.edu ([140.247.233.35]:8233 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP
	id S1755447AbWKYDYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 22:24:34 -0500
Date: Fri, 24 Nov 2006 22:24:33 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Jens Axboe <jens.axboe@oracle.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061124211300.GA102@oleg>
Message-ID: <Pine.LNX.4.44L0.0611242219420.11686-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2006, Oleg Nesterov wrote:

> > Given that you aren't using per-cpu data, why not just rely on a spinlock?
> 
> I thought about this too, and we can re-use sp->wq.lock,

Yes, although it would be a layering violation.

> > Then everything will be simple and easy to verify,
> 
> xxx_read_lock() will be simpler, but not too much. synchronize_xxx() needs
> some complication.

Look at the (untested) example below.  The code may be a little bit 
longer, but it's a lot easier to understand and verify.

> spin_lock() + spin_unlock() doesn't imply mb(), it allows subsequent loads
> to move into the the critical region.

No, that's wrong.  Subsequent loads are allowed to move into the region 
protected by the spinlock, but not past it (into the xxx critical 
section).

> I personally prefer this way, but may be you are right.

See what you think...

Alan

//-----------------------------------------------------------------------------
struct xxx_struct {
	int completed;
	int ctr[2];
	struct mutex mutex;
	spinlock_t lock;
	wait_queue_head_t wq;
};

void init_xxx_struct(struct xxx_struct *sp)
{
	sp->completed = 0;
	sp->ctr[0] = 1;
	sp->ctr[1] = 0;
	spin_lock_init(&sp->lock);
	mutex_init(&sp->mutex);
	init_waitqueue_head(&sp->wq);
}

int xxx_read_lock(struct xxx_struct *sp)
{
	int idx;

	spin_lock(&sp->lock);
	idx = sp->completed & 0x1;
	++sp->ctr[idx];
	spin_unlock(&sp->lock);
	return idx;
}

void xxx_read_unlock(struct xxx_struct *sp, int idx)
{
	spin_lock(&sp->lock);
	if (--sp->ctr[idx] == 0)
		wake_up(&sp->wq);
	spin_unlock(&sp->lock);
}

void synchronize_xxx(struct xxx_struct *sp)
{
	int idx;

	mutex_lock(&sp->mutex);

	spin_lock(&sp->lock);
	idx = sp->completed & 0x1;
	++sp->completed;
	--sp->ctr[idx];
	sp->ctr[idx ^ 1] = 1;
	spin_unlock(&sp->lock);

	wait_event(sp->wq, sp->ctr[idx] == 0);
	mutex_unlock(&sp->mutex);
}

