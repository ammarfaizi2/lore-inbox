Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWDLIdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWDLIdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 04:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWDLIdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 04:33:04 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:41131 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932111AbWDLIdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 04:33:03 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>, ebiederm@xmission.com
Message-Id: <20060412083402.25911.56088.sendpatchset@cherry.local>
Subject: [PATCH] Kexec: Common alloc
Date: Wed, 12 Apr 2006 17:33:02 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kexec: Common alloc

This patch reduces code redundancy by introducing a new function called
kimage_common_alloc() which is used to set up image->control_code_page.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

Applies on top of linux-2.6.17-rc1-git5 + "Kexec: Remove duplicate rimage"

 kexec.c |   51 ++++++++++++++++++++-------------------------------
 1 files changed, 20 insertions(+), 31 deletions(-)

--- 0004/kernel/kexec.c
+++ work/kernel/kexec.c	2006-04-12 16:30:34.000000000 +0900
@@ -205,34 +205,36 @@ out:
 
 }
 
-static int kimage_normal_alloc(struct kimage **rimage, unsigned long entry,
-				unsigned long nr_segments,
-				struct kexec_segment __user *segments)
+static int kimage_common_alloc(struct kimage *image)
 {
-	int result;
-	struct kimage *image;
-
-	/* Allocate and initialize a controlling structure */
-	image = NULL;
-	result = do_kimage_alloc(&image, entry, nr_segments, segments);
-	if (result)
-		goto out;
-
 	/*
-	 * Find a location for the control code buffer, and add it
+	 * Find a location for the control code buffer, and add
 	 * the vector of segments so that it's pages will also be
 	 * counted as destination pages.
 	 */
-	result = -ENOMEM;
 	image->control_code_page = kimage_alloc_control_pages(image,
 					   get_order(KEXEC_CONTROL_CODE_SIZE));
 	if (!image->control_code_page) {
 		printk(KERN_ERR "Could not allocate control_code_buffer\n");
-		goto out;
+		return -ENOMEM;
 	}
 
-	result = 0;
- out:
+	return 0;
+}
+
+static int kimage_normal_alloc(struct kimage **rimage, unsigned long entry,
+				unsigned long nr_segments,
+				struct kexec_segment __user *segments)
+{
+	int result;
+	struct kimage *image;
+
+	/* Allocate and initialize a controlling structure */
+	image = NULL;
+	result = do_kimage_alloc(&image, entry, nr_segments, segments);
+	if (!result)
+		result = kimage_common_alloc(image);
+
 	if (result == 0)
 		*rimage = image;
 	else
@@ -287,20 +289,7 @@ static int kimage_crash_alloc(struct kim
 			goto out;
 	}
 
-	/*
-	 * Find a location for the control code buffer, and add
-	 * the vector of segments so that it's pages will also be
-	 * counted as destination pages.
-	 */
-	result = -ENOMEM;
-	image->control_code_page = kimage_alloc_control_pages(image,
-					   get_order(KEXEC_CONTROL_CODE_SIZE));
-	if (!image->control_code_page) {
-		printk(KERN_ERR "Could not allocate control_code_buffer\n");
-		goto out;
-	}
-
-	result = 0;
+	result = kimage_common_alloc(image);
 out:
 	if (result == 0)
 		*rimage = image;
