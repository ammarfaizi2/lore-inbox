Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWEJC4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWEJC4n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWEJC4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:56:37 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:53053 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932426AbWEJC4Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:24 -0400
Date: Tue, 9 May 2006 19:56:03 -0700
Message-Id: <200605100256.k4A2u3lB031731@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: Seokmann.Ju@lsil.com, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] megaraid gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warning,

drivers/scsi/megaraid.c: In function ‘issue_scb’:
drivers/scsi/megaraid.c:1153: warning: passing argument 2 of ‘writel’ makes pointer from integer without a cast
drivers/scsi/megaraid.c: In function ‘issue_scb_block’:
drivers/scsi/megaraid.c:1216: warning: passing argument 2 of ‘writel’ makes pointer from integer without a cast
drivers/scsi/megaraid.c:1229: warning: passing argument 2 of ‘writel’ makes pointer from integer without a cast
drivers/scsi/megaraid.c:1231: warning: passing argument 1 of ‘readl’ makes pointer from integer without a cast
drivers/scsi/megaraid.c: In function ‘megaraid_isr_memmapped’:
drivers/scsi/megaraid.c:1361: warning: passing argument 1 of ‘readl’ makes pointer from integer without a cast
drivers/scsi/megaraid.c:1368: warning: passing argument 2 of ‘writel’ makes pointer from integer without a cast
drivers/scsi/megaraid.c:1387: warning: passing argument 2 of ‘writel’ makes pointer from integer without a cast
drivers/scsi/megaraid.c:1391: warning: passing argument 1 of ‘readl’ makes pointer from integer without a cast
drivers/scsi/megaraid.c: In function ‘megadev_ioctl’:
drivers/scsi/megaraid.c:3665: warning: ignoring return value of ‘copy_to_user’, declared with attribute warn_unused_result


Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/drivers/scsi/megaraid.c
===================================================================
--- linux-2.6.16.orig/drivers/scsi/megaraid.c
+++ linux-2.6.16/drivers/scsi/megaraid.c
@@ -73,10 +73,10 @@ static unsigned short int max_mbox_busy_
 module_param(max_mbox_busy_wait, ushort, 0);
 MODULE_PARM_DESC(max_mbox_busy_wait, "Maximum wait for mailbox in microseconds if busy (default=MBOX_BUSY_WAIT=10)");
 
-#define RDINDOOR(adapter)		readl((adapter)->base + 0x20)
-#define RDOUTDOOR(adapter)		readl((adapter)->base + 0x2C)
-#define WRINDOOR(adapter,value)		writel(value, (adapter)->base + 0x20)
-#define WROUTDOOR(adapter,value)	writel(value, (adapter)->base + 0x2C)
+#define RDINDOOR(adapter)		readl((void*)((adapter)->base + 0x20))
+#define RDOUTDOOR(adapter)		readl((void*)((adapter)->base + 0x2C))
+#define WRINDOOR(adapter,value)		writel(value, (void *)((adapter)->base + 0x20))
+#define WROUTDOOR(adapter,value)	writel(value, (void*)((adapter)->base + 0x2C))
 
 /*
  * Global variables
@@ -3662,8 +3662,9 @@ megadev_ioctl(struct inode *inode, struc
 			 * Send the request sense data also, irrespective of
 			 * whether the user has asked for it or not.
 			 */
-			copy_to_user(upthru->reqsensearea,
-					pthru->reqsensearea, 14);
+			if (copy_to_user(upthru->reqsensearea,
+					pthru->reqsensearea, 14))
+				return -EFAULT;
 
 freemem_and_return:
 			if( pthru->dataxferlen ) {
