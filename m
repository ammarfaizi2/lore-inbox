Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272182AbSISSNp>; Thu, 19 Sep 2002 14:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272187AbSISSNp>; Thu, 19 Sep 2002 14:13:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18953 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S272182AbSISSNm>;
	Thu, 19 Sep 2002 14:13:42 -0400
Message-ID: <3D8A14E6.6000105@mandrakesoft.com>
Date: Thu, 19 Sep 2002 14:18:14 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Donald Becker <becker@scyld.com>
CC: netdev@oss.sgi.com, Jason Lunz <lunz@falooley.org>,
       Richard Gooch <rgooch@ras.ucalgary.ca>,
       "Patrick R. McManus" <mcmanus@ducksong.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       edward_peng@dlink.com.tw
Subject: PATCH: sundance #3
References: <Pine.LNX.4.44.0209191316300.29420-100000@beohost.scyld.com>
Content-Type: multipart/mixed;
 boundary="------------040704040102060900060303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040704040102060900060303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The obvious sundance #3 patch follows...  cumulative to the 
sundance-1.04 base patch, and sundance #2 patch.

--------------040704040102060900060303
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/net/sundance.c b/drivers/net/sundance.c
--- a/drivers/net/sundance.c	Thu Sep 19 14:16:21 2002
+++ b/drivers/net/sundance.c	Thu Sep 19 14:16:21 2002
@@ -41,10 +41,17 @@
 	- Autodetect where mii_preable_required is needed,
 	default to not needed.  (Donald Becker)
 
+	Version LK1.04b:
+	- Remove mii_preamble_required module parameter (Donald Becker)
+	- Add per-interface mii_preamble_required (setting is autodetected)
+	  (Donald Becker)
+	- Remove unnecessary cast from void pointer
+	- Re-align comments in private struct
+
 */
 
 #define DRV_NAME	"sundance"
-#define DRV_VERSION	"1.01+LK1.04a"
+#define DRV_VERSION	"1.01+LK1.04b"
 #define DRV_RELDATE	"19-Sep-2002"
 
 
@@ -81,10 +88,6 @@
 #define MAX_UNITS 8	
 static char *media[MAX_UNITS];
 
-/* Set iff a MII transceiver on any interface requires mdio preamble.
-   This only set with older tranceivers, so the extra
-   code size of a per-interface flag is not worthwhile. */
-static int mii_preamble_required = 0;
 
 /* Operational parameters that are set at compile time. */
 
@@ -159,13 +162,11 @@
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(media, "1-" __MODULE_STRING(MAX_UNITS) "s");
 MODULE_PARM(flowctrl, "i");
-MODULE_PARM(mii_preamble_required, "i");
 MODULE_PARM_DESC(max_interrupt_work, "Sundance Alta maximum events handled per interrupt");
 MODULE_PARM_DESC(mtu, "Sundance Alta MTU (all boards)");
 MODULE_PARM_DESC(debug, "Sundance Alta debug level (0-5)");
 MODULE_PARM_DESC(rx_copybreak, "Sundance Alta copy breakpoint for copy-only-tiny-frames");
 MODULE_PARM_DESC(flowctrl, "Sundance Alta flow control [0|1]");
-MODULE_PARM_DESC(mii_preamble_required, "Set to send a preamble before MII management transactions");
 
 /*
 				Theory of Operation
@@ -418,17 +419,17 @@
         dma_addr_t tx_ring_dma;
         dma_addr_t rx_ring_dma;
 	struct net_device_stats stats;
-	struct timer_list timer;	/* Media monitoring timer. */
+	struct timer_list timer;		/* Media monitoring timer. */
 	/* Frequently used values: keep some adjacent for cache effect. */
 	spinlock_t lock;
-	spinlock_t rx_lock;					/* Group with Tx control cache line. */
+	spinlock_t rx_lock;			/* Group with Tx control cache line. */
 	int chip_id;
 	unsigned int cur_rx, dirty_rx;		/* Producer/consumer ring indices */
-	unsigned int rx_buf_sz;				/* Based on MTU+slack. */
+	unsigned int rx_buf_sz;			/* Based on MTU+slack. */
 	struct netdev_desc *last_tx;		/* Last Tx descriptor used. */
 	unsigned int cur_tx, dirty_tx;
 	/* These values are keep track of the transceiver/media in use. */
-	unsigned int full_duplex:1;			/* Full-duplex operation requested. */
+	unsigned int full_duplex:1;		/* Full-duplex operation requested. */
 	unsigned int flowctrl:1;
 	unsigned int default_port:4;		/* Last dev->if_port value. */
 	unsigned int an_enable:1;
@@ -436,10 +437,11 @@
 	struct tasklet_struct rx_tasklet;
 	int budget;
 	/* Multicast and receive mode. */
-	spinlock_t mcastlock;				/* SMP lock multicast updates. */
+	spinlock_t mcastlock;			/* SMP lock multicast updates. */
 	u16 mcast_filter[4];
 	/* MII transceiver section. */
-	u16 advertising;					/* NWay media advertisement */
+	int mii_preamble_required;
+	u16 advertising;			/* NWay media advertisement */
 	unsigned char phys[MII_CNT];		/* MII device addresses, only first one used. */
 	struct pci_dev *pci_dev;
 };
@@ -569,20 +571,20 @@
 	if (1) {
 		int phy, phy_idx = 0;
 		np->phys[0] = 1;		/* Default setting */
-		mii_preamble_required++;
+		np->mii_preamble_required++;
 		for (phy = 1; phy < 32 && phy_idx < MII_CNT; phy++) {
 			int mii_status = mdio_read(dev, phy, MII_BMSR);
 			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
 				np->phys[phy_idx++] = phy;
 				np->advertising = mdio_read(dev, phy, MII_ADVERTISE);
 				if ((mii_status & 0x0040) == 0)
-					mii_preamble_required++;
+					np->mii_preamble_required++;
 				printk(KERN_INFO "%s: MII PHY found at address %d, status "
 					   "0x%4.4x advertising %4.4x.\n",
 					   dev->name, phy, mii_status, np->advertising);
 			}
 		}
-		mii_preamble_required--;
+		np->mii_preamble_required--;
 
 		if (phy_idx == 0) {
 			printk(KERN_INFO "%s: No MII transceiver found, aborting.  ASIC status %x\n",
@@ -722,11 +724,12 @@
 
 static int mdio_read(struct net_device *dev, int phy_id, int location)
 {
+	struct netdev_private *np = dev->priv;
 	long mdio_addr = dev->base_addr + MIICtrl;
 	int mii_cmd = (0xf6 << 10) | (phy_id << 5) | location;
 	int i, retval = 0;
 
-	if (mii_preamble_required)
+	if (np->mii_preamble_required)
 		mdio_sync(mdio_addr);
 
 	/* Shift the read command bits out. */
@@ -751,11 +754,12 @@
 
 static void mdio_write(struct net_device *dev, int phy_id, int location, int value)
 {
+	struct netdev_private *np = dev->priv;
 	long mdio_addr = dev->base_addr + MIICtrl;
 	int mii_cmd = (0x5002 << 16) | (phy_id << 23) | (location<<18) | value;
 	int i;
 
-	if (mii_preamble_required)
+	if (np->mii_preamble_required)
 		mdio_sync(mdio_addr);
 
 	/* Shift the command bits out. */
@@ -969,7 +973,7 @@
 static int
 start_tx (struct sk_buff *skb, struct net_device *dev)
 {
-	struct netdev_private *np = (struct netdev_private *) dev->priv;
+	struct netdev_private *np = dev->priv;
 	struct netdev_desc *txdesc;
 	unsigned entry;
 	long ioaddr = dev->base_addr;

--------------040704040102060900060303--

