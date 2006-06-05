Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750885AbWFEVQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWFEVQE (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 17:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWFEVQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 17:16:04 -0400
Received: from mail.gmx.de ([213.165.64.20]:51620 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750885AbWFEVQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 17:16:03 -0400
X-Authenticated: #704063
Subject: Re: [Patch] Zoran strncpy() cleanup
From: Eric Sesterhenn <snakebyte@gmx.de>
To: Horst Schirmeier <horst@schirmeier.com>
Cc: LKML <linux-kernel@vger.kernel.org>, bdirks@pacbell.net
In-Reply-To: <20060605210230.GN7236@quickstop.soohrt.org>
References: <1149538357.16994.7.camel@alice>
	 <20060605210230.GN7236@quickstop.soohrt.org>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 23:15:55 +0200
Message-Id: <1149542155.17537.3.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 23:02 +0200, Horst Schirmeier wrote:
> On Mon, 05 Jun 2006, Eric Sesterhenn wrote:
> > hi,
> > 
> > this was spotted by coverity ( bug id #536 ). While
> > it is not really a bug, i think we should clean it up.
> > std->name can only hold 24 chars, not 32 as the strncpy() calls
> > suggest. std->name can hold 32 chars, but since we use constant
> > fixed-sized strings, which will always fit into these arrays, i changed
> > the strncpy() calls to strcpy(). If you prefer strncpy(foo->name, "bar", sizeof(foo->name))
> > please let me know and i redo the patch.
> > 
> > Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> 
> This _is_ really a bug. strncpy() pads the remaining bytes of dest with
> zeroes, which destroys parts of the v4l2_standard structure (in
> particular, the v4l2_fract substructure). I'd suggest not to use
> strcpy() although it's safe here -- until someone changes the structure
> sizes.

Thanks for the fast reply, here is an updated version.
This patch changes all strncpy() calls to use sizeof(foo)-1 as the
last parameter.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc5/drivers/media/video/zoran_driver.c.orig	2006-06-05 23:05:32.000000000 +0200
+++ linux-2.6.17-rc5/drivers/media/video/zoran_driver.c	2006-06-05 23:12:06.000000000 +0200
@@ -2047,7 +2047,7 @@ zoran_do_ioctl (struct inode *inode,
 		dprintk(3, KERN_DEBUG "%s: VIDIOCGCAP\n", ZR_DEVNAME(zr));
 
 		memset(vcap, 0, sizeof(struct video_capability));
-		strncpy(vcap->name, ZR_DEVNAME(zr), sizeof(vcap->name));
+		strncpy(vcap->name, ZR_DEVNAME(zr), sizeof(vcap->name)-1);
 		vcap->type = ZORAN_VID_TYPE;
 
 		vcap->channels = zr->card.inputs;
@@ -2689,8 +2689,8 @@ zoran_do_ioctl (struct inode *inode,
 		dprintk(3, KERN_DEBUG "%s: VIDIOC_QUERYCAP\n", ZR_DEVNAME(zr));
 
 		memset(cap, 0, sizeof(*cap));
-		strncpy(cap->card, ZR_DEVNAME(zr), sizeof(cap->card));
-		strncpy(cap->driver, "zoran", sizeof(cap->driver));
+		strncpy(cap->card, ZR_DEVNAME(zr), sizeof(cap->card)-1);
+		strncpy(cap->driver, "zoran", sizeof(cap->driver)-1);
 		snprintf(cap->bus_info, sizeof(cap->bus_info), "PCI:%s",
 			 pci_name(zr->pci_dev));
 		cap->version =
@@ -2742,7 +2742,7 @@ zoran_do_ioctl (struct inode *inode,
 		memset(fmt, 0, sizeof(*fmt));
 		fmt->index = index;
 		fmt->type = type;
-		strncpy(fmt->description, zoran_formats[i].name, 31);
+		strncpy(fmt->description, zoran_formats[i].name, sizeof(fmt->description)-1);
 		fmt->pixelformat = zoran_formats[i].fourcc;
 		if (zoran_formats[i].flags & ZORAN_FORMAT_COMPRESSED)
 			fmt->flags |= V4L2_FMT_FLAG_COMPRESSED;
@@ -3566,16 +3566,16 @@ zoran_do_ioctl (struct inode *inode,
 
 		switch (ctrl->id) {
 		case V4L2_CID_BRIGHTNESS:
-			strncpy(ctrl->name, "Brightness", 31);
+			strncpy(ctrl->name, "Brightness", sizeof(ctrl->name)-1);
 			break;
 		case V4L2_CID_CONTRAST:
-			strncpy(ctrl->name, "Contrast", 31);
+			strncpy(ctrl->name, "Contrast", sizeof(ctrl->name)-1);
 			break;
 		case V4L2_CID_SATURATION:
-			strncpy(ctrl->name, "Saturation", 31);
+			strncpy(ctrl->name, "Saturation", sizeof(ctrl->name)-1);
 			break;
 		case V4L2_CID_HUE:
-			strncpy(ctrl->name, "Hue", 31);
+			strncpy(ctrl->name, "Hue", sizeof(ctrl->name)-1);
 			break;
 		}
 
@@ -3693,7 +3693,7 @@ zoran_do_ioctl (struct inode *inode,
 					&caps);
 			if (caps.flags & VIDEO_DECODER_AUTO) {
 				std->id = V4L2_STD_ALL;
-				strncpy(std->name, "Autodetect", 31);
+				strncpy(std->name, "Autodetect", sizeof(std->name)-1);
 				return 0;
 			} else
 				return -EINVAL;
@@ -3701,21 +3701,21 @@ zoran_do_ioctl (struct inode *inode,
 		switch (std->index) {
 		case 0:
 			std->id = V4L2_STD_PAL;
-			strncpy(std->name, "PAL", 31);
+			strncpy(std->name, "PAL", sizeof(std->name)-1);
 			std->frameperiod.numerator = 1;
 			std->frameperiod.denominator = 25;
 			std->framelines = zr->card.tvn[0]->Ht;
 			break;
 		case 1:
 			std->id = V4L2_STD_NTSC;
-			strncpy(std->name, "NTSC", 31);
+			strncpy(std->name, "NTSC", sizeof(std->name)-1);
 			std->frameperiod.numerator = 1001;
 			std->frameperiod.denominator = 30000;
 			std->framelines = zr->card.tvn[1]->Ht;
 			break;
 		case 2:
 			std->id = V4L2_STD_SECAM;
-			strncpy(std->name, "SECAM", 31);
+			strncpy(std->name, "SECAM", sizeof(std->name)-1);
 			std->frameperiod.numerator = 1;
 			std->frameperiod.denominator = 25;
 			std->framelines = zr->card.tvn[2]->Ht;
@@ -3871,7 +3871,7 @@ zoran_do_ioctl (struct inode *inode,
 		memset(outp, 0, sizeof(*outp));
 		outp->index = 0;
 		outp->type = V4L2_OUTPUT_TYPE_ANALOGVGAOVERLAY;
-		strncpy(outp->name, "Autodetect", 31);
+		strncpy(outp->name, "Autodetect", sizeof(outp->name)-1);
 
 		return 0;
 	}


