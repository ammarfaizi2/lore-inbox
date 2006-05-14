Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWENHEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWENHEm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 03:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWENHEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 03:04:42 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:31895 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751326AbWENHEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 03:04:41 -0400
From: Darren Hart <dvhltc@us.ibm.com>
Organization: IBM Linux Technology Center
To: Mike Galbraith <efault@gmx.de>
Subject: Re: rt20 scheduling latency testcase and failure data
Date: Sun, 14 May 2006 00:04:29 -0700
User-Agent: KMail/1.9.1
Cc: Lee Revell <rlrevell@joe-job.com>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Florian Schmidt <mista.tapas@gmx.net>
References: <200605121924.53917.dvhltc@us.ibm.com> <1147578414.7738.11.camel@homer> <1147585718.9372.15.camel@homer>
In-Reply-To: <1147585718.9372.15.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605140004.30307.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > On Saturday 13 May 2006 11:21, Lee Revell wrote:
> > If you disable printf + fflush in iterations loop, problem goes away?

Unfortunately not, after disabling the printf and fflush, my very first run 
resulted in:

ITERATION 0
-------------------------------
Scheduling Latency
-------------------------------

Running 10000 iterations with a period of 5 ms
Expected running time: 50 s

ITERATION DELAY(US) MAX_DELAY(US) FAILURES
--------- --------- ------------- --------


PERIOD MISSED!
     scheduled delta:     4078 us
        actual delta:    14213 us
             latency:    10135 us
---------------------------------------
      previous start: 42050139 us
                 now: 42051059 us
     scheduled start: 42045000 us
next scheduled start is in the past!


Start Latency:   99 us: PASS
Min Latency:      8 us: PASS
Avg Latency:      8 us: PASS
Max Latency:   10139 us: FAIL


> P.S.
>
> I think it probably will, because...
>
> sched_latency [ea53a0b0]D 00000001     0  8261   7858                8260
> (NOTLB) e29a0e70 e29a0e58 00000008 00000001 df6158e0 00000000 623266f4
> 0000017d b23d45c4 efd53870 dfcb8dc0 efd53870 00000000 000011e6 ea53a1e8
> ea53a0b0 efdf0d30 b2454560 623e5018 0000017d 00000001 efdf0d30 00000100
> 00000000 Call Trace:
>  [<b1038454>] __rt_mutex_adjust_prio+0x1f/0x24 (112)
>  [<b1038ad8>] task_blocks_on_rt_mutex+0x1b6/0x1c9 (16)
>  [<b13bfeb1>] schedule+0x34/0x10b (24)
>  [<b13c0963>] rt_mutex_slowlock+0xc7/0x258 (28)
>  [<b13c0bb6>] rt_mutex_lock+0x3f/0x43 (100)
>  [<b1039075>] rt_down+0x12/0x32 (20)
>  [<b13c14a7>] lock_kernel+0x1d/0x23 (16)
>  [<b1228246>] tty_write+0x119/0x21b (12)
>  [<b122b758>] write_chan+0x0/0x338 (24)
>  [<b10352bd>] hrtimer_wakeup+0x0/0x1c (20)
>  [<b10671f0>] vfs_write+0xc1/0x19b (24)
>  [<b1067bfa>] sys_write+0x4b/0x74 (40)
>  [<b1002eeb>] sysenter_past_esp+0x54/0x75 (40)
>

What is it about this dump that made you suspect the printf?  Or was it just 
that printing the trace seemed to trigger a failure - so it seemed reasonable 
that the process may have been blocked on writing to the console?  I could 
see that causing a failure like the one below, but not like the one I posted 
above.  (The one above has no printfs between the time measurements 
surrounding the clock_nanosleep() call and it overslept by 10ms).  Also, 
shouldn't I have seen something in the oprofile reports I posted earlier if 
the printf was causing the latencies?

Thanks for the comments, thoughts, and suggestions.

> ...generated via SysRq-T, induces...
>
> PERIOD MISSED!
>      scheduled delta:     4964 us
>         actual delta:     4974 us
>              latency:       10 us
> ---------------------------------------
>       previous start:  1750012 us
>                  now: 13122245 us
>      scheduled start:  1755000 us
> next scheduled start is in the past!

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
