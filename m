Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424109AbWKIQse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424109AbWKIQse (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 11:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424106AbWKIQse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 11:48:34 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:20552 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1424110AbWKIQsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 11:48:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=ck4cUvt4G6sxoKAFILqHMEo+3S9VNh2JUsCPkfDxv6gs9kaUtJ/I4blCf4C72A1VdKj9KGHV0DPL4Bi76AlO9E28scab3Wo9pB76ilnwx7Pds2S+e+s5FjMxMoEJ89d+wBNUKYIS9yZRnwWaeag5c53UHkNEE4JXDenj1uZ3S64=
Message-ID: <45535C08.5020607@innova-card.com>
Date: Thu, 09 Nov 2006 17:49:12 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: fbmem: is bootup logo broken for monochrome LCD ?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to display the bootup logo on a monochrome LCD (1 bit per
pixel). I had to hack fbmem.c in a couple of place to make it
works. I'm wondering now if these changes are correct since I'm not
familiar with this code. Could anybody take a look and tell me ?

Thanks
		Franck

-- >8 --

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 17961e3..8c9d51f 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -247,6 +247,7 @@ static void fb_set_logo(struct fb_info *
 			       const struct linux_logo *logo, u8 *dst,
 			       int depth)
 {
+	u32 bpp = info->var.bits_per_pixel;
 	int i, j, k;
 	const u8 *src = logo->data;
 	u8 xor = (info->fix.visual == FB_VISUAL_MONO01) ? 0xff : 0;
@@ -275,9 +276,14 @@ static void fb_set_logo(struct fb_info *
 		for (i = 0; i < logo->height; i++) {
 			for (j = 0; j < logo->width; src++) {
 				d = *src ^ xor;
-				for (k = 7; k >= 0; k--) {
-					*dst++ = ((d >> k) & 1) ? fg : 0;
+				if (bpp == 1) {
+					*dst++ = d;
 					j++;
+				} else {
+					for (k = 7; k >= 0; k--) {
+						*dst++ = ((d >> k) & 1) ? fg : 0;
+						j++;
+					}
 				}
 			}
 		}
@@ -487,7 +493,6 @@ int fb_show_logo(struct fb_info *info, i
 	if (fb_logo.logo == NULL || info->state != FBINFO_STATE_RUNNING)
 		return 0;
 
-	image.depth = 8;
 	image.data = fb_logo.logo->data;
 
 	if (fb_logo.needs_cmapreset)
@@ -506,6 +511,9 @@ int fb_show_logo(struct fb_info *info, i
 
 		saved_pseudo_palette = info->pseudo_palette;
 		info->pseudo_palette = palette;
+	} else {
+		image.fg_color = 1;
+		image.bg_color = 0;
 	}
 
 	if (fb_logo.depth <= 4) {
@@ -525,6 +533,7 @@ int fb_show_logo(struct fb_info *info, i
 	image.dy = 0;
 	image.width = fb_logo.logo->width;
 	image.height = fb_logo.logo->height;
+	image.depth = fb_logo.depth;
 
 	if (rotate) {
 		logo_rotate = kmalloc(fb_logo.logo->width *
