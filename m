Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTJFNLO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 09:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbTJFNLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 09:11:14 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:50370 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262041AbTJFNLL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 09:11:11 -0400
Message-ID: <3F816AB6.6020709@terra.com.br>
Date: Mon, 06 Oct 2003 10:14:30 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>, cgoos@syskonnect.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux@syskonnect.de
Subject: [PATCH] release region in skfddi driver
Content-Type: multipart/mixed;
 boundary="------------050105000606010901090809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050105000606010901090809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Jeff/Christoph,

	Patch against 2.6.0-test6.

	- Check the return value of request_region;

	- Only increment the global adapter value if request_region returned 
a valid pointer;

	- release_region if global adapter value > 0;

	Found by smatch.

	Please review and consider applying,

	Cheers.

Felipe

--------------050105000606010901090809
Content-Type: text/plain;
 name="skfddi-region.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="skfddi-region.patch"

--- linux-2.6.0-test6/drivers/net/skfp/skfddi.c.orig	2003-10-06 09:47:16.000000000 -0300
+++ linux-2.6.0-test6/drivers/net/skfp/skfddi.c	2003-10-06 10:03:14.000000000 -0300
@@ -394,11 +394,15 @@
 			skb_queue_head_init(&smc->os.SendSkbQueue);
 
 			if (skfp_driver_init(dev) == 0) {
+				if (!request_region(dev->base_addr,
+					       FP_IO_LEN, dev->name)){
+					kfree (dev);
+					return -EBUSY;
+				}
+
 				// only increment global board 
 				// count on success
 				num_boards++;
-				request_region(dev->base_addr,
-					       FP_IO_LEN, dev->name);
 				if ((SubSysId & 0xff00) == 0x5500 ||
 					(SubSysId & 0xff00) == 0x5800) {
 				printk("%s: SysKonnect FDDI PCI adapter"
@@ -411,11 +415,8 @@
 			} else {
 				kfree(dev);
 				i = SKFP_MAX_NUM_BOARDS;	// stop search
-
 			}
-
 		}		// if (dev != NULL)
-
 	}			// for SKFP_MAX_NUM_BOARDS
 
 	/*
@@ -427,6 +428,7 @@
 	if (num_boards > 0)
 		return (0);
 	else {
+		release_region (dev->base_addr, FP_IO_LEN);
 		printk("no SysKonnect FDDI adapter found\n");
 		return (-ENODEV);
 	}

--------------050105000606010901090809--

