Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbVKAOyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbVKAOyQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 09:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVKAOyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 09:54:15 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:10174 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750826AbVKAOyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 09:54:15 -0500
Date: Tue, 1 Nov 2005 15:54:02 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] cpu hoptlug: avoid usage of smp_processor_id() in preemptible code
Message-ID: <20051101145402.GA20255@osiris.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Replace smp_processor_id() with any_online_cpu(cpu_online_map) in order
to avoid lots of
"BUG: using smp_processor_id() in preemptible [00000001] code:..."
messages in case taking a cpu online fails.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

diffstat:
 kernel/sched.c      |    3 ++-
 kernel/softirq.c    |    3 ++-
 kernel/softlockup.c |    3 ++-
 kernel/workqueue.c  |    2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index 340dd23..d94ceef 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -4680,7 +4680,8 @@ static int migration_call(struct notifie
 #ifdef CONFIG_HOTPLUG_CPU
 	case CPU_UP_CANCELED:
 		/* Unbind it from offline cpu so it can run.  Fall thru. */
-		kthread_bind(cpu_rq(cpu)->migration_thread,smp_processor_id());
+		kthread_bind(cpu_rq(cpu)->migration_thread,
+			     any_online_cpu(cpu_online_map));
 		kthread_stop(cpu_rq(cpu)->migration_thread);
 		cpu_rq(cpu)->migration_thread = NULL;
 		break;
diff --git a/kernel/softirq.c b/kernel/softirq.c
index f766b2f..ad3295c 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -470,7 +470,8 @@ static int __devinit cpu_callback(struct
 #ifdef CONFIG_HOTPLUG_CPU
 	case CPU_UP_CANCELED:
 		/* Unbind so it can run.  Fall thru. */
-		kthread_bind(per_cpu(ksoftirqd, hotcpu), smp_processor_id());
+		kthread_bind(per_cpu(ksoftirqd, hotcpu),
+			     any_online_cpu(cpu_online_map));
 	case CPU_DEAD:
 		p = per_cpu(ksoftirqd, hotcpu);
 		per_cpu(ksoftirqd, hotcpu) = NULL;
diff --git a/kernel/softlockup.c b/kernel/softlockup.c
index 7597620..a2dcceb 100644
--- a/kernel/softlockup.c
+++ b/kernel/softlockup.c
@@ -123,7 +123,8 @@ cpu_callback(struct notifier_block *nfb,
 #ifdef CONFIG_HOTPLUG_CPU
 	case CPU_UP_CANCELED:
 		/* Unbind so it can run.  Fall thru. */
-		kthread_bind(per_cpu(watchdog_task, hotcpu), smp_processor_id());
+		kthread_bind(per_cpu(watchdog_task, hotcpu),
+			     any_online_cpu(cpu_online_map));
 	case CPU_DEAD:
 		p = per_cpu(watchdog_task, hotcpu);
 		per_cpu(watchdog_task, hotcpu) = NULL;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7cee222..42df83d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -524,7 +524,7 @@ static int __devinit workqueue_cpu_callb
 		list_for_each_entry(wq, &workqueues, list) {
 			/* Unbind so it can run. */
 			kthread_bind(per_cpu_ptr(wq->cpu_wq, hotcpu)->thread,
-				     smp_processor_id());
+				     any_online_cpu(cpu_online_map));
 			cleanup_workqueue_thread(wq, hotcpu);
 		}
 		break;
