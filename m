Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbVLOJED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbVLOJED (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVLOJD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:03:57 -0500
Received: from ozlabs.org ([203.10.76.45]:58279 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932494AbVLOJDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:03:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17313.12671.661715.211100@cargo.ozlabs.ibm.com>
Date: Thu, 15 Dec 2005 20:03:59 +1100
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>,
       LKML <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [BUG] Xserver startup locks system... git bisect results
In-Reply-To: <1134623748.16880.32.camel@gaston>
References: <20051215043212.GA4479@jupiter.solarsys.private>
	<1134622384.16880.26.camel@gaston>
	<1134623242.16880.30.camel@gaston>
	<1134623748.16880.32.camel@gaston>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:

> On Thu, 2005-12-15 at 16:07 +1100, Benjamin Herrenschmidt wrote:
> > Ah, also, something else you can try, is replace
> > 
> > 	dev_priv->gart_vm_start = dev_priv->fb_location
> > 	    + RADEON_READ(RADEON_CONFIG_APER_SIZE);
> 
> Actually, the above should read
> 
> 	    + RADEON_READ(RADEON_CONFIG_APER_SIZE) * 2;

With the patch below, my powerbook will sleep and wake up
successfully.

Paul.

diff --git a/drivers/char/drm/radeon_cp.c b/drivers/char/drm/radeon_cp.c
index 9f2b4ef..465fdc2 100644
--- a/drivers/char/drm/radeon_cp.c
+++ b/drivers/char/drm/radeon_cp.c
@@ -1522,7 +1522,7 @@ static int radeon_do_init_cp(drm_device_
 
 	dev_priv->gart_size = init->gart_size;
 	dev_priv->gart_vm_start = dev_priv->fb_location
-	    + RADEON_READ(RADEON_CONFIG_APER_SIZE) * 2;
+	    + RADEON_READ(RADEON_CONFIG_MEMSIZE);
 
 #if __OS_HAS_AGP
 	if (!dev_priv->is_pci)
diff --git a/drivers/char/drm/radeon_drv.h b/drivers/char/drm/radeon_drv.h
index 7bda7e3..d92ccee 100644
--- a/drivers/char/drm/radeon_drv.h
+++ b/drivers/char/drm/radeon_drv.h
@@ -379,6 +379,7 @@ extern int r300_do_cp_cmdbuf(drm_device_
 #	define RADEON_PLL_WR_EN			(1 << 7)
 #define RADEON_CLOCK_CNTL_INDEX		0x0008
 #define RADEON_CONFIG_APER_SIZE		0x0108
+#define RADEON_CONFIG_MEMSIZE		0x00f8
 #define RADEON_CRTC_OFFSET		0x0224
 #define RADEON_CRTC_OFFSET_CNTL		0x0228
 #	define RADEON_CRTC_TILE_EN		(1 << 15)
