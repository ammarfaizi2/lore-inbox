Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279903AbRKNAwk>; Tue, 13 Nov 2001 19:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279912AbRKNAwa>; Tue, 13 Nov 2001 19:52:30 -0500
Received: from sushi.toad.net ([162.33.130.105]:407 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S279903AbRKNAwN>;
	Tue, 13 Nov 2001 19:52:13 -0500
Subject: [PATCH] parport_pc to use pnpbios_register_driver() #3
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 13 Nov 2001 19:52:27 -0500
Message-Id: <1005699149.25202.20.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an again-improved version of the patch.  Variable and
function names are better considered.  Some '__devinit's have
been added.

It was suggested to me that I not explicitly initialize
any members of structs that are initialized to zero or NULL.
I know that space is saved in the kernel image when zero-
initializers are omitted from definitions, but is this also
true when one omits the initializer of only one element of
a struct?

It was suggested that the compilation condition not be
   #if defined (CONFIG_PNPBIOS) || defined (CONFIG_PNPBIOS_MODULE)
but
   #if defined (CONFIG_PNPBIOS) || (defined (CONFIG_PNPBIOS_MODULE)
   && defined (MODULE)
However, it is my understanding that this is not necessary because
the parport_pc driver will be compiled integrally with pnpbios
support only if the pnpbios driver is also compiled integrally.
(Contrapositively, if pnpbios is a module then so is parport_pc.)
Thus CONFIG_PNPBIOS_MODULE will never be defined here without
MODULE being defined.  Is this right?

I haven't looked at Russell King's serial driver code yet.

The patch:
--- linux-2.4.13-ac8_ORIG/drivers/parport/parport_pc.c	Fri Oct 26 18:13:48 2001
+++ linux-2.4.13-ac8/drivers/parport/parport_pc.c	Tue Nov 13 19:24:10 2001
@@ -2822,7 +2822,7 @@
 
 #define UNSET(res)   ((res).flags & IORESOURCE_UNSET)
 
-int init_pnp040x(struct pci_dev *dev)
+static int __devinit init_PNP040x(struct pci_dev *dev)
 {
 	int io,iohi,irq,dma;
 
@@ -2879,6 +2879,30 @@
 
 #endif 
 
+#if defined (CONFIG_PNPBIOS) || defined (CONFIG_PNPBIOS_MODULE)
+static int __devinit parport_pc_pnpbios_probecb( struct pci_dev *dev, const struct pnpbios_device_id *id )
+{
+                return init_PNP040x(dev) ? 1 : 0;
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
+
+static struct pnpbios_driver parport_pc_pnpbios_drv = {
+	/* node: */
+	name:         "parport_pc",
+	id_table:     parport_pc_pnpbios_tbl,
+	probe:        parport_pc_pnpbios_probecb,
+	remove:       NULL
+};
+#endif
+
 /* This function is called by parport_pc_init if the user didn't
  * specify any ports to probe.  Its job is to find some ports.  Order
  * is important here -- we want ISA ports to be registered first,
@@ -2892,7 +2916,6 @@
 static int __init parport_pc_find_ports (int autoirq, int autodma)
 {
 	int count = 0, r;
-	struct pci_dev *dev;
 
 #ifdef CONFIG_PARPORT_PC_SUPERIO
 	detect_and_report_winbond ();
@@ -2900,11 +2923,7 @@
 #endif
 
 #if defined (CONFIG_PNPBIOS) || defined (CONFIG_PNPBIOS_MODULE)
-	dev=NULL;
-	while ((dev=pnpbios_find_device("PNP0400",dev)))
-		count+=init_pnp040x(dev);
-        while ((dev=pnpbios_find_device("PNP0401",dev)))
-                count+=init_pnp040x(dev);
+	count += pnpbios_register_driver(&parport_pc_pnpbios_drv);
 #endif
 
 	/* Onboard SuperIO chipsets that show themselves on the PCI bus. */
@@ -3015,6 +3034,10 @@
 
 	if (!user_specified)
 		pci_unregister_driver (&parport_pc_pci_driver);
+
+#if defined (CONFIG_PNPBIOS) || defined (CONFIG_PNPBIOS_MODULE)
+	pnpbios_unregister_driver(&parport_pc_pnpbios_drv);
+#endif
 
 	while (p) {
 		tmp = p->next;

