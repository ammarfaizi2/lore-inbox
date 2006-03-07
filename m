Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWCGWVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWCGWVN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 17:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWCGWVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 17:21:13 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:50872 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964783AbWCGWVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 17:21:13 -0500
Date: Tue, 7 Mar 2006 17:20:52 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC][PATCH] kdump: x86_64 timer interrupt lockup due to pending interrupt
Message-ID: <20060307222052.GD9106@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060306164034.GB10594@in.ibm.com> <20060306214332.GA18529@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306214332.GA18529@muc.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 10:43:32PM +0100, Andi Kleen wrote:
> On Mon, Mar 06, 2006 at 11:40:34AM -0500, Vivek Goyal wrote:
> > 
> > o check_timer() routine fails while second kernel is booting after a crash
> >   on an opetron box. Problem happens because timer vector (0x31) seems to be
> >   locked.
> > 
> > o After a system crash, it is not safe to service interrupts any more, hence
> >   interrupts are disabled. This leads to pending interrupts at LAPIC. LAPIC
> >   sends these interrupts to the CPU during early boot of second kernel. Other
> >   pending interrupts are discarded saying unexpected trap but timer interrupt
> >   is serviced and CPU does not issue an LAPIC EOI because it think this
> >   interrupt came from i8259 and sends ack to 8259. This leads to vector 0x31
> >   locking as LAPIC does not clear respective ISR and keeps on waiting for
> >   EOI.
> > 
> > o In this patch, one extra EOI is being issued in check_timer() to unlock the
> >   vector. Please suggest if there is a better way to handle this situation.
> 
> Shouldn't we rather do this for all interrupts when the APIC is set up? 
> I don't see how the timer is special here.
>

Timer is a special case here.

In other cases, the moment interrupts are enabled on cpu, LAPIC pushes pending
interrupts to cpu and it is ignored as bad irq using ack_bad_irq(). This
still sends EOI to LAPIC if LPAIC support is compiled in.

But for timer, the moment pending interrupt is pushed to cpu, it is handled
as valid interrupt and cpu assumes that it came from 8259 and sends ack to
8259 and not to LAPIC. Hence leads to missing EOI for timer vector and 
deadlock.

But still doing it generic manner for all interrupts while setting up LAPIC
probably makes more sense. Please find attached the patch.




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

o This patch issues extra EOI for the pending interrupts who have ISR set.

o Though today only timer seems to be the special case because in early
  boot it thinks interrupts are coming from i8259 and uses
  mask_and_ack_8259A() as ack handler and does not issue LAPIC EOI. But
  probably doing it in generic manner for all vectors makes sense.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/apic.c    |   21 +++++++++++++++++++++
 include/asm-x86_64/apicdef.h |    1 +
 2 files changed, 22 insertions(+)

diff -puN arch/x86_64/kernel/apic.c~x86_64-pending-interrupt-fix arch/x86_64/kernel/apic.c
--- linux-2.6.16-rc5-16M/arch/x86_64/kernel/apic.c~x86_64-pending-interrupt-fix	2006-03-07 15:37:49.000000000 -0500
+++ linux-2.6.16-rc5-16M-root/arch/x86_64/kernel/apic.c	2006-03-07 16:25:11.000000000 -0500
@@ -342,6 +342,7 @@ void __init init_bsp_APIC(void)
 void __cpuinit setup_local_APIC (void)
 {
 	unsigned int value, maxlvt;
+	int i, j;
 
 	value = apic_read(APIC_LVR);
 
@@ -370,6 +371,26 @@ void __cpuinit setup_local_APIC (void)
 	value &= ~APIC_TPRI_MASK;
 	apic_write(APIC_TASKPRI, value);
 
+#ifdef CONFIG_CRASH_DUMP
+	/*
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
+#endif
 	/*
 	 * Now that we are all set up, enable the APIC
 	 */
diff -puN include/asm-x86_64/apicdef.h~x86_64-pending-interrupt-fix include/asm-x86_64/apicdef.h
--- linux-2.6.16-rc5-16M/include/asm-x86_64/apicdef.h~x86_64-pending-interrupt-fix	2006-03-07 15:56:10.000000000 -0500
+++ linux-2.6.16-rc5-16M-root/include/asm-x86_64/apicdef.h	2006-03-07 16:27:45.000000000 -0500
@@ -39,6 +39,7 @@
 #define			APIC_SPIV_FOCUS_DISABLED	(1<<9)
 #define			APIC_SPIV_APIC_ENABLED		(1<<8)
 #define		APIC_ISR	0x100
+#define		APIC_ISR_NR	0x8	/* Number of 32 bit ISR registers. */
 #define		APIC_TMR	0x180
 #define 	APIC_IRR	0x200
 #define 	APIC_ESR	0x280
_
