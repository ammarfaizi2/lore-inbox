Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbTJNTCb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 15:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbTJNTCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 15:02:31 -0400
Received: from havoc.gtf.org ([63.247.75.124]:14561 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262886AbTJNTBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 15:01:48 -0400
Date: Tue, 14 Oct 2003 15:01:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: marcelo@parcelfarce.linux.theplanet.co.uk, marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [BK PATCHES] 2.4.x net driver updates
Message-ID: <20031014190108.GA19665@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.4

This will update the following files:

 drivers/net/8139too.c             |    2 
 drivers/net/b44.c                 |   23 +----
 drivers/net/e1000/e1000_main.c    |   30 +++++-
 drivers/net/natsemi.c             |    2 
 drivers/net/pcmcia/xircom_cb.c    |  114 ++++++++++++-------------
 drivers/net/sk98lin/h/skversion.h |   13 +-
 drivers/net/sk98lin/skge.c        |  171 ++++++++++++++++++++++++++------------
 drivers/net/tulip/tulip_core.c    |    1 
 include/linux/ethtool.h           |   11 +-
 include/linux/pci_ids.h           |    1 
 net/core/ethtool.c                |   49 ++++++----
 11 files changed, 254 insertions(+), 163 deletions(-)

through these ChangeSets:

<pp@ee.oulu.fi> (03/10/14 1.1198)
   [PATCH] b44 enable interrupts after tx timeout (2.4.23-pre6)
   
   Here's the 2.4.23-pre6 version, which syncs the driver fully with 2.6.
   Seems to work (tm).

<manfred@colorfullife.com> (03/10/14 1.1197)
   [netdrvr natsemi] fix ring clean
   
   Too much copy&paste in a call to pci_unmap_single.

<jgarzik@redhat.com> (03/10/14 1.1196)
   [netdrvr tulip] add pci id
   
   Contributed by Ken Zalewski.

<jgarzik@redhat.com> (03/10/14 1.1195)
   [netdrvr 8139too] another new PCI ID
   
   Contributed by Josh Litherland, Donald Becker, and others.

<jgarzik@redhat.com> (03/10/14 1.1194)
   [netdrvr 8139too] add pci id
   
   contributed by "JaReK" and Donald Becker.

<scott.feldman@intel.com> (03/10/14 1.1193)
   [PATCH] hang on ZEROCOPY/TSO when hitting no-Tx-resources
   
   * Critical bug fix: under heavy Tx stress using ZEROCOPY or TSO, if we
     run out of Tx descriptors, we don't calculate for the context
     descriptor used as the first of the ZEROCOPY/TSO send, nor do we clean
     up the context descriptor bits in the case where the send isn't going
     to fit and we need to undo the mappings.  This bug was introduced
     with the 5.2.16 patch set which included a workaround for a hang
     on 82544 over PCI-X.  This workaround caused the check for no-Tx-
     resource logic to change, and this bug slipped in.

<scott.feldman@intel.com> (03/10/14 1.1192)
   [PATCH] ethtool_ops eeprom stuff
   
   Finally got around to adding ethtool_ops to e100-3.0.x.  I found a bug
   with get_eeprom() and it seems to work best if we add get_eeprom_len() to
   the ops list.  Also moved check for offest + len < size into ethtool.c.
   
   I was able to test [GS]EEPROM, PHYS_ID, GSTATS, GSTRINGS, and TEST, and
   everything looks good.
   
   Should I send same for 2.4?

<mlindner@syskonnect.de> (03/10/14 1.1191)
   [PATCH] sk98lin-2.4: Driver update to version 6.18
   
   here is a new version of the sk98lin driver (v6.18) with some changes
   for the kernel 2.4.22-bk25.
   
   Patch 1/1
    * Add: New Gigabit LOM vendors (Epox, Gigabyte, Abit, Iwill, ECS, Asus)
    * Add: Better Support for Yukon Plus chipset
    * Fix: IO-control return race condition
    * Fix: Interrupt moderation value check
    * Fix: PCI initialization (SkGeInitPCI)
    * Fix: TCP and UDP HW Checksum calculation

<jgarzik@redhat.com> (03/10/14 1.1190)
   [netdrvr xircom_cb] backport 2.6 changes
   
   * use alloc_etherdev; fixes races in stats pointer setting
     (by Stephen Hemminger)
   * kill unnecessary whitespace and #includes
   * use C99-style initializers
   * speling and irqreturn_t changes





diff -Nru a/drivers/net/8139too.c b/drivers/net/8139too.c
--- a/drivers/net/8139too.c	Tue Oct 14 14:52:41 2003
+++ b/drivers/net/8139too.c	Tue Oct 14 14:52:41 2003
@@ -247,6 +247,8 @@
 	{0x14ea, 0xab06, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
 	{0x14ea, 0xab07, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
 	{0x11db, 0x1234, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
+	{0x1432, 0x9130, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
+	{0x02ac, 0x1012, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
 
 #ifdef CONFIG_SH_SECUREEDGE5410
 	/* Bogus 8139 silicon reports 8129 without external PROM :-( */
diff -Nru a/drivers/net/b44.c b/drivers/net/b44.c
--- a/drivers/net/b44.c	Tue Oct 14 14:52:41 2003
+++ b/drivers/net/b44.c	Tue Oct 14 14:52:41 2003
@@ -25,8 +25,8 @@
 
 #define DRV_MODULE_NAME		"b44"
 #define PFX DRV_MODULE_NAME	": "
-#define DRV_MODULE_VERSION	"0.9"
-#define DRV_MODULE_RELDATE	"Jul 14, 2003"
+#define DRV_MODULE_VERSION	"0.91"
+#define DRV_MODULE_RELDATE	"Oct 3, 2003"
 
 #define B44_DEF_MSG_ENABLE	  \
 	(NETIF_MSG_DRV		| \
@@ -80,16 +80,7 @@
 
 static int b44_debug = -1;	/* -1 == use B44_DEF_MSG_ENABLE as value */
 
-#ifndef PCI_DEVICE_ID_BCM4401
-#define PCI_DEVICE_ID_BCM4401      0x4401
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#define IRQ_RETVAL(x) 
-#define irqreturn_t void
-#endif
-
-static struct pci_device_id b44_pci_tbl[] __devinitdata = {
+static struct pci_device_id b44_pci_tbl[] = {
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4401,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ }	/* terminate list with empty entry */
@@ -870,6 +861,8 @@
 
 	spin_unlock_irq(&bp->lock);
 
+	b44_enable_ints(bp);
+
 	netif_wake_queue(dev);
 }
 
@@ -1393,7 +1386,7 @@
 		strcpy (info.driver, DRV_MODULE_NAME);
 		strcpy (info.version, DRV_MODULE_VERSION);
 		memset(&info.fw_version, 0, sizeof(info.fw_version));
-		strcpy (info.bus_info, pci_dev->slot_name);
+		strcpy (info.bus_info, pci_name(pci_dev));
 		info.eedump_len = 0;
 		info.regdump_len = 0;
 		if (copy_to_user (useraddr, &info, sizeof (info)))
@@ -1834,7 +1827,7 @@
 	iounmap((void *) bp->regs);
 
 err_out_free_dev:
-	kfree(dev);
+	free_netdev(dev);
 
 err_out_free_res:
 	pci_release_regions(pdev);
@@ -1852,7 +1845,7 @@
 	if (dev) {
 		unregister_netdev(dev);
 		iounmap((void *) ((struct b44 *)(dev->priv))->regs);
-		kfree(dev);
+		free_netdev(dev);
 		pci_release_regions(pdev);
 		pci_disable_device(pdev);
 		pci_set_drvdata(pdev, NULL);
diff -Nru a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
--- a/drivers/net/e1000/e1000_main.c	Tue Oct 14 14:52:41 2003
+++ b/drivers/net/e1000/e1000_main.c	Tue Oct 14 14:52:41 2003
@@ -59,7 +59,7 @@
 
 char e1000_driver_name[] = "e1000";
 char e1000_driver_string[] = "Intel(R) PRO/1000 Network Driver";
-char e1000_driver_version[] = "5.2.16-k1";
+char e1000_driver_version[] = "5.2.16-k2";
 char e1000_copyright[] = "Copyright (c) 1999-2003 Intel Corporation.";
 
 /* e1000_pci_tbl - PCI Device ID Table
@@ -1532,6 +1532,7 @@
 	unsigned int first)
 {
 	struct e1000_desc_ring *tx_ring = &adapter->tx_ring;
+	struct e1000_tx_desc *tx_desc;
 	struct e1000_buffer *buffer_info;
 	unsigned int len = skb->len, max_per_txd = E1000_MAX_DATA_PER_TXD;
 	unsigned int offset = 0, size, count = 0, i;
@@ -1622,17 +1623,29 @@
 		}
 	}
 
-	if(E1000_DESC_UNUSED(&adapter->tx_ring) < count) {
+	if(E1000_DESC_UNUSED(&adapter->tx_ring) < count + 2) {
 
 		/* There aren't enough descriptors available to queue up
-		 * this send, so undo the mapping and abort the send. 
-		 * We could have done the check before we mapped the skb,
-		 * but because of all the workarounds (above), it's too
-		 * difficult to predict how many we're going to need.*/
-		i = first;
+		 * this send (need: count + 1 context desc + 1 desc gap
+		 * to keep tail from touching head), so undo the mapping
+		 * and abort the send.  We could have done the check before
+		 * we mapped the skb, but because of all the workarounds
+		 * (above), it's too difficult to predict how many we're
+		 * going to need.*/
+		i = adapter->tx_ring.next_to_use;
+
+		if(i == first) {
+			/* Cleanup after e1000_tx_[csum|tso] scribbling
+			 * on descriptors. */
+			tx_desc = E1000_TX_DESC(*tx_ring, first);
+			tx_desc->buffer_addr = 0;
+			tx_desc->lower.data = 0;
+			tx_desc->upper.data = 0;
+		}
 
 		while(count--) {
 			buffer_info = &tx_ring->buffer_info[i];
+
 			if(buffer_info->dma) {
 				pci_unmap_page(adapter->pdev,
 					       buffer_info->dma,
@@ -1640,8 +1653,11 @@
 					       PCI_DMA_TODEVICE);
 				buffer_info->dma = 0;
 			}
+
 			if(++i == tx_ring->count) i = 0;
 		}
+
+		adapter->tx_ring.next_to_use = first;
 
 		return 0;
 	}
diff -Nru a/drivers/net/natsemi.c b/drivers/net/natsemi.c
--- a/drivers/net/natsemi.c	Tue Oct 14 14:52:41 2003
+++ b/drivers/net/natsemi.c	Tue Oct 14 14:52:41 2003
@@ -1528,7 +1528,7 @@
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		if (np->tx_skbuff[i]) {
 			pci_unmap_single(np->pci_dev,
-				np->rx_dma[i], np->rx_skbuff[i]->len,
+				np->tx_dma[i], np->tx_skbuff[i]->len,
 				PCI_DMA_TODEVICE);
 			dev_kfree_skb(np->tx_skbuff[i]);
 			np->stats.tx_dropped++;
diff -Nru a/drivers/net/pcmcia/xircom_cb.c b/drivers/net/pcmcia/xircom_cb.c
--- a/drivers/net/pcmcia/xircom_cb.c	Tue Oct 14 14:52:41 2003
+++ b/drivers/net/pcmcia/xircom_cb.c	Tue Oct 14 14:52:41 2003
@@ -14,10 +14,8 @@
  * 	$Id: xircom_cb.c,v 1.33 2001/03/19 14:02:07 arjanv Exp $
  */
 
-
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
@@ -30,12 +28,11 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/ethtool.h>
+
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
 #include <asm/io.h>
 
-
-
 #ifdef DEBUG
 #define enter(x)   printk("Enter: %s, %s line %i\n",x,__FILE__,__LINE__)
 #define leave(x)   printk("Leave: %s, %s line %i\n",x,__FILE__,__LINE__)
@@ -114,7 +111,7 @@
 /* Function prototypes */
 static int xircom_probe(struct pci_dev *pdev, const struct pci_device_id *id);
 static void xircom_remove(struct pci_dev *pdev);
-static void xircom_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
+static irqreturn_t xircom_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
 static int xircom_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static int xircom_open(struct net_device *dev);
 static int xircom_close(struct net_device *dev);
@@ -124,7 +121,7 @@
 static void investigate_read_descriptor(struct net_device *dev,struct xircom_private *card, int descnr, unsigned int bufferoffset);
 static void investigate_write_descriptor(struct net_device *dev, struct xircom_private *card, int descnr, unsigned int bufferoffset);
 static void read_mac_address(struct xircom_private *card);
-static void tranceiver_voodoo(struct xircom_private *card);
+static void transceiver_voodoo(struct xircom_private *card);
 static void initialize_card(struct xircom_private *card);
 static void trigger_transmit(struct xircom_private *card);
 static void trigger_receive(struct xircom_private *card);
@@ -143,17 +140,19 @@
 
 
 
-static struct pci_device_id xircom_pci_table[] __devinitdata = {
+static struct pci_device_id xircom_pci_table[] = {
 	{0x115D, 0x0003, PCI_ANY_ID, PCI_ANY_ID,},
 	{0,},
 };
 MODULE_DEVICE_TABLE(pci, xircom_pci_table);
 
 static struct pci_driver xircom_ops = {
-	name:		"xircom_cb", 
-	id_table:	xircom_pci_table, 
-	probe:		xircom_probe, 
-	remove:		__devexit_p(xircom_remove),
+	.name		= "xircom_cb", 
+	.id_table	= xircom_pci_table, 
+	.probe		= xircom_probe, 
+	.remove		= xircom_remove, 
+	.suspend =NULL,
+	.resume =NULL
 };
 
 
@@ -226,40 +225,32 @@
 		return -ENODEV;
 	}
 
-	
 	/* 
 	   Before changing the hardware, allocate the memory.
 	   This way, we can fail gracefully if not enough memory
 	   is available. 
 	 */
-	private = kmalloc(sizeof(*private),GFP_KERNEL);
-	memset(private, 0, sizeof(struct xircom_private));
+	dev = alloc_etherdev(sizeof(struct xircom_private));
+	if (!dev) {
+		printk(KERN_ERR "xircom_probe: failed to allocate etherdev\n");
+		goto device_fail;
+	}
+	private = dev->priv;
 	
 	/* Allocate the send/receive buffers */
 	private->rx_buffer = pci_alloc_consistent(pdev,8192,&private->rx_dma_handle);
-	
 	if (private->rx_buffer == NULL) {
  		printk(KERN_ERR "xircom_probe: no memory for rx buffer \n");
- 		kfree(private);
-		return -ENODEV;
+		goto rx_buf_fail;
 	}	
 	private->tx_buffer = pci_alloc_consistent(pdev,8192,&private->tx_dma_handle);
 	if (private->tx_buffer == NULL) {
 		printk(KERN_ERR "xircom_probe: no memory for tx buffer \n");
-		kfree(private->rx_buffer);
-		kfree(private);
-		return -ENODEV;
-	}
-	dev = init_etherdev(dev, 0);
-	if (dev == NULL) {
-		printk(KERN_ERR "xircom_probe: failed to allocate etherdev\n");
-		kfree(private->rx_buffer);
-		kfree(private->tx_buffer);
-		kfree(private);
-		return -ENODEV;
+		goto tx_buf_fail;
 	}
+
 	SET_MODULE_OWNER(dev);
-	printk(KERN_INFO "%s: Xircom cardbus revision %i at irq %i \n", dev->name, chip_rev, pdev->irq);
+
 
 	private->dev = dev;
 	private->pdev = pdev;
@@ -267,11 +258,11 @@
 	private->lock = SPIN_LOCK_UNLOCKED;
 	dev->irq = pdev->irq;
 	dev->base_addr = private->io_port;
-
+	
 	initialize_card(private);
 	read_mac_address(private);
 	setup_descriptors(private);
-
+	
 	dev->open = &xircom_open;
 	dev->hard_start_xmit = &xircom_start_xmit;
 	dev->stop = &xircom_close;
@@ -280,19 +271,34 @@
 	SET_ETHTOOL_OPS(dev, &netdev_ethtool_ops);
 	pci_set_drvdata(pdev, dev);
 
+	if (register_netdev(dev)) {
+		printk(KERN_ERR "xircom_probe: netdevice registration failed.\n");
+		goto reg_fail;
+	}
+		
+	printk(KERN_INFO "%s: Xircom cardbus revision %i at irq %i \n", dev->name, chip_rev, pdev->irq);
 	/* start the transmitter to get a heartbeat */
 	/* TODO: send 2 dummy packets here */
-	tranceiver_voodoo(private);
-
+	transceiver_voodoo(private);
+	
 	spin_lock_irqsave(&private->lock,flags);
-	  activate_transmitter(private);
-	  activate_receiver(private);
+	activate_transmitter(private);
+	activate_receiver(private);
 	spin_unlock_irqrestore(&private->lock,flags);
-
+	
 	trigger_receive(private);
-
+	
 	leave("xircom_probe");
 	return 0;
+
+reg_fail:
+	kfree(private->tx_buffer);
+tx_buf_fail:
+	kfree(private->rx_buffer);
+rx_buf_fail:
+	free_netdev(dev);
+device_fail:
+	return -ENODEV;
 }
 
 
@@ -305,27 +311,20 @@
 static void __devexit xircom_remove(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
-	struct xircom_private *card;
+	struct xircom_private *card = dev->priv;
+
 	enter("xircom_remove");
-	if (dev!=NULL) {
-		card=dev->priv;
-		if (card!=NULL) {	
-			if (card->rx_buffer!=NULL)
-				pci_free_consistent(pdev,8192,card->rx_buffer,card->rx_dma_handle);
-			card->rx_buffer = NULL;
-			if (card->tx_buffer!=NULL)
-				pci_free_consistent(pdev,8192,card->tx_buffer,card->tx_dma_handle);
-			card->tx_buffer = NULL;			
-		}
-		kfree(card);
-	}
+	pci_free_consistent(pdev,8192,card->rx_buffer,card->rx_dma_handle);
+	pci_free_consistent(pdev,8192,card->tx_buffer,card->tx_dma_handle);
+
 	release_region(dev->base_addr, 128);
 	unregister_netdev(dev);
-	kfree(dev);
+	free_netdev(dev);
+	pci_set_drvdata(pdev, NULL);
 	leave("xircom_remove");
 } 
 
-static void xircom_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
+static irqreturn_t xircom_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
 {
 	struct net_device *dev = (struct net_device *) dev_instance;
 	struct xircom_private *card = (struct xircom_private *) dev->priv;
@@ -369,6 +368,7 @@
 	
 	spin_unlock(&card->lock);
 	leave("xircom_interrupt");
+	return IRQ_HANDLED;
 }
 
 static int xircom_start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -1022,7 +1022,7 @@
 
 
 /* 
-link_status() checks the link's status and will return 0 for no link, 10 for 10mbit link and 100 for.. guess what.
+link_status() checks the the links status and will return 0 for no link, 10 for 10mbit link and 100 for.. guess what.
 
 Must be called in locked state with interrupts disabled
 */
@@ -1097,15 +1097,15 @@
 
 
 /*
- tranceiver_voodoo() enables the external UTP plug thingy.
+ transceiver_voodoo() enables the external UTP plug thingy.
  it's called voodoo as I stole this code and cannot cross-reference
  it with the specification.
  */
-static void tranceiver_voodoo(struct xircom_private *card)
+static void transceiver_voodoo(struct xircom_private *card)
 {
 	unsigned long flags;
 
-	enter("tranceiver_voodoo");
+	enter("transceiver_voodoo");
 
 	/* disable all powermanagement */
 	pci_write_config_dword(card->pdev, PCI_POWERMGMT, 0x0000);
@@ -1124,7 +1124,7 @@
         spin_unlock_irqrestore(&card->lock, flags);
 
 	netif_start_queue(card->dev);
-	leave("tranceiver_voodoo");
+	leave("transceiver_voodoo");
 }
 
 
diff -Nru a/drivers/net/sk98lin/h/skversion.h b/drivers/net/sk98lin/h/skversion.h
--- a/drivers/net/sk98lin/h/skversion.h	Tue Oct 14 14:52:41 2003
+++ b/drivers/net/sk98lin/h/skversion.h	Tue Oct 14 14:52:41 2003
@@ -2,8 +2,8 @@
  *
  * Name:	version.h
  * Project:	GEnesis, PCI Gigabit Ethernet Adapter
- * Version:	$Revision: 1.2 $
- * Date:	$Date: 2003/08/13 12:01:01 $
+ * Version:	$Revision: 1.3 $
+ * Date:	$Date: 2003/08/25 13:34:48 $
  * Purpose:	SK specific Error log support
  *
  ******************************************************************************/
@@ -25,6 +25,9 @@
  *
  * History:
  *	$Log: skversion.h,v $
+ *	Revision 1.3  2003/08/25 13:34:48  mlindner
+ *	Fix: Lint changes
+ *	
  *	Revision 1.2  2003/08/13 12:01:01  mlindner
  *	Add: Changes for Lint
  *	
@@ -51,12 +54,12 @@
 #ifdef	lint
 static const char SysKonnectFileId[] = "@(#) (C) SysKonnect GmbH.";
 static const char SysKonnectBuildNumber[] =
-	"@(#)SK-BUILD: 6.17 PL: 01"; 
+	"@(#)SK-BUILD: 6.18 PL: 01"; 
 #endif	/* !defined(lint) */
 
-#define BOOT_STRING	"sk98lin: Network Device Driver v6.17\n" \
+#define BOOT_STRING	"sk98lin: Network Device Driver v6.18\n" \
 			"(C)Copyright 1999-2003 Marvell(R)."
 
-#define VER_STRING	"6.17"
+#define VER_STRING	"6.18"
 
 
diff -Nru a/drivers/net/sk98lin/skge.c b/drivers/net/sk98lin/skge.c
--- a/drivers/net/sk98lin/skge.c	Tue Oct 14 14:52:41 2003
+++ b/drivers/net/sk98lin/skge.c	Tue Oct 14 14:52:41 2003
@@ -56,6 +56,18 @@
  * History:
  *
  *	$Log: skge.c,v $
+ *	Revision 1.16  2003/09/23 11:07:35  mlindner
+ *	Fix: IO-control return race condition
+ *	Fix: Interrupt moderation value check
+ *	
+ *	Revision 1.15  2003/09/22 08:40:05  mlindner
+ *	Add: Added DRIVER_FILE_NAME and DRIVER_REL_DATE
+ *	
+ *	Revision 1.14  2003/09/22 08:11:10  mlindner
+ *	Add: New function for PCI initialization (SkGeInitPCI)
+ *	Add: Yukon Plus changes (ChipID, PCI...)
+ *	Fix: TCP and UDP Checksum calculation
+ *	
  *	Revision 1.11  2003/08/26 16:05:19  mlindner
  *	Fix: Compiler warnings (void *)
  *	
@@ -551,6 +563,7 @@
 static int	SkGeChangeMtu(struct SK_NET_DEVICE *dev, int new_mtu);
 static void	PortReInitBmu(SK_AC*, int);
 static int	SkGeIocMib(DEV_NET*, unsigned int, int);
+static int	SkGeInitPCI(SK_AC *pAC);
 static void	StartDrvCleanupTimer(SK_AC *pAC);
 static void	StopDrvCleanupTimer(SK_AC *pAC);
 static int	XmitFrameSG(SK_AC*, TX_PORT*, struct sk_buff*);
@@ -620,10 +633,10 @@
 	SK_AC			*pAC;
 	DEV_NET			*pNet = NULL;
 	struct pci_dev	*pdev = NULL;
-	unsigned long		base_address;
 	struct SK_NET_DEVICE *dev = NULL;
 	SK_BOOL DeviceFound = SK_FALSE;
 	SK_BOOL BootStringCount = SK_FALSE;
+	int			retval;
 #ifdef CONFIG_PROC_FS
 	int			proc_root_initialized = 0;
 	struct proc_dir_entry	*pProcFile;
@@ -668,6 +681,8 @@
 		pNet = dev->priv;
 		pNet->pAC = kmalloc(sizeof(SK_AC), GFP_KERNEL);
 		if (pNet->pAC == NULL){
+			dev->get_stats = NULL;
+			unregister_netdev(dev);
 			kfree(dev->priv);
 			printk(KERN_ERR "Unable to allocate adapter "
 			       "structure!\n");
@@ -694,6 +709,14 @@
 		pNet->Mtu = 1500;
 		pNet->Up = 0;
 		dev->irq = pdev->irq;
+		retval = SkGeInitPCI(pAC);
+		if (retval) {
+			printk("SKGE: PCI setup failed: %i\n", retval);
+			dev->get_stats = NULL;
+			unregister_netdev(dev);
+			kfree(dev);
+			continue;
+		}
 
 		dev->open =		&SkGeOpen;
 		dev->stop =		&SkGeClose;
@@ -716,41 +739,6 @@
 #endif
 #endif
 
-		/*
-		 * Dummy value.
-		 */
-		dev->base_addr = 42;
-		pci_set_master(pdev);
-
-		pci_set_master(pdev);
-		base_address = pci_resource_start (pdev, 0);
-
-#ifdef SK_BIG_ENDIAN
-		/*
-		 * On big endian machines, we use the adapter's aibility of
-		 * reading the descriptors as big endian.
-		 */
-		{
-		SK_U32		our2;
-			SkPciReadCfgDWord(pAC, PCI_OUR_REG_2, &our2);
-			our2 |= PCI_REV_DESC;
-			SkPciWriteCfgDWord(pAC, PCI_OUR_REG_2, our2);
-		}
-#endif
-
-		/*
-		 * Remap the regs into kernel space.
-		 */
-		pAC->IoBase = (char*)ioremap(base_address, 0x4000);
-
-		if (!pAC->IoBase){
-			printk(KERN_ERR "%s:  Unable to map I/O register, "
-			       "SK 98xx No. %i will be disabled.\n",
-			       dev->name, boards_found);
-			kfree(dev);
-			break;
-		}
-
 		pAC->Index = boards_found;
 		if (SkGeBoardInit(dev, pAC)) {
 			FreeResources(dev);
@@ -887,6 +875,68 @@
 } /* skge_probe */
 
 
+
+/*****************************************************************************
+ *
+ * 	SkGeInitPCI - Init the PCI resources
+ *
+ * Description:
+ *	This function initialize the PCI resources and IO
+ *
+ * Returns: N/A
+ *	
+ */
+int SkGeInitPCI(SK_AC *pAC)
+{
+	struct SK_NET_DEVICE *dev = pAC->dev[0];
+	struct pci_dev *pdev = pAC->PciDev;
+	int retval;
+
+	if (pci_enable_device(pdev) != 0) {
+		return 1;
+	}
+
+	dev->mem_start = pci_resource_start (pdev, 0);
+	pci_set_master(pdev);
+
+	if (pci_request_regions(pdev, pAC->Name) != 0) {
+		retval = 2;
+		goto out_disable;
+	}
+
+#ifdef SK_BIG_ENDIAN
+	/*
+	 * On big endian machines, we use the adapter's aibility of
+	 * reading the descriptors as big endian.
+	 */
+	{
+		SK_U32		our2;
+		SkPciReadCfgDWord(pAC, PCI_OUR_REG_2, &our2);
+		our2 |= PCI_REV_DESC;
+		SkPciWriteCfgDWord(pAC, PCI_OUR_REG_2, our2);
+	}
+#endif
+
+	/*
+	 * Remap the regs into kernel space.
+	 */
+	pAC->IoBase = (char*)ioremap_nocache(dev->mem_start, 0x4000);
+
+	if (!pAC->IoBase){
+		retval = 3;
+		goto out_release;
+	}
+
+	return 0;
+
+ out_release:
+	pci_release_regions(pdev);
+ out_disable:
+	pci_disable_device(pdev);
+	return retval;
+}
+
+
 /*****************************************************************************
  *
  * 	FreeResources - release resources allocated for adapter
@@ -908,6 +958,9 @@
 		pNet = (DEV_NET*) dev->priv;
 		pAC = pNet->pAC;
 		AllocFlag = pAC->AllocFlag;
+		if (pAC->PciDev) {
+			pci_release_regions(pAC->PciDev);
+		}
 		if (AllocFlag & SK_ALLOC_IRQ) {
 			free_irq(dev->irq, dev);
 		}
@@ -2172,7 +2225,7 @@
 	*/
 	if (BytesSend < C_LEN_ETHERNET_MINSIZE) {
 	    skb_put(pMessage, (C_LEN_ETHERNET_MINSIZE-BytesSend));
-	    memset( ((int *)(pMessage->data))+BytesSend,
+	    SK_MEMSET( ((char *)(pMessage->data))+BytesSend,
 	            0, C_LEN_ETHERNET_MINSIZE-BytesSend);
 	}
 
@@ -2205,10 +2258,12 @@
 
 	if (pMessage->ip_summed == CHECKSUM_HW) {
 		Protocol = ((SK_U8)pMessage->data[C_OFFSET_IPPROTO] & 0xff);
-		if ((Protocol == C_PROTO_ID_UDP) && (pAC->GIni.GIChipRev != 0)) {
-			pTxd->TBControl = BMU_UDP_CHECK;
+		if ((Protocol == C_PROTO_ID_UDP) && 
+			(pAC->GIni.GIChipRev == 0) &&
+			(pAC->GIni.GIChipId == CHIP_ID_YUKON)) {
+			pTxd->TBControl = BMU_TCP_CHECK;
 		} else {
-			pTxd->TBControl = BMU_TCP_CHECK ;
+			pTxd->TBControl = BMU_UDP_CHECK;
 		}
 
 		IpHeaderLength  = (SK_U8)pMessage->data[C_OFFSET_IPHEADER];
@@ -2232,7 +2287,7 @@
 #ifdef USE_TX_COMPLETE
 				   BMU_IRQ_EOF |
 #endif
-				   pMessage->len;
+			pMessage->len;
 	}
 
 	/* 
@@ -2333,10 +2388,12 @@
 		** (Revision 2.0)
 		*/
 		Protocol = ((SK_U8)pMessage->data[C_OFFSET_IPPROTO] & 0xff);
-		if ((Protocol == C_PROTO_ID_UDP) && (pAC->GIni.GIChipRev != 0)) {
-			pTxd->TBControl |= BMU_UDP_CHECK;
+		if ((Protocol == C_PROTO_ID_UDP) && 
+			(pAC->GIni.GIChipRev == 0) &&
+			(pAC->GIni.GIChipId == CHIP_ID_YUKON)) {
+			pTxd->TBControl |= BMU_TCP_CHECK;
 		} else {
-			pTxd->TBControl |= BMU_TCP_CHECK ;
+			pTxd->TBControl |= BMU_UDP_CHECK;
 		}
 
 		IpHeaderLength  = ((SK_U8)pMessage->data[C_OFFSET_IPHEADER] & 0xf)*4;
@@ -2383,11 +2440,12 @@
 			** opcode for udp is not working in the hardware yet 
 			** (revision 2.0)
 			*/
-			if ( (Protocol == C_PROTO_ID_UDP) && 
-			     (pAC->GIni.GIChipRev != 0) ) {
-				pTxd->TBControl |= BMU_UDP_CHECK ;
+			if ((Protocol == C_PROTO_ID_UDP) && 
+				(pAC->GIni.GIChipRev == 0) &&
+				(pAC->GIni.GIChipId == CHIP_ID_YUKON)) {
+				pTxd->TBControl |= BMU_TCP_CHECK;
 			} else {
-				pTxd->TBControl |= BMU_TCP_CHECK ;
+				pTxd->TBControl |= BMU_UDP_CHECK;
 			}
 		} else {
 			pTxd->TBControl = BMU_CHECK | BMU_SW | BMU_OWN;
@@ -3616,21 +3674,26 @@
 			Length = sizeof(pAC->PnmiStruct) + HeaderLength;
 		}
 		if (NULL == (pMemBuf = kmalloc(Length, GFP_KERNEL))) {
-			return -EFAULT;
+			return -ENOMEM;
 		}
 		if(copy_from_user(pMemBuf, Ioctl.pData, Length)) {
-			return -EFAULT;
+			Err = -EFAULT;
+			goto fault_gen;
 		}
 		if ((Ret = SkPnmiGenIoctl(pAC, pAC->IoBase, pMemBuf, &Length, 0)) < 0) {
-			return -EFAULT;
+			Err = -EFAULT;
+			goto fault_gen;
 		}
 		if(copy_to_user(Ioctl.pData, pMemBuf, Length) ) {
-			return -EFAULT;
+			Err = -EFAULT;
+			goto fault_gen;
 		}
 		Ioctl.Len = Length;
 		if(copy_to_user(rq->ifr_data, &Ioctl, sizeof(SK_GE_IOCTL))) {
-			return -EFAULT;
+			Err = -EFAULT;
+			goto fault_gen;
 		}
+fault_gen:
 		kfree(pMemBuf); /* cleanup everything */
 		break;
 	default:
@@ -4370,7 +4433,7 @@
         }
 
         if (IntsPerSec[pAC->Index] != 0) {
-           if ((IntsPerSec[pAC->Index]< 30)&&(IntsPerSec[pAC->Index]> 40000)) {
+           if ((IntsPerSec[pAC->Index]< 30) || (IntsPerSec[pAC->Index]> 40000)) {
               pAC->DynIrqModInfo.MaxModIntsPerSec = C_INTS_PER_SEC_DEFAULT;
            } else {
               pAC->DynIrqModInfo.MaxModIntsPerSec = IntsPerSec[pAC->Index];
diff -Nru a/drivers/net/tulip/tulip_core.c b/drivers/net/tulip/tulip_core.c
--- a/drivers/net/tulip/tulip_core.c	Tue Oct 14 14:52:41 2003
+++ b/drivers/net/tulip/tulip_core.c	Tue Oct 14 14:52:41 2003
@@ -229,6 +229,7 @@
 	{ 0x1186, 0x1561, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
 	{ 0x1626, 0x8410, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
 	{ 0x1737, 0xAB09, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
+	{ 0x1737, 0xAB08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
 	{ 0x17B3, 0xAB08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
 	{ 0x14f1, 0x1803, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CONEXANT },
 	{ 0x10b9, 0x5261, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DM910X },	/* ALi 1563 integrated ethernet */
diff -Nru a/include/linux/ethtool.h b/include/linux/ethtool.h
--- a/include/linux/ethtool.h	Tue Oct 14 14:52:41 2003
+++ b/include/linux/ethtool.h	Tue Oct 14 14:52:41 2003
@@ -303,14 +303,14 @@
  *
  * get_eeprom:
  *	Should fill in the magic field.  Don't need to check len for zero
- *	or wraparound but must check offset + len < size.  Fill in the data
- *	argument with the eeprom values from offset to offset + len.  Update
- *	len to the amount read.  Returns an error or zero.
+ *	or wraparound.  Fill in the data argument with the eeprom values
+ *	from offset to offset + len.  Update len to the amount read.
+ *	Returns an error or zero.
  *
  * set_eeprom:
  *	Should validate the magic field.  Don't need to check len for zero
- *	or wraparound but must check offset + len < size.  Update len to
- *	the amount written.  Returns an error or zero.
+ *	or wraparound.  Update len to the amount written.  Returns an error
+ *	or zero.
  */
 struct ethtool_ops {
 	int	(*get_settings)(struct net_device *, struct ethtool_cmd *);
@@ -324,6 +324,7 @@
 	void	(*set_msglevel)(struct net_device *, u32);
 	int	(*nway_reset)(struct net_device *);
 	u32	(*get_link)(struct net_device *);
+	int	(*get_eeprom_len)(struct net_device *);
 	int	(*get_eeprom)(struct net_device *, struct ethtool_eeprom *, u8 *);
 	int	(*set_eeprom)(struct net_device *, struct ethtool_eeprom *, u8 *);
 	int	(*get_coalesce)(struct net_device *, struct ethtool_coalesce *);
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Tue Oct 14 14:52:41 2003
+++ b/include/linux/pci_ids.h	Tue Oct 14 14:52:41 2003
@@ -1669,6 +1669,7 @@
 #define PCI_DEVICE_ID_TIGON3_5703A3	0x16c7
 #define PCI_DEVICE_ID_TIGON3_5901	0x170d
 #define PCI_DEVICE_ID_TIGON3_5901_2	0x170e
+#define PCI_DEVICE_ID_BCM4401		0x4401
 
 #define PCI_VENDOR_ID_SYBA		0x1592
 #define PCI_DEVICE_ID_SYBA_2P_EPP	0x0782
diff -Nru a/net/core/ethtool.c b/net/core/ethtool.c
--- a/net/core/ethtool.c	Tue Oct 14 14:52:41 2003
+++ b/net/core/ethtool.c	Tue Oct 14 14:52:41 2003
@@ -106,7 +106,8 @@
 		info.n_stats = ops->get_stats_count(dev);
 	if (ops->get_regs_len)
 		info.regdump_len = ops->get_regs_len(dev);
-	/* XXX: eeprom? */
+	if (ops->get_eeprom_len)
+		info.eedump_len = ops->get_eeprom_len(dev);
 
 	if (copy_to_user(useraddr, &info, sizeof(info)))
 		return -EFAULT;
@@ -229,29 +230,34 @@
 static int ethtool_get_eeprom(struct net_device *dev, void *useraddr)
 {
 	struct ethtool_eeprom eeprom;
+	struct ethtool_ops *ops = dev->ethtool_ops;
 	u8 *data;
-	int len, ret;
+	int ret;
 
-	if (!dev->ethtool_ops->get_eeprom)
+	if (!ops->get_eeprom || !ops->get_eeprom_len)
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&eeprom, useraddr, sizeof(eeprom)))
 		return -EFAULT;
 
-	len = eeprom.len;
 	/* Check for wrap and zero */
-	if (eeprom.offset + len <= eeprom.offset)
+	if (eeprom.offset + eeprom.len <= eeprom.offset)
+		return -EINVAL;
+
+	/* Check for exceeding total eeprom len */
+	if (eeprom.offset + eeprom.len > ops->get_eeprom_len(dev))
 		return -EINVAL;
 
-	data = kmalloc(len, GFP_USER);
+	data = kmalloc(eeprom.len, GFP_USER);
 	if (!data)
 		return -ENOMEM;
 
-	if (copy_from_user(data, useraddr + sizeof(eeprom), len))
-		return -EFAULT;
+	ret = -EFAULT;
+	if (copy_from_user(data, useraddr + sizeof(eeprom), eeprom.len))
+		goto out;
 
-	ret = dev->ethtool_ops->get_eeprom(dev, &eeprom, data);
-	if (!ret)
+	ret = ops->get_eeprom(dev, &eeprom, data);
+	if (ret)
 		goto out;
 
 	ret = -EFAULT;
@@ -269,32 +275,37 @@
 static int ethtool_set_eeprom(struct net_device *dev, void *useraddr)
 {
 	struct ethtool_eeprom eeprom;
+	struct ethtool_ops *ops = dev->ethtool_ops;
 	u8 *data;
-	int len, ret;
+	int ret;
 
-	if (!dev->ethtool_ops->set_eeprom)
+	if (!ops->set_eeprom || !ops->get_eeprom_len)
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&eeprom, useraddr, sizeof(eeprom)))
 		return -EFAULT;
 
-	len = eeprom.len;
 	/* Check for wrap and zero */
-	if (eeprom.offset + len <= eeprom.offset)
+	if (eeprom.offset + eeprom.len <= eeprom.offset)
+		return -EINVAL;
+
+	/* Check for exceeding total eeprom len */
+	if (eeprom.offset + eeprom.len > ops->get_eeprom_len(dev))
 		return -EINVAL;
 
-	data = kmalloc(len, GFP_USER);
+	data = kmalloc(eeprom.len, GFP_USER);
 	if (!data)
 		return -ENOMEM;
 
-	if (copy_from_user(data, useraddr + sizeof(eeprom), len))
-		return -EFAULT;
+	ret = -EFAULT;
+	if (copy_from_user(data, useraddr + sizeof(eeprom), eeprom.len))
+		goto out;
 
-	ret = dev->ethtool_ops->set_eeprom(dev, &eeprom, data);
+	ret = ops->set_eeprom(dev, &eeprom, data);
 	if (ret)
 		goto out;
 
-	if (copy_to_user(useraddr + sizeof(eeprom), data, len))
+	if (copy_to_user(useraddr + sizeof(eeprom), data, eeprom.len))
 		ret = -EFAULT;
 
  out:
