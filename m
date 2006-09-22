Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbWIVOb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWIVOb3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWIVOb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:31:29 -0400
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:36504 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S932535AbWIVOb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:31:28 -0400
Message-ID: <4513F3AD.9070603@lwfinger.net>
Date: Fri, 22 Sep 2006 09:31:09 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Erik Mouw <erik@harddisk-recovery.com>
CC: dbtsai@gmail.com, John Linville <linville@tuxdriver.com>,
       netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bcm43xx softMac Driver in 2.6.18
References: <4513E308.10507@lwfinger.net> <20060922135352.GD4122@harddisk-recovery.com>
In-Reply-To: <20060922135352.GD4122@harddisk-recovery.com>
Content-Type: multipart/mixed;
 boundary="------------040203060207010409060309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040203060207010409060309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Erik Mouw wrote:
> On Fri, Sep 22, 2006 at 08:20:08AM -0500, Larry Finger wrote:
>> This patch, which was originally sent to John Linville on 9/14/06,
>> has been taken against 2.6.18. It changes more lines
>> than would be absolutely necessary to affect the fix; however, it
>> ends up with this section looking exactly like the current code (with
>> pending patches) that is in wireless-2.6.
> 
> Sorry, but your patch doesn't apply cleanly against 2.6.18:
> 
> erik@arthur:~/git/linux-2.6 > patch -p1 --dry-run < ../bcm43xx-2.6.18.diff
> patching file drivers/net/wireless/bcm43xx/bcm43xx_main.c
> Hunk #1 FAILED at 3182.
> 1 out of 1 hunk FAILED -- saving rejects to file drivers/net/wireless/bcm43xx/bcm43xx_main.c.rej

Arrrgh! My mailer messed up the white space and put spaces instead of tabs. The correct patch is 
attached here so it doesn't happen again. This one has been tested against a clean download of 2.6.18.

Larry


--------------040203060207010409060309
Content-Type: text/plain;
 name="patch_preempt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_preempt"

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


--------------040203060207010409060309--
