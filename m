Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274809AbTHFCu4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 22:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274820AbTHFCuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 22:50:55 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:19073 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S274809AbTHFCr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 22:47:29 -0400
Date: Tue, 5 Aug 2003 22:15:45 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Updates for 2.6.0-test2
Message-ID: <20030805221545.GD13275@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030805221415.GB13275@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805221415.GB13275@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# --------------------------------------------
# 03/08/05	ambx1@neo.rr.com	1.1109
# [PNPBIOS] Move Parsing Functions to the PnPBIOS driver
# 
# This patch moves the resource parsing functions from support.c to the
# pnpbios driver.  Originally these functions were intended for other
# pnp protocols but in reality they are only used by the PnPBIOS driver.
# This patch greatly cleans up the code in both the parsing functions
# and their connection with the pnpbios driver.  Also note that
# pnpbios.h has been added for local pnpbios functions.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/pnpbios/Makefile b/drivers/pnp/pnpbios/Makefile
--- a/drivers/pnp/pnpbios/Makefile	Tue Aug  5 21:24:58 2003
+++ b/drivers/pnp/pnpbios/Makefile	Tue Aug  5 21:24:58 2003
@@ -4,4 +4,4 @@
 
 pnpbios-proc-$(CONFIG_PROC_FS) = proc.o
 
-obj-y := core.o $(pnpbios-proc-y)
+obj-y := core.o rsparser.o $(pnpbios-proc-y)
diff -Nru a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	Tue Aug  5 21:24:58 2003
+++ b/drivers/pnp/pnpbios/core.c	Tue Aug  5 21:24:58 2003
@@ -65,6 +65,8 @@
 #include <asm/system.h>
 #include <asm/byteorder.h>
 
+#include "pnpbios.h"
+
 
 /*
  *
@@ -743,80 +745,6 @@
 
 #endif   /* CONFIG_HOTPLUG */
 
-/* pnp EISA ids */
-
-#define HEX(id,a) hex[((id)>>a) & 15]
-#define CHAR(id,a) (0x40 + (((id)>>a) & 31))
-//
-
-static inline void pnpid32_to_pnpid(u32 id, char *str)
-{
-	const char *hex = "0123456789abcdef";
-
-	id = be32_to_cpu(id);
-	str[0] = CHAR(id, 26);
-	str[1] = CHAR(id, 21);
-	str[2] = CHAR(id,16);
-	str[3] = HEX(id, 12);
-	str[4] = HEX(id, 8);
-	str[5] = HEX(id, 4);
-	str[6] = HEX(id, 0);
-	str[7] = '\0';
-
-	return;
-}
-//
-#undef CHAR
-#undef HEX
-
-static void node_id_data_to_dev(unsigned char *p, struct pnp_bios_node *node, struct pnp_dev *dev)
-{
-	int len;
-	char id[8];
-	struct pnp_id *dev_id;
-
-	if ((char *)p == NULL)
-		return;
-        while ( (char *)p < ((char *)node->data + node->size )) {
-
-                if( p[0] & 0x80 ) {
-			len = (p[2] << 8) | p[1];
-			if ((p[0] & 0x7f) == 0x02) /* human readable name */
-			{
-				int size = *(short *) &p[1];
-				memcpy(dev->dev.name, p + 3, len >= 80 ? 79 : size);
-				break;
-			}
-			p += len + 3;
-			continue;
-		}
-		len = p[0] & 0x07;
-		switch ((p[0]>>3) & 0x0f) {
-		case 0x0f: /* end tag */
-		{
-        		return;
-			break;
-		}
-		case 0x03: /* compatible ID */
-		{
-			if (len != 4)
-				goto __skip;
-			dev_id =  pnpbios_kmalloc(sizeof (struct pnp_id), GFP_KERNEL);
-			if (!dev_id)
-				return;
-			memset(dev_id, 0, sizeof(struct pnp_id));
-			pnpid32_to_pnpid(p[1] | p[2] << 8 | p[3] << 16 | p[4] << 24,id);
-			memcpy(&dev_id->id, id, 7);
-			pnp_add_id(dev_id, dev);
-			break;
-		}
-		}
-		__skip:
-		p += len + 1;
-
-	}
-}
-
 static int pnpbios_get_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
 {
 	u8 nodenum = dev->number;
@@ -833,7 +761,7 @@
 		kfree(node);
 		return -ENODEV;
 	}
-	pnp_parse_current_resources((char *)node->data,(char *)node->data + node->size,res);
+	pnpbios_read_resources_from_node(res, node);
 	dev->active = pnp_is_active(dev);
 	kfree(node);
 	return 0;
@@ -854,7 +782,7 @@
 		return -1;
 	if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_STATIC, node))
 		return -ENODEV;
-	if(!pnp_write_resources((char *)node->data,(char *)node->data + node->size,res)){
+	if(pnpbios_write_resources_to_node(res, node)<0) {
 		kfree(node);
 		return -1;
 	}
@@ -869,7 +797,7 @@
 {
 	struct pnp_bios_node * node;
 	int ret;
-	
+
 	/* just in case */
 	if(dev->flags & PNPBIOS_NO_DISABLE || !pnpbios_is_dynamic(dev))
 		return -EPERM;
@@ -897,7 +825,6 @@
 static int insert_device(struct pnp_dev *dev, struct pnp_bios_node * node)
 {
 	struct list_head * pos;
-	unsigned char * p;
 	struct pnp_dev * pnp_dev;
 	struct pnp_id *dev_id;
 	char id[8];
@@ -917,11 +844,7 @@
 	pnpid32_to_pnpid(node->eisa_id,id);
 	memcpy(dev_id->id,id,7);
 	pnp_add_id(dev_id, dev);
-	p = pnp_parse_current_resources((char *)node->data,
-		(char *)node->data + node->size,&dev->res);
-	p = pnp_parse_possible_resources((char *)p,
-		(char *)node->data + node->size,dev);
-	node_id_data_to_dev(p,node,dev);
+	pnpbios_parse_data_stream(dev, node);
 	dev->active = pnp_is_active(dev);
 	dev->flags = node->flags;
 	if (!(dev->flags & PNPBIOS_NO_CONFIG))
diff -Nru a/drivers/pnp/pnpbios/pnpbios.h b/drivers/pnp/pnpbios/pnpbios.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/pnp/pnpbios/pnpbios.h	Tue Aug  5 21:24:58 2003
@@ -0,0 +1,8 @@
+/*
+ * pnpbios.h - contains definitions for functions used only locally.
+ */
+
+extern int pnpbios_parse_data_stream(struct pnp_dev *dev, struct pnp_bios_node * node);
+extern int pnpbios_read_resources_from_node(struct pnp_resource_table *res, struct pnp_bios_node * node);
+extern int pnpbios_write_resources_to_node(struct pnp_resource_table *res, struct pnp_bios_node * node);
+extern void pnpid32_to_pnpid(u32 id, char *str);
diff -Nru a/drivers/pnp/pnpbios/rsparser.c b/drivers/pnp/pnpbios/rsparser.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/pnp/pnpbios/rsparser.c	Tue Aug  5 21:24:58 2003
@@ -0,0 +1,775 @@
+/*
+ * rsparser.c - parses and encodes pnpbios resource data streams
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/ctype.h>
+#include <linux/pnp.h>
+#include <linux/pnpbios.h>
+
+#include "pnpbios.h"
+
+/* standard resource tags */
+#define SMALL_TAG_PNPVERNO		0x01
+#define SMALL_TAG_LOGDEVID		0x02
+#define SMALL_TAG_COMPATDEVID		0x03
+#define SMALL_TAG_IRQ			0x04
+#define SMALL_TAG_DMA			0x05
+#define SMALL_TAG_STARTDEP		0x06
+#define SMALL_TAG_ENDDEP		0x07
+#define SMALL_TAG_PORT			0x08
+#define SMALL_TAG_FIXEDPORT		0x09
+#define SMALL_TAG_VENDOR		0x0e
+#define SMALL_TAG_END			0x0f
+#define LARGE_TAG			0x80
+#define LARGE_TAG_MEM			0x81
+#define LARGE_TAG_ANSISTR		0x82
+#define LARGE_TAG_UNICODESTR		0x83
+#define LARGE_TAG_VENDOR		0x84
+#define LARGE_TAG_MEM32			0x85
+#define LARGE_TAG_FIXEDMEM32		0x86
+
+/*
+ * Resource Data Stream Format:
+ *
+ * Allocated Resources (required)
+ * end tag ->
+ * Resource Configuration Options (optional)
+ * end tag ->
+ * Compitable Device IDs (optional)
+ * final end tag ->
+ */
+
+/*
+ * Allocated Resources
+ */
+
+static void
+pnpbios_parse_allocated_irqresource(struct pnp_resource_table * res, int irq)
+{
+	int i = 0;
+	while ((res->irq_resource[i].flags & IORESOURCE_IRQ) && i < PNP_MAX_IRQ) i++;
+	if (i < PNP_MAX_IRQ) {
+		res->irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
+		if (irq == -1) {
+			res->irq_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->irq_resource[i].start =
+		res->irq_resource[i].end = (unsigned long) irq;
+	}
+}
+
+static void
+pnpbios_parse_allocated_dmaresource(struct pnp_resource_table * res, int dma)
+{
+	int i = 0;
+	while ((res->dma_resource[i].flags & IORESOURCE_DMA) && i < PNP_MAX_DMA) i++;
+	if (i < PNP_MAX_DMA) {
+		res->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
+		if (dma == -1) {
+			res->dma_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->dma_resource[i].start =
+		res->dma_resource[i].end = (unsigned long) dma;
+	}
+}
+
+static void
+pnpbios_parse_allocated_ioresource(struct pnp_resource_table * res, int io, int len)
+{
+	int i = 0;
+	while ((res->port_resource[i].flags & IORESOURCE_IO) && i < PNP_MAX_PORT) i++;
+	if (i < PNP_MAX_PORT) {
+		res->port_resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
+		if (len <= 0 || (io + len -1) >= 0x10003) {
+			res->port_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->port_resource[i].start = (unsigned long) io;
+		res->port_resource[i].end = (unsigned long)(io + len - 1);
+	}
+}
+
+static void
+pnpbios_parse_allocated_memresource(struct pnp_resource_table * res, int mem, int len)
+{
+	int i = 0;
+	while ((res->mem_resource[i].flags & IORESOURCE_MEM) && i < PNP_MAX_MEM) i++;
+	if (i < PNP_MAX_MEM) {
+		res->mem_resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
+		if (len <= 0) {
+			res->mem_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->mem_resource[i].start = (unsigned long) mem;
+		res->mem_resource[i].end = (unsigned long)(mem + len - 1);
+	}
+}
+
+static unsigned char *
+pnpbios_parse_allocated_resource_data(unsigned char * p, unsigned char * end, struct pnp_resource_table * res)
+{
+	unsigned int len, tag;
+	int io, size, mask, i;
+
+	if (!p)
+		return NULL;
+
+	/* Blank the resource table values */
+	pnp_init_resource_table(res);
+
+	while ((char *)p < (char *)end) {
+
+		/* determine the type of tag */
+		if (p[0] & LARGE_TAG) { /* large tag */
+			len = (p[2] << 8) | p[1];
+			tag = p[0];
+		} else { /* small tag */
+			len = p[0] & 0x07;
+			tag = ((p[0]>>3) & 0x0f);
+		}
+
+		switch (tag) {
+
+		case LARGE_TAG_MEM:
+			if (len != 9)
+				goto len_err;
+			io = *(short *) &p[4];
+			size = *(short *) &p[10];
+			pnpbios_parse_allocated_memresource(res, io, size);
+			break;
+
+		case LARGE_TAG_ANSISTR:
+			/* ignore this for now */
+			break;
+
+		case LARGE_TAG_VENDOR:
+			/* do nothing */
+			break;
+
+		case LARGE_TAG_MEM32:
+			if (len != 17)
+				goto len_err;
+			io = *(int *) &p[4];
+			size = *(int *) &p[16];
+			pnpbios_parse_allocated_memresource(res, io, size);
+			break;
+
+		case LARGE_TAG_FIXEDMEM32:
+			if (len != 9)
+				goto len_err;
+			io = *(int *) &p[4];
+			size = *(int *) &p[8];
+			pnpbios_parse_allocated_memresource(res, io, size);
+			break;
+
+		case SMALL_TAG_IRQ:
+			if (len < 2 || len > 3)
+				goto len_err;
+			io = -1;
+			mask= p[1] + p[2]*256;
+			for (i=0;i<16;i++, mask=mask>>1)
+				if(mask & 0x01) io=i;
+			pnpbios_parse_allocated_irqresource(res, io);
+			break;
+
+		case SMALL_TAG_DMA:
+			if (len != 2)
+				goto len_err;
+			io = -1;
+			mask = p[1];
+			for (i=0;i<8;i++, mask = mask>>1)
+				if(mask & 0x01) io=i;
+			pnpbios_parse_allocated_dmaresource(res, io);
+			break;
+
+		case SMALL_TAG_PORT:
+			if (len != 7)
+				goto len_err;
+			io = p[2] + p[3] *256;
+			size = p[7];
+			pnpbios_parse_allocated_ioresource(res, io, size);
+			break;
+
+		case SMALL_TAG_VENDOR:
+			/* do nothing */
+			break;
+
+		case SMALL_TAG_FIXEDPORT:
+			if (len != 3)
+				goto len_err;
+			io = p[1] + p[2] * 256;
+			size = p[3];
+			pnpbios_parse_allocated_ioresource(res, io, size);
+			break;
+
+		case SMALL_TAG_END:
+			p = p + 2;
+        		return (unsigned char *)p;
+			break;
+
+		default: /* an unkown tag */
+			len_err:
+			printk(KERN_ERR "PnPBIOS: Unknown tag '0x%x', length '%d'.\n", tag, len);
+			break;
+		}
+
+		/* continue to the next tag */
+		if (p[0] & LARGE_TAG)
+			p += len + 3;
+		else
+			p += len + 1;
+	}
+
+	printk(KERN_ERR "PnPBIOS: Resource structure does not contain an end tag.\n");
+
+	return NULL;
+}
+
+
+/*
+ * Resource Configuration Options
+ */
+
+static void
+pnpbios_parse_mem_option(unsigned char *p, int size, struct pnp_option *option)
+{
+	struct pnp_mem * mem;
+	mem = pnpbios_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	if (!mem)
+		return;
+	mem->min = ((p[5] << 8) | p[4]) << 8;
+	mem->max = ((p[7] << 8) | p[6]) << 8;
+	mem->align = (p[9] << 8) | p[8];
+	mem->size = ((p[11] << 8) | p[10]) << 8;
+	mem->flags = p[3];
+	pnp_register_mem_resource(option,mem);
+	return;
+}
+
+static void
+pnpbios_parse_mem32_option(unsigned char *p, int size, struct pnp_option *option)
+{
+	struct pnp_mem * mem;
+	mem = pnpbios_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	if (!mem)
+		return;
+	mem->min = (p[7] << 24) | (p[6] << 16) | (p[5] << 8) | p[4];
+	mem->max = (p[11] << 24) | (p[10] << 16) | (p[9] << 8) | p[8];
+	mem->align = (p[15] << 24) | (p[14] << 16) | (p[13] << 8) | p[12];
+	mem->size = (p[19] << 24) | (p[18] << 16) | (p[17] << 8) | p[16];
+	mem->flags = p[3];
+	pnp_register_mem_resource(option,mem);
+	return;
+}
+
+static void
+pnpbios_parse_fixed_mem32_option(unsigned char *p, int size, struct pnp_option *option)
+{
+	struct pnp_mem * mem;
+	mem = pnpbios_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	if (!mem)
+		return;
+	mem->min = mem->max = (p[7] << 24) | (p[6] << 16) | (p[5] << 8) | p[4];
+	mem->size = (p[11] << 24) | (p[10] << 16) | (p[9] << 8) | p[8];
+	mem->align = 0;
+	mem->flags = p[3];
+	pnp_register_mem_resource(option,mem);
+	return;
+}
+
+static void
+pnpbios_parse_irq_option(unsigned char *p, int size, struct pnp_option *option)
+{
+	struct pnp_irq * irq;
+	irq = pnpbios_kmalloc(sizeof(struct pnp_irq), GFP_KERNEL);
+	if (!irq)
+		return;
+	irq->map = (p[2] << 8) | p[1];
+	if (size > 2)
+		irq->flags = p[3];
+	else
+		irq->flags = IORESOURCE_IRQ_HIGHEDGE;
+	pnp_register_irq_resource(option,irq);
+	return;
+}
+
+static void
+pnpbios_parse_dma_option(unsigned char *p, int size, struct pnp_option *option)
+{
+	struct pnp_dma * dma;
+	dma = pnpbios_kmalloc(sizeof(struct pnp_dma), GFP_KERNEL);
+	if (!dma)
+		return;
+	dma->map = p[1];
+	dma->flags = p[2];
+	pnp_register_dma_resource(option,dma);
+	return;
+}
+
+static void
+pnpbios_parse_port_option(unsigned char *p, int size, struct pnp_option *option)
+{
+	struct pnp_port * port;
+	port = pnpbios_kmalloc(sizeof(struct pnp_port), GFP_KERNEL);
+	if (!port)
+		return;
+	port->min = (p[3] << 8) | p[2];
+	port->max = (p[5] << 8) | p[4];
+	port->align = p[6];
+	port->size = p[7];
+	port->flags = p[1] ? PNP_PORT_FLAG_16BITADDR : 0;
+	pnp_register_port_resource(option,port);
+	return;
+}
+
+static void
+pnpbios_parse_fixed_port_option(unsigned char *p, int size, struct pnp_option *option)
+{
+	struct pnp_port * port;
+	port = pnpbios_kmalloc(sizeof(struct pnp_port), GFP_KERNEL);
+	if (!port)
+		return;
+	port->min = port->max = (p[2] << 8) | p[1];
+	port->size = p[3];
+	port->align = 0;
+	port->flags = PNP_PORT_FLAG_FIXED;
+	pnp_register_port_resource(option,port);
+	return;
+}
+
+static unsigned char *
+pnpbios_parse_resource_option_data(unsigned char * p, unsigned char * end, struct pnp_dev *dev)
+{
+	unsigned int len, tag;
+	int priority = 0;
+	struct pnp_option *option;
+
+	if (!p)
+		return NULL;
+
+	option = pnp_register_independent_option(dev);
+	if (!option)
+		return NULL;
+
+	while ((char *)p < (char *)end) {
+
+		/* determine the type of tag */
+		if (p[0] & LARGE_TAG) { /* large tag */
+			len = (p[2] << 8) | p[1];
+			tag = p[0];
+		} else { /* small tag */
+			len = p[0] & 0x07;
+			tag = ((p[0]>>3) & 0x0f);
+		}
+
+		switch (tag) {
+
+		case LARGE_TAG_MEM:
+			if (len != 9)
+				goto len_err;
+			pnpbios_parse_mem_option(p, len, option);
+			break;
+
+		case LARGE_TAG_MEM32:
+			if (len != 17)
+				goto len_err;
+			pnpbios_parse_mem32_option(p, len, option);
+			break;
+
+		case LARGE_TAG_FIXEDMEM32:
+			if (len != 9)
+				goto len_err;
+			pnpbios_parse_fixed_mem32_option(p, len, option);
+			break;
+
+		case SMALL_TAG_IRQ:
+			if (len < 2 || len > 3)
+				goto len_err;
+			pnpbios_parse_irq_option(p, len, option);
+			break;
+
+		case SMALL_TAG_DMA:
+			if (len != 2)
+				goto len_err;
+			pnpbios_parse_dma_option(p, len, option);
+			break;
+
+		case SMALL_TAG_PORT:
+			if (len != 7)
+				goto len_err;
+			pnpbios_parse_port_option(p, len, option);
+			break;
+
+		case SMALL_TAG_VENDOR:
+			/* do nothing */
+			break;
+
+		case SMALL_TAG_FIXEDPORT:
+			if (len != 3)
+				goto len_err;
+			pnpbios_parse_fixed_port_option(p, len, option);
+			break;
+
+		case SMALL_TAG_STARTDEP:
+			if (len > 1)
+				goto len_err;
+			priority = 0x100 | PNP_RES_PRIORITY_ACCEPTABLE;
+			if (len > 0)
+				priority = 0x100 | p[1];
+			option = pnp_register_dependent_option(dev, priority);
+			if (!option)
+				return NULL;
+			break;
+
+		case SMALL_TAG_ENDDEP:
+			if (len != 0)
+				goto len_err;
+			break;
+
+		case SMALL_TAG_END:
+			p = p + 2;
+        		return (unsigned char *)p;
+			break;
+
+		default: /* an unkown tag */
+			len_err:
+			printk(KERN_ERR "PnPBIOS: Unknown tag '0x%x', length '%d'.\n", tag, len);
+			break;
+		}
+
+		/* continue to the next tag */
+		if (p[0] & LARGE_TAG)
+			p += len + 3;
+		else
+			p += len + 1;
+	}
+
+	printk(KERN_ERR "PnPBIOS: Resource structure does not contain an end tag.\n");
+
+	return NULL;
+}
+
+
+/*
+ * Compatible Device IDs
+ */
+
+#define HEX(id,a) hex[((id)>>a) & 15]
+#define CHAR(id,a) (0x40 + (((id)>>a) & 31))
+//
+
+void pnpid32_to_pnpid(u32 id, char *str)
+{
+	const char *hex = "0123456789abcdef";
+
+	id = be32_to_cpu(id);
+	str[0] = CHAR(id, 26);
+	str[1] = CHAR(id, 21);
+	str[2] = CHAR(id,16);
+	str[3] = HEX(id, 12);
+	str[4] = HEX(id, 8);
+	str[5] = HEX(id, 4);
+	str[6] = HEX(id, 0);
+	str[7] = '\0';
+
+	return;
+}
+//
+#undef CHAR
+#undef HEX
+
+static unsigned char *
+pnpbios_parse_compatible_ids(unsigned char *p, unsigned char *end, struct pnp_dev *dev)
+{
+	int len, tag;
+	char id[8];
+	struct pnp_id *dev_id;
+
+	if (!p)
+		return NULL;
+
+	while ((char *)p < (char *)end) {
+
+		/* determine the type of tag */
+		if (p[0] & LARGE_TAG) { /* large tag */
+			len = (p[2] << 8) | p[1];
+			tag = p[0];
+		} else { /* small tag */
+			len = p[0] & 0x07;
+			tag = ((p[0]>>3) & 0x0f);
+		}
+
+		switch (tag) {
+
+		case SMALL_TAG_COMPATDEVID: /* compatible ID */
+			if (len != 4)
+				goto len_err;
+			dev_id =  pnpbios_kmalloc(sizeof (struct pnp_id), GFP_KERNEL);
+			if (!dev_id)
+				return NULL;
+			memset(dev_id, 0, sizeof(struct pnp_id));
+			pnpid32_to_pnpid(p[1] | p[2] << 8 | p[3] << 16 | p[4] << 24,id);
+			memcpy(&dev_id->id, id, 7);
+			pnp_add_id(dev_id, dev);
+			break;
+
+		case SMALL_TAG_END:
+			p = p + 2;
+        		return (unsigned char *)p;
+			break;
+
+		default: /* an unkown tag */
+			len_err:
+			printk(KERN_ERR "PnPBIOS: Unknown tag '0x%x', length '%d'.\n", tag, len);
+			break;
+		}
+
+		/* continue to the next tag */
+		if (p[0] & LARGE_TAG)
+			p += len + 3;
+		else
+			p += len + 1;
+	}
+
+	printk(KERN_ERR "PnPBIOS: Resource structure does not contain an end tag.\n");
+
+	return NULL;
+}
+
+
+/*
+ * Allocated Resource Encoding
+ */
+
+static void pnpbios_encode_mem(unsigned char *p, struct resource * res)
+{
+	unsigned long base = res->start;
+	unsigned long len = res->end - res->start + 1;
+	p[4] = (base >> 8) & 0xff;
+	p[5] = ((base >> 8) >> 8) & 0xff;
+	p[6] = (base >> 8) & 0xff;
+	p[7] = ((base >> 8) >> 8) & 0xff;
+	p[10] = (len >> 8) & 0xff;
+	p[11] = ((len >> 8) >> 8) & 0xff;
+	return;
+}
+
+static void pnpbios_encode_mem32(unsigned char *p, struct resource * res)
+{
+	unsigned long base = res->start;
+	unsigned long len = res->end - res->start + 1;
+	p[4] = base & 0xff;
+	p[5] = (base >> 8) & 0xff;
+	p[6] = (base >> 16) & 0xff;
+	p[7] = (base >> 24) & 0xff;
+	p[8] = base & 0xff;
+	p[9] = (base >> 8) & 0xff;
+	p[10] = (base >> 16) & 0xff;
+	p[11] = (base >> 24) & 0xff;
+	p[16] = len & 0xff;
+	p[17] = (len >> 8) & 0xff;
+	p[18] = (len >> 16) & 0xff;
+	p[19] = (len >> 24) & 0xff;
+	return;
+}
+
+static void pnpbios_encode_fixed_mem32(unsigned char *p, struct resource * res)
+{	unsigned long base = res->start;
+	unsigned long len = res->end - res->start + 1;
+	p[4] = base & 0xff;
+	p[5] = (base >> 8) & 0xff;
+	p[6] = (base >> 16) & 0xff;
+	p[7] = (base >> 24) & 0xff;
+	p[8] = len & 0xff;
+	p[9] = (len >> 8) & 0xff;
+	p[10] = (len >> 16) & 0xff;
+	p[11] = (len >> 24) & 0xff;
+	return;
+}
+
+static void pnpbios_encode_irq(unsigned char *p, struct resource * res)
+{
+	unsigned long map = 0;
+	map = 1 << res->start;
+	p[1] = map & 0xff;
+	p[2] = (map >> 8) & 0xff;
+	return;
+}
+
+static void pnpbios_encode_dma(unsigned char *p, struct resource * res)
+{
+	unsigned long map = 0;
+	map = 1 << res->start;
+	p[1] = map & 0xff;
+	return;
+}
+
+static void pnpbios_encode_port(unsigned char *p, struct resource * res)
+{
+	unsigned long base = res->start;
+	unsigned long len = res->end - res->start + 1;
+	p[2] = base & 0xff;
+	p[3] = (base >> 8) & 0xff;
+	p[4] = base & 0xff;
+	p[5] = (base >> 8) & 0xff;
+	p[7] = len & 0xff;
+	return;
+}
+
+static void pnpbios_encode_fixed_port(unsigned char *p, struct resource * res)
+{
+	unsigned long base = res->start;
+	unsigned long len = res->end - res->start + 1;
+	p[1] = base & 0xff;
+	p[2] = (base >> 8) & 0xff;
+	p[3] = len & 0xff;
+	return;
+}
+
+static unsigned char *
+pnpbios_encode_allocated_resource_data(unsigned char * p, unsigned char * end, struct pnp_resource_table * res)
+{
+	unsigned int len, tag;
+	int port = 0, irq = 0, dma = 0, mem = 0;
+
+	if (!p)
+		return NULL;
+
+	while ((char *)p < (char *)end) {
+
+		/* determine the type of tag */
+		if (p[0] & LARGE_TAG) { /* large tag */
+			len = (p[2] << 8) | p[1];
+			tag = p[0];
+		} else { /* small tag */
+			len = p[0] & 0x07;
+			tag = ((p[0]>>3) & 0x0f);
+		}
+
+		switch (tag) {
+
+		case LARGE_TAG_MEM:
+			if (len != 9)
+				goto len_err;
+			pnpbios_encode_mem(p, &res->mem_resource[mem]);
+			mem++;
+			break;
+
+		case LARGE_TAG_MEM32:
+			if (len != 17)
+				goto len_err;
+			pnpbios_encode_mem32(p, &res->mem_resource[mem]);
+			mem++;
+			break;
+
+		case LARGE_TAG_FIXEDMEM32:
+			if (len != 9)
+				goto len_err;
+			pnpbios_encode_fixed_mem32(p, &res->mem_resource[mem]);
+			mem++;
+			break;
+
+		case SMALL_TAG_IRQ:
+			if (len < 2 || len > 3)
+				goto len_err;
+			pnpbios_encode_irq(p, &res->irq_resource[irq]);
+			irq++;
+			break;
+
+		case SMALL_TAG_DMA:
+			if (len != 2)
+				goto len_err;
+			pnpbios_encode_dma(p, &res->dma_resource[dma]);
+			dma++;
+			break;
+
+		case SMALL_TAG_PORT:
+			if (len != 7)
+				goto len_err;
+			pnpbios_encode_port(p, &res->port_resource[port]);
+			port++;
+			break;
+
+		case SMALL_TAG_VENDOR:
+			/* do nothing */
+			break;
+
+		case SMALL_TAG_FIXEDPORT:
+			if (len != 3)
+				goto len_err;
+			pnpbios_encode_fixed_port(p, &res->port_resource[port]);
+			port++;
+			break;
+
+		case SMALL_TAG_END:
+			p = p + 2;
+        		return (unsigned char *)p;
+			break;
+
+		default: /* an unkown tag */
+			len_err:
+			printk(KERN_ERR "PnPBIOS: Unknown tag '0x%x', length '%d'.\n", tag, len);
+			break;
+		}
+
+		/* continue to the next tag */
+		if (p[0] & LARGE_TAG)
+			p += len + 3;
+		else
+			p += len + 1;
+	}
+
+	printk(KERN_ERR "PnPBIOS: Resource structure does not contain an end tag.\n");
+
+	return NULL;
+}
+
+
+/*
+ * Core Parsing Functions
+ */
+
+int
+pnpbios_parse_data_stream(struct pnp_dev *dev, struct pnp_bios_node * node)
+{
+	unsigned char * p = (char *)node->data;
+	unsigned char * end = (char *)(node->data + node->size);
+	p = pnpbios_parse_allocated_resource_data(p,end,&dev->res);
+	if (!p)
+		return -EIO;
+	p = pnpbios_parse_resource_option_data(p,end,dev);
+	if (!p)
+		return -EIO;
+	p = pnpbios_parse_compatible_ids(p,end,dev);
+	if (!p)
+		return -EIO;
+	return 0;
+}
+
+int
+pnpbios_read_resources_from_node(struct pnp_resource_table *res,
+				 struct pnp_bios_node * node)
+{
+	unsigned char * p = (char *)node->data;
+	unsigned char * end = (char *)(node->data + node->size);
+	p = pnpbios_parse_allocated_resource_data(p,end,res);
+	if (!p)
+		return -EIO;
+	return 0;
+}
+
+int
+pnpbios_write_resources_to_node(struct pnp_resource_table *res,
+				struct pnp_bios_node * node)
+{
+	unsigned char * p = (char *)node->data;
+	unsigned char * end = (char *)(node->data + node->size);
+	p = pnpbios_encode_allocated_resource_data(p,end,res);
+	if (!p)
+		return -EIO;
+	return 0;
+}
diff -Nru a/drivers/pnp/support.c b/drivers/pnp/support.c
--- a/drivers/pnp/support.c	Tue Aug  5 21:24:58 2003
+++ b/drivers/pnp/support.c	Tue Aug  5 21:24:58 2003
@@ -3,9 +3,6 @@
  *
  * Copyright 2003 Adam Belay <ambx1@neo.rr.com>
  *
- * Resource parsing functions are based on those in the linux pnpbios driver.
- * Copyright Christian Schmidt, Tom Lees, David Hinds, Alan Cox, Thomas Hood,
- * Brian Gerst and Adam Belay.
  */
 
 #include <linux/config.h>
@@ -21,26 +18,6 @@
 #include <linux/pnp.h>
 #include "base.h"
 
-#define SMALL_TAG_PNPVERNO		0x01
-#define SMALL_TAG_LOGDEVID		0x02
-#define SMALL_TAG_COMPATDEVID		0x03
-#define SMALL_TAG_IRQ			0x04
-#define SMALL_TAG_DMA			0x05
-#define SMALL_TAG_STARTDEP		0x06
-#define SMALL_TAG_ENDDEP		0x07
-#define SMALL_TAG_PORT			0x08
-#define SMALL_TAG_FIXEDPORT		0x09
-#define SMALL_TAG_VENDOR		0x0e
-#define SMALL_TAG_END			0x0f
-#define LARGE_TAG			0x80
-#define LARGE_TAG_MEM			0x01
-#define LARGE_TAG_ANSISTR		0x02
-#define LARGE_TAG_UNICODESTR		0x03
-#define LARGE_TAG_VENDOR		0x04
-#define LARGE_TAG_MEM32			0x05
-#define LARGE_TAG_FIXEDMEM32		0x06
-
-
 /**
  * pnp_is_active - Determines if a device is active based on its current resources
  * @dev: pointer to the desired PnP device
@@ -59,639 +36,5 @@
 }
 
 
-/*
- * Current resource reading functions *
- */
-
-static void current_irqresource(struct pnp_resource_table * res, int irq)
-{
-	int i = 0;
-	while ((res->irq_resource[i].flags & IORESOURCE_IRQ) && i < PNP_MAX_IRQ) i++;
-	if (i < PNP_MAX_IRQ) {
-		res->irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
-		if (irq == -1) {
-			res->irq_resource[i].flags |= IORESOURCE_DISABLED;
-			return;
-		}
-		res->irq_resource[i].start =
-		res->irq_resource[i].end = (unsigned long) irq;
-	}
-}
-
-static void current_dmaresource(struct pnp_resource_table * res, int dma)
-{
-	int i = 0;
-	while ((res->dma_resource[i].flags & IORESOURCE_DMA) && i < PNP_MAX_DMA) i++;
-	if (i < PNP_MAX_DMA) {
-		res->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
-		if (dma == -1) {
-			res->dma_resource[i].flags |= IORESOURCE_DISABLED;
-			return;
-		}
-		res->dma_resource[i].start =
-		res->dma_resource[i].end = (unsigned long) dma;
-	}
-}
-
-static void current_ioresource(struct pnp_resource_table * res, int io, int len)
-{
-	int i = 0;
-	while ((res->port_resource[i].flags & IORESOURCE_IO) && i < PNP_MAX_PORT) i++;
-	if (i < PNP_MAX_PORT) {
-		res->port_resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
-		if (len <= 0 || (io + len -1) >= 0x10003) {
-			res->port_resource[i].flags |= IORESOURCE_DISABLED;
-			return;
-		}
-		res->port_resource[i].start = (unsigned long) io;
-		res->port_resource[i].end = (unsigned long)(io + len - 1);
-	}
-}
-
-static void current_memresource(struct pnp_resource_table * res, int mem, int len)
-{
-	int i = 0;
-	while ((res->mem_resource[i].flags & IORESOURCE_MEM) && i < PNP_MAX_MEM) i++;
-	if (i < PNP_MAX_MEM) {
-		res->mem_resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
-		if (len <= 0) {
-			res->mem_resource[i].flags |= IORESOURCE_DISABLED;
-			return;
-		}
-		res->mem_resource[i].start = (unsigned long) mem;
-		res->mem_resource[i].end = (unsigned long)(mem + len - 1);
-	}
-}
-
-/**
- * pnp_parse_current_resources - Extracts current resource information from a raw PnP resource structure
- * @p: pointer to the start of the structure
- * @end: pointer to the end of the structure
- * @res: pointer to the resource table to record to
- *
- */
-
-unsigned char * pnp_parse_current_resources(unsigned char * p, unsigned char * end, struct pnp_resource_table * res)
-{
-	int len;
-
-	if (!p)
-		return NULL;
-
-	/* Blank the resource table values */
-	pnp_init_resource_table(res);
-
-	while ((char *)p < (char *)end) {
-
-		if(p[0] & LARGE_TAG) { /* large tag */
-			len = (p[2] << 8) | p[1];
-			switch (p[0] & 0x7f) {
-			case LARGE_TAG_MEM:
-			{
-				int io = *(short *) &p[4];
-				int size = *(short *) &p[10];
-				if (len != 9)
-					goto lrg_err;
-				current_memresource(res, io, size);
-				break;
-			}
-			case LARGE_TAG_ANSISTR:
-			{
-				/* ignore this for now */
-				break;
-			}
-			case LARGE_TAG_VENDOR:
-			{
-				/* do nothing */
-				break;
-			}
-			case LARGE_TAG_MEM32:
-			{
-				int io = *(int *) &p[4];
-				int size = *(int *) &p[16];
-				if (len != 17)
-					goto lrg_err;
-				current_memresource(res, io, size);
-				break;
-			}
-			case LARGE_TAG_FIXEDMEM32:
-			{
-				int io = *(int *) &p[4];
-				int size = *(int *) &p[8];
-				if (len != 9)
-					goto lrg_err;
-				current_memresource(res, io, size);
-				break;
-			}
-			default: /* an unkown tag */
-			{
-				lrg_err:
-				pnp_warn("parser: Unknown large tag '0x%x'.", p[0] & 0x7f);
-				break;
-			}
-			} /* switch */
-			p += len + 3;
-			continue;
-		} /* end large tag */
-
-		/* small tag */
-		len = p[0] & 0x07;
-		switch ((p[0]>>3) & 0x0f) {
-		case SMALL_TAG_IRQ:
-		{
-			int i, mask, irq = -1;
-			if (len < 2 || len > 3)
-				goto sm_err;
-			mask= p[1] + p[2]*256;
-			for (i=0;i<16;i++, mask=mask>>1)
-				if(mask & 0x01) irq=i;
-			current_irqresource(res, irq);
-			break;
-		}
-		case SMALL_TAG_DMA:
-		{
-			int i, mask, dma = -1;
-			if (len != 2)
-				goto sm_err;
-			mask = p[1];
-			for (i=0;i<8;i++, mask = mask>>1)
-				if(mask & 0x01) dma=i;
-			current_dmaresource(res, dma);
-			break;
-		}
-		case SMALL_TAG_PORT:
-		{
-			int io= p[2] + p[3] *256;
-			int size = p[7];
-			if (len != 7)
-				goto sm_err;
-			current_ioresource(res, io, size);
-			break;
-		}
-		case SMALL_TAG_VENDOR:
-		{
-			/* do nothing */
-			break;
-		}
-		case SMALL_TAG_FIXEDPORT:
-		{
-			int io = p[1] + p[2] * 256;
-			int size = p[3];
-			if (len != 3)
-				goto sm_err;
-			current_ioresource(res, io, size);
-			break;
-		}
-		case SMALL_TAG_END:
-		{
-			p = p + 2;
-        		return (unsigned char *)p;
-			break;
-		}
-		default: /* an unkown tag */
-		{
-			sm_err:
-			pnp_warn("parser: Unknown small tag '0x%x'.", p[0]>>3);
-			break;
-		}
-		}
-                p += len + 1;
-	}
-	pnp_err("parser: Resource structure does not contain an end tag.");
-
-	return NULL;
-}
-
-
-/*
- * Possible resource reading functions *
- */
-
-static void possible_mem(unsigned char *p, int size, struct pnp_option *option)
-{
-	struct pnp_mem * mem;
-	mem = pnp_alloc(sizeof(struct pnp_mem));
-	if (!mem)
-		return;
-	mem->min = ((p[5] << 8) | p[4]) << 8;
-	mem->max = ((p[7] << 8) | p[6]) << 8;
-	mem->align = (p[9] << 8) | p[8];
-	mem->size = ((p[11] << 8) | p[10]) << 8;
-	mem->flags = p[3];
-	pnp_register_mem_resource(option,mem);
-	return;
-}
-
-static void possible_mem32(unsigned char *p, int size, struct pnp_option *option)
-{
-	struct pnp_mem * mem;
-	mem = pnp_alloc(sizeof(struct pnp_mem));
-	if (!mem)
-		return;
-	mem->min = (p[7] << 24) | (p[6] << 16) | (p[5] << 8) | p[4];
-	mem->max = (p[11] << 24) | (p[10] << 16) | (p[9] << 8) | p[8];
-	mem->align = (p[15] << 24) | (p[14] << 16) | (p[13] << 8) | p[12];
-	mem->size = (p[19] << 24) | (p[18] << 16) | (p[17] << 8) | p[16];
-	mem->flags = p[3];
-	pnp_register_mem_resource(option,mem);
-	return;
-}
-
-static void possible_fixed_mem32(unsigned char *p, int size, struct pnp_option *option)
-{
-	struct pnp_mem * mem;
-	mem = pnp_alloc(sizeof(struct pnp_mem));
-	if (!mem)
-		return;
-	mem->min = mem->max = (p[7] << 24) | (p[6] << 16) | (p[5] << 8) | p[4];
-	mem->size = (p[11] << 24) | (p[10] << 16) | (p[9] << 8) | p[8];
-	mem->align = 0;
-	mem->flags = p[3];
-	pnp_register_mem_resource(option,mem);
-	return;
-}
-
-static void possible_irq(unsigned char *p, int size, struct pnp_option *option)
-{
-	struct pnp_irq * irq;
-	irq = pnp_alloc(sizeof(struct pnp_irq));
-	if (!irq)
-		return;
-	irq->map = (p[2] << 8) | p[1];
-	if (size > 2)
-		irq->flags = p[3];
-	else
-		irq->flags = IORESOURCE_IRQ_HIGHEDGE;
-	pnp_register_irq_resource(option,irq);
-	return;
-}
-
-static void possible_dma(unsigned char *p, int size, struct pnp_option *option)
-{
-	struct pnp_dma * dma;
-	dma = pnp_alloc(sizeof(struct pnp_dma));
-	if (!dma)
-		return;
-	dma->map = p[1];
-	dma->flags = p[2];
-	pnp_register_dma_resource(option,dma);
-	return;
-}
-
-static void possible_port(unsigned char *p, int size, struct pnp_option *option)
-{
-	struct pnp_port * port;
-	port = pnp_alloc(sizeof(struct pnp_port));
-	if (!port)
-		return;
-	port->min = (p[3] << 8) | p[2];
-	port->max = (p[5] << 8) | p[4];
-	port->align = p[6];
-	port->size = p[7];
-	port->flags = p[1] ? PNP_PORT_FLAG_16BITADDR : 0;
-	pnp_register_port_resource(option,port);
-	return;
-}
-
-static void possible_fixed_port(unsigned char *p, int size, struct pnp_option *option)
-{
-	struct pnp_port * port;
-	port = pnp_alloc(sizeof(struct pnp_port));
-	if (!port)
-		return;
-	port->min = port->max = (p[2] << 8) | p[1];
-	port->size = p[3];
-	port->align = 0;
-	port->flags = PNP_PORT_FLAG_FIXED;
-	pnp_register_port_resource(option,port);
-	return;
-}
-
-/**
- * pnp_parse_possible_resources - Extracts possible resource information from a raw PnP resource structure
- * @p: pointer to the start of the structure
- * @end: pointer to the end of the structure
- * @dev: pointer to the desired PnP device
- *
- */
-
-unsigned char * pnp_parse_possible_resources(unsigned char * p, unsigned char * end, struct pnp_dev *dev)
-{
-	int len, priority = 0;
-	struct pnp_option *option;
-
-	if (!p)
-		return NULL;
-
-	option = pnp_register_independent_option(dev);
-	if (!option)
-		return NULL;
-
-	while ((char *)p < (char *)end) {
-
-		if(p[0] & LARGE_TAG) { /* large tag */
-			len = (p[2] << 8) | p[1];
-			switch (p[0] & 0x7f) {
-			case LARGE_TAG_MEM:
-			{
-				if (len != 9)
-					goto lrg_err;
-				possible_mem(p,len,option);
-				break;
-			}
-			case LARGE_TAG_MEM32:
-			{
-				if (len != 17)
-					goto lrg_err;
-				possible_mem32(p,len,option);
-				break;
-			}
-			case LARGE_TAG_FIXEDMEM32:
-			{
-				if (len != 9)
-					goto lrg_err;
-				possible_fixed_mem32(p,len,option);
-				break;
-			}
-			default: /* an unkown tag */
-			{
-				lrg_err:
-				pnp_warn("parser: Unknown large tag '0x%x'.", p[0] & 0x7f);
-				break;
-			}
-			} /* switch */
-                        p += len + 3;
-			continue;
-		} /* end large tag */
-
-		/* small tag */
-		len = p[0] & 0x07;
-		switch ((p[0]>>3) & 0x0f) {
-		case SMALL_TAG_IRQ:
-		{
-			if (len < 2 || len > 3)
-				goto sm_err;
-			possible_irq(p,len,option);
-			break;
-		}
-		case SMALL_TAG_DMA:
-		{
-			if (len != 2)
-				goto sm_err;
-			possible_dma(p,len,option);
-			break;
-		}
-		case SMALL_TAG_STARTDEP:
-		{
-			if (len > 1)
-				goto sm_err;
-			priority = 0x100 | PNP_RES_PRIORITY_ACCEPTABLE;
-			if (len > 0)
-				priority = 0x100 | p[1];
-			option = pnp_register_dependent_option(dev, priority);
-			if (!option)
-				return NULL;
-			break;
-		}
-		case SMALL_TAG_ENDDEP:
-		{
-			if (len != 0)
-				goto sm_err;
-			break;
-		}
-		case SMALL_TAG_PORT:
-		{
-			if (len != 7)
-				goto sm_err;
-			possible_port(p,len,option);
-			break;
-		}
-		case SMALL_TAG_FIXEDPORT:
-		{
-			if (len != 3)
-				goto sm_err;
-			possible_fixed_port(p,len,option);
-			break;
-		}
-		case SMALL_TAG_END:
-		{
-			p = p + 2;
-			return (unsigned char *)p;
-			break;
-		}
-		default: /* an unkown tag */
-		{
-			sm_err:
-			pnp_warn("parser: Unknown small tag '0x%x'.", p[0]>>3);
-			break;
-		}
-		}
-                p += len + 1;
-	}
-	pnp_err("parser: Resource structure does not contain an end tag.");
-
-	return NULL;
-}
-
-
-/*
- * Resource Writing functions
- */
-
-static void write_mem(unsigned char *p, struct resource * res)
-{
-	unsigned long base = res->start;
-	unsigned long len = res->end - res->start + 1;
-	p[4] = (base >> 8) & 0xff;
-	p[5] = ((base >> 8) >> 8) & 0xff;
-	p[6] = (base >> 8) & 0xff;
-	p[7] = ((base >> 8) >> 8) & 0xff;
-	p[10] = (len >> 8) & 0xff;
-	p[11] = ((len >> 8) >> 8) & 0xff;
-	return;
-}
-
-static void write_mem32(unsigned char *p, struct resource * res)
-{
-	unsigned long base = res->start;
-	unsigned long len = res->end - res->start + 1;
-	p[4] = base & 0xff;
-	p[5] = (base >> 8) & 0xff;
-	p[6] = (base >> 16) & 0xff;
-	p[7] = (base >> 24) & 0xff;
-	p[8] = base & 0xff;
-	p[9] = (base >> 8) & 0xff;
-	p[10] = (base >> 16) & 0xff;
-	p[11] = (base >> 24) & 0xff;
-	p[16] = len & 0xff;
-	p[17] = (len >> 8) & 0xff;
-	p[18] = (len >> 16) & 0xff;
-	p[19] = (len >> 24) & 0xff;
-	return;
-}
-
-static void write_fixed_mem32(unsigned char *p, struct resource * res)
-{	unsigned long base = res->start;
-	unsigned long len = res->end - res->start + 1;
-	p[4] = base & 0xff;
-	p[5] = (base >> 8) & 0xff;
-	p[6] = (base >> 16) & 0xff;
-	p[7] = (base >> 24) & 0xff;
-	p[8] = len & 0xff;
-	p[9] = (len >> 8) & 0xff;
-	p[10] = (len >> 16) & 0xff;
-	p[11] = (len >> 24) & 0xff;
-	return;
-}
-
-static void write_irq(unsigned char *p, struct resource * res)
-{
-	unsigned long map = 0;
-	map = 1 << res->start;
-	p[1] = map & 0xff;
-	p[2] = (map >> 8) & 0xff;
-	return;
-}
-
-static void write_dma(unsigned char *p, struct resource * res)
-{
-	unsigned long map = 0;
-	map = 1 << res->start;
-	p[1] = map & 0xff;
-	return;
-}
-
-static void write_port(unsigned char *p, struct resource * res)
-{
-	unsigned long base = res->start;
-	unsigned long len = res->end - res->start + 1;
-	p[2] = base & 0xff;
-	p[3] = (base >> 8) & 0xff;
-	p[4] = base & 0xff;
-	p[5] = (base >> 8) & 0xff;
-	p[7] = len & 0xff;
-	return;
-}
-
-static void write_fixed_port(unsigned char *p, struct resource * res)
-{
-	unsigned long base = res->start;
-	unsigned long len = res->end - res->start + 1;
-	p[1] = base & 0xff;
-	p[2] = (base >> 8) & 0xff;
-	p[3] = len & 0xff;
-	return;
-}
-
-/**
- * pnp_write_resources - Writes resource information to a raw PnP resource structure
- * @p: pointer to the start of the structure
- * @end: pointer to the end of the structure
- * @res: pointer to a resource table containing the resources to set
- *
- */
-
-unsigned char * pnp_write_resources(unsigned char * p, unsigned char * end, struct pnp_resource_table * res)
-{
-	int len, port = 0, irq = 0, dma = 0, mem = 0;
-
-	if (!p)
-		return NULL;
-
-	while ((char *)p < (char *)end) {
-
-		if(p[0] & LARGE_TAG) { /* large tag */
-			len = (p[2] << 8) | p[1];
-			switch (p[0] & 0x7f) {
-			case LARGE_TAG_MEM:
-			{
-				if (len != 9)
-					goto lrg_err;
-				write_mem(p, &res->mem_resource[mem]);
-				mem++;
-				break;
-			}
-			case LARGE_TAG_MEM32:
-			{
-				if (len != 17)
-					goto lrg_err;
-				write_mem32(p, &res->mem_resource[mem]);
-				break;
-			}
-			case LARGE_TAG_FIXEDMEM32:
-			{
-				if (len != 9)
-					goto lrg_err;
-				write_fixed_mem32(p, &res->mem_resource[mem]);
-				break;
-			}
-			default: /* an unkown tag */
-			{
-				lrg_err:
-				pnp_warn("parser: Unknown large tag '0x%x'.", p[0] & 0x7f);
-				break;
-			}
-			} /* switch */
-                        p += len + 3;
-			continue;
-		} /* end large tag */
-
-		/* small tag */
-		len = p[0] & 0x07;
-		switch ((p[0]>>3) & 0x0f) {
-		case SMALL_TAG_IRQ:
-		{
-			if (len < 2 || len > 3)
-				goto sm_err;
-			write_irq(p, &res->irq_resource[irq]);
-			irq++;
-			break;
-		}
-		case SMALL_TAG_DMA:
-		{
-			if (len != 2)
-				goto sm_err;
-			write_dma(p, &res->dma_resource[dma]);
-			dma++;
-			break;
-		}
-		case SMALL_TAG_PORT:
-		{
-			if (len != 7)
-				goto sm_err;
-			write_port(p, &res->port_resource[port]);
-			port++;
-			break;
-		}
-		case SMALL_TAG_FIXEDPORT:
-		{
-			if (len != 3)
-				goto sm_err;
-			write_fixed_port(p, &res->port_resource[port]);
-			port++;
-			break;
-		}
-		case SMALL_TAG_END:
-		{
-			p = p + 2;
-			return (unsigned char *)p;
-			break;
-		}
-		default: /* an unkown tag */
-		{
-			sm_err:
-			pnp_warn("parser: Unknown small tag '0x%x'.", p[0]>>3);
-			break;
-		}
-		}
-                p += len + 1;
-	}
-	pnp_err("parser: Resource structure does not contain an end tag.");
-
-	return NULL;
-}
 
 EXPORT_SYMBOL(pnp_is_active);
-EXPORT_SYMBOL(pnp_parse_current_resources);
-EXPORT_SYMBOL(pnp_parse_possible_resources);
-EXPORT_SYMBOL(pnp_write_resources);
diff -Nru a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Tue Aug  5 21:24:58 2003
+++ b/include/linux/pnp.h	Tue Aug  5 21:24:58 2003
@@ -389,9 +389,6 @@
 
 /* protocol helpers */
 int pnp_is_active(struct pnp_dev * dev);
-unsigned char * pnp_parse_current_resources(unsigned char * p, unsigned char * end, struct pnp_resource_table * res);
-unsigned char * pnp_parse_possible_resources(unsigned char * p, unsigned char * end, struct pnp_dev * dev);
-unsigned char * pnp_write_resources(unsigned char * p, unsigned char * end, struct pnp_resource_table * res);
 int compare_pnp_id(struct pnp_id * pos, const char * id);
 int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev);
 int pnp_register_driver(struct pnp_driver *drv);
@@ -437,9 +434,6 @@
 
 /* protocol helpers */
 static inline int pnp_is_active(struct pnp_dev * dev) { return 0; }
-static inline unsigned char * pnp_parse_current_resources(unsigned char * p, unsigned char * end, struct pnp_resource_table * res) { return NULL; }
-static inline unsigned char * pnp_parse_possible_resources(unsigned char * p, unsigned char * end, struct pnp_dev * dev) { return NULL; }
-static inline unsigned char * pnp_write_resources(unsigned char * p, unsigned char * end, struct pnp_resource_table * res) { return NULL; }
 static inline int compare_pnp_id(struct pnp_id * pos, const char * id) { return -ENODEV; }
 static inline int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_register_driver(struct pnp_driver *drv) { return -ENODEV; }
