Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318994AbSHMReO>; Tue, 13 Aug 2002 13:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318995AbSHMReN>; Tue, 13 Aug 2002 13:34:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37529 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318994AbSHMReM>;
	Tue, 13 Aug 2002 13:34:12 -0400
Date: Tue, 13 Aug 2002 19:37:59 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] kwaitd, 2.5.31-A1
In-Reply-To: <3D59436F.3DFAFA36@zip.com.au>
Message-ID: <Pine.LNX.4.44.0208131928320.4369-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Andrew Morton wrote:

> > the reaping of the thread is thus not done by the parent (or init), but by
> > per-CPU [kwaitd] kernel threads. The exiting thread queues itself always
> > to the CPU-local kwaitd queue, to maintain locality of reference and cheap
> > switching to kwaitd.
> 
> I'd be inclined to agree with hch on that.  We have an awful lot of
> kernel threads nowadays, and keventd would fill the bill.

i agree. What i did was i looked at the kernel-source as-is, and there was
no mechanism to do this properly so i took a different approach. Could
anyone send me per-CPU keventd patches? The thread-exit path is pretty
timing-critical, the current global keventd spinlock does not work.

> > +void reap_thread(task_t *p)
> > +{
> > +       kwait_t *kwait = kwait_threads + smp_processor_id();
> > +
> 
> get_cpu() here?

this function is called under a spinlock currently, so there's no point in
doing that.

> > +       if (p->parent == kwait->task) {
> > +               printk("hm, %s(%d) reaped already.\n", p->comm, p->pid);
> > +               return;
> > +       }
> > +       REMOVE_LINKS(p);
> 
> This is called under read_lock(&tasklist_lock), but modifies the
> task list.

hm, i thought it was only under the write lock. Oh, i see, a rare strace
codepath does it. Fixed - thanks.

> > ...
> > +
> > +                       schedule();
> > +                       current->state = TASK_RUNNING;
> 
> schedule() always returns in state TASK_RUNNING? [...]

right - fixed :)

> And a question: is it not possible to make the exitting task just go and
> reap itself?  If it's a matter of freeing the stack pages we could just
> add the page to a per-cpu deferred freeing list and reap it in page
> reclaim.

well, yes - but i dislike deferred freeing lists, it's always a problem
where to free the RAM for real. It didnt really work for bhs, it didnt
really work for other items either. And we have this nice lazy-TLB
mechanism for kernel threads so it's really a non-issue to use them.

	Ingo

