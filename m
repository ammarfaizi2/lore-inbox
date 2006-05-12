Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWELSEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWELSEW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 14:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWELSEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 14:04:22 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:53931 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932119AbWELSEV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 14:04:21 -0400
Subject: Re: [RFC][PATCH -rt] irqd starvation on SMP by a single process?
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20060512055025.GA25824@elte.hu>
References: <1147401812.1907.14.camel@cog.beaverton.ibm.com>
	 <20060512055025.GA25824@elte.hu>
Content-Type: text/plain
Date: Fri, 12 May 2006 11:04:18 -0700
Message-Id: <1147457058.9343.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-12 at 07:50 +0200, Ingo Molnar wrote:
> +		if (!cpus_equal(current->cpus_allowed, irq_affinity[irq]));
> +			set_cpus_allowed(current, irq_affinity[irq]);

Gah! I introduced a terrible bug there. 

Note the semi-colon at the end of the if statement! Sorry about that!

The following patch (which I've tested as well) fixes that.

--- 2.6-rt/kernel/irq/manage.c	2006-05-11 18:37:36.000000000 -0500
+++ dev-rt/kernel/irq/manage.c	2006-05-12 12:55:56.000000000 -0500
@@ -724,6 +724,7 @@
 		set_current_state(TASK_INTERRUPTIBLE);
 		do_hardirq(desc);
 		cond_resched_all();
+		local_irq_disable();
 		__do_softirq();
 //		do_softirq_from_hardirq();
 		local_irq_enable();
@@ -731,10 +732,8 @@
 		/*
 		 * Did IRQ affinities change?
 		 */
-		if (!cpu_isset(smp_processor_id(), irq_affinity[irq])) {
-			mask = cpumask_of_cpu(any_online_cpu(irq_affinity[irq]));
-			set_cpus_allowed(current, mask);
-		}
+		if(!cpus_equal(current->cpus_allowed, irq_affinity[irq]))
+			set_cpus_allowed(current, irq_affinity[irq]);
 #endif
 		schedule();
 	}




