Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937190AbWLEATr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937190AbWLEATr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 19:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937194AbWLEATr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 19:19:47 -0500
Received: from mout0.freenet.de ([194.97.50.131]:49595 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937190AbWLEATo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 19:19:44 -0500
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.19-rt1, yum/rpm
Date: Tue, 5 Dec 2006 01:19:58 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061130083358.GA351@elte.hu>
In-Reply-To: <20061130083358.GA351@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200612050119.59113.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 30. November 2006 09:33 schrieb Ingo Molnar:
> i have released the 2.6.19-rt1 tree, which can be downloaded from the

Hi Ingo,

here comes a freerunning trace explaining the weirdness I see here.
I tried max_latency tracing first, didn't see anything usefull,
went on with tracing freerunning with a user_trace_stop() at the spot,
where snd-usb-usx2y diagnoses hickup.

I tweaked latency_trace.c to make freerunning work. Will post later.

To get an overview of whats happening, search in this e-mail for
	i_usX2Y_usbpcm_urb_complete
. Its the interrupt callback.


Those were the rt priorities with IRQ 17 driving the usb soundcard:
$ ps -ALc|grep FF

    2     2 FF   90 ?        00:00:00 posix_cpu_timer
    3     3 FF   41 ?        00:00:00 softirq-high/0
    4     4 FF   41 ?        00:00:00 softirq-timer/0
    5     5 FF   41 ?        00:00:00 softirq-net-tx/
    6     6 FF   41 ?        00:00:00 softirq-net-rx/
    7     7 FF   41 ?        00:00:00 softirq-block/0
    8     8 FF   41 ?        00:00:06 softirq-tasklet
    9     9 FF   41 ?        00:00:00 softirq-hrtimer
   10    10 FF   41 ?        00:00:00 softirq-rcu/0
   11    11 FF  139 ?        00:00:00 watchdog/0
   13    13 FF   41 ?        00:00:00 events/0
   50    50 FF   89 ?        00:00:00 IRQ 9
  242   242 FF   88 ?        00:00:00 IRQ 8
  273   273 FF   87 ?        00:00:00 IRQ 14
  275   275 FF   86 ?        00:00:00 IRQ 15
  295   295 FF   85 ?        00:00:00 IRQ 12
  296   296 FF   84 ?        00:00:00 IRQ 1
  308   308 FF  120 ?        00:00:30 IRQ 17
  735   735 FF  110 ?        00:00:00 IRQ 19
 1329  1329 FF   81 ?        00:00:00 IRQ 6
 1338  1338 FF   80 ?        00:00:00 IRQ 7
 1684  1684 FF  110 ?        00:00:06 IRQ 18
 2198  2198 FF   78 ?        00:00:00 IRQ 4
 2667  2672 FF   49 pts/0    00:00:00 ardour.bin
 2700  2700 FF   90 ?        00:00:00 artsd

$ cat /proc/interrupts
           CPU0
  0:    1477957  IO-APIC        [........N/  0]-edge      timer
  1:       7560  IO-APIC        [.......M./  0]-edge      i8042
  4:         12  IO-APIC        [.......M./  3]-edge      serial
  7:          0  IO-APIC        [..P....M./  0]-edge      parport0
  8:          1  IO-APIC        [........./  0]-edge      rtc
  9:          0  IO-APIC        [........./  0]-fasteoi   acpi
 12:      62839  IO-APIC        [.......M./  0]-edge      i8042
 14:      22303  IO-APIC        [.......M./  0]-edge      ide0
 15:      10169  IO-APIC        [.......M./  0]-edge      ide1
 17:     967826  IO-APIC        [........./  0]-fasteoi   uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb4, ehci_hcd:usb5
 18:     247356  IO-APIC        [........./  1]-fasteoi   eth0, nvidia
 19:        979  IO-APIC        [........./  0]-fasteoi   VIA8237
NMI:          0
LOC:        834
ERR:          0
MIS:          0



Edited Trace, first part showing normal operation,
second part showing things getting weired:

<trace first part>
preemption latency trace v1.1.5 on 2.6.19-rt1.dbg
--------------------------------------------------------------------
 latency: 491583660 us, #131071/131071, CPU#0 | (M:rt VP:0, KP:0, SP:1 HP:1)
    -----------------
    | task: IRQ 17-308 (uid:0 nice:-5 policy:1 rt_prio:80)
    -----------------
 => started at: snd_usX2Y_pcm_trigger+0x30/0xf4 <f89d9ff8>
 => ended at:   __schedule+0x680/0x70e <c032a74c>

                 _------=> CPU#            
                / _-----=> irqs-off        
               | / _----=> need-resched    
               || / _---=> hardirq/softirq 
               ||| / _--=> preempt-depth   
               |||| /                      
               |||||     delay             
   cmd     pid ||||| time  |   caller      
      \   /    |||||   \   |   /           
qjackctl-2668  0D...    0us < (0)
qjackctl-2668  0....    0us > sys_gettimeofday (b7212324 00000000 0000007b)
qjackctl-2668  0D...    2us < (0)
qjackctl-2668  0....    2us > sys_write (00000010 b721338a 0000007b)
qjackctl-2668  0....    4us : try_to_wake_up (c011b4ab 0 0)
qjackctl-2668  0D..1    5us : __activate_task <ardour.b-2675> (172 1)
qjackctl-2668  0D...    6us < (1)
qjackctl-2668  0....    6us+> sys_read (0000000f b721338a 0000007b)
qjackctl-2668  0D...    9us < (1)
qjackctl-2668  0....   10us+> sys_poll (0823dea8 00000002 0000007b)
qjackctl-2668  0...1   12us : __schedule (c032a995 0 0)
qjackctl-2668  0D..2   13us : deactivate_task <qjackctl-2668> (172 2)
ardour.b-2675  0D..2   14us+: __schedule <qjackctl-2668> (172 172)
ardour.b-2675  0D...   17us < (1)
ardour.b-2675  0....   18us > sys_gettimeofday (b01fe324 00000000 0000007b)
ardour.b-2675  0D...   20us!< (0)
ardour.b-2675  0D.h.  178us+: do_IRQ (b6281a8a 0 0)
ardour.b-2675  0D.h1  185us : hrtimer_interrupt (d2f6b90d72 eccc1f4c)
ardour.b-2675  0D.h1  185us : try_to_wake_up (c011b58b 0 0)
ardour.b-2675  0D.h2  186us : effective_prio <ardour.b-2670> (-5 -5)
ardour.b-2675  0D.h2  187us!: __activate_task <ardour.b-2670> (-5 1)
ardour.b-2675  0D.h.  576us : do_IRQ (b61ead92 18 0)
ardour.b-2675  0D.h1  576us : try_to_wake_up (c011b58b 0 0)
ardour.b-2675  0D.h2  577us!: __activate_task <IRQ_18-1674> (170 2)
ardour.b-2675  0D.h.  886us : do_IRQ (b60c7d7a 17 0)
ardour.b-2675  0D.h1  886us : try_to_wake_up (c011b58b 0 0)
ardour.b-2675  0D.h2  887us : __activate_task <IRQ_17-308> (180 3)
ardour.b-2675  0Dnh2  887us+: try_to_wake_up <IRQ_17-308> (180 172)
ardour.b-2675  0Dn.1  894us : __schedule (c010330e 0 0)
  IRQ_17-308   0D..2  895us+: __schedule <ardour.b-2675> (172 180)
  IRQ_17-308   0....  905us+: i_usX2Y_usbpcm_urb_complete (8 0 dc3de)
  IRQ_17-308   0...1  926us : __schedule (c032a995 0 0)
  IRQ_17-308   0D..2  926us : deactivate_task <IRQ_17-308> (180 4)
ardour.b-2675  0D..2  928us!: __schedule <IRQ_17-308> (180 172)
ardour.b-2675  0.... 1060us > sys_gettimeofday (b01fe324 00000000 0000007b)
ardour.b-2675  0D... 1062us < (0)
ardour.b-2675  0.... 1063us+> sys_write (00000017 b01ff38a 0000007b)
ardour.b-2675  0.... 1065us : try_to_wake_up (c011b4ab 0 0)
ardour.b-2675  0D..1 1066us : __activate_task <jackd-2667> (173 3)
ardour.b-2675  0Dn.1 1067us : try_to_wake_up <jackd-2667> (173 172)
ardour.b-2675  0Dn.1 1067us : __schedule (c032a862 0 0)
   jackd-2667  0D..2 1069us+: __schedule <ardour.b-2675> (172 173)
   jackd-2667  0D..3 1073us : rt_mutex_setprio <ardour.b-2675> (172 173)
   jackd-2667  0D..3 1073us : rt_mutex_setprio (0 0 0)
   jackd-2667  0...1 1074us : __schedule (c032a995 0 0)
   jackd-2667  0D..2 1074us : deactivate_task <jackd-2667> (173 4)
ardour.b-2675  0D..2 1075us : __schedule <jackd-2667> (173 173)
ardour.b-2675  0D..1 1077us : try_to_wake_up (c011b531 0 0)
ardour.b-2675  0D..2 1078us : __activate_task <jackd-2667> (173 3)
ardour.b-2675  0D..2 1079us : rt_mutex_setprio <ardour.b-2675> (173 172)
ardour.b-2675  0Dn.2 1079us : rt_mutex_setprio (0 1 0)
ardour.b-2675  0Dn.1 1080us : __schedule (c032a862 0 0)
   jackd-2667  0D..2 1081us : __schedule <ardour.b-2675> (172 173)
   jackd-2667  0D... 1083us < (1)
   jackd-2667  0.... 1084us > sys_gettimeofday (b6e521b4 00000000 0000007b)
   jackd-2667  0D... 1085us < (0)
   jackd-2667  0.... 1086us+> sys_read (00000013 b6e52257 0000007b)
   jackd-2667  0D... 1089us+< (1)
   jackd-2667  0.... 1121us > sys_gettimeofday (b6e52254 00000000 0000007b)
   jackd-2667  0D... 1122us < (0)
   jackd-2667  0.... 1124us > sys_gettimeofday (b6e522f4 00000000 0000007b)
   jackd-2667  0D... 1125us < (0)
   jackd-2667  0.... 1126us+> sys_poll (08074440 00000002 0000007b)
   jackd-2667  0...1 1132us : __schedule (c032a995 0 0)
   jackd-2667  0D..2 1132us : deactivate_task <jackd-2667> (173 4)
ardour.b-2675  0D..2 1134us : __schedule <jackd-2667> (173 172)
ardour.b-2675  0D... 1135us < (1)
ardour.b-2675  0.... 1137us+> sys_read (00000016 b01ff38a 0000007b)
ardour.b-2675  0D... 1139us < (1)
ardour.b-2675  0.... 1140us+> sys_poll (086641a8 00000002 0000007b)
ardour.b-2675  0...1 1143us : __schedule (c032a995 0 0)
ardour.b-2675  0D..2 1144us : deactivate_task <ardour.b-2675> (172 3)
  IRQ_18-1674  0D..2 1145us+: __schedule <ardour.b-2675> (172 170)
  IRQ_18-1674  0D... 1179us : try_to_wake_up (c011b58b 0 0)
  IRQ_18-1674  0D..1 1180us+: __activate_task <softirq--8> (101 2)
  IRQ_18-1674  0...1 1187us : __schedule (c032a995 0 0)
  IRQ_18-1674  0D..2 1188us : deactivate_task <IRQ_18-1674> (170 3)
softirq--8     0D..2 1189us+: __schedule <IRQ_18-1674> (170 101)
softirq--8     0...1 1236us : __schedule (c032a995 0 0)
softirq--8     0D..2 1237us : deactivate_task <softirq--8> (101 2)
softirq--8     0D..2 1237us : effective_prio <ardour.b-2670> (-5 -5)
ardour.b-2670  0D..2 1238us : __schedule <softirq--8> (101 -5)
ardour.b-2670  0D... 1240us+< (0)
ardour.b-2670  0.... 1249us+> sys_nanosleep (b72ec324 b72ec31c 0000007b)
ardour.b-2670  0D..1 1252us : enqueue_hrtimer (d2f7622b63 eccc1f4c)
ardour.b-2670  0...1 1253us : __schedule (c032a995 0 0)
ardour.b-2670  0D..2 1253us : deactivate_task <ardour.b-2670> (-5 1)
  <idle>-0     0D..2 1254us+: __schedule <ardour.b-2670> (-5 20)
  <idle>-0     0D..2 1264us!: enqueue_hrtimer (d2f7127753 c039bbd0)
  <idle>-0     0D.h1 1886us : do_IRQ (c0102163 17 0)
  <idle>-0     0D.h2 1886us : try_to_wake_up (c011b58b 0 0)
  <idle>-0     0D.h3 1887us : __activate_task <IRQ_17-308> (180 0)
  <idle>-0     0Dnh3 1887us+: try_to_wake_up <IRQ_17-308> (180 20)
  <idle>-0     0Dn.1 1898us+: hrtimer_restart_sched_tick (d2f6d3732d 0)
  <idle>-0     0Dn.2 1906us+: enqueue_hrtimer (d2f6d90313 c039bbd0)
  <idle>-0     0.n.1 1914us : __schedule (c0102264 0 0)
  IRQ_17-308   0D..2 1915us+: __schedule <<idle>-0> (20 180)
  IRQ_17-308   0.... 1924us+: i_usX2Y_usbpcm_urb_complete (8 0 dc3df)
  IRQ_17-308   0...1 1945us : __schedule (c032a995 0 0)
  IRQ_17-308   0D..2 1945us : deactivate_task <IRQ_17-308> (180 1)
  <idle>-0     0D..2 1946us+: __schedule <IRQ_17-308> (180 20)
  <idle>-0     0D..2 1956us!: enqueue_hrtimer (d2f7127753 c039bbd0)
  <idle>-0     0D.h1 2885us : do_IRQ (c0102163 17 0)
  <idle>-0     0D.h2 2886us : try_to_wake_up (c011b58b 0 0)
  <idle>-0     0D.h3 2886us : __activate_task <IRQ_17-308> (180 0)
  <idle>-0     0Dnh3 2887us+: try_to_wake_up <IRQ_17-308> (180 20)
  <idle>-0     0Dn.1 2897us+: hrtimer_restart_sched_tick (d2f6e2b5ec 0)
  <idle>-0     0Dn.2 2905us+: enqueue_hrtimer (d2f7160c13 c039bbd0)
  <idle>-0     0.n.1 2913us : __schedule (c0102264 0 0)
  IRQ_17-308   0D..2 2914us+: __schedule <<idle>-0> (20 180)
  IRQ_17-308   0.... 2922us+: i_usX2Y_usbpcm_urb_complete (8 0 dc3e0)
  IRQ_17-308   0...1 2942us : __schedule (c032a995 0 0)
  IRQ_17-308   0D..2 2943us : deactivate_task <IRQ_17-308> (180 1)
  <idle>-0     0D..2 2944us!: __schedule <IRQ_17-308> (180 20)
  <idle>-0     0D.h1 3882us : do_IRQ (c0102163 17 0)
  <idle>-0     0D.h2 3883us : try_to_wake_up (c011b58b 0 0)
  <idle>-0     0D.h3 3883us : __activate_task <IRQ_17-308> (180 0)
  <idle>-0     0Dnh3 3884us+: try_to_wake_up <IRQ_17-308> (180 20)
  <idle>-0     0Dn.1 3891us : __schedule (c0102264 0 0)
  IRQ_17-308   0D..2 3892us+: __schedule <<idle>-0> (20 180)
  IRQ_17-308   0.... 3900us+: i_usX2Y_usbpcm_urb_complete (8 0 dc3e1)
  IRQ_17-308   0...1 3920us : __schedule (c032a995 0 0)
  IRQ_17-308   0D..2 3921us : deactivate_task <IRQ_17-308> (180 1)
  <idle>-0     0D..2 3921us!: __schedule <IRQ_17-308> (180 20)
  <idle>-0     0D.h1 4881us : do_IRQ (c0102163 17 0)
  <idle>-0     0D.h2 4882us : try_to_wake_up (c011b58b 0 0)
  <idle>-0     0D.h3 4883us : __activate_task <IRQ_17-308> (180 0)
  <idle>-0     0Dnh3 4883us+: try_to_wake_up <IRQ_17-308> (180 20)
  <idle>-0     0Dn.1 4890us : __schedule (c0102264 0 0)
  IRQ_17-308   0D..2 4891us+: __schedule <<idle>-0> (20 180)
  IRQ_17-308   0.... 4899us+: i_usX2Y_usbpcm_urb_complete (8 0 dc3e2)
  IRQ_17-308   0...1 4919us : __schedule (c032a995 0 0)
  IRQ_17-308   0D..2 4919us : deactivate_task <IRQ_17-308> (180 1)
  <idle>-0     0D..2 4920us!: __schedule <IRQ_17-308> (180 20)
  <idle>-0     0D.h1 5880us : do_IRQ (c0102163 17 0)
  <idle>-0     0D.h2 5881us : try_to_wake_up (c011b58b 0 0)
  <idle>-0     0D.h3 5881us : __activate_task <IRQ_17-308> (180 0)
  <idle>-0     0Dnh3 5881us+: try_to_wake_up <IRQ_17-308> (180 20)
  <idle>-0     0Dn.1 5888us : __schedule (c0102264 0 0)
  IRQ_17-308   0D..2 5889us+: __schedule <<idle>-0> (20 180)
  IRQ_17-308   0.... 5898us+: i_usX2Y_usbpcm_urb_complete (8 0 dc3e3)
  IRQ_17-308   0.... 5904us : try_to_wake_up (c011b4ab 0 0)
  IRQ_17-308   0D..1 5905us+: __activate_task <jackd-2667> (173 1)
  IRQ_17-308   0.... 5910us+: try_to_wake_up (c011b4ab 0 0)
  IRQ_17-308   0...1 5924us : __schedule (c032a995 0 0)
  IRQ_17-308   0D..2 5925us : deactivate_task <IRQ_17-308> (180 2)
   jackd-2667  0D..2 5926us+: __schedule <IRQ_17-308> (180 173)
   jackd-2667  0D... 5932us < (2)
   jackd-2667  0.... 5933us > sys_gettimeofday (b6e522f4 00000000 0000007b)
   jackd-2667  0D... 5934us+< (0)
   jackd-2667  0.... 5968us > sys_gettimeofday (b6e521b4 00000000 0000007b)
   jackd-2667  0D... 5970us < (0)
   jackd-2667  0.... 5970us+> sys_write (00000005 b6e52257 0000007b)
   jackd-2667  0.... 5973us : try_to_wake_up (c011b4ab 0 0)
   jackd-2667  0D..1 5973us : __activate_task <qjackctl-2668> (172 1)
   jackd-2667  0D... 5975us < (1)
   jackd-2667  0.... 5975us > sys_gettimeofday (b6e521b4 00000000 0000007b)
   jackd-2667  0D... 5977us < (0)
   jackd-2667  0.... 5977us+> sys_poll (b6e5224c 00000001 0000007b)
   jackd-2667  0...1 5980us : __schedule (c032a995 0 0)
   jackd-2667  0D..2 5980us : deactivate_task <jackd-2667> (173 2)
qjackctl-2668  0D..2 5982us+: __schedule <jackd-2667> (173 172)
qjackctl-2668  0D... 5985us < (1)
qjackctl-2668  0.... 5986us > sys_gettimeofday (b7212324 00000000 0000007b)
qjackctl-2668  0D... 5988us < (0)
qjackctl-2668  0.... 5989us > sys_gettimeofday (b7212324 00000000 0000007b)
qjackctl-2668  0D... 5990us < (0)
qjackctl-2668  0.... 5990us > sys_write (00000010 b721338a 0000007b)
qjackctl-2668  0.... 5992us : try_to_wake_up (c011b4ab 0 0)
qjackctl-2668  0D..1 5993us : __activate_task <ardour.b-2675> (172 1)
qjackctl-2668  0D... 5994us < (1)
qjackctl-2668  0.... 5994us+> sys_read (0000000f b721338a 0000007b)
qjackctl-2668  0D... 5997us < (1)
qjackctl-2668  0.... 5998us+> sys_poll (0823dea8 00000002 0000007b)
qjackctl-2668  0...1 6001us : __schedule (c032a995 0 0)
qjackctl-2668  0D..2 6001us : deactivate_task <qjackctl-2668> (172 2)
ardour.b-2675  0D..2 6002us+: __schedule <qjackctl-2668> (172 172)
ardour.b-2675  0D... 6006us < (1)
ardour.b-2675  0.... 6007us > sys_gettimeofday (b01fe324 00000000 0000007b)
ardour.b-2675  0D... 6008us!< (0)
ardour.b-2675  0D.h. 6266us+: do_IRQ (b6281cf6 0 0)
ardour.b-2675  0D.h1 6273us+: hrtimer_interrupt (d2f7160c13 c039bbd0)
ardour.b-2675  0D.h. 6277us : try_to_wake_up (c011b58b 0 0)
ardour.b-2675  0D.h1 6277us : __activate_task <softirq--4> (101 1)
ardour.b-2675  0D.h. 6278us : try_to_wake_up (c011b58b 0 0)
ardour.b-2675  0D.h1 6279us : __activate_task <posix_cp-2> (150 2)
ardour.b-2675  0D.h1 6280us!: enqueue_hrtimer (d2f7531513 c039bbd0)
ardour.b-2675  0D.h. 6879us : do_IRQ (b60c7ce3 17 0)
ardour.b-2675  0D.h1 6879us : try_to_wake_up (c011b58b 0 0)
ardour.b-2675  0D.h2 6880us : __activate_task <IRQ_17-308> (180 3)
ardour.b-2675  0Dnh2 6880us+: try_to_wake_up <IRQ_17-308> (180 172)
ardour.b-2675  0Dn.1 6888us : __schedule (c010330e 0 0)
  IRQ_17-308   0D..2 6889us+: __schedule <ardour.b-2675> (172 180)
  IRQ_17-308   0.... 6898us+: i_usX2Y_usbpcm_urb_complete (8 0 dc3e4)
  IRQ_17-308   0...1 6924us : __schedule (c032a995 0 0)
  IRQ_17-308   0D..2 6924us : deactivate_task <IRQ_17-308> (180 4)
ardour.b-2675  0D..2 6925us!: __schedule <IRQ_17-308> (180 172)
ardour.b-2675  0.... 7049us > sys_gettimeofday (b01fe324 00000000 0000007b)
ardour.b-2675  0D... 7051us < (0)
ardour.b-2675  0.... 7051us+> sys_write (00000017 b01ff38a 0000007b)
ardour.b-2675  0.... 7054us : try_to_wake_up (c011b4ab 0 0)
ardour.b-2675  0D..1 7055us : __activate_task <jackd-2667> (173 3)
ardour.b-2675  0Dn.1 7056us : try_to_wake_up <jackd-2667> (173 172)
ardour.b-2675  0Dn.1 7056us : __schedule (c032a862 0 0)
   jackd-2667  0D..2 7058us+: __schedule <ardour.b-2675> (172 173)
   jackd-2667  0D..3 7062us : rt_mutex_setprio <ardour.b-2675> (172 173)
   jackd-2667  0D..3 7062us : rt_mutex_setprio (0 0 0)
   jackd-2667  0...1 7063us : __schedule (c032a995 0 0)
   jackd-2667  0D..2 7063us : deactivate_task <jackd-2667> (173 4)
ardour.b-2675  0D..2 7064us : __schedule <jackd-2667> (173 173)
ardour.b-2675  0D..1 7066us : try_to_wake_up (c011b531 0 0)
ardour.b-2675  0D..2 7067us : __activate_task <jackd-2667> (173 3)
ardour.b-2675  0D..2 7068us : rt_mutex_setprio <ardour.b-2675> (173 172)
ardour.b-2675  0Dn.2 7068us : rt_mutex_setprio (0 1 0)
ardour.b-2675  0Dn.1 7069us : __schedule (c032a862 0 0)
   jackd-2667  0D..2 7070us : __schedule <ardour.b-2675> (172 173)
   jackd-2667  0D... 7072us < (1)
   jackd-2667  0.... 7073us > sys_gettimeofday (b6e521b4 00000000 0000007b)
   jackd-2667  0D... 7074us < (0)
   jackd-2667  0.... 7075us+> sys_read (00000013 b6e52257 0000007b)
   jackd-2667  0D... 7078us+< (1)
   jackd-2667  0.... 7110us > sys_gettimeofday (b6e52254 00000000 0000007b)
   jackd-2667  0D... 7111us < (0)
   jackd-2667  0.... 7113us > sys_gettimeofday (b6e522f4 00000000 0000007b)
   jackd-2667  0D... 7114us < (0)
   jackd-2667  0.... 7115us+> sys_poll (08074440 00000002 0000007b)
   jackd-2667  0...1 7121us : __schedule (c032a995 0 0)
   jackd-2667  0D..2 7122us : deactivate_task <jackd-2667> (173 4)
ardour.b-2675  0D..2 7123us : __schedule <jackd-2667> (173 172)
ardour.b-2675  0D... 7125us < (1)
ardour.b-2675  0.... 7126us+> sys_read (00000016 b01ff38a 0000007b)
ardour.b-2675  0D... 7129us < (1)
ardour.b-2675  0.... 7129us+> sys_poll (086641a8 00000002 0000007b)
ardour.b-2675  0...1 7133us : __schedule (c032a995 0 0)
ardour.b-2675  0D..2 7133us : deactivate_task <ardour.b-2675> (172 3)
posix_cp-2     0D..2 7134us : __schedule <ardour.b-2675> (172 150)
posix_cp-2     0...1 7136us : __schedule (c032a995 0 0)
posix_cp-2     0D..2 7136us : deactivate_task <posix_cp-2> (150 2)
softirq--4     0D..2 7137us+: __schedule <posix_cp-2> (150 101)
softirq--4     0.... 7142us : try_to_wake_up (c011b58b 0 0)
softirq--4     0D..1 7142us : effective_prio <ardour.b-2669> (-5 -5)
softirq--4     0D..1 7143us : __activate_task <ardour.b-2669> (-5 1)
softirq--4     0...1 7145us : __schedule (c032a995 0 0)
softirq--4     0D..2 7145us : deactivate_task <softirq--4> (101 2)
softirq--4     0D..2 7146us : effective_prio <ardour.b-2669> (-5 -5)
ardour.b-2669  0D..2 7147us+: __schedule <softirq--4> (101 -5)
ardour.b-2669  0D... 7152us+< (0)
ardour.b-2669  0.... 7159us > sys_gettimeofday (bfb7dfa8 00000000 0000007b)
ardour.b-2669  0D... 7160us!< (0)
ardour.b-2669  0.... 7265us+> sys_ioctl (00000005 0000541b 0000007b)
ardour.b-2669  0D... 7267us < (0)
ardour.b-2669  0.... 7269us > sys_gettimeofday (bfb7df98 00000000 0000007b)
ardour.b-2669  0D... 7270us+< (0)
ardour.b-2669  0.... 7274us+> sys_poll (08c74150 00000003 0000007b)
ardour.b-2669  0D... 7277us!< (0)
ardour.b-2669  0D.h. 7879us : do_IRQ (49b48631 17 0)
ardour.b-2669  0D.h1 7880us : try_to_wake_up (c011b58b 0 0)
ardour.b-2669  0D.h2 7880us : __activate_task <IRQ_17-308> (180 1)
ardour.b-2669  0Dnh2 7881us+: try_to_wake_up <IRQ_17-308> (180 -5)
ardour.b-2669  0Dn.1 7888us : __schedule (c010330e 0 0)
  IRQ_17-308   0D..2 7890us+: __schedule <ardour.b-2669> (-5 180)
  IRQ_17-308   0.... 7901us+: i_usX2Y_usbpcm_urb_complete (8 0 dc3e5)
  IRQ_17-308   0...1 7923us : __schedule (c032a995 0 0)
  IRQ_17-308   0D..2 7924us : deactivate_task <IRQ_17-308> (180 2)
ardour.b-2669  0D..2 7925us!: __schedule <IRQ_17-308> (180 -5)
ardour.b-2669  0.... 8457us+> sys_write (00000005 084c56c0 0000007b)
ardour.b-2669  0.... 8469us : try_to_wake_up (c011b4ab 0 0)
ardour.b-2669  0D..1 8470us : effective_prio <X-2287> (-5 -5)
ardour.b-2669  0D..1 8471us+: __activate_task <X-2287> (-5 1)
ardour.b-2669  0D... 8473us+< (2208)
ardour.b-2669  0.... 8479us > sys_ioctl (00000005 0000541b 0000007b)
ardour.b-2669  0D... 8480us < (0)
ardour.b-2669  0.... 8482us > sys_gettimeofday (bfb7df98 00000000 0000007b)
ardour.b-2669  0D... 8484us+< (0)
ardour.b-2669  0.... 8487us+> sys_poll (08c74150 00000003 0000007b)
ardour.b-2669  0...1 8492us : __schedule (c032a995 0 0)
ardour.b-2669  0D..2 8493us : deactivate_task <ardour.b-2669> (-5 2)
ardour.b-2669  0D..2 8493us : effective_prio <X-2287> (-5 -5)
       X-2287  0D..2 8495us+: __schedule <ardour.b-2669> (-5 -5)
       X-2287  0D... 8540us+< (1)
       X-2287  0.... 8549us+> sys_setitimer (00000000 bf850984 0000007b)
       X-2287  0D..1 8553us : enqueue_hrtimer (d2f86a4698 f753444c)
       X-2287  0D... 8554us < (0)
       X-2287  0.... 8556us > sys_gettimeofday (bf85098c 00000000 0000007b)
       X-2287  0D... 8557us+< (0)
       X-2287  0.... 8564us+> sys_read (00000029 08577c68 0000007b)
       X-2287  0.... 8572us : try_to_wake_up (c011b4ab 0 0)
       X-2287  0D..1 8573us : effective_prio <ardour.b-2669> (-5 -5)
       X-2287  0D..1 8573us+: __activate_task <ardour.b-2669> (-5 1)
       X-2287  0D... 8578us!< (2208)
       X-2287  0D.h. 8877us : do_IRQ (b7d4d832 17 0)
       X-2287  0D.h1 8878us : try_to_wake_up (c011b58b 0 0)
       X-2287  0D.h2 8879us : __activate_task <IRQ_17-308> (180 2)
       X-2287  0Dnh2 8879us+: try_to_wake_up <IRQ_17-308> (180 -5)
       X-2287  0Dn.1 8887us : __schedule (c010330e 0 0)
  IRQ_17-308   0D..2 8889us+: __schedule <X-2287> (-5 180)
  IRQ_17-308   0.... 8899us+: i_usX2Y_usbpcm_urb_complete (8 0 dc3e6)
  IRQ_17-308   0...1 8923us : __schedule (c032a995 0 0)
  IRQ_17-308   0D..2 8924us : deactivate_task <IRQ_17-308> (180 3)
<trace first part/>


Big part repeating the same stuff cut out here.
Below the trace shows i_usX2Y_usbpcm_urb_complete() running
under an alien context, and this is where jackd starts stalling:


<trace 2nd part>
  <idle>-0     0D.h1 3410029us : do_IRQ (c0102163 17 0)
  <idle>-0     0D.h2 3410029us : try_to_wake_up (c011b58b 0 0)
  <idle>-0     0D.h3 3410030us : __activate_task <IRQ_17-308> (180 0)
  <idle>-0     0Dnh3 3410030us+: try_to_wake_up <IRQ_17-308> (180 20)
  <idle>-0     0Dn.1 3410037us : __schedule (c0102264 0 0)
  IRQ_17-308   0D..2 3410038us+: __schedule <<idle>-0> (20 180)
  IRQ_17-308   0.... 3410047us+: i_usX2Y_usbpcm_urb_complete (8 0 dd133)
  IRQ_17-308   0...1 3410066us : __schedule (c032a995 0 0)
  IRQ_17-308   0D..2 3410067us : deactivate_task <IRQ_17-308> (180 1)
  <idle>-0     0D..2 3410068us!: __schedule <IRQ_17-308> (180 20)
  <idle>-0     0D.h1 3410495us : do_IRQ (c0102163 12 0)
  <idle>-0     0D.h2 3410496us : try_to_wake_up (c011b58b 0 0)
  <idle>-0     0D.h3 3410496us : __activate_task <IRQ_12-295> (145 0)
  <idle>-0     0Dnh3 3410497us : try_to_wake_up <IRQ_12-295> (145 20)
  <idle>-0     0Dn.1 3410498us : __schedule (c0102264 0 0)
  IRQ_12-295   0D..2 3410499us+: __schedule <<idle>-0> (20 145)
  IRQ_12-295   0...1 3410508us : __schedule (c032a995 0 0)
  IRQ_12-295   0D..2 3410508us : deactivate_task <IRQ_12-295> (145 1)
  <idle>-0     0D..2 3410509us!: __schedule <IRQ_12-295> (145 20)
  <idle>-0     0D.h1 3410985us+: do_IRQ (c0102163 0 0)
  <idle>-0     0D.h2 3410992us+: hrtimer_interrupt (d3c2380013 c039bbd0)
  <idle>-0     0D.h1 3410995us : try_to_wake_up (c011b58b 0 0)
  <idle>-0     0D.h2 3410996us : __activate_task <softirq--4> (101 0)
  <idle>-0     0Dnh2 3410996us : try_to_wake_up <softirq--4> (101 20)
  <idle>-0     0Dnh1 3410997us : try_to_wake_up (c011b58b 0 0)
  <idle>-0     0Dnh2 3410998us : __activate_task <posix_cp-2> (150 1)
  <idle>-0     0Dnh2 3410998us : try_to_wake_up <posix_cp-2> (150 20)
  <idle>-0     0Dnh2 3410999us+: enqueue_hrtimer (d3c2750913 c039bbd0)
  <idle>-0     0Dn.1 3411008us : __schedule (c0102264 0 0)
posix_cp-2     0D..2 3411009us : __schedule <<idle>-0> (20 150)
posix_cp-2     0...1 3411010us : __schedule (c032a995 0 0)
posix_cp-2     0D..2 3411011us : deactivate_task <posix_cp-2> (150 2)
softirq--4     0D..2 3411012us+: __schedule <posix_cp-2> (150 101)
softirq--4     0D.h. 3411028us : do_IRQ (c027b5d4 17 0)
softirq--4     0D.h1 3411028us : try_to_wake_up (c011b58b 0 0)
softirq--4     0D.h2 3411029us : __activate_task <IRQ_17-308> (180 1)
softirq--4     0Dnh2 3411029us+: try_to_wake_up <IRQ_17-308> (180 101)
softirq--4     0Dn.1 3411036us : __schedule (c032aed7 0 0)
  IRQ_17-308   0D..2 3411037us+: __schedule <softirq--4> (101 180)
  IRQ_17-308   0D..3 3411044us : rt_mutex_setprio <softirq--4> (101 180)
  IRQ_17-308   0D..3 3411044us : rt_mutex_setprio (0 0 0)
  IRQ_17-308   0...1 3411045us : __schedule (c032a995 0 0)
  IRQ_17-308   0D..2 3411046us : deactivate_task <IRQ_17-308> (180 2)
softirq--4     0D..2 3411047us+: __schedule <IRQ_17-308> (180 180)
softirq--4     0D..1 3411050us : try_to_wake_up (c011b531 0 0)
softirq--4     0D..2 3411050us : __activate_task <IRQ_17-308> (180 1)
softirq--4     0D..2 3411051us : rt_mutex_setprio <softirq--4> (180 101)
softirq--4     0Dn.2 3411052us : rt_mutex_setprio (0 1 0)
softirq--4     0Dn.1 3411052us : __schedule (c032a862 0 0)
  IRQ_17-308   0D..2 3411053us+: __schedule <softirq--4> (101 180)
  IRQ_17-308   0...1 3411063us : __schedule (c032a995 0 0)
  IRQ_17-308   0D..2 3411063us : deactivate_task <IRQ_17-308> (180 2)
softirq--4     0D..2 3411064us+: __schedule <IRQ_17-308> (180 101)
softirq--4     0.... 3411072us+: i_usX2Y_usbpcm_urb_complete (8 0 dd134)
softirq--4     0.... 3411078us : try_to_wake_up (c011b4ab 0 0)
softirq--4     0D..1 3411079us : __activate_task <jackd-2667> (173 1)
softirq--4     0Dn.1 3411079us : try_to_wake_up <jackd-2667> (173 101)
softirq--4     0Dn.1 3411080us : __schedule (c032a862 0 0)
   jackd-2667  0D..2 3411081us+: __schedule <softirq--4> (101 173)
   jackd-2667  0D..3 3411085us : rt_mutex_setprio <softirq--4> (101 173)
   jackd-2667  0D..3 3411085us : rt_mutex_setprio (0 0 0)
   jackd-2667  0...1 3411086us : __schedule (c032a995 0 0)
   jackd-2667  0D..2 3411087us : deactivate_task <jackd-2667> (173 2)
softirq--4     0D..2 3411087us+: __schedule <jackd-2667> (173 173)
softirq--4     0D..1 3411090us : try_to_wake_up (c011b531 0 0)
softirq--4     0D..2 3411090us : __activate_task <jackd-2667> (173 1)
softirq--4     0D..2 3411091us : rt_mutex_setprio <softirq--4> (173 101)
softirq--4     0Dn.2 3411092us : rt_mutex_setprio (0 1 0)
softirq--4     0Dn.1 3411092us : __schedule (c032a862 0 0)
   jackd-2667  0D..2 3411093us+: __schedule <softirq--4> (101 173)
   jackd-2667  0D... 3411098us < (1)
   jackd-2667  0.... 3411099us > sys_gettimeofday (b6e522f4 00000000 0000007b)
   jackd-2667  0D... 3411101us < (0)
   jackd-2667  0.... 3411102us > sys_gettimeofday (b6e522f4 00000000 0000007b)
   jackd-2667  0D... 3411104us < (0)
   jackd-2667  0.... 3411104us+> sys_poll (08074440 00000001 0000007b)
   jackd-2667  0...1 3411107us : __schedule (c032a995 0 0)
   jackd-2667  0D..2 3411108us : deactivate_task <jackd-2667> (173 2)
softirq--4     0D..2 3411109us+: __schedule <jackd-2667> (173 101)
softirq--4     0.... 3411114us : try_to_wake_up (c011b4ab 0 0)
softirq--4     0D..1 3411114us : __activate_task <jackd-2667> (173 1)
softirq--4     0Dn.1 3411115us : try_to_wake_up <jackd-2667> (173 101)
softirq--4     0Dn.1 3411115us : __schedule (c032a862 0 0)
   jackd-2667  0D..2 3411116us+: __schedule <softirq--4> (101 173)
   jackd-2667  0D..3 3411120us : rt_mutex_setprio <softirq--4> (101 173)
   jackd-2667  0D..3 3411120us : rt_mutex_setprio (0 0 0)
   jackd-2667  0...1 3411121us : __schedule (c032a995 0 0)
   jackd-2667  0D..2 3411122us : deactivate_task <jackd-2667> (173 2)
softirq--4     0D..2 3411122us+: __schedule <jackd-2667> (173 173)
softirq--4     0D..1 3411125us : try_to_wake_up (c011b531 0 0)
softirq--4     0D..2 3411125us : __activate_task <jackd-2667> (173 1)
softirq--4     0D..2 3411126us : rt_mutex_setprio <softirq--4> (173 101)
softirq--4     0Dn.2 3411127us : rt_mutex_setprio (0 1 0)
softirq--4     0Dn.1 3411127us : __schedule (c032a862 0 0)
   jackd-2667  0D..2 3411128us+: __schedule <softirq--4> (101 173)
   jackd-2667  0D... 3411131us < (1)
   jackd-2667  0.... 3411131us > sys_gettimeofday (b6e522f4 00000000 0000007b)
   jackd-2667  0D... 3411133us+< (0)
   jackd-2667  0.... 3411167us > sys_gettimeofday (b6e521b4 00000000 0000007b)
   jackd-2667  0D... 3411168us < (0)
   jackd-2667  0.... 3411169us+> sys_write (00000005 b6e52257 0000007b)
   jackd-2667  0.... 3411171us : try_to_wake_up (c011b4ab 0 0)
   jackd-2667  0D..1 3411172us : __activate_task <qjackctl-2668> (172 2)
   jackd-2667  0D... 3411174us < (1)
   jackd-2667  0.... 3411174us > sys_gettimeofday (b6e521b4 00000000 0000007b)
   jackd-2667  0D... 3411176us < (0)
   jackd-2667  0.... 3411176us+> sys_poll (b6e5224c 00000001 0000007b)
   jackd-2667  0...1 3411178us : __schedule (c032a995 0 0)
   jackd-2667  0D..2 3411179us : deactivate_task <jackd-2667> (173 3)
qjackctl-2668  0D..2 3411180us+: __schedule <jackd-2667> (173 172)
qjackctl-2668  0D... 3411183us < (1)
qjackctl-2668  0.... 3411184us > sys_gettimeofday (b7212324 00000000 0000007b)
qjackctl-2668  0D... 3411186us < (0)
qjackctl-2668  0.... 3411186us > sys_gettimeofday (b7212324 00000000 0000007b)
qjackctl-2668  0D... 3411188us < (0)
qjackctl-2668  0.... 3411188us > sys_write (00000010 b721338a 0000007b)
qjackctl-2668  0.... 3411190us : try_to_wake_up (c011b4ab 0 0)
qjackctl-2668  0D..1 3411191us : __activate_task <ardour.b-2675> (172 2)
qjackctl-2668  0D... 3411192us < (1)
qjackctl-2668  0.... 3411193us+> sys_read (0000000f b721338a 0000007b)
qjackctl-2668  0D... 3411195us < (1)
qjackctl-2668  0.... 3411196us+> sys_poll (0823dea8 00000002 0000007b)
qjackctl-2668  0...1 3411199us : __schedule (c032a995 0 0)
qjackctl-2668  0D..2 3411199us : deactivate_task <qjackctl-2668> (172 3)
ardour.b-2675  0D..2 3411201us+: __schedule <qjackctl-2668> (172 172)
ardour.b-2675  0D... 3411204us < (1)
ardour.b-2675  0.... 3411205us > sys_gettimeofday (b01fe324 00000000 0000007b)
ardour.b-2675  0D... 3411206us+< (0)
ardour.b-2675  0D.h. 3411229us+: do_IRQ (b61f8f9a 0 0)
ardour.b-2675  0D.h1 3411236us : hrtimer_interrupt (d3c23bbde0 eccc1f4c)
ardour.b-2675  0D.h1 3411237us : try_to_wake_up (c011b58b 0 0)
ardour.b-2675  0D.h2 3411238us : effective_prio <ardour.b-2670> (-5 -5)
ardour.b-2675  0D.h2 3411238us!: __activate_task <ardour.b-2670> (-5 2)
ardour.b-2675  0D.h. 3411710us : do_IRQ (b6281b98 12 0)
ardour.b-2675  0D.h1 3411711us : try_to_wake_up (c011b58b 0 0)
ardour.b-2675  0D.h2 3411711us!: __activate_task <IRQ_12-295> (145 3)
ardour.b-2675  0D.h. 3412027us : do_IRQ (b60c7d6b 17 0)
ardour.b-2675  0D.h1 3412028us : try_to_wake_up (c011b58b 0 0)
ardour.b-2675  0D.h2 3412028us : __activate_task <IRQ_17-308> (180 4)
ardour.b-2675  0Dnh2 3412029us+: try_to_wake_up <IRQ_17-308> (180 172)
ardour.b-2675  0Dn.1 3412036us : __schedule (c010330e 0 0)
  IRQ_17-308   0D..2 3412037us+: __schedule <ardour.b-2675> (172 180)
  IRQ_17-308   0...1 3412051us : __schedule (c032a995 0 0)
  IRQ_17-308   0D..2 3412051us : deactivate_task <IRQ_17-308> (180 5)
ardour.b-2675  0D..2 3412052us!: __schedule <IRQ_17-308> (180 172)
ardour.b-2675  0.... 3412236us > sys_gettimeofday (b01fe324 00000000 0000007b)
ardour.b-2675  0D... 3412238us < (0)
ardour.b-2675  0.... 3412238us+> sys_write (00000017 b01ff38a 0000007b)
ardour.b-2675  0.... 3412241us : try_to_wake_up (c011b4ab 0 0)
ardour.b-2675  0D..1 3412242us : __activate_task <jackd-2667> (173 4)
ardour.b-2675  0Dn.1 3412242us : try_to_wake_up <jackd-2667> (173 172)
ardour.b-2675  0Dn.1 3412243us : __schedule (c032a862 0 0)
   jackd-2667  0D..2 3412244us+: __schedule <ardour.b-2675> (172 173)
   jackd-2667  0D..3 3412248us : rt_mutex_setprio <ardour.b-2675> (172 173)
   jackd-2667  0D..3 3412248us : rt_mutex_setprio (0 0 0)
   jackd-2667  0...1 3412249us : __schedule (c032a995 0 0)
   jackd-2667  0D..2 3412250us : deactivate_task <jackd-2667> (173 5)
ardour.b-2675  0D..2 3412251us : __schedule <jackd-2667> (173 173)
ardour.b-2675  0D..1 3412253us : try_to_wake_up (c011b531 0 0)
ardour.b-2675  0D..2 3412253us : __activate_task <jackd-2667> (173 4)
ardour.b-2675  0D..2 3412254us : rt_mutex_setprio <ardour.b-2675> (173 172)
ardour.b-2675  0Dn.2 3412254us : rt_mutex_setprio (0 1 0)
ardour.b-2675  0Dn.1 3412255us : __schedule (c032a862 0 0)
   jackd-2667  0D..2 3412256us : __schedule <ardour.b-2675> (172 173)
   jackd-2667  0D... 3412258us < (1)
   jackd-2667  0.... 3412259us > sys_gettimeofday (b6e521b4 00000000 0000007b)
   jackd-2667  0D... 3412260us < (0)
   jackd-2667  0.... 3412261us+> sys_read (00000013 b6e52257 0000007b)
   jackd-2667  0D... 3412264us+< (1)
   jackd-2667  0.... 3412296us > sys_gettimeofday (b6e52254 00000000 0000007b)
   jackd-2667  0D... 3412297us < (0)
   jackd-2667  0.... 3412299us > sys_gettimeofday (b6e522f4 00000000 0000007b)
   jackd-2667  0D... 3412301us < (0)
   jackd-2667  0.... 3412301us+> sys_poll (08074440 00000002 0000007b)
   jackd-2667  0...1 3412307us : __schedule (c032a995 0 0)
   jackd-2667  0D..2 3412308us : deactivate_task <jackd-2667> (173 5)
ardour.b-2675  0D..2 3412309us : __schedule <jackd-2667> (173 172)
ardour.b-2675  0D... 3412311us < (1)
ardour.b-2675  0.... 3412312us+> sys_read (00000016 b01ff38a 0000007b)
ardour.b-2675  0D... 3412315us < (1)
ardour.b-2675  0.... 3412316us+> sys_poll (086641a8 00000002 0000007b)
ardour.b-2675  0...1 3412319us : __schedule (c032a995 0 0)
ardour.b-2675  0D..2 3412320us : deactivate_task <ardour.b-2675> (172 4)
  IRQ_12-295   0D..2 3412321us+: __schedule <ardour.b-2675> (172 145)
  IRQ_12-295   0...1 3412328us : __schedule (c032a995 0 0)
  IRQ_12-295   0D..2 3412328us : deactivate_task <IRQ_12-295> (145 3)
softirq--4     0D..2 3412329us+: __schedule <IRQ_12-295> (145 101)
softirq--4     0.... 3412340us+: i_usX2Y_usbpcm_urb_complete (8 0 dd135)
softirq--4     0...1 3412358us : __schedule (c032a995 0 0)
softirq--4     0D..2 3412358us : deactivate_task <softirq--4> (101 2)
softirq--4     0D..2 3412359us : effective_prio <ardour.b-2670> (-5 -5)
ardour.b-2670  0D..2 3412360us : __schedule <softirq--4> (101 -5)
ardour.b-2670  0D... 3412361us+< (0)
ardour.b-2670  0.... 3412372us+> sys_nanosleep (b72ec324 b72ec31c 0000007b)
ardour.b-2670  0D..1 3412374us : enqueue_hrtimer (d3c2e5eed0 eccc1f4c)
ardour.b-2670  0...1 3412375us : __schedule (c032a995 0 0)
ardour.b-2670  0D..2 3412375us : deactivate_task <ardour.b-2670> (-5 1)
  <idle>-0     0D..2 3412376us+: __schedule <ardour.b-2670> (-5 20)
  <idle>-0     0D..2 3412386us!: enqueue_hrtimer (d3c2ae7d53 c039bbd0)
  <idle>-0     0D.h1 3413027us : do_IRQ (c0102163 17 0)
  <idle>-0     0D.h2 3413027us : try_to_wake_up (c011b58b 0 0)
  <idle>-0     0D.h3 3413028us : __activate_task <IRQ_17-308> (180 0)
  <idle>-0     0Dnh3 3413028us+: try_to_wake_up <IRQ_17-308> (180 20)
  <idle>-0     0Dn.1 3413039us+: hrtimer_restart_sched_tick (d3c2577fb8 0)
  <idle>-0     0Dn.2 3413047us+: enqueue_hrtimer (d3c2750913 c039bbd0)
  <idle>-0     0.n.1 3413055us : __schedule (c0102264 0 0)
  IRQ_17-308   0D..2 3413056us+: __schedule <<idle>-0> (20 180)
  IRQ_17-308   0.... 3413064us : i_usX2Y_usbpcm_urb_complete (8 ffffffee dd136)


vim:ft=help

<trace 2nd part/>

      Karsten
