Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263497AbTJNTJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 15:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263536AbTJNTJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 15:09:28 -0400
Received: from havoc.gtf.org ([63.247.75.124]:22241 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263497AbTJNTIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 15:08:41 -0400
Date: Tue, 14 Oct 2003 15:06:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [BK PATCHES] 2.6.x net driver updates
Message-ID: <20031014190603.GA20087@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried to keep it to fixes, and created a separate queue
(net-drivers-2.[45]-exp) for non-fixes.

Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

This will update the following files:

 drivers/net/8139too.c           |    2 +
 drivers/net/Kconfig             |    4 +--
 drivers/net/b44.c               |   15 +++---------
 drivers/net/defxx.c             |    4 +--
 drivers/net/e1000/e1000_main.c  |   35 ++++++++++++++++++++++------
 drivers/net/hamradio/bpqether.c |    6 ----
 drivers/net/hamradio/scc.c      |    4 +--
 drivers/net/hp100.c             |   10 ++++----
 drivers/net/natsemi.c           |    2 -
 drivers/net/pcmcia/pcnet_cs.c   |   23 ++++++++++++------
 drivers/net/tulip/tulip_core.c  |    1 
 drivers/net/tulip/xircom_cb.c   |   35 ++++++++++++++--------------
 drivers/net/wireless/atmel.c    |    1 
 drivers/net/wireless/atmel_cs.c |   11 +++++---
 include/linux/ethtool.h         |   11 ++++----
 net/core/ethtool.c              |   49 ++++++++++++++++++++++++----------------
 16 files changed, 123 insertions(+), 90 deletions(-)

through these ChangeSets:

<pp@ee.oulu.fi> (03/10/14 1.1370)
   [PATCH] b44 enable interrupts after tx timeout (2.6-test version)
   
   Resending the patch I sent some time ago for b44.c that nukes the
   2.4 compatibility cruft as well.
   
   I'll do one for 2.4.23pre6 ASAP, hopefully being able sync the driver fully
   with the one in 2.6 (free_netdev() etc.).

<manfred@colorfullife.com> (03/10/14 1.1369)
   [netdrvr natsemi] fix ring clean
   
   Too much copy&paste in a call to pci_unmap_single.

<jgarzik@redhat.com> (03/10/14 1.1368)
   [netdrvr tulip] add pci id
   
   Contributed by Ken Zalewski.

<simon@thekelleys.org.uk> (03/10/14 1.1367)
   [PATCH] - atmel wireless driver
   
   1) Remove "#include <linux/version.h>" which was not needed and added
      bad extra compile dependencies.
   
   2) Fix typo in module description.
   
   3) Make card detection code cope with buggy SMC CIS entries.

<jgarzik@redhat.com> (03/10/14 1.1366)
   [netdrvr 8139too] another new PCI ID
   
   Contributed by Josh Litherland, Donald Becker, and others.

<jgarzik@redhat.com> (03/10/14 1.1365)
   [netdrvr 8139too] add pci id
   
   contributed by "JaReK" and Donald Becker.

<scott.feldman@intel.com> (03/10/14 1.1364)
   [PATCH] hang on ZEROCOPY/TSO when hitting no-Tx-resources
   
   * Critical bug fix: under heavy Tx stress using ZEROCOPY or TSO, if we
     ran out of Tx descriptors, we didn't calculate for the context
     descritor used as the first of the ZEROCOPY/TSO send, nor do we clean
     up the context desriptor bits in the case where the send isn't going
     to fit, where we need to undo the mappings.  This bug was introduced
     with the 5.2.16 patch set which included a workaround for a hang
     on 82544 over PCI-X.  This workaround cause the check for no-Tx-
     rosource logic to change, and this bug slipped in.

<ak@muc.de> (03/10/14 1.1363)
   [PATCH] Fix warnings in defxx.c
   
   Fix harmless 64bit warnings in defxx.c

<ak@muc.de> (03/10/14 1.1362)
   [PATCH] Fix warnings in hp100
   
   Fix some harmless integer/pointer size mismatch warnings in hp100.c
   on 64bit compiles

<ak@muc.de> (03/10/14 1.1361)
   [PATCH] Mark non 64bit clean network drivers
   
   This marks some net drivers which are clearly not 64bit (judging from
   the warnings) as !64BIT.
   
   -Andi

<pe1rxq@amsat.org> (03/10/14 1.1360)
   [hamradio bpqether] fix ancient debug line
   
   removes a verry old debug line from the bpqethernet driver that
   only fills logs.

<pe1rxq@amsat.org> (03/10/14 1.1359)
   [hamradio scc] fix probe function
   
   fix for the probe function of the scc driver which now uses
   an uninitialised scc struct for requesting an io region.

<scott.feldman@intel.com> (03/10/14 1.1358)
   [PATCH] ethtool_ops eeprom stuff
   
   Finally got around to adding ethtool_ops to e100-3.0.x.  I found a bug
   with get_eeprom() and it seems to work best if we add get_eeprom_len() to
   the ops list.  Also moved check for offest + len < size into ethtool.c.
   
   I was able to test [GS]EEPROM, PHYS_ID, GSTATS, GSTRINGS, and TEST, and
   everything looks good.
   
   Should I send same for 2.4?

<rmk+lkml@arm.linux.org.uk> (03/10/14 1.1357)
   [PATCH] Fix pcnet_cs network hotplug
   
   pcnet_cs registers the network device too early.  The effect of this
   is that the networking hotplug scripts are unable to bring the device
   up automatically.
   
   There are two issues:
   - we were registering the net device before we finished setting up
     the device (eg, reading the MAC address.)
   - we were using DEV_CONFIG_PENDING to block the net device "open"
     callback, and as we know the other methods may be called prior
     to open.
   
   My only concern with this patch is that we set info->node.dev_name
   after we register the net device, so use of cardctl during the
   hotplug scripts may give unexpected results.  However, I am not
   aware of anyone using cardctl to read the device name in network
   hotplug scripts.
   
   Please review and merge.  Thanks.

<shemminger@osdl.org> (03/10/14 1.1356)
   [netdrvr xircom_cb] fix race in statistics pointer setting
   by converting to use alloc_etherdev.



diff -Nru a/drivers/net/8139too.c b/drivers/net/8139too.c
--- a/drivers/net/8139too.c	Tue Oct 14 15:02:25 2003
+++ b/drivers/net/8139too.c	Tue Oct 14 15:02:25 2003
@@ -248,6 +248,8 @@
 	{0x14ea, 0xab06, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
 	{0x14ea, 0xab07, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
 	{0x11db, 0x1234, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
+	{0x1432, 0x9130, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
+	{0x02ac, 0x1012, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
 
 #ifdef CONFIG_SH_SECUREEDGE5410
 	/* Bogus 8139 silicon reports 8129 without external PROM :-( */
diff -Nru a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig	Tue Oct 14 15:02:25 2003
+++ b/drivers/net/Kconfig	Tue Oct 14 15:02:25 2003
@@ -1616,7 +1616,7 @@
 
 config TLAN
 	tristate "TI ThunderLAN support"
-	depends on NET_PCI && (PCI || EISA)
+	depends on NET_PCI && (PCI || EISA) && !64BIT
 	---help---
 	  If you have a PCI Ethernet network card based on the ThunderLAN chip
 	  which is supported by this driver, say Y and read the
@@ -2412,7 +2412,7 @@
 
 config RCPCI
 	tristate "Red Creek Hardware VPN (EXPERIMENTAL)"
-	depends on NETDEVICES && EXPERIMENTAL && PCI
+	depends on NETDEVICES && EXPERIMENTAL && PCI && !64BIT
 	help
 	  This is a driver for hardware which provides a Virtual Private
 	  Network (VPN). Say Y if you have it.
diff -Nru a/drivers/net/b44.c b/drivers/net/b44.c
--- a/drivers/net/b44.c	Tue Oct 14 15:02:25 2003
+++ b/drivers/net/b44.c	Tue Oct 14 15:02:25 2003
@@ -25,8 +25,8 @@
 
 #define DRV_MODULE_NAME		"b44"
 #define PFX DRV_MODULE_NAME	": "
-#define DRV_MODULE_VERSION	"0.9"
-#define DRV_MODULE_RELDATE	"Jul 14, 2003"
+#define DRV_MODULE_VERSION	"0.91"
+#define DRV_MODULE_RELDATE	"Oct 3, 2003"
 
 #define B44_DEF_MSG_ENABLE	  \
 	(NETIF_MSG_DRV		| \
@@ -80,15 +80,6 @@
 
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
 static struct pci_device_id b44_pci_tbl[] = {
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4401,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
@@ -869,6 +860,8 @@
 	b44_init_hw(bp);
 
 	spin_unlock_irq(&bp->lock);
+
+	b44_enable_ints(bp);
 
 	netif_wake_queue(dev);
 }
diff -Nru a/drivers/net/defxx.c b/drivers/net/defxx.c
--- a/drivers/net/defxx.c	Tue Oct 14 15:02:25 2003
+++ b/drivers/net/defxx.c	Tue Oct 14 15:02:25 2003
@@ -2664,8 +2664,8 @@
  
 static void my_skb_align(struct sk_buff *skb, int n)
 {
-	u32 x=(u32)skb->data;	/* We only want the low bits .. */
-	u32 v;
+	unsigned long x=(unsigned long)skb->data;	
+	unsigned long v;
 	
 	v=(x+n-1)&~(n-1);	/* Where we want to be */
 	
diff -Nru a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
--- a/drivers/net/e1000/e1000_main.c	Tue Oct 14 15:02:25 2003
+++ b/drivers/net/e1000/e1000_main.c	Tue Oct 14 15:02:25 2003
@@ -30,7 +30,7 @@
 
 /* Change Log
  *
- * 5.2.18	9/13/03
+ * 5.2.20	9/30/03
  *   o Bug fix: SERDES devices might be connected to a back-plane
  *     switch that doesn't support auto-neg, so add the capability
  *     to force 1000/Full.
@@ -39,6 +39,9 @@
  *     Jumbo Frames or with the reduced FIFO in 82547.
  *   o Better propagation of error codes. [Janice Girouard 
  *     (janiceg@us.ibm.com)].
+ *   o Bug fix: hang under heavy Tx stress when running out of Tx
+ *     descriptors; wasn't clearing context descriptor when backing
+ *     out of send because of no-resource condition.
  *
  * 5.2.16	8/8/03
  *   o Added support for new controllers: 82545GM, 82546GB, 82541/7_B1
@@ -61,7 +64,7 @@
 
 char e1000_driver_name[] = "e1000";
 char e1000_driver_string[] = "Intel(R) PRO/1000 Network Driver";
-char e1000_driver_version[] = "5.2.19-k1";
+char e1000_driver_version[] = "5.2.20-k1";
 char e1000_copyright[] = "Copyright (c) 1999-2003 Intel Corporation.";
 
 /* e1000_pci_tbl - PCI Device ID Table
@@ -1545,6 +1548,7 @@
 	unsigned int first)
 {
 	struct e1000_desc_ring *tx_ring = &adapter->tx_ring;
+	struct e1000_tx_desc *tx_desc;
 	struct e1000_buffer *buffer_info;
 	unsigned int len = skb->len, max_per_txd = E1000_MAX_DATA_PER_TXD;
 	unsigned int offset = 0, size, count = 0, i;
@@ -1640,17 +1644,29 @@
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
@@ -1658,8 +1674,11 @@
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
diff -Nru a/drivers/net/hamradio/bpqether.c b/drivers/net/hamradio/bpqether.c
--- a/drivers/net/hamradio/bpqether.c	Tue Oct 14 15:02:25 2003
+++ b/drivers/net/hamradio/bpqether.c	Tue Oct 14 15:02:25 2003
@@ -196,12 +196,8 @@
 	eth = (struct ethhdr *)skb->mac.raw;
 
 	if (!(bpq->acpt_addr[0] & 0x01) &&
-	    memcmp(eth->h_source, bpq->acpt_addr, ETH_ALEN)) {
-		if (net_ratelimit())
-			printk(KERN_DEBUG "bpqether: wrong dest %s\n",
-			       bpq_print_ethaddr(eth->h_source));
+	    memcmp(eth->h_source, bpq->acpt_addr, ETH_ALEN))
 		goto drop_unlock;
-	}
 
 	if (skb_cow(skb, sizeof(struct ethhdr)))
 		goto drop_unlock;
diff -Nru a/drivers/net/hamradio/scc.c b/drivers/net/hamradio/scc.c
--- a/drivers/net/hamradio/scc.c	Tue Oct 14 15:02:25 2003
+++ b/drivers/net/hamradio/scc.c	Tue Oct 14 15:02:25 2003
@@ -1762,7 +1762,7 @@
 
 #ifndef SCC_DONT_CHECK
 
-			if(request_region(scc->ctrl, 1, "scc-probe"))
+			if(request_region(hwcfg.ctrl_a, 1, "scc-probe"))
 			{
 				disable_irq(hwcfg.irq);
 				Outb(hwcfg.ctrl_a, 0);
@@ -1774,7 +1774,7 @@
 				if (InReg(hwcfg.ctrl_a,R13) != 0x55)
 					found = 0;
 				enable_irq(hwcfg.irq);
-				release_region(scc->ctrl, 1);
+				release_region(hwcfg.ctrl_a, 1);
 			}
 			else
 				found = 0;
diff -Nru a/drivers/net/hp100.c b/drivers/net/hp100.c
--- a/drivers/net/hp100.c	Tue Oct 14 15:02:25 2003
+++ b/drivers/net/hp100.c	Tue Oct 14 15:02:25 2003
@@ -1265,9 +1265,9 @@
 {
 	/* pdlptr is starting address for this pdl */
 
-	if (0 != (((unsigned) pdlptr) & 0xf))
-		printk("hp100: %s: Init rxpdl: Unaligned pdlptr 0x%x.\n",
-		       dev->name, (unsigned) pdlptr);
+	if (0 != (((unsigned long) pdlptr) & 0xf))
+		printk("hp100: %s: Init rxpdl: Unaligned pdlptr 0x%lx.\n",
+		       dev->name, (unsigned long) pdlptr);
 
 	ringptr->pdl = pdlptr + 1;
 	ringptr->pdl_paddr = virt_to_whatever(dev, pdlptr + 1);
@@ -1292,8 +1292,8 @@
 			    register hp100_ring_t * ringptr,
 			    register u32 * pdlptr)
 {
-	if (0 != (((unsigned) pdlptr) & 0xf))
-		printk("hp100: %s: Init txpdl: Unaligned pdlptr 0x%x.\n", dev->name, (unsigned) pdlptr);
+	if (0 != (((unsigned long) pdlptr) & 0xf))
+		printk("hp100: %s: Init txpdl: Unaligned pdlptr 0x%lx.\n", dev->name, (unsigned long) pdlptr);
 
 	ringptr->pdl = pdlptr;	/* +1; */
 	ringptr->pdl_paddr = virt_to_whatever(dev, pdlptr);	/* +1 */
diff -Nru a/drivers/net/natsemi.c b/drivers/net/natsemi.c
--- a/drivers/net/natsemi.c	Tue Oct 14 15:02:25 2003
+++ b/drivers/net/natsemi.c	Tue Oct 14 15:02:25 2003
@@ -1530,7 +1530,7 @@
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		if (np->tx_skbuff[i]) {
 			pci_unmap_single(np->pci_dev,
-				np->rx_dma[i], np->rx_skbuff[i]->len,
+				np->tx_dma[i], np->tx_skbuff[i]->len,
 				PCI_DMA_TODEVICE);
 			dev_kfree_skb(np->tx_skbuff[i]);
 			np->stats.tx_dropped++;
diff -Nru a/drivers/net/pcmcia/pcnet_cs.c b/drivers/net/pcmcia/pcnet_cs.c
--- a/drivers/net/pcmcia/pcnet_cs.c	Tue Oct 14 15:02:25 2003
+++ b/drivers/net/pcmcia/pcnet_cs.c	Tue Oct 14 15:02:25 2003
@@ -681,10 +681,6 @@
     } else {
 	dev->if_port = 0;
     }
-    if (register_netdev(dev) != 0) {
-	printk(KERN_NOTICE "pcnet_cs: register_netdev() failed\n");
-	goto failed;
-    }
 
     hw_info = get_hwinfo(link);
     if (hw_info == NULL)
@@ -699,7 +695,6 @@
     if (hw_info == NULL) {
 	printk(KERN_NOTICE "pcnet_cs: unable to read hardware net"
 	       " address for io base %#3lx\n", dev->base_addr);
-	unregister_netdev(dev);
 	goto failed;
     }
 
@@ -733,8 +728,6 @@
     ei_status.word16 = 1;
     ei_status.reset_8390 = &pcnet_reset_8390;
 
-    strcpy(info->node.dev_name, dev->name);
-    link->dev = &info->node;
     SET_ETHTOOL_OPS(dev, &netdev_ethtool_ops);
 
     if (info->flags & (IS_DL10019|IS_DL10022)) {
@@ -743,6 +736,21 @@
 	mii_phy_probe(dev);
 	if ((id == 0x30) && !info->pna_phy && (info->eth_phy == 4))
 	    info->eth_phy = 0;
+    }
+
+    link->dev = &info->node;
+    link->state &= ~DEV_CONFIG_PENDING;
+
+    if (register_netdev(dev) != 0) {
+	printk(KERN_NOTICE "pcnet_cs: register_netdev() failed\n");
+	link->dev = NULL;
+	goto failed;
+    }
+
+    strcpy(info->node.dev_name, dev->name);
+
+    if (info->flags & (IS_DL10019|IS_DL10022)) {
+	u_char id = inb(dev->base_addr + 0x1a);
 	printk(KERN_INFO "%s: NE2000 (DL100%d rev %02x): ",
 	       dev->name, ((info->flags & IS_DL10022) ? 22 : 19), id);
 	if (info->pna_phy)
@@ -758,7 +766,6 @@
     printk(" hw_addr ");
     for (i = 0; i < 6; i++)
 	printk("%02X%s", dev->dev_addr[i], ((i<5) ? ":" : "\n"));
-    link->state &= ~DEV_CONFIG_PENDING;
     return;
 
 cs_failed:
diff -Nru a/drivers/net/tulip/tulip_core.c b/drivers/net/tulip/tulip_core.c
--- a/drivers/net/tulip/tulip_core.c	Tue Oct 14 15:02:25 2003
+++ b/drivers/net/tulip/tulip_core.c	Tue Oct 14 15:02:25 2003
@@ -224,6 +224,7 @@
 	{ 0x1186, 0x1561, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
 	{ 0x1626, 0x8410, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
 	{ 0x1737, 0xAB09, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
+	{ 0x1737, 0xAB08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
 	{ 0x17B3, 0xAB08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
  	{ 0x10b9, 0x5261, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DM910X },	/* ALi 1563 integrated ethernet */
 	{ 0x10b7, 0x9300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET }, /* 3Com 3CSOHO100B-TX */
diff -Nru a/drivers/net/tulip/xircom_cb.c b/drivers/net/tulip/xircom_cb.c
--- a/drivers/net/tulip/xircom_cb.c	Tue Oct 14 15:02:25 2003
+++ b/drivers/net/tulip/xircom_cb.c	Tue Oct 14 15:02:25 2003
@@ -230,7 +230,8 @@
 	   This way, we can fail gracefully if not enough memory
 	   is available. 
 	 */
-	if ((dev = init_etherdev(NULL, sizeof(struct xircom_private))) == NULL) {
+	dev = alloc_etherdev(sizeof(struct xircom_private));
+	if (!dev) {
 		printk(KERN_ERR "xircom_probe: failed to allocate etherdev\n");
 		goto device_fail;
 	}
@@ -250,7 +251,7 @@
 
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
-	printk(KERN_INFO "%s: Xircom cardbus revision %i at irq %i \n", dev->name, chip_rev, pdev->irq);
+
 
 	private->dev = dev;
 	private->pdev = pdev;
@@ -259,7 +260,6 @@
 	dev->irq = pdev->irq;
 	dev->base_addr = private->io_port;
 	
-	
 	initialize_card(private);
 	read_mac_address(private);
 	setup_descriptors(private);
@@ -272,7 +272,12 @@
 	SET_ETHTOOL_OPS(dev, &netdev_ethtool_ops);
 	pci_set_drvdata(pdev, dev);
 
-	
+	if (register_netdev(dev)) {
+		printk(KERN_ERR "xircom_probe: netdevice registration failed.\n");
+		goto reg_fail;
+	}
+		
+	printk(KERN_INFO "%s: Xircom cardbus revision %i at irq %i \n", dev->name, chip_rev, pdev->irq);
 	/* start the transmitter to get a heartbeat */
 	/* TODO: send 2 dummy packets here */
 	transceiver_voodoo(private);
@@ -287,10 +292,12 @@
 	leave("xircom_probe");
 	return 0;
 
+reg_fail:
+	kfree(private->tx_buffer);
 tx_buf_fail:
 	kfree(private->rx_buffer);
 rx_buf_fail:
-	kfree(dev);
+	free_netdev(dev);
 device_fail:
 	return -ENODEV;
 }
@@ -305,22 +312,16 @@
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
-	}
+	pci_free_consistent(pdev,8192,card->rx_buffer,card->rx_dma_handle);
+	pci_free_consistent(pdev,8192,card->tx_buffer,card->tx_dma_handle);
+
 	release_region(dev->base_addr, 128);
 	unregister_netdev(dev);
 	free_netdev(dev);
+	pci_set_drvdata(pdev, NULL);
 	leave("xircom_remove");
 } 
 
diff -Nru a/drivers/net/wireless/atmel.c b/drivers/net/wireless/atmel.c
--- a/drivers/net/wireless/atmel.c	Tue Oct 14 15:02:25 2003
+++ b/drivers/net/wireless/atmel.c	Tue Oct 14 15:02:25 2003
@@ -37,7 +37,6 @@
 ******************************************************************************/
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/init.h>
 
 #include <linux/kernel.h>
diff -Nru a/drivers/net/wireless/atmel_cs.c b/drivers/net/wireless/atmel_cs.c
--- a/drivers/net/wireless/atmel_cs.c	Tue Oct 14 15:02:25 2003
+++ b/drivers/net/wireless/atmel_cs.c	Tue Oct 14 15:02:25 2003
@@ -84,7 +84,7 @@
 static int irq_list[4] = { -1 };
 
 MODULE_AUTHOR("Simon Kelley");
-MODULE_DESCRIPTION("Support for Atmel at76c50x 802.11 wireless ethnet cards.");
+MODULE_DESCRIPTION("Support for Atmel at76c50x 802.11 wireless ethernet cards.");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("Atmel at76c50x PCMCIA cards");
 MODULE_PARM(irq_mask, "i");
@@ -404,9 +404,12 @@
 					goto mismatch;
 				for (k = 0; k < j; k++) {
 					while ((*p != '\0') && (*p != '/')) p++;
-					if (*p == '\0')
-						goto mismatch;
-					p++;
+					if (*p == '\0') {
+						if (*q != '\0')
+							goto mismatch;
+					} else {
+						p++;
+					}
 				}
 				while((*q != '\0') && (*p != '\0') && 
 				      (*p != '/') && (*p == *q)) p++, q++;
diff -Nru a/include/linux/ethtool.h b/include/linux/ethtool.h
--- a/include/linux/ethtool.h	Tue Oct 14 15:02:25 2003
+++ b/include/linux/ethtool.h	Tue Oct 14 15:02:25 2003
@@ -307,14 +307,14 @@
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
@@ -328,6 +328,7 @@
 	void	(*set_msglevel)(struct net_device *, u32);
 	int	(*nway_reset)(struct net_device *);
 	u32	(*get_link)(struct net_device *);
+	int	(*get_eeprom_len)(struct net_device *);
 	int	(*get_eeprom)(struct net_device *, struct ethtool_eeprom *, u8 *);
 	int	(*set_eeprom)(struct net_device *, struct ethtool_eeprom *, u8 *);
 	int	(*get_coalesce)(struct net_device *, struct ethtool_coalesce *);
diff -Nru a/net/core/ethtool.c b/net/core/ethtool.c
--- a/net/core/ethtool.c	Tue Oct 14 15:02:25 2003
+++ b/net/core/ethtool.c	Tue Oct 14 15:02:25 2003
@@ -122,7 +122,8 @@
 		info.n_stats = ops->get_stats_count(dev);
 	if (ops->get_regs_len)
 		info.regdump_len = ops->get_regs_len(dev);
-	/* XXX: eeprom? */
+	if (ops->get_eeprom_len)
+		info.eedump_len = ops->get_eeprom_len(dev);
 
 	if (copy_to_user(useraddr, &info, sizeof(info)))
 		return -EFAULT;
@@ -245,29 +246,34 @@
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
@@ -285,32 +291,37 @@
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
