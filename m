Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271368AbRIFQfG>; Thu, 6 Sep 2001 12:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271365AbRIFQe5>; Thu, 6 Sep 2001 12:34:57 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:26123 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S271344AbRIFQes>;
	Thu, 6 Sep 2001 12:34:48 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 6 Sep 2001 18:32:17 +0200
From: Gerd Knorr <kraxel@bytesex.org>
Message-Id: <200109061632.f86GWHDB007006@bytesex.masq.in-berlin.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PNPBIOS: warning: >= 16 resources, overflow?
In-Reply-To: <20010906150451.A5256@bytesex.org>
In-Reply-To: <slrn9pedo0.3eu.kraxel@bytesex.org> <E15exwY-0007xb-00@the-village.bc.nu> <20010906150451.A5256@bytesex.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In lists.linux.kernel, you wrote:
> > For the motherboard memory/io ranges it might be worth teaching the
> > pnp bios parser to actually reserve the regions as it scans them ?
>  
>  No trivial way.  Need to read some more code to see how the parser
>  works [ ... ]

Ok, figured how I can hook it directly into the parser.

  Gerd

-------------------------- cut here ------------------------
--- 2.4.9-ac7/drivers/pnp/Makefile.fix	Thu Sep  6 17:43:51 2001
+++ 2.4.9-ac7/drivers/pnp/Makefile	Thu Sep  6 17:48:46 2001
@@ -17,7 +17,7 @@
 isa-pnp-objs := isapnp.o quirks.o $(proc-y)
 
 procpnp-$(CONFIG_PROC_FS) = pnp_proc.o
-pnpbios-objs := pnp_bios.o mboard.o $(procpnp-y)
+pnpbios-objs := pnp_bios.o $(procpnp-y)
 
 obj-$(CONFIG_ISAPNP) += isa-pnp.o
 obj-$(CONFIG_PNPBIOS) += pnpbios.o
--- 2.4.9-ac7/drivers/pnp/pnp_bios.c.fix	Thu Sep  6 17:44:30 2001
+++ 2.4.9-ac7/drivers/pnp/pnp_bios.c	Thu Sep  6 17:49:08 2001
@@ -50,7 +50,6 @@
 
 void pnp_proc_init(void);
 static void pnpbios_build_devlist(void);
-int pnpbios_request_mboard(void);
 
 /*
  * This is the standard structure used to identify the entry point
@@ -616,7 +615,6 @@
 		break;
 	}
 	pnpbios_build_devlist();
-	pnpbios_request_mboard();
 #ifdef CONFIG_PROC_FS
 	pnp_proc_init();
 #endif
@@ -674,6 +672,46 @@
 	}
 }
 
+static char * __init pnpid32_to_pnpid(u32 id);
+
+/*
+ * request I/O ports which are used according to the PnP BIOS
+ * to avoid I/O conflicts.
+ */
+static void mboard_request(char *pnpid, int io, int len)
+{
+    struct ressource *res;
+    
+    if (0 != strcmp(pnpid,"PNP0c01") &&  /* memory controller */
+	0 != strcmp(pnpid,"PNP0c02"))    /* system peripheral: other */
+	return;
+
+    if (io < 0x100) {
+	/*
+	 * below 0x100 is only standard PC hardware
+	 * (pics, kbd, timer, dma, ...)
+	 *
+	 * We should not get ressource conflicts there,
+	 * and the kernel reserves these anyway
+	 * (see arch/i386/kernel/setup.c).
+	 */
+	return;
+    }
+
+    /*
+     * anything else we'll try reserve to avoid these ranges are
+     * assigned to someone (CardBus bridges for example) and thus are
+     * triggering resource conflicts.
+     *
+     * failures at this point are usually harmless. pci quirks for
+     * example do reserve stuff they know about too, so we might have
+     * double reservations here.
+     */
+    res = request_region(io,len,pnpid);
+    printk("PnPBIOS: %s: request 0x%x-0x%x%s\n",
+	   pnpid,io,io+len,NULL != res ? " ok" : "");
+}
+
 /* parse PNPBIOS "Allocated Resources Block" and fill IO,IRQ,DMA into pci_dev */
 static void __init pnpbios_rawdata_2_pci_dev(struct pnp_bios_node *node, struct pci_dev *pci_dev)
 {
@@ -729,6 +767,7 @@
 			io= p[2] + p[3] *256;
 			len = p[7];
 			pnpbios_add_ioresource(pci_dev, io, len, IORESOURCE_IO);
+			mboard_request(pnpid32_to_pnpid(node->eisa_id),io,len);
                         break;
 		case 0x09: // fixed location io
 			io = p[1] + p[2] * 256;
--- 2.4.9-ac7/drivers/pnp/mboard.c.fix	Thu Sep  6 17:43:51 2001
+++ 2.4.9-ac7/drivers/pnp/mboard.c	Thu Sep  6 17:49:22 2001
@@ -1,88 +0,0 @@
-/*
- * request I/O ports which are used according to the PnP BIOS.
- *
- * (c) 2001 Gerd Knorr <kraxel@bytesex.org>
- */
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/init.h>
-
-#include <asm/io.h>
-#include <asm/dma.h>
-#include <asm/uaccess.h>
-
-#include <linux/pnp_bios.h>
-
-static int __init request_stuff(char *pnp, struct pci_dev *dev)
-{
-	struct resource *res;
-	int i,count = 0;
-	unsigned long start;
-
-	printk(KERN_INFO "%s: request ports [%s]:",dev->name,pnp);
-	for (i = 0; i < DEVICE_COUNT_RESOURCE &&
-		    (dev->resource[i].start || dev->resource[i].end); i++) {
-		if (dev->resource[i].start > 0xffff ||
-		    dev->resource[i].end   > 0xffff) {
-			/*
-			 * these are memory ressources -- ignore them.
-			 * The PnP BIOS reports the main memory layout
-			 * this way.
-			 *
-			 * FIXME: It might be worth merging the reserved
-			 * maps reported here into our PCI tables - AC
-			 */
-			continue;
-		}
-		if (dev->resource[i].end < 0x100) {
-			/*
-			 * below 0x100 is only standard PC hardware
-			 * (pics, kbd, timer, dma, ...)
-			 *
-			 * We should not get ressource conflicts there,
-			 * and the kernel reserves these anyway
-			 * (see arch/i386/kernel/setup.c).
-			 */
-			continue;
-		}
-		
-		start = dev->resource[i].start;
-	
-		/*
-		 *	Handle a resource spanning the mboard and I/O 
-	 	 *	areas. Chop off its head for the reservation
-	 	 */
-
-		if(start < 0x100)
-			start = 0x100;
-	
-		/*
-		 * anything else we'll reserve to avoid these ranges are
-		 * assigned to someone (CardBus bridges for example) and
-		 * thus are triggering resource conflicts.
-		 */
-		res = request_region(start,
-			dev->resource[i].end - start,
-			dev->name);
-		printk(" 0x%lx-0x%lx",
-			dev->resource[i].start, dev->resource[i].end);
-		count++;
-	} 
-	printk("\n");
-	if (i == DEVICE_COUNT_RESOURCE)
-		printk("%s: warning: >= %d resources, overflow?\n",
-			dev->name,DEVICE_COUNT_RESOURCE);
-	return count;
-}
-
-int __init pnpbios_request_mboard(void)
-{
-	struct pci_dev *dev = NULL;
-	int count = 0;
-
-	while ((dev=pnpbios_find_device("PNP0c01",dev)))
-		count += request_stuff("PNP0c01",dev);
-	while ((dev=pnpbios_find_device("PNP0c02",dev)))
-		count += request_stuff("PNP0c02",dev);
-	return count;
-}
