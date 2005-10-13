Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbVJMULw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbVJMULw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 16:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVJMULv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 16:11:51 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:23268 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932453AbVJMULt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 16:11:49 -0400
Subject: Re: sched_clock -> check_tsc_unstable -> tsc_read_c3_time ?!?
From: john stultz <johnstul@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1129233687.16243.52.camel@mindpipe>
References: <1129233687.16243.52.camel@mindpipe>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 13:11:45 -0700
Message-Id: <1129234306.27168.7.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-13 at 16:01 -0400, Lee Revell wrote:
> Looking at the latency traces it appears that sched_clock could be
> optimized a bit:
> 
> evolutio-16296 0D.h4   32us : activate_task (try_to_wake_up)
> evolutio-16296 0D.h4   33us : sched_clock (activate_task)
> evolutio-16296 0D.h4   33us : check_tsc_unstable (sched_clock)
> evolutio-16296 0D.h4   34us : tsc_read_c3_time (sched_clock)
> evolutio-16296 0D.h4   35us : recalc_task_prio (activate_task)
> 
> check_tsc_unstable and tsc_read_c3_time appear to be new.  Here they
> are:
> 
>      49 /* Code to mark and check if the TSC is unstable
>      50  * due to cpufreq or due to unsynced TSCs
>      51  */
>      52 static int tsc_unstable;
>      53 int check_tsc_unstable(void)
>      54 {
>      55         return tsc_unstable;
>      56 }
> 
>      73 u64 tsc_read_c3_time(void)
>      74 {
>      75         return tsc_c3_offset;
>      76 }
> 
> Shouldn't these be inlined or something?  I know it's only a few
> microseconds, but it seems like excessive function call overhead to me.

Yea, you're right about the inlining. Although I'm not sure why those
functions should take microseconds to execute. That's very strange.

> I don't use power management and the TSC is stable on this machine.  Why
> do we have to call these simple accessor functions over and over?

Basically its there to detect if the cpu goes into a low power mode and
halts the TSC. 

They probably could be #defined if C3 really cannot triggered, but some
check will be necessary otherwise.

The arch specific bits in my patches have gotten less of my attention
recently, but hopefully with the arch generic code getting pretty solid
and fast I'll be back to focusing on it.

thanks
-john


