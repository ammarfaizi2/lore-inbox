Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbULMXsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbULMXsx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 18:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbULMXsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 18:48:53 -0500
Received: from mail.timesys.com ([65.117.135.102]:57533 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261348AbULMXsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 18:48:50 -0500
Message-ID: <41BE29B5.5090206@timesys.com>
Date: Mon, 13 Dec 2004 18:45:57 -0500
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
References: <OF737A0ECF.4ECB9A35-ON86256F65.006249D6@raytheon.com>	 <1102722147.3300.7.camel@localhost.localdomain>	 <41BB2785.7020006@timesys.com> <1102826191.3691.44.camel@localhost.localdomain>
In-Reply-To: <1102826191.3691.44.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Dec 2004 23:41:08.0578 (UTC) FILETIME=[3851B420:01C4E16D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

>>Another issue is the fact the server thread is effectively
>>non-preemptive.  Otherwise a newly arrived waiter of priority
>>higher than a client currently being serviced would receive
>>immediate attention.  One problem to be solved here is how to
>>save/restore client context when a "context switch" is required.
> 
> 
> I don't quite understand your point here. 
> 
> Say you have process A at prio 20 that waits on a queue with server S. S
> becomes prio 20 and starts to run. Then it is preempted by process B at
> prio 30 which then comes to wait on the server's queue. Server S becomes
> prio 30 and finishes process A's work, then checks the queue again and
> finds process B and starts working on process B's work still at prio 30.
> The time of process B is still bounded (predictable).

My point was the server thread in the above scenario is
non-preemptable.  Otherwise upon B soliciting service from
S, A's work by S would be preempted and attention would be
given immediately to B.

This may very well be a concession to simplicity in the
design.  The server context on behalf of client A would need
to be saved [somewhere] when B caused the preemption and
restored when A's priority deemed doing so.

For a mutex, the priority promotion of 'anything of lower
priority in my way' to logical completion is needed to
preserve the semantics of a mutex, ie: mutex ownership cannot
be preempted.  However in general this doesn't hold for the
server thread model.  We could redirect the server
immediately to a different client at the cost of additional
context switching -- a compromise to consider.

Again this is the general case.  It is likely for critical
sections to exist in the server thread where preemption must
be disabled analogous to the kernel/cpu preemption model.

> ...The work to keep track of what priorities are being
> inherited is even easier than mutexs...

The dependency chain does exist here as for mutexes if we
allow servers to wait on other servers.  Note in this usage
a preemptive server model favors preemption over priority
propagation unless the target server is itself blocked.

Note here it is more obvious [at least to me] circular
dependencies are to be disallowed.  With mutexes, especially
of the reader/writer variety, circular ownership
dependencies can go unnoticed which will confound the
priority promotion logic.

-john



-- 
john.cooper@timesys.com
