Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbTF1Bcy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 21:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265007AbTF1Bcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 21:32:54 -0400
Received: from smtp1.brturbo.com ([200.199.201.21]:28584 "EHLO
	smtp.brturbo.com") by vger.kernel.org with ESMTP id S265002AbTF1Bcn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 21:32:43 -0400
From: Marcelo Penna Guerra <eu@marcelopenna.org>
To: Fridtjof Busse <Fridtjof.Busse@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: AGPGART for nForce2?
Date: Fri, 27 Jun 2003 22:48:29 -0300
User-Agent: KMail/1.5.9
References: <29148.1056701891@www25.gmx.net>
In-Reply-To: <29148.1056701891@www25.gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tPP/+yrdvOXgyVw"
Message-Id: <200306272248.29654.eu@marcelopenna.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_tPP/+yrdvOXgyVw
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This is the original nvidia agpgart patch from 261 drivers with the 
modifications needed to work with 2.4.21+ kernels. If you have any doubts, go 
to the forum on nforcershq.com. Good luck.

By the way, I hope to see it in 2.4.22 too. A lot of people in nforcershq.com 
have been using this patch or 2.4.21-ac* without any problems.

Marcelo Penna Guerra

On Friday 27 June 2003 05:18, Fridtjof Busse wrote:
> Hi
> Is there going to be support for the nForce2 AGP in 2.4.22? AFAIK it's
> already
> in 2.5, but the nvidia-patch only works with 2.4.20, not with 2.4.21.
> Are there any plans to backport AGP-support from 2.5 or modify the
> nvidia-patch to work with 2.4.21/2.4.22?
> Please CC me.
> Thanks.

--Boundary-00=_tPP/+yrdvOXgyVw
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="linux-2.4.21-agpgart.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.4.21-agpgart.diff"

diff -ru linux-2.4.20/Documentation/Configure.help linux-2.4.20-nforce/Documentation/Configure.help
--- linux-2.4.20/Documentation/Configure.help	2002-11-28 15:53:08.000000000 -0800
+++ linux-2.4.20-nforce/Documentation/Configure.help	2003-04-22 21:52:46.000000000 -0700
@@ -3559,6 +3559,14 @@
   Say Y here to support the Serverworks AGP card.  See 
   <http://www.serverworks.com/> for product descriptions and images.
 
+NVIDIA chipset support
+CONFIG_AGP_NVIDIA
+  This option gives you AGP support for the GLX component of the
+  XFree86 4.x on NVIDIA nForce/nForce2 chipsets.
+
+  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
+  use GLX or DRI.  If unsure, say N.
+
 ALI chipset support
 CONFIG_AGP_ALI
   This option gives you AGP support for the GLX component of the
diff -ru linux-2.4.20/arch/i386/defconfig linux-2.4.20-nforce/arch/i386/defconfig
--- linux-2.4.20/arch/i386/defconfig	2002-11-28 15:53:09.000000000 -0800
+++ linux-2.4.20-nforce/arch/i386/defconfig	2003-04-22 21:52:46.000000000 -0700
@@ -607,6 +607,7 @@
 CONFIG_AGP_SIS=y
 CONFIG_AGP_ALI=y
 # CONFIG_AGP_SWORKS is not set
+CONFIG_AGP_NVIDIA=y
 CONFIG_DRM=y
 # CONFIG_DRM_OLD is not set
 
diff -ru linux-2.4.20/drivers/char/Config.in linux-2.4.20-nforce/drivers/char/Config.in
--- linux-2.4.20/drivers/char/Config.in	2002-11-28 15:53:12.000000000 -0800
+++ linux-2.4.20-nforce/drivers/char/Config.in	2003-04-22 21:52:46.000000000 -0700
@@ -288,6 +288,9 @@
    bool '  Generic SiS support' CONFIG_AGP_SIS
    bool '  ALI chipset support' CONFIG_AGP_ALI
    bool '  Serverworks LE/HE support' CONFIG_AGP_SWORKS
+   if [ "$CONFIG_X86" = "y" ]; then
+      bool '  NVIDIA chipset support' CONFIG_AGP_NVIDIA
+   fi
    if [ "$CONFIG_IA64" = "y" ]; then
       bool '  HP ZX1 AGP support' CONFIG_AGP_HP_ZX1
    fi
diff -ru linux-2.4.20/drivers/char/agp/agp.h linux-2.4.20-nforce/drivers/char/agp/agp.h
--- linux-2.4.20/drivers/char/agp/agp.h	2002-11-28 15:53:12.000000000 -0800
+++ linux-2.4.20-nforce/drivers/char/agp/agp.h	2003-04-22 21:52:46.000000000 -0700
@@ -412,6 +412,17 @@
 #define SVWRKS_POSTFLUSH  0x14
 #define SVWRKS_DIRFLUSH   0x0c
 
+/* NVIDIA registers */
+#define NVIDIA_0_APBASE     0x10
+#define NVIDIA_0_APSIZE     0x80
+#define NVIDIA_1_WBC        0xf0
+#define NVIDIA_2_GARTCTRL   0xd0
+#define NVIDIA_2_APBASE     0xd8
+#define NVIDIA_2_APLIMIT    0xdc
+#define NVIDIA_2_ATTBASE(i) (0xe0 + (i) * 4)
+#define NVIDIA_3_APBASE     0x50
+#define NVIDIA_3_APLIMIT    0x54
+
 /* HP ZX1 SBA registers */
 #define HP_ZX1_CTRL		0x200
 #define HP_ZX1_IBASE		0x300
diff -ru linux-2.4.20/drivers/char/agp/agpgart_be.c linux-2.4.20-nforce/drivers/char/agp/agpgart_be.c
--- linux-2.4.20/drivers/char/agp/agpgart_be.c	2002-11-28 15:53:12.000000000 -0800
+++ linux-2.4.20-nforce/drivers/char/agp/agpgart_be.c	2003-04-22 21:52:46.000000000 -0700
@@ -43,6 +43,9 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/page.h>
+#ifdef CONFIG_AGP_NVIDIA
+    #include <asm/msr.h>
+#endif
 
 #include <linux/agp_backend.h>
 #include "agp.h"
@@ -4028,6 +4031,330 @@
 
 #endif /* CONFIG_AGP_SWORKS */
 
+#ifdef CONFIG_AGP_NVIDIA
+
+static struct _nvidia_private {
+	struct pci_dev *dev_1;
+	struct pci_dev *dev_2;
+	struct pci_dev *dev_3;
+	volatile u32 *aperture;
+	int num_active_entries;
+	off_t pg_offset;
+} nvidia_private;
+
+static int nvidia_fetch_size(void)
+{
+	int i;
+	u8 size_value;
+	aper_size_info_8 *values;
+
+	pci_read_config_byte(agp_bridge.dev, NVIDIA_0_APSIZE, &size_value);
+	size_value &= 0x0f;
+	values = A_SIZE_8(agp_bridge.aperture_sizes);
+
+	for (i = 0; i < agp_bridge.num_aperture_sizes; i++) {
+		if (size_value == values[i].size_value) {
+			agp_bridge.previous_size =
+				agp_bridge.current_size = (void *) (values + i);
+			agp_bridge.aperture_size_idx = i;
+			return values[i].size;
+		}
+	}
+
+	return 0;
+}
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
+    base_hi = 0x0;
+    base_lo = (base & ~0xfff) | 0x18;
+    mask_hi = 0xf;
+    mask_lo = ((~(size - 1)) & 0xfffff000) | 0x800;
+    wrmsr(IORR_BASE0 + 2 * iorr_addr, base_lo, base_hi);
+    wrmsr(IORR_MASK0 + 2 * iorr_addr, mask_lo, mask_hi);
+
+    rdmsr(SYSCFG, sys_lo, sys_hi);
+    sys_lo |= 0x00100000;
+    wrmsr(SYSCFG, sys_lo, sys_hi);
+
+	return 0;
+}
+
+static int nvidia_configure(void)
+{
+	int i, rc, num_dirs;
+	u32 apbase, aplimit;
+	aper_size_info_8 *current_size;
+	u32 temp;
+
+	current_size = A_SIZE_8(agp_bridge.current_size);
+
+	/* aperture size */
+	pci_write_config_byte(agp_bridge.dev, NVIDIA_0_APSIZE,
+		current_size->size_value);
+
+    /* address to map to */
+	pci_read_config_dword(agp_bridge.dev, NVIDIA_0_APBASE, &apbase);
+	apbase &= PCI_BASE_ADDRESS_MEM_MASK;
+	agp_bridge.gart_bus_addr = apbase;
+	aplimit = apbase + (current_size->size * 1024 * 1024) - 1;
+	pci_write_config_dword(nvidia_private.dev_2, NVIDIA_2_APBASE, apbase);
+	pci_write_config_dword(nvidia_private.dev_2, NVIDIA_2_APLIMIT, aplimit);
+	pci_write_config_dword(nvidia_private.dev_3, NVIDIA_3_APBASE, apbase);
+	pci_write_config_dword(nvidia_private.dev_3, NVIDIA_3_APLIMIT, aplimit);
+	if (0 != (rc = nvidia_init_iorr(apbase, current_size->size * 1024 * 1024)))
+		return rc;
+
+	/* directory size is 64k */
+	num_dirs = current_size->size / 64;
+	nvidia_private.num_active_entries = current_size->num_entries;
+	nvidia_private.pg_offset = 0;
+	if (num_dirs == 0) {
+		num_dirs = 1;
+		nvidia_private.num_active_entries /= (64 / current_size->size);
+		nvidia_private.pg_offset = (apbase & (64 * 1024 * 1024 - 1) &
+			~(current_size->size * 1024 * 1024 - 1)) / PAGE_SIZE;
+	}
+
+	/* attbase */
+	for(i = 0; i < 8; i++) {
+		pci_write_config_dword(nvidia_private.dev_2, NVIDIA_2_ATTBASE(i),
+			(agp_bridge.gatt_bus_addr + (i % num_dirs) * 64 * 1024) | 1);
+	}
+
+	/* gtlb control */
+	pci_read_config_dword(nvidia_private.dev_2, NVIDIA_2_GARTCTRL, &temp);
+	pci_write_config_dword(nvidia_private.dev_2, NVIDIA_2_GARTCTRL,
+		temp | 0x11);
+
+	/* gart control */
+	pci_read_config_dword(agp_bridge.dev, NVIDIA_0_APSIZE, &temp);
+	pci_write_config_dword(agp_bridge.dev, NVIDIA_0_APSIZE,
+		temp | 0x100);
+
+	/* map aperture */
+	nvidia_private.aperture =
+		(volatile u32 *) ioremap(apbase, 33 * PAGE_SIZE);
+
+	return 0;
+}
+
+static void nvidia_cleanup(void)
+{
+	aper_size_info_8 *previous_size;
+	u32 temp;
+
+	/* gart control */
+	pci_read_config_dword(agp_bridge.dev, NVIDIA_0_APSIZE, &temp);
+	pci_write_config_dword(agp_bridge.dev, NVIDIA_0_APSIZE,
+		temp & ~(0x100));
+
+	/* gtlb control */
+	pci_read_config_dword(nvidia_private.dev_2, NVIDIA_2_GARTCTRL, &temp);
+	pci_write_config_dword(nvidia_private.dev_2, NVIDIA_2_GARTCTRL,
+		temp & ~(0x11));
+
+	/* unmap aperture */
+	iounmap((void *) nvidia_private.aperture);
+
+	/* restore previous aperture size */
+	previous_size = A_SIZE_8(agp_bridge.previous_size);
+	pci_write_config_byte(agp_bridge.dev, NVIDIA_0_APSIZE,
+		previous_size->size_value);
+
+	/* restore iorr for previous aperture size */
+	nvidia_init_iorr(agp_bridge.gart_bus_addr,
+		previous_size->size * 1024 * 1024);
+}
+
+static void nvidia_tlbflush(agp_memory * mem)
+{
+	int i;
+	unsigned long end;
+	u32 wbc_reg, wbc_mask, temp;
+
+	/* flush chipset */
+	switch(agp_bridge.type) {
+	case NVIDIA_NFORCE:
+		wbc_mask = 0x00010000;
+		break;
+	case NVIDIA_NFORCE2:
+		wbc_mask = 0x80000000;
+		break;
+	default:
+		wbc_mask = 0;
+		break;
+	}
+
+	if (wbc_mask) {
+		pci_read_config_dword(nvidia_private.dev_1, NVIDIA_1_WBC, &wbc_reg);
+		wbc_reg |= wbc_mask;
+		pci_write_config_dword(nvidia_private.dev_1, NVIDIA_1_WBC, wbc_reg);
+
+		end = jiffies + 3*HZ;
+		do {
+			pci_read_config_dword(nvidia_private.dev_1, NVIDIA_1_WBC, &wbc_reg);
+			if ((signed)(end - jiffies) <= 0) {
+				printk(KERN_ERR "TLB flush took more than 3 seconds.\n");
+			}
+		} while (wbc_reg & wbc_mask);
+	}
+
+	/* flush TLB entries */
+	for(i = 0; i < 32 + 1; i++)
+		temp = nvidia_private.aperture[i * PAGE_SIZE / sizeof(u32)];
+	for(i = 0; i < 32 + 1; i++)
+		temp = nvidia_private.aperture[i * PAGE_SIZE / sizeof(u32)];
+}
+
+static unsigned long nvidia_mask_memory(unsigned long addr, int type)
+{
+	/* Memory type is ignored */
+
+	return addr | agp_bridge.masks[0].mask;
+}
+
+static int nvidia_insert_memory(agp_memory * mem,
+				     off_t pg_start, int type)
+{
+	int i, j;
+	
+	if ((type != 0) || (mem->type != 0))
+		return -EINVAL;
+	
+	if ((pg_start + mem->page_count) >
+		(nvidia_private.num_active_entries - agp_memory_reserved/PAGE_SIZE))
+		return -EINVAL;
+	
+	for(j = pg_start; j < (pg_start + mem->page_count); j++) {
+		if (!PGE_EMPTY(agp_bridge.gatt_table[nvidia_private.pg_offset + j])) {
+			return -EBUSY;
+		}
+	}
+
+	if (mem->is_flushed == FALSE) {
+		CACHE_FLUSH();
+		mem->is_flushed = TRUE;
+	}
+	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
+		agp_bridge.gatt_table[nvidia_private.pg_offset + j] = agp_bridge.mask_memory(mem->memory[i], mem->type);
+	}
+
+	agp_bridge.tlb_flush(mem);
+	return 0;
+}
+
+static int nvidia_remove_memory(agp_memory * mem, off_t pg_start,
+				     int type)
+{
+	int i;
+
+	if ((type != 0) || (mem->type != 0))
+		return -EINVAL;
+	
+	for (i = pg_start; i < (mem->page_count + pg_start); i++) {
+		agp_bridge.gatt_table[nvidia_private.pg_offset + i] =
+		    (unsigned long) agp_bridge.scratch_page;
+	}
+
+	agp_bridge.tlb_flush(mem);
+	return 0;
+}
+
+static aper_size_info_8 nvidia_generic_sizes[5] =
+{
+	{512, 131072, 7, 0},
+	{256, 65536, 6, 8},
+	{128, 32768, 5, 12},
+	{64, 16384, 4, 14},
+	/* The 32M mode still requires a 64k gatt */
+	{32, 16384, 4, 15}
+};
+
+static gatt_mask nvidia_generic_masks[] =
+{
+	{0x00000001, 0}
+};
+
+static int __init nvidia_generic_setup (struct pci_dev *pdev)
+{
+	nvidia_private.dev_1 =
+		pci_find_slot((unsigned int)pdev->bus->number, PCI_DEVFN(0, 1));
+	nvidia_private.dev_2 =
+		pci_find_slot((unsigned int)pdev->bus->number, PCI_DEVFN(0, 2));
+	nvidia_private.dev_3 =
+		pci_find_slot((unsigned int)pdev->bus->number, PCI_DEVFN(30, 0));
+	
+	if((nvidia_private.dev_1 == NULL) ||
+		(nvidia_private.dev_2 == NULL) ||
+		(nvidia_private.dev_3 == NULL)) {
+		printk(KERN_INFO PFX "agpgart: Detected an NVIDIA "
+			"nForce/nForce2 chipset, but could not find "
+			"the secondary devices.\n");
+		agp_bridge.type = NOT_SUPPORTED;
+		return -ENODEV;
+	}
+
+	agp_bridge.masks = nvidia_generic_masks;
+	agp_bridge.aperture_sizes = (void *) nvidia_generic_sizes;
+	agp_bridge.size_type = U8_APER_SIZE;
+	agp_bridge.num_aperture_sizes = 5;
+	agp_bridge.dev_private_data = (void *) &nvidia_private;
+	agp_bridge.needs_scratch_page = FALSE;
+	agp_bridge.configure = nvidia_configure;
+	agp_bridge.fetch_size = nvidia_fetch_size;
+	agp_bridge.cleanup = nvidia_cleanup;
+	agp_bridge.tlb_flush = nvidia_tlbflush;
+	agp_bridge.mask_memory = nvidia_mask_memory;
+	agp_bridge.agp_enable = agp_generic_agp_enable;
+	agp_bridge.cache_flush = global_cache_flush;
+	agp_bridge.create_gatt_table = agp_generic_create_gatt_table;
+	agp_bridge.free_gatt_table = agp_generic_free_gatt_table;
+	agp_bridge.insert_memory = nvidia_insert_memory;
+	agp_bridge.remove_memory = nvidia_remove_memory;
+	agp_bridge.alloc_by_type = agp_generic_alloc_by_type;
+	agp_bridge.free_by_type = agp_generic_free_by_type;
+	agp_bridge.agp_alloc_page = agp_generic_alloc_page;
+	agp_bridge.agp_destroy_page = agp_generic_destroy_page;
+	agp_bridge.suspend = agp_generic_suspend;
+	agp_bridge.resume = agp_generic_resume;
+	agp_bridge.cant_use_aperture = 0;
+
+	return 0;
+}
+
+#endif /* CONFIG_AGP_NVIDIA */
+
 #ifdef CONFIG_AGP_HP_ZX1
 
 #ifndef log2
@@ -4722,6 +5050,27 @@
 		via_generic_setup },
 #endif /* CONFIG_AGP_VIA */
 
+#ifdef CONFIG_AGP_NVIDIA
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE,
+		PCI_VENDOR_ID_NVIDIA,
+		NVIDIA_NFORCE,
+		"NVIDIA",
+		"nForce",
+		nvidia_generic_setup },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE2,
+		PCI_VENDOR_ID_NVIDIA,
+		NVIDIA_NFORCE2,
+		"NVIDIA",
+		"nForce2",
+		nvidia_generic_setup },
+	{ 0,
+		PCI_VENDOR_ID_NVIDIA,
+		NVIDIA_GENERIC,
+		"NVIDIA",
+		"Generic",
+		nvidia_generic_setup },
+#endif /* CONFIG_AGP_NVIDIA */
+
 #ifdef CONFIG_AGP_HP_ZX1
 	{ PCI_DEVICE_ID_HP_ZX1_LBA,
 		PCI_VENDOR_ID_HP,
diff -ru linux-2.4.20/include/linux/agp_backend.h linux-2.4.20-nforce/include/linux/agp_backend.h
--- linux-2.4.20/include/linux/agp_backend.h	2002-11-28 15:53:15.000000000 -0800
+++ linux-2.4.20-nforce/include/linux/agp_backend.h	2003-04-22 21:52:46.000000000 -0700
@@ -79,6 +79,9 @@
 	SVWRKS_HE,
 	SVWRKS_LE,
 	SVWRKS_GENERIC,
+	NVIDIA_NFORCE,
+	NVIDIA_NFORCE2,
+	NVIDIA_GENERIC,
 	HP_ZX1,
 };
 
diff -ru linux-2.4.20/include/linux/pci_ids.h linux-2.4.20-nforce/include/linux/pci_ids.h
--- linux-2.4.20/include/linux/pci_ids.h	2002-11-28 15:53:15.000000000 -0800
+++ linux-2.4.20-nforce/include/linux/pci_ids.h	2003-04-22 21:52:46.000000000 -0700
@@ -884,6 +884,8 @@
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE2_GTS2	0x0151
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE2_ULTRA	0x0152
 #define PCI_DEVICE_ID_NVIDIA_QUADRO2_PRO	0x0153
+#define PCI_DEVICE_ID_NVIDIA_NFORCE		0x01a4
+#define PCI_DEVICE_ID_NVIDIA_NFORCE2		0x01e0
 #define PCI_DEVICE_ID_NVIDIA_IGEFORCE2		0x01a0
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3		0x0200
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3_1		0x0201

--Boundary-00=_tPP/+yrdvOXgyVw--
