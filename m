Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWC0VXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWC0VXJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 16:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWC0VXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 16:23:09 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:3997 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751447AbWC0VXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 16:23:08 -0500
Date: Mon, 27 Mar 2006 16:22:52 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Morton Andrew Morton <akpm@osdl.org>
Subject: [PATCH] i386 kdump timer vector lockup fix
Message-ID: <20060327212252.GA28030@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Porting the patch I posted for x86_64 to i386.

http://marc.theaimsgroup.com/?l=linux-kernel&m=114178139610707&w=2



o While using kdump, after a system crash when second kernel boots, timer
  vector gets (0x31) locked and CPU does not see timer interrupts
  travelling from IOAPIC to APIC. Currently it does not lead to boot
  failure in second kernel as timer interrupts continues to come as ExtInt
  through LAPIC directly, but fixing it is good in case some boards do
  not support the other mode. 

o After a system crash, it is not safe to service interrupts any more, hence
  interrupts are disabled. This leads to pending interrupts at LAPIC. LAPIC
  sends these interrupts to the CPU during early boot of second kernel. Other
  pending interrupts are discarded saying unexpected trap but timer interrupt
  is serviced and CPU does not issue an LAPIC EOI because it think this
  interrupt came from i8259 and sends ack to 8259. This leads to vector 0x31
  locking as LAPIC does not clear respective ISR and keeps on waiting for
  EOI.

o This patch issues extra EOI for the pending interrupts who have ISR set.

o Though today only timer seems to be the special case because in early
  boot it thinks interrupts are coming from i8259 and uses
  mask_and_ack_8259A() as ack handler and does not issue LAPIC EOI. But
  probably doing it in generic manner for all vectors makes sense.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/kernel/apic.c    |   20 ++++++++++++++++++++
 include/asm-i386/apicdef.h |    1 +
 2 files changed, 21 insertions(+)

diff -puN arch/i386/kernel/apic.c~i386-kdump-timer-vector-lockup-fix arch/i386/kernel/apic.c
--- linux-2.6.16-mm1-16M/arch/i386/kernel/apic.c~i386-kdump-timer-vector-lockup-fix	2006-03-27 16:03:27.000000000 -0500
+++ linux-2.6.16-mm1-16M-root/arch/i386/kernel/apic.c	2006-03-27 16:03:27.000000000 -0500
@@ -415,6 +415,7 @@ void __init init_bsp_APIC(void)
 void __devinit setup_local_APIC(void)
 {
 	unsigned long oldvalue, value, ver, maxlvt;
+	int i, j;
 
 	/* Pound the ESR really hard over the head with a big hammer - mbligh */
 	if (esr_disable) {
@@ -452,6 +453,25 @@ void __devinit setup_local_APIC(void)
 	apic_write_around(APIC_TASKPRI, value);
 
 	/*
+	 * After a crash, we no longer service the interrupts and a pending
+	 * interrupt from previous kernel might still have ISR bit set.
+	 *
+	 * Most probably by now CPU has serviced that pending interrupt and
+	 * it might not have done the ack_APIC_irq() because it thought,
+	 * interrupt came from i8259 as ExtInt. LAPIC did not get EOI so it
+	 * does not clear the ISR bit and cpu thinks it has already serivced
+	 * the interrupt. Hence a vector might get locked. It was noticed
+	 * for timer irq (vector 0x31). Issue an extra EOI to clear ISR.
+	 */
+	for (i = APIC_ISR_NR - 1; i >= 0; i--) {
+		value = apic_read(APIC_ISR + i*0x10);
+		for (j = 31; j >= 0; j--) {
+			if (value & (1<<j))
+				ack_APIC_irq();
+		}
+	}
+
+	/*
 	 * Now that we are all set up, enable the APIC
 	 */
 	value = apic_read(APIC_SPIV);
diff -puN include/asm-i386/apicdef.h~i386-kdump-timer-vector-lockup-fix include/asm-i386/apicdef.h
--- linux-2.6.16-mm1-16M/include/asm-i386/apicdef.h~i386-kdump-timer-vector-lockup-fix	2006-03-27 16:03:27.000000000 -0500
+++ linux-2.6.16-mm1-16M-root/include/asm-i386/apicdef.h	2006-03-27 16:03:27.000000000 -0500
@@ -37,6 +37,7 @@
 #define			APIC_SPIV_FOCUS_DISABLED	(1<<9)
 #define			APIC_SPIV_APIC_ENABLED		(1<<8)
 #define		APIC_ISR	0x100
+#define         APIC_ISR_NR     0x8     /* Number of 32 bit ISR registers. */
 #define		APIC_TMR	0x180
 #define 	APIC_IRR	0x200
 #define 	APIC_ESR	0x280
_


