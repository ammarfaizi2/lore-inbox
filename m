Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278959AbRKFJWN>; Tue, 6 Nov 2001 04:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278879AbRKFJWF>; Tue, 6 Nov 2001 04:22:05 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:32522 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S278792AbRKFJV4>;
	Tue, 6 Nov 2001 04:21:56 -0500
Message-ID: <3BE7ABB2.7010507@epfl.ch>
Date: Tue, 06 Nov 2001 10:21:54 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>, alan@lxorguk.ukuu.org.uk
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Intel 820 chipset AGP - Fix for 840, 845, 850, 860 AGP support
Content-Type: multipart/mixed;
 boundary="------------010304050509070708090501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010304050509070708090501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello all

Following the discussion with Robert Love, here is a patch that :
	- provides AGP support for i820 chipset
	- fixes several incorrect reads/writes to the APSIZE register. According 
to the Intel specs, this register has a size of 8 bits for the 820, 840, 
845, 850 and 860 chipsets. As a consequence, the types for the aperture 
info has been changed to aper_Size_info_8
	- the '*tlbflush' was incorrect. The Intel specs give only one bit of the 
AGPCTRL to be set to flush the GTLB. The generic function writes this 
bit, along with two others (why ?)


The patch has been made against 2.4.13-ac7. I have another one available 
for the 2.4.9 Redhat's kernel at 
http://ltswww.epfl.ch/~aspert/patches/patch-agp_i820-2.4.9-6_fix_apsize
This one works fine with me (I have i820) _but_ the other chipsets have 
not been tested. Please report any bug/silly things you may find. I have 
not tested the patch for 2.4.13-ac7, but it should not break up too many 
things :-)

Nicolas.

PS: I am not subsribed to linux-kernel, so CC to me your 
answers/proposals/whatever ;-)
-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)

--------------010304050509070708090501
Content-Type: text/plain;
 name="patch-agp_i820-2.4.13-ac7_fix_agpsize"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-agp_i820-2.4.13-ac7_fix_agpsize"

diff -Nru linux-2.4.13-ac7.clean/Documentation/Configure.help linux-2.4.13-ac7_i820/Documentation/Configure.help
--- linux-2.4.13-ac7.clean/Documentation/Configure.help	Mon Nov  5 16:26:56 2001
+++ linux-2.4.13-ac7_i820/Documentation/Configure.help	Mon Nov  5 16:13:09 2001
@@ -3098,10 +3098,10 @@
   a module, say M here and read <file:Documentation/modules.txt>.  The
   module will be called agpgart.o.
 
-Intel 440LX/BX/GX/815/830/840/845/850/860 support
+Intel 440LX/BX/GX/815/820/830/840/845/850/860 support
 CONFIG_AGP_INTEL
   This option gives you AGP support for the GLX component of the
-  XFree86 4.x on Intel 440LX/BX/GX, 815, 830, 840, 845, 850 and 860 chipsets.
+  XFree86 4.x on Intel 440LX/BX/GX, 815, 820, 830, 840, 845, 850 and 860 chipsets.
 
   You should say Y here if you use XFree86 3.3.6 or 4.x and want to
   use GLX or DRI.  If unsure, say N.
diff -Nru linux-2.4.13-ac7.clean/drivers/char/Config.in linux-2.4.13-ac7_i820/drivers/char/Config.in
--- linux-2.4.13-ac7.clean/drivers/char/Config.in	Mon Nov  5 16:26:57 2001
+++ linux-2.4.13-ac7_i820/drivers/char/Config.in	Mon Nov  5 16:13:34 2001
@@ -213,7 +213,7 @@
    bool '  ALI chipset support' CONFIG_AGP_ALI
    bool '  AMD Irongate, 761, and 762 support' CONFIG_AGP_AMD
    bool '  Generic SiS support' CONFIG_AGP_SIS
-   bool '  Intel 440LX/BX/GX and I815/I830/I840/I845/I850/I860 support' CONFIG_AGP_INTEL
+   bool '  Intel 440LX/BX/GX and I815/I820/I830/I840/I845/I850/I860 support' CONFIG_AGP_INTEL
    bool '  Intel I810/I815/I830M (on-board) support' CONFIG_AGP_I810
    bool '  Serverworks LE/HE support' CONFIG_AGP_SWORKS
    bool '  VIA chipset support' CONFIG_AGP_VIA
diff -Nru linux-2.4.13-ac7.clean/drivers/char/agp/agp.h linux-2.4.13-ac7_i820/drivers/char/agp/agp.h
--- linux-2.4.13-ac7.clean/drivers/char/agp/agp.h	Mon Nov  5 16:26:57 2001
+++ linux-2.4.13-ac7_i820/drivers/char/agp/agp.h	Tue Nov  6 09:53:12 2001
@@ -176,6 +176,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_830_M_1
 #define PCI_DEVICE_ID_INTEL_830_M_1     0x3577
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_820_0
+#define PCI_DEVICE_ID_INTEL_820_0       0x2500
+#endif
 #ifndef PCI_DEVICE_ID_INTEL_840_0
 #define PCI_DEVICE_ID_INTEL_840_0		0x1a21
 #endif
@@ -273,9 +276,13 @@
 #define I830_RDRAM_ND(x)           (((x) & 0x20) >> 5)
 #define I830_RDRAM_DDT(x)          (((x) & 0x18) >> 3)
 
+/* intel i820 registers */
+#define INTEL_I820_RDCR     0x51
+#define INTEL_I820_ERRSTS   0xc8
+
 /* intel i840 registers */
 #define INTEL_I840_MCHCFG   0x50
-#define INTEL_I840_ERRSTS	0xc8
+#define INTEL_I840_ERRSTS   0xc8
  
 /* intel i845 registers */
 #define INTEL_I845_AGPM     0x51
@@ -307,6 +314,8 @@
 #define I810_DRAM_ROW_0        0x00000001
 #define I810_DRAM_ROW_0_SDRAM  0x00000001
 
+
+
 /* VIA register */
 #define VIA_APBASE      0x10
 #define VIA_GARTCTRL    0x80
diff -Nru linux-2.4.13-ac7.clean/drivers/char/agp/agpgart_be.c linux-2.4.13-ac7_i820/drivers/char/agp/agpgart_be.c
--- linux-2.4.13-ac7.clean/drivers/char/agp/agpgart_be.c	Mon Nov  5 16:26:57 2001
+++ linux-2.4.13-ac7_i820/drivers/char/agp/agpgart_be.c	Tue Nov  6 09:59:32 2001
@@ -1427,12 +1427,45 @@
 	return 0;
 }
 
+
+static int intel_8xx_fetch_size(void)
+{
+	int i;
+	u8 temp;
+	aper_size_info_8 *values;
+
+	pci_read_config_byte(agp_bridge.dev, INTEL_APSIZE, &temp);
+	values = A_SIZE_8(agp_bridge.aperture_sizes);
+
+	for (i = 0; i < agp_bridge.num_aperture_sizes; i++) {
+		if (temp == values[i].size_value) {
+			agp_bridge.previous_size =
+			    agp_bridge.current_size = (void *) (values + i);
+			agp_bridge.aperture_size_idx = i;
+			return values[i].size;
+		}
+	}
+
+	return 0;
+}
+
 static void intel_tlbflush(agp_memory * mem)
 {
 	pci_write_config_dword(agp_bridge.dev, INTEL_AGPCTRL, 0x2200);
 	pci_write_config_dword(agp_bridge.dev, INTEL_AGPCTRL, 0x2280);
 }
 
+
+static void intel_8xx_tlbflush(agp_memory * mem)
+{
+  u32 temp;
+  pci_read_config_dword(agp_bridge.dev, INTEL_AGPCTRL, &temp);
+  pci_write_config_dword(agp_bridge.dev, INTEL_AGPCTRL, temp & ~(1 << 7));
+  pci_read_config_dword(agp_bridge.dev, INTEL_AGPCTRL, &temp);
+  pci_write_config_dword(agp_bridge.dev, INTEL_AGPCTRL, temp & (1 << 7));
+}
+
+
 static void intel_cleanup(void)
 {
 	u16 temp;
@@ -1445,6 +1478,20 @@
 			      previous_size->size_value);
 }
 
+
+static void intel_8xx_cleanup(void)
+{
+	u16 temp;
+	aper_size_info_8 *previous_size;
+
+	previous_size = A_SIZE_8(agp_bridge.previous_size);
+	pci_read_config_word(agp_bridge.dev, INTEL_NBXCFG, &temp);
+	pci_write_config_word(agp_bridge.dev, INTEL_NBXCFG, temp & ~(1 << 9));
+	pci_write_config_byte(agp_bridge.dev, INTEL_APSIZE,
+			      previous_size->size_value);
+}
+
+
 static int intel_configure(void)
 {
 	u32 temp;
@@ -1477,17 +1524,70 @@
 	return 0;
 }
 
+static void intel_820_tlbflush(agp_memory * mem)
+{
+  return;
+}
+
+static void intel_820_cleanup(void)
+{
+	u8 temp;
+	aper_size_info_8 *previous_size;
+
+	previous_size = A_SIZE_8(agp_bridge.previous_size);
+	pci_read_config_byte(agp_bridge.dev, INTEL_I820_RDCR, &temp);
+	pci_write_config_byte(agp_bridge.dev, INTEL_I820_RDCR, 
+			      temp & ~(1 << 1));
+	pci_write_config_byte(agp_bridge.dev, INTEL_APSIZE,
+			      previous_size->size_value);
+}
+
+
+static int intel_820_configure(void)
+{
+	u32 temp;
+ 	u8 temp2; 
+	aper_size_info_8 *current_size;
+
+	current_size = A_SIZE_8(agp_bridge.current_size);
+
+	/* aperture size */
+	pci_write_config_byte(agp_bridge.dev, INTEL_APSIZE,
+			      current_size->size_value); 
+
+	/* address to map to */
+	pci_read_config_dword(agp_bridge.dev, INTEL_APBASE, &temp);
+	agp_bridge.gart_bus_addr = (temp & PCI_BASE_ADDRESS_MEM_MASK);
+
+	/* attbase - aperture base */
+	pci_write_config_dword(agp_bridge.dev, INTEL_ATTBASE,
+			       agp_bridge.gatt_bus_addr); 
+
+	/* agpctrl */
+	pci_write_config_dword(agp_bridge.dev, INTEL_AGPCTRL, 0x0000); 
+
+	/* global enable aperture access */
+	/* This flag is not accessed through MCHCFG register as in */
+	/* i850 chipset. */
+	pci_read_config_byte(agp_bridge.dev, INTEL_I820_RDCR, &temp2);
+	pci_write_config_byte(agp_bridge.dev, INTEL_I820_RDCR, 
+			      temp2 | (1 << 1));
+	/* clear any possible AGP-related error conditions */
+	pci_write_config_word(agp_bridge.dev, INTEL_I820_ERRSTS, 0x001c); 
+	return 0;
+}
+
 static int intel_840_configure(void)
 {
 	u32 temp;
 	u16 temp2;
-	aper_size_info_16 *current_size;
+	aper_size_info_8 *current_size;
 
-	current_size = A_SIZE_16(agp_bridge.current_size);
+	current_size = A_SIZE_8(agp_bridge.current_size);
 
 	/* aperture size */
 	pci_write_config_byte(agp_bridge.dev, INTEL_APSIZE,
-			      (char)current_size->size_value); 
+			      current_size->size_value); 
 
 	/* address to map to */
 	pci_read_config_dword(agp_bridge.dev, INTEL_APBASE, &temp);
@@ -1512,14 +1612,14 @@
 static int intel_845_configure(void)
 {
 	u32 temp;
-	u16 temp2;
-	aper_size_info_16 *current_size;
+	u8 temp2;
+	aper_size_info_8 *current_size;
 
-	current_size = A_SIZE_16(agp_bridge.current_size);
+	current_size = A_SIZE_8(agp_bridge.current_size);
 
 	/* aperture size */
 	pci_write_config_byte(agp_bridge.dev, INTEL_APSIZE,
-			      (char)current_size->size_value); 
+			      current_size->size_value); 
 
 	/* address to map to */
 	pci_read_config_dword(agp_bridge.dev, INTEL_APBASE, &temp);
@@ -1545,13 +1645,13 @@
 {
 	u32 temp;
 	u16 temp2;
-	aper_size_info_16 *current_size;
+	aper_size_info_8 *current_size;
 
-	current_size = A_SIZE_16(agp_bridge.current_size);
+	current_size = A_SIZE_8(agp_bridge.current_size);
 
 	/* aperture size */
 	pci_write_config_byte(agp_bridge.dev, INTEL_APSIZE,
-			      (char)current_size->size_value); 
+			      current_size->size_value); 
 
 	/* address to map to */
 	pci_read_config_dword(agp_bridge.dev, INTEL_APBASE, &temp);
@@ -1577,13 +1677,13 @@
 {
 	u32 temp;
 	u16 temp2;
-	aper_size_info_16 *current_size;
+	aper_size_info_8 *current_size;
 
-	current_size = A_SIZE_16(agp_bridge.current_size);
+	current_size = A_SIZE_8(agp_bridge.current_size);
 
 	/* aperture size */
 	pci_write_config_byte(agp_bridge.dev, INTEL_APSIZE,
-			      (char)current_size->size_value);
+			      current_size->size_value);
 
 	/* address to map to */
 	pci_read_config_dword(agp_bridge.dev, INTEL_APBASE, &temp);
@@ -1623,6 +1723,17 @@
 	{0x00000017, 0}
 };
 
+static aper_size_info_8 intel_8xx_sizes[7] =
+{
+	{256, 65536, 6, 0},
+	{128, 32768, 5, 32},
+	{64, 16384, 4, 48},
+	{32, 8192, 3, 56},
+	{16, 4096, 2, 60},
+	{8, 2048, 1, 62},
+	{4, 1024, 0, 63}
+};
+
 static aper_size_info_16 intel_generic_sizes[7] =
 {
 	{256, 65536, 6, 0},
@@ -1667,19 +1778,51 @@
 	(void) pdev; /* unused */
 }
 
+
+static int __init intel_820_setup (struct pci_dev *pdev)
+{
+       agp_bridge.masks = intel_generic_masks;
+       agp_bridge.num_of_masks = 1;
+       agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
+       agp_bridge.size_type = U8_APER_SIZE;
+       agp_bridge.num_aperture_sizes = 7;
+       agp_bridge.dev_private_data = NULL;
+       agp_bridge.needs_scratch_page = FALSE;
+       agp_bridge.configure = intel_820_configure;
+       agp_bridge.fetch_size = intel_8xx_fetch_size;
+       agp_bridge.cleanup = intel_cleanup;
+       agp_bridge.tlb_flush = intel_820_tlbflush;
+       agp_bridge.mask_memory = intel_mask_memory;
+       agp_bridge.agp_enable = agp_generic_agp_enable;
+       agp_bridge.cache_flush = global_cache_flush;
+       agp_bridge.create_gatt_table = agp_generic_create_gatt_table;
+       agp_bridge.free_gatt_table = agp_generic_free_gatt_table;
+       agp_bridge.insert_memory = agp_generic_insert_memory;
+       agp_bridge.remove_memory = agp_generic_remove_memory;
+       agp_bridge.alloc_by_type = agp_generic_alloc_by_type;
+       agp_bridge.free_by_type = agp_generic_free_by_type;
+       agp_bridge.agp_alloc_page = agp_generic_alloc_page;
+       agp_bridge.agp_destroy_page = agp_generic_destroy_page;
+
+       return 0;
+
+       (void) pdev; /* unused */
+}
+
+
 static int __init intel_840_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
 	agp_bridge.num_of_masks = 1;
-	agp_bridge.aperture_sizes = (void *) intel_generic_sizes;
-	agp_bridge.size_type = U16_APER_SIZE;
+	agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
+	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
 	agp_bridge.dev_private_data = NULL;
 	agp_bridge.needs_scratch_page = FALSE;
 	agp_bridge.configure = intel_840_configure;
-	agp_bridge.fetch_size = intel_fetch_size;
-	agp_bridge.cleanup = intel_cleanup;
-	agp_bridge.tlb_flush = intel_tlbflush;
+	agp_bridge.fetch_size = intel_8xx_fetch_size;
+	agp_bridge.cleanup = intel_8xx_cleanup;
+	agp_bridge.tlb_flush = intel_8xx_tlbflush;
 	agp_bridge.mask_memory = intel_mask_memory;
 	agp_bridge.agp_enable = agp_generic_agp_enable;
 	agp_bridge.cache_flush = global_cache_flush;
@@ -1704,15 +1847,15 @@
 {
 	agp_bridge.masks = intel_generic_masks;
 	agp_bridge.num_of_masks = 1;
-	agp_bridge.aperture_sizes = (void *) intel_generic_sizes;
-	agp_bridge.size_type = U16_APER_SIZE;
+	agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
+	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
 	agp_bridge.dev_private_data = NULL;
 	agp_bridge.needs_scratch_page = FALSE;
 	agp_bridge.configure = intel_845_configure;
-	agp_bridge.fetch_size = intel_fetch_size;
-	agp_bridge.cleanup = intel_cleanup;
-	agp_bridge.tlb_flush = intel_tlbflush;
+	agp_bridge.fetch_size = intel_8xx_fetch_size;
+	agp_bridge.cleanup = intel_8xx_cleanup;
+	agp_bridge.tlb_flush = intel_8xx_tlbflush;
 	agp_bridge.mask_memory = intel_mask_memory;
 	agp_bridge.agp_enable = agp_generic_agp_enable;
 	agp_bridge.cache_flush = global_cache_flush;
@@ -1737,15 +1880,15 @@
 {
 	agp_bridge.masks = intel_generic_masks;
 	agp_bridge.num_of_masks = 1;
-	agp_bridge.aperture_sizes = (void *) intel_generic_sizes;
-	agp_bridge.size_type = U16_APER_SIZE;
+	agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
+	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
 	agp_bridge.dev_private_data = NULL;
 	agp_bridge.needs_scratch_page = FALSE;
 	agp_bridge.configure = intel_850_configure;
-	agp_bridge.fetch_size = intel_fetch_size;
-	agp_bridge.cleanup = intel_cleanup;
-	agp_bridge.tlb_flush = intel_tlbflush;
+	agp_bridge.fetch_size = intel_8xx_fetch_size;
+	agp_bridge.cleanup = intel_8xx_cleanup;
+	agp_bridge.tlb_flush = intel_8xx_tlbflush;
 	agp_bridge.mask_memory = intel_mask_memory;
 	agp_bridge.agp_enable = agp_generic_agp_enable;
 	agp_bridge.cache_flush = global_cache_flush;
@@ -1770,15 +1913,15 @@
 {
 	agp_bridge.masks = intel_generic_masks;
 	agp_bridge.num_of_masks = 1;
-	agp_bridge.aperture_sizes = (void *) intel_generic_sizes;
-	agp_bridge.size_type = U16_APER_SIZE;
+	agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
+	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
 	agp_bridge.dev_private_data = NULL;
 	agp_bridge.needs_scratch_page = FALSE;
 	agp_bridge.configure = intel_860_configure;
-	agp_bridge.fetch_size = intel_fetch_size;
-	agp_bridge.cleanup = intel_cleanup;
-	agp_bridge.tlb_flush = intel_tlbflush;
+	agp_bridge.fetch_size = intel_8xx_fetch_size;
+	agp_bridge.cleanup = intel_8xx_cleanup;
+	agp_bridge.tlb_flush = intel_8xx_tlbflush;
 	agp_bridge.mask_memory = intel_mask_memory;
 	agp_bridge.agp_enable = agp_generic_agp_enable;
 	agp_bridge.cache_flush = global_cache_flush;
@@ -3403,6 +3546,12 @@
 		"Intel",
 		"i815",
 		intel_generic_setup },
+	{ PCI_DEVICE_ID_INTEL_820_0,
+		PCI_VENDOR_ID_INTEL,
+		INTEL_I820,
+		"Intel",
+		"i820",
+		intel_820_setup },
 	{ PCI_DEVICE_ID_INTEL_830_M_0,
 		PCI_VENDOR_ID_INTEL,
 		INTEL_I830_M,
diff -Nru linux-2.4.13-ac7.clean/drivers/char/drm/drm_agpsupport.h linux-2.4.13-ac7_i820/drivers/char/drm/drm_agpsupport.h
--- linux-2.4.13-ac7.clean/drivers/char/drm/drm_agpsupport.h	Mon Nov  5 16:26:57 2001
+++ linux-2.4.13-ac7_i820/drivers/char/drm/drm_agpsupport.h	Mon Nov  5 16:19:17 2001
@@ -273,6 +273,7 @@
 
 #if LINUX_VERSION_CODE >= 0x020400
 		case INTEL_I815:	head->chipset = "Intel i815";	 break;
+	 	case INTEL_I820:	head->chipset = "Intel i820";	 break;
 		case INTEL_I840:	head->chipset = "Intel i840";    break;
 		case INTEL_I845:	head->chipset = "Intel i845";    break;
 		case INTEL_I850:	head->chipset = "Intel i850";	 break;
diff -Nru linux-2.4.13-ac7.clean/include/linux/agp_backend.h linux-2.4.13-ac7_i820/include/linux/agp_backend.h
--- linux-2.4.13-ac7.clean/include/linux/agp_backend.h	Mon Nov  5 16:27:04 2001
+++ linux-2.4.13-ac7_i820/include/linux/agp_backend.h	Mon Nov  5 16:19:58 2001
@@ -46,6 +46,7 @@
 	INTEL_GX,
 	INTEL_I810,
 	INTEL_I815,
+	INTEL_I820,
 	INTEL_I830_M,
 	INTEL_I840,
 	INTEL_I845,

--------------010304050509070708090501--

