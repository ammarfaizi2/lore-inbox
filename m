Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUJRIqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUJRIqj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 04:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUJRIqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 04:46:38 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:56773 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264991AbUJRIow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 04:44:52 -0400
Date: Mon, 18 Oct 2004 14:15:25 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>, ak@muc.de,
       suparna@in.ibm.com
Subject: Re: [1/2] PATCH Kernel watchpoint interface-2.6.9-rc4-mm1
Message-ID: <20041018084525.GA27936@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20041018084312.GG27204@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041018084312.GG27204@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides global debug register settings.
Used by kernel watchpoint interface patch.
---
Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


---

 linux-2.6.9-rc4-prasanna/arch/i386/Kconfig.debug     |    7 
 linux-2.6.9-rc4-prasanna/arch/i386/kernel/Makefile   |    1 
 linux-2.6.9-rc4-prasanna/arch/i386/kernel/debugreg.c |  178 +++++++++++++++++++
 linux-2.6.9-rc4-prasanna/arch/i386/kernel/process.c  |   28 ++
 linux-2.6.9-rc4-prasanna/arch/i386/kernel/ptrace.c   |    5 
 linux-2.6.9-rc4-prasanna/arch/i386/kernel/signal.c   |    3 
 linux-2.6.9-rc4-prasanna/arch/i386/kernel/traps.c    |    4 
 linux-2.6.9-rc4-prasanna/include/asm-i386/debugreg.h |  162 +++++++++++++++++
 8 files changed, 383 insertions(+), 5 deletions(-)

diff -puN arch/i386/Kconfig.debug~kprobes-debug-regs-2.6.9-rc4-mm1 arch/i386/Kconfig.debug
--- linux-2.6.9-rc4/arch/i386/Kconfig.debug~kprobes-debug-regs-2.6.9-rc4-mm1	2004-10-18 13:49:18.000000000 +0530
+++ linux-2.6.9-rc4-prasanna/arch/i386/Kconfig.debug	2004-10-18 13:49:28.000000000 +0530
@@ -29,6 +29,13 @@ config KPROBES
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
 
+config DEBUGREG
+	bool "Global Debug Registers"
+	depends on DEBUG_KERNEL
+	help
+	  Global debug register settings will be honoured if this is turned on.
+	  If in doubt, say "N".
+
 config DEBUG_STACK_USAGE
 	bool "Stack utilization instrumentation"
 	depends on DEBUG_KERNEL
diff -puN /dev/null arch/i386/kernel/debugreg.c
--- /dev/null	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.9-rc4-prasanna/arch/i386/kernel/debugreg.c	2004-10-18 13:49:18.000000000 +0530
@@ -0,0 +1,178 @@
+/*
+ * This provides a debug register allocation mechanism, to be
+ * used by all debuggers, which need debug registers.
+ *
+ * Author: vamsi_krishna@in.ibm.com
+ *	   bharata@in.ibm.com
+ */
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <asm/system.h>
+#include <asm/debugreg.h>
+
+struct debugreg dr_list[DR_MAX];
+unsigned long dr7_global_mask = 0;
+static spinlock_t dr_lock = SPIN_LOCK_UNLOCKED;
+
+static inline void set_dr7_global_mask(int regnum)
+{
+	switch (regnum) {
+		case 0: dr7_global_mask |= DR7_DR0_BITS; break;
+		case 1: dr7_global_mask |= DR7_DR1_BITS; break;
+		case 2: dr7_global_mask |= DR7_DR2_BITS; break;
+		case 3: dr7_global_mask |= DR7_DR3_BITS; break;
+	}
+	return;
+}
+
+static inline void clear_dr7_global_mask(int regnum)
+{
+	switch (regnum) {
+		case 0: dr7_global_mask &= ~DR7_DR0_BITS; break;
+		case 1: dr7_global_mask &= ~DR7_DR1_BITS; break;
+		case 2: dr7_global_mask &= ~DR7_DR2_BITS; break;
+		case 3: dr7_global_mask &= ~DR7_DR3_BITS; break;
+	}
+	return;
+}
+
+static int get_dr(int regnum, int flag)
+{
+	if ((flag == DR_ALLOC_GLOBAL) && (dr_list[regnum].flag == DR_UNUSED)) {
+		dr_list[regnum].flag = DR_GLOBAL;
+		set_dr7_global_mask(regnum);
+		return regnum;
+	}
+	else if ((dr_list[regnum].flag == DR_UNUSED) || (dr_list[regnum].flag == DR_LOCAL)) {
+		dr_list[regnum].use_count++;
+		dr_list[regnum].flag = DR_LOCAL;
+		return regnum;
+	}
+	return -1;
+}
+
+static int get_any_dr(int flag)
+{
+	int i;
+	if (flag == DR_ALLOC_LOCAL) {
+		for (i = 0; i < DR_MAX; i++) {
+			if (dr_list[i].flag == DR_LOCAL) {
+				dr_list[i].use_count++;
+				return i;
+			} else if (dr_list[i].flag == DR_UNUSED) {
+				dr_list[i].flag = DR_LOCAL;
+				dr_list[i].use_count = 1;
+				return i;
+			}
+		}
+	} else {
+		for (i = DR_MAX-1; i >= 0; i--) {
+			if (dr_list[i].flag == DR_UNUSED) {
+				dr_list[i].flag = DR_GLOBAL;
+				set_dr7_global_mask(i);
+				return i;
+			}
+		}
+	}
+	return -1;
+}
+
+static inline void dr_free_local(int regnum)
+{
+	if (! (--dr_list[regnum].use_count))
+		dr_list[regnum].flag = DR_UNUSED;
+	return;
+}
+
+static inline void dr_free_global(int regnum)
+{
+	dr_list[regnum].flag = DR_UNUSED;
+	dr_list[regnum].use_count = 0;
+	clear_dr7_global_mask(regnum);
+	return;
+}
+
+int dr_alloc(int regnum, int flag)
+{
+	int ret;
+
+	spin_lock(&dr_lock);
+	if (regnum == DR_ANY)
+		ret = get_any_dr(flag);
+	else if (regnum >= DR_MAX)
+		ret = -1;
+	else
+		ret = get_dr(regnum, flag);
+	spin_unlock(&dr_lock);
+	return ret;
+}
+
+int dr_free(int regnum)
+{
+	spin_lock(&dr_lock);
+	if (regnum >= DR_MAX || dr_list[regnum].flag == DR_UNUSED) {
+		spin_unlock(&dr_lock);
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
+void dr_inc_use_count(unsigned long mask)
+{
+	int i;
+
+	spin_lock(&dr_lock);
+	for (i =0; i < DR_MAX; i++) {
+		if (DR_IS_LOCAL(mask, i))
+			dr_list[i].use_count++;
+	}
+	spin_unlock(&dr_lock);
+}
+
+void dr_dec_use_count(unsigned long mask)
+{
+	int i;
+
+	spin_lock(&dr_lock);
+	for (i =0; i < DR_MAX; i++) {
+		if (DR_IS_LOCAL(mask, i))
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
diff -puN arch/i386/kernel/Makefile~kprobes-debug-regs-2.6.9-rc4-mm1 arch/i386/kernel/Makefile
--- linux-2.6.9-rc4/arch/i386/kernel/Makefile~kprobes-debug-regs-2.6.9-rc4-mm1	2004-10-18 13:49:18.000000000 +0530
+++ linux-2.6.9-rc4-prasanna/arch/i386/kernel/Makefile	2004-10-18 13:49:28.000000000 +0530
@@ -35,6 +35,7 @@ obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+obj-$(CONFIG_DEBUGREG)		+= debugreg.o
 
 EXTRA_AFLAGS   := -traditional
 
diff -puN arch/i386/kernel/process.c~kprobes-debug-regs-2.6.9-rc4-mm1 arch/i386/kernel/process.c
--- linux-2.6.9-rc4/arch/i386/kernel/process.c~kprobes-debug-regs-2.6.9-rc4-mm1	2004-10-18 13:49:18.000000000 +0530
+++ linux-2.6.9-rc4-prasanna/arch/i386/kernel/process.c	2004-10-18 13:49:18.000000000 +0530
@@ -50,6 +50,7 @@
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
+#include <asm/debugreg.h>
 
 #include <linux/irq.h>
 #include <linux/err.h>
@@ -317,6 +318,8 @@ void exit_thread(void)
 		tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
 		put_cpu();
 	}
+	if (tsk->thread.debugreg[7])
+		dr_dec_use_count(tsk->thread.debugreg[7]);
 	perfctr_exit_thread(&tsk->thread);
 }
 
@@ -324,6 +327,8 @@ void flush_thread(void)
 {
 	struct task_struct *tsk = current;
 
+	if (tsk->thread.debugreg[7])
+		dr_dec_use_count(tsk->thread.debugreg[7]);
 	memset(tsk->thread.debugreg, 0, sizeof(unsigned long)*8);
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));	
 	/*
@@ -416,6 +421,9 @@ int copy_thread(int nr, unsigned long cl
 		desc->b = LDT_entry_b(&info);
 	}
 
+	if (tsk->thread.debugreg[7])
+		dr_inc_use_count(tsk->thread.debugreg[7]);
+
 	err = 0;
  out:
 	if (err && p->thread.io_bitmap_ptr) {
@@ -593,6 +601,24 @@ struct task_struct fastcall * __switch_t
 	/*
 	 * Now maybe reload the debug registers
 	 */
+#ifdef CONFIG_DEBUGREG
+{
+	/*
+	 * Don't reload global debug registers. Don't touch the global debug
+	 * register settings in dr7.
+	 */
+	unsigned long next_dr7 = next->debugreg[7];
+	if (unlikely(next_dr7)) {
+		if (DR7_L0(next_dr7)) loaddebug(next, 0);
+		if (DR7_L1(next_dr7)) loaddebug(next, 1);
+		if (DR7_L2(next_dr7)) loaddebug(next, 2);
+		if (DR7_L3(next_dr7)) loaddebug(next, 3);
+		/* no 4 and 5 */
+		loaddebug(next, 6);
+		load_process_dr7(next_dr7);
+	}
+}
+#else
 	if (unlikely(next->debugreg[7])) {
 		loaddebug(next, 0);
 		loaddebug(next, 1);
@@ -602,7 +628,7 @@ struct task_struct fastcall * __switch_t
 		loaddebug(next, 6);
 		loaddebug(next, 7);
 	}
-
+#endif
 	if (unlikely(prev->io_bitmap_ptr || next->io_bitmap_ptr))
 		handle_io_bitmap(next, tss);
 
diff -puN arch/i386/kernel/ptrace.c~kprobes-debug-regs-2.6.9-rc4-mm1 arch/i386/kernel/ptrace.c
--- linux-2.6.9-rc4/arch/i386/kernel/ptrace.c~kprobes-debug-regs-2.6.9-rc4-mm1	2004-10-18 13:49:18.000000000 +0530
+++ linux-2.6.9-rc4-prasanna/arch/i386/kernel/ptrace.c	2004-10-18 13:49:18.000000000 +0530
@@ -353,6 +353,11 @@ asmlinkage int sys_ptrace(long request, 
 
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
diff -puN arch/i386/kernel/signal.c~kprobes-debug-regs-2.6.9-rc4-mm1 arch/i386/kernel/signal.c
--- linux-2.6.9-rc4/arch/i386/kernel/signal.c~kprobes-debug-regs-2.6.9-rc4-mm1	2004-10-18 13:49:18.000000000 +0530
+++ linux-2.6.9-rc4-prasanna/arch/i386/kernel/signal.c	2004-10-18 13:49:18.000000000 +0530
@@ -25,6 +25,7 @@
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
+#include <asm/debugreg.h>
 #include "sigframe.h"
 
 #define DEBUG_SIG 0
@@ -600,7 +601,7 @@ int fastcall do_signal(struct pt_regs *r
 		 * have been cleared if the watchpoint triggered
 		 * inside the kernel.
 		 */
-		__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
+		load_process_dr7(current->thread.debugreg[7]);
 
 		/* Whee!  Actually deliver the signal.  */
 		handle_signal(signr, &info, &ka, oldset, regs);
diff -puN arch/i386/kernel/traps.c~kprobes-debug-regs-2.6.9-rc4-mm1 arch/i386/kernel/traps.c
--- linux-2.6.9-rc4/arch/i386/kernel/traps.c~kprobes-debug-regs-2.6.9-rc4-mm1	2004-10-18 13:49:18.000000000 +0530
+++ linux-2.6.9-rc4-prasanna/arch/i386/kernel/traps.c	2004-10-18 13:49:28.000000000 +0530
@@ -812,9 +812,7 @@ asmlinkage void do_debug(struct pt_regs 
 	 * the signal is delivered.
 	 */
 clear_dr7:
-	__asm__("movl %0,%%db7"
-		: /* no output */
-		: "r" (0));
+	load_process_dr7(0);
 	CHK_REMOTE_DEBUG(1,SIGTRAP,error_code,regs,)
 	return;
 
diff -puN include/asm-i386/debugreg.h~kprobes-debug-regs-2.6.9-rc4-mm1 include/asm-i386/debugreg.h
--- linux-2.6.9-rc4/include/asm-i386/debugreg.h~kprobes-debug-regs-2.6.9-rc4-mm1	2004-10-18 13:49:18.000000000 +0530
+++ linux-2.6.9-rc4-prasanna/include/asm-i386/debugreg.h	2004-10-18 13:49:18.000000000 +0530
@@ -61,4 +61,166 @@
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
+#define DR7_RW_SET(dr, regnum, rw) do {	\
+		(dr) &= ~(0x3 << (16 + (4 * (regnum)))); \
+		(dr) |= (((rw) & 0x3) << (16 + (4 * (regnum)))); \
+	} while (0)
+
+#define DR7_RW_VAL(dr, regnum) \
+	(((dr) >> (16 + (4 * (regnum)))) & 0x3)
+
+#define DR7_LEN_SET(dr, regnum, len) do { \
+		(dr) &= ~(0x3 << (18 + (4 * (regnum)))); \
+		(dr) |= (((len-1) & 0x3) << (18 + (4 * (regnum)))); \
+	} while (0)
+
+#define DR7_LEN_VAL(dr, regnum) \
+	(((dr) >> (18 + (4 * (regnum)))) & 0x3)
+
+#define DR7_L0(dr)    (((dr))&0x1)
+#define DR7_L1(dr)    (((dr)>>2)&0x1)
+#define DR7_L2(dr)    (((dr)>>4)&0x1)
+#define DR7_L3(dr)    (((dr)>>6)&0x1)
+
+#define DR_IS_LOCAL(dr, num) ((dr) & (1UL << (num <<1)))
+
+/* Set the rw, len and global flag in dr7 for a debug register */
+#define SET_DR7(dr, regnum, access, len) do { \
+		DR7_RW_SET(dr, regnum, access); \
+		DR7_LEN_SET(dr, regnum, len); \
+		dr |= (2UL << regnum*2); \
+	} while (0)
+
+/* Disable a debug register by clearing the global/local flag in dr7 */
+#define RESET_DR7(dr, regnum) dr &= ~(3UL << regnum*2)
+
+#define DR7_DR0_BITS		0x000F0003
+#define DR7_DR1_BITS		0x00F0000C
+#define DR7_DR2_BITS		0x0F000030
+#define DR7_DR3_BITS		0xF00000C0
+
+#define DR_TRAP_MASK 		0xF
+
+#define DR_TYPE_EXECUTE		0x0
+#define DR_TYPE_WRITE		0x1
+#define DR_TYPE_IO		0x2
+#define DR_TYPE_RW		0x3
+
+#define get_dr(regnum, val) \
+		__asm__("movl %%db" #regnum ", %0"  \
+			:"=r" (val))
+static inline unsigned long read_dr(int regnum)
+{
+	unsigned long val = 0;
+	switch (regnum) {
+		case 0: get_dr(0, val); break;
+		case 1: get_dr(1, val); break;
+		case 2: get_dr(2, val); break;
+		case 3: get_dr(3, val); break;
+		case 6: get_dr(6, val); break;
+		case 7: get_dr(7, val); break;
+	}
+	return val;
+}
+#undef get_dr
+
+#define set_dr(regnum, val) \
+		__asm__("movl %0,%%db" #regnum  \
+			: /* no output */ \
+			:"r" (val))
+static inline void write_dr(int regnum, unsigned long val)
+{
+	switch (regnum) {
+		case 0: set_dr(0, val); break;
+		case 1: set_dr(1, val); break;
+		case 2: set_dr(2, val); break;
+		case 3: set_dr(3, val); break;
+		case 7: set_dr(7, val); break;
+	}
+	return;
+}
+#undef set_dr
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
+static inline int enable_debugreg(unsigned long old_dr7, unsigned long new_dr7) { return 0; }
+static inline void load_process_dr7(unsigned long curr_dr7)
+{
+	write_dr(7, curr_dr7);
+}
+
+static void dr_inc_use_count(unsigned long mask) { }
+static void dr_dec_use_count(unsigned long mask) { }
+
+#endif /* CONFIG_DEBUGREG */
 #endif

_
Thanks
Prasanna
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
