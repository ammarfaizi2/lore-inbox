Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTIYUkk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 16:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTIYUkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 16:40:40 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:60420 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261869AbTIYUkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 16:40:39 -0400
Subject: [PATCH] fix smc-mca cleanup breakage
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 25 Sep 2003 15:40:27 -0500
Message-Id: <1064522429.1781.21.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest set of smc-mca fixes broke the driver.  Apparently, it wasn't
realised that request_region() actually returns a pointer to the region
you're requesting if it can.  Without this fix, the smc-mca cannot
attach to any device.

James
===== drivers/net/smc-mca.c 1.11 vs edited =====
--- 1.11/drivers/net/smc-mca.c	Thu Sep  4 02:36:29 2003
+++ edited/drivers/net/smc-mca.c	Thu Sep 25 15:26:14 2003
@@ -269,9 +269,10 @@
 		goto err_unregister_netdev;
 	}
 
-	rc = request_region(ioaddr, ULTRA_IO_EXTENT, dev->name);
-	if (rc)
+	if (!request_region(ioaddr, ULTRA_IO_EXTENT, dev->name)) {
+		rc = -ENODEV;
 		goto err_unregister_netdev;
+	}
 
 	reg4 = inb(ioaddr + 4) & 0x7f;
 	outb(reg4, ioaddr + 4);


