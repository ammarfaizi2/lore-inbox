Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVDMDTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVDMDTN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbVDLTcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:32:23 -0400
Received: from fire.osdl.org ([65.172.181.4]:11465 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262191AbVDLKcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:15 -0400
Message-Id: <200504121032.j3CAW7Pb005510@shell0.pdx.osdl.net>
Subject: [patch 094/198] x86_64: Use the e820 hole to map the IOMMU/AGP aperture
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

This might save memory on some Opteron systems without AGP bridge.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/aperture.c |   41 ++++++++++++++++++++++++----------
 1 files changed, 30 insertions(+), 11 deletions(-)

diff -puN arch/x86_64/kernel/aperture.c~x86_64-use-the-e820-hole-to-map-the-iommu-agp-aperture arch/x86_64/kernel/aperture.c
--- 25/arch/x86_64/kernel/aperture.c~x86_64-use-the-e820-hole-to-map-the-iommu-agp-aperture	2005-04-12 03:21:25.519257384 -0700
+++ 25-akpm/arch/x86_64/kernel/aperture.c	2005-04-12 03:21:25.522256928 -0700
@@ -33,11 +33,13 @@ int fallback_aper_force __initdata = 0; 
 
 int fix_aperture __initdata = 1;
 
-/* This code runs before the PCI subsystem is initialized, so just 
-   access the northbridge directly. */
-
 #define NB_ID_3 (PCI_VENDOR_ID_AMD | (0x1103<<16))
 
+static struct resource aper_res = {
+	.name = "Aperture",
+	.flags = IORESOURCE_MEM,
+};
+
 static u32 __init allocate_aperture(void) 
 {
 #ifdef CONFIG_DISCONTIGMEM
@@ -53,11 +55,24 @@ static u32 __init allocate_aperture(void
 	aper_size = (32 * 1024 * 1024) << fallback_aper_order; 
 
 	/* 
-	 * Aperture has to be naturally aligned. This means an 2GB aperture won't 
-	 * have much chances to find a place in the lower 4GB of memory. 
-	 * Unfortunately we cannot move it up because that would make the 
-	 * IOMMU useless.
+	 * Aperture has to be naturally aligned. This means an 2GB
+	 * aperture won't have much chances to find a place in the
+	 * lower 4GB of memory.  Unfortunately we cannot move it up
+	 * because that would make the IOMMU useless.
 	 */
+
+	/* First try to find some free unused space */
+	if (!allocate_resource(&iomem_resource, &aper_res,
+			       aper_size,
+			       0, 0xffffffff,
+			       aper_size,
+			       NULL, NULL)) {
+		printk(KERN_INFO "Putting aperture at %lx-%lx\n",
+		       aper_res.start, aper_res.end);
+		return aper_res.start;
+	}
+
+	/* No free space found. Go on to waste some memory... */
 	p = __alloc_bootmem_node(nd0, aper_size, aper_size, 0); 
 	if (!p || __pa(p)+aper_size > 0xffffffff) {
 		printk("Cannot allocate aperture memory hole (%p,%uK)\n",
@@ -66,7 +81,7 @@ static u32 __init allocate_aperture(void
 			free_bootmem_node(nd0, (unsigned long)p, aper_size); 
 		return 0;
 	}
-	printk("Mapping aperture over %d KB of RAM @ %lx\n",  
+	printk("Mapping aperture over %d KB of precious RAM @ %lx\n",
 	       aper_size >> 10, __pa(p)); 
 	return (u32)__pa(p); 
 }
@@ -87,10 +102,16 @@ static int __init aperture_valid(char *n
 		printk("Aperture from %s pointing to e820 RAM. Ignoring.\n",name);
 		return 0; 
 	} 
+	/* Don't check the resource here because the aperture is usually
+	   in an e820 reserved area, and we allocated these earlier. */
 	return 1;
 } 
 
-/* Find a PCI capability */ 
+/*
+ * Find a PCI capability.
+ * This code runs before the PCI subsystem is initialized, so just
+ * access the northbridge directly.
+ */
 static __u32 __init find_cap(int num, int slot, int func, int cap) 
 { 
 	u8 pos;
@@ -255,8 +276,6 @@ void __init iommu_hole_init(void) 
 		   fallback_aper_force) { 
 		printk("Your BIOS doesn't leave a aperture memory hole\n");
 		printk("Please enable the IOMMU option in the BIOS setup\n");
-		printk("This costs you %d MB of RAM\n",
-		       32 << fallback_aper_order);
 
 		aper_order = fallback_aper_order;
 		aper_alloc = allocate_aperture();
_
