Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756883AbWK0FH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883AbWK0FH2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 00:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756985AbWK0FH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 00:07:28 -0500
Received: from pool-71-111-72-250.ptldor.dsl-w.verizon.net ([71.111.72.250]:43610
	"EHLO IBM-8EC8B5596CA.beaverton.ibm.com") by vger.kernel.org
	with ESMTP id S1756951AbWK0FGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 00:06:55 -0500
Date: Sun, 26 Nov 2006 21:02:48 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jens Axboe <jens.axboe@oracle.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061127050247.GC5021@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <Pine.LNX.4.64.0611161414580.3349@woody.osdl.org> <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org> <20061117065128.GA5452@us.ibm.com> <20061117092925.GT7164@kernel.dk> <20061119190027.GA3676@oleg> <20061123145910.GA145@oleg> <20061124182153.GA9868@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061124182153.GA9868@oleg>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2006 at 09:21:53PM +0300, Oleg Nesterov wrote:
> Ok, synchronize_xxx() passed 1 hour rcutorture test on dual P-III.
> 
> It behaves the same as srcu but optimized for writers. The fast path
> for synchronize_xxx() is mutex_lock() + atomic_read() + mutex_unlock().
> The slow path is __wait_event(), no polling. However, the reader does
> atomic inc/dec on lock/unlock, and the counters are not per-cpu.
> 
> Jens, is it ok for you? Alan, Paul, what is your opinion?

Looks pretty good, actually.  A few quibbles below.  I need to review
again after sleeping on it.

						Thanx, Paul

> Oleg.
> 
> --- 19-rc6/kernel/__rcutorture.c	2006-11-17 19:42:31.000000000 +0300
> +++ 19-rc6/kernel/rcutorture.c	2006-11-24 21:00:00.000000000 +0300
> @@ -464,6 +464,120 @@ static struct rcu_torture_ops srcu_ops =
>  	.name = "srcu"
>  };
> 
> +//-----------------------------------------------------------------------------
> +struct xxx_struct {
> +	int completed;
> +	atomic_t ctr[2];
> +	struct mutex mutex;
> +	wait_queue_head_t wq;
> +};
> +
> +void init_xxx_struct(struct xxx_struct *sp)
> +{
> +	sp->completed = 0;
> +	atomic_set(sp->ctr + 0, 1);
> +	atomic_set(sp->ctr + 1, 0);
> +	mutex_init(&sp->mutex);
> +	init_waitqueue_head(&sp->wq);
> +}
> +
> +int xxx_read_lock(struct xxx_struct *sp)
> +{
> +	for (;;) {
> +		int idx = sp->completed & 0x1;

Might need a comment saying why no rcu_dereference() needed on the
preceding line.  The reason (as I understand it) is that we are
only doing atomic operations on the element being indexed.  Is there
an Alpha architect in the house?  ;-)

> +		if (likely(atomic_inc_not_zero(sp->ctr + idx)))
> +			return idx;
> +	}
> +}

The loop seems absolutely necessary if one wishes to avoid a
synchronize_sched() in synchronize_xxx() below (and was one of the things
I was missing earlier).  However, isn't there a possibility that a pile
of synchronize_xxx() calls might indefinitely delay an unlucky reader?

> +
> +void xxx_read_unlock(struct xxx_struct *sp, int idx)
> +{
> +	if (unlikely(atomic_dec_and_test(sp->ctr + idx)))
> +		wake_up(&sp->wq);
> +}
> +
> +void synchronize_xxx(struct xxx_struct *sp)
> +{
> +	int idx;
> +
> +	mutex_lock(&sp->mutex);
> +
> +	idx = sp->completed & 0x1;
> +	if (!atomic_add_unless(sp->ctr + idx, -1, 1))
> +		goto out;
> +
> +	atomic_inc(sp->ctr + (idx ^ 0x1));
> +	sp->completed++;
> +
> +	__wait_event(sp->wq, !atomic_read(sp->ctr + idx));
> +out:
> +	mutex_unlock(&sp->mutex);
> +}

Test code!!!  Very good!!!  (This is added to rcutorture, right?)

> +//-----------------------------------------------------------------------------
> +static struct xxx_struct xxx_ctl;
> +
> +static void xxx_torture_init(void)
> +{
> +	init_xxx_struct(&xxx_ctl);
> +	rcu_sync_torture_init();
> +}
> +
> +static void xxx_torture_cleanup(void)
> +{
> +	synchronize_xxx(&xxx_ctl);
> +}
> +
> +static int xxx_torture_read_lock(void)
> +{
> +	return xxx_read_lock(&xxx_ctl);
> +}
> +
> +static void xxx_torture_read_unlock(int idx)
> +{
> +	xxx_read_unlock(&xxx_ctl, idx);
> +}
> +
> +static int xxx_torture_completed(void)
> +{
> +	return xxx_ctl.completed;
> +}
> +
> +static void xxx_torture_synchronize(void)
> +{
> +	synchronize_xxx(&xxx_ctl);
> +}
> +
> +static int xxx_torture_stats(char *page)
> +{
> +	int cnt = 0;
> +	int idx = xxx_ctl.completed & 0x1;
> +
> +	cnt += sprintf(&page[cnt], "%s%s per-CPU(idx=%d):",
> +			torture_type, TORTURE_FLAG, idx);
> +
> +	cnt += sprintf(&page[cnt], " (%d,%d)",
> +			atomic_read(xxx_ctl.ctr + 0),
> +			atomic_read(xxx_ctl.ctr + 1));
> +
> +	cnt += sprintf(&page[cnt], "\n");
> +	return cnt;
> +}
> +
> +static struct rcu_torture_ops xxx_ops = {
> +	.init = xxx_torture_init,
> +	.cleanup = xxx_torture_cleanup,
> +	.readlock = xxx_torture_read_lock,
> +	.readdelay = srcu_read_delay,
> +	.readunlock = xxx_torture_read_unlock,
> +	.completed = xxx_torture_completed,
> +	.deferredfree = rcu_sync_torture_deferred_free,
> +	.sync = xxx_torture_synchronize,
> +	.stats = xxx_torture_stats,
> +	.name = "xxx"
> +};
> +//-----------------------------------------------------------------------------
> +
>  /*
>   * Definitions for sched torture testing.
>   */
> @@ -503,8 +617,8 @@ static struct rcu_torture_ops sched_ops
>  };
> 
>  static struct rcu_torture_ops *torture_ops[] =
> -	{ &rcu_ops, &rcu_sync_ops, &rcu_bh_ops, &rcu_bh_sync_ops, &srcu_ops,
> -	  &sched_ops, NULL };
> +	{ &rcu_ops, &rcu_sync_ops, &rcu_bh_ops, &rcu_bh_sync_ops,
> +	  &srcu_ops, &xxx_ops, &sched_ops, NULL };
> 
>  /*
>   * RCU torture writer kthread.  Repeatedly substitutes a new structure
> 
