Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422730AbWCWXz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422730AbWCWXz2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 18:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422733AbWCWXz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 18:55:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54032 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422730AbWCWXz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 18:55:27 -0500
Date: Fri, 24 Mar 2006 00:55:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, airlied@linux.ie
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: [RFC: -mm patch] remove drm_{alloc,free}_pages
Message-ID: <20060323235526.GH22727@stusta.de>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323014046.2ca1d9df.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 01:40:46AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc6-mm2:
>...
>  git-drm.patch
>...
>  git trees.
>...

drm_alloc_pages and drm_free_pages can now be removed.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/drm/drmP.h             |    2 
 drivers/char/drm/drm_memory.c       |   59 -----------------------
 drivers/char/drm/drm_memory_debug.h |   70 ----------------------------
 3 files changed, 131 deletions(-)

--- linux-2.6.16-mm1-full/drivers/char/drm/drmP.h.old	2006-03-23 23:05:06.000000000 +0100
+++ linux-2.6.16-mm1-full/drivers/char/drm/drmP.h	2006-03-23 23:05:37.000000000 +0100
@@ -813,8 +813,6 @@
 extern int drm_mem_info(char *buf, char **start, off_t offset,
 			int request, int *eof, void *data);
 extern void *drm_realloc(void *oldpt, size_t oldsize, size_t size, int area);
-extern unsigned long drm_alloc_pages(int order, int area);
-extern void drm_free_pages(unsigned long address, int order, int area);
 extern void *drm_ioremap(unsigned long offset, unsigned long size,
 			 drm_device_t * dev);
 extern void *drm_ioremap_nocache(unsigned long offset, unsigned long size,
--- linux-2.6.16-mm1-full/drivers/char/drm/drm_memory_debug.h.old	2006-03-23 23:05:19.000000000 +0100
+++ linux-2.6.16-mm1-full/drivers/char/drm/drm_memory_debug.h	2006-03-23 23:05:30.000000000 +0100
@@ -206,76 +206,6 @@
 	}
 }
 
-unsigned long drm_alloc_pages (int order, int area) {
-	unsigned long address;
-	unsigned long bytes = PAGE_SIZE << order;
-	unsigned long addr;
-	unsigned int sz;
-
-	spin_lock(&drm_mem_lock);
-	if ((drm_ram_used >> PAGE_SHIFT)
-	    > (DRM_RAM_PERCENT * drm_ram_available) / 100) {
-		spin_unlock(&drm_mem_lock);
-		return 0;
-	}
-	spin_unlock(&drm_mem_lock);
-
-	address = __get_free_pages(GFP_KERNEL|__GFP_COMP, order);
-	if (!address) {
-		spin_lock(&drm_mem_lock);
-		++drm_mem_stats[area].fail_count;
-		spin_unlock(&drm_mem_lock);
-		return 0;
-	}
-	spin_lock(&drm_mem_lock);
-	++drm_mem_stats[area].succeed_count;
-	drm_mem_stats[area].bytes_allocated += bytes;
-	drm_ram_used += bytes;
-	spin_unlock(&drm_mem_lock);
-
-	/* Zero outside the lock */
-	memset((void *)address, 0, bytes);
-
-	/* Reserve */
-	for (addr = address, sz = bytes;
-	     sz > 0; addr += PAGE_SIZE, sz -= PAGE_SIZE) {
-		SetPageReserved(virt_to_page(addr));
-	}
-
-	return address;
-}
-
-void drm_free_pages (unsigned long address, int order, int area) {
-	unsigned long bytes = PAGE_SIZE << order;
-	int alloc_count;
-	int free_count;
-	unsigned long addr;
-	unsigned int sz;
-
-	if (!address) {
-		DRM_MEM_ERROR(area, "Attempt to free address 0\n");
-	} else {
-		/* Unreserve */
-		for (addr = address, sz = bytes;
-		     sz > 0; addr += PAGE_SIZE, sz -= PAGE_SIZE) {
-			ClearPageReserved(virt_to_page(addr));
-		}
-		free_pages(address, order);
-	}
-
-	spin_lock(&drm_mem_lock);
-	free_count = ++drm_mem_stats[area].free_count;
-	alloc_count = drm_mem_stats[area].succeed_count;
-	drm_mem_stats[area].bytes_freed += bytes;
-	drm_ram_used -= bytes;
-	spin_unlock(&drm_mem_lock);
-	if (free_count > alloc_count) {
-		DRM_MEM_ERROR(area,
-			      "Excess frees: %d frees, %d allocs\n",
-			      free_count, alloc_count);
-	}
-}
-
 void *drm_ioremap (unsigned long offset, unsigned long size,
 		    drm_device_t * dev) {
 	void *pt;
--- linux-2.6.16-mm1-full/drivers/char/drm/drm_memory.c.old	2006-03-23 23:05:54.000000000 +0100
+++ linux-2.6.16-mm1-full/drivers/char/drm/drm_memory.c	2006-03-23 23:06:11.000000000 +0100
@@ -79,65 +79,6 @@
 	return pt;
 }
 
-/**
- * Allocate pages.
- *
- * \param order size order.
- * \param area memory area. (Not used.)
- * \return page address on success, or zero on failure.
- *
- * Allocate and reserve free pages.
- */
-unsigned long drm_alloc_pages(int order, int area)
-{
-	unsigned long address;
-	unsigned long bytes = PAGE_SIZE << order;
-	unsigned long addr;
-	unsigned int sz;
-
-	address = __get_free_pages(GFP_KERNEL|__GFP_COMP, order);
-	if (!address)
-		return 0;
-
-	/* Zero */
-	memset((void *)address, 0, bytes);
-
-	/* Reserve */
-	for (addr = address, sz = bytes;
-	     sz > 0; addr += PAGE_SIZE, sz -= PAGE_SIZE) {
-		SetPageReserved(virt_to_page(addr));
-	}
-
-	return address;
-}
-
-/**
- * Free pages.
- *
- * \param address address of the pages to free.
- * \param order size order.
- * \param area memory area. (Not used.)
- *
- * Unreserve and free pages allocated by alloc_pages().
- */
-void drm_free_pages(unsigned long address, int order, int area)
-{
-	unsigned long bytes = PAGE_SIZE << order;
-	unsigned long addr;
-	unsigned int sz;
-
-	if (!address)
-		return;
-
-	/* Unreserve */
-	for (addr = address, sz = bytes;
-	     sz > 0; addr += PAGE_SIZE, sz -= PAGE_SIZE) {
-		ClearPageReserved(virt_to_page(addr));
-	}
-
-	free_pages(address, order);
-}
-
 #if __OS_HAS_AGP
 /** Wrapper around agp_allocate_memory() */
 DRM_AGP_MEM *drm_alloc_agp(drm_device_t * dev, int pages, u32 type)

