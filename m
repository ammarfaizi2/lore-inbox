Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280502AbRKJFhA>; Sat, 10 Nov 2001 00:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280508AbRKJFgu>; Sat, 10 Nov 2001 00:36:50 -0500
Received: from hermes.toad.net ([162.33.130.251]:48059 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S280502AbRKJFg3>;
	Sat, 10 Nov 2001 00:36:29 -0500
Subject: [PATCH] parport_pc to use pnpbios_register_driver()
To: linux-kernel@vger.kernel.org
Date: Sat, 10 Nov 2001 00:36:33 -0500 (EST)
Cc: jdthood@mail.com
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20011110053633.D7D8AB70@thanatos.toad.net>
From: jdthood@home.dhs.org (Thomas Hood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch to make parport_pc.c use pnpbios_register_driver()
instead of pnpbios_find_device.


--- linux-2.4.13-ac8_ORIG/drivers/parport/parport_pc.c	Fri Oct 26 18:13:48 2001
+++ linux-2.4.13-ac8/drivers/parport/parport_pc.c	Fri Nov  9 23:42:11 2001
@@ -2822,7 +2822,7 @@
 
 #define UNSET(res)   ((res).flags & IORESOURCE_UNSET)
 
-int init_pnp040x(struct pci_dev *dev)
+int init_PNP040x(struct pci_dev *dev)
 {
 	int io,iohi,irq,dma;
 
@@ -2879,6 +2879,28 @@
 
 #endif 
 
+#if defined (CONFIG_PNPBIOS) || defined (CONFIG_PNPBIOS_MODULE)
+static int pnpbios_probe_cb( struct pci_dev *dev, const struct pnpbios_device_id *id )
+{
+                return init_PNP040x(dev);
+}
+
+static struct pnpbios_device_id pnpdevs[] = {
+	/*  id, driver_data */
+	{ "PNP0400", 0L },
+	{ "PNP0401", 0L },
+	{ }
+};
+
+static struct pnpbios_driver pnpdrv = {
+	/* node     */ { },
+	/* name     */ "parport_pc",
+	/* id_table */ pnpdevs,
+	/* probe    */ pnpbios_probe_cb,
+	/* remove   */ NULL
+};
+#endif
+
 /* This function is called by parport_pc_init if the user didn't
  * specify any ports to probe.  Its job is to find some ports.  Order
  * is important here -- we want ISA ports to be registered first,
@@ -2892,7 +2914,6 @@
 static int __init parport_pc_find_ports (int autoirq, int autodma)
 {
 	int count = 0, r;
-	struct pci_dev *dev;
 
 #ifdef CONFIG_PARPORT_PC_SUPERIO
 	detect_and_report_winbond ();
@@ -2900,11 +2921,7 @@
 #endif
 
 #if defined (CONFIG_PNPBIOS) || defined (CONFIG_PNPBIOS_MODULE)
-	dev=NULL;
-	while ((dev=pnpbios_find_device("PNP0400",dev)))
-		count+=init_pnp040x(dev);
-        while ((dev=pnpbios_find_device("PNP0401",dev)))
-                count+=init_pnp040x(dev);
+	count += pnpbios_register_driver(&pnpdrv);
 #endif
 
 	/* Onboard SuperIO chipsets that show themselves on the PCI bus. */
@@ -3015,6 +3032,10 @@
 
 	if (!user_specified)
 		pci_unregister_driver (&parport_pc_pci_driver);
+
+#if defined (CONFIG_PNPBIOS) || defined (CONFIG_PNPBIOS_MODULE)
+	pnpbios_unregister_driver(&pnpdrv);
+#endif
 
 	while (p) {
 		tmp = p->next;
