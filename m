Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVBJSaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVBJSaO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 13:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVBJSaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 13:30:14 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:42000 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S262188AbVBJS36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 13:29:58 -0500
Subject: [patch 1/1] uml: use PTRACE_OLDSETOPTIONS instead of PTRACE_SETOPTIONS [before 2.6.11]
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       bstroesser@fujitsu-siemens.com
From: blaisorblade@yahoo.it
Date: Thu, 10 Feb 2005 19:28:39 +0100
Message-Id: <20050210182839.04C854B51@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: blaisorblade@yahoo.it, jdike@addtoit.com

In linux 2.6, PTRACE_SETOPTIONS is redefined to 0x4200, while the old 2.4
value (21) is still available as PTRACE_OLDSETOPTIONS.

So, if UML uses PTRACE_SETOPTIONS, an UML-kernel built on a 2.6 won't run on a
2.4 host. Hence we must use PTRACE_OLDSETOPTIONS.

For cases when PTRACE_OLDSETOPTIONS does not exists (i.e. 2.4 host or archs
which miss it because they don't have a "deprecated" value), we fallback this
macro to PTRACE_SETOPTIONS.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/include/ptrace_user.h               |   20 ++++++++++
 linux-2.6.11-paolo/arch/um/include/sysdep-x86_64/ptrace_user.h |    7 ++-
 linux-2.6.11-paolo/arch/um/kernel/process.c                    |    2 -
 linux-2.6.11-paolo/arch/um/kernel/skas/process.c               |    2 -
 linux-2.6.11-paolo/arch/um/kernel/tt/exec_user.c               |    2 -
 linux-2.6.11-paolo/arch/um/kernel/tt/tracer.c                  |    4 +-
 6 files changed, 29 insertions(+), 8 deletions(-)

diff -puN arch/um/include/ptrace_user.h~uml-use-PTRACE_OLDSETOPTIONS-instead-of-PTRACE_SETOPTIONS arch/um/include/ptrace_user.h
--- linux-2.6.11/arch/um/include/ptrace_user.h~uml-use-PTRACE_OLDSETOPTIONS-instead-of-PTRACE_SETOPTIONS	2005-02-10 19:23:14.943498872 +0100
+++ linux-2.6.11-paolo/arch/um/include/ptrace_user.h	2005-02-10 19:23:14.979493400 +0100
@@ -26,6 +26,26 @@ extern void ptrace_pokeuser(unsigned lon
 #define PTRACE_SYSEMU_SINGLESTEP 32
 #endif
 
+/* On architectures, that started to support PTRACE_O_TRACESYSGOOD
+ * in linux 2.4, there are two different definitions of
+ * PTRACE_SETOPTIONS: linux 2.4 uses 21 while linux 2.6 uses 0x4200.
+ * For binary compatibility, 2.6 also supports the old "21", named
+ * PTRACE_OLDSETOPTION. On these architectures, UML always must use
+ * "21", to ensure the kernel runs on 2.4 and 2.6 host without
+ * recompilation. So, we use PTRACE_OLDSETOPTIONS in UML.
+ * We also want to be able to build the kernel on 2.4, which doesn't
+ * have PTRACE_OLDSETOPTIONS. So, if it is missing, we declare
+ * PTRACE_OLDSETOPTIONS to to be the same as PTRACE_SETOPTIONS.
+ *
+ * On architectures, that start to support PTRACE_O_TRACESYSGOOD on
+ * linux 2.6, PTRACE_OLDSETOPTIONS never is defined, and also isn't
+ * supported by the host kernel. In that case, our trick lets us use
+ * the new 0x4200 with the name PTRACE_OLDSETOPTIONS.
+ */
+#ifndef PTRACE_OLDSETOPTIONS
+#define PTRACE_OLDSETOPTIONS PTRACE_SETOPTIONS
+#endif
+
 void set_using_sysemu(int value);
 int get_using_sysemu(void);
 extern int sysemu_supported;
diff -puN arch/um/kernel/process.c~uml-use-PTRACE_OLDSETOPTIONS-instead-of-PTRACE_SETOPTIONS arch/um/kernel/process.c
--- linux-2.6.11/arch/um/kernel/process.c~uml-use-PTRACE_OLDSETOPTIONS-instead-of-PTRACE_SETOPTIONS	2005-02-10 19:23:14.945498568 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/process.c	2005-02-10 19:23:14.980493248 +0100
@@ -322,7 +322,7 @@ void __init check_ptrace(void)
 	printk("Checking that ptrace can change system call numbers...");
 	pid = start_ptraced_child(&stack);
 
-	if(ptrace(PTRACE_SETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+	if (ptrace(PTRACE_OLDSETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
 		panic("check_ptrace: PTRACE_SETOPTIONS failed, errno = %d", errno);
 
 	while(1){
diff -puN arch/um/kernel/skas/process.c~uml-use-PTRACE_OLDSETOPTIONS-instead-of-PTRACE_SETOPTIONS arch/um/kernel/skas/process.c
--- linux-2.6.11/arch/um/kernel/skas/process.c~uml-use-PTRACE_OLDSETOPTIONS-instead-of-PTRACE_SETOPTIONS	2005-02-10 19:23:14.947498264 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/skas/process.c	2005-02-10 19:23:14.980493248 +0100
@@ -124,7 +124,7 @@ void start_userspace(int cpu)
 		panic("start_userspace : expected SIGSTOP, got status = %d",
 		      status);
 
-	if (ptrace(PTRACE_SETOPTIONS, pid, NULL, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+	if (ptrace(PTRACE_OLDSETOPTIONS, pid, NULL, (void *)PTRACE_O_TRACESYSGOOD) < 0)
 		panic("start_userspace : PTRACE_SETOPTIONS failed, errno=%d\n",
 		      errno);
 
diff -puN arch/um/kernel/tt/exec_user.c~uml-use-PTRACE_OLDSETOPTIONS-instead-of-PTRACE_SETOPTIONS arch/um/kernel/tt/exec_user.c
--- linux-2.6.11/arch/um/kernel/tt/exec_user.c~uml-use-PTRACE_OLDSETOPTIONS-instead-of-PTRACE_SETOPTIONS	2005-02-10 19:23:14.949497960 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/tt/exec_user.c	2005-02-10 19:23:14.980493248 +0100
@@ -39,7 +39,7 @@ void do_exec(int old_pid, int new_pid)
 
 	os_kill_ptraced_process(old_pid, 0);
 
-	if (ptrace(PTRACE_SETOPTIONS, new_pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+	if (ptrace(PTRACE_OLDSETOPTIONS, new_pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
 		tracer_panic("do_exec: PTRACE_SETOPTIONS failed, errno = %d", errno);
 
 	if(ptrace_setregs(new_pid, regs) < 0)
diff -puN arch/um/kernel/tt/tracer.c~uml-use-PTRACE_OLDSETOPTIONS-instead-of-PTRACE_SETOPTIONS arch/um/kernel/tt/tracer.c
--- linux-2.6.11/arch/um/kernel/tt/tracer.c~uml-use-PTRACE_OLDSETOPTIONS-instead-of-PTRACE_SETOPTIONS	2005-02-10 19:23:14.951497656 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/tt/tracer.c	2005-02-10 19:23:14.981493096 +0100
@@ -72,7 +72,7 @@ void attach_process(int pid)
 	   (ptrace(PTRACE_CONT, pid, 0, 0) < 0))
 		tracer_panic("OP_FORK failed to attach pid");
 	wait_for_stop(pid, SIGSTOP, PTRACE_CONT, NULL);
-	if (ptrace(PTRACE_SETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+	if (ptrace(PTRACE_OLDSETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
 		tracer_panic("OP_FORK: PTRACE_SETOPTIONS failed, errno = %d", errno);
 	if(ptrace(PTRACE_CONT, pid, 0, 0) < 0)
 		tracer_panic("OP_FORK failed to continue process");
@@ -200,7 +200,7 @@ int tracer(int (*init_proc)(void *), voi
 		printf("waitpid on idle thread failed, errno = %d\n", errno);
 		exit(1);
 	}
-	if (ptrace(PTRACE_SETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0) {
+	if (ptrace(PTRACE_OLDSETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0) {
 		printf("Failed to PTRACE_SETOPTIONS for idle thread, errno = %d\n", errno);
 		exit(1);
 	}
diff -puN arch/um/include/sysdep-x86_64/ptrace_user.h~uml-use-PTRACE_OLDSETOPTIONS-instead-of-PTRACE_SETOPTIONS arch/um/include/sysdep-x86_64/ptrace_user.h
--- linux-2.6.11/arch/um/include/sysdep-x86_64/ptrace_user.h~uml-use-PTRACE_OLDSETOPTIONS-instead-of-PTRACE_SETOPTIONS	2005-02-10 19:26:36.043926960 +0100
+++ linux-2.6.11-paolo/arch/um/include/sysdep-x86_64/ptrace_user.h	2005-02-10 19:27:24.058627616 +0100
@@ -49,10 +49,11 @@
 #define MAX_REG_NR ((MAX_REG_OFFSET) / sizeof(unsigned long))
 
 /* x86_64 FC3 doesn't define this in /usr/include/linux/ptrace.h even though
- * it's defined in the kernel's include/linux/ptrace.h
+ * it's defined in the kernel's include/linux/ptrace.h. Additionally, use the
+ * 2.4 name and value for 2.4 host compatibility.
  */
-#ifndef PTRACE_SETOPTIONS
-#define PTRACE_SETOPTIONS 0x4200
+#ifndef PTRACE_OLDSETOPTIONS
+#define PTRACE_OLDSETOPTIONS 21
 #endif
 
 #endif
_
