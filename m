Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbSKCHjP>; Sun, 3 Nov 2002 02:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261614AbSKCHjP>; Sun, 3 Nov 2002 02:39:15 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:35492 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261595AbSKCHjM>; Sun, 3 Nov 2002 02:39:12 -0500
Date: Sat, 2 Nov 2002 23:45:37 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: Greg KH <greg@kroah.com>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.45/drivers/base/bus.c - new field to consolidate memory allocation in many drivers
Message-ID: <20021102234537.A335@baldur.yggdrasil.com>
References: <20021102112951.A6910@adam.yggdrasil.com> <20021102204258.GA22607@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20021102204258.GA22607@kroah.com>; from greg@kroah.com on Sat, Nov 02, 2002 at 12:42:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 02, 2002 at 12:42:58PM -0800, Greg KH wrote:
> On Sat, Nov 02, 2002 at 11:29:51AM -0800, Adam J. Richter wrote:
> > 
> > 	This patch allows device drivers to tell the generic device
> > code to handle allocating the per-device blob of memory that is
> > normally stored in device.driver_data.  It does so by adding a new
> > field device_driver.drvdata_size, with the following semantics:
> 
> Ugh, have you tried to use this patch in real life with the busses that
> use driver_data today?  I didn't think so :)
> 
> In short, only the driver's individual probe function knows how big of a
> data chunk it needs, and that probe function isn't known until probe()
> is called.  Hm, well ok, match() could set this, but then it would have
> to call into the function found by match to get the size.  By then it's
> just really not worth adding this extra complexity to the code.

	Although I had not converted any drivers when I wrote my
previous message, I am now writing this message on a machine using a
via-rhine ethernet driver that uses this facility.  The driver is
three lines smaller and, more importantly, has one less probably
untested error branch.  I think this example should address you
concerns.

	Note that because struct net_device may need to persist after
->remove() returns, I had to make a net_device.destructor function
(sharable with all similar network device drivers) rather than allow
drivers/base/bus.c to do the kfree.  If the same turns out to be true
for Scsi_Host, gendisk, etc., then I will scrap the kfree part of my
proposal.

	Drivers that really want to do a single variable-length
kmalloc for their private data will not use this facility, or will use
drvpriv_size = -1 if they want to just eliminate the kfree.  I think
those drivers will be rare if the allocators for the underlying
software abstractions (Scsi_Host, net_device, gendisk, etc.) are made
available that can just take a pointer to zero-filled memory rather
than doing the kmalloc themselves.

	This change may seem like small fry, but it's important to
understand that it will potentially eliminate a lot of untested error
branches and also that I plan some similar optional consolidation of
other driver resource allocations, especially those that can return
failure (DMA consistent memory, streaming DMA mappings, request_region
in ISA drivers, etc., but I'd like to do this incrementally).
Ultimately, this should produce smaller and more reliable drivers.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diffs

--- linux-2.5.45/include/linux/device.h	2002-10-30 16:43:40.000000000 -0800
+++ linux/include/linux/device.h	2002-11-02 05:20:36.000000000 -0800
@@ -114,6 +114,7 @@
 	char			* name;
 	struct bus_type		* bus;
 	struct device_class	* devclass;
+	int			drvdata_size;
 
 	rwlock_t		lock;
 	atomic_t		refcount;
--- linux-2.5.45/drivers/base/bus.c	2002-10-30 16:42:20.000000000 -0800
+++ linux/drivers/base/bus.c	2002-11-02 21:24:12.000000000 -0800
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/slab.h>
 #include "base.h"
 
 static LIST_HEAD(bus_driver_list);
@@ -94,16 +95,35 @@
 	list_add_tail(&dev->driver_list,&dev->driver->devices);
 }
 
+static void free_driver_data(struct device *dev)
+{
+	if (dev->driver->drvdata_size && dev->driver_data)
+		kfree(dev->driver_data);
+	dev->driver = NULL;
+}
+
 static int bus_match(struct device * dev, struct device_driver * drv)
 {
 	int error = -ENODEV;
 	if (dev->bus->match(dev,drv)) {
+
+		if (drv->drvdata_size > 0) {
+			dev->driver_data = kmalloc(drv->drvdata_size,
+						   GFP_KERNEL);
+			if (dev->driver_data)
+				memset(dev->driver_data, 0, drv->drvdata_size);
+			else
+				return -ENOMEM;
+		}
+		else
+			dev->driver_data = NULL;
+
 		dev->driver = drv;
 		if (drv->probe) {
 			if (!(error = drv->probe(dev)))
 				attach(dev);
 			else
-				dev->driver = NULL;
+				free_driver_data(dev);
 		} else 
 			attach(dev);
 	}
@@ -166,7 +186,7 @@
 		devclass_remove_device(dev);
 		if (drv->remove)
 			drv->remove(dev);
-		dev->driver = NULL;
+		free_driver_data(dev);
 	}
 }
 
--- linux-2.5.45/include/linux/netdevice.h	2002-10-30 16:43:43.000000000 -0800
+++ linux/include/linux/netdevice.h	2002-11-02 20:08:04.000000000 -0800
@@ -615,6 +623,8 @@
 	/* WILL BE REMOVED IN 2.5.0 */
 }
 
+extern void netdev_kfree_priv(struct net_device *dev);
+
 extern int netdev_finish_unregister(struct net_device *dev);
 
 static inline void dev_put(struct net_device *dev)
--- linux-2.5.45/net/core/dev.c	2002-10-30 16:42:56.000000000 -0800
+++ linux/net/core/dev.c	2002-11-02 20:08:16.000000000 -0800
@@ -2488,6 +2679,19 @@
 }
 
 /**
+ *	netdev_kfree_priv - Simple dev.destructor to free private data
+ *	@dev: device
+ *
+ *	Simply calls kfree(dev->priv).
+ */
+void
+netdev_kfree_priv(struct net_device *dev)
+{
+	kfree(dev->priv);
+}
+EXPORT_SYMBOL(netdev_kfree_priv);
+
+/**
  *	netdev_finish_unregister - complete unregistration
  *	@dev: device
  *
--- linux-2.5.45/drivers/net/via-rhine.c	2002-10-30 16:43:44.000000000 -0800
+++ linux/drivers/net/via-rhine.c	2002-11-02 21:47:02.000000000 -0800
@@ -501,6 +501,7 @@
 	unsigned int mii_cnt;			/* number of MIIs found, but only the first one is used */
 	u16 mii_status;						/* last read MII status */
 	struct mii_if_info mii_if;
+	struct net_device netdev;
 };
 
 static int  mdio_read(struct net_device *dev, int phy_id, int location);
@@ -571,8 +572,8 @@
 static int __devinit via_rhine_init_one (struct pci_dev *pdev,
 					 const struct pci_device_id *ent)
 {
-	struct net_device *dev;
-	struct netdev_private *np;
+	struct netdev_private *np = pci_get_drvdata(pdev);
+	struct net_device *dev = &np->netdev;
 	int i, option;
 	int chip_id = (int) ent->driver_data;
 	static int card_idx = -1;
@@ -618,15 +619,13 @@
 	if (pci_flags & PCI_USES_MASTER)
 		pci_set_master (pdev);
 
-	dev = alloc_etherdev(sizeof(*np));
-	if (dev == NULL) {
-		printk (KERN_ERR "init_ethernet failed for card #%d\n", card_idx);
+	if (pci_request_regions(pdev, shortname))
 		goto err_out;
-	}
+
+	init_etherdev(dev, 0);
 	SET_MODULE_OWNER(dev);
-	
-	if (pci_request_regions(pdev, shortname))
-		goto err_out_free_netdev;
+	dev->priv = np;
+	dev->destructor = netdev_kfree_priv;
 
 #ifdef USE_MEM
 	ioaddr0 = ioaddr;
@@ -707,7 +706,6 @@
 
 	dev->irq = pdev->irq;
 
-	np = dev->priv;
 	spin_lock_init (&np->lock);
 	np->chip_id = chip_id;
 	np->drv_flags = via_rhine_chip_info[chip_id].drv_flags;
@@ -760,8 +758,6 @@
 			printk("%2.2x:", dev->dev_addr[i]);
 	printk("%2.2x, IRQ %d.\n", dev->dev_addr[i], pdev->irq);
 
-	pci_set_drvdata(pdev, dev);
-
 	if (np->drv_flags & CanHaveMII) {
 		int phy, phy_idx = 0;
 		np->phys[0] = 1;		/* Standard for this chip. */
@@ -812,8 +808,6 @@
 err_out_free_res:
 #endif
 	pci_release_regions(pdev);
-err_out_free_netdev:
-	kfree (dev);
 err_out:
 	return -ENODEV;
 }
@@ -1730,7 +1724,8 @@
 
 static void __devexit via_rhine_remove_one (struct pci_dev *pdev)
 {
-	struct net_device *dev = pci_get_drvdata(pdev);
+	struct netdev_private *np = pci_get_drvdata(pdev);
+	struct net_device *dev = &np->netdev;
 	
 	unregister_netdev(dev);
 
@@ -1740,7 +1735,6 @@
 	iounmap((char *)(dev->base_addr));
 #endif
 
-	kfree(dev);
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
 }
@@ -1751,6 +1745,9 @@
 	.id_table	= via_rhine_pci_tbl,
 	.probe		= via_rhine_init_one,
 	.remove		= __devexit_p(via_rhine_remove_one),
+	.driver		= {
+		.drvdata_size = sizeof(struct netdev_private)
+	},
 };
 
 

--tThc/1wpZn/ma/RB--
