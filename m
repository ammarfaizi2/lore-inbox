Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270325AbTGMSFv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 14:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270324AbTGMSFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 14:05:50 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:28550 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270325AbTGMSFt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 14:05:49 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 13 Jul 2003 11:13:09 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Scheduler woes ( was [patch] SCHED_SOFTRR linux scheduler policy)
 ...
In-Reply-To: <1058097211.32496.30.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.55.0307131022560.14680@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.55.0307091929270.4625@bigblue.dev.mcafeelabs.com> 
 <20030713115033.GA371@elf.ucw.cz> <1058097211.32496.30.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003, Alan Cox wrote:

> On Sul, 2003-07-13 at 12:50, Pavel Machek wrote:
> > Hi!
> >
> > > I finally found a couple of hours for this and I also found a machine were
> > > I can run 2.5, since luck abandoned myself about this. The small page
> > > describe the obvious and contain the trivial patch and the latecy test app :
> > >
> > > http://www.xmailserver.org/linux-patches/softrr.html
> >
> > What happens if evil user forks 60 processes, marks them all
> > SCHED_SOFTRR, and tries to starve everyone else?
>
> With the current scheduler you lose. Rik did some playing with a fair
> share scheduler some time ago. That actually works very well for a lot
> of these sorts of things. You can nice processes up (but only by
> penalising your own processes) and conceptually you'd be able to soft
> real time on a per user basis this way.

There are currently two kind of problems, that can be solved with
different approaches. One is starvation and the other one is fairness
among system users. Googling around for problems reported about
starvation, we can find stuff reported by David Mosberger plus other real
or artificial piece of code that makes the scheduler to starve other tasks
(or at least assign CPU slices in a way less than optimal way). Since Ingo
will be listening I'll go with some ideas. I believe we should have three
domains inside the scheduler 1) RT 2) Interactive 3) Non-Interactive,
having three different priority lists. It is possible to have 1 and 2
collapsed to restrict the schema to a dual-domain. The algorithm should be
like :

	if ((t = get_rt_task()) != NULL)
		goto got_it;
	if (time_to_pick_interactive() && (t = get_int_task()) != NULL)
		goto got_it;
	if (!(t = get_nint_task()))
		t = idle();
got_it:
	...

Functions get_*() do the std bitmap lookup and O(1) fetch. The function
time_to_pick_interactive() is a trivial function of the time consumed by
interactive tasks and non-interactive tasks so that we can even eventually
tune it with /proc. Even a super-trivial policy like :

	static inline int time_to_pick_interactive(void) {
		return rt->sched_num % N;
	}

would work. Even with N very small like 2, the greater timeslice allocated
for interactive tasks will still assign a huge slice of CPU to them (a
quadratic of cubic timeslice(prio) function will mark even more the gap).
The EXPIRED_STARVING() thing simply does not work, expecially with a ten
second setup. Also, it makes all interactive tasks to fall trough in the
expired array. The above solution will guarantee that no starvation will
be experienced by other tasks. You really want to make time_to_pick_interactive()
a function of the allocated CPU time to achieve a better distribution.
All the tricks available to hit the interactive selection machanism will
fail under this solution. All non-iteractive tasks will have their
*guaranteed* (and tunable) minimum CPU time. You can easily keep the time
allocation information inside the run queue struct so that you can access
them w/out extra locks.

Ingo, I know you're busy with other stuff but you should definitely take a
look at some of the exposed cases, some of them are scary if you think at
what they can do in a multi-user environment.



- Davide

