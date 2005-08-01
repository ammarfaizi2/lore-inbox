Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVHAO7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVHAO7N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 10:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVHAO7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 10:59:13 -0400
Received: from gw.alcove.fr ([81.80.245.157]:55732 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S262098AbVHAO7E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 10:59:04 -0400
Subject: Re: 2.6.13-rc3-mm3
From: Stelian Pop <stelian@popies.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Greg KH <greg@kroah.com>,
       Manuel Lauss <mano@roarinelk.homelinux.net>,
       Erik Waling <erikw@acc.umu.se>
In-Reply-To: <Pine.LNX.4.58.0507311557020.14342@g5.osdl.org>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	 <42EC9410.8080107@roarinelk.homelinux.net>
	 <Pine.LNX.4.58.0507311054320.29650@g5.osdl.org>
	 <Pine.LNX.4.58.0507311125360.29650@g5.osdl.org>
	 <1122846072.17880.43.camel@deep-space-9.dsnet>
	 <Pine.LNX.4.58.0507311557020.14342@g5.osdl.org>
Content-Type: text/plain; charset=utf-8
Date: Mon, 01 Aug 2005 16:37:47 +0200
Message-Id: <1122907067.31357.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry all for the duplicate, LKML slipped somehow from the CC: line so I'm sending this again]

Le dimanche 31 juillet 2005 à 16:22 -0700, Linus Torvalds a écrit :

> Also, it looks like sonypi really is pretty nasty to probe for, so it's 
> not enough to just say "oh, it's a sony VAIO, let's reserve that region". 
> Otherwise I'd just suggest adding a "dmi_check_system()" table to 
> arch/i386/pci/i386.c, at the top of "pcibios_assign_resources()", and 
> then you could just allocate things based on DMI information.

Since every Vaio laptop out there seems indeed to use only the first IO
port range in the list, we can de-nastyify the probe. And if we don't
even bother to check for Type1 vs. Type2 devices and we reserve both,
then it may be acceptable to do the above.

See the attached patch below which does just that. This has NOT been
tested (only compile-tested), and moreover it has a high breakage
probability in case some Vaios cannot live with the fixed ioport choice.

Note that this patch will conflict with the recent Eric's one (added in
CC:), he may want to rediff his Type3 changes in case this patch gets
in.

Stelian.


Mark some IO regions reserved on Sony Vaio laptops because the sonypi
driver will need them later, and we don't want another driver to reserve
them before the sonypi driver starts.
  
Signed-off-by: Stelian Pop <stelian@popies.net>

 arch/i386/pci/i386.c  |   42 +++++++++++++++++++++++++++++++++++
 drivers/char/sonypi.c |   60 ++++++++------------------------------------------
 2 files changed, 52 insertions(+), 50 deletions(-)

Index: linux-2.6.git/arch/i386/pci/i386.c
===================================================================
--- linux-2.6.git.orig/arch/i386/pci/i386.c	2005-07-08 14:08:10.000000000 +0200
+++ linux-2.6.git/arch/i386/pci/i386.c	2005-08-01 15:46:06.000000000 +0200
@@ -30,6 +30,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/errno.h>
+#include <linux/dmi.h>
 
 #include "pci.h"
 
@@ -167,12 +168,53 @@
 	}
 }
 
+/*
+ * Reserve IO ports used later by the sonypi driver, or they may got used
+ * by other devices.
+ */
+static int __init sonyvaio_reserve_ioports(struct dmi_system_id *d)
+{
+	/* IO ports for 'type1' device */
+	if (!request_region(0x10c0, 0x08, "Sony Programable I/O Type1 Device"))
+		printk(KERN_ERR "Sony Vaio: cannot reserve Type1 IO region\n");
+
+	/* IO ports for 'type2' device */
+	if (!request_region(0x1080, 0x20, "Sony Programable I/O Type2 Device"))
+		printk(KERN_ERR "Sony Vaio: cannot reserve Type2 IO region\n");
+
+	printk(KERN_INFO "Sony Vaio: pre-reserved IO ports\n");
+
+	return 0;
+}
+
+static struct dmi_system_id __initdata sonyvaioio_dmi_table[] = {
+	{
+		.callback = sonyvaio_reserve_ioports,
+		.ident = "Sony Vaio Laptop",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PCG-"),
+		},
+	},
+	{
+		.callback = sonyvaio_reserve_ioports,
+		.ident = "Sony Vaio Laptop",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-"),
+		},
+	},
+	{ }
+};
+
 static int __init pcibios_assign_resources(void)
 {
 	struct pci_dev *dev = NULL;
 	int idx;
 	struct resource *r;
 
+	dmi_check_system(sonyvaioio_dmi_table);
+
 	for_each_pci_dev(dev) {
 		int class = dev->class >> 8;
 
Index: linux-2.6.git/drivers/char/sonypi.c
===================================================================
--- linux-2.6.git.orig/drivers/char/sonypi.c	2005-08-01 11:06:47.000000000 +0200
+++ linux-2.6.git/drivers/char/sonypi.c	2005-08-01 15:45:27.000000000 +0200
@@ -104,14 +104,18 @@
 #define SONYPI_IRQ_SHIFT		22
 #define SONYPI_BASE			0x50
 #define SONYPI_G10A			(SONYPI_BASE+0x14)
-#define SONYPI_TYPE1_REGION_SIZE	0x08
+/* those ports are reserved in arch/i386/pci/i386.c */
+#define SONYPI_TYPE1_IOPORT1		0x10c0
+#define SONYPI_TYPE1_IOPORT2		0x10c4
 #define SONYPI_TYPE1_EVTYPE_OFFSET	0x04
 
 /* type2 series specifics */
 #define SONYPI_SIRQ			0x9b
 #define SONYPI_SLOB			0x9c
 #define SONYPI_SHIB			0x9d
-#define SONYPI_TYPE2_REGION_SIZE	0x20
+/* those ports are reserved in arch/i386/pci/i386.c */
+#define SONYPI_TYPE2_IOPORT1		0x1080
+#define SONYPI_TYPE2_IOPORT2		0x1084
 #define SONYPI_TYPE2_EVTYPE_OFFSET	0x12
 
 /* battery / brightness addresses */
@@ -136,29 +140,6 @@
 #define SONYPI_DATA_IOPORT	0x62
 #define SONYPI_CST_IOPORT	0x66
 
-/* The set of possible ioports */
-struct sonypi_ioport_list {
-	u16	port1;
-	u16	port2;
-};
-
-static struct sonypi_ioport_list sonypi_type1_ioport_list[] = {
-	{ 0x10c0, 0x10c4 },	/* looks like the default on C1Vx */
-	{ 0x1080, 0x1084 },
-	{ 0x1090, 0x1094 },
-	{ 0x10a0, 0x10a4 },
-	{ 0x10b0, 0x10b4 },
-	{ 0x0, 0x0 }
-};
-
-static struct sonypi_ioport_list sonypi_type2_ioport_list[] = {
-	{ 0x1080, 0x1084 },
-	{ 0x10a0, 0x10a4 },
-	{ 0x10c0, 0x10c4 },
-	{ 0x10e0, 0x10e4 },
-	{ 0x0, 0x0 }
-};
-
 /* The set of possible interrupts */
 struct sonypi_irq_list {
 	u16	irq;
@@ -451,7 +432,6 @@
 	u16 bits;
 	u16 ioport1;
 	u16 ioport2;
-	u16 region_size;
 	u16 evtype_offset;
 	int camera_power;
 	int bluetooth_power;
@@ -1139,7 +1119,6 @@
 static int __devinit sonypi_probe(void)
 {
 	int i, ret;
-	struct sonypi_ioport_list *ioport_list;
 	struct sonypi_irq_list *irq_list;
 	struct pci_dev *pcidev;
 
@@ -1177,33 +1156,17 @@
 	}
 
 	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2) {
-		ioport_list = sonypi_type2_ioport_list;
-		sonypi_device.region_size = SONYPI_TYPE2_REGION_SIZE;
+		sonypi_device.ioport1 = SONYPI_TYPE2_IOPORT1;
+		sonypi_device.ioport2 = SONYPI_TYPE2_IOPORT2;
 		sonypi_device.evtype_offset = SONYPI_TYPE2_EVTYPE_OFFSET;
 		irq_list = sonypi_type2_irq_list;
 	} else {
-		ioport_list = sonypi_type1_ioport_list;
-		sonypi_device.region_size = SONYPI_TYPE1_REGION_SIZE;
+		sonypi_device.ioport1 = SONYPI_TYPE1_IOPORT1;
+		sonypi_device.ioport2 = SONYPI_TYPE1_IOPORT2;
 		sonypi_device.evtype_offset = SONYPI_TYPE1_EVTYPE_OFFSET;
 		irq_list = sonypi_type1_irq_list;
 	}
 
-	for (i = 0; ioport_list[i].port1; i++) {
-		if (request_region(ioport_list[i].port1,
-				   sonypi_device.region_size,
-				   "Sony Programable I/O Device")) {
-			/* get the ioport */
-			sonypi_device.ioport1 = ioport_list[i].port1;
-			sonypi_device.ioport2 = ioport_list[i].port2;
-			break;
-		}
-	}
-	if (!sonypi_device.ioport1) {
-		printk(KERN_ERR "sonypi: request_region failed\n");
-		ret = -ENODEV;
-		goto out_reqreg;
-	}
-
 	for (i = 0; irq_list[i].irq; i++) {
 
 		sonypi_device.irq = irq_list[i].irq;
@@ -1303,8 +1266,6 @@
 	input_unregister_device(&sonypi_device.input_jog_dev);
 	free_irq(sonypi_device.irq, sonypi_irq);
 out_reqirq:
-	release_region(sonypi_device.ioport1, sonypi_device.region_size);
-out_reqreg:
 	misc_deregister(&sonypi_misc_device);
 out_miscreg:
 	if (pcidev)
@@ -1332,7 +1293,6 @@
 	}
 
 	free_irq(sonypi_device.irq, sonypi_irq);
-	release_region(sonypi_device.ioport1, sonypi_device.region_size);
 	misc_deregister(&sonypi_misc_device);
 	if (sonypi_device.dev)
 		pci_disable_device(sonypi_device.dev);

-- 
Stelian Pop <stelian@popies.net>

