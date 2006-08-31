Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWHaXEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWHaXEl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 19:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWHaXEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 19:04:41 -0400
Received: from smtp-out.google.com ([216.239.45.12]:26468 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750715AbWHaXEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 19:04:41 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:cc:subject:message-id:mime-version:
	content-type:content-disposition:user-agent;
	b=UH1mzQ/5GxVOAagRhsp/FivibUwKHbpuQF9oKqyK2zPjL8sTlea+kAZZd9L82wFmN
	MGp+BWkZJb8oaBetLFjRA==
Date: Thu, 31 Aug 2006 16:04:30 -0700
From: adurbin@google.com
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de
Subject: [PATCH] x86_64: put GART into resource map
Message-ID: <20060831230430.GA21338@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch places the GART into the resource map. This will allow for
the visibility of the GART region in /proc/iomem.

Signed-off-by: Aaron Durbin <adurbin@gmail.com>

---

diff --git a/arch/x86_64/kernel/aperture.c b/arch/x86_64/kernel/aperture.c
index 58af8e7..616cfac 100644
--- a/arch/x86_64/kernel/aperture.c
+++ b/arch/x86_64/kernel/aperture.c
@@ -17,6 +17,7 @@ #include <linux/mmzone.h>
 #include <linux/pci_ids.h>
 #include <linux/pci.h>
 #include <linux/bitops.h>
+#include <linux/ioport.h>
 #include <asm/e820.h>
 #include <asm/io.h>
 #include <asm/proto.h>
@@ -33,6 +34,18 @@ int fallback_aper_force __initdata = 0; 
 
 int fix_aperture __initdata = 1;
 
+static struct resource gart_resource = {
+	.name	= "GART",
+	.flags	= IORESOURCE_MEM,
+};
+
+static void __init insert_aperture_resource(u32 aper_base, u32 aper_size)
+{
+	gart_resource.start = aper_base;
+	gart_resource.end = aper_base + aper_size - 1;
+	insert_resource(&iomem_resource, &gart_resource);
+}
+
 /* This code runs before the PCI subsystem is initialized, so just
    access the northbridge directly. */
 
@@ -62,6 +75,7 @@ static u32 __init allocate_aperture(void
 	}
 	printk("Mapping aperture over %d KB of RAM @ %lx\n",
 	       aper_size >> 10, __pa(p)); 
+	insert_aperture_resource((u32)__pa(p), aper_size);
 	return (u32)__pa(p); 
 }
 
@@ -233,8 +247,13 @@ void __init iommu_hole_init(void) 
 		last_aper_base = aper_base;
 	} 
 
-	if (!fix && !fallback_aper_force) 
+	if (!fix && !fallback_aper_force) {
+		if (last_aper_base) {
+			unsigned long n = (32 * 1024 * 1024) << last_aper_order;
+			insert_aperture_resource((u32)last_aper_base, n);
+		}
 		return; 
+	}
 
 	if (!fallback_aper_force)
 		aper_alloc = search_agp_bridge(&aper_order, &valid_agp); 
