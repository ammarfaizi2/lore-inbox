Return-Path: <linux-kernel-owner+w=401wt.eu-S932119AbXAFTck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbXAFTck (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 14:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbXAFTck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 14:32:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58936 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119AbXAFTcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 14:32:39 -0500
Date: Sat, 6 Jan 2007 19:31:52 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>,
       Jeremy Fitzhardinge <jeremy@xensource.com>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Adrian Bunk <bunk@stusta.de>, airlied@linux.ie
Subject: Re: [patch] paravirt: isolate module ops
Message-ID: <20070106193152.GA26153@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>,
	Zachary Amsden <zach@vmware.com>,
	Jeremy Fitzhardinge <jeremy@xensource.com>,
	Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjan@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, airlied@linux.ie
References: <20070106000715.GA6688@elte.hu> <459EEDEB.8090800@vmware.com> <1168064710.20372.28.camel@localhost.localdomain> <20070106071424.GB11232@elte.hu> <1168100325.20372.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168100325.20372.37.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 03:18:45AM +1100, Rusty Russell wrote:
> PS.  drm_memory.h has a "drm_follow_page": this forces us to uninline
> various page tables ops.  Can this use follow_page() somehow, or do we
> need an "__follow_page" export for this case?

Not if avoidable.  And it seems avoidable as drm really should be using
vmalloc_to_page.  Untested patch below:


Index: linux-2.6/drivers/char/drm/drm_memory.c
===================================================================
--- linux-2.6.orig/drivers/char/drm/drm_memory.c	2007-01-06 20:21:07.000000000 +0100
+++ linux-2.6/drivers/char/drm/drm_memory.c	2007-01-06 20:29:03.000000000 +0100
@@ -211,6 +211,23 @@
 }
 #endif  /*  0  */
 
+static int is_agp_mapping(void *pt, unsigned long size, drm_device_t *dev)
+{
+	unsigned long addr = (unsigned long)pt;
+
+	if (addr >= VMALLOC_START && addr < VMALLOC_END) {
+		unsigned long phys;
+		drm_map_t *map;
+
+		phys = page_to_phys(vmalloc_to_page(pt)) + offset_in_page(pt);
+		map = drm_lookup_map(phys, size, dev);
+		if (map && map->type == _DRM_AGP)
+			return 1;
+	}
+
+	return 0;
+}
+
 void drm_ioremapfree(void *pt, unsigned long size,
 				   drm_device_t * dev)
 {
@@ -219,21 +236,11 @@
 	 * routines for handling mappings in the AGP space.  Hopefully this can be done in
 	 * a future revision of the interface...
 	 */
-	if (drm_core_has_AGP(dev) && dev->agp && dev->agp->cant_use_aperture
-	    && ((unsigned long)pt >= VMALLOC_START
-		&& (unsigned long)pt < VMALLOC_END)) {
-		unsigned long offset;
-		drm_map_t *map;
-
-		offset = drm_follow_page(pt) | ((unsigned long)pt & ~PAGE_MASK);
-		map = drm_lookup_map(offset, size, dev);
-		if (map && map->type == _DRM_AGP) {
-			vunmap(pt);
-			return;
-		}
-	}
-
-	iounmap(pt);
+	if (drm_core_has_AGP(dev) && dev->agp && dev->agp->cant_use_aperture &&
+	    is_agp_mapping(pt, size, dev))
+		vunmap(pt);
+	else
+		iounmap(pt);
 }
 EXPORT_SYMBOL(drm_ioremapfree);
 
Index: linux-2.6/drivers/char/drm/drm_memory.h
===================================================================
--- linux-2.6.orig/drivers/char/drm/drm_memory.h	2007-01-06 20:21:07.000000000 +0100
+++ linux-2.6/drivers/char/drm/drm_memory.h	2007-01-06 20:26:50.000000000 +0100
@@ -55,23 +55,6 @@
 #  define PAGE_AGP	PAGE_KERNEL
 # endif
 #endif
-
-static inline unsigned long drm_follow_page(void *vaddr)
-{
-	pgd_t *pgd = pgd_offset_k((unsigned long)vaddr);
-	pud_t *pud = pud_offset(pgd, (unsigned long)vaddr);
-	pmd_t *pmd = pmd_offset(pud, (unsigned long)vaddr);
-	pte_t *ptep = pte_offset_kernel(pmd, (unsigned long)vaddr);
-	return pte_pfn(*ptep) << PAGE_SHIFT;
-}
-
-#else				/* __OS_HAS_AGP */
-
-static inline unsigned long drm_follow_page(void *vaddr)
-{
-	return 0;
-}
-
 #endif
 
 void *drm_ioremap(unsigned long offset, unsigned long size,
