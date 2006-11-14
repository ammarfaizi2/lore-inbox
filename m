Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965335AbWKNMY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965335AbWKNMY0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 07:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965368AbWKNMYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 07:24:25 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:10972 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S965335AbWKNMYY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 07:24:24 -0500
Date: Tue, 14 Nov 2006 17:54:38 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       vatsa@in.ibm.com, dipankar@in.ibm.com, davej@redhat.com, mingo@elte.hu,
       kiran@scalex86.org
Subject: [PATCH 4/4] Handle CPU_LOCK_ACQUIRE and CPU_LOCK_RELEASE in workqueue_cpu_callback.
Message-ID: <20061114122438.GE31787@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061114121832.GA31787@in.ibm.com> <20061114122050.GB31787@in.ibm.com> <20061114122214.GC31787@in.ibm.com> <20061114122325.GD31787@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114122325.GD31787@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In hot-cpu callback function workqueue_cpu_callback, lock the workqueue_mutex 
under CPU_LOCK_ACQUIRE and release it under CPU_LOCK_RELEASE.

This eliminates handling of redundant events namely CPU_DOWN_PREPARE and
CPU_DOWN_FAILED.

Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>

--
 kernel/workqueue.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

Index: hotplug/kernel/workqueue.c
===================================================================
--- hotplug.orig/kernel/workqueue.c
+++ hotplug/kernel/workqueue.c
@@ -638,8 +638,11 @@ static int __devinit workqueue_cpu_callb
 	struct workqueue_struct *wq;
 
 	switch (action) {
-	case CPU_UP_PREPARE:
+	case CPU_LOCK_ACQUIRE:
 		mutex_lock(&workqueue_mutex);
+		break;
+
+	case CPU_UP_PREPARE:
 		/* Create a new workqueue thread for it. */
 		list_for_each_entry(wq, &workqueues, list) {
 			if (!create_workqueue_thread(wq, hotcpu)) {
@@ -658,7 +661,6 @@ static int __devinit workqueue_cpu_callb
 			kthread_bind(cwq->thread, hotcpu);
 			wake_up_process(cwq->thread);
 		}
-		mutex_unlock(&workqueue_mutex);
 		break;
 
 	case CPU_UP_CANCELED:
@@ -670,15 +672,6 @@ static int __devinit workqueue_cpu_callb
 				     any_online_cpu(cpu_online_map));
 			cleanup_workqueue_thread(wq, hotcpu);
 		}
-		mutex_unlock(&workqueue_mutex);
-		break;
-
-	case CPU_DOWN_PREPARE:
-		mutex_lock(&workqueue_mutex);
-		break;
-
-	case CPU_DOWN_FAILED:
-		mutex_unlock(&workqueue_mutex);
 		break;
 
 	case CPU_DEAD:
@@ -686,6 +679,9 @@ static int __devinit workqueue_cpu_callb
 			cleanup_workqueue_thread(wq, hotcpu);
 		list_for_each_entry(wq, &workqueues, list)
 			take_over_work(wq, hotcpu);
+		break;
+
+	case CPU_LOCK_RELEASE:
 		mutex_unlock(&workqueue_mutex);
 		break;
 	}
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
