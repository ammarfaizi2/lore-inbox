Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbULNNCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbULNNCv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 08:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbULNNCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 08:02:45 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:50917 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261496AbULNNCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 08:02:11 -0500
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
In-Reply-To: <41BE29B5.5090206@timesys.com>
References: <OF737A0ECF.4ECB9A35-ON86256F65.006249D6@raytheon.com>
	 <1102722147.3300.7.camel@localhost.localdomain>
	 <41BB2785.7020006@timesys.com>
	 <1102826191.3691.44.camel@localhost.localdomain>
	 <41BE29B5.5090206@timesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Tue, 14 Dec 2004 08:01:36 -0500
Message-Id: <1103029296.3582.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-13 at 18:45 -0500, john cooper wrote:
> Steven Rostedt wrote:
> > 
> > I don't quite understand your point here. 
> > 
> > Say you have process A at prio 20 that waits on a queue with server S. S
> > becomes prio 20 and starts to run. Then it is preempted by process B at
> > prio 30 which then comes to wait on the server's queue. Server S becomes
> > prio 30 and finishes process A's work, then checks the queue again and
> > finds process B and starts working on process B's work still at prio 30.
> > The time of process B is still bounded (predictable).
> 
> My point was the server thread in the above scenario is
> non-preemptable.  Otherwise upon B soliciting service from
> S, A's work by S would be preempted and attention would be
> given immediately to B.
> 

Why must the server be non-preemptable?  Have you written code for a
server that can immediately switch to another clients request? I've
tried, and it's not easy.  The work of the server would only process one
client at a time. In that regard, the server is "non-preemptable", but
in services to be done, not in context switching. B would preempt server
S just because B is a higher priority. But when B puts itself to sleep
on S's wait queue, S would then inherit B's priority. But S would still
be finishing A's work. When S finished A's work, it would go directly on
to B's work.  This is just like a mutex. Think of the code within a
mutex as a service, and the Server is just the thread that happens to be
doing the work. So Process A would go into the mutex, become Sa, then
when B wanted to go into the mutex, Sa would inherit B's priority, and
when it's finish with A's work, it would become Sb.

> This may very well be a concession to simplicity in the
> design.  The server context on behalf of client A would need
> to be saved [somewhere] when B caused the preemption and
> restored when A's priority deemed doing so.
> 
Server S would not know that B is on the wait queue, except that B has
increased S's priority. S would still work on A's request, so the only
saving for S would be in the S's stack when B preempted it.

> For a mutex, the priority promotion of 'anything of lower
> priority in my way' to logical completion is needed to
> preserve the semantics of a mutex, ie: mutex ownership cannot
> be preempted.  However in general this doesn't hold for the
> server thread model.  We could redirect the server
> immediately to a different client at the cost of additional
> context switching -- a compromise to consider.
> 

How would you redirect the Server?  If server S is working on A's work,
(let's make it easy and use the example of a web server) A sends S a
request to serve page P, S goes to retrieve P, then B comes along and
request page Q, how would you write the code to know to stop working on
getting P and start getting Q, S is a single thread, doing the work, not
multiple instances.

> Again this is the general case.  It is likely for critical
> sections to exist in the server thread where preemption must
> be disabled analogous to the kernel/cpu preemption model.
> 
> > ...The work to keep track of what priorities are being
> > inherited is even easier than mutexs...
> 
> The dependency chain does exist here as for mutexes if we
> allow servers to wait on other servers.  Note in this usage
> a preemptive server model favors preemption over priority
> propagation unless the target server is itself blocked.
> 

If you have a single thread working as the server, how do you go about
writing code that can have that thread stop a task in the middle and
start doing something else. Although there may not be a need to do
certain things non-preemptively, but a server (should I say server
thread), only does one task at a time, giving it a same functionality as
a mutex.

> Note here it is more obvious [at least to me] circular
> dependencies are to be disallowed.  With mutexes, especially
> of the reader/writer variety, circular ownership
> dependencies can go unnoticed which will confound the
> priority promotion logic.
> 

I agree with you here, since a process can only have one server working
on it at a time. But this can become a problem, if you have one server
working for another server. If server S needs something from server X
then X needs something from server S, and they both are waiting. But
that would already have shown up in the kernel.


The whole point I'm trying to make is that today, when a high priority
process goes onto a wait queue, the process that will server that rt
process may be of a lower priority than other processes lower that the
original rt process that is waiting.  So you have a case of priority
inversion within processes serving other processes.

-- Steve

