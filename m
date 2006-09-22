Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWIVNU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWIVNU3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 09:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWIVNU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 09:20:29 -0400
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:57342 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S932402AbWIVNU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 09:20:28 -0400
Message-ID: <4513E308.10507@lwfinger.net>
Date: Fri, 22 Sep 2006 08:20:08 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: dbtsai@gmail.com
CC: John Linville <linville@tuxdriver.com>, netdev@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bcm43xx softMac Driver in 2.6.18
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When we found the cause of NETDEV watchdog timeouts in the wireless-2.6 code, I knew that the 2.6.18 
release code would cause a serious regression. I immediately prepared and tested a patch to fix 
this; however, I was unable to get it pushed into the stable code before release of 2.6.18. The 
following submission text and patch has been sent to the stable maintainers, which I hope is 
included in 2.6.18.1.

For people having these lockups with 2.6.18, please try this patch and inform me of the results, 
both positive and negative. The latter are particularly important.

Larry
==================================================================

In 2.6.18, the section that prepares for preemptible periodic work
has two bugs. The first is due to an improper locking sequence that leads
to frozen systems. The second causes netdev watchdog timeouts. Both
lead to serious regressions as compared with 2.6.17.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---

This patch, which was originally sent to John Linville on 9/14/06,
has been taken against 2.6.18. It changes more lines
than would be absolutely necessary to affect the fix; however, it
ends up with this section looking exactly like the current code (with
pending patches) that is in wireless-2.6.

Larry

Index: linux-2.6/drivers/net/wireless/bcm43xx/bcm43xx_main.c
===================================================================
--- linux-2.6.orig/drivers/net/wireless/bcm43xx/bcm43xx_main.c
+++ linux-2.6/drivers/net/wireless/bcm43xx/bcm43xx_main.c
@@ -3182,39 +3182,37 @@ static void bcm43xx_periodic_work_handle
  		/* Periodic work will take a long time, so we want it to
  		 * be preemtible.
  		 */
-		bcm43xx_lock_irqonly(bcm, flags);
-		netif_stop_queue(bcm->net_dev);
+		mutex_lock(&bcm->mutex);
+		netif_tx_disable(bcm->net_dev);
+		spin_lock_irqsave(&bcm->irq_lock, flags);
+		bcm43xx_mac_suspend(bcm);
  		if (bcm43xx_using_pio(bcm))
  			bcm43xx_pio_freeze_txqueues(bcm);
  		savedirqs = bcm43xx_interrupt_disable(bcm, BCM43xx_IRQ_ALL);
-		bcm43xx_unlock_irqonly(bcm, flags);
-		bcm43xx_lock_noirq(bcm);
+		spin_unlock_irqrestore(&bcm->irq_lock, flags);
  		bcm43xx_synchronize_irq(bcm);
  	} else {
  		/* Periodic work should take short time, so we want low
  		 * locking overhead.
  		 */
-		bcm43xx_lock_irqsafe(bcm, flags);
+		mutex_lock(&bcm->mutex);
+		spin_lock_irqsave(&bcm->irq_lock, flags);
  	}

  	do_periodic_work(bcm);

  	if (badness > BADNESS_LIMIT) {
-		bcm43xx_lock_irqonly(bcm, flags);
-		if (likely(bcm43xx_status(bcm) == BCM43xx_STAT_INITIALIZED)) {
-			tasklet_enable(&bcm->isr_tasklet);
-			bcm43xx_interrupt_enable(bcm, savedirqs);
-			if (bcm43xx_using_pio(bcm))
-				bcm43xx_pio_thaw_txqueues(bcm);
-		}
+		spin_lock_irqsave(&bcm->irq_lock, flags);
+		tasklet_enable(&bcm->isr_tasklet);
+		bcm43xx_interrupt_enable(bcm, savedirqs);
+		if (bcm43xx_using_pio(bcm))
+			bcm43xx_pio_thaw_txqueues(bcm);
+		bcm43xx_mac_enable(bcm);
  		netif_wake_queue(bcm->net_dev);
-		mmiowb();
-		bcm43xx_unlock_irqonly(bcm, flags);
-		bcm43xx_unlock_noirq(bcm);
-	} else {
-		mmiowb();
-		bcm43xx_unlock_irqsafe(bcm, flags);
  	}
+	mmiowb();
+	spin_unlock_irqrestore(&bcm->irq_lock, flags);
+	mutex_unlock(&bcm->mutex);
  }

  static void bcm43xx_periodic_tasks_delete(struct bcm43xx_private *bcm)



_______________________________________________
Bcm43xx-dev mailing list
Bcm43xx-dev@lists.berlios.de
https://lists.berlios.de/mailman/listinfo/bcm43xx-dev



