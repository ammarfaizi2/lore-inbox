Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269375AbUICAHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269375AbUICAHg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 20:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269404AbUICAGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:06:53 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:35316 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S269403AbUIBX6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:58:39 -0400
Date: Thu, 2 Sep 2004 20:03:02 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Mackall <mpm@selenic.com>,
       William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@suse.de>
Subject: [PATCH][8/8] Arch agnostic completely out of line locks / x86_64
Message-ID: <Pine.LNX.4.58.0409021241291.4481@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/x86_64/kernel/time.c        |   13 +++++++++++++
 arch/x86_64/kernel/vmlinux.lds.S |    1 +
 include/asm-x86_64/ptrace.h      |    4 ++++
 3 files changed, 18 insertions(+)

Andi, i'm not so sure about that return address in profile_pc, i think i
need to read a bit more.

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.9-rc1-mm1-stage/include/asm-x86_64/ptrace.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/include/asm-x86_64/ptrace.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 ptrace.h
--- linux-2.6.9-rc1-mm1-stage/include/asm-x86_64/ptrace.h	26 Aug 2004 13:13:07 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/include/asm-x86_64/ptrace.h	2 Sep 2004 23:24:05 -0000
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
Index: linux-2.6.9-rc1-mm1-stage/arch/x86_64/kernel/time.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/x86_64/kernel/time.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 time.c
--- linux-2.6.9-rc1-mm1-stage/arch/x86_64/kernel/time.c	26 Aug 2004 13:13:06 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/x86_64/kernel/time.c	2 Sep 2004 23:58:08 -0000
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
Index: linux-2.6.9-rc1-mm1-stage/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/x86_64/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-mm1-stage/arch/x86_64/kernel/vmlinux.lds.S	26 Aug 2004 13:13:06 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/x86_64/kernel/vmlinux.lds.S	2 Sep 2004 13:08:15 -0000
@@ -16,6 +16,7 @@ SECTIONS
   .text : {
 	*(.text)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
