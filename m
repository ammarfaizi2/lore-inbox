Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266234AbUBKXAA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 18:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266232AbUBKW77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 17:59:59 -0500
Received: from mail1.drkw.com ([62.129.121.35]:58532 "EHLO mail1.drkw.com")
	by vger.kernel.org with ESMTP id S266234AbUBKW7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 17:59:35 -0500
From: "Heilmann, Oliver" <Oliver.Heilmann@drkw.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] AGP 648[FX] cleaned+fixed but still have problem. Plz help.
Content-Type: text/plain
Message-Id: <1076540358.609.60.camel@cobra>
Mime-Version: 1.0
Date: Wed, 11 Feb 2004 22:59:19 +0000
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: Oliver.Heilmann@drkw.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch is provides AGP support for sis 648 and 648FX chipsets
(previous versions only worked on FX chipsets).

However there is still this issue that I haven't been able to figure
out. First of, here's what I found out so far:

AGP initialisation is totally different between the two chipset
versions. The FX version sticks to the AGP3 spec in most regards, claims
to support 3.5 but does not support isochronous transactions.
The plain (non-FX) version does not stick to the spec and uses the same
register set as all the other sis chips supported in sis-agp.c. The
capid register of the plain version shows agp3.0 and not 3.5 as the FX
version, which is how I tell the two appart. Both share the same PCI-Id.

The only common thing (as far as AGP is concerned) between the two chip
iterations is this bug(or is it):
Any time the agp rate is changed in the bridges command register, the
bridge stops working for about 5ms, such that the master's (agp-card)
config space cannot be read (returns the same value regardless of
offset). This is fatal during initialisation because the bridge must be
initialised before the master.
I recorded the config spaces of both the bridge and the master before,
during and after the screw-up in order to find some event I can wait
for.No such luck. Even if I just wait for the master's config space to
become readable again, the bridge does not seem to be completely ready
and initialisation still fails most of the time.
Could this indeed be a chipset bug? Can anybody think of any other event
I could wait for? Currently I'm just waiting 10+ ms, which ALWAYS work. 

Oliver


Changes since last patch:
* added 648 support
* cleaned up to only use one driver struct instance in sis-agp.c
* uses more existing code and recycles agp_device_command
* generally a lot cleaner


diff -uprN -X dontdiff linux-2.6.2/drivers/char/agp/agp.h linux-2.6.2.lastmod/drivers/char/agp/agp.h
--- linux-2.6.2/drivers/char/agp/agp.h	2004-02-04 03:43:43.000000000 +0000
+++ linux-2.6.2.lastmod/drivers/char/agp/agp.h	2004-02-09 13:01:46.000000000 +0000
@@ -402,6 +402,16 @@ void global_cache_flush(void);
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
 
@@ -410,13 +420,17 @@ extern int agp_try_unsupported_boot;
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
@@ -435,4 +449,7 @@ extern int agp_try_unsupported_boot;
 #define AGPSTAT3_8X		(1<<1)
 #define AGPSTAT3_4X		(1)
 
+#define AGPCTRL_APERENB         (1<<8)
+#define AGPCTRL_GTLBEN          (1<<7)
+
 #endif				/* _AGP_BACKEND_PRIV_H */
diff -uprN -X dontdiff linux-2.6.2/drivers/char/agp/generic.c linux-2.6.2.lastmod/drivers/char/agp/generic.c
--- linux-2.6.2/drivers/char/agp/generic.c	2004-02-04 03:43:42.000000000 +0000
+++ linux-2.6.2.lastmod/drivers/char/agp/generic.c	2004-02-11 17:06:25.000000000 +0000
@@ -956,3 +956,86 @@ unsigned long agp_generic_mask_memory(un
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
diff -uprN -X dontdiff linux-2.6.2/drivers/char/agp/sis-agp.c linux-2.6.2.lastmod/drivers/char/agp/sis-agp.c
--- linux-2.6.2/drivers/char/agp/sis-agp.c	2004-02-04 03:43:07.000000000 +0000
+++ linux-2.6.2.lastmod/drivers/char/agp/sis-agp.c	2004-02-11 16:45:39.000000000 +0000
@@ -61,6 +61,45 @@ static void sis_cleanup(void)
 			      (previous_size->size_value & ~(0x03)));
 }
 
+static void sis_648_enable(u32 mode)
+{
+	struct pci_dev *device = NULL;
+	u32 command;
+	int rate;
+
+	printk(KERN_INFO PFX "Found an AGP %d.%d compliant device at %s.\n",
+	       agp_bridge->major_version,
+	       agp_bridge->minor_version,
+	       agp_bridge->dev->slot_name);
+
+	pci_read_config_dword(agp_bridge->dev,
+			      agp_bridge->capndx + PCI_AGP_STATUS, &command);
+
+	command = agp_collect_device_status(mode, command);
+	command |= AGPSTAT_AGP_ENABLE;
+	rate = (command & 0x7) << 2;
+	
+	while ((device = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, device)) != NULL) {
+		u8 agp = pci_find_capability(device, PCI_CAP_ID_AGP);
+		if (!agp)
+			continue;
+		
+		printk(KERN_INFO PFX "Putting AGP V3 device at %s into %dx mode\n",
+		       pci_name(device), rate);
+		
+		pci_write_config_dword(device, agp + PCI_AGP_COMMAND, command);
+		
+		if(device->device == PCI_DEVICE_ID_SI_648)
+		{
+			// weird: on 648 and 648fx chipsets any rate change in the target command register
+			// triggers a 5ms screwup during which the master cannot be configured
+			printk(KERN_INFO PFX "sis 648 agp fix - giving bridge time to recover\n");
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout (1+(HZ*10)/1000);
+		}
+	}
+}
+
 static struct aper_size_info_8 sis_generic_sizes[7] =
 {
 	{256, 65536, 6, 99},
@@ -176,6 +215,29 @@ static struct agp_device_ids sis_agp_dev
 	{ }, /* dummy final entry, always present */
 };
 
+static void __devinit sis_get_driver(struct agp_bridge_data *bridge)
+{
+	if(bridge->dev->device==PCI_DEVICE_ID_SI_648)
+	{
+		if(agp_bridge->major_version==3 && agp_bridge->minor_version < 5)
+		{
+			sis_driver.agp_enable=sis_648_enable;
+		}
+		else
+		{
+			sis_driver.agp_enable         = sis_648_enable;
+			sis_driver.aperture_sizes     = agp3_generic_sizes;
+			sis_driver.size_type	      = U16_APER_SIZE;
+			sis_driver.num_aperture_sizes = AGP_GENERIC_SIZES_ENTRIES;
+			sis_driver.configure	      = agp3_generic_configure;
+			sis_driver.fetch_size	      = agp3_generic_fetch_size;
+			sis_driver.cleanup	      = agp3_generic_cleanup;
+			sis_driver.tlb_flush	      = agp3_generic_tlbflush;
+		}
+	}
+	bridge->driver=&sis_driver;
+}
+
 static int __devinit agp_sis_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *ent)
 {
@@ -206,14 +268,17 @@ found:
 	if (!bridge)
 		return -ENOMEM;
 
-	bridge->driver = &sis_driver;
 	bridge->dev = pdev;
 	bridge->capndx = cap_ptr;
 
+	get_agp_version(bridge);
+
 	/* Fill in the mode register */
 	pci_read_config_dword(pdev,
-			bridge->capndx+PCI_AGP_STATUS,
-			&bridge->mode);
+			      bridge->capndx+PCI_AGP_STATUS,
+			      &bridge->mode);
+
+	sis_get_driver(bridge);
 
 	pci_set_drvdata(pdev, bridge);
 	return agp_add_bridge(bridge);



--------------------------------------------------------------------------------
The information contained herein is confidential and is intended solely for the
addressee. Access by any other party is unauthorised without the express 
written permission of the sender. If you are not the intended recipient, please 
contact the sender either via the company switchboard on +44 (0)20 7623 8000, or
via e-mail return. If you have received this e-mail in error or wish to read our
e-mail disclaimer statement and monitoring policy, please refer to 
http://www.drkw.com/disc/email/ or contact the sender.
--------------------------------------------------------------------------------

