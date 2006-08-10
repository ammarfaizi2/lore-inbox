Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161472AbWHJRHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161472AbWHJRHE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161465AbWHJRHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:07:01 -0400
Received: from mail0.lsil.com ([147.145.40.20]:48561 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1161467AbWHJRHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:07:00 -0400
Subject: [PATCH 1/1] scsi : megaraid_{mm, mbox} : irq data type fix
From: Seokmann Ju <sju@lsil.com>
To: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>
Cc: sju@lsil.com, ebiederm@xmission.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 10 Aug 2006 12:54:47 -0400
Message-Id: <1155228887.6698.7.camel@dhcp-65-957.se.lsil.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
X-OriginalArrivalTime: 10 Aug 2006 17:06:33.0192 (UTC) FILETIME=[549B3E80:01C6BC9F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes incorrect irq data type in the driver which led driver initialization failure in some cases.
The problem was reported by Eric @. Biederman <ebiederm@xmission.com>.

Signed-off-by: Seokmann Ju <seokmann.ju@lsil.com>
---
diff -Naur old/Documentation/scsi/ChangeLog.megaraid new/Documentation/scsi/ChangeLog.megaraid
--- old/Documentation/scsi/ChangeLog.megaraid	2006-08-08 15:52:49.000000000 -0400
+++ new/Documentation/scsi/ChangeLog.megaraid	2006-08-09 08:39:18.000000000 -0400
@@ -1,5 +1,5 @@
 Release Date	: Fri May 19 09:31:45 EST 2006 - Seokmann Ju <sju@lsil.com>
-Current Version : 2.20.4.9 (scsi module), 2.20.2.6 (cmm module)
+Current Version : 2.20.4.9 (scsi module), 2.20.2.7 (cmm module)
 Older Version	: 2.20.4.8 (scsi module), 2.20.2.6 (cmm module)
 
 1.	Fixed a bug in megaraid_init_mbox().
@@ -121,6 +121,23 @@
 	> **************************************************************
 	> ****************
 
+4.	Incorrect data type has been used for 'irq' variable in the driver
+	as pointed out by Eric below.
+
+	> Sent: Monday, August 07, 2006 11:29 AM
+	> Subject: [PATCH] megaraid: Use the proper type to hold the irq number.
+	> 
+	> When testing on a Unisys machine it was discovered that
+	> the megaraid driver would not initialize as it was
+	> requesting irq 162 instead of irq 1442 it was assigned.
+	> The problem was the irq number had been truncated by being
+	> stored in an unsigned char.
+	> 
+	> The ioctl interface appears fundamentally broken as it exports
+	> the irq number to user space in an unsigned char. 
+	> 
+	> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
+
 Release Date	: Mon Apr 11 12:27:22 EST 2006 - Seokmann Ju <sju@lsil.com>
 Current Version : 2.20.4.8 (scsi module), 2.20.2.6 (cmm module)
 Older Version	: 2.20.4.7 (scsi module), 2.20.2.6 (cmm module)
diff -Naur old/drivers/scsi/megaraid/mega_common.h new/drivers/scsi/megaraid/mega_common.h
--- old/drivers/scsi/megaraid/mega_common.h	2006-08-08 15:53:44.000000000 -0400
+++ new/drivers/scsi/megaraid/mega_common.h	2006-08-08 15:56:03.000000000 -0400
@@ -175,7 +175,7 @@
 	uint8_t			max_lun;
 
 	uint32_t		unique_id;
-	uint8_t			irq;
+	unsigned int		irq;
 	uint8_t			ito;
 	caddr_t			ibuf;
 	dma_addr_t		ibuf_dma_h;
diff -Naur old/drivers/scsi/megaraid/megaraid_ioctl.h new/drivers/scsi/megaraid/megaraid_ioctl.h
--- old/drivers/scsi/megaraid/megaraid_ioctl.h	2006-08-08 15:53:44.000000000 -0400
+++ new/drivers/scsi/megaraid/megaraid_ioctl.h	2006-08-08 15:56:41.000000000 -0400
@@ -183,7 +183,7 @@
 	uint8_t		pci_bus;
 	uint8_t		pci_dev_fn;
 	uint8_t		pci_slot;
-	uint8_t		irq;
+	unsigned int	irq;
 
 	uint32_t	unique_id;
 	uint32_t	host_no;
@@ -209,7 +209,7 @@
 typedef struct mcontroller {
 
 	uint64_t	base;
-	uint8_t		irq;
+	unsigned int	irq;
 	uint8_t		numldrv;
 	uint8_t		pcibus;
 	uint16_t	pcidev;
---
