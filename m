Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264732AbUE0POP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264732AbUE0POP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 11:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264755AbUE0POP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 11:14:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:26055 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264732AbUE0PNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 11:13:39 -0400
Date: Thu, 27 May 2004 15:21:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: macro@ds2.pg.gda.pl, linux-kernel@vger.kernel.org
Subject: [patch] io-apic cleanup #2, BK-curr
Message-ID: <20040527132119.GA13185@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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


the patch below gets rid of APIC_LOCKUP_DEBUG. It has been in the kernel
for more than 3 years and the message was only reported once during that
period of time - and even in that case it was a side-effect of a really
bad crash. The lockup workaround works, the debugging code can be moved
out.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/kernel/io_apic.c.orig	
+++ linux/arch/i386/kernel/io_apic.c	
@@ -41,8 +41,6 @@
 
 #include "io_ports.h"
 
-#define APIC_LOCKUP_DEBUG
-
 static spinlock_t ioapic_lock = SPIN_LOCK_UNLOCKED;
 
 /*
@@ -1858,30 +1856,11 @@ static void end_level_ioapic_irq (unsign
 	ack_APIC_irq();
 
 	if (!(v & (1 << (i & 0x1f)))) {
-#ifdef APIC_LOCKUP_DEBUG
-		struct irq_pin_list *entry;
-#endif
-
 #ifdef APIC_MISMATCH_DEBUG
 		atomic_inc(&irq_mis_count);
 #endif
 		spin_lock(&ioapic_lock);
 		__mask_and_edge_IO_APIC_irq(irq);
-#ifdef APIC_LOCKUP_DEBUG
-		for (entry = irq_2_pin + irq;;) {
-			unsigned int reg;
-
-			if (entry->pin == -1)
-				break;
-			reg = io_apic_read(entry->apic, 0x10 + entry->pin * 2);
-			if (reg & 0x00004000)
-				printk(KERN_CRIT "Aieee!!!  Remote IRR"
-					" still set after unlock!\n");
-			if (!entry->next)
-				break;
-			entry = irq_2_pin + entry->next;
-		}
-#endif
 		__unmask_and_level_IO_APIC_irq(irq);
 		spin_unlock(&ioapic_lock);
 	}
