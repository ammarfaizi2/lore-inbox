Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWDFSJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWDFSJY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 14:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWDFSJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 14:09:23 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:23960 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932151AbWDFSJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 14:09:22 -0400
Date: Fri, 7 Apr 2006 02:06:28 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] coredump: speedup SIGKILL sending
Message-ID: <20060406220628.GA237@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch a thread group is killed atomically under ->siglock.
This is faster because we can use sigaddset() instead of force_sig_info()
and this is used in further patches.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- rc1/fs/exec.c~2_KILL	2006-04-06 15:10:28.000000000 +0400
+++ rc1/fs/exec.c	2006-04-06 15:19:33.000000000 +0400
@@ -1387,17 +1387,24 @@ static void format_corename(char *corena
 static void zap_process(struct task_struct *start, int *ptraced)
 {
 	struct task_struct *t;
+	unsigned long flags;
+
+	spin_lock_irqsave(&start->sighand->siglock, flags);
 
 	t = start;
 	do {
 		if (t != current && t->mm) {
 			t->mm->core_waiters++;
-			force_sig_specific(SIGKILL, t);
+			sigaddset(&t->pending.signal, SIGKILL);
+			signal_wake_up(t, 1);
+
 			if (unlikely(t->ptrace) &&
 			    unlikely(t->parent->mm == t->mm))
 				*ptraced = 1;
 		}
 	} while ((t = next_thread(t)) != start);
+
+	spin_unlock_irqrestore(&start->sighand->siglock, flags);
 }
 
 static void zap_threads (struct mm_struct *mm)

