Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130940AbRDCK5k>; Tue, 3 Apr 2001 06:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131158AbRDCK5b>; Tue, 3 Apr 2001 06:57:31 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:38812 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S131600AbRDCK5N>; Tue, 3 Apr 2001 06:57:13 -0400
Date: Tue, 3 Apr 2001 16:28:28 +0530
From: "Bharata B . Rao" <rbharata@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: dprobes@dwoss.lotus.com
Subject: [RFC][PATCH] Debug Register Allocation on x86
Message-ID: <20010403162828.A4857@in.ibm.com>
Reply-To: dprobes@dwoss.lotus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, debug register settings in Linux are per-process. This is all that 
is needed for debugging (user space) processes. However, tools that can be 
used to debug the kernel (none at present in the stock kernel, but available 
as external patches like SGI KDB and IBM Dynamic Probes) need debug register 
settings that are "global" in nature and require them to be preserved across 
context switches. These facilities currently operate on the presumption that 
they are the only users of the debug registers. This is clearly wrong and 
leads to interoperability problems when two or more debugging facilities are 
active on the system, as they could end up overwriting each other's debug 
register settings without being aware of it, leading to unexpected results.

Here is a patch to the 2.4.2 kernel that provides interfaces to allocate and 
free debug registers. This enables the debug registers to be treated as a 
resource that can shared among multiple facilities, without unexpected 
behaviour when two facilities are active at the same time.

int dr_alloc(int dr_num_requested, int local_or_global)
int dr_free(int dr_num)

This patch helps coordinate the allocation of hardware debug registers amongst 
multiple debugging facilities, kernel space as well as user space. The 
interfaces provided can be used to allocate debug registers for both "local" 
(process-context specific) usage, applied via ptrace by user mode debuggers 
like gdb, as well as for "global" usage by kernel debugging facilities. Debug 
registers allocated for local usage can be allocated to multiple processes 
where as those allocated for global usage can be allocated only to one debug 
facility at a time. We ensure that global debug register settings are 
preserved across context switches.

NOTE:  The patch, at present is minimalist in nature. It only facilitates 
different debug tools in selecting debug register(s) that are not in use.
It is currently up to the debug tools themselves to handle the actual updates 
to the registers, propagate them to other processors in an SMP system if 
required, and to hook into the systems debug exception handler to identify and 
act on exceptions generated due to their debug registers. Since these 
requirements exist for any component that uses debug registers, we are 
considering building on the basic patch to provide these features as well for 
a more complete debug register management API, if there is sufficient 
interest. 

The watchpoint probes feature in Dynamic Probes v2.0 makes use of the 
interfaces provided in this patch to set up global watchpoints that work 
consistently even in the presence of user mode debuggers already using 
hardware watchpoints. If other debugging facilities like KDB also use this 
interface to reserve debug registers, then DProbes watchpoints could coexist 
with kdb watchpoints as well with consistent behaviour.

Kernel changes:
- new dr_alloc/dr_free infrastructure
- ptrace modified to make use of dr_alloc/dr_free
- switch_to now reloads only the debug registers with local watchpoint 
  settings on a task-switch
- signal handling restores the debug register settings only for local debug 
  register settings 
- reference count for a debug register having local watchpoint settings is 
  incremented when a process is cloned and decremented when a process exits

Caveats:
- gdb doesn't check for failures in setting debug registers today

Todos:
- we don't yet handle multiple registers being enabled in a single ptrace call 
  (not a problem with gdb today)
- consider allocating registers in the reverse order for global watchpoints 
  (to reduce chances of allocation failures for gdb, which relies on being able 
  to use a fixed debug register)

Kernel debug facilities that could use this:
http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes/
http://oss.sgi.com/projects/kdb/

Regards
Bharata B. Rao.
IBM Dynamic Probes Team


diff -urN linux-2.4.2/arch/i386/config.in linux-2.4.2+dr/arch/i386/config.in
--- linux-2.4.2/arch/i386/config.in	Tue Jan  9 02:57:56 2001
+++ linux-2.4.2+dr/arch/i386/config.in	Tue Apr  3 15:56:17 2001
@@ -366,4 +366,5 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'x86 Global/Local Debug Register Management (IBM)' CONFIG_DR_ALLOC
 endmenu
diff -urN linux-2.4.2/arch/i386/kernel/Makefile linux-2.4.2+dr/arch/i386/kernel/Makefile
--- linux-2.4.2/arch/i386/kernel/Makefile	Sat Dec 30 04:05:47 2000
+++ linux-2.4.2+dr/arch/i386/kernel/Makefile	Tue Apr  3 15:56:17 2001
@@ -40,5 +40,6 @@
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o mpparse.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
+obj-$(CONFIG_DR_ALLOC)	+= dr_alloc.o
 
 include $(TOPDIR)/Rules.make
diff -urN linux-2.4.2/arch/i386/kernel/dr_alloc.c linux-2.4.2+dr/arch/i386/kernel/dr_alloc.c
--- linux-2.4.2/arch/i386/kernel/dr_alloc.c	Thu Jan  1 05:30:00 1970
+++ linux-2.4.2+dr/arch/i386/kernel/dr_alloc.c	Tue Apr  3 15:56:16 2001
@@ -0,0 +1,248 @@
+/*
+ * This is a debug register allocation mechanism, to be used by
+ * all debuggers, which use debug registers.
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
+ */
+
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+
+#include <asm/system.h>
+#include <asm/debugreg.h>
+#include <asm/dr_alloc.h>
+
+struct dr_struct dr_list[DR_MAX];
+unsigned long dr7_global_mask = 0;
+static spinlock_t dr_lock = SPIN_LOCK_UNLOCKED;
+
+static inline void set_dr7_global_mask(int regnum) 
+{
+	switch(regnum) {
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
+	switch(regnum) {
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
+	if (flag) {
+		for (i = 0; i < DR_MAX; i++) {
+			if (dr_list[i].flag == DR_LOCAL) {
+				dr_list[i].use_count++;
+				return i;
+			}
+		}
+	}
+	for (i = 0; i < DR_MAX; i++) {
+		if (dr_list[i].flag == DR_UNUSED) {
+			if (flag) {
+				dr_list[i].flag = DR_LOCAL;
+				dr_list[i].use_count = 1;
+			}
+			else {
+				dr_list[i].flag = DR_GLOBAL;
+				set_dr7_global_mask(i);
+			}
+			return i;
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
+	unsigned long flags;
+	spin_lock_irqsave(&dr_lock, flags);
+	if (regnum == DR_ANY) 
+		ret = get_any_dr(flag);
+	else if (regnum >= DR_MAX)
+		ret = -1;
+	else
+		ret = get_dr(regnum, flag);
+	spin_unlock_irqrestore(&dr_lock, flags);
+	return ret;
+}
+
+int dr_free(int regnum)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&dr_lock, flags);
+	if (regnum >= DR_MAX || dr_list[regnum].flag == DR_UNUSED) {
+		spin_unlock_irqrestore(&dr_lock, flags);
+		return -1;
+	}
+	if (dr_list[regnum].flag == DR_LOCAL) 
+		dr_free_local(regnum);
+	else 
+		dr_free_global(regnum);
+	spin_unlock_irqrestore(&dr_lock, flags);
+	return 0;
+}
+
+int dr_inc_use_count(unsigned long mask)
+{
+	int i;
+	unsigned long flags;
+	
+	spin_lock_irqsave(&dr_lock, flags);
+	for (i =0; i < DR_MAX; i++) {
+		if (DR_IS_LOCAL(mask, i))
+			dr_list[i].use_count++;
+	}
+	spin_unlock_irqrestore(&dr_lock, flags);
+	return 0;
+}
+
+int dr_dec_use_count(unsigned long mask)
+{
+	int i;
+	unsigned long flags;
+	
+	spin_lock_irqsave(&dr_lock, flags);
+	for (i =0; i < DR_MAX; i++) {
+		if (DR_IS_LOCAL(mask, i))
+			dr_free_local(i);
+	}
+	spin_unlock_irqrestore(&dr_lock, flags);
+	return 0;
+}
+
+#define set_dr(regnum, val) \
+		__asm__("movl %0,%%db" #regnum  \
+			: /* no output */ \
+			:"r" (val))
+void write_dr(int regnum, unsigned long val)
+{
+	switch(regnum) {
+		case 0: set_dr(0, val); break;
+		case 1: set_dr(1, val); break;
+		case 2: set_dr(2, val); break;
+		case 3: set_dr(3, val); break;
+		case 7: set_dr(7, val); break;
+		default: printk("write_dr: invalid debug register\n"); 
+			break;
+	}
+	return;
+}
+#undef set_dr
+
+#define get_dr(regnum, val) \
+		__asm__("movl %%db" #regnum ", %0"  \
+			:"=r" (val))
+unsigned long read_dr(int regnum)
+{
+	unsigned long val = 0;
+	switch(regnum) {
+		case 0: get_dr(0, val); break;
+		case 1: get_dr(1, val); break;
+		case 2: get_dr(2, val); break;
+		case 3: get_dr(3, val); break;
+		case 7: get_dr(7, val); break;
+		default: printk("read_dr: invalid debug register\n"); 
+			break;
+	}
+	return val;
+}
+#undef get_dr
+	
+/*
+ * Given the debug status register, returns the debug register number
+ * which caused the debug trap.
+ */
+int dr_trap(unsigned int condition)
+{
+	switch(condition & DR_TRAP_MASK) {
+		case DR_TRAP0: return 0;
+		case DR_TRAP1: return 1;
+		case DR_TRAP2: return 2;
+		case DR_TRAP3: return 3;
+		default: return -1;
+	}
+}
+
+/*
+ * Given the debug status register, returns the address due to which
+ * the debug trap occured.
+ */
+unsigned long dr_trap_addr(unsigned int condition)
+{
+	int regnum = dr_trap(condition);
+
+	if (regnum == -1)
+		return -1;
+
+	return read_dr(regnum);
+}
+
+/*
+ * Given the debug status register, returns the type debug trap -
+ * execute, read/write, write or io.
+ */
+int dr_trap_type(unsigned int condition)
+{
+	int regnum = dr_trap(condition);
+
+	if (regnum == -1)
+		return -1;
+
+	return DR7_RW_VAL(read_dr(7), regnum);
+}
diff -urN linux-2.4.2/arch/i386/kernel/process.c linux-2.4.2+dr/arch/i386/kernel/process.c
--- linux-2.4.2/arch/i386/kernel/process.c	Sat Feb 10 00:59:44 2001
+++ linux-2.4.2+dr/arch/i386/kernel/process.c	Tue Apr  3 15:56:17 2001
@@ -46,6 +46,9 @@
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
+#ifdef CONFIG_DR_ALLOC
+#include <asm/dr_alloc.h>
+#endif
 
 #include <linux/irq.h>
 
@@ -467,13 +470,20 @@
  */
 void exit_thread(void)
 {
-	/* nothing to do ... */
+#ifdef CONFIG_DR_ALLOC
+	if (current->thread.debugreg[7])
+		dr_dec_use_count(current->thread.debugreg[7]);
+#endif
 }
 
 void flush_thread(void)
 {
 	struct task_struct *tsk = current;
 
+#ifdef CONFIG_DR_ALLOC
+	if (tsk->thread.debugreg[7])
+		dr_dec_use_count(tsk->thread.debugreg[7]); 
+#endif
 	memset(tsk->thread.debugreg, 0, sizeof(unsigned long)*8);
 	/*
 	 * Forget coprocessor state..
@@ -547,6 +557,19 @@
 
 	unlazy_fpu(current);
 	struct_cpy(&p->thread.i387, &current->thread.i387);
+#ifdef CONFIG_DR_ALLOC
+	/* 
+	 * If this task is using debug registers, up the debug register 
+	 * use count. Note that debug register state could not have changed 
+	 * since it is copied from current to the new task.
+	 *
+	 * caveat: We depend on the fact that do_fork does not fail if 
+	 * copy_thread is successful. Otherwise, we will need to call a 
+	 * function from do_fork to undo this work if fork fails after this.
+	 */
+	if (current->thread.debugreg[7])
+		dr_inc_use_count(current->thread.debugreg[7]);
+#endif
 
 	return 0;
 }
@@ -653,6 +676,24 @@
 	/*
 	 * Now maybe reload the debug registers
 	 */
+#ifdef CONFIG_DR_ALLOC
+{
+	/*
+	 * Don't reload global debug registers. Don't touch the global debug
+	 * registers in dr7.
+	 */
+	unsigned long next_dr7 = next->debugreg[7];
+	if (next_dr7){
+		if (DR7_L0(next_dr7)) loaddebug(next, 0);
+		if (DR7_L1(next_dr7)) loaddebug(next, 1);
+		if (DR7_L2(next_dr7)) loaddebug(next, 2);
+		if (DR7_L3(next_dr7)) loaddebug(next, 3);
+		/* no 4 and 5 */
+		loaddebug(next, 6); /* I don't think this is needed. */
+		write_dr(7, (read_dr(7) & dr7_global_mask) | next_dr7);
+	}
+}
+#else
 	if (next->debugreg[7]){
 		loaddebug(next, 0);
 		loaddebug(next, 1);
@@ -662,7 +703,7 @@
 		loaddebug(next, 6);
 		loaddebug(next, 7);
 	}
-
+#endif		
 	if (prev->ioperm || next->ioperm) {
 		if (next->ioperm) {
 			/*
diff -urN linux-2.4.2/arch/i386/kernel/ptrace.c linux-2.4.2+dr/arch/i386/kernel/ptrace.c
--- linux-2.4.2/arch/i386/kernel/ptrace.c	Tue Oct 31 04:16:53 2000
+++ linux-2.4.2+dr/arch/i386/kernel/ptrace.c	Tue Apr  3 15:56:17 2001
@@ -20,6 +20,9 @@
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/debugreg.h>
+#ifdef CONFIG_DR_ALLOC
+#include <asm/dr_alloc.h>
+#endif
 
 /*
  * does not yet catch signals sent when the child dies.
@@ -134,6 +137,42 @@
 	return retval;
 }
 
+#ifdef CONFIG_DR_ALLOC
+/*
+ * This routine decides if the ptrace request is for enabling or disabling 
+ * a debug reg, and accordingly calls dr_alloc() or dr_free().
+ *
+ * We are not taking care of situations where multiple debug registers
+ * are getting enabled/disabled by one ptrace call. In such cases we just
+ * allocate/free the 1st debug register and return. 
+ *
+ * Also, we assume that ptrace is used only to allocate local debug registers.
+ * So to allocate a global debug register in the kernel, use dr_alloc()
+ * directly. 
+ *
+ * gdb uses ptrace to write to debug registers. It assumes that writing to
+ * debug register always succeds and it doesn't check the return value of 
+ * ptrace. Now with this new LOCAL/GLOBAL DEBUG REGISTER ALLOCATION LOGIC, 
+ * ptrace request for a local debug register can fail, if the required debug
+ * register is already globally allocated. Since gdb fails to notice this 
+ * failure, it sometimes tries to free a debug register, which is not allocated
+ * for it. To handle this case, this function returns -1.
+ */
+static int enable_debugreg(unsigned long old_dr7, unsigned long new_dr7)
+{
+	int i, dr_shift = 1UL;
+	for (i = 0; i < DR_MAX; i++, dr_shift <<= 2) {
+		if ((old_dr7 ^ new_dr7) & dr_shift) {
+			if (new_dr7 & dr_shift)
+				return dr_alloc(i, DR_ALLOC_LOCAL);
+			else
+				return dr_free(i);
+		}
+	}
+	return -1;
+}
+#endif
+
 asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
@@ -281,6 +320,18 @@
 
 			  addr -= (long) &dummy->u_debugreg;
 			  addr = addr >> 2;
+#ifdef CONFIG_DR_ALLOC
+{
+			  int retval;
+			  if (addr == 7) {
+				retval = enable_debugreg(child->thread.debugreg[addr], data);
+				if (retval == -1) {
+					ret = -EBUSY;
+					break;
+				}
+			  }	
+}
+#endif
 			  child->thread.debugreg[addr] = data;
 			  ret = 0;
 		  }
diff -urN linux-2.4.2/arch/i386/kernel/signal.c linux-2.4.2+dr/arch/i386/kernel/signal.c
--- linux-2.4.2/arch/i386/kernel/signal.c	Wed Feb 14 02:45:04 2001
+++ linux-2.4.2+dr/arch/i386/kernel/signal.c	Tue Apr  3 15:56:17 2001
@@ -22,6 +22,9 @@
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
+#ifdef CONFIG_DR_ALLOC
+#include <asm/dr_alloc.h>
+#endif
 
 #define DEBUG_SIG 0
 
@@ -694,7 +697,18 @@
 		 * have been cleared if the watchpoint triggered
 		 * inside the kernel.
 		 */
-		__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
+#ifdef CONFIG_DR_ALLOC
+{
+		/*
+		 * Don't change the global watchpoint bit settings in dr7.
+		 */
+		if (current->thread.debugreg[7]) {
+			write_dr(7, (read_dr(7) & dr7_global_mask) | current->thread.debugreg[7]);
+		}
+}
+#else
+                __asm__("movl %0,%%db7" : : "r" (current->thread.debugreg[7]));
+#endif
 
 		/* Whee!  Actually deliver the signal.  */
 		handle_signal(signr, ka, &info, oldset, regs);
diff -urN linux-2.4.2/arch/i386/kernel/traps.c linux-2.4.2+dr/arch/i386/kernel/traps.c
--- linux-2.4.2/arch/i386/kernel/traps.c	Wed Feb 14 03:45:04 2001
+++ linux-2.4.2+dr/arch/i386/kernel/traps.c	Tue Apr  3 15:56:17 2001
@@ -46,6 +46,9 @@
 #include <asm/cobalt.h>
 #include <asm/lithium.h>
 #endif
+#ifdef CONFIG_DR_ALLOC
+#include <asm/dr_alloc.h>
+#endif
 
 #include <linux/irq.h>
 
@@ -566,9 +569,17 @@
 	 * the signal is delivered.
 	 */
 clear_dr7:
+#ifdef CONFIG_DR_ALLOC
+	/* 
+	 * Don't clear the entire dr7. Leave out the bits corresponding
+	 * to global watchpoints.
+	 */
+	write_dr(7, (read_dr(7) & dr7_global_mask));	
+#else
 	__asm__("movl %0,%%db7"
 		: /* no output */
 		: "r" (0));
+#endif
 	return;
 
 debug_vm86:
diff -urN linux-2.4.2/include/asm-i386/dr_alloc.h linux-2.4.2+dr/include/asm-i386/dr_alloc.h
--- linux-2.4.2/include/asm-i386/dr_alloc.h	Thu Jan  1 05:30:00 1970
+++ linux-2.4.2+dr/include/asm-i386/dr_alloc.h	Tue Apr  3 15:56:17 2001
@@ -0,0 +1,132 @@
+/*
+ * This is a debug register allocation mechanism, to be used by
+ * all debuggers, which use debug registers.
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
+ */
+
+#ifndef __ASM_I386_DR_ALLOC_H
+#define __ASM_I386_DR_ALLOC_H
+
+/* No of debug registers available on IA32 processors */
+#define DR_MAX	4
+
+struct dr_struct {
+	unsigned long flag;
+	unsigned long use_count;
+};
+
+/* dr_struct flags */
+#define DR_UNUSED	0
+#define DR_LOCAL	1
+#define DR_GLOBAL	2
+	
+/* debug register numbers */
+#define DR_ANY		DR_MAX + 1
+
+/* global or local allocation requests */
+#define DR_ALLOC_GLOBAL		0
+#define DR_ALLOC_LOCAL		1
+
+#define DR7_RW_SET(dr, regnum, rw)                              \
+       do {                                                    \
+               (dr) &= ~(0x3 << (16 + (4 * (regnum))));         \
+               (dr) |= (((rw) & 0x3) << (16 + (4 * (regnum)))); \
+       } while (0)
+
+#define DR7_RW_VAL(dr, regnum) \
+       (((dr) >> (16 + (4 * (regnum)))) & 0x3)
+
+#define DR7_LEN_SET(dr, regnum, rw)                             \
+       do {                                                    \
+               (dr) &= ~(0x3 << (18 + (4 * (regnum))));         \
+               (dr) |= (((rw) & 0x3) << (18 + (4 * (regnum)))); \
+       } while (0)
+
+#define DR7_LEN_VAL(dr, regnum) \
+       (((dr) >> (18 + (4 * (regnum)))) & 0x3)
+
+#define DR7_G0(dr)    (((dr)>>1)&0x1)
+#define DR7_G0SET(dr) ((dr) |= 0x2)
+#define DR7_G0CLR(dr) ((dr) &= ~0x2)
+#define DR7_G1(dr)    (((dr)>>3)&0x1)
+#define DR7_G1SET(dr) ((dr) |= 0x8)
+#define DR7_G1CLR(dr) ((dr) &= ~0x8)
+#define DR7_G2(dr)    (((dr)>>5)&0x1)
+#define DR7_G2SET(dr) ((dr) |= 0x20)
+#define DR7_G2CLR(dr) ((dr) &= ~0x20)
+#define DR7_G3(dr)    (((dr)>>7)&0x1)
+#define DR7_G3SET(dr) ((dr) |= 0x80)
+#define DR7_G3CLR(dr) ((dr) &= ~0x80)
+
+#define DR7_L0(dr)    (((dr))&0x1)
+#define DR7_L0SET(dr) ((dr) |= 0x1)
+#define DR7_L0CLR(dr) ((dr) &= ~0x1)
+#define DR7_L1(dr)    (((dr)>>2)&0x1)
+#define DR7_L1SET(dr) ((dr) |= 0x4)
+#define DR7_L1CLR(dr) ((dr) &= ~0x4)
+#define DR7_L2(dr)    (((dr)>>4)&0x1)
+#define DR7_L2SET(dr) ((dr) |= 0x10)
+#define DR7_L2CLR(dr) ((dr) &= ~0x10)
+#define DR7_L3(dr)    (((dr)>>6)&0x1)
+#define DR7_L3SET(dr) ((dr) |= 0x40)
+#define DR7_L3CLR(dr) ((dr) &= ~0x40)
+
+#define DR_IS_LOCAL(dr, num) ((dr) & (1UL << (num <<1)))
+
+#define DR7_L0_BIT		0x00000001
+#define DR7_L1_BIT		0x00000004
+#define DR7_L2_BIT		0x00000010
+#define DR7_L3_BIT		0x00000040
+
+/* Set the rw, len and global flag in dr7 for a debug register */
+#define SET_DR7(dr, regnum, access, len) \
+	DR7_RW_SET(dr, regnum, access); \
+	DR7_LEN_SET(dr, regnum, len); \
+	dr |= (2UL << regnum*2);
+
+/* Disable a debug register by clearing the global/local flag in dr7 */
+#define RESET_DR7(dr, regnum) \
+	dr &= ~(3UL << regnum*2); \
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
+/* Function declarations */
+extern int dr_trap(unsigned int);
+extern unsigned long dr_trap_addr(unsigned int);
+extern int dr_trap_type(unsigned int);
+
+extern unsigned long read_dr(int);
+extern void write_dr(int, unsigned long);
+
+extern int dr_alloc(int regnum, int flag);
+extern int dr_free(int regnum);
+extern int dr_inc_use_count(unsigned long mask);
+extern int dr_dec_use_count(unsigned long mask);
+
+extern struct dr_struct dr_list[DR_MAX];
+extern unsigned long dr7_global_mask;
+
+#endif
-- 
