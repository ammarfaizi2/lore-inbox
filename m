Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbULITZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbULITZV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 14:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbULITZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 14:25:21 -0500
Received: from tus-gate5.raytheon.com ([199.46.245.234]:59801 "EHLO
	tus-gate5.raytheon.com") by vger.kernel.org with ESMTP
	id S261589AbULITYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 14:24:44 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
To: Ingo Molnar <mingo@elte.hu>
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF5058AABF.606A2CFD-ON86256F65.0067A0C9@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 9 Dec 2004 13:23:38 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/09/2004 01:23:43 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I may take this "off line" if it goes on too much longer. A little
"view of the customer" is good for the whole group, but if it
gets too much into my specific application, I don't see the benefit.

>* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:
>
>> CPU load is pretty steady at up to 20% for any of the two CPU nodes in
>> the cluster. The upper bound for OS overhead (latency) I need is about
>> 1 msec (out of a 12.5 msec / 80 Hz frame). I do have some long CPU
>> runs / PCI shared memory traffic in the 80 Hz task at a one per second
>> rate that might take up to 10 msec of the 12.5 msec frame.
>
>so the 1 msec latency is needed by this 80 Hz task? I'd thus make this
>task prio 90 (higher than most IRQ handlers), and make the 80 Hz
>timesource's [timer IRQ? RTC? special driver?] IRQ thread prio 91. All
>other IRQ threads should be below prio 90. Whatever else this task
>triggers will be handled either by PI handling, or is started enough in
>advance (such as disk IO or network IO) to be completed by the time the
>80 Hz task needs it.
If I could do it over again, I may agree with you. However, there are a
few constraints you are not aware of:
 - the run time library I use (GNAT Ada) has only 31 priorities plus
a few it reserves for itself. These are mapped to 1-32 on Linux.
 - the framework we wrote (may years ago for another OS) uses almost all
of these priorities. For example, the 80 Hz task I referred to runs at
priority 24. The 1 Hz task runs at 4. We basically use every other
priority.
 - a task can request to run before / after a specific rate so the
odd priorities can be used as well.
 - we also have a "synchronizer" that runs at 29 and a couple other
special tasks that can run at 28.
So without rewriting the Ada run time, I don't have any free priority
levels to work with. Also note that I do get acceptable performance with
2.4 preempt + lowlat which does not have threaded IRQ's. I ought to get
acceptable performance with a 2.6 system (or else, why step up?).

>> I could set the IRQ priority of the shared memory interface to be the
>> highest (since I do task scheduling based on it) but after that there
>> is also no preset assignment of priority to I/O activity.
>
>but if this is the task that needs to do its work within 1 msec when
>signalled, it should be the highest prio one nevertheless, and no IRQ
>(except the signal IRQ) must be allowed to preempt it.
[I think we violently agree on this one]

>(The other tasks can 'feed' this master task with whatever scheduling
>pattern, as long as the 'master task' provides frames with a precise 80
>Hz frequency. Any jitter to the execution of these other threads is
>handled by buffering enough stuff in advance.)
We do not necessarily send signals at 80 Hz. Our framework has non
harmonic rates like...
  100, 80, 60, 50, 40, 30, 25, 20, 10, 5, 2, and 1
so the minimum frequency that divides evenly into all those is 1200 Hz.
Our 2.4 kernel has HZ=2400. If the "master task" (or in our system the
synchronizer) gets behind, the software is built to take care of that
(basically a best effort) to try to prevent missed frames.

>> Some form of priority inheritance may be "better" but I understand
>> that is not likely to be implemented (nor worth the effort).
>
>the master task's priority will be inherited across most of the
>dependencies that might happen at the kernel level. [ If it doesnt then
>it should show up in traces and i'm most interested in fixing it ... ]
I was referring to the priorities of the IRQ's being inherited from
the priority of the RT task making the I/O request. Then I could make
the priorities of all the IRQ's less than my highest RT task & they
would get boosted as needed. [but then I might need more buffering
for I/O since the RT tasks are starving them...]

>> By setting the IRQ threads to RT FIFO 99, I also get something closer
>> to PREEMPT_DESKTOP w/o IRQ threading (or for that matter, closer to
>> the 2.4 kernel I use today). It shows more clearly the overhead of
>> adding the threads.
>
>i believe this is the wrong model for this workload.
I stand by the statement I made. It is closer to the model of
PREEMPT_DESKTOP and shows the thread overhead more clearly. The user
can certainly optimize for a specific workload but that masks the
overhead added by threading.

>> [...] As Ingo noted in a private message
>>   "IRQ-threading will always be more expensive than direct IRQs,
>>    but it should be a fixed overhead not some drastic degradation."
>>
>> I agree the overhead should be modest but somehow the test cases I run
>> don't show that (yet). There is certainly more work to be done to fix
>> that.
>
>have you tried it with all debugging turned off? I'd like to fix any
>performance problems related to IRQ/softirq threading. (If you mean the
>'lost pings' problem, that one looks like to be more of a priority
>inversion problem than a real performance issue.)

I don't expect turning the debugging off will make that much of a
difference but I can try it tomorrow. The charts look MUCH worse
in _RT than _PK right now and both have the same level of debugging
enabled (and _PK is close to the 2.4 performance). I'll tar up the
html directories and send those separately so you can see the difference
between -5PK and -5RT at the application level. I'll send the 2.4
charts for a baseline comparison as well.

The lost pings go away by boosting the priority of ksoftirqd/0 and /1.
But even with all the IRQ's at 99 and those two tasks at 99, the ping
response time under _RT is about 2x to 3x the response time of the
non threaded IRQs of _PK.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

