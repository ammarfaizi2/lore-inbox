Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269700AbUICNsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269700AbUICNsh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 09:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269698AbUICNrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:47:33 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:50588 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S269695AbUICNrK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:47:10 -0400
Date: Fri, 3 Sep 2004 15:47:45 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: packed stack vs. cpu hotplug.
Message-ID: <20040903134744.GB3493@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: packed stack vs. cpu hotplug.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The different stack frame layout for packed stacks broke cpu hotplug.
Recreate the initial stack frame of the idle thread for offline cpus
coming back online. Reenable interrupts after loading the initial
registers. In addition this patch contains two more bug fixes:
a typo for 64 bit (__SMALL_STACK_SIZE vs. __SMALL_STACK) and
show_trace didn't show a trace if for task == NULL.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/entry.S       |    2 +-
 arch/s390/kernel/entry64.S     |    2 +-
 arch/s390/kernel/smp.c         |    8 +++++++-
 arch/s390/kernel/traps.c       |    4 ++--
 include/asm-s390/thread_info.h |    2 +-
 5 files changed, 12 insertions(+), 6 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-s390/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	Fri Sep  3 15:26:11 2004
+++ linux-2.6-s390/arch/s390/kernel/entry.S	Fri Sep  3 15:26:30 2004
@@ -602,8 +602,8 @@
         l       %r15,__LC_SAVE_AREA+60 # load ksp
         lctl    %c0,%c15,__LC_CREGS_SAVE_AREA # get new ctl regs
         lam     %a0,%a15,__LC_AREGS_SAVE_AREA
-        stosm   0(%r15),0x04           # now we can turn dat on
         lm      %r6,%r15,__SF_GPRS(%r15) # load registers from clone
+        stosm   __SF_EMPTY(%r15),0x04    # now we can turn dat on
         basr    %r14,0
         l       %r14,restart_addr-.(%r14)
         br      %r14                   # branch to start_secondary
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-s390/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	Fri Sep  3 15:26:11 2004
+++ linux-2.6-s390/arch/s390/kernel/entry64.S	Fri Sep  3 15:26:30 2004
@@ -644,8 +644,8 @@
         lctlg   %c0,%c15,0(%r10) # get new ctl regs
         lghi    %r10,__LC_AREGS_SAVE_AREA
         lam     %a0,%a15,0(%r10)
-        stosm   0(%r15),0x04           # now we can turn dat on
         lmg     %r6,%r15,__SF_GPRS(%r15) # load registers from clone
+        stosm   __SF_EMPTY(%r15),0x04    # now we can turn dat on
 	jg      start_secondary
 #else
 /*
diff -urN linux-2.6/arch/s390/kernel/smp.c linux-2.6-s390/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	Fri Sep  3 15:26:11 2004
+++ linux-2.6-s390/arch/s390/kernel/smp.c	Fri Sep  3 15:26:30 2004
@@ -637,6 +637,7 @@
 {
 	struct task_struct *idle;
         struct _lowcore    *cpu_lowcore;
+	struct stack_frame *sf;
         sigp_ccode          ccode;
 	int                 curr_cpu;
 
@@ -660,9 +661,14 @@
 
 	idle = current_set[cpu];
         cpu_lowcore = lowcore_ptr[cpu];
-	cpu_lowcore->save_area[15] = idle->thread.ksp;
 	cpu_lowcore->kernel_stack = (unsigned long)
 		idle->thread_info + (THREAD_SIZE);
+	sf = (struct stack_frame *) (cpu_lowcore->kernel_stack
+				     - sizeof(struct pt_regs)
+				     - sizeof(struct stack_frame));
+	memset(sf, 0, sizeof(struct stack_frame));
+	sf->gprs[9] = (unsigned long) sf;
+	cpu_lowcore->save_area[15] = (unsigned long) sf;
 	__ctl_store(cpu_lowcore->cregs_save_area[0], 0, 15);
 	__asm__ __volatile__("stam  0,15,0(%0)"
 			     : : "a" (&cpu_lowcore->access_regs_save_area)
diff -urN linux-2.6/arch/s390/kernel/traps.c linux-2.6-s390/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	Fri Sep  3 15:26:11 2004
+++ linux-2.6-s390/arch/s390/kernel/traps.c	Fri Sep  3 15:26:30 2004
@@ -138,8 +138,8 @@
 		__show_trace(sp, (unsigned long) task->thread_info,
 			     (unsigned long) task->thread_info + THREAD_SIZE);
 	else
-		__show_trace(sp, S390_lowcore.thread_info - THREAD_SIZE,
-			     S390_lowcore.thread_info);
+		__show_trace(sp, S390_lowcore.thread_info,
+			     S390_lowcore.thread_info + THREAD_SIZE);
 	printk("\n");
 }
 
diff -urN linux-2.6/include/asm-s390/thread_info.h linux-2.6-s390/include/asm-s390/thread_info.h
--- linux-2.6/include/asm-s390/thread_info.h	Fri Sep  3 15:26:16 2004
+++ linux-2.6-s390/include/asm-s390/thread_info.h	Fri Sep  3 15:26:30 2004
@@ -23,7 +23,7 @@
 #define ASYNC_ORDER  0
 #endif
 #else /* __s390x__ */
-#ifndef __SMALL_STACK_STACK
+#ifndef __SMALL_STACK
 #define THREAD_ORDER 2
 #define ASYNC_ORDER  2
 #else
