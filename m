Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282893AbRK0KFZ>; Tue, 27 Nov 2001 05:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282892AbRK0KFQ>; Tue, 27 Nov 2001 05:05:16 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:37648 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S282071AbRK0KFJ>;
	Tue, 27 Nov 2001 05:05:09 -0500
Message-ID: <3C036553.3040505@epfl.ch>
Date: Tue, 27 Nov 2001 11:05:07 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Didier Moens <Didier.Moens@dmb001.rug.ac.be>
CC: Abraham vd Merwe <abraham@2d3d.co.za>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        skraw@ithnet.com
Subject: Re: [Fwd: Re: OOPS in agpgart (2.4.13, 2.4.15pre7)]
In-Reply-To: <linux.kernel.3C021570.4000603@dmb.rug.ac.be> <3C022BB4.7080707@epfl.ch> <1006808870.817.0.camel@phantasy> <3C02BF41.1010303@xs4all.be> <20011127101148.C5778@crystal.2d3d.co.za> <3C034CAE.2090103@dmb.rug.ac.be> <20011127111022.B881@crystal.2d3d.co.za> <3C036245.6080105@dmb.rug.ac.be>
Content-Type: multipart/mixed;
 boundary="------------060608040809090101080106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060608040809090101080106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


> 
> 
> To sum up : this is an IBM A30p, with an "external" Radeon Mobility LY 
> (32 MB), and an 830MP instead of an 830M. The 830MP is common for both 
> IBM A30 and A30p models.
> 
> 

OK ! so you _do_ have an external graphic card (that's what looked unclear to me), 

for which AGP should work in the same way it does for other Intel chipsets...

So why not trying the little patch I attach below, which should make 
your stuff work, without breaking too much the i830 support for on-board 
adapters... The patch is for 2.4.16, but is likely to be applied easily 
on another recent kernel. Keep me informed...

Best regards
-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)


--------------060608040809090101080106
Content-Type: text/plain;
 name="patch-agp_i830mp-2.4.16"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-agp_i830mp-2.4.16"

diff -Nru linux-2.4.16.clean/drivers/char/agp/agp.h linux-2.4.16.dirty/drivers/char/agp/agp.h
--- linux-2.4.16.clean/drivers/char/agp/agp.h	Fri Nov  9 23:01:21 2001
+++ linux-2.4.16.dirty/drivers/char/agp/agp.h	Mon Nov 26 13:25:56 2001
@@ -276,6 +276,8 @@
 #define I830_RDRAM_ND(x)           (((x) & 0x20) >> 5)
 #define I830_RDRAM_DDT(x)          (((x) & 0x18) >> 3)
 
+#define INTEL_I830_ERRSTS          0x92
+
 /* intel i820 registers */
 #define INTEL_I820_RDCR     0x51
 #define INTEL_I820_ERRSTS   0xc8
diff -Nru linux-2.4.16.clean/drivers/char/agp/agpgart_be.c linux-2.4.16.dirty/drivers/char/agp/agpgart_be.c
--- linux-2.4.16.clean/drivers/char/agp/agpgart_be.c	Fri Nov 16 19:11:22 2001
+++ linux-2.4.16.dirty/drivers/char/agp/agpgart_be.c	Tue Nov 27 11:00:39 2001
@@ -1705,6 +1705,38 @@
 	return 0;
 }
 
+static int intel_830mp_configure(void)
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
 
+static aper_size_info_8 intel_830mp_sizes[4] = 
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
 
+static int __init intel_830mp_setup (struct pci_dev *pdev)
+{
+       agp_bridge.masks = intel_generic_masks;
+       agp_bridge.num_of_masks = 1;
+       agp_bridge.aperture_sizes = (void *) intel_830mp_sizes;
+       agp_bridge.size_type = U8_APER_SIZE;
+       agp_bridge.num_aperture_sizes = 4;
+       agp_bridge.dev_private_data = NULL;
+       agp_bridge.needs_scratch_page = FALSE;
+       agp_bridge.configure = intel_830mp_configure;
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
@@ -3557,7 +3626,7 @@
 		INTEL_I830_M,
 		"Intel",
 		"i830M",
-		intel_generic_setup },
+		intel_830mp_setup },
 	{ PCI_DEVICE_ID_INTEL_840_0,
 		PCI_VENDOR_ID_INTEL,
 		INTEL_I840,
@@ -3879,18 +3948,20 @@
 			i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
 									   PCI_DEVICE_ID_INTEL_830_M_1,
 									   NULL);
-			if(PCI_FUNC(i810_dev->devfn) != 0) {
+			if(i810_dev && PCI_FUNC(i810_dev->devfn) != 0) {
 				i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
 										   PCI_DEVICE_ID_INTEL_830_M_1,
 										   i810_dev);
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
+					   "Intel 830MP stuff\n");
+				agp_bridge.type = INTEL_I830_M;
+				break;
 			}
 			printk(KERN_INFO PFX "Detected an Intel "
 				   "830M Chipset.\n");

--------------060608040809090101080106--

