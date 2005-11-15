Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbVKOWhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbVKOWhS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 17:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbVKOWhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 17:37:17 -0500
Received: from fmr22.intel.com ([143.183.121.14]:47024 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932550AbVKOWhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 17:37:15 -0500
Message-Id: <200511152237.jAFMb5g14072@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Cc: "Luck, Tony" <tony.luck@intel.com>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "Seth, Rohit" <rohit.seth@intel.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>, <akpm@osdl.org>
Subject: [patch] cpu_idle performance bug fix
Date: Tue, 15 Nov 2005 14:37:05 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXqNRqL684iuXzIS9WYbey9t6WQRg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

Our performance validation on 2.6.15-rc1 caught a disastrous
performance regression with netperf (-98%) and volanomark (-58%)
compares to previous kernel version 2.6.14-git7.  See the following
chart (result group 1 & 2).

http://kernel-perf.sourceforge.net/results.machine_id=26.html


We have root caused it to this changeset: http://tinyurl.com/cetoa

This changeset broke the ia64 task resched notification.  In
sched.c:resched_task(), a reschedule IPI is conditioned upon
TIF_POLLING_NRFLAG.  However, the above changeset unconditionally
set the polling thread flag for idle tasks regardless whether
pal_halt_light is in use or not.  As a result, resched IPI is not
sent from resched_task().  And since the default behavior on ia64
is to use pal_halt_light, we end up delaying the rescheduling task
until next timer tick, and thus cause the performance regression.

Here is the patch to fix the performance bug.  I'm glad our performance
suite is turning up bad performance bug like this in time.  

Tony, since this is such a catastrophic performance failure, please
consider merge this fix for 2.6.15-rc2.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- ./arch/ia64/kernel/process.c.orig	2005-11-15 11:43:30.019045450 -0800
+++ ./arch/ia64/kernel/process.c	2005-11-15 12:15:27.116678215 -0800
@@ -202,12 +202,9 @@ default_idle (void)
 {
 	local_irq_enable();
 	while (!need_resched()) {
-		if (can_do_pal_halt) {
-			local_irq_disable();
-			if (!need_resched())
-				safe_halt();
-			local_irq_enable();
-		} else
+		if (can_do_pal_halt)
+			safe_halt();
+		else
 			cpu_relax();
 	}
 }
@@ -272,10 +269,14 @@ cpu_idle (void)
 {
 	void (*mark_idle)(int) = ia64_mark_idle;
   	int cpu = smp_processor_id();
-	set_thread_flag(TIF_POLLING_NRFLAG);
 
 	/* endless idle loop with no priority at all */
 	while (1) {
+		if (can_do_pal_halt)
+			clear_thread_flag(TIF_POLLING_NRFLAG);
+		else
+			set_thread_flag(TIF_POLLING_NRFLAG);
+
 		if (!need_resched()) {
 			void (*idle)(void);
 #ifdef CONFIG_SMP

