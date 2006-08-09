Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWHIOAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWHIOAi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 10:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWHIOAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 10:00:38 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:52903 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1750855AbWHIOAh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 10:00:37 -0400
Date: Wed, 9 Aug 2006 22:24:13 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] sys_getppid-oopses-on-debug-kernel-v2-simplify
Message-ID: <20060809182413.GA1205@oleg>
References: <20060809143816.GA142@oleg> <44D9D03B.6060907@sw.ru> <20060809165441.GA187@oleg> <44D9DCFF.2080400@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D9DCFF.2080400@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On top of Kirill's sys_getppid-oopses-on-debug-kernel-v2.patch

- We don't need ->group_leader->real_parent, all threads should
  have the same ->real_parent.

- We don't need tasklist_lock, task_struct is freed by RCU, so
  rcu_read_lock() should be enough.

(Compile tested)

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc3/kernel/timer.c~	2006-08-09 22:08:51.000000000 +0400
+++ 2.6.18-rc3/kernel/timer.c	2006-08-09 22:15:35.000000000 +0400
@@ -1324,28 +1324,18 @@ asmlinkage long sys_getpid(void)
 }
 
 /*
- * Accessing ->group_leader->real_parent is not SMP-safe, it could
- * change from under us. However, rather than getting any lock
- * we can use an optimistic algorithm: get the parent
- * pid, and go back and check that the parent is still
- * the same. If it has changed (which is extremely unlikely
- * indeed), we just try again..
- *
- * NOTE! This depends on the fact that even if we _do_
- * get an old value of "parent", we can happily dereference
- * the pointer (it was and remains a dereferencable kernel pointer
- * no matter what): we just can't necessarily trust the result
- * until we know that the parent pointer is valid.
- *
- * NOTE2: ->group_leader never changes from under us.
+ * Accessing ->real_parent is not SMP-safe, it could
+ * change from under us. However, we can use a stale
+ * value of ->real_parent under rcu_read_lock(), see
+ * release_task()->call_rcu(delayed_put_task_struct).
  */
 asmlinkage long sys_getppid(void)
 {
 	int pid;
 
-	read_lock(&tasklist_lock);
-	pid = current->group_leader->real_parent->tgid;
-	read_unlock(&tasklist_lock);
+	rcu_read_lock();
+	pid = rcu_dereference(current->real_parent)->tgid;
+	rcu_read_unlock();
 
 	return pid;
 }

