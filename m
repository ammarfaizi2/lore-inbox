Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbTBCB2Q>; Sun, 2 Feb 2003 20:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbTBCB2Q>; Sun, 2 Feb 2003 20:28:16 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:13193 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S265570AbTBCB0u>;
	Sun, 2 Feb 2003 20:26:50 -0500
Date: Sun, 2 Feb 2003 20:36:51 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH][RFC] Various Fixes and Improved Error Checking (3/4)
Message-ID: <20030202203651.GA22836@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org, greg@kroah.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jaroslav Kysela <perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes many bugs that were discovered while testing the previous two 
patches.  It also checks to see if the resources requested and the resources set 
actually match.


diff -urN a/drivers/pnp/driver.c b/drivers/pnp/driver.c
--- a/drivers/pnp/driver.c	Sun Feb  2 11:40:10 2003
+++ b/drivers/pnp/driver.c	Sun Feb  2 18:27:00 2003
@@ -95,7 +95,7 @@
 	pnp_dev = to_pnp_dev(dev);
 	pnp_drv = to_pnp_driver(dev->driver);
 
-	pnp_dbg("pnp: match found with the PnP device '%s' and the driver '%s'", dev->bus_id,pnp_drv->name);
+	pnp_dbg("match found with the PnP device '%s' and the driver '%s'", dev->bus_id,pnp_drv->name);
 
 	error = pnp_device_attach(pnp_dev);
 	if (error < 0)
diff -urN a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	Sun Feb  2 12:26:25 2003
+++ b/drivers/pnp/isapnp/core.c	Sun Feb  2 18:20:32 2003
@@ -969,7 +969,7 @@
 EXPORT_SYMBOL(isapnp_wake);
 EXPORT_SYMBOL(isapnp_device);
 
-static int isapnp_get_resources(struct pnp_dev *dev)
+static int isapnp_get_resources(struct pnp_dev *dev, struct pnp_resource_table * res)
 {
 	/* We don't need to do anything but this, the rest is taken care of */
 	if (pnp_port_valid(dev, 0) == 0 &&
@@ -979,27 +979,28 @@
 		dev->active = 0;
 	else
 		dev->active = 1;
+	*res = dev->res;
 	return 0;
 }
 
-static int isapnp_set_resources(struct pnp_dev *dev)
+static int isapnp_set_resources(struct pnp_dev *dev, struct pnp_resource_table * res)
 {
 	int tmp;
 
 	isapnp_cfg_begin(dev->card->number, dev->number);
 	dev->active = 1;
-	for (tmp = 0; tmp < 8 && pnp_port_valid(dev, tmp); tmp++)
-		isapnp_write_word(ISAPNP_CFG_PORT+(tmp<<1), pnp_port_start(dev, tmp));
-	for (tmp = 0; tmp < 2 && pnp_irq_valid(dev, tmp); tmp++) {
-		int irq = pnp_irq(dev, tmp);
+	for (tmp = 0; tmp < 8 && res->port_resource[tmp].flags & IORESOURCE_IO; tmp++)
+		isapnp_write_word(ISAPNP_CFG_PORT+(tmp<<1), res->port_resource[tmp].start);
+	for (tmp = 0; tmp < 2 && res->irq_resource[tmp].flags & IORESOURCE_IRQ; tmp++) {
+		int irq = res->irq_resource[tmp].start;
 		if (irq == 2)
 			irq = 9;
 		isapnp_write_byte(ISAPNP_CFG_IRQ+(tmp<<1), irq);
 	}
-	for (tmp = 0; tmp < 2 && pnp_dma_valid(dev, tmp); tmp++)
-		isapnp_write_byte(ISAPNP_CFG_DMA+tmp, pnp_dma(dev, tmp));
-	for (tmp = 0; tmp < 4 && pnp_mem_valid(dev, tmp); tmp++)
-		isapnp_write_word(ISAPNP_CFG_MEM+(tmp<<2), (pnp_mem_start(dev, tmp) >> 8) & 0xffff);
+	for (tmp = 0; tmp < 2 && res->dma_resource[tmp].flags & IORESOURCE_DMA; tmp++)
+		isapnp_write_byte(ISAPNP_CFG_DMA+tmp, res->dma_resource[tmp].start);
+	for (tmp = 0; tmp < 4 && res->mem_resource[tmp].flags & IORESOURCE_MEM; tmp++)
+		isapnp_write_word(ISAPNP_CFG_MEM+(tmp<<2), (res->mem_resource[tmp].start >> 8) & 0xffff);
 	isapnp_activate(dev->number);
 	isapnp_cfg_end();
 	return 0;
diff -urN a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	Sun Feb  2 12:26:25 2003
+++ b/drivers/pnp/pnpbios/core.c	Sun Feb  2 16:51:25 2003
@@ -700,20 +700,26 @@
 		return;
         while ( (char *)p < ((char *)node->data + node->size )) {
 
-                if( p[0] & 0x80 ) {// large item
+                if( p[0] & 0x80 ) {
 			len = (p[2] << 8) | p[1];
-                        p += len + 3;
-                        continue;
-                }
+			if ((p[0] & 0x7f) == 0x02) /* human readable name */
+			{
+				int size = *(short *) &p[1];
+				memcpy(dev->dev.name, p + 3, len >= 80 ? 79 : size);
+				break;
+			}
+			p += len + 3;
+			continue;
+		}
 		len = p[0] & 0x07;
-                switch ((p[0]>>3) & 0x0f) {
-		case 0x0f:
+		switch ((p[0]>>3) & 0x0f) {
+		case 0x0f: /* end tag */
 		{
         		return;
 			break;
 		}
-                case 0x03: // compatible ID
-                {
+		case 0x03: /* compatible ID */
+		{
 			if (len != 4)
 				goto __skip;
 			dev_id =  pnpbios_kmalloc(sizeof (struct pnp_id), GFP_KERNEL);
@@ -724,20 +730,20 @@
 			memcpy(&dev_id->id, id, 7);
 			pnp_add_id(dev_id, dev);
 			break;
-                }
-                } /* switch */
+		}
+		}
 		__skip:
-                p += len + 1;
+		p += len + 1;
 
-        } /* while */
+	}
 }
 
-static int pnpbios_get_resources(struct pnp_dev *dev)
+static int pnpbios_get_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
 {
 	struct pnp_dev_node_info node_info;
 	u8 nodenum = dev->number;
 	struct pnp_bios_node * node;
-		
+
 	/* just in case */
 	if(!pnpbios_is_dynamic(dev))
 		return -EPERM;
@@ -748,13 +754,13 @@
 		return -1;
 	if (pnp_bios_get_dev_node(&nodenum, (char )0, node))
 		return -ENODEV;
-	pnp_parse_current_resources((char *)node->data,(char *)node->data + node->size,dev);
+	pnp_parse_current_resources((char *)node->data,(char *)node->data + node->size,res);
 	dev->active = pnp_is_active(dev);
 	kfree(node);
 	return 0;
 }
 
-static int pnpbios_set_resources(struct pnp_dev *dev)
+static int pnpbios_set_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
 {
 	struct pnp_dev_node_info node_info;
 	u8 nodenum = dev->number;
@@ -770,7 +776,7 @@
 		return -1;
 	if (pnp_bios_get_dev_node(&nodenum, (char )1, node))
 		return -ENODEV;
-	if(!pnp_write_resources((char *)node->data,(char *)node->data + node->size,dev)){
+	if(!pnp_write_resources((char *)node->data,(char *)node->data + node->size,res)){
 		return -1;
 	}
 	pnp_bios_set_dev_node(node->handle, (char)0, node);
@@ -835,7 +841,7 @@
 		return -1;
 	if (pnp_bios_get_dev_node(&nodenum, (char )1, node))
 		goto failed;
-	if(pnp_write_resources((char *)node->data,(char *)node->data + node->size,dev)<0)
+	if(pnp_write_resources((char *)node->data,(char *)node->data + node->size,&dev->res)<0)
 		goto failed;
 	kfree(config);
 	kfree(node);
@@ -917,7 +923,7 @@
 		pnpid32_to_pnpid(node->eisa_id,id);
 		memcpy(dev_id->id,id,7);
 		pnp_add_id(dev_id, dev);
-		pos = pnp_parse_current_resources((char *)node->data,(char *)node->data + node->size,dev);
+		pos = pnp_parse_current_resources((char *)node->data,(char *)node->data + node->size,&dev->res);
 		pos = pnp_parse_possible_resources((char *)pos,(char *)node->data + node->size,dev);
 		node_id_data_to_dev(pos,node,dev);
 		dev->active = pnp_is_active(dev);
diff -urN a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c	Sun Feb  2 12:26:25 2003
+++ b/drivers/pnp/resource.c	Sun Feb  2 18:24:07 2003
@@ -50,7 +50,7 @@
 	if (!res)
 		return NULL;
 	ptr = dev->possible;
-	if (ptr && ptr->dependent && dependent) { /* add to another list */
+	if (ptr) { /* add to another list */
 		ptra = ptr->dep;
 		while (ptra && ptra->dep)
 			ptra = ptra->dep;
@@ -58,24 +58,14 @@
 			ptr->dep = res;
 		else
 			ptra->dep = res;
-	} else {
-		if (!ptr){
-			dev->possible = res;
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
 
@@ -685,9 +675,9 @@
 	}
 
 	mask = irq->map;
-	for (i = *value1; i < 16; i++, mask=mask>>1)
+	for (i = *value1 + 1; i < 16; i++)
 	{
-		if(mask & 0x01) {
+		if(mask>>i & 0x01) {
 			*value1 = *value2 = i;
 			if(!pnp_check_irq(dev, idx))
 				return 1;
@@ -723,9 +713,9 @@
 	}
 
 	mask = dma->map;
-	for (i = *value1; i < 8; i++, mask=mask>>1)
+	for (i = *value1 + 1; i < 8; i++)
 	{
-		if(mask & 0x01) {
+		if(mask>>i & 0x01) {
 			*value1 = *value2 = i;
 			if(!pnp_check_dma(dev, idx))
 				return 1;
@@ -999,6 +989,7 @@
 {
 	struct pnp_change * change = pnp_add_change(parent,dev);
 	move--;
+	spin_lock(&pnp_lock);
 	if (!pnp_can_configure(dev))
 		goto fail;
 	if (!dev->rule->depnum) {
@@ -1010,6 +1001,7 @@
 			goto fail;
 		pnp_init_resource_table(&dev->res);
 	}
+	spin_unlock(&pnp_lock);
 	if (!parent) {
 		pnp_free_changes(change);
 		kfree(change);
@@ -1017,6 +1009,7 @@
 	return 1;
 
 fail:
+	spin_unlock(&pnp_lock);
 	if (!parent)
 		kfree(change);
 	return 0;
@@ -1104,6 +1097,32 @@
 	return error;
 }
 
+static int pnp_compare_resources(struct pnp_resource_table * resa, struct pnp_resource_table * resb)
+{
+	int idx;
+	for (idx = 0; idx < PNP_MAX_IRQ; idx++) {
+		if (resa->irq_resource[idx].start != resb->irq_resource[idx].start)
+			return 1;
+	}
+	for (idx = 0; idx < PNP_MAX_DMA; idx++) {
+		if (resa->dma_resource[idx].start != resb->dma_resource[idx].start)
+			return 1;
+	}
+	for (idx = 0; idx < PNP_MAX_PORT; idx++) {
+		if (resa->port_resource[idx].start != resb->port_resource[idx].start)
+			return 1;
+		if (resa->port_resource[idx].end != resb->port_resource[idx].end)
+			return 1;
+	}
+	for (idx = 0; idx < PNP_MAX_MEM; idx++) {
+		if (resa->mem_resource[idx].start != resb->mem_resource[idx].start)
+			return 1;
+		if (resa->mem_resource[idx].end != resb->mem_resource[idx].end)
+			return 1;
+	}
+	return 0;
+}
+
 
 /*
  * PnP Device Resource Management
@@ -1120,19 +1139,32 @@
 {
 	if (!dev)
 		return -EINVAL;
-	if (!pnp_can_configure(dev))
-		return -EBUSY;
+	if (dev->active) {
+		pnp_info("res: The PnP device '%s' is already active.", dev->dev.bus_id);
+		return -EINVAL;
+	}
 	if (dev->status != PNP_READY && dev->status != PNP_ATTACHED){
 		pnp_err("res: Activation failed because the PnP device '%s' is busy", dev->dev.bus_id);
 		return -EINVAL;
 	}
-	if (!pnp_can_write(dev))
+	if (!pnp_can_write(dev)) {
+		pnp_info("res: Unable to activate the PnP device '%s' because this feature is not supported", dev->dev.bus_id);
 		return -EINVAL;
-
+	}
+	if (!dev->protocol->set(dev, &dev->res)<0) {
+		pnp_err("res: The protocol '%s' reports that activating the PnP device '%s' has failed", dev->protocol->name, dev->dev.bus_id);
+		return -1;
+	}
+	if (pnp_can_read(dev)) {
+		struct pnp_resource_table res;
+		dev->protocol->get(dev, &res);
+		if (pnp_compare_resources(&dev->res, &res)) {
+			pnp_err("res: The resources requested do not match those actually set for the PnP device '%s'", dev->dev.bus_id);
+			return -1;
+		}
+	} else
+		dev->active = pnp_is_active(dev);
 	pnp_dbg("res: the device '%s' has been activated", dev->dev.bus_id);
-	dev->protocol->set(dev);
-	if (pnp_can_read(dev))
-		dev->protocol->get(dev);
 	kfree(dev->rule);
 	return 0;
 }
@@ -1148,16 +1180,24 @@
 {
         if (!dev)
                 return -EINVAL;
+	if (!dev->active) {
+		pnp_info("res: The PnP device '%s' is already disabled.", dev->dev.bus_id);
+		return -EINVAL;
+	}
 	if (dev->status != PNP_READY){
-		printk(KERN_INFO "pnp: Disable failed becuase the PnP device '%s' is busy\n", dev->dev.bus_id);
+		pnp_info("res: Disable failed becuase the PnP device '%s' is busy", dev->dev.bus_id);
 		return -EINVAL;
 	}
-	if (dev->lock_resources)
-		return -EPERM;
-	if (!pnp_can_disable(dev) || !dev->active)
+	if (!pnp_can_disable(dev)<0) {
+		pnp_info("res: Unable to disable the PnP device '%s' because this feature is not supported", dev->dev.bus_id);
 		return -EINVAL;
+	}
+	if (!dev->protocol->disable(dev)) {
+		pnp_err("res: The protocol '%s' reports that disabling the PnP device '%s' has failed", dev->protocol->name, dev->dev.bus_id);
+		return -1;
+	}
 	pnp_dbg("the device '%s' has been disabled", dev->dev.bus_id);
-	return dev->protocol->disable(dev);
+	return 0;
 }
 
 /**
diff -urN a/drivers/pnp/support.c b/drivers/pnp/support.c
--- a/drivers/pnp/support.c	Sun Feb  2 12:26:25 2003
+++ b/drivers/pnp/support.c	Sun Feb  2 18:25:41 2003
@@ -1,5 +1,5 @@
 /*
- * support.c - provides standard pnp functions for the use of pnp protocol drivers, 
+ * support.c - provides standard pnp functions for the use of pnp protocol drivers,
  *
  * Copyright 2002 Adam Belay <ambx1@neo.rr.com>
  *
@@ -36,7 +36,7 @@
 #define LARGE_TAG_ANSISTR		0x02
 #define LARGE_TAG_UNICODESTR		0x03
 #define LARGE_TAG_VENDOR		0x04
-#define LARGE_TAG_MEM32		0x05
+#define LARGE_TAG_MEM32			0x05
 #define LARGE_TAG_FIXEDMEM32		0x06
 
 
@@ -48,8 +48,8 @@
 
 int pnp_is_active(struct pnp_dev * dev)
 {
-	if (!pnp_port_start(dev, 0) &&
-	    !pnp_mem_start(dev, 0) &&
+	if (!pnp_port_start(dev, 0) && pnp_port_len(dev, 0) <= 1 &&
+	    !pnp_mem_start(dev, 0) && pnp_mem_len(dev, 0) <= 1 &&
 	    pnp_irq(dev, 0) == -1 &&
 	    pnp_dma(dev, 0) == -1)
 	    	return 0;
@@ -62,59 +62,59 @@
  * Current resource reading functions *
  */
 
-static void current_irqresource(struct pnp_dev *dev, int irq)
+static void current_irqresource(struct pnp_resource_table * res, int irq)
 {
 	int i = 0;
-	while (pnp_irq_valid(dev, i) && i < PNP_MAX_IRQ) i++;
+	while ((res->irq_resource[i].flags & IORESOURCE_IRQ) && i < PNP_MAX_IRQ) i++;
 	if (i < PNP_MAX_IRQ) {
-		dev->res.irq_resource[i].start =
-		dev->res.irq_resource[i].end = (unsigned long) irq;
-		dev->res.irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
+		res->irq_resource[i].start =
+		res->irq_resource[i].end = (unsigned long) irq;
+		res->irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
 	}
 }
 
-static void current_dmaresource(struct pnp_dev *dev, int dma)
+static void current_dmaresource(struct pnp_resource_table * res, int dma)
 {
 	int i = 0;
-	while (pnp_dma_valid(dev, i) && i < PNP_MAX_DMA) i++;
+	while ((res->dma_resource[i].flags & IORESOURCE_DMA) && i < PNP_MAX_DMA) i++;
 	if (i < PNP_MAX_DMA) {
-		dev->res.dma_resource[i].start =
-		dev->res.dma_resource[i].end = (unsigned long) dma;
-		dev->res.dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
+		res->dma_resource[i].start =
+		res->dma_resource[i].end = (unsigned long) dma;
+		res->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
 	}
 }
 
-static void current_ioresource(struct pnp_dev *dev, int io, int len)
+static void current_ioresource(struct pnp_resource_table * res, int io, int len)
 {
 	int i = 0;
-	while (pnp_port_valid(dev, i) && i < PNP_MAX_PORT) i++;
+	while ((res->port_resource[i].flags & IORESOURCE_IO) && i < PNP_MAX_PORT) i++;
 	if (i < PNP_MAX_PORT) {
-		dev->res.port_resource[i].start = (unsigned long) io;
-		dev->res.port_resource[i].end = (unsigned long)(io + len - 1);
-		dev->res.port_resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
+		res->port_resource[i].start = (unsigned long) io;
+		res->port_resource[i].end = (unsigned long)(io + len - 1);
+		res->port_resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
 	}
 }
 
-static void current_memresource(struct pnp_dev *dev, int mem, int len)
+static void current_memresource(struct pnp_resource_table * res, int mem, int len)
 {
 	int i = 0;
-	while (pnp_mem_valid(dev, i) && i < PNP_MAX_MEM) i++;
+	while ((res->mem_resource[i].flags & IORESOURCE_MEM) && i < PNP_MAX_MEM) i++;
 	if (i < PNP_MAX_MEM) {
-		dev->res.mem_resource[i].start = (unsigned long) mem;
-		dev->res.mem_resource[i].end = (unsigned long)(mem + len - 1);
-		dev->res.mem_resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
+		res->mem_resource[i].start = (unsigned long) mem;
+		res->mem_resource[i].end = (unsigned long)(mem + len - 1);
+		res->mem_resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
 	}
 }
 
 /**
- * pnp_parse_current_res - Extracts current resource information from a raw PnP resource structure
- * @p: pointer to the raw structure
+ * pnp_parse_current_resources - Extracts current resource information from a raw PnP resource structure
+ * @p: pointer to the start of the structure
  * @end: pointer to the end of the structure
- * @dev: pointer to the desired PnP device
+ * @res: pointer to the resource table to record to
  *
  */
 
-unsigned char * pnp_parse_current_resources(unsigned char * p, unsigned char * end, struct pnp_dev *dev)
+unsigned char * pnp_parse_current_resources(unsigned char * p, unsigned char * end, struct pnp_resource_table * res)
 {
 	int len;
 
@@ -122,7 +122,7 @@
 		return NULL;
 
 	/* Blank the resource table values */
-	pnp_init_resource_table(&dev->res);
+	pnp_init_resource_table(res);
 
 	while ((char *)p < (char *)end) {
 
@@ -135,13 +135,12 @@
 				int size = *(short *) &p[10];
 				if (len != 9)
 					goto lrg_err;
-				current_memresource(dev, io, size);
+				current_memresource(res, io, size);
 				break;
 			}
-			case LARGE_TAG_ANSISTR: /* human readable name */
+			case LARGE_TAG_ANSISTR:
 			{
-				int size = *(short *) &p[1];
-				memcpy(dev->dev.name, p + 3, len >= 80 ? 79 : size);
+				/* ignore this for now */
 				break;
 			}
 			case LARGE_TAG_MEM32:
@@ -150,7 +149,7 @@
 				int size = *(int *) &p[16];
 				if (len != 17)
 					goto lrg_err;
-				current_memresource(dev, io, size);
+				current_memresource(res, io, size);
 				break;
 			}
 			case LARGE_TAG_FIXEDMEM32:
@@ -159,7 +158,7 @@
 				int size = *(int *) &p[8];
 				if (len != 9)
 					goto lrg_err;
-				current_memresource(dev, io, size);
+				current_memresource(res, io, size);
 				break;
 			}
 			default: /* an unkown tag */
@@ -184,7 +183,7 @@
 			mask= p[1] + p[2]*256;
 			for (i=0;i<16;i++, mask=mask>>1)
 				if(mask & 0x01) irq=i;
-			current_irqresource(dev, irq);
+			current_irqresource(res, irq);
 			break;
 		}
 		case SMALL_TAG_DMA:
@@ -195,7 +194,7 @@
 			mask = p[1];
 			for (i=0;i<8;i++, mask = mask>>1)
 				if(mask & 0x01) dma=i;
-			current_dmaresource(dev, dma);
+			current_dmaresource(res, dma);
 			break;
 		}
 		case SMALL_TAG_PORT:
@@ -204,7 +203,7 @@
 			int size = p[7];
 			if (len != 7)
 				goto sm_err;
-			current_ioresource(dev, io, size);
+			current_ioresource(res, io, size);
 			break;
 		}
 		case SMALL_TAG_FIXEDPORT:
@@ -213,7 +212,7 @@
 			int size = p[3];
 			if (len != 3)
 				goto sm_err;
-			current_ioresource(dev, io, size);
+			current_ioresource(res, io, size);
 			break;
 		}
 		case SMALL_TAG_END:
@@ -341,7 +340,7 @@
 
 /**
  * pnp_parse_possible_resources - Extracts possible resource information from a raw PnP resource structure
- * @p: pointer to the raw structure
+ * @p: pointer to the start of the structure
  * @end: pointer to the end of the structure
  * @dev: pointer to the desired PnP device
  *
@@ -553,10 +552,17 @@
 	return;
 }
 
-unsigned char * pnp_write_resources(unsigned char * p, unsigned char * end, struct pnp_dev *dev)
+/**
+ * pnp_write_resources - Writes resource information to a raw PnP resource structure
+ * @p: pointer to the start of the structure
+ * @end: pointer to the end of the structure
+ * @res: pointer to a resource table containing the resources to set
+ *
+ */
+
+unsigned char * pnp_write_resources(unsigned char * p, unsigned char * end, struct pnp_resource_table * res)
 {
 	int len, port = 0, irq = 0, dma = 0, mem = 0;
-	struct pnp_resource_table * res = &dev->res;
 
 	if (!p)
 		return NULL;
diff -urN a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Sun Feb  2 12:26:25 2003
+++ b/include/linux/pnp.h	Sun Feb  2 15:49:01 2003
@@ -156,7 +156,6 @@
 
 struct pnp_resources {
 	unsigned short priority;	/* priority */
-	unsigned short dependent;	/* dependent resources */
 	struct pnp_port *port;		/* first port */
 	struct pnp_irq *irq;		/* first IRQ */
 	struct pnp_dma *dma;		/* first DMA */
@@ -333,8 +332,8 @@
 	char		      * name;
 
 	/* resource control functions */
-	int (*get)(struct pnp_dev *dev);
-	int (*set)(struct pnp_dev *dev);
+	int (*get)(struct pnp_dev *dev, struct pnp_resource_table *res);
+	int (*set)(struct pnp_dev *dev, struct pnp_resource_table *res);
 	int (*disable)(struct pnp_dev *dev);
 
 	/* used by pnp layer only (look but don't touch) */
@@ -387,9 +386,9 @@
 
 /* support */
 int pnp_is_active(struct pnp_dev * dev);
-unsigned char * pnp_parse_current_resources(unsigned char * p, unsigned char * end, struct pnp_dev *dev);
-unsigned char * pnp_parse_possible_resources(unsigned char * p, unsigned char * end, struct pnp_dev *dev);
-unsigned char * pnp_write_resources(unsigned char * p, unsigned char * end, struct pnp_dev *dev);
+unsigned char * pnp_parse_current_resources(unsigned char * p, unsigned char * end, struct pnp_resource_table * res);
+unsigned char * pnp_parse_possible_resources(unsigned char * p, unsigned char * end, struct pnp_dev * dev);
+unsigned char * pnp_write_resources(unsigned char * p, unsigned char * end, struct pnp_resource_table * res);
 
 #else
 
@@ -425,9 +424,9 @@
 
 /* support */
 static inline int pnp_is_active(struct pnp_dev * dev) { return -ENODEV; )
-static inline unsigned char * pnp_parse_current_resources(unsigned char * p, unsigned char * end, struct pnp_dev *dev) { return NULL; }
-static inline unsigned char * pnp_parse_possible_resources(unsigned char * p, unsigned char * end, struct pnp_dev *dev) { return NULL; }
-static inline unsigned char * pnp_write_resources(unsigned char * p, unsigned char * end, struct pnp_dev *dev) { return NULL; )
+static inline unsigned char * pnp_parse_current_resources(unsigned char * p, unsigned char * end, struct pnp_resource_table * res) { return NULL; }
+static inline unsigned char * pnp_parse_possible_resources(unsigned char * p, unsigned char * end, struct pnp_dev * dev) { return NULL; }
+static inline unsigned char * pnp_write_resources(unsigned char * p, unsigned char * end, struct pnp_resource_table * res) { return NULL; )
 
 #endif /* CONFIG_PNP */
 
