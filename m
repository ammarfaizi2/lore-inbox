Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264760AbSLFQmN>; Fri, 6 Dec 2002 11:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbSLFQmM>; Fri, 6 Dec 2002 11:42:12 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:2323 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264760AbSLFQkw>;
	Fri, 6 Dec 2002 11:40:52 -0500
Date: Fri, 6 Dec 2002 08:48:02 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PNP driver changes for 2.5.50
Message-ID: <20021206164802.GB10376@kroah.com>
References: <20021206164522.GA10376@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206164522.GA10376@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.837.4.1, 2002/12/05 23:31:21-06:00, ambx1@neo.rr.com

[PATCH] Linux PnP Support V0.93 - 2.5.50

Attached is a patch, that updates the 2.5.50 to the latest pnp
version.  It includes all 9 of the previously submitted patches.

Highlights are as follows:
-PnP BIOS fixes
-Several new macros
-PnP Card Services
-Various bug fixes
-more drivers converted to the new APIs


diff -Nru a/drivers/input/gameport/ns558.c b/drivers/input/gameport/ns558.c
--- a/drivers/input/gameport/ns558.c	Fri Dec  6 10:38:41 2002
+++ b/drivers/input/gameport/ns558.c	Fri Dec  6 10:38:41 2002
@@ -37,7 +37,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/slab.h>
-#include <linux/isapnp.h>
+#include <linux/pnp.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Classic gameport (ISA/PnP) driver");
@@ -52,7 +52,7 @@
 struct ns558 {
 	int type;
 	int size;
-	struct pci_dev *dev;
+	struct pnp_dev *dev;
 	struct list_head node;
 	struct gameport gameport;
 	char phys[32];
@@ -159,67 +159,55 @@
 	list_add(&port->node, &ns558_list);
 }
 
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 
-#define NS558_DEVICE(a,b,c,d)\
-	.card_vendor = ISAPNP_ANY_ID, card_device: ISAPNP_ANY_ID,\
-	.vendor = ISAPNP_VENDOR(a,b,c), function: ISAPNP_DEVICE(d)
-
-static struct isapnp_device_id pnp_devids[] = {
-	{ NS558_DEVICE('@','P','@',0x0001) }, /* ALS 100 */
-	{ NS558_DEVICE('@','P','@',0x0020) }, /* ALS 200 */
-	{ NS558_DEVICE('@','P','@',0x1001) }, /* ALS 100+ */
-	{ NS558_DEVICE('@','P','@',0x2001) }, /* ALS 120 */
-	{ NS558_DEVICE('A','S','B',0x16fd) }, /* AdLib NSC16 */
-	{ NS558_DEVICE('A','Z','T',0x3001) }, /* AZT1008 */
-	{ NS558_DEVICE('C','D','C',0x0001) }, /* Opl3-SAx */
-	{ NS558_DEVICE('C','S','C',0x0001) }, /* CS4232 */
-	{ NS558_DEVICE('C','S','C',0x000f) }, /* CS4236 */
-	{ NS558_DEVICE('C','S','C',0x0101) }, /* CS4327 */
-	{ NS558_DEVICE('C','T','L',0x7001) }, /* SB16 */
-	{ NS558_DEVICE('C','T','L',0x7002) }, /* AWE64 */
-	{ NS558_DEVICE('C','T','L',0x7005) }, /* Vibra16 */
-	{ NS558_DEVICE('E','N','S',0x2020) }, /* SoundscapeVIVO */
-	{ NS558_DEVICE('E','S','S',0x0001) }, /* ES1869 */
-	{ NS558_DEVICE('E','S','S',0x0005) }, /* ES1878 */
-	{ NS558_DEVICE('E','S','S',0x6880) }, /* ES688 */
-	{ NS558_DEVICE('I','B','M',0x0012) }, /* CS4232 */
-	{ NS558_DEVICE('O','P','T',0x0001) }, /* OPTi Audio16 */
-	{ NS558_DEVICE('Y','M','H',0x0006) }, /* Opl3-SA */
-	{ NS558_DEVICE('Y','M','H',0x0022) }, /* Opl3-SAx */
-	{ NS558_DEVICE('P','N','P',0xb02f) }, /* Generic */
-	{ 0, },
+static struct pnp_id pnp_devids[] = {
+	{ .id = "@P@0001", .driver_data = 0 }, /* ALS 100 */
+	{ .id = "@P@0020", .driver_data = 0 }, /* ALS 200 */
+	{ .id = "@P@1001", .driver_data = 0 }, /* ALS 100+ */
+	{ .id = "@P@2001", .driver_data = 0 }, /* ALS 120 */
+	{ .id = "ASB16fd", .driver_data = 0 }, /* AdLib NSC16 */
+	{ .id = "AZT3001", .driver_data = 0 }, /* AZT1008 */
+	{ .id = "CDC0001", .driver_data = 0 }, /* Opl3-SAx */
+	{ .id = "CSC0001", .driver_data = 0 }, /* CS4232 */
+	{ .id = "CSC000f", .driver_data = 0 }, /* CS4236 */
+	{ .id = "CSC0101", .driver_data = 0 }, /* CS4327 */
+	{ .id = "CTL7001", .driver_data = 0 }, /* SB16 */
+	{ .id = "CTL7002", .driver_data = 0 }, /* AWE64 */
+	{ .id = "CTL7005", .driver_data = 0 }, /* Vibra16 */
+	{ .id = "ENS2020", .driver_data = 0 }, /* SoundscapeVIVO */
+	{ .id = "ESS0001", .driver_data = 0 }, /* ES1869 */
+	{ .id = "ESS0005", .driver_data = 0 }, /* ES1878 */
+	{ .id = "ESS6880", .driver_data = 0 }, /* ES688 */
+	{ .id = "IBM0012", .driver_data = 0 }, /* CS4232 */
+	{ .id = "OPT0001", .driver_data = 0 }, /* OPTi Audio16 */
+	{ .id = "YMH0006", .driver_data = 0 }, /* Opl3-SA */
+	{ .id = "YMH0022", .driver_data = 0 }, /* Opl3-SAx */
+	{ .id = "PNPb02f", .driver_data = 0 }, /* Generic */
+	{ .id = "", },
 };
 
-MODULE_DEVICE_TABLE(isapnp, pnp_devids);
+MODULE_DEVICE_TABLE(pnp, pnp_devids);
 
-static void ns558_pnp_probe(struct pci_dev *dev)
+static int ns558_pnp_probe(struct pnp_dev *dev, const struct pnp_id *cid, const struct pnp_id *did)
 {
 	int ioport, iolen;
 	struct ns558 *port;
 
-	if (dev->prepare && dev->prepare(dev) < 0)
-		return;
-
 	if (!(dev->resource[0].flags & IORESOURCE_IO)) {
 		printk(KERN_WARNING "ns558: No i/o ports on a gameport? Weird\n");
-		return;
+		return -ENODEV;
 	}
 
-	if (dev->activate && dev->activate(dev) < 0) {
-		printk(KERN_ERR "ns558: PnP resource allocation failed\n");
-		return;
-	}
-	
-	ioport = pci_resource_start(dev, 0);
-	iolen = pci_resource_len(dev, 0);
+	ioport = pnp_port_start(dev,0);
+	iolen = pnp_port_len(dev,0);
 
 	if (!request_region(ioport, iolen, "ns558-pnp"))
-		goto deactivate;
+		return -EBUSY;
 
 	if (!(port = kmalloc(sizeof(struct ns558), GFP_KERNEL))) {
 		printk(KERN_ERR "ns558: Memory allocation failed.\n");
-		goto deactivate;
+		return -ENOMEM;
 	}
 	memset(port, 0, sizeof(struct ns558));
 
@@ -231,54 +219,46 @@
 	port->gameport.phys = port->phys;
 	port->gameport.name = port->name;
 	port->gameport.id.bustype = BUS_ISAPNP;
-	port->gameport.id.vendor = dev->vendor;
-	port->gameport.id.product = dev->device;
 	port->gameport.id.version = 0x100;
 
-	sprintf(port->phys, "isapnp%d.%d/gameport0", PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+	sprintf(port->phys, "pnp%s/gameport0", dev->dev.bus_id);
 	sprintf(port->name, "%s", dev->dev.name[0] ? dev->dev.name : "NS558 PnP Gameport");
 
 	gameport_register_port(&port->gameport);
 
-	printk(KERN_INFO "gameport: NS558 PnP at isapnp%d.%d io %#x",
-		PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn), port->gameport.io);
+	printk(KERN_INFO "gameport: NS558 PnP at pnp%s io %#x",
+		dev->dev.bus_id, port->gameport.io);
 	if (iolen > 1) printk(" size %d", iolen);
 	printk(" speed %d kHz\n", port->gameport.speed);
 
 	list_add_tail(&port->node, &ns558_list);
-	return;
-
-deactivate:
-	if (dev->deactivate)
-		dev->deactivate(dev);
+	return 0;
 }
+
+static struct pnp_driver ns558_pnp_driver = {
+	.name		= "ns558",
+	.id_table	= pnp_devids,
+	.probe		= ns558_pnp_probe,
+};
+
+#else
+
+static const struct pnp_driver ns558_pnp_driver;
+
 #endif
 
 int __init ns558_init(void)
 {
 	int i = 0;
-#ifdef __ISAPNP__
-	struct isapnp_device_id *devid;
-	struct pci_dev *dev = NULL;
-#endif
 
 /*
  * Probe for ISA ports.
  */
 
-	while (ns558_isa_portlist[i]) 
+	while (ns558_isa_portlist[i])
 		ns558_isa_probe(ns558_isa_portlist[i++]);
 
-/*
- * Probe for PnP ports.
- */
-
-#ifdef __ISAPNP__
-	for (devid = pnp_devids; devid->vendor; devid++)
-		while ((dev = isapnp_find_dev(NULL, devid->vendor, devid->function, dev)))
-			ns558_pnp_probe(dev);
-#endif
-
+	pnp_register_driver(&ns558_pnp_driver);
 	return list_empty(&ns558_list) ? -ENODEV : 0;
 }
 
@@ -290,13 +270,10 @@
 		gameport_unregister_port(&port->gameport);
 		switch (port->type) {
 
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 			case NS558_PNP:
-				if (port->dev->deactivate)
-					port->dev->deactivate(port->dev);
 				/* fall through */
 #endif
-
 			case NS558_ISA:
 				release_region(port->gameport.io, port->size);
 				break;
@@ -305,6 +282,7 @@
 				break;
 		}
 	}
+	pnp_unregister_driver(&ns558_pnp_driver);
 }
 
 module_init(ns558_init);
diff -Nru a/drivers/net/e100/e100_main.c b/drivers/net/e100/e100_main.c
--- a/drivers/net/e100/e100_main.c	Fri Dec  6 10:38:41 2002
+++ b/drivers/net/e100/e100_main.c	Fri Dec  6 10:38:41 2002
@@ -87,8 +87,8 @@
 extern int e100_create_proc_subdir(struct e100_private *, char *);
 extern void e100_remove_proc_subdir(struct e100_private *, char *);
 #else
-#define e100_create_proc_subdir(X) 0
-#define e100_remove_proc_subdir(X) do {} while(0)
+#define e100_create_proc_subdir(X, Y) 0
+#define e100_remove_proc_subdir(X, Y) do {} while(0)
 #endif
 
 static int e100_do_ethtool_ioctl(struct net_device *, struct ifreq *);
diff -Nru a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
--- a/drivers/parport/parport_pc.c	Fri Dec  6 10:38:41 2002
+++ b/drivers/parport/parport_pc.c	Fri Dec  6 10:38:41 2002
@@ -2973,7 +2973,7 @@
 #endif /* CONFIG_PCI */
 
 #ifdef CONFIG_PNP
-static const struct pnp_id pnp_dev_table[] = {
+static const struct pnp_device_id pnp_dev_table[] = {
 	/* Standard LPT Printer Port */
 	{.id = "PNP0400", .driver_data = 0},
 	/* ECP Printer Port */
@@ -2984,7 +2984,6 @@
 /* we only need the pnp layer to activate the device, at least for now */
 static struct pnp_driver parport_pc_pnp_driver = {
 	.name		= "parport_pc",
-	.card_id_table	= NULL,
 	.id_table	= pnp_dev_table,
 };
 #else
diff -Nru a/drivers/pnp/Kconfig b/drivers/pnp/Kconfig
--- a/drivers/pnp/Kconfig	Fri Dec  6 10:38:41 2002
+++ b/drivers/pnp/Kconfig	Fri Dec  6 10:38:41 2002
@@ -2,7 +2,7 @@
 # Plug and Play configuration
 #
 
-menu "Plug and Play configuration"
+menu "Plug and Play support"
 
 config PNP
 	bool "Plug and Play support"
@@ -30,11 +30,20 @@
 
 	  If unsure, say Y.
 
+config PNP_CARD
+	bool "Plug and Play card services"
+	depends on PNP
+	help
+	  Select Y if you want the PnP Layer to manage cards.  Cards are groups
+	  of PnP devices.  Some drivers, especially PnP sound card drivers, use
+	  these cards.  If you want to use the protocol ISAPNP you will need to
+	  say Y here.
+
 config PNP_DEBUG
 	bool "PnP Debug Messages"
 	depends on PNP
 	help
-	  Say Y if you want the Plug and Play Layer to print debug messages.  
+	  Say Y if you want the Plug and Play Layer to print debug messages.
 	  This is useful if you are developing a PnP driver or troubleshooting.
 
 comment "Protocols"
@@ -42,7 +51,7 @@
 
 config ISAPNP
 	bool "ISA Plug and Play support (EXPERIMENTAL)"
-	depends on PNP && EXPERIMENTAL
+	depends on PNP && EXPERIMENTAL && PNP_CARD
 	help
 	  Say Y here if you would like support for ISA Plug and Play devices.
 	  Some information is in <file:Documentation/isapnp.txt>.
diff -Nru a/drivers/pnp/Makefile b/drivers/pnp/Makefile
--- a/drivers/pnp/Makefile	Fri Dec  6 10:38:41 2002
+++ b/drivers/pnp/Makefile	Fri Dec  6 10:38:41 2002
@@ -2,11 +2,13 @@
 # Makefile for the Linux Plug-and-Play Support.
 #
 
-obj-y		:= core.o driver.o resource.o interface.o quirks.o names.o system.o
+pnp-card-$(CONFIG_PNP_CARD) = card.o
+
+obj-y		:= core.o driver.o resource.o interface.o quirks.o names.o system.o $(pnp-card-y)
 
 obj-$(CONFIG_PNPBIOS)		+= pnpbios/
 obj-$(CONFIG_ISAPNP)		+= isapnp/
 
-export-objs	:= core.o driver.o resource.o
+export-objs	:= core.o driver.o resource.o $(pnp-card-y)
 
 include $(TOPDIR)/Rules.make
diff -Nru a/drivers/pnp/base.h b/drivers/pnp/base.h
--- a/drivers/pnp/base.h	Fri Dec  6 10:38:41 2002
+++ b/drivers/pnp/base.h	Fri Dec  6 10:38:41 2002
@@ -4,5 +4,6 @@
 extern int pnp_interface_attach_device(struct pnp_dev *dev);
 extern void pnp_name_device(struct pnp_dev *dev);
 extern void pnp_fixup_device(struct pnp_dev *dev);
-extern void pnp_free_ids(struct pnp_dev *dev);
 extern void pnp_free_resources(struct pnp_resources *resources);
+extern int __pnp_add_device(struct pnp_dev *dev);
+extern void __pnp_remove_device(struct pnp_dev *dev);
diff -Nru a/drivers/pnp/card.c b/drivers/pnp/card.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/pnp/card.c	Fri Dec  6 10:38:41 2002
@@ -0,0 +1,342 @@
+/*
+ * card.c - contains functions for managing groups of PnP devices
+ *
+ * Copyright 2002 Adam Belay <ambx1@neo.rr.com>
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#ifdef CONFIG_PNP_DEBUG
+	#define DEBUG
+#else
+	#undef DEBUG
+#endif
+
+#include <linux/pnp.h>
+#include <linux/init.h>
+#include "base.h"
+
+
+LIST_HEAD(pnp_cards);
+
+static const struct pnp_card_id * match_card(struct pnpc_driver *drv, struct pnp_card *card)
+{
+	const struct pnp_card_id *drv_id = drv->id_table;
+	while (*drv_id->id){
+		if (compare_pnp_id(card->id,drv_id->id))
+			return drv_id;
+		drv_id++;
+	}
+	return NULL;
+}
+
+static int card_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct pnp_card * card = to_pnp_card(dev);
+	struct pnpc_driver * pnp_drv = to_pnpc_driver(drv);
+	if (match_card(pnp_drv, card) == NULL)
+		return 0;
+	return 1;
+}
+
+struct bus_type pnpc_bus_type = {
+	name:	"pnp_card",
+	match:	card_bus_match,
+};
+
+
+/**
+ * pnpc_add_id - adds an EISA id to the specified card
+ * @id: pointer to a pnp_id structure
+ * @card: pointer to the desired card
+ *
+ */
+
+int pnpc_add_id(struct pnp_id *id, struct pnp_card *card)
+{
+	struct pnp_id *ptr;
+	if (!id)
+		return -EINVAL;
+	if (!card)
+		return -EINVAL;
+	ptr = card->id;
+	while (ptr && ptr->next)
+		ptr = ptr->next;
+	if (ptr)
+		ptr->next = id;
+	else
+		card->id = id;
+	return 0;
+}
+
+static void pnpc_free_ids(struct pnp_card *card)
+{
+	struct pnp_id * id;
+	struct pnp_id *next;
+	if (!card)
+		return;
+	id = card->id;
+	while (id) {
+		next = id->next;
+		kfree(id);
+		id = next;
+	}
+}
+
+static void pnp_release_card(struct device *dmdev)
+{
+	struct pnp_card * card = to_pnp_card(dmdev);
+	pnpc_free_ids(card);
+	kfree(card);
+}
+
+/**
+ * pnpc_add_card - adds a PnP card to the PnP Layer
+ * @card: pointer to the card to add
+ */
+
+int pnpc_add_card(struct pnp_card *card)
+{
+	int error = 0;
+	if (!card || !card->protocol)
+		return -EINVAL;
+	sprintf(card->dev.bus_id, "%02x:%02x", card->protocol->number, card->number);
+	INIT_LIST_HEAD(&card->rdevs);
+	strcpy(card->dev.name,card->name);
+	card->dev.parent = &card->protocol->dev;
+	card->dev.bus = &pnpc_bus_type;
+	card->dev.release = &pnp_release_card;
+	error = device_register(&card->dev);
+	if (error == 0){
+		struct list_head *pos;
+		spin_lock(&pnp_lock);
+		list_add_tail(&card->global_list, &pnp_cards);
+		list_add_tail(&card->protocol_list, &card->protocol->cards);
+		spin_unlock(&pnp_lock);
+		list_for_each(pos,&card->devices){
+			struct pnp_dev *dev = card_to_pnp_dev(pos);
+			__pnp_add_device(dev);
+		}
+	}
+	return error;
+}
+
+/**
+ * pnpc_remove_card - removes a PnP card from the PnP Layer
+ * @card: pointer to the card to remove
+ */
+
+void pnpc_remove_card(struct pnp_card *card)
+{
+	struct list_head *pos;
+	if (!card)
+		return;
+	device_unregister(&card->dev);
+	spin_lock(&pnp_lock);
+	list_del_init(&card->global_list);
+	list_del_init(&card->protocol_list);
+	spin_unlock(&pnp_lock);
+	list_for_each(pos,&card->devices){
+		struct pnp_dev *dev = card_to_pnp_dev(pos);
+		__pnp_remove_device(dev);
+	}
+}
+
+/**
+ * pnpc_add_device - adds a device to the specified card
+ * @card: pointer to the card to add to
+ * @dev: pointer to the device to add
+ */
+
+int pnpc_add_device(struct pnp_card *card, struct pnp_dev *dev)
+{
+	if (!dev || !dev->protocol || !card)
+		return -EINVAL;
+	dev->dev.parent = &card->dev;
+	sprintf(dev->dev.bus_id, "%02x:%02x.%02x", dev->protocol->number, card->number,dev->number);
+	spin_lock(&pnp_lock);
+	dev->card = card;
+	list_add_tail(&dev->card_list, &card->devices);
+	spin_unlock(&pnp_lock);
+	return 0;
+}
+
+/**
+ * pnpc_remove_device- removes a device from the specified card
+ * @card: pointer to the card to remove from
+ * @dev: pointer to the device to remove
+ */
+
+void pnpc_remove_device(struct pnp_dev *dev)
+{
+	spin_lock(&pnp_lock);
+	dev->card = NULL;
+	list_del_init(&dev->card_list);
+	spin_unlock(&pnp_lock);
+	__pnp_remove_device(dev);
+}
+
+/**
+ * pnp_request_card_device - Searches for a PnP device under the specified card
+ * @card: pointer to the card to search under, cannot be NULL
+ * @id: pointer to a PnP ID structure that explains the rules for finding the device
+ * @from: Starting place to search from. If NULL it will start from the begining.
+ *
+ * Will activate the device
+ */
+
+struct pnp_dev * pnp_request_card_device(struct pnp_card *card, const char *id, struct pnp_dev *from)
+{
+	struct list_head *pos;
+	struct pnp_dev *dev;
+	if (!card || !id)
+		goto done;
+	if (!from) {
+		pos = card->devices.next;
+	} else {
+		if (from->card != card)
+			goto done;
+		pos = from->card_list.next;
+	}
+	while (pos != &card->devices) {
+		dev = card_to_pnp_dev(pos);
+		if (compare_pnp_id(dev->id,id))
+			goto found;
+		pos = pos->next;
+	}
+
+done:
+	return NULL;
+
+found:
+	if (dev->active == 0)
+		if(pnp_activate_dev(dev)<0)
+			return NULL;
+	spin_lock(&pnp_lock);
+	list_add_tail(&dev->rdev_list, &card->rdevs);
+	spin_unlock(&pnp_lock);
+	return dev;
+}
+
+/**
+ * pnp_release_card_device - call this when the driver no longer needs the device
+ * @dev: pointer to the PnP device stucture
+ *
+ * Will disable the device
+ */
+
+void pnp_release_card_device(struct pnp_dev *dev)
+{
+	spin_lock(&pnp_lock);
+	list_del_init(&dev->rdev_list);
+	spin_unlock(&pnp_lock);
+	pnp_disable_dev(dev);
+}
+
+static void pnpc_recover_devices(struct pnp_card *card)
+{
+	struct list_head *pos;
+	list_for_each(pos,&card->rdevs){
+		struct pnp_dev *dev = list_entry(pos, struct pnp_dev, rdev_list);
+		pnp_release_card_device(dev);
+	}
+}
+
+static int pnpc_card_probe(struct device *dev)
+{
+	int error = 0;
+	struct pnpc_driver *drv = to_pnpc_driver(dev->driver);
+	struct pnp_card *card = to_pnp_card(dev);
+	const struct pnp_card_id *card_id = NULL;
+
+	pnp_dbg("pnp: match found with the PnP card '%s' and the driver '%s'", dev->bus_id,drv->name);
+
+	if (drv->probe) {
+		card_id = match_card(drv, card);
+		if (card_id != NULL)
+			error = drv->probe(card, card_id);
+		if (error >= 0){
+			card->driver = drv;
+			error = 0;
+		} else
+			pnpc_recover_devices(card);
+	}
+	return error;
+}
+
+static int pnpc_card_remove(struct device *dev)
+{
+	struct pnp_card * card = to_pnp_card(dev);
+	struct pnpc_driver * drv = card->driver;
+
+	if (drv) {
+		if (drv->remove)
+			drv->remove(card);
+		card->driver = NULL;
+	}
+	pnpc_recover_devices(card);
+	return 0;
+}
+
+/**
+ * pnpc_register_driver - registers a PnP card driver with the PnP Layer
+ * @cdrv: pointer to the driver to register
+ */
+
+int pnpc_register_driver(struct pnpc_driver * drv)
+{
+	int count;
+	struct list_head *pos;
+
+	drv->driver.name = drv->name;
+	drv->driver.bus = &pnpc_bus_type;
+	drv->driver.probe = pnpc_card_probe;
+	drv->driver.remove = pnpc_card_remove;
+
+	pnp_dbg("the card driver '%s' has been registered", drv->name);
+
+	count = driver_register(&drv->driver);
+
+	/* get the number of initial matches */
+	if (count >= 0){
+		count = 0;
+		list_for_each(pos,&drv->driver.devices){
+			count++;
+		}
+	}
+	return count;
+}
+
+/**
+ * pnpc_unregister_driver - unregisters a PnP card driver from the PnP Layer
+ * @cdrv: pointer to the driver to unregister
+ *
+ * Automatically disables requested devices
+ */
+
+void pnpc_unregister_driver(struct pnpc_driver *drv)
+{
+	driver_unregister(&drv->driver);
+	pnp_dbg("the card driver '%s' has been unregistered", drv->name);
+}
+
+static int __init pnp_card_init(void)
+{
+	printk(KERN_INFO "pnp: Enabling Plug and Play Card Services.\n");
+	return bus_register(&pnpc_bus_type);
+}
+
+subsys_initcall(pnp_card_init);
+
+EXPORT_SYMBOL(pnpc_add_card);
+EXPORT_SYMBOL(pnpc_remove_card);
+EXPORT_SYMBOL(pnpc_add_device);
+EXPORT_SYMBOL(pnpc_remove_device);
+EXPORT_SYMBOL(pnp_request_card_device);
+EXPORT_SYMBOL(pnp_release_card_device);
+EXPORT_SYMBOL(pnpc_register_driver);
+EXPORT_SYMBOL(pnpc_unregister_driver);
+EXPORT_SYMBOL(pnpc_add_id);
diff -Nru a/drivers/pnp/core.c b/drivers/pnp/core.c
--- a/drivers/pnp/core.c	Fri Dec  6 10:38:41 2002
+++ b/drivers/pnp/core.c	Fri Dec  6 10:38:41 2002
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/errno.h>
 
 #include "base.h"
 
@@ -41,7 +42,7 @@
  *  Ex protocols: ISAPNP, PNPBIOS, etc
  */
 
-int pnp_protocol_register(struct pnp_protocol *protocol)
+int pnp_register_protocol(struct pnp_protocol *protocol)
 {
 	int nodenum;
 	struct list_head * pos;
@@ -50,6 +51,7 @@
 		return -EINVAL;
 
 	INIT_LIST_HEAD(&protocol->devices);
+	INIT_LIST_HEAD(&protocol->cards);
 	nodenum = 0;
 	spin_lock(&pnp_lock);
 
@@ -76,7 +78,7 @@
  * @protocol: pointer to the corresponding pnp_protocol structure
  *
  */
-void pnp_protocol_unregister(struct pnp_protocol *protocol)
+void pnp_unregister_protocol(struct pnp_protocol *protocol)
 {
 	spin_lock(&pnp_lock);
 	list_del_init(&protocol->protocol_list);
@@ -84,17 +86,19 @@
 	device_unregister(&protocol->dev);
 }
 
-/**
- * pnp_init_device - pnp protocols should call this before adding a PnP device
- * @dev: pointer to dev to init
- *
- *  for now it only inits dev->ids, more later?
- */
 
-int pnp_init_device(struct pnp_dev *dev)
+static void pnp_free_ids(struct pnp_dev *dev)
 {
-	INIT_LIST_HEAD(&dev->ids);
-	return 0;
+	struct pnp_id * id;
+	struct pnp_id * next;
+	if (!dev)
+		return;
+	id = dev->id;
+	while (id) {
+		next = id->next;
+		kfree(id);
+		id = next;
+	}
 }
 
 static void pnp_release_device(struct device *dmdev)
@@ -106,68 +110,73 @@
 	kfree(dev);
 }
 
-/**
- * pnp_add_device - adds a pnp device to the pnp layer
- * @dev: pointer to dev to add
- *
- *  adds to driver model, name database, fixups, interface, etc.
- */
-
-int pnp_add_device(struct pnp_dev *dev)
+int __pnp_add_device(struct pnp_dev *dev)
 {
 	int error = 0;
-	if (!dev || !dev->protocol)
-		return -EINVAL;
-	if (dev->card)
-		sprintf(dev->dev.bus_id, "%02x:%02x.%02x", dev->protocol->number,
-		  dev->card->number,dev->number);
-	else
-		sprintf(dev->dev.bus_id, "%02x:%02x", dev->protocol->number,
-		  dev->number);
 	pnp_name_device(dev);
 	pnp_fixup_device(dev);
 	strcpy(dev->dev.name,dev->name);
-	dev->dev.parent = &dev->protocol->dev;
 	dev->dev.bus = &pnp_bus_type;
 	dev->dev.release = &pnp_release_device;
 	error = device_register(&dev->dev);
 	if (error == 0){
 		spin_lock(&pnp_lock);
 		list_add_tail(&dev->global_list, &pnp_global);
-		list_add_tail(&dev->dev_list, &dev->protocol->devices);
+		list_add_tail(&dev->protocol_list, &dev->protocol->devices);
 		spin_unlock(&pnp_lock);
 		pnp_interface_attach_device(dev);
 	}
 	return error;
 }
 
+/*
+ * pnp_add_device - adds a pnp device to the pnp layer
+ * @dev: pointer to dev to add
+ *
+ *  adds to driver model, name database, fixups, interface, etc.
+ */
+
+int pnp_add_device(struct pnp_dev *dev)
+{
+	if (!dev || !dev->protocol || dev->card)
+		return -EINVAL;
+	dev->dev.parent = &dev->protocol->dev;
+	sprintf(dev->dev.bus_id, "%02x:%02x", dev->protocol->number, dev->number);
+	return __pnp_add_device(dev);
+}
+
+void __pnp_remove_device(struct pnp_dev *dev)
+{
+	spin_lock(&pnp_lock);
+	list_del_init(&dev->global_list);
+	list_del_init(&dev->protocol_list);
+	spin_unlock(&pnp_lock);
+	device_unregister(&dev->dev);
+}
+
 /**
  * pnp_remove_device - removes a pnp device from the pnp layer
  * @dev: pointer to dev to add
  *
  * this function will free all mem used by dev
  */
+
 void pnp_remove_device(struct pnp_dev *dev)
 {
-	if (!dev)
+	if (!dev || dev->card)
 		return;
-	device_unregister(&dev->dev);
-	spin_lock(&pnp_lock);
-	list_del_init(&dev->global_list);
-	list_del_init(&dev->dev_list);
-	spin_unlock(&pnp_lock);
+	__pnp_remove_device(dev);
 }
 
 static int __init pnp_init(void)
 {
-	printk(KERN_INFO "Linux Plug and Play Support v0.9 (c) Adam Belay\n");
+	printk(KERN_INFO "Linux Plug and Play Support v0.93 (c) Adam Belay\n");
 	return bus_register(&pnp_bus_type);
 }
 
 subsys_initcall(pnp_init);
 
-EXPORT_SYMBOL(pnp_protocol_register);
-EXPORT_SYMBOL(pnp_protocol_unregister);
+EXPORT_SYMBOL(pnp_register_protocol);
+EXPORT_SYMBOL(pnp_unregister_protocol);
 EXPORT_SYMBOL(pnp_add_device);
 EXPORT_SYMBOL(pnp_remove_device);
-EXPORT_SYMBOL(pnp_init_device);
diff -Nru a/drivers/pnp/driver.c b/drivers/pnp/driver.c
--- a/drivers/pnp/driver.c	Fri Dec  6 10:38:41 2002
+++ b/drivers/pnp/driver.c	Fri Dec  6 10:38:41 2002
@@ -34,46 +34,30 @@
 	return 1;
 }
 
-int compare_pnp_id(struct list_head *id_list, const char *id)
+int compare_pnp_id(struct pnp_id *pos, const char *id)
 {
-	struct list_head *pos;
-	if (!id_list || !id || (strlen(id) != 7))
+	if (!pos || !id || (strlen(id) != 7))
 		return 0;
 	if (memcmp(id,"ANYDEVS",7)==0)
 		return 1;
-	list_for_each(pos,id_list){
-		struct pnp_id *pnp_id = to_pnp_id(pos);
-		if (memcmp(pnp_id->id,id,3)==0)
-			if (compare_func(pnp_id->id,id)==1)
+	while (pos){
+		if (memcmp(pos->id,id,3)==0)
+			if (compare_func(pos->id,id)==1)
 				return 1;
+		pos = pos->next;
 	}
 	return 0;
 }
 
-static const struct pnp_id * match_card(struct pnp_driver *drv, struct pnp_card *card)
+static const struct pnp_device_id * match_device(struct pnp_driver *drv, struct pnp_dev *dev)
 {
-	const struct pnp_id *drv_card_id = drv->card_id_table;
-	if (!drv)
-		return NULL;
-	if (!card)
-		return NULL;
-	while (*drv_card_id->id){
-		if (compare_pnp_id(&card->ids,drv_card_id->id))
-			return drv_card_id;
-		drv_card_id++;
-	}
-	return NULL;
-}
-
-static const struct pnp_id * match_device(struct pnp_driver *drv, struct pnp_dev *dev)
-{
-	const struct pnp_id *drv_id = drv->id_table;
+	const struct pnp_device_id *drv_id = drv->id_table;
 	if (!drv)
 		return NULL;
 	if (!dev)
 		return NULL;
 	while (*drv_id->id){
-		if (compare_pnp_id(&dev->ids,drv_id->id))
+		if (compare_pnp_id(dev->id,drv_id->id))
 			return drv_id;
 		drv_id++;
 	}
@@ -85,32 +69,23 @@
 	int error = 0;
 	struct pnp_driver *pnp_drv;
 	struct pnp_dev *pnp_dev;
-	const struct pnp_id *card_id = NULL;
-	const struct pnp_id *dev_id = NULL;
+	const struct pnp_device_id *dev_id = NULL;
 	pnp_dev = to_pnp_dev(dev);
 	pnp_drv = to_pnp_driver(dev->driver);
+
 	pnp_dbg("pnp: match found with the PnP device '%s' and the driver '%s'", dev->bus_id,pnp_drv->name);
 
 	if (pnp_dev->active == 0)
 		if(pnp_activate_dev(pnp_dev)<0)
 			return -1;
 	if (pnp_drv->probe && pnp_dev->active) {
-		if (pnp_dev->card && pnp_drv->card_id_table){
-			card_id = match_card(pnp_drv, pnp_dev->card);
-			if (card_id != NULL)
-				dev_id = match_device(pnp_drv, pnp_dev);
-			if (dev_id != NULL)
-				error = pnp_drv->probe(pnp_dev, card_id, dev_id);
-		}
-		else{
-			dev_id = match_device(pnp_drv, pnp_dev);
-			if (dev_id != NULL)
-				error = pnp_drv->probe(pnp_dev, card_id, dev_id);
-		}
-		if (error >= 0){
-			pnp_dev->driver = pnp_drv;
-			error = 0;
-		}
+		dev_id = match_device(pnp_drv, pnp_dev);
+		if (dev_id != NULL)
+			error = pnp_drv->probe(pnp_dev, dev_id);
+	}
+	if (error >= 0){
+		pnp_dev->driver = pnp_drv;
+		error = 0;
 	}
 	return error;
 }
@@ -133,9 +108,6 @@
 {
 	struct pnp_dev * pnp_dev = to_pnp_dev(dev);
 	struct pnp_driver * pnp_drv = to_pnp_driver(drv);
-	if (pnp_dev->card && pnp_drv->card_id_table
-	    && match_card(pnp_drv, pnp_dev->card) == NULL)
-		return 0;
 	if (match_device(pnp_drv, pnp_dev) == NULL)
 		return 0;
 	return 1;
@@ -174,8 +146,8 @@
 
 void pnp_unregister_driver(struct pnp_driver *drv)
 {
-	pnp_dbg("the driver '%s' has been unregistered", drv->name);
 	driver_unregister(&drv->driver);
+	pnp_dbg("the driver '%s' has been unregistered", drv->name);
 }
 
 /**
@@ -187,23 +159,19 @@
 
 int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev)
 {
+	struct pnp_id *ptr;
 	if (!id)
 		return -EINVAL;
 	if (!dev)
 		return -EINVAL;
-	list_add_tail(&id->id_list,&dev->ids);
+	ptr = dev->id;
+	while (ptr && ptr->next)
+		ptr = ptr->next;
+	if (ptr)
+		ptr->next = id;
+	else
+		dev->id = id;
 	return 0;
-}
-
-void pnp_free_ids(struct pnp_dev *dev)
-{
-	struct list_head *pos;
-	if (!dev)
-		return;
-	list_for_each(pos,&dev->ids){
-		struct pnp_id *pnp_id = to_pnp_id(pos);
-		kfree(pnp_id);
-	}
 }
 
 EXPORT_SYMBOL(pnp_register_driver);
diff -Nru a/drivers/pnp/interface.c b/drivers/pnp/interface.c
--- a/drivers/pnp/interface.c	Fri Dec  6 10:38:41 2002
+++ b/drivers/pnp/interface.c	Fri Dec  6 10:38:41 2002
@@ -321,13 +321,13 @@
 static ssize_t pnp_show_current_ids(struct device *dmdev, char *buf, size_t count, loff_t off)
 {
 	char *str = buf;
-	struct list_head * pos;
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
+	struct pnp_id * pos = dev->id;
 	if (off)
 		return 0;
-	list_for_each(pos,&dev->ids) {
-		struct pnp_id * cur = to_pnp_id(pos);
-		str += sprintf(str,"%s\n", cur->id);
+	while (pos) {
+		str += sprintf(str,"%s\n", pos->id);
+		pos = pos->next;
 	}
 	return (str - buf);
 }
diff -Nru a/drivers/pnp/isapnp/Makefile b/drivers/pnp/isapnp/Makefile
--- a/drivers/pnp/isapnp/Makefile	Fri Dec  6 10:38:41 2002
+++ b/drivers/pnp/isapnp/Makefile	Fri Dec  6 10:38:41 2002
@@ -2,10 +2,10 @@
 # Makefile for the kernel ISAPNP driver.
 #
 
-export-objs := core.o compat.o
+export-objs := core.o
 
 isapnp-proc-$(CONFIG_PROC_FS) = proc.o
 
-obj-y := core.o compat.o $(isapnp-proc-y)
+obj-y := core.o $(isapnp-proc-y)
 
 include $(TOPDIR)/Rules.make
diff -Nru a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	Fri Dec  6 10:38:41 2002
+++ b/drivers/pnp/isapnp/core.c	Fri Dec  6 10:38:41 2002
@@ -449,13 +449,13 @@
 	dev = isapnp_alloc(sizeof(struct pnp_dev));
 	if (!dev)
 		return NULL;
-	pnp_init_device(dev);
 	dev->number = number;
 	isapnp_parse_id(dev, (tmp[1] << 8) | tmp[0], (tmp[3] << 8) | tmp[2]);
 	dev->regs = tmp[4];
 	dev->card = card;
 	if (size > 5)
 		dev->regs |= tmp[5] << 8;
+	dev->protocol = &isapnp_protocol;
 	return dev;
 }
 
@@ -640,7 +640,7 @@
 		return 1;
 	if (pnp_build_resource(dev, 0) == NULL)
 		return 1;
-	list_add_tail(&dev->card_list, &card->devices);
+	pnpc_add_device(card,dev);
 	while (1) {
 		if (isapnp_read_tag(&type, &size)<0)
 			return 1;
@@ -653,7 +653,7 @@
 				if ((dev = isapnp_parse_device(card, size, number++)) == NULL)
 					return 1;
 				pnp_build_resource(dev,0);
-				list_add_tail(&dev->card_list, &card->devices);
+				pnpc_add_device(card,dev);
 				size = 0;
 				skip = 0;
 			} else {
@@ -848,7 +848,7 @@
 			device & 0x0f,
 			(device >> 12) & 0x0f,
 			(device >> 8) & 0x0f);
-	list_add_tail(&id->id_list,&card->ids);
+	pnpc_add_id(id,card);
 }
 
 /*
@@ -879,12 +879,11 @@
 			;
 		else if (checksum == 0x00 || checksum != header[8])	/* not valid CSN */
 			continue;
-		if ((card = isapnp_alloc(sizeof(struct pci_bus))) == NULL)
+		if ((card = isapnp_alloc(sizeof(struct pnp_card))) == NULL)
 			continue;
 
 		card->number = csn;
 		INIT_LIST_HEAD(&card->devices);
-		INIT_LIST_HEAD(&card->ids);
 		isapnp_parse_card_id(card, (header[1] << 8) | header[0], (header[3] << 8) | header[2]);
 		card->serial = (header[7] << 24) | (header[6] << 16) | (header[5] << 8) | header[4];
 		isapnp_checksum_value = 0x00;
@@ -892,8 +891,8 @@
 		if (isapnp_checksum_value != 0x00)
 			printk(KERN_ERR "isapnp: checksum for device %i is not valid (0x%x)\n", csn, isapnp_checksum_value);
 		card->checksum = isapnp_checksum_value;
-
-		list_add_tail(&card->node, &isapnp_cards);
+		card->protocol = &isapnp_protocol;
+		pnpc_add_card(card);
 	}
 	return 0;
 }
@@ -1061,25 +1060,6 @@
 	.disable = isapnp_disable_resources,
 };
 
-static inline int isapnp_init_device_tree(void)
-{
-
-	struct pnp_card *card;
-
-	isapnp_for_each_card(card) {
-		struct list_head *devlist;
-		for (devlist = card->devices.next; devlist != &card->devices; devlist = devlist->next) {
-			struct pnp_dev *dev = card_to_pnp_dev(devlist);
-			snprintf(dev->dev.name, sizeof(dev->dev.name), "%s", dev->name);
-			dev->card = card;
-			dev->protocol = &isapnp_protocol;
-			pnp_add_device(dev);
-		}
-	}
-
-	return 0;
-}
-
 int __init isapnp_init(void)
 {
 	int cards;
@@ -1104,7 +1084,7 @@
 		return -EBUSY;
 	}
 
-	if(pnp_protocol_register(&isapnp_protocol)<0)
+	if(pnp_register_protocol(&isapnp_protocol)<0)
 		return -EBUSY;
 
 	/*
@@ -1143,7 +1123,7 @@
 	isapnp_build_device_list();
 	cards = 0;
 
-	isapnp_for_each_card(card) {
+	protocol_for_each_card(&isapnp_protocol,card) {
 		cards++;
 		if (isapnp_verbose) {
 			struct list_head *devlist;
@@ -1162,7 +1142,6 @@
 		printk(KERN_INFO "isapnp: No Plug & Play card found\n");
 	}
 
-	isapnp_init_device_tree();
 	isapnp_proc_init();
 	return 0;
 }
diff -Nru a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
--- a/drivers/pnp/isapnp/proc.c	Fri Dec  6 10:38:41 2002
+++ b/drivers/pnp/isapnp/proc.c	Fri Dec  6 10:38:41 2002
@@ -146,7 +146,7 @@
 {
 	struct pnp_dev *dev;
 	isapnp_proc_bus_dir = proc_mkdir("isapnp", proc_bus);
-	isapnp_for_each_dev(dev) {
+	protocol_for_each_dev(&isapnp_protocol,dev) {
 		isapnp_proc_attach_device(dev);
 	}
 	return 0;
diff -Nru a/drivers/pnp/names.c b/drivers/pnp/names.c
--- a/drivers/pnp/names.c	Fri Dec  6 10:38:41 2002
+++ b/drivers/pnp/names.c	Fri Dec  6 10:38:41 2002
@@ -32,7 +32,7 @@
 	int i;
 	char *name = dev->name;
 	for(i=0; i<sizeof(pnp_id_eisaid)/sizeof(pnp_id_eisaid[0]); i++){
-		if (compare_pnp_id(&dev->ids,pnp_id_eisaid[i])){
+		if (compare_pnp_id(dev->id,pnp_id_eisaid[i])){
 			sprintf(name, "%s", pnp_id_names[i]);
 			return;
 		}
diff -Nru a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	Fri Dec  6 10:38:41 2002
+++ b/drivers/pnp/pnpbios/core.c	Fri Dec  6 10:38:41 2002
@@ -1256,6 +1256,12 @@
 	struct pnp_dev_node_info node_info;
 	u8 nodenum = dev->number;
 	struct pnp_bios_node * node;
+		
+	/* just in case */
+	if(dev->driver)
+		return -EBUSY;
+	if(!pnp_is_dynamic(dev))
+		return -EPERM;
 	if (pnp_bios_dev_node_info(&node_info) != 0)
 		return -ENODEV;
 	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
@@ -1273,10 +1279,15 @@
 	struct pnp_dev_node_info node_info;
 	u8 nodenum = dev->number;
 	struct pnp_bios_node * node;
-	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 
+	/* just in case */
+	if(dev->driver)
+		return -EBUSY;
+	if (flags == PNP_DYNAMIC && !pnp_is_dynamic(dev))
+		return -EPERM;
 	if (pnp_bios_dev_node_info(&node_info) != 0)
 		return -ENODEV;
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -1;
 	if (pnp_bios_get_dev_node(&nodenum, (char )1, node))
@@ -1323,16 +1334,21 @@
 	struct pnp_bios_node * node;
 	if (!config)
 		return -1;
+	/* just in case */
+	if(dev->driver)
+		return -EBUSY;
+	if(dev->flags & PNP_NO_DISABLE || !pnp_is_dynamic(dev))
+		return -EPERM;
 	memset(config, 0, sizeof(struct pnp_cfg));
 	if (!dev || !dev->active)
 		return -EINVAL;
-	for (i=0; i <= 8; i++)
+	for (i=0; i < 8; i++)
 		config->port[i] = &port;
-	for (i=0; i <= 4; i++)
+	for (i=0; i < 4; i++)
 		config->mem[i] = &mem;
-	for (i=0; i <= 2; i++)
+	for (i=0; i < 2; i++)
 		config->irq[i] = &irq;
-	for (i=0; i <= 2; i++)
+	for (i=0; i < 2; i++)
 		config->dma[i] = &dma;
 	dev->active = 0;
 
@@ -1369,7 +1385,7 @@
 	struct list_head * pos;
 	struct pnp_dev * pnp_dev;
 	list_for_each (pos, &pnpbios_protocol.devices){
-		pnp_dev = list_entry(pos, struct pnp_dev, dev_list);
+		pnp_dev = list_entry(pos, struct pnp_dev, protocol_list);
 		if (dev->number == pnp_dev->number)
 			return -1;
 	}
@@ -1402,10 +1418,13 @@
 	for(nodenum=0; nodenum<0xff; ) {
 		u8 thisnodenum = nodenum;
 		/* We build the list from the "boot" config because
-		 * asking for the "current" config causes some
-		 * BIOSes to crash.
+		 * we know that the resources couldn't have changed
+		 * at this stage.  Furthermore some buggy PnP BIOSes
+		 * will crash if we request the "current" config
+		 * from devices that are can only be static such as
+		 * those controlled by the "system" driver.
 		 */
-		if (pnp_bios_get_dev_node(&nodenum, (char )0 , node))
+		if (pnp_bios_get_dev_node(&nodenum, (char )1, node))
 			break;
 		nodes_got++;
 		dev =  pnpbios_kmalloc(sizeof (struct pnp_dev), GFP_KERNEL);
@@ -1416,7 +1435,6 @@
 		if (!dev_id)
 			break;
 		memset(dev_id,0,sizeof(struct pnp_id));
-		pnp_init_device(dev);
 		dev->number = thisnodenum;
 		memcpy(dev->name,"Unknown Device",13);
 		dev->name[14] = '\0';
@@ -1426,6 +1444,7 @@
 		pos = node_current_resource_data_to_dev(node,dev);
 		pos = node_possible_resource_data_to_dev(pos,node,dev);
 		node_id_data_to_dev(pos,node,dev);
+		dev->flags = node->flags;
 
 		dev->protocol = &pnpbios_protocol;
 
@@ -1450,10 +1469,7 @@
  *
  */
 
-extern int is_sony_vaio_laptop;
-
 static int pnpbios_disabled; /* = 0 */
-static int dont_reserve_resources; /* = 0 */
 int pnpbios_dont_use_current_config; /* = 0 */
 
 #ifndef MODULE
@@ -1471,8 +1487,6 @@
 			str += 3;
 		if (strncmp(str, "curr", 4) == 0)
 			pnpbios_dont_use_current_config = invert;
-		if (strncmp(str, "res", 3) == 0)
-			dont_reserve_resources = invert;
 		str = strchr(str, ',');
 		if (str != NULL)
 			str += strspn(str, ", \t");
@@ -1499,9 +1513,6 @@
 		return -ENODEV;
 	}
 
-	if ( is_sony_vaio_laptop )
-		pnpbios_dont_use_current_config = 1;
-
 	/*
  	 * Search the defined area (0xf0000-0xffff0) for a valid PnP BIOS
 	 * structure and, if one is found, sets up the selectors and
@@ -1544,7 +1555,7 @@
 	}
 	if (!pnp_bios_present())
 		return -ENODEV;
-	pnp_protocol_register(&pnpbios_protocol);
+	pnp_register_protocol(&pnpbios_protocol);
 	build_devlist();
 	/*if ( ! dont_reserve_resources )*/
 		/*reserve_resources();*/
diff -Nru a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
--- a/drivers/pnp/quirks.c	Fri Dec  6 10:38:41 2002
+++ b/drivers/pnp/quirks.c	Fri Dec  6 10:38:41 2002
@@ -157,7 +157,7 @@
 	int i = 0;
 
 	while (*pnp_fixups[i].id) {
-		if (compare_pnp_id(&dev->ids,pnp_fixups[i].id)) {
+		if (compare_pnp_id(dev->id,pnp_fixups[i].id)) {
 			pnp_dbg("Calling quirk for %s",
 		                  dev->dev.bus_id);
 			pnp_fixups[i].quirk_function(dev);
diff -Nru a/drivers/pnp/system.c b/drivers/pnp/system.c
--- a/drivers/pnp/system.c	Fri Dec  6 10:38:41 2002
+++ b/drivers/pnp/system.c	Fri Dec  6 10:38:41 2002
@@ -13,12 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 
-static const struct pnp_id pnp_card_table[] = {
-	{	"ANYDEVS",		0	},
-	{	"",			0	}
-};
-
-static const struct pnp_id pnp_dev_table[] = {
+static const struct pnp_device_id pnp_dev_table[] = {
 	/* General ID for reserving resources */
 	{	"PNP0c02",		0	},
 	/* memory controller */
@@ -101,7 +96,7 @@
 	return;
 }
 
-static int system_pnp_probe(struct pnp_dev * dev, const struct pnp_id *card_id, const struct pnp_id *dev_id)
+static int system_pnp_probe(struct pnp_dev * dev, const struct pnp_device_id *dev_id)
 {
 	reserve_resources_of_dev(dev);
 	return 0;
@@ -109,7 +104,6 @@
 
 static struct pnp_driver system_pnp_driver = {
 	.name		= "system",
-	.card_id_table	= pnp_card_table,
 	.id_table	= pnp_dev_table,
 	.probe		= system_pnp_probe,
 	.remove		= NULL,
diff -Nru a/drivers/serial/8250_pnp.c b/drivers/serial/8250_pnp.c
--- a/drivers/serial/8250_pnp.c	Fri Dec  6 10:38:41 2002
+++ b/drivers/serial/8250_pnp.c	Fri Dec  6 10:38:41 2002
@@ -33,12 +33,7 @@
 #define UNKNOWN_DEV 0x3000
 
 
-static const struct pnp_id pnp_card_table[] = {
-	{	"ANYDEVS",		0	},
-	{	"",			0	}
-};
-
-static const struct pnp_id pnp_dev_table[] = {
+static const struct pnp_device_id pnp_dev_table[] = {
 	/* Archtek America Corp. */
 	/* Archtek SmartLink Modem 3334BT Plug & Play */
 	{	"AAC000F",		0	},
@@ -316,6 +311,8 @@
 	{	"",			0	}
 };
 
+MODULE_DEVICE_TABLE(pnp, pnp_dev_table);
+
 static void inline avoid_irq_share(struct pnp_dev *dev)
 {
 	unsigned int map = 0x1FF8;
@@ -384,7 +381,7 @@
 }
 
 static int
-serial_pnp_probe(struct pnp_dev * dev, const struct pnp_id *card_id, const struct pnp_id *dev_id)
+serial_pnp_probe(struct pnp_dev * dev, const struct pnp_device_id *dev_id)
 {
 	struct serial_struct serial_req;
 	int ret, line, flags = dev_id->driver_data;
@@ -393,10 +390,10 @@
 	if (flags & SPCI_FL_NO_SHIRQ)
 		avoid_irq_share(dev);
 	memset(&serial_req, 0, sizeof(serial_req));
-	serial_req.irq = dev->irq_resource[0].start;
-	serial_req.port = pci_resource_start(dev, 0);
+	serial_req.irq = pnp_irq(dev,0);
+	serial_req.port = pnp_port_start(dev, 0);
 	if (HIGH_BITS_OFFSET)
-		serial_req.port = dev->resource[0].start >> HIGH_BITS_OFFSET;
+		serial_req.port = pnp_port_start(dev, 0) >> HIGH_BITS_OFFSET;
 #ifdef SERIAL_DEBUG_PNP
 	printk("Setup PNP port: port %x, irq %d, type %d\n",
 	       serial_req.port, serial_req.irq, serial_req.io_type);
@@ -407,7 +404,7 @@
 	line = register_serial(&serial_req);
 
 	if (line >= 0)
-		dev->driver_data = (void *)(line + 1);
+		pnp_set_drvdata(dev, (void *)(line + 1));
 	return line >= 0 ? 0 : -ENODEV;
 
 }
@@ -419,7 +416,6 @@
 
 static struct pnp_driver serial_pnp_driver = {
 	.name		= "serial",
-	.card_id_table	= pnp_card_table,
 	.id_table	= pnp_dev_table,
 	.probe		= serial_pnp_probe,
 	.remove		= serial_pnp_remove,
@@ -442,5 +438,3 @@
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Generic 8250/16x50 PnP serial driver");
-/* FIXME */
-/*MODULE_DEVICE_TABLE(pnpbios, pnp_dev_table);*/
diff -Nru a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Fri Dec  6 10:38:41 2002
+++ b/include/linux/pnp.h	Fri Dec  6 10:38:41 2002
@@ -1,3 +1,9 @@
+/*
+ * Linux Plug and Play Support
+ * Copyright by Adam Belay <ambx1@neo.rr.com>
+ *
+ */
+
 #ifndef _LINUX_PNP_H
 #define _LINUX_PNP_H
 
@@ -7,108 +13,210 @@
 #include <linux/list.h>
 
 
-/* Device Managemnt */
+/*
+ * Device Managemnt
+ */
 
 #define DEVICE_COUNT_IRQ	2
 #define DEVICE_COUNT_DMA	2
 #define DEVICE_COUNT_RESOURCE	12
+#define MAX_DEVICES		8
 
 struct pnp_resource;
 struct pnp_protocol;
+struct pnp_id;
 
-struct pnp_card {			/* this is for ISAPNP */ 
-	struct list_head node;		/* node in list of cards */
+struct pnp_card {
 	char name[80];
 	unsigned char number;		/* card number */
-	struct list_head ids;		/* stores all supported dev ids */
+	struct list_head global_list;	/* node in global list of cards */
+	struct list_head protocol_list;	/* node in protocol's list of cards */
 	struct list_head devices;	/* devices attached to the card */
+	struct pnp_protocol * protocol;
+	struct pnp_id * id;		/* contains supported EISA IDs*/
+
 	unsigned char	pnpver;		/* Plug & Play version */
 	unsigned char	productver;	/* product version */
 	unsigned int	serial;		/* serial number */
 	unsigned char	checksum;	/* if zero - checksum passed */
+	void	      * protocol_data;	/* Used to store protocol specific data */
+
+	struct pnpc_driver * driver;	/* pointer to the driver bound to this device */
+	struct list_head rdevs;		/* a list of devices requested by the card driver */
 	struct proc_dir_entry *procdir;	/* directory entry in /proc/bus/isapnp */
+	struct	device	dev;		/* Driver Model device interface */
 };
 
-#define to_pnp_card(n) list_entry(n, struct pnp_card, node)
+#define global_to_pnp_card(n) list_entry(n, struct pnp_card, global_list)
+#define protocol_to_pnp_card(n) list_entry(n, struct pnp_card, protocol_list)
+#define to_pnp_card(n) list_entry(n, struct pnp_card, dev)
+#define pnp_for_each_card(card) \
+	for(dev = global_to_pnp_card(pnp_cards.next); \
+	dev != global_to_pnp_card(&cards); \
+	dev = global_to_pnp_card(card>global_list.next))
+
+static inline void *pnpc_get_drvdata (struct pnp_card *pcard)
+{
+	return dev_get_drvdata(&pcard->dev);
+}
+
+static inline void pnpc_set_drvdata (struct pnp_card *pcard, void *data)
+{
+	dev_set_drvdata(&pcard->dev, data);
+}
+
+static inline void *pnpc_get_protodata (struct pnp_card *pcard)
+{
+	return pcard->protocol_data;
+}
+
+static inline void pnpc_set_protodata (struct pnp_card *pcard, void *data)
+{
+	pcard->protocol_data = data;
+}
 
 struct pnp_dev {
 	char name[80];			/* device name */
 	int active;			/* status of the device */
 	int ro;				/* read only */
-	struct list_head dev_list;	/* node in list of device's protocol */
-	struct list_head global_list;
-	struct list_head card_list;
+	struct list_head global_list;	/* node in global list of devices */
+	struct list_head protocol_list;	/* node in list of device's protocol */
+	struct list_head card_list;	/* node in card's list of devices */
+	struct list_head rdev_list;	/* node in cards list of requested devices */
 	struct pnp_protocol * protocol;
-	struct pnp_card *card;
+	struct pnp_card * card;
+	struct pnp_id * id;		/* contains supported EISA IDs*/
 
+	void * protocol_data;		/* Used to store protocol specific data */
 	unsigned char number;		/* must be unique */
 	unsigned short	regs;		/* ISAPnP: supported registers */
-	struct list_head ids;		/* stores all supported dev ids */
+	
 	struct pnp_resources *res;	/* possible resource information */
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
 	struct resource dma_resource[DEVICE_COUNT_DMA];
 	struct resource irq_resource[DEVICE_COUNT_IRQ];
 
-	struct pnp_driver * driver;	/* which driver has allocated this device */
+	struct pnp_driver * driver;	/* pointer to the driver bound to this device */
 	struct	device	    dev;	/* Driver Model device interface */
-	void  		  * driver_data;/* data private to the driver */
-	void		  * protocol_data;
+	int		    flags;	/* used by protocols */
 	struct proc_dir_entry *procent;	/* device entry in /proc/bus/isapnp */
 };
 
 #define global_to_pnp_dev(n) list_entry(n, struct pnp_dev, global_list)
 #define card_to_pnp_dev(n) list_entry(n, struct pnp_dev, card_list)
-#define protocol_to_pnp_dev(n) list_entry(n, struct pnp_dev, dev_list)
+#define protocol_to_pnp_dev(n) list_entry(n, struct pnp_dev, protocol_list)
 #define	to_pnp_dev(n) container_of(n, struct pnp_dev, dev)
 #define pnp_for_each_dev(dev) \
 	for(dev = global_to_pnp_dev(pnp_global.next); \
 	dev != global_to_pnp_dev(&pnp_global); \
 	dev = global_to_pnp_dev(dev->global_list.next))
 
+static inline void *pnp_get_drvdata (struct pnp_dev *pdev)
+{
+	return dev_get_drvdata(&pdev->dev);
+}
+
+static inline void pnp_set_drvdata (struct pnp_dev *pdev, void *data)
+{
+	dev_set_drvdata(&pdev->dev, data);
+}
+
+static inline void *pnp_get_protodata (struct pnp_dev *pdev)
+{
+	return pdev->protocol_data;
+}
+
+static inline void pnp_set_protodata (struct pnp_dev *pdev, void *data)
+{
+	pdev->protocol_data = data;
+}
+
 struct pnp_fixup {
 	char id[7];
 	void (*quirk_function)(struct pnp_dev *dev);	/* fixup function */
 };
 
+
 /*
- * Linux Plug and Play Support
- * Copyright by Adam Belay <ambx1@neo.rr.com>
- *
+ * Driver Management
  */
 
-/* Driver Management */
-
 struct pnp_id {
 	char id[7];
+	struct pnp_id * next;
+};
+
+struct pnp_device_id {
+	char id[7];
 	unsigned long driver_data;	/* data private to the driver */
-	struct list_head id_list;	/* node in card's or device's list */
 };
 
-#define to_pnp_id(n) list_entry(n, struct pnp_id, id_list)
+struct pnp_card_id {
+	char id[7];
+	unsigned long driver_data;	/* data private to the driver */
+	struct {
+		char id[7];
+	} devs[MAX_DEVICES];		/* logical devices */
+};
 
 struct pnp_driver {
 	struct list_head node;
 	char *name;
-	const struct pnp_id *card_id_table;
-	const struct pnp_id *id_table;
-	int  (*probe)  (struct pnp_dev *dev, const struct pnp_id *card_id,
-		 	const struct pnp_id *dev_id);
+	const struct pnp_device_id *id_table;
+	int  (*probe)  (struct pnp_dev *dev, const struct pnp_device_id *dev_id);
 	void (*remove) (struct pnp_dev *dev);
-	struct device_driver	driver;
+	struct device_driver driver;
 };
 
 #define	to_pnp_driver(drv) container_of(drv,struct pnp_driver, driver)
 
+struct pnpc_driver {
+	struct list_head node;
+	char *name;
+	const struct pnp_card_id *id_table;
+	int  (*probe)  (struct pnp_card *card, const struct pnp_card_id *card_id);
+	void (*remove) (struct pnp_card *card);
+	struct device_driver driver;
+};
+
+#define	to_pnpc_driver(drv) container_of(drv,struct pnpc_driver, driver)
+
+
+/*
+ * Resource Management
+ */
+
+/* Use these instead of directly reading pnp_dev to get resource information */
+#define pnp_port_start(dev,bar)   ((dev)->resource[(bar)].start)
+#define pnp_port_end(dev,bar)     ((dev)->resource[(bar)].end)
+#define pnp_port_flags(dev,bar)   ((dev)->resource[(bar)].flags)
+#define pnp_port_len(dev,bar) \
+	((pnp_port_start((dev),(bar)) == 0 &&	\
+	  pnp_port_end((dev),(bar)) ==		\
+	  pnp_port_start((dev),(bar))) ? 0 :	\
+	  					\
+	 (pnp_port_end((dev),(bar)) -		\
+	  pnp_port_start((dev),(bar)) + 1))
+
+#define pnp_mem_start(dev,bar)   ((dev)->resource[(bar+8)].start)
+#define pnp_mem_end(dev,bar)     ((dev)->resource[(bar+8)].end)
+#define pnp_mem_flags(dev,bar)   ((dev)->resource[(bar+8)].flags)
+#define pnp_mem_len(dev,bar) \
+	((pnp_mem_start((dev),(bar)) == 0 &&	\
+	  pnp_mem_end((dev),(bar)) ==		\
+	  pnp_mem_start((dev),(bar))) ? 0 :	\
+	  					\
+	 (pnp_mem_end((dev),(bar)) -		\
+	  pnp_mem_start((dev),(bar)) + 1))
 
-/* Resource Management */
+#define pnp_irq(dev,bar)	 ((dev)->irq_resource[(bar)].start)
+#define pnp_irq_flags(dev,bar)	 ((dev)->irq_resource[(bar)].flags)
 
-#define DEV_IO(dev, index) (dev->resource[index].start)
-#define DEV_MEM(dev, index) (dev->resource[index+8].start)
-#define DEV_IRQ(dev, index) (dev->irq_resource[index].start)
-#define DEV_DMA(dev, index) (dev->dma_resource[index].start)
+#define pnp_dma(dev,bar)	 ((dev)->dma_resource[(bar)].start)
+#define pnp_dma_flags(dev,bar)	 ((dev)->dma_resource[(bar)].flags)
 
 #define PNP_PORT_FLAG_16BITADDR	(1<<0)
-#define PNP_PORT_FLAG_FIXED		(1<<1)
+#define PNP_PORT_FLAG_FIXED	(1<<1)
 
 struct pnp_port {
 	unsigned short min;		/* min base number */
@@ -182,7 +290,9 @@
 };
 
 
-/* Protocol Management */
+/* 
+ * Protocol Management
+ */
 
 struct pnp_protocol {
 	struct list_head	protocol_list;
@@ -196,18 +306,26 @@
 	/* used by pnp layer only (look but don't touch) */
 	unsigned char		number;		/* protocol number*/
 	struct device		dev;		/* link to driver model */
+	struct list_head	cards;
 	struct list_head	devices;
 };
 
 #define to_pnp_protocol(n) list_entry(n, struct pnp_protocol, protocol_list)
+#define protocol_for_each_card(protocol,card) \
+	for((card) = protocol_to_pnp_card((protocol)->cards.next); \
+	(card) != protocol_to_pnp_card(&(protocol)->cards); \
+	(card) = protocol_to_pnp_card((card)->protocol_list.next))
+#define protocol_for_each_dev(protocol,dev) \
+	for((dev) = protocol_to_pnp_dev((protocol)->devices.next); \
+	(dev) != protocol_to_pnp_dev(&(protocol)->devices); \
+	(dev) = protocol_to_pnp_dev((dev)->protocol_list.next))
 
 
 #if defined(CONFIG_PNP)
 
 /* core */
-int pnp_protocol_register(struct pnp_protocol *protocol);
-void pnp_protocol_unregister(struct pnp_protocol *protocol);
-int pnp_init_device(struct pnp_dev *dev);
+int pnp_register_protocol(struct pnp_protocol *protocol);
+void pnp_unregister_protocol(struct pnp_protocol *protocol);
 int pnp_add_device(struct pnp_dev *dev);
 void pnp_remove_device(struct pnp_dev *dev);
 extern struct list_head pnp_global;
@@ -226,7 +344,7 @@
 int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, int mode);
 
 /* driver */
-int compare_pnp_id(struct list_head * id_list, const char * id);
+int compare_pnp_id(struct pnp_id * pos, const char * id);
 int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev);
 int pnp_register_driver(struct pnp_driver *drv);
 void pnp_unregister_driver(struct pnp_driver *drv);
@@ -234,8 +352,8 @@
 #else
 
 /* just in case anyone decides to call these without PnP Support Enabled */
-static inline int pnp_protocol_register(struct pnp_protocol *protocol) { return -ENODEV; }
-static inline void pnp_protocol_unregister(struct pnp_protocol *protocol) { }
+static inline int pnp_register_protocol(struct pnp_protocol *protocol) { return -ENODEV; }
+static inline void pnp_unregister_protocol(struct pnp_protocol *protocol) { }
 static inline int pnp_init_device(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_add_device(struct pnp_dev *dev) { return -ENODEV; }
 static inline void pnp_remove_device(struct pnp_dev *dev) { }
@@ -250,14 +368,45 @@
 static inline int pnp_activate_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, int mode) { return -ENODEV; }
-static inline int compare_pnp_id(struct list_head * id_list, char * id) { return -ENODEV; }
+static inline int compare_pnp_id(struct list_head * id_list, const char * id) { return -ENODEV; }
 static inline int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_register_driver(struct pnp_driver *drv) { return -ENODEV; }
 static inline void pnp_unregister_driver(struct pnp_driver *drv) { ; }
 
 #endif /* CONFIG_PNP */
 
+
+#if defined(CONFIG_PNP_CARD)
+
+/* card */
+int pnpc_add_card(struct pnp_card *card);
+void pnpc_remove_card(struct pnp_card *card);
+int pnpc_add_device(struct pnp_card *card, struct pnp_dev *dev);
+void pnpc_remove_device(struct pnp_dev *dev);
+struct pnp_dev * pnp_request_card_device(struct pnp_card *card, const char *id, struct pnp_dev *from);
+void pnp_release_card_device(struct pnp_dev *dev);
+int pnpc_register_driver(struct pnpc_driver * drv);
+void pnpc_unregister_driver(struct pnpc_driver *drv);
+int pnpc_add_id(struct pnp_id *id, struct pnp_card *card);
+extern struct list_head pnp_cards;
+
+#else
+
+static inline int pnpc_add_card(struct pnp_card *card) { return -ENODEV; }
+static inline void pnpc_remove_card(struct pnp_card *card) { ; }
+static inline int pnpc_add_device(struct pnp_card *card, struct pnp_dev *dev) { return -ENODEV; }
+static inline void pnpc_remove_device(struct pnp_dev *dev) { ; }
+static inline struct pnp_dev * pnp_request_card_device(struct pnp_card *card, const char *id, struct pnp_dev *from) { return NULL; }
+static inline void pnp_release_card_device(struct pnp_dev *dev) { ; }
+static inline int pnpc_register_driver(struct pnpc_driver *drv) { return -ENODEV; }
+static inline void pnpc_unregister_driver(struct pnpc_driver *drv) { ; }
+static inline int pnpc_add_id(struct pnp_id *id, struct pnp_card *card) { return -ENODEV; }
+
+#endif /* CONFIG_PNP_CARD */
+
+
 #if defined(CONFIG_ISAPNP)
+
 /* compat */
 struct pnp_card *pnp_find_card(unsigned short vendor,
 				 unsigned short device,
diff -Nru a/include/linux/pnpbios.h b/include/linux/pnpbios.h
--- a/include/linux/pnpbios.h	Fri Dec  6 10:38:41 2002
+++ b/include/linux/pnpbios.h	Fri Dec  6 10:38:41 2002
@@ -75,6 +75,19 @@
 #define PNPMSG_POWER_OFF		0x41
 #define PNPMSG_PNP_OS_ACTIVE		0x42
 #define PNPMSG_PNP_OS_INACTIVE		0x43
+/*
+ * Plug and Play BIOS flags
+ */
+#define PNP_NO_DISABLE		0x0001
+#define PNP_NO_CONFIG		0x0002
+#define PNP_OUTPUT		0x0004
+#define PNP_INPUT		0x0008
+#define PNP_BOOTABLE		0x0010
+#define PNP_DOCK		0x0020
+#define PNP_REMOVABLE		0x0040
+#define pnp_is_static(x) (x->flags & 0x0100) == 0x0000
+#define pnp_is_dynamic(x) x->flags & 0x0080
+
 /* 0x8000 through 0xffff are OEM defined */
 
 #pragma pack(1)
diff -Nru a/include/linux/sunrpc/stats.h b/include/linux/sunrpc/stats.h
--- a/include/linux/sunrpc/stats.h	Fri Dec  6 10:38:41 2002
+++ b/include/linux/sunrpc/stats.h	Fri Dec  6 10:38:41 2002
@@ -61,16 +61,18 @@
 
 #else
 
+static inline struct proc_dir_entry *rpc_proc_register(struct rpc_stat *s) { return NULL; }
+static inline void rpc_proc_unregister(const char *p) {}
+static inline int rpc_proc_read(char *a, char **b, off_t c, int d, int *e, void *f) { return 0; }
+static inline void rpc_proc_zero(struct rpc_program *p) {}
+
+static inline struct proc_dir_entry *svc_proc_register(struct svc_stat *s) { return NULL; }
 static inline void svc_proc_unregister(const char *p) {}
-static inline struct proc_dir_entry*svc_proc_register(struct svc_stat *s)
-{
-	return NULL;
-}
+static inline int svc_proc_read(char *a, char **b, off_t c, int d, int *e, void *f) { return 0; }
+static inline void svc_proc_zero(struct svc_program *p) {}
+
+#define proc_net_rpc NULL
 
-static inline int svc_proc_read(char *a, char **b, off_t c, int d, int *e, void *f)
-{
-	return 0;
-}
 #endif
 
 #endif /* _LINUX_SUNRPC_STATS_H */
diff -Nru a/sound/isa/opl3sa2.c b/sound/isa/opl3sa2.c
--- a/sound/isa/opl3sa2.c	Fri Dec  6 10:38:41 2002
+++ b/sound/isa/opl3sa2.c	Fri Dec  6 10:38:41 2002
@@ -24,11 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
-#ifndef LINUX_ISAPNP_H
-#include <linux/isapnp.h>
-#define isapnp_card pci_bus
-#define isapnp_dev pci_dev
-#endif
+#include <linux/pnp.h>
 #include <sound/core.h>
 #include <sound/cs4231.h>
 #include <sound/mpu401.h>
@@ -51,7 +47,7 @@
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_ISAPNP; /* Enable this card */
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 static int isapnp[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};
 #endif
 static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* 0xf86,0x370,0x100 */
@@ -73,7 +69,7 @@
 MODULE_PARM(enable, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(enable, "Enable OPL3-SA soundcard.");
 MODULE_PARM_SYNTAX(enable, SNDRV_ENABLE_DESC);
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 MODULE_PARM(isapnp, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(isapnp, "ISA PnP detection for specified soundcard.");
 MODULE_PARM_SYNTAX(isapnp, SNDRV_ISAPNP_DESC);
@@ -147,8 +143,8 @@
 	snd_hwdep_t *synth;
 	snd_rawmidi_t *rmidi;
 	cs4231_t *cs4231;
-#ifdef __ISAPNP__
-	struct isapnp_dev *dev;
+#ifdef CONFIG_PNP
+	struct pnp_dev *dev;
 #endif
 	unsigned char ctlregs[0x20];
 	int ymode;		/* SL added */
@@ -163,33 +159,27 @@
 
 static snd_card_t *snd_opl3sa2_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
 
-#ifdef __ISAPNP__
-
-static struct isapnp_card *snd_opl3sa2_isapnp_cards[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PTR;
-static const struct isapnp_card_id *snd_opl3sa2_isapnp_id[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PTR;
+#ifdef CONFIG_PNP
 
-#define ISAPNP_OPL3SA2(_va, _vb, _vc, _device, _function) \
-        { \
-                ISAPNP_CARD_ID(_va, _vb, _vc, _device), \
-                devs : { ISAPNP_DEVICE_ID(_va, _vb, _vc, _function), } \
-        }
+static struct pnp_card *snd_opl3sa2_isapnp_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
+static const struct pnp_card_id *snd_opl3sa2_isapnp_id[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
 
-static struct isapnp_card_id snd_opl3sa2_pnpids[] __devinitdata = {
+static struct pnp_card_id snd_opl3sa2_pnpids[] = {
 	/* Yamaha YMF719E-S (Genius Sound Maker 3DX) */
-	ISAPNP_OPL3SA2('Y','M','H',0x0020,0x0021),
+	{.id = "YMH0020", .driver_data = 0, devs : { {.id="YMH0021"}, } },
 	/* Yamaha OPL3-SA3 (integrated on Intel's Pentium II AL440LX motherboard) */
-	ISAPNP_OPL3SA2('Y','M','H',0x0030,0x0021),
+	{.id = "YMH0030", .driver_data = 0, devs : { {.id="YMH0021"}, } },
 	/* Yamaha OPL3-SA2 */
-	ISAPNP_OPL3SA2('Y','M','H',0x0800,0x0021),
+	{.id = "YMH0800", .driver_data = 0, devs : { {.id="YMH0021"}, } },
 	/* NeoMagic MagicWave 3DX */
-	ISAPNP_OPL3SA2('N','M','X',0x2200,0x2210),
+	{.id = "NMX2200", .driver_data = 0, devs : { {.id="NMX2210"}, } },
 	/* --- */
-	{ ISAPNP_CARD_END, }	/* end */
+	{.id = "", } /* end */
 };
 
-ISAPNP_CARD_TABLE(snd_opl3sa2_pnpids);
+/*PNP_CARD_TABLE(snd_opl3sa2_pnpids);*/
 
-#endif /* __ISAPNP__ */
+#endif /* CONFIG_PNP */
 
 
 /* read control port (w/o spinlock) */
@@ -634,41 +624,18 @@
 
 #endif /* CONFIG_PM */
 
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 static int __init snd_opl3sa2_isapnp(int dev, opl3sa2_t *chip)
 {
-        const struct isapnp_card_id *id = snd_opl3sa2_isapnp_id[dev];
-        struct isapnp_card *card = snd_opl3sa2_isapnp_cards[dev];
-	struct isapnp_dev *pdev;
-
-	chip->dev = isapnp_find_dev(card, id->devs[0].vendor, id->devs[0].function, NULL);
-	if (chip->dev->active) {
-		chip->dev = NULL;
-		return -EBUSY;
-	}
-	/* PnP initialization */
+        const struct pnp_card_id *id = snd_opl3sa2_isapnp_id[dev];
+        struct pnp_card *card = snd_opl3sa2_isapnp_cards[dev];
+	struct pnp_dev *pdev;
+
+	chip->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
 	pdev = chip->dev;
-	if (pdev->prepare(pdev)<0)
-		return -EAGAIN;
-	if (sb_port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[0], sb_port[dev], 16);
-	if (wss_port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[1], wss_port[dev], 8);
-	if (fm_port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[2], fm_port[dev], 4);
-	if (midi_port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[3], midi_port[dev], 2);
-	if (port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[4], port[dev], 2);
-	if (dma1[dev] != SNDRV_AUTO_DMA)
-		isapnp_resource_change(&pdev->dma_resource[0], dma1[dev], 1);
-	if (dma2[dev] != SNDRV_AUTO_DMA)
-		isapnp_resource_change(&pdev->dma_resource[1], dma2[dev], 1);
-	if (irq[dev] != SNDRV_AUTO_IRQ)
-		isapnp_resource_change(&pdev->irq_resource[0], irq[dev], 1);
-	if (pdev->activate(pdev)<0) {
-		snd_printk("isapnp configure failure (out of resources?)\n");
-		return -EBUSY;
+	if (!pdev){
+		snd_printdd("isapnp OPL3-SA: a card was found but it did not contain the needed devices\n",);
+		return -ENODEV;
 	}
 	sb_port[dev] = pdev->resource[0].start;
 	wss_port[dev] = pdev->resource[1].start;
@@ -685,19 +652,12 @@
 	return 0;
 }
 
-static void snd_opl3sa2_deactivate(opl3sa2_t *chip)
-{
-	if (chip->dev) {
-		chip->dev->deactivate(chip->dev);
-		chip->dev = NULL;
-	}
-}
-#endif /* __ISAPNP__ */
+#endif /* CONFIG_PNP */
 
 static int snd_opl3sa2_free(opl3sa2_t *chip)
 {
-#ifdef __ISAPNP__
-	snd_opl3sa2_deactivate(chip);
+#ifdef CONFIG_PNP
+	chip->dev = NULL;
 #endif
 #ifdef CONFIG_PM
 	if (chip->pm_dev)
@@ -731,7 +691,7 @@
 	};
 	int err;
 
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	if (!isapnp[dev]) {
 #endif
 		if (port[dev] == SNDRV_AUTO_PORT) {
@@ -750,7 +710,7 @@
 			snd_printk("specify midi_port\n");
 			return -EINVAL;
 		}
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	}
 #endif
 	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
@@ -766,7 +726,7 @@
 	chip->irq = -1;
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0)
 		goto __error;
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	if (isapnp[dev] && (err = snd_opl3sa2_isapnp(dev, chip)) < 0)
 		goto __error;
 #endif
@@ -854,9 +814,9 @@
 	return err;
 }
 
-#ifdef __ISAPNP__
-static int __init snd_opl3sa2_isapnp_detect(struct isapnp_card *card,
-					    const struct isapnp_card_id *id)
+#ifdef CONFIG_PNP
+static int __init snd_opl3sa2_isapnp_detect(struct pnp_card *card,
+					    const struct pnp_card_id *id)
 {
         static int dev;
         int res;
@@ -874,7 +834,20 @@
         }
         return -ENODEV;
 }
-#endif /* __ISAPNP__ */
+
+static void snd_opl3sa2_isapnp_remove(struct pnp_card * card)
+{
+/* FIXME */
+}
+
+static struct pnpc_driver opl3sa2_pnpc_driver = {
+	.name		= "opl3sa2",
+	.id_table	= snd_opl3sa2_pnpids,
+	.probe		= snd_opl3sa2_isapnp_detect,
+	.remove		= snd_opl3sa2_isapnp_remove,
+};
+
+#endif /* CONFIG_PNP */
 
 static int __init alsa_card_opl3sa2_init(void)
 {
@@ -883,15 +856,15 @@
 	for (dev = 0; dev < SNDRV_CARDS; dev++) {
 		if (!enable[dev])
 			continue;
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 		if (isapnp[dev])
 			continue;
 #endif
 		if (snd_opl3sa2_probe(dev) >= 0)
 			cards++;
 	}
-#ifdef __ISAPNP__
-	cards += isapnp_probe_cards(snd_opl3sa2_pnpids, snd_opl3sa2_isapnp_detect);
+#ifdef CONFIG_PNP
+	cards += pnpc_register_driver(&opl3sa2_pnpc_driver);
 #endif
 	if (!cards) {
 #ifdef MODULE
@@ -940,7 +913,7 @@
 	       get_option(&str,&dma1[nr_dev]) == 2 &&
 	       get_option(&str,&dma2[nr_dev]) == 2 &&
 	       get_option(&str,&opl3sa3_ymode[nr_dev]) == 2);
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	if (pnp != INT_MAX)
 		isapnp[nr_dev] = pnp;
 #endif
diff -Nru a/sound/oss/opl3sa2.c b/sound/oss/opl3sa2.c
--- a/sound/oss/opl3sa2.c	Fri Dec  6 10:38:41 2002
+++ b/sound/oss/opl3sa2.c	Fri Dec  6 10:38:41 2002
@@ -841,10 +841,9 @@
 	{.id = ""}
 };
 
-/*MODULE_DEVICE_TABLE(isapnp, isapnp_opl3sa2_list);*/
+MODULE_DEVICE_TABLE(pnp, pnp_opl3sa2_list);
 
-static int opl3sa2_pnp_probe(struct pnp_dev *dev, const struct pnp_id *card_id,
-			     const struct pnp_id *dev_id)
+static int opl3sa2_pnp_probe(struct pnp_dev *dev, const struct pnp_id *dev_id)
 {
 	int card = opl3sa2_cards_num;
 	if (opl3sa2_cards_num == OPL3SA2_CARDS_MAX)
@@ -883,7 +882,6 @@
 
 static struct pnp_driver opl3sa2_driver = {
 	.name		= "opl3sa2",
-	.card_id_table	= NULL,
 	.id_table	= pnp_opl3sa2_list,
 	.probe		= opl3sa2_pnp_probe,
 };
