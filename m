Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270007AbUIDApI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270007AbUIDApI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 20:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270006AbUIDAoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 20:44:39 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:26308 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S270007AbUIDAfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 20:35:47 -0400
Date: Fri, 3 Sep 2004 20:40:14 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH][5/8] updated arch agnostic completely out of line locks /
 ppc32
Message-ID: <Pine.LNX.4.58.0409032027190.31136@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/ppc/kernel/time.c        |   14 ++++++++++++++
 arch/ppc/kernel/vmlinux.lds.S |    1 +
 include/asm-ppc/ptrace.h      |    5 +++++
 3 files changed, 20 insertions(+)

Status: Untested
Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.9-rc1-bk9-sparc64/arch/ppc/kernel/time.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/arch/ppc/kernel/time.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 time.c
--- linux-2.6.9-rc1-bk9-sparc64/arch/ppc/kernel/time.c	3 Sep 2004 01:30:22 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/arch/ppc/kernel/time.c	3 Sep 2004 23:55:27 -0000
@@ -108,6 +108,20 @@ static inline int tb_delta(unsigned *jif
 	return delta;
 }

+#ifdef CONFIG_SMP
+unsigned long profile_pc(struct pt_regs *regs)
+{
+	unsigned long pc = instruction_pointer(regs);
+
+	if (pc >= (unsigned long)&__lock_text_start &&
+	    pc <= (unsigned long)&__lock_text_end)
+		return regs->link;
+
+	return pc;
+}
+EXPORT_SYMBOL(profile_pc);
+#endif
+
 /*
  * timer_interrupt - gets called when the decrementer overflows,
  * with interrupts disabled.
Index: linux-2.6.9-rc1-bk9-sparc64/arch/ppc/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/arch/ppc/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-bk9-sparc64/arch/ppc/kernel/vmlinux.lds.S	3 Sep 2004 01:30:22 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/arch/ppc/kernel/vmlinux.lds.S	3 Sep 2004 23:55:27 -0000
@@ -32,6 +32,7 @@ SECTIONS
   {
     *(.text)
     SCHED_TEXT
+    LOCK_TEXT
     *(.fixup)
     *(.got1)
     __got2_start = .;
Index: linux-2.6.9-rc1-bk9-sparc64/include/asm-ppc/ptrace.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/include/asm-ppc/ptrace.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 ptrace.h
--- linux-2.6.9-rc1-bk9-sparc64/include/asm-ppc/ptrace.h	3 Sep 2004 01:30:42 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/include/asm-ppc/ptrace.h	3 Sep 2004 23:55:27 -0000
@@ -47,7 +47,12 @@ struct pt_regs {

 #ifndef __ASSEMBLY__
 #define instruction_pointer(regs) ((regs)->nip)
+#ifdef CONFIG_SMP
+extern unsigned long profile_pc(struct pt_regs *regs);
+#else
 #define profile_pc(regs) instruction_pointer(regs)
+#endif
+
 #define user_mode(regs) (((regs)->msr & MSR_PR) != 0)

 #define force_successful_syscall_return()   \
