Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVAWXZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVAWXZo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 18:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVAWXZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 18:25:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52117 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261376AbVAWXYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 18:24:49 -0500
Date: Sun, 23 Jan 2005 15:24:40 -0800
Message-Id: <200501232324.j0NNOebO006488@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Cc: Christoph Lameter <clameter@sgi.com>
Cc: Ulrich Drepper <drepper@redhat.com>
Subject: [PATCH 3/7] posix-timers: fix posix-timers signals lock order
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The posix-timers code establishes the locking order that k_itimer locks are
outside siglocks.  However, when the signal code calls back into the
posix-timers code to reload a timer after its signal is dequeued, it holds
a siglock while calling do_schedule_next_timer, which gets a timer lock.

I'm not sure there is any deadlock scenario possible using the real-time
POSIX timers, because of the intricate arrangement of timer firing and
resetting synchronization.  But with the new CPU timers code, this deadlock
pops up right away.  Dropping the siglock here certainly doesn't hurt in
the real-time timer cases, and it really seems like the right thing here to
keep the locking details in the interface between signals and posix-timers
code comprehensible.


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/kernel/signal.c
+++ linux-2.6/kernel/signal.c
@@ -564,7 +564,15 @@ int dequeue_signal(struct task_struct *t
 	if ( signr &&
 	     ((info->si_code & __SI_MASK) == __SI_TIMER) &&
 	     info->si_sys_private){
+		/*
+		 * Release the siglock to ensure proper locking order
+		 * of timer locks outside of siglocks.  Note, we leave
+		 * irqs disabled here, since the posix-timers code is
+		 * about to disable them again anyway.
+		 */
+		spin_unlock(&tsk->sighand->siglock);
 		do_schedule_next_timer(info);
+		spin_lock(&tsk->sighand->siglock);
 	}
 	return signr;
 }
