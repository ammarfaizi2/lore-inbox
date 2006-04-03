Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751702AbWDCPYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbWDCPYi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 11:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWDCPYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 11:24:38 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:44986 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751668AbWDCPYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 11:24:38 -0400
Subject: [PATCH 01/02 -rt] Allow for HRTIMER_RESTART in a CB_IRQSAFE
	callback.
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>, rostedt@goodmis.org
Content-Type: text/plain
Date: Mon, 03 Apr 2006 11:24:21 -0400
Message-Id: <1144077861.21444.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simply requeues a CB if HRTIMER_RESTART is set in CB_IRQSAFE
hrtimer_interrupt.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-rt12/kernel/hrtimer.c
===================================================================
--- linux-2.6.16-rt12.orig/kernel/hrtimer.c	2006-04-02 16:06:52.000000000 -0400
+++ linux-2.6.16-rt12/kernel/hrtimer.c	2006-04-03 10:57:18.000000000 -0400
@@ -838,8 +838,10 @@ int hrtimer_interrupt(void)
 			if (timer->mode == HRTIMER_CB_IRQSAFE) {
 				int ret = timer->function(timer);
 
-				BUG_ON(ret != HRTIMER_NORESTART);
-				timer->node.rb_parent = HRTIMER_INACTIVE;
+				if (ret == HRTIMER_RESTART)
+					enqueue_hrtimer(timer, base);
+				else
+					timer->node.rb_parent = HRTIMER_INACTIVE;
 			} else {
 				hrtimer_add_cb_pending(timer, base);
 				raise = 1;


