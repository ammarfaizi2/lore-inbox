Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266520AbSL2LZO>; Sun, 29 Dec 2002 06:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266528AbSL2LZO>; Sun, 29 Dec 2002 06:25:14 -0500
Received: from gate.perex.cz ([194.212.165.105]:15120 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S266520AbSL2LZF>;
	Sun, 29 Dec 2002 06:25:05 -0500
Date: Sun, 29 Dec 2002 12:33:03 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Adam Belay <ambx1@neo.rr.com>
cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: [PATCH] pnp & pci structure cleanups
Message-ID: <Pine.LNX.4.33.0212291228200.532-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	this is my second pnp cleanup. It removes ISA PnP variables from 
PCI structures, cleans isapnp.h header file and adds the compatibility 
routines. Also, i82365 pcmcia driver is updated to latest PnP API 
(in compatibility mode). This patch will cause that all unconverted 
ISA PnP code will fail to compile, but it's better than silent failure 
(like the current kernel tree does).

						Jaroslav

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.902, 2002-12-26 19:42:08+01:00, perex@suse.cz
  PnP update
    - removed ISAPnP members from PCI structures
    - isapnp.h cleanups (removal of duplicates)
    - added compatible functions (pnp_find_dev and pnp_find_card)
    - i82365 (pcmcia driver) - ported to new PnP layer


 drivers/pcmcia/i82365.c     |   26 +++-----
 drivers/pnp/isapnp/Makefile |    4 -
 drivers/pnp/isapnp/compat.c |   27 ++++----
 drivers/pnp/isapnp/core.c   |   54 ++++++++---------
 drivers/pnp/isapnp/proc.c   |    1 
 include/linux/isapnp.h      |  138 --------------------------------------------
 include/linux/pci.h         |   19 ------
 include/linux/pnp.h         |   12 ++-
 8 files changed, 66 insertions(+), 215 deletions(-)


diff -Nru a/drivers/pcmcia/i82365.c b/drivers/pcmcia/i82365.c
--- a/drivers/pcmcia/i82365.c	Thu Dec 26 19:45:48 2002
+++ b/drivers/pcmcia/i82365.c	Thu Dec 26 19:45:48 2002
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
--- a/drivers/pnp/isapnp/Makefile	Thu Dec 26 19:45:48 2002
+++ b/drivers/pnp/isapnp/Makefile	Thu Dec 26 19:45:48 2002
@@ -2,8 +2,8 @@
 # Makefile for the kernel ISAPNP driver.
 #
 
-export-objs := core.o
+export-objs := core.o compat.o
 
 isapnp-proc-$(CONFIG_PROC_FS) = proc.o
 
-obj-y := core.o $(isapnp-proc-y)
+obj-y := core.o compat.o $(isapnp-proc-y)
diff -Nru a/drivers/pnp/isapnp/compat.c b/drivers/pnp/isapnp/compat.c
--- a/drivers/pnp/isapnp/compat.c	Thu Dec 26 19:45:48 2002
+++ b/drivers/pnp/isapnp/compat.c	Thu Dec 26 19:45:48 2002
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
--- a/drivers/pnp/isapnp/core.c	Thu Dec 26 19:45:48 2002
+++ b/drivers/pnp/isapnp/core.c	Thu Dec 26 19:45:48 2002
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
--- a/drivers/pnp/isapnp/proc.c	Thu Dec 26 19:45:48 2002
+++ b/drivers/pnp/isapnp/proc.c	Thu Dec 26 19:45:48 2002
@@ -28,6 +28,7 @@
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 
+extern struct pnp_protocol isapnp_protocol;
 
 static struct proc_dir_entry *isapnp_proc_bus_dir = NULL;
 
diff -Nru a/include/linux/isapnp.h b/include/linux/isapnp.h
--- a/include/linux/isapnp.h	Thu Dec 26 19:45:48 2002
+++ b/include/linux/isapnp.h	Thu Dec 26 19:45:48 2002
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
--- a/include/linux/pci.h	Thu Dec 26 19:45:48 2002
+++ b/include/linux/pci.h	Thu Dec 26 19:45:48 2002
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
--- a/include/linux/pnp.h	Thu Dec 26 19:45:48 2002
+++ b/include/linux/pnp.h	Thu Dec 26 19:45:48 2002
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

===================================================================


This BitKeeper patch contains the following changesets:
1.902
## Wrapped with gzip_uu ##


begin 664 bkpatch896
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
?&_%\>_P/!-Z-]&[3R:BM#W0V<*BC_1]F440XHB``````
`
end

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

