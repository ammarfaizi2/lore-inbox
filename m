Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWAOUtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWAOUtr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWAOUtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:49:19 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:39331 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750753AbWAOUtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:49:08 -0500
Message-Id: <200601152139.k0FLdapx027710@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Subject: [PATCH 2/11] UML - Move libc-dependent utility procedures
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 15 Jan 2006 16:39:36 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gennady Sharapov <Gennady.V.Sharapov@intel.com>

The serial UML OS-abstraction layer patch (um/kernel dir).

This moves all systemcalls from user_util.c file under os-Linux dir

Signed-off-by: Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/drivers/fd.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/drivers/fd.c	2006-01-06 21:23:35.000000000 -0500
+++ linux-2.6.15-mm/arch/um/drivers/fd.c	2006-01-06 21:24:14.000000000 -0500
@@ -11,6 +11,7 @@
 #include "user.h"
 #include "user_util.h"
 #include "chan_user.h"
+#include "os.h"
 
 struct fd_chan {
 	int fd;
Index: linux-2.6.15-mm/arch/um/include/os.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/include/os.h	2006-01-06 21:24:14.000000000 -0500
+++ linux-2.6.15-mm/arch/um/include/os.h	2006-01-06 21:46:20.000000000 -0500
@@ -195,6 +195,8 @@ extern unsigned long long os_usecs(void)
 /* tt.c
  * for tt mode only (will be deleted in future...)
  */
+extern void stop(void);
+extern int wait_for_stop(int pid, int sig, int cont_type, void *relay);
 extern int protect_memory(unsigned long addr, unsigned long len,
 			  int r, int w, int x, int must_succeed);
 extern void forward_pending_sigio(int target);
@@ -235,4 +237,12 @@ extern int set_signals(int enable);
 extern void os_fill_handlinfo(struct kern_handlers h);
 extern void do_longjmp(void *p, int val);
 
+/* util.c */
+extern void stack_protections(unsigned long address);
+extern void task_protections(unsigned long address);
+extern int raw(int fd);
+extern void setup_machinename(char *machine_out);
+extern void setup_hostinfo(void);
+extern int setjmp_wrapper(void (*proc)(void *, void *), ...);
+
 #endif
Index: linux-2.6.15-mm/arch/um/include/user_util.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/include/user_util.h	2006-01-06 21:24:14.000000000 -0500
+++ linux-2.6.15-mm/arch/um/include/user_util.h	2006-01-06 21:24:14.000000000 -0500
@@ -44,10 +44,6 @@ extern unsigned long brk_start;
 extern int pty_output_sigio;
 extern int pty_close_sigio;
 
-extern void stop(void);
-extern void stack_protections(unsigned long address);
-extern void task_protections(unsigned long address);
-extern int wait_for_stop(int pid, int sig, int cont_type, void *relay);
 extern void *add_signal_handler(int sig, void (*handler)(int));
 extern int linux_main(int argc, char **argv);
 extern void set_cmdline(char *cmd);
@@ -55,8 +51,6 @@ extern void input_cb(void (*proc)(void *
 extern int get_pty(void);
 extern void *um_kmalloc(int size);
 extern int switcheroo(int fd, int prot, void *from, void *to, int size);
-extern void setup_machinename(char *machine_out);
-extern void setup_hostinfo(void);
 extern void do_exec(int old_pid, int new_pid);
 extern void tracer_panic(char *msg, ...);
 extern int detach(int pid, int sig);
@@ -70,18 +64,6 @@ extern int cpu_feature(char *what, char 
 extern int arch_handle_signal(int sig, union uml_pt_regs *regs);
 extern int arch_fixup(unsigned long address, void *sc_ptr);
 extern void arch_init_thread(void);
-extern int setjmp_wrapper(void (*proc)(void *, void *), ...);
 extern int raw(int fd);
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.15-mm/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/Makefile	2006-01-06 21:24:14.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/Makefile	2006-01-06 21:46:20.000000000 -0500
@@ -10,8 +10,7 @@ obj-y = config.o exec_kern.o exitcode.o 
 	init_task.o irq.o irq_user.o ksyms.o mem.o physmem.o \
 	process_kern.o ptrace.o reboot.o resource.o sigio_user.o sigio_kern.o \
 	signal_kern.o smp.o syscall_kern.o sysrq.o time.o \
-	time_kern.o tlb.o trap_kern.o uaccess.o um_arch.o umid.o \
-	user_util.o
+	time_kern.o tlb.o trap_kern.o uaccess.o um_arch.o umid.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
@@ -24,7 +23,7 @@ obj-$(CONFIG_MODE_SKAS) += skas/
 
 user-objs-$(CONFIG_TTY_LOG) += tty_log.o
 
-USER_OBJS := $(user-objs-y) config.o time.o tty_log.o user_util.o
+USER_OBJS := $(user-objs-y) config.o time.o tty_log.o
 
 include arch/um/scripts/Makefile.rules
 
Index: linux-2.6.15-mm/arch/um/kernel/skas/uaccess.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/skas/uaccess.c	2006-01-06 21:23:35.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/skas/uaccess.c	2006-01-06 21:24:14.000000000 -0500
@@ -13,7 +13,7 @@
 #include "asm/pgtable.h"
 #include "asm/uaccess.h"
 #include "kern_util.h"
-#include "user_util.h"
+#include "os.h"
 
 extern void *um_virt_to_phys(struct task_struct *task, unsigned long addr,
 			     pte_t *pte_out);
Index: linux-2.6.15-mm/arch/um/kernel/tt/gdb.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/tt/gdb.c	2006-01-06 21:23:35.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/tt/gdb.c	2006-01-06 21:24:14.000000000 -0500
@@ -20,6 +20,7 @@
 #include "user_util.h"
 #include "tt.h"
 #include "sysdep/thread.h"
+#include "os.h"
 
 extern int debugger_pid;
 extern int debugger_fd;
Index: linux-2.6.15-mm/arch/um/kernel/tt/ptproxy/ptrace.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/tt/ptproxy/ptrace.c	2006-01-06 21:23:35.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/tt/ptproxy/ptrace.c	2006-01-06 21:24:14.000000000 -0500
@@ -20,6 +20,7 @@ Jeff Dike (jdike@karaya.com) : Modified 
 #include "kern_util.h"
 #include "ptrace_user.h"
 #include "tt.h"
+#include "os.h"
 
 long proxy_ptrace(struct debugger *debugger, int arg1, pid_t arg2,
 		  long arg3, long arg4, pid_t child, int *ret)
Index: linux-2.6.15-mm/arch/um/kernel/tt/ptproxy/sysdep.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/tt/ptproxy/sysdep.c	2006-01-06 21:23:35.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/tt/ptproxy/sysdep.c	2006-01-06 21:24:14.000000000 -0500
@@ -15,6 +15,7 @@ terms and conditions.
 #include "ptrace_user.h"
 #include "user_util.h"
 #include "user.h"
+#include "os.h"
 
 int get_syscall(pid_t pid, long *arg1, long *arg2, long *arg3, long *arg4, 
 		long *arg5)
Index: linux-2.6.15-mm/arch/um/kernel/user_util.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/user_util.c	2006-01-06 21:23:35.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,174 +0,0 @@
-/* 
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <limits.h>
-#include <setjmp.h>
-#include <sys/mman.h>
-#include <sys/stat.h>
-#include <sys/utsname.h>
-#include <sys/param.h>
-#include <sys/time.h>
-#include "asm/types.h"
-#include <ctype.h>
-#include <signal.h>
-#include <wait.h>
-#include <errno.h>
-#include <stdarg.h>
-#include <sched.h>
-#include <termios.h>
-#include <string.h>
-#include "user_util.h"
-#include "kern_util.h"
-#include "user.h"
-#include "mem_user.h"
-#include "init.h"
-#include "ptrace_user.h"
-#include "uml-config.h"
-
-void stop(void)
-{
-	while(1) sleep(1000000);
-}
-
-void stack_protections(unsigned long address)
-{
-	int prot = PROT_READ | PROT_WRITE | PROT_EXEC;
-
-        if(mprotect((void *) address, page_size(), prot) < 0)
-		panic("protecting stack failed, errno = %d", errno);
-}
-
-void task_protections(unsigned long address)
-{
-	unsigned long guard = address + page_size();
-	unsigned long stack = guard + page_size();
-	int prot = 0, pages;
-
-#ifdef notdef
-	if(mprotect((void *) stack, page_size(), prot) < 0)
-		panic("protecting guard page failed, errno = %d", errno);
-#endif
-	pages = (1 << UML_CONFIG_KERNEL_STACK_ORDER) - 2;
-	prot = PROT_READ | PROT_WRITE | PROT_EXEC;
-	if(mprotect((void *) stack, pages * page_size(), prot) < 0)
-		panic("protecting stack failed, errno = %d", errno);
-}
-
-int wait_for_stop(int pid, int sig, int cont_type, void *relay)
-{
-	sigset_t *relay_signals = relay;
-	int status, ret;
-
-	while(1){
-		CATCH_EINTR(ret = waitpid(pid, &status, WUNTRACED));
-		if((ret < 0) ||
-		   !WIFSTOPPED(status) || (WSTOPSIG(status) != sig)){
-			if(ret < 0){
-				printk("wait failed, errno = %d\n",
-				       errno);
-			}
-			else if(WIFEXITED(status)) 
-				printk("process %d exited with status %d\n",
-				       pid, WEXITSTATUS(status));
-			else if(WIFSIGNALED(status))
-				printk("process %d exited with signal %d\n",
-				       pid, WTERMSIG(status));
-			else if((WSTOPSIG(status) == SIGVTALRM) ||
-				(WSTOPSIG(status) == SIGALRM) ||
-				(WSTOPSIG(status) == SIGIO) ||
-				(WSTOPSIG(status) == SIGPROF) ||
-				(WSTOPSIG(status) == SIGCHLD) ||
-				(WSTOPSIG(status) == SIGWINCH) ||
-				(WSTOPSIG(status) == SIGINT)){
-				ptrace(cont_type, pid, 0, WSTOPSIG(status));
-				continue;
-			}
-			else if((relay_signals != NULL) &&
-				sigismember(relay_signals, WSTOPSIG(status))){
-				ptrace(cont_type, pid, 0, WSTOPSIG(status));
-				continue;
-			}
-			else printk("process %d stopped with signal %d\n",
-				    pid, WSTOPSIG(status));
-			panic("wait_for_stop failed to wait for %d to stop "
-			      "with %d\n", pid, sig);
-		}
-		return(status);
-	}
-}
-
-int raw(int fd)
-{
-	struct termios tt;
-	int err;
-
-	CATCH_EINTR(err = tcgetattr(fd, &tt));
-	if(err < 0)
-		return -errno;
-
-	cfmakeraw(&tt);
-
- 	CATCH_EINTR(err = tcsetattr(fd, TCSADRAIN, &tt));
-	if(err < 0)
-		return -errno;
-
-	/* XXX tcsetattr could have applied only some changes
-	 * (and cfmakeraw() is a set of changes) */
-	return(0);
-}
-
-void setup_machinename(char *machine_out)
-{
-	struct utsname host;
-
-	uname(&host);
-#if defined(UML_CONFIG_UML_X86) && !defined(UML_CONFIG_64BIT)
-	if (!strcmp(host.machine, "x86_64")) {
-		strcpy(machine_out, "i686");
-		return;
-	}
-#endif
-	strcpy(machine_out, host.machine);
-}
-
-char host_info[(_UTSNAME_LENGTH + 1) * 4 + _UTSNAME_NODENAME_LENGTH + 1];
-
-void setup_hostinfo(void)
-{
-	struct utsname host;
-
-	uname(&host);
-	sprintf(host_info, "%s %s %s %s %s", host.sysname, host.nodename,
-		host.release, host.version, host.machine);
-}
-
-int setjmp_wrapper(void (*proc)(void *, void *), ...)
-{
-        va_list args;
-	sigjmp_buf buf;
-	int n;
-
-	n = sigsetjmp(buf, 1);
-	if(n == 0){
-		va_start(args, proc);
-		(*proc)(&buf, &args);
-	}
-	va_end(args);
-	return(n);
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.15-mm/arch/um/os-Linux/Makefile
===================================================================
--- linux-2.6.15-mm.orig/arch/um/os-Linux/Makefile	2006-01-06 21:24:14.000000000 -0500
+++ linux-2.6.15-mm/arch/um/os-Linux/Makefile	2006-01-06 21:24:14.000000000 -0500
@@ -5,12 +5,12 @@
 
 obj-y = aio.o elf_aux.o file.o helper.o main.o mem.o process.o signal.o \
 	start_up.o time.o trap.o tt.o tty.o uaccess.o umid.o user_syms.o \
-	drivers/ sys-$(SUBARCH)/
+	util.o drivers/ sys-$(SUBARCH)/
 
 obj-$(CONFIG_MODE_SKAS) += skas/
 
 USER_OBJS := aio.o elf_aux.o file.o helper.o main.o mem.o process.o signal.o \
-	start_up.o time.o trap.o tt.o tty.o uaccess.o umid.o
+	start_up.o time.o trap.o tt.o tty.o uaccess.o umid.o util.o
 
 elf_aux.o: $(ARCH_DIR)/kernel-offsets.h
 CFLAGS_elf_aux.o += -I$(objtree)/arch/um
Index: linux-2.6.15-mm/arch/um/os-Linux/tt.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/os-Linux/tt.c	2006-01-06 21:24:14.000000000 -0500
+++ linux-2.6.15-mm/arch/um/os-Linux/tt.c	2006-01-06 21:46:20.000000000 -0500
@@ -63,6 +63,54 @@ void kill_child_dead(int pid)
 	} while(1);
 }
 
+void stop(void)
+{
+	while(1) sleep(1000000);
+}
+
+int wait_for_stop(int pid, int sig, int cont_type, void *relay)
+{
+	sigset_t *relay_signals = relay;
+	int status, ret;
+
+	while(1){
+		CATCH_EINTR(ret = waitpid(pid, &status, WUNTRACED));
+		if((ret < 0) ||
+		   !WIFSTOPPED(status) || (WSTOPSIG(status) != sig)){
+			if(ret < 0){
+				printk("wait failed, errno = %d\n",
+				       errno);
+			}
+			else if(WIFEXITED(status))
+				printk("process %d exited with status %d\n",
+				       pid, WEXITSTATUS(status));
+			else if(WIFSIGNALED(status))
+				printk("process %d exited with signal %d\n",
+				       pid, WTERMSIG(status));
+			else if((WSTOPSIG(status) == SIGVTALRM) ||
+				(WSTOPSIG(status) == SIGALRM) ||
+				(WSTOPSIG(status) == SIGIO) ||
+				(WSTOPSIG(status) == SIGPROF) ||
+				(WSTOPSIG(status) == SIGCHLD) ||
+				(WSTOPSIG(status) == SIGWINCH) ||
+				(WSTOPSIG(status) == SIGINT)){
+				ptrace(cont_type, pid, 0, WSTOPSIG(status));
+				continue;
+			}
+			else if((relay_signals != NULL) &&
+				sigismember(relay_signals, WSTOPSIG(status))){
+				ptrace(cont_type, pid, 0, WSTOPSIG(status));
+				continue;
+			}
+			else printk("process %d stopped with signal %d\n",
+				    pid, WSTOPSIG(status));
+			panic("wait_for_stop failed to wait for %d to stop "
+			      "with %d\n", pid, sig);
+		}
+		return(status);
+	}
+}
+
 /*
  *-------------------------
  * only for tt mode (will be deleted in future...)
Index: linux-2.6.15-mm/arch/um/os-Linux/util.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/os-Linux/util.c	2006-01-06 21:46:42.000000000 -0500
@@ -0,0 +1,116 @@
+/*
+ * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <limits.h>
+#include <setjmp.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/utsname.h>
+#include <sys/param.h>
+#include <sys/time.h>
+#include "asm/types.h"
+#include <ctype.h>
+#include <signal.h>
+#include <wait.h>
+#include <errno.h>
+#include <stdarg.h>
+#include <sched.h>
+#include <termios.h>
+#include <string.h>
+#include "user_util.h"
+#include "kern_util.h"
+#include "user.h"
+#include "mem_user.h"
+#include "init.h"
+#include "ptrace_user.h"
+#include "uml-config.h"
+#include "os.h"
+
+void stack_protections(unsigned long address)
+{
+	int prot = PROT_READ | PROT_WRITE | PROT_EXEC;
+
+	if(mprotect((void *) address, page_size(), prot) < 0)
+		panic("protecting stack failed, errno = %d", errno);
+}
+
+void task_protections(unsigned long address)
+{
+	unsigned long guard = address + page_size();
+	unsigned long stack = guard + page_size();
+	int prot = 0, pages;
+
+#ifdef notdef
+	if(mprotect((void *) stack, page_size(), prot) < 0)
+		panic("protecting guard page failed, errno = %d", errno);
+#endif
+	pages = (1 << UML_CONFIG_KERNEL_STACK_ORDER) - 2;
+	prot = PROT_READ | PROT_WRITE | PROT_EXEC;
+	if(mprotect((void *) stack, pages * page_size(), prot) < 0)
+		panic("protecting stack failed, errno = %d", errno);
+}
+
+int raw(int fd)
+{
+	struct termios tt;
+	int err;
+
+	CATCH_EINTR(err = tcgetattr(fd, &tt));
+	if(err < 0)
+		return -errno;
+
+	cfmakeraw(&tt);
+
+	CATCH_EINTR(err = tcsetattr(fd, TCSADRAIN, &tt));
+	if(err < 0)
+		return -errno;
+
+	/* XXX tcsetattr could have applied only some changes
+	 * (and cfmakeraw() is a set of changes) */
+	return(0);
+}
+
+void setup_machinename(char *machine_out)
+{
+	struct utsname host;
+
+	uname(&host);
+#if defined(UML_CONFIG_UML_X86) && !defined(UML_CONFIG_64BIT)
+	if (!strcmp(host.machine, "x86_64")) {
+		strcpy(machine_out, "i686");
+		return;
+	}
+#endif
+	strcpy(machine_out, host.machine);
+}
+
+char host_info[(_UTSNAME_LENGTH + 1) * 4 + _UTSNAME_NODENAME_LENGTH + 1];
+
+void setup_hostinfo(void)
+{
+	struct utsname host;
+
+	uname(&host);
+	sprintf(host_info, "%s %s %s %s %s", host.sysname, host.nodename,
+		host.release, host.version, host.machine);
+}
+
+int setjmp_wrapper(void (*proc)(void *, void *), ...)
+{
+	va_list args;
+	sigjmp_buf buf;
+	int n;
+
+	n = sigsetjmp(buf, 1);
+	if(n == 0){
+		va_start(args, proc);
+		(*proc)(&buf, &args);
+	}
+	va_end(args);
+	return(n);
+}

