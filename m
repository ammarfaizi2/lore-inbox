Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132884AbRDJAGJ>; Mon, 9 Apr 2001 20:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132886AbRDJAGA>; Mon, 9 Apr 2001 20:06:00 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:40305 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S132884AbRDJAFr>; Mon, 9 Apr 2001 20:05:47 -0400
Date: Mon, 9 Apr 2001 17:08:23 -0700
From: Nick Pollitt <npollitt@engr.sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Process pinning
Message-ID: <20010409170823.C2316@engr.sgi.com>
Reply-To: npollitt@engr.sgi.com
Mail-Followup-To: Nick Pollitt <npollitt@engr.sgi.com>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch applies cleanly to 2.4.3-ac3.  

Changes to array.c expose cpus_allowed in proc/pid/stat.  

PR_GET_RUNON and PR_SET_RUNON were done by Ingo and Dimitris.  Added
MUSTRUN_PID and RUNANY_PID.

Also attached is runon and it's manpage.

Nick


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.3-process-pinning.patch"

diff -X /home/npollitt/dontdiff -Nur 243-ac3/linux/fs/proc/array.c mine/linux/fs/proc/array.c
--- 243-ac3/linux/fs/proc/array.c	Tue Mar 27 16:21:37 2001
+++ mine/linux/fs/proc/array.c	Tue Mar 27 16:23:24 2001
@@ -343,7 +343,7 @@
 	read_unlock(&tasklist_lock);
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %lu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d\n",
+%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu\n",
 		task->pid,
 		task->comm,
 		state,
@@ -386,7 +386,8 @@
 		task->nswap,
 		task->cnswap,
 		task->exit_signal,
-		task->processor);
+		task->processor,
+		task->cpus_allowed);
 	if(mm)
 		mmput(mm);
 	return res;
diff -X /home/npollitt/dontdiff -Nur 243-ac3/linux/include/linux/prctl.h mine/linux/include/linux/prctl.h
--- 243-ac3/linux/include/linux/prctl.h	Sun Mar 19 11:15:32 2000
+++ mine/linux/include/linux/prctl.h	Tue Mar 27 16:23:24 2001
@@ -20,4 +20,9 @@
 #define PR_GET_KEEPCAPS   7
 #define PR_SET_KEEPCAPS   8
 
+#define PR_GET_RUNON	  9
+#define PR_SET_RUNON	  10
+#define PR_MUSTRUN_PID    11
+#define PR_RUNANY_PID     12
+
 #endif /* _LINUX_PRCTL_H */
diff -X /home/npollitt/dontdiff -Nur 243-ac3/linux/kernel/sched.c mine/linux/kernel/sched.c
--- 243-ac3/linux/kernel/sched.c	Tue Mar 27 16:21:38 2001
+++ mine/linux/kernel/sched.c	Tue Mar 27 16:23:24 2001
@@ -112,6 +112,10 @@
 #ifdef CONFIG_SMP
 
 #define idle_task(cpu) (init_tasks[cpu_number_map(cpu)])
+#define can_schedule_goodness(p,cpu) ( (!(p)->has_cpu ||  \
+                                        p->processor == cpu) &&  \
+                                        ((p)->cpus_allowed & (1 << cpu)))
+
 #define can_schedule(p,cpu) ((!(p)->has_cpu) && \
 				((p)->cpus_allowed & (1 << cpu)))
 
@@ -119,6 +123,7 @@
 
 #define idle_task(cpu) (&init_task)
 #define can_schedule(p,cpu) (1)
+#define can_schedule_goodness(p,cpu) (1)
 
 #endif
 
@@ -594,7 +599,7 @@
 still_running_back:
 	list_for_each(tmp, &runqueue_head) {
 		p = list_entry(tmp, struct task_struct, run_list);
-		if (can_schedule(p, this_cpu)) {
+		if (can_schedule_goodness(p, this_cpu)) {
 			int weight = goodness(p, this_cpu, prev->active_mm);
 			if (weight > c)
 				c = weight, next = p;
diff -X /home/npollitt/dontdiff -Nur 243-ac3/linux/kernel/sys.c mine/linux/kernel/sys.c
--- 243-ac3/linux/kernel/sys.c	Tue Mar 27 16:21:38 2001
+++ mine/linux/kernel/sys.c	Tue Mar 27 16:23:24 2001
@@ -1255,12 +1255,95 @@
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

--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="runon.c"

/*
 * runon.c - assign a process to a named processor
 *
 * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
 * 
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of version 2 of the GNU General Public License as
 * published by the Free Software Foundation.
 * 
 * This program is distributed in the hope that it would be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * 
 * Further, this software is distributed without any warranty that it is
 * free of the rightful claim of any third person regarding infringement
 * or the like.  Any license provided herein, whether implied or
 * otherwise, applies only to this software file.  Patent licenses, if
 * any, provided herein do not apply to combinations of this program with
 * other software, or any other product whatsoever.
 * 
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write the Free Software Foundation, Inc., 59
 * Temple Place - Suite 330, Boston MA 02111-1307, USA.
 * 
 * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
 * Mountain View, CA  94043, or:
 * 
 * http://www.sgi.com 
 * 
 * For further information regarding this notice, see: 
 * 
 * http://oss.sgi.com/projects/GenInfo/SGIGPLNoticeExplan/
 */

#include	<stdio.h>
#include	<unistd.h>
#include	<linux/prctl.h>

#define _POSIX_OPTION_ORDER

static void usage();

int main(argc, argv)
int argc;
char *argv[];
{
	extern	errno;
	extern	__const char *__const sys_errlist[];
	int	c, processor, pid;
	int usepid = 0;
	register char *p;

	if (argc < 3) {
		usage();
		exit(1);
	}

	while ((c = getopt (argc, argv, "p:")) != -1) {
		switch(c) {
		case 'p':
			usepid = 1;
			pid = atoi(optarg);
			break;
		}
	}

	p = argv[optind];
	while(*p) {
		if(!isdigit(*p)) {
			fprintf(stderr, "%s: cpu argument must be numeric.\n", argv[0]);
			exit(2);
		}
		p++;
	}
	processor = atoi(&argv[optind][0]);
	optind++;

	if (usepid) {
		if (prctl(PR_MUSTRUN_PID, processor, pid, 0, 0) < 0) {
			fprintf(stderr, "%s: could not attach pid %d to processor %d\n",
										 argv[0], pid, processor);
			exit(1);
		}
	}
	else {
		if (prctl(PR_SET_RUNON, processor, 0, 0, 0) < 0) { 
			fprintf(stderr,
				"%s: could not attach to processor %d -- %s\n ",
				argv[0], processor, sys_errlist[errno]);
			exit(1);
		}
	
		execvp(argv[optind], &argv[optind]);
		fprintf(stderr, "%s: %s\n", sys_errlist[errno], argv[optind]);
		exit(1);
	}
	return(0);
}

static void usage() {
	fprintf(stderr, "usage: runon processor (-p pid | command [args...])\n");
}

--cPi+lWm09sJ+d57q--
