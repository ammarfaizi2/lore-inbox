Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWGEFUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWGEFUf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 01:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWGEFUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 01:20:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:17602 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932348AbWGEFUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 01:20:34 -0400
Subject: [PATCH] powerpc: Fix loss of interrupts with MPIC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 15:07:00 +1000
Message-Id: <1152076021.17790.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the new interrupt rework, an interrupt "host" map() callback can be
called after the interrupt is already active (it's called again for an
already mapped interrupt to allow changing the trigger
setup, and currently this is not guarded with a test of wether the
interrupt is requested or not, I plan to change some of this logic to be
a bit less lenient against random reconfiguring of live
interrupts but just not yet). The ported MPIC driver has a bug where
when that happens, it will mask the interrupt. This changes it to
preserve the previous masking of the interrupt instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
Linus: It would be nice if that could still sneak into -rc1 as it causes
hangs and other bad issues on PowerMac.

Index: linux-irq-work/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/sysdev/mpic.c	2006-07-05 14:46:11.000000000 +1000
+++ linux-irq-work/arch/powerpc/sysdev/mpic.c	2006-07-05 15:00:48.000000000 +1000
@@ -405,20 +405,22 @@
 	unsigned int loops = 100000;
 	struct mpic *mpic = mpic_from_irq(irq);
 	unsigned int src = mpic_irq_to_hw(irq);
+	unsigned long flags;
 
 	DBG("%p: %s: enable_irq: %d (src %d)\n", mpic, mpic->name, irq, src);
 
+	spin_lock_irqsave(&mpic_lock, flags);
 	mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
 		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) &
 		       ~MPIC_VECPRI_MASK);
-
 	/* make sure mask gets to controller before we return to user */
 	do {
 		if (!loops--) {
 			printk(KERN_ERR "mpic_enable_irq timeout\n");
 			break;
 		}
-	} while(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) & MPIC_VECPRI_MASK);	
+	} while(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) & MPIC_VECPRI_MASK);
+	spin_unlock_irqrestore(&mpic_lock, flags);
 }
 
 static void mpic_mask_irq(unsigned int irq)
@@ -426,9 +428,11 @@
 	unsigned int loops = 100000;
 	struct mpic *mpic = mpic_from_irq(irq);
 	unsigned int src = mpic_irq_to_hw(irq);
+	unsigned long flags;
 
 	DBG("%s: disable_irq: %d (src %d)\n", mpic->name, irq, src);
 
+	spin_lock_irqsave(&mpic_lock, flags);
 	mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
 		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) |
 		       MPIC_VECPRI_MASK);
@@ -440,6 +444,7 @@
 			break;
 		}
 	} while(!(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) & MPIC_VECPRI_MASK));
+	spin_unlock_irqrestore(&mpic_lock, flags);
 }
 
 static void mpic_end_irq(unsigned int irq)
@@ -624,7 +629,7 @@
 	struct irq_desc *desc = get_irq_desc(virq);
 	struct irq_chip *chip;
 	struct mpic *mpic = h->host_data;
-	unsigned int vecpri = MPIC_VECPRI_SENSE_LEVEL |
+	u32 v, vecpri = MPIC_VECPRI_SENSE_LEVEL |
 		MPIC_VECPRI_POLARITY_NEGATIVE;
 	int level;
 
@@ -668,11 +673,21 @@
 	}
 #endif
 
-	/* Reconfigure irq */
-	vecpri |= MPIC_VECPRI_MASK | hw | (8 << MPIC_VECPRI_PRIORITY_SHIFT);
-	mpic_irq_write(hw, MPIC_IRQ_VECTOR_PRI, vecpri);
+	/* Reconfigure irq. We must preserve the mask bit as we can be called
+	 * while the interrupt is still active (This may change in the future
+	 * but for now, it is the case).
+	 */
+	spin_lock_irqsave(&mpic_lock, flags);
+	v = mpic_irq_read(hw, MPIC_IRQ_VECTOR_PRI);
+	vecpri = (v &
+		~(MPIC_VECPRI_POLARITY_MASK | MPIC_VECPRI_SENSE_MASK)) |
+		vecpri;
+	if (vecpri != v)
+		mpic_irq_write(hw, MPIC_IRQ_VECTOR_PRI, vecpri);
+	spin_unlock_irqrestore(&mpic_lock, flags);
 
-	pr_debug("mpic: mapping as IRQ\n");
+	pr_debug("mpic: mapping as IRQ, vecpri = 0x%08x (was 0x%08x)\n",
+		 vecpri, v);
 
 	set_irq_chip_data(virq, mpic);
 	set_irq_chip_and_handler(virq, chip, handle_fasteoi_irq);
@@ -904,8 +919,8 @@
 		
 		/* do senses munging */
 		if (mpic->senses && i < mpic->senses_count)
-			vecpri = mpic_flags_to_vecpri(mpic->senses[i],
-						      &level);
+			vecpri |= mpic_flags_to_vecpri(mpic->senses[i],
+						       &level);
 		else
 			vecpri |= MPIC_VECPRI_SENSE_LEVEL;
 
@@ -955,14 +970,17 @@
 
 void __init mpic_set_serial_int(struct mpic *mpic, int enable)
 {
+	unsigned long flags;
 	u32 v;
 
+	spin_lock_irqsave(&mpic_lock, flags);
 	v = mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1);
 	if (enable)
 		v |= MPIC_GREG_GLOBAL_CONF_1_SIE;
 	else
 		v &= ~MPIC_GREG_GLOBAL_CONF_1_SIE;
 	mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1, v);
+	spin_unlock_irqrestore(&mpic_lock, flags);
 }
 
 void mpic_irq_set_priority(unsigned int irq, unsigned int pri)
  

