Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbVI1HNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbVI1HNy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 03:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbVI1HNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 03:13:48 -0400
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:32899 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S1030204AbVI1HNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 03:13:19 -0400
Date: Wed, 28 Sep 2005 09:12:21 +0200 (MEST)
From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 4/7] HPET: allow shared interrupts
In-reply-to: <20050928071155.23025.43523.balrog@turing>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Bob Picco <bob.picco@hp.com>,
       Clemens Ladisch <clemens@ladisch.de>
Message-id: <20050928071221.23025.65457.balrog@turing>
Content-transfer-encoding: 7BIT
References: <20050928071155.23025.43523.balrog@turing>
X-Scan-Signature: c411a55668daee96a10e94995ae48951
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for shared HPET interrupts.

The driver previously acknowledged interrupts for both edge and level
interrupts, but didn't actually allow a shared interrupt in the latter
case.

We use a new per-timer flag to save whether the timer's interrupt
might be shared, and use it to do the processing required for level
interrupts only if necessary.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

Index: linux-2.6.13/drivers/char/hpet.c
===================================================================
--- linux-2.6.13.orig/drivers/char/hpet.c	2005-09-27 21:45:12.000000000 +0200
+++ linux-2.6.13/drivers/char/hpet.c	2005-09-27 22:21:48.000000000 +0200
@@ -90,6 +90,7 @@ static struct hpets *hpets;
 #define	HPET_OPEN		0x0001
 #define	HPET_IE			0x0002	/* interrupt enabled */
 #define	HPET_PERIODIC		0x0004
+#define	HPET_SHARED_IRQ		0x0008
 
 #if BITS_PER_LONG == 64
 #define	write_counter(V, MC)	writeq(V, MC)
@@ -120,6 +121,11 @@ static irqreturn_t hpet_interrupt(int ir
 	unsigned long isr;
 
 	devp = data;
+	isr = 1 << (devp - devp->hd_hpets->hp_dev);
+
+	if ((devp->hd_flags & HPET_SHARED_IRQ) &&
+	    !(isr & readl(&devp->hd_hpet->hpet_isr)))
+		return IRQ_NONE;
 
 	spin_lock(&hpet_lock);
 	devp->hd_irqdata++;
@@ -137,8 +143,8 @@ static irqreturn_t hpet_interrupt(int ir
 			      &devp->hd_timer->hpet_compare);
 	}
 
-	isr = (1 << (devp - devp->hd_hpets->hp_dev));
-	writeq(isr, &devp->hd_hpet->hpet_isr);
+	if (devp->hd_flags & HPET_SHARED_IRQ)
+		writel(isr, &devp->hd_hpet->hpet_isr);
 	spin_unlock(&hpet_lock);
 
 	spin_lock(&hpet_task_lock);
@@ -375,15 +381,21 @@ static int hpet_ioctl_ieon(struct hpet_d
 	}
 
 	devp->hd_flags |= HPET_IE;
+
+	if (readl(&timer->hpet_config) & Tn_INT_TYPE_CNF_MASK)
+		devp->hd_flags |= HPET_SHARED_IRQ;
 	spin_unlock_irq(&hpet_lock);
 
 	irq = devp->hd_hdwirq;
 
 	if (irq) {
-		sprintf(devp->hd_name, "hpet%d", (int)(devp - hpetp->hp_dev));
+		unsigned long irq_flags;
 
-		if (request_irq
-		    (irq, hpet_interrupt, SA_INTERRUPT, devp->hd_name, (void *)devp)) {
+		sprintf(devp->hd_name, "hpet%d", (int)(devp - hpetp->hp_dev));
+		irq_flags = devp->hd_flags & HPET_SHARED_IRQ
+						? SA_SHIRQ : SA_INTERRUPT;
+		if (request_irq(irq, hpet_interrupt, irq_flags, 
+				devp->hd_name, (void *)devp)) {
 			printk(KERN_ERR "hpet: IRQ %d is not free\n", irq);
 			irq = 0;
 		}
@@ -417,8 +429,10 @@ static int hpet_ioctl_ieon(struct hpet_d
 		write_counter(t + m + hpetp->hp_delta, &timer->hpet_compare);
 	}
 
-	isr = (1 << (devp - hpets->hp_dev));
-	writeq(isr, &hpet->hpet_isr);
+	if (devp->hd_flags & HPET_SHARED_IRQ) {
+		isr = 1 << (devp - hpets->hp_dev);
+		writel(isr, &hpet->hpet_isr);
+	}
 	writeq(g, &timer->hpet_config);
 	local_irq_restore(flags);
 
