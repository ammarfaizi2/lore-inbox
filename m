Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269072AbUHMKhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269072AbUHMKhL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 06:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269071AbUHMKge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 06:36:34 -0400
Received: from pop.gmx.de ([213.165.64.20]:20632 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269072AbUHMKcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 06:32:36 -0400
X-Authenticated: #4399952
Date: Fri, 13 Aug 2004 12:42:49 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-Id: <20040813124249.13066d94@mango.fruits.de>
In-Reply-To: <20040812235116.GA27838@elte.hu>
References: <20040726082330.GA22764@elte.hu>
	<1090830574.6936.96.camel@mindpipe>
	<20040726083537.GA24948@elte.hu>
	<1090832436.6936.105.camel@mindpipe>
	<20040726124059.GA14005@elte.hu>
	<20040726204720.GA26561@elte.hu>
	<20040729222657.GA10449@elte.hu>
	<20040801193043.GA20277@elte.hu>
	<20040809104649.GA13299@elte.hu>
	<20040810132654.GA28915@elte.hu>
	<20040812235116.GA27838@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2004 01:51:16 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> -O6 also adds another timing option besides preempt_thresh: if
> preempt_thresh is set to 0 then the tracer will automatically track
> the largest-previous latency. (i.e. the system does a search for the
> absolute maximum latency.) The /proc/sys/kernel/preempt_max_latency 
> control can be used to reset this value to conduct a new search for a 
> new workload, without having to reboot the system.

Hmm, should a new report only be generated when the newly measured
latency is really > than all other ones? I get the feeling that >= seems
to be enough. Here a dmesg extract:

(swapper/1): new 6 us maximum-latency critical section.
 => started at: <schedule+0x5c/0x5b0>
 => ended at:   <finish_task_switch+0x32/0x90>
 [<c01064ae>] dump_stack+0x1e/0x20
 [<c0130c64>] check_preempt_timing+0x184/0x1e0
 [<c0130db4>] sub_preempt_count+0x44/0x50
 [<c0112c22>] finish_task_switch+0x32/0x90
 [<c0112c9e>] schedule_tail+0x1e/0x60
 [<c0105df6>] ret_from_fork+0x6/0x14
(swapper/1): new 8 us maximum-latency critical section.
 => started at: <voluntary_resched+0x1e/0x50>
 => ended at:   <voluntary_resched+0x1e/0x50>
 [<c01064ae>] dump_stack+0x1e/0x20
 [<c0130c64>] check_preempt_timing+0x184/0x1e0
 [<c0130cf8>] touch_preempt_timing+0x38/0x60
 [<c0292a9e>] voluntary_resched+0x1e/0x50
 [<c013a1b6>] kmem_cache_alloc+0x56/0x60
 [<c01160c0>] copy_process+0x9e0/0xbd0
 [<c0116302>] do_fork+0x52/0x1b3
 [<c0104135>] kernel_thread+0x85/0x90
 [<c012a907>] keventd_create_kthread+0x27/0x50
 [<c012a9a7>] kthread_create+0x77/0xd0
 [<c031dc9b>] cpu_callback+0x5b/0xc0
 [<c031dd22>] spawn_ksoftirqd+0x22/0x50
 [<c0100334>] init+0x34/0x170
 [<c01040a5>] kernel_thread_helper+0x5/0x10
(swapper/1): new 9 us maximum-latency critical section.
 => started at: <voluntary_resched+0x1e/0x50>
 => ended at:   <voluntary_resched+0x1e/0x50>
 [<c01064ae>] dump_stack+0x1e/0x20
 [<c0130c64>] check_preempt_timing+0x184/0x1e0
 [<c0130cf8>] touch_preempt_timing+0x38/0x60
 [<c0292a9e>] voluntary_resched+0x1e/0x50
 [<c013a1b6>] kmem_cache_alloc+0x56/0x60
 [<c0116009>] copy_process+0x929/0xbd0
 [<c0116302>] do_fork+0x52/0x1b3
 [<c0104135>] kernel_thread+0x85/0x90
 [<c012a907>] keventd_create_kthread+0x27/0x50
 [<c012a9a7>] kthread_create+0x77/0xd0
 [<c031dc9b>] cpu_callback+0x5b/0xc0
 [<c031dd22>] spawn_ksoftirqd+0x22/0x50
 [<c0100334>] init+0x34/0x170
 [<c01040a5>] kernel_thread_helper+0x5/0x10


Here are two reports with the same maximum-latency (31 us):

(swapper/1): new 31 us maximum-latency critical section.
 => started at: <voluntary_resched+0x1e/0x50>
 => ended at:   <voluntary_resched+0x1e/0x50>
 [<c01064ae>] dump_stack+0x1e/0x20
 [<c0130c64>] check_preempt_timing+0x184/0x1e0
 [<c0130cf8>] touch_preempt_timing+0x38/0x60
 [<c0292a9e>] voluntary_resched+0x1e/0x50
 [<c013a3f0>] __kmalloc+0x80/0x90
 [<c0316279>] malloc+0x19/0x20
 [<c01024d4>] huft_build+0x2d4/0x590
 [<c0102ea1>] inflate_fixed+0xc1/0x1a0
 [<c010379a>] inflate+0x4a/0xb0
 [<c0103b89>] gunzip+0x2f9/0x530
 [<c0316e41>] unpack_to_rootfs+0x191/0x220
 [<c0316efb>] populate_rootfs+0x2b/0x130
 [<c010033e>] init+0x3e/0x170
 [<c01040a5>] kernel_thread_helper+0x5/0x10
(swapper/1): new 31 us maximum-latency critical section.
 => started at: <voluntary_resched+0x1e/0x50>
 => ended at:   <voluntary_resched+0x1e/0x50>
 [<c01064ae>] dump_stack+0x1e/0x20
 [<c0130c64>] check_preempt_timing+0x184/0x1e0
 [<c0130cf8>] touch_preempt_timing+0x38/0x60
 [<c0292a9e>] voluntary_resched+0x1e/0x50
 [<c013a1b6>] kmem_cache_alloc+0x56/0x60
 [<c015c8e9>] getname+0x29/0xc0
 [<c015f3fd>] sys_mkdir+0x1d/0xf0
 [<c03169af>] do_name+0x10f/0x1b0
 [<c0316bb1>] write_buffer+0x21/0x30
 [<c0316be4>] flush_buffer+0x24/0x60
 [<c0316c64>] flush_window+0x24/0x70
 [<c01037db>] inflate+0x8b/0xb0
 [<c0103b89>] gunzip+0x2f9/0x530
 [<c0316e41>] unpack_to_rootfs+0x191/0x220
 [<c0316efb>] populate_rootfs+0x2b/0x130
 [<c010033e>] init+0x3e/0x170
 [<c01040a5>] kernel_thread_helper+0x5/0x10
NET: Registered protocol family 16

Btw: i do have some regular ca. 300 us latencies.. Here are some traces
(these happen with an average frequency of ca. 0.3hz):


Aug 13 12:40:49 mango kernel: (ksoftirqd/0/2): 307 us critical section
violates 250 us threshold.
Aug 13 12:40:49 mango kernel:  => started at: <___do_softirq+0x20/0x90>
Aug 13 12:40:49 mango kernel:  => ended at:  
<cond_resched_softirq+0x59/0x70>
Aug 13 12:40:49 mango kernel:  [<c01064ae>] dump_stack+0x1e/0x20
Aug 13 12:40:49 mango kernel:  [<c0130c64>]
check_preempt_timing+0x184/0x1e0
Aug 13 12:40:49 mango kernel:  [<c0130cf8>]
touch_preempt_timing+0x38/0x60
Aug 13 12:40:49 mango kernel:  [<c0113df9>]
cond_resched_softirq+0x59/0x70
Aug 13 12:40:49 mango kernel:  [<c011faef>] run_timer_softirq+0xdf/0x1d0
Aug 13 12:40:49 mango kernel:  [<c011adbc>] ___do_softirq+0x7c/0x90
Aug 13 12:40:49 mango kernel:  [<c011ae19>] _do_softirq+0x9/0x10
Aug 13 12:40:49 mango kernel:  [<c011b1d4>] ksoftirqd+0x84/0xd0
Aug 13 12:40:49 mango kernel:  [<c012a8da>] kthread+0xaa/0xb0
Aug 13 12:40:49 mango kernel:  [<c01040a5>]
kernel_thread_helper+0x5/0x10
Aug 13 12:40:54 mango kernel: (ksoftirqd/0/2): 307 us critical section
violates 250 us threshold.
Aug 13 12:40:54 mango kernel:  => started at: <___do_softirq+0x20/0x90>
Aug 13 12:40:54 mango kernel:  => ended at:  
<cond_resched_softirq+0x59/0x70>
Aug 13 12:40:54 mango kernel:  [<c01064ae>] dump_stack+0x1e/0x20
Aug 13 12:40:54 mango kernel:  [<c0130c64>]
check_preempt_timing+0x184/0x1e0
Aug 13 12:40:54 mango kernel:  [<c0130cf8>]
touch_preempt_timing+0x38/0x60
Aug 13 12:40:54 mango kernel:  [<c0113df9>]
cond_resched_softirq+0x59/0x70
Aug 13 12:40:54 mango kernel:  [<c011faef>] run_timer_softirq+0xdf/0x1d0
Aug 13 12:40:54 mango kernel:  [<c011adbc>] ___do_softirq+0x7c/0x90
Aug 13 12:40:54 mango kernel:  [<c011ae19>] _do_softirq+0x9/0x10
Aug 13 12:40:54 mango kernel:  [<c011b1d4>] ksoftirqd+0x84/0xd0
Aug 13 12:40:54 mango kernel:  [<c012a8da>] kthread+0xaa/0xb0
Aug 13 12:40:54 mango kernel:  [<c01040a5>]
kernel_thread_helper+0x5/0x10
Aug 13 12:40:59 mango kernel: (ksoftirqd/0/2): 308 us critical section
violates 250 us threshold.
Aug 13 12:40:59 mango kernel:  => started at: <___do_softirq+0x20/0x90>
Aug 13 12:40:59 mango kernel:  => ended at:  
<cond_resched_softirq+0x59/0x70>
Aug 13 12:40:59 mango kernel:  [<c01064ae>] dump_stack+0x1e/0x20
Aug 13 12:40:59 mango kernel:  [<c0130c64>]
check_preempt_timing+0x184/0x1e0
Aug 13 12:40:59 mango kernel:  [<c0130cf8>]
touch_preempt_timing+0x38/0x60
Aug 13 12:40:59 mango kernel:  [<c0113df9>]
cond_resched_softirq+0x59/0x70
Aug 13 12:40:59 mango kernel:  [<c011faef>] run_timer_softirq+0xdf/0x1d0
Aug 13 12:40:59 mango kernel:  [<c011adbc>] ___do_softirq+0x7c/0x90
Aug 13 12:40:59 mango kernel:  [<c011ae19>] _do_softirq+0x9/0x10
Aug 13 12:40:59 mango kernel:  [<c011b1d4>] ksoftirqd+0x84/0xd0
Aug 13 12:40:59 mango kernel:  [<c012a8da>] kthread+0xaa/0xb0
Aug 13 12:40:59 mango kernel:  [<c01040a5>]
kernel_thread_helper+0x5/0x10
Aug 13 12:41:04 mango kernel: (ksoftirqd/0/2): 307 us critical section
violates 250 us threshold.
Aug 13 12:41:04 mango kernel:  => started at: <___do_softirq+0x20/0x90>
Aug 13 12:41:04 mango kernel:  => ended at:  
<cond_resched_softirq+0x59/0x70>
Aug 13 12:41:04 mango kernel:  [<c01064ae>] dump_stack+0x1e/0x20
Aug 13 12:41:04 mango kernel:  [<c0130c64>]
check_preempt_timing+0x184/0x1e0
Aug 13 12:41:04 mango kernel:  [<c0130cf8>]
touch_preempt_timing+0x38/0x60
Aug 13 12:41:04 mango kernel:  [<c0113df9>]
cond_resched_softirq+0x59/0x70
Aug 13 12:41:04 mango kernel:  [<c011faef>] run_timer_softirq+0xdf/0x1d0
Aug 13 12:41:04 mango kernel:  [<c011adbc>] ___do_softirq+0x7c/0x90
Aug 13 12:41:04 mango kernel:  [<c011ae19>] _do_softirq+0x9/0x10
Aug 13 12:41:04 mango kernel:  [<c011b1d4>] ksoftirqd+0x84/0xd0
Aug 13 12:41:04 mango kernel:  [<c012a8da>] kthread+0xaa/0xb0
Aug 13 12:41:04 mango kernel:  [<c01040a5>]
kernel_thread_helper+0x5/0x10
Aug 13 12:41:09 mango kernel: (ksoftirqd/0/2): 307 us critical section
violates 250 us threshold.
Aug 13 12:41:09 mango kernel:  => started at: <___do_softirq+0x20/0x90>
Aug 13 12:41:09 mango kernel:  => ended at:  
<cond_resched_softirq+0x59/0x70>
Aug 13 12:41:09 mango kernel:  [<c01064ae>] dump_stack+0x1e/0x20
Aug 13 12:41:09 mango kernel:  [<c0130c64>]
check_preempt_timing+0x184/0x1e0
Aug 13 12:41:09 mango kernel:  [<c0130cf8>]
touch_preempt_timing+0x38/0x60
Aug 13 12:41:09 mango kernel:  [<c0113df9>]
cond_resched_softirq+0x59/0x70
Aug 13 12:41:09 mango kernel:  [<c011faef>] run_timer_softirq+0xdf/0x1d0
Aug 13 12:41:09 mango kernel:  [<c011adbc>] ___do_softirq+0x7c/0x90
Aug 13 12:41:09 mango kernel:  [<c011ae19>] _do_softirq+0x9/0x10
Aug 13 12:41:09 mango kernel:  [<c011b1d4>] ksoftirqd+0x84/0xd0
Aug 13 12:41:09 mango kernel:  [<c012a8da>] kthread+0xaa/0xb0
Aug 13 12:41:09 mango kernel:  [<c01040a5>]
kernel_thread_helper+0x5/0x10

Some system info:

I do not habe preempt-tracing enabled, only voluntary preempt and
preempt timing..

Linux mango.fruits.de 2.6.8-rc4 #1 Fri Aug 13 03:05:04 CEST 2004 i686
GNU/Linux
-----------
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 7
model name      : AMD Duron(tm) Processor
stepping        : 1
cpu MHz         : 1195.497
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 2359.29

-----------
/proc/interrupts:
           CPU0       
  0:    1832325          XT-PIC  timer
  1:       8892          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  CS46XX
  8:          4          XT-PIC  rtc
 10:       2066          XT-PIC  eth0
 12:      39786          XT-PIC  i8042
 14:        900          XT-PIC  ide0
 15:      12719          XT-PIC  ide1
NMI:          0 
ERR:          0
-----------
/proc/irq/10/eth0/threaded:1
/proc/irq/12/i8042/threaded:1
/proc/irq/14/ide0/threaded:1
/proc/irq/15/ide1/threaded:1
/proc/irq/1/i8042/threaded:1
/proc/irq/5/CS46XX/threaded:0
/proc/irq/8/rtc/threaded:0
-----------
/sys/block/hda/queue/max_sectors_kb:16
/sys/block/hdd/queue/max_sectors_kb:16
-----------
voluntary_preemption
3
kernel_preemption
1
-----------
preempt_thresh
250


-- 
Palimm Palimm!
http://affenbande.org/~tapas/

