Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbTIVWeW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 18:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbTIVWeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 18:34:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:28115 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261399AbTIVWeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 18:34:20 -0400
Date: Mon, 22 Sep 2003 15:33:53 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] isp16 -- use request_region
Message-Id: <20030922153353.7eb19898.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change isp16 from check_region to request_region.

diff -Nru a/drivers/cdrom/isp16.c b/drivers/cdrom/isp16.c
--- a/drivers/cdrom/isp16.c	Mon Sep 22 15:33:46 2003
+++ b/drivers/cdrom/isp16.c	Mon Sep 22 15:33:46 2003
@@ -121,14 +121,14 @@
 		return (0);
 	}
 
-	if (check_region(ISP16_IO_BASE, ISP16_IO_SIZE)) {
+	if (!request_region(ISP16_IO_BASE, ISP16_IO_SIZE, "isp16")) {
 		printk("ISP16: i/o ports already in use.\n");
-		return (-EIO);
+		goto ret_eio;
 	}
 
 	if ((isp16_type = isp16_detect()) < 0) {
 		printk("ISP16: no cdrom interface found.\n");
-		return (-EIO);
+		goto err;
 	}
 
 	printk(KERN_INFO
@@ -148,20 +148,24 @@
 	else {
 		printk("ISP16: %s not supported by cdrom interface.\n",
 		       isp16_cdrom_type);
-		return (-EIO);
+		goto err;
 	}
 
 	if (isp16_cdi_config(isp16_cdrom_base, expected_drive,
 			     isp16_cdrom_irq, isp16_cdrom_dma) < 0) {
 		printk
 		    ("ISP16: cdrom interface has not been properly configured.\n");
-		return (-EIO);
+		goto err;
 	}
 	printk(KERN_INFO
 	       "ISP16: cdrom interface set up with io base 0x%03X, irq %d, dma %d,"
 	       " type %s.\n", isp16_cdrom_base, isp16_cdrom_irq,
 	       isp16_cdrom_dma, isp16_cdrom_type);
 	return (0);
+ err:
+	release_region(ISP16_IO_BASE, ISP16_IO_SIZE);
+ ret_eio:
+	return (-EIO);
 }
 
 static short __init isp16_detect(void)
