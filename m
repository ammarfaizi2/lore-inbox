Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWI2CPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWI2CPL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161270AbWI2CNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:13:14 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:1199 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751348AbWI2CNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:13:04 -0400
Message-Id: <20060929021301.675685000@us.ibm.com>
References: <20060929020232.756637000@us.ibm.com>
User-Agent: quilt/0.45-1
Date: Thu, 28 Sep 2006 19:02:40 -0700
From: Matt Helsley <matthltc@us.ibm.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       John T Kohl <jtk@us.ibm.com>, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@zeniv.linux.org.uk>, Steve Grubb <sgrubb@redhat.com>,
       linux-audit@redhat.com, Paul Jackson <pj@sgi.com>
Subject: [RFC][PATCH 08/10] Task watchers v2 Register lockdep task watcher
Content-Disposition: inline; filename=task-watchers-register-lockdep
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Register a task watcher for lockdep instead of hooking into copy_process().

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
---
 kernel/fork.c    |    5 -----
 kernel/lockdep.c |    9 +++++++++
 2 files changed, 9 insertions(+), 5 deletions(-)

Index: linux-2.6.18-mm1/kernel/fork.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/fork.c
+++ linux-2.6.18-mm1/kernel/fork.c
@@ -1058,15 +1058,10 @@ static struct task_struct *copy_process(
 		p->tgid = current->tgid;
 
 	retval = notify_task_watchers(WATCH_TASK_INIT, clone_flags, p);
 	if (retval < 0)
 		goto bad_fork_cleanup_delays_binfmt;
-#ifdef CONFIG_LOCKDEP
-	p->lockdep_depth = 0; /* no locks held yet */
-	p->curr_chain_key = 0;
-	p->lockdep_recursion = 0;
-#endif
 
 	rt_mutex_init_task(p);
 
 #ifdef CONFIG_DEBUG_MUTEXES
 	p->blocked_on = NULL; /* not blocked yet */
Index: linux-2.6.18-mm1/kernel/lockdep.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/lockdep.c
+++ linux-2.6.18-mm1/kernel/lockdep.c
@@ -2555,10 +2555,19 @@ void __init lockdep_init(void)
 		INIT_LIST_HEAD(chainhash_table + i);
 
 	lockdep_initialized = 1;
 }
 
+static int init_task_lockdep(unsigned long clone_flags, struct task_struct *p)
+{
+	p->lockdep_depth = 0; /* no locks held yet */
+	p->curr_chain_key = 0;
+	p->lockdep_recursion = 0;
+	return 0;
+}
+task_watcher_func(init, init_task_lockdep);
+
 void __init lockdep_info(void)
 {
 	printk("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
 
 	printk("... MAX_LOCKDEP_SUBCLASSES:    %lu\n", MAX_LOCKDEP_SUBCLASSES);

--
