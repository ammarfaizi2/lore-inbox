Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281652AbRKZMoU>; Mon, 26 Nov 2001 07:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281651AbRKZMoA>; Mon, 26 Nov 2001 07:44:00 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:65035 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S281650AbRKZMnz>;
	Mon, 26 Nov 2001 07:43:55 -0500
Message-ID: <3C023909.4010202@epfl.ch>
Date: Mon, 26 Nov 2001 13:43:53 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Didier.Moens@dmb001.rug.ac.be, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]Re: [Fwd: Re: OOPS in agpgart (2.4.13, 2.4.15pre7)]
In-Reply-To: <linux.kernel.3C021570.4000603@dmb.rug.ac.be>
Content-Type: multipart/mixed;
 boundary="------------030003030703020502060409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030003030703020502060409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello again


Here is a patch that _might_ improve things wrt. agp support for i830 
chipsets. I do not have a i830 box at hand, so it has not been tested 
(well, it compiles ok. ;-). If you feel like crashing your PC once more, 
try the patch (against 2.4.15) and tell me whether things became 
better/worse.
I assumed that the i830mg without secondary device was working in a way 
that is similar to other Intel chipsets.

Good luck :-)

Nicolas.
-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)

--------------030003030703020502060409
Content-Type: text/plain;
 name="patch-agp_i830mg-2.4.15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-agp_i830mg-2.4.15"

diff -Nru linux-2.4.15.clean/drivers/char/agp/agp.h linux-2.4.15.dirty/drivers/char/agp/agp.h
--- linux-2.4.15.clean/drivers/char/agp/agp.h	Fri Nov  9 23:01:21 2001
+++ linux-2.4.15.dirty/drivers/char/agp/agp.h	Mon Nov 26 13:25:56 2001
@@ -276,6 +276,8 @@
 #define I830_RDRAM_ND(x)           (((x) & 0x20) >> 5)
 #define I830_RDRAM_DDT(x)          (((x) & 0x18) >> 3)
 
+#define INTEL_I830_ERRSTS          0x92
+
 /* intel i820 registers */
 #define INTEL_I820_RDCR     0x51
 #define INTEL_I820_ERRSTS   0xc8
diff -Nru linux-2.4.15.clean/drivers/char/agp/agpgart_be.c linux-2.4.15.dirty/drivers/char/agp/agpgart_be.c
--- linux-2.4.15.clean/drivers/char/agp/agpgart_be.c	Fri Nov 16 19:11:22 2001
+++ linux-2.4.15.dirty/drivers/char/agp/agpgart_be.c	Mon Nov 26 13:35:29 2001
@@ -1705,6 +1705,38 @@
 	return 0;
 }
 
+static int intel_830mg_configure(void)
+{
+	u32 temp;
+	u16 temp2;
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
+	/* gmch */
+	pci_read_config_word(agp_bridge.dev, INTEL_NBXCFG, &temp2);
+	pci_write_config_word(agp_bridge.dev, INTEL_NBXCFG,
+			      temp2 | (1 << 9));
+	/* clear any possible AGP-related error conditions */
+	pci_write_config_word(agp_bridge.dev, INTEL_I830_ERRSTS, 0x1c);
+	return 0;
+}
+
 static unsigned long intel_mask_memory(unsigned long addr, int type)
 {
 	/* Memory type is ignored */
@@ -1745,6 +1777,14 @@
 	{4, 1024, 0, 63}
 };
 
+static aper_size_info_8 intel_830mg_sizes[4] = 
+{
+  {256, 65536, 6, 0},
+  {128, 32768, 5, 32},
+  {64, 16384, 4, 48},
+  {32, 8192, 3, 56}
+};
+
 static int __init intel_generic_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
@@ -1809,6 +1849,35 @@
        (void) pdev; /* unused */
 }
 
+static int __init intel_830mg_setup (struct pci_dev *pdev)
+{
+       agp_bridge.masks = intel_generic_masks;
+       agp_bridge.num_of_masks = 1;
+       agp_bridge.aperture_sizes = (void *) intel_830mg_sizes;
+       agp_bridge.size_type = U8_APER_SIZE;
+       agp_bridge.num_aperture_sizes = 4;
+       agp_bridge.dev_private_data = NULL;
+       agp_bridge.needs_scratch_page = FALSE;
+       agp_bridge.configure = intel_830mg_configure;
+       agp_bridge.fetch_size = intel_8xx_fetch_size;
+       agp_bridge.cleanup = intel_8xx_cleanup;
+       agp_bridge.tlb_flush = intel_8xx_tlbflush;
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
 
 static int __init intel_840_setup (struct pci_dev *pdev)
 {
@@ -3886,11 +3955,13 @@
 			}
 
 			if (i810_dev == NULL) {
-				printk(KERN_ERR PFX "Detected an "
+				printk(KERN_INFO PFX "Detected an "
 					   "Intel 830M, but could not find the"
-					   " secondary device.\n");
-				agp_bridge.type = NOT_SUPPORTED;
-				return -ENODEV;
+ 				           " secondary device.\n");
+				printk(KERN_INFO PFX "Trying the "
+					   "Intel 830MG stuff\n");
+				agp_bridge.type = INTEL_I830_M;
+				return intel_830mg_setup(dev);
 			}
 			printk(KERN_INFO PFX "Detected an Intel "
 				   "830M Chipset.\n");

--------------030003030703020502060409--

