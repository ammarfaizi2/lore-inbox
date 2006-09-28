Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751960AbWI1RaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbWI1RaZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 13:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbWI1RaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 13:30:25 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:50870 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751960AbWI1RaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 13:30:22 -0400
Date: Thu, 28 Sep 2006 22:59:51 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com,
       ckrm-tech@lists.sourceforge.net
Subject: [RFC, PATCH 4/9] CPU Controller V2 - define group operations
Message-ID: <20060928172951.GE8746@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060928172520.GA8746@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928172520.GA8746@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define these operations for a task-group:

        - create new group
        - destroy existing group
        - assign bandwidth (quota) for a group
        - get bandwidth (quota) of a group


Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>

---

 linux-2.6.18-root/include/linux/sched.h |   13 +++++
 linux-2.6.18-root/kernel/sched.c        |   79 ++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff -puN kernel/sched.c~cpu_ctlr_grp_ops kernel/sched.c
--- linux-2.6.18/kernel/sched.c~cpu_ctlr_grp_ops	2006-09-28 16:40:21.106832096 +0530
+++ linux-2.6.18-root/kernel/sched.c	2006-09-28 17:23:19.055924264 +0530
@@ -7192,3 +7192,82 @@ void set_curr_task(int cpu, struct task_
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
+	tg->ticks = CPU_CONTROL_SHORT_WINDOW;
+	tg->long_ticks = NUM_LONG_TICKS;
+
+	for_each_possible_cpu(i) {
+		tgrq = kzalloc(sizeof(*tgrq), GFP_KERNEL);
+		if (!tgrq)
+			goto oom;
+		tg->rq[i] = tgrq;
+		task_grp_rq_init(tgrq, tg);
+	}
+
+	return tg;
+oom:
+	while (i--)
+		kfree(tg->rq[i]);
+
+	kfree(tg);
+	return NULL;
+}
+
+/* Deallocate runqueue structures */
+void sched_dealloc_group(struct task_grp *tg)
+{
+	int i;
+
+	for_each_possible_cpu(i)
+		kfree(tg->rq[i]);
+
+	kfree(tg);
+}
+
+/* Assign quota to this group */
+int sched_assign_quota(struct task_grp *tg, int quota)
+{
+	int i;
+
+	tg->ticks = (quota * CPU_CONTROL_SHORT_WINDOW) / 100;
+
+	for_each_possible_cpu(i)
+		tg->rq[i]->ticks = tg->ticks;
+
+	return 0;
+}
+
+static inline int cpu_quota(struct task_grp *tg)
+{
+	return (tg->ticks * 100) / CPU_CONTROL_SHORT_WINDOW;
+}
+
+/* Return assigned quota for this group */
+int sched_get_quota(struct task_grp *tg)
+{
+	return cpu_quota(tg);
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
--- linux-2.6.18/include/linux/sched.h~cpu_ctlr_grp_ops	2006-09-28 16:40:21.111831336 +0530
+++ linux-2.6.18-root/include/linux/sched.h	2006-09-28 17:23:19.059923656 +0530
@@ -1611,6 +1611,19 @@ static inline void thaw_processes(void) 
 static inline int try_to_freeze(void) { return 0; }
 
 #endif /* CONFIG_PM */
+
+#ifdef CONFIG_CPUMETER
+struct task_grp;
+struct task_grp_ops {
+	void *(*alloc_group)(void);
+	void (*dealloc_group)(struct task_grp *grp);
+	int (*assign_quota)(struct task_grp *grp, int quota);
+	int (*get_quota)(struct task_grp *grp);
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
