Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWAIRKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWAIRKg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbWAIRKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:10:36 -0500
Received: from havoc.gtf.org ([69.61.125.42]:7315 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030185AbWAIRKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:10:34 -0500
Date: Mon, 9 Jan 2006 12:10:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x net driver updates
Message-ID: <20060109171032.GA25768@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 Documentation/networking/bonding.txt |    2 
 MAINTAINERS                          |    1 
 drivers/net/3c503.c                  |   16 +--
 drivers/net/Kconfig                  |    4 
 drivers/net/ac3200.c                 |   16 +--
 drivers/net/bonding/bonding.h        |    8 -
 drivers/net/e1000/e1000_param.c      |   10 +-
 drivers/net/e2100.c                  |   14 +-
 drivers/net/es3210.c                 |   14 +-
 drivers/net/forcedeth.c              |  164 +++++++++++++++++++++--------------
 drivers/net/gianfar.h                |    4 
 drivers/net/hp-plus.c                |   12 +-
 drivers/net/hp.c                     |   12 +-
 drivers/net/ibm_emac/ibm_emac.h      |    3 
 drivers/net/ibm_emac/ibm_emac_core.c |    2 
 drivers/net/lance.c                  |   22 ++--
 drivers/net/lne390.c                 |   14 +-
 drivers/net/mv643xx_eth.c            |    2 
 drivers/net/ne.c                     |   18 +--
 drivers/net/ne2.c                    |   16 +--
 drivers/net/sk98lin/skge.c           |  129 ++++++++++++++++-----------
 drivers/net/smc-ultra.c              |   24 ++---
 drivers/net/tulip/tulip_core.c       |    2 
 drivers/net/wd.c                     |   14 +-
 drivers/net/wireless/ipw2100.c       |    5 -
 net/ieee80211/ieee80211_crypt_wep.c  |   61 +++++++++----
 net/ieee80211/ieee80211_tx.c         |    2 
 net/ieee80211/ieee80211_wx.c         |    2 
 28 files changed, 341 insertions(+), 252 deletions(-)

Adrian Bunk:
      drivers/net/Kconfig: indentation fix
      drivers/net/bonding/bonding.h: "extern inline" -> "static inline"
      drivers/net/gianfar.h: "extern inline" -> "static inline"

Ayaz Abdulla:
      forcedeth: TSO fix for large buffers

Christoph Dworzak:
      tulip: enable multiport NIC BIOS fixups for x86_64

Dan Williams:
      [patch] ipw2100: support WEXT-18 enc_capa v3

Denis Vlasenko:
      fix a few "warning: 'cleanup_card' defined but not used"

Eric Paris:
      update bonding.txt to not show ip address on slaves

Eugene Surovegin:
      PPC44x EMAC driver: disable TX status deferral in half-duplex mode

Franck:
      Add MIPS dependency for dm9000 driver

Johannes Berg:
      ieee80211: enable hw wep where host has to build IV

Kenji Kaneshige:
      e1000: Fix invalid memory reference

Olaf Hering:
      remove bouncing mail address of mv643xx_eth maintainer

Stephen Hemminger:
      sk98lin: routine called from probe marked __init
      sk98lin: not doing high dma properly
      sk98lin: error handling on dual port board
      sk98lin: use kzalloc
      sk98lin: error handling on probe
      sk98lin: error handling of pci setup

diff --git a/Documentation/networking/bonding.txt b/Documentation/networking/bonding.txt
index b0fe41d..8d8b4e5 100644
--- a/Documentation/networking/bonding.txt
+++ b/Documentation/networking/bonding.txt
@@ -945,7 +945,6 @@ bond0     Link encap:Ethernet  HWaddr 00
           collisions:0 txqueuelen:0
 
 eth0      Link encap:Ethernet  HWaddr 00:C0:F0:1F:37:B4
-          inet addr:XXX.XXX.XXX.YYY  Bcast:XXX.XXX.XXX.255  Mask:255.255.252.0
           UP BROADCAST RUNNING SLAVE MULTICAST  MTU:1500  Metric:1
           RX packets:3573025 errors:0 dropped:0 overruns:0 frame:0
           TX packets:1643167 errors:1 dropped:0 overruns:1 carrier:0
@@ -953,7 +952,6 @@ eth0      Link encap:Ethernet  HWaddr 00
           Interrupt:10 Base address:0x1080
 
 eth1      Link encap:Ethernet  HWaddr 00:C0:F0:1F:37:B4
-          inet addr:XXX.XXX.XXX.YYY  Bcast:XXX.XXX.XXX.255  Mask:255.255.252.0
           UP BROADCAST RUNNING SLAVE MULTICAST  MTU:1500  Metric:1
           RX packets:3651769 errors:0 dropped:0 overruns:0 frame:0
           TX packets:1643480 errors:0 dropped:0 overruns:0 carrier:0
diff --git a/MAINTAINERS b/MAINTAINERS
index 76dc820..270e28c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1697,7 +1697,6 @@ S: Maintained
 
 MARVELL MV64340 ETHERNET DRIVER
 P:	Manish Lachwani
-M:	Manish_Lachwani@pmc-sierra.com
 L:	linux-mips@linux-mips.org
 L:	netdev@vger.kernel.org
 S:	Supported
diff --git a/drivers/net/3c503.c b/drivers/net/3c503.c
index 5c5eebd..dcc98af 100644
--- a/drivers/net/3c503.c
+++ b/drivers/net/3c503.c
@@ -148,14 +148,6 @@ el2_pio_probe(struct net_device *dev)
     return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	/* NB: el2_close() handles free_irq */
-	release_region(dev->base_addr, EL2_IO_EXTENT);
-	if (ei_status.mem)
-		iounmap(ei_status.mem);
-}
-
 #ifndef MODULE
 struct net_device * __init el2_probe(int unit)
 {
@@ -726,6 +718,14 @@ init_module(void)
 	return -ENXIO;
 }
 
+static void cleanup_card(struct net_device *dev)
+{
+	/* NB: el2_close() handles free_irq */
+	release_region(dev->base_addr, EL2_IO_EXTENT);
+	if (ei_status.mem)
+		iounmap(ei_status.mem);
+}
+
 void
 cleanup_module(void)
 {
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 1960961..733bc25 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -129,7 +129,7 @@ config NET_SB1000
 
 	  If you don't have this card, of course say N.
 
-	source "drivers/net/arcnet/Kconfig"
+source "drivers/net/arcnet/Kconfig"
 
 source "drivers/net/phy/Kconfig"
 
@@ -844,7 +844,7 @@ config SMC9194
 
 config DM9000
 	tristate "DM9000 support"
-	depends on ARM && NET_ETHERNET
+	depends on (ARM || MIPS) && NET_ETHERNET
 	select CRC32
 	select MII
 	---help---
diff --git a/drivers/net/ac3200.c b/drivers/net/ac3200.c
index 8a0af54..7952dc6 100644
--- a/drivers/net/ac3200.c
+++ b/drivers/net/ac3200.c
@@ -123,14 +123,6 @@ static int __init do_ac3200_probe(struct
 	return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	/* Someday free_irq may be in ac_close_card() */
-	free_irq(dev->irq, dev);
-	release_region(dev->base_addr, AC_IO_EXTENT);
-	iounmap(ei_status.mem);
-}
-
 #ifndef MODULE
 struct net_device * __init ac3200_probe(int unit)
 {
@@ -406,6 +398,14 @@ init_module(void)
 	return -ENXIO;
 }
 
+static void cleanup_card(struct net_device *dev)
+{
+	/* Someday free_irq may be in ac_close_card() */
+	free_irq(dev->irq, dev);
+	release_region(dev->base_addr, AC_IO_EXTENT);
+	iounmap(ei_status.mem);
+}
+
 void
 cleanup_module(void)
 {
diff --git a/drivers/net/bonding/bonding.h b/drivers/net/bonding/bonding.h
index 015c7f1..f20bb85 100644
--- a/drivers/net/bonding/bonding.h
+++ b/drivers/net/bonding/bonding.h
@@ -205,7 +205,7 @@ struct bonding {
  *
  * Caller must hold bond lock for read
  */
-extern inline struct slave *bond_get_slave_by_dev(struct bonding *bond, struct net_device *slave_dev)
+static inline struct slave *bond_get_slave_by_dev(struct bonding *bond, struct net_device *slave_dev)
 {
 	struct slave *slave = NULL;
 	int i;
@@ -219,7 +219,7 @@ extern inline struct slave *bond_get_sla
 	return slave;
 }
 
-extern inline struct bonding *bond_get_bond_by_slave(struct slave *slave)
+static inline struct bonding *bond_get_bond_by_slave(struct slave *slave)
 {
 	if (!slave || !slave->dev->master) {
 		return NULL;
@@ -228,13 +228,13 @@ extern inline struct bonding *bond_get_b
 	return (struct bonding *)slave->dev->master->priv;
 }
 
-extern inline void bond_set_slave_inactive_flags(struct slave *slave)
+static inline void bond_set_slave_inactive_flags(struct slave *slave)
 {
 	slave->state = BOND_STATE_BACKUP;
 	slave->dev->flags |= IFF_NOARP;
 }
 
-extern inline void bond_set_slave_active_flags(struct slave *slave)
+static inline void bond_set_slave_active_flags(struct slave *slave)
 {
 	slave->state = BOND_STATE_ACTIVE;
 	slave->dev->flags &= ~IFF_NOARP;
diff --git a/drivers/net/e1000/e1000_param.c b/drivers/net/e1000/e1000_param.c
index 38695d5..ccbbe5a 100644
--- a/drivers/net/e1000/e1000_param.c
+++ b/drivers/net/e1000/e1000_param.c
@@ -545,7 +545,7 @@ e1000_check_fiber_options(struct e1000_a
 static void __devinit
 e1000_check_copper_options(struct e1000_adapter *adapter)
 {
-	int speed, dplx;
+	int speed, dplx, an;
 	int bd = adapter->bd_number;
 
 	{ /* Speed */
@@ -641,8 +641,12 @@ e1000_check_copper_options(struct e1000_
 					 .p = an_list }}
 		};
 
-		int an = AutoNeg[bd];
-		e1000_validate_option(&an, &opt, adapter);
+		if (num_AutoNeg > bd) {
+			an = AutoNeg[bd];
+			e1000_validate_option(&an, &opt, adapter);
+		} else {
+			an = opt.def;
+		}
 		adapter->hw.autoneg_advertised = an;
 	}
 
diff --git a/drivers/net/e2100.c b/drivers/net/e2100.c
index f5a4dd7..e5c5cd2 100644
--- a/drivers/net/e2100.c
+++ b/drivers/net/e2100.c
@@ -140,13 +140,6 @@ static int  __init do_e2100_probe(struct
 	return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	/* NB: e21_close() handles free_irq */
-	iounmap(ei_status.mem);
-	release_region(dev->base_addr, E21_IO_EXTENT);
-}
-
 #ifndef MODULE
 struct net_device * __init e2100_probe(int unit)
 {
@@ -463,6 +456,13 @@ init_module(void)
 	return -ENXIO;
 }
 
+static void cleanup_card(struct net_device *dev)
+{
+	/* NB: e21_close() handles free_irq */
+	iounmap(ei_status.mem);
+	release_region(dev->base_addr, E21_IO_EXTENT);
+}
+
 void
 cleanup_module(void)
 {
diff --git a/drivers/net/es3210.c b/drivers/net/es3210.c
index 50f8e23..6b0ab1e 100644
--- a/drivers/net/es3210.c
+++ b/drivers/net/es3210.c
@@ -155,13 +155,6 @@ static int __init do_es_probe(struct net
 	return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	free_irq(dev->irq, dev);
-	release_region(dev->base_addr, ES_IO_EXTENT);
-	iounmap(ei_status.mem);
-}
-
 #ifndef MODULE
 struct net_device * __init es_probe(int unit)
 {
@@ -456,6 +449,13 @@ init_module(void)
 	return -ENXIO;
 }
 
+static void cleanup_card(struct net_device *dev)
+{
+	free_irq(dev->irq, dev);
+	release_region(dev->base_addr, ES_IO_EXTENT);
+	iounmap(ei_status.mem);
+}
+
 void
 cleanup_module(void)
 {
diff --git a/drivers/net/forcedeth.c b/drivers/net/forcedeth.c
index c39344a..3682ec6 100644
--- a/drivers/net/forcedeth.c
+++ b/drivers/net/forcedeth.c
@@ -101,6 +101,7 @@
  *	0.46: 20 Oct 2005: Add irq optimization modes.
  *	0.47: 26 Oct 2005: Add phyaddr 0 in phy scan.
  *	0.48: 24 Dec 2005: Disable TSO, bugfix for pci_map_single
+ *	0.49: 10 Dec 2005: Fix tso for large buffers.
  *
  * Known bugs:
  * We suspect that on some hardware no TX done interrupts are generated.
@@ -112,7 +113,7 @@
  * DEV_NEED_TIMERIRQ will not harm you on sane hardware, only generating a few
  * superfluous timer interrupts from the nic.
  */
-#define FORCEDETH_VERSION		"0.48"
+#define FORCEDETH_VERSION		"0.49"
 #define DRV_NAME			"forcedeth"
 
 #include <linux/module.h>
@@ -349,6 +350,8 @@ typedef union _ring_type {
 #define NV_TX2_VALID		(1<<31)
 #define NV_TX2_TSO		(1<<28)
 #define NV_TX2_TSO_SHIFT	14
+#define NV_TX2_TSO_MAX_SHIFT	14
+#define NV_TX2_TSO_MAX_SIZE	(1<<NV_TX2_TSO_MAX_SHIFT)
 #define NV_TX2_CHECKSUM_L3	(1<<27)
 #define NV_TX2_CHECKSUM_L4	(1<<26)
 
@@ -408,15 +411,15 @@ typedef union _ring_type {
 #define NV_WATCHDOG_TIMEO	(5*HZ)
 
 #define RX_RING		128
-#define TX_RING		64
+#define TX_RING		256
 /* 
  * If your nic mysteriously hangs then try to reduce the limits
  * to 1/0: It might be required to set NV_TX_LASTPACKET in the
  * last valid ring entry. But this would be impossible to
  * implement - probably a disassembly error.
  */
-#define TX_LIMIT_STOP	63
-#define TX_LIMIT_START	62
+#define TX_LIMIT_STOP	255
+#define TX_LIMIT_START	254
 
 /* rx/tx mac addr + type + vlan + align + slack*/
 #define NV_RX_HEADERS		(64)
@@ -535,6 +538,7 @@ struct fe_priv {
 	unsigned int next_tx, nic_tx;
 	struct sk_buff *tx_skbuff[TX_RING];
 	dma_addr_t tx_dma[TX_RING];
+	unsigned int tx_dma_len[TX_RING];
 	u32 tx_flags;
 };
 
@@ -935,6 +939,7 @@ static void nv_init_tx(struct net_device
 	        else
 			np->tx_ring.ex[i].FlagLen = 0;
 		np->tx_skbuff[i] = NULL;
+		np->tx_dma[i] = 0;
 	}
 }
 
@@ -945,30 +950,27 @@ static int nv_init_ring(struct net_devic
 	return nv_alloc_rx(dev);
 }
 
-static void nv_release_txskb(struct net_device *dev, unsigned int skbnr)
+static int nv_release_txskb(struct net_device *dev, unsigned int skbnr)
 {
 	struct fe_priv *np = netdev_priv(dev);
-	struct sk_buff *skb = np->tx_skbuff[skbnr];
-	unsigned int j, entry, fragments;
-			
-	dprintk(KERN_INFO "%s: nv_release_txskb for skbnr %d, skb %p\n",
-		dev->name, skbnr, np->tx_skbuff[skbnr]);
-	
-	entry = skbnr;
-	if ((fragments = skb_shinfo(skb)->nr_frags) != 0) {
-		for (j = fragments; j >= 1; j--) {
-			skb_frag_t *frag = &skb_shinfo(skb)->frags[j-1];
-			pci_unmap_page(np->pci_dev, np->tx_dma[entry],
-				       frag->size,
-				       PCI_DMA_TODEVICE);
-			entry = (entry - 1) % TX_RING;
-		}
+
+	dprintk(KERN_INFO "%s: nv_release_txskb for skbnr %d\n",
+		dev->name, skbnr);
+
+	if (np->tx_dma[skbnr]) {
+		pci_unmap_page(np->pci_dev, np->tx_dma[skbnr],
+			       np->tx_dma_len[skbnr],
+			       PCI_DMA_TODEVICE);
+		np->tx_dma[skbnr] = 0;
+	}
+
+	if (np->tx_skbuff[skbnr]) {
+		dev_kfree_skb_irq(np->tx_skbuff[skbnr]);
+		np->tx_skbuff[skbnr] = NULL;
+		return 1;
+	} else {
+		return 0;
 	}
-	pci_unmap_single(np->pci_dev, np->tx_dma[entry],
-			 skb->len - skb->data_len,
-			 PCI_DMA_TODEVICE);
-	dev_kfree_skb_irq(skb);
-	np->tx_skbuff[skbnr] = NULL;
 }
 
 static void nv_drain_tx(struct net_device *dev)
@@ -981,10 +983,8 @@ static void nv_drain_tx(struct net_devic
 			np->tx_ring.orig[i].FlagLen = 0;
 		else
 			np->tx_ring.ex[i].FlagLen = 0;
-		if (np->tx_skbuff[i]) {
-			nv_release_txskb(dev, i);
+		if (nv_release_txskb(dev, i))
 			np->stats.tx_dropped++;
-		}
 	}
 }
 
@@ -1021,68 +1021,105 @@ static void drain_ring(struct net_device
 static int nv_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct fe_priv *np = netdev_priv(dev);
+	u32 tx_flags = 0;
 	u32 tx_flags_extra = (np->desc_ver == DESC_VER_1 ? NV_TX_LASTPACKET : NV_TX2_LASTPACKET);
 	unsigned int fragments = skb_shinfo(skb)->nr_frags;
-	unsigned int nr = (np->next_tx + fragments) % TX_RING;
+	unsigned int nr = (np->next_tx - 1) % TX_RING;
+	unsigned int start_nr = np->next_tx % TX_RING;
 	unsigned int i;
+	u32 offset = 0;
+	u32 bcnt;
+	u32 size = skb->len-skb->data_len;
+	u32 entries = (size >> NV_TX2_TSO_MAX_SHIFT) + ((size & (NV_TX2_TSO_MAX_SIZE-1)) ? 1 : 0);
+
+	/* add fragments to entries count */
+	for (i = 0; i < fragments; i++) {
+		entries += (skb_shinfo(skb)->frags[i].size >> NV_TX2_TSO_MAX_SHIFT) +
+			   ((skb_shinfo(skb)->frags[i].size & (NV_TX2_TSO_MAX_SIZE-1)) ? 1 : 0);
+	}
 
 	spin_lock_irq(&np->lock);
 
-	if ((np->next_tx - np->nic_tx + fragments) > TX_LIMIT_STOP) {
+	if ((np->next_tx - np->nic_tx + entries - 1) > TX_LIMIT_STOP) {
 		spin_unlock_irq(&np->lock);
 		netif_stop_queue(dev);
 		return NETDEV_TX_BUSY;
 	}
 
-	np->tx_skbuff[nr] = skb;
-	
-	if (fragments) {
-		dprintk(KERN_DEBUG "%s: nv_start_xmit: buffer contains %d fragments\n", dev->name, fragments);
-		/* setup descriptors in reverse order */
-		for (i = fragments; i >= 1; i--) {
-			skb_frag_t *frag = &skb_shinfo(skb)->frags[i-1];
-			np->tx_dma[nr] = pci_map_page(np->pci_dev, frag->page, frag->page_offset, frag->size,
-							PCI_DMA_TODEVICE);
+	/* setup the header buffer */
+	do {
+		bcnt = (size > NV_TX2_TSO_MAX_SIZE) ? NV_TX2_TSO_MAX_SIZE : size;
+		nr = (nr + 1) % TX_RING;
+
+		np->tx_dma[nr] = pci_map_single(np->pci_dev, skb->data + offset, bcnt,
+						PCI_DMA_TODEVICE);
+		np->tx_dma_len[nr] = bcnt;
+
+		if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2) {
+			np->tx_ring.orig[nr].PacketBuffer = cpu_to_le32(np->tx_dma[nr]);
+			np->tx_ring.orig[nr].FlagLen = cpu_to_le32((bcnt-1) | tx_flags);
+		} else {
+			np->tx_ring.ex[nr].PacketBufferHigh = cpu_to_le64(np->tx_dma[nr]) >> 32;
+			np->tx_ring.ex[nr].PacketBufferLow = cpu_to_le64(np->tx_dma[nr]) & 0x0FFFFFFFF;
+			np->tx_ring.ex[nr].FlagLen = cpu_to_le32((bcnt-1) | tx_flags);
+		}
+		tx_flags = np->tx_flags;
+		offset += bcnt;
+		size -= bcnt;
+	} while(size);
+
+	/* setup the fragments */
+	for (i = 0; i < fragments; i++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		u32 size = frag->size;
+		offset = 0;
+
+		do {
+			bcnt = (size > NV_TX2_TSO_MAX_SIZE) ? NV_TX2_TSO_MAX_SIZE : size;
+			nr = (nr + 1) % TX_RING;
+
+			np->tx_dma[nr] = pci_map_page(np->pci_dev, frag->page, frag->page_offset+offset, bcnt,
+						      PCI_DMA_TODEVICE);
+			np->tx_dma_len[nr] = bcnt;
 
 			if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2) {
 				np->tx_ring.orig[nr].PacketBuffer = cpu_to_le32(np->tx_dma[nr]);
-				np->tx_ring.orig[nr].FlagLen = cpu_to_le32( (frag->size-1) | np->tx_flags | tx_flags_extra);
+				np->tx_ring.orig[nr].FlagLen = cpu_to_le32((bcnt-1) | tx_flags);
 			} else {
 				np->tx_ring.ex[nr].PacketBufferHigh = cpu_to_le64(np->tx_dma[nr]) >> 32;
 				np->tx_ring.ex[nr].PacketBufferLow = cpu_to_le64(np->tx_dma[nr]) & 0x0FFFFFFFF;
-				np->tx_ring.ex[nr].FlagLen = cpu_to_le32( (frag->size-1) | np->tx_flags | tx_flags_extra);
+				np->tx_ring.ex[nr].FlagLen = cpu_to_le32((bcnt-1) | tx_flags);
 			}
-			
-			nr = (nr - 1) % TX_RING;
+			offset += bcnt;
+			size -= bcnt;
+		} while (size);
+	}
 
-			if (np->desc_ver == DESC_VER_1)
-				tx_flags_extra &= ~NV_TX_LASTPACKET;
-			else
-				tx_flags_extra &= ~NV_TX2_LASTPACKET;		
-		}
+	/* set last fragment flag  */
+	if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2) {
+		np->tx_ring.orig[nr].FlagLen |= cpu_to_le32(tx_flags_extra);
+	} else {
+		np->tx_ring.ex[nr].FlagLen |= cpu_to_le32(tx_flags_extra);
 	}
 
+	np->tx_skbuff[nr] = skb;
+
 #ifdef NETIF_F_TSO
 	if (skb_shinfo(skb)->tso_size)
-		tx_flags_extra |= NV_TX2_TSO | (skb_shinfo(skb)->tso_size << NV_TX2_TSO_SHIFT);
+		tx_flags_extra = NV_TX2_TSO | (skb_shinfo(skb)->tso_size << NV_TX2_TSO_SHIFT);
 	else
 #endif
-	tx_flags_extra |= (skb->ip_summed == CHECKSUM_HW ? (NV_TX2_CHECKSUM_L3|NV_TX2_CHECKSUM_L4) : 0);
+	tx_flags_extra = (skb->ip_summed == CHECKSUM_HW ? (NV_TX2_CHECKSUM_L3|NV_TX2_CHECKSUM_L4) : 0);
 
-	np->tx_dma[nr] = pci_map_single(np->pci_dev, skb->data, skb->len-skb->data_len,
-					PCI_DMA_TODEVICE);
-	
+	/* set tx flags */
 	if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2) {
-		np->tx_ring.orig[nr].PacketBuffer = cpu_to_le32(np->tx_dma[nr]);
-		np->tx_ring.orig[nr].FlagLen = cpu_to_le32( (skb->len-skb->data_len-1) | np->tx_flags | tx_flags_extra);
+		np->tx_ring.orig[start_nr].FlagLen |= cpu_to_le32(tx_flags | tx_flags_extra);
 	} else {
-		np->tx_ring.ex[nr].PacketBufferHigh = cpu_to_le64(np->tx_dma[nr]) >> 32;
-		np->tx_ring.ex[nr].PacketBufferLow = cpu_to_le64(np->tx_dma[nr]) & 0x0FFFFFFFF;
-		np->tx_ring.ex[nr].FlagLen = cpu_to_le32( (skb->len-skb->data_len-1) | np->tx_flags | tx_flags_extra);
+		np->tx_ring.ex[start_nr].FlagLen |= cpu_to_le32(tx_flags | tx_flags_extra);
 	}	
 
-	dprintk(KERN_DEBUG "%s: nv_start_xmit: packet packet %d queued for transmission. tx_flags_extra: %x\n",
-				dev->name, np->next_tx, tx_flags_extra);
+	dprintk(KERN_DEBUG "%s: nv_start_xmit: packet %d (entries %d) queued for transmission. tx_flags_extra: %x\n",
+		dev->name, np->next_tx, entries, tx_flags_extra);
 	{
 		int j;
 		for (j=0; j<64; j++) {
@@ -1093,7 +1130,7 @@ static int nv_start_xmit(struct sk_buff 
 		dprintk("\n");
 	}
 
-	np->next_tx += 1 + fragments;
+	np->next_tx += entries;
 
 	dev->trans_start = jiffies;
 	spin_unlock_irq(&np->lock);
@@ -1140,7 +1177,6 @@ static void nv_tx_done(struct net_device
 					np->stats.tx_packets++;
 					np->stats.tx_bytes += skb->len;
 				}
-				nv_release_txskb(dev, i);
 			}
 		} else {
 			if (Flags & NV_TX2_LASTPACKET) {
@@ -1156,9 +1192,9 @@ static void nv_tx_done(struct net_device
 					np->stats.tx_packets++;
 					np->stats.tx_bytes += skb->len;
 				}				
-				nv_release_txskb(dev, i);
 			}
 		}
+		nv_release_txskb(dev, i);
 		np->nic_tx++;
 	}
 	if (np->next_tx - np->nic_tx < TX_LIMIT_START)
@@ -2456,7 +2492,7 @@ static int __devinit nv_probe(struct pci
 		np->txrxctl_bits |= NVREG_TXRXCTL_RXCHECK;
 		dev->features |= NETIF_F_HW_CSUM | NETIF_F_SG;
 #ifdef NETIF_F_TSO
-		/* disabled dev->features |= NETIF_F_TSO; */
+		dev->features |= NETIF_F_TSO;
 #endif
  	}
 
diff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h
index 94a91da..cb9d66a 100644
--- a/drivers/net/gianfar.h
+++ b/drivers/net/gianfar.h
@@ -718,14 +718,14 @@ struct gfar_private {
 	uint32_t msg_enable;
 };
 
-extern inline u32 gfar_read(volatile unsigned *addr)
+static inline u32 gfar_read(volatile unsigned *addr)
 {
 	u32 val;
 	val = in_be32(addr);
 	return val;
 }
 
-extern inline void gfar_write(volatile unsigned *addr, u32 val)
+static inline void gfar_write(volatile unsigned *addr, u32 val)
 {
 	out_be32(addr, val);
 }
diff --git a/drivers/net/hp-plus.c b/drivers/net/hp-plus.c
index 0abf5dd..74e167e 100644
--- a/drivers/net/hp-plus.c
+++ b/drivers/net/hp-plus.c
@@ -138,12 +138,6 @@ static int __init do_hpp_probe(struct ne
 	return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	/* NB: hpp_close() handles free_irq */
-	release_region(dev->base_addr - NIC_OFFSET, HP_IO_EXTENT);
-}
-
 #ifndef MODULE
 struct net_device * __init hp_plus_probe(int unit)
 {
@@ -473,6 +467,12 @@ init_module(void)
 	return -ENXIO;
 }
 
+static void cleanup_card(struct net_device *dev)
+{
+	/* NB: hpp_close() handles free_irq */
+	release_region(dev->base_addr - NIC_OFFSET, HP_IO_EXTENT);
+}
+
 void
 cleanup_module(void)
 {
diff --git a/drivers/net/hp.c b/drivers/net/hp.c
index 59cf841..cf9fb36 100644
--- a/drivers/net/hp.c
+++ b/drivers/net/hp.c
@@ -102,12 +102,6 @@ static int __init do_hp_probe(struct net
 	return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	free_irq(dev->irq, dev);
-	release_region(dev->base_addr - NIC_OFFSET, HP_IO_EXTENT);
-}
-
 #ifndef MODULE
 struct net_device * __init hp_probe(int unit)
 {
@@ -444,6 +438,12 @@ init_module(void)
 	return -ENXIO;
 }
 
+static void cleanup_card(struct net_device *dev)
+{
+	free_irq(dev->irq, dev);
+	release_region(dev->base_addr - NIC_OFFSET, HP_IO_EXTENT);
+}
+
 void
 cleanup_module(void)
 {
diff --git a/drivers/net/ibm_emac/ibm_emac.h b/drivers/net/ibm_emac/ibm_emac.h
index 644edbf..c2dae60 100644
--- a/drivers/net/ibm_emac/ibm_emac.h
+++ b/drivers/net/ibm_emac/ibm_emac.h
@@ -110,6 +110,7 @@ struct emac_regs {
 #define EMAC_MR1_TFS_2K			0x00080000
 #define EMAC_MR1_TR0_MULT		0x00008000
 #define EMAC_MR1_JPSM			0x00000000
+#define EMAC_MR1_MWSW_001		0x00000000
 #define EMAC_MR1_BASE(opb)		(EMAC_MR1_TFS_2K | EMAC_MR1_TR0_MULT)
 #else
 #define EMAC_MR1_RFS_4K			0x00180000
@@ -130,7 +131,7 @@ struct emac_regs {
 					 (freq) <= 83  ? EMAC_MR1_OBCI_83 : \
 					 (freq) <= 100 ? EMAC_MR1_OBCI_100 : EMAC_MR1_OBCI_100P)
 #define EMAC_MR1_BASE(opb)		(EMAC_MR1_TFS_2K | EMAC_MR1_TR | \
-					 EMAC_MR1_MWSW_001 | EMAC_MR1_OBCI(opb))
+					 EMAC_MR1_OBCI(opb))
 #endif
 
 /* EMACx_TMR0 */
diff --git a/drivers/net/ibm_emac/ibm_emac_core.c b/drivers/net/ibm_emac/ibm_emac_core.c
index 1da8a66..591c586 100644
--- a/drivers/net/ibm_emac/ibm_emac_core.c
+++ b/drivers/net/ibm_emac/ibm_emac_core.c
@@ -408,7 +408,7 @@ static int emac_configure(struct ocp_ene
 	/* Mode register */
 	r = EMAC_MR1_BASE(emac_opb_mhz()) | EMAC_MR1_VLE | EMAC_MR1_IST;
 	if (dev->phy.duplex == DUPLEX_FULL)
-		r |= EMAC_MR1_FDE;
+		r |= EMAC_MR1_FDE | EMAC_MR1_MWSW_001;
 	dev->stop_timeout = STOP_TIMEOUT_10;
 	switch (dev->phy.speed) {
 	case SPEED_1000:
diff --git a/drivers/net/lance.c b/drivers/net/lance.c
index 1d75ca0..d1d714f 100644
--- a/drivers/net/lance.c
+++ b/drivers/net/lance.c
@@ -309,17 +309,6 @@ static void lance_tx_timeout (struct net
 
 
 
-static void cleanup_card(struct net_device *dev)
-{
-	struct lance_private *lp = dev->priv;
-	if (dev->dma != 4)
-		free_dma(dev->dma);
-	release_region(dev->base_addr, LANCE_TOTAL_SIZE);
-	kfree(lp->tx_bounce_buffs);
-	kfree((void*)lp->rx_buffs);
-	kfree(lp);
-}
-
 #ifdef MODULE
 #define MAX_CARDS		8	/* Max number of interfaces (cards) per module */
 
@@ -367,6 +356,17 @@ int init_module(void)
 	return -ENXIO;
 }
 
+static void cleanup_card(struct net_device *dev)
+{
+	struct lance_private *lp = dev->priv;
+	if (dev->dma != 4)
+		free_dma(dev->dma);
+	release_region(dev->base_addr, LANCE_TOTAL_SIZE);
+	kfree(lp->tx_bounce_buffs);
+	kfree((void*)lp->rx_buffs);
+	kfree(lp);
+}
+
 void cleanup_module(void)
 {
 	int this_dev;
diff --git a/drivers/net/lne390.c b/drivers/net/lne390.c
index 309d254..646e89f 100644
--- a/drivers/net/lne390.c
+++ b/drivers/net/lne390.c
@@ -145,13 +145,6 @@ static int __init do_lne390_probe(struct
 	return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	free_irq(dev->irq, dev);
-	release_region(dev->base_addr, LNE390_IO_EXTENT);
-	iounmap(ei_status.mem);
-}
-
 #ifndef MODULE
 struct net_device * __init lne390_probe(int unit)
 {
@@ -440,6 +433,13 @@ int init_module(void)
 	return -ENXIO;
 }
 
+static void cleanup_card(struct net_device *dev)
+{
+	free_irq(dev->irq, dev);
+	release_region(dev->base_addr, LNE390_IO_EXTENT);
+	iounmap(ei_status.mem);
+}
+
 void cleanup_module(void)
 {
 	int this_dev;
diff --git a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
index 3cb9b3f..22c3a37 100644
--- a/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2002 rabeeh@galileo.co.il
  *
  * Copyright (C) 2003 PMC-Sierra, Inc.,
- *	written by Manish Lachwani (lachwani@pmc-sierra.com)
+ *	written by Manish Lachwani
  *
  * Copyright (C) 2003 Ralf Baechle <ralf@linux-mips.org>
  *
diff --git a/drivers/net/ne.c b/drivers/net/ne.c
index 0de8fdd..94f782d 100644
--- a/drivers/net/ne.c
+++ b/drivers/net/ne.c
@@ -212,15 +212,6 @@ static int __init do_ne_probe(struct net
 	return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	struct pnp_dev *idev = (struct pnp_dev *)ei_status.priv;
-	if (idev)
-		pnp_device_detach(idev);
-	free_irq(dev->irq, dev);
-	release_region(dev->base_addr, NE_IO_EXTENT);
-}
-
 #ifndef MODULE
 struct net_device * __init ne_probe(int unit)
 {
@@ -859,6 +850,15 @@ int init_module(void)
 	return -ENODEV;
 }
 
+static void cleanup_card(struct net_device *dev)
+{
+	struct pnp_dev *idev = (struct pnp_dev *)ei_status.priv;
+	if (idev)
+		pnp_device_detach(idev);
+	free_irq(dev->irq, dev);
+	release_region(dev->base_addr, NE_IO_EXTENT);
+}
+
 void cleanup_module(void)
 {
 	int this_dev;
diff --git a/drivers/net/ne2.c b/drivers/net/ne2.c
index 6d62ada..e6df375 100644
--- a/drivers/net/ne2.c
+++ b/drivers/net/ne2.c
@@ -278,14 +278,6 @@ static int __init do_ne2_probe(struct ne
 	return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	mca_mark_as_unused(ei_status.priv);
-	mca_set_adapter_procfn( ei_status.priv, NULL, NULL);
-	free_irq(dev->irq, dev);
-	release_region(dev->base_addr, NE_IO_EXTENT);
-}
-
 #ifndef MODULE
 struct net_device * __init ne2_probe(int unit)
 {
@@ -812,6 +804,14 @@ int init_module(void)
 	return -ENXIO;
 }
 
+static void cleanup_card(struct net_device *dev)
+{
+	mca_mark_as_unused(ei_status.priv);
+	mca_set_adapter_procfn( ei_status.priv, NULL, NULL);
+	free_irq(dev->irq, dev);
+	release_region(dev->base_addr, NE_IO_EXTENT);
+}
+
 void cleanup_module(void)
 {
 	int this_dev;
diff --git a/drivers/net/sk98lin/skge.c b/drivers/net/sk98lin/skge.c
index 9a76ac1..197edd7 100644
--- a/drivers/net/sk98lin/skge.c
+++ b/drivers/net/sk98lin/skge.c
@@ -282,26 +282,22 @@ SK_U32 Val)		/* pointer to store the rea
  * Description:
  *	This function initialize the PCI resources and IO
  *
- * Returns: N/A
- *	
+ * Returns:
+ *	0 - indicate everything worked ok.
+ *	!= 0 - error indication
  */
-int SkGeInitPCI(SK_AC *pAC)
+static __devinit int SkGeInitPCI(SK_AC *pAC)
 {
 	struct SK_NET_DEVICE *dev = pAC->dev[0];
 	struct pci_dev *pdev = pAC->PciDev;
 	int retval;
 
-	if (pci_enable_device(pdev) != 0) {
-		return 1;
-	}
-
 	dev->mem_start = pci_resource_start (pdev, 0);
 	pci_set_master(pdev);
 
-	if (pci_request_regions(pdev, "sk98lin") != 0) {
-		retval = 2;
-		goto out_disable;
-	}
+	retval = pci_request_regions(pdev, "sk98lin");
+	if (retval)
+		goto out;
 
 #ifdef SK_BIG_ENDIAN
 	/*
@@ -320,9 +316,8 @@ int SkGeInitPCI(SK_AC *pAC)
 	 * Remap the regs into kernel space.
 	 */
 	pAC->IoBase = ioremap_nocache(dev->mem_start, 0x4000);
-
-	if (!pAC->IoBase){
-		retval = 3;
+	if (!pAC->IoBase) {
+		retval = -EIO;
 		goto out_release;
 	}
 
@@ -330,8 +325,7 @@ int SkGeInitPCI(SK_AC *pAC)
 
  out_release:
 	pci_release_regions(pdev);
- out_disable:
-	pci_disable_device(pdev);
+ out:
 	return retval;
 }
 
@@ -492,7 +486,7 @@ module_param_array(AutoSizing, charp, NU
  *	0, if everything is ok
  *	!=0, on error
  */
-static int __init SkGeBoardInit(struct SK_NET_DEVICE *dev, SK_AC *pAC)
+static int __devinit SkGeBoardInit(struct SK_NET_DEVICE *dev, SK_AC *pAC)
 {
 short	i;
 unsigned long Flags;
@@ -529,7 +523,7 @@ SK_BOOL	DualNet;
 	if (SkGeInit(pAC, pAC->IoBase, SK_INIT_DATA) != 0) {
 		printk("HWInit (0) failed.\n");
 		spin_unlock_irqrestore(&pAC->SlowPathLock, Flags);
-		return(-EAGAIN);
+		return -EIO;
 	}
 	SkI2cInit(  pAC, pAC->IoBase, SK_INIT_DATA);
 	SkEventInit(pAC, pAC->IoBase, SK_INIT_DATA);
@@ -551,7 +545,7 @@ SK_BOOL	DualNet;
 	if (SkGeInit(pAC, pAC->IoBase, SK_INIT_IO) != 0) {
 		printk("sk98lin: HWInit (1) failed.\n");
 		spin_unlock_irqrestore(&pAC->SlowPathLock, Flags);
-		return(-EAGAIN);
+		return -EIO;
 	}
 	SkI2cInit(  pAC, pAC->IoBase, SK_INIT_IO);
 	SkEventInit(pAC, pAC->IoBase, SK_INIT_IO);
@@ -583,20 +577,20 @@ SK_BOOL	DualNet;
 	} else {
 		printk(KERN_WARNING "sk98lin: Illegal number of ports: %d\n",
 		       pAC->GIni.GIMacsFound);
-		return -EAGAIN;
+		return -EIO;
 	}
 
 	if (Ret) {
 		printk(KERN_WARNING "sk98lin: Requested IRQ %d is busy.\n",
 		       dev->irq);
-		return -EAGAIN;
+		return Ret;
 	}
 	pAC->AllocFlag |= SK_ALLOC_IRQ;
 
 	/* Alloc memory for this board (Mem for RxD/TxD) : */
 	if(!BoardAllocMem(pAC)) {
 		printk("No memory for descriptor rings.\n");
-       		return(-EAGAIN);
+		return -ENOMEM;
 	}
 
 	BoardInitMem(pAC);
@@ -612,7 +606,7 @@ SK_BOOL	DualNet;
 		DualNet)) {
 		BoardFreeMem(pAC);
 		printk("sk98lin: SkGeInitAssignRamToQueues failed.\n");
-		return(-EAGAIN);
+		return -EIO;
 	}
 
 	return (0);
@@ -633,8 +627,7 @@ SK_BOOL	DualNet;
  *	SK_TRUE, if all memory could be allocated
  *	SK_FALSE, if not
  */
-static SK_BOOL BoardAllocMem(
-SK_AC	*pAC)
+static __devinit SK_BOOL BoardAllocMem(SK_AC	*pAC)
 {
 caddr_t		pDescrMem;	/* pointer to descriptor memory area */
 size_t		AllocLength;	/* length of complete descriptor area */
@@ -727,8 +720,7 @@ size_t		AllocLength;	/* length of comple
  *
  * Returns:	N/A
  */
-static void BoardInitMem(
-SK_AC	*pAC)	/* pointer to adapter context */
+static __devinit void BoardInitMem(SK_AC *pAC)
 {
 int	i;		/* loop counter */
 int	RxDescrSize;	/* the size of a rx descriptor rounded up to alignment*/
@@ -4776,32 +4768,47 @@ static int __devinit skge_probe_one(stru
 	struct net_device	*dev = NULL;
 	static int boards_found = 0;
 	int error = -ENODEV;
+	int using_dac = 0;
 	char DeviceStr[80];
 
 	if (pci_enable_device(pdev))
 		goto out;
  
 	/* Configure DMA attributes. */
-	if (pci_set_dma_mask(pdev, DMA_64BIT_MASK) &&
-	    pci_set_dma_mask(pdev, DMA_32BIT_MASK))
-		goto out_disable_device;
-
+	if (sizeof(dma_addr_t) > sizeof(u32) &&
+	    !(error = pci_set_dma_mask(pdev, DMA_64BIT_MASK))) {
+		using_dac = 1;
+		error = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
+		if (error < 0) {
+			printk(KERN_ERR "sk98lin %s unable to obtain 64 bit DMA "
+			       "for consistent allocations\n", pci_name(pdev));
+			goto out_disable_device;
+		}
+	} else {
+		error = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
+		if (error) {
+			printk(KERN_ERR "sk98lin %s no usable DMA configuration\n",
+			       pci_name(pdev));
+			goto out_disable_device;
+		}
+	}
 
-	if ((dev = alloc_etherdev(sizeof(DEV_NET))) == NULL) {
-		printk(KERN_ERR "Unable to allocate etherdev "
+ 	error = -ENOMEM;
+ 	dev = alloc_etherdev(sizeof(DEV_NET));
+ 	if (!dev) {
+		printk(KERN_ERR "sk98lin: unable to allocate etherdev "
 		       "structure!\n");
 		goto out_disable_device;
 	}
 
 	pNet = netdev_priv(dev);
-	pNet->pAC = kmalloc(sizeof(SK_AC), GFP_KERNEL);
+	pNet->pAC = kzalloc(sizeof(SK_AC), GFP_KERNEL);
 	if (!pNet->pAC) {
-		printk(KERN_ERR "Unable to allocate adapter "
+		printk(KERN_ERR "sk98lin: unable to allocate adapter "
 		       "structure!\n");
 		goto out_free_netdev;
 	}
 
-	memset(pNet->pAC, 0, sizeof(SK_AC));
 	pAC = pNet->pAC;
 	pAC->PciDev = pdev;
 
@@ -4810,6 +4817,7 @@ static int __devinit skge_probe_one(stru
 	pAC->CheckQueue = SK_FALSE;
 
 	dev->irq = pdev->irq;
+
 	error = SkGeInitPCI(pAC);
 	if (error) {
 		printk(KERN_ERR "sk98lin: PCI setup failed: %i\n", error);
@@ -4844,19 +4852,25 @@ static int __devinit skge_probe_one(stru
 #endif
 	}
 
+	if (using_dac)
+		dev->features |= NETIF_F_HIGHDMA;
+
 	pAC->Index = boards_found++;
 
-	if (SkGeBoardInit(dev, pAC))
+	error = SkGeBoardInit(dev, pAC);
+	if (error)
 		goto out_free_netdev;
 
 	/* Read Adapter name from VPD */
 	if (ProductStr(pAC, DeviceStr, sizeof(DeviceStr)) != 0) {
+		error = -EIO;
 		printk(KERN_ERR "sk98lin: Could not read VPD data.\n");
 		goto out_free_resources;
 	}
 
 	/* Register net device */
-	if (register_netdev(dev)) {
+	error = register_netdev(dev);
+	if (error) {
 		printk(KERN_ERR "sk98lin: Could not register device.\n");
 		goto out_free_resources;
 	}
@@ -4883,15 +4897,17 @@ static int __devinit skge_probe_one(stru
 
 	boards_found++;
 
+	pci_set_drvdata(pdev, dev);
+
 	/* More then one port found */
 	if ((pAC->GIni.GIMacsFound == 2 ) && (pAC->RlmtNets == 2)) {
-		if ((dev = alloc_etherdev(sizeof(DEV_NET))) == 0) {
-			printk(KERN_ERR "Unable to allocate etherdev "
+		dev = alloc_etherdev(sizeof(DEV_NET));
+		if (!dev) {
+			printk(KERN_ERR "sk98lin: unable to allocate etherdev "
 				"structure!\n");
-			goto out;
+			goto single_port;
 		}
 
-		pAC->dev[1]   = dev;
 		pNet          = netdev_priv(dev);
 		pNet->PortNr  = 1;
 		pNet->NetNr   = 1;
@@ -4920,20 +4936,28 @@ static int __devinit skge_probe_one(stru
 #endif
 		}
 
-		if (register_netdev(dev)) {
-			printk(KERN_ERR "sk98lin: Could not register device for seconf port.\n");
+		if (using_dac)
+			dev->features |= NETIF_F_HIGHDMA;
+
+		error = register_netdev(dev);
+		if (error) {
+			printk(KERN_ERR "sk98lin: Could not register device"
+			       " for second port. (%d)\n", error);
 			free_netdev(dev);
-			pAC->dev[1] = pAC->dev[0];
-		} else {
-			memcpy(&dev->dev_addr,
-					&pAC->Addr.Net[1].CurrentMacAddress, 6);
-			memcpy(dev->perm_addr, dev->dev_addr, dev->addr_len);
-	
-			printk("%s: %s\n", dev->name, DeviceStr);
-			printk("      PrefPort:B  RlmtMode:Dual Check Link State\n");
+			goto single_port;
 		}
+
+		pAC->dev[1]   = dev;
+		memcpy(&dev->dev_addr,
+		       &pAC->Addr.Net[1].CurrentMacAddress, 6);
+		memcpy(dev->perm_addr, dev->dev_addr, dev->addr_len);
+
+		printk("%s: %s\n", dev->name, DeviceStr);
+		printk("      PrefPort:B  RlmtMode:Dual Check Link State\n");
 	}
 
+single_port:
+
 	/* Save the hardware revision */
 	pAC->HWRevision = (((pAC->GIni.GIPciHwRev >> 4) & 0x0F)*10) +
 		(pAC->GIni.GIPciHwRev & 0x0F);
@@ -4945,7 +4969,6 @@ static int __devinit skge_probe_one(stru
 	memset(&pAC->PnmiBackup, 0, sizeof(SK_PNMI_STRUCT_DATA));
 	memcpy(&pAC->PnmiBackup, &pAC->PnmiStruct, sizeof(SK_PNMI_STRUCT_DATA));
 
-	pci_set_drvdata(pdev, dev);
 	return 0;
 
  out_free_resources:
diff --git a/drivers/net/smc-ultra.c b/drivers/net/smc-ultra.c
index ba8593a..3db30cd 100644
--- a/drivers/net/smc-ultra.c
+++ b/drivers/net/smc-ultra.c
@@ -168,18 +168,6 @@ static int __init do_ultra_probe(struct 
 	return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	/* NB: ultra_close_card() does free_irq */
-#ifdef __ISAPNP__
-	struct pnp_dev *idev = (struct pnp_dev *)ei_status.priv;
-	if (idev)
-		pnp_device_detach(idev);
-#endif
-	release_region(dev->base_addr - ULTRA_NIC_OFFSET, ULTRA_IO_EXTENT);
-	iounmap(ei_status.mem);
-}
-
 #ifndef MODULE
 struct net_device * __init ultra_probe(int unit)
 {
@@ -594,6 +582,18 @@ init_module(void)
 	return -ENXIO;
 }
 
+static void cleanup_card(struct net_device *dev)
+{
+	/* NB: ultra_close_card() does free_irq */
+#ifdef __ISAPNP__
+	struct pnp_dev *idev = (struct pnp_dev *)ei_status.priv;
+	if (idev)
+		pnp_device_detach(idev);
+#endif
+	release_region(dev->base_addr - ULTRA_NIC_OFFSET, ULTRA_IO_EXTENT);
+	iounmap(ei_status.mem);
+}
+
 void
 cleanup_module(void)
 {
diff --git a/drivers/net/tulip/tulip_core.c b/drivers/net/tulip/tulip_core.c
index 125ed00..c67c912 100644
--- a/drivers/net/tulip/tulip_core.c
+++ b/drivers/net/tulip/tulip_core.c
@@ -1564,7 +1564,7 @@ static int __devinit tulip_init_one (str
 			    dev->dev_addr, 6);
 		}
 #endif
-#if defined(__i386__)		/* Patch up x86 BIOS bug. */
+#if defined(__i386__) || defined(__x86_64__)	/* Patch up x86 BIOS bug. */
 		if (last_irq)
 			irq = last_irq;
 #endif
diff --git a/drivers/net/wd.c b/drivers/net/wd.c
index b03feae..7caa8dc 100644
--- a/drivers/net/wd.c
+++ b/drivers/net/wd.c
@@ -127,13 +127,6 @@ static int __init do_wd_probe(struct net
 	return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	free_irq(dev->irq, dev);
-	release_region(dev->base_addr - WD_NIC_OFFSET, WD_IO_EXTENT);
-	iounmap(ei_status.mem);
-}
-
 #ifndef MODULE
 struct net_device * __init wd_probe(int unit)
 {
@@ -538,6 +531,13 @@ init_module(void)
 	return -ENXIO;
 }
 
+static void cleanup_card(struct net_device *dev)
+{
+	free_irq(dev->irq, dev);
+	release_region(dev->base_addr - WD_NIC_OFFSET, WD_IO_EXTENT);
+	iounmap(ei_status.mem);
+}
+
 void
 cleanup_module(void)
 {
diff --git a/drivers/net/wireless/ipw2100.c b/drivers/net/wireless/ipw2100.c
index 44cd3fc..cf05661 100644
--- a/drivers/net/wireless/ipw2100.c
+++ b/drivers/net/wireless/ipw2100.c
@@ -7153,7 +7153,7 @@ static int ipw2100_wx_get_range(struct n
 
 	/* Set the Wireless Extension versions */
 	range->we_version_compiled = WIRELESS_EXT;
-	range->we_version_source = 16;
+	range->we_version_source = 18;
 
 //      range->retry_capa;      /* What retry options are supported */
 //      range->retry_flags;     /* How to decode max/min retry limit */
@@ -7184,6 +7184,9 @@ static int ipw2100_wx_get_range(struct n
 				IW_EVENT_CAPA_MASK(SIOCGIWAP));
 	range->event_capa[1] = IW_EVENT_CAPA_K_1;
 
+	range->enc_capa = IW_ENC_CAPA_WPA | IW_ENC_CAPA_WPA2 |
+		IW_ENC_CAPA_CIPHER_TKIP | IW_ENC_CAPA_CIPHER_CCMP;
+
 	IPW_DEBUG_WX("GET Range\n");
 
 	return 0;
diff --git a/net/ieee80211/ieee80211_crypt_wep.c b/net/ieee80211/ieee80211_crypt_wep.c
index 073aebd..f8dca31 100644
--- a/net/ieee80211/ieee80211_crypt_wep.c
+++ b/net/ieee80211/ieee80211_crypt_wep.c
@@ -75,22 +75,14 @@ static void prism2_wep_deinit(void *priv
 	kfree(priv);
 }
 
-/* Perform WEP encryption on given skb that has at least 4 bytes of headroom
- * for IV and 4 bytes of tailroom for ICV. Both IV and ICV will be transmitted,
- * so the payload length increases with 8 bytes.
- *
- * WEP frame payload: IV + TX key idx, RC4(data), ICV = RC4(CRC32(data))
- */
-static int prism2_wep_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
+/* Add WEP IV/key info to a frame that has at least 4 bytes of headroom */
+static int prism2_wep_build_iv(struct sk_buff *skb, int hdr_len, void *priv)
 {
 	struct prism2_wep_data *wep = priv;
-	u32 crc, klen, len;
-	u8 key[WEP_KEY_LEN + 3];
-	u8 *pos, *icv;
-	struct scatterlist sg;
-
-	if (skb_headroom(skb) < 4 || skb_tailroom(skb) < 4 ||
-	    skb->len < hdr_len)
+	u32 klen, len;
+	u8 *pos;
+	
+	if (skb_headroom(skb) < 4 || skb->len < hdr_len)
 		return -1;
 
 	len = skb->len - hdr_len;
@@ -112,15 +104,47 @@ static int prism2_wep_encrypt(struct sk_
 	}
 
 	/* Prepend 24-bit IV to RC4 key and TX frame */
-	*pos++ = key[0] = (wep->iv >> 16) & 0xff;
-	*pos++ = key[1] = (wep->iv >> 8) & 0xff;
-	*pos++ = key[2] = wep->iv & 0xff;
+	*pos++ = (wep->iv >> 16) & 0xff;
+	*pos++ = (wep->iv >> 8) & 0xff;
+	*pos++ = wep->iv & 0xff;
 	*pos++ = wep->key_idx << 6;
 
+	return 0;
+}
+
+/* Perform WEP encryption on given skb that has at least 4 bytes of headroom
+ * for IV and 4 bytes of tailroom for ICV. Both IV and ICV will be transmitted,
+ * so the payload length increases with 8 bytes.
+ *
+ * WEP frame payload: IV + TX key idx, RC4(data), ICV = RC4(CRC32(data))
+ */
+static int prism2_wep_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
+{
+	struct prism2_wep_data *wep = priv;
+	u32 crc, klen, len;
+	u8 *pos, *icv;
+	struct scatterlist sg;
+	u8 key[WEP_KEY_LEN + 3];
+
+	/* other checks are in prism2_wep_build_iv */
+	if (skb_tailroom(skb) < 4)
+		return -1;
+	
+	/* add the IV to the frame */
+	if (prism2_wep_build_iv(skb, hdr_len, priv))
+		return -1;
+	
+	/* Copy the IV into the first 3 bytes of the key */
+	memcpy(key, skb->data + hdr_len, 3);
+
 	/* Copy rest of the WEP key (the secret part) */
 	memcpy(key + 3, wep->key, wep->key_len);
+	
+	len = skb->len - hdr_len - 4;
+	pos = skb->data + hdr_len + 4;
+	klen = 3 + wep->key_len;
 
-	/* Append little-endian CRC32 and encrypt it to produce ICV */
+	/* Append little-endian CRC32 over only the data and encrypt it to produce ICV */
 	crc = ~crc32_le(~0, pos, len);
 	icv = skb_put(skb, 4);
 	icv[0] = crc;
@@ -231,6 +255,7 @@ static struct ieee80211_crypto_ops ieee8
 	.name = "WEP",
 	.init = prism2_wep_init,
 	.deinit = prism2_wep_deinit,
+	.build_iv = prism2_wep_build_iv,
 	.encrypt_mpdu = prism2_wep_encrypt,
 	.decrypt_mpdu = prism2_wep_decrypt,
 	.encrypt_msdu = NULL,
diff --git a/net/ieee80211/ieee80211_tx.c b/net/ieee80211/ieee80211_tx.c
index 445f206..e5b33c8 100644
--- a/net/ieee80211/ieee80211_tx.c
+++ b/net/ieee80211/ieee80211_tx.c
@@ -288,7 +288,7 @@ int ieee80211_xmit(struct sk_buff *skb, 
 	/* Determine total amount of storage required for TXB packets */
 	bytes = skb->len + SNAP_SIZE + sizeof(u16);
 
-	if (host_encrypt)
+	if (host_encrypt || host_build_iv)
 		fc = IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA |
 		    IEEE80211_FCTL_PROTECTED;
 	else
diff --git a/net/ieee80211/ieee80211_wx.c b/net/ieee80211/ieee80211_wx.c
index 181755f..406d5b9 100644
--- a/net/ieee80211/ieee80211_wx.c
+++ b/net/ieee80211/ieee80211_wx.c
@@ -284,7 +284,7 @@ int ieee80211_wx_set_encode(struct ieee8
 	};
 	int i, key, key_provided, len;
 	struct ieee80211_crypt_data **crypt;
-	int host_crypto = ieee->host_encrypt || ieee->host_decrypt;
+	int host_crypto = ieee->host_encrypt || ieee->host_decrypt || ieee->host_build_iv;
 
 	IEEE80211_DEBUG_WX("SET_ENCODE\n");
 
