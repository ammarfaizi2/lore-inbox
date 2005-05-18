Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVERC6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVERC6K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 22:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVERC6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 22:58:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:28293 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262062AbVERC6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 22:58:04 -0400
Subject: [PATCH] DRM: Fix radeon mapping of AGP
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Airlie <airlied@gmail.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net
Content-Type: text/plain
Date: Wed, 18 May 2005 12:57:44 +1000
Message-Id: <1116385064.6122.7.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David! 

Here's my latest version of the patch for radeon_cp that fixes the
possible overlap mapping we talked about. I went the paranoid way this
time, by checking both CONFIG_MEMSIZE and MC_FB_LOCATION "top", in order
to put the AGP aperture always above any of those. This should avoid bad
surprises in the future and fix the problem with existing ppc r300's who
have CONFIG_APER_SIZE < CONFIG_MEM_SIZE.

The X.org side is still bogus, but at least, with this DRM fix, this
won't break it all, X will just use only half of VRAM I suppose. I'll
work on fixing X later.

Let me know if that patch is ok, others on the list, I would appreciate
if you could give it a try and make sure it doesn't cause any
regression. It applies against current Linus git tree.

Index: linux-work/drivers/char/drm/radeon_drv.h
===================================================================
--- linux-work.orig/drivers/char/drm/radeon_drv.h	2005-05-02 10:48:09.000000000 +1000
+++ linux-work/drivers/char/drm/radeon_drv.h	2005-05-18 11:39:00.000000000 +1000
@@ -346,6 +346,7 @@
 #define RADEON_CLOCK_CNTL_DATA		0x000c
 #	define RADEON_PLL_WR_EN			(1 << 7)
 #define RADEON_CLOCK_CNTL_INDEX		0x0008
+#define RADEON_CONFIG_MEMSIZE		0x00f8
 #define RADEON_CONFIG_APER_SIZE		0x0108
 #define RADEON_CRTC_OFFSET		0x0224
 #define RADEON_CRTC_OFFSET_CNTL		0x0228
Index: linux-work/drivers/char/drm/radeon_cp.c
===================================================================
--- linux-work.orig/drivers/char/drm/radeon_cp.c	2005-05-02 10:48:09.000000000 +1000
+++ linux-work/drivers/char/drm/radeon_cp.c	2005-05-18 12:00:07.000000000 +1000
@@ -1267,7 +1267,8 @@
 
 static int radeon_do_init_cp( drm_device_t *dev, drm_radeon_init_t *init )
 {
-	drm_radeon_private_t *dev_priv = dev->dev_private;;
+	drm_radeon_private_t *dev_priv = dev->dev_private;
+	u32 gart_loc, mem_size, mem_top;
 	DRM_DEBUG( "\n" );
 
 	dev_priv->is_pci = init->is_pci;
@@ -1476,8 +1477,32 @@
 
 
 	dev_priv->gart_size = init->gart_size;
-	dev_priv->gart_vm_start = dev_priv->fb_location
-				+ RADEON_READ( RADEON_CONFIG_APER_SIZE );
+	mem_size = RADEON_READ(RADEON_CONFIG_MEMSIZE);
+	mem_top = RADEON_READ(RADEON_MC_FB_LOCATION) & 0xffff0000;
+
+	/* assume mem_size of 0 means one of those buggy M6 and thus
+	 * is 8Mb
+	 */
+	if (mem_size == 0)
+		mem_size = 0x00800000;
+	
+	/* if MC_FB_LOCATION was set for a bigger aperture, then adapt,
+	 * we really want to make sure there is no overlap between the
+	 * region defined by MC_FB_LOCATION and the AGP aperture
+	 */
+	if (((mem_top + 1) - dev_priv->fb_location) > mem_size)
+		mem_size = (mem_top + 1) - dev_priv->fb_location;
+	/* try to put the gart after the framebuffer */
+	gart_loc = dev_priv->fb_location + mem_size;
+	/* if it overflows, warn and try to put it _before_ the framebuffer */
+	if ((gart_loc + dev_priv->gart_size) < dev_priv->fb_location) {
+		DRM_INFO("Warning ! Gart does not fit above framebuffer in "
+			 "card space, moving it below. Risks collision with "
+			 " main memory ! ");
+		gart_loc = dev_priv->fb_location - dev_priv->gart_size;
+	}
+	
+	dev_priv->gart_vm_start = gart_loc;
 
 #if __OS_HAS_AGP
 	if ( !dev_priv->is_pci )


