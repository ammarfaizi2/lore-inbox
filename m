Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269511AbUINRxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269511AbUINRxD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269531AbUINRta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:49:30 -0400
Received: from [12.177.129.25] ([12.177.129.25]:26563 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S269520AbUINRn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:43:57 -0400
Message-Id: <200409141847.i8EIlZ4W003422@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - Cleaning up
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Sep 2004 14:47:35 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a whole lot of "obviously won't break anything" changes, 
including
	renaming the UML console functions more consistently
	notes to myself
	code movement
	making some functions static
	error path cleanup
	printk fixes

Signed-off-by: Jeff Dike <jdike@addtoit.com>
	
Index: 2.6.9-rc2/arch/um/drivers/stdio_console.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/drivers/stdio_console.c	2004-09-14 13:30:22.000000000 -0400
+++ 2.6.9-rc2/arch/um/drivers/stdio_console.c	2004-09-14 13:30:33.000000000 -0400
@@ -191,7 +191,7 @@
 
 late_initcall(stdio_init);
 
-static void console_write(struct console *console, const char *string, 
+static void uml_console_write(struct console *console, const char *string, 
 			  unsigned len)
 {
 	struct line *line = &vts[console->index];
@@ -203,22 +203,22 @@
 		up(&line->sem);
 }
 
-static struct tty_driver *um_console_device(struct console *c, int *index)
+static struct tty_driver *uml_console_device(struct console *c, int *index)
 {
 	*index = c->index;
 	return console_driver;
 }
 
-static int console_setup(struct console *co, char *options)
+static int uml_console_setup(struct console *co, char *options)
 {
 	return(0);
 }
 
 static struct console stdiocons = {
 	name:		"tty",
-	write:		console_write,
-	device:		um_console_device,
-	setup:		console_setup,
+	write:		uml_console_write,
+	device:		uml_console_device,
+	setup:		uml_console_setup,
 	flags:		CON_PRINTBUFFER,
 	index:		-1,
 };
Index: 2.6.9-rc2/arch/um/drivers/xterm.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/drivers/xterm.c	2004-09-14 13:30:22.000000000 -0400
+++ 2.6.9-rc2/arch/um/drivers/xterm.c	2004-09-14 13:30:33.000000000 -0400
@@ -83,6 +83,7 @@
 "    are 'xterm=gnome-terminal,-t,-x'.\n\n"
 );
 
+/* XXX This badly needs some cleaning up in the error paths */
 int xterm_open(int input, int output, int primary, void *d, char **dev_out)
 {
 	struct xterm_chan *data = d;
Index: 2.6.9-rc2/arch/um/kernel/process.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/process.c	2004-09-14 13:30:32.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/process.c	2004-09-14 13:30:33.000000000 -0400
@@ -139,16 +139,6 @@
 	return(arg.pid);
 }
 
-void suspend_new_thread(int fd)
-{
-	char c;
-
-	os_stop_process(os_getpid());
-
-	if(os_read_file(fd, &c, sizeof(c)) != sizeof(c))
-		panic("read failed in suspend_new_thread");
-}
-
 static int ptrace_child(void *arg)
 {
 	int pid = os_getpid();
Index: 2.6.9-rc2/arch/um/kernel/sigio_kern.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/sigio_kern.c	2004-09-14 13:30:22.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/sigio_kern.c	2004-09-14 13:30:33.000000000 -0400
@@ -16,7 +16,7 @@
 /* Protected by sigio_lock() called from write_sigio_workaround */
 static int sigio_irq_fd = -1;
 
-irqreturn_t sigio_interrupt(int irq, void *data, struct pt_regs *unused)
+static irqreturn_t sigio_interrupt(int irq, void *data, struct pt_regs *unused)
 {
 	read_sigio_fd(sigio_irq_fd);
 	reactivate_fd(sigio_irq_fd, SIGIO_WRITE_IRQ);
@@ -25,10 +25,14 @@
 
 int write_sigio_irq(int fd)
 {
-	if(um_request_irq(SIGIO_WRITE_IRQ, fd, IRQ_READ, sigio_interrupt,
+	int err;
+
+	err = um_request_irq(SIGIO_WRITE_IRQ, fd, IRQ_READ, sigio_interrupt,
 			  SA_INTERRUPT | SA_SAMPLE_RANDOM, "write sigio", 
-			  NULL)){
-		printk("write_sigio_irq : um_request_irq failed\n");
+			     NULL);
+	if(err){
+		printk("write_sigio_irq : um_request_irq failed, err = %d\n",
+		       err);
 		return(-1);
 	}
 	sigio_irq_fd = fd;
Index: 2.6.9-rc2/arch/um/kernel/skas/process.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/skas/process.c	2004-09-14 13:30:32.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/skas/process.c	2004-09-14 13:30:33.000000000 -0400
@@ -375,28 +375,6 @@
 	siglongjmp(initial_jmpbuf, 4);
 }
 
-int new_mm(int from)
-{
-	struct proc_mm_op copy;
-	int n, fd = os_open_file("/proc/mm",
-				 of_cloexec(of_write(OPENFLAGS())), 0);
-
-	if(fd < 0)
-		return(fd);
-
-	if(from != -1){
-		copy = ((struct proc_mm_op) { .op 	= MM_COPY_SEGMENTS,
-					      .u 	= 
-					      { .copy_segments	= from } } );
-		n = os_write_file(fd, &copy, sizeof(copy));
-		if(n != sizeof(copy)) 
-			printk("new_mm : /proc/mm copy_segments failed, "
-			       "err = %d\n", -n);
-	}
-
-	return(fd);
-}
-
 void switch_mm_skas(int mm_fd)
 {
 	int err;
Index: 2.6.9-rc2/arch/um/kernel/skas/process_kern.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/skas/process_kern.c	2004-09-14 13:30:33.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/skas/process_kern.c	2004-09-14 13:30:33.000000000 -0400
@@ -22,6 +22,7 @@
 #include "frame.h"
 #include "kern.h"
 #include "mode.h"
+#include "proc_mm.h"
 
 static atomic_t using_sysemu;
 int sysemu_supported;
@@ -196,6 +197,28 @@
 	return(0);
 }
 
+int new_mm(int from)
+{
+	struct proc_mm_op copy;
+	int n, fd;
+
+	fd = os_open_file("/proc/mm", of_cloexec(of_write(OPENFLAGS())), 0);
+	if(fd < 0)
+		return(fd);
+
+	if(from != -1){
+		copy = ((struct proc_mm_op) { .op 	= MM_COPY_SEGMENTS,
+					      .u 	= 
+					      { .copy_segments	= from } } );
+		n = os_write_file(fd, &copy, sizeof(copy));
+		if(n != sizeof(copy)) 
+			printk("new_mm : /proc/mm copy_segments failed, "
+			       "err = %d\n", -n);
+	}
+
+	return(fd);
+}
+
 void init_idle_skas(void)
 {
 	cpu_tasks[current_thread->cpu].pid = os_getpid();
Index: 2.6.9-rc2/arch/um/kernel/tt/process_kern.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/tt/process_kern.c	2004-09-14 13:30:30.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/tt/process_kern.c	2004-09-14 13:30:33.000000000 -0400
@@ -128,6 +128,17 @@
 	os_close_file(current->thread.mode.tt.switch_pipe[1]);
 }
 
+void suspend_new_thread(int fd)
+{
+	int err;
+	char c;
+
+	os_stop_process(os_getpid());
+	err = os_read_file(fd, &c, sizeof(c));
+	if(err != sizeof(c))
+		panic("read failed in suspend_new_thread, err = %d", -err);
+}
+
 void schedule_tail(task_t *prev);
 
 static void new_thread_handler(int sig)
@@ -162,6 +173,12 @@
 	local_irq_enable();
 	if(!run_kernel_thread(fn, arg, &current->thread.exec_buf))
 		do_exit(0);
+	
+	/* XXX No set_user_mode here because a newly execed process will
+	 * immediately segfault on its non-existent IP, coming straight back
+	 * to the signal handler, which will call set_user_mode on its way
+	 * out.  This should probably change since it's confusing.
+	 */
 }
 
 static int new_thread_proc(void *stack)
Index: 2.6.9-rc2/arch/um/kernel/tt/tracer.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/tt/tracer.c	2004-09-14 13:30:22.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/tt/tracer.c	2004-09-14 13:30:33.000000000 -0400
@@ -330,7 +330,8 @@
 					continue;
 				}
 				tracing = 0;
-				if(do_syscall(task, pid)) sig = SIGUSR2;
+				if(do_syscall(task, pid))
+					sig = SIGUSR2;
 				else clear_singlestep(task);
 				break;
 			case SIGPROF:
Index: 2.6.9-rc2/arch/um/kernel/umid.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/umid.c	2004-09-14 13:30:22.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/umid.c	2004-09-14 13:30:33.000000000 -0400
@@ -43,7 +43,7 @@
 	}
 
 	if(strlen(name) > UMID_LEN - 1)
-		(*printer)("Unique machine name is being truncated to %s "
+		(*printer)("Unique machine name is being truncated to %d "
 			   "characters\n", UMID_LEN);
 	strlcpy(umid, name, sizeof(umid));
 
@@ -199,17 +199,20 @@
 static int __init set_uml_dir(char *name, int *add)
 {
 	if((strlen(name) > 0) && (name[strlen(name) - 1] != '/')){
-		uml_dir = malloc(strlen(name) + 1);
+		uml_dir = malloc(strlen(name) + 2);
 		if(uml_dir == NULL){
 			printf("Failed to malloc uml_dir - error = %d\n",
 			       errno);
 			uml_dir = name;
+			/* Return 0 here because do_initcalls doesn't look at
+			 * the return value.
+			 */
 			return(0);
 		}
 		sprintf(uml_dir, "%s/", name);
 	}
 	else uml_dir = name;
-	return 0;
+	return(0);
 }
 
 static int __init make_uml_dir(void)
Index: 2.6.9-rc2/arch/um/kernel/user_util.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/user_util.c	2004-09-14 13:30:22.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/user_util.c	2004-09-14 13:30:33.000000000 -0400
@@ -88,11 +88,11 @@
 				       errno);
 			}
 			else if(WIFEXITED(status)) 
-				printk("process exited with status %d\n", 
-				       WEXITSTATUS(status));
+				printk("process %d exited with status %d\n", 
+				       pid, WEXITSTATUS(status));
 			else if(WIFSIGNALED(status))
-				printk("process exited with signal %d\n", 
-				       WTERMSIG(status));
+				printk("process %d exited with signal %d\n", 
+				       pid, WTERMSIG(status));
 			else if((WSTOPSIG(status) == SIGVTALRM) ||
 				(WSTOPSIG(status) == SIGALRM) ||
 				(WSTOPSIG(status) == SIGIO) ||
@@ -108,8 +108,8 @@
 				ptrace(cont_type, pid, 0, WSTOPSIG(status));
 				continue;
 			}
-			else printk("process stopped with signal %d\n", 
-				    WSTOPSIG(status));
+			else printk("process %d stopped with signal %d\n", 
+				    pid, WSTOPSIG(status));
 			panic("wait_for_stop failed to wait for %d to stop "
 			      "with %d\n", pid, sig);
 		}
Index: 2.6.9-rc2/arch/um/os-Linux/file.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/os-Linux/file.c	2004-09-14 13:30:30.000000000 -0400
+++ 2.6.9-rc2/arch/um/os-Linux/file.c	2004-09-14 13:30:33.000000000 -0400
@@ -187,7 +187,8 @@
 
 	if((fcntl(master, F_SETFL, flags | O_NONBLOCK | O_ASYNC) < 0) ||
 	   (fcntl(master, F_SETOWN, os_getpid()) < 0)){
-		printk("fcntl F_SETFL or F_SETOWN failed, errno = %d\n", errno);
+		printk("fcntl F_SETFL or F_SETOWN failed, errno = %d\n", 
+		       errno);
 		return(-errno);
 	}
 
Index: 2.6.9-rc2/arch/um/os-Linux/process.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/os-Linux/process.c	2004-09-14 13:30:22.000000000 -0400
+++ 2.6.9-rc2/arch/um/os-Linux/process.c	2004-09-14 13:30:33.000000000 -0400
@@ -42,9 +42,9 @@
 	}
 	os_close_file(fd);
 	pc = ARBITRARY_ADDR;
-	if(sscanf(buf, "%*d " COMM_SCANF " %*c %*d %*d %*d %*d %*d %*d %*d %*d "
+	if(sscanf(buf, "%*d " COMM_SCANF " %*c %*d %*d %*d %*d %*d %*d %*d "
 		  "%*d %*d %*d %*d %*d %*d %*d %*d %*d %*d %*d %*d %*d %*d "
-		  "%*d %*d %*d %*d %lu", &pc) != 1){
+		  "%*d %*d %*d %*d %*d %lu", &pc) != 1){
 		printk("os_process_pc - couldn't find pc in '%s'\n", buf);
 	}
 	return(pc);
Index: 2.6.9-rc2/arch/um/sys-i386/ptrace_user.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/sys-i386/ptrace_user.c	2004-09-14 13:30:22.000000000 -0400
+++ 2.6.9-rc2/arch/um/sys-i386/ptrace_user.c	2004-09-14 13:30:33.000000000 -0400
@@ -42,7 +42,8 @@
 		if(ptrace(PTRACE_POKEUSER, pid, &dummy->u_debugreg[i],
 			  regs[i]) < 0)
 			printk("write_debugregs - ptrace failed on "
-			       "register %d, errno = %d\n", errno);
+			       "register %d, value = 0x%x, errno = %d\n", i, 
+			       regs[i], errno);
 	}
 }
 
More recent patches modify files in tidy.

