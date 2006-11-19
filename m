Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933278AbWKSUzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933278AbWKSUzg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933282AbWKSUzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:55:36 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:18867 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S933279AbWKSUzb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:55:31 -0500
Date: Sun, 19 Nov 2006 23:55:16 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jens Axboe <jens.axboe@oracle.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Thomas Gleixner <tglx@timesys.com>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, manfred@colorfullife.com
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061119205516.GA117@oleg>
References: <20061119190027.GA3676@oleg> <Pine.LNX.4.44L0.0611191512280.15059-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611191512280.15059-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19, Alan Stern wrote:
>
> On Sun, 19 Nov 2006, Oleg Nesterov wrote:
> 
> > 	int xxx_read_lock(struct xxx_struct *sp)
> > 	{
> > 		int idx;
> > 
> > 		idx = sp->completed & 0x1;
> > 		atomic_inc(sp->ctr + idx);
> > 		smp_mb__after_atomic_inc();
> > 
> > 		return idx;
> > 	}
> > 
> > 	void xxx_read_unlock(struct xxx_struct *sp, int idx)
> > 	{
> > 		if (atomic_dec_and_test(sp->ctr + idx))
> > 			wake_up(&sp->wq);
> > 	}
> > 
> > 	void synchronize_xxx(struct xxx_struct *sp)
> > 	{
> > 		wait_queue_t wait;
> > 		int idx;
> > 
> > 		init_wait(&wait);
> > 		mutex_lock(&sp->mutex);
> > 
> > 		idx = sp->completed++ & 0x1;
> > 
> > 		for (;;) {
> > 			prepare_to_wait(&sp->wq, &wait, TASK_UNINTERRUPTIBLE);
> > 
> > 			if (!atomic_add_unless(sp->ctr + idx, -1, 1))
> > 				break;
> > 
> > 			schedule();
> > 			atomic_inc(sp->ctr + idx);
> > 		}
> > 		finish_wait(&sp->wq, &wait);
> > 
> > 		mutex_unlock(&sp->mutex);
> > 	}
> > 
> > Very simple. Note that synchronize_xxx() is O(1), doesn't poll, and could
> > be optimized further.
> 
> What happens if synchronize_xxx manages to execute inbetween 
> xxx_read_lock's
> 
>  		idx = sp->completed & 0x1;
>  		atomic_inc(sp->ctr + idx);
> 
> statements?

Oops. I forgot about explicit mb() before sp->completed++ in synchronize_xxx().

So synchronize_xxx() should do

	smp_mb();
	idx = sp->completed++ & 0x1;

	for (;;) { ... }

>               You see, there's no way around using synchronize_sched().

With this change I think we are safe.

If synchronize_xxx() increments ->completed in between, the caller of
xxx_read_lock() will see all memory ops (started before synchronize_xxx())
completed. It is ok that synchronize_xxx() returns immediately.

Thanks!

Oleg.

