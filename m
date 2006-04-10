Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWDJV4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWDJV4I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 17:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWDJV4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 17:56:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:63186 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751211AbWDJV4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 17:56:07 -0400
X-Authenticated: #704063
Subject: [Patch] use after free in drivers/media/video/em28xx/em28xx-video.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: mchehab@brturbo.com.br
Content-Type: text/plain
Date: Mon, 10 Apr 2006 23:56:05 +0200
Message-Id: <1144706165.31602.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

in several we use dev->devno right after we kfree()
dev. This fixes coverity bug id #1065

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc1/drivers/media/video/em28xx/em28xx-video.c.orig	2006-04-10 23:49:05.000000000 +0200
+++ linux-2.6.17-rc1/drivers/media/video/em28xx/em28xx-video.c	2006-04-10 23:50:05.000000000 +0200
@@ -1576,8 +1576,8 @@ static int em28xx_init_dev(struct em28xx
 	errCode = em28xx_config(dev);
 	if (errCode) {
 		em28xx_errdev("error configuring device\n");
-		kfree(dev);
 		em28xx_devused&=~(1<<dev->devno);
+		kfree(dev);
 		return -ENOMEM;
 	}
 
@@ -1603,8 +1603,8 @@ static int em28xx_init_dev(struct em28xx
 	dev->vdev = video_device_alloc();
 	if (NULL == dev->vdev) {
 		em28xx_errdev("cannot allocate video_device.\n");
-		kfree(dev);
 		em28xx_devused&=~(1<<dev->devno);
+		kfree(dev);
 		return -ENOMEM;
 	}
 
@@ -1612,8 +1612,8 @@ static int em28xx_init_dev(struct em28xx
 	if (NULL == dev->vbi_dev) {
 		em28xx_errdev("cannot allocate video_device.\n");
 		kfree(dev->vdev);
-		kfree(dev);
 		em28xx_devused&=~(1<<dev->devno);
+		kfree(dev);
 		return -ENOMEM;
 	}
 
@@ -1650,8 +1650,8 @@ static int em28xx_init_dev(struct em28xx
 		mutex_unlock(&dev->lock);
 		list_del(&dev->devlist);
 		video_device_release(dev->vdev);
-		kfree(dev);
 		em28xx_devused&=~(1<<dev->devno);
+		kfree(dev);
 		return -ENODEV;
 	}
 
@@ -1662,8 +1662,8 @@ static int em28xx_init_dev(struct em28xx
 		list_del(&dev->devlist);
 		video_device_release(dev->vbi_dev);
 		video_device_release(dev->vdev);
-		kfree(dev);
 		em28xx_devused&=~(1<<dev->devno);
+		kfree(dev);
 		return -ENODEV;
 	} else {
 		printk("registered VBI\n");


