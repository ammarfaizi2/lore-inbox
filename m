Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263316AbUJ2NSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263316AbUJ2NSn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 09:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbUJ2NSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 09:18:43 -0400
Received: from mail.renesas.com ([202.234.163.13]:55760 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S263316AbUJ2NNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 09:13:49 -0400
Date: Fri, 29 Oct 2004 22:13:38 +0900 (JST)
Message-Id: <20041029.221338.115904096.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc1] [m32r] Remove rep_nop()
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Remove rep_nop() from include/asm-m32r/processor.h,
because REP NOP (PAUSE) is a x86 specific instuction.

Instead of rep_nop(), barrier() should be used for cpu_relax()
as well as other architecuture.

	* include/asm-m32r/processor.h:
	- Change not to include "cachectl.h".
	- Remove rep_nop() and redefine cpu_relax() as barrier().

	* arch/m32r/kernel/smpboot.h:
	- Use cpu_relax() instead of rep_nop().

Regards.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/smpboot.c   |    4 ++--
 include/asm-m32r/processor.h |   30 +++++++-----------------------
 2 files changed, 9 insertions(+), 25 deletions(-)


diff -ruNp a/include/asm-m32r/processor.h b/include/asm-m32r/processor.h
--- a/include/asm-m32r/processor.h	2004-10-19 06:53:06.000000000 +0900
+++ b/include/asm-m32r/processor.h	2004-10-29 17:36:11.000000000 +0900
@@ -1,28 +1,23 @@
 #ifndef _ASM_M32R_PROCESSOR_H
 #define _ASM_M32R_PROCESSOR_H
 
-/* $Id$ */
-
 /*
+ * include/asm-m32r/processor.h
+ *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2001  by Hiroyuki Kondo, Hirokazu Takata, and Hitoshi Yamamoto
+ * Copyright (C) 1994  Linus Torvalds
+ * Copyright (C) 2001  Hiroyuki Kondo, Hirokazu Takata, and Hitoshi Yamamoto
+ * Copyright (C) 2004  Hirokazu Takata <takata at linux-m32r.org>
  */
 
-/*
- * include/asm-m32r/processor.h
- *
- * Copyright (C) 1994 Linus Torvalds
- */
 #include <linux/kernel.h>
 #include <linux/config.h>
 #include <asm/cache.h>
 #include <asm/ptrace.h>  /* pt_regs */
 
-#include <asm/cachectl.h>
-
 /*
  * Default implementation of macro that returns current
  * instruction pointer ("program counter").
@@ -53,7 +48,7 @@ extern struct cpuinfo_m32r boot_cpu_data
 extern struct cpuinfo_m32r cpu_data[];
 #define current_cpu_data cpu_data[smp_processor_id()]
 #else
-#define cpu_data &boot_cpu_data
+#define cpu_data (&boot_cpu_data)
 #define current_cpu_data boot_cpu_data
 #endif
 
@@ -141,17 +136,6 @@ unsigned long get_wchan(struct task_stru
 
 #define THREAD_SIZE (2*PAGE_SIZE)
 
-/* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
-static __inline__ void rep_nop(void)
-{
-	__asm__ __volatile__(
-		"nop \n\t"
-		"nop \n\t"
-		:
-		:
-		: "memory");
-}
-
-#define cpu_relax()     rep_nop()
+#define cpu_relax()	barrier()
 
 #endif /* _ASM_M32R_PROCESSOR_H */
diff -ruNp a/arch/m32r/kernel/smpboot.c b/arch/m32r/kernel/smpboot.c
--- a/arch/m32r/kernel/smpboot.c	2004-10-19 06:55:36.000000000 +0900
+++ b/arch/m32r/kernel/smpboot.c	2004-10-29 16:01:27.000000000 +0900
@@ -433,7 +433,7 @@ int __init start_secondary(void *unused)
 	cpu_init();
 	smp_callin();
 	while (!cpu_isset(smp_processor_id(), smp_commenced_mask))
-		rep_nop();
+		cpu_relax();
 
 	smp_online();
 
@@ -482,7 +482,7 @@ static void __init smp_callin(void)
 		/* Has the boot CPU finished it's STARTUP sequence ? */
 		if (cpu_isset(cpu_id, cpu_callout_map))
 			break;
-		rep_nop();
+		cpu_relax();
 	}
 
 	if (!time_before(jiffies, timeout)) {

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
