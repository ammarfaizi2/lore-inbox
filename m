Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264025AbTDNWam (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbTDNWam (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:30:42 -0400
Received: from colossus.systems.pipex.net ([62.241.160.73]:14506 "HELO
	colossus.systems.pipex.net") by vger.kernel.org with SMTP
	id S264025AbTDNWaj (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 18:30:39 -0400
From: shaheed <srhaque@iee.org>
To: mingo@elte.hu
Subject: [RFC] patch to allow CPUs to be reserved to callers of sys_setaffinity [was Processor sets (pset) for linux kernel 2.5/2.6?]
Date: Mon, 14 Apr 2003 23:40:08 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, rml@tech9.net
References: <1050146434.3e97f68300fff@netmail.pipex.net>
In-Reply-To: <1050146434.3e97f68300fff@netmail.pipex.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304142340.08276.srhaque@iee.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Following up from http://www.ussg.iu.edu/hypermail/linux/kernel/0304.1/1113.html, here is a prototype patch against 2.5.67 to allow CPUs to be reserved to callers of sys_setaffinity(). It seems to work safely on a uniprocessor, and I'll test it on a multi-processor in a few days time. I'm not requesting inclusion of this patch until then.

Any feedback on form as well as content appreciated...I'm particularly wondering if it is worth stealing sys_setaffinity()/sys_getaffinity() for PID 0 to set/return this value since that would allow user-mode code to dynamically choose a non-restricted processor if required.

Thanks, Shaheed

1. The patch is against a clean 2.5.67

2. There is a new boot flag "restricted_cpus". This takes a bit mask of CPUs.

3. The initial task has it's cpus_allowed mask set to ~restricted_cpus in the fork initialisation code (it cannot be done in TASK_INIT since the value is not static). This should mean that any task that does not override cpus_allowed with sys_setaffinity does not get to run on the restricted processors.

4. The parsing of the boot flag does a sanity check to prevent all available CPUs being restricted.

5. Patch follows...

diff -urN -X dontdiff linux-2.5.67/kernel/fork.c newlinux-2.5.67/kernel/fork.c
--- linux-2.5.67/kernel/fork.c	2003-04-07 18:30:42.000000000 +0100
+++ newlinux-2.5.67/kernel/fork.c	2003-04-14 21:36:59.000000000 +0100
@@ -206,6 +206,7 @@
 
 	init_task.rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
 	init_task.rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
+	init_task.cpus_allowed = ~restricted_cpus;
 }
 
 static struct task_struct *dup_task_struct(struct task_struct *orig)
diff -urN -X dontdiff linux-2.5.67/kernel/sched.c newlinux-2.5.67/kernel/sched.c
--- linux-2.5.67/kernel/sched.c	2003-04-07 18:32:23.000000000 +0100
+++ newlinux-2.5.67/kernel/sched.c	2003-04-14 22:28:31.000000000 +0100
@@ -40,6 +40,13 @@
 #endif
 
 /*
+ * The boot flag "restricted_cpus" is negated to form the default per-task
+ * cpus_allowed mask. This has the effect of only allowing processes which
+ * call sys_setaffinity() to run on restricted_cpus.
+ */ 
+unsigned long restricted_cpus = 0;
+
+/*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
  * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
  * and back.
@@ -2338,6 +2345,34 @@
 }
 
 /*
+ * set_restricted_cpus - process boot flag to set restricted_cpus.
+ *
+ * NOTE: This function is a __setup and __init function.
+ */
+int __init set_restricted_cpus(char *options)
+{
+	unsigned long temp;
+	char *value;
+
+	if (!options || !*options)
+		return 0;
+	temp = simple_strtoul(value, &value, 0);
+
+	/*
+	 * Make sure that the user has not restricted all available CPUs,
+	 * otherwise a functioning system won't result!
+	 */
+	if (~temp & cpu_online_map) {
+		restricted_cpus = temp;
+	} else {
+		printk(KERN_ERR "cannot restrict all 0x%lx online CPUs!\n", cpu_online_map);
+	}
+	return 0;
+}
+
+__setup("restricted_cpus=", set_restricted_cpus);
+
+/*
  * migration_thread - this is a highprio system thread that performs
  * thread migration by 'pulling' threads into the target runqueue.
  */
diff -urN -X dontdiff linux-2.5.67/Documentation/kernel-parameters.txt newlinux-2.5.67/Documentation/kernel-parameters.txt
--- linux-2.5.67/Documentation/kernel-parameters.txt	2003-04-07 18:33:03.000000000 +0100
+++ newlinux-2.5.67/Documentation/kernel-parameters.txt	2003-04-14 22:45:25.000000000 +0100
@@ -809,6 +809,10 @@
 
 	reserve=	[KNL,BUGS] Force the kernel to ignore some iomem area
 
+	restricted_cpus=
+	                [KNL] Don't use these CPUs for processes by default.
+			Format: <cpu_mask>
+
 	resume=		[SWSUSP] Specify the partition device for software suspension
 
 	riscom8=	[HW,SERIAL]
diff -urN -X dontdiff linux-2.5.67/include/linux/sched.h newlinux-2.5.67/include/linux/sched.h
--- linux-2.5.67/include/linux/sched.h	2003-04-07 18:30:42.000000000 +0100
+++ newlinux-2.5.67/include/linux/sched.h	2003-04-14 21:37:42.000000000 +0100
@@ -88,6 +88,7 @@
 
 extern int nr_threads;
 extern int last_pid;
+extern unsigned long restricted_cpus;
 DECLARE_PER_CPU(unsigned long, process_counts);
 extern int nr_processes(void);
 extern unsigned long nr_running(void);


