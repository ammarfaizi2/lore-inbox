Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUIAFrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUIAFrQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 01:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUIAFrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 01:47:15 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:19397 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S262085AbUIAFrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 01:47:10 -0400
Date: Wed, 1 Sep 2004 08:07:28 +0200
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       alan@redhat.com
Subject: Re: [PATCH 2.6.9-rc1-mm1] Disable colour conversion in the CPiA
 Video Camera driver
Message-Id: <20040901080728.2563f883.luca.risolia@studio.unibo.it>
In-Reply-To: <20040831175235.GA21130@bytesex>
References: <20040830013201.7d153288.akpm@osdl.org>
	<20040830133205.GC1727@bytesex>
	<20040830203117.5acca627.luca.risolia@studio.unibo.it>
	<20040831175235.GA21130@bytesex>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2004 19:52:36 +0200
Gerd Knorr <kraxel@bytesex.org> wrote:

> The message should be rate limited as suggested in the previous message
> (because otherwise the log may be flooded with bogous warnings due to
> the v4l1 API issues mentioned above).  Maybe a single message at insmod
> time is even better.
> 
> In any case the message should make clear the intention of this, i.e.
> that it is planned to drop in-kernel conversion altogether by -- say --
> sept 2005 (should be enougth warning time), that is disabled by default
> now to catch problem cases, and that the users should fix the apps in
> case they don't work without conversion reenabled via insmod option.

Okay, please apply.

Signed-off-by: Luca Risolia <luca.risolia@studio.unibo.it>

--- devel-2.6.8/drivers/media/video/cpia.c.orig	2004-08-29 11:28:14.000000000 +0200
+++ devel-2.6.8/drivers/media/video/cpia.c	2004-09-01 07:54:13.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/config.h>
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/vmalloc.h>
@@ -62,6 +63,15 @@ MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("video");
 #endif
 
+static unsigned short colorspace_conv = 0;
+module_param(colorspace_conv, ushort, 0444);
+MODULE_PARM_DESC(colorspace_conv,
+                 "\n<n> Colorspace conversion:"
+                 "\n0 = disable"
+                 "\n1 = enable"
+                 "\nDefault value is 0"
+                 "\n");
+
 #define ABOUT "V4L-Driver for Vision CPiA based cameras"
 
 #ifndef VID_HARDWARE_CPIA
@@ -1428,14 +1438,19 @@ static void __exit proc_cpia_destroy(voi
 /* supported frame palettes and depths */
 static inline int valid_mode(u16 palette, u16 depth)
 {
-	return (palette == VIDEO_PALETTE_GREY && depth == 8) ||
-	       (palette == VIDEO_PALETTE_RGB555 && depth == 16) ||
-	       (palette == VIDEO_PALETTE_RGB565 && depth == 16) ||
-	       (palette == VIDEO_PALETTE_RGB24 && depth == 24) ||
-	       (palette == VIDEO_PALETTE_RGB32 && depth == 32) ||
-	       (palette == VIDEO_PALETTE_YUV422 && depth == 16) ||
-	       (palette == VIDEO_PALETTE_YUYV && depth == 16) ||
-	       (palette == VIDEO_PALETTE_UYVY && depth == 16);
+	if ((palette == VIDEO_PALETTE_YUV422 && depth == 16) ||
+	    (palette == VIDEO_PALETTE_YUYV && depth == 16))
+		return 1;
+
+	if (colorspace_conv)
+		return (palette == VIDEO_PALETTE_GREY && depth == 8) ||
+		       (palette == VIDEO_PALETTE_RGB555 && depth == 16) ||
+		       (palette == VIDEO_PALETTE_RGB565 && depth == 16) ||
+		       (palette == VIDEO_PALETTE_RGB24 && depth == 24) ||
+		       (palette == VIDEO_PALETTE_RGB32 && depth == 32) ||
+		       (palette == VIDEO_PALETTE_UYVY && depth == 16);
+
+	return 0;
 }
 
 static int match_videosize( int width, int height )
@@ -4040,6 +4055,13 @@ static int __init cpia_init(void)
 {
 	printk(KERN_INFO "%s v%d.%d.%d\n", ABOUT,
 	       CPIA_MAJ_VER, CPIA_MIN_VER, CPIA_PATCH_VER);
+
+	printk(KERN_WARNING "Since in-kernel colorspace conversion is not "
+	       "allowed, it is disabled by default now. Users should fix the "
+	       "applications in case they don't work without conversion "
+	       "reenabled by setting the 'colorspace_conv' module "
+	       "parameter to 1");
+
 #ifdef CONFIG_PROC_FS
 	proc_cpia_create();
 #endif
