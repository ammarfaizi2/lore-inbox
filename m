Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbUJZMLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbUJZMLU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 08:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbUJZMLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 08:11:19 -0400
Received: from sd291.sivit.org ([194.146.225.122]:36747 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262245AbUJZMCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 08:02:43 -0400
Date: Tue, 26 Oct 2004 14:03:55 +0200
From: Stelian Pop <stelian@popies.net>
To: Dominik Brodowski <linux@dominikbrodowski.de>, jgarzik@pobox.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: David Hinds <dahinds@users.sourceforge.net>
Subject: Re: [PATCH] pcmcia network drivers cleanup
Message-ID: <20041026120352.GE2998@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Dominik Brodowski <linux@dominikbrodowski.de>, jgarzik@pobox.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	David Hinds <dahinds@users.sourceforge.net>
References: <20041025152121.GA7647@dominikbrodowski.de> <20041025153038.GF3161@crusoe.alcove-fr> <20041025153615.GA7730@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025153615.GA7730@dominikbrodowski.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 05:36:15PM +0200, Dominik Brodowski wrote:

> You need to convert all paramters at once, as MODULE_PARM and module_parm()
> can't exist in the same module at the same time anyway. Also, as all
> INT_MODULE_PARMs were defined to be MODULE_PARM, it should be safe to do so.

Ok, here is an updated patch which:

  * makes debugging work (PCMCIA_DEBUG does not exist anymore, make the
    Makefile test for CONFIG_PCMCIA_DEBUG and activate DEBUG in CFLAGS)
    and use the same debugging macros for every driver through code 
    reuse.
  * converts all drivers to directly use module_param() instead of the
    homebrew INT_MODULE_PARAM (based on MODULE_PARM()).

This was tested with the pcnet_cs driver, the others compile cleanly
but have not been tested.

Stelian.

 drivers/net/pcmcia/3c574_cs.c         |   91 +++++++--------
 drivers/net/pcmcia/3c589_cs.c         |   81 ++++++-------
 drivers/net/pcmcia/Makefile           |    4 
 drivers/net/pcmcia/axnet_cs.c         |   38 ++----
 drivers/net/pcmcia/com20020_cs.c      |   85 ++++++--------
 drivers/net/pcmcia/fmvj18x_cs.c       |   71 +++++------
 drivers/net/pcmcia/ibmtr_cs.c         |   40 +++---
 drivers/net/pcmcia/nmclan_cs.c        |  203 ++++++++++++++++------------------
 drivers/net/pcmcia/pcnet_cs.c         |   83 ++++++++-----
 drivers/net/pcmcia/smc91c92_cs.c      |  101 ++++++++--------
 drivers/net/pcmcia/xirc2ps_cs.c       |  126 ++++++++++-----------
 linux-2.6/drivers/net/pcmcia/common.h |   16 ++
 12 files changed, 467 insertions(+), 472 deletions(-)


Signed-off-by: Stelian Pop <stelian@popies.net>

===== drivers/net/pcmcia/Makefile 1.15 vs edited =====
--- 1.15/drivers/net/pcmcia/Makefile	2003-02-26 03:56:15 +01:00
+++ edited/drivers/net/pcmcia/Makefile	2004-10-22 00:01:15 +02:00
@@ -2,6 +2,10 @@
 # Makefile for the Linux PCMCIA network device drivers.
 #
 
+ifeq ($(CONFIG_PCMCIA_DEBUG),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
+
 # 16-bit client drivers
 obj-$(CONFIG_PCMCIA_3C589)	+= 3c589_cs.o
 obj-$(CONFIG_PCMCIA_3C574)	+= 3c574_cs.o
===== drivers/net/pcmcia/3c574_cs.c 1.34 vs edited =====
--- 1.34/drivers/net/pcmcia/3c574_cs.c	2004-10-20 10:37:15 +02:00
+++ edited/drivers/net/pcmcia/3c574_cs.c	2004-10-26 11:00:58 +02:00
@@ -98,6 +98,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/system.h>
+#include "common.h"
 
 /*====================================================================*/
 
@@ -107,29 +108,27 @@
 MODULE_DESCRIPTION("3Com 3c574 series PCMCIA ethernet driver");
 MODULE_LICENSE("GPL");
 
-#define INT_MODULE_PARM(n, v) static int n = v; MODULE_PARM(n, "i")
-
-/* Now-standard PC card module parameters. */
-INT_MODULE_PARM(irq_mask, 0xdeb8);
+/* Bit map of interrupts to choose from */
+static int irq_mask = 0xdeb8;
+module_param(irq_mask, int, 0444);
 static int irq_list[4] = { -1 };
-MODULE_PARM(irq_list, "1-4i");
+module_param_array(irq_list, int, NULL, 0444);
 
 /* Maximum events (Rx packets, etc.) to handle at each interrupt. */
-INT_MODULE_PARM(max_interrupt_work, 32);
+static int max_interrupt_work = 32;
+module_param(max_interrupt_work, int, 0444);
 
 /* Force full duplex modes? */
-INT_MODULE_PARM(full_duplex, 0);
+static int full_duplex; /* = 0 */
+module_param(full_duplex, int, 0444);
 
 /* Autodetect link polarity reversal? */
-INT_MODULE_PARM(auto_polarity, 1);
+static int auto_polarity = 1;
+module_param(auto_polarity, int, 0444);
 
-#ifdef PCMCIA_DEBUG
-INT_MODULE_PARM(pc_debug, PCMCIA_DEBUG);
-#define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
-static char *version =
+#ifdef DEBUG
+static char __attribute((unused)) *version =
 "3c574_cs.c 1.65ac1 2003/04/07 Donald Becker/David Hinds, becker@scyld.com.\n";
-#else
-#define DEBUG(n, args...)
 #endif
 
 /*====================================================================*/
@@ -277,7 +276,7 @@
 	struct net_device *dev;
 	int i, ret;
 
-	DEBUG(0, "3c574_attach()\n");
+	pn_dbg(0, "3c574_attach()\n");
 
 	/* Create the PC card device object. */
 	dev = alloc_etherdev(sizeof(struct el3_private));
@@ -354,7 +353,7 @@
 	struct net_device *dev = link->priv;
 	dev_link_t **linkp;
 
-	DEBUG(0, "3c574_detach(0x%p)\n", link);
+	pn_dbg(0, "3c574_detach(0x%p)\n", link);
 
 	/* Locate device structure */
 	for (linkp = &dev_list; *linkp; linkp = &(*linkp)->next)
@@ -403,7 +402,7 @@
 
 	phys_addr = (u16 *)dev->dev_addr;
 
-	DEBUG(0, "3c574_config(0x%p)\n", link);
+	pn_dbg(0, "3c574_config(0x%p)\n", link);
 
 	tuple.Attributes = 0;
 	tuple.DesiredTuple = CISTPL_CONFIG;
@@ -496,8 +495,8 @@
 			mii_status = mdio_read(ioaddr, phy & 0x1f, 1);
 			if (mii_status != 0xffff) {
 				lp->phys = phy & 0x1f;
-				DEBUG(0, "  MII transceiver at index %d, status %x.\n",
-					  phy, mii_status);
+				pn_dbg(0, "  MII transceiver at index %d, status %x.\n",
+				       phy, mii_status);
 				if ((mii_status & 0x0040) == 0)
 					mii_preamble_required = 1;
 				break;
@@ -554,7 +553,7 @@
 
 static void tc574_release(dev_link_t *link)
 {
-	DEBUG(0, "3c574_release(0x%p)\n", link);
+	pn_dbg(0, "3c574_release(0x%p)\n", link);
 
 	pcmcia_release_configuration(link->handle);
 	pcmcia_release_io(link->handle, &link->io);
@@ -576,7 +575,7 @@
 	dev_link_t *link = args->client_data;
 	struct net_device *dev = link->priv;
 
-	DEBUG(1, "3c574_event(0x%06x)\n", event);
+	pn_dbg(1, "3c574_event(0x%06x)\n", event);
 
 	switch (event) {
 	case CS_EVENT_CARD_REMOVAL:
@@ -832,8 +831,8 @@
 	lp->media.expires = jiffies + HZ;
 	add_timer(&lp->media);
 	
-	DEBUG(2, "%s: opened, status %4.4x.\n",
-		  dev->name, inw(dev->base_addr + EL3_STATUS));
+	pn_dbg(2, "%s: opened, status %4.4x.\n",
+	       dev->name, inw(dev->base_addr + EL3_STATUS));
 	
 	return 0;
 }
@@ -868,8 +867,8 @@
 		if (tx_status & 0x30)
 			tc574_wait_for_completion(dev, TxReset);
 		if (tx_status & 0x38) {
-			DEBUG(1, "%s: transmit error: status 0x%02x\n",
-				  dev->name, tx_status);
+			pn_dbg(1, "%s: transmit error: status 0x%02x\n",
+			       dev->name, tx_status);
 			outw(TxEnable, ioaddr + EL3_CMD);
 			lp->stats.tx_aborted_errors++;
 		}
@@ -883,8 +882,8 @@
 	struct el3_private *lp = netdev_priv(dev);
 	unsigned long flags;
 
-	DEBUG(3, "%s: el3_start_xmit(length = %ld) called, "
-		  "status %4.4x.\n", dev->name, (long)skb->len,
+	pn_dbg(3, "%s: el3_start_xmit(length = %ld) called, "
+	       "status %4.4x.\n", dev->name, (long)skb->len,
 		  inw(ioaddr + EL3_STATUS));
 
 	spin_lock_irqsave(&lp->window_lock, flags);
@@ -921,8 +920,8 @@
 		return IRQ_NONE;
 	ioaddr = dev->base_addr;
 
-	DEBUG(3, "%s: interrupt, status %4.4x.\n",
-		  dev->name, inw(ioaddr + EL3_STATUS));
+	pn_dbg(3, "%s: interrupt, status %4.4x.\n",
+	       dev->name, inw(ioaddr + EL3_STATUS));
 
 	spin_lock(&lp->window_lock);
 	
@@ -930,7 +929,7 @@
 		   (IntLatch | RxComplete | RxEarly | StatsFull)) {
 		if (!netif_device_present(dev) ||
 			((status & 0xe000) != 0x2000)) {
-			DEBUG(1, "%s: Interrupt from dead card\n", dev->name);
+			pn_dbg(1, "%s: Interrupt from dead card\n", dev->name);
 			break;
 		}
 
@@ -940,7 +939,7 @@
 			work_budget = el3_rx(dev, work_budget);
 
 		if (status & TxAvailable) {
-			DEBUG(3, "  TX room bit was handled.\n");
+			pn_dbg(3, "  TX room bit was handled.\n");
 			/* There's room in the FIFO for a full-sized packet. */
 			outw(AckIntr | TxAvailable, ioaddr + EL3_CMD);
 			netif_wake_queue(dev);
@@ -980,8 +979,8 @@
 		}
 
 		if (--work_budget < 0) {
-			DEBUG(0, "%s: Too much work in interrupt, "
-				  "status %4.4x.\n", dev->name, status);
+			pn_dbg(0, "%s: Too much work in interrupt, "
+			       "status %4.4x.\n", dev->name, status);
 			/* Clear all interrupts */
 			outw(AckIntr | 0xFF, ioaddr + EL3_CMD);
 			break;
@@ -990,8 +989,8 @@
 		outw(AckIntr | IntReq | IntLatch, ioaddr + EL3_CMD);
 	}
 
-	DEBUG(3, "%s: exiting interrupt, status %4.4x.\n",
-		  dev->name, inw(ioaddr + EL3_STATUS));
+	pn_dbg(3, "%s: exiting interrupt, status %4.4x.\n",
+	       dev->name, inw(ioaddr + EL3_STATUS));
 		  
 	spin_unlock(&lp->window_lock);
 	return IRQ_RETVAL(handled);
@@ -1098,7 +1097,7 @@
 	ioaddr_t ioaddr = dev->base_addr;
 	u8 rx, tx, up;
 
-	DEBUG(2, "%s: updating the statistics.\n", dev->name);
+	pn_dbg(2, "%s: updating the statistics.\n", dev->name);
 
 	if (inw(ioaddr+EL3_STATUS) == 0xffff) /* No card. */
 		return;
@@ -1135,8 +1134,8 @@
 	ioaddr_t ioaddr = dev->base_addr;
 	short rx_status;
 	
-	DEBUG(3, "%s: in rx_packet(), status %4.4x, rx_status %4.4x.\n",
-		  dev->name, inw(ioaddr+EL3_STATUS), inw(ioaddr+RxStatus));
+	pn_dbg(3, "%s: in rx_packet(), status %4.4x, rx_status %4.4x.\n",
+	       dev->name, inw(ioaddr+EL3_STATUS), inw(ioaddr+RxStatus));
 	while (!((rx_status = inw(ioaddr + RxStatus)) & 0x8000) &&
 		   (--worklimit >= 0)) {
 		if (rx_status & 0x4000) { /* Error, update stats. */
@@ -1156,8 +1155,8 @@
 
 			skb = dev_alloc_skb(pkt_len+5);
 
-			DEBUG(3, "  Receiving packet size %d status %4.4x.\n",
-				  pkt_len, rx_status);
+			pn_dbg(3, "  Receiving packet size %d status %4.4x.\n",
+			       pkt_len, rx_status);
 			if (skb != NULL) {
 				skb->dev = dev;
 				skb_reserve(skb, 2);
@@ -1169,8 +1168,8 @@
 				lp->stats.rx_packets++;
 				lp->stats.rx_bytes += pkt_len;
 			} else {
-				DEBUG(1, "%s: couldn't allocate a sk_buff of"
-					  " size %d.\n", dev->name, pkt_len);
+				pn_dbg(1, "%s: couldn't allocate a sk_buff of"
+				       " size %d.\n", dev->name, pkt_len);
 				lp->stats.rx_dropped++;
 			}
 		}
@@ -1198,9 +1197,9 @@
 	u16 *data = (u16 *)&rq->ifr_ifru;
 	int phy = lp->phys & 0x1f;
 
-	DEBUG(2, "%s: In ioct(%-.6s, %#4.4x) %4.4x %4.4x %4.4x %4.4x.\n",
-		  dev->name, rq->ifr_ifrn.ifrn_name, cmd,
-		  data[0], data[1], data[2], data[3]);
+	pn_dbg(2, "%s: In ioct(%-.6s, %#4.4x) %4.4x %4.4x %4.4x %4.4x.\n",
+	       dev->name, rq->ifr_ifrn.ifrn_name, cmd,
+	       data[0], data[1], data[2], data[3]);
 
 	switch(cmd) {
 	case SIOCGMIIPHY:		/* Get the address of the PHY in use. */
@@ -1265,7 +1264,7 @@
 	struct el3_private *lp = netdev_priv(dev);
 	dev_link_t *link = &lp->link;
 
-	DEBUG(2, "%s: shutting down ethercard.\n", dev->name);
+	pn_dbg(2, "%s: shutting down ethercard.\n", dev->name);
 	
 	if (DEV_OK(link)) {
 		unsigned long flags;
===== drivers/net/pcmcia/3c589_cs.c 1.31 vs edited =====
--- 1.31/drivers/net/pcmcia/3c589_cs.c	2004-10-20 10:37:15 +02:00
+++ edited/drivers/net/pcmcia/3c589_cs.c	2004-10-26 11:01:10 +02:00
@@ -51,6 +51,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/system.h>
+#include "common.h"
 
 /* To minimize the size of the driver source I only define operating
    constants if they are used several times.  You'll need the manual
@@ -126,23 +127,19 @@
 MODULE_DESCRIPTION("3Com 3c589 series PCMCIA ethernet driver");
 MODULE_LICENSE("GPL");
 
-#define INT_MODULE_PARM(n, v) static int n = v; MODULE_PARM(n, "i")
-
-/* Special hook for setting if_port when module is loaded */
-INT_MODULE_PARM(if_port, 0);
-
 /* Bit map of interrupts to choose from */
-INT_MODULE_PARM(irq_mask, 0xdeb8);
+static int irq_mask = 0xdeb8;
+module_param(irq_mask, int, 0444);
 static int irq_list[4] = { -1 };
-MODULE_PARM(irq_list, "1-4i");
+module_param_array(irq_list, int, NULL, 0444);
+
+/* Maximum events (Rx packets, etc.) to handle at each interrupt. */
+static int if_port; /* = 0 */
+module_param(if_port, int, 0444);
 
-#ifdef PCMCIA_DEBUG
-INT_MODULE_PARM(pc_debug, PCMCIA_DEBUG);
-#define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
-static char *version =
+#ifdef DEBUG
+static char __attribute((unused)) *version =
 DRV_NAME ".c " DRV_VERSION " 2001/10/13 00:08:50 (David Hinds)";
-#else
-#define DEBUG(n, args...)
 #endif
 
 /*====================================================================*/
@@ -190,7 +187,7 @@
     struct net_device *dev;
     int i, ret;
 
-    DEBUG(0, "3c589_attach()\n");
+    pn_dbg(0, "3c589_attach()\n");
     
     /* Create new ethernet device */
     dev = alloc_etherdev(sizeof(struct el3_private));
@@ -268,7 +265,7 @@
     struct net_device *dev = link->priv;
     dev_link_t **linkp;
     
-    DEBUG(0, "3c589_detach(0x%p)\n", link);
+    pn_dbg(0, "3c589_detach(0x%p)\n", link);
     
     /* Locate device structure */
     for (linkp = &dev_list; *linkp; linkp = &(*linkp)->next)
@@ -313,7 +310,7 @@
     ioaddr_t ioaddr;
     char *ram_split[] = {"5:3", "3:1", "1:1", "3:5"};
     
-    DEBUG(0, "3c589_config(0x%p)\n", link);
+    pn_dbg(0, "3c589_config(0x%p)\n", link);
 
     phys_addr = (u16 *)dev->dev_addr;
     tuple.Attributes = 0;
@@ -428,7 +425,7 @@
 
 static void tc589_release(dev_link_t *link)
 {
-    DEBUG(0, "3c589_release(0x%p)\n", link);
+    pn_dbg(0, "3c589_release(0x%p)\n", link);
     
     pcmcia_release_configuration(link->handle);
     pcmcia_release_io(link->handle, &link->io);
@@ -452,7 +449,7 @@
     dev_link_t *link = args->client_data;
     struct net_device *dev = link->priv;
     
-    DEBUG(1, "3c589_event(0x%06x)\n", event);
+    pn_dbg(1, "3c589_event(0x%06x)\n", event);
     
     switch (event) {
     case CS_EVENT_CARD_REMOVAL:
@@ -613,7 +610,7 @@
 	sprintf(info->bus_info, "PCMCIA 0x%lx", dev->base_addr);
 }
 
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
 static u32 netdev_get_msglevel(struct net_device *dev)
 {
 	return pc_debug;
@@ -623,14 +620,14 @@
 {
 	pc_debug = level;
 }
-#endif /* PCMCIA_DEBUG */
+#endif /* DEBUG */
 
 static struct ethtool_ops netdev_ethtool_ops = {
 	.get_drvinfo		= netdev_get_drvinfo,
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
 	.get_msglevel		= netdev_get_msglevel,
 	.set_msglevel		= netdev_set_msglevel,
-#endif /* PCMCIA_DEBUG */
+#endif /* DEBUG */
 };
 
 static int el3_config(struct net_device *dev, struct ifmap *map)
@@ -665,8 +662,8 @@
     lp->media.expires = jiffies + HZ;
     add_timer(&lp->media);
 
-    DEBUG(1, "%s: opened, status %4.4x.\n",
-	  dev->name, inw(dev->base_addr + EL3_STATUS));
+    pn_dbg(1, "%s: opened, status %4.4x.\n",
+	   dev->name, inw(dev->base_addr + EL3_STATUS));
     
     return 0;
 }
@@ -700,8 +697,8 @@
 	if (tx_status & 0x30)
 	    tc589_wait_for_completion(dev, TxReset);
 	if (tx_status & 0x38) {
-	    DEBUG(1, "%s: transmit error: status 0x%02x\n",
-		  dev->name, tx_status);
+	    pn_dbg(1, "%s: transmit error: status 0x%02x\n",
+		   dev->name, tx_status);
 	    outw(TxEnable, ioaddr + EL3_CMD);
 	    lp->stats.tx_aborted_errors++;
 	}
@@ -714,8 +711,8 @@
     ioaddr_t ioaddr = dev->base_addr;
     struct el3_private *priv = netdev_priv(dev);
 
-    DEBUG(3, "%s: el3_start_xmit(length = %ld) called, "
-	  "status %4.4x.\n", dev->name, (long)skb->len,
+    pn_dbg(3, "%s: el3_start_xmit(length = %ld) called, "
+	   "status %4.4x.\n", dev->name, (long)skb->len,
 	  inw(ioaddr + EL3_STATUS));
 
     priv->stats.tx_bytes += skb->len;
@@ -752,14 +749,14 @@
 
     ioaddr = dev->base_addr;
 
-    DEBUG(3, "%s: interrupt, status %4.4x.\n",
-	  dev->name, inw(ioaddr + EL3_STATUS));
+    pn_dbg(3, "%s: interrupt, status %4.4x.\n",
+	   dev->name, inw(ioaddr + EL3_STATUS));
 
     spin_lock(&lp->lock);    
     while ((status = inw(ioaddr + EL3_STATUS)) &
 	(IntLatch | RxComplete | StatsFull)) {
 	if ((status & 0xe000) != 0x2000) {
-	    DEBUG(1, "%s: interrupt from dead card\n", dev->name);
+	    pn_dbg(1, "%s: interrupt from dead card\n", dev->name);
 	    handled = 0;
 	    break;
 	}
@@ -768,7 +765,7 @@
 	    el3_rx(dev);
 	
 	if (status & TxAvailable) {
-	    DEBUG(3, "    TX room bit was handled.\n");
+	    pn_dbg(3, "    TX room bit was handled.\n");
 	    /* There's room in the FIFO for a full-sized packet. */
 	    outw(AckIntr | TxAvailable, ioaddr + EL3_CMD);
 	    netif_wake_queue(dev);
@@ -820,8 +817,8 @@
 
     lp->last_irq = jiffies;
     spin_unlock(&lp->lock);    
-    DEBUG(3, "%s: exiting interrupt, status %4.4x.\n",
-	  dev->name, inw(ioaddr + EL3_STATUS));
+    pn_dbg(3, "%s: exiting interrupt, status %4.4x.\n",
+	   dev->name, inw(ioaddr + EL3_STATUS));
     return IRQ_RETVAL(handled);
 }
 
@@ -933,7 +930,7 @@
     struct el3_private *lp = netdev_priv(dev);
     ioaddr_t ioaddr = dev->base_addr;
 
-    DEBUG(2, "%s: updating the statistics.\n", dev->name);
+    pn_dbg(2, "%s: updating the statistics.\n", dev->name);
     /* Turn off statistics updates while reading. */
     outw(StatsDisable, ioaddr + EL3_CMD);
     /* Switch to the stats window, and read everything. */
@@ -962,8 +959,8 @@
     int worklimit = 32;
     short rx_status;
     
-    DEBUG(3, "%s: in rx_packet(), status %4.4x, rx_status %4.4x.\n",
-	  dev->name, inw(ioaddr+EL3_STATUS), inw(ioaddr+RX_STATUS));
+    pn_dbg(3, "%s: in rx_packet(), status %4.4x, rx_status %4.4x.\n",
+	   dev->name, inw(ioaddr+EL3_STATUS), inw(ioaddr+RX_STATUS));
     while (!((rx_status = inw(ioaddr + RX_STATUS)) & 0x8000) &&
 	   (--worklimit >= 0)) {
 	if (rx_status & 0x4000) { /* Error, update stats. */
@@ -983,8 +980,8 @@
 	    
 	    skb = dev_alloc_skb(pkt_len+5);
 	    
-	    DEBUG(3, "    Receiving packet size %d status %4.4x.\n",
-		  pkt_len, rx_status);
+	    pn_dbg(3, "    Receiving packet size %d status %4.4x.\n",
+		   pkt_len, rx_status);
 	    if (skb != NULL) {
 		skb->dev = dev;
 		skb_reserve(skb, 2);
@@ -996,8 +993,8 @@
 		lp->stats.rx_packets++;
 		lp->stats.rx_bytes += pkt_len;
 	    } else {
-		DEBUG(1, "%s: couldn't allocate a sk_buff of"
-		      " size %d.\n", dev->name, pkt_len);
+		pn_dbg(1, "%s: couldn't allocate a sk_buff of"
+		       " size %d.\n", dev->name, pkt_len);
 		lp->stats.rx_dropped++;
 	    }
 	}
@@ -1030,7 +1027,7 @@
     dev_link_t *link = &lp->link;
     ioaddr_t ioaddr = dev->base_addr;
     
-    DEBUG(1, "%s: shutting down ethercard.\n", dev->name);
+    pn_dbg(1, "%s: shutting down ethercard.\n", dev->name);
 
     if (DEV_OK(link)) {
 	/* Turn off statistics ASAP.  We update lp->stats below. */
===== drivers/net/pcmcia/axnet_cs.c 1.28 vs edited =====
--- 1.28/drivers/net/pcmcia/axnet_cs.c	2004-10-20 10:37:15 +02:00
+++ edited/drivers/net/pcmcia/axnet_cs.c	2004-10-26 11:00:09 +02:00
@@ -49,6 +49,7 @@
 #include <asm/system.h>
 #include <asm/byteorder.h>
 #include <asm/uaccess.h>
+#include "common.h"
 
 #define AXNET_CMD	0x00
 #define AXNET_DATAPORT	0x10	/* NatSemi-defined port window offset. */
@@ -73,20 +74,15 @@
 MODULE_DESCRIPTION("Asix AX88190 PCMCIA ethernet driver");
 MODULE_LICENSE("GPL");
 
-#define INT_MODULE_PARM(n, v) static int n = v; MODULE_PARM(n, "i")
-
 /* Bit map of interrupts to choose from */
-INT_MODULE_PARM(irq_mask,	0xdeb8);
+static int irq_mask = 0xdeb8;
+module_param(irq_mask, int, 0444);
 static int irq_list[4] = { -1 };
-MODULE_PARM(irq_list, "1-4i");
+module_param_array(irq_list, int, NULL, 0444);
 
-#ifdef PCMCIA_DEBUG
-INT_MODULE_PARM(pc_debug, PCMCIA_DEBUG);
-#define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
-static char *version =
+#ifdef DEBUG
+static char __attribute((unused)) *version =
 "axnet_cs.c 1.28 2002/06/29 06:27:37 (David Hinds)";
-#else
-#define DEBUG(n, args...)
 #endif
 
 /*====================================================================*/
@@ -161,7 +157,7 @@
     client_reg_t client_reg;
     int i, ret;
 
-    DEBUG(0, "axnet_attach()\n");
+    pn_dbg(0, "axnet_attach()\n");
 
     dev = alloc_netdev(sizeof(struct ei_device) + sizeof(axnet_dev_t),
 			"eth%d", axdev_setup);
@@ -223,7 +219,7 @@
     struct net_device *dev = link->priv;
     dev_link_t **linkp;
 
-    DEBUG(0, "axnet_detach(0x%p)\n", link);
+    pn_dbg(0, "axnet_detach(0x%p)\n", link);
 
     /* Locate device structure */
     for (linkp = &dev_list; *linkp; linkp = &(*linkp)->next)
@@ -342,11 +338,11 @@
     axnet_dev_t *info = PRIV(dev);
     tuple_t tuple;
     cisparse_t parse;
-    int i, j, last_ret, last_fn;
+    int i, j = 0, last_ret, last_fn;
     u_short buf[64];
     config_info_t conf;
 
-    DEBUG(0, "axnet_config(0x%p)\n", link);
+    pn_dbg(0, "axnet_config(0x%p)\n", link);
 
     tuple.Attributes = 0;
     tuple.TupleData = (cisdata_t *)buf;
@@ -473,7 +469,7 @@
     for (i = 0; i < 6; i++)
 	printk("%02X%s", dev->dev_addr[i], ((i<5) ? ":" : "\n"));
     if (info->phy_id != -1) {
-	DEBUG(0, "  MII transceiver at index %d, status %x.\n", info->phy_id, j);
+	pn_dbg(0, "  MII transceiver at index %d, status %x.\n", info->phy_id, j);
     } else {
 	printk(KERN_NOTICE "  No MII transceivers found!\n");
     }
@@ -497,7 +493,7 @@
 
 static void axnet_release(dev_link_t *link)
 {
-    DEBUG(0, "axnet_release(0x%p)\n", link);
+    pn_dbg(0, "axnet_release(0x%p)\n", link);
 
     pcmcia_release_configuration(link->handle);
     pcmcia_release_io(link->handle, &link->io);
@@ -521,7 +517,7 @@
     dev_link_t *link = args->client_data;
     struct net_device *dev = link->priv;
 
-    DEBUG(2, "axnet_event(0x%06x)\n", event);
+    pn_dbg(2, "axnet_event(0x%06x)\n", event);
 
     switch (event) {
     case CS_EVENT_CARD_REMOVAL:
@@ -625,7 +621,7 @@
     axnet_dev_t *info = PRIV(dev);
     dev_link_t *link = &info->link;
     
-    DEBUG(2, "axnet_open('%s')\n", dev->name);
+    pn_dbg(2, "axnet_open('%s')\n", dev->name);
 
     if (!DEV_OK(link))
 	return -ENODEV;
@@ -651,7 +647,7 @@
     axnet_dev_t *info = PRIV(dev);
     dev_link_t *link = &info->link;
 
-    DEBUG(2, "axnet_close('%s')\n", dev->name);
+    pn_dbg(2, "axnet_close('%s')\n", dev->name);
 
     ax_close(dev);
     free_irq(dev->irq, dev);
@@ -822,7 +818,7 @@
     int xfer_count = count;
     char *buf = skb->data;
 
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
     if ((ei_debug > 4) && (count != 4))
 	printk(KERN_DEBUG "%s: [bi=%d]\n", dev->name, count+4);
 #endif
@@ -843,7 +839,7 @@
 {
     ioaddr_t nic_base = dev->base_addr;
 
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
     if (ei_debug > 4)
 	printk(KERN_DEBUG "%s: [bo=%d]\n", dev->name, count);
 #endif
===== drivers/net/pcmcia/com20020_cs.c 1.21 vs edited =====
--- 1.21/drivers/net/pcmcia/com20020_cs.c	2004-03-08 14:59:50 +01:00
+++ edited/drivers/net/pcmcia/com20020_cs.c	2004-10-26 11:01:45 +02:00
@@ -51,15 +51,11 @@
 
 #include <asm/io.h>
 #include <asm/system.h>
+#include "common.h"
 
 #define VERSION "arcnet: COM20020 PCMCIA support loaded.\n"
 
-#ifdef PCMCIA_DEBUG
-
-static int pc_debug = PCMCIA_DEBUG;
-MODULE_PARM(pc_debug, "i");
-#define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
-
+#ifdef DEBUG
 static void regdump(struct net_device *dev)
 {
     int ioaddr = dev->base_addr;
@@ -90,37 +86,32 @@
     }
     printk("\n");
 }
-
 #else
-
-#define DEBUG(n, args...) do { } while (0)
 static inline void regdump(struct net_device *dev) { }
-
 #endif
 
 
 /*====================================================================*/
 
-/* Parameters that can be set with 'insmod' */
-
-static int node;
-static int timeout = 3;
-static int backplane;
-static int clockp;
-static int clockm;
-
-MODULE_PARM(node, "i");
-MODULE_PARM(timeout, "i");
-MODULE_PARM(backplane, "i");
-MODULE_PARM(clockp, "i");
-MODULE_PARM(clockm, "i");
 
 /* Bit map of interrupts to choose from */
-static u_int irq_mask = 0xdeb8;
+static int irq_mask = 0xdeb8;
+module_param(irq_mask, int, 0444);
 static int irq_list[4] = { -1 };
+module_param_array(irq_list, int, NULL, 0444);
+
+/* Parameters that can be set with 'insmod' */
+static int node; /* = 0 */
+module_param(node, int, 0444);
+static int timeout = 3;
+module_param(timeout, int, 0444);
+static int backplane; /* = 0 */
+module_param(backplane, int, 0444);
+static int clockp; /* = 0 */
+module_param(clockp, int, 0444);
+static int clockm; /* = 0 */
+module_param(clockm, int, 0444);
 
-MODULE_PARM(irq_mask, "i");
-MODULE_PARM(irq_list, "1-4i");
 MODULE_LICENSE("GPL");
 
 /*====================================================================*/
@@ -161,7 +152,7 @@
     int i, ret;
     struct arcnet_local *lp;
     
-    DEBUG(0, "com20020_attach()\n");
+    pn_dbg(0, "com20020_attach()\n");
 
     /* Create new network device */
     link = kmalloc(sizeof(struct dev_link_t), GFP_KERNEL);
@@ -250,9 +241,9 @@
     dev_link_t **linkp;
     struct net_device *dev; 
     
-    DEBUG(1,"detach...\n");
+    pn_dbg(1,"detach...\n");
 
-    DEBUG(0, "com20020_detach(0x%p)\n", link);
+    pn_dbg(0, "com20020_detach(0x%p)\n", link);
 
     /* Locate device structure */
     for (linkp = &dev_list; *linkp; linkp = &(*linkp)->next)
@@ -263,7 +254,7 @@
     dev = info->dev;
 
     if (link->dev) {
-	DEBUG(1,"unregister...\n");
+	pn_dbg(1,"unregister...\n");
 
 	unregister_netdev(dev);
 	    
@@ -282,20 +273,20 @@
         pcmcia_deregister_client(link->handle);
 
     /* Unlink device structure, free bits */
-    DEBUG(1,"unlinking...\n");
+    pn_dbg(1,"unlinking...\n");
     *linkp = link->next;
     if (link->priv)
     {
 	dev = info->dev;
 	if (dev)
 	{
-	    DEBUG(1,"kfree...\n");
+	    pn_dbg(1,"kfree...\n");
 	    free_netdev(dev);
 	}
-	DEBUG(1,"kfree2...\n");
+	pn_dbg(1,"kfree2...\n");
 	kfree(info);
     }
-    DEBUG(1,"kfree3...\n");
+    pn_dbg(1,"kfree3...\n");
     kfree(link);
 
 } /* com20020_detach */
@@ -327,9 +318,9 @@
     info = link->priv;
     dev = info->dev;
 
-    DEBUG(1,"config...\n");
+    pn_dbg(1,"config...\n");
 
-    DEBUG(0, "com20020_config(0x%p)\n", link);
+    pn_dbg(0, "com20020_config(0x%p)\n", link);
 
     tuple.Attributes = 0;
     tuple.TupleData = buf;
@@ -344,7 +335,7 @@
     /* Configure card */
     link->state |= DEV_CONFIG;
 
-    DEBUG(1,"arcnet: baseport1 is %Xh\n", link->io.BasePort1);
+    pn_dbg(1,"arcnet: baseport1 is %Xh\n", link->io.BasePort1);
     i = !CS_SUCCESS;
     if (!link->io.BasePort1)
     {
@@ -361,20 +352,20 @@
     
     if (i != CS_SUCCESS)
     {
-	DEBUG(1,"arcnet: requestIO failed totally!\n");
+	pn_dbg(1,"arcnet: requestIO failed totally!\n");
 	goto failed;
     }
 	
     ioaddr = dev->base_addr = link->io.BasePort1;
-    DEBUG(1,"arcnet: got ioaddr %Xh\n", ioaddr);
+    pn_dbg(1,"arcnet: got ioaddr %Xh\n", ioaddr);
 
-    DEBUG(1,"arcnet: request IRQ %d (%Xh/%Xh)\n",
+    pn_dbg(1,"arcnet: request IRQ %d (%Xh/%Xh)\n",
 	   link->irq.AssignedIRQ,
 	   link->irq.IRQInfo1, link->irq.IRQInfo2);
     i = pcmcia_request_irq(link->handle, &link->irq);
     if (i != CS_SUCCESS)
     {
-	DEBUG(1,"arcnet: requestIRQ failed totally!\n");
+	pn_dbg(1,"arcnet: requestIRQ failed totally!\n");
 	goto failed;
     }
 
@@ -398,21 +389,21 @@
     i = com20020_found(dev, 0);	/* calls register_netdev */
     
     if (i != 0) {
-	DEBUG(1,KERN_NOTICE "com20020_cs: com20020_found() failed\n");
+	pn_dbg(1,KERN_NOTICE "com20020_cs: com20020_found() failed\n");
 	link->dev = NULL;
 	goto failed;
     }
 
     strcpy(info->node.dev_name, dev->name);
 
-    DEBUG(1,KERN_INFO "%s: port %#3lx, irq %d\n",
+    pn_dbg(1,KERN_INFO "%s: port %#3lx, irq %d\n",
            dev->name, dev->base_addr, dev->irq);
     return;
 
 cs_failed:
     cs_error(link->handle, last_fn, last_ret);
 failed:
-    DEBUG(1,"com20020_config failed...\n");
+    pn_dbg(1,"com20020_config failed...\n");
     com20020_release(link);
 } /* com20020_config */
 
@@ -427,9 +418,9 @@
 static void com20020_release(dev_link_t *link)
 {
 
-    DEBUG(1,"release...\n");
+    pn_dbg(1,"release...\n");
 
-    DEBUG(0, "com20020_release(0x%p)\n", link);
+    pn_dbg(0, "com20020_release(0x%p)\n", link);
 
     pcmcia_release_configuration(link->handle);
     pcmcia_release_io(link->handle, &link->io);
@@ -454,7 +445,7 @@
     com20020_dev_t *info = link->priv;
     struct net_device *dev = info->dev;
 
-    DEBUG(1, "com20020_event(0x%06x)\n", event);
+    pn_dbg(1, "com20020_event(0x%06x)\n", event);
     
     switch (event) {
     case CS_EVENT_CARD_REMOVAL:
===== drivers/net/pcmcia/fmvj18x_cs.c 1.33 vs edited =====
--- 1.33/drivers/net/pcmcia/fmvj18x_cs.c	2004-03-08 14:59:50 +01:00
+++ edited/drivers/net/pcmcia/fmvj18x_cs.c	2004-10-26 11:01:56 +02:00
@@ -59,6 +59,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/system.h>
+#include "common.h"
 
 /*====================================================================*/
 
@@ -67,24 +68,20 @@
 MODULE_DESCRIPTION("fmvj18x and compatible PCMCIA ethernet driver");
 MODULE_LICENSE("GPL");
 
-#define INT_MODULE_PARM(n, v) static int n = v; MODULE_PARM(n, "i")
-
 /* Bit map of interrupts to choose from */
-/* This means pick from 15, 14, 12, 11, 10, 9, 7, 5, 4, and 3 */
-INT_MODULE_PARM(irq_mask, 0xdeb8);
+static int irq_mask = 0xdeb8;
+module_param(irq_mask, int, 0444);
 static int irq_list[4] = { -1 };
-MODULE_PARM(irq_list, "1-4i");
+module_param_array(irq_list, int, NULL, 0444);
 
 /* SRAM configuration */
 /* 0:4KB*2 TX buffer   else:8KB*2 TX buffer */
-INT_MODULE_PARM(sram_config, 0);
+static int sram_config; /* = 0 */
+module_param(sram_config, int, 0444);
 
-#ifdef PCMCIA_DEBUG
-INT_MODULE_PARM(pc_debug, PCMCIA_DEBUG);
-#define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
-static char *version = DRV_NAME ".c " DRV_VERSION " 2002/03/23";
-#else
-#define DEBUG(n, args...)
+#ifdef DEBUG
+static char __attribute((unused)) *version =
+DRV_NAME ".c " DRV_VERSION " 2002/03/23";
 #endif
 
 /*====================================================================*/
@@ -250,7 +247,7 @@
     client_reg_t client_reg;
     int i, ret;
     
-    DEBUG(0, "fmvj18x_attach()\n");
+    pn_dbg(0, "fmvj18x_attach()\n");
 
     /* Make up a FMVJ18x specific data structure */
     dev = alloc_etherdev(sizeof(local_info_t));
@@ -324,7 +321,7 @@
     struct net_device *dev = link->priv;
     dev_link_t **linkp;
     
-    DEBUG(0, "fmvj18x_detach(0x%p)\n", link);
+    pn_dbg(0, "fmvj18x_detach(0x%p)\n", link);
     
     /* Locate device structure */
     for (linkp = &dev_list; *linkp; linkp = &(*linkp)->next)
@@ -405,7 +402,7 @@
     char *card_name = "unknown";
     u_char *node_id;
 
-    DEBUG(0, "fmvj18x_config(0x%p)\n", link);
+    pn_dbg(0, "fmvj18x_config(0x%p)\n", link);
 
     /*
        This reads the card's CONFIG tuple to find its configuration
@@ -718,7 +715,7 @@
 static void fmvj18x_release(dev_link_t *link)
 {
 
-    DEBUG(0, "fmvj18x_release(0x%p)\n", link);
+    pn_dbg(0, "fmvj18x_release(0x%p)\n", link);
 
     /* Don't bother checking to see if these succeed or not */
     pcmcia_release_window(link->win);
@@ -737,7 +734,7 @@
     dev_link_t *link = args->client_data;
     struct net_device *dev = link->priv;
 
-    DEBUG(1, "fmvj18x_event(0x%06x)\n", event);
+    pn_dbg(1, "fmvj18x_event(0x%06x)\n", event);
     
     switch (event) {
     case CS_EVENT_CARD_REMOVAL:
@@ -829,8 +826,8 @@
     outb(tx_stat, ioaddr + TX_STATUS);
     outb(rx_stat, ioaddr + RX_STATUS);
     
-    DEBUG(4, "%s: interrupt, rx_status %02x.\n", dev->name, rx_stat);
-    DEBUG(4, "               tx_status %02x.\n", tx_stat);
+    pn_dbg(4, "%s: interrupt, rx_status %02x.\n", dev->name, rx_stat);
+    pn_dbg(4, "               tx_status %02x.\n", tx_stat);
     
     if (rx_stat || (inb(ioaddr + RX_MODE) & F_BUF_EMP) == 0) {
 	/* there is packet(s) in rx buffer */
@@ -850,8 +847,8 @@
 	}
 	netif_wake_queue(dev);
     }
-    DEBUG(4, "%s: exiting interrupt,\n", dev->name);
-    DEBUG(4, "    tx_status %02x, rx_status %02x.\n", tx_stat, rx_stat);
+    pn_dbg(4, "%s: exiting interrupt,\n", dev->name);
+    pn_dbg(4, "    tx_status %02x, rx_status %02x.\n", tx_stat, rx_stat);
 
     outb(D_TX_INTR, ioaddr + TX_INTR);
     outb(D_RX_INTR, ioaddr + RX_INTR);
@@ -916,8 +913,8 @@
 	    return 1;
 	}
 
-	DEBUG(4, "%s: Transmitting a packet of length %lu.\n",
-	      dev->name, (unsigned long)skb->len);
+	pn_dbg(4, "%s: Transmitting a packet of length %lu.\n",
+	       dev->name, (unsigned long)skb->len);
 	lp->stats.tx_bytes += skb->len;
 
 	/* Disable both interrupts. */
@@ -971,7 +968,7 @@
     ioaddr_t ioaddr = dev->base_addr;
     int i;
 
-    DEBUG(4, "fjn_reset(%s) called.\n",dev->name);
+    pn_dbg(4, "fjn_reset(%s) called.\n",dev->name);
 
     /* Reset controller */
     if( sram_config == 0 ) 
@@ -1057,14 +1054,14 @@
     ioaddr_t ioaddr = dev->base_addr;
     int boguscount = 10;	/* 5 -> 10: by agy 19940922 */
 
-    DEBUG(4, "%s: in rx_packet(), rx_status %02x.\n",
-	  dev->name, inb(ioaddr + RX_STATUS));
+    pn_dbg(4, "%s: in rx_packet(), rx_status %02x.\n",
+    	   dev->name, inb(ioaddr + RX_STATUS));
 
     while ((inb(ioaddr + RX_MODE) & F_BUF_EMP) == 0) {
 	u_short status = inw(ioaddr + DATAPORT);
 
-	DEBUG(4, "%s: Rxing packet mode %02x status %04x.\n",
-	      dev->name, inb(ioaddr + RX_MODE), status);
+	pn_dbg(4, "%s: Rxing packet mode %02x status %04x.\n",
+	       dev->name, inb(ioaddr + RX_MODE), status);
 #ifndef final_version
 	if (status == 0) {
 	    outb(F_SKP_PKT, ioaddr + RX_SKIP);
@@ -1104,7 +1101,7 @@
 		 (pkt_len + 1) >> 1);
 	    skb->protocol = eth_type_trans(skb, dev);
 
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
 	    if (pc_debug > 5) {
 		int i;
 		printk(KERN_DEBUG "%s: Rxed packet of length %d: ",
@@ -1138,8 +1135,8 @@
 	}
 
 	if (i > 0)
-	    DEBUG(5, "%s: Exint Rx packet with mode %02x after "
-		  "%d ticks.\n", dev->name, inb(ioaddr + RX_MODE), i);
+	    pn_dbg(5, "%s: Exint Rx packet with mode %02x after "
+		   "%d ticks.\n", dev->name, inb(ioaddr + RX_MODE), i);
     }
 */
 
@@ -1156,7 +1153,7 @@
 	sprintf(info->bus_info, "PCMCIA 0x%lx", dev->base_addr);
 }
 
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
 static u32 netdev_get_msglevel(struct net_device *dev)
 {
 	return pc_debug;
@@ -1166,14 +1163,14 @@
 {
 	pc_debug = level;
 }
-#endif /* PCMCIA_DEBUG */
+#endif /* DEBUG */
 
 static struct ethtool_ops netdev_ethtool_ops = {
 	.get_drvinfo		= netdev_get_drvinfo,
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
 	.get_msglevel		= netdev_get_msglevel,
 	.set_msglevel		= netdev_set_msglevel,
-#endif /* PCMCIA_DEBUG */
+#endif /* DEBUG */
 };
 
 static int fjn_config(struct net_device *dev, struct ifmap *map){
@@ -1185,7 +1182,7 @@
     struct local_info_t *lp = netdev_priv(dev);
     dev_link_t *link = &lp->link;
 
-    DEBUG(4, "fjn_open('%s').\n", dev->name);
+    pn_dbg(4, "fjn_open('%s').\n", dev->name);
 
     if (!DEV_OK(link))
 	return -ENODEV;
@@ -1211,7 +1208,7 @@
     dev_link_t *link = &lp->link;
     ioaddr_t ioaddr = dev->base_addr;
 
-    DEBUG(4, "fjn_close('%s').\n", dev->name);
+    pn_dbg(4, "fjn_close('%s').\n", dev->name);
 
     lp->open_time = 0;
     netif_stop_queue(dev);
===== drivers/net/pcmcia/ibmtr_cs.c 1.27 vs edited =====
--- 1.27/drivers/net/pcmcia/ibmtr_cs.c	2004-03-08 14:59:50 +01:00
+++ edited/drivers/net/pcmcia/ibmtr_cs.c	2004-10-26 11:02:09 +02:00
@@ -66,20 +66,16 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/system.h>
+#include "common.h"
 
 #define PCMCIA
 #include "../tokenring/ibmtr.c"
 
-#ifdef PCMCIA_DEBUG
-static int pc_debug = PCMCIA_DEBUG;
-MODULE_PARM(pc_debug, "i");
-#define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
-static char *version =
+#ifdef DEBUG
+static char __attribute((unused)) *version =
 "ibmtr_cs.c 1.10   1996/01/06 05:19:00 (Steve Kipisz)\n"
 "           2.2.7  1999/05/03 12:00:00 (Mike Phillips)\n"
 "           2.4.2  2001/30/28 Midnight (Burt Silverman)\n";
-#else
-#define DEBUG(n, args...)
 #endif
 
 /*====================================================================*/
@@ -87,27 +83,27 @@
 /* Parameters that can be set with 'insmod' */
 
 /* Bit map of interrupts to choose from */
-static u_int irq_mask = 0xdeb8;
+static int irq_mask = 0xdeb8;
+module_param(irq_mask, int, 0444);
 static int irq_list[4] = { -1 };
+module_param_array(irq_list, int, NULL, 0444);
 
 /* MMIO base address */
-static u_long mmiobase = 0xce000;
+static int mmiobase = 0xce000;
+module_param(mmiobase, int, 0444);
 
 /* SRAM base address */
-static u_long srambase = 0xd0000;
+static int srambase = 0xd0000;
+module_param(srambase, int, 0444);
 
 /* SRAM size 8,16,32,64 */
-static u_long sramsize = 64;
+static int sramsize = 64;
+module_param(sramsize, int, 0444);
 
 /* Ringspeed 4,16 */
 static int ringspeed = 16;
+module_param(ringspeed, int, 0444);
 
-MODULE_PARM(irq_mask, "i");
-MODULE_PARM(irq_list, "1-4i");
-MODULE_PARM(mmiobase, "i");
-MODULE_PARM(srambase, "i");
-MODULE_PARM(sramsize, "i");
-MODULE_PARM(ringspeed, "i");
 MODULE_LICENSE("GPL");
 
 /*====================================================================*/
@@ -164,7 +160,7 @@
     client_reg_t client_reg;
     int i, ret;
     
-    DEBUG(0, "ibmtr_attach()\n");
+    pn_dbg(0, "ibmtr_attach()\n");
 
     /* Create new token-ring device */
     info = kmalloc(sizeof(*info), GFP_KERNEL); 
@@ -242,7 +238,7 @@
     dev_link_t **linkp;
     struct net_device *dev;
 
-    DEBUG(0, "ibmtr_detach(0x%p)\n", link);
+    pn_dbg(0, "ibmtr_detach(0x%p)\n", link);
 
     /* Locate device structure */
     for (linkp = &dev_list; *linkp; linkp = &(*linkp)->next)
@@ -295,7 +291,7 @@
     int i, last_ret, last_fn;
     u_char buf[64];
 
-    DEBUG(0, "ibmtr_config(0x%p)\n", link);
+    pn_dbg(0, "ibmtr_config(0x%p)\n", link);
 
     tuple.Attributes = 0;
     tuple.TupleData = buf;
@@ -405,7 +401,7 @@
     ibmtr_dev_t *info = link->priv;
     struct net_device *dev = info->dev;
 
-    DEBUG(0, "ibmtr_release(0x%p)\n", link);
+    pn_dbg(0, "ibmtr_release(0x%p)\n", link);
 
     pcmcia_release_configuration(link->handle);
     pcmcia_release_io(link->handle, &link->io);
@@ -436,7 +432,7 @@
     ibmtr_dev_t *info = link->priv;
     struct net_device *dev = info->dev;
 
-    DEBUG(1, "ibmtr_event(0x%06x)\n", event);
+    pn_dbg(1, "ibmtr_event(0x%06x)\n", event);
 
     switch (event) {
     case CS_EVENT_CARD_REMOVAL:
===== drivers/net/pcmcia/nmclan_cs.c 1.30 vs edited =====
--- 1.30/drivers/net/pcmcia/nmclan_cs.c	2004-10-20 10:37:15 +02:00
+++ edited/drivers/net/pcmcia/nmclan_cs.c	2004-10-26 11:02:17 +02:00
@@ -156,6 +156,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/system.h>
+#include "common.h"
 
 /* ----------------------------------------------------------------------------
 Defines
@@ -382,10 +383,10 @@
 Private Global Variables
 ---------------------------------------------------------------------------- */
 
-#ifdef PCMCIA_DEBUG
-static char rcsid[] =
+#ifdef DEBUG
+static char __attribute((unused)) rcsid[] =
 "nmclan_cs.c,v 0.16 1995/07/01 06:42:17 rpao Exp rpao";
-static char *version =
+static char __attribute((unused)) *version =
 DRV_NAME " " DRV_VERSION " (Roger C. Pao)";
 #endif
 
@@ -405,22 +406,15 @@
 MODULE_DESCRIPTION("New Media PCMCIA ethernet driver");
 MODULE_LICENSE("GPL");
 
-#define INT_MODULE_PARM(n, v) static int n = v; MODULE_PARM(n, "i")
-
+/* Bit map of interrupts to choose from */
+static int irq_mask = 0xdeb8;
+module_param(irq_mask, int, 0444);
 static int irq_list[4] = { -1 };
-MODULE_PARM(irq_list, "1-4i");
+module_param_array(irq_list, int, NULL, 0444);
 
 /* 0=auto, 1=10baseT, 2 = 10base2, default=auto */
-INT_MODULE_PARM(if_port, 0);
-/* Bit map of interrupts to choose from */
-INT_MODULE_PARM(irq_mask, 0xdeb8);
-
-#ifdef PCMCIA_DEBUG
-INT_MODULE_PARM(pc_debug, PCMCIA_DEBUG);
-#define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
-#else
-#define DEBUG(n, args...)
-#endif
+static int if_port; /* = 0 */
+module_param(if_port, int, 0444);
 
 /* ----------------------------------------------------------------------------
 Function Prototypes
@@ -463,8 +457,8 @@
     client_reg_t client_reg;
     int i, ret;
 
-    DEBUG(0, "nmclan_attach()\n");
-    DEBUG(1, "%s\n", rcsid);
+    pn_dbg(0, "nmclan_attach()\n");
+    pn_dbg(1, "%s\n", rcsid);
 
     /* Create new ethernet device */
     dev = alloc_etherdev(sizeof(mace_private));
@@ -543,7 +537,7 @@
     struct net_device *dev = link->priv;
     dev_link_t **linkp;
 
-    DEBUG(0, "nmclan_detach(0x%p)\n", link);
+    pn_dbg(0, "nmclan_detach(0x%p)\n", link);
 
     /* Locate device structure */
     for (linkp = &dev_list; *linkp; linkp = &(*linkp)->next)
@@ -715,7 +709,7 @@
   int i, last_ret, last_fn;
   ioaddr_t ioaddr;
 
-  DEBUG(0, "nmclan_config(0x%p)\n", link);
+  pn_dbg(0, "nmclan_config(0x%p)\n", link);
 
   tuple.Attributes = 0;
   tuple.TupleData = buf;
@@ -754,8 +748,8 @@
     sig[0] = mace_read(lp, ioaddr, MACE_CHIPIDL);
     sig[1] = mace_read(lp, ioaddr, MACE_CHIPIDH);
     if ((sig[0] == 0x40) && ((sig[1] & 0x0F) == 0x09)) {
-      DEBUG(0, "nmclan_cs configured: mace id=%x %x\n",
-	    sig[0], sig[1]);
+      pn_dbg(0, "nmclan_cs configured: mace id=%x %x\n",
+	     sig[0], sig[1]);
     } else {
       printk(KERN_NOTICE "nmclan_cs: mace id not found: %x %x should"
 	     " be 0x40 0x?9\n", sig[0], sig[1]);
@@ -808,7 +802,7 @@
 static void nmclan_release(dev_link_t *link)
 {
 
-  DEBUG(0, "nmclan_release(0x%p)\n", link);
+  pn_dbg(0, "nmclan_release(0x%p)\n", link);
 
   pcmcia_release_configuration(link->handle);
   pcmcia_release_io(link->handle, &link->io);
@@ -830,7 +824,7 @@
   dev_link_t *link = args->client_data;
   struct net_device *dev = link->priv;
 
-  DEBUG(1, "nmclan_event(0x%06x)\n", event);
+  pn_dbg(1, "nmclan_event(0x%06x)\n", event);
 
   switch (event) {
     case CS_EVENT_CARD_REMOVAL:
@@ -895,8 +889,8 @@
   /* Reset Xilinx */
   reg.Action = CS_WRITE;
   reg.Offset = CISREG_COR;
-  DEBUG(1, "nmclan_reset: OrigCorValue=0x%lX, resetting...\n",
-	OrigCorValue);
+  pn_dbg(1, "nmclan_reset: OrigCorValue=0x%lX, resetting...\n",
+	 OrigCorValue);
   reg.Value = COR_SOFT_RESET;
   pcmcia_access_configuration_register(link->handle, &reg);
   /* Need to wait for 20 ms for PCMCIA to finish reset. */
@@ -972,7 +966,7 @@
   mace_private *lp = netdev_priv(dev);
   dev_link_t *link = &lp->link;
 
-  DEBUG(2, "%s: shutting down ethercard.\n", dev->name);
+  pn_dbg(2, "%s: shutting down ethercard.\n", dev->name);
 
   /* Mask off all interrupts from the MACE chip. */
   outb(0xFF, ioaddr + AM2150_MACE_BASE + MACE_IMR);
@@ -991,7 +985,7 @@
 	sprintf(info->bus_info, "PCMCIA 0x%lx", dev->base_addr);
 }
 
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
 static u32 netdev_get_msglevel(struct net_device *dev)
 {
 	return pc_debug;
@@ -1001,14 +995,14 @@
 {
 	pc_debug = level;
 }
-#endif /* PCMCIA_DEBUG */
+#endif /* DEBUG */
 
 static struct ethtool_ops netdev_ethtool_ops = {
 	.get_drvinfo		= netdev_get_drvinfo,
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
 	.get_msglevel		= netdev_get_msglevel,
 	.set_msglevel		= netdev_set_msglevel,
-#endif /* PCMCIA_DEBUG */
+#endif /* DEBUG */
 };
 
 /* ----------------------------------------------------------------------------
@@ -1045,8 +1039,8 @@
 
   netif_stop_queue(dev);
 
-  DEBUG(3, "%s: mace_start_xmit(length = %ld) called.\n",
-	dev->name, (long)skb->len);
+  pn_dbg(3, "%s: mace_start_xmit(length = %ld) called.\n",
+	 dev->name, (long)skb->len);
 
 #if (!TX_INTERRUPTABLE)
   /* Disable MACE TX interrupts. */
@@ -1107,8 +1101,7 @@
   int IntrCnt = MACE_MAX_IR_ITERATIONS;
 
   if (dev == NULL) {
-    DEBUG(2, "mace_interrupt(): irq 0x%X for unknown device.\n",
-	  irq);
+    pn_dbg(2, "mace_interrupt(): irq 0x%X for unknown device.\n", irq);
     return IRQ_NONE;
   }
 
@@ -1128,7 +1121,7 @@
   }
 
   if (!netif_device_present(dev)) {
-    DEBUG(2, "%s: interrupt from dead card\n", dev->name);
+    pn_dbg(2, "%s: interrupt from dead card\n", dev->name);
     return IRQ_NONE;
   }
 
@@ -1136,7 +1129,7 @@
     /* WARNING: MACE_IR is a READ/CLEAR port! */
     status = inb(ioaddr + AM2150_MACE_BASE + MACE_IR);
 
-    DEBUG(3, "mace_interrupt: irq 0x%X status 0x%X.\n", irq, status);
+    pn_dbg(3, "mace_interrupt: irq 0x%X status 0x%X.\n", irq, status);
 
     if (status & MACE_IR_RCVINT) {
       mace_rx(dev, MACE_MAX_RX_ITERATIONS);
@@ -1255,8 +1248,8 @@
   ) {
     rx_status = inw(ioaddr + AM2150_RCV);
 
-    DEBUG(3, "%s: in mace_rx(), framecnt 0x%X, rx_status"
-	  " 0x%X.\n", dev->name, rx_framecnt, rx_status);
+    pn_dbg(3, "%s: in mace_rx(), framecnt 0x%X, rx_status"
+    	   " 0x%X.\n", dev->name, rx_framecnt, rx_status);
 
     if (rx_status & MACE_RCVFS_RCVSTS) { /* Error, update stats. */
       lp->linux_stats.rx_errors++;
@@ -1282,8 +1275,8 @@
       lp->mace_stats.rfs_rcvcc += inb(ioaddr + AM2150_RCV);
         /* rcv collision count */
 
-      DEBUG(3, "    receiving packet size 0x%X rx_status"
-	    " 0x%X.\n", pkt_len, rx_status);
+      pn_dbg(3, "    receiving packet size 0x%X rx_status"
+	     " 0x%X.\n", pkt_len, rx_status);
 
       skb = dev_alloc_skb(pkt_len+2);
 
@@ -1304,8 +1297,8 @@
 	outb(0xFF, ioaddr + AM2150_RCV_NEXT); /* skip to next frame */
 	continue;
       } else {
-	DEBUG(1, "%s: couldn't allocate a sk_buff of size"
-	      " %d.\n", dev->name, pkt_len);
+	pn_dbg(1, "%s: couldn't allocate a sk_buff of size"
+	       " %d.\n", dev->name, pkt_len);
 	lp->linux_stats.rx_dropped++;
       }
     }
@@ -1320,29 +1313,29 @@
 ---------------------------------------------------------------------------- */
 static void pr_linux_stats(struct net_device_stats *pstats)
 {
-  DEBUG(2, "pr_linux_stats\n");
-  DEBUG(2, " rx_packets=%-7ld        tx_packets=%ld\n",
-	(long)pstats->rx_packets, (long)pstats->tx_packets);
-  DEBUG(2, " rx_errors=%-7ld         tx_errors=%ld\n",
-	(long)pstats->rx_errors, (long)pstats->tx_errors);
-  DEBUG(2, " rx_dropped=%-7ld        tx_dropped=%ld\n",
-	(long)pstats->rx_dropped, (long)pstats->tx_dropped);
-  DEBUG(2, " multicast=%-7ld         collisions=%ld\n",
-	(long)pstats->multicast, (long)pstats->collisions);
-
-  DEBUG(2, " rx_length_errors=%-7ld  rx_over_errors=%ld\n",
-	(long)pstats->rx_length_errors, (long)pstats->rx_over_errors);
-  DEBUG(2, " rx_crc_errors=%-7ld     rx_frame_errors=%ld\n",
-	(long)pstats->rx_crc_errors, (long)pstats->rx_frame_errors);
-  DEBUG(2, " rx_fifo_errors=%-7ld    rx_missed_errors=%ld\n",
-	(long)pstats->rx_fifo_errors, (long)pstats->rx_missed_errors);
-
-  DEBUG(2, " tx_aborted_errors=%-7ld tx_carrier_errors=%ld\n",
-	(long)pstats->tx_aborted_errors, (long)pstats->tx_carrier_errors);
-  DEBUG(2, " tx_fifo_errors=%-7ld    tx_heartbeat_errors=%ld\n",
-	(long)pstats->tx_fifo_errors, (long)pstats->tx_heartbeat_errors);
-  DEBUG(2, " tx_window_errors=%ld\n",
-	(long)pstats->tx_window_errors);
+  pn_dbg(2, "pr_linux_stats\n");
+  pn_dbg(2, " rx_packets=%-7ld        tx_packets=%ld\n",
+	 (long)pstats->rx_packets, (long)pstats->tx_packets);
+  pn_dbg(2, " rx_errors=%-7ld         tx_errors=%ld\n",
+	 (long)pstats->rx_errors, (long)pstats->tx_errors);
+  pn_dbg(2, " rx_dropped=%-7ld        tx_dropped=%ld\n",
+	 (long)pstats->rx_dropped, (long)pstats->tx_dropped);
+  pn_dbg(2, " multicast=%-7ld         collisions=%ld\n",
+	 (long)pstats->multicast, (long)pstats->collisions);
+
+  pn_dbg(2, " rx_length_errors=%-7ld  rx_over_errors=%ld\n",
+	 (long)pstats->rx_length_errors, (long)pstats->rx_over_errors);
+  pn_dbg(2, " rx_crc_errors=%-7ld     rx_frame_errors=%ld\n",
+	 (long)pstats->rx_crc_errors, (long)pstats->rx_frame_errors);
+  pn_dbg(2, " rx_fifo_errors=%-7ld    rx_missed_errors=%ld\n",
+	 (long)pstats->rx_fifo_errors, (long)pstats->rx_missed_errors);
+
+  pn_dbg(2, " tx_aborted_errors=%-7ld tx_carrier_errors=%ld\n",
+	 (long)pstats->tx_aborted_errors, (long)pstats->tx_carrier_errors);
+  pn_dbg(2, " tx_fifo_errors=%-7ld    tx_heartbeat_errors=%ld\n",
+	 (long)pstats->tx_fifo_errors, (long)pstats->tx_heartbeat_errors);
+  pn_dbg(2, " tx_window_errors=%ld\n",
+	 (long)pstats->tx_window_errors);
 } /* pr_linux_stats */
 
 /* ----------------------------------------------------------------------------
@@ -1350,48 +1343,48 @@
 ---------------------------------------------------------------------------- */
 static void pr_mace_stats(mace_statistics *pstats)
 {
-  DEBUG(2, "pr_mace_stats\n");
+  pn_dbg(2, "pr_mace_stats\n");
 
-  DEBUG(2, " xmtsv=%-7d             uflo=%d\n",
-	pstats->xmtsv, pstats->uflo);
-  DEBUG(2, " lcol=%-7d              more=%d\n",
-	pstats->lcol, pstats->more);
-  DEBUG(2, " one=%-7d               defer=%d\n",
-	pstats->one, pstats->defer);
-  DEBUG(2, " lcar=%-7d              rtry=%d\n",
-	pstats->lcar, pstats->rtry);
+  pn_dbg(2, " xmtsv=%-7d             uflo=%d\n",
+	 pstats->xmtsv, pstats->uflo);
+  pn_dbg(2, " lcol=%-7d              more=%d\n",
+	 pstats->lcol, pstats->more);
+  pn_dbg(2, " one=%-7d               defer=%d\n",
+	 pstats->one, pstats->defer);
+  pn_dbg(2, " lcar=%-7d              rtry=%d\n",
+	 pstats->lcar, pstats->rtry);
 
   /* MACE_XMTRC */
-  DEBUG(2, " exdef=%-7d             xmtrc=%d\n",
-	pstats->exdef, pstats->xmtrc);
+  pn_dbg(2, " exdef=%-7d             xmtrc=%d\n",
+	 pstats->exdef, pstats->xmtrc);
 
   /* RFS1--Receive Status (RCVSTS) */
-  DEBUG(2, " oflo=%-7d              clsn=%d\n",
-	pstats->oflo, pstats->clsn);
-  DEBUG(2, " fram=%-7d              fcs=%d\n",
-	pstats->fram, pstats->fcs);
+  pn_dbg(2, " oflo=%-7d              clsn=%d\n",
+	 pstats->oflo, pstats->clsn);
+  pn_dbg(2, " fram=%-7d              fcs=%d\n",
+	 pstats->fram, pstats->fcs);
 
   /* RFS2--Runt Packet Count (RNTPC) */
   /* RFS3--Receive Collision Count (RCVCC) */
-  DEBUG(2, " rfs_rntpc=%-7d         rfs_rcvcc=%d\n",
-	pstats->rfs_rntpc, pstats->rfs_rcvcc);
+  pn_dbg(2, " rfs_rntpc=%-7d         rfs_rcvcc=%d\n",
+	 pstats->rfs_rntpc, pstats->rfs_rcvcc);
 
   /* MACE_IR */
-  DEBUG(2, " jab=%-7d               babl=%d\n",
-	pstats->jab, pstats->babl);
-  DEBUG(2, " cerr=%-7d              rcvcco=%d\n",
-	pstats->cerr, pstats->rcvcco);
-  DEBUG(2, " rntpco=%-7d            mpco=%d\n",
-	pstats->rntpco, pstats->mpco);
+  pn_dbg(2, " jab=%-7d               babl=%d\n",
+	 pstats->jab, pstats->babl);
+  pn_dbg(2, " cerr=%-7d              rcvcco=%d\n",
+	 pstats->cerr, pstats->rcvcco);
+  pn_dbg(2, " rntpco=%-7d            mpco=%d\n",
+	 pstats->rntpco, pstats->mpco);
 
   /* MACE_MPC */
-  DEBUG(2, " mpc=%d\n", pstats->mpc);
+  pn_dbg(2, " mpc=%d\n", pstats->mpc);
 
   /* MACE_RNTPC */
-  DEBUG(2, " rntpc=%d\n", pstats->rntpc);
+  pn_dbg(2, " rntpc=%d\n", pstats->rntpc);
 
   /* MACE_RCVCC */
-  DEBUG(2, " rcvcc=%d\n", pstats->rcvcc);
+  pn_dbg(2, " rcvcc=%d\n", pstats->rcvcc);
 
 } /* pr_mace_stats */
 
@@ -1460,7 +1453,7 @@
 
   update_stats(dev->base_addr, dev);
 
-  DEBUG(1, "%s: updating the statistics.\n", dev->name);
+  pn_dbg(1, "%s: updating the statistics.\n", dev->name);
   pr_linux_stats(&lp->linux_stats);
   pr_mace_stats(&lp->mace_stats);
 
@@ -1526,7 +1519,7 @@
   byte = hashcode >> 3;
   ladrf[byte] |= (1 << (hashcode & 7));
 
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
   if (pc_debug > 2) {
     printk(KERN_DEBUG "    adr =");
     for (i = 0; i < 6; i++)
@@ -1557,12 +1550,12 @@
   ioaddr_t ioaddr = dev->base_addr;
   int i;
 
-  DEBUG(2, "%s: restoring Rx mode to %d addresses.\n",
-	dev->name, num_addrs);
+  pn_dbg(2, "%s: restoring Rx mode to %d addresses.\n",
+	 dev->name, num_addrs);
 
   if (num_addrs > 0) {
 
-    DEBUG(1, "Attempt to restore multicast list detected.\n");
+    pn_dbg(1, "Attempt to restore multicast list detected.\n");
 
     mace_write(lp, ioaddr, MACE_IAC, MACE_IAC_ADDRCHG | MACE_IAC_LOGADDR);
     /* Poll ADDRCHG bit */
@@ -1613,13 +1606,13 @@
   int i;
   struct dev_mc_list *dmi = dev->mc_list;
 
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
   if (pc_debug > 1) {
     static int old;
     if (dev->mc_count != old) {
       old = dev->mc_count;
-      DEBUG(0, "%s: setting Rx mode to %d addresses.\n",
-	    dev->name, old);
+      pn_dbg(0, "%s: setting Rx mode to %d addresses.\n",
+	     dev->name, old);
     }
   }
 #endif
@@ -1649,8 +1642,8 @@
   ioaddr_t ioaddr = dev->base_addr;
   mace_private *lp = netdev_priv(dev);
 
-  DEBUG(2, "%s: restoring Rx mode to %d addresses.\n", dev->name,
-	lp->multicast_num_addrs);
+  pn_dbg(2, "%s: restoring Rx mode to %d addresses.\n", dev->name,
+	 lp->multicast_num_addrs);
 
   if (dev->flags & IFF_PROMISC) {
     /* Promiscuous mode: receive all packets */
@@ -1669,13 +1662,13 @@
 {
   mace_private *lp = netdev_priv(dev);
 
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
   if (pc_debug > 1) {
     static int old;
     if (dev->mc_count != old) {
       old = dev->mc_count;
-      DEBUG(0, "%s: setting Rx mode to %d addresses.\n",
-	    dev->name, old);
+      pn_dbg(0, "%s: setting Rx mode to %d addresses.\n",
+	     dev->name, old);
     }
   }
 #endif
===== drivers/net/pcmcia/pcnet_cs.c 1.34 vs edited =====
--- 1.34/drivers/net/pcmcia/pcnet_cs.c	2004-03-19 12:18:03 +01:00
+++ edited/drivers/net/pcmcia/pcnet_cs.c	2004-10-26 11:03:43 +02:00
@@ -52,6 +52,7 @@
 #include <asm/system.h>
 #include <asm/byteorder.h>
 #include <asm/uaccess.h>
+#include "common.h"
 
 #define PCNET_CMD	0x00
 #define PCNET_DATAPORT	0x10	/* NatSemi-defined port window offset. */
@@ -69,14 +70,9 @@
 
 static char *if_names[] = { "auto", "10baseT", "10base2"};
 
-#ifdef PCMCIA_DEBUG
-static int pc_debug = PCMCIA_DEBUG;
-MODULE_PARM(pc_debug, "i");
-#define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
-static char *version =
+#ifdef DEBUG
+static char __attribute((unused)) *version =
 "pcnet_cs.c 1.153 2003/11/09 18:53:09 (David Hinds)";
-#else
-#define DEBUG(n, args...)
 #endif
 
 /*====================================================================*/
@@ -87,24 +83,43 @@
 MODULE_DESCRIPTION("NE2000 compatible PCMCIA ethernet driver");
 MODULE_LICENSE("GPL");
 
-#define INT_MODULE_PARM(n, v) static int n = v; MODULE_PARM(n, "i")
-
 /* Bit map of interrupts to choose from */
-INT_MODULE_PARM(irq_mask,	0xdeb8);
+static int irq_mask = 0xdeb8;
+module_param(irq_mask, int, 0444);
 static int irq_list[4] = { -1 };
-MODULE_PARM(irq_list, "1-4i");
+module_param_array(irq_list, int, NULL, 0444);
 
-INT_MODULE_PARM(if_port,	1);	/* Transceiver type */
-INT_MODULE_PARM(use_big_buf,	1);	/* use 64K packet buffer? */
-INT_MODULE_PARM(mem_speed,	0);	/* shared mem speed, in ns */
-INT_MODULE_PARM(delay_output,	0);	/* pause after xmit? */
-INT_MODULE_PARM(delay_time,	4);	/* in usec */
-INT_MODULE_PARM(use_shmem,	-1);	/* use shared memory? */
-INT_MODULE_PARM(full_duplex,	0);	/* full duplex? */
+/* Transceiver type */
+static int if_port = 1;
+module_param(if_port, int, 0444);
+
+/* use 64K packet buffer? */
+static int use_big_buf = 1;
+module_param(use_big_buf, int, 0444);
+
+/* shared mem speed, in ns */
+static int mem_speed; /* = 0 */
+module_param(mem_speed, int, 0444);
+
+/* pause after xmit? */
+static int delay_output; /* = 0 */
+module_param(delay_output, int, 0444);
+
+/* in usec */
+static int delay_time = 4;
+module_param(delay_time, int, 0444);
+
+/* use shared memory? */
+static int use_shmem = -1;
+module_param(use_shmem, int, 0444);
+
+/* full duplex ? */
+static int full_duplex; /* = 0 */
+module_param(full_duplex, int, 0444);
 
 /* Ugh!  Let the user hardwire the hardware address for queer cards */
 static int hw_addr[6] = { 0, /* ... */ };
-MODULE_PARM(hw_addr, "6i");
+module_param_array(hw_addr, int, NULL, 0444);
 
 /*====================================================================*/
 
@@ -258,7 +273,7 @@
     client_reg_t client_reg;
     int i, ret;
 
-    DEBUG(0, "pcnet_attach()\n");
+    pn_dbg(0, "pcnet_attach()\n");
 
     /* Create new ethernet device */
     dev = __alloc_ei_netdev(sizeof(pcnet_dev_t));
@@ -318,7 +333,7 @@
     struct net_device *dev = link->priv;
     dev_link_t **linkp;
 
-    DEBUG(0, "pcnet_detach(0x%p)\n", link);
+    pn_dbg(0, "pcnet_detach(0x%p)\n", link);
 
     /* Locate device structure */
     for (linkp = &dev_list; *linkp; linkp = &(*linkp)->next)
@@ -575,7 +590,7 @@
     config_info_t conf;
     hw_info_t *hw_info;
 
-    DEBUG(0, "pcnet_config(0x%p)\n", link);
+    pn_dbg(0, "pcnet_config(0x%p)\n", link);
 
     tuple.Attributes = 0;
     tuple.TupleData = (cisdata_t *)buf;
@@ -774,7 +789,7 @@
 {
     pcnet_dev_t *info = PRIV(link->priv);
 
-    DEBUG(0, "pcnet_release(0x%p)\n", link);
+    pn_dbg(0, "pcnet_release(0x%p)\n", link);
 
     if (info->flags & USE_SHMEM) {
 	iounmap(info->base);
@@ -802,7 +817,7 @@
     dev_link_t *link = args->client_data;
     struct net_device *dev = link->priv;
 
-    DEBUG(2, "pcnet_event(0x%06x)\n", event);
+    pn_dbg(2, "pcnet_event(0x%06x)\n", event);
 
     switch (event) {
     case CS_EVENT_CARD_REMOVAL:
@@ -1056,7 +1071,7 @@
 	phyid = tmp << 16;
 	phyid |= mdio_read(mii_addr, i, MII_PHYID_REG2);
 	phyid &= MII_PHYID_REV_MASK;
-	DEBUG(0, "%s: MII at %d is 0x%08x\n", dev->name, i, phyid);
+	pn_dbg(0, "%s: MII at %d is 0x%08x\n", dev->name, i, phyid);
 	if (phyid == AM79C9XX_HOME_PHY) {
 	    info->pna_phy = i;
 	} else if (phyid != AM79C9XX_ETH_PHY) {
@@ -1070,7 +1085,7 @@
     pcnet_dev_t *info = PRIV(dev);
     dev_link_t *link = &info->link;
     
-    DEBUG(2, "pcnet_open('%s')\n", dev->name);
+    pn_dbg(2, "pcnet_open('%s')\n", dev->name);
 
     if (!DEV_OK(link))
 	return -ENODEV;
@@ -1098,7 +1113,7 @@
     pcnet_dev_t *info = PRIV(dev);
     dev_link_t *link = &info->link;
 
-    DEBUG(2, "pcnet_close('%s')\n", dev->name);
+    pn_dbg(2, "pcnet_close('%s')\n", dev->name);
 
     ei_close(dev);
     free_irq(dev->irq, dev);
@@ -1338,7 +1353,7 @@
     int xfer_count = count;
     char *buf = skb->data;
 
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
     if ((ei_debug > 4) && (count != 4))
 	printk(KERN_DEBUG "%s: [bi=%d]\n", dev->name, count+4);
 #endif
@@ -1362,7 +1377,7 @@
 
     /* This was for the ALPHA version only, but enough people have
        encountering problems that it is still here. */
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
     if (ei_debug > 4) {		/* DMA termination address check... */
 	int addr, tries = 20;
 	do {
@@ -1391,12 +1406,12 @@
 {
     ioaddr_t nic_base = dev->base_addr;
     pcnet_dev_t *info = PRIV(dev);
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
     int retries = 0;
 #endif
     u_long dma_start;
 
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
     if (ei_debug > 4)
 	printk(KERN_DEBUG "%s: [bo=%d]\n", dev->name, count);
 #endif
@@ -1416,7 +1431,7 @@
     /* We should already be in page 0, but to be safe... */
     outb_p(E8390_PAGE0+E8390_START+E8390_NODMA, nic_base+PCNET_CMD);
 
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
   retry:
 #endif
 
@@ -1433,7 +1448,7 @@
 
     dma_start = jiffies;
 
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
     /* This was for the ALPHA version only, but enough people have
        encountering problems that it is still here. */
     if (ei_debug > 4) {	/* DMA termination address check... */
@@ -1657,7 +1672,7 @@
 
 static void __exit exit_pcnet_cs(void)
 {
-    DEBUG(0, "pcnet_cs: unloading\n");
+    pn_dbg(0, "pcnet_cs: unloading\n");
     pcmcia_unregister_driver(&pcnet_driver);
     while (dev_list != NULL)
 	pcnet_detach(dev_list);
===== drivers/net/pcmcia/smc91c92_cs.c 1.35 vs edited =====
--- 1.35/drivers/net/pcmcia/smc91c92_cs.c	2004-08-30 01:19:51 +02:00
+++ edited/drivers/net/pcmcia/smc91c92_cs.c	2004-10-26 11:02:53 +02:00
@@ -53,6 +53,7 @@
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
+#include "common.h"
 
 /* Ositech Seven of Diamonds firmware */
 #include "ositech.h"
@@ -66,7 +67,11 @@
 MODULE_DESCRIPTION("SMC 91c92 series PCMCIA ethernet driver");
 MODULE_LICENSE("GPL");
 
-#define INT_MODULE_PARM(n, v) static int n = v; MODULE_PARM(n, "i")
+/* Bit map of interrupts to choose from */
+static int irq_mask = 0xdeb8;
+module_param(irq_mask, int, 0444);
+static int irq_list[4] = { -1 };
+module_param_array(irq_list, int, NULL, 0444);
 
 /*
   Transceiver/media type.
@@ -74,20 +79,12 @@
    1 = 10baseT (and autoselect if #define AUTOSELECT),
    2 = AUI/10base2,
 */
-INT_MODULE_PARM(if_port, 0);
-
-/* Bit map of interrupts to choose from. */
-INT_MODULE_PARM(irq_mask, 0xdeb8);
-static int irq_list[4] = { -1 };
-MODULE_PARM(irq_list, "1-4i");
+static int if_port; /* = 0 */
+module_param(if_port, int, 0444);
 
-#ifdef PCMCIA_DEBUG
-INT_MODULE_PARM(pc_debug, PCMCIA_DEBUG);
-static const char *version =
+#ifdef DEBUG
+static char __attribute((unused)) *version =
 "smc91c92_cs.c 0.09 1996/8/4 Donald Becker, becker@scyld.com.\n";
-#define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
-#else
-#define DEBUG(n, args...)
 #endif
 
 #define DRV_NAME	"smc91c92_cs"
@@ -322,7 +319,7 @@
     struct net_device *dev;
     int i, ret;
 
-    DEBUG(0, "smc91c92_attach()\n");
+    pn_dbg(0, "smc91c92_attach()\n");
 
     /* Create new ethernet device */
     dev = alloc_etherdev(sizeof(struct smc_private));
@@ -405,7 +402,7 @@
     struct net_device *dev = link->priv;
     dev_link_t **linkp;
 
-    DEBUG(0, "smc91c92_detach(0x%p)\n", link);
+    pn_dbg(0, "smc91c92_detach(0x%p)\n", link);
 
     /* Locate device structure */
     for (linkp = &dev_list; *linkp; linkp = &(*linkp)->next)
@@ -821,9 +818,9 @@
 	set_bits(0x300, link->io.BasePort1 + OSITECH_AUI_PWR);
 	/* Now, turn on the interrupt for both card functions */
 	set_bits(0x300, link->io.BasePort1 + OSITECH_RESET_ISR);
-	DEBUG(2, "AUI/PWR: %4.4x RESET/ISR: %4.4x\n",
-	      inw(link->io.BasePort1 + OSITECH_AUI_PWR),
-	      inw(link->io.BasePort1 + OSITECH_RESET_ISR));
+	pn_dbg(2, "AUI/PWR: %4.4x RESET/ISR: %4.4x\n",
+	       inw(link->io.BasePort1 + OSITECH_AUI_PWR),
+	       inw(link->io.BasePort1 + OSITECH_RESET_ISR));
     }
 
     return 0;
@@ -902,11 +899,11 @@
     cisparse_t parse;
     u_short buf[32];
     char *name;
-    int i, j, rev;
+    int i, j = 0, rev;
     ioaddr_t ioaddr;
     u_long mir;
 
-    DEBUG(0, "smc91c92_config(0x%p)\n", link);
+    pn_dbg(0, "smc91c92_config(0x%p)\n", link);
 
     tuple.Attributes = tuple.TupleOffset = 0;
     tuple.TupleData = (cisdata_t *)buf;
@@ -1050,8 +1047,8 @@
 
     if (smc->cfg & CFG_MII_SELECT) {
 	if (smc->mii_if.phy_id != -1) {
-	    DEBUG(0, "  MII transceiver at index %d, status %x.\n",
-		  smc->mii_if.phy_id, j);
+	    pn_dbg(0, "  MII transceiver at index %d, status %x.\n",
+		   smc->mii_if.phy_id, j);
 	} else {
     	    printk(KERN_NOTICE "  No MII transceivers found!\n");
 	}
@@ -1078,7 +1075,7 @@
 static void smc91c92_release(dev_link_t *link)
 {
 
-    DEBUG(0, "smc91c92_release(0x%p)\n", link);
+    pn_dbg(0, "smc91c92_release(0x%p)\n", link);
 
     pcmcia_release_configuration(link->handle);
     pcmcia_release_io(link->handle, &link->io);
@@ -1110,7 +1107,7 @@
     struct smc_private *smc = netdev_priv(dev);
     int i;
 
-    DEBUG(1, "smc91c92_event(0x%06x)\n", event);
+    pn_dbg(1, "smc91c92_event(0x%06x)\n", event);
 
     switch (event) {
     case CS_EVENT_CARD_REMOVAL:
@@ -1235,7 +1232,7 @@
 
 ======================================================================*/
 
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
 static void smc_dump(struct net_device *dev)
 {
     ioaddr_t ioaddr = dev->base_addr;
@@ -1257,9 +1254,9 @@
     struct smc_private *smc = netdev_priv(dev);
     dev_link_t *link = &smc->link;
 
-#ifdef PCMCIA_DEBUG
-    DEBUG(0, "%s: smc_open(%p), ID/Window %4.4x.\n",
-	  dev->name, dev, inw(dev->base_addr + BANK_SELECT));
+#ifdef DEBUG
+    pn_dbg(0, "%s: smc_open(%p), ID/Window %4.4x.\n",
+	   dev->name, dev, inw(dev->base_addr + BANK_SELECT));
     if (pc_debug > 1) smc_dump(dev);
 #endif
 
@@ -1295,8 +1292,8 @@
     dev_link_t *link = &smc->link;
     ioaddr_t ioaddr = dev->base_addr;
 
-    DEBUG(0, "%s: smc_close(), status %4.4x.\n",
-	  dev->name, inw(ioaddr + BANK_SELECT));
+    pn_dbg(0, "%s: smc_close(), status %4.4x.\n",
+	   dev->name, inw(ioaddr + BANK_SELECT));
 
     netif_stop_queue(dev);
 
@@ -1362,8 +1359,8 @@
 	u_char *buf = skb->data;
 	u_int length = skb->len; /* The chip will pad to ethernet min. */
 
-	DEBUG(2, "%s: Trying to xmit packet of length %d.\n",
-	      dev->name, length);
+	pn_dbg(2, "%s: Trying to xmit packet of length %d.\n",
+	       dev->name, length);
 	
 	/* send the packet length: +6 for status word, length, and ctl */
 	outw(0, ioaddr + DATA_1);
@@ -1415,8 +1412,8 @@
 
     netif_stop_queue(dev);
 
-    DEBUG(2, "%s: smc_start_xmit(length = %d) called,"
-	  " status %4.4x.\n", dev->name, skb->len, inw(ioaddr + 2));
+    pn_dbg(2, "%s: smc_start_xmit(length = %d) called,"
+	   " status %4.4x.\n", dev->name, skb->len, inw(ioaddr + 2));
 
     if (smc->saved_skb) {
 	/* THIS SHOULD NEVER HAPPEN. */
@@ -1460,7 +1457,7 @@
     }
 
     /* Otherwise defer until the Tx-space-allocated interrupt. */
-    DEBUG(2, "%s: memory allocation deferred.\n", dev->name);
+    pn_dbg(2, "%s: memory allocation deferred.\n", dev->name);
     outw((IM_ALLOC_INT << 8) | (ir & 0xff00), ioaddr + INTERRUPT);
 
     return 0;
@@ -1524,8 +1521,8 @@
 
     SMC_SELECT_BANK(0);
     ephs = inw(ioaddr + EPH);
-    DEBUG(2, "%s: Ethernet protocol handler interrupt, status"
-	  " %4.4x.\n", dev->name, ephs);
+    pn_dbg(2, "%s: Ethernet protocol handler interrupt, status"
+	   " %4.4x.\n", dev->name, ephs);
     /* Could be a counter roll-over warning: update stats. */
     card_stats = inw(ioaddr + COUNTER);
     /* single collisions */
@@ -1564,16 +1561,16 @@
 
     ioaddr = dev->base_addr;
 
-    DEBUG(3, "%s: SMC91c92 interrupt %d at %#x.\n", dev->name,
-	  irq, ioaddr);
+    pn_dbg(3, "%s: SMC91c92 interrupt %d at %#x.\n", dev->name,
+	   irq, ioaddr);
 
     smc->watchdog = 0;
     saved_bank = inw(ioaddr + BANK_SELECT);
     if ((saved_bank & 0xff00) != 0x3300) {
 	/* The device does not exist -- the card could be off-line, or
 	   maybe it has been ejected. */
-	DEBUG(1, "%s: SMC91c92 interrupt %d for non-existent"
-	      "/ejected device.\n", dev->name, irq);
+	pn_dbg(1, "%s: SMC91c92 interrupt %d for non-existent"
+	       "/ejected device.\n", dev->name, irq);
 	handled = 0;
 	goto irq_done;
     }
@@ -1586,8 +1583,8 @@
 
     do { /* read the status flag, and mask it */
 	status = inw(ioaddr + INTERRUPT) & 0xff;
-	DEBUG(3, "%s: Status is %#2.2x (mask %#2.2x).\n", dev->name,
-	      status, mask);
+	pn_dbg(3, "%s: Status is %#2.2x (mask %#2.2x).\n", dev->name,
+	       status, mask);
 	if ((status & mask) == 0) {
 	    if (bogus_cnt == INTR_WORK)
 		handled = 0;
@@ -1631,15 +1628,15 @@
 	    smc_eph_irq(dev);
     } while (--bogus_cnt);
 
-    DEBUG(3, "  Restoring saved registers mask %2.2x bank %4.4x"
-	  " pointer %4.4x.\n", mask, saved_bank, saved_pointer);
+    pn_dbg(3, "  Restoring saved registers mask %2.2x bank %4.4x"
+	   " pointer %4.4x.\n", mask, saved_bank, saved_pointer);
 
     /* restore state register */
     outw((mask<<8), ioaddr + INTERRUPT);
     outw(saved_pointer, ioaddr + POINTER);
     SMC_SELECT_BANK(saved_bank);
 
-    DEBUG(3, "%s: Exiting interrupt IRQ%d.\n", dev->name, irq);
+    pn_dbg(3, "%s: Exiting interrupt IRQ%d.\n", dev->name, irq);
 
 irq_done:
 
@@ -1690,8 +1687,8 @@
     rx_status = inw(ioaddr + DATA_1);
     packet_length = inw(ioaddr + DATA_1) & 0x07ff;
 
-    DEBUG(2, "%s: Receive status %4.4x length %d.\n",
-	  dev->name, rx_status, packet_length);
+    pn_dbg(2, "%s: Receive status %4.4x length %d.\n",
+	   dev->name, rx_status, packet_length);
 
     if (!(rx_status & RS_ERRORS)) {		
 	/* do stuff to make a new packet */
@@ -1701,7 +1698,7 @@
 	skb = dev_alloc_skb(packet_length+2);
 	
 	if (skb == NULL) {
-	    DEBUG(1, "%s: Low memory, packet dropped.\n", dev->name);
+	    pn_dbg(1, "%s: Low memory, packet dropped.\n", dev->name);
 	    smc->stats.rx_dropped++;
 	    outw(MC_RELEASE, ioaddr + MMU_CMD);
 	    return;
@@ -1872,7 +1869,7 @@
     struct smc_private *smc = netdev_priv(dev);
     int i;
 
-    DEBUG(0, "%s: smc91c92 reset called.\n", dev->name);
+    pn_dbg(0, "%s: smc91c92 reset called.\n", dev->name);
 
     /* The first interaction must be a write to bring the chip out
        of sleep mode. */
@@ -2184,7 +2181,7 @@
 	return ret;
 }
 
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
 static u32 smc_get_msglevel(struct net_device *dev)
 {
 	return pc_debug;
@@ -2219,7 +2216,7 @@
 	.get_settings = smc_get_settings,
 	.set_settings = smc_set_settings,
 	.get_link = smc_get_link,
-#ifdef PCMCIA_DEBUG
+#ifdef DEBUG
 	.get_msglevel = smc_get_msglevel,
 	.set_msglevel = smc_set_msglevel,
 #endif
===== drivers/net/pcmcia/xirc2ps_cs.c 1.37 vs edited =====
--- 1.37/drivers/net/pcmcia/xirc2ps_cs.c	2004-10-20 10:37:15 +02:00
+++ edited/drivers/net/pcmcia/xirc2ps_cs.c	2004-10-26 12:27:30 +02:00
@@ -91,6 +91,7 @@
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
+#include "common.h"
 
 #ifndef MANFID_COMPAQ
   #define MANFID_COMPAQ 	   0x0138
@@ -211,21 +212,6 @@
 
 static char *if_names[] = { "Auto", "10BaseT", "10Base2", "AUI", "100BaseT" };
 
-/****************
- * All the PCMCIA modules use PCMCIA_DEBUG to control debugging.  If
- * you do not define PCMCIA_DEBUG at all, all the debug code will be
- * left out.  If you compile with PCMCIA_DEBUG=0, the debug code will
- * be present but disabled -- but it can then be enabled for specific
- * modules at load time with a 'pc_debug=#' option to insmod.
- */
-#ifdef PCMCIA_DEBUG
-static int pc_debug = PCMCIA_DEBUG;
-MODULE_PARM(pc_debug, "i");
-#define DEBUG(n, args...) if (pc_debug>(n)) printk(KDBG_XIRC args)
-#else
-#define DEBUG(n, args...)
-#endif
-
 #define KDBG_XIRC KERN_DEBUG   "xirc2ps_cs: "
 #define KERR_XIRC KERN_ERR     "xirc2ps_cs: "
 #define KWRN_XIRC KERN_WARNING "xirc2ps_cs: "
@@ -255,15 +241,23 @@
 MODULE_DESCRIPTION("Xircom PCMCIA ethernet driver");
 MODULE_LICENSE("Dual MPL/GPL");
 
-#define INT_MODULE_PARM(n, v) static int n = v; MODULE_PARM(n, "i")
-
+/* Bit map of interrupts to choose from */
+static int irq_mask = 0xdeb8;
+module_param(irq_mask, int, 0444);
 static int irq_list[4] = { -1 };
-MODULE_PARM(irq_list, "1-4i");
-INT_MODULE_PARM(irq_mask,	0xdeb8);
-INT_MODULE_PARM(if_port,	0);
-INT_MODULE_PARM(full_duplex,	0);
-INT_MODULE_PARM(do_sound, 	1);
-INT_MODULE_PARM(lockup_hack,	0);  /* anti lockup hack */
+module_param_array(irq_list, int, NULL, 0444);
+
+static int if_port; /* = 0 */
+module_param(if_port, int, 0444);
+
+static int full_duplex; /* = 0 */
+module_param(full_duplex, int, 0444);
+
+static int do_sound = 1;
+module_param(do_sound, int, 0444);
+
+static int lockup_hack; /* = 0 */
+module_param(lockup_hack, int, 0444);
 
 /*====================================================================*/
 
@@ -424,7 +418,7 @@
 } while (0)
 
 /*====== Functions used for debugging =================================*/
-#if defined(PCMCIA_DEBUG) && 0 /* reading regs may change system status */
+#if defined(DEBUG) && 0 /* reading regs may change system status */
 static void
 PrintRegisters(struct net_device *dev)
 {
@@ -456,7 +450,7 @@
 	}
     }
 }
-#endif /* PCMCIA_DEBUG */
+#endif /* DEBUG */
 
 /*============== MII Management functions ===============*/
 
@@ -589,7 +583,7 @@
     local_info_t *local;
     int err;
 
-    DEBUG(0, "attach()\n");
+    pn_dbg(0, "attach()\n");
 
     /* Allocate the device structure */
     dev = alloc_etherdev(sizeof(local_info_t));
@@ -657,14 +651,14 @@
     struct net_device *dev = link->priv;
     dev_link_t **linkp;
 
-    DEBUG(0, "detach(0x%p)\n", link);
+    pn_dbg(0, "detach(0x%p)\n", link);
 
     /* Locate device structure */
     for (linkp = &dev_list; *linkp; linkp = &(*linkp)->next)
 	if (*linkp == link)
 	    break;
     if (!*linkp) {
-	DEBUG(0, "detach(0x%p): dev_link lost\n", link);
+	pn_dbg(0, "detach(0x%p): dev_link lost\n", link);
 	return;
     }
 
@@ -712,14 +706,14 @@
 {
     struct net_device *dev = link->priv;
     local_info_t *local = netdev_priv(dev);
-  #ifdef PCMCIA_DEBUG
+  #ifdef DEBUG
     unsigned cisrev = ((const unsigned char *)s)[2];
   #endif
     unsigned mediaid= ((const unsigned char *)s)[3];
     unsigned prodid = ((const unsigned char *)s)[4];
 
-    DEBUG(0, "cisrev=%02x mediaid=%02x prodid=%02x\n",
-	  cisrev, mediaid, prodid);
+    pn_dbg(0, "cisrev=%02x mediaid=%02x prodid=%02x\n",
+	   cisrev, mediaid, prodid);
 
     local->mohawk = 0;
     local->dingo = 0;
@@ -817,7 +811,7 @@
 
     local->dingo_ccr = NULL;
 
-    DEBUG(0, "config(0x%p)\n", link);
+    pn_dbg(0, "config(0x%p)\n", link);
 
     /*
      * This reads the card's CONFIG tuple to find its configuration
@@ -857,7 +851,7 @@
 	       (unsigned)parse.manfid.manf);
 	goto failure;
     }
-    DEBUG(0, "found %s card\n", local->manf_str);
+    pn_dbg(0, "found %s card\n", local->manf_str);
 
     if (!set_card_type(link, buf)) {
 	printk(KNOT_XIRC "this card is not supported\n");
@@ -1159,7 +1153,7 @@
 xirc2ps_release(dev_link_t *link)
 {
 
-    DEBUG(0, "release(0x%p)\n", link);
+    pn_dbg(0, "release(0x%p)\n", link);
 
     if (link->win) {
 	struct net_device *dev = link->priv;
@@ -1196,11 +1190,11 @@
     dev_link_t *link = args->client_data;
     struct net_device *dev = link->priv;
 
-    DEBUG(0, "event(%d)\n", (int)event);
+    pn_dbg(0, "event(%d)\n", (int)event);
 
     switch (event) {
     case CS_EVENT_REGISTRATION_COMPLETE:
-	DEBUG(0, "registration complete\n");
+	pn_dbg(0, "registration complete\n");
 	break;
     case CS_EVENT_CARD_REMOVAL:
 	link->state &= ~DEV_PRESENT;
@@ -1267,7 +1261,7 @@
 	PutByte(XIRCREG_CR, 0);
     }
 
-    DEBUG(6, "%s: interrupt %d at %#x.\n", dev->name, irq, ioaddr);
+    pn_dbg(6, "%s: interrupt %d at %#x.\n", dev->name, irq, ioaddr);
 
     saved_page = GetByte(XIRCREG_PR);
     /* Read the ISR to see whats the cause for the interrupt.
@@ -1277,7 +1271,7 @@
     bytes_rcvd = 0;
   loop_entry:
     if (int_status == 0xff) { /* card may be ejected */
-	DEBUG(3, "%s: interrupt %d for dead card\n", dev->name, irq);
+	pn_dbg(3, "%s: interrupt %d for dead card\n", dev->name, irq);
 	goto leave;
     }
     eth_status = GetByte(XIRCREG_ESR);
@@ -1290,8 +1284,8 @@
     PutByte(XIRCREG40_TXST0, 0);
     PutByte(XIRCREG40_TXST1, 0);
 
-    DEBUG(3, "%s: ISR=%#2.2x ESR=%#2.2x RSR=%#2.2x TSR=%#4.4x\n",
-	  dev->name, int_status, eth_status, rx_status, tx_status);
+    pn_dbg(3, "%s: ISR=%#2.2x ESR=%#2.2x RSR=%#2.2x TSR=%#4.4x\n",
+	   dev->name, int_status, eth_status, rx_status, tx_status);
 
     /***** receive section ******/
     SelectPage(0);
@@ -1301,14 +1295,14 @@
 	    /* too many bytes received during this int, drop the rest of the
 	     * packets */
 	    lp->stats.rx_dropped++;
-	    DEBUG(2, "%s: RX drop, too much done\n", dev->name);
+	    pn_dbg(2, "%s: RX drop, too much done\n", dev->name);
 	} else if (rsr & PktRxOk) {
 	    struct sk_buff *skb;
 
 	    pktlen = GetWord(XIRCREG0_RBC);
 	    bytes_rcvd += pktlen;
 
-	    DEBUG(5, "rsr=%#02x packet_length=%u\n", rsr, pktlen);
+	    pn_dbg(5, "rsr=%#02x packet_length=%u\n", rsr, pktlen);
 
 	    skb = dev_alloc_skb(pktlen+3); /* 1 extra so we can use insw */
 	    if (!skb) {
@@ -1378,19 +1372,19 @@
 		    lp->stats.multicast++;
 	    }
 	} else { /* bad packet */
-	    DEBUG(5, "rsr=%#02x\n", rsr);
+	    pn_dbg(5, "rsr=%#02x\n", rsr);
 	}
 	if (rsr & PktTooLong) {
 	    lp->stats.rx_frame_errors++;
-	    DEBUG(3, "%s: Packet too long\n", dev->name);
+	    pn_dbg(3, "%s: Packet too long\n", dev->name);
 	}
 	if (rsr & CRCErr) {
 	    lp->stats.rx_crc_errors++;
-	    DEBUG(3, "%s: CRC error\n", dev->name);
+	    pn_dbg(3, "%s: CRC error\n", dev->name);
 	}
 	if (rsr & AlignErr) {
 	    lp->stats.rx_fifo_errors++; /* okay ? */
-	    DEBUG(3, "%s: Alignment error\n", dev->name);
+	    pn_dbg(3, "%s: Alignment error\n", dev->name);
 	}
 
 	/* clear the received/dropped/error packet */
@@ -1402,7 +1396,7 @@
     if (rx_status & 0x10) { /* Receive overrun */
 	lp->stats.rx_over_errors++;
 	PutByte(XIRCREG_CR, ClearRxOvrun);
-	DEBUG(3, "receive overrun cleared\n");
+	pn_dbg(3, "receive overrun cleared\n");
     }
 
     /***** transmit section ******/
@@ -1415,13 +1409,13 @@
 	if (nn < n) /* rollover */
 	    lp->stats.tx_packets += 256 - n;
 	else if (n == nn) { /* happens sometimes - don't know why */
-	    DEBUG(0, "PTR not changed?\n");
+	    pn_dbg(0, "PTR not changed?\n");
 	} else
 	    lp->stats.tx_packets += lp->last_ptr_value - n;
 	netif_wake_queue(dev);
     }
     if (tx_status & 0x0002) {	/* Execessive collissions */
-	DEBUG(0, "tx restarted due to execssive collissions\n");
+	pn_dbg(0, "tx restarted due to execssive collissions\n");
 	PutByte(XIRCREG_CR, RestartTx);  /* restart transmitter process */
     }
     if (tx_status & 0x0040)
@@ -1440,14 +1434,14 @@
 		maxrx_bytes = 2000;
 	    else if (maxrx_bytes > 22000)
 		maxrx_bytes = 22000;
-	    DEBUG(1, "set maxrx=%u (rcvd=%u ticks=%lu)\n",
-		  maxrx_bytes, bytes_rcvd, duration);
+	    pn_dbg(1, "set maxrx=%u (rcvd=%u ticks=%lu)\n",
+		   maxrx_bytes, bytes_rcvd, duration);
 	} else if (!duration && maxrx_bytes < 22000) {
 	    /* now much faster */
 	    maxrx_bytes += 2000;
 	    if (maxrx_bytes > 22000)
 		maxrx_bytes = 22000;
-	    DEBUG(1, "set maxrx=%u\n", maxrx_bytes);
+	    pn_dbg(1, "set maxrx=%u\n", maxrx_bytes);
 	}
     }
 
@@ -1488,8 +1482,8 @@
     unsigned freespace;
     unsigned pktlen = skb? skb->len : 0;
 
-    DEBUG(1, "do_start_xmit(skb=%p, dev=%p) len=%u\n",
-	  skb, dev, pktlen);
+    pn_dbg(1, "do_start_xmit(skb=%p, dev=%p) len=%u\n",
+	   skb, dev, pktlen);
 
 
     /* adjust the packet length to min. required
@@ -1515,8 +1509,8 @@
     freespace &= 0x7fff;
     /* TRS doesn't work - (indeed it is eliminated with sil-rev 1) */
     okay = pktlen +2 < freespace;
-    DEBUG(2 + (okay ? 2 : 0), "%s: avail. tx space=%u%s\n",
-	  dev->name, freespace, okay ? " (okay)":" (not enough)");
+    pn_dbg(2 + (okay ? 2 : 0), "%s: avail. tx space=%u%s\n",
+	   dev->name, freespace, okay ? " (okay)":" (not enough)");
     if (!okay) { /* not enough space */
 	return 1;  /* upper layer may decide to requeue this packet */
     }
@@ -1621,7 +1615,7 @@
 {
     local_info_t *local = netdev_priv(dev);
 
-    DEBUG(0, "do_config(%p)\n", dev);
+    pn_dbg(0, "do_config(%p)\n", dev);
     if (map->port != 255 && map->port != dev->if_port) {
 	if (map->port > 4)
 	    return -EINVAL;
@@ -1648,7 +1642,7 @@
     local_info_t *lp = netdev_priv(dev);
     dev_link_t *link = &lp->link;
 
-    DEBUG(0, "do_open(%p)\n", dev);
+    pn_dbg(0, "do_open(%p)\n", dev);
 
     /* Check that the PCMCIA card is still here. */
     /* Physical device present signature. */
@@ -1682,9 +1676,9 @@
     ioaddr_t ioaddr = dev->base_addr;
     u16 *data = (u16 *)&rq->ifr_ifru;
 
-    DEBUG(1, "%s: ioctl(%-.6s, %#04x) %04x %04x %04x %04x\n",
-	  dev->name, rq->ifr_ifrn.ifrn_name, cmd,
-	  data[0], data[1], data[2], data[3]);
+    pn_dbg(1, "%s: ioctl(%-.6s, %#04x) %04x %04x %04x %04x\n",
+	   dev->name, rq->ifr_ifrn.ifrn_name, cmd,
+	   data[0], data[1], data[2], data[3]);
 
     if (!local->mohawk)
 	return -EOPNOTSUPP;
@@ -1731,7 +1725,7 @@
     ioaddr_t ioaddr = dev->base_addr;
     unsigned value;
 
-    DEBUG(0, "%s: do_reset(%p,%d)\n", dev? dev->name:"eth?", dev, full);
+    pn_dbg(0, "%s: do_reset(%p,%d)\n", dev? dev->name:"eth?", dev, full);
 
     hardreset(dev);
     PutByte(XIRCREG_CR, SoftReset); /* set */
@@ -1769,7 +1763,7 @@
     }
     Wait(HZ/25);		     /* wait 40 msec to let it complete */
 
-  #ifdef PCMCIA_DEBUG
+  #ifdef DEBUG
     if (pc_debug) {
 	SelectPage(0);
 	value = GetByte(XIRCREG_ESR);	 /* read the ESR */
@@ -1787,7 +1781,7 @@
 	value |= DisableLinkPulse;
     PutByte(XIRCREG1_ECR, value);
   #endif
-    DEBUG(0, "%s: ECR is: %#02x\n", dev->name, value);
+    pn_dbg(0, "%s: ECR is: %#02x\n", dev->name, value);
 
     SelectPage(0x42);
     PutByte(XIRCREG42_SWC0, 0x20); /* disable source insertion */
@@ -1964,7 +1958,7 @@
 
     ioaddr_t ioaddr = dev->base_addr;
 
-    DEBUG(0, "do_powerdown(%p)\n", dev);
+    pn_dbg(0, "do_powerdown(%p)\n", dev);
 
     SelectPage(4);
     PutByte(XIRCREG4_GPR1, 0);	     /* clear bit 0: power down */
@@ -1978,7 +1972,7 @@
     local_info_t *lp = netdev_priv(dev);
     dev_link_t *link = &lp->link;
 
-    DEBUG(0, "do_stop(%p)\n", dev);
+    pn_dbg(0, "do_stop(%p)\n", dev);
 
     if (!link)
 	return -ENODEV;
--- /dev/null	2004-02-23 22:02:56.000000000 +0100
+++ linux-2.6/drivers/net/pcmcia/common.h	2004-10-26 11:00:16.000000000 +0200
@@ -0,0 +1,16 @@
+#include <linux/kernel.h>
+#include <linux/moduleparam.h>
+
+#ifdef DEBUG
+static int pc_debug;
+
+module_param(pc_debug, int, 0644);
+
+#define pn_dbg(lvl, fmt, arg...) do {				\
+	if (pc_debug > (lvl))					\
+		printk(KERN_DEBUG "pn: " fmt, ## arg);		\
+} while (0)
+
+#else
+#define pn_dbg(lvl, fmt, arg...) do { } while (0)
+#endif
-- 
Stelian Pop <stelian@popies.net>    
