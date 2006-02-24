Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWBXA1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWBXA1N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 19:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWBXA1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 19:27:12 -0500
Received: from thorn.pobox.com ([208.210.124.75]:49370 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S932240AbWBXA1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 19:27:11 -0500
Date: Thu, 23 Feb 2006 18:31:46 -0600
From: Nathan Lynch <ntl@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] softlockup detection vs. cpu hotplug
Message-ID: <20060224003146.GJ3293@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm able to trigger bogus softlockup warnings during cpu hotplug
testing, due to the percpu timestamp not being re-initialized before
the cpu starts servicing timer interrupts.

Before starting a cpu's watchdog thread, touch the cpu's timestamp to
avoid false positives.

In the watchdog thread, do touch_softlockup_watchdog in a
non-preemptible section so that it won't touch another cpu's
timestamp.  This can happen in the window between the watchdog thread
getting forcefully migrated during a cpu offline operation and
kthread_should_stop.

Signed-off-by: Nathan Lynch <ntl@pobox.com>

---

 kernel/softlockup.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

33426e0c29ad973f9107cbd872648050f8988e61
diff --git a/kernel/softlockup.c b/kernel/softlockup.c
index c67189a..bd86fe1 100644
--- a/kernel/softlockup.c
+++ b/kernel/softlockup.c
@@ -34,9 +34,14 @@ static struct notifier_block panic_block
 	.notifier_call = softlock_panic,
 };
 
+static void __touch_softlockup_watchdog(int cpu)
+{
+	per_cpu(timestamp, cpu) = jiffies;
+}
+
 void touch_softlockup_watchdog(void)
 {
-	per_cpu(timestamp, raw_smp_processor_id()) = jiffies;
+	__touch_softlockup_watchdog(raw_smp_processor_id());
 }
 EXPORT_SYMBOL(touch_softlockup_watchdog);
 
@@ -73,6 +78,7 @@ void softlockup_tick(struct pt_regs *reg
 static int watchdog(void * __bind_cpu)
 {
 	struct sched_param param = { .sched_priority = 99 };
+	unsigned long bind_cpu = (unsigned long)__bind_cpu;
 
 	sched_setscheduler(current, SCHED_FIFO, &param);
 	current->flags |= PF_NOFREEZE;
@@ -86,10 +92,15 @@ static int watchdog(void * __bind_cpu)
 	 */
 	while (!kthread_should_stop()) {
 		msleep_interruptible(1000);
-		touch_softlockup_watchdog();
+		/* When our cpu is offlined the watchdog thread can
+		 * get migrated before it is stopped.
+		 */
+		preempt_disable();
+		if (likely(smp_processor_id() == bind_cpu))
+			touch_softlockup_watchdog();
+		preempt_enable();
+		__set_current_state(TASK_RUNNING);
 	}
-	__set_current_state(TASK_RUNNING);
-
 	return 0;
 }
 
@@ -112,6 +123,7 @@ cpu_callback(struct notifier_block *nfb,
 		}
   		per_cpu(watchdog_task, hotcpu) = p;
 		kthread_bind(p, hotcpu);
+		__touch_softlockup_watchdog(hotcpu);
  		break;
 	case CPU_ONLINE:
 
-- 
1.1.5

