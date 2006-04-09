Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWDHUO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWDHUO7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 16:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWDHUOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 16:14:46 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:20379 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S965031AbWDHUOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 16:14:23 -0400
Date: Sun, 9 Apr 2006 04:11:30 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH rc1-mm 3/3] coredump: copy_process: don't check SIGNAL_GROUP_EXIT
Message-ID: <20060409001130.GA104@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After the previous patch SIGNAL_GROUP_EXIT implies a pending SIGKILL,
we can remove this check from copy_process() because we already checked
!signal_pending().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/kernel/fork.c~3_fork	2006-03-23 22:59:33.000000000 +0300
+++ MM/kernel/fork.c	2006-04-09 03:17:12.000000000 +0400
@@ -1157,18 +1157,6 @@ static task_t *copy_process(unsigned lon
 	}
 
 	if (clone_flags & CLONE_THREAD) {
-		/*
-		 * Important: if an exit-all has been started then
-		 * do not create this new thread - the whole thread
-		 * group is supposed to exit anyway.
-		 */
-		if (current->signal->flags & SIGNAL_GROUP_EXIT) {
-			spin_unlock(&current->sighand->siglock);
-			write_unlock_irq(&tasklist_lock);
-			retval = -EAGAIN;
-			goto bad_fork_cleanup_namespace;
-		}
-
 		p->group_leader = current->group_leader;
 		list_add_tail_rcu(&p->thread_group, &p->group_leader->thread_group);
 

