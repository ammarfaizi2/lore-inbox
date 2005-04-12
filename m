Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVDMBaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVDMBaU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVDLTwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:52:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:48584 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262165AbVDLKbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:51 -0400
Message-Id: <200504121031.j3CAVg4w005383@shell0.pdx.osdl.net>
Subject: [patch 064/198] i386: Use loaddebug macro consistently
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@redhat.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland McGrath <roland@redhat.com>

This moves the macro loaddebug from asm-i386/suspend.h to
asm-i386/processor.h, which is the place that makes sense for it to be
defined, removes the extra copy of the same macro in
arch/i386/kernel/process.c, and makes arch/i386/kernel/signal.c use the
macro in place of its expansion.

This is a purely cosmetic cleanup for the normal i386 kernel.  However, it
is handy for Xen to be able to just redefine the loaddebug macro once
instead of also changing the signal.c code.

Signed-off-by: Roland McGrath <roland@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/kernel/process.c   |    7 -------
 25-akpm/arch/i386/kernel/signal.c    |    2 +-
 25-akpm/include/asm-i386/processor.h |    8 ++++++++
 25-akpm/include/asm-i386/suspend.h   |    5 -----
 4 files changed, 9 insertions(+), 13 deletions(-)

diff -puN arch/i386/kernel/process.c~i386-use-loaddebug-macro-consistently arch/i386/kernel/process.c
--- 25/arch/i386/kernel/process.c~i386-use-loaddebug-macro-consistently	2005-04-12 03:21:18.732289160 -0700
+++ 25-akpm/arch/i386/kernel/process.c	2005-04-12 03:21:18.740287944 -0700
@@ -558,13 +558,6 @@ handle_io_bitmap(struct thread_struct *n
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
diff -puN arch/i386/kernel/signal.c~i386-use-loaddebug-macro-consistently arch/i386/kernel/signal.c
--- 25/arch/i386/kernel/signal.c~i386-use-loaddebug-macro-consistently	2005-04-12 03:21:18.734288856 -0700
+++ 25-akpm/arch/i386/kernel/signal.c	2005-04-12 03:21:18.741287792 -0700
@@ -618,7 +618,7 @@ int fastcall do_signal(struct pt_regs *r
 		 * inside the kernel.
 		 */
 		if (unlikely(current->thread.debugreg[7])) {
-			__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
+			loaddebug(&current->thread, 7);
 		}
 
 		/* Whee!  Actually deliver the signal.  */
diff -puN include/asm-i386/processor.h~i386-use-loaddebug-macro-consistently include/asm-i386/processor.h
--- 25/include/asm-i386/processor.h~i386-use-loaddebug-macro-consistently	2005-04-12 03:21:18.735288704 -0700
+++ 25-akpm/include/asm-i386/processor.h	2005-04-12 03:21:18.741287792 -0700
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
diff -puN include/asm-i386/suspend.h~i386-use-loaddebug-macro-consistently include/asm-i386/suspend.h
--- 25/include/asm-i386/suspend.h~i386-use-loaddebug-macro-consistently	2005-04-12 03:21:18.736288552 -0700
+++ 25-akpm/include/asm-i386/suspend.h	2005-04-12 03:21:18.742287640 -0700
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
_
