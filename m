Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWIHSYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWIHSYA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWIHSXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:23:33 -0400
Received: from mga07.intel.com ([143.182.124.22]:31340 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751145AbWIHSXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:23:21 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,134,1157353200"; 
   d="scan'208"; a="113819742:sNHT6909352842"
Message-Id: <20060908182023.593718000@linux.intel.com>
References: <20060908181533.771856000@linux.intel.com>
User-Agent: quilt/0.45-1
Date: Fri, 08 Sep 2006 11:15:38 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Kyle McMartin <kyle@parisc-linux.org>,
       Valerie Henson <val_henson@linux.intel.com>,
       Jeff Garzik <jeff@garzik.org>
Subject: [patch 05/10] [TULIP] Defer tulip_select_media() to process context
Content-Disposition: inline; filename=tulip-defer-tulip_select_media-to-process-context
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francois Romieu <romieu@fr.zoreil.com>

Move tulip_select_media() processing to a workqueue, instead of
delaying in interrupt context, edited by Kyle McMartin to use kevent
thread, instead of creating its own workqueue.

Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>
Signed-off-by: Valerie Henson <val_henson@linux.intel.com>
Signed-off-by: Jeff Garzik <jeff@garzik.org>

---
 drivers/net/tulip/21142.c      |    4 +-
 drivers/net/tulip/timer.c      |   14 +++++++-
 drivers/net/tulip/tulip.h      |   19 ++++++++++--
 drivers/net/tulip/tulip_core.c |   64 +++++++++++++++++++----------------------
 4 files changed, 60 insertions(+), 41 deletions(-)

--- linux-2.6.18-rc4-mm1.orig/drivers/net/tulip/21142.c
+++ linux-2.6.18-rc4-mm1/drivers/net/tulip/21142.c
@@ -26,9 +26,9 @@ static u16 t21142_csr15[] = { 0x0008, 0x
 
 /* Handle the 21143 uniquely: do autoselect with NWay, not the EEPROM list
    of available transceivers.  */
-void t21142_timer(unsigned long data)
+void t21142_media_task(void *data)
 {
-	struct net_device *dev = (struct net_device *)data;
+	struct net_device *dev = data;
 	struct tulip_private *tp = netdev_priv(dev);
 	void __iomem *ioaddr = tp->base_addr;
 	int csr12 = ioread32(ioaddr + CSR12);
--- linux-2.6.18-rc4-mm1.orig/drivers/net/tulip/timer.c
+++ linux-2.6.18-rc4-mm1/drivers/net/tulip/timer.c
@@ -18,13 +18,14 @@
 #include "tulip.h"
 
 
-void tulip_timer(unsigned long data)
+void tulip_media_task(void *data)
 {
-	struct net_device *dev = (struct net_device *)data;
+	struct net_device *dev = data;
 	struct tulip_private *tp = netdev_priv(dev);
 	void __iomem *ioaddr = tp->base_addr;
 	u32 csr12 = ioread32(ioaddr + CSR12);
 	int next_tick = 2*HZ;
+	unsigned long flags;
 
 	if (tulip_debug > 2) {
 		printk(KERN_DEBUG "%s: Media selection tick, %s, status %8.8x mode"
@@ -126,6 +127,15 @@ void tulip_timer(unsigned long data)
 	}
 	break;
 	}
+
+
+	spin_lock_irqsave(&tp->lock, flags);
+	if (tp->timeout_recovery) {
+		tulip_tx_timeout_complete(tp, ioaddr);
+		tp->timeout_recovery = 0;
+	}
+	spin_unlock_irqrestore(&tp->lock, flags);
+
 	/* mod_timer synchronizes us with potential add_timer calls
 	 * from interrupts.
 	 */
--- linux-2.6.18-rc4-mm1.orig/drivers/net/tulip/tulip.h
+++ linux-2.6.18-rc4-mm1/drivers/net/tulip/tulip.h
@@ -44,7 +44,8 @@ struct tulip_chip_table {
 	int io_size;
 	int valid_intrs;	/* CSR7 interrupt enable settings */
 	int flags;
-	void (*media_timer) (unsigned long data);
+	void (*media_timer) (unsigned long);
+	void (*media_task) (void *);
 };
 
 
@@ -366,6 +367,7 @@ struct tulip_private {
 	unsigned int medialock:1;	/* Don't sense media type. */
 	unsigned int mediasense:1;	/* Media sensing in progress. */
 	unsigned int nway:1, nwayset:1;		/* 21143 internal NWay. */
+	unsigned int timeout_recovery:1;
 	unsigned int csr0;	/* CSR0 setting. */
 	unsigned int csr6;	/* Current CSR6 control settings. */
 	unsigned char eeprom[EEPROM_SIZE];	/* Serial EEPROM contents. */
@@ -384,6 +386,7 @@ struct tulip_private {
 	void __iomem *base_addr;
 	int csr12_shadow;
 	int pad0;		/* Used for 8-byte alignment */
+	struct work_struct media_work;
 };
 
 
@@ -398,7 +401,7 @@ struct eeprom_fixup {
 
 /* 21142.c */
 extern u16 t21142_csr14[];
-void t21142_timer(unsigned long data);
+void t21142_media_task(void *data);
 void t21142_start_nway(struct net_device *dev);
 void t21142_lnk_change(struct net_device *dev, int csr5);
 
@@ -436,7 +439,7 @@ void pnic_lnk_change(struct net_device *
 void pnic_timer(unsigned long data);
 
 /* timer.c */
-void tulip_timer(unsigned long data);
+void tulip_media_task(void *data);
 void mxic_timer(unsigned long data);
 void comet_timer(unsigned long data);
 
@@ -488,4 +491,14 @@ static inline void tulip_restart_rxtx(st
 	tulip_start_rxtx(tp);
 }
 
+static inline void tulip_tx_timeout_complete(struct tulip_private *tp, void __iomem *ioaddr)
+{
+	/* Stop and restart the chip's Tx processes. */
+	tulip_restart_rxtx(tp);
+	/* Trigger an immediate transmit demand. */
+	iowrite32(0, ioaddr + CSR1);
+
+	tp->stats.tx_errors++;
+}
+
 #endif /* __NET_TULIP_H__ */
--- linux-2.6.18-rc4-mm1.orig/drivers/net/tulip/tulip_core.c
+++ linux-2.6.18-rc4-mm1/drivers/net/tulip/tulip_core.c
@@ -130,7 +130,14 @@ int tulip_debug = TULIP_DEBUG;
 int tulip_debug = 1;
 #endif
 
+static void tulip_timer(unsigned long data)
+{
+	struct net_device *dev = (struct net_device *)data;
+	struct tulip_private *tp = netdev_priv(dev);
 
+	if (netif_running(dev))
+		schedule_work(&tp->media_work);
+}
 
 /*
  * This table use during operation for capabilities and media timer.
@@ -144,59 +151,60 @@ struct tulip_chip_table tulip_tbl[] = {
 
   /* DC21140 */
   { "Digital DS21140 Tulip", 128, 0x0001ebef,
-	HAS_MII | HAS_MEDIA_TABLE | CSR12_IN_SROM | HAS_PCI_MWI, tulip_timer },
+	HAS_MII | HAS_MEDIA_TABLE | CSR12_IN_SROM | HAS_PCI_MWI, tulip_timer,
+	tulip_media_task },
 
   /* DC21142, DC21143 */
   { "Digital DS21142/43 Tulip", 128, 0x0801fbff,
 	HAS_MII | HAS_MEDIA_TABLE | ALWAYS_CHECK_MII | HAS_ACPI | HAS_NWAY
-	| HAS_INTR_MITIGATION | HAS_PCI_MWI, t21142_timer },
+	| HAS_INTR_MITIGATION | HAS_PCI_MWI, tulip_timer, t21142_media_task },
 
   /* LC82C168 */
   { "Lite-On 82c168 PNIC", 256, 0x0001fbef,
-	HAS_MII | HAS_PNICNWAY, pnic_timer },
+	HAS_MII | HAS_PNICNWAY, pnic_timer, },
 
   /* MX98713 */
   { "Macronix 98713 PMAC", 128, 0x0001ebef,
-	HAS_MII | HAS_MEDIA_TABLE | CSR12_IN_SROM, mxic_timer },
+	HAS_MII | HAS_MEDIA_TABLE | CSR12_IN_SROM, mxic_timer, },
 
   /* MX98715 */
   { "Macronix 98715 PMAC", 256, 0x0001ebef,
-	HAS_MEDIA_TABLE, mxic_timer },
+	HAS_MEDIA_TABLE, mxic_timer, },
 
   /* MX98725 */
   { "Macronix 98725 PMAC", 256, 0x0001ebef,
-	HAS_MEDIA_TABLE, mxic_timer },
+	HAS_MEDIA_TABLE, mxic_timer, },
 
   /* AX88140 */
   { "ASIX AX88140", 128, 0x0001fbff,
 	HAS_MII | HAS_MEDIA_TABLE | CSR12_IN_SROM | MC_HASH_ONLY
-	| IS_ASIX, tulip_timer },
+	| IS_ASIX, tulip_timer, tulip_media_task },
 
   /* PNIC2 */
   { "Lite-On PNIC-II", 256, 0x0801fbff,
-	HAS_MII | HAS_NWAY | HAS_8023X | HAS_PCI_MWI, pnic2_timer },
+	HAS_MII | HAS_NWAY | HAS_8023X | HAS_PCI_MWI, pnic2_timer, },
 
   /* COMET */
   { "ADMtek Comet", 256, 0x0001abef,
-	HAS_MII | MC_HASH_ONLY | COMET_MAC_ADDR, comet_timer },
+	HAS_MII | MC_HASH_ONLY | COMET_MAC_ADDR, comet_timer, },
 
   /* COMPEX9881 */
   { "Compex 9881 PMAC", 128, 0x0001ebef,
-	HAS_MII | HAS_MEDIA_TABLE | CSR12_IN_SROM, mxic_timer },
+	HAS_MII | HAS_MEDIA_TABLE | CSR12_IN_SROM, mxic_timer, },
 
   /* I21145 */
   { "Intel DS21145 Tulip", 128, 0x0801fbff,
 	HAS_MII | HAS_MEDIA_TABLE | ALWAYS_CHECK_MII | HAS_ACPI
-	| HAS_NWAY | HAS_PCI_MWI, t21142_timer },
+	| HAS_NWAY | HAS_PCI_MWI, tulip_timer, tulip_media_task },
 
   /* DM910X */
   { "Davicom DM9102/DM9102A", 128, 0x0001ebef,
 	HAS_MII | HAS_MEDIA_TABLE | CSR12_IN_SROM | HAS_ACPI,
-	tulip_timer },
+	tulip_timer, tulip_media_task },
 
   /* RS7112 */
   { "Conexant LANfinity", 256, 0x0001ebef,
-	HAS_MII | HAS_ACPI, tulip_timer },
+	HAS_MII | HAS_ACPI, tulip_timer, tulip_media_task },
 
 };
 
@@ -524,20 +532,9 @@ static void tulip_tx_timeout(struct net_
 			   "SIA %8.8x %8.8x %8.8x %8.8x, resetting...\n",
 			   dev->name, ioread32(ioaddr + CSR5), ioread32(ioaddr + CSR12),
 			   ioread32(ioaddr + CSR13), ioread32(ioaddr + CSR14), ioread32(ioaddr + CSR15));
-		if ( ! tp->medialock  &&  tp->mtable) {
-			do
-				--tp->cur_index;
-			while (tp->cur_index >= 0
-				   && (tulip_media_cap[tp->mtable->mleaf[tp->cur_index].media]
-					   & MediaIsFD));
-			if (--tp->cur_index < 0) {
-				/* We start again, but should instead look for default. */
-				tp->cur_index = tp->mtable->leafcount - 1;
-			}
-			tulip_select_media(dev, 0);
-			printk(KERN_WARNING "%s: transmit timed out, switching to %s "
-				   "media.\n", dev->name, medianame[dev->if_port]);
-		}
+		tp->timeout_recovery = 1;
+		schedule_work(&tp->media_work);
+		goto out_unlock;
 	} else if (tp->chip_id == PNIC2) {
 		printk(KERN_WARNING "%s: PNIC2 transmit timed out, status %8.8x, "
 		       "CSR6/7 %8.8x / %8.8x CSR12 %8.8x, resetting...\n",
@@ -577,14 +574,9 @@ static void tulip_tx_timeout(struct net_
 	}
 #endif
 
-	/* Stop and restart the chip's Tx processes . */
-
-	tulip_restart_rxtx(tp);
-	/* Trigger an immediate transmit demand. */
-	iowrite32(0, ioaddr + CSR1);
-
-	tp->stats.tx_errors++;
+	tulip_tx_timeout_complete(tp, ioaddr);
 
+out_unlock:
 	spin_unlock_irqrestore (&tp->lock, flags);
 	dev->trans_start = jiffies;
 	netif_wake_queue (dev);
@@ -734,6 +726,8 @@ static void tulip_down (struct net_devic
 	void __iomem *ioaddr = tp->base_addr;
 	unsigned long flags;
 
+	flush_scheduled_work();
+
 	del_timer_sync (&tp->timer);
 #ifdef CONFIG_TULIP_NAPI
 	del_timer_sync (&tp->oom_timer);
@@ -1412,6 +1406,8 @@ static int __devinit tulip_init_one (str
 	tp->timer.data = (unsigned long)dev;
 	tp->timer.function = tulip_tbl[tp->chip_id].media_timer;
 
+	INIT_WORK(&tp->media_work, tulip_tbl[tp->chip_id].media_task, dev);
+
 	dev->base_addr = (unsigned long)ioaddr;
 
 #ifdef CONFIG_TULIP_MWI

--
