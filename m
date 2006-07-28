Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbWG1DHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbWG1DHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 23:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbWG1DHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 23:07:08 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:56042 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932567AbWG1DGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 23:06:55 -0400
Message-Id: <200607280306.k6S36SYl007946@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 6/7] UML - Fix handling of failed execs of helpers
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Jul 2006 23:06:28 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There were some bugs in handling failures to exec helper programs.
errno was passed back from the child with the wrong sign.  It was also
ignored.  In the case where it mattered, the errno from the
(successful) read in the parent was used instead.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/os-Linux/helper.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/helper.c	2006-07-13 15:32:08.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/helper.c	2006-07-14 10:19:35.000000000 -0400
@@ -42,7 +42,7 @@ static int helper_child(void *arg)
 	if(data->pre_exec != NULL)
 		(*data->pre_exec)(data->pre_data);
 	execvp(argv[0], argv);
-	errval = errno;
+	errval = -errno;
 	printk("helper_child - execve of '%s' failed - errno = %d\n", argv[0], errno);
 	os_write_file(data->fd, &errval, sizeof(errval));
 	kill(os_getpid(), SIGKILL);
@@ -62,7 +62,7 @@ int run_helper(void (*pre_exec)(void *),
 		stack = *stack_out;
 	else stack = alloc_stack(0, __cant_sleep());
 	if(stack == 0)
-		return(-ENOMEM);
+		return -ENOMEM;
 
 	ret = os_pipe(fds, 1, 0);
 	if(ret < 0){
@@ -95,16 +95,16 @@ int run_helper(void (*pre_exec)(void *),
 	/* Read the errno value from the child, if the exec failed, or get 0 if
 	 * the exec succeeded because the pipe fd was set as close-on-exec. */
 	n = os_read_file(fds[0], &ret, sizeof(ret));
-	if (n < 0) {
-		printk("run_helper : read on pipe failed, ret = %d\n", -n);
-		ret = n;
-		kill(pid, SIGKILL);
-		CATCH_EINTR(waitpid(pid, NULL, 0));
-	} else if(n != 0){
-		CATCH_EINTR(n = waitpid(pid, NULL, 0));
-		ret = -errno;
-	} else {
+	if(n == 0)
 		ret = pid;
+	else {
+		if(n < 0){
+			printk("run_helper : read on pipe failed, ret = %d\n", 
+			       -n);
+			ret = n;
+			kill(pid, SIGKILL);
+		}
+		CATCH_EINTR(waitpid(pid, NULL, 0));
 	}
 
 out_close:

