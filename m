Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVKQN24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVKQN24 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVKQN24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:28:56 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:6355 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750802AbVKQN24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:28:56 -0500
Date: Thu, 17 Nov 2005 18:58:50 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: ak@suse.de, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 8/10] kdump: x86_64 save cpu registers upon crash
Message-ID: <20051117132850.GL3981@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20051117131339.GD3981@in.ibm.com> <20051117131825.GE3981@in.ibm.com> <20051117132004.GF3981@in.ibm.com> <20051117132138.GG3981@in.ibm.com> <20051117132315.GH3981@in.ibm.com> <20051117132437.GI3981@in.ibm.com> <20051117132557.GJ3981@in.ibm.com> <20051117132659.GK3981@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117132659.GK3981@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Saving the cpu registers of all cpus before booting in to the crash kernel.

o crash_setup_regs will save the registers of the cpu on which
  panic has occured. One of the concerns ppc64 folks raised is that after
  capturing the register states, one should not pop the current call frame
  and push new one. Hence it has been inlined. More call frames later get
  pushed on to stack (machine_crash_shutdown() and machine_kexec()), but one
  will not want to backtrace those.

o Not very sure about the CFI annotations. With this patch I am
  getting decent backtrace with gdb. Assuming, compiler has generated
  enough debugging information for crash_kexec(). Coding crash_setup_regs()
  in pure assembly makes it tricky because then it can not be inlined and
  we don't want to return back after capturing register states we don't
  want to pop this call frame. 

o Saving the non-panicing cpus registers will be done in the NMI handler 
  while shooting down them in machine_crash_shutdown. 

o Introducing CRASH_DUMP option in Kconfig for x86_64.

Signed-off-by:Murali M Chakravarthy <muralim@in.ibm.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.15-rc1-1M-dynamic-root/arch/x86_64/Kconfig        |    7 +
 linux-2.6.15-rc1-1M-dynamic-root/arch/x86_64/kernel/crash.c |   70 ++++++++++++
 linux-2.6.15-rc1-1M-dynamic-root/include/asm-x86_64/kexec.h |   36 ++++++
 3 files changed, 113 insertions(+)

diff -puN arch/x86_64/Kconfig~x86_64-save-cpu-registers-upon-crash arch/x86_64/Kconfig
--- linux-2.6.15-rc1-1M-dynamic/arch/x86_64/Kconfig~x86_64-save-cpu-registers-upon-crash	2005-11-17 11:57:08.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/arch/x86_64/Kconfig	2005-11-17 11:57:08.000000000 +0530
@@ -402,6 +402,13 @@ config KEXEC
 	  support.  As of this writing the exact hardware interface is
 	  strongly in flux, so no good recommendation can be made.
 
+config CRASH_DUMP
+	bool "kernel crash dumps (EXPERIMENTAL)"
+	depends on EMBEDDED
+	depends on EXPERIMENTAL
+	help
+		Generate crash dump after being started by kexec.
+
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
diff -puN arch/x86_64/kernel/crash.c~x86_64-save-cpu-registers-upon-crash arch/x86_64/kernel/crash.c
--- linux-2.6.15-rc1-1M-dynamic/arch/x86_64/kernel/crash.c~x86_64-save-cpu-registers-upon-crash	2005-11-17 11:57:08.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/arch/x86_64/kernel/crash.c	2005-11-17 11:57:08.000000000 +0530
@@ -11,9 +11,12 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/smp.h>
+#include <linux/irq.h>
 #include <linux/reboot.h>
 #include <linux/kexec.h>
 #include <linux/delay.h>
+#include <linux/elf.h>
+#include <linux/elfcore.h>
 
 #include <asm/processor.h>
 #include <asm/hardirq.h>
@@ -24,6 +27,71 @@
 /* This keeps a track of which one is crashing cpu. */
 static int crashing_cpu;
 
+static u32 *append_elf_note(u32 *buf, char *name, unsigned type,
+						void *data, size_t data_len)
+{
+	struct elf_note note;
+
+	note.n_namesz = strlen(name) + 1;
+	note.n_descsz = data_len;
+	note.n_type   = type;
+	memcpy(buf, &note, sizeof(note));
+	buf += (sizeof(note) +3)/4;
+	memcpy(buf, name, note.n_namesz);
+	buf += (note.n_namesz + 3)/4;
+	memcpy(buf, data, note.n_descsz);
+	buf += (note.n_descsz + 3)/4;
+
+	return buf;
+}
+
+static void final_note(u32 *buf)
+{
+	struct elf_note note;
+
+	note.n_namesz = 0;
+	note.n_descsz = 0;
+	note.n_type   = 0;
+	memcpy(buf, &note, sizeof(note));
+}
+
+static void crash_save_this_cpu(struct pt_regs *regs, int cpu)
+{
+	struct elf_prstatus prstatus;
+	u32 *buf;
+
+	if ((cpu < 0) || (cpu >= NR_CPUS))
+		return;
+
+	/* Using ELF notes here is opportunistic.
+	 * I need a well defined structure format
+	 * for the data I pass, and I need tags
+	 * on the data to indicate what information I have
+	 * squirrelled away.  ELF notes happen to provide
+	 * all of that that no need to invent something new.
+	 */
+
+	buf = (u32*)per_cpu_ptr(crash_notes, cpu);
+
+	if (!buf)
+		return;
+
+	memset(&prstatus, 0, sizeof(prstatus));
+	prstatus.pr_pid = current->pid;
+	elf_core_copy_regs(&prstatus.pr_reg, regs);
+	buf = append_elf_note(buf, "CORE", NT_PRSTATUS, &prstatus,
+					sizeof(prstatus));
+	final_note(buf);
+}
+
+static void crash_save_self(struct pt_regs *regs)
+{
+	int cpu;
+
+	cpu = smp_processor_id();
+	crash_save_this_cpu(regs, cpu);
+}
+
 #ifdef CONFIG_SMP
 static atomic_t waiting_for_crash_ipi;
 
@@ -38,6 +106,7 @@ static int crash_nmi_callback(struct pt_
 		return 1;
 	local_irq_disable();
 
+	crash_save_this_cpu(regs, cpu);
 	disable_local_APIC();
 	atomic_dec(&waiting_for_crash_ipi);
 	/* Assume hlt works */
@@ -113,4 +182,5 @@ void machine_crash_shutdown(struct pt_re
 	disable_IO_APIC();
 #endif
 
+	crash_save_self(regs);
 }
diff -puN include/asm-x86_64/kexec.h~x86_64-save-cpu-registers-upon-crash include/asm-x86_64/kexec.h
--- linux-2.6.15-rc1-1M-dynamic/include/asm-x86_64/kexec.h~x86_64-save-cpu-registers-upon-crash	2005-11-17 11:57:08.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/include/asm-x86_64/kexec.h	2005-11-17 11:57:08.000000000 +0530
@@ -3,6 +3,7 @@
 
 #include <asm/page.h>
 #include <asm/proto.h>
+#include <asm/ptrace.h>
 
 /*
  * KEXEC_SOURCE_MEMORY_LIMIT maximum page get_free_page can return.
@@ -27,4 +28,39 @@
 
 #define MAX_NOTE_BYTES 1024
 
+/*
+ * Saving the registers of the cpu on which panic occured in
+ * crash_kexec to save a valid sp. The registers of other cpus
+ * will be saved in machine_crash_shutdown while shooting down them.
+ */
+
+static inline void crash_setup_regs(struct pt_regs *newregs,
+						struct pt_regs *oldregs)
+{
+	if (oldregs)
+		memcpy(newregs, oldregs, sizeof(*newregs));
+	else {
+		__asm__ __volatile__("movq %%rbx,%0" : "=m"(newregs->rbx));
+		__asm__ __volatile__("movq %%rcx,%0" : "=m"(newregs->rcx));
+		__asm__ __volatile__("movq %%rdx,%0" : "=m"(newregs->rdx));
+		__asm__ __volatile__("movq %%rsi,%0" : "=m"(newregs->rsi));
+		__asm__ __volatile__("movq %%rdi,%0" : "=m"(newregs->rdi));
+		__asm__ __volatile__("movq %%rbp,%0" : "=m"(newregs->rbp));
+		__asm__ __volatile__("movq %%rax,%0" : "=m"(newregs->rax));
+		__asm__ __volatile__("movq %%rsp,%0" : "=m"(newregs->rsp));
+		__asm__ __volatile__("movq %%r8,%0" : "=m"(newregs->r8));
+		__asm__ __volatile__("movq %%r9,%0" : "=m"(newregs->r9));
+		__asm__ __volatile__("movq %%r10,%0" : "=m"(newregs->r10));
+		__asm__ __volatile__("movq %%r11,%0" : "=m"(newregs->r11));
+		__asm__ __volatile__("movq %%r12,%0" : "=m"(newregs->r12));
+		__asm__ __volatile__("movq %%r13,%0" : "=m"(newregs->r13));
+		__asm__ __volatile__("movq %%r14,%0" : "=m"(newregs->r14));
+		__asm__ __volatile__("movq %%r15,%0" : "=m"(newregs->r15));
+		__asm__ __volatile__("movl %%ss, %%eax;" :"=a"(newregs->ss));
+		__asm__ __volatile__("movl %%cs, %%eax;" :"=a"(newregs->cs));
+		__asm__ __volatile__("pushfq; popq %0" :"=m"(newregs->eflags));
+
+		newregs->rip = (unsigned long)current_text_addr();
+	}
+}
 #endif /* _X86_64_KEXEC_H */
_
