Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933144AbWKSUVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933144AbWKSUVm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933155AbWKSUVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:21:42 -0500
Received: from firewall.rowland.harvard.edu ([140.247.233.35]:10968 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S933144AbWKSUVk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:21:40 -0500
Date: Sun, 19 Nov 2006 15:21:40 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Jens Axboe <jens.axboe@oracle.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Thomas Gleixner <tglx@timesys.com>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, <manfred@colorfullife.com>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061119190027.GA3676@oleg>
Message-ID: <Pine.LNX.4.44L0.0611191512280.15059-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2006, Oleg Nesterov wrote:

> On 11/17, Jens Axboe wrote:
> >
> > It works for me, but the overhead is still large. Before it would take
> > 8-12 jiffies for a synchronize_srcu() to complete without there actually
> > being any reader locks active, now it takes 2-3 jiffies. So it's
> > definitely faster, and as suspected the loss of two of three
> > synchronize_sched() cut down the overhead to a third.
> > 
> > It's still too heavy for me, by far the most calls I do to
> > synchronize_srcu() doesn't have any reader locks pending. I'm still a
> > big advocate of the fastpath srcu_readers_active() check. I can
> > understand the reluctance to make it the default, but for my case it's
> > "safe enough", so if we could either export srcu_readers_active() or
> > export a synchronize_srcu_fast() (or something like that), then SRCU
> > would be a good fit for barrier vs plug rework.
> 
> Just an idea. How about another variant of srcu which is more optimized
> for writers?
> 
> 	struct xxx_struct {
> 		int completed;
> 		atomic_t ctr[2];
> 		struct mutex mutex;
> 		wait_queue_head_t wq;
> 	};
> 
> 	void init_xxx_struct(struct xxx_struct *sp)
> 	{
> 		sp->completed = 0;
> 		atomic_set(sp->ctr + 0, 1);
> 		atomic_set(sp->ctr + 1, 1);
> 		mutex_init(&sp->mutex);
> 		init_waitqueue_head(&sp->wq);
> 	}
> 
> 	int xxx_read_lock(struct xxx_struct *sp)
> 	{
> 		int idx;
> 
> 		idx = sp->completed & 0x1;
> 		atomic_inc(sp->ctr + idx);
> 		smp_mb__after_atomic_inc();
> 
> 		return idx;
> 	}
> 
> 	void xxx_read_unlock(struct xxx_struct *sp, int idx)
> 	{
> 		if (atomic_dec_and_test(sp->ctr + idx))
> 			wake_up(&sp->wq);
> 	}
> 
> 	void synchronize_xxx(struct xxx_struct *sp)
> 	{
> 		wait_queue_t wait;
> 		int idx;
> 
> 		init_wait(&wait);
> 		mutex_lock(&sp->mutex);
> 
> 		idx = sp->completed++ & 0x1;
> 
> 		for (;;) {
> 			prepare_to_wait(&sp->wq, &wait, TASK_UNINTERRUPTIBLE);
> 
> 			if (!atomic_add_unless(sp->ctr + idx, -1, 1))
> 				break;
> 
> 			schedule();
> 			atomic_inc(sp->ctr + idx);
> 		}
> 		finish_wait(&sp->wq, &wait);
> 
> 		mutex_unlock(&sp->mutex);
> 	}
> 
> Very simple. Note that synchronize_xxx() is O(1), doesn't poll, and could
> be optimized further.

What happens if synchronize_xxx manages to execute inbetween 
xxx_read_lock's

 		idx = sp->completed & 0x1;
 		atomic_inc(sp->ctr + idx);

statements?  You see, there's no way around using synchronize_sched().

Alan Stern

