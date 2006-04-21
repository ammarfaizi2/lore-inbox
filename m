Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWDUCa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWDUCa7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWDUC2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:28:47 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:17381 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932127AbWDUC2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:28:14 -0400
From: maeda.naoaki@jp.fujitsu.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: maeda.naoaki@jp.fujitsu.com
Date: Fri, 21 Apr 2006 11:27:48 +0900
Message-Id: <20060421022748.13598.96502.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
In-Reply-To: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
References: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
Subject: [RFC][PATCH 4/9] CPU controller - Adds interface functions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4/9: cpurc_interface

Adds interface functions to CKRM CPU controller.

Signed-off-by: Kurosawa Takahiro <kurosawa@valinux.co.jp>
Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>

 include/linux/cpu_rc.h |    6 ++++++
 kernel/cpu_rc.c        |   45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

Index: linux-2.6.17-rc2/kernel/cpu_rc.c
===================================================================
--- linux-2.6.17-rc2.orig/kernel/cpu_rc.c
+++ linux-2.6.17-rc2/kernel/cpu_rc.c
@@ -232,3 +232,48 @@ void cpu_rc_detect_hunger(task_t *tsk)
 
 	tsk->last_activated = 0;
 }
+
+void cpu_rc_clear_stat(struct cpu_rc *cr, int cpu)
+{
+	cr->stat[cpu].timestamp = 0;
+	cr->stat[cpu].load = 0;
+	cr->stat[cpu].maybe_hungry = 0;
+}
+
+void cpu_rc_init_cr(struct cpu_rc *cr, struct cpu_rc_domain *rcd)
+{
+	cr->rcd = rcd;
+	cr->share = 0;
+	cr->ts_factor = CPU_RC_TSFACTOR_MAX;
+}
+
+void cpu_rc_get_cr(struct cpu_rc *cr)
+{
+	cpu_rcd_lock(cr);
+	cr->rcd->numcrs++;
+	cpu_rcd_unlock(cr);
+}
+
+void cpu_rc_put_cr(struct cpu_rc *cr)
+{
+	cpu_rcd_lock(cr);
+	cr->is_hungry = 0;
+	cr->rcd->numcrs--;
+	cpu_rcd_unlock(cr);
+}
+
+void cpu_rc_init_rcd(struct cpu_rc_domain *rcd)
+{
+	rcd->cpus = cpu_online_map;
+	spin_lock_init(&rcd->lock);
+	rcd->hungry_count = 0;
+	rcd->numcpus = cpus_weight(cpu_online_map);
+	rcd->numcrs = 0;
+}
+
+void cpu_rc_set_share(struct cpu_rc *cr, int val)
+{
+	cpu_rcd_lock(cr);
+	cr->share = val;
+	cpu_rcd_unlock(cr);
+}
Index: linux-2.6.17-rc2/include/linux/cpu_rc.h
===================================================================
--- linux-2.6.17-rc2.orig/include/linux/cpu_rc.h
+++ linux-2.6.17-rc2/include/linux/cpu_rc.h
@@ -52,6 +52,12 @@ extern unsigned int cpu_rc_load(struct c
 extern unsigned int cpu_rc_scale_timeslice(task_t *, unsigned int);
 extern void cpu_rc_account(task_t *, unsigned long);
 extern void cpu_rc_detect_hunger(task_t *);
+extern void cpu_rc_clear_stat(struct cpu_rc *, int);
+extern void cpu_rc_init_cr(struct cpu_rc *, struct cpu_rc_domain *);
+extern void cpu_rc_get_cr(struct cpu_rc *);
+extern void cpu_rc_put_cr(struct cpu_rc *);
+extern void cpu_rc_init_rcd(struct cpu_rc_domain *);
+extern void cpu_rc_set_share(struct cpu_rc *, int);
 
 static inline void cpu_rc_record_activated(task_t *tsk, unsigned long now)
 {
