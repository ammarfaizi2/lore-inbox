Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbVEYGxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVEYGxC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 02:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVEYGxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 02:53:02 -0400
Received: from smtp816.mail.sc5.yahoo.com ([66.163.170.2]:13987 "HELO
	smtp816.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262286AbVEYGke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 02:40:34 -0400
Message-Id: <20050525064006.341792000.dtor_core@ameritech.net>
References: <20050525063738.864916000.dtor_core@ameritech.net>
Date: Wed, 25 May 2005 01:37:45 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: irda-users@lists.sourceforge.net
Cc: Jean Tourrilhes <jt@hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: [patch 7/9] smsc-ircc2: PM cleanup - do not close device when suspending
Content-Disposition: inline; filename=ircc2-pm2.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IRDA: smsc-ircc2 - avoid closing device and releasing DMA/interrupt
      when suspending - they may not be available any more at resume
      time.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/net/irda/smsc-ircc2.c |   35 +++++++++++++++++++++++++++++------
 1 files changed, 29 insertions(+), 6 deletions(-)

Index: dtor/drivers/net/irda/smsc-ircc2.c
===================================================================
--- dtor.orig/drivers/net/irda/smsc-ircc2.c
+++ dtor/drivers/net/irda/smsc-ircc2.c
@@ -1579,6 +1579,11 @@ static int smsc_ircc_net_open(struct net
 	self = (struct smsc_ircc_cb *) dev->priv;
 	IRDA_ASSERT(self != NULL, return 0;);
 
+	if (self->io.suspended) {
+		IRDA_DEBUG(0, "%s(), device is suspended\n", __FUNCTION__);
+		return -EAGAIN;
+	}
+
 	if (request_irq(self->io.irq, smsc_ircc_interrupt, 0, dev->name,
 			(void *) dev)) {
 		IRDA_DEBUG(0, "%s(), unable to allocate irq=%d\n",
@@ -1654,11 +1659,17 @@ static int smsc_ircc_suspend(struct devi
 {
 	struct smsc_ircc_cb *self = dev_get_drvdata(dev);
 
-	IRDA_MESSAGE("%s, Suspending\n", driver_name);
-
 	if (level == SUSPEND_DISABLE && !self->io.suspended) {
-		smsc_ircc_net_close(self->netdev);
+		IRDA_DEBUG("%s, Suspending\n", driver_name);
+
+		rtnl_lock();
+		if (netif_running(self->netdev)) {
+			netif_device_detach(self->netdev);
+			disable_irq(self->io.irq);
+			disable_dma(self->io.dma);
+		}
 		self->io.suspended = 1;
+		rtnl_unlock();
 	}
 
 	return 0;
@@ -1667,13 +1678,25 @@ static int smsc_ircc_suspend(struct devi
 static int smsc_ircc_resume(struct device *dev, u32 level)
 {
 	struct smsc_ircc_cb *self = dev_get_drvdata(dev);
+	unsigned long flags;
 
 	if (level == RESUME_ENABLE && self->io.suspended) {
+		IRDA_DEBUG("%s, Waking up\n", driver_name);
 
-		smsc_ircc_net_open(self->netdev);
+		rtnl_lock();
+		if (netif_running(self->netdev)) {
+			spin_lock_irqsave(&self->lock, flags);
+			self->io.speed = 0;
+			smsc_ircc_change_speed(self,
+				SMSC_IRCC2_C_IRDA_FALLBACK_SPEED);
+			spin_unlock_irqrestore(&self->lock, flags);
+
+			enable_dma(self->io.dma);
+			enable_irq(self->io.irq);
+			netif_device_attach(self->netdev);
+		}
 		self->io.suspended = 0;
-
-		IRDA_MESSAGE("%s, Waking up\n", driver_name);
+		rtnl_unlock();
 	}
 	return 0;
 }

