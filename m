Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268410AbUIQEPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268410AbUIQEPo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 00:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268407AbUIQEN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 00:13:27 -0400
Received: from [12.177.129.25] ([12.177.129.25]:4548 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268331AbUIQENC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 00:13:02 -0400
Message-Id: <200409170517.i8H5HR2J005377@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - Clean up terminal state handling
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Sep 2004 01:17:27 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up UML's handling of terminal state with better error
handling, interface cleanup, and some code tidying.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/drivers/fd.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/drivers/fd.c	2004-09-16 22:59:06.000000000 -0400
+++ 2.6.9-rc2/arch/um/drivers/fd.c	2004-09-16 23:14:18.000000000 -0400
@@ -7,6 +7,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <termios.h>
+#include <errno.h>
 #include "user.h"
 #include "user_util.h"
 #include "chan_user.h"
@@ -45,10 +46,16 @@
 int fd_open(int input, int output, int primary, void *d, char **dev_out)
 {
 	struct fd_chan *data = d;
+	int err;
 
 	if(data->raw && isatty(data->fd)){
-		tcgetattr(data->fd, &data->tt);
-		raw(data->fd, 0);
+		CATCH_EINTR(err = tcgetattr(data->fd, &data->tt));
+		if(err)
+			return(err);
+
+		err = raw(data->fd);
+		if(err)
+			return(err);
 	}
 	sprintf(data->str, "%d", data->fd);
 	*dev_out = data->str;
@@ -58,9 +65,13 @@
 void fd_close(int fd, void *d)
 {
 	struct fd_chan *data = d;
+	int err;
 
 	if(data->raw && isatty(fd)){
-		tcsetattr(fd, TCSAFLUSH, &data->tt);
+		CATCH_EINTR(err = tcsetattr(fd, TCSAFLUSH, &data->tt));
+		if(err)
+			printk("Failed to restore terminal state - " 
+			       "errno = %d\n", -err);
 		data->raw = 0;
 	}
 }
Index: 2.6.9-rc2/arch/um/drivers/port_user.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/drivers/port_user.c	2004-09-16 22:59:06.000000000 -0400
+++ 2.6.9-rc2/arch/um/drivers/port_user.c	2004-09-16 23:14:18.000000000 -0400
@@ -76,12 +76,17 @@
 int port_open(int input, int output, int primary, void *d, char **dev_out)
 {
 	struct port_chan *data = d;
-	int fd;
+	int fd, err;
 
 	fd = port_wait(data->kernel_data);
 	if((fd >= 0) && data->raw){
-		tcgetattr(fd, &data->tt);
-		raw(fd, 0);
+		CATCH_EINTR(err = tcgetattr(fd, &data->tt));
+		if(err)
+			return(err);
+
+		err = raw(fd);
+		if(err)
+			return(err);
 	}
 	*dev_out = data->dev;
 	return(fd);
Index: 2.6.9-rc2/arch/um/drivers/pty.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/drivers/pty.c	2004-09-16 22:59:06.000000000 -0400
+++ 2.6.9-rc2/arch/um/drivers/pty.c	2004-09-16 23:14:18.000000000 -0400
@@ -38,7 +38,7 @@
 {
 	struct pty_chan *data = d;
 	char *dev;
-	int fd;
+	int fd, err;
 
 	fd = get_pty();
 	if(fd < 0){
@@ -46,8 +46,13 @@
 		return(-errno);
 	}
 	if(data->raw){
-		tcgetattr(fd, &data->tt);
-		raw(fd, 0);
+		CATCH_EINTR(err = tcgetattr(fd, &data->tt));
+		if(err)
+			return(err);
+
+		err = raw(fd);
+		if(err)
+			return(err);
 	}
 
 	dev = ptsname(fd);
@@ -89,13 +94,19 @@
 int pty_open(int input, int output, int primary, void *d, char **dev_out)
 {
 	struct pty_chan *data = d;
-	int fd;
+	int fd, err;
 	char dev[sizeof("/dev/ptyxx\0")] = "/dev/ptyxx";
 
 	fd = getmaster(dev);
-	if(fd < 0) return(-errno);
+	if(fd < 0) 
+		return(-errno);
+	
+	if(data->raw){
+		err = raw(fd);
+		if(err)
+			return(err);
+	}
 	
-	if(data->raw) raw(fd, 0);
 	if(data->announce) (*data->announce)(dev, data->dev);
 
 	sprintf(data->dev_name, "%s", dev);
Index: 2.6.9-rc2/arch/um/drivers/tty.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/drivers/tty.c	2004-09-16 22:59:06.000000000 -0400
+++ 2.6.9-rc2/arch/um/drivers/tty.c	2004-09-16 23:14:18.000000000 -0400
@@ -41,13 +41,18 @@
 int tty_open(int input, int output, int primary, void *d, char **dev_out)
 {
 	struct tty_chan *data = d;
-	int fd;
+	int fd, err;
 
 	fd = os_open_file(data->dev, of_set_rw(OPENFLAGS(), input, output), 0);
 	if(fd < 0) return(fd);
 	if(data->raw){
-		tcgetattr(fd, &data->tt);
-		raw(fd, 0);
+		CATCH_EINTR(err = tcgetattr(fd, &data->tt));
+		if(err)
+			return(err);
+
+		err = raw(fd);
+		if(err)
+			return(err);
 	}
 
 	*dev_out = data->dev;
Index: 2.6.9-rc2/arch/um/drivers/xterm.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/drivers/xterm.c	2004-09-16 22:59:06.000000000 -0400
+++ 2.6.9-rc2/arch/um/drivers/xterm.c	2004-09-16 23:14:18.000000000 -0400
@@ -142,8 +142,19 @@
 		goto out;
 	}
 
-	tcgetattr(new, &data->tt);
-	if(data->raw) raw(new, 0);
+	CATCH_EINTR(err = tcgetattr(new, &data->tt));
+	if(err){
+		new = err;
+		goto out;
+	}
+
+	if(data->raw){
+		err = raw(new);
+		if(err){
+			new = err;
+			goto out;
+		}
+	}
 
 	data->pid = pid;
 	*dev_out = NULL;
Index: 2.6.9-rc2/arch/um/include/user_util.h
===================================================================
--- 2.6.9-rc2.orig/arch/um/include/user_util.h	2004-09-16 22:59:06.000000000 -0400
+++ 2.6.9-rc2/arch/um/include/user_util.h	2004-09-16 23:14:18.000000000 -0400
@@ -8,6 +8,8 @@
 
 #include "sysdep/ptrace.h"
 
+#define CATCH_EINTR(expr) while (((expr) < 0) && (errno == EINTR))
+
 extern int mode_tt;
 
 extern int grantpt(int __fd);
@@ -89,11 +91,8 @@
 extern int can_do_skas(void);
 extern void arch_init_thread(void);
 extern int setjmp_wrapper(void (*proc)(void *, void *), ...);
+extern int raw(int fd);
 
-extern int __raw(int fd, int complain, int now);
-#define raw(fd, complain) __raw((fd), (complain), 1)
-
-#define CATCH_EINTR(expr) while ( ((expr) < 0) && errno == EINTR)
 #endif
 
 /*
Index: 2.6.9-rc2/arch/um/kernel/sigio_user.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/sigio_user.c	2004-09-16 22:59:06.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/sigio_user.c	2004-09-16 23:14:18.000000000 -0400
@@ -68,7 +68,8 @@
 		return;
 	}
 
-	err = __raw(master, 1, 0); //Not now, but complain so we now where we failed.
+	/* Not now, but complain so we now where we failed. */
+	err = raw(master);
 	if (err < 0)
 		panic("check_sigio : __raw failed, errno = %d\n", -err);
 
Index: 2.6.9-rc2/arch/um/kernel/user_util.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/user_util.c	2004-09-16 22:59:06.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/user_util.c	2004-09-16 23:14:18.000000000 -0400
@@ -118,35 +118,26 @@
 	}
 }
 
-int __raw(int fd, int complain, int now)
+int raw(int fd)
 {
 	struct termios tt;
 	int err;
-	int when;
 
 	CATCH_EINTR(err = tcgetattr(fd, &tt));
-
 	if (err < 0) {
-		if (complain)
 			printk("tcgetattr failed, errno = %d\n", errno);
 		return(-errno);
 	}
 
 	cfmakeraw(&tt);
 
-	if (now)
-		when = TCSANOW;
-	else
-		when = TCSADRAIN;
-
-	CATCH_EINTR(err = tcsetattr(fd, when, &tt));
-
+ 	CATCH_EINTR(err = tcsetattr(fd, TCSADRAIN, &tt));
 	if (err < 0) {
-		if (complain)
 			printk("tcsetattr failed, errno = %d\n", errno);
 		return(-errno);
 	}
-	/*XXX: tcsetattr could have applied only some changes
+
+	/* XXX tcsetattr could have applied only some changes
 	 * (and cfmakeraw() is a set of changes) */
 	return(0);
 }
More recent patches modify files in raw-cleanup.

