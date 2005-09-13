Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbVIMFal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVIMFal (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 01:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVIMFal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 01:30:41 -0400
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:40840 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932298AbVIMFaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 01:30:22 -0400
Message-Id: <20050913052632.289381000.dtor_core@ameritech.net>
References: <20050913052026.358863000.dtor_core@ameritech.net>
Date: Tue, 13 Sep 2005 00:20:28 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: irda-users@lists.sourceforge.net
Cc: Jean Tourrilhes <jt@hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: [patch 2/2] IRDA: nsc-ircc - switch to new power management scheme
Content-Disposition: inline; filename=nsc-ircc-pm.patch
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IRDA: nsc-ircc - switch to new power management scheme

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/net/irda/nsc-ircc.c |  153 ++++++++++++++++++++++++++++++--------------
 drivers/net/irda/nsc-ircc.h |    2 
 2 files changed, 108 insertions(+), 47 deletions(-)

Index: work/drivers/net/irda/nsc-ircc.c
===================================================================
--- work.orig/drivers/net/irda/nsc-ircc.c
+++ work/drivers/net/irda/nsc-ircc.c
@@ -53,13 +53,12 @@
 #include <linux/init.h>
 #include <linux/rtnetlink.h>
 #include <linux/dma-mapping.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <asm/byteorder.h>
 
-#include <linux/pm.h>
-
 #include <net/irda/wrapper.h>
 #include <net/irda/irda.h>
 #include <net/irda/irda_device.h>
@@ -69,7 +68,9 @@
 #define CHIP_IO_EXTENT 8
 #define BROKEN_DONGLE_ID
 
-static char *driver_name = "nsc-ircc";
+#define NSC_IRCC_DRIVER_NAME	"nsc-ircc"
+
+static char *driver_name = NSC_IRCC_DRIVER_NAME;
 
 /* Module parameters */
 static int qos_mtt_bits = 0x07;  /* 1 ms or more */
@@ -145,7 +146,15 @@ static int  nsc_ircc_net_open(struct net
 static int  nsc_ircc_net_close(struct net_device *dev);
 static int  nsc_ircc_net_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static struct net_device_stats *nsc_ircc_net_get_stats(struct net_device *dev);
-static int nsc_ircc_pmproc(struct pm_dev *dev, pm_request_t rqst, void *data);
+static int nsc_ircc_suspend(struct device *dev, pm_message_t state, u32 level);
+static int nsc_ircc_resume(struct device *dev, u32 level);
+
+static struct device_driver nsc_ircc_driver = {
+	.name		= NSC_IRCC_DRIVER_NAME,
+	.bus		= &platform_bus_type,
+	.suspend	= nsc_ircc_suspend,
+	.resume		= nsc_ircc_resume,
+};
 
 /*
  * Function nsc_ircc_init ()
@@ -163,6 +172,12 @@ static int __init nsc_ircc_init(void)
 	int reg;
 	int i = 0;
 
+	ret = driver_register(&nsc_ircc_driver);
+	if (ret) {
+		IRDA_ERROR("%s, Can't register driver!\n", driver_name);
+		return ret;
+	}
+
 	/* Probe for all the NSC chipsets we know about */
 	for (chip=chips; chip->name ; chip++) {
 		IRDA_DEBUG(2, "%s(), Probing for %s ...\n", __FUNCTION__,
@@ -226,12 +241,11 @@ static void __exit nsc_ircc_cleanup(void
 {
 	int i;
 
-	pm_unregister_all(nsc_ircc_pmproc);
-
-	for (i=0; i < 4; i++) {
+	for (i=0; i < 4; i++)
 		if (dev_self[i])
 			nsc_ircc_close(dev_self[i]);
-	}
+
+	driver_unregister(&nsc_ircc_driver);
 }
 
 /*
@@ -244,7 +258,6 @@ static int __init nsc_ircc_open(int i, c
 {
 	struct net_device *dev;
 	struct nsc_ircc_cb *self;
-        struct pm_dev *pmdev;
 	void *ret;
 	int err;
 
@@ -363,11 +376,19 @@ static int __init nsc_ircc_open(int i, c
 	self->io.dongle_id = dongle_id;
 	nsc_ircc_init_dongle_interface(self->io.fir_base, dongle_id);
 
-        pmdev = pm_register(PM_SYS_DEV, PM_SYS_IRDA, nsc_ircc_pmproc);
-        if (pmdev)
-                pmdev->data = self;
+	self->pldev = platform_device_register_simple(driver_name, self->index, NULL, 0);
+	if (IS_ERR(self->pldev)) {
+		IRDA_ERROR("%s(), platform_device_register_simple() failed!\n",
+			   __FUNCTION__);
+		err = PTR_ERR(self->pldev);
+		goto out5;
+	}
+	dev_set_drvdata(&self->pldev->dev, self);
 
 	return 0;
+
+ out5:
+	unregister_netdev(self->netdev);
  out4:
 	dma_free_coherent(NULL, self->tx_buff.truesize,
 			  self->tx_buff.head, self->tx_buff_dma);
@@ -398,6 +419,8 @@ static int __exit nsc_ircc_close(struct 
 
         iobase = self->io.fir_base;
 
+	platform_device_unregister(self->pldev);
+
 	/* Remove netdevice */
 	unregister_netdev(self->netdev);
 
@@ -1995,6 +2018,20 @@ static int nsc_ircc_is_receiving(struct 
 	return status;
 }
 
+static int nsc_ircc_request_irq(struct nsc_ircc_cb *self)
+{
+	int error;
+
+	error = request_irq(self->io.irq, nsc_ircc_interrupt, 0,
+			    self->netdev->name, self->netdev);
+	if (error)
+		IRDA_WARNING("%s, unable to allocate irq=%d, err=%d\n",
+			     driver_name, self->io.irq, error);
+
+	return error;
+}
+
+
 /*
  * Function nsc_ircc_net_open (dev)
  *
@@ -2005,6 +2042,7 @@ static int nsc_ircc_net_open(struct net_
 {
 	struct nsc_ircc_cb *self;
 	int iobase;
+	int error;
 	char hwname[32];
 	__u8 bank;
 
@@ -2017,11 +2055,10 @@ static int nsc_ircc_net_open(struct net_
 
 	iobase = self->io.fir_base;
 
-	if (request_irq(self->io.irq, nsc_ircc_interrupt, 0, dev->name, dev)) {
-		IRDA_WARNING("%s, unable to allocate irq=%d\n",
-			     driver_name, self->io.irq);
-		return -EAGAIN;
-	}
+	error = nsc_ircc_request_irq(self);
+	if (error)
+		return error;
+
 	/*
 	 * Always allocate the DMA channel after the IRQ, and clean up on
 	 * failure.
@@ -2096,7 +2133,8 @@ static int nsc_ircc_net_close(struct net
 	switch_bank(iobase, BANK0);
 	outb(0, iobase+IER);
 
-	free_irq(self->io.irq, dev);
+	if (!self->io.suspended)
+		free_irq(self->io.irq, dev);
 	free_dma(self->io.dma);
 
 	/* Restore bank register */
@@ -2160,44 +2198,67 @@ static struct net_device_stats *nsc_ircc
 	return &self->stats;
 }
 
-static void nsc_ircc_suspend(struct nsc_ircc_cb *self)
+static int nsc_ircc_suspend(struct device *dev, pm_message_t state, u32 level)
 {
-	IRDA_MESSAGE("%s, Suspending\n", driver_name);
+	struct nsc_ircc_cb *self = dev_get_drvdata(dev);
+	__u8 bank;
 
-	if (self->io.suspended)
-		return;
+	if (level == SUSPEND_DISABLE && !self->io.suspended) {
 
-	nsc_ircc_net_close(self->netdev);
+		IRDA_MESSAGE("%s, Suspending\n", driver_name);
 
-	self->io.suspended = 1;
+		rtnl_lock();
+		if (netif_running(self->netdev)) {
+			netif_device_detach(self->netdev);
+
+			/* Disable interrupts */
+			bank = inb(self->io.fir_base + BSR);
+			switch_bank(self->io.fir_base, BANK0);
+			outb(0, self->io.fir_base + IER);
+			outb(bank, self->io.fir_base + BSR);
+
+			free_irq(self->io.irq, self->netdev);
+			disable_dma(self->io.dma);
+		}
+		self->io.suspended = 1;
+		rtnl_unlock();
+	}
+	return 0;
 }
 
-static void nsc_ircc_wakeup(struct nsc_ircc_cb *self)
+static int nsc_ircc_resume(struct device *dev, u32 level)
 {
-	if (!self->io.suspended)
-		return;
-
-	nsc_ircc_setup(&self->io);
-	nsc_ircc_net_open(self->netdev);
+	struct nsc_ircc_cb *self = dev_get_drvdata(dev);
+	__u8 bank;
 
-	IRDA_MESSAGE("%s, Waking up\n", driver_name);
+	if (level == RESUME_ENABLE && self->io.suspended) {
+		IRDA_DEBUG(1, "%s, Waking up\n", driver_name);
 
-	self->io.suspended = 0;
-}
+		rtnl_lock();
+		if (nsc_ircc_setup(&self->io) < 0) {
+			/*
+			 * Don't fail resume process, just kill this
+			 * network interface
+			 */
+			unregister_netdevice(self->netdev);
+		} else if (netif_running(self->netdev)) {
+			if (nsc_ircc_request_irq(self)) {
+				unregister_netdevice(self->netdev);
+			} else {
+				enable_dma(self->io.dma);
+				/* Start interrupts */
+				bank = inb(self->io.fir_base + BSR);
+				switch_bank(self->io.fir_base, BANK0);
+				outb(IER_LS_IE | IER_RXHDL_IE,
+					self->io.fir_base + IER);
+				outb(bank, self->io.fir_base + BSR);
+				netif_device_attach(self->netdev);
+			}
+		}
+		self->io.suspended = 0;
+		rtnl_unlock();
+	}
 
-static int nsc_ircc_pmproc(struct pm_dev *dev, pm_request_t rqst, void *data)
-{
-        struct nsc_ircc_cb *self = (struct nsc_ircc_cb*) dev->data;
-        if (self) {
-                switch (rqst) {
-                case PM_SUSPEND:
-                        nsc_ircc_suspend(self);
-                        break;
-                case PM_RESUME:
-                        nsc_ircc_wakeup(self);
-                        break;
-                }
-        }
 	return 0;
 }
 
Index: work/drivers/net/irda/nsc-ircc.h
===================================================================
--- work.orig/drivers/net/irda/nsc-ircc.h
+++ work/drivers/net/irda/nsc-ircc.h
@@ -269,7 +269,7 @@ struct nsc_ircc_cb {
 	__u32 new_speed;
 	int index;                 /* Instance index */
 
-        struct pm_dev *dev;
+	struct platform_device *pldev;
 };
 
 static inline void switch_bank(int iobase, int bank)

