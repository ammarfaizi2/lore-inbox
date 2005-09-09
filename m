Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965238AbVIICK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbVIICK5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 22:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbVIICK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 22:10:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:57258 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965238AbVIICK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 22:10:57 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Scheduler hooks to support separate ia64 MCA/INIT stacks
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 09 Sep 2005 12:10:51 +1000
Message-ID: <6922.1126231851@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new ia64 MCA/INIT handlers[1] (think of them as super NMI) run on
separate stacks.  99% of the changes for these new handlers is ia64
only code, however they need a couple of scheduler hooks to support
these extra stacks.  The complete patch set will be coming through the
ia64 tree, this RFC covers just the scheduler changes, so they do not
come as a surprise when the ia64 tree is rolled up.

[1] http://marc.theaimsgroup.com/?l=linux-ia64&m=112537827113545&w=2
    and the following patches.

IA64 MCA/INIT are completely asynchronous events.  They can be
delivered even when normal interrupts are disabled.  The cpu can be in
user context, in kernel context, in prom called from the kernel, the
cpu can even be in physical addressing mode with no valid stack
pointers when MCA/INIT is delivered.

Because of all the modes in which these events can occur, it is not
safe to use the normal kernel stacks, mainly because we cannot always
tell what state the kernel stacks are in when MCA/INIT is delivered.
The new MCA/INIT handlers define some additional per-cpu stacks.  When
MCA/INIT is delivered, the cpu starts using the relevant per-cpu stack,
effectively running as a new process.  If the original kernel stack can
be identified and verified then the process that was interrupted is
modified to look like a blocked task.

IA64 backtrace has two distinct starting points, a task can either be
running or it can be blocked.  The ia64 unwinder starts with two
different states, depending on the task state.  Since MCA/INIT
backtrace is done using one cpu to list all the tasks, there has to be
a way for the backtrace code to determine if a task is running on
another cpu or is blocked.  In 2.4 we used to have a flag to say that a
task was running on a cpu.  In 2.6, that data is stored in
cpu_curr(cpu), which needs to be exposed to support ia64 MCA/INIT
handlers.

The new MCA/INIT handlers are the equivalent of an asynchronous context
switch.  Because MCA/INIT can be delivered at any time, the handlers
cannot trust the state of any spinlock, MCA/INIT can occur when
spin_lock_irq has been issued, i.e. they can occur in the middle of
critical code.  Therefore it is not safe to call the normal scheduler
functions which update the runqueues.

This patch adds two small hooks that can be safely called from MCA/INIT
context.  If other architectures want to support NMI on separate stacks
then they can also use these functions.


Index: linux/include/linux/sched.h
===================================================================
- --- linux.orig/include/linux/sched.h	2005-09-08 16:47:05.668290545 +1000
+++ linux/include/linux/sched.h	2005-09-08 16:47:08.165015793 +1000
@@ -883,6 +883,8 @@ extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, struct sched_param *);
 extern task_t *idle_task(int cpu);
+extern task_t *curr_task(int cpu);
+extern void set_curr_task(int cpu, task_t *p);
 
 void yield(void);
 
Index: linux/kernel/sched.c
===================================================================
- --- linux.orig/kernel/sched.c	2005-09-08 16:47:05.669266973 +1000
+++ linux/kernel/sched.c	2005-09-09 11:36:53.017356186 +1000
@@ -3471,6 +3471,32 @@ task_t *idle_task(int cpu)
 }
 
 /**
+ * curr_task - return the current task for a given cpu.
+ * @cpu: the processor in question.
+ */
+task_t *curr_task(int cpu)
+{
+	return cpu_curr(cpu);
+}
+
+/**
+ * set_curr_task - set the current task for a given cpu.
+ * @cpu: the processor in question.
+ * @p: the task pointer to set.
+ *
+ * Description: This function must only be used when non-maskable interrupts
+ * are serviced on a separate stack.  It allows the architecture to switch the
+ * notion of the current task on a cpu in a non-blocking manner.  This function
+ * must be called with interrupts disabled, the caller must save the original
+ * value of the current task (see curr_task() above) and restore that value
+ * before reenabling interrupts.
+ */
+void set_curr_task(int cpu, task_t *p)
+{
+	cpu_curr(cpu) = p;
+}
+
+/**
  * find_process_by_pid - find a process with a matching PID value.
  * @pid: the pid in question.
  */




