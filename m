Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262442AbSJVKvg>; Tue, 22 Oct 2002 06:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbSJVKvg>; Tue, 22 Oct 2002 06:51:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:3818 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262442AbSJVKvZ>;
	Tue, 22 Oct 2002 06:51:25 -0400
Date: Tue, 22 Oct 2002 16:41:08 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: rusty@rustcorp.com.au, richard <richardj_moore@uk.ibm.com>,
       tom <hanharat@us.ibm.com>, suparna@in.ibm.com,
       bharata <bharata@in.ibm.com>
Subject: [patch 2/4] kprobes - debug register management for 2.5.44
Message-ID: <20021022164108.B26617@in.ibm.com>
Reply-To: vamsi@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch to provide global debug registers support on ia32.
Debug registers are global resources and unless they are allocated
and freed when needed we will end up overwriting somebody else's
settings.

While this is not absolutely essential for kernel watchpoints,
it is needed for its correct functioning.

2.5 specific changes include:
- lots of code cleanup
- s/CONFIG_DR_ALLOC/CONFIG_DEBUGREG
- kill lots of #ifdefs in .c files
- consolidate all dr stuff in include/asm-i386/debugreg.h

This patches applies on top of kprobes base.
-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
--
diff -urN -X /home/vamsi/.dontdiff 44-pure/arch/i386/config.in 44-kprobes/arch/i386/config.in
--- 44-pure/arch/i386/config.in	2002-10-22 12:52:07.000000000 +0530
+++ 44-kprobes/arch/i386/config.in	2002-10-22 12:38:18.000000000 +0530
@@ -457,6 +457,7 @@
 
 bool 'Kernel debugging' CONFIG_DEBUG_KERNEL
 if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; then
+   bool '  Global Debug Registers' CONFIG_DEBUGREG
    bool '  Check for stack overflows' CONFIG_DEBUG_STACKOVERFLOW
    bool '  Debug memory allocations' CONFIG_DEBUG_SLAB
    bool '  Memory mapped I/O debugging' CONFIG_DEBUG_IOVIRT
diff -urN -X /home/vamsi/.dontdiff 44-pure/arch/i386/kernel/debugreg.c 44-kprobes/arch/i386/kernel/debugreg.c
--- 44-pure/arch/i386/kernel/debugreg.c	1970-01-01 05:30:00.000000000 +0530
+++ 44-kprobes/arch/i386/kernel/debugreg.c	2002-10-22 12:37:52.000000000 +0530
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
diff -urN -X /home/vamsi/.dontdiff 44-pure/arch/i386/kernel/Makefile 44-kprobes/arch/i386/kernel/Makefile
--- 44-pure/arch/i386/kernel/Makefile	2002-10-22 12:52:07.000000000 +0530
+++ 44-kprobes/arch/i386/kernel/Makefile	2002-10-22 12:37:52.000000000 +0530
@@ -4,7 +4,7 @@
 
 EXTRA_TARGETS := head.o init_task.o
 
-export-objs     := mca.o i386_ksyms.o time.o
+export-objs     := mca.o i386_ksyms.o time.o debugreg.o
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
@@ -30,6 +30,7 @@
 obj-$(CONFIG_PROFILING)		+= profile.o
 obj-$(CONFIG_EDD)             	+= edd.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
+obj-$(CONFIG_DEBUGREG)		+= debugreg.o
 
 EXTRA_AFLAGS   := -traditional
 
diff -urN -X /home/vamsi/.dontdiff 44-pure/arch/i386/kernel/process.c 44-kprobes/arch/i386/kernel/process.c
--- 44-pure/arch/i386/kernel/process.c	2002-10-19 09:30:42.000000000 +0530
+++ 44-kprobes/arch/i386/kernel/process.c	2002-10-22 12:37:52.000000000 +0530
@@ -46,6 +46,7 @@
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
+#include <asm/debugreg.h>
 
 #include <linux/irq.h>
 #include <linux/err.h>
@@ -240,12 +241,16 @@
 		kfree(tsk->thread.ts_io_bitmap);
 		tsk->thread.ts_io_bitmap = NULL;
 	}
+	if (tsk->thread.debugreg[7])
+		dr_dec_use_count(tsk->thread.debugreg[7]);
 }
 
 void flush_thread(void)
 {
 	struct task_struct *tsk = current;
 
+	if (tsk->thread.debugreg[7])
+		dr_dec_use_count(tsk->thread.debugreg[7]); 
 	memset(tsk->thread.debugreg, 0, sizeof(unsigned long)*8);
 	/*
 	 * Forget coprocessor state..
@@ -328,6 +333,9 @@
 		desc->a = LDT_entry_a(&info);
 		desc->b = LDT_entry_b(&info);
 	}
+
+	if (current->thread.debugreg[7])
+		dr_inc_use_count(current->thread.debugreg[7]);
 	return 0;
 }
 
@@ -443,6 +451,24 @@
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
@@ -452,7 +478,7 @@
 		loaddebug(next, 6);
 		loaddebug(next, 7);
 	}
-
+#endif		
 	if (unlikely(prev->ts_io_bitmap || next->ts_io_bitmap)) {
 		if (next->ts_io_bitmap) {
 			/*
diff -urN -X /home/vamsi/.dontdiff 44-pure/arch/i386/kernel/ptrace.c 44-kprobes/arch/i386/kernel/ptrace.c
--- 44-pure/arch/i386/kernel/ptrace.c	2002-10-19 09:31:19.000000000 +0530
+++ 44-kprobes/arch/i386/kernel/ptrace.c	2002-10-22 12:37:52.000000000 +0530
@@ -269,6 +269,11 @@
 
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
diff -urN -X /home/vamsi/.dontdiff 44-pure/arch/i386/kernel/signal.c 44-kprobes/arch/i386/kernel/signal.c
--- 44-pure/arch/i386/kernel/signal.c	2002-10-19 09:31:52.000000000 +0530
+++ 44-kprobes/arch/i386/kernel/signal.c	2002-10-22 12:37:52.000000000 +0530
@@ -22,6 +22,7 @@
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
+#include <asm/debugreg.h>
 
 #define DEBUG_SIG 0
 
@@ -574,7 +575,7 @@
 		 * have been cleared if the watchpoint triggered
 		 * inside the kernel.
 		 */
-		__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
+		load_process_dr7(current->thread.debugreg[7]);
 
 		/* Whee!  Actually deliver the signal.  */
 		handle_signal(signr, &info, oldset, regs);
diff -urN -X /home/vamsi/.dontdiff 44-pure/arch/i386/kernel/traps.c 44-kprobes/arch/i386/kernel/traps.c
--- 44-pure/arch/i386/kernel/traps.c	2002-10-22 12:52:07.000000000 +0530
+++ 44-kprobes/arch/i386/kernel/traps.c	2002-10-22 12:37:52.000000000 +0530
@@ -641,9 +641,7 @@
 	 * the signal is delivered.
 	 */
 clear_dr7:
-	__asm__("movl %0,%%db7"
-		: /* no output */
-		: "r" (0));
+	load_process_dr7(0);
 	return 0;
 
 debug_vm86:
diff -urN -X /home/vamsi/.dontdiff 44-pure/include/asm-i386/debugreg.h 44-kprobes/include/asm-i386/debugreg.h
--- 44-pure/include/asm-i386/debugreg.h	2002-10-19 09:32:27.000000000 +0530
+++ 44-kprobes/include/asm-i386/debugreg.h	2002-10-22 12:37:52.000000000 +0530
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
+#ifdef CONFIG_DEBUGREG
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
+static inline void void load_process_dr7(unsigned long curr_dr7)
+{
+	write_dr(7, curr_dr7);
+}
+
+static void dr_inc_use_count(unsigned long mask) { }
+static void dr_dec_use_count(unsigned long mask) { }
+
+#endif /* CONFIG_DEBUGREG */
 #endif
