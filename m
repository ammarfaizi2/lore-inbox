Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132042AbRDAHxv>; Sun, 1 Apr 2001 03:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132044AbRDAHxc>; Sun, 1 Apr 2001 03:53:32 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:60798 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S132042AbRDAHxV>; Sun, 1 Apr 2001 03:53:21 -0400
Message-ID: <3AC6DD34.5B030E96@mvista.com>
Date: Sat, 31 Mar 2001 23:48:04 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: nigel@nrg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <m14j5FD-001PKFC@mozart>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> In message <Pine.LNX.4.05.10103291555390.8122-100000@cosmic.nrg.org> you write:
> > Here is an attempt at a possible version of synchronize_kernel() that
> > should work on a preemptible kernel.  I haven't tested it yet.
> 
> It's close, but...
> 
> Those who suggest that we don't do preemtion on SMP make this much
> easier (synchronize_kernel() is a NOP on UP), and I'm starting to
> agree with them.  Anyway:
> 
> >               if (p->state == TASK_RUNNING ||
> >                               (p->state == (TASK_RUNNING|TASK_PREEMPTED))) {
> >                       p->flags |= PF_SYNCING;
> 
> Setting a running task's flags brings races, AFAICT, and checking
> p->state is NOT sufficient, consider wait_event(): you need p->has_cpu
> here I think.  You could do it for TASK_PREEMPTED only, but you'd have
> to do the "unreal priority" part of synchronize_kernel() with some
> method to say "don't preempt anyone", but it will hurt latency.
> Hmmm...
> 
> The only way I can see is to have a new element in "struct
> task_struct" saying "syncing now", which is protected by the runqueue
> lock.  This looks like (and I prefer wait queues, they have such nice
> helpers):
> 
>         static DECLARE_WAIT_QUEUE_HEAD(syncing_task);
>         static DECLARE_MUTEX(synchronize_kernel_mtx);
>         static int sync_count = 0;
> 
> schedule():
>         if (!(prev->state & TASK_PREEMPTED) && prev->syncing)
>                 if (--sync_count == 0) wake_up(&syncing_task);
> 
> synchronize_kernel():
> {
>         struct list_head *tmp;
>         struct task_struct *p;
> 
>         /* Guard against multiple calls to this function */
>         down(&synchronize_kernel_mtx);
> 
>         /* Everyone running now or currently preempted must
>            voluntarily schedule before we know we are safe. */
>         spin_lock_irq(&runqueue_lock);
>         list_for_each(tmp, &runqueue_head) {
>                 p = list_entry(tmp, struct task_struct, run_list);
>                 if (p->has_cpu || p->state == (TASK_RUNNING|TASK_PREEMPTED)) {
I think this should be:
	          if (p->has_cpu || p->state & TASK_PREEMPTED)) {
to catch tasks that were preempted with other states.  The lse Multi
Queue scheduler folks are going to love this.

George

>                         p->syncing = 1;
>                         sync_count++;
>                 }
>         }
>         spin_unlock_irq(&runqueue_lock);
> 
>         /* Wait for them all */
>         wait_event(syncing_task, sync_count == 0);
>         up(&synchronize_kernel_mtx);
> }
> 
> Also untested 8),
> Rusty.
> --
> Premature optmztion is rt of all evl. --DK
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
