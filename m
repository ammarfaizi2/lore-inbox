Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265806AbUATVSf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 16:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265807AbUATVSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 16:18:35 -0500
Received: from mail1.drkw.com ([62.129.121.35]:29905 "EHLO mail1.drkw.com")
	by vger.kernel.org with ESMTP id S265806AbUATVSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 16:18:20 -0500
From: "Heilmann, Oliver" <Oliver.Heilmann@drkw.com>
To: linux-kernel@vger.kernel.org
Cc: robert@vis.ethz.ch, davej@redhat.com
Subject: [PATCH] AGPGART preliminary SiS648 support
Content-Type: text/plain
Message-Id: <1074633491.533.26.camel@cobra>
Mime-Version: 1.0
Date: Tue, 20 Jan 2004 21:18:11 +0000
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: Oliver.Heilmann@drkw.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Preliminary 648FX agp support.

The delay problem described in 
http://www.ussg.iu.edu/hypermail/linux/kernel/0401.1/0053.html
still exists. Dave: any luck with that data sheet yet?

agp3 specifies things that had been left up to implementers in previous versions hence the new generic-agp3.c file.
Apart from the problem described above the 648 chipset seems to stick to the spec.
If this is also true for other chipset it might be possible to turn this into a generic agp3 driver at some point?

Obviously, users of the fglrx driver will want to turn off the internalagp option.

Oliver

diff -urN -X dontdiff linux-2.6.1/drivers/char/agp/Makefile linux/drivers/char/agp/Makefile
--- linux-2.6.1/drivers/char/agp/Makefile	2004-01-09 06:59:19.000000000 +0000
+++ linux/drivers/char/agp/Makefile	2004-01-16 14:36:40.000000000 +0000
@@ -1,4 +1,4 @@
-agpgart-y := backend.o frontend.o generic.o isoch.o
+agpgart-y := backend.o frontend.o generic.o generic-agp3.o isoch.o
 
 obj-$(CONFIG_AGP)		+= agpgart.o
 obj-$(CONFIG_AGP_ALI)		+= ali-agp.o
diff -urN -X dontdiff linux-2.6.1/drivers/char/agp/agp.h linux/drivers/char/agp/agp.h
--- linux-2.6.1/drivers/char/agp/agp.h	2004-01-09 06:59:26.000000000 +0000
+++ linux/drivers/char/agp/agp.h	2004-01-16 14:29:21.000000000 +0000
@@ -402,6 +402,17 @@
 void get_agp_version(struct agp_bridge_data *bridge);
 unsigned long agp_generic_mask_memory(unsigned long addr, int type);
 
+/* generic routines for agp>=3 */
+int agp3_generic_fetch_size(void);
+void agp3_generic_tlbflush(struct agp_memory *mem);
+int agp3_generic_configure(void);
+void agp3_generic_cleanup(void);
+
+/* aperture sizes have been standardised since v3 */
+#define AGP_GENERIC_SIZES_ENTRIES 11
+extern struct aper_size_info_16 agp3_generic_sizes[];
+
+
 extern int agp_off;
 extern int agp_try_unsupported_boot;
 
@@ -410,7 +421,10 @@
 #define AGPCMD			0x8
 #define AGPNISTAT		0xc
 #define AGPCTRL                 0x10
+#define AGPAPSIZE               0x14
 #define AGPNEPG			0x16
+#define AGPGARTLO               0x18
+#define AGPGARTHI               0x1c
 #define AGPNICMD		0x20
 
 #define AGP_MAJOR_VERSION_SHIFT	(20)
@@ -435,4 +449,8 @@
 #define AGPSTAT3_8X		(1<<1)
 #define AGPSTAT3_4X		(1)
 
+#define AGPCTRL_APERENB         (1<<8)
+#define AGPCTRL_GTLBEN          (1<<7)
+
+
 #endif				/* _AGP_BACKEND_PRIV_H */
diff -urN -X dontdiff linux-2.6.1/drivers/char/agp/generic-agp3.c linux/drivers/char/agp/generic-agp3.c
--- linux-2.6.1/drivers/char/agp/generic-agp3.c	1970-01-01 01:00:00.000000000 +0100
+++ linux/drivers/char/agp/generic-agp3.c	2004-01-18 13:58:51.000000000 +0000
@@ -0,0 +1,115 @@
+/*
+ * AGPGART driver.
+ * Copyright (C) 2002-2003 Dave Jones.
+ * Copyright (C) 1999 Jeff Hartmann.
+ * Copyright (C) 1999 Precision Insight, Inc.
+ * Copyright (C) 1999 Xi Graphics, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * JEFF HARTMANN, OR ANY OTHER CONTRIBUTORS BE LIABLE FOR ANY CLAIM, 
+ * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
+ * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
+ * OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+
+#include <linux/pci.h>
+#include <linux/agp_backend.h>
+#include "agp.h"
+
+/*
+ * These functions are implemented according to the agpV3 spec,
+ * which covers implementation details that had previously been
+ * left up to manufacturers.
+ */
+
+int agp3_generic_fetch_size(void)
+{
+	u16 temp_size;
+        int i;
+        struct aper_size_info_16 *values;
+ 
+	pci_read_config_word(agp_bridge->dev, agp_bridge->capndx+AGPAPSIZE, &temp_size);
+	values = A_SIZE_16(agp_bridge->driver->aperture_sizes);
+
+	for (i = 0; i < agp_bridge->driver->num_aperture_sizes; i++) {
+	     if (temp_size == values[i].size_value) {
+		 agp_bridge->previous_size =
+	       		agp_bridge->current_size = (void *) (values + i);
+
+	     	agp_bridge->aperture_size_idx = i;
+	     	return values[i].size;
+	     }
+	}
+	return 0;
+}
+EXPORT_SYMBOL(agp3_generic_fetch_size);
+
+void agp3_generic_tlbflush(struct agp_memory *mem)
+{
+	u32 ctrl;
+	pci_read_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPCTRL, &ctrl);
+	pci_write_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPCTRL, ctrl & ~AGPCTRL_GTLBEN);
+	pci_write_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPCTRL, ctrl);
+}
+EXPORT_SYMBOL(agp3_generic_tlbflush);
+
+int agp3_generic_configure(void)
+{
+	u32 temp;
+
+	struct aper_size_info_16 *current_size;
+	current_size = A_SIZE_16(agp_bridge->current_size);
+
+	pci_read_config_dword(agp_bridge->dev, AGP_APBASE, &temp);
+	agp_bridge->gart_bus_addr = (temp & PCI_BASE_ADDRESS_MEM_MASK);
+
+	// set aperture size
+	pci_write_config_word(agp_bridge->dev, agp_bridge->capndx+AGPAPSIZE, current_size->size_value);
+	// set gart pointer
+	pci_write_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPGARTLO, agp_bridge->gatt_bus_addr);
+
+	// enable aperture and GTLB
+	pci_read_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPCTRL, &temp);
+	pci_write_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPCTRL, temp | AGPCTRL_APERENB | AGPCTRL_GTLBEN);
+
+	return 0;
+}
+EXPORT_SYMBOL(agp3_generic_configure);
+
+void agp3_generic_cleanup(void)
+{
+	u32 ctrl;
+	pci_read_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPCTRL, &ctrl);
+	pci_write_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPCTRL, ctrl & ~AGPCTRL_APERENB);
+}
+EXPORT_SYMBOL(agp3_generic_cleanup);
+
+struct aper_size_info_16 agp3_generic_sizes[AGP_GENERIC_SIZES_ENTRIES]=
+{
+        {4096, 1048576, 10,0x000},
+        {2048,  524288, 9, 0x800},
+        {1024,  262144, 8, 0xc00},
+        { 512,  131072, 7, 0xe00},
+	{ 256,   65536, 6, 0xf00},
+	{ 128,   32768, 5, 0xf20},
+	{  64,   16384, 4, 0xf30},
+	{  32,    8192, 3, 0xf38},
+	{  16,    4096, 2, 0xf3c},
+	{   8,    2048, 1, 0xf3e},
+	{   4,    1024, 0, 0xf3f}
+};
+EXPORT_SYMBOL(agp3_generic_sizes);
diff -urN -X dontdiff linux-2.6.1/drivers/char/agp/sis-agp.c linux/drivers/char/agp/sis-agp.c
--- linux-2.6.1/drivers/char/agp/sis-agp.c	2004-01-09 06:59:06.000000000 +0000
+++ linux/drivers/char/agp/sis-agp.c	2004-01-20 20:25:35.000000000 +0000
@@ -21,7 +21,7 @@
 		    ((temp_size & ~(0x03)) ==
 		     (values[i].size_value & ~(0x03)))) {
 			agp_bridge->previous_size =
-			    agp_bridge->current_size = (void *) (values + i);
+				agp_bridge->current_size = (void *) (values + i);
 
 			agp_bridge->aperture_size_idx = i;
 			return values[i].size;
@@ -61,7 +61,67 @@
 			      (previous_size->size_value & ~(0x03)));
 }
 
-static struct aper_size_info_8 sis_generic_sizes[7] =
+static void sis648_enable(u32 mode)
+{
+	// find the master, this needs to be better
+	struct pci_dev *master = NULL;
+	u8 mcapndx=0;
+
+	while ((master = pci_find_class(PCI_CLASS_DISPLAY_VGA<<8, master)) != NULL) {
+	  mcapndx = pci_find_capability(master, PCI_CAP_ID_AGP);
+	  printk (KERN_INFO PFX "Found AGP device. %x:%x \n", master->vendor, master->device);
+	  break;
+	}
+	if(!mcapndx)
+		return;
+
+	u32 tStatus;
+	u32 mStatus;
+	pci_read_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPSTAT, &tStatus);
+	pci_read_config_dword(master, mcapndx+AGPSTAT, &mStatus);
+	
+	printk(KERN_INFO PFX "target status %x\n", tStatus);
+	printk(KERN_INFO PFX "master status %x\n", mStatus);
+
+	int tcc=(tStatus>>10)&3;
+	int mcc=(mStatus>>10)&3;
+	int calcycl=(tcc<mcc) ? tcc : mcc;
+	int sba=(tStatus & AGPSTAT_SBA) && (mStatus & AGPSTAT_SBA);
+	int agp_enable=1;
+	int gart64b=0;
+	int over4g=0;
+	int fw=(tStatus & AGPSTAT_FW) && (mStatus & AGPSTAT_FW);
+	int rate=(tStatus & 2) && (tStatus & 2) ? 2 : 1;
+
+	// init target (bridge)
+	u32 tcmd=(calcycl<<10)|(sba<<9)|(agp_enable<<8)|(gart64b<<7)|(over4g<<5)|(fw<<4)|rate;
+	printk(KERN_INFO PFX "tcmd=%x\n",tcmd);
+	pci_write_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPCMD, tcmd);
+
+	u8 mcaptest = pci_find_capability(master, PCI_CAP_ID_AGP);
+	if(mcaptest!=mcapndx)
+	{
+	  printk(KERN_INFO PFX "master capndx screwed ... waiting 10ms\n");
+	  // weird: on 648fx chipsets any rate change in the target command register
+	  // triggers a 5ms screwup during which the master cannot be configured
+	  set_current_state(TASK_INTERRUPTIBLE);
+	  schedule_timeout (1+(HZ*10)/1000);  
+	}
+	else
+	{
+	  printk(KERN_INFO PFX "bridge is up and master seems okay");
+	}
+
+	// init master (card)
+	int prq=(mStatus>>24)&0xff;
+	int parqsz=(tStatus>>AGPSTAT_ARQSZ_SHIFT) & 3;
+	u32 mcmd=(prq<<24)|(parqsz<<13)|(sba<<9)|(agp_enable<<8)|(over4g<<5)|(fw<<4)|rate;
+	printk(KERN_INFO PFX "mcmd=%x\n",mcmd);
+
+	pci_write_config_dword(master, mcapndx+AGPCMD, mcmd);
+}
+
+static struct aper_size_info_8 sis_generic_sizes[] =
 {
 	{256, 65536, 6, 99},
 	{128, 32768, 5, 83},
@@ -95,6 +155,29 @@
 	.agp_destroy_page	= agp_generic_destroy_page,
 };
 
+struct agp_bridge_driver sis648_driver = {
+	.owner			= THIS_MODULE,
+	.aperture_sizes 	= agp3_generic_sizes,
+	.size_type		= U16_APER_SIZE,
+	.num_aperture_sizes	= AGP_GENERIC_SIZES_ENTRIES,
+	.configure		= agp3_generic_configure,
+	.fetch_size		= agp3_generic_fetch_size,
+	.cleanup		= agp3_generic_cleanup,
+	.tlb_flush		= agp3_generic_tlbflush,
+	.mask_memory		= agp_generic_mask_memory,
+	.masks			= NULL,
+	.agp_enable		= sis648_enable,
+	.cache_flush		= global_cache_flush,
+	.create_gatt_table	= agp_generic_create_gatt_table,
+	.free_gatt_table	= agp_generic_free_gatt_table,
+	.insert_memory		= agp_generic_insert_memory,
+	.remove_memory		= agp_generic_remove_memory,
+	.alloc_by_type		= agp_generic_alloc_by_type,
+	.free_by_type		= agp_generic_free_by_type,
+	.agp_alloc_page		= agp_generic_alloc_page,
+	.agp_destroy_page	= agp_generic_destroy_page
+};
+
 static struct agp_device_ids sis_agp_device_ids[] __devinitdata =
 {
 	{
@@ -192,13 +275,13 @@
 	for (j = 0; devs[j].chipset_name; j++) {
 		if (pdev->device == devs[j].device_id) {
 			printk(KERN_INFO PFX "Detected SiS %s chipset\n",
-					devs[j].chipset_name);
+			       devs[j].chipset_name);
 			goto found;
 		}
 	}
 
 	printk(KERN_ERR PFX "Unsupported SiS chipset (device id: %04x)\n",
-		    pdev->device);
+	       pdev->device);
 	return -ENODEV;
 
 found:
@@ -206,14 +289,17 @@
 	if (!bridge)
 		return -ENOMEM;
 
-	bridge->driver = &sis_driver;
+	if(pdev->device==PCI_DEVICE_ID_SI_648)
+		bridge->driver = &sis648_driver;
+	else
+		bridge->driver = &sis_driver;
 	bridge->dev = pdev;
 	bridge->capndx = cap_ptr;
 
 	/* Fill in the mode register */
 	pci_read_config_dword(pdev,
-			bridge->capndx+PCI_AGP_STATUS,
-			&bridge->mode);
+			      bridge->capndx+PCI_AGP_STATUS,
+			      &bridge->mode);
 
 	pci_set_drvdata(pdev, bridge);
 	return agp_add_bridge(bridge);
@@ -229,12 +315,12 @@
 
 static struct pci_device_id agp_sis_pci_table[] = {
 	{
-	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
-	.class_mask	= ~0,
-	.vendor		= PCI_VENDOR_ID_SI,
-	.device		= PCI_ANY_ID,
-	.subvendor	= PCI_ANY_ID,
-	.subdevice	= PCI_ANY_ID,
+		.class		= (PCI_CLASS_BRIDGE_HOST << 8),
+		.class_mask	= ~0,
+		.vendor		= PCI_VENDOR_ID_SI,
+		.device		= PCI_ANY_ID,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
 	},
 	{ }
 };



--------------------------------------------------------------------------------
The information contained herein is confidential and is intended solely for the
addressee. Access by any other party is unauthorised without the express
written permission of the sender. If you are not the intended recipient, please
contact the sender either via the company switchboard on +44 (0)20 7623 8000, or
via e-mail return. If you have received this e-mail in error or wish to read our
e-mail disclaimer statement and monitoring policy, please refer to 
http://www.drkw.com/disc/email/ or contact the sender.
--------------------------------------------------------------------------------

