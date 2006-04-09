Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWDIO6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWDIO6U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 10:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWDIO6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 10:58:19 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28933 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750760AbWDIO6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 10:58:19 -0400
Date: Sun, 9 Apr 2006 16:58:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, airlied@linux.ie
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.ne
Subject: [-mm patch] drivers/char/drm/drm_memory.c: possible cleanups
Message-ID: <20060409145818.GD8454@stusta.de>
References: <20060408031405.5e5131da.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060408031405.5e5131da.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2006 at 03:14:05AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc1-mm1:
>...
>  git-drm.patch
>...
>  git trees
>...

This patch contains the following possible cleanups plus the changes 
caused by them:
- #if 0 the following unused global function:
  - drm_ioremap_nocache()
- make the following needlessly global functions static:
  - agp_remap()
  - drm_lookup_map()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/drm/drmP.h             |    4 ++--
 drivers/char/drm/drm_memory.c       |   25 +++++++++++++++++++++----
 drivers/char/drm/drm_memory.h       |   24 ------------------------
 drivers/char/drm/drm_memory_debug.h |    2 ++
 4 files changed, 25 insertions(+), 30 deletions(-)

--- linux-2.6.17-rc1-mm2-full/drivers/char/drm/drmP.h.old	2006-04-09 16:18:20.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/char/drm/drmP.h	2006-04-09 16:18:38.000000000 +0200
@@ -815,8 +815,6 @@
 extern void *drm_realloc(void *oldpt, size_t oldsize, size_t size, int area);
 extern void *drm_ioremap(unsigned long offset, unsigned long size,
 			 drm_device_t * dev);
-extern void *drm_ioremap_nocache(unsigned long offset, unsigned long size,
-				 drm_device_t * dev);
 extern void drm_ioremapfree(void *pt, unsigned long size, drm_device_t * dev);
 
 extern DRM_AGP_MEM *drm_alloc_agp(drm_device_t * dev, int pages, u32 type);
@@ -1022,11 +1020,13 @@
 	map->handle = drm_ioremap(map->offset, map->size, dev);
 }
 
+#if 0
 static __inline__ void drm_core_ioremap_nocache(struct drm_map *map,
 						struct drm_device *dev)
 {
 	map->handle = drm_ioremap_nocache(map->offset, map->size, dev);
 }
+#endif  /*  0  */
 
 static __inline__ void drm_core_ioremapfree(struct drm_map *map,
 					    struct drm_device *dev)
--- linux-2.6.17-rc1-mm2-full/drivers/char/drm/drm_memory.h.old	2006-04-09 16:15:53.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/char/drm/drm_memory.h	2006-04-09 16:21:28.000000000 +0200
@@ -57,15 +57,6 @@
 # endif
 #endif
 
-/*
- * Find the drm_map that covers the range [offset, offset+size).
- */
-drm_map_t *drm_lookup_map(unsigned long offset,
-					unsigned long size, drm_device_t * dev);
-
-void *agp_remap(unsigned long offset, unsigned long size,
-			      drm_device_t * dev);
-
 static inline unsigned long drm_follow_page(void *vaddr)
 {
 	pgd_t *pgd = pgd_offset_k((unsigned long)vaddr);
@@ -77,18 +68,6 @@
 
 #else				/* __OS_HAS_AGP */
 
-static inline drm_map_t *drm_lookup_map(unsigned long offset,
-					unsigned long size, drm_device_t * dev)
-{
-	return NULL;
-}
-
-static inline void *agp_remap(unsigned long offset, unsigned long size,
-			      drm_device_t * dev)
-{
-	return NULL;
-}
-
 static inline unsigned long drm_follow_page(void *vaddr)
 {
 	return 0;
@@ -99,8 +78,5 @@
 void *drm_ioremap(unsigned long offset, unsigned long size,
 				drm_device_t * dev);
 
-void *drm_ioremap_nocache(unsigned long offset,
-					unsigned long size, drm_device_t * dev);
-
 void drm_ioremapfree(void *pt, unsigned long size,
 				   drm_device_t * dev);
--- linux-2.6.17-rc1-mm2-full/drivers/char/drm/drm_memory_debug.h.old	2006-04-09 16:19:31.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/char/drm/drm_memory_debug.h	2006-04-09 16:19:44.000000000 +0200
@@ -229,6 +229,7 @@
 	return pt;
 }
 
+#if 0
 void *drm_ioremap_nocache (unsigned long offset, unsigned long size,
 			    drm_device_t * dev) {
 	void *pt;
@@ -251,6 +252,7 @@
 	spin_unlock(&drm_mem_lock);
 	return pt;
 }
+#endif  /*  0  */
 
 void drm_ioremapfree (void *pt, unsigned long size, drm_device_t * dev) {
 	int alloc_count;
--- linux-2.6.17-rc1-mm2-full/drivers/char/drm/drm_memory.c.old	2006-04-09 16:16:14.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/char/drm/drm_memory.c	2006-04-09 16:21:24.000000000 +0200
@@ -83,8 +83,8 @@
 /*
  * Find the drm_map that covers the range [offset, offset+size).
  */
-drm_map_t *drm_lookup_map(unsigned long offset,
-					unsigned long size, drm_device_t * dev)
+static drm_map_t *drm_lookup_map(unsigned long offset,
+				 unsigned long size, drm_device_t * dev)
 {
 	struct list_head *list;
 	drm_map_list_t *r_list;
@@ -102,8 +102,8 @@
 	return NULL;
 }
 
-void *agp_remap(unsigned long offset, unsigned long size,
-			      drm_device_t * dev)
+static void *agp_remap(unsigned long offset, unsigned long size,
+		       drm_device_t * dev)
 {
 	unsigned long *phys_addr_map, i, num_pages =
 	    PAGE_ALIGN(size) / PAGE_SIZE;
@@ -168,6 +168,21 @@
 {
 	return drm_agp_unbind_memory(handle);
 }
+
+#else  /*  __OS_HAS_AGP  */
+
+static inline drm_map_t *drm_lookup_map(unsigned long offset,
+					unsigned long size, drm_device_t * dev)
+{
+	return NULL;
+}
+
+static inline void *agp_remap(unsigned long offset, unsigned long size,
+			      drm_device_t * dev)
+{
+	return NULL;
+}
+
 #endif				/* agp */
 
 void *drm_ioremap(unsigned long offset, unsigned long size,
@@ -183,6 +198,7 @@
 }
 EXPORT_SYMBOL(drm_ioremap);
 
+#if 0
 void *drm_ioremap_nocache(unsigned long offset,
 					unsigned long size, drm_device_t * dev)
 {
@@ -194,6 +210,7 @@
 	}
 	return ioremap_nocache(offset, size);
 }
+#endif  /*  0  */
 
 void drm_ioremapfree(void *pt, unsigned long size,
 				   drm_device_t * dev)

