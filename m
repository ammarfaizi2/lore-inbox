Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281194AbRKEPtz>; Mon, 5 Nov 2001 10:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281196AbRKEPto>; Mon, 5 Nov 2001 10:49:44 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:25107 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S281194AbRKEPte>;
	Mon, 5 Nov 2001 10:49:34 -0500
Message-ID: <3BE6B50A.5010806@epfl.ch>
Date: Mon, 05 Nov 2001 16:49:30 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Robert Love <rml@tech9.net>
Subject: [PATCH]agp for i820 chipset
Content-Type: multipart/mixed;
 boundary="------------030202000803000209080702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030202000803000209080702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello all.

Here is an unpdated version of the patch I posted last week that enables 
AGP support for i820 chipset. This one has been done against 2.4.13-ac7, 
_but_ not tested under this kernel. However, it works fine under 2.4.9 
Redhat's kernel (i.e. close to a 2.4.9-ac kernel I think). Xfree-4.1, 
openGL apps and Quake3 are running smoothly.

It seems to me like the 'generic' Intel agp driver used previously was 
writing over some 'reserved' bits in the 'intel_cleanup' and 
'intel_tlbflush' routines. I must admit this has not caused any problem 
on my machine so far, but this might have been luck...
Anyway, the proposed patch aims to fix these potential troublemakers. If 
anyone is willing to test it under 2.4.13-ac7, I would appreciate to 
have some feedback.

The patch against 2.4.9-x (as well as the 2.4.13-ac7 one) is available 
at the URL: http://ltswww.epfl.ch/~aspert/patches

Nicolas.

PS: As usual CC your remarks/comments/flames to me as I am not 
subscribed to the list
-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)

--------------030202000803000209080702
Content-Type: text/plain;
 name="patch-agp_i820-2.4.13-ac7"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-agp_i820-2.4.13-ac7"

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
+++ linux-2.4.13-ac7_i820/drivers/char/agp/agp.h	Mon Nov  5 16:32:44 2001
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
@@ -200,6 +203,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_810_1
 #define PCI_DEVICE_ID_INTEL_810_1       0x7121
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_820_1
+#define PCI_DEVICE_ID_INTEL_820_1       0x250f
+#endif
 #ifndef PCI_DEVICE_ID_INTEL_810_DC100_1
 #define PCI_DEVICE_ID_INTEL_810_DC100_1 0x7123
 #endif
@@ -273,6 +279,10 @@
 #define I830_RDRAM_ND(x)           (((x) & 0x20) >> 5)
 #define I830_RDRAM_DDT(x)          (((x) & 0x18) >> 3)
 
+/* intel i820 registers */
+#define INTEL_I820_RDCR     0x51
+#define INTEL_I820_ERRSTS   0xc8
+
 /* intel i840 registers */
 #define INTEL_I840_MCHCFG   0x50
 #define INTEL_I840_ERRSTS	0xc8
@@ -307,6 +317,8 @@
 #define I810_DRAM_ROW_0        0x00000001
 #define I810_DRAM_ROW_0_SDRAM  0x00000001
 
+
+
 /* VIA register */
 #define VIA_APBASE      0x10
 #define VIA_GARTCTRL    0x80
diff -Nru linux-2.4.13-ac7.clean/drivers/char/agp/agpgart_be.c linux-2.4.13-ac7_i820/drivers/char/agp/agpgart_be.c
--- linux-2.4.13-ac7.clean/drivers/char/agp/agpgart_be.c	Mon Nov  5 16:26:57 2001
+++ linux-2.4.13-ac7_i820/drivers/char/agp/agpgart_be.c	Mon Nov  5 16:18:04 2001
@@ -1477,6 +1477,79 @@
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
+	aper_size_info_16 *previous_size;
+
+	previous_size = A_SIZE_16(agp_bridge.previous_size);
+	pci_read_config_byte(agp_bridge.dev, INTEL_I820_RDCR, &temp);
+	pci_write_config_byte(agp_bridge.dev, INTEL_I820_RDCR, 
+			      temp & ~(1 << 1));
+	pci_write_config_byte(agp_bridge.dev, INTEL_APSIZE,
+			      (u8)(previous_size->size_value));
+}
+
+static int intel_820_fetch_size(void)
+{
+	int i;
+	u8 temp;
+	aper_size_info_16 *values;
+
+	pci_read_config_byte(agp_bridge.dev, INTEL_APSIZE, &temp);
+	values = A_SIZE_16(agp_bridge.aperture_sizes);
+
+	for (i = 0; i < agp_bridge.num_aperture_sizes; i++) {
+		if (temp == (u8)(values[i].size_value)) {
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
+static int intel_820_configure(void)
+{
+	u32 temp;
+ 	u8 temp2; 
+	aper_size_info_16 *current_size;
+
+	current_size = A_SIZE_16(agp_bridge.current_size);
+
+	/* aperture size */
+	pci_write_config_byte(agp_bridge.dev, INTEL_APSIZE,
+			      (char)current_size->size_value); 
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
@@ -1667,6 +1740,38 @@
 	(void) pdev; /* unused */
 }
 
+
+static int __init intel_820_setup (struct pci_dev *pdev)
+{
+       agp_bridge.masks = intel_generic_masks;
+       agp_bridge.num_of_masks = 1;
+       agp_bridge.aperture_sizes = (void *) intel_generic_sizes;
+       agp_bridge.size_type = U16_APER_SIZE;
+       agp_bridge.num_aperture_sizes = 7;
+       agp_bridge.dev_private_data = NULL;
+       agp_bridge.needs_scratch_page = FALSE;
+       agp_bridge.configure = intel_820_configure;
+       agp_bridge.fetch_size = intel_820_fetch_size;
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
@@ -3403,6 +3508,12 @@
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

--------------030202000803000209080702--

