Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVAIRQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVAIRQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 12:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVAIRQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 12:16:27 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:60919 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261646AbVAIRPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 12:15:39 -0500
Subject: [PATCH] scheduling priorities with rlimit
From: utz lehmann <lkml@s2y4n2c.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>
Content-Type: text/plain
Date: Sun, 09 Jan 2005 18:15:36 +0100
Message-Id: <1105290936.24812.29.camel@segv.aura.of.mankind>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a3828f1c4d839cf12e8a3b808f7ed34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I really like the idea of controlling the maximum settable scheduling
priorities via rlimit. See the Realtime LSM thread. I want to give users
the right to raise the priority of previously niced jobs.

I have modified Chris Wright's patch (against 2.6.10):
(http://marc.theaimsgroup.com/?l=linux-kernel&m=110513793228776&w=2)

- allow always to increase nice levels (lower priority).
- set the default for RLIMIT_PRIO to 0.
- add the other architectures.

With this the default is compatible with the old behavior.

With RLIMIT_PRIO > 0 a user is able to raise the priority up to the
value. 0-39 for nice levels 19 .. -20, 40-139 for realtime priorities
(0 .. 99).

It can be simply set in /etc/security/limits.conf with a patched PAM.

I have tested it on x86 incl. jack + audio apps.


Is this approach suitable for mainline?
Is the patch ok?

You can find PAM patches and rpms for FC 3 at
http://www.s2y4n2c.de/linux/rlimit_prio/


utz

Signed off by: utz lehmann <lkml@s2y4n2c.de>

diff -Nrup linux-2.6.10/include/linux/sched.h linux-2.6.10-prio/include/linux/sched.h
--- linux-2.6.10/include/linux/sched.h	2004-12-24 22:33:59.000000000 +0100
+++ linux-2.6.10-prio/include/linux/sched.h	2005-01-09 02:42:27.459948519 +0100
@@ -738,6 +738,7 @@ extern void sched_idle_next(void);
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(const task_t *p);
 extern int task_nice(const task_t *p);
+extern int nice_to_prio(const int nice);
 extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
 
diff -Nrup linux-2.6.10/kernel/sched.c linux-2.6.10-prio/kernel/sched.c
--- linux-2.6.10/kernel/sched.c	2004-12-24 22:35:24.000000000 +0100
+++ linux-2.6.10-prio/kernel/sched.c	2005-01-09 02:50:42.146306514 +0100
@@ -3008,12 +3008,8 @@ asmlinkage long sys_nice(int increment)
 	 * We don't have to worry. Conceptually one call occurs first
 	 * and we have a single winner.
 	 */
-	if (increment < 0) {
-		if (!capable(CAP_SYS_NICE))
-			return -EPERM;
-		if (increment < -40)
-			increment = -40;
-	}
+	if (increment < -40)
+		increment = -40;
 	if (increment > 40)
 		increment = 40;
 
@@ -3023,6 +3019,12 @@ asmlinkage long sys_nice(int increment)
 	if (nice > 19)
 		nice = 19;
 
+	if (increment < 0 && 
+	    (MAX_PRIO-1) - NICE_TO_PRIO(nice) > 
+	    current->signal->rlim[RLIMIT_PRIO].rlim_cur &&
+	    !capable(CAP_SYS_NICE))
+		return -EPERM;
+
 	retval = security_task_setnice(current, nice);
 	if (retval)
 		return retval;
@@ -3056,6 +3058,15 @@ int task_nice(const task_t *p)
 }
 
 /**
+ * nice_to_prio - return priority of give nice value
+ * @nice: nice value
+ */
+int nice_to_prio(const int nice)
+{
+	return NICE_TO_PRIO(nice);
+}
+
+/**
  * idle_cpu - is a given cpu idle currently?
  * @cpu: the processor in question.
  */
@@ -3139,6 +3150,7 @@ recheck:
 
 	retval = -EPERM;
 	if ((policy == SCHED_FIFO || policy == SCHED_RR) &&
+	    lp.sched_priority+40 > p->signal->rlim[RLIMIT_PRIO].rlim_cur && 
 	    !capable(CAP_SYS_NICE))
 		goto out_unlock;
 	if ((current->euid != p->euid) && (current->euid != p->uid) &&
diff -Nrup linux-2.6.10/kernel/sys.c linux-2.6.10-prio/kernel/sys.c
--- linux-2.6.10/kernel/sys.c	2004-12-24 22:33:59.000000000 +0100
+++ linux-2.6.10-prio/kernel/sys.c	2005-01-09 03:34:54.618507222 +0100
@@ -224,7 +224,10 @@ static int set_one_prio(struct task_stru
 		error = -EPERM;
 		goto out;
 	}
-	if (niceval < task_nice(p) && !capable(CAP_SYS_NICE)) {
+	if (niceval < task_nice(p) &&
+	    (MAX_PRIO-1) - nice_to_prio(niceval) > 
+	    p->signal->rlim[RLIMIT_PRIO].rlim_cur &&
+	    !capable(CAP_SYS_NICE)) {
 		error = -EACCES;
 		goto out;
 	}
diff -Nrup linux-2.6.10/include/asm-alpha/resource.h linux-2.6.10-prio/include/asm-alpha/resource.h
--- linux-2.6.10/include/asm-alpha/resource.h	2004-12-24 22:33:51.000000000 +0100
+++ linux-2.6.10-prio/include/asm-alpha/resource.h	2005-01-09 04:19:22.581658112 +0100
@@ -18,8 +18,9 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_PRIO	13		/* maximum scheduling priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	14
 
 /*
  * SuS says limits have to be unsigned.  Fine, it's unsigned, but
@@ -45,6 +46,7 @@
     {LONG_MAX, LONG_MAX},			/* RLIMIT_LOCKS */	\
     {MAX_SIGPENDING, MAX_SIGPENDING},		/* RLIMIT_SIGPENDING */ \
     {MQ_BYTES_MAX, MQ_BYTES_MAX},		/* RLIMIT_MSGQUEUE */	\
+    {       0,        0},			/* RLIMIT_PRIO */	\
 }
 
 #endif /* __KERNEL__ */
diff -Nrup linux-2.6.10/include/asm-arm/resource.h linux-2.6.10-prio/include/asm-arm/resource.h
--- linux-2.6.10/include/asm-arm/resource.h	2004-12-24 22:35:25.000000000 +0100
+++ linux-2.6.10-prio/include/asm-arm/resource.h	2005-01-09 04:19:47.831161464 +0100
@@ -18,8 +18,9 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_PRIO	13		/* maximum scheduling priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	14
 
 #ifdef __KERNEL__
 
@@ -44,6 +45,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ MAX_SIGPENDING, MAX_SIGPENDING},	\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX},		\
+	{ 0,             0             },	\
 }
 
 #endif /* __KERNEL__ */
diff -Nrup linux-2.6.10/include/asm-arm26/resource.h linux-2.6.10-prio/include/asm-arm26/resource.h
--- linux-2.6.10/include/asm-arm26/resource.h	2004-12-24 22:33:49.000000000 +0100
+++ linux-2.6.10-prio/include/asm-arm26/resource.h	2005-01-09 04:20:16.152359541 +0100
@@ -18,8 +18,9 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_PRIO	13		/* maximum scheduling priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	14
 
 #ifdef __KERNEL__
 
@@ -44,6 +45,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ MAX_SIGPENDING, MAX_SIGPENDING},	\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX},		\
+	{ 0,             0             },	\
 }
 
 #endif /* __KERNEL__ */
diff -Nrup linux-2.6.10/include/asm-cris/resource.h linux-2.6.10-prio/include/asm-cris/resource.h
--- linux-2.6.10/include/asm-cris/resource.h	2004-12-24 22:35:01.000000000 +0100
+++ linux-2.6.10-prio/include/asm-cris/resource.h	2005-01-09 04:20:25.483436038 +0100
@@ -18,8 +18,9 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_PRIO	13		/* maximum scheduling priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	14
 
 /*
  * SuS says limits have to be unsigned.
@@ -44,6 +45,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
+	{            0,	             0 },		\
 }
 
 #endif /* __KERNEL__ */
diff -Nrup linux-2.6.10/include/asm-h8300/resource.h linux-2.6.10-prio/include/asm-h8300/resource.h
--- linux-2.6.10/include/asm-h8300/resource.h	2004-12-24 22:33:50.000000000 +0100
+++ linux-2.6.10-prio/include/asm-h8300/resource.h	2005-01-09 04:20:55.316482343 +0100
@@ -18,8 +18,9 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_PRIO	13		/* maximum scheduling priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	14
 
 /*
  * SuS says limits have to be unsigned.
@@ -44,6 +45,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
+	{            0,	             0 },		\
 }
 
 #endif /* __KERNEL__ */
diff -Nrup linux-2.6.10/include/asm-i386/resource.h linux-2.6.10-prio/include/asm-i386/resource.h
--- linux-2.6.10/include/asm-i386/resource.h	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6.10-prio/include/asm-i386/resource.h	2005-01-09 02:51:38.550652444 +0100
@@ -18,8 +18,9 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_PRIO	13		/* maximum scheduling priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	14
 
 
 /*
@@ -45,6 +46,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
+	{            0,	             0 },		\
 }
 
 #endif /* __KERNEL__ */
diff -Nrup linux-2.6.10/include/asm-ia64/resource.h linux-2.6.10-prio/include/asm-ia64/resource.h
--- linux-2.6.10/include/asm-ia64/resource.h	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6.10-prio/include/asm-ia64/resource.h	2005-01-09 04:21:40.555000376 +0100
@@ -25,8 +25,9 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_PRIO	13		/* maximum scheduling priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	14
 
 /*
  * SuS says limits have to be unsigned.
@@ -51,6 +52,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
+	{            0,	             0 },		\
 }
 
 # endif /* __KERNEL__ */
diff -Nrup linux-2.6.10/include/asm-m32r/resource.h linux-2.6.10-prio/include/asm-m32r/resource.h
--- linux-2.6.10/include/asm-m32r/resource.h	2004-12-24 22:34:29.000000000 +0100
+++ linux-2.6.10-prio/include/asm-m32r/resource.h	2005-01-09 04:23:12.890842150 +0100
@@ -22,8 +22,9 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE	12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_PRIO	13		/* maximum scheduling priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	14
 
 /*
  * SuS says limits have to be unsigned.
@@ -48,6 +49,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
+	{            0,	             0 },		\
 }
 
 #endif /* __KERNEL__ */
diff -Nrup linux-2.6.10/include/asm-m68k/resource.h linux-2.6.10-prio/include/asm-m68k/resource.h
--- linux-2.6.10/include/asm-m68k/resource.h	2004-12-24 22:33:49.000000000 +0100
+++ linux-2.6.10-prio/include/asm-m68k/resource.h	2005-01-09 04:23:23.319806990 +0100
@@ -18,8 +18,9 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_PRIO	13		/* maximum scheduling priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	14
 
 /*
  * SuS says limits have to be unsigned.
@@ -44,6 +45,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
+	{            0,	             0 },		\
 }
 
 #endif /* __KERNEL__ */
diff -Nrup linux-2.6.10/include/asm-mips/resource.h linux-2.6.10-prio/include/asm-mips/resource.h
--- linux-2.6.10/include/asm-mips/resource.h	2004-12-24 22:35:25.000000000 +0100
+++ linux-2.6.10-prio/include/asm-mips/resource.h	2005-01-09 04:24:59.745229422 +0100
@@ -25,8 +25,9 @@
 #define RLIMIT_LOCKS 10			/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_PRIO 13			/* maximum scheduling priority */
 
-#define RLIM_NLIMITS 13			/* Number of limit flavors.  */
+#define RLIM_NLIMITS 14			/* Number of limit flavors.  */
 
 #ifdef __KERNEL__
 
@@ -58,6 +59,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
+	{            0,	             0 },		\
 }
 
 #endif /* __KERNEL__ */
diff -Nrup linux-2.6.10/include/asm-parisc/resource.h linux-2.6.10-prio/include/asm-parisc/resource.h
--- linux-2.6.10/include/asm-parisc/resource.h	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6.10-prio/include/asm-parisc/resource.h	2005-01-09 04:25:24.322786492 +0100
@@ -18,8 +18,9 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_PRIO	13		/* maximum scheduling priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	14
 
 /*
  * SuS says limits have to be unsigned.
@@ -44,6 +45,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
+	{            0,	             0 },		\
 }
 
 #endif /* __KERNEL__ */
diff -Nrup linux-2.6.10/include/asm-ppc/resource.h linux-2.6.10-prio/include/asm-ppc/resource.h
--- linux-2.6.10/include/asm-ppc/resource.h	2004-12-24 22:34:32.000000000 +0100
+++ linux-2.6.10-prio/include/asm-ppc/resource.h	2005-01-09 04:25:39.139313466 +0100
@@ -14,8 +14,9 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_PRIO	13		/* maximum scheduling priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	14
 
 #ifdef __KERNEL__
 
@@ -41,6 +42,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
+	{            0,	             0 },		\
 }
 
 #endif /* __KERNEL__ */
diff -Nrup linux-2.6.10/include/asm-ppc64/resource.h linux-2.6.10-prio/include/asm-ppc64/resource.h
--- linux-2.6.10/include/asm-ppc64/resource.h	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6.10-prio/include/asm-ppc64/resource.h	2005-01-09 04:25:55.064729944 +0100
@@ -23,8 +23,9 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_PRIO	13		/* maximum scheduling priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	14
 
 #ifdef __KERNEL__
 
@@ -50,6 +51,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
+	{            0,	             0 },		\
 }
 
 #endif /* __KERNEL__ */
diff -Nrup linux-2.6.10/include/asm-s390/resource.h linux-2.6.10-prio/include/asm-s390/resource.h
--- linux-2.6.10/include/asm-s390/resource.h	2004-12-24 22:34:30.000000000 +0100
+++ linux-2.6.10-prio/include/asm-s390/resource.h	2005-01-09 04:26:16.528595316 +0100
@@ -26,8 +26,9 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_PRIO	13		/* maximum scheduling priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	14
 
 /*
  * SuS says limits have to be unsigned.
@@ -52,6 +53,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
+	{            0,	             0 },		\
 }
 
 #endif /* __KERNEL__ */
diff -Nrup linux-2.6.10/include/asm-sh/resource.h linux-2.6.10-prio/include/asm-sh/resource.h
--- linux-2.6.10/include/asm-sh/resource.h	2004-12-24 22:35:01.000000000 +0100
+++ linux-2.6.10-prio/include/asm-sh/resource.h	2005-01-09 04:26:36.105647948 +0100
@@ -18,8 +18,9 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_PRIO	13		/* maximum scheduling priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	14
 
 #ifdef __KERNEL__
 
@@ -44,6 +45,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
+	{            0,	             0 },		\
 }
 
 #endif /* __KERNEL__ */
diff -Nrup linux-2.6.10/include/asm-sparc/resource.h linux-2.6.10-prio/include/asm-sparc/resource.h
--- linux-2.6.10/include/asm-sparc/resource.h	2004-12-24 22:33:59.000000000 +0100
+++ linux-2.6.10-prio/include/asm-sparc/resource.h	2005-01-09 04:28:51.647156378 +0100
@@ -24,8 +24,9 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_PRIO	13		/* maximum scheduling priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	14
 
 /*
  * SuS says limits have to be unsigned.
@@ -49,6 +50,7 @@
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {MAX_SIGPENDING, MAX_SIGPENDING},	\
     {MQ_BYTES_MAX, MQ_BYTES_MAX},	\
+    {            0,              0 },	\
 }
 
 #endif /* __KERNEL__ */
diff -Nrup linux-2.6.10/include/asm-sparc64/resource.h linux-2.6.10-prio/include/asm-sparc64/resource.h
--- linux-2.6.10/include/asm-sparc64/resource.h	2004-12-24 22:33:50.000000000 +0100
+++ linux-2.6.10-prio/include/asm-sparc64/resource.h	2005-01-09 04:29:19.272404892 +0100
@@ -24,8 +24,9 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_PRIO	13		/* maximum scheduling priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	14
 
 /*
  * SuS says limits have to be unsigned.
@@ -48,6 +49,7 @@
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {MAX_SIGPENDING, MAX_SIGPENDING},	\
     {MQ_BYTES_MAX, MQ_BYTES_MAX},	\
+    {            0,              0 },	\
 }
 
 #endif /* __KERNEL__ */
diff -Nrup linux-2.6.10/include/asm-v850/resource.h linux-2.6.10-prio/include/asm-v850/resource.h
--- linux-2.6.10/include/asm-v850/resource.h	2004-12-24 22:33:50.000000000 +0100
+++ linux-2.6.10-prio/include/asm-v850/resource.h	2005-01-09 04:29:53.196025392 +0100
@@ -18,8 +18,9 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_PRIO	13		/* maximum scheduling priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	14
 
 /*
  * SuS says limits have to be unsigned.
@@ -44,6 +45,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
+	{            0,	             0 },		\
 }
 
 #endif /* __KERNEL__ */
diff -Nrup linux-2.6.10/include/asm-x86_64/resource.h linux-2.6.10-prio/include/asm-x86_64/resource.h
--- linux-2.6.10/include/asm-x86_64/resource.h	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6.10-prio/include/asm-x86_64/resource.h	2005-01-09 04:30:05.892760345 +0100
@@ -18,8 +18,9 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_PRIO	13		/* maximum scheduling priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	14
 
 /*
  * SuS says limits have to be unsigned.
@@ -44,6 +45,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
+	{            0,	             0 },		\
 }
 
 #endif /* __KERNEL__ */


