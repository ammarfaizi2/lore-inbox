Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318971AbSHMRV6>; Tue, 13 Aug 2002 13:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318970AbSHMRV6>; Tue, 13 Aug 2002 13:21:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36358 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318971AbSHMRVz>;
	Tue, 13 Aug 2002 13:21:55 -0400
Message-ID: <3D59436F.3DFAFA36@zip.com.au>
Date: Tue, 13 Aug 2002 10:35:43 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] kwaitd, 2.5.31-A1
References: <Pine.LNX.4.44.0208131755090.31234-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> ...
> the reaping of the thread is thus not done by the parent (or init), but by
> per-CPU [kwaitd] kernel threads. The exiting thread queues itself always
> to the CPU-local kwaitd queue, to maintain locality of reference and cheap
> switching to kwaitd.

I'd be inclined to agree with hch on that.  We have an awful lot of
kernel threads nowadays, and keventd would fill the bill.

Andrea's kernels have keventd running SCHED_RR, and that's appropriate
to this application also.   Not sure about AIO though.

> [ this new reaping method could also be used when reparenting to init -
> but i'm unsure whether this would really work as expected - do some init
> variants rely perhaps on getting all orphan tasks in the system? ]

That should be OK.  init never knew about the reparented ones anyway.

> ...
> +
> +static kwait_t kwait_threads[NR_CPUS] __cacheline_aligned;
> +

We need to start using Rusty's percpu stuff sometime.

> +void reap_thread(task_t *p)
> +{
> +       kwait_t *kwait = kwait_threads + smp_processor_id();
> +

get_cpu() here?

> +
> +       if (p->parent == kwait->task) {
> +               printk("hm, %s(%d) reaped already.\n", p->comm, p->pid);
> +               return;
> +       }
> +       REMOVE_LINKS(p);

This is called under read_lock(&tasklist_lock), but modifies the
task list.

> ...
> +
> +                       schedule();
> +                       current->state = TASK_RUNNING;

schedule() always returns in state TASK_RUNNING?  (Or at least, it
used to.  Tell me if that changed, quick ;))

And a question: is it not possible to make the exitting task just go
and reap itself?  If it's a matter of freeing the stack pages we could
just add the page to a per-cpu deferred freeing list and reap it in
page reclaim.
