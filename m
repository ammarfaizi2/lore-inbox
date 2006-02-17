Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030462AbWBQQOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030462AbWBQQOw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 11:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030628AbWBQQOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 11:14:52 -0500
Received: from mr1.bfh.ch ([147.87.250.50]:16099 "EHLO mr1.bfh.ch")
	by vger.kernel.org with ESMTP id S1030462AbWBQQOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 11:14:50 -0500
X-PMWin-Version: 2.5.0e, Antispam-Engine: 2.2.0.0, Antivirus-Engine: 2.32.10
Thread-Index: AcYz3UL2XMJaTRRQTy6NSFGgEiSCNg==
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Importance: normal
Message-ID: <43F5F672.9080904@bfh.ch>
Date: Fri, 17 Feb 2006 17:14:42 +0100
From: "Seewer Philippe" <philippe.seewer@bfh.ch>
Organization: BFH
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050811)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: <tsbogend@alpha.franken.de>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH 2/2] pcnet32: PHY selection support
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2006 16:14:42.0715 (UTC) FILETIME=[42BD9EB0:01C633DD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Most AMD pcnet chips support up to 32 external PHYs. This patch
introduces basic PHY selection/switching support, by adding two
new module parameters:
-maxphy: how many PHYs the card supports
-usephy: which phy to use instead of eeprom default

Maxphy is necessary in order to check the range of usephy and may
be overriden inside the module.

If only maxphy is present I've implemented an algorithm which checks
the link state on all PHYs and uses the one that has a link.

I tested this extensively on our 2700/01 FTX cards and works. I have
added a maxphy override for those cards to the driver as well.

The only drawback here is that I wasn't able to figure out how to
dynamically switch the PHY, so the whole switching process is done in
pcnet32_probe1 instead of open or when the link state changes. This
means that once the driver is loaded the PHY which was connected must
be used and no change is possible without physically resetting
(power off/on) the card.

Patch applies to 2.6.16-rc3 and depends on patch nr. 1 to completely
support AT 2700/01 FTX cards.

Signed-off-by: Philippe Seewer <philippe.seewer@bfh.ch>
---

 pcnet32.c |  107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 105 insertions(+), 2 deletions(-)


diff -uprN -X linux-2.6.16-rc3-vanilla/Documentation/dontdiff linux-2.6.16-rc3-vanilla/drivers/net/pcnet32.c linux-2.6.16-rc3/drivers/net/pcnet32.c
--- linux-2.6.16-rc3-vanilla/drivers/net/pcnet32.c      2006-02-17 16:38:44.000000000 +0100
+++ linux-2.6.16-rc3/drivers/net/pcnet32.c      2006-02-17 16:40:47.000000000 +0100
@@ -22,7 +22,7 @@
  *************************************************************************/

 #define DRV_NAME       "pcnet32"
-#define DRV_VERSION    "1.31d"
+#define DRV_VERSION    "1.32"
 #define DRV_RELDATE    "17.Feb.2006"
 #define PFX            DRV_NAME ": "

@@ -140,6 +140,10 @@ static int options[MAX_UNITS];
 static int full_duplex[MAX_UNITS];
 static int homepna[MAX_UNITS];

+/* Options to switch PHY */
+static int maxphy[MAX_UNITS];
+static int usephy[MAX_UNITS];
+
 /*
  *                             Theory of Operation
  *
@@ -267,6 +271,8 @@ static int homepna[MAX_UNITS];
  *        See Bugzilla 2669 and 4551.
  * v1.31d  17 Nov 2006 Philippe Seewer Extended AT 2700/01 FX support
  *         to support FTX variants as well.
+ * v1.32   17 Nov 2006 Philippe Seewer Basic PHY switching support on
+ *         module load.
  */


@@ -386,6 +392,8 @@ struct pcnet32_private {
     struct timer_list  watchdog_timer;
     struct timer_list  blink_timer;
     u32                        msg_enable;     /* debug message level */
+    int                 maxphy;         /* max PHYs supported by chip */
+    int                 usephy;         /* which PHY to use */
 };

 static void pcnet32_probe_vlbus(void);
@@ -417,6 +425,7 @@ static void pcnet32_get_regs(struct net_
 static void pcnet32_purge_tx_ring(struct net_device *dev);
 static int pcnet32_alloc_ring(struct net_device *dev, char *name);
 static void pcnet32_free_ring(struct net_device *dev);
+static void pcnet32_switch_phy(struct net_device *dev, int phy);


 enum pci_flags_bit {
@@ -1336,6 +1345,20 @@ pcnet32_probe1(unsigned long ioaddr, int
     lp->mii_if.mdio_read = mdio_read;
     lp->mii_if.mdio_write = mdio_write;

+    lp->maxphy = 1;
+    if ((cards_found >= MAX_UNITS) || (maxphy[cards_found]))
+        lp->maxphy = maxphy[cards_found];
+
+    lp->usephy = 0;
+    if ((cards_found >= MAX_UNITS) || (usephy[cards_found]))
+        lp->usephy = usephy[cards_found];
+
+    if (lp->usephy > lp->maxphy) {
+        printk(KERN_ERR PFX "   usephy paramater out of range! ignoring!\n");
+       lp->usephy = 0;
+    }
+
+
     if (fdx && !(lp->options & PCNET32_PORT_ASEL) &&
                ((cards_found>=MAX_UNITS) || full_duplex[cards_found]))
        lp->options |= PCNET32_PORT_FD;
@@ -1358,6 +1381,15 @@ pcnet32_probe1(unsigned long ioaddr, int
            && dev->dev_addr[2] == 0x75)
        lp->options = PCNET32_PORT_FD | PCNET32_PORT_GPSI;

+    /*
+     * Test for specific cards to set maxphy count
+     */
+    if (lp->pci_dev->subsystem_vendor == PCI_VENDOR_ID_AT &&
+       (lp->pci_dev->subsystem_device == PCI_SUBDEVICE_ID_AT_2700FTX ||
+        lp->pci_dev->subsystem_device == PCI_SUBDEVICE_ID_AT_2701FTX)) {
+      lp->maxphy = 2;
+    }
+
     lp->init_block.mode = le16_to_cpu(0x0003); /* Disable Rx and Tx. */
     lp->init_block.tlen_rlen = le16_to_cpu(lp->tx_len_bits | lp->rx_len_bits);
     for (i = 0; i < 6; i++)
@@ -1403,9 +1435,38 @@ pcnet32_probe1(unsigned long ioaddr, int
     }

     /* Set the mii phy_id so that we can query the link state */
-    if (lp->mii)
+    if (lp->mii) {
        lp->mii_if.phy_id = ((lp->a.read_bcr (ioaddr, 33)) >> 5) & 0x1f;

+       /* Multi PHY? */
+       if (lp->maxphy > 1) {
+           /* Autoswitch? */
+           if (lp->usephy == 0) {
+               /* backup */
+               lp->usephy = lp->mii_if.phy_id;
+
+               /* give preference to eeprom default if no link */
+               media = lp->mii_if.phy_id;
+
+               /* check link */
+               for (i = 1; i <= lp->maxphy; i++) {
+                 lp->mii_if.phy_id = i;
+                 if (mii_check_media(&lp->mii_if, 0, 1)) {
+                   media = i;
+                   /* give preference to eeprom default if link found */
+                   if (i == lp->usephy)
+                     break;
+                 }
+               }
+
+               lp->mii_if.phy_id = media;
+           } else {
+               lp->mii_if.phy_id = lp->usephy;
+           }
+           pcnet32_switch_phy(dev, lp->mii_if.phy_id);
+       }
+    }
+
     /*
      * Override options:
      * Allied Telesyn AT 2700/2701 FX are 100Mbit only and do not
@@ -1573,6 +1634,32 @@ static void pcnet32_free_ring(struct net
     }
 }

+static void pcnet32_switch_phy(struct net_device *dev, int phy)
+{
+    struct pcnet32_private *lp = dev->priv;
+    unsigned long ioaddr = dev->base_addr;
+    int i;
+
+    /* Isolate all unused phy's */
+    for (i = 1; i < 3; i++) {
+      if (i != phy)
+        mdio_write(dev, 1, MII_BMCR, BMCR_ISOLATE);
+    }
+
+    /* Make sure used phy is not isolated */
+    mdio_write(dev, phy, MII_BMCR,
+              mdio_read(dev, phy, MII_BMCR) & ~BMCR_ISOLATE);
+
+    /* Rearead mii regs */
+    for (i = 0; i < 5; i++) {
+      mdio_read(dev, phy, i);
+      mdio_read(dev, phy, i);
+    }
+
+    /* Store PHY */
+    lp->a.write_bcr(ioaddr, 33, ((phy & 0x1f) << 5) | MII_BMCR);
+}
+

 static int
 pcnet32_open(struct net_device *dev)
@@ -1654,6 +1741,16 @@ pcnet32_open(struct net_device *dev)
            if (lp->options & PCNET32_PORT_100)
                val |= 0x08;
            lp->a.write_bcr (ioaddr, 32, val);
+           /*
+            * AT 2700 FTX seems broken somehow, when disabling the
+            * DANAS the mii registers for the fiber poort need to be
+            * set.
+            */
+           if (lp->pci_dev->subsystem_vendor == PCI_VENDOR_ID_AT &&
+               lp->pci_dev->subsystem_device == PCI_SUBDEVICE_ID_AT_2700FTX &&
+               lp->mii_if.phy_id == 1) {
+             mdio_write(dev, lp->mii_if.phy_id, MII_BMCR, 0x2100);
+           }
        } else {
            if (lp->options & PCNET32_PORT_ASEL) {
                lp->a.write_bcr(ioaddr, 32,
@@ -2505,6 +2602,12 @@ MODULE_PARM_DESC(full_duplex, DRV_NAME "
 module_param_array(homepna, int, NULL, 0);
 MODULE_PARM_DESC(homepna, DRV_NAME " mode for 79C978 cards (1 for HomePNA, 0 for Ethernet, default Ethernet");

+/* Module parameters for PHY selection support */
+module_param_array(maxphy, int, NULL, 0);
+MODULE_PARM_DESC(maxphy, DRV_NAME " max PHYs the card supports");
+module_param_array(usephy, int, NULL, 0);
+MODULE_PARM_DESC(usephy, DRV_NAME " use specified PHY port instead of default");
+
 MODULE_AUTHOR("Thomas Bogendoerfer");
 MODULE_DESCRIPTION("Driver for PCnet32 and PCnetPCI based ethercards");
 MODULE_LICENSE("GPL");

