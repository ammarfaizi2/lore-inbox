Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWGRDZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWGRDZq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 23:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWGRDZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 23:25:46 -0400
Received: from mail.ccur.com ([66.10.65.12]:63171 "EHLO mail.ccur.com")
	by vger.kernel.org with ESMTP id S1750742AbWGRDZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 23:25:46 -0400
Subject: [PATCH] Re: cond_resched() fix
From: Jim Houston <jim.houston@ccur.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Concurrent Computer Corp.
Date: Mon, 17 Jul 2006 23:25:43 -0400
Message-Id: <1153193143.6799.26.camel@x2.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jul 2006 03:25:45.0011 (UTC) FILETIME=[DAE6F030:01C6AA19]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I found an off by one error in your recent cond_resched fix.  In
cond_resched_lock() it calls __resched_legal()
before dropping the spin lock.  __resched_legal() will
always finds the preempt_count non-zero and will prevent
the call to __cond_resched().

The attached patch adds a parameter to __resched_legal()
with the expected preempt_count value.  The patch was made
against a Linus's git tree.  It will apply cleanly to
linux-2.6.18-rc2.

Jim Houston - Concurrent Computer Corp.

--
--- linux-2.6/kernel/sched.c.orig	2006-07-17 09:30:05.000000000 -0400
+++ linux-2.6/kernel/sched.c	2006-07-17 23:00:50.000000000 -0400
@@ -4456,9 +4456,9 @@
 	return 0;
 }
 
-static inline int __resched_legal(void)
+static inline int __resched_legal(int expected_preempt_count)
 {
-	if (unlikely(preempt_count()))
+	if (unlikely(preempt_count() != expected_preempt_count))
 		return 0;
 	if (unlikely(system_state != SYSTEM_RUNNING))
 		return 0;
@@ -4484,7 +4484,7 @@
 
 int __sched cond_resched(void)
 {
-	if (need_resched() && __resched_legal()) {
+	if (need_resched() && __resched_legal(0)) {
 		__cond_resched();
 		return 1;
 	}
@@ -4510,7 +4510,7 @@
 		ret = 1;
 		spin_lock(lock);
 	}
-	if (need_resched() && __resched_legal()) {
+	if (need_resched() && __resched_legal(1)) {
 		spin_release(&lock->dep_map, 1, _THIS_IP_);
 		_raw_spin_unlock(lock);
 		preempt_enable_no_resched();
@@ -4526,7 +4526,7 @@
 {
 	BUG_ON(!in_softirq());
 
-	if (need_resched() && __resched_legal()) {
+	if (need_resched() && __resched_legal(0)) {
 		raw_local_irq_disable();
 		_local_bh_enable();
 		raw_local_irq_enable();


