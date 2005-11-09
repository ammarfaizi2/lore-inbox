Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbVKIDW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbVKIDW2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 22:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbVKIDW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 22:22:28 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:30912 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030414AbVKIDW2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 22:22:28 -0500
Date: Tue, 8 Nov 2005 19:22:34 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: akpm@osdl.org, mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, dipankar@hill9.org, wli@holomorphy.com
Subject: [PATCH] tasklist-RCU fix in attach_pid()
Message-ID: <20051109032233.GA3060@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Bug in attach_pid() can result in RCU readers in find_pid() getting
confused if they race with process creation.

Signed-off-by: <paulmck@us.ibm.com>

---

(applies to both 2.6.14-mm1 and -rt)

 pid.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -uprNa -X dontdiff linux-2.6.14-mm1/kernel/pid.c linux-2.6.14-mm1-fix-1/kernel/pid.c
--- linux-2.6.14-mm1/kernel/pid.c	2005-11-08 08:18:55.000000000 -0800
+++ linux-2.6.14-mm1-fix-1/kernel/pid.c	2005-11-08 19:02:35.000000000 -0800
@@ -150,6 +150,7 @@ int fastcall attach_pid(task_t *task, en
 
 	task_pid = &task->pids[type];
 	pid = find_pid(type, nr);
+	task_pid->nr = nr;
 	if (pid == NULL) {
 		INIT_LIST_HEAD(&task_pid->pid_list);
 		hlist_add_head_rcu(&task_pid->pid_chain,
@@ -158,7 +159,6 @@ int fastcall attach_pid(task_t *task, en
 		INIT_HLIST_NODE(&task_pid->pid_chain);
 		list_add_tail_rcu(&task_pid->pid_list, &pid->pid_list);
 	}
-	task_pid->nr = nr;
 
 	return 0;
 }
