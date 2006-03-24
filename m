Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWCXSNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWCXSNx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWCXSNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:13:39 -0500
Received: from [198.99.130.12] ([198.99.130.12]:42134 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751352AbWCXSNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:13:30 -0500
Message-Id: <200603241814.k2OIEfmq005520@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Subject: [PATCH 5/16] UML - Merge irq_user.c and irq.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Mar 2006 13:14:41 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The serial UML OS-abstraction layer patch (um/kernel dir).

This joins irq_user.c and irq.c files.

Signed-off-by: Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/Makefile	2006-03-23 18:40:30.000000000 -0500
+++ linux-2.6.16/arch/um/kernel/Makefile	2006-03-23 18:54:20.000000000 -0500
@@ -7,7 +7,7 @@ extra-y := vmlinux.lds
 clean-files :=
 
 obj-y = config.o exec_kern.o exitcode.o \
-	init_task.o irq.o irq_user.o ksyms.o mem.o physmem.o \
+	init_task.o irq.o ksyms.o mem.o physmem.o \
 	process_kern.o ptrace.o reboot.o resource.o sigio_user.o sigio_kern.o \
 	signal_kern.o smp.o syscall_kern.o sysrq.o \
 	time_kern.o tlb.o trap_kern.o uaccess.o um_arch.o umid.o
Index: linux-2.6.16/arch/um/kernel/irq.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/irq.c	2006-03-23 18:40:30.000000000 -0500
+++ linux-2.6.16/arch/um/kernel/irq.c	2006-03-23 18:55:15.000000000 -0500
@@ -31,6 +31,8 @@
 #include "irq_user.h"
 #include "irq_kern.h"
 #include "os.h"
+#include "sigio.h"
+#include "misc_constants.h"
 
 /*
  * Generic, controller-independent functions:
@@ -77,6 +79,298 @@ skip:
 	return 0;
 }
 
+struct irq_fd *active_fds = NULL;
+static struct irq_fd **last_irq_ptr = &active_fds;
+
+extern void free_irqs(void);
+
+void sigio_handler(int sig, union uml_pt_regs *regs)
+{
+	struct irq_fd *irq_fd;
+	int n;
+
+	if(smp_sigio_handler()) return;
+	while(1){
+		n = os_waiting_for_events(active_fds);
+		if (n <= 0) {
+			if(n == -EINTR) continue;
+			else break;
+		}
+
+		for(irq_fd = active_fds; irq_fd != NULL; irq_fd = irq_fd->next){
+			if(irq_fd->current_events != 0){
+				irq_fd->current_events = 0;
+				do_IRQ(irq_fd->irq, regs);
+			}
+		}
+	}
+
+	free_irqs();
+}
+
+static void maybe_sigio_broken(int fd, int type)
+{
+	if(os_isatty(fd)){
+		if((type == IRQ_WRITE) && !pty_output_sigio){
+			write_sigio_workaround();
+			add_sigio_fd(fd, 0);
+		}
+		else if((type == IRQ_READ) && !pty_close_sigio){
+			write_sigio_workaround();
+			add_sigio_fd(fd, 1);
+		}
+	}
+}
+
+
+int activate_fd(int irq, int fd, int type, void *dev_id)
+{
+	struct pollfd *tmp_pfd;
+	struct irq_fd *new_fd, *irq_fd;
+	unsigned long flags;
+	int pid, events, err, n;
+
+	pid = os_getpid();
+	err = os_set_fd_async(fd, pid);
+	if(err < 0)
+		goto out;
+
+	new_fd = um_kmalloc(sizeof(*new_fd));
+	err = -ENOMEM;
+	if(new_fd == NULL)
+		goto out;
+
+	if(type == IRQ_READ) events = UM_POLLIN | UM_POLLPRI;
+	else events = UM_POLLOUT;
+	*new_fd = ((struct irq_fd) { .next  		= NULL,
+				     .id 		= dev_id,
+				     .fd 		= fd,
+				     .type 		= type,
+				     .irq 		= irq,
+				     .pid  		= pid,
+				     .events 		= events,
+				     .current_events 	= 0 } );
+
+	/* Critical section - locked by a spinlock because this stuff can
+	 * be changed from interrupt handlers.  The stuff above is done
+	 * outside the lock because it allocates memory.
+	 */
+
+	/* Actually, it only looks like it can be called from interrupt
+	 * context.  The culprit is reactivate_fd, which calls
+	 * maybe_sigio_broken, which calls write_sigio_workaround,
+	 * which calls activate_fd.  However, write_sigio_workaround should
+	 * only be called once, at boot time.  That would make it clear that
+	 * this is called only from process context, and can be locked with
+	 * a semaphore.
+	 */
+	flags = irq_lock();
+	for(irq_fd = active_fds; irq_fd != NULL; irq_fd = irq_fd->next){
+		if((irq_fd->fd == fd) && (irq_fd->type == type)){
+			printk("Registering fd %d twice\n", fd);
+			printk("Irqs : %d, %d\n", irq_fd->irq, irq);
+			printk("Ids : 0x%p, 0x%p\n", irq_fd->id, dev_id);
+			goto out_unlock;
+		}
+	}
+
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
+			kfree(tmp_pfd);
+			tmp_pfd = NULL;
+		}
+
+		tmp_pfd = um_kmalloc(n);
+		if (tmp_pfd == NULL)
+			goto out_kfree;
+
+		flags = irq_lock();
+	}
+	/*-------------*/
+
+	*last_irq_ptr = new_fd;
+	last_irq_ptr = &new_fd->next;
+
+	irq_unlock(flags);
+
+	/* This calls activate_fd, so it has to be outside the critical
+	 * section.
+	 */
+	maybe_sigio_broken(fd, type);
+
+	return(0);
+
+ out_unlock:
+	irq_unlock(flags);
+ out_kfree:
+	kfree(new_fd);
+ out:
+	return(err);
+}
+
+static void free_irq_by_cb(int (*test)(struct irq_fd *, void *), void *arg)
+{
+	unsigned long flags;
+
+	flags = irq_lock();
+	os_free_irq_by_cb(test, arg, active_fds, &last_irq_ptr);
+	irq_unlock(flags);
+}
+
+struct irq_and_dev {
+	int irq;
+	void *dev;
+};
+
+static int same_irq_and_dev(struct irq_fd *irq, void *d)
+{
+	struct irq_and_dev *data = d;
+
+	return((irq->irq == data->irq) && (irq->id == data->dev));
+}
+
+void free_irq_by_irq_and_dev(unsigned int irq, void *dev)
+{
+	struct irq_and_dev data = ((struct irq_and_dev) { .irq  = irq,
+							  .dev  = dev });
+
+	free_irq_by_cb(same_irq_and_dev, &data);
+}
+
+static int same_fd(struct irq_fd *irq, void *fd)
+{
+	return(irq->fd == *((int *) fd));
+}
+
+void free_irq_by_fd(int fd)
+{
+	free_irq_by_cb(same_fd, &fd);
+}
+
+static struct irq_fd *find_irq_by_fd(int fd, int irqnum, int *index_out)
+{
+	struct irq_fd *irq;
+	int i = 0;
+	int fdi;
+
+	for(irq=active_fds; irq != NULL; irq = irq->next){
+		if((irq->fd == fd) && (irq->irq == irqnum)) break;
+		i++;
+	}
+	if(irq == NULL){
+		printk("find_irq_by_fd doesn't have descriptor %d\n", fd);
+		goto out;
+	}
+	fdi = os_get_pollfd(i);
+	if((fdi != -1) && (fdi != fd)){
+		printk("find_irq_by_fd - mismatch between active_fds and "
+		       "pollfds, fd %d vs %d, need %d\n", irq->fd,
+		       fdi, fd);
+		irq = NULL;
+		goto out;
+	}
+	*index_out = i;
+ out:
+	return(irq);
+}
+
+void reactivate_fd(int fd, int irqnum)
+{
+	struct irq_fd *irq;
+	unsigned long flags;
+	int i;
+
+	flags = irq_lock();
+	irq = find_irq_by_fd(fd, irqnum, &i);
+	if(irq == NULL){
+		irq_unlock(flags);
+		return;
+	}
+	os_set_pollfd(i, irq->fd);
+	irq_unlock(flags);
+
+	/* This calls activate_fd, so it has to be outside the critical
+	 * section.
+	 */
+	maybe_sigio_broken(fd, irq->type);
+}
+
+void deactivate_fd(int fd, int irqnum)
+{
+	struct irq_fd *irq;
+	unsigned long flags;
+	int i;
+
+	flags = irq_lock();
+	irq = find_irq_by_fd(fd, irqnum, &i);
+	if(irq == NULL)
+		goto out;
+	os_set_pollfd(i, -1);
+ out:
+	irq_unlock(flags);
+}
+
+int deactivate_all_fds(void)
+{
+	struct irq_fd *irq;
+	int err;
+
+	for(irq=active_fds;irq != NULL;irq = irq->next){
+		err = os_clear_fd_async(irq->fd);
+		if(err)
+			return(err);
+	}
+	/* If there is a signal already queued, after unblocking ignore it */
+	os_set_ioignore();
+
+	return(0);
+}
+
+void forward_interrupts(int pid)
+{
+	struct irq_fd *irq;
+	unsigned long flags;
+	int err;
+
+	flags = irq_lock();
+	for(irq=active_fds;irq != NULL;irq = irq->next){
+		err = os_set_owner(irq->fd, pid);
+		if(err < 0){
+			/* XXX Just remove the irq rather than
+			 * print out an infinite stream of these
+			 */
+			printk("Failed to forward %d to pid %d, err = %d\n",
+			       irq->fd, pid, -err);
+		}
+
+		irq->pid = pid;
+	}
+	irq_unlock(flags);
+}
+
 /*
  * do_IRQ handles all normal device IRQ's (the special
  * SMP cross-CPU interrupts have their own specific
Index: linux-2.6.16/arch/um/kernel/irq_user.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/irq_user.c	2006-03-23 18:51:20.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,324 +0,0 @@
-/*
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <stdlib.h>
-#include <unistd.h>
-#include <errno.h>
-#include <signal.h>
-#include <string.h>
-#include <sys/poll.h>
-#include <sys/types.h>
-#include <sys/time.h>
-#include "user_util.h"
-#include "kern_util.h"
-#include "user.h"
-#include "process.h"
-#include "sigio.h"
-#include "irq_user.h"
-#include "os.h"
-#include "misc_constants.h"
-
-struct irq_fd *active_fds = NULL;
-static struct irq_fd **last_irq_ptr = &active_fds;
-
-extern void free_irqs(void);
-
-void sigio_handler(int sig, union uml_pt_regs *regs)
-{
-	struct irq_fd *irq_fd;
-	int n;
-
-	if(smp_sigio_handler()) return;
-	while(1){
-		n = os_waiting_for_events(active_fds);
-		if (n <= 0) {
-			if(n == -EINTR) continue;
-			else break;
- 		}
-
-		for(irq_fd = active_fds; irq_fd != NULL; irq_fd = irq_fd->next){
-			if(irq_fd->current_events != 0){
-				irq_fd->current_events = 0;
-				do_IRQ(irq_fd->irq, regs);
-			}
-		}
-	}
-
-	free_irqs();
-}
-
-static void maybe_sigio_broken(int fd, int type)
-{
-	if(os_isatty(fd)){
-		if((type == IRQ_WRITE) && !pty_output_sigio){
-			write_sigio_workaround();
-			add_sigio_fd(fd, 0);
-		}
-		else if((type == IRQ_READ) && !pty_close_sigio){
-			write_sigio_workaround();
-			add_sigio_fd(fd, 1);			
-		}
-	}
-}
-
-
-int activate_fd(int irq, int fd, int type, void *dev_id)
-{
-	struct pollfd *tmp_pfd;
-	struct irq_fd *new_fd, *irq_fd;
-	unsigned long flags;
-	int pid, events, err, n;
-
-	pid = os_getpid();
-	err = os_set_fd_async(fd, pid);
-	if(err < 0)
-		goto out;
-
-	new_fd = um_kmalloc(sizeof(*new_fd));
-	err = -ENOMEM;
-	if(new_fd == NULL)
-		goto out;
-
-	if(type == IRQ_READ) events = UM_POLLIN | UM_POLLPRI;
-	else events = UM_POLLOUT;
-	*new_fd = ((struct irq_fd) { .next  		= NULL,
-				     .id 		= dev_id,
-				     .fd 		= fd,
-				     .type 		= type,
-				     .irq 		= irq,
-				     .pid  		= pid,
-				     .events 		= events,
-				     .current_events 	= 0 } );
-
-	/* Critical section - locked by a spinlock because this stuff can
-	 * be changed from interrupt handlers.  The stuff above is done
-	 * outside the lock because it allocates memory.
-	 */
-
-	/* Actually, it only looks like it can be called from interrupt
-	 * context.  The culprit is reactivate_fd, which calls
-	 * maybe_sigio_broken, which calls write_sigio_workaround,
-	 * which calls activate_fd.  However, write_sigio_workaround should
-	 * only be called once, at boot time.  That would make it clear that
-	 * this is called only from process context, and can be locked with
-	 * a semaphore.
-	 */
-	flags = irq_lock();
-	for(irq_fd = active_fds; irq_fd != NULL; irq_fd = irq_fd->next){
-		if((irq_fd->fd == fd) && (irq_fd->type == type)){
-			printk("Registering fd %d twice\n", fd);
-			printk("Irqs : %d, %d\n", irq_fd->irq, irq);
-			printk("Ids : 0x%x, 0x%x\n", irq_fd->id, dev_id);
-			goto out_unlock;
-		}
-	}
-
-	/*-------------*/
-	if(type == IRQ_WRITE)
-		fd = -1;
-
-	tmp_pfd = NULL;
-	n = 0;
-
-	while(1){
-		n = os_create_pollfd(fd, events, tmp_pfd, n);
-		if (n == 0)
-			break;
-
-		/* n > 0
-		 * It means we couldn't put new pollfd to current pollfds
-		 * and tmp_fds is NULL or too small for new pollfds array.
-		 * Needed size is equal to n as minimum.
-		 *
-		 * Here we have to drop the lock in order to call
-		 * kmalloc, which might sleep.
-		 * If something else came in and changed the pollfds array
-		 * so we will not be able to put new pollfd struct to pollfds
-		 * then we free the buffer tmp_fds and try again.
-		 */
-		irq_unlock(flags);
-		if (tmp_pfd != NULL) {
-			kfree(tmp_pfd);
-			tmp_pfd = NULL;
-		}
-
-		tmp_pfd = um_kmalloc(n);
-		if (tmp_pfd == NULL)
-			goto out_kfree;
-
-		flags = irq_lock();
-	}
-	/*-------------*/
-
-	*last_irq_ptr = new_fd;
-	last_irq_ptr = &new_fd->next;
-
-	irq_unlock(flags);
-
-	/* This calls activate_fd, so it has to be outside the critical
-	 * section.
-	 */
-	maybe_sigio_broken(fd, type);
-
-	return(0);
-
- out_unlock:
-	irq_unlock(flags);
- out_kfree:
-	kfree(new_fd);
- out:
-	return(err);
-}
-
-static void free_irq_by_cb(int (*test)(struct irq_fd *, void *), void *arg)
-{
-	unsigned long flags;
-
-	flags = irq_lock();
- 	os_free_irq_by_cb(test, arg, active_fds, &last_irq_ptr);
-	irq_unlock(flags);
-}
-
-struct irq_and_dev {
-	int irq;
-	void *dev;
-};
-
-static int same_irq_and_dev(struct irq_fd *irq, void *d)
-{
-	struct irq_and_dev *data = d;
-
-	return((irq->irq == data->irq) && (irq->id == data->dev));
-}
-
-void free_irq_by_irq_and_dev(unsigned int irq, void *dev)
-{
-	struct irq_and_dev data = ((struct irq_and_dev) { .irq  = irq,
-							  .dev  = dev });
-
-	free_irq_by_cb(same_irq_and_dev, &data);
-}
-
-static int same_fd(struct irq_fd *irq, void *fd)
-{
-	return(irq->fd == *((int *) fd));
-}
-
-void free_irq_by_fd(int fd)
-{
-	free_irq_by_cb(same_fd, &fd);
-}
-
-static struct irq_fd *find_irq_by_fd(int fd, int irqnum, int *index_out)
-{
-	struct irq_fd *irq;
-	int i = 0;
-	int fdi;
-
-	for(irq=active_fds; irq != NULL; irq = irq->next){
-		if((irq->fd == fd) && (irq->irq == irqnum)) break;
-		i++;
-	}
-	if(irq == NULL){
-		printk("find_irq_by_fd doesn't have descriptor %d\n", fd);
-		goto out;
-	}
-	fdi = os_get_pollfd(i);
-	if((fdi != -1) && (fdi != fd)){
-		printk("find_irq_by_fd - mismatch between active_fds and "
-		       "pollfds, fd %d vs %d, need %d\n", irq->fd,
-		       fdi, fd);
-		irq = NULL;
-		goto out;
-	}
-	*index_out = i;
- out:
-	return(irq);
-}
-
-void reactivate_fd(int fd, int irqnum)
-{
-	struct irq_fd *irq;
-	unsigned long flags;
-	int i;
-
-	flags = irq_lock();
-	irq = find_irq_by_fd(fd, irqnum, &i);
-	if(irq == NULL){
-		irq_unlock(flags);
-		return;
-	}
-	os_set_pollfd(i, irq->fd);
-	irq_unlock(flags);
-
-	/* This calls activate_fd, so it has to be outside the critical
-	 * section.
-	 */
-	maybe_sigio_broken(fd, irq->type);
-}
-
-void deactivate_fd(int fd, int irqnum)
-{
-	struct irq_fd *irq;
-	unsigned long flags;
-	int i;
-
-	flags = irq_lock();
-	irq = find_irq_by_fd(fd, irqnum, &i);
-	if(irq == NULL)
-		goto out;
-	os_set_pollfd(i, -1);
- out:
-	irq_unlock(flags);
-}
-
-int deactivate_all_fds(void)
-{
-	struct irq_fd *irq;
-	int err;
-
-	for(irq=active_fds;irq != NULL;irq = irq->next){
-		err = os_clear_fd_async(irq->fd);
-		if(err)
-			return(err);
-	}
-	/* If there is a signal already queued, after unblocking ignore it */
-	os_set_ioignore();
-
-	return(0);
-}
-
-void forward_interrupts(int pid)
-{
-	struct irq_fd *irq;
-	unsigned long flags;
-	int err;
-
-	flags = irq_lock();
-	for(irq=active_fds;irq != NULL;irq = irq->next){
-		err = os_set_owner(irq->fd, pid);
-		if(err < 0){
-			/* XXX Just remove the irq rather than
-			 * print out an infinite stream of these
-			 */
-			printk("Failed to forward %d to pid %d, err = %d\n",
-			       irq->fd, pid, -err);
-		}
-
-		irq->pid = pid;
-	}
-	irq_unlock(flags);
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

