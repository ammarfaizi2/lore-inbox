Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269401AbUICAMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269401AbUICAMT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 20:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269432AbUICAD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:03:26 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:28404 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S269407AbUIBX6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:58:15 -0400
Date: Thu, 2 Sep 2004 20:02:40 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Anton Blanchard <anton@samba.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Matt Mackall <mpm@selenic.com>
Subject: [PATCH][4/8] Arch agnostic completely out of line locks / ppc32
Message-ID: <Pine.LNX.4.58.0409021227490.4481@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/ppc/kernel/time.c        |   14 ++++++++++++++
 arch/ppc/kernel/vmlinux.lds.S |    1 +
 include/asm-ppc/ptrace.h      |    5 +++++
 3 files changed, 20 insertions(+)

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.9-rc1-mm1-stage/arch/ppc/kernel/time.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/ppc/kernel/time.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 time.c
--- linux-2.6.9-rc1-mm1-stage/arch/ppc/kernel/time.c	26 Aug 2004 13:12:55 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/ppc/kernel/time.c	2 Sep 2004 13:53:46 -0000
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
Index: linux-2.6.9-rc1-mm1-stage/arch/ppc/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/ppc/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-mm1-stage/arch/ppc/kernel/vmlinux.lds.S	26 Aug 2004 13:12:55 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/ppc/kernel/vmlinux.lds.S	2 Sep 2004 13:08:15 -0000
@@ -32,6 +32,7 @@ SECTIONS
   {
     *(.text)
     SCHED_TEXT
+    LOCK_TEXT
     *(.fixup)
     *(.got1)
     __got2_start = .;
Index: linux-2.6.9-rc1-mm1-stage/include/asm-ppc/ptrace.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/include/asm-ppc/ptrace.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 ptrace.h
--- linux-2.6.9-rc1-mm1-stage/include/asm-ppc/ptrace.h	26 Aug 2004 13:13:12 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/include/asm-ppc/ptrace.h	2 Sep 2004 13:08:16 -0000
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
