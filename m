Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292222AbSB0GrJ>; Wed, 27 Feb 2002 01:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292228AbSB0GrB>; Wed, 27 Feb 2002 01:47:01 -0500
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:40403 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S292222AbSB0Gqm>; Wed, 27 Feb 2002 01:46:42 -0500
Message-ID: <3C7C80D7.59F983B6@didntduck.org>
Date: Wed, 27 Feb 2002 01:46:47 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.6-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Use list heads for task list
Content-Type: multipart/mixed;
 boundary="------------7FF53C54D65C1C11E9E63E4E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7FF53C54D65C1C11E9E63E4E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch (against 2.5.6-pre1) converts prev_task and next_task in the
task_struct to use list heads.

-- 

						Brian Gerst
--------------7FF53C54D65C1C11E9E63E4E
Content-Type: text/plain; charset=us-ascii;
 name="task_list-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="task_list-1"

diff -urN linux-2.5.6-pre1/arch/alpha/kernel/smp.c linux/arch/alpha/kernel/smp.c
--- linux-2.5.6-pre1/arch/alpha/kernel/smp.c	Wed Feb 20 01:47:29 2002
+++ linux/arch/alpha/kernel/smp.c	Tue Feb 26 22:53:02 2002
@@ -460,7 +460,7 @@
 	if (fork_by_hand() < 0)
 		panic("failed fork for CPU %d", cpuid);
 
-	idle = init_task.prev_task;
+	idle = LAST_TASK;
 	if (!idle)
 		panic("No idle process for CPU %d", cpuid);
 
diff -urN linux-2.5.6-pre1/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- linux-2.5.6-pre1/arch/i386/kernel/smpboot.c	Wed Feb 20 01:47:29 2002
+++ linux/arch/i386/kernel/smpboot.c	Tue Feb 26 22:53:02 2002
@@ -828,7 +828,7 @@
 	 * We remove it from the pidhash and the runqueue
 	 * once we got the process:
 	 */
-	idle = init_task.prev_task;
+	idle = LAST_TASK;
 	if (!idle)
 		panic("No idle process for CPU %d", cpu);
 
diff -urN linux-2.5.6-pre1/arch/ia64/kernel/smpboot.c linux/arch/ia64/kernel/smpboot.c
--- linux-2.5.6-pre1/arch/ia64/kernel/smpboot.c	Wed Nov 21 13:31:09 2001
+++ linux/arch/ia64/kernel/smpboot.c	Tue Feb 26 22:53:02 2002
@@ -412,7 +412,7 @@
 	 * We remove it from the pidhash and the runqueue
 	 * once we got the process:
 	 */
-	idle = init_task.prev_task;
+	idle = LAST_TASK;
 	if (!idle)
 		panic("No idle process for CPU %d", cpu);
 
diff -urN linux-2.5.6-pre1/arch/mips/kernel/smp.c linux/arch/mips/kernel/smp.c
--- linux-2.5.6-pre1/arch/mips/kernel/smp.c	Wed Feb  6 11:47:02 2002
+++ linux/arch/mips/kernel/smp.c	Tue Feb 26 22:53:02 2002
@@ -123,7 +123,7 @@
 		/* Spawn a new process normally.  Grab a pointer to
 		   its task struct so we can mess with it */
 		do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
-		p = init_task.prev_task;
+		p = LAST_TASK;
 
 		/* Schedule the first task manually */
 		p->processor = i;
@@ -152,7 +152,7 @@
 		 * Linux can schedule processes on this slave.
 		 */
 		kernel_thread(0, NULL, CLONE_PID);
-		p = init_task.prev_task;
+		p = LAST_TASK;
 		sprintf(p->comm, "%s%d", "Idle", i);
 		init_tasks[i] = p;
 		p->processor = i;
diff -urN linux-2.5.6-pre1/arch/mips64/sgi-ip27/ip27-init.c linux/arch/mips64/sgi-ip27/ip27-init.c
--- linux-2.5.6-pre1/arch/mips64/sgi-ip27/ip27-init.c	Wed Nov 21 13:31:09 2001
+++ linux/arch/mips64/sgi-ip27/ip27-init.c	Tue Feb 26 22:53:02 2002
@@ -491,7 +491,7 @@
 			 * Linux can schedule processes on this slave.
 			 */
 			kernel_thread(0, NULL, CLONE_PID);
-			p = init_task.prev_task;
+			p = LAST_TASK;
 			sprintf(p->comm, "%s%d", "Idle", num_cpus);
 			init_tasks[num_cpus] = p;
 			alloc_cpupda(cpu, num_cpus);
diff -urN linux-2.5.6-pre1/arch/ppc/kernel/smp.c linux/arch/ppc/kernel/smp.c
--- linux-2.5.6-pre1/arch/ppc/kernel/smp.c	Wed Feb 20 01:47:30 2002
+++ linux/arch/ppc/kernel/smp.c	Tue Feb 26 22:53:02 2002
@@ -364,7 +364,7 @@
 		memset(&regs, 0, sizeof(struct pt_regs));
 		if (do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0) < 0)
 			panic("failed fork for CPU %d", i);
-		p = init_task.prev_task;
+		p = LAST_TASK;
 		if (!p)
 			panic("No idle task for CPU %d", i);
 		init_idle(p, i);
diff -urN linux-2.5.6-pre1/arch/ppc64/kernel/smp.c linux/arch/ppc64/kernel/smp.c
--- linux-2.5.6-pre1/arch/ppc64/kernel/smp.c	Wed Feb 20 01:47:31 2002
+++ linux/arch/ppc64/kernel/smp.c	Tue Feb 26 22:53:02 2002
@@ -669,7 +669,7 @@
 
 		if (do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0) < 0)
 			panic("failed fork for CPU %d", i);
-		p = init_task.prev_task;
+		p = LAST_TASK;
 		if (!p)
 			panic("No idle task for CPU %d", i);
 
diff -urN linux-2.5.6-pre1/arch/s390/kernel/smp.c linux/arch/s390/kernel/smp.c
--- linux-2.5.6-pre1/arch/s390/kernel/smp.c	Wed Feb  6 11:46:55 2002
+++ linux/arch/s390/kernel/smp.c	Tue Feb 26 22:53:02 2002
@@ -528,7 +528,7 @@
          * We remove it from the pidhash and the runqueue
          * once we got the process:
          */
-        idle = init_task.prev_task;
+        idle = LAST_TASK;
         if (!idle)
                 panic("No idle process for CPU %d",cpu);
         idle->processor = cpu;
diff -urN linux-2.5.6-pre1/arch/s390x/kernel/smp.c linux/arch/s390x/kernel/smp.c
--- linux-2.5.6-pre1/arch/s390x/kernel/smp.c	Wed Feb  6 11:46:55 2002
+++ linux/arch/s390x/kernel/smp.c	Tue Feb 26 22:53:02 2002
@@ -507,7 +507,7 @@
          * We remove it from the pidhash and the runqueue
          * once we got the process:
          */
-        idle = init_task.prev_task;
+        idle = LAST_TASK;
         if (!idle)
                 panic("No idle process for CPU %d",cpu);
         idle->processor = cpu;
diff -urN linux-2.5.6-pre1/arch/sparc/kernel/sun4d_smp.c linux/arch/sparc/kernel/sun4d_smp.c
--- linux-2.5.6-pre1/arch/sparc/kernel/sun4d_smp.c	Wed Feb  6 11:46:55 2002
+++ linux/arch/sparc/kernel/sun4d_smp.c	Tue Feb 26 22:53:02 2002
@@ -220,7 +220,7 @@
 
 			cpucount++;
 
-			p = init_task.prev_task;
+			p = LAST_TASK;
 
 			p->cpu = i;
 
diff -urN linux-2.5.6-pre1/arch/sparc/kernel/sun4m_smp.c linux/arch/sparc/kernel/sun4m_smp.c
--- linux-2.5.6-pre1/arch/sparc/kernel/sun4m_smp.c	Wed Feb  6 11:46:55 2002
+++ linux/arch/sparc/kernel/sun4m_smp.c	Tue Feb 26 22:53:02 2002
@@ -193,7 +193,7 @@
 
 			cpucount++;
 
-			p = init_task.prev_task;
+			p = LAST_TASK;
 
 			p->cpu = i;
 
diff -urN linux-2.5.6-pre1/arch/sparc64/kernel/smp.c linux/arch/sparc64/kernel/smp.c
--- linux-2.5.6-pre1/arch/sparc64/kernel/smp.c	Mon Feb 11 10:21:43 2002
+++ linux/arch/sparc64/kernel/smp.c	Tue Feb 26 22:53:02 2002
@@ -270,7 +270,7 @@
 			kernel_thread(NULL, NULL, CLONE_PID);
 			cpucount++;
 
-			p = init_task.prev_task;
+			p = LAST_TASK;
 
 			init_idle(p, i);
 
diff -urN linux-2.5.6-pre1/arch/x86_64/kernel/smpboot.c linux/arch/x86_64/kernel/smpboot.c
--- linux-2.5.6-pre1/arch/x86_64/kernel/smpboot.c	Wed Feb 20 01:47:31 2002
+++ linux/arch/x86_64/kernel/smpboot.c	Tue Feb 26 22:53:02 2002
@@ -559,7 +559,7 @@
 	 * We remove it from the pidhash and the runqueue
 	 * once we got the process:
 	 */
-	idle = init_task.prev_task;
+	idle = LAST_TASK;
 	if (!idle)
 		panic("No idle process for CPU %d", cpu);
 
diff -urN linux-2.5.6-pre1/include/linux/init_task.h linux/include/linux/init_task.h
--- linux-2.5.6-pre1/include/linux/init_task.h	Tue Feb 26 23:56:18 2002
+++ linux/include/linux/init_task.h	Wed Feb 27 00:40:43 2002
@@ -53,8 +53,7 @@
     active_mm:		&init_mm,					\
     run_list:		LIST_HEAD_INIT(tsk.run_list),			\
     time_slice:		HZ,						\
-    next_task:		&tsk,						\
-    prev_task:		&tsk,						\
+    task_list:		LIST_HEAD_INIT(tsk.task_list),			\
     p_opptr:		&tsk,						\
     p_pptr:		&tsk,						\
     thread_group:	LIST_HEAD_INIT(tsk.thread_group),		\
diff -urN linux-2.5.6-pre1/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.6-pre1/include/linux/sched.h	Tue Feb 26 23:52:17 2002
+++ linux/include/linux/sched.h	Wed Feb 27 00:36:21 2002
@@ -250,7 +250,7 @@
 	unsigned long cpus_allowed;
 	unsigned int time_slice;
 
-	struct task_struct *next_task, *prev_task;
+	struct list_head task_list;
 
 	struct mm_struct *mm, *active_mm;
 	struct list_head local_pages;
@@ -716,8 +716,7 @@
 })
 
 #define REMOVE_LINKS(p) do { \
-	(p)->next_task->prev_task = (p)->prev_task; \
-	(p)->prev_task->next_task = (p)->next_task; \
+	list_del(&(p)->task_list); \
 	if ((p)->p_osptr) \
 		(p)->p_osptr->p_ysptr = (p)->p_ysptr; \
 	if ((p)->p_ysptr) \
@@ -727,18 +726,20 @@
 	} while (0)
 
 #define SET_LINKS(p) do { \
-	(p)->next_task = &init_task; \
-	(p)->prev_task = init_task.prev_task; \
-	init_task.prev_task->next_task = (p); \
-	init_task.prev_task = (p); \
+	list_add_tail(&(p)->task_list, &init_task.task_list); \
 	(p)->p_ysptr = NULL; \
 	if (((p)->p_osptr = (p)->p_pptr->p_cptr) != NULL) \
 		(p)->p_osptr->p_ysptr = p; \
 	(p)->p_pptr->p_cptr = p; \
 	} while (0)
 
-#define for_each_task(p) \
-	for (p = &init_task ; (p = p->next_task) != &init_task ; )
+#define LAST_TASK list_entry(init_task.task_list.prev, struct task_struct, task_list)
+
+#define for_each_task(task) \
+	for (task = next_task(&init_task) ; task != &init_task ; task = next_task(task))
+
+#define next_task(p) \
+	list_entry((p)->task_list.next, struct task_struct, task_list)
 
 #define for_each_thread(task) \
 	for (task = next_thread(current) ; task != current ; task = next_thread(task))

--------------7FF53C54D65C1C11E9E63E4E--

