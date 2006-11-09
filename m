Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424270AbWKIXkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424270AbWKIXkT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424268AbWKIXkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:40:09 -0500
Received: from www.osadl.org ([213.239.205.134]:58268 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161866AbWKIXjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:39:08 -0500
Message-Id: <20061109233034.870801000@cruncher.tec.linutronix.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
Date: Thu, 09 Nov 2006 23:38:24 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Len Brown <lenb@kernel.org>, John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 07/19] ACPI: Add state propagation for dynamic broadcasting
Content-Disposition: inline;
	filename=acpi-add-hres-dyntick-broadcast-support.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

This is a preparatory patch for high resolution timers and dynticks.

The local APIC timer is fast and per CPU, but it gets stopped in C3 state.
On some broken systems, especially AMD based ones it gets stopped in C2. This
also affects akpm's jinxed VAIO.

The broadcast function informs the local APIC management code that a state
which stops the local APIC is going to be entered/exited. This switches the
local APIC timer to the PIT broadcast mode. The clockevents layer takes care
of the distribution of events.

The lapic_timer_idle_broadcast() function is an empty inline for now, which
will be replaced by the later clockevents patches for the affected
architectures.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux-2.6.19-rc5-mm1/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/drivers/acpi/processor_idle.c	2006-11-09 21:13:00.000000000 +0100
+++ linux-2.6.19-rc5-mm1/drivers/acpi/processor_idle.c	2006-11-09 21:13:06.000000000 +0100
@@ -281,11 +281,27 @@ static void acpi_propagate_timer_broadca
 		on_each_cpu(switch_ipi_to_APIC_timer, &mask, 1, 1);
 }
 
+/* Power(C) State timer broadcast control */
+static void acpi_state_timer_broadcast(struct acpi_processor *pr,
+				       struct acpi_processor_cx *cx,
+				       int broadcast)
+{
+	int state = cx - pr->power.states;
+
+	if (state >= pr->power.timer_broadcast_on_state)
+		lapic_timer_idle_broadcast(broadcast);
+}
+
 #else
 
 static void acpi_timer_check_state(int state, struct acpi_processor *pr,
 				   struct acpi_processor_cx *cstate) { }
 static void acpi_propagate_timer_broadcast(struct acpi_processor *pr) { }
+static void acpi_state_timer_broadcast(struct acpi_processor *pr,
+				       struct acpi_processor_cx *cx,
+				       int broadcast)
+{
+}
 
 #endif
 
@@ -431,6 +447,7 @@ static void acpi_processor_idle(void)
 		/* Get start time (ticks) */
 		t1 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Invoke C2 */
+		acpi_state_timer_broadcast(pr, cx, 1);
 		acpi_cstate_enter(cx);
 		/* Get end time (ticks) */
 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
@@ -445,6 +462,7 @@ static void acpi_processor_idle(void)
 		/* Compute time (ticks) that we were actually asleep */
 		sleep_ticks =
 		    ticks_elapsed(t1, t2) - cx->latency_ticks - C2_OVERHEAD;
+		acpi_state_timer_broadcast(pr, cx, 0);
 		break;
 
 	case ACPI_STATE_C3:
@@ -467,6 +485,7 @@ static void acpi_processor_idle(void)
 		/* Get start time (ticks) */
 		t1 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Invoke C3 */
+		acpi_state_timer_broadcast(pr, cx, 1);
 		acpi_cstate_enter(cx);
 		/* Get end time (ticks) */
 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
@@ -487,6 +506,7 @@ static void acpi_processor_idle(void)
 		/* Compute time (ticks) that we were actually asleep */
 		sleep_ticks =
 		    ticks_elapsed(t1, t2) - cx->latency_ticks - C3_OVERHEAD;
+		acpi_state_timer_broadcast(pr, cx, 0);
 		break;
 
 	default:
Index: linux-2.6.19-rc5-mm1/include/asm-i386/apic.h
===================================================================
--- linux-2.6.19-rc5-mm1.orig/include/asm-i386/apic.h	2006-11-09 21:14:36.000000000 +0100
+++ linux-2.6.19-rc5-mm1/include/asm-i386/apic.h	2006-11-09 21:16:34.000000000 +0100
@@ -113,6 +113,7 @@ extern void setup_secondary_APIC_clock (
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
+static inline void lapic_timer_idle_broadcast(int broadcast) { }
 
 extern void enable_NMI_through_LVT0 (void * dummy);
 
Index: linux-2.6.19-rc5-mm1/include/asm-x86_64/apic.h
===================================================================
--- linux-2.6.19-rc5-mm1.orig/include/asm-x86_64/apic.h	2006-11-08 16:40:14.000000000 +0100
+++ linux-2.6.19-rc5-mm1/include/asm-x86_64/apic.h	2006-11-09 21:17:00.000000000 +0100
@@ -84,6 +84,7 @@ extern int APIC_init_uniprocessor (void)
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
 extern void clustered_apic_check(void);
+static inline void lapic_timer_idle_broadcast(int broadcast) { }
 
 extern void setup_APIC_extened_lvt(unsigned char lvt_off, unsigned char vector,
 				   unsigned char msg_type, unsigned char mask);

--

