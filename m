Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbVJKAuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbVJKAuj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 20:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVJKAuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 20:50:39 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:8883 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S1751325AbVJKAui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 20:50:38 -0400
Subject: Re: 2.6.14-rc3-rt10 build problem (now rt13)
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, nando@ccrma.Stanford.EDU
In-Reply-To: <1128883124.12370.13.camel@cmn3.stanford.edu>
References: <1128619072.4593.16.camel@cmn3.stanford.edu>
	 <20051007114126.GC857@elte.hu> <1128714933.23974.3.camel@cmn3.stanford.edu>
	 <20051007211654.GA14996@elte.hu>
	 <1128725801.23974.20.camel@cmn3.stanford.edu>
	 <20051007231126.GA17919@elte.hu>
	 <1128824015.5104.6.camel@cmn3.stanford.edu>
	 <20051009043341.GA30878@elte.hu>
	 <1128883124.12370.13.camel@cmn3.stanford.edu>
Content-Type: text/plain
Date: Mon, 10 Oct 2005 17:50:20 -0700
Message-Id: <1128991820.5117.4.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-10-09 at 11:38 -0700, Fernando Lopez-Lezcano wrote: 
> On Sun, 2005-10-09 at 06:33 +0200, Ingo Molnar wrote:
> > * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> > 
> > > This appears to be triggered from Freqtweak (a Jack application):
> > > Oct  8 18:48:00 cmn3 kernel: freqtweak:4705 userspace BUG: scheduling in
> > > user-atomic context!
> > > Oct  8 18:48:00 cmn3 kernel:  [<c037c05b>] schedule+0xeb/0x100 (8)
> > > Oct  8 18:48:00 cmn3 kernel:  [<c037d745>] rwsem_down_read_failed
> > > +0xa5/0x1c0 (28)
> > > Oct  8 18:48:00 cmn3 kernel:  [<c01467ee>] .text.lock.futex+0xa9/0x2db
> > > (52)
> > > Oct  8 18:48:00 cmn3 kernel:  [<c0130c46>] try_to_del_timer_sync
> > > +0x46/0x50 (32)
> > > Oct  8 18:48:00 cmn3 kernel:  [<c0130c71>] del_timer_sync+0x21/0x30 (16)
> > > Oct  8 18:48:00 cmn3 kernel:  [<c0121330>] default_wake_function
> > > +0x0/0x20 (32)
> > > Oct  8 18:48:00 cmn3 kernel:  [<c0151b5c>] audit_syscall_exit+0x4c/0x400
> > > (12)
> > > Oct  8 18:48:00 cmn3 kernel:  [<c0146589>] do_futex+0x69/0xf0 (24)
> > > Oct  8 18:48:00 cmn3 kernel:  [<c0146674>] sys_futex+0x64/0x120 (24)
> > > Oct  8 18:48:00 cmn3 kernel:  [<c0103471>] syscall_call+0x7/0xb (60)
> > 
> > could you enable CONFIG_DEBUG_PREEMPT and send me the same assert (which 
> > will hopefully include a critical section list too).
> 
> I will try to do that tomorrow. 
> 
> I forgot to mention, all this is with the SMP kernel running on a dual
> core Athlon, PREEMPT_DESKTOP and HZ=1000. 

I did not get the same one to repeat, got this instead (see below for
more latency traces):

[<c0104703>] dump_stack+0x23/0x30 (20)
[<c03b2ff5>] schedule+0x105/0x130 (28)
[<c03b31d4>] wait_for_completion+0xa4/0xe0 (48)
[<c0193579>] coredump_wait+0xa9/0xe0 (52)
[<c01936cc>] do_coredump+0x11c/0x2ac (120)
[<c01382c1>] get_signal_to_deliver+0x321/0x340 (44)
[<c010349c>] do_signal+0x5c/0x130 (188)
[<c01035a0>] do_notify_resume+0x30/0x40 (12)
[<c01037ac>] work_notifysig+0x13/0x1b (-8116)
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

( softirq-timer/0-4    |#0): new 6 us maximum-latency wakeup.
( softirq-timer/0-4    |#0): new 11 us maximum-latency wakeup.
(  gnome-terminal-4657 |#1): new 519 us maximum-latency wakeup.
(       kjournald-444  |#1): new 2295 us maximum-latency wakeup.
( softirq-timer/1-13   |#1): new 3014 us maximum-latency wakeup.
(               X-4463 |#1): new 7458 us maximum-latency wakeup.
(               X-4463 |#1): new 18489 us maximum-latency wakeup.
( softirq-timer/1-13   |#1): new 36000 us maximum-latency wakeup.

These are the RT processes and their priorities, upping the
softirq-timer processes priority does not seem to make any difference:
   12  41      1 [softirq-high/1]
   13  41      1 [softirq-timer/1]
   14  41      1 [softirq-net-tx/]
   15  41      1 [softirq-net-rx/]
   16  41      1 [softirq-scsi/1]
   17  41      1 [softirq-tasklet]
   20  41      1 [events/0]
   21  41      1 [events/1]
    3  41      1 [softirq-high/0]
    4  41      1 [softirq-timer/0]
    5  41      1 [softirq-net-tx/]
    6  41      1 [softirq-net-rx/]
    7  41      1 [softirq-scsi/0]
    8  41      1 [softirq-tasklet]
4495  74     34 [IRQ 225]
4022  75     35 [IRQ 7]
3997  76     36 [IRQ 3]
3996  77     37 [IRQ 4]
  962  81     41 [IRQ 193]
  936  82     42 [IRQ 6]
  414  84     44 [IRQ 177]
  352  86     46 [IRQ 14]
   27  89     49 [IRQ 9]
  319  89     49 [IRQ 12]
  384  90     50 [IRQ 1]
1222  99     59 [IRQ 217]
  427 100     60 [IRQ 185]
1062 109     69 [IRQ 209]
1049 110     70 [IRQ 201]
  301 120     80 [IRQ 8]
   11 139     99 [migration/1]
   18 139     99 [watchdog/1]
    2 139     99 [migration/0]
    9 139     99 [watchdog/0]

# cat /proc/interrupts
           CPU0       CPU1
  0:       6882    1191382  IO-APIC-edge   [........N/  0]  timer
  1:          6       1705  IO-APIC-edge   [........./  0]  i8042
  7:          2          1  IO-APIC-edge   [..P....../  0]  parport0
  8:          0          1  IO-APIC-edge   [........N/  0]  rtc
  9:          0          0  IO-APIC-level  [........./  0]  acpi
12:        581      68040  IO-APIC-edge   [........./  1]  i8042
14:         84      10711  IO-APIC-edge   [........./  0]  ide0
177:          0          0  IO-APIC-level  [........./  0]  libata
185:        107      25623  IO-APIC-level  [........./  0]  libata,
ehci_hcd:usb1
193:       6238     484611  IO-APIC-level  [........./  0]  SysKonnect
SK-98xx
201:       5159     773150  IO-APIC-level  [........N/  0]  ICE1712,
ohci1394
209:          0          0  IO-APIC-level  [........N/  0]  NVidia CK8S,
ohci_hcd:usb2
217:          0          0  IO-APIC-level  [........./  0]
ohci_hcd:usb3
225:        506      67236  IO-APIC-level  [........./  1]
radeon@pci:0000:01:00.0
NMI:          0          0
LOC:    1197825    1197903
ERR:          1
MIS:          0

-- Fernando


----

preemption latency trace v1.1.5 on 2.6.13-0.7.rdtd.rhfc4.ccrmasmp
--------------------------------------------------------------------
 latency: 40968 us, #20/20, CPU#1 | (M:preempt VP:0, KP:0, SP:1 HP:1
#P:2)
    -----------------
    | task: jackd-4735 (uid:743 nice:0 policy:1 rt_prio:62)
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
  ardour-4871  1....    0us : _raw_spin_lock_irqsave (remove_wait_queue)
  ardour-4871  1Dn.1    0us : _raw_spin_unlock_irqrestore
(remove_wait_queue)
  ardour-4871  1Dn..    1us : smp_reschedule_interrupt (c03b5540 0 0)
  ardour-4871  1Dn..    2us : preempt_schedule_irq (need_resched)
  ardour-4871  1Dn..    2us : __schedule (preempt_schedule_irq)
  ardour-4871  1Dn..    3us : profile_hit (__schedule)
  ardour-4871  1Dn.1    3us : sched_clock (__schedule)
  ardour-4871  1Dn.1    3us : check_tsc_unstable (sched_clock)
  ardour-4871  1Dn.1    4us : tsc_read_c3_time (sched_clock)
  ardour-4871  1Dn.1    4us : _raw_spin_lock_irq (__schedule)
  ardour-4871  1Dn.1    5us : _raw_spin_lock_irqsave
(_raw_spin_lock_irq)
  ardour-4871  1Dn.2    5us : dependent_sleeper (__schedule)
   <...>-4735  1D..2    6us : __switch_to (__schedule)
   <...>-4735  1D..2    6us : __schedule <ardour-4871> (73 25)
   <...>-4735  1D..2    6us : _raw_spin_unlock_irq (__schedule)
   <...>-4735  1...1    7us : trace_stop_sched_switched (__schedule)
   <...>-4735  1D..1    7us : _raw_spin_lock (trace_stop_sched_switched)
   <...>-4735  1D..2    7us : trace_stop_sched_switched <<...>-4735> (25
1)
   <...>-4735  1D..2    7us : trace_stop_sched_switched (__schedule)


vim:ft=help

----

preemption latency trace v1.1.5 on 2.6.13-0.7.rdtd.rhfc4.ccrmasmp
--------------------------------------------------------------------
 latency: 1008 us, #21/21, CPU#0 | (M:preempt VP:0, KP:0, SP:1 HP:1
#P:2)
    -----------------
    | task: softirq-timer/0-4 (uid:0 nice:0 policy:1 rt_prio:1)
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
hydrogen-4887  0.n.1    0us : trace_stop_sched_switched (__schedule)
hydrogen-4887  0Dn.1    0us : _raw_spin_lock (trace_stop_sched_switched)
hydrogen-4887  0Dn.2    0us : trace_stop_sched_switched <<...>-4> (62
74)
hydrogen-4887  0Dn.2    0us : _raw_spin_unlock
(trace_stop_sched_switched)
hydrogen-4887  0Dn.1    0us : preempt_schedule (_raw_spin_unlock)
hydrogen-4887  0.n..    1us : __schedule (schedule)
hydrogen-4887  0.n..    1us : profile_hit (__schedule)
hydrogen-4887  0.n.1    1us : sched_clock (__schedule)
hydrogen-4887  0.n.1    2us : check_tsc_unstable (sched_clock)
hydrogen-4887  0.n.1    2us : tsc_read_c3_time (sched_clock)
hydrogen-4887  0.n.1    2us : _raw_spin_lock_irq (__schedule)
hydrogen-4887  0.n.1    2us : _raw_spin_lock_irqsave
(_raw_spin_lock_irq)
hydrogen-4887  0Dn.2    3us : dependent_sleeper (__schedule)
   <...>-4     0D..2    3us : __switch_to (__schedule)
   <...>-4     0D..2    3us : __schedule <hydrogen-4887> (74 62)
   <...>-4     0D..2    4us : _raw_spin_unlock_irq (__schedule)
   <...>-4     0...1    4us : trace_stop_sched_switched (__schedule)
   <...>-4     0D..1    4us : _raw_spin_lock (trace_stop_sched_switched)
   <...>-4     0D..2    4us : trace_stop_sched_switched <<...>-4> (62 0)
   <...>-4     0D..2    5us : trace_stop_sched_switched (__schedule)


vim:ft=help

----

preemption latency trace v1.1.5 on 2.6.13-0.7.rdtd.rhfc4.ccrmasmp
--------------------------------------------------------------------
 latency: 1978 us, #18/18, CPU#1 | (M:preempt VP:0, KP:0, SP:1 HP:1
#P:2)
    -----------------
    | task: softirq-timer/1-13 (uid:0 nice:0 policy:1 rt_prio:1)
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
multiloa-4679  1.n.1    0us : _raw_spin_unlock (audit_syscall_exit)
multiloa-4679  1.n..    0us : preempt_schedule (_raw_spin_unlock)
multiloa-4679  1Dn..    0us : __schedule (preempt_schedule)
multiloa-4679  1Dn..    0us : profile_hit (__schedule)
multiloa-4679  1Dn.1    0us : sched_clock (__schedule)
multiloa-4679  1Dn.1    1us : check_tsc_unstable (sched_clock)
multiloa-4679  1Dn.1    1us : tsc_read_c3_time (sched_clock)
multiloa-4679  1Dn.1    1us : _raw_spin_lock_irq (__schedule)
multiloa-4679  1Dn.1    1us : _raw_spin_lock_irqsave
(_raw_spin_lock_irq)
multiloa-4679  1Dn.2    1us : dependent_sleeper (__schedule)
   <...>-13    1D..2    2us : __switch_to (__schedule)
   <...>-13    1D..2    2us : __schedule <multiloa-4679> (73 62)
   <...>-13    1D..2    2us : _raw_spin_unlock_irq (__schedule)
   <...>-13    1...1    2us : trace_stop_sched_switched (__schedule)
   <...>-13    1D..1    2us : _raw_spin_lock (trace_stop_sched_switched)
   <...>-13    1D..2    3us : trace_stop_sched_switched <<...>-13> (62
1)
   <...>-13    1D..2    3us : trace_stop_sched_switched (__schedule)


vim:ft=help

----

preemption latency trace v1.1.5 on 2.6.13-0.7.rdtd.rhfc4.ccrmasmp
--------------------------------------------------------------------
 latency: 741 us, #21/21, CPU#0 | (M:preempt VP:0, KP:0, SP:1 HP:1 #P:2)
    -----------------
    | task: IRQ 225-4495 (uid:0 nice:-5 policy:1 rt_prio:34)
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
       X-4463  0....    0us : poll_freewait (do_select)
       X-4463  0....    0us : __might_sleep (sys_select)
       X-4463  0.n..    0us : __copy_to_user_ll (sys_select)
       X-4463  0Dn..    1us : smp_reschedule_interrupt (c021aae4 0 0)
       X-4463  0Dn..    1us : preempt_schedule_irq (need_resched)
       X-4463  0Dn..    1us : __schedule (preempt_schedule_irq)
       X-4463  0Dn..    1us : profile_hit (__schedule)
       X-4463  0Dn.1    1us : sched_clock (__schedule)
       X-4463  0Dn.1    2us : check_tsc_unstable (sched_clock)
       X-4463  0Dn.1    2us : tsc_read_c3_time (sched_clock)
       X-4463  0Dn.1    2us : _raw_spin_lock_irq (__schedule)
       X-4463  0Dn.1    2us : _raw_spin_lock_irqsave
(_raw_spin_lock_irq)
       X-4463  0Dn.2    2us : dependent_sleeper (__schedule)
   <...>-4495  0D..2    3us : __switch_to (__schedule)
   <...>-4495  0D..2    3us : __schedule <X-4463> (74 41)
   <...>-4495  0D..2    3us : _raw_spin_unlock_irq (__schedule)
   <...>-4495  0...1    3us : trace_stop_sched_switched (__schedule)
   <...>-4495  0D..1    4us : _raw_spin_lock (trace_stop_sched_switched)
   <...>-4495  0D..2    4us : trace_stop_sched_switched <<...>-4495> (41
0)
   <...>-4495  0D..2    4us : trace_stop_sched_switched (__schedule)


vim:ft=help

----

preemption latency trace v1.1.5 on 2.6.13-0.7.rdtd.rhfc4.ccrmasmp
--------------------------------------------------------------------
 latency: 741 us, #21/21, CPU#0 | (M:preempt VP:0, KP:0, SP:1 HP:1 #P:2)
    -----------------
    | task: IRQ 225-4495 (uid:0 nice:-5 policy:1 rt_prio:34)
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
       X-4463  0....    0us : poll_freewait (do_select)
       X-4463  0....    0us : __might_sleep (sys_select)
       X-4463  0.n..    0us : __copy_to_user_ll (sys_select)
       X-4463  0Dn..    1us : smp_reschedule_interrupt (c021aae4 0 0)
       X-4463  0Dn..    1us : preempt_schedule_irq (need_resched)
       X-4463  0Dn..    1us : __schedule (preempt_schedule_irq)
       X-4463  0Dn..    1us : profile_hit (__schedule)
       X-4463  0Dn.1    1us : sched_clock (__schedule)
       X-4463  0Dn.1    2us : check_tsc_unstable (sched_clock)
       X-4463  0Dn.1    2us : tsc_read_c3_time (sched_clock)
       X-4463  0Dn.1    2us : _raw_spin_lock_irq (__schedule)
       X-4463  0Dn.1    2us : _raw_spin_lock_irqsave
(_raw_spin_lock_irq)
       X-4463  0Dn.2    2us : dependent_sleeper (__schedule)
   <...>-4495  0D..2    3us : __switch_to (__schedule)
   <...>-4495  0D..2    3us : __schedule <X-4463> (74 41)
   <...>-4495  0D..2    3us : _raw_spin_unlock_irq (__schedule)
   <...>-4495  0...1    3us : trace_stop_sched_switched (__schedule)
   <...>-4495  0D..1    4us : _raw_spin_lock (trace_stop_sched_switched)
   <...>-4495  0D..2    4us : trace_stop_sched_switched <<...>-4495> (41
0)
   <...>-4495  0D..2    4us : trace_stop_sched_switched (__schedule)


vim:ft=help

----

preemption latency trace v1.1.5 on 2.6.13-0.7.rdtd.rhfc4.ccrmasmp
--------------------------------------------------------------------
 latency: 1004 us, #18/18, CPU#0 | (M:preempt VP:0, KP:0, SP:1 HP:1
#P:2)
    -----------------
    | task: softirq-timer/0-4 (uid:0 nice:0 policy:1 rt_prio:1)
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
multiloa-4679  0.n.1    0us : _raw_spin_unlock (new_inode)
multiloa-4679  0.n..    0us : preempt_schedule (_raw_spin_unlock)
multiloa-4679  0Dn..    0us : __schedule (preempt_schedule)
multiloa-4679  0Dn..    0us : profile_hit (__schedule)
multiloa-4679  0Dn.1    0us : sched_clock (__schedule)
multiloa-4679  0Dn.1    0us : check_tsc_unstable (sched_clock)
multiloa-4679  0Dn.1    0us : tsc_read_c3_time (sched_clock)
multiloa-4679  0Dn.1    0us : _raw_spin_lock_irq (__schedule)
multiloa-4679  0Dn.1    1us : _raw_spin_lock_irqsave
(_raw_spin_lock_irq)
multiloa-4679  0Dn.2    1us : dependent_sleeper (__schedule)
   <...>-4     0D..2    2us : __switch_to (__schedule)
   <...>-4     0D..2    2us : __schedule <multiloa-4679> (73 62)
   <...>-4     0D..2    2us : _raw_spin_unlock_irq (__schedule)
   <...>-4     0...1    2us : trace_stop_sched_switched (__schedule)
   <...>-4     0D..1    2us : _raw_spin_lock (trace_stop_sched_switched)
   <...>-4     0D..2    2us : trace_stop_sched_switched <<...>-4> (62 0)
   <...>-4     0D..2    3us : trace_stop_sched_switched (__schedule)


vim:ft=help

----

preemption latency trace v1.1.5 on 2.6.13-0.7.rdtd.rhfc4.ccrmasmp
--------------------------------------------------------------------
 latency: 1657 us, #21/21, CPU#0 | (M:preempt VP:0, KP:0, SP:1 HP:1
#P:2)
    -----------------
    | task: IRQ 12-319 (uid:0 nice:-5 policy:1 rt_prio:49)
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
       X-4463  0....    0us : avc_audit (avc_has_perm)
       X-4463  0.n..    0us : unix_stream_recvmsg (sock_aio_read)
       X-4463  0.n..    0us : __might_sleep (unix_stream_recvmsg)
       X-4463  0Dn..    1us : smp_reschedule_interrupt (c0149d7f 0 0)
       X-4463  0Dn..    1us : preempt_schedule_irq (need_resched)
       X-4463  0Dn..    1us : __schedule (preempt_schedule_irq)
       X-4463  0Dn..    1us : profile_hit (__schedule)
       X-4463  0Dn.1    1us : sched_clock (__schedule)
       X-4463  0Dn.1    1us : check_tsc_unstable (sched_clock)
       X-4463  0Dn.1    2us : tsc_read_c3_time (sched_clock)
       X-4463  0Dn.1    2us : _raw_spin_lock_irq (__schedule)
       X-4463  0Dn.1    2us : _raw_spin_lock_irqsave
(_raw_spin_lock_irq)
       X-4463  0Dn.2    2us : dependent_sleeper (__schedule)
   <...>-319   0D..2    3us : __switch_to (__schedule)
   <...>-319   0D..2    3us : __schedule <X-4463> (74 32)
   <...>-319   0D..2    3us : _raw_spin_unlock_irq (__schedule)
   <...>-319   0...1    3us : trace_stop_sched_switched (__schedule)
   <...>-319   0D..1    3us : _raw_spin_lock (trace_stop_sched_switched)
   <...>-319   0D..2    4us : trace_stop_sched_switched <<...>-319> (32
0)
   <...>-319   0D..2    4us : trace_stop_sched_switched (__schedule)


vim:ft=help

----

preemption latency trace v1.1.5 on 2.6.13-0.7.rdtd.rhfc4.ccrmasmp
--------------------------------------------------------------------
 latency: 2140 us, #21/21, CPU#0 | (M:preempt VP:0, KP:0, SP:1 HP:1
#P:2)
    -----------------
    | task: IRQ 12-319 (uid:0 nice:-5 policy:1 rt_prio:49)
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
       X-4463  0D..1    0us : _raw_spin_unlock_irqrestore
(tty_ldisc_try)
       X-4463  0....    0us : normal_poll (tty_poll)
       X-4463  0.n..    0us : __pollwait (normal_poll)
       X-4463  0Dn..    1us : smp_reschedule_interrupt (c019bf66 0 0)
       X-4463  0Dn..    1us : preempt_schedule_irq (need_resched)
       X-4463  0Dn..    1us : __schedule (preempt_schedule_irq)
       X-4463  0Dn..    1us : profile_hit (__schedule)
       X-4463  0Dn.1    1us : sched_clock (__schedule)
       X-4463  0Dn.1    1us : check_tsc_unstable (sched_clock)
       X-4463  0Dn.1    2us : tsc_read_c3_time (sched_clock)
       X-4463  0Dn.1    2us : _raw_spin_lock_irq (__schedule)
       X-4463  0Dn.1    2us : _raw_spin_lock_irqsave
(_raw_spin_lock_irq)
       X-4463  0Dn.2    2us : dependent_sleeper (__schedule)
   <...>-319   0D..2    3us : __switch_to (__schedule)
   <...>-319   0D..2    3us : __schedule <X-4463> (74 32)
   <...>-319   0D..2    4us : _raw_spin_unlock_irq (__schedule)
   <...>-319   0...1    4us : trace_stop_sched_switched (__schedule)
   <...>-319   0D..1    4us : _raw_spin_lock (trace_stop_sched_switched)
   <...>-319   0D..2    4us : trace_stop_sched_switched <<...>-319> (32
0)
   <...>-319   0D..2    5us : trace_stop_sched_switched (__schedule)


vim:ft=help

----

