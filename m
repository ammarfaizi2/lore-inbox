Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267086AbSL3WQk>; Mon, 30 Dec 2002 17:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267091AbSL3WQk>; Mon, 30 Dec 2002 17:16:40 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:51983 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267086AbSL3WQU>;
	Mon, 30 Dec 2002 17:16:20 -0500
Date: Mon, 30 Dec 2002 14:19:46 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PnP changes for 2.5.53
Message-ID: <20021230221946.GB814@kroah.com>
References: <20021230221836.GA814@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021230221836.GA814@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.865.47.1, 2002/12/26 16:56:19+01:00, perex@suse.cz

PnP update
  - added configuration templates - configuration can be changed from the probe() callback
  - new PnP ID - NSC6001
  - fixes in PnP BIOS code - no more oopses
  - fixed typos and thinkos in 8250_pnp.c


diff -Nru a/Documentation/isapnp.txt b/Documentation/isapnp.txt
--- a/Documentation/isapnp.txt	Mon Dec 30 14:21:02 2002
+++ b/Documentation/isapnp.txt	Mon Dec 30 14:21:02 2002
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
--- a/drivers/pnp/card.c	Mon Dec 30 14:21:02 2002
+++ b/drivers/pnp/card.c	Mon Dec 30 14:21:02 2002
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
--- a/drivers/pnp/core.c	Mon Dec 30 14:21:02 2002
+++ b/drivers/pnp/core.c	Mon Dec 30 14:21:02 2002
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
--- a/drivers/pnp/driver.c	Mon Dec 30 14:21:02 2002
+++ b/drivers/pnp/driver.c	Mon Dec 30 14:21:02 2002
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
--- a/drivers/pnp/idlist.h	Mon Dec 30 14:21:02 2002
+++ b/drivers/pnp/idlist.h	Mon Dec 30 14:21:02 2002
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
--- a/drivers/pnp/interface.c	Mon Dec 30 14:21:02 2002
+++ b/drivers/pnp/interface.c	Mon Dec 30 14:21:02 2002
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
--- a/drivers/pnp/isapnp/core.c	Mon Dec 30 14:21:02 2002
+++ b/drivers/pnp/isapnp/core.c	Mon Dec 30 14:21:02 2002
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
--- a/drivers/pnp/pnpbios/core.c	Mon Dec 30 14:21:02 2002
+++ b/drivers/pnp/pnpbios/core.c	Mon Dec 30 14:21:02 2002
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
--- a/drivers/pnp/resource.c	Mon Dec 30 14:21:02 2002
+++ b/drivers/pnp/resource.c	Mon Dec 30 14:21:02 2002
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
--- a/drivers/serial/8250_pnp.c	Mon Dec 30 14:21:02 2002
+++ b/drivers/serial/8250_pnp.c	Mon Dec 30 14:21:02 2002
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
--- a/include/linux/pnp.h	Mon Dec 30 14:21:02 2002
+++ b/include/linux/pnp.h	Mon Dec 30 14:21:02 2002
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
