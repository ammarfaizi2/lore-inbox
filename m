Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262472AbSKCWeF>; Sun, 3 Nov 2002 17:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262547AbSKCWeF>; Sun, 3 Nov 2002 17:34:05 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:62387 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262472AbSKCWeA>; Sun, 3 Nov 2002 17:34:00 -0500
Date: Sun, 3 Nov 2002 14:40:22 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: mochel@osdl.org, linux-kernel@vger.kernel.org
Cc: davem@redhat.com, greg@kroah.com
Subject: Re: Patch: linux-2.5.45/drivers/base/bus.c - new field to consolidate memory allocation in many drivers
Message-ID: <20021103144022.A8273@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Here is a new version of my patch that also allows drivers to
ask the generic driver code to allocate a fixed-size per-device blob of
consistent DMA memory.  It includes an example patch to via-rhine.c,
removing another 14 lines, including another memory allocation failure
error branch.  I am running the resulting via-rhine driver now.

	If I can eliminate an average of 5 line from each of the 557
modules in my modules.pcimap (never mind other busses for the moment),
that would be over 2000 lines of code.  More importantly, I'm sure it
would eliminate a lot of bugs in untested error branches.

	Dave M.: I am cc'ing this to because you asked for a
bus-independent API for allocating DMA consistent memory when I
discusssed consolidating some other driver DMA mapping operations
about six months ago.  This patch adds the wrapper functions
dma_{alloc,free}_consistent() for this purpose which are not optimized
right now, but provide an API and could be expanded to support more
the the DMA allocation API as it is actually used.  The implementation
can be optimized later, but I think it addresses your concern about
propagating artificial PCI dependence.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dma.diff"

--- linux-2.5.45/include/linux/dma-map.h	1969-12-31 16:00:00.000000000 -0800
+++ linux/include/linux/dma-map.h	2002-11-03 05:27:04.000000000 -0800
@@ -0,0 +1,53 @@
+/*
+ * Generic DMA region interface.
+ */
+
+#ifndef LINUX_DMA_MAP_H
+#define LINUX_DMA_MAP_H
+
+#include <asm/types.h>
+#include <linux/device.h>
+
+struct device;
+
+struct dma_ops {
+	void *(*alloc_consistent)(struct device *dev, size_t size,
+				  dma_addr_t *dma_handle);
+
+	void (*free_consistent)(struct device *dev, size_t size,
+				void *vaddr, dma_addr_t dma_handle);
+
+	/* Other operations (map_page, map_single, etc.) will be added
+	   when they are actually used. */
+};
+
+/* So we only have one place to change if dma_ops is moved: */
+static inline struct dma_ops *DEV_DMA_OPS(struct device *dev)
+{
+	return dev->bus->dma_ops;
+}
+
+static inline void *
+dma_alloc_consistent(struct device *dev, size_t size, dma_addr_t *dma_handle)
+{
+	void *ptr;
+	ptr = (*DEV_DMA_OPS(dev)->alloc_consistent)(dev, size, dma_handle);
+
+#if 0
+	/* Currently every alloc_consistent implementation replicates this.
+	   In the future, only do the memset here. */
+	if (ptr)
+		memset(ptr, 0, size);
+#endif
+
+	return ptr;
+}
+
+static inline void dma_free_consistent(struct device *dev, size_t size,
+				       void *vaddr, dma_addr_t dma_handle)
+{
+	(*DEV_DMA_OPS(dev)->free_consistent)(dev, size, vaddr, dma_handle);
+}
+
+
+#endif /* LINUX_DMA_MAP_H */
--- linux-2.5.45/drivers/pci/dma-ops.c	1969-12-31 16:00:00.000000000 -0800
+++ linux/drivers/pci/dma-ops.c	2002-11-03 05:31:09.000000000 -0800
@@ -0,0 +1,22 @@
+#include <linux/dma-map.h>
+#include <linux/pci.h>
+
+static void *_pci_alloc_consistent(struct device *dev, size_t size,
+				   dma_addr_t *dma_handle)
+{
+	struct pci_dev *pcidev = container_of(dev, struct pci_dev, dev);
+	return pci_alloc_consistent(pcidev, size, dma_handle);
+}
+
+static void _pci_free_consistent(struct device *dev, size_t size,
+				 void *vaddr, dma_addr_t dma_handle)
+{
+	struct pci_dev *pcidev = container_of(dev, struct pci_dev, dev);
+	pci_free_consistent(pcidev, size, vaddr, dma_handle);
+}
+
+
+struct dma_ops pci_dma_ops = {
+	.alloc_consistent =	_pci_alloc_consistent,
+	.free_consistent =	_pci_free_consistent,
+};
--- linux-2.5.45/include/linux/device.h	2002-10-30 16:43:40.000000000 -0800
+++ linux/include/linux/device.h	2002-11-03 05:04:52.000000000 -0800
@@ -58,6 +58,7 @@
 struct device;
 struct device_driver;
 struct device_class;
+struct dma_ops;
 
 struct bus_type {
 	char			* name;
@@ -68,6 +69,7 @@
 	struct list_head	node;
 	struct list_head	devices;
 	struct list_head	drivers;
+	struct dma_ops		*dma_ops; /* For CPU busses: pci, isa, sbus */
 
 	struct driver_dir_entry	dir;
 	struct driver_dir_entry	device_dir;
@@ -114,6 +116,8 @@
 	char			* name;
 	struct bus_type		* bus;
 	struct device_class	* devclass;
+	int			drv_alloc;
+	int			dma_alloc;
 
 	rwlock_t		lock;
 	atomic_t		refcount;
@@ -290,6 +294,8 @@
 	struct device_driver *driver;	/* which driver has allocated this
 					   device */
 	void		*driver_data;	/* data private to the driver */
+	void		*dma_vaddr;
+	dma_addr_t	dma_busaddr;
 
 	u32		class_num;	/* class-enumerated value */
 	void		* class_data;	/* class-specific data */
--- linux-2.5.45/drivers/base/bus.c	2002-10-30 16:42:20.000000000 -0800
+++ linux/drivers/base/bus.c	2002-11-03 06:21:16.000000000 -0800
@@ -12,6 +12,8 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/dma-map.h>
 #include "base.h"
 
 static LIST_HEAD(bus_driver_list);
@@ -94,16 +96,57 @@
 	list_add_tail(&dev->driver_list,&dev->driver->devices);
 }
 
+static void free_driver_data(struct device *dev, struct device_driver *drv)
+{
+	if (drv->drv_alloc && dev->driver_data)
+		kfree(dev->driver_data);
+
+	if (drv->dma_alloc && dev->dma_vaddr)
+		dma_free_consistent(dev, drv->dma_alloc,
+				    dev->dma_vaddr, dev->dma_busaddr);
+
+	dev->driver = NULL;
+}
+
+static int alloc_driver_data(struct device *dev, struct device_driver *drv)
+{
+	dev->driver_data = NULL;
+	dev->dma_vaddr = NULL;
+
+	if (drv->dma_alloc != 0) {
+		dev->dma_vaddr = dma_alloc_consistent(dev, drv->dma_alloc,
+						      &dev->dma_busaddr);
+		if (!dev->dma_vaddr)
+			return -ENOMEM;
+	}
+	if (drv->drv_alloc > 0) {
+		dev->driver_data = kmalloc(drv->drv_alloc,  GFP_KERNEL);
+		if (dev->driver_data)
+			memset(dev->driver_data, 0, drv->drv_alloc);
+		else {
+			free_driver_data(dev, drv);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
 static int bus_match(struct device * dev, struct device_driver * drv)
 {
 	int error = -ENODEV;
 	if (dev->bus->match(dev,drv)) {
+		int alloc_err = alloc_driver_data(dev, drv);
+
+		if (alloc_err)
+			return alloc_err;
+
 		dev->driver = drv;
 		if (drv->probe) {
 			if (!(error = drv->probe(dev)))
 				attach(dev);
 			else
-				dev->driver = NULL;
+				free_driver_data(dev, drv);
 		} else 
 			attach(dev);
 	}
@@ -166,9 +209,9 @@
 		devclass_remove_device(dev);
 		if (drv->remove)
 			drv->remove(dev);
-		dev->driver = NULL;
+		free_driver_data(dev, drv);
 	}
 }
 
--- linux-2.5.45/include/linux/netdevice.h	2002-10-30 16:43:43.000000000 -0800
+++ linux/include/linux/netdevice.h	2002-11-02 20:08:04.000000000 -0800
@@ -615,8 +623,10 @@
 	/* WILL BE REMOVED IN 2.5.0 */
 }
 
+extern void netdev_kfree_priv(struct net_device *dev);
+
 extern int netdev_finish_unregister(struct net_device *dev);
 
 static inline void dev_put(struct net_device *dev)
--- linux-2.5.45/net/core/dev.c	2002-10-30 16:42:56.000000000 -0800
+++ linux/net/core/dev.c	2002-11-03 00:15:23.000000000 -0800
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
@@ -2511,7 +2715,7 @@
 #endif
 	if (dev->destructor)
 		dev->destructor(dev);
-	if (dev->features & NETIF_F_DYNALLOC)
+	else if (dev->features & NETIF_F_DYNALLOC)
 		kfree(dev);
 	return 0;
 }
--- linux-2.5.45/drivers/net/via-rhine.c	2002-10-30 16:43:44.000000000 -0800
+++ linux/drivers/net/via-rhine.c	2002-11-03 06:09:29.000000000 -0800
@@ -143,7 +143,6 @@
 #define TX_QUEUE_LEN	10		/* Limit ring entries actually used.  */
 #define RX_RING_SIZE	16
 
-
 /* Operational parameters that usually are not changed. */
 
 /* Time in jiffies before concluding the transmitter is hung. */
@@ -441,6 +440,9 @@
 	u32 next_desc;
 };
 
+#define RX_RING_BYTES	(RX_RING_SIZE * sizeof(struct rx_desc))
+#define TX_RING_BYTES   (TX_RING_SIZE * sizeof(struct tx_desc))
+
 enum rx_status_bits {
 	RxOK=0x8000, RxWholePkt=0x0300, RxErr=0x008F
 };
@@ -501,6 +503,7 @@
 	unsigned int mii_cnt;			/* number of MIIs found, but only the first one is used */
 	u16 mii_status;						/* last read MII status */
 	struct mii_if_info mii_if;
+	struct net_device netdev;
 };
 
 static int  mdio_read(struct net_device *dev, int phy_id, int location);
@@ -571,8 +574,8 @@
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
@@ -618,15 +621,13 @@
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
@@ -707,7 +708,6 @@
 
 	dev->irq = pdev->irq;
 
-	np = dev->priv;
 	spin_lock_init (&np->lock);
 	np->chip_id = chip_id;
 	np->drv_flags = via_rhine_chip_info[chip_id].drv_flags;
@@ -760,8 +760,6 @@
 			printk("%2.2x:", dev->dev_addr[i]);
 	printk("%2.2x, IRQ %d.\n", dev->dev_addr[i], pdev->irq);
 
-	pci_set_drvdata(pdev, dev);
-
 	if (np->drv_flags & CanHaveMII) {
 		int phy, phy_idx = 0;
 		np->phys[0] = 1;		/* Standard for this chip. */
@@ -812,8 +810,6 @@
 err_out_free_res:
 #endif
 	pci_release_regions(pdev);
-err_out_free_netdev:
-	kfree (dev);
 err_out:
 	return -ENODEV;
 }
@@ -821,27 +817,14 @@
 static int alloc_ring(struct net_device* dev)
 {
 	struct netdev_private *np = dev->priv;
-	void *ring;
-	dma_addr_t ring_dma;
+	void *ring = np->pdev->dev.dma_vaddr;
+	dma_addr_t ring_dma = np->pdev->dev.dma_busaddr;
 
-	ring = pci_alloc_consistent(np->pdev, 
-				    RX_RING_SIZE * sizeof(struct rx_desc) +
-				    TX_RING_SIZE * sizeof(struct tx_desc),
-				    &ring_dma);
-	if (!ring) {
-		printk(KERN_ERR "Could not allocate DMA memory.\n");
-		return -ENOMEM;
-	}
 	if (np->drv_flags & ReqTxAlign) {
 		np->tx_bufs = pci_alloc_consistent(np->pdev, PKT_BUF_SZ * TX_RING_SIZE,
 								   &np->tx_bufs_dma);
-		if (np->tx_bufs == NULL) {
-			pci_free_consistent(np->pdev, 
-				    RX_RING_SIZE * sizeof(struct rx_desc) +
-				    TX_RING_SIZE * sizeof(struct tx_desc),
-				    ring, ring_dma);
+		if (np->tx_bufs == NULL)
 			return -ENOMEM;
-		}
 	}
 
 	np->rx_ring = ring;
@@ -856,10 +839,6 @@
 {
 	struct netdev_private *np = dev->priv;
 
-	pci_free_consistent(np->pdev, 
-			    RX_RING_SIZE * sizeof(struct rx_desc) +
-			    TX_RING_SIZE * sizeof(struct tx_desc),
-			    np->rx_ring, np->rx_ring_dma);
 	np->tx_ring = NULL;
 
 	if (np->tx_bufs)
@@ -1730,7 +1709,8 @@
 
 static void __devexit via_rhine_remove_one (struct pci_dev *pdev)
 {
-	struct net_device *dev = pci_get_drvdata(pdev);
+	struct netdev_private *np = pci_get_drvdata(pdev);
+	struct net_device *dev = &np->netdev;
 	
 	unregister_netdev(dev);
 
@@ -1740,7 +1720,6 @@
 	iounmap((char *)(dev->base_addr));
 #endif
 
-	kfree(dev);
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
 }
@@ -1751,6 +1730,10 @@
 	.id_table	= via_rhine_pci_tbl,
 	.probe		= via_rhine_init_one,
 	.remove		= __devexit_p(via_rhine_remove_one),
+	.driver		= {
+		.drv_alloc = sizeof(struct netdev_private),
+		.dma_alloc = RX_RING_BYTES + TX_RING_BYTES,
+	},
 };
 
 

--0OAP2g/MAC+5xKAE--
