Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWDUCbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWDUCbA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWDUC2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:28:44 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:22757 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932131AbWDUC2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:28:14 -0400
From: maeda.naoaki@jp.fujitsu.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: maeda.naoaki@jp.fujitsu.com
Date: Fri, 21 Apr 2006 11:27:42 +0900
Message-Id: <20060421022742.13598.7230.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
In-Reply-To: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
References: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
Subject: [RFC][PATCH 3/9] CPU controller - Adds timeslice scaling
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

3/9: cpurc_timeslice_scaling

This patch corresponds to section 3 in Documentation/ckrm/cpurc-internals, 
adding the CPU resource control by scaling timeslices given to each tasks.
The scaling factors of timeslices are changed based on the difference between
the share of the resource and the actual load.

Signed-off-by: Kurosawa Takahiro <kurosawa@valinux.co.jp>
Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>

 include/linux/cpu_rc.h |   12 +++++++++
 kernel/cpu_rc.c        |   63 +++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched.c         |   11 +++++++-
 3 files changed, 82 insertions(+), 4 deletions(-)

Index: linux-2.6.17-rc2/include/linux/cpu_rc.h
===================================================================
--- linux-2.6.17-rc2.orig/include/linux/cpu_rc.h
+++ linux-2.6.17-rc2/include/linux/cpu_rc.h
@@ -17,8 +17,11 @@
 
 #define CPU_RC_SPREAD_PERIOD	(10 * HZ)
 #define CPU_RC_LOAD_SCALE	(2 * CPU_RC_SPREAD_PERIOD)
+#define CPU_RC_LOAD_MARGIN	1
 #define CPU_RC_SHARE_SCALE	100
 #define CPU_RC_TSFACTOR_MAX	CPU_RC_SHARE_SCALE
+#define CPU_RC_TSFACTOR_INC_HI	5
+#define CPU_RC_TSFACTOR_INC_LO	2
 #define CPU_RC_HCOUNT_INC	2
 #define CPU_RC_RECALC_INTERVAL	HZ
 
@@ -34,6 +37,8 @@ struct cpu_rc_domain {
 struct cpu_rc {
 	int share;
 	int is_hungry;
+	unsigned int ts_factor;
+	unsigned long last_recalc;
 	struct cpu_rc_domain *rcd;
 	struct {
 		unsigned long timestamp;
@@ -44,6 +49,7 @@ struct cpu_rc {
 
 extern struct cpu_rc *cpu_rc_get(task_t *);
 extern unsigned int cpu_rc_load(struct cpu_rc *);
+extern unsigned int cpu_rc_scale_timeslice(task_t *, unsigned int);
 extern void cpu_rc_account(task_t *, unsigned long);
 extern void cpu_rc_detect_hunger(task_t *);
 
@@ -74,6 +80,12 @@ static inline void cpu_rc_record_allocat
 					    unsigned int slice,
 					    unsigned long now) {}
 
+static inline unsigned int cpu_rc_scale_timeslice(task_t *tsk,
+						  unsigned int slice)
+{
+	return slice;
+}
+
 #endif /* CONFIG_CPU_RC */
 
 #endif /* _LINUX_CPU_RC_H_ */
Index: linux-2.6.17-rc2/kernel/cpu_rc.c
===================================================================
--- linux-2.6.17-rc2.orig/kernel/cpu_rc.c
+++ linux-2.6.17-rc2/kernel/cpu_rc.c
@@ -14,6 +14,16 @@
 #include <linux/sched.h>
 #include <linux/cpu_rc.h>
 
+static inline void cpu_rcd_lock(struct cpu_rc *cr)
+{
+	spin_lock(&cr->rcd->lock);
+}
+
+static inline void cpu_rcd_unlock(struct cpu_rc *cr)
+{
+	spin_unlock(&cr->rcd->lock);
+}
+
 static inline int cpu_rc_is_hungry(struct cpu_rc *cr)
 {
 	return cr->is_hungry;
@@ -77,6 +87,33 @@ static inline void cpu_rc_recalc_tsfacto
 	else
 		cpu_rc_set_hungry(cr);
 
+	if (!cpu_rc_is_anyone_hungry(cr)) {
+		/* Everyone satisfied.  Extend time_slice. */
+		cr->ts_factor += CPU_RC_TSFACTOR_INC_HI;
+	} else {
+		if (cpu_rc_is_hungry(cr)) {
+			/* Extend time_slice a little. */
+			cr->ts_factor += CPU_RC_TSFACTOR_INC_LO;
+		} else if (load * CPU_RC_SHARE_SCALE >
+			   (cr->share + CPU_RC_LOAD_MARGIN)
+				* CPU_RC_LOAD_SCALE) {
+			/*
+			 * scale time_slice only when load is higher than
+			 * the share.
+			 */
+			cr->ts_factor = cr->ts_factor * cr->share
+				* CPU_RC_LOAD_SCALE
+				/ (load * CPU_RC_SHARE_SCALE);
+		}
+	}
+
+	if (cr->ts_factor == 0)
+		cr->ts_factor = 1;
+	else if (cr->ts_factor > CPU_RC_TSFACTOR_MAX)
+		cr->ts_factor = CPU_RC_TSFACTOR_MAX;
+
+	cr->last_recalc = now;
+
 	cpu_rcd_unlock(cr);
 }
 
@@ -102,7 +139,29 @@ unsigned int cpu_rc_load(struct cpu_rc *
 
 	BUG_ON(!n);
 
-	return load / n * CPU_RC_GUAR_SCALE / CPU_RC_LOAD_SCALE;
+	return load / n * CPU_RC_SHARE_SCALE / CPU_RC_LOAD_SCALE;
+}
+
+/*
+ * cpu_rc_scale_timeslice scales the task timeslice based on the scale factor
+ */
+unsigned int cpu_rc_scale_timeslice(task_t *tsk, unsigned int slice)
+{
+	struct cpu_rc *cr;
+	unsigned int scaled;
+
+	cr = cpu_rc_get(tsk);
+	if (!cr)
+		return slice;
+
+	if (jiffies - cr->last_recalc > CPU_RC_RECALC_INTERVAL)
+		cpu_rc_recalc_tsfactor(cr);
+
+	scaled = slice * cr->ts_factor / CPU_RC_TSFACTOR_MAX;
+	if (scaled == 0)
+		scaled = 1;
+
+	return scaled;
 }
 
 /*
@@ -167,7 +226,7 @@ void cpu_rc_detect_hunger(task_t *tsk)
 
 	BUG_ON(tsk->last_slice == 0);
 	wait = jiffies - tsk->last_activated;
-	if (CPU_RC_GUAR_SCALE * tsk->last_slice	/ (wait + tsk->last_slice)
+	if (CPU_RC_SHARE_SCALE * tsk->last_slice / (wait + tsk->last_slice)
 			< cr->share)
 		cr->stat[cpu].maybe_hungry++;
 
Index: linux-2.6.17-rc2/kernel/sched.c
===================================================================
--- linux-2.6.17-rc2.orig/kernel/sched.c
+++ linux-2.6.17-rc2/kernel/sched.c
@@ -173,10 +173,17 @@
 
 static unsigned int task_timeslice(task_t *p)
 {
+	unsigned int timeslice;
+
 	if (p->static_prio < NICE_TO_PRIO(0))
-		return SCALE_PRIO(DEF_TIMESLICE*4, p->static_prio);
+		timeslice = SCALE_PRIO(DEF_TIMESLICE*4, p->static_prio);
 	else
-		return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
+		timeslice = SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
+
+	if (!TASK_INTERACTIVE(p))
+		timeslice = cpu_rc_scale_timeslice(p, timeslice);
+
+	return timeslice;
 }
 #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
 				< (long long) (sd)->cache_hot_time)
