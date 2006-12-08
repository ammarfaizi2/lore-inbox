Return-Path: <linux-kernel-owner+w=401wt.eu-S1760809AbWLHSZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760809AbWLHSZD (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 13:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760805AbWLHSZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:25:02 -0500
Received: from ns2.gothnet.se ([82.193.160.251]:8670 "EHLO
	GOTHNET-SMTP2.gothnet.se" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760800AbWLHSZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:25:00 -0500
Message-ID: <4579ADE5.7050107@tungstengraphics.com>
Date: Fri, 08 Dec 2006 19:24:37 +0100
From: =?ISO-8859-1?Q?Thomas_Hellstr=F6m?= <thomas@tungstengraphics.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.6.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Dave Airlie <airlied@linux.ie>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2/2] agpgart - Remove unnecessary flushes.
Content-Type: multipart/mixed;
 boundary="------------060207010903050305050007"
X-BitDefender-Scanner: Mail not scanned due to license constraints
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060207010903050305050007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

This patch is to speed up flipping of pages in and out of the AGP=20
aperture as needed by the new drm memory manager.

A number of global cache flushes are removed as well as some PCI posting=20
flushes.
The following guidelines have been used:

1) Memory that is only mapped uncached and that has been subject to a=20
global cache flush after the mapping was changed to uncached does not=20
need any more cache flushes. Neither before binding to the aperture nor=20
after unbinding.

2) Only do one PCI posting flush after a sequence of writes modifying=20
page entries in the GATT.

Patch against davej's agpgart.git

/Thomas Hellstr=F6m





--------------060207010903050305050007
Content-Type: text/x-patch;
 name="patch2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch2.diff"

diff --git a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
index 7a6107f..75557de 100644
--- a/drivers/char/agp/generic.c
+++ b/drivers/char/agp/generic.c
@@ -1076,8 +1076,8 @@ int agp_generic_insert_memory(struct agp
 
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
 		writel(bridge->driver->mask_memory(bridge, mem->memory[i], mask_type), bridge->gatt_table+j);
-		readl(bridge->gatt_table+j);	/* PCI Posting. */
 	}
+	readl(bridge->gatt_table+j-1);	/* PCI Posting. */
 
 	bridge->driver->tlb_flush(mem);
 	return 0;
@@ -1111,10 +1111,9 @@ int agp_generic_remove_memory(struct agp
 	/* AK: bogus, should encode addresses > 4GB */
 	for (i = pg_start; i < (mem->page_count + pg_start); i++) {
 		writel(bridge->scratch_page, bridge->gatt_table+i);
-		readl(bridge->gatt_table+i);	/* PCI Posting. */
 	}
+	readl(bridge->gatt_table+i-1);	/* PCI Posting. */
 
-	global_cache_flush();
 	bridge->driver->tlb_flush(mem);
 	return 0;
 }
diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
index 677581a..aaf9b30 100644
--- a/drivers/char/agp/intel-agp.c
+++ b/drivers/char/agp/intel-agp.c
@@ -256,9 +256,8 @@ static int intel_i810_insert_entries(str
 		for (i = pg_start; i < (pg_start + mem->page_count); i++) {
 			writel((i*4096)|I810_PTE_LOCAL|I810_PTE_VALID, 
 			       intel_i810_private.registers+I810_PTE_BASE+(i*4));
-			readl(intel_i810_private.registers+I810_PTE_BASE+(i*4));
-			
 		}
+		readl(intel_i810_private.registers+I810_PTE_BASE+((i-1)*4));
 		break;
 	case AGP_PHYS_MEMORY:
 		if (!mem->is_flushed) 
@@ -268,13 +267,13 @@ static int intel_i810_insert_entries(str
 							       mem->memory[i],
 							       mask_type),
 			       intel_i810_private.registers+I810_PTE_BASE+(j*4));
-			readl(intel_i810_private.registers+I810_PTE_BASE+(j*4));
 		}
+		readl(intel_i810_private.registers+I810_PTE_BASE+((j-1)*4));
 		break;
 	default:
 		goto out_err;
 	}
-	global_cache_flush();
+	
 	agp_bridge->driver->tlb_flush(mem);
 out:
 	ret = 0;
@@ -293,10 +292,9 @@ static int intel_i810_remove_entries(str
 
 	for (i = pg_start; i < (mem->page_count + pg_start); i++) {
 		writel(agp_bridge->scratch_page, intel_i810_private.registers+I810_PTE_BASE+(i*4));
-		readl(intel_i810_private.registers+I810_PTE_BASE+(i*4))	;
 	}
-	
-	global_cache_flush();
+	readl(intel_i810_private.registers+I810_PTE_BASE+((i-1)*4));	
+
 	agp_bridge->driver->tlb_flush(mem);
 	return 0;
 }
@@ -646,7 +644,7 @@ static int intel_i830_insert_entries(str
 	if (mask_type != 0 && mask_type != AGP_PHYS_MEMORY && 
 	    mask_type != INTEL_AGP_CACHED_MEMORY)
 		goto out_err;
-
+	
 	if (!mem->is_flushed)
 		global_cache_flush();
 
@@ -654,9 +652,8 @@ static int intel_i830_insert_entries(str
 		writel(agp_bridge->driver->mask_memory(agp_bridge,
 						       mem->memory[i], mask_type),
 		       intel_i830_private.registers+I810_PTE_BASE+(j*4));
-		readl(intel_i830_private.registers+I810_PTE_BASE+(j*4));
 	}
-	global_cache_flush();
+	readl(intel_i830_private.registers+I810_PTE_BASE+((j-1)*4));
 	agp_bridge->driver->tlb_flush(mem);
 
 out:
@@ -671,8 +668,6 @@ static int intel_i830_remove_entries(str
 {
 	int i;
 
-	global_cache_flush();
-
 	if (pg_start < intel_i830_private.gtt_entries) {
 		printk (KERN_INFO PFX "Trying to disable local/stolen memory\n");
 		return -EINVAL;
@@ -680,10 +675,9 @@ static int intel_i830_remove_entries(str
 
 	for (i = pg_start; i < (mem->page_count + pg_start); i++) {
 		writel(agp_bridge->scratch_page, intel_i830_private.registers+I810_PTE_BASE+(i*4));
-		readl(intel_i830_private.registers+I810_PTE_BASE+(i*4));
 	}
-	
-	global_cache_flush();
+	readl(intel_i830_private.registers+I810_PTE_BASE+((i-1)*4));
+
 	agp_bridge->driver->tlb_flush(mem);
 	return 0;
 }
@@ -777,10 +771,9 @@ static int intel_i915_insert_entries(str
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
 		writel(agp_bridge->driver->mask_memory(agp_bridge,
 			mem->memory[i], mask_type), intel_i830_private.gtt+j);
-		readl(intel_i830_private.gtt+j);
 	}
 	
-	global_cache_flush();
+	readl(intel_i830_private.gtt+j-1);
 	agp_bridge->driver->tlb_flush(mem);
 
  out:
@@ -795,19 +788,16 @@ static int intel_i915_remove_entries(str
 {
 	int i;
 
-	global_cache_flush();
-
 	if (pg_start < intel_i830_private.gtt_entries) {
 		printk (KERN_INFO PFX "Trying to disable local/stolen memory\n");
 		return -EINVAL;
 	}
-
+	
 	for (i = pg_start; i < (mem->page_count + pg_start); i++) {
 		writel(agp_bridge->scratch_page, intel_i830_private.gtt+i);
-		readl(intel_i830_private.gtt+i);
 	}
-
-	global_cache_flush();
+	readl(intel_i830_private.gtt+i-1);
+	
 	agp_bridge->driver->tlb_flush(mem);
 	return 0;
 }

--------------060207010903050305050007--



