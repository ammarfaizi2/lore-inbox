Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVLPG7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVLPG7P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 01:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbVLPG7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 01:59:15 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:7840 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932153AbVLPG7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 01:59:14 -0500
Date: Fri, 16 Dec 2005 06:59:01 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>,
       Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] Xserver startup locks system... git bisect results
In-Reply-To: <1134712343.6316.2.camel@gaston>
Message-ID: <Pine.LNX.4.58.0512160658220.22102@skynet>
References: <20051215043212.GA4479@jupiter.solarsys.private> 
 <1134622384.16880.26.camel@gaston> <1134623242.16880.30.camel@gaston> 
 <1134623748.16880.32.camel@gaston>  <17313.12671.661715.211100@cargo.ozlabs.ibm.com>
  <20051216035032.GA4026@jupiter.solarsys.private> <1134712343.6316.2.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Finally fixes the radeon memory mapping bug that was incorrectly
> fixed by the previous patch. This time, we use the actual vram
> size as the size to calculate how far to move the AGP aperture> from the
> framebuffer in card's memory space. If there are still issues with this
> patch, they are due to bugs in the X driver that I'm working on fixing
> too.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Dave Airlie <airlied@linux.ie>

>
> Index: linux-work/drivers/char/drm/radeon_cp.c
> ===================================================================
> --- linux-work.orig/drivers/char/drm/radeon_cp.c	2005-12-13 20:23:00.000000000 +1100
> +++ linux-work/drivers/char/drm/radeon_cp.c	2005-12-16 16:17:30.000000000 +1100
> @@ -1312,6 +1312,8 @@
>  static int radeon_do_init_cp(drm_device_t * dev, drm_radeon_init_t * init)
>  {
>  	drm_radeon_private_t *dev_priv = dev->dev_private;;
> +	unsigned int mem_size;
> +
>  	DRM_DEBUG("\n");
>
>  	dev_priv->is_pci = init->is_pci;
> @@ -1521,8 +1523,11 @@
>  					  + dev_priv->fb_location) >> 10));
>
>  	dev_priv->gart_size = init->gart_size;
> -	dev_priv->gart_vm_start = dev_priv->fb_location
> -	    + RADEON_READ(RADEON_CONFIG_APER_SIZE) * 2;
> +
> +	mem_size = RADEON_READ(RADEON_CONFIG_MEMSIZE);
> +	if (mem_size == 0)
> +		mem_size = 0x800000;
> +	dev_priv->gart_vm_start = dev_priv->fb_location + mem_size;
>
>  #if __OS_HAS_AGP
>  	if (!dev_priv->is_pci)
> Index: linux-work/drivers/char/drm/radeon_drv.h
> ===================================================================
> --- linux-work.orig/drivers/char/drm/radeon_drv.h	2005-11-25 15:03:35.000000000 +1100
> +++ linux-work/drivers/char/drm/radeon_drv.h	2005-12-16 16:14:43.000000000 +1100
> @@ -379,6 +379,7 @@
>  #	define RADEON_PLL_WR_EN			(1 << 7)
>  #define RADEON_CLOCK_CNTL_INDEX		0x0008
>  #define RADEON_CONFIG_APER_SIZE		0x0108
> +#define RADEON_CONFIG_MEMSIZE		0x00f8
>  #define RADEON_CRTC_OFFSET		0x0224
>  #define RADEON_CRTC_OFFSET_CNTL		0x0228
>  #	define RADEON_CRTC_TILE_EN		(1 << 15)
>
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

