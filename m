Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265434AbUBAVGv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265435AbUBAVGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:06:50 -0500
Received: from nycsmtp4out-eri0.rdc-nyc.rr.com ([24.29.99.227]:2756 "EHLO
	nycsmtp4out-eri0.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S265434AbUBAVFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:05:24 -0500
Date: Sun, 01 Feb 2004 16:05:16 -0500
From: Huw Rogers <count0@localnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: APM good, ACPI bad (2.6.2-rc1 / p4 HT / Uniwill N258SA0)
Cc: <ncunningham@users.sourceforge.net>, <pavel@ucw.cz>,
       <linux-laptop@mobilix.org>, <acpi-devel@lists.sourceforge.net>
In-Reply-To: <37778.199.172.169.20.1075236597.squirrel@webmail.localnet.com>
References: <1075231649.18386.34.camel@laptop-linux> <37778.199.172.169.20.1075236597.squirrel@webmail.localnet.com>
Message-Id: <20040201151411.3A7B.COUNT0@localnet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.04 [en]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got Uniwill N258SA0 laptop suspend/resume working (2.6.2-rc1-mm3) with
APM. Patch enclosed. CPU is desktop P4 with hyperthreading.

Recompiled 2.6.2-rc1-mm3 without ACPI, with APM. Booting with
noirqbalance acpi=ht apm=smp.

apm --suspend works perfectly, including from within fglrx accelerated X
(albeit with occasional minor screen corruption requiring a X refresh on
suspend, easily scripted).

I needed this patch on top of -mm3 (incorporates Oliver's SiS AGP patch
from http://lkml.org/lkml/2004/1/20/233). This fixes the SiS 648FX AGP
driver. I #if 0'd a prohibition on suspend with SMP. I also added
suspend/resume handlers for the SiS 648FX (suspend does nothing, resume
reconfigures).

My earlier report of bad ACPI experience:

> S1 - suspends, does not fully resume (USB devices get re-initted,
>      then hangs). needs power cycle to get back
> S3 - suspends if acpi_os_name="Microsoft Windows NT", but resume
>      disables the display so thoroughly I have to unplug AC and remove
>      battery before power cycling to get it back!
> S4 (pmdisk) - suspends and immediately resumes with spurious wake up
> S4b - ('') - ditto

There's some kind of deep problem with S3 resume and ACPI - "Back to C!"
never even gets output, i.e. wakeup.S has some kind of problem, but it's
difficult to debug.

pmdisk (echo -n "disk" >/sys/power/state) has the same behavior under
APM as reported above under ACPI, i.e. immediate resume. Not sure if
it's supposed to work other than under ACPI anyway...

Patch:

-------- cut here --------
diff -Nru a/drivers/char/agp/agp.h b/drivers/char/agp/agp.h
--- a/drivers/char/agp/agp.h	2004-01-09 01:59:26.000000000 -0500
+++ b/drivers/char/agp/agp.h	2004-01-25 19:42:18.000000000 -0500
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
diff -Nru a/drivers/char/agp/generic-agp3.c b/drivers/char/agp/generic-agp3.c
--- a/drivers/char/agp/generic-agp3.c	1969-12-31 19:00:00.000000000 -0500
+++ b/drivers/char/agp/generic-agp3.c	2004-01-25 19:42:18.000000000 -0500
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
diff -Nru a/drivers/char/agp/Makefile b/drivers/char/agp/Makefile
--- a/drivers/char/agp/Makefile	2004-01-09 01:59:19.000000000 -0500
+++ b/drivers/char/agp/Makefile	2004-01-25 19:42:18.000000000 -0500
@@ -1,4 +1,4 @@
-agpgart-y := backend.o frontend.o generic.o isoch.o
+agpgart-y := backend.o frontend.o generic.o generic-agp3.o isoch.o
 
 obj-$(CONFIG_AGP)		+= agpgart.o
 obj-$(CONFIG_AGP_ALI)		+= ali-agp.o
diff -Nru a/drivers/char/agp/sis-agp.c b/drivers/char/agp/sis-agp.c
--- a/drivers/char/agp/sis-agp.c	2004-01-09 01:59:06.000000000 -0500
+++ b/drivers/char/agp/sis-agp.c	2004-02-01 13:06:09.000000000 -0500
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
@@ -227,14 +313,31 @@
 	agp_put_bridge(bridge);
 }
 
+static int agp_sis_suspend(struct pci_dev *dev, u32 state)
+{
+	return 0;
+}
+
+static int agp_sis_resume(struct pci_dev *pdev)
+{
+	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
+
+	printk(KERN_INFO PFX "agp_sis_resume()\n");
+
+	if (bridge->driver == &sis648_driver)
+		agp3_generic_configure();
+
+	return 0;
+}
+
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
@@ -246,6 +349,8 @@
 	.id_table	= agp_sis_pci_table,
 	.probe		= agp_sis_probe,
 	.remove		= agp_sis_remove,
+	.suspend	= agp_sis_suspend,
+	.resume		= agp_sis_resume
 };
 
 static int __init agp_sis_init(void)
diff -Nru a/kernel/power/main.c b/kernel/power/main.c
--- a/kernel/power/main.c	2004-01-09 01:59:19.000000000 -0500
+++ b/kernel/power/main.c	2004-01-25 19:59:35.000000000 -0500
@@ -144,11 +144,13 @@
 	if (down_trylock(&pm_sem))
 		return -EBUSY;
 
+#if 0
 	/* Suspend is hard to get right on SMP. */
 	if (num_online_cpus() != 1) {
 		error = -EPERM;
 		goto Unlock;
 	}
+#endif
 
 	if (state == PM_SUSPEND_DISK) {
 		error = pm_suspend_disk();
-------- cut here --------

-- 
Huw Rogers <count0@localnet.com>

