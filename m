Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262979AbVDBARH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262979AbVDBARH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbVDBAQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:16:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:47068 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262958AbVDAXsW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:22 -0500
Cc: gregkh@suse.de
Subject: [PATCH] PCI: create PCI_DEBUG config option to make it easier for users to enable pci debugging
In-Reply-To: <11123992741405@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:55 -0800
Message-Id: <1112399274351@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.26, 2005/03/28 22:29:40-08:00, gregkh@suse.de

[PATCH] PCI: create PCI_DEBUG config option to make it easier for users to enable pci debugging

Now you don't have to dig through a file to change a #define, it's a real config option.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/Kconfig     |   10 ++++++++++
 drivers/pci/Makefile    |    4 ++++
 drivers/pci/hotplug.c   |   15 ++++-----------
 drivers/pci/pci.c       |   12 +++---------
 drivers/pci/probe.c     |   25 +++++++++----------------
 drivers/pci/quirks.c    |    2 --
 drivers/pci/remove.c    |    8 --------
 drivers/pci/setup-irq.c |   10 +---------
 drivers/pci/setup-res.c |   16 ++++------------
 9 files changed, 35 insertions(+), 67 deletions(-)


diff -Nru a/drivers/pci/Kconfig b/drivers/pci/Kconfig
--- a/drivers/pci/Kconfig	2005-04-01 15:30:40 -08:00
+++ b/drivers/pci/Kconfig	2005-04-01 15:30:40 -08:00
@@ -47,3 +47,13 @@
 
 	  When in doubt, say Y.
 
+config PCI_DEBUG
+	bool "PCI Debugging"
+	depends on PCI && DEBUG_KERNEL
+	help
+	  Say Y here if you want the PCI core to produce a bunch of debug
+	  messages to the system log.  Select this if you are having a
+	  problem with PCI support and want to see more of what is going on.
+
+	  When in doubt, say N.
+
diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	2005-04-01 15:30:40 -08:00
+++ b/drivers/pci/Makefile	2005-04-01 15:30:40 -08:00
@@ -41,6 +41,10 @@
 obj-y += syscall.o
 endif
 
+ifeq ($(CONFIG_PCI_DEBUG),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
+
 hostprogs-y := gen-devlist
 
 # Dependencies on generated files need to be listed explicitly
diff -Nru a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c	2005-04-01 15:30:40 -08:00
+++ b/drivers/pci/hotplug.c	2005-04-01 15:30:40 -08:00
@@ -1,15 +1,8 @@
+#include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/module.h>
 #include "pci.h"
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif
-
 int pci_hotplug (struct device *dev, char **envp, int num_envp,
 		 char *buffer, int buffer_size)
 {
@@ -71,7 +64,7 @@
 	struct pci_dev_wrapped wrapped_dev;
 	int result = 0;
 
-	DBG("PCI: Scanning bus %04x:%02x\n", pci_domain_nr(wrapped_bus->bus),
+	pr_debug("PCI: Scanning bus %04x:%02x\n", pci_domain_nr(wrapped_bus->bus),
 		wrapped_bus->bus->number);
 
 	if (fn->pre_visit_pci_bus) {
@@ -107,7 +100,7 @@
 	struct pci_bus_wrapped wrapped_bus;
 	int result = 0;
 
-	DBG("PCI: Scanning bridge %s\n", pci_name(wrapped_dev->dev));
+	pr_debug("PCI: Scanning bridge %s\n", pci_name(wrapped_dev->dev));
 
 	if (fn->visit_pci_dev) {
 		result = fn->visit_pci_dev(wrapped_dev, wrapped_parent);
@@ -153,7 +146,7 @@
 				return result;
 			break;
 		default:
-			DBG("PCI: Scanning device %s\n", pci_name(dev));
+			pr_debug("PCI: Scanning device %s\n", pci_name(dev));
 			if (fn->visit_pci_dev) {
 				result = fn->visit_pci_dev (wrapped_dev,
 							    wrapped_parent);
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	2005-04-01 15:30:40 -08:00
+++ b/drivers/pci/pci.c	2005-04-01 15:30:40 -08:00
@@ -9,6 +9,7 @@
  *	Copyright 1997 -- 2000 Martin Mares <mj@ucw.cz>
  */
 
+#include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/pci.h>
@@ -16,13 +17,6 @@
 #include <linux/spinlock.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif
 
 /**
  * pci_bus_max_busnr - returns maximum PCI bus number of given bus' children
@@ -633,7 +627,7 @@
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	if (! (cmd & PCI_COMMAND_MASTER)) {
-		DBG("PCI: Enabling bus mastering for device %s\n", pci_name(dev));
+		pr_debug("PCI: Enabling bus mastering for device %s\n", pci_name(dev));
 		cmd |= PCI_COMMAND_MASTER;
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
@@ -711,7 +705,7 @@
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	if (! (cmd & PCI_COMMAND_INVALIDATE)) {
-		DBG("PCI: Enabling Mem-Wr-Inval for device %s\n", pci_name(dev));
+		pr_debug("PCI: Enabling Mem-Wr-Inval for device %s\n", pci_name(dev));
 		cmd |= PCI_COMMAND_INVALIDATE;
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2005-04-01 15:30:40 -08:00
+++ b/drivers/pci/probe.c	2005-04-01 15:30:40 -08:00
@@ -2,6 +2,7 @@
  * probe.c - PCI detection and setup code
  */
 
+#include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/pci.h>
@@ -9,14 +10,6 @@
 #include <linux/module.h>
 #include <linux/cpumask.h>
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif
-
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
 #define CARDBUS_RESERVE_BUSNR	3
 #define PCI_CFG_SPACE_SIZE	256
@@ -422,8 +415,8 @@
 
 	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
 
-	DBG("PCI: Scanning behind PCI bridge %s, config %06x, pass %d\n",
-	    pci_name(dev), buses & 0xffffff, pass);
+	pr_debug("PCI: Scanning behind PCI bridge %s, config %06x, pass %d\n",
+		 pci_name(dev), buses & 0xffffff, pass);
 
 	/* Disable MasterAbortMode during probing to avoid reporting
 	   of bus errors (in some architectures) */ 
@@ -559,8 +552,8 @@
 	dev->class = class;
 	class >>= 8;
 
-	DBG("PCI: Found %s [%04x/%04x] %06x %02x\n", pci_name(dev),
-	    dev->vendor, dev->device, class, dev->hdr_type);
+	pr_debug("PCI: Found %s [%04x/%04x] %06x %02x\n", pci_name(dev),
+		 dev->vendor, dev->device, class, dev->hdr_type);
 
 	/* "Unknown power state" */
 	dev->current_state = 4;
@@ -815,7 +808,7 @@
 	unsigned int devfn, pass, max = bus->secondary;
 	struct pci_dev *dev;
 
-	DBG("PCI: Scanning bus %04x:%02x\n", pci_domain_nr(bus), bus->number);
+	pr_debug("PCI: Scanning bus %04x:%02x\n", pci_domain_nr(bus), bus->number);
 
 	/* Go find them, Rover! */
 	for (devfn = 0; devfn < 0x100; devfn += 8)
@@ -825,7 +818,7 @@
 	 * After performing arch-dependent fixup of the bus, look behind
 	 * all PCI-to-PCI bridges on this bus.
 	 */
-	DBG("PCI: Fixups for bus %04x:%02x\n", pci_domain_nr(bus), bus->number);
+	pr_debug("PCI: Fixups for bus %04x:%02x\n", pci_domain_nr(bus), bus->number);
 	pcibios_fixup_bus(bus);
 	for (pass=0; pass < 2; pass++)
 		list_for_each_entry(dev, &bus->devices, bus_list) {
@@ -841,7 +834,7 @@
 	 *
 	 * Return how far we've got finding sub-buses.
 	 */
-	DBG("PCI: Bus scan for %04x:%02x returning with max=%02x\n",
+	pr_debug("PCI: Bus scan for %04x:%02x returning with max=%02x\n",
 		pci_domain_nr(bus), bus->number, max);
 	return max;
 }
@@ -881,7 +874,7 @@
 
 	if (pci_find_bus(pci_domain_nr(b), bus)) {
 		/* If we already got to this bus through a different bridge, ignore it */
-		DBG("PCI: Bus %04x:%02x already known\n", pci_domain_nr(b), bus);
+		pr_debug("PCI: Bus %04x:%02x already known\n", pci_domain_nr(b), bus);
 		goto err_out;
 	}
 	list_add_tail(&b->node, &pci_root_buses);
diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2005-04-01 15:30:40 -08:00
+++ b/drivers/pci/quirks.c	2005-04-01 15:30:40 -08:00
@@ -19,8 +19,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 
-#undef DEBUG
-
 /* Deal with broken BIOS'es that neglect to enable passive release,
    which can cause problems in combination with the 82441FX/PPro MTRRs */
 static void __devinit quirk_passive_release(struct pci_dev *dev)
diff -Nru a/drivers/pci/remove.c b/drivers/pci/remove.c
--- a/drivers/pci/remove.c	2005-04-01 15:30:40 -08:00
+++ b/drivers/pci/remove.c	2005-04-01 15:30:40 -08:00
@@ -2,14 +2,6 @@
 #include <linux/module.h>
 #include "pci.h"
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif
-
 static void pci_free_resources(struct pci_dev *dev)
 {
 	int i;
diff -Nru a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
--- a/drivers/pci/setup-irq.c	2005-04-01 15:30:40 -08:00
+++ b/drivers/pci/setup-irq.c	2005-04-01 15:30:40 -08:00
@@ -18,14 +18,6 @@
 #include <linux/cache.h>
 
 
-#define DEBUG_CONFIG 0
-#if DEBUG_CONFIG
-#define DBG(x...)     printk(x)
-#else
-#define DBG(x...)
-#endif
-
-
 static void __init
 pdev_fixup_irq(struct pci_dev *dev,
 	       u8 (*swizzle)(struct pci_dev *, u8 *),
@@ -53,7 +45,7 @@
 		irq = 0;
 	dev->irq = irq;
 
-	DBG(KERN_ERR "PCI: fixup irq: (%s) got %d\n",
+	pr_debug("PCI: fixup irq: (%s) got %d\n",
 		dev->dev.kobj.name, dev->irq);
 
 	/* Always tell the device, so the driver knows what is
diff -Nru a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
--- a/drivers/pci/setup-res.c	2005-04-01 15:30:40 -08:00
+++ b/drivers/pci/setup-res.c	2005-04-01 15:30:40 -08:00
@@ -25,13 +25,6 @@
 #include <linux/slab.h>
 #include "pci.h"
 
-#define DEBUG_CONFIG 0
-#if DEBUG_CONFIG
-#define DBG(x...)     printk(x)
-#else
-#define DBG(x...)
-#endif
-
 
 static void
 pci_update_resource(struct pci_dev *dev, struct resource *res, int resno)
@@ -42,10 +35,9 @@
 
 	pcibios_resource_to_bus(dev, &region, res);
 
-	DBG(KERN_ERR "  got res [%lx:%lx] bus [%lx:%lx] flags %lx for "
-	      "BAR %d of %s\n", res->start, res->end,
-	      region.start, region.end, res->flags,
-	      resno, pci_name(dev));
+	pr_debug("  got res [%lx:%lx] bus [%lx:%lx] flags %lx for "
+		 "BAR %d of %s\n", res->start, res->end,
+		 region.start, region.end, res->flags, resno, pci_name(dev));
 
 	new = region.start | (res->flags & PCI_REGION_FLAG_MASK);
 	if (res->flags & IORESOURCE_IO)
@@ -85,7 +77,7 @@
 		}
 	}
 	res->flags &= ~IORESOURCE_UNSET;
-	DBG(KERN_INFO "PCI: moved device %s resource %d (%lx) to %x\n",
+	pr_debug("PCI: moved device %s resource %d (%lx) to %x\n",
 		pci_name(dev), resno, res->flags,
 		new & ~PCI_REGION_FLAG_MASK);
 }

