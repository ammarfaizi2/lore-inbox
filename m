Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUJEWOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUJEWOf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 18:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUJEWOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 18:14:35 -0400
Received: from mail.dif.dk ([193.138.115.101]:25305 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S264665AbUJEWOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 18:14:31 -0400
Date: Wed, 6 Oct 2004 00:21:58 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: "David A. Hinds" <dahinds@users.sourceforge.net>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>
Subject: [PATCH] check the return value of __copy_to_user in
 drivers/pcmcia/ds.c::ds_ioctl and return -EFAULT if it fails
Message-ID: <Pine.LNX.4.61.0410060012590.2913@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  CC      drivers/pcmcia/ds.o
include/asm/uaccess.h: In function `ds_ioctl':
drivers/pcmcia/ds.c:1049: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result

Patch adds a check of the return value and returns -EFAULT if 
__copy_to_user fails.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.9-rc3-bk5-orig/drivers/pcmcia/ds.c linux-2.6.9-rc3-bk5/drivers/pcmcia/ds.c
--- linux-2.6.9-rc3-bk5-orig/drivers/pcmcia/ds.c	2004-10-05 22:07:27.000000000 +0200
+++ linux-2.6.9-rc3-bk5/drivers/pcmcia/ds.c	2004-10-06 00:12:20.000000000 +0200
@@ -1046,7 +1046,11 @@ static int ds_ioctl(struct inode * inode
 	}
     }
 
-    if (cmd & IOC_OUT) __copy_to_user(uarg, (char *)&buf, size);
+    if (cmd & IOC_OUT) {
+        if (__copy_to_user(uarg, (char *)&buf, size))
+            err = -EFAULT;
+    }
+
 
     return err;
 } /* ds_ioctl */


