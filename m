Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267632AbUHEK52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267632AbUHEK52 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 06:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267636AbUHEK51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 06:57:27 -0400
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:52107 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S267632AbUHEK4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 06:56:03 -0400
Date: Thu, 5 Aug 2004 12:52:33 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: rivafb: kill riva_chip_info and riva_chips
Message-ID: <20040805105233.GA3509@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
attached patch (against 2.6.8-pre3) kills riva_chips_info and riva_chips
and replaces the NV_ARCH_ determination by a less error prone one. We
better use the driver_data for something more interesting later. Please
apply.
Cheers,
 -- Guido

Signed-of-by: Guido Guenther <agx@sigxcpu.org>

--- ../linux-2.6.8-rc3.orig/drivers/video/riva/fbdev.c	2004-08-04 14:27:12.000000000 +0200
+++ drivers/video/riva/fbdev.c	2004-08-05 10:04:17.271516528 +0200
@@ -111,177 +111,87 @@
  *
  * ------------------------------------------------------------------------- */
 
-enum riva_chips {
-	CH_RIVA_128 = 0,
-	CH_RIVA_TNT,
-	CH_RIVA_TNT2,
-	CH_RIVA_UTNT2,
-	CH_RIVA_VTNT2,
-	CH_RIVA_UVTNT2,
-	CH_RIVA_ITNT2,
-	CH_GEFORCE_SDR,
-	CH_GEFORCE_DDR,
-	CH_QUADRO,
-	CH_GEFORCE2_MX,
-	CH_GEFORCE2_MX2,
-	CH_GEFORCE2_GO,
-	CH_QUADRO2_MXR,
-	CH_GEFORCE2_GTS,
-	CH_GEFORCE2_GTS2,
-	CH_GEFORCE2_ULTRA,
-	CH_QUADRO2_PRO,
-	CH_GEFORCE4_MX_460,
-	CH_GEFORCE4_MX_440,
-	CH_GEFORCE4_MX_420,
-	CH_GEFORCE4_440_GO,
-	CH_GEFORCE4_420_GO,
-	CH_GEFORCE4_420_GO_M32,
-	CH_QUADRO4_500XGL,
-	CH_GEFORCE4_440_GO_M64,
-	CH_QUADRO4_200,
-	CH_QUADRO4_550XGL,
-	CH_QUADRO4_500_GOGL,
-	CH_IGEFORCE2,
-	CH_GEFORCE3,
-	CH_GEFORCE3_1,
-	CH_GEFORCE3_2,
-	CH_QUADRO_DDC,
-	CH_GEFORCE4_TI_4600,
-	CH_GEFORCE4_TI_4400,
-	CH_GEFORCE4_TI_4200,
-	CH_QUADRO4_900XGL,
-	CH_QUADRO4_750XGL,
-	CH_QUADRO4_700XGL
-};
-
-/* directly indexed by riva_chips enum, above */
-static struct riva_chip_info {
-	const char *name;
-	unsigned arch_rev;
-} riva_chip_info[] __initdata = {
-	{ "RIVA-128", NV_ARCH_03 },
-	{ "RIVA-TNT", NV_ARCH_04 },
-	{ "RIVA-TNT2", NV_ARCH_04 },
-	{ "RIVA-UTNT2", NV_ARCH_04 },
-	{ "RIVA-VTNT2", NV_ARCH_04 },
-	{ "RIVA-UVTNT2", NV_ARCH_04 },
-	{ "RIVA-ITNT2", NV_ARCH_04 },
-	{ "GeForce-SDR", NV_ARCH_10 },
-	{ "GeForce-DDR", NV_ARCH_10 },
-	{ "Quadro", NV_ARCH_10 },
-	{ "GeForce2-MX", NV_ARCH_10 },
-	{ "GeForce2-MX", NV_ARCH_10 },
-	{ "GeForce2-GO", NV_ARCH_10 },
-	{ "Quadro2-MXR", NV_ARCH_10 },
-	{ "GeForce2-GTS", NV_ARCH_10 },
-	{ "GeForce2-GTS", NV_ARCH_10 },
-	{ "GeForce2-ULTRA", NV_ARCH_10 },
-	{ "Quadro2-PRO", NV_ARCH_10 },
-	{ "GeForce4-MX-460", NV_ARCH_10 },
-	{ "GeForce4-MX-440", NV_ARCH_10 },
-	{ "GeForce4-MX-420", NV_ARCH_10 },
-	{ "GeForce4-440-GO", NV_ARCH_10 },
-	{ "GeForce4-420-GO", NV_ARCH_10 },
-	{ "GeForce4-420-GO-M32", NV_ARCH_10 },
-	{ "Quadro4-500-XGL", NV_ARCH_10 },
-	{ "GeForce4-440-GO-M64", NV_ARCH_10 },
-	{ "Quadro4-200", NV_ARCH_10 },
-	{ "Quadro4-550-XGL", NV_ARCH_10 },
-	{ "Quadro4-500-GOGL", NV_ARCH_10 },
-	{ "GeForce2", NV_ARCH_10 },
-	{ "GeForce3", NV_ARCH_20 }, 
-	{ "GeForce3 Ti 200", NV_ARCH_20 },
-	{ "GeForce3 Ti 500", NV_ARCH_20 },
-	{ "Quadro DDC", NV_ARCH_20 },
-	{ "GeForce4 Ti 4600", NV_ARCH_20 },
-	{ "GeForce4 Ti 4400", NV_ARCH_20 },
-	{ "GeForce4 Ti 4200", NV_ARCH_20 },
-	{ "Quadro4-900-XGL", NV_ARCH_20 },
-	{ "Quadro4-750-XGL", NV_ARCH_20 },
-	{ "Quadro4-700-XGL", NV_ARCH_20 }
-};
-
 static struct pci_device_id rivafb_pci_tbl[] = {
 	{ PCI_VENDOR_ID_NVIDIA_SGS, PCI_DEVICE_ID_NVIDIA_SGS_RIVA128,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_RIVA_128 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TNT,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_RIVA_TNT },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TNT2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_RIVA_TNT2 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_UTNT2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_RIVA_UTNT2 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_VTNT2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_RIVA_VTNT2 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_UVTNT2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_RIVA_VTNT2 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_ITNT2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_RIVA_ITNT2 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_SDR,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE_SDR },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_DDR,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE_DDR },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_MX,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_MX },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_MX2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_MX2 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_GO,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_GO },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO2_MXR,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO2_MXR },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_GTS,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_GTS },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_GTS2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_GTS2 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_ULTRA,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_ULTRA },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO2_PRO,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO2_PRO },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_460,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_MX_460 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_440,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_MX_440 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_420,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_MX_420 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_440_GO,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_440_GO },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_420_GO,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_420_GO },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_420_GO_M32,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_420_GO_M32 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_500XGL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_500XGL },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_440_GO_M64,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_440_GO_M64 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_200,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_200 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_550XGL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_550XGL },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_500_GOGL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_500_GOGL },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_IGEFORCE2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_IGEFORCE2 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE3,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE3 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE3_1,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE3_1 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE3_2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE3_2 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO_DDC,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO_DDC },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4600,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_TI_4600 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4400,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_TI_4400 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4200,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_TI_4200 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
  	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_900XGL },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_750XGL },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_700XGL },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, rivafb_pci_tbl);
@@ -304,7 +214,6 @@
 static int  strictmode       = 0;
 
 static struct fb_fix_screeninfo rivafb_fix = {
-	.id		= "nVidia",
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.xpanstep	= 1,
 	.ypanstep	= 1,
@@ -1904,6 +1813,44 @@
 		par->FlatPanel = 1;
 }
 
+static U032 riva_get_arch(struct pci_dev *pd)
+{
+    	U032 arch=0;
+
+	switch (pd->device & 0x0ff0) {
+		case 0x0100:   /* GeForce 256 */
+		case 0x0110:   /* GeForce2 MX */
+		case 0x0150:   /* GeForce2 */
+		case 0x0170:   /* GeForce4 MX */
+		case 0x0180:   /* GeForce4 MX (8x AGP) */
+		case 0x01A0:   /* nForce */
+		case 0x01F0:   /* nForce2 */
+		     arch =  NV_ARCH_10;
+		     break;
+		case 0x0200:   /* GeForce3 */
+		case 0x0250:   /* GeForce4 Ti */
+		case 0x0280:   /* GeForce4 Ti (8x AGP) */
+		     arch =  NV_ARCH_20;
+		     break;
+		case 0x0300:   /* GeForceFX 5800 */
+		case 0x0310:   /* GeForceFX 5600 */
+		case 0x0320:   /* GeForceFX 5200 */
+		case 0x0330:   /* GeForceFX 5900 */
+		case 0x0340:   /* GeForceFX 5700 */
+		     arch =  NV_ARCH_30;
+		     break;
+		case 0x0020:   /* TNT, TNT2 */
+		     arch =  NV_ARCH_04;
+		     break;
+		case 0x0010:   /* Riva128 */
+		     arch =  NV_ARCH_03;
+		     break;
+		default:   /* unknown architecture */
+		     break;
+	}
+	return arch;
+}
+
 /* ------------------------------------------------------------------------- *
  *
  * PCI bus
@@ -1913,13 +1860,11 @@
 static int __devinit rivafb_probe(struct pci_dev *pd,
 			     	const struct pci_device_id *ent)
 {
-	struct riva_chip_info *rci = &riva_chip_info[ent->driver_data];
 	struct riva_par *default_par;
 	struct fb_info *info;
 
 	NVTRACE_ENTER();
 	assert(pd != NULL);
-	assert(rci != NULL);
 
 	info = kmalloc(sizeof(struct fb_info), GFP_KERNEL);
 	if (!info)
@@ -1948,11 +1893,25 @@
 		goto err_out_request;
 	}
 
-	strcat(rivafb_fix.id, rci->name);
-	default_par->riva.Architecture = rci->arch_rev;
+	default_par->riva.Architecture = riva_get_arch(pd);
 
 	default_par->Chipset = (pd->vendor << 16) | pd->device;
 	printk(KERN_INFO PFX "nVidia device/chipset %X\n",default_par->Chipset);
+#ifdef CONFIG_PCI_NAMES
+	printk(KERN_INFO PFX "%s\n", pd->pretty_name);
+#endif
+
+	if(default_par->riva.Architecture == 0) {
+		printk(KERN_ERR PFX "unknown NV_ARCH\n");
+		goto err_out_kfree1;
+	}
+	if(default_par->riva.Architecture == NV_ARCH_10 ||
+	   default_par->riva.Architecture == NV_ARCH_20 ||
+	   default_par->riva.Architecture == NV_ARCH_30) {
+		sprintf(rivafb_fix.id, "NV%x", (pd->device & 0x0ff0) >> 4);
+	} else {
+		sprintf(rivafb_fix.id, "NV%x", default_par->riva.Architecture);
+	}
 	
 	default_par->FlatPanel = flatpanel;
 	if (flatpanel == 1)
@@ -2057,10 +2016,9 @@
 	pci_set_drvdata(pd, info);
 
 	printk(KERN_INFO PFX
-		"PCI nVidia NV%x framebuffer ver %s (%s, %dMB @ 0x%lX)\n",
-		default_par->riva.Architecture,
-		RIVAFB_VERSION,
+		"PCI nVidia %s framebuffer ver %s (%dMB @ 0x%lX)\n",
 		info->fix.id,
+		RIVAFB_VERSION,
 		info->fix.smem_len / (1024 * 1024),
 		info->fix.smem_start);
 #ifdef CONFIG_PMAC_BACKLIGHT
--- ../linux-2.6.8-rc3.orig/drivers/video/riva/riva_hw.h	2004-06-16 07:20:03.000000000 +0200
+++ drivers/video/riva/riva_hw.h	2004-08-04 18:26:15.000000000 +0200
@@ -89,12 +89,14 @@
 #define VGA_RD08(p,i)   NV_RD08(p,i)
 
 /*
- * Define supported architectures.
+ * Define different architectures.
  */
 #define NV_ARCH_03  0x03
 #define NV_ARCH_04  0x04
 #define NV_ARCH_10  0x10
 #define NV_ARCH_20  0x20
+#define NV_ARCH_30  0x30
+#define NV_ARCH_40  0x40
 
 /***************************************************************************\
 *                                                                           *
