Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbVKQNUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVKQNUM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVKQNUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:20:12 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:18154 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750808AbVKQNUK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:20:10 -0500
Date: Thu, 17 Nov 2005 18:50:04 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: ak@suse.de, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 2/10] kdump: dynamic per cpu allocation of memory for saving cpu registers
Message-ID: <20051117132004.GF3981@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20051117131339.GD3981@in.ibm.com> <20051117131825.GE3981@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117131825.GE3981@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o In case of system crash, current state of cpu registers is saved in memory
  in elf note format. So far memory for storing elf notes was being allocated
  statically for NR_CPUS.

o This patch introduces dynamic allocation of memory for storing elf notes.
  It uses alloc_percpu() interface. This should lead to better memory usage.

o Introduced based on Andi Kleen's and Eric W. Biederman's suggestions.

o This patch also moves memory allocation for elf notes from architecture
  dependent portion to architecture independent portion. Now crash_notes
  is architecture independent. The whole idea is that size of memory to be
  allocated per cpu (MAX_NOTE_BYTES) can be architecture dependent and
  allocation of this memory can be architecture independent. 

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.15-rc1-1M-dynamic-root/arch/i386/kernel/crash.c          |    5 +--
 linux-2.6.15-rc1-1M-dynamic-root/arch/ppc/kernel/machine_kexec.c   |    6 ---
 linux-2.6.15-rc1-1M-dynamic-root/arch/ppc64/kernel/machine_kexec.c |    3 -
 linux-2.6.15-rc1-1M-dynamic-root/arch/s390/kernel/crash.c          |    2 -
 linux-2.6.15-rc1-1M-dynamic-root/arch/x86_64/kernel/crash.c        |    2 -
 linux-2.6.15-rc1-1M-dynamic-root/include/asm-i386/kexec.h          |    3 -
 linux-2.6.15-rc1-1M-dynamic-root/include/asm-powerpc/kexec.h       |    3 -
 linux-2.6.15-rc1-1M-dynamic-root/include/asm-s390/kexec.h          |    3 -
 linux-2.6.15-rc1-1M-dynamic-root/include/asm-x86_64/kexec.h        |    3 -
 linux-2.6.15-rc1-1M-dynamic-root/include/linux/kexec.h             |    2 +
 linux-2.6.15-rc1-1M-dynamic-root/kernel/kexec.c                    |   16 ++++++++++
 11 files changed, 21 insertions(+), 27 deletions(-)

diff -puN arch/i386/kernel/crash.c~kdump-dynamic-per-cpu-elf-note-memory-alloc arch/i386/kernel/crash.c
--- linux-2.6.15-rc1-1M-dynamic/arch/i386/kernel/crash.c~kdump-dynamic-per-cpu-elf-note-memory-alloc	2005-11-15 14:09:51.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/arch/i386/kernel/crash.c	2005-11-15 14:09:52.000000000 +0530
@@ -25,7 +25,6 @@
 #include <mach_ipi.h>
 
 
-note_buf_t crash_notes[NR_CPUS];
 /* This keeps a track of which one is crashing cpu. */
 static int crashing_cpu;
 
@@ -72,7 +71,9 @@ static void crash_save_this_cpu(struct p
 	 * squirrelled away.  ELF notes happen to provide
 	 * all of that that no need to invent something new.
 	 */
-	buf = &crash_notes[cpu][0];
+	buf = (u32*)per_cpu_ptr(crash_notes, cpu);
+	if (!buf)
+		return;
 	memset(&prstatus, 0, sizeof(prstatus));
 	prstatus.pr_pid = current->pid;
 	elf_core_copy_regs(&prstatus.pr_reg, regs);
diff -puN arch/ppc64/kernel/machine_kexec.c~kdump-dynamic-per-cpu-elf-note-memory-alloc arch/ppc64/kernel/machine_kexec.c
--- linux-2.6.15-rc1-1M-dynamic/arch/ppc64/kernel/machine_kexec.c~kdump-dynamic-per-cpu-elf-note-memory-alloc	2005-11-15 14:09:51.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/arch/ppc64/kernel/machine_kexec.c	2005-11-15 14:09:52.000000000 +0530
@@ -28,9 +28,6 @@
 
 #define HASH_GROUP_SIZE 0x80	/* size of each hash group, asm/mmu.h */
 
-/* Have this around till we move it into crash specific file */
-note_buf_t crash_notes[NR_CPUS];
-
 /* Dummy for now. Not sure if we need to have a crash shutdown in here
  * and if what it will achieve. Letting it be now to compile the code
  * in generic kexec environment
diff -puN arch/ppc/kernel/machine_kexec.c~kdump-dynamic-per-cpu-elf-note-memory-alloc arch/ppc/kernel/machine_kexec.c
--- linux-2.6.15-rc1-1M-dynamic/arch/ppc/kernel/machine_kexec.c~kdump-dynamic-per-cpu-elf-note-memory-alloc	2005-11-15 14:09:51.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/arch/ppc/kernel/machine_kexec.c	2005-11-15 14:09:52.000000000 +0530
@@ -28,12 +28,6 @@ typedef NORET_TYPE void (*relocate_new_k
 const extern unsigned char relocate_new_kernel[];
 const extern unsigned int relocate_new_kernel_size;
 
-/*
- * Provide a dummy crash_notes definition while crash dump arrives to ppc.
- * This prevents breakage of crash_notes attribute in kernel/ksysfs.c.
- */
-note_buf_t crash_notes[NR_CPUS];
-
 void machine_shutdown(void)
 {
 	if (ppc_md.machine_shutdown)
diff -puN arch/s390/kernel/crash.c~kdump-dynamic-per-cpu-elf-note-memory-alloc arch/s390/kernel/crash.c
--- linux-2.6.15-rc1-1M-dynamic/arch/s390/kernel/crash.c~kdump-dynamic-per-cpu-elf-note-memory-alloc	2005-11-15 14:09:51.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/arch/s390/kernel/crash.c	2005-11-15 14:09:52.000000000 +0530
@@ -10,8 +10,6 @@
 #include <linux/threads.h>
 #include <linux/kexec.h>
 
-note_buf_t crash_notes[NR_CPUS];
-
 void machine_crash_shutdown(struct pt_regs *regs)
 {
 }
diff -puN arch/x86_64/kernel/crash.c~kdump-dynamic-per-cpu-elf-note-memory-alloc arch/x86_64/kernel/crash.c
--- linux-2.6.15-rc1-1M-dynamic/arch/x86_64/kernel/crash.c~kdump-dynamic-per-cpu-elf-note-memory-alloc	2005-11-15 14:09:51.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/arch/x86_64/kernel/crash.c	2005-11-15 14:09:52.000000000 +0530
@@ -19,8 +19,6 @@
 #include <asm/nmi.h>
 #include <asm/hw_irq.h>
 
-note_buf_t crash_notes[NR_CPUS];
-
 void machine_crash_shutdown(struct pt_regs *regs)
 {
 	/* This function is only called after the system
diff -puN include/asm-i386/kexec.h~kdump-dynamic-per-cpu-elf-note-memory-alloc include/asm-i386/kexec.h
--- linux-2.6.15-rc1-1M-dynamic/include/asm-i386/kexec.h~kdump-dynamic-per-cpu-elf-note-memory-alloc	2005-11-15 14:09:51.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/include/asm-i386/kexec.h	2005-11-15 14:09:52.000000000 +0530
@@ -26,8 +26,5 @@
 #define KEXEC_ARCH KEXEC_ARCH_386
 
 #define MAX_NOTE_BYTES 1024
-typedef u32 note_buf_t[MAX_NOTE_BYTES/4];
-
-extern note_buf_t crash_notes[];
 
 #endif /* _I386_KEXEC_H */
diff -puN include/asm-powerpc/kexec.h~kdump-dynamic-per-cpu-elf-note-memory-alloc include/asm-powerpc/kexec.h
--- linux-2.6.15-rc1-1M-dynamic/include/asm-powerpc/kexec.h~kdump-dynamic-per-cpu-elf-note-memory-alloc	2005-11-15 14:09:51.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/include/asm-powerpc/kexec.h	2005-11-15 14:09:52.000000000 +0530
@@ -33,9 +33,6 @@
 #ifndef __ASSEMBLY__
 
 #define MAX_NOTE_BYTES 1024
-typedef u32 note_buf_t[MAX_NOTE_BYTES / sizeof(u32)];
-
-extern note_buf_t crash_notes[];
 
 #ifdef __powerpc64__
 extern void kexec_smp_wait(void);	/* get and clear naca physid, wait for
diff -puN include/asm-s390/kexec.h~kdump-dynamic-per-cpu-elf-note-memory-alloc include/asm-s390/kexec.h
--- linux-2.6.15-rc1-1M-dynamic/include/asm-s390/kexec.h~kdump-dynamic-per-cpu-elf-note-memory-alloc	2005-11-15 14:09:51.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/include/asm-s390/kexec.h	2005-11-15 14:09:52.000000000 +0530
@@ -35,8 +35,5 @@
 #define KEXEC_ARCH KEXEC_ARCH_S390
 
 #define MAX_NOTE_BYTES 1024
-typedef u32 note_buf_t[MAX_NOTE_BYTES/4];
-
-extern note_buf_t crash_notes[];
 
 #endif /*_S390_KEXEC_H */
diff -puN include/asm-x86_64/kexec.h~kdump-dynamic-per-cpu-elf-note-memory-alloc include/asm-x86_64/kexec.h
--- linux-2.6.15-rc1-1M-dynamic/include/asm-x86_64/kexec.h~kdump-dynamic-per-cpu-elf-note-memory-alloc	2005-11-15 14:09:52.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/include/asm-x86_64/kexec.h	2005-11-15 14:09:52.000000000 +0530
@@ -26,8 +26,5 @@
 #define KEXEC_ARCH KEXEC_ARCH_X86_64
 
 #define MAX_NOTE_BYTES 1024
-typedef u32 note_buf_t[MAX_NOTE_BYTES/4];
-
-extern note_buf_t crash_notes[];
 
 #endif /* _X86_64_KEXEC_H */
diff -puN include/linux/kexec.h~kdump-dynamic-per-cpu-elf-note-memory-alloc include/linux/kexec.h
--- linux-2.6.15-rc1-1M-dynamic/include/linux/kexec.h~kdump-dynamic-per-cpu-elf-note-memory-alloc	2005-11-15 14:09:52.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/include/linux/kexec.h	2005-11-15 14:09:52.000000000 +0530
@@ -125,6 +125,8 @@ extern struct kimage *kexec_image;
 /* Location of a reserved region to hold the crash kernel.
  */
 extern struct resource crashk_res;
+typedef u32 note_buf_t[MAX_NOTE_BYTES/4];
+extern note_buf_t *crash_notes;
 
 #else /* !CONFIG_KEXEC */
 struct pt_regs;
diff -puN kernel/kexec.c~kdump-dynamic-per-cpu-elf-note-memory-alloc kernel/kexec.c
--- linux-2.6.15-rc1-1M-dynamic/kernel/kexec.c~kdump-dynamic-per-cpu-elf-note-memory-alloc	2005-11-15 14:09:52.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/kernel/kexec.c	2005-11-15 14:09:52.000000000 +0530
@@ -26,6 +26,9 @@
 #include <asm/system.h>
 #include <asm/semaphore.h>
 
+/* Per cpu memory for storing cpu states in case of system crash. */
+note_buf_t* crash_notes;
+
 /* Location of the reserved area for the crash kernel */
 struct resource crashk_res = {
 	.name  = "Crash kernel",
@@ -1060,3 +1063,16 @@ void crash_kexec(struct pt_regs *regs)
 		xchg(&kexec_lock, 0);
 	}
 }
+
+static int __init crash_notes_memory_init(void)
+{
+	/* Allocate memory for saving cpu registers. */
+	crash_notes = alloc_percpu(note_buf_t);
+	if (!crash_notes) {
+		printk("Kexec: Memory allocation for saving cpu register"
+		" states failed\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+module_init(crash_notes_memory_init)
_
