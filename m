Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWEVPlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWEVPlK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 11:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWEVPlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 11:41:10 -0400
Received: from odin2.bull.net ([129.184.85.11]:27049 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S1750712AbWEVPlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 11:41:09 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: RT patch + LTTng
Date: Mon, 22 May 2006 17:42:28 +0200
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605221742.29566.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I have added the LTTng patch to the 2.6.16-rt23.
In the LTT trace, I see some odd time stamps :

First case :

...
process.schedchange: 12.800681016 (/cpu_1), 7667, lttctl, 0, 0x0, MODE_UNKNOWN { 17, 7667, 2 }
socket.call: 12.800685053 (/cpu_1), 7667, lttctl, 0, 0x0, MODE_UNKNOWN { 11, 3 }
socket.sendmsg: 12.800687153 (/cpu_1), 7667, lttctl, 0, 0x0, MODE_UNKNOWN { 0xf3b78b80, 16, 3, 31, 288 }
>The pb is effectively on the next line : we skip from 12.800687153 to 13.397691687
>0,597 seconde ??? 
core.time_heartbeat: 13.397691687 (/control/facilities_1), 7667, lttctl, 0, 0x0, MODE_UNKNOWN
core.time_heartbeat: 13.397691979 (/control/facilities_0), 7662, lttd, 7660, 0x0, USER_MODE
core.time_heartbeat: 13.397694936 (/control/interrupts_0), 7662, lttd, 7660, 0x0, USER_MODE
...

Second case :

...
process.schedchange: 4.062674969 (/cpu_1), 0, UNNAMED, 0, 0x0, SYSCALL { 17, 0, 2 }
process.wakeup: 4.062733369 (/cpu_0), 7538, lttd, 1, 0x0, USER_MODE { 5, 2 }
process.wakeup: 4.062738209 (/cpu_0), 7538, lttd, 1, 0x0, USER_MODE { 3, 2 }
process.schedchange: 4.062746308 (/cpu_0), 3, posix_cpu_timer, 1, 0x0, SYSCALL { 7538, 3, 0 }
process.schedchange: 4.062751787 (/cpu_0), 5, softirq-timer/0, 1, 0x0, SYSCALL { 3, 5, 2 }
timer.softirq: 4.062753184 (/cpu_0), 5, softirq-timer/0, 1, 0x0, SYSCALL
process.schedchange: 4.062759716 (/cpu_0), 7538, lttd, 1, 0x0, USER_MODE { 5, 7538, 2 }
>====================== Problem On the following lines
>573us between 4.062759716 and 4.063493275
kernel.trap_entry: 4.063493275 (/cpu_1), 0, UNNAMED, 0, 0x0, TRAP { 2, 0xc0101329 }
kernel.trap_exit: 4.063494252 (/cpu_1), 0, UNNAMED, 0, 0x0, SYSCALL
kernel.trap_entry: 4.063494624 (/cpu_0), 7538, lttd, 1, 0x0, TRAP { 2, 0xc032e8b9 }
kernel.trap_exit: 4.063495799 (/cpu_0), 7538, lttd, 1, 0x0, USER_MODE
kernel.irq_entry: 4.063497194 (/cpu_0), 7538, lttd, 1, 0x0, IRQ { 0, kernel }
kernel.irq_exit: 4.063500254 (/cpu_0), 7538, lttd, 1, 0x0, USER_MODE
process.wakeup: 4.063644762 (/cpu_1), 0, UNNAMED, 0, 0x0, SYSCALL { 17, 2 }
...

My questions are :
What could explains these gaps :
NMI ?
ACPI ?
clock synchronization between CPU ?
other cause ?

There is no big latencies :
-sh-2.05b# cat /proc/latency_trace
preemption latency trace v1.1.5 on 2.6.16-DAV07_ltt
--------------------------------------------------------------------
 latency: 93 us, #240/240, CPU#0 | (M:rt VP:0, KP:0, SP:1 HP:1 #P:2)
    -----------------
    | task: posix_cpu_timer-3 (uid:0 nice:0 policy:1 rt_prio:99)
    -----------------

                 _------=> CPU#            
                / _-----=> irqs-off        
               | / _----=> need-resched    
               || / _---=> hardirq/softirq 
               ||| / _--=> preempt-depth   
               |||| /                      
               |||||     delay             
   cmd     pid ||||| time  |   caller      
      \   /    |||||   \   |   /           
ltt_stat-7809  0Dnh3    0us : __trace_start_sched_wakeup (try_to_wake_up)
ltt_stat-7809  0Dnh3    0us : __trace_start_sched_wakeup <<...>-3> (0 0)
ltt_stat-7809  0Dnh3    0us : _raw_spin_unlock (__trace_start_sched_wakeup)
ltt_stat-7809  0Dnh2    1us : preempt_schedule (_raw_spin_unlock)
ltt_stat-7809  0Dnh2    1us : resched_task (try_to_wake_up)
ltt_stat-7809  0Dnh2    1us : try_to_wake_up <<...>-3> (199 -8)
ltt_stat-7809  0Dnh2    1us : _raw_spin_unlock_irqrestore (try_to_wake_up)
ltt_stat-7809  0Dnh1    1us : preempt_schedule (_raw_spin_unlock_irqrestore)
ltt_stat-7809  0Dnh1    1us : wake_up_process (run_posix_cpu_timers)
ltt_stat-7809  0Dnh1    2us : irq_exit (smp_apic_timer_interrupt)
ltt_stat-7809  0.n.1    2us : ltt_heartbeat_read_synthetic_tsc (ltt_statedump_thread)
...
ltt_stat-7809  0.n.1   81us : ltt_heartbeat_read_synthetic_tsc (ltt_statedump_thread)
ltt_stat-7809  0.n.1   81us : preempt_schedule (ltt_heartbeat_read_synthetic_tsc)
ltt_stat-7809  0.n.1   82us : ltt_heartbeat_read_synthetic_tsc (ltt_statedump_thread)
ltt_stat-7809  0.n.1   82us : preempt_schedule (ltt_heartbeat_read_synthetic_tsc)
ltt_stat-7809  0.n.1   82us : ltt_heartbeat_read_synthetic_tsc (ltt_statedump_thread)
ltt_stat-7809  0.n.1   83us : preempt_schedule (ltt_heartbeat_read_synthetic_tsc)
ltt_stat-7809  0.n.1   83us : ltt_heartbeat_read_synthetic_tsc (ltt_statedump_thread)
ltt_stat-7809  0.n.1   83us : preempt_schedule (ltt_heartbeat_read_synthetic_tsc)
ltt_stat-7809  0.n..   84us : rt_up_read (ltt_statedump_thread)
ltt_stat-7809  0.n..   84us : _raw_spin_lock_irqsave (rt_up_read)
ltt_stat-7809  0Dn.1   84us : _raw_spin_unlock_irqrestore (rt_up_read)
ltt_stat-7809  0.n..   85us : preempt_schedule (_raw_spin_unlock_irqrestore)
ltt_stat-7809  0Dn..   85us : __schedule (preempt_schedule)
ltt_stat-7809  0Dn..   85us : profile_hit (__schedule)
ltt_stat-7809  0Dn.1   85us : sched_clock (__schedule)
ltt_stat-7809  0Dn.1   86us : _raw_spin_lock_irq (__schedule)
ltt_stat-7809  0Dn.2   86us : balance_rt_tasks (__schedule)
ltt_stat-7809  0Dn.2   86us : find_next_bit (balance_rt_tasks)
ltt_stat-7809  0Dn.2   86us : find_next_bit (balance_rt_tasks)
ltt_stat-7809  0D..2   87us : trace_array (__schedule)
ltt_stat-7809  0D..2   87us : trace_array <<...>-3> (0 199)
ltt_stat-7809  0D..2   88us : trace_array <<...>-5> (98 101)
ltt_stat-7809  0D..2   89us : trace_array <ltt_stat-7809> (112 -8)
ltt_stat-7809  0D..2   89us : trace_array <<...>-7806> (118 -2)
ltt_stat-7809  0D..2   89us : trace_array (__schedule)
ltt_stat-7809  0D..2   90us : sched_info_arrive (__schedule)
ltt_stat-7809  0D..3   91us : ltt_heartbeat_read_synthetic_tsc (__schedule)
   <...>-3     0D..2   91us : __switch_to (__schedule)
   <...>-3     0D..2   92us : __schedule <ltt_stat-7809> (-8 199)
   <...>-3     0D..2   92us : _raw_spin_unlock_irq (__schedule)
   <...>-3     0...1   92us : trace_stop_sched_switched (__schedule)
   <...>-3     0D..1   93us : _raw_spin_lock (trace_stop_sched_switched)
   <...>-3     0D..2   93us : trace_stop_sched_switched <<...>-3> (0 0)
   <...>-3     0D..2   93us : trace_stop_sched_switched (__schedule)


I don't use CPU FREQ :
-sh-2.05b# zgrep   CPU_FREQ    /proc/config.gz 
# CONFIG_CPU_FREQ is not set
-sh-2.05b#


-- 
Serge Noiraud
