Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUBYU0J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 15:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbUBYU0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 15:26:09 -0500
Received: from mail.timesys.com ([65.117.135.102]:49771 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261426AbUBYUZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:25:57 -0500
Message-ID: <403D04D4.3020502@timesys.com>
Date: Wed, 25 Feb 2004 15:25:56 -0500
From: Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH} PPC 32 multithreaded core dumps
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2004 20:18:40.0890 (UTC) FILETIME=[8F1C9DA0:01C3FBDC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This code fixes the register dumps for 32 bit ppc multi threaded core 
dumps. It's largely based on the ppc64 code. It was tested on an 8260 
processor with the TimeSys modified 2.6.1 kernel. The patch is for 
2.6.3. Let me know if there are any problems with it. If anyone can tell 
me why arch/ppc/boot/simple/misc.c was including elf.h in the first 
place I'd appreciate it. It doesn't appear to need it and it doesn't 
like task_struct now.

Greg Weeks



diff -uprN linux-2.6.3.orig/arch/ppc/boot/simple/misc.c 
linux-2.6.3.change/arch/ppc/boot/simple/misc.c
--- linux-2.6.3.orig/arch/ppc/boot/simple/misc.c    2004-02-17 
22:59:11.000000000 -0500
+++ linux-2.6.3.change/arch/ppc/boot/simple/misc.c    2004-02-25 
14:10:30.000000000 -0500
@@ -17,7 +17,6 @@
  */
 
 #include <linux/types.h>
-#include <linux/elf.h>
 #include <linux/config.h>
 #include <linux/string.h>
 
diff -uprN linux-2.6.3.orig/arch/ppc/kernel/process.c 
linux-2.6.3.change/arch/ppc/kernel/process.c
--- linux-2.6.3.orig/arch/ppc/kernel/process.c    2004-02-17 
22:57:53.000000000 -0500
+++ linux-2.6.3.change/arch/ppc/kernel/process.c    2004-02-25 
14:12:13.000000000 -0500
@@ -45,7 +45,6 @@
 #include <asm/prom.h>
 #include <asm/hardirq.h>
 
-int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpregs);
 extern unsigned long _get_SP(void);
 
 struct task_struct *last_task_used_math = NULL;
@@ -188,12 +187,17 @@ enable_kernel_fp(void)
 #endif /* CONFIG_SMP */
 }
 
-int
-dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpregs)
+int dump_task_fpu(struct task_struct *tsk, elf_fpregset_t *fpregs)
 {
-    if (regs->msr & MSR_FP)
+    struct pt_regs *regs = tsk->thread.regs;
+
+    if (!regs)
+        return 0;
+    if (tsk == current && (regs->msr & MSR_FP))
         giveup_fpu(current);
-    memcpy(fpregs, &current->thread.fpr[0], sizeof(*fpregs));
+
+    memcpy(fpregs, &tsk->thread.fpr[0], sizeof(*fpregs));
+
     return 1;
 }
 
diff -uprN linux-2.6.3.orig/include/asm-ppc/elf.h 
linux-2.6.3.change/include/asm-ppc/elf.h
--- linux-2.6.3.orig/include/asm-ppc/elf.h    2004-02-17 
22:57:11.000000000 -0500
+++ linux-2.6.3.change/include/asm-ppc/elf.h    2004-02-25 
14:14:21.000000000 -0500
@@ -90,11 +90,33 @@ typedef elf_vrreg_t elf_vrregset_t[ELF_N
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE    4096
 
-#define ELF_CORE_COPY_REGS(gregs, regs) \
-    memcpy(gregs, regs, \
-           sizeof(struct pt_regs) < sizeof(elf_gregset_t)? \
-           sizeof(struct pt_regs): sizeof(elf_gregset_t));
+static inline void ppc_elf_core_copy_regs(elf_gregset_t elf_regs,
+                        struct pt_regs *regs)
+{
+    int i;
+    int gprs = sizeof(struct pt_regs)/sizeof(elf_greg_t);
+
+    if (gprs > ELF_NGREG)
+        gprs = ELF_NGREG;
+
+    for (i=0; i < gprs; i++)
+        elf_regs[i] = (elf_greg_t)((elf_greg_t *)regs)[i];
+}
+#define ELF_CORE_COPY_REGS(gregs, regs) ppc_elf_core_copy_regs(gregs, 
regs);
+
+static inline int dump_task_regs(struct task_struct *tsk,
+                 elf_gregset_t *elf_regs)
+{
+    struct pt_regs *regs = tsk->thread.regs;
+    if (regs)
+        ppc_elf_core_copy_regs(*elf_regs, regs);
+
+    return 1;
+}
+#define ELF_CORE_COPY_TASK_REGS(tsk, elf_regs) dump_task_regs(tsk, 
elf_regs)
 
+extern int dump_task_fpu(struct task_struct *, elf_fpregset_t *);
+#define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, 
elf_fpregs)
 
 /* This yields a mask that user programs can use to figure out what
    instruction set this cpu supports.  This could be done in userspace,

