Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVG0W6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVG0W6B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVG0Wzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:55:48 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:20632 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S261215AbVG0Wyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 18:54:49 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH] PNP: consolidate kmalloc wrappers
Date: Wed, 27 Jul 2005 16:54:37 -0600
User-Agent: KMail/1.8.1
Cc: Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507271654.38155.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ISAPNP, PNPBIOS, and PNPACPI all had their own kmalloc wrappers that
reimplemented kcalloc().  Remove the wrappers and just use kcalloc()
directly.

Note that this also removes the PNPBIOS error message when the kmalloc
fails.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work/drivers/pnp/isapnp/core.c
===================================================================
--- work.orig/drivers/pnp/isapnp/core.c	2005-07-25 15:04:26.000000000 -0600
+++ work/drivers/pnp/isapnp/core.c	2005-07-27 13:28:09.000000000 -0600
@@ -142,17 +142,6 @@
 	isapnp_write_byte(idx+1, val);
 }
 
-static void *isapnp_alloc(long size)
-{
-	void *result;
-
-	result = kmalloc(size, GFP_KERNEL);
-	if (!result)
-		return NULL;
-	memset(result, 0, size);
-	return result;
-}
-
 static void isapnp_key(void)
 {
 	unsigned char code = 0x6a, msb;
@@ -406,7 +395,7 @@
 	struct pnp_id * id;
 	if (!dev)
 		return;
-	id = isapnp_alloc(sizeof(struct pnp_id));
+	id = kcalloc(1, sizeof(struct pnp_id), GFP_KERNEL);
 	if (!id)
 		return;
 	sprintf(id->id, "%c%c%c%x%x%x%x",
@@ -430,7 +419,7 @@
 	struct pnp_dev *dev;
 
 	isapnp_peek(tmp, size);
-	dev = isapnp_alloc(sizeof(struct pnp_dev));
+	dev = kcalloc(1, sizeof(struct pnp_dev), GFP_KERNEL);
 	if (!dev)
 		return NULL;
 	dev->number = number;
@@ -461,7 +450,7 @@
 	unsigned long bits;
 
 	isapnp_peek(tmp, size);
-	irq = isapnp_alloc(sizeof(struct pnp_irq));
+	irq = kcalloc(1, sizeof(struct pnp_irq), GFP_KERNEL);
 	if (!irq)
 		return;
 	bits = (tmp[1] << 8) | tmp[0];
@@ -485,7 +474,7 @@
 	struct pnp_dma *dma;
 
 	isapnp_peek(tmp, size);
-	dma = isapnp_alloc(sizeof(struct pnp_dma));
+	dma = kcalloc(1, sizeof(struct pnp_dma), GFP_KERNEL);
 	if (!dma)
 		return;
 	dma->map = tmp[0];
@@ -505,7 +494,7 @@
 	struct pnp_port *port;
 
 	isapnp_peek(tmp, size);
-	port = isapnp_alloc(sizeof(struct pnp_port));
+	port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
 	if (!port)
 		return;
 	port->min = (tmp[2] << 8) | tmp[1];
@@ -528,7 +517,7 @@
 	struct pnp_port *port;
 
 	isapnp_peek(tmp, size);
-	port = isapnp_alloc(sizeof(struct pnp_port));
+	port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
 	if (!port)
 		return;
 	port->min = port->max = (tmp[1] << 8) | tmp[0];
@@ -550,7 +539,7 @@
 	struct pnp_mem *mem;
 
 	isapnp_peek(tmp, size);
-	mem = isapnp_alloc(sizeof(struct pnp_mem));
+	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = ((tmp[2] << 8) | tmp[1]) << 8;
@@ -573,7 +562,7 @@
 	struct pnp_mem *mem;
 
 	isapnp_peek(tmp, size);
-	mem = isapnp_alloc(sizeof(struct pnp_mem));
+	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = (tmp[4] << 24) | (tmp[3] << 16) | (tmp[2] << 8) | tmp[1];
@@ -595,7 +584,7 @@
 	struct pnp_mem *mem;
 
 	isapnp_peek(tmp, size);
-	mem = isapnp_alloc(sizeof(struct pnp_mem));
+	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = mem->max = (tmp[4] << 24) | (tmp[3] << 16) | (tmp[2] << 8) | tmp[1];
@@ -838,7 +827,7 @@
 
 static void isapnp_parse_card_id(struct pnp_card * card, unsigned short vendor, unsigned short device)
 {
-	struct pnp_id * id = isapnp_alloc(sizeof(struct pnp_id));
+	struct pnp_id * id = kcalloc(1, sizeof(struct pnp_id), GFP_KERNEL);
 	if (!id)
 		return;
 	sprintf(id->id, "%c%c%c%x%x%x%x",
@@ -874,7 +863,7 @@
 			header[4], header[5], header[6], header[7], header[8]);
 		printk(KERN_DEBUG "checksum = 0x%x\n", checksum);
 #endif
-		if ((card = isapnp_alloc(sizeof(struct pnp_card))) == NULL)
+		if ((card = kcalloc(1, sizeof(struct pnp_card), GFP_KERNEL)) == NULL)
 			continue;
 
 		card->number = csn;
Index: work/drivers/pnp/pnpacpi/core.c
===================================================================
--- work.orig/drivers/pnp/pnpacpi/core.c	2005-07-27 10:43:37.000000000 -0600
+++ work/drivers/pnp/pnpacpi/core.c	2005-07-27 13:28:33.000000000 -0600
@@ -41,15 +41,6 @@
 	return (!acpi_match_ids(dev, excluded_id_list));
 }
 
-void *pnpacpi_kmalloc(size_t size, int f)
-{
-	void *p = kmalloc(size, f);
-
-	if (p)
-		memset(p, 0, size);
-	return p;
-}
-
 /*
  * Compatible Device IDs
  */
@@ -146,7 +137,7 @@
 		return 0;
 
 	pnp_dbg("ACPI device : hid %s", acpi_device_hid(device));
-	dev =  pnpacpi_kmalloc(sizeof(struct pnp_dev), GFP_KERNEL);
+	dev =  kcalloc(1, sizeof(struct pnp_dev), GFP_KERNEL);
 	if (!dev) {
 		pnp_err("Out of memory");
 		return -ENOMEM;
@@ -176,7 +167,7 @@
 	dev->number = num;
 
 	/* set the initial values for the PnP device */
-	dev_id = pnpacpi_kmalloc(sizeof(struct pnp_id), GFP_KERNEL);
+	dev_id = kcalloc(1, sizeof(struct pnp_id), GFP_KERNEL);
 	if (!dev_id)
 		goto err;
 	pnpidacpi_to_pnpid(acpi_device_hid(device), dev_id->id);
@@ -208,8 +199,7 @@
 		for (i = 0; i < cid_list->count; i++) {
 			if (!ispnpidacpi(cid_list->id[i].value))
 				continue;
-			dev_id = pnpacpi_kmalloc(sizeof(struct pnp_id),
-				GFP_KERNEL);
+			dev_id = kcalloc(1, sizeof(struct pnp_id), GFP_KERNEL);
 			if (!dev_id)
 				continue;
 
Index: work/drivers/pnp/pnpacpi/pnpacpi.h
===================================================================
--- work.orig/drivers/pnp/pnpacpi/pnpacpi.h	2005-07-27 10:42:19.000000000 -0600
+++ work/drivers/pnp/pnpacpi/pnpacpi.h	2005-07-27 12:40:00.000000000 -0600
@@ -5,7 +5,6 @@
 #include <linux/acpi.h>
 #include <linux/pnp.h>
 
-void *pnpacpi_kmalloc(size_t size, int f);
 acpi_status pnpacpi_parse_allocated_resource(acpi_handle, struct pnp_resource_table *);
 acpi_status pnpacpi_parse_resource_option_data(acpi_handle, struct pnp_dev *);
 int pnpacpi_encode_resources(struct pnp_resource_table *, struct acpi_buffer *);
Index: work/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work.orig/drivers/pnp/pnpacpi/rsparser.c	2005-07-27 10:42:59.000000000 -0600
+++ work/drivers/pnp/pnpacpi/rsparser.c	2005-07-27 13:30:07.000000000 -0600
@@ -247,7 +247,7 @@
 
 	if (p->number_of_channels == 0)
 		return;
-	dma = pnpacpi_kmalloc(sizeof(struct pnp_dma), GFP_KERNEL);
+	dma = kcalloc(1, sizeof(struct pnp_dma), GFP_KERNEL);
 	if (!dma)
 		return;
 
@@ -302,7 +302,7 @@
 
 	if (p->number_of_interrupts == 0)
 		return;
-	irq = pnpacpi_kmalloc(sizeof(struct pnp_irq), GFP_KERNEL);
+	irq = kcalloc(1, sizeof(struct pnp_irq), GFP_KERNEL);
 	if (!irq)
 		return;
 
@@ -323,7 +323,7 @@
 
 	if (p->number_of_interrupts == 0)
 		return;
-	irq = pnpacpi_kmalloc(sizeof(struct pnp_irq), GFP_KERNEL);
+	irq = kcalloc(1, sizeof(struct pnp_irq), GFP_KERNEL);
 	if (!irq)
 		return;
 
@@ -343,7 +343,7 @@
 
 	if (io->range_length == 0)
 		return;
-	port = pnpacpi_kmalloc(sizeof(struct pnp_port), GFP_KERNEL);
+	port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
 	if (!port)
 		return;
 	port->min = io->min_base_address;
@@ -363,7 +363,7 @@
 
 	if (io->range_length == 0)
 		return;
-	port = pnpacpi_kmalloc(sizeof(struct pnp_port), GFP_KERNEL);
+	port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
 	if (!port)
 		return;
 	port->min = port->max = io->base_address;
@@ -381,7 +381,7 @@
 
 	if (p->range_length == 0)
 		return;
-	mem = pnpacpi_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = p->min_base_address;
@@ -403,7 +403,7 @@
 
 	if (p->range_length == 0)
 		return;
-	mem = pnpacpi_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = p->min_base_address;
@@ -425,7 +425,7 @@
 
 	if (p->range_length == 0)
 		return;
-	mem = pnpacpi_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = mem->max = p->range_base_address;
@@ -609,7 +609,7 @@
 	if (!res_cnt)
 		return -EINVAL;
 	buffer->length = sizeof(struct acpi_resource) * (res_cnt + 1) + 1;
-	buffer->pointer = pnpacpi_kmalloc(buffer->length - 1, GFP_KERNEL);
+	buffer->pointer = kcalloc(1, buffer->length - 1, GFP_KERNEL);
 	if (!buffer->pointer)
 		return -ENOMEM;
 	pnp_dbg("Res cnt %d", res_cnt);
Index: work/drivers/pnp/pnpbios/core.c
===================================================================
--- work.orig/drivers/pnp/pnpbios/core.c	2005-07-25 15:04:26.000000000 -0600
+++ work/drivers/pnp/pnpbios/core.c	2005-07-27 13:32:27.000000000 -0600
@@ -86,16 +86,6 @@
 
 struct pnp_dev_node_info node_info;
 
-void *pnpbios_kmalloc(size_t size, int f)
-{
-	void *p = kmalloc( size, f );
-	if ( p == NULL )
-		printk(KERN_ERR "PnPBIOS: kmalloc() failed\n");
-	else
-		memset(p, 0, size);
-	return p;
-}
-
 /*
  *
  * DOCKING FUNCTIONS
@@ -121,10 +111,10 @@
 	if (!current->fs->root) {
 		return -EAGAIN;
 	}
-	if (!(envp = (char **) pnpbios_kmalloc (20 * sizeof (char *), GFP_KERNEL))) {
+	if (!(envp = (char **) kcalloc (20, sizeof (char *), GFP_KERNEL))) {
 		return -ENOMEM;
 	}
-	if (!(buf = pnpbios_kmalloc (256, GFP_KERNEL))) {
+	if (!(buf = kcalloc (1, 256, GFP_KERNEL))) {
 		kfree (envp);
 		return -ENOMEM;
 	}
@@ -231,7 +221,7 @@
 	if(!pnpbios_is_dynamic(dev))
 		return -EPERM;
 
-	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
+	node = kcalloc(1, node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -1;
 	if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_DYNAMIC, node)) {
@@ -254,7 +244,7 @@
 	if (!pnpbios_is_dynamic(dev))
 		return -EPERM;
 
-	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
+	node = kcalloc(1, node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -1;
 	if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_DYNAMIC, node)) {
@@ -305,7 +295,7 @@
 	if(dev->flags & PNPBIOS_NO_DISABLE || !pnpbios_is_dynamic(dev))
 		return -EPERM;
 
-	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
+	node = kcalloc(1, node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -ENOMEM;
 
@@ -347,7 +337,7 @@
 	}
 
 	/* set the initial values for the PnP device */
-	dev_id = pnpbios_kmalloc(sizeof(struct pnp_id), GFP_KERNEL);
+	dev_id = kcalloc(1, sizeof(struct pnp_id), GFP_KERNEL);
 	if (!dev_id)
 		return -1;
 	pnpid32_to_pnpid(node->eisa_id,id);
@@ -385,7 +375,7 @@
 	struct pnp_bios_node *node;
 	struct pnp_dev *dev;
 
-	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
+	node = kcalloc(1, node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return;
 
@@ -402,7 +392,7 @@
 				break;
 		}
 		nodes_got++;
-		dev =  pnpbios_kmalloc(sizeof (struct pnp_dev), GFP_KERNEL);
+		dev =  kcalloc(1, sizeof (struct pnp_dev), GFP_KERNEL);
 		if (!dev)
 			break;
 		if(insert_device(dev,node)<0)
Index: work/drivers/pnp/pnpbios/pnpbios.h
===================================================================
--- work.orig/drivers/pnp/pnpbios/pnpbios.h	2005-07-25 15:04:26.000000000 -0600
+++ work/drivers/pnp/pnpbios/pnpbios.h	2005-07-27 12:38:19.000000000 -0600
@@ -26,7 +26,6 @@
 
 extern int pnp_bios_present(void);
 extern int  pnpbios_dont_use_current_config;
-extern void *pnpbios_kmalloc(size_t size, int f);
 
 extern int pnpbios_parse_data_stream(struct pnp_dev *dev, struct pnp_bios_node * node);
 extern int pnpbios_read_resources_from_node(struct pnp_resource_table *res, struct pnp_bios_node * node);
Index: work/drivers/pnp/pnpbios/proc.c
===================================================================
--- work.orig/drivers/pnp/pnpbios/proc.c	2005-07-25 15:04:26.000000000 -0600
+++ work/drivers/pnp/pnpbios/proc.c	2005-07-27 13:33:09.000000000 -0600
@@ -87,7 +87,7 @@
 		return -EFBIG;
 	}
 
-	tmpbuf = pnpbios_kmalloc(escd.escd_size, GFP_KERNEL);
+	tmpbuf = kcalloc(1, escd.escd_size, GFP_KERNEL);
 	if (!tmpbuf) return -ENOMEM;
 
 	if (pnp_bios_read_escd(tmpbuf, escd.nv_storage_base)) {
@@ -133,7 +133,7 @@
 	if (pos >= 0xff)
 		return 0;
 
-	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
+	node = kcalloc(1, node_info.max_node_size, GFP_KERNEL);
 	if (!node) return -ENOMEM;
 
 	for (nodenum=pos; nodenum<0xff; ) {
@@ -168,7 +168,7 @@
 	u8 nodenum = (long)data;
 	int len;
 
-	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
+	node = kcalloc(1, node_info.max_node_size, GFP_KERNEL);
 	if (!node) return -ENOMEM;
 	if (pnp_bios_get_dev_node(&nodenum, boot, node)) {
 		kfree(node);
@@ -188,7 +188,7 @@
 	u8 nodenum = (long)data;
 	int ret = count;
 
-	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
+	node = kcalloc(1, node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -ENOMEM;
 	if (pnp_bios_get_dev_node(&nodenum, boot, node)) {
Index: work/drivers/pnp/pnpbios/rsparser.c
===================================================================
--- work.orig/drivers/pnp/pnpbios/rsparser.c	2005-07-25 15:04:26.000000000 -0600
+++ work/drivers/pnp/pnpbios/rsparser.c	2005-07-27 13:33:41.000000000 -0600
@@ -247,7 +247,7 @@
 pnpbios_parse_mem_option(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_mem * mem;
-	mem = pnpbios_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = ((p[5] << 8) | p[4]) << 8;
@@ -263,7 +263,7 @@
 pnpbios_parse_mem32_option(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_mem * mem;
-	mem = pnpbios_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = (p[7] << 24) | (p[6] << 16) | (p[5] << 8) | p[4];
@@ -279,7 +279,7 @@
 pnpbios_parse_fixed_mem32_option(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_mem * mem;
-	mem = pnpbios_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = mem->max = (p[7] << 24) | (p[6] << 16) | (p[5] << 8) | p[4];
@@ -296,7 +296,7 @@
 	struct pnp_irq * irq;
 	unsigned long bits;
 
-	irq = pnpbios_kmalloc(sizeof(struct pnp_irq), GFP_KERNEL);
+	irq = kcalloc(1, sizeof(struct pnp_irq), GFP_KERNEL);
 	if (!irq)
 		return;
 	bits = (p[2] << 8) | p[1];
@@ -313,7 +313,7 @@
 pnpbios_parse_dma_option(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_dma * dma;
-	dma = pnpbios_kmalloc(sizeof(struct pnp_dma), GFP_KERNEL);
+	dma = kcalloc(1, sizeof(struct pnp_dma), GFP_KERNEL);
 	if (!dma)
 		return;
 	dma->map = p[1];
@@ -326,7 +326,7 @@
 pnpbios_parse_port_option(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_port * port;
-	port = pnpbios_kmalloc(sizeof(struct pnp_port), GFP_KERNEL);
+	port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
 	if (!port)
 		return;
 	port->min = (p[3] << 8) | p[2];
@@ -342,7 +342,7 @@
 pnpbios_parse_fixed_port_option(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_port * port;
-	port = pnpbios_kmalloc(sizeof(struct pnp_port), GFP_KERNEL);
+	port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
 	if (!port)
 		return;
 	port->min = port->max = (p[2] << 8) | p[1];
@@ -530,7 +530,7 @@
 		case SMALL_TAG_COMPATDEVID: /* compatible ID */
 			if (len != 4)
 				goto len_err;
-			dev_id =  pnpbios_kmalloc(sizeof (struct pnp_id), GFP_KERNEL);
+			dev_id =  kcalloc(1, sizeof (struct pnp_id), GFP_KERNEL);
 			if (!dev_id)
 				return NULL;
 			memset(dev_id, 0, sizeof(struct pnp_id));
