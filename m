Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbVLPDul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVLPDul (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 22:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbVLPDul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 22:50:41 -0500
Received: from smtp-relay.dca.net ([216.158.48.66]:5557 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S932107AbVLPDul
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 22:50:41 -0500
Date: Thu, 15 Dec 2005 22:50:32 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       LKML <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [BUG] Xserver startup locks system... git bisect results
Message-ID: <20051216035032.GA4026@jupiter.solarsys.private>
References: <20051215043212.GA4479@jupiter.solarsys.private> <1134622384.16880.26.camel@gaston> <1134623242.16880.30.camel@gaston> <1134623748.16880.32.camel@gaston> <17313.12671.661715.211100@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17313.12671.661715.211100@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul, Benjamin:

* Paul Mackerras <paulus@samba.org> [2005-12-15 20:03:59 +1100]:
> Benjamin Herrenschmidt writes:
> 
> > On Thu, 2005-12-15 at 16:07 +1100, Benjamin Herrenschmidt wrote:
> > > Ah, also, something else you can try, is replace
> > > 
> > > 	dev_priv->gart_vm_start = dev_priv->fb_location
> > > 	    + RADEON_READ(RADEON_CONFIG_APER_SIZE);
> > 
> > Actually, the above should read
> > 
> > 	    + RADEON_READ(RADEON_CONFIG_APER_SIZE) * 2;
> 
> With the patch below, my powerbook will sleep and wake up
> successfully.

I added the printk's you (BH) asked for to Paul's patch, resulting in the
patch below.  It works fine so far.  Here's the relevant kernel log:

Dec 15 22:39:47 jupiter kernel: dev_priv->fb_location is 0xe8000000
Dec 15 22:39:47 jupiter kernel: RADEON_READ(RADEON_CONFIG_APER_SIZE) is 0x08000000
Dec 15 22:39:47 jupiter kernel: [drm] Loading R200 Microcode

Let me know if you need any more info.  Thanks.

--- linux-2.6.15-rc5-radeon-test.orig/drivers/char/drm/radeon_cp.c
+++ linux-2.6.15-rc5-radeon-test/drivers/char/drm/radeon_cp.c
@@ -1522,7 +1522,12 @@ static int radeon_do_init_cp(drm_device_
 
 	dev_priv->gart_size = init->gart_size;
 	dev_priv->gart_vm_start = dev_priv->fb_location
-	    + RADEON_READ(RADEON_CONFIG_APER_SIZE) * 2;
+	    + RADEON_READ(RADEON_CONFIG_MEMSIZE);
+
+printk(KERN_INFO "dev_priv->fb_location is 0x%08x\n",
+	dev_priv->fb_location);
+printk(KERN_INFO "RADEON_READ(RADEON_CONFIG_APER_SIZE) is 0x%08x\n",
+	RADEON_READ(RADEON_CONFIG_APER_SIZE));
 
 #if __OS_HAS_AGP
 	if (!dev_priv->is_pci)
--- linux-2.6.15-rc5-radeon-test.orig/drivers/char/drm/radeon_drv.h
+++ linux-2.6.15-rc5-radeon-test/drivers/char/drm/radeon_drv.h
@@ -379,6 +379,7 @@ extern int r300_do_cp_cmdbuf(drm_device_
 #	define RADEON_PLL_WR_EN			(1 << 7)
 #define RADEON_CLOCK_CNTL_INDEX		0x0008
 #define RADEON_CONFIG_APER_SIZE		0x0108
+#define RADEON_CONFIG_MEMSIZE		0x00f8
 #define RADEON_CRTC_OFFSET		0x0224
 #define RADEON_CRTC_OFFSET_CNTL		0x0228
 #	define RADEON_CRTC_TILE_EN		(1 << 15)

-- 
Mark M. Hoffman
mhoffman@lightlink.com

