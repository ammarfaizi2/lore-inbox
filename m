Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269969AbTGQICa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 04:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271119AbTGQICa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 04:02:30 -0400
Received: from ifi.informatik.uni-stuttgart.de ([129.69.211.1]:44970 "EHLO
	ifi.informatik.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id S269969AbTGQICW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 04:02:22 -0400
Date: Thu, 17 Jul 2003 10:17:13 +0200
From: "Marcelo E. Magallon" <mmagallo@debian.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.4.22-pre4] AGPGART for i7205/i7505
Message-ID: <20030717081713.GA19027@informatik.uni-stuttgart.de>
Mail-Followup-To: "Marcelo E. Magallon" <mmagallo@debian.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
X-Operating-System: Linux techno 2.4.21-ck1
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

 [ Please Cc: mmagallo@debian.org, I'm not subscribed to the list. ]

 attached is a patch to add support for i7205/i7505 to the 2.4.22-pre4
 kernel (it should apply to newer -pre's).  I only looked at the driver
 in 2.5 and AFAICS this is really the only thing needed (Dave, please
 correct me).  Alas, the NVIDIA binary-only drivers don't like it.  I
 have tried 2.6.0-pre1 on the same machine and it doesn't work with that
 either.  I haven't been able to test with anything else yet.

 Another problem I had, in agp_find_max it reads something like:

    long memory, index, result;
    memory = (num_physpages << PAGE_SHIFT) >> 20;

 I have 4 GB of memory on this box and the function reports the maximum
 agp memory to be 0 MB.  It's clear why, num_physpages << PAGE_SHIFT is
 zero in this case.  Something like:

    if (PAGE_SHIFT > 20)
        memory = num_physpages << (PAGE_SHIFT - 20)
    else
        memory = num_physpages >> (20 - PAGE_SHIFT)

 should do the trick.

 Marcelo

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.21_15_agpgart.diff"

diff -ruN linux-2.4.21/drivers/char/agp/agp.h linux-2.4.22-pre4+p4/drivers/char/agp/agp.h
--- linux-2.4.21/drivers/char/agp/agp.h	2003-07-15 11:38:50.000000000 +0200
+++ linux-2.4.22-pre4+p4/drivers/char/agp/agp.h	2003-07-15 11:28:34.000000000 +0200
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
diff -ruN linux-2.4.21/drivers/char/agp/agpgart_be.c linux-2.4.22-pre4+p4/drivers/char/agp/agpgart_be.c
--- linux-2.4.21/drivers/char/agp/agpgart_be.c	2003-07-15 11:38:50.000000000 +0200
+++ linux-2.4.22-pre4+p4/drivers/char/agp/agpgart_be.c	2003-07-15 11:31:11.000000000 +0200
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
diff -ruN linux-2.4.21/include/linux/agp_backend.h linux-2.4.22-pre4+p4/include/linux/agp_backend.h
--- linux-2.4.21/include/linux/agp_backend.h	2003-07-15 11:39:15.000000000 +0200
+++ linux-2.4.22-pre4+p4/include/linux/agp_backend.h	2003-07-15 11:30:11.000000000 +0200
@@ -55,6 +55,8 @@
 	INTEL_I855_PM,
 	INTEL_I860,
 	INTEL_I865_G,
+	INTEL_I7205,
+	INTEL_I7505,
 	VIA_GENERIC,
 	VIA_VP3,
 	VIA_MVP3,

--x+6KMIRAuhnl3hBn--
