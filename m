Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267557AbUIJR0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267557AbUIJR0m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 13:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267619AbUIJR0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 13:26:19 -0400
Received: from [12.177.129.25] ([12.177.129.25]:24771 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S267607AbUIJRYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 13:24:51 -0400
Message-Id: <200409101828.i8AISG0O003438@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - disable pending signals across a reboot
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 Sep 2004 14:28:16 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On reboot, all signals and signal sources are disabled so that late-arriving
signals don't show up after the reboot exec, confusing the new image, which
is not expecting signals yet.

				Jeff

Index: 2.6.9-rc1/arch/um/include/irq_user.h
===================================================================
--- 2.6.9-rc1.orig/arch/um/include/irq_user.h	2004-06-16 01:19:37.000000000 -0400
+++ 2.6.9-rc1/arch/um/include/irq_user.h	2004-09-10 13:11:06.000000000 -0400
@@ -14,6 +14,7 @@
 extern void free_irq_by_fd(int fd);
 extern void reactivate_fd(int fd, int irqnum);
 extern void deactivate_fd(int fd, int irqnum);
+extern int deactivate_all_fds(void);
 extern void forward_interrupts(int pid);
 extern void init_irq_signals(int on_sigstack);
 extern void forward_ipi(int fd, int pid);
Index: 2.6.9-rc1/arch/um/include/os.h
===================================================================
--- 2.6.9-rc1.orig/arch/um/include/os.h	2004-09-09 19:46:14.000000000 -0400
+++ 2.6.9-rc1/arch/um/include/os.h	2004-09-10 13:11:06.000000000 -0400
@@ -140,6 +140,7 @@
 extern int os_file_modtime(char *file, unsigned long *modtime);
 extern int os_pipe(int *fd, int stream, int close_on_exec);
 extern int os_set_fd_async(int fd, int owner);
+extern int os_clear_fd_async(int fd);
 extern int os_set_fd_block(int fd, int blocking);
 extern int os_accept_connection(int fd);
 extern int os_create_unix_socket(char *file, int len, int close_on_exec);
Index: 2.6.9-rc1/arch/um/include/time_user.h
===================================================================
--- 2.6.9-rc1.orig/arch/um/include/time_user.h	2004-06-16 01:19:01.000000000 -0400
+++ 2.6.9-rc1/arch/um/include/time_user.h	2004-09-10 13:11:06.000000000 -0400
@@ -11,6 +11,7 @@
 extern void set_interval(int timer_type);
 extern void idle_sleep(int secs);
 extern void enable_timer(void);
+extern void disable_timer(void);
 extern unsigned long time_lock(void);
 extern void time_unlock(unsigned long);
 
Index: 2.6.9-rc1/arch/um/kernel/irq_user.c
===================================================================
--- 2.6.9-rc1.orig/arch/um/kernel/irq_user.c	2004-09-09 19:46:14.000000000 -0400
+++ 2.6.9-rc1/arch/um/kernel/irq_user.c	2004-09-10 13:11:06.000000000 -0400
@@ -364,6 +364,20 @@
 	irq_unlock(flags);
 }
 
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
+
+	return(0);
+}
+
 void forward_ipi(int fd, int pid)
 {
 	int err;
Index: 2.6.9-rc1/arch/um/kernel/time.c
===================================================================
--- 2.6.9-rc1.orig/arch/um/kernel/time.c	2004-09-09 19:46:14.000000000 -0400
+++ 2.6.9-rc1/arch/um/kernel/time.c	2004-09-10 13:11:06.000000000 -0400
@@ -54,6 +54,15 @@
 		       errno);
 }
 
+void disable_timer(void)
+{
+	struct itimerval disable = ((struct itimerval) { { 0, 0 }, { 0, 0 }});
+	if((setitimer(ITIMER_VIRTUAL, &disable, NULL) < 0) ||
+	   (setitimer(ITIMER_REAL, &disable, NULL) < 0))
+		printk("disnable_timer - setitimer failed, errno = %d\n",
+		       errno);
+}
+
 void switch_timers(int to_real)
 {
 	struct itimerval disable = ((struct itimerval) { { 0, 0 }, { 0, 0 }});
Index: 2.6.9-rc1/arch/um/os-Linux/file.c
===================================================================
--- 2.6.9-rc1.orig/arch/um/os-Linux/file.c	2004-09-09 19:46:14.000000000 -0400
+++ 2.6.9-rc1/arch/um/os-Linux/file.c	2004-09-10 13:11:06.000000000 -0400
@@ -495,6 +495,16 @@
 	return(0);
 }
 
+int os_clear_fd_async(int fd)
+{
+	int flags = fcntl(fd, F_GETFL);
+
+	flags &= ~(O_ASYNC | O_NONBLOCK);
+	if(fcntl(fd, F_SETFL, flags) < 0)
+		return(-errno);
+	return(0);
+}
+
 int os_set_fd_block(int fd, int blocking)
 {
 	int flags;

