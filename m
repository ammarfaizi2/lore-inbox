Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262522AbSJAVwd>; Tue, 1 Oct 2002 17:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262523AbSJAVwd>; Tue, 1 Oct 2002 17:52:33 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:1809
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262522AbSJAVwb>; Tue, 1 Oct 2002 17:52:31 -0400
Subject: [PATCH] 8390.c: preemption and disable_irq
From: Robert Love <rml@tech9.net>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1033509479.12851.34.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 01 Oct 2002 17:58:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

Alan pointed out to me that drivers/net/8390.c calls disable_irq() while
non-atomic.  This leads to the possibility that the kernel is preempted
while the IRQ line is disabled.

This is not a bug but obviously not optimal.  The solution is simply to
disable preemption prior to calling disable_irq().

Patch against 2.5.40 is attached.  Look OK?

	Robert Love

P.S. Note there is a much simpler solution of merely flipping the
spin_lock() and disable_irq() calls - the spin_lock() will provide the
atomicity without the explicit preempt_disable().  I do not think this
is safe, however, since the IRQ handler could deadlock if it grabbed
this lock (which I assume it does).

diff -urN linux-2.5.40/drivers/net/8390.c linux/drivers/net/8390.c
--- linux-2.5.40/drivers/net/8390.c	Tue Oct  1 03:06:17 2002
+++ linux/drivers/net/8390.c	Tue Oct  1 17:49:11 2002
@@ -243,7 +243,8 @@
 	}
 
 	/* Ugly but a reset can be slow, yet must be protected */
-		
+
+	preempt_disable();
 	disable_irq_nosync(dev->irq);
 	spin_lock(&ei_local->page_lock);
 		
@@ -253,6 +254,7 @@
 		
 	spin_unlock(&ei_local->page_lock);
 	enable_irq(dev->irq);
+	preempt_enable();
 	netif_wake_queue(dev);
 }
     
@@ -286,9 +288,9 @@
 	/*
 	 *	Slow phase with lock held.
 	 */
-	 
+
+	preempt_disable();
 	disable_irq_nosync(dev->irq);
-	
 	spin_lock(&ei_local->page_lock);
 	
 	ei_local->irqlock = 1;
@@ -331,6 +333,7 @@
 		outb_p(ENISR_ALL, e8390_base + EN0_IMR);
 		spin_unlock(&ei_local->page_lock);
 		enable_irq(dev->irq);
+		preempt_enable();
 		ei_local->stat.tx_errors++;
 		return 1;
 	}
@@ -387,6 +390,7 @@
 	
 	spin_unlock(&ei_local->page_lock);
 	enable_irq(dev->irq);
+	preempt_enable();
 
 	dev_kfree_skb (skb);
 	ei_local->stat.tx_bytes += send_length;



