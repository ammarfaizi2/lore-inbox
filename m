Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274813AbRIZDd4>; Tue, 25 Sep 2001 23:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274816AbRIZDdt>; Tue, 25 Sep 2001 23:33:49 -0400
Received: from sushi.toad.net ([162.33.130.105]:14000 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S274813AbRIZDdd>;
	Tue, 25 Sep 2001 23:33:33 -0400
Message-ID: <3BB14C82.609166A9@yahoo.co.uk>
Date: Tue, 25 Sep 2001 23:33:22 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] parport_pc.c PnP BIOS handling code
Content-Type: multipart/mixed;
 boundary="------------D22C1C6EF743DB7D876DF977"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D22C1C6EF743DB7D876DF977
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Attached is a patch which, although independent of the
PnP BIOS patch I posted earlier, is the companion of
that patch.  This patch modifies init_pnp040x() so
that it checks for the IORESOURCE_UNSET bit which
the PnP BIOS driver uses to indicate that a given
"struct resource" is vacuous.

The parport driver's mysterious rejection of dma==0,
which I asked about before, I now suspect to have been a
workaround for bugs in pnpbios which resulted in pnpbios 
reporting dma=0 when in fact the PnP BIOS had reported
no dma resource at all or else dma disabled.  Now that
those bugs are getting fixed, it seems okay to allow
the use of DMA0, and the patch does so.

--
Thomas Hood
--------------D22C1C6EF743DB7D876DF977
Content-Type: text/plain; charset=us-ascii;
 name="parport_pc-patch-20010925-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="parport_pc-patch-20010925-1"

--- linux-2.4.9-ac13-mwave/drivers/parport/parport_pc.c_ORIG	Fri Sep 21 15:23:19 2001
+++ linux-2.4.9-ac13-mwave/drivers/parport/parport_pc.c	Tue Sep 25 23:10:17 2001
@@ -2797,26 +2797,66 @@
 	return count;
 }
 
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
 
 /* This function is called by parport_pc_init if the user didn't
  * specify any ports to probe.  Its job is to find some ports.  Order

--------------D22C1C6EF743DB7D876DF977--

