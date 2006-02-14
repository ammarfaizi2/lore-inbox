Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161134AbWBNQjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbWBNQjj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161133AbWBNQjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:39:39 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:26759 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1161130AbWBNQji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:39:38 -0500
Subject: [RFT/PATCH] 3c509: use proper suspend/resume API
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Date: Tue, 14 Feb 2006 18:39:33 +0200
Message-Id: <1139935173.22151.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am looking for someone with 3c509 netword card that can do
suspend/resume to test this patch.

			Pekka

Subject: 3c509: use proper suspend/resume API
From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch converts 3c509 driver to use proper suspend/resume API instead of
the deprecated pm_register/pm_unregister.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

Index: 2.6/drivers/net/3c509.c
===================================================================
--- 2.6.orig/drivers/net/3c509.c
+++ 2.6/drivers/net/3c509.c
@@ -174,9 +174,6 @@ struct el3_private {
 	/* skb send-queue */
 	int head, size;
 	struct sk_buff *queue[SKB_QUEUE_SIZE];
-#ifdef CONFIG_PM_LEGACY
-	struct pm_dev *pmdev;
-#endif
 	enum {
 		EL3_MCA,
 		EL3_PNP,
@@ -201,11 +198,15 @@ static void el3_tx_timeout (struct net_d
 static void el3_down(struct net_device *dev);
 static void el3_up(struct net_device *dev);
 static struct ethtool_ops ethtool_ops;
-#ifdef CONFIG_PM_LEGACY
-static int el3_suspend(struct pm_dev *pdev);
-static int el3_resume(struct pm_dev *pdev);
-static int el3_pm_callback(struct pm_dev *pdev, pm_request_t rqst, void *data);
+#ifdef CONFIG_PM
+static int el3_suspend(struct device *, pm_message_t);
+static int el3_resume(struct device *);
+#else
+#define el3_suspend NULL
+#define el3_resume NULL
 #endif
+
+
 /* generic device remove for all device types */
 #if defined(CONFIG_EISA) || defined(CONFIG_MCA)
 static int el3_device_remove (struct device *device);
@@ -229,7 +230,9 @@ static struct eisa_driver el3_eisa_drive
 		.driver   = {
 				.name    = "3c509",
 				.probe   = el3_eisa_probe,
-				.remove  = __devexit_p (el3_device_remove)
+				.remove  = __devexit_p (el3_device_remove),
+				.suspend = el3_suspend,
+				.resume  = el3_resume,
 		}
 };
 #endif
@@ -262,6 +265,8 @@ static struct mca_driver el3_mca_driver 
 				.bus = &mca_bus_type,
 				.probe = el3_mca_probe,
 				.remove = __devexit_p(el3_device_remove),
+				.suspend = el3_suspend,
+				.resume  = el3_resume,
 		},
 };
 #endif /* CONFIG_MCA */
@@ -362,10 +367,6 @@ static void el3_common_remove (struct ne
 	struct el3_private *lp = netdev_priv(dev);
 
 	(void) lp;				/* Keep gcc quiet... */
-#ifdef CONFIG_PM_LEGACY
-	if (lp->pmdev)
-		pm_unregister(lp->pmdev);
-#endif
 #if defined(__ISAPNP__)
 	if (lp->type == EL3_PNP)
 		pnp_device_detach(to_pnp_dev(lp->dev));
@@ -572,16 +573,6 @@ no_pnp:
 	if (err)
 		goto out1;
 
-#ifdef CONFIG_PM_LEGACY
-	/* register power management */
-	lp->pmdev = pm_register(PM_ISA_DEV, card_idx, el3_pm_callback);
-	if (lp->pmdev) {
-		struct pm_dev *p;
-		p = lp->pmdev;
-		p->data = (struct net_device *)dev;
-	}
-#endif
-
 	el3_cards++;
 	lp->next_dev = el3_root_dev;
 	el3_root_dev = dev;
@@ -1480,20 +1471,17 @@ el3_up(struct net_device *dev)
 }
 
 /* Power Management support functions */
-#ifdef CONFIG_PM_LEGACY
+#ifdef CONFIG_PM
 
 static int
-el3_suspend(struct pm_dev *pdev)
+el3_suspend(struct device *pdev, pm_message_t state)
 {
 	unsigned long flags;
 	struct net_device *dev;
 	struct el3_private *lp;
 	int ioaddr;
 	
-	if (!pdev && !pdev->data)
-		return -EINVAL;
-
-	dev = (struct net_device *)pdev->data;
+	dev = pdev->driver_data;
 	lp = netdev_priv(dev);
 	ioaddr = dev->base_addr;
 
@@ -1510,17 +1498,14 @@ el3_suspend(struct pm_dev *pdev)
 }
 
 static int
-el3_resume(struct pm_dev *pdev)
+el3_resume(struct device *pdev)
 {
 	unsigned long flags;
 	struct net_device *dev;
 	struct el3_private *lp;
 	int ioaddr;
 	
-	if (!pdev && !pdev->data)
-		return -EINVAL;
-
-	dev = (struct net_device *)pdev->data;
+	dev = pdev->driver_data;
 	lp = netdev_priv(dev);
 	ioaddr = dev->base_addr;
 
@@ -1536,20 +1521,7 @@ el3_resume(struct pm_dev *pdev)
 	return 0;
 }
 
-static int
-el3_pm_callback(struct pm_dev *pdev, pm_request_t rqst, void *data)
-{
-	switch (rqst) {
-		case PM_SUSPEND:
-			return el3_suspend(pdev);
-
-		case PM_RESUME:
-			return el3_resume(pdev);
-	}
-	return 0;
-}
-
-#endif /* CONFIG_PM_LEGACY */
+#endif /* CONFIG_PM */
 
 /* Parameters that may be passed into the module. */
 static int debug = -1;


