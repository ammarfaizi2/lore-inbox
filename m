Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUJAQCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUJAQCF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 12:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUJAQCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 12:02:04 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:30870 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S263778AbUJAQB0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 12:01:26 -0400
X-Envelope-From: kraxel@bytesex.org
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] vesafb memory size mismatch
References: <20041001153624.267a808b@homer.gnuage.org>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 01 Oct 2004 17:48:21 +0200
In-Reply-To: <20041001153624.267a808b@homer.gnuage.org>
Message-ID: <87acv6l9ru.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aurelien Jacobs <aurel@gnuage.org> writes:

> Hi,
> 
> I found a bug in the vesafb driver. The video memory size which is
> reserved by vesafb do not correspond to the really needed memory.

Oh, while we are at it, I've hacked a patch as well some time ago.
All the size calculation in vesafb is a bit tricky.  I've tried to
cleanup that a bit and fix some bugs along the way, but never managed
to submit it.  I think the boundary check cleanups should also fix the
bug you've seen.

Ok, here we go ...

The patch does introduce some variables for the different sizes used
and add some comments what they are good for, so it's easier to see
what is actually going on:

  - size_vmode: minimum memory required for the video mode.
  - size_total: the total amount of memory we have.
  - size_remap: the amount of memory vesafb is going to use
    (and allocate kernel address space for).  By default this
    is size_vmode*2, so fbcon has some room to use.

For ressource allocation + mtrr entries size_total video memory is
used through.  The later is important for X11 performance, as the
X-Server will try to create a mtrr entry for the whole video memory
and fail in case vesafb creates a small one for size_remap only.

  Gerd

Index: linux-2.6.8/drivers/video/vesafb.c
===================================================================
--- linux-2.6.8.orig/drivers/video/vesafb.c	2004-08-18 12:11:41.000000000 +0200
+++ linux-2.6.8/drivers/video/vesafb.c	2004-08-18 18:23:23.554270385 +0200
@@ -218,6 +218,9 @@ static int __init vesafb_probe(struct de
 	struct platform_device *dev = to_platform_device(device);
 	struct fb_info *info;
 	int i, err;
+	unsigned int size_vmode;
+	unsigned int size_remap;
+	unsigned int size_total;
 
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_VLFB)
 		return -ENXIO;
@@ -229,32 +232,37 @@ static int __init vesafb_probe(struct de
 	vesafb_defined.xres = screen_info.lfb_width;
 	vesafb_defined.yres = screen_info.lfb_height;
 	vesafb_fix.line_length = screen_info.lfb_linelength;
-
-	/* Allocate enough memory for double buffering */
-	vesafb_fix.smem_len = screen_info.lfb_width * screen_info.lfb_height * vesafb_defined.bits_per_pixel >> 2;
-
-	/* check that we don't remap more memory than old cards have */
-	if (vesafb_fix.smem_len > (screen_info.lfb_size * 65536))
-		vesafb_fix.smem_len = screen_info.lfb_size * 65536;
-
-	/* Set video size according to vram boot option */
-	if (vram)
-		vesafb_fix.smem_len = vram * 1024 * 1024;
-
 	vesafb_fix.visual   = (vesafb_defined.bits_per_pixel == 8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
 
-	/* limit framebuffer size to 16 MB.  Otherwise we'll eat tons of
-	 * kernel address space for nothing if the gfx card has alot of
-	 * memory (>= 128 MB isn't uncommon these days ...) */
-	if (vesafb_fix.smem_len > 16 * 1024 * 1024)
-		vesafb_fix.smem_len = 16 * 1024 * 1024;
+	/*   size_vmode -- that is the amount of memory needed for the
+	 *                 used video mode, i.e. the minimum amount of
+	 *                 memory we need. */
+	size_vmode = (vesafb_defined.xres * vesafb_defined.yres *
+		vesafb_defined.bits_per_pixel) >> 3;
+
+	/*   size_total -- all video memory we have. Used for mtrr
+	 *                 entries and bounds checking. */
+	size_total = screen_info.lfb_size * 65536;
+	if (size_total < size_vmode)
+		size_total = size_vmode;
+	if (vram)
+		size_total = vram * 1024 * 1024;
+
+	/*   size_remap -- the amount of video memory we are going to
+	 *                 use for vesafb.  With modern cards it is no
+	 *                 option to simply use size_total as that
+	 *                 wastes plenty of kernel address space. */
+	size_remap  = size_vmode * 2;
+	if (size_remap > size_total)
+		size_remap = size_total;
+	vesafb_fix.smem_len = size_remap;
 
 #ifndef __i386__
 	screen_info.vesapm_seg = 0;
 #endif
 
-	if (!request_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len, "vesafb")) {
+	if (!request_mem_region(vesafb_fix.smem_start, size_total, "vesafb")) {
 		printk(KERN_WARNING
 		       "vesafb: abort, cannot reserve video memory at 0x%lx\n",
 			vesafb_fix.smem_start);
@@ -279,8 +287,10 @@ static int __init vesafb_probe(struct de
 		goto err;
 	}
 
-	printk(KERN_INFO "vesafb: framebuffer at 0x%lx, mapped to 0x%p, size %dk\n",
-	       vesafb_fix.smem_start, info->screen_base, vesafb_fix.smem_len/1024);
+	printk(KERN_INFO "vesafb: framebuffer at 0x%lx, mapped to 0x%p, "
+	       "using %dk, total %dk\n",
+	       vesafb_fix.smem_start, info->screen_base,
+	       size_remap/1024, size_total/1024);
 	printk(KERN_INFO "vesafb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
 	       vesafb_defined.xres, vesafb_defined.yres, vesafb_defined.bits_per_pixel, vesafb_fix.line_length, screen_info.pages);
 
@@ -364,7 +374,7 @@ static int __init vesafb_probe(struct de
 	request_region(0x3c0, 32, "vesafb");
 
 	if (mtrr) {
-		int temp_size = vesafb_fix.smem_len;
+		int temp_size = size_total;
 		/* Find the largest power-of-two */
 		while (temp_size & (temp_size - 1))
                 	temp_size &= (temp_size - 1);
@@ -395,7 +405,7 @@ static int __init vesafb_probe(struct de
 	return 0;
 err:
 	framebuffer_release(info);
-	release_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len);
+	release_mem_region(vesafb_fix.smem_start, size_total);
 	return err;
 }
 
