Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284691AbRLZSgF>; Wed, 26 Dec 2001 13:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284728AbRLZSf4>; Wed, 26 Dec 2001 13:35:56 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:13231 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S284691AbRLZSfh>; Wed, 26 Dec 2001 13:35:37 -0500
Date: Wed, 26 Dec 2001 20:34:37 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: i8259 micro optimisation for ISR/IRR reads
Message-ID: <Pine.LNX.4.33.0112262033270.28333-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this should also improve performance on the spurious interrupt code path
(ISR reads), without hurting the common case (IRR reads).

Comments/flames are very welcome
Cheers,
	Zwane Mwaikambo


--- linux-2.5.2-pre1.orig/arch/i386/kernel/i8259.c	Tue Sep 18 08:03:09 2001
+++ linux/arch/i386/kernel/i8259.c	Thu Jan  1 05:30:49 1998
@@ -210,14 +210,21 @@
 	spin_unlock_irqrestore(&i8259A_lock, flags);
 }

+static unsigned char cached_reg[2] = {IRR_REG, IRR_REG};
+
 int i8259A_irq_pending(unsigned int irq)
 {
 	unsigned int mask = 1<<irq;
 	unsigned long flags;
-	int ret;
-
+	int ret, pic = (irq < 8) ? 0 : 1;
+
 	spin_lock_irqsave(&i8259A_lock, flags);
-	if (irq < 8)
+	if (unlikely (cached_reg[pic] != IRR_REG)) {
+		outb(IRR_REG, (pic) ? 0xA0 : 0x20);
+		cached_reg[pic] = IRR_REG;
+	}
+
+	if (!pic)
 		ret = inb(0x20) & mask;
 	else
 		ret = inb(0xA0) & (mask >> 8);
@@ -236,7 +243,8 @@

 /*
  * This function assumes to be called rarely. Switching between
- * 8259A registers is slow.
+ * 8259A registers is slow. The default cached_reg is set to IRR
+ * since that is the default when the PIC is setup.
  * This has to be protected by the irq controller spinlock
  * before being called.
  */
@@ -244,16 +252,18 @@
 {
 	int value;
 	int irqmask = 1<<irq;
+	int pic = (irq < 8) ? 0 : 1;

-	if (irq < 8) {
-		outb(0x0B,0x20);		/* ISR register */
-		value = inb(0x20) & irqmask;
-		outb(0x0A,0x20);		/* back to the IRR register */
-		return value;
+	if (cached_reg[pic] != ISR_REG) {
+		outb(ISR_REG, (pic) ? 0xA0 : 0x20);
+		cached_reg[pic] = ISR_REG;
 	}
-	outb(0x0B,0xA0);		/* ISR register */
-	value = inb(0xA0) & (irqmask >> 8);
-	outb(0x0A,0xA0);		/* back to the IRR register */
+
+	if (!pic) {
+		value = inb(0x20) & irqmask;
+	} else
+		value = inb(0xA0) & (irqmask >> 8);
+
 	return value;
 }

@@ -348,6 +358,8 @@
 	outb_p(0x11, 0x20);	/* ICW1: select 8259A-1 init */
 	outb_p(0x20 + 0, 0x21);	/* ICW2: 8259A-1 IR0-7 mapped to 0x20-0x27 */
 	outb_p(0x04, 0x21);	/* 8259A-1 (the master) has a slave on IR2 */
+	outb_p(IRR_REG, 0x21);	/* Default to IRR */
+
 	if (auto_eoi)
 		outb_p(0x03, 0x21);	/* master does Auto EOI */
 	else
@@ -358,6 +370,7 @@
 	outb_p(0x02, 0xA1);	/* 8259A-2 is a slave on master's IR2 */
 	outb_p(0x01, 0xA1);	/* (slave's support for AEOI in flat mode
 				    is to be investigated) */
+	outb_p(IRR_REG, 0xA1);	/* Default to IRR */

 	if (auto_eoi)
 		/*

