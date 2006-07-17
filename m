Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWGQO3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWGQO3N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 10:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWGQO3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 10:29:13 -0400
Received: from mail.suse.de ([195.135.220.2]:47541 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750797AbWGQO3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 10:29:12 -0400
Message-ID: <44BB9EB3.9020101@suse.de>
Date: Mon, 17 Jul 2006 16:29:07 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Kalev Lember <kalev@smartlink.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kexec and framebuffer
References: <44BB9A7A.4060100@smartlink.ee>
In-Reply-To: <44BB9A7A.4060100@smartlink.ee>
Content-Type: multipart/mixed;
 boundary="------------060001080505080003070002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060001080505080003070002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

  Hi,

> I am wondering what would be the preferred method to extract screen_info
> from running kernel. Should this be made available from sysfs or maybe a
> new system call be created?

Simply ask /dev/fb0?
Patch for kexec tools attached.

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
http://www.suse.de/~kraxel/julika-dora.jpeg

--------------060001080505080003070002
Content-Type: text/x-patch;
 name="kexec-vesafb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kexec-vesafb.diff"

Index: kexec-tools-1.101/kexec/arch/i386/x86-linux-setup.c
===================================================================
--- kexec-tools-1.101.orig/kexec/arch/i386/x86-linux-setup.c	2006-03-03 10:51:31.000000000 +0100
+++ kexec-tools-1.101/kexec/arch/i386/x86-linux-setup.c	2006-03-10 14:02:20.000000000 +0100
@@ -24,6 +24,8 @@
 #include <sys/stat.h>
 #include <sys/mman.h>
 #include <fcntl.h>
+#include <sys/ioctl.h>
+#include <linux/fb.h>
 #include <unistd.h>
 #include <x86/x86-linux.h>
 #include "../../kexec.h"
@@ -94,6 +96,56 @@ void setup_linux_bootloader_parameters(
 	cmdline_ptr[cmdline_len - 1] = '\0';
 }
 
+int setup_linux_vesafb(struct x86_linux_param_header *real_mode)
+{
+	struct fb_fix_screeninfo fix;
+	struct fb_var_screeninfo var;
+	int fd;
+
+	fd = open("/dev/fb0", O_RDONLY);
+	if (-1 == fd)
+		return -1;
+
+	if (-1 == ioctl(fd, FBIOGET_FSCREENINFO, &fix))
+		goto out;
+	if (-1 == ioctl(fd, FBIOGET_VSCREENINFO, &var))
+		goto out;
+	if (0 != strcmp(fix.id, "vesafb"))
+		goto out;
+	close(fd);
+
+	real_mode->orig_video_isVGA = 0x23 /* VIDEO_TYPE_VLFB */;
+	real_mode->lfb_width      = var.xres;
+	real_mode->lfb_height     = var.yres;
+	real_mode->lfb_depth      = var.bits_per_pixel;
+	real_mode->lfb_base       = fix.smem_start;
+	real_mode->lfb_linelength = fix.line_length;
+	real_mode->vesapm_seg     = 0;
+
+	/* fixme: better get size from /proc/iomem */
+	real_mode->lfb_size       = (fix.smem_len + 65535) / 65536;
+	real_mode->pages          = (fix.smem_len + 4095) / 4096;
+
+	if (var.bits_per_pixel > 8) {
+		real_mode->red_pos    = var.red.offset;
+		real_mode->red_size   = var.red.length;
+		real_mode->green_pos  = var.green.offset;
+		real_mode->green_size = var.green.length;
+		real_mode->blue_pos   = var.blue.offset;
+		real_mode->blue_size  = var.blue.length;
+		real_mode->rsvd_pos   = var.transp.offset;
+		real_mode->rsvd_size  = var.transp.length;
+	}
+	fprintf(stderr, "%s: %dx%dx%d @ %lx +%lx\n", __FUNCTION__,
+		var.xres, var.yres, var.bits_per_pixel,
+		fix.smem_start, fix.smem_len);
+	return 0;
+
+ out:
+	close(fd);
+	return -1;
+}
+
 void setup_linux_system_parameters(struct x86_linux_param_header *real_mode,
 					unsigned long kexec_flags)
 {
@@ -111,6 +163,7 @@ void setup_linux_system_parameters(struc
 	real_mode->orig_video_ega_bx = 0;
 	real_mode->orig_video_isVGA = 1;
 	real_mode->orig_video_points = 16;
+	setup_linux_vesafb(real_mode);
 
 	/* Fill in the memsize later */
 	real_mode->ext_mem_k = 0;

--------------060001080505080003070002--
