Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266036AbUAUUCy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 15:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266032AbUAUUCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 15:02:50 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:20377 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266028AbUAUUCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 15:02:45 -0500
Date: Wed, 21 Jan 2004 20:01:40 +0000
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Jakob Kemi <jakob.kemi@post.utfors.se>
Subject: Re: Large stack allocation in w9966 driver.
Message-ID: <20040121200140.GC9162@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Jakob Kemi <jakob.kemi@post.utfors.se>
References: <20040121194559.GB9162@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040121194559.GB9162@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 07:45:59PM +0000, Dave Jones wrote:
 > Another large on-stack allocation. (This time around 2KB).

Lets try again, without the leaks. (Thanks Joe).

		Dave

--- bk-linus/drivers/media/video/w9966.c	2003-09-29 20:04:12.000000000 +0100
+++ linux-2.5/drivers/media/video/w9966.c	2004-01-21 20:00:02.000000000 +0000
@@ -875,6 +875,7 @@
 	unsigned char addr = 0xa0;	// ECP, read, CCD-transfer, 00000
 	unsigned char* dest = (unsigned char*)buf;
 	unsigned long dleft = count;
+	unsigned char *tbuf;
 	
 	// Why would anyone want more than this??
 	if (count > cam->width * cam->height * 2)
@@ -894,25 +895,33 @@
 		w9966_pdev_release(cam);
 		return -EFAULT;
 	}
-	
+
+	tbuf = kmalloc(W9966_RBUFFER, GFP_KERNEL);
+	if (tbuf == NULL) {
+		count = -ENOMEM;
+		goto out;
+	}
+
 	while(dleft > 0)
 	{
 		unsigned long tsize = (dleft > W9966_RBUFFER) ? W9966_RBUFFER : dleft;
-		unsigned char tbuf[W9966_RBUFFER];
 	
 		if (parport_read(cam->pport, tbuf, tsize) < tsize) {
-			w9966_pdev_release(cam);
-			return -EFAULT;
+			count = -EFAULT;
+			goto out;
 		}
 		if (copy_to_user(dest, tbuf, tsize) != 0) {
-			w9966_pdev_release(cam);
-			return -EFAULT;
+			count = -EFAULT;
+			goto out;
 		}
 		dest += tsize;
 		dleft -= tsize;
 	}
-	
+
 	w9966_wReg(cam, 0x01, 0x18);	// Disable capture
+
+out:
+	kfree(tbuf);
 	w9966_pdev_release(cam);
 
 	return count;
