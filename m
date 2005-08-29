Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbVH2UZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbVH2UZc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 16:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVH2UZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 16:25:32 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:41230 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751100AbVH2UZb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 16:25:31 -0400
Message-Id: <200508292006.j7TK6ru5029910@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/9] UML - Error path cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Aug 2005 16:06:52 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This cleans up the error path in ubd_open, causing it now to call
ubd_close appropriately when something fails.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-rc6-mm1/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.13-rc6-mm1.orig/arch/um/drivers/ubd_kern.c	2005-08-29 11:51:22.000000000 -0400
+++ linux-2.6.13-rc6-mm1/arch/um/drivers/ubd_kern.c	2005-08-29 11:57:44.000000000 -0400
@@ -668,21 +668,22 @@
 	struct ubd *dev = &ubd_dev[n];
 	int err;
 
+	err = -ENODEV;
 	if(dev->file == NULL)
-		return(-ENODEV);
+		goto out;
 
 	if (ubd_open_dev(dev))
-		return(-ENODEV);
+		goto out;
 
 	err = ubd_file_size(dev, &dev->size);
 	if(err < 0)
-		return(err);
+		goto out_close;
 
 	dev->size = ROUND_BLOCK(dev->size);
 
 	err = ubd_new_disk(MAJOR_NR, dev->size, n, &ubd_gendisk[n]);
 	if(err) 
-		return(err);
+		goto out_close;
  
 	if(fake_major != MAJOR_NR)
 		ubd_new_disk(fake_major, dev->size, n, 
@@ -693,8 +694,11 @@
 	if (fake_ide)
 		make_ide_entries(ubd_gendisk[n]->disk_name);
 
+	err = 0;
+out_close:
 	ubd_close(dev);
-	return 0;
+out:
+	return err;
 }
 
 static int ubd_config(char *str)

