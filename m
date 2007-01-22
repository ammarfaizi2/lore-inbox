Return-Path: <linux-kernel-owner+w=401wt.eu-S932071AbXAVQyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbXAVQyb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 11:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbXAVQyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 11:54:31 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:57784 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932071AbXAVQya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 11:54:30 -0500
Date: Mon, 22 Jan 2007 11:54:27 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>
Subject: [PATCH - revised] Kwatch: kernel watchpoints using CPU debug registers
In-Reply-To: <20070118223300.GA5404@infradead.org>
Message-ID: <Pine.LNX.4.44L0.0701221148270.2370-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

This patch (as839b) implements the Kwatch (kernel-space hardware-based
watchpoints) API for the i386 architecture.  The API is explained in
the kerneldoc for register_kwatch() in arch/i386/kernel/kwatch.c, and
there is demonstration code in include/asm-i386/kwatch.h.

The original version of the patch was written by Vamsi Krishna S and
Bharata B Rao in 2002.  It was updated in 2004 by Prasanna S Panchamukhi
for 2.6.13 and then again (here) by me for 2.6.20.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

This version of the patch has been revised along the lines suggested by
Christoph.  Note that it is meant to apply on top of the i386-ptrace
whitespace cleanup patch I submitted last week.

The impact of kwatch upon utrace is minimal.  Kwatch is intended for 
adding hardware watchpoints in the kernel, whereas utrace is intended for 
general debugging (not including watchpoints at the moment, oddly enough) 
of user processes.  The two don't really overlap, and adding kwatch should 
not result in any significant delay in adding utrace.

Alan Stern


Index: usb-2.6/arch/i386/kernel/debugreg.c
===================================================================
--- /dev/null
+++ usb-2.6/arch/i386/kernel/debugreg.c
@@ -0,0 +1,269 @@
+/*
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
+ * Copyright (C) IBM Corporation, 2002, 2004
+ * Copyright (C) 2007 Alan Stern
+ */
+
+/*
+ * These routines provide a debug register allocation mechanism.
+ */
+
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <asm/system.h>
+#include <asm/debugreg.h>
+
+struct debugreg {
+	int flag;
+	int use_count;
+};
+
+/* flag values */
+#define DR_ALLOC_NONE		0
+#define DR_ALLOC_GLOBAL		1
+#define DR_ALLOC_LOCAL		2
+
+static struct debugreg dr_list[DR_MAX];
+static DEFINE_SPINLOCK(dr_lock);
+static unsigned long dr7_global_mask = DR_CONTROL_RESERVED |
+		DR_GLOBAL_SLOWDOWN | DR_GLOBAL_ENABLE_MASK;
+
+/*
+ * Set the process's debug register 7 value: Keep all existing global
+ * bit settings and install the process's local bit settings.
+ */
+void set_process_debugreg7(unsigned long new_dr7)
+{
+	unsigned long dr7;
+
+	get_debugreg(dr7, 7);
+	dr7 = (dr7 & dr7_global_mask) | (new_dr7 & ~dr7_global_mask);
+	set_debugreg(dr7, 7);
+}
+
+/**
+ * debugreg7_clear_bits - clear the type, len, and global-enable flag bits
+ * @old_dr7: original value for debug register 7
+ * @regnum: number of the debug register to disable
+ *
+ * @regnum must lie in the range 0 - 3.
+ *
+ * Returns the new value for debug register 7, with the appropriate bits
+ * cleared to disable the specified debug register.
+ */
+unsigned long debugreg7_clear_bits(unsigned long old_dr7, int regnum)
+{
+	unsigned long new_dr7;
+
+	new_dr7 = old_dr7 & ~(0xf <<
+			(DR_CONTROL_SHIFT + regnum * DR_CONTROL_SIZE));
+	new_dr7 &= ~(0x2 << (regnum * DR_ENABLE_SIZE));
+	return new_dr7;
+}
+
+/**
+ * debugreg7_set_bits - set the type, len, and global-enable flag bits
+ * @old_dr7: original value for debug register 7
+ * @regnum: number of the debug register to enable
+ * @type: type of debugging watchpoint
+ * @len: length of the debugging watchpoint
+ *
+ * @regnum must lie in the range DR_FIRST_ADDR - DR_LAST_ADDR (0 - 3).
+ * @type must lie in the range DR_WR_EXECUTE - DR_RW_READ (0 - 3).
+ * @len must be 1, 2, or 4.
+ *
+ * Returns the new value for debug register 7, with the appropriate bits
+ * set to enable a new watchpoint for the specified debug register.
+ */
+unsigned long debugreg7_set_bits(unsigned long old_dr7, int regnum,
+		u8 type, u8 len)
+{
+	unsigned long new_dr7;
+
+	--len;
+	new_dr7 = old_dr7 & ~(0xf <<
+			(DR_CONTROL_SHIFT + regnum * DR_CONTROL_SIZE));
+	new_dr7 |= (((len << 2) | type) <<
+			(DR_CONTROL_SHIFT + regnum * DR_CONTROL_SIZE));
+	new_dr7 |= (0x2 << (regnum * DR_ENABLE_SIZE));
+	return new_dr7;
+}
+
+static unsigned long dr7_global_reg_mask(unsigned int regnum)
+{
+	return (0xf << (DR_CONTROL_SHIFT + regnum * DR_CONTROL_SIZE)) |
+			(0x1 << (regnum * DR_ENABLE_SIZE));
+}
+
+static int get_global_dr(int regnum)
+{
+	if (dr_list[regnum].flag == DR_ALLOC_NONE) {
+		dr_list[regnum].flag = DR_ALLOC_GLOBAL;
+		dr7_global_mask |= dr7_global_reg_mask(regnum);
+		return regnum;
+	}
+	return -1;
+}
+
+static void free_global_dr(int regnum)
+{
+	dr_list[regnum].flag = DR_ALLOC_NONE;
+	dr_list[regnum].use_count = 0;
+	dr7_global_mask &= ~dr7_global_reg_mask(regnum);
+}
+
+static int get_local_dr(int regnum)
+{
+	if (dr_list[regnum].flag != DR_ALLOC_GLOBAL) {
+		dr_list[regnum].flag = DR_ALLOC_LOCAL;
+		dr_list[regnum].use_count++;
+		return regnum;
+	}
+	return -1;
+}
+
+static void free_local_dr(int regnum)
+{
+	if (dr_list[regnum].flag == DR_ALLOC_LOCAL) {
+		if (!--dr_list[regnum].use_count)
+			dr_list[regnum].flag = DR_ALLOC_NONE;
+	}
+}
+
+/**
+ * debugreg_global_alloc - allocate a debug register for global use
+ * @regnum: register number to allocate or %DR_ANY
+ *
+ * Returns -1 if @regnum is already allocated, otherwise returns
+ * @regnum and does a global allocation.
+ */
+int debugreg_global_alloc(int regnum)
+{
+	int ret = -1;
+
+	spin_lock(&dr_lock);
+	if (regnum >= 0 && regnum < DR_MAX)
+		ret = get_global_dr(regnum);
+	else if (regnum == DR_ANY) {
+
+		/*
+		 * gdb allocates local debug registers starting from 0.
+		 * To help avoid conflicts, we'll start from the other end.
+		 */
+		for (regnum = DR_MAX - 1; regnum >= 0; --regnum) {
+			ret = get_global_dr(regnum);
+			if (ret >= 0)
+				break;
+		}
+	} else
+		printk(KERN_ERR "%s: Cannot allocate debug register %d\n",
+				__FUNCTION__,  regnum);
+	spin_unlock(&dr_lock);
+	return ret;
+}
+
+/**
+ * debugreg_global_free - release a global debug register allocation
+ * @regnum: the number of the register to deallocate
+ *
+ * @regnum must previously have been allocated by debugreg_global_alloc().
+ */
+void debugreg_global_free(int regnum)
+{
+	spin_lock(&dr_lock);
+	if (regnum < 0 || regnum >= DR_MAX ||
+			dr_list[regnum].flag != DR_ALLOC_GLOBAL)
+		printk(KERN_ERR "%s: Cannot free debug register %d\n",
+				__FUNCTION__,  regnum);
+	else
+		free_global_dr(regnum);
+	spin_unlock(&dr_lock);
+}
+
+/*
+ * Increment the usage counts for locally-enabled debug registers.
+ * Must be called when a process using debug registers forks or is cloned.
+ */
+void debugreg_inc_use_count(unsigned long mask)
+{
+	int i;
+	int dr_local_enable = 1 << DR_LOCAL_ENABLE_SHIFT;
+
+	spin_lock(&dr_lock);
+	for (i = 0; i < DR_MAX; (++i, dr_local_enable <<= DR_ENABLE_SIZE)) {
+		if (mask & dr_local_enable)
+			dr_list[i].use_count++;
+	}
+	spin_unlock(&dr_lock);
+}
+
+/*
+ * Decrement the usage counts for locally-enabled debug registers.
+ * Must be called when a process using debug registers exits or execs.
+ */
+void debugreg_dec_use_count(unsigned long mask)
+{
+	int i;
+	int dr_local_enable = 1 << DR_LOCAL_ENABLE_SHIFT;
+
+	spin_lock(&dr_lock);
+	for (i = 0; i < DR_MAX; (++i, dr_local_enable <<= DR_ENABLE_SIZE)) {
+		if (mask & dr_local_enable)
+			free_local_dr(i);
+	}
+	spin_unlock(&dr_lock);
+}
+
+/* Report whether a debug register is globally allocated. */
+int debugreg_is_global(int regnum)
+{
+	return (dr_list[regnum].flag == DR_ALLOC_GLOBAL);
+}
+
+/*
+ * This routine decides if a ptrace request is for enabling or disabling
+ * a debug reg, and accordingly calls dr_alloc() or dr_free().
+ *
+ * gdb uses ptrace to write to debug registers.  It assumes that writing to
+ * a debug register always succeds and it doesn't check the return value of
+ * ptrace.  Now with this new global debug register allocation/freeing,
+ * ptrace request for a local debug register will fail if the required debug
+ * register is already globally allocated.  Since gdb doesn't notice this
+ * failure, it sometimes tries to free a debug register which it does not
+ * own.
+ *
+ * Returns -1 if the ptrace request tries to locally allocate a debug register
+ * that is already globally allocated.  Otherwise returns >0 or 0 according
+ * as any debug registers are or are not locally allocated in the new setting.
+ */
+int enable_debugreg(unsigned long old_dr7, unsigned long new_dr7)
+{
+	int i;
+	int dr_local_enable = 1 << DR_LOCAL_ENABLE_SHIFT;
+
+	if (new_dr7 & DR_LOCAL_ENABLE_MASK & dr7_global_mask)
+		return -1;
+	for (i = 0; i < DR_MAX; (++i, dr_local_enable <<= DR_ENABLE_SIZE)) {
+		if ((old_dr7 ^ new_dr7) & dr_local_enable) {
+			if (new_dr7 & dr_local_enable)
+				get_local_dr(i);
+			else
+				free_local_dr(i);
+		}
+	}
+	return new_dr7 & DR_LOCAL_ENABLE_MASK;
+}
Index: usb-2.6/arch/i386/kernel/process.c
===================================================================
--- usb-2.6.orig/arch/i386/kernel/process.c
+++ usb-2.6/arch/i386/kernel/process.c
@@ -51,6 +51,7 @@
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
+#include <asm/debugreg.h>
 
 #include <linux/err.h>
 
@@ -356,9 +357,10 @@ EXPORT_SYMBOL(kernel_thread);
  */
 void exit_thread(void)
 {
+	struct task_struct *tsk = current;
+
 	/* The process may have allocated an io port bitmap... nuke it. */
 	if (unlikely(test_thread_flag(TIF_IO_BITMAP))) {
-		struct task_struct *tsk = current;
 		struct thread_struct *t = &tsk->thread;
 		int cpu = get_cpu();
 		struct tss_struct *tss = &per_cpu(init_tss, cpu);
@@ -376,15 +378,20 @@ void exit_thread(void)
 		tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
 		put_cpu();
 	}
+	if (unlikely(test_thread_flag(TIF_DEBUG)))
+ 		debugreg_dec_use_count(tsk->thread.debugreg[7]);
 }
 
 void flush_thread(void)
 {
 	struct task_struct *tsk = current;
 
+	if (unlikely(test_thread_flag(TIF_DEBUG))) {
+		debugreg_dec_use_count(tsk->thread.debugreg[7]);
+		clear_tsk_thread_flag(tsk, TIF_DEBUG);
+	}
 	memset(tsk->thread.debugreg, 0, sizeof(unsigned long)*8);
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));	
-	clear_tsk_thread_flag(tsk, TIF_DEBUG);
 	/*
 	 * Forget coprocessor state..
 	 */
@@ -462,6 +469,9 @@ int copy_thread(int nr, unsigned long cl
 		desc->b = LDT_entry_b(&info);
 	}
 
+	if (unlikely(test_thread_flag(TIF_DEBUG)))
+		debugreg_inc_use_count(tsk->thread.debugreg[7]);
+
 	err = 0;
  out:
 	if (err && p->thread.io_bitmap_ptr) {
@@ -537,14 +547,22 @@ static noinline void __switch_to_xtra(st
 
 	next = &next_p->thread;
 
+	/*
+	 * Don't reload global debug registers. Don't touch the global debug
+	 * register settings in dr7.
+	 */
 	if (test_tsk_thread_flag(next_p, TIF_DEBUG)) {
-		set_debugreg(next->debugreg[0], 0);
-		set_debugreg(next->debugreg[1], 1);
-		set_debugreg(next->debugreg[2], 2);
-		set_debugreg(next->debugreg[3], 3);
+		if (!debugreg_is_global(0))
+			set_debugreg(next->debugreg[0], 0);
+		if (!debugreg_is_global(1))
+			set_debugreg(next->debugreg[1], 1);
+		if (!debugreg_is_global(2))
+			set_debugreg(next->debugreg[2], 2);
+		if (!debugreg_is_global(3))
+			set_debugreg(next->debugreg[3], 3);
 		/* no 4 and 5 */
 		set_debugreg(next->debugreg[6], 6);
-		set_debugreg(next->debugreg[7], 7);
+		set_process_debugreg7(next->debugreg[7]);
 	}
 
 	if (!test_tsk_thread_flag(next_p, TIF_IO_BITMAP)) {
Index: usb-2.6/arch/i386/kernel/ptrace.c
===================================================================
--- usb-2.6.orig/arch/i386/kernel/ptrace.c
+++ usb-2.6/arch/i386/kernel/ptrace.c
@@ -412,6 +412,7 @@ long arch_ptrace(struct task_struct *chi
 			ret = putreg(child, addr, data);
 			break;
 		}
+
 		/* We need to be very careful here.  We implicitly
 		   want to modify a portion of the task_struct, and we
 		   have to be selective about what portions we allow someone
@@ -421,10 +422,18 @@ long arch_ptrace(struct task_struct *chi
 		if (addr >= (long) &dummy->u_debugreg[0] &&
 		    addr <= (long) &dummy->u_debugreg[7]) {
 
-			if (addr == (long) &dummy->u_debugreg[4]) break;
-			if (addr == (long) &dummy->u_debugreg[5]) break;
-			if (addr < (long) &dummy->u_debugreg[4] &&
-			    ((unsigned long) data) >= TASK_SIZE-3) break;
+			addr -= (long) &dummy->u_debugreg;
+			addr = addr >> 2;
+			if (addr < 4) {
+				if ((unsigned long) data >= TASK_SIZE-3)
+					break;
+				if (debugreg_is_global(addr)) {
+					ret = -EBUSY;
+					break;
+				}
+			}
+			else if (addr == 4 || addr == 5)
+				break;
 
 			/* Sanity-check data. Take one half-byte at once with
 			 * check = (val >> (16 + 4*i)) & 0xf. It contains the
@@ -456,18 +465,21 @@ long arch_ptrace(struct task_struct *chi
 			 * See the AMD manual no. 24593 (AMD64 System
 			 * Programming) */
 
-			if (addr == (long) &dummy->u_debugreg[7]) {
+			else if (addr == 7) {
 				data &= ~DR_CONTROL_RESERVED;
 				for (i = 0; i < 4; i++)
 					if ((0x5f54 >> ((data >> (16 + 4*i)) & 0xf)) & 1)
 						goto out_tsk;
-				if (data)
+				i = enable_debugreg(child->thread.debugreg[7], data);
+				if (i < 0) {
+					ret = -EBUSY;
+					break;
+				}
+				if (i)
 					set_tsk_thread_flag(child, TIF_DEBUG);
 				else
 					clear_tsk_thread_flag(child, TIF_DEBUG);
 			}
-			addr -= (long) &dummy->u_debugreg;
-			addr = addr >> 2;
 			child->thread.debugreg[addr] = data;
 			ret = 0;
 		}
Index: usb-2.6/arch/i386/kernel/signal.c
===================================================================
--- usb-2.6.orig/arch/i386/kernel/signal.c
+++ usb-2.6/arch/i386/kernel/signal.c
@@ -25,6 +25,7 @@
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
+#include <asm/debugreg.h>
 #include "sigframe.h"
 
 #define DEBUG_SIG 0
@@ -594,7 +595,7 @@ static void fastcall do_signal(struct pt
 		 * inside the kernel.
 		 */
 		if (unlikely(current->thread.debugreg[7]))
-			set_debugreg(current->thread.debugreg[7], 7);
+			set_process_debugreg7(current->thread.debugreg[7]);
 
 		/* Whee!  Actually deliver the signal.  */
 		if (handle_signal(signr, &info, &ka, oldset, regs) == 0) {
Index: usb-2.6/arch/i386/kernel/traps.c
===================================================================
--- usb-2.6.orig/arch/i386/kernel/traps.c
+++ usb-2.6/arch/i386/kernel/traps.c
@@ -808,6 +808,7 @@ fastcall void __kprobes do_debug(struct 
 	struct task_struct *tsk = current;
 
 	get_debugreg(condition, 6);
+	set_debugreg(0, 6);	/* DR6 is never cleared by the CPU */
 
 	if (notify_die(DIE_DEBUG, "debug", regs, condition, error_code,
 					SIGTRAP) == NOTIFY_STOP)
@@ -849,7 +850,7 @@ fastcall void __kprobes do_debug(struct 
 	 * the signal is delivered.
 	 */
 clear_dr7:
-	set_debugreg(0, 7);
+	set_process_debugreg7(0);
 	return;
 
 debug_vm86:
Index: usb-2.6/include/asm-i386/debugreg.h
===================================================================
--- usb-2.6.orig/include/asm-i386/debugreg.h
+++ usb-2.6/include/asm-i386/debugreg.h
@@ -33,6 +33,7 @@
 
 #define DR_RW_EXECUTE (0x0)   /* Settings for the access types to trap on */
 #define DR_RW_WRITE (0x1)
+#define DR_RW_IO (0x2)
 #define DR_RW_READ (0x3)
 
 #define DR_LEN_1 (0x0) /* Settings for data length to trap on */
@@ -61,4 +62,43 @@
 #define DR_LOCAL_SLOWDOWN (0x100)   /* Local slow the pipeline */
 #define DR_GLOBAL_SLOWDOWN (0x200)  /* Global slow the pipeline */
 
+#define DR_MAX	4
+#define DR_ANY	(DR_MAX + 1)
+
+#ifdef CONFIG_KWATCH
+
+extern void set_process_debugreg7(unsigned long new_dr7);
+extern unsigned long debugreg7_set_bits(unsigned long old_dr7, int regnum,
+		u8 type, u8 len);
+extern unsigned long debugreg7_clear_bits(unsigned long old_dr7, int regnum);
+extern int debugreg_global_alloc(int regnum);
+extern void debugreg_global_free(int regnum);
+extern void debugreg_inc_use_count(unsigned long mask);
+extern void debugreg_dec_use_count(unsigned long mask);
+extern int debugreg_is_global(int regnum);
+extern int enable_debugreg(unsigned long old_dr7, unsigned long new_dr7);
+
+#else
+
+static inline void set_process_debugreg7(unsigned long new_dr7);
+{
+	set_debugreg(new_dr7, 7);
+}
+static inline void debugreg_inc_use_count(unsigned long mask)
+{
+}
+static inline void debugreg_dec_use_count(unsigned long mask)
+{
+}
+static inline int debugreg_is_global(int regnum)
+{
+	return 0;
+}
+static inline int enable_debugreg(unsigned long old_dr7,
+		unsigned long new_dr7)
+{
+	return (new_dr7 != 0);
+}
+
+#endif				/* CONFIG_KWATCH */
 #endif
Index: usb-2.6/arch/i386/kernel/kwatch.c
===================================================================
--- /dev/null
+++ usb-2.6/arch/i386/kernel/kwatch.c
@@ -0,0 +1,274 @@
+/*
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
+ * Copyright (C) IBM Corporation, 2002, 2004
+ * Copyright (C) 2007 Alan Stern
+ */
+
+/* Kwatch: a kernel watchpoint interface, using the CPU's debug registers. */
+
+#include <linux/bitops.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/ptrace.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <asm/kwatch.h>
+#include <asm/kdebug.h>
+#include <asm/debugreg.h>
+
+#define RF_MASK	0x00010000
+
+static struct kwatch kwatch_list[DR_MAX];
+static DEFINE_SPINLOCK(kwatch_lock);
+static unsigned long kwatch_in_progress;	/* bitmap of registers
+							being handled */
+
+static void write_debugreg(unsigned long addr, int debugreg)
+{
+	switch (debugreg) {
+		case 0:	set_debugreg(addr, 0);	break;
+		case 1:	set_debugreg(addr, 1);	break;
+		case 2:	set_debugreg(addr, 2);	break;
+		case 3:	set_debugreg(addr, 3);	break;
+		case 6:	set_debugreg(addr, 6);	break;
+		case 7:	set_debugreg(addr, 7);	break;
+	}
+}
+
+#ifdef CONFIG_SMP
+
+struct dr_info {
+	int debugreg;
+	int type;
+	unsigned long addr;
+};
+
+static void write_smp_debugreg(void *info)
+{
+	struct dr_info *dr = (struct dr_info *) info;
+
+	if (cpu_has_de && dr->type == KWATCH_TYPE_IO)
+		set_in_cr4(X86_CR4_DE);
+	write_debugreg(dr->addr, dr->debugreg);
+}
+
+/* Update a debug register on all CPUs */
+static void sync_debugreg(unsigned long addr, int debugreg, int type)
+{
+	struct dr_info dr;
+
+	dr.debugreg = debugreg;
+	dr.type = type;
+	dr.addr = addr;
+	smp_call_function(write_smp_debugreg, &dr, 0, 0);
+}
+
+#else
+
+static inline void sync_debugreg(unsigned long addr, int debugreg, int type)
+{
+}
+#endif	/* CONFIG_SMP */
+
+/*
+ * Interrupts are disabled on entry as trap1 is an interrupt gate and they
+ * remain disabled thorough out this function.
+ */
+static int kwatch_handler(unsigned long condition, struct pt_regs *regs)
+{
+	unsigned int debugreg;
+	unsigned long addr;
+	struct kwatch *kw;
+	int recursed = 0;
+
+	/* The debug status register value is passed in "condition". */
+	if (condition & DR_TRAP0) {
+		debugreg = 0;
+		get_debugreg(addr, 0);
+	} else if (condition & DR_TRAP1) {
+		debugreg = 1;
+		get_debugreg(addr, 1);
+	} else if (condition & DR_TRAP2) {
+		debugreg = 2;
+		get_debugreg(addr, 2);
+	} else if (condition & DR_TRAP3) {
+		debugreg = 3;
+		get_debugreg(addr, 3);
+	} else
+		return recursed;
+	kw = &kwatch_list[debugreg];
+
+	/* We're in an interrupt, but this is clear and BUG()-safe. */
+	preempt_disable();
+
+	/* If we are recursing, we already hold the lock. */
+	if (kwatch_in_progress)
+		recursed = 1;
+	else
+		spin_lock(&kwatch_lock);
+	set_bit(debugreg, &kwatch_in_progress);
+
+	if ((unsigned long) kw->addr == addr) {
+		if (!recursed && kw->handler)
+			kw->handler(kw, regs);
+		if (kw->type == KWATCH_TYPE_EXECUTE)
+			regs->eflags |= RF_MASK;
+	}
+
+	clear_bit(debugreg, &kwatch_in_progress);
+	if (!recursed)
+		spin_unlock(&kwatch_lock);
+
+	preempt_enable_no_resched();
+	return recursed;
+}
+
+/**
+ * register_kwatch - register a hardware watchpoint
+ * @addr: address of the watchpoint
+ * @length: extent of the watchpoint (1, 2, or 4 bytes)
+ * @type: type of access to trap (read, write, I/O, or execute)
+ * @handler: callback routine to invoke when a trap occurs
+ *
+ * Allocates and returns a debug register and installs the requested
+ * watchpoint.
+ *
+ * @length must be 1, 2, or 4, and @type must be one of %KWATCH_TYPE_RW
+ * (read or write), %KWATCH_TYPE_WRITE (write only), %KWATCH_TYPE_IO
+ * (IO-space access), or %KWATCH_TYPE_EXECUTE.  Note that %KWATCH_TYPE_IO
+ * is available only on processors with Debugging Extensions, and @length
+ * must be 1 for %KWATCH_TYPE_EXECUTE.
+ *
+ * When a trap occurs, @handler is invoked in_interrupt with a pointer
+ * to a struct kwatch containing the watchpoint information and a pointer
+ * to the CPU register values at the time of the trap.  %KWATCH_TYPE_EXECUTE
+ * traps occur before the watch-pointed instruction executes; all other
+ * types occur after the memory or I/O access has taken place.
+ *
+ * Returns a debug register number or a negative error code.
+ */
+int register_kwatch(void *addr, u8 length, u8 type, kwatch_handler_t handler)
+{
+	int debugreg;
+	unsigned long dr7, flags;
+
+	switch (length) {
+	case 1:
+	case 2:
+	case 4:
+		break;
+	default:
+		return -EINVAL;
+	}
+	switch (type) {
+	case KWATCH_TYPE_WRITE:
+	case KWATCH_TYPE_RW:
+		break;
+	case KWATCH_TYPE_IO:
+		if (cpu_has_de)
+			break;
+		return -EINVAL;
+	case KWATCH_TYPE_EXECUTE:
+		if (length == 1)
+			break;
+		/* FALL THROUGH */
+	default:
+		return -EINVAL;
+	}
+	if (!handler)
+		return -EINVAL;
+
+	debugreg = debugreg_global_alloc(DR_ANY);
+	if (debugreg < 0)
+		return -EBUSY;
+
+	spin_lock_irqsave(&kwatch_lock, flags);
+	kwatch_list[debugreg].addr = addr;
+	kwatch_list[debugreg].length = length;
+	kwatch_list[debugreg].type = type;
+	kwatch_list[debugreg].handler = handler;
+	spin_unlock_irqrestore(&kwatch_lock, flags);
+
+	if (type == KWATCH_TYPE_IO)
+		set_in_cr4(X86_CR4_DE);
+	write_debugreg((unsigned long) addr, debugreg);
+	sync_debugreg((unsigned long) addr, debugreg, type);
+
+	get_debugreg(dr7, 7);
+	dr7 = debugreg7_set_bits(dr7, debugreg, type, length);
+	set_debugreg(dr7, 7);
+	sync_debugreg(dr7, 7, 0);
+	return debugreg;
+}
+EXPORT_SYMBOL_GPL(register_kwatch);
+
+/**
+ * unregister_kwatch - free a previously-allocated debugging watchpoint
+ * @debugreg: the debugging register to deallocate
+ *
+ * Removes a hardware watchpoint and deallocates the corresponding
+ * debugging register.  @debugreg must previously have been allocated
+ * by register_kwatch().
+ */
+void unregister_kwatch(int debugreg)
+{
+	unsigned long flags;
+	unsigned long dr7;
+
+	if (debugreg < 0 || debugreg >= DR_MAX ||
+			!kwatch_list[debugreg].handler)
+		return;
+
+	get_debugreg(dr7, 7);
+	dr7 = debugreg7_clear_bits(dr7, debugreg);
+	set_debugreg(dr7, 7);
+	sync_debugreg(dr7, 7, 0);
+
+	spin_lock_irqsave(&kwatch_lock, flags);
+	kwatch_list[debugreg].addr = 0;
+	kwatch_list[debugreg].handler = NULL;
+	spin_unlock_irqrestore(&kwatch_lock, flags);
+
+	debugreg_global_free(debugreg);
+}
+EXPORT_SYMBOL_GPL(unregister_kwatch);
+
+/*
+ * Wrapper routine to for handling exceptions.
+ */
+static int kwatch_exceptions_notify(struct notifier_block *self,
+		unsigned long val, void *data)
+{
+	struct die_args *args = (struct die_args *) data;
+
+	if (val == DIE_DEBUG) {
+		if (kwatch_handler(args->err, args->regs))
+			return NOTIFY_STOP;
+	}
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block kwatch_exceptions_nb = {
+	.notifier_call = kwatch_exceptions_notify,
+	.priority = 0x7ffffffe		/* we need to notified second */
+};
+
+static int __init init_kwatch(void)
+{
+	return register_die_notifier(&kwatch_exceptions_nb);
+}
+
+__initcall(init_kwatch);
Index: usb-2.6/arch/i386/kernel/Makefile
===================================================================
--- usb-2.6.orig/arch/i386/kernel/Makefile
+++ usb-2.6/arch/i386/kernel/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_VM86)		+= vm86.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
 obj-$(CONFIG_K8_NB)		+= k8.o
+obj-$(CONFIG_KWATCH)		+= debugreg.o kwatch.o
 
 # Make sure this is linked after any other paravirt_ops structs: see head.S
 obj-$(CONFIG_PARAVIRT)		+= paravirt.o
Index: usb-2.6/include/asm-i386/kwatch.h
===================================================================
--- /dev/null
+++ usb-2.6/include/asm-i386/kwatch.h
@@ -0,0 +1,99 @@
+#ifndef _ASM_KWATCH_H
+#define _ASM_KWATCH_H
+
+/*
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
+ * Copyright (C) IBM Corporation, 2002, 2004
+ * Copyright (C) 2007 Alan Stern
+ */
+
+/*
+ * Kernel watchpoint interface.  Use these routines to create and delete
+ * hardware watchpoints within the kernel, using the CPU's debug registers.
+ *
+ * This sample code sets a watchpoint on pid_max and registers a callback
+ * function for writes to that variable.
+ *
+ * ----------------------------------------------------------------------
+ * #include <asm/kwatch.h>
+ *
+ * static void kwatch_handler(struct kwatch *p, struct pt_regs *regs)
+ * {
+ * 	printk(KERN_DEBUG "Watchpoint triggered\n");
+ * 	dump_stack();
+ * 	.......<do anything>........
+ * }
+ *
+ * static int debugreg_num;
+ *
+ * static int init_module(void)
+ * {
+ * 	..........<do anything>............
+ * 	debugreg_num = register_kwatch(&pid_max,
+ * 			 4, KWATCH_TYPE_WRITE, kwatch_handler);
+ * 	..........<do anything>............
+ * }
+ *
+ * static void cleanup_module(void)
+ * {
+ * 	..........<do anything>............
+ * 	unregister_kwatch(debugreg_num);
+ * 	..........<do anything>............
+ * }
+ * ----------------------------------------------------------------------
+ *
+ * Test this by changing the value of pid_max in /proc/sys/kernel/pid_max:
+ *
+ * 	# echo 1000 > /proc/sys/kernel/pid_max
+ *
+ * The output from kwatch_handler() will show up in the system log.
+ */
+
+#include <linux/types.h>
+
+struct kwatch;
+struct pt_regs;
+typedef void (*kwatch_handler_t)(struct kwatch *, struct pt_regs *);
+
+struct kwatch {
+	void *addr;		/* location of watchpoint */
+	u8 length;		/* range of address */
+	u8 type;		/* type of watchpoint */
+	kwatch_handler_t handler;
+};
+
+#define KWATCH_TYPE_EXECUTE 	0x0	/* Watchpoint types */
+#define KWATCH_TYPE_WRITE	0x1
+#define KWATCH_TYPE_IO		0x2
+#define KWATCH_TYPE_RW		0x3
+
+#ifdef	CONFIG_KWATCH
+extern int register_kwatch(void *addr, u8 length, u8 type,
+		kwatch_handler_t handler);
+extern void unregister_kwatch(int debugreg);
+
+#else
+
+static inline int register_kwatch(void *addr, u8 length, u8 type,
+		kwatch_handler_t handler)
+{
+	return -ENOSYS;
+}
+static inline void unregister_kwatch(int debugreg)
+{
+}
+#endif
+#endif	/* _ASM_KWATCH_H */
Index: usb-2.6/arch/i386/Kconfig
===================================================================
--- usb-2.6.orig/arch/i386/Kconfig
+++ usb-2.6/arch/i386/Kconfig
@@ -1210,6 +1210,14 @@ config KPROBES
 	  a probepoint and specifies the callback.  Kprobes is useful
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
+
+config KWATCH
+	bool "Kwatch points (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  Kwatch enables kernel-space data watchpoints using the processor's
+	  debug registers.  It can be very useful for kernel debugging.
+	  If in doubt, say "N".
 endmenu
 
 source "arch/i386/Kconfig.debug"

