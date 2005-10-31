Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbVJaLKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbVJaLKz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 06:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVJaLKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 06:10:55 -0500
Received: from mail4.hitachi.co.jp ([133.145.228.5]:31158 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1751051AbVJaLKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 06:10:54 -0500
Message-ID: <4365FBBA.9030708@sdl.hitachi.co.jp>
Date: Mon, 31 Oct 2005 20:10:50 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Satoshi Oshima <soshima@redhat.com>, Hideo Aoki <haoki@redhat.com>,
       Yumiko Sugita <sugita@sdl.hitachi.co.jp>, noboru.obata.ar@hitachi.com,
       systemtap@sources.redhat.com
Subject: [RFC][PATCH 3/3]Djprobe (Direct Jump Probe) for 2.6.14-rc5-mm1
References: <4365FA24.7030207@sdl.hitachi.co.jp> <4365FB01.2070505@sdl.hitachi.co.jp> <4365FB42.7040502@sdl.hitachi.co.jp>
In-Reply-To: <4365FB42.7040502@sdl.hitachi.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch is the i386 architecture dependent codes of djprobe.
I heard that we need to synchronize caches of each processor if we
execute self modifying on i386.
So, this patch synchronize caches by using CPUID and smp_call_function.

---
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: hiramatu@sdl.hitachi.co.jp

Signed-off-by: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>

 arch/i386/Kconfig               |    8 +
 arch/i386/kernel/Makefile       |    1
 arch/i386/kernel/djprobe.c      |  172 ++++++++++++++++++++++++++++++++++++++++
 arch/i386/kernel/stub_djprobe.S |   77 +++++++++++++++++
 include/asm-i386/djprobe.h      |   56 +++++++++++++
 5 files changed, 314 insertions(+)
diff -Narup linux-2.6.14-rc5-mm1.djp.2/arch/i386/Kconfig linux-2.6.14-rc5-mm1.djp.3/arch/i386/Kconfig
--- linux-2.6.14-rc5-mm1.djp.2/arch/i386/Kconfig	2005-10-25 11:28:49.000000000 +0900
+++ linux-2.6.14-rc5-mm1.djp.3/arch/i386/Kconfig	2005-10-27 11:26:55.000000000 +0900
@@ -1317,6 +1317,14 @@ config KPROBES
 	  a probepoint and specifies the callback.  Kprobes is useful
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
+
+config DJPROBE
+        bool "Direct Jump probe"
+	depends on KPROBES && !PREEMPT
+	help
+	 Djprobe allows you to dynamically hook at any kernel function
+	 entry points and collect the debugging or performance analysis
+	 information non-disruptively.
 endmenu

 source "arch/i386/Kconfig.debug"
diff -Narup linux-2.6.14-rc5-mm1.djp.2/arch/i386/kernel/Makefile linux-2.6.14-rc5-mm1.djp.3/arch/i386/kernel/Makefile
--- linux-2.6.14-rc5-mm1.djp.2/arch/i386/kernel/Makefile	2005-10-25 11:28:49.000000000 +0900
+++ linux-2.6.14-rc5-mm1.djp.3/arch/i386/kernel/Makefile	2005-10-25 14:39:12.000000000 +0900
@@ -29,6 +29,7 @@ obj-$(CONFIG_KEXEC)		+= machine_kexec.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_X86_SUMMIT_NUMA)	+= summit.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
+obj-$(CONFIG_DJPROBE)		+= stub_djprobe.o djprobe.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-y				+= sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
diff -Narup linux-2.6.14-rc5-mm1.djp.2/arch/i386/kernel/djprobe.c linux-2.6.14-rc5-mm1.djp.3/arch/i386/kernel/djprobe.c
--- linux-2.6.14-rc5-mm1.djp.2/arch/i386/kernel/djprobe.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.14-rc5-mm1.djp.3/arch/i386/kernel/djprobe.c	2005-10-28 17:52:29.000000000 +0900
@@ -0,0 +1,172 @@
+/*
+ *  Kernel Direct Jump Probe (Djprobes)
+ *  arch/i386/kernel/djprobe.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) Hitachi, Ltd. 2005
+ *
+ * 2005-Aug	Created by Masami HIRAMATSU <hiramatu@sdl.hitachi.co.jp>
+ * 		Initial implementation of Direct jump probe (djprobe)
+ *              to reduce overhead.
+ */
+
+#include <linux/config.h>
+#include <linux/djprobe.h>
+#include <linux/ptrace.h>
+#include <linux/spinlock.h>
+#include <linux/preempt.h>
+#include <asm/cacheflush.h>
+#include <asm/kdebug.h>
+#include <asm/desc.h>
+#include <asm/processor.h>
+
+
+/*
+ * When kernel full preemption is enabled, we can't ensure that no threads
+ * are executing the modified code. It may be stored in the stack of the
+ * threads. In this case, the djprobe interfaces are emulated by using
+ * kprobe.
+ * When kernel full preemption is disabled, threads are scheduled
+ * from only limited addresses. So it is easy to check whether the
+ * preemption can occur in the modified code.
+ */
+
+/*
+ * On pentium series, Unsynchronized cross-modifying code
+ * operations can cause unexpected instruction execution results.
+ * So after code modified, we should synchronize it on each processor.
+ */
+static void __local_serialize_cpu(void * info)
+{
+	serialize_cpu();
+}
+
+static inline void smp_serialize_cpus(void)
+{
+	on_each_cpu(__local_serialize_cpu, NULL, 1,1);
+}
+
+/* jmp code manipulators */
+struct __arch_jmp_op {
+	char op;
+	long raddr;
+} __attribute__((packed));
+/* insert jmp code */
+static inline void __set_jmp_op(void *from, void *to, int sync)
+{
+	struct __arch_jmp_op *jop;
+	jop = (struct __arch_jmp_op *)from;
+	jop->raddr=(long)(to) - ((long)(from) + 5);
+	mb();
+	if (sync) smp_serialize_cpus();
+	jop->op = RELATIVEJUMP_INSTRUCTION;
+}
+/* switch back to the kprobe */
+static inline void __set_breakpoint_op(void *dest, void *orig)
+{
+	struct __arch_jmp_op *jop = (struct __arch_jmp_op *)dest,
+		*jop2 = (struct __arch_jmp_op *)orig;
+
+	jop->op = BREAKPOINT_INSTRUCTION;
+	jop->raddr = jop2->raddr;
+	mb();
+	smp_serialize_cpus();
+}
+
+/* djprobe call back function: called from stub code */
+static void asmlinkage djprobe_callback(struct djprobe_instance * djpi,
+					struct pt_regs *regs)
+{
+	struct djprobe *djp;
+	rcu_read_lock();
+	list_for_each_entry_rcu(djp, &djpi->plist, plist) {
+		if (djp->handler)
+			djp->handler(djp, regs);
+	}
+	rcu_read_unlock();
+}
+
+/*
+ * Copy post processing instructions
+ * Target instructions MUST be relocatable.
+ */
+int __kprobes arch_prepare_djprobe_instance(struct djprobe_instance *djpi,
+				  unsigned long size)
+{
+	kprobe_opcode_t *stub;
+	stub = djpi->stub.insn;
+	djpi->stub.size = size;
+
+	/* copy arch-dep-instance from template */
+	memcpy((void*)stub, (void*)&arch_tmpl_stub_entry, ARCH_STUB_SIZE);
+
+	/* set probe information */
+	*((long*)(stub + ARCH_STUB_VAL_IDX)) = (long)djpi;
+	/* set probe function */
+	*((long*)(stub + ARCH_STUB_CALL_IDX)) = (long)djprobe_callback;
+
+	/* copy instructions into the middle of djporbe instance */
+	memcpy((void*)(stub + ARCH_STUB_INST_IDX),
+	       (void*)djpi->kp.addr, size);
+
+	/* set returning jmp instruction at the tail of djporbe instance*/
+	__set_jmp_op(stub + ARCH_STUB_INST_IDX + size,
+		     (void*)((long)djpi->kp.addr + size), 0);
+
+	return 0;
+}
+
+/* Insert "jmp" instruction into the probing point. */
+void __kprobes arch_install_djprobe_instance(struct djprobe_instance *djpi)
+{
+	__set_jmp_op((void*)djpi->kp.addr, (void*)djpi->stub.insn, 1);
+}
+
+/* Write back original instructions & kprobe */
+void __kprobes arch_uninstall_djprobe_instance(struct djprobe_instance *djpi)
+{
+	kprobe_opcode_t *stub;
+	stub = &djpi->stub.insn[ARCH_STUB_INST_IDX];
+	__set_breakpoint_op((void*)djpi->kp.addr, (void*)stub);
+}
+
+static DEFINE_SPINLOCK(djprobe_handler_lock);
+
+/* djprobe handler : switch to a bypass code */
+int __kprobes djprobe_pre_handler(struct kprobe * kp, struct pt_regs * regs)
+{
+	struct djprobe_instance *djpi =
+		container_of(kp,struct djprobe_instance, kp);
+	kprobe_opcode_t *stub = djpi->stub.insn;
+
+	spin_lock(&djprobe_handler_lock);
+	if (DJPI_EMPTY(djpi)) {
+		kp->ainsn.insn[0] = kp->opcode;
+		return 0;
+	} else {
+		regs->eip = (unsigned long)stub;
+		regs->eflags |= TF_MASK;
+		regs->eflags &= ~IF_MASK;
+		kp->ainsn.insn[0] = RETURN_INSTRUCTION;
+		return 1; /* already prepared */
+	}
+}
+
+void __kprobes djprobe_post_handler(struct kprobe * kp, struct pt_regs * regs,
+				    unsigned long flags)
+{
+	spin_unlock(&djprobe_handler_lock);
+}
diff -Narup linux-2.6.14-rc5-mm1.djp.2/arch/i386/kernel/stub_djprobe.S linux-2.6.14-rc5-mm1.djp.3/arch/i386/kernel/stub_djprobe.S
--- linux-2.6.14-rc5-mm1.djp.2/arch/i386/kernel/stub_djprobe.S	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.14-rc5-mm1.djp.3/arch/i386/kernel/stub_djprobe.S	2005-10-25 14:39:12.000000000 +0900
@@ -0,0 +1,77 @@
+/*
+ *  linux/arch/i386/stub_djprobe.S
+ *
+ *  Copyright (C) HITACHI,LTD. 2005
+ *  Created by Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
+ */
+
+#include <linux/config.h>
+
+# jmp into this function from other functions.
+.global arch_tmpl_stub_entry
+arch_tmpl_stub_entry:
+	nop
+	subl $8, %esp	#skip segment registers.
+	pushf
+	subl $20, %esp	#skip segment registers.
+	pushl %eax
+	pushl %ebp
+	pushl %edi
+	pushl %esi
+	pushl %edx
+	pushl %ecx
+	pushl %ebx
+
+	movl %esp, %eax
+	pushl %eax
+	addl $60, %eax
+	movl %eax, 56(%esp)
+.global arch_tmpl_stub_val
+arch_tmpl_stub_val:
+	movl $0xffffffff, %eax
+	pushl %eax
+.global arch_tmpl_stub_call
+arch_tmpl_stub_call:
+	movl $0xffffffff, %eax
+	call *%eax
+	addl $8, %esp
+
+	popl %ebx
+	popl %ecx
+	popl %edx
+	popl %esi
+	popl %edi
+	popl %ebp
+	popl %eax
+	addl $20, %esp
+	popf
+	addl $8, %esp
+.global arch_tmpl_stub_inst
+arch_tmpl_stub_inst:
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+.global arch_tmpl_stub_end
+arch_tmpl_stub_end:
diff -Narup linux-2.6.14-rc5-mm1.djp.2/include/asm-i386/djprobe.h linux-2.6.14-rc5-mm1.djp.3/include/asm-i386/djprobe.h
--- linux-2.6.14-rc5-mm1.djp.2/include/asm-i386/djprobe.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.14-rc5-mm1.djp.3/include/asm-i386/djprobe.h	2005-10-25 14:39:12.000000000 +0900
@@ -0,0 +1,56 @@
+#ifndef _ASM_DJPROBE_H
+#define _ASM_DJPROBE_H
+/*
+ *  Kernel Direct Jump Probe (Djprobe)
+ *  include/asm-i386/djprobe.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) Hitachi, Ltd. 2005
+ *
+ * 2005-Aug	Created by Masami HIRAMATSU <hiramatu@sdl.hitachi.co.jp>
+ * 		Initial implementation of Direct jump probe (djprobe)
+ *              to reduce overhead.
+ */
+
+#define RELATIVEJUMP_INSTRUCTION 0xe9
+#define RETURN_INSTRUCTION 0xc3
+
+#ifndef CONFIG_PREEMPT
+#define ARCH_SUPPORTS_DJPROBES
+#endif				/* CONFIG_PREEMPT */
+
+/* stub template code */
+extern kprobe_opcode_t arch_tmpl_stub_entry;
+extern kprobe_opcode_t arch_tmpl_stub_val;
+extern kprobe_opcode_t arch_tmpl_stub_call;
+extern kprobe_opcode_t arch_tmpl_stub_inst;
+extern kprobe_opcode_t arch_tmpl_stub_end;
+
+#define ARCH_STUB_VAL_IDX ((long)&arch_tmpl_stub_val - (long)&arch_tmpl_stub_entry + 1)
+#define ARCH_STUB_CALL_IDX ((long)&arch_tmpl_stub_call - (long)&arch_tmpl_stub_entry + 1)
+#define ARCH_STUB_INST_IDX ((long)&arch_tmpl_stub_inst - (long)&arch_tmpl_stub_entry)
+#define ARCH_STUB_SIZE ((long)&arch_tmpl_stub_end - (long)&arch_tmpl_stub_entry)
+
+#define ARCH_STUB_INSN_MAX 20
+#define ARCH_STUB_INSN_MIN 5
+
+struct arch_djprobe_stub {
+	kprobe_opcode_t *insn;
+	int size;
+};
+#define DJPI_ARCH_SIZE(djpi) (djpi->stub.size)
+
+#endif				/* _ASM_DJPROBE_H */


