Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWELCnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWELCnh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 22:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWELCng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 22:43:36 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:990 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750868AbWELCng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 22:43:36 -0400
Subject: [RFC][PATCH -rt] irqd starvation on SMP by a single process?
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain
Date: Thu, 11 May 2006 19:43:32 -0700
Message-Id: <1147401812.1907.14.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Ingo,

	I've been seeing some odd behavior recently w/ the irq smp_affinity
masks. With a single runaway -rt thread, we were getting hard hangs on
an SMP system.

Clearly, if the runaway -rt thread is running on a cpu that is getting
critical interrupts (scsi, network, etc), a system hang would be
expected. However I started playing with the proc/irq/<num>/smp_affinity
masks and got some odd behavior.

Using taskset and a small script that sets all the irq smp_affinity
values, I got the following.

./irqbind.sh 1 ; taskset 1 ./runaway  = HANG (as expected)
./irqbind.sh 1 ; taskset 2 ./runaway  = NO HANG (as expected)

./irqbind.sh 2 ; taskset 1 ./runaway  = NO HANG (as expected)
./irqbind.sh 2 ; taskset 2 ./runaway  = HANG (as expected)

Everything is cool. However, I figured we could set the irq smp_affinity
mask to multiple cpus so a runaway thread could not cause a hang.

./irqbind.sh 3 ; taskset 1 ./runaway  = Sometimes hang
./irqbind.sh 3 ; taskset 2 ./runaway  = !Sometime hang

Basically it appeared that while the irq smp_affinity mask was set for
both cpus, the irq was really being delivered to only one cpu. Looking
at the code, sure enough, that is the case.

The patch below appears to correct this issue, however it also
repeatedly(on different irqs) causes the following BUG:

BUG: using smp_processor_id() in preemptible [00000000] code: IRQ 24/1518
caller is __do_softirq+0x10/0x51					 
 [<c0263bc3>] debug_smp_processor_id+0x7b/0x88 (8)
 [<c0126936>] __do_softirq+0x10/0x51 (12)	  
 [<c0141195>] do_irqd+0xd8/0x10e (12)	 
 [<c013250f>] kthread+0x7c/0xa6 (24) 
 [<c0132493>] kthread+0x0/0xa6 (20) 
 [<c0101041>] kernel_thread_helper+0x5/0xb (16)
---------------------------		       
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c0263b83>] .... debug_smp_processor_id+0x3b/0x88
.....[<00000000>] ..   ( <= rest_init+0x3feffd64/0x3d)
						      
------------------------------
| showing all locks held by: |	(IRQ 24/1518 [f7b11070,  60]):


Thoughts?
-john


--- 2.6-rt/kernel/irq/manage.c	2006-05-11 18:37:36.000000000 -0500
+++ dev-rt/kernel/irq/manage.c	2006-05-11 21:09:10.000000000 -0500
@@ -731,10 +731,8 @@
 		/*
 		 * Did IRQ affinities change?
 		 */
-		if (!cpu_isset(smp_processor_id(), irq_affinity[irq])) {
-			mask = cpumask_of_cpu(any_online_cpu(irq_affinity[irq]));
-			set_cpus_allowed(current, mask);
-		}
+		if(!cpus_equal(current->cpus_allowed, irq_affinity[irq]));
+			set_cpus_allowed(current, irq_affinity[irq]);
 #endif
 		schedule();
 	}


