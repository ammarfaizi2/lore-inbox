Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966920AbWKVAw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966920AbWKVAw6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 19:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966922AbWKVAw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 19:52:58 -0500
Received: from mga05.intel.com ([192.55.52.89]:44082 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S966920AbWKVAw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 19:52:57 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,445,1157353200"; 
   d="scan'208"; a="18579287:sNHT20632590"
Date: Tue, 21 Nov 2006 16:28:45 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@timesys.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan <arjan@linux.intel.com>
Subject: [RFC][PATCH] Add do_not_call_when_idle option to timer and workqueue
Message-ID: <20061121162845.A24791@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a new flag to timers to allow "Do not call when Idle" mode.
Export this sort of soft timer over workqueues and use it in ondemand governor.

This patch avoids the periodic ondemand timer invocations in
Dynamic Tick kernels.

This can be used in various other kernel timers that end up setting up
unnecessary timers during idle.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.19-rc-mm/include/linux/timer.h
===================================================================
--- linux-2.6.19-rc-mm.orig/include/linux/timer.h	2006-11-13 15:06:26.000000000 -0800
+++ linux-2.6.19-rc-mm/include/linux/timer.h	2006-11-13 16:01:03.000000000 -0800
@@ -8,6 +8,8 @@
 
 struct tvec_t_base_s;
 
+#define TIMER_FLAG_NOT_IN_IDLE	(0x1)
+
 struct timer_list {
 	struct list_head entry;
 	unsigned long expires;
@@ -16,6 +18,7 @@
 	unsigned long data;
 
 	struct tvec_t_base_s *base;
+	int	flags;
 #ifdef CONFIG_TIMER_STATS
 	void *start_site;
 	char start_comm[16];
@@ -30,6 +33,7 @@
 		.expires = (_expires),				\
 		.data = (_data),				\
 		.base = &boot_tvec_bases,			\
+		.flags = 0,					\
 	}
 
 #define DEFINE_TIMER(_name, _function, _expires, _data)		\
Index: linux-2.6.19-rc-mm/include/linux/workqueue.h
===================================================================
--- linux-2.6.19-rc-mm.orig/include/linux/workqueue.h	2006-11-13 15:06:26.000000000 -0800
+++ linux-2.6.19-rc-mm/include/linux/workqueue.h	2006-11-13 16:01:03.000000000 -0800
@@ -65,6 +65,8 @@
 extern int FASTCALL(queue_delayed_work(struct workqueue_struct *wq, struct work_struct *work, unsigned long delay));
 extern int queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
 	struct work_struct *work, unsigned long delay);
+extern int queue_soft_delayed_work_on(int cpu, struct workqueue_struct *wq,
+	struct work_struct *work, unsigned long delay);
 extern void FASTCALL(flush_workqueue(struct workqueue_struct *wq));
 
 extern int FASTCALL(schedule_work(struct work_struct *work));
Index: linux-2.6.19-rc-mm/kernel/timer.c
===================================================================
--- linux-2.6.19-rc-mm.orig/kernel/timer.c	2006-11-13 15:06:26.000000000 -0800
+++ linux-2.6.19-rc-mm/kernel/timer.c	2006-11-13 16:01:03.000000000 -0800
@@ -639,6 +639,8 @@
 	j = base->timer_jiffies & TVR_MASK;
 	do {
 		list_for_each_entry(nte, base->tv1.vec + j, entry) {
+			if (nte->flags & TIMER_FLAG_NOT_IN_IDLE)
+				continue;
 			expires = nte->expires;
 			found = nte;
 			if (j < (base->timer_jiffies & TVR_MASK))
Index: linux-2.6.19-rc-mm/kernel/workqueue.c
===================================================================
--- linux-2.6.19-rc-mm.orig/kernel/workqueue.c	2006-11-13 15:06:26.000000000 -0800
+++ linux-2.6.19-rc-mm/kernel/workqueue.c	2006-11-13 16:01:03.000000000 -0800
@@ -196,6 +196,20 @@
 }
 EXPORT_SYMBOL_GPL(queue_delayed_work_on);
 
+int queue_soft_delayed_work_on(int cpu, struct workqueue_struct *wq,
+			struct work_struct *work, unsigned long delay)
+{
+	int ret;
+	struct timer_list *timer = &work->timer;
+	ret = queue_delayed_work_on(cpu, wq, work, delay);
+	if (ret) {
+		timer->flags |= TIMER_FLAG_NOT_IN_IDLE;
+	}
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(queue_soft_delayed_work_on);
+
 static void run_workqueue(struct cpu_workqueue_struct *cwq)
 {
 	unsigned long flags;
Index: linux-2.6.19-rc-mm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-2.6.19-rc-mm.orig/drivers/cpufreq/cpufreq_ondemand.c	2006-11-13 15:58:04.000000000 -0800
+++ linux-2.6.19-rc-mm/drivers/cpufreq/cpufreq_ondemand.c	2006-11-21 12:23:15.000000000 -0800
@@ -446,7 +448,7 @@
 	                        	dbs_info->freq_lo,
 	                        	CPUFREQ_RELATION_H);
 	}
-	queue_delayed_work_on(cpu, kondemand_wq, &dbs_info->work, delay);
+	queue_soft_delayed_work_on(cpu, kondemand_wq, &dbs_info->work, delay);
 }
 
 static inline void dbs_timer_init(unsigned int cpu)
@@ -456,9 +458,9 @@
 	int delay = usecs_to_jiffies(dbs_tuners_ins.sampling_rate);
 	delay -= jiffies % delay;
 
 	ondemand_powersave_bias_init();
 	INIT_WORK(&dbs_info->work, do_dbs_timer, NULL);
-	queue_delayed_work_on(cpu, kondemand_wq, &dbs_info->work, delay);
+	queue_soft_delayed_work_on(cpu, kondemand_wq, &dbs_info->work, delay);
 }
 
 static inline void dbs_timer_exit(struct cpu_dbs_info_s *dbs_info)
