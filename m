Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbULLEg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbULLEg6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 23:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbULLEg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 23:36:58 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:23740 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261541AbULLEgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 23:36:54 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
From: Steven Rostedt <rostedt@goodmis.org>
To: john cooper <john.cooper@timesys.com>
Cc: Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>, Ingo Molnar <mingo@elte.hu>,
       Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, LKML <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
In-Reply-To: <41BB2785.7020006@timesys.com>
References: <OF737A0ECF.4ECB9A35-ON86256F65.006249D6@raytheon.com>
	 <1102722147.3300.7.camel@localhost.localdomain>
	 <41BB2785.7020006@timesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Sat, 11 Dec 2004 23:36:31 -0500
Message-Id: <1102826191.3691.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-11 at 11:59 -0500, john cooper wrote:
> Steven Rostedt wrote:
> 
> > [RFC]  Has there been previously any thought of adding priority
> > inheriting wait queues. With the IRQs that run as threads, have hooks in
> > the code that allows a driver or socket layer to attach a thread to a
> > wait queue, and when a RT priority task waits on the queue, a function
> > is call to increase (if needed) the priority of the attached thread. I
> > know that this would take some work, and would make the normal kernel
> > and RT diverge more, but it would really help to solve the problem of a
> > high priority process waiting for an interrupt that can be starved by
> > other high priority processes.
> 
> I think there are two issues here.  One being as above which
> addresses allowing the server thread to compete for CPU time
> at a priority equal to its highest waiting client.  Essentially
> the server needs no inherent priority of its own, rather its
> priority is automatically inherited.  The semantics seem
> straightforward even in the general case of servers themselves
> becoming clients of other servers.
> 

I agree with you on this.

> Another issue is the fact the server thread is effectively
> non-preemptive.  Otherwise a newly arrived waiter of priority
> higher than a client currently being serviced would receive
> immediate attention.  One problem to be solved here is how to
> save/restore client context when a "context switch" is required.

I don't quite understand your point here. 

Say you have process A at prio 20 that waits on a queue with server S. S
becomes prio 20 and starts to run. Then it is preempted by process B at
prio 30 which then comes to wait on the server's queue. Server S becomes
prio 30 and finishes process A's work, then checks the queue again and
finds process B and starts working on process B's work still at prio 30.
The time of process B is still bounded (predictable).

So it's similar to a mutex and priority inheritance. We can look at
process A taking lock L and then when process B blocks on lock L,
process A inherits process B's priority (B being greater prio than A).
The difference is that the work is being done within a mutex as suppose
to a server. The work to keep track of what priorities are being
inherited is even easier than mutexs, since you have a process (the
server) to just point to which process it has inherited, and a wait
queue to store which process needs to be inherited next when the server
wakes up the currently inherited process.

-- Steve

