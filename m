Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbTBCB0k>; Sun, 2 Feb 2003 20:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbTBCB0k>; Sun, 2 Feb 2003 20:26:40 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:12681 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S265396AbTBCB0g>;
	Sun, 2 Feb 2003 20:26:36 -0500
Date: Sun, 2 Feb 2003 20:36:56 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH][RFC] PnP BIOS cleanups (4/4)
Message-ID: <20030202203656.GA23160@neo.rr.com>
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

This patch cleans up device inserting and disabling.


--- a/drivers/pnp/pnpbios/core.c	Sun Feb  2 18:43:34 2003
+++ b/drivers/pnp/pnpbios/core.c	Sun Feb  2 19:19:13 2003
@@ -236,6 +236,7 @@
 	void *p = kmalloc( size, f );
 	if ( p == NULL )
 		printk(KERN_ERR "PnPBIOS: kmalloc() failed\n");
+	memset(p, 0, size);
 	return p;
 }
 
@@ -752,8 +753,10 @@
 	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -1;
-	if (pnp_bios_get_dev_node(&nodenum, (char )0, node))
+	if (pnp_bios_get_dev_node(&nodenum, (char )0, node)) {
+		kfree(node);
 		return -ENODEV;
+	}
 	pnp_parse_current_resources((char *)node->data,(char *)node->data + node->size,res);
 	dev->active = pnp_is_active(dev);
 	kfree(node);
@@ -777,6 +780,7 @@
 	if (pnp_bios_get_dev_node(&nodenum, (char )1, node))
 		return -ENODEV;
 	if(!pnp_write_resources((char *)node->data,(char *)node->data + node->size,res)){
+		kfree(node);
 		return -1;
 	}
 	pnp_bios_set_dev_node(node->handle, (char)0, node);
@@ -786,70 +790,24 @@
 
 static int pnpbios_disable_resources(struct pnp_dev *dev)
 {
-	struct pnp_rule_table * config = kmalloc(sizeof(struct pnp_rule_table), GFP_KERNEL);
-	/* first we need to set everything to a disabled value */
-	struct pnp_port	port = {
-	.max	= 0,
-	.min	= 0,
-	.align	= 0,
-	.size	= 0,
-	.flags	= 0,
-	.pad	= 0,
-	};
-	struct pnp_mem	mem = {
-	.max	= 0,
-	.min	= 0,
-	.align	= 0,
-	.size	= 0,
-	.flags	= 0,
-	};
-	struct pnp_dma	dma = {
-	.map	= 0,
-	.flags	= 0,
-	};
-	struct pnp_irq	irq = {
-	.map	= 0,
-	.flags	= 0,
-	.pad	= 0,
-	};
-	int i;
 	struct pnp_dev_node_info node_info;
-	u8 nodenum = dev->number;
 	struct pnp_bios_node * node;
-	if (!config)
-		return -1;
+	
 	/* just in case */
 	if(dev->flags & PNPBIOS_NO_DISABLE || !pnpbios_is_dynamic(dev))
 		return -EPERM;
-	memset(config, 0, sizeof(struct pnp_rule_table));
 	if (!dev || !dev->active)
 		return -EINVAL;
-	for (i=0; i < 8; i++)
-		config->port[i] = &port;
-	for (i=0; i < 4; i++)
-		config->mem[i] = &mem;
-	for (i=0; i < 2; i++)
-		config->irq[i] = &irq;
-	for (i=0; i < 2; i++)
-		config->dma[i] = &dma;
-	dev->active = 0;
-
 	if (pnp_bios_dev_node_info(&node_info) != 0)
 		return -ENODEV;
+	/* the value of this will be zero */
 	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
-		return -1;
-	if (pnp_bios_get_dev_node(&nodenum, (char )1, node))
-		goto failed;
-	if(pnp_write_resources((char *)node->data,(char *)node->data + node->size,&dev->res)<0)
-		goto failed;
-	kfree(config);
+		return -ENOMEM;
+	pnp_bios_set_dev_node(node->handle, (char)0, node);
+	dev->active = 0;
 	kfree(node);
 	return 0;
- failed:
-	kfree(node);
-	kfree(config);
-	return -1;
 }
 
 
@@ -862,15 +820,47 @@
 	.disable = pnpbios_disable_resources,
 };
 
-static inline int insert_device(struct pnp_dev *dev)
+static int insert_device(struct pnp_dev *dev, struct pnp_bios_node * node)
 {
 	struct list_head * pos;
+	unsigned char * p;
 	struct pnp_dev * pnp_dev;
+	struct pnp_id *dev_id;
+	char id[8];
+
+	/* check if the device is already added */
+	dev->number = node->handle;
 	list_for_each (pos, &pnpbios_protocol.devices){
 		pnp_dev = list_entry(pos, struct pnp_dev, protocol_list);
 		if (dev->number == pnp_dev->number)
 			return -1;
 	}
+
+	/* set the initial values for the PnP device */
+	dev_id = pnpbios_kmalloc(sizeof(struct pnp_id), GFP_KERNEL);
+	if (!dev_id)
+		return -1;
+	pnpid32_to_pnpid(node->eisa_id,id);
+	memcpy(dev_id->id,id,7);
+	pnp_add_id(dev_id, dev);
+	p = pnp_parse_current_resources((char *)node->data,
+		(char *)node->data + node->size,&dev->res);
+	p = pnp_parse_possible_resources((char *)p,
+		(char *)node->data + node->size,dev);
+	node_id_data_to_dev(p,node,dev);
+	dev->active = pnp_is_active(dev);
+	dev->flags = node->flags;
+	if (!(dev->flags & PNPBIOS_NO_CONFIG))
+		dev->capabilities |= PNP_CONFIGURABLE;
+	if (!(dev->flags & PNPBIOS_NO_DISABLE))
+		dev->capabilities |= PNP_DISABLE;
+	dev->capabilities |= PNP_READ;
+	if (pnpbios_is_dynamic(dev))
+		dev->capabilities |= PNP_WRITE;
+	if (dev->flags & PNPBIOS_REMOVABLE)
+		dev->capabilities |= PNP_REMOVABLE;
+	dev->protocol = &pnpbios_protocol;
+
 	pnp_add_device(dev);
 	return 0;
 }
@@ -878,14 +868,11 @@
 static void __init build_devlist(void)
 {
 	u8 nodenum;
-	char id[8];
-	unsigned char *pos;
 	unsigned int nodes_got = 0;
 	unsigned int devs = 0;
 	struct pnp_bios_node *node;
 	struct pnp_dev_node_info node_info;
 	struct pnp_dev *dev;
-	struct pnp_id *dev_id;
 
 	if (!pnp_bios_present())
 		return;
@@ -912,38 +899,9 @@
 		dev =  pnpbios_kmalloc(sizeof (struct pnp_dev), GFP_KERNEL);
 		if (!dev)
 			break;
-		memset(dev,0,sizeof(struct pnp_dev));
-		dev_id =  pnpbios_kmalloc(sizeof (struct pnp_id), GFP_KERNEL);
-		if (!dev_id) {
-			kfree(dev);
-			break;
-		}
-		memset(dev_id,0,sizeof(struct pnp_id));
-		dev->number = thisnodenum;
-		pnpid32_to_pnpid(node->eisa_id,id);
-		memcpy(dev_id->id,id,7);
-		pnp_add_id(dev_id, dev);
-		pos = pnp_parse_current_resources((char *)node->data,(char *)node->data + node->size,&dev->res);
-		pos = pnp_parse_possible_resources((char *)pos,(char *)node->data + node->size,dev);
-		node_id_data_to_dev(pos,node,dev);
-		dev->active = pnp_is_active(dev);
-		dev->flags = node->flags;
-		if (!(dev->flags & PNPBIOS_NO_CONFIG))
-			dev->capabilities |= PNP_CONFIGURABLE;
-		if (!(dev->flags & PNPBIOS_NO_DISABLE))
-			dev->capabilities |= PNP_DISABLE;
-		dev->capabilities |= PNP_READ;
-		if (pnpbios_is_dynamic(dev))
-			dev->capabilities |= PNP_WRITE;
-		if (dev->flags & PNPBIOS_REMOVABLE)
-			dev->capabilities |= PNP_REMOVABLE;
-
-		dev->protocol = &pnpbios_protocol;
-
-		if(insert_device(dev)<0) {
-			kfree(dev_id);
+		if(insert_device(dev,node)<0)
 			kfree(dev);
-		} else
+		else
 			devs++;
 		if (nodenum <= thisnodenum) {
 			printk(KERN_ERR "PnPBIOS: build_devlist: Node number 0x%x is out of sequence following node 0x%x. Aborting.\n", (unsigned int)nodenum, (unsigned int)thisnodenum);
