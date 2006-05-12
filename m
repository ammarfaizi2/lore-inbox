Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWELIWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWELIWn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 04:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWELIWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 04:22:43 -0400
Received: from outbound.mailhop.org ([63.208.196.171]:56327 "EHLO
	outbound.mailhop.org") by vger.kernel.org with ESMTP
	id S1751082AbWELIWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 04:22:42 -0400
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 69.217.236.13
X-Report-Abuse-To: abuse@dyndns.com (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: ekillips
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5563ACF3-3B20-47D3-B487-0152DF2A2D0F@yakko.cs.wmich.edu>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Content-Transfer-Encoding: 7bit
From: Edward Killips <camber@yakko.cs.wmich.edu>
Subject: [RFC][PATCH -rt] irqd starvation on SMP by a single process?
Date: Fri, 12 May 2006 00:22:38 -0400
To: Ingo Molnar <mingo@elte.hu>
X-Mailer: Apple Mail (2.749.3)
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

BUG: using smp_processor_id() in preemptible [00000000] code: IRQ  
24/1518
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


-
To unsubscribe from this list: send the line "unsubscribe linux- 
kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
