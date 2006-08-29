Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWH2RWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWH2RWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 13:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWH2RWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 13:22:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53950 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751143AbWH2RWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 13:22:04 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060827215636.263883000@klappe.arndb.de> 
References: <20060827215636.263883000@klappe.arndb.de>  <20060827214734.252316000@klappe.arndb.de> 
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Jeff Dike <jdike@addtoit.com>, Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au
Subject: Re: [PATCH 3/7] provide kernel_execve on all architectures 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 29 Aug 2006 18:21:08 +0100
Message-ID: <25403.1156872068@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> Most architectures can probably implement this in a nicer way
> in assembly or by combining it with the sys_execve implementation
> itself, but this should do it for now.

Try applying the attached delta for FRV.  Note that you didn't #include
asm/unistd.h in your original patch.

Signed-Off-By: David Howells <dhowells@redhat.com>

---
diff --git a/arch/frv/kernel/Makefile b/arch/frv/kernel/Makefile
index 91d380a..7bf175c 100644
--- a/arch/frv/kernel/Makefile
+++ b/arch/frv/kernel/Makefile
@@ -8,7 +8,7 @@ heads-$(CONFIG_MMU)		:= head-mmu-fr451.o
 extra-y:= head.o init_task.o vmlinux.lds
 
 obj-y := $(heads-y) entry.o entry-table.o break.o switch_to.o kernel_thread.o \
-	 process.o traps.o ptrace.o signal.o dma.o \
+	 kernel_execve.o process.o traps.o ptrace.o signal.o dma.o \
 	 sys_frv.o time.o semaphore.o setup.o frv_ksyms.o \
 	 debug-stub.o irq.o irq-routing.o sleep.o uaccess.o atomic-ops.o
 
diff --git a/arch/frv/kernel/sys_frv.c b/arch/frv/kernel/sys_frv.c
index 944aab2..c4d4348 100644
--- a/arch/frv/kernel/sys_frv.c
+++ b/arch/frv/kernel/sys_frv.c
@@ -212,19 +212,3 @@ asmlinkage long sys_ipc(unsigned long ca
 		return -ENOSYS;
 	}
 }
-
-/*
- * Do a system call from kernel instead of calling sys_execve so we
- * end up with proper pt_regs.
- */
-int kernel_execve(const char *filename, char *const argv[], char *const envp[])
-{
-	register unsigned long __scnum __asm__ ("gr7") = __NR_execve;
-	register unsigned long __sc0 __asm__ ("gr8") = (unsigned long) filename;
-	register unsigned long __sc1 __asm__ ("gr9") = (unsigned long) argv;
-	register unsigned long __sc2 __asm__ ("gr10") = (unsigned long) envp;
-	__asm__ __volatile__ ("tira gr0,#0"
-			      : "+r" (__sc0)
-			      : "r" (__scnum), "r" (__sc1), "r" (__sc2));
-	return __sc0;
-}
diff --git a/arch/frv/kernel/kernel_execve.S b/arch/frv/kernel/kernel_execve.S
new file mode 100644
index 0000000..9b074a1
--- /dev/null
+++ b/arch/frv/kernel/kernel_execve.S
@@ -0,0 +1,33 @@
+/* in-kernel program execution
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/linkage.h>
+#include <asm/unistd.h>
+
+###############################################################################
+#
+# Do a system call from kernel instead of calling sys_execve so we end up with
+# proper pt_regs.
+#
+# int kernel_execve(const char *filename, char *const argv[], char *const envp[])
+#
+# On entry: GR8/GR9/GR10: arguments to function
+# On return: GR8: syscall return.
+#
+###############################################################################
+	.globl		kernel_execve
+	.type		kernel_execve,@function
+kernel_execve:
+	setlos		__NR_execve,gr7
+	tira		gr0,#0
+	bralr
+
+	.size		kernel_execve,.-kernel_execve
