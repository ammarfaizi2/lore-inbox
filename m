Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWC1XfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWC1XfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWC1XfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:35:10 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:32985 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S964837AbWC1XfJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:35:09 -0500
Date: Wed, 29 Mar 2006 00:34:57 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: PI patch against 2.6.16-rt9
In-Reply-To: <1143585726.5344.238.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0603290006290.32655-100000@lifa02.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2006, Thomas Gleixner wrote:

> On Tue, 2006-03-28 at 23:23 +0100, Esben Nielsen wrote:
> > > If you get to L(x) the underlying dependencies might have changed
> > > already as well as the dependencies x ... n. We might get false
> > > positives in the deadlock detection that way, as a deadlock is an
> > > "atomic" state.
> >
> > As I see it you might detect a circular lock graph "atomically". But is
> > that a "deadlock"? Yes, if you rule out signals and timeouts, this
> > situation does indeed deadlock your program.
> >
> > But if you count in signals and timeouts your algoritm also gives "false
> > positives": You can detect a circular lock but when you return from
> > rt_mutex_slowlock(), a signal is delivered and there is no longer a
> > circular dependency and most important: The program wouldn't be
> > deadlocked even if you didn't ask for deadlock detection and your task in
> > that case would block.
> >
> > I would like to see an examble of a false deadlock. I don't rule them out
> > in the present code. But they might be simple to fix.
>
> Simply the initial lock chain is L1->L2->L3->L4, which is no deadlock.
> Now in the course of your lock dropping L2 gets removed while you are at
> L3 and L5 gets added on top of L4. You follow the chain blindly and
> detect a dealock vs. L5, but its not longer valid. The L2 cleanup is
> blocked by yourself. There is no way to prevent this with your method.
>

Hmm, let me try to write it out

       A                B             C           D
    lock L1           lock L2       lock L3       lock L4
    lock L2           lock L3       lock L4
 traverse to C
 is preempted
                                                  unlock L4
                                    unlock L4
                                    unlock L3
                      unlock L3                   lock L4
                      unlock L2     lock L3
                      lock L3       lock L4

 Continue from C

Ok, I see the problem for _deadlock detection_.  There still is no problem
for PI.



> Your method is tempting, but I do not see how it works out right now.
>

It works for PI. It might give false positives for deadlock detection even
without signals involved. But that might be solved by simply checking
again. If it is stored on a task when they blocked on a lock it
could be seen if they had released and reobtained the task since the last
traversal.

If I should choose between a 100% certain deadlock detection and
rescheduling while doing PI I would choose that latter as that gives a
deterministic RT system. Are there at all applications depending on
deadlock detection or is it only for debug perposes anyway?

Esben

> 	tglx
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


