Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVAJFit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVAJFit (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVAJFis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:38:48 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:20740
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262095AbVAJFOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:17 -0500
Message-Id: <200501100735.j0A7ZYPW005780@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 10/28] UML - Make a common misconfiguration impossible
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:35:34 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes UML produce error messages instead of silently exiting
when one of several configuration mistakes are made.  FD_CHAN is now
mandatory so that people don't turn it off and complain about no boot
messages.
Some printks were turned into printfs in the tt mode gdb code so that they
appear on the screen.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/Kconfig_char
===================================================================
--- 2.6.10.orig/arch/um/Kconfig_char	2004-12-14 12:14:46.000000000 -0500
+++ 2.6.10/arch/um/Kconfig_char	2004-12-14 16:00:23.000000000 -0500
@@ -23,15 +23,6 @@
 
         Unless you have a specific reason for disabling this, say Y.
 
-config FD_CHAN
-	bool "file descriptor channel support"
-	help
-        This option enables support for attaching UML consoles and serial
-        lines to already set up file descriptors.  Generally, the main
-        console is attached to file descriptors 0 and 1 (stdin and stdout),
-        so it would be wise to leave this enabled unless you intend to
-        attach it to some other host device.
-
 config NULL_CHAN
 	bool "null channel support"
 	help
@@ -80,7 +71,7 @@
 
 config NOCONFIG_CHAN
 	bool
-	default !(XTERM_CHAN && TTY_CHAN && PTY_CHAN && PORT_CHAN && FD_CHAN && NULL_CHAN)
+	default !(XTERM_CHAN && TTY_CHAN && PTY_CHAN && PORT_CHAN && NULL_CHAN)
 
 config CON_ZERO_CHAN
 	string "Default main console channel initialization"
Index: 2.6.10/arch/um/defconfig
===================================================================
--- 2.6.10.orig/arch/um/defconfig	2004-12-14 15:51:48.000000000 -0500
+++ 2.6.10/arch/um/defconfig	2004-12-14 16:00:23.000000000 -0500
@@ -92,13 +92,12 @@
 CONFIG_STDERR_CONSOLE=y
 CONFIG_STDIO_CONSOLE=y
 CONFIG_SSL=y
-CONFIG_FD_CHAN=y
 CONFIG_NULL_CHAN=y
 CONFIG_PORT_CHAN=y
 CONFIG_PTY_CHAN=y
 CONFIG_TTY_CHAN=y
 CONFIG_XTERM_CHAN=y
-# CONFIG_NOCONFIG_CHAN is not set
+CONFIG_NOCONFIG_CHAN=y
 CONFIG_CON_ZERO_CHAN="fd:0,fd:1"
 CONFIG_CON_CHAN="xterm"
 CONFIG_SSL_CHAN="pty"
Index: 2.6.10/arch/um/drivers/Makefile
===================================================================
--- 2.6.10.orig/arch/um/drivers/Makefile	2004-12-14 12:14:46.000000000 -0500
+++ 2.6.10/arch/um/drivers/Makefile	2004-12-14 16:00:23.000000000 -0500
@@ -20,7 +20,7 @@
 port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o
 
-obj-y := stdio_console.o $(CHAN_OBJS)
+obj-y := stdio_console.o fd.o $(CHAN_OBJS) 
 obj-$(CONFIG_SSL) += ssl.o
 obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
 
@@ -34,7 +34,6 @@
 obj-$(CONFIG_MMAPPER) += mmapper_kern.o 
 obj-$(CONFIG_BLK_DEV_UBD) += ubd.o 
 obj-$(CONFIG_HOSTAUDIO) += hostaudio.o
-obj-$(CONFIG_FD_CHAN) += fd.o 
 obj-$(CONFIG_NULL_CHAN) += null.o 
 obj-$(CONFIG_PORT_CHAN) += port.o
 obj-$(CONFIG_PTY_CHAN) += pty.o
Index: 2.6.10/arch/um/drivers/chan_kern.c
===================================================================
--- 2.6.10.orig/arch/um/drivers/chan_kern.c	2004-12-14 12:14:46.000000000 -0500
+++ 2.6.10/arch/um/drivers/chan_kern.c	2004-12-14 16:00:23.000000000 -0500
@@ -399,11 +399,7 @@
 };
 
 struct chan_type chan_table[] = {
-#ifdef CONFIG_FD_CHAN
 	{ "fd", &fd_ops },
-#else
-	{ "fd", &not_configged_ops },
-#endif
 
 #ifdef CONFIG_NULL_CHAN
 	{ "null", &null_ops },
Index: 2.6.10/arch/um/kernel/tt/gdb.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/tt/gdb.c	2004-12-14 11:42:52.000000000 -0500
+++ 2.6.10/arch/um/kernel/tt/gdb.c	2004-12-14 16:00:23.000000000 -0500
@@ -162,7 +162,7 @@
 void signal_usr1(int sig)
 {
 	if(debugger_pid != -1){
-		printk(UM_KERN_ERR "The debugger is already running\n");
+		printf("The debugger is already running\n");
 		return;
 	}
 	debugger_pid = start_debugger(linux_prog, 0, 0, &debugger_fd);
@@ -228,19 +228,19 @@
 void child_signal(pid_t pid, int status){ }
 int init_ptrace_proxy(int idle_pid, int startup, int stop)
 {
-	printk(UM_KERN_ERR "debug requested when CONFIG_PT_PROXY is off\n");
+	printf("debug requested when CONFIG_PT_PROXY is off\n");
 	kill_child_dead(idle_pid);
 	exit(1);
 }
 
 void signal_usr1(int sig)
 {
-	printk(UM_KERN_ERR "debug requested when CONFIG_PT_PROXY is off\n");
+	printf("debug requested when CONFIG_PT_PROXY is off\n");
 }
 
 int attach_debugger(int idle_pid, int pid, int stop)
 {
-	printk(UM_KERN_ERR "attach_debugger called when CONFIG_PT_PROXY "
+	printf("attach_debugger called when CONFIG_PT_PROXY "
 	       "is off\n");
 	return(-1);
 }

