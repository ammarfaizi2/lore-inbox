Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbULND6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbULND6d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 22:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbULND6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 22:58:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21960 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261391AbULND4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 22:56:04 -0500
Date: Mon, 13 Dec 2004 19:56:00 -0800
Message-Id: <200412140356.iBE3u0YB008046@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
X-Fcc: ~/Mail/linus
Subject: [PATCH 2/7] fix posix-timers signals lock order
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Note that releasing the siglock here adds new instances of existing job
control races in the 2.6.10 code.  This issue goes away if you use my
stoprace-fix patch (already in 2.6.10-rc3-mm1).  So it is advised to apply
those signal fixes before using this patch.

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

--- linux-2.6/kernel/signal.c 17 Nov 2004 23:13:14 -0000
+++ linux-2.6/kernel/signal.c 17 Nov 2004 23:14:48 -0000
@@ -564,7 +564,15 @@
 	if ( signr &&
 	     ((info->si_code & __SI_MASK) == __SI_TIMER) &&
 	     info->si_sys_private){
- 		do_schedule_next_timer(info);
+		/*
+		 * Release the siglock to ensure proper locking order
+		 * of timer locks outside of siglocks.  Note, we leave
+		 * irqs disabled here, since the posix-timers code is
+		 * about to disable them again anyway.
+		 */
+		spin_unlock(&tsk->sighand->siglock);
+		do_schedule_next_timer(info);
+		spin_lock(&tsk->sighand->siglock);
 	}
 	return signr;
 }
