Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264837AbUE0PyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264837AbUE0PyK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 11:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264850AbUE0PyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 11:54:09 -0400
Received: from mx2.elte.hu ([157.181.151.9]:55174 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264837AbUE0PyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 11:54:01 -0400
Date: Thu, 27 May 2004 15:31:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: macro@ds2.pg.gda.pl, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: [patch] io-apic cleanup #3, BK-curr
Message-ID: <20040527133105.GA17046@elte.hu>
References: <20040527132119.GA13185@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040527132119.GA13185@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the patch below gets rid of io_apic_sync().

io_apic_sync() was introduced in 2.1.104 and it was originally done for
masking and unmasking as well. Later the unmasking use got removed but
the masking use lingered around. I dont think it was ever justified to
do it and clearly since the lack of io_apic_sync() didnt break some of
the other writes we do to the IO-APIC registers, it must be unnecessary
in the masking case too. Maciej?

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/kernel/io_apic.c.orig	
+++ linux/arch/i386/kernel/io_apic.c	
@@ -145,10 +145,7 @@ static void __modify_IO_APIC_irq (unsign
 /* mask = 1 */
 static void __mask_IO_APIC_irq (unsigned int irq)
 {
-	struct irq_pin_list *entry = irq_2_pin + irq;
 	__modify_IO_APIC_irq(irq, 0x00010000, 0);
-	/* Is it needed? Or do others need it too? */
-	io_apic_sync(entry->apic);
 }
 
 /* mask = 0 */
--- linux/include/asm-i386/io_apic.h.orig	
+++ linux/include/asm-i386/io_apic.h	
@@ -188,15 +188,6 @@ static inline void io_apic_modify(unsign
 	*(IO_APIC_BASE(apic)+4) = value;
 }
 
-/*
- * Synchronize the IO-APIC and the CPU by doing
- * a dummy read from the IO-APIC
- */
-static inline void io_apic_sync(unsigned int apic)
-{
-	(void) *(IO_APIC_BASE(apic)+4);
-}
-
 /* 1 if "noapic" boot option passed */
 extern int skip_ioapic_setup;
 
