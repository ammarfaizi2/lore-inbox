Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270065AbUJHRSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270065AbUJHRSA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 13:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270067AbUJHRSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 13:18:00 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:39691 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S270065AbUJHRPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:15:32 -0400
Date: Fri, 8 Oct 2004 12:13:07 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com, akpm@osdl.org, jgarzik@pobox.com,
       marcelo.tosatti@cyclades.com
Subject: [patch 2.4.28-pre3] 3c59x: resync with 2.6
Message-ID: <20041008121307.C14378@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
	akpm@osdl.org, jgarzik@pobox.com, marcelo.tosatti@cyclades.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Backport of current 3c59x driver (minus EISA/sysfs stuff) from 2.6 to
2.4.  This should ease further maintenance in 2.4.
---
I've been chasing some 3c59x driver problems on both 2.4.x and 2.6.x
kernels.  The 3c59x driver was pretty far out of sync between the two
trees, so I thought it made sense to sync them back up.

 drivers/net/3c59x.c |  505 ++++++++++++++++++++++++++++++++++------------------
 include/linux/mii.h |    7 
 2 files changed, 346 insertions(+), 166 deletions(-)

Successfully tested w/ 3c905 on i686 w/ 2.4.28-rc3.

--- linux-2.4/drivers/net/3c59x.c.orig
+++ linux-2.4/drivers/net/3c59x.c
@@ -166,12 +166,19 @@
     - Rename wait_for_completion() to issue_and_wait() to avoid completion.h
       clash.
 
-    LK1.1.18ac 01Jul02 akpm
-     - Fix for undocumented transceiver power-up bit on some 3c566B's
-       (Donald Becker, Rahul Karnik)
- 
+   LK1.1.17 18Dec01 akpm
+    - PCI ID 9805 is a Python-T, not a dual-port Cyclone.  Apparently.
+      And it has NWAY.
+    - Mask our advertised modes (vp->advertising) with our capabilities
+	  (MII reg5) when deciding which duplex mode to use.
+    - Add `global_options' as default for options[].  Ditto global_enable_wol,
+      global_full_duplex.
+
+   LK1.1.18 01Jul02 akpm
+    - Fix for undocumented transceiver power-up bit on some 3c566B's
+      (Donald Becker, Rahul Karnik)
 
-    - See http://www.uow.edu.au/~andrewm/linux/#3c59x-2.3 for more details.
+    - See http://www.zip.com.au/~akpm/linux/#3c59x-2.3 for more details.
     - Also see Documentation/networking/vortex.txt
 */
 
@@ -186,7 +193,7 @@
 
 
 #define DRV_NAME	"3c59x"
-#define DRV_VERSION	"LK1.1.18-ac"
+#define DRV_VERSION	"LK1.1.18"
 #define DRV_RELDATE	"1 July 2002"
 
 
@@ -201,11 +208,11 @@
 /* Set the copy breakpoint for the copy-only-tiny-frames scheme.
    Setting to > 1512 effectively disables this feature. */
 #ifndef __arm__
-static const int rx_copybreak = 200;
+static int rx_copybreak = 200;
 #else
 /* ARM systems perform better by disregarding the bus-master
    transfer capability of these cards. -- rmk */
-static const int rx_copybreak = 1513;
+static int rx_copybreak = 1513;
 #endif
 /* Allow setting MTU to a larger size, bypassing the normal ethernet setup. */
 static const int mtu = 1500;
@@ -228,16 +235,9 @@ static int vortex_debug = VORTEX_DEBUG;
 static int vortex_debug = 1;
 #endif
 
-#ifndef __OPTIMIZE__
-#error You must compile this file with the correct options!
-#error See the last lines of the source file.
-#error You must compile this driver with "-O".
-#endif
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/errno.h>
@@ -246,6 +246,7 @@ static int vortex_debug = 1;
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
+#include <linux/if.h>
 #include <linux/mii.h>
 #include <linux/init.h>
 #include <linux/netdevice.h>
@@ -275,10 +276,13 @@ MODULE_DESCRIPTION("3Com 3c59x/3c9xx eth
 MODULE_LICENSE("GPL");
 
 MODULE_PARM(debug, "i");
+MODULE_PARM(global_options, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(8) "i");
+MODULE_PARM(global_full_duplex, "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(8) "i");
 MODULE_PARM(hw_checksums, "1-" __MODULE_STRING(8) "i");
 MODULE_PARM(flow_ctrl, "1-" __MODULE_STRING(8) "i");
+MODULE_PARM(global_enable_wol, "i");
 MODULE_PARM(enable_wol, "1-" __MODULE_STRING(8) "i");
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(max_interrupt_work, "i");
@@ -288,10 +292,13 @@ MODULE_PARM(compaq_device_id, "i");
 MODULE_PARM(watchdog, "i");
 MODULE_PARM_DESC(debug, "3c59x debug level (0-6)");
 MODULE_PARM_DESC(options, "3c59x: Bits 0-3: media type, bit 4: bus mastering, bit 9: full duplex");
+MODULE_PARM_DESC(global_options, "3c59x: same as options, but applies to all NICs if options is unset");
 MODULE_PARM_DESC(full_duplex, "3c59x full duplex setting(s) (1)");
+MODULE_PARM_DESC(global_full_duplex, "3c59x: same as full_duplex, but applies to all NICs if options is unset");
 MODULE_PARM_DESC(hw_checksums, "3c59x Hardware checksum checking by adapter(s) (0-1)");
 MODULE_PARM_DESC(flow_ctrl, "3c59x 802.3x flow control usage (PAUSE only) (0-1)");
 MODULE_PARM_DESC(enable_wol, "3c59x: Turn on Wake-on-LAN for adapter(s) (0-1)");
+MODULE_PARM_DESC(global_enable_wol, "3c59x: same as enable_wol, but applies to all NICs if options is unset");
 MODULE_PARM_DESC(rx_copybreak, "3c59x copy breakpoint for copy-only-tiny-frames");
 MODULE_PARM_DESC(max_interrupt_work, "3c59x maximum events handled per interrupt");
 MODULE_PARM_DESC(compaq_ioaddr, "3c59x PCI I/O base address (Compaq BIOS problem workaround)");
@@ -405,7 +412,8 @@ enum {	IS_VORTEX=1, IS_BOOMERANG=2, IS_C
 	EEPROM_8BIT=0x10,	/* AKPM: Uses 0x230 as the base bitmaps for EEPROM reads */
 	HAS_PWR_CTRL=0x20, HAS_MII=0x40, HAS_NWAY=0x80, HAS_CB_FNS=0x100,
 	INVERT_MII_PWR=0x200, INVERT_LED_PWR=0x400, MAX_COLLISION_RESET=0x800,
-	EEPROM_OFFSET=0x1000, HAS_HWCKSM=0x2000, WNO_XCVR_PWR=0x4000 };
+	EEPROM_OFFSET=0x1000, HAS_HWCKSM=0x2000, WNO_XCVR_PWR=0x4000,
+	EXTRA_PREAMBLE=0x8000, };
 
 enum vortex_chips {
 	CH_3C590 = 0,
@@ -429,6 +437,7 @@ enum vortex_chips {
 	CH_3C905B_2,
 	CH_3C905B_FX,
 	CH_3C905C,
+	CH_3C9202,
 	CH_3C980,
 	CH_3C9805,
 
@@ -484,7 +493,7 @@ static struct vortex_chip_info {
 	{"3c900 Boomerang 10Mbps Combo",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG, 64, },
 	{"3c900 Cyclone 10Mbps TPO",						/* AKPM: from Don's 0.99M */
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },
+	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
 	{"3c900 Cyclone 10Mbps Combo",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
 
@@ -497,19 +506,21 @@ static struct vortex_chip_info {
 	{"3c905 Boomerang 100baseT4",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|HAS_MII, 64, },
 	{"3c905B Cyclone 100baseTx",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },
+	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE, 128, },
 
 	{"3c905B Cyclone 10/100/BNC",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },
 	{"3c905B-FX Cyclone 100baseFx",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
 	{"3c905C Tornado",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM, 128, },
+	PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE, 128, },
+	{"3c920B-EMB-WNM (ATI Radeon 9100 IGP)",
+	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_MII|HAS_HWCKSM, 128, },
 	{"3c980 Cyclone",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
+
 	{"3c980C Python-T",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },
-
 	{"3cSOHO100-TX Hurricane",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },
 	{"3c555 Laptop Hurricane",
@@ -520,9 +531,9 @@ static struct vortex_chip_info {
 	{"3c556B Laptop Hurricane",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|EEPROM_OFFSET|HAS_CB_FNS|INVERT_MII_PWR|
 	                                WNO_XCVR_PWR|HAS_HWCKSM, 128, },
+
 	{"3c575 [Megahertz] 10/100 LAN 	CardBus",
 	PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|HAS_MII|EEPROM_8BIT, 128, },
-
 	{"3c575 Boomerang CardBus",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|HAS_MII|EEPROM_8BIT, 128, },
 	{"3CCFE575BT Cyclone CardBus",
@@ -534,10 +545,10 @@ static struct vortex_chip_info {
 	{"3CCFE656 Cyclone CardBus",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_CB_FNS|EEPROM_8BIT|INVERT_MII_PWR|
 									INVERT_LED_PWR|HAS_HWCKSM, 128, },
+
 	{"3CCFEM656B Cyclone+Winmodem CardBus",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_CB_FNS|EEPROM_8BIT|INVERT_MII_PWR|
 									INVERT_LED_PWR|HAS_HWCKSM, 128, },
-
 	{"3CXFEM656C Tornado+Winmodem CardBus",			/* From pcmcia-cs-3.1.5 */
 	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_CB_FNS|EEPROM_8BIT|INVERT_MII_PWR|
 									MAX_COLLISION_RESET|HAS_HWCKSM, 128, },
@@ -547,19 +558,19 @@ static struct vortex_chip_info {
 	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM, 128, },
 	{"3c982 Hydra Dual Port A",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_HWCKSM|HAS_NWAY, 128, },
+
 	{"3c982 Hydra Dual Port B",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_HWCKSM|HAS_NWAY, 128, },
-
 	{"3c905B-T4",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },
+	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE, 128, },
 	{"3c920B-EMB-WNM Tornado",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM, 128, },
 
-	{0,}, /* 0 terminated list. */
+	{NULL,}, /* NULL terminated list. */
 };
 
 
-static struct pci_device_id vortex_pci_tbl[] __devinitdata = {
+static struct pci_device_id vortex_pci_tbl[] = {
 	{ 0x10B7, 0x5900, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C590 },
 	{ 0x10B7, 0x5920, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C592 },
 	{ 0x10B7, 0x5970, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C597 },
@@ -581,6 +592,7 @@ static struct pci_device_id vortex_pci_t
 	{ 0x10B7, 0x9058, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905B_2 },
 	{ 0x10B7, 0x905A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905B_FX },
 	{ 0x10B7, 0x9200, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905C },
+	{ 0x10B7, 0x9202, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C9202 },
 	{ 0x10B7, 0x9800, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C980 },
 	{ 0x10B7, 0x9805, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C9805 },
 
@@ -681,7 +693,7 @@ enum Window2 {			/* Window 2. */
 	Wn2_ResetOptions=12,
 };
 enum Window3 {			/* Window 3: MAC/config bits. */
-	Wn3_Config=0, Wn3_MAC_Ctrl=6, Wn3_Options=8,
+	Wn3_Config=0, Wn3_MaxPktSize=4, Wn3_MAC_Ctrl=6, Wn3_Options=8,
 };
 
 #define BFEXT(value, offset, bitcount)  \
@@ -709,7 +721,8 @@ enum Win4_Media_bits {
 	Media_LnkBeat = 0x0800,
 };
 enum Window7 {					/* Window 7: Bus Master control. */
-	Wn7_MasterAddr = 0, Wn7_MasterLen = 6, Wn7_MasterStatus = 12,
+	Wn7_MasterAddr = 0, Wn7_VlanEtherType=4, Wn7_MasterLen = 6,
+	Wn7_MasterStatus = 12,
 };
 /* Boomerang bus master control registers. */
 enum MasterCtrl {
@@ -806,7 +819,8 @@ struct vortex_private {
 		pm_state_valid:1,				/* power_state[] has sane contents */
 		open:1,
 		medialock:1,
-		must_free_region:1;				/* Flag: if zero, Cardbus owns the I/O region */
+		must_free_region:1,				/* Flag: if zero, Cardbus owns the I/O region */
+		large_frames:1;			/* accept large frames */
 	int drv_flags;
 	u16 status_enable;
 	u16 intr_enable;
@@ -822,6 +836,12 @@ struct vortex_private {
 	u32 power_state[16];
 };
 
+#ifdef CONFIG_PCI
+#define VORTEX_PCI(dev) ((dev)->pdev)
+#else
+#define VORTEX_PCI(dev) NULL
+#endif
+
 /* The action to take with a media selection timer tick.
    Note that we deviate from the 3Com order by checking 10base2 before AUI.
  */
@@ -853,7 +873,7 @@ static struct media_table {
 static int vortex_probe1(struct pci_dev *pdev, long ioaddr, int irq,
 				   int chip_idx, int card_idx);
 static void vortex_up(struct net_device *dev);
-static void vortex_down(struct net_device *dev);
+static void vortex_down(struct net_device *dev, int final);
 static int vortex_open(struct net_device *dev);
 static void mdio_sync(long ioaddr, int bits);
 static int mdio_read(struct net_device *dev, int phy_id, int location);
@@ -864,17 +884,21 @@ static int vortex_start_xmit(struct sk_b
 static int boomerang_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static int vortex_rx(struct net_device *dev);
 static int boomerang_rx(struct net_device *dev);
-static void vortex_interrupt(int irq, void *dev_id, struct pt_regs *regs);
-static void boomerang_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t vortex_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t boomerang_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 static int vortex_close(struct net_device *dev);
 static void dump_tx_ring(struct net_device *dev);
 static void update_stats(long ioaddr, struct net_device *dev);
 static struct net_device_stats *vortex_get_stats(struct net_device *dev);
 static void set_rx_mode(struct net_device *dev);
+#ifdef CONFIG_PCI
 static int vortex_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
+#endif
 static void vortex_tx_timeout(struct net_device *dev);
 static void acpi_set_WOL(struct net_device *dev);
 static struct ethtool_ops vortex_ethtool_ops;
+static void set_8021q_mode(struct net_device *dev, int enable);
+
 
 /* This driver uses 'options' to pass the media type, full-duplex flag, etc. */
 /* Option count limit only -- unlimited interfaces are supported. */
@@ -884,6 +908,9 @@ static int full_duplex[MAX_UNITS] = {-1,
 static int hw_checksums[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
 static int flow_ctrl[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
 static int enable_wol[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
+static int global_options = -1;
+static int global_full_duplex = -1;
+static int global_enable_wol = -1;
 
 /* #define dev_alloc_skb dev_alloc_skb_debug */
 
@@ -895,6 +922,18 @@ static int compaq_ioaddr, compaq_irq, co
 
 static int vortex_cards_found;
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void poll_vortex(struct net_device *dev)
+{
+	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	unsigned long flags;
+	local_save_flags(flags);
+	local_irq_disable();
+	(vp->full_bus_master_rx ? boomerang_interrupt:vortex_interrupt)(dev->irq,dev,NULL);
+	local_irq_restore(flags);
+} 
+#endif
+
 #ifdef CONFIG_PM
 
 static int vortex_suspend (struct pci_dev *pdev, u32 state)
@@ -904,7 +943,7 @@ static int vortex_suspend (struct pci_de
 	if (dev && dev->priv) {
 		if (netif_running(dev)) {
 			netif_device_detach(dev);
-			vortex_down(dev);
+			vortex_down(dev, 1);
 		}
 	}
 	return 0;
@@ -1006,9 +1045,9 @@ static int __devinit vortex_probe1(struc
 	int i, step;
 	struct net_device *dev;
 	static int printed_version;
-	int retval;
+	int retval, print_info;
 	struct vortex_chip_info * const vci = &vortex_info_tbl[chip_idx];
-	char *print_name;
+	char *print_name = "3c59x";
 
 	if (!printed_version) {
 		printk (version);
@@ -1024,7 +1063,10 @@ static int __devinit vortex_probe1(struc
 		goto out;
 	}
 	SET_MODULE_OWNER(dev);
-	vp = dev->priv;
+	SET_NETDEV_DEV(dev, gendev);
+	vp = netdev_priv(dev);
+
+	option = global_options;
 
 	/* The lower four bits are the media type. */
 	if (dev->mem_start) {
@@ -1034,10 +1076,10 @@ static int __devinit vortex_probe1(struc
 		 */
 		option = dev->mem_start;
 	}
-	else if (card_idx < MAX_UNITS)
-		option = options[card_idx];
-	else
-		option = -1;
+	else if (card_idx < MAX_UNITS) {
+		if (options[card_idx] >= 0)
+			option = options[card_idx];
+	}
 
 	if (option > 0) {
 		if (option & 0x8000)
@@ -1048,7 +1090,10 @@ static int __devinit vortex_probe1(struc
 			vp->enable_wol = 1;
 	}
 
-	printk (KERN_INFO "See Documentation/networking/vortex.txt\n");
+	print_info = (vortex_debug > 1);
+	if (print_info)
+		printk (KERN_INFO "See Documentation/networking/vortex.txt\n");
+
 	printk(KERN_INFO "%s: 3Com %s %s at 0x%lx. Vers " DRV_VERSION "\n",
 	       print_name,
 	       pdev ? "PCI" : "EISA",
@@ -1058,6 +1103,7 @@ static int __devinit vortex_probe1(struc
 	dev->base_addr = ioaddr;
 	dev->irq = irq;
 	dev->mtu = mtu;
+	vp->large_frames = mtu > 1500;
 	vp->drv_flags = vci->drv_flags;
 	vp->has_nway = (vci->drv_flags & HAS_NWAY) ? 1 : 0;
 	vp->io_size = vci->io_size;
@@ -1127,6 +1173,11 @@ static int __devinit vortex_probe1(struc
 		vp->bus_master = (option & 16) ? 1 : 0;
 	}
 
+	if (global_full_duplex > 0)
+		vp->full_duplex = 1;
+	if (global_enable_wol > 0)
+		vp->enable_wol = 1;
+
 	if (card_idx < MAX_UNITS) {
 		if (full_duplex[card_idx] > 0)
 			vp->full_duplex = 1;
@@ -1174,16 +1225,20 @@ static int __devinit vortex_probe1(struc
 		printk(" ***INVALID CHECKSUM %4.4x*** ", checksum);
 	for (i = 0; i < 3; i++)
 		((u16 *)dev->dev_addr)[i] = htons(eeprom[i + 10]);
-	for (i = 0; i < 6; i++)
-		printk("%c%2.2x", i ? ':' : ' ', dev->dev_addr[i]);
+	if (print_info) {
+		for (i = 0; i < 6; i++)
+			printk("%c%2.2x", i ? ':' : ' ', dev->dev_addr[i]);
+	}
 	EL3WINDOW(2);
 	for (i = 0; i < 6; i++)
 		outb(dev->dev_addr[i], ioaddr + i);
 
 #ifdef __sparc__
-	printk(", IRQ %s\n", __irq_itoa(dev->irq));
+	if (print_info)
+		printk(", IRQ %s\n", __irq_itoa(dev->irq));
 #else
-	printk(", IRQ %d\n", dev->irq);
+	if (print_info)
+		printk(", IRQ %d\n", dev->irq);
 	/* Tell them about an invalid IRQ. */
 	if (dev->irq <= 0 || dev->irq >= NR_IRQS)
 		printk(KERN_WARNING " *** Warning: IRQ %d is unlikely to work! ***\n",
@@ -1192,9 +1247,12 @@ static int __devinit vortex_probe1(struc
 
 	EL3WINDOW(4);
 	step = (inb(ioaddr + Wn4_NetDiag) & 0x1e) >> 1;
-	printk(KERN_INFO "  product code %02x%02x rev %02x.%d date %02d-"
-		"%02d-%02d\n", eeprom[6]&0xff, eeprom[6]>>8, eeprom[0x14],
-		step, (eeprom[4]>>5) & 15, eeprom[4] & 31, eeprom[4]>>9);
+	if (print_info) {
+		printk(KERN_INFO "  product code %02x%02x rev %02x.%d date %02d-"
+			"%02d-%02d\n", eeprom[6]&0xff, eeprom[6]>>8, eeprom[0x14],
+			step, (eeprom[4]>>5) & 15, eeprom[4] & 31, eeprom[4]>>9);
+	}
+
 
 	if (pdev && vci->drv_flags & HAS_CB_FNS) {
 		unsigned long fn_st_addr;			/* Cardbus function status space */
@@ -1207,8 +1265,10 @@ static int __devinit vortex_probe1(struc
 			if (!vp->cb_fn_base)
 				goto free_ring;
 		}
-		printk(KERN_INFO "%s: CardBus functions mapped %8.8lx->%p\n",
-			print_name, fn_st_addr, vp->cb_fn_base);
+		if (print_info) {
+			printk(KERN_INFO "%s: CardBus functions mapped %8.8lx->%p\n",
+				print_name, fn_st_addr, vp->cb_fn_base);
+		}
 		EL3WINDOW(2);
 
 		n = inw(ioaddr + Wn2_ResetOptions) & ~0x4010;
@@ -1230,7 +1290,8 @@ static int __devinit vortex_probe1(struc
 
 	if (vp->info1 & 0x8000) {
 		vp->full_duplex = 1;
-		printk(KERN_INFO "Full duplex capable\n");
+		if (print_info)
+			printk(KERN_INFO "Full duplex capable\n");
 	}
 
 	{
@@ -1241,16 +1302,17 @@ static int __devinit vortex_probe1(struc
 		if ((vp->available_media & 0xff) == 0)		/* Broken 3c916 */
 			vp->available_media = 0x40;
 		config = inl(ioaddr + Wn3_Config);
-		printk(KERN_DEBUG "  Internal config register is %4.4x, "
-				"transceivers %#x.\n", config,
-				inw(ioaddr + Wn3_Options));
-		printk(KERN_INFO "  %dK %s-wide RAM %s Rx:Tx split, %s%s interface.\n",
-			   8 << RAM_SIZE(config),
-			   RAM_WIDTH(config) ? "word" : "byte",
-			   ram_split[RAM_SPLIT(config)],
-			   AUTOSELECT(config) ? "autoselect/" : "",
-			   XCVR(config) > XCVR_ExtMII ? "<invalid transceiver>" :
-			   media_tbl[XCVR(config)].name);
+		if (print_info) {
+			printk(KERN_DEBUG "  Internal config register is %4.4x, "
+				   "transceivers %#x.\n", config, inw(ioaddr + Wn3_Options));
+			printk(KERN_INFO "  %dK %s-wide RAM %s Rx:Tx split, %s%s interface.\n",
+				   8 << RAM_SIZE(config),
+				   RAM_WIDTH(config) ? "word" : "byte",
+				   ram_split[RAM_SPLIT(config)],
+				   AUTOSELECT(config) ? "autoselect/" : "",
+				   XCVR(config) > XCVR_ExtMII ? "<invalid transceiver>" :
+				   media_tbl[XCVR(config)].name);
+		}
 		vp->default_media = XCVR(config);
 		if (vp->default_media == XCVR_NWAY)
 			vp->has_nway = 1;
@@ -1265,11 +1327,14 @@ static int __devinit vortex_probe1(struc
 	} else
 		dev->if_port = vp->default_media;
 
-	if (dev->if_port == XCVR_MII || dev->if_port == XCVR_NWAY) {
+	if ((vp->available_media & 0x40) || (vci->drv_flags & HAS_NWAY) ||
+		dev->if_port == XCVR_MII || dev->if_port == XCVR_NWAY) {
 		int phy, phy_idx = 0;
 		EL3WINDOW(4);
 		mii_preamble_required++;
-		mii_preamble_required++;
+		if (vp->drv_flags & EXTRA_PREAMBLE)
+			mii_preamble_required++;
+		mdio_sync(ioaddr, 32);
 		mdio_read(dev, 24, 1);
 		for (phy = 0; phy < 32 && phy_idx < 1; phy++) {
 			int mii_status, phyx;
@@ -1287,9 +1352,10 @@ static int __devinit vortex_probe1(struc
 			mii_status = mdio_read(dev, phyx, 1);
 			if (mii_status  &&  mii_status != 0xffff) {
 				vp->phys[phy_idx++] = phyx;
-				printk(KERN_INFO "  MII transceiver found at "
-					"address %d, status %4x.\n",
-					phyx, mii_status);
+				if (print_info) {
+					printk(KERN_INFO "  MII transceiver found at address %d,"
+						" status %4x.\n", phyx, mii_status);
+				}
 				if ((mii_status & 0x0040) == 0)
 					mii_preamble_required++;
 			}
@@ -1310,9 +1376,10 @@ static int __devinit vortex_probe1(struc
 
 	if (vp->capabilities & CapBusMaster) {
 		vp->full_bus_master_tx = 1;
-		printk(KERN_INFO "  Enabling bus-master transmits and %s "
-				"receives.\n",
+		if (print_info) {
+			printk(KERN_INFO "  Enabling bus-master transmits and %s receives.\n",
 			(vp->info2 & 1) ? "early" : "whole-frame" );
+		}
 		vp->full_bus_master_rx = (vp->info2 & 1) ? 1 : 2;
 		vp->bus_master = 0;		/* AKPM: vortex only */
 	}
@@ -1331,21 +1398,28 @@ static int __devinit vortex_probe1(struc
 		dev->hard_start_xmit = vortex_start_xmit;
 	}
 
-	printk(KERN_INFO "%s: scatter/gather %sabled. h/w checksums %sabled\n",
-			print_name,
-			(dev->features & NETIF_F_SG) ? "en":"dis",
-			(dev->features & NETIF_F_IP_CSUM) ? "en":"dis");
+	if (print_info) {
+		printk(KERN_INFO "%s: scatter/gather %sabled. h/w checksums %sabled\n",
+				print_name,
+				(dev->features & NETIF_F_SG) ? "en":"dis",
+				(dev->features & NETIF_F_IP_CSUM) ? "en":"dis");
+	}
 
 	dev->stop = vortex_close;
 	dev->get_stats = vortex_get_stats;
+#ifdef CONFIG_PCI
 	dev->do_ioctl = vortex_ioctl;
+#endif
 	dev->ethtool_ops = &vortex_ethtool_ops;
 	dev->set_multicast_list = set_rx_mode;
 	dev->tx_timeout = vortex_tx_timeout;
 	dev->watchdog_timeo = (watchdog * HZ) / 1000;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller = poll_vortex; 
+#endif
 	if (pdev && vp->enable_wol) {
 		vp->pm_state_valid = 1;
- 		pci_save_state(vp->pdev, vp->power_state);
+ 		pci_save_state(VORTEX_PCI(vp), vp->power_state);
  		acpi_set_WOL(dev);
 	}
 	retval = register_netdev(dev);
@@ -1361,7 +1435,7 @@ free_ring:
 free_region:
 	if (vp->must_free_region)
 		release_region(ioaddr, vci->io_size);
-	kfree (dev);
+	free_netdev(dev);
 	printk(KERN_ERR PFX "vortex_probe1 fails.  Returns %d\n", retval);
 out:
 	return retval;
@@ -1396,13 +1470,13 @@ static void
 vortex_up(struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
-	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 	unsigned int config;
 	int i;
 
-	if (vp->pdev && vp->enable_wol) {
-		pci_set_power_state(vp->pdev, 0);	/* Go active */
-		pci_restore_state(vp->pdev, vp->power_state);
+	if (VORTEX_PCI(vp) && vp->enable_wol) {
+		pci_set_power_state(VORTEX_PCI(vp), 0);	/* Go active */
+		pci_restore_state(VORTEX_PCI(vp), vp->power_state);
 	}
 
 	/* Before initializing select the active media port. */
@@ -1465,9 +1539,10 @@ vortex_up(struct net_device *dev)
 		if (mii_reg5 == 0xffff  ||  mii_reg5 == 0x0000) {
 			netif_carrier_off(dev); /* No MII device or no link partner report */
 		} else {
+			mii_reg5 &= vp->advertising;
 			if ((mii_reg5 & 0x0100) != 0	/* 100baseTx-FD */
 				 || (mii_reg5 & 0x00C0) == 0x0040) /* 10T-FD, but not 100-HD */
-				vp->full_duplex = 1;
+			vp->full_duplex = 1;
 			netif_carrier_on(dev);
 		}
 		vp->partner_flow_ctrl = ((mii_reg5 & 0x0400) != 0);
@@ -1482,7 +1557,7 @@ vortex_up(struct net_device *dev)
 
 	/* Set the full-duplex bit. */
 	outw(	((vp->info1 & 0x8000) || vp->full_duplex ? 0x20 : 0) |
-		 	(dev->mtu > 1500 ? 0x40 : 0) |
+		 	(vp->large_frames ? 0x40 : 0) |
 			((vp->full_duplex && vp->flow_ctrl && vp->partner_flow_ctrl) ? 0x100 : 0),
 			ioaddr + Wn3_MAC_Ctrl);
 
@@ -1561,11 +1636,13 @@ vortex_up(struct net_device *dev)
 		for (i = 0; i < RX_RING_SIZE; i++)	/* AKPM: this is done in vortex_open, too */
 			vp->rx_ring[i].status = 0;
 		for (i = 0; i < TX_RING_SIZE; i++)
-			vp->tx_skbuff[i] = 0;
+			vp->tx_skbuff[i] = NULL;
 		outl(0, ioaddr + DownListPtr);
 	}
 	/* Set receiver mode: presumably accept b-case and phys addr only. */
 	set_rx_mode(dev);
+	/* enable 802.1q tagged frames */
+	set_8021q_mode(dev, 1);
 	outw(StatsEnable, ioaddr + EL3_CMD); /* Turn on statistics. */
 
 //	issue_and_wait(dev, SetTxStart|0x07ff);
@@ -1593,7 +1670,7 @@ vortex_up(struct net_device *dev)
 static int
 vortex_open(struct net_device *dev)
 {
-	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 	int i;
 	int retval;
 
@@ -1618,7 +1695,7 @@ vortex_open(struct net_device *dev)
 				break;			/* Bad news!  */
 			skb->dev = dev;			/* Mark as being used by this device. */
 			skb_reserve(skb, 2);	/* Align IP on 16 byte boundaries */
-			vp->rx_ring[i].addr = cpu_to_le32(pci_map_single(vp->pdev, skb->tail, PKT_BUF_SZ, PCI_DMA_FROMDEVICE));
+			vp->rx_ring[i].addr = cpu_to_le32(pci_map_single(VORTEX_PCI(vp), skb->tail, PKT_BUF_SZ, PCI_DMA_FROMDEVICE));
 		}
 		if (i != RX_RING_SIZE) {
 			int j;
@@ -1626,7 +1703,7 @@ vortex_open(struct net_device *dev)
 			for (j = 0; j < i; j++) {
 				if (vp->rx_skbuff[j]) {
 					dev_kfree_skb(vp->rx_skbuff[j]);
-					vp->rx_skbuff[j] = 0;
+					vp->rx_skbuff[j] = NULL;
 				}
 			}
 			retval = -ENOMEM;
@@ -1651,7 +1728,7 @@ static void
 vortex_timer(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *)data;
-	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int next_tick = 60*HZ;
 	int ok = 0;
@@ -1695,8 +1772,10 @@ vortex_timer(unsigned long data)
 			if (mii_status & BMSR_LSTATUS) {
 				int mii_reg5 = mdio_read(dev, vp->phys[0], 5);
 				if (! vp->force_fd  &&  mii_reg5 != 0xffff) {
-					int duplex = (mii_reg5&0x0100) ||
-						(mii_reg5 & 0x01C0) == 0x0040;
+					int duplex;
+
+					mii_reg5 &= vp->advertising;
+					duplex = (mii_reg5&0x0100) || (mii_reg5 & 0x01C0) == 0x0040;
 					if (vp->full_duplex != duplex) {
 						vp->full_duplex = duplex;
 						printk(KERN_INFO "%s: Setting %s-duplex based on MII "
@@ -1706,7 +1785,7 @@ vortex_timer(unsigned long data)
 						/* Set the full-duplex bit. */
 						EL3WINDOW(3);
 						outw(	(vp->full_duplex ? 0x20 : 0) |
-								(dev->mtu > 1500 ? 0x40 : 0) |
+								(vp->large_frames ? 0x40 : 0) |
 								((vp->full_duplex && vp->flow_ctrl && vp->partner_flow_ctrl) ? 0x100 : 0),
 								ioaddr + Wn3_MAC_Ctrl);
 						if (vortex_debug > 1)
@@ -1775,16 +1854,18 @@ leave_media_alone:
 
 static void vortex_tx_timeout(struct net_device *dev)
 {
-	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 
 	printk(KERN_ERR "%s: transmit timed out, tx_status %2.2x status %4.4x.\n",
 		   dev->name, inb(ioaddr + TxStatus),
 		   inw(ioaddr + EL3_STATUS));
 	EL3WINDOW(4);
-	printk(KERN_ERR "  diagnostics: net %04x media %04x dma %8.8x.\n",
-		   inw(ioaddr + Wn4_NetDiag), inw(ioaddr + Wn4_Media),
-		   inl(ioaddr + PktStatus));
+	printk(KERN_ERR "  diagnostics: net %04x media %04x dma %08x fifo %04x\n",
+			inw(ioaddr + Wn4_NetDiag),
+			inw(ioaddr + Wn4_Media),
+			inl(ioaddr + PktStatus),
+			inw(ioaddr + Wn4_FIFODiag));
 	/* Slight code bloat to be user friendly. */
 	if ((inb(ioaddr + TxStatus) & 0x88) == 0x88)
 		printk(KERN_ERR "%s: Transmitter encountered 16 collisions --"
@@ -1800,9 +1881,9 @@ static void vortex_tx_timeout(struct net
 			unsigned long flags;
 			local_irq_save(flags);
 			if (vp->full_bus_master_tx)
-				boomerang_interrupt(dev->irq, dev, 0);
+				boomerang_interrupt(dev->irq, dev, NULL);
 			else
-				vortex_interrupt(dev->irq, dev, 0);
+				vortex_interrupt(dev->irq, dev, NULL);
 			local_irq_restore(flags);
 		}
 	}
@@ -1843,7 +1924,7 @@ static void vortex_tx_timeout(struct net
 static void
 vortex_error(struct net_device *dev, int status)
 {
-	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int do_tx_reset = 0, reset_mask = 0;
 	unsigned char tx_status = 0;
@@ -1919,7 +2000,8 @@ vortex_error(struct net_device *dev, int
 				printk(KERN_ERR "%s: PCI bus error, bus status %8.8x\n", dev->name, bus_status);
 
 			/* In this case, blow the card away */
-			vortex_down(dev);
+			/* Must not enter D3 or we can't legally issue the reset! */
+			vortex_down(dev, 0);
 			issue_and_wait(dev, TotalReset | 0xff);
 			vortex_up(dev);		/* AKPM: bug.  vortex_up() assumes that the rx ring is full. It may not be. */
 		} else if (fifo_diag & 0x0400)
@@ -1929,6 +2011,8 @@ vortex_error(struct net_device *dev, int
 			issue_and_wait(dev, RxReset|0x07);
 			/* Set the Rx filter to the current state. */
 			set_rx_mode(dev);
+			/* enable 802.1q VLAN tagged frames */
+			set_8021q_mode(dev, 1);
 			outw(RxEnable, ioaddr + EL3_CMD); /* Re-enable the receiver. */
 			outw(AckIntr | HostError, ioaddr + EL3_CMD);
 		}
@@ -1945,7 +2029,7 @@ vortex_error(struct net_device *dev, int
 static int
 vortex_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 
 	/* Put out the doubleword header... */
@@ -1953,7 +2037,7 @@ vortex_start_xmit(struct sk_buff *skb, s
 	if (vp->bus_master) {
 		/* Set the bus-master controller to transfer the packet. */
 		int len = (skb->len + 3) & ~3;
-		outl(	vp->tx_skb_dma = pci_map_single(vp->pdev, skb->data, len, PCI_DMA_TODEVICE),
+		outl(	vp->tx_skb_dma = pci_map_single(VORTEX_PCI(vp), skb->data, len, PCI_DMA_TODEVICE),
 				ioaddr + Wn7_MasterAddr);
 		outw(len, ioaddr + Wn7_MasterLen);
 		vp->tx_skb = skb;
@@ -2000,7 +2084,7 @@ vortex_start_xmit(struct sk_buff *skb, s
 static int
 boomerang_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	/* Calculate the next Tx descriptor entry. */
 	int entry = vp->cur_tx % TX_RING_SIZE;
@@ -2029,16 +2113,16 @@ boomerang_start_xmit(struct sk_buff *skb
 	if (skb->ip_summed != CHECKSUM_HW)
 			vp->tx_ring[entry].status = cpu_to_le32(skb->len | TxIntrUploaded);
 	else
-			vp->tx_ring[entry].status = cpu_to_le32(skb->len | TxIntrUploaded | AddTCPChksum);
+			vp->tx_ring[entry].status = cpu_to_le32(skb->len | TxIntrUploaded | AddTCPChksum | AddUDPChksum);
 
 	if (!skb_shinfo(skb)->nr_frags) {
-		vp->tx_ring[entry].frag[0].addr = cpu_to_le32(pci_map_single(vp->pdev, skb->data,
+		vp->tx_ring[entry].frag[0].addr = cpu_to_le32(pci_map_single(VORTEX_PCI(vp), skb->data,
 										skb->len, PCI_DMA_TODEVICE));
 		vp->tx_ring[entry].frag[0].length = cpu_to_le32(skb->len | LAST_FRAG);
 	} else {
 		int i;
 
-		vp->tx_ring[entry].frag[0].addr = cpu_to_le32(pci_map_single(vp->pdev, skb->data,
+		vp->tx_ring[entry].frag[0].addr = cpu_to_le32(pci_map_single(VORTEX_PCI(vp), skb->data,
 										skb->len-skb->data_len, PCI_DMA_TODEVICE));
 		vp->tx_ring[entry].frag[0].length = cpu_to_le32(skb->len-skb->data_len);
 
@@ -2046,7 +2130,7 @@ boomerang_start_xmit(struct sk_buff *skb
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
 			vp->tx_ring[entry].frag[i+1].addr =
-					cpu_to_le32(pci_map_single(vp->pdev,
+					cpu_to_le32(pci_map_single(VORTEX_PCI(vp),
 											   (void*)page_address(frag->page) + frag->page_offset,
 											   frag->size, PCI_DMA_TODEVICE));
 
@@ -2057,7 +2141,7 @@ boomerang_start_xmit(struct sk_buff *skb
 		}
 	}
 #else
-	vp->tx_ring[entry].addr = cpu_to_le32(pci_map_single(vp->pdev, skb->data, skb->len, PCI_DMA_TODEVICE));
+	vp->tx_ring[entry].addr = cpu_to_le32(pci_map_single(VORTEX_PCI(vp), skb->data, skb->len, PCI_DMA_TODEVICE));
 	vp->tx_ring[entry].length = cpu_to_le32(skb->len | LAST_FRAG);
 	vp->tx_ring[entry].status = cpu_to_le32(skb->len | TxIntrUploaded);
 #endif
@@ -2096,14 +2180,16 @@ boomerang_start_xmit(struct sk_buff *skb
  * full_bus_master_tx == 0 && full_bus_master_rx == 0
  */
 
-static void vortex_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t
+vortex_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct net_device *dev = dev_id;
-	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 	long ioaddr;
 	int status;
 	int work_done = max_interrupt_work;
-	
+	int handled = 0;
+
 	ioaddr = dev->base_addr;
 	spin_lock(&vp->lock);
 
@@ -2114,6 +2200,7 @@ static void vortex_interrupt(int irq, vo
 
 	if ((status & IntLatch) == 0)
 		goto handler_exit;		/* No interrupt: shared IRQs cause this */
+	handled = 1;
 
 	if (status & IntReq) {
 		status |= vp->deferred;
@@ -2145,7 +2232,7 @@ static void vortex_interrupt(int irq, vo
 		if (status & DMADone) {
 			if (inw(ioaddr + Wn7_MasterStatus) & 0x1000) {
 				outw(0x1000, ioaddr + Wn7_MasterStatus); /* Ack the event. */
-				pci_unmap_single(vp->pdev, vp->tx_skb_dma, (vp->tx_skb->len + 3) & ~3, PCI_DMA_TODEVICE);
+				pci_unmap_single(VORTEX_PCI(vp), vp->tx_skb_dma, (vp->tx_skb->len + 3) & ~3, PCI_DMA_TODEVICE);
 				dev_kfree_skb_irq(vp->tx_skb); /* Release the transferred buffer */
 				if (inw(ioaddr + TxFree) > 1536) {
 					/*
@@ -2190,6 +2277,7 @@ static void vortex_interrupt(int irq, vo
 			   dev->name, status);
 handler_exit:
 	spin_unlock(&vp->lock);
+	return IRQ_RETVAL(handled);
 }
 
 /*
@@ -2197,10 +2285,11 @@ handler_exit:
  * full_bus_master_tx == 1 && full_bus_master_rx == 1
  */
 
-static void boomerang_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t
+boomerang_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct net_device *dev = dev_id;
-	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 	long ioaddr;
 	int status;
 	int work_done = max_interrupt_work;
@@ -2266,16 +2355,16 @@ static void boomerang_interrupt(int irq,
 #if DO_ZEROCOPY					
 					int i;
 					for (i=0; i<=skb_shinfo(skb)->nr_frags; i++)
-							pci_unmap_single(vp->pdev,
+							pci_unmap_single(VORTEX_PCI(vp),
 											 le32_to_cpu(vp->tx_ring[entry].frag[i].addr),
 											 le32_to_cpu(vp->tx_ring[entry].frag[i].length)&0xFFF,
 											 PCI_DMA_TODEVICE);
 #else
-					pci_unmap_single(vp->pdev,
+					pci_unmap_single(VORTEX_PCI(vp),
 						le32_to_cpu(vp->tx_ring[entry].addr), skb->len, PCI_DMA_TODEVICE);
 #endif
 					dev_kfree_skb_irq(skb);
-					vp->tx_skbuff[entry] = 0;
+					vp->tx_skbuff[entry] = NULL;
 				} else {
 					printk(KERN_DEBUG "boomerang_interrupt: no skb!\n");
 				}
@@ -2320,11 +2409,12 @@ static void boomerang_interrupt(int irq,
 			   dev->name, status);
 handler_exit:
 	spin_unlock(&vp->lock);
+	return IRQ_HANDLED;
 }
 
 static int vortex_rx(struct net_device *dev)
 {
-	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int i;
 	short rx_status;
@@ -2358,14 +2448,14 @@ static int vortex_rx(struct net_device *
 				/* 'skb_put()' points to the start of sk_buff data area. */
 				if (vp->bus_master &&
 					! (inw(ioaddr + Wn7_MasterStatus) & 0x8000)) {
-					dma_addr_t dma = pci_map_single(vp->pdev, skb_put(skb, pkt_len),
+					dma_addr_t dma = pci_map_single(VORTEX_PCI(vp), skb_put(skb, pkt_len),
 									   pkt_len, PCI_DMA_FROMDEVICE);
 					outl(dma, ioaddr + Wn7_MasterAddr);
 					outw((skb->len + 3) & ~3, ioaddr + Wn7_MasterLen);
 					outw(StartDMAUp, ioaddr + EL3_CMD);
 					while (inw(ioaddr + Wn7_MasterStatus) & 0x8000)
 						;
-					pci_unmap_single(vp->pdev, dma, pkt_len, PCI_DMA_FROMDEVICE);
+					pci_unmap_single(VORTEX_PCI(vp), dma, pkt_len, PCI_DMA_FROMDEVICE);
 				} else {
 					insl(ioaddr + RX_FIFO, skb_put(skb, pkt_len),
 						 (pkt_len + 3) >> 2);
@@ -2394,7 +2484,7 @@ static int vortex_rx(struct net_device *
 static int
 boomerang_rx(struct net_device *dev)
 {
-	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 	int entry = vp->cur_rx % RX_RING_SIZE;
 	long ioaddr = dev->base_addr;
 	int rx_status;
@@ -2431,18 +2521,19 @@ boomerang_rx(struct net_device *dev)
 			if (pkt_len < rx_copybreak && (skb = dev_alloc_skb(pkt_len + 2)) != 0) {
 				skb->dev = dev;
 				skb_reserve(skb, 2);	/* Align IP on 16 byte boundaries */
-				pci_dma_sync_single(vp->pdev, dma, PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
+				pci_dma_sync_single(VORTEX_PCI(vp), dma, PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
 				/* 'skb_put()' points to the start of sk_buff data area. */
 				memcpy(skb_put(skb, pkt_len),
 					   vp->rx_skbuff[entry]->tail,
 					   pkt_len);
+				pci_dma_sync_single(VORTEX_PCI(vp), dma, PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
 				vp->rx_copy++;
 			} else {
 				/* Pass up the skbuff already on the Rx ring. */
 				skb = vp->rx_skbuff[entry];
 				vp->rx_skbuff[entry] = NULL;
 				skb_put(skb, pkt_len);
-				pci_unmap_single(vp->pdev, dma, PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
+				pci_unmap_single(VORTEX_PCI(vp), dma, PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
 				vp->rx_nocopy++;
 			}
 			skb->protocol = eth_type_trans(skb, dev);
@@ -2479,7 +2570,7 @@ boomerang_rx(struct net_device *dev)
 			}
 			skb->dev = dev;			/* Mark as being used by this device. */
 			skb_reserve(skb, 2);	/* Align IP on 16 byte boundaries */
-			vp->rx_ring[entry].addr = cpu_to_le32(pci_map_single(vp->pdev, skb->tail, PKT_BUF_SZ, PCI_DMA_FROMDEVICE));
+			vp->rx_ring[entry].addr = cpu_to_le32(pci_map_single(VORTEX_PCI(vp), skb->tail, PKT_BUF_SZ, PCI_DMA_FROMDEVICE));
 			vp->rx_skbuff[entry] = skb;
 		}
 		vp->rx_ring[entry].status = 0;	/* Clear complete bit. */
@@ -2496,7 +2587,7 @@ static void
 rx_oom_timer(unsigned long arg)
 {
 	struct net_device *dev = (struct net_device *)arg;
-	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 
 	spin_lock_irq(&vp->lock);
 	if ((vp->cur_rx - vp->dirty_rx) == RX_RING_SIZE)	/* This test is redundant, but makes me feel good */
@@ -2509,9 +2600,9 @@ rx_oom_timer(unsigned long arg)
 }
 
 static void
-vortex_down(struct net_device *dev)
+vortex_down(struct net_device *dev, int final_down)
 {
-	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 
 	netif_stop_queue (dev);
@@ -2526,6 +2617,9 @@ vortex_down(struct net_device *dev)
 	outw(RxDisable, ioaddr + EL3_CMD);
 	outw(TxDisable, ioaddr + EL3_CMD);
 
+	/* Disable receiving 802.1q tagged frames */
+	set_8021q_mode(dev, 0);
+
 	if (dev->if_port == XCVR_10base2)
 		/* Turn off thinnet power.  Green! */
 		outw(StopCoax, ioaddr + EL3_CMD);
@@ -2538,8 +2632,8 @@ vortex_down(struct net_device *dev)
 	if (vp->full_bus_master_tx)
 		outl(0, ioaddr + DownListPtr);
 
-	if (vp->pdev && vp->enable_wol) {
-		pci_save_state(vp->pdev, vp->power_state);
+	if (final_down && VORTEX_PCI(vp) && vp->enable_wol) {
+		pci_save_state(VORTEX_PCI(vp), vp->power_state);
 		acpi_set_WOL(dev);
 	}
 }
@@ -2547,12 +2641,12 @@ vortex_down(struct net_device *dev)
 static int
 vortex_close(struct net_device *dev)
 {
-	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int i;
 
 	if (netif_device_present(dev))
-		vortex_down(dev);
+		vortex_down(dev, 1);
 
 	if (vortex_debug > 1) {
 		printk(KERN_DEBUG"%s: vortex_close() status %4.4x, Tx status %2.2x.\n",
@@ -2567,7 +2661,6 @@ vortex_close(struct net_device *dev)
 			((vp->drv_flags & HAS_HWCKSM) == 0) &&
 			(hw_checksums[vp->card_idx] == -1)) {
 		printk(KERN_WARNING "%s supports hardware checksums, and we're not using them!\n", dev->name);
-		printk(KERN_WARNING "Please see http://www.uow.edu.au/~andrewm/zerocopy.html\n");
 	}
 #endif
 		
@@ -2576,10 +2669,10 @@ vortex_close(struct net_device *dev)
 	if (vp->full_bus_master_rx) { /* Free Boomerang bus master Rx buffers. */
 		for (i = 0; i < RX_RING_SIZE; i++)
 			if (vp->rx_skbuff[i]) {
-				pci_unmap_single(	vp->pdev, le32_to_cpu(vp->rx_ring[i].addr),
+				pci_unmap_single(	VORTEX_PCI(vp), le32_to_cpu(vp->rx_ring[i].addr),
 									PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
 				dev_kfree_skb(vp->rx_skbuff[i]);
-				vp->rx_skbuff[i] = 0;
+				vp->rx_skbuff[i] = NULL;
 			}
 	}
 	if (vp->full_bus_master_tx) { /* Free Boomerang bus master Tx buffers. */
@@ -2590,15 +2683,15 @@ vortex_close(struct net_device *dev)
 				int k;
 
 				for (k=0; k<=skb_shinfo(skb)->nr_frags; k++)
-						pci_unmap_single(vp->pdev,
+						pci_unmap_single(VORTEX_PCI(vp),
 										 le32_to_cpu(vp->tx_ring[i].frag[k].addr),
 										 le32_to_cpu(vp->tx_ring[i].frag[k].length)&0xFFF,
 										 PCI_DMA_TODEVICE);
 #else
-				pci_unmap_single(vp->pdev, le32_to_cpu(vp->tx_ring[i].addr), skb->len, PCI_DMA_TODEVICE);
+				pci_unmap_single(VORTEX_PCI(vp), le32_to_cpu(vp->tx_ring[i].addr), skb->len, PCI_DMA_TODEVICE);
 #endif
 				dev_kfree_skb(skb);
-				vp->tx_skbuff[i] = 0;
+				vp->tx_skbuff[i] = NULL;
 			}
 		}
 	}
@@ -2610,7 +2703,7 @@ static void
 dump_tx_ring(struct net_device *dev)
 {
 	if (vortex_debug > 0) {
-		struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 		long ioaddr = dev->base_addr;
 		
 		if (vp->full_bus_master_tx) {
@@ -2643,7 +2736,7 @@ dump_tx_ring(struct net_device *dev)
 
 static struct net_device_stats *vortex_get_stats(struct net_device *dev)
 {
-	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 	unsigned long flags;
 
 	if (netif_device_present(dev)) {	/* AKPM: Used to be netif_running */
@@ -2663,7 +2756,7 @@ static struct net_device_stats *vortex_g
 	*/
 static void update_stats(long ioaddr, struct net_device *dev)
 {
-	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 	int old_window = inw(ioaddr + EL3_CMD);
 
 	if (old_window == 0xffff)	/* Chip suspended or ejected. */
@@ -2700,46 +2793,46 @@ static void update_stats(long ioaddr, st
 	return;
 }
 
+
 static void vortex_get_drvinfo(struct net_device *dev,
-				struct ethtool_drvinfo *info)
+					struct ethtool_drvinfo *info)
 {
-	struct vortex_private *vp = dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 
 	strcpy(info->driver, DRV_NAME);
 	strcpy(info->version, DRV_VERSION);
-	if (vp->pdev)
-		strcpy(info->bus_info, pci_name(vp->pdev));
-	else
+	if (VORTEX_PCI(vp)) {
+		strcpy(info->bus_info, pci_name(VORTEX_PCI(vp)));
+	} else {
 		sprintf(info->bus_info, "EISA 0x%lx %d",
 			dev->base_addr, dev->irq);
+	}
 }
 
 static struct ethtool_ops vortex_ethtool_ops = {
-	.get_drvinfo		= vortex_get_drvinfo,
+	.get_drvinfo =		vortex_get_drvinfo,
 };
 
-static int vortex_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+#ifdef CONFIG_PCI
+static int vortex_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
-	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&rq->ifr_data;
+	struct mii_ioctl_data *data = if_mii(rq);
 	int phy = vp->phys[0] & 0x1f;
 	int retval;
 
 	switch(cmd) {
 	case SIOCGMIIPHY:		/* Get address of MII PHY in use. */
-	case SIOCDEVPRIVATE:		/* for binary compat, remove in 2.5 */
 		data->phy_id = phy;
 
 	case SIOCGMIIREG:		/* Read MII PHY register. */
-	case SIOCDEVPRIVATE+1:		/* for binary compat, remove in 2.5 */
 		EL3WINDOW(4);
 		data->val_out = mdio_read(dev, data->phy_id & 0x1f, data->reg_num & 0x1f);
 		retval = 0;
 		break;
 
 	case SIOCSMIIREG:		/* Write MII PHY register. */
-	case SIOCDEVPRIVATE+2:		/* for binary compat, remove in 2.5 */
 		if (!capable(CAP_NET_ADMIN)) {
 			retval = -EPERM;
 		} else {
@@ -2756,6 +2849,31 @@ static int vortex_ioctl(struct net_devic
 	return retval;
 }
 
+/*
+ *	Must power the device up to do MDIO operations
+ */
+static int vortex_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+{
+	int err;
+	struct vortex_private *vp = netdev_priv(dev);
+	int state = 0;
+
+	if (vp && VORTEX_PCI(vp))
+		state = VORTEX_PCI(vp)->current_state;
+
+	/* The kernel core really should have pci_get_power_state() */
+
+	if(state != 0)
+		pci_set_power_state(VORTEX_PCI(vp), 0);
+	err = vortex_do_ioctl(dev, rq, cmd);
+	if(state != 0)
+		pci_set_power_state(VORTEX_PCI(vp), state);
+
+	return err;
+}
+#endif
+
+
 /* Pre-Cyclone chips have no documented multicast filter, so the only
    multicast setting is to receive all multicast frames.  At least
    the chip has a very clean way to set the mode, unlike many others. */
@@ -2776,6 +2894,61 @@ static void set_rx_mode(struct net_devic
 	outw(new_mode, ioaddr + EL3_CMD);
 }
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+/* Setup the card so that it can receive frames with an 802.1q VLAN tag.
+   Note that this must be done after each RxReset due to some backwards
+   compatibility logic in the Cyclone and Tornado ASICs */
+
+/* The Ethernet Type used for 802.1q tagged frames */
+#define VLAN_ETHER_TYPE 0x8100
+
+static void set_8021q_mode(struct net_device *dev, int enable)
+{
+	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	long ioaddr = dev->base_addr;
+	int old_window = inw(ioaddr + EL3_CMD);
+	int mac_ctrl;
+
+	if ((vp->drv_flags&IS_CYCLONE) || (vp->drv_flags&IS_TORNADO)) {
+		/* cyclone and tornado chipsets can recognize 802.1q
+		 * tagged frames and treat them correctly */
+
+		int max_pkt_size = dev->mtu+14;	/* MTU+Ethernet header */
+		if (enable)
+			max_pkt_size += 4;	/* 802.1Q VLAN tag */
+
+		EL3WINDOW(3);
+		outw(max_pkt_size, ioaddr+Wn3_MaxPktSize);
+
+		/* set VlanEtherType to let the hardware checksumming
+		   treat tagged frames correctly */
+		EL3WINDOW(7);
+		outw(VLAN_ETHER_TYPE, ioaddr+Wn7_VlanEtherType);
+	} else {
+		/* on older cards we have to enable large frames */
+
+		vp->large_frames = dev->mtu > 1500 || enable;
+
+		EL3WINDOW(3);
+		mac_ctrl = inw(ioaddr+Wn3_MAC_Ctrl);
+		if (vp->large_frames)
+			mac_ctrl |= 0x40;
+		else
+			mac_ctrl &= ~0x40;
+		outw(mac_ctrl, ioaddr+Wn3_MAC_Ctrl);
+	}
+
+	EL3WINDOW(old_window);
+}
+#else
+
+static void set_8021q_mode(struct net_device *dev, int enable)
+{
+}
+
+
+#endif
+
 /* MII transceiver control section.
    Read and write the MII registers using software-generated serial
    MDIO protocol.  See the MII specifications or DP83840A data sheet
@@ -2810,7 +2983,7 @@ static void mdio_sync(long ioaddr, int b
 
 static int mdio_read(struct net_device *dev, int phy_id, int location)
 {
-	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 	int i;
 	long ioaddr = dev->base_addr;
 	int read_cmd = (0xf6 << 10) | (phy_id << 5) | location;
@@ -2844,7 +3017,7 @@ static int mdio_read(struct net_device *
 
 static void mdio_write(struct net_device *dev, int phy_id, int location, int value)
 {
-	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int write_cmd = 0x50020000 | (phy_id << 23) | (location << 18) | value;
 	long mdio_addr = ioaddr + Wn4_PhysicalMgmt;
@@ -2878,7 +3051,7 @@ static void mdio_write(struct net_device
 /* Set Wake-On-LAN mode and put the board into D3 (power-down) state. */
 static void acpi_set_WOL(struct net_device *dev)
 {
-	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	struct vortex_private *vp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 
 	/* Power up on: 1==Downloaded Filter, 2==Magic Packets, 4==Link Status. */
@@ -2889,8 +3062,8 @@ static void acpi_set_WOL(struct net_devi
 	outw(RxEnable, ioaddr + EL3_CMD);
 
 	/* Change the power state to D3; RxEnable doesn't take effect. */
-	pci_enable_wake(vp->pdev, 0, 1);
-	pci_set_power_state(vp->pdev, 3);
+	pci_enable_wake(VORTEX_PCI(vp), 0, 1);
+	pci_set_power_state(VORTEX_PCI(vp), 3);
 }
 
 
@@ -2904,21 +3077,21 @@ static void __devexit vortex_remove_one 
 		BUG();
 	}
 
-	vp = dev->priv;
+	vp = netdev_priv(dev);
 
 	/* AKPM: FIXME: we should have
 	 *	if (vp->cb_fn_base) iounmap(vp->cb_fn_base);
 	 * here
 	 */
 	unregister_netdev(dev);
-	/* Should really use issue_and_wait() here */
-	outw(TotalReset|0x14, dev->base_addr + EL3_CMD);
 
-	if (vp->pdev && vp->enable_wol) {
-		pci_set_power_state(vp->pdev, 0);	/* Go active */
+	if (VORTEX_PCI(vp) && vp->enable_wol) {
+		pci_set_power_state(VORTEX_PCI(vp), 0);	/* Go active */
 		if (vp->pm_state_valid)
-			pci_restore_state(vp->pdev, vp->power_state);
+			pci_restore_state(VORTEX_PCI(vp), vp->power_state);
 	}
+	/* Should really use issue_and_wait() here */
+	outw(TotalReset|0x14, dev->base_addr + EL3_CMD);
 
 	pci_free_consistent(pdev,
 						sizeof(struct boom_rx_desc) * RX_RING_SIZE
@@ -2927,18 +3100,18 @@ static void __devexit vortex_remove_one 
 						vp->rx_ring_dma);
 	if (vp->must_free_region)
 		release_region(dev->base_addr, vp->io_size);
-	kfree(dev);
+	free_netdev(dev);
 }
 
 
 static struct pci_driver vortex_driver = {
-	name:		"3c59x",
-	probe:		vortex_init_one,
-	remove:		__devexit_p(vortex_remove_one),
-	id_table:	vortex_pci_tbl,
+	.name		= "3c59x",
+	.probe		= vortex_init_one,
+	.remove		= __devexit_p(vortex_remove_one),
+	.id_table	= vortex_pci_tbl,
 #ifdef CONFIG_PM
-	suspend:	vortex_suspend,
-	resume:		vortex_resume,
+	.suspend	= vortex_suspend,
+	.resume		= vortex_resume,
 #endif
 };
 
--- linux-2.4/include/linux/mii.h.orig
+++ linux-2.4/include/linux/mii.h
@@ -9,6 +9,7 @@
 #define __LINUX_MII_H__
 
 #include <linux/types.h>
+#include <linux/if.h>
 
 /* Generic MII registers. */
 
@@ -144,6 +145,12 @@ struct mii_ioctl_data {
 };
 
 
+static inline struct mii_ioctl_data *if_mii(struct ifreq *rq)
+{
+	return (struct mii_ioctl_data *) &rq->ifr_ifru;
+}
+
+
 /**
  * mii_nway_result
  * @negotiated: value of MII ANAR and'd with ANLPAR
