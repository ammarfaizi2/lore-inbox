Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261335AbSI3Vl1>; Mon, 30 Sep 2002 17:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261342AbSI3Vl1>; Mon, 30 Sep 2002 17:41:27 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47097 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261335AbSI3Vl0>;
	Mon, 30 Sep 2002 17:41:26 -0400
Message-ID: <3D98C60B.9C1EA90B@mvista.com>
Date: Mon, 30 Sep 2002 14:45:47 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
References: <Pine.LNX.4.44.0209291927400.15706-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> the attached patch is the smptimers patch plus the removal of old BHs and
> a rewrite of task-queue handling.
> 
~snip
> 
> scalable timers: i've further improved the patch ported to 2.5 by wli and
> Dipankar. There is only one pending issue i can see, the question of
> whether to migrate timers in mod_timer() or not. I'm quite convinced that
> they should be migrated, but i might be wrong. It's a 10 lines change to
> switch between migrating and non-migrating timers, we can do performance
> tests later on. The current, more complex migration code is pretty fast
> and has been stable under extremely high networking loads in the past 2
> years, so we can immediately switch to the simpler variant if someone
> proves it improves performance. (I'd say if non-migrating timers improve
> Apache performance on one of the bigger NUMA boxes then the point is
> proven, no further though will be needed.)

As the APIC timers are currently set up they are
undisciplined WRT the PIT which is still used to drive the
clock.  This means that, since this patch drives the
"run_timer_list" code from the APIC timers, the actual delay
in timer servicing from the requested time will vary with
a.) the cpu (since each cpu is set up to have its timer
expire at a different time within the 1/HZ tick) and b.)
over time as the PIT and the APIC clocks drift.  This may be
acceptable with 1/HZ timer resolution (however I don't
really think it is), but it is in no way acceptable WRT high
resolution timers.

The solution I would suggest is to disciplined the APIC
clocks.  They _should_ be set up to interrupt as soon after
a PIT interrupt as possible and they should all do so at the
same time if we are to avoid timer (not time, actual time
keeping is not in question here) glitches when moving from
one cpu to another.  Further, checks for drift need to be in
place to "pull" the APIC timer into sync when it drifts.

I had similar problems in the high-res-timers keeping the
PIT synched with the TSC or the pm timer.  It is do able.
> 
~snip
> 
>         Ingo

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
