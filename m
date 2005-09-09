Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030456AbVIIWnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbVIIWnS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbVIIWlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:41:49 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:35863 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1030457AbVIIWkY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:40:24 -0400
Cc: Sam Ravnborg <sam@mars (none)>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 7/12] kbuild: v850 use generic asm-offsets.h support
In-Reply-To: <11263057061063-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Sat, 10 Sep 2005 00:41:46 +0200
Message-Id: <11263057063890-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deleted obsolete stuff from arch makefile
Renamed .c file to asm-offsets.h
Fix include of asm-offsets.h to use new name

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 arch/v850/Makefile             |   14 +--------
 arch/v850/kernel/asm-consts.c  |   61 ----------------------------------------
 arch/v850/kernel/asm-offsets.c |   61 ++++++++++++++++++++++++++++++++++++++++
 arch/v850/kernel/entry.S       |    2 +
 4 files changed, 63 insertions(+), 75 deletions(-)
 delete mode 100644 arch/v850/kernel/asm-consts.c
 create mode 100644 arch/v850/kernel/asm-offsets.c

fb61a8615fce15f30b1bb1cf265ed05e251b9ed8
diff --git a/arch/v850/Makefile b/arch/v850/Makefile
--- a/arch/v850/Makefile
+++ b/arch/v850/Makefile
@@ -51,16 +51,4 @@ root_fs_image_force: $(ROOT_FS_IMAGE)
 	$(OBJCOPY) $(OBJCOPY_FLAGS_BLOB) --rename-section .data=.root,alloc,load,readonly,data,contents $< root_fs_image.o
 endif
 
-
-prepare: include/asm-$(ARCH)/asm-consts.h
-
-# Generate constants from C code for use by asm files
-arch/$(ARCH)/kernel/asm-consts.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-$(ARCH)/asm-consts.h: arch/$(ARCH)/kernel/asm-consts.s
-	$(call filechk,gen-asm-offsets)
-
-CLEAN_FILES += include/asm-$(ARCH)/asm-consts.h \
-	       arch/$(ARCH)/kernel/asm-consts.s \
-	       root_fs_image.o
+CLEAN_FILES += root_fs_image.o
diff --git a/arch/v850/kernel/asm-consts.c b/arch/v850/kernel/asm-consts.c
deleted file mode 100644
--- a/arch/v850/kernel/asm-consts.c
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
- * This program is used to generate definitions needed by
- * assembly language modules.
- *
- * We use the technique used in the OSF Mach kernel code:
- * generate asm statements containing #defines,
- * compile this file to assembler, and then extract the
- * #defines from the assembly-language output.
- */
-
-#include <linux/stddef.h>
-#include <linux/sched.h>
-#include <linux/kernel_stat.h>
-#include <linux/ptrace.h>
-#include <linux/hardirq.h>
-#include <asm/irq.h>
-#include <asm/errno.h>
-
-#define DEFINE(sym, val) \
-	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
-
-#define BLANK() asm volatile("\n->" : : )
-
-int main (void)
-{
-	/* offsets into the task struct */
-	DEFINE (TASK_STATE, offsetof (struct task_struct, state));
-	DEFINE (TASK_FLAGS, offsetof (struct task_struct, flags));
-	DEFINE (TASK_PTRACE, offsetof (struct task_struct, ptrace));
-	DEFINE (TASK_BLOCKED, offsetof (struct task_struct, blocked));
-	DEFINE (TASK_THREAD, offsetof (struct task_struct, thread));
-	DEFINE (TASK_THREAD_INFO, offsetof (struct task_struct, thread_info));
-	DEFINE (TASK_MM, offsetof (struct task_struct, mm));
-	DEFINE (TASK_ACTIVE_MM, offsetof (struct task_struct, active_mm));
-	DEFINE (TASK_PID, offsetof (struct task_struct, pid));
-
-	/* offsets into the kernel_stat struct */
-	DEFINE (STAT_IRQ, offsetof (struct kernel_stat, irqs));
-
-
-	/* signal defines */
-	DEFINE (SIGSEGV, SIGSEGV);
-	DEFINE (SEGV_MAPERR, SEGV_MAPERR);
-	DEFINE (SIGTRAP, SIGTRAP);
-	DEFINE (SIGCHLD, SIGCHLD);
-	DEFINE (SIGILL, SIGILL);
-	DEFINE (TRAP_TRACE, TRAP_TRACE);
-
-	/* ptrace flag bits */
-	DEFINE (PT_PTRACED, PT_PTRACED);
-	DEFINE (PT_DTRACE, PT_DTRACE);
-
-	/* error values */
-	DEFINE (ENOSYS, ENOSYS);
-
-	/* clone flag bits */
-	DEFINE (CLONE_VFORK, CLONE_VFORK);
-	DEFINE (CLONE_VM, CLONE_VM);
-
-	return 0;
-}
diff --git a/arch/v850/kernel/asm-offsets.c b/arch/v850/kernel/asm-offsets.c
new file mode 100644
--- /dev/null
+++ b/arch/v850/kernel/asm-offsets.c
@@ -0,0 +1,61 @@
+/*
+ * This program is used to generate definitions needed by
+ * assembly language modules.
+ *
+ * We use the technique used in the OSF Mach kernel code:
+ * generate asm statements containing #defines,
+ * compile this file to assembler, and then extract the
+ * #defines from the assembly-language output.
+ */
+
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/kernel_stat.h>
+#include <linux/ptrace.h>
+#include <linux/hardirq.h>
+#include <asm/irq.h>
+#include <asm/errno.h>
+
+#define DEFINE(sym, val) \
+	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+
+#define BLANK() asm volatile("\n->" : : )
+
+int main (void)
+{
+	/* offsets into the task struct */
+	DEFINE (TASK_STATE, offsetof (struct task_struct, state));
+	DEFINE (TASK_FLAGS, offsetof (struct task_struct, flags));
+	DEFINE (TASK_PTRACE, offsetof (struct task_struct, ptrace));
+	DEFINE (TASK_BLOCKED, offsetof (struct task_struct, blocked));
+	DEFINE (TASK_THREAD, offsetof (struct task_struct, thread));
+	DEFINE (TASK_THREAD_INFO, offsetof (struct task_struct, thread_info));
+	DEFINE (TASK_MM, offsetof (struct task_struct, mm));
+	DEFINE (TASK_ACTIVE_MM, offsetof (struct task_struct, active_mm));
+	DEFINE (TASK_PID, offsetof (struct task_struct, pid));
+
+	/* offsets into the kernel_stat struct */
+	DEFINE (STAT_IRQ, offsetof (struct kernel_stat, irqs));
+
+
+	/* signal defines */
+	DEFINE (SIGSEGV, SIGSEGV);
+	DEFINE (SEGV_MAPERR, SEGV_MAPERR);
+	DEFINE (SIGTRAP, SIGTRAP);
+	DEFINE (SIGCHLD, SIGCHLD);
+	DEFINE (SIGILL, SIGILL);
+	DEFINE (TRAP_TRACE, TRAP_TRACE);
+
+	/* ptrace flag bits */
+	DEFINE (PT_PTRACED, PT_PTRACED);
+	DEFINE (PT_DTRACE, PT_DTRACE);
+
+	/* error values */
+	DEFINE (ENOSYS, ENOSYS);
+
+	/* clone flag bits */
+	DEFINE (CLONE_VFORK, CLONE_VFORK);
+	DEFINE (CLONE_VM, CLONE_VM);
+
+	return 0;
+}
diff --git a/arch/v850/kernel/entry.S b/arch/v850/kernel/entry.S
--- a/arch/v850/kernel/entry.S
+++ b/arch/v850/kernel/entry.S
@@ -22,7 +22,7 @@
 #include <asm/irq.h>
 #include <asm/errno.h>
 
-#include <asm/asm-consts.h>
+#include <asm/asm-offsets.h>
 
 
 /* Make a slightly more convenient alias for C_SYMBOL_NAME.  */


