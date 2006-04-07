Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWDGTFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWDGTFB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWDGTFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:05:01 -0400
Received: from mail.timesys.com ([65.117.135.102]:19673 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP id S964891AbWDGTFA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:05:00 -0400
Subject: [PATCH] Fix compilation of 2.6.16-rt13 real-time preemption patch
	on PowerPC
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>,
       "Gleixner, Thomas" <thomas.gleixner@timesys.com>
Content-Type: text/plain
Date: Fri, 07 Apr 2006 14:58:16 -0400
Message-Id: <1144436297.10765.52.camel@excalibur.timesys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2006 18:58:17.0720 (UTC) FILETIME=[3B2E4780:01C65A75]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch corrects errors encountered when compiling the
2.6.16-rt13 real-time preemption patch on the PowerPC architecture:

      * The INIT_FS and INIT_FILES macro definitions changed, but
        corresponding changes to the calls were missed on PowerPC.

      * The new TIF_NEED_RESCHED_DELAYED definition caused an overflow
        of a 16-bit immediate load field in several PowerPC
        assembly-language instructions (e.g. in entry.S).  This patch
        changes the definition of TIF_NEED_RESCHED_DELAYED from the
        value 16 to the value 13 (which appears to have been previously
        unused).  (All bits from 0 to 15 are now in use on PPC, so if
        any new thread_info flags are needed, we'll have to actually fix
        the PPC assembly code to deal with the resulting 32-bit
        quantity.)

      * The file include/asm-powerpc/irqflags.h was missing completely
        on PowerPC.  For now, I've supplied a stub file.  There is
        currently no support for CONFIG_DEBUG_TRACE_IRQFLAGS.

Thanks go to Thomas Gleixner for his comments/suggestions on this patch.

I've successfully built and test-booted this on an AMCC440EP "Bamboo" board.


Signed-off-by: Walt Wimer <walt.wimer@timesys.com>



diff -Naur linux-2.6.16-rt13-orig/arch/powerpc/kernel/init_task.c linux-2.6.16-rt13-fixd/arch/powerpc/kernel/init_task.c
--- linux-2.6.16-rt13-orig/arch/powerpc/kernel/init_task.c	2006-04-07 13:26:49.000000000 -0400
+++ linux-2.6.16-rt13-fixd/arch/powerpc/kernel/init_task.c	2006-03-20 00:53:29.000000000 -0500
@@ -3,12 +3,12 @@
 #include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/init_task.h>
-#include <linux/fs_struct.h>
+#include <linux/fs.h>
 #include <linux/mqueue.h>
 #include <asm/uaccess.h>
 
-static struct fs_struct init_fs = INIT_FS(init_fs);
-static struct files_struct init_files = INIT_FILES(init_files);
+static struct fs_struct init_fs = INIT_FS;
+static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
diff -Naur linux-2.6.16-rt13-orig/include/asm-powerpc/thread_info.h linux-2.6.16-rt13-fixd/include/asm-powerpc/thread_info.h
--- linux-2.6.16-rt13-orig/include/asm-powerpc/thread_info.h	2006-04-07 13:26:55.000000000 -0400
+++ linux-2.6.16-rt13-fixd/include/asm-powerpc/thread_info.h	2006-04-07 12:44:05.000000000 -0400
@@ -119,9 +119,9 @@
 #define TIF_MEMDIE		10
 #define TIF_SECCOMP		11	/* secure computing */
 #define TIF_RESTOREALL		12	/* Restore all regs (implies NOERROR) */
+#define TIF_NEED_RESCHED_DELAYED 13	/* reschedule on return to userspace */
 #define TIF_NOERROR		14	/* Force successful syscall return */
 #define TIF_RESTORE_SIGMASK	15	/* Restore signal mask in do_signal */
-#define TIF_NEED_RESCHED_DELAYED 16	/* reschedule on return to userspace */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
diff -Naur linux-2.6.16-rt13-orig/include/asm-powerpc/irqflags.h linux-2.6.16-rt13-fixd/include/asm-powerpc/irqflags.h
--- linux-2.6.16-rt13-orig/include/asm-powerpc/irqflags.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.16-rt13-fixd/include/asm-powerpc/irqflags.h	2006-04-07 12:39:01.000000000 -0400
@@ -0,0 +1,33 @@
+/*
+ * include/asm-powerpc/irqflags.h
+ *
+ * IRQ flags handling
+ *
+ * This file gets included from lowlevel asm headers too, to provide
+ * wrapped versions of the local_irq_*() APIs, based on the
+ * raw_local_irq_*() macros from the lowlevel headers.
+ */
+#ifndef _ASM_IRQFLAGS_H
+#define _ASM_IRQFLAGS_H
+
+/*
+ * Get definitions for raw_local_save_flags(x), etc.
+ */
+#include <asm-powerpc/hw_irq.h>
+
+/*
+ * Do the CPU's IRQ-state tracing from assembly code. We call a
+ * C function, so save all the C-clobbered registers:
+ */
+#ifdef CONFIG_DEBUG_TRACE_IRQFLAGS
+
+#error No support on PowerPC yet for CONFIG_DEBUG_TRACE_IRQFLAGS
+
+#else
+# define TRACE_IRQS_ON
+# define TRACE_IRQS_OFF
+# define TRACE_IRQS_ON_STR
+# define TRACE_IRQS_OFF_STR
+#endif
+
+#endif



