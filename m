Return-Path: <linux-kernel-owner+w=401wt.eu-S967805AbWLILlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967805AbWLILlw (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 06:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967808AbWLILlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 06:41:52 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55405 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967805AbWLILlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 06:41:51 -0500
Date: Sat, 9 Dec 2006 12:40:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [patch] high-res timers: PIT broadcasting fix
Message-ID: <20061209114041.GA32227@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] high-res timers: PIT broadcasting fix
From: Thomas Gleixner <tglx@linutronix.de>

systems that enter C3 and have to turn off the APIC we
fall back to the PIT as the clock events source which
emulates a local events source. Dynticks exposed a bug in
the broadcast/local-events emulation code: if the PIT
IRQ came earlier than the next high-res timer on an idle
CPU would have needed, then the PIT was not reprogrammed
for followup irqs.

(also, clean things up a bit by splitting out the broadcast
 reprogramming logic into clockevents_reprogram_broadcast())

this bug can explain certain rare boot-time hangs on C3-capable
laptops that run with HIGH_RES_TIMERS and NO_HZ enabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/time/clockevents.c |   60 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 18 deletions(-)

Index: linux/kernel/time/clockevents.c
===================================================================
--- linux.orig/kernel/time/clockevents.c
+++ linux/kernel/time/clockevents.c
@@ -529,6 +529,32 @@ static cpumask_t local_event_broadcast;
 static void (*broadcast_function)(cpumask_t *mask);
 static void (*global_event_handler)(struct pt_regs *regs);
 
+/*
+ * Reprogram the broadcast device:
+ *
+ * Called with events_lock held and interrupts disabled.
+ */
+static void clockevents_reprogram_broadcast(void)
+{
+	struct clock_event_device *glblevt = global_eventdevice.event;
+	struct local_events *dev;
+	ktime_t expires = { .tv64 = KTIME_MAX };
+	int64_t delta;
+	int cpu;
+
+	for (cpu = first_cpu(local_event_broadcast); cpu != NR_CPUS;
+	     cpu = next_cpu(cpu, local_event_broadcast)) {
+		dev = &per_cpu(local_eventdevices, cpu);
+		if (dev->expires_next.tv64 < expires.tv64)
+			expires = dev->expires_next;
+	}
+
+	if (expires.tv64 != KTIME_MAX) {
+		delta = ktime_to_ns(ktime_sub(expires, ktime_get()));
+		do_clockevents_set_next_event(glblevt, delta);
+	}
+}
+
 /**
  * clockevents_set_broadcast - switch next event device from/to broadcast mode
  *
@@ -538,10 +564,7 @@ static void (*global_event_handler)(stru
 void clockevents_set_broadcast(struct clock_event_device *evt, int broadcast)
 {
 	struct local_events *devices = &__get_cpu_var(local_eventdevices);
-	struct clock_event_device *glblevt = global_eventdevice.event;
 	int cpu = smp_processor_id();
-	ktime_t expires = { .tv64 = KTIME_MAX };
-	int64_t delta;
 	unsigned long flags;
 
 	if (devices->nextevt != evt)
@@ -558,19 +581,7 @@ void clockevents_set_broadcast(struct cl
 		if (devices->expires_next.tv64 != KTIME_MAX)
 			clockevents_set_next_event(devices->expires_next, 1);
 	}
-
-	/* Reprogram the broadcast device */
-	for (cpu = first_cpu(local_event_broadcast); cpu != NR_CPUS;
-	     cpu = next_cpu(cpu, local_event_broadcast)) {
-		devices = &per_cpu(local_eventdevices, cpu);
-		if (devices->expires_next.tv64 < expires.tv64)
-			expires = devices->expires_next;
-	}
-
-	if (expires.tv64 != KTIME_MAX) {
-		delta = ktime_to_ns(ktime_sub(expires, ktime_get()));
-		do_clockevents_set_next_event(glblevt, delta);
-	}
+	clockevents_reprogram_broadcast();
 
 	spin_unlock_irqrestore(&events_lock, flags);
 }
@@ -637,9 +648,22 @@ static void handle_nextevt_broadcast(str
 			cpu_set(cpu, mask);
 		}
 	}
+	if (!cpus_empty(mask)) {
+		/*
+		 * Wakeup the cpus which have an expired event. The
+		 * global event is reprogrammed in the return from
+		 * idle code.
+		 */
+		broadcast_function(&mask);
+	} else {
+		/*
+		 * The global event did not expire any CPU local
+		 * events. This happens in dyntick mode, as the
+		 * maximum PIT delta is quite small.
+		 */
+		clockevents_reprogram_broadcast();
+	}
 	spin_unlock(&events_lock);
-	/* Wakeup the cpus which have an expired event */
-	broadcast_function(&mask);
 }
 
 /*
