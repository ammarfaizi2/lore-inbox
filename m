Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318519AbSIFMRW>; Fri, 6 Sep 2002 08:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318536AbSIFMRW>; Fri, 6 Sep 2002 08:17:22 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:17645 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S318519AbSIFMRU>; Fri, 6 Sep 2002 08:17:20 -0400
Date: Fri, 6 Sep 2002 17:20:25 +0530 (IST)
From: "Hanumanthu. H" <hanu@wipro.com>
To: <linux-kernel@vger.kernel.org>
cc: <torvalds@transmeta.com>, <mingo@redhat.com>, <hanumanthu.hanok@wipro.com>
Subject: Some improvements to sys_setpriority & sys_getpriority
Message-ID: <Pine.LNX.4.33.0209061708190.778-100000@ccvsbarc.wipro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Attached patch avoids using for_each_task() when
PRIO_PROCESS is passed as first parameter for
setpriority  & getpriority system calls (which is
most usual case). Current implementation of sys_setpriority
and sys_getpriority iterates over the tasklist to find out
the process to apply niceval. Even in case of current process
iteration is performed. This might be overhead iterate through
entire task list when we know which process to set priority to.
Please consider to apply.

Thanks
Hanu

Wipro technologies,
India Ltd


(Please ignore the attachement, which our mail server simply
 sticks to everymail)


----- Patch applies to kernel/sys.c, against linux-2.5.33 ----

--- linux-2.5.33/kernel/sys.c	Sun Sep  1 03:34:49 2002
+++ linux-2.5.33.1/kernel/sys.c	Fri Sep  6 18:08:41 2002
@@ -225,6 +225,15 @@
 	return 0;
 }

+static int proc_check_nice(struct task_struct *p, int niceval)
+{
+	if (p->uid  != current->uid && !capable(CAP_SYS_NICE))
+		return -EPERM;
+	if (niceval < task_nice(p) && !capable(CAP_SYS_NICE))
+		return -EACCES;
+	return security_ops->task_setnice(p, niceval);
+}
+
 asmlinkage long sys_setpriority(int which, int who, int niceval)
 {
 	struct task_struct *p;
@@ -241,29 +250,22 @@
 		niceval = 19;

 	read_lock(&tasklist_lock);
+
+	if (which == PRIO_PROCESS) {
+		p = (who) ? find_task_by_pid(who) : current;
+		if ( p && !(error = proc_check_nice(p, niceval)))
+			set_user_nice(p, niceval);
+		goto get_out;
+	}
+
 	for_each_task(p) {
-		int no_nice;
 		if (!proc_sel(p, which, who))
 			continue;
-		if (p->uid != current->euid &&
-			p->uid != current->uid && !capable(CAP_SYS_NICE)) {
-			error = -EPERM;
+		if ( (error = proc_check_nice(p, niceval)))
 			continue;
-		}
-		if (error == -ESRCH)
-			error = 0;
-		if (niceval < task_nice(p) && !capable(CAP_SYS_NICE)) {
-			error = -EACCES;
-			continue;
-		}
-		no_nice = security_ops->task_setnice(p, niceval);
-		if (no_nice) {
-			error = no_nice;
-			continue;
-		}
 		set_user_nice(p, niceval);
-
 	}
+get_out:
 	read_unlock(&tasklist_lock);

 	return error;
@@ -284,6 +286,12 @@
 		return -EINVAL;

 	read_lock(&tasklist_lock);
+	if (which == PRIO_PROCESS) {
+		p = (who) ? find_task_by_pid(who) : current;
+		if(p) retval = 20 - task_nice(p);
+		goto get_out;
+	}
+
 	for_each_task (p) {
 		long niceval;
 		if (!proc_sel(p, which, who))
@@ -292,6 +300,7 @@
 		if (niceval > retval)
 			retval = niceval;
 	}
+get_out:
 	read_unlock(&tasklist_lock);

 	return retval;

