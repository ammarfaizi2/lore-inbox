Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129957AbQKZHC1>; Sun, 26 Nov 2000 02:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129786AbQKZHCR>; Sun, 26 Nov 2000 02:02:17 -0500
Received: from [209.249.10.20] ([209.249.10.20]:56540 "EHLO
        freya.yggdrasil.com") by vger.kernel.org with ESMTP
        id <S129977AbQKZHCJ>; Sun, 26 Nov 2000 02:02:09 -0500
Date: Sat, 25 Nov 2000 22:31:50 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: alan@lxorguk.ukuu.org, mid@auk.cx
Cc: linux-kernel@vger.kernel.org
Subject: Patch: linux-2.4.0-test11ac4/drivers/net/tokenring/{tmspci,abyss}.c __devinit fixes
Message-ID: <20001125223150.A5407@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Hooray!  I see that Alan has included a port of the
drivers/net/tokenring/{tmspci,abyss}.c to the new PCI interface,
presumably by Adam Fritzler.

	This patch correct some minor errors where __devinit{,data}
should be used instead of __init{,data} so the driver does not
make illegal memory references in a hot plugging event.  Even if
there is currently no hot pluggable version of these cards, I believe
the scenario would occur if you were to plug a notebook into
a PCI docking station that supports hot docking and had one of these
cards plugged in.  So, the scenario can happen.  I also added
__devinit to the eeprom reading routines, which are only called
by another __devinit routine.

	I hope this patch will be applied both to the development
version of the driver and, ideally, to Alan's tree, and really ideally,
propagated to Linus with the rest of Adam Fritzler's port.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="diffs.separate"

diff -u -r linux-2.4.0-test11-ac4/drivers/net/tokenring/tmspci.c linux-2.4.0-test11-ac4.hacked/drivers/net/tokenring/tmspci.c
--- linux-2.4.0-test11-ac4/drivers/net/tokenring/tmspci.c	Sat Nov 25 21:15:17 2000
+++ linux-2.4.0-test11-ac4.hacked/drivers/net/tokenring/tmspci.c	Sat Nov 25 21:51:49 2000
@@ -41,7 +41,7 @@
 #include <linux/trdevice.h>
 #include "tms380tr.h"
 
-static char version[] __initdata =
+static char version[] __devinitdata =
 "tmspci.c: v1.02 23/11/2000 by Adam Fritzler\n";
 
 #define TMS_PCI_IO_EXTENT 32
@@ -58,7 +58,7 @@
 	{ {0x03, 0x01}, "3Com Token Link Velocity"},
 };
 
-static struct pci_device_id tmspci_pci_tbl[] __initdata = {
+static struct pci_device_id tmspci_pci_tbl[] __devinitdata = {
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_TOKENRING, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_SYSKONNECT, PCI_DEVICE_ID_SYSKONNECT_TR, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },
 	{ PCI_VENDOR_ID_TCONRAD, PCI_DEVICE_ID_TCONRAD_TOKENRING, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2 },
@@ -67,7 +67,7 @@
 };
 MODULE_DEVICE_TABLE(pci, tmspci_pci_tbl);
 
-static void tms_pci_read_eeprom(struct net_device *dev);
+static void __devinit tms_pci_read_eeprom(struct net_device *dev);
 static unsigned short tms_pci_setnselout_pins(struct net_device *dev);
 
 static unsigned short tms_pci_sifreadb(struct net_device *dev, unsigned short reg)
@@ -90,7 +90,7 @@
 	outw(val, dev->base_addr + reg);
 }
 
-static int __init tms_pci_attach(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int __devinit tms_pci_attach(struct pci_dev *pdev, const struct pci_device_id *ent)
 {	
 	static int versionprinted;
 	struct net_device *dev;
@@ -192,7 +192,7 @@
  * machine hard when this is called.  Luckily, its supported in a
  * seperate driver.  --ASF
  */
-static void tms_pci_read_eeprom(struct net_device *dev)
+static void __devinit tms_pci_read_eeprom(struct net_device *dev)
 {
 	int i;
 	
@@ -219,7 +219,7 @@
 	return val;
 }
 
-static void __exit tms_pci_detach (struct pci_dev *pdev)
+static void __devexit tms_pci_detach (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
diff -u -r linux-2.4.0-test11-ac4/drivers/net/tokenring/abyss.c linux-2.4.0-test11-ac4.hacked/drivers/net/tokenring/abyss.c
--- linux-2.4.0-test11-ac4/drivers/net/tokenring/abyss.c	Sat Nov 25 21:15:17 2000
+++ linux-2.4.0-test11-ac4.hacked/drivers/net/tokenring/abyss.c	Sat Nov 25 21:52:49 2000
@@ -41,12 +41,12 @@
 #include "tms380tr.h"
 #include "abyss.h"            /* Madge-specific constants */
 
-static char version[] __initdata =
+static char version[] __devinitdata =
 "abyss.c: v1.02 23/11/2000 by Adam Fritzler\n";
 
 #define ABYSS_IO_EXTENT 64
 
-static struct pci_device_id abyss_pci_tbl[] __initdata = {
+static struct pci_device_id abyss_pci_tbl[] __devinitdata = {
 	{ PCI_VENDOR_ID_MADGE, PCI_DEVICE_ID_MADGE_MK2,
 	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_NETWORK_TOKEN_RING << 8, 0x00ffffff, },
 	{ }			/* Terminating entry */
@@ -91,7 +91,7 @@
 	outw(val, dev->base_addr + reg);
 }
 
-static int __init abyss_attach(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int __devinit abyss_attach(struct pci_dev *pdev, const struct pci_device_id *ent)
 {	
 	static int versionprinted;
 	struct net_device *dev;
@@ -390,7 +390,7 @@
  * Read configuration data from the AT24 SEEPROM on Madge cards.
  *
  */
-static void abyss_read_eeprom(struct net_device *dev)
+static void __devinit abyss_read_eeprom(struct net_device *dev)
 {
 	struct net_local *tp;
 	unsigned long ioaddr;
@@ -432,7 +432,7 @@
 	return 0;
 }
 
-static void __exit abyss_detach (struct pci_dev *pdev)
+static void __devexit abyss_detach (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	

--LQksG6bCIzRHxTLp--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
