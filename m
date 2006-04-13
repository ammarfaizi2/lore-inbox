Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWDMC2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWDMC2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 22:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWDMC2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 22:28:53 -0400
Received: from lixom.net ([66.141.50.11]:2463 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S932427AbWDMC2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 22:28:52 -0400
Date: Wed, 12 Apr 2006 21:28:09 -0500
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to 1GB
Message-ID: <20060413022809.GD24769@pb15.lixom.net>
References: <20060413020559.GC24769@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413020559.GC24769@pb15.lixom.net>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This goes with the previous dma_mask patch -- enable DART at 1GB due to
Airport Extreme cards needing it. Please consider for 2.6.17.


Thanks,

Olof


---

Turn on the DART already at 1GB. This is needed because of crippled
devices in some systems, i.e. Airport Extreme cards, only supporting
30-bit DMA addresses.

Otherwise, users with between 1 and 2GB of memory will need to manually
enable it with iommu=force, and that's no good.

Some simple performance tests show that there's a slight impact of
enabling DART, but it's in the 1-3% range (kernel build with disk I/O
as well as over NFS).

iommu=off can still be used for those who don't want to deal with the
overhead (and don't need it for any devices).


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: 2.6/arch/powerpc/sysdev/dart_iommu.c
===================================================================
--- 2.6.orig/arch/powerpc/sysdev/dart_iommu.c
+++ 2.6/arch/powerpc/sysdev/dart_iommu.c
@@ -329,10 +329,14 @@ void iommu_init_early_dart(void)
 
 void __init alloc_dart_table(void)
 {
-	/* Only reserve DART space if machine has more than 2GB of RAM
+	/* Only reserve DART space if machine has more than 1GB of RAM
 	 * or if requested with iommu=on on cmdline.
+	 *
+	 * 1GB of RAM is picked as limit because some default devices
+	 * (i.e. Airport Extreme) have 30 bit address range limits.
 	 */
-	if (lmb_end_of_DRAM() <= 0x80000000ull && !iommu_force_on)
+
+	if (lmb_end_of_DRAM() <= 0x40000000ull && !iommu_force_on)
 		return;
 
 	/* 512 pages (2MB) is max DART tablesize. */
