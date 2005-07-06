Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbVGFUTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVGFUTo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVGFUM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:12:59 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:11363 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262125AbVGFTom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 15:44:42 -0400
Date: Wed, 6 Jul 2005 15:44:41 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       benh@kernel.crashing.org
Subject: [PATCH 1/3] openfirmware: generate device table for userspace
Message-ID: <20050706194441.GA18921@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.151-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This patch converts the usage of struct of_match to struct of_device_id,
 similar to pci_device_id. This allows a device table to be generated, which 
 can be parsed by depmod(8) to generate a map file for module loading.
 
 In order for hotplug to work with macio devices, patches to module-init-tools
 and hotplug must be applied. Those patches are available at:
 
 ftp://ftp.suse.com/pub/people/jeffm/linux/macio-hotplug/

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.13-rc2.orig/arch/ppc/syslib/of_device.c linux-2.6.13-rc2/arch/ppc/syslib/of_device.c
--- linux-2.6.13-rc2.orig/arch/ppc/syslib/of_device.c	2005-07-06 11:38:56.000000000 -0400
+++ linux-2.6.13-rc2/arch/ppc/syslib/of_device.c	2005-07-06 11:40:25.000000000 -0400
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <asm/errno.h>
 #include <asm/of_device.h>
 
@@ -15,20 +16,20 @@
  * Used by a driver to check whether an of_device present in the
  * system is in its list of supported devices.
  */
-const struct of_match * of_match_device(const struct of_match *matches,
+const struct of_device_id * of_match_device(const struct of_device_id *matches,
 					const struct of_device *dev)
 {
 	if (!dev->node)
 		return NULL;
-	while (matches->name || matches->type || matches->compatible) {
+	while (matches->name[0] || matches->type[0] || matches->compatible[0]) {
 		int match = 1;
-		if (matches->name && matches->name != OF_ANY_MATCH)
+		if (matches->name[0])
 			match &= dev->node->name
 				&& !strcmp(matches->name, dev->node->name);
-		if (matches->type && matches->type != OF_ANY_MATCH)
+		if (matches->type[0])
 			match &= dev->node->type
 				&& !strcmp(matches->type, dev->node->type);
-		if (matches->compatible && matches->compatible != OF_ANY_MATCH)
+		if (matches->compatible[0])
 			match &= device_is_compatible(dev->node,
 				matches->compatible);
 		if (match)
@@ -42,7 +43,7 @@ static int of_platform_bus_match(struct 
 {
 	struct of_device * of_dev = to_of_device(dev);
 	struct of_platform_driver * of_drv = to_of_platform_driver(drv);
-	const struct of_match * matches = of_drv->match_table;
+	const struct of_device_id * matches = of_drv->match_table;
 
 	if (!matches)
 		return 0;
@@ -75,7 +76,7 @@ static int of_device_probe(struct device
 	int error = -ENODEV;
 	struct of_platform_driver *drv;
 	struct of_device *of_dev;
-	const struct of_match *match;
+	const struct of_device_id *match;
 
 	drv = to_of_platform_driver(dev->driver);
 	of_dev = to_of_device(dev);
diff -ruNpX dontdiff linux-2.6.13-rc2.orig/arch/ppc64/kernel/of_device.c linux-2.6.13-rc2/arch/ppc64/kernel/of_device.c
--- linux-2.6.13-rc2.orig/arch/ppc64/kernel/of_device.c	2005-07-06 11:38:56.000000000 -0400
+++ linux-2.6.13-rc2/arch/ppc64/kernel/of_device.c	2005-07-06 11:40:25.000000000 -0400
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <asm/errno.h>
 #include <asm/of_device.h>
 
@@ -15,20 +16,20 @@
  * Used by a driver to check whether an of_device present in the
  * system is in its list of supported devices.
  */
-const struct of_match * of_match_device(const struct of_match *matches,
+const struct of_device_id *of_match_device(const struct of_device_id *matches,
 					const struct of_device *dev)
 {
 	if (!dev->node)
 		return NULL;
-	while (matches->name || matches->type || matches->compatible) {
+	while (matches->name[0] || matches->type[0] || matches->compatible[0]) {
 		int match = 1;
-		if (matches->name && matches->name != OF_ANY_MATCH)
+		if (matches->name[0])
 			match &= dev->node->name
 				&& !strcmp(matches->name, dev->node->name);
-		if (matches->type && matches->type != OF_ANY_MATCH)
+		if (matches->type[0])
 			match &= dev->node->type
 				&& !strcmp(matches->type, dev->node->type);
-		if (matches->compatible && matches->compatible != OF_ANY_MATCH)
+		if (matches->compatible[0])
 			match &= device_is_compatible(dev->node,
 				matches->compatible);
 		if (match)
@@ -42,7 +43,7 @@ static int of_platform_bus_match(struct 
 {
 	struct of_device * of_dev = to_of_device(dev);
 	struct of_platform_driver * of_drv = to_of_platform_driver(drv);
-	const struct of_match * matches = of_drv->match_table;
+	const struct of_device_id * matches = of_drv->match_table;
 
 	if (!matches)
 		return 0;
@@ -75,7 +76,7 @@ static int of_device_probe(struct device
 	int error = -ENODEV;
 	struct of_platform_driver *drv;
 	struct of_device *of_dev;
-	const struct of_match *match;
+	const struct of_device_id *match;
 
 	drv = to_of_platform_driver(dev->driver);
 	of_dev = to_of_device(dev);
diff -ruNpX dontdiff linux-2.6.13-rc2.orig/drivers/i2c/busses/i2c-keywest.c linux-2.6.13-rc2/drivers/i2c/busses/i2c-keywest.c
--- linux-2.6.13-rc2.orig/drivers/i2c/busses/i2c-keywest.c	2005-07-06 11:39:00.000000000 -0400
+++ linux-2.6.13-rc2/drivers/i2c/busses/i2c-keywest.c	2005-07-06 11:40:25.000000000 -0400
@@ -698,7 +698,7 @@ dispose_iface(struct device *dev)
 }
 
 static int
-create_iface_macio(struct macio_dev* dev, const struct of_match *match)
+create_iface_macio(struct macio_dev* dev, const struct of_device_id *match)
 {
 	return create_iface(dev->ofdev.node, &dev->ofdev.dev);
 }
@@ -710,7 +710,7 @@ dispose_iface_macio(struct macio_dev* de
 }
 
 static int
-create_iface_of_platform(struct of_device* dev, const struct of_match *match)
+create_iface_of_platform(struct of_device* dev, const struct of_device_id *match)
 {
 	return create_iface(dev->node, &dev->dev);
 }
@@ -721,10 +721,9 @@ dispose_iface_of_platform(struct of_devi
 	return dispose_iface(&dev->dev);
 }
 
-static struct of_match i2c_keywest_match[] = 
+static struct of_device_id i2c_keywest_match[] = 
 {
 	{
-	.name 		= OF_ANY_MATCH,
 	.type		= "i2c",
 	.compatible	= "keywest"
 	},
diff -ruNpX dontdiff linux-2.6.13-rc2.orig/drivers/ide/ppc/pmac.c linux-2.6.13-rc2/drivers/ide/ppc/pmac.c
--- linux-2.6.13-rc2.orig/drivers/ide/ppc/pmac.c	2005-07-06 11:39:01.000000000 -0400
+++ linux-2.6.13-rc2/drivers/ide/ppc/pmac.c	2005-07-06 11:40:25.000000000 -0400
@@ -1419,7 +1419,7 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
  * Attach to a macio probed interface
  */
 static int __devinit
-pmac_ide_macio_attach(struct macio_dev *mdev, const struct of_match *match)
+pmac_ide_macio_attach(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	void __iomem *base;
 	unsigned long regbase;
@@ -1637,27 +1637,19 @@ pmac_ide_pci_resume(struct pci_dev *pdev
 	return rc;
 }
 
-static struct of_match pmac_ide_macio_match[] = 
+static struct of_device_id pmac_ide_macio_match[] = 
 {
 	{
 	.name 		= "IDE",
-	.type		= OF_ANY_MATCH,
-	.compatible	= OF_ANY_MATCH
 	},
 	{
 	.name 		= "ATA",
-	.type		= OF_ANY_MATCH,
-	.compatible	= OF_ANY_MATCH
 	},
 	{
-	.name 		= OF_ANY_MATCH,
 	.type		= "ide",
-	.compatible	= OF_ANY_MATCH
 	},
 	{
-	.name 		= OF_ANY_MATCH,
 	.type		= "ata",
-	.compatible	= OF_ANY_MATCH
 	},
 	{},
 };
diff -ruNpX dontdiff linux-2.6.13-rc2.orig/drivers/macintosh/macio_asic.c linux-2.6.13-rc2/drivers/macintosh/macio_asic.c
--- linux-2.6.13-rc2.orig/drivers/macintosh/macio_asic.c	2005-07-06 11:37:58.000000000 -0400
+++ linux-2.6.13-rc2/drivers/macintosh/macio_asic.c	2005-07-06 11:40:25.000000000 -0400
@@ -33,7 +33,7 @@ static int macio_bus_match(struct device
 {
 	struct macio_dev * macio_dev = to_macio_device(dev);
 	struct macio_driver * macio_drv = to_macio_driver(drv);
-	const struct of_match * matches = macio_drv->match_table;
+	const struct of_device_id * matches = macio_drv->match_table;
 
 	if (!matches) 
 		return 0;
@@ -66,7 +66,7 @@ static int macio_device_probe(struct dev
 	int error = -ENODEV;
 	struct macio_driver *drv;
 	struct macio_dev *macio_dev;
-	const struct of_match *match;
+	const struct of_device_id *match;
 
 	drv = to_macio_driver(dev->driver);
 	macio_dev = to_macio_device(dev);
diff -ruNpX dontdiff linux-2.6.13-rc2.orig/drivers/macintosh/mediabay.c linux-2.6.13-rc2/drivers/macintosh/mediabay.c
--- linux-2.6.13-rc2.orig/drivers/macintosh/mediabay.c	2005-07-06 11:37:58.000000000 -0400
+++ linux-2.6.13-rc2/drivers/macintosh/mediabay.c	2005-07-06 11:40:25.000000000 -0400
@@ -642,7 +642,7 @@ static int __pmac media_bay_task(void *x
 	}
 }
 
-static int __devinit media_bay_attach(struct macio_dev *mdev, const struct of_match *match)
+static int __devinit media_bay_attach(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	struct media_bay_info* bay;
 	u32 __iomem *regbase;
@@ -797,23 +797,20 @@ static struct mb_ops keylargo_mb_ops __p
  * Therefore we do it all by polling the media bay once each tick.
  */
 
-static struct of_match media_bay_match[] =
+static struct of_device_id media_bay_match[] =
 {
 	{
 	.name		= "media-bay",
-	.type		= OF_ANY_MATCH,
 	.compatible	= "keylargo-media-bay",
 	.data		= &keylargo_mb_ops,
 	},
 	{
 	.name		= "media-bay",
-	.type		= OF_ANY_MATCH,
 	.compatible	= "heathrow-media-bay",
 	.data		= &heathrow_mb_ops,
 	},
 	{
 	.name		= "media-bay",
-	.type		= OF_ANY_MATCH,
 	.compatible	= "ohare-media-bay",
 	.data		= &ohare_mb_ops,
 	},
diff -ruNpX dontdiff linux-2.6.13-rc2.orig/drivers/macintosh/therm_pm72.c linux-2.6.13-rc2/drivers/macintosh/therm_pm72.c
--- linux-2.6.13-rc2.orig/drivers/macintosh/therm_pm72.c	2005-07-06 11:39:04.000000000 -0400
+++ linux-2.6.13-rc2/drivers/macintosh/therm_pm72.c	2005-07-06 11:40:25.000000000 -0400
@@ -120,6 +120,7 @@
 #include <asm/system.h>
 #include <asm/sections.h>
 #include <asm/of_device.h>
+#include <asm/macio.h>
 
 #include "therm_pm72.h"
 
@@ -1986,7 +1987,7 @@ static void fcu_lookup_fans(struct devic
 	}
 }
 
-static int fcu_of_probe(struct of_device* dev, const struct of_match *match)
+static int fcu_of_probe(struct of_device* dev, const struct of_device_id *match)
 {
 	int rc;
 
@@ -2009,12 +2010,10 @@ static int fcu_of_remove(struct of_devic
 	return 0;
 }
 
-static struct of_match fcu_of_match[] = 
+static struct of_device_id fcu_match[] = 
 {
 	{
-	.name 		= OF_ANY_MATCH,
 	.type		= "fcu",
-	.compatible	= OF_ANY_MATCH
 	},
 	{},
 };
@@ -2022,7 +2021,7 @@ static struct of_match fcu_of_match[] = 
 static struct of_platform_driver fcu_of_platform_driver = 
 {
 	.name 		= "temperature",
-	.match_table	= fcu_of_match,
+	.match_table	= fcu_match,
 	.probe		= fcu_of_probe,
 	.remove		= fcu_of_remove
 };
diff -ruNpX dontdiff linux-2.6.13-rc2.orig/drivers/macintosh/therm_windtunnel.c linux-2.6.13-rc2/drivers/macintosh/therm_windtunnel.c
--- linux-2.6.13-rc2.orig/drivers/macintosh/therm_windtunnel.c	2005-07-06 11:39:04.000000000 -0400
+++ linux-2.6.13-rc2/drivers/macintosh/therm_windtunnel.c	2005-07-06 11:40:25.000000000 -0400
@@ -43,6 +43,7 @@
 #include <asm/system.h>
 #include <asm/sections.h>
 #include <asm/of_device.h>
+#include <asm/macio.h>
 
 #define LOG_TEMP		0			/* continously log temperature */
 
@@ -450,7 +451,7 @@ do_probe( struct i2c_adapter *adapter, i
 /************************************************************************/
 
 static int
-therm_of_probe( struct of_device *dev, const struct of_match *match )
+therm_of_probe( struct of_device *dev, const struct of_device_id *match )
 {
 	return i2c_add_driver( &g4fan_driver );
 }
@@ -461,9 +462,8 @@ therm_of_remove( struct of_device *dev )
 	return i2c_del_driver( &g4fan_driver );
 }
 
-static struct of_match therm_of_match[] = {{
+static struct of_device_id therm_of_match[] = {{
 	.name		= "fan",
-	.type		= OF_ANY_MATCH,
 	.compatible	= "adm1030"
     }, {}
 };
diff -ruNpX dontdiff linux-2.6.13-rc2.orig/drivers/net/bmac.c linux-2.6.13-rc2/drivers/net/bmac.c
--- linux-2.6.13-rc2.orig/drivers/net/bmac.c	2005-07-06 11:39:05.000000000 -0400
+++ linux-2.6.13-rc2/drivers/net/bmac.c	2005-07-06 11:40:25.000000000 -0400
@@ -1261,7 +1261,7 @@ static void bmac_reset_and_enable(struct
 	spin_unlock_irqrestore(&bp->lock, flags);
 }
 
-static int __devinit bmac_probe(struct macio_dev *mdev, const struct of_match *match)
+static int __devinit bmac_probe(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	int j, rev, ret;
 	struct bmac_data *bp;
@@ -1645,16 +1645,13 @@ static int __devexit bmac_remove(struct 
 	return 0;
 }
 
-static struct of_match bmac_match[] = 
+static struct of_device_id bmac_match[] = 
 {
 	{
 	.name 		= "bmac",
-	.type		= OF_ANY_MATCH,
-	.compatible	= OF_ANY_MATCH,
 	.data		= (void *)0,
 	},
 	{
-	.name 		= OF_ANY_MATCH,
 	.type		= "network",
 	.compatible	= "bmac+",
 	.data		= (void *)1,
diff -ruNpX dontdiff linux-2.6.13-rc2.orig/drivers/net/mace.c linux-2.6.13-rc2/drivers/net/mace.c
--- linux-2.6.13-rc2.orig/drivers/net/mace.c	2005-03-02 02:37:52.000000000 -0500
+++ linux-2.6.13-rc2/drivers/net/mace.c	2005-07-06 11:40:25.000000000 -0400
@@ -109,7 +109,7 @@ bitrev(int b)
 }
 
 
-static int __devinit mace_probe(struct macio_dev *mdev, const struct of_match *match)
+static int __devinit mace_probe(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	struct device_node *mace = macio_get_of_node(mdev);
 	struct net_device *dev;
@@ -1009,12 +1009,10 @@ static irqreturn_t mace_rxdma_intr(int i
     return IRQ_HANDLED;
 }
 
-static struct of_match mace_match[] = 
+static struct of_device_id mace_match[] = 
 {
 	{
 	.name 		= "mace",
-	.type		= OF_ANY_MATCH,
-	.compatible	= OF_ANY_MATCH
 	},
 	{},
 };
diff -ruNpX dontdiff linux-2.6.13-rc2.orig/drivers/net/wireless/airport.c linux-2.6.13-rc2/drivers/net/wireless/airport.c
--- linux-2.6.13-rc2.orig/drivers/net/wireless/airport.c	2005-07-06 11:38:07.000000000 -0400
+++ linux-2.6.13-rc2/drivers/net/wireless/airport.c	2005-07-06 11:40:25.000000000 -0400
@@ -184,7 +184,7 @@ static int airport_hard_reset(struct ori
 }
 
 static int
-airport_attach(struct macio_dev *mdev, const struct of_match *match)
+airport_attach(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	struct orinoco_private *priv;
 	struct net_device *dev;
@@ -266,16 +266,16 @@ MODULE_AUTHOR("Benjamin Herrenschmidt <b
 MODULE_DESCRIPTION("Driver for the Apple Airport wireless card.");
 MODULE_LICENSE("Dual MPL/GPL");
 
-static struct of_match airport_match[] = 
+static struct of_device_id airport_match[] = 
 {
 	{
 	.name 		= "radio",
-	.type		= OF_ANY_MATCH,
-	.compatible	= OF_ANY_MATCH
 	},
 	{},
 };
 
+MODULE_DEVICE_TABLE (of, airport_match);
+
 static struct macio_driver airport_driver = 
 {
 	.name 		= DRIVER_NAME,
diff -ruNpX dontdiff linux-2.6.13-rc2.orig/drivers/scsi/mac53c94.c linux-2.6.13-rc2/drivers/scsi/mac53c94.c
--- linux-2.6.13-rc2.orig/drivers/scsi/mac53c94.c	2005-07-06 11:39:13.000000000 -0400
+++ linux-2.6.13-rc2/drivers/scsi/mac53c94.c	2005-07-06 11:40:25.000000000 -0400
@@ -424,7 +424,7 @@ static struct scsi_host_template mac53c9
 	.use_clustering	= DISABLE_CLUSTERING,
 };
 
-static int mac53c94_probe(struct macio_dev *mdev, const struct of_match *match)
+static int mac53c94_probe(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	struct device_node *node = macio_get_of_node(mdev);
 	struct pci_dev *pdev = macio_get_pci_dev(mdev);
@@ -544,15 +544,14 @@ static int mac53c94_remove(struct macio_
 }
 
 
-static struct of_match mac53c94_match[] = 
+static struct of_device_id mac53c94_match[] = 
 {
 	{
 	.name 		= "53c94",
-	.type		= OF_ANY_MATCH,
-	.compatible	= OF_ANY_MATCH
 	},
 	{},
 };
+MODULE_DEVICE_TABLE (of, mac53c94_match);
 
 static struct macio_driver mac53c94_driver = 
 {
diff -ruNpX dontdiff linux-2.6.13-rc2.orig/drivers/scsi/mesh.c linux-2.6.13-rc2/drivers/scsi/mesh.c
--- linux-2.6.13-rc2.orig/drivers/scsi/mesh.c	2005-07-06 11:39:13.000000000 -0400
+++ linux-2.6.13-rc2/drivers/scsi/mesh.c	2005-07-06 11:40:25.000000000 -0400
@@ -1847,7 +1847,7 @@ static struct scsi_host_template mesh_te
 	.use_clustering			= DISABLE_CLUSTERING,
 };
 
-static int mesh_probe(struct macio_dev *mdev, const struct of_match *match)
+static int mesh_probe(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	struct device_node *mesh = macio_get_of_node(mdev);
 	struct pci_dev* pdev = macio_get_pci_dev(mdev);
@@ -2012,20 +2012,18 @@ static int mesh_remove(struct macio_dev 
 }
 
 
-static struct of_match mesh_match[] = 
+static struct of_device_id mesh_match[] = 
 {
 	{
 	.name 		= "mesh",
-	.type		= OF_ANY_MATCH,
-	.compatible	= OF_ANY_MATCH
 	},
 	{
-	.name 		= OF_ANY_MATCH,
 	.type		= "scsi",
 	.compatible	= "chrp,mesh0"
 	},
 	{},
 };
+MODULE_DEVICE_TABLE (of, mesh_match);
 
 static struct macio_driver mesh_driver = 
 {
diff -ruNpX dontdiff linux-2.6.13-rc2.orig/drivers/serial/pmac_zilog.c linux-2.6.13-rc2/drivers/serial/pmac_zilog.c
--- linux-2.6.13-rc2.orig/drivers/serial/pmac_zilog.c	2005-07-06 11:39:14.000000000 -0400
+++ linux-2.6.13-rc2/drivers/serial/pmac_zilog.c	2005-07-06 11:40:25.000000000 -0400
@@ -1545,7 +1545,7 @@ static void pmz_dispose_port(struct uart
 /*
  * Called upon match with an escc node in the devive-tree.
  */
-static int pmz_attach(struct macio_dev *mdev, const struct of_match *match)
+static int pmz_attach(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	int i;
 	
@@ -1850,20 +1850,17 @@ err_out:
 	return rc;
 }
 
-static struct of_match pmz_match[] = 
+static struct of_device_id pmz_match[] = 
 {
 	{
 	.name 		= "ch-a",
-	.type		= OF_ANY_MATCH,
-	.compatible	= OF_ANY_MATCH
 	},
 	{
 	.name 		= "ch-b",
-	.type		= OF_ANY_MATCH,
-	.compatible	= OF_ANY_MATCH
 	},
 	{},
 };
+MODULE_DEVICE_TABLE (of, pmz_match);
 
 static struct macio_driver pmz_driver = 
 {
diff -ruNpX dontdiff linux-2.6.13-rc2.orig/drivers/video/platinumfb.c linux-2.6.13-rc2/drivers/video/platinumfb.c
--- linux-2.6.13-rc2.orig/drivers/video/platinumfb.c	2005-03-02 02:38:07.000000000 -0500
+++ linux-2.6.13-rc2/drivers/video/platinumfb.c	2005-07-06 11:40:25.000000000 -0400
@@ -523,7 +523,7 @@ int __init platinumfb_setup(char *option
 #define invalidate_cache(addr)
 #endif
 
-static int __devinit platinumfb_probe(struct of_device* odev, const struct of_match *match)
+static int __devinit platinumfb_probe(struct of_device* odev, const struct of_device_id *match)
 {
 	struct device_node	*dp = odev->node;
 	struct fb_info		*info;
@@ -647,12 +647,10 @@ static int __devexit platinumfb_remove(s
 	return 0;
 }
 
-static struct of_match platinumfb_match[] = 
+static struct of_device_id platinumfb_match[] = 
 {
 	{
 	.name 		= "platinum",
-	.type		= OF_ANY_MATCH,
-	.compatible	= OF_ANY_MATCH,
 	},
 	{},
 };
diff -ruNpX dontdiff linux-2.6.13-rc2.orig/include/asm-ppc/macio.h linux-2.6.13-rc2/include/asm-ppc/macio.h
--- linux-2.6.13-rc2.orig/include/asm-ppc/macio.h	2005-07-06 11:38:32.000000000 -0400
+++ linux-2.6.13-rc2/include/asm-ppc/macio.h	2005-07-06 11:40:25.000000000 -0400
@@ -1,6 +1,7 @@
 #ifndef __MACIO_ASIC_H__
 #define __MACIO_ASIC_H__
 
+#include <linux/mod_devicetable.h>
 #include <asm/of_device.h>
 
 extern struct bus_type macio_bus_type;
@@ -120,10 +121,10 @@ static inline struct pci_dev *macio_get_
 struct macio_driver
 {
 	char			*name;
-	struct of_match		*match_table;
+	struct of_device_id	*match_table;
 	struct module		*owner;
 
-	int	(*probe)(struct macio_dev* dev, const struct of_match *match);
+	int	(*probe)(struct macio_dev* dev, const struct of_device_id *match);
 	int	(*remove)(struct macio_dev* dev);
 
 	int	(*suspend)(struct macio_dev* dev, pm_message_t state);
diff -ruNpX dontdiff linux-2.6.13-rc2.orig/include/asm-ppc/of_device.h linux-2.6.13-rc2/include/asm-ppc/of_device.h
--- linux-2.6.13-rc2.orig/include/asm-ppc/of_device.h	2005-07-06 11:38:32.000000000 -0400
+++ linux-2.6.13-rc2/include/asm-ppc/of_device.h	2005-07-06 11:40:25.000000000 -0400
@@ -24,20 +24,8 @@ struct of_device
 };
 #define	to_of_device(d) container_of(d, struct of_device, dev)
 
-/*
- * Struct used for matching a device
- */
-struct of_match
-{
-	char	*name;
-	char	*type;
-	char	*compatible;
-	void	*data;
-};
-#define OF_ANY_MATCH		((char *)-1L)
-
-extern const struct of_match *of_match_device(
-	const struct of_match *matches, const struct of_device *dev);
+extern const struct of_device_id *of_match_device(
+	const struct of_device_id *matches, const struct of_device *dev);
 
 extern struct of_device *of_dev_get(struct of_device *dev);
 extern void of_dev_put(struct of_device *dev);
@@ -49,10 +37,10 @@ extern void of_dev_put(struct of_device 
 struct of_platform_driver
 {
 	char			*name;
-	struct of_match		*match_table;
+	struct of_device_id	*match_table;
 	struct module		*owner;
 
-	int	(*probe)(struct of_device* dev, const struct of_match *match);
+	int	(*probe)(struct of_device* dev, const struct of_device_id *match);
 	int	(*remove)(struct of_device* dev);
 
 	int	(*suspend)(struct of_device* dev, pm_message_t state);
diff -ruNpX dontdiff linux-2.6.13-rc2.orig/include/linux/mod_devicetable.h linux-2.6.13-rc2/include/linux/mod_devicetable.h
--- linux-2.6.13-rc2.orig/include/linux/mod_devicetable.h	2005-07-06 11:39:23.000000000 -0400
+++ linux-2.6.13-rc2/include/linux/mod_devicetable.h	2005-07-06 11:40:25.000000000 -0400
@@ -174,6 +174,17 @@ struct serio_device_id {
 	__u8 proto;
 };
 
+/*
+ * Struct used for matching a device
+ */
+struct of_device_id
+{
+	char	name[32];
+	char	type[32];
+	char	compatible[128];
+	void	*data;
+};
+
 
 /* PCMCIA */
 
diff -ruNpX dontdiff linux-2.6.13-rc2.orig/scripts/mod/file2alias.c linux-2.6.13-rc2/scripts/mod/file2alias.c
--- linux-2.6.13-rc2.orig/scripts/mod/file2alias.c	2005-07-06 11:39:26.000000000 -0400
+++ linux-2.6.13-rc2/scripts/mod/file2alias.c	2005-07-06 11:40:39.000000000 -0400
@@ -25,6 +25,8 @@ typedef Elf64_Addr	kernel_ulong_t;
 #include <stdint.h>
 #endif
 
+#include <ctype.h>
+
 typedef uint32_t	__u32;
 typedef uint16_t	__u16;
 typedef unsigned char	__u8;
@@ -323,6 +325,22 @@ static int do_pcmcia_entry(const char *f
 
 
 
+static int do_of_entry (const char *filename, struct of_device_id *of, char *alias)
+{
+    char *tmp;
+    sprintf (alias, "of:N%sT%sC%s",
+                    of->name[0] ? of->name : "*",
+                    of->type[0] ? of->type : "*",
+                    of->compatible[0] ? of->compatible : "*");
+
+    /* Replace all whitespace with underscores */
+    for (tmp = alias; tmp && *tmp; tmp++)
+        if (isspace (*tmp))
+            *tmp = '_';
+
+    return 1;
+}
+
 /* Ignore any prefix, eg. v850 prepends _ */
 static inline int sym_is(const char *symbol, const char *name)
 {
@@ -401,6 +419,10 @@ void handle_moddevtable(struct module *m
 	else if (sym_is(symname, "__mod_pcmcia_device_table"))
 		do_table(symval, sym->st_size, sizeof(struct pcmcia_device_id),
 			 do_pcmcia_entry, mod);
+        else if (sym_is(symname, "__mod_of_device_table"))
+		do_table(symval, sym->st_size, sizeof(struct of_device_id),
+			 do_of_entry, mod);
+
 }
 
 /* Now add out buffered information to the generated C source */
-- 
Jeff Mahoney
SuSE Labs
