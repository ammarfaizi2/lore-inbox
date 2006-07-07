Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWGGAev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWGGAev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWGGAeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:34:22 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:51139 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751109AbWGGAdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:33:45 -0400
Message-Id: <200607070033.k670XmJx008722@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 13/19] UML - Make some symbols static
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jul 2006 20:33:48 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few sigio-related things can be made static.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/include/os.h
===================================================================
--- linux-2.6.17.orig/arch/um/include/os.h	2006-07-06 13:28:50.000000000 -0400
+++ linux-2.6.17/arch/um/include/os.h	2006-07-06 13:28:59.000000000 -0400
@@ -329,7 +329,6 @@ extern void os_set_ioignore(void);
 extern void init_irq_signals(int on_sigstack);
 
 /* sigio.c */
-extern int add_sigio_fd(int fd, int read);
 extern int ignore_sigio_fd(int fd);
 extern void maybe_sigio_broken(int fd, int read);
 
Index: linux-2.6.17/arch/um/kernel/sigio_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/sigio_kern.c	2006-07-06 13:22:13.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/sigio_kern.c	2006-07-06 13:28:59.000000000 -0400
@@ -53,17 +53,3 @@ void sigio_unlock(void)
 {
 	spin_unlock(&sigio_spinlock);
 }
-
-extern void sigio_cleanup(void);
-__uml_exitcall(sigio_cleanup);
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
Index: linux-2.6.17/arch/um/os-Linux/sigio.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/sigio.c	2006-07-06 13:28:57.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/sigio.c	2006-07-06 13:28:59.000000000 -0400
@@ -43,13 +43,13 @@ struct pollfds {
 /* Protected by sigio_lock().  Used by the sigio thread, but the UML thread
  * synchronizes with it.
  */
-struct pollfds current_poll = {
+static struct pollfds current_poll = {
 	.poll  		= NULL,
 	.size 		= 0,
 	.used 		= 0
 };
 
-struct pollfds next_poll = {
+static struct pollfds next_poll = {
 	.poll  		= NULL,
 	.size 		= 0,
 	.used 		= 0
@@ -156,7 +156,7 @@ static void update_thread(void)
 	set_signals(flags);
 }
 
-int add_sigio_fd(int fd, int read)
+static int add_sigio_fd(int fd, int read)
 {
 	int err = 0, i, n, events;
 
@@ -333,10 +333,12 @@ void maybe_sigio_broken(int fd, int read
 	add_sigio_fd(fd, read);
 }
 
-void sigio_cleanup(void)
+static void sigio_cleanup(void)
 {
 	if(write_sigio_pid != -1){
 		os_kill_process(write_sigio_pid, 1);
 		write_sigio_pid = -1;
 	}
 }
+
+__uml_exitcall(sigio_cleanup);

