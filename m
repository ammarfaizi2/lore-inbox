Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWHUStS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWHUStS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWHUStH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:49:07 -0400
Received: from ns1.suse.de ([195.135.220.2]:43654 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750760AbWHUSsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:48:42 -0400
Date: Mon, 21 Aug 2006 11:47:02 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, dev@openvz.org,
       haveblue@us.ibm.com, dev@sw.ru, oleg@tv-sign.ru,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 11/20] sys_getppid oopses on debug kernel
Message-ID: <20060821184702.GL21938@kroah.com>
References: <20060821183818.155091391@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sys_getppid-oopses-on-debug-kernel.patch"
In-Reply-To: <20060821184527.GA21938@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Kirill Korotaev <dev@sw.ru>

sys_getppid() optimization can access a freed memory.  On kernels with
DEBUG_SLAB turned ON, this results in Oops.  As Dave Hansen noted, this
optimization is also unsafe for memory hotplug.

So this patch always takes the lock to be safe.

[oleg@tv-sign.ru: simplifications]

Signed-off-by: Kirill Korotaev <dev@openvz.org>
Cc: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 kernel/timer.c |   41 +++++++----------------------------------
 1 file changed, 7 insertions(+), 34 deletions(-)

--- linux-2.6.17.9.orig/kernel/timer.c
+++ linux-2.6.17.9/kernel/timer.c
@@ -975,46 +975,19 @@ asmlinkage long sys_getpid(void)
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
-	struct task_struct *me = current;
-	struct task_struct *parent;
 
-	parent = me->group_leader->real_parent;
-	for (;;) {
-		pid = parent->tgid;
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
-{
-		struct task_struct *old = parent;
+	rcu_read_lock();
+	pid = rcu_dereference(current->real_parent)->tgid;
+	rcu_read_unlock();
 
-		/*
-		 * Make sure we read the pid before re-reading the
-		 * parent pointer:
-		 */
-		smp_rmb();
-		parent = me->group_leader->real_parent;
-		if (old != parent)
-			continue;
-}
-#endif
-		break;
-	}
 	return pid;
 }
 

--
