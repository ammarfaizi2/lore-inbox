Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWDLGvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWDLGvd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 02:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWDLGvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 02:51:32 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:24980 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932082AbWDLGvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 02:51:32 -0400
Date: Wed, 12 Apr 2006 15:53:01 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@engr.sgi.com>, riel@redhat.com, dgc@sgi.com
Subject: [PATCH] support for panic at OOM
Message-Id: <20060412155301.10d611ca.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a feature to panic at OOM, oom_die.

When sysctl vm.oom_die = 1, the kernel panics intead of killing
rogue processes. And if vm.oom_die is 0 the kernel will do
oom_kill() in the same way as it does today. Of course, the 
default value is 0 and only root can modifies it.

In general, oom_killer works well and kill rogue processes. So 
the whole system can survive. But there are environments where
panic is preferable rather than kill some processes.

For example, a failover system can replace a broken system with
back-up system immediately at panic, so it doesn't need oom_kill.

Considering a failover cluster system, a failover service puts
all nodes under its observation. When a node panics, the failover
system  can replace it with new one immediately. But if oom_kill runs
and kills some processes, the system will go to partial broken
state. This partial broken state is sometimes difficult to be
detected. The worst case is that a failover daemon is killed 
(possibility is not 0%), the whole system will be unstable.

Another case is crash-dump supported system. If the system panics
at OOM, crash dump can preserve *all* information about system.
Because SIGKILL cannot cause process coredump, oom killer cannot
preserve any hints except for the message log.

thanks,
-Kame
==

This patch adds oom_die sysctl under sys.vm.

When oom_die==1, system panic at out_of_memory istead of kill some
process. In some situation, I think panic is more useful than kill.
This patch is against 2.6.17-rc1-mm2.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.17-rc1-mm2/kernel/sysctl.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/kernel/sysctl.c
+++ linux-2.6.17-rc1-mm2/kernel/sysctl.c
@@ -60,6 +60,7 @@ extern int proc_nr_files(ctl_table *tabl
 extern int C_A_D;
 extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;
+extern int sysctl_oom_die;
 extern int max_threads;
 extern int sysrq_enabled;
 extern int core_uses_pid;
@@ -718,6 +719,14 @@ static ctl_table vm_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 	{
+		.ctl_name	= VM_OOM_DIE,
+		.procname	= "oom_die",
+		.data		= &sysctl_oom_die,
+		.maxlen		= sizeof(sysctl_oom_die),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
 		.ctl_name	= VM_OVERCOMMIT_RATIO,
 		.procname	= "overcommit_ratio",
 		.data		= &sysctl_overcommit_ratio,
Index: linux-2.6.17-rc1-mm2/mm/oom_kill.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/oom_kill.c
+++ linux-2.6.17-rc1-mm2/mm/oom_kill.c
@@ -23,7 +23,7 @@
 #include <linux/cpuset.h>
 
 /* #define DEBUG */
-
+int sysctl_oom_die = 0;
 /**
  * oom_badness - calculate a numeric value for how bad this task has been
  * @p: task struct of which task we should calculate
@@ -290,6 +290,12 @@ static struct mm_struct *oom_kill_proces
 	return oom_kill_task(p, message);
 }
 
+
+static void oom_die(void)
+{
+	panic("Panic: out of memory: oom_die is selected.");
+}
+
 /**
  * oom_kill - kill the "best" process when we run out of memory
  *
@@ -331,6 +337,8 @@ void out_of_memory(struct zonelist *zone
 
 	case CONSTRAINT_NONE:
 retry:
+		if (sysctl_oom_die)
+			oom_die();
 		/*
 		 * Rambo mode: Shoot down a process and hope it solves whatever
 		 * issues we may have.

