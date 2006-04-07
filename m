Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWDGF06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWDGF06 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 01:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWDGF05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 01:26:57 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:16079 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932261AbWDGF05
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 01:26:57 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@codemonkey.org.uk>
Subject: [PATCH] deinline a few large inlines in DRM code
Date: Fri, 7 Apr 2006 08:26:40 +0300
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QgfNElSzQqcVYxh"
Message-Id: <200604070826.40453.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_QgfNElSzQqcVYxh
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is what we have now:

Large inlines with multiple callers:
Size  Uses Wasted Name and definition
===== ==== ====== ================================================
  322    5   1208 drm_core_ioremap      drivers/char/drm/drmP.h
  258    5    952 drm_core_ioremapfree  drivers/char/drm/drmP.h
  148    4    384 drm_ioremapfree       drivers/char/drm/drm_memory.h
  147    3    254 drm_ioremap   drivers/char/drm/drm_memory.h

This patch moves a few large functions from drm_memory.h
to drm_memory.c, with the following effect:

# size org/*.ko new/*.ko | sort -t/ -k2
   text    data     bss     dec     hex filename
  46305    1304      20   47629    ba0d new/drm.ko
  46367    1304      20   47691    ba4b org/drm.ko
  12969    1372       0   14341    3805 new/i810.ko
  14712    1372       0   16084    3ed4 org/i810.ko
  16447    1364       0   17811    4593 new/i830.ko
  18198    1364       0   19562    4c6a org/i830.ko
  11875    1324       0   13199    338f new/i915.ko
  13025    1324       0   14349    380d org/i915.ko
  23936   29288       0   53224    cfe8 new/mga.ko
  27280   29288       0   56568    dcf8 org/mga.ko

Please apply.

Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>
--
vda

--Boundary-00=_QgfNElSzQqcVYxh
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.16.drm_inline.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.16.drm_inline.patch"

# size org/* new/* | sort -t/ -k2
   text    data     bss     dec     hex filename
  46305    1304      20   47629    ba0d new/drm.ko
  46367    1304      20   47691    ba4b org/drm.ko
  12969    1372       0   14341    3805 new/i810.ko
  14712    1372       0   16084    3ed4 org/i810.ko
  16447    1364       0   17811    4593 new/i830.ko
  18198    1364       0   19562    4c6a org/i830.ko
  11875    1324       0   13199    338f new/i915.ko
  13025    1324       0   14349    380d org/i915.ko
  23936   29288       0   53224    cfe8 new/mga.ko
  27280   29288       0   56568    dcf8 org/mga.ko

diff -urpN linux-2.6.16.org/drivers/char/drm/drm_memory.c linux-2.6.16.drm/drivers/char/drm/drm_memory.c
--- linux-2.6.16.org/drivers/char/drm/drm_memory.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.drm/drivers/char/drm/drm_memory.c	Thu Apr  6 21:03:39 2006
@@ -139,6 +139,71 @@ void drm_free_pages(unsigned long addres
 }
 
 #if __OS_HAS_AGP
+/*
+ * Find the drm_map that covers the range [offset, offset+size).
+ */
+drm_map_t *drm_lookup_map(unsigned long offset,
+					unsigned long size, drm_device_t * dev)
+{
+	struct list_head *list;
+	drm_map_list_t *r_list;
+	drm_map_t *map;
+
+	list_for_each(list, &dev->maplist->head) {
+		r_list = (drm_map_list_t *) list;
+		map = r_list->map;
+		if (!map)
+			continue;
+		if (map->offset <= offset
+		    && (offset + size) <= (map->offset + map->size))
+			return map;
+	}
+	return NULL;
+}
+
+void *agp_remap(unsigned long offset, unsigned long size,
+			      drm_device_t * dev)
+{
+	unsigned long *phys_addr_map, i, num_pages =
+	    PAGE_ALIGN(size) / PAGE_SIZE;
+	struct drm_agp_mem *agpmem;
+	struct page **page_map;
+	void *addr;
+
+	size = PAGE_ALIGN(size);
+
+#ifdef __alpha__
+	offset -= dev->hose->mem_space->start;
+#endif
+
+	for (agpmem = dev->agp->memory; agpmem; agpmem = agpmem->next)
+		if (agpmem->bound <= offset
+		    && (agpmem->bound + (agpmem->pages << PAGE_SHIFT)) >=
+		    (offset + size))
+			break;
+	if (!agpmem)
+		return NULL;
+
+	/*
+	 * OK, we're mapping AGP space on a chipset/platform on which memory accesses by
+	 * the CPU do not get remapped by the GART.  We fix this by using the kernel's
+	 * page-table instead (that's probably faster anyhow...).
+	 */
+	/* note: use vmalloc() because num_pages could be large... */
+	page_map = vmalloc(num_pages * sizeof(struct page *));
+	if (!page_map)
+		return NULL;
+
+	phys_addr_map =
+	    agpmem->memory->memory + (offset - agpmem->bound) / PAGE_SIZE;
+	for (i = 0; i < num_pages; ++i)
+		page_map[i] = pfn_to_page(phys_addr_map[i] >> PAGE_SHIFT);
+	addr = vmap(page_map, num_pages, VM_IOREMAP, PAGE_AGP);
+	vfree(page_map);
+
+	return addr;
+}
+
 /** Wrapper around agp_allocate_memory() */
 DRM_AGP_MEM *drm_alloc_agp(drm_device_t * dev, int pages, u32 type)
 {
@@ -163,4 +228,56 @@ int drm_unbind_agp(DRM_AGP_MEM * handle)
 	return drm_agp_unbind_memory(handle);
 }
 #endif				/* agp */
+
+void *drm_ioremap(unsigned long offset, unsigned long size,
+				drm_device_t * dev)
+{
+	if (drm_core_has_AGP(dev) && dev->agp && dev->agp->cant_use_aperture) {
+		drm_map_t *map = drm_lookup_map(offset, size, dev);
+
+		if (map && map->type == _DRM_AGP)
+			return agp_remap(offset, size, dev);
+	}
+	return ioremap(offset, size);
+}
+EXPORT_SYMBOL(drm_ioremap);
+
+void *drm_ioremap_nocache(unsigned long offset,
+					unsigned long size, drm_device_t * dev)
+{
+	if (drm_core_has_AGP(dev) && dev->agp && dev->agp->cant_use_aperture) {
+		drm_map_t *map = drm_lookup_map(offset, size, dev);
+
+		if (map && map->type == _DRM_AGP)
+			return agp_remap(offset, size, dev);
+	}
+	return ioremap_nocache(offset, size);
+}
+
+void drm_ioremapfree(void *pt, unsigned long size,
+				   drm_device_t * dev)
+{
+	/*
+	 * This is a bit ugly.  It would be much cleaner if the DRM API would use separate
+	 * routines for handling mappings in the AGP space.  Hopefully this can be done in
+	 * a future revision of the interface...
+	 */
+	if (drm_core_has_AGP(dev) && dev->agp && dev->agp->cant_use_aperture
+	    && ((unsigned long)pt >= VMALLOC_START
+		&& (unsigned long)pt < VMALLOC_END)) {
+		unsigned long offset;
+		drm_map_t *map;
+
+		offset = drm_follow_page(pt) | ((unsigned long)pt & ~PAGE_MASK);
+		map = drm_lookup_map(offset, size, dev);
+		if (map && map->type == _DRM_AGP) {
+			vunmap(pt);
+			return;
+		}
+	}
+
+	iounmap(pt);
+}
+EXPORT_SYMBOL(drm_ioremapfree);
+
 #endif				/* debug_memory */
diff -urpN linux-2.6.16.org/drivers/char/drm/drm_memory.h linux-2.6.16.drm/drivers/char/drm/drm_memory.h
--- linux-2.6.16.org/drivers/char/drm/drm_memory.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.drm/drivers/char/drm/drm_memory.h	Thu Apr  6 19:18:53 2006
@@ -60,67 +60,11 @@
 /*
  * Find the drm_map that covers the range [offset, offset+size).
  */
-static inline drm_map_t *drm_lookup_map(unsigned long offset,
-					unsigned long size, drm_device_t * dev)
-{
-	struct list_head *list;
-	drm_map_list_t *r_list;
-	drm_map_t *map;
-
-	list_for_each(list, &dev->maplist->head) {
-		r_list = (drm_map_list_t *) list;
-		map = r_list->map;
-		if (!map)
-			continue;
-		if (map->offset <= offset
-		    && (offset + size) <= (map->offset + map->size))
-			return map;
-	}
-	return NULL;
-}
-
-static inline void *agp_remap(unsigned long offset, unsigned long size,
-			      drm_device_t * dev)
-{
-	unsigned long *phys_addr_map, i, num_pages =
-	    PAGE_ALIGN(size) / PAGE_SIZE;
-	struct drm_agp_mem *agpmem;
-	struct page **page_map;
-	void *addr;
-
-	size = PAGE_ALIGN(size);
-
-#ifdef __alpha__
-	offset -= dev->hose->mem_space->start;
-#endif
+drm_map_t *drm_lookup_map(unsigned long offset,
+					unsigned long size, drm_device_t * dev);
 
-	for (agpmem = dev->agp->memory; agpmem; agpmem = agpmem->next)
-		if (agpmem->bound <= offset
-		    && (agpmem->bound + (agpmem->pages << PAGE_SHIFT)) >=
-		    (offset + size))
-			break;
-	if (!agpmem)
-		return NULL;
-
-	/*
-	 * OK, we're mapping AGP space on a chipset/platform on which memory accesses by
-	 * the CPU do not get remapped by the GART.  We fix this by using the kernel's
-	 * page-table instead (that's probably faster anyhow...).
-	 */
-	/* note: use vmalloc() because num_pages could be large... */
-	page_map = vmalloc(num_pages * sizeof(struct page *));
-	if (!page_map)
-		return NULL;
-
-	phys_addr_map =
-	    agpmem->memory->memory + (offset - agpmem->bound) / PAGE_SIZE;
-	for (i = 0; i < num_pages; ++i)
-		page_map[i] = pfn_to_page(phys_addr_map[i] >> PAGE_SHIFT);
-	addr = vmap(page_map, num_pages, VM_IOREMAP, PAGE_AGP);
-	vfree(page_map);
-
-	return addr;
-}
+void *agp_remap(unsigned long offset, unsigned long size,
+			      drm_device_t * dev);
 
 static inline unsigned long drm_follow_page(void *vaddr)
 {
@@ -152,51 +96,11 @@ static inline unsigned long drm_follow_p
 
 #endif
 
-static inline void *drm_ioremap(unsigned long offset, unsigned long size,
-				drm_device_t * dev)
-{
-	if (drm_core_has_AGP(dev) && dev->agp && dev->agp->cant_use_aperture) {
-		drm_map_t *map = drm_lookup_map(offset, size, dev);
-
-		if (map && map->type == _DRM_AGP)
-			return agp_remap(offset, size, dev);
-	}
-	return ioremap(offset, size);
-}
-
-static inline void *drm_ioremap_nocache(unsigned long offset,
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
+void *drm_ioremap(unsigned long offset, unsigned long size,
+				drm_device_t * dev);
 
-static inline void drm_ioremapfree(void *pt, unsigned long size,
-				   drm_device_t * dev)
-{
-	/*
-	 * This is a bit ugly.  It would be much cleaner if the DRM API would use separate
-	 * routines for handling mappings in the AGP space.  Hopefully this can be done in
-	 * a future revision of the interface...
-	 */
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
+void *drm_ioremap_nocache(unsigned long offset,
+					unsigned long size, drm_device_t * dev);
 
-	iounmap(pt);
-}
+void drm_ioremapfree(void *pt, unsigned long size,
+				   drm_device_t * dev);

--Boundary-00=_QgfNElSzQqcVYxh--
