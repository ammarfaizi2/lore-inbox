Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262747AbUKMDHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbUKMDHk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 22:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbUKMDGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 22:06:32 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4872 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262668AbUKMDCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 22:02:53 -0500
Date: Sat, 13 Nov 2004 04:02:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ambx1@neo.rr.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] some PNP cleanups
Message-ID: <20041113030220.GW2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following changes to the PNP code:
- remove some unused code
- make some needlessly global code static

Please review whether some of this might conflict with pending changes.


diffstat output:
 drivers/pnp/card.c         |   38 -------------------------------------
 drivers/pnp/core.c         |    2 -
 drivers/pnp/interface.c    |    2 -
 drivers/pnp/manager.c      |    3 --
 drivers/pnp/pnpbios/core.c |    7 ++----
 drivers/pnp/resource.c     |   10 ++++-----
 include/linux/pnp.h        |   13 ------------
 7 files changed, 11 insertions(+), 64 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/pnp/card.c.old	2004-11-13 03:19:40.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pnp/card.c	2004-11-13 03:20:14.000000000 +0100
@@ -216,27 +216,6 @@
 }
 
 /**
- * pnp_remove_card - removes a PnP card from the PnP Layer
- * @card: pointer to the card to remove
- */
-
-void pnp_remove_card(struct pnp_card * card)
-{
-	struct list_head *pos, *temp;
-	if (!card)
-		return;
-	device_unregister(&card->dev);
-	spin_lock(&pnp_lock);
-	list_del(&card->global_list);
-	list_del(&card->protocol_list);
-	spin_unlock(&pnp_lock);
-	list_for_each_safe(pos,temp,&card->devices){
-		struct pnp_dev *dev = card_to_pnp_dev(pos);
-		pnp_remove_card_device(dev);
-	}
-}
-
-/**
  * pnp_add_card_device - adds a device to the specified card
  * @card: pointer to the card to add to
  * @dev: pointer to the device to add
@@ -258,21 +237,6 @@
 }
 
 /**
- * pnp_remove_card_device- removes a device from the specified card
- * @card: pointer to the card to remove from
- * @dev: pointer to the device to remove
- */
-
-void pnp_remove_card_device(struct pnp_dev * dev)
-{
-	spin_lock(&pnp_lock);
-	dev->card = NULL;
-	list_del(&dev->card_list);
-	spin_unlock(&pnp_lock);
-	__pnp_remove_device(dev);
-}
-
-/**
  * pnp_request_card_device - Searches for a PnP device under the specified card
  * @lcard: pointer to the card link, cannot be NULL
  * @id: pointer to a PnP ID structure that explains the rules for finding the device
@@ -381,9 +345,7 @@
 }
 
 EXPORT_SYMBOL(pnp_add_card);
-EXPORT_SYMBOL(pnp_remove_card);
 EXPORT_SYMBOL(pnp_add_card_device);
-EXPORT_SYMBOL(pnp_remove_card_device);
 EXPORT_SYMBOL(pnp_add_card_id);
 EXPORT_SYMBOL(pnp_request_card_device);
 EXPORT_SYMBOL(pnp_release_card_device);
--- linux-2.6.10-rc1-mm5-full/include/linux/pnp.h.old	2004-11-13 03:19:21.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/include/linux/pnp.h	2004-11-13 03:25:58.000000000 +0100
@@ -260,13 +260,6 @@
 #define pnp_device_is_isapnp(dev) 0
 #endif
 
-#ifdef CONFIG_PNPBIOS
-extern struct pnp_protocol pnpbios_protocol;
-#define pnp_device_is_pnpbios(dev) ((dev)->protocol == (&pnpbios_protocol))
-#else
-#define pnp_device_is_pnpbios(dev) 0
-#endif
-
 
 /* status */
 #define PNP_READY		0x0000
@@ -360,9 +353,7 @@
 
 /* multidevice card support */
 int pnp_add_card(struct pnp_card *card);
-void pnp_remove_card(struct pnp_card *card);
 int pnp_add_card_device(struct pnp_card *card, struct pnp_dev *dev);
-void pnp_remove_card_device(struct pnp_dev *dev);
 int pnp_add_card_id(struct pnp_id *id, struct pnp_card *card);
 struct pnp_dev * pnp_request_card_device(struct pnp_card_link *clink, const char * id, struct pnp_dev * from);
 void pnp_release_card_device(struct pnp_dev * dev);
@@ -378,7 +369,6 @@
 int pnp_register_port_resource(struct pnp_option *option, struct pnp_port *data);
 int pnp_register_mem_resource(struct pnp_option *option, struct pnp_mem *data);
 void pnp_init_resource_table(struct pnp_resource_table *table);
-int pnp_assign_resources(struct pnp_dev *dev, int depnum);
 int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode);
 int pnp_auto_config_dev(struct pnp_dev *dev);
 int pnp_validate_config(struct pnp_dev *dev);
@@ -406,9 +396,7 @@
 
 /* multidevice card support */
 static inline int pnp_add_card(struct pnp_card *card) { return -ENODEV; }
-static inline void pnp_remove_card(struct pnp_card *card) { ; }
 static inline int pnp_add_card_device(struct pnp_card *card, struct pnp_dev *dev) { return -ENODEV; }
-static inline void pnp_remove_card_device(struct pnp_dev *dev) { ; }
 static inline int pnp_add_card_id(struct pnp_id *id, struct pnp_card *card) { return -ENODEV; }
 static inline struct pnp_dev * pnp_request_card_device(struct pnp_card_link *clink, const char * id, struct pnp_dev * from) { return NULL; }
 static inline void pnp_release_card_device(struct pnp_dev * dev) { ; }
@@ -423,7 +411,6 @@
 static inline int pnp_register_port_resource(struct pnp_option *option, struct pnp_port *data) { return -ENODEV; }
 static inline int pnp_register_mem_resource(struct pnp_option *option, struct pnp_mem *data) { return -ENODEV; }
 static inline void pnp_init_resource_table(struct pnp_resource_table *table) { }
-static inline int pnp_assign_resources(struct pnp_dev *dev, int depnum) { return -ENODEV; }
 static inline int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode) { return -ENODEV; }
 static inline int pnp_auto_config_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_validate_config(struct pnp_dev *dev) { return -ENODEV; }
--- linux-2.6.10-rc1-mm5-full/drivers/pnp/core.c.old	2004-11-13 03:20:42.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pnp/core.c	2004-11-13 03:20:53.000000000 +0100
@@ -18,7 +18,7 @@
 #include "base.h"
 
 
-LIST_HEAD(pnp_protocols);
+static LIST_HEAD(pnp_protocols);
 LIST_HEAD(pnp_global);
 spinlock_t pnp_lock = SPIN_LOCK_UNLOCKED;
 
--- linux-2.6.10-rc1-mm5-full/drivers/pnp/interface.c.old	2004-11-13 03:22:00.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pnp/interface.c	2004-11-13 03:22:12.000000000 +0100
@@ -29,7 +29,7 @@
 
 typedef struct pnp_info_buffer pnp_info_buffer_t;
 
-int pnp_printf(pnp_info_buffer_t * buffer, char *fmt,...)
+static int pnp_printf(pnp_info_buffer_t * buffer, char *fmt,...)
 {
 	va_list args;
 	int res;
--- linux-2.6.10-rc1-mm5-full/drivers/pnp/manager.c.old	2004-11-13 03:23:11.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pnp/manager.c	2004-11-13 03:23:27.000000000 +0100
@@ -296,7 +296,7 @@
  *
  * Only set depnum to 0 if the device does not have dependent options.
  */
-int pnp_assign_resources(struct pnp_dev *dev, int depnum)
+static int pnp_assign_resources(struct pnp_dev *dev, int depnum)
 {
 	struct pnp_port *port;
 	struct pnp_mem *mem;
@@ -558,7 +558,6 @@
 }
 
 
-EXPORT_SYMBOL(pnp_assign_resources);
 EXPORT_SYMBOL(pnp_manual_config_dev);
 EXPORT_SYMBOL(pnp_auto_config_dev);
 EXPORT_SYMBOL(pnp_activate_dev);
--- linux-2.6.10-rc1-mm5-full/drivers/pnp/pnpbios/core.c.old	2004-11-13 03:24:47.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pnp/pnpbios/core.c	2004-11-13 03:26:24.000000000 +0100
@@ -319,7 +319,7 @@
 
 /* PnP Layer support */
 
-struct pnp_protocol pnpbios_protocol = {
+static struct pnp_protocol pnpbios_protocol = {
 	.name	= "Plug and Play BIOS",
 	.get	= pnpbios_get_resources,
 	.set	= pnpbios_set_resources,
@@ -453,7 +453,7 @@
 /* PnP BIOS signature: "$PnP" */
 #define PNP_SIGNATURE   (('$' << 0) + ('P' << 8) + ('n' << 16) + ('P' << 24))
 
-int __init pnpbios_probe_system(void)
+static int __init pnpbios_probe_system(void)
 {
 	union pnp_bios_install_struct *check;
 	u8 sum;
@@ -529,7 +529,7 @@
 	{ }
 };
 
-int __init pnpbios_init(void)
+static int __init pnpbios_init(void)
 {
 	int ret;
 
@@ -636,4 +636,3 @@
 
 #endif
 
-EXPORT_SYMBOL(pnpbios_protocol);
--- linux-2.6.10-rc1-mm5-full/drivers/pnp/resource.c.old	2004-11-13 03:27:15.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pnp/resource.c	2004-11-13 03:28:03.000000000 +0100
@@ -21,11 +21,11 @@
 #include <linux/pnp.h>
 #include "base.h"
 
-int pnp_skip_pci_scan;				/* skip PCI resource scanning */
-int pnp_reserve_irq[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some IRQ */
-int pnp_reserve_dma[8] = { [0 ... 7] = -1 };	/* reserve (don't use) some DMA */
-int pnp_reserve_io[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some I/O region */
-int pnp_reserve_mem[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some memory region */
+static int pnp_skip_pci_scan;				/* skip PCI resource scanning */
+static int pnp_reserve_irq[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some IRQ */
+static int pnp_reserve_dma[8] = { [0 ... 7] = -1 };	/* reserve (don't use) some DMA */
+static int pnp_reserve_io[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some I/O region */
+static int pnp_reserve_mem[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some memory region */
 
 
 /*

