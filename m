Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268711AbUH3S4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268711AbUH3S4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268916AbUH3S1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:27:07 -0400
Received: from vsmtp4alice-fr.tin.it ([212.216.176.150]:20212 "EHLO
	vsmtp4.tin.it") by vger.kernel.org with ESMTP id S268677AbUH3SLD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:11:03 -0400
Date: Mon, 30 Aug 2004 20:31:17 +0200
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: Re: [PATCH 2.6.9-rc1-mm1] Disable colour conversion in the CPiA
 Video Camera driver
Message-Id: <20040830203117.5acca627.luca.risolia@studio.unibo.it>
In-Reply-To: <20040830133205.GC1727@bytesex>
References: <20040830013201.7d153288.akpm@osdl.org>
	<20040830133205.GC1727@bytesex>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2004 15:32:05 +0200
Gerd Knorr <kraxel@bytesex.org> wrote:

> First: there should be a reasonable warning time for the current users.
> Some printk message telling them they are using a depricated feature.
> Maybe even a insmod option to enable/disable it, with the default being
> software conversion disabled.
> 
> Second: IMHO it would be a very good idea to port the driver to the v4l2
> API before ripping the in-kernel colorspace conversion support.  v4l2
> provides a sane API to get a list of supported color formats, whereas
> with v4l1 it is dirty trial-and-error + guesswork for the applications.

I don't see why porting the driver to the V4L2 API has to precede the
software conversion removal I was talking about. I think that the
negotiation of the color formats is not the point here...

For many years no one has ever cancelled deprecated code yet both
users and developers know that software conversion should be made
in userspace. It is worth to state that those who have preached this rule
and have always, for instance, been opposed to optional decoders
in kernel space, have never lifted a finger to correct already existing code. 
Now, I do not expect that these people wake up and even provide a V4L2 driver.

In addition, aside from software conversion, it is enough to take
a quick look at the code to understand that it is no longer maintained.
Having seen the recent occurrences, non-maintained drivers should be
altogether removed.

Nevertheless, there is below a new patch that adds a parameter to the
module and warnings for users, as suggested by you. Within a few months,
if this situation has not changed, I will propose a new patch that
completely removes the driver. At this later date, I hope not to find
objections and excuses that delay this problem.

Rules are made for everyone.

Luca


Signed-off-by: Luca Risolia <luca.risolia@studio.unibo.it>

--- devel-2.6.8/drivers/media/video/cpia.c.orig	2004-08-29 11:28:14.000000000 +0200
+++ devel-2.6.8/drivers/media/video/cpia.c	2004-08-30 17:14:36.000000000 +0200
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
@@ -1428,14 +1438,22 @@ static void __exit proc_cpia_destroy(voi
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
+	else 
+		LOG("Palette %u not available by default. Set colorspace_conv "
+		    "module parameter to 1 to enable it", (unsigned)(palette));
+
+	return 0;
 }
 
 static int match_videosize( int width, int height )
