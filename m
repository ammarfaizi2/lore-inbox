Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291767AbSBAOTt>; Fri, 1 Feb 2002 09:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291765AbSBAOTa>; Fri, 1 Feb 2002 09:19:30 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:25765 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S291762AbSBAOTN>; Fri, 1 Feb 2002 09:19:13 -0500
Date: Fri, 1 Feb 2002 15:19:00 +0100 (MET)
From: Erich Focht <efocht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: O(1) J9 scheduler: set_cpus_allowed
Message-ID: <Pine.LNX.4.21.0202011435500.6004-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

the function set_cpus_allowed(task_t *p, unsigned long new_mask)
works "as is" only if called for the task p=current. The appended patch
corrects this and enables e.g. external load balancers to change the
cpus_allowed mask of an arbitrary process.

BTW: how about migrating the definition of the structures runqueue and
prio_array into include/linux/sched.h and exporting the symbol
runqueues? It would help with debugging, monitoring and other
developments.

Thanks,
Best regards,
Erich

--- 2.4.17-IA64-kdb-J9/kernel/sched.c	Thu Jan 31 18:39:37 2002
+++ 2.4.17-IA64-kdb-J9ia64/kernel/sched.c	Fri Feb  1 16:06:40 2002
@@ -859,16 +868,16 @@
 
 	p->cpus_allowed = new_mask;
 	/*
-	 * Can the task run on the current CPU? If not then
+	 * Can the task run on its current CPU? If not then
 	 * migrate the process off to a proper CPU.
 	 */
-	if (new_mask & (1UL << smp_processor_id()))
+	if (new_mask & (1UL << p->cpu))
 		return;
 #if CONFIG_SMP
-	current->state = TASK_UNINTERRUPTIBLE;
-	smp_migrate_task(__ffs(new_mask), current);
-
-	schedule();
+	p->state = TASK_UNINTERRUPTIBLE;
+	smp_migrate_task(__ffs(new_mask), p);
+	if (p == current)
+		schedule();
 #endif
 }
 

