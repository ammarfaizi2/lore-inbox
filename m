Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbVC3Swi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbVC3Swi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVC3Swf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:52:35 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:23475 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S262393AbVC3SvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:51:23 -0500
Subject: [patch 1/8] uml: fix sigio spinlock [for 2.6.12]
To: torvalds@osdl.org
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Wed, 30 Mar 2005 19:33:41 +0200
Message-Id: <20050330173341.41F25EFED3@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just saw a "take twice spinlock" deadlock with the Spinlock debugging
enabled on this lock, and static code analysis revealed this is the culprit:
update_thread can take (in an error path) the sigio_lock, which is already
held by all its callers (it's a static function, so it's easy to verify).

Added some comments to mark where this function needs the lock, in case
someone wants to reduce the locking here.

Also clean an exitcall to mark the thread as killed (won't hurt, and could
be useful if things go wrong).

As a bonus, some CodingStyle cleanups.

This should go in 2.6.12 for its simplicity and usefulness.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/sigio_user.c |   29 ++++++++++---------------
 1 files changed, 12 insertions(+), 17 deletions(-)

diff -puN arch/um/kernel/sigio_user.c~uml-fix-sigio-spinlock arch/um/kernel/sigio_user.c
--- linux-2.6.11/arch/um/kernel/sigio_user.c~uml-fix-sigio-spinlock	2005-03-24 11:37:00.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/sigio_user.c	2005-03-24 11:37:00.000000000 +0100
@@ -108,12 +108,14 @@ static void tty_output(int master, int s
 		panic("check_sigio : write failed, errno = %d\n", errno);
 	while(((n = os_read_file(slave, buf, sizeof(buf))) > 0) && !got_sigio) ;
 
-	if(got_sigio){
+	if (got_sigio) {
 		printk("Yes\n");
 		pty_output_sigio = 1;
+	} else if (n == -EAGAIN) {
+		printk("No, enabling workaround\n");
+	} else {
+		panic("check_sigio : read failed, err = %d\n", n);
 	}
-	else if(n == -EAGAIN) printk("No, enabling workaround\n");
-	else panic("check_sigio : read failed, err = %d\n", n);
 }
 
 static void tty_close(int master, int slave)
@@ -235,6 +237,8 @@ static int need_poll(int n)
 	return(0);
 }
 
+/* Must be called with sigio_lock held, because it's needed by the marked
+ * critical section. */
 static void update_thread(void)
 {
 	unsigned long flags;
@@ -257,7 +261,7 @@ static void update_thread(void)
 	set_signals(flags);
 	return;
  fail:
-	sigio_lock();
+	/* Critical section start */
 	if(write_sigio_pid != -1) 
 		os_kill_process(write_sigio_pid, 1);
 	write_sigio_pid = -1;
@@ -265,7 +269,7 @@ static void update_thread(void)
 	os_close_file(sigio_private[1]);
 	os_close_file(write_sigio_fds[0]);
 	os_close_file(write_sigio_fds[1]);
-	sigio_unlock();
+	/* Critical section end */
 	set_signals(flags);
 }
 
@@ -418,19 +422,10 @@ int read_sigio_fd(int fd)
 
 static void sigio_cleanup(void)
 {
-	if(write_sigio_pid != -1)
+	if (write_sigio_pid != -1) {
 		os_kill_process(write_sigio_pid, 1);
+		write_sigio_pid = -1;
+	}
 }
 
 __uml_exitcall(sigio_cleanup);
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
_
