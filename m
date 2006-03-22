Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422675AbWCWUlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbWCWUlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWCWUk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:40:56 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:44789 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932177AbWCWUkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:40:23 -0500
Message-Id: <20060323203521.502162000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
User-Agent: quilt/0.44-1
Date: Thu, 23 Mar 2006 00:00:04 +0100
From: Arnd Bergmann <abergman@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [patch 04/13] powerpc: fix cell iommu setup
Content-Disposition: inline; filename=iommu-fix.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A small bug crept in the iommu driver when we made it more
generic. This patch is needed for boards that have a dma
window that does not start at bus address zero.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6.15-rc5/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/powerpc/platforms/cell/iommu.c
+++ linux-2.6.15-rc5/arch/powerpc/platforms/cell/iommu.c
@@ -289,7 +289,7 @@ static void cell_do_map_iommu(struct cel
 	ioc_base = iommu->mapped_base;
 	ioc_mmio_base = iommu->mapped_mmio_base;
 
-	for (real_address = 0, io_address = 0;
+	for (real_address = 0, io_address = map_start;
 	     io_address <= map_start + map_size;
 	     real_address += io_page_size, io_address += io_page_size) {
 		ioste = get_iost_entry(fake_iopt, io_address, io_page_size);
@@ -302,7 +302,7 @@ static void cell_do_map_iommu(struct cel
 		set_iopt_cache(ioc_mmio_base,
 			get_ioc_hash_1way(ioste, io_address),
 			get_ioc_tag(ioste, io_address),
-			get_iopt_entry(real_address-map_start, ioid, IOPT_PROT_RW));
+			get_iopt_entry(real_address, ioid, IOPT_PROT_RW));
 	}
 }
 

--

