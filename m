Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSFJUPQ>; Mon, 10 Jun 2002 16:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316079AbSFJUPP>; Mon, 10 Jun 2002 16:15:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61625 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S316070AbSFJUPN>;
	Mon, 10 Jun 2002 16:15:13 -0400
Date: Mon, 10 Jun 2002 22:12:46 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler Bug (set_cpus_allowed)
In-Reply-To: <20020607121207.B1532@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0206102053310.28876-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Jun 2002, Mike Kravetz wrote:

> > > Consider the case where a task is to give up the CPU
> > > and schedule() is called.  In such a case the current
> > > task is removed from the runqueue (via deactivate_task).
> > > Now, further assume that there are no runnable tasks
> > > on the runqueue and we end up calling load_balance().
> > > In load_balance, we potentially drop the runqueue lock
> > > to obtain multiple runqueue locks in the proper order.
> > > Now, when we drop the runqueue lock we will still
> > > be running in the context of task p.  However, p does
> > > not reside on a runqueue.  It is now possible for
> > > set_cpus_allowed() to be called for p.  We can get the
> > > runqueue lock and take the fast path to simply update
> > > the task's cpu field.  If this happens, bad (very bad)
> > > things will happen!
> > 
> > Ugh I think you are right.  This is an incredibly small race, though!
> 
> I agree that the race is small.  I 'found' this while playing with some
> experimental code that does the same thing as the fast path in
> set_cpus_allowed: it sets the cpu field while holding the rq lock if the
> task is not on the rq.  This code runs as at higher frequency (than
> would be expected of set_cpus_allowed) and found this hole.

i agree that this is a subtle issue. My first version of the migration
code did something like this - it's a natural desire to manually migrate
the target task (there are various levels of doing this - the very first
version of the code directly unlinked the thread from the current runqueue
and linked it into the target runqueue), instead of having to switch to a
migration-thread.

the fundamental reason for this fragility is the following: the room to
move the concept of migration into the O(1) design is very very small, if
the condition is to not increase the cost of the scheduler fastpath.

the only robust way i found was to use a highprio helper thread which
naturally unschedules the current task. Attempts to somehow unschedule a
to-be-migrated task without having to switch into the helper thread turned
out to be problematic.

	Ingo

