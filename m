Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267760AbUIKI3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267760AbUIKI3F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 04:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267860AbUIKI3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 04:29:04 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:18604 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267760AbUIKI2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 04:28:50 -0400
Date: Sat, 11 Sep 2004 01:28:14 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       linux-kernel@vger.kernel.org
Message-Id: <20040911082816.10372.16867.91982@sam.engr.sgi.com>
In-Reply-To: <20040911082810.10372.86008.84920@sam.engr.sgi.com>
References: <20040911082810.10372.86008.84920@sam.engr.sgi.com>
Subject: [Patch 1/4] cpusets display allowed masks in proc status
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Should have done this earlier - the cpus_allowed and mems_allowed
values for each task are not always obvious from the tasks cpuset
settings, for various reasons, including:

  1) a task might use sched_setaffinity, mbind or set_mempolicy
     to restrain its placement to less than its cpuset, or
  2) various temporary changes to cpus_allowed are done by
     kernel internal code, or
  3) attaching a task to a cpuset doesn't change its mems_allowed
     until the next time that task needs kernel memory, or
  4) changing a cpusets 'cpus' doesn't change the cpus_allowed of
     the tasks attached to it until those tasks are reattached
     to that cpuset (to avoid a hook in the hotpath scheduler
     code in the kernel).

So it is useful, when learning and making new uses of cpusets and
placement to be able to see what are the current value of a tasks
cpus_allowed and mems_allowed, which are the actual placement used
by the kernel scheduler and memory allocator.

The cpus_allowed and mems_allowed values are needed by user space
apps that are micromanaging placement, such as when moving an app to a
different cpuset, and trying to recreate the cpuset-relative placement
obtained by that app within its cpuset using sched_setaffinity,
mbind and set_mempolicy.

The cpus_allowed value is also available via the sched_getaffinity
system call.  But since the entire rest of the cpuset API, including
the display of mems_allowed added here, is via an ascii style
presentation in /proc and /dev/cpuset, it is worth the extra couple
lines of code to display cpus_allowed in the same way.

This patch adds the display of these two fields to the 'status'
file in the /proc/<pid> directory of each task.  The fields are only
added if CONFIG_CPUSETS is enabled (which is also needed to define
the mems_allowed field of each task).  The new output lines look like:

  $ tail -2 /proc/1/status
  Cpus_allowed:   ffffffff,ffffffff,ffffffff,ffffffff
  Mems_allowed:   ffffffff,ffffffff

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.9-rc1-mm4/fs/proc/array.c
===================================================================
--- 2.6.9-rc1-mm4.orig/fs/proc/array.c	2004-09-10 09:11:33.000000000 -0700
+++ 2.6.9-rc1-mm4/fs/proc/array.c	2004-09-10 15:27:23.000000000 -0700
@@ -73,6 +73,7 @@
 #include <linux/highmem.h>
 #include <linux/file.h>
 #include <linux/times.h>
+#include <linux/cpuset.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -295,6 +296,7 @@ int proc_pid_status(struct task_struct *
 	}
 	buffer = task_sig(task, buffer);
 	buffer = task_cap(task, buffer);
+	buffer = cpuset_task_status_allowed(task, buffer);
 #if defined(CONFIG_ARCH_S390)
 	buffer = task_show_regs(task, buffer);
 #endif
Index: 2.6.9-rc1-mm4/include/linux/cpuset.h
===================================================================
--- 2.6.9-rc1-mm4.orig/include/linux/cpuset.h	2004-09-10 09:11:33.000000000 -0700
+++ 2.6.9-rc1-mm4/include/linux/cpuset.h	2004-09-10 15:27:23.000000000 -0700
@@ -25,6 +25,7 @@ void cpuset_restrict_to_mems_allowed(uns
 int cpuset_zonelist_valid_mems_allowed(struct zonelist *zl);
 int cpuset_zone_allowed(struct zone *z);
 extern struct file_operations proc_cpuset_operations;
+extern char *cpuset_task_status_allowed(struct task_struct *task, char *buffer);
 
 #else /* !CONFIG_CPUSETS */
 
@@ -52,6 +53,12 @@ static inline int cpuset_zone_allowed(st
 	return 1;
 }
 
+static inline char *cpuset_task_status_allowed(struct task_struct *task,
+							char *buffer)
+{
+	return buffer;
+}
+
 #endif /* !CONFIG_CPUSETS */
 
 #endif /* _LINUX_CPUSET_H */
Index: 2.6.9-rc1-mm4/kernel/cpuset.c
===================================================================
--- 2.6.9-rc1-mm4.orig/kernel/cpuset.c	2004-09-10 15:27:03.000000000 -0700
+++ 2.6.9-rc1-mm4/kernel/cpuset.c	2004-09-10 15:27:23.000000000 -0700
@@ -1495,3 +1495,15 @@ struct file_operations proc_cpuset_opera
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
+
+/* Display task cpus_allowed, mems_allowed in /proc/<pid>/status file. */
+char *cpuset_task_status_allowed(struct task_struct *task, char *buffer)
+{
+	buffer += sprintf(buffer, "Cpus_allowed:\t");
+	buffer += cpumask_scnprintf(buffer, PAGE_SIZE, task->cpus_allowed);
+	buffer += sprintf(buffer, "\n");
+	buffer += sprintf(buffer, "Mems_allowed:\t");
+	buffer += nodemask_scnprintf(buffer, PAGE_SIZE, task->mems_allowed);
+	buffer += sprintf(buffer, "\n");
+	return buffer;
+}

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
