Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTFZUPJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 16:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbTFZUPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 16:15:08 -0400
Received: from air-2.osdl.org ([65.172.181.6]:30428 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262497AbTFZUOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 16:14:30 -0400
Date: Thu, 26 Jun 2003 13:28:32 -0700
From: Bob Miller <rem@osdl.org>
To: alan@redhat.com, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.73] Remove racy check_mem_region() call from arc-rimi.c
Message-ID: <20030626202832.GF16162@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed the check_mem_region() call and replaced with request_mem_region().
Because of the way the driver is structured the first request_mem_region()
call gets the default memory area.  After probing the complete memory
area that is needed to communicate with the device is known, so the first
memory area is released and the complete area is requested.

--
Bob Miller                                      Email: rem@osdl.org
Open Source Development Lab                     Phone: 503.626.2455 Ext. 17

diff -Nru a/drivers/net/arcnet/arc-rimi.c b/drivers/net/arcnet/arc-rimi.c
--- a/drivers/net/arcnet/arc-rimi.c	Wed Jun 25 16:18:27 2003
+++ b/drivers/net/arcnet/arc-rimi.c	Wed Jun 25 16:18:27 2003
@@ -86,6 +86,8 @@
  */
 static int __init arcrimi_probe(struct net_device *dev)
 {
+	int retval;
+
 	BUGLVL(D_NORMAL) printk(VERSION);
 	BUGLVL(D_NORMAL) printk("E-mail me if you actually test the RIM I driver, please!\n");
 
@@ -97,16 +99,27 @@
 		       "must specify the shmem and irq!\n");
 		return -ENODEV;
 	}
-	if (check_mem_region(dev->mem_start, BUFFER_SIZE)) {
+	/*
+	 * Grab the memory region at mem_start for BUFFER_SIZE bytes.
+	 * Later in arcrimi_found() the real size will be determined
+	 * and this reserve will be released and the correct size
+	 * will be taken.
+	 */
+	if (!request_mem_region(dev->mem_start, BUFFER_SIZE, "arcnet (90xx)")) {
 		BUGMSG(D_NORMAL, "Card memory already allocated\n");
 		return -ENODEV;
 	}
 	if (dev->dev_addr[0] == 0) {
+		release_mem_region(dev->mem_start, BUFFER_SIZE);
 		BUGMSG(D_NORMAL, "You need to specify your card's station "
 		       "ID!\n");
 		return -ENODEV;
 	}
-	return arcrimi_found(dev);
+	retval = arcrimi_found(dev);
+	if (retval < 0) {
+		release_mem_region(dev->mem_start, BUFFER_SIZE);
+	}
+	return retval;
 }
 
 
@@ -182,8 +195,19 @@
 	/* get and check the station ID from offset 1 in shmem */
 	dev->dev_addr[0] = readb(lp->mem_start + 1);
 
-	/* reserve the memory region - guaranteed to work by check_region */
-	request_mem_region(dev->mem_start, dev->mem_end - dev->mem_start + 1, "arcnet (90xx)");
+	/*
+	 * re-reserve the memory region - arcrimi_probe() alloced this reqion
+	 * but didn't know the real size.  Free that region and then re-get
+	 * with the correct size.  There is a VERY slim chance this could
+	 * fail.
+	 */
+	release_mem_region(dev->mem_start, BUFFER_SIZE);
+	if (!request_mem_region(dev->mem_start,
+				dev->mem_end - dev->mem_start + 1,
+				"arcnet (90xx)")) {
+		BUGMSG(D_NORMAL, "Card memory already allocated\n");
+		goto err_free_dev_priv;
+	}
 
 	BUGMSG(D_NORMAL, "ARCnet RIM I: station %02Xh found at IRQ %d, "
 	       "ShMem %lXh (%ld*%d bytes).\n",
