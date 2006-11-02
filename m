Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWKBSDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWKBSDJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 13:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWKBSDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 13:03:08 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:31417 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751354AbWKBSDG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 13:03:06 -0500
Date: Thu, 2 Nov 2006 13:01:39 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Morton Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>, mingo@elte.hu,
       tglx@linutronix.de, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [RFC][PATCH 2.6.19-rc4-mm1] Check for clock event device handler being non NULL before calling it
Message-ID: <20061102180139.GC8074@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


o Kdump broke in 2.6.19-rc4-mm1 on i386 due to LAPIC timer interrupt handling
  changes. (clock events)

o Problems happens because a pending LAPIC timer interrupt is received
  as soon as kernel enables interrupts first time during boot but 
  associated clock event device has not been initialized yet and
  kernel crashes.

o One can receive a pending LAPIC timer interrupt from previous kernel's
  context (as in kdump).  

o A pending LAPIC timer interrupt is delivedred to CPU in second kernel as
  soon as interrupts are enabled. Already idt vector has been set to handle
  LAPIC timer interrupts but actually LPAIC is setup in setup_local_APIC()
  much later. setup_local_APIC() also initializes LAPIC timer and in turn
  related clock_event_device. But here interrupts comes really early and LAPIC
  has not been set, associated clock_event_device structure has not been
  initialized hence kernel crashes in smp_apic_timer_interrupt().

o One of the possible solution is that register the LAPIC timer vector late
  after LAPIC has been initialized. But this would only solve the problem
  for boot cpu and not other cpus.

o In this patch, I check for clock_event_device event handler and if
  handler is NULL, that interrupt is ignored as spurious one. Not the best
  way to handle the situation as it does not count for bugs in
  clock_event_device creation and registration logic, and also introduces
  un-necessary check in fastpath. Pleaes suggest if there is a better way
  to handle this.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/kernel/apic.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff -puN arch/i386/kernel/apic.c~debug1-patch arch/i386/kernel/apic.c
--- linux-2.6.19-rc4-reloc/arch/i386/kernel/apic.c~debug1-patch	2006-11-01 15:30:03.000000000 -0500
+++ linux-2.6.19-rc4-reloc-root/arch/i386/kernel/apic.c	2006-11-01 17:19:06.000000000 -0500
@@ -1322,6 +1322,23 @@ fastcall void smp_apic_timer_interrupt(s
 	int cpu = smp_processor_id();
 	struct clock_event_device *evt = &per_cpu(lapic_events, cpu);
 
+	/* Normally we should not be here till LAPIC has been initialized
+	 * but in some cases like kdump, its possible that there is a
+ 	 * pending LAPIC timer interrupt from previous kernel's context
+	 * and is delivered in new kernel the moment interrupts are enabled.
+	 *
+	 * Interrupts are enabled early and LAPIC is setup much later, hence
+	 * its possible that when we get here evt->event_handler is NULL.
+	 * Check for event_handler being NULL and discard the interrupt
+	 * as spurious.
+	 */
+
+	if (!evt->event_handler) {
+		printk("Spurious LAPIC timer interrupt on cpu %d\n", cpu);
+		set_irq_regs(old_regs);
+		return;
+	}
+
 	/*
 	 * the NMI deadlock-detector uses this.
 	 */
_
