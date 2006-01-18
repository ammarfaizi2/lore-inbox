Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbWARPxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWARPxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 10:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWARPxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 10:53:22 -0500
Received: from cantor2.suse.de ([195.135.220.15]:34964 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030358AbWARPxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 10:53:21 -0500
Date: Wed, 18 Jan 2006 16:53:20 +0100
From: Nick Piggin <npiggin@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] ati_pcigart: simplify page_count manipulations
Message-ID: <20060118155320.GC28418@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate a compound page for the user mapping instead of tweaking
the page refcounts.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/drivers/char/drm/ati_pcigart.c
===================================================================
--- linux-2.6.orig/drivers/char/drm/ati_pcigart.c
+++ linux-2.6/drivers/char/drm/ati_pcigart.c
@@ -59,17 +59,16 @@ static void *drm_ati_alloc_pcigart_table
 	int i;
 	DRM_DEBUG("%s\n", __FUNCTION__);
 
-	address = __get_free_pages(GFP_KERNEL, ATI_PCIGART_TABLE_ORDER);
+	address = __get_free_pages(GFP_KERNEL | __GFP_COMP,
+					ATI_PCIGART_TABLE_ORDER);
 	if (address == 0UL) {
 		return 0;
 	}
 
 	page = virt_to_page(address);
 
-	for (i = 0; i < ATI_PCIGART_TABLE_PAGES; i++, page++) {
-		get_page(page);
+	for (i = 0; i < ATI_PCIGART_TABLE_PAGES; i++, page++)
 		SetPageReserved(page);
-	}
 
 	DRM_DEBUG("%s: returning 0x%08lx\n", __FUNCTION__, address);
 	return (void *)address;
@@ -83,10 +82,8 @@ static void drm_ati_free_pcigart_table(v
 
 	page = virt_to_page((unsigned long)address);
 
-	for (i = 0; i < ATI_PCIGART_TABLE_PAGES; i++, page++) {
-		__put_page(page);
+	for (i = 0; i < ATI_PCIGART_TABLE_PAGES; i++, page++)
 		ClearPageReserved(page);
-	}
 
 	free_pages((unsigned long)address, ATI_PCIGART_TABLE_ORDER);
 }
