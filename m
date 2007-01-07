Return-Path: <linux-kernel-owner+w=401wt.eu-S964838AbXAGSkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbXAGSkx (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 13:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbXAGSkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 13:40:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49747 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964838AbXAGSkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 13:40:52 -0500
Date: Sun, 7 Jan 2007 18:39:46 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>,
       Zachary Amsden <zach@vmware.com>,
       Jeremy Fitzhardinge <jeremy@xensource.com>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Adrian Bunk <bunk@stusta.de>, airlied@linux.ie
Subject: Re: [patch] paravirt: isolate module ops
Message-ID: <20070107183946.GB8158@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>,
	Zachary Amsden <zach@vmware.com>,
	Jeremy Fitzhardinge <jeremy@xensource.com>,
	Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjan@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, airlied@linux.ie
References: <20070106000715.GA6688@elte.hu> <459EEDEB.8090800@vmware.com> <1168064710.20372.28.camel@localhost.localdomain> <20070106071424.GB11232@elte.hu> <1168100325.20372.37.camel@localhost.localdomain> <20070106193152.GA26153@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20070106193152.GA26153@infradead.org>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 06, 2007 at 07:31:52PM +0000, Christoph Hellwig wrote:
> On Sun, Jan 07, 2007 at 03:18:45AM +1100, Rusty Russell wrote:
> > PS.  drm_memory.h has a "drm_follow_page": this forces us to uninline
> > various page tables ops.  Can this use follow_page() somehow, or do we
> > need an "__follow_page" export for this case?
> 
> Not if avoidable.  And it seems avoidable as drm really should be using
> vmalloc_to_page.  Untested patch below:

Even better we can actualy avid most of the page table walks completely.
First there is a number of places that can never have the vmalloc case
an may use ioremap/iounmap directly.  Secondly drm_core_ioremap/
drm_core_ioremapfree already have the right drm_map to check wich kind
of mapping we have - we just need to use it instead of discarding that
information!  The only leaves direct drm_ioremapfree in i810_dma.c and
i830_dma.c which I don't quite manage to follow.  Maybe Dave has an
idea how to get rid of those aswell.

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=drm-avoid-drm_ioremap

Index: linux-2.6/drivers/char/drm/drm_bufs.c
===================================================================
--- linux-2.6.orig/drivers/char/drm/drm_bufs.c	2007-01-07 14:07:18.000000000 +0100
+++ linux-2.6/drivers/char/drm/drm_bufs.c	2007-01-07 14:09:40.000000000 +0100
@@ -178,7 +178,7 @@
 			}
 		}
 		if (map->type == _DRM_REGISTERS)
-			map->handle = drm_ioremap(map->offset, map->size, dev);
+			map->handle = ioremap(map->offset, map->size);
 		break;
 
 	case _DRM_SHM:
@@ -238,7 +238,7 @@
 	list = drm_alloc(sizeof(*list), DRM_MEM_MAPS);
 	if (!list) {
 		if (map->type == _DRM_REGISTERS)
-			drm_ioremapfree(map->handle, map->size, dev);
+			iounmap(map->handle);
 		drm_free(map, sizeof(*map), DRM_MEM_MAPS);
 		return -EINVAL;
 	}
@@ -255,7 +255,7 @@
 	ret = drm_map_handle(dev, &list->hash, user_token, 0);
 	if (ret) {
 		if (map->type == _DRM_REGISTERS)
-			drm_ioremapfree(map->handle, map->size, dev);
+			iounmap(map->handle);
 		drm_free(map, sizeof(*map), DRM_MEM_MAPS);
 		drm_free(list, sizeof(*list), DRM_MEM_MAPS);
 		mutex_unlock(&dev->struct_mutex);
@@ -362,7 +362,7 @@
 
 	switch (map->type) {
 	case _DRM_REGISTERS:
-		drm_ioremapfree(map->handle, map->size, dev);
+		iounmap(map->handle);
 		/* FALLTHROUGH */
 	case _DRM_FRAME_BUFFER:
 		if (drm_core_has_MTRR(dev) && map->mtrr >= 0) {
Index: linux-2.6/drivers/char/drm/drm_vm.c
===================================================================
--- linux-2.6.orig/drivers/char/drm/drm_vm.c	2007-01-07 14:07:18.000000000 +0100
+++ linux-2.6/drivers/char/drm/drm_vm.c	2007-01-07 14:10:50.000000000 +0100
@@ -227,7 +227,12 @@
 							   map->size);
 					DRM_DEBUG("mtrr_del = %d\n", retcode);
 				}
-				drm_ioremapfree(map->handle, map->size, dev);
+				/*
+				 * XXX(hch) autmatic mapping/unmapping only happens for
+				 * _DRM_REGISTERS in all other places.  Should we have
+				 * this check here aswell?
+				 */
+				iounmap(map->handle);
 				break;
 			case _DRM_SHM:
 				vfree(map->handle);

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=simplify-drm_core_ioremap

Index: linux-2.6/drivers/char/drm/drmP.h
===================================================================
--- linux-2.6.orig/drivers/char/drm/drmP.h	2007-01-07 14:13:48.000000000 +0100
+++ linux-2.6/drivers/char/drm/drmP.h	2007-01-07 14:15:32.000000000 +0100
@@ -1059,27 +1059,8 @@
 extern int drm_mm_init(drm_mm_t *mm, unsigned long start, unsigned long size);
 extern void drm_mm_takedown(drm_mm_t *mm);
 
-/* Inline replacements for DRM_IOREMAP macros */
-static __inline__ void drm_core_ioremap(struct drm_map *map,
-					struct drm_device *dev)
-{
-	map->handle = drm_ioremap(map->offset, map->size, dev);
-}
-
-#if 0
-static __inline__ void drm_core_ioremap_nocache(struct drm_map *map,
-						struct drm_device *dev)
-{
-	map->handle = drm_ioremap_nocache(map->offset, map->size, dev);
-}
-#endif  /*  0  */
-
-static __inline__ void drm_core_ioremapfree(struct drm_map *map,
-					    struct drm_device *dev)
-{
-	if (map->handle && map->size)
-		drm_ioremapfree(map->handle, map->size, dev);
-}
+extern void drm_core_ioremap(struct drm_map *map, struct drm_device *dev);
+extern void drm_core_ioremapfree(struct drm_map *map, struct drm_device *dev);
 
 static __inline__ struct drm_map *drm_core_findmap(struct drm_device *dev,
 						   unsigned int token)
Index: linux-2.6/drivers/char/drm/drm_memory.c
===================================================================
--- linux-2.6.orig/drivers/char/drm/drm_memory.c	2007-01-07 14:13:48.000000000 +0100
+++ linux-2.6/drivers/char/drm/drm_memory.c	2007-01-07 14:19:34.000000000 +0100
@@ -197,20 +197,6 @@
 }
 EXPORT_SYMBOL(drm_ioremap);
 
-#if 0
-void *drm_ioremap_nocache(unsigned long offset,
-					unsigned long size, drm_device_t * dev)
-{
-	if (drm_core_has_AGP(dev) && dev->agp && dev->agp->cant_use_aperture) {
-		drm_map_t *map = drm_lookup_map(offset, size, dev);
-
-		if (map && map->type == _DRM_AGP)
-			return agp_remap(offset, size, dev);
-	}
-	return ioremap_nocache(offset, size);
-}
-#endif  /*  0  */
-
 void drm_ioremapfree(void *pt, unsigned long size,
 				   drm_device_t * dev)
 {
@@ -238,3 +224,26 @@
 EXPORT_SYMBOL(drm_ioremapfree);
 
 #endif				/* debug_memory */
+
+void drm_core_ioremap(struct drm_map *map, struct drm_device *dev)
+{
+	if (drm_core_has_AGP(dev) &&
+	    dev->agp && dev->agp->cant_use_aperture && map->type == _DRM_AGP)
+		map->handle = agp_remap(map->offset, map->size, dev);
+	else
+		map->handle = ioremap(map->offset, map->size);
+}
+EXPORT_SYMBOL_GPL(drm_core_ioremap);
+
+void drm_core_ioremapfree(struct drm_map *map, struct drm_device *dev)
+{
+	if (!map->handle || !map->size)
+		return;
+
+	if (drm_core_has_AGP(dev) &&
+	    dev->agp && dev->agp->cant_use_aperture && map->type == _DRM_AGP)
+		vunmap(map->handle);
+	else
+		iounmap(map->handle);
+}
+EXPORT_SYMBOL_GPL(drm_core_ioremapfree);

--J/dobhs11T7y2rNN--
