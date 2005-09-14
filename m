Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbVINW1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbVINW1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbVINW1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:27:09 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:61445 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S965076AbVINW1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:27:07 -0400
Message-Id: <200509142155.j8ELtm5c012124@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Allan Graves <allan.graves@gmail.com>
Subject: [PATCH 1/10] UML - _switch_to code consolidation
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Sep 2005 17:55:47 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves code that is in both switch_to_tt and
switch_to_skas to the top level _switch_to function, keeping us from
duplicating code.  It is required for the stack trace patch to work
properly.

Signed-off-by: Allan Graves <allan.graves@gmail.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.13.orig/arch/um/kernel/process_kern.c	2005-09-13 16:04:11.000000000 -0400
+++ linux-2.6.13/arch/um/kernel/process_kern.c	2005-09-13 16:08:18.000000000 -0400
@@ -113,8 +113,16 @@
 
 void *_switch_to(void *prev, void *next, void *last)
 {
-	return(CHOOSE_MODE(switch_to_tt(prev, next), 
-			   switch_to_skas(prev, next)));
+        struct task_struct *from = prev;
+        struct task_struct *to= next;
+
+        to->thread.prev_sched = from;
+        set_current(to);
+
+	CHOOSE_MODE_PROC(switch_to_tt, switch_to_skas, prev, next);
+
+        return(current->thread.prev_sched); 
+
 }
 
 void interrupt_end(void)
Index: linux-2.6.13/arch/um/kernel/skas/include/mode_kern-skas.h
===================================================================
--- linux-2.6.13.orig/arch/um/kernel/skas/include/mode_kern-skas.h	2005-09-13 16:04:12.000000000 -0400
+++ linux-2.6.13/arch/um/kernel/skas/include/mode_kern-skas.h	2005-09-13 16:08:18.000000000 -0400
@@ -11,7 +11,7 @@
 #include "asm/ptrace.h"
 
 extern void flush_thread_skas(void);
-extern void *switch_to_skas(void *prev, void *next);
+extern void switch_to_skas(void *prev, void *next);
 extern void start_thread_skas(struct pt_regs *regs, unsigned long eip,
 			      unsigned long esp);
 extern int copy_thread_skas(int nr, unsigned long clone_flags,
Index: linux-2.6.13/arch/um/kernel/skas/process_kern.c
===================================================================
--- linux-2.6.13.orig/arch/um/kernel/skas/process_kern.c	2005-09-13 16:05:34.000000000 -0400
+++ linux-2.6.13/arch/um/kernel/skas/process_kern.c	2005-09-13 16:08:18.000000000 -0400
@@ -24,7 +24,7 @@
 #include "proc_mm.h"
 #include "registers.h"
 
-void *switch_to_skas(void *prev, void *next)
+void switch_to_skas(void *prev, void *next)
 {
 	struct task_struct *from, *to;
 
@@ -35,16 +35,11 @@
 	if(current->pid == 0)
 		switch_timers(0);
 
-	to->thread.prev_sched = from;
-	set_current(to);
-
 	switch_threads(&from->thread.mode.skas.switch_buf, 
 		       to->thread.mode.skas.switch_buf);
 
 	if(current->pid == 0)
 		switch_timers(1);
-
-	return(current->thread.prev_sched);
 }
 
 extern void schedule_tail(struct task_struct *prev);
Index: linux-2.6.13/arch/um/kernel/tt/include/mode_kern-tt.h
===================================================================
--- linux-2.6.13.orig/arch/um/kernel/tt/include/mode_kern-tt.h	2005-09-13 16:04:12.000000000 -0400
+++ linux-2.6.13/arch/um/kernel/tt/include/mode_kern-tt.h	2005-09-13 16:08:18.000000000 -0400
@@ -11,7 +11,7 @@
 #include "asm/ptrace.h"
 #include "asm/uaccess.h"
 
-extern void *switch_to_tt(void *prev, void *next);
+extern void switch_to_tt(void *prev, void *next);
 extern void flush_thread_tt(void);
 extern void start_thread_tt(struct pt_regs *regs, unsigned long eip,
 			   unsigned long esp);
Index: linux-2.6.13/arch/um/kernel/tt/process_kern.c
===================================================================
--- linux-2.6.13.orig/arch/um/kernel/tt/process_kern.c	2005-09-13 16:04:11.000000000 -0400
+++ linux-2.6.13/arch/um/kernel/tt/process_kern.c	2005-09-13 16:08:38.000000000 -0400
@@ -26,7 +26,7 @@
 #include "init.h"
 #include "tt.h"
 
-void *switch_to_tt(void *prev, void *next, void *last)
+int switch_to_tt(void *prev, void *next, void *last)
 {
 	struct task_struct *from, *to, *prev_sched;
 	unsigned long flags;
@@ -36,8 +36,6 @@
 	from = prev;
 	to = next;
 
-	to->thread.prev_sched = from;
-
 	cpu = from->thread_info->cpu;
 	if(cpu == 0)
 		forward_interrupts(to->thread.mode.tt.extern_pid);
@@ -53,7 +51,6 @@
 	forward_pending_sigio(to->thread.mode.tt.extern_pid);
 
 	c = 0;
-	set_current(to);
 
 	err = os_write_file(to->thread.mode.tt.switch_pipe[1], &c, sizeof(c));
 	if(err != sizeof(c))
@@ -85,8 +82,6 @@
 
 	flush_tlb_all();
 	local_irq_restore(flags);
-
-	return(current->thread.prev_sched);
 }
 
 void release_thread_tt(struct task_struct *task)

