Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbVAEPyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbVAEPyr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 10:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbVAEPxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 10:53:06 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:57070 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262474AbVAEPjV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 10:39:21 -0500
Subject: Re: [BUG] mm_struct leak on cpu hotplug (s390/ppc64)
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, rusty@rustcorp.com.au,
       paulus@au1.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050105110833.GA14956@elte.hu>
References: <20050104131101.GA3560@osiris.boeblingen.de.ibm.com>
	 <1104892877.8954.27.camel@localhost.localdomain>
	 <20050105110833.GA14956@elte.hu>
Content-Type: text/plain
Date: Wed, 05 Jan 2005 09:44:14 -0600
Message-Id: <1104939854.18695.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-05 at 12:08 +0100, Ingo Molnar wrote:
> the correct solution i think would be to call back into the scheduler
> from cpu_die():
> 
> void cpu_die(void)
> {
>         if (ppc_md.cpu_die)
>                 ppc_md.cpu_die();
> +	idle_task_exit();
>         local_irq_disable();
>         for (;;);
> }
> 
> and then in idle_task_exit(), do something like:
> 
> void idle_task_exit(void)
> {
> 	struct mm_struct *mm = current->active_mm;
> 
> 	if (mm != &init_mm)
> 		switch_mm(mm, &init_mm, current);
> 	mmdrop(mm);
> }
> 
> (completely untested.) This makes sure that the idle task uses the
> init_mm (which always has valid pagetables), and also ensures correct
> reference-counting. Hm?

OK, how's this?  I'll submit the sched and ppc64 bits separately if
there are no objections.  I assume Heiko can take care of s390.

Note that in the ppc64 cpu_die function we must call idle_task_exit
before calling ppc_md.cpu_die, because the latter does not return.

Nathan


Index: 2.6.10/include/linux/sched.h
===================================================================
--- 2.6.10.orig/include/linux/sched.h	2004-12-24 21:33:59.000000000 +0000
+++ 2.6.10/include/linux/sched.h	2005-01-05 14:30:39.000000000 +0000
@@ -735,6 +735,7 @@
 #endif
 
 extern void sched_idle_next(void);
+extern void idle_task_exit(void);
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(const task_t *p);
 extern int task_nice(const task_t *p);
Index: 2.6.10/kernel/sched.c
===================================================================
--- 2.6.10.orig/kernel/sched.c	2004-12-24 21:35:24.000000000 +0000
+++ 2.6.10/kernel/sched.c	2005-01-05 14:36:40.000000000 +0000
@@ -3995,6 +3995,20 @@
 	spin_unlock_irqrestore(&rq->lock, flags);
 }
 
+/* Ensures that the idle task is using init_mm right before its cpu goes
+ * offline.
+ */
+void idle_task_exit(void)
+{
+	struct mm_struct *mm = current->active_mm;
+
+	BUG_ON(cpu_online(smp_processor_id()));
+
+	if (mm != &init_mm)
+		switch_mm(mm, &init_mm, current);
+	mmdrop(mm);
+}
+
 static void migrate_dead(unsigned int dead_cpu, task_t *tsk)
 {
 	struct runqueue *rq = cpu_rq(dead_cpu);
Index: 2.6.10/arch/ppc64/kernel/setup.c
===================================================================
--- 2.6.10.orig/arch/ppc64/kernel/setup.c	2004-12-24 21:34:44.000000000 +0000
+++ 2.6.10/arch/ppc64/kernel/setup.c	2005-01-05 14:39:43.000000000 +0000
@@ -1337,6 +1337,7 @@
 
 void cpu_die(void)
 {
+	idle_task_exit();
 	if (ppc_md.cpu_die)
 		ppc_md.cpu_die();
 	local_irq_disable();


