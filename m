Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267647AbUHFNlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267647AbUHFNlb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUHFNlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:41:31 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:61331 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S267647AbUHFNkx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:40:53 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Guido Guenther <agx@sigxcpu.org>
Subject: Re: rivafb: kill riva_chip_info and riva_chips
Date: Fri, 6 Aug 2004 21:39:40 +0800
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408062139.41060.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Guido Guenther <agx@sigxcpu.org> wrote:

> Hi,
> attached patch (against 2.6.8-pre3) kills
> riva_chips_info and riva_chips
> and replaces the NV_ARCH_ determination by a less
> error prone one. We
> better use the driver_data for something more
> interesting later. Please
> apply.

Nice!

Just a few changes:

1. modified patch so it's in -p1 form 
2. killed compile warning when CONFIG_FB_RIVA_I2C is not set
3. changed U032 to u32 in riva_get_arch()

Tony

Signed-off-by: Guido Guenther <agx@sigxcpu.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

diff -uprN linux-2.6.8-rc3-mm1-orig/drivers/video/riva/fbdev.c linux-2.6.8-rc3-mm1/drivers/video/riva/fbdev.c
--- linux-2.6.8-rc3-mm1-orig/drivers/video/riva/fbdev.c	2004-08-02 23:22:40.000000000 +0800
+++ linux-2.6.8-rc3-mm1/drivers/video/riva/fbdev.c	2004-08-06 21:23:30.809363264 +0800
@@ -111,177 +111,87 @@ static int rivafb_blank(int blank, struc
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
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TNT,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_RIVA_TNT },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TNT2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_RIVA_TNT2 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_UTNT2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_RIVA_UTNT2 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_VTNT2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_RIVA_VTNT2 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_UVTNT2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_RIVA_VTNT2 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_ITNT2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_RIVA_ITNT2 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_SDR,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE_SDR },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_DDR,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE_DDR },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_MX,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_MX },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_MX2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_MX2 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_GO,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_GO },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO2_MXR,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO2_MXR },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_GTS,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_GTS },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_GTS2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_GTS2 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_ULTRA,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_ULTRA },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO2_PRO,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO2_PRO },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_460,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_MX_460 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_440,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_MX_440 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_420,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_MX_420 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_440_GO,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_440_GO },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_420_GO,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_420_GO },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_420_GO_M32,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_420_GO_M32 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_500XGL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_500XGL },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_440_GO_M64,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_440_GO_M64 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_200,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_200 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_550XGL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_550XGL },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_500_GOGL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_500_GOGL },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_IGEFORCE2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_IGEFORCE2 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE3,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE3 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE3_1,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE3_1 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE3_2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE3_2 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO_DDC,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO_DDC },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4600,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_TI_4600 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4400,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_TI_4400 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4200,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_TI_4200 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
  	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_900XGL },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_750XGL },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_700XGL },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, rivafb_pci_tbl);
@@ -304,7 +214,6 @@ static char *mode_option __initdata = NU
 static int  strictmode       = 0;
 
 static struct fb_fix_screeninfo rivafb_fix = {
-	.id		= "nVidia",
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.xpanstep	= 1,
 	.ypanstep	= 1,
@@ -1831,6 +1740,26 @@ static int riva_get_EDID_OF(struct fb_in
 }
 #endif /* CONFIG_PPC_OF */
 
+#ifdef CONFIG_FB_RIVA_I2C
+static int riva_get_EDID_i2c(struct fb_info *info)
+{
+	struct riva_par *par = (struct riva_par *) info->par;
+	int i;
+
+	NVTRACE_ENTER();
+	riva_create_i2c_busses(par);
+	for (i = par->bus; i >= 1; i--) {
+		riva_probe_i2c_connector(par, i, &par->EDID);
+		if (par->EDID) {
+			printk("rivafb: Found EDID Block from BUS %i\n", i);
+			break;
+		}
+	}
+	NVTRACE_LEAVE();
+	return (par->EDID) ? 1 : 0;
+}
+#endif /* CONFIG_FB_RIVA_I2C */
+
 static void riva_update_default_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	struct fb_monspecs *specs = &info->monspecs;
@@ -1867,26 +1796,13 @@ static void riva_update_default_var(stru
 
 static void riva_get_EDID(struct fb_info *info, struct pci_dev *pdev)
 {
-	struct riva_par *par;
-	int i;
-
 	NVTRACE_ENTER();
 #ifdef CONFIG_PPC_OF
 	if (!riva_get_EDID_OF(info, pdev))
 		printk("rivafb: could not retrieve EDID from OF\n");
-#else
-	/* XXX use other methods later */
-#ifdef CONFIG_FB_RIVA_I2C
-
-	par = (struct riva_par *) info->par;
-	for (i = par->bus; i >= 1; i--) {
-		riva_probe_i2c_connector(par, i, &par->EDID);
-		if (par->EDID) {
-			printk("rivafb: Found EDID Block from BUS %i\n", i);
-			break;
-		}
-	}
-#endif
+#elif CONFIG_FB_RIVA_I2C
+	if (!riva_get_EDID_i2c(info))
+		printk("rivafb: could not retrieve EDID from DDC/I2C\n");
 #endif
 	NVTRACE_LEAVE();
 }
@@ -1911,16 +1827,52 @@ static void riva_get_edidinfo(struct fb_
  *
  * ------------------------------------------------------------------------- */
 
+static u32 riva_get_arch(struct pci_dev *pd)
+{
+    	u32 arch = 0;
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
@@ -1949,12 +1901,27 @@ static int __devinit rivafb_probe(struct
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
+
 	default_par->FlatPanel = flatpanel;
 	if (flatpanel == 1)
 		printk(KERN_INFO PFX "flatpanel support enabled\n");
@@ -2039,10 +2006,6 @@ static int __devinit rivafb_probe(struct
 	}
 #endif /* CONFIG_MTRR */
 
-#ifdef CONFIG_FB_RIVA_I2C
-	riva_create_i2c_busses((struct riva_par *) info->par);
-#endif
-
 	info->fbops = &riva_fb_ops;
 	info->fix = rivafb_fix;
 	riva_get_EDID(info, pd);
@@ -2062,10 +2025,9 @@ static int __devinit rivafb_probe(struct
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
@@ -2111,6 +2073,8 @@ static void __exit rivafb_remove(struct 
 
 #ifdef CONFIG_FB_RIVA_I2C
 	riva_delete_i2c_busses(par);
+	if (par->EDID)
+		kfree(par->EDID);
 #endif
 
 	unregister_framebuffer(info);
diff -uprN linux-2.6.8-rc3-mm1-orig/drivers/video/riva/riva_hw.h linux-2.6.8-rc3-mm1/drivers/video/riva/riva_hw.h
--- linux-2.6.8-rc3-mm1-orig/drivers/video/riva/riva_hw.h	2004-05-10 10:33:20.000000000 +0800
+++ linux-2.6.8-rc3-mm1/drivers/video/riva/riva_hw.h	2004-08-06 21:23:42.880528168 +0800
@@ -89,12 +89,14 @@ typedef unsigned int   U032;
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



