Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267646AbTBQXR2>; Mon, 17 Feb 2003 18:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267674AbTBQXQx>; Mon, 17 Feb 2003 18:16:53 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:14497 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267649AbTBQXNz>;
	Mon, 17 Feb 2003 18:13:55 -0500
Date: Mon, 17 Feb 2003 18:23:35 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] pnp - PnP BIOS Updates (6/13)
Message-ID: <20030217182335.GA31438@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch solves the GPF bug(get current resources) that has been causing
pnpbios lockups for well over a year before my involvement with this driver.
The pnpbios proc interface should now be safe to use.  It also updates the
pnpbios code to use the new parsing functions and simplifies pnp disable.

Please apply,
Adam


--- a/drivers/pnp/pnpbios/core.c~	Tue Jan 14 05:58:04 2003
+++ a/drivers/pnp/pnpbios/core.c	Sun Feb  9 10:45:42 2003
@@ -142,6 +142,8 @@
 set_limit(cpu_gdt_table[cpu][(selname) >> 3], size); \
 } while(0)
 
+static struct desc_struct bad_bios_desc = { 0, 0x00409200 };
+
 /*
  * At some point we want to use this stack frame pointer to unwind
  * after PnP BIOS oopses. 
@@ -160,6 +162,8 @@
 {
 	unsigned long flags;
 	u16 status;
+	struct desc_struct save_desc_40;
+	int cpu;
 
 	/*
 	 * PnP BIOSes are generally not terribly re-entrant.
@@ -168,6 +172,10 @@
 	if(pnp_bios_is_utter_crap)
 		return PNP_FUNCTION_NOT_SUPPORTED;
 
+	cpu = get_cpu();
+	save_desc_40 = cpu_gdt_table[cpu][0x40 / 8];
+	cpu_gdt_table[cpu][0x40 / 8] = bad_bios_desc;
+
 	/* On some boxes IRQ's during PnP BIOS calls are deadly.  */
 	spin_lock_irqsave(&pnp_bios_lock, flags);
 
@@ -207,6 +215,9 @@
 		: "memory"
 	);
 	spin_unlock_irqrestore(&pnp_bios_lock, flags);
+
+	cpu_gdt_table[cpu][0x40 / 8] = save_desc_40;
+	put_cpu();
 	
 	/* If we get here and this is set then the PnP BIOS faulted on us. */
 	if(pnp_bios_is_utter_crap)
@@ -236,6 +247,8 @@
 	void *p = kmalloc( size, f );
 	if ( p == NULL )
 		printk(KERN_ERR "PnPBIOS: kmalloc() failed\n");
+	else
+		memset(p, 0, size);
 	return p;
 }
 
@@ -664,381 +677,6 @@
 
 #endif   /* CONFIG_HOTPLUG */
 
-
-/* pnp current resource reading functions */
-
-
-static void add_irqresource(struct pnp_dev *dev, int irq)
-{
-	int i = 0;
-	while (pnp_irq_valid(dev, i) && i < DEVICE_COUNT_IRQ) i++;
-	if (i < DEVICE_COUNT_IRQ) {
-		dev->irq_resource[i].start = 
-		dev->irq_resource[i].end = (unsigned long) irq;
-		dev->irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
-	}
-}
-
-static void add_dmaresource(struct pnp_dev *dev, int dma)
-{
-	int i = 0;
-	while (pnp_dma_valid(dev, i) && i < DEVICE_COUNT_DMA) i++;
-	if (i < DEVICE_COUNT_DMA) {
-		dev->dma_resource[i].start =
-		dev->dma_resource[i].end = (unsigned long) dma;
-		dev->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
-	}
-}
-
-static void add_ioresource(struct pnp_dev *dev, int io, int len)
-{
-	int i = 0;
-	while (pnp_port_valid(dev, i) && i < DEVICE_COUNT_IO) i++;
-	if (i < DEVICE_COUNT_RESOURCE) {
-		dev->io_resource[i].start = (unsigned long) io;
-		dev->io_resource[i].end = (unsigned long)(io + len - 1);
-		dev->io_resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
-	}
-}
-
-static void add_memresource(struct pnp_dev *dev, int mem, int len)
-{
-	int i = 0;
-	while (pnp_mem_valid(dev, i) && i < DEVICE_COUNT_MEM) i++;
-	if (i < DEVICE_COUNT_RESOURCE) {
-		dev->mem_resource[i].start = (unsigned long) mem;
-		dev->mem_resource[i].end = (unsigned long)(mem + len - 1);
-		dev->mem_resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
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
-	for (i=0;i<DEVICE_COUNT_IO;i++) {
-		dev->io_resource[i].start = 0;
-		dev->io_resource[i].end = 0;
-		dev->io_resource[i].flags = IORESOURCE_IO|IORESOURCE_UNSET;
-	}
-	for (i=0;i<DEVICE_COUNT_MEM;i++) {
-		dev->mem_resource[i].start = 0;
-		dev->mem_resource[i].end = 0;
-		dev->mem_resource[i].flags = IORESOURCE_MEM|IORESOURCE_UNSET;
-	}
-	for (i=0;i<DEVICE_COUNT_IRQ;i++) {
-		dev->irq_resource[i].start = (unsigned long)-1;
-		dev->irq_resource[i].end = (unsigned long)-1;
-		dev->irq_resource[i].flags = IORESOURCE_IRQ|IORESOURCE_UNSET;
-	}
-	for (i=0;i<DEVICE_COUNT_DMA;i++) {
-		dev->dma_resource[i].start = (unsigned long)-1;
-		dev->dma_resource[i].end = (unsigned long)-1;
-		dev->dma_resource[i].flags = IORESOURCE_DMA|IORESOURCE_UNSET;
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
-				memcpy(dev->name, p + 3, len >= 80 ? 79 : len);
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
-	if (pnp_port_valid(dev, 0) == 0 &&
-	    pnp_mem_valid(dev, 0) == 0 &&
-	    pnp_irq_valid(dev, 0) == 0 &&
-	    pnp_dma_valid(dev, 0) == 0)
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
@@ -1075,20 +713,26 @@
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
@@ -1099,177 +743,20 @@
 			memcpy(&dev_id->id, id, 7);
 			pnp_add_id(dev_id, dev);
 			break;
-                }
-                } /* switch */
-		__skip:
-                p += len + 1;
-
-        } /* while */
-}
-
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
-static int node_set_resources(struct pnp_bios_node *node, struct pnp_cfg *config)
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
 		}
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
 		}
-                } /* switch */
 		__skip:
-                p += len + 1;
-
-        } /* while */
+		p += len + 1;
 
-	/* we never got an end tag so this data is corrupt or invalid */
-	return -EINVAL;
-
-	done:
-	error = pnp_bios_set_dev_node(node->handle, (char)0, node);
-        return error;
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
@@ -1278,18 +765,22 @@
 	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -1;
-	if (pnp_bios_get_dev_node(&nodenum, (char )0, node))
+	if (pnp_bios_get_dev_node(&nodenum, (char )0, node)) {
+		kfree(node);
 		return -ENODEV;
-	node_current_resource_data_to_dev(node,dev);
+	}
+	pnp_parse_current_resources((char *)node->data,(char *)node->data + node->size,res);
+	dev->active = pnp_is_active(dev);
 	kfree(node);
 	return 0;
 }
 
-static int pnpbios_set_resources(struct pnp_dev *dev, struct pnp_cfg *config)
+static int pnpbios_set_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
 {
 	struct pnp_dev_node_info node_info;
 	u8 nodenum = dev->number;
 	struct pnp_bios_node * node;
+	int ret;
 
 	/* just in case */
 	if (!pnpbios_is_dynamic(dev))
@@ -1301,83 +792,42 @@
 		return -1;
 	if (pnp_bios_get_dev_node(&nodenum, (char )1, node))
 		return -ENODEV;
-	if(node_set_resources(node, config)<0){
+	if(!pnp_write_resources((char *)node->data,(char *)node->data + node->size,res)){
+		kfree(node);
 		return -1;
 	}
+	ret = pnp_bios_set_dev_node(node->handle, (char)0, node);
 	kfree(node);
-	return 0;
+	if (ret > 0)
+		ret = -1;
+	return ret;
 }
 
 static int pnpbios_disable_resources(struct pnp_dev *dev)
 {
-	struct pnp_cfg * config = kmalloc(sizeof(struct pnp_cfg), GFP_KERNEL);
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
-	.pad	= 0,
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
+	int ret;
+	
 	/* just in case */
 	if(dev->flags & PNPBIOS_NO_DISABLE || !pnpbios_is_dynamic(dev))
 		return -EPERM;
-	memset(config, 0, sizeof(struct pnp_cfg));
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
-	if(node_set_resources(node, config)<0)
-		goto failed;
-	kfree(config);
-	kfree(node);
-	return 0;
- failed:
+		return -ENOMEM;
+	ret = pnp_bios_set_dev_node(dev->number, (char)0, node);
+	dev->active = 0;
 	kfree(node);
-	kfree(config);
-	return -1;
+	if (ret > 0)
+		ret = -1;
+	return ret;
 }
 
-
 /* PnP Layer support */
 
 static struct pnp_protocol pnpbios_protocol = {
@@ -1387,15 +837,47 @@
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
@@ -1403,14 +885,11 @@
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
@@ -1424,51 +903,15 @@
 
 	for(nodenum=0; nodenum<0xff; ) {
 		u8 thisnodenum = nodenum;
-		/* We build the list from the "boot" config because
-		 * we know that the resources couldn't have changed
-		 * at this stage.  Furthermore some buggy PnP BIOSes
-		 * will crash if we request the "current" config
-		 * from devices that are can only be static such as
-		 * those controlled by the "system" driver.
-		 */
-		if (pnp_bios_get_dev_node(&nodenum, (char )1, node))
+		if (pnp_bios_get_dev_node(&nodenum, (char )0, node))
 			break;
 		nodes_got++;
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
-		strcpy(dev->name,"Unknown Device");
-		pnpid32_to_pnpid(node->eisa_id,id);
-		memcpy(dev_id->id,id,7);
-		pnp_add_id(dev_id, dev);
-		pos = node_current_resource_data_to_dev(node,dev);
-		pos = node_possible_resource_data_to_dev(pos,node,dev);
-		node_id_data_to_dev(pos,node,dev);
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
@@ -1563,6 +1006,8 @@
 		pnp_bios_callpoint.segment = PNP_CS16;
 		pnp_bios_hdr = check;
 
+		set_base(bad_bios_desc, __va((unsigned long)0x40 << 4));
+		_set_limit((char *)&bad_bios_desc, 4095 - (0x40 << 4));
 		for(i=0; i < NR_CPUS; i++)
 		{
 			Q2_SET_SEL(i, PNP_CS32, &pnp_bios_callfunc, 64 * 1024);
