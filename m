Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272804AbTGaHXy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 03:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272813AbTGaHXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 03:23:54 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:16656 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S272804AbTGaHXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 03:23:51 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marc Heckmann <mh@nadir.org>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: UP IO-APIC fix in 2.4.22-pre?
Date: Thu, 31 Jul 2003 09:08:27 +0200
User-Agent: KMail/1.5.2
References: <20030731002847.GA3549@nadir.org>
In-Reply-To: <20030731002847.GA3549@nadir.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307310821.27648.m.c.p@wolk-project.de>
X-PRIORITY: 2 (High)
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rBMK/BrgcqgJPfe"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_rBMK/BrgcqgJPfe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 31 July 2003 02:28, Marc Heckmann wrote:

Hi Marc,

> I was just wondering about the bugfix for UP IO-APIC that is in 2.4-ac
> and that went into 2.5:
> http://linux.bkbits.net:8080/linux-2.5/cset@1.1455.1.9
> Will it make it into 2.4.22? From what I understand this fixes the
> following problem that many of us are seeing:
> hda: dma_timer_expiry: dma status == 0x24
> hda: lost interrupt
> hda: dma_intr: bad DMA status (dma_stat=30)
> hda: dma_intr: status=0x50 { DriveReady SeekComplete }

I sent it to Marcelo yesterday. In the meantime you might want to try out the 
attached patch ontop of 2.4.22-pre9 and see if it fixes the problems for you.

ciao, Marc

--Boundary-00=_rBMK/BrgcqgJPfe
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="IO-APIC-edge-IRQs-on-UP-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="IO-APIC-edge-IRQs-on-UP-fix.patch"

--- a/arch/i386/kernel/io_apic.c	2003-07-30 11:18:50.000000000 +0200
+++ b/arch/i386/kernel/io_apic.c	2003-07-31 01:40:36.000000000 +0200
@@ -1343,6 +1343,25 @@ static void clear_IO_APIC (void)
 
 static void mask_and_ack_level_ioapic_irq (unsigned int irq) { /* nothing */ }
 
+#ifndef CONFIG_SMP
+
+void send_IPI_self(int vector)
+{
+	unsigned int cfg;
+
+	/*
+	 * Wait for idle.
+	 */
+	apic_wait_icr_idle();
+	cfg = APIC_DM_FIXED | APIC_DEST_SELF | vector | APIC_DEST_LOGICAL;
+	/*
+	 * Send the IPI. The write to APIC_ICR fires this off.
+	 */
+	apic_write_around(APIC_ICR, cfg);
+}
+
+#endif /* CONFIG_SMP */
+
 static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
 {
 	unsigned long flags;
--- a/include/asm-i386/hw_irq.h	2003-07-17 13:42:13.000000000 +0100
+++ b/include/asm-i386/hw_irq.h	2003-07-17 15:49:58.000000000 +0100
@@ -13,8 +13,10 @@
  */
 
 #include <linux/config.h>
+#include <linux/smp_lock.h>
 #include <asm/atomic.h>
 #include <asm/irq.h>
+#include <asm/current.h>
 
 /*
  * IDT vectors usable for external interrupt sources start
@@ -213,7 +215,7 @@
 	atomic_inc((atomic_t *)&prof_buffer[eip]);
 }
 
-#ifdef CONFIG_SMP /*more of this file should probably be ifdefed SMP */
+#if defined(CONFIG_X86_IO_APIC)
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {
 	if (IO_APIC_IRQ(i))
 		send_IPI_self(IO_APIC_VECTOR(i));

--Boundary-00=_rBMK/BrgcqgJPfe--


