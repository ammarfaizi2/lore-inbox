Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbULOK5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbULOK5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 05:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbULOK5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 05:57:49 -0500
Received: from mail.renesas.com ([202.234.163.13]:13505 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262325AbULOKzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 05:55:39 -0500
Date: Wed, 15 Dec 2004 19:55:28 +0900 (JST)
Message-Id: <20041215.195528.35033694.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ksakamot@linux-m32r.org,
       takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc3-mm1] m32r: Update ptrace.c for multithread
 debugging
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch updates ptrace.c to support multithread debugging.
So far, only one breakpoint's location was kept by kernel, however,
in the multithreaded application's debug, it is required to kept 
multi-point breakpoint locations by kernel.

In this implementation, maximum number of MAX_TRAPS(=10 (by default))
breakpoint's information will be kept in the "debug_trap" member
of the thread_struct for each thread.

	* include/asm-m32r/processor.h: 
	  Modify debug_trap struct to keep multipoint breakpoint locations
	  for multithread debugging.

	* arch/m32r/kernel/ptrace.c:
	- Update to support multithread debugging.
	- Remove unused functions, withdraw_debug_trap_for_signal() and
	  embed_debug_trap_for_signal().

Regards,

Signed-off-by: Kei Sakamoto <ksakamot@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/ptrace.c    |   89 ++++++++++++++-----------------------------
 include/asm-m32r/processor.h |    6 +-
 2 files changed, 34 insertions(+), 61 deletions(-)


diff -ruNp a/include/asm-m32r/processor.h b/include/asm-m32r/processor.h
--- a/include/asm-m32r/processor.h	2004-12-15 18:36:49.000000000 +0900
+++ b/include/asm-m32r/processor.h	2004-12-15 18:37:29.000000000 +0900
@@ -70,10 +70,12 @@ typedef struct {
 	unsigned long seg;
 } mm_segment_t;
 
+#define MAX_TRAPS 10
+
 struct debug_trap {
 	int nr_trap;
-	unsigned long	addr;
-	unsigned long	insn;
+	unsigned long	addr[MAX_TRAPS];
+	unsigned long	insn[MAX_TRAPS];
 };
 
 struct thread_struct {
diff -ruNp a/arch/m32r/kernel/ptrace.c b/arch/m32r/kernel/ptrace.c
--- a/arch/m32r/kernel/ptrace.c	2004-12-15 18:36:49.000000000 +0900
+++ b/arch/m32r/kernel/ptrace.c	2004-12-15 18:37:47.000000000 +0900
@@ -2,7 +2,7 @@
  * linux/arch/m32r/kernel/ptrace.c
  *
  * Copyright (C) 2002  Hirokazu Takata, Takeo Takahashi
- * Copyright (C) 2004  Hirokazu Takata <takata at linux-m32r.org>
+ * Copyright (C) 2004  Hirokazu Takata, Kei Sakamoto
  *
  * Original x86 implementation:
  *	By Ross Biro 1/23/92
@@ -450,13 +450,13 @@ register_debug_trap(struct task_struct *
 	struct debug_trap *p = &child->thread.debug_trap;
 	unsigned long addr = next_pc & ~3;
 
-	if (p->nr_trap != 0) {
+	if (p->nr_trap == MAX_TRAPS) {
 		printk("kernel BUG at %s %d: p->nr_trap = %d\n",
 					__FILE__, __LINE__, p->nr_trap);
 		return -1;
 	}
-	p->addr = addr;
-	p->insn = next_insn;
+	p->addr[p->nr_trap] = addr;
+	p->insn[p->nr_trap] = next_insn;
 	p->nr_trap++;
 	if (next_pc & 3) {
 		*code = (next_insn & 0xffff0000) | 0x10f1;
@@ -473,35 +473,34 @@ register_debug_trap(struct task_struct *
 	return 0;
 }
 
-int withdraw_debug_trap_for_signal(struct task_struct *child)
-{
-	struct debug_trap *p = &child->thread.debug_trap;
-	int nr_trap = p->nr_trap;
-
-	if (nr_trap) {
-		access_process_vm(child, p->addr, &p->insn, sizeof(p->insn), 1);
-		p->nr_trap = 0;
-		p->addr = 0;
-		p->insn = 0;
-	}
-	return nr_trap;
-}
-
 static int
 unregister_debug_trap(struct task_struct *child, unsigned long addr,
 		      unsigned long *code)
 {
 	struct debug_trap *p = &child->thread.debug_trap;
+        int i;
 
-	if (p->nr_trap != 1 || p->addr != addr) {
+	/* Search debug trap entry. */
+	for (i = 0; i < p->nr_trap; i++) {
+		if (p->addr[i] == addr)
+			break;
+	}
+	if (i >= p->nr_trap) {
 		/* The trap may be requested from debugger.
 		 * ptrace should do nothing in this case.
 		 */
 		return 0;
 	}
-	*code = p->insn;
-	p->insn = 0;
-	p->addr = 0;
+
+	/* Recover orignal instruction code. */
+	*code = p->insn[i];
+
+	/* Shift debug trap entries. */
+	while (i < p->nr_trap - 1) {
+		p->insn[i] = p->insn[i + 1];
+		p->addr[i] = p->addr[i + 1];
+		i++;
+	}
 	p->nr_trap--;
 	return 1;
 }
@@ -510,13 +509,11 @@ static void
 unregister_all_debug_traps(struct task_struct *child)
 {
 	struct debug_trap *p = &child->thread.debug_trap;
+	int i;
 
-	if (p->nr_trap) {
-		access_process_vm(child, p->addr, &p->insn, sizeof(p->insn), 1);
-		p->addr = 0;
-		p->insn = 0;
-		p->nr_trap = 0;
-	}
+	for (i = 0; i < p->nr_trap; i++)
+		access_process_vm(child, p->addr[i], &p->insn[i], sizeof(p->insn[i]), 1);
+	p->nr_trap = 0;
 }
 
 static inline void
@@ -576,34 +573,6 @@ embed_debug_trap(struct task_struct *chi
 }
 
 void
-embed_debug_trap_for_signal(struct task_struct *child)
-{
-	unsigned long next_pc;
-	unsigned long pc, insn;
-	int ret;
-
-	pc = get_stack_long(child, PT_BPC);
-	ret = access_process_vm(child, pc&~3, &insn, sizeof(insn), 0);
-	if (ret != sizeof(insn)) {
-		printk("kernel BUG at %s %d: access_process_vm returns %d\n",
-		       __FILE__, __LINE__, ret);
-		return;
-	}
-	compute_next_pc(insn, pc, &next_pc, child);
-	if (next_pc & 0x80000000) {
-		printk("kernel BUG at %s %d: next_pc = 0x%08x\n",
-		       __FILE__, __LINE__, (int)next_pc);
-		return;
-	}
-	if (embed_debug_trap(child, next_pc)) {
-		printk("kernel BUG at %s %d: embed_debug_trap error\n",
-		       __FILE__, __LINE__);
-		return;
-	}
-	invalidate_cache();
-}
-
-void
 withdraw_debug_trap(struct pt_regs *regs)
 {
 	unsigned long addr;
@@ -621,9 +590,12 @@ static void
 init_debug_traps(struct task_struct *child)
 {
 	struct debug_trap *p = &child->thread.debug_trap;
+	int i;
 	p->nr_trap = 0;
-	p->addr = 0;
-	p->insn = 0;
+	for (i = 0; i < MAX_TRAPS; i++) {
+		p->addr[i] = 0;
+		p->insn[i] = 0;
+	}
 }
 
 
@@ -855,4 +827,3 @@ void do_syscall_trace(void)
 		current->exit_code = 0;
 	}
 }
-

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
