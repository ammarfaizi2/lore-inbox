Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273076AbTG3RbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 13:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273087AbTG3RbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 13:31:11 -0400
Received: from modemcable198.171-130-66.que.mc.videotron.ca ([66.130.171.198]:11905
	"EHLO gaston") by vger.kernel.org with ESMTP id S273076AbTG3RbH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 13:31:07 -0400
Subject: [RFC+PATCH] calling request_irq() with lock held (+sungem fix)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059586244.2420.41.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 30 Jul 2003 13:30:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hrm.. old problem: request_irq() called with a lock held.

This is unclear wether this should be safe or not, I now IDE used to
do that, but the current implementation of request_irq() on most archs
is definitely not safe to be called in a non-sleeping context.

i386 was sort-fixed by using GFP_ATOMIC in the kmalloc() done inside
request_irq() itself, but what about all of the proc related stuff
that gets done when setup_irq() calls register_irq_proc() ? So the
_fact_ is that the current implementations in archs, including i386,
are unsafe to call from "atomic" context.

David: this patch fixes sungem for that.

Cheers,
Ben.

diff -urN linux-2.5/drivers/net/sungem.c linuxppc-2.5-benh/drivers/net/sungem.c
--- linux-2.5/drivers/net/sungem.c	2003-07-29 08:50:59.000000000 -0400
+++ linuxppc-2.5-benh/drivers/net/sungem.c	2003-07-30 13:25:32.000000000 -0400
@@ -2101,17 +2101,14 @@
 		gp->hw_running = 1;
 	}
 
-	spin_lock_irq(&gp->lock);
-
 	/* We can now request the interrupt as we know it's masked
 	 * on the controller
 	 */
 	if (request_irq(gp->pdev->irq, gem_interrupt,
 			SA_SHIRQ, dev->name, (void *)dev)) {
-		spin_unlock_irq(&gp->lock);
-
 		printk(KERN_ERR "%s: failed to request irq !\n", gp->dev->name);
 
+		spin_lock_irq(&gp->lock);
 #ifdef CONFIG_PPC_PMAC
 		if (!hw_was_up && gp->pdev->vendor == PCI_VENDOR_ID_APPLE)
 			gem_apple_powerdown(gp);
@@ -2120,10 +2117,13 @@
 		gp->pm_timer.expires = jiffies + 10*HZ;
 		add_timer(&gp->pm_timer);
 		up(&gp->pm_sem);
+		spin_unlock_irq(&gp->lock);
 
 		return -EAGAIN;
 	}
 
+       	spin_lock_irq(&gp->lock);
+
 	/* Allocate & setup ring buffers */
 	gem_init_rings(gp);
 

