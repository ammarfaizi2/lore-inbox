Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVEZWt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVEZWt7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 18:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVEZWi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 18:38:56 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:27409 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261842AbVEZWgF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 18:36:05 -0400
Message-Id: <200505262230.j4QMUXjF014699@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 6/7] UML - Fix segfault on exit with CONFIG_GCOV
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 26 May 2005 18:30:33 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We need to disable signals on exit in all cases, not just when rebooting.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/kernel/main.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/main.c	2005-05-26 17:16:46.000000000 -0400
+++ linux-2.6.11/arch/um/kernel/main.c	2005-05-26 17:29:27.000000000 -0400
@@ -87,7 +87,7 @@ int main(int argc, char **argv, char **e
 {
 	char **new_argv;
 	sigset_t mask;
-	int ret, i;
+	int ret, i, err;
 
 	/* Enable all signals except SIGIO - in some environments, we can
 	 * enter with some signals blocked
@@ -160,27 +160,29 @@ int main(int argc, char **argv, char **e
 	 */
 	change_sig(SIGPROF, 0);
 
+        /* This signal stuff used to be in the reboot case.  However, 
+         * sometimes a SIGVTALRM can come in when we're halting (reproducably
+         * when writing out gcov information, presumably because that takes
+         * some time) and cause a segfault.
+         */
+
+        /* stop timers and set SIG*ALRM to be ignored */
+        disable_timer();
+        
+        /* disable SIGIO for the fds and set SIGIO to be ignored */
+        err = deactivate_all_fds();
+        if(err)
+                printf("deactivate_all_fds failed, errno = %d\n", -err);
+
+        /* Let any pending signals fire now.  This ensures
+         * that they won't be delivered after the exec, when
+         * they are definitely not expected.
+         */
+        unblock_signals();
+
 	/* Reboot */
 	if(ret){
-		int err;
-
 		printf("\n");
-
-		/* stop timers and set SIG*ALRM to be ignored */
-		disable_timer();
-
-		/* disable SIGIO for the fds and set SIGIO to be ignored */
-		err = deactivate_all_fds();
-		if(err)
-			printf("deactivate_all_fds failed, errno = %d\n",
-			       -err);
-
-		/* Let any pending signals fire now.  This ensures
-		 * that they won't be delivered after the exec, when
-		 * they are definitely not expected.
-		 */
-		unblock_signals();
-
 		execvp(new_argv[0], new_argv);
 		perror("Failed to exec kernel");
 		ret = 1;

