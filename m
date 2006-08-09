Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWHITE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWHITE3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 15:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWHITE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 15:04:29 -0400
Received: from gabe.freedesktop.org ([131.252.208.82]:12257 "EHLO
	gabe.freedesktop.org") by vger.kernel.org with ESMTP
	id S1751268AbWHITE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 15:04:29 -0400
From: Eric Anholt <eric@anholt.net>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org, Alan Hourihane <alanh@tungstengraphics.com>,
       Eric Anholt <eric@anholt.net>
Subject: [PATCH] Add support for Intel i965G/Q GARTs.
Reply-To: Eric Anholt <eric@anholt.net>
Date: Wed, 09 Aug 2006 12:04:27 -0700
Message-Id: <11551502672606-git-send-email-eric@anholt.net>
X-Mailer: git-send-email 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Hourihane <alanh@tungstengraphics.com>

Signed-off-by: Eric Anholt <eric@anholt.net>


---

 drivers/char/agp/intel-agp.c |  167 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 162 insertions(+), 5 deletions(-)

0bc75aab93ee69dcf547ca55a8afcd1464dbfc95
diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
index 61ac380..c51b365 100644
--- a/drivers/char/agp/intel-agp.c
+++ b/drivers/char/agp/intel-agp.c
@@ -8,8 +8,15 @@
  *
  * Intel(R) 915G/915GM support added by Alan Hourihane
  * <alanh@tungstengraphics.com>.
+ *
+ * Intel(R) 945G/945GM support added by Alan Hourihane
+ * <alanh@tungstengraphics.com>.
+ *
+ * Intel(R) 946GZ/965Q/965G support added by Alan Hourihane
+ * <alanh@tungstengraphics.com>.
  */
 
+#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/init.h>
@@ -17,6 +24,22 @@ #include <linux/pagemap.h>
 #include <linux/agp_backend.h>
 #include "agp.h"
 
+/* Should be moved to include/linux/pci_ids.h */
+#define PCI_DEVICE_ID_INTEL_82946GZ_HB      0x2970
+#define PCI_DEVICE_ID_INTEL_82946GZ_IG      0x2972
+#define PCI_DEVICE_ID_INTEL_82965G_1_HB     0x2980
+#define PCI_DEVICE_ID_INTEL_82965G_1_IG     0x2982
+#define PCI_DEVICE_ID_INTEL_82965Q_HB       0x2990
+#define PCI_DEVICE_ID_INTEL_82965Q_IG       0x2992
+#define PCI_DEVICE_ID_INTEL_82965G_HB       0x29A0
+#define PCI_DEVICE_ID_INTEL_82965G_IG       0x29A2
+
+#define IS_I965 (agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82946GZ_HB || \
+                 agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82965G_1_HB || \
+                 agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82965Q_HB || \
+                 agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82965G_HB)
+
+
 /* Intel 815 register */
 #define INTEL_815_APCONT	0x51
 #define INTEL_815_ATTBASE_MASK	~0x1FFFFFFF
@@ -40,6 +63,8 @@ #define I915_PTEADDR	0x1C
 #define I915_GMCH_GMS_STOLEN_48M	(0x6 << 4)
 #define I915_GMCH_GMS_STOLEN_64M	(0x7 << 4)
 
+/* Intel 965G registers */
+#define I965_MSAC 0x62
 
 /* Intel 7505 registers */
 #define INTEL_I7505_APSIZE	0x74
@@ -354,6 +379,7 @@ static struct aper_size_info_fixed intel
 	/* The 64M mode still requires a 128k gatt */
 	{64, 16384, 5},
 	{256, 65536, 6},
+        {512, 131072, 7},
 };
 
 static struct _intel_i830_private {
@@ -377,7 +403,11 @@ static void intel_i830_init_gtt_entries(
 	/* We obtain the size of the GTT, which is also stored (for some
 	 * reason) at the top of stolen memory. Then we add 4KB to that
 	 * for the video BIOS popup, which is also stored in there. */
-	size = agp_bridge->driver->fetch_size() + 4;
+
+       if (IS_I965)
+               size = 512 + 4;
+       else
+               size = agp_bridge->driver->fetch_size() + 4;
 
 	if (agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82830_HB ||
 	    agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82845G_HB) {
@@ -423,7 +453,7 @@ static void intel_i830_init_gtt_entries(
 			if (agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915G_HB ||
 			    agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915GM_HB ||
 			    agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82945G_HB ||
-			    agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82945GM_HB)
+			    agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82945GM_HB || IS_I965 )
 				gtt_entries = MB(48) - KB(size);
 			else
 				gtt_entries = 0;
@@ -433,7 +463,7 @@ static void intel_i830_init_gtt_entries(
 			if (agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915G_HB ||
 			    agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915GM_HB ||
 			    agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82945G_HB ||
-			    agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82945GM_HB)
+			    agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82945GM_HB || IS_I965)
 				gtt_entries = MB(64) - KB(size);
 			else
 				gtt_entries = 0;
@@ -736,7 +766,7 @@ static int intel_i915_remove_entries(str
 static int intel_i915_fetch_size(void)
 {
 	struct aper_size_info_fixed *values;
-	u32 temp, offset;
+	u32 temp, offset = 0;
 
 #define I915_256MB_ADDRESS_MASK (1<<27)
 
@@ -791,6 +821,77 @@ static int intel_i915_create_gatt_table(
 
 	return 0;
 }
+static int intel_i965_fetch_size(void)
+{
+       struct aper_size_info_fixed *values;
+       u32 offset = 0;
+       u8 temp;
+
+#define I965_512MB_ADDRESS_MASK (3<<1)
+
+       values = A_SIZE_FIX(agp_bridge->driver->aperture_sizes);
+
+       pci_read_config_byte(intel_i830_private.i830_dev, I965_MSAC, &temp);
+       temp &= I965_512MB_ADDRESS_MASK;
+       switch (temp) {
+       case 0x00:
+               offset = 0; /* 128MB */
+               break;
+       case 0x06:
+               offset = 3; /* 512MB */
+               break;
+       default:
+       case 0x02:
+               offset = 2; /* 256MB */
+               break;
+       }
+
+       agp_bridge->previous_size = agp_bridge->current_size = (void *)(values + offset);
+
+       return values[offset].size;
+}
+
+/* The intel i965 automatically initializes the agp aperture during POST.
++ * Use the memory already set aside for in the GTT.
++ */
+static int intel_i965_create_gatt_table(struct agp_bridge_data *bridge)
+{
+       int page_order;
+       struct aper_size_info_fixed *size;
+       int num_entries;
+       u32 temp;
+
+       size = agp_bridge->current_size;
+       page_order = size->page_order;
+       num_entries = size->num_entries;
+       agp_bridge->gatt_table_real = NULL;
+
+       pci_read_config_dword(intel_i830_private.i830_dev, I915_MMADDR, &temp);
+
+       temp &= 0xfff00000;
+       intel_i830_private.gtt = ioremap((temp + (512 * 1024)) , 512 * 1024);
+
+       if (!intel_i830_private.gtt)
+               return -ENOMEM;
+
+
+       intel_i830_private.registers = ioremap(temp,128 * 4096);
+       if (!intel_i830_private.registers)
+               return -ENOMEM;
+
+       temp = readl(intel_i830_private.registers+I810_PGETBL_CTL) & 0xfffff000;
+       global_cache_flush();   /* FIXME: ? */
+
+       /* we have to call this as early as possible after the MMIO base address is known */
+       intel_i830_init_gtt_entries();
+
+       agp_bridge->gatt_table = NULL;
+
+       agp_bridge->gatt_bus_addr = temp;
+
+       return 0;
+}
+
 
 static int intel_fetch_size(void)
 {
@@ -1469,7 +1570,7 @@ static struct agp_bridge_driver intel_91
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= intel_i830_sizes,
 	.size_type		= FIXED_APER_SIZE,
-	.num_aperture_sizes	= 3,
+	.num_aperture_sizes	= 4,
 	.needs_scratch_page	= TRUE,
 	.configure		= intel_i915_configure,
 	.fetch_size		= intel_i915_fetch_size,
@@ -1489,6 +1590,29 @@ static struct agp_bridge_driver intel_91
 	.agp_destroy_page	= agp_generic_destroy_page,
 };
 
+static struct agp_bridge_driver intel_i965_driver = {
+       .owner                  = THIS_MODULE,
+       .aperture_sizes         = intel_i830_sizes,
+       .size_type              = FIXED_APER_SIZE,
+       .num_aperture_sizes     = 4,
+       .needs_scratch_page     = TRUE,
+       .configure              = intel_i915_configure,
+       .fetch_size             = intel_i965_fetch_size,
+       .cleanup                = intel_i915_cleanup,
+       .tlb_flush              = intel_i810_tlbflush,
+       .mask_memory            = intel_i810_mask_memory,
+       .masks                  = intel_i810_masks,
+       .agp_enable             = intel_i810_agp_enable,
+       .cache_flush            = global_cache_flush,
+       .create_gatt_table      = intel_i965_create_gatt_table,
+       .free_gatt_table        = intel_i830_free_gatt_table,
+       .insert_memory          = intel_i915_insert_entries,
+       .remove_memory          = intel_i915_remove_entries,
+       .alloc_by_type          = intel_i830_alloc_by_type,
+       .free_by_type           = intel_i810_free_by_type,
+       .agp_alloc_page         = agp_generic_alloc_page,
+       .agp_destroy_page       = agp_generic_destroy_page,
+};
 
 static struct agp_bridge_driver intel_7505_driver = {
 	.owner			= THIS_MODULE,
@@ -1684,6 +1808,35 @@ static int __devinit agp_intel_probe(str
 			bridge->driver = &intel_845_driver;
 		name = "945GM";
 		break;
+       case PCI_DEVICE_ID_INTEL_82946GZ_HB:
+               if (find_i830(PCI_DEVICE_ID_INTEL_82946GZ_IG))
+                       bridge->driver = &intel_i965_driver;
+               else
+                       bridge->driver = &intel_845_driver;
+               name = "946GZ";
+               break;
+       case PCI_DEVICE_ID_INTEL_82965G_1_HB:
+               if (find_i830(PCI_DEVICE_ID_INTEL_82965G_1_IG))
+                       bridge->driver = &intel_i965_driver;
+               else
+                       bridge->driver = &intel_845_driver;
+               name = "965G";
+               break;
+       case PCI_DEVICE_ID_INTEL_82965Q_HB:
+               if (find_i830(PCI_DEVICE_ID_INTEL_82965Q_IG))
+                       bridge->driver = &intel_i965_driver;
+               else
+                       bridge->driver = &intel_845_driver;
+               name = "965Q";
+               break;
+       case PCI_DEVICE_ID_INTEL_82965G_HB:
+               if (find_i830(PCI_DEVICE_ID_INTEL_82965G_IG))
+                       bridge->driver = &intel_i965_driver;
+               else
+                       bridge->driver = &intel_845_driver;
+               name = "965G";
+               break;
+
 	case PCI_DEVICE_ID_INTEL_7505_0:
 		bridge->driver = &intel_7505_driver;
 		name = "E7505";
@@ -1825,6 +1978,10 @@ #define ID(x)						\
 	ID(PCI_DEVICE_ID_INTEL_82915GM_HB),
 	ID(PCI_DEVICE_ID_INTEL_82945G_HB),
 	ID(PCI_DEVICE_ID_INTEL_82945GM_HB),
+        ID(PCI_DEVICE_ID_INTEL_82946GZ_HB),
+        ID(PCI_DEVICE_ID_INTEL_82965G_1_HB),
+        ID(PCI_DEVICE_ID_INTEL_82965Q_HB),
+        ID(PCI_DEVICE_ID_INTEL_82965G_HB),
 	{ }
 };
 
-- 
1.3.0.g34962

