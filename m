Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWEZQLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWEZQLc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWEZQLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:11:22 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:34710 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750977AbWEZQLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:11:04 -0400
Message-Id: <20060526161036.915977618@goodmis.org>
References: <20060526160651.870725515@goodmis.org>
User-Agent: quilt/0.44-1
Date: Fri, 26 May 2006 12:06:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Mark Knecht <markknecht@gmail.com>,
       Clark Williams <williams@redhat.com>,
       Robert Crocombe <rwcrocombe@raytheon.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
Subject: [PATCH -rt 2/2] Fix condition in default_idle
Content-Disposition: inline; filename=fix-default_idle.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The condition statement in default_idle had the conjunctions backwards.
Instead of && it had || so the idle thread would never be preempted.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-rt23/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.16-rt23.orig/arch/x86_64/kernel/process.c	2006-05-26 10:41:30.000000000 -0400
+++ linux-2.6.16-rt23/arch/x86_64/kernel/process.c	2006-05-26 10:41:44.000000000 -0400
@@ -120,9 +120,9 @@ void default_idle(void)
 
 	clear_thread_flag(TIF_POLLING_NRFLAG);
 	smp_mb__after_clear_bit();
-	while (!need_resched() || !need_resched_delayed()) {
+	while (!need_resched() && !need_resched_delayed()) {
 		local_irq_disable();
-		if (!need_resched() || !need_resched_delayed())
+		if (!need_resched() && !need_resched_delayed())
 			safe_halt();
 		else
 			local_irq_enable();

--
