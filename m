Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267340AbTBIQyf>; Sun, 9 Feb 2003 11:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267333AbTBIQye>; Sun, 9 Feb 2003 11:54:34 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:38028 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267340AbTBIQxQ>;
	Sun, 9 Feb 2003 11:53:16 -0500
Date: Sun, 9 Feb 2003 12:02:49 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] pnp - preparations and cleanups (1/12) 2.5.59-bk3
Message-ID: <20030209120249.GA13840@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains several small changes primarly to get in the right position 
for the remaing patches in the series.  It includes pnp.h and makefile changes.

Please apply,
Adam


diff -urN a/drivers/pnp/Makefile b/drivers/pnp/Makefile
--- a/drivers/pnp/Makefile	Sun Feb  9 10:18:34 2003
+++ b/drivers/pnp/Makefile	Sun Feb  9 10:19:47 2003
@@ -4,8 +4,7 @@
 
 pnp-card-$(CONFIG_PNP_CARD) = card.o
 
-obj-y		:= core.o driver.o resource.o interface.o quirks.o names.o system.o $(pnp-card-y)
+obj-y		:= core.o driver.o resource.o manager.o support.o interface.o quirks.o names.o system.o $(pnp-card-y)
 
 obj-$(CONFIG_PNPBIOS)		+= pnpbios/
 obj-$(CONFIG_ISAPNP)		+= isapnp/
-
diff -urN a/drivers/pnp/base.h b/drivers/pnp/base.h
--- a/drivers/pnp/base.h	Tue Jan 14 05:58:15 2003
+++ b/drivers/pnp/base.h	Sat Feb  8 15:31:29 2003
@@ -1,9 +1,32 @@
 extern struct bus_type pnp_bus_type;
 extern spinlock_t pnp_lock;
-extern void *pnp_alloc(long size);
-extern int pnp_interface_attach_device(struct pnp_dev *dev);
-extern void pnp_name_device(struct pnp_dev *dev);
-extern void pnp_fixup_device(struct pnp_dev *dev);
-extern void pnp_free_resources(struct pnp_resources *resources);
-extern int __pnp_add_device(struct pnp_dev *dev);
-extern void __pnp_remove_device(struct pnp_dev *dev);
+void *pnp_alloc(long size);
+int pnp_interface_attach_device(struct pnp_dev *dev);
+void pnp_name_device(struct pnp_dev *dev);
+void pnp_fixup_device(struct pnp_dev *dev);
+void pnp_free_resources(struct pnp_resources *resources);
+int __pnp_add_device(struct pnp_dev *dev);
+void __pnp_remove_device(struct pnp_dev *dev);
+
+/* resource conflict types */
+#define CONFLICT_TYPE_NONE	0x0000	/* there are no conflicts, other than those in the link */
+#define CONFLICT_TYPE_RESERVED	0x0001	/* the resource requested was reserved */
+#define CONFLICT_TYPE_IN_USE	0x0002	/* there is a conflict because the resource is in use */
+#define CONFLICT_TYPE_PCI	0x0004	/* there is a conflict with a pci device */
+#define CONFLICT_TYPE_INVALID	0x0008	/* the resource requested is invalid */
+#define CONFLICT_TYPE_INTERNAL	0x0010	/* resources within the device conflict with each ohter */
+#define CONFLICT_TYPE_PNP_WARM	0x0020	/* there is a conflict with a pnp device that is active */
+#define CONFLICT_TYPE_PNP_COLD	0x0040	/* there is a conflict with a pnp device that is disabled */
+
+/* conflict search modes */
+#define SEARCH_WARM 1	/* check for conflicts with active devices */
+#define SEARCH_COLD 0	/* check for conflicts with disabled devices */
+
+struct pnp_dev * pnp_check_port_conflicts(struct pnp_dev * dev, int idx, int mode);
+int pnp_check_port(struct pnp_dev * dev, int idx);
+struct pnp_dev * pnp_check_mem_conflicts(struct pnp_dev * dev, int idx, int mode);
+int pnp_check_mem(struct pnp_dev * dev, int idx);
+struct pnp_dev * pnp_check_irq_conflicts(struct pnp_dev * dev, int idx, int mode);
+int pnp_check_irq(struct pnp_dev * dev, int idx);
+struct pnp_dev * pnp_check_dma_conflicts(struct pnp_dev * dev, int idx, int mode);
+int pnp_check_dma(struct pnp_dev * dev, int idx);
diff -urN a/drivers/pnp/card.c b/drivers/pnp/card.c
--- a/drivers/pnp/card.c	Tue Jan 14 05:59:18 2003
+++ b/drivers/pnp/card.c	Sat Feb  1 16:52:08 2003
@@ -22,9 +22,9 @@
 
 LIST_HEAD(pnp_cards);
 
-static const struct pnp_card_device_id * match_card(struct pnpc_driver *drv, struct pnp_card *card)
+static const struct pnp_card_id * match_card(struct pnpc_driver *drv, struct pnp_card *card)
 {
-	const struct pnp_card_device_id *drv_id = drv->id_table;
+	const struct pnp_card_id *drv_id = drv->id_table;
 	while (*drv_id->id){
 		if (compare_pnp_id(card->id,drv_id->id))
 			return drv_id;
@@ -106,7 +106,6 @@
 		return -EINVAL;
 	sprintf(card->dev.bus_id, "%02x:%02x", card->protocol->number, card->number);
 	INIT_LIST_HEAD(&card->rdevs);
-	strcpy(card->dev.name,card->name);
 	card->dev.parent = &card->protocol->dev;
 	card->dev.bus = &pnpc_bus_type;
 	card->dev.release = &pnp_release_card;
@@ -221,7 +220,7 @@
 	cdrv = to_pnpc_driver(card->dev.driver);
 	if (dev->active == 0) {
 		if (!(cdrv->flags & PNPC_DRIVER_DO_NOT_ACTIVATE)) {
-			if(pnp_activate_dev(dev,NULL)<0) {
+			if(pnp_activate_dev(dev)<0) {
 				pnp_device_detach(dev);
 				return NULL;
 			}
@@ -286,7 +285,7 @@
 	int error = 0;
 	struct pnpc_driver *drv = to_pnpc_driver(dev->driver);
 	struct pnp_card *card = to_pnp_card(dev);
-	const struct pnp_card_device_id *card_id = NULL;
+	const struct pnp_card_id *card_id = NULL;
 
 	pnp_dbg("pnp: match found with the PnP card '%s' and the driver '%s'", dev->bus_id,drv->name);
 
diff -urN a/drivers/pnp/core.c b/drivers/pnp/core.c
--- a/drivers/pnp/core.c	Tue Jan 14 05:58:23 2003
+++ b/drivers/pnp/core.c	Mon Feb  3 18:06:33 2003
@@ -104,31 +104,29 @@
 static void pnp_release_device(struct device *dmdev)
 {
 	struct pnp_dev * dev = to_pnp_dev(dmdev);
-	if (dev->res)
-		pnp_free_resources(dev->res);
+	if (dev->possible)
+		pnp_free_resources(dev->possible);
 	pnp_free_ids(dev);
 	kfree(dev);
 }
 
 int __pnp_add_device(struct pnp_dev *dev)
 {
-	int error = 0;
+	int ret;
 	pnp_name_device(dev);
 	pnp_fixup_device(dev);
-	strncpy(dev->dev.name,dev->name,DEVICE_NAME_SIZE-1);
-	dev->dev.name[DEVICE_NAME_SIZE-1] = '\0';
 	dev->dev.bus = &pnp_bus_type;
 	dev->dev.release = &pnp_release_device;
 	dev->status = PNP_READY;
-	error = device_register(&dev->dev);
-	if (error == 0){
-		spin_lock(&pnp_lock);
-		list_add_tail(&dev->global_list, &pnp_global);
-		list_add_tail(&dev->protocol_list, &dev->protocol->devices);
-		spin_unlock(&pnp_lock);
+	spin_lock(&pnp_lock);
+	list_add_tail(&dev->global_list, &pnp_global);
+	list_add_tail(&dev->protocol_list, &dev->protocol->devices);
+	spin_unlock(&pnp_lock);
+	pnp_auto_config_dev(dev);
+	ret = device_register(&dev->dev);
+	if (ret == 0)
 		pnp_interface_attach_device(dev);
-	}
-	return error;
+	return ret;
 }
 
 /*
@@ -172,7 +170,7 @@
 
 static int __init pnp_init(void)
 {
-	printk(KERN_INFO "Linux Plug and Play Support v0.94 (c) Adam Belay\n");
+	printk(KERN_INFO "Linux Plug and Play Support v0.95 (c) Adam Belay\n");
 	return bus_register(&pnp_bus_type);
 }
 
diff -urN a/drivers/pnp/driver.c b/drivers/pnp/driver.c
--- a/drivers/pnp/driver.c	Tue Jan 14 05:59:08 2003
+++ b/drivers/pnp/driver.c	Sun Feb  2 18:27:00 2003
@@ -95,7 +95,7 @@
 	pnp_dev = to_pnp_dev(dev);
 	pnp_drv = to_pnp_driver(dev->driver);
 
-	pnp_dbg("pnp: match found with the PnP device '%s' and the driver '%s'", dev->bus_id,pnp_drv->name);
+	pnp_dbg("match found with the PnP device '%s' and the driver '%s'", dev->bus_id,pnp_drv->name);
 
 	error = pnp_device_attach(pnp_dev);
 	if (error < 0)
@@ -103,7 +103,7 @@
 
 	if (pnp_dev->active == 0) {
 		if (!(pnp_drv->flags & PNP_DRIVER_DO_NOT_ACTIVATE)) {
-			error = pnp_activate_dev(pnp_dev, NULL);
+			error = pnp_activate_dev(pnp_dev);
 			if (error < 0)
 				return error;
 		}
diff -urN a/drivers/pnp/names.c b/drivers/pnp/names.c
--- a/drivers/pnp/names.c	Tue Jan 14 05:58:03 2003
+++ b/drivers/pnp/names.c	Sat Feb  1 16:52:08 2003
@@ -30,7 +30,7 @@
 pnp_name_device(struct pnp_dev *dev)
 {
 	int i;
-	char *name = dev->name;
+	char *name = dev->dev.name;
 	for(i=0; i<sizeof(pnp_id_eisaid)/sizeof(pnp_id_eisaid[0]); i++){
 		if (compare_pnp_id(dev->id,pnp_id_eisaid[i])){
 			sprintf(name, "%s", pnp_id_names[i]);
diff -urN a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
--- a/drivers/pnp/quirks.c	Tue Jan 14 05:59:12 2003
+++ b/drivers/pnp/quirks.c	Sat Feb  1 16:52:08 2003
@@ -29,7 +29,7 @@
 static void quirk_awe32_resources(struct pnp_dev *dev)
 {
 	struct pnp_port *port, *port2, *port3;
-	struct pnp_resources *res = dev->res->dep;
+	struct pnp_resources *res = dev->possible->dep;
 
 	/*
 	 * Unfortunately the isapnp_add_port_resource is too tightly bound
@@ -57,7 +57,7 @@
 
 static void quirk_cmi8330_resources(struct pnp_dev *dev)
 {
-	struct pnp_resources *res = dev->res->dep;
+	struct pnp_resources *res = dev->possible->dep;
 
 	for ( ; res ; res = res->dep ) {
 
@@ -77,7 +77,7 @@
 static void quirk_sb16audio_resources(struct pnp_dev *dev)
 {
 	struct pnp_port *port;
-	struct pnp_resources *res = dev->res->dep;
+	struct pnp_resources *res = dev->possible->dep;
 	int    changed = 0;
 
 	/*
@@ -115,7 +115,7 @@
 	 */
 	struct pnp_resources *res;
 	int max;
-	res = dev->res;
+	res = dev->possible;
 	max = 0;
 	for (res = res->dep; res; res = res->dep) {
 		if (res->dma->map > max)
diff -urN a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c	Tue Jan 14 05:58:56 2003
+++ b/drivers/pnp/resource.c	Sat Feb  8 15:30:20 2003
@@ -1,5 +1,5 @@
 /*
- * resource.c - contains resource management algorithms
+ * resource.c - Contains functions for registering and analyzing resource information
  *
  * based on isapnp.c resource management (c) Jaroslav Kysela <perex@suse.cz>
  * Copyright 2002 Adam Belay <ambx1@neo.rr.com>
@@ -16,15 +16,8 @@
 #include <asm/dma.h>
 #include <asm/irq.h>
 #include <linux/ioport.h>
-#include <linux/config.h>
 #include <linux/init.h>
 
-#ifdef CONFIG_PNP_DEBUG
-	#define DEBUG
-#else
-	#undef DEBUG
-#endif
-
 #include <linux/pnp.h>
 #include "base.h"
 
@@ -36,7 +29,9 @@
 int pnp_reserve_mem[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some memory region */
 
 
-/* resource information adding functions */
+/*
+ * possible resource registration
+ */
 
 struct pnp_resources * pnp_build_resource(struct pnp_dev *dev, int dependent)
 {
@@ -45,8 +40,8 @@
 	res = pnp_alloc(sizeof(struct pnp_resources));
 	if (!res)
 		return NULL;
-	ptr = dev->res;
-	if (ptr && ptr->dependent && dependent) { /* add to another list */
+	ptr = dev->possible;
+	if (ptr) { /* add to another list */
 		ptra = ptr->dep;
 		while (ptra && ptra->dep)
 			ptra = ptra->dep;
@@ -54,24 +49,14 @@
 			ptr->dep = res;
 		else
 			ptra->dep = res;
-	} else {
-		if (!ptr){
-			dev->res = res;
-		}
-		else{
-			kfree(res);
-			return NULL;
-		}
-	}
+	} else
+		dev->possible = res;
 	if (dependent) {
 		res->priority = dependent & 0xff;
 		if (res->priority > PNP_RES_PRIORITY_FUNCTIONAL)
 			res->priority = PNP_RES_PRIORITY_INVALID;
-		res->dependent = 1;
-	} else {
+	} else
 		res->priority = PNP_RES_PRIORITY_PREFERRED;
-		res->dependent = 1;
-	}
 	return res;
 }
 
@@ -81,7 +66,7 @@
 	struct pnp_resources *res;
 	if (!dev)
 		return NULL;
-	res = dev->res;
+	res = dev->possible;
 	if (!res)
 		return NULL;
 	for (i = 0; i < depnum; i++)
@@ -100,7 +85,7 @@
 	struct pnp_resources *res;
 	if (!dev)
 		return -EINVAL;
-	res = dev->res;
+	res = dev->possible;
 	if (!res)
 		return -EINVAL;
 	while (res->dep){
@@ -110,10 +95,6 @@
 	return num;
 }
 
-/*
- *  Add IRQ resource to resources list.
- */
-
 int pnp_add_irq_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data)
 {
 	int i;
@@ -139,10 +120,6 @@
 	return 0;
 }
 
-/*
- *  Add DMA resource to resources list.
- */
-
 int pnp_add_dma_resource(struct pnp_dev *dev, int depnum, struct pnp_dma *data)
 {
 	struct pnp_resources *res;
@@ -162,20 +139,15 @@
 	return 0;
 }
 
-/*
- *  Add port resource to resources list.
- */
-
 int pnp_add_port_resource(struct pnp_dev *dev, int depnum, struct pnp_port *data)
 {
 	struct pnp_resources *res;
 	struct pnp_port *ptr;
 	res = pnp_find_resources(dev,depnum);
-	if (res==NULL)
+	if (!res)
 		return -EINVAL;
 	if (!data)
 		return -EINVAL;
-	data->res = res;
 	ptr = res->port;
 	while (ptr && ptr->next)
 		ptr = ptr->next;
@@ -186,10 +158,6 @@
 	return 0;
 }
 
-/*
- *  Add memory resource to resources list.
- */
-
 int pnp_add_mem_resource(struct pnp_dev *dev, int depnum, struct pnp_mem *data)
 {
 	struct pnp_resources *res;
@@ -209,32 +177,6 @@
 	return 0;
 }
 
-/*
- *  Add 32-bit memory resource to resources list.
- */
-
-int pnp_add_mem32_resource(struct pnp_dev *dev, int depnum, struct pnp_mem32 *data)
-{
-	struct pnp_resources *res;
-	struct pnp_mem32 *ptr;
-	res = pnp_find_resources(dev,depnum);
-	if (!res)
-		return -EINVAL;
-	if (!data)
-		return -EINVAL;
-	ptr = res->mem32;
-	while (ptr && ptr->next)
-		ptr = ptr->next;
-	if (ptr)
-		ptr->next = data;
-	else
-		res->mem32 = data;
-	return 0;
-}
-
-
-/* resource removing functions */
-
 static void pnp_free_port(struct pnp_port *port)
 {
 	struct pnp_port *next;
@@ -279,17 +221,6 @@
 	}
 }
 
-static void pnp_free_mem32(struct pnp_mem32 *mem32)
-{
-	struct pnp_mem32 *next;
-
-	while (mem32) {
-		next = mem32->next;
-		kfree(mem32);
-		mem32 = next;
-	}
-}
-
 void pnp_free_resources(struct pnp_resources *resources)
 {
 	struct pnp_resources *next;
@@ -300,597 +231,447 @@
 		pnp_free_irq(resources->irq);
 		pnp_free_dma(resources->dma);
 		pnp_free_mem(resources->mem);
-		pnp_free_mem32(resources->mem32);
 		kfree(resources);
 		resources = next;
 	}
 }
 
 
-/* resource validity checking functions */
+/*
+ * resource validity checking
+ */
+
+#define length(start, end) (*(end) - *(start) + 1)
 
-static int pnp_check_port(int port, int size, int idx, struct pnp_cfg *config)
-{
-	int i, tmp, rport, rsize;
-	struct pnp_dev *dev;
+/* ranged_conflict - used to determine if two resource ranges conflict
+ * condition 1: check if the start of a is within b
+ * condition 2: check if the end of a is within b
+ * condition 3: check if b is engulfed by a */
+
+#define ranged_conflict(starta, enda, startb, endb) \
+((*(starta) >= *(startb) && *(starta) <= *(endb)) || \
+ (*(enda) >= *(startb) && *(enda) <= *(endb)) || \
+ (*(starta) < *(startb) && *(enda) > *(endb)))
+
+struct pnp_dev * pnp_check_port_conflicts(struct pnp_dev * dev, int idx, int mode)
+{
+	int tmp;
+	unsigned long *port, *end, *tport, *tend;
+	struct pnp_dev *tdev;
+	port = &dev->res.port_resource[idx].start;
+	end = &dev->res.port_resource[idx].end;
 
-	if (check_region(port, size))
-		return 1;
-	for (i = 0; i < 8; i++) {
-		rport = pnp_reserve_io[i << 1];
-		rsize = pnp_reserve_io[(i << 1) + 1];
-		if (port >= rport && port < rport + rsize)
-			return 1;
-		if (port + size > rport && port + size < (rport + rsize) - 1)
-			return 1;
-	}
-
-	pnp_for_each_dev(dev) {
-		if (dev->active) {
-			for (tmp = 0; tmp < 8; tmp++) {
-				if (pnp_port_valid(dev, tmp)) {
-					rport = pnp_port_start(dev, tmp);
-					rsize = pnp_port_len(dev, tmp);
-					if (port >= rport && port < rport + rsize)
-						return 1;
-					if (port + size > rport && port + size < (rport + rsize) - 1)
-						return 1;
-				}
+	/* if the resource doesn't exist, don't complain about it */
+	if (dev->res.port_resource[idx].start == 0)
+		return NULL;
+
+	/* check for cold conflicts */
+	pnp_for_each_dev(tdev) {
+		/* Is the device configurable? */
+		if (tdev == dev || (mode ? !dev->active : dev->active))
+			continue;
+		for (tmp = 0; tmp < PNP_MAX_PORT; tmp++) {
+			if (tdev->res.port_resource[tmp].flags & IORESOURCE_IO) {
+				tport = &tdev->res.port_resource[tmp].start;
+				tend = &tdev->res.port_resource[tmp].end;
+				if (ranged_conflict(port,end,tport,tend))
+					return tdev;
 			}
 		}
 	}
-	for (tmp = 0; tmp < 8 && tmp != idx; tmp++) {
-		if (pnp_port_valid(dev, tmp) &&
-		    pnp_flags_valid(&config->request.io_resource[tmp])) {
-			rport = config->request.io_resource[tmp].start;
-			rsize = (config->request.io_resource[tmp].end - rport) + 1;
-			if (port >= rport && port < rport + rsize)
-				return 1;
-			if (port + size > rport && port + size < (rport + rsize) - 1)
-				return 1;
+	return NULL;
+}
+
+int pnp_check_port(struct pnp_dev * dev, int idx)
+{
+	int tmp;
+	unsigned long *port, *end, *tport, *tend;
+	port = &dev->res.port_resource[idx].start;
+	end = &dev->res.port_resource[idx].end;
+
+	/* if the resource doesn't exist, don't complain about it */
+	if (dev->res.port_resource[idx].start == 0)
+		return 0;
+
+	/* check if the resource is already in use, skip if the device is active because it itself may be in use */
+	if(!dev->active) {
+		if (check_region(*port, length(port,end)))
+			return CONFLICT_TYPE_IN_USE;
+	}
+
+	/* check if the resource is reserved */
+	for (tmp = 0; tmp < 8; tmp++) {
+		int rport = pnp_reserve_io[tmp << 1];
+		int rend = pnp_reserve_io[(tmp << 1) + 1] + rport - 1;
+		if (ranged_conflict(port,end,&rport,&rend))
+			return CONFLICT_TYPE_RESERVED;
+	}
+
+	/* check for internal conflicts */
+	for (tmp = 0; tmp < PNP_MAX_PORT && tmp != idx; tmp++) {
+		if (dev->res.port_resource[tmp].flags & IORESOURCE_IO) {
+			tport = &dev->res.port_resource[tmp].start;
+			tend = &dev->res.port_resource[tmp].end;
+			if (ranged_conflict(port,end,tport,tend))
+				return CONFLICT_TYPE_INTERNAL;
 		}
 	}
+
+	/* check for warm conflicts */
+	if (pnp_check_port_conflicts(dev, idx, SEARCH_WARM))
+		return CONFLICT_TYPE_PNP_WARM;
+
 	return 0;
 }
 
-static int pnp_check_mem(unsigned int addr, unsigned int size, int idx, struct pnp_cfg *config)
+struct pnp_dev * pnp_check_mem_conflicts(struct pnp_dev * dev, int idx, int mode)
 {
-	int i, tmp;
-	unsigned int raddr, rsize;
-	struct pnp_dev *dev;
-
-	for (i = 0; i < 8; i++) {
-		raddr = (unsigned int)pnp_reserve_mem[i << 1];
-		rsize = (unsigned int)pnp_reserve_mem[(i << 1) + 1];
-		if (addr >= raddr && addr < raddr + rsize)
-			return 1;
-		if (addr + size > raddr && addr + size < (raddr + rsize) - 1)
-			return 1;
-		if (__check_region(&iomem_resource, addr, size))
-			return 1;
-	}
-	pnp_for_each_dev(dev) {
-		if (dev->active) {
-			for (tmp = 0; tmp < 4; tmp++) {
-				if (pnp_mem_valid(dev, tmp)) {
-					raddr = pnp_mem_start(dev, tmp);
-					rsize = pnp_mem_len(dev, tmp);
-					if (addr >= raddr && addr < raddr + rsize)
-						return 1;
-					if (addr + size > raddr && addr + size < (raddr + rsize) - 1)
-						return 1;
-				}
+	int tmp;
+	unsigned long *addr, *end, *taddr, *tend;
+	struct pnp_dev *tdev;
+	addr = &dev->res.mem_resource[idx].start;
+	end = &dev->res.mem_resource[idx].end;
+
+	/* if the resource doesn't exist, don't complain about it */
+	if (dev->res.mem_resource[idx].start == 0)
+		return NULL;
+
+	/* check for cold conflicts */
+	pnp_for_each_dev(tdev) {
+		/* Is the device configurable? */
+		if (tdev == dev || (mode ? !dev->active : dev->active))
+			continue;
+		for (tmp = 0; tmp < PNP_MAX_MEM; tmp++) {
+			if (tdev->res.mem_resource[tmp].flags & IORESOURCE_MEM) {
+				taddr = &tdev->res.mem_resource[tmp].start;
+				tend = &tdev->res.mem_resource[tmp].end;
+				if (ranged_conflict(addr,end,taddr,tend))
+					return tdev;
 			}
 		}
 	}
-	for (tmp = 0; tmp < 4 && tmp != idx; tmp++) {
-		if (pnp_mem_valid(dev, tmp) &&
-		    pnp_flags_valid(&config->request.mem_resource[tmp])) {
-			raddr = config->request.mem_resource[tmp].start;
-			rsize = (config->request.mem_resource[tmp].end - raddr) + 1;
-			if (addr >= raddr && addr < raddr + rsize)
-				return 1;
-			if (addr + size > raddr && addr + size < (raddr + rsize) - 1)
-				return 1;
+	return NULL;
+}
+
+int pnp_check_mem(struct pnp_dev * dev, int idx)
+{
+	int tmp;
+	unsigned long *addr, *end, *taddr, *tend;
+	addr = &dev->res.mem_resource[idx].start;
+	end = &dev->res.mem_resource[idx].end;
+
+	/* if the resource doesn't exist, don't complain about it */
+	if (dev->res.mem_resource[idx].start == 0)
+		return 0;
+
+	/* check if the resource is already in use, skip if the device is active because it itself may be in use */
+	if(!dev->active) {
+		if (__check_region(&iomem_resource, *addr, length(addr,end)))
+			return CONFLICT_TYPE_IN_USE;
+	}
+
+	/* check if the resource is reserved */
+	for (tmp = 0; tmp < 8; tmp++) {
+		int raddr = pnp_reserve_mem[tmp << 1];
+		int rend = pnp_reserve_mem[(tmp << 1) + 1] + raddr - 1;
+		if (ranged_conflict(addr,end,&raddr,&rend))
+			return CONFLICT_TYPE_RESERVED;
+	}
+
+	/* check for internal conflicts */
+	for (tmp = 0; tmp < PNP_MAX_MEM && tmp != idx; tmp++) {
+		if (dev->res.mem_resource[tmp].flags & IORESOURCE_MEM) {
+			taddr = &dev->res.mem_resource[tmp].start;
+			tend = &dev->res.mem_resource[tmp].end;
+			if (ranged_conflict(addr,end,taddr,tend))
+				return CONFLICT_TYPE_INTERNAL;
 		}
 	}
+
+	/* check for warm conflicts */
+	if (pnp_check_mem_conflicts(dev, idx, SEARCH_WARM))
+		return CONFLICT_TYPE_PNP_WARM;
+
 	return 0;
 }
 
+struct pnp_dev * pnp_check_irq_conflicts(struct pnp_dev * dev, int idx, int mode)
+{
+	int tmp;
+	struct pnp_dev * tdev;
+	unsigned long * irq = &dev->res.irq_resource[idx].start;
+
+	/* if the resource doesn't exist, don't complain about it */
+	if (dev->res.irq_resource[idx].start == -1)
+		return NULL;
+
+	/* check for cold conflicts */
+	pnp_for_each_dev(tdev) {
+		/* Is the device configurable? */
+		if (tdev == dev || (mode ? !dev->active : dev->active))
+			continue;
+		for (tmp = 0; tmp < PNP_MAX_IRQ; tmp++) {
+			if (tdev->res.irq_resource[tmp].flags & IORESOURCE_IRQ) {
+				if ((tdev->res.irq_resource[tmp].start == *irq))
+					return tdev;
+			}
+		}
+	}
+	return NULL;
+}
+
 static void pnp_test_handler(int irq, void *dev_id, struct pt_regs *regs)
 {
 }
 
-static int pnp_check_interrupt(int irq, struct pnp_cfg *config)
+int pnp_check_irq(struct pnp_dev * dev, int idx)
 {
-	int i;
-#ifdef CONFIG_PCI
-	struct pci_dev *pci;
-#endif
-	struct pnp_dev *dev;
-	if (!config)
-		return 1;
-
-	if (irq < 0 || irq > 15)
-		return 1;
-	for (i = 0; i < 16; i++) {
-		if (pnp_reserve_irq[i] == irq)
-			return 1;
-	}
-	pnp_for_each_dev(dev) {
-		if (dev->active) {
-			if ((pnp_irq_valid(dev, 0) && dev->irq_resource[0].start == irq) ||
-			    (pnp_irq_valid(dev, 1) && dev->irq_resource[1].start == irq))
-				return 1;
+	int tmp;
+	unsigned long * irq = &dev->res.irq_resource[idx].start;
+
+	/* if the resource doesn't exist, don't complain about it */
+	if (dev->res.irq_resource[idx].start == -1)
+		return 0;
+
+	/* check if the resource is valid */
+	if (*irq < 0 || *irq > 15)
+		return CONFLICT_TYPE_INVALID;
+
+	/* check if the resource is reserved */
+	for (tmp = 0; tmp < 16; tmp++) {
+		if (pnp_reserve_irq[tmp] == *irq)
+			return CONFLICT_TYPE_RESERVED;
+	}
+
+	/* check for internal conflicts */
+	for (tmp = 0; tmp < PNP_MAX_IRQ && tmp != idx; tmp++) {
+		if (dev->res.irq_resource[tmp].flags & IORESOURCE_IRQ) {
+			if (dev->res.irq_resource[tmp].start == *irq)
+				return CONFLICT_TYPE_INTERNAL;
 		}
 	}
-	if (pnp_flags_valid(&config->request.irq_resource[0]) &&
-	    pnp_flags_valid(&config->request.irq_resource[1]) &&
-	    (config->request.irq_resource[0].start == irq))
-		return 1;
+
 #ifdef CONFIG_PCI
+	/* check if the resource is being used by a pci device */
 	if (!pnp_skip_pci_scan) {
+		struct pci_dev * pci;
 		pci_for_each_dev(pci) {
-			if (pci->irq == irq)
-				return 1;
+			if (pci->irq == *irq)
+				return CONFLICT_TYPE_PCI;
 		}
 	}
 #endif
-	if (request_irq(irq, pnp_test_handler, SA_INTERRUPT, "pnp", NULL))
-		return 1;
-	free_irq(irq, NULL);
-	return 0;
-}
-
-static int pnp_check_dma(int dma, struct pnp_cfg *config)
-{
-	int i, mindma = 1;
-	struct pnp_dev *dev;
-	if (!config)
-		return 1;
 
-	if (pnp_allow_dma0 == 1)
-		mindma = 0;
-	if (dma < mindma || dma == 4 || dma > 7)
-		return 1;
-	for (i = 0; i < 8; i++) {
-		if (pnp_reserve_dma[i] == dma)
-			return 1;
-	}
-	pnp_for_each_dev(dev) {
-		if (dev->active) {
-			if ((pnp_dma_valid(dev, 0) && pnp_dma(dev, 0) == dma) ||
-			    (pnp_dma_valid(dev, 1) && pnp_dma(dev, 1) == dma))
-				return 1;
-		}
+	/* check if the resource is already in use, skip if the device is active because it itself may be in use */
+	if(!dev->active) {
+		if (request_irq(*irq, pnp_test_handler, SA_INTERRUPT, "pnp", NULL))
+			return CONFLICT_TYPE_IN_USE;
+		free_irq(*irq, NULL);
 	}
-	if (pnp_flags_valid(&config->request.dma_resource[0]) &&
-	    pnp_flags_valid(&config->request.dma_resource[1]) &&
-	    (config->request.dma_resource[0].start == dma))
-		return 1;
-	if (request_dma(dma, "pnp"))
-		return 1;
-	free_dma(dma);
-	return 0;
-}
 
+	/* check for warm conflicts */
+	if (pnp_check_irq_conflicts(dev, idx, SEARCH_WARM))
+		return CONFLICT_TYPE_PNP_WARM;
 
-/* config generation functions */
-static int pnp_generate_port(struct pnp_cfg *config, int num)
-{
-	struct pnp_port *port;
-	unsigned long *value1, *value2, *value3;
-	if (!config || num < 0 || num > 7)
-		return -EINVAL;
-	port = config->port[num];
-	if (!port)
-		return 0;
-	value1 = &config->request.io_resource[num].start;
-	value2 = &config->request.io_resource[num].end;
-	value3 = &config->request.io_resource[num].flags;
-	*value1 = port->min;
-	*value2 = *value1 + port->size - 1;
-	*value3 = port->flags | IORESOURCE_IO;
-	while (pnp_check_port(*value1, port->size, num, config)) {
-		*value1 += port->align;
-		*value2 = *value1 + port->size - 1;
-		if (*value1 > port->max || !port->align)
-			return -ENOENT;
-	}
 	return 0;
 }
 
-static int pnp_generate_mem(struct pnp_cfg *config, int num)
-{
-	struct pnp_mem *mem;
-	unsigned long *value1, *value2, *value3;
-	if (!config || num < 0 || num > 3)
-		return -EINVAL;
-	mem = config->mem[num];
-	if (!mem)
-		return 0;
-	value1 = &config->request.mem_resource[num].start;
-	value2 = &config->request.mem_resource[num].end;
-	value3 = &config->request.mem_resource[num].flags;
-	*value1 = mem->min;
-	*value2 = *value1 + mem->size - 1;
-	*value3 = mem->flags | IORESOURCE_MEM;
-	if (!(mem->flags & IORESOURCE_MEM_WRITEABLE))
-		*value3 |= IORESOURCE_READONLY;
-	if (mem->flags & IORESOURCE_MEM_CACHEABLE)
-		*value3 |= IORESOURCE_CACHEABLE;
-	if (mem->flags & IORESOURCE_MEM_RANGELENGTH)
-		*value3 |= IORESOURCE_RANGELENGTH;
-	if (mem->flags & IORESOURCE_MEM_SHADOWABLE)
-		*value3 |= IORESOURCE_SHADOWABLE;
-	while (pnp_check_mem(*value1, mem->size, num, config)) {
-		*value1 += mem->align;
-		*value2 = *value1 + mem->size - 1;
-		if (*value1 > mem->max || !mem->align)
-			return -ENOENT;
-	}
-	return 0;
-}
 
-static int pnp_generate_irq(struct pnp_cfg *config, int num)
+struct pnp_dev * pnp_check_dma_conflicts(struct pnp_dev * dev, int idx, int mode)
 {
-	struct pnp_irq *irq;
-	unsigned long *value1, *value2, *value3;
-	/* IRQ priority: this table is good for i386 */
-	static unsigned short xtab[16] = {
-		5, 10, 11, 12, 9, 14, 15, 7, 3, 4, 13, 0, 1, 6, 8, 2
-	};
-	int i;
-	if (!config || num < 0 || num > 1)
-		return -EINVAL;
-	irq = config->irq[num];
-	if (!irq)
-		return 0;
-	value1 = &config->request.irq_resource[num].start;
-	value2 = &config->request.irq_resource[num].end;
-	value3 = &config->request.irq_resource[num].flags;
-	*value3 = irq->flags | IORESOURCE_IRQ;
+	int tmp;
+	struct pnp_dev * tdev;
+	unsigned long * dma = &dev->res.dma_resource[idx].start;
 
-	for (i=0; i < 16; i++)
-	{
-		if(irq->map & (1<<xtab[i])) {
-		*value1 = *value2 = xtab[i];
-		if(pnp_check_interrupt(*value1,config)==0)
-			return 0;
+	/* if the resource doesn't exist, don't complain about it */
+	if (dev->res.dma_resource[idx].start == -1)
+		return NULL;
+
+	/* check for cold conflicts */
+	pnp_for_each_dev(tdev) {
+		/* Is the device configurable? */
+		if (tdev == dev || (mode ? !dev->active : dev->active))
+			continue;
+		for (tmp = 0; tmp < PNP_MAX_DMA; tmp++) {
+			if (tdev->res.dma_resource[tmp].flags & IORESOURCE_DMA) {
+				if ((tdev->res.dma_resource[tmp].start == *dma))
+					return tdev;
+			}
 		}
 	}
-	return -ENOENT;
+	return NULL;
 }
 
-static int pnp_generate_dma(struct pnp_cfg *config, int num)
+int pnp_check_dma(struct pnp_dev * dev, int idx)
 {
-	struct pnp_dma *dma;
-	unsigned long *value1, *value2, *value3;
-	/* DMA priority: this table is good for i386 */
-	static unsigned short xtab[16] = {
-		1, 3, 5, 6, 7, 0, 2, 4
-	};
-	int i;
-	if (!config || num < 0 || num > 1)
-		return -EINVAL;
-	dma = config->dma[num];
-	if (!dma)
+	int tmp, mindma = 1;
+	unsigned long * dma = &dev->res.dma_resource[idx].start;
+
+	/* if the resource doesn't exist, don't complain about it */
+	if (dev->res.dma_resource[idx].start == -1)
 		return 0;
-	value1 = &config->request.dma_resource[num].start;
-	value2 = &config->request.dma_resource[num].end;
-	value3 = &config->request.dma_resource[num].flags;
-	*value3 = dma->flags | IORESOURCE_DMA;
 
-	for (i=0; i < 8; i++)
-	{
-		if(dma->map & (1<<xtab[i])) {
-		*value1 = *value2 = xtab[i];
-		if(pnp_check_dma(*value1,config)==0)
-			return 0;
-		}
+	/* check if the resource is valid */
+	if (pnp_allow_dma0 == 1)
+		mindma = 0;
+	if (*dma < mindma || *dma == 4 || *dma > 7)
+		return CONFLICT_TYPE_INVALID;
+
+	/* check if the resource is reserved */
+	for (tmp = 0; tmp < 8; tmp++) {
+		if (pnp_reserve_dma[tmp] == *dma)
+			return CONFLICT_TYPE_RESERVED;
 	}
-	return -ENOENT;
-}
 
-int pnp_init_res_cfg(struct pnp_res_cfg *res_config)
-{
-	int idx;
+	/* check for internal conflicts */
+	for (tmp = 0; tmp < PNP_MAX_DMA && tmp != idx; tmp++) {
+		if (dev->res.dma_resource[tmp].flags & IORESOURCE_DMA) {
+			if (dev->res.dma_resource[tmp].start == *dma)
+				return CONFLICT_TYPE_INTERNAL;
+		}
+	}
 
-	if (!res_config)
-		return -EINVAL;
-	for (idx = 0; idx < DEVICE_COUNT_IRQ; idx++) {
-		res_config->irq_resource[idx].start = -1;
-		res_config->irq_resource[idx].end = -1;
-		res_config->irq_resource[idx].flags = IORESOURCE_IRQ|IORESOURCE_UNSET;
-	}
-	for (idx = 0; idx < DEVICE_COUNT_DMA; idx++) {
-		res_config->dma_resource[idx].name = NULL;
-		res_config->dma_resource[idx].start = -1;
-		res_config->dma_resource[idx].end = -1;
-		res_config->dma_resource[idx].flags = IORESOURCE_DMA|IORESOURCE_UNSET;
-	}
-	for (idx = 0; idx < DEVICE_COUNT_IO; idx++) {
-		res_config->io_resource[idx].name = NULL;
-		res_config->io_resource[idx].start = 0;
-		res_config->io_resource[idx].end = 0;
-		res_config->io_resource[idx].flags = IORESOURCE_IO|IORESOURCE_UNSET;
-	}
-	for (idx = 0; idx < DEVICE_COUNT_MEM; idx++) {
-		res_config->mem_resource[idx].name = NULL;
-		res_config->mem_resource[idx].start = 0;
-		res_config->mem_resource[idx].end = 0;
-		res_config->mem_resource[idx].flags = IORESOURCE_MEM|IORESOURCE_UNSET;
+	/* check if the resource is already in use, skip if the device is active because it itself may be in use */
+	if(!dev->active) {
+		if (request_dma(*dma, "pnp"))
+			return CONFLICT_TYPE_IN_USE;
+		free_dma(*dma);
 	}
-	return 0;
-}
 
-static int pnp_prepare_request(struct pnp_dev *dev, struct pnp_cfg *config, struct pnp_res_cfg *template)
-{
-	int idx, err;
-	if (!config)
-		return -EINVAL;
-	if (dev->lock_resources)
-		return -EPERM;
-	if (dev->active)
-		return -EBUSY;
-	err = pnp_init_res_cfg(&config->request);
-	if (err < 0)
-		return err;
-	if (!template)
-		return 0;
-	for (idx = 0; idx < DEVICE_COUNT_IRQ; idx++)
-		if (pnp_flags_valid(&template->irq_resource[idx]))
-			config->request.irq_resource[idx] = template->irq_resource[idx];
-	for (idx = 0; idx < DEVICE_COUNT_DMA; idx++)
-		if (pnp_flags_valid(&template->dma_resource[idx]))
-			config->request.dma_resource[idx] = template->dma_resource[idx];
-	for (idx = 0; idx < DEVICE_COUNT_IO; idx++)
-		if (pnp_flags_valid(&template->io_resource[idx]))
-			config->request.io_resource[idx] = template->io_resource[idx];
-	for (idx = 0; idx < DEVICE_COUNT_MEM; idx++)
-		if (pnp_flags_valid(&template->io_resource[idx]))
-			config->request.mem_resource[idx] = template->mem_resource[idx];
+	/* check for warm conflicts */
+	if (pnp_check_dma_conflicts(dev, idx, SEARCH_WARM))
+		return CONFLICT_TYPE_PNP_WARM;
 	return 0;
 }
 
-static int pnp_generate_request(struct pnp_dev *dev, struct pnp_cfg *config, struct pnp_res_cfg *template)
+
+/**
+ * pnp_init_resource_table - Resets a resource table to default values.
+ * @table: pointer to the desired resource table
+ *
+ */
+
+void pnp_init_resource_table(struct pnp_resource_table *table)
 {
-	int i, err;
-	if (!config)
-		return -EINVAL;
-	if ((err = pnp_prepare_request(dev, config, template))<0)
-		return err;
-	for (i=0; i<=7; i++)
-	{
-		if(pnp_generate_port(config,i)<0)
-			return -ENOENT;
-	}
-	for (i=0; i<=3; i++)
-	{
-		if(pnp_generate_mem(config,i)<0)
-			return -ENOENT;
-	}
-	for (i=0; i<=1; i++)
-	{
-		if(pnp_generate_irq(config,i)<0)
-			return -ENOENT;
-	}
-	for (i=0; i<=1; i++)
-	{
-		if(pnp_generate_dma(config,i)<0)
-			return -ENOENT;
+	int idx;
+	for (idx = 0; idx < PNP_MAX_IRQ; idx++) {
+		table->irq_resource[idx].name = NULL;
+		table->irq_resource[idx].start = -1;
+		table->irq_resource[idx].end = -1;
+		table->irq_resource[idx].flags = 0;
+	}
+	for (idx = 0; idx < PNP_MAX_DMA; idx++) {
+		table->dma_resource[idx].name = NULL;
+		table->dma_resource[idx].start = -1;
+		table->dma_resource[idx].end = -1;
+		table->dma_resource[idx].flags = 0;
+	}
+	for (idx = 0; idx < PNP_MAX_PORT; idx++) {
+		table->port_resource[idx].name = NULL;
+		table->port_resource[idx].start = 0;
+		table->port_resource[idx].end = 0;
+		table->port_resource[idx].flags = 0;
+	}
+	for (idx = 0; idx < PNP_MAX_MEM; idx++) {
+		table->mem_resource[idx].name = NULL;
+		table->mem_resource[idx].start = 0;
+		table->mem_resource[idx].end = 0;
+		table->mem_resource[idx].flags = 0;
 	}
-	return 0;
 }
 
 
+/**
+ * pnp_generate_rule - Creates a rule table structure based on depnum and device.
+ * @dev: pointer to the desired device
+ * @depnum: dependent function, if not valid will return an error
+ * @rule: pointer to a rule structure to record data to
+ *
+ */
 
-static struct pnp_cfg * pnp_generate_config(struct pnp_dev *dev, int depnum)
+int pnp_generate_rule(struct pnp_dev * dev, int depnum, struct pnp_rule_table * rule)
 {
-	struct pnp_cfg * config;
 	int nport = 0, nirq = 0, ndma = 0, nmem = 0;
 	struct pnp_resources * res;
 	struct pnp_port * port;
 	struct pnp_mem * mem;
 	struct pnp_irq * irq;
 	struct pnp_dma * dma;
-	if (!dev)
-		return NULL;
-	if (depnum < 0)
-		return NULL;
-	config = pnp_alloc(sizeof(struct pnp_cfg));
-	if (!config)
-		return NULL;
+
+	if (depnum <= 0 || !rule)
+		return -EINVAL;
 
 	/* independent */
 	res = pnp_find_resources(dev, 0);
 	if (!res)
-		goto fail;
+		return -ENODEV;
 	port = res->port;
 	mem = res->mem;
 	irq = res->irq;
 	dma = res->dma;
 	while (port){
-		config->port[nport] = port;
+		rule->port[nport] = port;
 		nport++;
 		port = port->next;
 	}
 	while (mem){
-		config->mem[nmem] = mem;
+		rule->mem[nmem] = mem;
 		nmem++;
 		mem = mem->next;
 	}
 	while (irq){
-		config->irq[nirq] = irq;
+		rule->irq[nirq] = irq;
 		nirq++;
 		irq = irq->next;
 	}
 	while (dma){
-		config->dma[ndma] = dma;
+		rule->dma[ndma] = dma;
 		ndma++;
 		dma = dma->next;
 	}
 
 	/* dependent */
-	if (depnum == 0)
-		return config;
 	res = pnp_find_resources(dev, depnum);
 	if (!res)
-		goto fail;
+		return -ENODEV;
 	port = res->port;
 	mem = res->mem;
 	irq = res->irq;
 	dma = res->dma;
 	while (port){
-		config->port[nport] = port;
+		rule->port[nport] = port;
 		nport++;
 		port = port->next;
 	}
 	while (mem){
-		config->mem[nmem] = mem;
+		rule->mem[nmem] = mem;
 		nmem++;
 		mem = mem->next;
 	}
 
 	while (irq){
-		config->irq[nirq] = irq;
+		rule->irq[nirq] = irq;
 		nirq++;
 		irq = irq->next;
 	}
 	while (dma){
-		config->dma[ndma] = dma;
+		rule->dma[ndma] = dma;
 		ndma++;
 		dma = dma->next;
 	}
-	return config;
-
-	fail:
-	kfree(config);
-	return NULL;
-}
-
-/* PnP Device Resource Management */
-
-/**
- * pnp_activate_dev - activates a PnP device for use
- * @dev: pointer to the desired device
- *
- * finds the best resource configuration and then informs the correct pnp protocol
- */
 
-int pnp_activate_dev(struct pnp_dev *dev, struct pnp_res_cfg *template)
-{
-	int depnum, max;
-	struct pnp_cfg *config;
-	if (!dev)
-		return -EINVAL;
-        max = pnp_get_max_depnum(dev);
-	if (!pnp_can_configure(dev))
-		return -EBUSY;
-	if (dev->status != PNP_READY && dev->status != PNP_ATTACHED){
-		printk(KERN_INFO "pnp: Automatic configuration failed because the PnP device '%s' is busy\n", dev->dev.bus_id);
-		return -EINVAL;
-	}
-	if (!pnp_can_write(dev))
-		return -EINVAL;
-	if (max == 0)
-		return 0;
-	for (depnum=1; depnum <= max; depnum++)
-	{
-		config = pnp_generate_config(dev,depnum);
-		if (!config)
-			return -EINVAL;
-		if (pnp_generate_request(dev,config,template)==0)
-			goto done;
-		kfree(config);
-	}
-	printk(KERN_ERR "pnp: Automatic configuration failed for device '%s' due to resource conflicts\n", dev->dev.bus_id);
-	return -ENOENT;
-
-	done:
-	pnp_dbg("the device '%s' has been activated", dev->dev.bus_id);
-	dev->protocol->set(dev,config);
-	if (pnp_can_read(dev))
-		dev->protocol->get(dev);
-	kfree(config);
-	return 0;
+	/* clear the remaining values */
+	for (; nport < PNP_MAX_PORT; nport++)
+		rule->port[nport] = NULL;
+	for (; nmem < PNP_MAX_MEM; nmem++)
+		rule->mem[nmem] = NULL;
+	for (; nirq < PNP_MAX_IRQ; nirq++)
+		rule->irq[nirq] = NULL;
+	for (; ndma < PNP_MAX_DMA; ndma++)
+		rule->dma[ndma] = NULL;
+	return 1;
 }
 
-/**
- * pnp_disable_dev - disables device
- * @dev: pointer to the desired device
- *
- * inform the correct pnp protocol so that resources can be used by other devices
- */
-
-int pnp_disable_dev(struct pnp_dev *dev)
-{
-        if (!dev)
-                return -EINVAL;
-	if (dev->status != PNP_READY){
-		printk(KERN_INFO "pnp: Disable failed becuase the PnP device '%s' is busy\n", dev->dev.bus_id);
-		return -EINVAL;
-	}
-	if (dev->lock_resources)
-		return -EPERM;
-	if (!pnp_can_disable(dev) || !dev->active)
-		return -EINVAL;
-	pnp_dbg("the device '%s' has been disabled", dev->dev.bus_id);
-	return dev->protocol->disable(dev);
-}
-
-/**
- * pnp_raw_set_dev - same as pnp_activate_dev except the resource config can be specified
- * @dev: pointer to the desired device
- * @depnum: resource dependent function
- * @mode: static or dynamic
- *
- */
-
-int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, struct pnp_res_cfg *template)
-{
-	struct pnp_cfg *config;
-	if (!dev)
-		return -EINVAL;
-	if (dev->status != PNP_READY){
-		printk(KERN_INFO "pnp: Unable to set resources because the PnP device '%s' is busy\n", dev->dev.bus_id);
-		return -EINVAL;
-	}
-	if (!pnp_can_write(dev) || !pnp_can_configure(dev))
-		return -EINVAL;
-        config = pnp_generate_config(dev,depnum);
-	if (!config)
-		return -EINVAL;
-	if (pnp_generate_request(dev,config,template)==0)
-		goto done;
-	kfree(config);
-	printk(KERN_ERR "pnp: Manual configuration failed for device '%s' due to resource conflicts\n", dev->dev.bus_id);
-	return -ENOENT;
-
-	done:
-	dev->protocol->set(dev,config);
-	if (pnp_can_read(dev))
-		dev->protocol->get(dev);
-	kfree(config);
-	return 0;
-}
-
-/**
- * pnp_resource_change - change one resource
- * @resource: pointer to resource to be changed
- * @start: start of region
- * @size: size of region
- *
- */
- 
-void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size)
-{
-	if (resource == NULL)
-		return;
-	resource->flags &= ~(IORESOURCE_AUTO|IORESOURCE_UNSET);
-	resource->start = start;
-	resource->end = start + size - 1;
-}
 
 EXPORT_SYMBOL(pnp_build_resource);
 EXPORT_SYMBOL(pnp_find_resources);
@@ -900,11 +681,9 @@
 EXPORT_SYMBOL(pnp_add_port_resource);
 EXPORT_SYMBOL(pnp_add_mem_resource);
 EXPORT_SYMBOL(pnp_add_mem32_resource);
-EXPORT_SYMBOL(pnp_init_res_cfg);
-EXPORT_SYMBOL(pnp_activate_dev);
-EXPORT_SYMBOL(pnp_disable_dev);
-EXPORT_SYMBOL(pnp_raw_set_dev);
-EXPORT_SYMBOL(pnp_resource_change);
+EXPORT_SYMBOL(pnp_init_resource_table);
+EXPORT_SYMBOL(pnp_generate_rule);
+
 
 /* format is: allowdma0 */
 
diff -urN a/drivers/pnp/system.c b/drivers/pnp/system.c
--- a/drivers/pnp/system.c	Tue Jan 14 05:59:34 2003
+++ b/drivers/pnp/system.c	Sat Feb  1 16:52:08 2003
@@ -53,7 +53,7 @@
 {
 	int i;
 
-	for (i=0;i<DEVICE_COUNT_IO;i++) {
+	for (i=0;i<PNP_MAX_PORT;i++) {
 		if (pnp_port_valid(dev, i))
 			/* end of resources */
 			continue;
diff -urN a/drivers/serial/8250_pnp.c b/drivers/serial/8250_pnp.c
--- a/drivers/serial/8250_pnp.c	Tue Jan 14 05:58:04 2003
+++ b/drivers/serial/8250_pnp.c	Sat Feb  1 16:52:08 2003
@@ -317,7 +317,7 @@
 {
 	unsigned int map = 0x1FF8;
 	struct pnp_irq *irq;
-	struct pnp_resources *res = dev->res;
+	struct pnp_resources *res = dev->possible;
 
 	serial8250_get_irq_map(&map);
 
@@ -357,10 +357,10 @@
  */
 static int serial_pnp_guess_board(struct pnp_dev *dev, int *flags)
 {
-	struct pnp_resources *res = dev->res;
+	struct pnp_resources *res = dev->possible;
 	struct pnp_resources *resa;
 
-	if (!(check_name(dev->name) || (dev->card && check_name(dev->card->name))))
+	if (!(check_name(dev->dev.name) || (dev->card && check_name(dev->card->dev.name))))
 		return -ENODEV;
 
 	if (!res)
diff -urN a/include/linux/ioport.h b/include/linux/ioport.h
--- a/include/linux/ioport.h	Tue Jan 14 05:58:23 2003
+++ b/include/linux/ioport.h	Sun Feb  2 11:51:32 2003
@@ -77,6 +77,7 @@
 #define IORESOURCE_MEM_8BIT		(0<<3)
 #define IORESOURCE_MEM_16BIT		(1<<3)
 #define IORESOURCE_MEM_8AND16BIT	(2<<3)
+#define IORESOURCE_MEM_32BIT		(3<<3)
 #define IORESOURCE_MEM_SHADOWABLE	(1<<5)	/* dup: IORESOURCE_SHADOWABLE */
 #define IORESOURCE_MEM_EXPANSIONROM	(1<<6)
 
diff -urN a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Tue Jan 14 05:59:30 2003
+++ b/include/linux/pnp.h	Sun Feb  9 09:42:10 2003
@@ -13,42 +13,144 @@
 #include <linux/list.h>
 #include <linux/errno.h>
 
+#define PNP_MAX_PORT		8
+#define PNP_MAX_MEM		4
+#define PNP_MAX_IRQ		2
+#define PNP_MAX_DMA		2
+#define PNP_MAX_DEVICES		8
+#define PNP_ID_LEN		8
+
+struct pnp_protocol;
+struct pnp_dev;
+
 
 /*
- * Device Managemnt
+ * Resource Management
  */
 
-#define DEVICE_COUNT_IRQ	2
-#define DEVICE_COUNT_DMA	2
-#define DEVICE_COUNT_IO		8
-#define DEVICE_COUNT_MEM	4
-#define MAX_DEVICES		8
+/* Use these instead of directly reading pnp_dev to get resource information */
+#define pnp_port_start(dev,bar)   ((dev)->res.port_resource[(bar)].start)
+#define pnp_port_end(dev,bar)     ((dev)->res.port_resource[(bar)].end)
+#define pnp_port_flags(dev,bar)   ((dev)->res.port_resource[(bar)].flags)
+#define pnp_port_valid(dev,bar)   (pnp_port_flags((dev),(bar)) & IORESOURCE_IO)
+#define pnp_port_len(dev,bar) \
+	((pnp_port_start((dev),(bar)) == 0 &&	\
+	  pnp_port_end((dev),(bar)) ==		\
+	  pnp_port_start((dev),(bar))) ? 0 :	\
+	  					\
+	 (pnp_port_end((dev),(bar)) -		\
+	  pnp_port_start((dev),(bar)) + 1))
 
-struct pnp_resource;
-struct pnp_protocol;
-struct pnp_id;
-struct pnp_cfg;
+#define pnp_mem_start(dev,bar)   ((dev)->res.mem_resource[(bar)].start)
+#define pnp_mem_end(dev,bar)     ((dev)->res.mem_resource[(bar)].end)
+#define pnp_mem_flags(dev,bar)   ((dev)->res.mem_resource[(bar)].flags)
+#define pnp_mem_valid(dev,bar)   (pnp_mem_flags((dev),(bar)) & IORESOURCE_MEM)
+#define pnp_mem_len(dev,bar) \
+	((pnp_mem_start((dev),(bar)) == 0 &&	\
+	  pnp_mem_end((dev),(bar)) ==		\
+	  pnp_mem_start((dev),(bar))) ? 0 :	\
+	  					\
+	 (pnp_mem_end((dev),(bar)) -		\
+	  pnp_mem_start((dev),(bar)) + 1))
+
+#define pnp_irq(dev,bar)	 ((dev)->res.irq_resource[(bar)].start)
+#define pnp_irq_flags(dev,bar)	 ((dev)->res.irq_resource[(bar)].flags)
+#define pnp_irq_valid(dev,bar)   (pnp_irq_flags((dev),(bar)) & IORESOURCE_IRQ)
+
+#define pnp_dma(dev,bar)	 ((dev)->res.dma_resource[(bar)].start)
+#define pnp_dma_flags(dev,bar)	 ((dev)->res.dma_resource[(bar)].flags)
+#define pnp_dma_valid(dev,bar)   (pnp_dma_flags((dev),(bar)) & IORESOURCE_DMA)
+
+#define PNP_PORT_FLAG_16BITADDR	(1<<0)
+#define PNP_PORT_FLAG_FIXED	(1<<1)
+
+struct pnp_port {
+	unsigned short min;		/* min base number */
+	unsigned short max;		/* max base number */
+	unsigned char align;		/* align boundary */
+	unsigned char size;		/* size of range */
+	unsigned char flags;		/* port flags */
+	unsigned char pad;		/* pad */
+	struct pnp_port *next;		/* next port */
+};
+
+struct pnp_irq {
+	unsigned short map;		/* bitmaks for IRQ lines */
+	unsigned char flags;		/* IRQ flags */
+	unsigned char pad;		/* pad */
+	struct pnp_irq *next;		/* next IRQ */
+};
+
+struct pnp_dma {
+	unsigned char map;		/* bitmask for DMA channels */
+	unsigned char flags;		/* DMA flags */
+	struct pnp_dma *next;		/* next port */
+};
+
+struct pnp_mem {
+	unsigned int min;		/* min base number */
+	unsigned int max;		/* max base number */
+	unsigned int align;		/* align boundary */
+	unsigned int size;		/* size of range */
+	unsigned char flags;		/* memory flags */
+	unsigned char pad;		/* pad */
+	struct pnp_mem *next;		/* next memory resource */
+};
+
+#define PNP_RES_PRIORITY_PREFERRED	0
+#define PNP_RES_PRIORITY_ACCEPTABLE	1
+#define PNP_RES_PRIORITY_FUNCTIONAL	2
+#define PNP_RES_PRIORITY_INVALID	65535
+
+struct pnp_resources {
+	unsigned short priority;	/* priority */
+	struct pnp_port *port;		/* first port */
+	struct pnp_irq *irq;		/* first IRQ */
+	struct pnp_dma *dma;		/* first DMA */
+	struct pnp_mem *mem;		/* first memory resource */
+	struct pnp_dev *dev;		/* parent */
+	struct pnp_resources *dep;	/* dependent resources */
+};
+
+struct pnp_rule_table {
+	int depnum;
+	struct pnp_port *port[PNP_MAX_PORT];
+	struct pnp_irq *irq[PNP_MAX_IRQ];
+	struct pnp_dma *dma[PNP_MAX_DMA];
+	struct pnp_mem *mem[PNP_MAX_MEM];
+};
+
+struct pnp_resource_table {
+	struct resource port_resource[PNP_MAX_PORT];
+	struct resource mem_resource[PNP_MAX_MEM];
+	struct resource dma_resource[PNP_MAX_DMA];
+	struct resource irq_resource[PNP_MAX_IRQ];
+};
+
+
+/*
+ * Device Managemnt
+ */
 
 struct pnp_card {
-	char name[80];
-	int status;			/* status of the card */
-	unsigned char number;		/* card number */
+	struct device dev;		/* Driver Model device interface */
+	unsigned char number;		/* used as an index, must be unique */
 	struct list_head global_list;	/* node in global list of cards */
 	struct list_head protocol_list;	/* node in protocol's list of cards */
 	struct list_head devices;	/* devices attached to the card */
+	struct list_head rdevs;		/* a list of devices requested by the card driver */
+	int status;
+
 	struct pnp_protocol * protocol;
+	struct pnpc_driver * driver;
 	struct pnp_id * id;		/* contains supported EISA IDs*/
 
+	void	      * protocol_data;	/* Used to store protocol specific data */
 	unsigned char	pnpver;		/* Plug & Play version */
 	unsigned char	productver;	/* product version */
 	unsigned int	serial;		/* serial number */
 	unsigned char	checksum;	/* if zero - checksum passed */
-	void	      * protocol_data;	/* Used to store protocol specific data */
-
-	struct pnpc_driver * driver;	/* pointer to the driver bound to this device */
-	struct list_head rdevs;		/* a list of devices requested by the card driver */
 	struct proc_dir_entry *procdir;	/* directory entry in /proc/bus/isapnp */
-	struct	device	dev;		/* Driver Model device interface */
 };
 
 #define global_to_pnp_card(n) list_entry(n, struct pnp_card, global_list)
@@ -58,10 +160,6 @@
 	for((card) = global_to_pnp_card(pnp_cards.next); \
 	(card) != global_to_pnp_card(&pnp_cards); \
 	(card) = global_to_pnp_card((card)->global_list.next))
-#define pnp_card_for_each_dev(card,dev) \
-	for((dev) = card_to_pnp_dev((card)->devices.next); \
-	(dev) != card_to_pnp_dev(&(card)->devices); \
-	(dev) = card_to_pnp_dev((dev)->card_list.next))
 
 static inline void *pnpc_get_drvdata (struct pnp_card *pcard)
 {
@@ -84,8 +182,9 @@
 }
 
 struct pnp_dev {
-	char name[80];			/* device name */
-	int active;			/* status of the device */
+	struct device dev;		/* Driver Model device interface */
+	unsigned char number;		/* used as an index, must be unique */
+	int active;
 	int capabilities;
 	int status;
 
@@ -93,24 +192,20 @@
 	struct list_head protocol_list;	/* node in list of device's protocol */
 	struct list_head card_list;	/* node in card's list of devices */
 	struct list_head rdev_list;	/* node in cards list of requested devices */
+
 	struct pnp_protocol * protocol;
-	struct pnp_card * card;
-	struct pnp_id * id;		/* contains supported EISA IDs*/
+	struct pnp_card * card;		/* card the device is attached to, none if NULL */
+	struct pnp_driver * driver;
+
+	struct pnp_id		      * id;		/* supported EISA IDs*/
+	struct pnp_resource_table	res;		/* contains the currently chosen resources */
+	struct pnp_resources	      * possible;	/* a list of possible resources */
+	struct pnp_rule_table	      * rule;		/* the current possible resource set */
+	int 				config_mode;	/* flags that determine how the device's resources should be configured */
 
 	void * protocol_data;		/* Used to store protocol specific data */
-	unsigned char number;		/* must be unique */
 	unsigned short	regs;		/* ISAPnP: supported registers */
-	
-	struct pnp_resources *res;	/* possible resource information */
-	int lock_resources;		/* resources are locked */
-	struct resource io_resource[DEVICE_COUNT_IO];   /* port regions */
-	struct resource mem_resource[DEVICE_COUNT_MEM]; /* memory regions + expansion ROMs */
-	struct resource dma_resource[DEVICE_COUNT_DMA];
-	struct resource irq_resource[DEVICE_COUNT_IRQ];
-
-	struct pnp_driver * driver;	/* pointer to the driver bound to this device */
-	struct	device	    dev;	/* Driver Model device interface */
-	int		    flags;	/* used by protocols */
+	int 		flags;		/* used by protocols */
 	struct proc_dir_entry *procent;	/* device entry in /proc/bus/isapnp */
 };
 
@@ -119,13 +214,14 @@
 #define protocol_to_pnp_dev(n) list_entry(n, struct pnp_dev, protocol_list)
 #define	to_pnp_dev(n) container_of(n, struct pnp_dev, dev)
 #define pnp_for_each_dev(dev) \
-	for(dev = global_to_pnp_dev(pnp_global.next); \
-	dev != global_to_pnp_dev(&pnp_global); \
-	dev = global_to_pnp_dev(dev->global_list.next))
+	for((dev) = global_to_pnp_dev(pnp_global.next); \
+	(dev) != global_to_pnp_dev(&pnp_global); \
+	(dev) = global_to_pnp_dev((dev)->global_list.next))
 #define card_for_each_dev(card,dev) \
 	for((dev) = card_to_pnp_dev((card)->devices.next); \
 	(dev) != card_to_pnp_dev(&(card)->devices); \
 	(dev) = card_to_pnp_dev((dev)->card_list.next))
+#define pnp_dev_name(dev) (dev)->dev.name
 
 static inline void *pnp_get_drvdata (struct pnp_dev *pdev)
 {
@@ -152,6 +248,12 @@
 	void (*quirk_function)(struct pnp_dev *dev);	/* fixup function */
 };
 
+/* config modes */
+#define PNP_CONFIG_AUTO		0x0001	/* Use the Resource Configuration Engine to determine resource settings */
+#define PNP_CONFIG_MANUAL	0x0002	/* the config has been manually specified */
+#define PNP_CONFIG_FORCE	0x0004	/* disables validity checking */
+#define PNP_CONFIG_INVALID	0x0008	/* If this flag is set, the pnp layer will refuse to activate the device */
+
 /* capabilities */
 #define PNP_READ		0x0001
 #define PNP_WRITE		0x0002
@@ -165,14 +267,14 @@
 				 ((dev)->capabilities & PNP_WRITE))
 #define pnp_can_disable(dev)	(((dev)->protocol) && ((dev)->protocol->disable) && \
 				 ((dev)->capabilities & PNP_DISABLE))
-#define pnp_can_configure(dev)	((!(dev)->active) && ((dev)->capabilities & PNP_CONFIGURABLE))
+#define pnp_can_configure(dev)	((!(dev)->active) && ((dev)->config_mode & PNP_CONFIG_AUTO) && \
+				 ((dev)->capabilities & PNP_CONFIGURABLE))
 
 /* status */
-#define PNP_INIT		0x0000
-#define PNP_READY		0x0001
-#define PNP_ATTACHED		0x0002
-#define PNP_BUSY		0x0004
-#define PNP_FAULTY		0x0008
+#define PNP_READY		0x0000
+#define PNP_ATTACHED		0x0001
+#define PNP_BUSY		0x0002
+#define PNP_FAULTY		0x0004
 
 
 /*
@@ -180,21 +282,21 @@
  */
 
 struct pnp_id {
-	char id[7];
+	char id[PNP_ID_LEN];
 	struct pnp_id * next;
 };
 
 struct pnp_device_id {
-	char id[7];
+	char id[PNP_ID_LEN];
 	unsigned long driver_data;	/* data private to the driver */
 };
 
-struct pnp_card_device_id {
-	char id[7];
+struct pnp_card_id {
+	char id[PNP_ID_LEN];
 	unsigned long driver_data;	/* data private to the driver */
 	struct {
-		char id[7];
-	} devs[MAX_DEVICES];		/* logical devices */
+		char id[PNP_ID_LEN];
+	} devs[PNP_MAX_DEVICES];	/* logical devices */
 };
 
 #define PNP_DRIVER_DO_NOT_ACTIVATE	(1<<0)
@@ -216,9 +318,9 @@
 struct pnpc_driver {
 	struct list_head node;
 	char *name;
-	const struct pnp_card_device_id *id_table;
+	const struct pnp_card_id *id_table;
 	unsigned int flags;
-	int  (*probe)  (struct pnp_card *card, const struct pnp_card_device_id *card_id);
+	int  (*probe)  (struct pnp_card *card, const struct pnp_card_id *card_id);
 	void (*remove) (struct pnp_card *card);
 	struct device_driver driver;
 };
@@ -227,135 +329,16 @@
 
 
 /*
- * Resource Management
- */
-
-#define pnp_flags_valid(resrc)	(((resrc)->flags & IORESOURCE_UNSET) == 0 && \
-				 ((resrc)->flags & (IORESOURCE_IO|IORESOURCE_MEM|IORESOURCE_IRQ|IORESOURCE_DMA)) != 0)
-
-/* Use these instead of directly reading pnp_dev to get resource information */
-#define pnp_port_start(dev,bar)	((dev)->io_resource[(bar)].start)
-#define pnp_port_end(dev,bar)	((dev)->io_resource[(bar)].end)
-#define pnp_port_flags(dev,bar)	((dev)->io_resource[(bar)].flags)
-#define pnp_port_valid(dev,bar)	pnp_flags_valid(&(dev)->io_resource[(bar)])
-#define pnp_port_len(dev,bar) \
-	((pnp_port_start((dev),(bar)) == 0 &&	\
-	  pnp_port_end((dev),(bar)) ==		\
-	  pnp_port_start((dev),(bar))) ? 0 :	\
-	  					\
-	 (pnp_port_end((dev),(bar)) -		\
-	  pnp_port_start((dev),(bar)) + 1))
-
-#define pnp_mem_start(dev,bar)	((dev)->mem_resource[(bar)].start)
-#define pnp_mem_end(dev,bar)	((dev)->mem_resource[(bar)].end)
-#define pnp_mem_flags(dev,bar)	((dev)->mem_resource[(bar)].flags)
-#define pnp_mem_valid(dev,bar)	pnp_flags_valid(&(dev)->mem_resource[(bar)])
-#define pnp_mem_len(dev,bar) \
-	((pnp_mem_start((dev),(bar)) == 0 &&	\
-	  pnp_mem_end((dev),(bar)) ==		\
-	  pnp_mem_start((dev),(bar))) ? 0 :	\
-	  					\
-	 (pnp_mem_end((dev),(bar)) -		\
-	  pnp_mem_start((dev),(bar)) + 1))
-
-#define pnp_irq(dev,bar)	((dev)->irq_resource[(bar)].start)
-#define pnp_irq_flags(dev,bar)	((dev)->irq_resource[(bar)].flags)
-#define pnp_irq_valid(dev,bar)	pnp_flags_valid(&(dev)->irq_resource[(bar)])
-
-#define pnp_dma(dev,bar)	((dev)->dma_resource[(bar)].start)
-#define pnp_dma_flags(dev,bar)	((dev)->dma_resource[(bar)].flags)
-#define pnp_dma_valid(dev,bar)	pnp_flags_valid(&(dev)->dma_resource[(bar)])
-
-#define PNP_PORT_FLAG_16BITADDR	(1<<0)
-#define PNP_PORT_FLAG_FIXED	(1<<1)
-
-struct pnp_port {
-	unsigned short min;		/* min base number */
-	unsigned short max;		/* max base number */
-	unsigned char align;		/* align boundary */
-	unsigned char size;		/* size of range */
-	unsigned char flags;		/* port flags */
-	unsigned char pad;		/* pad */
-	struct pnp_resources *res;	/* parent */
-	struct pnp_port *next;		/* next port */
-};
-
-struct pnp_irq {
-	unsigned short map;		/* bitmaks for IRQ lines */
-	unsigned char flags;		/* IRQ flags */
-	unsigned char pad;		/* pad */
-	struct pnp_resources *res;	/* parent */
-	struct pnp_irq *next;		/* next IRQ */
-};
-
-struct pnp_dma {
-	unsigned char map;		/* bitmask for DMA channels */
-	unsigned char flags;		/* DMA flags */
-	struct pnp_resources *res;	/* parent */
-	struct pnp_dma *next;		/* next port */
-};
-
-struct pnp_mem {
-	unsigned int min;		/* min base number */
-	unsigned int max;		/* max base number */
-	unsigned int align;		/* align boundary */
-	unsigned int size;		/* size of range */
-	unsigned char flags;		/* memory flags */
-	unsigned char pad;		/* pad */
-	struct pnp_resources *res;	/* parent */
-	struct pnp_mem *next;		/* next memory resource */
-};
-
-struct pnp_mem32 {
-	unsigned char data[17];
-	struct pnp_resources *res;	/* parent */
-	struct pnp_mem32 *next;		/* next 32-bit memory resource */
-};
-
-#define PNP_RES_PRIORITY_PREFERRED	0
-#define PNP_RES_PRIORITY_ACCEPTABLE	1
-#define PNP_RES_PRIORITY_FUNCTIONAL	2
-#define PNP_RES_PRIORITY_INVALID	65535
-
-struct pnp_resources {
-	unsigned short priority;	/* priority */
-	unsigned short dependent;	/* dependent resources */
-	struct pnp_port *port;		/* first port */
-	struct pnp_irq *irq;		/* first IRQ */
-	struct pnp_dma *dma;		/* first DMA */
-	struct pnp_mem *mem;		/* first memory resource */
-	struct pnp_mem32 *mem32;	/* first 32-bit memory */
-	struct pnp_dev *dev;		/* parent */
-	struct pnp_resources *dep;	/* dependent resources */
-};
-
-struct pnp_res_cfg {
-	struct resource io_resource[DEVICE_COUNT_IO];	/* I/O ports */
-	struct resource mem_resource[DEVICE_COUNT_MEM]; /* memory regions + expansion ROMs */
-	struct resource dma_resource[DEVICE_COUNT_DMA];
-	struct resource irq_resource[DEVICE_COUNT_IRQ];
-};
-
-struct pnp_cfg {
-	struct pnp_port *port[8];
-	struct pnp_irq *irq[2];
-	struct pnp_dma *dma[2];
-	struct pnp_mem *mem[4];
-	struct pnp_res_cfg request;
-};
-
-
-/* 
  * Protocol Management
  */
 
 struct pnp_protocol {
 	struct list_head	protocol_list;
-	char			name[DEVICE_NAME_SIZE];
+	char		      * name;
 
-	/* functions */
-	int (*get)(struct pnp_dev *dev);
-	int (*set)(struct pnp_dev *dev, struct pnp_cfg *config);
+	/* resource control functions */
+	int (*get)(struct pnp_dev *dev, struct pnp_resource_table *res);
+	int (*set)(struct pnp_dev *dev, struct pnp_resource_table *res);
 	int (*disable)(struct pnp_dev *dev);
 
 	/* used by pnp layer only (look but don't touch) */
@@ -384,6 +367,8 @@
 int pnp_add_device(struct pnp_dev *dev);
 void pnp_remove_device(struct pnp_dev *dev);
 extern struct list_head pnp_global;
+int pnp_device_attach(struct pnp_dev *pnp_dev);
+void pnp_device_detach(struct pnp_dev *pnp_dev);
 
 /* resource */
 struct pnp_resources * pnp_build_resource(struct pnp_dev *dev, int dependent);
@@ -393,29 +378,42 @@
 int pnp_add_dma_resource(struct pnp_dev *dev, int depnum, struct pnp_dma *data);
 int pnp_add_port_resource(struct pnp_dev *dev, int depnum, struct pnp_port *data);
 int pnp_add_mem_resource(struct pnp_dev *dev, int depnum, struct pnp_mem *data);
-int pnp_add_mem32_resource(struct pnp_dev *dev, int depnum, struct pnp_mem32 *data);
-int pnp_init_res_cfg(struct pnp_res_cfg *template);
-int pnp_activate_dev(struct pnp_dev *dev, struct pnp_res_cfg *template);
+void pnp_init_resource_table(struct pnp_resource_table *table);
+int pnp_generate_rule(struct pnp_dev * dev, int depnum, struct pnp_rule_table * rule);
+
+/* manager */
+int pnp_activate_dev(struct pnp_dev *dev);
 int pnp_disable_dev(struct pnp_dev *dev);
-int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, struct pnp_res_cfg *template);
 void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size);
+int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode);
+int pnp_auto_config_dev(struct pnp_dev *dev);
 
 /* driver */
 int compare_pnp_id(struct pnp_id * pos, const char * id);
 int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev);
 int pnp_register_driver(struct pnp_driver *drv);
 void pnp_unregister_driver(struct pnp_driver *drv);
-int pnp_device_attach(struct pnp_dev *pnp_dev);
-void pnp_device_detach(struct pnp_dev *pnp_dev);
+
+/* support */
+int pnp_is_active(struct pnp_dev * dev);
+unsigned char * pnp_parse_current_resources(unsigned char * p, unsigned char * end, struct pnp_resource_table * res);
+unsigned char * pnp_parse_possible_resources(unsigned char * p, unsigned char * end, struct pnp_dev * dev);
+unsigned char * pnp_write_resources(unsigned char * p, unsigned char * end, struct pnp_resource_table * res);
 
 #else
 
 /* just in case anyone decides to call these without PnP Support Enabled */
+
+/* core */
 static inline int pnp_register_protocol(struct pnp_protocol *protocol) { return -ENODEV; }
 static inline void pnp_unregister_protocol(struct pnp_protocol *protocol) { }
 static inline int pnp_init_device(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_add_device(struct pnp_dev *dev) { return -ENODEV; }
 static inline void pnp_remove_device(struct pnp_dev *dev) { }
+static inline int pnp_device_attach(struct pnp_dev *pnp_dev) { return -ENODEV; }
+static inline void pnp_device_detach(struct pnp_dev *pnp_dev) { ; }
+
+/* resource */
 static inline struct pnp_resources * pnp_build_resource(struct pnp_dev *dev, int dependent) { return NULL; }
 static inline struct pnp_resources * pnp_find_resources(struct pnp_dev *dev, int depnum) { return NULL; }
 static inline int pnp_get_max_depnum(struct pnp_dev *dev) { return -ENODEV; }
@@ -423,19 +421,27 @@
 static inline int pnp_add_dma_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
 static inline int pnp_add_port_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
 static inline int pnp_add_mem_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
-static inline int pnp_add_mem32_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
-static inline int pnp_init_res_cfg(struct pnp_res_cfg *template) { return -ENODEV; }
-static inline int pnp_activate_dev(struct pnp_dev *dev, struct pnp_res_cfg *template) { return -ENODEV; }
+static inline void pnp_init_resource_table(struct pnp_resource_table *table) { ; }
+static inline int pnp_generate_rule(struct pnp_dev * dev, int depnum, struct pnp_rule_table * rule) { return -ENODEV; }
+
+/* manager */
+static inline int pnp_activate_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; }
-static inline int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, struct pnp_res_cfg *template) { return -ENODEV; }
 static inline void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size) { ; }
+static inline int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode) { return -ENODEV; }
+static inline int pnp_auto_config_dev(struct pnp_dev *dev) { return -ENODEV; }
+
+/* driver */
 static inline int compare_pnp_id(struct list_head * id_list, const char * id) { return -ENODEV; }
 static inline int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_register_driver(struct pnp_driver *drv) { return -ENODEV; }
 static inline void pnp_unregister_driver(struct pnp_driver *drv) { ; }
 
-static inline int pnp_device_attach(struct pnp_dev *pnp_dev) { return -ENODEV; }
-static inline void pnp_device_detach(struct pnp_dev *pnp_dev) { ; }
+/* support */
+static inline int pnp_is_active(struct pnp_dev * dev) { return -ENODEV; )
+static inline unsigned char * pnp_parse_current_resources(unsigned char * p, unsigned char * end, struct pnp_resource_table * res) { return NULL; }
+static inline unsigned char * pnp_parse_possible_resources(unsigned char * p, unsigned char * end, struct pnp_dev * dev) { return NULL; }
+static inline unsigned char * pnp_write_resources(unsigned char * p, unsigned char * end, struct pnp_resource_table * res) { return NULL; )
 
 #endif /* CONFIG_PNP */
 
@@ -458,6 +464,7 @@
 
 #else
 
+/* card */
 static inline int pnpc_add_card(struct pnp_card *card) { return -ENODEV; }
 static inline void pnpc_remove_card(struct pnp_card *card) { ; }
 static inline int pnpc_add_device(struct pnp_card *card, struct pnp_dev *dev) { return -ENODEV; }
@@ -467,11 +474,12 @@
 static inline int pnpc_register_driver(struct pnpc_driver *drv) { return -ENODEV; }
 static inline void pnpc_unregister_driver(struct pnpc_driver *drv) { ; }
 static inline int pnpc_add_id(struct pnp_id *id, struct pnp_card *card) { return -ENODEV; }
-static inline int pnpc_attach(struct pnp_card *card) { return -ENODEV; }
-static inline void pnpc_detach(struct pnp_card *card) { ; }
 
 #endif /* CONFIG_PNP_CARD */
 
+#define pnp_err(format, arg...) printk(KERN_ERR "pnp: " format "\n" , ## arg)
+#define pnp_info(format, arg...) printk(KERN_INFO "pnp: " format "\n" , ## arg)
+#define pnp_warn(format, arg...) printk(KERN_WARNING "pnp: " format "\n" , ## arg)
 
 #ifdef DEBUG
 #define pnp_dbg(format, arg...) printk(KERN_DEBUG "pnp: " format "\n" , ## arg)
