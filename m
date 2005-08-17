Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbVHQTef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVHQTef (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 15:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVHQTef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 15:34:35 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:46547 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751223AbVHQTef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 15:34:35 -0400
Subject: Re: 2.6.13-rc6-rt6
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1124299967.5764.187.camel@localhost.localdomain>
References: <1124208507.5764.20.camel@localhost.localdomain>
	 <20050816163202.GA5288@elte.hu> <20050816163730.GA7879@elte.hu>
	 <20050816165247.GA10386@elte.hu> <20050816170805.GA12959@elte.hu>
	 <1124214647.5764.40.camel@localhost.localdomain>
	 <1124215631.5764.43.camel@localhost.localdomain>
	 <1124218245.5764.52.camel@localhost.localdomain>
	 <1124252419.5764.83.camel@localhost.localdomain>
	 <1124257580.5764.105.camel@localhost.localdomain>
	 <20050817064750.GA8395@elte.hu>
	 <1124299967.5764.187.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 17 Aug 2005 15:34:18 -0400
Message-Id: <1124307258.5186.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 13:32 -0400, Steven Rostedt wrote:
> On Wed, 2005-08-17 at 08:47 +0200, Ingo Molnar wrote:
> 
> > but stop_machine() looks quite preempt-unsafe to begin with. The 
> > local_irq_disable() would not be needed at all if prior the 
> > for_each_online_cpu() loop we'd use set_cpus_allowed. The current method 
> > of achieving 'no preemption' is simply racy even during normal 
> > CONFIG_PREEMPT.
> 
> The code does look flakey, but I think it still works, and it may need
> to have a raw_local_irq_disable.

I added this patch to my AMD box is it runs fine.  So I'm assuming that
we do actually want interrupts disabled here.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux_realtime_goliath/kernel/stop_machine.c
===================================================================
--- linux_realtime_goliath/kernel/stop_machine.c	(revision 295)
+++ linux_realtime_goliath/kernel/stop_machine.c	(working copy)
@@ -40,7 +40,7 @@
 	while (stopmachine_state != STOPMACHINE_EXIT) {
 		if (stopmachine_state == STOPMACHINE_DISABLE_IRQ 
 		    && !irqs_disabled) {
-			local_irq_disable();
+			raw_local_irq_disable();
 			irqs_disabled = 1;
 			/* Ack: irqs disabled. */
 			smp_mb(); /* Must read state first. */
@@ -66,7 +66,7 @@
 	atomic_inc(&stopmachine_thread_ack);
 
 	if (irqs_disabled)
-		local_irq_enable();
+		raw_local_irq_enable();
 	if (prepared)
 		preempt_enable();
 
@@ -120,7 +120,7 @@
 	}
 
 	/* Don't schedule us away at this point, please. */
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	/* Now they are all started, make them hold the CPUs, ready. */
 	stopmachine_set_state(STOPMACHINE_PREPARE);
@@ -134,7 +134,7 @@
 static void restart_machine(void)
 {
 	stopmachine_set_state(STOPMACHINE_EXIT);
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 struct stop_machine_data


