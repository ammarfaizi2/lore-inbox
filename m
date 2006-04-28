Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWD1BjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWD1BjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWD1Bis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:38:48 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:50338 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030263AbWD1BiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:38:25 -0400
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Date: Fri, 28 Apr 2006 10:37:51 +0900
Message-Id: <20060428013751.9582.50425.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
In-Reply-To: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
Subject: [PATCH 4/9] CPU controller - Add interface functions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4/9: cpurc_interface

Adds interface functions to resource group CPU controller.

Signed-off-by: Kurosawa Takahiro <kurosawa@valinux.co.jp>
Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>

 include/linux/cpu_rc.h |    6 ++++++
 kernel/cpu_rc.c        |   45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

Index: linux-2.6.17-rc3/kernel/cpu_rc.c
===================================================================
--- linux-2.6.17-rc3.orig/kernel/cpu_rc.c
+++ linux-2.6.17-rc3/kernel/cpu_rc.c
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
Index: linux-2.6.17-rc3/include/linux/cpu_rc.h
===================================================================
--- linux-2.6.17-rc3.orig/include/linux/cpu_rc.h
+++ linux-2.6.17-rc3/include/linux/cpu_rc.h
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
