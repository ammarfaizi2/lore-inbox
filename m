Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271917AbSISRHu>; Thu, 19 Sep 2002 13:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271932AbSISRHu>; Thu, 19 Sep 2002 13:07:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27912 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S271917AbSISRHq>;
	Thu, 19 Sep 2002 13:07:46 -0400
Message-ID: <3D8A056C.2000605@mandrakesoft.com>
Date: Thu, 19 Sep 2002 13:12:12 -0400
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
Subject: PATCH: sundance #2
References: <Pine.LNX.4.44.0209190903050.29420-100000@beohost.scyld.com>
Content-Type: multipart/mixed;
 boundary="------------010400030102010602030107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010400030102010602030107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Thanks to Donald for his comments.  This patch addresses the first of 
his two emails.

This patch is _cumulative_ with the last one I sent (sundance 1.04), so 
do not discard that one.

Again additional testing is appreciated.  Keep the feedback coming, 
there will be more sundance bugfixes (patch #3, #4, etc.)

	Jeff



--------------010400030102010602030107
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/net/sundance.c b/drivers/net/sundance.c
--- a/drivers/net/sundance.c	Thu Sep 19 13:05:53 2002
+++ b/drivers/net/sundance.c	Thu Sep 19 13:05:53 2002
@@ -18,26 +18,34 @@
 	http://www.scyld.com/network/sundance.html
 
 
-	Version 1.01a (jgarzik):
+	Version LK1.01a (jgarzik):
 	- Replace some MII-related magic numbers with constants
 
-	Version 1.02 (D-Link):
+	Version LK1.02 (D-Link):
 	- Add new board to PCI ID list
 	- Fix multicast bug
 	
-	Version 1.03 (D-Link):
+	Version LK1.03 (D-Link):
 	- New Rx scheme, reduce Rx congestion
 	- Option to disable flow control
 	
-	Version 1.04 (D-Link):
+	Version LK1.04 (D-Link):
 	- Tx timeout recovery
 	- More support for ethtool.
 
+	Version LK1.04a (jgarzik):
+	- Remove unused/constant members from struct pci_id_info
+	(which then allows removal of 'drv_flags' from private struct)
+	- If no phy is found, fail to load that board
+	- Always start phy id scan at id 1 to avoid problems (Donald Becker)
+	- Autodetect where mii_preable_required is needed,
+	default to not needed.  (Donald Becker)
+
 */
 
 #define DRV_NAME	"sundance"
-#define DRV_VERSION	"1.04"
-#define DRV_RELDATE	"19-Aug-2002"
+#define DRV_VERSION	"1.01+LK1.04a"
+#define DRV_RELDATE	"19-Sep-2002"
 
 
 /* The user-configurable values.
@@ -72,6 +80,12 @@
 */
 #define MAX_UNITS 8	
 static char *media[MAX_UNITS];
+
+/* Set iff a MII transceiver on any interface requires mdio preamble.
+   This only set with older tranceivers, so the extra
+   code size of a per-interface flag is not worthwhile. */
+static int mii_preamble_required = 0;
+
 /* Operational parameters that are set at compile time. */
 
 /* Keep the ring sizes a power of two for compile efficiency.
@@ -145,11 +159,14 @@
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(media, "1-" __MODULE_STRING(MAX_UNITS) "s");
 MODULE_PARM(flowctrl, "i");
+MODULE_PARM(mii_preamble_required, "i");
 MODULE_PARM_DESC(max_interrupt_work, "Sundance Alta maximum events handled per interrupt");
 MODULE_PARM_DESC(mtu, "Sundance Alta MTU (all boards)");
 MODULE_PARM_DESC(debug, "Sundance Alta debug level (0-5)");
 MODULE_PARM_DESC(rx_copybreak, "Sundance Alta copy breakpoint for copy-only-tiny-frames");
 MODULE_PARM_DESC(flowctrl, "Sundance Alta flow control [0|1]");
+MODULE_PARM_DESC(mii_preamble_required, "Set to send a preamble before MII management transactions");
+
 /*
 				Theory of Operation
 
@@ -225,20 +242,6 @@
 */
 
 
-enum pci_id_flags_bits {
-        /* Set PCI command register bits before calling probe1(). */
-        PCI_USES_IO=1, PCI_USES_MEM=2, PCI_USES_MASTER=4,
-        /* Read and map the single following PCI BAR. */
-        PCI_ADDR0=0<<4, PCI_ADDR1=1<<4, PCI_ADDR2=2<<4, PCI_ADDR3=3<<4,
-        PCI_ADDR_64BITS=0x100, PCI_NO_ACPI_WAKE=0x200, PCI_NO_MIN_LATENCY=0x400,
-};
-enum chip_capability_flags {CanHaveMII=1, };
-#ifdef USE_IO_OPS
-#define PCI_IOTYPE (PCI_USES_MASTER | PCI_USES_IO  | PCI_ADDR0)
-#else
-#define PCI_IOTYPE (PCI_USES_MASTER | PCI_USES_MEM | PCI_ADDR1)
-#endif
-
 static struct pci_device_id sundance_pci_tbl[] __devinitdata = {
 	{0x1186, 0x1002, 0x1186, 0x1002, 0, 0, 0},
 	{0x1186, 0x1002, 0x1186, 0x1003, 0, 0, 1},
@@ -250,31 +253,20 @@
 };
 MODULE_DEVICE_TABLE(pci, sundance_pci_tbl);
 
+enum {
+	netdev_io_size = 128
+};
+
 struct pci_id_info {
         const char *name;
-        struct match_info {
-                int     pci, pci_mask, subsystem, subsystem_mask;
-                int revision, revision_mask;                            /* Only 8 bits. */
-        } id;
-        enum pci_id_flags_bits pci_flags;
-        int io_size;                            /* Needed for I/O region check or ioremap(). */
-        int drv_flags;                          /* Driver use, intended as capability flags. */
 };
 static struct pci_id_info pci_id_tbl[] = {
-	{"D-Link DFE-550TX FAST Ethernet Adapter", {0x10021186, 0xffffffff,},
-	 PCI_IOTYPE, 128, CanHaveMII},
-	{"D-Link DFE-550FX 100Mbps Fiber-optics Adapter",
-	 {0x10031186, 0xffffffff,},
-	 PCI_IOTYPE, 128, CanHaveMII},
-	{"D-Link DFE-580TX 4 port Server Adapter", {0x10121186, 0xffffffff,},
-	 PCI_IOTYPE, 128, CanHaveMII},
-	{"D-Link DFE-530TXS FAST Ethernet Adapter", {0x10021186, 0xffffffff,},
-	 PCI_IOTYPE, 128, CanHaveMII},
-	{"D-Link DL10050-based FAST Ethernet Adapter",
-	 {0x10021186, 0xffffffff,},
-	 PCI_IOTYPE, 128, CanHaveMII},
-	{"Sundance Technology Alta", {0x020113F0, 0xffffffff,},
-	 PCI_IOTYPE, 128, CanHaveMII},
+	{"D-Link DFE-550TX FAST Ethernet Adapter"},
+	{"D-Link DFE-550FX 100Mbps Fiber-optics Adapter"},
+	{"D-Link DFE-580TX 4 port Server Adapter"},
+	{"D-Link DFE-530TXS FAST Ethernet Adapter"},
+	{"D-Link DL10050-based FAST Ethernet Adapter"},
+	{"Sundance Technology Alta"},
 	{0,},			/* 0 terminated list. */
 };
 
@@ -430,7 +422,7 @@
 	/* Frequently used values: keep some adjacent for cache effect. */
 	spinlock_t lock;
 	spinlock_t rx_lock;					/* Group with Tx control cache line. */
-	int chip_id, drv_flags;
+	int chip_id;
 	unsigned int cur_rx, dirty_rx;		/* Producer/consumer ring indices */
 	unsigned int rx_buf_sz;				/* Based on MTU+slack. */
 	struct netdev_desc *last_tx;		/* Last Tx descriptor used. */
@@ -447,7 +439,6 @@
 	spinlock_t mcastlock;				/* SMP lock multicast updates. */
 	u16 mcast_filter[4];
 	/* MII transceiver section. */
-	int mii_cnt;						/* MII device addresses. */
 	u16 advertising;					/* NWay media advertisement */
 	unsigned char phys[MII_CNT];		/* MII device addresses, only first one used. */
 	struct pci_dev *pci_dev;
@@ -521,7 +512,7 @@
 	ioaddr = pci_resource_start(pdev, 0);
 #else
 	ioaddr = pci_resource_start(pdev, 1);
-	ioaddr = (long) ioremap (ioaddr, pci_id_tbl[chip_idx].io_size);
+	ioaddr = (long) ioremap (ioaddr, netdev_io_size);
 	if (!ioaddr)
 		goto err_out_res;
 #endif
@@ -535,7 +526,6 @@
 
 	np = dev->priv;
 	np->chip_id = chip_idx;
-	np->drv_flags = pci_id_tbl[chip_idx].drv_flags;
 	np->pci_dev = pdev;
 	spin_lock_init(&np->lock);
 	tasklet_init(&np->rx_tasklet, rx_poll, (unsigned long)dev);
@@ -579,21 +569,28 @@
 	if (1) {
 		int phy, phy_idx = 0;
 		np->phys[0] = 1;		/* Default setting */
-		for (phy = 0; phy < 32 && phy_idx < MII_CNT; phy++) {
-			int mii_status = mdio_read(dev, phy, 1);
+		mii_preamble_required++;
+		for (phy = 1; phy < 32 && phy_idx < MII_CNT; phy++) {
+			int mii_status = mdio_read(dev, phy, MII_BMSR);
 			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
 				np->phys[phy_idx++] = phy;
-				np->advertising = mdio_read(dev, phy, 4);
+				np->advertising = mdio_read(dev, phy, MII_ADVERTISE);
+				if ((mii_status & 0x0040) == 0)
+					mii_preamble_required++;
 				printk(KERN_INFO "%s: MII PHY found at address %d, status "
 					   "0x%4.4x advertising %4.4x.\n",
 					   dev->name, phy, mii_status, np->advertising);
 			}
 		}
-		np->mii_cnt = phy_idx;
-		if (phy_idx == 0)
-			printk(KERN_INFO "%s: No MII transceiver found!, ASIC status %x\n",
+		mii_preamble_required--;
+
+		if (phy_idx == 0) {
+			printk(KERN_INFO "%s: No MII transceiver found, aborting.  ASIC status %x\n",
 				   dev->name, readl(ioaddr + ASICCtrl));
+			goto err_out_unmap_rx;
+		}
 	}
+
 	/* Parse override configuration */
 	np->an_enable = 1;
 	if (card_idx < MAX_UNITS) {
@@ -700,11 +697,6 @@
 	The maximum data clock rate is 2.5 Mhz.  The minimum timing is usually
 	met by back-to-back 33Mhz PCI cycles. */
 #define mdio_delay() readb(mdio_addr)
-
-/* Set iff a MII transceiver on any interface requires mdio preamble.
-   This only set with older tranceivers, so the extra
-   code size of a per-interface flag is not worthwhile. */
-static const char mii_preamble_required = 1;
 
 enum mii_reg_bits {
 	MDIO_ShiftClk=0x0001, MDIO_Data=0x0002, MDIO_EnbOutput=0x0004,

--------------010400030102010602030107--

