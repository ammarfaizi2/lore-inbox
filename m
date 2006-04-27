Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWD0UUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWD0UUp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWD0UUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:20:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:20375 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030222AbWD0UUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:20:21 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Jon Smirl <jonsmirl@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 1/5] Frame buffer: remove cmap sysfs interface
Reply-To: Greg KH <greg@kroah.com>
Date: Thu, 27 Apr 2006 13:18:41 -0700
Message-Id: <11461691251083-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.3.1
In-Reply-To: <20060427201558.GA2101@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Smirl <jonsmirl@gmail.com>

Remove it as it does not work properly due to sysfs core changes.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/video/fbsysfs.c |   92 ++---------------------------------------------
 1 files changed, 3 insertions(+), 89 deletions(-)

913e7ec545462b9a49fa308d0c81697236f7d29d
diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
index b72b052..34e0739 100644
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -305,94 +305,6 @@ static ssize_t show_stride(struct class_
 	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->fix.line_length);
 }
 
-/* Format for cmap is "%02x%c%4x%4x%4x\n" */
-/* %02x entry %c transp %4x red %4x blue %4x green \n */
-/* 256 rows at 16 chars equals 4096, the normal page size */
-/* the code will automatically adjust for different page sizes */
-static ssize_t store_cmap(struct class_device *class_device, const char *buf,
-			  size_t count)
-{
-	struct fb_info *fb_info = class_get_devdata(class_device);
-	int rc, i, start, length, transp = 0;
-
-	if ((count > PAGE_SIZE) || ((count % 16) != 0))
-		return -EINVAL;
-
-	if (!fb_info->fbops->fb_setcolreg && !fb_info->fbops->fb_setcmap)
-		return -EINVAL;
-
-	sscanf(buf, "%02x", &start);
-	length = count / 16;
-
-	for (i = 0; i < length; i++)
-		if (buf[i * 16 + 2] != ' ')
-			transp = 1;
-
-	/* If we can batch, do it */
-	if (fb_info->fbops->fb_setcmap && length > 1) {
-		struct fb_cmap umap;
-
-		memset(&umap, 0, sizeof(umap));
-		if ((rc = fb_alloc_cmap(&umap, length, transp)))
-			return rc;
-
-		umap.start = start;
-		for (i = 0; i < length; i++) {
-			sscanf(&buf[i * 16 +  3], "%4hx", &umap.red[i]);
-			sscanf(&buf[i * 16 +  7], "%4hx", &umap.blue[i]);
-			sscanf(&buf[i * 16 + 11], "%4hx", &umap.green[i]);
-			if (transp)
-				umap.transp[i] = (buf[i * 16 +  2] != ' ');
-		}
-		rc = fb_info->fbops->fb_setcmap(&umap, fb_info);
-		fb_copy_cmap(&umap, &fb_info->cmap);
-		fb_dealloc_cmap(&umap);
-
-		return rc ?: count;
-	}
-	for (i = 0; i < length; i++) {
-		u16 red, blue, green, tsp;
-
-		sscanf(&buf[i * 16 +  3], "%4hx", &red);
-		sscanf(&buf[i * 16 +  7], "%4hx", &blue);
-		sscanf(&buf[i * 16 + 11], "%4hx", &green);
-		tsp = (buf[i * 16 +  2] != ' ');
-		if ((rc = fb_info->fbops->fb_setcolreg(start++,
-				      red, green, blue, tsp, fb_info)))
-			return rc;
-
-		fb_info->cmap.red[i] = red;
-		fb_info->cmap.blue[i] = blue;
-		fb_info->cmap.green[i] = green;
-		if (transp)
-			fb_info->cmap.transp[i] = tsp;
-	}
-	return count;
-}
-
-static ssize_t show_cmap(struct class_device *class_device, char *buf)
-{
-	struct fb_info *fb_info = class_get_devdata(class_device);
-	unsigned int i;
-
-	if (!fb_info->cmap.red || !fb_info->cmap.blue ||
-	   !fb_info->cmap.green)
-		return -EINVAL;
-
-	if (fb_info->cmap.len > PAGE_SIZE / 16)
-		return -EINVAL;
-
-	/* don't mess with the format, the buffer is PAGE_SIZE */
-	/* 256 entries at 16 chars per line equals 4096 = PAGE_SIZE */
-	for (i = 0; i < fb_info->cmap.len; i++) {
-		snprintf(&buf[ i * 16], PAGE_SIZE - i * 16, "%02x%c%4x%4x%4x\n", i + fb_info->cmap.start,
-			((fb_info->cmap.transp && fb_info->cmap.transp[i]) ? '*' : ' '),
-			fb_info->cmap.red[i], fb_info->cmap.blue[i],
-			fb_info->cmap.green[i]);
-	}
-	return 16 * fb_info->cmap.len;
-}
-
 static ssize_t store_blank(struct class_device *class_device, const char * buf,
 			   size_t count)
 {
@@ -502,10 +414,12 @@ static ssize_t show_fbstate(struct class
 	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->state);
 }
 
+/* When cmap is added back in it should be a binary attribute
+ * not a text one. Consideration should also be given to converting
+ * fbdev to use configfs instead of sysfs */
 static struct class_device_attribute class_device_attrs[] = {
 	__ATTR(bits_per_pixel, S_IRUGO|S_IWUSR, show_bpp, store_bpp),
 	__ATTR(blank, S_IRUGO|S_IWUSR, show_blank, store_blank),
-	__ATTR(color_map, S_IRUGO|S_IWUSR, show_cmap, store_cmap),
 	__ATTR(console, S_IRUGO|S_IWUSR, show_console, store_console),
 	__ATTR(cursor, S_IRUGO|S_IWUSR, show_cursor, store_cursor),
 	__ATTR(mode, S_IRUGO|S_IWUSR, show_mode, store_mode),
-- 
1.3.1

