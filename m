Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbVHYFWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVHYFWW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbVHYFWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:22:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10956 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964826AbVHYFWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:22:16 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (20/22) task_thread_info - part 3/4
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8AEr-0005ep-Q8@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:25:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a) added embedded thread_info [m68k processor.h]
b) added missing symbols in asm-offsets.c
c) task_thread_info() and freinds in asm-m68k/thread_info.h
d) made m68k thread_info.h included by m68k processor.h, not the
other way round.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-includes/arch/m68k/kernel/asm-offsets.c RC13-rc7-m68k/arch/m68k/kernel/asm-offsets.c
--- RC13-rc7-includes/arch/m68k/kernel/asm-offsets.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-m68k/arch/m68k/kernel/asm-offsets.c	2005-08-25 00:54:19.000000000 -0400
@@ -31,6 +31,7 @@
 	DEFINE(TASK_SIGPENDING, offsetof(struct task_struct, thread.work.sigpending));
 	DEFINE(TASK_NOTIFY_RESUME, offsetof(struct task_struct, thread.work.notify_resume));
 	DEFINE(TASK_THREAD, offsetof(struct task_struct, thread));
+	DEFINE(TASK_INFO, offsetof(struct task_struct, thread.info));
 	DEFINE(TASK_MM, offsetof(struct task_struct, mm));
 	DEFINE(TASK_ACTIVE_MM, offsetof(struct task_struct, active_mm));
 
@@ -45,6 +46,10 @@
 	DEFINE(THREAD_FPCNTL, offsetof(struct thread_struct, fpcntl));
 	DEFINE(THREAD_FPSTATE, offsetof(struct thread_struct, fpstate));
 
+	/* offsets into the thread_info struct */
+	DEFINE(TINFO_PREEMPT, offsetof(struct thread_info, preempt_count));
+	DEFINE(HARDIRQ_SHIFT, HARDIRQ_SHIFT);
+
 	/* offsets into the pt_regs */
 	DEFINE(PT_D0, offsetof(struct pt_regs, d0));
 	DEFINE(PT_ORIG_D0, offsetof(struct pt_regs, orig_d0));
diff -urN RC13-rc7-includes/include/asm-m68k/processor.h RC13-rc7-m68k/include/asm-m68k/processor.h
--- RC13-rc7-includes/include/asm-m68k/processor.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-m68k/include/asm-m68k/processor.h	2005-08-25 00:54:19.000000000 -0400
@@ -14,6 +14,7 @@
 #define current_text_addr() ({ __label__ _l; _l: &&_l;})
 
 #include <linux/config.h>
+#include <linux/thread_info.h>
 #include <asm/segment.h>
 #include <asm/fpu.h>
 #include <asm/ptrace.h>
@@ -79,6 +80,7 @@
 	unsigned long  fpcntl[3];	/* fp control regs */
 	unsigned char  fpstate[FPSTATESIZE];  /* floating point state */
 	struct task_work work;
+	struct thread_info info;
 };
 
 #define INIT_THREAD  {							\
diff -urN RC13-rc7-includes/include/asm-m68k/thread_info.h RC13-rc7-m68k/include/asm-m68k/thread_info.h
--- RC13-rc7-includes/include/asm-m68k/thread_info.h	2005-08-10 10:37:53.000000000 -0400
+++ RC13-rc7-m68k/include/asm-m68k/thread_info.h	2005-08-25 00:54:19.000000000 -0400
@@ -2,7 +2,6 @@
 #define _ASM_M68K_THREAD_INFO_H
 
 #include <asm/types.h>
-#include <asm/processor.h>
 #include <asm/page.h>
 
 struct thread_info {
@@ -35,11 +34,11 @@
 #define free_thread_info(ti)  free_pages((unsigned long)(ti),1)
 #endif /* PAGE_SHIFT == 13 */
 
-//#define init_thread_info	(init_task.thread.info)
-#define init_stack		(init_thread_union.stack)
-
-#define current_thread_info()	(current->thread_info)
+#define init_thread_info	(init_thread_union.thread_info)
+#define init_stack	(init_thread_union.stack)
 
+#define task_thread_info(tsk)   (&(tsk)->thread.info)
+#define current_thread_info()	task_thread_info(current)
 
 #define __HAVE_THREAD_FUNCTIONS
 
@@ -52,6 +51,10 @@
 
 extern int thread_flag_fixme(void);
 
+#define setup_thread_info(p, ti) do (ti)->task = p; while(0)
+
+#define end_of_stack(p) ((unsigned long *)(p)->thread_info + 1)
+
 /*
  * flag set/clear/test wrappers
  * - pass TIF_xxxx constants to these functions
