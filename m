Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVAGVtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVAGVtP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVAGVo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:44:28 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:6081 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261641AbVAGVmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:42:35 -0500
Subject: [PATCH] introduce idle_task_exit
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
       Rusty Russell <rusty@rustcorp.com.au>, paulus@au1.ibm.com,
       lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050107114353.GA29779@elte.hu>
References: <20050104131101.GA3560@osiris.boeblingen.de.ibm.com>
	 <1104892877.8954.27.camel@localhost.localdomain>
	 <20050105110833.GA14956@elte.hu>
	 <1104939854.18695.29.camel@localhost.localdomain>
	 <20050107114353.GA29779@elte.hu>
Content-Type: text/plain
Message-Id: <1105134189.13391.6.camel@pants.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 07 Jan 2005 15:43:09 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 05:43, Ingo Molnar wrote:
> * Nathan Lynch <nathanl@austin.ibm.com> wrote:
> 
> > OK, how's this?  I'll submit the sched and ppc64 bits separately if
> > there are no objections.  I assume Heiko can take care of s390.
> > 
> > Note that in the ppc64 cpu_die function we must call idle_task_exit
> > before calling ppc_md.cpu_die, because the latter does not return.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>


Heiko Carstens figured out that offlining a cpu can leak mm_structs
because the dying cpu's idle task fails to switch to init_mm and
mmdrop its active_mm before the cpu is down.  This patch introduces
idle_task_exit, which allows the idle task to do this as Ingo
suggested.

I will follow this up with a patch for ppc64 which calls
idle_task_exit from cpu_die.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>


---


diff -puN kernel/sched.c~sched-idle_task_exit kernel/sched.c
--- linux-2.6.10-bk10/kernel/sched.c~sched-idle_task_exit	2005-01-07 15:23:35.000000000 -0600
+++ linux-2.6.10-bk10-nathanl/kernel/sched.c	2005-01-07 15:23:35.000000000 -0600
@@ -3996,6 +3996,20 @@ void sched_idle_next(void)
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
diff -puN include/linux/sched.h~sched-idle_task_exit include/linux/sched.h
--- linux-2.6.10-bk10/include/linux/sched.h~sched-idle_task_exit	2005-01-07 15:23:35.000000000 -0600
+++ linux-2.6.10-bk10-nathanl/include/linux/sched.h	2005-01-07 15:23:35.000000000 -0600
@@ -757,6 +757,7 @@ extern void sched_exec(void);
 #endif
 
 extern void sched_idle_next(void);
+extern void idle_task_exit(void);
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(const task_t *p);
 extern int task_nice(const task_t *p);

_


