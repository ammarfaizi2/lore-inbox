Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbULIXVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbULIXVS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 18:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbULIXVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 18:21:18 -0500
Received: from mail3.utc.com ([192.249.46.192]:41194 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S261666AbULIXU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 18:20:58 -0500
Message-ID: <41B8DCBF.6070504@cybsft.com>
Date: Thu, 09 Dec 2004 17:16:15 -0600
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
References: <OFADAD8EC1.8BCE1EC6-ON86256F65.005EFFA6@raytheon.com> <20041209173136.GE7975@elte.hu> <41B8B6C4.60200@cybsft.com> <20041209220632.GE14194@elte.hu>
In-Reply-To: <20041209220632.GE14194@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000203030302070101060800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000203030302070101060800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>running realfeel with rtc histogram generates > 100 usec entries in
>>the histogram but none of these are ever caught by the wakeup tracing.
> 
> 
> can you reproduce this with rtc_wakeup:
> 
>   http://www.affenbande.org/~tapas/wiki/index.php?rtc_wakeup
> 
> ?

Yes. See attached files. When I ran rtc_wakeup the priorities were
IRQ 8= 97
IRQ 0= 96
Dropping IRQ 8 (down to 86) below rtc_wakeup kept rtc_wakeup from 
completing any runs.

> 
> 
>>I think I know why we don't get traces from this. TIF_NEED_RESCHED is
>>not set for IRQ 8 at the time that it wakes up realfeel so
>>_need_resched fails and trace_start_sched_wakeup doesn't actually call
>>__trace_start_sched_wakeup(p)???
> 
> 
> here's the code:
> 
> +static inline void trace_start_sched_wakeup(task_t *p, runqueue_t *rq)
> +{
> +       if (TASK_PREEMPTS_CURR(p, rq) && (p != rq->curr) && _need_resched())
> +               __trace_start_sched_wakeup(p);
> +}

I know. I MUST KEEP MY MOUTH SHUT. I MUST KEEP MY MOUTH SHUT. I just 
didn't see how it was possible that either of the other two conditions 
could ever be false in this case and I missed the call to resched_task
> 
> indeed this only triggers if the woken up task has a higher priority
> than the waker... hm. Could you try to reverse the priorities of 
> realfeel and IRQ8, does that produce traces?

I did this and latencies in the histogram dropped drastically. The 
highest latency in the histogram is 33 usecs and thus never gets high 
enough to trigger the tracing???

IRQ 8 = 97
IRQ 0 = 96
realfeel = 98


> 
> 	Ingo
> 


--------------000203030302070101060800
Content-Type: text/plain;
 name="latency_trace.out1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="latency_trace.out1"

preemption latency trace v1.1.4 on 2.6.10-rc2-mm3-V0.7.32-12
--------------------------------------------------------------------
 latency: 46 us, #83/83 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:2)
    -----------------
    | task: su-5646 (uid:500 nice:0 policy:0 rt_prio:0)
    -----------------

                 _------=> CPU#            
                / _-----=> irqs-off        
               | / _----=> hardirq         
               || / _---=> softirq         
               ||| / _--=> preempt-depth   
               |||| /                      
               |||||     delay             
   cmd     pid ||||| time  |   caller      
      \   /    |||||   \   |   /           
    bash-5650  0-h.2    0탎 : __trace_start_sched_wakeup (try_to_wake_up)
    bash-5650  0-h.2    0탎 : _raw_spin_unlock (try_to_wake_up)
    bash-5650  0-h.1    0탎 : preempt_schedule (try_to_wake_up)
    bash-5650  0        1탎 : __wake_up_common <su-5646> (74 75): 
    bash-5650  0-h.1    1탎 : try_to_wake_up (__wake_up_common)
    bash-5650  0-h.1    1탎 : _raw_spin_unlock (try_to_wake_up)
    bash-5650  0-h..    2탎 : preempt_schedule (try_to_wake_up)
    bash-5650  0.h..    2탎 : _spin_unlock_irqrestore (__wake_up_sync)
    bash-5650  0.h..    2탎 : up_mutex (__wake_up_sync)
    bash-5650  0.h..    2탎 : __up_mutex (up_mutex)
    bash-5650  0-h..    3탎 : _raw_spin_lock (__up_mutex)
    bash-5650  0-h.1    3탎 : _raw_spin_lock (__up_mutex)
    bash-5650  0-h.2    3탎 : _raw_spin_lock (__up_mutex)
    bash-5650  0-h.3    3탎 : mutex_getprio (__up_mutex)
    bash-5650  0        4탎 : __up_mutex <bash-5650> (75 75): 
    bash-5650  0-h.3    4탎 : _raw_spin_unlock (__up_mutex)
    bash-5650  0-h.2    4탎 : preempt_schedule (__up_mutex)
    bash-5650  0-h.2    4탎 : _raw_spin_unlock (__up_mutex)
    bash-5650  0-h.1    5탎 : preempt_schedule (__up_mutex)
    bash-5650  0-h.1    5탎 : _raw_spin_unlock (__up_mutex)
    bash-5650  0-h..    5탎 : preempt_schedule (__up_mutex)
    bash-5650  0.h..    5탎 : next_thread (__wake_up_parent)
    bash-5650  0.h..    6탎 : _spin_is_locked (next_thread)
    bash-5650  0.h..    6탎 : rt_mutex_is_locked (next_thread)
    bash-5650  0.h..    6탎 : _spin_unlock_irqrestore (do_notify_parent)
    bash-5650  0.h..    6탎 : up_mutex (do_notify_parent)
    bash-5650  0.h..    7탎 : __up_mutex (up_mutex)
    bash-5650  0-h..    7탎 : _raw_spin_lock (__up_mutex)
    bash-5650  0-h.1    7탎 : _raw_spin_lock (__up_mutex)
    bash-5650  0-h.2    7탎 : _raw_spin_lock (__up_mutex)
    bash-5650  0-h.3    8탎 : mutex_getprio (__up_mutex)
    bash-5650  0        8탎 : __up_mutex <bash-5650> (75 75): 
    bash-5650  0-h.3    8탎 : _raw_spin_unlock (__up_mutex)
    bash-5650  0-h.2    8탎 : preempt_schedule (__up_mutex)
    bash-5650  0-h.2    9탎 : _raw_spin_unlock (__up_mutex)
    bash-5650  0-h.1    9탎 : preempt_schedule (__up_mutex)
    bash-5650  0-h.1    9탎 : _raw_spin_unlock (__up_mutex)
    bash-5650  0-h..   10탎 : preempt_schedule (__up_mutex)
    bash-5650  0.h..   10탎 : _write_unlock_irq (exit_notify)
    bash-5650  0.h..   10탎 : up_write_mutex (exit_notify)
    bash-5650  0.h..   11탎 : __up_mutex (up_write_mutex)
    bash-5650  0-h..   11탎 : _raw_spin_lock (__up_mutex)
    bash-5650  0-h.1   11탎 : _raw_spin_lock (__up_mutex)
    bash-5650  0-h.2   12탎 : _raw_spin_lock (__up_mutex)
    bash-5650  0-h.3   12탎 : mutex_getprio (__up_mutex)
    bash-5650  0       12탎 : __up_mutex <bash-5650> (75 75): 
    bash-5650  0-h.3   12탎 : _raw_spin_unlock (__up_mutex)
    bash-5650  0-h.2   13탎 : preempt_schedule (__up_mutex)
    bash-5650  0-h.2   13탎 : _raw_spin_unlock (__up_mutex)
    bash-5650  0-h.1   13탎 : preempt_schedule (__up_mutex)
    bash-5650  0-h.1   14탎 : _raw_spin_unlock (__up_mutex)
    bash-5650  0-h..   14탎 : preempt_schedule (__up_mutex)
    bash-5650  0.h..   14탎 : check_no_held_locks (do_exit)
    bash-5650  0-h..   15탎+: _raw_spin_lock (check_no_held_locks)
    bash-5650  0-h.1   22탎 : _raw_spin_lock (check_no_held_locks)
    bash-5650  0-h.2   23탎 : _raw_spin_unlock (check_no_held_locks)
    bash-5650  0-h.1   23탎 : preempt_schedule (check_no_held_locks)
    bash-5650  0-h.1   24탎 : _raw_spin_unlock (check_no_held_locks)
    bash-5650  0-h..   24탎 : preempt_schedule (check_no_held_locks)
    bash-5650  0.h..   24탎 : preempt_schedule (do_exit)
    bash-5650  0-h..   25탎 : __schedule (preempt_schedule)
    bash-5650  0-h.1   25탎 : sched_clock (__schedule)
    bash-5650  0-h.1   26탎 : _raw_spin_lock_irq (__schedule)
    bash-5650  0-h.1   26탎 : _raw_spin_lock_irqsave (__schedule)
    bash-5650  0-h.2   27탎 : dequeue_task (__schedule)
    bash-5650  0-h.2   27탎 : recalc_task_prio (__schedule)
    bash-5650  0-h.2   28탎 : effective_prio (recalc_task_prio)
    bash-5650  0-h.2   28탎 : enqueue_task (__schedule)
    bash-5650  0-..2   29탎+: trace_array (__schedule)
    bash-5650  0       33탎 : __schedule <su-5646> (74 78): 
    bash-5650  0       33탎 : __schedule <bash-5650> (75 78): 
    bash-5650  0-..2   34탎+: trace_array (__schedule)
      su-5646  0-..2   41탎 : __switch_to (__schedule)
      su-5646  0       42탎 : schedule <bash-5650> (75 74): 
      su-5646  0-..2   42탎 : finish_task_switch (__schedule)
      su-5646  0-..2   43탎 : _raw_spin_unlock (finish_task_switch)
      su-5646  0-..1   43탎 : trace_stop_sched_switched (finish_task_switch)
      su-5646  0       44탎 : finish_task_switch <su-5646> (74 0): 
      su-5646  0-..1   44탎 : _raw_spin_lock_irqsave (trace_stop_sched_switched)
      su-5646  0-..2   45탎 : trace_stop_sched_switched (finish_task_switch)


vim:ft=help

--------------000203030302070101060800
Content-Type: text/plain;
 name="log.out1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log.out1"

`IRQ 8'[677] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=1
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=1
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=1
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=1
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=1
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=1
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=1
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=1
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=1
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=1
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=1
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=1
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=1
Read missed before next interrupt
`IRQ 8'[677] is being piggy. need_resched=0, cpu=1
Read missed before next interrupt
bug in rtc_read(): called in state S_IDLE!
`IRQ 8'[677] is being piggy. need_resched=0, cpu=1
Read missed before next interrupt

rtc latency histogram of {rtc_wakeup/5775, 320346 samples}:
10 179572
11 98009
12 11054
13 19555
14 5171
15 928
16 1257
17 610
18 638
19 317
20 255
21 585
22 1108
23 375
24 220
25 138
26 113
27 201
28 92
29 19
30 21
31 4
32 3
33 3
34 1
36 2
40 2
41 3
42 2
44 1
45 1
46 1
48 14
49 16
50 9
51 5
52 4
53 1
54 2
56 1
58 1
60 2
62 1
65 1
67 1
147 1
157 1
158 5
159 3
160 6
161 1
162 2
165 1
167 2
168 1
169 1
170 1
172 1
174 1

--------------000203030302070101060800
Content-Type: text/plain;
 name="rtc.out1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtc.out1"

rtc_wakeup - press ctrl-c to stop - use -h to get help
freq:             8192
max # of irqs:    0 (run until stopped)
jitter threshold: 100000% (122070 usec)
output filename:  /dev/null
rt priority:      90(91)
aquiring rt privs
getting cpu speed
929730325.422 Hz (929.730 MHz)
# of cycles for "perfect" period: 113492 (122 usec)
setting up ringbuffer
setting up consumer thread
setting up /dev/rtc
locking memory
turning irq on
beginning measurement
missed 1 irq(s) - not timing last period
new max. jitter: 1.3% (1 usec)
new max. jitter: 2.7% (3 usec)
new max. jitter: 6.4% (7 usec)
new max. jitter: 8.0% (9 usec)
new max. jitter: 9.8% (11 usec)
new max. jitter: 18.8% (22 usec)
new max. jitter: 46.2% (56 usec)
new max. jitter: 68.4% (83 usec)
new max. jitter: 91.0% (111 usec)
new max. jitter: 102.2% (124 usec)
done.
total # of irqs:      320362
missed irqs:          1
threshold violations: 0
max jitter:           102.2% (124 usec)


--------------000203030302070101060800--
