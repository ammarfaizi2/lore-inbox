Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268681AbUH3SWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268681AbUH3SWw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUH3SWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:22:52 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:26803 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S268697AbUH3SDD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:03:03 -0400
Date: Mon, 30 Aug 2004 20:03:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: kernel stack options.
Message-ID: <20040830180329.GB6411@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: kernel stack options.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

This adds support for the new compiler options -mkernel-backchain,
-mstack-size, -mstack-guard, -mwarn-dynamicstack and -mwarn-framesize.

The option -mkernel-backchain enables the use of modified layout for
the stack frames of kernel functions. This breaks the ABI, modules
compiled with the option won't work on a kernel compiled with the
option and vice versa. The positive effect of the option is a drastic
reduction of kernel stack use. The trick is that the new frame layout
allows to overlap the 96 (31 bit)/160 (64 bit) byte bias areas of the
functions on the call chain. This lowers the minimal stack usage of a
function from 96 bytes to 16 bytes (31 bit) and 160 bytes to 24 bytes
(64 bit). The kernel stack use is decreased to a point where it is
possible to use 4K (31 bit) / 8K (64 bit) stacks. The split into
process stack and interrupt stack is already in place.

The options -mstack-size and -mstack-guard are used to detect kernel
stack overflows. The compiler adds code to the prolog of every function
that causes an illegal operation if the kernel stack is about to overflow.

The options -mwarn-dynamicstack and -mwarn-framesize cause the compiler
to emit warnings if a function uses dynamic stack allocation or if the
function frame size is bigger then a specified limit.

To play safe all the new options are configuratable.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/Kconfig              |  126 ++++++++++++++++++++++++++++++++---------
 arch/s390/Makefile             |   26 +++++++-
 arch/s390/defconfig            |   14 +++-
 arch/s390/kernel/asm-offsets.c |    4 +
 arch/s390/kernel/entry.S       |   85 +++++++++++++++++++--------
 arch/s390/kernel/entry64.S     |   91 ++++++++++++++++++++---------
 arch/s390/kernel/head.S        |    6 +
 arch/s390/kernel/head64.S      |    6 +
 arch/s390/kernel/process.c     |   68 ++++++++--------------
 arch/s390/kernel/setup.c       |    4 +
 arch/s390/kernel/smp.c         |   14 +++-
 arch/s390/kernel/traps.c       |   96 ++++++++++++++++++++++---------
 include/asm-s390/lowcore.h     |    8 +-
 include/asm-s390/processor.h   |   19 ++++++
 include/asm-s390/thread_info.h |   38 +++++++-----
 15 files changed, 428 insertions(+), 177 deletions(-)

diff -urN linux-2.6/arch/s390/Kconfig linux-2.6-s390/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	Mon Aug 30 19:14:07 2004
+++ linux-2.6-s390/arch/s390/Kconfig	Mon Aug 30 19:14:22 2004
@@ -48,33 +48,6 @@
 	depends on ARCH_S390X = 'n'
 	default y
 
-choice
-	prompt "Processor type"
-	default MARCH_G5
-
-config MARCH_G5
-	bool "S/390 model G5 and G6"
-	depends on ARCH_S390_31
-	help
-	  Select this to build a 31 bit kernel that works
-	  on all S/390 and zSeries machines.
-
-config MARCH_Z900
-	bool "IBM eServer zSeries model z800 and z900"
-	help
-	  Select this to optimize for zSeries machines. This
-	  will enable some optimizations that are not available
-	  on older 31 bit only CPUs.
-
-config MARCH_Z990
-	bool "IBM eServer zSeries model z890 and z990"
-	help
-	  Select this enable optimizations for model z890/z990.
-	  This will be slightly faster but does not work on
-	  older machines such as the z900.
-
-endchoice
-
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
@@ -149,6 +122,105 @@
 	  This allows you to run 32-bit Linux/ELF binaries on your zSeries
 	  in 64 bit mode. Everybody wants this; say Y.
 
+comment "Code generation options"
+
+choice 
+	prompt "Processor type"
+	default MARCH_G5
+
+config MARCH_G5
+	bool "S/390 model G5 and G6"
+	depends on ARCH_S390_31
+	help
+	  Select this to build a 31 bit kernel that works
+	  on all S/390 and zSeries machines.
+
+config MARCH_Z900
+	bool "IBM eServer zSeries model z800 and z900"
+	help
+	  Select this to optimize for zSeries machines. This
+	  will enable some optimizations that are not available
+	  on older 31 bit only CPUs.
+
+config MARCH_Z990
+	bool "IBM eServer zSeries model z890 and z990"
+	help
+	  Select this enable optimizations for model z890/z990.
+	  This will be slightly faster but does not work on
+	  older machines such as the z900.
+
+endchoice 
+
+config PACK_STACK
+	bool "Pack kernel stack"
+	help
+	  This option enables the compiler option -mkernel-backchain if it
+	  is available. If the option is available the compiler supports
+	  the new stack layout which dramatically reduces the minimum stack
+	  frame size. With an old compiler a non-leaf function needs a
+	  minimum of 96 bytes on 31 bit and 160 bytes on 64 bit. With
+	  -mkernel-backchain the minimum size drops to 16 byte on 31 bit
+	  and 24 byte on 64 bit.
+
+	  Say Y if you are unsure.
+
+config SMALL_STACK
+	bool "Use 4kb/8kb for kernel stack instead of 8kb/16kb"
+	depends on PACK_STACK
+	help
+	  If you say Y here and the compiler supports the -mkernel-backchain
+	  option the kernel will use a smaller kernel stack size. For 31 bit
+	  the reduced size is 4kb instead of 8kb and for 64 bit it is 8kb
+	  instead of 16kb. This allows to run more thread on a system and
+	  reduces the pressure on the memory management for higher order
+	  page allocations.
+
+	  Say N if you are unsure.
+	
+
+config CHECK_STACK
+	bool "Detect kernel stack overflow"
+	help
+	  This option enables the compiler option -mstack-guard and
+	  -mstack-size if they are available. If the compiler supports them
+	  it will emit additional code to each function prolog to trigger
+	  an illegal operation if the kernel stack is about to overflow.
+
+	  Say N if you are unsure.
+
+config STACK_GUARD
+	int "Size of the guard area (128-1024)"
+	range 128 1024
+	depends on CHECK_STACK
+	default "256"
+	help
+	  This allows you to specify the size of the guard area at the lower
+	  end of the kernel stack. If the kernel stack points into the guard
+	  area on function entry an illegal operation is triggered. The size
+	  needs to be a power of 2. Please keep in mind that the size of an
+	  interrupt frame is 184 bytes for 31 bit and 328 bytes on 64 bit.
+	  The minimum size for the stack guard should be 256 for 31 bit and
+	  512 for 64 bit.
+
+config WARN_STACK
+	bool "Emit compiler warnings for function with broken stack usage"
+	help
+	  This option enables the compiler options -mwarn-framesize and
+	  -mwarn-dynamicstack. If the compiler supports these options it
+	  will generate warnings for function which either use alloca or
+	  create a stack frame bigger then CONFIG_WARN_STACK_SIZE.
+
+	  Say N if you are unsure.
+
+config WARN_STACK_SIZE
+	int "Maximum frame size considered safe (128-2048)"
+	range 128 2048
+	depends on WARN_STACK
+	default "256"
+	help
+	  This allows you to specify the maximum frame size a function may
+	  have without the compiler complaining about it.
+
 comment "I/O subsystem configuration"
 
 config MACHCHK_WARNING
diff -urN linux-2.6/arch/s390/Makefile linux-2.6-s390/arch/s390/Makefile
--- linux-2.6/arch/s390/Makefile	Mon Aug 30 19:14:07 2004
+++ linux-2.6-s390/arch/s390/Makefile	Mon Aug 30 19:14:22 2004
@@ -18,6 +18,7 @@
 CFLAGS		+= -m31
 AFLAGS		+= -m31
 UTS_MACHINE	:= s390
+STACK_SIZE	:= 8192
 endif
 
 ifdef CONFIG_ARCH_S390X
@@ -26,16 +27,37 @@
 CFLAGS		+= -m64
 AFLAGS		+= -m64
 UTS_MACHINE	:= s390x
+STACK_SIZE	:= 16384
 endif
 
 cflags-$(CONFIG_MARCH_G5)   += $(call cc-option,-march=g5)
 cflags-$(CONFIG_MARCH_Z900) += $(call cc-option,-march=z900)
 cflags-$(CONFIG_MARCH_Z990) += $(call cc-option,-march=z990)
 
-CFLAGS		+= $(cflags-y)
+ifeq ($(call cc-option-yn,-mkernel-backchain),y)
+cflags-$(CONFIG_PACK_STACK)  += -mkernel-backchain -D__PACK_STACK
+aflags-$(CONFIG_PACK_STACK)  += -D__PACK_STACK
+cflags-$(CONFIG_SMALL_STACK) += -D__SMALL_STACK
+aflags-$(CONFIG_SMALL_STACK) += -D__SMALL_STACK
+ifdef CONFIG_SMALL_STACK
+STACK_SIZE := $(shell echo $$(($(STACK_SIZE)/2)) )
+endif
+endif
+
+ifeq ($(call cc-option-yn,-mstack-size=8192 -mstack-guard=128),y)
+cflags-$(CONFIG_CHECK_STACK) += -mstack-size=$(STACK_SIZE)
+cflags-$(CONFIG_CHECK_STACK) += -mstack-guard=$(CONFIG_STACK_GUARD)
+endif
+
+ifeq ($(call cc-option-yn,-mwarn-dynamicstack),y)
+cflags-$(CONFIG_WARN_STACK) += -mwarn-dynamicstack
+cflags-$(CONFIG_WARN_STACK) += -mwarn-framesize=$(CONFIG_WARN_STACK_SIZE)
+endif
+
+CFLAGS		+= -mbackchain $(cflags-y)
 CFLAGS		+= $(call cc-option,-finline-limit=10000)
 CFLAGS 		+= -pipe -fno-strength-reduce -Wno-sign-compare 
-CFLAGS		+= -mbackchain
+AFLAGS		+= $(aflags-y)
 
 OBJCOPYFLAGS	:= -O binary
 LDFLAGS_vmlinux := -e start
diff -urN linux-2.6/arch/s390/defconfig linux-2.6-s390/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	Mon Aug 30 19:14:22 2004
+++ linux-2.6-s390/arch/s390/defconfig	Mon Aug 30 19:14:22 2004
@@ -58,15 +58,23 @@
 # CONFIG_ARCH_S390X is not set
 # CONFIG_64BIT is not set
 CONFIG_ARCH_S390_31=y
-CONFIG_MARCH_G5=y
-# CONFIG_MARCH_Z900 is not set
-# CONFIG_MARCH_Z990 is not set
 CONFIG_SMP=y
 CONFIG_NR_CPUS=32
 # CONFIG_HOTPLUG_CPU is not set
 CONFIG_MATHEMU=y
 
 #
+# Code generation options
+#
+CONFIG_MARCH_G5=y
+# CONFIG_MARCH_Z900 is not set
+# CONFIG_MARCH_Z990 is not set
+CONFIG_PACK_STACK=y
+# CONFIG_SMALL_STACK is not set
+# CONFIG_CHECK_STACK is not set
+# CONFIG_WARN_STACK is not set
+
+#
 # I/O subsystem configuration
 #
 CONFIG_MACHCHK_WARNING=y
diff -urN linux-2.6/arch/s390/kernel/asm-offsets.c linux-2.6-s390/arch/s390/kernel/asm-offsets.c
--- linux-2.6/arch/s390/kernel/asm-offsets.c	Sat Aug 14 12:55:09 2004
+++ linux-2.6-s390/arch/s390/kernel/asm-offsets.c	Mon Aug 30 19:14:22 2004
@@ -39,5 +39,9 @@
 	DEFINE(__PT_ILC, offsetof(struct pt_regs, ilc),);
 	DEFINE(__PT_TRAP, offsetof(struct pt_regs, trap),);
 	DEFINE(__PT_SIZE, sizeof(struct pt_regs),);
+	BLANK();
+	DEFINE(__SF_BACKCHAIN, offsetof(struct stack_frame, back_chain),);
+	DEFINE(__SF_GPRS, offsetof(struct stack_frame, gprs),);
+	DEFINE(__SF_EMPTY, offsetof(struct stack_frame, empty1),);
 	return 0;
 }
diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-s390/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	Mon Aug 30 19:14:22 2004
+++ linux-2.6-s390/arch/s390/kernel/entry.S	Mon Aug 30 19:14:22 2004
@@ -19,6 +19,7 @@
 #include <asm/thread_info.h>
 #include <asm/offsets.h>
 #include <asm/unistd.h>
+#include <asm/page.h>
 
 /*
  * Stack layout for the system_call stack entry.
@@ -52,6 +53,9 @@
 		 _TIF_RESTART_SVC | _TIF_SINGLE_STEP )
 _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NEED_RESCHED)
 
+STACK_SHIFT = PAGE_SHIFT + THREAD_ORDER
+STACK_SIZE  = 1 << STACK_SHIFT
+
 #define BASED(name) name-system_call(%r13)
 
 /*
@@ -86,10 +90,16 @@
 	bnz	BASED(1f)
 0:	l	%r14,__LC_ASYNC_STACK	# are we already on the async stack ?
 	slr	%r14,%r15
-	sra	%r14,13
+	sra	%r14,STACK_SHIFT
 	be	BASED(2f)
 1:	l	%r15,__LC_ASYNC_STACK
 	.endif
+#ifdef CONFIG_CHECK_STACK
+	b	BASED(3f)
+2:	tml	%r15,STACK_SIZE - CONFIG_STACK_GUARD
+	bz	BASED(stack_overflow)
+3:
+#endif	
 2:	s	%r15,BASED(.Lc_spsize)	# make room for registers & psw
 	mvc	SP_PSW(8,%r15),0(%r12)	# move user PSW to stack
 	la	%r12,\psworg
@@ -99,7 +109,7 @@
 	st	%r12,SP_ILC(%r15)
 	mvc	SP_R12(16,%r15),\savearea # move %r12-%r15 to stack
 	la	%r12,0
-	st	%r12,0(%r15)		# clear back chain
+	st	%r12,__SF_BACKCHAIN(%r15)	# clear back chain
 	.endm
 
 	.macro  RESTORE_ALL sync
@@ -124,19 +134,19 @@
 __switch_to_base:
 	tm	__THREAD_per(%r3),0xe8		# new process is using per ?
 	bz	__switch_to_noper-__switch_to_base(%r1)	# if not we're fine
-        stctl   %c9,%c11,24(%r15)		# We are using per stuff
-        clc     __THREAD_per(12,%r3),24(%r15)
+        stctl   %c9,%c11,__SF_EMPTY(%r15)	# We are using per stuff
+        clc     __THREAD_per(12,%r3),__SF_EMPTY(%r15)
         be      __switch_to_noper-__switch_to_base(%r1)	# we got away w/o bashing TLB's
         lctl    %c9,%c11,__THREAD_per(%r3)	# Nope we didn't
 __switch_to_noper:
-        stm     %r6,%r15,24(%r15)       # store __switch_to registers of prev task
+        stm     %r6,%r15,__SF_GPRS(%r15)# store __switch_to registers of prev task
 	st	%r15,__THREAD_ksp(%r2)	# store kernel stack to prev->tss.ksp
 	l	%r15,__THREAD_ksp(%r3)	# load kernel stack from next->tss.ksp
-	lm	%r6,%r15,24(%r15)	# load __switch_to registers of next task
+	lm	%r6,%r15,__SF_GPRS(%r15)# load __switch_to registers of next task
 	st	%r3,__LC_CURRENT	# __LC_CURRENT = current task struct
 	l	%r3,__THREAD_info(%r3)  # load thread_info from task struct
 	st	%r3,__LC_THREAD_INFO
-	ahi	%r3,8192
+	ahi	%r3,STACK_SIZE
 	st	%r3,__LC_KERNEL_STACK	# __LC_KERNEL_STACK = new kernel stack
 	br	%r14
 
@@ -146,24 +156,24 @@
  */
 	.global do_call_softirq
 do_call_softirq:
-	stnsm	24(%r15),0xfc
-	stm	%r12,%r15,28(%r15)
+	stnsm	__SF_EMPTY(%r15),0xfc
+	stm	%r12,%r15,__SF_GPRS(%r15)
 	lr	%r12,%r15
         basr    %r13,0
 do_call_base:
 	l	%r0,__LC_ASYNC_STACK
 	slr     %r0,%r15
-	sra	%r0,13
+	sra	%r0,STACK_SHIFT
 	be	0f-do_call_base(%r13)
 	l	%r15,__LC_ASYNC_STACK
 0:	sl	%r15,.Lc_overhead-do_call_base(%r13)
-        st	%r12,0(%r15)	# store backchain
+        st	%r12,__SF_BACKCHAIN(%r15)	# store backchain
 	l	%r1,.Ldo_softirq-do_call_base(%r13)
 	basr	%r14,%r1
-	lm	%r12,%r15,28(%r12)
-	ssm	24(%r15)
+	lm	%r12,%r15,__SF_GPRS(%r12)
+	ssm	__SF_EMPTY(%r15)
 	br	%r14
-	
+
 __critical_start:
 /*
  * SVC interrupt handler routine. System calls are synchronous events and
@@ -309,7 +319,7 @@
 	st	%r15,SP_R15(%r15)	# store stack pointer for new kthread
 0:	l       %r1,BASED(.Lschedtail)
 	basr    %r14,%r1
-        stosm   24(%r15),0x03     # reenable interrupts
+        stosm   __SF_EMPTY(%r15),0x03     # reenable interrupts
 	b	BASED(sysc_return)
 
 #
@@ -460,7 +470,7 @@
 	mvc	__THREAD_per+__PER_address(4,%r1),__LC_PER_ADDRESS
 	mvc	__THREAD_per+__PER_access_id(1,%r1),__LC_PER_ACCESS_ID
 	oi	__TI_flags+3(%r9),_TIF_SINGLE_STEP # set TIF_SINGLE_STEP
-	stosm	24(%r15),0x03		# reenable interrupts
+	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
 	b	BASED(sysc_do_svc)
 
 /*
@@ -496,16 +506,16 @@
 	l	%r1,SP_R15(%r15)
 	s	%r1,BASED(.Lc_spsize)
 	mvc	SP_PTREGS(__PT_SIZE,%r1),SP_PTREGS(%r15)
-        xc      0(4,%r1),0(%r1)        # clear back chain
+        xc      __SF_BACKCHAIN(4,%r1),__SF_BACKCHAIN(%r1) # clear back chain
 	lr	%r15,%r1
 io_resume_loop:
 	tm	__TI_flags+3(%r9),_TIF_NEED_RESCHED
 	bno	BASED(io_leave)
 	mvc     __TI_precount(4,%r9),BASED(.Lc_pactive)
-        stosm   24(%r15),0x03          # reenable interrupts
+        stosm   __SF_EMPTY(%r15),0x03  # reenable interrupts
         l       %r1,BASED(.Lschedule)
 	basr	%r14,%r1	       # call schedule
-        stnsm   24(%r15),0xfc          # disable I/O and ext. interrupts
+        stnsm   __SF_EMPTY(%r15),0xfc  # disable I/O and ext. interrupts
 	xc      __TI_precount(4,%r9),__TI_precount(%r9)
 	b	BASED(io_resume_loop)
 #endif
@@ -517,7 +527,7 @@
 	l	%r1,__LC_KERNEL_STACK
 	s	%r1,BASED(.Lc_spsize)
 	mvc	SP_PTREGS(__PT_SIZE,%r1),SP_PTREGS(%r15)
-        xc      0(4,%r1),0(%r1)        # clear back chain
+        xc      __SF_BACKCHAIN(4,%r1),__SF_BACKCHAIN(%r1) # clear back chain
 	lr	%r15,%r1
 #
 # One of the work bits is on. Find out which one.
@@ -535,9 +545,9 @@
 #	
 io_reschedule:        
         l       %r1,BASED(.Lschedule)
-        stosm   24(%r15),0x03          # reenable interrupts
+        stosm   __SF_EMPTY(%r15),0x03  # reenable interrupts
 	basr    %r14,%r1	       # call scheduler
-        stnsm   24(%r15),0xfc          # disable I/O and ext. interrupts
+        stnsm   __SF_EMPTY(%r15),0xfc  # disable I/O and ext. interrupts
 	tm	__TI_flags+3(%r9),_TIF_WORK_INT
 	bz	BASED(io_leave)        # there is no work to do
 	b	BASED(io_work_loop)
@@ -546,12 +556,12 @@
 # _TIF_SIGPENDING is set, call do_signal
 #
 io_sigpending:     
-        stosm   24(%r15),0x03          # reenable interrupts
+        stosm   __SF_EMPTY(%r15),0x03  # reenable interrupts
         la      %r2,SP_PTREGS(%r15)    # load pt_regs
         sr      %r3,%r3                # clear *oldset
         l       %r1,BASED(.Ldo_signal)
 	basr    %r14,%r1	       # call do_signal
-        stnsm   24(%r15),0xfc          # disable I/O and ext. interrupts
+        stnsm   __SF_EMPTY(%r15),0xfc  # disable I/O and ext. interrupts
 	b	BASED(io_leave)        # out of here, do NOT recheck
 
 /*
@@ -593,7 +603,7 @@
         lctl    %c0,%c15,__LC_CREGS_SAVE_AREA # get new ctl regs
         lam     %a0,%a15,__LC_AREGS_SAVE_AREA
         stosm   0(%r15),0x04           # now we can turn dat on
-        lm      %r6,%r15,24(%r15)      # load registers from clone
+        lm      %r6,%r15,__SF_GPRS(%r15) # load registers from clone
         basr    %r14,0
         l       %r14,restart_addr-.(%r14)
         br      %r14                   # branch to start_secondary
@@ -614,6 +624,31 @@
 restart_go:
 #endif
 
+#ifdef CONFIG_CHECK_STACK
+/*
+ * The synchronous or the asynchronous stack overflowed. We are dead.
+ * No need to properly save the registers, we are going to panic anyway.
+ * Setup a pt_regs so that show_trace can provide a good call trace.
+ */
+stack_overflow:
+	l	%r15,__LC_PANIC_STACK	# change to panic stack
+	sl	%r15,BASED(.Lc_spsize)
+	mvc	SP_PSW(8,%r15),0(%r12)	# move user PSW to stack
+	stm	%r0,%r11,SP_R0(%r15)	# store gprs %r0-%r11 to kernel stack
+	la	%r1,__LC_SAVE_AREA
+	ch	%r12,BASED(.L0x020)	# old psw addr == __LC_SVC_OLD_PSW ?
+	be	BASED(0f)
+	ch	%r12,BASED(.L0x028)	# old psw addr == __LC_PGM_OLD_PSW ?
+	be	BASED(0f)
+	la	%r1,__LC_SAVE_AREA+16
+0:	mvc	SP_R12(16,%r15),0(%r1)	# move %r12-%r15 to stack
+        xc      __SF_BACKCHAIN(4,%r15),__SF_BACKCHAIN(%r15) # clear back chain
+	l	%r1,BASED(1f)		# branch to kernel_stack_overflow
+        la      %r2,SP_PTREGS(%r15)	# load pt_regs
+	br	%r1
+1:	.long  kernel_stack_overflow
+#endif
+
 cleanup_table_system_call:
 	.long	system_call + 0x80000000, sysc_do_svc + 0x80000000
 cleanup_table_sysc_return:
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-s390/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	Mon Aug 30 19:14:22 2004
+++ linux-2.6-s390/arch/s390/kernel/entry64.S	Mon Aug 30 19:14:22 2004
@@ -19,6 +19,7 @@
 #include <asm/thread_info.h>
 #include <asm/offsets.h>
 #include <asm/unistd.h>
+#include <asm/page.h>
 
 /*
  * Stack layout for the system_call stack entry.
@@ -48,6 +49,9 @@
 SP_TRAP      =  STACK_FRAME_OVERHEAD + __PT_TRAP
 SP_SIZE      =  STACK_FRAME_OVERHEAD + __PT_SIZE
 
+STACK_SHIFT = PAGE_SHIFT + THREAD_ORDER
+STACK_SIZE  = 1 << STACK_SHIFT
+
 _TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
 		 _TIF_RESTART_SVC | _TIF_SINGLE_STEP )
 _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NEED_RESCHED)
@@ -85,10 +89,16 @@
 	jnz	1f
 0:	lg	%r14,__LC_ASYNC_STACK	# are we already on the async. stack ?
 	slgr	%r14,%r15
-	srag	%r14,%r14,14
+	srag	%r14,%r14,STACK_SHIFT
 	jz	2f
 1:	lg	%r15,__LC_ASYNC_STACK	# load async stack
 	.endif
+#ifdef CONFIG_CHECK_STACK
+	j	3f
+2:	tml	%r15,STACK_SIZE - CONFIG_STACK_GUARD
+	jz	stack_overflow
+3:
+#endif	
 2:	aghi    %r15,-SP_SIZE		# make room for registers & psw
 	mvc     SP_PSW(16,%r15),0(%r12)	# move user PSW to stack
 	la	%r12,\psworg
@@ -98,7 +108,7 @@
 	st	%r12,SP_ILC(%r15)
 	mvc	SP_R12(32,%r15),\savearea # move %r12-%r15 to stack
 	la	%r12,0
-	stg	%r12,0(%r15)
+	stg	%r12,__SF_BACKCHAIN(%r15)
         .endm
 
 	.macro	RESTORE_ALL sync
@@ -121,19 +131,19 @@
 __switch_to:
 	tm	__THREAD_per+4(%r3),0xe8 # is the new process using per ?
 	jz	__switch_to_noper		# if not we're fine
-        stctg   %c9,%c11,48(%r15)       # We are using per stuff
-        clc     __THREAD_per(24,%r3),48(%r15)
+        stctg   %c9,%c11,__SF_EMPTY(%r15)# We are using per stuff
+        clc     __THREAD_per(24,%r3),__SF_EMPTY(%r15)
         je      __switch_to_noper            # we got away without bashing TLB's
         lctlg   %c9,%c11,__THREAD_per(%r3)	# Nope we didn't
 __switch_to_noper:
-        stmg    %r6,%r15,48(%r15)       # store __switch_to registers of prev task
+        stmg    %r6,%r15,__SF_GPRS(%r15)# store __switch_to registers of prev task
 	stg	%r15,__THREAD_ksp(%r2)	# store kernel stack to prev->tss.ksp
 	lg	%r15,__THREAD_ksp(%r3)	# load kernel stack from next->tss.ksp
-        lmg     %r6,%r15,48(%r15)       # load __switch_to registers of next task
+        lmg     %r6,%r15,__SF_GPRS(%r15)# load __switch_to registers of next task
 	stg	%r3,__LC_CURRENT	# __LC_CURRENT = current task struct
 	lg	%r3,__THREAD_info(%r3)  # load thread_info from task struct
 	stg	%r3,__LC_THREAD_INFO
-	aghi	%r3,16384
+	aghi	%r3,STACK_SIZE
 	stg	%r3,__LC_KERNEL_STACK	# __LC_KERNEL_STACK = new kernel stack
 	br	%r14
 
@@ -143,19 +153,19 @@
  */
 	.global do_call_softirq
 do_call_softirq:
-	stnsm	48(%r15),0xfc
-	stmg	%r12,%r15,56(%r15)
+	stnsm	__SF_EMPTY(%r15),0xfc
+	stmg	%r12,%r15,__SF_GPRS(%r15)
 	lgr	%r12,%r15
 	lg	%r0,__LC_ASYNC_STACK
 	slgr    %r0,%r15
-	srag	%r0,%r0,14
+	srag	%r0,%r0,STACK_SHIFT
 	je	0f
 	lg	%r15,__LC_ASYNC_STACK
 0:	aghi	%r15,-STACK_FRAME_OVERHEAD
-	stg	%r12,0(%r15)		# store back chain
+	stg	%r12,__SF_BACKCHAIN(%r15)	# store back chain
 	brasl	%r14,do_softirq
-	lmg	%r12,%r15,56(%r12)
-	ssm	48(%r15)
+	lmg	%r12,%r15,__SF_GPRS(%r12)
+	ssm	__SF_EMPTY(%r15)
 	br	%r14
 
 __critical_start:
@@ -507,7 +517,7 @@
 	mvc	__THREAD_per+__PER_address(8,%r1),__LC_PER_ADDRESS
 	mvc	__THREAD_per+__PER_access_id(1,%r1),__LC_PER_ACCESS_ID
 	oi	__TI_flags+7(%r9),_TIF_SINGLE_STEP # set TIF_SINGLE_STEP
-	stosm	48(%r15),0x03		# reenable interrupts
+	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
 	j	sysc_do_svc
 
 /*
@@ -542,16 +552,16 @@
 	lg	%r1,SP_R15(%r15)
 	aghi	%r1,-SP_SIZE
 	mvc	SP_PTREGS(__PT_SIZE,%r1),SP_PTREGS(%r15)
-        xc      0(8,%r1),0(%r1)        # clear back chain
+        xc      __SF_BACKCHAIN(8,%r1),__SF_BACKCHAIN(%r1) # clear back chain
 	lgr	%r15,%r1
 io_resume_loop:
 	tm	__TI_flags+7(%r9),_TIF_NEED_RESCHED
 	jno	io_leave
 	larl    %r1,.Lc_pactive
 	mvc     __TI_precount(4,%r9),0(%r1)
-        stosm   48(%r15),0x03          # reenable interrupts
+        stosm   __SF_EMPTY(%r15),0x03   # reenable interrupts
 	brasl   %r14,schedule          # call schedule
-        stnsm   48(%r15),0xfc          # disable I/O and ext. interrupts
+        stnsm   __SF_EMPTY(%r15),0xfc   # disable I/O and ext. interrupts
 	xc      __TI_precount(4,%r9),__TI_precount(%r9)
 	j	io_resume_loop
 #endif
@@ -563,7 +573,7 @@
 	lg	%r1,__LC_KERNEL_STACK
 	aghi	%r1,-SP_SIZE
 	mvc	SP_PTREGS(__PT_SIZE,%r1),SP_PTREGS(%r15)
-        xc      0(8,%r1),0(%r1)        # clear back chain
+        xc      __SF_BACKCHAIN(8,%r1),__SF_BACKCHAIN(%r1) # clear back chain
 	lgr	%r15,%r1
 #
 # One of the work bits is on. Find out which one.
@@ -580,23 +590,23 @@
 # _TIF_NEED_RESCHED is set, call schedule
 #	
 io_reschedule:        
-        stosm   48(%r15),0x03       # reenable interrupts
-        brasl   %r14,schedule       # call scheduler
-        stnsm   48(%r15),0xfc       # disable I/O and ext. interrupts
+	stosm   __SF_EMPTY(%r15),0x03	# reenable interrupts
+	brasl   %r14,schedule		# call scheduler
+	stnsm   __SF_EMPTY(%r15),0xfc	# disable I/O and ext. interrupts
 	tm	__TI_flags+7(%r9),_TIF_WORK_INT
-	jz	io_leave               # there is no work to do
+	jz	io_leave		# there is no work to do
 	j	io_work_loop
 
 #
 # _TIF_SIGPENDING is set, call do_signal
 #
 io_sigpending:     
-        stosm   48(%r15),0x03       # reenable interrupts
-        la      %r2,SP_PTREGS(%r15) # load pt_regs
-        slgr    %r3,%r3             # clear *oldset
-	brasl	%r14,do_signal      # call do_signal
-        stnsm   48(%r15),0xfc       # disable I/O and ext. interrupts
-	j	sysc_leave          # out of here, do NOT recheck
+	stosm   __SF_EMPTY(%r15),0x03	# reenable interrupts
+	la      %r2,SP_PTREGS(%r15)	# load pt_regs
+	slgr    %r3,%r3			# clear *oldset
+	brasl	%r14,do_signal		# call do_signal
+	stnsm   __SF_EMPTY(%r15),0xfc	# disable I/O and ext. interrupts
+	j	sysc_leave		# out of here, do NOT recheck
 
 /*
  * External interrupt handler routine
@@ -635,7 +645,7 @@
         lghi    %r10,__LC_AREGS_SAVE_AREA
         lam     %a0,%a15,0(%r10)
         stosm   0(%r15),0x04           # now we can turn dat on
-        lmg     %r6,%r15,48(%r15)      # load registers from clone
+        lmg     %r6,%r15,__SF_GPRS(%r15) # load registers from clone
 	jg      start_secondary
 #else
 /*
@@ -652,6 +662,29 @@
 restart_go:
 #endif
 
+#ifdef CONFIG_CHECK_STACK
+/*
+ * The synchronous or the asynchronous stack overflowed. We are dead.
+ * No need to properly save the registers, we are going to panic anyway.
+ * Setup a pt_regs so that show_trace can provide a good call trace.
+ */
+stack_overflow:
+	lg	%r15,__LC_PANIC_STACK	# change to panic stack
+	aghi	%r1,-SP_SIZE
+	mvc	SP_PSW(16,%r15),0(%r12)	# move user PSW to stack
+	stmg	%r0,%r11,SP_R0(%r15)	# store gprs %r0-%r11 to kernel stack
+	la	%r1,__LC_SAVE_AREA
+	chi	%r12,__LC_SVC_OLD_PSW
+	je	0f
+	chi	%r12,__LC_PGM_OLD_PSW
+	je	0f
+	la	%r1,__LC_SAVE_AREA+16
+0:	mvc	SP_R12(32,%r15),0(%r1)  # move %r12-%r15 to stack
+        xc      __SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15) # clear back chain
+        la      %r2,SP_PTREGS(%r15)	# load pt_regs
+	jg	kernel_stack_overflow
+#endif
+
 cleanup_table_system_call:
 	.quad	system_call, sysc_do_svc
 cleanup_table_sysc_return:
diff -urN linux-2.6/arch/s390/kernel/head.S linux-2.6-s390/arch/s390/kernel/head.S
--- linux-2.6/arch/s390/kernel/head.S	Sat Aug 14 12:55:09 2004
+++ linux-2.6-s390/arch/s390/kernel/head.S	Mon Aug 30 19:14:22 2004
@@ -31,6 +31,8 @@
 #include <asm/setup.h>
 #include <asm/lowcore.h>
 #include <asm/offsets.h>
+#include <asm/thread_info.h>
+#include <asm/page.h>
 
 #ifndef CONFIG_IPL
         .org   0
@@ -741,10 +743,10 @@
 #
         l     %r15,.Linittu-.LPG2(%r13)
 	mvc   __LC_CURRENT(4),__TI_task(%r15)
-        ahi   %r15,8192                 # init_task_union + 8192
+        ahi   %r15,1<<(PAGE_SHIFT+THREAD_ORDER) # init_task_union + THREAD_SIZE
         st    %r15,__LC_KERNEL_STACK    # set end of kernel stack
         ahi   %r15,-96
-        xc    0(4,%r15),0(%r15)         # set backchain to zero
+        xc    __SF_BACKCHAIN(4,%r15),__SF_BACKCHAIN(%r15) # clear backchain
 
 # check control registers
         stctl  %c0,%c15,0(%r15)
diff -urN linux-2.6/arch/s390/kernel/head64.S linux-2.6-s390/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	Sat Aug 14 12:55:10 2004
+++ linux-2.6-s390/arch/s390/kernel/head64.S	Mon Aug 30 19:14:22 2004
@@ -31,6 +31,8 @@
 #include <asm/setup.h>
 #include <asm/lowcore.h>
 #include <asm/offsets.h>
+#include <asm/thread_info.h>
+#include <asm/page.h>
 
 #ifndef CONFIG_IPL
         .org   0
@@ -741,10 +743,10 @@
 	larl  %r15,init_thread_union
 	lg    %r14,__TI_task(%r15)      # cache current in lowcore
 	stg   %r14,__LC_CURRENT
-        aghi  %r15,16384                # init_task_union + 16384
+        aghi  %r15,1<<(PAGE_SHIFT+THREAD_ORDER) # init_task_union + THREAD_SIZE
         stg   %r15,__LC_KERNEL_STACK    # set end of kernel stack
         aghi  %r15,-160
-        xc    0(8,%r15),0(%r15)         # set backchain to zero
+        xc    __SF_BACKCHAIN(4,%r15),__SF_BACKCHAIN(%r15) # clear backchain
 
 # check control registers
         stctg  %c0,%c15,0(%r15)
diff -urN linux-2.6/arch/s390/kernel/process.c linux-2.6-s390/arch/s390/kernel/process.c
--- linux-2.6/arch/s390/kernel/process.c	Mon Aug 30 19:14:22 2004
+++ linux-2.6-s390/arch/s390/kernel/process.c	Mon Aug 30 19:14:22 2004
@@ -58,14 +58,11 @@
  */
 unsigned long thread_saved_pc(struct task_struct *tsk)
 {
-	unsigned long bc;
+	struct stack_frame *sf;
 
-	bc = *((unsigned long *) tsk->thread.ksp);
-#ifndef CONFIG_ARCH_S390X
-	return *((unsigned long *) (bc+56));
-#else
-	return *((unsigned long *) (bc+112));
-#endif
+	sf = (struct stack_frame *) tsk->thread.ksp;
+	sf = (struct stack_frame *) sf->back_chain;
+	return sf->gprs[8];
 }
 
 /*
@@ -232,20 +229,13 @@
 	unsigned long unused,
         struct task_struct * p, struct pt_regs * regs)
 {
-        struct stack_frame
+        struct fake_frame
           {
-            unsigned long back_chain;
-            unsigned long eos;
-            unsigned long glue1;
-            unsigned long glue2;
-            unsigned long scratch[2];
-            unsigned long gprs[10];    /* gprs 6 -15                       */
-            unsigned int  fprs[4];     /* fpr 4 and 6                      */
-            unsigned int  empty[4];
+	    struct stack_frame sf;
             struct pt_regs childregs;
           } *frame;
 
-        frame = ((struct stack_frame *)
+        frame = ((struct fake_frame *)
 		 (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
         p->thread.ksp = (unsigned long) frame;
 	p->set_child_tid = p->clear_child_tid = NULL;
@@ -253,13 +243,13 @@
         frame->childregs = *regs;
 	frame->childregs.gprs[2] = 0;	/* child returns 0 on fork. */
         frame->childregs.gprs[15] = new_stackp;
-        frame->back_chain = frame->eos = 0;
+        frame->sf.back_chain = 0;
 
         /* new return point is ret_from_fork */
-        frame->gprs[8] = (unsigned long) ret_from_fork;
+        frame->sf.gprs[8] = (unsigned long) ret_from_fork;
 
         /* fake return stack for resume(), don't go back to schedule */
-        frame->gprs[9] = (unsigned long) frame;
+        frame->sf.gprs[9] = (unsigned long) frame;
 
 	/* Save access registers to new thread structure. */
 	save_access_regs(&p->thread.acrs[0]);
@@ -402,30 +392,26 @@
 
 unsigned long get_wchan(struct task_struct *p)
 {
-	unsigned long r14, r15, bc;
-	unsigned long stack_page;
-	int count = 0;
-	if (!p || p == current || p->state == TASK_RUNNING)
+	struct stack_frame *sf, *low, *high;
+	unsigned long return_address;
+	int count;
+
+	if (!p || p == current || p->state == TASK_RUNNING || !p->thread_info)
 		return 0;
-	stack_page = (unsigned long) p->thread_info;
-	r15 = p->thread.ksp;
-	if (!stack_page || r15 < stack_page ||
-	    r15 >= THREAD_SIZE - sizeof(unsigned long) + stack_page)
+	low = (struct stack_frame *) p->thread_info;
+	high = (struct stack_frame *)
+		((unsigned long) p->thread_info + THREAD_SIZE) - 1;
+	sf = (struct stack_frame *) (p->thread.ksp & PSW_ADDR_INSN);
+	if (sf <= low || sf > high)
 		return 0;
-	bc = (*(unsigned long *) r15) & PSW_ADDR_INSN;
-	do {
-		if (bc < stack_page ||
-		    bc >= THREAD_SIZE - sizeof(unsigned long) + stack_page)
+	for (count = 0; count < 16; count++) {
+		sf = (struct stack_frame *) (sf->back_chain & PSW_ADDR_INSN);
+		if (sf <= low || sf > high)
 			return 0;
-#ifndef CONFIG_ARCH_S390X
-		r14 = (*(unsigned long *) (bc+56)) & PSW_ADDR_INSN;
-#else
-		r14 = *(unsigned long *) (bc+112);
-#endif
-		if (!in_sched_functions(r14))
-			return r14;
-		bc = (*(unsigned long *) bc) & PSW_ADDR_INSN;
-	} while (count++ < 16);
+		return_address = sf->gprs[8] & PSW_ADDR_INSN;
+		if (!in_sched_functions(return_address))
+			return return_address;
+	}
 	return 0;
 }
 
diff -urN linux-2.6/arch/s390/kernel/setup.c linux-2.6-s390/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	Sat Aug 14 12:54:48 2004
+++ linux-2.6-s390/arch/s390/kernel/setup.c	Mon Aug 30 19:14:22 2004
@@ -503,6 +503,10 @@
 	lc->kernel_stack = ((unsigned long) &init_thread_union) + THREAD_SIZE;
 	lc->async_stack = (unsigned long)
 		__alloc_bootmem(ASYNC_SIZE, ASYNC_SIZE, 0) + ASYNC_SIZE;
+#ifdef CONFIG_CHECK_STACK
+	lc->panic_stack = (unsigned long)
+		__alloc_bootmem(PAGE_SIZE, PAGE_SIZE, 0) + PAGE_SIZE;
+#endif
 	lc->current_task = (unsigned long) init_thread_union.thread_info.task;
 	lc->thread_info = (unsigned long) &init_thread_union;
 #ifdef CONFIG_ARCH_S390X
diff -urN linux-2.6/arch/s390/kernel/smp.c linux-2.6-s390/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	Mon Aug 30 19:14:07 2004
+++ linux-2.6-s390/arch/s390/kernel/smp.c	Mon Aug 30 19:14:22 2004
@@ -741,7 +741,7 @@
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	unsigned long async_stack;
+	unsigned long stack;
 	unsigned int cpu;
         int i;
 
@@ -761,12 +761,18 @@
 		lowcore_ptr[i] = (struct _lowcore *)
 			__get_free_pages(GFP_KERNEL|GFP_DMA, 
 					sizeof(void*) == 8 ? 1 : 0);
-		async_stack = __get_free_pages(GFP_KERNEL,ASYNC_ORDER);
-		if (lowcore_ptr[i] == NULL || async_stack == 0ULL)
+		stack = __get_free_pages(GFP_KERNEL,ASYNC_ORDER);
+		if (lowcore_ptr[i] == NULL || stack == 0ULL)
 			panic("smp_boot_cpus failed to allocate memory\n");
 
 		*(lowcore_ptr[i]) = S390_lowcore;
-		lowcore_ptr[i]->async_stack = async_stack + (ASYNC_SIZE);
+		lowcore_ptr[i]->async_stack = stack + (ASYNC_SIZE);
+#ifdef CONFIG_CHECK_STACK
+		stack = __get_free_pages(GFP_KERNEL,0);
+		if (stack == 0ULL)
+			panic("smp_boot_cpus failed to allocate memory\n");
+		lowcore_ptr[i]->panic_stack = stack + (PAGE_SIZE);
+#endif
 	}
 	set_prefix((u32)(unsigned long) lowcore_ptr[smp_processor_id()]);
 
diff -urN linux-2.6/arch/s390/kernel/traps.c linux-2.6-s390/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	Sat Aug 14 12:55:10 2004
+++ linux-2.6-s390/arch/s390/kernel/traps.c	Mon Aug 30 19:14:22 2004
@@ -67,54 +67,93 @@
 #define stack_pointer ({ void **sp; asm("la %0,0(15)" : "=&d" (sp)); sp; })
 
 #ifndef CONFIG_ARCH_S390X
-#define RET_ADDR 56
 #define FOURLONG "%08lx %08lx %08lx %08lx\n"
 static int kstack_depth_to_print = 12;
-
 #else /* CONFIG_ARCH_S390X */
-#define RET_ADDR 112
 #define FOURLONG "%016lx %016lx %016lx %016lx\n"
 static int kstack_depth_to_print = 20;
-
 #endif /* CONFIG_ARCH_S390X */
 
-void show_trace(struct task_struct *task, unsigned long * stack)
+/*
+ * For show_trace we have tree different stack to consider:
+ *   - the panic stack which is used if the kernel stack has overflown
+ *   - the asynchronous interrupt stack (cpu related)
+ *   - the synchronous kernel stack (process related)
+ * The stack trace can start at any of the three stack and can potentially
+ * touch all of them. The order is: panic stack, async stack, sync stack.
+ */
+static unsigned long
+__show_trace(unsigned long sp, unsigned long low, unsigned long high)
 {
-	unsigned long backchain, low_addr, high_addr, ret_addr;
+	struct stack_frame *sf;
+	struct pt_regs *regs;
 
-	if (!stack)
-		stack = (task == NULL) ? *stack_pointer : &(task->thread.ksp);
+	while (1) {
+		sp = sp & PSW_ADDR_INSN;
+		if (sp < low || sp > high - sizeof(*sf))
+			return sp;
+		sf = (struct stack_frame *) sp;
+		printk("([<%016lx>] ", sf->gprs[8] & PSW_ADDR_INSN);
+		print_symbol("%s)\n", sf->gprs[8] & PSW_ADDR_INSN);
+		/* Follow the backchain. */
+		while (1) {
+			low = sp;
+			sp = sf->back_chain & PSW_ADDR_INSN;
+			if (!sp)
+				break;
+			if (sp <= low || sp > high - sizeof(*sf))
+				return sp;
+			sf = (struct stack_frame *) sp;
+			printk(" [<%016lx>] ", sf->gprs[8] & PSW_ADDR_INSN);
+			print_symbol("%s\n", sf->gprs[8] & PSW_ADDR_INSN);
+		}
+		/* Zero backchain detected, check for interrupt frame. */
+		sp = (unsigned long) (sf + 1);
+		if (sp <= low || sp > high - sizeof(*regs))
+			return sp;
+		regs = (struct pt_regs *) sp;
+		printk(" [<%016lx>] ", regs->psw.addr & PSW_ADDR_INSN);
+		print_symbol("%s\n", regs->psw.addr & PSW_ADDR_INSN);
+		low = sp;
+		sp = regs->gprs[15];
+	}
+}
 
+void show_trace(struct task_struct *task, unsigned long * stack)
+{
+	register unsigned long __r15 asm ("15");
+	unsigned long sp;
+
+	sp = (unsigned long) stack;
+	if (!sp)
+		sp = task ? task->thread.ksp : __r15;
 	printk("Call Trace:\n");
-	low_addr = ((unsigned long) stack) & PSW_ADDR_INSN;
-	high_addr = (low_addr & (-THREAD_SIZE)) + THREAD_SIZE;
-	/* Skip the first frame (biased stack) */
-	backchain = *((unsigned long *) low_addr) & PSW_ADDR_INSN;
-	/* Print up to 8 lines */
-	while  (backchain > low_addr && backchain <= high_addr) {
-		ret_addr = *((unsigned long *) (backchain+RET_ADDR)) & PSW_ADDR_INSN;
-		printk(" [<%016lx>] ", ret_addr);
-		print_symbol("%s\n", ret_addr);
-		low_addr = backchain;
-		backchain = *((unsigned long *) backchain) & PSW_ADDR_INSN;
-	}
+#ifdef CONFIG_CHECK_STACK
+	sp = __show_trace(sp, S390_lowcore.panic_stack - 4096,
+			  S390_lowcore.panic_stack);
+#endif
+	sp = __show_trace(sp, S390_lowcore.async_stack - ASYNC_SIZE,
+			  S390_lowcore.async_stack);
+	if (task)
+		__show_trace(sp, (unsigned long) task->thread_info,
+			     (unsigned long) task->thread_info + THREAD_SIZE);
+	else
+		__show_trace(sp, S390_lowcore.thread_info - THREAD_SIZE,
+			     S390_lowcore.thread_info);
 	printk("\n");
 }
 
 void show_stack(struct task_struct *task, unsigned long *sp)
 {
+	register unsigned long * __r15 asm ("15");
 	unsigned long *stack;
 	int i;
 
 	// debugging aid: "show_stack(NULL);" prints the
 	// back trace for this cpu.
 
-	if (!sp) {
-		if (task)
-			sp = (unsigned long *) task->thread.ksp;
-		else
-			sp = *stack_pointer;
-	}
+	if (!sp)
+		sp = task ? (unsigned long *) task->thread.ksp : __r15;
 
 	stack = sp;
 	for (i = 0; i < kstack_depth_to_print; i++) {
@@ -591,6 +630,11 @@
 	}
 }
 
+asmlinkage void kernel_stack_overflow(struct pt_regs * regs)
+{
+	die("Kernel stack overflow", regs, 0);
+	panic("Corrupt kernel stack, can't continue.");
+}
 
 
 /* init is done in lowcore.S and head.S */
diff -urN linux-2.6/include/asm-s390/lowcore.h linux-2.6-s390/include/asm-s390/lowcore.h
--- linux-2.6/include/asm-s390/lowcore.h	Sat Aug 14 12:55:32 2004
+++ linux-2.6-s390/include/asm-s390/lowcore.h	Mon Aug 30 19:14:22 2004
@@ -68,6 +68,7 @@
 #define __LC_ASYNC_STACK                0xC48
 #define __LC_KERNEL_ASCE		0xC4C
 #define __LC_USER_ASCE			0xC50
+#define __LC_PANIC_STACK                0xC54
 #define __LC_CPUID                      0xC60
 #define __LC_CPUADDR                    0xC68
 #define __LC_IPLDEV                     0xC7C
@@ -80,6 +81,7 @@
 #define __LC_ASYNC_STACK                0xD50
 #define __LC_KERNEL_ASCE		0xD58
 #define __LC_USER_ASCE			0xD60
+#define __LC_PANIC_STACK                0xD68
 #define __LC_CPUID                      0xD90
 #define __LC_CPUADDR                    0xD98
 #define __LC_IPLDEV                     0xDB8
@@ -176,7 +178,8 @@
 	__u32        async_stack;              /* 0xc48 */
 	__u32        kernel_asce;              /* 0xc4c */
 	__u32        user_asce;                /* 0xc50 */
-	__u8         pad10[0xc60-0xc54];       /* 0xc54 */
+	__u32        panic_stack;              /* 0xc54 */
+	__u8         pad10[0xc60-0xc58];       /* 0xc58 */
 	/* entry.S sensitive area start */
 	struct       cpuinfo_S390 cpu_data;    /* 0xc60 */
 	__u32        ipl_device;               /* 0xc7c */
@@ -257,7 +260,8 @@
 	__u64        async_stack;              /* 0xd50 */
 	__u64        kernel_asce;              /* 0xd58 */
 	__u64        user_asce;                /* 0xd60 */
-	__u8         pad10[0xd80-0xd68];       /* 0xd68 */
+	__u64        panic_stack;              /* 0xd68 */
+	__u8         pad10[0xd80-0xd70];       /* 0xd70 */
 	/* entry.S sensitive area start */
 	struct       cpuinfo_S390 cpu_data;    /* 0xd80 */
 	__u32        ipl_device;               /* 0xdb8 */
diff -urN linux-2.6/include/asm-s390/processor.h linux-2.6-s390/include/asm-s390/processor.h
--- linux-2.6/include/asm-s390/processor.h	Mon Aug 30 19:14:12 2004
+++ linux-2.6-s390/include/asm-s390/processor.h	Mon Aug 30 19:14:22 2004
@@ -103,6 +103,25 @@
 
 typedef struct thread_struct thread_struct;
 
+/*
+ * Stack layout of a C stack frame.
+ */
+#ifndef __PACK_STACK
+struct stack_frame {
+	unsigned long back_chain;
+	unsigned long empty1[5];
+	unsigned long gprs[10];
+	unsigned int  empty2[8];
+};
+#else
+struct stack_frame {
+	unsigned long empty1[5];
+	unsigned int  empty2[8];
+	unsigned long gprs[10];
+	unsigned long back_chain;
+};
+#endif
+
 #define ARCH_MIN_TASKALIGN	8
 
 #ifndef __s390x__
diff -urN linux-2.6/include/asm-s390/thread_info.h linux-2.6-s390/include/asm-s390/thread_info.h
--- linux-2.6/include/asm-s390/thread_info.h	Sat Aug 14 12:55:47 2004
+++ linux-2.6-s390/include/asm-s390/thread_info.h	Mon Aug 30 19:14:22 2004
@@ -11,6 +11,30 @@
 
 #ifdef __KERNEL__
 
+/*
+ * Size of kernel stack for each process
+ */
+#ifndef __s390x__
+#ifndef __SMALL_STACK
+#define THREAD_ORDER 1
+#define ASYNC_ORDER  1
+#else
+#define THREAD_ORDER 0
+#define ASYNC_ORDER  0
+#endif
+#else /* __s390x__ */
+#ifndef __SMALL_STACK_STACK
+#define THREAD_ORDER 2
+#define ASYNC_ORDER  2
+#else
+#define THREAD_ORDER 1
+#define ASYNC_ORDER  1
+#endif
+#endif /* __s390x__ */
+
+#define THREAD_SIZE (PAGE_SIZE << THREAD_ORDER)
+#define ASYNC_SIZE  (PAGE_SIZE << ASYNC_ORDER)
+
 #ifndef __ASSEMBLY__
 #include <asm/processor.h>
 #include <asm/lowcore.h>
@@ -47,20 +71,6 @@
 #define init_thread_info	(init_thread_union.thread_info)
 #define init_stack		(init_thread_union.stack)
 
-/*
- * Size of kernel stack for each process
- */
-#ifndef __s390x__
-#define THREAD_ORDER 1
-#define ASYNC_ORDER  1
-#else /* __s390x__ */
-#define THREAD_ORDER 2
-#define ASYNC_ORDER  2
-#endif /* __s390x__ */
-
-#define THREAD_SIZE (PAGE_SIZE << THREAD_ORDER)
-#define ASYNC_SIZE  (PAGE_SIZE << ASYNC_ORDER)
-
 /* how to get the thread information struct from C */
 static inline struct thread_info *current_thread_info(void)
 {
