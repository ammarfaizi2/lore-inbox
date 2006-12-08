Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164222AbWLHA3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164222AbWLHA3M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 19:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164224AbWLHA3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 19:29:12 -0500
Received: from mga05.intel.com ([192.55.52.89]:17432 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1164223AbWLHA3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 19:29:10 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,511,1157353200"; 
   d="scan'208"; a="174621380:sNHT162860950"
Date: Thu, 7 Dec 2006 16:03:01 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@timesys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add not_critical_when_idle mode for workqueues and use it in ondemand governor
Message-ID: <20061207160301.B26061@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Add a new not_critical_when_idle parameter to queue_delayed_work_on(). This
parameter can be used to schedule work that are 'unimportant' when
CPU is idle and can be called later, when CPU eventually comes out of idle.

Use this parameter in cpufreq ondemand governor.
 
Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.19-rc-mm/kernel/workqueue.c
===================================================================
--- linux-2.6.19-rc-mm.orig/kernel/workqueue.c	2006-12-07 15:34:07.000000000 -0800
+++ linux-2.6.19-rc-mm/kernel/workqueue.c	2006-12-07 15:34:31.000000000 -0800
@@ -171,11 +171,13 @@
  * @wq: workqueue to use
  * @work: work to queue
  * @delay: number of jiffies to wait before queueing
+ * @not_critical_when_idle: 1 indicates work is not critical when CPU is idle
  *
  * Returns 0 if @work was already on a queue, non-zero otherwise.
  */
 int queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
-			struct work_struct *work, unsigned long delay)
+			struct work_struct *work, unsigned long delay,
+			int not_critical_when_idle)
 {
 	int ret = 0;
 	struct timer_list *timer = &work->timer;
@@ -189,7 +191,7 @@
 		timer->expires = jiffies + delay;
 		timer->data = (unsigned long)work;
 		timer->function = delayed_work_timer_fn;
-		add_timer_on(timer, cpu, 0);
+		add_timer_on(timer, cpu, not_critical_when_idle);
 		ret = 1;
 	}
 	return ret;
@@ -507,7 +509,7 @@
 int schedule_delayed_work_on(int cpu,
 			struct work_struct *work, unsigned long delay)
 {
-	return queue_delayed_work_on(cpu, keventd_wq, work, delay);
+	return queue_delayed_work_on(cpu, keventd_wq, work, delay, 0);
 }
 EXPORT_SYMBOL(schedule_delayed_work_on);
 
Index: linux-2.6.19-rc-mm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-2.6.19-rc-mm.orig/drivers/cpufreq/cpufreq_ondemand.c	2006-12-07 15:34:07.000000000 -0800
+++ linux-2.6.19-rc-mm/drivers/cpufreq/cpufreq_ondemand.c	2006-12-07 15:34:31.000000000 -0800
@@ -446,7 +446,7 @@
 	                        	dbs_info->freq_lo,
 	                        	CPUFREQ_RELATION_H);
 	}
-	queue_delayed_work_on(cpu, kondemand_wq, &dbs_info->work, delay);
+	queue_delayed_work_on(cpu, kondemand_wq, &dbs_info->work, delay, 1);
 }
 
 static inline void dbs_timer_init(unsigned int cpu)
@@ -458,7 +458,7 @@
 
 	ondemand_powersave_bias_init();
 	INIT_WORK(&dbs_info->work, do_dbs_timer, NULL);
-	queue_delayed_work_on(cpu, kondemand_wq, &dbs_info->work, delay);
+	queue_delayed_work_on(cpu, kondemand_wq, &dbs_info->work, delay, 1);
 }
 
 static inline void dbs_timer_exit(struct cpu_dbs_info_s *dbs_info)
Index: linux-2.6.19-rc-mm/include/linux/workqueue.h
===================================================================
--- linux-2.6.19-rc-mm.orig/include/linux/workqueue.h	2006-12-07 15:34:07.000000000 -0800
+++ linux-2.6.19-rc-mm/include/linux/workqueue.h	2006-12-07 15:34:31.000000000 -0800
@@ -64,7 +64,8 @@
 extern int FASTCALL(queue_work(struct workqueue_struct *wq, struct work_struct *work));
 extern int FASTCALL(queue_delayed_work(struct workqueue_struct *wq, struct work_struct *work, unsigned long delay));
 extern int queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
-	struct work_struct *work, unsigned long delay);
+	struct work_struct *work, unsigned long delay,
+	int not_critical_when_idle);
 extern void FASTCALL(flush_workqueue(struct workqueue_struct *wq));
 
 extern int FASTCALL(schedule_work(struct work_struct *work));
