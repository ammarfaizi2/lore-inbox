Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVAMPbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVAMPbH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 10:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVAMPbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 10:31:07 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:51972 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261650AbVAMPbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 10:31:01 -0500
Subject: [patch 6/8] uml: commentary about SIGWINCH handling for consoles
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 13 Jan 2005 06:13:36 +0100
Message-Id: <20050113051337.15EB863253@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>, Jeff Dike <jdike@addtoit.com>

Explain what happens inside the SIGWINCH handler - it's non-obvious enough
that the correct code seemed me to need a cleanup (which was indeed buggy).
More info in the comments themselves.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/drivers/chan_user.c |   29 +++++++++++++++++++++++++
 1 files changed, 29 insertions(+)

diff -puN arch/um/drivers/chan_user.c~uml-explain-sigwinch-handling arch/um/drivers/chan_user.c
--- linux-2.6.11/arch/um/drivers/chan_user.c~uml-explain-sigwinch-handling	2005-01-13 01:59:27.652856248 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/chan_user.c	2005-01-13 01:59:27.654855944 +0100
@@ -49,6 +49,24 @@ error:
 	return(-errno);
 }
 
+/*
+ * UML SIGWINCH handling
+ *
+ * The point of this is to handle SIGWINCH on consoles which have host ttys and
+ * relay them inside UML to whatever might be running on the console and cares
+ * about the window size (since SIGWINCH notifies about terminal size changes).
+ *
+ * So, we have a separate thread for each host tty attached to a UML device
+ * (side-issue - I'm annoyed that one thread can't have multiple controlling
+ * ttys for purposed of handling SIGWINCH, but I imagine there are other reasons
+ * that doesn't make any sense).
+ *
+ * SIGWINCH can't be received synchronously, so you have to set up to receive it
+ * as a signal.  That being the case, if you are going to wait for it, it is
+ * convenient to sit in a pause() and wait for the signal to bounce you out of
+ * it (see below for how we make sure to exit only on SIGWINCH).
+ */
+
 static void winch_handler(int sig)
 {
 }
@@ -75,9 +93,14 @@ static int winch_thread(void *arg)
 		printk("winch_thread : failed to write synchronization "
 		       "byte, err = %d\n", -count);
 
+	/* We are not using SIG_IGN on purpose, so don't fix it as I thought to
+	 * do! If using SIG_IGN, the pause() call below would not stop on
+	 * SIGWINCH. */
+
 	signal(SIGWINCH, winch_handler);
 	sigfillset(&sigs);
 	sigdelset(&sigs, SIGWINCH);
+	/* Block anything else than SIGWINCH. */
 	if(sigprocmask(SIG_SETMASK, &sigs, NULL) < 0){
 		printk("winch_thread : sigprocmask failed, errno = %d\n", 
 		       errno);
@@ -95,12 +118,18 @@ static int winch_thread(void *arg)
 		exit(1);
 	}
 
+	/* These are synchronization calls between various UML threads on the
+	 * host - since they are not different kernel threads, we cannot use
+	 * kernel semaphores. We don't use SysV semaphores because they are
+	 * persistant. */
 	count = os_read_file(pipe_fd, &c, sizeof(c));
 	if(count != sizeof(c))
 		printk("winch_thread : failed to read synchronization byte, "
 		       "err = %d\n", -count);
 
 	while(1){
+		/* This will be interrupted by SIGWINCH only, since other signals
+		 * are blocked.*/
 		pause();
 
 		count = os_write_file(pipe_fd, &c, sizeof(c));
_
