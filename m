Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275110AbRIYQ4E>; Tue, 25 Sep 2001 12:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275109AbRIYQzq>; Tue, 25 Sep 2001 12:55:46 -0400
Received: from sushi.toad.net ([162.33.130.105]:25286 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S275108AbRIYQza>;
	Tue, 25 Sep 2001 12:55:30 -0400
Message-ID: <3BB0B6F4.3BBCAACE@yahoo.co.uk>
Date: Tue, 25 Sep 2001 12:55:16 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Bigger change to pnp_bios.c
Content-Type: multipart/mixed;
 boundary="------------5D77C55A99C54EEBC6620DC9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5D77C55A99C54EEBC6620DC9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

For those of keen eye, my last patch contained a (harmless)
bug: a ',' in place of '&&'.  

The attached patch replaces yesterday's patch and contains
a number of additional needed changes.

-  "struct resource" was mistyped "struct ressource" in one place.
-  build_devlist() contained a memory leak: struct pci_devs were
   kmalloc()ed but not freed if left unused.
-  Made all printk()s consistent: start with "PnPBIOS:"
-  Made some code formatting and other trivial changes
-  Incorrect nodenum was recorded in dev->devfn
-  But most importantly, the driver now distinguishes between
   resource data that has not been set and resources that are
   reported by the PnP BIOS as extant but disabled.  Whereas
   previously a struct resource .start value of 0 was ambiguous
   between  "resource does not exist" and "resource is disabled",
   now the .flags field (specifically, the IORESOURCE_UNSET bit) is
   used to indicate an unused struct, while a .start value of -1
   is used to indicate a disabled irq or dma.

This patch supersedes the previous one I submitted yesterday
in a file called "pnpbios-patch-20010924-1" attached to a message
entitled "Small change to pnp_bios.c".

--
Thomas
--------------5D77C55A99C54EEBC6620DC9
Content-Type: text/plain; charset=us-ascii;
 name="pnpbios-patch-20010925-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpbios-patch-20010925-1"

--- linux-2.4.9-ac13-mwave/drivers/pnp/pnp_bios.c_1	Fri Sep 21 16:15:44 2001
+++ linux-2.4.9-ac13-mwave/drivers/pnp/pnp_bios.c	Tue Sep 25 12:53:19 2001
@@ -593,18 +593,18 @@
 		for (sum = 0, i = 0; i < length; i++)
 			sum += check->chars[i];
 		if (sum)
 			continue;
 		if (check->fields.version < 0x10) {
-			printk(KERN_WARNING "PnP: unsupported version %d.%d",
+			printk(KERN_WARNING "PnPBIOS: unsupported version %d.%d",
 			       check->fields.version >> 4,
 			       check->fields.version & 15);
 			continue;
 		}
-		printk(KERN_INFO "PnP: PNP BIOS installation structure at 0x%p\n",
+		printk(KERN_INFO "PnPBIOS: PnP BIOS installation structure at 0x%p\n",
 		       check);
-		printk(KERN_INFO "PnP: PNP BIOS version %d.%d, entry at %x:%x, dseg at %x\n",
+		printk(KERN_INFO "PnPBIOS: PnP BIOS version %d.%d, entry at %x:%x, dseg at %x\n",
                        check->fields.version >> 4, check->fields.version & 15,
 		       check->fields.pm16cseg, check->fields.pm16offset,
 		       check->fields.pm16dseg);
 		Q2_SET_SEL(PNP_CS32, &pnp_bios_callfunc, 64 * 1024);
 		Q_SET_SEL(PNP_CS16, check->fields.pm16cseg, 64 * 1024);
@@ -644,33 +644,49 @@
 EXPORT_SYMBOL(pnp_bios_present);
 EXPORT_SYMBOL(pnp_bios_dev_node_info);
 
 static void inline pnpbios_add_irqresource(struct pci_dev *dev, int irq)
 {
+	// Permit irq==-1 which signifies "disabled"
 	int i = 0;
-	while (dev->irq_resource[i].start && i < DEVICE_COUNT_IRQ) i++;
-	if (i < DEVICE_COUNT_IRQ)
+	while (!(dev->irq_resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_IRQ) i++;
+	if (i < DEVICE_COUNT_IRQ) {
 		dev->irq_resource[i].start = irq;
+		dev->irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
+	}
 }
 
 static void inline pnpbios_add_dmaresource(struct pci_dev *dev, int dma)
 {
+	// Permit dma==-1 which signifies "disabled"
 	int i = 0;
-	while (dev->dma_resource[i].start && i < DEVICE_COUNT_DMA) i++;
-	if (i < DEVICE_COUNT_DMA)
+	while (!(dev->dma_resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_DMA) i++;
+	if (i < DEVICE_COUNT_DMA) {
 		dev->dma_resource[i].start = dma;
+		dev->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
+	}
 }
 
-static void __init pnpbios_add_ioresource(struct pci_dev *dev, int io, 
-					  int len, int flags)
+static void __init pnpbios_add_ioresource(struct pci_dev *dev, int io, int len)
 {
 	int i = 0;
-	while (dev->resource[i].start && i < DEVICE_COUNT_RESOURCE) i++;
+	while (!(dev->resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_RESOURCE) i++;
 	if (i < DEVICE_COUNT_RESOURCE) {
 		dev->resource[i].start = io;
 		dev->resource[i].end = io + len;
-		dev->resource[i].flags = flags;
+		dev->resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
+	}
+}
+
+static void __init pnpbios_add_memresource(struct pci_dev *dev, int io, int len)
+{
+	int i = 0;
+	while (!(dev->resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_RESOURCE) i++;
+	if (i < DEVICE_COUNT_RESOURCE) {
+		dev->resource[i].start = io;
+		dev->resource[i].end = io + len;
+		dev->resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
 	}
 }
 
 static char * __init pnpid32_to_pnpid(u32 id);
 
@@ -678,22 +694,22 @@
  * request I/O ports which are used according to the PnP BIOS
  * to avoid I/O conflicts.
  */
 static void mboard_request(char *pnpid, int io, int len)
 {
-    struct ressource *res;
+    struct resource *res;
     
     if (0 != strcmp(pnpid,"PNP0c01") &&  /* memory controller */
 	0 != strcmp(pnpid,"PNP0c02"))    /* system peripheral: other */
 	return;
 
     if (io < 0x100) {
 	/*
 	 * below 0x100 is only standard PC hardware
 	 * (pics, kbd, timer, dma, ...)
 	 *
-	 * We should not get ressource conflicts there,
+	 * We should not get resource conflicts there,
 	 * and the kernel reserves these anyway
 	 * (see arch/i386/kernel/setup.c).
 	 */
 	return;
     }
@@ -714,75 +730,91 @@
 
 /* parse PNPBIOS "Allocated Resources Block" and fill IO,IRQ,DMA into pci_dev */
 static void __init pnpbios_rawdata_2_pci_dev(struct pnp_bios_node *node, struct pci_dev *pci_dev)
 {
 	unsigned char *p = node->data, *lastp=NULL;
-        int mask,i,io,irq,len,dma;
 
-	memset(pci_dev, 0, sizeof(struct pci_dev));
         while ( (char *)p < ((char *)node->data + node->size )) {
         	if(p==lastp) break;
 
                 if( p[0] & 0x80 ) {// large item
 			switch (p[0] & 0x7f) {
 			case 0x01: // memory
-				io = *(short *) &p[4];
-				len = *(short *) &p[10];
-				pnpbios_add_ioresource(pci_dev, io, len, IORESOURCE_MEM);
+			{
+				int io = *(short *) &p[4];
+				int len = *(short *) &p[10];
+				pnpbios_add_memresource(pci_dev, io, len);
 				break;
+			}
 			case 0x02: // device name
-				len = *(short *) &p[1];
+			{
+				int len = *(short *) &p[1];
 				memcpy(pci_dev->name, p + 3, len >= 80 ? 79 : len);
 				break;
+			}
 			case 0x05: // 32-bit memory
-				io = *(int *) &p[4];
-				len = *(int *) &p[16];
-				pnpbios_add_ioresource(pci_dev, io, len, IORESOURCE_MEM);
+			{
+				int io = *(int *) &p[4];
+				int len = *(int *) &p[16];
+				pnpbios_add_memresource(pci_dev, io, len);
 				break;
+			}
 			case 0x06: // fixed location 32-bit memory
-				io = *(int *) &p[4];
-				len = *(int *) &p[8];
-				pnpbios_add_ioresource(pci_dev, io, len, IORESOURCE_MEM);
+			{
+				int io = *(int *) &p[4];
+				int len = *(int *) &p[8];
+				pnpbios_add_memresource(pci_dev, io, len);
 				break;
 			}
+			} /* switch */
                         lastp = p+3;
                         p = p + p[1] + p[2]*256 + 3;
                         continue;
                 }
                 if ((p[0]>>3) == 0x0f) // end tag
                         break;
                 switch (p[0]>>3) {
                 case 0x04: // irq
-                        irq = -1;
+                {
+                        int i, mask, irq = -1; // "disabled"
                         mask= p[1] + p[2]*256;
                         for (i=0;i<16;i++, mask=mask>>1)
-                                if(mask &0x01) irq=i;
+                                if(mask & 0x01) irq=i;
 			pnpbios_add_irqresource(pci_dev, irq);
                         break;
+                }
                 case 0x05: // dma
-                        dma = -1;
+                {
+                        int i, mask, dma = -1; // "disabled"
                         mask = p[1];
                         for (i=0;i<8;i++, mask = mask>>1)
-                                if(mask&0x01) dma=i;
+                                if(mask & 0x01) dma=i;
 			pnpbios_add_dmaresource(pci_dev, dma);
                         break;
+                }
                 case 0x08: // io
-			io= p[2] + p[3] *256;
-			len = p[7];
-			pnpbios_add_ioresource(pci_dev, io, len, IORESOURCE_IO);
+                {
+			int io= p[2] + p[3] *256;
+			int len = p[7];
+			pnpbios_add_ioresource(pci_dev, io, len);
 			mboard_request(pnpid32_to_pnpid(node->eisa_id),io,len);
                         break;
+                }
 		case 0x09: // fixed location io
-			io = p[1] + p[2] * 256;
-			len = p[3];
-			pnpbios_add_ioresource(pci_dev, io, len, IORESOURCE_IO);
+		{
+			int io = p[1] + p[2] * 256;
+			int len = p[3];
+			pnpbios_add_ioresource(pci_dev, io, len);
 			break;
-                }
+		}
+                } /* switch */
                 lastp=p+1;
                 p = p + (p[0] & 0x07) + 1;
 
-        }
+        } /* while */
+
+        return;
 }
 
 #define HEX(id,a) hex[((id)>>a) & 15]
 #define CHAR(id,a) (0x40 + (((id)>>a) & 31))
 
@@ -816,21 +848,49 @@
 	/* FIXME: Need to check for re-add of existing node */
 	list_add_tail(&dev->global_list, &pnpbios_devices);
 	return 0;
 }
 
+static struct pci_dev * __init pnpbios_kmalloc_pci_dev( void )
+{
+	struct pci_dev *dev;
+	int i;
+
+	dev =  kmalloc( sizeof(struct pci_dev), GFP_KERNEL );
+	if (!dev)
+		return NULL;
+
+	memset(dev,0,sizeof(struct pci_dev));
+
+	for (i=0;i<DEVICE_COUNT_RESOURCE;i++) {
+	/*	dev->resource[i].start = 0; */
+		dev->resource[i].flags = IORESOURCE_UNSET;
+	}
+	for (i=0;i<DEVICE_COUNT_IRQ;i++) {
+		dev->irq_resource[i].start = (unsigned long)-1;  // "disabled"
+		dev->irq_resource[i].flags = IORESOURCE_UNSET;
+	}
+	for (i=0;i<DEVICE_COUNT_DMA;i++) {
+		dev->dma_resource[i].start = (unsigned long)-1;  // "disabled"
+		dev->dma_resource[i].flags = IORESOURCE_UNSET;
+	}
+
+	return dev;
+}
+
 /*
  *	Build the list of pci_dev objects from the PnP table
  */
  
 static void __init pnpbios_build_devlist(void)
 {
-	int i, devs = 0;
+	int i;
+	int nodes_got = 0;
 	struct pnp_bios_node *node;
         struct pnp_dev_node_info node_info;
 	struct pci_dev *dev;
-	int num;
+	int nodenum;
 	char *pnpid;
 
 	
         if (!pnp_bios_present ())
                 return;
@@ -840,33 +900,29 @@
 
         node = kmalloc(node_info.max_node_size, GFP_KERNEL);
         if (!node)
                 return;
 
-	for(i=0;i<0xff;i++) {
-		dev =  kmalloc(sizeof (struct pci_dev), GFP_KERNEL);
+	for(i=0,nodenum=0;i<0xff && nodenum!=0xff;i++) {
+		int thisnodenum = nodenum;
+                if (pnp_bios_get_dev_node((u8 *)&nodenum, (char )0 , node))
+			continue;
+		nodes_got++;
+		dev = pnpbios_kmalloc_pci_dev();
 		if (!dev)
 			break;
-			
-                if (pnp_bios_get_dev_node((u8 *)&num, (char )0 , node))
-			continue;
-
-		devs++;
 		pnpbios_rawdata_2_pci_dev(node,dev);
-		dev->devfn=num;
+		dev->devfn=thisnodenum;
 		pnpid = pnpid32_to_pnpid(node->eisa_id);
 		memcpy(dev->name,"PNPBIOS",8);
 		memcpy(dev->slot_name,pnpid,8);
 		if(pnpbios_insert_device(dev)<0)
 			kfree(dev);
 	}
 	kfree(node);
 
-	if (devs)
-		printk(KERN_INFO "PnP: %i device%s detected total\n", devs, devs > 1 ? "s" : "");
-	else
-		printk(KERN_INFO "PnP: No devices found\n");
+	printk(KERN_INFO "PnPBIOS: %i node%s reported by PnP BIOS\n", nodes_got, nodes_got != 1 ? "s" : "");
 }
 
 
 /*
  *	The public interface to PnP BIOS enumeration

--------------5D77C55A99C54EEBC6620DC9--

