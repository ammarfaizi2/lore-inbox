Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbTEATyk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 15:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbTEATyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 15:54:40 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:6345 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262261AbTEATyi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 15:54:38 -0400
From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Organization: Ozzmosis Corp.
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] acpi-swsusp19
Date: Thu, 1 May 2003 17:07:28 -0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305011707.29238.lucasvr@gobolinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have found some problems when compiling a patched kernel (2.4.20) with both 
ACPI and software suspend disabled (version acpi-acpi20021212-swsusp19):

kernel/kernel.o: In function `schedule':
kernel/kernel.o(.text+0x25d): undefined reference to `TASK_SUSPENDED'
kernel/kernel.o(.text+0x2da): undefined reference to `TASK_SUSPENDED'
make[1]: *** [kallsyms] Error 1


The patch below can fix this error.
Lucas


--- 2.4.20-swsusp/kernel/sched.c	2003-04-21 23:06:29.000000000 -0300
+++ 2.4.20-lucasvr/kernel/sched.c	2003-04-29 23:28:21.000000000 -0300
@@ -29,6 +29,9 @@
 #include <linux/completion.h>
 #include <linux/prefetch.h>
 #include <linux/compiler.h>
+#ifdef CONFIG_SOFTWARE_SUSPEND
+#include <linux/suspend.h>
+#endif
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -115,15 +118,24 @@
 #ifdef CONFIG_SMP
 
 #define idle_task(cpu) (init_tasks[cpu_number_map(cpu)])
+#ifdef CONFIG_SOFTWARE_SUSPEND
+#define can_schedule(p,cpu) \
+	((!TASK_SUSPENDED(p)) && ((p)->cpus_runnable & (p)->cpus_allowed & (1UL << 
cpu)))
+#else
 #define can_schedule(p,cpu) \
-	((p)->cpus_runnable & (p)->cpus_allowed & (1 << cpu))
+	((p)->cpus_runnable & (p)->cpus_allowed & (1 << cpu))	
+#endif /* CONFIG_SOFTWARE_SUSPEND */
 
 #else
 
 #define idle_task(cpu) (&init_task)
+#ifdef CONFIG_SOFTWARE_SUSPEND
+#define can_schedule(p,cpu) (!TASK_SUSPENDED(p))
+#else
 #define can_schedule(p,cpu) (1)
+#endif /* CONFIG_SOFTWARE_SUSPEND */
 
-#endif
+#endif /* CONFIG_SMP */
 
 void scheduling_functions_start_here(void) { }
 
@@ -634,6 +646,11 @@
 	task_set_cpu(next, this_cpu);
 	spin_unlock_irq(&runqueue_lock);
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	if (unlikely(TASK_SUSPENDED(next)))
+		printk("Scheduling suspended task %s!\n", next->comm);
+#endif
+
 	if (unlikely(prev == next)) {
 		/* We won't go through the normal tail, so do this by hand */
 		prev->policy &= ~SCHED_YIELD;

