Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275382AbTHITR6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 15:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275385AbTHITR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 15:17:58 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:11382 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S275382AbTHITRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 15:17:50 -0400
Date: Sat, 9 Aug 2003 15:17:48 -0400
From: Matt Wilson <msw@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
       Roland McGrath <roland@redhat.com>, manfred@colorfullife,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] zap_other_threads() detaches thread group leader
Message-ID: <20030809151748.B26520@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The change to detach the threads in zap_other_threads() broke the case
where the non-thread-group-leader is the cause of de_thread().  In
this case the group leader will be detached and freed before
switch_exec_pids() is complete and invalid data will be used.
This is a patch that makes sure that the group leader does not get
detached and reaped.

Thought that Ingo or Roland submitted this for me, but since it's
still not in test3 I figured I would send it myself.  Please CC: me on
replies.

Cheers,

Matt
msw@redhat.com

--- linux-2.6.0-test3/kernel/signal.c.zap	2003-08-09 14:58:50.000000000 -0400
+++ linux-2.6.0-test3/kernel/signal.c	2003-08-09 14:59:42.000000000 -0400
@@ -1011,9 +1011,11 @@ void zap_other_threads(struct task_struc
 		 * killed as part of a thread group due to another
 		 * thread doing an execve() or similar. So set the
 		 * exit signal to -1 to allow immediate reaping of
-		 * the process.
+		 * the process.  But don't detach the thread group
+		 * leader.
 		 */
-		t->exit_signal = -1;
+		if (t != p->group_leader)
+			t->exit_signal = -1;
 
 		sigaddset(&t->pending.signal, SIGKILL);
 		rm_from_queue(SIG_KERNEL_STOP_MASK, &t->pending);
