Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWF1VRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWF1VRL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 17:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWF1VRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 17:17:11 -0400
Received: from mga06.intel.com ([134.134.136.21]:27050 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751534AbWF1VRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 17:17:10 -0400
X-IronPort-AV: i="4.06,189,1149490800"; 
   d="scan'208"; a="58132336:sNHT1265924800"
Date: Wed, 28 Jun 2006 14:10:28 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       alexey.y.starikovskiy@intel.com
Subject: [RFC] Adding queue_delayed_work_on interface for workqueues
Message-ID: <20060628141028.A13221@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is a part of cpufreq patches for ondemand governor optimizations
and entire series is actually posted to cpufreq mailing list.
Subject "minor optimizations to ondemand governor"

The following patch however is a generic change to workqueue interface and 
I wanted to get comments on this on lkml.

Thanks,
Venki

Add queue_delayed_work_on() interface for workqueues.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.17/include/linux/workqueue.h
===================================================================
--- linux-2.6.17.orig/include/linux/workqueue.h
+++ linux-2.6.17/include/linux/workqueue.h
@@ -63,12 +63,13 @@ extern void destroy_workqueue(struct wor
 
 extern int FASTCALL(queue_work(struct workqueue_struct *wq, struct work_struct *work));
 extern int FASTCALL(queue_delayed_work(struct workqueue_struct *wq, struct work_struct *work, unsigned long delay));
+extern int FASTCALL(queue_delayed_work_on(int cpu, struct workqueue_struct *wq, struct work_struct *work, unsigned long delay));
 extern void FASTCALL(flush_workqueue(struct workqueue_struct *wq));
 
 extern int FASTCALL(schedule_work(struct work_struct *work));
 extern int FASTCALL(schedule_delayed_work(struct work_struct *work, unsigned long delay));
 
-extern int schedule_delayed_work_on(int cpu, struct work_struct *work, unsigned long delay);
+extern int FASTCALL(schedule_delayed_work_on(int cpu, struct work_struct *work, unsigned long delay));
 extern int schedule_on_each_cpu(void (*func)(void *info), void *info);
 extern void flush_scheduled_work(void);
 extern int current_is_keventd(void);
Index: linux-2.6.17/kernel/workqueue.c
===================================================================
--- linux-2.6.17.orig/kernel/workqueue.c
+++ linux-2.6.17/kernel/workqueue.c
@@ -148,6 +148,27 @@ int fastcall queue_delayed_work(struct w
 	return ret;
 }
 
+int fastcall queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
+			struct work_struct *work, unsigned long delay)
+{
+	int ret = 0;
+	struct timer_list *timer = &work->timer;
+
+	if (!test_and_set_bit(0, &work->pending)) {
+		BUG_ON(timer_pending(timer));
+		BUG_ON(!list_empty(&work->entry));
+
+		/* This stores wq for the moment, for the timer_fn */
+		work->wq_data = wq;
+		timer->expires = jiffies + delay;
+		timer->data = (unsigned long)work;
+		timer->function = delayed_work_timer_fn;
+		add_timer_on(timer, cpu);
+		ret = 1;
+	}
+	return ret;
+}
+
 static void run_workqueue(struct cpu_workqueue_struct *cwq)
 {
 	unsigned long flags;
@@ -408,24 +429,10 @@ int fastcall schedule_delayed_work(struc
 	return queue_delayed_work(keventd_wq, work, delay);
 }
 
-int schedule_delayed_work_on(int cpu,
+int fastcall schedule_delayed_work_on(int cpu,
 			struct work_struct *work, unsigned long delay)
 {
-	int ret = 0;
-	struct timer_list *timer = &work->timer;
-
-	if (!test_and_set_bit(0, &work->pending)) {
-		BUG_ON(timer_pending(timer));
-		BUG_ON(!list_empty(&work->entry));
-		/* This stores keventd_wq for the moment, for the timer_fn */
-		work->wq_data = keventd_wq;
-		timer->expires = jiffies + delay;
-		timer->data = (unsigned long)work;
-		timer->function = delayed_work_timer_fn;
-		add_timer_on(timer, cpu);
-		ret = 1;
-	}
-	return ret;
+	return queue_delayed_work_on(cpu, keventd_wq, work, delay);
 }
 
 int schedule_on_each_cpu(void (*func) (void *info), void *info)
@@ -608,6 +615,7 @@ void init_workqueues(void)
 EXPORT_SYMBOL_GPL(__create_workqueue);
 EXPORT_SYMBOL_GPL(queue_work);
 EXPORT_SYMBOL_GPL(queue_delayed_work);
+EXPORT_SYMBOL_GPL(queue_delayed_work_on);
 EXPORT_SYMBOL_GPL(flush_workqueue);
 EXPORT_SYMBOL_GPL(destroy_workqueue);
 
