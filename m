Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317022AbSHGFI0>; Wed, 7 Aug 2002 01:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317024AbSHGFI0>; Wed, 7 Aug 2002 01:08:26 -0400
Received: from smtp3.hushmail.com ([64.40.111.33]:13322 "EHLO
	smtp3.hushmail.com") by vger.kernel.org with ESMTP
	id <S317022AbSHGFIZ>; Wed, 7 Aug 2002 01:08:25 -0400
Message-Id: <200208070511.g775Bsf95940@mailserver2.hushmail.com>
From: silvio.cesare@hushmail.com
To: linux-kernel@vger.kernel.org
Subject: PATCH 2.4.19: drivers/video/sbusfb.c
Date: Tue,  6 Aug 2002 22:11:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


integer overflow in index + count, leading to unbounded copies.

patch has not been tested or verified.

--
Silvio

diff -u  drivers/video/sbusfb.c.2.4.19 drivers/video/sbusfb.c 
--- drivers/video/sbusfb.c.2.4.19       Tue Aug  6 21:17:39 2002
+++ drivers/video/sbusfb.c      Tue Aug  6 21:21:50 2002
@@ -599,7 +599,8 @@
                break;
        case FBIOGETCMAP_SPARC: {
                char *rp, *gp, *bp;
-               int end, count, index;
+               int count, index;
+               unsigned int end;
                struct fbcmap *cmap;
 
                if (!fb->loadcmap)
@@ -612,7 +613,10 @@
                        return -EFAULT;
                if ((index < 0) || (index > 255))
                        return -EINVAL;
-               if (index + count > 256)
+               if ((count < 0) || (count > 256))
+                       return -EINVAL;
+               end = index + count;
+               if (end > 256)
                        count = 256 - index;
                if (__get_user(rp, &cmap->red) ||
                    __get_user(gp, &cmap->green) ||
@@ -624,7 +628,6 @@
                        return -EFAULT;
                if (verify_area (VERIFY_WRITE, bp, count))
                        return -EFAULT;
-               end = index + count;
                for (i = index; i < end; i++){
                        if (__put_user(fb->color_map CM(i,0), rp) ||
                            __put_user(fb->color_map CM(i,1), gp) ||
@@ -637,7 +640,8 @@
        }
        case FBIOPUTCMAP_SPARC: {       /* load color map entries */
                char *rp, *gp, *bp;
-               int end, count, index;
+               int count, index;
+               unsigned int end;
                struct fbcmap *cmap;
                
                if (!fb->loadcmap || !fb->color_map)
@@ -650,7 +654,10 @@
                        return -EFAULT;
                if ((index < 0) || (index > 255))
                        return -EINVAL;
-               if (index + count > 256)
+               if ((count < 0) || (count > 256))
+                       return -EINVAL;
+               end = index + count;
+               if (end > 256)
                        count = 256 - index;
                if (__get_user(rp, &cmap->red) ||
                    __get_user(gp, &cmap->green) ||
@@ -663,7 +670,6 @@

Communicate in total privacy.
Get your free encrypted email at https://www.hushmail.com/?l=2

Looking for a good deal on a domain name? http://www.hush.com/partners/offers.cgi?id=domainpeople

