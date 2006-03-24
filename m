Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWCXSOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWCXSOB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWCXSN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:13:58 -0500
Received: from [198.99.130.12] ([198.99.130.12]:47510 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751377AbWCXSNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:13:48 -0500
Message-Id: <200603241815.k2OIF5lw005570@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Blaisorblade <blaisorblade@yahoo.it>
Subject: [PATCH 15/16] UML - Fix thread startup race
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Mar 2006 13:15:05 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a race in the starting of write_sigio_thread.
Previously, some of the data needed by the thread was initialized
after the clone.  If the thread ran immediately, it would see the
uninitialized data, including an empty pollfds, which would cause it
to hang.
We move the data initialization to before the clone, and adjust the
error paths and cleanup accordingly.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/os-Linux/sigio.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/sigio.c	2006-03-23 18:55:38.000000000 -0500
+++ linux-2.6.16/arch/um/os-Linux/sigio.c	2006-03-23 21:10:27.000000000 -0500
@@ -29,8 +29,10 @@ static int write_sigio_pid = -1;
  * the descriptors closed after it is killed.  So, it can't see them change.
  * On the UML side, they are changed under the sigio_lock.
  */
-static int write_sigio_fds[2] = { -1, -1 };
-static int sigio_private[2] = { -1, -1 };
+#define SIGIO_FDS_INIT {-1, -1}
+
+static int write_sigio_fds[2] = SIGIO_FDS_INIT;
+static int sigio_private[2] = SIGIO_FDS_INIT;
 
 struct pollfds {
 	struct pollfd *poll;
@@ -270,49 +272,46 @@ void write_sigio_workaround(void)
 	/* Did we race? Don't try to optimize this, please, it's not so likely
 	 * to happen, and no more than once at the boot. */
 	if(write_sigio_pid != -1)
-		goto out_unlock;
-
-	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL,
-					    CLONE_FILES | CLONE_VM, &stack, 0);
+		goto out_free;
 
-	if (write_sigio_pid < 0)
-		goto out_clear;
+	current_poll = ((struct pollfds) { .poll 	= p,
+					   .used 	= 1,
+					   .size 	= 1 });
 
 	if (write_sigio_irq(l_write_sigio_fds[0]))
-		goto out_kill;
+		goto out_clear_poll;
 
-	/* Success, finally. */
 	memcpy(write_sigio_fds, l_write_sigio_fds, sizeof(l_write_sigio_fds));
 	memcpy(sigio_private, l_sigio_private, sizeof(l_sigio_private));
 
-	current_poll = ((struct pollfds) { .poll 	= p,
-					   .used 	= 1,
-					   .size 	= 1 });
+	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL,
+					    CLONE_FILES | CLONE_VM, &stack, 0);
 
-	sigio_unlock();
-	return;
+	if (write_sigio_pid < 0)
+		goto out_clear;
 
- out_kill:
-	l_write_sigio_pid = write_sigio_pid;
-	write_sigio_pid = -1;
 	sigio_unlock();
-	/* Going to call waitpid, avoid holding the lock. */
-	os_kill_process(l_write_sigio_pid, 1);
-	goto out_free;
+	return;
 
- out_clear:
+out_clear:
 	write_sigio_pid = -1;
- out_unlock:
-	sigio_unlock();
- out_free:
+	write_sigio_fds[0] = -1;
+	write_sigio_fds[1] = -1;
+	sigio_private[0] = -1;
+	sigio_private[1] = -1;
+out_clear_poll:
+	current_poll = ((struct pollfds) { .poll	= NULL,
+					   .size	= 0,
+					   .used	= 0 });
+out_free:
 	kfree(p);
- out_close2:
+	sigio_unlock();
+out_close2:
 	close(l_sigio_private[0]);
 	close(l_sigio_private[1]);
- out_close1:
+out_close1:
 	close(l_write_sigio_fds[0]);
 	close(l_write_sigio_fds[1]);
-	return;
 }
 
 void sigio_cleanup(void)

