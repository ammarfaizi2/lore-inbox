Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751620AbVIZJez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbVIZJez (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 05:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbVIZJeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 05:34:37 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:19927 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751620AbVIZJee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 05:34:34 -0400
Date: Mon, 26 Sep 2005 18:34:12 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: Paul Jackson <pj@sgi.com>
Cc: taka@valinux.co.jp, magnus.damm@gmail.com, dino@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] CPUMETER: connect the CPU resource controller to
 CPUMETER
In-Reply-To: <20050910015209.4f581b8a.pj@sgi.com>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
X-Mailer: Sylpheed version 2.1.2+svn (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050926093433.2394770045@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch puts the CPU resource controller into CPUMETER framework.
With this patch, we can control the CPU resource from the cpuset
filesystem.

Signed-off-by: KUROSAWA Takahiro <kurosawa@valinux.co.jp>

--- from-0003/init/Kconfig
+++ to-work/init/Kconfig	2005-09-26 17:31:40.247109876 +0900
@@ -249,6 +249,7 @@ config CPUMETER
 
 config CPU_RC
 	bool "CPU resource controller"
+	depends on CPUMETER
 	help
 	  This options will let you control the CPU resource by scaling 
 	  the timeslice allocated for each tasks.
--- from-0003/kernel/cpu_rc.c
+++ to-work/kernel/cpu_rc.c	2005-09-22 11:51:57.000000000 +0900
@@ -228,6 +228,124 @@ void cpu_rc_collect_hunger(task_t *tsk)
 	tsk->last_activated = 0;
 }
 
+/*
+ * interface functions for cpumeter
+ */
+static void *cpu_rc_create_rcdomain(struct cpuset *cs,
+				    cpumask_t cpus, nodemask_t mems)
+{
+	struct cpu_rc_domain *rcd;
+
+	if (cpus_empty(cpus)) {
+		return NULL;
+	}
+
+	rcd = kmalloc(sizeof(*rcd), GFP_KERNEL);
+	if (rcd == NULL) {
+		return NULL;
+	}
+
+	rcd->cpus = cpus;
+	spin_lock_init(&rcd->lock);
+	rcd->hungry_groups = 0;
+
+	rcd->numcpus = cpus_weight(cpus);
+
+	return rcd;
+}
+
+static void cpu_rc_destroy_rcdomain(void *rcd)
+{
+	kfree(rcd);
+}
+
+static void *cpu_rc_create(void *rcd, struct cpuset *cs)
+{
+	struct cpu_rc *cr;
+
+	cr = kmalloc(sizeof(*cr), GFP_KERNEL);
+	if (cr == NULL) {
+		return NULL;
+	}
+
+	memset(cr, 0, sizeof(*cr));
+	cr->rcd = rcd;
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
+	for_each_cpu_mask(i, cr->rcd->cpus) {
+		load += cr->stat[i].load;
+		n++;
+	}
+
+	*valp = load / n * CPU_RC_GUAR_SCALE / CPU_RC_LOAD_SCALE;
+
+	return 0;
+}
+
+static struct cpumeter_ctlr cpu_rc_ctlr = {
+	.name = "cpu",
+	.create_rcdomain = cpu_rc_create_rcdomain,
+	.destroy_rcdomain = cpu_rc_destroy_rcdomain,
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
+	err = cpumeter_register_controller(&cpu_rc_ctlr);
+	if (err) {
+		printk(KERN_ERR "cpu_rc: register to cpumeter failed\n");
+	}
+}
+
+static struct cpu_rc *cpu_rc_get(task_t *tsk)
+{
+	return cpumeter_get_controller_data(tsk->cpuset, &cpu_rc_ctlr);
 }
