Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbWBGCXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWBGCXV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 21:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWBGCXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 21:23:16 -0500
Received: from [198.99.130.12] ([198.99.130.12]:20459 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964945AbWBGCWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 21:22:55 -0500
Message-Id: <200602070223.k172NxuT009664@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       "Robert Hillen" <robert.hillen@skynet.be>
Subject: [PATCH 4/8] UML - Close TUN/TAP file descriptors
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Feb 2006 21:23:59 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When UML opens a TUN/TAP device, the file descriptor could be copied into
later, long-lived threads, holding the device open even after the interface
is taken down, preventing it from being brought up again.  This patch makes
these descriptors close-on-exec so that they disappear from helper processes,
and adds CLONE_FILES to a UML helper thread so that the descriptors are closed
in the thread when they are closed elsewhere in UML.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/chan_user.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/chan_user.c	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/chan_user.c	2006-02-06 17:35:47.000000000 -0500
@@ -9,6 +9,7 @@
 #include <termios.h>
 #include <string.h>
 #include <signal.h>
+#include <sched.h>
 #include <sys/stat.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
@@ -73,7 +74,6 @@ static void winch_handler(int sig)
 struct winch_data {
 	int pty_fd;
 	int pipe_fd;
-	int close_me;
 };
 
 static int winch_thread(void *arg)
@@ -84,7 +84,6 @@ static int winch_thread(void *arg)
 	int count, err;
 	char c = 1;
 
-	os_close_file(data->close_me);
 	pty_fd = data->pty_fd;
 	pipe_fd = data->pipe_fd;
 	count = os_write_file(pipe_fd, &c, sizeof(c));
@@ -153,15 +152,16 @@ static int winch_tramp(int fd, struct tt
 	}
 
 	data = ((struct winch_data) { .pty_fd 		= fd,
-				      .pipe_fd 		= fds[1],
-				      .close_me 	= fds[0] } );
-	err = run_helper_thread(winch_thread, &data, 0, &stack, 0);
+				      .pipe_fd 		= fds[1] } );
+	/* CLONE_FILES so this thread doesn't hold open files which are open
+	 * now, but later closed.  This is a problem with /dev/net/tun.
+	 */
+	err = run_helper_thread(winch_thread, &data, CLONE_FILES, &stack, 0);
 	if(err < 0){
 		printk("fork of winch_thread failed - errno = %d\n", errno);
 		goto out_close;
 	}
 
-	os_close_file(fds[1]);
 	*fd_out = fds[0];
 	n = os_read_file(fds[0], &c, sizeof(c));
 	if(n != sizeof(c)){
@@ -169,13 +169,12 @@ static int winch_tramp(int fd, struct tt
 		printk("read failed, err = %d\n", -n);
 		printk("fd %d will not support SIGWINCH\n", fd);
                 err = -EINVAL;
-		goto out_close1;
+		goto out_close;
 	}
 	return err ;
 
  out_close:
 	os_close_file(fds[1]);
- out_close1:
 	os_close_file(fds[0]);
  out:
 	return err;
Index: linux-2.6.15/arch/um/os-Linux/drivers/tuntap_user.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/drivers/tuntap_user.c	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/drivers/tuntap_user.c	2006-02-06 17:35:47.000000000 -0500
@@ -122,6 +122,7 @@ static int tuntap_open_tramp(char *gate,
 		return(-EINVAL);
 	}
 	*fd_out = ((int *) CMSG_DATA(cmsg))[0];
+	os_set_exec_close(*fd_out, 1);
 	return(0);
 }
 
@@ -137,7 +138,8 @@ static int tuntap_open(void *data)
 		return(err);
 
 	if(pri->fixed_config){
-		pri->fd = os_open_file("/dev/net/tun", of_rdwr(OPENFLAGS()), 0);
+		pri->fd = os_open_file("/dev/net/tun",
+				       of_cloexec(of_rdwr(OPENFLAGS())), 0);
 		if(pri->fd < 0){
 			printk("Failed to open /dev/net/tun, err = %d\n",
 			       -pri->fd);

