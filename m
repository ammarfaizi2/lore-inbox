Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbUAZJqP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 04:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbUAZJqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 04:46:15 -0500
Received: from mail1.drkw.com ([62.129.121.35]:57279 "EHLO mail1.drkw.com")
	by vger.kernel.org with ESMTP id S263014AbUAZJqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 04:46:00 -0500
From: "Heilmann, Oliver" <Oliver.Heilmann@drkw.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] AGPGART preliminary SiS648 support - fixed and shrunk
Content-Type: text/plain
Message-Id: <1075110384.566.6.camel@cobra>
Mime-Version: 1.0
Date: Mon, 26 Jan 2004 09:46:24 +0000
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: Oliver.Heilmann@drkw.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* fixed a major bug where the request size had accidentally been take from the master's status reg instead of the target's.

* got rid of the extra file it's all in generic.c and sis-agp.c now

Any feedback is greatly appreciated. 

patch is vs 2.6.1

Oliver 

diff -urN -X dontdiff linux-2.6.1/drivers/char/agp/agp.h linux-2.6.1.agp648/drivers/char/agp/agp.h
--- linux-2.6.1/drivers/char/agp/agp.h	2004-01-09 06:59:26.000000000 +0000
+++ linux-2.6.1.agp648/drivers/char/agp/agp.h	2004-01-24 23:58:38.000000000 +0000
@@ -402,6 +402,16 @@
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
 extern int agp_off;
 extern int agp_try_unsupported_boot;
 
@@ -410,13 +420,17 @@
 #define AGPCMD			0x8
 #define AGPNISTAT		0xc
 #define AGPCTRL                 0x10
+#define AGPAPSIZE               0x14
 #define AGPNEPG			0x16
+#define AGPGARTLO               0x18
+#define AGPGARTHI               0x1c
 #define AGPNICMD		0x20
 
 #define AGP_MAJOR_VERSION_SHIFT	(20)
 #define AGP_MINOR_VERSION_SHIFT	(16)
 
 #define AGPSTAT_RQ_DEPTH	(0xff000000)
+#define AGPSTAT_RQ_DEPTH_SHIFT  24
 
 #define AGPSTAT_CAL_MASK	(1<<12|1<<11|1<<10)
 #define AGPSTAT_ARQSZ		(1<<15|1<<14|1<<13)
@@ -435,4 +449,7 @@
 #define AGPSTAT3_8X		(1<<1)
 #define AGPSTAT3_4X		(1)
 
+#define AGPCTRL_APERENB         (1<<8)
+#define AGPCTRL_GTLBEN          (1<<7)
+
 #endif				/* _AGP_BACKEND_PRIV_H */
diff -urN -X dontdiff linux-2.6.1/drivers/char/agp/generic.c linux-2.6.1.agp648/drivers/char/agp/generic.c
--- linux-2.6.1/drivers/char/agp/generic.c	2004-01-09 06:59:26.000000000 +0000
+++ linux-2.6.1.agp648/drivers/char/agp/generic.c	2004-01-24 23:02:37.000000000 +0000
@@ -956,3 +956,86 @@
 }
 EXPORT_SYMBOL(agp_generic_mask_memory);
 
+/*
+ * These functions are implemented according to the agpV3 spec,
+ * which covers implementation details that had previously been
+ * left open.
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
+		if (temp_size == values[i].size_value) {
+			agp_bridge->previous_size =
+				agp_bridge->current_size = (void *) (values + i);
+			
+			agp_bridge->aperture_size_idx = i;
+			return values[i].size;
+		}
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
diff -urN -X dontdiff linux-2.6.1/drivers/char/agp/sis-agp.c linux-2.6.1.agp648/drivers/char/agp/sis-agp.c
--- linux-2.6.1/drivers/char/agp/sis-agp.c	2004-01-09 06:59:06.000000000 +0000
+++ linux-2.6.1.agp648/drivers/char/agp/sis-agp.c	2004-01-25 17:26:15.000000000 +0000
@@ -95,6 +95,88 @@
 	.agp_destroy_page	= agp_generic_destroy_page,
 };
 
+// sis-648 specific routines + driver
+static void sis648_enable(u32 mode)
+{
+	// find the master, this needs to be better
+	struct pci_dev *master = NULL;
+	u8 mcapndx=0;
+
+	while ((master = pci_find_class(PCI_CLASS_DISPLAY_VGA<<8, master)) != NULL) {
+		mcapndx = pci_find_capability(master, PCI_CAP_ID_AGP);
+		printk (KERN_INFO PFX "Found AGP master. %x:%x \n", master->vendor, master->device);
+		break;
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
+	int tcc=tStatus & AGPSTAT_CAL_MASK;
+	int mcc=mStatus & AGPSTAT_CAL_MASK;
+	int calcycl=(tcc<mcc) ? tcc : mcc;
+	int rate=(tStatus & tStatus &  AGPSTAT3_8X) ? 2 : 1;
+
+	u32 tcmd=tStatus & mStatus & (AGPSTAT_SBA|AGPSTAT_FW);
+	u32 mcmd=tcmd;
+	tcmd|=calcycl|AGPSTAT_AGP_ENABLE|rate;
+	mcmd|=(tStatus & AGPSTAT_RQ_DEPTH)|(tStatus & AGPSTAT_ARQSZ)|AGPSTAT_AGP_ENABLE|rate;
+
+	printk(KERN_INFO PFX "tcmd=%x\n",tcmd);
+	printk(KERN_INFO PFX "mcmd=%x\n",mcmd);
+
+	// init target (bridge)
+	pci_write_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPCMD, tcmd);
+	
+	u8 mcaptest = pci_find_capability(master, PCI_CAP_ID_AGP);
+	if(mcaptest!=mcapndx)
+	{
+		printk(KERN_INFO PFX "master capndx screwed ... waiting 10ms\n");
+		// weird: on 648fx chipsets any rate change in the target command register
+		// triggers a 5ms screwup during which the master cannot be configured
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout (1+(HZ*10)/1000);  
+	}
+	else
+	{
+		printk(KERN_INFO PFX "bridge is up and master seems okay");
+	}
+	
+	// init master (card)
+	pci_write_config_dword(master, mcapndx+AGPCMD, mcmd);
+}
+
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
+// sis-648 end
+
+
 static struct agp_device_ids sis_agp_device_ids[] __devinitdata =
 {
 	{
@@ -206,7 +288,11 @@
 	if (!bridge)
 		return -ENOMEM;
 
-	bridge->driver = &sis_driver;
+
+	if(pdev->device==PCI_DEVICE_ID_SI_648)
+		bridge->driver = &sis648_driver;
+	else
+		bridge->driver = &sis_driver;
 	bridge->dev = pdev;
 	bridge->capndx = cap_ptr;



--------------------------------------------------------------------------------
The information contained herein is confidential and is intended solely for the
addressee. Access by any other party is unauthorised without the express
written permission of the sender. If you are not the intended recipient, please
contact the sender either via the company switchboard on +44 (0)20 7623 8000, or
via e-mail return. If you have received this e-mail in error or wish to read our
e-mail disclaimer statement and monitoring policy, please refer to 
http://www.drkw.com/disc/email/ or contact the sender.
--------------------------------------------------------------------------------

