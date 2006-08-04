Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWHDFF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWHDFF5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWHDFF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:05:57 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:3510 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751403AbWHDFFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:05:55 -0400
Date: Fri, 4 Aug 2006 10:40:23 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Mike Galbraith <efault@gmx.de>,
       Balbir Singh <balbir@in.ibm.com>, sekharan@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: [ RFC, PATCH 2/5 ] CPU controller - Define group operations
Message-ID: <20060804051023.GF27194@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060804050753.GD27194@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060804050753.GD27194@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Define these operations for a task-group:

	- create new group
	- destroy existing group
	- assign bandwidth (quota) for a group
	- get bandwidth (quota) of a group


Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>



 include/linux/sched.h |   12 +++++++
 kernel/sched.c        |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff -puN kernel/sched.c~cpu_ctlr_grp_ops kernel/sched.c
--- linux-2.6.18-rc3/kernel/sched.c~cpu_ctlr_grp_ops	2006-08-04 07:58:50.000000000 +0530
+++ linux-2.6.18-rc3-root/kernel/sched.c	2006-08-04 07:58:50.000000000 +0530
@@ -7063,3 +7063,82 @@ void set_curr_task(int cpu, struct task_
 }
 
 #endif
+
+#ifdef CONFIG_CPUMETER
+
+/* Allocate runqueue structures for the new task-group */
+void *sched_alloc_group(void)
+{
+	struct task_grp *tg;
+	struct task_grp_rq *tgrq;
+	int i;
+
+	tg = kzalloc(sizeof(*tg), GFP_KERNEL);
+	if (!tg)
+		return NULL;
+
+	tg->ticks = -1;		/* No limit */
+
+	for_each_possible_cpu(i) {
+		tgrq = kzalloc(sizeof(*tgrq), GFP_KERNEL);
+		if (!tgrq)
+			goto oom;
+		tg->rq[i] = tgrq;
+		task_grp_rq_init(tgrq, tg->ticks);
+	}
+
+	return (void *)tg;
+oom:
+	while (i--)
+		kfree(tg->rq[i]);
+
+	kfree(tg);
+	return NULL;
+}
+
+/* Deallocate runqueue structures */
+void sched_dealloc_group(void *grp)
+{
+	struct task_grp *tg = (struct task_grp *)grp;
+	int i;
+
+	for_each_possible_cpu(i)
+		kfree(tg->rq[i]);
+
+	kfree(tg);
+}
+
+/* Assign quota to this group */
+void sched_assign_quota(void *grp, int quota)
+{
+	struct task_grp *tg = (struct task_grp *)grp;
+	int i;
+
+	tg->ticks = (quota * 5 * HZ) / 100;
+
+	for_each_possible_cpu(i)
+		tg->rq[i]->ticks = tg->ticks;
+
+}
+
+/* Return assigned quota for this group */
+int sched_get_quota(void *grp)
+{
+	struct task_grp *tg = (struct task_grp *)grp;
+	int quota;
+
+	quota = (tg->ticks * 100) / (5 * HZ);
+
+	return quota;
+}
+
+static struct task_grp_ops sched_grp_ops = {
+	.alloc_group = sched_alloc_group,
+	.dealloc_group = sched_dealloc_group,
+	.assign_quota = sched_assign_quota,
+	.get_quota = sched_get_quota,
+};
+
+struct task_grp_ops *cpu_ctlr = &sched_grp_ops;
+
+#endif /* CONFIG_CPUMETER */
diff -puN include/linux/sched.h~cpu_ctlr_grp_ops include/linux/sched.h
--- linux-2.6.18-rc3/include/linux/sched.h~cpu_ctlr_grp_ops	2006-08-04 07:58:50.000000000 +0530
+++ linux-2.6.18-rc3-root/include/linux/sched.h	2006-08-04 07:58:50.000000000 +0530
@@ -1604,6 +1604,18 @@ static inline void thaw_processes(void) 
 static inline int try_to_freeze(void) { return 0; }
 
 #endif /* CONFIG_PM */
+
+#ifdef CONFIG_CPUMETER
+struct task_grp_ops {
+	void *(*alloc_group)(void);
+	void (*dealloc_group)(void *grp);
+	void (*assign_quota)(void *grp, int quota);
+	int (*get_quota)(void *grp);
+};
+
+extern struct task_grp_ops *cpu_ctlr;
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif

_
-- 
Regards,
vatsa
-- 
Regards,
vatsa
