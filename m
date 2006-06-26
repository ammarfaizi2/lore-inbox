Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933309AbWFZW6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933309AbWFZW6V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933307AbWFZW6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:58:20 -0400
Received: from mail.gmx.de ([213.165.64.21]:47807 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S933331AbWFZW5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:57:46 -0400
X-Authenticated: #704063
Subject: [Patch] Pointer dereference in drivers/usb/misc/usblcd
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: g.toth@e-biz.lu
Content-Type: text/plain
Date: Tue, 27 Jun 2006 00:57:42 +0200
Message-Id: <1151362662.15204.7.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

coverity spotted (id #185) that we still use urb, if the allocation
fails in the error path. This patch fixes this by returning directly.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-git11/drivers/usb/misc/usblcd.c.orig	2006-06-27 00:52:22.000000000 +0200
+++ linux-2.6.17-git11/drivers/usb/misc/usblcd.c	2006-06-27 00:52:39.000000000 +0200
@@ -200,10 +200,8 @@ static ssize_t lcd_write(struct file *fi
 
 	/* create a urb, and a buffer for it, and copy the data to the urb */
 	urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!urb) {
-		retval = -ENOMEM;
-		goto error;
-	}
+	if (!urb)
+		return -ENOMEM;
 	
 	buf = usb_buffer_alloc(dev->udev, count, GFP_KERNEL, &urb->transfer_dma);
 	if (!buf) {


