Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWGGAj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWGGAj1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWGGAeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:34:15 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:53187 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751117AbWGGAdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:33:50 -0400
Message-Id: <200607070033.k670XiwH008712@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 11/19] UML - Remove os_isatty
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jul 2006 20:33:44 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

os_isatty can be made to disappear by moving maybe_sigio_broken from
kernel to user code.  This also lets write_sigio_workaround become
static.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/include/os.h
===================================================================
--- linux-2.6.17.orig/arch/um/include/os.h	2006-07-06 13:25:20.000000000 -0400
+++ linux-2.6.17/arch/um/include/os.h	2006-07-06 13:28:50.000000000 -0400
@@ -318,7 +318,6 @@ extern void reboot_skas(void);
 
 /* irq.c */
 extern int os_waiting_for_events(struct irq_fd *active_fds);
-extern int os_isatty(int fd);
 extern int os_create_pollfd(int fd, int events, void *tmp_pfd, int size_tmpfds);
 extern void os_free_irq_by_cb(int (*test)(struct irq_fd *, void *), void *arg,
 		struct irq_fd *active_fds, struct irq_fd ***last_irq_ptr2);
@@ -330,9 +329,9 @@ extern void os_set_ioignore(void);
 extern void init_irq_signals(int on_sigstack);
 
 /* sigio.c */
-extern void write_sigio_workaround(void);
 extern int add_sigio_fd(int fd, int read);
 extern int ignore_sigio_fd(int fd);
+extern void maybe_sigio_broken(int fd, int read);
 
 /* skas/trap */
 extern void sig_handler_common_skas(int sig, void *sc_ptr);
Index: linux-2.6.17/arch/um/kernel/irq.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/irq.c	2006-07-06 13:28:43.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/irq.c	2006-07-06 13:28:50.000000000 -0400
@@ -110,19 +110,6 @@ void sigio_handler(int sig, union uml_pt
 	free_irqs();
 }
 
-static void maybe_sigio_broken(int fd, int type)
-{
-	if (os_isatty(fd)) {
-		if ((type == IRQ_WRITE) && !pty_output_sigio) {
-			write_sigio_workaround();
-			add_sigio_fd(fd, 0);
-		} else if ((type == IRQ_READ) && !pty_close_sigio) {
-			write_sigio_workaround();
-			add_sigio_fd(fd, 1);
-		}
-	}
-}
-
 static DEFINE_SPINLOCK(irq_lock);
 
 int activate_fd(int irq, int fd, int type, void *dev_id)
@@ -221,7 +208,7 @@ int activate_fd(int irq, int fd, int typ
 	/* This calls activate_fd, so it has to be outside the critical
 	 * section.
 	 */
-	maybe_sigio_broken(fd, type);
+	maybe_sigio_broken(fd, (type == IRQ_READ));
 
 	return(0);
 
@@ -318,7 +305,7 @@ void reactivate_fd(int fd, int irqnum)
 	/* This calls activate_fd, so it has to be outside the critical
 	 * section.
 	 */
-	maybe_sigio_broken(fd, irq->type);
+	maybe_sigio_broken(fd, (irq->type == IRQ_READ));
 }
 
 void deactivate_fd(int fd, int irqnum)
Index: linux-2.6.17/arch/um/os-Linux/irq.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/irq.c	2006-07-06 13:25:08.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/irq.c	2006-07-06 13:28:50.000000000 -0400
@@ -52,11 +52,6 @@ int os_waiting_for_events(struct irq_fd 
 	return n;
 }
 
-int os_isatty(int fd)
-{
-	return isatty(fd);
-}
-
 int os_create_pollfd(int fd, int events, void *tmp_pfd, int size_tmpfds)
 {
 	if (pollfds_num == pollfds_size) {
Index: linux-2.6.17/arch/um/os-Linux/sigio.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/sigio.c	2006-06-20 17:24:29.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/sigio.c	2006-07-06 13:28:50.000000000 -0400
@@ -233,7 +233,7 @@ static struct pollfd *setup_initial_poll
 	return p;
 }
 
-void write_sigio_workaround(void)
+static void write_sigio_workaround(void)
 {
 	unsigned long stack;
 	struct pollfd *p;
@@ -314,6 +314,18 @@ out_close1:
 	close(l_write_sigio_fds[1]);
 }
 
+void maybe_sigio_broken(int fd, int read)
+{
+	if(!isatty(fd))
+		return;
+
+	if((read || pty_output_sigio) && (!read || pty_close_sigio))
+		return;
+
+	write_sigio_workaround();
+	add_sigio_fd(fd, read);
+}
+
 void sigio_cleanup(void)
 {
 	if(write_sigio_pid != -1){

