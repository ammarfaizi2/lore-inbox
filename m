Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261571AbTCGMna>; Fri, 7 Mar 2003 07:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbTCGMnZ>; Fri, 7 Mar 2003 07:43:25 -0500
Received: from d06lmsgate.uk.ibm.com ([195.212.29.1]:51095 "EHLO
	d06lmsgate.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S261571AbTCGMmp> convert rfc822-to-8bit; Fri, 7 Mar 2003 07:42:45 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (6/7): uni-processor kernel.
Date: Fri, 7 Mar 2003 13:38:42 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303071338.42039.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes for kernel configured with CONFIG_SMP=n.

diffstat:
 arch/s390/kernel/entry.S       |    6 ------
 arch/s390/kernel/setup.c       |    5 +++++
 arch/s390/kernel/signal.c      |    1 +
 arch/s390/kernel/traps.c       |    1 +
 arch/s390/math-emu/math.c      |    1 +
 arch/s390x/kernel/entry.S      |    4 ----
 arch/s390x/kernel/setup.c      |    5 +++++
 arch/s390x/kernel/signal.c     |    1 +
 arch/s390x/kernel/signal32.c   |    1 +
 arch/s390x/kernel/traps.c      |    4 +---
 drivers/s390/char/sclp.c       |    4 ++--
 drivers/s390/cio/device_id.c   |    1 +
 drivers/s390/cio/device_pgid.c |    1 +
 drivers/s390/cio/requestirq.c  |    3 ++-
 14 files changed, 22 insertions(+), 16 deletions(-)

diff -urN linux-2.5.64/arch/s390/kernel/entry.S linux-2.5.64-s390/arch/s390/kernel/entry.S
--- linux-2.5.64/arch/s390/kernel/entry.S	Fri Mar  7 11:40:32 2003
+++ linux-2.5.64-s390/arch/s390/kernel/entry.S	Fri Mar  7 11:40:56 2003
@@ -289,13 +289,9 @@
         basr    %r13,0
         l       %r13,.Lentry_base-.(%r13)  # setup base pointer to &entry_base
         GET_THREAD_INFO           # load pointer to task_struct to R9
-#if CONFIG_SMP || CONFIG_PREEMPT
         l       %r1,BASED(.Lschedtail)
 	la      %r14,BASED(sysc_return)
         br      %r1               # call schedule_tail, return to sysc_return
-#else
-	b	BASED(sysc_return)
-#endif
 
 #
 # clone, fork, vfork, exec and sigreturn need glue,
@@ -967,8 +963,6 @@
 .Lsigaltstack: .long  sys_sigaltstack
 .Ltrace:       .long  syscall_trace
 .Lvfork:       .long  sys_vfork
-#if CONFIG_SMP || CONFIG_PREEMPT
 .Lschedtail:   .long  schedule_tail
-#endif
 
 
diff -urN linux-2.5.64/arch/s390/kernel/setup.c linux-2.5.64-s390/arch/s390/kernel/setup.c
--- linux-2.5.64/arch/s390/kernel/setup.c	Wed Mar  5 04:28:58 2003
+++ linux-2.5.64-s390/arch/s390/kernel/setup.c	Fri Mar  7 11:40:56 2003
@@ -41,6 +41,7 @@
 #include <asm/smp.h>
 #include <asm/mmu_context.h>
 #include <asm/cpcmd.h>
+#include <asm/lowcore.h>
 
 /*
  * Machine setup..
@@ -534,10 +535,14 @@
 			       (loops_per_jiffy/(5000/HZ))%100);
 	}
 	if (cpu_online_map & (1 << n)) {
+#ifdef CONFIG_SMP
 		if (smp_processor_id() == n)
 			cpuinfo = &S390_lowcore.cpu_data;
 		else
 			cpuinfo = &lowcore_ptr[n]->cpu_data;
+#else
+		cpuinfo = &S390_lowcore.cpu_data;
+#endif
 		seq_printf(m, "processor %li: "
 			       "version = %02X,  "
 			       "identification = %06X,  "
diff -urN linux-2.5.64/arch/s390/kernel/signal.c linux-2.5.64-s390/arch/s390/kernel/signal.c
--- linux-2.5.64/arch/s390/kernel/signal.c	Wed Mar  5 04:29:33 2003
+++ linux-2.5.64-s390/arch/s390/kernel/signal.c	Fri Mar  7 11:40:56 2003
@@ -29,6 +29,7 @@
 #include <linux/binfmts.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
+#include <asm/lowcore.h>
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
diff -urN linux-2.5.64/arch/s390/kernel/traps.c linux-2.5.64-s390/arch/s390/kernel/traps.c
--- linux-2.5.64/arch/s390/kernel/traps.c	Wed Mar  5 04:29:15 2003
+++ linux-2.5.64-s390/arch/s390/kernel/traps.c	Fri Mar  7 11:40:56 2003
@@ -35,6 +35,7 @@
 #include <asm/mathemu.h>
 #include <asm/cpcmd.h>
 #include <asm/s390_ext.h>
+#include <asm/lowcore.h>
 
 /* Called from entry.S only */
 extern void handle_per_exception(struct pt_regs *regs);
diff -urN linux-2.5.64/arch/s390/math-emu/math.c linux-2.5.64-s390/arch/s390/math-emu/math.c
--- linux-2.5.64/arch/s390/math-emu/math.c	Wed Mar  5 04:29:16 2003
+++ linux-2.5.64-s390/arch/s390/math-emu/math.c	Fri Mar  7 11:40:56 2003
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <asm/uaccess.h>
+#include <asm/lowcore.h>
 
 #include "sfp-util.h"
 #include <math-emu/soft-fp.h>
diff -urN linux-2.5.64/arch/s390x/kernel/entry.S linux-2.5.64-s390/arch/s390x/kernel/entry.S
--- linux-2.5.64/arch/s390x/kernel/entry.S	Fri Mar  7 11:40:32 2003
+++ linux-2.5.64-s390/arch/s390x/kernel/entry.S	Fri Mar  7 11:40:56 2003
@@ -270,12 +270,8 @@
         .globl  ret_from_fork
 ret_from_fork:  
         GET_THREAD_INFO           # load pointer to task_struct to R9
-#if CONFIG_SMP || CONFIG_PREEMPT
 	larl    %r14,sysc_return
         jg      schedule_tail     # return to sysc_return
-#else
-	j	sysc_return
-#endif
 
 #
 # clone, fork, vfork, exec and sigreturn need glue,
diff -urN linux-2.5.64/arch/s390x/kernel/setup.c linux-2.5.64-s390/arch/s390x/kernel/setup.c
--- linux-2.5.64/arch/s390x/kernel/setup.c	Wed Mar  5 04:29:16 2003
+++ linux-2.5.64-s390/arch/s390x/kernel/setup.c	Fri Mar  7 11:40:56 2003
@@ -41,6 +41,7 @@
 #include <asm/smp.h>
 #include <asm/mmu_context.h>
 #include <asm/cpcmd.h>
+#include <asm/lowcore.h>
 
 /*
  * Machine setup..
@@ -528,10 +529,14 @@
 				(loops_per_jiffy/(5000/HZ))%100);
 	}
 	if (cpu_online_map & (1 << n)) {
+#ifdef CONFIG_SMP
 		if (smp_processor_id() == n)
 			cpuinfo = &S390_lowcore.cpu_data;
 		else
 			cpuinfo = &lowcore_ptr[n]->cpu_data;
+#else
+		cpuinfo = &S390_lowcore.cpu_data;
+#endif
 		seq_printf(m, "processor %li: "
 				"version = %02X,  "
 				"identification = %06X,  "
diff -urN linux-2.5.64/arch/s390x/kernel/signal.c linux-2.5.64-s390/arch/s390x/kernel/signal.c
--- linux-2.5.64/arch/s390x/kernel/signal.c	Wed Mar  5 04:29:24 2003
+++ linux-2.5.64-s390/arch/s390x/kernel/signal.c	Fri Mar  7 11:40:56 2003
@@ -29,6 +29,7 @@
 #include <linux/binfmts.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
+#include <asm/lowcore.h>
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
diff -urN linux-2.5.64/arch/s390x/kernel/signal32.c linux-2.5.64-s390/arch/s390x/kernel/signal32.c
--- linux-2.5.64/arch/s390x/kernel/signal32.c	Wed Mar  5 04:29:18 2003
+++ linux-2.5.64-s390/arch/s390x/kernel/signal32.c	Fri Mar  7 11:40:56 2003
@@ -29,6 +29,7 @@
 #include <linux/binfmts.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
+#include <asm/lowcore.h>
 #include "linux32.h"
 #include "ptrace32.h"
 
diff -urN linux-2.5.64/arch/s390x/kernel/traps.c linux-2.5.64-s390/arch/s390x/kernel/traps.c
--- linux-2.5.64/arch/s390x/kernel/traps.c	Wed Mar  5 04:29:32 2003
+++ linux-2.5.64-s390/arch/s390x/kernel/traps.c	Fri Mar  7 11:40:56 2003
@@ -32,11 +32,9 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/atomic.h>
-#if CONFIG_REMOTE_DEBUG
-#include <asm/gdb-stub.h>
-#endif
 #include <asm/cpcmd.h>
 #include <asm/s390_ext.h>
+#include <asm/lowcore.h>
 
 /* Called from entry.S only */
 extern void handle_per_exception(struct pt_regs *regs);
diff -urN linux-2.5.64/drivers/s390/char/sclp.c linux-2.5.64-s390/drivers/s390/char/sclp.c
--- linux-2.5.64/drivers/s390/char/sclp.c	Wed Mar  5 04:29:24 2003
+++ linux-2.5.64-s390/drivers/s390/char/sclp.c	Fri Mar  7 11:40:56 2003
@@ -489,8 +489,8 @@
 {
 	psw_t quiesce_psw;
 
-	quiesce_psw.mask = _DW_PSW_MASK;
-	queisce_psw.addr = 0xfff;
+	quiesce_psw.mask = PSW_BASE_BITS | PSW_MASK_WAIT;
+	quiesce_psw.addr = 0xfff;
 	__load_psw(quiesce_psw);
 }
 #endif
diff -urN linux-2.5.64/drivers/s390/cio/device_id.c linux-2.5.64-s390/drivers/s390/cio/device_id.c
--- linux-2.5.64/drivers/s390/cio/device_id.c	Wed Mar  5 04:28:52 2003
+++ linux-2.5.64-s390/drivers/s390/cio/device_id.c	Fri Mar  7 11:40:56 2003
@@ -16,6 +16,7 @@
 #include <asm/ccwdev.h>
 #include <asm/delay.h>
 #include <asm/cio.h>
+#include <asm/lowcore.h>
 
 #include "cio.h"
 #include "cio_debug.h"
diff -urN linux-2.5.64/drivers/s390/cio/device_pgid.c linux-2.5.64-s390/drivers/s390/cio/device_pgid.c
--- linux-2.5.64/drivers/s390/cio/device_pgid.c	Wed Mar  5 04:29:21 2003
+++ linux-2.5.64-s390/drivers/s390/cio/device_pgid.c	Fri Mar  7 11:40:56 2003
@@ -16,6 +16,7 @@
 #include <asm/ccwdev.h>
 #include <asm/cio.h>
 #include <asm/delay.h>
+#include <asm/lowcore.h>
 
 #include "cio.h"
 #include "cio_debug.h"
diff -urN linux-2.5.64/drivers/s390/cio/requestirq.c linux-2.5.64-s390/drivers/s390/cio/requestirq.c
--- linux-2.5.64/drivers/s390/cio/requestirq.c	Wed Mar  5 04:29:31 2003
+++ linux-2.5.64-s390/drivers/s390/cio/requestirq.c	Fri Mar  7 11:40:56 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/requestirq.c
  *   S/390 common I/O routines -- enabling and disabling of devices
- *   $Revision: 1.42 $
+ *   $Revision: 1.43 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -14,6 +14,7 @@
 #include <linux/config.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <asm/lowcore.h>
 
 #include "css.h"
 

