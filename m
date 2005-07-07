Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVGGIsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVGGIsO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 04:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVGGIpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 04:45:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23528 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261263AbVGGIpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 04:45:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] reset real_timer target on exec leader change
In-Reply-To: Andrew Morton's message of  Wednesday, 6 July 2005 00:28:24 -0700 <20050706002824.5fd79887.akpm@osdl.org>
Emacs: well, why *shouldn't* you pay property taxes on your editor?
Message-Id: <20050707084517.6D0C6180985@magilla.sf.frob.com>
Date: Thu,  7 Jul 2005 01:45:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When a noninitial thread does exec, it becomes the new group leader.  If
there is a ITIMER_REAL timer running, it points at the old group leader and
when it fires it can follow a stale pointer.  The timer data needs to be
reset to point at the exec'ing thread that is becoming the group leader.
This has to synchronize with any concurrent firing of the timer to make
sure that it_real_fn can never run when the data points to a thread that
might have been reaped already.


Signed-off-by: Roland McGrath <roland@redhat.com>

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -642,6 +642,19 @@ static inline int de_thread(struct task_
 	count = 2;
 	if (thread_group_leader(current))
 		count = 1;
+	else {
+		/*
+		 * The SIGALRM timer survives the exec, but needs to point
+		 * at us as the new group leader now.  We have a race with
+		 * a timer firing now getting the old leader, so we need to
+		 * synchronize with any firing (by calling del_timer_sync)
+		 * before we can safely let the old group leader die.
+		 */
+		sig->real_timer.data = (unsigned long) current;
+		if (del_timer_sync(&sig->real_timer)) {
+			add_timer(&sig->real_timer);
+		}
+	}
 	while (atomic_read(&sig->count) > count) {
 		sig->group_exit_task = current;
 		sig->notify_count = count;
