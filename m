Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbULNObe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbULNObe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 09:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbULNObd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 09:31:33 -0500
Received: from mail.timesys.com ([65.117.135.102]:18524 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261494AbULNObU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 09:31:20 -0500
Message-ID: <41BEF883.9000401@timesys.com>
Date: Tue, 14 Dec 2004 09:28:19 -0500
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>, Ingo Molnar <mingo@elte.hu>,
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
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       john cooper <john.cooper@timesys.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
References: <OF737A0ECF.4ECB9A35-ON86256F65.006249D6@raytheon.com>	 <1102722147.3300.7.camel@localhost.localdomain>	 <41BB2785.7020006@timesys.com>	 <1102826191.3691.44.camel@localhost.localdomain>	 <41BE29B5.5090206@timesys.com> <1103029296.3582.28.camel@localhost.localdomain>
In-Reply-To: <1103029296.3582.28.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Dec 2004 14:23:35.0937 (UTC) FILETIME=[7F678710:01C4E1E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

> Why must the server be non-preemptable?  Have you written code for a
> server that can immediately switch to another clients request? I've
> tried, and it's not easy.

Yes I have and agree it is not trivial.  What is required is
for the server's context in the process of servicing client A
to be saved with A and context of the new client to be loaded.

One way this can be accomplished is to save the server context
on the stack of the client which it is preempting.  This is
quite similar to the model of a CPU (server) and how task
(client) preemption is effected in the kernel.

> The work of the server would only process one
> client at a time. In that regard, the server is "non-preemptable", but
> in services to be done, not in context switching. B would preempt server
> S just because B is a higher priority. But when B puts itself to sleep
> on S's wait queue, S would then inherit B's priority.

In this scenario B is not preempting A's service, but rather elevating
S to the priority of B in hope S can compete for system resource at
B's priority.  In a preemptive scenario B would not sleep on S as its
priority would redirect S from A to B.  The only time an arriving high
priority client would promote/block over preemption would be if S
itself was blocked (unavailable).

> But S would still
> be finishing A's work. When S finished A's work, it would go directly on
> to B's work.  This is just like a mutex...

Yes the above is just like a mutex.  However the model of a server
thread offers opportunity for greater server (resource) availability
while retaining correct semantics vs. that of a mutex (resource).
The server's service of a client in general may be preempted while
the ownership of a mutex may not.

> Server S would not know that B is on the wait queue, except that B has
> increased S's priority. S would still work on A's request, so the only
> saving for S would be in the S's stack when B preempted it.

True in the non-preemptive case as there is no reason to
notify S.  In the preemptive case S would receive the
equivalent of an interrupt upon B's arrival.

> How would you redirect the Server?  If server S is working on A's work,
> (let's make it easy and use the example of a web server) A sends S a
> request to serve page P, S goes to retrieve P, then B comes along and
> request page Q, how would you write the code to know to stop working on
> getting P and start getting Q, S is a single thread, doing the work, not
> multiple instances.

True.  However abstractly S would be preempted and save its
current context 'with' A.  S then would restore (load) B's
(initial) context and begin service.

A userspace example is probably not the easiest place to start.
Such saving and restoration of context is much less of a logistical
issue for in-kernel mechanisms.

Although I've implemented similar server models in userspace where
the available server interruptive mechanism boils down to sending
of a signal.  The enforcement of critical sections in the
server is effected by blocking signal delivery (preemption).

> If you have a single thread working as the server, how do you go about
> writing code that can have that thread stop a task in the middle and
> start doing something else. Although there may not be a need to do
> certain things non-preemptively, but a server (should I say server
> thread), only does one task at a time, giving it a same functionality as
> a mutex.

The server in the preemptive model virtualizes a CPU.  We can
preempt the service of the CPU during execution in a task (client)
by interrupting the CPU.  This results in saving of the CPU context
during the service of the client on the stack of the preempted client.

> I agree with you here, since a process can only have one server working
> on it at a time. But this can become a problem, if you have one server
> working for another server. If server S needs something from server X
> then X needs something from server S, and they both are waiting. But
> that would already have shown up in the kernel.

Yes, circular dependencies are illegal while strictly ordered
dependencies are allowable.  This is similar to enforcement of
a mutex/lock acquisition hierarchy.

> The whole point I'm trying to make is that today, when a high priority
> process goes onto a wait queue, the process that will server that rt
> process may be of a lower priority than other processes lower that the
> original rt process that is waiting.  So you have a case of priority
> inversion within processes serving other processes.

Agreed.  And I do think this mechanism has merit irrespective
of the preemption model -- I wouldn't expect a preemptive
approach to be available in the first prototype.

I'd hazard other likely sources of battle history dealing with
client/server/preemption issues to be found in papers dealing with
microkernel [who?] design of about a decade and a half ago.

-john


-- 
john.cooper@timesys.com
