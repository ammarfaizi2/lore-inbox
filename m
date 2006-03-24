Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWCXSSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWCXSSl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWCXSSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:18:05 -0500
Received: from [198.99.130.12] ([198.99.130.12]:43926 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751144AbWCXSNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:13:35 -0500
Message-Id: <200603241814.k2OIEjng005530@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Subject: [PATCH 7/16] UML - Move sigio_user.c to os-Linux/sigio.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Mar 2006 13:14:45 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The serial UML OS-abstraction layer patch (um/kernel dir).

This moves sigio_user.c to os-Linux dir

Signed-off-by: Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/include/os.h
===================================================================
--- linux-2.6.16.orig/arch/um/include/os.h	2006-03-23 17:23:54.000000000 -0500
+++ linux-2.6.16/arch/um/include/os.h	2006-03-23 17:26:25.000000000 -0500
@@ -311,4 +311,9 @@ extern void os_set_pollfd(int i, int fd)
 extern void os_set_ioignore(void);
 extern void init_irq_signals(int on_sigstack);
 
+/* sigio.c */
+extern void write_sigio_workaround(void);
+extern int add_sigio_fd(int fd, int read);
+extern int ignore_sigio_fd(int fd);
+
 #endif
Index: linux-2.6.16/arch/um/include/sigio.h
===================================================================
--- linux-2.6.16.orig/arch/um/include/sigio.h	2006-03-23 17:23:54.000000000 -0500
+++ linux-2.6.16/arch/um/include/sigio.h	2006-03-23 17:26:25.000000000 -0500
@@ -8,8 +8,6 @@
 
 extern int write_sigio_irq(int fd);
 extern int register_sigio_fd(int fd);
-extern int add_sigio_fd(int fd, int read);
-extern int ignore_sigio_fd(int fd);
 extern void sigio_lock(void);
 extern void sigio_unlock(void);
 
Index: linux-2.6.16/arch/um/include/user_util.h
===================================================================
--- linux-2.6.16.orig/arch/um/include/user_util.h	2006-03-23 17:15:05.000000000 -0500
+++ linux-2.6.16/arch/um/include/user_util.h	2006-03-23 17:26:25.000000000 -0500
@@ -58,7 +58,6 @@ extern int attach(int pid);
 extern void kill_child_dead(int pid);
 extern int cont(int pid);
 extern void check_sigio(void);
-extern void write_sigio_workaround(void);
 extern void arch_check_bugs(void);
 extern int cpu_feature(char *what, char *buf, int len);
 extern int arch_handle_signal(int sig, union uml_pt_regs *regs);
Index: linux-2.6.16/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/Makefile	2006-03-23 17:15:05.000000000 -0500
+++ linux-2.6.16/arch/um/kernel/Makefile	2006-03-23 17:26:25.000000000 -0500
@@ -8,7 +8,7 @@ clean-files :=
 
 obj-y = config.o exec_kern.o exitcode.o \
 	init_task.o irq.o ksyms.o mem.o physmem.o \
-	process_kern.o ptrace.o reboot.o resource.o sigio_user.o sigio_kern.o \
+	process_kern.o ptrace.o reboot.o resource.o sigio_kern.o \
 	signal_kern.o smp.o syscall_kern.o sysrq.o \
 	time_kern.o tlb.o trap_kern.o uaccess.o um_arch.o umid.o
 
Index: linux-2.6.16/arch/um/os-Linux/Makefile
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/Makefile	2006-03-23 17:15:05.000000000 -0500
+++ linux-2.6.16/arch/um/os-Linux/Makefile	2006-03-23 17:26:25.000000000 -0500
@@ -3,14 +3,15 @@
 # Licensed under the GPL
 #
 
-obj-y = aio.o elf_aux.o file.o helper.o irq.o main.o mem.o process.o signal.o \
-	start_up.o time.o trap.o tt.o tty.o uaccess.o umid.o user_syms.o \
-	util.o drivers/ sys-$(SUBARCH)/
+obj-y = aio.o elf_aux.o file.o helper.o irq.o main.o mem.o process.o sigio.o \
+	signal.o start_up.o time.o trap.o tt.o tty.o uaccess.o umid.o \
+	user_syms.o util.o drivers/ sys-$(SUBARCH)/
 
 obj-$(CONFIG_MODE_SKAS) += skas/
 
 USER_OBJS := aio.o elf_aux.o file.o helper.o irq.o main.o mem.o process.o \
-	signal.o start_up.o time.o trap.o tt.o tty.o uaccess.o umid.o util.o
+	sigio.o signal.o start_up.o time.o trap.o tt.o tty.o uaccess.o umid.o \
+	util.o
 
 elf_aux.o: $(ARCH_DIR)/kernel-offsets.h
 CFLAGS_elf_aux.o += -I$(objtree)/arch/um
Index: linux-2.6.16/arch/um/os-Linux/sigio.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16/arch/um/os-Linux/sigio.c	2006-03-23 17:30:27.000000000 -0500
@@ -0,0 +1,324 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include <unistd.h>
+#include <stdlib.h>
+#include <termios.h>
+#include <pty.h>
+#include <signal.h>
+#include <errno.h>
+#include <string.h>
+#include <sched.h>
+#include <sys/socket.h>
+#include <sys/poll.h>
+#include "init.h"
+#include "user.h"
+#include "kern_util.h"
+#include "user_util.h"
+#include "sigio.h"
+#include "os.h"
+
+/* Protected by sigio_lock(), also used by sigio_cleanup, which is an
+ * exitcall.
+ */
+static int write_sigio_pid = -1;
+
+/* These arrays are initialized before the sigio thread is started, and
+ * the descriptors closed after it is killed.  So, it can't see them change.
+ * On the UML side, they are changed under the sigio_lock.
+ */
+static int write_sigio_fds[2] = { -1, -1 };
+static int sigio_private[2] = { -1, -1 };
+
+struct pollfds {
+	struct pollfd *poll;
+	int size;
+	int used;
+};
+
+/* Protected by sigio_lock().  Used by the sigio thread, but the UML thread
+ * synchronizes with it.
+ */
+struct pollfds current_poll = {
+	.poll  		= NULL,
+	.size 		= 0,
+	.used 		= 0
+};
+
+struct pollfds next_poll = {
+	.poll  		= NULL,
+	.size 		= 0,
+	.used 		= 0
+};
+
+static int write_sigio_thread(void *unused)
+{
+	struct pollfds *fds, tmp;
+	struct pollfd *p;
+	int i, n, respond_fd;
+	char c;
+
+        signal(SIGWINCH, SIG_IGN);
+	fds = &current_poll;
+	while(1){
+		n = poll(fds->poll, fds->used, -1);
+		if(n < 0){
+			if(errno == EINTR) continue;
+			printk("write_sigio_thread : poll returned %d, "
+			       "errno = %d\n", n, errno);
+		}
+		for(i = 0; i < fds->used; i++){
+			p = &fds->poll[i];
+			if(p->revents == 0) continue;
+			if(p->fd == sigio_private[1]){
+				n = os_read_file(sigio_private[1], &c, sizeof(c));
+				if(n != sizeof(c))
+					printk("write_sigio_thread : "
+					       "read failed, err = %d\n", -n);
+				tmp = current_poll;
+				current_poll = next_poll;
+				next_poll = tmp;
+				respond_fd = sigio_private[1];
+			}
+			else {
+				respond_fd = write_sigio_fds[1];
+				fds->used--;
+				memmove(&fds->poll[i], &fds->poll[i + 1],
+					(fds->used - i) * sizeof(*fds->poll));
+			}
+
+			n = os_write_file(respond_fd, &c, sizeof(c));
+			if(n != sizeof(c))
+				printk("write_sigio_thread : write failed, "
+				       "err = %d\n", -n);
+		}
+	}
+
+	return 0;
+}
+
+static int need_poll(int n)
+{
+	if(n <= next_poll.size){
+		next_poll.used = n;
+		return(0);
+	}
+	kfree(next_poll.poll);
+	next_poll.poll = um_kmalloc_atomic(n * sizeof(struct pollfd));
+	if(next_poll.poll == NULL){
+		printk("need_poll : failed to allocate new pollfds\n");
+		next_poll.size = 0;
+		next_poll.used = 0;
+		return(-1);
+	}
+	next_poll.size = n;
+	next_poll.used = n;
+	return(0);
+}
+
+/* Must be called with sigio_lock held, because it's needed by the marked
+ * critical section. */
+static void update_thread(void)
+{
+	unsigned long flags;
+	int n;
+	char c;
+
+	flags = set_signals(0);
+	n = os_write_file(sigio_private[0], &c, sizeof(c));
+	if(n != sizeof(c)){
+		printk("update_thread : write failed, err = %d\n", -n);
+		goto fail;
+	}
+
+	n = os_read_file(sigio_private[0], &c, sizeof(c));
+	if(n != sizeof(c)){
+		printk("update_thread : read failed, err = %d\n", -n);
+		goto fail;
+	}
+
+	set_signals(flags);
+	return;
+ fail:
+	/* Critical section start */
+	if(write_sigio_pid != -1)
+		os_kill_process(write_sigio_pid, 1);
+	write_sigio_pid = -1;
+	close(sigio_private[0]);
+	close(sigio_private[1]);
+	close(write_sigio_fds[0]);
+	close(write_sigio_fds[1]);
+	/* Critical section end */
+	set_signals(flags);
+}
+
+int add_sigio_fd(int fd, int read)
+{
+	int err = 0, i, n, events;
+
+	sigio_lock();
+	for(i = 0; i < current_poll.used; i++){
+		if(current_poll.poll[i].fd == fd)
+			goto out;
+	}
+
+	n = current_poll.used + 1;
+	err = need_poll(n);
+	if(err)
+		goto out;
+
+	for(i = 0; i < current_poll.used; i++)
+		next_poll.poll[i] = current_poll.poll[i];
+
+	if(read) events = POLLIN;
+	else events = POLLOUT;
+
+	next_poll.poll[n - 1] = ((struct pollfd) { .fd  	= fd,
+						   .events 	= events,
+						   .revents 	= 0 });
+	update_thread();
+ out:
+	sigio_unlock();
+	return(err);
+}
+
+int ignore_sigio_fd(int fd)
+{
+	struct pollfd *p;
+	int err = 0, i, n = 0;
+
+	sigio_lock();
+	for(i = 0; i < current_poll.used; i++){
+		if(current_poll.poll[i].fd == fd) break;
+	}
+	if(i == current_poll.used)
+		goto out;
+
+	err = need_poll(current_poll.used - 1);
+	if(err)
+		goto out;
+
+	for(i = 0; i < current_poll.used; i++){
+		p = &current_poll.poll[i];
+		if(p->fd != fd) next_poll.poll[n++] = current_poll.poll[i];
+	}
+	if(n == i){
+		printk("ignore_sigio_fd : fd %d not found\n", fd);
+		err = -1;
+		goto out;
+	}
+
+	update_thread();
+ out:
+	sigio_unlock();
+	return(err);
+}
+
+static struct pollfd *setup_initial_poll(int fd)
+{
+	struct pollfd *p;
+
+	p = um_kmalloc(sizeof(struct pollfd));
+	if (p == NULL) {
+		printk("setup_initial_poll : failed to allocate poll\n");
+		return NULL;
+	}
+	*p = ((struct pollfd) { .fd  	= fd,
+				.events 	= POLLIN,
+				.revents 	= 0 });
+	return p;
+}
+
+void write_sigio_workaround(void)
+{
+	unsigned long stack;
+	struct pollfd *p;
+	int err;
+	int l_write_sigio_fds[2];
+	int l_sigio_private[2];
+	int l_write_sigio_pid;
+
+	/* We call this *tons* of times - and most ones we must just fail. */
+	sigio_lock();
+	l_write_sigio_pid = write_sigio_pid;
+	sigio_unlock();
+
+	if (l_write_sigio_pid != -1)
+		return;
+
+	err = os_pipe(l_write_sigio_fds, 1, 1);
+	if(err < 0){
+		printk("write_sigio_workaround - os_pipe 1 failed, "
+		       "err = %d\n", -err);
+		return;
+	}
+	err = os_pipe(l_sigio_private, 1, 1);
+	if(err < 0){
+		printk("write_sigio_workaround - os_pipe 2 failed, "
+		       "err = %d\n", -err);
+		goto out_close1;
+	}
+
+	p = setup_initial_poll(l_sigio_private[1]);
+	if(!p)
+		goto out_close2;
+
+	sigio_lock();
+
+	/* Did we race? Don't try to optimize this, please, it's not so likely
+	 * to happen, and no more than once at the boot. */
+	if(write_sigio_pid != -1)
+		goto out_unlock;
+
+	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL,
+					    CLONE_FILES | CLONE_VM, &stack, 0);
+
+	if (write_sigio_pid < 0)
+		goto out_clear;
+
+	if (write_sigio_irq(l_write_sigio_fds[0]))
+		goto out_kill;
+
+	/* Success, finally. */
+	memcpy(write_sigio_fds, l_write_sigio_fds, sizeof(l_write_sigio_fds));
+	memcpy(sigio_private, l_sigio_private, sizeof(l_sigio_private));
+
+	current_poll = ((struct pollfds) { .poll 	= p,
+					   .used 	= 1,
+					   .size 	= 1 });
+
+	sigio_unlock();
+	return;
+
+ out_kill:
+	l_write_sigio_pid = write_sigio_pid;
+	write_sigio_pid = -1;
+	sigio_unlock();
+	/* Going to call waitpid, avoid holding the lock. */
+	os_kill_process(l_write_sigio_pid, 1);
+	goto out_free;
+
+ out_clear:
+	write_sigio_pid = -1;
+ out_unlock:
+	sigio_unlock();
+ out_free:
+	kfree(p);
+ out_close2:
+	close(l_sigio_private[0]);
+	close(l_sigio_private[1]);
+ out_close1:
+	close(l_write_sigio_fds[0]);
+	close(l_write_sigio_fds[1]);
+	return;
+}
+
+void sigio_cleanup(void)
+{
+	if(write_sigio_pid != -1){
+		os_kill_process(write_sigio_pid, 1);
+		write_sigio_pid = -1;
+	}
+}
Index: linux-2.6.16/arch/um/kernel/sigio_user.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/sigio_user.c	2006-03-23 17:25:36.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,324 +0,0 @@
-/*
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <unistd.h>
-#include <stdlib.h>
-#include <termios.h>
-#include <pty.h>
-#include <signal.h>
-#include <errno.h>
-#include <string.h>
-#include <sched.h>
-#include <sys/socket.h>
-#include <sys/poll.h>
-#include "init.h"
-#include "user.h"
-#include "kern_util.h"
-#include "user_util.h"
-#include "sigio.h"
-#include "os.h"
-
-/* Protected by sigio_lock(), also used by sigio_cleanup, which is an 
- * exitcall.
- */
-static int write_sigio_pid = -1;
-
-/* These arrays are initialized before the sigio thread is started, and
- * the descriptors closed after it is killed.  So, it can't see them change.
- * On the UML side, they are changed under the sigio_lock.
- */
-static int write_sigio_fds[2] = { -1, -1 };
-static int sigio_private[2] = { -1, -1 };
-
-struct pollfds {
-	struct pollfd *poll;
-	int size;
-	int used;
-};
-
-/* Protected by sigio_lock().  Used by the sigio thread, but the UML thread
- * synchronizes with it.
- */
-struct pollfds current_poll = {
-	.poll  		= NULL,
-	.size 		= 0,
-	.used 		= 0
-};
-
-struct pollfds next_poll = {
-	.poll  		= NULL,
-	.size 		= 0,
-	.used 		= 0
-};
-
-static int write_sigio_thread(void *unused)
-{
-	struct pollfds *fds, tmp;
-	struct pollfd *p;
-	int i, n, respond_fd;
-	char c;
-
-        signal(SIGWINCH, SIG_IGN);
-	fds = &current_poll;
-	while(1){
-		n = poll(fds->poll, fds->used, -1);
-		if(n < 0){
-			if(errno == EINTR) continue;
-			printk("write_sigio_thread : poll returned %d, "
-			       "errno = %d\n", n, errno);
-		}
-		for(i = 0; i < fds->used; i++){
-			p = &fds->poll[i];
-			if(p->revents == 0) continue;
-			if(p->fd == sigio_private[1]){
-				n = os_read_file(sigio_private[1], &c, sizeof(c));
-				if(n != sizeof(c))
-					printk("write_sigio_thread : "
-					       "read failed, err = %d\n", -n);
-				tmp = current_poll;
-				current_poll = next_poll;
-				next_poll = tmp;
-				respond_fd = sigio_private[1];
-			}
-			else {
-				respond_fd = write_sigio_fds[1];
-				fds->used--;
-				memmove(&fds->poll[i], &fds->poll[i + 1],
-					(fds->used - i) * sizeof(*fds->poll));
-			}
-
-			n = os_write_file(respond_fd, &c, sizeof(c));
-			if(n != sizeof(c))
-				printk("write_sigio_thread : write failed, "
-				       "err = %d\n", -n);
-		}
-	}
-
-	return 0;
-}
-
-static int need_poll(int n)
-{
-	if(n <= next_poll.size){
-		next_poll.used = n;
-		return(0);
-	}
-	kfree(next_poll.poll);
-	next_poll.poll = um_kmalloc_atomic(n * sizeof(struct pollfd));
-	if(next_poll.poll == NULL){
-		printk("need_poll : failed to allocate new pollfds\n");
-		next_poll.size = 0;
-		next_poll.used = 0;
-		return(-1);
-	}
-	next_poll.size = n;
-	next_poll.used = n;
-	return(0);
-}
-
-/* Must be called with sigio_lock held, because it's needed by the marked
- * critical section. */
-static void update_thread(void)
-{
-	unsigned long flags;
-	int n;
-	char c;
-
-	flags = set_signals(0);
-	n = os_write_file(sigio_private[0], &c, sizeof(c));
-	if(n != sizeof(c)){
-		printk("update_thread : write failed, err = %d\n", -n);
-		goto fail;
-	}
-
-	n = os_read_file(sigio_private[0], &c, sizeof(c));
-	if(n != sizeof(c)){
-		printk("update_thread : read failed, err = %d\n", -n);
-		goto fail;
-	}
-
-	set_signals(flags);
-	return;
- fail:
-	/* Critical section start */
-	if(write_sigio_pid != -1) 
-		os_kill_process(write_sigio_pid, 1);
-	write_sigio_pid = -1;
-	close(sigio_private[0]);
-	close(sigio_private[1]);
-	close(write_sigio_fds[0]);
-	close(write_sigio_fds[1]);
-	/* Critical section end */
-	set_signals(flags);
-}
-
-int add_sigio_fd(int fd, int read)
-{
-	int err = 0, i, n, events;
-
-	sigio_lock();
-	for(i = 0; i < current_poll.used; i++){
-		if(current_poll.poll[i].fd == fd) 
-			goto out;
-	}
-
-	n = current_poll.used + 1;
-	err = need_poll(n);
-	if(err) 
-		goto out;
-
-	for(i = 0; i < current_poll.used; i++)
-		next_poll.poll[i] = current_poll.poll[i];
-
-	if(read) events = POLLIN;
-	else events = POLLOUT;
-
-	next_poll.poll[n - 1] = ((struct pollfd) { .fd  	= fd,
-						   .events 	= events,
-						   .revents 	= 0 });
-	update_thread();
- out:
-	sigio_unlock();
-	return(err);
-}
-
-int ignore_sigio_fd(int fd)
-{
-	struct pollfd *p;
-	int err = 0, i, n = 0;
-
-	sigio_lock();
-	for(i = 0; i < current_poll.used; i++){
-		if(current_poll.poll[i].fd == fd) break;
-	}
-	if(i == current_poll.used)
-		goto out;
-	
-	err = need_poll(current_poll.used - 1);
-	if(err)
-		goto out;
-
-	for(i = 0; i < current_poll.used; i++){
-		p = &current_poll.poll[i];
-		if(p->fd != fd) next_poll.poll[n++] = current_poll.poll[i];
-	}
-	if(n == i){
-		printk("ignore_sigio_fd : fd %d not found\n", fd);
-		err = -1;
-		goto out;
-	}
-
-	update_thread();
- out:
-	sigio_unlock();
-	return(err);
-}
-
-static struct pollfd* setup_initial_poll(int fd)
-{
-	struct pollfd *p;
-
-	p = um_kmalloc(sizeof(struct pollfd));
-	if (p == NULL) {
-		printk("setup_initial_poll : failed to allocate poll\n");
-		return NULL;
-	}
-	*p = ((struct pollfd) { .fd  	= fd,
-				.events 	= POLLIN,
-				.revents 	= 0 });
-	return p;
-}
-
-void write_sigio_workaround(void)
-{
-	unsigned long stack;
-	struct pollfd *p;
-	int err;
-	int l_write_sigio_fds[2];
-	int l_sigio_private[2];
-	int l_write_sigio_pid;
-
-	/* We call this *tons* of times - and most ones we must just fail. */
-	sigio_lock();
-	l_write_sigio_pid = write_sigio_pid;
-	sigio_unlock();
-
-	if (l_write_sigio_pid != -1)
-		return;
-
-	err = os_pipe(l_write_sigio_fds, 1, 1);
-	if(err < 0){
-		printk("write_sigio_workaround - os_pipe 1 failed, "
-		       "err = %d\n", -err);
-		return;
-	}
-	err = os_pipe(l_sigio_private, 1, 1);
-	if(err < 0){
-		printk("write_sigio_workaround - os_pipe 1 failed, "
-		       "err = %d\n", -err);
-		goto out_close1;
-	}
-
-	p = setup_initial_poll(l_sigio_private[1]);
-	if(!p)
-		goto out_close2;
-
-	sigio_lock();
-
-	/* Did we race? Don't try to optimize this, please, it's not so likely
-	 * to happen, and no more than once at the boot. */
-	if(write_sigio_pid != -1)
-		goto out_unlock;
-
-	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL,
-					    CLONE_FILES | CLONE_VM, &stack, 0);
-
-	if (write_sigio_pid < 0)
-		goto out_clear;
-
-	if (write_sigio_irq(l_write_sigio_fds[0]))
-		goto out_kill;
-
-	/* Success, finally. */
-	memcpy(write_sigio_fds, l_write_sigio_fds, sizeof(l_write_sigio_fds));
-	memcpy(sigio_private, l_sigio_private, sizeof(l_sigio_private));
-
-	current_poll = ((struct pollfds) { .poll 	= p,
-					   .used 	= 1,
-					   .size 	= 1 });
-
-	sigio_unlock();
-	return;
-
- out_kill:
-	l_write_sigio_pid = write_sigio_pid;
-	write_sigio_pid = -1;
-	sigio_unlock();
-	/* Going to call waitpid, avoid holding the lock. */
-	os_kill_process(l_write_sigio_pid, 1);
-	goto out_free;
-
- out_clear:
-	write_sigio_pid = -1;
- out_unlock:
-	sigio_unlock();
- out_free:
-	kfree(p);
- out_close2:
-	close(l_sigio_private[0]);
-	close(l_sigio_private[1]);
- out_close1:
-	close(l_write_sigio_fds[0]);
-	close(l_write_sigio_fds[1]);
-	return;
-}
-
-void sigio_cleanup(void)
-{
-	if (write_sigio_pid != -1) {
-		os_kill_process(write_sigio_pid, 1);
-		write_sigio_pid = -1;
-	}
-}

