Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUJESam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUJESam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 14:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUJESal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 14:30:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14231 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263736AbUJES2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 14:28:41 -0400
Date: Tue, 5 Oct 2004 11:28:31 -0700
Message-Id: <200410051828.i95ISVoc006842@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] CPU time clock support in clock_* syscalls
In-Reply-To: Nick Piggin's message of  Tuesday, 5 October 2004 16:43:45 +1000 <416242A1.3060203@yahoo.com.au>
Emacs: where editing text is like playing Paganini on a glass harmonica.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Roland McGrath wrote:
> 
> >  /*
> > + * This is called on clock ticks and on context switches.
> > + * Bank in p->sched_time the ns elapsed since the last tick or switch.
> > + */
> > +static void update_cpu_clock(task_t *p, runqueue_t *rq,
> > +			     unsigned long long now)
> > +{
> > +	unsigned long long last = max(p->timestamp, rq->timestamp_last_tick);
> > +	p->sched_time += now - last;
> > +}
> 
> This looks wrong. But update_cpu_clock is never called from another
> CPU. In which case you don't need to worry about timestamp_last_tick.

I don't really understand this comment.  update_cpu_clock is called from
schedule and from scheduler_tick.  When it was last called by schedule,
p->timestamp will mark this time.  When it was last called by
p->scheduler_tick, rq->timestamp_last_tick will mark this time.
Hence the max of the two is the last time update_cpu_clock was called.

> This doesn't perform the timestamp_last_tick "normalisation" properly
> either.

I don't know what you think is missing.  If the "normalization" you are
talking about is this kind of thing:

		p->timestamp = p->timestamp - rq_src->timestamp_last_tick
				+ rq_dest->timestamp_last_tick;

then that is not relevant here.  That normalizes the timestamp to the new
CPU when changing from one CPU to another.  This is not something that
matters for the sched_time tracking, because that only uses the difference
between a timestamp when the thread went on a CPU and the timestamp when it
went off.  When a thread switches CPUs without yielding, this normalization
will happen to its ->timestamp, and then the next update_cpu_clock will be
taking the difference of the newly-appropriate ->timestamp value against
the current CPU's sched_clock value.

> It also seems to conveniently ignore locking when reading those values
> off another CPU. Not a big deal for dynamic load calculations, but I'm
> not so sure about your usage...?

Here again I don't know what you are talking about.  Nothing is ever read
"off another CPU".  A thread maintains its own sched_time counter while it
is running on a CPU.

> Lastly, even when using timestamp_last_tick correctly, I think sched_clock
> will still drift around slightly, especially if a task switches CPUs a lot
> (but not restricted to moving CPUs). 

Please explain.



Thanks,
Roland
