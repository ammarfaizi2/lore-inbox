Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267623AbUHUS0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267623AbUHUS0n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 14:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266895AbUHUSZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 14:25:02 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:51443 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267606AbUHUSYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 14:24:31 -0400
Date: Sat, 21 Aug 2004 14:28:45 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, John Levon <levon@movementarian.org>,
       William Lee Irwin III <wli@holomorphy.com>, Keith Owens <kaos@sgi.com>
Subject: [PATCH][3/4] Completely out of line spinlocks / readprofile
Message-ID: <Pine.LNX.4.58.0408211333440.27390@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Making the spinlock text non inline means that samples during lock
contention show the spinlock text as opposed to what we really want. So
use profile_ticks to provide a smarter way of detecting where we are.

 arch/i386/kernel/time.c     |   12 ++++++++++++
 arch/x86_64/kernel/time.c   |   13 +++++++++++++
 include/asm-i386/ptrace.h   |    4 ++++
 include/asm-x86_64/ptrace.h |    4 ++++
 4 files changed, 33 insertions(+)

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.8.1-mm3/include/asm-i386/ptrace.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm3/include/asm-i386/ptrace.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 ptrace.h
--- linux-2.6.8.1-mm3/include/asm-i386/ptrace.h	21 Aug 2004 13:15:01 -0000	1.1.1.1
+++ linux-2.6.8.1-mm3/include/asm-i386/ptrace.h	21 Aug 2004 16:23:52 -0000
@@ -57,7 +57,11 @@ struct pt_regs {
 #ifdef __KERNEL__
 #define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))
 #define instruction_pointer(regs) ((regs)->eip)
+#ifdef CONFIG_COOL_SPINLOCK
+extern unsigned long profile_pc(struct pt_regs *regs);
+#else
 #define profile_pc(regs) instruction_pointer(regs)
 #endif
+#endif

 #endif
Index: linux-2.6.8.1-mm3/include/asm-x86_64/ptrace.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm3/include/asm-x86_64/ptrace.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 ptrace.h
--- linux-2.6.8.1-mm3/include/asm-x86_64/ptrace.h	21 Aug 2004 13:15:02 -0000	1.1.1.1
+++ linux-2.6.8.1-mm3/include/asm-x86_64/ptrace.h	21 Aug 2004 16:55:13 -0000
@@ -83,7 +83,11 @@ struct pt_regs {
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 #define user_mode(regs) (!!((regs)->cs & 3))
 #define instruction_pointer(regs) ((regs)->rip)
+#ifdef CONFIG_COOL_SPINLOCK
+extern unsigned long profile_pc(struct pt_regs *regs);
+#else
 #define profile_pc(regs) instruction_pointer(regs)
+#endif
 void signal_fault(struct pt_regs *regs, void __user *frame, char *where);

 enum {
Index: linux-2.6.8.1-mm3/arch/i386/kernel/time.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm3/arch/i386/kernel/time.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 time.c
--- linux-2.6.8.1-mm3/arch/i386/kernel/time.c	21 Aug 2004 13:14:49 -0000	1.1.1.1
+++ linux-2.6.8.1-mm3/arch/i386/kernel/time.c	21 Aug 2004 18:03:04 -0000
@@ -200,7 +200,19 @@ unsigned long long monotonic_clock(void)
 }
 EXPORT_SYMBOL(monotonic_clock);

+#ifdef CONFIG_COOL_SPINLOCK
+unsigned long profile_pc(struct pt_regs *regs)
+{
+	unsigned long pc = instruction_pointer(regs);
+
+	if (pc >= (unsigned long)&start_spin_lock_text &&
+	    pc <= (unsigned long)&end_spin_lock_text)
+		return *(unsigned long *)regs->esp;

+	return pc;
+}
+EXPORT_SYMBOL(profile_pc);
+#endif
 /*
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
Index: linux-2.6.8.1-mm3/arch/x86_64/kernel/time.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm3/arch/x86_64/kernel/time.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 time.c
--- linux-2.6.8.1-mm3/arch/x86_64/kernel/time.c	21 Aug 2004 13:14:53 -0000	1.1.1.1
+++ linux-2.6.8.1-mm3/arch/x86_64/kernel/time.c	21 Aug 2004 18:02:46 -0000
@@ -296,6 +296,19 @@ unsigned long long monotonic_clock(void)
 }
 EXPORT_SYMBOL(monotonic_clock);

+#ifdef CONFIG_COOL_SPINLOCK
+unsigned long profile_pc(struct pt_regs *regs)
+{
+	unsigned long pc = instruction_pointer(regs);
+
+	if (pc >= (unsigned long)&start_spin_lock_text &&
+	    pc <= (unsigned long)&end_spin_lock_text)
+		return *(unsigned long *)regs->rsp;
+
+	return pc;
+}
+EXPORT_SYMBOL(profile_pc);
+#endif

 static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
