Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262829AbUJ1Ic1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbUJ1Ic1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 04:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUJ1Ic1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 04:32:27 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:43425 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262830AbUJ1IcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 04:32:10 -0400
Message-ID: <20668.195.245.190.93.1098952275.squirrel@195.245.190.93>
In-Reply-To: <20041028063630.GD9781@elte.hu>
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu>
    <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu>
    <5225.195.245.190.94.1098880980.squirrel@195.245.190.94>
    <20041027135309.GA8090@elte.hu>
    <12917.195.245.190.94.1098890763.squirrel@195.245.190.94>
    <20041027205126.GA25091@elte.hu> <20041027211957.GA28571@elte.hu>
    <33083.192.168.1.5.1098919913.squirrel@192.168.1.5>
    <20041028063630.GD9781@elte.hu>
Date: Thu, 28 Oct 2004 09:31:15 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 28 Oct 2004 08:32:08.0454 (UTC) FILETIME=[9CDEBA60:01C4BCC8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> * Rui Nuno Capela wrote:
>
>> >> ok, i've uploaded RT-V0.4.2 which has more of the same: it fixes
>> >> other missed preemption checks. Does it make any difference to the
>> >> xruns on your UP box?
>> >
>> > uploaded RT-V0.4.3 - there was a thinko in the latency tracer that
>> > caused early boot failures.
>> >
>>
>> Yes, the xrun rate has decreased, slightly. RT-V0.4.3 is now ranking
>> under 10 per 5 min (~2/min), with jackd -R -r44100 -p128 -n2,
>> fluidsynth x 6.
>>
>> Better still, but not to par as RT-U3, under the very same conditions.
>
> how much idle time do you have in the RT-U3 and in the RT-V0.4 tests,
> compared? If it's close to 100% then make sure you have the following
> debug options disabled:
>
>  # CONFIG_DEBUG_SLAB is not set
>  # CONFIG_DEBUG_PREEMPT is not set
>  # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
>  # CONFIG_PREEMPT_TIMING is not set
>  # CONFIG_RWSEM_DEADLOCK_DETECT is not set
>  # CONFIG_FRAME_POINTER is not set
>  # CONFIG_DEBUG_STACKOVERFLOW is not set
>  # CONFIG_DEBUG_STACK_USAGE is not set
>  # CONFIG_DEBUG_PAGEALLOC is not set
>
> RWSEM_DEADLOCK, DEBUG_PREEMPT, PREEMPT_TIMING and LATENCY_TRACE are
> especially expensive, so depending on the amount of kernel work done, it
> can make or break the total balance of CPU time used and you could get
> xruns not only due to kernel latencies but purely due to having not
> enough CPU time to generate audio output. (fluidsynth is a software
> audio generator?)
>

As far as nmeter can tell, this a rough cpu usage pattern between RT-U3
and RT-V0.4.3, during my jackd + 6*fluidsynth "benchmark" tests:

  cpu usage                    RT-U3.0    RT-V0.4.3
  ---------------------------- ---------- ---------
  system (kernel)              <10%        10%
  user                          30%        60%
  ---------------------------- ---------- ---------
  total                        <40%        70%


The following table compares the state between my RT-U3 and RT-V0.4.3
configurations, regarding only the mentioned options:

  option                       RT-U3.0    RT-V0.4.3
  ---------------------------- ---------- ---------
  CONFIG_DEBUG_SLAB              n          n
  CONFIG_DEBUG_PREEMPT           y          y
  CONFIG_DEBUG_SPINLOCK_SLEEP    n          -
  CONFIG_PREEMPT_TIMING          n          n
  CONFIG_RWSEM_DEADLOCK_DETECT   -          y
  CONFIG_FRAME_POINTER           y          y
  CONFIG_DEBUG_STACKOVERFLOW     y          y
  CONFIG_DEBUG_STACK_USAGE       n          n
  CONFIG_DEBUG_PAGEALLOC         n          n

(dash "-" means that the option is not available in the config).

As you can see, it can only be CONFIG_RWSEM_DEADLOCK_DETECT, being new in
RT-V0.4.3, that is probably affecting on RT-V0.4.3. I'll try to rebuild
and test all over without it, and see if it gets any better.

BBL
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


