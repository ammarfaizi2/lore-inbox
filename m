Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131671AbRBQNyX>; Sat, 17 Feb 2001 08:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131672AbRBQNyO>; Sat, 17 Feb 2001 08:54:14 -0500
Received: from ns.caldera.de ([212.34.180.1]:37897 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S131671AbRBQNyC>;
	Sat, 17 Feb 2001 08:54:02 -0500
Date: Sat, 17 Feb 2001 14:27:06 +0100
Message-Id: <200102171327.OAA00342@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: thomas.widmann@icn.siemens.de ("Thomas Widmann")
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP: bind process to cpu
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <BGEDIODHBENLENEMBEPAEEDFCAAA.thomas.widmann@icn.siemens.de>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <BGEDIODHBENLENEMBEPAEEDFCAAA.thomas.widmann@icn.siemens.de> you wrote:
> Hi,
>
> I run an 3*XEON 550MHz Primergy with 2GB of RAM.
> On this machine, i have compiled kernel 2.4.0SMP.
>
> Is it possible to bind a process to a specific
> cpu on this SMP machine (process affinity) ?

Linux 2.4 is mostlu ready for process affinity, but it is not (yet)
exported to userspace.  I've attached at patch by Nick Pollitt from SGI
that allows to enable process pinning using prctl().

> I there something like pset ?

I've seen patches for SGI-like psets for 2.2.<something>, but not for 2.4.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.


diff -X /home/npollitt/dontdiff -Nur origlinux/fs/proc/array.c linux/fs/proc/array.c
--- origlinux/fs/proc/array.c	Tue Nov 14 11:22:36 2000
+++ linux/fs/proc/array.c	Thu Jan 25 15:17:35 2001
@@ -347,7 +347,7 @@
 	read_unlock(&tasklist_lock);
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %lu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d\n",
+%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu\n",
 		task->pid,
 		task->comm,
 		state,
@@ -390,7 +390,8 @@
 		task->nswap,
 		task->cnswap,
 		task->exit_signal,
-		task->processor);
+		task->processor,
+		task->cpus_allowed);
 	if(mm)
 		mmput(mm);
 	return res;
diff -X /home/npollitt/dontdiff -Nur origlinux/include/linux/prctl.h linux/include/linux/prctl.h
--- origlinux/include/linux/prctl.h	Sun Mar 19 11:15:32 2000
+++ linux/include/linux/prctl.h	Thu Jan 25 15:17:35 2001
@@ -20,4 +20,9 @@
 #define PR_GET_KEEPCAPS   7
 #define PR_SET_KEEPCAPS   8
 
+#define PR_GET_RUNON	  9
+#define PR_SET_RUNON	  10
+#define PR_MUSTRUN_PID    11
+#define PR_RUNANY_PID     12
+
 #endif /* _LINUX_PRCTL_H */
diff -X /home/npollitt/dontdiff -Nur origlinux/kernel/sched.c linux/kernel/sched.c
--- origlinux/kernel/sched.c	Thu Jan  4 13:50:38 2001
+++ linux/kernel/sched.c	Thu Jan 25 17:22:23 2001
@@ -108,6 +108,10 @@
 #ifdef CONFIG_SMP
 
 #define idle_task(cpu) (init_tasks[cpu_number_map(cpu)])
+#define can_schedule_goodness(p,cpu) ( (!(p)->has_cpu ||  \
+                                        p->processor == cpu) &&  \
+                                        ((p)->cpus_allowed & (1 << cpu)))
+
 #define can_schedule(p,cpu) ((!(p)->has_cpu) && \
 				((p)->cpus_allowed & (1 << cpu)))
 
@@ -568,7 +572,7 @@
 still_running_back:
 	list_for_each(tmp, &runqueue_head) {
 		p = list_entry(tmp, struct task_struct, run_list);
-		if (can_schedule(p, this_cpu)) {
+		if (can_schedule_goodness(p, this_cpu)) {
 			int weight = goodness(p, this_cpu, prev->active_mm);
 			if (weight > c)
 				c = weight, next = p;
diff -X /home/npollitt/dontdiff -Nur origlinux/kernel/sys.c linux/kernel/sys.c
--- origlinux/kernel/sys.c	Mon Oct 16 12:58:51 2000
+++ linux/kernel/sys.c	Thu Jan 25 15:17:35 2001
@@ -1203,12 +1203,95 @@
 			}
 			current->keep_capabilities = arg2;
 			break;
+		case PR_GET_RUNON:
+			error = put_user(current->cpus_allowed, (long *)arg2);
+			break;
+		case PR_SET_RUNON:
+			if (arg2 == 0)
+				arg2 = 1 << smp_processor_id();
+			arg2 &= cpu_online_map;
+			if (!arg2)
+				error = -EINVAL;
+			else {
+				current->cpus_allowed = arg2;
+				if (!(arg2 & (1 << smp_processor_id())))
+					current->need_resched = 1;
+			}
+			break;
+		case PR_MUSTRUN_PID:
+			/* arg2 is cpu, arg3 is pid */
+			if (arg2 == 0)
+				arg2 = 1 << smp_processor_id();
+			arg2 &= cpu_online_map;
+			if (!arg2)
+				error = -EINVAL;
+			error = mp_mustrun_pid(arg2, arg3);
+			break;
+		case PR_RUNANY_PID:
+			/* arg2 is pid */
+			if (!arg2)
+				error = -EINVAL;
+			error = mp_runany_pid(arg2);
+			break;
 		default:
 			error = -EINVAL;
 			break;
 	}
 	return error;
 }
+
+static int mp_mustrun_pid(int cpu, int pid) 
+{
+	struct task_struct *p;
+	int ret;
+
+	ret = -EPERM;
+	/* Not allowed to change 1 */
+	if (pid == 1) 
+		goto out;
+
+	read_lock(&tasklist_lock);
+	p = find_task_by_pid(pid);
+	if (p)
+		get_task_struct(p);
+	read_unlock(&tasklist_lock);
+	if (!p)
+		ret = -ESRCH;
+
+	p->cpus_allowed = cpu;
+	p->need_resched = 1;
+	free_task_struct(p);
+	ret = 0;
+out:
+	return ret;
+}
+
+static int mp_runany_pid(int pid) 
+{
+	struct task_struct *p;
+	int ret;
+
+	ret = -EPERM;
+	/* Not allowed to change 1 */
+	if (pid == 1) 
+		goto out;
+
+	read_lock(&tasklist_lock);
+	p = find_task_by_pid(pid);
+	if (p)
+		get_task_struct(p);
+	read_unlock(&tasklist_lock);
+	if (!p)
+		ret = -ESRCH;
+
+	p->cpus_allowed = 0xFFFFFFFF;
+	p->need_resched = 0;
+	free_task_struct(p);
+	ret = 0;
+out:
+	return ret;
+}
+
 
 EXPORT_SYMBOL(notifier_chain_register);
 EXPORT_SYMBOL(notifier_chain_unregister);
