Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278494AbRJ3Wtf>; Tue, 30 Oct 2001 17:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278521AbRJ3WtS>; Tue, 30 Oct 2001 17:49:18 -0500
Received: from trifle.nips.ac.jp ([133.48.76.39]:56205 "HELO trifle.nips.ac.jp")
	by vger.kernel.org with SMTP id <S278514AbRJ3WtC>;
	Tue, 30 Oct 2001 17:49:02 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Intel 845 support for agpgart
X-Mailer: Mew version 1.94.2 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Wed_Oct_31_07:49:00_2001_483)--"
Content-Transfer-Encoding: 7bit
Message-Id: <20011031074918B.shy@trifle.nips.ac.jp>
Date: Wed, 31 Oct 2001 07:49:18 +0900
From: Shyouzou Sugitani <shy@trifle.nips.ac.jp>
X-Dispatcher: imput version 20000414(IM141)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Next_Part(Wed_Oct_31_07:49:00_2001_483)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,
      
this patch for 2.4.14-pre5 adds support for the Intel i845 chipset to
the agpgart module.
It seems to work fine on my ASUS P4B with Matrox G450.

--
Regards,
Shyouzou Sugitani <shy@debian.or.jp>

----Next_Part(Wed_Oct_31_07:49:00_2001_483)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="agp_i845.diff"

--- linux/include/linux/agp_backend.h.dist	Wed Oct 31 03:02:41 2001
+++ linux/include/linux/agp_backend.h	Wed Oct 31 03:03:00 2001
@@ -48,6 +48,7 @@
 	INTEL_I815,
 	INTEL_I830_M,
 	INTEL_I840,
+	INTEL_I845,
 	INTEL_I850,
 	VIA_GENERIC,
 	VIA_VP3,
--- linux/drivers/char/agp/agp.h.dist	Wed Oct 31 02:58:43 2001
+++ linux/drivers/char/agp/agp.h	Wed Oct 31 02:59:31 2001
@@ -173,6 +173,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_840_0
 #define PCI_DEVICE_ID_INTEL_840_0		0x1a21
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_845_0
+#define PCI_DEVICE_ID_INTEL_845_0     0x1a30
+#endif
 #ifndef PCI_DEVICE_ID_INTEL_850_0
 #define PCI_DEVICE_ID_INTEL_850_0     0x2530
 #endif
@@ -254,6 +257,10 @@
 /* intel i840 registers */
 #define INTEL_I840_MCHCFG   0x50
 #define INTEL_I840_ERRSTS	0xc8
+
+/* intel i845 registers */
+#define INTEL_I845_MCHCFG   0x51
+#define INTEL_I845_ERRSTS   0xc8
 
 /* intel i850 registers */
 #define INTEL_I850_MCHCFG   0x50
--- linux/drivers/char/agp/agpgart_be.c.dist	Wed Oct 31 02:59:46 2001
+++ linux/drivers/char/agp/agpgart_be.c	Wed Oct 31 03:02:26 2001
@@ -387,7 +387,7 @@
 /* 
  * Driver routines - start
  * Currently this module supports the following chipsets:
- * i810, i815, 440lx, 440bx, 440gx, i840, i850, via vp3, via mvp3,
+ * i810, i815, 440lx, 440bx, 440gx, i840, i845, i850, via vp3, via mvp3,
  * via kx133, via kt133, amd irongate, amd 761, amd 762, ALi M1541,
  * and generic support for the SiS chipsets.
  */
@@ -1504,6 +1504,38 @@
 	return 0;
 }
 
+static int intel_845_configure(void)
+{
+	u32 temp;
+	u8 temp2;
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
+	/* mcgcfg */
+	pci_read_config_byte(agp_bridge.dev, INTEL_I845_MCHCFG, &temp2);
+	pci_write_config_byte(agp_bridge.dev, INTEL_I845_MCHCFG,
+			      temp2 | (1 << 1));
+	/* clear any possible AGP-related error conditions */
+	pci_write_config_word(agp_bridge.dev, INTEL_I845_ERRSTS, 0x001c); 
+	return 0;
+}
+
 static int intel_850_configure(void)
 {
 	u32 temp;
@@ -1631,6 +1663,39 @@
 	(void) pdev; /* unused */
 }
 
+static int __init intel_845_setup (struct pci_dev *pdev)
+{
+	agp_bridge.masks = intel_generic_masks;
+	agp_bridge.num_of_masks = 1;
+	agp_bridge.aperture_sizes = (void *) intel_generic_sizes;
+	agp_bridge.size_type = U16_APER_SIZE;
+	agp_bridge.num_aperture_sizes = 7;
+	agp_bridge.dev_private_data = NULL;
+	agp_bridge.needs_scratch_page = FALSE;
+	agp_bridge.configure = intel_845_configure;
+	agp_bridge.fetch_size = intel_fetch_size;
+	agp_bridge.cleanup = intel_cleanup;
+	agp_bridge.tlb_flush = intel_tlbflush;
+	agp_bridge.mask_memory = intel_mask_memory;
+	agp_bridge.agp_enable = agp_generic_agp_enable;
+	agp_bridge.cache_flush = global_cache_flush;
+	agp_bridge.create_gatt_table = agp_generic_create_gatt_table;
+	agp_bridge.free_gatt_table = agp_generic_free_gatt_table;
+	agp_bridge.insert_memory = agp_generic_insert_memory;
+	agp_bridge.remove_memory = agp_generic_remove_memory;
+	agp_bridge.alloc_by_type = agp_generic_alloc_by_type;
+	agp_bridge.free_by_type = agp_generic_free_by_type;
+	agp_bridge.agp_alloc_page = agp_generic_alloc_page;
+	agp_bridge.agp_destroy_page = agp_generic_destroy_page;
+	agp_bridge.suspend = agp_generic_suspend;
+	agp_bridge.resume = agp_generic_resume;
+	agp_bridge.cant_use_aperture = 0;
+
+	return 0;
+	
+	(void) pdev; /* unused */
+}
+
 static int __init intel_850_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
@@ -3272,6 +3337,12 @@
 		"Intel",
 		"i840",
 		intel_840_setup },
+	{ PCI_DEVICE_ID_INTEL_845_0,
+	        PCI_VENDOR_ID_INTEL,
+	        INTEL_I845,
+	        "Intel",
+	        "i845",
+	        intel_845_setup },
 	{ PCI_DEVICE_ID_INTEL_850_0,
 	        PCI_VENDOR_ID_INTEL,
 	        INTEL_I850,
--- linux/drivers/char/Config.in.dist	Wed Oct 31 02:58:18 2001
+++ linux/drivers/char/Config.in	Wed Oct 31 02:58:30 2001
@@ -206,7 +206,7 @@
 
 dep_tristate '/dev/agpgart (AGP Support)' CONFIG_AGP $CONFIG_DRM_AGP
 if [ "$CONFIG_AGP" != "n" ]; then
-   bool '  Intel 440LX/BX/GX and I815/I830M/I840/I850 support' CONFIG_AGP_INTEL
+   bool '  Intel 440LX/BX/GX and I815/I830M/I840/I845/I850 support' CONFIG_AGP_INTEL
    bool '  Intel I810/I815/I830M (on-board) support' CONFIG_AGP_I810
    bool '  VIA chipset support' CONFIG_AGP_VIA
    bool '  AMD Irongate, 761, and 762 support' CONFIG_AGP_AMD
--- linux/Documentation/Configure.help.dist	Wed Oct 31 02:57:18 2001
+++ linux/Documentation/Configure.help	Wed Oct 31 02:58:03 2001
@@ -2629,10 +2629,10 @@
   module, say M here and read Documentation/modules.txt. The module
   will be called agpgart.o.
 
-Intel 440LX/BX/GX/815/830M/840/850 support
+Intel 440LX/BX/GX/815/830M/840/845/850 support
 CONFIG_AGP_INTEL
   This option gives you AGP support for the GLX component of the
-  XFree86 4.x on Intel 440LX/BX/GX, 815, 830M, 840 and 850 chipsets.
+  XFree86 4.x on Intel 440LX/BX/GX, 815, 830M, 840, 845 and 850 chipsets.
 
   For the moment, you should probably say N, unless you want to test
   the GLX component for XFree86 3.3.6, which can be downloaded from

----Next_Part(Wed_Oct_31_07:49:00_2001_483)----
