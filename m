Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbTDGBke (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 21:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbTDGBke (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 21:40:34 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:38284 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263191AbTDGBkS (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 21:40:18 -0400
Date: Mon, 7 Apr 2003 02:51:39 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Proposed AGPGART changes for 2.5.67
Message-ID: <20030407015007.GA14445@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks, the diff below consolodates a lot of the AGP3.0 code together
such that subdrivers now have a single 'enable' function (the aptly
named 'agp_generic_enable') as opposed to special agp_3_0_enable
functions when in 3.0 mode.

There are a few other bits pending, but I'd appreciate feedback
from users of this code (on any version of AGP, not just 3.0).

The node enable stuff was completely broken previously for all
garts except for the Intel E7x05's, which does funky stuff with
their PCI bus configuration. unfortunatly, it was silent failure,
so this went unnoticed for a while. (Bonus screwup points for
making the only 'working' GART non-compilable -- mea culpa)

Diff is against 2.5.66+bk12, but should apply to 2.5.66 vanilla too.

		Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/Kconfig agpgart/drivers/char/agp/Kconfig
--- bk-linus/drivers/char/agp/Kconfig	2003-04-07 01:41:40.000000000 +0100
+++ agpgart/drivers/char/agp/Kconfig	2003-04-06 13:58:14.000000000 +0100
@@ -141,7 +141,7 @@ config AGP_ALPHA_CORE
 
 # Put AGP 3.0 entries below here.
 
-config AGP_I7505
+config AGP_I7x05
 	tristate "Intel 7205/7505 support (AGP 3.0)"
 	depends on AGP3
 	help
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/agp.h agpgart/drivers/char/agp/agp.h
--- bk-linus/drivers/char/agp/agp.h	2003-03-06 17:16:06.000000000 +0000
+++ agpgart/drivers/char/agp/agp.h	2003-04-06 20:59:42.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  * AGPGART
- * Copyright (C) 2002 Dave Jones
+ * Copyright (C) 2002-2003 Dave Jones
  * Copyright (C) 1999 Jeff Hartmann
  * Copyright (C) 1999 Precision Insight, Inc.
  * Copyright (C) 1999 Xi Graphics, Inc.
@@ -46,7 +46,7 @@ static void __attribute__((unused)) glob
 		panic(PFX "timed out waiting for the other CPUs!\n");
 }
 #else
-static inline void global_cache_flush(void)
+static void global_cache_flush(void)
 {
 	flush_agp_cache();
 }
@@ -380,8 +380,7 @@ struct agp_driver {
 
 
 /* Generic routines. */
-void agp_generic_agp_enable(u32 mode);
-void agp_generic_agp_3_0_enable(u32 mode);
+void agp_generic_enable(u32 mode);
 int agp_generic_create_gatt_table(void);
 int agp_generic_free_gatt_table(void);
 agp_memory *agp_create_memory(int scratch_pages);
@@ -399,5 +398,6 @@ int agp_register_driver (struct agp_driv
 int agp_unregister_driver(struct agp_driver *drv);
 u32 agp_collect_device_status(u32 mode, u32 command);
 void agp_device_command(u32 command, int agp_v3);
+int agp_3_0_node_enable(u32 mode, u32 minor);
 
 #endif				/* _AGP_BACKEND_PRIV_H */
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/ali-agp.c agpgart/drivers/char/agp/ali-agp.c
--- bk-linus/drivers/char/agp/ali-agp.c	2003-04-07 01:41:40.000000000 +0100
+++ agpgart/drivers/char/agp/ali-agp.c	2003-04-07 01:39:29.000000000 +0100
@@ -208,7 +208,7 @@ static int __init ali_generic_setup (str
 	agp_bridge->cleanup = ali_cleanup;
 	agp_bridge->tlb_flush = ali_tlbflush;
 	agp_bridge->mask_memory = ali_mask_memory;
-	agp_bridge->agp_enable = agp_generic_agp_enable;
+	agp_bridge->agp_enable = agp_generic_enable;
 	agp_bridge->cache_flush = ali_cache_flush;
 	agp_bridge->create_gatt_table = agp_generic_create_gatt_table;
 	agp_bridge->free_gatt_table = agp_generic_free_gatt_table;
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/amd-k7-agp.c agpgart/drivers/char/agp/amd-k7-agp.c
--- bk-linus/drivers/char/agp/amd-k7-agp.c	2003-04-07 01:41:40.000000000 +0100
+++ agpgart/drivers/char/agp/amd-k7-agp.c	2003-04-07 01:39:29.000000000 +0100
@@ -368,7 +368,7 @@ static int __init amd_irongate_setup (st
 	agp_bridge->cleanup = amd_irongate_cleanup;
 	agp_bridge->tlb_flush = amd_irongate_tlbflush;
 	agp_bridge->mask_memory = amd_irongate_mask_memory;
-	agp_bridge->agp_enable = agp_generic_agp_enable;
+	agp_bridge->agp_enable = agp_generic_enable;
 	agp_bridge->cache_flush = global_cache_flush;
 	agp_bridge->create_gatt_table = amd_create_gatt_table;
 	agp_bridge->free_gatt_table = amd_free_gatt_table;
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/amd-k8-agp.c agpgart/drivers/char/agp/amd-k8-agp.c
--- bk-linus/drivers/char/agp/amd-k8-agp.c	2003-02-16 15:53:41.000000000 +0000
+++ agpgart/drivers/char/agp/amd-k8-agp.c	2003-04-01 16:43:18.000000000 +0100
@@ -1,5 +1,5 @@
 /* 
- * Copyright 2001,2002 SuSE Labs
+ * Copyright 2001-2003 SuSE Labs
  * Distributed under the GNU public license, v2.
  * 
  * This is a GART driver for the AMD K8 northbridge and the AMD 8151 
@@ -265,7 +265,7 @@ static void agp_x86_64_agp_enable(u32 mo
 	/* If not enough, go to AGP v2 setup */
 	if (v3_devs<2) {
 		printk (KERN_INFO "AGP: Only %d devices found, not enough, trying AGPv2\n", v3_devs);
-		return agp_generic_agp_enable(mode);
+		return agp_generic_enable(mode);
 	} else {
 		printk (KERN_INFO "AGP: Enough AGPv3 devices found, setting up...\n");
 	}
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/backend.c agpgart/drivers/char/agp/backend.c
--- bk-linus/drivers/char/agp/backend.c	2003-02-11 01:08:59.000000000 +0000
+++ agpgart/drivers/char/agp/backend.c	2003-04-07 01:39:29.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  * AGPGART driver backend routines.
- * Copyright (C) 2002 Dave Jones.
+ * Copyright (C) 2002-2003 Dave Jones.
  * Copyright (C) 1999 Jeff Hartmann.
  * Copyright (C) 1999 Precision Insight, Inc.
  * Copyright (C) 1999 Xi Graphics, Inc.
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/frontend.c agpgart/drivers/char/agp/frontend.c
--- bk-linus/drivers/char/agp/frontend.c	2003-04-07 01:41:40.000000000 +0100
+++ agpgart/drivers/char/agp/frontend.c	2003-04-02 17:48:23.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  * AGPGART driver frontend
- * Copyright (C) 2002 Dave Jones
+ * Copyright (C) 2002-2003 Dave Jones
  * Copyright (C) 1999 Jeff Hartmann
  * Copyright (C) 1999 Precision Insight, Inc.
  * Copyright (C) 1999 Xi Graphics, Inc.
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/generic-3.0.c agpgart/drivers/char/agp/generic-3.0.c
--- bk-linus/drivers/char/agp/generic-3.0.c	2003-04-03 12:22:06.000000000 +0100
+++ agpgart/drivers/char/agp/generic-3.0.c	2003-04-07 01:39:29.000000000 +0100
@@ -319,10 +319,10 @@ static int agp_3_0_nonisochronous_node_e
  * Fully configure and enable an AGP 3.0 host bridge and all the devices
  * lying behind it.
  */
-static int agp_3_0_node_enable(u32 mode, u32 minor)
+int agp_3_0_node_enable(u32 mode, u32 minor)
 {
 	struct pci_dev *td = agp_bridge->dev, *dev;
-	u8 bus_num, mcapndx;
+	u8 mcapndx;
 	u32 isoch, arqsz, cal_cycle, tmp, rate;
 	u32 tstatus, tcmd, mcmd, mstatus, ncapid;
 	u32 mmajor, mminor;
@@ -343,23 +343,30 @@ static int agp_3_0_node_enable(u32 mode,
 	head = &dev_list->list;
 	INIT_LIST_HEAD(head);
 
-	/* 
-	 * Find all the devices on this bridge's secondary bus and add them
-	 * to dev_list. 
-	 */
-	pci_read_config_byte(td, PCI_SECONDARY_BUS, &bus_num);
-	pci_for_each_dev(dev) {
-		if(dev->bus->number == bus_num) {
-			if((cur = kmalloc(sizeof(*cur), GFP_KERNEL)) == NULL) {
-				ret = -ENOMEM;
-				goto free_and_exit;
-			}
-			
-			cur->dev = dev;
+	/* Find all AGP devices, and add them to dev_list. */
+	pci_for_each_dev(dev) { 
+		switch ((dev->class >>8) & 0xff00) {
+			case 0x0001:    /* Unclassified device */
+			case 0x0300:    /* Display controller */
+			case 0x0400:    /* Multimedia controller */
+			case 0x0600:    /* Bridge */
+				mcapndx = pci_find_capability(dev, PCI_CAP_ID_AGP);
+				if (mcapndx == 0)
+					continue;
+
+				if((cur = kmalloc(sizeof(*cur), GFP_KERNEL)) == NULL) {
+					ret = -ENOMEM;
+					goto free_and_exit;
+				}
+				cur->dev = dev;
+
+				pos = &cur->list;
+				list_add(pos, head);
+				ndevs++;
+				continue;
 
-			pos = &cur->list;
-			list_add(pos, head);
-			ndevs++;
+			default:
+				continue;
 		}
 	}
 
@@ -518,33 +525,5 @@ get_out:
 	return ret;
 }
 
-/* 
- * Entry point to AGP 3.0 host bridge init.  Check to see if we 
- * have an AGP 3.0 device operating in 3.0 mode.  Call 
- * agp_3_0_node_enable or agp_generic_agp_enable if we don't 
- * (AGP 3.0 devices are required to operate as AGP 2.0 devices 
- * when not using 3.0 electricals.
- */
-void agp_generic_agp_3_0_enable(u32 mode)
-{
-	u32 ncapid, major, minor, agp_3_0;
-
-	pci_read_config_dword(agp_bridge->dev, agp_bridge->capndx, &ncapid);
-
-	major = (ncapid >> 20) & 0xf;
-	minor = (ncapid >> 16) & 0xf;
-
-	printk(KERN_INFO PFX "Found an AGP %d.%d compliant device.\n",major, minor);
-
-	if(major >= 3) {
-		pci_read_config_dword(agp_bridge->dev, agp_bridge->capndx + 0x4, &agp_3_0);
-		/* 
-		 * Check to see if we are operating in 3.0 mode 
-		 */
-		if((agp_3_0 >> 3) & 0x1)
-			agp_3_0_node_enable(mode, minor);
-	}
-}
-
-EXPORT_SYMBOL(agp_generic_agp_3_0_enable);
+EXPORT_SYMBOL_GPL(agp_3_0_node_enable);
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/generic.c agpgart/drivers/char/agp/generic.c
--- bk-linus/drivers/char/agp/generic.c	2003-04-07 01:41:40.000000000 +0100
+++ agpgart/drivers/char/agp/generic.c	2003-04-06 21:00:39.000000000 +0100
@@ -392,21 +392,39 @@ void agp_device_command(u32 command, int
 	}
 }
 
-void agp_generic_agp_enable(u32 mode)
+void agp_generic_enable(u32 mode)
 {
-	u32 command;
+	u32 command, ncapid, major, minor;
 
+	pci_read_config_dword(agp_bridge->dev, agp_bridge->capndx, &ncapid);
+	major = (ncapid >> 20) & 0xf;
+	minor = (ncapid >> 16) & 0xf;
+	printk(KERN_INFO PFX "Found an AGP %d.%d compliant device.\n",major, minor);
+
+#ifdef CONFIG_AGP3
+	if(major >= 3) {
+		u32 agp_3_0;
+
+		pci_read_config_dword(agp_bridge->dev, agp_bridge->capndx + 0x4, &agp_3_0);
+		/* Check to see if we are operating in 3.0 mode */
+		if((agp_3_0 >> 3) & 0x1) {
+			agp_3_0_node_enable(mode, minor);
+			return;
+		} else {
+			printk (KERN_INFO PFX "not in AGP 3.0 mode, falling back to 2.x\n");
+		}
+	}
+#endif
+
+	/* AGP v<3 */
 	pci_read_config_dword(agp_bridge->dev,
-			      agp_bridge->capndx + PCI_AGP_STATUS,
-			      &command);
+		      agp_bridge->capndx + PCI_AGP_STATUS, &command);
 
 	command = agp_collect_device_status(mode, command);
 	command |= 0x100;
 
 	pci_write_config_dword(agp_bridge->dev,
-			       agp_bridge->capndx + PCI_AGP_COMMAND,
-			       command);
-
+		       agp_bridge->capndx + PCI_AGP_COMMAND, command);
 	agp_device_command(command, 0);
 }
 
@@ -745,7 +763,7 @@ EXPORT_SYMBOL(agp_generic_alloc_page);
 EXPORT_SYMBOL(agp_generic_destroy_page);
 EXPORT_SYMBOL(agp_generic_suspend);
 EXPORT_SYMBOL(agp_generic_resume);
-EXPORT_SYMBOL(agp_generic_agp_enable);
+EXPORT_SYMBOL(agp_generic_enable);
 EXPORT_SYMBOL(agp_generic_create_gatt_table);
 EXPORT_SYMBOL(agp_generic_free_gatt_table);
 EXPORT_SYMBOL(agp_generic_insert_memory);
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/hp-agp.c agpgart/drivers/char/agp/hp-agp.c
--- bk-linus/drivers/char/agp/hp-agp.c	2003-04-07 01:41:40.000000000 +0100
+++ agpgart/drivers/char/agp/hp-agp.c	2003-04-07 01:39:30.000000000 +0100
@@ -339,7 +339,7 @@ static int __init hp_zx1_setup (struct p
 	agp_bridge->cleanup = hp_zx1_cleanup;
 	agp_bridge->tlb_flush = hp_zx1_tlbflush;
 	agp_bridge->mask_memory = hp_zx1_mask_memory;
-	agp_bridge->agp_enable = agp_generic_agp_enable;
+	agp_bridge->agp_enable = agp_generic_enable;
 	agp_bridge->cache_flush = global_cache_flush;
 	agp_bridge->create_gatt_table = hp_zx1_create_gatt_table;
 	agp_bridge->free_gatt_table = hp_zx1_free_gatt_table;
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/i460-agp.c agpgart/drivers/char/agp/i460-agp.c
--- bk-linus/drivers/char/agp/i460-agp.c	2003-04-07 01:41:40.000000000 +0100
+++ agpgart/drivers/char/agp/i460-agp.c	2003-04-07 01:39:30.000000000 +0100
@@ -536,7 +536,7 @@ static int __init intel_i460_setup (stru
 	agp_bridge->cleanup = i460_cleanup;
 	agp_bridge->tlb_flush = i460_tlb_flush;
 	agp_bridge->mask_memory = i460_mask_memory;
-	agp_bridge->agp_enable = agp_generic_agp_enable;
+	agp_bridge->agp_enable = agp_generic_enable;
 	agp_bridge->cache_flush = global_cache_flush;
 	agp_bridge->create_gatt_table = i460_create_gatt_table;
 	agp_bridge->free_gatt_table = i460_free_gatt_table;
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/i7x05-agp.c agpgart/drivers/char/agp/i7x05-agp.c
--- bk-linus/drivers/char/agp/i7x05-agp.c	2003-04-07 01:41:40.000000000 +0100
+++ agpgart/drivers/char/agp/i7x05-agp.c	2003-04-02 23:01:32.000000000 +0100
@@ -8,7 +8,7 @@ static int intel_7505_fetch_size(void)
 {
 	int i;
 	u16 tmp;
-	aper_size_info_16 *values;
+	struct aper_size_info_16 *values;
 
 	/* 
 	 * For AGP 3.0 APSIZE is now 16 bits
@@ -41,7 +41,7 @@ static void intel_7505_tlbflush(agp_memo
 
 static void intel_7505_cleanup(void)
 {
-	aper_size_info_16 *previous_size;
+	struct aper_size_info_16 *previous_size;
 
 	previous_size = A_SIZE_16(agp_bridge->previous_size);
 	pci_write_config_byte(agp_bridge->dev, INTEL_I7505_APSIZE,
@@ -52,7 +52,7 @@ static void intel_7505_cleanup(void)
 static int intel_7505_configure(void)
 {
 	u32 temp;
-	aper_size_info_16 *current_size;
+	struct aper_size_info_16 *current_size;
 	
 	current_size = A_SIZE_16(agp_bridge->current_size);
 
@@ -76,7 +76,7 @@ static int intel_7505_configure(void)
 	return 0;
 }
 
-static aper_size_info_16 intel_7505_sizes[7] =
+static struct aper_size_info_16 intel_7505_sizes[7] =
 {
 	{256, 65536, 6, 0xf00},
 	{128, 32768, 5, 0xf20},
@@ -87,15 +87,21 @@ static aper_size_info_16 intel_7505_size
 	{4, 1024, 0, 0xf3f}
 };
 
-static void i7505_setup (u32 mode)
+static unsigned long i7x05_mask_memory(unsigned long addr, int type)
 {
-	if ((agp_generic_agp_3_0_enable)==FALSE)
-		agp_generic_agp_enable(mode);
+	/* Memory type is ignored */
+	return addr | agp_bridge->masks[0].mask;
 }
 
+static struct gatt_mask i7x05_generic_masks[] =
+{
+	{.mask = 0x00000017, .type = 0}
+};
+
+
 static int __init intel_7505_setup (struct pci_dev *pdev)
 {
-	agp_bridge->masks = intel_generic_masks;
+	agp_bridge->masks = i7x05_generic_masks;
 	agp_bridge->aperture_sizes = (void *) intel_7505_sizes;
 	agp_bridge->size_type = U16_APER_SIZE;
 	agp_bridge->num_aperture_sizes = 7;
@@ -105,8 +111,8 @@ static int __init intel_7505_setup (stru
 	agp_bridge->fetch_size = intel_7505_fetch_size;
 	agp_bridge->cleanup = intel_7505_cleanup;
 	agp_bridge->tlb_flush = intel_7505_tlbflush;
-	agp_bridge->mask_memory = intel_mask_memory;
-	agp_bridge->agp_enable = i7505_enable;
+	agp_bridge->mask_memory = i7x05_mask_memory;
+	agp_bridge->agp_enable = agp_generic_enable;
 	agp_bridge->cache_flush = global_cache_flush;
 	agp_bridge->create_gatt_table = agp_generic_create_gatt_table;
 	agp_bridge->free_gatt_table = agp_generic_free_gatt_table;
@@ -165,7 +171,7 @@ static int __init agp_lookup_host_bridge
 }
 
 static struct agp_driver i7x05_agp_driver = {
-	.owner = THIS_MODULE;
+	.owner = THIS_MODULE,
 };
 
 static int __init agp_i7x05_probe (struct pci_dev *dev, const struct pci_device_id *ent)
@@ -180,7 +186,7 @@ static int __init agp_i7x05_probe (struc
 		agp_bridge->dev = dev;
 		agp_bridge->capndx = cap_ptr;
 		/* Fill in the mode register */
-		pci_read_config_dword(agp_bridge->dev, agp_bridge->capndx+PCI_AGP_STATUS, &agp_bridge->mode)
+		pci_read_config_dword(agp_bridge->dev, agp_bridge->capndx+PCI_AGP_STATUS, &agp_bridge->mode);
 		i7x05_agp_driver.dev = dev;
 		agp_register_driver(&i7x05_agp_driver);
 		return 0;
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/intel-agp.c agpgart/drivers/char/agp/intel-agp.c
--- bk-linus/drivers/char/agp/intel-agp.c	2003-04-07 01:41:40.000000000 +0100
+++ agpgart/drivers/char/agp/intel-agp.c	2003-04-07 01:39:30.000000000 +0100
@@ -1026,7 +1026,7 @@ static int __init intel_generic_setup (s
 	agp_bridge->cleanup = intel_cleanup;
 	agp_bridge->tlb_flush = intel_tlbflush;
 	agp_bridge->mask_memory = intel_mask_memory;
-	agp_bridge->agp_enable = agp_generic_agp_enable;
+	agp_bridge->agp_enable = agp_generic_enable;
 	agp_bridge->cache_flush = global_cache_flush;
 	agp_bridge->create_gatt_table = agp_generic_create_gatt_table;
 	agp_bridge->free_gatt_table = agp_generic_free_gatt_table;
@@ -1055,7 +1055,7 @@ static int __init intel_815_setup (struc
 	agp_bridge->cleanup = intel_8xx_cleanup;
 	agp_bridge->tlb_flush = intel_8xx_tlbflush;
 	agp_bridge->mask_memory = intel_mask_memory;
-	agp_bridge->agp_enable = agp_generic_agp_enable;
+	agp_bridge->agp_enable = agp_generic_enable;
 	agp_bridge->cache_flush = global_cache_flush;
 	agp_bridge->create_gatt_table = agp_generic_create_gatt_table;
 	agp_bridge->free_gatt_table = agp_generic_free_gatt_table;
@@ -1085,7 +1085,7 @@ static int __init intel_820_setup (struc
 	agp_bridge->cleanup = intel_820_cleanup;
 	agp_bridge->tlb_flush = intel_820_tlbflush;
 	agp_bridge->mask_memory = intel_mask_memory;
-	agp_bridge->agp_enable = agp_generic_agp_enable;
+	agp_bridge->agp_enable = agp_generic_enable;
 	agp_bridge->cache_flush = global_cache_flush;
 	agp_bridge->create_gatt_table = agp_generic_create_gatt_table;
 	agp_bridge->free_gatt_table = agp_generic_free_gatt_table;
@@ -1114,7 +1114,7 @@ static int __init intel_830mp_setup (str
 	agp_bridge->cleanup = intel_8xx_cleanup;
 	agp_bridge->tlb_flush = intel_8xx_tlbflush;
 	agp_bridge->mask_memory = intel_mask_memory;
-	agp_bridge->agp_enable = agp_generic_agp_enable;
+	agp_bridge->agp_enable = agp_generic_enable;
 	agp_bridge->cache_flush = global_cache_flush;
 	agp_bridge->create_gatt_table = agp_generic_create_gatt_table;
 	agp_bridge->free_gatt_table = agp_generic_free_gatt_table;
@@ -1143,7 +1143,7 @@ static int __init intel_840_setup (struc
 	agp_bridge->cleanup = intel_8xx_cleanup;
 	agp_bridge->tlb_flush = intel_8xx_tlbflush;
 	agp_bridge->mask_memory = intel_mask_memory;
-	agp_bridge->agp_enable = agp_generic_agp_enable;
+	agp_bridge->agp_enable = agp_generic_enable;
 	agp_bridge->cache_flush = global_cache_flush;
 	agp_bridge->create_gatt_table = agp_generic_create_gatt_table;
 	agp_bridge->free_gatt_table = agp_generic_free_gatt_table;
@@ -1172,7 +1172,7 @@ static int __init intel_845_setup (struc
 	agp_bridge->cleanup = intel_8xx_cleanup;
 	agp_bridge->tlb_flush = intel_8xx_tlbflush;
 	agp_bridge->mask_memory = intel_mask_memory;
-	agp_bridge->agp_enable = agp_generic_agp_enable;
+	agp_bridge->agp_enable = agp_generic_enable;
 	agp_bridge->cache_flush = global_cache_flush;
 	agp_bridge->create_gatt_table = agp_generic_create_gatt_table;
 	agp_bridge->free_gatt_table = agp_generic_free_gatt_table;
@@ -1201,7 +1201,7 @@ static int __init intel_850_setup (struc
 	agp_bridge->cleanup = intel_8xx_cleanup;
 	agp_bridge->tlb_flush = intel_8xx_tlbflush;
 	agp_bridge->mask_memory = intel_mask_memory;
-	agp_bridge->agp_enable = agp_generic_agp_enable;
+	agp_bridge->agp_enable = agp_generic_enable;
 	agp_bridge->cache_flush = global_cache_flush;
 	agp_bridge->create_gatt_table = agp_generic_create_gatt_table;
 	agp_bridge->free_gatt_table = agp_generic_free_gatt_table;
@@ -1230,7 +1230,7 @@ static int __init intel_860_setup (struc
 	agp_bridge->cleanup = intel_8xx_cleanup;
 	agp_bridge->tlb_flush = intel_8xx_tlbflush;
 	agp_bridge->mask_memory = intel_mask_memory;
-	agp_bridge->agp_enable = agp_generic_agp_enable;
+	agp_bridge->agp_enable = agp_generic_enable;
 	agp_bridge->cache_flush = global_cache_flush;
 	agp_bridge->create_gatt_table = agp_generic_create_gatt_table;
 	agp_bridge->free_gatt_table = agp_generic_free_gatt_table;
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/sis-agp.c agpgart/drivers/char/agp/sis-agp.c
--- bk-linus/drivers/char/agp/sis-agp.c	2003-04-07 01:41:40.000000000 +0100
+++ agpgart/drivers/char/agp/sis-agp.c	2003-04-07 01:39:30.000000000 +0100
@@ -99,7 +99,7 @@ static int __init sis_generic_setup (str
 	agp_bridge->cleanup = sis_cleanup;
 	agp_bridge->tlb_flush = sis_tlbflush;
 	agp_bridge->mask_memory = sis_mask_memory;
-	agp_bridge->agp_enable = agp_generic_agp_enable;
+	agp_bridge->agp_enable = agp_generic_enable;
 	agp_bridge->cache_flush = global_cache_flush;
 	agp_bridge->create_gatt_table = agp_generic_create_gatt_table;
 	agp_bridge->free_gatt_table = agp_generic_free_gatt_table;
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/via-agp.c agpgart/drivers/char/agp/via-agp.c
--- bk-linus/drivers/char/agp/via-agp.c	2003-04-07 01:41:40.000000000 +0100
+++ agpgart/drivers/char/agp/via-agp.c	2003-04-01 16:41:41.000000000 +0100
@@ -186,7 +186,7 @@ static int __init via_generic_agp3_setup
 	agp_bridge->num_aperture_sizes = 10;
 	agp_bridge->dev_private_data = NULL;
 	agp_bridge->needs_scratch_page = FALSE;
-	agp_bridge->agp_enable = agp_generic_agp_3_0_enable;
+	agp_bridge->agp_enable = agp_generic_enable;
 	agp_bridge->configure = via_configure_agp3;
 	agp_bridge->fetch_size = via_fetch_size_agp3;
 	agp_bridge->cleanup = via_cleanup_agp3;
@@ -248,7 +248,7 @@ static int __init via_generic_setup (str
 	agp_bridge->cleanup = via_cleanup;
 	agp_bridge->tlb_flush = via_tlbflush;
 	agp_bridge->mask_memory = via_mask_memory;
-	agp_bridge->agp_enable = agp_generic_agp_enable;
+	agp_bridge->agp_enable = agp_generic_enable;
 	agp_bridge->cache_flush = global_cache_flush;
 	agp_bridge->create_gatt_table = agp_generic_create_gatt_table;
 	agp_bridge->free_gatt_table = agp_generic_free_gatt_table;
@@ -319,10 +319,10 @@ static struct agp_device_ids via_agp_dev
 	},
 
 	/* VT8361 */
-/*	{
+	{
 		.device_id	= PCI_DEVICE_ID_VIA_8361,	// 0x3112
 		.chipset_name	= "Apollo KLE133",
-	}, */
+	},
 
 	/* VT8365 / VT8362 */
 	{
@@ -331,10 +331,10 @@ static struct agp_device_ids via_agp_dev
 	},
 
 	/* VT8753A */
-/*	{
-		.device_id	= PCI_DEVICE_ID_VIA_8753_0,	// 0x3128
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_8753_0,
 		.chipset_name	= "P4X266",
-	},	*/	
+	},
 
 	/* VT8366 */
 	{
@@ -349,16 +349,16 @@ static struct agp_device_ids via_agp_dev
 	},
 
 	/* KM266 / PM266 */
-/*	{
-		.device_id	= PCI_DEVICE_ID_VIA_KM266,	// 0x3116
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_KM266,
 		.chipset_name	= "KM266/PM266",
-	},	*/
+	},
 
 	/* CLE266 */
-/*	{
-		.device_id	= PCI_DEVICE_ID_VIA_CLE266,	// 0x3123
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_CLE266,
 		.chipset_name	= "CLE266",
-	},	*/
+	},
 
 	{
 		.device_id	= PCI_DEVICE_ID_VIA_8377_0,
@@ -374,16 +374,16 @@ static struct agp_device_ids via_agp_dev
 	},
 
 	/* VT8752*/
-/*	{
-		.device_id	= PCI_DEVICE_ID_VIA_8752,	// 0x3148
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_8752,
 		.chipset_name	= "ProSavage DDR P4M266",
-	},	*/
+	},
 
 	/* KN266/PN266 */
-/*	{
-		.device_id	= PCI_DEVICE_ID_KN266,	// 0x3156
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_KN266,
 		.chipset_name	= "KN266/PN266",
-	},	*/
+	},
 
 	/* VT8754 */
 	{
@@ -392,28 +392,28 @@ static struct agp_device_ids via_agp_dev
 	},
 
 	/* P4N333 */
-/*	{
-		.device_id	= PCI_DEVICE_ID_VIA_P4N333,	// 0x3178
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_P4N333,
 		.chipset_name	= "P4N333",
-	}, */
+	},
 
 	/* P4X600 */
-/*	{
-		.device_id	= PCI_DEVICE_ID_VIA_P4X600,	// 0x0198
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_P4X600,
 		.chipset_name	= "P4X600",
-	},	*/
+	},
 
 	/* KM400 */
-/*	{
-		.device_id	= PCI_DEVICE_ID_VIA_KM400,	// 0x3205
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_KM400,
 		.chipset_name	= "KM400",
-	},	*/
+	},
 
 	/* P4M400 */
-/*	{
-		.device_id	= PCI_DEVICE_ID_VIA_P4M400,	// 0x3209
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_P4M400,
 		.chipset_name	= "PM400",
-	},	*/
+	},
 
 	{ }, /* dummy final entry, always present */
 };
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/linux/pci_ids.h agpgart/include/linux/pci_ids.h
--- bk-linus/include/linux/pci_ids.h	2003-04-07 01:42:34.000000000 +0100
+++ agpgart/include/linux/pci_ids.h	2003-04-07 01:34:34.000000000 +0100
@@ -1074,6 +1074,7 @@
 #define PCI_DEVICE_ID_TTI_HPT374	0x0008
 
 #define PCI_VENDOR_ID_VIA		0x1106
+#define PCI_DEVICE_ID_VIA_P4X600	0x0198
 #define PCI_DEVICE_ID_VIA_8363_0	0x0305 
 #define PCI_DEVICE_ID_VIA_8371_0	0x0391
 #define PCI_DEVICE_ID_VIA_8501_0	0x0501
@@ -1113,11 +1114,19 @@
 #define PCI_DEVICE_ID_VIA_8653_0	0x3101
 #define PCI_DEVICE_ID_VIA_8622		0x3102 
 #define PCI_DEVICE_ID_VIA_8233C_0	0x3109
-#define PCI_DEVICE_ID_VIA_8361		0x3112 
+#define PCI_DEVICE_ID_VIA_8361		0x3112
+#define PCI_DEVICE_ID_VIA_KM266		0x3116
+#define PCI_DEVICE_ID_VIA_CLE266	0x3123
+#define PCI_DEVICE_ID_VIA_8753_0	0x3128
 #define PCI_DEVICE_ID_VIA_8233A		0x3147
+#define PCI_DEVICE_ID_VIA_8752		0x3148
+#define PCI_DEVICE_ID_VIA_KN266		0x3156
 #define PCI_DEVICE_ID_VIA_8754		0x3168
 #define PCI_DEVICE_ID_VIA_8235		0x3177
+#define PCI_DEVICE_ID_VIA_P4N333	0x3178
 #define PCI_DEVICE_ID_VIA_8377_0	0x3189
+#define PCI_DEVICE_ID_VIA_KM400		0x3205
+#define PCI_DEVICE_ID_VIA_P4M400	0x3209
 #define PCI_DEVICE_ID_VIA_86C100A	0x6100
 #define PCI_DEVICE_ID_VIA_8231		0x8231
 #define PCI_DEVICE_ID_VIA_8231_4	0x8235

