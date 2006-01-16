Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWAPLah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWAPLah (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 06:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWAPLah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 06:30:37 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:54473 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1750917AbWAPLag
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 06:30:36 -0500
Date: Mon, 16 Jan 2006 12:30:03 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Bill Huey <billh@gnuppy.monkey.org>
cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>, <linux-kernel@vger.kernel.org>
Subject: Re: RT Mutex patch and tester [PREEMPT_RT]
In-Reply-To: <20060116105333.GA19617@gnuppy.monkey.org>
Message-ID: <Pine.LNX.4.44L0.0601161215080.4219-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2006, Bill Huey wrote:

> On Mon, Jan 16, 2006 at 02:22:55AM -0800, Bill Huey wrote:
> > On Mon, Jan 16, 2006 at 09:35:42AM +0100, Esben Nielsen wrote:
> > > On Sat, 14 Jan 2006, Bill Huey wrote:
> > > I am not precisely sure what you mean by "false reporting".
> > >
> > > Handing off BKL is done in schedule() in sched.c. I.e. if B owns a normal
> > > mutex, A will give BKL to B when A calls schedule() in the down-operation
> > > of that mutex.
> >
> > Task A holding BKL would have to drop BKL when it blocks against a mutex held
> > by task B in my example and therefore must hit schedule() before any pi boost
> > operation happens. I'll take another look at your code just to see if this is
> > clear.
>
> Esben,
>
> Ok, I see what you did. Looking through the raw patch instead of the applied
> sources made it not so obvious it me.

Only small patches can be read directly....

> Looks the logic for it is there to deal
> with that case, good. I like the patch,

good :-)

> but it does context switch twice as
> much it seems which might a killer.

Twice? It depends on the lock nesting depth. The number of task
switches is the lock nesting depth in any blocking down() operation.
In all other implementations the number of task switches is just 1.
I.e is the usual case (task A blocks on  lock 1 owned by B, which is
unblocked), where lock nesting depth is 1, there is no penalty with my
approach. The panalty comes at (task A blocks on lock 1 owned by B,
blocked on lock 2 owned by C). There B is scheduled as an agent to boost
C, such that A never touches lock 2 or task C. Precisely this makes the
spinlocks a lot easier to handle.

On the other hand the maximum time spent with preemption off is
O(1) in my implementation whereas it is at least O(lock nesting depth) in
other implementations. I think the current implementation in rt_preempt
is max(O(total number of PI waiters),O(lock nesting depth)).

Esben

>
> bill
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

