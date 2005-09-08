Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932627AbVIHFo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbVIHFo6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 01:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbVIHFo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 01:44:57 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:43202 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932627AbVIHFow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 01:44:52 -0400
Date: Thu, 8 Sep 2005 14:44:51 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] SUBCPUSETS: connect the CPU resource controller to
 subcpusets
X-Mailer: Sylpheed version 2.1.0+svn (GTK+ 2.6.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050908054451.ADE9870031@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch puts the CPU resource controller into SUBCPUSETS framework.
With this patch, we can control the CPU resource from the cpuset
filesystem.

Signed-off-by: KUROSAWA Takahiro <kurosawa@valinux.co.jp>


--- from-0005/init/Kconfig
+++ to-work/init/Kconfig	2005-09-07 20:49:02.766634348 +0900
@@ -249,6 +249,7 @@ config SUBCPUSETS
 
 config CPU_RC
 	bool "CPU resource controller"
+	depends on SUBCPUSETS
 	help
 	  This options will let you control the CPU resource by scaling 
 	  the timeslice allocated for each tasks.
--- from-0005/kernel/cpu_rc.c
+++ to-work/kernel/cpu_rc.c	2005-09-07 19:41:08.189485000 +0900
@@ -230,6 +230,137 @@ void cpu_rc_collect_hunger(task_t *tsk)
 	tsk->last_activated = 0;
 }
 
+/*
+ * interface functions for subcpuset
+ */
+static void *cpu_rc_create_toplevel(struct cpuset *cs,
+				    cpumask_t cpus, nodemask_t mems)
+{
+	struct cpu_rc_toplevel *top;
+	int i;
+
+	if (cpus_empty(cpus)) {
+		return NULL;
+	}
+
+	top = kmalloc(sizeof(*top), GFP_KERNEL);
+	if (top == NULL) {
+		return NULL;
+	}
+
+	top->cs = cs;
+	top->cpus = cpus;
+	top->shares = CPU_RC_GUAR_SCALE;
+	spin_lock_init(&top->lock);
+	top->hungry_groups = 0;
+
+	top->numcpus = 0;
+	for_each_cpu_mask(i, cpus) {
+		top->numcpus++;
+	}
+
+	return top;
+}
+
+static void cpu_rc_destroy_toplevel(void *top)
+{
+	kfree(top);
+}
+
+static void *cpu_rc_create(void *top, struct cpuset *cs)
+{
+	struct cpu_rc *cr;
+
+	cr = kmalloc(sizeof(*cr), GFP_KERNEL);
+	if (cr == NULL) {
+		return NULL;
+	}
+
+	memset(cr, 0, sizeof(*cr));
+	cr->top = top;
+	cr->ts_factor = CPU_RC_TSFACTOR_MAX;
+	
+	return cr;
+}
+
+static void cpu_rc_destroy(void *p)
+{
+	struct cpu_rc *cr = p;
+
+	cpu_rc_lock(cr);
+	cpu_rc_set_satisfied(cr);
+	cpu_rc_unlock(cr);
+
+	kfree(p);
+}
+
+static int cpu_rc_set_guar(void *ctldata, unsigned long val)
+{
+	struct cpu_rc *cr = ctldata;
+
+	if (cr == NULL) {
+		return -EINVAL;
+	}
+
+	cpu_rc_lock(cr);
+	if (cr->top->shares + cr->guarantee < val) {
+		cpu_rc_unlock(cr);
+		return -ENOSPC;
+	}
+
+	cr->top->shares += cr->guarantee;
+	cr->top->shares -= val;
+	cr->guarantee = val;
+	cpu_rc_unlock(cr);
+
+	return 0;
+}
+
+static int cpu_rc_get_cur(void *ctldata, unsigned long *valp)
+{
+	struct cpu_rc *cr = ctldata;
+	unsigned int load;
+	int i, n;
+
+	if (cr == NULL) {
+		return -EINVAL;
+	}
+
+	load = 0;
+	n = 0;
+
+	/* Just displaying the value, so no locking... */
+	for_each_cpu_mask(i, cr->top->cpus) {
+		load += cr->stat[i].load;
+		n++;
+	}
+
+	*valp = load / n * CPU_RC_GUAR_SCALE / CPU_RC_LOAD_SCALE;
+
+	return 0;
+}
+
+static struct subcpuset_ctlr cpu_rc_ctlr = {
+	.name = "cpu",
+	.create_toplevel = cpu_rc_create_toplevel,
+	.destroy_toplevel = cpu_rc_destroy_toplevel,
+	.create = cpu_rc_create,
+	.destroy = cpu_rc_destroy,
+	.set_lim = NULL,
+	.set_guar = cpu_rc_set_guar,
+	.get_cur = cpu_rc_get_cur,
+};
+
 void cpu_rc_init(void)
 {
+	int err;
+	err = subcpuset_register_controller(&cpu_rc_ctlr);
+	if (err) {
+		printk(KERN_ERR "cpu_rc: register to subcpuset failed\n");
+	}
+}
+
+static struct cpu_rc *cpu_rc_get(task_t *tsk)
+{
+	return subcpuset_get_controller_data(tsk->cpuset, &cpu_rc_ctlr);
 }
