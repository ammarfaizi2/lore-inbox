Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWCWBeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWCWBeb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 20:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWCWBeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 20:34:31 -0500
Received: from havoc.gtf.org ([69.61.125.42]:49033 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932473AbWCWBea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 20:34:30 -0500
Date: Wed, 22 Mar 2006 20:34:22 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver updates
Message-ID: <20060323013422.GA17201@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/Makefile         |    4 +-
 drivers/net/au1000_eth.c     |   18 ++++------
 drivers/net/depca.c          |    2 -
 drivers/net/sis900.c         |    1 
 drivers/net/sky2.c           |   27 +++++++++++++---
 drivers/net/sky2.h           |   71 +++++++++++++++++++++----------------------
 drivers/net/tulip/de2104x.c  |    2 -
 drivers/s390/net/qeth_main.c |   57 +++-------------------------------
 drivers/s390/net/qeth_proc.c |   56 ++++++++++++++++-----------------
 drivers/s390/net/qeth_sys.c  |    2 -
 10 files changed, 104 insertions(+), 136 deletions(-)

Artur Skawina:
      sis900 adm7001 PHY support

Eric Sesterhenn:
      Use after free in net/tulip/de2104x.c
      Use of uninitialized variable in drivers/net/depca.c

Frank Pavlic:
      s390: qeth driver statistics fixes
      s390: qeth driver cleanups
      s390: qeth :allow setting of attribute "route6" to "no_router".

Jens Osterkamp:
      fix spidernet build issue

Sergei Shtylylov:
      AMD Au1xx0: fix Ethernet TX stats

Stephen Hemminger:
      sky2: more ethtool stats

diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 00e72b1..b90468a 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -58,8 +58,8 @@ obj-$(CONFIG_STNIC) += stnic.o 8390.o
 obj-$(CONFIG_FEALNX) += fealnx.o
 obj-$(CONFIG_TIGON3) += tg3.o
 obj-$(CONFIG_BNX2) += bnx2.o
-spidernet-y += spider_net.o spider_net_ethtool.o sungem_phy.o
-obj-$(CONFIG_SPIDER_NET) += spidernet.o
+spidernet-y += spider_net.o spider_net_ethtool.o
+obj-$(CONFIG_SPIDER_NET) += spidernet.o sungem_phy.o
 obj-$(CONFIG_TC35815) += tc35815.o
 obj-$(CONFIG_SKGE) += skge.o
 obj-$(CONFIG_SKY2) += sky2.o
diff --git a/drivers/net/au1000_eth.c b/drivers/net/au1000_eth.c
index cd0b1dc..1363083 100644
--- a/drivers/net/au1000_eth.c
+++ b/drivers/net/au1000_eth.c
@@ -90,8 +90,6 @@ static void au1000_tx_timeout(struct net
 static int au1000_set_config(struct net_device *dev, struct ifmap *map);
 static void set_rx_mode(struct net_device *);
 static struct net_device_stats *au1000_get_stats(struct net_device *);
-static inline void update_tx_stats(struct net_device *, u32, u32);
-static inline void update_rx_stats(struct net_device *, u32);
 static void au1000_timer(unsigned long);
 static int au1000_ioctl(struct net_device *, struct ifreq *, int);
 static int mdio_read(struct net_device *, int, int);
@@ -1825,16 +1823,11 @@ static void __exit au1000_cleanup_module
 	}
 }
 
-
-static inline void 
-update_tx_stats(struct net_device *dev, u32 status, u32 pkt_len)
+static void update_tx_stats(struct net_device *dev, u32 status)
 {
 	struct au1000_private *aup = (struct au1000_private *) dev->priv;
 	struct net_device_stats *ps = &aup->stats;
 
-	ps->tx_packets++;
-	ps->tx_bytes += pkt_len;
-
 	if (status & TX_FRAME_ABORTED) {
 		if (dev->if_port == IF_PORT_100BASEFX) {
 			if (status & (TX_JAB_TIMEOUT | TX_UNDERRUN)) {
@@ -1867,7 +1860,7 @@ static void au1000_tx_ack(struct net_dev
 	ptxd = aup->tx_dma_ring[aup->tx_tail];
 
 	while (ptxd->buff_stat & TX_T_DONE) {
-		update_tx_stats(dev, ptxd->status, ptxd->len & 0x3ff);
+		update_tx_stats(dev, ptxd->status);
 		ptxd->buff_stat &= ~TX_T_DONE;
 		ptxd->len = 0;
 		au_sync();
@@ -1889,6 +1882,7 @@ static void au1000_tx_ack(struct net_dev
 static int au1000_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct au1000_private *aup = (struct au1000_private *) dev->priv;
+	struct net_device_stats *ps = &aup->stats;
 	volatile tx_dma_t *ptxd;
 	u32 buff_stat;
 	db_dest_t *pDB;
@@ -1908,7 +1902,7 @@ static int au1000_tx(struct sk_buff *skb
 		return 1;
 	}
 	else if (buff_stat & TX_T_DONE) {
-		update_tx_stats(dev, ptxd->status, ptxd->len & 0x3ff);
+		update_tx_stats(dev, ptxd->status);
 		ptxd->len = 0;
 	}
 
@@ -1928,6 +1922,9 @@ static int au1000_tx(struct sk_buff *skb
 	else
 		ptxd->len = skb->len;
 
+	ps->tx_packets++;
+	ps->tx_bytes += ptxd->len;
+
 	ptxd->buff_stat = pDB->dma_addr | TX_DMA_ENABLE;
 	au_sync();
 	dev_kfree_skb(skb);
@@ -1936,7 +1933,6 @@ static int au1000_tx(struct sk_buff *skb
 	return 0;
 }
 
-
 static inline void update_rx_stats(struct net_device *dev, u32 status)
 {
 	struct au1000_private *aup = (struct au1000_private *) dev->priv;
diff --git a/drivers/net/depca.c b/drivers/net/depca.c
index 03804cc..0941d40 100644
--- a/drivers/net/depca.c
+++ b/drivers/net/depca.c
@@ -1412,7 +1412,7 @@ static int __init depca_mca_probe(struct
 		irq = 11;
 		break;
 	default:
-		printk("%s: mca_probe IRQ error.  You should never get here (%d).\n", dev->name, where);
+		printk("%s: mca_probe IRQ error.  You should never get here (%d).\n", mdev->name, where);
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/sis900.c b/drivers/net/sis900.c
index a1cb07c..253440a 100644
--- a/drivers/net/sis900.c
+++ b/drivers/net/sis900.c
@@ -128,6 +128,7 @@ static const struct mii_chip_info {
 	{ "SiS 900 Internal MII PHY", 		0x001d, 0x8000, LAN },
 	{ "SiS 7014 Physical Layer Solution", 	0x0016, 0xf830, LAN },
 	{ "Altimata AC101LF PHY",               0x0022, 0x5520, LAN },
+	{ "ADM 7001 LAN PHY",			0x002e, 0xcc60, LAN },
 	{ "AMD 79C901 10BASE-T PHY",  		0x0000, 0x6B70, LAN },
 	{ "AMD 79C901 HomePNA PHY",		0x0000, 0x6B90, HOME},
 	{ "ICS LAN PHY",			0x0015, 0xF440, LAN },
diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index f08fe6c..36db938 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -2478,17 +2478,34 @@ static const struct sky2_stat {
 	{ "rx_unicast",    GM_RXF_UC_OK },
 	{ "tx_mac_pause",  GM_TXF_MPAUSE },
 	{ "rx_mac_pause",  GM_RXF_MPAUSE },
-	{ "collisions",    GM_TXF_SNG_COL },
+	{ "collisions",    GM_TXF_COL },
 	{ "late_collision",GM_TXF_LAT_COL },
 	{ "aborted", 	   GM_TXF_ABO_COL },
+	{ "single_collisions", GM_TXF_SNG_COL },
 	{ "multi_collisions", GM_TXF_MUL_COL },
-	{ "fifo_underrun", GM_TXE_FIFO_UR },
-	{ "fifo_overflow", GM_RXE_FIFO_OV },
-	{ "rx_toolong",    GM_RXF_LNG_ERR },
-	{ "rx_jabber",     GM_RXF_JAB_PKT },
+
+	{ "rx_short",      GM_RXE_SHT },
 	{ "rx_runt", 	   GM_RXE_FRAG },
+	{ "rx_64_byte_packets", GM_RXF_64B },
+	{ "rx_65_to_127_byte_packets", GM_RXF_127B },
+	{ "rx_128_to_255_byte_packets", GM_RXF_255B },
+	{ "rx_256_to_511_byte_packets", GM_RXF_511B },
+	{ "rx_512_to_1023_byte_packets", GM_RXF_1023B },
+	{ "rx_1024_to_1518_byte_packets", GM_RXF_1518B },
+	{ "rx_1518_to_max_byte_packets", GM_RXF_MAX_SZ },
 	{ "rx_too_long",   GM_RXF_LNG_ERR },
+	{ "rx_fifo_overflow", GM_RXE_FIFO_OV },
+	{ "rx_jabber",     GM_RXF_JAB_PKT },
 	{ "rx_fcs_error",   GM_RXF_FCS_ERR },
+
+	{ "tx_64_byte_packets", GM_TXF_64B },
+	{ "tx_65_to_127_byte_packets", GM_TXF_127B },
+	{ "tx_128_to_255_byte_packets", GM_TXF_255B },
+	{ "tx_256_to_511_byte_packets", GM_TXF_511B },
+	{ "tx_512_to_1023_byte_packets", GM_TXF_1023B },
+	{ "tx_1024_to_1518_byte_packets", GM_TXF_1518B },
+	{ "tx_1519_to_max_byte_packets", GM_TXF_MAX_SZ },
+	{ "tx_fifo_underrun", GM_TXE_FIFO_UR },
 };
 
 static u32 sky2_get_rx_csum(struct net_device *dev)
diff --git a/drivers/net/sky2.h b/drivers/net/sky2.h
index d63cd5a..2838f66 100644
--- a/drivers/net/sky2.h
+++ b/drivers/net/sky2.h
@@ -1373,23 +1373,23 @@ enum {
 	GM_SMI_CTRL	= 0x0080,	/* 16 bit r/w	SMI Control Register */
 	GM_SMI_DATA	= 0x0084,	/* 16 bit r/w	SMI Data Register */
 	GM_PHY_ADDR	= 0x0088,	/* 16 bit r/w	GPHY Address Register */
+/* MIB Counters */
+	GM_MIB_CNT_BASE	= 0x0100,	/* Base Address of MIB Counters */
+	GM_MIB_CNT_SIZE	= 256,
 };
 
-/* MIB Counters */
-#define GM_MIB_CNT_BASE	0x0100		/* Base Address of MIB Counters */
-#define GM_MIB_CNT_SIZE	44		/* Number of MIB Counters */
 
 /*
  * MIB Counters base address definitions (low word) -
  * use offset 4 for access to high word	(32 bit r/o)
  */
 enum {
-	GM_RXF_UC_OK  = GM_MIB_CNT_BASE + 0,	/* Unicast Frames Received OK */
+	GM_RXF_UC_OK    = GM_MIB_CNT_BASE + 0,	/* Unicast Frames Received OK */
 	GM_RXF_BC_OK	= GM_MIB_CNT_BASE + 8,	/* Broadcast Frames Received OK */
 	GM_RXF_MPAUSE	= GM_MIB_CNT_BASE + 16,	/* Pause MAC Ctrl Frames Received */
 	GM_RXF_MC_OK	= GM_MIB_CNT_BASE + 24,	/* Multicast Frames Received OK */
 	GM_RXF_FCS_ERR	= GM_MIB_CNT_BASE + 32,	/* Rx Frame Check Seq. Error */
-	/* GM_MIB_CNT_BASE + 40:	reserved */
+
 	GM_RXO_OK_LO	= GM_MIB_CNT_BASE + 48,	/* Octets Received OK Low */
 	GM_RXO_OK_HI	= GM_MIB_CNT_BASE + 56,	/* Octets Received OK High */
 	GM_RXO_ERR_LO	= GM_MIB_CNT_BASE + 64,	/* Octets Received Invalid Low */
@@ -1397,37 +1397,36 @@ enum {
 	GM_RXF_SHT	= GM_MIB_CNT_BASE + 80,	/* Frames <64 Byte Received OK */
 	GM_RXE_FRAG	= GM_MIB_CNT_BASE + 88,	/* Frames <64 Byte Received with FCS Err */
 	GM_RXF_64B	= GM_MIB_CNT_BASE + 96,	/* 64 Byte Rx Frame */
-	GM_RXF_127B	= GM_MIB_CNT_BASE + 104,	/* 65-127 Byte Rx Frame */
-	GM_RXF_255B	= GM_MIB_CNT_BASE + 112,	/* 128-255 Byte Rx Frame */
-	GM_RXF_511B	= GM_MIB_CNT_BASE + 120,	/* 256-511 Byte Rx Frame */
-	GM_RXF_1023B	= GM_MIB_CNT_BASE + 128,	/* 512-1023 Byte Rx Frame */
-	GM_RXF_1518B	= GM_MIB_CNT_BASE + 136,	/* 1024-1518 Byte Rx Frame */
-	GM_RXF_MAX_SZ	= GM_MIB_CNT_BASE + 144,	/* 1519-MaxSize Byte Rx Frame */
-	GM_RXF_LNG_ERR	= GM_MIB_CNT_BASE + 152,	/* Rx Frame too Long Error */
-	GM_RXF_JAB_PKT	= GM_MIB_CNT_BASE + 160,	/* Rx Jabber Packet Frame */
-	/* GM_MIB_CNT_BASE + 168:	reserved */
-	GM_RXE_FIFO_OV	= GM_MIB_CNT_BASE + 176,	/* Rx FIFO overflow Event */
-	/* GM_MIB_CNT_BASE + 184:	reserved */
-	GM_TXF_UC_OK	= GM_MIB_CNT_BASE + 192,	/* Unicast Frames Xmitted OK */
-	GM_TXF_BC_OK	= GM_MIB_CNT_BASE + 200,	/* Broadcast Frames Xmitted OK */
-	GM_TXF_MPAUSE	= GM_MIB_CNT_BASE + 208,	/* Pause MAC Ctrl Frames Xmitted */
-	GM_TXF_MC_OK	= GM_MIB_CNT_BASE + 216,	/* Multicast Frames Xmitted OK */
-	GM_TXO_OK_LO	= GM_MIB_CNT_BASE + 224,	/* Octets Transmitted OK Low */
-	GM_TXO_OK_HI	= GM_MIB_CNT_BASE + 232,	/* Octets Transmitted OK High */
-	GM_TXF_64B	= GM_MIB_CNT_BASE + 240,	/* 64 Byte Tx Frame */
-	GM_TXF_127B	= GM_MIB_CNT_BASE + 248,	/* 65-127 Byte Tx Frame */
-	GM_TXF_255B	= GM_MIB_CNT_BASE + 256,	/* 128-255 Byte Tx Frame */
-	GM_TXF_511B	= GM_MIB_CNT_BASE + 264,	/* 256-511 Byte Tx Frame */
-	GM_TXF_1023B	= GM_MIB_CNT_BASE + 272,	/* 512-1023 Byte Tx Frame */
-	GM_TXF_1518B	= GM_MIB_CNT_BASE + 280,	/* 1024-1518 Byte Tx Frame */
-	GM_TXF_MAX_SZ	= GM_MIB_CNT_BASE + 288,	/* 1519-MaxSize Byte Tx Frame */
-
-	GM_TXF_COL	= GM_MIB_CNT_BASE + 304,	/* Tx Collision */
-	GM_TXF_LAT_COL	= GM_MIB_CNT_BASE + 312,	/* Tx Late Collision */
-	GM_TXF_ABO_COL	= GM_MIB_CNT_BASE + 320,	/* Tx aborted due to Exces. Col. */
-	GM_TXF_MUL_COL	= GM_MIB_CNT_BASE + 328,	/* Tx Multiple Collision */
-	GM_TXF_SNG_COL	= GM_MIB_CNT_BASE + 336,	/* Tx Single Collision */
-	GM_TXE_FIFO_UR	= GM_MIB_CNT_BASE + 344,	/* Tx FIFO Underrun Event */
+	GM_RXF_127B	= GM_MIB_CNT_BASE + 104,/* 65-127 Byte Rx Frame */
+	GM_RXF_255B	= GM_MIB_CNT_BASE + 112,/* 128-255 Byte Rx Frame */
+	GM_RXF_511B	= GM_MIB_CNT_BASE + 120,/* 256-511 Byte Rx Frame */
+	GM_RXF_1023B	= GM_MIB_CNT_BASE + 128,/* 512-1023 Byte Rx Frame */
+	GM_RXF_1518B	= GM_MIB_CNT_BASE + 136,/* 1024-1518 Byte Rx Frame */
+	GM_RXF_MAX_SZ	= GM_MIB_CNT_BASE + 144,/* 1519-MaxSize Byte Rx Frame */
+	GM_RXF_LNG_ERR	= GM_MIB_CNT_BASE + 152,/* Rx Frame too Long Error */
+	GM_RXF_JAB_PKT	= GM_MIB_CNT_BASE + 160,/* Rx Jabber Packet Frame */
+
+	GM_RXE_FIFO_OV	= GM_MIB_CNT_BASE + 176,/* Rx FIFO overflow Event */
+	GM_TXF_UC_OK	= GM_MIB_CNT_BASE + 192,/* Unicast Frames Xmitted OK */
+	GM_TXF_BC_OK	= GM_MIB_CNT_BASE + 200,/* Broadcast Frames Xmitted OK */
+	GM_TXF_MPAUSE	= GM_MIB_CNT_BASE + 208,/* Pause MAC Ctrl Frames Xmitted */
+	GM_TXF_MC_OK	= GM_MIB_CNT_BASE + 216,/* Multicast Frames Xmitted OK */
+	GM_TXO_OK_LO	= GM_MIB_CNT_BASE + 224,/* Octets Transmitted OK Low */
+	GM_TXO_OK_HI	= GM_MIB_CNT_BASE + 232,/* Octets Transmitted OK High */
+	GM_TXF_64B	= GM_MIB_CNT_BASE + 240,/* 64 Byte Tx Frame */
+	GM_TXF_127B	= GM_MIB_CNT_BASE + 248,/* 65-127 Byte Tx Frame */
+	GM_TXF_255B	= GM_MIB_CNT_BASE + 256,/* 128-255 Byte Tx Frame */
+	GM_TXF_511B	= GM_MIB_CNT_BASE + 264,/* 256-511 Byte Tx Frame */
+	GM_TXF_1023B	= GM_MIB_CNT_BASE + 272,/* 512-1023 Byte Tx Frame */
+	GM_TXF_1518B	= GM_MIB_CNT_BASE + 280,/* 1024-1518 Byte Tx Frame */
+	GM_TXF_MAX_SZ	= GM_MIB_CNT_BASE + 288,/* 1519-MaxSize Byte Tx Frame */
+
+	GM_TXF_COL	= GM_MIB_CNT_BASE + 304,/* Tx Collision */
+	GM_TXF_LAT_COL	= GM_MIB_CNT_BASE + 312,/* Tx Late Collision */
+	GM_TXF_ABO_COL	= GM_MIB_CNT_BASE + 320,/* Tx aborted due to Exces. Col. */
+	GM_TXF_MUL_COL	= GM_MIB_CNT_BASE + 328,/* Tx Multiple Collision */
+	GM_TXF_SNG_COL	= GM_MIB_CNT_BASE + 336,/* Tx Single Collision */
+	GM_TXE_FIFO_UR	= GM_MIB_CNT_BASE + 344,/* Tx FIFO Underrun Event */
 };
 
 /* GMAC Bit Definitions */
diff --git a/drivers/net/tulip/de2104x.c b/drivers/net/tulip/de2104x.c
index 6299e18..e3dd144 100644
--- a/drivers/net/tulip/de2104x.c
+++ b/drivers/net/tulip/de2104x.c
@@ -1327,11 +1327,11 @@ static void de_clean_rings (struct de_pr
 		struct sk_buff *skb = de->tx_skb[i].skb;
 		if ((skb) && (skb != DE_DUMMY_SKB)) {
 			if (skb != DE_SETUP_SKB) {
-				dev_kfree_skb(skb);
 				de->net_stats.tx_dropped++;
 				pci_unmap_single(de->pdev,
 					de->tx_skb[i].mapping,
 					skb->len, PCI_DMA_TODEVICE);
+				dev_kfree_skb(skb);
 			} else {
 				pci_unmap_single(de->pdev,
 					de->tx_skb[i].mapping,
diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
index dba7f7f..021cd5d 100644
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
@@ -1364,7 +1364,7 @@ qeth_wait_for_buffer(struct qeth_channel
 static void
 qeth_clear_cmd_buffers(struct qeth_channel *channel)
 {
-	int cnt = 0;
+	int cnt;
 
 	for (cnt=0; cnt < QETH_CMD_BUFFER_NO; cnt++)
 		qeth_release_buffer(channel,&channel->iob[cnt]);
@@ -2814,11 +2814,11 @@ qeth_handle_send_error(struct qeth_card 
 		QETH_DBF_TEXT_(trace,1,"%s",CARD_BUS_ID(card));
 		return QETH_SEND_ERROR_LINK_FAILURE;
 	case 3:
+	default:
 		QETH_DBF_TEXT(trace, 1, "SIGAcc3");
 		QETH_DBF_TEXT_(trace,1,"%s",CARD_BUS_ID(card));
 		return QETH_SEND_ERROR_KICK_IT;
 	}
-	return QETH_SEND_ERROR_LINK_FAILURE;
 }
 
 void
@@ -3865,6 +3865,7 @@ qeth_get_cast_type(struct qeth_card *car
 	        	if ((hdr_mac == QETH_TR_MAC_NC) ||
 			    (hdr_mac == QETH_TR_MAC_C))
 				return RTN_MULTICAST;
+			break;
 	        /* eth or so multicast? */
                 default:
                       	if ((hdr_mac == QETH_ETH_MAC_V4) ||
@@ -4419,6 +4420,7 @@ qeth_send_packet(struct qeth_card *card,
 	int elements_needed = 0;
 	enum qeth_large_send_types large_send = QETH_LARGE_SEND_NO;
 	struct qeth_eddp_context *ctx = NULL;
+	int tx_bytes = skb->len;
 	int rc;
 
 	QETH_DBF_TEXT(trace, 6, "sendpkt");
@@ -4499,7 +4501,7 @@ qeth_send_packet(struct qeth_card *card,
 					      elements_needed, ctx);
 	if (!rc){
 		card->stats.tx_packets++;
-		card->stats.tx_bytes += skb->len;
+		card->stats.tx_bytes += tx_bytes;
 #ifdef CONFIG_QETH_PERF_STATS
 		if (skb_shinfo(skb)->tso_size &&
 		   !(large_send == QETH_LARGE_SEND_NO)) {
@@ -4585,38 +4587,11 @@ qeth_mdio_read(struct net_device *dev, i
 	case MII_NCONFIG: /* network interface config */
 		break;
 	default:
-		rc = 0;
 		break;
 	}
 	return rc;
 }
 
-static void
-qeth_mdio_write(struct net_device *dev, int phy_id, int regnum, int value)
-{
-	switch(regnum){
-	case MII_BMCR: /* Basic mode control register */
-	case MII_BMSR: /* Basic mode status register */
-	case MII_PHYSID1: /* PHYS ID 1 */
-	case MII_PHYSID2: /* PHYS ID 2 */
-	case MII_ADVERTISE: /* Advertisement control reg */
-	case MII_LPA: /* Link partner ability reg */
-	case MII_EXPANSION: /* Expansion register */
-	case MII_DCOUNTER: /* disconnect counter */
-	case MII_FCSCOUNTER: /* false carrier counter */
-	case MII_NWAYTEST: /* N-way auto-neg test register */
-	case MII_RERRCOUNTER: /* rx error counter */
-	case MII_SREVISION: /* silicon revision */
-	case MII_RESV1: /* reserved 1 */
-	case MII_LBRERROR: /* loopback, rx, bypass error */
-	case MII_PHYADDR: /* physical address */
-	case MII_RESV2: /* reserved 2 */
-	case MII_TPISTATUS: /* TPI status for 10mbps */
-	case MII_NCONFIG: /* network interface config */
-	default:
-		break;
-	}
-}
 
 static inline const char *
 qeth_arp_get_error_cause(int *rc)
@@ -5236,21 +5211,6 @@ qeth_do_ioctl(struct net_device *dev, st
 			mii_data->val_out = qeth_mdio_read(dev,mii_data->phy_id,
 							   mii_data->reg_num);
 		break;
-	case SIOCSMIIREG:
-		rc = -EOPNOTSUPP;
-		break;
-		/* TODO: remove return if qeth_mdio_write does something */
-		if (!capable(CAP_NET_ADMIN)){
-			rc = -EPERM;
-			break;
-		}
-		mii_data = if_mii(rq);
-		if (mii_data->phy_id != 0)
-			rc = -EINVAL;
-		else
-			qeth_mdio_write(dev, mii_data->phy_id, mii_data->reg_num,
-					mii_data->val_in);
-		break;
 	default:
 		rc = -EOPNOTSUPP;
 	}
@@ -6900,7 +6860,7 @@ qeth_send_setassparms(struct qeth_card *
 	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
 	if (len <= sizeof(__u32))
 		cmd->data.setassparms.data.flags_32bit = (__u32) data;
-	else if (len > sizeof(__u32))
+	else   /* (len > sizeof(__u32)) */
 		memcpy(&cmd->data.setassparms.data, (void *) data, len);
 
 	rc = qeth_send_ipa_cmd(card, iob, reply_cb, reply_param);
@@ -7379,11 +7339,6 @@ qeth_setrouting_v6(struct qeth_card *car
 	qeth_correct_routing_type(card, &card->options.route6.type,
 				  QETH_PROT_IPV6);
 
-	if ((card->options.route6.type == NO_ROUTER) ||
-	    ((card->info.type == QETH_CARD_TYPE_OSAE) &&
-	     (card->options.route6.type == MULTICAST_ROUTER) &&
-	     !qeth_is_supported6(card,IPA_OSA_MC_ROUTER)))
-		return 0;
 	rc = qeth_send_setrouting(card, card->options.route6.type,
 				  QETH_PROT_IPV6);
 	if (rc) {
diff --git a/drivers/s390/net/qeth_proc.c b/drivers/s390/net/qeth_proc.c
index 3c6339d..360d782 100644
--- a/drivers/s390/net/qeth_proc.c
+++ b/drivers/s390/net/qeth_proc.c
@@ -74,7 +74,7 @@ qeth_procfile_seq_next(struct seq_file *
 static inline const char *
 qeth_get_router_str(struct qeth_card *card, int ipv)
 {
-	int routing_type = 0;
+	enum qeth_routing_types routing_type = NO_ROUTER;
 
 	if (ipv == 4) {
 		routing_type = card->options.route4.type;
@@ -86,26 +86,26 @@ qeth_get_router_str(struct qeth_card *ca
 #endif /* CONFIG_QETH_IPV6 */
 	}
 
-	if (routing_type == PRIMARY_ROUTER)
+	switch (routing_type){
+	case PRIMARY_ROUTER:
 		return "pri";
-	else if (routing_type == SECONDARY_ROUTER)
+	case SECONDARY_ROUTER:
 		return "sec";
-	else if (routing_type == MULTICAST_ROUTER) {
+	case MULTICAST_ROUTER:
 		if (card->info.broadcast_capable == QETH_BROADCAST_WITHOUT_ECHO)
 			return "mc+";
 		return "mc";
-	} else if (routing_type == PRIMARY_CONNECTOR) {
+	case PRIMARY_CONNECTOR:
 		if (card->info.broadcast_capable == QETH_BROADCAST_WITHOUT_ECHO)
 			return "p+c";
 		return "p.c";
-	} else if (routing_type == SECONDARY_CONNECTOR) {
+	case SECONDARY_CONNECTOR:
 		if (card->info.broadcast_capable == QETH_BROADCAST_WITHOUT_ECHO)
 			return "s+c";
 		return "s.c";
-	} else if (routing_type == NO_ROUTER)
+	default:   /* NO_ROUTER */
 		return "no";
-	else
-		return "unk";
+	}
 }
 
 static int
@@ -192,27 +192,27 @@ qeth_perf_procfile_seq_show(struct seq_f
 			CARD_DDEV_ID(card),
 			QETH_CARD_IFNAME(card)
 		  );
-	seq_printf(s, "  Skb's/buffers received                 : %li/%i\n"
-		      "  Skb's/buffers sent                     : %li/%i\n\n",
+	seq_printf(s, "  Skb's/buffers received                 : %lu/%u\n"
+		      "  Skb's/buffers sent                     : %lu/%u\n\n",
 		        card->stats.rx_packets, card->perf_stats.bufs_rec,
 		        card->stats.tx_packets, card->perf_stats.bufs_sent
 		  );
-	seq_printf(s, "  Skb's/buffers sent without packing     : %li/%i\n"
-		      "  Skb's/buffers sent with packing        : %i/%i\n\n",
+	seq_printf(s, "  Skb's/buffers sent without packing     : %lu/%u\n"
+		      "  Skb's/buffers sent with packing        : %u/%u\n\n",
 		   card->stats.tx_packets - card->perf_stats.skbs_sent_pack,
 		   card->perf_stats.bufs_sent - card->perf_stats.bufs_sent_pack,
 		   card->perf_stats.skbs_sent_pack,
 		   card->perf_stats.bufs_sent_pack
 		  );
-	seq_printf(s, "  Skbs sent in SG mode                   : %i\n"
-		      "  Skb fragments sent in SG mode          : %i\n\n",
+	seq_printf(s, "  Skbs sent in SG mode                   : %u\n"
+		      "  Skb fragments sent in SG mode          : %u\n\n",
 		      card->perf_stats.sg_skbs_sent,
 		      card->perf_stats.sg_frags_sent);
-	seq_printf(s, "  large_send tx (in Kbytes)              : %i\n"
-		      "  large_send count                       : %i\n\n",
+	seq_printf(s, "  large_send tx (in Kbytes)              : %u\n"
+		      "  large_send count                       : %u\n\n",
 		      card->perf_stats.large_send_bytes >> 10,
 		      card->perf_stats.large_send_cnt);
-	seq_printf(s, "  Packing state changes no pkg.->packing : %i/%i\n"
+	seq_printf(s, "  Packing state changes no pkg.->packing : %u/%u\n"
 		      "  Watermarks L/H                         : %i/%i\n"
 		      "  Current buffer usage (outbound q's)    : "
 		      "%i/%i/%i/%i\n\n",
@@ -229,16 +229,16 @@ qeth_perf_procfile_seq_show(struct seq_f
 				atomic_read(&card->qdio.out_qs[3]->used_buffers)
 				: 0
 		  );
-	seq_printf(s, "  Inbound handler time (in us)           : %i\n"
-		      "  Inbound handler count                  : %i\n"
-		      "  Inbound do_QDIO time (in us)           : %i\n"
-		      "  Inbound do_QDIO count                  : %i\n\n"
-		      "  Outbound handler time (in us)          : %i\n"
-		      "  Outbound handler count                 : %i\n\n"
-		      "  Outbound time (in us, incl QDIO)       : %i\n"
-		      "  Outbound count                         : %i\n"
-		      "  Outbound do_QDIO time (in us)          : %i\n"
-		      "  Outbound do_QDIO count                 : %i\n\n",
+	seq_printf(s, "  Inbound handler time (in us)           : %u\n"
+		      "  Inbound handler count                  : %u\n"
+		      "  Inbound do_QDIO time (in us)           : %u\n"
+		      "  Inbound do_QDIO count                  : %u\n\n"
+		      "  Outbound handler time (in us)          : %u\n"
+		      "  Outbound handler count                 : %u\n\n"
+		      "  Outbound time (in us, incl QDIO)       : %u\n"
+		      "  Outbound count                         : %u\n"
+		      "  Outbound do_QDIO time (in us)          : %u\n"
+		      "  Outbound do_QDIO count                 : %u\n\n",
 		        card->perf_stats.inbound_time,
 			card->perf_stats.inbound_cnt,
 		        card->perf_stats.inbound_do_qdio_time,
diff --git a/drivers/s390/net/qeth_sys.c b/drivers/s390/net/qeth_sys.c
index c1831f5..f2a076a 100644
--- a/drivers/s390/net/qeth_sys.c
+++ b/drivers/s390/net/qeth_sys.c
@@ -115,7 +115,7 @@ qeth_dev_portno_store(struct device *dev
 		return -EPERM;
 
 	portno = simple_strtoul(buf, &tmp, 16);
-	if ((portno < 0) || (portno > MAX_PORTNO)){
+	if (portno > MAX_PORTNO){
 		PRINT_WARN("portno 0x%X is out of range\n", portno);
 		return -EINVAL;
 	}
