Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263110AbVG3TFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263110AbVG3TFi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263115AbVG3TDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:03:34 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:52619 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S263112AbVG3TDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:03:16 -0400
Subject: [patch 3/3] uml: fix SIGWINCH handler race while waiting for signals.
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       bstroesser@fujitsu-siemens.com
From: blaisorblade@yahoo.it
Date: Sat, 30 Jul 2005 21:05:39 +0200
Message-Id: <20050730190539.DA3481AEA0@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

If a SIGWINCH comes in, while winch_thread() isn't waiting
in wait(), winch_thread could miss signals.
It isn't very probable, that anyone will see this causing
trouble, as it would need a very special timing, that a
missed SIGWINCH results in a wrong window size.

So, this is a minor problem. But why not fix, as it can
be done so easy?

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/drivers/chan_user.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff -puN arch/um/drivers/chan_user.c~uml-fix-winch_thread arch/um/drivers/chan_user.c
--- linux-2.6.git/arch/um/drivers/chan_user.c~uml-fix-winch_thread	2005-07-30 18:03:31.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/drivers/chan_user.c	2005-07-30 18:03:31.000000000 +0200
@@ -63,7 +63,7 @@ error:
  *
  * SIGWINCH can't be received synchronously, so you have to set up to receive it
  * as a signal.  That being the case, if you are going to wait for it, it is
- * convenient to sit in a pause() and wait for the signal to bounce you out of
+ * convenient to sit in sigsuspend() and wait for the signal to bounce you out of
  * it (see below for how we make sure to exit only on SIGWINCH).
  */
 
@@ -94,18 +94,19 @@ static int winch_thread(void *arg)
 		       "byte, err = %d\n", -count);
 
 	/* We are not using SIG_IGN on purpose, so don't fix it as I thought to
-	 * do! If using SIG_IGN, the pause() call below would not stop on
+	 * do! If using SIG_IGN, the sigsuspend() call below would not stop on
 	 * SIGWINCH. */
 
 	signal(SIGWINCH, winch_handler);
 	sigfillset(&sigs);
-	sigdelset(&sigs, SIGWINCH);
-	/* Block anything else than SIGWINCH. */
+	/* Block all signals possible. */
 	if(sigprocmask(SIG_SETMASK, &sigs, NULL) < 0){
 		printk("winch_thread : sigprocmask failed, errno = %d\n", 
 		       errno);
 		exit(1);
 	}
+	/* In sigsuspend(), block anything else than SIGWINCH. */
+	sigdelset(&sigs, SIGWINCH);
 
 	if(setsid() < 0){
 		printk("winch_thread : setsid failed, errno = %d\n", errno);
@@ -130,7 +131,7 @@ static int winch_thread(void *arg)
 	while(1){
 		/* This will be interrupted by SIGWINCH only, since other signals
 		 * are blocked.*/
-		pause();
+		sigsuspend(&sigs);
 
 		count = os_write_file(pipe_fd, &c, sizeof(c));
 		if(count != sizeof(c))
_
