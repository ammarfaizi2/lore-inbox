Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266527AbSL2LZl>; Sun, 29 Dec 2002 06:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266528AbSL2LZl>; Sun, 29 Dec 2002 06:25:41 -0500
Received: from gate.perex.cz ([194.212.165.105]:15376 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S266527AbSL2LZG>;
	Sun, 29 Dec 2002 06:25:06 -0500
Date: Sun, 29 Dec 2002 12:20:15 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Adam Belay <ambx1@neo.rr.com>
cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: [PATCH] proposed PnP layer changes/fixes and cleanups
Message-ID: <Pine.LNX.4.33.0212201557270.824-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I've revised the PnP code and found numerous of simple bugs. Also,
my opinion is that the resctriction of resources to only ones hardcoded by
hardware vendors is not a good idea. Hardware usually supports more
configurations (especially ISA PnP devices).
	I've tried to implement a configuration template, so driver can
pass it's own resource map in the probe phase. Also, I've added a new
member to the driver structures - flags. The flag
PNP_DRIVER_DO_NOT_ACTIVATE instructs the pnp code that the device
shouldn't be activated before the probe() callback is entered. It's
necessary to implement this behaviour to allow passing of a new
configuration template (thus calling pnp_activate_dev() from the probe()
callback).
	Also, the resources can be locked now (I've changed the ro flag to 
lock_resources).

						Jaroslav

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.901, 2002-12-26 16:56:19+01:00, perex@suse.cz
  PnP update
    - added configuration templates - configuration can be changed from the probe() callback
    - new PnP ID - NSC6001
    - fixes in PnP BIOS code - no more oopses
    - fixed typos and thinkos in 8250_pnp.c


 Documentation/isapnp.txt   |  193 +--------------------------------------------
 drivers/pnp/card.c         |   14 ++-
 drivers/pnp/core.c         |    3 
 drivers/pnp/driver.c       |   16 ++-
 drivers/pnp/idlist.h       |    3 
 drivers/pnp/interface.c    |   20 ++++
 drivers/pnp/isapnp/core.c  |    4 
 drivers/pnp/pnpbios/core.c |   27 +++---
 drivers/pnp/resource.c     |  107 +++++++++++++++++-------
 drivers/serial/8250_pnp.c  |    7 +
 include/linux/pnp.h        |   35 ++++++--
 11 files changed, 176 insertions(+), 253 deletions(-)


diff -Nru a/Documentation/isapnp.txt b/Documentation/isapnp.txt
--- a/Documentation/isapnp.txt	Thu Dec 26 19:45:04 2002
+++ b/Documentation/isapnp.txt	Thu Dec 26 19:45:04 2002
@@ -4,199 +4,11 @@
 Interface /proc/isapnp
 ======================
 
-Read commands:
---------------
+The interface has been removed. See pnp.txt for more details.
 
-No comment.
-
-Write commands:
----------------
-
-With the write interface you can activate or modify the configuration of
-ISA Plug & Play devices.  It is mainly useful for drivers which have not
-been rewritten to use the ISA Plug & Play kernel support yet.
-
-card <idx> <vendor>	- select PnP device by vendor identification
-csn <CSN>		- select PnP device by CSN
-dev <idx> <logdev>	- select logical device
-auto			- run autoconfigure
-activate		- activate logical device
-deactivate		- deactivate logical device
-port <idx> <value>	- set port 0-7 to value
-irq <idx> <value>	- set IRQ 0-1 to value
-dma <idx> <value>	- set DMA 0-1 to value
-memory <idx> <value>	- set memory 0-3 to value
-poke <reg> <value>	- poke configuration byte to selected register
-pokew <reg> <value>	- poke configuration word to selected register
-poked <reg> <value>	- poke configuration dword to selected register
-allow_dma0 <value>	- allow dma channel 0 during auto activation: 0=off, 1=on
-
-Explanation:
-	- variable <idx> begins with zero
-	- variable <CSN> begins with one
-	- <vendor> is in the standard format 'ABC1234'
-	- <logdev> is in the standard format 'ABC1234'
-
-Example:
-
-cat > /proc/isapnp <<EOF
-card 0 CSC7537
-dev 0 CSC0000
-port 0 0x534
-port 1 0x388
-port 2 0x220
-irq 0 5
-dma 0 1
-dma 1 3
-poke 0x70 9
-activate
-logdev 0 CSC0001
-port 0 0x240
-activate
-EOF
-
-
-Information for developers
+Interface /proc/bus/isapnp
 ==========================
 
-Finding a device
-----------------
-
-extern struct pci_bus *isapnp_find_card(unsigned short vendor,
-                                        unsigned short device,
-                                        struct pci_bus *from);
-
-This function finds an ISA PnP card.  For the vendor argument, the
-ISAPNP_VENDOR(a,b,c) macro should be used, where a,b,c are characters or
-integers.  For the device argument the ISAPNP_DEVICE(x) macro should be
-used, where x is an integer value.  Both vendor and device arguments
-can be taken from contents of the /proc/isapnp file.
-
-extern struct pci_dev *isapnp_find_dev(struct pci_bus *card,
-                                       unsigned short vendor,
-                                       unsigned short function,
-                                       struct pci_dev *from);
-
-This function finds an ISA PnP device. If card is NULL, then the global
-search mode is used (all devices are used for the searching).  Otherwise
-only devices which belong to the specified card are checked.  For the
-function number the ISAPNP_FUNCTION(x) macro can be used; it works
-similarly to the ISAPNP_DEVICE(x) macro.
-
-extern int isapnp_probe_cards(const struct isapnp_card_id *ids,
-                              int (*probe)(struct pci_bus *card,
-                              const struct isapnp_card_id *id));
-
-
-This function is a helper for drivers which need to use more than
-one device from an ISA PnP card.  The probe callback is called with
-appropriate arguments for each card.
-
-Example for ids parameter initialization:
-
-static struct isapnp_card_id card_ids[] __devinitdata = {
-	{
-        	ISAPNP_CARD_ID('A','D','V', 0x550a),
-                devs: {
-			ISAPNP_DEVICE_ID('A', 'D', 'V', 0x0010),
-			ISAPNP_DEVICE_ID('A', 'D', 'V', 0x0011)
-		},
-		driver_data: 0x1234,
-	},
-	{
-		ISAPNP_CARD_END,
-	}
-};
-ISAPNP_CARD_TABLE(card_ids);
-
-extern int isapnp_probe_devs(const struct isapnp_device_id *ids,
-                             int (*probe)(struct pci_bus *card,
-                             const struct isapnp_device_id *id));
-
-
-This function is a helper for drivers which need to use one
-device from an ISA PnP card.  The probe callback is called with
-appropriate arguments for each matched device.
-
-Example for ids parameter initialization:
-
-static struct isapnp_device_id device_ids[] __devinitdata = {
-	{ ISAPNP_DEVICE_SINGLE('E','S','S', 0x0968, 'E','S','S', 0x0968), },
-	{ ISAPNP_DEVICE_SINGLE_END, }
-};
-MODULE_DEVICE_TABLE(isapnp, device_ids);
-
-
-ISA PnP configuration
-=====================
-
-There are two ways in which the ISA PnP interface can be used.
-
-First way: low-level
---------------------
-
-All ISA PNP configuration registers are accessible via the low-level
-isapnp_(read|write)_(byte|word|dword) functions.
-
-The function isapnp_cfg_begin() must be called before any lowlevel function.
-The function isapnp_cfg_end() must be always called after configuration
-otherwise the access to the ISA PnP configuration functions will be blocked.
-
-Second way: auto-configuration
-------------------------------
-
-This feature gives to the driver the real power of the ISA PnP driver.
-The function dev->prepare() initializes the resource members in the device
-structure.  This structure contains all resources set to auto configuration
-values after the initialization.  The device driver may modify some resources
-to skip the auto configuration for a given resource.
-
-Once the device structure contains all requested resource values, the function
-dev->activate() must be called to assign free resources to resource members
-with the auto configuration value.
-
-Function dev->activate() does:
-   - resources with the auto configuration value are configured
-   - the auto configuration is created using ISA PnP resource map
-   - the function writes configuration to ISA PnP configuration registers
-   - the function returns to the caller actual used resources
-
-When the device driver is removed, function dev->deactivate() has to be
-called to free all assigned resources.
-
-Example (game port initialization)
-==================================
-
-/*** initialization ***/
-
-	struct pci_dev *dev;
-
-	/* find the first game port, use standard PnP IDs */
-	dev = isapnp_find_dev(NULL,
-			      ISAPNP_VENDOR('P','N','P'),
-			      ISAPNP_FUNCTION(0xb02f),
-			      NULL);
-	if (!dev)
-		return -ENODEV;
-	if (dev->active)
-		return -EBUSY;
-	if (dev->prepare(dev)<0)
-		return -EAGAIN;
-	if (!(dev->resource[0].flags & IORESOURCE_IO))
-		return -ENODEV;
-	if (!dev->ro) {
-		/* override resource */
-		if (user_port != USER_PORT_AUTO_VALUE)
-			isapnp_resource_change(&dev->resource[0], user_port, 1);
-	}
-	if (dev->activate(dev)<0) {
-		printk("isapnp configure failed (out of resources?)\n");
-		return -ENOMEM;
-	}
-	user_port = dev->resource[0].start;		/* get real port */
-
-/*** deactivation ***/
-
-	/* to deactivate use: */
- 	if (dev)
- 		dev->deactivate(dev);
+This directory allows access to ISA PnP cards and logical devices.
+The regular files contain the contents of ISA PnP registers for
+a logical device.
diff -Nru a/drivers/pnp/card.c b/drivers/pnp/card.c
--- a/drivers/pnp/card.c	Thu Dec 26 19:45:04 2002
+++ b/drivers/pnp/card.c	Thu Dec 26 19:45:04 2002
@@ -192,6 +192,7 @@
 {
 	struct list_head *pos;
 	struct pnp_dev *dev;
+	struct pnpc_driver *cdrv;
 	if (!card || !id)
 		goto done;
 	if (!from) {
@@ -212,9 +213,16 @@
 	return NULL;
 
 found:
-	if (dev->active == 0)
-		if(pnp_activate_dev(dev)<0)
-			return NULL;
+	cdrv = to_pnpc_driver(card->dev.driver);
+	if (dev->active == 0) {
+		if (!(cdrv->flags & PNPC_DRIVER_DO_NOT_ACTIVATE)) {
+			if(pnp_activate_dev(dev,NULL)<0)
+				return NULL;
+		}
+	} else {
+		if ((cdrv->flags & PNPC_DRIVER_DO_NOT_ACTIVATE))
+			pnp_disable_dev(dev);
+	}
 	spin_lock(&pnp_lock);
 	list_add_tail(&dev->rdev_list, &card->rdevs);
 	spin_unlock(&pnp_lock);
diff -Nru a/drivers/pnp/core.c b/drivers/pnp/core.c
--- a/drivers/pnp/core.c	Thu Dec 26 19:45:04 2002
+++ b/drivers/pnp/core.c	Thu Dec 26 19:45:04 2002
@@ -115,7 +115,8 @@
 	int error = 0;
 	pnp_name_device(dev);
 	pnp_fixup_device(dev);
-	strcpy(dev->dev.name,dev->name);
+	strncpy(dev->dev.name,dev->name,DEVICE_NAME_SIZE-1);
+	dev->dev.name[DEVICE_NAME_SIZE-1] = '\0';
 	dev->dev.bus = &pnp_bus_type;
 	dev->dev.release = &pnp_release_device;
 	error = device_register(&dev->dev);
diff -Nru a/drivers/pnp/driver.c b/drivers/pnp/driver.c
--- a/drivers/pnp/driver.c	Thu Dec 26 19:45:04 2002
+++ b/drivers/pnp/driver.c	Thu Dec 26 19:45:04 2002
@@ -66,7 +66,7 @@
 
 static int pnp_device_probe(struct device *dev)
 {
-	int error = 0;
+	int error;
 	struct pnp_driver *pnp_drv;
 	struct pnp_dev *pnp_dev;
 	const struct pnp_device_id *dev_id = NULL;
@@ -75,9 +75,17 @@
 
 	pnp_dbg("pnp: match found with the PnP device '%s' and the driver '%s'", dev->bus_id,pnp_drv->name);
 
-	if (pnp_dev->active == 0)
-		if(pnp_activate_dev(pnp_dev)<0)
-			return -1;
+	if (pnp_dev->active == 0) {
+		if (!(pnp_drv->flags & PNP_DRIVER_DO_NOT_ACTIVATE)) {
+			error = pnp_activate_dev(pnp_dev, NULL);
+			if (error < 0)
+				return error;
+		}
+	} else {
+		if ((pnp_drv->flags & PNP_DRIVER_DO_NOT_ACTIVATE))
+			pnp_disable_dev(pnp_dev);
+	}
+	error = 0;
 	if (pnp_drv->probe && pnp_dev->active) {
 		dev_id = match_device(pnp_drv, pnp_dev);
 		if (dev_id != NULL)
diff -Nru a/drivers/pnp/idlist.h b/drivers/pnp/idlist.h
--- a/drivers/pnp/idlist.h	Thu Dec 26 19:45:04 2002
+++ b/drivers/pnp/idlist.h	Thu Dec 26 19:45:04 2002
@@ -5,6 +5,7 @@
 ID("IBM3780", "IBM pointing device")
 ID("IBM0071", "IBM infrared communications device")
 ID("IBM3760", "IBM DSP")
+ID("NSC6001", "National Semiconductor Serial Port with Fast IR")
 ID("PNP0000", "AT Interrupt Controller")
 ID("PNP0001", "EISA Interrupt Controller")
 ID("PNP0002", "MCA Interrupt Controller")
@@ -54,6 +55,7 @@
 ID("PNP0603", "Generic IDE supporting Microsoft Device Bay Specification")
 ID("PNP0700", "PC standard floppy disk controller")
 ID("PNP0701", "Standard floppy controller supporting MS Device Bay Spec")
+ID("PNP0802", "Microsoft Sound System or Compatible Device (obsolete)")
 ID("PNP0900", "VGA Compatible")
 ID("PNP0901", "Video Seven VRAM/VRAM II/1024i")
 ID("PNP0902", "8514/A Compatible")
@@ -151,7 +153,6 @@
 ID("PNP0f1d", "Compaq LTE Trackball Serial Mouse")
 ID("PNP0f1e", "Microsoft Kids Trackball Mouse")
 ID("PNP8001", "Novell/Anthem NE3200")
-ID("PNP0802", "Microsoft Sound System or Compatible Device (obsolete)")
 ID("PNP8004", "Compaq NE3200")
 ID("PNP8006", "Intel EtherExpress/32")
 ID("PNP8008", "HP EtherTwist EISA LAN Adapter/32 (HP27248A)")
diff -Nru a/drivers/pnp/interface.c b/drivers/pnp/interface.c
--- a/drivers/pnp/interface.c	Thu Dec 26 19:45:04 2002
+++ b/drivers/pnp/interface.c	Thu Dec 26 19:45:04 2002
@@ -295,12 +295,28 @@
 	num_args = sscanf(buf,"%10s %i %10s",command,&depnum,type);
 	if (!num_args)
 		goto done;
+	if (!strnicmp(command,"lock",4)) {
+		if (dev->active) {
+			dev->lock_resources = 1;
+		} else {
+			error = -EINVAL;
+		}
+		goto done;
+	}
+	if (!strnicmp(command,"unlock",6)) {
+		if (dev->lock_resources) {
+			dev->lock_resources = 0;
+		} else {
+			error = -EINVAL;
+		}
+		goto done;
+	}
 	if (!strnicmp(command,"disable",7)) {
 		error = pnp_disable_dev(dev);
 		goto done;
 	}
 	if (!strnicmp(command,"auto",4)) {
-		error = pnp_activate_dev(dev);
+		error = pnp_activate_dev(dev,NULL);
 		goto done;
 	}
 	if (!strnicmp(command,"manual",6)) {
@@ -308,7 +324,7 @@
 			goto done;
 		if (!strnicmp(type,"static",6))
 			mode = PNP_STATIC;
-		error = pnp_raw_set_dev(dev,depnum,mode);
+		error = pnp_raw_set_dev(dev,depnum,NULL,mode);
 		goto done;
 	}
  done:
diff -Nru a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	Thu Dec 26 19:45:04 2002
+++ b/drivers/pnp/isapnp/core.c	Thu Dec 26 19:45:04 2002
@@ -631,7 +631,7 @@
  */
 
 static int __init isapnp_create_device(struct pnp_card *card,
-					   unsigned short size)
+				       unsigned short size)
 {
 	int number = 0, skip = 0, depnum = 0, dependent = 0, compat = 0;
 	unsigned char type, tmp[17];
@@ -947,7 +947,7 @@
 	int idx;
 	if (dev == NULL)
 		return -EINVAL;
-	if (dev->active || dev->ro)
+	if (dev->active || dev->lock_resources)
 		return -EBUSY;
 	for (idx = 0; idx < DEVICE_COUNT_IRQ; idx++) {
 		dev->irq_resource[idx].name = NULL;
diff -Nru a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	Thu Dec 26 19:45:04 2002
+++ b/drivers/pnp/pnpbios/core.c	Thu Dec 26 19:45:04 2002
@@ -1058,6 +1058,7 @@
 static void node_id_data_to_dev(unsigned char *p, struct pnp_bios_node *node, struct pnp_dev *dev)
 {
 	int len;
+	char id[8];
 	struct pnp_id *dev_id;
 
 	if ((char *)p == NULL)
@@ -1083,7 +1084,9 @@
 			dev_id =  pnpbios_kmalloc(sizeof (struct pnp_id), GFP_KERNEL);
 			if (!dev_id)
 				return;
-			pnpid32_to_pnpid(p[1] | p[2] << 8 | p[3] << 16 | p[4] << 24,dev_id->id);
+			memset(dev_id, 0, sizeof(struct pnp_id));
+			pnpid32_to_pnpid(p[1] | p[2] << 8 | p[3] << 16 | p[4] << 24,id);
+			memcpy(&dev_id->id, id, 7);
 			pnp_add_id(dev_id, dev);
 			break;
                 }
@@ -1258,7 +1261,7 @@
 	struct pnp_bios_node * node;
 		
 	/* just in case */
-	if(dev->driver)
+	if(pnp_dev_has_driver(dev))
 		return -EBUSY;
 	if(!pnp_is_dynamic(dev))
 		return -EPERM;
@@ -1281,7 +1284,7 @@
 	struct pnp_bios_node * node;
 
 	/* just in case */
-	if(dev->driver)
+	if(pnp_dev_has_driver(dev))
 		return -EBUSY;
 	if (flags == PNP_DYNAMIC && !pnp_is_dynamic(dev))
 		return -EPERM;
@@ -1335,7 +1338,7 @@
 	if (!config)
 		return -1;
 	/* just in case */
-	if(dev->driver)
+	if(pnp_dev_has_driver(dev))
 		return -EBUSY;
 	if(dev->flags & PNP_NO_DISABLE || !pnp_is_dynamic(dev))
 		return -EPERM;
@@ -1396,7 +1399,7 @@
 static void __init build_devlist(void)
 {
 	u8 nodenum;
-	char id[7];
+	char id[8];
 	unsigned char *pos;
 	unsigned int nodes_got = 0;
 	unsigned int devs = 0;
@@ -1432,14 +1435,15 @@
 			break;
 		memset(dev,0,sizeof(struct pnp_dev));
 		dev_id =  pnpbios_kmalloc(sizeof (struct pnp_id), GFP_KERNEL);
-		if (!dev_id)
+		if (!dev_id) {
+			kfree(dev);
 			break;
+		}
 		memset(dev_id,0,sizeof(struct pnp_id));
 		dev->number = thisnodenum;
-		memcpy(dev->name,"Unknown Device",13);
-		dev->name[14] = '\0';
+		strcpy(dev->name,"Unknown Device");
 		pnpid32_to_pnpid(node->eisa_id,id);
-		memcpy(dev_id->id,id,8);
+		memcpy(dev_id->id,id,7);
 		pnp_add_id(dev_id, dev);
 		pos = node_current_resource_data_to_dev(node,dev);
 		pos = node_possible_resource_data_to_dev(pos,node,dev);
@@ -1448,9 +1452,10 @@
 
 		dev->protocol = &pnpbios_protocol;
 
-		if(insert_device(dev)<0)
+		if(insert_device(dev)<0) {
+			kfree(dev_id);
 			kfree(dev);
-		else
+		} else
 			devs++;
 		if (nodenum <= thisnodenum) {
 			printk(KERN_ERR "PnPBIOS: build_devlist: Node number 0x%x is out of sequence following node 0x%x. Aborting.\n", (unsigned int)nodenum, (unsigned int)thisnodenum);
diff -Nru a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c	Thu Dec 26 19:45:04 2002
+++ b/drivers/pnp/resource.c	Thu Dec 26 19:45:04 2002
@@ -588,45 +588,65 @@
 	return -ENOENT;
 }
 
-static int pnp_prepare_request(struct pnp_cfg *config)
+int pnp_init_res_cfg(struct pnp_res_cfg *res_config)
 {
-	struct pnp_dev *dev;
 	int idx;
-	if (!config)
-		return -EINVAL;
-	dev = &config->request;
-	if (dev == NULL)
+
+	if (!res_config)
 		return -EINVAL;
-	if (dev->active || dev->ro)
-		return -EBUSY;
 	for (idx = 0; idx < DEVICE_COUNT_IRQ; idx++) {
-		dev->irq_resource[idx].name = NULL;
-		dev->irq_resource[idx].start = -1;
-		dev->irq_resource[idx].end = -1;
-		dev->irq_resource[idx].flags = 0;
+		res_config->irq_resource[idx].start = -1;
+		res_config->irq_resource[idx].end = -1;
+		res_config->irq_resource[idx].flags = 0;
 	}
 	for (idx = 0; idx < DEVICE_COUNT_DMA; idx++) {
-		dev->dma_resource[idx].name = NULL;
-		dev->dma_resource[idx].start = -1;
-		dev->dma_resource[idx].end = -1;
-		dev->dma_resource[idx].flags = 0;
+		res_config->dma_resource[idx].name = NULL;
+		res_config->dma_resource[idx].start = -1;
+		res_config->dma_resource[idx].end = -1;
+		res_config->dma_resource[idx].flags = 0;
 	}
 	for (idx = 0; idx < DEVICE_COUNT_RESOURCE; idx++) {
-		dev->resource[idx].name = NULL;
-		dev->resource[idx].start = 0;
-		dev->resource[idx].end = 0;
-		dev->resource[idx].flags = 0;
+		res_config->resource[idx].name = NULL;
+		res_config->resource[idx].start = 0;
+		res_config->resource[idx].end = 0;
+		res_config->resource[idx].flags = 0;
 	}
 	return 0;
 }
 
-static int pnp_generate_request(struct pnp_cfg *config)
+static int pnp_prepare_request(struct pnp_dev *dev, struct pnp_cfg *config, struct pnp_res_cfg *template)
 {
-	int i;
+	int idx, err;
 	if (!config)
 		return -EINVAL;
-	if (pnp_prepare_request<0)
-		return -ENOENT;
+	if (dev->lock_resources)
+		return -EPERM;
+	if (dev->active)
+		return -EBUSY;
+	err = pnp_init_res_cfg(&config->request);
+	if (err < 0)
+		return err;
+	if (!template)
+		return 0;
+	for (idx = 0; idx < DEVICE_COUNT_IRQ; idx++)
+		if (template->irq_resource[idx].start >= 0)
+			config->request.irq_resource[idx] = template->irq_resource[idx];
+	for (idx = 0; idx < DEVICE_COUNT_DMA; idx++)
+		if (template->dma_resource[idx].start >= 0)
+			config->request.dma_resource[idx] = template->dma_resource[idx];
+	for (idx = 0; idx < DEVICE_COUNT_RESOURCE; idx++)
+		if (template->resource[idx].start > 0)
+			config->request.resource[idx] = template->resource[idx];
+	return 0;
+}
+
+static int pnp_generate_request(struct pnp_dev *dev, struct pnp_cfg *config, struct pnp_res_cfg *template)
+{
+	int i, err;
+	if (!config)
+		return -EINVAL;
+	if ((err = pnp_prepare_request(dev, config, template))<0)
+		return err;
 	for (i=0; i<=7; i++)
 	{
 		if(pnp_generate_port(config,i)<0)
@@ -745,7 +765,7 @@
  * finds the best resource configuration and then informs the correct pnp protocol
  */
 
-int pnp_activate_dev(struct pnp_dev *dev)
+int pnp_activate_dev(struct pnp_dev *dev, struct pnp_res_cfg *template)
 {
 	int depnum, max;
 	struct pnp_cfg *config;
@@ -754,7 +774,7 @@
         max = pnp_get_max_depnum(dev);
 	if (dev->active)
 		return -EBUSY;
-	if (dev->driver){
+	if (pnp_dev_has_driver(dev)){
 		printk(KERN_INFO "pnp: Automatic configuration failed because the PnP device '%s' is busy\n", dev->dev.bus_id);
 		return -EINVAL;
 	}
@@ -767,7 +787,7 @@
 		config = pnp_generate_config(dev,depnum);
 		if (!config)
 			return -EINVAL;
-		if (pnp_generate_request(config)==0)
+		if (pnp_generate_request(dev,config,template)==0)
 			goto done;
 		kfree(config);
 	}
@@ -794,10 +814,12 @@
 {
         if (!dev)
                 return -EINVAL;
-	if (dev->driver){
+	if (pnp_dev_has_driver(dev)){
 		printk(KERN_INFO "pnp: Disable failed becuase the PnP device '%s' is busy\n", dev->dev.bus_id);
 		return -EINVAL;
 	}
+	if (dev->lock_resources)
+		return -EPERM;
 	if (!dev->protocol->disable || !dev->active)
 		return -EINVAL;
 	pnp_dbg("the device '%s' has been disabled", dev->dev.bus_id);
@@ -812,21 +834,21 @@
  *
  */
 
-int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, int mode)
+int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, struct pnp_res_cfg *template, int mode)
 {
 	struct pnp_cfg *config;
 	if (!dev)
 		return -EINVAL;
-        config = pnp_generate_config(dev,depnum);
-	if (dev->driver){
-		printk(KERN_INFO "pnp: Unable to set resources becuase the PnP device '%s' is busy\n", dev->dev.bus_id);
+	if (pnp_dev_has_driver(dev)){
+		printk(KERN_INFO "pnp: Unable to set resources because the PnP device '%s' is busy\n", dev->dev.bus_id);
 		return -EINVAL;
 	}
 	if (!dev->protocol->get || !dev->protocol->set)
 		return -EINVAL;
+        config = pnp_generate_config(dev,depnum);
 	if (!config)
 		return -EINVAL;
-	if (pnp_generate_request(config)==0)
+	if (pnp_generate_request(dev,config,template)==0)
 		goto done;
 	kfree(config);
 	printk(KERN_ERR "pnp: Manual configuration failed for device '%s' due to resource conflicts\n", dev->dev.bus_id);
@@ -840,6 +862,23 @@
 	return 0;
 }
 
+/**
+ * pnp_resource_change - change one resource
+ * @resource: pointer to resource to be changed
+ * @start: start of region
+ * @size: size of region
+ *
+ */
+ 
+void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size)
+{
+	if (resource == NULL)
+		return;
+	resource->flags &= ~IORESOURCE_AUTO;
+	resource->start = start;
+	resource->end = start + size - 1;
+}
+
 EXPORT_SYMBOL(pnp_build_resource);
 EXPORT_SYMBOL(pnp_find_resources);
 EXPORT_SYMBOL(pnp_get_max_depnum);
@@ -848,9 +887,11 @@
 EXPORT_SYMBOL(pnp_add_port_resource);
 EXPORT_SYMBOL(pnp_add_mem_resource);
 EXPORT_SYMBOL(pnp_add_mem32_resource);
+EXPORT_SYMBOL(pnp_init_res_cfg);
 EXPORT_SYMBOL(pnp_activate_dev);
 EXPORT_SYMBOL(pnp_disable_dev);
 EXPORT_SYMBOL(pnp_raw_set_dev);
+EXPORT_SYMBOL(pnp_resource_change);
 
 /* format is: allowdma0 */
 
diff -Nru a/drivers/serial/8250_pnp.c b/drivers/serial/8250_pnp.c
--- a/drivers/serial/8250_pnp.c	Thu Dec 26 19:45:04 2002
+++ b/drivers/serial/8250_pnp.c	Thu Dec 26 19:45:04 2002
@@ -360,7 +360,7 @@
 	struct pnp_resources *res = dev->res;
 	struct pnp_resources *resa;
 
-	if (!(check_name(dev->name) || check_name(dev->card->name)))
+	if (!(check_name(dev->name) || (dev->card && check_name(dev->card->name))))
 		return -ENODEV;
 
 	if (!res)
@@ -385,8 +385,11 @@
 {
 	struct serial_struct serial_req;
 	int ret, line, flags = dev_id->driver_data;
-	if (flags & UNKNOWN_DEV)
+	if (flags & UNKNOWN_DEV) {
 		ret = serial_pnp_guess_board(dev, &flags);
+		if (ret < 0)
+			return ret;
+	}
 	if (flags & SPCI_FL_NO_SHIRQ)
 		avoid_irq_share(dev);
 	memset(&serial_req, 0, sizeof(serial_req));
diff -Nru a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Thu Dec 26 19:45:04 2002
+++ b/include/linux/pnp.h	Thu Dec 26 19:45:04 2002
@@ -26,6 +26,7 @@
 struct pnp_resource;
 struct pnp_protocol;
 struct pnp_id;
+struct pnp_cfg;
 
 struct pnp_card {
 	char name[80];
@@ -79,7 +80,6 @@
 struct pnp_dev {
 	char name[80];			/* device name */
 	int active;			/* status of the device */
-	int ro;				/* read only */
 	struct list_head global_list;	/* node in global list of devices */
 	struct list_head protocol_list;	/* node in list of device's protocol */
 	struct list_head card_list;	/* node in card's list of devices */
@@ -93,6 +93,7 @@
 	unsigned short	regs;		/* ISAPnP: supported registers */
 	
 	struct pnp_resources *res;	/* possible resource information */
+	int lock_resources;		/* resources are locked */
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
 	struct resource dma_resource[DEVICE_COUNT_DMA];
 	struct resource irq_resource[DEVICE_COUNT_IRQ];
@@ -112,6 +113,13 @@
 	dev != global_to_pnp_dev(&pnp_global); \
 	dev = global_to_pnp_dev(dev->global_list.next))
 
+static inline int pnp_dev_has_driver(struct pnp_dev *pdev)
+{
+	if (pdev->driver || (pdev->card && pdev->card->driver))
+		return 1;
+	return 0;
+} 
+
 static inline void *pnp_get_drvdata (struct pnp_dev *pdev)
 {
 	return dev_get_drvdata(&pdev->dev);
@@ -160,10 +168,13 @@
 	} devs[MAX_DEVICES];		/* logical devices */
 };
 
+#define PNP_DRIVER_DO_NOT_ACTIVATE	(1<<0)
+
 struct pnp_driver {
 	struct list_head node;
 	char *name;
 	const struct pnp_device_id *id_table;
+	unsigned int flags;
 	int  (*probe)  (struct pnp_dev *dev, const struct pnp_device_id *dev_id);
 	void (*remove) (struct pnp_dev *dev);
 	struct device_driver driver;
@@ -171,10 +182,13 @@
 
 #define	to_pnp_driver(drv) container_of(drv,struct pnp_driver, driver)
 
+#define PNPC_DRIVER_DO_NOT_ACTIVATE	(1<<0)
+
 struct pnpc_driver {
 	struct list_head node;
 	char *name;
 	const struct pnp_card_id *id_table;
+	unsigned int flags;
 	int  (*probe)  (struct pnp_card *card, const struct pnp_card_id *card_id);
 	void (*remove) (struct pnp_card *card);
 	struct device_driver driver;
@@ -279,6 +293,12 @@
 	struct pnp_resources *dep;	/* dependent resources */
 };
 
+struct pnp_res_cfg {
+	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
+	struct resource dma_resource[DEVICE_COUNT_DMA];
+	struct resource irq_resource[DEVICE_COUNT_IRQ];
+};
+
 #define PNP_DYNAMIC		0	/* get or set current resource */
 #define PNP_STATIC		1	/* get or set resource for next boot */
 
@@ -287,7 +307,7 @@
 	struct pnp_irq *irq[2];
 	struct pnp_dma *dma[2];
 	struct pnp_mem *mem[4];
-	struct pnp_dev request;
+	struct pnp_res_cfg request;
 };
 
 
@@ -340,9 +360,11 @@
 int pnp_add_port_resource(struct pnp_dev *dev, int depnum, struct pnp_port *data);
 int pnp_add_mem_resource(struct pnp_dev *dev, int depnum, struct pnp_mem *data);
 int pnp_add_mem32_resource(struct pnp_dev *dev, int depnum, struct pnp_mem32 *data);
-int pnp_activate_dev(struct pnp_dev *dev);
+int pnp_init_res_cfg(struct pnp_res_cfg *template);
+int pnp_activate_dev(struct pnp_dev *dev, struct pnp_res_cfg *template);
 int pnp_disable_dev(struct pnp_dev *dev);
-int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, int mode);
+int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, struct pnp_res_cfg *template, int mode);
+void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size);
 
 /* driver */
 int compare_pnp_id(struct pnp_id * pos, const char * id);
@@ -366,9 +388,10 @@
 static inline int pnp_add_port_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
 static inline int pnp_add_mem_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
 static inline int pnp_add_mem32_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
-static inline int pnp_activate_dev(struct pnp_dev *dev) { return -ENODEV; }
+static inline int pnp_init_res_cfg(struct pnp_res_cfg *template) { return -ENODEV; }
+static inline int pnp_activate_dev(struct pnp_dev *dev, struct pnp_res_cfg *template) { return -ENODEV; }
 static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; }
-static inline int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, int mode) { return -ENODEV; }
+static inline int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, struct pnp_res_cfg *template, int mode) { return -ENODEV; }
 static inline int compare_pnp_id(struct list_head * id_list, const char * id) { return -ENODEV; }
 static inline int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_register_driver(struct pnp_driver *drv) { return -ENODEV; }

===================================================================


This BitKeeper patch contains the following changesets:
1.901
## Wrapped with gzip_uu ##


begin 664 bkpatch857
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
`
end

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs





