Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbULQVEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbULQVEC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 16:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbULQVDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 16:03:51 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:40105 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262164AbULQUym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 15:54:42 -0500
From: Mike Werner <werner@sgi.com>
Reply-To: werner@sgi.com
To: davej@codemonkey.org.uk
Subject: [patch 2.6.10-rc3 4/4] agpgart: allow multiple backends to be initialized
Date: Fri, 17 Dec 2004 12:56:21 -0800
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412171256.22666.werner@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This new version reduces the number of changes required by users of the agpgart
such as drm to support the new api for multiple agp bridges. 
The first patch doesn't touch any platform specific files and all current platform
gart drivers will just work the same as they do now since the global 
agp_bridge is still supported as the default bridge.

Summary for the 4 patches.
[1/4] Allow multiple backends to be initialized for agpgart
[2/4] Run Lindent on generic.c
[3/4] Patch drm code to work with modified agpgart api.
[4/4] Patch framebuffer code to work with modified agpgart api.
-----------------------------------------------------------------------------
 aty/radeon_pm.c      |    3 ++-
 i810/i810_main.c     |   17 +++++++++--------
 intelfb/intelfbdrv.c |   23 ++++++++++++-----------
 3 files changed, 23 insertions(+), 20 deletions(-)

# This is a BitKeeper generated diff -Nru style patch.
#
#   add fb support for new multiple agp bridge agpgart api
# 
diff -Nru a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
--- a/drivers/video/aty/radeon_pm.c	2004-12-17 12:53:56 -08:00
+++ b/drivers/video/aty/radeon_pm.c	2004-12-17 12:53:56 -08:00
@@ -870,7 +870,8 @@
 	 * not for a module.
 	 */
 #ifdef CONFIG_AGP
-	agp_enable(0);
+	/* The bridge can be determined from agp_backend_acquire */
+	agp_enable(agp_bridge, 0);
 #endif
 
 	fb_set_suspend(info, 1);
diff -Nru a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c	2004-12-17 12:53:56 -08:00
+++ b/drivers/video/i810/i810_main.c	2004-12-17 12:53:56 -08:00
@@ -1591,40 +1591,41 @@
 {
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
 	int size;
+	struct agp_bridge_data *bridge;
 	
 	i810_fix_offsets(par);
 	size = par->fb.size + par->iring.size;
 
-	if (agp_backend_acquire()) {
+	if (!(bridge = agp_backend_acquire(par->dev))) {
 		printk("i810fb_alloc_fbmem: cannot acquire agpgart\n");
 		return -ENODEV;
 	}
 	if (!(par->i810_gtt.i810_fb_memory = 
-	      agp_allocate_memory(size >> 12, AGP_NORMAL_MEMORY))) {
+	      agp_allocate_memory(bridge, size >> 12, AGP_NORMAL_MEMORY))) {
 		printk("i810fb_alloc_fbmem: can't allocate framebuffer "
 		       "memory\n");
-		agp_backend_release();
+		agp_backend_release(bridge);
 		return -ENOMEM;
 	}
 	if (agp_bind_memory(par->i810_gtt.i810_fb_memory,
 			    par->fb.offset)) {
 		printk("i810fb_alloc_fbmem: can't bind framebuffer memory\n");
-		agp_backend_release();
+		agp_backend_release(bridge);
 		return -EBUSY;
 	}	
 	
 	if (!(par->i810_gtt.i810_cursor_memory = 
-	      agp_allocate_memory(par->cursor_heap.size >> 12,
+	      agp_allocate_memory(bridge, par->cursor_heap.size >> 12,
 				  AGP_PHYSICAL_MEMORY))) {
 		printk("i810fb_alloc_cursormem:  can't allocate" 
 		       "cursor memory\n");
-		agp_backend_release();
+		agp_backend_release(bridge);
 		return -ENOMEM;
 	}
 	if (agp_bind_memory(par->i810_gtt.i810_cursor_memory,
 			    par->cursor_heap.offset)) {
 		printk("i810fb_alloc_cursormem: cannot bind cursor memory\n");
-		agp_backend_release();
+		agp_backend_release(bridge);
 		return -EBUSY;
 	}	
 
@@ -1632,7 +1633,7 @@
 
 	i810_fix_pointers(par);
 
-	agp_backend_release();
+	agp_backend_release(bridge);
 
 	return 0;
 }
diff -Nru a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
--- a/drivers/video/intelfb/intelfbdrv.c	2004-12-17 12:53:56 -08:00
+++ b/drivers/video/intelfb/intelfbdrv.c	2004-12-17 12:53:56 -08:00
@@ -470,6 +470,7 @@
 	struct agp_kern_info gtt_info;
 	int agp_memtype;
 	const char *s;
+	struct agp_bridge_data *bridge;
 
 	DBG_MSG("intelfb_pci_register\n");
 
@@ -605,16 +606,16 @@
 	}
 
 	/* Use agpgart to manage the GATT */
-	if (agp_backend_acquire()) {
+	if (!(bridge = agp_backend_acquire(pdev))) {
 		ERR_MSG("cannot acquire agp\n");
 		cleanup(dinfo);
 		return -ENODEV;
 	}
 
 	/* get the current gatt info */
-	if (agp_copy_info(&gtt_info)) {
+	if (agp_copy_info(bridge, &gtt_info)) {
 		ERR_MSG("cannot get agp info\n");
-		agp_backend_release();
+		agp_backend_release(bridge);
 		cleanup(dinfo);
 		return -ENODEV;
 	}
@@ -637,17 +638,17 @@
 	/* Allocate memories (which aren't stolen) */
 	if (dinfo->accel) {
 		if (!(dinfo->gtt_ring_mem =
-		      agp_allocate_memory(dinfo->ring.size >> 12,
+		      agp_allocate_memory(bridge, dinfo->ring.size >> 12,
 					  AGP_NORMAL_MEMORY))) {
 			ERR_MSG("cannot allocate ring buffer memory\n");
-			agp_backend_release();
+			agp_backend_release(bridge);
 			cleanup(dinfo);
 			return -ENOMEM;
 		}
 		if (agp_bind_memory(dinfo->gtt_ring_mem,
 				    dinfo->ring.offset)) {
 			ERR_MSG("cannot bind ring buffer memory\n");
-			agp_backend_release();
+			agp_backend_release(bridge);
 			cleanup(dinfo);
 			return -EBUSY;
 		}
@@ -661,17 +662,17 @@
 		agp_memtype = dinfo->mobile ? AGP_PHYSICAL_MEMORY
 			: AGP_NORMAL_MEMORY;
 		if (!(dinfo->gtt_cursor_mem =
-		      agp_allocate_memory(dinfo->cursor.size >> 12,
+		      agp_allocate_memory(bridge, dinfo->cursor.size >> 12,
 					  agp_memtype))) {
 			ERR_MSG("cannot allocate cursor memory\n");
-			agp_backend_release();
+			agp_backend_release(bridge);
 			cleanup(dinfo);
 			return -ENOMEM;
 		}
 		if (agp_bind_memory(dinfo->gtt_cursor_mem,
 				    dinfo->cursor.offset)) {
 			ERR_MSG("cannot bind cursor memory\n");
-			agp_backend_release();
+			agp_backend_release(bridge);
 			cleanup(dinfo);
 			return -EBUSY;
 		}
@@ -686,7 +687,7 @@
 	}
 	if (dinfo->fbmem_gart) {
 		if (!(dinfo->gtt_fb_mem =
-		      agp_allocate_memory(dinfo->fb.size >> 12,
+		      agp_allocate_memory(bridge, dinfo->fb.size >> 12,
 					  AGP_NORMAL_MEMORY))) {
 			WRN_MSG("cannot allocate framebuffer memory - use "
 				"the stolen one\n");
@@ -709,7 +710,7 @@
 	dinfo->fb_start = dinfo->fb.offset << 12;
 
 	/* release agpgart */
-	agp_backend_release();
+	agp_backend_release(bridge);
 
 	if (mtrr)
 		set_mtrr(dinfo);
