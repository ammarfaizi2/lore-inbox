Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287531AbSAJGaY>; Thu, 10 Jan 2002 01:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287532AbSAJGaP>; Thu, 10 Jan 2002 01:30:15 -0500
Received: from pool-141-157-232-117.ny325.east.verizon.net ([141.157.232.117]:18185
	"EHLO arizona.localdomain") by vger.kernel.org with ESMTP
	id <S287531AbSAJGaD>; Thu, 10 Jan 2002 01:30:03 -0500
Date: Thu, 10 Jan 2002 01:29:57 -0500
From: kevin@koconnor.net
To: Robert Love <rml@tech9.net>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: lock order in O(1) scheduler
Message-ID: <20020110012957.B13456@arizona.localdomain>
In-Reply-To: <20020110001002.A13456@arizona.localdomain> <1010640369.5335.289.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1010640369.5335.289.camel@phantasy>; from rml@tech9.net on Thu, Jan 10, 2002 at 12:26:08AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 12:26:08AM -0500, Robert Love wrote:
> On Thu, 2002-01-10 at 00:10, kevin@koconnor.net wrote:
> 
> > I was unable to figure out what the logic of the '(smp_processor_id() <
> > p->cpu)' test is..  (Why should the CPU number of the process being awoken
> > matter?)  My best guess is that this is to enforce a locking invariant -
> > but if so, isn't this test backwards?  If p->cpu > current->cpu then
> > p->cpu's runqueue is locked first followed by this_rq - locking greatest to
> > least, where the rest of the code does least to greatest..
> 
> Not so sure of the validity, but it is to respect lock order.
[...]

Right.  It is a confusing though - depending on the value of p->cpu
relative to current->cpu, the synchronous flag may be ignored.  Since the
relationship between p->cpu and current->cpu is essentially random, this
makes the behavior of the synchronous flag random - why bother?

I can see that re-grabbing the locks in the proper order would be a pain.
Also, after a quick grep, it appears only fs/pipe.c is interested in the
wake_up_sync() variant.  Maybe this feature should just be culled?

-Kevin


The try_to_wake_up function in pre11 (just for reference):


static int try_to_wake_up(task_t * p, int synchronous)
{
        unsigned long flags;
        int success = 0;
        runqueue_t *rq;

        lock_task_rq(rq, p, flags);
        p->state = TASK_RUNNING;
        if (!p->array) {
                if (!rt_task(p) && synchronous && (smp_processor_id() < p->cpu)) {
                        spin_lock(&this_rq()->lock);
                        p->cpu = smp_processor_id();
                        activate_task(p, this_rq());
                        spin_unlock(&this_rq()->lock);
                } else {
                        activate_task(p, rq);
                        if ((rq->curr == rq->idle) ||
                                        (p->prio < rq->curr->prio))
                                resched_task(rq->curr);
                }
                success = 1;
        }
        unlock_task_rq(rq, p, flags);
        return success;
}

-- 
 ------------------------------------------------------------------------
 | Kevin O'Connor                     "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net                  'IMHO', 'FAQ', 'BTW', etc. !"    |
 ------------------------------------------------------------------------
