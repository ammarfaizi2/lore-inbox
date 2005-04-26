Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVDZRwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVDZRwJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 13:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVDZRuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:50:46 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37622 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261513AbVDZRtX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:49:23 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc3-V0.7.46-01
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050422155549.GB22795@elte.hu>
References: <20050422154931.GA22534@elte.hu>
	 <Pine.LNX.4.44.0504220852310.22042-100000@dhcp153.mvista.com>
	 <20050422155549.GB22795@elte.hu>
Content-Type: multipart/mixed; boundary="=-Rz8YUQSfxgNcKrV6AXTM"
Organization: MontaVista
Message-Id: <1114537755.12772.26.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Apr 2005 10:49:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--=-Rz8YUQSfxgNcKrV6AXTM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-04-22 at 08:55, Ingo Molnar wrote:

> i used:
> 
>   ./test --tasks 10 file.hist


This patch cleanup the delays on increased numbers of tasks. It goes on
to of the current plist snapshot. 

Daniel

--=-Rz8YUQSfxgNcKrV6AXTM
Content-Disposition: attachment; filename=fix_pi_list_init.patch
Content-Type: text/x-patch; name=fix_pi_list_init.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6.11/include/linux/plist.h
===================================================================
--- linux-2.6.11.orig/include/linux/plist.h	2005-04-22 19:36:54.000000000 +0000
+++ linux-2.6.11/include/linux/plist.h	2005-04-22 19:38:29.000000000 +0000
@@ -251,7 +251,7 @@
 static inline void plist_del_init(struct plist *pl, struct plist *plist)
 {
         plist_del (pl, plist);
-        plist_init(pl, 0);
+        plist_init(pl, INT_MAX);
 }
 
 /* Return the priority a pl node */
Index: linux-2.6.11/include/linux/rt_lock.h
===================================================================
--- linux-2.6.11.orig/include/linux/rt_lock.h	2005-04-21 17:49:26.000000000 +0000
+++ linux-2.6.11/include/linux/rt_lock.h	2005-04-22 22:35:37.000000000 +0000
@@ -95,12 +95,12 @@
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 # define __RT_MUTEX_INITIALIZER(lockname) \
 	{ .wait_lock = RAW_SPIN_LOCK_UNLOCKED, \
-	.wait_list = PLIST_INIT((lockname).wait_list, 0),  \
+	.wait_list = PLIST_INIT((lockname).wait_list, MAX_PRIO),  \
 	.name = #lockname, .file = __FILE__, .line = __LINE__ }
 #else
 # define __RT_MUTEX_INITIALIZER(lockname) \
 	{ .wait_lock = RAW_SPIN_LOCK_UNLOCKED, \
-	PLIST_INIT((lockname).wait_list, 0) }
+	PLIST_INIT((lockname).wait_list, MAX_PRIO) }
 #endif
 /*
  * RW-semaphores are an RT mutex plus a reader-depth count.
Index: linux-2.6.11/kernel/rt.c
===================================================================
--- linux-2.6.11.orig/kernel/rt.c	2005-04-22 15:05:33.000000000 +0000
+++ linux-2.6.11/kernel/rt.c	2005-04-22 22:34:22.000000000 +0000
@@ -939,6 +939,7 @@
 
 	set_task_state(task, TASK_UNINTERRUPTIBLE);
 
+	plist_init (&waiter.list, task->prio);
 	task_blocks_on_lock(&waiter, task, lock, eip);
 
 	TRACE_BUG_ON(!irqs_disabled());

--=-Rz8YUQSfxgNcKrV6AXTM--

