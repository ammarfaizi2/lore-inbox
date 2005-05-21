Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVEUWoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVEUWoQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 18:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVEUWoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 18:44:15 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:12712 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261197AbVEUWnu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 18:43:50 -0400
Date: Sun, 22 May 2005 00:39:59 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Grant Grundler <grundler@parisc-linux.org>, akpm@osdl.org,
       T-Bone@parisc-linux.org, varenet@parisc-linux.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: patch tulip-natsemi-dp83840a-phy-fix.patch added to -mm tree
Message-ID: <20050521223959.GA4337@electric-eye.fr.zoreil.com>
References: <200505101955.j4AJtX9x032464@shell0.pdx.osdl.net> <42881C58.40001@pobox.com> <20050516050843.GA20107@colo.lackof.org> <4288CE51.1050703@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4288CE51.1050703@pobox.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> :
[tulip_media_select]
> 1) called from timer context, from the media poll timer
> 
> 2) called from spin_lock_irqsave() context, in the ->tx_timeout hook.
> 
> The first case can be fixed by moved all the timer code to a workqueue. 
>  Then when the existing timer fires, kick the workqueue.
> 
> The second case can be fixed by kicking the workqueue upon tx_timeout 
> (which is the reason why I did not suggest queue_delayed_work() use).

First try below. It only moves tulip_select_media() to process context.
The original patch (with s/udelay/msleep/ or such) is not included.

Patch applies/compiles against 2.6.12-rc4.

Comments/suggestions ?

diff -puN a/drivers/net/tulip/tulip.h~tulip-000 b/drivers/net/tulip/tulip.h
--- a/drivers/net/tulip/tulip.h~tulip-000	2005-05-21 22:30:08.133891956 +0200
+++ b/drivers/net/tulip/tulip.h	2005-05-22 00:18:45.598682086 +0200
@@ -46,6 +46,7 @@ struct tulip_chip_table {
 	int valid_intrs;	/* CSR7 interrupt enable settings */
 	int flags;
 	void (*media_timer) (unsigned long data);
+	void (*media_task) (void *);
 };
 
 
@@ -368,6 +369,7 @@ struct tulip_private {
 	unsigned int medialock:1;	/* Don't sense media type. */
 	unsigned int mediasense:1;	/* Media sensing in progress. */
 	unsigned int nway:1, nwayset:1;		/* 21143 internal NWay. */
+	unsigned int timeout_recovery: 1;
 	unsigned int csr0;	/* CSR0 setting. */
 	unsigned int csr6;	/* Current CSR6 control settings. */
 	unsigned char eeprom[EEPROM_SIZE];	/* Serial EEPROM contents. */
@@ -386,6 +388,7 @@ struct tulip_private {
 	void __iomem *base_addr;
 	int csr12_shadow;
 	int pad0;		/* Used for 8-byte alignment */
+	struct work_struct media_work;                          
 };
 
 
@@ -400,7 +403,7 @@ struct eeprom_fixup {
 
 /* 21142.c */
 extern u16 t21142_csr14[];
-void t21142_timer(unsigned long data);
+void t21142_media_task(void *data);
 void t21142_start_nway(struct net_device *dev);
 void t21142_lnk_change(struct net_device *dev, int csr5);
 
@@ -438,7 +441,7 @@ void pnic_lnk_change(struct net_device *
 void pnic_timer(unsigned long data);
 
 /* timer.c */
-void tulip_timer(unsigned long data);
+void tulip_media_task(void *data);
 void mxic_timer(unsigned long data);
 void comet_timer(unsigned long data);
 
@@ -490,4 +493,13 @@ static inline void tulip_restart_rxtx(st
 	tulip_start_rxtx(tp);
 }
 
+static inline void tulip_tx_timeout_complete(struct tulip_private *tp, void __iomem *ioaddr)
+{
+        /* Stop and restart the chip's Tx processes. */
+        tulip_restart_rxtx(tp);
+        /* Trigger an immediate transmit demand. */
+        iowrite32(0, ioaddr + CSR1);
+                 
+        tp->stats.tx_errors++;
+}
 #endif /* __NET_TULIP_H__ */

diff -puN a/drivers/net/tulip/tulip_core.c~tulip-000 b/drivers/net/tulip/tulip_core.c
--- a/drivers/net/tulip/tulip_core.c~tulip-000	2005-05-21 20:57:38.385293188 +0200
+++ b/drivers/net/tulip/tulip_core.c	2005-05-22 00:24:29.144946592 +0200
@@ -132,6 +132,16 @@ int tulip_debug = 1;
 #endif
 
 
+static struct workqueue_struct *ktulipd_workqueue;
+
+static void tulip_timer(unsigned long data)
+{
+	struct net_device *dev = (struct net_device *)data;
+	struct tulip_private *tp = netdev_priv(dev);
+
+	if (likely(netif_running(dev)))
+		queue_work(ktulipd_workqueue, &tp->media_work);
+}
 
 /*
  * This table use during operation for capabilities and media timer.
@@ -145,63 +155,65 @@ struct tulip_chip_table tulip_tbl[] = {
 
   /* DC21140 */
   { "Digital DS21140 Tulip", 128, 0x0001ebef,
-	HAS_MII | HAS_MEDIA_TABLE | CSR12_IN_SROM | HAS_PCI_MWI, tulip_timer },
+	HAS_MII | HAS_MEDIA_TABLE | CSR12_IN_SROM | HAS_PCI_MWI, tulip_timer,
+	tulip_media_task },
 
   /* DC21142, DC21143 */
   { "Digital DS21143 Tulip", 128, 0x0801fbff,
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
+	| HAS_NWAY | HAS_PCI_MWI, tulip_timer, t21142_media_task },
 
   /* DM910X */
   { "Davicom DM9102/DM9102A", 128, 0x0001ebef,
 	HAS_MII | HAS_MEDIA_TABLE | CSR12_IN_SROM | HAS_ACPI,
-	tulip_timer },
+	tulip_timer, tulip_media_task },
 
   /* RS7112 */
   { "Conexant LANfinity", 256, 0x0001ebef,
-	HAS_MII | HAS_ACPI, tulip_timer },
+	HAS_MII | HAS_ACPI, tulip_timer, tulip_media_task },
 
    /* ULi526X */
    { "ULi M5261/M5263", 128, 0x0001ebef,
-        HAS_MII | HAS_MEDIA_TABLE | CSR12_IN_SROM | HAS_ACPI, tulip_timer },
+	HAS_MII | HAS_MEDIA_TABLE | CSR12_IN_SROM | HAS_ACPI, tulip_timer,
+	tulip_media_task },
 };
 
 
@@ -265,6 +277,17 @@ static void set_rx_mode(struct net_devic
 static void poll_tulip(struct net_device *dev);
 #endif
 
+static inline int tulip_create_workqueue(void)
+{
+	ktulipd_workqueue = create_workqueue("ktulipd");
+	return ktulipd_workqueue ? 0 : -ENOMEM;
+}
+
+static inline void tulip_destroy_workqueue(void)
+{
+	destroy_workqueue(ktulipd_workqueue);
+}
+
 static void tulip_set_power_state (struct tulip_private *tp,
 				   int sleep, int snooze)
 {
@@ -526,20 +549,9 @@ static void tulip_tx_timeout(struct net_
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
+		queue_work(ktulipd_workqueue, &tp->media_work);
+		goto out_unlock;
 	} else if (tp->chip_id == PNIC2) {
 		printk(KERN_WARNING "%s: PNIC2 transmit timed out, status %8.8x, "
 		       "CSR6/7 %8.8x / %8.8x CSR12 %8.8x, resetting...\n",
@@ -579,14 +591,9 @@ static void tulip_tx_timeout(struct net_
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
@@ -736,6 +743,8 @@ static void tulip_down (struct net_devic
 	void __iomem *ioaddr = tp->base_addr;
 	unsigned long flags;
 
+	flush_workqueue(ktulipd_workqueue);
+
 	del_timer_sync (&tp->timer);
 #ifdef CONFIG_TULIP_NAPI
 	del_timer_sync (&tp->oom_timer);
@@ -1408,6 +1417,8 @@ static int __devinit tulip_init_one (str
 	tp->timer.data = (unsigned long)dev;
 	tp->timer.function = tulip_tbl[tp->chip_id].media_timer;
 
+	INIT_WORK(&tp->media_work, tulip_tbl[tp->chip_id].media_task, dev);
+
 	dev->base_addr = (unsigned long)ioaddr;
 
 #ifdef CONFIG_TULIP_MWI
@@ -1838,6 +1849,8 @@ static struct pci_driver tulip_driver = 
 
 static int __init tulip_init (void)
 {
+	int ret;
+
 #ifdef MODULE
 	printk (KERN_INFO "%s", version);
 #endif
@@ -1846,14 +1859,23 @@ static int __init tulip_init (void)
 	tulip_rx_copybreak = rx_copybreak;
 	tulip_max_interrupt_work = max_interrupt_work;
 
+	ret = tulip_create_workqueue();
+	if (ret < 0)
+		goto out;
+
 	/* probe for and init boards */
-	return pci_module_init (&tulip_driver);
+	ret = pci_module_init(&tulip_driver);
+	if (ret < 0)
+		tulip_destroy_workqueue();
+out:
+	return ret;
 }
 
 
 static void __exit tulip_cleanup (void)
 {
 	pci_unregister_driver (&tulip_driver);
+	tulip_destroy_workqueue();
 }
 
 
diff -puN a/drivers/net/tulip/21142.c~tulip-000 b/drivers/net/tulip/21142.c
--- a/drivers/net/tulip/21142.c~tulip-000	2005-05-21 20:57:37.978358686 +0200
+++ b/drivers/net/tulip/21142.c	2005-05-22 00:10:21.717431845 +0200
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
diff -puN a/drivers/net/tulip/timer.c~tulip-000 b/drivers/net/tulip/timer.c
--- a/drivers/net/tulip/timer.c~tulip-000	2005-05-21 20:57:38.251314753 +0200
+++ b/drivers/net/tulip/timer.c	2005-05-22 00:24:05.889719386 +0200
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
@@ -127,6 +128,14 @@ void tulip_timer(unsigned long data)
 	}
 	break;
 	}
+
+	spin_lock_irqsave (&tp->lock, flags);
+	if (tp->timeout_recovery) {
+		tp->timeout_recovery = 0;
+		tulip_tx_timeout_complete(tp, ioaddr);
+	}
+	spin_unlock_irqrestore (&tp->lock, flags);
+
 	/* mod_timer synchronizes us with potential add_timer calls
 	 * from interrupts.
 	 */
_
