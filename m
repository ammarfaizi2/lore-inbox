Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266584AbSKZT06>; Tue, 26 Nov 2002 14:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266609AbSKZT06>; Tue, 26 Nov 2002 14:26:58 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:6866 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266584AbSKZTZy>;
	Tue, 26 Nov 2002 14:25:54 -0500
Date: Tue, 26 Nov 2002 19:31:07 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Split up AGP GART device lists.
Message-ID: <20021126193107.GA25048@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a lot of redundancy in the lists of devices
supported by AGPGART.
In particular, Vendor ID/Name and pointers to the
chipset setup routines are typically a per-vendor
thing rather than a per-device thing.

The below patch addresses this by splitting the table
into a vendor/device pair where a vendor table has
a pointer to n device tables.  In the few cases where
some chipsets need a non-generic chipset init routine,
they can override the one specified in the vendor table.

I've given this a boot-test on a box with an Intel i850 GART,
but due to the multi-vendor nature of the patch, I'd
appreciate testers from various other chipsets to make sure
I didn't miss something obvious.

Patch is against latest bitkeeper, but should apply to any 2.5-recent.

		Dave


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/agp.c agpgart/drivers/char/agp/agp.c
--- bk-linus/drivers/char/agp/agp.c	2002-11-26 10:41:12.000000000 -0100
+++ agpgart/drivers/char/agp/agp.c	2002-11-26 19:14:33.000000000 -0100
@@ -744,469 +744,60 @@ void agp_enable(u32 mode)
 
 /* End - Generic Agp routines */
 
-
-/* per-chipset initialization data.
- * note -- all chipsets for a single vendor MUST be grouped together
- */
+/* per-chipset initialization data. */
 static struct {
-	unsigned short device_id; /* first, to make table easier to read */
-	unsigned short vendor_id;
-	enum chipset_type chipset;
-	const char *vendor_name;
-	const char *chipset_name;
-	int (*chipset_setup) (struct pci_dev *pdev);
-} agp_bridge_info[] __initdata = {
+	struct agp_bridge_info *ptr;
+} agp_bridge_list[] __initdata = {
 
 #ifdef CONFIG_AGP_ALI
-	{
-		.device_id	= PCI_DEVICE_ID_AL_M1541,
-		.vendor_id	= PCI_VENDOR_ID_AL,
-		.chipset	= ALI_M1541,
-		.vendor_name	= "Ali",
-		.chipset_name	= "M1541",
-		.chipset_setup	= ali_generic_setup,
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_AL_M1621,
-		.vendor_id	= PCI_VENDOR_ID_AL,
-		.chipset	= ALI_M1621,
-		.vendor_name	= "Ali",
-		.chipset_name	= "M1621",
-		.chipset_setup	= ali_generic_setup,
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_AL_M1631,
-		.vendor_id	= PCI_VENDOR_ID_AL,
-		.chipset	= ALI_M1631,
-		.vendor_name	= "Ali",
-		.chipset_name	= "M1631",
-		.chipset_setup	= ali_generic_setup,
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_AL_M1632,
-		.vendor_id	= PCI_VENDOR_ID_AL,
-		.chipset	= ALI_M1632,
-		.vendor_name	= "Ali",
-		.chipset_name	= "M1632",
-		.chipset_setup	= ali_generic_setup,
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_AL_M1641,
-		.vendor_id	= PCI_VENDOR_ID_AL,
-		.chipset	= ALI_M1641,
-		.vendor_name	= "Ali",
-		.chipset_name	= "M1641",
-		.chipset_setup	= ali_generic_setup,
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_AL_M1644,
-		.vendor_id	= PCI_VENDOR_ID_AL,
-		.chipset	= ALI_M1644,
-		.vendor_name	= "Ali",
-		.chipset_name	= "M1644",
-		.chipset_setup	= ali_generic_setup,
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_AL_M1647,
-		.vendor_id	= PCI_VENDOR_ID_AL,
-		.chipset	= ALI_M1647,
-		.vendor_name	= "Ali",
-		.chipset_name	= "M1647",
-		.chipset_setup	= ali_generic_setup,
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_AL_M1651,
-		.vendor_id	= PCI_VENDOR_ID_AL,
-		.chipset	= ALI_M1651,
-		.vendor_name	= "Ali",
-		.chipset_name	= "M1651",
-		.chipset_setup	= ali_generic_setup,
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_AL_M1671,
-		.vendor_id	= PCI_VENDOR_ID_AL,
-		.chipset	= ALI_M1671,
-		.vendor_name	= "Ali",
-		.chipset_name	= "M1671",
-		.chipset_setup	= ali_generic_setup,
-	},
-	{
-		.device_id	= 0,
-		.vendor_id	= PCI_VENDOR_ID_AL,
-		.chipset	= ALI_GENERIC,
-		.vendor_name	= "Ali",
-		.chipset_name	= "Generic",
-		.chipset_setup	= ali_generic_setup,
-	},
-#endif /* CONFIG_AGP_ALI */
-
+	{ .ptr = &ali_agp_bridge_info },
+#endif
 #ifdef CONFIG_AGP_AMD_8151
-	{ 
-		.device_id	= PCI_DEVICE_ID_AMD_8151_0,
-		.vendor_id  = PCI_VENDOR_ID_AMD,
-		.chipset    = AMD_8151,
-		.vendor_name = "AMD",
-		.chipset_name = "8151",
-		.chipset_setup = amd_8151_setup 
-	},
-#endif /* CONFIG_AGP_AMD */
-
+	{.ptr = &amd_k8_agp_bridge_info },
+#endif
 #ifdef CONFIG_AGP_AMD
-	{
-		.device_id	= PCI_DEVICE_ID_AMD_FE_GATE_7006,
-		.vendor_id	= PCI_VENDOR_ID_AMD,
-		.chipset	= AMD_IRONGATE,
-		.vendor_name	= "AMD",
-		.chipset_name	= "Irongate",
-		.chipset_setup	= amd_irongate_setup,
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_AMD_FE_GATE_700E,
-		.vendor_id	= PCI_VENDOR_ID_AMD,
-		.chipset	= AMD_761,
-		.vendor_name	= "AMD",
-		.chipset_name	= "761",
-		.chipset_setup	= amd_irongate_setup,
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_AMD_FE_GATE_700C,
-		.vendor_id	= PCI_VENDOR_ID_AMD,
-		.chipset	= AMD_762,
-		.vendor_name	= "AMD",
-		.chipset_name	= "760MP",
-		.chipset_setup	= amd_irongate_setup,
-	},
-	{
-		.device_id	= 0,
-		.vendor_id	= PCI_VENDOR_ID_AMD,
-		.chipset	= AMD_GENERIC,
-		.vendor_name	= "AMD",
-		.chipset_name	= "Generic",
-		.chipset_setup	= amd_irongate_setup,
-	},
-#endif /* CONFIG_AGP_AMD */
+	{.ptr = &amd_agp_bridge_info },
+#endif
 #ifdef CONFIG_AGP_INTEL
-	{
-		.device_id	= PCI_DEVICE_ID_INTEL_82443LX_0,
-		.vendor_id	= PCI_VENDOR_ID_INTEL,
-		.chipset	= INTEL_LX,
-		.vendor_name	= "Intel",
-		.chipset_name	= "440LX",
-		.chipset_setup	= intel_generic_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_INTEL_82443BX_0,
-		.vendor_id	= PCI_VENDOR_ID_INTEL,
-		.chipset	= INTEL_BX,
-		.vendor_name	= "Intel",
-		.chipset_name	= "440BX",
-		.chipset_setup	= intel_generic_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_INTEL_82443GX_0,
-		.vendor_id	= PCI_VENDOR_ID_INTEL,
-		.chipset	= INTEL_GX,
-		.vendor_name	= "Intel",
-		.chipset_name	= "440GX",
-		.chipset_setup	= intel_generic_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_INTEL_82815_MC,
-		.vendor_id	= PCI_VENDOR_ID_INTEL,
-		.chipset	= INTEL_I815,
-		.vendor_name	= "Intel",
-		.chipset_name	= "i815",
-		.chipset_setup	= intel_815_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_INTEL_82820_HB,
-		.vendor_id	= PCI_VENDOR_ID_INTEL,
-		.chipset	= INTEL_I820,
-		.vendor_name	= "Intel",
-		.chipset_name	= "i820",
-		.chipset_setup	= intel_820_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_INTEL_82820_UP_HB,
-		.vendor_id	= PCI_VENDOR_ID_INTEL,
-		.chipset	= INTEL_I820,
-		.vendor_name	= "Intel",
-		.chipset_name	= "i820",
-		.chipset_setup	= intel_820_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_INTEL_82830_HB,
-		.vendor_id	= PCI_VENDOR_ID_INTEL,
-		.chipset	= INTEL_I830_M,
-		.vendor_name	= "Intel",
-		.chipset_name	= "i830M",
-		.chipset_setup	= intel_830mp_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_INTEL_82845G_HB,
-		.vendor_id	= PCI_VENDOR_ID_INTEL,
-		.chipset	= INTEL_I845_G,
-		.vendor_name	= "Intel",
-		.chipset_name	= "i845G",
-		.chipset_setup	= intel_830mp_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_INTEL_82840_HB,
-		.vendor_id	= PCI_VENDOR_ID_INTEL,
-		.chipset	= INTEL_I840,
-		.vendor_name	= "Intel",
-		.chipset_name	= "i840",
-		.chipset_setup	= intel_840_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_INTEL_82845_HB,
-		.vendor_id	= PCI_VENDOR_ID_INTEL,
-		.chipset	= INTEL_I845,
-		.vendor_name	= "Intel",
-		.chipset_name	= "i845",
-		.chipset_setup	= intel_845_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_INTEL_82850_HB,
-		.vendor_id	= PCI_VENDOR_ID_INTEL,
-		.chipset	= INTEL_I850,
-		.vendor_name	= "Intel",
-		.chipset_name	= "i850",
-		.chipset_setup	= intel_850_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_INTEL_82860_HB,
-		.vendor_id	= PCI_VENDOR_ID_INTEL,
-		.chipset	= INTEL_I860,
-		.vendor_name	= "Intel",
-		.chipset_name	= "i860",
-		.chipset_setup	= intel_860_setup
-	},
-	{
-		.device_id	= 0,
-		.vendor_id	= PCI_VENDOR_ID_INTEL,
-		.chipset	= INTEL_GENERIC,
-		.vendor_name	= "Intel",
-		.chipset_name	= "Generic",
-		.chipset_setup	= intel_generic_setup
-	},
-
-#endif /* CONFIG_AGP_INTEL */
-
+	{.ptr = &intel_agp_bridge_info },
+#endif
 #ifdef CONFIG_AGP_SIS
-	{
-		.device_id	= PCI_DEVICE_ID_SI_740,
-		.vendor_id	= PCI_VENDOR_ID_SI,
-		.chipset	= SIS_GENERIC,
-		.vendor_name	= "SiS",
-		.chipset_name	= "740",
-		.chipset_setup	= sis_generic_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_SI_650,
-		.vendor_id	= PCI_VENDOR_ID_SI,
-		.chipset	= SIS_GENERIC,
-		.vendor_name	= "SiS",
-		.chipset_name	= "650",
-		.chipset_setup	= sis_generic_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_SI_645,
-		.vendor_id	= PCI_VENDOR_ID_SI,
-		.chipset	= SIS_GENERIC,
-		.vendor_name	= "SiS",
-		.chipset_name	= "645",
-		.chipset_setup	= sis_generic_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_SI_735,
-		.vendor_id	= PCI_VENDOR_ID_SI,
-		.chipset	= SIS_GENERIC,
-		.vendor_name	= "SiS",
-		.chipset_name	= "735",
-		.chipset_setup	= sis_generic_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_SI_745,
-		.vendor_id	= PCI_VENDOR_ID_SI,
-		.chipset	= SIS_GENERIC,
-		.vendor_name	= "SiS",
-		.chipset_name	= "745",
-		.chipset_setup	= sis_generic_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_SI_730,
-		.vendor_id	= PCI_VENDOR_ID_SI,
-		.chipset	= SIS_GENERIC,
-		.vendor_name	= "SiS",
-		.chipset_name	= "730",
-		.chipset_setup	= sis_generic_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_SI_630,
-		.vendor_id	= PCI_VENDOR_ID_SI,
-		.chipset	= SIS_GENERIC,
-		.vendor_name	= "SiS",
-		.chipset_name	= "630",
-		.chipset_setup	= sis_generic_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_SI_540,
-		.vendor_id	= PCI_VENDOR_ID_SI,
-		.chipset	= SIS_GENERIC,
-		.vendor_name	= "SiS",
-		.chipset_name	= "540",
-		.chipset_setup	= sis_generic_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_SI_620,
-		.vendor_id	= PCI_VENDOR_ID_SI,
-		.chipset	= SIS_GENERIC,
-		.vendor_name	= "SiS",
-		.chipset_name	= "620",
-		.chipset_setup	= sis_generic_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_SI_530,
-		.vendor_id	= PCI_VENDOR_ID_SI,
-		.chipset	= SIS_GENERIC,
-		.vendor_name	= "SiS",
-		.chipset_name	= "530",
-		.chipset_setup	= sis_generic_setup
-	},
-        {
-		.device_id	= PCI_DEVICE_ID_SI_550,
-		.vendor_id	= PCI_VENDOR_ID_SI,
-		.chipset	= SIS_GENERIC,
-		.vendor_name	= "SiS",
-		.chipset_name	= "550",
-		.chipset_setup	= sis_generic_setup
-	},
-	{
-		.device_id	= 0,
-		.vendor_id	= PCI_VENDOR_ID_SI,
-		.chipset	= SIS_GENERIC,
-		.vendor_name	= "SiS",
-		.chipset_name	= "Generic",
-		.chipset_setup	= sis_generic_setup
-	},
-#endif /* CONFIG_AGP_SIS */
-
+	{.ptr = &sis_agp_bridge_info },
+#endif
 #ifdef CONFIG_AGP_VIA
-	{
-		.device_id	= PCI_DEVICE_ID_VIA_8501_0,
-		.vendor_id	= PCI_VENDOR_ID_VIA,
-		.chipset	= VIA_MVP4,
-		.vendor_name	= "Via",
-		.chipset_name	= "MVP4",
-		.chipset_setup	= via_generic_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_VIA_82C597_0,
-		.vendor_id	= PCI_VENDOR_ID_VIA,
-		.chipset	= VIA_VP3,
-		.vendor_name	= "Via",
-		.chipset_name	= "VP3",
-		.chipset_setup	= via_generic_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_VIA_82C598_0,
-		.vendor_id	= PCI_VENDOR_ID_VIA,
-		.chipset	= VIA_MVP3,
-		.vendor_name	= "Via",
-		.chipset_name	= "MVP3",
-		.chipset_setup	= via_generic_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_VIA_82C691,
-		.vendor_id	= PCI_VENDOR_ID_VIA,
-		.chipset	= VIA_APOLLO_PRO,
-		.vendor_name	= "Via",
-		.chipset_name	= "Apollo Pro",
-		.chipset_setup	= via_generic_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_VIA_8371_0,
-		.vendor_id	= PCI_VENDOR_ID_VIA,
-		.chipset	= VIA_APOLLO_KX133,
-		.vendor_name	= "Via",
-		.chipset_name	= "Apollo Pro KX133",
-		.chipset_setup	= via_generic_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_VIA_8363_0,
-		.vendor_id	= PCI_VENDOR_ID_VIA,
-		.chipset	= VIA_APOLLO_KT133,
-		.vendor_name	= "Via",
-		.chipset_name	= "Apollo Pro KT133",
-		.chipset_setup	= via_generic_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_VIA_8367_0,
-		.vendor_id	= PCI_VENDOR_ID_VIA,
-		.chipset	= VIA_APOLLO_KT133,
-		.vendor_name	= "Via",
-		.chipset_name	= "Apollo Pro KT266",
-		.chipset_setup	= via_generic_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_VIA_8377_0,
-		.vendor_id	= PCI_VENDOR_ID_VIA,
-		.chipset	= VIA_APOLLO_KT400,
-		.vendor_name	= "Via",
-		.chipset_name	= "Apollo Pro KT400",
-		.chipset_setup	= via_generic_setup
-	},
-	{
-		.device_id	= PCI_DEVICE_ID_VIA_8653_0,
-		.vendor_id	= PCI_VENDOR_ID_VIA,
-		.chipset	= VIA_APOLLO_PRO,
-		.vendor_name	= "Via",
-		.chipset_name	= "Apollo Pro266T",
-		.chipset_setup	= via_generic_setup
-	},
-	{
-		.device_id	= 0,
-		.vendor_id	= PCI_VENDOR_ID_VIA,
-		.chipset	= VIA_GENERIC,
-		.vendor_name	= "Via",
-		.chipset_name	= "Generic",
-		.chipset_setup	= via_generic_setup
-	},
-#endif /* CONFIG_AGP_VIA */
-
+	{.ptr = &via_agp_bridge_info },
+#endif
 #ifdef CONFIG_AGP_HP_ZX1
-	{
-		.device_id	= PCI_DEVICE_ID_HP_ZX1_LBA,
-		.vendor_id	= PCI_VENDOR_ID_HP,
-		.chipset	= HP_ZX1,
-		.vendor_name	= "HP",
-		.chipset_name	= "ZX1",
-		.chipset_setup	= hp_zx1_setup
-	},
+	{.ptr = &hp_agp_bridge_info },
 #endif
-
-	{ }, /* dummy final entry, always present */
+	{NULL},
 };
 
 
 /* scan table above for supported devices */
 static int __init agp_lookup_host_bridge (struct pci_dev *pdev)
 {
-	int i;
+	int i=0, j=0;
+	struct agp_bridge_info *bridge=NULL;
+	struct agp_device_ids *devs;
 	
-	for (i = 0; i < ARRAY_SIZE (agp_bridge_info); i++)
-		if (pdev->vendor == agp_bridge_info[i].vendor_id)
+	while (agp_bridge_list[i].ptr != NULL) {
+		bridge = agp_bridge_list[i].ptr;
+		if (pdev->vendor == bridge->vendor_id)
 			break;
+		i++;
+	}
 
-	if (i >= ARRAY_SIZE (agp_bridge_info)) {
+	/* Vendor not found! */
+	if (bridge == NULL) {
 		printk (KERN_DEBUG PFX "unsupported bridge\n");
 		return -ENODEV;
 	}
 
-	while ((i < ARRAY_SIZE (agp_bridge_info)) &&
-	       (agp_bridge_info[i].vendor_id == pdev->vendor)) {
-		if (pdev->device == agp_bridge_info[i].device_id) {
+	devs = bridge->ids;
+
+	while (devs[j].chipset_name != NULL) {
+		if (pdev->device == devs[j].device_id) {
 #ifdef CONFIG_AGP_ALI
 			if (pdev->device == PCI_DEVICE_ID_AL_M1621) {
 				u8 hidden_1621_id;
@@ -1214,21 +805,21 @@ static int __init agp_lookup_host_bridge
 				pci_read_config_byte(pdev, 0xFB, &hidden_1621_id);
 				switch (hidden_1621_id) {
 				case 0x31:
-					agp_bridge_info[i].chipset_name="M1631";
+					devs[j].chipset_name="M1631";
 					break;
 				case 0x32:
-					agp_bridge_info[i].chipset_name="M1632";
+					devs[j].chipset_name="M1632";
 					break;
 				case 0x41:
-					agp_bridge_info[i].chipset_name="M1641";
+					devs[j].chipset_name="M1641";
 					break;
 				case 0x43:
 					break;
 				case 0x47:
-					agp_bridge_info[i].chipset_name="M1647";
+					devs[j].chipset_name="M1647";
 					break;
 				case 0x51:
-					agp_bridge_info[i].chipset_name="M1651";
+					devs[j].chipset_name="M1651";
 					break;
 				default:
 					break;
@@ -1237,30 +828,32 @@ static int __init agp_lookup_host_bridge
 #endif
 
 			printk (KERN_INFO PFX "Detected %s %s chipset\n",
-				agp_bridge_info[i].vendor_name,
-				agp_bridge_info[i].chipset_name);
-			agp_bridge.type = agp_bridge_info[i].chipset;
-			return agp_bridge_info[i].chipset_setup (pdev);
+				bridge->vendor_name, devs[j].chipset_name);
+			agp_bridge.type = devs[j].chipset;
+
+			if (devs[j].chipset_setup != NULL)
+				return devs[j].chipset_setup(pdev);
+			else
+				return bridge->chipset_setup(pdev);
 		}
-		
-		i++;
+		j++;
 	}
 
-	i--; /* point to vendor generic entry (device_id == 0) */
+	j--; /* point to vendor generic entry (device_id == 0) */
 
 	/* try init anyway, if user requests it AND
 	 * there is a 'generic' bridge entry for this vendor */
-	if (agp_try_unsupported && agp_bridge_info[i].device_id == 0) {
+	if (agp_try_unsupported && devs[i].device_id == 0) {
 		printk(KERN_WARNING PFX "Trying generic %s routines"
 		       " for device id: %04x\n",
-		       agp_bridge_info[i].vendor_name, pdev->device);
-		agp_bridge.type = agp_bridge_info[i].chipset;
-		return agp_bridge_info[i].chipset_setup (pdev);
+		       bridge->vendor_name, pdev->device);
+		agp_bridge.type = devs[i].chipset;
+		return bridge->chipset_setup(pdev);
 	}
 
 	printk(KERN_ERR PFX "Unsupported %s chipset (device id: %04x),"
-	       " you might want to try agp_try_unsupported=1.\n",
-	       agp_bridge_info[i].vendor_name, pdev->device);
+		" you might want to try agp_try_unsupported=1.\n",
+		bridge->vendor_name, pdev->device);
 	return -ENODEV;
 }
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/agp.h agpgart/drivers/char/agp/agp.h
--- bk-linus/drivers/char/agp/agp.h	2002-11-26 10:41:12.000000000 -0100
+++ agpgart/drivers/char/agp/agp.h	2002-11-26 18:39:53.000000000 -0100
@@ -381,4 +381,26 @@ struct agp_bridge_data {
 #define HP_ZX1_PDIR_BASE	0x320
 #define HP_ZX1_CACHE_FLUSH	0x428
 
+struct agp_device_ids {
+	unsigned short device_id; /* first, to make table easier to read */
+	enum chipset_type chipset;
+	const char *chipset_name;
+	int (*chipset_setup) (struct pci_dev *pdev);	/* used to override generic */
+};
+
+struct agp_bridge_info {
+	unsigned short vendor_id;
+	const char *vendor_name;
+	int (*chipset_setup) (struct pci_dev *pdev);
+	struct agp_device_ids *ids;
+};
+
+extern struct agp_bridge_info ali_agp_bridge_info;
+extern struct agp_bridge_info amd_k8_agp_bridge_info;
+extern struct agp_bridge_info amd_agp_bridge_info;
+extern struct agp_bridge_info intel_agp_bridge_info;
+extern struct agp_bridge_info sis_agp_bridge_info;
+extern struct agp_bridge_info via_agp_bridge_info;
+extern struct agp_bridge_info hp_agp_bridge_info;
+
 #endif				/* _AGP_BACKEND_PRIV_H */
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/ali-agp.c agpgart/drivers/char/agp/ali-agp.c
--- bk-linus/drivers/char/agp/ali-agp.c	2002-11-26 10:41:12.000000000 -0100
+++ agpgart/drivers/char/agp/ali-agp.c	2002-11-26 18:27:59.000000000 -0100
@@ -32,6 +32,7 @@
 #include <linux/init.h>
 #include <linux/agp_backend.h>
 #include "agp.h"
+#include "ali.h"
 
 static int ali_fetch_size(void)
 {
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/ali.h agpgart/drivers/char/agp/ali.h
--- bk-linus/drivers/char/agp/ali.h	1969-12-31 23:00:00.000000000 -0100
+++ agpgart/drivers/char/agp/ali.h	2002-11-26 17:44:56.000000000 -0100
@@ -0,0 +1,64 @@
+struct agp_device_ids ali_agp_device_ids[] __initdata =
+{
+	{
+		.device_id	= PCI_DEVICE_ID_AL_M1541,
+		.chipset	= ALI_M1541,
+		.chipset_name	= "M1541",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_AL_M1621,
+		.chipset	= ALI_M1621,
+		.chipset_name	= "M1621",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_AL_M1631,
+		.chipset	= ALI_M1631,
+		.chipset_name	= "M1631",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_AL_M1632,
+		.chipset	= ALI_M1632,
+		.chipset_name	= "M1632",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_AL_M1641,
+		.chipset	= ALI_M1641,
+		.chipset_name	= "M1641",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_AL_M1644,
+		.chipset	= ALI_M1644,
+		.chipset_name	= "M1644",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_AL_M1647,
+		.chipset	= ALI_M1647,
+		.chipset_name	= "M1647",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_AL_M1651,
+		.chipset	= ALI_M1651,
+		.chipset_name	= "M1651",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_AL_M1671,
+		.chipset	= ALI_M1671,
+		.chipset_name	= "M1671",
+	},
+	{
+		.device_id	= 0,
+		.chipset	= ALI_GENERIC,
+		.chipset_name	= "Generic",
+	},
+
+	{ }, /* dummy final entry, always present */
+};
+
+struct agp_bridge_info ali_agp_bridge_info __initdata =
+{
+	.vendor_id	= PCI_VENDOR_ID_AL,
+	.vendor_name	= "Ali",
+	.chipset_setup	= ali_generic_setup,
+	.ids			= ali_agp_device_ids,
+};
+
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/amd-agp.c agpgart/drivers/char/agp/amd-agp.c
--- bk-linus/drivers/char/agp/amd-agp.c	2002-11-26 10:41:12.000000000 -0100
+++ agpgart/drivers/char/agp/amd-agp.c	2002-11-26 18:28:08.000000000 -0100
@@ -31,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/agp_backend.h>
 #include "agp.h"
+#include "amd.h"
 
 struct amd_page_map {
 	unsigned long *real;
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/amd.h agpgart/drivers/char/agp/amd.h
--- bk-linus/drivers/char/agp/amd.h	1969-12-31 23:00:00.000000000 -0100
+++ agpgart/drivers/char/agp/amd.h	2002-11-26 17:44:36.000000000 -0100
@@ -0,0 +1,32 @@
+struct agp_device_ids amd_agp_device_ids[] __initdata =
+{
+	{
+		.device_id	= PCI_DEVICE_ID_AMD_FE_GATE_7006,
+		.chipset	= AMD_IRONGATE,
+		.chipset_name	= "Irongate",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_AMD_FE_GATE_700E,
+		.chipset	= AMD_761,
+		.chipset_name	= "761",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_AMD_FE_GATE_700C,
+		.chipset	= AMD_762,
+		.chipset_name	= "760MP",
+	},
+	{
+		.device_id	= 0,
+		.chipset	= AMD_GENERIC,
+		.chipset_name	= "Generic",
+	},
+	{ }, /* dummy final entry, always present */
+};
+
+struct agp_bridge_info amd_agp_bridge_info __initdata = 
+{
+	.vendor_id	= PCI_VENDOR_ID_AMD,
+	.vendor_name	= "AMD",
+	.chipset_setup	= amd_irongate_setup,
+	.ids		= amd_agp_device_ids,
+};
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/hp-agp.c agpgart/drivers/char/agp/hp-agp.c
--- bk-linus/drivers/char/agp/hp-agp.c	2002-11-26 10:41:12.000000000 -0100
+++ agpgart/drivers/char/agp/hp-agp.c	2002-11-26 18:31:15.000000000 -0100
@@ -31,7 +31,7 @@
 #include <linux/init.h>
 #include <linux/agp_backend.h>
 #include "agp.h"
-
+#include "hp.h"
 
 #ifndef log2
 #define log2(x)		ffz(~(x))
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/hp.h agpgart/drivers/char/agp/hp.h
--- bk-linus/drivers/char/agp/hp.h	1969-12-31 23:00:00.000000000 -0100
+++ agpgart/drivers/char/agp/hp.h	2002-11-26 17:44:39.000000000 -0100
@@ -0,0 +1,17 @@
+struct agp_device_ids hp_agp_device_ids[] __initdata =
+{
+	{
+		.device_id	= PCI_DEVICE_ID_HP_ZX1_LBA,
+		.chipset	= HP_ZX1,
+		.chipset_name	= "ZX1",
+	},
+	{ }, /* dummy final entry, always present */
+};
+
+struct agp_bridge_info hp_agp_bridge_info __initdata =
+{
+	.vendor_id	= PCI_VENDOR_ID_HP,
+	.vendor_name	= "HP",
+	.chipset_setup	= hp_zx1_setup,
+	.ids		= hp_agp_device_ids,
+};
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/i8x0-agp.c agpgart/drivers/char/agp/i8x0-agp.c
--- bk-linus/drivers/char/agp/i8x0-agp.c	2002-11-26 10:41:12.000000000 -0100
+++ agpgart/drivers/char/agp/i8x0-agp.c	2002-11-26 18:37:28.000000000 -0100
@@ -31,7 +31,7 @@
 #include <linux/init.h>
 #include <linux/agp_backend.h>
 #include "agp.h"
-
+#include "i8x0.h"
 
 static int intel_fetch_size(void)
 {
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/i8x0.h agpgart/drivers/char/agp/i8x0.h
--- bk-linus/drivers/char/agp/i8x0.h	1969-12-31 23:00:00.000000000 -0100
+++ agpgart/drivers/char/agp/i8x0.h	2002-11-26 18:29:30.000000000 -0100
@@ -0,0 +1,86 @@
+struct agp_device_ids intel_agp_device_ids[] __initdata =
+{
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_82443LX_0,
+		.chipset	= INTEL_LX,
+		.chipset_name	= "440LX",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_82443BX_0,
+		.chipset	= INTEL_BX,
+		.chipset_name	= "440BX",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_82443GX_0,
+		.chipset	= INTEL_GX,
+		.chipset_name	= "440GX",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_82815_MC,
+		.chipset	= INTEL_I815,
+		.chipset_name	= "i815",
+		.chipset_setup	= intel_815_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_82820_HB,
+		.chipset	= INTEL_I820,
+		.chipset_name	= "i820",
+		.chipset_setup	= intel_820_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_82820_UP_HB,
+		.chipset	= INTEL_I820,
+		.chipset_name	= "i820",
+		.chipset_setup	= intel_820_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_82830_HB,
+		.chipset	= INTEL_I830_M,
+		.chipset_name	= "i830M",
+		.chipset_setup	= intel_830mp_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_82845G_HB,
+		.chipset	= INTEL_I845_G,
+		.chipset_name	= "i845G",
+		.chipset_setup	= intel_830mp_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_82840_HB,
+		.chipset	= INTEL_I840,
+		.chipset_name	= "i840",
+		.chipset_setup	= intel_840_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_82845_HB,
+		.chipset	= INTEL_I845,
+		.chipset_name	= "i845",
+		.chipset_setup	= intel_845_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_82850_HB,
+		.chipset	= INTEL_I850,
+		.chipset_name	= "i850",
+		.chipset_setup	= intel_850_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_82860_HB,
+		.chipset	= INTEL_I860,
+		.chipset_name	= "i860",
+		.chipset_setup	= intel_860_setup
+	},
+	{
+		.device_id	= 0,
+		.chipset	= INTEL_GENERIC,
+		.chipset_name	= "Generic",
+	},
+	{ }, /* dummy final entry, always present */
+};
+
+struct agp_bridge_info intel_agp_bridge_info __initdata =
+{
+	.vendor_id	= PCI_VENDOR_ID_INTEL,
+	.vendor_name	= "Intel",
+	.chipset_setup	= intel_generic_setup,
+	.ids			= intel_agp_device_ids,			
+};
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/k8-agp.c agpgart/drivers/char/agp/k8-agp.c
--- bk-linus/drivers/char/agp/k8-agp.c	2002-11-26 10:41:12.000000000 -0100
+++ agpgart/drivers/char/agp/k8-agp.c	2002-11-26 18:31:44.000000000 -0100
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/agp_backend.h>
 #include "agp.h"
+#include "k8-agp.h"
 
 extern int agp_memory_reserved;
 extern __u32 *agp_gatt_table; 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/k8-agp.h agpgart/drivers/char/agp/k8-agp.h
--- bk-linus/drivers/char/agp/k8-agp.h	1969-12-31 23:00:00.000000000 -0100
+++ agpgart/drivers/char/agp/k8-agp.h	2002-11-26 17:44:44.000000000 -0100
@@ -0,0 +1,17 @@
+struct agp_device_ids amd_k8_device_ids[] __initdata =
+{
+	{ 
+		.device_id	= PCI_DEVICE_ID_AMD_8151_0,
+		.chipset    = AMD_8151,
+		.chipset_name = "8151",
+	},
+	{ }, /* dummy final entry, always present */
+};
+
+struct agp_bridge_info amd_k8_agp_bridge_info[] __initdata =
+{
+	.vendor_id		= PCI_VENDOR_ID_AMD,
+	.vendor_name	= "AMD",
+	.chipset_setup	= amd_8151_setup,
+	.ids			= amd_k8_device_ids,
+};
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/sis-agp.c agpgart/drivers/char/agp/sis-agp.c
--- bk-linus/drivers/char/agp/sis-agp.c	2002-11-26 10:41:12.000000000 -0100
+++ agpgart/drivers/char/agp/sis-agp.c	2002-11-26 18:31:45.000000000 -0100
@@ -31,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/agp_backend.h>
 #include "agp.h"
+#include "sis.h"
 
 static int sis_fetch_size(void)
 {
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/sis.h agpgart/drivers/char/agp/sis.h
--- bk-linus/drivers/char/agp/sis.h	1969-12-31 23:00:00.000000000 -0100
+++ agpgart/drivers/char/agp/sis.h	2002-11-26 17:44:46.000000000 -0100
@@ -0,0 +1,72 @@
+struct agp_device_ids sis_agp_device_ids[] __initdata =
+{
+	{
+		.device_id	= PCI_DEVICE_ID_SI_740,
+		.chipset	= SIS_GENERIC,
+		.chipset_name	= "740",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_SI_650,
+		.chipset	= SIS_GENERIC,
+		.chipset_name	= "650",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_SI_645,
+		.chipset	= SIS_GENERIC,
+		.chipset_name	= "645",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_SI_735,
+		.chipset	= SIS_GENERIC,
+		.chipset_name	= "735",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_SI_745,
+		.chipset	= SIS_GENERIC,
+		.chipset_name	= "745",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_SI_730,
+		.chipset	= SIS_GENERIC,
+		.chipset_name	= "730",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_SI_630,
+		.chipset	= SIS_GENERIC,
+		.chipset_name	= "630",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_SI_540,
+		.chipset	= SIS_GENERIC,
+		.chipset_name	= "540",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_SI_620,
+		.chipset	= SIS_GENERIC,
+		.chipset_name	= "620",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_SI_530,
+		.chipset	= SIS_GENERIC,
+		.chipset_name	= "530",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_SI_550,
+		.chipset	= SIS_GENERIC,
+		.chipset_name	= "550",
+	},
+	{
+		.device_id	= 0,
+		.chipset	= SIS_GENERIC,
+		.chipset_name	= "Generic",
+	},
+	{ }, /* dummy final entry, always present */
+};
+
+struct agp_bridge_info sis_agp_bridge_info __initdata =
+{
+	.vendor_id	= PCI_VENDOR_ID_SI,
+	.vendor_name	= "SiS",
+	.chipset_setup	= sis_generic_setup,
+	.ids			= sis_agp_device_ids,
+};
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/via-agp.c agpgart/drivers/char/agp/via-agp.c
--- bk-linus/drivers/char/agp/via-agp.c	2002-11-26 10:41:12.000000000 -0100
+++ agpgart/drivers/char/agp/via-agp.c	2002-11-26 18:31:46.000000000 -0100
@@ -32,6 +32,7 @@
 #include <linux/init.h>
 #include <linux/agp_backend.h>
 #include "agp.h"
+#include "via.h"
 
 
 static int via_fetch_size(void)
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/via.h agpgart/drivers/char/agp/via.h
--- bk-linus/drivers/char/agp/via.h	1969-12-31 23:00:00.000000000 -0100
+++ agpgart/drivers/char/agp/via.h	2002-11-26 17:44:49.000000000 -0100
@@ -0,0 +1,62 @@
+struct agp_device_ids via_agp_device_ids[] __initdata =
+{
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_8501_0,
+		.chipset	= VIA_MVP4,
+		.chipset_name	= "MVP4",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_82C597_0,
+		.chipset	= VIA_VP3,
+		.chipset_name	= "VP3",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_82C598_0,
+		.chipset	= VIA_MVP3,
+		.chipset_name	= "MVP3",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_82C691,
+		.chipset	= VIA_APOLLO_PRO,
+		.chipset_name	= "Apollo Pro",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_8371_0,
+		.chipset	= VIA_APOLLO_KX133,
+		.chipset_name	= "Apollo Pro KX133",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_8363_0,
+		.chipset	= VIA_APOLLO_KT133,
+		.chipset_name	= "Apollo Pro KT133",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_8367_0,
+		.chipset	= VIA_APOLLO_KT133,
+		.chipset_name	= "Apollo Pro KT266",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_8377_0,
+		.chipset	= VIA_APOLLO_KT400,
+		.chipset_name	= "Apollo Pro KT400",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_8653_0,
+		.chipset	= VIA_APOLLO_PRO,
+		.chipset_name	= "Apollo Pro266T",
+	},
+	{
+		.device_id	= 0,
+		.chipset	= VIA_GENERIC,
+		.chipset_name	= "Generic",
+	},
+	{ }, /* dummy final entry, always present */
+};
+
+struct agp_bridge_info via_agp_bridge_info __initdata =
+{
+	.vendor_id	= PCI_VENDOR_ID_VIA,
+	.vendor_name	= "Via",
+	.chipset_setup	= via_generic_setup,
+	.ids			= via_agp_device_ids,
+};

-- 
| Dave Jones.        http://www.codemonkey.org.uk
