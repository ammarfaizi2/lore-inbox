Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbVL0MME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVL0MME (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 07:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVL0MMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 07:12:03 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:49576 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S932298AbVL0MMB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 07:12:01 -0500
X-Sieve: CMU Sieve 2.2
Subject: Re: Suspend to {mem,disk} broken in 2.6.15-rc6/rc7 on my T42
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jules Villard <jvillard@ens-lyon.fr>, linux-kernel@vger.org,
       Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@linux.ie>
In-Reply-To: <Pine.LNX.4.64.0512261545460.14098@g5.osdl.org>
References: <20051226194527.GA3036@blatterie>
	 <Pine.LNX.4.64.0512261545460.14098@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 27 Dec 2005 12:49:33 +1100
Message-Id: <1135648173.4780.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also, while we are at it, can you try this patch on top of current
-git ? What I _think_ might be happening is that the X server is also
trying to muck around with the card memory map and is forcing it back
into a wrong setting that also happens to no longer match what the DRM
wants to do and blows up. There are bugs all over the place in that code
(and still some bugs in the DRM as well anyway). This patch attempts to
avoid that by using the largest of the 2 values, which I think will
cause it to behave as it used to for you and will still fix the problem
with machines that have an aperture size smaller than the video memory.

That might be good enough until I fully fix X and the DRM (work in progress
but there are other "issues").

Index: linux-work/drivers/char/drm/radeon_cp.c
===================================================================
--- linux-work.orig/drivers/char/drm/radeon_cp.c	2005-12-24 10:07:22.000000000 +1100
+++ linux-work/drivers/char/drm/radeon_cp.c	2005-12-27 12:48:02.000000000 +1100
@@ -1312,7 +1312,7 @@
 static int radeon_do_init_cp(drm_device_t * dev, drm_radeon_init_t * init)
 {
 	drm_radeon_private_t *dev_priv = dev->dev_private;
-	unsigned int mem_size;
+	unsigned int mem_size, aper_size;
 
 	DRM_DEBUG("\n");
 
@@ -1527,7 +1527,9 @@
 	mem_size = RADEON_READ(RADEON_CONFIG_MEMSIZE);
 	if (mem_size == 0)
 		mem_size = 0x800000;
-	dev_priv->gart_vm_start = dev_priv->fb_location + mem_size;
+	aper_size = max(RADEON_READ(RADEON_CONFIG_APER_SIZE), mem_size);
+
+	dev_priv->gart_vm_start = dev_priv->fb_location + aper_size;
 
 #if __OS_HAS_AGP
 	if (!dev_priv->is_pci)


