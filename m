Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263707AbTHZM0o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 08:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbTHZM0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 08:26:37 -0400
Received: from ifi.informatik.uni-stuttgart.de ([129.69.211.1]:25340 "EHLO
	ifi.informatik.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id S263772AbTHZM0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 08:26:16 -0400
Date: Tue, 26 Aug 2003 14:26:12 +0200
From: "Marcelo E. Magallon" <mmagallo@debian.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH,BACKPORT] AGPGART support for Intel 7205/7505 chipsets
Message-ID: <20030826122611.GA26314@informatik.uni-stuttgart.de>
Mail-Followup-To: "Marcelo E. Magallon" <mmagallo@debian.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
X-Operating-System: Linux techno 2.4.21-ck1
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marcelo,

On Mon, Aug 04, 2003 at 02:39:55PM -0300, Marcelo Tosatti wrote:

 > I prefer this getting applied at 2.4.23-pre.

 Ok, here's the patch again against what's current in the BK tree.  I
 just checked that it still applies and works with 2.4.22.

 > >  The only hardware I have access to is from NVIDIA, which means I
 > >  haven't been able to test this with a non-tainted kernel, but I
 > >  don't expect this to be a problem.

 In the meanwhile I have verified that Radeon 9[578]00 cards also work.
 (ATI's drivers).

 Question for the list: the machines where I'm testing this have 4GB of
 RAM.  The MTRRs look like this after starting the X server:

reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
reg01: base=0x80000000 (2048MB), size=1024MB: write-back, count=1
reg02: base=0xc0000000 (3072MB), size= 512MB: write-back, count=1
reg03: base=0xd8000000 (3456MB), size= 128MB: uncachable, count=1
reg04: base=0x100000000 (4096MB), size=4096MB: write-back, count=1
reg05: base=0x200000000 (8192MB), size=8192MB: write-back, count=1
reg06: base=0xe0000000 (3584MB), size= 128MB: write-combining, count=1
reg07: base=0xf0000000 (3840MB), size=  64MB: write-combining, count=1

 6 and 7 are set up by the X server.  Originally 6 and 7 were two big
 (16 GB and 32 GB) areas (at 0x400000000 and 0x80000000).  After
 removing those by hand and starting the X server AGP works (in case of
 the ATI drivers, the X server won't even come up if AGP can't be
 enabled).

 The question is what are those areas for? (I mean 4 and 5 and the
 original 6 and 7)  There's no physical memory there...

 TIA,

 Marcelo

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="agpgart-i7505.diff"

Index: drivers/char/agp/agpgart_be.c
===================================================================
--- drivers/char/agp/agpgart_be.c	(revision 3835)
+++ drivers/char/agp/agpgart_be.c	(working copy)
@@ -1817,6 +1817,37 @@
 }
 
 
+static int intel_7505_configure(void)
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
+	/* mcgcfg */
+	pci_read_config_word(agp_bridge.dev, INTEL_I7505_MCHCFG, &temp2);
+	pci_write_config_word(agp_bridge.dev, INTEL_I7505_MCHCFG,
+			      temp2 | (1 << 9));
+	return 0;
+}
+
+
 static unsigned long intel_mask_memory(unsigned long addr, int type)
 {
 	/* Memory type is ignored */
@@ -2126,6 +2157,38 @@
 	(void) pdev; /* unused */
 }
 
+static int __init intel_7505_setup (struct pci_dev *pdev)
+{
+	agp_bridge.masks = intel_generic_masks;
+	agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
+	agp_bridge.size_type = U8_APER_SIZE;
+	agp_bridge.num_aperture_sizes = 7;
+	agp_bridge.dev_private_data = NULL;
+	agp_bridge.needs_scratch_page = FALSE;
+	agp_bridge.configure = intel_7505_configure;
+	agp_bridge.fetch_size = intel_8xx_fetch_size;
+	agp_bridge.cleanup = intel_8xx_cleanup;
+	agp_bridge.tlb_flush = intel_8xx_tlbflush;
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
 #endif /* CONFIG_AGP_INTEL */
 
 #ifdef CONFIG_AGP_VIA
@@ -4942,6 +5005,18 @@
 		"Intel",
 		"i860",
 		intel_860_setup },
+	{ PCI_DEVICE_ID_INTEL_7205_0,
+		PCI_VENDOR_ID_INTEL,
+		INTEL_I7205,
+		"Intel",
+		"i7205",
+		intel_7505_setup },
+	{ PCI_DEVICE_ID_INTEL_7505_0,
+		PCI_VENDOR_ID_INTEL,
+		INTEL_I7505,
+		"Intel",
+		"i7505",
+		intel_7505_setup },
 	{ 0,
 		PCI_VENDOR_ID_INTEL,
 		INTEL_GENERIC,
Index: drivers/char/agp/agp.h
===================================================================
--- drivers/char/agp/agp.h	(revision 3835)
+++ drivers/char/agp/agp.h	(working copy)
@@ -223,6 +223,12 @@
 #ifndef PCI_DEVICE_ID_INTEL_860_0
 #define PCI_DEVICE_ID_INTEL_860_0     0x2531
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_7205_0
+#define PCI_DEVICE_ID_INTEL_7205_0     0x255d
+#endif
+#ifndef PCI_DEVICE_ID_INTEL_7505_0
+#define PCI_DEVICE_ID_INTEL_7505_0     0x2550
+#endif
 #ifndef PCI_DEVICE_ID_INTEL_810_DC100_0
 #define PCI_DEVICE_ID_INTEL_810_DC100_0 0x7122
 #endif
@@ -366,6 +372,10 @@
 #define INTEL_I860_MCHCFG	0x50
 #define INTEL_I860_ERRSTS	0xc8
 
+/* intel i7505 registers */
+#define INTEL_I7505_MCHCFG	0x50
+#define INTEL_I7505_ERRSTS	0x42
+
 /* intel i810 registers */
 #define I810_GMADDR 0x10
 #define I810_MMADDR 0x14

--AhhlLboLdkugWU4S--
