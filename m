Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVEYGle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVEYGle (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 02:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVEYGle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 02:41:34 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:4242 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262281AbVEYGkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 02:40:33 -0400
Message-Id: <20050525064006.224660000.dtor_core@ameritech.net>
References: <20050525063738.864916000.dtor_core@ameritech.net>
Date: Wed, 25 May 2005 01:37:44 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: irda-users@lists.sourceforge.net
Cc: Jean Tourrilhes <jt@hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: [patch 6/9] smsc-ircc2: add to sysfs as platform device, new PM
Content-Disposition: inline; filename=ircc2-pm.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IRDA: smsc-ircc2 - add sysfs support (platform device and driver) and
      switch power management to the new scheme.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 smsc-ircc2.c |  125 +++++++++++++++++++++++++++++++----------------------------
 1 files changed, 67 insertions(+), 58 deletions(-)

Index: dtor/drivers/net/irda/smsc-ircc2.c
===================================================================
--- dtor.orig/drivers/net/irda/smsc-ircc2.c
+++ dtor/drivers/net/irda/smsc-ircc2.c
@@ -73,7 +73,6 @@ MODULE_AUTHOR("Daniele Peri <peri@csai.u
 MODULE_DESCRIPTION("SMC IrCC SIR/FIR controller driver");
 MODULE_LICENSE("GPL");
 
-
 static int ircc_dma = 255;
 module_param(ircc_dma, int, 0);
 MODULE_PARM_DESC(ircc_dma, "DMA channel");
@@ -144,17 +143,20 @@ struct smsc_ircc_cb {
 	int tx_len;                /* Number of frames in tx_buff */
 
 	int transceiver;
-	struct pm_dev *pmdev;
+	struct platform_device *pldev;
 };
 
 /* Constants */
 
-static const char *driver_name = "smsc-ircc2";
+#define SMSC_IRCC2_DRIVER_NAME			"smsc-ircc2"
+
 #define SMSC_IRCC2_C_IRDA_FALLBACK_SPEED	9600
 #define SMSC_IRCC2_C_DEFAULT_TRANSCEIVER	1
 #define SMSC_IRCC2_C_NET_TIMEOUT		0
 #define SMSC_IRCC2_C_SIR_STOP			0
 
+static const char *driver_name = SMSC_IRCC2_DRIVER_NAME;
+
 /* Prototypes */
 
 static int smsc_ircc_open(unsigned int firbase, unsigned int sirbase, u8 dma, u8 irq);
@@ -187,7 +189,6 @@ static int  smsc_ircc_net_ioctl(struct n
 static void smsc_ircc_timeout(struct net_device *dev);
 #endif
 static struct net_device_stats *smsc_ircc_net_get_stats(struct net_device *dev);
-static int  smsc_ircc_pmproc(struct pm_dev *dev, pm_request_t rqst, void *data);
 static int smsc_ircc_is_receiving(struct smsc_ircc_cb *self);
 static void smsc_ircc_probe_transceiver(struct smsc_ircc_cb *self);
 static void smsc_ircc_set_transceiver_for_speed(struct smsc_ircc_cb *self, u32 speed);
@@ -212,10 +213,15 @@ static int  smsc_ircc_probe_transceiver_
 
 /* Power Management */
 
-static void smsc_ircc_suspend(struct smsc_ircc_cb *self);
-static void smsc_ircc_wakeup(struct smsc_ircc_cb *self);
-static int smsc_ircc_pmproc(struct pm_dev *dev, pm_request_t rqst, void *data);
+static int smsc_ircc_suspend(struct device *dev, pm_message_t state, u32 level);
+static int smsc_ircc_resume(struct device *dev, u32 level);
 
+static struct device_driver smsc_ircc_driver = {
+	.name		= SMSC_IRCC2_DRIVER_NAME,
+	.bus		= &platform_bus_type,
+	.suspend	= smsc_ircc_suspend,
+	.resume		= smsc_ircc_resume,
+};
 
 /* Transceivers for SMSC-ircc */
 
@@ -335,34 +341,42 @@ static inline void register_bank(int iob
  */
 static int __init smsc_ircc_init(void)
 {
-	int ret = -ENODEV;
+	int ret;
 
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
 
+	ret = driver_register(&smsc_ircc_driver);
+	if (ret) {
+		IRDA_ERROR("%s, Can't register driver!\n", driver_name);
+		return ret;
+	}
+
 	dev_count = 0;
 
 	if (ircc_fir > 0 && ircc_sir > 0) {
 		IRDA_MESSAGE(" Overriding FIR address 0x%04x\n", ircc_fir);
 		IRDA_MESSAGE(" Overriding SIR address 0x%04x\n", ircc_sir);
 
-		if (smsc_ircc_open(ircc_fir, ircc_sir, ircc_dma, ircc_irq) == 0)
-			return 0;
+		if (smsc_ircc_open(ircc_fir, ircc_sir, ircc_dma, ircc_irq))
+			ret = -ENODEV;
+	} else {
 
-		return -ENODEV;
-	}
+		/* try user provided configuration register base address */
+		if (ircc_cfg > 0) {
+			IRDA_MESSAGE(" Overriding configuration address "
+				     "0x%04x\n", ircc_cfg);
+			if (!smsc_superio_fdc(ircc_cfg))
+				ret = 0;
+			if (!smsc_superio_lpc(ircc_cfg))
+				ret = 0;
+		}
 
-	/* try user provided configuration register base address */
-	if (ircc_cfg > 0) {
-	        IRDA_MESSAGE(" Overriding configuration address 0x%04x\n",
-			     ircc_cfg);
-		if (!smsc_superio_fdc(ircc_cfg))
-			ret = 0;
-		if (!smsc_superio_lpc(ircc_cfg))
+		if (smsc_ircc_look_for_chips() > 0)
 			ret = 0;
 	}
 
-	if (smsc_ircc_look_for_chips() > 0)
-		ret = 0;
+	if (ret)
+		driver_unregister(&smsc_ircc_driver);
 
 	return ret;
 }
@@ -420,7 +434,7 @@ static int __init smsc_ircc_open(unsigne
 	dev->irq = self->io.irq = irq;
 
 	/* Need to store self somewhere */
-	dev_self[dev_count++] = self;
+	dev_self[dev_count] = self;
 	spin_lock_init(&self->lock);
 
 	self->rx_buff.truesize = SMSC_IRCC2_RX_BUFF_TRUESIZE;
@@ -469,14 +483,22 @@ static int __init smsc_ircc_open(unsigne
 		goto err_out4;
 	}
 
-	self->pmdev = pm_register(PM_SYS_DEV, PM_SYS_IRDA, smsc_ircc_pmproc);
-	if (self->pmdev)
-		self->pmdev->data = self;
+	self->pldev = platform_device_register_simple(SMSC_IRCC2_DRIVER_NAME,
+						      dev_count, NULL, 0);
+	if (IS_ERR(self->pldev)) {
+		err = PTR_ERR(self->pldev);
+		goto err_out5;
+	}
+	dev_set_drvdata(&self->pldev->dev, self);
 
 	IRDA_MESSAGE("IrDA: Registered device %s\n", dev->name);
+	dev_count++;
 
 	return 0;
 
+ err_out5:
+	unregister_netdev(self->netdev);
+
  err_out4:
 	dma_free_coherent(NULL, self->tx_buff.truesize,
 			  self->tx_buff.head, self->tx_buff_dma);
@@ -485,7 +507,7 @@ static int __init smsc_ircc_open(unsigne
 			  self->rx_buff.head, self->rx_buff_dma);
  err_out2:
 	free_netdev(self->netdev);
-	dev_self[--dev_count] = NULL;
+	dev_self[dev_count] = NULL;
  err_out1:
 	release_region(fir_base, SMSC_IRCC2_FIR_CHIP_IO_EXTENT);
 	release_region(sir_base, SMSC_IRCC2_SIR_CHIP_IO_EXTENT);
@@ -1628,44 +1650,31 @@ static int smsc_ircc_net_close(struct ne
 	return 0;
 }
 
-
-static void smsc_ircc_suspend(struct smsc_ircc_cb *self)
+static int smsc_ircc_suspend(struct device *dev, pm_message_t state, u32 level)
 {
+	struct smsc_ircc_cb *self = dev_get_drvdata(dev);
+
 	IRDA_MESSAGE("%s, Suspending\n", driver_name);
 
-	if (!self->io.suspended) {
+	if (level == SUSPEND_DISABLE && !self->io.suspended) {
 		smsc_ircc_net_close(self->netdev);
 		self->io.suspended = 1;
 	}
+
+	return 0;
 }
 
-static void smsc_ircc_wakeup(struct smsc_ircc_cb *self)
+static int smsc_ircc_resume(struct device *dev, u32 level)
 {
-	if (!self->io.suspended)
-		return;
+	struct smsc_ircc_cb *self = dev_get_drvdata(dev);
 
-	/* The code was doing a "cli()" here, but this can't be right.
-	 * If you need protection, do it in net_open with a spinlock
-	 * or give a good reason. - Jean II */
-
-	smsc_ircc_net_open(self->netdev);
-
-	IRDA_MESSAGE("%s, Waking up\n", driver_name);
-}
-
-static int smsc_ircc_pmproc(struct pm_dev *dev, pm_request_t rqst, void *data)
-{
-        struct smsc_ircc_cb *self = (struct smsc_ircc_cb*) dev->data;
-        if (self) {
-                switch (rqst) {
-                case PM_SUSPEND:
-                        smsc_ircc_suspend(self);
-                        break;
-                case PM_RESUME:
-                        smsc_ircc_wakeup(self);
-                        break;
-                }
-        }
+	if (level == RESUME_ENABLE && self->io.suspended) {
+
+		smsc_ircc_net_open(self->netdev);
+		self->io.suspended = 0;
+
+		IRDA_MESSAGE("%s, Waking up\n", driver_name);
+	}
 	return 0;
 }
 
@@ -1684,10 +1693,7 @@ static int __exit smsc_ircc_close(struct
 
 	IRDA_ASSERT(self != NULL, return -1;);
 
-	iobase = self->io.fir_base;
-
-	if (self->pmdev)
-		pm_unregister(self->pmdev);
+	platform_device_unregister(self->pldev);
 
 	/* Remove netdevice */
 	unregister_netdev(self->netdev);
@@ -1696,6 +1702,7 @@ static int __exit smsc_ircc_close(struct
 	spin_lock_irqsave(&self->lock, flags);
 
 	/* Stop interrupts */
+	iobase = self->io.fir_base;
 	register_bank(iobase, 0);
 	outb(0, iobase + IRCC_IER);
 	outb(IRCC_MASTER_RESET, iobase + IRCC_MASTER);
@@ -1742,6 +1749,8 @@ static void __exit smsc_ircc_cleanup(voi
 		if (dev_self[i])
 			smsc_ircc_close(dev_self[i]);
 	}
+
+	driver_unregister(&smsc_ircc_driver);
 }
 
 /*

