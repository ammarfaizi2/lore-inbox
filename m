Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbULIUjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbULIUjY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 15:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbULIUjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 15:39:24 -0500
Received: from mail3.utc.com ([192.249.46.192]:19084 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S261611AbULIUjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 15:39:01 -0500
Message-ID: <41B8B6C4.60200@cybsft.com>
Date: Thu, 09 Dec 2004 14:34:12 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mark_H_Johnson@raytheon.com, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
References: <OFADAD8EC1.8BCE1EC6-ON86256F65.005EFFA6@raytheon.com> <20041209173136.GE7975@elte.hu>
In-Reply-To: <20041209173136.GE7975@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:
> 
> 
>>>also, i'd like to take a look at latency traces, if you have them for
>>>this run.
>>
>>I could if I had any. The _RT run had NO latency traces > 250 usec
>>(the limit I had set for the test). The equivalent _PK run had 37 of
>>those traces. I can rerun the test with a smaller limit to get some if
>>it is really important. My build of -12 is almost done and we can see
>>what kind of repeatability / results from the all_cpus trace shows.
> 
> 
> /me is puzzled.
> 
> so all the CPU-loop delays within the -RT kernel are below 250 usecs? I
> guess i dont understand what this means then:
> 
> | The max CPU latencies in RT are worse than PK as well. The values for
> | RT range from 3.00 msec to 5.43 msec and on PK range from 1.45 msec to
> | 2.24 msec.
> 
> these come from userspace timestamping? So where userspace detects a
> delay the kernel tracer doesnt measure any?
> 
> 	Ingo
> 

Ingo,

I see something similar here also:

running realfeel with rtc histogram generates > 100 usec entries in the 
histogram but none of these are ever caught by the wakeup tracing.

IRQ 8 = 99
realfeel = 98
IRQ 0 = 97

-realfeel sets rtc up to 1024 Hz and does blocking read on rtc
-IRQ 8 hits and rtc_interrupt runs code from rtc_wake_event which sets 
last_interrupt_time then calls wake_up_interruptible which as you know 
eventually calls try_to_wake_up because it's the default_wake_function
-the blocked read then restarts after the schedule() call in rtc_read, 
right?
-then realfeel in rtc_read runs code in rtc_read_event which sets now, 
then generates histogram entry from the diff between now and 
last_interrupt_time

No wakeup latency generated from this.

I think I know why we don't get traces from this. TIF_NEED_RESCHED is 
not set for IRQ 8 at the time that it wakes up realfeel so _need_resched 
fails and trace_start_sched_wakeup doesn't actually call 
__trace_start_sched_wakeup(p)???

kr

