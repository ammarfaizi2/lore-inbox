Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbTJGSeK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 14:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbTJGSeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 14:34:10 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:10923 "EHLO
	mwinf0302.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262647AbTJGSd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 14:33:58 -0400
Subject: [PATCH] kupdated signal handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
Content-Type: text/plain
Message-Id: <1065551422.31281.32.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 07 Oct 2003 20:33:29 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the fix to the problem we have been discussing...

===== fs/buffer.c 1.80 vs edited =====
--- 1.80/fs/buffer.c	Sat Sep 13 20:09:44 2003
+++ edited/fs/buffer.c	Wed Oct  1 11:27:07 2003
@@ -3068,13 +3068,13 @@
 		remove_wait_queue(&kupdate_wait, &wait);
 		/* check for sigstop */
 		if (signal_pending(tsk)) {
-			int stopped = 0;
+			int sig, stopped = 0;
+			struct siginfo info;
+
 			spin_lock_irq(&tsk->sigmask_lock);
-			if (sigismember(&tsk->pending.signal, SIGSTOP)) {
-				sigdelset(&tsk->pending.signal, SIGSTOP);
+			sig = dequeue_signal(&current->blocked, &info);
+			if (sig == SIGSTOP)
 				stopped = 1;
-			}
-			recalc_sigpending(tsk);
 			spin_unlock_irq(&tsk->sigmask_lock);
 			if (stopped) {
 				tsk->state = TASK_STOPPED;


