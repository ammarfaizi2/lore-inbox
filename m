Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTETUXi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 16:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbTETUXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 16:23:38 -0400
Received: from are.twiddle.net ([64.81.246.98]:429 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S261168AbTETUXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 16:23:34 -0400
Date: Tue, 20 May 2003 13:36:34 -0700
From: Richard Henderson <rth@twiddle.net>
To: linux-kernel@vger.kernel.org
Subject: [agp] 2.5 alpha update
Message-ID: <20030520203634.GB4769@twiddle.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meant to cc lkml as well, since this affects building
generic kernels even if you don't configure in agp.


r~


----- Forwarded message from Richard Henderson <rth@twiddle.net> -----

Date: Tue, 20 May 2003 13:33:41 -0700
From: Richard Henderson <rth@twiddle.net>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Jeff Wiedemeier <Jeff.Wiedemeier@hp.com>
Subject: [agp] 2.5 alpha update
User-Agent: Mutt/1.4i

On Tue, May 20, 2003 at 07:11:41PM +0100, Dave Jones wrote:
> it went the way of the dodo. If you look at what happened in
> include/linux/agp_backend.h you'll see that the enum got shrunk
> down to 'NOT_SUPPORTED' and 'SUPPORTED'. basically, it's just a
> bool now.

Mm.  Looks like the alpha bits havn't compiled in a while now.

How does the following look?  I don't have any of the hardware
to try this, but at least it builds.  Jeff, can you try to
boot such a beast?


r~



===== arch/alpha/kernel/core_marvel.c 1.10 vs edited =====
--- 1.10/arch/alpha/kernel/core_marvel.c	Mon May 12 18:59:21 2003
+++ edited/arch/alpha/kernel/core_marvel.c	Tue May 20 13:05:19 2003
@@ -1075,7 +1075,6 @@
 	/*
 	 * Fill it in.
 	 */
-	agp->type = ALPHA_CORE_AGP;
 	agp->hose = hose;
 	agp->private = NULL;
 	agp->ops = &marvel_agp_ops;
===== arch/alpha/kernel/core_titan.c 1.15 vs edited =====
--- 1.15/arch/alpha/kernel/core_titan.c	Thu Apr 24 00:15:06 2003
+++ edited/arch/alpha/kernel/core_titan.c	Tue May 20 13:05:07 2003
@@ -763,7 +763,6 @@
 	/*
 	 * Fill it in.
 	 */
-	agp->type = ALPHA_CORE_AGP;
 	agp->hose = hose;
 	agp->private = port;
 	agp->ops = &titan_agp_ops;
===== drivers/char/agp/alpha-agp.c 1.6 vs edited =====
--- 1.6/drivers/char/agp/alpha-agp.c	Wed May 14 18:05:00 2003
+++ edited/drivers/char/agp/alpha-agp.c	Tue May 20 13:28:36 2003
@@ -11,38 +11,12 @@
 
 #include "agp.h"
 
-static struct page *alpha_core_agp_vm_nopage(struct vm_area_struct *vma,
-					     unsigned long address,
-					     int write_access)
-{
-	alpha_agp_info *agp = agp_bridge->dev_private_data;
-	dma_addr_t dma_addr;
-	unsigned long pa;
-	struct page *page;
-
-	dma_addr = address - vma->vm_start + agp->aperture.bus_base;
-	pa = agp->ops->translate(agp, dma_addr);
-
-	if (pa == (unsigned long)-EINVAL) return NULL;	/* no translation */
-	
-	/*
-	 * Get the page, inc the use count, and return it
-	 */
-	page = virt_to_page(__va(pa));
-	get_page(page);
-	return page;
-}
 
 static struct aper_size_info_fixed alpha_core_agp_sizes[] =
 {
 	{ 0, 0, 0 }, /* filled in by alpha_core_agp_setup */
 };
 
-struct vm_operations_struct alpha_core_agp_vm_ops = {
-	.nopage = alpha_core_agp_vm_nopage,
-};
-
-
 static int alpha_core_agp_nop(void)
 {
 	/* just return success */
@@ -117,17 +91,18 @@
 
 struct agp_bridge_driver alpha_core_agp_driver = {
 	.owner			= THIS_MODULE,
-	.aperture_sizes		= aper_size,
-	.current_size		= aper_size,	/* only one entry */
-	.size_type		= FIXED_APER_SIZE,
+	.aperture_sizes		= alpha_core_agp_sizes,
 	.num_aperture_sizes	= 1,
-	.configure		= alpha_core_agp_configure,
+	.size_type		= FIXED_APER_SIZE,
+	.cant_use_aperture	= 1,
+	.masks			= NULL,
+
 	.fetch_size		= alpha_core_agp_fetch_size,
+	.configure		= alpha_core_agp_configure,
+	.agp_enable		= alpha_core_agp_enable,
 	.cleanup		= alpha_core_agp_cleanup,
 	.tlb_flush		= alpha_core_agp_tlbflush,
 	.mask_memory		= agp_generic_mask_memory,
-	.masks			= NULL,
-	.agp_enable		= alpha_core_agp_enable,
 	.cache_flush		= global_cache_flush,
 	.create_gatt_table	= alpha_core_agp_nop,
 	.free_gatt_table	= alpha_core_agp_nop,
@@ -137,9 +112,6 @@
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
-	.mode			= agp->capability.lw,
-	.cant_use_aperture	= 1,
-	.vm_ops			= &alpha_core_agp_vm_ops,
 };
 
 struct agp_bridge_data *alpha_bridge;
@@ -160,11 +132,9 @@
 	 * Build the aperture size descriptor
 	 */
 	aper_size = alpha_core_agp_sizes;
-	if (!aper_size)
-		return -ENOMEM;
 	aper_size->size = agp->aperture.size / (1024 * 1024);
 	aper_size->num_entries = agp->aperture.size / PAGE_SIZE;
-	aper_size->page_order = ffs(aper_size->num_entries / 1024) - 1;
+	aper_size->page_order = __ffs(aper_size->num_entries / 1024);
 
 	/*
 	 * Build a fake pci_dev struct
===== include/asm-alpha/agp_backend.h 1.1 vs edited =====
--- 1.1/include/asm-alpha/agp_backend.h	Thu Jan 16 14:08:21 2003
+++ edited/include/asm-alpha/agp_backend.h	Tue May 20 13:04:40 2003
@@ -17,7 +17,6 @@
 } alpha_agp_mode;
 
 typedef struct _alpha_agp_info {
-	enum chipset_type type;
 	struct pci_controller *hose;
 	struct {
 		dma_addr_t bus_base;

----- End forwarded message -----
