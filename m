Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280820AbRKON37>; Thu, 15 Nov 2001 08:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280825AbRKON3s>; Thu, 15 Nov 2001 08:29:48 -0500
Received: from sushi.toad.net ([162.33.130.105]:37254 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S280820AbRKON3q>;
	Thu, 15 Nov 2001 08:29:46 -0500
Subject: [PATCH] parport_pc to use pnpbios_register_driver() #4
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1005752791.8923.44.camel@thanatos>
In-Reply-To: <Pine.LNX.4.33.0111140935350.791-100000@vaio>  
	<15273.1005733037@redhat.com>  <1005752791.8923.44.camel@thanatos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 15 Nov 2001 08:30:02 -0500
Message-Id: <1005831004.26182.16.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> What I would rather do is write parport_pc consistently
> with how all other drivers are written.  Then if we
> decide to set all this up more intelligently in the
> future we can make a global change.

Since everyone except parport_pc simply does:
   #ifdef CONFIG_PNPBIOS
   ...
   #endif
(i.e., no "|| defined(CONFIG_PNPBIOS_MODULE)") I have
changed my patch to be consistent with that practice.

Other changes:
- Merge init_pnp040x into callback
- Use a buffer to build up message

This patch has been tested with the new modutils, and
the modules.pnpbiosmap file is correctly generated.

--
Thomas Hood

The patch:
--- linux-2.4.13-ac8_ORIG/drivers/parport/parport_pc.c	Fri Oct 26 18:13:48 2001
+++ linux-2.4.13-ac8/drivers/parport/parport_pc.c	Thu Nov 15 08:21:35 2001
@@ -63,7 +63,7 @@
 #include <linux/parport_pc.h>
 #include <asm/parport.h>
 
-#if defined (CONFIG_PNPBIOS) || defined (CONFIG_PNPBIOS_MODULE)
+#ifdef CONFIG_PNPBIOS
 #include <linux/pnp_bios.h>
 #endif
 
@@ -2818,30 +2818,36 @@
 	return count;
 }
 
-#if defined (CONFIG_PNPBIOS) || defined (CONFIG_PNPBIOS_MODULE)
+#ifdef CONFIG_PNPBIOS
 
-#define UNSET(res)   ((res).flags & IORESOURCE_UNSET)
-
-int init_pnp040x(struct pci_dev *dev)
+/* formerly init_pnp040x() */
+static int __devinit parport_pc_pnpbios_probecb( struct pci_dev *dev, const struct pnpbios_device_id *id )
 {
+#define UNSET(res)   ((res).flags & IORESOURCE_UNSET)
 	int io,iohi,irq,dma;
+	char buffer[256], *bufw;
+
+	bufw = buffer;
 
-	printk(KERN_INFO
-		"parport: PnP BIOS reports device %s %s (node number 0x%x) is ",
+	bufw+=sprintf(bufw,
+		"parport: PnP BIOS reports device %s %s (node number 0x%x) is",
 		dev->name, dev->slot_name, dev->devfn
 	);
 
 	if ( UNSET(dev->resource[0]) ) {
-		printk("not configured.\n");
+		bufw+=sprintf(bufw, " not configured.");
+		printk(KERN_INFO "%s\n", buffer);
 		return 0;
 	}
-	io  = dev->resource[0].start;
-	printk("configured to use io 0x%04x",io);
+
+	io = dev->resource[0].start;
+	bufw+=sprintf(bufw," configured to use io 0x%04x",io);
+
 	if ( UNSET(dev->resource[1]) ) {
 		iohi = 0;
 	} else {
 		iohi = dev->resource[1].start;
-		printk(", io 0x%04x",iohi);
+		bufw+=sprintf(bufw,", io 0x%04x",iohi);
 	}
 
 	if ( UNSET(dev->irq_resource[0]) ) {
@@ -2849,10 +2855,10 @@
 	} else {
 		if ( dev->irq_resource[0].start == (unsigned long)-1 ) {
 			irq = PARPORT_IRQ_NONE;
-			printk(", irq disabled");
+			bufw+=sprintf(bufw,", irq disabled");
 		} else {
 			irq = dev->irq_resource[0].start;
-			printk(", irq %d",irq);
+			bufw+=sprintf(bufw,", irq %d",irq);
 		}
 	}
 
@@ -2861,23 +2867,38 @@
 	} else {
 		if ( dev->dma_resource[0].start == (unsigned long)-1 ) {
 			dma = PARPORT_DMA_NONE;
-			printk(", dma disabled");
+			bufw+=sprintf(bufw,", dma disabled");
 		} else {
 			dma = dev->dma_resource[0].start;
-			printk(", dma %d",dma);
+			bufw+=sprintf(bufw,", dma %d",dma);
 		}
 	}
-
-	printk("\n");
+	printk(KERN_INFO "%s.\n", buffer);
 
 	if (parport_pc_probe_port(io,iohi,irq,dma,NULL))
 		return 1;
 
 	return 0;
-}
 #undef UNSET
+}
+
+static struct pnpbios_device_id parport_pc_pnpbios_tbl[] __devinitdata = {
+	/*  id, driver_data */
+	{ "PNP0400",  },
+	{ "PNP0401",  },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(pnpbios, parport_pc_pnpbios_tbl);
 
-#endif 
+static struct pnpbios_driver parport_pc_pnpbios_drv = {
+	/* node: */
+	name:         "parport_pc",
+	id_table:     parport_pc_pnpbios_tbl,
+	probe:        parport_pc_pnpbios_probecb,
+	remove:       NULL
+};
+#endif
 
 /* This function is called by parport_pc_init if the user didn't
  * specify any ports to probe.  Its job is to find some ports.  Order
@@ -2892,19 +2913,14 @@
 static int __init parport_pc_find_ports (int autoirq, int autodma)
 {
 	int count = 0, r;
-	struct pci_dev *dev;
 
 #ifdef CONFIG_PARPORT_PC_SUPERIO
 	detect_and_report_winbond ();
 	detect_and_report_smsc ();
 #endif
 
-#if defined (CONFIG_PNPBIOS) || defined (CONFIG_PNPBIOS_MODULE)
-	dev=NULL;
-	while ((dev=pnpbios_find_device("PNP0400",dev)))
-		count+=init_pnp040x(dev);
-        while ((dev=pnpbios_find_device("PNP0401",dev)))
-                count+=init_pnp040x(dev);
+#ifdef CONFIG_PNPBIOS
+	count += pnpbios_register_driver(&parport_pc_pnpbios_drv);
 #endif
 
 	/* Onboard SuperIO chipsets that show themselves on the PCI bus. */
@@ -3015,6 +3031,10 @@
 
 	if (!user_specified)
 		pci_unregister_driver (&parport_pc_pci_driver);
+
+#ifdef CONFIG_PNPBIOS
+	pnpbios_unregister_driver(&parport_pc_pnpbios_drv);
+#endif
 
 	while (p) {
 		tmp = p->next;

