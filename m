Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVH3I0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVH3I0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 04:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVH3I0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 04:26:12 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:31385 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750832AbVH3I0L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 04:26:11 -0400
Date: Tue, 30 Aug 2005 13:56:53 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Tom Rini <trini@kernel.crashing.org>, Andi Kleen <ak@suse.de>,
       kaos@sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 16/16] Add hardware breakpoint support for i386
Message-ID: <20050830082653.GA629@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > This adds hardware breakpoint support for i386. This is not as well tested
> as
> > software breakpoints, but in some minimal testing appears to be
> functional.
>
> This really would need so coordination with user space using
> them. Otherwise it'll be quite unreliable because any user program
> can break it.
>
> Long ago (in 2.4 time frame) there used to be a IBM patch floating
> around to reserve them globally and user space to use specific ones. I
> guess something like that would be needed again.
>

Yes, to add hardware breakpoint support for i386, there are two patches.
1. Provides hardware debug register allocation mechanism.
2. Provides light weight interface for kernel-space watchpoint probes
These patches have been posted & reviewd on lkml and systemtap mailing lists.

Your comments are welcome.

Thanks
Prasanna

This patch provides debug register allocation mechanism.
Useful for debuggers like IOW, kgdb, kdb, kernel watchpoint.
---
Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>

---


---

 linux-2.6.13-prasanna/arch/i386/Kconfig.debug     |    8 
 linux-2.6.13-prasanna/arch/i386/kernel/Makefile   |    1 
 linux-2.6.13-prasanna/arch/i386/kernel/debugreg.c |  281 ++++++++++++++++++++++
 linux-2.6.13-prasanna/arch/i386/kernel/process.c  |   31 +-
 linux-2.6.13-prasanna/arch/i386/kernel/ptrace.c   |    5 
 linux-2.6.13-prasanna/arch/i386/kernel/signal.c   |    3 
 linux-2.6.13-prasanna/arch/i386/kernel/traps.c    |    2 
 linux-2.6.13-prasanna/include/asm-i386/debugreg.h |  189 ++++++++++++++
 8 files changed, 511 insertions(+), 9 deletions(-)

diff -puN arch/i386/Kconfig.debug~kprobes-debug-regs arch/i386/Kconfig.debug
--- linux-2.6.13/arch/i386/Kconfig.debug~kprobes-debug-regs	2005-08-30 11:43:49.369626152 +0530
+++ linux-2.6.13-prasanna/arch/i386/Kconfig.debug	2005-08-30 11:43:49.442615056 +0530
@@ -32,6 +32,14 @@ config KPROBES
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
 
+config DEBUGREG
+	bool "Global Debug Registers"
+	depends on DEBUG_KERNEL
+	default off
+	help
+	  Global debug register allocation mechanism is useful for debuggers
+	  IOW, Kgdb, Kdb, Kernel Watchpoint probes. If in doubt say "N"
+
 config DEBUG_STACK_USAGE
 	bool "Stack utilization instrumentation"
 	depends on DEBUG_KERNEL
diff -puN /dev/null arch/i386/kernel/debugreg.c
--- /dev/null	2005-08-30 16:04:24.253093808 +0530
+++ linux-2.6.13-prasanna/arch/i386/kernel/debugreg.c	2005-08-30 11:43:49.444614752 +0530
@@ -0,0 +1,281 @@
+/*
+ *  Debug register
+ *  arch/i386/kernel/debugreg.c
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
+ * Copyright (C) IBM Corporation, 2002, 2004
+ *
+ * 2002-Oct	Created by Vamsi Krishna S <vamsi_krishna@in.ibm.com> and
+ *		Bharata Rao <bharata@in.ibm.com> to provide debug register
+ *		allocation mechanism.
+ * 2004-Oct	Updated by Prasanna S Panchamukhi <prasanna@in.ibm.com> with
+ *		idr_allocations mechanism as suggested by Andi Kleen.
+ */
+/*
+ * This provides a debug register allocation mechanism, to be
+ * used by all debuggers, which need debug registers.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/idr.h>
+#include <asm/system.h>
+#include <asm/debugreg.h>
+
+struct debugreg dr_list[DR_MAX];
+unsigned long dr7_global_mask = 0;
+static spinlock_t dr_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_IDR(debugreg_idr);
+static DECLARE_MUTEX(debugreg_idr_mutex);
+static spinlock_t debugreg_idr_lock = SPIN_LOCK_UNLOCKED;
+
+static unsigned long dr7_global_bits[] = {
+	DR7_DR0_BITS, DR7_DR1_BITS, DR7_DR2_BITS, DR7_DR3_BITS
+};
+
+static inline void set_dr7_global_mask(int regnum)
+{
+	if (DR_IS_ADDR(regnum))
+		dr7_global_mask |= dr7_global_bits[regnum];
+}
+
+static inline void clear_dr7_global_mask(int regnum)
+{
+	if (DR_IS_ADDR(regnum))
+		dr7_global_mask |= ~dr7_global_bits[regnum];
+}
+
+/*
+ * See if specific debug register is free.
+ */
+static int specific_debugreg(unsigned int regnum)
+{
+	int r, n;
+
+	if (regnum >= DR_MAX)
+		return -EINVAL;
+
+	down(&debugreg_idr_mutex);
+	r = idr_pre_get(&debugreg_idr, GFP_KERNEL);
+	up(&debugreg_idr_mutex);
+	if (!r)
+		return -ENOMEM;
+
+	spin_lock(&debugreg_idr_lock);
+
+	if (idr_find(&debugreg_idr, regnum)) {
+		r = -EBUSY;
+		goto out;
+	}
+
+	r = idr_get_new_above(&debugreg_idr, specific_debugreg, regnum, &n);
+	if (r)
+		goto out;
+
+	if (n != regnum) {
+		idr_remove(&debugreg_idr, n);
+		r = -EBUSY;
+		goto out;
+	}
+
+      out:
+	spin_unlock(&debugreg_idr_lock);
+	return r;
+}
+
+static int next_free_debugreg(unsigned int *regnum)
+{
+	int r;
+	unsigned int n;
+
+	down(&debugreg_idr_mutex);
+	r = idr_pre_get(&debugreg_idr, GFP_KERNEL);
+	up(&debugreg_idr_mutex);
+	if (!r)
+		return -ENOMEM;
+
+	spin_lock(&debugreg_idr_lock);
+
+	r = idr_get_new(&debugreg_idr, next_free_debugreg, &n);
+	if (r)
+		goto out;
+
+	if (n >= DR_MAX) {
+		idr_remove(&debugreg_idr, n);
+		r = -ENOSPC;
+		goto out;
+	}
+
+	*regnum = n;
+      out:
+	spin_unlock(&debugreg_idr_lock);
+	return r;
+}
+
+static void free_debugreg(int regnum)
+{
+	spin_lock(&debugreg_idr_lock);
+	idr_remove(&debugreg_idr, regnum);
+	spin_unlock(&debugreg_idr_lock);
+}
+
+static int get_dr(int regnum, int flag)
+{
+	int ret;
+
+	ret = specific_debugreg(regnum);
+
+	if ((flag == DR_ALLOC_GLOBAL) && (ret >= 0)) {
+		dr_list[regnum].flag = DR_GLOBAL;
+		set_dr7_global_mask(regnum);
+		return regnum;
+	} else if (dr_list[regnum].flag != DR_GLOBAL) {
+		dr_list[regnum].use_count++;
+		dr_list[regnum].flag = DR_LOCAL;
+		return regnum;
+	}
+	return ret;
+}
+
+static int get_any_dr(int flag)
+{
+	int i, ret = 0;
+
+	if (flag == DR_ALLOC_LOCAL) {
+		for (i = 0; i < DR_MAX; i++) {
+			if ((idr_find(&debugreg_idr, i)) && (dr_list[i].flag == DR_LOCAL)) {
+				dr_list[i].use_count++;
+				return i;
+			}
+		}
+		if ((ret = next_free_debugreg(&i)) >= 0) {
+			dr_list[i].flag = DR_LOCAL;
+			dr_list[i].use_count = 1;
+			return i;
+		}
+	} else {
+		if ((ret = next_free_debugreg(&i)) >= 0) {
+			dr_list[i].flag = DR_GLOBAL;
+			set_dr7_global_mask(i);
+			return i;
+		}
+	}
+	return ret;
+}
+
+static inline void dr_free_local(int regnum)
+{
+	if (!(--dr_list[regnum].use_count)) {
+		free_debugreg(regnum);
+		dr_list[regnum].flag = DR_UNUSED;
+	}
+}
+
+static inline void dr_free_global(int regnum)
+{
+	free_debugreg(regnum);
+	dr_list[regnum].flag = DR_UNUSED;
+	dr_list[regnum].use_count = 0;
+	clear_dr7_global_mask(regnum);
+}
+
+int dr_alloc(int regnum, int flag)
+{
+	int ret = 0;
+
+	spin_lock(&dr_lock);
+	if (regnum == DR_ANY)
+		ret = get_any_dr(flag);
+	else if (regnum >= DR_MAX)
+		ret = -1;
+	else
+		ret = get_dr(regnum, flag);
+	spin_unlock(&dr_lock);
+	if (ret < 0)
+		printk("dr_alloc:Cannot allocate debug register %d\n", regnum);
+	return ret;
+}
+
+int dr_free(int regnum)
+{
+	spin_lock(&dr_lock);
+	if (regnum >= DR_MAX || (!idr_find(&debugreg_idr, regnum))) {
+		spin_unlock(&dr_lock);
+		printk("dr_free:Cannot free debug register %d\n", regnum);
+		return -1;
+	}
+	if (dr_list[regnum].flag == DR_LOCAL)
+		dr_free_local(regnum);
+	else
+		dr_free_global(regnum);
+	spin_unlock(&dr_lock);
+	return 0;
+}
+
+void dr_inc_use_count(unsigned long debugreg)
+{
+	int i;
+
+	spin_lock(&dr_lock);
+	for (i = 0; i < DR_MAX; i++) {
+		if ((idr_find(&debugreg_idr, i)) && (DR_IS_LOCAL(debugreg, i)))
+			dr_list[i].use_count++;
+	}
+	spin_unlock(&dr_lock);
+}
+
+void dr_dec_use_count(unsigned long debugreg)
+{
+	int i;
+
+	spin_lock(&dr_lock);
+	for (i = 0; i < DR_MAX; i++) {
+		if ((idr_find(&debugreg_idr, i)) && (DR_IS_LOCAL(debugreg, i)))
+			dr_free_local(i);
+	}
+	spin_unlock(&dr_lock);
+}
+
+/*
+ * This routine decides if the ptrace request is for enabling or disabling
+ * a debug reg, and accordingly calls dr_alloc() or dr_free().
+ *
+ * gdb uses ptrace to write to debug registers. It assumes that writing to
+ * debug register always succeds and it doesn't check the return value of
+ * ptrace. Now with this new global debug register allocation/freeing,
+ * ptrace request for a local debug register can fail, if the required debug
+ * register is already globally allocated. Since gdb fails to notice this
+ * failure, it sometimes tries to free a debug register, which is not
+ * allocated for it.
+ */
+int enable_debugreg(unsigned long old_dr7, unsigned long new_dr7)
+{
+	int i, dr_shift = 1UL;
+	for (i = 0; i < DR_MAX; i++, dr_shift <<= 2) {
+		if ((old_dr7 ^ new_dr7) & dr_shift) {
+			if (new_dr7 & dr_shift)
+				dr_alloc(i, DR_ALLOC_LOCAL);
+			else
+				dr_free(i);
+			return 0;
+		}
+	}
+	return -1;
+}
+
+EXPORT_SYMBOL(dr_alloc);
+EXPORT_SYMBOL(dr_free);
diff -puN arch/i386/kernel/Makefile~kprobes-debug-regs arch/i386/kernel/Makefile
--- linux-2.6.13/arch/i386/kernel/Makefile~kprobes-debug-regs	2005-08-30 11:43:49.374625392 +0530
+++ linux-2.6.13-prasanna/arch/i386/kernel/Makefile	2005-08-30 11:43:49.444614752 +0530
@@ -34,6 +34,7 @@ obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+obj-$(CONFIG_DEBUGREG)		+= debugreg.o
 
 EXTRA_AFLAGS   := -traditional
 
diff -puN arch/i386/kernel/process.c~kprobes-debug-regs arch/i386/kernel/process.c
--- linux-2.6.13/arch/i386/kernel/process.c~kprobes-debug-regs	2005-08-30 11:43:49.377624936 +0530
+++ linux-2.6.13-prasanna/arch/i386/kernel/process.c	2005-08-30 11:43:49.447614296 +0530
@@ -52,6 +52,7 @@
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
+#include <asm/debugreg.h>
 
 #include <linux/irq.h>
 #include <linux/err.h>
@@ -399,6 +400,8 @@ void exit_thread(void)
 		tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
 		put_cpu();
 	}
+	if (tsk->thread.debugreg[7])
+		dr_dec_use_count(tsk->thread.debugreg[7]);
 }
 
 void flush_thread(void)
@@ -412,6 +415,8 @@ void flush_thread(void)
 	 */
 	kprobe_flush_task(tsk);
 
+	if (tsk->thread.debugreg[7])
+		dr_dec_use_count(tsk->thread.debugreg[7]);
 	memset(tsk->thread.debugreg, 0, sizeof(unsigned long)*8);
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));	
 	/*
@@ -513,6 +518,9 @@ int copy_thread(int nr, unsigned long cl
 		desc->b = LDT_entry_b(&info);
 	}
 
+	if (tsk->thread.debugreg[7])
+		dr_inc_use_count(tsk->thread.debugreg[7]);
+
 	err = 0;
  out:
 	if (err && p->thread.io_bitmap_ptr) {
@@ -676,6 +684,7 @@ struct task_struct fastcall * __switch_t
 				 *next = &next_p->thread;
 	int cpu = smp_processor_id();
 	struct tss_struct *tss = &per_cpu(init_tss, cpu);
+	unsigned long next_dr7 = next->debugreg[7];
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
@@ -713,14 +722,22 @@ struct task_struct fastcall * __switch_t
 	/*
 	 * Now maybe reload the debug registers
 	 */
-	if (unlikely(next->debugreg[7])) {
-		set_debugreg(next->debugreg[0], 0);
-		set_debugreg(next->debugreg[1], 1);
-		set_debugreg(next->debugreg[2], 2);
-		set_debugreg(next->debugreg[3], 3);
+	/*
+	 * Don't reload global debug registers. Don't touch the global debug
+	 * register settings in dr7.
+	 */
+	if (unlikely(next_dr7)) {
+		if (prev->debugreg[0] != next->debugreg[0])
+			set_debugreg(current->thread.debugreg[0], 0);
+		if (prev->debugreg[1] != next->debugreg[1])
+			set_debugreg(current->thread.debugreg[1], 1);
+		if (prev->debugreg[2] != next->debugreg[2])
+			set_debugreg(current->thread.debugreg[2], 2);
+		if (prev->debugreg[3] != next->debugreg[3])
+			set_debugreg(current->thread.debugreg[3], 3);
 		/* no 4 and 5 */
-		set_debugreg(next->debugreg[6], 6);
-		set_debugreg(next->debugreg[7], 7);
+		set_debugreg(current->thread.debugreg[6], 6);
+		load_process_dr7(next_dr7);
 	}
 
 	if (unlikely(prev->io_bitmap_ptr || next->io_bitmap_ptr))
diff -puN arch/i386/kernel/ptrace.c~kprobes-debug-regs arch/i386/kernel/ptrace.c
--- linux-2.6.13/arch/i386/kernel/ptrace.c~kprobes-debug-regs	2005-08-30 11:43:49.380624480 +0530
+++ linux-2.6.13-prasanna/arch/i386/kernel/ptrace.c	2005-08-30 11:43:49.449613992 +0530
@@ -504,6 +504,11 @@ asmlinkage int sys_ptrace(long request, 
 
 			  addr -= (long) &dummy->u_debugreg;
 			  addr = addr >> 2;
+
+			  if (addr == 7 && (enable_debugreg(child->thread.debugreg[addr], data)) < 0) {
+				  ret = -EBUSY;
+				  break;
+			  }
 			  child->thread.debugreg[addr] = data;
 			  ret = 0;
 		  }
diff -puN arch/i386/kernel/signal.c~kprobes-debug-regs arch/i386/kernel/signal.c
--- linux-2.6.13/arch/i386/kernel/signal.c~kprobes-debug-regs	2005-08-30 11:43:49.430616880 +0530
+++ linux-2.6.13-prasanna/arch/i386/kernel/signal.c	2005-08-30 11:43:49.450613840 +0530
@@ -25,6 +25,7 @@
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
+#include <asm/debugreg.h>
 #include "sigframe.h"
 
 #define DEBUG_SIG 0
@@ -622,7 +623,7 @@ int fastcall do_signal(struct pt_regs *r
 		 * inside the kernel.
 		 */
 		if (unlikely(current->thread.debugreg[7])) {
-			set_debugreg(current->thread.debugreg[7], 7);
+			load_process_dr7(current->thread.debugreg[7]);
 		}
 
 		/* Whee!  Actually deliver the signal.  */
diff -puN arch/i386/kernel/traps.c~kprobes-debug-regs arch/i386/kernel/traps.c
--- linux-2.6.13/arch/i386/kernel/traps.c~kprobes-debug-regs	2005-08-30 11:43:49.434616272 +0530
+++ linux-2.6.13-prasanna/arch/i386/kernel/traps.c	2005-08-30 11:43:49.452613536 +0530
@@ -756,7 +756,7 @@ fastcall void do_debug(struct pt_regs * 
 	 * the signal is delivered.
 	 */
 clear_dr7:
-	set_debugreg(0, 7);
+	load_process_dr7(0);
 	return;
 
 debug_vm86:
diff -puN include/asm-i386/debugreg.h~kprobes-debug-regs include/asm-i386/debugreg.h
--- linux-2.6.13/include/asm-i386/debugreg.h~kprobes-debug-regs	2005-08-30 11:43:49.437615816 +0530
+++ linux-2.6.13-prasanna/include/asm-i386/debugreg.h	2005-08-30 11:43:49.453613384 +0530
@@ -61,4 +61,193 @@
 #define DR_LOCAL_SLOWDOWN (0x100)   /* Local slow the pipeline */
 #define DR_GLOBAL_SLOWDOWN (0x200)  /* Global slow the pipeline */
 
+struct debugreg {
+	unsigned long flag;
+	unsigned long use_count;
+};
+
+/* debugreg flags */
+#define DR_UNUSED	0
+#define DR_LOCAL	1
+#define DR_GLOBAL	2
+
+#define DR_MAX	4
+#define DR_ANY	DR_MAX + 1
+
+/* global or local allocation requests */
+#define DR_ALLOC_GLOBAL		0
+#define DR_ALLOC_LOCAL		1
+
+#define DR7_RW_SET(dr7, regnum, rw) do {	\
+		(dr7) &= ~(0x3 << (16 + (4 * (regnum)))); \
+		(dr7) |= (((rw) & 0x3) << (16 + (4 * (regnum)))); \
+	} while (0)
+
+#define DR7_RW_VAL(dr7, regnum) \
+	(((dr7) >> (16 + (4 * (regnum)))) & 0x3)
+
+#define DR7_LEN_SET(dr7, regnum, len) do { \
+		(dr7) &= ~(0x3 << (18 + (4 * (regnum)))); \
+		(dr7) |= (((len-1) & 0x3) << (18 + (4 * (regnum)))); \
+	} while (0)
+
+#define DR7_LEN_VAL(dr7, regnum) \
+	(((dr7) >> (18 + (4 * (regnum)))) & 0x3)
+
+#define DR7_L0(dr0)    (((dr0))&0x1)
+#define DR7_L1(dr1)    (((dr1)>>2)&0x1)
+#define DR7_L2(dr2)    (((dr2)>>4)&0x1)
+#define DR7_L3(dr3)    (((dr3)>>6)&0x1)
+
+/* Check if local breakpoint is enabled */
+#define DR_IS_LOCAL(dr7, regnum) ((dr7) & (1UL << (regnum <<1)))
+
+/* Set the rw, len and global flag in dr7 for a debug register */
+#define SET_DR7(dr7, regnum, access, len) do { \
+		DR7_RW_SET(dr7, regnum, access); \
+		DR7_LEN_SET(dr7, regnum, len); \
+		dr7 |= (2UL << regnum*2); \
+	} while (0)
+
+/* Disable a debug register by clearing the global/local flag in dr7 */
+#define RESET_DR7(dr7, regnum) dr7 &= ~(3UL << regnum*2)
+
+#define DR_IS_ADDR(regnum) (0xf & (1 << (regnum)))
+
+#define DR7_DR0_BITS		0x000F0003
+#define DR7_DR1_BITS		0x00F0000C
+#define DR7_DR2_BITS		0x0F000030
+#define DR7_DR3_BITS		0xF00000C0
+
+#define DR_TRAP_MASK 		0xF
+
+#define DR_TYPE_EXECUTE 	0x0
+#define DR_TYPE_WRITE		0x1
+#define DR_TYPE_IO		0x2
+#define DR_TYPE_RW		0x3
+
+#define get_dr(regnum, val) get_debugreg(val, regnum)
+
+static inline unsigned long read_dr(int regnum)
+{
+	unsigned long val = 0;
+	switch (regnum) {
+	case 0:
+		get_dr(0, val);
+		break;
+	case 1:
+		get_dr(1, val);
+		break;
+	case 2:
+		get_dr(2, val);
+		break;
+	case 3:
+		get_dr(3, val);
+		break;
+	case 6:
+		get_dr(6, val);
+		break;
+	case 7:
+		get_dr(7, val);
+		break;
+	}
+	return val;
+}
+
+#undef get_dr
+
+static inline void write_dr(int regnum, unsigned long val)
+{
+	switch (regnum) {
+	case 0:
+		set_debugreg(val, 0);
+		break;
+	case 1:
+		set_debugreg(val, 1);
+		break;
+	case 2:
+		set_debugreg(val, 2);
+		break;
+	case 3:
+		set_debugreg(val, 3);
+		break;
+	case 7:
+		set_debugreg(val, 7);
+		break;
+	}
+}
+
+#ifdef CONFIG_DEBUGREG
+/*
+ * Given the debug status register, returns the debug register number
+ * which caused the debug trap.
+ */
+static inline int dr_trap(unsigned int condition)
+{
+	int i, reg_shift = 1UL;
+	for (i = 0; i < DR_MAX; i++, reg_shift <<= 1)
+		if ((condition & reg_shift))
+			return i;
+	return -1;
+}
+
+/*
+ * Given the debug status register, returns the address due to which
+ * the debug trap occured.
+ */
+static inline unsigned long dr_trap_addr(unsigned int condition)
+{
+	int regnum = dr_trap(condition);
+
+	if (regnum == -1)
+		return -1;
+	return read_dr(regnum);
+}
+
+/*
+ * Given the debug status register, returns the type of debug trap:
+ * execute, read/write, write or io.
+ */
+static inline int dr_trap_type(unsigned int condition)
+{
+	int regnum = dr_trap(condition);
+
+	if (regnum == -1)
+		return -1;
+	return DR7_RW_VAL(read_dr(7), regnum);
+}
+
+/* Function declarations */
+
+extern int dr_alloc(int regnum, int flag);
+extern int dr_free(int regnum);
+extern void dr_inc_use_count(unsigned long mask);
+extern void dr_dec_use_count(unsigned long mask);
+extern struct debugreg dr_list[DR_MAX];
+extern unsigned long dr7_global_mask;
+extern int enable_debugreg(unsigned long old_dr7, unsigned long new_dr7);
+
+static inline void load_process_dr7(unsigned long curr_dr7)
+{
+	write_dr(7, (read_dr(7) & dr7_global_mask) | curr_dr7);
+}
+#else
+static inline int enable_debugreg(unsigned long old_dr7, unsigned long new_dr7)
+{
+	return 0;
+}
+static inline void load_process_dr7(unsigned long curr_dr7)
+{
+	write_dr(7, curr_dr7);
+}
+
+static void dr_inc_use_count(unsigned long mask)
+{
+}
+
+static void dr_dec_use_count(unsigned long mask)
+{
+}
+
+#endif				/* CONFIG_DEBUGREG */
 #endif

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
