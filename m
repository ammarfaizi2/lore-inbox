Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbWHUMmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbWHUMmi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbWHUMmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:42:37 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:24281 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S965090AbWHUMmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:42:36 -0400
Date: Mon, 21 Aug 2006 21:06:38 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] sys_get_robust_list: don't take tasklist_lock
Message-ID: <20060821170638.GA1646@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

use rcu locks for find_task_by_pid().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/kernel/futex.c~3_sgrl	2006-08-21 20:41:15.000000000 +0400
+++ 2.6.18-rc4/kernel/futex.c	2006-08-21 20:59:24.000000000 +0400
@@ -1682,7 +1682,7 @@ sys_get_robust_list(int pid, struct robu
 		struct task_struct *p;
 
 		ret = -ESRCH;
-		read_lock(&tasklist_lock);
+		rcu_read_lock();
 		p = find_task_by_pid(pid);
 		if (!p)
 			goto err_unlock;
@@ -1691,7 +1691,7 @@ sys_get_robust_list(int pid, struct robu
 				!capable(CAP_SYS_PTRACE))
 			goto err_unlock;
 		head = p->robust_list;
-		read_unlock(&tasklist_lock);
+		rcu_read_unlock();
 	}
 
 	if (put_user(sizeof(*head), len_ptr))
@@ -1699,7 +1699,7 @@ sys_get_robust_list(int pid, struct robu
 	return put_user(head, head_ptr);
 
 err_unlock:
-	read_unlock(&tasklist_lock);
+	rcu_read_unlock();
 
 	return ret;
 }

