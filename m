Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWBQQOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWBQQOo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 11:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbWBQQOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 11:14:43 -0500
Received: from mr1.bfh.ch ([147.87.250.50]:13795 "EHLO mr1.bfh.ch")
	by vger.kernel.org with ESMTP id S964921AbWBQQOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 11:14:42 -0500
X-PMWin-Version: 2.5.0e, Antispam-Engine: 2.2.0.0, Antivirus-Engine: 2.32.10
Thread-Index: AcYz3UFx+dEzcRZgQVWqf4ovh3RCFg==
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Importance: normal
Message-ID: <43F5F66F.6040608@bfh.ch>
Date: Fri, 17 Feb 2006 17:14:39 +0100
From: "Seewer Philippe" <philippe.seewer@bfh.ch>
Organization: BFH
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050811)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: <tsbogend@alpha.franken.de>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH 1/2] pcnet32: Introduce basic AT 2700/01 FTX support
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2006 16:14:39.0918 (UTC) FILETIME=[4112D4E0:01C633DD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch extends Don Fry's last patch for AT 2700/01 FX to set the
speed/fdx options for the FTX variants of these cards as well.

Additionally the option override has been moved from pcnet32_open to
pcnet32_probe1 because it's only necessary to override the options once.

Tested and works.

Patch applies to 2.6.16-rc3

Signed-off-by: Philippe Seewer <philippe.seewer@bfh.ch>
---

 drivers/net/pcnet32.c   |   39 ++++++++++++++++++++++++++-------------
 include/linux/pci_ids.h |    2 ++
 2 files changed, 28 insertions(+), 13 deletions(-)


diff -uprN -X linux-2.6.16-rc3-vanilla/Documentation/dontdiff linux-2.6.16-rc3-vanilla/drivers/net/pcnet32.c linux-2.6.16-rc3/drivers/net/pcnet32.c
--- linux-2.6.16-rc3-vanilla/drivers/net/pcnet32.c      2006-02-13 01:27:25.000000000 +0100
+++ linux-2.6.16-rc3/drivers/net/pcnet32.c      2006-02-17 15:49:41.000000000 +0100
@@ -22,8 +22,8 @@
  *************************************************************************/

 #define DRV_NAME       "pcnet32"
-#define DRV_VERSION    "1.31c"
-#define DRV_RELDATE    "01.Nov.2005"
+#define DRV_VERSION    "1.31d"
+#define DRV_RELDATE    "17.Feb.2006"
 #define PFX            DRV_NAME ": "

 static const char *version =
@@ -265,6 +265,8 @@ static int homepna[MAX_UNITS];
  * v1.31c  01 Nov 2005 Don Fry Allied Telesyn 2700/2701 FX are 100Mbit only.
  *        Force 100Mbit FD if Auto (ASEL) is selected.
  *        See Bugzilla 2669 and 4551.
+ * v1.31d  17 Nov 2006 Philippe Seewer Extended AT 2700/01 FX support
+ *         to support FTX variants as well.
  */


@@ -1404,6 +1406,28 @@ pcnet32_probe1(unsigned long ioaddr, int
     if (lp->mii)
        lp->mii_if.phy_id = ((lp->a.read_bcr (ioaddr, 33)) >> 5) & 0x1f;

+    /*
+     * Override options:
+     * Allied Telesyn AT 2700/2701 FX are 100Mbit only and do not
+     * negotiate. The same goes for AT 2701 FTX on fiber and
+     * autoneg on 2700FTX seems generally broken.
+     */
+    if (lp->pci_dev->subsystem_vendor == PCI_VENDOR_ID_AT &&
+       ((lp->pci_dev->subsystem_device == PCI_SUBDEVICE_ID_AT_2700FX ||
+         lp->pci_dev->subsystem_device == PCI_SUBDEVICE_ID_AT_2701FX ||
+         lp->pci_dev->subsystem_device == PCI_SUBDEVICE_ID_AT_2700FTX)
+        ||
+        (lp->pci_dev->subsystem_device == PCI_SUBDEVICE_ID_AT_2701FTX &&
+         lp->mii_if.phy_id == 1)
+        )) {
+       if (lp->options & PCNET32_PORT_ASEL) {
+           lp->options = PCNET32_PORT_MII | PCNET32_PORT_FD | PCNET32_PORT_100;
+           if (pcnet32_debug & NETIF_MSG_PROBE)
+             printk("    Setting 100Mb-Full Duplex.\n");
+       }
+    }
+
+
     init_timer (&lp->watchdog_timer);
     lp->watchdog_timer.data = (unsigned long) dev;
     lp->watchdog_timer.function = (void *) &pcnet32_watchdog;
@@ -1614,17 +1638,6 @@ pcnet32_open(struct net_device *dev)
        val |= 0x10;
     lp->a.write_csr (ioaddr, 124, val);

-    /* Allied Telesyn AT 2700/2701 FX are 100Mbit only and do not negotiate */
-    if (lp->pci_dev->subsystem_vendor == PCI_VENDOR_ID_AT &&
-           (lp->pci_dev->subsystem_device == PCI_SUBDEVICE_ID_AT_2700FX ||
-            lp->pci_dev->subsystem_device == PCI_SUBDEVICE_ID_AT_2701FX)) {
-       if (lp->options & PCNET32_PORT_ASEL) {
-           lp->options = PCNET32_PORT_FD | PCNET32_PORT_100;
-           if (netif_msg_link(lp))
-               printk(KERN_DEBUG "%s: Setting 100Mb-Full Duplex.\n",
-                       dev->name);
-       }
-    }
     {
        /*
         * 24 Jun 2004 according AMD, in order to change the PHY,
diff -uprN -X linux-2.6.16-rc3-vanilla/Documentation/dontdiff linux-2.6.16-rc3-vanilla/include/linux/pci_ids.h linux-2.6.16-rc3/include/linux/pci_ids.h
--- linux-2.6.16-rc3-vanilla/include/linux/pci_ids.h    2006-02-13 01:27:25.000000000 +0100
+++ linux-2.6.16-rc3/include/linux/pci_ids.h    2006-02-17 15:51:37.000000000 +0100
@@ -1538,7 +1538,9 @@
 /* Allied Telesyn */
 #define PCI_VENDOR_ID_AT               0x1259
 #define PCI_SUBDEVICE_ID_AT_2700FX     0x2701
+#define PCI_SUBDEVICE_ID_AT_2700FTX    0x2702
 #define PCI_SUBDEVICE_ID_AT_2701FX     0x2703
+#define PCI_SUBDEVICE_ID_AT_2701FTX    0x2704

 #define PCI_VENDOR_ID_ESS              0x125d
 #define PCI_DEVICE_ID_ESS_ESS1968      0x1968

