Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbUKDCG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbUKDCG6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbUKDCFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:05:18 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:5524
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S262058AbUKDBz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:55:57 -0500
Subject: [patch 17/20] UML: Lots of little fixes by Jeff Dike.
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 04 Nov 2004 00:17:54 +0100
Message-Id: <20041103231754.C22B355C89@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jeff Dike <jdike@addtoit.com>

This is a large set of small fixes and other changes:

Fixed a file descriptor leak in the network driver when changing an IP
address.

The port channel now sets SO_REUSEADDR.

Added some initcall and exitcall definitions to arch/um/include/init.h
so that they can be used from userspace code.

Fixed the error handling in run_helper.

Added the log() facility to mem_user.c.

Fixed a problem with recursive segfaults not being handled correctly.

tty_log_fd and umid aren't added to the command line any more.

Fixed some prints.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/drivers/port_user.c             |    8 ++
 vanilla-linux-2.6.9-paolo/arch/um/kernel/mem_user.c               |   33 ++++++++++
 vanilla-linux-2.6.9-paolo/arch/um/kernel/sigio_kern.c             |    2 
 vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/include/mode-skas.h |    2 
 vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/trap_user.c           |    7 ++
 vanilla-linux-2.6.9-paolo/arch/um/kernel/tty_log.c                |    2 
 vanilla-linux-2.6.9-paolo/arch/um/kernel/umid.c                   |    1 
 vanilla-linux-2.6.9-paolo/arch/um/os-Linux/file.c                 |    3 
 8 files changed, 55 insertions(+), 3 deletions(-)

diff -puN arch/um/drivers/port_user.c~uml-random arch/um/drivers/port_user.c
--- vanilla-linux-2.6.9/arch/um/drivers/port_user.c~uml-random	2004-11-03 23:29:27.894140360 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/drivers/port_user.c	2004-11-03 23:29:27.967129264 +0100
@@ -123,12 +123,18 @@ struct chan_ops port_ops = {
 int port_listen_fd(int port)
 {
 	struct sockaddr_in addr;
-	int fd, err;
+	int fd, err, arg;
 
 	fd = socket(PF_INET, SOCK_STREAM, 0);
 	if(fd == -1) 
 		return(-errno);
 
+	arg = 1;
+	if(setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &arg, sizeof(arg)) < 0){
+		err = -errno;
+		goto out;
+	}
+
 	addr.sin_family = AF_INET;
 	addr.sin_port = htons(port);
 	addr.sin_addr.s_addr = htonl(INADDR_ANY);
diff -puN arch/um/kernel/mem_user.c~uml-random arch/um/kernel/mem_user.c
--- vanilla-linux-2.6.9/arch/um/kernel/mem_user.c~uml-random	2004-11-03 23:29:27.934134280 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/mem_user.c	2004-11-03 23:29:27.967129264 +0100
@@ -228,6 +228,39 @@ int protect_memory(unsigned long addr, u
 	return(0);
 }
 
+#if 0
+/* Debugging facility for dumping stuff out to the host, avoiding the timing
+ * problems that come with printf and breakpoints.
+ * Enable in case of emergency.
+ */
+
+int logging = 1;
+int logging_fd = -1;
+
+int logging_line = 0;
+char logging_buf[512];
+
+void log(char *fmt, ...)
+{
+        va_list ap;
+        struct timeval tv;
+        struct openflags flags;
+
+        if(logging == 0) return;
+        if(logging_fd < 0){
+                flags = of_create(of_trunc(of_rdwr(OPENFLAGS())));
+                logging_fd = os_open_file("log", flags, 0644);
+        }
+        gettimeofday(&tv, NULL);
+        sprintf(logging_buf, "%d\t %u.%u  ", logging_line++, tv.tv_sec,
+                tv.tv_usec);
+        va_start(ap, fmt);
+        vsprintf(&logging_buf[strlen(logging_buf)], fmt, ap);
+        va_end(ap);
+        write(logging_fd, logging_buf, strlen(logging_buf));
+}
+#endif
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
diff -puN arch/um/kernel/sigio_kern.c~uml-random arch/um/kernel/sigio_kern.c
--- vanilla-linux-2.6.9/arch/um/kernel/sigio_kern.c~uml-random	2004-11-03 23:29:27.936133976 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/sigio_kern.c	2004-11-03 23:29:27.967129264 +0100
@@ -28,7 +28,7 @@ int write_sigio_irq(int fd)
 	int err;
 
 	err = um_request_irq(SIGIO_WRITE_IRQ, fd, IRQ_READ, sigio_interrupt,
-			  SA_INTERRUPT | SA_SAMPLE_RANDOM, "write sigio", 
+			     SA_INTERRUPT | SA_SAMPLE_RANDOM, "write sigio",
 			     NULL);
 	if(err){
 		printk("write_sigio_irq : um_request_irq failed, err = %d\n",
diff -puN arch/um/kernel/skas/include/mode-skas.h~uml-random arch/um/kernel/skas/include/mode-skas.h
--- vanilla-linux-2.6.9/arch/um/kernel/skas/include/mode-skas.h~uml-random	2004-11-03 23:29:27.959130480 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/include/mode-skas.h	2004-11-03 23:29:27.968129112 +0100
@@ -6,6 +6,8 @@
 #ifndef __MODE_SKAS_H__
 #define __MODE_SKAS_H__
 
+#include <sysdep/ptrace.h>
+
 extern unsigned long exec_regs[];
 extern unsigned long exec_fp_regs[];
 extern unsigned long exec_fpx_regs[];
diff -puN arch/um/kernel/tt/trap_user.c~uml-random arch/um/kernel/tt/trap_user.c
--- vanilla-linux-2.6.9/arch/um/kernel/tt/trap_user.c~uml-random	2004-11-03 23:29:27.960130328 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/trap_user.c	2004-11-03 23:29:27.968129112 +0100
@@ -30,6 +30,13 @@ void sig_handler_common_tt(int sig, void
 	if(sig == SIGSEGV)
 		change_sig(SIGSEGV, 1);
 
+	/* This is done because to allow SIGSEGV to be delivered inside a SEGV
+	 * handler.  This can happen in copy_user, and if SEGV is disabled,
+	 * the process will die.
+	 */
+	if(sig == SIGSEGV)
+		change_sig(SIGSEGV, 1);
+
 	r = &TASK_REGS(get_current())->tt;
 	save_regs = *r;
 	is_user = user_context(SC_SP(sc));
diff -puN arch/um/kernel/tty_log.c~uml-random arch/um/kernel/tty_log.c
--- vanilla-linux-2.6.9/arch/um/kernel/tty_log.c~uml-random	2004-11-03 23:29:27.962130024 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/tty_log.c	2004-11-03 23:29:27.968129112 +0100
@@ -205,6 +205,8 @@ static int __init set_tty_log_fd(char *n
 		printf("set_tty_log_fd - strtoul failed on '%s'\n", name);
 		tty_log_fd = -1;
 	}
+
+	*add = 0;
 	return 0;
 }
 
diff -puN arch/um/kernel/umid.c~uml-random arch/um/kernel/umid.c
--- vanilla-linux-2.6.9/arch/um/kernel/umid.c~uml-random	2004-11-03 23:29:27.963129872 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/umid.c	2004-11-03 23:29:27.968129112 +0100
@@ -54,6 +54,7 @@ static int __init set_umid(char *name, i
 
 static int __init set_umid_arg(char *name, int *add)
 {
+	*add = 0;
 	return(set_umid(name, 0, printf));
 }
 
diff -puN arch/um/os-Linux/file.c~uml-random arch/um/os-Linux/file.c
--- vanilla-linux-2.6.9/arch/um/os-Linux/file.c~uml-random	2004-11-03 23:29:27.964129720 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/os-Linux/file.c	2004-11-03 23:29:27.969128960 +0100
@@ -308,7 +308,8 @@ int os_seek_file(int fd, __u64 offset)
 	__u64 actual;
 
 	actual = lseek64(fd, offset, SEEK_SET);
-	if(actual != offset) return(-errno);
+	if(actual != offset)
+		return(-errno);
 	return(0);
 }
 
_
