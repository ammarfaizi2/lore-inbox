Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTFJLba (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 07:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbTFJLba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 07:31:30 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:24552 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S262033AbTFJLb2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 07:31:28 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: scheduler interactivity - does this patch help?
Date: Tue, 10 Jun 2003 21:39:02 +1000
User-Agent: KMail/1.5.2
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
References: <1055186553.707.1.camel@teapot.felipe-alfaro.com> <5.2.0.9.2.20030610133204.01fd2cd0@pop.gmx.net>
In-Reply-To: <5.2.0.9.2.20030610133204.01fd2cd0@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306102139.02678.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jun 2003 21:37, Mike Galbraith wrote:
> At 07:39 PM 6/10/2003 +1000, Con Kolivas wrote:
> >On Tue, 10 Jun 2003 05:22, Felipe Alfaro Solana wrote:
> > > On Mon, 2003-06-09 at 07:43, Martin J. Bligh wrote:
> > > > I've had this patch (I think from Ingo) kicking around in -mjb
> > > > for a while. I'm going to drop it unless someone thinks it's useful
> > > > for some testcase you have ... anyone interested?
> > > >
> > > > Thanks,
> > > >
> > > > M.
> > > >
> > > > diff -urpN -X /home/fletch/.diff.exclude
> > > > 400-reiserfs_dio/kernel/sched.c 420-sched_interactive/kernel/sched.c
> > > > ---
> > > > 400-reiserfs_dio/kernel/sched.c     Fri May 30 19:26:34 2003
> > > > +++ 420-sched_interactive/kernel/sched.c    Fri May 30 19:28:06 2003
> > > > @@ -89,6 +89,8 @@ int node_threshold = 125;
> > > >  #define STARVATION_LIMIT   (starvation_limit)
> > > >  #define NODE_THRESHOLD             (node_threshold)
> > > >
> > > > +#define TIMESLICE_GRANULARITY (HZ/20 ?: 1)
> > > > +
> > > >  /*
> > > >   * If a task is 'interactive' then we reinsert it in the active
> > > >   * array after it has expired its current timeslice. (it will not
> > > > @@ -1365,6 +1367,27 @@ void scheduler_tick(int user_ticks, int
> > > >                     enqueue_task(p, rq->expired);
> > > >             } else
> > > >                     enqueue_task(p, rq->active);
> > > > +   } else {
> > > > +           /*
> > > > +           * Prevent a too long timeslice allowing a task to
> > > > monopolize +           * the CPU. We do this by splitting up the
> > > > timeslice into +           * smaller pieces.
> > > > +           *
> > > > +           * Note: this does not mean the task's timeslices expire
> > > > or +           * get lost in any way, they just might be preempted by
> > > > +           * another task of equal priority. (one with higher +     
> > > >      * priority would have preempted this task already.) We +        
> > > >   * requeue this task to the end of the list on this priority +      
> > > >     * level, which is in essence a round-robin of tasks with +       
> > > >    * equal priority.
> > > > +           */
> > > > +           if (!(p->time_slice % TIMESLICE_GRANULARITY) &&
> > > > +                                   (p->array == rq->active)) {
> > > > +                   dequeue_task(p, rq->active);
> > > > +                   set_tsk_need_resched(p);
> > > > +                   p->prio = effective_prio(p);
> > > > +                   enqueue_task(p, rq->active);
> > > > +           }
> > > >     }
> > > >  out_unlock:
> > > >     spin_unlock(&rq->lock);
> > >
> > > I'm currently testing it on a modified 2.5.70-mm6 kernel (with HZ set
> > > to 1000) and seems to help a little with XMMS's chunky audio playback
> > > when X is reniced to -20.
> >
> >I tried this patch way back when mingo first posted it and found it helped
> > a little. Have a close look at it, though; all it does is limit max
> > timeslice to 50ms when other tasks are running at the same priority. A
> > better effect can and is obtained by changing max_timeslice to 50ms...
>
> It also drops priority somewhat sooner.  If you reduce max to 50ms, normal
> task timeslice becomes tiny, which won't do anything good for throughput.

I wasn't advocating this as a fix, just making an observation. I do think the 
effect on throughput is overrated though. A few benchmarks I did on cpu 
intensive cache heavy tasks shows only very slight but measurable 
improvements as timeslices get beyond 7ms on a P4 2.53. Below this however 
throughput very rapidly drops off. 

P3 733 showed comparable effects. I haven't tested lower spec machines than 
this though.

Con

