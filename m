Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbTH2RG4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbTH2RGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:06:33 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:32190 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261440AbTH2RE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:04:56 -0400
Date: Fri, 29 Aug 2003 19:04:27 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (1/8): s390 arch.
Message-ID: <20030829170427.GB1242@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Fix cflags setting for z990.
 - New default configuration.
 - Fix 32 bit emulation of sys_sysinfo and sys_clone.
 - Add code for -ERESTART_RESTARTBLOCK in 32 bit signal emulation.
 - Rename resume to __switch_to to avoid name clash.
 - Some micro optimizations:
    + Put cpu number to lowcore.
    + Put percpu_offset to lowcore.
 - Fix show_trace and show_stack.
 - Add alignments to linker script.
 - Fix bug in CMS label recognition in ibm.c
 - Add atomic64_t and related funtions.
 - Add include/asm-s390/local.h
 - Fix get_user for 8 byte values for 31 bit.

diffstat:
 arch/s390/Makefile               |    2 
 arch/s390/defconfig              |   26 +++--
 arch/s390/kernel/compat_ioctl.c  |    1 
 arch/s390/kernel/compat_linux.c  |   17 ++-
 arch/s390/kernel/compat_signal.c |    9 +
 arch/s390/kernel/entry.S         |   16 +--
 arch/s390/kernel/entry64.S       |   14 +-
 arch/s390/kernel/setup.c         |    1 
 arch/s390/kernel/smp.c           |    8 +
 arch/s390/kernel/traps.c         |   12 +-
 arch/s390/kernel/vmlinux.lds.S   |    2 
 fs/partitions/ibm.c              |    3 
 include/asm-s390/atomic.h        |  198 ++++++++++++++++++++++-----------------
 include/asm-s390/local.h         |   59 +++++++++++
 include/asm-s390/lowcore.h       |    6 -
 include/asm-s390/percpu.h        |    8 +
 include/asm-s390/sections.h      |    6 +
 include/asm-s390/smp.h           |    2 
 include/asm-s390/system.h        |    4 
 include/asm-s390/uaccess.h       |    8 -
 20 files changed, 273 insertions(+), 129 deletions(-)

diff -urN linux-2.6/arch/s390/Makefile linux-2.6-s390/arch/s390/Makefile
--- linux-2.6/arch/s390/Makefile	Sat Aug 23 01:52:59 2003
+++ linux-2.6-s390/arch/s390/Makefile	Fri Aug 29 18:55:06 2003
@@ -32,7 +32,7 @@
 
 cflags-$(CONFIG_MARCH_G5)   += $(call check_gcc,-march=g5,)
 cflags-$(CONFIG_MARCH_Z900) += $(call check_gcc,-march=z900,)
-cflags-$(CONFIG_MARCH_Z990) += $(call check_gcc,-march=trex,)
+cflags-$(CONFIG_MARCH_Z990) += $(call check_gcc,-march=z990,)
 
 CFLAGS		+= $(cflags-y)
 CFLAGS		+= $(call check_gcc,-finline-limit=10000,)
diff -urN linux-2.6/arch/s390/defconfig linux-2.6-s390/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	Sat Aug 23 01:58:58 2003
+++ linux-2.6-s390/arch/s390/defconfig	Fri Aug 29 18:55:06 2003
@@ -10,6 +10,7 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
+# CONFIG_BROKEN is not set
 
 #
 # General setup
@@ -19,10 +20,14 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 CONFIG_LOG_BUF_SHIFT=17
+# CONFIG_IKCONFIG is not set
 # CONFIG_EMBEDDED is not set
 # CONFIG_KALLSYMS is not set
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
 
 #
 # Loadable module support
@@ -83,18 +88,20 @@
 CONFIG_CCW=y
 
 #
-# Block device drivers
+# Block devices
 #
 CONFIG_BLK_DEV_LOOP=m
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_BLK_DEV_XPRAM=m
+# CONFIG_LBD is not set
 
 #
 # S/390 block device drivers
 #
+CONFIG_BLK_DEV_XPRAM=m
 CONFIG_DASD=y
 # CONFIG_DASD_PROFILE is not set
 CONFIG_DASD_ECKD=y
@@ -154,7 +161,6 @@
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 # CONFIG_NETLINK_DEV is not set
-# CONFIG_NETFILTER is not set
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -176,7 +182,9 @@
 # CONFIG_INET6_ESP is not set
 # CONFIG_INET6_IPCOMP is not set
 # CONFIG_IPV6_TUNNEL is not set
-# CONFIG_XFRM_USER is not set
+# CONFIG_DECNET is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_NETFILTER is not set
 
 #
 # SCTP Configuration (EXPERIMENTAL)
@@ -186,8 +194,6 @@
 # CONFIG_ATM is not set
 # CONFIG_VLAN_8021Q is not set
 # CONFIG_LLC is not set
-# CONFIG_DECNET is not set
-# CONFIG_BRIDGE is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
 # CONFIG_NET_DIVERT is not set
@@ -379,11 +385,17 @@
 # CONFIG_EFI_PARTITION is not set
 
 #
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
 # Kernel hacking
 #
 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 
 #
@@ -407,6 +419,8 @@
 # CONFIG_CRYPTO_TWOFISH is not set
 # CONFIG_CRYPTO_SERPENT is not set
 # CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
 # CONFIG_CRYPTO_DEFLATE is not set
 # CONFIG_CRYPTO_TEST is not set
 
diff -urN linux-2.6/arch/s390/kernel/compat_ioctl.c linux-2.6-s390/arch/s390/kernel/compat_ioctl.c
--- linux-2.6/arch/s390/kernel/compat_ioctl.c	Sat Aug 23 01:57:25 2003
+++ linux-2.6-s390/arch/s390/kernel/compat_ioctl.c	Fri Aug 29 18:55:06 2003
@@ -23,6 +23,7 @@
 #include <asm/types.h>
 #include <asm/uaccess.h>
 
+#include <linux/blkdev.h>
 #include <linux/blkpg.h>
 #include <linux/cdrom.h>
 #include <linux/dm-ioctl.h>
diff -urN linux-2.6/arch/s390/kernel/compat_linux.c linux-2.6-s390/arch/s390/kernel/compat_linux.c
--- linux-2.6/arch/s390/kernel/compat_linux.c	Sat Aug 23 01:58:43 2003
+++ linux-2.6-s390/arch/s390/kernel/compat_linux.c	Fri Aug 29 18:55:06 2003
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
--- linux-2.6/arch/s390/kernel/compat_signal.c	Sat Aug 23 02:00:32 2003
+++ linux-2.6-s390/arch/s390/kernel/compat_signal.c	Fri Aug 29 18:55:06 2003
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
@@ -639,6 +643,11 @@
 			regs->gprs[2] = regs->orig_gpr2;
 			regs->psw.addr -= 2;
 		}
+		/* Restart the system call with a new system call number */
+		if (regs->gprs[2] == -ERESTART_RESTARTBLOCK) {
+			regs->gprs[2] = __NR_restart_syscall;
+			set_thread_flag(TIF_RESTART_SVC);
+		}
 	}
 	return 0;
 }
diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-s390/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	Sat Aug 23 01:52:57 2003
+++ linux-2.6-s390/arch/s390/kernel/entry.S	Fri Aug 29 18:55:06 2003
@@ -123,25 +123,25 @@
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
 	l	%r3,__THREAD_info(%r3)  # load thread_info from task struct
 	ahi	%r3,8192
 	st	%r3,__LC_KERNEL_STACK	# __LC_KERNEL_STACK = new kernel stack
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-s390/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	Sat Aug 23 01:52:57 2003
+++ linux-2.6-s390/arch/s390/kernel/entry64.S	Fri Aug 29 18:55:06 2003
@@ -111,23 +111,23 @@
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
 	lg	%r3,__THREAD_info(%r3)  # load thread_info from task struct
 	aghi	%r3,16384
 	stg	%r3,__LC_KERNEL_STACK	# __LC_KERNEL_STACK = new kernel stack
diff -urN linux-2.6/arch/s390/kernel/setup.c linux-2.6-s390/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	Sat Aug 23 01:52:07 2003
+++ linux-2.6-s390/arch/s390/kernel/setup.c	Fri Aug 29 18:55:06 2003
@@ -97,7 +97,6 @@
          */
         asm volatile ("stidp %0": "=m" (S390_lowcore.cpu_data.cpu_id));
         S390_lowcore.cpu_data.cpu_addr = addr;
-        S390_lowcore.cpu_data.cpu_nr = nr;
 
         /*
          * Force FPU initialization:
diff -urN linux-2.6/arch/s390/kernel/smp.c linux-2.6-s390/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	Sat Aug 23 01:50:51 2003
+++ linux-2.6-s390/arch/s390/kernel/smp.c	Fri Aug 29 18:55:06 2003
@@ -514,8 +514,10 @@
 	__asm__ __volatile__("stam  0,15,0(%0)"
 			     : : "a" (&cpu_lowcore->access_regs_save_area)
 			     : "memory");
-        eieio();
-        signal_processor(cpu,sigp_restart);
+	cpu_lowcore->percpu_offset = __per_cpu_offset[cpu];
+        cpu_lowcore->cpu_data.cpu_nr = cpu;
+	eieio();
+	signal_processor(cpu,sigp_restart);
 
 	while (!cpu_online(cpu));
 	return 0;
@@ -560,6 +562,7 @@
 {
 	cpu_set(smp_processor_id(), cpu_online_map);
 	cpu_set(smp_processor_id(), cpu_possible_map);
+	S390_lowcore.percpu_offset = __per_cpu_offset[smp_processor_id()];
 }
 
 void smp_cpus_done(unsigned int max_cpus)
@@ -577,6 +580,7 @@
         return 0;
 }
 
+EXPORT_SYMBOL(cpu_possible_map);
 EXPORT_SYMBOL(lowcore_ptr);
 EXPORT_SYMBOL(smp_ctl_set_bit);
 EXPORT_SYMBOL(smp_ctl_clear_bit);
diff -urN linux-2.6/arch/s390/kernel/traps.c linux-2.6-s390/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	Sat Aug 23 01:54:19 2003
+++ linux-2.6-s390/arch/s390/kernel/traps.c	Fri Aug 29 18:55:06 2003
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
--- linux-2.6/arch/s390/kernel/vmlinux.lds.S	Sat Aug 23 01:54:22 2003
+++ linux-2.6-s390/arch/s390/kernel/vmlinux.lds.S	Fri Aug 29 18:55:06 2003
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
diff -urN linux-2.6/fs/partitions/ibm.c linux-2.6-s390/fs/partitions/ibm.c
--- linux-2.6/fs/partitions/ibm.c	Sat Aug 23 02:02:03 2003
+++ linux-2.6-s390/fs/partitions/ibm.c	Fri Aug 29 18:55:06 2003
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
--- linux-2.6/include/asm-s390/atomic.h	Sat Aug 23 01:52:07 2003
+++ linux-2.6-s390/include/asm-s390/atomic.h	Fri Aug 29 18:55:06 2003
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
diff -urN linux-2.6/include/asm-s390/local.h linux-2.6-s390/include/asm-s390/local.h
--- linux-2.6/include/asm-s390/local.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/include/asm-s390/local.h	Fri Aug 29 18:55:07 2003
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
--- linux-2.6/include/asm-s390/lowcore.h	Sat Aug 23 01:55:41 2003
+++ linux-2.6-s390/include/asm-s390/lowcore.h	Fri Aug 29 18:55:07 2003
@@ -169,7 +169,8 @@
         /* SMP info area: defined by DJB */
         __u64        jiffy_timer;              /* 0xc80 */
 	__u32        ext_call_fast;            /* 0xc88 */
-        __u8         pad11[0xe00-0xc8c];       /* 0xc8c */
+	__u32        percpu_offset;            /* 0xc8c */
+        __u8         pad11[0xe00-0xc90];       /* 0xc90 */
 
         /* 0xe00 is used as indicator for dump tools */
         /* whether the kernel died with panic() or not */
@@ -244,7 +245,8 @@
         /* SMP info area: defined by DJB */
         __u64        jiffy_timer;              /* 0xdc0 */
 	__u64        ext_call_fast;            /* 0xdc8 */
-        __u8         pad12[0xe00-0xdd0];       /* 0xdd0 */
+	__u64        percpu_offset;            /* 0xdd0 */
+        __u8         pad12[0xe00-0xdd8];       /* 0xdd8 */
 
         /* 0xe00 is used as indicator for dump tools */
         /* whether the kernel died with panic() or not */
diff -urN linux-2.6/include/asm-s390/percpu.h linux-2.6-s390/include/asm-s390/percpu.h
--- linux-2.6/include/asm-s390/percpu.h	Sat Aug 23 02:01:33 2003
+++ linux-2.6-s390/include/asm-s390/percpu.h	Fri Aug 29 18:55:07 2003
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
diff -urN linux-2.6/include/asm-s390/sections.h linux-2.6-s390/include/asm-s390/sections.h
--- linux-2.6/include/asm-s390/sections.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/include/asm-s390/sections.h	Fri Aug 29 18:55:07 2003
@@ -0,0 +1,6 @@
+#ifndef _S390_SECTIONS_H
+#define _S390_SECTIONS_H
+
+#include <asm-generic/sections.h>
+
+#endif
diff -urN linux-2.6/include/asm-s390/smp.h linux-2.6-s390/include/asm-s390/smp.h
--- linux-2.6/include/asm-s390/smp.h	Sat Aug 23 01:56:13 2003
+++ linux-2.6-s390/include/asm-s390/smp.h	Fri Aug 29 18:55:07 2003
@@ -46,7 +46,7 @@
  
 #define PROC_CHANGE_PENALTY	20		/* Schedule penalty */
 
-#define smp_processor_id() (current_thread_info()->cpu)
+#define smp_processor_id() (S390_lowcore.cpu_data.cpu_nr)
 
 #define cpu_online(cpu) cpu_isset(cpu, cpu_online_map)
 #define cpu_possible(cpu) cpu_isset(cpu, cpu_possible_map)
diff -urN linux-2.6/include/asm-s390/system.h linux-2.6-s390/include/asm-s390/system.h
--- linux-2.6/include/asm-s390/system.h	Sat Aug 23 02:02:36 2003
+++ linux-2.6-s390/include/asm-s390/system.h	Fri Aug 29 18:55:07 2003
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
--- linux-2.6/include/asm-s390/uaccess.h	Sat Aug 23 01:53:03 2003
+++ linux-2.6-s390/include/asm-s390/uaccess.h	Fri Aug 29 18:55:07 2003
@@ -224,18 +224,18 @@
 
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
 
