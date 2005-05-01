Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbVEAVUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVEAVUy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbVEAVTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:19:19 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:20499 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262680AbVEAVSY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:18:24 -0400
Message-Id: <200505012112.j41LCnxL016446@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/22] UML - Fix SIGWINCH relaying
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:12:49 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes SIGWINCH work again, and fixes a couple of SIGWINCH-associated 
crashes.  First, the sigio thread disables SIGWINCH because all hell breaks 
loose if it ever gets one and tries to call the signal handling code.
Second, there was a problem with deferencing tty structs after they were
freed.  The SIGWINCH support for a tty wasn't being turned off or freed
after the tty went away.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11-mm/arch/um/drivers/line.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/drivers/line.c	2005-04-30 12:57:43.000000000 -0400
+++ linux-2.6.11-mm/arch/um/drivers/line.c	2005-04-30 13:09:17.000000000 -0400
@@ -462,12 +462,15 @@
 	return err;
 }
 
+static void unregister_winch(struct tty_struct *tty);
+
 void line_close(struct tty_struct *tty, struct file * filp)
 {
 	struct line *line = tty->driver_data;
 
-	/* XXX: I assume this should be called in process context, not with interrupt
-	 * disabled!*/
+	/* XXX: I assume this should be called in process context, not with 
+         *  interrupts disabled!
+         */
 	spin_lock_irq(&line->lock);
 
 	/* We ignore the error anyway! */
@@ -478,6 +481,12 @@
 		line_disable(tty, -1);
 		tty->driver_data = NULL;
 	}
+
+        if((line->count == 0) && line->sigio){
+                unregister_winch(tty);
+                line->sigio = 0;
+        }
+
 	spin_unlock_irq(&line->lock);
 }
 
@@ -729,6 +738,34 @@
 	up(&winch_handler_sem);
 }
 
+static void unregister_winch(struct tty_struct *tty)
+{
+	struct list_head *ele;
+	struct winch *winch, *found = NULL;
+
+	down(&winch_handler_sem);
+	list_for_each(ele, &winch_handlers){
+		winch = list_entry(ele, struct winch, list);
+                if(winch->tty == tty){
+                        found = winch;
+                        break;
+                }
+        }
+
+        if(found == NULL)
+                goto out;
+
+        if(winch->pid != -1)
+                os_kill_process(winch->pid, 1);
+
+        free_irq_by_irq_and_dev(WINCH_IRQ, winch);
+        free_irq(WINCH_IRQ, winch);
+        list_del(&winch->list);
+        kfree(winch);
+ out:
+	up(&winch_handler_sem);
+}
+
 static void winch_cleanup(void)
 {
 	struct list_head *ele;
Index: linux-2.6.11-mm/arch/um/include/os.h
===================================================================
--- linux-2.6.11-mm.orig/arch/um/include/os.h	2005-04-30 12:56:24.000000000 -0400
+++ linux-2.6.11-mm/arch/um/include/os.h	2005-04-30 13:08:14.000000000 -0400
@@ -160,6 +160,7 @@
 extern void os_kill_ptraced_process(int pid, int reap_child);
 extern void os_usr1_process(int pid);
 extern int os_getpid(void);
+extern int os_getpgrp(void);
 
 extern int os_map_memory(void *virt, int fd, unsigned long long off,
 			 unsigned long len, int r, int w, int x);
Index: linux-2.6.11-mm/arch/um/kernel/irq.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/irq.c	2005-04-30 12:56:24.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/irq.c	2005-04-30 13:08:14.000000000 -0400
@@ -163,7 +163,6 @@
 		irq_desc[i].handler = &SIGIO_irq_type;
 		enable_irq(i);
 	}
-	init_irq_signals(0);
 }
 
 /*
Index: linux-2.6.11-mm/arch/um/kernel/process.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/process.c	2005-04-30 12:56:24.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/process.c	2005-04-30 13:08:14.000000000 -0400
@@ -65,8 +65,6 @@
 		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
 	set_handler(SIGBUS, (__sighandler_t) sig_handler, flags, 
 		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
-	set_handler(SIGWINCH, (__sighandler_t) sig_handler, flags, 
-		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
 	set_handler(SIGUSR2, (__sighandler_t) sig_handler, 
 		    flags, SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
 	signal(SIGHUP, SIG_IGN);
Index: linux-2.6.11-mm/arch/um/kernel/sigio_user.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/sigio_user.c	2005-04-30 12:56:24.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/sigio_user.c	2005-04-30 13:08:14.000000000 -0400
@@ -182,6 +182,7 @@
 	int i, n, respond_fd;
 	char c;
 
+        signal(SIGWINCH, SIG_IGN);
 	fds = &current_poll;
 	while(1){
 		n = poll(fds->poll, fds->used, -1);
Index: linux-2.6.11-mm/arch/um/kernel/skas/process.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/skas/process.c	2005-04-30 13:08:02.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/skas/process.c	2005-04-30 13:08:14.000000000 -0400
@@ -28,10 +28,11 @@
 #include "chan_user.h"
 #include "signal_user.h"
 #include "registers.h"
+#include "process.h"
 
 int is_skas_winch(int pid, int fd, void *data)
 {
-	if(pid != os_getpid())
+        if(pid != os_getpgrp())
 		return(0);
 
 	register_winch_irq(-1, fd, -1, data);
@@ -259,6 +260,10 @@
 	sigjmp_buf **switch_buf = switch_buf_ptr;
 	int n;
 
+	set_handler(SIGWINCH, (__sighandler_t) sig_handler, 
+		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGALRM,
+		    SIGVTALRM, -1);
+
 	*fork_buf_ptr = &initial_jmpbuf;
 	n = sigsetjmp(initial_jmpbuf, 1);
 	if(n == 0)
Index: linux-2.6.11-mm/arch/um/kernel/tt/tracer.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/tt/tracer.c	2005-04-30 13:08:02.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/tt/tracer.c	2005-04-30 13:08:14.000000000 -0400
@@ -26,6 +26,7 @@
 #include "kern_util.h"
 #include "chan_user.h"
 #include "ptrace_user.h"
+#include "irq_user.h"
 #include "mode.h"
 #include "tt.h"
 
@@ -33,7 +34,7 @@
 
 int is_tracer_winch(int pid, int fd, void *data)
 {
-	if(pid != tracing_pid)
+	if(pid != os_getpgrp())
 		return(0);
 
 	register_winch_irq(tracer_winch[0], fd, -1, data);
@@ -119,6 +120,7 @@
 	signal(SIGSEGV, (__sighandler_t) sig_handler);
 	set_cmdline("(idle thread)");
 	set_init_pid(os_getpid());
+	init_irq_signals(0);
 	proc = arg;
 	return((*proc)(NULL));
 }
Index: linux-2.6.11-mm/arch/um/os-Linux/process.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/os-Linux/process.c	2005-04-30 12:56:24.000000000 -0400
+++ linux-2.6.11-mm/arch/um/os-Linux/process.c	2005-04-30 13:08:14.000000000 -0400
@@ -123,6 +123,11 @@
 	return(getpid());
 }
 
+int os_getpgrp(void)
+{
+	return getpgrp();
+}
+
 int os_map_memory(void *virt, int fd, unsigned long long off, unsigned long len,
 		  int r, int w, int x)
 {

