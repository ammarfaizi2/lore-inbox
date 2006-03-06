Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWCFQkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWCFQkx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 11:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWCFQkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 11:40:53 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:27598 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751073AbWCFQkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 11:40:52 -0500
Date: Mon, 6 Mar 2006 11:40:34 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Andi Kleen <ak@muc.de>, Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [RFC][PATCH] kdump: x86_64 timer interrupt lockup due to pending interrupt
Message-ID: <20060306164034.GB10594@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


o check_timer() routine fails while second kernel is booting after a crash
  on an opetron box. Problem happens because timer vector (0x31) seems to be
  locked.

o After a system crash, it is not safe to service interrupts any more, hence
  interrupts are disabled. This leads to pending interrupts at LAPIC. LAPIC
  sends these interrupts to the CPU during early boot of second kernel. Other
  pending interrupts are discarded saying unexpected trap but timer interrupt
  is serviced and CPU does not issue an LAPIC EOI because it think this
  interrupt came from i8259 and sends ack to 8259. This leads to vector 0x31
  locking as LAPIC does not clear respective ISR and keeps on waiting for
  EOI.

o In this patch, one extra EOI is being issued in check_timer() to unlock the
  vector. Please suggest if there is a better way to handle this situation.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/io_apic.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+)

diff -puN arch/x86_64/kernel/io_apic.c~x86_64-kdump-pending-timer-interrupt-fix arch/x86_64/kernel/io_apic.c
--- linux-2.6.16-rc5-16M/arch/x86_64/kernel/io_apic.c~x86_64-kdump-pending-timer-interrupt-fix	2006-03-03 12:25:51.000000000 -0500
+++ linux-2.6.16-rc5-16M-root/arch/x86_64/kernel/io_apic.c	2006-03-03 12:32:05.000000000 -0500
@@ -1809,6 +1809,21 @@ static inline void check_timer(void)
 	if (timer_over_8254 > 0)
 		enable_8259A_irq(0);
 
+#ifdef CONFIG_CRASH_DUMP
+	/*
+	 * After a crash, we no longer service the interrupts and a pending
+	 * timer interrupt (0x31) from previous kernel might still have ISR
+	 * bit set. Most probably by now CPU has serviced that pending
+	 * interrupt and it did not do ack_APIC_irq() because it thought,
+	 * interrupt came from i8259 as ExtInt. LAPIC did not get EOI so it
+	 * does not clear the ISR bit and cpu thinks it has already serivced
+	 * the interrupt. Hence vector 0x31 is locked. Issue an extra EOI to
+	 * LAPIC to unlock.
+	 */
+	if (!disable_apic)
+		ack_APIC_irq();
+#endif
+
 	pin1  = find_isa_irq_pin(0, mp_INT);
 	apic1 = find_isa_irq_apic(0, mp_INT);
 	pin2  = ioapic_i8259.pin;
_
