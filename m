Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276753AbRJHCCl>; Sun, 7 Oct 2001 22:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276759AbRJHCCc>; Sun, 7 Oct 2001 22:02:32 -0400
Received: from hermes.toad.net ([162.33.130.251]:65418 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S276753AbRJHCCP>;
	Sun, 7 Oct 2001 22:02:15 -0400
Subject: [PATCH] 2.4.10-ac8 parport_pc fix
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 07 Oct 2001 22:02:15 -0400
Message-Id: <1002506536.848.103.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch for the 2.4.10-ac8 parport_pc driver.

Now that the PnP BIOS driver tells the difference between a
device's not using a resource type, its use of that resource
type being disabled, and its use of that resource with number
zero, we can modify the parport_pc driver to interpret and
report that information correctly.

This patch is independent of the PnP BIOS driver patches
I just submitted.

// Thomas

The patch:
--- linux-2.4.10-ac8/drivers/parport/parport_pc.c	Sun Oct  7 14:38:44 2001
+++ linux-2.4.10-ac8-fix/drivers/parport/parport_pc.c	Sun Oct  7 15:37:44 2001
@@ -2799,22 +2799,62 @@
 
 #if defined (CONFIG_PNPBIOS) || defined (CONFIG_PNPBIOS_MODULE)
 
+#define UNSET(res)   ((res).flags & IORESOURCE_UNSET)
+
 int init_pnp040x(struct pci_dev *dev)
-{	int io,iohi,irq,dma;
+{
+	int io,iohi,irq,dma;
+
+	printk(KERN_INFO
+		"parport: PnP BIOS reports device %s %s (node number 0x%x) is ",
+		dev->name, dev->slot_name, dev->devfn
+	);
+
+	if ( UNSET(dev->resource[0]) ) {
+		printk("not configured.\n");
+		return 0;
+	}
+	io  = dev->resource[0].start;
+	printk("configured to use io 0x%04x",io);
+	if ( UNSET(dev->resource[1]) ) {
+		iohi = 0;
+	} else {
+		iohi = dev->resource[1].start;
+		printk(", io 0x%04x",iohi);
+	}
 
-	io=dev->resource[0].start;
-	iohi=dev->resource[1].start;
-	irq=dev->irq_resource[0].start;
-	dma=dev->dma_resource[0].start;
+	if ( UNSET(dev->irq_resource[0]) ) {
+		irq = PARPORT_IRQ_NONE;
+	} else {
+		if ( dev->irq_resource[0].start == -1 ) {
+			irq = PARPORT_IRQ_NONE;
+			printk(", irq disabled");
+		} else {
+			irq = dev->irq_resource[0].start;
+			printk(", irq %d",irq);
+		}
+	}
 
-	if(dma==0) dma=-1;
+	if ( UNSET(dev->dma_resource[0]) ) {
+		dma = PARPORT_DMA_NONE;
+	} else {
+		if ( dev->dma_resource[0].start == -1 ) {
+			dma = PARPORT_DMA_NONE;
+			printk(", dma disabled");
+		} else {
+			dma = dev->dma_resource[0].start;
+			printk(", dma %d",irq);
+		}
+	}
+
+	printk("\n");
 
-	printk(KERN_INFO "PnPBIOS: Parport found %s %s at io=%04x,%04x irq=%d dma=%d\n",
-		dev->name,dev->slot_name,io,iohi,irq,dma);
 	if (parport_pc_probe_port(io,iohi,irq,dma,NULL))
 		return 1;
+
 	return 0;
 }
+#undef UNSET
 
 #endif 
 

