Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275094AbTHLHwa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 03:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275095AbTHLHwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 03:52:30 -0400
Received: from mail15.speakeasy.net ([216.254.0.215]:18610 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S275094AbTHLHw3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 03:52:29 -0400
Date: Tue, 12 Aug 2003 00:52:26 -0700
Message-Id: <200308120752.h7C7qQT20085@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Matt Wilson <msw@redhat.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH] revert zap_other_threads breakage, disallow CLONE_THREAD without CLONE_DETACHED
In-Reply-To: Roland McGrath's message of  Tuesday, 12 August 2003 00:40:52 -0700 <200308120740.h7C7eqV20032@magilla.sf.frob.com>
X-Fcc: ~/Mail/linus
X-Windows: sometimes you fill a vacuum and it still sucks.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply this patch to get us back out of this useless quagmire and
disallow the problematic case that noone wants to try to use any more.


Thanks,
Roland


--- linux/kernel/fork.c	18 Jul 2003 16:27:39 -0000	1.142
+++ linux/kernel/fork.c	12 Aug 2003 06:20:05 -0000
@@ -744,7 +749,8 @@ struct task_struct *copy_process(unsigne
 	 * Thread groups must share signals as well, and detached threads
 	 * can only be started up within the thread group.
 	 */
-	if ((clone_flags & CLONE_THREAD) && !(clone_flags & CLONE_SIGHAND))
+	if ((clone_flags & CLONE_THREAD) &&
+	    (clone_flags & (CLONE_SIGHAND|CLONE_DETACHED)) != (CLONE_SIGHAND|CLONE_DETACHED))
 		return ERR_PTR(-EINVAL);
 	if ((clone_flags & CLONE_DETACHED) && !(clone_flags & CLONE_THREAD))
 		return ERR_PTR(-EINVAL);
--- linux/kernel/signal.c	7 Aug 2003 20:06:12 -0000	1.98
+++ linux/kernel/signal.c	12 Aug 2003 06:18:34 -0000
@@ -1005,16 +1016,6 @@ void zap_other_threads(struct task_struc
 		 */
 		if (t->state & (TASK_ZOMBIE|TASK_DEAD))
 			continue;
-
-		/*
-		 * We don't want to notify the parent, since we are
-		 * killed as part of a thread group due to another
-		 * thread doing an execve() or similar. So set the
-		 * exit signal to -1 to allow immediate reaping of
-		 * the process.
-		 */
-		t->exit_signal = -1;
-
 		sigaddset(&t->pending.signal, SIGKILL);
 		rm_from_queue(SIG_KERNEL_STOP_MASK, &t->pending);
 		signal_wake_up(t, 1);
