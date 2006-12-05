Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937181AbWLEC1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937181AbWLEC1I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 21:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937204AbWLEC1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 21:27:07 -0500
Received: from smtp-out.google.com ([216.239.33.17]:52542 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937181AbWLEC1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 21:27:04 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:content-type;
	b=tl0v+UnZ5A3jyLCkPik52wmBJrII1kFYN19/cwWMGpxyvoKPkJSBNe+U4OX8qhoMN
	g9C0SxCIdKbCRWJEkvU6A==
Message-ID: <4574D8EB.1060104@google.com>
Date: Mon, 04 Dec 2006 18:26:51 -0800
From: Martin Bligh <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix up compiler warnings in megaraid driver
Content-Type: multipart/mixed;
 boundary="------------070003050505010103090705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070003050505010103090705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix up compiler warnings in megaraid driver

Signed-off-by: Martin J. Bligh <mbligh@google.com>


--------------070003050505010103090705
Content-Type: text/plain;
 name="2.6.19-megaraid"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.19-megaraid"

diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.19/drivers/scsi/megaraid.c 2.6.19-megaraid/drivers/scsi/megaraid.c
--- linux-2.6.19/drivers/scsi/megaraid.c	2006-12-04 17:52:00.000000000 -0800
+++ 2.6.19-megaraid/drivers/scsi/megaraid.c	2006-12-04 18:24:03.000000000 -0800
@@ -73,10 +73,14 @@ static unsigned short int max_mbox_busy_
 module_param(max_mbox_busy_wait, ushort, 0);
 MODULE_PARM_DESC(max_mbox_busy_wait, "Maximum wait for mailbox in microseconds if busy (default=MBOX_BUSY_WAIT=10)");
 
-#define RDINDOOR(adapter)		readl((adapter)->base + 0x20)
-#define RDOUTDOOR(adapter)		readl((adapter)->base + 0x2C)
-#define WRINDOOR(adapter,value)		writel(value, (adapter)->base + 0x20)
-#define WROUTDOOR(adapter,value)	writel(value, (adapter)->base + 0x2C)
+#define RDINDOOR(adapter)		readl((volatile void __iomem *) \
+							(adapter)->base + 0x20)
+#define RDOUTDOOR(adapter)		readl((volatile void __iomem *) \
+							(adapter)->base + 0x2C)
+#define WRINDOOR(adapter,value)		writel(value, (volatile void __iomem *)\
+							(adapter)->base + 0x20)
+#define WROUTDOOR(adapter,value)	writel(value, (volatile void __iomem *)\
+							(adapter)->base + 0x2C)
 
 /*
  * Global variables
@@ -3566,7 +3570,7 @@ megadev_ioctl(struct inode *inode, struc
 			/*
 			 * The user passthru structure
 			 */
-			upthru = (mega_passthru __user *)MBOX(uioc)->xferaddr;
+			upthru = (mega_passthru __user *)(unsigned long)MBOX(uioc)->xferaddr;
 
 			/*
 			 * Copy in the user passthru here.
@@ -3618,7 +3622,7 @@ megadev_ioctl(struct inode *inode, struc
 				/*
 				 * Get the user data
 				 */
-				if( copy_from_user(data, (char __user *)uxferaddr,
+				if( copy_from_user(data, (char __user *)(unsigned long) uxferaddr,
 							pthru->dataxferlen) ) {
 					rval = (-EFAULT);
 					goto freemem_and_return;
@@ -3644,7 +3648,7 @@ megadev_ioctl(struct inode *inode, struc
 			 * Is data going up-stream
 			 */
 			if( pthru->dataxferlen && (uioc.flags & UIOC_RD) ) {
-				if( copy_to_user((char __user *)uxferaddr, data,
+				if( copy_to_user((char __user *)(unsigned long) uxferaddr, data,
 							pthru->dataxferlen) ) {
 					rval = (-EFAULT);
 				}
@@ -3697,7 +3701,7 @@ freemem_and_return:
 				/*
 				 * Get the user data
 				 */
-				if( copy_from_user(data, (char __user *)uxferaddr,
+				if( copy_from_user(data, (char __user *)(unsigned long) uxferaddr,
 							uioc.xferlen) ) {
 
 					pci_free_consistent(pdev,
@@ -3737,7 +3741,7 @@ freemem_and_return:
 			 * Is data going up-stream
 			 */
 			if( uioc.xferlen && (uioc.flags & UIOC_RD) ) {
-				if( copy_to_user((char __user *)uxferaddr, data,
+				if( copy_to_user((char __user *)(unsigned long) uxferaddr, data,
 							uioc.xferlen) ) {
 
 					rval = (-EFAULT);

--------------070003050505010103090705--
