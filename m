Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbTEHTst (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 15:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbTEHTst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 15:48:49 -0400
Received: from pengo.systems.pipex.net ([62.241.160.193]:45510 "HELO
	pengo.systems.pipex.net") by vger.kernel.org with SMTP
	id S262058AbTEHTsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 15:48:46 -0400
From: shaheed <srhaque@iee.org>
To: mingo@elte.hu, rml@tech9.net
Subject: [PATCH] 2.5.69 support for restricting cpu usage to callers of  sys_setaffinity
Date: Thu, 8 May 2003 20:58:43 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305082058.43565.srhaque@iee.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Following on from 

http://www.ussg.iu.edu/hypermail/linux/kernel/0304.1/1634.html

here is a patch against 2.5.69 to add support for restricting cpu usage to 
callers of sys_setaffinity. Please review and apply.

Thanks, Shaheed

1. The patch is against a clean 2.5.69

2. There is a new boot flag "restricted_cpus". This takes a bit mask
of CPUs. 

3. The initial task has it's cpus_allowed mask set to ~restricted_cpus in the 
fork initialisation code (it cannot be done in TASK_INIT since the value is 
not 
static). This should mean that any task that does not override cpus_allowed 
with sys_setaffinity does not get to run on the restricted processors. 

4. The parsing of the boot flag does a sanity check to prevent all available 
CPUs being restricted. 

5. Patch follows... 


--- linux-2.5.69-vanilla/Documentation/kernel-parameters.txt	Sun May  4 
23:53:57 2003
+++ linux-2.5.69/Documentation/kernel-parameters.txt	Thu May  8 10:14:51 2003
@@ -809,6 +809,10 @@
 
 	reserve=	[KNL,BUGS] Force the kernel to ignore some iomem area
 
+	restricted_cpus=
+	                [KNL] Don't use these CPUs for processes by default.
+			Format: <cpu_mask>
+
 	resume=		[SWSUSP] Specify the partition device for software suspension
 
 	riscom8=	[HW,SERIAL]
--- linux-2.5.69-vanilla/kernel/fork.c	Sun May  4 23:53:02 2003
+++ linux-2.5.69/kernel/fork.c	Thu May  8 13:44:02 2003
@@ -62,6 +62,30 @@
  */
 static task_t *task_cache[NR_CPUS] __cacheline_aligned;
 
+/*
+ * The boot flag "restricted_cpus" is negated to form the default per-task
+ * cpus_allowed mask. This has the effect of only allowing processes which
+ * call sys_setaffinity() to run on restricted_cpus.
+ */ 
+static unsigned long restricted_cpus = 0;
+
+/*
+ * set_restricted_cpus - process boot flag to set restricted_cpus.
+ *
+ * NOTE: This function is a __setup and __init function.
+ */
+int __init set_restricted_cpus(char *options)
+{
+	char *value = options;
+
+	if (!value || !*value)
+		return 0;
+	restricted_cpus = simple_strtoul(value, &value, 0);
+	return 0;
+}
+
+__setup("restricted_cpus=", set_restricted_cpus);
+
 int nr_processes(void)
 {
 	int cpu;
@@ -208,6 +232,19 @@
 
 	init_task.rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
 	init_task.rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
+
+	/*
+	 * Make sure that the user has not restricted all available CPUs,
+	 * otherwise a functioning system won't result! Note that at this
+	 * point, only the boot CPU is actually online...
+	 */
+	if (~restricted_cpus & cpu_online_map) {
+		printk(KERN_ERR "restricted CPUs 0x%lx\n", restricted_cpus);
+	} else {
+		printk(KERN_ERR "cannot restrict all CPUs!\n");
+		restricted_cpus = 0;
+	}
+	init_task.cpus_allowed = ~restricted_cpus;
 }
 
 static struct task_struct *dup_task_struct(struct task_struct *orig)

