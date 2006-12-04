Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759860AbWLDFSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759860AbWLDFSd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 00:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759861AbWLDFSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 00:18:33 -0500
Received: from fms-01.valinux.co.jp ([210.128.90.1]:37584 "EHLO
	mail.valinux.co.jp") by vger.kernel.org with ESMTP id S1759858AbWLDFSc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 00:18:32 -0500
From: Magnus Damm <magnus@valinux.co.jp>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, fastboot@lists.osdl.org,
       magnus.damm@gmail.com, Magnus Damm <magnus@valinux.co.jp>,
       ebiederm@xmission.com, Andrew Morton <akpm@osdl.org>
Date: Mon, 04 Dec 2006 14:18:19 +0900
Message-Id: <20061204051819.25549.6746.sendpatchset@localhost>
Subject: [PATCH] Kexec / Kdump: Unify elf note code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Kexec / Kdump: Unify elf note code

The elf note saving code is currently duplicated over several architectures. 
This cleanup patch simply adds code to a common file and then replaces 
the arch-specific code with calls to the newly added code.

The only drawback with this approach is that s390 doesn't fully support 
kexec-on-panic which for that arch leads to introduction of unused code.

Signed-Off-By: Magnus Damm <magnus@valinux.co.jp>
---

 Applies on top of linux-2.6.19.
 Builds on i386 and x86_64.

 arch/i386/kernel/crash.c    |   66 +----------------------------------------
 arch/powerpc/kernel/crash.c |   59 +-----------------------------------
 arch/x86_64/kernel/crash.c  |   69 +------------------------------------------
 include/linux/kexec.h       |    1
 kernel/kexec.c              |   56 ++++++++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 188 deletions(-)

--- 0001/arch/i386/kernel/crash.c
+++ work/arch/i386/kernel/crash.c	2006-12-04 11:40:16.000000000 +0900
@@ -31,68 +31,6 @@
 /* This keeps a track of which one is crashing cpu. */
 static int crashing_cpu;
 
-static u32 *append_elf_note(u32 *buf, char *name, unsigned type, void *data,
-							       size_t data_len)
-{
-	struct elf_note note;
-
-	note.n_namesz = strlen(name) + 1;
-	note.n_descsz = data_len;
-	note.n_type   = type;
-	memcpy(buf, &note, sizeof(note));
-	buf += (sizeof(note) +3)/4;
-	memcpy(buf, name, note.n_namesz);
-	buf += (note.n_namesz + 3)/4;
-	memcpy(buf, data, note.n_descsz);
-	buf += (note.n_descsz + 3)/4;
-
-	return buf;
-}
-
-static void final_note(u32 *buf)
-{
-	struct elf_note note;
-
-	note.n_namesz = 0;
-	note.n_descsz = 0;
-	note.n_type   = 0;
-	memcpy(buf, &note, sizeof(note));
-}
-
-static void crash_save_this_cpu(struct pt_regs *regs, int cpu)
-{
-	struct elf_prstatus prstatus;
-	u32 *buf;
-
-	if ((cpu < 0) || (cpu >= NR_CPUS))
-		return;
-
-	/* Using ELF notes here is opportunistic.
-	 * I need a well defined structure format
-	 * for the data I pass, and I need tags
-	 * on the data to indicate what information I have
-	 * squirrelled away.  ELF notes happen to provide
-	 * all of that, so there is no need to invent something new.
-	 */
-	buf = (u32*)per_cpu_ptr(crash_notes, cpu);
-	if (!buf)
-		return;
-	memset(&prstatus, 0, sizeof(prstatus));
-	prstatus.pr_pid = current->pid;
-	elf_core_copy_regs(&prstatus.pr_reg, regs);
-	buf = append_elf_note(buf, "CORE", NT_PRSTATUS, &prstatus,
-				sizeof(prstatus));
-	final_note(buf);
-}
-
-static void crash_save_self(struct pt_regs *regs)
-{
-	int cpu;
-
-	cpu = safe_smp_processor_id();
-	crash_save_this_cpu(regs, cpu);
-}
-
 #if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
 static atomic_t waiting_for_crash_ipi;
 
@@ -121,7 +59,7 @@ static int crash_nmi_callback(struct not
 		crash_fixup_ss_esp(&fixed_regs, regs);
 		regs = &fixed_regs;
 	}
-	crash_save_this_cpu(regs, cpu);
+	crash_save_cpu(regs, cpu);
 	disable_local_APIC();
 	atomic_dec(&waiting_for_crash_ipi);
 	/* Assume hlt works */
@@ -195,5 +133,5 @@ void machine_crash_shutdown(struct pt_re
 #if defined(CONFIG_X86_IO_APIC)
 	disable_IO_APIC();
 #endif
-	crash_save_self(regs);
+	crash_save_cpu(regs, safe_smp_processor_id());
 }
--- 0001/arch/powerpc/kernel/crash.c
+++ work/arch/powerpc/kernel/crash.c	2006-12-04 11:43:20.000000000 +0900
@@ -46,61 +46,6 @@ int crashing_cpu = -1;
 static cpumask_t cpus_in_crash = CPU_MASK_NONE;
 cpumask_t cpus_in_sr = CPU_MASK_NONE;
 
-static u32 *append_elf_note(u32 *buf, char *name, unsigned type, void *data,
-							       size_t data_len)
-{
-	struct elf_note note;
-
-	note.n_namesz = strlen(name) + 1;
-	note.n_descsz = data_len;
-	note.n_type   = type;
-	memcpy(buf, &note, sizeof(note));
-	buf += (sizeof(note) +3)/4;
-	memcpy(buf, name, note.n_namesz);
-	buf += (note.n_namesz + 3)/4;
-	memcpy(buf, data, note.n_descsz);
-	buf += (note.n_descsz + 3)/4;
-
-	return buf;
-}
-
-static void final_note(u32 *buf)
-{
-	struct elf_note note;
-
-	note.n_namesz = 0;
-	note.n_descsz = 0;
-	note.n_type   = 0;
-	memcpy(buf, &note, sizeof(note));
-}
-
-static void crash_save_this_cpu(struct pt_regs *regs, int cpu)
-{
-	struct elf_prstatus prstatus;
-	u32 *buf;
-
-	if ((cpu < 0) || (cpu >= NR_CPUS))
-		return;
-
-	/* Using ELF notes here is opportunistic.
-	 * I need a well defined structure format
-	 * for the data I pass, and I need tags
-	 * on the data to indicate what information I have
-	 * squirrelled away.  ELF notes happen to provide
-	 * all of that that no need to invent something new.
-	 */
-	buf = (u32*)per_cpu_ptr(crash_notes, cpu);
-	if (!buf) 
-		return;
-
-	memset(&prstatus, 0, sizeof(prstatus));
-	prstatus.pr_pid = current->pid;
-	elf_core_copy_regs(&prstatus.pr_reg, regs);
-	buf = append_elf_note(buf, "CORE", NT_PRSTATUS, &prstatus,
-			sizeof(prstatus));
-	final_note(buf);
-}
-
 #ifdef CONFIG_SMP
 static atomic_t enter_on_soft_reset = ATOMIC_INIT(0);
 
@@ -113,7 +58,7 @@ void crash_ipi_callback(struct pt_regs *
 
 	local_irq_disable();
 	if (!cpu_isset(cpu, cpus_in_crash))
-		crash_save_this_cpu(regs, cpu);
+		crash_save_cpu(regs, cpu);
 	cpu_set(cpu, cpus_in_crash);
 
 	/*
@@ -306,7 +251,7 @@ void default_machine_crash_shutdown(stru
 	 * such that another IPI will not be sent.
 	 */
 	crashing_cpu = smp_processor_id();
-	crash_save_this_cpu(regs, crashing_cpu);
+	crash_save_cpu(regs, crashing_cpu);
 	crash_kexec_prepare_cpus(crashing_cpu);
 	cpu_set(crashing_cpu, cpus_in_crash);
 	if (ppc_md.kexec_cpu_down)
--- 0001/arch/x86_64/kernel/crash.c
+++ work/arch/x86_64/kernel/crash.c	2006-12-04 11:40:53.000000000 +0900
@@ -28,71 +28,6 @@
 /* This keeps a track of which one is crashing cpu. */
 static int crashing_cpu;
 
-static u32 *append_elf_note(u32 *buf, char *name, unsigned type,
-						void *data, size_t data_len)
-{
-	struct elf_note note;
-
-	note.n_namesz = strlen(name) + 1;
-	note.n_descsz = data_len;
-	note.n_type   = type;
-	memcpy(buf, &note, sizeof(note));
-	buf += (sizeof(note) +3)/4;
-	memcpy(buf, name, note.n_namesz);
-	buf += (note.n_namesz + 3)/4;
-	memcpy(buf, data, note.n_descsz);
-	buf += (note.n_descsz + 3)/4;
-
-	return buf;
-}
-
-static void final_note(u32 *buf)
-{
-	struct elf_note note;
-
-	note.n_namesz = 0;
-	note.n_descsz = 0;
-	note.n_type   = 0;
-	memcpy(buf, &note, sizeof(note));
-}
-
-static void crash_save_this_cpu(struct pt_regs *regs, int cpu)
-{
-	struct elf_prstatus prstatus;
-	u32 *buf;
-
-	if ((cpu < 0) || (cpu >= NR_CPUS))
-		return;
-
-	/* Using ELF notes here is opportunistic.
-	 * I need a well defined structure format
-	 * for the data I pass, and I need tags
-	 * on the data to indicate what information I have
-	 * squirrelled away.  ELF notes happen to provide
-	 * all of that, no need to invent something new.
-	 */
-
-	buf = (u32*)per_cpu_ptr(crash_notes, cpu);
-
-	if (!buf)
-		return;
-
-	memset(&prstatus, 0, sizeof(prstatus));
-	prstatus.pr_pid = current->pid;
-	elf_core_copy_regs(&prstatus.pr_reg, regs);
-	buf = append_elf_note(buf, "CORE", NT_PRSTATUS, &prstatus,
-					sizeof(prstatus));
-	final_note(buf);
-}
-
-static void crash_save_self(struct pt_regs *regs)
-{
-	int cpu;
-
-	cpu = smp_processor_id();
-	crash_save_this_cpu(regs, cpu);
-}
-
 #ifdef CONFIG_SMP
 static atomic_t waiting_for_crash_ipi;
 
@@ -117,7 +52,7 @@ static int crash_nmi_callback(struct not
 		return NOTIFY_STOP;
 	local_irq_disable();
 
-	crash_save_this_cpu(regs, cpu);
+	crash_save_cpu(regs, cpu);
 	disable_local_APIC();
 	atomic_dec(&waiting_for_crash_ipi);
 	/* Assume hlt works */
@@ -196,5 +131,5 @@ void machine_crash_shutdown(struct pt_re
 
 	disable_IO_APIC();
 
-	crash_save_self(regs);
+	crash_save_cpu(regs, smp_processor_id());
 }
--- 0001/include/linux/kexec.h
+++ work/include/linux/kexec.h	2006-12-04 12:04:40.000000000 +0900
@@ -105,6 +105,7 @@ extern struct page *kimage_alloc_control
 						unsigned int order);
 extern void crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
+void crash_save_cpu(struct pt_regs *regs, int cpu);
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
 
--- 0001/kernel/kexec.c
+++ work/kernel/kexec.c	2006-12-04 12:05:28.000000000 +0900
@@ -20,6 +20,8 @@
 #include <linux/syscalls.h>
 #include <linux/ioport.h>
 #include <linux/hardirq.h>
+#include <linux/elf.h>
+#include <linux/elfcore.h>
 
 #include <asm/page.h>
 #include <asm/uaccess.h>
@@ -1067,6 +1069,60 @@ void crash_kexec(struct pt_regs *regs)
 	}
 }
 
+static u32 *append_elf_note(u32 *buf, char *name, unsigned type, void *data,
+			    size_t data_len)
+{
+	struct elf_note note;
+
+	note.n_namesz = strlen(name) + 1;
+	note.n_descsz = data_len;
+	note.n_type   = type;
+	memcpy(buf, &note, sizeof(note));
+	buf += (sizeof(note) + 3)/4;
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
+void crash_save_cpu(struct pt_regs *regs, int cpu)
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
+	 * all of that, so there is no need to invent something new.
+	 */
+	buf = (u32*)per_cpu_ptr(crash_notes, cpu);
+	if (!buf)
+		return;
+	memset(&prstatus, 0, sizeof(prstatus));
+	prstatus.pr_pid = current->pid;
+	elf_core_copy_regs(&prstatus.pr_reg, regs);
+	buf = append_elf_note(buf, "CORE", NT_PRSTATUS, &prstatus,
+				sizeof(prstatus));
+	final_note(buf);
+}
+
 static int __init crash_notes_memory_init(void)
 {
 	/* Allocate memory for saving cpu registers. */
