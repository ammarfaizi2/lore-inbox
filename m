Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVG1Tdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVG1Tdu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 15:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbVG1Tdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 15:33:35 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:37540 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261643AbVG1Tbr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 15:31:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lvg9tPeUw5maeBGF0t3IUI5JB4i/a54MSviOa4FVx83vpLFHOcztMZ6+FjV7cQ98d1lMwn4m2fKRxpUS0BJ9Tm48hgDIWFqhHtol0Dn8u4jU0qRbgMdZmR3mq2ir/Ki1gLRasgBGK1z5pv4TrZyL+TCGbcNOklRuTcSAqBocz/o=
Message-ID: <9e473391050728123150931cbd@mail.gmail.com>
Date: Thu, 28 Jul 2005 15:31:44 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fbdev: colormap fixes
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <9e473391050728074573e40038@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507280031.j6S0V3L3016861@hera.kernel.org>
	 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be>
	 <9e473391050728074573e40038@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do we want to apply this patch now to get rid of the buffer overflow hole?
Then we can take our time and work out a better solution.

-- 
Jon Smirl
jonsmirl@gmail.com

Fix a buffer overflow vunerabilty in previous cmap patch
signed-off-by: Jon Smirl <jonsmirl@gmail.com>

diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -244,15 +244,15 @@ static ssize_t show_virtual(struct class
 
 /* Format for cmap is "%02x%c%4x%4x%4x\n" */
 /* %02x entry %c transp %4x red %4x blue %4x green \n */
-/* 255 rows at 16 chars equals 4096 */
-/* PAGE_SIZE can be 4096 or larger */
+/* 256 rows at 16 chars equals 4096, the normal page size */
+/* the code will automatically adjust for different page sizes */
 static ssize_t store_cmap(struct class_device *class_device, const char *buf,
 			  size_t count)
 {
 	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
 	int rc, i, start, length, transp = 0;
 
-	if ((count > 4096) || ((count % 16) != 0) || (PAGE_SIZE < 4096))
+	if ((count > PAGE_SIZE) || ((count % 16) != 0))
 		return -EINVAL;
 
 	if (!fb_info->fbops->fb_setcolreg && !fb_info->fbops->fb_setcmap)
@@ -317,18 +317,18 @@ static ssize_t show_cmap(struct class_de
 	   !fb_info->cmap.green)
 		return -EINVAL;
 
-	if (PAGE_SIZE < 4096)
+	if (fb_info->cmap.len > PAGE_SIZE / 16)
 		return -EINVAL;
 
 	/* don't mess with the format, the buffer is PAGE_SIZE */
-	/* 255 entries at 16 chars per line equals 4096 = PAGE_SIZE */
+	/* 256 entries at 16 chars per line equals 4096 = PAGE_SIZE */
 	for (i = 0; i < fb_info->cmap.len; i++) {
-		sprintf(&buf[ i * 16], "%02x%c%4x%4x%4x\n", i + fb_info->cmap.start,
+		snprintf(&buf[ i * 16], PAGE_SIZE - i * 16, "%02x%c%4x%4x%4x\n", i
+ fb_info->cmap.start,
 			((fb_info->cmap.transp && fb_info->cmap.transp[i]) ? '*' : ' '),
 			fb_info->cmap.red[i], fb_info->cmap.blue[i],
 			fb_info->cmap.green[i]);
 	}
-	return 4096;
+	return 16 * fb_info->cmap.len;
 }
 
 static ssize_t store_blank(struct class_device *class_device, const char * buf,
