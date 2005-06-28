Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVF1GWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVF1GWm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVF1GWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:22:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:39660 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261927AbVF1Fd4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:56 -0400
Cc: gregkh@suse.de
Subject: [PATCH] PCI: make drivers use the pci shutdown callback instead of the driver core callback.
In-Reply-To: <11199367751551@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:55 -0700
Message-Id: <11199367752277@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: make drivers use the pci shutdown callback instead of the driver core callback.

Now we can change the pci core to always set this pointer, as pci drivers
should use it, not the driver core callback.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d18c3db58bc544fce6662ca7edba616ca9788a70
tree dd4c2d2c0bef6d47a32452112a9396a3137d8c10
parent 4002307d2b563a6ab317ca4d7eb1d201a6673d37
author Greg Kroah-Hartman <gregkh@suse.de> Thu, 23 Jun 2005 17:35:56 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:47 -0700

 drivers/message/fusion/mptfc.c    |    4 +---
 drivers/message/fusion/mptscsih.c |   10 +++++-----
 drivers/message/fusion/mptscsih.h |    2 +-
 drivers/message/fusion/mptspi.c   |    4 +---
 drivers/net/e100.c                |    9 ++-------
 drivers/net/via-rhine.c           |   11 ++++-------
 drivers/scsi/3w-9xxx.c            |    8 +++-----
 drivers/scsi/3w-xxxx.c            |    8 +++-----
 drivers/scsi/ipr.c                |   10 ++++------
 drivers/scsi/megaraid.c           |    8 +++-----
 10 files changed, 27 insertions(+), 47 deletions(-)

diff --git a/drivers/message/fusion/mptfc.c b/drivers/message/fusion/mptfc.c
--- a/drivers/message/fusion/mptfc.c
+++ b/drivers/message/fusion/mptfc.c
@@ -364,9 +364,7 @@ static struct pci_driver mptfc_driver = 
 	.id_table	= mptfc_pci_table,
 	.probe		= mptfc_probe,
 	.remove		= __devexit_p(mptscsih_remove),
-	.driver         = {
-		.shutdown = mptscsih_shutdown,
-        },
+	.shutdown	= mptscsih_shutdown,
 #ifdef CONFIG_PM
 	.suspend	= mptscsih_suspend,
 	.resume		= mptscsih_resume,
diff --git a/drivers/message/fusion/mptscsih.c b/drivers/message/fusion/mptscsih.c
--- a/drivers/message/fusion/mptscsih.c
+++ b/drivers/message/fusion/mptscsih.c
@@ -170,7 +170,7 @@ static void	mptscsih_fillbuf(char *buffe
 #endif
 
 void 		mptscsih_remove(struct pci_dev *);
-void 		mptscsih_shutdown(struct device *);
+void 		mptscsih_shutdown(struct pci_dev *);
 #ifdef CONFIG_PM
 int 		mptscsih_suspend(struct pci_dev *pdev, pm_message_t state);
 int 		mptscsih_resume(struct pci_dev *pdev);
@@ -988,7 +988,7 @@ mptscsih_remove(struct pci_dev *pdev)
 #endif
 #endif
 
-	mptscsih_shutdown(&pdev->dev);
+	mptscsih_shutdown(pdev);
 
 	sz1=0;
 
@@ -1026,9 +1026,9 @@ mptscsih_remove(struct pci_dev *pdev)
  *
  */
 void
-mptscsih_shutdown(struct device * dev)
+mptscsih_shutdown(struct pci_dev *pdev)
 {
-	MPT_ADAPTER 		*ioc = pci_get_drvdata(to_pci_dev(dev));
+	MPT_ADAPTER 		*ioc = pci_get_drvdata(pdev);
 	struct Scsi_Host 	*host = ioc->sh;
 	MPT_SCSI_HOST		*hd;
 
@@ -1054,7 +1054,7 @@ mptscsih_shutdown(struct device * dev)
 int
 mptscsih_suspend(struct pci_dev *pdev, pm_message_t state)
 {
-	mptscsih_shutdown(&pdev->dev);
+	mptscsih_shutdown(pdev);
 	return mpt_suspend(pdev,state);
 }
 
diff --git a/drivers/message/fusion/mptscsih.h b/drivers/message/fusion/mptscsih.h
--- a/drivers/message/fusion/mptscsih.h
+++ b/drivers/message/fusion/mptscsih.h
@@ -82,7 +82,7 @@
 #endif
 
 extern void mptscsih_remove(struct pci_dev *);
-extern void mptscsih_shutdown(struct device *);
+extern void mptscsih_shutdown(struct pci_dev *);
 #ifdef CONFIG_PM
 extern int mptscsih_suspend(struct pci_dev *pdev, u32 state);
 extern int mptscsih_resume(struct pci_dev *pdev);
diff --git a/drivers/message/fusion/mptspi.c b/drivers/message/fusion/mptspi.c
--- a/drivers/message/fusion/mptspi.c
+++ b/drivers/message/fusion/mptspi.c
@@ -419,9 +419,7 @@ static struct pci_driver mptspi_driver =
 	.id_table	= mptspi_pci_table,
 	.probe		= mptspi_probe,
 	.remove		= __devexit_p(mptscsih_remove),
-	.driver         = {
-		.shutdown = mptscsih_shutdown,
-        },
+	.shutdown	= mptscsih_shutdown,
 #ifdef CONFIG_PM
 	.suspend	= mptscsih_suspend,
 	.resume		= mptscsih_resume,
diff --git a/drivers/net/e100.c b/drivers/net/e100.c
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -2440,9 +2440,8 @@ static int e100_resume(struct pci_dev *p
 #endif
 
 
-static void e100_shutdown(struct device *dev)
+static void e100_shutdown(struct pci_dev *pdev)
 {
-	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct nic *nic = netdev_priv(netdev);
 
@@ -2463,11 +2462,7 @@ static struct pci_driver e100_driver = {
 	.suspend =      e100_suspend,
 	.resume =       e100_resume,
 #endif
-
-	.driver = {
-		.shutdown = e100_shutdown,
-	}
-
+	.shutdown =	e100_shutdown,
 };
 
 static int __init e100_init_module(void)
diff --git a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
--- a/drivers/net/via-rhine.c
+++ b/drivers/net/via-rhine.c
@@ -507,7 +507,7 @@ static struct net_device_stats *rhine_ge
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static struct ethtool_ops netdev_ethtool_ops;
 static int  rhine_close(struct net_device *dev);
-static void rhine_shutdown (struct device *gdev);
+static void rhine_shutdown (struct pci_dev *pdev);
 
 #define RHINE_WAIT_FOR(condition) do {					\
 	int i=1024;							\
@@ -1895,9 +1895,8 @@ static void __devexit rhine_remove_one(s
 	pci_set_drvdata(pdev, NULL);
 }
 
-static void rhine_shutdown (struct device *gendev)
+static void rhine_shutdown (struct pci_dev *pdev)
 {
-	struct pci_dev *pdev = to_pci_dev(gendev);
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct rhine_private *rp = netdev_priv(dev);
 	void __iomem *ioaddr = rp->base;
@@ -1956,7 +1955,7 @@ static int rhine_suspend(struct pci_dev 
 	pci_save_state(pdev);
 
 	spin_lock_irqsave(&rp->lock, flags);
-	rhine_shutdown(&pdev->dev);
+	rhine_shutdown(pdev);
 	spin_unlock_irqrestore(&rp->lock, flags);
 
 	free_irq(dev->irq, dev);
@@ -2010,9 +2009,7 @@ static struct pci_driver rhine_driver = 
 	.suspend	= rhine_suspend,
 	.resume		= rhine_resume,
 #endif /* CONFIG_PM */
-	.driver = {
-		.shutdown = rhine_shutdown,
-	}
+	.shutdown =	rhine_shutdown,
 };
 
 
diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -1916,9 +1916,9 @@ static void __twa_shutdown(TW_Device_Ext
 } /* End __twa_shutdown() */
 
 /* Wrapper for __twa_shutdown */
-static void twa_shutdown(struct device *dev)
+static void twa_shutdown(struct pci_dev *pdev)
 {
-	struct Scsi_Host *host = pci_get_drvdata(to_pci_dev(dev));
+	struct Scsi_Host *host = pci_get_drvdata(pdev);
 	TW_Device_Extension *tw_dev = (TW_Device_Extension *)host->hostdata;
 
 	__twa_shutdown(tw_dev);
@@ -2140,9 +2140,7 @@ static struct pci_driver twa_driver = {
 	.id_table	= twa_pci_tbl,
 	.probe		= twa_probe,
 	.remove		= twa_remove,
-	.driver		= {
-		.shutdown = twa_shutdown
-	}
+	.shutdown	= twa_shutdown
 };
 
 /* This function is called on driver initialization */
diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -2264,9 +2264,9 @@ static void __tw_shutdown(TW_Device_Exte
 } /* End __tw_shutdown() */
 
 /* Wrapper for __tw_shutdown */
-static void tw_shutdown(struct device *dev)
+static void tw_shutdown(struct pci_dev *pdev)
 {
-	struct Scsi_Host *host = pci_get_drvdata(to_pci_dev(dev));
+	struct Scsi_Host *host = pci_get_drvdata(pdev);
 	TW_Device_Extension *tw_dev = (TW_Device_Extension *)host->hostdata;
 
 	__tw_shutdown(tw_dev);
@@ -2451,9 +2451,7 @@ static struct pci_driver tw_driver = {
 	.id_table	= tw_pci_tbl,
 	.probe		= tw_probe,
 	.remove		= tw_remove,
-	.driver		= {
-		.shutdown = tw_shutdown
-	}
+	.shutdown	= tw_shutdown,
 };
 
 /* This function is called on driver initialization */
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -6012,7 +6012,7 @@ static int __devinit ipr_probe(struct pc
 
 /**
  * ipr_shutdown - Shutdown handler.
- * @dev:	device struct
+ * @pdev:	pci device struct
  *
  * This function is invoked upon system shutdown/reboot. It will issue
  * an adapter shutdown to the adapter to flush the write cache.
@@ -6020,9 +6020,9 @@ static int __devinit ipr_probe(struct pc
  * Return value:
  * 	none
  **/
-static void ipr_shutdown(struct device *dev)
+static void ipr_shutdown(struct pci_dev *pdev)
 {
-	struct ipr_ioa_cfg *ioa_cfg = pci_get_drvdata(to_pci_dev(dev));
+	struct ipr_ioa_cfg *ioa_cfg = pci_get_drvdata(pdev);
 	unsigned long lock_flags = 0;
 
 	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
@@ -6068,9 +6068,7 @@ static struct pci_driver ipr_driver = {
 	.id_table = ipr_pci_table,
 	.probe = ipr_probe,
 	.remove = ipr_remove,
-	.driver = {
-		.shutdown = ipr_shutdown,
-	},
+	.shutdown = ipr_shutdown,
 };
 
 /**
diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -5036,9 +5036,9 @@ megaraid_remove_one(struct pci_dev *pdev
 }
 
 static void
-megaraid_shutdown(struct device *dev)
+megaraid_shutdown(struct pci_dev *pdev)
 {
-	struct Scsi_Host *host = pci_get_drvdata(to_pci_dev(dev));
+	struct Scsi_Host *host = pci_get_drvdata(pdev);
 	adapter_t *adapter = (adapter_t *)host->hostdata;
 
 	__megaraid_shutdown(adapter);
@@ -5070,9 +5070,7 @@ static struct pci_driver megaraid_pci_dr
 	.id_table	= megaraid_pci_tbl,
 	.probe		= megaraid_probe_one,
 	.remove		= __devexit_p(megaraid_remove_one),
-	.driver		= {
-		.shutdown = megaraid_shutdown,
-	},
+	.shutdown	= megaraid_shutdown,
 };
 
 static int __init megaraid_init(void)

