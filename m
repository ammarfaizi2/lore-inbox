Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWDJOqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWDJOqB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 10:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWDJOqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 10:46:01 -0400
Received: from [212.33.188.179] ([212.33.188.179]:37892 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751196AbWDJOpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 10:45:41 -0400
From: Al Boldi <a1426z@gawab.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
Date: Mon, 10 Apr 2006 17:43:23 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200604031459.51542.a1426z@gawab.com> <200604090804.40867.a1426z@gawab.com> <44399E81.9050908@bigpond.net.au>
In-Reply-To: <44399E81.9050908@bigpond.net.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200604101743.23072.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Al Boldi wrote:
> > But how does this explain spa_no_frills setting promotion to max not
> > having this problem?
>
> I'm still puzzled by this.  The only thing I can think of is that the
> promotion mechanism is to simple in that it just moves all promotable
> tasks up one slot without regard for how long they've been on the queue.
>   Doing this was a deliberate decision based on the desire to minimize
> overhead and the belief that it wouldn't matter in the grand scheme of
> things.  I may do some experimenting with slightly more sophisticated
> version.
>
> Properly done, promotion should hardly ever occur but the cost would be
> slightly more complex enqueue/dequeue operations.  The current version
> will do unnecessary promotions but it was felt this was more than
> compensated for by the lower enqueue/dequeue costs.  We'll see how a
> more sophisticated version goes in terms of trade offs.

Would this affect the current, nearly perfect, spa_no_frills rr-behaviour w/ 
its ability to circumvent the timeslice problem when setting promo to max?

> >> This is one good reason not to use spa_no_frills on
> >> production systems.
> >
> > spa_ebs is great, but rather bursty.  Even setting max_ia_bonus=0
> > doesn't fix that.   Is there a way to smooth it like spa_no_frills?
>
> The principal determinant would be the smoothness of the yardstick.
> This is supposed to represent the task with the highest (recent) CPU
> usage rate per share and is used to determine how fairly CPU is being
> distributed among the currently active tasks.  Tasks are given a
> priority based on how their CPU usage rate per share compares to this
> yardstick.  This means that as the system load and/or type of task
> running changes the priorities of the tasks can change dramatically.
>
> Is the burstiness that you're seeing just in the observed priorities or
> is it associated with behavioural burstiness as well?

It's behavioural, exhibited in a choking style, like a jumpy mouse move 
during ia boosts.

> >> Perhaps you should consider creating a child
> >> scheduler on top of it that meets your needs?
> >
> > Perhaps.
>
> Good.  I've been hoping that other interested parties might be
> encouraged by the small interface to SPA children to try different ideas
> for scheduling.

Is there a no-op child skeleton available?

> One thing that could be played with here is to vary the time slice based
> on the priority.  This would be in the opposite direction to the normal
> scheduler with higher priority tasks (i.e. those with lower prio values)
> getting smaller time slices.  The rationale being:
>
> 1. stop tasks that have been given large bonuses from shutting out other
> tasks for too long, and
> 2. reduce the context switch rate for tasks that haven't received bonuses.
>
> Because tasks that get large bonuses will have short CPU bursts they
> should not be adversely effected (if this is done properly) as they will
> (except in exceptional circumstances such as a change in behaviour)
> surrender the CPU voluntarily before their reduced time slice has
> expired.  Imaginative use of the available statistics could make this
> largely automatic but there would be a need to be aware that the
> statistics can be distorted by the shorter time slices.
>
> On the other hand, giving tasks without bonuses longer time slices
> shouldn't adversely effect interactive performance as the interactive
> tasks will (courtesy of their bonuses) preempt them.

I couldn't agree more.  Tackling the problem on both fronts (prio/tslice) may 
give us more control, which could result in a more appropriate / fairer / 
smoother scheduler.

Thanks!

--
Al

