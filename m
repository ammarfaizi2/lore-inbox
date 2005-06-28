Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVF1RaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVF1RaA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 13:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVF1R1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 13:27:37 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:16569 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262169AbVF1R05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 13:26:57 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Date: Tue, 28 Jun 2005 19:27:43 +0200
User-Agent: KMail/1.8.1
Cc: mingo@elte.hu
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506281927.43959.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

suffering (not really ;-) double-rated IO-APIC level-interrupts I found the following patch as a solution:

--- arch/i386/kernel/io_apic.c~	2005-06-28 19:07:49.000000000 +0200
+++ arch/i386/kernel/io_apic.c	2005-06-28 19:07:49.000000000 +0200
@@ -1959,6 +1959,7 @@
 static void mask_and_ack_level_ioapic_irq(unsigned int irq)
 {
 	move_irq(irq);
+	mask_IO_APIC_irq(irq);
 	ack_APIC_irq();
 }
 
--- kernel/irq/handle.c~	2005-06-28 19:19:32.000000000 +0200
+++ kernel/irq/handle.c	2005-06-28 19:19:32.000000000 +0200
@@ -214,7 +214,6 @@
 	 * hardirq redirection to the irqd process context:
 	 */
 	if (redirect_hardirq(desc)) {
-		desc->handler->disable(irq);
 		goto out_no_end;
 	}

it works here on a PREEMPT_RT 2.6.12-RT-V0.7.50-29 base.
Level-interrupts are sanely rated again.
Didn't check, if the patch breaks XT-PIC mode, which works ok without the patch.
Mainline shows the same effect here (VIA K8T800 UP), didn't dig there yet.

thanks,
Karsten

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
