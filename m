Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWCXSNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWCXSNy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWCXSNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:13:37 -0500
Received: from [198.99.130.12] ([198.99.130.12]:40854 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750821AbWCXSNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:13:30 -0500
Message-Id: <200603241814.k2OIEcUH005515@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Subject: [PATCH 4/16] UML - Move libc-dependent irq code to os-Linux
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Mar 2006 13:14:38 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The serial UML OS-abstraction layer patch (um/kernel dir).

This moves all systemcalls from irq_user.c file under os-Linux dir

Signed-off-by: Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/include/irq_user.h
===================================================================
--- linux-2.6.16.orig/arch/um/include/irq_user.h	2006-03-23 18:40:30.000000000 -0500
+++ linux-2.6.16/arch/um/include/irq_user.h	2006-03-23 18:52:10.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2001, 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -6,6 +6,17 @@
 #ifndef __IRQ_USER_H__
 #define __IRQ_USER_H__
 
+struct irq_fd {
+	struct irq_fd *next;
+	void *id;
+	int fd;
+	int type;
+	int irq;
+	int pid;
+	int events;
+	int current_events;
+};
+
 enum { IRQ_READ, IRQ_WRITE };
 
 extern void sigio_handler(int sig, union uml_pt_regs *regs);
@@ -16,8 +27,6 @@ extern void reactivate_fd(int fd, int ir
 extern void deactivate_fd(int fd, int irqnum);
 extern int deactivate_all_fds(void);
 extern void forward_interrupts(int pid);
-extern void init_irq_signals(int on_sigstack);
-extern void forward_ipi(int fd, int pid);
 extern int activate_ipi(int fd, int pid);
 extern unsigned long irq_lock(void);
 extern void irq_unlock(unsigned long flags);
Index: linux-2.6.16/arch/um/include/misc_constants.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16/arch/um/include/misc_constants.h	2006-03-23 18:51:20.000000000 -0500
@@ -0,0 +1,6 @@
+#ifndef __MISC_CONSTANT_H_
+#define __MISC_CONSTANT_H_
+
+#include <user_constants.h>
+
+#endif
Index: linux-2.6.16/arch/um/include/os.h
===================================================================
--- linux-2.6.16.orig/arch/um/include/os.h	2006-03-23 18:40:30.000000000 -0500
+++ linux-2.6.16/arch/um/include/os.h	2006-03-23 18:51:20.000000000 -0500
@@ -12,6 +12,7 @@
 #include "sysdep/ptrace.h"
 #include "kern_util.h"
 #include "skas/mm_id.h"
+#include "irq_user.h"
 
 #define OS_TYPE_FILE 1 
 #define OS_TYPE_DIR 2 
@@ -198,6 +199,8 @@ extern void os_flush_stdout(void);
 /* tt.c
  * for tt mode only (will be deleted in future...)
  */
+extern void forward_ipi(int fd, int pid);
+extern void kill_child_dead(int pid);
 extern void stop(void);
 extern int wait_for_stop(int pid, int sig, int cont_type, void *relay);
 extern int protect_memory(unsigned long addr, unsigned long len,
@@ -294,4 +297,17 @@ extern void initial_thread_cb_skas(void 
 extern void halt_skas(void);
 extern void reboot_skas(void);
 
+/* irq.c */
+extern int os_waiting_for_events(struct irq_fd *active_fds);
+extern int os_isatty(int fd);
+extern int os_create_pollfd(int fd, int events, void *tmp_pfd, int size_tmpfds);
+extern void os_free_irq_by_cb(int (*test)(struct irq_fd *, void *), void *arg,
+		struct irq_fd *active_fds, struct irq_fd ***last_irq_ptr2);
+extern void os_free_irq_later(struct irq_fd *active_fds,
+		int irq, void *dev_id);
+extern int os_get_pollfd(int i);
+extern void os_set_pollfd(int i, int fd);
+extern void os_set_ioignore(void);
+extern void init_irq_signals(int on_sigstack);
+
 #endif
Index: linux-2.6.16/arch/um/kernel/irq_user.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/irq_user.c	2006-03-23 18:40:30.000000000 -0500
+++ linux-2.6.16/arch/um/kernel/irq_user.c	2006-03-23 18:51:20.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -18,53 +18,25 @@
 #include "sigio.h"
 #include "irq_user.h"
 #include "os.h"
+#include "misc_constants.h"
 
-struct irq_fd {
-	struct irq_fd *next;
-	void *id;
-	int fd;
-	int type;
-	int irq;
-	int pid;
-	int events;
-	int current_events;
-};
-
-static struct irq_fd *active_fds = NULL;
+struct irq_fd *active_fds = NULL;
 static struct irq_fd **last_irq_ptr = &active_fds;
 
-static struct pollfd *pollfds = NULL;
-static int pollfds_num = 0;
-static int pollfds_size = 0;
-
-extern int io_count, intr_count;
-
 extern void free_irqs(void);
 
 void sigio_handler(int sig, union uml_pt_regs *regs)
 {
 	struct irq_fd *irq_fd;
-	int i, n;
+	int n;
 
 	if(smp_sigio_handler()) return;
 	while(1){
-		n = poll(pollfds, pollfds_num, 0);
-		if(n < 0){
-			if(errno == EINTR) continue;
-			printk("sigio_handler : poll returned %d, "
-			       "errno = %d\n", n, errno);
-			break;
-		}
-		if(n == 0) break;
-
-		irq_fd = active_fds;
-		for(i = 0; i < pollfds_num; i++){
-			if(pollfds[i].revents != 0){
-				irq_fd->current_events = pollfds[i].revents;
-				pollfds[i].fd = -1;
-			}
-			irq_fd = irq_fd->next;
-		}
+		n = os_waiting_for_events(active_fds);
+		if (n <= 0) {
+			if(n == -EINTR) continue;
+			else break;
+ 		}
 
 		for(irq_fd = active_fds; irq_fd != NULL; irq_fd = irq_fd->next){
 			if(irq_fd->current_events != 0){
@@ -77,14 +49,9 @@ void sigio_handler(int sig, union uml_pt
 	free_irqs();
 }
 
-int activate_ipi(int fd, int pid)
-{
-	return(os_set_fd_async(fd, pid));
-}
-
 static void maybe_sigio_broken(int fd, int type)
 {
-	if(isatty(fd)){
+	if(os_isatty(fd)){
 		if((type == IRQ_WRITE) && !pty_output_sigio){
 			write_sigio_workaround();
 			add_sigio_fd(fd, 0);
@@ -96,12 +63,13 @@ static void maybe_sigio_broken(int fd, i
 	}
 }
 
+
 int activate_fd(int irq, int fd, int type, void *dev_id)
 {
 	struct pollfd *tmp_pfd;
 	struct irq_fd *new_fd, *irq_fd;
 	unsigned long flags;
-	int pid, events, err, n, size;
+	int pid, events, err, n;
 
 	pid = os_getpid();
 	err = os_set_fd_async(fd, pid);
@@ -113,8 +81,8 @@ int activate_fd(int irq, int fd, int typ
 	if(new_fd == NULL)
 		goto out;
 
-	if(type == IRQ_READ) events = POLLIN | POLLPRI;
-	else events = POLLOUT;
+	if(type == IRQ_READ) events = UM_POLLIN | UM_POLLPRI;
+	else events = UM_POLLOUT;
 	*new_fd = ((struct irq_fd) { .next  		= NULL,
 				     .id 		= dev_id,
 				     .fd 		= fd,
@@ -125,12 +93,12 @@ int activate_fd(int irq, int fd, int typ
 				     .current_events 	= 0 } );
 
 	/* Critical section - locked by a spinlock because this stuff can
-	 * be changed from interrupt handlers.  The stuff above is done 
+	 * be changed from interrupt handlers.  The stuff above is done
 	 * outside the lock because it allocates memory.
 	 */
 
 	/* Actually, it only looks like it can be called from interrupt
-	 * context.  The culprit is reactivate_fd, which calls 
+	 * context.  The culprit is reactivate_fd, which calls
 	 * maybe_sigio_broken, which calls write_sigio_workaround,
 	 * which calls activate_fd.  However, write_sigio_workaround should
 	 * only be called once, at boot time.  That would make it clear that
@@ -147,40 +115,42 @@ int activate_fd(int irq, int fd, int typ
 		}
 	}
 
-	n = pollfds_num;
-	if(n == pollfds_size){
-		while(1){
-			/* Here we have to drop the lock in order to call 
-			 * kmalloc, which might sleep.  If something else
-			 * came in and changed the pollfds array, we free
-			 * the buffer and try again.
-			 */
-			irq_unlock(flags);
-			size = (pollfds_num + 1) * sizeof(pollfds[0]);
-			tmp_pfd = um_kmalloc(size);
-			flags = irq_lock();
-			if(tmp_pfd == NULL)
-				goto out_unlock;
-			if(n == pollfds_size)
-				break;
+	/*-------------*/
+	if(type == IRQ_WRITE)
+		fd = -1;
+
+	tmp_pfd = NULL;
+	n = 0;
+
+	while(1){
+		n = os_create_pollfd(fd, events, tmp_pfd, n);
+		if (n == 0)
+			break;
+
+		/* n > 0
+		 * It means we couldn't put new pollfd to current pollfds
+		 * and tmp_fds is NULL or too small for new pollfds array.
+		 * Needed size is equal to n as minimum.
+		 *
+		 * Here we have to drop the lock in order to call
+		 * kmalloc, which might sleep.
+		 * If something else came in and changed the pollfds array
+		 * so we will not be able to put new pollfd struct to pollfds
+		 * then we free the buffer tmp_fds and try again.
+		 */
+		irq_unlock(flags);
+		if (tmp_pfd != NULL) {
 			kfree(tmp_pfd);
+			tmp_pfd = NULL;
 		}
-		if(pollfds != NULL){
-			memcpy(tmp_pfd, pollfds,
-			       sizeof(pollfds[0]) * pollfds_size);
-			kfree(pollfds);
-		}
-		pollfds = tmp_pfd;
-		pollfds_size++;
-	}
 
-	if(type == IRQ_WRITE) 
-		fd = -1;
+		tmp_pfd = um_kmalloc(n);
+		if (tmp_pfd == NULL)
+			goto out_kfree;
 
-	pollfds[pollfds_num] = ((struct pollfd) { .fd 	= fd,
-						  .events 	= events,
-						  .revents 	= 0 });
-	pollfds_num++;
+		flags = irq_lock();
+	}
+	/*-------------*/
 
 	*last_irq_ptr = new_fd;
 	last_irq_ptr = &new_fd->next;
@@ -196,6 +166,7 @@ int activate_fd(int irq, int fd, int typ
 
  out_unlock:
 	irq_unlock(flags);
+ out_kfree:
 	kfree(new_fd);
  out:
 	return(err);
@@ -203,43 +174,10 @@ int activate_fd(int irq, int fd, int typ
 
 static void free_irq_by_cb(int (*test)(struct irq_fd *, void *), void *arg)
 {
-	struct irq_fd **prev;
 	unsigned long flags;
-	int i = 0;
 
 	flags = irq_lock();
-	prev = &active_fds;
-	while(*prev != NULL){
-		if((*test)(*prev, arg)){
-			struct irq_fd *old_fd = *prev;
-			if((pollfds[i].fd != -1) && 
-			   (pollfds[i].fd != (*prev)->fd)){
-				printk("free_irq_by_cb - mismatch between "
-				       "active_fds and pollfds, fd %d vs %d\n",
-				       (*prev)->fd, pollfds[i].fd);
-				goto out;
-			}
-
-			pollfds_num--;
-
-			/* This moves the *whole* array after pollfds[i] (though
-			 * it doesn't spot as such)! */
-
-			memmove(&pollfds[i], &pollfds[i + 1],
-			       (pollfds_num - i) * sizeof(pollfds[0]));
-
-			if(last_irq_ptr == &old_fd->next) 
-				last_irq_ptr = prev;
-			*prev = (*prev)->next;
-			if(old_fd->type == IRQ_WRITE) 
-				ignore_sigio_fd(old_fd->fd);
-			kfree(old_fd);
-			continue;
-		}
-		prev = &(*prev)->next;
-		i++;
-	}
- out:
+ 	os_free_irq_by_cb(test, arg, active_fds, &last_irq_ptr);
 	irq_unlock(flags);
 }
 
@@ -277,6 +215,7 @@ static struct irq_fd *find_irq_by_fd(int
 {
 	struct irq_fd *irq;
 	int i = 0;
+	int fdi;
 
 	for(irq=active_fds; irq != NULL; irq = irq->next){
 		if((irq->fd == fd) && (irq->irq == irqnum)) break;
@@ -286,10 +225,11 @@ static struct irq_fd *find_irq_by_fd(int
 		printk("find_irq_by_fd doesn't have descriptor %d\n", fd);
 		goto out;
 	}
-	if((pollfds[i].fd != -1) && (pollfds[i].fd != fd)){
+	fdi = os_get_pollfd(i);
+	if((fdi != -1) && (fdi != fd)){
 		printk("find_irq_by_fd - mismatch between active_fds and "
-		       "pollfds, fd %d vs %d, need %d\n", irq->fd, 
-		       pollfds[i].fd, fd);
+		       "pollfds, fd %d vs %d, need %d\n", irq->fd,
+		       fdi, fd);
 		irq = NULL;
 		goto out;
 	}
@@ -310,9 +250,7 @@ void reactivate_fd(int fd, int irqnum)
 		irq_unlock(flags);
 		return;
 	}
-
-	pollfds[i].fd = irq->fd;
-
+	os_set_pollfd(i, irq->fd);
 	irq_unlock(flags);
 
 	/* This calls activate_fd, so it has to be outside the critical
@@ -331,7 +269,7 @@ void deactivate_fd(int fd, int irqnum)
 	irq = find_irq_by_fd(fd, irqnum, &i);
 	if(irq == NULL)
 		goto out;
-	pollfds[i].fd = -1;
+	os_set_pollfd(i, -1);
  out:
 	irq_unlock(flags);
 }
@@ -347,21 +285,11 @@ int deactivate_all_fds(void)
 			return(err);
 	}
 	/* If there is a signal already queued, after unblocking ignore it */
-	set_handler(SIGIO, SIG_IGN, 0, -1);
+	os_set_ioignore();
 
 	return(0);
 }
 
-void forward_ipi(int fd, int pid)
-{
-	int err;
-
-	err = os_set_owner(fd, pid);
-	if(err < 0)
-		printk("forward_ipi: set_owner failed, fd = %d, me = %d, "
-		       "target = %d, err = %d\n", fd, os_getpid(), pid, -err);
-}
-
 void forward_interrupts(int pid)
 {
 	struct irq_fd *irq;
@@ -384,22 +312,6 @@ void forward_interrupts(int pid)
 	irq_unlock(flags);
 }
 
-void init_irq_signals(int on_sigstack)
-{
-	__sighandler_t h;
-	int flags;
-
-	flags = on_sigstack ? SA_ONSTACK : 0;
-	if(timer_irq_inited) h = (__sighandler_t) alarm_handler;
-	else h = boot_timer_handler;
-
-	set_handler(SIGVTALRM, h, flags | SA_RESTART, 
-		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, -1);
-	set_handler(SIGIO, (__sighandler_t) sig_handler, flags | SA_RESTART,
-		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
-	signal(SIGWINCH, SIG_IGN);
-}
-
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: linux-2.6.16/arch/um/kernel/smp.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/smp.c	2006-03-23 18:40:30.000000000 -0500
+++ linux-2.6.16/arch/um/kernel/smp.c	2006-03-23 18:51:20.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2000 - 2003 Jeff Dike (jdike@addtoit.com)
  * Licensed under the GPL
  */
@@ -77,9 +77,9 @@ static int idle_proc(void *cpup)
 	if(err < 0)
 		panic("CPU#%d failed to create IPI pipe, err = %d", cpu, -err);
 
-	activate_ipi(cpu_data[cpu].ipi_pipe[0], 
+	os_set_fd_async(cpu_data[cpu].ipi_pipe[0],
 		     current->thread.mode.tt.extern_pid);
- 
+
 	wmb();
 	if (cpu_test_and_set(cpu, cpu_callin_map)) {
 		printk("huh, CPU#%d already present??\n", cpu);
@@ -106,7 +106,7 @@ static struct task_struct *idle_thread(i
 		panic("copy_process failed in idle_thread, error = %ld",
 		      PTR_ERR(new_task));
 
-	cpu_tasks[cpu] = ((struct cpu_task) 
+	cpu_tasks[cpu] = ((struct cpu_task)
 		          { .pid = 	new_task->thread.mode.tt.extern_pid,
 			    .task = 	new_task } );
 	idle_threads[cpu] = new_task;
@@ -134,12 +134,12 @@ void smp_prepare_cpus(unsigned int maxcp
 	if(err < 0)
 		panic("CPU#0 failed to create IPI pipe, errno = %d", -err);
 
-	activate_ipi(cpu_data[me].ipi_pipe[0],
+	os_set_fd_async(cpu_data[me].ipi_pipe[0],
 		     current->thread.mode.tt.extern_pid);
 
 	for(cpu = 1; cpu < ncpus; cpu++){
 		printk("Booting processor %d...\n", cpu);
-		
+
 		idle = idle_thread(cpu);
 
 		init_idle(idle, cpu);
@@ -223,7 +223,7 @@ void smp_call_function_slave(int cpu)
 	atomic_inc(&scf_finished);
 }
 
-int smp_call_function(void (*_func)(void *info), void *_info, int nonatomic, 
+int smp_call_function(void (*_func)(void *info), void *_info, int nonatomic,
 		      int wait)
 {
 	int cpus = num_online_cpus() - 1;
Index: linux-2.6.16/arch/um/os-Linux/Makefile
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/Makefile	2006-03-23 18:40:30.000000000 -0500
+++ linux-2.6.16/arch/um/os-Linux/Makefile	2006-03-23 18:51:20.000000000 -0500
@@ -3,14 +3,14 @@
 # Licensed under the GPL
 #
 
-obj-y = aio.o elf_aux.o file.o helper.o main.o mem.o process.o signal.o \
+obj-y = aio.o elf_aux.o file.o helper.o irq.o main.o mem.o process.o signal.o \
 	start_up.o time.o trap.o tt.o tty.o uaccess.o umid.o user_syms.o \
 	util.o drivers/ sys-$(SUBARCH)/
 
 obj-$(CONFIG_MODE_SKAS) += skas/
 
-USER_OBJS := aio.o elf_aux.o file.o helper.o main.o mem.o process.o signal.o \
-	start_up.o time.o trap.o tt.o tty.o uaccess.o umid.o util.o
+USER_OBJS := aio.o elf_aux.o file.o helper.o irq.o main.o mem.o process.o \
+	signal.o start_up.o time.o trap.o tt.o tty.o uaccess.o umid.o util.o
 
 elf_aux.o: $(ARCH_DIR)/kernel-offsets.h
 CFLAGS_elf_aux.o += -I$(objtree)/arch/um
Index: linux-2.6.16/arch/um/os-Linux/irq.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16/arch/um/os-Linux/irq.c	2006-03-23 18:54:00.000000000 -0500
@@ -0,0 +1,162 @@
+/*
+ * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <signal.h>
+#include <string.h>
+#include <sys/poll.h>
+#include <sys/types.h>
+#include <sys/time.h>
+#include "user_util.h"
+#include "kern_util.h"
+#include "user.h"
+#include "process.h"
+#include "sigio.h"
+#include "irq_user.h"
+#include "os.h"
+
+static struct pollfd *pollfds = NULL;
+static int pollfds_num = 0;
+static int pollfds_size = 0;
+
+int os_waiting_for_events(struct irq_fd *active_fds)
+{
+	struct irq_fd *irq_fd;
+	int i, n, err;
+
+	n = poll(pollfds, pollfds_num, 0);
+	if(n < 0){
+		err = -errno;
+		if(errno != EINTR)
+			printk("sigio_handler: os_waiting_for_events:"
+			       " poll returned %d, errno = %d\n", n, errno);
+		return err;
+	}
+
+	if(n == 0)
+		return 0;
+
+	irq_fd = active_fds;
+
+	for(i = 0; i < pollfds_num; i++){
+		if(pollfds[i].revents != 0){
+			irq_fd->current_events = pollfds[i].revents;
+			pollfds[i].fd = -1;
+		}
+		irq_fd = irq_fd->next;
+	}
+	return n;
+}
+
+int os_isatty(int fd)
+{
+	return(isatty(fd));
+}
+
+int os_create_pollfd(int fd, int events, void *tmp_pfd, int size_tmpfds)
+{
+	if (pollfds_num == pollfds_size) {
+		if (size_tmpfds <= pollfds_size * sizeof(pollfds[0])) {
+			/* return min size needed for new pollfds area */
+			return((pollfds_size + 1) * sizeof(pollfds[0]));
+		}
+
+		if(pollfds != NULL){
+			memcpy(tmp_pfd, pollfds,
+			       sizeof(pollfds[0]) * pollfds_size);
+			/* remove old pollfds */
+			kfree(pollfds);
+		}
+		pollfds = tmp_pfd;
+		pollfds_size++;
+	} else {
+		/* remove not used tmp_pfd */
+		if (tmp_pfd != NULL)
+			kfree(tmp_pfd);
+	}
+
+	pollfds[pollfds_num] = ((struct pollfd) { .fd 	= fd,
+						  .events 	= events,
+						  .revents 	= 0 });
+	pollfds_num++;
+
+	return(0);
+}
+
+void os_free_irq_by_cb(int (*test)(struct irq_fd *, void *), void *arg,
+		struct irq_fd *active_fds, struct irq_fd ***last_irq_ptr2)
+{
+	struct irq_fd **prev;
+	int i = 0;
+
+	prev = &active_fds;
+	while(*prev != NULL){
+		if((*test)(*prev, arg)){
+			struct irq_fd *old_fd = *prev;
+			if((pollfds[i].fd != -1) &&
+			   (pollfds[i].fd != (*prev)->fd)){
+				printk("os_free_irq_by_cb - mismatch between "
+				       "active_fds and pollfds, fd %d vs %d\n",
+				       (*prev)->fd, pollfds[i].fd);
+				goto out;
+			}
+
+			pollfds_num--;
+
+			/* This moves the *whole* array after pollfds[i]
+			 * (though it doesn't spot as such)!
+			 */
+
+			memmove(&pollfds[i], &pollfds[i + 1],
+			       (pollfds_num - i) * sizeof(pollfds[0]));
+			if(*last_irq_ptr2 == &old_fd->next)
+				*last_irq_ptr2 = prev;
+
+			*prev = (*prev)->next;
+			if(old_fd->type == IRQ_WRITE)
+				ignore_sigio_fd(old_fd->fd);
+			kfree(old_fd);
+			continue;
+		}
+		prev = &(*prev)->next;
+		i++;
+	}
+ out:
+	return;
+}
+
+
+int os_get_pollfd(int i)
+{
+	return(pollfds[i].fd);
+}
+
+void os_set_pollfd(int i, int fd)
+{
+	pollfds[i].fd = fd;
+}
+
+void os_set_ioignore(void)
+{
+	set_handler(SIGIO, SIG_IGN, 0, -1);
+}
+
+void init_irq_signals(int on_sigstack)
+{
+	__sighandler_t h;
+	int flags;
+
+	flags = on_sigstack ? SA_ONSTACK : 0;
+	if(timer_irq_inited) h = (__sighandler_t) alarm_handler;
+	else h = boot_timer_handler;
+
+	set_handler(SIGVTALRM, h, flags | SA_RESTART,
+		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, -1);
+	set_handler(SIGIO, (__sighandler_t) sig_handler, flags | SA_RESTART,
+		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
+	signal(SIGWINCH, SIG_IGN);
+}
Index: linux-2.6.16/arch/um/os-Linux/tt.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/tt.c	2006-03-23 18:40:30.000000000 -0500
+++ linux-2.6.16/arch/um/os-Linux/tt.c	2006-03-23 18:51:20.000000000 -0500
@@ -110,6 +110,16 @@ int wait_for_stop(int pid, int sig, int 
 	}
 }
 
+void forward_ipi(int fd, int pid)
+{
+	int err;
+
+	err = os_set_owner(fd, pid);
+	if(err < 0)
+		printk("forward_ipi: set_owner failed, fd = %d, me = %d, "
+		       "target = %d, err = %d\n", fd, os_getpid(), pid, -err);
+}
+
 /*
  *-------------------------
  * only for tt mode (will be deleted in future...)
Index: linux-2.6.16/arch/um/sys-i386/user-offsets.c
===================================================================
--- linux-2.6.16.orig/arch/um/sys-i386/user-offsets.c	2006-03-23 18:40:30.000000000 -0500
+++ linux-2.6.16/arch/um/sys-i386/user-offsets.c	2006-03-23 18:53:12.000000000 -0500
@@ -3,12 +3,13 @@
 #include <asm/ptrace.h>
 #include <asm/user.h>
 #include <linux/stddef.h>
+#include <sys/poll.h>
 
 #define DEFINE(sym, val) \
-        asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
 
 #define DEFINE_LONGS(sym, val) \
-        asm volatile("\n->" #sym " %0 " #val : : "i" (val/sizeof(unsigned long)))
+	asm volatile("\n->" #sym " %0 " #val : : "i" (val/sizeof(unsigned long)))
 
 #define OFFSET(sym, str, mem) \
 	DEFINE(sym, offsetof(struct str, mem));
@@ -67,4 +68,9 @@ void foo(void)
 	DEFINE(HOST_ES, ES);
 	DEFINE(HOST_GS, GS);
 	DEFINE(UM_FRAME_SIZE, sizeof(struct user_regs_struct));
+
+	/* XXX Duplicated between i386 and x86_64 */
+	DEFINE(UM_POLLIN, POLLIN);
+	DEFINE(UM_POLLPRI, POLLPRI);
+	DEFINE(UM_POLLOUT, POLLOUT);
 }
Index: linux-2.6.16/arch/um/sys-x86_64/user-offsets.c
===================================================================
--- linux-2.6.16.orig/arch/um/sys-x86_64/user-offsets.c	2006-03-23 18:40:30.000000000 -0500
+++ linux-2.6.16/arch/um/sys-x86_64/user-offsets.c	2006-03-23 18:51:20.000000000 -0500
@@ -1,6 +1,7 @@
 #include <stdio.h>
 #include <stddef.h>
 #include <signal.h>
+#include <sys/poll.h>
 #define __FRAME_OFFSETS
 #include <asm/ptrace.h>
 #include <asm/types.h>
@@ -88,4 +89,9 @@ void foo(void)
 	DEFINE_LONGS(HOST_IP, RIP);
 	DEFINE_LONGS(HOST_SP, RSP);
 	DEFINE(UM_FRAME_SIZE, sizeof(struct user_regs_struct));
+
+	/* XXX Duplicated between i386 and x86_64 */
+	DEFINE(UM_POLLIN, POLLIN);
+	DEFINE(UM_POLLPRI, POLLPRI);
+	DEFINE(UM_POLLOUT, POLLOUT);
 }

