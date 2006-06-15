Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWFOQzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWFOQzy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 12:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWFOQzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 12:55:54 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:13761 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751367AbWFOQzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 12:55:53 -0400
Date: Thu, 15 Jun 2006 18:55:27 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] cpu hotplug: fix CPU_UP_CANCEL handling
Message-ID: <20060615165527.GA10394@osiris.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

If a cpu hotplug callback fails on CPU_UP_PREPARE, all callbacks will be
called with CPU_UP_CANCELED. A few of these callbacks assume that on
CPU_UP_PREPARE a pointer to task has been stored in a percpu array.
This assumption is not true if CPU_UP_PREPARE fails and the following
calls to kthread_bind() in CPU_UP_CANCELED will cause an addressing
exception because of passing a NULL pointer.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 kernel/sched.c      |    2 ++
 kernel/softirq.c    |    2 ++
 kernel/softlockup.c |    2 ++
 kernel/workqueue.c  |    2 ++
 4 files changed, 8 insertions(+)

diff --git a/kernel/sched.c b/kernel/sched.c
index c13f1bd..293ae8a 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -4746,6 +4746,8 @@ static int migration_call(struct notifie
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
 	case CPU_UP_CANCELED:
+		if (!cpu_rq(cpu)->migration_thread)
+			break;
 		/* Unbind it from offline cpu so it can run.  Fall thru. */
 		kthread_bind(cpu_rq(cpu)->migration_thread,
 			     any_online_cpu(cpu_online_map));
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 336f92d..9e2f1c6 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -470,6 +470,8 @@ static int cpu_callback(struct notifier_
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
 	case CPU_UP_CANCELED:
+		if (!per_cpu(ksoftirqd, hotcpu))
+			break;
 		/* Unbind so it can run.  Fall thru. */
 		kthread_bind(per_cpu(ksoftirqd, hotcpu),
 			     any_online_cpu(cpu_online_map));
diff --git a/kernel/softlockup.c b/kernel/softlockup.c
index 14c7faf..9166df7 100644
--- a/kernel/softlockup.c
+++ b/kernel/softlockup.c
@@ -127,6 +127,8 @@ cpu_callback(struct notifier_block *nfb,
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
 	case CPU_UP_CANCELED:
+		if (!per_cpu(watchdog_task, hotcpu))
+			break;
 		/* Unbind so it can run.  Fall thru. */
 		kthread_bind(per_cpu(watchdog_task, hotcpu),
 			     any_online_cpu(cpu_online_map));
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 880fb41..7790907 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -578,6 +578,8 @@ static int workqueue_cpu_callback(struct
 
 	case CPU_UP_CANCELED:
 		list_for_each_entry(wq, &workqueues, list) {
+			if (!per_cpu_ptr(wq->cpu_wq, hotcpu)->thread)
+				continue;
 			/* Unbind so it can run. */
 			kthread_bind(per_cpu_ptr(wq->cpu_wq, hotcpu)->thread,
 				     any_online_cpu(cpu_online_map));
