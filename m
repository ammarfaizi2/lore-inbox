Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753084AbWKCE21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbWKCE21 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 23:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753085AbWKCE17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 23:27:59 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:32170 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1753088AbWKCE1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 23:27:53 -0500
Message-Id: <20061103042750.245853000@us.ibm.com>
References: <20061103042257.274316000@us.ibm.com>
User-Agent: quilt/0.45-1
Date: Thu, 02 Nov 2006 20:23:04 -0800
From: Matt Helsley <matthltc@us.ibm.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
       Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
       Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 7/9] Task Watchers v2: Register lockdep task watcher
Content-Disposition: inline; filename=task-watchers-register-lockdep
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Register a task watcher for lockdep instead of hooking into copy_process().

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
---
 kernel/fork.c    |    5 -----
 kernel/lockdep.c |    9 +++++++++
 2 files changed, 9 insertions(+), 5 deletions(-)

Benchmark results:
System: 4 1.7GHz ppc64 (Power 4+) processors, 30968600MB RAM, 2.6.19-rc2-mm2 kernel

Clone	Number of Children Cloned
	5000		7500		10000		12500		15000		17500
	---------------------------------------------------------------------------------------
Mean	17808.2 	18092.3 	18215.5 	18183.6 	18310.8 	18342.8
Dev	302.333 	317.786 	303.385 	280.608 	281.378 	294.009
Err (%)	1.69772 	1.75647 	1.66553 	1.5432	 	1.53668 	1.60285

Fork	Number of Children Forked
	5000		7500		10000		12500		15000		17500
	---------------------------------------------------------------------------------------
Mean	17821.8 	18025.1 	18112.5 	18226	 	18217.4 	18318
Dev	316.497 	310.195 	291.372 	297.166 	364.908 	293.89
Err (%)	1.7759 		1.7209 		1.60868 	1.63045 	2.00307 	1.60438

Kernbench:
Elapsed: 124.333s User: 439.787s System: 46.491s CPU: 390.7%
439.67user 46.42system 2:04.09elapsed 391%CPU (0avgtext+0avgdata 0maxresident)k
439.82user 46.46system 2:04.17elapsed 391%CPU (0avgtext+0avgdata 0maxresident)k
439.75user 46.65system 2:04.24elapsed 391%CPU (0avgtext+0avgdata 0maxresident)k
439.79user 46.43system 2:04.54elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.71user 46.43system 2:04.56elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.71user 46.51system 2:04.45elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.86user 46.64system 2:04.69elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.87user 46.44system 2:04.05elapsed 392%CPU (0avgtext+0avgdata 0maxresident)k
439.87user 46.48system 2:04.63elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.82user 46.45system 2:03.91elapsed 392%CPU (0avgtext+0avgdata 0maxresident)k

Index: linux-2.6.19-rc2-mm2/kernel/fork.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/kernel/fork.c
+++ linux-2.6.19-rc2-mm2/kernel/fork.c
@@ -1052,15 +1052,10 @@ static struct task_struct *copy_process(
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
 
Index: linux-2.6.19-rc2-mm2/kernel/lockdep.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/kernel/lockdep.c
+++ linux-2.6.19-rc2-mm2/kernel/lockdep.c
@@ -2556,10 +2556,19 @@ void __init lockdep_init(void)
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
