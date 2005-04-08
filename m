Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262657AbVDHDAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbVDHDAl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 23:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVDHDAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 23:00:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32170 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262657AbVDHDAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 23:00:25 -0400
Date: Thu, 7 Apr 2005 20:00:13 -0700
Message-Id: <200504080300.j3830DkA016351@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] i386: Use loaddebug macro consistently
X-Shopping-List: (1) Iniquitous consolation
   (2) Amorphous docks
   (3) Dark soil
   (4) Cavernous artery prescriptions
   (5) Turbulent suspenders
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the macro loaddebug from asm-i386/suspend.h to asm-i386/processor.h,
which is the place that makes sense for it to be defined, removes the
extra copy of the same macro in arch/i386/kernel/process.c, and makes
arch/i386/kernel/signal.c use the macro in place of its expansion.

This is a purely cosmetic cleanup for the normal i386 kernel.  
However, it is handy for Xen to be able to just redefine the loaddebug
macro once instead of also changing the signal.c code.


Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/arch/i386/kernel/signal.c
+++ linux-2.6/arch/i386/kernel/signal.c
@@ -618,7 +618,7 @@ int fastcall do_signal(struct pt_regs *r
 		 * inside the kernel.
 		 */
 		if (unlikely(current->thread.debugreg[7])) {
-			__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
+			loaddebug(&current->thread, 7);
 		}
 
 		/* Whee!  Actually deliver the signal.  */
--- linux-2.6/arch/i386/kernel/process.c
+++ linux-2.6/arch/i386/kernel/process.c
@@ -548,13 +548,6 @@ handle_io_bitmap(struct thread_struct *n
 	 */
 	tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET_LAZY;
 }
-/*
- * This special macro can be used to load a debugging register
- */
-#define loaddebug(thread,register) \
-		__asm__("movl %0,%%db" #register  \
-			: /* no output */ \
-			:"r" (thread->debugreg[register]))
 
 /*
  *	switch_to(x,yn) should switch tasks from x to y.
--- linux-2.6/include/asm-i386/processor.h
+++ linux-2.6/include/asm-i386/processor.h
@@ -499,6 +499,14 @@ static inline void load_esp0(struct tss_
 	regs->esp = new_esp;					\
 } while (0)
 
+/*
+ * This special macro can be used to load a debugging register
+ */
+#define loaddebug(thread,register) \
+               __asm__("movl %0,%%db" #register  \
+                       : /* no output */ \
+                       :"r" ((thread)->debugreg[register]))
+
 /* Forward declaration, a strange C thing */
 struct task_struct;
 struct mm_struct;
--- linux-2.6/include/asm-i386/suspend.h
+++ linux-2.6/include/asm-i386/suspend.h
@@ -36,11 +36,6 @@ struct saved_context {
 	unsigned long return_address;
 } __attribute__((packed));
 
-#define loaddebug(thread,register) \
-               __asm__("movl %0,%%db" #register  \
-                       : /* no output */ \
-                       :"r" ((thread)->debugreg[register]))
-
 #ifdef CONFIG_ACPI_SLEEP
 extern unsigned long saved_eip;
 extern unsigned long saved_esp;
