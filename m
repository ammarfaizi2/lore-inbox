Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbULFOm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbULFOm6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 09:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbULFOmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 09:42:50 -0500
Received: from tus-gate3.raytheon.com ([199.46.245.232]:6689 "EHLO
	tus-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S261479AbULFOmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 09:42:22 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-0
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
Message-ID: <OF783C60D6.A87E04B2-ON86256F62.004E56E5@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Mon, 6 Dec 2004 08:40:57 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/06/2004 08:41:03 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>* Esben Nielsen <simlo@phys.au.dk> wrote:
>
>> On Fri, 3 Dec 2004, Ingo Molnar wrote:
>>
>> >
>> > [...]
>> > on low RT load (the common case)
>>
>> In the system I deal with on my day job, 50% of the CPU load is from
>> RT tasks!
>
>i'm not sure what point you are trying to make, but 'low RT load' in
>this context means up to a load of 1.0. (i.e. one or less tasks running
>on average)
I am not quite so sure that is a good assumption with our real time
system either. We use RT priorities based on execution rate with a
single (highest priority) RT task that wakes up the others at the
appropriate times. So an 80 Hz task has a higher RT priority than a
40 Hz task, both are greater than 10 Hz, and all greater than 1 Hz.
We do have a few other tasks for signal handling and other purposes
but most fit the above pattern.

At periodic rate (e.g., once per second) we basically start ALL RT tasks
and let the kernel figure out which one (two actually) should run first.
At that point in time, I may have 10-20 RT tasks ready to run with only
two CPU's to run them on. As the high priority tasks get done, the load
starts to drop, but a one Hz task may get delayed for some time and
interrupted several times during execution (later cycles of higher rate
RT tasks). FYI - I just checked and on our cluster head node, we have
31 RT tasks on a two CPU system.

With the real time load up, the one minute load average on 2.4 systems
oscillates in an odd fashion. For example, looking at 1 hour chart of
load average on my cluster shows the head node oscillating between zero
and five, even though the CPU usage is constant at 17.4%. I assume this
is a sampling error.

If the algorithm is OK for "small numbers" where small is under ten
times the number of CPU's, that is probably OK. [I'll allow that
SOMEONE will try to run a big RT simulation on a 256 CPU SMP machine
and complain later]

>also, this only applies to SMP systems.
Yes.

>thirdly, even if the new balancing code kicks in, the overhead is not
>that bad, and it's for a purpose: we rather want an RT task to run on a
>free CPU.
I agree though I wish it was possible to determine if the interrupt
preemption was "short" or "long" to decide to switch or not [the switch
DOES have costs...]. I believe this is why the max latency of my CPU
task went down (by about 1 msec) but the number of short latencies
(> 100 usec) went up.

But I am still seeing starvation of the non RT tasks that was not
present in 2.4. It appears that cpu_burn (non RT, nice) is taking CPU
cycles that should be allocated to my (non RT, not nice) stress test
programs. This distorts the elapsed time of my tests and to some extent
the latency results (since less I/O stress is on the system) of the tests.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

