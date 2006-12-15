Return-Path: <linux-kernel-owner+w=401wt.eu-S1752064AbWLOAUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbWLOAUM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbWLOAUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:20:11 -0500
Received: from 69-30-77-85.dq1sn.easystreet.com ([69.30.77.85]:59961 "EHLO
	vonnegut.anholt.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbWLOAUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:20:09 -0500
X-Greylist: delayed 705 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 19:20:07 EST
From: eric@anholt.net
To: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Cc: Eric Anholt <eric@anholt.net>
Subject: [PATCH] [AGP] Fix detection of aperture size versus GTT size on G965.
Date: Thu, 14 Dec 2006 16:06:15 -0800
Message-Id: <11661411753734-git-send-email-eric@anholt.net>
X-Mailer: git-send-email 1.4.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Anholt <eric@anholt.net>

On the G965, the GTT size may be larger than is required to cover the aperture.
(In fact, on all hardware we've seen, the GTT is 512KB to the aperture's
256MB).  A previous commit forced the aperture size to 512MB on G965 to match
GTT, which would likely result in hangs at best if users tried to rely on
agpgart's aperture size information.  Instead, we use the resource length for
the aperture size and the system's reported GTT size when available for the GTT
size.

Because the MSAC registers which had been read for aperture size detection on
i9xx chips just cause a change in the resource size, we can use generic code
for aperture detection on all i9xx.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/char/agp/agp.h       |    4 ++
 drivers/char/agp/intel-agp.c |  110 ++++++++++++++++++++++--------------------
 2 files changed, 62 insertions(+), 52 deletions(-)

diff --git a/drivers/char/agp/agp.h b/drivers/char/agp/agp.h
index 8b3317f..1d59e2a 100644
--- a/drivers/char/agp/agp.h
+++ b/drivers/char/agp/agp.h
@@ -225,6 +225,10 @@ struct agp_bridge_data {
 #define I810_GMS_DISABLE	0x00000000
 #define I810_PGETBL_CTL		0x2020
 #define I810_PGETBL_ENABLED	0x00000001
+#define I965_PGETBL_SIZE_MASK	0x0000000e
+#define I965_PGETBL_SIZE_512KB	(0 << 1)
+#define I965_PGETBL_SIZE_256KB	(1 << 1)
+#define I965_PGETBL_SIZE_128KB	(2 << 1)
 #define I810_DRAM_CTL		0x3000
 #define I810_DRAM_ROW_0		0x00000001
 #define I810_DRAM_ROW_0_SDRAM	0x00000001
diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
index 555b3a8..c99082b 100644
--- a/drivers/char/agp/intel-agp.c
+++ b/drivers/char/agp/intel-agp.c
@@ -370,6 +370,11 @@ static struct _intel_i830_private {
 	struct pci_dev *i830_dev;		/* device one */
 	volatile u8 __iomem *registers;
 	volatile u32 __iomem *gtt;		/* I915G */
+	/* gtt_entries is the number of gtt entries that are already mapped
+	 * to stolen memory.  Stolen memory is larger than the memory mapped
+	 * through gtt_entries, as it includes some reserved space for the BIOS
+	 * popup and for the GTT.
+	 */
 	int gtt_entries;
 } intel_i830_private;
 
@@ -380,14 +385,41 @@ static void intel_i830_init_gtt_entries(void)
 	u8 rdct;
 	int local = 0;
 	static const int ddt[4] = { 0, 16, 32, 64 };
-	int size;
+	int size; /* reserved space (in kb) at the top of stolen memory */
 
 	pci_read_config_word(agp_bridge->dev,I830_GMCH_CTRL,&gmch_ctrl);
 
-	/* We obtain the size of the GTT, which is also stored (for some
-	 * reason) at the top of stolen memory. Then we add 4KB to that
-	 * for the video BIOS popup, which is also stored in there. */
-	size = agp_bridge->driver->fetch_size() + 4;
+	if (IS_I965) {
+		u32 pgetbl_ctl;
+
+		pci_read_config_dword(agp_bridge->dev, I810_PGETBL_CTL,
+				      &pgetbl_ctl);
+		/* The 965 has a field telling us the size of the GTT,
+		 * which may be larger than what is necessary to map the
+		 * aperture.
+		 */
+		switch (pgetbl_ctl & I965_PGETBL_SIZE_MASK) {
+		case I965_PGETBL_SIZE_128KB:
+			size = 128;
+			break;
+		case I965_PGETBL_SIZE_256KB:
+			size = 256;
+			break;
+		case I965_PGETBL_SIZE_512KB:
+			size = 512;
+			break;
+		default:
+			printk(KERN_INFO PFX "Unknown page table size, "
+			       "assuming 512KB\n");
+			size = 512;
+		}
+		size += 4; /* add in BIOS popup space */
+	} else {
+		/* On previous hardware, the GTT size was just what was
+		 * required to map the aperture.
+		 */
+		size = agp_bridge->driver->fetch_size() + 4;
+	}
 
 	if (agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82830_HB ||
 	    agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82845G_HB) {
@@ -743,22 +775,27 @@ static int intel_i915_remove_entries(struct agp_memory *mem,off_t pg_start,
 	return 0;
 }
 
-static int intel_i915_fetch_size(void)
+/* Return the aperture size by just checking the resource length.  The effect
+ * described in the spec of the MSAC registers is just changing of the
+ * resource size.
+ */
+static int intel_i9xx_fetch_size(void)
 {
-	struct aper_size_info_fixed *values;
-	u32 temp, offset;
+	int num_sizes = sizeof(intel_i830_sizes) / sizeof(*intel_i830_sizes);
+	int aper_size; /* size in megabytes */
+	int i;
 
-#define I915_256MB_ADDRESS_MASK (1<<27)
+	aper_size = pci_resource_len(intel_i830_private.i830_dev, 2) / MB(1);
 
-	values = A_SIZE_FIX(agp_bridge->driver->aperture_sizes);
+	for (i = 0; i < num_sizes; i++) {
+		if (aper_size == intel_i830_sizes[i].size) {
+			agp_bridge->current_size = intel_i830_sizes + i;
+			agp_bridge->previous_size = agp_bridge->current_size;
+			return aper_size;
+		}
+	}
 
-	pci_read_config_dword(intel_i830_private.i830_dev, I915_GMADDR, &temp);
-	if (temp & I915_256MB_ADDRESS_MASK)
-		offset = 0;	/* 128MB aperture */
-	else
-		offset = 2;	/* 256MB aperture */
-	agp_bridge->previous_size = agp_bridge->current_size = (void *)(values + offset);
-	return values[offset].size;
+	return 0;
 }
 
 /* The intel i915 automatically initializes the agp aperture during POST.
@@ -821,40 +858,9 @@ static unsigned long intel_i965_mask_memory(struct agp_bridge_data *bridge,
 	return addr | bridge->driver->masks[type].mask;
 }
 
-static int intel_i965_fetch_size(void)
-{
-       struct aper_size_info_fixed *values;
-       u32 offset = 0;
-       u8 temp;
-
-#define I965_512MB_ADDRESS_MASK (3<<1)
-
-       values = A_SIZE_FIX(agp_bridge->driver->aperture_sizes);
-
-       pci_read_config_byte(intel_i830_private.i830_dev, I965_MSAC, &temp);
-       temp &= I965_512MB_ADDRESS_MASK;
-       switch (temp) {
-       case 0x00:
-               offset = 0; /* 128MB */
-               break;
-       case 0x06:
-               offset = 3; /* 512MB */
-               break;
-       default:
-       case 0x02:
-               offset = 2; /* 256MB */
-               break;
-       }
-
-       agp_bridge->previous_size = agp_bridge->current_size = (void *)(values + offset);
-
-	/* The i965 GTT is always sized as if it had a 512kB aperture size */
-	return 512;
-}
-
 /* The intel i965 automatically initializes the agp aperture during POST.
-+ * Use the memory already set aside for in the GTT.
-+ */
+ * Use the memory already set aside for in the GTT.
+ */
 static int intel_i965_create_gatt_table(struct agp_bridge_data *bridge)
 {
        int page_order;
@@ -1574,7 +1580,7 @@ static struct agp_bridge_driver intel_915_driver = {
 	.num_aperture_sizes	= 4,
 	.needs_scratch_page	= TRUE,
 	.configure		= intel_i915_configure,
-	.fetch_size		= intel_i915_fetch_size,
+	.fetch_size		= intel_i9xx_fetch_size,
 	.cleanup		= intel_i915_cleanup,
 	.tlb_flush		= intel_i810_tlbflush,
 	.mask_memory		= intel_i810_mask_memory,
@@ -1598,7 +1604,7 @@ static struct agp_bridge_driver intel_i965_driver = {
        .num_aperture_sizes     = 4,
        .needs_scratch_page     = TRUE,
        .configure              = intel_i915_configure,
-       .fetch_size             = intel_i965_fetch_size,
+       .fetch_size             = intel_i9xx_fetch_size,
        .cleanup                = intel_i915_cleanup,
        .tlb_flush              = intel_i810_tlbflush,
        .mask_memory            = intel_i965_mask_memory,
-- 
1.4.4.2

