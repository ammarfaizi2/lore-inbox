Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbUJ3O6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUJ3O6K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 10:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbUJ3O5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 10:57:39 -0400
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:43987 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261216AbUJ3OlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:41:12 -0400
Message-ID: <4183A7F8.3040108@kolivas.org>
Date: Sun, 31 Oct 2004 00:40:56 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH][plugsched 23/28] Make scheduler selection configurable
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig668E4B5B15A3E8F02BC37165"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig668E4B5B15A3E8F02BC37165
Content-Type: multipart/mixed;
 boundary="------------040103030808090409080002"

This is a multi-part message in MIME format.
--------------040103030808090409080002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make scheduler selection configurable


--------------040103030808090409080002
Content-Type: text/x-patch;
 name="config_schedulers.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config_schedulers.diff"

Put the union definition into scheduler.h, and ifdef only schedulers chosen
to be compiled in. This allows the addition of cpu schedulers without having
to modify sched.h and will compile task_struct at the cheapest cost possible
for the union.

Select the scheduler based on bootparam, save a copy of the init task and
use that along with running sched_init() again to start a different
scheduler.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/sched.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/sched.h	2004-10-30 00:24:59.472682663 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/sched.h	2004-10-30 00:25:01.363380167 +1000
@@ -520,9 +520,7 @@ struct task_struct {
 	int lock_depth;		/* Lock depth */
 
 	int static_prio;	/* A commonality between cpu schedulers */
-	union {
-		struct cpusched_ingo ingosched;
-	} u;
+	union cpusched u;
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
@@ -757,6 +755,7 @@ static inline int kstack_end(void *addr)
 
 extern union thread_union init_thread_union;
 extern struct task_struct init_task;
+extern struct task_struct base_init_task;
 
 extern struct   mm_struct init_mm;
 
Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/scheduler.h	2004-10-30 00:24:59.473682503 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h	2004-10-30 00:25:01.363380167 +1000
@@ -53,6 +53,7 @@ struct sched_drv
  * separate structs placed into the cpusched union in task_struct.
  */
 
+#ifdef CONFIG_CPUSCHED_INGO
 struct cpusched_ingo {
 	int prio;
 	struct list_head run_list;
@@ -65,3 +66,10 @@ struct cpusched_ingo {
 	unsigned long long last_ran;
 	int activated;
 };
+#endif
+
+union cpusched {
+#ifdef CONFIG_CPUSCHED_INGO
+		struct cpusched_ingo ingosched;
+#endif
+};
Index: linux-2.6.10-rc1-mm2-plugsched1/init/Kconfig
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/init/Kconfig	2004-10-30 00:24:59.470682983 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/init/Kconfig	2004-10-30 00:25:01.364380007 +1000
@@ -249,6 +249,33 @@ config IKCONFIG_PROC
 	  through /proc/config.gz.
 
 
+config PLUGSCHED
+	bool "Support for multiple cpu schedulers"
+	default y
+	help
+	  Say Y here if you want to compile in support for multiple
+	  cpu schedulers. The cpu scheduler may be selected at boot time
+	  with the boot parameter "cpusched=". The choice of which cpu
+	  schedulers to compile into the kernel can be made by enabling
+	  "Configure standard kernel features" otherwise all cpu schedulers
+	  supported will be compiled in.
+
+choice
+	prompt "Default cpu scheduler"
+	help
+	  This option allows you to choose which cpu scheduler shall be
+	  booted by default at startup if you have plugsched support, or
+	  it will choose which is the only scheduler compiled in.
+	  
+config CPUSCHED_DEFAULT_INGO
+	bool "Ingosched cpu scheduler"
+	select CPUSCHED_INGO
+	---help---
+	  This is the default cpu scheduler which is an O(1) dual priority
+	  array scheduler with a hybrid interactive design.
+
+endchoice
+
 menuconfig EMBEDDED
 	bool "Configure standard kernel features (for small systems)"
 	help
@@ -257,6 +284,16 @@ menuconfig EMBEDDED
           environments which can tolerate a "non-standard" kernel.
           Only use this if you really know what you are doing.
 
+config CPUSCHED_INGO
+	bool "Ingosched cpu scheduler" if EMBEDDED
+	depends on PLUGSCHED
+	default y
+	---help---
+	  This is the default cpu scheduler which is an O(1) dual priority
+	  array scheduler with a hybrid interactive design.
+	  To boot this cpu scheduler, if it is not the default, use the
+	  bootparam "cpusched=ingosched".
+
 config KALLSYMS
 	 bool "Load all symbols for debugging/kksymoops" if EMBEDDED
 	 default y
Index: linux-2.6.10-rc1-mm2-plugsched1/init/main.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/init/main.c	2004-10-30 00:24:59.470682983 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/init/main.c	2004-10-30 00:25:24.902614077 +1000
@@ -488,10 +488,11 @@ void __init parse_early_param(void)
 	done = 1;
 }
 
+struct task_struct base_init_task;
+
 /*
  *	Activate the first processor.
  */
-
 asmlinkage void __init start_kernel(void)
 {
 	char * command_line;
@@ -513,6 +514,11 @@ asmlinkage void __init start_kernel(void
 	smp_prepare_boot_cpu();
 
 	/*
+	 * Save a copy of the baseline init_task in case we need to start
+	 * another cpu scheduler.
+	 */
+	base_init_task = init_task;
+	/*
 	 * Set up the scheduler prior starting any interrupts (such as the
 	 * timer interrupt). Full topology setup happens at smp_init()
 	 * time - but meanwhile we still have a functioning scheduler.
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/Makefile
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/Makefile	2004-10-30 00:24:59.471682823 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/Makefile	2004-10-30 00:25:01.365379847 +1000
@@ -7,8 +7,9 @@ obj-y     = scheduler.o fork.o exec_doma
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o wait.o kfifo.o sched.o
+	    kthread.o wait.o kfifo.o
 
+obj-$(CONFIG_CPUSCHED_INGO) += sched.o
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o spinlock.o
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-30 00:24:59.472682663 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-30 00:25:01.366379687 +1000
@@ -36,6 +36,7 @@
 #include <linux/seq_file.h>
 #include <linux/syscalls.h>
 #include <linux/times.h>
+#include <linux/sched.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -879,12 +880,34 @@ EXPORT_SYMBOL(complete_all);
 
 extern struct sched_drv ingo_sched_drv;
 
-struct sched_drv *scheduler = &ingo_sched_drv;
+struct sched_drv *scheduler =
+#if defined(CONFIG_CPUSCHED_DEFAULT_INGO)
+	&ingo_sched_drv;
+#else
+	NULL;
+#error "You must have at least 1 cpu scheduler selected"
+#endif
 
 static int __init scheduler_setup(char *str)
 {
-	if (!strcmp(str, "ingosched"))
-		scheduler = &ingo_sched_drv;
+	struct sched_drv *chosen_sched = NULL;
+#if defined(CONFIG_CPUSCHED_INGO)
+	if (!strcmp(str, ingo_sched_drv.cpusched_name))
+		chosen_sched = &ingo_sched_drv;
+#endif
+	if (chosen_sched && chosen_sched != scheduler) {
+		/*
+		 * A different cpu scheduler from the default has been
+		 * chosen. We need to reinit the scheduler. Set the scheduler
+		 * pointer to the new chosen scheduler.
+		 */
+		scheduler = chosen_sched;
+		/* Get a fresh init_task from the saved one */
+		init_task = base_init_task;
+		/* Repeate sched_init sequence */
+		sched_init();
+		preempt_disable();
+	}
 	return 1;
 }
 



--------------040103030808090409080002--

--------------enig668E4B5B15A3E8F02BC37165
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6f4ZUg7+tp6mRURAnAJAKCMxNeTj5hWfNmoB9TLo2mGJmZ+yACdHm9e
IAMPKJfiKVsHunXwoWQivI8=
=aQiN
-----END PGP SIGNATURE-----

--------------enig668E4B5B15A3E8F02BC37165--
