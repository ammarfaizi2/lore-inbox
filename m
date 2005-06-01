Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVFAOSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVFAOSr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVFAORO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:17:14 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:5619 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261391AbVFAONd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:13:33 -0400
Date: Wed, 1 Jun 2005 07:13:30 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
cc: linux-kernel@vger.kernel.org
Subject: RT and pi_test
Message-ID: <Pine.LNX.4.44.0506010706000.23057-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I've run the pi_test a few times recently with some strange 
numbers. I'm getting abnormally high task latency if I run 
"./test --tasks=10 ./hist" . Depending on how long I run it, I've seen 
task latency as high as 3 milliseconds, should be 0.1ms or less.

The first time I saw these latencies I has the PI abstraction applied, and 
the most recent time I had the attached patch applied only. This patch is 
small so I'm not sure if it could have that type of effect on task 
latency.

btw, 'm not incrementing the RTC priority.

Daniel


Index: linux-2.6.11/include/linux/plist.h
===================================================================
--- linux-2.6.11.orig/include/linux/plist.h	2005-05-27 22:04:12.000000000 +0000
+++ linux-2.6.11/include/linux/plist.h	2005-06-01 13:12:37.000000000 +0000
@@ -83,7 +83,7 @@ struct plist {
  * @member:     the name of the list_struct within the struct.
  */
 #define plist_entry(ptr, type, member) \
-        container_of(plist_first(ptr), type, member)
+        container_of(ptr, type, member)
 /**
  * plist_for_each  -       iterate over the plist
  * @pos1:        the type * to use as a loop counter.
Index: linux-2.6.11/kernel/rt.c
===================================================================
--- linux-2.6.11.orig/kernel/rt.c	2005-06-01 13:06:21.000000000 +0000
+++ linux-2.6.11/kernel/rt.c	2005-06-01 13:50:08.000000000 +0000
@@ -773,7 +773,7 @@ static inline struct task_struct * pick_
 	 *
 	 * (same-prio RT tasks go FIFO)
 	 */
-	waiter = plist_entry(&lock->wait_list, struct rt_mutex_waiter, list);
+	waiter = plist_entry(plist_first(&lock->wait_list), struct rt_mutex_waiter, list);
 
 	trace_special_pid(waiter->task->pid, waiter->task->prio, 0);
 
@@ -1351,7 +1351,7 @@ static void __up_mutex(struct rt_mutex *
 	 */
 	prio = mutex_getprio(old_owner);
 	if (!plist_empty(&old_owner->pi_waiters)) {
-		w = plist_entry(&old_owner->pi_waiters, struct rt_mutex_waiter, pi_list);
+		w = plist_entry(plist_first(&old_owner->pi_waiters), struct rt_mutex_waiter, pi_list);
 		if (w->task->prio < prio)
 			prio = w->task->prio;
 	}

