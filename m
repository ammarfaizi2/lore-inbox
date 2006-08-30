Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWH3X04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWH3X04 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWH3X0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:26:55 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:27543 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751108AbWH3X0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:26:53 -0400
Date: Wed, 30 Aug 2006 19:26:51 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: [PATCH 15/16] LTTng : Linux Trace Toolkit Next Generation 0.5.95, kernel 2.6.17
Message-ID: <20060830232651.GP17079@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Krystal-22734-1156980411-0001-2"
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:26:07 up 7 days, 20:35,  9 users,  load average: 1.65, 0.95, 0.57
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-22734-1156980411-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

15- LTTng architecture dependant instrumentation --- sh (incomplete)
patch-2.6.17-lttng-0.5.95-instrumentation-sh.diff

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

--=_Krystal-22734-1156980411-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.6.17-lttng-0.5.95-instrumentation-sh.diff"

--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -12,6 +12,8 @@ #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 #include <linux/seq_file.h>
+#include <linux/ltt-events.h>
+
 #include <asm/irq.h>
 #include <asm/processor.h>
 #include <asm/cpu/mmu_context.h>
diff --git a/arch/sh/kernel/process.c b/arch/sh/kernel/process.c
index 22dc9c2..4af1849 100644
--- a/arch/sh/kernel/process.c
+++ b/arch/sh/kernel/process.c
@@ -21,6 +21,7 @@ #include <linux/pm.h>
 #include <linux/ptrace.h>
 #include <linux/kallsyms.h>
 #include <linux/kexec.h>
+#include <linux/ltt-events.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
diff --git a/arch/sh/kernel/sys_sh.c b/arch/sh/kernel/sys_sh.c
index 917b2f3..d4a8619 100644
--- a/arch/sh/kernel/sys_sh.c
+++ b/arch/sh/kernel/sys_sh.c
@@ -21,6 +21,7 @@ #include <linux/syscalls.h>
 #include <linux/mman.h>
 #include <linux/file.h>
 #include <linux/utsname.h>
+#include <linux/ltt-events.h>
 
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
@@ -174,6 +175,8 @@ asmlinkage int sys_ipc(uint call, int fi
 	version = call >> 16; /* hack for backward compatibility */
 	call &= 0xffff;
 
+	ltt_ev_ipc(LTT_EV_IPC_CALL, call, first);
+
 	if (call <= SEMCTL)
 		switch (call) {
 		case SEMOP:
diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
index 7eb0671..64b626c 100644
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -27,6 +27,7 @@ #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/module.h>
 #include <linux/kallsyms.h>
+#include <linux/ltt-events.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -500,6 +501,8 @@ asmlinkage void do_address_error(struct 
 
 	asm volatile("stc       r2_bank,%0": "=r" (error_code));
 
+	ltt_ev_trap_entry(error_code >> 5, regs->pc);
+
 	oldfs = get_fs();
 
 	if (user_mode(regs)) {
@@ -523,8 +526,10 @@ asmlinkage void do_address_error(struct 
 		tmp = handle_unaligned_access(instruction, regs);
 		set_fs(oldfs);
 
-		if (tmp==0)
-			return; /* sorted */
+		if (tmp==0) {
+			ltt_ev_trap_exit();
+ 			return; /* sorted */
+		}
 
 	uspace_segv:
 		printk(KERN_NOTICE "Killing process \"%s\" due to unaligned access\n", current->comm);
@@ -545,6 +550,7 @@ asmlinkage void do_address_error(struct 
 		handle_unaligned_access(instruction, regs);
 		set_fs(oldfs);
 	}
+	ltt_ev_trap_exit();
 }
 
 #ifdef CONFIG_SH_DSP
@@ -704,6 +710,74 @@ void show_task(unsigned long *sp)
 {
 	show_stack(NULL, sp);
 }
+/* Trace related code */
+#ifdef CONFIG_LTT
+asmlinkage void trace_real_syscall_entry(struct pt_regs *regs)
+{
+	int use_depth;
+	int use_bounds;
+	int depth = 0;
+	int seek_depth;
+	unsigned long lower_bound;
+	unsigned long upper_bound;
+	unsigned long addr;
+	unsigned long *stack;
+	ltt_syscall_entry trace_syscall_event;
+
+	/* Set the syscall ID */
+	trace_syscall_event.syscall_id = (uint8_t) regs->regs[REG_REG0 + 3];
+
+	/* Set the address in any case */
+	trace_syscall_event.address = regs->pc;
+
+	/* Are we in the kernel (This is a kernel thread)? */
+	if (!user_mode(regs))
+		/* Don't go digining anywhere */
+		goto trace_syscall_end;
+
+	/* Get the trace configuration */
+	if (ltt_get_trace_config(&use_depth, &use_bounds, &seek_depth,
+				(void *) &lower_bound, (void *) &upper_bound) < 0)
+		goto trace_syscall_end;
+
+	/* Do we have to search for an eip address range */
+	if ((use_depth == 1) || (use_bounds == 1)) {
+		/* Start at the top of the stack (bottom address since stacks grow downward) */
+		stack = (unsigned long *) regs->regs[REG_REG15];
+
+		/* Keep on going until we reach the end of the process' stack limit (wherever it may be) */
+		while (!get_user(addr, stack)) {
+			/* Does this LOOK LIKE an address in the program */
+			/* TODO: does this work with shared libraries?? - Greg Banks */
+			if ((addr > current->mm->start_code) && (addr < current->mm->end_code)) {
+				/* Does this address fit the description */
+				if (((use_depth == 1) && (depth == seek_depth))
+				    || ((use_bounds == 1) && (addr > lower_bound)
+					&& (addr < upper_bound))) {
+					/* Set the address */
+					trace_syscall_event.address = addr;
+
+					/* We're done */
+					goto trace_syscall_end;
+				} else
+					/* We're one depth more */
+					depth++;
+			}
+			/* Go on to the next address */
+			stack++;
+		}
+	}
+trace_syscall_end:
+	/* Trace the event */
+	ltt_log_event(LTT_EV_SYSCALL_ENTRY, &trace_syscall_event);
+}
+
+asmlinkage void trace_real_syscall_exit(void)
+{
+	ltt_log_event(LTT_EV_SYSCALL_EXIT, NULL);
+}
+
+#endif				/* CONFIG_LTT */
 
 void dump_stack(void)
 {
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 775f86c..f3f08b3 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -21,6 +21,7 @@ #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/ltt-events.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -53,6 +54,14 @@ #endif
 	tsk = current;
 	mm = tsk->mm;
 
+#ifdef CONFIG_LTT
+	{
+		unsigned long trapnr;
+		asm volatile("stc       r2_bank,%0": "=r" (trapnr));
+		ltt_ev_trap_entry(trapnr >> 5, regs->pc);  /* trap 4,5 or 6 */
+	}
+#endif
+
 	/*
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
@@ -106,6 +115,7 @@ survive:
 	}
 
 	up_read(&mm->mmap_sem);
+	ltt_ev_trap_exit();
 	return;
 
 /*
@@ -119,6 +129,7 @@ bad_area:
 		tsk->thread.address = address;
 		tsk->thread.error_code = writeaccess;
 		force_sig(SIGSEGV, tsk);
+		ltt_ev_trap_exit();
 		return;
 	}
 
@@ -185,6 +196,8 @@ do_sigbus:
 	/* Kernel mode? Handle exceptions or die */
 	if (!user_mode(regs))
 		goto no_context;
+
+	ltt_ev_trap_exit();
 }
 
 /*
diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index 408d44a..1937b8b 100644

--=_Krystal-22734-1156980411-0001-2--
