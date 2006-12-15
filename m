Return-Path: <linux-kernel-owner+w=401wt.eu-S1751741AbWLOA04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbWLOA04 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbWLOA0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:26:55 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:48308 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbWLOAXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:23:45 -0500
Message-Id: <20061215000819.552275000@us.ibm.com>
References: <20061215000754.764718000@us.ibm.com>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 16:08:01 -0800
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
       Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
       Paul Jackson <pj@sgi.com>
Subject: Register lockdep task watcher
Content-Disposition: inline; filename=task-watchers-register-lockdep
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Register a task watcher for lockdep instead of hooking into copy_process().

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
---
 kernel/fork.c    |    5 -----
 kernel/lockdep.c |   11 +++++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

Index: linux-2.6.19/kernel/fork.c
===================================================================
--- linux-2.6.19.orig/kernel/fork.c
+++ linux-2.6.19/kernel/fork.c
@@ -1059,15 +1059,10 @@ static struct task_struct *copy_process(
 		p->tgid = current->tgid;
 
 	retval = notify_task_watchers(WATCH_TASK_INIT, clone_flags, p);
 	if (retval < 0)
 		goto bad_fork_cleanup_delays_binfmt;
-#ifdef CONFIG_LOCKDEP
-	p->lockdep_depth = 0; /* no locks held yet */
-	p->curr_chain_key = 0;
-	p->lockdep_recursion = 0;
-#endif
 
 #ifdef CONFIG_DEBUG_MUTEXES
 	p->blocked_on = NULL; /* not blocked yet */
 #endif
 
Index: linux-2.6.19/kernel/lockdep.c
===================================================================
--- linux-2.6.19.orig/kernel/lockdep.c
+++ linux-2.6.19/kernel/lockdep.c
@@ -25,10 +25,11 @@
  * mapping lock dependencies runtime.
  */
 #include <linux/mutex.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
+#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/kallsyms.h>
@@ -2557,10 +2558,20 @@ void __init lockdep_init(void)
 		INIT_LIST_HEAD(chainhash_table + i);
 
 	lockdep_initialized = 1;
 }
 
+static int __task_init init_task_lockdep(unsigned long clone_flags,
+					 struct task_struct *p)
+{
+	p->lockdep_depth = 0; /* no locks held yet */
+	p->curr_chain_key = 0;
+	p->lockdep_recursion = 0;
+	return 0;
+}
+DEFINE_TASK_INITCALL(init_task_lockdep);
+
 void __init lockdep_info(void)
 {
 	printk("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
 
 	printk("... MAX_LOCKDEP_SUBCLASSES:    %lu\n", MAX_LOCKDEP_SUBCLASSES);

--
