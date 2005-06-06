Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVFFUPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVFFUPf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVFFUPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 16:15:05 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:58884 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261651AbVFFUNb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 16:13:31 -0400
Message-Id: <200506062008.j56K8BKG008967@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 5/5] UML - clean up error path
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Jun 2005 16:08:11 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This cleans an error path which used to leak file descriptors by returning
without trying to tidy up.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/drivers/chan_user.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/chan_user.c	2005-06-02 17:04:11.000000000 -0400
+++ linux-2.6.12-rc/arch/um/drivers/chan_user.c	2005-06-03 17:46:17.000000000 -0400
@@ -143,22 +143,22 @@ static int winch_tramp(int fd, struct tt
 {
 	struct winch_data data;
 	unsigned long stack;
-	int fds[2], pid, n, err;
+	int fds[2], n, err;
 	char c;
 
 	err = os_pipe(fds, 1, 1);
 	if(err < 0){
 		printk("winch_tramp : os_pipe failed, err = %d\n", -err);
-		return(err);
+		goto out;
 	}
 
 	data = ((struct winch_data) { .pty_fd 		= fd,
 				      .pipe_fd 		= fds[1],
 				      .close_me 	= fds[0] } );
-	pid = run_helper_thread(winch_thread, &data, 0, &stack, 0);
-	if(pid < 0){
+	err = run_helper_thread(winch_thread, &data, 0, &stack, 0);
+	if(err < 0){
 		printk("fork of winch_thread failed - errno = %d\n", errno);
-		return(pid);
+		goto out_close;
 	}
 
 	os_close_file(fds[1]);
@@ -168,14 +168,22 @@ static int winch_tramp(int fd, struct tt
 		printk("winch_tramp : failed to read synchronization byte\n");
 		printk("read failed, err = %d\n", -n);
 		printk("fd %d will not support SIGWINCH\n", fd);
-                pid = -1;
+                err = -EINVAL;
+		goto out_close1;
 	}
-	return(pid);
+	return err ;
+
+ out_close:
+	os_close_file(fds[1]);
+ out_close1:
+	os_close_file(fds[0]);
+ out:
+	return err;
 }
 
 void register_winch(int fd, struct tty_struct *tty)
 {
-	int pid, thread, thread_fd;
+	int pid, thread, thread_fd = -1;
 	int count;
 	char c = 1;
 

