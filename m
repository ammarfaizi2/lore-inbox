Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbTBCB1b>; Sun, 2 Feb 2003 20:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbTBCB1a>; Sun, 2 Feb 2003 20:27:30 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:12937 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S265543AbTBCB0n>;
	Sun, 2 Feb 2003 20:26:43 -0500
Date: Sun, 2 Feb 2003 20:36:46 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH][RFC] Unified Resource Parsing (2/4)
Message-ID: <20030202203646.GA22096@neo.rr.com>
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

This patch creates a series of global resource parsing functions that can be 
used by any pnp protocol including eventually ACPI.  These new functions are 
based on those found in the pnpbios driver but they have been improved.  
This patch also adds MEM32 support to the pnp layer.


diff -urN a/drivers/pnp/Makefile b/drivers/pnp/Makefile
--- a/drivers/pnp/Makefile	Tue Jan 14 05:58:03 2003
+++ b/drivers/pnp/Makefile	Sat Feb  1 22:05:51 2003
@@ -4,9 +4,9 @@
 
 pnp-card-$(CONFIG_PNP_CARD) = card.o
 
-obj-y		:= core.o driver.o resource.o interface.o quirks.o names.o system.o $(pnp-card-y)
+obj-y		:= core.o driver.o resource.o support.o interface.o quirks.o names.o system.o $(pnp-card-y)
 
 obj-$(CONFIG_PNPBIOS)		+= pnpbios/
 obj-$(CONFIG_ISAPNP)		+= isapnp/
 
-export-objs	:= core.o driver.o resource.o $(pnp-card-y)
+export-objs	:= core.o driver.o resource.o support.o $(pnp-card-y)
diff -urN a/drivers/pnp/interface.c b/drivers/pnp/interface.c
--- a/drivers/pnp/interface.c	Sun Feb  2 11:40:10 2003
+++ b/drivers/pnp/interface.c	Sat Feb  1 22:50:10 2003
@@ -158,27 +158,15 @@
 	case IORESOURCE_MEM_8AND16BIT:
 		s = "8-bit&16-bit";
 		break;
+	case IORESOURCE_MEM_32BIT:
+		s = "32-bit";
+		break;
 	default:
 		s = "16-bit";
 	}
 	pnp_printf(buffer, ", %s\n", s);
 }
 
-static void pnp_print_mem32(pnp_info_buffer_t *buffer, char *space, struct pnp_mem32 *mem32)
-{
-	int first = 1, i;
-
-	pnp_printf(buffer, "%s32-bit memory ", space);
-	for (i = 0; i < 17; i++) {
-		if (first) {
-			first = 0;
-		} else {
-			pnp_printf(buffer, ":");
-		}
-		pnp_printf(buffer, "%02x", mem32->data[i]);
-	}
-}
-
 static void pnp_print_resources(pnp_info_buffer_t *buffer, char *space, struct pnp_resources *res, int dep)
 {
 	char *s;
@@ -186,7 +174,6 @@
 	struct pnp_irq *irq;
 	struct pnp_dma *dma;
 	struct pnp_mem *mem;
-	struct pnp_mem32 *mem32;
 
 	switch (res->priority) {
 	case PNP_RES_PRIORITY_PREFERRED:
@@ -211,8 +198,6 @@
 		pnp_print_dma(buffer, space, dma);
 	for (mem = res->mem; mem; mem = mem->next)
 		pnp_print_mem(buffer, space, mem);
-	for (mem32 = res->mem32; mem32; mem32 = mem32->next)
-		pnp_print_mem32(buffer, space, mem32);
 }
 
 static ssize_t pnp_show_possible_resources(struct device *dmdev, char *buf)
diff -urN a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	Sun Feb  2 11:40:10 2003
+++ b/drivers/pnp/isapnp/core.c	Sat Feb  1 22:05:51 2003
@@ -579,14 +579,18 @@
 						 int depnum, int size)
 {
 	unsigned char tmp[17];
-	struct pnp_mem32 *mem32;
+	struct pnp_mem *mem;
 
 	isapnp_peek(tmp, size);
-	mem32 = isapnp_alloc(sizeof(struct pnp_mem32));
-	if (!mem32)
+	mem = isapnp_alloc(sizeof(struct pnp_mem));
+	if (!mem)
 		return;
-	memcpy(mem32->data, tmp, 17);
-	pnp_add_mem32_resource(dev,depnum,mem32);
+	mem->min = (tmp[4] << 24) | (tmp[3] << 16) | (tmp[2] << 8) | tmp[1];
+	mem->max = (tmp[8] << 24) | (tmp[7] << 16) | (tmp[6] << 8) | tmp[5];
+	mem->align = (tmp[12] << 24) | (tmp[11] << 16) | (tmp[10] << 8) | tmp[9];
+	mem->size = (tmp[16] << 24) | (tmp[15] << 16) | (tmp[14] << 8) | tmp[13];
+	mem->flags = tmp[0];
+	pnp_add_mem_resource(dev,depnum,mem);
 }
 
 /*
@@ -596,15 +600,18 @@
 static void __init isapnp_add_fixed_mem32_resource(struct pnp_dev *dev,
 						       int depnum, int size)
 {
-	unsigned char tmp[17];
-	struct pnp_mem32 *mem32;
+	unsigned char tmp[9];
+	struct pnp_mem *mem;
 
 	isapnp_peek(tmp, size);
-	mem32 = isapnp_alloc(sizeof(struct pnp_mem32));
-	if (!mem32)
+	mem = isapnp_alloc(sizeof(struct pnp_mem));
+	if (!mem)
 		return;
-	memcpy(mem32->data, tmp, 17);
-	pnp_add_mem32_resource(dev,depnum,mem32);
+	mem->min = mem->max = (tmp[4] << 24) | (tmp[3] << 16) | (tmp[2] << 8) | tmp[1];
+	mem->size = (tmp[8] << 24) | (tmp[7] << 16) | (tmp[6] << 8) | tmp[5];
+	mem->align = 0;
+	mem->flags = tmp[0];
+	pnp_add_mem_resource(dev,depnum,mem);
 }
 
 /*
@@ -736,7 +743,7 @@
 			size = 0;
 			break;
 		case _LTAG_FIXEDMEM32RANGE:
-			if (size != 17)
+			if (size != 9)
 				goto __skip;
 			isapnp_add_fixed_mem32_resource(dev, depnum, size);
 			size = 0;
diff -urN a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	Sun Feb  2 11:40:10 2003
+++ b/drivers/pnp/pnpbios/core.c	Sat Feb  1 22:05:51 2003
@@ -664,381 +664,6 @@
 
 #endif   /* CONFIG_HOTPLUG */
 
-
-/* pnp current resource reading functions */
-
-
-static void add_irqresource(struct pnp_dev *dev, int irq)
-{
-	int i = 0;
-	while (pnp_irq_valid(dev, i) && i < PNP_MAX_IRQ) i++;
-	if (i < PNP_MAX_IRQ) {
-		dev->resources.irq_resource[i].start =
-		dev->resources.irq_resource[i].end = (unsigned long) irq;
-		dev->resources.irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
-	}
-}
-
-static void add_dmaresource(struct pnp_dev *dev, int dma)
-{
-	int i = 0;
-	while (pnp_dma_valid(dev, i) && i < DEVICE_COUNT_DMA) i++;
-	if (i < PNP_MAX_DMA) {
-		dev->resources.dma_resource[i].start =
-		dev->resources.dma_resource[i].end = (unsigned long) dma;
-		dev->resources.dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
-	}
-}
-
-static void add_ioresource(struct pnp_dev *dev, int io, int len)
-{
-	int i = 0;
-	while (pnp_port_valid(dev, i) && i < PNP_MAX_PORT) i++;
-	if (i < PNP_MAX_PORT) {
-		dev->resources.port_resource[i].start = (unsigned long) io;
-		dev->resources.port_resource[i].end = (unsigned long)(io + len - 1);
-		dev->resources.port_resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
-	}
-}
-
-static void add_memresource(struct pnp_dev *dev, int mem, int len)
-{
-	int i = 0;
-	while (pnp_mem_valid(dev, i) && i < PNP_MAX_MEM) i++;
-	if (i < PNP_MAX_MEM) {
-		dev->resources.mem_resource[i].start = (unsigned long) mem;
-		dev->resources.mem_resource[i].end = (unsigned long)(mem + len - 1);
-		dev->resources.mem_resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
-	}
-}
-
-static unsigned char *node_current_resource_data_to_dev(struct pnp_bios_node *node, struct pnp_dev *dev)
-{
-	unsigned char *p = node->data, *lastp=NULL;
-	int i;
-
-	/*
-	 * First, set resource info to default values
-	 */
-	for (i=0;i<PNP_MAX_PORT;i++) {
-		dev->resources.port_resource[i].start = 0;
-		dev->resources.port_resource[i].end = 0;
-		dev->resources.port_resource[i].flags = IORESOURCE_UNSET;
-	}
-	for (i=0;i<PNP_MAX_MEM;i++) {
-		dev->resources.mem_resource[i].start = 0;
-		dev->resources.mem_resource[i].end = 0;
-		dev->resources.mem_resource[i].flags = IORESOURCE_UNSET;
-	}
-	for (i=0;i<PNP_MAX_IRQ;i++) {
-		dev->resources.irq_resource[i].start = (unsigned long)-1;
-		dev->resources.irq_resource[i].end = (unsigned long)-1;
-		dev->resources.irq_resource[i].flags = IORESOURCE_UNSET;
-	}
-	for (i=0;i<PNP_MAX_DMA;i++) {
-		dev->resources.dma_resource[i].start = (unsigned long)-1;
-		dev->resources.dma_resource[i].end = (unsigned long)-1;
-		dev->resources.dma_resource[i].flags = IORESOURCE_UNSET;
-	}
-
-	/*
-	 * Fill in dev resource info
-	 */
-        while ( (char *)p < ((char *)node->data + node->size )) {
-        	if(p==lastp) break;
-
-                if( p[0] & 0x80 ) {// large item
-			switch (p[0] & 0x7f) {
-			case 0x01: // memory
-			{
-				int io = *(short *) &p[4];
-				int len = *(short *) &p[10];
-				add_memresource(dev, io, len);
-				break;
-			}
-			case 0x02: // device name
-			{
-				int len = *(short *) &p[1];
-				memcpy(dev->dev.name, p + 3, len >= 80 ? 79 : len);
-				break;
-			}
-			case 0x05: // 32-bit memory
-			{
-				int io = *(int *) &p[4];
-				int len = *(int *) &p[16];
-				add_memresource(dev, io, len);
-				break;
-			}
-			case 0x06: // fixed location 32-bit memory
-			{
-				int io = *(int *) &p[4];
-				int len = *(int *) &p[8];
-				add_memresource(dev, io, len);
-				break;
-			}
-			} /* switch */
-                        lastp = p+3;
-                        p = p + p[1] + p[2]*256 + 3;
-                        continue;
-                }
-                if ((p[0]>>3) == 0x0f){ // end tag
-			p = p + 2;
-			goto end;
-                        break;
-			}
-                switch (p[0]>>3) {
-                case 0x04: // irq
-                {
-                        int i, mask, irq = -1;
-                        mask= p[1] + p[2]*256;
-                        for (i=0;i<16;i++, mask=mask>>1)
-                                if(mask & 0x01) irq=i;
-			add_irqresource(dev, irq);
-                        break;
-                }
-                case 0x05: // dma
-                {
-                        int i, mask, dma = -1;
-                        mask = p[1];
-                        for (i=0;i<8;i++, mask = mask>>1)
-                                if(mask & 0x01) dma=i;
-			add_dmaresource(dev, dma);
-                        break;
-                }
-                case 0x08: // io
-                {
-			int io= p[2] + p[3] *256;
-			int len = p[7];
-			add_ioresource(dev, io, len);
-                        break;
-                }
-		case 0x09: // fixed location io
-		{
-			int io = p[1] + p[2] * 256;
-			int len = p[3];
-			add_ioresource(dev, io, len);
-			break;
-		}
-                } /* switch */
-                lastp=p+1;
-                p = p + (p[0] & 0x07) + 1;
-
-        } /* while */
-	end:
-	if (pnp_port_start(dev, 0) == 0 &&
-	    pnp_mem_start(dev, 0) == 0 &&
-	    pnp_irq(dev, 0) == -1 &&
-	    pnp_dma(dev, 0) == -1)
-		dev->active = 0;
-	else
-		dev->active = 1;
-        return (unsigned char *)p;
-}
-
-
-/* pnp possible resource reading functions */
-
-static void read_lgtag_mem(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
-{
-	struct pnp_mem * mem;
-	mem = pnpbios_kmalloc(sizeof(struct pnp_mem),GFP_KERNEL);
-	if (!mem)
-		return;
-	memset(mem,0,sizeof(struct pnp_mem));
-	mem->min = ((p[3] << 8) | p[2]) << 8;
-	mem->max = ((p[5] << 8) | p[4]) << 8;
-	mem->align = (p[7] << 8) | p[6];
-	mem->size = ((p[9] << 8) | p[8]) << 8;
-	mem->flags = p[1];
-	pnp_add_mem_resource(dev,depnum,mem);
-	return;
-}
-
-static void read_lgtag_mem32(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
-{
-	struct pnp_mem32 * mem;
-	mem = pnpbios_kmalloc(sizeof(struct pnp_mem32),GFP_KERNEL);
-	if (!mem)
-		return;
-	memset(mem,0,sizeof(struct pnp_mem32));
-	memcpy(mem->data, p, 17);
-	pnp_add_mem32_resource(dev,depnum,mem);
-	return;
-}
-
-static void read_lgtag_fmem32(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
-{
-	struct pnp_mem32 * mem;
-	mem = pnpbios_kmalloc(sizeof(struct pnp_mem32),GFP_KERNEL);
-	if (!mem)
-		return;
-	memset(mem,0,sizeof(struct pnp_mem32));
-	memcpy(mem->data, p, 17);
-	pnp_add_mem32_resource(dev,depnum,mem);
-	return;
-}
-
-static void read_smtag_irq(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
-{
-	struct pnp_irq * irq;
-	irq = pnpbios_kmalloc(sizeof(struct pnp_irq),GFP_KERNEL);
-	if (!irq)
-		return;
-	memset(irq,0,sizeof(struct pnp_irq));
-	irq->map = (p[2] << 8) | p[1];
-	if (size > 2)
-		irq->flags = p[3];
-	pnp_add_irq_resource(dev,depnum,irq);
-	return;
-}
-
-static void read_smtag_dma(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
-{
-	struct pnp_dma * dma;
-	dma = pnpbios_kmalloc(sizeof(struct pnp_dma),GFP_KERNEL);
-	if (!dma)
-		return;
-	memset(dma,0,sizeof(struct pnp_dma));
-	dma->map = p[1];
-	dma->flags = p[2];
-	pnp_add_dma_resource(dev,depnum,dma);
-	return;
-}
-
-static void read_smtag_port(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
-{
-	struct pnp_port * port;
-	port = pnpbios_kmalloc(sizeof(struct pnp_port),GFP_KERNEL);
-	if (!port)
-		return;
-	memset(port,0,sizeof(struct pnp_port));
-	port->min = (p[3] << 8) | p[2];
-	port->max = (p[5] << 8) | p[4];
-	port->align = p[6];
-	port->size = p[7];
-	port->flags = p[1] ? PNP_PORT_FLAG_16BITADDR : 0;
-	pnp_add_port_resource(dev,depnum,port);
-	return;
-}
-
-static void read_smtag_fport(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
-{
-	struct pnp_port * port;
-	port = pnpbios_kmalloc(sizeof(struct pnp_port),GFP_KERNEL);
-	if (!port)
-		return;
-	memset(port,0,sizeof(struct pnp_port));
-	port->min = port->max = (p[2] << 8) | p[1];
-	port->size = p[3];
-	port->align = 0;
-	port->flags = PNP_PORT_FLAG_FIXED;
-	pnp_add_port_resource(dev,depnum,port);
-	return;
-}
-
-static unsigned char *node_possible_resource_data_to_dev(unsigned char *p, struct pnp_bios_node *node, struct pnp_dev *dev)
-{
-	int len, depnum, dependent;
-
-	if ((char *)p == NULL)
-		return NULL;
-	if (pnp_build_resource(dev, 0) == NULL)
-		return NULL;
-	depnum = 0; /*this is the first so it should be 0 */
-	dependent = 0;
-        while ( (char *)p < ((char *)node->data + node->size )) {
-
-                if( p[0] & 0x80 ) {// large item
-			len = (p[2] << 8) | p[1];
-			switch (p[0] & 0x7f) {
-			case 0x01: // memory
-			{
-				if (len != 9)
-					goto __skip;
-				read_lgtag_mem(p,len,depnum,dev);
-				break;
-			}
-			case 0x05: // 32-bit memory
-			{
-				if (len != 17)
-					goto __skip;
-				read_lgtag_mem32(p,len,depnum,dev);
-				break;
-			}
-			case 0x06: // fixed location 32-bit memory
-			{
-				if (len != 17)
-					goto __skip;
-				read_lgtag_fmem32(p,len,depnum,dev);
-				break;
-			}
-			} /* switch */
-                        p += len + 3;
-                        continue;
-                }
-		len = p[0] & 0x07;
-                switch ((p[0]>>3) & 0x0f) {
-		case 0x0f:
-		{
-			p = p + 2;
-        		return (unsigned char *)p;
-			break;
-		}
-                case 0x04: // irq
-                {
-			if (len < 2 || len > 3)
-				goto __skip;
-			read_smtag_irq(p,len,depnum,dev);
-			break;
-                }
-                case 0x05: // dma
-                {
-			if (len != 2)
-				goto __skip;
-			read_smtag_dma(p,len,depnum,dev);
-                        break;
-                }
-                case 0x06: // start dep
-                {
-			if (len > 1)
-				goto __skip;
-			dependent = 0x100 | PNP_RES_PRIORITY_ACCEPTABLE;
-			if (len > 0)
-				dependent = 0x100 | p[1];
-			pnp_build_resource(dev,dependent);
-			depnum = pnp_get_max_depnum(dev);
-                        break;
-                }
-                case 0x07: // end dep
-                {
-			if (len != 0)
-				goto __skip;
-			depnum = 0;
-                        break;
-                }
-                case 0x08: // io
-                {
-			if (len != 7)
-				goto __skip;
-			read_smtag_port(p,len,depnum,dev);
-                        break;
-                }
-		case 0x09: // fixed location io
-		{
-			if (len != 3)
-				goto __skip;
-			read_smtag_fport(p,len,depnum,dev);
-			break;
-		}
-                } /* switch */
-		__skip:
-                p += len + 1;
-
-        } /* while */
-
-        return NULL;
-}
-
 /* pnp EISA ids */
 
 #define HEX(id,a) hex[((id)>>a) & 15]
@@ -1107,163 +732,6 @@
         } /* while */
 }
 
-/* pnp resource writing functions */
-
-static void write_lgtag_mem(unsigned char *p, int size, struct pnp_mem *mem)
-{
-	if (!mem)
-		return;
-	p[2] = (mem->min >> 8) & 0xff;
-	p[3] = ((mem->min >> 8) >> 8) & 0xff;
-	p[4] = (mem->max >> 8) & 0xff;
-	p[5] = ((mem->max >> 8) >> 8) & 0xff;
-	p[6] = mem->align & 0xff;
-	p[7] = (mem->align >> 8) & 0xff;
-	p[8] = (mem->size >> 8) & 0xff;
-	p[9] = ((mem->size >> 8) >> 8) & 0xff;
-	p[1] = mem->flags & 0xff;
-	return;
-}
-
-static void write_smtag_irq(unsigned char *p, int size, struct pnp_irq *irq)
-{
-	if (!irq)
-		return;
-	p[1] = irq->map & 0xff;
-	p[2] = (irq->map >> 8) & 0xff;
-	if (size > 2)
-		p[3] = irq->flags & 0xff;
-	return;
-}
-
-static void write_smtag_dma(unsigned char *p, int size, struct pnp_dma *dma)
-{
-	if (!dma)
-		return;
-	p[1] = dma->map & 0xff;
-	p[2] = dma->flags & 0xff;
-	return;
-}
-
-static void write_smtag_port(unsigned char *p, int size, struct pnp_port *port)
-{
-	if (!port)
-		return;
-	p[2] = port->min & 0xff;
-	p[3] = (port->min >> 8) & 0xff;
-	p[4] = port->max & 0xff;
-	p[5] = (port->max >> 8) & 0xff;
-	p[6] = port->align & 0xff;
-	p[7] = port->size & 0xff;
-	p[1] = port->flags & 0xff;
-	return;
-}
-
-static void write_smtag_fport(unsigned char *p, int size, struct pnp_port *port)
-{
-	if (!port)
-		return;
-	p[1] = port->min & 0xff;
-	p[2] = (port->min >> 8) & 0xff;
-	p[3] = port->size & 0xff;
-	return;
-}
-
-static int node_set_resources(struct pnp_bios_node *node, struct pnp_rule_table *config)
-{
-	int error = 0;
-	unsigned char *p = (char *)node->data, *lastp = NULL;
-	int len, port = 0, irq = 0, dma = 0, mem = 0;
-
-	if (!node)
-		return -EINVAL;
-	if ((char *)p == NULL)
-		return -EINVAL;
-        while ( (char *)p < ((char *)node->data + node->size )) {
-
-                if( p[0] & 0x80 ) {// large item
-			len = (p[2] << 8) | p[1];
-			switch (p[0] & 0x7f) {
-			case 0x01: // memory
-			{
-				if (len != 9)
-					goto __skip;
-				write_lgtag_mem(p,len,config->mem[mem]);
-				mem++;
-				break;
-			}
-			case 0x05: // 32-bit memory
-			{
-				if (len != 17)
-					goto __skip;
-				/* FIXME */
-				break;
-			}
-			case 0x06: // fixed location 32-bit memory
-			{
-				if (len != 17)
-					goto __skip;
-				/* FIXME */
-				break;
-			}
-			} /* switch */
-                        lastp = p+3;
-                        p = p + p[1] + p[2]*256 + 3;
-                        continue;
-                }
-		len = p[0] & 0x07;
-                switch ((p[0]>>3) & 0x0f) {
-		case 0x0f:
-		{
-        		goto done;
-			break;
-		}
-                case 0x04: // irq
-                {
-			if (len < 2 || len > 3)
-				goto __skip;
-			write_smtag_irq(p,len,config->irq[irq]);
-			irq++;
-			break;
-                }
-                case 0x05: // dma
-                {
-			if (len != 2)
-				goto __skip;
-			write_smtag_dma(p,len,config->dma[dma]);
-			dma++;
-                        break;
-                }
-                case 0x08: // io
-                {
-			if (len != 7)
-				goto __skip;
-			write_smtag_port(p,len,config->port[port]);
-			port++;
-                        break;
-                }
-		case 0x09: // fixed location io
-		{
-			if (len != 3)
-				goto __skip;
-			write_smtag_fport(p,len,config->port[port]);
-			port++;
-			break;
-		}
-                } /* switch */
-		__skip:
-                p += len + 1;
-
-        } /* while */
-
-	/* we never got an end tag so this data is corrupt or invalid */
-	return -EINVAL;
-
-	done:
-	error = pnp_bios_set_dev_node(node->handle, (char)0, node);
-        return error;
-}
-
 static int pnpbios_get_resources(struct pnp_dev *dev)
 {
 	struct pnp_dev_node_info node_info;
@@ -1280,7 +748,8 @@
 		return -1;
 	if (pnp_bios_get_dev_node(&nodenum, (char )0, node))
 		return -ENODEV;
-	node_current_resource_data_to_dev(node,dev);
+	pnp_parse_current_resources((char *)node->data,(char *)node->data + node->size,dev);
+	dev->active = pnp_is_active(dev);
 	kfree(node);
 	return 0;
 }
@@ -1301,9 +770,10 @@
 		return -1;
 	if (pnp_bios_get_dev_node(&nodenum, (char )1, node))
 		return -ENODEV;
-	if(node_set_resources(node, &dev->config->rule)<0){
+	if(!pnp_write_resources((char *)node->data,(char *)node->data + node->size,dev)){
 		return -1;
 	}
+	pnp_bios_set_dev_node(node->handle, (char)0, node);
 	kfree(node);
 	return 0;
 }
@@ -1326,7 +796,6 @@
 	.align	= 0,
 	.size	= 0,
 	.flags	= 0,
-	.pad	= 0,
 	};
 	struct pnp_dma	dma = {
 	.map	= 0,
@@ -1366,7 +835,7 @@
 		return -1;
 	if (pnp_bios_get_dev_node(&nodenum, (char )1, node))
 		goto failed;
-	if(node_set_resources(node, config)<0)
+	if(pnp_write_resources((char *)node->data,(char *)node->data + node->size,dev)<0)
 		goto failed;
 	kfree(config);
 	kfree(node);
@@ -1448,9 +917,10 @@
 		pnpid32_to_pnpid(node->eisa_id,id);
 		memcpy(dev_id->id,id,7);
 		pnp_add_id(dev_id, dev);
-		pos = node_current_resource_data_to_dev(node,dev);
-		pos = node_possible_resource_data_to_dev(pos,node,dev);
+		pos = pnp_parse_current_resources((char *)node->data,(char *)node->data + node->size,dev);
+		pos = pnp_parse_possible_resources((char *)pos,(char *)node->data + node->size,dev);
 		node_id_data_to_dev(pos,node,dev);
+		dev->active = pnp_is_active(dev);
 		dev->flags = node->flags;
 		if (!(dev->flags & PNPBIOS_NO_CONFIG))
 			dev->capabilities |= PNP_CONFIGURABLE;
diff -urN a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c	Sun Feb  2 11:40:10 2003
+++ b/drivers/pnp/resource.c	Sat Feb  1 23:09:48 2003
@@ -212,29 +212,6 @@
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
 static void pnp_free_port(struct pnp_port *port)
 {
 	struct pnp_port *next;
@@ -279,17 +256,6 @@
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
@@ -300,7 +266,6 @@
 		pnp_free_irq(resources->irq);
 		pnp_free_dma(resources->dma);
 		pnp_free_mem(resources->mem);
-		pnp_free_mem32(resources->mem32);
 		kfree(resources);
 		resources = next;
 	}
@@ -341,7 +306,7 @@
 	/* check for cold conflicts */
 	pnp_for_each_dev(tdev) {
 		/* Is the device configurable? */
-		if (tdev == dev || mode ? !dev->active : dev->active)
+		if (tdev == dev || (mode ? !dev->active : dev->active))
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_PORT; tmp++) {
 			if (tdev->res.port_resource[tmp].flags & IORESOURCE_IO) {
@@ -412,7 +377,7 @@
 	/* check for cold conflicts */
 	pnp_for_each_dev(tdev) {
 		/* Is the device configurable? */
-		if (tdev == dev || mode ? !dev->active : dev->active)
+		if (tdev == dev || (mode ? !dev->active : dev->active))
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_MEM; tmp++) {
 			if (tdev->res.mem_resource[tmp].flags & IORESOURCE_MEM) {
@@ -481,7 +446,7 @@
 	/* check for cold conflicts */
 	pnp_for_each_dev(tdev) {
 		/* Is the device configurable? */
-		if (tdev == dev || mode ? !dev->active : dev->active)
+		if (tdev == dev || (mode ? !dev->active : dev->active))
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_IRQ; tmp++) {
 			if (tdev->res.irq_resource[tmp].flags & IORESOURCE_IRQ) {
@@ -563,7 +528,7 @@
 	/* check for cold conflicts */
 	pnp_for_each_dev(tdev) {
 		/* Is the device configurable? */
-		if (tdev == dev || mode ? !dev->active : dev->active)
+		if (tdev == dev || (mode ? !dev->active : dev->active))
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_DMA; tmp++) {
 			if (tdev->res.dma_resource[tmp].flags & IORESOURCE_DMA) {
@@ -1060,6 +1025,9 @@
 static int pnp_generate_config(struct pnp_dev * dev)
 {
 	int move;
+	/* if the device cannot be configured skip it */
+	if (!pnp_can_configure(dev))
+		return 1;
 	if (!dev->rule) {
 		dev->rule = pnp_alloc(sizeof(struct pnp_rule_table));
 		if (!dev->rule)
@@ -1074,7 +1042,7 @@
 
 	pnp_init_resource_table(&dev->res);
 	dev->rule->depnum = 0;
-	printk (KERN_ERR "pnp: Unable to resolve resource conflicts for the device '%s', this device will not be usable.\n", dev->dev.bus_id);
+	pnp_err("res: Unable to resolve resource conflicts for the device '%s', this device will not be usable.", dev->dev.bus_id);
 	return 0;
 }
 
@@ -1128,10 +1096,11 @@
 	int error;
 	if(!dev)
 		return -EINVAL;
-	if(dev->active)
+	if(dev->active) {
 		error = pnp_process_active(dev);
-	else
+	} else {
 		error = pnp_generate_config(dev);
+	}
 	return error;
 }
 
@@ -1154,13 +1123,13 @@
 	if (!pnp_can_configure(dev))
 		return -EBUSY;
 	if (dev->status != PNP_READY && dev->status != PNP_ATTACHED){
-		printk(KERN_INFO "pnp: Activation failed because the PnP device '%s' is busy\n", dev->dev.bus_id);
+		pnp_err("res: Activation failed because the PnP device '%s' is busy", dev->dev.bus_id);
 		return -EINVAL;
 	}
 	if (!pnp_can_write(dev))
 		return -EINVAL;
 
-	pnp_dbg("the device '%s' has been activated", dev->dev.bus_id);
+	pnp_dbg("res: the device '%s' has been activated", dev->dev.bus_id);
 	dev->protocol->set(dev);
 	if (pnp_can_read(dev))
 		dev->protocol->get(dev);
diff -urN a/drivers/pnp/support.c b/drivers/pnp/support.c
--- a/drivers/pnp/support.c	Thu Jan  1 00:00:00 1970
+++ b/drivers/pnp/support.c	Sat Feb  1 22:35:47 2003
@@ -0,0 +1,660 @@
+/*
+ * support.c - provides standard pnp functions for the use of pnp protocol drivers, 
+ *
+ * Copyright 2003 Adam Belay <ambx1@neo.rr.com>
+ *
+ * Resource parsing functions are based on those in the linux pnpbios driver.
+ * Copyright Christian Schmidt, Tom Lees, David Hinds, Alan Cox, Thomas Hood,
+ * Brian Gerst and Adam Belay.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+
+#ifdef CONFIG_PNP_DEBUG
+	#define DEBUG
+#else
+	#undef DEBUG
+#endif
+
+#include <linux/pnp.h>
+#include "base.h"
+
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
+#define LARGE_TAG_MEM			0x01
+#define LARGE_TAG_ANSISTR		0x02
+#define LARGE_TAG_UNICODESTR		0x03
+#define LARGE_TAG_VENDOR		0x04
+#define LARGE_TAG_MEM32		0x05
+#define LARGE_TAG_FIXEDMEM32		0x06
+
+
+/**
+ * pnp_is_active - Determines if a device is active based on its current resources
+ * @dev: pointer to the desired PnP device
+ *
+ */
+
+int pnp_is_active(struct pnp_dev * dev)
+{
+	if (!pnp_port_start(dev, 0) &&
+	    !pnp_mem_start(dev, 0) &&
+	    pnp_irq(dev, 0) == -1 &&
+	    pnp_dma(dev, 0) == -1)
+	    	return 0;
+	else
+		return 1;
+}
+
+
+/*
+ * Current resource reading functions *
+ */
+
+static void current_irqresource(struct pnp_dev *dev, int irq)
+{
+	int i = 0;
+	while (pnp_irq_valid(dev, i) && i < PNP_MAX_IRQ) i++;
+	if (i < PNP_MAX_IRQ) {
+		dev->res.irq_resource[i].start =
+		dev->res.irq_resource[i].end = (unsigned long) irq;
+		dev->res.irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
+	}
+}
+
+static void current_dmaresource(struct pnp_dev *dev, int dma)
+{
+	int i = 0;
+	while (pnp_dma_valid(dev, i) && i < PNP_MAX_DMA) i++;
+	if (i < PNP_MAX_DMA) {
+		dev->res.dma_resource[i].start =
+		dev->res.dma_resource[i].end = (unsigned long) dma;
+		dev->res.dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
+	}
+}
+
+static void current_ioresource(struct pnp_dev *dev, int io, int len)
+{
+	int i = 0;
+	while (pnp_port_valid(dev, i) && i < PNP_MAX_PORT) i++;
+	if (i < PNP_MAX_PORT) {
+		dev->res.port_resource[i].start = (unsigned long) io;
+		dev->res.port_resource[i].end = (unsigned long)(io + len - 1);
+		dev->res.port_resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
+	}
+}
+
+static void current_memresource(struct pnp_dev *dev, int mem, int len)
+{
+	int i = 0;
+	while (pnp_mem_valid(dev, i) && i < PNP_MAX_MEM) i++;
+	if (i < PNP_MAX_MEM) {
+		dev->res.mem_resource[i].start = (unsigned long) mem;
+		dev->res.mem_resource[i].end = (unsigned long)(mem + len - 1);
+		dev->res.mem_resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
+	}
+}
+
+/**
+ * pnp_parse_current_res - Extracts current resource information from a raw PnP resource structure
+ * @p: pointer to the raw structure
+ * @end: pointer to the end of the structure
+ * @dev: pointer to the desired PnP device
+ *
+ */
+
+unsigned char * pnp_parse_current_resources(unsigned char * p, unsigned char * end, struct pnp_dev *dev)
+{
+	int len;
+
+	if (!p)
+		return NULL;
+
+	/* Blank the resource table values */
+	pnp_init_resource_table(&dev->res);
+
+	while ((char *)p < (char *)end) {
+
+		if(p[0] & LARGE_TAG) { /* large tag */
+			len = (p[2] << 8) | p[1];
+			switch (p[0] & 0x7f) {
+			case LARGE_TAG_MEM:
+			{
+				int io = *(short *) &p[4];
+				int size = *(short *) &p[10];
+				if (len != 9)
+					goto lrg_err;
+				current_memresource(dev, io, size);
+				break;
+			}
+			case LARGE_TAG_ANSISTR: /* human readable name */
+			{
+				int size = *(short *) &p[1];
+				memcpy(dev->dev.name, p + 3, len >= 80 ? 79 : size);
+				break;
+			}
+			case LARGE_TAG_MEM32:
+			{
+				int io = *(int *) &p[4];
+				int size = *(int *) &p[16];
+				if (len != 17)
+					goto lrg_err;
+				current_memresource(dev, io, size);
+				break;
+			}
+			case LARGE_TAG_FIXEDMEM32:
+			{
+				int io = *(int *) &p[4];
+				int size = *(int *) &p[8];
+				if (len != 9)
+					goto lrg_err;
+				current_memresource(dev, io, size);
+				break;
+			}
+			default: /* an unkown tag */
+			{
+				lrg_err:
+				pnp_warn("parser: Unknown large tag '0x%x'.", p[0] & 0x7f);
+				break;
+			}
+			} /* switch */
+                        p += len + 3;
+			continue;
+		} /* end large tag */
+
+		/* small tag */
+		len = p[0] & 0x07;
+		switch ((p[0]>>3) & 0x0f) {
+		case SMALL_TAG_IRQ:
+		{
+			int i, mask, irq = -1;
+			if (len < 2 || len > 3)
+				goto sm_err;
+			mask= p[1] + p[2]*256;
+			for (i=0;i<16;i++, mask=mask>>1)
+				if(mask & 0x01) irq=i;
+			current_irqresource(dev, irq);
+			break;
+		}
+		case SMALL_TAG_DMA:
+		{
+			int i, mask, dma = -1;
+			if (len != 2)
+				goto sm_err;
+			mask = p[1];
+			for (i=0;i<8;i++, mask = mask>>1)
+				if(mask & 0x01) dma=i;
+			current_dmaresource(dev, dma);
+			break;
+		}
+		case SMALL_TAG_PORT:
+		{
+			int io= p[2] + p[3] *256;
+			int size = p[7];
+			if (len != 7)
+				goto sm_err;
+			current_ioresource(dev, io, size);
+			break;
+		}
+		case SMALL_TAG_FIXEDPORT:
+		{
+			int io = p[1] + p[2] * 256;
+			int size = p[3];
+			if (len != 3)
+				goto sm_err;
+			current_ioresource(dev, io, size);
+			break;
+		}
+		case SMALL_TAG_END:
+		{
+			p = p + 2;
+        		return (unsigned char *)p;
+			break;
+		}
+		default: /* an unkown tag */
+		{
+			sm_err:
+			pnp_warn("parser: Unknown small tag '0x%x'.", p[0]>>3);
+			break;
+		}
+		}
+                p += len + 1;
+	}
+	pnp_err("parser: Resource structure does not contain an end tag.");
+
+	return NULL;
+}
+
+
+/*
+ * Possible resource reading functions *
+ */
+
+static void possible_mem(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+{
+	struct pnp_mem * mem;
+	mem = pnp_alloc(sizeof(struct pnp_mem));
+	if (!mem)
+		return;
+	mem->min = ((p[3] << 8) | p[2]) << 8;
+	mem->max = ((p[5] << 8) | p[4]) << 8;
+	mem->align = (p[7] << 8) | p[6];
+	mem->size = ((p[9] << 8) | p[8]) << 8;
+	mem->flags = p[1];
+	pnp_add_mem_resource(dev,depnum,mem);
+	return;
+}
+
+static void possible_mem32(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+{
+	struct pnp_mem * mem;
+	mem = pnp_alloc(sizeof(struct pnp_mem));
+	if (!mem)
+		return;
+	mem->min = (p[5] << 24) | (p[4] << 16) | (p[3] << 8) | p[2];
+	mem->max = (p[9] << 24) | (p[8] << 16) | (p[7] << 8) | p[6];
+	mem->align = (p[13] << 24) | (p[12] << 16) | (p[11] << 8) | p[10];
+	mem->size = (p[17] << 24) | (p[16] << 16) | (p[15] << 8) | p[14];
+	mem->flags = p[1];
+	pnp_add_mem_resource(dev,depnum,mem);
+	return;
+}
+
+static void possible_fixed_mem32(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+{
+	struct pnp_mem * mem;
+	mem = pnp_alloc(sizeof(struct pnp_mem));
+	if (!mem)
+		return;
+	mem->min = mem->max = (p[5] << 24) | (p[4] << 16) | (p[3] << 8) | p[2];
+	mem->size = (p[9] << 24) | (p[8] << 16) | (p[7] << 8) | p[6];
+	mem->align = 0;
+	mem->flags = p[1];
+	pnp_add_mem_resource(dev,depnum,mem);
+	return;
+}
+
+static void possible_irq(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+{
+	struct pnp_irq * irq;
+	irq = pnp_alloc(sizeof(struct pnp_irq));
+	if (!irq)
+		return;
+	irq->map = (p[2] << 8) | p[1];
+	if (size > 2)
+		irq->flags = p[3];
+	pnp_add_irq_resource(dev,depnum,irq);
+	return;
+}
+
+static void possible_dma(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+{
+	struct pnp_dma * dma;
+	dma = pnp_alloc(sizeof(struct pnp_dma));
+	if (!dma)
+		return;
+	dma->map = p[1];
+	dma->flags = p[2];
+	pnp_add_dma_resource(dev,depnum,dma);
+	return;
+}
+
+static void possible_port(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+{
+	struct pnp_port * port;
+	port = pnp_alloc(sizeof(struct pnp_port));
+	if (!port)
+		return;
+	port->min = (p[3] << 8) | p[2];
+	port->max = (p[5] << 8) | p[4];
+	port->align = p[6];
+	port->size = p[7];
+	port->flags = p[1] ? PNP_PORT_FLAG_16BITADDR : 0;
+	pnp_add_port_resource(dev,depnum,port);
+	return;
+}
+
+static void possible_fixed_port(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+{
+	struct pnp_port * port;
+	port = pnp_alloc(sizeof(struct pnp_port));
+	if (!port)
+		return;
+	port->min = port->max = (p[2] << 8) | p[1];
+	port->size = p[3];
+	port->align = 0;
+	port->flags = PNP_PORT_FLAG_FIXED;
+	pnp_add_port_resource(dev,depnum,port);
+	return;
+}
+
+/**
+ * pnp_parse_possible_resources - Extracts possible resource information from a raw PnP resource structure
+ * @p: pointer to the raw structure
+ * @end: pointer to the end of the structure
+ * @dev: pointer to the desired PnP device
+ *
+ */
+
+unsigned char * pnp_parse_possible_resources(unsigned char * p, unsigned char * end, struct pnp_dev *dev)
+{
+	int len, depnum = 0, dependent = 0;
+
+	if (!p)
+		return NULL;
+
+	if (pnp_build_resource(dev, 0) == NULL)
+		return NULL;
+
+	while ((char *)p < (char *)end) {
+
+		if(p[0] & LARGE_TAG) { /* large tag */
+			len = (p[2] << 8) | p[1];
+			switch (p[0] & 0x7f) {
+			case LARGE_TAG_MEM:
+			{
+				if (len != 9)
+					goto lrg_err;
+				possible_mem(p,len,depnum,dev);
+				break;
+			}
+			case LARGE_TAG_MEM32:
+			{
+				if (len != 17)
+					goto lrg_err;
+				possible_mem32(p,len,depnum,dev);
+				break;
+			}
+			case LARGE_TAG_FIXEDMEM32:
+			{
+				if (len != 9)
+					goto lrg_err;
+				possible_fixed_mem32(p,len,depnum,dev);
+				break;
+			}
+			default: /* an unkown tag */
+			{
+				lrg_err:
+				pnp_warn("parser: Unknown large tag '0x%x'.", p[0] & 0x7f);
+				break;
+			}
+			} /* switch */
+                        p += len + 3;
+			continue;
+		} /* end large tag */
+
+		/* small tag */
+		len = p[0] & 0x07;
+		switch ((p[0]>>3) & 0x0f) {
+		case SMALL_TAG_IRQ:
+		{
+			if (len < 2 || len > 3)
+				goto sm_err;
+			possible_irq(p,len,depnum,dev);
+			break;
+		}
+		case SMALL_TAG_DMA:
+		{
+			if (len != 2)
+				goto sm_err;
+			possible_dma(p,len,depnum,dev);
+			break;
+		}
+                case SMALL_TAG_STARTDEP:
+                {
+			if (len > 1)
+				goto sm_err;
+			dependent = 0x100 | PNP_RES_PRIORITY_ACCEPTABLE;
+			if (len > 0)
+				dependent = 0x100 | p[1];
+			pnp_build_resource(dev,dependent);
+			depnum = pnp_get_max_depnum(dev);
+                        break;
+                }
+                case SMALL_TAG_ENDDEP:
+                {
+			if (len != 0)
+				goto sm_err;
+			depnum = 0;
+                        break;
+                }
+		case SMALL_TAG_PORT:
+		{
+			if (len != 7)
+				goto sm_err;
+			possible_port(p,len,depnum,dev);
+			break;
+		}
+		case SMALL_TAG_FIXEDPORT:
+		{
+			if (len != 3)
+				goto sm_err;
+			possible_fixed_port(p,len,depnum,dev);
+			break;
+		}
+		case SMALL_TAG_END:
+		{
+			p = p + 2;
+			return (unsigned char *)p;
+			break;
+		}
+		default: /* an unkown tag */
+		{
+			sm_err:
+			pnp_warn("parser: Unknown small tag '0x%x'.", p[0]>>3);
+			break;
+		}
+		}
+                p += len + 1;
+	}
+	pnp_err("parser: Resource structure does not contain an end tag.");
+
+	return NULL;
+}
+
+
+/*
+ * Resource Writing functions
+ */
+
+static void write_mem(unsigned char *p, struct resource * res)
+{
+	unsigned long base = res->start;
+	unsigned long len = res->end - res->start + 1;
+	p[2] = (base >> 8) & 0xff;
+	p[3] = ((base >> 8) >> 8) & 0xff;
+	p[4] = (base >> 8) & 0xff;
+	p[5] = ((base >> 8) >> 8) & 0xff;
+	p[8] = (len >> 8) & 0xff;
+	p[9] = ((len >> 8) >> 8) & 0xff;
+	return;
+}
+
+static void write_mem32(unsigned char *p, struct resource * res)
+{
+	unsigned long base = res->start;
+	unsigned long len = res->end - res->start + 1;
+	p[2] = base & 0xff;
+	p[3] = (base >> 8) & 0xff;
+	p[4] = (base >> 16) & 0xff;
+	p[5] = (base >> 24) & 0xff;
+	p[6] = base & 0xff;
+	p[7] = (base >> 8) & 0xff;
+	p[8] = (base >> 16) & 0xff;
+	p[9] = (base >> 24) & 0xff;
+	p[14] = len & 0xff;
+	p[15] = (len >> 8) & 0xff;
+	p[16] = (len >> 16) & 0xff;
+	p[17] = (len >> 24) & 0xff;
+	return;
+}
+
+static void write_fixed_mem32(unsigned char *p, struct resource * res)
+{	unsigned long base = res->start;
+	unsigned long len = res->end - res->start + 1;
+	p[2] = base & 0xff;
+	p[3] = (base >> 8) & 0xff;
+	p[4] = (base >> 16) & 0xff;
+	p[5] = (base >> 24) & 0xff;
+	p[6] = len & 0xff;
+	p[7] = (len >> 8) & 0xff;
+	p[8] = (len >> 16) & 0xff;
+	p[9] = (len >> 24) & 0xff;
+	return;
+}
+
+static void write_irq(unsigned char *p, struct resource * res)
+{
+	unsigned long map = 0;
+	map = 1 << res->start;
+	p[1] = map & 0xff;
+	p[2] = (map >> 8) & 0xff;
+	return;
+}
+
+static void write_dma(unsigned char *p, struct resource * res)
+{
+	unsigned long map = 0;
+	map = 1 << res->start;
+	p[1] = map & 0xff;
+	return;
+}
+
+static void write_port(unsigned char *p, struct resource * res)
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
+static void write_fixed_port(unsigned char *p, struct resource * res)
+{
+	unsigned long base = res->start;
+	unsigned long len = res->end - res->start + 1;
+	p[1] = base & 0xff;
+	p[2] = (base >> 8) & 0xff;
+	p[3] = len & 0xff;
+	return;
+}
+
+unsigned char * pnp_write_resources(unsigned char * p, unsigned char * end, struct pnp_dev *dev)
+{
+	int len, port = 0, irq = 0, dma = 0, mem = 0;
+	struct pnp_resource_table * res = &dev->res;
+
+	if (!p)
+		return NULL;
+
+	while ((char *)p < (char *)end) {
+
+		if(p[0] & LARGE_TAG) { /* large tag */
+			len = (p[2] << 8) | p[1];
+			switch (p[0] & 0x7f) {
+			case LARGE_TAG_MEM:
+			{
+				if (len != 9)
+					goto lrg_err;
+				write_mem(p, &res->mem_resource[mem]);
+				mem++;
+				break;
+			}
+			case LARGE_TAG_MEM32:
+			{
+				if (len != 17)
+					goto lrg_err;
+				write_mem32(p, &res->mem_resource[mem]);
+				break;
+			}
+			case LARGE_TAG_FIXEDMEM32:
+			{
+				if (len != 9)
+					goto lrg_err;
+				write_fixed_mem32(p, &res->mem_resource[mem]);
+				break;
+			}
+			default: /* an unkown tag */
+			{
+				lrg_err:
+				pnp_warn("parser: Unknown large tag '0x%x'.", p[0] & 0x7f);
+				break;
+			}
+			} /* switch */
+                        p += len + 3;
+			continue;
+		} /* end large tag */
+
+		/* small tag */
+		len = p[0] & 0x07;
+		switch ((p[0]>>3) & 0x0f) {
+		case SMALL_TAG_IRQ:
+		{
+			if (len < 2 || len > 3)
+				goto sm_err;
+			write_irq(p, &res->irq_resource[irq]);
+			irq++;
+			break;
+		}
+		case SMALL_TAG_DMA:
+		{
+			if (len != 2)
+				goto sm_err;
+			write_dma(p, &res->dma_resource[irq]);
+			dma++;
+			break;
+		}
+		case SMALL_TAG_PORT:
+		{
+			if (len != 7)
+				goto sm_err;
+			write_port(p, &res->port_resource[port]);
+			port++;
+			break;
+		}
+		case SMALL_TAG_FIXEDPORT:
+		{
+			if (len != 3)
+				goto sm_err;
+			write_fixed_port(p, &res->port_resource[port]);
+			port++;
+			break;
+		}
+		case SMALL_TAG_END:
+		{
+			p = p + 2;
+			return (unsigned char *)p;
+			break;
+		}
+		default: /* an unkown tag */
+		{
+			sm_err:
+			pnp_warn("parser: Unknown small tag '0x%x'.", p[0]>>3);
+			break;
+		}
+		}
+                p += len + 1;
+	}
+	pnp_err("parser: Resource structure does not contain an end tag.");
+
+	return NULL;
+}
+
+EXPORT_SYMBOL(pnp_is_active);
+EXPORT_SYMBOL(pnp_parse_current_resources);
+EXPORT_SYMBOL(pnp_parse_possible_resources);
+EXPORT_SYMBOL(pnp_write_resources);
diff -urN a/include/linux/ioport.h b/include/linux/ioport.h
--- a/include/linux/ioport.h	Tue Jan 14 05:58:23 2003
+++ b/include/linux/ioport.h	Sat Feb  1 22:05:51 2003
@@ -77,6 +77,7 @@
 #define IORESOURCE_MEM_8BIT		(0<<3)
 #define IORESOURCE_MEM_16BIT		(1<<3)
 #define IORESOURCE_MEM_8AND16BIT	(2<<3)
+#define IORESOURCE_MEM_32BIT		(3<<3)
 #define IORESOURCE_MEM_SHADOWABLE	(1<<5)	/* dup: IORESOURCE_SHADOWABLE */
 #define IORESOURCE_MEM_EXPANSIONROM	(1<<6)
 
diff -urN a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Sun Feb  2 11:40:10 2003
+++ b/include/linux/pnp.h	Sat Feb  1 22:48:44 2003
@@ -149,11 +149,6 @@
 	struct pnp_mem *next;		/* next memory resource */
 };
 
-struct pnp_mem32 {
-	unsigned char data[17];
-	struct pnp_mem32 *next;		/* next 32-bit memory resource */
-};
-
 #define PNP_RES_PRIORITY_PREFERRED	0
 #define PNP_RES_PRIORITY_ACCEPTABLE	1
 #define PNP_RES_PRIORITY_FUNCTIONAL	2
@@ -166,7 +161,6 @@
 	struct pnp_irq *irq;		/* first IRQ */
 	struct pnp_dma *dma;		/* first DMA */
 	struct pnp_mem *mem;		/* first memory resource */
-	struct pnp_mem32 *mem32;	/* first 32-bit memory */
 	struct pnp_dev *dev;		/* parent */
 	struct pnp_resources *dep;	/* dependent resources */
 };
@@ -380,7 +374,6 @@
 int pnp_add_dma_resource(struct pnp_dev *dev, int depnum, struct pnp_dma *data);
 int pnp_add_port_resource(struct pnp_dev *dev, int depnum, struct pnp_port *data);
 int pnp_add_mem_resource(struct pnp_dev *dev, int depnum, struct pnp_mem *data);
-int pnp_add_mem32_resource(struct pnp_dev *dev, int depnum, struct pnp_mem32 *data);
 void pnp_init_resource_table(struct pnp_resource_table *table);
 int pnp_activate_dev(struct pnp_dev *dev);
 int pnp_disable_dev(struct pnp_dev *dev);
@@ -392,6 +385,12 @@
 int pnp_register_driver(struct pnp_driver *drv);
 void pnp_unregister_driver(struct pnp_driver *drv);
 
+/* support */
+int pnp_is_active(struct pnp_dev * dev);
+unsigned char * pnp_parse_current_resources(unsigned char * p, unsigned char * end, struct pnp_dev *dev);
+unsigned char * pnp_parse_possible_resources(unsigned char * p, unsigned char * end, struct pnp_dev *dev);
+unsigned char * pnp_write_resources(unsigned char * p, unsigned char * end, struct pnp_dev *dev);
+
 #else
 
 /* just in case anyone decides to call these without PnP Support Enabled */
@@ -413,8 +412,7 @@
 static inline int pnp_add_dma_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
 static inline int pnp_add_port_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
 static inline int pnp_add_mem_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
-static inline int pnp_add_mem32_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
-static void pnp_init_resource_table(struct pnp_resource_table *table) { ; }
+static inline void pnp_init_resource_table(struct pnp_resource_table *table) { ; }
 static inline int pnp_activate_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size) { ; }
@@ -424,6 +422,12 @@
 static inline int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_register_driver(struct pnp_driver *drv) { return -ENODEV; }
 static inline void pnp_unregister_driver(struct pnp_driver *drv) { ; }
+
+/* support */
+static inline int pnp_is_active(struct pnp_dev * dev) { return -ENODEV; )
+static inline unsigned char * pnp_parse_current_resources(unsigned char * p, unsigned char * end, struct pnp_dev *dev) { return NULL; }
+static inline unsigned char * pnp_parse_possible_resources(unsigned char * p, unsigned char * end, struct pnp_dev *dev) { return NULL; }
+static inline unsigned char * pnp_write_resources(unsigned char * p, unsigned char * end, struct pnp_dev *dev) { return NULL; )
 
 #endif /* CONFIG_PNP */
 
