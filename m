Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265625AbTFNFuE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 01:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265626AbTFNFuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 01:50:03 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:50372 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265625AbTFNFt7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 01:49:59 -0400
Date: Fri, 13 Jun 2003 23:03:55 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: rml@tech9.net, retes_simbad@yahoo.es, linux-kernel@vger.kernel.org
Subject: Re: lowlatency fixes needed in 2.4 and 2.5
Message-Id: <20030613230355.06bfea7c.akpm@digeo.com>
In-Reply-To: <20030614014820.GZ1571@dualathlon.random>
References: <20030614014820.GZ1571@dualathlon.random>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 14 Jun 2003 06:03:47.0828 (UTC) FILETIME=[B8507B40:01C3323A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Fri, Jun 13, 2003 at 08:03:46PM +0000, Robert Love wrote:
> > On Fri, 2003-06-13 at 18:56, Ramón Rey Vicente????ey Vicente wrote:
> > 
> > > And, what's about the low_latency/preemptible patches? 
> > 
> > We did all that and more for 2.5.
> 
> the lowlatency patches are a must for 2.4, let's put them under the
> security bugfix headline and maybe they will get merged eventually ;).

Agree.

> It's not at all about lowlatency, it's about DoSing a box given enough
> pagecache and ram, tested it years ago the first time on some alpha.

It rather makes a mockery of SCHED_FIFO/SCHED_RR too.

> I'm not very exited about the -preempt stuff going on in 2.5 (this is
> code that is there since many months I know), just to make an example
> this code is micro-inefficient w/o -preempt configured:
> 
> static inline runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
> {
> 	struct runqueue *rq;
> 
> repeat_lock_task:
> 	local_irq_save(*flags);
> 	rq = task_rq(p);
> 	
> 
> when -preempt isn't configured you definitely want to do the
> local_irq_save _after_ the task_rq like we do in 2.4. It's absolutely
> wasteful to do the local_irq_save before the rq = task_rq.
> 
> Sure this is very much nitpicking (don't need to flame me I already know
> you'll never measure any performance overhead in any macrobenchmark, and
> it only affects irq latency anyways), but still I'm concerned on how
> -preempt is impacting some piece of code like this in a not very visible
> way and because it micro-peanlizes kernel compiles with -preempt
> disabled. I really would prefer an #ifdef CONFIG_PREEMPT there (or a
> cleaner abstraction, possibly not specific to the scheduler), as a
> documentation factor.

Yes.  I think we've been pretty successful in hiding the preempt mechanisms
inside existing infrastructure, so kernel/sched.c is a special case.

> ...
> I still think an explicit preempt-enable around the cpu intensive
> per-page copy users or checksums may be overall more worthwhile to
> provide lower mean latency than preempt as a whole.
> 
> I had a short look and 2.5 w/o -preempt enabled is still buggy and needs
> the above fixes too. Andrew, is that right or am I overlooking
> something?

I completely agree.  I want a non-preemptible kernel to not experience the
gross scheduling stalls: a few milliseconds is OK, a few hundred is not. 
Preempt will always be better, and that's fine.

2.5 should be OK, although I haven't checked lately.  grep around for
cond_resched().  The big pagecache and pagetable operations are addressed.

> In short I'd like to see those needed fixes included in 2.4 and
> _especially_ 2.5 ASAP.

yup.

