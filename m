Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbTJWSOz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 14:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbTJWSOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 14:14:55 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:15379 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S261538AbTJWSOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 14:14:36 -0400
From: Terence Ripperda <tripperda@nvidia.com>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
To: Dave Jones <davej@redhat.com>
Cc: Terence Ripperda <tripperda@nvidia.com>, linux-kernel@vger.kernel.org
Date: Thu, 23 Oct 2003 13:14:18 -0500
From: <tripperda@nvidia.com>
Subject: Re: nforce3 agpgart support
Message-ID: <20031023181418.GF881@hygelac>
References: <20030919231038.GA18625@hygelac> <20031023175700.GD881@hygelac> <20031023180403.GA805@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <20031023180403.GA805@redhat.com>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.19 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thanks Dave,

ccing linux-kernel with the nforce patch for 2.4.22.

Terence

On Thu, Oct 23, 2003 at 07:04:03PM +0100, davej@redhat.com wrote:
> On Thu, Oct 23, 2003 at 12:57:00PM -0500, Terence Ripperda wrote:
>  > Here's an updated patch for linux 2.4.22, which also includes support for an additional nforce3s chipset.
>  > 
>  > are these the correct people that I should be sending these patches to, or is there someone else I should be contacting?
> 
> For 2.4, send stuff straight to Marcelo (Cc linux-kernel is usually a
> good idea too). 2.6 stuff, bounce to me first please. With Alan busy
> doing an MBA for the next year, he likely won't have time to feed
> Marcelo patches.
> 
> 		Dave
> 
> -- 
>  Dave Jones     http://www.codemonkey.org.uk


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.22-agpgart-nf3.diff"

diff -ru linux-2.4.22/arch/i386/defconfig linux-2.4.22-nforce/arch/i386/defconfig
--- linux-2.4.22/arch/i386/defconfig	2002-11-28 15:53:09.000000000 -0800
+++ linux-2.4.22-nforce/arch/i386/defconfig	2003-09-29 18:29:11.000000000 -0700
@@ -607,6 +607,7 @@
 CONFIG_AGP_SIS=y
 CONFIG_AGP_ALI=y
 # CONFIG_AGP_SWORKS is not set
+CONFIG_AGP_NVIDIA=y
 CONFIG_DRM=y
 # CONFIG_DRM_OLD is not set
 
diff -ru linux-2.4.22/arch/x86_64/defconfig linux-2.4.22-nforce/arch/x86_64/defconfig
--- linux-2.4.22/arch/x86_64/defconfig	2003-08-25 04:44:40.000000000 -0700
+++ linux-2.4.22-nforce/arch/x86_64/defconfig	2003-09-29 18:29:11.000000000 -0700
@@ -528,7 +528,7 @@
 #
 # CONFIG_FTAPE is not set
 CONFIG_AGP=y
-CONFIG_AGP_AMD_8151=y
+CONFIG_AGP_X86_64=y
 CONFIG_AGP_INTEL=y
 CONFIG_AGP_I810=y
 CONFIG_AGP_VIA=y
@@ -536,6 +536,7 @@
 CONFIG_AGP_SIS=y
 CONFIG_AGP_ALI=y
 CONFIG_AGP_SWORKS=y
+CONFIG_AGP_NVIDIA=y
 # CONFIG_DRM is not set
 # CONFIG_MWAVE is not set
 
diff -ru linux-2.4.22/Documentation/Configure.help linux-2.4.22-nforce/Documentation/Configure.help
--- linux-2.4.22/Documentation/Configure.help	2003-08-25 04:44:39.000000000 -0700
+++ linux-2.4.22-nforce/Documentation/Configure.help	2003-09-29 18:29:11.000000000 -0700
@@ -3697,9 +3697,9 @@
   You should say Y here if you use XFree86 3.3.6 or 4.x and want to
   use GLX or DRI.  If unsure, say N.
 
-CONFIG_AGP_AMD_8151
+CONFIG_AGP_X86_64
   This option gives you AGP support for the GLX component of
-  XFree86 on AMD K8 with an AGP 8151 chipset.
+  XFree86 on AMD K8 with an AGP 8151 or NVIDIA nForce3 chipset.
 
   You should say Y here if you use XFree86 3.3.6 or 4.x and want to
   use GLX or DRI.  If unsure, say N.
diff -ru linux-2.4.22/drivers/char/agp/agpgart_be.c linux-2.4.22-nforce/drivers/char/agp/agpgart_be.c
--- linux-2.4.22/drivers/char/agp/agpgart_be.c	2003-08-25 04:44:41.000000000 -0700
+++ linux-2.4.22-nforce/drivers/char/agp/agpgart_be.c	2003-09-29 18:29:11.000000000 -0700
@@ -49,7 +49,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/page.h>
-#ifdef CONFIG_AGP_NVIDIA
+#if defined(CONFIG_AGP_NVIDIA) || defined(CONFIG_AGP_X86_64)
     #include <asm/msr.h>
 #endif
 
@@ -2744,7 +2744,7 @@
 
 #endif /* CONFIG_AGP_AMD */
 
-#ifdef CONFIG_AGP_AMD_8151
+#ifdef CONFIG_AGP_X86_64
 
 /* Begin AMD-8151 support */
 
@@ -3207,7 +3207,162 @@
 	(void) pdev; /* unused */
 }
 
-#endif /* CONFIG_AGP_AMD_8151 */
+
+/* NVIDIA x86-64 chipset support */
+ 
+
+static struct _nvidia_x86_64_private {
+	struct pci_dev *dev_1;
+} nvidia_x86_64_private;
+
+
+static int nvidia_init_iorr(u32 base, u32 size);
+
+
+static aper_size_info_32 nvidia_x86_64_sizes[5] =
+{
+	{512,  131072, 7, 0x00000000 },
+	{256,  65536,  6, 0x00000008 },
+	{128,  32768,  5, 0x0000000C },
+	{64,   16384,  4, 0x0000000E },
+	{32,   8192,   3, 0x0000000F }
+};
+
+
+static int nvidia_x86_64_configure(void)
+{
+	struct pci_dev *dev, *hammer=NULL;
+	int i, current_size, rc;
+	u32 tmp, apbase, apbar, aplimit;
+	unsigned long gatt_bus = virt_to_phys(agp_bridge.gatt_table_real);
+
+	if (!agp_bridge.dev) 
+		return -ENODEV;
+
+	/* configure AGP regs in each x86-64 host bridge */
+	pci_for_each_dev(dev) {
+		if (dev->bus->number==0 &&
+			PCI_FUNC(dev->devfn)==3 &&
+			PCI_SLOT(dev->devfn)>=24 && PCI_SLOT(dev->devfn)<=31) {
+			agp_bridge.gart_bus_addr = amd_x86_64_configure(dev,gatt_bus);
+			hammer = dev;
+		}
+	}
+	if (hammer == NULL)
+		return -ENODEV;
+
+	/* translate x86-64 aperture size to NVIDIA aperture size */
+	current_size = amd_x86_64_fetch_size();
+	for (i = 0 ; i < agp_bridge.num_aperture_sizes; i++) {
+		if (nvidia_x86_64_sizes[i].size == current_size)
+			break;
+	}
+	/* if x86-64 size does not match any NVIDIA size, exit here */
+	if (i == agp_bridge.num_aperture_sizes)
+		return -ENODEV;
+	pci_read_config_dword(nvidia_x86_64_private.dev_1, NVIDIA_X86_64_1_APSIZE, &tmp);
+	tmp &= ~(0xf);
+	tmp |= nvidia_x86_64_sizes[i].size_value;
+	pci_write_config_dword(nvidia_x86_64_private.dev_1, NVIDIA_X86_64_1_APSIZE, tmp);
+
+	/* shadow x86-64 registers into NVIDIA registers */
+	pci_read_config_dword (hammer, AMD_X86_64_GARTAPERTUREBASE, &apbase);
+	/* if x86-64 aperture base is beyond 4G, exit here */
+	if ( (apbase & 0x7fff) >> (32 - 25) )
+		 return -ENODEV;
+	apbase = (apbase & 0x7fff) << 25;
+	pci_read_config_dword(agp_bridge.dev, NVIDIA_X86_64_0_APBASE, &apbar);
+	apbar &= ~PCI_BASE_ADDRESS_MEM_MASK;
+	apbar |= apbase;
+	pci_write_config_dword(agp_bridge.dev, NVIDIA_X86_64_0_APBASE, apbar);
+	aplimit = apbase + (current_size * 1024 * 1024) - 1;
+	pci_write_config_dword(nvidia_x86_64_private.dev_1, NVIDIA_X86_64_1_APBASE1, apbase);
+	pci_write_config_dword(nvidia_x86_64_private.dev_1, NVIDIA_X86_64_1_APLIMIT1, aplimit);
+	pci_write_config_dword(nvidia_x86_64_private.dev_1, NVIDIA_X86_64_1_APBASE2, apbase);
+	pci_write_config_dword(nvidia_x86_64_private.dev_1, NVIDIA_X86_64_1_APLIMIT2, aplimit);
+
+	// update aperture IORR
+	if (0 != (rc = nvidia_init_iorr(apbase, current_size * 1024 * 1024)))
+		return rc;
+	
+	return 0;
+}
+
+
+static void nvidia_x86_64_cleanup(void)
+{
+	struct pci_dev *dev;
+	u32 tmp;
+
+	pci_for_each_dev(dev) {
+		/* disable gart translation */
+		if (dev->bus->number==0 && PCI_FUNC(dev->devfn)==3 &&
+		    (PCI_SLOT(dev->devfn) >=24) && (PCI_SLOT(dev->devfn) <=31)) {
+
+			pci_read_config_dword (dev, AMD_X86_64_GARTAPERTURECTL, &tmp);
+			tmp &= ~(AMD_X86_64_GARTEN);
+			pci_write_config_dword (dev, AMD_X86_64_GARTAPERTURECTL, tmp);
+		}
+	}
+}
+
+
+static unsigned long nvidia_x86_64_mask_memory(unsigned long addr, int type)
+{
+	return addr | agp_bridge.masks[0].mask;
+}
+
+
+static gatt_mask nvidia_x86_64_masks[] =
+{
+	{0x00000001, 0}
+};
+
+
+static int __init nvidia_x86_64_setup (struct pci_dev *pdev)
+{
+	nvidia_x86_64_private.dev_1 =
+		pci_find_slot((unsigned int)pdev->bus->number, PCI_DEVFN(11, 0));
+
+	if (nvidia_x86_64_private.dev_1 == NULL) {
+		printk(KERN_INFO PFX "agpgart: Detected an NVIDIA "
+			"nForce3 chipset, but could not find "
+			"the secondary device.\n");
+		agp_bridge.type = NOT_SUPPORTED;
+		return -ENODEV;
+	}
+
+	agp_bridge.masks = nvidia_x86_64_masks;
+	agp_bridge.aperture_sizes = (void *) nvidia_x86_64_sizes;
+	agp_bridge.size_type = U32_APER_SIZE;
+	agp_bridge.num_aperture_sizes = 5;
+	agp_bridge.dev_private_data = NULL;
+	agp_bridge.needs_scratch_page = FALSE;
+	agp_bridge.configure = nvidia_x86_64_configure;
+	agp_bridge.fetch_size = amd_x86_64_fetch_size;
+	agp_bridge.cleanup = nvidia_x86_64_cleanup;
+	agp_bridge.tlb_flush = amd_x86_64_tlbflush;
+	agp_bridge.mask_memory = nvidia_x86_64_mask_memory;
+	agp_bridge.agp_enable = agp_x86_64_agp_enable;
+	agp_bridge.cache_flush = global_cache_flush;
+	agp_bridge.create_gatt_table = agp_generic_create_gatt_table;
+	agp_bridge.free_gatt_table = agp_generic_free_gatt_table;
+	agp_bridge.insert_memory = x86_64_insert_memory;
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
+#endif /* CONFIG_AGP_X86_64 */
 
 #ifdef CONFIG_AGP_ALI
 
@@ -4060,6 +4215,8 @@
 	off_t pg_offset;
 } nvidia_private;
 
+static int nvidia_init_iorr(u32 base, u32 size);
+
 static int nvidia_fetch_size(void)
 {
 	int i;
@@ -4082,52 +4239,6 @@
 	return 0;
 }
 
-#define SYSCFG          0xC0010010
-#define IORR_BASE0      0xC0010016
-#define IORR_MASK0      0xC0010017
-#define AMD_K7_NUM_IORR 2
-
-static int nvidia_init_iorr(u32 base, u32 size)
-{
-	u32 base_hi, base_lo;
-	u32 mask_hi, mask_lo;
-	u32 sys_hi, sys_lo;
-	u32 iorr_addr, free_iorr_addr;
-
-	/* Find the iorr that is already used for the base */
-	/* If not found, determine the uppermost available iorr */
-	free_iorr_addr = AMD_K7_NUM_IORR;
-	for(iorr_addr = 0; iorr_addr < AMD_K7_NUM_IORR; iorr_addr++) {
-		rdmsr(IORR_BASE0 + 2 * iorr_addr, base_lo, base_hi);
-		rdmsr(IORR_MASK0 + 2 * iorr_addr, mask_lo, mask_hi);
-
-		if ((base_lo & 0xfffff000) == (base & 0xfffff000))
-			break;
-
-		if ((mask_lo & 0x00000800) == 0)
-			free_iorr_addr = iorr_addr;
-	}
-	
-	if (iorr_addr >= AMD_K7_NUM_IORR) {
-		iorr_addr = free_iorr_addr;
-		if (iorr_addr >= AMD_K7_NUM_IORR)
-			return -EINVAL;
-	}
-
-    base_hi = 0x0;
-    base_lo = (base & ~0xfff) | 0x18;
-    mask_hi = 0xf;
-    mask_lo = ((~(size - 1)) & 0xfffff000) | 0x800;
-    wrmsr(IORR_BASE0 + 2 * iorr_addr, base_lo, base_hi);
-    wrmsr(IORR_MASK0 + 2 * iorr_addr, mask_lo, mask_hi);
-
-    rdmsr(SYSCFG, sys_lo, sys_hi);
-    sys_lo |= 0x00100000;
-    wrmsr(SYSCFG, sys_lo, sys_hi);
-
-	return 0;
-}
-
 static int nvidia_configure(void)
 {
 	int i, rc, num_dirs;
@@ -4373,6 +4484,58 @@
 
 #endif /* CONFIG_AGP_NVIDIA */
 
+/* make IORR setup available to NVIDIA nForce/nForce2 support as well as to */
+/* NVIDIA nForce3 support in the x86-64 section. */
+#if defined(CONFIG_AGP_NVIDIA) || defined(CONFIG_AGP_X86_64)
+
+#define SYSCFG          0xC0010010
+#define IORR_BASE0      0xC0010016
+#define IORR_MASK0      0xC0010017
+#define AMD_K7_NUM_IORR 2
+
+static int nvidia_init_iorr(u32 base, u32 size)
+{
+	u32 base_hi, base_lo;
+	u32 mask_hi, mask_lo;
+	u32 sys_hi, sys_lo;
+	u32 iorr_addr, free_iorr_addr;
+
+	/* Find the iorr that is already used for the base */
+	/* If not found, determine the uppermost available iorr */
+	free_iorr_addr = AMD_K7_NUM_IORR;
+	for(iorr_addr = 0; iorr_addr < AMD_K7_NUM_IORR; iorr_addr++) {
+		rdmsr(IORR_BASE0 + 2 * iorr_addr, base_lo, base_hi);
+		rdmsr(IORR_MASK0 + 2 * iorr_addr, mask_lo, mask_hi);
+
+		if ((base_lo & 0xfffff000) == (base & 0xfffff000))
+			break;
+
+		if ((mask_lo & 0x00000800) == 0)
+			free_iorr_addr = iorr_addr;
+	}
+	
+	if (iorr_addr >= AMD_K7_NUM_IORR) {
+		iorr_addr = free_iorr_addr;
+		if (iorr_addr >= AMD_K7_NUM_IORR)
+			return -EINVAL;
+	}
+
+	base_hi = 0x0;
+	base_lo = (base & ~0xfff) | 0x18;
+	mask_hi = 0xf;
+	mask_lo = ((~(size - 1)) & 0xfffff000) | 0x800;
+	wrmsr(IORR_BASE0 + 2 * iorr_addr, base_lo, base_hi);
+	wrmsr(IORR_MASK0 + 2 * iorr_addr, mask_lo, mask_hi);
+
+	rdmsr(SYSCFG, sys_lo, sys_hi);
+	sys_lo |= 0x00100000;
+	wrmsr(SYSCFG, sys_lo, sys_hi);
+
+	return 0;
+}
+
+#endif /* defined(CONFIG_AGP_NVIDIA) || defined(CONFIG_AGP_X86_64) */
+
 #ifdef CONFIG_AGP_HP_ZX1
 
 #ifndef log2
@@ -4837,14 +5000,26 @@
 		amd_irongate_setup },
 #endif /* CONFIG_AGP_AMD */
 
-#ifdef CONFIG_AGP_AMD_8151
+#ifdef CONFIG_AGP_X86_64
 	{ PCI_DEVICE_ID_AMD_8151_0,
 		PCI_VENDOR_ID_AMD,
 		AMD_8151,
 		"AMD",
 		"8151",
 		amd_8151_setup },
-#endif /* CONFIG_AGP_AMD */
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE3,
+		PCI_VENDOR_ID_NVIDIA,
+		NVIDIA_NFORCE3,
+		"NVIDIA",
+		"nForce3",
+		nvidia_x86_64_setup },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S,
+		PCI_VENDOR_ID_NVIDIA,
+		NVIDIA_NFORCE3,
+		"NVIDIA",
+		"nForce3",
+		nvidia_x86_64_setup },
+#endif /* CONFIG_AGP_X86_64 */
 
 #ifdef CONFIG_AGP_INTEL
 	{ PCI_DEVICE_ID_INTEL_82443LX_0,
diff -ru linux-2.4.22/drivers/char/agp/agp.h linux-2.4.22-nforce/drivers/char/agp/agp.h
--- linux-2.4.22/drivers/char/agp/agp.h	2003-08-25 04:44:41.000000000 -0700
+++ linux-2.4.22-nforce/drivers/char/agp/agp.h	2003-09-29 18:29:11.000000000 -0700
@@ -466,6 +466,14 @@
 #define NVIDIA_3_APBASE     0x50
 #define NVIDIA_3_APLIMIT    0x54
 
+/* NVIDIA x86-64 registers */
+#define NVIDIA_X86_64_0_APBASE		0x10
+#define NVIDIA_X86_64_1_APBASE1		0x50
+#define NVIDIA_X86_64_1_APLIMIT1	0x54
+#define NVIDIA_X86_64_1_APSIZE		0xa8
+#define NVIDIA_X86_64_1_APBASE2		0xd8
+#define NVIDIA_X86_64_1_APLIMIT2	0xdc
+
 /* HP ZX1 SBA registers */
 #define HP_ZX1_CTRL		0x200
 #define HP_ZX1_IBASE		0x300
diff -ru linux-2.4.22/drivers/char/Config.in linux-2.4.22-nforce/drivers/char/Config.in
--- linux-2.4.22/drivers/char/Config.in	2003-08-25 04:44:41.000000000 -0700
+++ linux-2.4.22-nforce/drivers/char/Config.in	2003-09-29 18:29:11.000000000 -0700
@@ -294,7 +294,7 @@
 
 if [ "$CONFIG_GART_IOMMU" = "y" ]; then
 	bool '/dev/agpgart (AGP Support)' CONFIG_AGP
-	define_bool CONFIG_AGP_AMD_8151 y
+	define_bool CONFIG_AGP_X86_64 y
 else
 	tristate '/dev/agpgart (AGP Support)' CONFIG_AGP
 fi      
@@ -304,7 +304,7 @@
    bool '  VIA chipset support' CONFIG_AGP_VIA
    bool '  AMD Irongate, 761, and 762 support' CONFIG_AGP_AMD
    if [ "$CONFIG_GART_IOMMU" != "y" ]; then
-      bool '  AMD 8151 support' CONFIG_AGP_AMD_8151
+      bool '  x86-64 chipset support (AMD 8151, NVIDIA nForce3)' CONFIG_AGP_X86_64
    fi   
    bool '  Generic SiS support' CONFIG_AGP_SIS
    bool '  ALI chipset support' CONFIG_AGP_ALI
diff -ru linux-2.4.22/include/linux/agp_backend.h linux-2.4.22-nforce/include/linux/agp_backend.h
--- linux-2.4.22/include/linux/agp_backend.h	2003-08-25 04:44:44.000000000 -0700
+++ linux-2.4.22-nforce/include/linux/agp_backend.h	2003-09-29 18:29:11.000000000 -0700
@@ -88,6 +88,7 @@
 	SVWRKS_GENERIC,
 	NVIDIA_NFORCE,
 	NVIDIA_NFORCE2,
+	NVIDIA_NFORCE3,
 	NVIDIA_GENERIC,
 	HP_ZX1,
 };
diff -ru linux-2.4.22/include/linux/pci_ids.h linux-2.4.22-nforce/include/linux/pci_ids.h
--- linux-2.4.22/include/linux/pci_ids.h	2003-08-25 04:44:44.000000000 -0700
+++ linux-2.4.22-nforce/include/linux/pci_ids.h	2003-09-29 18:29:11.000000000 -0700
@@ -965,6 +965,8 @@
 #define PCI_DEVICE_ID_NVIDIA_UVTNT2		0x002D
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
 #define PCI_DEVICE_ID_NVIDIA_ITNT2		0x00A0
+#define PCI_DEVICE_ID_NVIDIA_NFORCE3		0x00d1
+#define PCI_DEVICE_ID_NVIDIA_NFORCE3S		0x00e1
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_SDR	0x0100
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_DDR	0x0101
 #define PCI_DEVICE_ID_NVIDIA_QUADRO		0x0103
@@ -977,7 +979,7 @@
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE2_ULTRA	0x0152
 #define PCI_DEVICE_ID_NVIDIA_QUADRO2_PRO	0x0153
 #define PCI_DEVICE_ID_NVIDIA_IGEFORCE2		0x01a0
-#define PCI_DEVICE_ID_NVIDIA_NFORCE		0x01a4
+#define PCI_DEVICE_ID_NVIDIA_NFORCE			0x01a4
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_IDE		0x01bc
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2		0x01e0
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3		0x0200

--98e8jtXdkpgskNou--
