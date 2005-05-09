Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVEIOg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVEIOg5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 10:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVEIOfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 10:35:37 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:38319 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261416AbVEIOcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 10:32:42 -0400
Message-ID: <427F7642.8D5DC3F2@tv-sign.ru>
Date: Mon, 09 May 2005 18:40:02 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: [PATCH 4/4] rt_mutex: possible bugfixes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my first look at the kernel/rt.c, so I am probably very wrong.


pi_setprio()
	if (rt_task(p) && plist_empty(&w->pi_list)) {
	                  ^^^^^^^^^^^
		plist_init(&w->pi_list, prio);
		plist_add(&w->pi_list, &lock->owner->pi_waiters);

plist_empty() checks list_empty(&w->pi_list->dp_node), this does not
garantees that this w->pi_list is not on list, because all nodes with
the same priority have empty ->dp_node, except the first one.
I have changed this to plist_unhashed(&w->pi_list).


__up_mutex()
	RACE_BUG_ON(!lock->wait_list.dp_node.prev && !lock->wait_list.dp_node.next);
	                                         ^^^^
I guess, this should be '||' ?


init_lists()
	// we have to do this until the static initializers get fixed:
	if (!lock->wait_list.dp_node.prev && !lock->wait_list.dp_node.next)

I can't understand this comment, just changed ->dp_node to ->prio_list.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- V0.7.47-01/kernel/rt.c~3_UNSURE	2005-05-09 19:13:33.000000000 +0400
+++ V0.7.47-01/kernel/rt.c	2005-05-09 19:43:47.000000000 +0400
@@ -627,7 +627,7 @@ static void pi_setprio(struct rt_mutex *
 		lock = w->lock;
 		TRACE_BUG_ON(!lock);
 		TRACE_BUG_ON(!lock->owner);
-		if (rt_task(p) && plist_empty(&w->pi_list)) {
+		if (rt_task(p) && plist_unhashed(&w->pi_list)) {
 			TRACE_BUG_ON(was_rt);
 			w->pi_list.prio = prio;
 			plist_add(&w->pi_list, &lock->owner->pi_waiters);
@@ -645,7 +645,7 @@ static void pi_setprio(struct rt_mutex *
 		 * (TODO: this can be unfair to SCHED_NORMAL tasks if they
 		 *        get PI handled.)
 		 */
-		if (!rt_task(p) && !plist_empty(&w->pi_list)) {
+		if (!rt_task(p) && !plist_unhashed(&w->pi_list)) {
 			TRACE_BUG_ON(!was_rt);
 			plist_del(&w->pi_list);
 			plist_del(&w->list);
@@ -788,7 +788,7 @@ static inline struct task_struct * pick_
 static inline void init_lists(struct rt_mutex *lock)
 {
 	// we have to do this until the static initializers get fixed:
-	if (!lock->wait_list.dp_node.prev && !lock->wait_list.dp_node.next)
+	if (!lock->wait_list.prio_list.prev && !lock->wait_list.prio_list.next)
 		pl_head_init(&lock->wait_list);
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 	if (!lock->held_list.prev && !lock->held_list.next)
@@ -1315,7 +1315,7 @@ static void __up_mutex(struct rt_mutex *
 	trace_lock_irqsave(&trace_lock, flags);
 	TRACE_BUG_ON(!irqs_disabled());
 	spin_lock(&lock->wait_lock);
-	TRACE_BUG_ON(!lock->wait_list.dp_node.prev && !lock->wait_list.dp_node.next);
+	TRACE_BUG_ON(!lock->wait_list.prio_list.prev || !lock->wait_list.prio_list.next);
 
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 	TRACE_WARN_ON(list_empty(&lock->held_list));
