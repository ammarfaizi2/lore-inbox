Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVASHyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVASHyz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 02:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVASHyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 02:54:35 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51903 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261627AbVASHdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:21 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 23/29] x86-crash_shutdown-snapshot-registers
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <x86-crash-shutdown-snapshot-registers-11061198972173@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <x86-crash-shutdown-nmi-shootdown-11061198973234@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<x86-rename-apic-mode-exint-11061198973109@ebiederm.dsl.xmission.com>
	<x86-local-apic-fix-11061198972413@ebiederm.dsl.xmission.com>
	<x86-64-e820-64bit-11061198971581@ebiederm.dsl.xmission.com>
	<x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<x86-64-i8259-shutdown-11061198973969@ebiederm.dsl.xmission.com>
	<x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
	<x86-64-apic-virtwire-on-shutdown-11061198973345@ebiederm.dsl.xmission.com>
	<vmlinux-fix-physical-addrs-11061198973860@ebiederm.dsl.xmission.com>
	<x86-vmlinux-fix-physical-addrs-11061198971192@ebiederm.dsl.xmission.com>
	<x86-64-vmlinux-fix-physical-addrs-11061198972723@ebiederm.dsl.xmission.com>
	<x86-64-entry64-1106119897218@ebiederm.dsl.xmission.com>
	<x86-config-kernel-start-1106119897152@ebiederm.dsl.xmission.com>
	<x86-64-config-kernel-start-11061198972987@ebiederm.dsl.xmission.com>
	<kexec-kexec-generic-11061198974111@ebiederm.dsl.xmission.com>
	<x86-machine-shutdown-1106119897775@ebiederm.dsl.xmission.com>
	<x86-kexec-11061198971773@ebiederm.dsl.xmission.com>
	<x86-crashkernel-1106119897532@ebiederm.dsl.xmission.com>
	<x86-64-machine-shutdown-11061198972282@ebiederm.dsl.xmission.com>
	<x86-64-kexec-11061198973999@ebiederm.dsl.xmission.com>
	<x86-64-crashkernel-11061198971876@ebiederm.dsl.xmission.com>
	<kexec-ppc-support-11061198973302@ebiederm.dsl.xmission.com>
	<x86-crash-shutdown-nmi-shootdown-11061198973234@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After the kernel panics if we wish to generate an entire machine core
file it is very nice to know the register state at the time the
machine crashed.

After long discussion it was realized that if you are going to be
saving the information anyway it is reasonable to store the
information in a format that it will be used and recognized in
so the register state is stored in the standard ELF note format.

Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 crash.c |   80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 80 insertions(+)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86-crash_shutdown-nmi-shootdown/arch/i386/kernel/crash.c linux-2.6.11-rc1-mm1-nokexec-x86-crash_shutdown-snapshot-registers/arch/i386/kernel/crash.c
--- linux-2.6.11-rc1-mm1-nokexec-x86-crash_shutdown-nmi-shootdown/arch/i386/kernel/crash.c	Tue Jan 18 23:15:17 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86-crash_shutdown-snapshot-registers/arch/i386/kernel/crash.c	Tue Jan 18 23:15:34 2005
@@ -30,12 +30,91 @@
 
 note_buf_t crash_notes[NR_CPUS];
 
+static u32 *append_elf_note(u32 *buf,
+	char *name, unsigned type, void *data, size_t data_len)
+{
+	struct elf_note note;
+	note.n_namesz = strlen(name) + 1;
+	note.n_descsz = data_len;
+	note.n_type   = type;
+	memcpy(buf, &note, sizeof(note));
+	buf += (sizeof(note) +3)/4;
+	memcpy(buf, name, note.n_namesz);
+	buf += (note.n_namesz + 3)/4;
+	memcpy(buf, data, note.n_descsz);
+	buf += (note.n_descsz + 3)/4;
+	return buf;
+}
+
+static void final_note(u32 *buf)
+{
+	struct elf_note note;
+	note.n_namesz = 0;
+	note.n_descsz = 0;
+	note.n_type   = 0;
+	memcpy(buf, &note, sizeof(note));
+}
+
+
+static void crash_save_this_cpu(struct pt_regs *regs, int cpu)
+{
+	struct elf_prstatus prstatus;
+	u32 *buf;
+	if ((cpu < 0) || (cpu >= NR_CPUS)) {
+		return;
+	}
+	/* Using ELF notes here is opportunistic.
+	 * I need a well defined structure format
+	 * for the data I pass, and I need tags
+	 * on the data to indicate what information I have 
+	 * squirrelled away.  ELF notes happen to provide
+	 * all of that that no need to invent something new.
+	 */
+	buf = &crash_notes[cpu][0];
+	memset(&prstatus, 0, sizeof(prstatus));
+	prstatus.pr_pid = current->pid;
+	elf_core_copy_regs(&prstatus.pr_reg, regs);
+	buf = append_elf_note(buf, "CORE", NT_PRSTATUS,
+		&prstatus, sizeof(prstatus));
+
+	final_note(buf);
+}
+
+static void crash_get_current_regs(struct pt_regs *regs)
+{
+	__asm__ __volatile__("movl %%ebx,%0" : "=m"(regs->ebx));
+	__asm__ __volatile__("movl %%ecx,%0" : "=m"(regs->ecx));
+	__asm__ __volatile__("movl %%edx,%0" : "=m"(regs->edx));
+	__asm__ __volatile__("movl %%esi,%0" : "=m"(regs->esi));
+	__asm__ __volatile__("movl %%edi,%0" : "=m"(regs->edi));
+	__asm__ __volatile__("movl %%ebp,%0" : "=m"(regs->ebp));
+	__asm__ __volatile__("movl %%eax,%0" : "=m"(regs->eax));
+	__asm__ __volatile__("movl %%esp,%0" : "=m"(regs->esp));
+	__asm__ __volatile__("movw %%ss, %%ax;" :"=a"(regs->xss));
+	__asm__ __volatile__("movw %%cs, %%ax;" :"=a"(regs->xcs));
+	__asm__ __volatile__("movw %%ds, %%ax;" :"=a"(regs->xds));
+	__asm__ __volatile__("movw %%es, %%ax;" :"=a"(regs->xes));
+	__asm__ __volatile__("pushfl; popl %0" :"=m"(regs->eflags));
+
+	regs->eip = (unsigned long)current_text_addr();
+}
+
+static void crash_save_self(void)
+{
+	struct pt_regs regs;
+	int cpu;
+	cpu = smp_processor_id();
+	crash_get_current_regs(&regs);
+	crash_save_this_cpu(&regs, cpu);
+}
+
 #ifdef CONFIG_SMP
 static atomic_t waiting_for_crash_ipi;
 
 static int crash_nmi_callback(struct pt_regs *regs, int cpu)
 {
 	local_irq_disable();
+	crash_save_this_cpu(regs, cpu);
 	atomic_dec(&waiting_for_crash_ipi);
 	/* Assume hlt works */
 	__asm__("hlt");
@@ -95,4 +174,5 @@
 	/* The kernel is broken so disable interrupts */
 	local_irq_disable();
 	nmi_shootdown_cpus();
+	crash_save_self();
 }
