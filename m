Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263617AbTDNRtS (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbTDNRsY (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:48:24 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:671 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id S263595AbTDNRpa (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:45:30 -0400
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (6/16): uni-processor builds.
Date: Mon, 14 Apr 2003 19:49:48 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304141949.48296.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes for s390 kernel configured with CONFIG_SMP=n.

diffstat:
 arch/s390/kernel/entry.S       |    6 ------
 arch/s390/kernel/setup.c       |    5 +++++
 arch/s390/kernel/signal.c      |    1 +
 arch/s390/kernel/traps.c       |    1 +
 arch/s390/math-emu/math.c      |    1 +
 drivers/s390/char/sclp.c       |    4 ++--
 drivers/s390/cio/device_id.c   |    1 +
 drivers/s390/cio/device_pgid.c |    1 +
 drivers/s390/cio/requestirq.c  |    3 ++-
 9 files changed, 14 insertions(+), 9 deletions(-)

diff -urN linux-2.5.67/arch/s390/kernel/entry.S linux-2.5.67-s390/arch/s390/kernel/entry.S
--- linux-2.5.67/arch/s390/kernel/entry.S	Mon Apr 14 19:11:50 2003
+++ linux-2.5.67-s390/arch/s390/kernel/entry.S	Mon Apr 14 19:11:52 2003
@@ -290,13 +290,9 @@
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
@@ -973,8 +969,6 @@
 .Lsigaltstack: .long  sys_sigaltstack
 .Ltrace:       .long  syscall_trace
 .Lvfork:       .long  sys_vfork
-#if CONFIG_SMP || CONFIG_PREEMPT
 .Lschedtail:   .long  schedule_tail
-#endif
 
 
diff -urN linux-2.5.67/arch/s390/kernel/setup.c linux-2.5.67-s390/arch/s390/kernel/setup.c
--- linux-2.5.67/arch/s390/kernel/setup.c	Mon Apr  7 19:30:41 2003
+++ linux-2.5.67-s390/arch/s390/kernel/setup.c	Mon Apr 14 19:11:52 2003
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
diff -urN linux-2.5.67/arch/s390/kernel/signal.c linux-2.5.67-s390/arch/s390/kernel/signal.c
--- linux-2.5.67/arch/s390/kernel/signal.c	Mon Apr  7 19:32:21 2003
+++ linux-2.5.67-s390/arch/s390/kernel/signal.c	Mon Apr 14 19:11:52 2003
@@ -29,6 +29,7 @@
 #include <linux/binfmts.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
+#include <asm/lowcore.h>
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
diff -urN linux-2.5.67/arch/s390/kernel/traps.c linux-2.5.67-s390/arch/s390/kernel/traps.c
--- linux-2.5.67/arch/s390/kernel/traps.c	Mon Apr  7 19:31:02 2003
+++ linux-2.5.67-s390/arch/s390/kernel/traps.c	Mon Apr 14 19:11:52 2003
@@ -35,6 +35,7 @@
 #include <asm/mathemu.h>
 #include <asm/cpcmd.h>
 #include <asm/s390_ext.h>
+#include <asm/lowcore.h>
 
 /* Called from entry.S only */
 extern void handle_per_exception(struct pt_regs *regs);
diff -urN linux-2.5.67/arch/s390/math-emu/math.c linux-2.5.67-s390/arch/s390/math-emu/math.c
--- linux-2.5.67/arch/s390/math-emu/math.c	Mon Apr  7 19:31:03 2003
+++ linux-2.5.67-s390/arch/s390/math-emu/math.c	Mon Apr 14 19:11:52 2003
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <asm/uaccess.h>
+#include <asm/lowcore.h>
 
 #include "sfp-util.h"
 #include <math-emu/soft-fp.h>
diff -urN linux-2.5.67/drivers/s390/char/sclp.c linux-2.5.67-s390/drivers/s390/char/sclp.c
--- linux-2.5.67/drivers/s390/char/sclp.c	Mon Apr 14 19:11:51 2003
+++ linux-2.5.67-s390/drivers/s390/char/sclp.c	Mon Apr 14 19:11:52 2003
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
diff -urN linux-2.5.67/drivers/s390/cio/device_id.c linux-2.5.67-s390/drivers/s390/cio/device_id.c
--- linux-2.5.67/drivers/s390/cio/device_id.c	Mon Apr 14 19:11:51 2003
+++ linux-2.5.67-s390/drivers/s390/cio/device_id.c	Mon Apr 14 19:11:52 2003
@@ -16,6 +16,7 @@
 #include <asm/ccwdev.h>
 #include <asm/delay.h>
 #include <asm/cio.h>
+#include <asm/lowcore.h>
 
 #include "cio.h"
 #include "cio_debug.h"
diff -urN linux-2.5.67/drivers/s390/cio/device_pgid.c linux-2.5.67-s390/drivers/s390/cio/device_pgid.c
--- linux-2.5.67/drivers/s390/cio/device_pgid.c	Mon Apr 14 19:11:51 2003
+++ linux-2.5.67-s390/drivers/s390/cio/device_pgid.c	Mon Apr 14 19:11:52 2003
@@ -16,6 +16,7 @@
 #include <asm/ccwdev.h>
 #include <asm/cio.h>
 #include <asm/delay.h>
+#include <asm/lowcore.h>
 
 #include "cio.h"
 #include "cio_debug.h"
diff -urN linux-2.5.67/drivers/s390/cio/requestirq.c linux-2.5.67-s390/drivers/s390/cio/requestirq.c
--- linux-2.5.67/drivers/s390/cio/requestirq.c	Mon Apr 14 19:11:51 2003
+++ linux-2.5.67-s390/drivers/s390/cio/requestirq.c	Mon Apr 14 19:11:52 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/requestirq.c
  *   S/390 common I/O routines -- enabling and disabling of devices
- *   $Revision: 1.42 $
+ *   $Revision: 1.44 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -14,6 +14,7 @@
 #include <linux/config.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <asm/lowcore.h>
 
 #include "css.h"
 

