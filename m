Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265623AbTFRXwO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 19:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265624AbTFRXwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 19:52:14 -0400
Received: from smtp01.web.de ([217.72.192.180]:47896 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S265623AbTFRXwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 19:52:05 -0400
From: Gregor Essers <gregor.essers@web.de>
To: linux-kernel@vger.kernel.org
Subject: KT 400 ATI-Only Patch for AGP 8x
Date: Thu, 19 Jun 2003 02:06:04 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_s5P8+Hrwk7vgFuh"
Message-Id: <200306190206.04817.gregor.essers@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_s5P8+Hrwk7vgFuh
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all, 

long searches have bring me to a thread on rage3d.com, and someone there has 
patched the Ati-Drivers from schneider-digital.de (13.5.2003).

I home that can help :)

Regards 

Gregor Essers
--Boundary-00=_s5P8+Hrwk7vgFuh
Content-Type: text/x-diff;
  charset="us-ascii";
  name="fglrx-glc22-4.2.0-2.5.1.i586-kt400agp3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fglrx-glc22-4.2.0-2.5.1.i586-kt400agp3.patch"

--- build_mod/agp.h	2002-11-27 14:53:19.000000000 -0500
+++ build_mod_kt400/agp.h	2003-02-10 15:19:33.000000000 -0500
@@ -47,8 +47,9 @@
 #define _FGL_AGP_H
 
 // build config defines
+#ifndef VIA_KT400_AGP3
 #define FGL_USE_AGPV3_OFFICIAL_ENABLE       /* use offical AGP V3 code */
-
+#endif
 // helper defines - for any public source of firegl code tree.
 
 // min/max defines taken from include/linux/kernel.h of linux-2.4.10-pre9
@@ -837,6 +838,12 @@
 #define VIA_APSIZE      0x84
 #define VIA_ATTBASE     0x88
 
+/* VIA KT400 */
+#define VIA_AGP3_GARTCTRL 0x90
+#define VIA_AGP3_APSIZE	  0x94
+#define VIA_AGP3_ATTBASE  0x98
+#define VIA_AGPSEL        0xfd
+
 /* SiS registers */
 #define SIS_APBASE      0x10
 #define SIS_ATTBASE     0x90
--- build_mod/agpgart_be.c	2002-11-27 14:53:19.000000000 -0500
+++ build_mod_kt400/agpgart_be.c	2003-02-10 15:21:09.000000000 -0500
@@ -2561,6 +2561,8 @@
     (void) pdev; /* unused */
 }
 
+#ifndef VIA_KT400_AGP3
+
 static int via_fetch_size(void)
 {
 	int i;
@@ -2619,6 +2621,63 @@
 	pci_write_config_dword(agp_bridge.dev, VIA_GARTCTRL, 0x0000000f);
 }
 
+#else
+
+static int via_fetch_size(void)
+{
+	int i;
+	u16 temp;
+	struct aper_size_info_16 *values;
+
+	values = A_SIZE_16(agp_bridge.aperture_sizes);
+	pci_read_config_word(agp_bridge.dev, VIA_AGP3_APSIZE, &temp);
+	for (i = 0; i < agp_bridge.num_aperture_sizes; i++) {
+		if (temp == values[i].size_value) {
+			agp_bridge.previous_size =
+			agp_bridge.current_size = (void *) (values + i);
+			agp_bridge.aperture_size_idx = i;
+			return values[i].size;
+		}
+	}
+	return 0;
+}
+
+static int via_configure(void)
+{
+	u32 temp;
+	struct aper_size_info_16 *current_size;
+    
+	current_size = A_SIZE_16(agp_bridge.current_size);
+
+	/* address to map too */
+	pci_read_config_dword(agp_bridge.dev, VIA_APBASE, &temp);
+	agp_bridge.gart_bus_addr = (temp & PCI_BASE_ADDRESS_MEM_MASK);
+
+	/* attbase - aperture GATT base */
+	pci_write_config_dword(agp_bridge.dev, VIA_AGP3_ATTBASE,
+		agp_bridge.gatt_bus_addr & 0xfffff000);
+	return 0;
+}
+
+static void via_cleanup(void)
+{
+	struct aper_size_info_16 *previous_size;
+
+	previous_size = A_SIZE_16(agp_bridge.previous_size);
+	pci_write_config_byte(agp_bridge.dev, VIA_APSIZE, previous_size->size_value);
+}
+
+static void via_tlbflush(agp_memory * mem)
+{
+	u32 temp;
+
+	pci_read_config_dword(agp_bridge.dev, VIA_AGP3_GARTCTRL, &temp);
+	pci_write_config_dword(agp_bridge.dev, VIA_AGP3_GARTCTRL, temp & ~(1<<7));
+	pci_write_config_dword(agp_bridge.dev, VIA_AGP3_GARTCTRL, temp);
+}
+
+#endif
+
 static unsigned long via_mask_memory(unsigned long addr, int type)
 {
 	/* Memory type is ignored */
@@ -2626,6 +2685,8 @@
 	return addr | agp_bridge.masks[0].mask;
 }
 
+#ifndef VIA_KT400_AGP3
+
 static struct aper_size_info_8 via_generic_sizes[7] =
 {
 	{256, 65536, 6, 0},
@@ -2637,6 +2698,24 @@
 	{4, 1024, 0, 252}
 };
 
+#else
+
+static struct aper_size_info_16 via_generic_sizes[11] =
+{
+	{ 4,     1024,  0, 1<<11|1<<10|1<<9|1<<8|1<<5|1<<4|1<<3|1<<2|1<<1|1<<0 },
+	{ 8,     2048,  1, 1<<11|1<<10|1<<9|1<<8|1<<5|1<<4|1<<3|1<<2|1<<1},
+	{ 16,    4096,  2, 1<<11|1<<10|1<<9|1<<8|1<<5|1<<4|1<<3|1<<2},
+	{ 32,    8192,  3, 1<<11|1<<10|1<<9|1<<8|1<<5|1<<4|1<<3},
+	{ 64,   16384,  4, 1<<11|1<<10|1<<9|1<<8|1<<5|1<<4},
+	{ 128,  32768,  5, 1<<11|1<<10|1<<9|1<<8|1<<5},
+	{ 256,  65536,  6, 1<<11|1<<10|1<<9|1<<8},
+	{ 512,  131072, 7, 1<<11|1<<10|1<<9},
+	{ 1024, 262144, 8, 1<<11|1<<10},
+	{ 2048, 524288, 9, 1<<11}	/* 2GB <- Max supported */
+};
+
+#endif
+
 static struct gatt_mask via_generic_masks[] =
 {
 	{0x00000000, 0}
@@ -2648,7 +2727,11 @@
 	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) via_generic_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
+#ifndef VIA_KT400_AGP3   
 	agp_bridge.num_aperture_sizes = 7;
+#else 
+	agp_bridge.num_aperture_sizes = 11;
+#endif   
 	agp_bridge.dev_private_data = NULL;
 	agp_bridge.needs_scratch_page = FALSE;
 	agp_bridge.configure = via_configure;
--- build_mod/make.sh	2002-11-27 14:53:19.000000000 -0500
+++ build_mod_kt400/make.sh	2003-02-08 22:44:23.000000000 -0500
@@ -781,7 +781,7 @@
 
 # ==============================================================
 # defines for all targets
-def_for_all="-DATI_AGP_HOOK -DATI -DFGL -D${target_define} -DFGL_CUSTOM_MODULE"
+def_for_all="-DATI_AGP_HOOK -DATI -DFGL -D${target_define} -DFGL_CUSTOM_MODULE -DVIA_KT400_AGP3"
 
 
 # ==============================================================

--Boundary-00=_s5P8+Hrwk7vgFuh--

