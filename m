Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270013AbUIDApH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270013AbUIDApH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 20:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270007AbUIDAou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 20:44:50 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:27076 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S270008AbUIDAfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 20:35:50 -0400
Date: Fri, 3 Sep 2004 20:40:17 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH][4/8] updated arch agnostic completely out of line locks /
 x86_64
Message-ID: <Pine.LNX.4.58.0409032024120.31136@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/x86_64/kernel/time.c        |   13 +++++++++++++
 arch/x86_64/kernel/vmlinux.lds.S |    1 +
 include/asm-x86_64/ptrace.h      |    4 ++++
 3 files changed, 18 insertions(+)

Status: Tested
Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.9-rc1-bk9-sparc64/arch/x86_64/kernel/time.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/arch/x86_64/kernel/time.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 time.c
--- linux-2.6.9-rc1-bk9-sparc64/arch/x86_64/kernel/time.c	3 Sep 2004 01:30:26 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/arch/x86_64/kernel/time.c	3 Sep 2004 23:55:27 -0000
@@ -179,6 +179,19 @@ int do_settimeofday(struct timespec *tv)

 EXPORT_SYMBOL(do_settimeofday);

+#if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
+unsigned long profile_pc(struct pt_regs *regs)
+{
+	unsigned long pc = instruction_pointer(regs);
+
+	if (pc >= (unsigned long)&__lock_text_start &&
+	    pc <= (unsigned long)&__lock_text_end)
+		return *(unsigned long *)regs->rbp;
+	return pc;
+}
+EXPORT_SYMBOL(profile_pc);
+#endif
+
 /*
  * In order to set the CMOS clock precisely, set_rtc_mmss has to be called 500
  * ms after the second nowtime has started, because when nowtime is written
Index: linux-2.6.9-rc1-bk9-sparc64/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/arch/x86_64/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-bk9-sparc64/arch/x86_64/kernel/vmlinux.lds.S	3 Sep 2004 01:30:26 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/arch/x86_64/kernel/vmlinux.lds.S	3 Sep 2004 23:55:27 -0000
@@ -16,6 +16,7 @@ SECTIONS
   .text : {
 	*(.text)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
Index: linux-2.6.9-rc1-bk9-sparc64/include/asm-x86_64/ptrace.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/include/asm-x86_64/ptrace.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 ptrace.h
--- linux-2.6.9-rc1-bk9-sparc64/include/asm-x86_64/ptrace.h	3 Sep 2004 01:30:43 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/include/asm-x86_64/ptrace.h	3 Sep 2004 23:55:27 -0000
@@ -83,7 +83,11 @@ struct pt_regs {
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 #define user_mode(regs) (!!((regs)->cs & 3))
 #define instruction_pointer(regs) ((regs)->rip)
+#if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
+extern unsigned long profile_pc(struct pt_regs *regs);
+#else
 #define profile_pc(regs) instruction_pointer(regs)
+#endif
 void signal_fault(struct pt_regs *regs, void __user *frame, char *where);

 enum {
