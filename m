Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266091AbUAUTrK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 14:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266093AbUAUTrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 14:47:10 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:10393 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266091AbUAUTrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 14:47:05 -0500
Date: Wed, 21 Jan 2004 19:45:59 +0000
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Jakob Kemi <jakob.kemi@post.utfors.se>
Subject: Large stack allocation in w9966 driver.
Message-ID: <20040121194559.GB9162@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Jakob Kemi <jakob.kemi@post.utfors.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another large on-stack allocation. (This time around 2KB).

		Dave


diff -Nru a/drivers/media/video/w9966.c b/drivers/media/video/w9966.c
--- a/drivers/media/video/w9966.c	Wed Jan 21 19:10:44 2004
+++ b/drivers/media/video/w9966.c	Wed Jan 21 19:10:44 2004
@@ -875,6 +875,7 @@
 	unsigned char addr = 0xa0;	// ECP, read, CCD-transfer, 00000
 	unsigned char* dest = (unsigned char*)buf;
 	unsigned long dleft = count;
+	unsigned char *tbuf;
 	
 	// Why would anyone want more than this??
 	if (count > cam->width * cam->height * 2)
@@ -894,11 +895,14 @@
 		w9966_pdev_release(cam);
 		return -EFAULT;
 	}
-	
+
+	tbuf = kmalloc(W9966_RBUFFER, GFP_KERNEL);
+	if (tbuf == NULL)
+		return -ENOMEM;
+
 	while(dleft > 0)
 	{
 		unsigned long tsize = (dleft > W9966_RBUFFER) ? W9966_RBUFFER : dleft;
-		unsigned char tbuf[W9966_RBUFFER];
 	
 		if (parport_read(cam->pport, tbuf, tsize) < tsize) {
 			w9966_pdev_release(cam);
@@ -911,7 +915,8 @@
 		dest += tsize;
 		dleft -= tsize;
 	}
-	
+	kfree(tbuf);
+
 	w9966_wReg(cam, 0x01, 0x18);	// Disable capture
 	w9966_pdev_release(cam);
 
