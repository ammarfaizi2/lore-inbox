Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267678AbTAHCln>; Tue, 7 Jan 2003 21:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267682AbTAHCln>; Tue, 7 Jan 2003 21:41:43 -0500
Received: from fmr01.intel.com ([192.55.52.18]:16366 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267678AbTAHClk> convert rfc822-to-8bit;
	Tue, 7 Jan 2003 21:41:40 -0500
content-class: urn:content-classes:message
Subject: [2.5] IRQ distribution in the 2.5.52  kernel
Date: Tue, 7 Jan 2003 18:50:18 -0800
Message-ID: <E88224AA79D2744187E7854CA8D9131DA5CE51@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.5] IRQ distribution in the 2.5.52  kernel
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcK2wK3Wu0R7hFpGRJaVfQgiQkMzbg==
From: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
To: <linux-kernel@vger.kernel.org>,
       "Kamble, Nitin A" <nitin.a.kamble@intel.com>
Cc: "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 08 Jan 2003 02:50:19.0688 (UTC) FILETIME=[AE782280:01C2B6C0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

  We were looking at the performance impact of the IRQ routing from
the 2.5.52 Linux kernel. This email includes some of our findings 
about the way the interrupts are getting moved in the 2.5.52 kernel. 
Also there is discussion and a patch for a new implementation. Let 
me know what you think at nitin.a.kamble@intel.com
 
Current implementation:
======================
We have found that the existing implementation works well on IA32 
SMP systems with light load of interrupts. Also we noticed that it
is not working that well under heavy interrupt load conditions on 
these SMP systems. The observations are:
 
* Interrupt load of each IRQ is getting balanced on CPUs independent 
of load of other IRQs. Also the current implementation moves the 
IRQs randomly. This works well when the interrupt load is light. But 
we start seeing imbalance of interrupt load with existence of 
multiple heavy interrupt sources. Frequently multiple heavily loaded 
IRQs gets moved to a single CPU while other CPUs stay very lightly 
loaded. To achieve a good interrupts load balance, it is important to 
consider the load of all the interrupts together.
    This further can be explained with an example of 4 CPUs and 4 
heavy interrupt sources. With the existing random movement approach, 
the chance of each of these heavy interrupt sources moving to separate 
CPUs is: (4/4)*(3/4)*(2/4)*(1/4) = 3/16. It means 13/16 = 81.25% of 
the time the situation is, some CPUs are very lightly loaded and some 
are loaded with multiple heavy interrupts. This causes the interrupt 
load imbalance and results in less performance. In a case of 2 CPUs 
and 2 heavily loaded interrupt sources, this imbalance happens 
1/2 = 50% of the times. This issue becomes more and more severe with 
increasing number of heavy interrupt sources.
 
* Another interesting observation is: We cannot see the imbalance 
of the interrupt load from /proc/interrupts. (/proc/interrupts shows 
the cumulative load of interrupts on all CPUs.) If the interrupt load 
is imbalanced and this imbalance is getting rotated among CPUs 
continuously, then /proc/interrupts will still show that the interrupt 
load is going to processors very evenly. Currently at the frequency 
(HZ/50) at which IRQs are moved across CPUs, it is not possible to 
see any interrupt load imbalance happening.
 
* We have also found that, in certain cases the static IRQ binding 
performs better than the existing kernel distribution of interrupt 
load. The reason is, in a well-balanced interrupt load situations, 
these interrupts are unnecessarily getting frequently moved across 
CPUs. This adds an extra overhead; also it takes off the CPU cache 
warmth benefits.
  This came out from the performance measurements done on a 4-way HT 
(8 logical processors) Pentium 4 Xeon system running 8 copies of 
netperf. The 4 NICs in the system taking different IRQs generated 
sizable interrupt load with the help of connected clients.
 
Here the netperf transactions/sec throughput numbers observed are:
 
IRQs nicely manually bound to CPUs: 56.20K 
The current kernel implementation of IRQ movement: 50.05K
 -----------------------
 The static binding of IRQs has performed 12.28% better than the 
current IRQ movement implemented in the kernel.
 
* The current implementation does not distinguish siblings from the 
HT (Hyper-Threading(tm)) enabled CPUs. It will be beneficial to 
balance the interrupt load with respect to processor packages first, 
and then among logical CPUs inside processor packages. 
  For example if we have 2 heavy interrupt sources and 2 processor 
packages (4 logical CPUs); Assigning both the heavy interrupt sources 
in different processor packages is better, it will use different 
execution resources from the different processor packages.
 
 

New revised implementation:
==========================
We also have been working on a new implementation. The following 
points are in main focus.
 
* At any moment heavily loaded IRQs are distributed to different 
CPUs to achieve as much balance as possible. 
 
* Lightly loaded interrupt sources are ignored from the load 
balancing, as they do not cause considerable imbalance.
 
* When the heavy interrupt sources are balanced, they are not moved 
around. This also helps in keeping the CPU caches warm.
 
* It has been made HT aware. While distributing the load, the load 
on a processor package to which the logical CPUs belong to is also 
considered.
 
* In the situations of few (lesser than num_cpus) heavy interrupt 
sources, it is not possible to balance them evenly. In such case 
the existing code has been reused to move the interrupts. The 
randomness from the original code has been removed.
 
* The time interval for redistribution has been made flexible. It 
varies as the system interrupt load changes.
 
* A new kernel_thread is introduced to do the load balancing 
calculations for all the interrupt sources. It keeps the balanace_maps 
ready for interrupt handlers, keeping the overhead in the interrupt 
handling to minimum.
 
* It allows the disabling of the IRQ distribution from the boot loader 
command line, if anybody wants to do it for any reason. 
 
* The algorithm also takes into account the static binding of 
interrupts to CPUs that user imposes from the 
/proc/irq/{n}/smp_affinity interface.
 
 
Throughput numbers with the netperf setup for the new implementation:
 
Current kernel IRQ balance implementation: 50.02K transactions/sec
The new IRQ balance implementation: 56.01K transactions/sec
 ---------------------
  The performance improvement on P4 Xeon of 11.9% is observed.
 
The new IRQ balance implementation also shows little performance 
improvement on P6 (Pentium II, III) systems.
 
On a P6 system the netperf throughput numbers are:
Current kernel IRQ balance implementation: 36.96K transactions/sec
The new IRQ balance implementation: 37.65K transactions/sec
 ---------------------
Here the performance improvement on P6 system of about 2% is observed.
 
 
Thanks & Regards,
Nitin

