Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbWAWX3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbWAWX3c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 18:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWAWX3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 18:29:32 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:64643 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S1030207AbWAWX3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 18:29:32 -0500
Message-ID: <43D566E0.50504@shadowconnect.com>
Date: Tue, 24 Jan 2006 00:29:36 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] I2O: fix and workaround for Motorola/Freescale controller
Content-Type: multipart/mixed;
 boundary="------------090502010600030905030309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090502010600030905030309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes:
--------
- This controller violates the I2O spec for the I/O registers. The patch
   contains a workaround which moves the registers to the proper location.
   (originally author: Matthew Starzewski)
- If a message frame is beyond the mapped address range a error is
   returned.

Signed-off-by: Markus Lidel <Markus.Lidel@shadowconnect.com>

--------------090502010600030905030309
Content-Type: text/x-patch;
 name="i2o-pci-motorola-freescale-workaround.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o-pci-motorola-freescale-workaround.patch"

--- a/drivers/message/i2o/pci.c	2006-01-23 23:41:42.031509195 +0100
+++ b/drivers/message/i2o/pci.c	2006-01-23 01:03:51.236440918 +0100
@@ -163,6 +168,24 @@
 	c->in_port = c->base.virt + I2O_IN_PORT;
 	c->out_port = c->base.virt + I2O_OUT_PORT;
 
+	/* Motorola/Freescale chip does not follow spec */
+	if (pdev->vendor == PCI_VENDOR_ID_MOTOROLA && pdev->device == 0x18c0) {
+		/* Check if CPU is enabled */
+		if (be32_to_cpu(readl(c->base.virt + 0x10000)) & 0x10000000) {
+			printk(KERN_INFO "%s: MPC82XX needs CPU running to "
+			       "service I2O.\n", c->name);
+			i2o_pci_free(c);
+			return -ENODEV;
+		} else {
+			c->irq_status += I2O_MOTOROLA_PORT_OFFSET;
+			c->irq_mask += I2O_MOTOROLA_PORT_OFFSET;
+			c->in_port += I2O_MOTOROLA_PORT_OFFSET;
+			c->out_port += I2O_MOTOROLA_PORT_OFFSET;
+			printk(KERN_INFO "%s: MPC82XX workarounds activated.\n",
+			       c->name);
+		}
+	}
+
 	if (i2o_dma_alloc(dev, &c->status, 8, GFP_KERNEL)) {
 		i2o_pci_free(c);
 		return -ENOMEM;
--- a/include/linux/i2o.h	2006-01-23 23:42:06.360729954 +0100
+++ b/include/linux/i2o.h	2006-01-23 00:58:44.288144650 +0100
@@ -1115,9 +1115,11 @@
 		return ERR_PTR(-ENOMEM);
 
 	mmsg->mfa = readl(c->in_port);
-	if (mmsg->mfa == I2O_QUEUE_EMPTY) {
+	if (unlikely(mmsg->mfa >= c->in_queue.len)) {
 		mempool_free(mmsg, c->in_msg.mempool);
-		return ERR_PTR(-EBUSY);
+		if(mmsg->mfa == I2O_QUEUE_EMPTY)
+			return ERR_PTR(-EBUSY);
+		return ERR_PTR(-EFAULT);
 	}
 
 	return &mmsg->msg;
--- a/drivers/message/i2o/core.h	2006-01-23 23:41:41.995507388 +0100
+++ b/drivers/message/i2o/core.h	2006-01-23 01:04:57.811975471 +0100
@@ -60,4 +60,7 @@
 #define I2O_IN_PORT	0x40
 #define I2O_OUT_PORT	0x44
 
+/* Motorola/Freescale specific register offset */
+#define I2O_MOTOROLA_PORT_OFFSET	0x10400
+
 #define I2O_IRQ_OUTBOUND_POST	0x00000008

--------------090502010600030905030309--
