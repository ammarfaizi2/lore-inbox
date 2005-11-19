Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVKSUwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVKSUwg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 15:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbVKSUwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 15:52:36 -0500
Received: from fsmlabs.com ([168.103.115.128]:53134 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1750824AbVKSUwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 15:52:34 -0500
X-ASG-Debug-ID: 1132433549-13440-16-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Sat, 19 Nov 2005 12:58:03 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Con Kolivas <kernel@kolivas.org>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck@vds.kolivas.org, tony@atomide.com
X-ASG-Orig-Subj: Re: [PATCH] i386 no idle hz - aka dynticks v051118-1
Subject: Re: [PATCH] i386 no idle hz - aka dynticks v051118-1
In-Reply-To: <200511182322.11222.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.61.0511191237020.20310@montezuma.fsmlabs.com>
References: <200511182322.11222.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5405
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It may be a little hard to see my comments as i've re-attached the patch 
inline as i couldn't reply-to properly (it was an attachment).

@@ -932,6 +933,9 @@ void (*wait_timer_tick)(void) __devinitd
 
 #define APIC_DIVISOR 16
 
+static u32 apic_timer_val;

__read_mostly ?

+void dyn_tick_interrupt(int irq, struct pt_regs *regs)
+{
+	int all_were_sleeping = 0;
+	int cpu = smp_processor_id();
+
+	if (!cpu_isset(cpu, nohz_cpu_mask))
+		return;
+
+	spin_lock(dyn_tick_lock);

This is going to cause contention problems for things like 
smp_call_function since all processors will be calling back to 
dyn_tick_interrupt.

+	if (cpus_equal(nohz_cpu_mask, cpu_online_map))
+		all_were_sleeping = 1;
+	cpu_clear(cpu, nohz_cpu_mask);
+
+	if (all_were_sleeping) {
+		/* Recover jiffies */
+		if (irq) {

Perhaps simply call the 'irq' parameter as in_irq as right now it seems to 
mean anything between irq or vector and somewhat confusing.

@@ -1190,15 +1191,19 @@ static inline void ioapic_register_intr(
 		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
 				trigger == IOAPIC_LEVEL)
 			irq_desc[vector].handler = &ioapic_level_type;
-		else
+		else if (vector)
 			irq_desc[vector].handler = &ioapic_edge_type;
+		else
+			irq_desc[vector].handler = IOAPIC_EDGE_TYPE_IRQ0;

Please at least be explicit and not hide things behind #defines

if (vector == 0)
	irq_desc[vector].handler = &ioapic_edge_type_irq0

 DEFINE_PER_CPU(irq_cpustat_t, irq_stat) ____cacheline_maxaligned_in_smp;
 EXPORT_PER_CPU_SYMBOL(irq_stat);
@@ -76,6 +77,8 @@ fastcall unsigned int do_IRQ(struct pt_r
 	}
 #endif
 
+	dyn_tick_interrupt(irq, regs);

This looks like it might contribute quite some contention in the irq fast 
path.

Thanks,
	Zwane

