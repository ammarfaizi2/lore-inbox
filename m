Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265987AbSL3WRR>; Mon, 30 Dec 2002 17:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265947AbSL3WRR>; Mon, 30 Dec 2002 17:17:17 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:52495 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266010AbSL3WQz>;
	Mon, 30 Dec 2002 17:16:55 -0500
Date: Mon, 30 Dec 2002 14:20:21 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP changes for 2.5.53
Message-ID: <20021230222021.GC814@kroah.com>
References: <20021230221836.GA814@kroah.com> <20021230221946.GB814@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021230221946.GB814@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.865.47.2, 2002/12/26 19:42:08+01:00, perex@suse.cz

PnP update
  - removed ISAPnP members from PCI structures
  - isapnp.h cleanups (removal of duplicates)
  - added compatible functions (pnp_find_dev and pnp_find_card)
  - i82365 (pcmcia driver) - ported to new PnP layer


diff -Nru a/drivers/pcmcia/i82365.c b/drivers/pcmcia/i82365.c
--- a/drivers/pcmcia/i82365.c	Mon Dec 30 14:20:56 2002
+++ b/drivers/pcmcia/i82365.c	Mon Dec 30 14:20:56 2002
@@ -814,7 +814,7 @@
 
 #ifdef CONFIG_ISA
 
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 static struct isapnp_device_id id_table[] __initdata = {
 	{ 	ISAPNP_ANY_ID, ISAPNP_ANY_ID, ISAPNP_VENDOR('P', 'N', 'P'),
 		ISAPNP_FUNCTION(0x0e00), (unsigned long) "Intel 82365-Compatible" },
@@ -826,32 +826,28 @@
 };
 MODULE_DEVICE_TABLE(isapnp, id_table);
 
-static struct pci_dev *i82365_pnpdev;
+static struct pnp_dev *i82365_pnpdev;
 #endif
 
 static void __init isa_probe(void)
 {
     int i, j, sock, k, ns, id;
     ioaddr_t port;
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
     struct isapnp_device_id *devid;
-    struct pci_dev *dev;
+    struct pnp_dev *dev;
 
     for (devid = id_table; devid->vendor; devid++) {
-	if ((dev = isapnp_find_dev(NULL, devid->vendor, devid->function, NULL))) {
-	    printk("ISAPNP ");
+	if ((dev = pnp_find_dev(NULL, devid->vendor, devid->function, NULL))) {
+	    printk("PNP ");
 
-	    if (dev->prepare && dev->prepare(dev) < 0) {
-		printk("prepare failed\n");
-		break;
-	    }
-
-	    if (dev->activate && dev->activate(dev) < 0) {
+	    if (pnp_activate_dev(dev, NULL) < 0) {
 		printk("activate failed\n");
 		break;
 	    }
 
-	    if ((i365_base = pci_resource_start(dev, 0))) {
+	    i365_base = pnp_port_start(dev, 0);
+	    if (i365_base) {
 		printk("no resources ?\n");
 		break;
 	    }
@@ -1644,8 +1640,8 @@
 	release_region(socket[i].ioaddr, 2);
     }
 #if defined(CONFIG_ISA) && defined(__ISAPNP__)
-    if (i82365_pnpdev && i82365_pnpdev->deactivate)
-		i82365_pnpdev->deactivate(i82365_pnpdev);
+    if (i82365_pnpdev)
+    		pnp_disable_dev(i82365_pnpdev);
 #endif
 } /* exit_i82365 */
 
diff -Nru a/drivers/pnp/isapnp/Makefile b/drivers/pnp/isapnp/Makefile
--- a/drivers/pnp/isapnp/Makefile	Mon Dec 30 14:20:56 2002
+++ b/drivers/pnp/isapnp/Makefile	Mon Dec 30 14:20:56 2002
@@ -2,8 +2,8 @@
 # Makefile for the kernel ISAPNP driver.
 #
 
-export-objs := core.o
+export-objs := core.o compat.o
 
 isapnp-proc-$(CONFIG_PROC_FS) = proc.o
 
-obj-y := core.o $(isapnp-proc-y)
+obj-y := core.o compat.o $(isapnp-proc-y)
diff -Nru a/drivers/pnp/isapnp/compat.c b/drivers/pnp/isapnp/compat.c
--- a/drivers/pnp/isapnp/compat.c	Mon Dec 30 14:20:56 2002
+++ b/drivers/pnp/isapnp/compat.c	Mon Dec 30 14:20:56 2002
@@ -26,21 +26,20 @@
 }
 
 struct pnp_card *pnp_find_card(unsigned short vendor,
-				 unsigned short device,
-				 struct pnp_card *from)
+			       unsigned short device,
+			       struct pnp_card *from)
 {
 	char id[7];
 	char any[7];
 	struct list_head *list;
 	pnp_convert_id(id, vendor, device);
 	pnp_convert_id(any, ISAPNP_ANY_ID, ISAPNP_ANY_ID);
-	list = isapnp_cards.next;
-	if (from)
-		list = from->node.next;
-
-	while (list != &isapnp_cards) {
-		struct pnp_card *card = to_pnp_card(list);
-		if (compare_pnp_id(&card->ids,id) || (memcmp(id,any,7)==0))
+
+	list = from ? from->global_list.next : pnp_cards.next;
+
+	while (list != &pnp_cards) {
+		struct pnp_card *card = global_to_pnp_card(list);
+		if (compare_pnp_id(card->id,id) || (memcmp(id,any,7)==0))
 			return card;
 		list = list->next;
 	}
@@ -48,9 +47,9 @@
 }
 
 struct pnp_dev *pnp_find_dev(struct pnp_card *card,
-				unsigned short vendor,
-				unsigned short function,
-				struct pnp_dev *from)
+			     unsigned short vendor,
+			     unsigned short function,
+			     struct pnp_dev *from)
 {
 	char id[7];
 	char any[7];
@@ -65,7 +64,7 @@
 
 		while (list != &pnp_global) {
 			struct pnp_dev *dev = global_to_pnp_dev(list);
-			if (compare_pnp_id(&dev->ids,id) || (memcmp(id,any,7)==0))
+			if (compare_pnp_id(dev->id,id) || (memcmp(id,any,7)==0))
 				return dev;
 			list = list->next;
 		}
@@ -80,7 +79,7 @@
 		}
 		while (list != &card->devices) {
 			struct pnp_dev *dev = card_to_pnp_dev(list);
-			if (compare_pnp_id(&dev->ids,id))
+			if (compare_pnp_id(dev->id,id))
 				return dev;
 			list = list->next;
 		}
diff -Nru a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	Mon Dec 30 14:20:56 2002
+++ b/drivers/pnp/isapnp/core.c	Mon Dec 30 14:20:56 2002
@@ -42,12 +42,8 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/isapnp.h>
-#include <linux/pnp.h>
 #include <asm/io.h>
 
-LIST_HEAD(isapnp_cards);
-LIST_HEAD(isapnp_devices);
-
 #if 0
 #define ISAPNP_REGION_OK
 #endif
@@ -106,6 +102,8 @@
 /* some prototypes */
 
 static int isapnp_config_prepare(struct pnp_dev *dev);
+extern struct pnp_protocol isapnp_card_protocol;
+extern struct pnp_protocol isapnp_protocol;
 
 static inline void write_data(unsigned char x)
 {
@@ -521,7 +519,7 @@
 	port->max = (tmp[4] << 8) | tmp[3];
 	port->align = tmp[5];
 	port->size = tmp[6];
-	port->flags = tmp[0] ? ISAPNP_PORT_FLAG_16BITADDR : 0;
+	port->flags = tmp[0] ? PNP_PORT_FLAG_16BITADDR : 0;
 	pnp_add_port_resource(dev,depnum,port);
 	return;
 }
@@ -543,7 +541,7 @@
 	port->min = port->max = (tmp[1] << 8) | tmp[0];
 	port->size = tmp[2];
 	port->align = 0;
-	port->flags = ISAPNP_PORT_FLAG_FIXED;
+	port->flags = PNP_PORT_FLAG_FIXED;
 	pnp_add_port_resource(dev,depnum,port);
 	return;
 }
@@ -686,7 +684,7 @@
 		case _STAG_STARTDEP:
 			if (size > 1)
 				goto __skip;
-			dependent = 0x100 | ISAPNP_RES_PRIORITY_ACCEPTABLE;
+			dependent = 0x100 | PNP_RES_PRIORITY_ACCEPTABLE;
 			if (size > 0) {
 				isapnp_peek(tmp, size);
 				dependent = 0x100 | tmp[0];
@@ -891,7 +889,7 @@
 		if (isapnp_checksum_value != 0x00)
 			printk(KERN_ERR "isapnp: checksum for device %i is not valid (0x%x)\n", csn, isapnp_checksum_value);
 		card->checksum = isapnp_checksum_value;
-		card->protocol = &isapnp_protocol;
+		card->protocol = &isapnp_card_protocol;
 		pnpc_add_card(card);
 	}
 	return 0;
@@ -903,7 +901,12 @@
 
 int isapnp_present(void)
 {
-	return !list_empty(&isapnp_devices);
+	struct pnp_card *card;
+	pnp_for_each_card(card) {
+		if (card->protocol == &isapnp_card_protocol)
+			return 1;
+	}
+	return 0;
 }
 
 int isapnp_cfg_begin(int csn, int logdev)
@@ -970,24 +973,11 @@
 	return 0;
 }
 
-void isapnp_resource_change(struct resource *resource,
-			    unsigned long start,
-			    unsigned long size)
-{
-	if (resource == NULL)
-		return;
-	resource->flags &= ~IORESOURCE_AUTO;
-	resource->start = start;
-	resource->end = start + size - 1;
-}
-
 /*
  *  Inititialization.
  */
 
 
-EXPORT_SYMBOL(isapnp_cards);
-EXPORT_SYMBOL(isapnp_devices);
 EXPORT_SYMBOL(isapnp_present);
 EXPORT_SYMBOL(isapnp_cfg_begin);
 EXPORT_SYMBOL(isapnp_cfg_end);
@@ -999,7 +989,6 @@
 EXPORT_SYMBOL(isapnp_write_dword);
 EXPORT_SYMBOL(isapnp_wake);
 EXPORT_SYMBOL(isapnp_device);
-EXPORT_SYMBOL(isapnp_resource_change);
 
 static int isapnp_get_resources(struct pnp_dev *dev)
 {
@@ -1053,8 +1042,15 @@
 	return 0;
 }
 
+struct pnp_protocol isapnp_card_protocol = {
+	.name	= "ISA Plug and Play - card",
+	.get	= NULL,
+	.set	= NULL,
+	.disable = NULL,
+};
+
 struct pnp_protocol isapnp_protocol = {
-	.name	= "ISA Plug and Play",
+	.name	= "ISA Plug and Play - device",
 	.get	= isapnp_get_resources,
 	.set	= isapnp_set_resources,
 	.disable = isapnp_disable_resources,
@@ -1064,6 +1060,7 @@
 {
 	int cards;
 	struct pnp_card *card;
+	struct pnp_dev *dev;
 
 	if (isapnp_disable) {
 		isapnp_detected = 0;
@@ -1084,6 +1081,9 @@
 		return -EBUSY;
 	}
 
+	if(pnp_register_protocol(&isapnp_card_protocol)<0)
+		return -EBUSY;
+
 	if(pnp_register_protocol(&isapnp_protocol)<0)
 		return -EBUSY;
 
@@ -1126,13 +1126,11 @@
 	protocol_for_each_card(&isapnp_protocol,card) {
 		cards++;
 		if (isapnp_verbose) {
-			struct list_head *devlist;
 			printk(KERN_INFO "isapnp: Card '%s'\n", card->name[0]?card->name:"Unknown");
 			if (isapnp_verbose < 2)
 				continue;
-			for (devlist = card->devices.next; devlist != &card->devices; devlist = devlist->next) {
-				struct pci_dev *dev = pci_dev_b(devlist);
-				printk(KERN_INFO "isapnp:   Device '%s'\n", dev->dev.name[0]?card->name:"Unknown");
+			pnp_card_for_each_dev(card,dev) {
+				printk(KERN_INFO "isapnp:   Device '%s'\n", dev->name[0]?dev->name:"Unknown");
 			}
 		}
 	}
diff -Nru a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
--- a/drivers/pnp/isapnp/proc.c	Mon Dec 30 14:20:56 2002
+++ b/drivers/pnp/isapnp/proc.c	Mon Dec 30 14:20:56 2002
@@ -28,6 +28,7 @@
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 
+extern struct pnp_protocol isapnp_protocol;
 
 static struct proc_dir_entry *isapnp_proc_bus_dir = NULL;
 
diff -Nru a/include/linux/isapnp.h b/include/linux/isapnp.h
--- a/include/linux/isapnp.h	Mon Dec 30 14:20:56 2002
+++ b/include/linux/isapnp.h	Mon Dec 30 14:20:56 2002
@@ -24,6 +24,7 @@
 
 #include <linux/config.h>
 #include <linux/errno.h>
+#include <linux/pnp.h>
 
 /*
  *  Configuration registers (TODO: change by specification)
@@ -54,79 +55,7 @@
 
 #ifdef __KERNEL__
 
-#include <linux/pci.h>
-
-#define ISAPNP_PORT_FLAG_16BITADDR	(1<<0)
-#define ISAPNP_PORT_FLAG_FIXED		(1<<1)
-
-struct isapnp_port {
-	unsigned short min;		/* min base number */
-	unsigned short max;		/* max base number */
-	unsigned char align;		/* align boundary */
-	unsigned char size;		/* size of range */
-	unsigned char flags;		/* port flags */
-	unsigned char pad;		/* pad */
-	struct isapnp_resources *res;	/* parent */
-	struct isapnp_port *next;	/* next port */
-};
-
-struct isapnp_irq {
-	unsigned short map;		/* bitmaks for IRQ lines */
-	unsigned char flags;		/* IRQ flags */
-	unsigned char pad;		/* pad */
-	struct isapnp_resources *res;	/* parent */
-	struct isapnp_irq *next;	/* next IRQ */
-};
-
-struct isapnp_dma {
-	unsigned char map;		/* bitmask for DMA channels */
-	unsigned char flags;		/* DMA flags */
-	struct isapnp_resources *res;	/* parent */
-	struct isapnp_dma *next;	/* next port */
-};
-
-struct isapnp_mem {
-	unsigned int min;		/* min base number */
-	unsigned int max;		/* max base number */
-	unsigned int align;		/* align boundary */
-	unsigned int size;		/* size of range */
-	unsigned char flags;		/* memory flags */
-	unsigned char pad;		/* pad */
-	struct isapnp_resources *res;	/* parent */
-	struct isapnp_mem *next;	/* next memory resource */
-};
-
-struct isapnp_mem32 {
-	/* TODO */
-	unsigned char data[17];
-	struct isapnp_resources *res;	/* parent */
-	struct isapnp_mem32 *next;	/* next 32-bit memory resource */
-};
-
-struct isapnp_fixup {
-	unsigned short vendor;		/* matching vendor */
-	unsigned short device;		/* matching device */
-	void (*quirk_function)(struct pci_dev *dev);	/* fixup function */
-};
-
-
-#define ISAPNP_RES_PRIORITY_PREFERRED	0
-#define ISAPNP_RES_PRIORITY_ACCEPTABLE	1
-#define ISAPNP_RES_PRIORITY_FUNCTIONAL	2
-#define ISAPNP_RES_PRIORITY_INVALID	65535
-
-struct isapnp_resources {
-	unsigned short priority;	/* priority */
-	unsigned short dependent;	/* dependent resources */
-	struct isapnp_port *port;	/* first port */
-	struct isapnp_irq *irq;		/* first IRQ */
-	struct isapnp_dma *dma;		/* first DMA */
-	struct isapnp_mem *mem;		/* first memory resource */
-	struct isapnp_mem32 *mem32;	/* first 32-bit memory */
-	struct pci_dev *dev;		/* parent */
-	struct isapnp_resources *alt;	/* alternative resource (aka dependent resources) */
-	struct isapnp_resources *next;	/* next resource */
-};
+#define DEVICE_COUNT_COMPATIBLE 4
 
 #define ISAPNP_ANY_ID		0xffff
 #define ISAPNP_CARD_DEVS	8
@@ -162,14 +91,6 @@
 	unsigned long driver_data;	/* data private to the driver */
 };
 
-struct isapnp_driver {
-	struct list_head node;
-	char *name;
-	const struct isapnp_device_id *id_table;	/* NULL if wants all devices */
-	int  (*probe)  (struct pci_dev *dev, const struct isapnp_device_id *id);	/* New device inserted */
-	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
-};
-
 #if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 
 #define __ISAPNP__
@@ -188,7 +109,6 @@
 void isapnp_device(unsigned char device);
 void isapnp_activate(unsigned char device);
 void isapnp_deactivate(unsigned char device);
-void isapnp_fixup_device(struct pci_dev *dev);
 void *isapnp_alloc(long size);
 
 #ifdef CONFIG_PROC_FS
@@ -199,40 +119,8 @@
 static inline isapnp_proc_done(void) { return 0; }
 #endif
 
-/* misc */
-void isapnp_resource_change(struct resource *resource,
-			    unsigned long start,
-			    unsigned long size);
 /* init/main.c */
 int isapnp_init(void);
-/* manager */
-static inline struct pci_bus *isapnp_find_card(unsigned short vendor,
-					       unsigned short device,
-					       struct pci_bus *from) { return NULL; }
-static inline struct pci_dev *isapnp_find_dev(struct pci_bus *card,
-					      unsigned short vendor,
-					      unsigned short function,
-					      struct pci_dev *from) { return NULL; }
-static inline int isapnp_probe_cards(const struct isapnp_card_id *ids,
-				     int (*probe)(struct pci_bus *card,
-						  const struct isapnp_card_id *id)) { return -ENODEV; }
-static inline int isapnp_probe_devs(const struct isapnp_device_id *ids,
-				    int (*probe)(struct pci_dev *dev,
-						 const struct isapnp_device_id *id)) { return -ENODEV; }
-static inline int isapnp_activate_dev(struct pci_dev *dev, const char *name) { return -ENODEV; }
-
-static inline int isapnp_register_driver(struct isapnp_driver *drv) { return 0; }
-
-static inline void isapnp_unregister_driver(struct isapnp_driver *drv) { }
-
-extern struct list_head isapnp_cards;
-extern struct list_head isapnp_devices;
-extern struct pnp_protocol isapnp_protocol;
-
-#define isapnp_for_each_card(card) \
-	for(card = to_pnp_card(isapnp_cards.next); card != to_pnp_card(&isapnp_cards); card = to_pnp_card(card->node.next))
-#define isapnp_for_each_dev(dev) \
-	for(dev = protocol_to_pnp_dev(isapnp_protocol.devices.next); dev != protocol_to_pnp_dev(&isapnp_protocol.devices); dev = protocol_to_pnp_dev(dev->dev_list.next))
 
 #else /* !CONFIG_ISAPNP */
 
@@ -250,28 +138,6 @@
 static inline void isapnp_device(unsigned char device) { ; }
 static inline void isapnp_activate(unsigned char device) { ; }
 static inline void isapnp_deactivate(unsigned char device) { ; }
-/* manager */
-static inline struct pci_bus *isapnp_find_card(unsigned short vendor,
-					       unsigned short device,
-					       struct pci_bus *from) { return NULL; }
-static inline struct pci_dev *isapnp_find_dev(struct pci_bus *card,
-					      unsigned short vendor,
-					      unsigned short function,
-					      struct pci_dev *from) { return NULL; }
-static inline int isapnp_probe_cards(const struct isapnp_card_id *ids,
-				     int (*probe)(struct pci_bus *card,
-						  const struct isapnp_card_id *id)) { return -ENODEV; }
-static inline int isapnp_probe_devs(const struct isapnp_device_id *ids,
-				    int (*probe)(struct pci_dev *dev,
-						 const struct isapnp_device_id *id)) { return -ENODEV; }
-static inline void isapnp_resource_change(struct resource *resource,
-					  unsigned long start,
-					  unsigned long size) { ; }
-static inline int isapnp_activate_dev(struct pci_dev *dev, const char *name) { return -ENODEV; }
-
-static inline int isapnp_register_driver(struct isapnp_driver *drv) { return 0; }
-
-static inline void isapnp_unregister_driver(struct isapnp_driver *drv) { }
 
 #endif /* CONFIG_ISAPNP */
 
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Mon Dec 30 14:20:56 2002
+++ b/include/linux/pci.h	Mon Dec 30 14:20:56 2002
@@ -362,7 +362,7 @@
 #define PCI_ANY_ID (~0)
 
 /*
- * The pci_dev structure is used to describe both PCI and ISAPnP devices.
+ * The pci_dev structure is used to describe PCI devices.
  */
 struct pci_dev {
 	struct list_head global_list;	/* node in list of all PCI devices */
@@ -410,16 +410,9 @@
 	struct resource irq_resource[DEVICE_COUNT_IRQ];
 
 	char		slot_name[8];	/* slot name */
-	int		active;		/* ISAPnP: device is active */
-	int		ro;		/* ISAPnP: read only */
-	unsigned short	regs;		/* ISAPnP: supported registers */
 
 	/* These fields are used by common fixups */
-	unsigned short	transparent:1;	/* Transparent PCI bridge */
-
-	int (*prepare)(struct pci_dev *dev);	/* ISAPnP hooks */
-	int (*activate)(struct pci_dev *dev);
-	int (*deactivate)(struct pci_dev *dev);
+	unsigned int	transparent:1;	/* Transparent PCI bridge */
 };
 
 #define pci_dev_g(n) list_entry(n, struct pci_dev, global_list)
@@ -463,13 +456,7 @@
 	unsigned char	subordinate;	/* max number of subordinate buses */
 
 	char		name[48];
-	unsigned short	vendor;
-	unsigned short	device;
-	unsigned int	serial;		/* serial number */
-	unsigned char	pnpver;		/* Plug & Play version */
-	unsigned char	productver;	/* product version */
-	unsigned char	checksum;	/* if zero - checksum passed */
-	unsigned char	pad1;
+
 	struct	device	* dev;
 };
 
diff -Nru a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Mon Dec 30 14:20:56 2002
+++ b/include/linux/pnp.h	Mon Dec 30 14:20:56 2002
@@ -51,11 +51,15 @@
 
 #define global_to_pnp_card(n) list_entry(n, struct pnp_card, global_list)
 #define protocol_to_pnp_card(n) list_entry(n, struct pnp_card, protocol_list)
-#define to_pnp_card(n) list_entry(n, struct pnp_card, dev)
+#define to_pnp_card(n) container_of(n, struct pnp_card, dev)
 #define pnp_for_each_card(card) \
-	for(dev = global_to_pnp_card(pnp_cards.next); \
-	dev != global_to_pnp_card(&cards); \
-	dev = global_to_pnp_card(card>global_list.next))
+	for((card) = global_to_pnp_card(pnp_cards.next); \
+	(card) != global_to_pnp_card(&pnp_cards); \
+	(card) = global_to_pnp_card((card)->global_list.next))
+#define pnp_card_for_each_dev(card,dev) \
+	for((dev) = card_to_pnp_dev((card)->devices.next); \
+	(dev) != card_to_pnp_dev(&(card)->devices); \
+	(dev) = card_to_pnp_dev((dev)->card_list.next))
 
 static inline void *pnpc_get_drvdata (struct pnp_card *pcard)
 {
