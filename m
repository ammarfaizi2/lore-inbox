Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbTIKRRr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbTIKRRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:17:47 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:26543 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261431AbTIKRPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:15:20 -0400
Date: Thu, 11 Sep 2003 19:14:34 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (1/7): s390 base.
Message-ID: <20030911171434.GB5637@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Fix cflags setting for z990.
 - Fix 32 bit emulation of sys_sysinfo and sys_clone.
 - Add code for -ERESTART_RESTARTBLOCK in 32 bit signal emulation.
 - Rename resume to __switch_to to avoid name clash.
 - Some micro optimizations:
    + Put cpu number to lowcore.
    + Put percpu_offset to lowcore.
    + Put current pointer to lowcore.
 - Fix show_trace and show_stack.
 - Add alignments to linker script.
 - Fix bug in CMS label recognition in ibm.c
 - Add atomic64_t and related funtions.
 - Add include/asm-s390/local.h
 - Fix get_user for 8 byte values for 31 bit.
 - Fix show_regs oops.
 - Fix ptrace peek/poke for 31 bit programs under a 64 bit kernel.
 - Add a couple of might_sleep() calls.
 - Fix restarting of svc calls done by use of execute.
 - Fix loading of modules with a BIG symbol table.
 - Fix inline asm constraint in __get_user_asm_1

diffstat:
 arch/s390/Makefile               |    2 
 arch/s390/kernel/compat_ioctl.c  |    1 
 arch/s390/kernel/compat_linux.c  |   17 ++-
 arch/s390/kernel/compat_signal.c |   13 ++
 arch/s390/kernel/entry.S         |   35 +++---
 arch/s390/kernel/entry64.S       |   33 +++---
 arch/s390/kernel/head.S          |    2 
 arch/s390/kernel/head64.S        |    3 
 arch/s390/kernel/module.c        |    7 -
 arch/s390/kernel/process.c       |    5 
 arch/s390/kernel/ptrace.c        |   21 +++-
 arch/s390/kernel/setup.c         |   19 +--
 arch/s390/kernel/signal.c        |    4 
 arch/s390/kernel/smp.c           |   12 +-
 arch/s390/kernel/traps.c         |   12 +-
 arch/s390/kernel/vmlinux.lds.S   |    2 
 arch/s390/mm/fault.c             |    5 
 fs/partitions/ibm.c              |    3 
 include/asm-s390/atomic.h        |  198 ++++++++++++++++++++++-----------------
 include/asm-s390/current.h       |   10 -
 include/asm-s390/hardirq.h       |   28 ++---
 include/asm-s390/local.h         |   59 +++++++++++
 include/asm-s390/lowcore.h       |   12 +-
 include/asm-s390/pci.h           |    2 
 include/asm-s390/percpu.h        |    8 +
 include/asm-s390/processor.h     |    3 
 include/asm-s390/ptrace.h        |    3 
 include/asm-s390/sections.h      |    6 +
 include/asm-s390/smp.h           |    2 
 include/asm-s390/spinlock.h      |   14 +-
 include/asm-s390/system.h        |    4 
 include/asm-s390/uaccess.h       |   29 ++++-
 32 files changed, 373 insertions(+), 201 deletions(-)

diff -urN linux-2.6/arch/s390/Makefile linux-2.6-s390/arch/s390/Makefile
--- linux-2.6/arch/s390/Makefile	Mon Sep  8 21:49:55 2003
+++ linux-2.6-s390/arch/s390/Makefile	Thu Sep 11 19:21:05 2003
@@ -32,7 +32,7 @@
 
 cflags-$(CONFIG_MARCH_G5)   += $(call check_gcc,-march=g5,)
 cflags-$(CONFIG_MARCH_Z900) += $(call check_gcc,-march=z900,)
-cflags-$(CONFIG_MARCH_Z990) += $(call check_gcc,-march=trex,)
+cflags-$(CONFIG_MARCH_Z990) += $(call check_gcc,-march=z990,)
 
 CFLAGS		+= $(cflags-y)
 CFLAGS		+= $(call check_gcc,-finline-limit=10000,)
diff -urN linux-2.6/arch/s390/kernel/compat_ioctl.c linux-2.6-s390/arch/s390/kernel/compat_ioctl.c
--- linux-2.6/arch/s390/kernel/compat_ioctl.c	Mon Sep  8 21:50:12 2003
+++ linux-2.6-s390/arch/s390/kernel/compat_ioctl.c	Thu Sep 11 19:21:05 2003
@@ -23,6 +23,7 @@
 #include <asm/types.h>
 #include <asm/uaccess.h>
 
+#include <linux/blkdev.h>
 #include <linux/blkpg.h>
 #include <linux/cdrom.h>
 #include <linux/dm-ioctl.h>
diff -urN linux-2.6/arch/s390/kernel/compat_linux.c linux-2.6-s390/arch/s390/kernel/compat_linux.c
--- linux-2.6/arch/s390/kernel/compat_linux.c	Mon Sep  8 21:50:21 2003
+++ linux-2.6-s390/arch/s390/kernel/compat_linux.c	Thu Sep 11 19:21:05 2003
@@ -1551,7 +1551,11 @@
         u32 totalswap;
         u32 freeswap;
         unsigned short procs;
-        char _f[22];
+	unsigned short pads;
+	u32 totalhigh;
+	u32 freehigh;
+	unsigned int mem_unit;
+        char _f[8];
 };
 
 extern asmlinkage int sys_sysinfo(struct sysinfo *info);
@@ -1576,6 +1580,9 @@
 	err |= __put_user (s.totalswap, &info->totalswap);
 	err |= __put_user (s.freeswap, &info->freeswap);
 	err |= __put_user (s.procs, &info->procs);
+	err |= __put_user (s.totalhigh, &info->totalhigh);
+	err |= __put_user (s.freehigh, &info->freehigh);
+	err |= __put_user (s.mem_unit, &info->mem_unit);
 	if (err)
 		return -EFAULT;
 	return ret;
@@ -2810,7 +2817,6 @@
 {
         unsigned long clone_flags;
         unsigned long newsp;
-	struct task_struct *p;
 	int *parent_tidptr, *child_tidptr;
 
         clone_flags = regs.gprs[3] & 0xffffffffUL;
@@ -2819,7 +2825,8 @@
 	child_tidptr = (int *) (regs.gprs[5] & 0x7fffffffUL);
         if (!newsp)
                 newsp = regs.gprs[15];
-        p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0,
-		    parent_tidptr, child_tidptr);
-	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
+        return do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0,
+		       parent_tidptr, child_tidptr);
 }
+
+
diff -urN linux-2.6/arch/s390/kernel/compat_signal.c linux-2.6-s390/arch/s390/kernel/compat_signal.c
--- linux-2.6/arch/s390/kernel/compat_signal.c	Mon Sep  8 21:50:28 2003
+++ linux-2.6-s390/arch/s390/kernel/compat_signal.c	Thu Sep 11 19:21:05 2003
@@ -563,6 +563,10 @@
 	if (regs->trap == __LC_SVC_OLD_PSW) {
 		/* If so, check system call restarting.. */
 		switch (regs->gprs[2]) {
+			case -ERESTART_RESTARTBLOCK:
+				current_thread_info()->restart_block.fn =
+					do_no_restart_syscall;
+				clear_thread_flag(TIF_RESTART_SVC);
 			case -ERESTARTNOHAND:
 				regs->gprs[2] = -EINTR;
 				break;
@@ -575,7 +579,7 @@
 			/* fallthrough */
 			case -ERESTARTNOINTR:
 				regs->gprs[2] = regs->orig_gpr2;
-				regs->psw.addr -= 2;
+				regs->psw.addr -= regs->ilc;
 		}
 	}
 
@@ -637,7 +641,12 @@
 		    regs->gprs[2] == -ERESTARTSYS ||
 		    regs->gprs[2] == -ERESTARTNOINTR) {
 			regs->gprs[2] = regs->orig_gpr2;
-			regs->psw.addr -= 2;
+			regs->psw.addr -= regs->ilc;
+		}
+		/* Restart the system call with a new system call number */
+		if (regs->gprs[2] == -ERESTART_RESTARTBLOCK) {
+			regs->gprs[2] = __NR_restart_syscall;
+			set_thread_flag(TIF_RESTART_SVC);
 		}
 	}
 	return 0;
diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-s390/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	Mon Sep  8 21:49:54 2003
+++ linux-2.6-s390/arch/s390/kernel/entry.S	Thu Sep 11 19:21:05 2003
@@ -45,8 +45,9 @@
 SP_AREGS     =  STACK_FRAME_OVERHEAD + PT_ACR0
 SP_ORIG_R2   =  STACK_FRAME_OVERHEAD + PT_ORIGGPR2
 /* Now the additional entries */
-SP_TRAP      =  (SP_ORIG_R2+GPR_SIZE)
-SP_SIZE      =  (SP_TRAP+4)
+SP_ILC       =  (SP_ORIG_R2+GPR_SIZE)
+SP_TRAP      =  (SP_ILC+2)
+SP_SIZE      =  (SP_TRAP+2)
 
 _TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_RESTART_SVC)
 _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NEED_RESCHED)
@@ -98,7 +99,8 @@
         stam    %a0,%a15,SP_AREGS(%r15)   # store access registers to kst.
         mvc     SP_AREGS+8(12,%r15),__LC_SAVE_AREA+12 # store ac. regs
         mvc     SP_PSW(8,%r15),\psworg    # move user PSW to stack
-	mvc	SP_TRAP(4,%r15),BASED(.L\psworg) # store trap indication
+	mvc	SP_ILC(2,%r15),__LC_SVC_ILC      # store instruction length
+	mvc	SP_TRAP(2,%r15),BASED(.L\psworg) # store trap indication
         xc      0(4,%r15),0(%r15)         # clear back chain
         .endm
 
@@ -123,25 +125,26 @@
  * Returns:
  *  gpr2 = prev
  */
-        .globl  resume
-resume:
+        .globl  __switch_to
+__switch_to:
         basr    %r1,0
-resume_base:
+__switch_to_base:
 	tm	__THREAD_per(%r3),0xe8		# new process is using per ?
-	bz	resume_noper-resume_base(%r1)	# if not we're fine
+	bz	__switch_to_noper-__switch_to_base(%r1)	# if not we're fine
         stctl   %c9,%c11,24(%r15)		# We are using per stuff
         clc     __THREAD_per(12,%r3),24(%r15)
-        be      resume_noper-resume_base(%r1)	# we got away w/o bashing TLB's
+        be      __switch_to_noper-__switch_to_base(%r1)	# we got away w/o bashing TLB's
         lctl    %c9,%c11,__THREAD_per(%r3)	# Nope we didn't
-resume_noper:
-        stm     %r6,%r15,24(%r15)       # store resume registers of prev task
+__switch_to_noper:
+        stm     %r6,%r15,24(%r15)       # store __switch_to registers of prev task
 	st	%r15,__THREAD_ksp(%r2)	# store kernel stack to prev->tss.ksp
 	l	%r15,__THREAD_ksp(%r3)	# load kernel stack from next->tss.ksp
 	stam    %a2,%a2,__THREAD_ar2(%r2)	# store kernel access reg. 2
 	stam    %a4,%a4,__THREAD_ar4(%r2)	# store kernel access reg. 4
 	lam     %a2,%a2,__THREAD_ar2(%r3)	# load kernel access reg. 2
 	lam     %a4,%a4,__THREAD_ar4(%r3)	# load kernel access reg. 4
-	lm	%r6,%r15,24(%r15)	# load resume registers of next task
+	lm	%r6,%r15,24(%r15)	# load __switch_to registers of next task
+	st	%r3,__LC_CURRENT	# __LC_CURRENT = current task struct
 	l	%r3,__THREAD_info(%r3)  # load thread_info from task struct
 	ahi	%r3,8192
 	st	%r3,__LC_KERNEL_STACK	# __LC_KERNEL_STACK = new kernel stack
@@ -685,11 +688,11 @@
 .Lc_pactive:   .long  PREEMPT_ACTIVE
 .Lc0xff:       .long  0xff
 .Lnr_syscalls: .long  NR_syscalls
-.L0x018:       .long  0x018
-.L0x020:       .long  0x020
-.L0x028:       .long  0x028
-.L0x030:       .long  0x030
-.L0x038:       .long  0x038
+.L0x018:       .word  0x018
+.L0x020:       .word  0x020
+.L0x028:       .word  0x028
+.L0x030:       .word  0x030
+.L0x038:       .word  0x038
 
 /*
  * Symbol constants
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-s390/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	Mon Sep  8 21:49:54 2003
+++ linux-2.6-s390/arch/s390/kernel/entry64.S	Thu Sep 11 19:21:05 2003
@@ -45,8 +45,9 @@
 SP_AREGS     =  STACK_FRAME_OVERHEAD + PT_ACR0
 SP_ORIG_R2   =  STACK_FRAME_OVERHEAD + PT_ORIGGPR2
 /* Now the additional entries */
-SP_TRAP      =  (SP_ORIG_R2+GPR_SIZE)
-SP_SIZE      =  (SP_TRAP+4)
+SP_ILC       =  (SP_ORIG_R2+GPR_SIZE)
+SP_TRAP      =  (SP_ILC+2)
+SP_SIZE      =  (SP_TRAP+2)
 
 _TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_RESTART_SVC)
 _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NEED_RESCHED)
@@ -86,7 +87,8 @@
         stam    %a0,%a15,SP_AREGS(%r15)  # store access registers to kst.
         mvc     SP_AREGS+8(12,%r15),__LC_SAVE_AREA+16 # store ac. regs
         mvc     SP_PSW(16,%r15),\psworg  # move user PSW to stack
-	mvc	SP_TRAP(4,%r15),.L\psworg-.Lconst(%r14) # store trap ind.
+	mvc	SP_ILC(2,%r15),__LC_SVC_ILC # store instruction length
+	mvc	SP_TRAP(2,%r15),.L\psworg-.Lconst(%r14) # store trap ind.
         xc      0(8,%r15),0(%r15)        # clear back chain
         .endm
 
@@ -111,23 +113,24 @@
  * Returns:
  *  gpr2 = prev
  */
-        .globl  resume
-resume:
+        .globl  __switch_to
+__switch_to:
 	tm	__THREAD_per+4(%r3),0xe8 # is the new process using per ?
-	jz	resume_noper		# if not we're fine
+	jz	__switch_to_noper		# if not we're fine
         stctg   %c9,%c11,48(%r15)       # We are using per stuff
         clc     __THREAD_per(24,%r3),48(%r15)
-        je      resume_noper            # we got away without bashing TLB's
+        je      __switch_to_noper            # we got away without bashing TLB's
         lctlg   %c9,%c11,__THREAD_per(%r3)	# Nope we didn't
-resume_noper:
-        stmg    %r6,%r15,48(%r15)       # store resume registers of prev task
+__switch_to_noper:
+        stmg    %r6,%r15,48(%r15)       # store __switch_to registers of prev task
 	stg	%r15,__THREAD_ksp(%r2)	# store kernel stack to prev->tss.ksp
 	lg	%r15,__THREAD_ksp(%r3)	# load kernel stack from next->tss.ksp
         stam    %a2,%a2,__THREAD_ar2(%r2)	# store kernel access reg. 2
         stam    %a4,%a4,__THREAD_ar4(%r2)	# store kernel access reg. 4
         lam     %a2,%a2,__THREAD_ar2(%r3)	# load kernel access reg. 2
         lam     %a4,%a4,__THREAD_ar4(%r3)	# load kernel access reg. 4
-        lmg     %r6,%r15,48(%r15)       # load resume registers of next task
+        lmg     %r6,%r15,48(%r15)       # load __switch_to registers of next task
+	stg	%r3,__LC_CURRENT	# __LC_CURRENT = current task struct
 	lg	%r3,__THREAD_info(%r3)  # load thread_info from task struct
 	aghi	%r3,16384
 	stg	%r3,__LC_KERNEL_STACK	# __LC_KERNEL_STACK = new kernel stack
@@ -705,9 +708,9 @@
 .Lconst:
 .Lc_ac:        .long  0,0,1
 .Lc_pactive:   .long  PREEMPT_ACTIVE
-.L0x0130:      .long  0x0130
-.L0x0140:      .long  0x0140
-.L0x0150:      .long  0x0150
-.L0x0160:      .long  0x0160
-.L0x0170:      .long  0x0170
+.L0x0130:      .word  0x0130
+.L0x0140:      .word  0x0140
+.L0x0150:      .word  0x0150
+.L0x0160:      .word  0x0160
+.L0x0170:      .word  0x0170
 .Lnr_syscalls: .long  NR_syscalls
diff -urN linux-2.6/arch/s390/kernel/head.S linux-2.6-s390/arch/s390/kernel/head.S
--- linux-2.6/arch/s390/kernel/head.S	Mon Sep  8 21:49:58 2003
+++ linux-2.6-s390/arch/s390/kernel/head.S	Thu Sep 11 19:21:05 2003
@@ -30,6 +30,7 @@
 #include <linux/config.h>
 #include <asm/setup.h>
 #include <asm/lowcore.h>
+#include <asm/offsets.h>
 
 #ifndef CONFIG_IPL
         .org   0
@@ -633,6 +634,7 @@
 # Setup stack
 #
         l     %r15,.Linittu-.LPG2(%r13)
+	mvc   __LC_CURRENT(4),__TI_task(%r15)
         ahi   %r15,8192                 # init_task_union + 8192
         st    %r15,__LC_KERNEL_STACK    # set end of kernel stack
         ahi   %r15,-96
diff -urN linux-2.6/arch/s390/kernel/head64.S linux-2.6-s390/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	Mon Sep  8 21:50:01 2003
+++ linux-2.6-s390/arch/s390/kernel/head64.S	Thu Sep 11 19:21:05 2003
@@ -30,6 +30,7 @@
 #include <linux/config.h>
 #include <asm/setup.h>
 #include <asm/lowcore.h>
+#include <asm/offsets.h>
 
 #ifndef CONFIG_IPL
         .org   0
@@ -642,6 +643,8 @@
 # Setup stack
 #
 	larl  %r15,init_thread_union
+	lg    %r14,__TI_task(%r15)      # cache current in lowcore
+	stg   %r14,__LC_CURRENT
         aghi  %r15,16384                # init_task_union + 16384
         stg   %r15,__LC_KERNEL_STACK    # set end of kernel stack
         aghi  %r15,-160
diff -urN linux-2.6/arch/s390/kernel/module.c linux-2.6-s390/arch/s390/kernel/module.c
--- linux-2.6/arch/s390/kernel/module.c	Mon Sep  8 21:50:23 2003
+++ linux-2.6-s390/arch/s390/kernel/module.c	Thu Sep 11 19:21:05 2003
@@ -133,9 +133,8 @@
 
 	/* Allocate one syminfo structure per symbol. */
 	me->arch.nsyms = symtab->sh_size / sizeof(Elf_Sym);
-	me->arch.syminfo = kmalloc(me->arch.nsyms *
-				   sizeof(struct mod_arch_syminfo),
-				   GFP_KERNEL);
+	me->arch.syminfo = vmalloc(me->arch.nsyms *
+				   sizeof(struct mod_arch_syminfo));
 	if (!me->arch.syminfo)
 		return -ENOMEM;
 	symbols = (void *) hdr + symtab->sh_offset;
@@ -397,7 +396,7 @@
 		    struct module *me)
 {
 	if (me->arch.syminfo)
-		kfree(me->arch.syminfo);
+		vfree(me->arch.syminfo);
 	return 0;
 }
 
diff -urN linux-2.6/arch/s390/kernel/process.c linux-2.6-s390/arch/s390/kernel/process.c
--- linux-2.6/arch/s390/kernel/process.c	Mon Sep  8 21:50:21 2003
+++ linux-2.6-s390/arch/s390/kernel/process.c	Thu Sep 11 19:21:05 2003
@@ -118,9 +118,6 @@
 	return 0;
 }
 
-extern void show_registers(struct pt_regs *regs);
-extern void show_trace(unsigned long *sp);
-
 void show_regs(struct pt_regs *regs)
 {
 	struct task_struct *tsk = current;
@@ -133,7 +130,7 @@
 	show_registers(regs);
 	/* Show stack backtrace if pt_regs is from kernel mode */
 	if (!(regs->psw.mask & PSW_MASK_PSTATE))
-		show_trace((unsigned long *) regs->gprs[15]);
+		show_trace(0,(unsigned long *) regs->gprs[15]);
 }
 
 extern void kernel_thread_starter(void);
diff -urN linux-2.6/arch/s390/kernel/ptrace.c linux-2.6-s390/arch/s390/kernel/ptrace.c
--- linux-2.6/arch/s390/kernel/ptrace.c	Mon Sep  8 21:50:24 2003
+++ linux-2.6-s390/arch/s390/kernel/ptrace.c	Thu Sep 11 19:21:05 2003
@@ -321,9 +321,18 @@
 			/* Fake a 31 bit psw address. */
 			tmp = (__u32) __KSTK_PTREGS(child)->psw.addr |
 				PSW32_ADDR_AMODE31;
-		} else
+		} else if (addr < (addr_t) &dummy32->regs.acrs[0]) {
+			/* gpr 0-15 */
 			tmp = *(__u32 *)((addr_t) __KSTK_PTREGS(child) + 
 					 addr*2 + 4);
+		} else if (addr < (addr_t) &dummy32->regs.orig_gpr2) {
+			offset = PT_ACR0 + addr - (addr_t) &dummy32->regs.acrs;
+			tmp = *(__u32*)((addr_t) __KSTK_PTREGS(child) + offset);
+		} else {
+			/* orig gpr 2 */
+			offset = PT_ORIGGPR2 + 4;
+			tmp = *(__u32*)((addr_t) __KSTK_PTREGS(child) + offset);
+		}
 	} else if (addr >= (addr_t) &dummy32->regs.fp_regs &&
 		   addr < (addr_t) (&dummy32->regs.fp_regs + 1)) {
 		/*
@@ -387,9 +396,17 @@
 			/* Build a 64 bit psw address from 31 bit address. */
 			__KSTK_PTREGS(child)->psw.addr = 
 				(__u64) tmp & PSW32_ADDR_INSN;
-		} else
+		} else if (addr < (addr_t) &dummy32->regs.acrs[0]) {
+			/* gpr 0-15 */
 			*(__u32*)((addr_t) __KSTK_PTREGS(child) + addr*2 + 4) =
 				tmp;
+		} else if (addr < (addr_t) &dummy32->regs.orig_gpr2) {
+			offset = PT_ACR0 + addr - (addr_t) &dummy32->regs.acrs;
+			*(__u32*)((addr_t) __KSTK_PTREGS(child) + offset) = tmp;
+		} else {
+			offset = PT_ORIGGPR2 + 4;
+			*(__u32*)((addr_t) __KSTK_PTREGS(child) + offset) = tmp;
+		}
 	} else if (addr >= (addr_t) &dummy32->regs.fp_regs &&
 		   addr < (addr_t) (&dummy32->regs.fp_regs + 1)) {
 		/*
diff -urN linux-2.6/arch/s390/kernel/setup.c linux-2.6-s390/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	Mon Sep  8 21:49:52 2003
+++ linux-2.6-s390/arch/s390/kernel/setup.c	Thu Sep 11 19:21:05 2003
@@ -97,7 +97,6 @@
          */
         asm volatile ("stidp %0": "=m" (S390_lowcore.cpu_data.cpu_id));
         S390_lowcore.cpu_data.cpu_addr = addr;
-        S390_lowcore.cpu_data.cpu_nr = nr;
 
         /*
          * Force FPU initialization:
@@ -418,7 +417,7 @@
 	 * we are rounding upwards:
 	 */
 	start_pfn = (__pa(&_end) + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	end_pfn = memory_end >> PAGE_SHIFT;
+	end_pfn = max_pfn = memory_end >> PAGE_SHIFT;
 
 	/*
 	 * Initialize the boot-time allocator (with low memory only):
@@ -497,21 +496,17 @@
 	lc->io_new_psw.addr = PSW_ADDR_AMODE + (unsigned long) io_int_handler;
 	lc->ipl_device = S390_lowcore.ipl_device;
 	lc->jiffy_timer = -1LL;
-#ifndef CONFIG_ARCH_S390X
-	lc->kernel_stack = ((__u32) &init_thread_union) + 8192;
-	lc->async_stack = (__u32)
-		__alloc_bootmem(2*PAGE_SIZE, 2*PAGE_SIZE, 0) + 8192;
-	set_prefix((__u32) lc);
-#else /* CONFIG_ARCH_S390X */
-	lc->kernel_stack = ((__u64) &init_thread_union) + 16384;
-	lc->async_stack = (__u64)
-		__alloc_bootmem(4*PAGE_SIZE, 4*PAGE_SIZE, 0) + 16384;
+	lc->kernel_stack = ((unsigned long) &init_thread_union) + THREAD_SIZE;
+	lc->async_stack = (unsigned long)
+		__alloc_bootmem(ASYNC_SIZE, ASYNC_SIZE, 0) + ASYNC_SIZE;
+	lc->current_task = (unsigned long) init_thread_union.thread_info.task;
+#ifdef CONFIG_ARCH_S390X
 	if (MACHINE_HAS_DIAG44)
 		lc->diag44_opcode = 0x83000044;
 	else
 		lc->diag44_opcode = 0x07000700;
-	set_prefix((__u32)(__u64) lc);
 #endif /* CONFIG_ARCH_S390X */
+	set_prefix((u32)(unsigned long) lc);
         cpu_init();
         __cpu_logical_map[0] = S390_lowcore.cpu_data.cpu_addr;
 
diff -urN linux-2.6/arch/s390/kernel/signal.c linux-2.6-s390/arch/s390/kernel/signal.c
--- linux-2.6/arch/s390/kernel/signal.c	Mon Sep  8 21:50:21 2003
+++ linux-2.6-s390/arch/s390/kernel/signal.c	Thu Sep 11 19:21:05 2003
@@ -418,7 +418,7 @@
 			/* fallthrough */
 			case -ERESTARTNOINTR:
 				regs->gprs[2] = regs->orig_gpr2;
-				regs->psw.addr -= 2;
+				regs->psw.addr -= regs->ilc;
 		}
 	}
 
@@ -487,7 +487,7 @@
 		    regs->gprs[2] == -ERESTARTSYS ||
 		    regs->gprs[2] == -ERESTARTNOINTR) {
 			regs->gprs[2] = regs->orig_gpr2;
-			regs->psw.addr -= 2;
+			regs->psw.addr -= regs->ilc;
 		}
 		/* Restart the system call with a new system call number */
 		if (regs->gprs[2] == -ERESTART_RESTARTBLOCK) {
diff -urN linux-2.6/arch/s390/kernel/smp.c linux-2.6-s390/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	Mon Sep  8 21:49:51 2003
+++ linux-2.6-s390/arch/s390/kernel/smp.c	Thu Sep 11 19:21:05 2003
@@ -207,7 +207,8 @@
 	cpu_clear(smp_processor_id(), cpu_restart_map);
 	if (smp_processor_id() == 0) {
 		/* Wait for all other cpus to enter do_machine_restart. */
-		while (!cpus_empty(cpu_restart_map));
+		while (!cpus_empty(cpu_restart_map))
+			barrier();
 		/* Store status of other cpus. */
 		do_store_status();
 		/*
@@ -514,8 +515,11 @@
 	__asm__ __volatile__("stam  0,15,0(%0)"
 			     : : "a" (&cpu_lowcore->access_regs_save_area)
 			     : "memory");
-        eieio();
-        signal_processor(cpu,sigp_restart);
+	cpu_lowcore->percpu_offset = __per_cpu_offset[cpu];
+        cpu_lowcore->current_task = (unsigned long) idle;
+        cpu_lowcore->cpu_data.cpu_nr = cpu;
+	eieio();
+	signal_processor(cpu,sigp_restart);
 
 	while (!cpu_online(cpu));
 	return 0;
@@ -560,6 +564,7 @@
 {
 	cpu_set(smp_processor_id(), cpu_online_map);
 	cpu_set(smp_processor_id(), cpu_possible_map);
+	S390_lowcore.percpu_offset = __per_cpu_offset[smp_processor_id()];
 }
 
 void smp_cpus_done(unsigned int max_cpus)
@@ -577,6 +582,7 @@
         return 0;
 }
 
+EXPORT_SYMBOL(cpu_possible_map);
 EXPORT_SYMBOL(lowcore_ptr);
 EXPORT_SYMBOL(smp_ctl_set_bit);
 EXPORT_SYMBOL(smp_ctl_clear_bit);
diff -urN linux-2.6/arch/s390/kernel/traps.c linux-2.6-s390/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	Mon Sep  8 21:50:01 2003
+++ linux-2.6-s390/arch/s390/kernel/traps.c	Thu Sep 11 19:21:05 2003
@@ -83,7 +83,7 @@
 	unsigned long backchain, low_addr, high_addr, ret_addr;
 
 	if (!stack)
-		stack = *stack_pointer;
+		stack = (task == NULL) ? *stack_pointer : &(task->thread.ksp);
 
 	printk("Call Trace:\n");
 	low_addr = ((unsigned long) stack) & PSW_ADDR_INSN;
@@ -120,8 +120,12 @@
 	// debugging aid: "show_stack(NULL);" prints the
 	// back trace for this cpu.
 
-	if(sp == NULL)
-		sp = *stack_pointer;
+	if (!sp) {
+		if (task)
+			sp = (unsigned long *) task->thread.ksp;
+		else
+			sp = *stack_pointer;
+	}
 
 	stack = sp;
 	for (i = 0; i < kstack_depth_to_print; i++) {
@@ -140,7 +144,7 @@
  */
 void dump_stack(void)
 {
-	show_stack(current, 0);
+	show_stack(0, 0);
 }
 
 void show_registers(struct pt_regs *regs)
diff -urN linux-2.6/arch/s390/kernel/vmlinux.lds.S linux-2.6-s390/arch/s390/kernel/vmlinux.lds.S
--- linux-2.6/arch/s390/kernel/vmlinux.lds.S	Mon Sep  8 21:50:01 2003
+++ linux-2.6-s390/arch/s390/kernel/vmlinux.lds.S	Thu Sep 11 19:21:05 2003
@@ -98,6 +98,7 @@
   . = ALIGN(256);
   __initramfs_start = .;
   .init.ramfs : { *(.init.initramfs) }
+  . = ALIGN(2);
   __initramfs_end = .;
   . = ALIGN(256);
   __per_cpu_start = .;
@@ -109,6 +110,7 @@
 
   __bss_start = .;		/* BSS */
   .bss : { *(.bss) }
+  . = ALIGN(2);
   __bss_stop = .;
 
   _end = . ;
diff -urN linux-2.6/arch/s390/mm/fault.c linux-2.6-s390/arch/s390/mm/fault.c
--- linux-2.6/arch/s390/mm/fault.c	Mon Sep  8 21:50:21 2003
+++ linux-2.6-s390/arch/s390/mm/fault.c	Thu Sep 11 19:21:05 2003
@@ -488,7 +488,7 @@
 int pfault_init(void)
 {
 	pfault_refbk_t refbk =
-		{ 0x258, 0, 5, 2, __LC_KERNEL_STACK, 1ULL << 48, 1ULL << 48,
+		{ 0x258, 0, 5, 2, __LC_CURRENT, 1ULL << 48, 1ULL << 48,
 		  __PF_RES_FIELD };
         int rc;
 
@@ -555,8 +555,7 @@
 	/*
 	 * Get the token (= address of kernel stack of affected task).
 	 */
-	tsk = (struct task_struct *)
-		(*((unsigned long *) __LC_PFAULT_INTPARM) - THREAD_SIZE);
+	tsk = (struct task_struct *) __LC_PFAULT_INTPARM;
 
 	/*
 	 * We got all needed information from the lowcore and can
diff -urN linux-2.6/fs/partitions/ibm.c linux-2.6-s390/fs/partitions/ibm.c
--- linux-2.6/fs/partitions/ibm.c	Mon Sep  8 21:50:41 2003
+++ linux-2.6-s390/fs/partitions/ibm.c	Thu Sep 11 19:21:05 2003
@@ -9,6 +9,7 @@
  * 07/10/00 Fixed detection of CMS formatted disks     
  * 02/13/00 VTOC partition support added
  * 12/27/01 fixed PL030593 (CMS reserved minidisk not detected on 64 bit)
+ * 07/24/03 no longer using contents of freed page for CMS label recognition (BZ3611)
  */
 
 #include <linux/config.h>
@@ -98,7 +99,7 @@
 		/*
 		 * VM style CMS1 labeled disk
 		 */
-		int *label = (int *) data;
+		int *label = (int *) vlabel;
 
 		if (label[13] != 0) {
 			printk("CMS1/%8s(MDSK):", name);
diff -urN linux-2.6/include/asm-s390/atomic.h linux-2.6-s390/include/asm-s390/atomic.h
--- linux-2.6/include/asm-s390/atomic.h	Mon Sep  8 21:49:52 2003
+++ linux-2.6-s390/include/asm-s390/atomic.h	Thu Sep 11 19:21:05 2003
@@ -1,13 +1,15 @@
 #ifndef __ARCH_S390_ATOMIC__
 #define __ARCH_S390_ATOMIC__
 
+#ifdef __KERNEL__
 /*
  *  include/asm-s390/atomic.h
  *
  *  S390 version
- *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright (C) 1999-2003 IBM Deutschland Entwicklung GmbH, IBM Corporation
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
- *               Denis Joseph Barrow
+ *               Denis Joseph Barrow,
+ *		 Arnd Bergmann (arndb@de.ibm.com)
  *
  *  Derived from "include/asm-i386/bitops.h"
  *    Copyright (C) 1992, Linus Torvalds
@@ -20,12 +22,13 @@
  * S390 uses 'Compare And Swap' for atomicity in SMP enviroment
  */
 
-typedef struct { volatile int counter; } __attribute__ ((aligned (4))) atomic_t;
+typedef struct {
+	volatile int counter;
+} __attribute__ ((aligned (4))) atomic_t;
 #define ATOMIC_INIT(i)  { (i) }
 
-#define atomic_eieio()          __asm__ __volatile__ ("BCR 15,0")
-
-#define __CS_LOOP(old_val, new_val, ptr, op_val, op_string)		\
+#define __CS_LOOP(ptr, op_val, op_string) ({				\
+	typeof(ptr->counter) old_val, new_val;				\
         __asm__ __volatile__("   l     %0,0(%3)\n"			\
                              "0: lr    %1,%0\n"				\
                              op_string "  %1,%4\n"			\
@@ -33,92 +36,140 @@
                              "   jl    0b"				\
                              : "=&d" (old_val), "=&d" (new_val),	\
 			       "+m" (((atomic_t *)(ptr))->counter)	\
-			     : "a" (ptr), "d" (op_val) : "cc" );
-
+			     : "a" (ptr), "d" (op_val) : "cc" );	\
+	new_val;							\
+})
 #define atomic_read(v)          ((v)->counter)
 #define atomic_set(v,i)         (((v)->counter) = (i))
 
-static __inline__ void atomic_add(int i, atomic_t *v)
+static __inline__ void atomic_add(int i, atomic_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, i, "ar");
+	       __CS_LOOP(v, i, "ar");
 }
-
-static __inline__ int atomic_add_return (int i, atomic_t *v)
+static __inline__ int atomic_add_return(int i, atomic_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, i, "ar");
-	return new_val;
+	return __CS_LOOP(v, i, "ar");
 }
-
-static __inline__ int atomic_add_negative(int i, atomic_t *v)
+static __inline__ int atomic_add_negative(int i, atomic_t * v)
 {
-	int old_val, new_val;
-        __CS_LOOP(old_val, new_val, v, i, "ar");
-        return new_val < 0;
+	return __CS_LOOP(v, i, "ar") < 0;
 }
-
-static __inline__ void atomic_sub(int i, atomic_t *v)
+static __inline__ void atomic_sub(int i, atomic_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, i, "sr");
+	       __CS_LOOP(v, i, "sr");
 }
-
-static __inline__ void atomic_inc(volatile atomic_t *v)
+static __inline__ void atomic_inc(volatile atomic_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, 1, "ar");
+	       __CS_LOOP(v, 1, "ar");
 }
-
-static __inline__ int atomic_inc_return(volatile atomic_t *v)
+static __inline__ int atomic_inc_return(volatile atomic_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, 1, "ar");
-        return new_val;
+	return __CS_LOOP(v, 1, "ar");
 }
-
-static __inline__ int atomic_inc_and_test(volatile atomic_t *v)
+static __inline__ int atomic_inc_and_test(volatile atomic_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, 1, "ar");
-	return new_val != 0;
+	return __CS_LOOP(v, 1, "ar") != 0;
 }
-
-static __inline__ void atomic_dec(volatile atomic_t *v)
+static __inline__ void atomic_dec(volatile atomic_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, 1, "sr");
+	       __CS_LOOP(v, 1, "sr");
 }
-
-static __inline__ int atomic_dec_return(volatile atomic_t *v)
+static __inline__ int atomic_dec_return(volatile atomic_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, 1, "sr");
-        return new_val;
+	return __CS_LOOP(v, 1, "sr");
 }
-
-static __inline__ int atomic_dec_and_test(volatile atomic_t *v)
+static __inline__ int atomic_dec_and_test(volatile atomic_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, 1, "sr");
-        return new_val == 0;
+	return __CS_LOOP(v, 1, "sr") == 0;
 }
-
-static __inline__ void atomic_clear_mask(unsigned long mask, atomic_t *v)
+static __inline__ void atomic_clear_mask(unsigned long mask, atomic_t * v)
+{
+	       __CS_LOOP(v, ~mask, "nr");
+}
+static __inline__ void atomic_set_mask(unsigned long mask, atomic_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, ~mask, "nr");
+	       __CS_LOOP(v, mask, "or");
 }
+#undef __CS_LOOP
 
-static __inline__ void atomic_set_mask(unsigned long mask, atomic_t *v)
+#ifdef __s390x__
+typedef struct {
+	volatile long long counter;
+} __attribute__ ((aligned (8))) atomic64_t;
+#define ATOMIC64_INIT(i)  { (i) }
+
+#define __CSG_LOOP(ptr, op_val, op_string) ({				\
+	typeof(ptr->counter) old_val, new_val;				\
+        __asm__ __volatile__("   lg    %0,0(%3)\n"			\
+                             "0: lgr   %1,%0\n"				\
+                             op_string "  %1,%4\n"			\
+                             "   csg   %0,%1,0(%3)\n"			\
+                             "   jl    0b"				\
+                             : "=&d" (old_val), "=&d" (new_val),	\
+			       "+m" (((atomic_t *)(ptr))->counter)	\
+			     : "a" (ptr), "d" (op_val) : "cc" );	\
+	new_val;							\
+})
+#define atomic64_read(v)          ((v)->counter)
+#define atomic64_set(v,i)         (((v)->counter) = (i))
+
+static __inline__ void atomic64_add(int i, atomic64_t * v)
+{
+	       __CSG_LOOP(v, i, "agr");
+}
+static __inline__ long long atomic64_add_return(int i, atomic64_t * v)
+{
+	return __CSG_LOOP(v, i, "agr");
+}
+static __inline__ long long atomic64_add_negative(int i, atomic64_t * v)
+{
+	return __CSG_LOOP(v, i, "agr") < 0;
+}
+static __inline__ void atomic64_sub(int i, atomic64_t * v)
+{
+	       __CSG_LOOP(v, i, "sgr");
+}
+static __inline__ void atomic64_inc(volatile atomic64_t * v)
+{
+	       __CSG_LOOP(v, 1, "agr");
+}
+static __inline__ long long atomic64_inc_return(volatile atomic64_t * v)
+{
+	return __CSG_LOOP(v, 1, "agr");
+}
+static __inline__ long long atomic64_inc_and_test(volatile atomic64_t * v)
+{
+	return __CSG_LOOP(v, 1, "agr") != 0;
+}
+static __inline__ void atomic64_dec(volatile atomic64_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, mask, "or");
+	       __CSG_LOOP(v, 1, "sgr");
 }
+static __inline__ long long atomic64_dec_return(volatile atomic64_t * v)
+{
+	return __CSG_LOOP(v, 1, "sgr");
+}
+static __inline__ long long atomic64_dec_and_test(volatile atomic64_t * v)
+{
+	return __CSG_LOOP(v, 1, "sgr") == 0;
+}
+static __inline__ void atomic64_clear_mask(unsigned long mask, atomic64_t * v)
+{
+	       __CSG_LOOP(v, ~mask, "ngr");
+}
+static __inline__ void atomic64_set_mask(unsigned long mask, atomic64_t * v)
+{
+	       __CSG_LOOP(v, mask, "ogr");
+}
+
+#undef __CSG_LOOP
+#endif
 
 /*
   returns 0  if expected_oldval==value in *v ( swap was successful )
   returns 1  if unsuccessful.
+
+  This is non-portable, use bitops or spinlocks instead!
 */
 static __inline__ int
 atomic_compare_and_swap(int expected_oldval,int new_val,atomic_t *v)
@@ -137,33 +188,10 @@
         return retval;
 }
 
-/*
-  Spin till *v = expected_oldval then swap with newval.
- */
-static __inline__ void
-atomic_compare_and_swap_spin(int expected_oldval,int new_val,atomic_t *v)
-{
-	unsigned long tmp;
-        __asm__ __volatile__(
-                "0: lr  %1,%3\n"
-                "   cs  %1,%4,0(%2)\n"
-                "   jl  0b\n"
-                : "+m" (v->counter), "=&d" (tmp)
-		: "a" (v), "d" (expected_oldval) , "d" (new_val)
-                : "cc" );
-}
-
-#define atomic_compare_and_swap_debug(where,from,to) \
-if (atomic_compare_and_swap ((from), (to), (where))) {\
-	printk (KERN_WARNING"%s/%d atomic counter:%s couldn't be changed from %d(%s) to %d(%s), was %d\n",\
-		__FILE__,__LINE__,#where,(from),#from,(to),#to,atomic_read (where));\
-        atomic_set(where,(to));\
-}
-
 #define smp_mb__before_atomic_dec()	smp_mb()
 #define smp_mb__after_atomic_dec()	smp_mb()
 #define smp_mb__before_atomic_inc()	smp_mb()
 #define smp_mb__after_atomic_inc()	smp_mb()
 
-#endif                                 /* __ARCH_S390_ATOMIC __            */
-
+#endif /* __KERNEL__ */
+#endif /* __ARCH_S390_ATOMIC__  */
diff -urN linux-2.6/include/asm-s390/current.h linux-2.6-s390/include/asm-s390/current.h
--- linux-2.6/include/asm-s390/current.h	Mon Sep  8 21:50:32 2003
+++ linux-2.6-s390/include/asm-s390/current.h	Thu Sep 11 19:21:05 2003
@@ -12,17 +12,11 @@
 #define _S390_CURRENT_H
 
 #ifdef __KERNEL__
-
-#include <linux/thread_info.h>
+#include <asm/lowcore.h>
 
 struct task_struct;
 
-static inline struct task_struct * get_current(void)
-{
-	return current_thread_info()->task;
-}
-
-#define current get_current()
+#define current ((struct task_struct *const)S390_lowcore.current_task)
 
 #endif
 
diff -urN linux-2.6/include/asm-s390/hardirq.h linux-2.6-s390/include/asm-s390/hardirq.h
--- linux-2.6/include/asm-s390/hardirq.h	Mon Sep  8 21:50:43 2003
+++ linux-2.6-s390/include/asm-s390/hardirq.h	Thu Sep 11 19:21:05 2003
@@ -18,14 +18,17 @@
 #include <linux/cache.h>
 #include <asm/lowcore.h>
 
-/* entry.S is sensitive to the offsets of these fields */
+/* irq_cpustat_t is unused currently, but could be converted
+ * into a percpu variable instead of storing softirq_pending
+ * on the lowcore */
 typedef struct {
 	unsigned int __softirq_pending;
-	unsigned int __syscall_count;
-	struct task_struct * __ksoftirqd_task; /* waitqueue is too large */
-} ____cacheline_aligned irq_cpustat_t;
+} irq_cpustat_t;
 
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
+#define softirq_pending(cpu) (lowcore_ptr[(cpu)]->softirq_pending)
+#define local_softirq_pending() (S390_lowcore.softirq_pending)
+
+#define __ARCH_IRQ_STAT
 
 /*
  * We put the hardirq and softirq counter into the preemption
@@ -76,7 +79,12 @@
 #define hardirq_trylock()	(!in_interrupt())
 #define hardirq_endlock()	do { } while (0)
 
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
+#define irq_enter()							\
+do {									\
+	BUG_ON( hardirq_count() );					\
+	(preempt_count() += HARDIRQ_OFFSET);				\
+} while(0)
+	
 
 extern void do_call_softirq(void);
 
@@ -93,16 +101,10 @@
 #define irq_exit()							\
 do {									\
 	preempt_count() -= IRQ_EXIT_OFFSET;				\
-	if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
+	if (!in_interrupt() && local_softirq_pending())			\
 		/* Use the async. stack for softirq */			\
 		do_call_softirq();					\
 	preempt_enable_no_resched();					\
 } while (0)
 
-#ifndef CONFIG_SMP
-# define synchronize_irq(irq)	barrier()
-#else
-  extern void synchronize_irq(unsigned int irq);
-#endif /* CONFIG_SMP */
-
 #endif /* __ASM_HARDIRQ_H */
diff -urN linux-2.6/include/asm-s390/local.h linux-2.6-s390/include/asm-s390/local.h
--- linux-2.6/include/asm-s390/local.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/include/asm-s390/local.h	Thu Sep 11 19:21:05 2003
@@ -0,0 +1,59 @@
+#ifndef _ASM_LOCAL_H
+#define _ASM_LOCAL_H
+
+#include <linux/config.h>
+#include <linux/percpu.h>
+#include <asm/atomic.h>
+
+#ifndef __s390x__
+
+typedef atomic_t local_t;
+
+#define LOCAL_INIT(i)	ATOMIC_INIT(i)
+#define local_read(v)	atomic_read(v)
+#define local_set(v,i)	atomic_set(v,i)
+
+#define local_inc(v)	atomic_inc(v)
+#define local_dec(v)	atomic_dec(v)
+#define local_add(i, v)	atomic_add(i, v)
+#define local_sub(i, v)	atomic_sub(i, v)
+
+#else
+
+typedef atomic64_t local_t;
+
+#define LOCAL_INIT(i)	ATOMIC64_INIT(i)
+#define local_read(v)	atomic64_read(v)
+#define local_set(v,i)	atomic64_set(v,i)
+
+#define local_inc(v)	atomic64_inc(v)
+#define local_dec(v)	atomic64_dec(v)
+#define local_add(i, v)	atomic64_add(i, v)
+#define local_sub(i, v)	atomic64_sub(i, v)
+
+#endif
+
+#define __local_inc(v)		((v)->counter++)
+#define __local_dec(v)		((v)->counter--)
+#define __local_add(i,v)	((v)->counter+=(i))
+#define __local_sub(i,v)	((v)->counter-=(i))
+
+/*
+ * Use these for per-cpu local_t variables: on some archs they are
+ * much more efficient than these naive implementations.  Note they take
+ * a variable, not an address.
+ */
+#define cpu_local_read(v)	local_read(&__get_cpu_var(v))
+#define cpu_local_set(v, i)	local_set(&__get_cpu_var(v), (i))
+
+#define cpu_local_inc(v)	local_inc(&__get_cpu_var(v))
+#define cpu_local_dec(v)	local_dec(&__get_cpu_var(v))
+#define cpu_local_add(i, v)	local_add((i), &__get_cpu_var(v))
+#define cpu_local_sub(i, v)	local_sub((i), &__get_cpu_var(v))
+
+#define __cpu_local_inc(v)	__local_inc(&__get_cpu_var(v))
+#define __cpu_local_dec(v)	__local_dec(&__get_cpu_var(v))
+#define __cpu_local_add(i, v)	__local_add((i), &__get_cpu_var(v))
+#define __cpu_local_sub(i, v)	__local_sub((i), &__get_cpu_var(v))
+
+#endif /* _ASM_LOCAL_H */
diff -urN linux-2.6/include/asm-s390/lowcore.h linux-2.6-s390/include/asm-s390/lowcore.h
--- linux-2.6/include/asm-s390/lowcore.h	Mon Sep  8 21:50:04 2003
+++ linux-2.6-s390/include/asm-s390/lowcore.h	Thu Sep 11 19:21:05 2003
@@ -65,6 +65,7 @@
 #define __LC_CPUADDR                    0xC68
 #define __LC_IPLDEV                     0xC7C
 #define __LC_JIFFY_TIMER		0xC80
+#define __LC_CURRENT			0xC90
 #else /* __s390x__ */
 #define __LC_KERNEL_STACK               0xD40
 #define __LC_ASYNC_STACK                0xD48
@@ -72,6 +73,7 @@
 #define __LC_CPUADDR                    0xD98
 #define __LC_IPLDEV                     0xDB8
 #define __LC_JIFFY_TIMER		0xDC0
+#define __LC_CURRENT			0xDD8
 #endif /* __s390x__ */
 
 #define __LC_PANIC_MAGIC                0xE00
@@ -169,7 +171,10 @@
         /* SMP info area: defined by DJB */
         __u64        jiffy_timer;              /* 0xc80 */
 	__u32        ext_call_fast;            /* 0xc88 */
-        __u8         pad11[0xe00-0xc8c];       /* 0xc8c */
+	__u32        percpu_offset;            /* 0xc8c */
+	__u32        current_task;	       /* 0xc90 */
+	__u32        softirq_pending;	       /* 0xc94 */
+        __u8         pad11[0xe00-0xc98];       /* 0xc98 */
 
         /* 0xe00 is used as indicator for dump tools */
         /* whether the kernel died with panic() or not */
@@ -244,7 +249,10 @@
         /* SMP info area: defined by DJB */
         __u64        jiffy_timer;              /* 0xdc0 */
 	__u64        ext_call_fast;            /* 0xdc8 */
-        __u8         pad12[0xe00-0xdd0];       /* 0xdd0 */
+	__u64        percpu_offset;            /* 0xdd0 */
+	__u64        current_task;	       /* 0xdd8 */
+	__u64        softirq_pending;	       /* 0xde0 */
+        __u8         pad12[0xe00-0xde8];       /* 0xde8 */
 
         /* 0xe00 is used as indicator for dump tools */
         /* whether the kernel died with panic() or not */
diff -urN linux-2.6/include/asm-s390/pci.h linux-2.6-s390/include/asm-s390/pci.h
--- linux-2.6/include/asm-s390/pci.h	Mon Sep  8 21:50:08 2003
+++ linux-2.6-s390/include/asm-s390/pci.h	Thu Sep 11 19:21:05 2003
@@ -4,7 +4,7 @@
 /* S/390 systems don't have a PCI bus. This file is just here because some stupid .c code
  * includes it even if CONFIG_PCI is not set.
  */
-#define PCI_DMA_BUS_IS_PHYS (1)
+#define PCI_DMA_BUS_IS_PHYS (0)
 
 #endif /* __ASM_S390_PCI_H */
 
diff -urN linux-2.6/include/asm-s390/percpu.h linux-2.6-s390/include/asm-s390/percpu.h
--- linux-2.6/include/asm-s390/percpu.h	Mon Sep  8 21:50:32 2003
+++ linux-2.6-s390/include/asm-s390/percpu.h	Thu Sep 11 19:21:05 2003
@@ -2,5 +2,13 @@
 #define __ARCH_S390_PERCPU__
 
 #include <asm-generic/percpu.h>
+#include <asm/lowcore.h>
+
+/*
+ * s390 uses the generic implementation for per cpu data, with the exception that
+ * the offset of the cpu local data area is cached in the cpu's lowcore memory
+ */
+#undef __get_cpu_var
+#define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, S390_lowcore.percpu_offset))
 
 #endif /* __ARCH_S390_PERCPU__ */
diff -urN linux-2.6/include/asm-s390/processor.h linux-2.6-s390/include/asm-s390/processor.h
--- linux-2.6/include/asm-s390/processor.h	Mon Sep  8 21:50:03 2003
+++ linux-2.6-s390/include/asm-s390/processor.h	Thu Sep 11 19:21:05 2003
@@ -162,6 +162,9 @@
  */
 extern char *task_show_regs(struct task_struct *task, char *buffer);
 
+extern void show_registers(struct pt_regs *regs);
+extern void show_trace(struct task_struct *task, unsigned long *sp);
+
 unsigned long get_wchan(struct task_struct *p);
 #define __KSTK_PTREGS(tsk) ((struct pt_regs *) \
         (((unsigned long) tsk->thread_info + THREAD_SIZE - sizeof(struct pt_regs)) & -8L))
diff -urN linux-2.6/include/asm-s390/ptrace.h linux-2.6-s390/include/asm-s390/ptrace.h
--- linux-2.6/include/asm-s390/ptrace.h	Mon Sep  8 21:50:17 2003
+++ linux-2.6-s390/include/asm-s390/ptrace.h	Thu Sep 11 19:21:05 2003
@@ -301,7 +301,8 @@
 	unsigned long gprs[NUM_GPRS];
 	unsigned int  acrs[NUM_ACRS];
 	unsigned long orig_gpr2;
-	unsigned int  trap;
+	unsigned short ilc;
+	unsigned short trap;
 } __attribute__ ((packed));
 
 /*
diff -urN linux-2.6/include/asm-s390/sections.h linux-2.6-s390/include/asm-s390/sections.h
--- linux-2.6/include/asm-s390/sections.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/include/asm-s390/sections.h	Thu Sep 11 19:21:05 2003
@@ -0,0 +1,6 @@
+#ifndef _S390_SECTIONS_H
+#define _S390_SECTIONS_H
+
+#include <asm-generic/sections.h>
+
+#endif
diff -urN linux-2.6/include/asm-s390/smp.h linux-2.6-s390/include/asm-s390/smp.h
--- linux-2.6/include/asm-s390/smp.h	Mon Sep  8 21:50:06 2003
+++ linux-2.6-s390/include/asm-s390/smp.h	Thu Sep 11 19:21:05 2003
@@ -46,7 +46,7 @@
  
 #define PROC_CHANGE_PENALTY	20		/* Schedule penalty */
 
-#define smp_processor_id() (current_thread_info()->cpu)
+#define smp_processor_id() (S390_lowcore.cpu_data.cpu_nr)
 
 #define cpu_online(cpu) cpu_isset(cpu, cpu_online_map)
 #define cpu_possible(cpu) cpu_isset(cpu, cpu_possible_map)
diff -urN linux-2.6/include/asm-s390/spinlock.h linux-2.6-s390/include/asm-s390/spinlock.h
--- linux-2.6/include/asm-s390/spinlock.h	Mon Sep  8 21:50:59 2003
+++ linux-2.6-s390/include/asm-s390/spinlock.h	Thu Sep 11 19:21:05 2003
@@ -221,18 +221,18 @@
 	
 	__asm__ __volatile__(
 #ifndef __s390x__
-			     "   lhi  %0,1\n"
-			     "   sll  %0,31\n"
-			     "   basr %1,0\n"
-			     "0: cs   %0,%1,0(%3)\n"
+			     "   slr  %0,%0\n"
+			     "   lhi  %1,1\n"
+			     "   sll  %1,31\n"
+			     "   cs   %0,%1,0(%3)"
 #else /* __s390x__ */
-			     "   llihh %0,0x8000\n"
-			     "   basr  %1,0\n"
+			     "   slgr  %0,%0\n"
+			     "   llihh %1,0x8000\n"
 			     "0: csg %0,%1,0(%3)\n"
 #endif /* __s390x__ */
 			     : "=&d" (result), "=&d" (reg), "+m" (rw->lock)
 			     : "a" (&rw->lock) : "cc" );
-	return !result;
+	return result == 0;
 }
 
 #endif /* __ASM_SPINLOCK_H */
diff -urN linux-2.6/include/asm-s390/system.h linux-2.6-s390/include/asm-s390/system.h
--- linux-2.6/include/asm-s390/system.h	Mon Sep  8 21:50:43 2003
+++ linux-2.6-s390/include/asm-s390/system.h	Thu Sep 11 19:21:05 2003
@@ -21,7 +21,7 @@
 
 struct task_struct;
 
-extern struct task_struct *resume(void *, void *);
+extern struct task_struct *__switch_to(void *, void *);
 
 #ifdef __s390x__
 #define __FLAG_SHIFT 56
@@ -88,7 +88,7 @@
 		break;							     \
 	save_fp_regs(&prev->thread.fp_regs);				     \
 	restore_fp_regs(&next->thread.fp_regs);				     \
-	prev = resume(prev,next);					     \
+	prev = __switch_to(prev,next);					     \
 } while (0)
 
 #define nop() __asm__ __volatile__ ("nop")
diff -urN linux-2.6/include/asm-s390/uaccess.h linux-2.6-s390/include/asm-s390/uaccess.h
--- linux-2.6/include/asm-s390/uaccess.h	Mon Sep  8 21:49:56 2003
+++ linux-2.6-s390/include/asm-s390/uaccess.h	Thu Sep 11 19:21:05 2003
@@ -216,7 +216,12 @@
 	__pu_err;						\
 })
 
-#define put_user(x, ptr) __put_user(x, ptr)
+#define put_user(x, ptr)					\
+({								\
+	might_sleep();						\
+	__put_user(x, ptr);					\
+})
+
 
 extern int __put_user_bad(void);
 
@@ -224,18 +229,18 @@
 
 #define __get_user_asm_8(x, ptr, err) \
 ({								\
-	register __typeof__(*(ptr)) const * __from asm("2");	\
-	register __typeof__(x) * __to asm("4");			\
+	register __typeof__(*(ptr)) const * __from asm("4");	\
+	register __typeof__(x) * __to asm("2");			\
 	__from = (ptr);						\
 	__to = &(x);						\
 	__asm__ __volatile__ (					\
 		"   sacf  512\n"				\
-		"0: mvc	  0(8,%1),0(%2)\n"			\
+		"0: mvc	  0(8,%2),0(%4)\n"			\
 		"   sacf  0\n"					\
 		"1:\n"						\
 		__uaccess_fixup					\
 		: "=&d" (err), "=m" (x)				\
-		: "a" (__to),"a" (__from),"K" (-EFAULT),"0" (0)	\
+		: "a" (__to),"K" (-EFAULT),"a" (__from),"0" (0)	\
 		: "cc" );					\
 })
 
@@ -300,7 +305,7 @@
 		"   sacf  0\n"					\
 		"1:\n"						\
 		__uaccess_fixup					\
-		: "=&d" (err), "=d" (x)				\
+		: "=&d" (err), "=&d" (x)			\
 		: "a" (__ptr), "K" (-EFAULT), "0" (0)		\
 		: "cc" );					\
 })
@@ -331,7 +336,11 @@
 	__gu_err;						\
 })
 
-#define get_user(x, ptr) __get_user(x, ptr)
+#define get_user(x, ptr)					\
+({								\
+	might_sleep();						\
+	__get_user(x, ptr);					\
+})
 
 extern int __get_user_bad(void);
 
@@ -351,6 +360,7 @@
 ({                                                              \
         long err = 0;                                           \
         __typeof__(n) __n = (n);                                \
+        might_sleep();						\
         if (__access_ok(to,__n)) {                              \
                 err = __copy_to_user_asm(from, __n, to);        \
         }                                                       \
@@ -370,6 +380,7 @@
 ({                                                              \
         long err = 0;                                           \
         __typeof__(n) __n = (n);                                \
+        might_sleep();						\
         if (__access_ok(from,__n)) {                            \
                 err = __copy_from_user_asm(to, __n, from);      \
         }                                                       \
@@ -461,6 +472,7 @@
 strncpy_from_user(char *dst, const char *src, long count)
 {
         long res = -EFAULT;
+        might_sleep();
         if (access_ok(VERIFY_READ, src, 1))
                 res = __strncpy_from_user(dst, src, count);
         return res;
@@ -477,6 +489,7 @@
 static inline unsigned long
 strnlen_user(const char * src, unsigned long n)
 {
+	might_sleep();
 	__asm__ __volatile__ (
 		"   alr   %0,%1\n"
 		"   slr   0,0\n"
@@ -510,6 +523,7 @@
 static inline unsigned long
 strnlen_user(const char * src, unsigned long n)
 {
+	might_sleep();
 #if 0
 	__asm__ __volatile__ (
 		"   algr  %0,%1\n"
@@ -574,6 +588,7 @@
 static inline unsigned long
 clear_user(void *to, unsigned long n)
 {
+	might_sleep();
 	if (access_ok(VERIFY_WRITE, to, n))
 		n = __clear_user(to, n);
 	return n;
